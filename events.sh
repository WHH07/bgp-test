#!/bin/bash
#检查是否提供了参数
if [ $# -ne 1 ]; then
	echo "Usage: $0 <n>"
	exit 1
fi

n=$1

while true; do
	# 生成n个范围为1到4之间的随机整数，并保存为数组 nums2
	for ((i=0; i<n; i++)); do
		nums2[$i]=$(( (RANDOM % 4) + 1 ))
	done
	# 生成n个范围为1到100之间的不同的随机整数，并保存为数组 nums1
	 nums1=($(shuf -i 1-100 -n $n))
	for ((i=0;i<n;i++)); do
		num=${nums1[$i]}
		ran=${nums2[$i]}
		if [ $ran -eq 1 ]; then
			next=$((num-10))
			if [ $next -ge 1 ] && [ $next -le 100 ]; then
				./lc.sh fail r"$num" eth1 r"$next" eth3
			fi
		elif [ $ran -eq 2 ]; then
			next=$((num + 1))
			if [ $next -ge 1 ] && [ $next -le 100 ] && [ $((num % 10)) -ne 0  ]; then
				./lc.sh fail r"$num" eth2 r"$next" eth4
			fi
		elif [ $ran -eq 3 ]; then
	        	next=$((num + 10))
			if [ $next -ge 1 ] && [ $next -le 100 ]; then
				./lc.sh fail r"$num" eth3 r"$next" eth1
			fi
		else
			next=$((num - 1))
			if [ $next -ge 1 ] && [ $next -le 100 ] && [ $((num % 10)) -ne 1 ]; then
				./lc.sh fail r"$num" eth4 r"$next" eth2
			fi

		fi
	done
	sleep 5
        for ((i=0;i<n;i++)); do
		num=${nums1[$i]}
		ran=${nums2[$i]}
		if [ $ran -eq 1 ]; then
			next=$((num-10))
			if [ $next -ge 1 ] && [ $next -le 100 ]; then
                                ./lc.sh recover r"$num" eth1 r"$next" eth3
			fi
		elif [ $ran -eq 2 ]; then
			next=$((num + 1))
			if [ $next -ge 1 ] && [ $next -le 100 ] && [ $((num % 10)) -ne 0 ]; then
				./lc.sh recover r"$num" eth2 r"$next" eth4
			fi
		elif [ $ran -eq 3 ]; then
			next=$((num + 10))
			if [ $next -ge 1 ] && [ $next -le 100 ]; then
				./lc.sh recover r"$num" eth3 r"$next" eth1
			fi
		else
			next=$((num - 1))
			if [ $next -ge 1 ] && [ $next -le 100 ] && [ $((num % 10)) -ne 1 ]; then
				./lc.sh recover r"$num" eth4 r"$next" eth2
			fi
		fi
	done
	sleep 5
done


