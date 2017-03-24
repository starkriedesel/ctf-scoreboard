FROM ruby:2.3

WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/Gemfile
RUN bundle install

COPY . /usr/src/app

EXPOSE 9292
CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0", "-p", "9292"]
