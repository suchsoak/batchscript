@echo off
chcp 65001 >nul
title Suchsoak - Ferramentas de Manutencao v1.0.8
mode con: cols=72 lines=40

:: ============================================================
::  CORES (ANSI) E ELEMENTOS VISUAIS
::  Requer Windows 10 ou superior. Salve este arquivo em UTF-8.
:: ============================================================
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "R=%ESC%[0m"
set "BLD=%ESC%[1m"
set "DIM=%ESC%[90m"
set "RED=%ESC%[91m"
set "GRN=%ESC%[92m"
set "YEL=%ESC%[93m"
set "BLU=%ESC%[94m"
set "MAG=%ESC%[95m"
set "CYN=%ESC%[96m"
set "WHT=%ESC%[97m"
set "LN=──────────────────────────────────────────────────────"
set "LN2=══════════════════════════════════════════════════════"
set "BX=════════════════════════════════════════════════════"

:: Verifique se o script esta sendo executado como administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    cls
    call :banner
    echo.
    echo %RED%  [!] Este script precisa ser executado como administrador.%R%
    echo.
    pause
    exit
)

cls
call :banner
echo.
echo %WHT%%BLD%   MENU PRINCIPAL%R%
echo %DIM%  %LN%%R%
echo.
echo   %GRN%[ 1]%R%  Verificar discos         %DIM%SFC, DISM, CHKDSK%R%
echo   %GRN%[ 2]%R%  Resetadores Netsh        %DIM%rede e firewall%R%
echo   %BLU%[ 3]%R%  Systeminfo               %DIM%informacoes do sistema%R%
echo   %CYN%[ 4]%R%  Windows Update           %DIM%resetar servicos%R%
echo   %CYN%[ 5]%R%  Remover marca Windows
echo   %CYN%[ 6]%R%  Resetar Drive Video
echo   %CYN%[ 7]%R%  HQ CODE                  %DIM%gerador de QR Code%R%
echo   %YEL%[ 8]%R%  Ativar Windows (KMS)
echo   %YEL%[ 9]%R%  Ativar Windows (MAS)
echo   %MAG%[10]%R%  Baixar WSL               %DIM%Windows Subsystem for Linux%R%
echo   %RED%[11]%R%  Sair do terminal
echo.
echo %DIM%  %LN%%R%
timeout 2 >nul
echo %DIM%  Escolha um numero de 1 a 11 para iniciar o processo.%R%

:: Escolha de opcoes
echo.
set /p "escolha=%GRN%  >> Escolha uma opção [1-11]: %R%"

REM Validação visual e navegação
if "%escolha%"=="1"  goto escolha1
if "%escolha%"=="2"  goto escolha2
if "%escolha%"=="3"  goto escolha3
if "%escolha%"=="4"  goto escolha4
if "%escolha%"=="5"  goto escolha5
if "%escolha%"=="6"  goto escolha6
if "%escolha%"=="7"  goto escolha7
if "%escolha%"=="8"  goto escolha8
if "%escolha%"=="9"  goto escolha9
if "%escolha%"=="10" goto escolha10
if "%escolha%"=="11" goto escolha11

cls
echo.
echo %RED%  ╔%BX%╗%R%
echo %RED%  ║                                                    ║%R%
echo %RED%  ║   [!] OPÇÃO INVÁLIDA!                              ║%R%
echo %RED%  ║   Escolha um número de 1 a 11.                     ║%R%
echo %RED%  ║                                                    ║%R%
echo %RED%  ╚%BX%╝%R%
echo.
pause
cls
goto :eof

:escolha1

cls
call :titulo "VERIFICADORES DE DISCO"
echo %DIM%  Github: https://github.com/suchsoak%R%
timeout 2 >nul
echo.
:: Informacoes de disco
call :aviso "Informacoes de disco:"
echo.
powershell -Command "Get-PhysicalDisk | Format-Table FriendlyName, MediaType, Size, SerialNumber, OperationalStatus"
if not errorlevel 1 (
    echo.
    call :ok "Informacoes de disco obtidas com sucesso."
) else (
    echo.
    call :erro "Erro ao obter informacoes de disco."
)
timeout 6 >nul
cls
call :titulo "VERIFICADORES DE DISCO"

:: SFC ScanNow
call :passo "[1/6] Verificando integridade dos arquivos do sistema" "Sfc /ScanNow"
timeout 2 >nul
Sfc /ScanNow
cls

:: DISM ScanHealth
call :passo "[2/6] Verificando imagem do Windows (ScanHealth)" "dism /online /cleanup-image /scanhealth"
dism /online /cleanup-image /scanhealth
timeout 2 >nul
cls

:: DISM RestoreHealth
call :passo "[3/6] Restaurando imagem do Windows (RestoreHealth)" "dism /online /cleanup-image /restorehealth"
dism /online /cleanup-image /restorehealth
timeout 5 >nul
cls

:: DISM CheckHealth
call :passo "[4/6] Checando saude da imagem do Windows (CheckHealth)" "dism /Online /Cleanup-Image /CheckHealth"
dism /Online /Cleanup-Image /CheckHealth
timeout 2 >nul
cls

:: CHKDSK
call :passo "[5/6] Verificando disco rigido (chkdsk)" "chkdsk"
timeout 3 >nul
chkdsk
cls

:: Apagando arquivos temporários
call :passo "[6/6] Apagando arquivos temporarios (%temp%)" "del /F /Q %temp%\*"
cd %temp%
del /F /Q *
timeout 3 >nul
cls

:: Identificando Disco
call :passo "Identificando Disco" "wmic diskdrive get mediatype"
echo.

wmic diskdrive get mediatype | findstr /c:"Fix hard disk media" > nul
if %errorlevel% == 0 (
  call :passo "Desfragmentando Disco Rigido (HDD)" "defrag C: /U /V"
  defrag C: /U /V
  timeout 3 >nul
  echo.
  call :ok "Desfragmentacao concluida."
) else (
  echo.
  call :aviso "SSD detectado: NAO e recomendado desfragmentar."
  timeout 3 >nul
)

timeout 3 >nul
call :info "Processo Finalizado..."
timeout 3 >nul
echo.
cls
echo.
echo %YEL%  ╔%BX%╗%R%
echo %YEL%  ║   [!] AVISO: o processo levará um tempo,           ║%R%
echo %YEL%  ║       dependendo da máquina.                       ║%R%
echo %YEL%  ╚%BX%╝%R%
echo.
echo   %GRN%[1]%R%  Executar o comando chkdsk /r
echo   %RED%[2]%R%  Nao executar o comando
echo.

set /p "op=%GRN%  >> Escolha uma opcao: %R%"

if %op% equ 1 goto op1
if %op% equ 2 goto op2

:op1

echo.
call :passo "Executando chkdsk /r" "chkdsk /r"
timeout 3 >nul
chkdsk /r
echo.
echo %GRN%  ╔%BX%╗%R%
echo %GRN%  ║   [!] Agora reinicie o computador.                 ║%R%
echo %GRN%  ╚%BX%╝%R%
:op2
cls
echo.
call :info "Saindo Do Terminal..."
timeout 3 >nul
cls
exit

:escolha2

cls
call :titulo "RESETADORES NETSH"
echo %DIM%  Github: https://github.com/suchsoak%R%
echo.
echo %CYN%  ╔%BX%╗%R%
echo %CYN%  ║%R%%WHT%%BLD%   ESCOLHA UMA OPÇÃO                                %R%%CYN%║%R%
echo %CYN%  ╠%BX%╣%R%
echo %CYN%  ║%R%   %GRN%[1]%R%  Colocar Regras De Firewall                  %CYN%║%R%
echo %CYN%  ║%R%   %RED%[2]%R%  Nao Colocar Regras De Firewall              %CYN%║%R%
echo %CYN%  ╚%BX%╝%R%
echo.

set /p "firewall=%GRN%  >> Escolha uma opcao: %R%"

if %firewall% == 1 goto firewall1
if %firewall% == 2 goto firewall2

:firewall1

cls
call :titulo "REGRAS DE FIREWALL"

set /p "porta=%YEL%  Coloque a porta: %R%"
echo.
call :info "Porta escolhida: %porta%"

timeout 1 > nul
netsh advfirewall firewall add rule name="Block %porta%" dir=in action=block protocol=TCP localport=%porta% 
echo.
timeout 3 >nul
call :secao "Informacoes De Rede"
echo.
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
netsh interface ipv4 show addresses "Wi-Fi" | findstr "Endereço IP"
timeout 3 >nul
echo.
call :secao "Resetadores de rede"
echo.
call :info "Configurando ipconfig..."
timeout /t 2 >nul
ipconfig /renew
ipconfig /flushdns
timeout /t 2 >nul
cls
call :ok "Configuracao de ip concluida."
timeout /t 2 > nul
echo.
call :aviso "Configurando Netsh..."
timeout /t 1 >nul
echo.

netsh winsock reset all
netsh int 6to4 reset all
netsh int ipv4 reset all
netsh int ipv6 reset all
netsh int httpstunnel reset all
netsh int isatap reset all
netsh int portproxy reset all
netsh int tcp reset all
netsh int teredo reset all
netsh int ip reset
netsh interface reset all
timeout /t 3 >nul
cls

echo.
echo %GRN%  ╔%BX%╗%R%
echo %GRN%  ║   Netsh configurado, agora reinicie o computador.  ║%R%
echo %GRN%  ╚%BX%╝%R%
echo.
pause
exit

:firewall2
cls
timeout 2 >nul
call :secao "Informacoes De Rede"
echo.
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
netsh interface ipv4 show addresses "Wi-Fi" | findstr "Endereço IP"
timeout 3 >nul
echo.
call :secao "Resetadores de rede"
echo.
call :info "Configurando ipconfig..."
timeout /t 2 >nul
ipconfig /renew
cls
call :ok "Configuracao de ip concluida."
timeout /t 3 > nul
echo.
call :aviso "Configurando Netsh..."
timeout /t 2 >nul
echo.

netsh winsock reset all
netsh int 6to4 reset all
netsh int ipv4 reset all
netsh int ipv6 reset all
netsh int httpstunnel reset all
netsh int isatap reset all
netsh int portproxy reset all
netsh int tcp reset all
netsh int teredo reset all
netsh int ip reset
netsh interface reset all
timeout /t 3 >nul
cls

echo.
echo %GRN%  ╔%BX%╗%R%
echo %GRN%  ║   Netsh configurado, agora reinicie o computador.  ║%R%
echo %GRN%  ╚%BX%╝%R%

echo.
pause
exit

:escolha3

cls
call :titulo "INFORMACOES DO SISTEMA"
call :info "Github: https://github.com/suchsoak"
timeout /t 2 >nul
echo.
call :secao "Sistema Operacional"
systeminfo | findstr /I "OS"
ver
echo.
call :secao "Data e Hora"
echo %WHT%  Data:%R%
date /t
echo %WHT%  Hora:%R% %time%
echo.
call :secao "Local"
timeout /t 2 > nul
echo.
echo %WHT%  IP:%R%
echo.
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
echo.
call :secao "Informacoes Adicionais"
echo.
systeminfo| findstr "Proprietário registrado"
echo.
echo %CYN%  [*]%R% Serial: %PROGRAMFILES(x86)% 
echo %CYN%  [*]%R% Maquina: %computername%  
echo %CYN%  [*]%R% Usuario: %username% 
echo %CYN%  [*]%R% Operacional: %OS% 
echo %CYN%  [*]%R% Pasta: %SYSTEMROOT% 
timeout /t 3 > nul
echo.
call :secao "Informacoes Do Processador"
timeout /t 2 > nul
echo.
echo %CYN%  [*]%R% Arquitetura: %PROCESSOR_ARCHITECTURE%
echo %CYN%  [*]%R% Processador: %PROCESSOR_IDENTIFIER% 
echo %CYN%  [*]%R% Versao: %PROCESSOR_REVISION% 
echo %CYN%  [*]%R% Nucleos: %NUMBER_OF_PROCESSORS%
echo.
call :secao "Informacoes do disco"
timeout /t 2 > nul
echo.
powershell -command "Get-CimInstance Win32_DiskDrive | Select-Object DeviceID, Model, Size"
echo.
powershell -command "Get-CimInstance Win32_LogicalDisk | Select-Object DeviceID, Size, FreeSpace"
echo.
call :secao "Informacoes da Placa De Video"
timeout /t 5 > nul
echo.
powershell -command "Get-CimInstance Win32_VideoController | Select-Object Name"
powershell -command "Get-CimInstance Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion"
echo.
timeout /t 5 > nul
call :secao "Informacoes da Placa Mae"
echo.
timeout /t 2 > nul
powershell -command "Get-CimInstance Win32_BIOS | Select-Object Name"
powershell -command "Get-CimInstance Win32_BIOS | Select-Object ReleaseDate"
powershell -command "Get-CimInstance Win32_BaseBoard | Select-Object Product"
echo.
call :secao "Informacoes da Memoria Ram"
echo.
powershell -command "Get-CimInstance Win32_PhysicalMemory | Select-Object Manufacturer, Capacity, PartNumber, Speed, DeviceLocator"
echo.
call :secao "Informacoes De Rede"
echo.
timeout /t 6 > nul
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
echo.
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
  call :erro "Nao foi possivel criar o arquivo informacoes.txt."
  call :erro "Verifique permissoes de escrita na pasta atual ou no TEMP."
  pause
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
@echo. >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_DiskDrive | Select-Object DeviceID, Model, Size" >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [!] Informacoes da Placa De Video: >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_VideoController | Select-Object Name" >> "%INFOFILE%"
powershell -command "Get-CimInstance Win32_VideoController | Select-Object Name, AdapterRAM, DriverVersion" >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
@echo [!] Informacoes da Placa Mae: >> "%INFOFILE%"
@echo. >> "%INFOFILE%"
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
@echo. >> "%INFOFILE%"
@echo -------------------- >> "%INFOFILE%"
timeout 5 >nul
echo.
echo %GRN%  ╔%BX%╗%R%
echo %GRN%  ║   [✓] Todas as informacoes foram salvas.           ║%R%
echo %GRN%  ╚%BX%╝%R%
call :info "Arquivo: %INFOFILE%"
timeout 3 >nul
start C:\Windows\System32\informacoes.txt
echo.
echo %YEL%  [!] Pressione Enter para sair do terminal.%R%
echo.

set /p sair=
if "%sair%" == "" (
  exit
)

:escolha4

cls
call :titulo "RESETAR WINDOWS UPDATE"
call :info "Github: https://github.com/suchsoak"
echo %DIM%  %LN%%R%
call :aviso "Este processo ira resetar o Windows Update."
echo %DIM%  %LN%%R%
timeout /t 2 >nul
echo.
call :passo "[1/5] Parando servicos relacionados ao Windows Update" "net stop wuauserv, bits, cryptsvc, appidsvc, trustedinstaller"
net stop wuauserv >nul
net stop bits >nul
net stop cryptsvc >nul
net stop appidsvc >nul
net stop trustedinstaller >nul
timeout /t 1 >nul

call :passo "[2/5] Renomeando pastas de atualizacao" "SoftwareDistribution e catroot2"
ren %systemroot%\SoftwareDistribution SoftwareDistribution.bak >nul 2>&1
ren %systemroot%\System32\catroot2 catroot2.bak >nul 2>&1
timeout /t 1 >nul

call :passo "[3/5] Reiniciando servicos" "net start ..."
net start wuauserv >nul
net start bits >nul
net start cryptsvc >nul
net start appidsvc >nul
net start trustedinstaller >nul
timeout /t 1 >nul

call :passo "[4/5] Configurando inicializacao automatica dos servicos" "sc config ... start= auto"
sc config wuauserv start= auto >nul
sc config bits start= auto >nul
sc config cryptsvc start= auto >nul
sc config appidsvc start= auto >nul
sc config trustedinstaller start= auto >nul
timeout /t 1 >nul

call :passo "[5/5] Forcando busca de atualizacoes" "wuauclt /detectnow /reportnow"
wuauclt /detectnow
wuauclt /reportnow
timeout /t 1 >nul

echo.
echo %GRN%  ╔%BX%╗%R%
echo %GRN%  ║   Verifique nas configurações se o Windows está    ║%R%
echo %GRN%  ║   atualizando. Se não, reinicie a máquina.         ║%R%
echo %GRN%  ╚%BX%╝%R%
echo.
pause
exit

:escolha5

cls
call :titulo "REMOVER MARCA D'AGUA DO WINDOWS"
call :info "Github: https://github.com/suchsoak"
echo %DIM%  %LN%%R%
call :aviso "Este processo ira remover a marca d'agua do Windows."
echo %DIM%  %LN%%R%
timeout /t 3 >nul
echo.
call :info "Limpando chaves de produto..."
SLMGR.VBS /CPKY 
SLMGR.VBS /CKMS 
call :info "Parando servico de protecao de software..."
Net stop Sppsvc 
call :info "Renomeando arquivo de tokens..."
CD C:\Windows\System32\SPP\Store\2.0 
Ren Tokens.dat Tokens.old 
call :info "Reinstalando licencas..."
SLMGR.VBS /RILC 
call :info "Restaurando integridade do sistema..."
Bcdedit.exe -set loadoptions ENABLE_INTEGRITY_CHECKS
Bcdedit.exe -set TESTSIGNING OFF
echo.
echo %GRN%  ╔%BX%╗%R%
echo %GRN%  ║   [✓] Concluído! Reinicie a máquina agora.         ║%R%
echo %GRN%  ╚%BX%╝%R%
pause
exit

:escolha6

cls
call :titulo "RESETAR DRIVER DE VIDEO"
call :info "Github: https://github.com/suchsoak"
echo %DIM%  %LN%%R%
call :aviso "Listando dispositivos de video..."
echo %DIM%  %LN%%R%
pnputil /enum-devices /class Display | findstr "ID da Instância"
echo.
set /p "ID=%YEL%  Digite a ID da Instância do driver de vídeo: %R%"
echo.
call :info "Reiniciando dispositivo de video..."
pnputil /restart-device "%ID%"
echo.
echo %DIM%  %LN%%R%
echo %WHT%  Deseja reiniciar o computador agora?%R%
echo %DIM%  %LN%%R%
echo   %GRN%[s]%R%  Sim
echo   %RED%[n]%R%  Não
echo %DIM%  %LN%%R%
set /p "reiniciar=%GRN%  >> Escolha uma opção [S/n]: %R%"
echo.

if /i "%reiniciar%"=="s" goto reiniciars
if /i "%reiniciar%"=="S" goto reiniciars
if /i "%reiniciar%"=="y" goto reiniciarn
if /i "%reiniciar%"=="Y" goto reiniciarn
if /i "%reiniciar%"=="n" goto reiniciarn
if /i "%reiniciar%"=="N" goto reiniciarn

echo.
call :erro "Opcao invalida! Por favor, escolha 's' ou 'n'."
echo.
pause
exit

:reiniciars
echo.
call :info "Reiniciando o computador..."
shutdown /r /c "O chefe mandou, vá descansar"
exit

:reiniciarn
echo.
call :ok "Processo finalizado sem reiniciar."
echo.
pause
exit

:escolha7
cls
call :titulo "HQ CODE  |  GERADOR DE QR CODE"
set /p "qr=%YEL%  Coloque o link: %R%"
echo.
echo.
timeout 2 >nul
curl qrenco.de/%qr%
pause

:escolha8
cls
call :titulo "ATIVADOR WINDOWS 11"
call :info "github: https://github.com/suchsoak"
echo.
echo %DIM%  %LN%%R%
call :aviso "Versao do Windows detectada:"
echo %DIM%  %LN%%R%
systeminfo | findstr /I "OS"
echo.
echo %CYN%  ╔%BX%╗%R%
echo %CYN%  ║%R%%WHT%%BLD%   SELECIONE SUA VERSÃO                             %R%%CYN%║%R%
echo %CYN%  ╚%BX%╝%R%
echo.
echo   %CYN%[ 1]%R%  Windows 11 Home
echo   %CYN%[ 2]%R%  Windows 11 Home N
echo   %CYN%[ 3]%R%  Windows 11 Home Single Language
echo   %CYN%[ 4]%R%  Windows 11 Country Specific
echo   %CYN%[ 5]%R%  Windows 11 Pro
echo   %CYN%[ 6]%R%  Windows 11 Pro N
echo   %CYN%[ 7]%R%  Windows 11 Pro for Workstations
echo   %CYN%[ 8]%R%  Windows 11 Pro for Workstations N
echo   %CYN%[ 9]%R%  Windows 11 Pro Education
echo   %CYN%[10]%R%  Windows 11 Pro Education N
echo   %CYN%[11]%R%  Windows 11 Education
echo   %CYN%[12]%R%  Windows 11 Education N
echo   %CYN%[13]%R%  Windows 11 Enterprise
echo   %CYN%[14]%R%  Windows 11 Enterprise N
echo   %CYN%[15]%R%  Windows 11 Enterprise G
echo   %CYN%[16]%R%  Windows 11 Enterprise G N
echo   %CYN%[17]%R%  Windows 11 Enterprise LTSC 2019
echo   %CYN%[18]%R%  Windows 11 Enterprise N LTSC 2019
echo.
echo %DIM%  %LN%%R%
echo.

set /p "sl=%GRN%  >> Digite o numero da sua versao e pressione Enter: %R%"

if "%sl%"=="1"  goto sl1
if "%sl%"=="2"  goto sl2
if "%sl%"=="3"  goto sl3
if "%sl%"=="4"  goto sl4
if "%sl%"=="5"  goto sl5
if "%sl%"=="6"  goto sl6
if "%sl%"=="7"  goto sl7
if "%sl%"=="8"  goto sl8
if "%sl%"=="9"  goto sl9
if "%sl%"=="10" goto sl10
if "%sl%"=="11" goto sl11
if "%sl%"=="12" goto sl12
if "%sl%"=="13" goto sl13
if "%sl%"=="14" goto sl14
if "%sl%"=="15" goto sl15
if "%sl%"=="16" goto sl16
if "%sl%"=="17" goto sl17
if "%sl%"=="18" goto sl18

if "%sl%"=="" (
  echo.
  call :erro "Nenhuma opcao selecionada. Por favor, escolha uma opcao!"
  echo.
  pause
  goto escolha8
) else (
  echo.
  call :erro "Opcao invalida! Por favor, escolha um numero de 1 a 18."
  echo.
  pause
  goto escolha8
)

:sl1
echo.
call :info "Ativando Windows 11 Home..."
slmgr /cpky
slmgr /skhc
slmgr /ipk TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
pause
exit

:sl2
echo.
call :info "Ativando Windows 11 Home N..."
slmgr /cpky
slmgr /skhc
slmgr /ipk 3KHY7-WNT83-DGQKR-F7HPR-844BM
pause
exit

:sl3
echo.
call :info "Ativando Windows 11 Home Single Language..."
slmgr /cpky
slmgr /skhc
slmgr /ipk 7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH
pause
exit

:sl4
echo.
call :info "Ativando Windows 11 Country Specific..."
slmgr /cpky
slmgr /skhc
slmgr /ipk PVMJN-6DFY6-9CCP6-7BKTT-D3WVR
pause
exit

:sl5
echo.
call :info "Ativando Windows 11 Pro..."
slmgr /cpky
slmgr /skhc
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
pause
exit

:sl6
echo.
call :info "Ativando Windows 11 Pro N..."
slmgr /cpky
slmgr /skhc
slmgr /ipk MH37W-N47XK-V7XM9-C7227-GCQG9
pause
exit

:sl7
echo.
call :info "Ativando Windows 11 Pro for Workstations..."
slmgr /cpky
slmgr /skhc
slmgr /ipk NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
pause
exit

:sl8
echo.
call :info "Ativando Windows 11 Pro for Workstations N..."
slmgr /cpky
slmgr /skhc
slmgr /ipk 9FNHH-K3HBT-3W4TD-6383H-6XYWF
pause
exit

:sl9
echo.
call :info "Ativando Windows 11 Pro Education..."
slmgr /cpky
slmgr /skhc
slmgr /ipk 6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
pause
exit

:sl10
echo.
call :info "Ativando Windows 11 Pro Education N..."
slmgr /cpky
slmgr /skhc
slmgr /ipk YVWGF-BXNMC-HTQYQ-CPQ99-66QFC
pause
exit

:sl11
echo.
call :info "Ativando Windows 11 Education..."
slmgr /cpky
slmgr /skhc
slmgr /ipk NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
pause
exit

:sl12
echo.
call :info "Ativando Windows 11 Education N..."
slmgr /cpky
slmgr /skhc
slmgr /ipk 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
pause
exit

:sl13
echo.
call :info "Ativando Windows 11 Enterprise..."
slmgr /cpky
slmgr /skhc
slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43
pause
exit

:sl14
echo.
call :info "Ativando Windows 11 Enterprise N..."
slmgr /cpky
slmgr /skhc
slmgr /ipk DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
pause
exit

:sl15
echo.
call :info "Ativando Windows 11 Enterprise G..."
slmgr /cpky
slmgr /skhc
slmgr /ipk YYVX9-NTFWV-6MDM3-9PT4T-4M68B
pause
exit

:sl16
echo.
call :info "Ativando Windows 11 Enterprise G N..."
slmgr /cpky
slmgr /skhc
slmgr /ipk 44RPN-FTY23-9VTTB-MP9BX-T84FV
pause
exit

:sl17
echo.
call :info "Ativando Windows 11 Enterprise LTSC 2019..."
slmgr /cpky
slmgr /skhc
slmgr /ipk M7XTQ-FN8P6-TTKYV-9D4CC-J462D
pause
exit

:sl18
echo.
call :info "Ativando Windows 11 Enterprise N LTSC 2019..."
slmgr /cpky
slmgr /skhc
slmgr /ipk 92NFX-8DJQP-P6BBQ-THF9C-7CG2H
pause
exit

:op1
cls
echo.
echo.
slmgr /ipk
pause

:escolha9
cls
call :titulo "ATIVADOR WINDOWS  |  MAS"
call :info "github: https://github.com/Suchsoak"
echo.
call :info "Ativando Windows com o Microsoft Activation Script (MAS)"
echo %DIM%  windows 10/11  https://get.activated.win%R%
echo.
call :aviso "Certifique-se de que o script esteja sendo executado como administrador."
echo.
irm https://get.activated.win | iex

:escolha10
cls
call :titulo "WSL  |  WINDOWS SUBSYSTEM FOR LINUX"
call :info "github: https://github.com/Suchsoak"
echo.
call :info "Baixando e instalando o WSL (Windows Subsystem for Linux)"
echo.
echo %DIM%  $ wsl --install%R%
echo.
wsl --install
echo.
call :ok "O WSL foi instalado com sucesso."
echo.
echo %WHT%  Para instalar uma distribuicao Linux, execute o comando:%R%
echo %CYN%  wsl --install -d ^<nome_da_distribuicao^>%R%
echo.
echo %DIM%  Exemplo: wsl --install -d Ubuntu%R%
echo.
call :aviso "Reinicie o computador para concluir a instalacao."
pause
:escolha11
exit

:: ============================================================
::  FUNCOES VISUAIS (apenas aparencia, sem alterar a logica)
:: ============================================================

:banner
echo.
echo %CYN%  ╔%BX%╗%R%
echo %CYN%  ║%R%%WHT%%BLD%   ◆  FERRAMENTAS DE MANUTENÇÃO                     %R%%CYN%║%R%
echo %CYN%  ╠%BX%╣%R%
echo %CYN%  ║%R%%DIM%   Github : %R%%WHT%github.com/suchsoak                     %R%%CYN%║%R%
echo %CYN%  ║%R%%DIM%   Versão : %R%%WHT%1.0.8                                   %R%%CYN%║%R%
echo %CYN%  ║%R%%DIM%   Autor  : %R%%WHT%suchsoak                                %R%%CYN%║%R%
echo %CYN%  ╚%BX%╝%R%
exit /b

:titulo
echo.
echo %CYN%  %LN2%%R%
echo %WHT%%BLD%   ◆  %~1%R%
echo %CYN%  %LN2%%R%
echo.
exit /b

:secao
echo.
echo %MAG%  ▌%R%%WHT%%BLD% %~1%R%
echo %DIM%  %LN%%R%
exit /b

:passo
echo.
echo %DIM%  ┌%LN%%R%
echo %DIM%  │%R% %YEL%%~1%R%
echo %DIM%  │%R% %DIM%$ %~2%R%
echo %DIM%  └%LN%%R%
echo.
exit /b

:info
echo %CYN%  [*]%R% %~1
exit /b

:aviso
echo %YEL%  [!]%R% %~1
exit /b

:ok
echo %GRN%  [✓]%R% %~1
exit /b

:erro
echo %RED%  [✗]%R% %~1
exit /b
