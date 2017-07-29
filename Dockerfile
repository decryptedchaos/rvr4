# ----------------------------------
# Pterodactyl Dockerfile
# Environment: RVR4
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        32bit/ubuntu:16.04

MAINTAINER  Pterodactyl Software, <support@pterodactyl.io>
ENV         DEBIAN_FRONTEND noninteractive


# Install Dependencies
RUN         apt-get update \
            && apt-get upgrade -y \
            && apt-get install -y gettext-base tar curl gcc g++ libgcc1 libtinfo5 libz1 libstdc++6 libtinfo5 libncurses5 libcurl3-gnutls \
            && useradd -m -d /home/container container
            	 		
			



ENV         HOME /home/container
WORKDIR     /home/container

COPY		./preflight.sh 		   /home/container/preflight.sh
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
