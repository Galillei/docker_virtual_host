#!/usr/bin/env bash
cat > /etc/hosts << EOF
127.0.0.1       localhost
127.0.1.1       galillei
# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhostaip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF
#for first start
for CID in `docker ps -q`; do
    IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID)
    DOMAIN_NAME=$(docker inspect -f '{{range .Config.Env}}{{println .}}{{end}}'  $CID | tr ' ' '\n' | grep 'DOMAIN_NAME' | sed 's/^.*=//' )
    if [ $DOMAIN_NAME ]
    then
        LINES="$IP  $DOMAIN_NAME"
        echo  $LINES>>/etc/hosts
    fi
done

docker events --filter 'event=start' --filter 'event=stop' | while read event

do
    cat > /etc/hosts << EOF
127.0.0.1       localhost
127.0.1.1       galillei
# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhostaip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF
#for first start
for CID in `docker ps -q`; do
    IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CID)
    DOMAIN_NAME=$(docker inspect -f '{{range .Config.Env}}{{println .}}{{end}}'  $CID | tr ' ' '\n' | grep 'DOMAIN_NAME' | sed 's/^.*=//' )
    if [ $DOMAIN_NAME ]
    then
        LINES="$IP  $DOMAIN_NAME"
        echo  $LINES>>/etc/hosts
    fi
done
done