FROM cnosuke/ruby23-base
MAINTAINER cnosuke

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  imagemagick \
  libmagickwand-dev \
  memcached \
  nginx

WORKDIR /
ADD https://github.com/cnosuke/tokyo_amage/archive/master.zip master.zip
RUN unzip master.zip && mv tokyo_amage-master app

RUN mkdir -p /app/tmp /app/log /app/public /tmp/socks
WORKDIR /app

# Add unicorn and foreman gems
RUN echo "gem 'unicorn'" >> Gemfile
RUN echo "gem 'foreman'" >> Gemfile
RUN bundle install

# Add memcached config
ADD memcached.conf /etc/memcached.conf

# Add nginx configs and tricking logger to STDIO
ADD nginx.conf /etc/nginx/sites-enabled/.
RUN rm /etc/nginx/sites-enabled/default
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

ADD Procfile unicorn.rb /app/

EXPOSE 80
CMD ["foreman", "start"]
