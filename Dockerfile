# syntax=docker/dockerfile:1
#
# RETIRED: transitional pass-through proxy only.
# The Kwang-Lim Chapel portal is served entirely by chapel-backend. This image exists
# so an existing Dokploy application keeps forwarding traffic until its domain is
# moved to the chapel-backend application. See README.md.

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY offline.html /usr/share/nginx/html/offline.html
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://127.0.0.1:80/healthz || exit 1

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
