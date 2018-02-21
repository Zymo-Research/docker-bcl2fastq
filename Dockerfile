FROM centos:7

MAINTAINER Mingda Jin

RUN yum update -y \
 && yum install -y \
        unzip \
 && yum clean all

RUN curl -OsSL ftp://webdata2:webdata2@ussd-ftp.illumina.com/downloads/software/bcl2fastq/bcl2fastq2-v2.17.1.14-Linux-x86_64.zip \
 && unzip bcl2fastq2-v2.17.1.14-Linux-x86_64.zip \
 && yum -y --nogpgcheck install bcl2fastq2-v2.17.1.14-Linux-x86_64.rpm \
 && yum clean all \
 && rm -f bcl2fastq2-v2.17.1.14-Linux-x86_64.rpm \
 && rm -f bcl2fastq2-v2.17.1.14-Linux-x86_64.zip

ENV RUN_FOLDER /mnt/run
ENV OUTPUT_FOLDER /mnt/output
ENV MISMATCHES 1

# install tini - a tiny init process (PID 1) for containers
# https://github.com/krallin/tini
# Although this is equivalent to passing the --init flag to 'docker run' command in Docker 1.13
# and higher, installing tini is still needed if user is using old Docker versions. This can also
# enforce containers running with a init process regardless of using the --init flag.
RUN curl -o /usr/local/bin/tini -sSL https://github.com/krallin/tini/releases/download/v0.16.1/tini \
 && chmod +x /usr/local/bin/tini

ENTRYPOINT ["/usr/local/bin/tini", "--"]

CMD /usr/local/bin/bcl2fastq \
    --runfolder-dir $RUN_FOLDER \
    --output-dir $OUTPUT_FOLDER/Data/Intensities/BaseCalls \
    --barcode-mismatches $MISMATCHES \
    --with-failed-reads

