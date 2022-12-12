<!-- markdownlint-disable MD041 -->
[![GitHubPackage][GitHubPackageBadge]][GitHubLink]
[![DockerPublishing][DockerPublishingBadge]][DockerLink]
[![DockerSize][DockerSizeBadge]][DockerLink]
[![DockerPulls][DockerPullsBadge]][DockerLink]

# NordVPN client for Docker

Leveraging the native NordVPN client and iptables to create the fastest, most stable connection possible.

# The Essentials

Build based on:

- Ubuntu `22.04`
- NordVPN `3.15.2`

Examples of use:

- [nordvpn_proxy.yml](https://github.com/tmknight/docker-nordvpn/blob/main/nordvpn_proxy.yml)

Docker Hub repository:

- <https://hub.docker.com/repository/docker/tmknight88/nordvpn>

# Requirements

Add [capabilities](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities):

- NET_ADMIN

Environment variables:

- TOKEN (or USER & PASS/PASSFILE)
- NET_LOCAL (technically not required for the container to work, but it should be set if local traffic is to be routed through VPN)

# Recommendations

IPv6 support is limited and generally [not supported](https://nordvpn.com/blog/ipv4-vs-ipv6/#:~:text=You%20might%20be%20wondering%20what,tunnel%20with%20the%20IPv4%20protocol.) by most VPN providers at this time. - ` Therefore, it is recommended to disable IPv6 support in your container via [sysctl](https://docs.docker.com/engine/reference/commandline/run/#configure-namespaced-kernel-parameters-sysctls-at-runtime):

`net.ipv6.conf.all.disable_ipv6=1`

# Environment Variables

Generally, the default settings will provide a great experience, however, several environment variables are available to provide flexibility:

| Variable                        | Default                  | Description                                                                                                                                                                                                                                              |
|:-------------------------------:|:------------------------:|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **BYPASS_LIST**                 |                          | Comma-separated list of domain names that should bypass VPN (i.e. these connections should not be secured); `FIREWALL` must be FALSE                                                                                                                     |
| **CHECK_CONNECTION_INTERVAL**   | 60                       | Time in seconds to check connection and reconnect as required                                                                                                                                                                                            |
| **CHECK_CONNECTION_URL**        | <https://www.google.com> | URL used by `CHECK_CONNECTION_INTERVAL`                                                                                                                                                                                                                  |
| **CONNECT**                     |                          | [country]/[server]/[country_code]/[city]/[group] or [country] [city] (leave unset to connect to the recommended server; use [NordVPN API](https://github.com/tmknight/docker-nordvpn#additional-information) to get the list of countries, cities, etc.) |
| **CYBER_SEC**                   | FALSE                    | Learn more at [NordVPN](https://nordvpn.com/features/cybersec/) (TRUE/FALSE)                                                                                                                                                                             |
| **DNS**                         |                          | A comma-separated list of IPv4/IPv6 addresses to be set as the interface's DNS servers, or non-IP hostnames to be set as the interface's DNS search domains (leave unset to use NordVPN servers)                                                         |
| **FIREWALL**                    | TRUE                     | Use the NordVPN firewall over iptables (TRUE/FALSE; Must be set to FALSE in order to use `BYPASS_LIST`)                                                                                                                                                  |
| **KILLSWITCH**                  | TRUE                     | Use the NordVPN kill switch; `FIREWALL` must also be TRUE (TRUE/FALSE)                                                                                                                                                                                   |
| **NET_LOCAL**                   |                          | Add a route to local IPv4 network once the VPN is up; the Docker network is automatically added; must be CIDR IPv4 format (e.g. `192.168.1.0/24`)                                                                                                        |
| **NET6_LOCAL**                  |                          | Add a route to local IPv4 network once the VPN is up; the Docker network is automatically added; must be CIDR IPv6 format (e.g. `fe00:d34d:b33f::/64`)                                                                                                   |
| **OBFUSCATE**                   | FALSE                    | Only valid when using TECHNOLOGY OpenVPN; learn more at [NordVPN](https://nordvpn.com/features/obfuscated-servers/) (TRUE/FALSE)                                                                                                                         |
| **PASS**                        |                          | Password for NordVPN account; surround in single quotes to prevent issues with special characters such as `$` (not required when using `TOKEN` or `PASSFILE`)                                                                                            |
| **PASSFILE**                    |                          | For use with `USER` and [docker secrets](https://docs.docker.com/compose/compose-file/compose-file-v3/#secrets), this should be set to `/run/secrets/<secret_name>`; this file should contain just the account password on the first line                |
| **PORT_RANGE**                  |                          | Port range to whitelist for both UDP and TCP; (e.g. `PORT_RANGE=9091 9095`)                                                                                                                                                                              |
| **PORTS**                       |                          | Semicolon delimited list of ports to whitelist for both UDP and TCP; (e.g `PORTS=9091;9095`)                                                                                                                                                             |
| **POST_CONNECT**                |                          | Command to execute after successful connection                                                                                                                                                                                                           |
| **PRE_CONNECT**                 |                          | Command to execute before attempt to connect                                                                                                                                                                                                             |
| **PROTOCOL**                    | UDP                      | Only valid when using TECHNOLOGY OpenVPN (TCP/UDP)                                                                                                                                                                                                       |
| **REFRESH_CONNECTION_INTERVAL** | 120                      | Time in minutes to trigger VPN reconnection to help ensure best connection available                                                                                                                                                                     |
| **TECHNOLOGY**                  | NordLynx                 | Specify Technology to use (NordLynx/OpenVPN)                                                                                                                                                                                                             |
| **TOKEN**                       |                          | **RECOMMENDED**; use in place of `USER` and `PASS` for NordVPN account; generated from your NordVPN account web portal                                                                                                                                   |
| **USER**                        |                          | User for NordVPN account (not required when using `TOKEN`)                                                                                                                                                                                               |

# Additional Information

Using the NordVPN API:

- <https://sleeplessbeastie.eu/2019/02/18/how-to-use-public-nordvpn-api/>

# Credits

Scripts based on the excellent work of <https://github.com/bubuntux/nordvpn>

# Disclaimers

This project is independently developed for personal use; there is no affiliation with NordVPN or Nord Security companies.  Nord Security companies are not responsible for, nor have control over, the nature, content and availability of this project.

[GitHubPackageBadge]: https://github.com/tmknight/docker-nordvpn/actions/workflows/github-package.yml/badge.svg
[GitHubLink]: https://github.com/tmknight/docker-nordvpn
[DockerPublishingBadge]: https://github.com/tmknight/docker-nordvpn/actions/workflows/docker-publish.yml/badge.svg
[DockerPullsBadge]: https://badgen.net/docker/pulls/tmknight88/nordvpn?icon=docker&label=Docker+Pulls&labelColor=black&color=green
[DockerSizeBadge]: https://badgen.net/docker/size/tmknight88/nordvpn?icon=docker&label=Docker+Size&labelColor=black&color=green
[DockerLink]: https://hub.docker.com/r/tmknight88/nordvpn
