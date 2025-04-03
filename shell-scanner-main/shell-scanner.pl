#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Request;
use LWP::UserAgent;
use Term::ANSIColor;
use Time::HiRes qw(gettimeofday tv_interval);
use URI;

# Urutan
my @c = ("\033[0;30m", "\033[1;30m", "\033[0;31m", "\033[1;31m", "\033[0;32m", "\033[1;32m", "\033[0;33m", "\033[1;33m", "\033[0;34m", "\033[1;34m", "\033[0;35m", "\033[1;35m", "\033[0;36m", "\033[1;36m", "\033[0;37m", "\033[1;37m", "\033[0m");

# Ekranı temizle
system('clear || cls');

# Banner
print "\n" . $c[5] . "╔═══════════════════════════════════════════╗\n";
print $c[5] . "║            SHELL SCANNER v2.1             ║\n";
print $c[5] . "║          Web Shell Drian                  ║\n";
print $c[5] . "╚═══════════════════════════════════════════╝\n";
print "\n" . $c[9] . "Contoh: www.example.com veya http://example.com\n\n";
print $c[5] . " -> ";

# Pengguna Dapat Masuk Ke
my $site = <STDIN>;
chomp $site;

# Verifikasi URL
my $uri = URI->new($site);
if (!$uri->scheme || !$uri->host) { die "URL Tidak Valid: $site\n"; }
if ($uri->scheme ne 'http' && $uri->scheme ne 'https') { die "Sadece HTTP ve HTTPS şemaları destekleniyor.\n"; }
$site = $uri->as_string;
$site .= "/" unless $site =~ /\/$/;

# Tarama ayarları
print $c[6] . "\n[?] Batas waktu koneksi habis (Detik) [Default: 10]: ";
my $timeout = <STDIN>;
chomp $timeout;
$timeout = 10 if $timeout eq '' || $timeout <= 0;

print $c[6] . "[?] Simpan Shell kedalam File ? [Y/n]: ";
my $save_option = <STDIN>;
chomp $save_option;
my $save_file = '';
if ($save_option =~ /^[Yy]/) {
    print $c[6] . "[?] Nama File [Default: shells_found.txt]: ";
    $save_file = <STDIN>;
    chomp $save_file;
    $save_file = "shells_found.txt" if $save_file eq '';
}

# İşlem başlangıç mesajı
print $c[3] . "\n[*] Scanning Running: $site\n";
print $c[3] . "[*] Waktu Koneksi Habis: $timeout saniye\n";
print $c[3] . "[*] Mohon Ditunggu Bujang...\n\n";

# Shell yolları
my @path = ('WSO.php','alfav4.1-tesla.php','k2.php','who1.php','config.php','dz.php','mailer.php','promailer.php','hexor.php','hb.php','fuck.php','xz.php','CaZaNoVa163.php','w.php','wp-content/plugins/akismet/akismet.php','images/stories/w.php','w.php','shell.php','cpanel.php','cpn.php','sql.php','mysql.php','config.php','configuration.php','madspot.php','Cgishell.pl','killer.php','changeall.php','2.php','Sh3ll.php','dz0.php','dam.php','user.php','dom.php','whmcs.php','r00t.php','1.php','a.php','r0k.php','abc.php','egy.php','syrian_shell.php','xxx.php','settings.php','tmp.php','cyber.php','c99.php','r57.php','404.php','gaza.php','1.php','d4rk.php','index1.php','nkr.php','xd.php','M4r0c.php','Dz.php','sniper.php','ksa.php','v4team.php','offline.php','priv8.php','911.php','madspotshell.php','c100.php','sym.php','cp.php','tmp/cpn.php','tmp/w.php','tmp/r57.php','tmp/king.php','tmp/sok.php','tmp/ss.php','tmp/as.php','tmp/dz.php','tmp/r1z.php','tmp/whmcs.php','tmp/root.php','tmp/r00t.php','templates/beez/index.php','templates/beez/beez.php','templates/rhuk_milkyway/index.php','tmp/uploads.php','tmp/upload.php','tmp/sa.php','sa.php','readme.php','tmp/readme.php','wp.zip'.'wp-content/plugins/disqus-comment-system/disqus.php',
'd0mains.php','wp-content/plugins/akismet/akismet.php','madspotshell.php','info.php','egyshell.php','Sym.php','c22.php','c100.php',
'wp-content/plugins/akismet/admin.php#','configuration.php','g.php','wp-content/plugins/google-sitemap-generator/sitemap-core.php#',
'wp-content/plugins/akismet/widget.php#','xx.pl','ls.php','Cpanel.php','k.php','zone-h.php','tmp/user.php','tmp/Sym.php','cp.php',
'tmp/madspotshell.php','tmp/root.php','tmp/whmcs.php','tmp/index.php','tmp/2.php','tmp/dz.php','tmp/cpn.php',
'tmp/changeall.php','tmp/Cgishell.pl','tmp/sql.php','0day.php','tmp/admin.php','cliente/downloads/h4xor.php',
'whmcs/downloads/dz.php','L3b.php','d.php','tmp/d.php','tmp/L3b.php','wp-content/plugins/akismet/admin.php',
'templates/rhuk_milkyway/index.php','templates/beez/index.php','sado.php','admin1.php','upload.php','up.php','vb.zip','vb.rar',
'admin2.asp','uploads.php','sa.php','sysadmins/','admin1/','sniper.php','administration/Sym.php','images/Sym.php',
'/r57.php','/wp-content/plugins/disqus-comment-system/disqus.php','gzaa_spysl','sql-new.php','/shell.php','/sa.php','/admin.php',
'/sa2.php','/2.php','/gaza.php','/up.php','/upload.php','/uploads.php','/templates/beez/index.php','shell.php','/amad.php',
'/t00.php','/dz.php','/site.rar','/Black.php','/site.tar.gz','/home.zip','/home.rar','/home.tar','/home.tar.gz',
'/forum.zip','/forum.rar','/forum.tar','/forum.tar.gz','/test.txt','/ftp.txt','/user.txt','/site.txt','/error_log','/error',
'/cpanel','/awstats','/site.sql','/vb.sql','/forum.sql','r00t-s3c.php','c.php','/backup.sql','/back.sql','/data.sql','wp.rar/',
'wp-content/plugins/disqus-comment-system/disqus.php','asp.aspx','/templates/beez/index.php','tmp/vaga.php',
'tmp/killer.php','whmcs.php','abuhlail.php','tmp/killer.php','tmp/domaine.pl','tmp/domaine.php','useradmin/',
'tmp/d0maine.php','d0maine.php','tmp/sql.php','X.php','123.php','m.php','b.php','up.php','tmp/dz1.php','dz1.php','forum.zip','Symlink.php','Symlink.pl',
'forum.rar','joomla.zip','joomla.rar','wp.php','buck.sql','sysadmin.php','images/c99.php', 'xd.php', 'c100.php',
'spy.aspx','xd.php','tmp/xd.php','sym/root/home/','billing/killer.php','tmp/upload.php','tmp/admin.php',
'Server.php','tmp/uploads.php','tmp/up.php','Server/','wp-admin/c99.php','tmp/priv8.php','priv8.php','cgi.pl/','AnonG.php','ACG.php','Manisso.asp','Manisso.php',
'AnonG2.php',
'tmp/cgi.pl','downloads/dom.php','templates/ja-helio-farsi/index.php','webadmin.html','admins.php',
'/wp-content/plugins/count-per-day/js/yc/d00.php','bluff.php','king.jeen','admins/','admins.asp','admins.php','wp.zip','/wp-content/plugins/disqus-comment-system/WSO.php',
'/wp-content/uploads/2021/01/alfav4.1-tesla.php',
'/wp-content/uploads/2021/02/alfav4.1-tesla.php',
'/wp-content/uploads/2021/03/alfav4.1-tesla.php',
'/wp-content/uploads/2021/04/alfav4.1-tesla.php',
'/wp-content/uploads/2021/05/alfav4.1-tesla.php',
'/wp-content/uploads/2021/06/alfav4.1-tesla.php',
'/wp-content/uploads/2021/07/alfav4.1-tesla.php',
'/wp-content/uploads/2021/08/alfav4.1-tesla.php',
'/wp-content/uploads/2021/09/alfav4.1-tesla.php',
'/wp-content/uploads/2021/10/alfav4.1-tesla.php',
'/wp-content/uploads/2021/11/alfav4.1-tesla.php',
'/wp-content/uploads/2021/12/alfav4.1-tesla.php',
'/wp-content/uploads/2021/01/k2.php',
'/wp-content/uploads/2021/02/k2.php',
'/wp-content/uploads/2021/03/k2.php',
'/wp-content/uploads/2021/04/k2.php',
'/wp-content/uploads/2021/05/k2.php',
'/wp-content/uploads/2021/06/k2.php',
'/wp-content/uploads/2021/07/k2.php',
'/wp-content/uploads/2021/08/k2.php',
'/wp-content/uploads/2021/09/k2.php',
'/wp-content/uploads/2021/10/k2.php',
'/wp-content/uploads/2021/11/k2.php',
'/wp-content/uploads/2021/12/k2.php',
'/wp-content/uploads/2021/01/who1.php',
'/wp-content/uploads/2021/02/who1.php',
'/wp-content/uploads/2021/03/who1.php',
'/wp-content/uploads/2021/04/who1.php',
'/wp-content/uploads/2021/05/who1.php',
'/wp-content/uploads/2021/06/who1.php',
'/wp-content/uploads/2021/07/who1.php',
'/wp-content/uploads/2021/08/who1.php',
'/wp-content/uploads/2021/09/who1.php',
'/wp-content/uploads/2021/10/who1.php',
'/wp-content/uploads/2021/11/who1.php',
'/wp-content/uploads/2021/12/who1.php',
'/wp-content/uploads/2021/01/cpanel.php',
'/wp-content/uploads/2021/02/cpanel.php',
'/wp-content/uploads/2021/03/cpanel.php',
'/wp-content/uploads/2021/04/cpanel.php',
'/wp-content/uploads/2021/05/cpanel.php',
'/wp-content/uploads/2021/06/cpanel.php',
'/wp-content/uploads/2021/08/cpanel.php',
'/wp-content/uploads/2021/09/cpanel.php',
'/wp-content/uploads/2021/10/cpanel.php',
'/wp-content/uploads/2021/11/cpanel.php',
'/wp-content/uploads/2021/12/cpanel.php',
'/wp-content/plugins/disqus-comment-system/dz.php',
'/wp-content/plugins/disqus-comment-system/DZ.php',
'/wp-content/plugins/disqus-comment-system/cpanel.php',
'/wp-content/plugins/disqus-comment-system/cpn.php',
'/wp-content/plugins/disqus-comment-system/sos.php',
'/wp-content/plugins/disqus-comment-system/term.php',
'/wp-content/plugins/disqus-comment-system/Sec-War.php',
'/wp-content/plugins/disqus-comment-system/sql.php',
'/wp-content/plugins/disqus-comment-system/ssl.php',
'/wp-content/plugins/disqus-comment-system/mysql.php',
'/wp-content/plugins/disqus-comment-system/WolF.php',
'/wp-content/plugins/disqus-comment-system/madspot.php',
'/wp-content/plugins/disqus-comment-system/Cgishell.pl',
'/wp-content/plugins/disqus-comment-system/killer.php',
'/wp-content/plugins/disqus-comment-system/changeall.php',
'/wp-content/plugins/disqus-comment-system/2.php',
'/wp-content/plugins/disqus-comment-system/Sh3ll.php',
'/wp-content/plugins/disqus-comment-system/dz0.php',
'/wp-content/plugins/disqus-comment-system/dam.php',
'/wp-content/plugins/disqus-comment-system/user.php',
'/wp-content/plugins/disqus-comment-system/dom.php',
'/wp-content/plugins/disqus-comment-system/whmcs.php',
'/wp-content/plugins/disqus-comment-system/vb.zip',
'/wp-content/plugins/disqus-comment-system/r00t.php',
'/wp-content/plugins/disqus-comment-system/c99.php',
'/wp-content/plugins/disqus-comment-system/gaza.php',
'/wp-content/plugins/disqus-comment-system/1.php',
'/wp-content/plugins/disqus-comment-system/d0mains.php',
'/wp-content/plugins/disqus-comment-system/madspotshell.php',
'/wp-content/plugins/disqus-comment-system/info.php',
'/wp-content/plugins/disqus-comment-system/egyshell.php',
'/wp-content/plugins/disqus-comment-system/Sym.php',
'/wp-content/plugins/disqus-comment-system/c22.php',
'/wp-content/plugins/disqus-comment-system/c100.php',
'/wp-content/plugins/disqus-comment-system/configuration.php',
'/wp-content/plugins/disqus-comment-system/g.php',
'/wp-content/plugins/disqus-comment-system/xx.pl',
'/wp-content/plugins/disqus-comment-system/ls.php',
'/wp-content/plugins/disqus-comment-system/Cpanel.php',
'/wp-content/plugins/disqus-comment-system/k.php',
'/wp-content/plugins/disqus-comment-system/zone-h.php',
'/wp-content/plugins/disqus-comment-system/tmp/user.php',
'/wp-content/plugins/disqus-comment-system/tmp/Sym.php',
'/wp-content/plugins/disqus-comment-system/cp.php',
'/wp-content/plugins/disqus-comment-system/tmp/madspotshell.php',
'/wp-content/plugins/disqus-comment-system/tmp/root.php',
'/wp-content/plugins/disqus-comment-system/tmp/whmcs.php',
'/wp-content/plugins/disqus-comment-system/tmp/index.php',
'/wp-content/plugins/disqus-comment-system/tmp/2.php',
'/wp-content/plugins/disqus-comment-system/tmp/dz.php',
'/wp-content/plugins/disqus-comment-system/tmp/cpn.php',
'/wp-content/plugins/disqus-comment-system/tmp/changeall.php',
'/wp-content/plugins/disqus-comment-system/tmp/Cgishell.pl',
'/wp-content/plugins/disqus-comment-system/tmp/sql.php',
'/wp-content/plugins/disqus-comment-system/0day.php',
'/wp-content/plugins/disqus-comment-system/tmp/admin.php',
'/wp-content/plugins/disqus-comment-system/L3b.php',
'/wp-content/plugins/disqus-comment-system/d.php',
'/wp-content/plugins/disqus-comment-system/tmp/d.php',
'/wp-content/plugins/disqus-comment-system/tmp/L3b.php',
'/wp-content/plugins/disqus-comment-system/sado.php',
'/wp-content/plugins/disqus-comment-system/admin1.php',
'/wp-content/plugins/disqus-comment-system/upload.php',
'/wp-content/plugins/disqus-comment-system/up.php',
'/wp-content/plugins/disqus-comment-system/vb.zip',
'/wp-content/plugins/disqus-comment-system/vb.rar',
'/wp-content/plugins/disqus-comment-system/admin2.asp',
'/wp-content/plugins/disqus-comment-system/uploads.php',
'/wp-content/plugins/disqus-comment-system/sa.php',
'/wp-content/plugins/disqus-comment-system/sysadmins/',
'/wp-content/plugins/disqus-comment-system/admin1/',
'/wp-content/plugins/disqus-comment-system/sniper.php',
'/wp-content/plugins/disqus-comment-system/images/Sym.php',
'/wp-content/plugins/disqus-comment-system//r57.php',
'/wp-content/plugins/disqus-comment-system/gzaa_spysl',
'/wp-content/plugins/disqus-comment-system/sql-new.php',
'/wp-content/plugins/disqus-comment-system//shell.php',
'/wp-content/plugins/disqus-comment-system//sa.php',
'/wp-content/plugins/disqus-comment-system//admin.php',
'/wp-content/plugins/disqus-comment-system//sa2.php',
'/wp-content/plugins/disqus-comment-system//2.php',
'/wp-content/plugins/disqus-comment-system//gaza.php',
'/wp-content/plugins/disqus-comment-system//up.php',
'/wp-content/plugins/disqus-comment-system//upload.php',
'/wp-content/plugins/disqus-comment-system//uploads.php',
'/wp-content/plugins/disqus-comment-system/shell.php',
'/wp-content/plugins/disqus-comment-system//amad.php',
'/wp-content/plugins/disqus-comment-system//t00.php',
'pwp-content/plugins/disqus-comment-system/disqus.php',
'wp-content/plugins/akismet/WSO.php',
'wp-content/plugins/akismet/dz.php',
'wp-content/plugins/akismet/DZ.php',
'wp-content/plugins/akismet/cpanel.php',
'wp-content/plugins/akismet/cpn.php',
'wp-content/plugins/akismet/sos.php',
'wp-content/plugins/akismet/term.php',
'wp-content/plugins/akismet/Sec-War.php',
'wp-content/plugins/akismet/sql.php',
'wp-content/plugins/akismet/ssl.php',
'wp-content/plugins/akismet/mysql.php',
'wp-content/plugins/akismet/WolF.php',
'wp-content/plugins/akismet/madspot.php',
'wp-content/plugins/akismet/Cgishell.pl',
'wp-content/plugins/akismet/killer.php',
'wp-content/plugins/akismet/changeall.php',
'wp-content/plugins/akismet/2.php',
'wp-content/plugins/akismet/Sh3ll.php',
'wp-content/plugins/akismet/dz0.php',
'wp-content/plugins/akismet/dam.php',
'wp-content/plugins/akismet/user.php',
'wp-content/plugins/akismet/dom.php',
'wp-content/plugins/akismet/whmcs.php',
'wp-content/plugins/akismet/vb.zip',
'wp-content/plugins/akismet/r00t.php',
'wp-content/plugins/akismet/c99.php',
'wp-content/plugins/akismet/gaza.php',
'wp-content/plugins/akismet/1.php',
'wp-content/plugins/akismet/d0mains.php',
'wp-content/plugins/akismet/madspotshell.php',
'wp-content/plugins/akismet/info.php',
'wp-content/plugins/akismet/egyshell.php',
'wp-content/plugins/akismet/Sym.php',
'wp-content/plugins/akismet/c22.php',
'wp-content/plugins/akismet/c100.php',
'wp-content/plugins/akismet/configuration.php',
'wp-content/plugins/akismet/g.php',
'wp-content/plugins/akismet/xx.pl',
'wp-content/plugins/akismet/ls.php',
'wp-content/plugins/akismet/Cpanel.php',
'wp-content/plugins/akismet/k.php',
'wp-content/plugins/akismet/zone-h.php',
'wp-content/plugins/akismet/tmp/user.php',
'wp-content/plugins/akismet/tmp/Sym.php',
'wp-content/plugins/akismet/cp.php',
'wp-content/plugins/akismet/tmp/madspotshell.php',
'wp-content/plugins/akismet/tmp/root.php',
'wp-content/plugins/akismet/tmp/whmcs.php',
'wp-content/plugins/akismet/tmp/index.php',
'wp-content/plugins/akismet/tmp/2.php',
'wp-content/plugins/akismet/tmp/dz.php',
'wp-content/plugins/akismet/tmp/cpn.php',
'wp-content/plugins/akismet/tmp/changeall.php',
'wp-content/plugins/akismet/tmp/Cgishell.pl',
'wp-content/plugins/akismet/tmp/sql.php',
'wp-content/plugins/akismet/0day.php',
'wp-content/plugins/akismet/tmp/admin.php',
'wp-content/plugins/akismet/L3b.php',
'wp-content/plugins/akismet/d.php',
'wp-content/plugins/akismet/tmp/d.php',
'wp-content/plugins/akismet/tmp/L3b.php',
'wp-content/plugins/akismet/sado.php',
'wp-content/plugins/akismet/admin1.php',
'wp-content/plugins/akismet/upload.php',
'wp-content/plugins/akismet/up.php',
'wp-content/plugins/akismet/vb.zip',
'wp-content/plugins/akismet/vb.rar',
'wp-content/plugins/akismet/admin2.asp',
'wp-content/plugins/akismet/uploads.php',
'wp-content/plugins/akismet/sa.php',
'wp-content/plugins/akismet/sysadmins/',
'wp-content/plugins/akismet/admin1/',
'wp-content/plugins/akismet/sniper.php',
'wp-content/plugins/akismet/images/Sym.php',
'wp-content/plugins/akismet//r57.php',
'wp-content/plugins/akismet/gzaa_spysl',
'wp-content/plugins/akismet/sql-new.php',
'wp-content/plugins/akismet//shell.php',
'wp-content/plugins/akismet//sa.php',
'wp-content/plugins/akismet//admin.php',
'wp-content/plugins/akismet//sa2.php',
'wp-content/plugins/akismet//2.php',
'wp-content/plugins/akismet//gaza.php',
'wp-content/plugins/akismet//up.php',
'wp-content/plugins/akismet//upload.php',
'wp-content/plugins/akismet//uploads.php',
'wp-content/plugins/akismet/shell.php',
'wp-content/plugins/akismet//amad.php',
'wp-content/plugins/akismet//t00.php',
'wp-content/plugins/akismet//dz.php',
'wp-content/plugins/akismet//site.rar',
'wp-content/plugins/akismet//Black.php',
'wp-content/plugins/akismet//site.tar.gz',
'wp-content/plugins/akismet//home.zip',
'wp-content/plugins/akismet//home.rar',
'wp-content/plugins/akismet//home.tar',
'wp-content/plugins/akismet//home.tar.gz',
'wp-content/plugins/akismet//forum.zip',
'wp-content/plugins/akismet//forum.rar',
'wp-content/plugins/akismet//forum.tar',
'wp-content/plugins/akismet//forum.tar.gz',
'wp-content/plugins/akismet//test.txt',
'wp-content/plugins/akismet//ftp.txt',
'wp-content/plugins/akismet//user.txt',
'wp-content/plugins/akismet//site.txt',
'wp-content/plugins/akismet//error_log',
'wp-content/plugins/akismet//error',
'wp-content/plugins/akismet//cpanel',
'wp-content/plugins/akismet//awstats',
'wp-content/plugins/akismet//site.sql',
'wp-content/plugins/akismet//vb.sql',
'wp-content/plugins/akismet//forum.sql',
'wp-content/plugins/akismet/r00t-s3c.php',
'wp-content/plugins/akismet/c.php',
'wp-content/plugins/akismet//backup.sql',
'wp-content/plugins/akismet//back.sql',
'wp-content/plugins/akismet//data.sql',
'wp-content/plugins/akismet/wp.rar/',
'wp-content/plugins/akismet/asp.aspx',
'wp-content/plugins/akismet/tmp/vaga.php',
'wp-content/plugins/akismet/tmp/killer.php',
'wp-content/plugins/akismet/whmcs.php',
'wp-content/plugins/akismet/abuhlail.php',
'wp-content/plugins/akismet/tmp/killer.php',
'wp-content/plugins/akismet/tmp/domaine.pl',
'wp-content/plugins/akismet/tmp/domaine.php',
'wp-content/plugins/akismet/useradmin/',
'wp-content/plugins/akismet/tmp/d0maine.php',
'wp-content/plugins/akismet/d0maine.php',
'wp-content/plugins/akismet/tmp/sql.php',
'wp-content/plugins/akismet/X.php',
'wp-content/plugins/akismet/123.php',
'wp-content/plugins/akismet/m.php',
'wp-content/plugins/akismet/b.php',
'wp-content/plugins/akismet/up.php',
'wp-content/plugins/akismet/tmp/dz1.php',
'wp-content/plugins/akismet/dz1.php',
'wp-content/plugins/akismet/forum.zip',
'wp-content/plugins/akismet/Symlink.php',
'wp-content/plugins/akismet/Symlink.pl',
'wp-content/plugins/akismet/forum.rar',
'wp-content/plugins/akismet/joomla.zip',
'wp-content/plugins/akismet/joomla.rar',
'wp-content/plugins/akismet/wp.php',
'wp-content/plugins/akismet/buck.sql',
'wp-content/plugins/akismet/sysadmin.php',
'wp-content/plugins/akismet/images/c99.php',
'wp-content/plugins/akismet/xd.php',
'wp-content/plugins/akismet/c100.php',
'wp-content/plugins/akismet/spy.aspx',
'wp-content/plugins/akismet/xd.php',
'wp-content/plugins/akismet/tmp/xd.php',
'wp-content/plugins/akismet/sym/root/home/',
'wp-content/plugins/akismet/billing/killer.php',
'wp-content/plugins/akismet/tmp/upload.php',
'wp-content/plugins/akismet/tmp/admin.php',
'wp-content/plugins/akismet/Server.php',
'wp-content/plugins/akismet/tmp/uploads.php',
'wp-content/plugins/akismet/tmp/up.php',
'wp-content/plugins/akismet/Server/',
'wp-content/plugins/akismet/wp-admin/c99.php',
'wp-content/plugins/akismet/tmp/priv8.php',
'wp-content/plugins/akismet/priv8.php',
'wp-content/plugins/akismet/cgi.pl/',
'wp-content/plugins/akismet/tmp/cgi.pl',
'wp-content/plugins/akismet/downloads/dom.php',
'wp-content/plugins/akismet/webadmin.html',
'wp-content/plugins/akismet/admins.php',
'wp-content/plugins/akismet/bluff.php',
'wp-content/plugins/akismet/king.jeen',
'wp-content/plugins/akismet/admins/',
'wp-content/plugins/akismet/admins.asp',
'wp-content/plugins/akismet/admins.php',
'wp-content/plugins/akismet/wp.zip',
'wp-content/plugins/akismet/disqus.php',);

# Bulunan shell'ler dizisi
my @found_shells = ();

# Log dosyası
open my $log_fh, ">", "scan_log.txt" or die "File Log Tidak Dpt Dibuka: $!";

# UserAgent oluştur
my $ua = LWP::UserAgent->new;
$ua->timeout($timeout);
$ua->agent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36");

# Tarama sayacı ve başlangıç zamanı
my $total_shells = scalar @path;
my $current = 0;
my $start_time = [gettimeofday];

# Verifikasi
sub is_shell {
    my ($content) = @_;
    my @keywords = ('eval', 'system', 'passthru', 'exec', 'shell_exec', 'popen', 'proc_open', 'backdoor', 'shell');
    foreach my $keyword (@keywords) { return 1 if $content =~ /\b$keyword\b/i; }
    return 1 if $content =~ /<form[^>]*method=["']?post["']?/i;
    return 0;
}

# Tarama döngüsü
foreach my $myshell (@path) {
    $current++;
    my $url = $site . $myshell;
    printf("\r%s[*] İlerleme: %d/%d (%d%%)%s", $c[6], $current, $total_shells, ($current/$total_shells*100), $c[0]);
    
    my $req = HTTP::Request->new(GET => $url);
    my $req_start_time = [gettimeofday];
    my $response = $ua->request($req);
    my $req_elapsed = tv_interval($req_start_time);
    
    print $log_fh "URL: $url, Yanıt Kodu: " . $response->code . ", Süre: " . sprintf("%.2f", $req_elapsed) . "s\n";
    
    if ($response->is_success) {
        my $content = $response->decoded_content;
        if (is_shell($content)) {
            push @found_shells, $url;
            print "\r" . $c[4] . "[+] Shell Bulundu: $url" . $c[0] . "\n";
        }
    }
    select(undef, undef, undef, 0.05);
}

# Taramayı bitir
my $elapsed = tv_interval($start_time);
print "\n" . $c[3] . "[*] Tarama tamamlandı. Süre: " . sprintf("%.2f", $elapsed) . " saniye.\n";
close $log_fh;

# Sonuçları göster
if (@found_shells) {
    print $c[4] . "\n[+] Bulunan Shell'ler (" . scalar @found_shells . "):\n";
    print $c[4] . "=" x 60 . "\n";
    foreach my $shell (@found_shells) { print $c[4] . "[+] $shell\n"; }
    print $c[4] . "=" x 60 . "\n";
    print $c[4] . "[+] Toplam " . scalar @found_shells . " shell bulundu.\n";
    
    if ($save_file ne '') {
        open my $fh, ">", $save_file or die "Dosya açılamadı: $!";
        print $fh "Hedef: $site\nTarama Tarihi: " . localtime() . "\n" . "=" x 60 . "\n\n";
        foreach my $shell (@found_shells) { print $fh "$shell\n"; }
        close $fh;
        print $c[4] . "[+] Sonuçlar '$save_file' dosyasına kaydedildi.\n";
    }
} else {
    print $c[2] . "\n[-] Hiç shell bulunamadı.\n";
}

print $c[0];
exit 0;