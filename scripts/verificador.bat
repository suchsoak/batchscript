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
