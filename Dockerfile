# ==========================================
# STAGE 1: The Build Environment (Heavyweight)
# ==========================================
# Replace 'node:20-alpine' with 'rust:1.75-alpine' or 'golang:1.22-alpine' later if needed.
FROM node:20-alpine AS builder
WORKDIR /app

# Install basic compiler tools required by many Web3/Ecosystem dependencies
RUN apk add --no-cache python3 make g++ git

# Copy your dependency maps first to maximize Docker caching speed
COPY package*.json ./ 
RUN npm ci

# Copy the rest of your project files and compile
COPY . .
RUN npm run build

# ==========================================
# STAGE 2: The Production Runtime (Minimal & Secure)
# ==========================================
FROM alpine:3.19 AS runtime
WORKDIR /aura-service

# Install just the runtime execution layer
RUN apk add --no-cache nodejs

# Bring over ONLY the compiled code from the builder stage
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
RUN npm prune --production

# Expose your service port (Adjust as necessary)
EXPOSE 3000

# Inject your exact environment tags directly into the container metadata
ENV ECOSYSTEM="AURA" \
    LAYER="S4X" \
    BUILD_VERSION="V.FADK"

# Execute your app
CMD ["node", "dist/index.js"]
