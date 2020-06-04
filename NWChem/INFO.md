Summary
=======
NWChem to calculate energy of 10 water molecules on 32 compute
nodes, each with two Intel Xeon E5-2680 v2 CPU @ 2.80GHz, under
RHEL Server 6.5.



Experimental setup
==================

Relevant hardware details
-------------------------
Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz 10 CPU cores
(Hyper-Threading disabled) x 2 sockets.

Operating systems and versions
------------------------------
Red Hat Enterprise Linux Server release 6.5. Linux kernel version
2.6.32-754.27.1.el6.x86_64.

Compilers and versions
----------------------
Intel icc (ICC) 17.0.3 20170404. 

Applications and versions
-------------------------
NWChem version 6.6, revision 27746 (2015-10-20). 

Libraries and versions
----------------------
MVAPICH2 version 2.1 modified to integrate UTI library UTI library:
git commit hash: 348ed82; prefix hwloc symbols with 'uti_'.

Key algorithms
--------------
Process/thread binding: 16 ranks / node bound to physical CPU cores
2-9 and 12-19, 1 OMP thread / rank. Progress threads bound to CPU
cores 0,1,10,11.

Input datasets and versions
---------------------------
Cluster: Ten water molecules. Method: Partial-direct CCSD(T). Basis:
cc-pvdz. Task (what to calculate): Energy.



Running the experiments
=======================

