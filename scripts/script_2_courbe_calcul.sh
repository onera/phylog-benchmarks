# $1 = input file1
# $2 = input file2
# $3 = legende pour file1
# $4 = legende pour file2
# $5 = nom du bench (pour le titre du graphique)
# $6 = nom du processeur
# $7 = min
# $8 = max

if [ $# -eq 0 ]; then 
    echo "*** Error: input files are missing"
    exit 0
fi
if [ $# -eq 1 ]; then 
    echo "*** Error: input file2 is missing"
    exit 0
fi
if [ ! -f $1 ]; then
    echo "*** Error: $1 not found"
    exit 0
fi
if [ ! -f $2 ]; then
    echo "*** Error: $2 not found"
    exit 0
fi
if [ ! -d Courbes ]; then
    mkdir Courbes
fi
if [ $# -eq 2 ]; then 
    echo "*** Warning: legends are missing"
    echo "*** Warning: graphic name is missing"
    echo "*** Warning: processor name is missing"
    LEG1=$1
    LEG2=$2
    NAME="NAME"
    PROC="PROC"
fi
if [ $# -eq 3 ]; then 
    echo "*** Warning: legend2 is missing"
    echo "*** Warning: graphic name is missing"
    echo "*** Warning: processor name is missing"
    LEG1=$3
    LEG2=$2
    NAME="NAME"
    PROC="PROC"
fi
if [ $# -eq 4 ]; then 
    LEG1=$3
    LEG2=$4
    echo "*** Warning: graphic name is missing"
    echo "*** Warning: processor name is missing"
    NAME="NAME"
    PROC="PROC"
fi
if [ $# -eq 5 ]; then 
    LEG1=$3
    LEG2=$4
    NAME=$5
    echo "*** Warning: processor name is missing"
    PROC="PROC"
fi
if [ $# -eq 6 ]; then 
    LEG1=$3
    LEG2=$4
    NAME=$5
    PROC=$6
fi
if [ $# -gt 6 ]; then 
    LEG1=$3
    LEG2=$4
    NAME=$5
    PROC=$6
fi

gnuplot -persist << EOFMarke
        file1 = "$1"
        file2 = "$2"

        stats file1 us 9 name "FILE1" nooutput
        stats file2 us 9 name "FILE2" nooutput

        set title '$NAME (proc $PROC)' noenhanced

        set output "Courbes/$1$2.jpg"   
        set key bmargin
        set terminal jpeg  
        set xlabel 'Iterations'
        set ylabel 'Execution time (in micro-seconds)'

	plot  [] [$7:$8] file1 using 9 w lp linetype 1 pointtype 1 linecolor 1 title '$LEG1' noenhanced,\
              file2 using 9 w lp linetype 1 pointtype 2 linecolor 2 title '$LEG2' noenhanced
              #FILE1_mean w l linetype 0 linecolor 1 linewidth 1 title 'Moyenne $LEG1',\
              #FILE2_mean w l linetype 0 linecolor 2 linewidth 1 title 'Moyenne $LEG2'

EOFMarke
courbe=Courbes/$1$2.jpg

host=`hostname`
if [ $host = "Mazel.local" ]; then
    open $courbe
else
    evince $courbe
fi
