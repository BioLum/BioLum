# BioLum
Wearable, mesh-networked lighting project for Raspberry Pi

Currently, we're using [resin.io](resin.io) to assist in deploys for development.

## Local development

### Bluetooth workaround

So, first off, tinyb depends on Bluetooth GATT support being enabled, which is an experimental feature.
resin.io currently doesn't run bluetoothd with the `--experimental` flag on the host. There is a workaround, though.

First, get a shell on the host and kill the current bluetoothd process.
```
root@e4991fa:~# ps | grep bluetooth
  706 root      5612 S    /usr/libexec/bluetooth/bluetoothd -
```

```
root@e4991fa:~# kill 706
```

Next, run bluetoothd with the `--experimental` flag.
```
root@e4991fa:~# /usr/libexec/bluetooth/bluetoothd --experimenl &
[1] 4610
```

In your app's container image, point DBUS at the correct path:
```
export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket
```

Now, tinyb should work fine.

Adding support for the `--experimental` flag is on the resin.io team's roadmap, see
https://forums.resin.io/t/rpi3-running-bluetoothd-with-experimental-flag/2566/23.

### Resin local mode

1. Install the resin cli: `npm install resin-cli -g --production --unsafe-perm`.
2. Use `sudo resin local scan` to find the host (for example: `f340127.local`)
3. Run `./gradlew jar` to build the jarfile.
4. From the project directory, push code to the host: `sudo resin local push f340127.local -s .`.

Reference: https://docs.resin.io/learn/develop/local-mode/.

# Useful links

- Setting up bluez and tinyb: http://fam-haugk.de/starting-with-bluetooth-le-on-the-raspberry-pi