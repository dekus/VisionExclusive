@echo off
start .\files\FXServer.exe +set onesync_enableInfinity 1 +set onesync_enableBeyond 1 +set onesync_forceMigration 1 +set onesync_population false +set onesync_distanceCullVehicles 1 +set onesync_radiusFrequency 1 +set sv_enforceGameBuild 2372 +set sv_shutdown_cancel 1 +exec server.cfg
exit