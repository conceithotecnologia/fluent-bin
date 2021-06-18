@echo off
@echo "Publicando versao..."
ftp -niv -s:release_ftp.cfg
del "*.7z"
