# ----------------------------------
# Pterodactyl Dockerfile
# Environment: RVR4
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        32bit/ubuntu:16.04

MAINTAINER  Pterodactyl Software, <support@pterodactyl.io>
ENV         DEBIAN_FRONTEND noninteractive
ENV         USER_NAME container
ENV         NSS_WRAPPER_PASSWD /tmp/passwd 
ENV         NSS_WRAPPER_GROUP /tmp/group

# Install Dependencies
RUN         dpkg --add-architecture i386 \
            && apt-get update \
            && apt-get upgrade -y \
            && apt-get install -y libnss-wrapper gettext-base tar curl gcc g++ lib32gcc1 lib32tinfo5 lib32z1 lib32stdc++6 libtinfo5:i386 libncurses5:i386 libcurl3-gnutls:i386 \
            && useradd -m -d /home/container -s /bin/bash container \
            && touch ${NSS_WRAPPER_PASSWD} ${NSS_WRAPPER_GROUP} \
            && chgrp 0 ${NSS_WRAPPER_PASSWD} ${NSS_WRAPPER_GROUP} \
            && chmod g+rw ${NSS_WRAPPER_PASSWD} ${NSS_WRAPPER_GROUP}	 		
			
ADD         passwd.template /passwd.template
ADD         passwd.template /passwd.template

USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./libnss_wrapper.so /libnss_wrapper.so
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
