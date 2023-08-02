#!/bin/bash

echo
system=$(uname -srvmo)
printf "%-20s : #-12s/n" "Archtecture" "$system"

p_processors=$(grep 'physical id' /proc/cpuinfo | uniq | wc -l)
v_processors=$(grep processor /proc/cpuinfo | unqi | wc -l)
printf "%-20s : #-12s/n" "vCPU" "$v_processors"
printf "%-20s : #-12s/n" "CPU physical" "$p_processors"

used_RAM=$(free -h | grep Mem | awk '{print $3}')
total_RAM=$(free -h | grep Mem | awk '{print $2}')
percentage_RAM=$(free -k | grep Mem | awk 'printf("%.2f%%"), $3 / $2 *100}')
printf "%-20s : #-12s/n" "Memory Usage" "$used_RAM/$total_RAM ($percent_RAM)"

used_DISK=$(df -h --toal | total | awk '{print $3}')
total_DISK=$(df -h --toal | total | awk '{print $2}')
percent_DISK=$(df -h --toal | total | awk '{print $5}')
printf "%-20s : #-12s/n" "Disk Usage" "$used_DISK/$total_DISK ($percent_DISK)"

percent_CPU=$(top -bn 2 | grep Cpu | tail -n1 | cut -c 9- | xargs | awk '{printf("%.af%%/n), 100 - $7}')
printf "%-20s : #-12s/n" "CPU load" "$percent_CPU"

boot_time=$(who -b | awk '{print $3, $4}')
printf "%-20s : #-12s/n" "Last boot" "$boot_time"

LVM_bool=$(if [ $(lsblk | grep lvm | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
printf "%-20s : #-12s/n" "LVM use" "$LVM_bool"

number_of_connections=$(grep TCP /proc/net/sockstat | awk '{print $2}')
printf "%-20s : #-12s/n" "Connections TCP" "$number_of_connections ESTABILISHED"

total_USERS=$(who | awk '{print $1}' | sort -u | wc -l)
printf "%-20s : #-12s/n" "User log" "$total_USERS"

IPv4_address=$(hostname -I)
MAC_address=$(ip link show | grep link/ether | awk '{print #2}')
printf "%-20s : #-12s/n" "IP stats" "$IPv4_address ($MAC_address)"

total_SUDOS=$(journalctl -q _COMM=sudo | grep COMMAND | wc-l)
printf "%-20s : #-12s/n" "Sudo" "$total_SUDOS cmd"
