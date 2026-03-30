#!/bin/bash

cd projeto
vtest=0
tbvtest=0
vhtest=0
script_test=0
mdtxt_test=0


for arquivo in *tb.v; do
	if [ "$arquivo" ]; then
                 mkdir  tb
                tbvtest=1
                break
        fi
done



if [ "$tbvtest" -eq 1 ]; then
        for arquivo in *tb.v; do
                mv "$arquivo"  tb/
        done
fi

# Fim da extensão "tb.v"

for arquivo in *.v; do
	if [ "$arquivo" ]; then
 		 mkdir src
		vtest=1	
		break
	fi
done
if [ "$vtest" -eq 1 ]; then
	for arquivo in *.v; do
        	mv "$arquivo"  src/   
	done      
fi

#Fim da extensão .v

for arquivo in *.vh; do
	if [ "$arquivo" ]; then
 		 mkdir include
		vhtest=1
		break
	fi
done
if [ "$vhtest" -eq 1 ]; then
	for arquivo in *.vh; do
        	mv "$arquivo"  include/
	done
fi

#Fim da extensão vh
   
for arquivo in *.tcl *.do *.sh; do
    if [  "$arquivo" ]; then
        mkdir script
        script_test=1
        break
    fi
done

if [ "$script_test" -eq 1 ]; then
    for arquivo in *.tcl *.do *.sh; do
        if [ "$arquivo" ]; then
            mv "$arquivo" script/
        fi
    done
fi

#Fim das extensões tcl, do e sh

for arquivo in *.md *.txt; do
    if [  "$arquivo" ]; then
        mkdir docs
        mdtxt_test=1
        break
    fi
done

if [ "$mdtxt_test" -eq 1 ]; then
    for arquivo in *.md *.txt; do
        if [ "$arquivo" ]; then
            mv "$arquivo" docs/
        fi
    done
fi

#Fim das extensões md e txt


