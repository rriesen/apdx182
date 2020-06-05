Summary
=======
NWChem to calculate energy of 10 water molecules on 32 compute nodes, each with two Intel Xeon E5-2680 v2 CPU @ 2.80GHz, under RHEL Server 6.5.


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
* MVAPICH2:
  Version 2.1 modified to integrate UTI library
* UTI library:
  https://github.com/RIKEN-SysSoft/uti.git
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

Install UTI
-----------
Execute following commands:
    git clone https://github.com/RIKEN-SysSoft/uti.git
    cd uti
    git checkout 348ed82d011545ec45b715da45f28e4e138a6396
    cd ..
    mkdir build && cd build
    ../uti/configure --prefix=$HOME/project/src/uti/install --with-cap-include=$HOME/usr/include --with-cap-lib=$HOME/lib64
    make && make install

Install MVAPICH
---------------
Execute following commands:
    tar xzf Data/mvapich-knsc-2020-04-22.tar.gz
    cd mvapich2-2.1
    ./configure --prefix=$HOME/project/mpich/mvapich-x86_64-linux-install CC=icc CXX=icpc F77=ifort FC=ifort CFLAGS=-I$HOME/usr/include LDFLAGS=-L$HOME/usr/lib --enable-fast=O2,ndebug --disable-rdma-cm --disable-mcast --enable-threads=multiple --enable-async-progress
    make && make install

Run NWChem
----------
(1) Go to the following website:
    http://www.nwchem-sw.org/index.php/Download
(2) Download the fowllowing file:
    http://www.nwchem-sw.org/download.php?f=Nwchem-6.6.revision27746-src.2015-10-20.tar.gz
(3) Build the NWChem with ARMCI-MPI by following the guide on the following website:
    http://www.nwchem-sw.org/index.php/Compiling_NWChem
(4) Download the following scripts:
    Data/nwchem-scripts-knsc-2020-06-05.tar.gz
(5) Run the experiments using nwchem.pl. Its usage:
    ./nwchem.pl <number of processes> <number of nodes> <configuration>
    Here are the examples (all using 32 nodes):
    1) With asynchronous progress communication threads, 4 cores dedicated to utility threads, 16 cores for compute processes
       ./nwchem.pl 512 32 16+4
    2) With asynchronous progress communication threads, 16 cores shared with compute processes and progress threads
       ./nwchem.pl 512 32 16+16
    3) Without asynchronous progress communication threads, 16 cores for compute processes
       ./nwchem.pl 512 32 16+0
