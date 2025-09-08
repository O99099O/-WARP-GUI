#!/bin/bash

# ==========================
# Configuration
# ==========================
VERSION="1.0"
AUTHOR="Poloss"
GITHUB_URL="https://github.com/O99099O/-WARP-GUI"
WARP_WEBSITE="https://1.1.1.1/"

# ==========================
# Fungsi: Cek apakah warp-cli terpasang
# ==========================
check_installation() {
  if ! command -v warp-cli &> /dev/null; then
    zenity --error --title="WARP Tidak Ditemukan" \
      --text="❌ Cloudflare WARP belum terinstall.\n\nSilakan install dari GitHub berikut:\n\n${GITHUB_URL}" \
      --width=400
    xdg-open "${GITHUB_URL}" >/dev/null 2>&1 &
    exit 1
  fi
}

# ==========================
# Fungsi: Pastikan daemon aktif
# ==========================
check_daemon() {
  if ! pgrep -x "warp-svc" > /dev/null; then
    zenity --question --title="WARP Daemon" \
      --text="⚠️ WARP daemon tidak berjalan. Jalankan sekarang?" \
      --width=300
    if [ $? -eq 0 ]; then
      (
        echo "10"
        if systemctl --user start warp-svc 2>/dev/null; then
          echo "50"
        elif sudo systemctl start warp-svc 2>/dev/null; then
          echo "50"
        else
          zenity --error --text="Gagal menjalankan warp-svc. Coba jalankan manual: sudo systemctl start warp-svc"
          exit 1
        fi
        sleep 3
        echo "100"
      ) | zenity --progress --title="Starting WARP" --text="Memulai WARP service..." --percentage=0 --auto-close
    else
      exit 1
    fi
  fi
}

# ==========================
# Fungsi: Registrasi kalau belum ada
# ==========================
ensure_registered() {
  if warp-cli status 2>&1 | grep -q "Registration missing"; then
    zenity --info --title="Registrasi" \
      --text="📝 Registrasi baru diperlukan. Membuat registrasi..." \
      --width=300
    
    (
      echo "20"
      warp-cli register >/dev/null 2>&1
      echo "40"
      warp-cli set-accept-tos true >/dev/null 2>&1
      echo "60"
      sleep 2
      echo "100"
    ) | zenity --progress --title="Registrasi" --text="Mendaftarkan perangkat..." --percentage=0 --auto-close
  fi
}

# ==========================
# Fungsi: Connect ke WARP + verifikasi
# ==========================
warp_connect() {
  (
    echo "10"
    warp-cli connect >/dev/null 2>&1
    echo "50"
    sleep 5
    echo "75"
    
    # Verifikasi koneksi
    if timeout 10 curl -s https://www.cloudflare.com/cdn-cgi/trace/ | grep -q "warp=on"; then
      echo "100"
      zenity --info --title="Koneksi Berhasil" \
        --text="✅ WARP berhasil tersambung.\n\nAlamat IP saat ini:\n$(curl -s https://ifconfig.me/ip)" \
        --width=400
    else
      zenity --error --title="Koneksi Gagal" \
        --text="❌ Gagal connect ke WARP.\n\nCoba manual:\nwarp-cli disconnect\nwarp-cli connect" \
        --width=400
    fi
  ) | zenity --progress --title="Menyambungkan" --text="Menyambungkan ke WARP..." --percentage=0 --auto-close
}

# ==========================
# Fungsi: Tampilkan status detail
# ==========================
show_detailed_status() {
  local status
  status=$(warp-cli status 2>&1)
  if echo "$status" | grep -q "Registration missing"; then
    zenity --info --title="Status" --text="Status: Tidak terdaftar" --width=300
  else
    zenity --text-info --title="Status WARP" \
      --filename=<(echo "=== STATUS WARP ==="; 
                   warp-cli status; 
                   echo -e "\n=== MODE ==="; 
                   warp-cli mode; 
                   echo -e "\n=== DNS FILTER ==="; 
                   warp-cli dns families; 
                   echo -e "\n=== ALAMAT IP ==="; 
                   curl -s https://ifconfig.me/ip) \
      --width=600 --height=500
  fi
}

# ==========================
# Fungsi: Set mode koneksi
# ==========================
set_mode() {
  local mode
  mode=$(zenity --list --title="Set Mode Koneksi" \
    --column="Mode" --column="Deskripsi" \
    "warp" "Mode standar WARP" \
    "warp+doh" "WARP dengan DNS-over-HTTPS" \
    "proxy" "Mode proxy saja" \
    "gateway" "Mode gateway" \
    --height=250 --width=400)
  
  if [ -n "$mode" ]; then
    if warp-cli mode "$mode" >/dev/null 2>&1; then
      zenity --info --title="Berhasil" --text="🌐 Mode diubah ke: $mode" --width=300
    else
      zenity --error --title="Gagal" --text="❌ Gagal mengubah mode ke: $mode" --width=300
    fi
  fi
}

# ==========================
# Fungsi: Set DNS filter
# ==========================
set_dns_filter() {
  local filter
  filter=$(zenity --list --title="Set DNS Filter" \
    --column="Filter" --column="Deskripsi" \
    "off" "Tidak ada filtering" \
    "malware" "Blokir malware" \
    "full" "Blokir malware dan konten dewasa" \
    --height=200 --width=400)
  
  if [ -n "$filter" ]; then
    if warp-cli dns families "$filter" >/dev/null 2>&1; then
      zenity --info --title="Berhasil" --text="🔒 DNS filter diatur ke: $filter" --width=300
    else
      zenity --error --title="Gagal" --text="❌ Gagal mengatur DNS filter" --width=300
    fi
  fi
}

# ==========================
# Fungsi: Tampilkan certificate
# ==========================
show_certificates() {
  local certs
  certs=$(warp-cli certificates 2>&1)
  if [ $? -eq 0 ]; then
    zenity --text-info --title="Sertifikat WARP" --filename=<(echo "$certs") --width=700 --height=500
  else
    zenity --error --title="Error" --text="Gagal mengambil informasi sertifikat" --width=300
  fi
}

# ==========================
# Fungsi: Tampilkan stats
# ==========================
show_stats() {
  local stats
  stats=$(warp-cli account 2>&1)
  if [ $? -eq 0 ]; then
    zenity --text-info --title="Statistik Akun" --filename=<(echo "$stats") --width=600 --height=400
  else
    zenity --error --title="Error" --text="Gagal mengambil statistik akun" --width=300
  fi
}

# ==========================
# Fungsi: Restart daemon
# ==========================
restart_daemon() {
  (
    echo "20"
    warp-cli disconnect >/dev/null 2>&1
    echo "40"
    
    if systemctl --user restart warp-svc 2>/dev/null || sudo systemctl restart warp-svc 2>/dev/null; then
      echo "70"
      sleep 5
      echo "100"
      zenity --info --title="Berhasil" --text="🔁 Daemon warp-svc berhasil direstart." --width=300
    else
      zenity --error --title="Gagal" --text="Gagal merestart daemon. Coba jalankan manual dengan sudo." --width=300
    fi
  ) | zenity --progress --title="Restarting Daemon" --text="Merestart WARP service..." --percentage=0 --auto-close
}

# ==========================
# Fungsi: Reset settings
# ==========================
reset_settings() {
  zenity --question --title="Konfirmasi" \
    --text="⚠️ Yakin ingin reset semua pengaturan WARP ke default?" \
    --width=400
  if [ $? -eq 0 ]; then
    if warp-cli settings reset >/dev/null 2>&1; then
      zenity --info --title="Berhasil" --text="⚙️ Semua pengaturan di-reset ke default." --width=300
    else
      zenity --error --title="Gagal" --text="Gagal mereset pengaturan." --width=300
    fi
  fi
}

# ==========================
# Fungsi: Tentang pembuat
# ==========================
about_creator() {
  zenity --info --title="Tentang Pembuat" --width=400 --height=200 \
    --text="<span size='large' weight='bold'>WARP GUI</span>\n\nVersi: ${VERSION}\nDibuat oleh: ${AUTHOR}\nGitHub: ${GITHUB_URL}\n\nTerima kasih telah menggunakan WARP GUI!"
}

# ==========================
# Fungsi: Menu utama
# ==========================
main_menu() {
  while true; do
    CHOICE=$(zenity --list --title="Cloudflare WARP GUI" \
      --column="Aksi" --column="Deskripsi" \
      "Sambungkan" "Sambungkan ke WARP" \
      "Putuskan" "Putuskan koneksi WARP" \
      "Status" "Tampilkan status detail" \
      "Mode" "Ubah mode koneksi (warp/proxy)" \
      "DNS Filter" "Atur filtering DNS" \
      "Restart" "Restart WARP service" \
      "Sertifikat" "Tampilkan sertifikat" \
      "Statistik" "Tampilkan statistik akun" \
      "Reset" "Reset pengaturan ke default" \
      "Website" "Buka website Cloudflare WARP" \
      "Tentang" "Tentang pembuat aplikasi" \
      "Keluar" "Keluar dari aplikasi" \
      --height=500 --width=600 --hide-header)
    
    case $CHOICE in
      "Sambungkan")
        ensure_registered
        warp_connect
        ;;
      "Putuskan")
        warp-cli disconnect >/dev/null 2>&1
        zenity --info --title="Terputus" --text="❌ Terputus dari WARP." --width=250
        ;;
      "Status")
        show_detailed_status
        ;;
      "Mode")
        set_mode
        ;;
      "DNS Filter")
        set_dns_filter
        ;;
      "Restart")
        restart_daemon
        ;;
      "Sertifikat")
        show_certificates
        ;;
      "Statistik")
        show_stats
        ;;
      "Reset")
        reset_settings
        ;;
      "Website")
        xdg-open "${WARP_WEBSITE}" >/dev/null 2>&1 &
        ;;
      "Tentang")
        about_creator
        ;;
      "Keluar")
        exit 0
        ;;
      *)
        exit 0
        ;;
    esac
  done
}

# ==========================
# Eksekusi awal
# ==========================
check_installation
check_daemon
ensure_registered

# ==========================
# Jalankan menu utama
# ==========================
main_menu
