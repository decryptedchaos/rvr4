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
            && apt-get install -y  tar curl \
            && useradd -m -d /home/container container \
			&& chown -R container:container /home/container \
			&& chmod -R 770 /home/container
			&& chown -R container:container /home/container
            	 		
			


USER 		container
ENV         HOME /home/container
WORKDIR     /home/container

COPY		./preflight.sh 		   /home/container/preflight.sh
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
