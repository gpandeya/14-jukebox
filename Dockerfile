# DEVELOPMENT DOCKERFILE


FROM ruby:2.4.1

RUN apt-get update && apt-get install vim postgresql-client redis-tools cifs-utils -y

RUN gem install rails

ENV RAILS_SERVE_STATIC_FILES "true"
ENV SECRET_KEY_BASE "db32eeada699718ee29d7f3f9213c82853207f60a952b326746a94e7c8e09255ec4c82f37aae36f1818cefc4baf6690c6cf9fc483157b84fbfcda70c79a8ca8b"
RUN rails assests:clobber && rails assets:precompile

RUN cd /usr/local                                                        \
    && wget https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.xz  \
    && tar -xvf node-v8.4.0-linux-x64.tar.xz                             \
    && mv node-v8.4.0-linux-x64 node                                     \
    && rm node-v8.4.0-linux-x64.tar.xz

ENV PATH "/usr/local/node/bin:$PATH"
ENV PORT "3333"
ENV HOST "0.0.0.0"
ENV RAILS_ENV "development"

RUN npm i -g yarn
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install

EXPOSE 3333
CMD ["rails", "server"]
