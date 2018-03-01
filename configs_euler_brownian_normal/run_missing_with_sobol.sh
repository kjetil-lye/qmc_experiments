#!/bin/bash
set -e
NX=64
export OMP_NUM_THREADS=1
cd "N${NX}"
DIMENSIONS=$(($NX*$NX*2))
for HURINDEX in 0.1 0.5 0.75;
do


    cd "H_${HURINDEX}";
    for generator_folder in euler_brownian_*
    do
	generator=${generator_folder//euler_brownian_/};
	cd ${generator_folder}
	for samples in 64 128 256 512 1024 2048 4096 8192 $((2*8192)) $((4*8192)) $((8*8192)) $((16*8192))
	do

	    cd "m${samples}";

	    MULTI_SAMPLES=1;
	    
	    if [ "$samples" -gt "64" ];
		then
		MULTI_SAMPLES=$(($samples/128))
	    fi
	    if [ ! -f 'alsuqcli_brownian_report.json' ] ;
	    then
		cp -r ../../../../*.so ./
		echo ${generator} ${samples}
		bsub -R beta -W 24:00 -N -B -n ${MULTI_SAMPLES} mpirun -np ${MULTI_SAMPLES} $HOME/alsvinn/build/alsuqcli/alsuqcli --multi-sample ${MULTI_SAMPLES} euler_brownian/euler_brownian.xml
	    fi
	    

	    cd ..;
	done
	cd ..;
    done
    cd ..;
done



