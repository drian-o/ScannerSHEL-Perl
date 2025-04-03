# Shell Scanner

![resim](https://github.com/user-attachments/assets/bf559926-ef1f-4484-8146-fddec480b327)



## 🔍 Genel Bakış

Shell Scanner, web sunucularında potansiyel PHP web shell'leri tespit etmek için geliştirilmiş bir tarama aracıdır. WSO, C99, R57, Alfa ve diğer popüler shell tiplerini tanımlayabilir ve yanlış pozitifleri en aza indirmek için gelişmiş bir doğrulama sistemi kullanır.

## ✨ Özellikler

- **Gelişmiş Shell Tespiti**: WSO, C99, R57, Alfa, B374K ve daha fazla shell tipini otomatik tanıma
- **Yanlış Pozitif Azaltma**: 404 sayfası karşılaştırma, ana sayfa analizi ve içerik kontrolü
- **Kategorilere Ayrılmış Sonuçlar**: Bulunan shell'leri türlerine göre sınıflandırma
- **Sonuç Kaydetme**: Bulunan shell'leri metin dosyasına kaydetme
- **Özelleştirilebilir Zaman Aşımı**: Bağlantı zaman aşımı değerini ayarlama

## 📋 Gereksinimler

- Perl 5.10 veya üstü
- Aşağıdaki Perl modülleri:
  - HTTP::Request
  - LWP::UserAgent
  - Term::ANSIColor
  - Time::HiRes

## 🔧 Kurulum

### Manuel Kurulum

```bash
# Gereken Perl modüllerini yükleyin
cpan HTTP::Request LWP::UserAgent Term::ANSIColor Time::HiRes

# Repoyu klonlayın
git clone https://github.com/frkndncr/shell-scanner.git
cd shell-scanner

# Aracı çalıştırılabilir yapın
chmod +x shell-scanner.pl
```

## 🚀 Kullanım

```bash
# Doğrudan çalıştırma
perl shell-scanner.pl

# Sistem geneline kurulmuşsa
shell-scanner
```

### Örnek Çıktı

```
╔═══════════════════════════════════════════╗
║            SHELL SCANNER v2.0             ║
║          Web Shell Tarama Aracı           ║
╚═══════════════════════════════════════════╝

Örnek: www.example.com veya http://example.com
 -> example.com

[*] Tarama başlatılıyor: http://example.com/
[*] Zaman aşımı: 10 saniye
[*] Lütfen bekleyin...

[+] Shell Bulundu (WSO): http://example.com/wso.php
[+] Shell Bulundu (MINI_SHELL): http://example.com/mini.php

[*] Tarama tamamlandı. Süre: 5.23 saniye.

[+] Bulunan Shell'ler (2):
============================================================

[+] WSO Shell'ler (1):
[+] http://example.com/wso.php (24650 bytes)

[+] MINI_SHELL Shell'ler (1):
[+] http://example.com/mini.php (458 bytes)

============================================================
[+] Toplam 2 shell bulundu.
```

## 🔒 Yasal Uyarı

Bu araç, **YALNIZCA** kendi sunucunuzu ve yetkilendirildiğiniz sistemleri test etmek için kullanılmalıdır. İzin almadan başkalarının sistemlerini taramak yasadışı olabilir. Bu aracın kötüye kullanımından doğacak herhangi bir sonuçtan geliştirici sorumlu değildir.

## 🤝 Katkıda Bulunma

1. Fork edin
2. Özellik branch'i oluşturun (`git checkout -b yeni-ozellik`)
3. Değişikliklerinizi commit edin (`git commit -m 'Yeni özellik: kısa açıklama'`)
4. Branch'inize push edin (`git push origin yeni-ozellik`)
5. Pull Request oluşturun

## 📜 Lisans

Bu proje [MIT Lisansı](LICENSE) altında lisanslanmıştır.
