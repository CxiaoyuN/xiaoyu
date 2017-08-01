#!/bin/sh

APP_PATH='/usr/local/';
ulimit -c 0
rm -rf vnser.sh;
clear;
#初始化退格
stty erase '^H' >> /dev/null

echo -e "\033[35m
+-------------------------------------------------------------------------------+
+                                                                               +
+             \(^o^)/~ Welcome 欢迎使用openvpn一键安装免流脚本~                 +
+           本脚本脚本支持安装：openvpn、mproxy、nginx、php-fpm、mysql等        +
+                                                                               +
+                                                             by: vnser         +
+-------------------------------------------------------------------------------+\033[0m
"
server_ip=`curl -s whatismyip.akamai.com`
echo -e '\n即将开始安装请您做好摇头准备~(～￣▽￣)～
我们将倒数三个数开始安装';
sleep 1;
echo -e "3";
sleep 1;
echo -e "2";
sleep 1;
echo -e "1
";
#清理上次安装残余
echo -e "正在清理系统垃圾残余,请稍等...\n";
killall openvpn nginx php-fpm mysqld mproxy  >/dev/null 2>&1
rm -rf ${APP_PATH}/openvpn ${APP_PATH}/nginx ${APP_PATH}/php ${APP_PATH}/mysql /root/*  >/dev/null 2>&1
echo -e "\n\033[31m 清理系统垃圾残余成功 \033[0m"

echo -e "正在开始初始化gcc、gcc-c++、openssl-devel、unzip...\n"
sleep 1;
#编译gcc gcc++
yum install gcc -y
yum install gcc-c++ -y
yum install -y openssl-devel
yum install pam-devel.x86_64 -y
yum install -y zip expect iptables iptables-services
yum install unzip -y
clear;

#处理网络模块
echo -e "\n\033[33m正在配置ipatbles防火墙...\033[0m"
#禁用centos7.+firewalld防火墙
systemctl stop firewalld.service >/dev/null 2>&1
systemctl disable firewalld.service >/dev/null 2>&1
#配置iptables防火墙
echo -e "\n\033[31m 开始配置iptables防火墙 \033[0m"
iptables -t nat -A POSTROUTING -s 10.8.0.0/24  -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -j MASQUERADE
service iptables save >/dev/null 2>&1
service iptables restart >/dev/null 2>&1

echo -e "\n\033[34m正在开启iptables防火墙转发...\033[0m";
echo 'net.ipv4.ip_forward = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.default.accept_source_route = 0
kernel.sysrq = 0
kernel.core_uses_pid = 1
net.ipv4.tcp_syncookies = 1
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.shmmax = 68719476736
kernel.shmall = 4294967296' > /etc/sysctl.conf
sysctl -p &> /dev/null
echo -e "\n\033[31m 配置iptables防火墙成功 \033[0m"

#安装openssl
if [ ! -d "${APP_PATH}openssl" ] ;then
	cd ${APP_PATH}
	echo -e "\n\033[35m正在安装openssl,请稍等(1-3分钟)...\033[0m"
	rm -rf /usr/bin/pod2man 
	wget http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/openssl-1.0.0e.tar.gz  >/dev/null 2>&1
	tar -xvzf openssl-1.0.0e.tar.gz  >/dev/null 2>&1
	cd openssl-1.0.0e
	./config --prefix=/usr/local/openssl  >/dev/null 2>&1
	 make install  >/dev/null 2>&1
else
	echo -e "\n\033[31m很抱歉,您的openssl已安装\033[0m"
fi;
echo -e "\n\033[31m openssl安装成功 \033[0m"

#安装lzo
cd ${APP_PATH}
echo -e "\n\033[35m正在安装lzo,请稍等(1-3分钟)...\033[0m"
wget http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/lzo-2.03.tar.gz  >/dev/null 2>&1
tar -xvzf lzo-2.03.tar.gz  >/dev/null 2>&1
cd lzo-2.03
./configure --prefix=/usr/local  >/dev/null 2>&1
 make install  >/dev/null 2>&1
 echo -e "/lib\n/lib64\n/usr/lib\n/usr/lib64\n/usr/local/lib\n/usr/local/lib64" >> /etc/ld.so.conf
 ldconfig 
echo -e "\n\033[31m lzo安装成功 \033[0m"

#安装openvpn
echo -e "\n\033[31m 开始配置Openvpn \033[0m"
if [ ! -d "${APP_PATH}openvpn" ] ;then
	#下载mproxy转接代理
	echo -e "\n\033[33m正在编译mproxy、http转接代理...\033[0m"
	cd ~
	wget http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/mproxy.c &> /dev/null
	gcc -o mproxy mproxy.c
	chmod 777 ./mproxy &> /dev/null
	
	echo -e '\n\033[36m正在编译安装openvpn,请稍等(大概需要20-30秒)...\033[0m'
	cd ${APP_PATH}
	wget http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/openvpn-2.3.12.tar.gz  >/dev/null 2>&1
	tar -xvzf openvpn-2.3.12.tar.gz  >/dev/null 2>&1
	cd openvpn-2.3.12
	./configure --prefix=/usr/local/openvpn  >/dev/null 2>&1
	 make install >/dev/null 2>&1
	#安装easy-rsa文件
	wget http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/easy-rsa.zip  >/dev/null 2>&1
	unzip easy-rsa.zip -d easy-rsa &> /dev/null
	cd ./easy-rsa
	chmod 777 *
	
	#生成证书
	echo -e "\n\033[31m正在创建openvpn证书,请稍等(大概1-3分钟)...\033[0m"
	source ./vars &> /dev/null
	./clean-all &> /dev/null
	./create_client_cert &> /dev/null
	./create_server_cert &> /dev/null
	./build-dh &> /dev/null
	${APP_PATH}openvpn/sbin/openvpn --genkey --secret ./keys/tls-auth.key 
	#证书移动
	mkdir -p ${APP_PATH}openvpn/cert
	cp -rf ./keys/ca.crt ${APP_PATH}openvpn/cert/
	cp -rf ./keys/server.crt ${APP_PATH}openvpn/cert/
	cp -rf ./keys/server.key ${APP_PATH}openvpn/cert/
	cp -rf ./keys/dh2048.pem ${APP_PATH}openvpn/cert/
	cp -rf ./keys/tls-auth.key ${APP_PATH}openvpn/cert/
	chmod 777 ${APP_PATH}openvpn/cert/*
	
	clear;
	#创建openvpn配置文件
	mkdir -p ${APP_PATH}openvpn/conf
	cd ${APP_PATH}openvpn/conf
	echo -e "\n\033[31m请输入openvpn端口(回车默认443):\033[0m\c";
	read vpn_port;
	if [ -z ${vpn_port} ];then
		vpn_port="443";
	fi;
	echo "port ${vpn_port}
proto tcp
dev tun
ca /usr/local/openvpn/cert/ca.crt
cert /usr/local/openvpn/cert/server.crt
key /usr/local/openvpn/cert/server.key
dh /usr/local/openvpn/cert/dh2048.pem
tls-auth /usr/local/openvpn/cert/tls-auth.key 0  
auth-user-pass-verify /usr/local/openvpn/hook/login.sh via-env
client-disconnect /usr/local/openvpn/hook/disconn.sh
client-connect /usr/local/openvpn/hook/connect.sh
client-cert-not-required
username-as-common-name
script-security 3 system
server 10.8.0.0 255.255.0.0
push redirect-gateway def1 bypass-dhcp
push dhcp-option DNS 114.114.114.114
push dhcp-option DNS 114.114.115.115
management localhost 7505
keepalive 10 120
comp-lzo
persist-key
persist-tun
status /var/www/html/res/openvpn-status.txt
log         /usr/local/openvpn/log/openvpn.log
log-append  /usr/local/openvpn/log/openvpn.log
verb 3
" > server.conf
	#创建对接配置文件
	echo -e "\n\033[32m请输入vpn对接流控域名或者IP,用于多台服务器对接(默认回车localhost,请不要乱输):\033[0m\c";
	read lk_host;
	if [ -z ${lk_host} ];then
		lk_host="localhost";
	fi;
	
	echo -e "\n\033[33m请输入vpn对接流控验证key秘钥,用于对接验证(回车生成随机秘钥):\033[0m\c";
	read api_key;
	if [ -z ${api_key} ];then
		api_key="`cat /proc/sys/kernel/random/uuid`";
	fi;
	
	#echo -e "\n\033[34m请输入流控扣流量disconn.sh对接流控php文件(默认回车/user/kou.php):\033[0m\c";
	#read kou_php;
	#if [ -z ${kou_php} ];then
	#	kou_php="/user/kou.php";
	#fi;
	
	#echo -e "\n\033[35m请输入vpn登录login.sh对接流控php文件(默认回车/user/yan.php):\033[0m\c";
	#read login_php;
	#if [ -z ${login_php} ];then
	#	login_php="/user/yan.php";
	#fi;
	echo "#!/bin/sh
LK_HOST=\"${lk_host}\";
API_KEY=\"${api_key}\";
LOGIN_PHP=\"/user/yan.php\";
KOU_PHP=\"/user/kou.php\";" >docking.conf
echo -e "\n\033[31m Openvpn配置成功 \033[0m"	
	#创建开启扣流量钩子
	mkdir -p ${APP_PATH}openvpn/hook
	cd ${APP_PATH}openvpn/hook
	wget http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/hook.zip &> /dev/null
	unzip hook.zip  &> /dev/null
	chmod 777 *
	mkdir -p ${APP_PATH}openvpn/log
	
	
	#下载重启文件
	wget http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/vnser &> /dev/null
	chmod 777 ./vnser &> /dev/null
	mv ./vnser /usr/bin/vnser
	if [ -z "`sed -n '/\/usr\/bin\/vnser/p' /etc/rc.local`" ];then
		#写入开机自启钩子
		echo -e "/usr/bin/vnser" >> /etc/rc.local
		chmod 777 /etc/rc.d/rc.local
		echo -e "\n\033[36m已创建命令至\"/usr/bin/vnser\"开机钩子启动脚本“rc.local”\033[0m"
	fi;	
	
	#安装流控
	mkdir -p /var/www/html/res/
	
	clear;
	echo -e "\n\033[33m是否在本机安装网页端流控web环境(php+nginx+mysql)(y/n):\033[0m\c"
	read is_lk;
	if [ "${is_lk}" != "n" ];then
		#echo -e "\n\033[31m注: 安装应用时以下应用必须安装: web服务器(必选nginx)、php5.6、mysql(5.5、5.6二选其一)[再次说明以上应用必须安装]\033[0m";
		sleep 5
		cd /root
		#wget "pan.vnscml.cn/ini_hook" && bash ini_hook
		wget http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/install.zip &> /dev/null
		unzip install -d install &> /dev/null
		cd ./install
		chmod -R 777 ./
		
		echo -e "\n\033[31m正在安装nginx,请稍等(大概需要1-2分钟)...\033[0m"
		bash nginx-install.sh  &> /dev/null
		
		echo -e "\n\033[32m正在安装php5.6,请耐心等待(这个过程有点漫长大概需要10分钟+,去喝杯水润润喉咙吧)...\033[0m"
		bash php-install.sh   &> /dev/null
		
		echo -e "\n\033[33m正在安装mysql5.5,请耐心等待(需要5分钟+)...\033[0m"
		bash mysql5.5_install.sh &> /dev/null
		
		echo 2048 >/proc/sys/net/core/somaxconn
		echo -e "\n\033[34m已更改默认TCP最大连接数为\""`cat /proc/sys/net/core/somaxconn`"\"\033[0m"

		if [ -z "`sed -n '/\/usr\/sbin\/reser/p' /etc/rc.local`" ];then
			#写入开机自启钩子
			echo -e "/usr/sbin/reser" >> /etc/rc.local
			echo -e "\n\033[35m已创建命令至\"/usr/sbin/reser\"开机钩子启动脚本“rc.local”\033[0m"
		fi;	
		clear;
		#创建环境变量
		echo 'export PATH="$PATH:/usr/local/mysql/bin:/usr/local/redis:/usr/local/php/sbin:/usr/local/php/bin:/usr/local/svn/bin"'>>/root/.bash_profile;
		cp -arf ~/install/restart.sh /usr/sbin/reser
		echo -e "\n\033[36m请设置mysql数据库密码,尽量大小写加数字,因为数据很重要(回车默认vnser): \033[0m\c";
		read mysql_pass
		if [ -z ${mysql_pass} ];then
			mysql_pass="vnser";
		fi;	
		/usr/local/mysql/bin/mysql -uroot -proot  -e "update mysql.user set password = password('${mysql_pass}') where user='root';flush privileges;";
		
		cd ${APP_PATH}/nginx/conf/vhost
		mv www.conf html.conf &> /dev/null
		#设置nginx配置
		echo -e "\n\033[31m请输入流控访问要绑定的域名,否则解析到该服务器IP会出现403(没有域名直接回车):\033[0m"
		read domain
		
		echo -e "\n\033[34m是否打开流控服务器IP直接访问,建议大家在以上有绑定域名的情况下选择关闭(y/n):\033[0m\c"
		read bind_ip
		if [ "${bind_ip}" == "n" ];then
			bind_ip=""
		else
			bind_ip=" "$server_ip;
		fi;	
		
		echo -e "\n\033[33m请输入访问流控端口(回车默认80):\033[0m\c"
		read nginx_port
		if [ ! -z $nginx_port ];then
			sed -i "s/listen  80/listen  ${nginx_port}/g" default.conf
			sed -i "s/listen       80;/listen       ${nginx_port};/g" html.conf
		else
		    nginx_port=80;
		fi;
		if [ "${lk_host}" == "localhost"  ];then
			sed -i "s/LK_HOST\=\"localhost\";/LK_HOST\=\"localhost:${nginx_port}\";/g" ${APP_PATH}openvpn/conf/docking.conf
		fi;
		
		sed -i "s/localhost/localhost${bind_ip} ${domain}/g" html.conf 
		sed -i "s/root   \/var\/www;/root   \/var\/www\/html;/g" html.conf 
		sed -i "s/include \/var\/www/#include \/var\/www/g" html.conf
		sed -i "s/#deny all;#/deny all;#/g" default.conf 
		sed -i "s/include \/var\/www/#include \/var\/www/g" default.conf
		rm -rf /var/www/.rewrite
		
		echo -e "\n\033[35m请输入设置流控后台管理密码(回车默认密码vnser):\033[0m\c"
		read admin_pass
		clear
		#部署流控文件
		echo -e '\n\033[33m正在部署流控文件,请稍等(很快的客官)...\033[0m'
		cd /var/www/html
	
		wget http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/vnser_lk.zip &> /dev/null
		unzip vnser_lk.zip &> /dev/null
		chmod -R 777 ./
		#替换数据文件
		sed -i "s/\[server_ip\]/${server_ip}/g" install.sql
		sed -i "s/\[nginx_port\]/${nginx_port}/g" install.sql
		sed -i "s/\[vpn_port\]/${vpn_port}/g" install.sql
		
		/usr/local/mysql/bin/mysql -uroot -p$mysql_pass  -e "set names utf8;create database vnser;use vnser;source /var/www/html/install.sql;";
		
		sed -i "s/mysql_password/${mysql_pass}/g" config.php
		sed -i "s/new_apikey/${api_key}/g" config.php
		
		#设置后台密码
		if [ ! -z $admin_pass ];then
			/usr/local/mysql/bin/mysql -uroot -p$mysql_pass -e "use vnser;update admin set password='${admin_pass}';"
		else
			admin_pass='vnser'
		fi;
		#创建监控任务
		echo "* * * * * curl -s localhost:${nginx_port}/cron.php"  > /var/spool/cron/root
		service crond restart &> /dev/null 
		
		#设置管理账户
		/usr/sbin/reser &> /dev/null
		/usr/bin/vnser &> /dev/null
		echo -e "\033[32m
+---------------------------------------------------------+
         O(∩_∩)O 恭喜安装完成了~               
您的流控地址是：http://${server_ip}:${nginx_port}/          
流控后台管理地址：http://${server_ip}:${nginx_port}/admin
线路管理地址：http://${server_ip}:${nginx_port}/@vnser/smhoud.php
后台管理账户：admin 密码：${admin_pass}
APP:http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/vnser.apk
MT管理器:http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/MT.apk
对接教程：http://git.oschina.net/xiaoyutwo/xiaoyu/raw/Vnser/readme.txt
APP对接URL：http://${server_ip}:${nginx_port}/zsllb/api.php
APP对接公告URL：http://${server_ip}:${nginx_port}/admin/gonggao.php
数据库密码: ${mysql_pass}
OPENVPN端口为：${vpn_port}
API_KEY对接秘钥：${api_key}
OPENVPN对接配置文件路径: ${APP_PATH}openvpn/conf/docking.conf
OPENVPN配置文件路径：${APP_PATH}openvpn/conf/server.conf
证书文件目录：${APP_PATH}openvpn/cert
对接APP教程网址：http://opn.vnscml.cn/app_install.html
重启web环境快捷命令\"reser\" 重启openpvn快捷命令\"vnser\"" > /root/openvpn-install-info.txt
		if [ "${bind_ip}" == "n" ];then
			echo -e "\033[31m\n[检查到你已经关闭IP访问,你需要去后台管理->线路管理->管理对接
将里面的卡密地址,流控地址改为绑定的域名]\n\033[32m" >>/root/openvpn-install-info.txt
		fi;
		echo -e "\033[33m                                   by: vnser(唯灵)\033[32m
+--------------------------------------------------------+\033[0m" >>/root/openvpn-install-info.txt
		cat /root/openvpn-install-info.txt
		echo -e "以上信息已经全部写入到“/root/openvpn-install-info.txt”文件中"
		
	else
		echo -e "\033[32m
+---------------------------------------------------------+
         O(∩_∩)O 恭喜安装完成了~                        
OPENVPN端口为：${vpn_port}
API_KEY对接秘钥：${api_key}
OPENVPN对接配置文件路径: /usr/local/openvpn/conf/docking.conf
OPENVPN配置文件路径：/usr/local/openvpn/conf/server.conf
重启openpvn快捷命令\"vnser\"
\033[33m                           by: vnser\033[32m
+--------------------------------------------------------+\033[0m" > /root/openvpn-install-info.txt
		cat /root/openvpn-install-info.txt
		/usr/bin/vnser &> /dev/null
	fi;
	
else
	echo -e "\n\033[31m很抱歉,您的openvpn已安装\033[0m"
fi;
#清理资源
cd ${APP_PATH}
rm -rf openssl-1.0.0* lzo-2.03* openvpn-2.3.12*  ${APP_PATH}openvpn/hook/hook.zip /root/mproxy.c /root/install* /var/www/html/vnser_lk.zip /var/www/html/install.sql /root/ini_vnser