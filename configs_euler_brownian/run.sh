#!/bin/bash
NX=256
export OMP_NUM_THREADS=1
cd "N${NX}"
DIMENSIONS=$(($NX*$NX*2))
for HURINDEX in 0.1 0.5 0.75;
do


    cd "H_${HURINDEX}";
    for generator in "monte_carlo" "halton_large" "halton409_large";
    do

	cd "euler_brownian_${generator}";
	for samples in 64 128 256 512 1024 2048 4096 8192 $((2*8192)) $((4*8192)) $((8*8192)) $((16*8192))
	do

	    cd "m${samples}";
	    cp -r ../../../../*.so ./

	    MULTI_SAMPLES=1;
	    
	    if [ "$samples" -gt "64" ];
		then
		MULTI_SAMPLES=$(($samples/128))
	    fi
	    bsub -N -B -n ${MULTI_SAMPLES} mpirun -np ${MULTI_SAMPLES} $HOME/alsvinn/build/alsuqcli/alsuqcli --multi-sample ${MULTI_SAMPLES} euler_brownian/euler_brownian.xml

	    cd ..;
	done
	cd ..;
    done
    cd ..;
done



