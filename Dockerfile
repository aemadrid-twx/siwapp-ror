FROM ruby:2.6.3-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq
RUN apt-get install -y \
    curl \
    gnupg2
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN	apt-get install -y \
	build-essential \
	nodejs \
	libpq-dev \
	libqt5webkit5-dev \
	qt5-default \
	git \
	xvfb && \
    gem install bundler -v 2.3.26

# Copy project src to container
COPY ./Gemfile /app/
COPY ./Gemfile.lock /app/

# Set /app as workdir
WORKDIR /app

# Install dependencies
RUN bundle install

CMD ["bundle", "exec", "rails", "s", "-b", "'0.0.0.0'"]
