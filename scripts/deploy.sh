#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

SETUP=0
if [[ "${1:-}" == "--setup" ]]; then
  SETUP=1
fi

if [[ ! -f .env ]]; then
  echo "Missing .env (copy from .env.example)" >&2
  exit 1
fi

get_env() {
  local key="$1"
  local line
  line="$(grep -E "^${key}=" .env | tail -n1 || true)"
  printf '%s' "${line#*=}"
}

DEPLOY_HOST="$(get_env DEPLOY_HOST)"
DEPLOY_PATH="$(get_env DEPLOY_PATH)"
POSTGRES_PASSWORD="$(get_env POSTGRES_PASSWORD)"
SECRET_KEY_BASE="$(get_env SECRET_KEY_BASE)"

if [[ -z "$DEPLOY_PATH" ]]; then
  DEPLOY_PATH="/opt/coelho"
fi

if [[ -z "$DEPLOY_HOST" || "$DEPLOY_HOST" == *"SEU_IP"* ]]; then
  echo "Set DEPLOY_HOST in .env (e.g. root@203.0.113.10)" >&2
  exit 1
fi

if [[ -z "$POSTGRES_PASSWORD" ]]; then
  echo "Set POSTGRES_PASSWORD in .env" >&2
  exit 1
fi

if [[ ${#SECRET_KEY_BASE} -lt 32 ]]; then
  echo "Set SECRET_KEY_BASE in .env (openssl rand -hex 64)" >&2
  exit 1
fi

echo "→ Target: ${DEPLOY_HOST}:${DEPLOY_PATH}"

ARCHIVE="$(mktemp /tmp/coelho-deploy.XXXXXX.tgz)"
cleanup() { rm -f "$ARCHIVE"; }
trap cleanup EXIT

echo "→ Packaging..."
tar -czf "$ARCHIVE" \
  --exclude='.git' \
  --exclude='frontend/node_modules' \
  --exclude='frontend/dist' \
  --exclude='frontend/.angular' \
  --exclude='frontend/coverage' \
  --exclude='backend/.bundle' \
  --exclude='backend/vendor/bundle' \
  --exclude='backend/log' \
  --exclude='backend/tmp' \
  --exclude='backend/storage' \
  --exclude='backend/public/assets' \
  --exclude='*.log' \
  -C "$ROOT" .

REMOTE_TMP="/tmp/coelho-deploy.tgz"
echo "→ Uploading..."
scp "$ARCHIVE" "${DEPLOY_HOST}:${REMOTE_TMP}"

REMOTE_SCRIPT=$(cat <<EOF
set -euo pipefail
mkdir -p '$DEPLOY_PATH'
tar -xzf '$REMOTE_TMP' -C '$DEPLOY_PATH'
rm -f '$REMOTE_TMP'
cd '$DEPLOY_PATH'
docker compose up -d --build
EOF
)

if [[ "$SETUP" -eq 1 ]]; then
  REMOTE_SCRIPT+=$'\n'
  REMOTE_SCRIPT+="docker compose exec -T api bundle exec rails db:prepare"$'\n'
  REMOTE_SCRIPT+="docker compose exec -T api bundle exec rails db:seed"$'\n'
  REMOTE_SCRIPT+="echo 'Setup OK: prepare/seed done.'"
fi

echo "→ Building on VPS..."
ssh "$DEPLOY_HOST" "bash -s" <<<"$REMOTE_SCRIPT"

echo
echo "Deploy OK. Check http://coelho.wiki"
if [[ "$SETUP" -eq 1 ]]; then
  echo "First run: seed applied. HTTPS later — see DEPLOY.md"
fi
