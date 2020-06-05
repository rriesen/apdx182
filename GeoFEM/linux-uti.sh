#!/bin/sh
#PJM -N "Geofem-test-8ppn-HWT-1T"
#PJM -L rscgrp=regular-flat
#PJM -L node=32
#PJM -L elapse=01:00:00
#PJM --omp thread=8
#PJM --mpi proc=256
#PJM -g gg10
#PJM -j
##PJM -e err
##PJM -o x256e.lst

COUNT=$PJM_NODE
PPN=$PJM_PROC_BY_NODE
echo "total mpi, node, ppn"
echo ${PJM_MPI_PROC} $COUNT $PPN
#export OMP_NUM_THREADS=16 #from --omp thread=
JOBCORES=$(expr $(expr ${PJM_MPI_PROC} \* $OMP_NUM_THREADS) / $COUNT )
HWT=1T
if [ $HWT = 1T ]; then
 export I_MPI_PIN_DOMAIN=$(expr $JOBCORES \* 4  / $PPN) #Job core per node *4 / proc per node (PPN)
elif [ $HWT = 2T ]; then
 export I_MPI_PIN_DOMAIN=$(expr $JOBCORES \* 2  / $PPN) #Job core per node *4 / proc per node (PPN)
else
 echo "num error"; exit
fi
export I_MPI_PERHOST=${PPN}
echo "Total node=" $COUNT
echo "Process per node=" $PPN
echo "OMP_NUM_THREADS=" $OMP_NUM_THREADS
echo "I_MPI_PIN_DOMAIN=" $I_MPI_PIN_DOMAIN
echo "I_MPI_PERHOST=" $I_MPI_PERHOST

export FI_PSM2_LAZY_CONN=1
export LD_PREFER_MAP_32BIT_EXEC=1

export I_MPI_JOB_FAST_STARTUP=1
export I_MPI_HARD_FINALIZE=1
export HFI_NO_CPUAFFINITY=1
export I_MPI_PIN_PROCESSOR_EXCLUDE_LIST=0,1,68,69,136,137,204,205
export KMP_AFFINITY=compact
export KMP_HW_SUBSET=1T
export OMP_STACKSIZE=1G
ulimit -s unlimited

#xsize=512; ysize=256; zsize=256
xsize=128; ysize=64; zsize=64

node=$COUNT
if [ $node -eq 16 ]; then
#64PPN
 #xdecomp=16; ydecomp=8; zdecomp=8
#32PPN
 #xdecomp=8; ydecomp=8; zdecomp=8
#16PPN
 #xdecomp=8; ydecomp=8; zdecomp=4
#8PPN
 xdecomp=8; ydecomp=4; zdecomp=4
elif [ $node -eq 32 ]; then
 xdecomp=8; ydecomp=8; zdecomp=4
elif [ $node -eq 64 ]; then
 xdecomp=8; ydecomp=8; zdecomp=8
elif [ $node -eq 128 ]; then
 xdecomp=16; ydecomp=8; zdecomp=8
elif [ $node -eq 256 ]; then
 xdecomp=16; ydecomp=16; zdecomp=8
elif [ $node -eq 512 ]; then
 xdecomp=16; ydecomp=16; zdecomp=16
elif [ $node -eq 1024 ]; then
 xdecomp=32; ydecomp=16; zdecomp=16
elif [ $node -eq 2048 ]; then
 xdecomp=32; ydecomp=32; zdecomp=16
elif [ $node -eq 4096 ]; then
 xdecomp=32; ydecomp=32; zdecomp=32
elif [ $node -eq 8192 ]; then
 xdecomp=64; ydecomp=32; zdecomp=32
else
echo "node num error"; exit
fi
rm -f mesh.inp
str="$xsize $ysize $zsize
 $xdecomp   $ydecomp   $zdecomp
 $OMP_NUM_THREADS  1
2000
-1"
echo "$str" > mesh.inp
sync


echo "START 2019 release_mt"
. /work/opt/local/cores/intel/impi/2019.1.144/intel64/bin/mpivars.sh release_mt
export I_MPI_ASYNC_PROGRESS=off
export I_MPI_FABRICS=shm:ofi

for bin in sol1 sol2 sol4 sol4i sol7 sol7i;
do

	for iter in `seq 1 5`;
	do
		echo "---- 2019 release_mt: $bin $iter:"
		mpiexec.hydra -n ${PJM_MPI_PROC} numactl --membind=1 ./$bin
	done

done
rm wk*

echo "START 2019 release_mt ASYNC first and last tiles"
export I_MPI_ASYNC_PROGRESS=on
export I_MPI_FABRICS=shm:ofi

# Enable UTI library binding policy
export UTI_BIND_CPUS=68,69,134,135,66,67,202,203

for bin in sol7i;
do

	for iter in `seq 1 5`;
	do
	#echo ./$bin
		echo "---- 2019 release_mt + async: $bin $iter:"
		mpiexec.hydra -n ${PJM_MPI_PROC} -env LD_PRELOAD=./libuti.so numactl --membind=1 ./$bin
		exit 0
	done

done
rm wk*

echo "END"
