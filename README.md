![GitHubPackage](https://github.com/tmknight/docker-nordvpn/actions/workflows/github-package.yml/badge.svg)
![DockerPublishing](https://github.com/tmknight/docker-nordvpn/actions/workflows/docker-publish.yml/badge.svg)
![DockerPulls](https://badgen.net/docker/pulls/tmknight88/nordvpn?icon=docker&label=Docker+Image+Pulls&labelColor=black&color=green)
# NordVPN client for Docker

Leveraging the native NordVPN client and iptables to create the fastest, most stable connection possible.

# The Essentials

Build based on:
- Ubuntu `22.04`
- NordVPN `3.15.2`

Docker Hub repository:
- https://hub.docker.com/repository/docker/tmknight88/nordvpn

Examples:
- [nordvpn_proxy.yml](https://github.com/tmknight/docker-nordvpn/blob/main/nordvpn_proxy.yml)

# Requirements
Add capabilities:
- NET_ADMIN

# Environment Variables

* `TOKEN` - RECOMMENDED and used in place of `USER` and `PASS` for NordVPN account
   -  Generated from your NordVPN account web portal
* `USER` - User for NordVPN account
   - Not required when using `TOKEN`
* `PASS` - Password for NordVPN account
   - Surround in single quotes to prevent issues with special characters such as `$`.
   - Not required when using `TOKEN` or `PASSFILE`
* `PASSFILE` - File from which to get `PASS`
   - If using [docker secrets](https://docs.docker.com/compose/compose-file/compose-file-v3/#secrets), this should be set to `/run/secrets/<secret_name>`
   - This file should contain just the account password on the first line.
* `CONNECT` - [country]/[server]/[country_code]/[city]/[group] or [country] [city] (default = connect to  the recommended server).
   - Use [NordVPN API](https://github.com/tmknight/docker-nordvpn/edit/main/README.md#additional-information) to get the list of countries, cities, etc.
   - Provide a [country] argument to connect to a specific country
      - Example `CONNECT=Australia`
   - Provide a [server] argument to connect to a specific server
      - Example `CONNECT=jp35`
   - Provide a [country_code] argument to connect to a specific country
      - Example `CONNECT=us`
   - Provide a [city] argument to connect to a specific city
      - Example `CONNECT=Hungary Budapest`
   - Provide a [group] argument to connect to a specific servers group
      - Example `CONNECT=P2P`
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
   - Example `ALLOW_LIST=somesite.com,anothersite.net`
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

# Additional Information

Using the NordVPN API:
  - https://sleeplessbeastie.eu/2019/02/18/how-to-use-public-nordvpn-api/

# Credits

Scripts based on the excellent work of https://github.com/bubuntux/nordvpn
