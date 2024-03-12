# $1 = input file1
# $2 = input file2
# $3 = input file3
# $4 = legende pour file1
# $5 = legende pour file2
# $6 = legende pour file3
# $7 = nom du bench (pour le titre du graphique)
# $8 = nom du processeur
# $9 = min
# $10 = max

if [ $# -eq 0 ]; then 
    echo "*** Error: input files are missing"
    exit 0
fi
if [ $# -eq 1 ]; then 
    echo "*** Error: input file2 is missing"
    echo "*** Error: input file3 is missing"
    exit 0
fi
if [ $# -eq 2 ]; then 
    echo "*** Error: input file3 is missing"
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
if [ ! -f $3 ]; then
    echo "*** Error: $3 not found"
    exit 0
fi
if [ ! -d Courbes ]; then
    mkdir Courbes
fi
if [ $# -eq 3 ]; then 
    echo "*** Warning: legends are missing"
    echo "*** Warning: graphic name is missing"
    echo "*** Warning: processor name is missing"
    LEG1=$1
    LEG2=$2
    LEG3=$3
    NAME="NAME"
    PROC="PROC"
fi
if [ $# -eq 4 ]; then 
    LEG1=$4
    echo "*** Warning: legend2 is missing"
    LEG2=$2
    echo "*** Warning: legend3 is missing"
    LEG3=$3
    echo "*** Warning: graphic name is missing"
    NAME="NAME"
    echo "*** Warning: processor name is missing"
    PROC="PROC"
fi
if [ $# -eq 5 ]; then 
    LEG1=$4
    LEG2=$5
    echo "*** Warning: legend3 is missing"
    LEG3=$3
    echo "*** Warning: graphic name is missing"
    NAME="NAME"
    echo "*** Warning: processor name is missing"
    PROC="PROC"
fi
if [ $# -eq 6 ]; then 
    LEG1=$4
    LEG2=$5
    LEG3=$6
    echo "*** Warning: graphic name is missing"
    NAME="NAME"
    echo "*** Warning: processor name is missing"
    PROC="PROC"
fi
if [ $# -eq 7 ]; then 
    LEG1=$4
    LEG2=$5
    LEG3=$6
    NAME=$7
    echo "*** Warning: processor name is missing"
    PROC="PROC"
fi
if [ $# -eq 8 ]; then 
    LEG1=$4
    LEG2=$5
    LEG3=$6
    NAME=$7
    PROC=$8
fi
if [ $# -gt 9 ]; then 
    LEG1=$4
    LEG2=$5
    LEG3=$6
    NAME=$7
    PROC=$8
fi

gnuplot -persist << EOFMarke
        file1 = "$1"
        file2 = "$2"
        file3 = "$3"

        set title "$NAME (proc $PROC)"

        set output "Courbes/$1$2$3.jpg"   
        set key bmargin
        set terminal jpeg  
        set xlabel 'Stride'
        set xtics out offset 2.5 ( "1" 0, "2" 40, "4" 80 ,"8" 120,"16" 160 ,"32" 200, "64" 240, "128" 280, "256" 320,"512" 360, "1024" 400, "2048" 440, " " 480)
        set ylabel 'Temps en micro-secondes'

	plot  [] [$9:${10}] file1 using 3 w lp linetype 1 pointtype 1 linecolor 1 title '$LEG1',\
              file2 using 3 w lp linetype 1 pointtype 2 linecolor 2 title '$LEG2',\
              file3 using 3 w lp linetype 1 pointtype 3 linecolor 3 title '$LEG3'

EOFMarke
courbe=Courbes/$1$2$3.jpg

host=`hostname`
if [ $host = "Mazel.local" ]; then
    open $courbe
else
    evince $courbe
fi
