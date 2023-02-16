#!/usr/bin/env bash
sysctl -w net.core.rmem_max=2000000 #set UDP Receive Buffer Size
sh /app/sniproxy -c /app/config/config.json
