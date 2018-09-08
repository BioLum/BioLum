# BioLum
Wearable, mesh-networked lighting project for Raspberry Pi

Currently, we're using [resin.io](resin.io) to assist in deploys for development.

## Local development

1. Install the resin cli: `npm install resin-cli -g --production --unsafe-perm`.
2. Use `sudo resin local scan` to find the host (for example: `f340127.local`)
3. Run `./gradlew jar` to build the jarfile.
4. From the project directory, push code to the host: `sudo resin local push f340127.local -s .`.

Reference: https://docs.resin.io/learn/develop/local-mode/.