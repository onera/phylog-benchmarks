# $1 = input file
# $2 = legende
# $3 = nom du bench (pour le titre du graphique)
# $4 = nom du processeur
# $4 = min
# $6 = max

if [ $# -eq 0 ]; then 
    echo "*** Error: input file is missing"
    exit 0
fi
if [ ! -f $1 ]; then
    echo "*** Error: $1 not found"
    exit 0
fi
if [ ! -d Courbes ]; then
    mkdir Courbes
fi
if [ $# -eq 1 ]; then 
    echo "*** Warning: legend is missing"
    LEG1=$1
    echo "*** Warning: graphic name is missing"
    NAME=$1
    echo "*** Warning: processor name is missing"
    PROC="XXX"
fi
if [ $# -eq 2 ]; then 
    LEG1=$2
    echo "*** Warning: graphic name is missing"
    NAME=$1
    echo "*** Warning: processor name is missing"
    PROC="XXX"
fi
if [ $# -eq 3 ]; then 
    LEG1=$2
    NAME=$3
    echo "*** Warning: processor name is missing"
    PROC="XXX"
fi
if [ $# -eq 4 ]; then 
    LEG1=$2
    NAME=$3
    PROC=$4
fi
if [ $# -gt 4 ]; then 
    LEG1=$2
    NAME=$3
    PROC=$4
fi

gnuplot -persist << EOFMarke
        file = "$1"

        set title '$NAME (proc $PROC)' noenhanced

        set output "Courbes/$1.jpg"   
        set key bmargin
        set terminal jpeg  
        set xlabel 'Stride'
        set xtics out offset 2.5 ( "1" 0, "2" 20, "4" 40 ,"8" 60,"16" 80 ,"32" 100, "64" 120, "128" 140, "256" 160,"512" 180, "1024" 200, "2048" 220, " " 240)
        set ylabel 'Execution time (in micro-seconds)' noenhanced

	plot  [] [$5:$6] file using 9 w lp linetype 1 pointtype 1 linecolor 1 title '$LEG1' noenhanced

EOFMarke

courbe=Courbes/$1.jpg

host=`hostname`
if [ $host = "Mazel.local" ]; then
    open $courbe
else
    evince $courbe
fi
