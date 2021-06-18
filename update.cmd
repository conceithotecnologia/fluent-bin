@echo off
@echo "Gerando update"

Win32\Fluent.exe -version
set /p ver=<ver.txt

7z a -mmt=8 -xr@update_ignore.cfg "Fluent %ver%_upd.7z" @update_lst.cfg