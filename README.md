# What this bot does?
It sends you a telegram message containing: 
1) Your chia farm summary;
2) Proofs found;
3) Attempts of your chia farm to find a proof.

# Run Chia Telegram Bot
1. Create new telegram bot using https://t.me/botfather
2. Copy the `TOKEN` provided by `@botfather` and save it somewhere
2. Get your `CHAT_ID` with https://t.me/chatid_echo_bot
4. Copy the `CHAT_ID` provided by `@chatid_echo_bot` and save it somewhere
5. Set `LOG_PATH` to the actual path to your chia log file (`~/.chia/mainnet/log/debug.log` by default)
6. Open terminal in a folder that contains `chiabot.sh`
7. Install cURL (with `sudo apt install curl` on Linux) if you haven't installed it previously 
8. Allow `chiabot.sh` to be executed with `sudo chmod u+x chiabot.sh` command
9. Run bot with `./chiabot.sh -m MODE -c CHAT_ID - t TOKEN` command

# Receive farm summary
You could set this bot to send you a summary message every X seconds:
1. Set `MSG_INTERVAL` of `chiabot.sh` to needed time in seconds ("300" for 5 minutes, "3600" for one hour, etc).
2. Run the bot using `./chiabot.sh -m summary -c CHAT_ID - t TOKEN` command.

# Receive only important messages
You could set this bot to send you messages only in 2 cases:
1. Your farm has found a proof
2. There were no attempts to find a proof in the last 5 minutes
 
To do this run the bot using `./chiabot.sh -m important -c CHAT_ID - t TOKEN` command.
You will not receive a warning if your PC isn't connected to the internet.

# Receive messages for every attempt 
You could set this bot to send you a summary message every X seconds:
1. Run the bot using `./chiabot.sh -m info -c CHAT_ID - t TOKEN` command.

# Say thanks
XCH: xch1xnhut6qlg38a94axmckuvt29qw65t6zrk2xwxtq8era93p6ahqqqfmkfum
