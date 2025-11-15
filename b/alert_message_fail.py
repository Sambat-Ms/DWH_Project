import requests

def send_telegram_alert(bot_token, chat_id, message, proxies=None):
    """
    Send an alert message to a Telegram bot with optional proxy.
    
    :param bot_token: str, your bot token from BotFather
    :param chat_id: str, your chat ID
    :param message: str, message to send
    :param proxies: dict, proxy settings (optional)
    """
    url = f"https://api.telegram.org/bot{bot_token}/sendMessage"
    payload = {
        "chat_id": chat_id,
        "text": message,
        "parse_mode": "HTML"
    }
    
    try:
        response = requests.post(url, data=payload, proxies=proxies)
        response.raise_for_status()
        print("✅ Message sent successfully")
    except requests.exceptions.RequestException as e:
        print(f"❌ Error: {e}")

# Example usage
if __name__ == "__main__":
    BOT_TOKEN = "YourTelegramToken"
    CHAT_ID = "YourChatID"
    ALERT_MESSAGE = "🚨 Alert: ETL Fail ❌"

    # Example proxy settings (HTTP & HTTPS)
    PROXIES = {
        "http": None,
        "https": None
    }

    send_telegram_alert(BOT_TOKEN, CHAT_ID, ALERT_MESSAGE, proxies=PROXIES)
