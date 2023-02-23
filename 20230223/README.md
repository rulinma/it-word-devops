# AI记单词运维

## 初始化环境

参考《程序员学习和实战指南》，按如下步骤执行，指南的内容和这里是同步的，避免重复，我没有重复编写。

### Linux环境初始化

* 虚拟机下载和安装

* CentOS下载和安装

* 基础工具安装

    ``` shell

    > yum update -y
    > yum install wget -y
    > yum search ifconfig
    > yum install net-tools -y

    ```

* mysql安装
  * [CentoOS下的MySQL默认安装](https://github.com/rulinma/it/blob/main/%E4%B8%AD%E9%97%B4%E4%BB%B6/%E6%95%B0%E6%8D%AE%E5%BA%93/MySQL/README.md)

* redis安装
  * [yum安装新版本(7.X)](https://github.com/rulinma/it/blob/main/%E4%B8%AD%E9%97%B4%E4%BB%B6/%E7%BC%93%E5%AD%98/Redis/README.md)

* java安装
  * [yum安装Java环境](https://github.com/rulinma/it/blob/main/%E5%90%8E%E7%AB%AF/Java%E5%BA%94%E7%94%A8/README.md)

* nginx安装
  * [yum安装Nginx](https://github.com/rulinma/it/blob/main/DevOps/%E8%BF%90%E7%BB%B4/%E8%B4%9F%E8%BD%BD%E5%9D%87%E8%A1%A1/Nginx/README.md)

* 防火墙
  * firewall
    * 测试和开发环境为了方便，初期可以考虑直接关闭，否则要配置规则，比较麻烦，不然有时候会出现问题，一时想不到也挺这人
    * systemctl status firewalld

* nacos安装
  * [Nacos安装](https://github.com/rulinma/it/blob/main/%E6%9E%B6%E6%9E%84%E8%AE%BE%E8%AE%A1/%E6%9E%B6%E6%9E%84/%E5%BE%AE%E6%9C%8D%E5%8A%A1/%E9%85%8D%E7%BD%AE%E4%B8%AD%E5%BF%83/Nacos/README.md)

* ssl证书申请
  * 配置到Nginx中
    * 考虑测试环境，暂时没有放ssl

### 程序准备

下面的内容，我都已经放入到虚拟机中，默认开机启动。

* 初始化数据库
  * 创建库
  * 创建用户
  * 导入数据库初始数据

* 发布后端

* 发布前端

* 其他问题
  * 关闭邮件提醒
    * echo "unset MAILCHECK">> /etc/profile

### 前端访问

* 本地绑定host
  * cat /etc/hosts
    * 192.168.1.10 www.test.xianglesong.com
    * 192.168.1.10 api.test.xianglesong.com
    * ...

* <http://api.test.xianglesong.com/api/ping>
  * pong
* <http://api.test.xianglesong.com/api/swagger-ui.html>
  * 后端swagger地址
* <http://www.test.xianglesong.com>
  * 前端地址
* <http://192.168.1.10:8848/nacos>
  * nacos地址

* 启动过程可能需要点时间
  * 查看日志
    * tail -f /data/logs/word-world/log/2023-02-23/info-0.log
  * 查看端口
    * netstat -tlpn

      ``` shell
      Active Internet connections (only servers)
      Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
      tcp        0      0 0.0.0.0:6379            0.0.0.0:*               LISTEN      911/redis-server 0.
      tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      984/nginx: master p
      tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      905/sshd
      tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      1371/master
      tcp6       0      0 :::3306                 :::*                    LISTEN      1002/mysqld
      tcp6       0      0 ::1:6379                :::*                    LISTEN      911/redis-server 0.
      tcp6       0      0 :::8719                 :::*                    LISTEN      1722/java
      tcp6       0      0 :::8848                 :::*                    LISTEN      1061/java
      tcp6       0      0 :::8081                 :::*                    LISTEN      1722/java
      tcp6       0      0 :::22                   :::*                    LISTEN      905/sshd
      tcp6       0      0 ::1:25                  :::*                    LISTEN      1371/master
      ```

## 说明

* 虚拟机导入后需要可能设置网络的IP，参考自己本地设置，桥接模式，方便访问
* 其他环境问题自行检查，有问题发issure
* 前后端源码，加入会员获取，此版本为0.0.1

## 参考文献

1. [(13: Permission denied) while connecting to upstream:[nginx]](https://stackoverflow.com/questions/23948527/13-permission-denied-while-connecting-to-upstreamnginx)
   1. setsebool -P httpd_can_network_connect 1
2. [Nginx: stat() failed (13: permission denied)](https://stackoverflow.com/questions/25774999/nginx-stat-failed-13-permission-denied)
   1. setenforce permissive
