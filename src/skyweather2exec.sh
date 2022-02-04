#! /bin/bash
#
# file: skyweather2exec.sh
# used as part of the systmed setup to run the SkyWeather2 python app as a service.
#
cd /home/pi/SDL_Pi_SkyWeather2
/usr/bin/python3 /home/pi/SDL_Pi_SkyWeather2/SkyWeather2.py >> /home/pi/SDL_Pi_skyweather2.out 2>&1
# /usr/bin/python3 /home/pi/SDL_Pi_SkyWeather2/SkyWeather2.py > /dev/null 2>&1
