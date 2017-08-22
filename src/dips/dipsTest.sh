#!/bin/bash

j=0
nb_concurrent_processes=10
for idxFold in {3..10}
do

	echo "    ====== START: DIPS cv fold: ${idxFold} ======"
	matlab -nodesktop -nosplash -nojvm -r "dipsTest(${subject_id}); exit;"
	((++j == nb_concurrent_processes)) && { j=0; wait; }
	echo "    ====== END: DIPS cv fold: ${idxFold} ======"

done