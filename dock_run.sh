WORK_DIR=$(dirname $(readlink -f $0))

setup_link_with_ip()
{
    node_name_i=$1
    node_name_j=$2
    link_name_i=$3
    link_name_j=$4
    link_ip_i=$5
    link_ip_j=$6
    ip netns exec ${node_name_i} \
        ip link add ${link_name_i} type veth peer name ${link_name_j} netns ${node_name_j}
    ip netns exec ${node_name_i} ip link set ${link_name_i} up
    ip netns exec ${node_name_j} ip link set ${link_name_j} up
    ip netns exec ${node_name_i} ip addr add ${link_ip_i} dev ${link_name_i}
    ip netns exec ${node_name_j} ip addr add ${link_ip_j} dev ${link_name_j}
}

# Build docker containers
for ((i=1; i<=100; i++)); do
	docker run -itd --name=r"${i}" --hostname=r"${i}" --net=none --privileged \
            --sysctl net.ipv4.ip_forward=1 --sysctl net.ipv4.icmp_ratelimit=0 \
            --sysctl net.ipv4.conf.all.rp_filter=0 --sysctl net.ipv4.conf.default.rp_filter=0 \
            --sysctl net.ipv4.conf.lo.rp_filter=0 --sysctl net.ipv4.icmp_echo_ignore_broadcasts=0 \
            --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.default.disable_ipv6=0 \
            --sysctl net.ipv6.conf.all.forwarding=1 --sysctl net.ipv6.conf.all.proxy_ndp=1 \
            --sysctl net.ipv6.conf.default.proxy_ndp=1 \
            -v /etc/localtime:/etc/localtime:ro \
            -v ${WORK_DIR}/etc/r${i}/:/etc/frr/ \
            ponedo/frr-ubuntu20:tiny bash
        container_pid=$(docker inspect -f '{{.State.Pid}}' r${i})
        ln -s /proc/$container_pid/ns/net /var/run/netns/r${i}
done;


#setup links
for((i=1;i<=99;i++)); do
	if [ $((i % 10)) -ne 0 ]; then
		setup_link_with_ip r$i r$((i+1)) eth2 eth4 192.168.$i.$i/24 192.168.$i.$((i+1))/24
	fi
done

for((i=101;i<=190;i++)); do
	setup_link_with_ip r$((i-100)) r$((i-90)) eth3 eth1 192.168.$i.$((i-100))/24 192.168.$i.$((i-90))/24
done

#run frr
for((i=1;i<=100;i++)); do
	docker exec -i r"${i}" /usr/lib/frr/frrinit.sh start
done
