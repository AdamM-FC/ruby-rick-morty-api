FROM quay.io/fundingcircle/alpine-ruby-builder:2.7

COPY . .

RUN apk --no-cache add sqlite sqlite-dev
RUN gem install bundler
RUN bundle install

EXPOSE 3000

ENTRYPOINT ["./entrypoint.sh"]