# Homepage

Homepage is a modern, fully static, fast, secure fully proxied, highly customizable application dashboard with integrations for over 100 services and translations into multiple languages. Easily configured via YAML files or through docker label discovery.

gethomepage.dev

<img src="https://raw.githubusercontent.com/gethomepage/homepage/main/images/banner_light%402x.png" width="60%" height="auto">

## How to use this Makejail

### Standalone

```sh
appjail makejail \
    -j homepage \
    -f gh+AppJail-makejails/homepage \
    -o virtualnet=":<random> default" \
    -o nat \
    -o expose=3000
```

### Arguments

* `homepage_tag` (default: `14.3`): See [#tags](#tags).
* `homepage_ajspec` (default: `gh+AppJail-makejails/homepage`): Entry point where the `appjail-ajspec(5)` file is located.
#
### Volumes

| Name            | Owner | Group | Perm | Type | Mountpoint                      |
| --------------- | ----- | ----- | ---- | ---- | ------------------------------- |
| homepage-config | 0     | 0     |  -   |  -   | /usr/local/www/homepage/config  |

## Tags

| Tag        | Arch    | Version            | Type   |
| ---------- | ------- | ------------------ | ------ |
| `14.3` | `amd64` | `14.3-RELEASE` | `thin` |
| `15` | `amd64` | `15` | `thin` |
