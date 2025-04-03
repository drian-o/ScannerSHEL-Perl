# Shell Scanner

![image](https://github.com/user-attachments/assets/ae7aaab1-0a80-411d-b00b-05ef7dde6b21)




## 🔍 Deskripsi

Shell Scanner adalah alat pemindaian yang dikembangkan untuk mendeteksi potensi shell web PHP di server web. WSO dapat mengidentifikasi C99, R57, Alpha dan jenis shell populer lainnya dan menggunakan sistem verifikasi lanjutan untuk meminimalkan kesalahan positif.

## ✨ Future

- **Deteksi Shell Tingkat Lanjut**: Pengenalan otomatis WSO, C99, R57, Alfa, B374K, dan jenis shell lainnya
- **Pengurangan Positif Palsu**: perbandingan 404 halaman, analisis beranda, dan kontrol konten
- **Hasil yang Dikategorikan**: Mengklasifikasikan cangkang yang ditemukan berdasarkan jenisnya
- **Menyimpan Hasil**: Menyimpan shell yang ditemukan ke file teks
- **Batas Waktu yang Dapat Disesuaikan**: Tetapkan nilai batas waktu koneksi

## 📋 Disklaimer

  - Perl 5.10 atau lebih tinggi
  - Modul Perl berikut:
  - HTTP::Permintaan
  - LWP::Agen Pengguna
  - Istilah::ANSIColor
  - Waktu :: HiRes

## 🔧 Setting

### Instalasi Manual

```bash
# Install modul Prel yang diperlukan
cpan HTTP::Request LWP::UserAgent Term::ANSIColor Time::HiRes

# Cloning Repository
git clone https://github.com/drian-o/ScannerSHEL-Perl.git
cd ScannerSHEL-Perl

# Eksekusi tools PERL
chmod +x shell-scanner.pl
```

## 🚀 Cara Kerja

```bash
# Eksesusi
perl shell-scanner.pl

# Sistem geneline kurulmuşsa
shell-scanner
```

### Örnek Çıktı

```
╔═══════════════════════════════════════════╗
║            SHELL SCANNER v2.1             ║
║          Web Shell Drian                  ║
╚═══════════════════════════════════════════╝

Contoh: www.example.com veya http://example.com
 -> example.com

[*] Scanning Running: https://seo-bone.pro/
[*] Waktu Koneksi Habis: 5 saniye
[*] Mohon Ditunggu Bujang...

[+] Shell Bulundu (WSO): http://example.com/wso.php
[+] Shell Bulundu (MINI_SHELL): http://example.com/mini.php

[*] Pemindaian selesai. Durasi: 5.23 saniye.

[+] Shell Dapat (2):
============================================================

[+] WSO Shell'ler (1):
[+] http://example.com/wso.php (24650 bytes)

[+] MINI_SHELL Shell'ler (1):
[+] http://example.com/mini.php (458 bytes)

============================================================
[+] Total Shell yang didapat.
```

## 🔒 Perlu Di Perhatikan

Alat ini harus digunakan **HANYA** untuk menguji server dan sistem Anda sendiri yang Anda izinkan. Memindai sistem orang lain tanpa izin mungkin ilegal. Pengembang tidak bertanggung jawab atas segala akibat yang timbul akibat penyalahgunaan alat ini.

## Tools dapat bekerja 100% menggunakan OS Kali Linux 
