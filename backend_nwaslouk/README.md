# backend_nwaslouk

Node + Express + MongoDB backend for Nwaslouk authentication.

## Run locally

1. Copy env

```bash
cp .env.example .env
```

2. Install deps

```bash
npm install
```

3. Start server

```bash
npm run dev
```

Server runs at http://localhost:4000

## Endpoints

- POST `/auth/sign-up` -> body: `{ email, password, confirmPassword?, name?, phone?, location?, isDriver? }` response: `{ token }`
- POST `/auth/sign-in` -> body: `{ email, password }` or `{ phone, password }` response: `{ token }`
- POST `/auth/logout` -> response: `{ success: true }`

MongoDB: `mongodb://localhost:27017/nwasloukDB`