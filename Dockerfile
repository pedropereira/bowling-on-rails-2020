FROM ruby:2.6.6-alpine

# Set path to store the application inside of the Docker image
ENV INSTALL_PATH /api/

# Install system dependencies
RUN apk update && \
    apk add --no-cache build-base git less openssh postgresql-dev tzdata vim zsh

# Install powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k
COPY .zshrc .p10k.zsh /root/

# Create application folder
RUN mkdir -p $INSTALL_PATH

# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
# (the src likely changed and we don't want to invalidate Docker's cache too early)
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
COPY Gemfile Gemfile.lock $INSTALL_PATH

# This sets the context of where commands will be ran
WORKDIR $INSTALL_PATH

# Update RubyGems and install bundler
RUN gem update --system && \
    gem install bundler:2.1.4

# Install gems
RUN bundle install

# Expose port to outside
EXPOSE $PORT

CMD zsh
