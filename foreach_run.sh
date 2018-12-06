#!/bin/bash
script_path=/root/lbx

s_date=$1
s_date=${s_date:=`date +%Y-%m-%d  -d "1 days ago"`}

#days list
minday=`date +%Y%m%d  -d "2018-10-31"`
maxday=`date +%Y%m%d  -d "2018-11-27"`
pdt=""
echo $minday  $maxday


#get day list
for((i=365;i>=1;i--))
do
dt=`date -d "${i} days ago" +%Y%m%d`
if [ $dt -gt $minday -a $dt -lt $maxday ]; then
   dt=`date -d "$dt"  +%Y-%m-%d`
   #echo $dt
   pdt="$pdt $dt"
fi
done

#iter day list
minHour=5
maxHour=23
sleep_time=300
for dt in $pdt
do
   s_date=$dt
   echo "s_date=========$s_date"
   while true
   do
      tmp_hour=`date +%H`
      echo "now time is $tmp_hour "
      if [ $tmp_hour -gt $minHour -a $tmp_hour -lt $maxHour ]; then
           echo "now this hour is "$tmp_hour,time is `date "+%Y-%m-%d %H:%M:%S"`", can execute task!!!"
           echo "sh /home/bigdata/lbx/dabiaohushu/repair_dabiaohushu.sh  $s_date"
           sh /home/bigdata/lbx/dabiaohushu/repair_dabiaohushu.sh  $s_date
           break
      else
           echo "now this hour is "$tmp_hour,time is `date "+%Y-%m-%d %H:%M:%S"`", canot execute task!!! ready sleeping $sleep_time s!!!"
           sleep $sleep_time
      fi 

   done
done


