@echo off
cls
:: Verifique se o script esta sendo executado como administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    @echo.
    @echo =====================================================
    @echo =             [!] Github: github.com/suchsoak        =
    @echo =             [!] Versao: 1.0.8                      =
    @echo =             [!] BY: suchsoak                       =
    @echo =====================================================
    @echo.
    @echo [!] Este script precisa ser executado como administrador.
    @echo.
    @pause
    exit
)

@echo.
@echo.
@echo =====================================================
@echo =             [!] Github: github.com/suchsoak        =
@echo =             [!] Versao: 1.0.8                      =
@echo =             [!] BY: suchsoak                       =
@echo =====================================================
@echo.
color 2
@echo =================== MENU PRINCIPAL ===================
@echo.
@echo   [1] Verificar discos
@echo   [2] Resetadores Netsh
color 1
@echo   [3] Systeminfo
color 7
@echo   [4] Windows Update
@echo   [5] Remover marca Windows
@echo   [6] Resetar Drive Video
@echo   [7] HQ CODE
@echo   [8] Ativar Windows (KMS)
@echo   [9] Ativar Windows (MAS)
@echo   [10] Baixar WSL (Windows Subsystem for Linux)
@echo   [11] Sair do terminal
@echo.
@echo =====================================================
timeout 2 >nul
@echo Escolha um numero de 1 a 11 para iniciar o processo.

:: Escolha de opcoes
@echo.
set /p escolha= [32m>> Escolha uma opção [1-11]: [0m

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

color 04
cls
@echo.
@echo =====================================================
@echo =            [!] OPCAO INVALIDA!                   =
@echo =      Por favor, escolha um numero de 1 a 11.      =
@echo =====================================================
@echo.
@pause
cls
goto :eof

:escolha1

@echo off
cls
@echo.
@echo.
@echo -----------------------------------
@echo Github: https://github.com/suchsoak
@echo -----------------------------------
timeout 2 >null
@echo.
:: Informacoes de disco
@echo [!] Informacoes de disco:
@echo.
powershell -Command "Get-PhysicalDisk | Format-Table FriendlyName, MediaType, Size, SerialNumber, OperationalStatus"
if not errorlevel 1 (
    @echo.
    @echo [*] Informacoes de disco obtidas com sucesso.
) else (
    @echo.
    @echo [!] Erro ao obter informacoes de disco.
)
timeout 6 >null
cls
@echo.
@echo =====================================================
@echo =            [!] VERIFICADORES DE DISCO             =
@echo =====================================================
@echo.

:: SFC ScanNow
color 3
@echo -----------------------------------------------------
@echo   [*] Verificando integridade dos arquivos do sistema
@echo   [*] Comando: Sfc /ScanNow
@echo -----------------------------------------------------
color 7
timeout 2 >nul
Sfc /ScanNow
cls

:: DISM ScanHealth
color 6
@echo -----------------------------------------------------
@echo   [*] Verificando imagem do Windows (ScanHealth)
@echo   [*] Comando: dism /online /cleanup-image /scanhealth
@echo -----------------------------------------------------
color 7
dism /online /cleanup-image /scanhealth
timeout 2 >nul
cls

:: DISM RestoreHealth
color 2
@echo -----------------------------------------------------
@echo   [*] Restaurando imagem do Windows (RestoreHealth)
@echo   [*] Comando: dism /online /cleanup-image /restorehealth
@echo -----------------------------------------------------
color 7
dism /online /cleanup-image /restorehealth
timeout 5 >nul
cls

:: DISM CheckHealth
color 9
@echo -----------------------------------------------------
@echo   [*] Checando saúde da imagem do Windows (CheckHealth)
@echo   [*] Comando: dism /Online /Cleanup-Image /CheckHealth
@echo -----------------------------------------------------
color 7
dism /Online /Cleanup-Image /CheckHealth
timeout 2 >nul
cls

:: CHKDSK
color 5
@echo -----------------------------------------------------
@echo   [*] Verificando disco rígido (chkdsk)
@echo   [*] Comando: chkdsk
@echo -----------------------------------------------------
color 7
timeout 3 >nul
chkdsk
cls

:: Apagando arquivos temporários
color 4
@echo -----------------------------------------------------
@echo   [*] Apagando arquivos temporários (%temp%)
@echo -----------------------------------------------------
color 7
cd %temp%
del /F /Q *
timeout 3 >nul
cls

:: Identificando Disco
color 1
@echo -----------------------------------------------------
@echo   [*] Identificando Disco
@echo -----------------------------------------------------
color 7
@echo.

wmic diskdrive get mediatype | findstr /c:"Fix hard disk media" > null
if %errorlevel% == 0 (
  color 3
  @echo -----------------------------------------------------
  @echo   [*] Desfragmentando Disco Rígido (HDD)...
  @echo   [*] Comando: defrag C: /U /V
  @echo -----------------------------------------------------
  color 7
  defrag C: /U /V
  timeout 3 >null
  color 2
  @echo -----------------------------------------------------
  @echo   [*] Desfragmentação Concluída.
  @echo -----------------------------------------------------
  color 7
) else (
  color 6
  @echo -----------------------------------------------------
  @echo   [*] SSD detectado: NÃO é recomendado desfragmentar.
  @echo -----------------------------------------------------
  color 7
  timeout 3 >null
)

timeout 3 >null
@echo [*] Processo Finalizado...
timeout 3 >null
@echo.
cls
@echo.
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [!] AVISO o processo levara um tempo, dependendo da maquina.
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo.
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [*] 1. Executar o comando chkdsk /r
@echo:: [*] 2. Nao executar o comando
@echo:::::::::::::::::::::::::::::::::::::::::::: 

set /p op=  escolha uma opcao: 

if %op% equ 1 goto op1
if %op% equ 2 goto op2

:op1

@echo -------------------------
@echo:: [*] chkdsk /r
@echo ------------------------- 
timeout 3 >null
chkdsk /r
@echo.
@echo =====================================
@echo =  [!] Agora reinicie o computador. =
@echo =====================================
:op2
cls 
@echo.
@echo [*] Saindo Do Terminal...
timeout 3 >null
color 7
cls
exit

:escolha2

@echo off
cls
color 3
@echo.
@echo ============================================================
@echo =                 RESETADORES NETSH                        =
@echo ============================================================
@echo.
@echo      Github: https://github.com/suchsoak
@echo ============================================================
@echo.
color 2
@echo  ╔════════════════════════════════════════════════════════╗
@echo  ║                ESCOLHA UMA OPÇÃO                       ║
@echo  ╠════════════════════════════════════════════════════════╣
@echo  ║   [1] Colocar Regras De Firewall                       ║
@echo  ║   [2] Nao Colocar Regras De Firewall                   ║
@echo  ╚════════════════════════════════════════════════════════╝
color 7
@echo.

set /p firewall=  escolha uma opcao: 

if %firewall% == 1 goto firewall1
if %firewall% == 2 goto firewall2

:firewall1

cls
color 1
@echo.
@echo Regras De Firewall
@echo.

@echo off
set /p porta=Coloque a porta:
@echo. 
@echo Porta escolhida: %porta%

timeout 1 > null
netsh advfirewall firewall add rule name="Block %porta%" dir=in action=block protocol=TCP localport=%porta% 
@echo.
timeout 3 >null
@echo [!] Informacoes De Rede: 
color 7
@echo.
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
timeout 3 >null
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [!] Resetadores de rede
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo.
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [*] Configurando ipconfig...
@echo:::::::::::::::::::::::::::::::::::::::::::: 
timeout /t 2 >null
ipconfig /renew
ipconfig /flushdns
timeout /t 2 >null
cls
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [!] Configuracao de ip concluida.
@echo::::::::::::::::::::::::::::::::::::::::::::
timeout /t 2 > null
@echo.
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [!] Configurando Netsh... 
@echo::::::::::::::::::::::::::::::::::::::::::::
timeout /t 1 >null
@echo.

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
timeout /t 3 >null
cls

@echo.
@echo -------------------------------------------------
@echo Netsh configurado, agora reinicie o computador.
@echo -------------------------------------------------
@echo.
@pause
exit

:firewall2
cls
color 4
timeout 2 >null
@echo [!] Informacoes De Rede: 
color 7
@echo.
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
timeout 3 >null
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [!] Resetadores de rede
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo.
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [*] Configurando ipconfig...
@echo:::::::::::::::::::::::::::::::::::::::::::: 
timeout /t 2 >null
ipconfig /renew
cls
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [!] Configuracao de ip concluida.
@echo::::::::::::::::::::::::::::::::::::::::::::
timeout /t 3 > null
@echo.
@echo::::::::::::::::::::::::::::::::::::::::::::
@echo:: [!] Configurando Netsh... 
@echo::::::::::::::::::::::::::::::::::::::::::::
timeout /t 2 >null
@echo.

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
timeout /t 3 >null
cls

@echo.
@echo ================================================
@echo Netsh configurado, agora reinicie o computador.
@echo ================================================

@echo.
@pause
exit

:escolha3

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

:escolha4

cls
color 3
@echo ============================================================
@echo =                  RESETAR WINDOWS UPDATE                  =
@echo ============================================================
@echo.
@echo [*] Github: https://github.com/suchsoak
@echo ------------------------------------------------------------
@echo [!] Este processo irá resetar o Windows Update.
@echo ------------------------------------------------------------
timeout /t 2 >nul
color 7
@echo.
@echo [*] Parando serviços relacionados ao Windows Update...
@echo ------------------------------------------------------------
net stop wuauserv >nul
net stop bits >nul
net stop cryptsvc >nul
net stop appidsvc >nul
net stop trustedinstaller >nul
timeout /t 1 >nul

color 6
@echo [*] Renomeando pastas de atualização...
@echo ------------------------------------------------------------
ren %systemroot%\SoftwareDistribution SoftwareDistribution.bak >nul 2>&1
ren %systemroot%\System32\catroot2 catroot2.bak >nul 2>&1
timeout /t 1 >nul

color 2
@echo [*] Reiniciando serviços...
@echo ------------------------------------------------------------
net start wuauserv >nul
net start bits >nul
net start cryptsvc >nul
net start appidsvc >nul
net start trustedinstaller >nul
timeout /t 1 >nul

color 1
@echo [*] Configurando inicialização automática dos serviços...
@echo ------------------------------------------------------------
sc config wuauserv start= auto >nul
sc config bits start= auto >nul
sc config cryptsvc start= auto >nul
sc config appidsvc start= auto >nul
sc config trustedinstaller start= auto >nul
timeout /t 1 >nul

color 5
@echo [*] Forçando busca de atualizações...
@echo ------------------------------------------------------------
wuauclt /detectnow
wuauclt /reportnow
timeout /t 1 >nul

color 7
@echo.
@echo ============================================================
@echo =   Verifique nas configurações se o Windows está           =
@echo =   atualizando. Caso não esteja, reinicie a máquina.       =
@echo ============================================================
@echo.
@pause
exit

:escolha5

cls
color 3
@echo ============================================================
@echo =           REMOVER MARCA D'ÁGUA DO WINDOWS                =
@echo ============================================================
@echo.
@echo [*] Github: https://github.com/suchsoak
@echo ------------------------------------------------------------
@echo [!] Este processo irá remover a marca d'água do Windows.
@echo ------------------------------------------------------------
timeout /t 3 >nul
color 7
@echo.
@echo [*] Limpando chaves de produto...
SLMGR.VBS /CPKY 
SLMGR.VBS /CKMS 
@echo [*] Parando serviço de proteção de software...
Net stop Sppsvc 
@echo [*] Renomeando arquivo de tokens...
CD C:\Windows\System32\SPP\Store\2.0 
Ren Tokens.dat Tokens.old 
@echo [*] Reinstalando licenças...
SLMGR.VBS /RILC 
@echo [*] Restaurando integridade do sistema...
Bcdedit.exe -set loadoptions ENABLE_INTEGRITY_CHECKS
Bcdedit.exe -set TESTSIGNING OFF
color 2
@echo.
@echo ============================================================
@echo =   [!] Processo concluído! Reinicie a máquina agora.      =
@echo ============================================================
@pause
exit

:escolha6

cls
color 1
@echo ============================================================
@echo =                RESETAR DRIVER DE VÍDEO                   =
@echo ============================================================
@echo.
@echo [*] Github: https://github.com/suchsoak
@echo ------------------------------------------------------------
@echo [!] Listando dispositivos de vídeo...
@echo ------------------------------------------------------------
pnputil /enum-devices /class Display | findstr "ID da Instância"
@echo.
set /p ID=Digite a ID da Instância do driver de vídeo: 
@echo.
@echo [*] Reiniciando dispositivo de vídeo...
pnputil /restart-device "%ID%"
@echo.
color 7
@echo ------------------------------------------------------------
@echo Deseja reiniciar o computador agora?
@echo ------------------------------------------------------------
@echo [s] Sim
@echo [n] Não
@echo ------------------------------------------------------------
set /p reiniciar=Escolha uma opção [S/n]: 
@echo.

if /i "%reiniciar%"=="s" goto reiniciars
if /i "%reiniciar%"=="S" goto reiniciars
if /i "%reiniciar%"=="y" goto reiniciarn
if /i "%reiniciar%"=="Y" goto reiniciarn
if /i "%reiniciar%"=="n" goto reiniciarn
if /i "%reiniciar%"=="N" goto reiniciarn

color 4
@echo.
@echo [!] Opção inválida! Por favor, escolha 's' ou 'n'.
@echo.
@pause
exit

:reiniciars
color 2
@echo.
@echo [*] Reiniciando o computador...
shutdown /r /c "O chefe mandou, vá descansar"
exit

:reiniciarn
color 2
@echo.
@echo [*] Processo finalizado sem reiniciar.
@echo.
@pause
exit

:escolha7
cls
@echo.
@echo.
set /p qr= Coloque o link:
@echo.
@echo.
timeout 2 >null
curl qrenco.de/%qr%
@pause

:escolha8
cls
color 3
@echo.
@echo ============================================================
@echo =                  ATIVADOR WINDOWS 11                     =
@echo ============================================================
@echo.
@echo [*] github: https://github.com/suchsoak
@echo.
@echo ------------------------------------------------------------
@echo [!] Versao do Windows detectada:
@echo ------------------------------------------------------------
systeminfo | findstr /I "OS"
@echo.
@echo ============================================================
@echo =                  SELECIONE SUA VERSAO                    =
@echo ============================================================
@echo.
@echo  [1] Windows 11 Home
@echo  [2] Windows 11 Home N
@echo  [3] Windows 11 Home Single Language
@echo  [4] Windows 11 Country Specific
@echo  [5] Windows 11 Pro
@echo  [6] Windows 11 Pro N
@echo  [7] Windows 11 Pro for Workstations
@echo  [8] Windows 11 Pro for Workstations N
@echo  [9] Windows 11 Pro Education
@echo  [10] Windows 11 Pro Education N
@echo  [11] Windows 11 Education
@echo  [12] Windows 11 Education N
@echo  [13] Windows 11 Enterprise
@echo  [14] Windows 11 Enterprise N
@echo  [15] Windows 11 Enterprise G
@echo  [16] Windows 11 Enterprise G N
@echo  [17] Windows 11 Enterprise LTSC 2019
@echo  [18] Windows 11 Enterprise N LTSC 2019
@echo.
@echo ============================================================
@echo.

set /p sl= Digite o numero da sua versao e pressione Enter: 

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
  color 4
  @echo.
  @echo [!] Nenhuma opcao selecionada. Por favor, escolha uma opcao!
  @echo.
  @pause
  goto escolha8
) else (
  color 4
  @echo.
  @echo [!] Opcao invalida! Por favor, escolha um numero de 1 a 18.
  @echo.
  @pause
  goto escolha8
)

:sl1
color 2
@echo.
@echo [*] Ativando Windows 11 Home...
slmgr /cpky
slmgr /skhc
slmgr /ipk TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
@pause
exit

:sl2
color 2
@echo.
@echo [*] Ativando Windows 11 Home N...
slmgr /cpky
slmgr /skhc
slmgr /ipk 3KHY7-WNT83-DGQKR-F7HPR-844BM
@pause
exit

:sl3
color 2
@echo.
@echo [*] Ativando Windows 11 Home Single Language...
slmgr /cpky
slmgr /skhc
slmgr /ipk 7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH
@pause
exit

:sl4
color 2
@echo.
@echo [*] Ativando Windows 11 Country Specific...
slmgr /cpky
slmgr /skhc
slmgr /ipk PVMJN-6DFY6-9CCP6-7BKTT-D3WVR
@pause
exit

:sl5
color 2
@echo.
@echo [*] Ativando Windows 11 Pro...
slmgr /cpky
slmgr /skhc
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
@pause
exit

:sl6
color 2
@echo.
@echo [*] Ativando Windows 11 Pro N...
slmgr /cpky
slmgr /skhc
slmgr /ipk MH37W-N47XK-V7XM9-C7227-GCQG9
@pause
exit

:sl7
color 2
@echo.
@echo [*] Ativando Windows 11 Pro for Workstations...
slmgr /cpky
slmgr /skhc
slmgr /ipk NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
@pause
exit

:sl8
color 2
@echo.
@echo [*] Ativando Windows 11 Pro for Workstations N...
slmgr /cpky
slmgr /skhc
slmgr /ipk 9FNHH-K3HBT-3W4TD-6383H-6XYWF
@pause
exit

:sl9
color 2
@echo.
@echo [*] Ativando Windows 11 Pro Education...
slmgr /cpky
slmgr /skhc
slmgr /ipk 6TP4R-GNPTD-KYYHQ-7B7DP-J447Y
@pause
exit

:sl10
color 2
@echo.
@echo [*] Ativando Windows 11 Pro Education N...
slmgr /cpky
slmgr /skhc
slmgr /ipk YVWGF-BXNMC-HTQYQ-CPQ99-66QFC
@pause
exit

:sl11
color 2
@echo.
@echo [*] Ativando Windows 11 Education...
slmgr /cpky
slmgr /skhc
slmgr /ipk NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
@pause
exit

:sl12
color 2
@echo.
@echo [*] Ativando Windows 11 Education N...
slmgr /cpky
slmgr /skhc
slmgr /ipk 2WH4N-8QGBV-H22JP-CT43Q-MDWWJ
@pause
exit

:sl13
color 2
@echo.
@echo [*] Ativando Windows 11 Enterprise...
slmgr /cpky
slmgr /skhc
slmgr /ipk NPPR9-FWDCX-D2C8J-H872K-2YT43
@pause
exit

:sl14
color 2
@echo.
@echo [*] Ativando Windows 11 Enterprise N...
slmgr /cpky
slmgr /skhc
slmgr /ipk DPH2V-TTNVB-4X9Q3-TJR4H-KHJW4
@pause
exit

:sl15
color 2
@echo.
@echo [*] Ativando Windows 11 Enterprise G...
slmgr /cpky
slmgr /skhc
slmgr /ipk YYVX9-NTFWV-6MDM3-9PT4T-4M68B
@pause
exit

:sl16
color 2
@echo.
@echo [*] Ativando Windows 11 Enterprise G N...
slmgr /cpky
slmgr /skhc
slmgr /ipk 44RPN-FTY23-9VTTB-MP9BX-T84FV
@pause
exit

:sl17
color 2
@echo.
@echo [*] Ativando Windows 11 Enterprise LTSC 2019...
slmgr /cpky
slmgr /skhc
slmgr /ipk M7XTQ-FN8P6-TTKYV-9D4CC-J462D
@pause
exit

:sl18
color 2
@echo.
@echo [*] Ativando Windows 11 Enterprise N LTSC 2019...
slmgr /cpky
slmgr /skhc
slmgr /ipk 92NFX-8DJQP-P6BBQ-THF9C-7CG2H
@pause
exit

:op1
cls
@echo.
@echo.
slmgr /ipk
@pause

:escolha9
@echo off
cls
@echo.
@echo -----------------------------------
@echo github: https://github.com/Suchsoak
@echo -----------------------------------
@echo.
@echo Ativando Windows com o Microsoft Activation Script (MAS)
@echo windows 10/11  <https://get.activated.win>
@echo.
@echo [!] Certifique-se de que o script esteja sendo executado como administrador.
@echo.
irm https://get.activated.win | iex

:escolha10
cls
@echo.
@echo.
@echo -----------------------------------
@echo github: https://github.com/Suchsoak
@echo -----------------------------------
@echo.
@echo Baixando e instalando o WSL (Windows Subsystem for Linux)
@echo.
@echo wsl --install
@echo.
wsl --install
@echo.
@echo [!] O WSL foi instalado com sucesso.
@echo.
@echo. Para instalar uma distribuicao Linux, execute o comando:
@echo wsl --install -d <nome_da_distribuicao>
@echo.
@echo Exemplo: wsl --install -d Ubuntu
@echo.
@echo [!] Reinicie o computador para concluir a instalacao.
@pause
:escolha11
exit
