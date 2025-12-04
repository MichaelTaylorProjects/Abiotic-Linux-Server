## 1. System Requirements
 - Ubuntu / Pop!_OS 22.04+
 - 8GB RAM Minimum
 - SteamCMD
 - Wine (staging)

## 2. Create Dedicated Service User

Do NOT run the server as root.

sudo useradd -m abiotic
sudo usermod -aG sudo abiotic
sudo su - abiotic

## 3. Install Dependencies

Install & Update..
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common lsb-release wget cabextract winbind screen xvfb steamcmd

Install Wine:
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

sudo wget -NP /etc/apt/sources.list.d/ \
https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources

sudo apt update
sudo apt install --install-recommends winehq-staging

## 4. Install Server via SteamCMD

Create the server directory:
mkdir -p /home/abiotic/abioticserver

Download the Windows server build:
/usr/games/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /home/abiotic/abioticserver +login anonymous +app_update 2857200 +quit


## 5. Create runserver.sh

sudo nano /home/abiotic/abioticserver/AbioticFactor/Binaries/Win64/runserver.sh

Paste and edit as needed:
#!/bin/bash
xvfb-run wine64 /home/abiotic/abioticserver/AbioticFactor/Binaries/Win64/AbioticFactorServer-Win64-Shipping.exe \
-log -newconsole -useperfthreads -NoAsyncLoadingThread \
-MaxServerPlayers=3 \
-PORT=7777 \
-QUERYPORT=27015 \
-tcp \
-ServerPassword=yourpassword \
-SteamServerName="YourServerName" \
-WorldSaveName="YourWorldSaveName"

Make it Executable
chmode +x /home/abiotic/abioticserver/AbioticFactor/Binaries/Win64/runserver.sh

## 6. Create systemd service

sudo nano /etc/systemd/abiotic.service


[Unit]
Description=Abiotic Factor Dedicated Server
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=abiotic
Group=abiotic
WorkingDirectory=/home/abiotic/abioticserver/
ExecStart=/home/abiotic/abioticserver/AbioticFactor/Binaries/Win64/runserver.sh
Restart=always

[Install]
WantedBy=multi-user.target


##Enable and start:
sudo systemctl daemon-reload
sudo systemctl enable abiotic
sudo systemctl start abiotic

## 7. Port Forwarding
On your router forward:
- 7777 UDP (For users to connect to the server)
- 27015 UDP (For steam to show the server in the server browser)

You can verify that Steam is listening:
sudo ss -ulnp | grep 27015


## 8. Save Migration (Optional)

Old world path example:
~/.steam/.../AbioticFactor/Saved/SaveGames/Server/Worlds/ExampleWorld

New server save path:
/home/abiotic/abioticserver/AbioticFactor/Saved/SaveGames/Server/Worlds/

Copy:
sudo cp -r /old/path/ExampleWorld \
/home/abiotic/abioticserver/AbioticFactor/Saved/SaveGames/Server/Worlds

Fix ownership:
sudo chown -R abiotic:abiotic \
/home/abiotic/abioticserver/AbioticFactor/Saved/SaveGames/Server/Worlds/ExampleWorld

Ensure runserver.sh uses:
-WorldSaveName="ExampleWorld"

Restart:
sudo systemctl restart abiotic


## 9. Admin Setup

sudo nano /home/abiotic/abioticserver/AbioticFactor/Saved/SaveGames/Server/Admin.ini

[Moderators]
Moderator=YOUR_STEAM_ID_HERE
Moderator=ANY_OTHER_STEAM_ID

[BannedPlayers]
BannedPlayer=ExampleBanID1
BannedPlayer=ExampleBanID2

[Admin]
AdminPassword=YourAdminPassword

## 10. Disable Sleep

sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

Verify:
systemctl status sleep.target

Should show:
Loaded: masked


## Useful Commands
sudo systemctl start abiotic
sudo systemctl stop abiotic
sudo system restart abiotic
journalctl -u abiotic -f 
