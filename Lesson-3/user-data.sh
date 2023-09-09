#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform using External Script222!"  >  /var/www/html/index.html
echo "<br><font color="red">And new second row"  >>  /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
