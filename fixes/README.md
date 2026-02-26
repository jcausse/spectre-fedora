# Fixes

* [Touchpad Palm Rejection](#palm-rejection)
* [WiFi ]

## Palm Rejection

Thanks to `aigilea` (see [this repo](https://github.com/aigilea/hp_spectre_x360_14_eu0xxx)).

Download `palm-rejection.service`, then open a terminal where the file was downloaded and run:

```bash
sudo cp palm-rejection.service /etc/systemd/system && \
sudo systemctl enable palm-rejection.service && \
sudo systemctl start palm-rejection.service
```
