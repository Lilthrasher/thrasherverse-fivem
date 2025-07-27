# FXServer

FXServer allows you to run a FiveM server for either GTA5 or RDR2. I was looking for a convenient way to run a server for GTA5 but couldn't find any good solutions, so I decided to take a stab at it myself. This repo should do a nightly build of the latest version of FXServer and push it to docker hub under "lilthrasher/fxserver:latest"

## How to use this container image

I have provided an example docker compose file with everything needed to get a server running.

The container provides a mount point at "/opt/fxserver/txData" which gives you access to the necessary folders to add mods on the server.

This image uses txAdmin for setup and control which allows you to run recipies and install server frameworks during initial setup.

txAdmin should be reachable at port 40120.