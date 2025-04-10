#!/bin/bash

# Start Klipper
./klipper/scripts/start-klippy.sh &

# Start Moonraker
./moonraker/moonraker.py &

# Start Nginx
sudo service nginx start

# Keep the container running
tail -f /dev/null
