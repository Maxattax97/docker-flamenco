FROM debian:bookworm-slim

ENV FLAMENCO_VERSION=3.5
ENV FLAMENCO_URL=https://flamenco.blender.org/downloads/flamenco-$FLAMENCO_VERSION-linux-amd64.tar.gz

WORKDIR /app

# Curl basically never changes.
# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app /config /data \
    && curl "$FLAMENCO_URL" -o /app/flamenco.tar.gz

RUN tar -xf flamenco.tar.gz --strip-components=1 \
    && rm -f /app/flamenco.tar.gz \
    && chmod +x /app/flamenco-manager \
    && ln -s /app/flamenco-manager.yaml /config/flamenco-manager.yaml

COPY entrypoint.sh /app/entrypoint.sh
COPY flamenco-manager.yaml /config/flamenco-manager.yaml

WORKDIR /app

CMD [ "/app/flamenco-manager" ]
EXPOSE 8080
