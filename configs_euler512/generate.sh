#!/bin/bash
NX=512
set -e
export OMP_NUM_THREADS=1
for x in *.so; 
do 
    x=`basename $x`; 
    x=${x//.so/}; 
    x=${x//lib/};
    mkdir kelvinhelmholtz_${x}
    cd kelvinhelmholtz_${x}; 
    for M in 64 128 256 512 1024 2048 4096 8192 $((2*8192)) $((4*8192)); 
    do 
	mkdir m${M}
	cd m${M};
	cp -r ../../template_kelvinhelmholtz ./kelvinhelmholtz;
	sed -i "s/GENERATOR/${x}/g" kelvinhelmholtz/kelvinhelmholtz.xml
	sed -i "s/SAMPLES/${M}/g" kelvinhelmholtz/kelvinhelmholtz.xml
	sed -i "s/NX/${NX}/g" kelvinhelmholtz/kelvinhelmholtz.xml


	N=$(($M/16)); 
	if [ "$N" -ge "1024" ];
	then
	    N=1024;
	fi;
	cp ../../*.so ./; 
	bsub -W 24:00 -N -B -n $N mpirun -np $N $HOME/alsvinn/build/alsuqcli/alsuqcli --multi-sample $N kelvinhelmholtz/kelvinhelmholtz.xml;
	cd ..; 
    done; 
    cd .. ; 
done

x='monte_carlo'

mkdir kelvinhelmholtz_${x}
cd kelvinhelmholtz_${x}; 
for M in 64 128 256 512 1024 2048 4096 8192 $((2*8192)) $((4*8192)); 
do 
    mkdir m${M}
    cd m${M};
    cp -r ../../template_kelvinhelmholtz ./kelvinhelmholtz;
    sed -i "s/dll/uniform/g" kelvinhelmholtz/kelvinhelmholtz.xml
    sed -i "s/GENERATOR/${x}/g" kelvinhelmholtz/kelvinhelmholtz.xml
    sed -i "s/SAMPLES/${M}/g" kelvinhelmholtz/kelvinhelmholtz.xml
    sed -i "s/NX/${NX}/g" kelvinhelmholtz/kelvinhelmholtz.xml


    N=$(($M/16)); 
    if [ "$N" -ge "1024" ];
    then
	N=1024;
    fi;
    cp ../../*.so ./; 
    bsub -W 24:00 -N -B -n $N mpirun -np $N $HOME/alsvinn/build/alsuqcli/alsuqcli --multi-sample $N kelvinhelmholtz/kelvinhelmholtz.xml;
    cd ..; 
done; 
cd .. ; 
