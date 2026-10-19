# Kwang-Lim Chapel - Frontend Client
**Africa University Chaplaincy Office &bull; Mutare, Zimbabwe**

Standalone frontend client and UI asset service for the Kwang-Lim Chapel Management Portal. Dokploy ready with multi-stage Docker build and production Nginx server.

---

## 🚀 Features

- **Tailwind CSS v4 & Plus Jakarta Sans**: AU Crimson (`#DC2626`), Slate (`#0F172A`), and Gold (`#D4AF37`) color palette.
- **Top Navigation Bar**: Horizontal header layout with official UMC Cross & Flame branding, active route pills, and dropdown navigation.
- **Accessibility & Inclusion (WCAG AAA)**: High-contrast mode, +12% enlarged typography scaling, and dynamic English / ChiShona language switcher.
- **PWA Ready**: Offline caching, service worker (`sw.js`), web manifest, and custom app icons.
- **Dokploy Ready**: Native `dokploy.json`, multi-stage `Dockerfile`, and `docker-compose.yml` with `/healthz` healthchecks.

---

## 📁 Directory Structure

```text
frontend/
├── assets/                  # UMC Cross & Flame logo, favicon, PWA manifest, service worker
│   ├── umc-logo.svg         # Official United Methodist insignia
│   ├── favicon.svg          # High-resolution SVG favicon
│   ├── manifest.json        # PWA application manifest
│   ├── sw.js                # Service Worker for offline caching
│   └── offline.html         # Low-bandwidth offline fallback page
├── css/                     # Tailwind CSS v4 styling & color definitions
│   └── app.css              # Africa University styling rules
├── js/                      # Modular JavaScript
│   ├── app.js               # Client entry point
│   ├── bootstrap.js         # Axios & CSRF HTTP interceptors
│   └── modules/             # UI interaction modules
│       ├── command-palette.js # Quick Command Palette (Ctrl + K)
│       └── accessibility.js # High Contrast & Shona language toggle
├── views/                   # Server-rendered Blade views & UI components
├── nginx.conf               # Production Nginx reverse proxy & static file server
├── Dockerfile               # Multi-stage Docker build (Node.js -> Nginx Alpine)
├── docker-compose.yml       # Dokploy compose deployment specification
├── dokploy.json             # Dokploy application configuration
├── package.json             # Frontend dependency manifest
└── vite.config.js           # Vite bundle configuration
```

---

## 🐳 Dokploy Deployment Guide

### Option 1: Deploy via Dokploy GUI (GitHub Repository)
1. In Dokploy, click **Create Application**.
2. Select **GitHub** and connect your frontend repository (`kwanglim-chapel-frontend`).
3. Set **Build Type**: `Dockerfile`.
4. Set **Port**: `80`.
5. Set **Health Check Path**: `/healthz`.
6. Add Environment Variable:
   ```env
   BACKEND_URL=http://backend:80
   ```
7. Click **Deploy**.

### Option 2: Deploy via Docker Compose
1. In Dokploy, click **Create Compose**.
2. Paste the contents of `docker-compose.yml`.
3. Click **Deploy**.

---

## 🛠️ Local Development

```bash
# Install dependencies
npm install

# Start Vite development server
npm run dev

# Build production assets
npm run build
```

---

## 📦 GitHub Repository Setup

To push this frontend service to GitHub:

```bash
cd frontend
git init -b main
git add .
git commit -m "feat: complete Dokploy-ready frontend client for Kwang-Lim Chapel"
git remote add origin https://github.com/<YOUR-GITHUB-USERNAME>/kwanglim-chapel-frontend.git
git push -u origin main
```
