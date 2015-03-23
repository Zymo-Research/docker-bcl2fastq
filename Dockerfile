FROM centos:5

MAINTAINER Hunter Chung <b89603112@gmail.com>

RUN yum -y install wget curl make ; yum -y update && yum clean all

RUN wget ftp://webdata:webdata@ussd-ftp.illumina.com/Downloads/Software/bcl2fastq/bcl2fastq-1.8.4-Linux-x86_64.rpm && \
yum -y --nogpgcheck localinstall bcl2fastq-1.8.4-Linux-x86_64.rpm && \
yum clean all && \
rm -rf bcl2fastq-1.8.4-Linux-x86_64.rpm

VOLUME /run /output
WORKDIR /run
ENV cpu_num=1

ADD run_bcl2fastq.sh /
RUN chmod 755 /run_bcl2fastq.sh
CMD /run_bcl2fastq.sh
