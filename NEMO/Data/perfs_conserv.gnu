set xlabel 'Resources (core)' font "PetitaMedium,30"
set ylabel 'Time (s)' font "PetitaMedium,30"
# add /archive/globc/eric/evian/Tools/ttf2pt1-3.4.4/install/bin to PATH
set terminal postscript eps color enhanced
#fontfile '~/.fonts/PetitaMedium.ttf' 26
set size 1.4,1.8
set output 'perfs_conserv.eps'
set pointsize 5
set key right nobox
set style line 1 lt rgb "red" lw 4 ps 2
set style line 2 lt rgb "orange" lw 4 ps 2
set style line 3 lt rgb "green" lw 4 ps 2
set style line 4 lt rgb "cyan" lw 4 ps 2
set style line 5 lt rgb "blue" lw 4 ps 2
set style line 6 lt rgb "violet" lw 4 ps 2
set style line 7 lt rgb "black" lw 4 ps 2
set style line 8 lt rgb "brown" lw 4 ps 2
set grid
set logscale x 10
#set logscale y 10
#set ytics 0,100,1000 font "PetitaMedium,30"
set ytics 2,2,14 font "PetitaMedium,30"
set title "SCRIP Conservative ORCA025->T359\n Intel Broadwell, 40 cores per node" font "PetitaMedium,30"
plot [10:12000] [0:16] 'conserv.dat'
u ($1):($12) title "reference" with lp ls 5, '' \
u ($1):($3) title "1-MPI/40-OpenMP" with lp ls 1, '' \
u 1:(40*11.6/($1)) title "ideal" with lp ls 7, '' \
u ($1):($4) title "2-MPI/20-OpenMP" with lp ls 2, '' \
u ($1):($2) title "1-MPI/80-OpenMP" with lp ls 3

