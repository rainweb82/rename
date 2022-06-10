# URL监控脚本

#### 介绍
使用shell脚本实时监控域名是否可正常访问，支持微信消息推送，每日监控报告等功能。

#### 运行软件termax

安卓：https://github.com/termux/termux-app/releases<br />
MAC：https://github.com/electerm/electerm/releases

#### 微信推送pushplus

自行前往http://www.pushplus.plus/注册，并填写token

#### 首次执行

pkg install git && git clone --depth 1 https://gitee.com/iamruirui/watchurl.git watchdog && cp ./watchdog/run.sh run.sh && cp ./watchdog/config config

#### 运行程序

bash run.sh

#### 配置程序

config为配置文件，可修改./config文件来调整配置<br />
url.list内为需监控的域名，程序会更新线上url.list文件，修改域名时直接修改线上url.list后，重新运行程序或等待程序自动更新即可