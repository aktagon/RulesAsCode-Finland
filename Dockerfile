FROM swipl:stable

RUN apt-get update \
    && apt-get install -y --no-install-recommends git ca-certificates make gcc libc6-dev \
    && rm -rf /var/lib/apt/lists/*

RUN swipl -g "pack_install(scasp, [interactive(false)])" -t halt

WORKDIR /app
COPY . .

ENTRYPOINT ["swipl"]
