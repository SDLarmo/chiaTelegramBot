# What this bot does?
It sends you a telegram message containing: 
1) Your chia farm summary;
2) Proofs found;
3) Attempts of your chia farm to find a proof.

# Run Chia Telegram Bot
1. Create new telegram bot using https://t.me/botfather
2. Copy the token provided by `@botfather` and paste it into the TOKEN variable of `chiabot.sh`
2. Get your chat id with https://t.me/chatid_echo_bot
4. Copy the chat id provided by `@chatid_echo_bot` and paste it into the CHAT_ID variable of `chiabot.sh`
5. Set your chia `log_level` to `INFO` (change this file - `~/.chia/mainnet/config/config.yaml`)
6. Set `LOG_PATH` to the actual path to your chia log file (`~/.chia/mainnet/log/debug.log` by default)
7. Open terminal in a folder that contains `chiabot.sh`
8. Install cURL (with `sudo apt install curl` on Linux) if you haven't installed it previously 
9. Allow `chiabot.sh` to be executed with `sudo chmod u+x chiabot.sh` command
10. Run bot with `./chiabot.sh` command

# Receive farm summary
You could set this bot to send you a summary message every X seconds:
1. Set `MODE` of `chiabot.sh` to `SUMMARY`.
2. Set `MSG_INTERVAL` of `chiabot.sh` to needed time in seconds ("300" for 5 minutes, "3600" for one hour, etc).
3. Run the bot.

# Receive only important messages
You could set this bot to send you messages only in 2 cases:
1. Your farm has found a proof
2. There were no attempts to find a proof in the last 5 minutes
 
To do this set `MODE` of `chiabot.sh` to anything except `IMPORTANT`.
You will not receive a warning if your PC isn't connected to the internet.

# Receive messages for every attempt 
You could set this bot to send you a summary message every X seconds:
1. Set `MODE` of `chiabot.sh` to `INFO`.
2. Run the bot.

# Say thanks
XCH: xch1xnhut6qlg38a94axmckuvt29qw65t6zrk2xwxtq8era93p6ahqqqfmkfum
