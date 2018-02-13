FROM ministryofjustice/ruby:2.3.3-webapp-onbuild

ENV UNICORN_PORT 3000

RUN touch /etc/inittab

RUN apt-get update && apt-get install -y

EXPOSE $UNICORN_PORT

RUN bundle exec rake assets:precompile RAILS_ENV=production SECRET_TOKEN=blah

CMD bundle exec unicorn -p $UNICORN_PORT -c ./config/unicorn.rb
