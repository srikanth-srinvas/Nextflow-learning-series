params.ref = "/Users/srikanth/data/scripts/nextflow/bwa-nextflow/refs/klebsiella_reference.fasta"
params.index_dir="/Users/srikanth/data/scripts/nextflow/bwa-nextflow/index_dir"

process index {

publishDir("${params.index_dir}", mode: 'copy')

    input:
    path genome

    output:
        path "*"

    script:
    """
    bwa index $genome
    """
}

workflow {
    ref_ch = Channel.fromPath(params.ref)
    index(ref_ch)
    index.out.view()
}