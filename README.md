# Homepage

Home Page is a modern, fully static, fast, secure fully proxied, highly customizable application dashboard with integrations for over 100 services and translations into multiple languages. Easily configured via YAML files or through docker label discovery.

gethomepage.dev

<img src="https://raw.githubusercontent.com/gethomepage/homepage/main/images/banner_light%402x.png" width="30%" height="auto" alt="Homepage logo">

## How to use this Makejail

### Standalone

```console
$ mkdir -p /var/appjail-volumes/homepage/config
$ appjail oci run -Pd \
    -o overwrite=force \
    -o virtualnet=":<random> default" \
    -o nat \
    -o fstab="/var/appjail-volumes/homepage/config /config" \
    -e PUID=1000 \
    -e PGID=1000 \
    -e HOMEPAGE_ALLOWED_HOSTS=homepage:3000 \
    ghcr.io/appjail-makejails/homepage homepage
```

### Deploy using `appjail-director`

```yaml
options:
  - virtualnet: ':<random> default'
  - nat:

services:
  homepage:
    name: homepage
    makejail: gh+AppJail-makejails/homepage
    oci:
      environment:
        - HOMEPAGE_ALLOWED_HOSTS: 'homepage:3000' # required. See gethomepage.dev/installation/#homepage_allowed_hosts
        - PUID: 1000 # optional, your user id
        - PGID: 1000 # optional, your group id
    options:
      - expose: '3000:3000'
      - container: 'args:--pull'
    volumes:
      - config: /config

volumes:
  config:
    device: /var/appjail-volumes/homepage/config
```

### Arguments (stage: build)

* `homepage_from` (default: `ghcr.io/appjail-makejails/homepage`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `homepage_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).

### Environment (OCI image)

* `PGID` (default: `1000`): Equivalent to `PUID` but for the Process Group ID.
* `PUID` (default: `1000`): Process User ID for the container's main process, allowing you to match the owner of files written to mounted host volumes to your host system's user. Writable volumes are changed based on this environment variable.

### Volumes

| Name | Owner | Group | Perm | Type | Mountpoint |
| --- | --- | --- | --- | --- | --- |
| appjail-3e723ade99-config | `${PUID}` | `${PGID}` | - | - | /config |

## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.1
      containerfile: Containerfile
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.1"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
```
