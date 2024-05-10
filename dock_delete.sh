# Delete docker containers
for ((i=1; i<=100; i++)); do
	docker rm -f r${i};
        rm -f /var/run/netns/r${i}
done

