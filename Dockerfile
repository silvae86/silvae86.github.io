FROM ruby:3.3.4

# install dependencies for responsive imagess
RUN apt-get update
RUN apt-get install -y libmagickwand-dev imagemagick exiftool ruby-full build-essential zlib1g-dev

RUN mkdir -p /setup_blog
WORKDIR /setup_blog
COPY Gemfile .
COPY Gemfile.lock .
RUN chmod -R ugo+rw /setup_blog

RUN gem install jekyll bundler rmagick
RUN gem install rmagick

#install deps
RUN bundle install

EXPOSE 4000

WORKDIR /blog
#serve blog
ENTRYPOINT [ "bundle", "exec", "jekyll", "serve", "--host=0.0.0.0"]