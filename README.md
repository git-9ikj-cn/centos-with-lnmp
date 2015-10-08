# centos6-with-lnmp
<h2>一、Centos6：</h2>
可以设置SSH登陆密码ROOT_PASS变量<br/>
ROOT_PASS：Password<br/>
不设置为自动生成ROOT_PASS<br/>
<h2>二、采用官网的lnmp一键包</h2>
<li>1)连接SSH</li>
<li>2)安装：<br/>
screen -S lnmp<br/>
cd lnmp1.2-full && ./install.sh lnmp<br/>
输入MySQL密码，回车默认*root*
