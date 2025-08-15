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
