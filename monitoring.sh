#!/bin/bash

slptm=$(uptime -s | awk '{print $2}' | awk -F ":" '{print $2%10*60 + $3}')
sleep $slptm

arch=$(uname -a)
cpup=$(grep "physical id" /proc/cpuinfo | wc -l)
vcpu=$(grep "processor" /proc/cpuinfo   | wc -l)
memu=$(free --mega | grep "^Mem:" | awk '{printf"%d/%dMB ", $3 , $2} {printf("(%.2f%%)",$3/$2*100)}')
disku=$(df -h --total | grep total | awk '{printf"%d/%dGb (%s)" , $3 * 1024 , $2, $5}')
cpul=$(mpstat | grep 'all' | awk '{printf"%.2f%%" , 100 - $13}')
lastb=$(uptime -s | awk -F ':' '{print $1 ":" $2}')
lvmu=$(if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]; then echo "yes" ; else echo "no" ; fi)
prn=$(echo "ESTABLISHED")
contcp=$(ss -Ht state established | wc -w)
userlog=$(users | wc -w)
ip=$(hostname -I | awk '{printf" IP %s" , $1}')
ipadma=$(ip a | grep "link/ether" | awk '{printf"(%s)" , $2}')
nucsud=$(journalctl _COMM=sudo | grep "COMMAND" | wc -l |awk '{printf"%s cmd", $1}')

wall "  #Architecture: $arch
        #CPU physical : $cpup
        #vCPU : $vcpu
        #Memory Usage : $memu
        #Disk Usage : $disku
        #CPU load : $cpul
        #Last boot : $lastb
        #LVM use : $lvmu
        #Connections TCP : $contcp $prn
        #User log: $userlog
        #Network: $ip $ipadma
        #Sudo : $nucsud
        "
