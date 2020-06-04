Summary
=======
Ran GeoFEM sol1 and sol7i on 32 compute nodes of the JCAHPC
Oakforest-PACS system; sol7i uses non-blocking collective calls,
which can be accelerated by MPI progress threads.



Experimental setup
==================

Relevant hardware details
-------------------------
Oakforest PACS, Intel(R) Xeon Phi(TM) CPU 7250 @ 1.40GHz. Quadrant
flat mode (MCDRAM exposed as NUMA node 1). 272 logical CPUs
(Hyper-Threading enabled);

Operating systems and versions
------------------------------
CentOS Linux release 7.6.1810 (Core). Linux kernel version 3.10.0-693.11.6.el7.x86_64

Compilers and versions
----------------------
Intel icc (ICC) 19.0.1.144 20181018

Applications and versions
-------------------------
GeoFEM versions sol1, sol7i

Libraries and versions
----------------------
Intel MPI 2018.3.222 (without progress  threads). Intel MPI
2019.1.144 release_mt (with progress threads). Hook pthread_create
and control thread placement to emulate UTI library binding behavior

Key algorithms
--------------
Process/thread binding: 8 ranks / node, 8 OMP threads /
rank. KMP_AFFINITY=compact. KMP_HW_SUBSET=1T. Progress threads
bound to logical CPU cores 68,69,134,135,66,67,202,203

Input datasets and versions
---------------------------
N/A



Running the experiments
=======================
