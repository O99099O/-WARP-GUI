---

# 🌐 WARP Zenity GUI

GUI sederhana untuk **Cloudflare WARP CLI** menggunakan **Zenity** di Linux.
Script ini memudahkan pengguna untuk mengontrol WARP melalui tampilan grafis tanpa perlu mengetik perintah di terminal.

---

## ✨ Fitur

* 🔌 **Connect / Disconnect** WARP dengan sekali klik
* ❌ **Disconnect ALL** (hapus registrasi & reset DNS)
* 📊 **Status & Statistik** koneksi
* 🔄 **Restart Daemon warp-svc**
* 🔐 **Atur Mode** (warp, warp+doh, proxy, gateway)
* 🛡️ **DNS Filtering** (off / malware / full)
* 📜 **Lihat Sertifikat**
* ⚙️ **Reset Pengaturan**
* 👤 **About Creator**

---

## 📦 Dependensi

Script ini memerlukan beberapa paket agar berjalan dengan baik:

* **warp-cli** (Cloudflare WARP CLI)
* **zenity** (untuk GUI berbasis dialog box di Linux)
* **systemd** (untuk mengontrol service `warp-svc`)

---

## 🚀 Instalasi

### 1. Install WARP CLI

Ikuti instruksi resmi dari Cloudflare:

```bash
# Debian/Ubuntu
curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloudflare-warp.gpg
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
sudo apt update
sudo apt install cloudflare-warp -y
```

### 2. Install Zenity

```bash
sudo apt install zenity -y
```

### 3. Clone Repository

```bash
git clone https://github.com/USERNAME/warp-zenity-gui.git
cd warp-zenity-gui
chmod +x warp-gui.sh
```

### 4. Jalankan Script

```bash
./warp-gui.sh
```

---

## 🖼️ Screenshot (Opsional)

Tambahkan screenshot GUI agar lebih menarik.
Contoh:

```
[ Gambar Connect / Disconnect ]
[ Gambar Status Info ]
```

---

## 📜 Lisensi

Project ini dirilis di bawah lisensi **MIT License**.
Bebas digunakan, dimodifikasi, dan dibagikan.

---

## 👤 Tentang Creator

* Nama: **Poloss**
* GitHub: [O99099O](https://github.com/O99099O)
* Versi: **0.1**

---

👉 Saran nama repo yang cocok:

* `warp-zenity-gui`
* `cloudflare-warp-gui`
* `warp-linux-gui`

---
