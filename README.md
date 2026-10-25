# 🖤 Stealth Dark SDDM Theme

A sleek, modern, dark glassmorphism theme for SDDM (Linux login screen). Features smooth animations, dynamic background blur, real user profile pictures, and deep dark aesthetic components.

Optimized for **CachyOS**, **Arch Linux**, **Ubuntu**, **Linux Mint**, **Debian**, **Pop!_OS**, and any Linux distribution using SDDM!

---

## 📸 Preview

![Theme Preview](preview.png)

---

## ✨ Features
- 🖤 **Dark Glassmorphism**: Elegant semi-transparent dark UI elements with clean borders.
- 🌫️ **Dynamic Blur**: Automatically blurs your background wallpaper behind the login cards.
- 🌊 **Smooth Animations**: Fluid fade-in and scale transitions for dropdown menus and buttons.
- 👤 **Real User Avatar**: Displays your actual Linux user profile picture automatically.
- 🇬🇧 **Forced English Date**: Days and months formatted in English regardless of system locale.
- 🚀 **Full Session Support**: Fully supports Wayland & X11 (Hyprland, COSMIC, KDE Plasma, GNOME, etc.).

---

## 🛠️ Quick One-Line Installation Guide

Just copy and paste the entire command block for your Linux distribution into your terminal!

### 🔹 For Arch Linux / CachyOS / Manjaro:
```bash
sudo pacman -S --needed qt5-graphicaleffects qt5-quickcontrols qt5-quickcontrols2 qt6-5compat git && git clone https://github.com/madebydarkxz/stealth-dark-sddm.git && cd stealth-dark-sddm && sudo cp -r . /usr/share/sddm/themes/stealth-dark && sudo mkdir -p /etc/sddm.conf.d && echo -e "[Theme]\nCurrent=stealth-dark" | sudo tee /etc/sddm.conf.d/theme.conf && sddm-greeter --test-mode --theme /usr/share/sddm/themes/stealth-dark

🔹 For Ubuntu / Linux Mint / Pop!_OS / Debian:

Bash

sudo apt update && sudo apt install -y qml-module-qtgraphicaleffects qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-layouts sddm git && git clone https://github.com/madebydarkxz/stealth-dark-sddm.git && cd stealth-dark-sddm && sudo cp -r . /usr/share/sddm/themes/stealth-dark && sudo mkdir -p /etc/sddm.conf.d && echo -e "[Theme]\nCurrent=stealth-dark" | sudo tee /etc/sddm.conf.d/theme.conf && sddm-greeter --test-mode --theme /usr/share/sddm/themes/stealth-dark

🖼️ Custom Wallpaper

You can easily use your own wallpaper:

    Rename your preferred image to background.jpg.
    Replace the background.jpg file located in /usr/share/sddm/themes/stealth-dark/ with your image.

📜 Credits

    Based on the original Ronin theme.
    Completely overhauled and updated for dark glassmorphism aesthetic, smooth transitions, and multi-distro compatibility by madebydarkxz.
