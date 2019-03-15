FROM ruby:2.5.0

ENV APP_ROOT /app
WORKDIR $APP_ROOT

RUN apt-get update -qq \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get install -y build-essential nodejs libpq-dev yarn

ADD Gemfile $APP_ROOT
ADD Gemfile.lock $APP_ROOT

RUN bundle install

COPY . $APP_ROOT

RUN rm ./tmp/pids/server.pid
CMD ["rm", "./tmp/pids/server.pid", "&&", "rails", "server", "-b", "0.0.0.0"]
