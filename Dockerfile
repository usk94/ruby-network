FROM ruby:3.2.2

WORKDIR /app

COPY . /app

RUN gem install net-ping

CMD ["ruby", "simulation.rb"]