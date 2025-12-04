# Abiotic-Linux-Server
This project demonstrates:
1. Headless Linux service deployment
2. SteamCMD Automation
3. Wine-based server hosting
4. Persistent save migration
5. systemd service management
6. Real-world uptime hardening

This was built and is currently running on my own hardware.

##Running Abiotic Factor Dedicated Server on Pop_OS Using Wine + systemd

This project documents the deployment of a persistent, auto-starting dedicated game server for Abiotic Factor on Linux using:
Pop!_OS (Ubuntu-Based)
StamCMD
Wine
systemd

The goal was to move from a fragile, manually launched server from Steam to a fully automated, headless, and persistent hosting environment suitable for long-term private gaming.

Final Capabilities
By the end of this project, the server achieved:
Dedicated Linux User Isolation (abiotic user for security)
Automatic startup at boot via systemd
No terminal dependency (true headless service)
Persistent world data
Successful save-game migration from a previous Steam install
Steam query + direct connect networking
Admin authentication via config
System sleep completely disabled to ensure 24/7 uptime
Live monitoring via journalctl
Resource usage tracking via systemd control groups

The system now behaves like a true always-on production service.


Architecture Summary
Core Stack:
OS: Pop!OS
Runtime: Wine
Distribution: SteamCMD
Service Management: systemd

Server Lifecycle:
1. Boot -> systemd automatically launches the server
2. SteamCMD ensures latest server build at startup
3. The server runs independently of any logged-in user
4. Screen locking and user logout do not affect uptime
5. If the process crashes, systemd automatically restarts it


Save Migation Accomplished
A full world migration was completed from:
Steam Dedicated Server (Steam) -> systemd-managed Win server (Linux)


this required:
1. Locating the original save under Steam's server directory
2. Identifying the active Wine-based save path
3. Copying full world + metadata + player state
4. Fixing file ownership for the service user
5. Updating the server's -WorldSaveName flag
6. Verifying successful load through live logs

The migrated world now runs permanently under the new service architecture.


Security & Stability Measures
1. Dedicated non-root service user
2. Explicit ownership enforcement for all world data
3. Locked-down admin authentication
4. System sleep, suspend, and hibernation fully disabled at the OS level
5. Controlled player limits for private lab usage


Skills Demonstrated
This project demonstrates hands-on competency with:
1. Linux user & permission management
2. Headless service deployment
3. systemd unit creation & debugging
4. Network port binding and UDP query diagnostics
5. SteamCMD automation
6. Wine production usage
7. Save-state data migration
8. Log-based live troubleshooting
9. Persistent uptime configuration
10. Resource monitoring under production load


Current Status
1. Server is live
2. World is persistent
3. Auto-start verified across reboots
4. Locked into a private lab/test configuration
5. Ready for gameplay and reproduction.
