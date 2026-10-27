# coelho.wiki

Personal project to share a bit about me.

## Stack

The frontend is a standalone Angular SPA in TypeScript, using RxJS and HttpClient to consume the API, with a single home route, in-page section scroll (Experience, Projects, Contact), and SCSS layouts. The backend is a Ruby on Rails API-only app with PostgreSQL, rack-cors for cross-origin Angular requests, and jsonapi-serializer for JSON:API responses, organized around controllers, models, services, and serializers under a versioned `/api/v1` surface.

## Structure

The project root splits into `frontend/` and `backend/`. Inside `frontend/src/app/`, `core/` holds HTTP services, models, and interceptors, `features/` covers the Home shell plus Projects, Experience, and Contact sections, and `shared/` keeps reusable UI pieces. In development the API is `http://localhost:3000/api/v1`; in production the SPA calls same-origin `/api/v1` via Nginx. Static assets live under `frontend/public/`. The `backend/` app follows a clean Rails layout under `app/` (`controllers/api/v1/`, `models/`, `services/`, `serializers/`), plus `db/migrate` and `db/seeds.rb`.