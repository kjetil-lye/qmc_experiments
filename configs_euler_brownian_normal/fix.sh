#!/bin/bash
NX=128

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
	    cd m${samples}
	    sed -i "s/<\/create_function>/<\/create_function><make_parameters_function>${generator}_make_parameters<\/make_parameters_function><set_parameter_function>${generator}_set_parameter<\/set_parameter_function><delete_parameters_function>${generator}_delete_parameters<\/delete_parameters_function>/g" euler_brownian/euler_brownian.xml 
	    
	    if [ "${generator}" =  "monte_carlo" ];
	    then
		sed -i "s/dll/uniform/g" euler_brownian/euler_brownian.xml
	    fi

	    cd ..;
	done
	cd ..;
    done
    cd ..;
done



