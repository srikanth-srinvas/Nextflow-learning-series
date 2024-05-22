params.linkfile = "/Users/srikanth/data/scripts/nextflow/genome_assembly/links.txt"
params.fastqdir = "/Users/srikanth/data/scripts/nextflow/genome_assembly/fastqs"

params.read1 = "/Users/srikanth/data/scripts/nextflow/genome_assembly/fastqs/SRR20082568_1.fastq.gz"
params.read2 = "/Users/srikanth/data/scripts/nextflow/genome_assembly/fastqs/SRR20082568_2.fastq.gz"
params.SPADES_Output = "/Users/srikanth/data/scripts/nextflow/genome_assembly/SPADES_Output"

process download {

    publishDir("${params.fastqdir}", mode: 'copy')

    input:
    path linkfile

    output:
    path "*", emit: outputfile

    script:
    """
    cat $linkfile | xargs -I {} -P 2 wget '{}'
    """
}

process assembly {

    publishDir("${params.SPADES_Output}", mode: 'copy')

    input:
    path read1
    path read2

    output:
    path "*", emit: SPADES_Output

    script:
    """
    echo ${read1.simpleName} | cut -d'_' -f1 | xargs -i spades.py --careful -1 $read1 -2 $read2 -o '{}'
    """
}

workflow {

    // Step to ensure fastq files are downloaded
    link_ch = Channel.fromPath(params.linkfile)
    download(link_ch)

    // Channels for read files
    read1_ch = Channel.fromPath(params.read1)
    read2_ch = Channel.fromPath(params.read2)

    // Run the assembly process
    assembly(read1_ch, read2_ch)

    // View the output
    assembly.out.SPADES_Output.view()
}
