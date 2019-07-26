[![Docker Build Status](https://img.shields.io/docker/build/zymoresearch/bcl2fastq.svg)](https://hub.docker.com/r/zymoresearch/bcl2fastq/) [![Docker Pulls](https://img.shields.io/docker/pulls/zymoresearch/bcl2fastq.svg)](https://hub.docker.com/r/zymoresearch/bcl2fastq/)

# Illumina bcl2fastq Docker

The official [Software Guide](https://support.illumina.com/content/dam/illumina-support/documents/documentation/software_documentation/bcl2fastq/bcl2fastq2-v2-20-software-guide-15051736-03.pdf) is here. This image is built on Alpine so it's extremely lightweight.

## Quick Start

Make sure a sample sheet (`SampleSheet.csv`) is in place. The default location is the root run folder, but you can use the command `--sample-sheet` to specify any CSV file in any location.

Example:

```bash
docker run -d --name bcl2fastq \
    -v <run folder>:/mnt/run \
    -v <output folder>:/mnt/output \
    zymoresearch/bcl2fastq \
        --runfolder-dir /mnt/run \
        --output-dir /mnt/output/Data/Intensities/BaseCalls/Alignment_1\
        --barcode-mismatches 0 \
        --with-failed-reads \
        --no-lane-splitting
```

Replace `<run folder>` and `<output folder>` with real directory names on a host machine. They could be the same folder or different ones.

Run `docker logs -f <container name>` to follow container log output. Use `ctrl-c` to detach.

## Deployment

This repository is connected with a [DockerHub repo](https://cloud.docker.com/u/zymoresearch/repository/docker/zymoresearch/bcl2fastq). 
Automated build is configured and can be triggered by creating release tags on GitHub that match a certain regular expression pattern `/^v([0-9.]+)$/` (i.e. v2.20). 
A successful build will create a new image with corresponding Docker tag as well as updating the `latest` image.
