---

# 🌐 WARP Zenity GUI

A simple GUI for **Cloudflare WARP CLI** using **Zenity** on Linux.
This script makes it easier to control WARP via a graphical interface without typing commands in the terminal.

---

## ✨ Features

* 🔌 **Connect / Disconnect** WARP with one click
* ❌ **Disconnect ALL** (unregister & reset DNS)
* 📊 **View Status & Connection Stats**
* 🔄 **Restart warp-svc Daemon**
* 🔐 **Set Mode** (warp, warp+doh, proxy, gateway)
* 🛡️ **DNS Filtering** (off / malware / full)
* 📜 **View Certificates**
* ⚙️ **Reset Settings**
* 👤 **About Creator**

---

## 📦 Dependencies

This script requires the following packages:

* **warp-cli** (Cloudflare WARP CLI)
* **zenity** (for dialog-based GUI on Linux)
* **systemd** (to manage the `warp-svc` service)

---

## 🚀 Installation

### 1. Install WARP CLI

⚠️ **Make sure you have WARP CLI installed first!**
👉 Full installation tutorials for various Linux distributions are provided below.

### 2. Install Zenity

```bash
sudo apt install zenity -y
```

### 3. Clone the Repository

```bash
git clone https://github.com/O99099O/-WARP-GUI.git
cd -WARP-GUI
chmod +x warp-gui.sh
```

### 4. Run the Script

```bash
./warp-gui.sh
```
## 📜 License

This project is released under the **MIT License**.
Free to use, modify, and share.

---

## 👤 About the Creator

* Name: **Poloss**
* GitHub: [O99099O](https://github.com/O99099O)
* Version: **0.1**

---

👉 Suggested repository names:

* `warp-zenity-gui`
* `cloudflare-warp-gui`
* `warp-linux-gui`

---

# 🌐 Cloudflare WARP CLI Installation Guide for Linux

## 🔴 Kali Linux (Debian Testing – Bookworm)

1. **Import Public Key**

```bash
curl https://pkg.cloudflareclient.com/pubkey.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
```

2. **Add Repository**

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

1. Import GPG key:

```bash
curl https://pkg.cloudflareclient.com/pubkey.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/cloudflare-warp.gpg
```

2. Add repo (adjust codename: `bullseye`, `bookworm`, or `sid`):

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

2. Add repo (auto-detect release: `focal`, `jammy`, `noble`):

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

1. Add repo:

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

*(For older CentOS, use `yum` instead of `dnf`)*

---

## 🟡 Arch Linux / Manjaro

1. Install from **AUR** (using yay/pamac):

```bash
yay -S cloudflare-warp-bin
```

or

```bash
pamac build cloudflare-warp-bin
```

---

## ✅ Verify Installation

Check if WARP is installed correctly:

```bash
warp-cli --version
```

You should see the installed version number.

---
