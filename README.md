# Dockerized Bcl2fastq-2.20

You can refer to the official [Bcl2fastq2 User Guide](https://support.illumina.com/content/dam/illumina-support/documents/documentation/software_documentation/bcl2fastq/bcl2fastq2_guide_15051736_v2.pdf) for more information.

## Quick Start

Make sure a valid `SampleSheet.csv` is located under `<run folder>`, and the user that runs `docker run` command on host machine has read permission to `<run folder>` and read/write permission to `<output folder>`.

```bash
docker run -d --name bcl2fastq2 \
    -u $( id -u $USER ):$( id -g $USER ) \
    -v <run folder>:/mnt/run \
    -v <output folder>:/mnt/output \
    zymoresearch/bcl2fastq:2.20
```

Replace `<run folder>` and `<output folder>` with the real directory names on host machine. The name of `<run folder>` may look something like `100723_EAS346_0188_FC626BWAAXX`. This will execute the following `bcl2fastq2` command in a container.

```bash
/usr/local/bin/bcl2fastq \
    --runfolder-dir /mnt/run \
    --output-dir /mnt/output/Data/Intensities/BaseCalls \
    --barcode-mismatches 1 \
    --with-failed-reads
```

**It is strongly recommended to include `-u $( id -u $USER ):$( id -g $USER )` in `docker run` command.** This will make container switch to the user with the same UID and GID as the current user on host machine. However, if `id` command is not available on your operating system, UID and GID can also be passed to container statically with `-u` like `-u 1001:1001`. If no user is specified at runtime, programs will run as root in a container, which may cause some security vulnerabilities.


## Docker Options

You can configure the execution of `bcl2fastq2` with the following Docker options.

* `-e "MISMATCHES=1"` - Comma-delimited list of number of mismatches allowed for each read (for example: 1,1). If a single value is provide, all index reads will allow the same number mismatches.


## Custom Bcl2fastq2 Command

You can run your own `bcl2fastq2` command by specifying arguments to `docker run`. For example:

```bash
docker run -d --name bcl2fastq2 \
    -u $( id -u $USER ):$( id -g $USER ) \
    -v <run folder>:/mnt/run \
    -v <output folder>:/mnt/output \
    zymoresearch/bcl2fastq:2.17 \
    /usr/local/bin/bcl2fastq \
        --runfolder-dir $RUN_FOLDER \
        --output-dir $OUTPUT_FOLDER \
        --barcode-mismatches 0
```

**Alternatively**, you can first start an interactive bash session.

```bash
docker run -it --name bcl2fastq2 \
    -u $( id -u $USER ):$( id -g $USER ) \
    -v <run folder>:/mnt/run \
    -v <output folder>:/mnt/output \
    zymoresearch/bcl2fastq:2.17 bash
```

And then execute `bcl2fastq2` command in the shell. For example:

```bash
/usr/local/bin/bcl2fastq \
    --runfolder-dir $RUN_FOLDER \
    --output-dir $OUTPUT_FOLDER \
    --barcode-mismatches 0
```

Use `ctrl-p + ctrl-q` to detach the tty without exiting the shell.


## Note

* Run `docker logs <container name>` to fetch the logs of a container. Run `docker logs -f <container name>` to follow container log output real-time.

* Please be aware that the format of Sample Sheet used by Bcl2fastq2 is different from that of Bcl2fastq.
