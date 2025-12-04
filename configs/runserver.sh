#!/bin/bash
xvfb-run /usr/bin/wine64-stable /home/abiotic/abioticserver/AbioticFactor/Binaries/Win64/AbioticFactorServer-Win64-Shipping.exe \
-log -newconsole -useperfthreads -NoAsyncLoadingThread \
-MaxServerPlayers=6 \
-PORT=7777 \
-QUERYPORT=27015 \
-tcp \
-ServerPassword=Your Server Password Here \
-SteamServerName="Your Server Name Here" \
-WorldSaveName="Your World Name Here"
