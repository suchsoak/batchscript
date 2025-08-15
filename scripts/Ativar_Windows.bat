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
