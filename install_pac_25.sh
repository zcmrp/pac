setenforce 0
ulimit -n 655350
echo "* soft nofile 655350" >> /etc/security/limits.conf
echo "* hard nofile 655350" >> /etc/security/limits.conf
echo "alias net-pf-10 off" >> /etc/modprobe.d/dist.conf
echo "alias ipv6 off" >> /etc/modprobe.d/dist.conf
killall -9 sendmail
/etc/init.d/postfix stop
chkconfig --level 2345 postfix off
chkconfig --level 2345 sendmail off
yum -y install squid wget
wget https://raw.githubusercontent.com/zcmrp/pac/master/squid/centos-squid.conf -O /etc/squid/squid.conf
echo "root:tpTc6oM5qYxpA" >> /etc/squid/passwd
mkdir -p /var/cache/squid
chmod -R 777 /var/cache/squid
squid -z
service squid restart
chkconfig --level 2345 squid on
iptables -t nat -F
iptables -t nat -X
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
iptables -t nat -P OUTPUT ACCEPT
iptables -t mangle -F
iptables -t mangle -X
iptables -t mangle -P PREROUTING ACCEPT
iptables -t mangle -P INPUT ACCEPT
iptables -t mangle -P FORWARD ACCEPT
iptables -t mangle -P OUTPUT ACCEPT
iptables -t mangle -P POSTROUTING ACCEPT
iptables -F
iptables -X
iptables -P FORWARD ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t raw -F
iptables -t raw -X
iptables -t raw -P PREROUTING ACCEPT
iptables -t raw -P OUTPUT ACCEPT
service iptables save
