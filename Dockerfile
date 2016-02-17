FROM cnosuke/ruby23-base
MAINTAINER cnosuke

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  imagemagick \
  libmagickwand-dev \
  memcached

COPY updateGit .
RUN git clone --depth 1 https://github.com/cnosuke/tokyo_amage.git /app

RUN echo "gem 'unicorn'" >> /app/Gemfile
RUN cd /app && bundle install

ADD run.sh /app/run.sh
ADD unicorn.rb /app/unicorn.rb
ADD memcached.conf /etc/memcached.conf
RUN mkdir -p /app/tmp /app/log /tmp/socks

EXPOSE 8080
CMD ["/app/run.sh"]
