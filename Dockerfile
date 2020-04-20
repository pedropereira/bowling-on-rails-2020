FROM ruby:2.6.5-alpine

ENV INSTALL_PATH /api
ENV PORT 5000

RUN apk update && \
    apk add --no-cache build-base sqlite-dev tzdata

RUN gem update --system && \
    gem install bundler:2.1.4

RUN mkdir -p $INSTALL_PATH
COPY . $INSTALL_PATH
WORKDIR $INSTALL_PATH

RUN bundle install

EXPOSE $PORT

CMD bundle exec rails s -p $PORT -b 0.0.0.0
