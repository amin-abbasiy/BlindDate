ARG RUBY_VERSION=3.2.2

FROM ruby:$RUBY_VERSION-slim

# Set environment variables
ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true

COPY Gemfile Gemfile.lock /application/

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libvips curl git postgresql-client libpq-dev

# Ensure node.js 18 is available for apt-get
ARG NODE_MAJOR=18
RUN curl -sL https://deb.nodesource.com/setup_$NODE_MAJOR.x | bash -

# Install node and yarn
RUN apt-get update -qq && apt-get install -y nodejs && npm install -g yarn

# Mount $PWD to this workdir
WORKDIR /application

RUN gem install bundler -v "~> 2.4.10" && gem cleanup bundler
RUN bundle install --jobs "$(getconf _NPROCESSORS_ONLN)" --retry 3

# Ensure gems are installed on a persistent volume and available as bins
VOLUME /bundle
RUN bundle config set --global path '/bundle'
ENV PATH="/bundle/ruby/$RUBY_VERSION/bin:${PATH}"

# Copy the whole app into the image
COPY . /application

# Expose port
EXPOSE 3000

# make entrypoint executable
RUN ["chmod", "-R", "+x", "docker-entrypoint.sh"]

# Start the server
ENTRYPOINT ["sh", "docker-entrypoint.sh"]