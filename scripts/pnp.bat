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
