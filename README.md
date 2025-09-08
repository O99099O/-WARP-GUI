---

# 🌐 WARP Zenity GUI

GUI sederhana untuk **Cloudflare WARP CLI** menggunakan **Zenity** di Linux.
Script ini memudahkan pengguna untuk mengontrol WARP melalui tampilan grafis tanpa perlu mengetik perintah di terminal.

---

* EN README : [BUTOON](https://github.com/O99099O/-WARP-GUI/blob/main/README_EN.md)

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

# PASTIKAN DAH INSTALL WARP NYA CLI !! TUTOR DI BAWAH

### 1. Install Zenity

```bash
sudo apt install zenity -y
```

### 3. Clone Repository

```bash
git clone https://github.com/O99099O/-WARP-GUI.git
cd -WARP-GUI
chmod +x warp-gui.sh
```

### 4. Jalankan Script

```bash
./warp-gui.sh
```

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


#########################################################################
# 🌐 Tutorial Install Cloudflare WARP CLI di Linux

## 🔴 Kali Linux (Debian Testing – Bookworm)

1. **Import Public Key**

```bash
curl https://pkg.cloudflareclient.com/pubkey.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
```

2. **Tambahkan Repository**

```bash
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ bookworm main" \
  | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
```

3. **Update & Install WARP**

```bash
sudo apt update
sudo apt install cloudflare-warp -y
```

---

## 🟢 Debian (Stable / Testing / Unstable)

1. Tambahkan kunci GPG:

```bash
curl https://pkg.cloudflareclient.com/pubkey.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/cloudflare-warp.gpg
```

2. Tambahkan repo (sesuaikan codename: `bullseye`, `bookworm`, atau `sid`):

```bash
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
```

3. Install:

```bash
sudo apt update
sudo apt install cloudflare-warp -y
```

---

## 🟣 Ubuntu (20.04 / 22.04 / 24.04)

1. Import key:

```bash
curl https://pkg.cloudflareclient.com/pubkey.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/cloudflare-warp.gpg
```

2. Tambahkan repo (otomatis sesuai release: `focal`, `jammy`, `noble`):

```bash
echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
```

3. Install:

```bash
sudo apt update
sudo apt install cloudflare-warp -y
```

---

## 🔵 Fedora / CentOS / RHEL

1. Tambahkan repo:

```bash
sudo tee /etc/yum.repos.d/cloudflare-warp.repo <<EOF
[cloudflare-warp]
name=Cloudflare WARP
baseurl=https://pkg.cloudflareclient.com/fedora/$releasever/$basearch
enabled=1
gpgcheck=1
gpgkey=https://pkg.cloudflareclient.com/pubkey.gpg
EOF
```

2. Install:

```bash
sudo dnf install cloudflare-warp -y
```

*(Untuk CentOS lama pakai `yum`)*

---

## 🟡 Arch Linux / Manjaro

1. Install dari **AUR** (pakai yay/pamac):

```bash
yay -S cloudflare-warp-bin
```

atau

```bash
pamac build cloudflare-warp-bin
```

---

## ✅ Verifikasi Instalasi

Cek apakah WARP terpasang dengan benar:

```bash
warp-cli --version
```

Output harus menampilkan versi WARP.

---
