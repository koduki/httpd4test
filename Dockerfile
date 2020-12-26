FROM ruby:3.0-rc-slim

RUN gem install webrick
RUN mkdir /app /workdir
ADD ./src/app.rb /app/app.rb

WORKDIR /workdir
ENTRYPOINT ["ruby", "/app/app.rb"]
