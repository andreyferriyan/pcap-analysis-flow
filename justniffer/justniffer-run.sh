#!/bin/bash
# README
# 
# Work in the same folder with justniffer-v*.conf and justniffer-rpp-processor.sh
#
# A simple wrapper to run justniffer with configurations and excutive file to
# to process each output line.
#
# The running logic is equal to:
#     justniffer-run.sh (justniffer-v*.conf) | justniffer-rpp-processor.sh
# 
# by chenxm
# 2013-01

function printinfo(){
	echo "Usage: $0 -o <outputfile> <pcapfile>"
	echo "  -o          The output file name"
	echo "  pcapfile    The pcap file to be processed"
}

if [ $# -lt 1 ]; then
	printinfo && exit 1;
fi

# Parsing output file
outputfile="justniffer.out"
while getopts o: par
do
	case "$par" in
		o)	outputfile="$OPTARG";;
		[?])	printinfo; exit 1;;
	esac
done

shift $(($OPTIND-1)) && input="$@"
if [ -z $input ]; then
	printinfo && exit 1;
fi

# Run justniffer
script_home=`dirname $0`
justniffer -f $input -F -c $script_home/justniffer-v1.1.conf > $outputfile

exit 0;
