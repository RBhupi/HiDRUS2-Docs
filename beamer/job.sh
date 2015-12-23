#!/bin/bash

# Example submission of PBS jobs in a loop

NUMBERS=$(seq 1 100) # Create an array of seed values from 1 to NSEEDS



read -p "If you want to submit the job with ensemble IDs 
$NUMBERS then type YeSs.
" RESP

if [ "$RESP" = "YeSs" ]; then
  echo "working on it ..."
else
  echo "Not submitting the jobs."
  exit 0
fi


# Loop through the different seed values and submit a run for each

for NUM in ${NUMBERS}
do
	# set the job name
	NAME=h2pp${NUM}
	echo "Submitting: ${NAME}"
	
	# Build a string called PBS which contains the instructions for your run
	
	PBS="#!/bin/bash\n\
	#PBS -N ${NAME}\n\
	#PBS -P k10\n\
   	#PBS -q normal\n\
   	#PBS -l walltime=10:00:00\n\
   	#PBS -l mem=500MB\n\
   	#PBS -l wd\n\
	./hidrus2 ./config.txt ${NUM}"

	
	# Echo the string PBS to the function qsub, which submits it as a cluster job for you
	# A small delay is included to avoid overloading the submission process
	
	echo -e ${PBS} | qsub 
	sleep 0.5
	echo "done."

done

