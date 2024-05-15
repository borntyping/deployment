# TODO

- https://tailscale.com/kb/1019/subnets?tab=linux#enable-ip-forwarding
- https://tailscale.com/kb/1320/performance-best-practices#ethtool-configuration

```shell
sudo cp /etc/pki/tls/private/razz-berry.bunny-moth.ts.net.crt /home/src/.local/state/syncthing/https-cert.pem
sudo cp /etc/pki/tls/private/razz-berry.bunny-moth.ts.net.key /home/src/.local/state/syncthing/https-key.pem
sudo chown src:src /home/src/.local/state/syncthing/https-cert.pem /home/src/.local/state/syncthing/https-key.pem
```
