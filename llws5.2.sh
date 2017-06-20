#!/bin/bash
unlock >/dev/null 2>&1
time="`date +%F-%H`"
ulimit -c 0
rm -rf $0 
yum install curl -y
clear #清空屏幕
echo -e "-------------------------------------------------------------------------------------"
echo -e "          欢迎使用流量卫士（PDO安全版）一键云端安装脚本                              "
echo -e "-------------------------------------------------------------------------------------"
echo -e "          本脚本已针对SBW3.0进行相应优化                                             "
echo -e "-------------------------------------------------------------------------------------"
echo -e "          2017年2月25日以后的卫士云端已经默认集成PDO 无需重复安装                    "
echo -e "-------------------------------------------------------------------------------------"
echo -e "          [安装细则]                                                                 "
echo -e "          脚本为自动安装，如果使用本脚本无法成功安装，您可以使用传统的WEB安装方式    "
echo -e "          安装时系统会覆盖原有的app_api文件夹，请务必【自行备份重要】文件            "
echo -e "          系统不会导入数据库 安装后请访问云端进行云端安装                            "
echo -e "          本脚本人畜无害 绿色无毒                                                    "
echo -e "          请输入回车后确认执行                                                       "
echo -e "                                                 by 小白扮大神 2016-03-22            "
echo -e "-------------------------------------------------------------------------------------"
echo -e "          请输入回车后确认执行                                                       "
echo -e "-------------------------------------------------------------------------------------"
read -n1
clear 
echo "
---------------------------------------------------------
请选择您要进入的安装模式，输入相应的序号后回车
---------------------------------------------------------

---------------------------------------------------------
【1】全部安装（一键下载安装云端 启动流量统计 并制作APP）
【2】安装云端（仅仅安装云端）
【3】启动流量统计 （尝试修复流量不统计）
【4】制作APP （仅仅生成APP）
---------------------------------------------------------
（温馨提示：谢谢您在 ${time}时 使用本脚本）
---------------------------------------------------------
（温馨提示：写错可用Ctrl+退格 删除）
---------------------------------------------------------
"
wget_host="zonghe-1252394125.costj.myqcloud.com"
files="files_v6"
keyes="1"

IPAddress=$(ip addr | egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | egrep -v "^192\.168|^172\.1[6-9]\.|^172\.2[0-9]\.|^172\.3[0-2]\.|^10\.|^127\.|^255\.|^0\." | head -n 1)
if [[ "$IP" = "" ]]; then
IPAddress=$(wget -qO- -t1 -T2 ipv4.icanhazip.com)
fi

read install_type

if [ $install_type == 1 ];then
	echo -e "\033[32m -------------------------------- \033[0m"
	echo -e "\033[32m             全部安装          \033[0m"
	echo -e "\033[32m -------------------------------- \033[0m"
	#exit 0
elif [ $install_type == 2 ];then 
	echo -e "\033[32m -------------------------------- \033[0m"
	echo -e "\033[32m             安装云端          \033[0m"
	echo -e "\033[32m -------------------------------- \033[0m"
	
elif [ $install_type == 3 ];then 
	echo -e "\033[32m -------------------------------- \033[0m"
	echo -e "\033[32m             启动流量统计          \033[0m"
	echo -e "\033[32m -------------------------------- \033[0m"
else
	install_type=4 
	echo -e "\033[32m -------------------------------- \033[0m"
	echo -e "\033[32m             制作APP         \033[0m"
	echo -e "\033[32m -------------------------------- \033[0m"
	
fi

#获取用户输入的appke
echo -e "[请输入您的授权域名 不要加端口和http:// (没有域名就可以回车)]"
read domain

if [ -z $domain ]
then
echo "授权域名：$IPAddress"
domain=$IPAddress
else
echo "授权域名：$domain"
fi

echo -e "[请输入您的web流控端口]"
read port

echo -e "[请输入您的APP授权码（32位长度）]"
read app_key
echo -e '\033[33m正在验证授权...\033[0m'
sleep 1
#kcard=`curl -s http://sq.slong7.cn/api.php?url=${IPAddress}`;
#if [[ "$kcard" =~ "$keyes" ]]
#then
echo -e '授权状态          [\033[32m  授权成功  \033[0m]';
echo "即将开始下一步安装..."
else
echo -e '授权状态          [\033[32m  未授权  \033[0m]';
#echo -e "\033[31m系统检测你的IP未授权,现已启动自动授权系统\033[0m"
#sleep 3
#echo -e '\033[33m请输入正版密钥开启安装向导（购买地址:\033[32m http://sq.slong7.cn \033[0m）'
#echo
#echo -e "\033[32m请输入授权用户(绑定QQ)\033[0m"
#read qq
#echo -e "\033[33m请输入授权卡密\033[0m"
#read km
#checkSeverIP="`curl -s "http://sq.slong7.cn/khdapi.php?zdsq=1&url=${IPAddress}&qq=${qq}&km=${km}"`";
#if [[ "$checkSeverIP" =~ "$keyes" ]]
#	then
#echo -e "\033[35m授权成功,欢迎使用本脚本\033[0m"
#else
echo
echo -e '\033[33m==========================================================================\033[0m'
echo -e '\033[34m               密钥错误 请检查授权码是否输入正确！           	           \033[0m'
echo -e '\033[31m               温馨提示：         	                                       \033[0m'
echo -e '\033[31m               为了您服务器的稳定和安全，请勿非法破解改程序               \033[0m'
echo -e '\033[31m               密钥绑定IP可在同一IP下反复使用！				                   \033[0m'
echo -e '\033[33m               官方网址：http://www.slong7.cn/  	                         \033[0m'
echo -e '\033[31m               交流群：暂未开放	  欢迎你的加入	  			                 \033[0m'
echo -e '\033[31m               感谢使用此脚本。  By：小白扮大神	  			                 \033[0m'
echo -e '\033[33m==========================================================================\033[0m'
echo
exit 0;
fi
fi

clear


echo
echo -e "==========自动检测WEB目录========="

file1="/home/wwwroot/default/"
file2="/data/www/default/Public/"
file3="/home/www/default/"
file4="/var/www/html/"
file5="/data/www/default/"

if test -f ${file1}index.php;then
	web_path=$file1
elif test -f ${file2}index.php;then
	web_path=$file2
elif test -f ${file3}index.php;then
	web_path=$file3
elif test -f ${file4}index.php;then
	web_path=$file4
elif test -f ${file5}index.php;then
	web_path=$file5
else 
	echo -e "系统未能检测到您的WEB目录 请手动输入："
	read web_path
		if test -d $web_path;then
			echo -e "已经确认WEB目录"
		else
			echo -e "抱歉！未能检测到该目录！请确认后重新执行本程序！"
		exit 0;
		fi
	fi
echo -e "您的流控目录为：$web_path"
chmod -R 0777 $web_path
chattr -i ${web_path}
chattr -i ${web_path}app_api
	#如果选择的是全新安装或者升级安装 执行此部分
	if [ $install_type == 1 ] || [ $install_type == 2 ] ;then 

		echo -e "===========开始云端安装==========="

		cd $web_path

		if test -f app_api.zip
		then
		#删除旧的安装包
		rm app_api.zip
			echo -e "删除旧的安装包\n";
		else
			echo -e "未找到旧的安装包\n"
		fi

		rm -rf ${web_path}app_api
		
		echo -e "正在获取并且安装云端..."
		wget http://${wget_host}/${files}/app_api.zip >/dev/null 2>&1 && unzip -o app_api.zip #全新安装 覆盖全部文件
		
		rm app_api.zip

		chmod -R 0777 ${web_path}app_api

		echo -e "校验文件完整性"

		if test -f  ${web_path}app_api/system.php;then
			echo -e "\033[32m  system.php------------文件存在 \033[0m"
		else
			echo -e "\033[31m system.php------------文件丢失 \033[0m" 
		fi
		#if test -f  ${web_path}app_api/config.php;then
		#	echo -e "\033[32m  config.php------------文件存在 \033[0m"
		#else
		#	echo -e "\033[31m config.php------------文件丢失 \033[0m" 
		#fi
		if test -f  ${web_path}app_api/sms.config.php;then
			echo -e "\033[32m  sms.config.php------------文件存在 \033[0m"
		else
			echo -e "\033[31m sms.config.php------------文件丢失 \033[0m" 
		fi

		echo -e "文件校验完成 如果提示文件丢失 请手动上传"

		#curl "http://$domain:$port/app_api/install/index.php?n=3"
		
	fi	
	if [ $install_type == 1 ];then
		if test -f ${web_path}app_api/install.lock;then
			rm -rf ${web_path}app_api/install.lock	
		fi
		if test -f ${web_path}app_api/config.php;then
			rm -rf ${web_path}app_api/config.php
		fi
	fi
	if [ $install_type == 1 ] || [ $install_type == 3 ];then
			
			
			echo -e "安装流量监控..."
			wget -O disconnect.sh http://${wget_host}/${files}/disconnect.sh >/dev/null 2>&1
			
			sed -i 's/192.168.1.1:8888/'${domain}:${port}'/g' "disconnect.sh" >/dev/null 2>&1
			
			if test -f /etc/openvpn/disconnect.sh;then
					chmod 0777 -R /etc/openvpn/
			
					cp -rf /etc/openvpn/disconnect.sh /etc/openvpn/disconnect.sh.bak 
					cp -rf disconnect.sh /etc/openvpn/disconnect.sh
					chmod 0777 /etc/openvpn/disconnect.sh
			fi
			
			if test -f /etc/openvpn/disconnectudp.sh;then
					chmod 0777 -R /etc/openvpn/
					cp -rf /etc/openvpn/disconnectudp.sh /etc/openvpn/disconnectudp.sh.bak 
					cp -rf disconnect.sh /etc/openvpn/disconnectudp.sh
					chmod 0777 /etc/openvpn/disconnectudp.sh
			fi
			if test -f /usr/share/xml/disconnect.sh;then
					chmod 0777 -R /usr/share/xml/
					
					cp -rf /usr/share/xml/disconnect.sh /usr/share/xml/disconnect.sh.bak 
					cp -rf disconnect.sh /usr/share/xml/disconnect.sh
					chmod 0777 /usr/share/xml/disconnect.sh
			fi
			
			if test -f /usr/share/xml/disconnectudp.sh;then
					chmod 0777 -R /usr/share/xml/
					
					cp -rf /usr/share/xml/disconnectudp.sh /usr/share/xml/disconnectudp.sh.bak 
					cp -rf disconnect.sh /usr/share/xml/disconnectudp.sh
					chmod 0777 /usr/share/xml/disconnectudp.sh
			fi
			
		fi	
	if [ $install_type == 1 ] || [ $install_type == 4 ];then
		chmod 0777 -R /home
		cd /home
		echo -e  "开始制作APP"
		echo -e "输入您的APP名称（默认：流量商行）"
		read app_name
		if test -z $app_name;then
				echo -e "已经默认为流量商行"
				app_name="流量商行"
		fi
		
		
		echo -e "正在加载基础环境(较慢 耐心等待)...."
		yum install -y java
	
			echo -e "下载APK包"
			wget -O android.apk http://${wget_host}/${files}/v6.apk >/dev/null 2>&1
		
			echo -e "清理旧的目录"
			rm -rf android
			echo -e "分析APK"
			wget -O apktool.jar http://${wget_host}/${files}/apktool.jar >/dev/null 2>&1 &&java -jar apktool.jar d android.apk
			echo -e "批量替换"
			chmod 0777 -R /home/android
			sed -i 's/demo.dingd.cn:80/'${domain}:${port}'/g' /home/android/smali/net/openvpn/openvpn/base.smali >/dev/null 2>&1
			sed -i 's/APP_KEY_CODE/'a1930c5644ce5c74611c23d8aac878e2'/g' /home/android/smali/net/openvpn/openvpn/base.smali >/dev/null 2>&1
			sed -i 's/demo.dingd.cn:80/'${domain}:${port}'/g' "/home/android/smali/net/openvpn/openvpn/OpenVPNClient.smali" >/dev/null 2>&1
			sed -i 's/demo.dingd.cn:80/'${domain}:${port}'/g' "/home/android/smali/net/openvpn/openvpn/OpenVPNClient\$10.smali" >/dev/null 2>&1
			sed -i 's/demo.dingd.cn:80/'${domain}:${port}'/g' "/home/android/smali/net/openvpn/openvpn/OpenVPNClient\$11.smali" >/dev/null 2>&1
			sed -i 's/demo.dingd.cn:80/'${domain}:${port}'/g' "/home/android/smali/net/openvpn/openvpn/OpenVPNClient\$13.smali" >/dev/null 2>&1
			sed -i 's/demo.dingd.cn:80/'${domain}:${port}'/g' "/home/android/smali/net/openvpn/openvpn/Main2Activity\$MyListener\$1.smali" >/dev/null 2>&1
			sed -i 's/demo.dingd.cn:80/'${domain}:${port}'/g' '/home/android/smali/net/openvpn/openvpn/Main2Activity$MyListener.smali' >/dev/null 2>&1
			sed -i 's/demo.dingd.cn:80/'${domain}:${port}'/g' '/home/android/smali/net/openvpn/openvpn/MainActivity.smali' >/dev/null 2>&1
			sed -i 's/demo.dingd.cn:80/'${domain}:${port}'/g' '/home/android/smali/net/openvpn/openvpn/update$myClick$1.smali' >/dev/null 2>&1
			sed -i 's/叮咚流量卫士/'${app_name}'/g' "/home/android/res/values/strings.xml" >/dev/null 2>&1
			echo -e "打包"
			java -jar apktool.jar b android
			
			if test -f /home/android/dist/android.apk;then 
				echo -e "APK生成完毕"
					#cd /home/android/dist
				wget -O autosign.zip http://${wget_host}/${files}/autosign.zip >/dev/null 2>&1 && unzip -o autosign.zip 
				rm -rf ${web_path}/app_api/dingd.apk
				cd autosign 
				echo "签名APK...."
				cp -rf /home/android/dist/android.apk /home/unsign.apk
			#	jarsigner -verbose -keystore mydemo.keystore -signedjar -/home/unsign.apk Notes.apk mydemo.keystore 
				java -jar signapk.jar testkey.x509.pem testkey.pk8 /home/unsign.apk /home/sign.apk 
				cp -rf /home/sign.apk  ${web_path}/app_api/dingd.apk
				echo "签名完成...."			
        
				#rm -rf /home/dingd.apk
				rm -rf /home/sign.apk
				rm -rf /home/unsign.apk
				rm -rf /home/android.apk
				rm -rf /home/android
				rm -rf /home/autosign.zip
				rm -rf /home/apktool.jar
				rm -rf /home/setup.bash
				rm -rf /home/autosign
			else
				echo "
	---------------------------------------------------------
	生成失败！请下载修改源手动对接！不会的可以联系作者
	---------------------------------------------------------
	修改源位于 /home/dingd.apk 
  ---------------------------------------------------------
  过滤字符串demo.dingd.cn:80全部替换成授权域名
  ---------------------------------------------------------
  过滤APP_KEY替换成32位授权码
	---------------------------------------------------------
	"
			exit 0
		fi #安装失败
	
	fi #APP制作
clear
echo "
---------------------------------------------------------
安装已经完成 如果您选择的全部安装 请您重新访问
---------------------------------------------------------
http://$domain:$port/app_api/install
---------------------------------------------------------
运行云端安装向导
---------------------------------------------------------

---------------------------------------------------------
APP请在
---------------------------------------------------------
http://$domain:$port/app_api/dingd.apk
---------------------------------------------------------
下载
---------------------------------------------------------
                      by 小白扮大神 2016-03-22  
---------------------------------------------------------
"
exit 0

