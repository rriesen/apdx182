Summary
=======
Ran CANDLE with Pilot 3 data set on an Intel Platinum 8168
CPU @ 2.70GHz under Linux 4.14.134 and the mOS multi-kernel v0.7
using CentOS Linux 7.

The CANDLE application, the various input decks (called Pilots),
as well as instructions on how to configure and run it, can be
obtained from https://asc.llnl.gov/coral-2-benchmarks/



Experimental setup
==================

Relevant hardware details
-------------------------
Intel Platinum 8168 CPU @ 2.70GHz, dual sockets, 24 cores each. 196
GB DDR4, no accelerators

Operating systems and versions
------------------------------
Linux experiments: CentOS Linux 7 with 4.14.134 from kernel.org
mOS experiments: mOS v0.7 from https://github.com/intel/mOS based on 4.14.134 Linux

Compilers and versions
----------------------
Intel Parallel Studio XE 2018.3.051
Python 3.7 using anaconda for package management

Applications and versions
-------------------------
CANDLE from the CORAL-2 Deep Learning Suite from https://asc.llnl.gov/coral-2-benchmarks/

Libraries and versions
----------------------
Python 3.7 using anaconda for package management
Packages: candle intelpython3_core intel tensorflow pandas keras
    scikit-learn requests opencv tqdm matplotlib graphviz pydot

Key algorithms
--------------
OpenMP thread allocation algorithm: KMP_BLOCKTIME=0
Initial configuration: KMP_AFFINITY="granularity=fine,compact,1,0."
Optimized configuration: KMP_AFFINITY="granularity=fine,proclist=[10-23,34-47,58-71,82-95],explicit;"

Input datasets and versions
---------------------------
CANDLE Pilot 3 data set from https://github.com/ECP-CANDLE/Benchmarks/tree/master/Pilot3 using
the P3B1 benchmark p3b1_baseline_keras2.py



Running the experiments
=======================
Under Linux:
export OMP_NUM_THREADS=46
python ./p3b1_baseline_keras2.py --inter-op-threads 2 --intra-op-threads 23

Under mOS:
export OMP_NUM_THREADS=46
yod python ./p3b1_baseline_keras2.py --inter-op-threads 2 --intra-op-threads 23
