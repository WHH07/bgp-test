#for((i=1;i<=100;i++)); do
#	mkdir etc/r"${i}"
#done;

for((i=1;i<=100;i++)); do
	bgp_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r$i
router bgp $i
    bgp router-id 172.11.0.$i
    timers bgp 1 3
    neighbor 192.168.$((i+90)).$((i-10)) remote-as $((i-10))
    neighbor 192.168.$((i+90)).$((i-10)) timers connect 5
    neighbor 192.168.$((i+100)).$((i+10)) remote-as $((i+10))
    neighbor 192.168.$((i+100)).$((i+10)) timers connect 5
    neighbor 192.168.$((i-1)).$((i-1)) remote-as $((i-1))
    neighbor 192.168.$((i-1)).$((i-1)) timers connect 5
    neighbor 192.168.$i.$((i+1)) remote-as $((i+1))
    neighbor 192.168.$i.$((i+1)) timers connect 5
    network 192.168.$((i+90)).0/24
    network 192.168.$((i+100)).0/24
    network 192.168.$i.0/24
    network 192.168.$((i-1)).0/24
    neighbor 192.168.$((i+90)).$((i-10)) bfd
    neighbor 192.168.$((i+100)).$((i+10)) bfd
    neighbor 192.168.$((i-1)).$((i-1)) bfd 
    neighbor 192.168.$i.$((i+1)) bfd                          
line vty
!"
	echo "$bgp_conf" > etc/r"$i"/bgpd.conf

	bfd_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r$i
bfd
 peer 192.168.$((i+90)).$((i-10))
  detect-multiplier 3
  receive-interval 10
  transmit-interval 10
 peer 192.168.$((i+100)).$((i+10))
  detect-multiplier 3
  receive-interval 10
  transmit-interval 10
 peer 192.168.$((i-1)).$((i-1))
  detect-multiplier 3
  receive-interval 10
  transmit-interval 10
 peer 192.168.$i.$((i+1))
  detect-multiplier 3
  receive-interval 10
  transmit-interval 10
line vty
!"
	echo "$bfd_conf" > etc/r"$i"/bfdd.conf

	zeb="ip forwarding
ipv6 forwarding"

	echo "$zeb" > etc/r"$i"/zebra.conf	
done

#r1
bgp_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r1
router bgp 1
    bgp router-id 172.11.0.1
    timers bgp 1 3
    neighbor 192.168.1.2 remote-as 2
    neighbor 192.168.1.2 timers connect 5
    neighbor 192.168.101.11 remote-as 11
    neighbor 192.168.101.11 timers connect 5
    network 192.168.1.0/24
    network 192.168.101.0/24
    neighbor 192.168.1.2 bfd
    neighbor 192.168.101.11 bfd
line vty
!"

echo "$bgp_conf" > etc/r1/bgpd.conf

#r10
bgp_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r10
router bgp 10
    bgp router-id 172.11.0.10
    timers bgp 1 3
    neighbor 192.168.9.9 remote-as 9
    neighbor 192.168.9.9 timers connect 5
    neighbor 192.168.110.20 remote-as 20
    neighbor 192.168.110.20 timers connect 5
    network 192.168.9.0/24
    network 192.168.110.0/24
    neighbor 192.168.9.9 bfd
    neighbor 192.168.110.20 bfd
line vty
!"

echo "$bgp_conf" > etc/r10/bgpd.conf

#r91
bgp_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r91
router bgp 91
    bgp router-id 172.11.0.91
    timers bgp 1 3
    neighbor 192.168.181.81 remote-as 81
    neighbor 192.168.181.81 timers connect 5
    neighbor 192.168.91.92 remote-as 92
    neighbor 192.168.91.92 timers connect 5
    network 192.168.181.0/24
    network 192.168.91.0/24
    neighbor 192.168.181.81 bfd
    neighbor 192.168.91.92 bfd
line vty
!"

echo "$bgp_conf" > etc/r91/bgpd.conf

#r100
bgp_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r100
router bgp 100
    bgp router-id 172.11.0.100
    timers bgp 1 3
    neighbor 192.168.99.99 remote-as 99
    neighbor 192.168.99.99 timers connect 5
    neighbor 192.168.190.90 remote-as 90
    neighbor 192.168.190.90 timers connect 5
    network 192.168.99.0/24
    network 192.168.190.0/24
    neighbor 192.168.99.99 bfd
    neighbor 192.168.190.90 bfd
line vty
!"

echo "$bgp_conf" > etc/r100/bgpd.conf


#上边
for((i=2;i<=9;i++)); do
	    bgp_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r$i
router bgp $i
    bgp router-id 172.11.0.$i
    timers bgp 1 3
    neighbor 192.168.$((i+100)).$((i+10)) remote-as $((i+10))
    neighbor 192.168.$((i+100)).$((i+10)) timers connect 5
    neighbor 192.168.$((i-1)).$((i-1)) remote-as $((i-1))
    neighbor 192.168.$((i-1)).$((i-1)) timers connect 5
    neighbor 192.168.$i.$((i+1)) remote-as $((i+1))
    neighbor 192.168.$i.$((i+1)) timers connect 5
    network 192.168.$((i+100)).0/24
    network 192.168.$((i-1)).0/24
    network 192.168.$i.0/24
    neighbor 192.168.$((i+100)).$((i+10)) bfd
    neighbor 192.168.$((i-1)).$((i-1)) bfd
    neighbor 192.168.$i.$((i+1)) bfd		    
line vty
!"
    echo "$bgp_conf" > etc/r"$i"/bgpd.conf
done

#左边
for((i=11;i<=81;i+=10)); do
            bgp_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r$i
router bgp $i
    bgp router-id 172.11.0.$i
    timers bgp 1 3
    neighbor 192.168.$((i+90)).$((i-10)) remote-as $((i-10))
    neighbor 192.168.$((i+90)).$((i-10)) timers connect 5
    neighbor 192.168.$((i+100)).$((i+10)) remote-as $((i+10))
    neighbor 192.168.$((i+100)).$((i+10)) timers connect 5
    neighbor 192.168.$i.$((i+1)) remote-as $((i+1))
    neighbor 192.168.$i.$((i+1)) timers connect 5
    network 192.168.$((i+90)).0/24
    network 192.168.$((i+100)).0/24
    network 192.168.$i.0/24
    neighbor 192.168.$((i+90)).$((i-10)) bfd
    neighbor 192.168.$((i+100)).$((i+10)) bfd
    neighbor 192.168.$i.$((i+1)) bfd
line vty
!"
    echo "$bgp_conf" > etc/r"$i"/bgpd.conf
done

#右边
for((i=20;i<=90;i+=10)); do
            bgp_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r$i
router bgp $i
    bgp router-id 172.11.0.$i
    timers bgp 1 3
    neighbor 192.168.$((i+90)).$((i-10)) remote-as $((i-10))
    neighbor 192.168.$((i+90)).$((i-10)) timers connect 5
    neighbor 192.168.$((i+100)).$((i+10)) remote-as $((i+10))
    neighbor 192.168.$((i+100)).$((i+10)) timers connect 5
    neighbor 192.168.$((i-1)).$((i-1)) remote-as $((i-1))
    neighbor 192.168.$((i-1)).$((i-1)) timers connect 5
    network 192.168.$((i+90)).0/24
    network 192.168.$((i+100)).0/24
    network 192.168.$((i-1)).0/24
    neighbor 192.168.$((i+90)).$((i-10)) bfd
    neighbor 192.168.$((i+100)).$((i+10)) bfd
    neighbor 192.168.$((i-1)).$((i-1)) bfd
line vty
!"
    echo "$bgp_conf" > etc/r"$i"/bgpd.conf
done

#下边
for((i=92;i<=99;i++)); do
            bgp_conf="!
frr version 7.2.1
frr defaults traditional
!
hostname r$i
router bgp $i
    bgp router-id 172.11.0.$i
    timers bgp 1 3
    neighbor 192.168.$((i+90)).$((i-10)) remote-as $((i-10))
    neighbor 192.168.$((i+90)).$((i-10)) timers connect 5
    neighbor 192.168.$((i-1)).$((i-1)) remote-as $((i-1))
    neighbor 192.168.$((i-1)).$((i-1)) timers connect 5
    neighbor 192.168.$i.$((i+1)) remote-as $((i+1))
    neighbor 192.168.$i.$((i+1)) timers connect 5
    network 192.168.$((i+90)).0/24
    network 192.168.$i.0/24
    network 192.168.$((i-1)).0/24
    neighbor 192.168.$((i+90)).$((i-10)) bfd
    neighbor 192.168.$((i-1)).$((i-1)) bfd
    neighbor 192.168.$i.$((i+1)) bfd
line vty
!"
    echo "$bgp_conf" > etc/r"$i"/bgpd.conf
done

