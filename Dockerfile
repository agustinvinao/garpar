# syntax=docker/dockerfile:1
FROM ruby:3.1
RUN gem install bundler --version "2.2.15"

RUN apt-get update -qq && apt-get install -y libmariadbd-dev
RUN apt-get update && apt-get upgrade -y && \
  apt-get install --no-install-recommends -y ca-certificates 

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install

# WORKDIR /myapp
# COPY Gemfile /myapp/Gemfile
# RUN bundle install

# # Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
# CMD ["rails", "server", "-b", "0.0.0.0"]