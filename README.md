# stealth-dark-sddm
# 🖤 Stealth Dark SDDM Theme

A sleek, modern, dark theme for SDDM (Linux login screen). Features smooth animations, dynamic background blur, and deep dark aesthetic components.
Optimized for **CachyOS**, **Arch Linux**, and any Linux distribution!

---

## 📸 Preview

![Theme Preview](preview.png)

---

## ✨ Features
- 🖤 **Dark Glassmorphism**: Elegant semi-transparent dark elements.
- 🌫️ **Dynamic Blur**: Automatically blurs your background image.
- 🌊 **Smooth Animations**: Fluid fade-in and scale transitions for menus.

---

## 🛠️ Installation Guide

### Step 1: Install Dependencies
Open your terminal and run:
`sudo pacman -S qt5-graphicaleffects qt5-quickcontrols qt5-quickcontrols2 qt6-5compat`

### Step 2: Download the theme
`git clone https://github.com/madebydarkxz/stealth-dark-sddm.git`

### Step 3: Enter the folder
`cd stealth-dark-sddm`

### Step 4: Copy to system directory
`sudo cp -r . /usr/share/sddm/themes/stealth-dark`

### Step 5: Setup Configuration
`sudo mkdir -p /etc/sddm.conf.d`
`echo "[Theme]" | sudo tee /etc/sddm.conf.d/theme.conf`
`echo "Current=stealth-dark" | sudo tee -a /etc/sddm.conf.d/theme.conf`

---

## 🖼️ Custom Wallpaper
To change the background, simply replace the `background.jpg` file inside the theme folder with your own image.
