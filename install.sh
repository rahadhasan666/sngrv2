#!/bin/bash

# RHD Toolkit - One Line Installer
# Created by Rahad Hasan

G="\e[32m"
R="\e[31m"
Y="\e[33m"
C="\e[36m"
W="\e[0m"

clear

echo -e "${C}"
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                                                                  ║"
echo "║                    ${Y}RHD TOOLKIT INSTALLER${C}                       ║"
echo "║                                                                  ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo -e "${W}"

# Check dependencies
echo -e "\n${Y}[*] Checking dependencies...${W}\n"

DEPS=("git" "bc" "zipalign" "apksigner")
MISSING=()

for dep in "${DEPS[@]}"; do
    if ! command -v $dep &> /dev/null; then
        echo -e "${R}[-] Missing: $dep${W}"
        MISSING+=($dep)
    else
        echo -e "${G}[+] Found: $dep${W}"
    fi
done

if [ ${#MISSING[@]} -ne 0 ]; then
    echo -e "\n${Y}[!] Installing missing dependencies...${W}\n"
    
    # Detect package manager
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y ${MISSING[@]}
    elif command -v pkg &> /dev/null; then
        pkg update
        pkg install -y ${MISSING[@]}
    elif command -v pacman &> /dev/null; then
        sudo pacman -S ${MISSING[@]}
    else
        echo -e "${R}[!] Please install manually: ${MISSING[@]}${W}"
    fi
fi

# Clone repository
echo -e "\n${Y}[*] Cloning RHD Toolkit...${W}\n"
git clone https://github.com/rahadhasan666/sngrv2.git

cd sngrv2

# Make executable
chmod +x apksigner.sh

# Create alias
echo -e "\n${Y}[*] Setting up alias...${W}"
echo "alias rhd='cd ~/sngrv2 && ./apksigner.sh'" >> ~/.bashrc
source ~/.bashrc

echo -e "\n${G}"
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║                                                                  ║"
echo "║                   ${Y}✓ INSTALLATION COMPLETE ✓${G}                    ║"
echo "║                                                                  ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo -e "${W}\n"

echo -e "${C}To start RHD Toolkit:${W}"
echo -e "  ${Y}cd sngr && ./apksigner.sh${W}"

