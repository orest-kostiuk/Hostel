# Start from a base image
FROM mcr.microsoft.com/devcontainers/universal:2

# Install dependencies
RUN apt-get update && apt-get install -y curl gpg

# Install RVM
RUN \curl -sSL https://get.rvm.io | bash -s stable

# Install Ruby 2.5.1
RUN /bin/bash -l -c "rvm install 2.5.1"

# Set Ruby 2.5.1 as the default
RUN /bin/bash -l -c "rvm --default use 2.5.1"

RUN /bin/bash -l -c "bundle install"