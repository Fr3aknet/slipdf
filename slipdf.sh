#!/bin/bash

clear
mkdir /tmp/.slipdf

#INDEX
echo -n URL:
read url
wget --output-document=/tmp/.slipdf/index $url
index=/tmp/.slipdf/index

#Baixada de fotos JPG
numdiapos=`cat $index|grep '<img class=\"slide\_image'|grep -o 'data\-full=.*'|cut -d'"' -f2|wc -l`
contdwl=1
pdfordre=10

while [ $contdwl -le $numdiapos ]
do 
	imgdwl=`cat $index|grep '<img class=\"slide\_image'|grep -o 'data\-full=.*'|cut -d'"' -f2|head -n$contdwl|tail -n1`
	wget --output-document=/tmp/.slipdf/$pdfordre.jpg $imgdwl
	contdwl=`expr $contdwl + 1`
	pdfordre=`expr $pdfordre + 1`
done

#JPG to PDF
echo -n OUTPUT:
read pdfoutput
convert /tmp/.slipdf/*.jpg $pdfoutput

rm -r /tmp/.slipdf
