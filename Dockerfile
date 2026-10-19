# syntax=docker/dockerfile:1

# ==========================================
# Stage 1: Build Frontend Assets
# ==========================================
FROM node:22-alpine AS build

WORKDIR /app

COPY package.json ./
# Install dependencies
RUN npm install --prefer-offline --no-audit

COPY . .

# Run build if script exists
RUN npm run build || true

# ==========================================
# Stage 2: Production Nginx Server
# ==========================================
FROM nginx:alpine AS runtime

LABEL maintainer="Africa University Kwang-Lim Chapel"
LABEL description="Dokploy Ready Frontend Client for Kwang-Lim Chapel Portal"

# Copy custom Nginx web server config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy frontend source and static assets
COPY --from=build /app/assets /usr/share/nginx/html/assets
COPY --from=build /app/css /usr/share/nginx/html/css
COPY --from=build /app/js /usr/share/nginx/html/js
COPY --from=build /app/views /usr/share/nginx/html/views
COPY --from=build /app/assets/favicon.svg /usr/share/nginx/html/favicon.svg
COPY --from=build /app/assets/umc-logo.svg /usr/share/nginx/html/umc-logo.svg
COPY --from=build /app/assets/sw.js /usr/share/nginx/html/sw.js
COPY --from=build /app/assets/manifest.json /usr/share/nginx/html/manifest.json
COPY --from=build /app/assets/offline.html /usr/share/nginx/html/offline.html
COPY --from=build /app/assets/offline.html /usr/share/nginx/html/index.html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://127.0.0.1:80/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
