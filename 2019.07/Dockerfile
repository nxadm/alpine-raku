FROM alpine:latest
LABEL version="2.2.2" maintainer="JJMerelo@GMail.com" perl6version="2019.07"

# Environment
ENV PATH="/root/.rakudobrew/bin/../versions/moar-2019.07/install/bin:/root/.rakudobrew/bin/../versions/moar-2019.07/install/share/perl6/site/bin:/root/.rakudobrew/bin:${PATH}" \
    PKGS="curl git perl" \
    PKGS_TMP="curl-dev linux-headers make gcc musl-dev wget" \
    ENV="/root/.profile" \
    VER="2019.07"

# Basic setup, programs and init
RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP \
    && git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew \
    && echo 'eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"' >> ~/.profile \
    && eval "$(~/.rakudobrew/bin/rakudobrew init Sh)"\
    && rakudobrew build moar $VER \
    && rakudobrew global moar-$VER \
    && rakudobrew build-zef\
    && zef install "Getopt::Long:ver<0.2.0>" Linenoise App::Prove6\
    && apk del $PKGS_TMP \
    && RAKUDO_VERSION=`sed "s/\n//" /root/.rakudobrew/CURRENT` \
       rm -rf /root/.rakudobrew/${RAKUDO_VERSION}/src /root/zef \
       /root/.rakudobrew/git_reference

# Runtime
WORKDIR /root
ENTRYPOINT ["perl6"]

