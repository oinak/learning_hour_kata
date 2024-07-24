# Dockerfile
FROM ruby:3.3.3

# install necessary packages and jemalloc
RUN apt-get update && \
      apt-get install libjemalloc2 && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*

# Set enviroment
ENV LD_PPRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc2.so.2

# Throw errors if Gemfile has been modified since Gemfile.lock
# omit this if don't bundle outside docker
# RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile* ./

RUN bundle install --jobs=4

COPY . .
