# FXServer

FXServer allows you to run a server for either GTA5 or RDR2. I was looking for a convenient way to run a server for GTA5 but couldn't find any good solutions, so I decided to take a stab at it myself. This repo should do a nightly build of the latest version of FXServer and push it to docker hub under "lilthrasher/fxserver:latest"

## How to use this container image

When you first run the container, the container logs will include the PIN necessary for txAdmin to link your Cfx.re account.

After linking your account, txAdmin will ask for you to setup a backup password in case you cannot authenticate with Cfx.re.

Select the options you would like during the first 5 steps of setup, however I recommend you don't change the Data Location during step 4 because "/opt/fxserver/txData" is the location of the container volume mount and changing this will make you unable to access the folders required to add or change mods.

Once you get to the "Input Parameters" step, you need to change the advanced database options to connect to the mariadb service running in a seperate container.

If you are using the docker compose file provided you should be able to enter "mariadb-fxserver" for the database host, and enter the database root password you have set in your .env file, after changing those two settings you should be able to run your recipe.

After checking your server config you can start your server.