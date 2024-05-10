WORK_DIR=$(dirname $(readlink -f $0))

op=$1
node_name_i=$2
link_name_i=$3
node_name_j=$4
link_name_j=$5

usage()
{
	echo "Usage:"
	echo -e "\t$0 COMMAND NODE_NAME_I LINK_NAME_I NODE_NAME_J LINK_NAME_J"
	echo -e "\tCOMMAND could be: \"fail\" or \"recover\""
}

if [ $# != 5 ]; then
	usage
	exit 1
elif [ "${op}" = "fail" ]; then
	ip netns exec ${node_name_i} \
	    tc qdisc replace dev ${link_name_i} root netem loss 100%
	ip netns exec ${node_name_j} \
	    tc qdisc replace dev ${link_name_j} root netem loss 100%
elif [ "${op}" = "recover" ]; then
	ip netns exec ${node_name_i} \
	    tc qdisc del dev ${link_name_i} root
	ip netns exec ${node_name_j} \
	    tc qdisc del dev ${link_name_j} root
else
	echo "Invalid operation ${op}!"
	usage
	exit 1
fi

