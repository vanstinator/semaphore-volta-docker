FROM ubuntu:20.04

# curl and ca-certificates are needed for volta installation
RUN apt-get update \
  && apt-get install -y \
  curl \
  ca-certificates \
  git \
  lftp \
  openssh-client \
  coreutils \
  --no-install-recommends

# We'll need to run docker commands
RUN curl -sSL https://get.docker.com/ | sh

# bash will load volta() function via .bashrc 
# using $VOLTA_HOME/load.sh
SHELL ["/bin/bash", "-c"]

# since we're starting non-interactive shell, 
# we wil need to tell bash to load .bashrc manually
ENV BASH_ENV ~/.bashrc
# needed by volta() function
ENV VOLTA_HOME /root/.volta
# make sure packages managed by volta will be in PATH
ENV PATH $VOLTA_HOME/bin:$PATH

# install volta
RUN curl https://get.volta.sh | bash
