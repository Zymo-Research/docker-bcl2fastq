# bcl2fatq-docker

The `Dockerfile` and related shell script files to build a [docker container](https://www.docker.com/),
which can execute [BCL2Fastq](http://support.illumina.com/content/dam/illumina-support/documents/documentation/software_documentation/bcl2fastq/bcl2fastq_letterbooklet_15038058brpmi.pdf).

## Qickstart
`docker run -d --name bcl2fastq -e "cpu_num=<NUMBER OF CPUs>" -v <RUN FOLDER>:/run -v <OUTPUT FOLDER>:/output hunterchung/bcl2fastq-docker`
### Variables
* `<NUMBER OF CPUs>`: BCL2Fastq process can be parallelilzed. Use a reasonable number depending
on the setup of your computer or computing cluster.
* `<RUN FOLDER>`: The full path of the run folder. E.g. ``.
* `OUTPUT FOLDER`: The process will create a `Unaligned` folder inside the `OUTPUT FOLDER` you specifiy here. The `Unaligned` contains all **Fastq** files.

## Troubleshooting
* If you want to access the container after running (maybe for debugging), do not use `--rm=true` argument.
* use `docker logs bcl2fastq` to access the log files.
