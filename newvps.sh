#!/bin/bash

# ZMT စာသားအကြီးကို အပြာရောင်ဖြင့် ဖော်ပြရန်
echo -e "\e[1;34m"
cat << "EOF"
███████╗███╗   ███╗████████╗
╚══███╔╝████╗ ████║╚══██╔══╝
  ███╔╝ ██╔████╔██║   ██║   
 ███╔╝  ██║╚██╔╝██║   ██║   
███████╗██║ ╚═╝ ██║   ██║   
╚══════╝╚═╝     ╚═╝   ╚═╝   
EOF
echo -e "\e[0m"

echo "Hello! This is ZMT setup script for New VPS."
echo "System update စတင်နေပါသည်..."

# 1. System Update နှင့် လိုအပ်သော Tools များ သွင်းခြင်း
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl socat wget git ufw apt-transport-https ca-certificates software-properties-common

# 2. Timezone ချိန်ခြင်း (Asia/Yangon)
echo "Timezone ကို Asia/Yangon သို့ ချိန်ညှိနေပါသည်..."
sudo timedatectl set-timezone Asia/Yangon
timedatectl status

# 3. TCP BBR Enable လုပ်ခြင်း (Network Speed မြန်ဆန်စေရန်)
echo "Network Optimization (BBR) ပြုလုပ်နေပါသည်..."
echo "net.core.default_qdisc=fq" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# 4. Docker Install လုပ်ခြင်း (Marzban & Outline အတွက် မရှိမဖြစ်လိုအပ်ပါသည်)
echo "Docker ကို Install လုပ်နေပါသည်..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

# 5. Firewall (UFW) ချိန်ညှိခြင်း
echo "UFW Firewall ကို ချိန်ညှိနေပါသည်..."
sudo ufw allow 22/tcp        # SSH (အရေးကြီးပါသည်)
sudo ufw allow 80/tcp        # HTTP
sudo ufw allow 8000/tcp      # Marzban Web Panel (Default)

# Proxy Core Ports များ
sudo ufw allow 443/tcp       # VLESS REALITY / HTTPS
sudo ufw allow 1080/tcp      # Shadowsocks TCP
sudo ufw allow 1080/udp      # Shadowsocks UDP
sudo ufw allow 2053/tcp      # Trojan TLS
sudo ufw allow 2083/tcp      # VLESS WS TLS
sudo ufw allow 4427/tcp      # VMESS + TCP
sudo ufw allow 8443/tcp      # VMess WS TLS
sudo ufw allow 9094/tcp      # TROJAN + TCP
sudo ufw allow 9850/tcp      # VLESS TLS

# UFW ကို ဖွင့်ပါမည်
echo "y" | sudo ufw enable

# 6. Outline Server Install လုပ်ခြင်း
echo -e "\e[1;36mOutline Server ကို Install လုပ်နေပါသည်...\e[0m"
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-server/master/src/server_manager/install_scripts/install_server.sh)"

# 7. နိဂုံးချုပ် နှင့် အရေးကြီး သတိပေးချက်
echo "--------------------------------------------------------"
echo -e "\e[1;32mVPS Setup အောင်မြင်စွာ ပြီးစီးပါပြီ!\e[0m"
echo "--------------------------------------------------------"

echo -e "\e[1;33m"
echo "======================================================================"
echo "⚠️ အရေးကြီးသတိပေးချက် (IMPORTANT WARNING) ⚠️"
echo "======================================================================"
echo "Outline Server မှ အပေါ်တွင် အစိမ်းရောင်စာသားဖြင့် ထုတ်ပေးလိုက်သော"
echo "'Management Port' နှင့် 'Access Key Port' များကို UFW တွင် ဖွင့်ပေးရန် လိုအပ်ပါသည်။"
echo ""
echo "Outline က ပေးသော Port များကို ကြည့်၍ အောက်ပါအတိုင်း ဖွင့်ပေးပါ - "
echo "ဥပမာ (Port 12345 နှင့် 54321 ရလျှင်):"
echo "sudo ufw allow 12345/tcp"
echo "sudo ufw allow 54321/tcp"
echo "sudo ufw allow 54321/udp"
echo "======================================================================"
echo -e "\e[0m"
