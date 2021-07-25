FROM scratch

ENV USER=${USER:-pi}

ENV USER_NAME=${USER}
ENV HOME=/home/${USER}
ENV WORKDIR=/home/${USER}

ENV DEBIAN_FRONTEND noninteractive
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}

USER root

ADD rootfs.tar /

RUN echo "pi:sk123456" | chpasswd

RUN apt-get update && apt-get install apt-utils && apt-get upgrade -y && \
apt-get install -y locales mc && \
apt-get -y autoremove && \
apt-get autoclean && \
apt-get clean && \
localedef -i pl_PL -c -f UTF-8 -A /usr/share/locale/locale.alias pl_PL.UTF-8 && \
localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8


USER ${USER}
WORKDIR ${HOME}

RUN mkdir -p Workspace

CMD ["/bin/bash"]

MAINTAINER Piotr ZAWADZKI "pzawadzki@polsl.pl"

# docker run --rm -ti --net=host -v ${PWD}:/home/pi/Workspace -w /home/pi/Workspace pzawad/raspios-lite /bin/bash


