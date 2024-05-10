for ((i=1;i<=99;i++)); do
	if [ $((i%10)) -ne 0 ]; then
		./lc.sh recover r$i eth2 r$((i+1)) eth4
	fi	
done

for ((i=101;i<=190;i++)); do
	./lc.sh recover r$((i-100)) eth3 r$((i-90)) eth1 
done
