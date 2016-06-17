FROM fedora:23
MAINTAINER "Konrad Kleine <kkleine@redhat.com>"
ENV LANG=en_US.utf8

RUN dnf install -y \
      python3-blockdiag \
      python3-blockdiag-devel \
      graphviz \
      curl \
      which \
      tar \
      procps-ng \
      findutils \
    && dnf clean all

#----------------------------------------------------------
# RVM setup
# Inspired by https://rvm.io/rvm/security but not directly
# copied as gpg needs to be gpg2 for instance.
#----------------------------------------------------------

RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

# Download the installer
RUN curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer
RUN curl -O https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer.asc

# Verify the installer signature (might need `gpg2`), and if it validates...
RUN gpg2 --verify rvm-installer.asc

# Run RVM the installer
RUN bash rvm-installer stable

# Install Ruby through RVM and the bundle utility
RUN bash -c "source /etc/profile.d/rvm.sh && rvm install 2.3.1 && gem install bundler"

#----------------------------------------------------------
# Misc.
#----------------------------------------------------------

# Mount source and build folders to these locations to get persitency
VOLUME ["/source", "/build"]

ENTRYPOINT ["/bin/bash"]
