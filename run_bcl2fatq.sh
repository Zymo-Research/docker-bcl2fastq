#!/bin/bash

configureBclToFastq.pl \
--input-dir /run/Data/Intensities/BaseCalls/ \
-o /output/Unaligned/
--no-eamss \
--fastq-cluster-count 0 \
--mismatches 1 \
--with-failed-reads \
--force &&

cd /output/Unaligned/
make -j $cpu_num
