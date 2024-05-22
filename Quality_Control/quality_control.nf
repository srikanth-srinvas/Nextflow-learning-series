params.fastq="/Users/srikanth/data/scripts/example_data/fastqs_forQC/*.fastq.gz"

process QC {

input:
 path fastq

output:
 path "*"

script:
"""
fastqc ${fastq}
"""

}

workflow  {
fastq_ch=Channel.fromPath(params.fastq)
QC(fastq_ch)
QC.out.view

}