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

### Deploy using appjail-director

**appjail-director.yml**:

```yaml
options:
  - virtualnet: ':<random> default'
  - nat:

services:
  homepage:
    name: homepage
    makejail: gh+AppJail-makejails/homepage
    volumes:
      - config: /homepage/src/config

volumes:
  config:
    device: .volumes/config
```

**.env**:

```
DIRECTOR_PROJECT=homepage
```

### Arguments

* `homepage_tag` (default: `13.3`): See [#tags](#tags).

## Tags

| Tag    | Arch    | Version        | Type   | `homepage_version` |
| ------ | ------- | -------------- | ------ | ------------------ |
| `13.3` | `amd64` | `13.3-RELEASE` | `thin` | `0.9.6`            |
| `14.1` | `amd64` | `14.1-RELEASE` | `thin` | `0.9.6`            |