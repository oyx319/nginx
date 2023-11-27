#!/bin/bash
# 使用方法: 
#	1、 ./nginx.sh <nginx安装目录>
# 	2、在nginx安装目录执行该文件
#	3、如果是yum安装的话，进入到/etc/nginx，执行脚本即可

NGINX_HOME=$1
OUTPUT_BASEDIR="chinagdn_nginx"
OUTPUT_DIR="`pwd`/$OUTPUT_BASEDIR" 
ISRPM=0
if [  -z $NGINX_HOME ]
then
	NGINX_HOME=`pwd`
fi

if [ $NGINX_HOME == "/etc/nginx" ]
then
	ISRPM=1
fi


if [ ! -f "$NGINX_HOME/nginx.conf" ]
then
	echo "nginx.conf Is Not Found!"
fi


if [ -d $OUTPUT_DIR ]
then
	rm -rf $OUTPUT_DIR
fi
mkdir $OUTPUT_DIR

echo "[>]Running User:" &>> "$OUTPUT_DIR/output.log"
ps -aux|grep nginx &>> "$OUTPUT_DIR/output.log"

echo "[>]Version:" >> "$OUTPUT_DIR/output.log"
if [ $ISRPM == 1 ]
then 
	nginx -V   &>> "$OUTPUT_DIR/output.log"
else
	$NGINX_HOME/sbin/nginx -V &>> "$OUTPUT_DIR/output.log"
fi

echo "[>]File Permission:" >> "$OUTPUT_DIR/output.log"
if [ $ISRPM  == 0 ]
then
	ls -al  $NGINX_HOME >> "$OUTPUT_DIR/output.log"
fi

cp -ar $NGINX_HOME/conf.d $OUTPUT_DIR

tar  -zcf "${OUTPUT_BASEDIR}.tar.gz" $OUTPUT_BASEDIR 
rm -rf $OUTPUT_DIR 

