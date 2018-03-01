#!/bin/bash
cwd=$(pwd)
NX=64

cd "N${NX}"
DIMENSIONS=$(($NX*$NX*2))
for HURINDEX in 0.1 0.5 0.75;
do


    cd "H_${HURINDEX}";

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

	cd "euler_brownian_sobol_${datasetname}";
	pwd
	for samples in 64 128 256 512 1024 2048 4096 8192 $((2*8192)) $((4*8192)) $((8*8192)) $((16*8192))
	do

	    cd "m${samples}";


	    sed -i "s/<\/create_function>/<\/create_function><make_parameters_function>${generator}_make_parameters<\/make_parameters_function><set_parameter_function>${generator}_set_parameter<\/set_parameter_function><delete_parameters_function>${generator}_delete_parameters<\/delete_parameters_function>/g" euler_brownian/euler_brownian.xml

	    cd ..;
	done
	cd ..;
    done

    cd ..;
done



