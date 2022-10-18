FROM alpine:3.14

LABEL maintainer="Mingda Jin<mjin@zymoresearch.com>"

WORKDIR /tmp

# Install missing mcheck.h in alpine
COPY mcheck.h /usr/include/

RUN apk --no-cache add \
      alpine-sdk \
      bash \
      cmake \
      zlib-dev \
      libstdc++ \
 && wget ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2-20-0-tar.zip \
 && unzip bcl2fastq2-v2-20-0-tar.zip \
 && gunzip bcl2fastq2-v2.20.0.422-Source.tar.gz \
 && tar xvf bcl2fastq2-v2.20.0.422-Source.tar \
 && ./bcl2fastq/src/configure --prefix=/usr/local/ --with-cmake=/usr/bin/cmake \
 && make \
 && make install \
 && rm -r /tmp/* \
 && rm /usr/include/mcheck.h \
 && apk --no-cache del \
      alpine-sdk \
      bash \
      cmake \
      zlib-dev

WORKDIR /

ENTRYPOINT ["bcl2fastq"]

CMD ["--version"]

