# Express + PostgreSQL + Docker

A minimal REST API to learn Docker with a real database.

## Project Structure

```
express-postgres-docker/
├── src/
│   └── index.js          ← Express app + all routes
├── Dockerfile            ← How to build the API image
├── docker-compose.yml    ← Runs API + Postgres together
├── .dockerignore         ← Files to exclude from image
└── package.json
```

## How to Run

```bash
# 1. Start everything (builds image + starts both containers)
docker compose up --build

# 2. Run in background (detached mode)
docker compose up --build -d

# 3. Stop everything
docker compose down

# 4. Stop AND delete the database volume (fresh start)
docker compose down -v
```

## Test the API

```bash
# Health check
curl http://10.1.27.156:3000/health

# Create a user
curl -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d '{"name": "Madhan", "email": "madhan@example.com"}'

# Get all users
curl http://localhost:3000/users

# Get user by ID
curl http://localhost:3000/users/1

# Delete a user
curl -X DELETE http://localhost:3000/users/1
```

## Connect to Postgres directly (optional)

```bash
# Open psql shell inside the running DB container
docker exec -it postgres_db psql -U postgres -d appdb

# Useful SQL commands inside psql
\dt                        -- list tables
SELECT * FROM users;       -- view all users
\q                         -- quit
```

## Key Concepts Demonstrated

- `Dockerfile` — builds the Node.js app into an image
- `docker-compose.yml` — runs api + db as two linked services
- `DB_HOST: db` — containers talk to each other by service name, not localhost
- `depends_on + healthcheck` — api waits for Postgres to be ready
- `volumes` — database data persists even after containers restart
- `.dockerignore` — keeps node_modules out of the image
