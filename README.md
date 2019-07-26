# Illumina bcl2fastq Docker

The official [Software Guide](https://support.illumina.com/content/dam/illumina-support/documents/documentation/software_documentation/bcl2fastq/bcl2fastq2-v2-20-software-guide-15051736-03.pdf) is here.

## Quick Start

Make sure a sample sheet (`SampleSheet.csv`) is in place. The default location is the root run folder, but you can use the command `--sample-sheet` to specify any CSV file in any location.

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

Replace `<run folder>` and `<output folder>` with real directory names on a host machine. They don't have to be the same folder.

Run `docker logs -f <container name>` to follow container log output. Use `ctrl-c` to detach.
