#!/bin/bash

# ဤနေရာတွင် မိမိအသုံးပြုလိုသော command များရေးရန်
echo "Hello! This is my one-click script for Outline VPN."
echo "System update စတင်နေပါသည်..."

# 1. System Update နှင့် လိုအပ်သော Tools များ သွင်းခြင်း
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl socat wget git

# 2. Timezone ချိန်ခြင်း
sudo timedatectl set-timezone Asia/Yangon
timedatectl status

# 3. Firewall (UFW) ချိန်ညှိခြင်း (လုံခြုံရေးအတွက် လိုအပ်သည်များသာ ဖွင့်ပါမည်)
sudo ufw allow OpenSSH  # SSH Connection မပြတ်သွားစေရန် အရေးကြီးပါသည်
sudo ufw --force enable
sudo ufw status

# 4. Outline Server Install လုပ်ခြင်း
echo "Outline Server စတင် Install လုပ်နေပါပြီ..."
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Jigsaw-Code/outline-apps/master/server_manager/install_scripts/install_server.sh)"

# 5. နိဂုံးချုပ်
echo "------------------------------------------------------"
echo "ရရှိလာသော installation output (အစိမ်းရောင်စာသားများ) ကို Outline Manager ထဲကို ကူးထည့်ပါ။"
echo "သတိပြုရန်: အထက်ပါ Output တွင် ပြထားသော Management Port နှင့် Access Key Port များကို UFW တွင် ထပ်မံဖွင့်ပေးရန် လိုအပ်ပါမည် (ဥပမာ - sudo ufw allow 1234/tcp)။"
echo "ပြီးစီးပါပြီ!"
