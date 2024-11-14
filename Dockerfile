FROM ubuntu:latest

# Install necessary packages and clean up cache to reduce image size
RUN apt-get update && \
    apt-get install -y apache2 zip unzip wget && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /var/www/html

# Download and unzip the web template in a single RUN command to reduce image layers
RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page291/carserv.zip && \
    unzip carserv.zip && \
    cp -rvf carserv/* . && \
    rm -rf carserv carserv.zip

# Expose the default HTTP port
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]

