set logscale x
set xlabel "Frequency (Hz)"
set ylabel "Magnitude (dB)"
set y2label "Phase (degrees)"
set y2range [-360:360]
set y2tics 60
set ytics nomirror
set y2tics
set grid
set key top right
set title "Bode Plot"

set terminal pngcairo size 1600,1200
set output "bode_plot.png"

plot 'bode_data.txt' using 1:2 with lines title 'Magnitude', \
     'bode_data.txt' using 1:3 with lines axis x1y2 title 'Phase'
