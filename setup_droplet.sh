#!/bin/bash
# PTTAutoSign DigitalOcean Droplet 安裝腳本

echo "=== PTTAutoSign 安裝腳本 ==="

# 更新系統
apt update && apt upgrade -y

# 安裝 Python
apt install -y python3 python3-pip git

# 克隆專案
cd /root
git clone https://github.com/didiyee87/PTTAutoSign.git
cd PTTAutoSign

# 安裝依賴
pip3 install -r requirements.txt

# 建立環境變數檔案
echo "請輸入你的設定："
read -p "Telegram Bot Token: " BOT_TOKEN
read -p "Telegram Chat ID: " CHAT_ID
read -p "PTT 帳號,密碼 (格式: account,password): " PTT_ID_1

cat > /root/PTTAutoSign/.env << EOF
bot_token=$BOT_TOKEN
chat_id=$CHAT_ID
ptt_id_1=$PTT_ID_1
ptt_id_2=none
EOF

# 建立執行腳本
cat > /root/PTTAutoSign/run.sh << 'EOF'
#!/bin/bash
cd /root/PTTAutoSign
export $(cat .env | xargs)
python3 main.py
EOF
chmod +x /root/PTTAutoSign/run.sh

# 設定 cron job (每天早上 10:30 台灣時間 = UTC 02:30)
(crontab -l 2>/dev/null; echo "30 2 * * * /root/PTTAutoSign/run.sh >> /root/PTTAutoSign/log.txt 2>&1") | crontab -

echo ""
echo "=== 安裝完成！ ==="
echo "測試執行: /root/PTTAutoSign/run.sh"
echo "查看排程: crontab -l"
echo "查看日誌: cat /root/PTTAutoSign/log.txt"
