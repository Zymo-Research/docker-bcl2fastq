![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/zymoresearch/bcl2fastq) ![Docker Pulls](https://img.shields.io/docker/pulls/zymoresearch/bcl2fastq)

# Supported tags and respective `Dockerfile` links

* [`2.20`](https://github.com/Zymo-Research/docker-bcl2fastq/blob/master/Dockerfile)

# What is bcl2fastq?

The Illumina bcl2fastq2 Conversion Software demultiplexes sequencing data and converts base call (BCL) files into FASTQ files. For more information, please see the latest [software guide](https://support.illumina.com/content/dam/illumina-support/documents/documentation/software_documentation/bcl2fastq/bcl2fastq2-v2-20-software-guide-15051736-03.pdf).

# How to use this image

## Demultiplex to the same folder

Replace `<runfolder-dir>` with the real run folder path on host machine.

```bash
$ docker run -v <runfolder-dir>:/mnt/run zymoresearch/bcl2fastq --runfolder-dir /mnt/run
```
