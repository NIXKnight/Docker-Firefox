FROM debian:buster-slim
MAINTAINER "Saad Ali <saad@nixknight.net>"

ARG USER=firefox
ARG GROUP=firefox
ARG UID=1000
ARG GID=1000
ARG FIREFOX_HOME=/home/$USER
ARG FIREFOX_VERSION=76.0

RUN apt-get update && \
    apt-get -y --no-install-recommends install bzip2 wget libpulse0 $(apt-cache depends firefox-esr | grep Depends | sed "s/.*ends:\ //" | tr '\n' ' ') && \
    cd /opt && \
    wget --no-check-certificate "https://ftp.mozilla.org/pub/firefox/releases/$FIREFOX_VERSION/linux-x86_64/en-US/firefox-$FIREFOX_VERSION.tar.bz2" -O firefox.tar.bz2 && \
    tar jxvf firefox.tar.bz2 && \
    apt-get clean all && rm -rf /var/lib/apt/lists/* 

RUN groupadd -g $GID $GROUP && \
    useradd -d "$FIREFOX_HOME" -u $UID -g $GID -m -s /bin/bash $USER

USER $USER
RUN mkdir $FIREFOX_HOME/hostdir
VOLUME $FIREFOX_HOME/hostdir
ENV HOME $FIREFOX_HOME
ENV PULSE_SERVER=unix:/run/user/1000/pulse/native
CMD /opt/firefox/firefox
