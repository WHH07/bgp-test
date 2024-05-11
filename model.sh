#!/bin/bash
#检查是否提供了参数
if [ $# -ne 2 ]; then
		echo "Usage: $0 <m> <n>"
			exit 1
fi

m=$1
n=$2

while true; do
	#m个横向链路故障
	nums1=($(shuf -i 1-99 -n $m))
	#n个纵向链路故障
	nums2=($(shuf -i 101-190 -n $n))
	
	#fail横向链路
	for((i=0;i<m;i++)); do
		cur=${nums1[$i]}
		if [ $((cur % 10)) -ne 0 ]; then
			./lc.sh fail r$cur eth2 r$((cur+1)) eth4
		fi
	done
	
	#fail纵向链路
	for((i=0;i<n;i++)); do
		cur=${nums2[$i]}
		./lc.sh fail r$((cur-100)) eth3 r$((cur-90)) eth1
	done
	sleep 5

	#recover横向链路
	for((i=0;i<m;i++)); do
		cur=${nums1[$i]}
		if [ $((cur % 10)) -ne 0 ]; then
			./lc.sh recover r$cur eth2 r$((cur+1)) eth4
		fi	
	done

	#recover纵向链路
	for((i=0;i<n;i++)); do
		cur=${nums2[$i]}	
		./lc.sh recover r$((cur-100)) eth3 r$((cur-90)) eth1
	done
	sleep 5	
done

