# Kelompok A05

- 5025201020 - Muhammad Ferdian Iqbal
- 5025201039 - Abd. Wahid
- 5025201197 - Abidjanna Zulfa Hamdika
  <br><br>

### Initial Project

> wise.a05.com

<br>

![Gambar Ostania](./images/ostania.png)

<br/>

![Gambar Wise](./images/wise.png)

### 1. Semua node terhubung ke router Ostania sehingga dapat mengakses internet

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

<br>
<hr>
<br>

### 5. DNS Slave di Berlint

![Gambar 5](./images/5.png)

<br>
<hr>
<br>

### 6. Subdomain yang khusus untuk operation yaitu operation.wise.yyy.com dengan alias www.operation.wise.yyy.com

![Gambar 6](./images/6.png)

<br>
<hr>
<br>

### 7. Subdomainmelalui Berlint dengan akses strix.operation.wise.yyy.com dengan alias www.strix.operation.wise.yyy.com

![Gambar 7](./images/7.png)

<br>
<hr>
<br>

### 8. Webserver dengan DocumentRoot pada /var/www/wise.yyy.com

![Gambar 8](./images/8.png)

<br>
<hr>
<br>

### 9. Url www.wise.yyy.com/index.php/home dapat menjadi www.wise.yyy.com/home

![Gambar 9](./images/9.png)

<br>
<hr>
<br>

### 10. Pada subdomain www.eden.wise.yyy.com, Loid membutuhkan penyimpanan aset yang memiliki DocumentRoot pada /var/www/eden.wise.yyy.com

![Gambar 10](./images/10.png)

<br>
<hr>
<br>

### 11. Pada folder /public, Loid ingin hanya dapat melakukan directory listing saja

![Gambar 11](./images/11.png)

<br>
<hr>
<br>

### 12. Error file 404.html pada folder /error untuk mengganti error kode pada apache

![Gambar 12](./images/12.png)

<br>
<hr>
<br>

### 13. Membuat konfigurasi virtual host. Virtual host ini bertujuan untuk dapat mengakses file asset www.eden.wise.yyy.com/public/js menjadi www.eden.wise.yyy.com/js

![Gambar 13](./images/13.png)

<br>
<hr>
<br>

### 14. www.strix.operation.wise.yyy.com hanya bisa diakses dengan port 15000 dan port 15500

![Gambar 14](./images/14.png)

<br>
<hr>
<br>

### 15. Autentikasi username Twilight dan password opStrix dan file di /var/www/strix.operation.wise.yyy

![Gambar 15](./images/15.png)

<br>
<hr>
<br>

### 16. Mengakses IP Eden akan dialihkan secara otomatis ke www.wise.yyy.com

![Gambar 16](./images/16.png)

<br>
<hr>
<br>

### 17. Mengubah request gambar yang memiliki substring “eden” akan diarahkan menuju eden.png.

![Gambar 17](./images/17.png)
