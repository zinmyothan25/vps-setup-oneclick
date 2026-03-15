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

echo "Hello! This is my setup script for New VPS."
echo "System update စတင်နေပါသည်..."

# 1. System Update နှင့် လိုအပ်သော Tools များ သွင်းခြင်း
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl socat wget git ufw

# 2. Timezone ချိန်ခြင်း
sudo timedatectl set-timezone Asia/Yangon
timedatectl status

# 3. Firewall (UFW) ချိန်ညှိခြင်း (လိုအပ်သော Port များကိုသာ ဖွင့်ပါမည်)
echo "UFW Firewall ကို ချိန်ညှိနေပါသည်..."

# အခြေခံ Ports များ
sudo ufw allow 22/tcp        # SSH (အရေးကြီးပါသည်)
sudo ufw allow 80/tcp        # HTTP
sudo ufw allow 8000/tcp      # Marzban Web Panel (Default)

# Proxy Core Ports များ (JSON Config အရ)
sudo ufw allow 443/tcp       # VLESS REALITY / HTTPS
sudo ufw allow 1080/tcp      # Shadowsocks TCP
sudo ufw allow 1080/udp      # Shadowsocks UDP
sudo ufw allow 2053/tcp      # Trojan TLS
sudo ufw allow 2083/tcp      # VLESS WS TLS
sudo ufw allow 4427/tcp      # VMESS + TCP
sudo ufw allow 8443/tcp      # VMess WS TLS
sudo ufw allow 9094/tcp      # TROJAN + TCP
sudo ufw allow 9850/tcp      # VLESS TLS

sudo ufw --force enable
sudo ufw status

# 4. Outline Server Install လုပ်ခြင်း
echo "Outline Server စတင် Install လုပ်နေပါပြီ..."
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-apps/master/server_manager/install_scripts/install_server.sh)"

# 5. နိဂုံးချုပ်
echo "--------------------------------------------------------"
echo "ရရှိလာသော installation output (အစိမ်းရောင်စာသားများ) ကို Outline Manager ထဲကို ကူးထည့်ပါ။"
echo "သတိပြုရန်: အထက်ပါ Output တွင် ပြထားသော Management Port နှင့် Access Key Port များကို UFW တွင် ထပ်မံဖွင့်ပေးရန် လိုအပ်ပါမည်။"
echo "ပြီးစီးပါပြီ!"
