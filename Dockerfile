FROM        ubuntu:bionic

LABEL       author="BSHNameless" maintainer="salankilaszlo@salankilaszlo.hu"

RUN         apt-get update \
            && apt-get upgrade -y \
            && apt install -y apt-transport-https dirmngr ca-certificates \
            && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
            && echo "deb https://download.mono-project.com/repo/ubuntu vs-bionic main" | tee /etc/apt/sources.list.d/mono-official-vs.list \
            && apt-get update \
            && apt -y --no-install-recommends install wget curl zip unzip unrar libopus-dev python mono-devel cron apt-transport-https  \
            && useradd -d /home/container -m container


USER        container
ENV         USER=container HOME=/home/container
ENV TZ=Europe/Budapest \
    DEBIAN_FRONTEND=noninteractive

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]