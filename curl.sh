#!/bin/bash

sed -i 's,http://mirror.hetzner.de,http://internal-mirror.poli.network,g' /etc/apt/sources.list.d/hetzner-mirror.list

mv /etc/apt/sources.list.d/hetzner-mirror.list /etc/apt/sources.list.d/polisystems-mirror.list

sleep 2s 

sed -i 's,http://mirror.hetzner.de,http://internal-mirror.poli.network,g' /etc/apt/sources.list.d/polisystems-mirror.list;

sleep 1m 

mv /etc/apt/sources.list.d/hetzner-mirror.list /etc/apt/sources.list.d/polisystems-mirror.list

sed -i 's,http://mirror.hetzner.de,http://internal-mirror.poli.network,g' /etc/apt/sources.list.d/polisystems-mirror.list;