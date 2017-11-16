[![Docker Build Status](https://img.shields.io/docker/build/zymoresearch/bcl2fastq.svg)](https://hub.docker.com/r/zymoresearch/bcl2fastq/) [![Docker Pulls](https://img.shields.io/docker/pulls/zymoresearch/bcl2fastq.svg)](https://hub.docker.com/r/zymoresearch/bcl2fastq/)

# Dockerized Bcl2fastq-1.8.4

## Quick Start

Make sure `SampleSheet.csv` is located under `<run folder>/Data/Intensities/BaseCalls/`, and the user that runs `docker run` command on host machine has read permission to `<run folder>` and read/write permission to `<output folder>`.

```bash
docker run -d --name bcl2fastq \
    -u $( id -u $USER ):$( id -g $USER ) \
    -v <run folder>:/mnt/run \
    -v <output folder>:/mnt/output \
    zymoresearch/bcl2fastq
```

Replace `<run folder>` and `<output folder>` with the real directory names on host machine. The name of `<run folder>` may look something like `100723_EAS346_0188_FC626BWAAXX`. This will execute the following `bcl2fastq` command in a container.

```bash
/usr/local/bin/configureBclToFastq.pl \
    --input-dir /mnt/run/Data/Intensities/BaseCalls/ \
    --output-dir /mnt/output/Unaligned \
    --fastq-cluster-count 0 \
    --mismatches 1 \
    --no-eamss \
    --with-failed-reads && \
make -j 4 -C /mnt/output/Unaligned/
```

**It is strongly recommended to include `-u $( id -u $USER ):$( id -g $USER )` in `docker run` command.** This will make container switch to the user with the same UID and GID as the current user on host machine. However, if `id` command is not available on your operating system, UID and GID can also be passed to container statically with `-u` like `-u 1001:1001`. If no user is specified at runtime, programs will run as root in a container, which may cause some security vulnerabilities.


## Modify Bcl2fastq Command

### Modify the extent of parallelization

Override the default setting (default: 4) by passing an environment variable `CPU_NUM` to `docker run` command. This is equivalent to running `make -j $CPU_NUM` for bcl conversion and demultiplexing in container.

```bash
docker run -d --name bcl2fastq \
    -e "CPU_NUM=8" \
    -u $( id -u $USER ):$( id -g $USER ) \
    -v <run folder>:/mnt/run \
    -v <output folder>:/mnt/output \
    zymoresearch/bcl2fastq
```

### Modify the number of mismatches allowed for each index read

Override the default setting (default: 1) by passing an environment variable `MISMATCHES` to `docker run` command. This can dynamically modify the `--mismatches` option of `configureBclToFastq.pl` command executed in container.

```bash
docker run -d --name bcl2fastq \
    -e "MISMATCHES=0" \
    -u $( id -u $USER ):$( id -g $USER ) \
    -v <run folder>:/mnt/run \
    -v <output folder>:/mnt/output \
    zymoresearch/bcl2fastq
```

### Custom Bcl2fastq command

You can run your own `bcl2fastq` command by specifying arguments to `docker run`. Please note that a complete command  for bcl conversion and demultiplexing should consist of both `configureBclToFastq.pl` and `make`. For example:

```bash
docker run -d --name bcl2fastq \
    -u $( id -u $USER ):$( id -g $USER ) \
    -v <run folder>:/mnt/run \
    -v <output folder>:/mnt/output \
    zymoresearch/bcl2fastq \
    configureBclToFastq.pl \
      --input-dir /mnt/run/Data/Intensities/BaseCalls \
      --output-dir /mnt/output \
      --no-eamss && \
    make -j 4 -C /mnt/output
```

**Alternatively**, you can first start an interactive bash session.

```bash
docker run -it --name bcl2fastq\
    -u $( id -u $USER ):$( id -g $USER ) \
    -v <run folder>:/mnt/run \
    -v <output folder>:/mnt/output \
    zymoresearch/bcl2fastq bash
```

And then execute `bcl2fastq` command in the shell. For example:

```bash
/usr/local/bin/configureBclToFastq.pl \
    --input-dir /mnt/run/Data/Intensities/BaseCalls \
    --output-dir /mnt/output \
    --no-eamss
make -j 4 -C /mnt/output
```

Use `ctrl-p + ctrl-q` to detach the tty without exiting the shell.


## Note

* Run `docker logs <container name>` to fetch the logs of a container. Run `docker logs -f <container name>` to follow container log output real-time.
