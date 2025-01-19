# Use an appropriate base image
FROM ubuntu:latest

# Install necessary packages, consolidate apt-get update and install steps
RUN apt-get update && apt-get install -y \
    software-properties-common \
    kea-dhcp4-server \
    kea-admin \
    kea-common

# Create necessary directories for Kea including leases directory
RUN mkdir -p /var/run/kea /run/kea /var/lib/kea && \
    chown -R _kea:_kea /var/run/kea /run/kea /var/lib/kea && \
    touch /var/lib/kea/kea-leases4.csv && \
    chown _kea:_kea /var/lib/kea/kea-leases4.csv

# Copy your Kea configuration file into the container
COPY config.json /etc/kea/config.json

# Expose the DHCP server port
EXPOSE 67/udp 67/tcp

# Command to run the Kea server
CMD ["kea-dhcp4", "-c", "/etc/kea/config.json"]

# sudo docker build -t kea:2.6 .
# sudo docker run --network host -d --name kea kea:2.6
