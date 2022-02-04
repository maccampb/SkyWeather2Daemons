## **Systemd service package for Skyweather2**

## Writing a systemd Service for SkyWeather2##

SkyWeather2 (SKW2) from SwitchDocLabs is a great project that allows makers to set up and monitor weather informtatoin in their local environment.

SKW2 currently uses the rc.local file to start up the skyweather and dashboard apps when the system reboots.

There is another way.

Many modern Linux distributions use a software suite [systemd] to manage the system's services (or *daemons*), for example to automatically start certain services in the correct order when the system boots.

Aside from this `README.md` file, this repository contains a basic
implementation of a Python service consisting of 2 Python scripts
and 2 systemd unit files that, when installed, will provide a systemd implementation for both the SkyWeather2 server and the dash dashboard server.

These services provide the added bonus that if the SkyWeather2 or dashboard services shutdown unexpectedly, systemd will try to restart them.

To setup systemd for the main SkyWeather2 service, you'll use:

- skyweather2.service
- skyweather2exec.sh

files. These need to be copied from wherever you downloaded them to the appropriate directories on the SwitchDocLabs Pi.


Note: if you have already set up the rc.local startup from the setup guide, page xx, you need to comment out those changes out prior to this setup.


For example, to set up the main SkyWeather2 service:

ssh into your SkyWeather2 Raspberry Pi

```
cd /etc/systemd/systemd

```

copy the ".service" file:

```
cp /yourdownloadlocation/skyweather2.service .
```
(don't forget the "." at the end) and then do a

```
ls -la
```
to check that the file copied correctly.

Next, copy the .sh file into the same directory as the SkyWeather2.py file. This needs to be in the same ditrectory as the program.
Check that it was copied correctly.

You may need to make the .sh files executable.


Reload the systemd service files to include the new service we ksut added.
```
sudo systemctl daemon-reload
```

Next, enable the service to launch on every reboot. This is important as you will scratch your head alot wondering why the service stops when you reboot. This is done using the systemctl command...

```
sudo systemctl enable SkyWeather2
```

Start your service by telling the systemd to attempt to start the server.

```
sudo systemctl start SkyWeather2
```

To check the status of your service, see how long it's been running and get other information related to your server:

```
sudo systemctl status SkyWeather2
```


If you want to disable your service on every reboot, because you need to do a upgrade or the program is getting into an loop:

```
sudo systemctl disable SkyWeather2
```

## Where to go from here

This will give you a service that you can use to manage the SkyWeather2 server, and you can repeat the steps for the dash server with the provided Files by repeating the same steps.

You can look up more information about systemd at [www.systemd.io](https://www.systemd.io)

And of course, if you find an error in this tutorial or have an addition, feel
free to create an issue or a pull request.

Happy coding!
