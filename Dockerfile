FROM debian:bookworm-20240513-slim

# ARG only available during build
# never env DEBIAN_FRONTEND=noninteractive !!
ARG DEBIAN_FRONTEND=noninteractive

RUN \
  dpkg --add-architecture i386 && \
  apt-get -qq -y update && \
  apt-get upgrade -y -qq && \
  apt-get install -y -qq software-properties-common && \
  # add repositories
  echo "deb http://ftp.us.debian.org/debian bookworm main non-free" > /etc/apt/sources.list.d/non-free.list
RUN \
  apt-get update -qq && \
  echo steam steam/question select "I AGREE" | debconf-set-selections && \
  echo steam steam/license note '' | debconf-set-selections
RUN \ 
  apt-get install -qq -y --install-recommends \
  steamcmd

RUN apt-get autoremove -qq -y && \
  apt-get -qq clean autoclean && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN adduser sapiens --home /home/sapiens
USER sapiens
RUN mkdir -p /home/sapiens/.local/share/majicjungle/

WORKDIR /home/sapiens

COPY entrypoint.sh /home/sapiens/
# if i dont switch back to root, entrypoint throws segmentationfault
USER root
ENTRYPOINT /home/sapiens/entrypoint.sh