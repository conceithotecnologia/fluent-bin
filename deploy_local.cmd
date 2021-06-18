@echo off
@echo "Fazendo Deploy Local..."
xcopy /y/q Win32\*.exe D:\Binarios\Fluent\Win32
xcopy /y/q Win32\*.bpl D:\Binarios\Fluent\Win32
@echo "Finalizado!"