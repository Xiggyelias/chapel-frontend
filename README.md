# chapel-frontend (retired)

**This repository is no longer part of the Kwang-Lim Chapel portal.**

The portal is a server-rendered Laravel application: every page, script, stylesheet and PWA file is built and served by **[chapel-backend](https://github.com/Xiggyelias/chapel-backend)**, which deploys as a single Dokploy application. This repository only ever ran an nginx reverse proxy in front of it; its copies of the views and assets were never executed.

## What is left here
A minimal pass-through proxy (`Dockerfile`, `nginx.conf`, `entrypoint.sh`, `offline.html`) so an existing Dokploy application built from this repository keeps working during the cutover. It forwards every request to `BACKEND_URL`.

## Cutover steps
1. In Dokploy, open the **chapel-backend** application and attach the public domain to it (HTTPS on).
2. Confirm the portal loads from that domain.
3. Stop and delete the **chapel-frontend** application in Dokploy.
4. Archive or delete this repository (GitHub → Settings → Danger Zone).

The full application history of the old frontend copies remains in this repository's git history.
