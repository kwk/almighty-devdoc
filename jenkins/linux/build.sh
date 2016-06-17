#!/bin/bash

# Echo to stderr
function errcho {
  >&2 echo "====  $@  ====";
}

# Show all command prior to executing them
set -x

# Exit if a command fails
set -e

# Where the source is stored?
# Take the value of the first and second argument or default
# to /source and /build
source_dir=${1:-/source}
build_dir=${2:-/build}

# Give all rights to users outside of the container
function clean_up {
  errcho "Cleaning up before exiting"
  
  errcho "Make build directory ${build_dir} readable from outside of container"
  chmod o+rw -Rv ${build_dir}

  # TODO (kkleine) Remove this bash when running in Jenkins
  # it is just here for interactive debugging
  bash
}
trap clean_up EXIT SIGHUP SIGINT SIGTERM SIGKILL

# Enable RVM (hide commands)
set +x
source /etc/profile.d/rvm.sh
set -x

# Restore bash trap
trap clean_up EXIT SIGHUP SIGINT SIGTERM SIGKILL

cd ${source_dir}
cp -Rfvp . ${build_dir}

# Install all ruby gems as specified in the Gemfile
cd ${build_dir}
bundle install

# Deploy
bundle exec rake deploy

