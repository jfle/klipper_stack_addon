# Stage 1: Build dependencies
FROM python:3.8-slim AS builder

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

# Stage 2: Runtime image
FROM python:3.8-slim

# Set the working directory for runtime
WORKDIR /home/klipper

# Copy over the necessary files from the build stage
COPY --from=builder /home/klipper /home/klipper

# Expose necessary ports
EXPOSE 7125

# Set the entrypoint for the container
CMD ["python3", "/home/klipper/moonraker/main.py"]

