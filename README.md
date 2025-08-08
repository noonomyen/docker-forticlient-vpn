# docker-openfortivpn

A [openfortivpn](https://github.com/adrienverge/openfortivpn) setup running inside Docker with SOCKS5 proxy (via `dante-server`), and full network access via network namespace tools.

---

## Usage

### 1. Edit config files

- `openfortivpn.conf`: Set VPN host, username, and password.
- `sockd.conf`: Usually no changes are needed.

### 2. Build and run the container

```bash
docker-compose up --build
```

### 3. Connect and use

You can either:

Use the SOCKS5 proxy on port 1080, or

Run commands inside the container’s network namespace using the netns.sh script:

```sh
./netns.sh ifconfig
```
