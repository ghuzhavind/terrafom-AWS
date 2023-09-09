#!/bin/bash
yum -y update
yum -y install httpd


myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html>
<h2>Bild by Power of Terraform <font color="red">v.0.1</font></h2><br>
Owner ----> ${f_name} ${l_name} <br>

%{ for name in names ~}
Hello, ${name}<br>
%{ endfor ~}

</html

EOF


sudo service httpd start
chkconfig httpd on
