ARG UBUNTU_VER
FROM ubuntu:${UBUNTU_VER}
ARG UBUNTU_VER
ARG NORDVPN_VERSION
ARG TARGETARCH
LABEL org.opencontainers.image.base.name="ubuntu:${UBUNTU_VER}"
LABEL org.opencontainers.image.description DESCRIPTION
LABEL org.opencontainers.image.licenses=GPL-3.0
LABEL org.opencontainers.image.source=https://github.com/tmknight/docker-nordvpn
LABEL org.opencontainers.image.title=nordvpn
LABEL autoheal=true
ENV CHECK_CONNECTION_INTERVAL=60 \
  CHECK_CONNECTION_URL="https://www.google.com" \
  CONNECT="" \
  CONNECTION_FILTERS="" \
  REFRESH_CONNECTION_INTERVAL=120 \
  TECHNOLOGY=NordLynx
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq \
  && apt-get upgrade -y -qq \
  && apt-get install -y -qq \
  iptables \
  curl \
  iputils-ping \
  libc6 \
  dnsutils \
  jq \
  ## only if desired to obtain the private key
  # wireguard \
  && curl -so /tmp/nordrepo.deb https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb \
  && apt-get install -y -qq \
  /tmp/nordrepo.deb \
  && apt-get update -qq \
  && apt-get install -y -qq \
  nordvpn=${NORDVPN_VERSION} \
  && apt-get remove -y -qq nordvpn-release \
  && apt-get autoremove -y -qq \
  && apt-get clean -y -qq \
  && rm -rf \
  /tmp/* \
  /var/cache/apt/archives/* \
  /var/lib/apt/lists/* \
  /var/tmp/* \
  && mkdir -p /run/nordvpn
COPY ./scripts/ /usr/local/bin/
COPY ./opt/ /opt/
RUN chmod -R +x \
  /usr/local/bin/ \
  && if [ "${TARGETARCH}" = "amd64" ]; then /usr/local/bin/iptables-wrapper-installer.sh; fi
## Expose Privoxy traffic
EXPOSE 8118
HEALTHCHECK --start-period=10s --timeout=3s \
  CMD /usr/local/bin/nord_healthcheck
CMD /usr/local/bin/nord_start
