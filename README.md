![DockerPublishing](https://github.com/tmknight/docker-nordvpn/actions/workflows/docker-publish.yml/badge.svg)
# docker-nordvpn
NordVPN client for Docker

Leveraging the native NordVPN client and iptables to create the fastest, most stable connection possible.

Scripts based on the excellent work of https://github.com/bubuntux/nordvpn

Build based on:

`Ubuntu 22.04`

`NordVPN 3.15.2`

# ENVIRONMENT VARIABLES

* `TOKEN` - RECOMMENDED and used in place of `USER` and `PASS` for NordVPN account
   -  Generated from your NordVPN account web portal
* `USER` - User for NordVPN account
   - Not required when using `TOKEN`
* `PASS` - Password for NordVPN account, surrounding the password in single quotes will prevent issues with special characters such as `$`.
   - Not required when using `TOKEN` or `PASSFILE`
* `PASSFILE` - File from which to get `PASS`
   - If using [docker secrets](https://docs.docker.com/compose/compose-file/compose-file-v3/#secrets) this should be set to `/run/secrets/<secret_name>`
   - This file should contain just the account password on the first line.
* `CONNECT` - [country]/[server]/[country_code]/[city]/[group] or [country] [city], if none provide you will connect to  the recommended server.
   - Provide a [country] argument to connect to a specific country. For example: Australia , Use `docker run --rm ghcr.io/tmknight/nordvpn nordvpn countries` to get the list of countries.
   - Provide a [server] argument to connect to a specific server
      - Example `CONNECT=jp35`
      - [Full List](https://nordvpn.com/servers/tools/)
   - Provide a [country_code] argument to connect to a specific country
      - Example `CONNECT=us`
   - Provide a [city] argument to connect to a specific city
      - Example `CONNECT=Hungary Budapest`
      - Use `docker run --rm ghcr.io/tmknight/nordvpn nordvpn cities [country]` to get the list of cities
   - Provide a [group] argument to connect to a specific servers group
      - Example `CONNECT=P2P`
      - Use `docker run --rm ghcr.io/tmknight/nordvpn nordvpn groups` to get the full list
      - `--group` value  Specify a server group to connect to
         - Example `--group p2p us`
* `PRE_CONNECT` - Command to execute before attempt to connect
* `POST_CONNECT` - Command to execute after successful connection
* `CYBER_SEC` - Enable or Disable (default = Disable)
   -  When enabled, the CyberSec feature will automatically block suspicious websites so that no malware or other cyber threats can infect your device
   - Additionally, no flashy ads will come into your sight
   - More information on how it works: https://nordvpn.com/features/cybersec/
* `DNS` - Up to 3 DNS servers or Disable (Setting DNS disables CyberSec; default = NordVPN DNS servers)
   - Example `1.1.1.1,8.8.8.8`
* `FIREWALL` - Enable or Disable (default = Enable)
* `OBFUSCATE` - Enable or Disable (default = Disable)
   - When enabled, this feature allows to bypass network traffic sensors which aim to detect usage of the protocol and log, throttle or block it (only valid when using OpenVpn)
* `TECHNOLOGY` - Specify Technology to use (default = NordLynx)
   * OpenVPN - Traditional connection.
   * NordLynx - NordVpn wireguard implementation (3x-5x times faster than OpenVPN)
* `PROTOCOL` - TCP or UDP (only valid when using OpenVPN Technology; default = UDP)
* `ALLOW_LIST` - Comma delimited list of domains that are going to be accessible _outside_ vpn
   - Example `ALLOW_LIST=somesite.ch,anothersite.au`
* `NET_LOCAL` - Add a route to local IPv4 network once the VPN is up
   - CIDR IPv4 networks: `192.168.1.0/24`
* `NET6_LOCAL` - Add a route to local IPv6 network once the VPN is up
   - CIDR IPv6 networks `fe00:d34d:b33f::/64`
* `PORTS` - Semicolon delimited list of ports to whitelist for both UDP and TCP
   - Example `- PORTS=9091;9095`
* `PORT_RANGE` - Port range to whitelist for both UDP and TCP
   - Example `- PORT_RANGE=9091 9095`
* `CHECK_CONNECTION_INTERVAL` - Time in seconds to check connection and reconnect if need it. (default = 60)
   - Example `- CHECK_CONNECTION_INTERVAL=300`
* `CHECK_CONNECTION_URL` - URL for checking Internet connection. (default = https://www.google.com)
   - Example `- CHECK_CONNECTION_URL=www.custom.domain`
* `REFRESH_CONNECTION_INTERVAL` - Time in minutes to trigger VPN reconnection to help ensure best connection available (default = 120; disable = 0)
   - Example `- REFRESH_CONNECTION_INTERVAL=240`
