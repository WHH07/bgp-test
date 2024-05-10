#重启FRR
for((i=1;i<=100;i++));do
	docker exec -i r"${i}" /usr/lib/frr/frrinit.sh restart
done;

