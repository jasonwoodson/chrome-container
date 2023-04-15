# Use the official Debian lite image as the base
FROM debian:bullseye-slim

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV CHROME_VERSION "google-chrome-stable"

# Install Google Chrome and required dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        hicolor-icon-theme \
        libcanberra-gtk* \
        libgl1-mesa-dri \
        libgl1-mesa-glx \
        libpango1.0-0 \
        libpulse0 \
        libv4l-0 \
        fonts-symbola \
        xdg-utils && \
    curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y ${CHROME_VERSION} && \
    apt-get purge --auto-remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up a non-root user
RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome && \
    mkdir -p /home/chrome && chown -R chrome:chrome /home/chrome

# Set working directory
WORKDIR /home/chrome

# Switch to the non-root user
USER chrome

# Set entrypoint
ENTRYPOINT [ "google-chrome" ]

# Set command
CMD [ "--user-data-dir=/data", "--no-sandbox", "--disable-dev-shm-usage" ]

