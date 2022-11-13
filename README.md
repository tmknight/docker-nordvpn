# docker-nordvpn
NordVPN for Docker

Scripts based on the excellent work of https://github.com/bubuntux/nordvpn

Build based on:

`Ubuntu 22.04`

`NordVPN v3.15.0`

# ENVIRONMENT VARIABLES

* `USER`     - User for NordVPN account.
* `PASS`     - Password for NordVPN account, surrounding the password in single quotes will prevent issues with special characters such as `$`.
* `TOKEN`     - Used in place of `USER` and `PASS` for NordVPN account, can be generated in your NordVPN account web portal
* `PASSFILE` - File from which to get `PASS`, if using [docker secrets](https://docs.docker.com/compose/compose-file/compose-file-v3/#secrets) this should be set to `/run/secrets/<secret_name>`. This file should contain just the account password on the first line.
* `CONNECT`  -  [country]/[server]/[country_code]/[city]/[group] or [country] [city], if none provide you will connect to  the recommended server.
   - Provide a [country] argument to connect to a specific country. For example: Australia , Use `docker run --rm ghcr.io/tmknight/nordvpn nordvpn countries` to get the list of countries.
   - Provide a [server] argument to connect to a specific server. For example: jp35 , [Full List](https://nordvpn.com/servers/tools/)
   - Provide a [country_code] argument to connect to a specific country. For example: us 
   - Provide a [city] argument to connect to a specific city. For example: 'Hungary Budapest' , Use `docker run --rm ghcr.io/tmknight/nordvpn nordvpn cities [country]` to get the list of cities. 
   - Provide a [group] argument to connect to a specific servers group. For example: P2P , Use `docker run --rm ghcr.io/tmknight/nordvpn nordvpn groups` to get the full list.
   - --group value  Specify a server group to connect to. For example: '--group p2p us'
* `PRE_CONNECT` - Command to execute before attempt to connect.
* `POST_CONNECT` - Command to execute after successful connection.
* `CYBER_SEC`  - Enable or Disable. When enabled, the CyberSec feature will automatically block suspicious websites so that no malware or other cyber threats can infect your device. Additionally, no flashy ads will come into your sight. More information on how it works: https://nordvpn.com/features/cybersec/.
* `DNS` -   Can set up to 3 DNS servers. For example 1.1.1.1,8.8.8.8 or Disable, Setting DNS disables CyberSec.
* `FIREWALL`  - Enable or Disable.
* `OBFUSCATE`  - Enable or Disable. When enabled, this feature allows to bypass network traffic sensors which aim to detect usage of the protocol and log, throttle or block it (only valid when using OpenVpn).
* `PROTOCOL`   - TCP or UDP (only valid when using OpenVPN).
* `TECHNOLOGY` - Specify Technology to use (NordLynx by default): 
   * OpenVPN    - Traditional connection.
   * NordLynx   - NordVpn wireguard implementation (3x-5x times faster than OpenVPN).
* `ALLOW_LIST` - List of domains that are going to be accessible _outside_ vpn (IE rarbg.to,yts.mx).
* `NET_LOCAL`  - CIDR networks (IE 192.168.1.0/24), add a route to allows replies once the VPN is up.
* `NET6_LOCAL` - CIDR IPv6 networks (IE fe00:d34d:b33f::/64), add a route to allows replies once the VPN is up.
* `PORTS`  - Semicolon delimited list of ports to whitelist for both UDP and TCP. For example '- PORTS=9091;9095'
* `PORT_RANGE`  - Port range to whitelist for both UDP and TCP. For example '- PORT_RANGE=9091 9095'
* `CHECK_CONNECTION_INTERVAL`  - Time in seconds to check connection and reconnect if need it. (300 by default) For example '- CHECK_CONNECTION_INTERVAL=600'
* `CHECK_CONNECTION_URL`  - URL for checking Internet connection. (www.google.com by default) For example '- CHECK_CONNECTION_URL=www.custom.domain'
