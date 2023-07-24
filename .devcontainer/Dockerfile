# use the official Ruby image for version 2.5.1
FROM ruby:2.5.1-slim-buster

# update system and install Linux packages you need
RUN apt-get update

# define the directory that we want to use
WORKDIR /workspace

# install Bundler
RUN gem install bundler
