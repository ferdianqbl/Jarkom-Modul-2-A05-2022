#!/bin/bash
Ostania(){
    apt-get update
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.12.0.0/16

}

Wise() {
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install bind9 -y
echo 'zone "wise.a05.com" {
type master;
file "/etc/bind/wise/wise.a05.com";
};'
# nomor 2
echo 'zone "wise.a05.com" {
        type master;
        file "/etc/bind/wise/wise.a05.com";
};' > /etc/bind/named.conf.local
mkdir /etc/bind/wise
echo "
\$TTL    604800
@       IN      SOA     wise.a05.com. root.wise.a05.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.a05.com.
@               IN      A       10.12.3.2 ; IP Wise
www             IN      CNAME   wise.a05.com.
" > /etc/bind/wise/wise.a05.com
service bind9 restart

# nomor 3
echo "
\$TTL    604800
@       IN      SOA     wise.a05.com. root.wise.a05.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.a05.com.
@               IN      A       10.12.3.2 ; IP Wise
www             IN      CNAME   wise.a05.com.
eden           IN      A       10.12.2.3 ; IP Eden
www.eden       IN      CNAME   eden.wise.a05.com.
" > /etc/bind/wise/wise.a05.com
service bind9 restart

# nomor 4

echo '
zone "wise.a05.com" {
        type master;
        file "/etc/bind/wise/wise.a05.com";
};

zone "3.12.10.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/3.12.10.in-addr.arpa";
};' > /etc/bind/named.conf.local

echo "
\$TTL    604800
@       IN      SOA     wise.a05.com. root.wise.a05.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
3.12.10.in-addr.arpa.   IN      NS      wise.a05.com.
2                       IN      PTR     wise.a05.com.
"> /etc/bind/wise/3.12.10.in-addr.arpa
service bind9 restart


# nomor 5

echo '
zone "wise.a05.com" {
        type master;
        notify yes;
        also-notify {10.12.2.2;};  //Masukan IP Berlint tanpa tanda petik
        allow-transfer {10.12.2.2;}; // Masukan IP Berlint tanpa tanda petik
        file "/etc/bind/wise/wise.a05.com";
};

zone "2.12.10.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.12.10.in-addr.arpa";
};' > /etc/bind/named.conf.local
service bind9 restart

# nomor 6
echo "
\$TTL    604800
@       IN      SOA     wise.a05.com. root.wise.a05.com. (
                                2       ; Serial
                        604800          ; Refresh
                        86400           ; Retry
                        2419200         ; Expire
                        604800 )        ; Negative Cache TTL
;
@               IN      NS      wise.a05.com.
@               IN      A       10.12.2.3 ; IP Eden
www             IN      CNAME   wise.a05.com.
eden           IN      A       10.12.2.3 ; IP Eden
www.eden       IN      CNAME   eden.wise.a05.com.
ns1             IN      A       10.12.2.2; IP Berlint
operation           IN      NS      ns1
"> /etc/bind/wise/wise.a05.com

echo "
options {
        directory \"/var/cache/bind\";

        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
" > /etc/bind/named.conf.options

echo '
zone "wise.a05.com" {
        type master;
        //notify yes;
        //also-notify {10.12.2.2;};  Masukan IP Berlint tanpa tanda petik
        file "/etc/bind/wise/wise.a05.com";
        allow-transfer {10.12.2.2;}; // Masukan IP Berlint tanpa tanda petik
};

zone "2.12.10.in-addr.arpa" {
        type master;
        file "/etc/bind/wise/2.12.10.in-addr.arpa";
};
' >  /etc/bind/named.conf.local

service bind9 restart
}

Berlint(){
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update

apt-get update
apt-get install bind9 -y
echo '
zone "wise.a05.com" {
        type slave;
        masters { 10.12.3.2; }; // Masukan IP Wise tanpa tanda petik
        file "/var/lib/bind/wise.a05.com";
};
' > /etc/bind/named.conf.local
service bind9 restart


echo "
options {
        directory \"/var/cache/bind\";
        allow-query{any;};
        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};
" > /etc/bind/named.conf.options
echo '
zone "wise.a05.com" {
        type slave;
        masters { 10.12.3.2; }; // Masukan IP Wise tanpa tanda petik
        file "/var/lib/bind/wise.a05.com";
};

zone "operation.wise.a05.com"{
        type master;
        file "/etc/bind/operation/operation.wise.a05.com";
};
'> /etc/bind/named.conf.local
mkdir /etc/bind/operation
echo "
\$TTL    604800
@       IN      SOA     operation.wise.a05.com. root.operation.wise.a05.com. (
                                2      ; Serial
                        604800         ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
@               IN      NS      operation.wise.a05.com.
@               IN      A       10.12.2.3       ;ip Eden
www             IN      CNAME   operation.wise.a05.com.
" > /etc/bind/operation/operation.wise.a05.com
service bind9 restart


# Nomor 7
echo "
\$TTL    604800
@       IN      SOA     operation.wise.a05.com. root.operation.wise.a05.com. (
                                2      ; Serial
                        604800         ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
@               IN      NS      operation.wise.a05.com.
@               IN      A       10.12.2.3       ;ip Eden
www             IN      CNAME   operation.wise.a05.com.
strix           IN      A       10.12.2.3       ;IP Eden
www.strix       IN      CNAME   strix.operation.wise.a05.com.
" > /etc/bind/operation/operation.wise.a05.com
service bind9 restart

}

SSS(){
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
echo "
nameserver 10.12.3.2
nameserver 10.12.2.2
nameserver 10.12.2.3

" > /etc/resolv.conf
}

Garden(){
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install lynx -y
echo "
nameserver 10.12.3.2
nameserver 10.12.2.2
nameserver 10.12.2.3

" > /etc/resolv.conf
}

Eden(){
echo "nameserver 192.168.122.1" > /etc/resolv.conf
apt-get update
# nomor 8
apt-get install apache2 -y
service apache2 start
apt-get install php -y
apt-get install libapache2-mod-php7.0 -y
service apache2 
apt-get install ca-certificates openssl -y
apt-get install unzip -y
apt-get install git -y
git clone https://github.com/wahidabd/Jarkom-Modul-2.git
# unzip -o /root/Jarkom-Modul-2/\*.zip -d /root/Jarkom-Modul-2
unzip /root/Jarkom-Modul-2/eden.wise.zip -d /root/Jarkom-Modul-2/
unzip /root/Jarkom-Modul-2/strix.operation.wise.zip -d /root/Jarkom-Modul-2/
unzip /root/Jarkom-Modul-2/wise.zip -d /root/Jarkom-Modul-2/
echo "
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.a05.com
        ServerName wise.a05.com
        ServerAlias www.wise.a05.com

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/wise.a05.com.conf
a2ensite wise.a05.com
mkdir /var/www/wise.a05.com
# cp -r /root/Jarkom-Modul-2/wise/* /var/www/wise.a05.com
mv /root/Jarkom-Modul-2/wise/* /var/www/wise.a05.com
service apache2 restart

# nomor 9
a2enmod rewrite
service apache2 restart
echo "
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule (.*) /index.php/\$1 [L]
" >/var/www/wise.a05.com/.htaccess
echo "
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/wise.a05.com
        ServerName wise.a05.com
        ServerAlias www.wise.a05.com

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.a05.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/wise.a05.com.conf
service apache2 restart

# nomor 10
echo "
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.a05.com
        ServerName eden.wise.a05.com
        ServerAlias www.eden.wise.a05.com

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.a05.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/eden.wise.a05.com.conf
a2ensite eden.wise.a05.com
mkdir /var/www/eden.wise.a05.com
# cp -r /root/Jarkom-Modul-2/eden.wise/ /var/www/eden.wise.a05.com
mv /root/Jarkom-Modul-2/eden.wise/* /var/www/eden.wise.a05.com
service apache2 restart
# echo "<?php echo 'yes nomor 10' ?>" > /var/www/eden.wise.a05.com/index.php

# nomor 11

echo "
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.a05.com
        ServerName eden.wise.a05.com
        ServerAlias www.eden.wise.a05.com

        <Directory /var/www/eden.wise.a05.com>
                Options +Indexes
        </Directory>

        <Directory /var/www/eden.wise.a05.com/public>
                Options +Indexes
        </Directory>

        <Directory /var/www/eden.wise.a05.com/public/css/*>
                Options -Indexes
        </Directory>

        <Directory /var/www/eden.wise.a05.com/public/js/*>
                Options -Indexes
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.a05.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/eden.wise.a05.com.conf
service apache2 restart

# nomor 12
echo "
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.a05.com
        ServerName eden.wise.a05.com
        ServerAlias www.eden.wise.a05.com

        ErrorDocument 404 /error/404.html
        ErrorDocument 500 /error/404.html
        ErrorDocument 502 /error/404.html
        ErrorDocument 503 /error/404.html
        ErrorDocument 504 /error/404.html

        <Directory /var/www/eden.wise.a05.com>
                Options +Indexes
        </Directory>

        <Directory /var/www/eden.wise.a05.com/public>
                Options +Indexes
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.a05.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/eden.wise.a05.com.conf
service apache2 restart

# nomor 13
echo "
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.a05.com
        ServerName eden.wise.a05.com
        ServerAlias www.eden.wise.a05.com

        ErrorDocument 404 /error/404.html
        ErrorDocument 500 /error/404.html
        ErrorDocument 502 /error/404.html
        ErrorDocument 503 /error/404.html
        ErrorDocument 504 /error/404.html

        <Directory /var/www/eden.wise.a05.com/public>
                Options +Indexes
        </Directory>

        Alias \"/js\" \"/var/www/eden.wise.a05.com/public/js\"


        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.a05.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/eden.wise.a05.com.conf
service apache2 restart

# nomor 14

echo "
<VirtualHost *:15000>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.a05.com

        ServerName strix.operation.wise.a05.com
        ServerAlias www.strix.operation.wise.a05.com

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<VirtualHost *:15500>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.a05.com
        ServerName strix.operation.wise.a05.com
        ServerAlias www.strix.operation.wise.a05.com


        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/strix.operation.wise.a05.com.conf
a2ensite strix.operation.wise.a05.com
service apache2 restart
mkdir /var/www/strix.operation.wise.a05.com
# cp -r /root/Jarkom-Modul-2/strix.operation.wise/ /var/www/strix.operation.wise.a05.com/
mv /root/Jarkom-Modul-2/strix.operation.wise/* /var/www/strix.operation.wise.a05.com/
rm -rf Jarkom-Modul-2

# echo "
# <?php
#         echo 'selamat 14';
# ?>
# " > /var/www/strix.operation.wise.a05.com/index.php
echo "
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 15000
Listen 15500
<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>
" > /etc/apache2/ports.conf

service apache2 restart

# nomor 15
htpasswd -c -b /etc/apache2/.htpasswd Twilight opStrix

echo "
<VirtualHost *:15000>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.a05.com

        ServerName strix.operation.wise.a05.com
        ServerAlias www.strix.operation.wise.a05.com

        <Directory \"/var/www/strix.operation.wise.a05.com\">
                AuthType Basic
                AuthName \"Restricted Content\"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

<VirtualHost *:15500>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/strix.operation.wise.a05.com

        ServerName strix.operation.wise.a05.com
        ServerAlias www.strix.operation.wise.a05.com

        <Directory \"/var/www/strix.operation.wise.a05.com\">
                AuthType Basic
                AuthName \"Restricted Content\"
                AuthUserFile /etc/apache2/.htpasswd
                Require valid-user
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/strix.operation.wise.a05.com.conf
service apache2 restart

# nomor 16

echo "
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        RewriteEngine On
        RewriteCond %{HTTP_HOST} !^wise.a05.com$
        RewriteRule /.* http://wise.a05.com/ [R]

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
" > /etc/apache2/sites-available/000-default.conf
service apache2 restart

# nomor 17
echo "
RewriteEngine On
RewriteBase /
RewriteCond %{REQUEST_URI} !\eden.png\b
RewriteRule eden http://eden.wise.a05.com/public/images/eden.png$1 [L,R=301]
" > /var/www/eden.wise.a05.com/.htaccess

echo "
<VirtualHost *:80>

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/eden.wise.a05.com
        ServerName eden.wise.a05.com
        ServerAlias www.eden.wise.a05.com

        ErrorDocument 404 /error/404.html
        ErrorDocument 500 /error/404.html
        ErrorDocument 502 /error/404.html
        ErrorDocument 503 /error/404.html
        ErrorDocument 504 /error/404.html

        <Directory /var/www/eden.wise.a05.com/public>
                Options +Indexes
        </Directory>

        Alias \"/js\" \"/var/www/eden.wise.a05.com/public/js\"

        <Directory /var/www/eden.wise.a05.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/wise.a05.com>
                Options +FollowSymLinks -Multiviews
                AllowOverride All
        </Directory>
        
</VirtualHost>
" > /etc/apache2/sites-available/eden.wise.a05.com.conf
service apache2 restart

}

if [ $HOSTNAME == "Ostania" ]
then
    Ostania
elif [ $HOSTNAME == "WISE" ]
then
    Wise
elif [ $HOSTNAME == "Berlint" ]
then
    Berlint
elif [ $HOSTNAME == "SSS" ]
then
    SSS
elif [ $HOSTNAME == "Garden" ]
then
    Garden
elif [ $HOSTNAME == "Eden" ]
then
    Eden
fi