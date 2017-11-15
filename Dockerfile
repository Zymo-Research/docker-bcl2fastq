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

CMD /usr/local/bin/configureBclToFastq.pl \
    --input-dir $RUN_FOLDER/Data/Intensities/BaseCalls/ \
    --output-dir $OUTPUT_FOLDER/Unaligned \
    --fastq-cluster-count 0 \
    --mismatches $MISMATCHES \
    --no-eamss \
    --with-failed-reads \
 && make -j $CPU_NUM -C $OUTPUT_FOLDER/Unaligned/

