#!/bin/sh

#$ -cwd
#$ -S /bin/sh

#$ -pe smp 1

#$ -m ea

#$ -N NextflowHeadJob


#nextflow run /shared/tutorial.nf  -with-timeline -with-trace -with-report -with-dag -w /shared/work -process.clusterOptions="-S /bin/bash"
nextflow run /shared/sleep_tutorial.nf  -with-timeline -with-trace -with-report -with-dag -w /shared/work -process.clusterOptions="-S /bin/bash"
