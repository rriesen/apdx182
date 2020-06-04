Summary
=======
Ran NEMO-BENCH on two dual-socket Xeon E5-2698v4 CPU @ 2.2GHz
under bullx scs with various configurations of MPI processes and
OpenMP threads.



Experimental setup
==================

Relevant hardware details
-------------------------
Intel Xeon E5-2698v4 @ 2.2GHz, dual sockets, 20 cores each.
    
Operating systems and versions
------------------------------
Bullx SCS

Compilers and versions
----------------------
Intel v16.1.150

Applications and versions
-------------------------
BENCH configuration of NEMO 4.0

Libraries and versions
----------------------
Intel MPI v5.1.2.150

Key algorithms
--------------
Switch hybrid parallel configuration at runtime. This dynamic
parallelism is controlled by HIPPO: two different configurations
are defined and used for SCRIP and NEMO routines, respectively.

    - NEMO-BENCH: 40 and 80 MPI tasks per node.
    - SCRIP: 1 MPI task with 40 and 80 OpeMP threads per node.

Input datasets and versions
---------------------------
BENCH-1 degree resolution configuration.



Running the experiments
=======================

