FROM debian:bullseye

# Install dependencies
RUN apt-get update && \
    apt-get install -y sudo git python3 python3-pip nginx

# Add a non-root user
RUN useradd -m klipper && \
    usermod -aG sudo klipper && \
    echo 'klipper ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Switch to the non-root user
USER klipper
WORKDIR /home/klipper

# Clone Klipper, Moonraker, and Mainsail
RUN git clone https://github.com/Klipper3d/klipper.git && \
    git clone https://github.com/Arksine/moonraker.git && \
    git clone https://github.com/mainsail-crew/mainsail.git

# Install Python dependencies for Klipper and Moonraker
RUN pip3 install -r klipper/scripts/klippy-requirements.txt && \
    pip3 install -r moonraker/requirements.txt

# Set up Mainsail
RUN mkdir -p /var/www/mainsail && \
    cp -r mainsail/* /var/www/mainsail/

# Expose ports
EXPOSE 80 7125

# Copy the run script
COPY run.sh /home/klipper/run.sh
RUN chmod +x /home/klipper/run.sh

# Start the services
CMD ["/home/klipper/run.sh"]
