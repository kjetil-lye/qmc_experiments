#!/bin/bash
cwd=$(pwd)
NX=64
mkdir "N${NX}"
cd "N${NX}"
DIMENSIONS=$(($NX*$NX*2))
for HURINDEX in 0.1 0.5 0.75;
do

    mkdir "H_${HURINDEX}";
    cd "H_${HURINDEX}";
    for generator in "monte_carlo" "halton_large" "halton409_large";
    do
	mkdir "euler_brownian_${generator}";
	cd "euler_brownian_${generator}";
	for samples in 64 128 256 512 1024 2048 4096 8192 $((2*8192)) $((4*8192)) $((8*8192)) $((16*8192))
	do
	    mkdir "m${samples}";
	    cd "m${samples}";
	    cp -r ../../../../template_euler_brownian/ euler_brownian

	    sed -i "s/NX/${NX}/g" euler_brownian/euler_brownian.xml
	    sed -i "s/SAMPLES/${samples}/g" euler_brownian/euler_brownian.xml
	    sed -i "s/DIMENSION/${DIMENSIONS}/g" euler_brownian/euler_brownian.xml

	    sed -i "s/HURINDEX/${HURINDEX}/g" euler_brownian/euler_brownian.py
	    sed -i "s/GENERATOR/${generator}/g" euler_brownian/euler_brownian.xml

	    if [ "${generator}" =  "monte_carlo" ];
	    then
		sed -i "s/dll/uniform/g" euler_brownian/euler_brownian.xml
	    fi

	    cd ..;
	done
	cd ..;
    done



    for dataset in ${cwd}/new*.txt
    do
	generator="sobol_large"
	datasetname=$(basename $dataset)
	datasetname=${datasetname//-/}
	datasetname=${datasetname//./}
	datasetname=${datasetname//kuo/}
	datasetname=${datasetname//joe/}
	datasetname=${datasetname//new/}
	datasetname=${datasetname//txt/}
	mkdir "euler_brownian_sobol_${datasetname}";
	cd "euler_brownian_sobol_${datasetname}";
	for samples in 64 128 256 512 1024 2048 4096 8192 $((2*8192)) $((4*8192)) $((8*8192)) $((16*8192))
	do
	    mkdir "m${samples}";
	    cd "m${samples}";
	    cp $dataset  ./dataset.txt
	    cp -r ../../../../template_euler_brownian/ euler_brownian

	    sed -i "s/NX/${NX}/g" euler_brownian/euler_brownian.xml
	    sed -i "s/SAMPLES/${samples}/g" euler_brownian/euler_brownian.xml
	    sed -i "s/DIMENSION/${DIMENSIONS}/g" euler_brownian/euler_brownian.xml

	    sed -i "s/HURINDEX/${HURINDEX}/g" euler_brownian/euler_brownian.py
	    sed -i "s/GENERATOR/${generator}/g" euler_brownian/euler_brownian.xml

	    cd ..;
	done
	cd ..;
    done

    cd ..;
done



