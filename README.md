# FXServer

FXServer allows you to run a server for either GTA5 or RDR2. I was looking for a convenient way to run a server for GTA5 but couldn't find any good solutions, so I decided to take a stab at it myself. This repo does a nightly build of the latest version of FXServer and pushes it to docker hub under "lilthrasher/fxserver:latest"

## How to use this container image

1. Before you start the container for the first time you will have to create a docker volume called "mariadb-fxserver".

2. When you first run the container, the container logs will include the PIN necessary for txAdmin to link your Cfx.re account.

3. After linking your account, txAdmin will ask for you to setup a backup password in case you cannot authenticate with Cfx.re.

4. Once you get to the step that asks for your server registration key you will need to make changes to the database configuration.

5. Enter "mariadb-fxserver" for the database host, and enter the database root password you have set, after changing those two settings you should be able to run your recipe.

6. After checking your server config you can start your server.