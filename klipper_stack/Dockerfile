# Use a Python base image
FROM python:3.8-slim

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies required for the application
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev \
    python3-dev \
    python3-pip \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create and set the working directory
WORKDIR /home/klipper

# Copy the current project files into the container's working directory
COPY . /home/klipper/

# Upgrade pip and install dependencies from requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /home/klipper/requirements.txt

# Expose any necessary ports (adjust these as needed)
EXPOSE 7125

# Set the command to run the necessary services (like Klipper and Moonraker)
CMD ["python3", "/home/klipper/moonraker/main.py"]
