# What this bot does?
It sends you a message with each attempt of your chia farm to find a proof.

# Run Chia Telegram Bot
1. Create new telegram bot using https://t.me/botfather
2. Copy the token provided by `@botfather` and paste it into the TOKEN variable of `chiabot.sh`
2. Get your chat id with https://t.me/chatid_echo_bot
4. Copy the chat id provided by `@chatid_echo_bot` and paste it into the CHAT_ID variable of `chiabot.sh`
5. Set your chia `log_level` to `INFO` (change this file - `~/.chia/mainnet/config/config.yaml`)
6. Set `LOG_PATH` to the actual path to your chia log file (`~/.chia/mainnet/log/debug.log` by default)
7. Open terminal in a folder that contains `chiabot.sh`
8. Allow `chiabot.sh` to be executed with `sudo chmod u+x chiabot.sh` command
9. Run bot with `./chiabot.sh` command

# Receive only important messages
You could set this bot to send you messages only in 2 cases:
1. Your farm has found a proof
2. There were no attempts to find a proof in the last 5 minutes
 
To do this set `LOG_LEVEL` of `chiabot.sh` to anything except `INFO`.
You will not receive a warning if your PC isn't connected to the internet.

# Say thanks
XCH: xch1ra8v89cdjafs492gtqxdgh5wlawdhdcyxwc6hta4qy92v03wfcjqtyxnwl
