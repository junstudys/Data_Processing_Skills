#!/bin/bash
#指定列分割文本文件数据(csv,txt等)
#输入文件名，如xxx.csv
read -p "Enter Filename:" filename
##输入要分拆的列数，如4
read -p "Enter Column:" col
read -p "Is Time Type:" is_time_type

##csv第一行为表头
list=$(head -1 $filename)

# 非时间样式，正常拆分/时间样式，截取日、月、或者年
if [ $is_time_type -eq 0 ]
then
  ##循环数组
  for i in `cat $filename | awk -F"," '{print $'$col'}' | sort | uniq`
  do
  ##找出符合条件的记录并写入数据，目前主要是csv格式数据$$
  cat $filename | awk -F"," '{if ($'$col'=="'${i}'") print $0}'> $i.csv
  ##插入表头
  sed -i '1i\'${list[@]}'' $i.csv
  done
else
  ##时间模式拆分
  #read -p "Enter Year,Month,Day(y,m,d):" time_type
  for i in `cat $filename | awk -F"," '{print substr($'$col',0,7)}' | sort | uniq`
  do
  ##找出符合条件的记录并写入数据，目前主要是csv格式数据
  cat $filename | awk -F"," '{if (substr($'$col',0,7)=="'${i}'") print $0}'> $i.csv
  ##插入表头
  sed -i '1i\'${list[@]}'' $i.csv
  done
fi