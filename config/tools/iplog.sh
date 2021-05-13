#sudo cat /var/log/nginx/access.log | grep "hls" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq > ~/ips.txt
sudo cat /var/log/nginx/yi.log | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq > ~/ips.txt
