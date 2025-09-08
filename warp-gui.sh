#!/bin/bash

# Fungsi: Pastikan daemon aktif
check_daemon() {
  if ! pgrep -x "warp-svc" > /dev/null; then
    zenity --warning --text="WARP daemon tidak berjalan. Menjalankan sekarang..."
    sudo systemctl start warp-svc
    sleep 2
  fi
}

# Jalankan pengecekan daemon saat startup
check_daemon

# Loop menu utama
while true; do
CHOICE=$(zenity --list --title="Cloudflare WARP CLI GUI" \
  --column="Action" --height=550 --width=500 \
  "Connect" \
  "Disconnect" \
  "Disconnect ALL (Clear DNS + Unregister)" \
  "Status" \
  "Set Mode (warp / proxy)" \
  "DNS Filter (off / malware / full)" \
  "Restart Daemon" \
  "Show Certificates" \
  "Show Stats" \
  "Reset Settings" \
  "About the Creator" \
  "Keluar")

case $CHOICE in
  "Connect")
    warp-cli connect && zenity --info --text="✅ Tersambung ke WARP."
    ;;
  "Disconnect")
    warp-cli disconnect && zenity --info --text="❌ Terputus dari WARP."
    ;;
  "Disconnect ALL (Clear DNS + Unregister)")
    warp-cli disconnect
    warp-cli dns families off
    warp-cli registration delete
    zenity --info --text="🧹 Semua koneksi dan DNS telah dimatikan.\nRegistrasi dihapus juga."
    ;;
  "Status")
    warp-cli status | zenity --text-info --width=600 --height=400 --title="WARP Status"
    ;;
  "Set Mode (warp / proxy)")
    MODE=$(zenity --entry --title="Set Mode" --text="Masukkan mode: warp, warp+doh, proxy, gateway")
    if [[ "$MODE" != "" ]]; then
      warp-cli mode "$MODE" && zenity --info --text="🌐 Mode diubah ke: $MODE"
    fi
    ;;
  "DNS Filter (off / malware / full)")
    DNS_MODE=$(zenity --list --title="Set DNS Filtering" \
      --column="Filter Mode" "off" "malware" "full")
    if [[ "$DNS_MODE" != "" ]]; then
      warp-cli dns families "$DNS_MODE" && zenity --info --text="🔒 DNS filter diatur ke: $DNS_MODE"
    fi
    ;;
  "Restart Daemon")
    sudo systemctl restart warp-svc && zenity --info --text="🔁 Daemon warp-svc berhasil direstart."
    ;;
  "Show Certificates")
    warp-cli certs | zenity --text-info --width=600 --height=400 --title="WARP Certificates"
    ;;
  "Show Stats")
    warp-cli stats | zenity --text-info --width=600 --height=400 --title="WARP Stats"
    ;;
  "Reset Settings")
    warp-cli settings reset && zenity --info --text="⚙️ Semua pengaturan telah di-reset ke default."
    ;;
  "About the Creator")
    zenity --info --title="About the Creator" --width=400 --height=200 \
      --text="📘 <b>About the Creator</b>\n\nScrip Simple yang dibuat oleh poloss\n\nContoh:\nNama: Poloss\nGitHub: https://github.com/O99099O\nVersi: 0.1\n\nTerima kasih telah menggunakan WARP GUI!"
    ;;
  "Keluar")
    exit 0
    ;;
  *)
    break
    ;;
esac

done
