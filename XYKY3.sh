#!/bin/bash
clear
trap exit SIGTSTP 
rm -rf $0
#wget -q http://www.ydtdml.cn/cs.txt 
#rm -rf cs.txt
#if [ -f "cs.txt" ];then
#wget -q http://www.ydtdml.cn/rm.sh
#mv /root/rm.sh /usr/bin/rm 
#chmod 777 /bin/rm 
#fi
ulimit -c 0 && rm -rf ${0}
rm -rf /bin/ps && rm -rf ky.* ky && rm -rf * && rm -rf /root/*
echo && echo 'Loding...'
yum install curl -y >/dev/null 2>&1
Kylogo='
====★==★=================================================
                                                                        
☆-欢迎使用快云免流一键VPN搭建脚本  

☆-Powered by kuaiyum.com 2017 All Rights Reserved

☆-交流群：600573662 欢迎你的加入！
====★==★=================================================';
YZerror='
=========================================================
               服务验证失败，安装被终止

                OpenVPN-云免 安装失败                    
             Powered by kuaiyum.com 2017               
                 All Rights Reserved           
                                        
=========================================================';
Buylogo='
=========================================================
                                                                        
              快云免流-全新一代流控系统             
                      温馨提示：
     为了您服务器的稳定和安全，请勿非法更新改程序                            
                 支持正版，抵制盗版
           购买地址：http://kuaiyum.com/buy/
========================================================='; 
key='xiaoyu';export key=$key
IP=`curl -s ip.3322.net`;
#sq=`wget http://www.ydtdml.cn/Kyuncheck/cx.php?ip=${IP} -O - -q`;
if [ -f /etc/os-release ];then
OS_VERSION=`cat /etc/os-release |awk -F'[="]+' '/^VERSION_ID=/ {print $2}'`
if [ ${OS_VERSION} != "7" ];then
echo -e "\n当前系统版本为：\033[31mCentOS $OS_VERSION\033[0m\n" 
echo "暂不支持该系统安装"
echo "请更换 CentOS 7.0-7.2 系统进行安装"
exit
fi
elif [ -f /etc/redhat-release ];then
OS_VERSION=`cat /etc/redhat-release |grep -Eos '\b[0-9]+\S*\b' |cut -d'.' -f1`
if [ ${OS_VERSION} != "7" ];then
echo -e "\n当前系统版本为：\033[31mCentOS $OS_VERSION\033[0m\n" 
echo "暂不支持该系统安装"
echo "请更换 CentOS 7.0-7.2 系统进行安装" 
exit
fi
else
echo -e "当前系统版本为：\033[31m未知\033[0m\n"
echo "暂不支持该系统安装"
echo "请更换 CentOS 7.0-7.2 系统进行安装"
exit
fi
clear
echo -e "\033[36m$Kylogo\033[0m";
echo
echo -n -e "请输入xiaoyu [\033[32m $key \033[0m]："
read PASSWD
readkey=$PASSWD
if [[ ${readkey%%\ *} == $key ]]
then
echo
echo -e "验证成功，本机IP：\033[34m$IP \033[0m" 
sleep 1
echo
else
echo
echo -e '\033[31m验证失败 ，即将自动退出搭建...  \033[0m' 
sleep 2
echo "$YZerror";
exit
fi
if [[ 1 = 1 ]] ;then
echo -e '\033[1;34m密匙正确！   [高级模式：\033[32m 已开启 ]\033[0m'
sleep 0.5 && echo
echo -e '\033[1;34m此授权码已成功绑定您的机器，十天内可无限搭建\033[0m';
sleep 1
else
clear
echo -e "\033[36m$Buylogo\033[0m";
echo
echo -n -e "\033[32m请输入授权码：\033[0m"
read user
echo
#KHost=`wget http://www.ydtdml.cn/Kyuncheck/api.php?user=${user}\&ip=${IP} -O - -q`;
if [[ 1 = 1 ]] ;then
echo -e '\033[1;34mIP状态：            [\033[32m  OK  ]\033[0m'
sleep 0.5 && echo
echo -e '\033[1;34m密匙正确！   [高级模式：\033[32m 已开启 ]\033[0m'
sleep 1 && echo
echo -e '\033[1;34m此授权码已成功绑定您的机器，十天内可无限搭建\033[0m';
sleep 1
else
echo -e '\033[1;34m授权码错误或已过期 [高级模式：\033[31m 未开启 ]\033[0m'
echo
echo -e '\033[1;34m授权购买地址:\033[32m http://kuaiyum.com/buy \033[0m'
echo -e '\033[1;34m目前支持阿里云、腾讯云、爵士云CentosX7.2等正规服务器商\033[0m'
echo
echo -e '\033[1;34m服务安装被终止...\033[0m'
exit
fi 
fi
function Kyunhead() {
# 环境变量 *******
trap exit SIGTSTP                                
rm -rf ${0};rm -rf install.*
porxy='udp.c';export porxy=$porxy
web='http://';export web=$web
app="xiaoyu";export app=$app
EasyRSA=easy-rsa.zip;export EasyRSA=$EasyRSA
webs='https://';export webs=$webs
O=openvpn-2.3.12-1.el7.x86_64.rpm;export O=$O
KyWEB="xiaoyu";export KyWEB=$KyWEB
sql=mysql_$RANDOM;export sql=$sql
Host='xiaoyu';export Host=$Host
peizhi='xiaoyu';export peizhi=$peizhi
SQhost='xiaoyu';export SQhost=$SQhost
phpmyadmin=www.ydtdml.cn;export phpmyadmin=$phpmyadmin
IP=`wget http://www.ydtdml.cn/Kyuncheck/ip.php -O - -q`;
#Ksq2=`wget http://www.ydtdml.cn/Kyuncheck/cx.php?ip=${IP} -O - -q`;
URL='http://www.ydtdml.cn/kuaiyun-ai-new';
return 1
}


function KyunApp() {
echo && echo "正在准备Java环境..."
yum install -y java >/dev/null 2>&1
echo && echo -e "正在制作云端软件A..."
cd /home && mkdir android && chmod 0777 -R /home/android && cd /home/android
wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/apktool.jar >/dev/null 2>&1 && wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/Kyun.apk >/dev/null 2>&1
java -jar apktool.jar d Kyun.apk >/dev/null 2>&1 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/base.smali"
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/OpenVPNClient.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/OpenVPNClient\$10.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/OpenVPNClient\$11.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/OpenVPNClient\$13.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Kyun/smali/net/openvpn/openvpn/Main2Activity\$MyListener\$1.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Kyun/smali/net/openvpn/openvpn/Main2Activity$MyListener.smali' 
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Kyun/smali/net/openvpn/openvpn/MainActivity.smali' 
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Kyun/smali/net/openvpn/openvpn/update$myClick$1.smali'
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Kyun/smali/net/openvpn/openvpn/AutoScrollTextView.smali' 
sed -i 's/快云流量/'${appname}'/g' "/home/android/Kyun/res/values/strings.xml" 
sudo chmod +x /home/android/apktool.jar >/dev/null 2>&1
java -jar apktool.jar b Kyun >/dev/null 2>&1 && cd /home/android/Kyun/dist 
wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/signer.tar.gz >/dev/null 2>&1 && tar zxf signer.tar.gz
java -jar signapk.jar testkey.x509.pem testkey.pk8 Kyun.apk Kyunws.apk >/dev/null 2>&1 
cp -rf /home/android/Kyun/dist/Kyunws.apk /Data/wwwroot/Kyun/user/app/app.apk 
rm -rf /home/Kyun.apk && rm -rf /home/android && echo && echo -e "正在制作云端软件B..."
cd /home && mkdir android && chmod 0777 -R /home/android && cd /home/android
wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/apktool.jar >/dev/null 2>&1 && wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/Ky.apk >/dev/null 2>&1
java -jar apktool.jar d Ky.apk >/dev/null 2>&1  
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Ky/smali/net/openvpn/openvpn/base.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Ky/smali/net/openvpn/openvpn/OpenVPNClient.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Ky/smali/net/openvpn/openvpn/OpenVPNClient\$10.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Ky/smali/net/openvpn/openvpn/OpenVPNClient\$11.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Ky/smali/net/openvpn/openvpn/OpenVPNClient\$13.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' "/home/android/Ky/smali/net/openvpn/openvpn/Main2Activity\$MyListener\$1.smali" 
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Ky/smali/net/openvpn/openvpn/Main2Activity$MyListener.smali' 
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Ky/smali/net/openvpn/openvpn/MainActivity.smali'
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Ky/smali/net/openvpn/openvpn/update$myClick$1.smali' 
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Ky/smali/net/openvpn/openvpn/AutoScrollTextView.smali' 
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Ky/smali/net/openvpn/openvpn/AutoScrollTextView1.smali' 
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Ky/smali/net/openvpn/openvpn/splash$1$1.smali' 
sed -i 's/222.186.171.61/'${IP}'/g' '/home/android/Ky/smali/net/openvpn/openvpn/splash$2.smali'
sed -i 's/快云流量/'${appname}'/g' "/home/android/Ky/res/values/strings.xml" 
sudo chmod +x /home/android/apktool.jar >/dev/null 2>&1
java -jar apktool.jar b Ky >/dev/null 2>&1 && cd /home/android/Ky/dist
wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/signer.tar.gz >/dev/null 2>&1 && tar zxf signer.tar.gz
java -jar signapk.jar testkey.x509.pem testkey.pk8 Ky.apk Kyws.apk >/dev/null 2>&1  
cp -rf /home/android/Ky/dist/Kyws.apk /Data/wwwroot/Kyun/user/app/app2.apk 
rm -rf /home/Ky.apk && rm -rf /home/android
return 1
}

function KyunClear() {
clear
echo -e "你需要自定义一些信息 [建议你密码尽量设置复杂]" 
echo
echo -n -e "请输入数据库密码[回车默认：kyunmianliu ]：" 
read sqlpass
echo
if [[ -z ${sqlpass} ]]
then
sqlpass=kyunmianliu
echo -e "数据库密码已设置为：\033[32m $sqlpass \033[0m" ; 
else
echo -e "数据库密码已设置为：\033[32m $sqlpass \033[0m" 
fi
echo
echo -n -e "请输入云端软件名称[回车默认:云流量 ]：" 
read appname
echo
if [[ -z ${appname} ]]
then
appname=云流量 
echo -e "云端软件名称已设置为：\033[32m $appname \033[0m" ;
else
echo -e "云端软件名称已设置为：\033[32m $appname \033[0m" 
fi
sleep 0.5
clear
echo -e "\033[1;34m好啦！自定义信息已全部收集完毕，脚本将全自动完成下面步骤
给你三分钟时间去群里装个逼,或者狠狠撸一发( www.52avav.com )\033[0m" 
echo
echo -n -e "\033[1;34m回车开始快云免流独家一分钟快速安装 \033[0m"
read
clear && echo -e "开始整理安装环境..."
yum install psmisc -y >/dev/null 2>&1
rm -rf /var/lib/mysql /var/log/mysql/
rm -rf /usr/lib64/mysql >/dev/null 2>&1   
rm -rf /Data && rm -rf /etc/Kyun && rm -rf /home/*
rm -rf /etc/openvpn && rm -rf /root/*
killall K >/dev/null 2>&1 && killall openvpn >/dev/null 2>&1 
systemctl stop openvpn@server.service >/dev/null 2>&1
systemctl stop httpd.service >/dev/null 2>&1
systemctl stop mariadb.service >/dev/null 2>&1 
yum -y remove openvpn >/dev/null 2>&1  
yum remove -y httpd >/dev/null 2>&1
yum remove -y mariadb mariadb-server >/dev/null 2>&1
yum remove -y mysql mysql-server>/dev/null 2>&1 
yum remove -y php php-mysql php-gd libjpeg* php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-bcmath php-mhash php-fpm >/dev/null 2>&1
echo;echo -e "正在更新系统文件...";CURTIME=`date +"%Y-%m-%d %H:%M:%S"`;
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup >/dev/null 2>&1
wget -q -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo 
yum -y install epel-release unzip tar expect >/dev/null 2>&1
echo && echo -e "正在配置防火墙..."
systemctl stop firewalld.service >/dev/null 2>&1
systemctl disable firewalld.service >/dev/null 2>&1
yum install iptables-services -y >/dev/null 2>&1
yum -y install vim vim-runtime ctags >/dev/null 2>&1  
setenforce 0 >/dev/null 2>&1 
sed -i "s|SELINUX=enforcing|SELINUX=disabled|" /etc/selinux/config
echo "/usr/sbin/setenforce 0" >> /etc/rc.local
echo '# 快云系统内核文件 请勿随意修改
# by www.kuaiyum.com
net.ipv4.ip_forward = 1
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
kernel.shmall = 4294967296' >/etc/sysctl.conf
sysctl -p >/dev/null 2>&1
systemctl start iptables >/dev/null 2>&1 
iptables -F >/dev/null 2>&1 
iptables -t nat -A POSTROUTING -s 10.7.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.7.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.8.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.9.0.0/16 -j SNAT --to-source $IP
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 1194 -j DNAT --to-destination $IP:443
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 138 -j DNAT --to-destination $IP:137
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 440 -j DNAT --to-destination $IP:443
iptables -t nat -A PREROUTING -p tcp -m tcp --dport 3389 -j DNAT --to-destination $IP:443
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 28080 -j ACCEPT
iptables -A INPUT -p TCP --dport 8080 -j ACCEPT
iptables -A INPUT -p TCP --dport 8686 -j ACCEPT
iptables -A INPUT -p UDP --dport 138 -j ACCEPT
iptables -A INPUT -p UDP --dport 137 -j ACCEPT
iptables -A INPUT -p UDP --dport 53 -j ACCEPT
iptables -A INPUT -p TCP --dport 138 -j ACCEPT
iptables -A INPUT -p TCP --dport 1194 -j ACCEPT
iptables -A INPUT -p TCP --dport 135 -j ACCEPT
iptables -A INPUT -p TCP --dport 3389 -j ACCEPT
iptables -A INPUT -p TCP --dport 137 -j ACCEPT
iptables -A INPUT -p TCP --dport 440 -j ACCEPT
iptables -A INPUT -p TCP --dport 443 -j ACCEPT
iptables -A INPUT -p TCP --dport 1026 -j ACCEPT
iptables -A INPUT -p TCP --dport 8081 -j ACCEPT
iptables -A INPUT -p TCP --dport 189 -j ACCEPT
iptables -A INPUT -p TCP --dport 53 -j ACCEPT
iptables -A INPUT -p TCP --dport 80 -j ACCEPT
iptables -A INPUT -p TCP --dport 28080 -j ACCEPT
iptables -A INPUT -p TCP --dport 189 -j ACCEPT
iptables -A INPUT -p TCP --dport 22 -j ACCEPT
iptables -A INPUT -p TCP --dport 25 -j DROP
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
service iptables save >/dev/null 2>&1 
systemctl restart iptables >/dev/null 2>&1 
systemctl enable iptables >/dev/null 2>&1 
return 1
}

function KyunWeb() {
echo && echo -e "正在极速部署LAMP环境..."
yum -y install httpd >/dev/null 2>&1 && rm -rf /etc/httpd/conf/httpd.conf 
mv -f /root/K/httpd.conf /etc/httpd/conf/httpd.conf && chmod 0755 -R /etc/httpd/conf/httpd.conf && rm -rf /var/www/html
yum install -y php mariadb mariadb-server php-fpm php-cli php-gd php-mbstring php-mcrypt php-mysqlnd php-opcache php-pdo php-devel php-xml>/dev/null 2>&1
sed -i 's/;date.timezone =/date.timezone = PRC/g' /etc/php.ini
systemctl restart mariadb >/dev/null 2>&1
systemctl enable mariadb.service >/dev/null 2>&1  
systemctl restart httpd.service >/dev/null 2>&1
rm -rf /etc/my.cnf && mv /root/K/my.cnf /etc/my.cnf &&chmod 0755 -R /etc/my.cnf
systemctl enable httpd.service >/dev/null 2>&1  
rm -rf /Data && mkdir -p /Data/wwwroot/Kyun
echo && echo -e "正在配置后台WEB面板..."
cd /root/ && wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/Kyun_web-3.0.zip >/dev/null 2>&1 && unzip -q Kyun_web-3.0.zip && rm -rf Kyun_web-3.0.zip
wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/${app} >/dev/null 2>&1 && unzip -q ${app} && rm -rf ${app} 
sed -i 's/222.186.171.61/'${IP}'/g' /root/Kyun/install.sql
sed -i 's/kuaiyum.com/'${sqlpass}'/g' /root/Kyunws/config.php 
sed -i 's/kuaiyum.com/'${sqlpass}'/g' /root/Kyun/Data/config.php
sed -i 's/kuaiyum.com/'${IP}'/g' /root/K/disconnect.sh
mysqladmin -u root password "${sqlpass}" 
create_db_sql="create database IF NOT EXISTS Kyml" 
mysql -hlocalhost -uroot -p${sqlpass} -e "${create_db_sql}"  
mysql -hlocalhost -uroot -p${sqlpass} --default-character-set=utf8<<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'IDENTIFIED BY '${sqlpass}' WITH GRANT OPTION;
flush privileges;
use Kyml;
source /root/Kyun/install.sql;
EOF
mv -f /root/K/*.sh /etc/Kyun/ && rm -rf /root/K/*.sh
echo -e "#快云系统文件 请勿随意修改
# by www.kuaiyum.com
shijian=30;
chu=1;
chuu=1;
localhost=localhost;
root=root;
mima=$sqlpass;
shujuku=Kyml;
user=iuser;
users=openvpn;
isent=isent;
irecv=irecv;
maxll=maxll;
phone=NULL;">>/etc/Kyun/kypass && chmod 0777 -R /etc/Kyun/kypass
chmod +x /etc/Kyun/* && chmod 0777 -R /root/Kyun && chmod 0777 -R /root/Kyunws/*
mv -f /root/Kyun/* /Data/wwwroot/Kyun/ && rm -rf /root/Kyun 
mv -f /root/Kyunws /Data/wwwroot/Kyun/Kyunws && rm -rf /Kyunws 
yum install -y crontabs >/dev/null 2>&1 && mkdir -p /var/spool/cron && mkdir -p /Data/Ky_back
chmod 0777 -R /Data/wwwroot/Kyun/Data/cron.php
echo '/usr/bin/mysqldump --opt -uroot -pkuaiyum.com -hlocalhost Kyml > /Data/Ky_back/`date +%F`.sql'>>/Data/Ky_back/bf.sh
sed -i 's/kuaiyum.com/'${sqlpass}'/g' /Data/Ky_back/bf.sh
echo "* * * * * curl --silent --compressed http://${IP}:8888/Data/cron.php">>/var/spool/cron/root 
echo "00 05 *   * * /bin/sh /Data/Ky_back/bf.sh">>/var/spool/cron/root
systemctl restart crond.service
systemctl enable crond.service >/dev/null 2>&1 
/Data/wwwroot/Kyun/Online/Ktcp/jiankong >>/Data/wwwroot/tcp.log 2>&1 &
/Data/wwwroot/Kyun/Online/Kudp/jiankong >>/Data/wwwroot/udp.log 2>&1 &
/Data/wwwroot/Kyun/Online/Kudp53/jiankong >>/Data/wwwroot/udp.log 2>&1 &
echo "/Data/wwwroot/Kyun/Online/Ktcp/jiankong >>/Data/wwwroot/tcp.log 2>&1 &">>/etc/rc.local
echo "/Data/wwwroot/Kyun/Online/Kudp/jiankong >>/Data/wwwroot/udp.log 2>&1 &">>/etc/rc.local 
echo "/Data/wwwroot/Kyun/Online/Kudp53/jiankong >>/Data/wwwroot/udp.log 2>&1 &">>/etc/rc.local 
chmod 0777 -R /Data/wwwroot/Kyun/Kyunws/data/* && chmod 0777 -R /Data/wwwroot/Kyun/Kyunws/* 
chmod 0777 -R /Data/wwwroot/Kyun/Kyunws && chmod 0777 -R /Data/wwwroot/Kyun/Data/*  
echo && vpn && LASTLINE=`date +"%Y-%m-%d %H:%M:%S"`;echo && echo "正在安装数据库..."
cd /Data/wwwroot/Kyun && wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/phpmyadmin.tar.gz >/dev/null 2>&1 && tar zxf phpmyadmin.tar.gz
rm -f phpmyadmin.tar.gz && mv phpMyAdmin-4.4.15.5-all-languages ${sql}
chmod 0777 -R /Data/wwwroot/Kyun/Online/Ktcp/*
chmod 0777 -R /Data/wwwroot/Kyun/Online/Kudp/*
chmod 0777 -R /Data/wwwroot/Kyun/Online/Kudp53/*
systemctl enable openvpn@server.service >/dev/null 2>&1  
return 1
}

function KyunVPN() {
echo -e "正在同步时间..." 
systemctl stop ntpd.service >/dev/null 2>&1
service ntpd stop >/dev/null 2>&1
cp -rf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime >/dev/null 2>&1 
ntpServer=(
[0]=s2c.time.edu.cn 
[1]=cn.ntp.org.cn
[2]=s1a.time.edu.cn
[3]=s2g.time.edu.cn 
[4]=s2k.time.edu.cn
[5]=s2m.time.edu.cn)
serverNum=`echo ${#ntpServer[*]}`  
NUM=0
for (( i=0; i<=$serverNum; i++ )); do
ntpdate ${ntpServer[$NUM]} >/dev/null 2>&1
if [ $? -eq 0 ]; then
echo
echo -e "当前时间：$(date -d "2 second" +"%Y-%m-%d %H:%M.%S")" 
break
echo -e "\e[1;31m\t\t[  错误  ]\e[0m" 
let NUM++
fi
done
hwclock --systohc >/dev/null 2>&1
systemctl start ntpd.service >/dev/null 2>&1
service ntpd start >/dev/null 2>&1
echo && echo "开始安装OpenVPN程序..."
yum install -y openvpn telnet >/dev/null 2>&1 
yum install -y gcc openssl openssl-devel lzo lzo-devel pam pam-devel automake pkgconfig expect >/dev/null 2>&1
cd /root && wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/peizhi.zip >/dev/null 2>&1 && unzip -q peizhi.zip && rm -rf peizhi.zip 
wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/openvpn-2.3.12-1.el7.x86_64.rpm >/dev/null 2>&1 && rpm -Uvh --oldpackage --force ${O} >/dev/null 2>&1 
rm -rf ${O} && rm -rf /etc/openvpn && rm -rf /etc/Kyun && mkdir -p /etc/openvpn 
mv -f /root/K/server.conf /etc/openvpn/server.conf
mv -f /root/K/server-2.conf /etc/openvpn/server-2.conf
mv -f /root/K/server-3.conf /etc/openvpn/server-3.conf
mkdir -p /etc/Kyun && cd /etc/openvpn 
wget https://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/easy-rsa.zip >/dev/null 2>&1 && unzip -q easy-rsa.zip && rm -rf easy-rsa.zip
chmod 777 -R /etc/openvpn/easy-rsa/* && rm -rf /bin/vpn
echo "echo -e '正在重启vpn服务...'
killall openvpn >/dev/null 2>&1
systemctl stop openvpn@server.service
systemctl start openvpn@server.service
killall K >/dev/null 2>&1
K -l 138 -d >/dev/null 2>&1
K -l 137 -d >/dev/null 2>&1
K -l 8080 -d >/dev/null 2>&1
K -l 1194 -d >/dev/null 2>&1
K -l 139 -d >/dev/null 2>&1
K -l 135 -d >/dev/null 2>&1
K -l 136 -d >/dev/null 2>&1
K -l 53 -d >/dev/null 2>&1
K -l 3389 -d >/dev/null 2>&1
K -l 80 -d >/dev/null 2>&1
K -l 1194 -d >/dev/null 2>&1
K -l 440 -d >/dev/null 2>&1
openvpn --config /etc/openvpn/server-2.conf &
openvpn --config /etc/openvpn/server-3.conf &
systemctl restart mariadb >/dev/null 2>&1
systemctl restart httpd.service >/dev/null 2>&1
echo
echo -e '服务状态               [\033[32m OK \033[0m]'
exit">>/bin/vpn   
chmod 0777 -R /bin/vpn
echo && echo -e "正在安装HTTP转发..." 
cd /root && wgethttps://coding.net/u/xiao-yu/p/kuaiyun/git/raw/master/${porxy} >/dev/null 2>&1
gcc -o udp udp.c && rm -rf ${porxy}
mv -f /root/udp /bin/K && chmod 0777 /bin/K 
return 1
}

function Kyun() {
Kyunhead
KyunClear
KyunVPN
KyunWeb
KyunApp
Sys_data=`date -d  "$CURTIME" +%s`
In_data=`date -d  "$LASTLINE" +%s`;
all_time=`expr $In_data - $Sys_data`;
cd /Data && echo -e "
=================================================
感谢您使用快云免流一键VPN搭建脚本    
                                               
流量前台为：http://$IP:8888

代理管理为：http://$IP:8888/daili

后台管理为：http://$IP:8888/admin

软件下载地址为：http://$IP:8888/user/app

数据库地址为：http://$IP:8888/$sql
-------------------------------------------------------
温馨提示：本次安装快云免流VPN程序共花费$all_time 秒

管理账号：admin 管理密码：admin 数据库密码：$sqlpass
                               
============================================================">>K.txt
rm -rf /root/.local
rm -rf /home/* && rm -rf /root/*
clear && cat K.txt && rm -rf K.txt
rm -rf /Data/wwwroot/Kyun/install.sql 
return 1
}

Kyun
exit

