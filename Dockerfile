FROM centos:5

MAINTAINER Hunter Chung <b89603112@gmail.com>

RUN yum -y install curl ; yum -y update && yum clean all

RUN curl ftp://webdata:webdata@ussd-ftp.illumina.com/Downloads/Software/bcl2fastq/bcl2fastq-1.8.4-Linux-x86_64.rpm > /tmp/bcl2fastq-1.8.4-Linux-x86_64.rpm
RUN yum -y --nogpgcheck localinstall /tmp/bcl2fastq-1.8.4-Linux-x86_64.rpm
RUN rm -rf /tmp/bcl2fastq-1.8.4-Linux-x86_64.rpm

VOLUME /run /output
WORKDIR /run

CMD configureBclToFastq.pl --input-dir /run/Data/Intensities/BaseCalls/ --no-eamss --fastq-cluster-count 0 --mismatches 1 --with-failed-reads --force -o /output/Unaligned/
