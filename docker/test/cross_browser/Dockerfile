FROM ruby:2.3.3-slim
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    npm \
    wget \
    zip \
    net-tools
RUN bash -c "wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && unzip ngrok-stable-linux-amd64.zip -d /bin/"

RUN gem install bundler
RUN mkdir -p /app
WORKDIR /app
CMD tail -f /dev/null