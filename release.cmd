@echo off
@echo "Gerando release"
Win32\Fluent.exe -version
set /p ver=<ver.txt
7z a -mmt=8 -xr@release_ignore.cfg "Fluent %ver%.7z" @release_lst.cfg