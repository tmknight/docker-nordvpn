FROM ubuntu:22.04
LABEL org.opencontainers.image.source=https://github.com/tmknight/docker-nordvpn
LABEL org.opencontainers.image.description="NordVPN for Docker"
LABEL org.opencontainers.image.licenses=GPL
LABEL autoheal=true
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
  && apt-get install -y -qq \
  curl \
  iputils-ping \
  libc6 \
  ## only if desired to obtain the private key
  # wireguard \
  && curl -s https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb --output /tmp/nordrepo.deb \
  && apt-get install -y -qq \
  /tmp/nordrepo.deb \
  && apt-get update -qq \
  && apt-get install -y -qq \
  nordvpn \
  && apt-get remove -y -qq nordvpn-release \
  && apt-get autoremove -y -qq \
  && apt-get clean -y -qq \
  && rm -rf \
  /tmp/* \
  /var/cache/apt/archives/* \
  /var/lib/apt/lists/* \
  /var/tmp/* \
  && mkdir -p /run/nordvpn
COPY ./nordvpn_start.sh /usr/bin/start
COPY ./scripts/ /usr/local/bin/
## Expose Privoxy traffic
EXPOSE 8118
HEALTHCHECK --start-period=10s --timeout=3s \
  CMD nordvpn status | grep -Ei "Status: Connected" || exit 1
CMD start
