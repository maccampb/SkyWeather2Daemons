#! /bin/bash
# 
# file : dashboard.sh
#
# shell file used to launch the dash app from SDL. This runs as a service under systemd
#
cd /home/pi/SDL_Pi_SkyWeather2/dash_app
/usr/bin/python3 /home/pi/SDL_Pi_SkyWeather2/dash_app/index.py >> /home/pi/SDL_Pi_dash_app.out  2>&1
# /usr/bin/python3 /home/pi/SDL_Pi_SkyWeather2/dash_app/index.py > /dev/null  2>&1