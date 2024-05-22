params.fastq = "/Users/srikanth/data/scripts/example_data/fastqs_forQC/*.fastq.gz"
params.qc_report = "/Users/srikanth/data/scripts/nextflow/Quality_Control"

process QC {

publishDir("${params.qc_report}", mode: 'copy')
    input:
    path fastq

    output:
    path "*", emit: qc_output

    script:
    """
    fastqc ${fastq}
    """
}

workflow {
    fastq_ch = Channel.fromPath(params.fastq)
    result_ch = QC(fastq_ch)
    
    result_ch.view()
}