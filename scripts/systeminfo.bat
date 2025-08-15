
@echo off
cls
color 4
@echo.
@echo.
@echo ============================================================
@echo =                  INFORMACOES DO SISTEMA                  =
@echo ============================================================
@echo.
@echo [*] Github: https://github.com/suchsoak
@echo ============================================================
timeout /t 2 >nul
@echo [*] Sistema Operacional:
systeminfo | findstr /I "OS"
ver
@echo ============================================================
@echo [*] Data: 
date /t
@echo [*] Hora: %time%
@echo ============================================================
@echo.
@echo [!] Local:
timeout /t 2 > null
@echo.
@echo IP:
@echo.
curl -s ipinfo.io | findstr "ip"
curl -s ipinfo.io | findstr "country"
curl -s ipinfo.io | findstr "region"
curl -s ipinfo.io | findstr "postal"
curl -s ipinfo.io | findstr "city"
curl -s ipinfo.io | findstr "hostname"
curl -s ipinfo.io | findstr "loc"
curl -s ipinfo.io | findstr "org"
curl -s ipinfo.io | findstr "timezone"
curl -s ipinfo.io | findstr "readme"
curl -s ipinfo.io | findstr "anycast"
curl -s ipinfo.io | findstr "asn"
curl -s ipinfo.io | findstr "abuse"
curl -s ipinfo.io | findstr "privacy"
@echo.
@echo [!] Informacoes Adicionais:
@echo.
color 1
systeminfo| findstr "Proprietário registrado"
@echo.
@echo [*] Serial: %PROGRAMFILES(x86)% 
@echo [*] Maquina: %computername%  
@echo [*] Usuario: %username% 
@echo [*] Operacional: %OS% 
@echo [*] Pasta: %SYSTEMROOT% 
timeout /t 3 > null
@echo.
@echo --------------------
@echo.
@echo [!] Informacoes Do Processador:
color 5
timeout /t 2 > null
@echo.
@echo [*] Arquitetura: %PROCESSOR_ARCHITECTURE%
@echo [*] Processador: %PROCESSOR_IDENTIFIER% 
@echo [*] Versao: %PROCESSOR_REVISION% 
@echo [*] Nucleos: %NUMBER_OF_PROCESSORS%
@echo.
@echo --------------------
@echo.
@echo [!] Informacoes do disco:
color 6
timeout /t 2 > null
@echo.
powershell -command "Get-CimInstance Win32_DiskDrive | Select-Object DeviceID, Model, Size"
@echo.
powershell -command "Get-CimInstance Win32_LogicalDisk | Select-Object DeviceID, Size, FreeSpace"
@echo --------------------
@echo.
@echo [!] Informacoes da Placa De Video:
color 7
timeout /t 5 > null
@echo.
powershell -command "Get-CimInstance Win32_VideoController | Select-Object Name"
powershell -command "Get-CimInstance Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion"
@echo.
@echo --------------------
@echo.
color 9
timeout /t 5 > null
@echo [!] Informacoes da Placa Mae:
@echo.
color 2
timeout /t 2 > null
powershell -command "Get-CimInstance Win32_BIOS | Select-Object Name"
powershell -command "Get-CimInstance Win32_BIOS | Select-Object ReleaseDate"
powershell -command "Get-CimInstance Win32_BaseBoard | Select-Object Product"
@echo.
@echo --------------------
@echo.
@echo [!] Informacoes da Memoria Ram:
@echo.
powershell -command "Get-CimInstance Win32_PhysicalMemory | Select-Object Manufacturer, Capacity, PartNumber, Speed, DeviceLocator"
echo.
@echo --------------------
@echo.
@echo [!] Informacoes De Rede:
@echo.
timeout /t 6 > null
color 8
netsh interface ipv4 show addresses "Wi-Fi" | findstr "Endereço IP"
netsh wlan show profiles name="Interface" key=clear | findstr "Nome SSID"
netsh wlan show profiles name="Interface" key=clear | findstr "Chave"
netsh wlan show interfaces | findstr "Perfil"
netsh wlan show interfaces | findstr "Estado"
netsh wlan show interfaces | findstr "Sinal"
netsh wlan show interfaces | findstr "Canal"
netsh wlan show interfaces | findstr "Descrição"
netsh wlan show interfaces | findstr "BSSID"
netsh wlan show interfaces | findstr "Criptografia"
netsh wlan show interfaces | findstr "Faixa"
color 7
@echo.
:: Tenta criar o arquivo informacoes.txt na pasta atual
set "INFOFILE=%CD%\informacoes.txt"
:: Se não conseguir, tenta criar na pasta TEMP do usuário
type nul > "%INFOFILE%" 2>nul
if not exist "%INFOFILE%" (
  set "INFOFILE=%TEMP%\informacoes.txt"
  type nul > "%INFOFILE%" 2>nul
)
:: Se ainda não conseguir, mostra erro e sai
if not exist "%INFOFILE%" (
  color 4
  @echo [!] ERRO: Não foi possível criar o arquivo informacoes.txt.
  @echo [!] Verifique permissões de escrita na pasta atual ou no TEMP.
  @pause
  goto :eof
)

attrib -R "%INFOFILE%"
type nul > "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
timeout /t 3 >nul
@echo [!] Salvando as informacoes em um arquivo txt (informacoes.txt)... >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo off >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [*] github: https://github.com/suchsoak >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
powershell -Command "Get-CimInstance Win32_OperatingSystem | Select-Object Name" >> "%INFOFILE%"
ver >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
date /t >> "%INFOFILE%"
@echo.  >> "%INFOFILE%"
@echo Horas: %time% >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [!] Local: >> "%INFOFILE%"
timeout /t 2 > nul
@echo. >> "%INFOFILE%"
@echo IP: >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
curl -s ipinfo.io | findstr "ip" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "country" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "region" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "postal" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "city" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "hostname" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "loc" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "org" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "timezone" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "readme" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "anycast" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "asn" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "abuse" >> "%INFOFILE%"
curl -s ipinfo.io | findstr "privacy" >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [!] Informacoes Adicionais: >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
color 1
systeminfo| findstr "Proprietário registrado" >> "%INFOFILE%"
@echo.>> "%INFOFILE%"
@echo [*] Serial: %PROGRAMFILES(x86)% >> "%INFOFILE%"
@echo [*] Maquina: %computername% >> "%INFOFILE%"
@echo [*] Usuario: %username% >> "%INFOFILE%"
@echo [*] Operacional: %OS% >> "%INFOFILE%"
@echo [*] Pasta: %SYSTEMROOT% >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [!] Informacoes Do Processador: >> "%INFOFILE%"
color 5
@echo. >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_Processor | Select-Object Name" >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [*] Arquitetura: %PROCESSOR_ARCHITECTURE% >> "%INFOFILE%"
@echo [*] Processador: %PROCESSOR_IDENTIFIER% >> "%INFOFILE%"
@echo [*] Versao: %PROCESSOR_REVISION% >> "%INFOFILE%"
@echo [*] Nucleos: %NUMBER_OF_PROCESSORS% >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [!] Informacoes do disco: >> "%INFOFILE%"
color 6
@echo. >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_DiskDrive | Select-Object DeviceID, Model, Size" >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [!] Informacoes da Placa De Video: >> "%INFOFILE%"
color 7
@echo. >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_VideoController | Select-Object Name" >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion" >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
color 9
@echo [!] Informacoes da Placa Mae: >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
color 2
powershell -command "Get-CimInstance Win32_BaseBoard | Select-Object Manufacturer" >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_BIOS | Select-Object Name" >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_BIOS | Select-Object ReleaseDate" >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_BaseBoard | Select-Object Product" >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [!] Informacoes da Memoria Ram: >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_PhysicalMemory | Select-Object Manufacturer, Capacity, PartNumber, Speed, DeviceLocator" >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [!] Informacoes De Rede: >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
color 8
netsh interface ipv4 show addresses "Wi-Fi" | findstr "Endereço IP" >> "%INFOFILE%"
netsh wlan show profiles name="Interface" key=clear | findstr "Nome SSID" >> "%INFOFILE%"
netsh wlan show profiles name="Interface" key=clear | findstr "Chave" >> "%INFOFILE%"
netsh wlan show interfaces | findstr "Perfil" >> "%INFOFILE%"
netsh wlan show interfaces | findstr "Estado" >> "%INFOFILE%"
netsh wlan show interfaces | findstr "Sinal" >> "%INFOFILE%"
netsh wlan show interfaces | findstr "Canal" >> "%INFOFILE%"
netsh wlan show interfaces | findstr "Descrição" >> "%INFOFILE%"
netsh wlan show interfaces | findstr "BSSID" >> "%INFOFILE%"
netsh wlan show interfaces | findstr "Criptografia" >> "%INFOFILE%"
netsh wlan show interfaces | findstr "Faixa" >> "%INFOFILE%"
color 7
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
timeout 5 >nul
@echo -------------------- 
@echo [*] Todas as informacoes foram salvas em: %INFOFILE%
@echo -------------------- 
timeout 3 >nul
start C:\Windows\System32\informacoes.txt
@echo -------------------- 
@echo [!] Precione Enter para sair do terminal.
@echo -------------------- 

set /p sair=
if "%sair%" == "" (
  exit
)
