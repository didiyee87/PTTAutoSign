# PTTAutoSign

![PTT](https://user-images.githubusercontent.com/11913223/130311745-97ccf57e-6c67-423e-b4a6-d74908dd9df9.png)

PTT 自動簽到，使用 GitHub Actions 每天自動登入 PTT 並發送 Telegram 通知。

## ✨ 特色

- ✅ 不需要額外伺服器
- 🚀 即時發送通知到 Telegram
- 👷‍♂️ 不需額外維護
- 🆓 完全免費（使用 GitHub Actions）

## 📋 部署步驟

### 1. Fork 此專案

點擊右上角的 **Fork** 按鈕，將此專案複製到你的 GitHub 帳號。

### 2. 設定 GitHub Secrets

前往你的 repo → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**

新增以下 Secrets：

| Secret 名稱 | 說明 | 範例 |
|------------|------|------|
| `BOT_TOKEN` | Telegram Bot Token | `1234567890:ABCdefGHIjklMNOpqrsTUVwxyz` |
| `CHAT_ID` | Telegram Chat ID | `123456789` |
| `PTT_ID_1` | PTT 帳號（格式：帳號,密碼） | `myaccount,mypassword` |
| `PTT_ID_2` | 第二個 PTT 帳號（若無則填 `none`） | `none` |

### 3. 啟用 GitHub Actions

1. 前往你的 repo → **Actions**
2. 點擊 **I understand my workflows, go ahead and enable them**
3. 找到 **PTT 自動簽到** workflow
4. 點擊 **Enable workflow**

### 4. 手動測試

在 Actions 頁面，點擊 **PTT 自動簽到** → **Run workflow** → **Run workflow** 進行測試。

## ⏰ 排程時間

預設每天 **台灣時間 10:30** 自動執行。

如需更改時間，編輯 `.github/workflows/ptt_auto_sign.yml` 中的 cron 設定：

```yaml
schedule:
  - cron: "30 2 * * *"  # UTC 時間，+8 = 台灣時間
```

## ❓ FAQ

### Q: 如何取得 Telegram Bot Token？

1. 在 Telegram 搜尋 [@BotFather](https://t.me/BotFather)
2. 發送 `/newbot` 建立新機器人
3. 依照指示設定機器人名稱
4. 取得 Token，格式如：`1234567890:ABCdefGHIjklMNOpqrsTUVwxyz`

### Q: 如何取得 Chat ID？

- **個人 Chat ID**：私訊 [@my_id_bot](https://t.me/my_id_bot)
- **頻道 Chat ID**：在頻道發送訊息，轉發給 @my_id_bot
- **群組 Chat ID**：將 @my_id_bot 加入群組

### Q: 支援多個 PTT 帳號嗎？

支援！在 `main.py` 中可以新增更多帳號：

```python
ptt_id_3 = os.getenv("ptt_id_3")
ptt_id_4 = os.getenv("ptt_id_4")
# ... 以此類推
```

並在 GitHub Secrets 中新增對應的 `PTT_ID_3`、`PTT_ID_4` 等。

## 📝 License

MIT License
