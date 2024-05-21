params.linkfile="/Users/srikanth/data/scripts/nextflow/genome_assembly/links.txt"
params.fastqdir="/Users/srikanth/data/scripts/nextflow/genome_assembly/fastqs"

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

workflow {

    link_ch = Channel.fromPath(params.linkfile)
    download(link_ch)
    download.out.outputfile.view()

}