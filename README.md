## Systemd service package for Skyweather2

### Writing a systemd Service for SkyWeather2


The SkyWeather2 system from SwitchDocLabs is a great project that allows makers to set up and monitor weather related information in their local environment.

To manage the necessary software on the Raspberry Pi, SkyWeather2 documentation outlines the use of the rc.local file to start up the skyweather and dashboard apps each time the RPi is rebooted.

Many modern Linux distributions use a software suite [systemd] to manage the system's services at startup (or *daemons*), for example to automatically start certain services in the correct order when the system boots. This is replacing the rc.local method in newer systems.

Aside from this `README.md` file, this GitHub repository contains a basic
implementation for systemd, consisting of 2 Python scripts
and 2 systemd unit files to help manage the SkyWeather2 and dash software.

These files, when installed, will provide a systemd implementation to startup and manage both the SkyWeather2 server and the dash dashboard server.

These services provide the added bonus that if the SkyWeather2 or dashboard services shutdown unexpectedly, systemd will try to restart them.

NOTE: These instructions assume that the file directories and files are the same as the ones on the SwitchDocLabs SDCard. These will set up the SkyWeather2 service for the main software package, and you can repeat this to setup the dashboard component. If you are using a different setup, you could modify the scrips accordingly.

To setup systemd service for the main SkyWeather2 application, you'll use the following files:

- skyweather2.service
- skyweather2exec.sh

These need to be copied from wherever you downloaded them to the appropriate directories on the SwitchDocLabs Pi.


Note: if you have already set up the rc.local startup from the setup guide, "SkyWeather2ConfigurationAndOperationsManual1.2.pdf" page 9, you need to comment out those changes out prior to this setup.


### To set up the main SkyWeather2 service:

ssh into your SkyWeather2 Raspberry Pi and change to the services directory. We are putting these the system directory versus the "user" directory as they need to be run as superuser (su). You may need to use the sudo command to get access to the required directories.

```
cd /etc/systemd/system

```

copy the ".service" file:

```
sudo cp /yourdownloadlocation/skyweather2.service /etc/systemd/system
```
and then do a

```
ls -la
```
to check that the file copied correctly.

Next, copy the .sh file into the /home/pi/bin directory.
if the /bin directory does not exist, create it with

```
mkdir /home/pi/bin
```

and copy the skyweather2exec.sh file there...

```
sudo cp /yourdownloadlocation/skyweather2exec.sh /home/pi/bin
```

Check that it was copied correctly.

You may need to make the .sh files executable.

```
sudo chmod +x skyweather2exec.sh
```

Tell the systemd daemon to reload the systemd service files to include the new service we just added. This is a key step to ensure that systemd knows that this service has been added.

```
sudo systemctl daemon-reload
```

Next, enable the service to launch on every reboot. This is very useful as you will scratch your head alot wondering why the service doesn't start up again when you reboot if you don't issue this command. This is done using the systemctl enable command...

```
sudo systemctl enable skyweather2
```

Start your service by telling the systemd to attempt to start the server. A output file that may provide useful for debugging will be created called "SDL_Pi_skyweather2.out".

```
sudo systemctl start skyweather2
```

To check the status of your service, see how long it's been running and get other information related to your server:

```
sudo systemctl status skyweather2
```

The output should look like this:
```
pi@SwitchDocLabs:/var/log $ systemctl status skyweather2
??? skyweather2.service - skyweather2 service
   Loaded: loaded (/etc/systemd/system/skyweather2.service; enabled; vendor preset: enabled)
   Active: active (running) since Mon 2022-01-31 14:56:38 EST; 24s ago
 Main PID: 1346 (skyweather2exec)
    Tasks: 21 (limit: 4915)
   CGroup: /system.slice/skyweather2.service
           ??????1346 /bin/bash /home/pi/bin/skyweather2exec.sh
           ??????1347 /usr/bin/python3 /home/pi/SDL_Pi_SkyWeather2/SkyWeather2.py
           ??????1369 /usr/bin/pigpiod
           ??????1385 /usr/local/bin/rtl_433 -q -F json -R 146 -R 147 -R 148 -R 150 -R 151 -R 152

Jan 31 14:56:38 SwitchDocLabs systemd[1]: Started skyweather2 service.
```


If you want to disable your service so that it is NOT started when the system reboots, use this command. This comes in useful when you need to do a upgrade or the program is getting into an loop:

```
sudo systemctl disable skyweather2
```

## Where to go from here

This will give you a service that you can use to manage the SkyWeather2 server and that will startup the service at boot and keep it running.

You can repeat the steps for the dash server with the provided Files by repeating the same steps. There is a .service file and a .sh file for the dashboard component in the GitHib repository.

You can look up more information about systemd at [www.systemd.io](https://www.systemd.io)

And of course, if you find an error in this package or have an comment or suggestions for changes, feel free to create an issue or a pull request.

Happy coding!
