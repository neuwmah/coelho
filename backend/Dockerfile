FROM ruby:3.2.3-slim

RUN apt-get update -qq \
  && apt-get install --no-install-recommends -y build-essential libpq-dev curl \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /rails

ENV RAILS_ENV=production \
  BUNDLE_WITHOUT="development:test" \
  BUNDLE_DEPLOYMENT=1 \
  BUNDLE_PATH=/usr/local/bundle

COPY Gemfile Gemfile.lock ./
RUN bundle install \
  && rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

COPY . .

RUN chmod +x bin/docker-entrypoint bin/rails bin/rake \
  && mkdir -p tmp/pids log \
  && useradd --create-home --shell /bin/bash rails \
  && chown -R rails:rails /rails

USER rails

EXPOSE 3000

ENTRYPOINT ["./bin/docker-entrypoint"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb", "-b", "tcp://0.0.0.0:3000"]
