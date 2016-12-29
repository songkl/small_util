#!/bin/sh

update_iptables() {

	wget -q -O cn.zone \
	http://www.ipdeny.com/ipblocks/data/countries/cn.zone

	iptables -t nat -A prerouting -p tcp -j SHADOWSOCKS
	iptables -t nat -A OUTPUT -p tcp -j SHADOWSOCKS

	while read ln; do
		iptables -t nat -A SHADOWSOCKS -d $ln -j RETURN
	done < cn.zone

	iptables --flush

}

update_iptables &
