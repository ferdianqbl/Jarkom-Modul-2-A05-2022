# Kelompok A05

- 5025201020 - Muhammad Ferdian Iqbal
- 5025201039 - Abd. Wahid
- 5025201197 - Abidjanna Zulfa Hamdika
  <br><br>

### Initial Project

> wise.a05.com

<br>

![Gambar Network](./images/network.png)

<br>

![Gambar Ostania](./images/ostania.png)

<br/>

![Gambar Wise](./images/wise.png)

### 1. Semua node terhubung ke router Ostania sehingga dapat mengakses internet

![Gambar 1](./images/1.png)

> Pada soal ini, agar terhubung ke router Ostania diperlukan konfigurasi pada resolv.conf seperti pada gambar.

<br>
<hr>
<br>

### 2. Akses wise.yyy.com dengan alias www.wise.yyy.com pada folder wise

![Gambar 2](./images/2.png)

> Pada script tersebut, agar dapat mengakses alias www.wise.yyy.com maka diperlukan konfigurasi di file named.conf.local dan file di /etc/bind/wise/wise.a05.com. Dengan menambahkan konfigurasi CNAME maka www.wise.yyy.com akan bisa diakses

<br>
<hr>
<br>

### 3. Subdomain eden.wise.yyy.com dengan alias www.eden.wise.yyy.com

![Gambar 3](./images/3.png)

> Pada script tersebut, diperlukan konfigurasi tambahan pada file wise.a05.com. Konfigurasi tersebut berupa penambahan A dengan IP mengarah ke IP eden dan penambahan alias CNAME www.eden.

<br>
<hr>
<br>

### 4. Reverse domain untuk domain utama

![Gambar 4](./images/4.png)

> Pada soal ini, perlu penambahan konfigurasi pada file named.conf.local, yaitu konfigurasi zone 3.171.192.in-addr.arpa. Selanjutnya, konfigurasi juga di file zone tadi dengan NS ke wise.a05.com dan PTR ke wise.a05.com

<br>
<hr>
<br>

### 5. DNS Slave di Berlint

![Gambar 5](./images/5.png)

> Untuk membuat DNS slave, perlu konfigurasi tambahan pada named.conf.local dengan type master, notify ke IP Berlint, dan Allow-transfer ke IP Berlint. Selanjutnya Konfigurasi yang sama dilakukan di Berlint dengan type nya slave dan menuju ke IP Berlint (Gambar Konfigurasi Berlint lebih lengkap ada pada gambar di soal nomor 6).

<br>
<hr>
<br>

### 6. Subdomain yang khusus untuk operation yaitu operation.wise.yyy.com dengan alias www.operation.wise.yyy.com

![Gambar 6](./images/6.png)

> Pada soal ini, perlu konfigurasi tambahan pada wise.ao5.com. A dengan ns1 ke IP Berlint dan NS dengan operation ke ns1. Lalu, pada file named.conf.options diperlukan konfigurasi options seperti pada gambar. Pada Berlint juga hampir sama konfigurasinya dengan WISE. Perlu ditambahkan options seperti pada gambar. Selanjutnya, pada file operation/operation.wise.a05.com juga diperlukan konfigurasi seperti gambar.

<br>
<hr>
<br>

### 7. Subdomain melalui Berlint dengan akses strix.operation.wise.yyy.com dengan alias www.strix.operation.wise.yyy.com

![Gambar 7](./images/7.png)

> Pada nomor ini diperlukan konfigurasi pada file operation.wise.a05.com seperti pada gambar. CNAME atau alias untuk strix.operation.wise.yyy.com. Lalu, diperlukan konfigurasi pada SSS dan Garden seperti pada gambar. (Diperlukan konfigurasi di SSS dan Garden seperti pada gambar pada nomor - nomor sebelumnya)

<br>
<hr>
<br>

### 8. Webserver dengan DocumentRoot pada /var/www/wise.yyy.com

![Gambar 8](./images/8.png)

> Pada soal ini, diperlukan apache2, php, libapache2-mod-php7.0, openssl, unzip, dan git. Setelah itu, file - file yang dibutuhkan didownload atau diambil dari repository github yang sebelumnya, file - file sudah dimasukkan ke repo tersebut. Lalu, file - file di unzip. Setelah itu, pengaturan VirtualHost di wise.a05.com.conf.

<br>
<hr>
<br>

### 9. Url www.wise.yyy.com/index.php/home dapat menjadi www.wise.yyy.com/home

![Gambar 9](./images/9.png)

> Pada soal ini, diperlukan apache 2 dan a2enmod rewrite. Pada .htaccess diperlukan konfigurasi seperti pada gambar. Selanjutnya, pada file wise.a05.com.conf diperlukan konfigurasi VirtualHost seperti pada gambar. Terdapat konfigurasi ServerAdmin, DocumentRoot, ServerName, ServerAlias.

<br>
<hr>
<br>

### 10. Pada subdomain www.eden.wise.yyy.com, Loid membutuhkan penyimpanan aset yang memiliki DocumentRoot pada /var/www/eden.wise.yyy.com

![Gambar 10](./images/10.png)

> Pada soal ini, diperlukan konfigurasi VirtualHost seperti pada gambar, beberapa command seperti pada gambar, diperlukan membuat directory eden.wise.a05.com dan memindahkan aset di directory eden.wise ke var/www/eden.wise.a05.com

<br>
<hr>
<br>

### 11. Pada folder /public, Loid ingin hanya dapat melakukan directory listing saja

![Gambar 11](./images/11.png)

> Pada soal ini, perlu konfigurasi VirtualHost seperti pada gambar.

<br>
<hr>
<br>

### 12. Error file 404.html pada folder /error untuk mengganti error kode pada apache

![Gambar 12](./images/12.png)

> Pada soal ini, di dalam VirtualHost perlu konfigurasi ErrorDocument agar mengarah ke 404.html

<br>
<hr>
<br>

### 13. Membuat konfigurasi virtual host. Virtual host ini bertujuan untuk dapat mengakses file asset www.eden.wise.yyy.com/public/js menjadi www.eden.wise.yyy.com/js

![Gambar 13](./images/13.png)

> Pada soal ini, perlu konvigurasi <Directory> dan Aliasnya seperti pada gambar.

<br>
<hr>
<br>

### 14. www.strix.operation.wise.yyy.com hanya bisa diakses dengan port 15000 dan port 15500

![Gambar 14](./images/14.png)

> Pada soal ini, diperlukan konfigurasi pada ports.conf dengan Listen ke 80, 15000, 15500

<br>
<hr>
<br>

### 15. Autentikasi username Twilight dan password opStrix dan file di /var/www/strix.operation.wise.yyy

![Gambar 15](./images/15.png)

> Pada soal ini, diperlukan htpasswd dengan username Twilight dan password opStrix. Lalu, konfigurasi VirtualHost seperti pada gambar

<br>
<hr>
<br>

### 16. Mengakses IP Eden akan dialihkan secara otomatis ke www.wise.yyy.com

![Gambar 16](./images/16.png)

> Pada konfigurasi VirtualHost diperlukan RewriteEngine, RewriteCond, dan RewriteRule yang mengarahkan ke www.wise.yyy.com

<br>
<hr>
<br>

### 17. Mengubah request gambar yang memiliki substring ???eden??? akan diarahkan menuju eden.png.

![Gambar 17](./images/17.png)

> Diperlukan RewriteRule dengan aturan ketika terdapat substring eden akan diarahkan menuju eden.png
