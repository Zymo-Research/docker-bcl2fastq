# bcl2fastq has been primarily developed and tested on CentOS 5, Illumina's
# recommended and supported platform. However, CentOS 5 reached end-of-life
# on March 31, 2017. To ensure the maximum compatibility, this image uses 7.
FROM centos:7

MAINTAINER Mingda Jin

RUN curl --remote-name -s ftp://webdata:webdata@ussd-ftp.illumina.com/Downloads/Software/bcl2fastq/bcl2fastq-1.8.4-Linux-x86_64.rpm \
 && yum -y --nogpgcheck install bcl2fastq-1.8.4-Linux-x86_64.rpm \
 && yum clean all \
 && rm -f bcl2fastq-1.8.4-Linux-x86_64.rpm

ENV RUN_FOLDER /mnt/run
ENV OUTPUT_FOLDER /mnt/output
ENV MISMATCHES 1
ENV CPU_NUM 4

# install tini - a tiny init process (PID 1) for containers
# https://github.com/krallin/tini
# Although this is equivalent to passing the --init flag to 'docker run' command in Docker 1.13
# and higher, installing tini is still needed if user is using old Docker versions. This can also
# enforce containers running with a init process regardless of using the --init flag.
RUN curl -o /usr/local/bin/tini https://github.com/krallin/tini/releases/download/v0.16.1/tini \
 && chmod +x /usr/local/bin/tini

ENTRYPOINT ["/usr/local/bin/tini", "--"]

CMD /usr/local/bin/configureBclToFastq.pl \
    --input-dir $RUN_FOLDER/Data/Intensities/BaseCalls/ \
    --output-dir $OUTPUT_FOLDER/Unaligned \
    --fastq-cluster-count 0 \
    --mismatches $MISMATCHES \
    --no-eamss \
    --with-failed-reads \
 && make -j $CPU_NUM -C $OUTPUT_FOLDER/Unaligned/

