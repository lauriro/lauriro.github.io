#!/bin/bash

#if (kill -0 19921) ; then echo alive ; fi

(sleep 25 ; /bin/false) &
my_pid=$!
i=0
while kill -0 $my_pid 2>/dev/null
do
	if ((i%10)) ; then
		echo -n .
	else
		echo -n $i
	fi
    sleep 1
	let i+=1
done

echo ""
echo Oh, it looks like the process is done with $i seconds.
wait $my_pid
my_status=$?
echo The exit status of the process was $my_status


