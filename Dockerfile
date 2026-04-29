# ── Stage 1: Builder ──────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

# Install ALL dependencies (including devDependencies)
RUN npm install

# ── Stage 2: Final image ──────────────────────────────────────────
FROM node:20-alpine

WORKDIR /app

# Install pm2 globally
RUN npm install -g pm2

# Copy only node_modules from builder stage
COPY --from=builder /app/node_modules ./node_modules

# Copy source code and config
COPY src ./src
COPY package.json ./
COPY ecosystem.config.js ./

EXPOSE 3000

CMD ["pm2-runtime", "start", "ecosystem.config.js"]