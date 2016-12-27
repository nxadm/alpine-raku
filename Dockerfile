FROM alpine:latest
MAINTAINER JJ Merelo <jjmerelo@GMail.com>
WORKDIR /root
ENTRYPOINT ["perl6"]

#Basic setup
RUN apk update
RUN apk upgrade

#Add basic programs
RUN apk add gcc git linux-headers make musl-dev perl

#Download and install rakudo
RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew
RUN echo 'export PATH=~/.rakudobrew/bin:$PATH' >> /etc/profile
RUN echo 'eval "$(/root/.rakudobrew/bin/rakudobrew init -)"' >> /etc/profile
ENV PATH="/root/.rakudobrew/bin:${PATH}"
RUN rakudobrew init

#Build moar
RUN rakudobrew build moar

#Build other utilities
RUN rakudobrew build panda
RUN panda install Linenoise

#Mount point
RUN mkdir /app
VOLUME /app
