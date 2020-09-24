FROM quay.io/fundingcircle/alpine-ruby-builder:2.7

COPY . .

RUN gem install bundler
RUN bundle install

ENTRYPOINT ["./entrypoint.sh"]