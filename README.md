# 🐱 Cat & Rocket Prompt for Ghostty

A lightweight, animated Bash prompt designed for developers who love **Rust**, **AI**, and **Clean Terminals**. Featuring a walking cat animation and dynamic Git status integration.

## 👀 Preview

<p align="center">
  <img src="./assets/preview.jpg" alt="Cat Rocket Prompt Preview" width="700px" style="border-radius: 8px;">
</p>

## 🚀 Features
- **Walking Cat Animation**: The cat cycles through 4 frames every time you hit Enter.
- **Dynamic Git Status**:
  - `🚀` (Rocket) when on `main` or `master` branch.
  - `🧪` (Flask) when on a feature branch.
  - `🍺` (Beer) when outside a Git repository.
- **Smart Pathing**: Automatically shortens directory paths (e.g., `/home/nova/dev/soulrouter` -> `~/d/soulrouter`).
- **Ghostty Optimized**: Pre-configured for the **Ghostty** terminal for maximum performance and draggable windows.

## 🛠 Installation

### 1. Requirements
- **Terminal**: [Ghostty](https://ghostty.org/) (Recommended)
- **Font**: [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads) (Mandatory for icons)
- **OS**: Pop!_OS / Ubuntu / Any Debian-based Linux

### 2. Fast Setup
Clone this repository and run the installer:
```bash
git clone [https://github.com/bombman/cat-rocket-prompt.git](https://github.com/bombman/cat-rocket-prompt.git)
cd cat-rocket-prompt
bash install.sh
source ~/.bashrc


⚙️ Manual Customization
If you want to change the cat or icons, edit scripts/prompt.sh:

Modify cat_frames for different animals.
Change tail_icon for different Git statuses.

📝 Configuration (Ghostty)
The included ghostty.config sets the terminal to:
Solid background (No transparency for better focus).
Native decorations (Draggable title bar).
Nerd Font integration.

🤝 Contributing
Feel free to fork this project and add more animations or indicators (like GPU temp or RAM usage)!