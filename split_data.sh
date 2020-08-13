#!/bin/bash
#ָ���зָ��ı��ļ�����(csv,txt��)
#�����ļ�������xxx.csv
read -p "Enter Filename:" filename
##����Ҫ�ֲ����������4
read -p "Enter Column:" col
read -p "Is Time Type:" is_time_type

##csv��һ��Ϊ��ͷ
list=$(head -1 $filename)

# ��ʱ����ʽ���������/ʱ����ʽ����ȡ�ա��¡�������
if [ $is_time_type -eq 0 ]
then
  ##ѭ������
  for i in `cat $filename | awk -F"," '{print $'$col'}' | sort | uniq`
  do
  ##�ҳ����������ļ�¼��д�����ݣ�Ŀǰ��Ҫ��csv��ʽ����$$
  cat $filename | awk -F"," '{if ($'$col'=="'${i}'") print $0}'> $i.csv
  ##�����ͷ
  sed -i '1i\'${list[@]}'' $i.csv
  done
else
  ##ʱ��ģʽ���
  #read -p "Enter Year,Month,Day(y,m,d):" time_type
  for i in `cat $filename | awk -F"," '{print substr($'$col',0,7)}' | sort | uniq`
  do
  ##�ҳ����������ļ�¼��д�����ݣ�Ŀǰ��Ҫ��csv��ʽ����
  cat $filename | awk -F"," '{if (substr($'$col',0,7)=="'${i}'") print $0}'> $i.csv
  ##�����ͷ
  sed -i '1i\'${list[@]}'' $i.csv
  done
fi