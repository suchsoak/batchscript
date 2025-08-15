<p align="center">
  <img src="https://github.com/suchsoak/batchscript/blob/main/BATCHALL_.png" alt="batchall.png" width="400">
</p>

# 🚀 BATCHALL: Sua Central de Scripts Batch para Windows! 🖥️

## O que é o BATCHALL? 🤔

**Batchall** é um super script em batch que reúne uma galeria de utilitários para facilitar tarefas comuns no Windows, como otimizar o disco, resetar configurações de rede, verificar integridade do sistema, instalar o WSL e muito mais! Tudo isso em um só lugar, com comandos prontos para uso e explicações detalhadas.

---

> ⚠️ **ATENÇÃO:**  
> O comando `WMIC` não está mais disponível. Agora, utilizamos o `powershell` para as funções equivalentes!

> 💡 **NOTA:**  
> Atualmente, o script possui **10 utilitários**. Novos scripts serão adicionados em breve!  
> Quer mais opções? Confira também meu repositório de scripts em PowerShell:  
> 👉 [https://github.com/suchsoak/Powershell_script](https://github.com/suchsoak/Powershell_script)

---

## 📚 Índice

- [Marca d'água do Windows](#marca-dágua-do-windows)
- [Windows Update](#windows-update)
- [Resetar Configurações de Rede (Netsh)](#resetar-configurações-de-rede-netsh)
- [Systeminfo Simplificado](#systeminfo-simplificado)
- [Verificador de Disco](#verificador-de-disco)
- [Resetar Driver de Vídeo](#resetar-driver-de-vídeo)
- [Gerar QR Code](#gerar-qr-code)
- [Ativar Windows (KMS)](#ativar-windows-kms)
- [Ativar Windows (MAS)](#ativar-windows-mas)
- [Instalar WSL Linux](#instalar-wsl-linux)
- [Documentação dos Códigos](#documentação-dos-códigos-utilizados)
- [Licença](#licença)

---

<details>
<summary>🪟 <strong>Marca d'água do Windows</strong></summary>

Este script remove a marca d'água "Ative o Windows" e limpa a chave do produto do registro.  
⚠️ **Cuidado:** Modificar o registro pode causar problemas graves se feito incorretamente!

**Comandos utilizados:**
- `SLMGR.VBS /CPKY` – Limpa a chave do produto do registro.
- `SLMGR.VBS /CKMS` – Limpa o servidor KMS.
- `Net stop Sppsvc` – Para o serviço de ativação.
- `CD C:\Windows\System32\SPP\Store\2.0` – Navega até a pasta de licenças.
- `Ren Tokens.dat Tokens.old` – Faz backup do arquivo de tokens.
- `SLMGR.VBS /RILC` – Reconstrói a licença.
- `reg add ... displayntoret ...` – Remove a marca d'água.

🔗 [Mais informações sobre a marca d'água](https://answers.microsoft.com/pt-br/windows/forum/all/marca-d%C3%A1gua-solicitando-ativa%C3%A7%C3%A3o-do/2ca8e29c-a54c-4498-baa6-22b04aa2b81c)

</details>

---

<details>
<summary>🔄 <strong>Windows Update</strong></summary>

Scripts para reiniciar e configurar os serviços do Windows Update.  
Ideal para resolver problemas de atualização!

**Comandos principais:**
```sh
net start bits
net start wuauserv
net start cryptSvc
net start msiserver
SC config wuauserv start= auto
SC config bits start= auto
SC config cryptsvc start= auto
SC config trustedinstaller start= auto
```
> 💡 Os comandos `SC` funcionam apenas no CMD, não no PowerShell.

</details>

---

<details>
<summary>🌐 <strong>Resetar Configurações de Rede (Netsh)</strong></summary>

Resete as configurações de rede e portas TCP/IP para resolver problemas de conexão!

**Como usar:**
- Execute o script como **Administrador**.

**Comandos utilizados:**
- `netsh winsock reset all`
- `netsh int ipv4 reset all`
- `netsh int ipv6 reset all`
- `ipconfig /renew`
- `netsh advfirewall firewall add rule ...`

🔗 [Documentação Netsh](https://learn.microsoft.com/pt-br/windows-server/networking/technologies/netsh/netsh)

</details>

---

<details>
<summary>📝 <strong>Systeminfo Simplificado</strong></summary>

Obtenha informações detalhadas do seu PC: processador, disco, memória, rede, IP, localização e mais!

**Como usar:**
- Execute `batchall.bat` como **Administrador**.

**Exemplo de saída:**
- Arquitetura do processador
- Modelo e espaço do disco
- Informações de RAM
- Dados de rede e IP externo (via `curl` e `ipinfo.io`)
- Informações salvas em `informacoes.txt`

🔗 [Documentação WMIC](https://learn.microsoft.com/pt-br/windows-server/administration/windows-commands/wmic)

</details>

---

<details>
<summary>🛠️ <strong>Verificador de Disco</strong></summary>

Verifique e repare arquivos do sistema com o clássico `sfc /scannow`.

**Comando principal:**
```sh
Sfc /ScanNow
```
🔗 [Como usar o Verificador de Arquivos do Sistema](https://support.microsoft.com/pt-br/topic/use-a-ferramenta-verificador-de-arquivos-do-sistema-para-reparar-arquivos-de-sistema-ausentes-ou-corrompidos-79aa86cb-ca52-166a-92a3-966e85d4094e)

</details>

---

<details>
<summary>🎮 <strong>Resetar Driver de Vídeo</strong></summary>

Reinicie o driver de vídeo facilmente, útil para resolver problemas gráficos!

**Comandos:**
```sh
pnputil /enum-devices /class Display | findstr "ID da Instância"
pnputil /restart-device "%ID%"
```
Ou use o atalho: `CTRL+SHIFT+WINDOWS+B` 😉

</details>

---

<details>
<summary>🔳 <strong>Gerar QR Code</strong></summary>

Gere um QR Code de qualquer link rapidamente!

**Comando:**
```sh
curl qrenco.de/%qr%
```
<p align="center">
  <img src="https://github.com/suchsoak/bashscript/blob/main/diskimg/HQCODE.png" alt="HRCODE.png" width="200">
</p>

</details>

---

<details>
<summary>🔑 <strong>Ativar Windows (KMS)</strong></summary>

Ative o Windows usando chaves públicas KMS (para fins educacionais).

**Exemplo de chaves:**
```
Windows 11 Pro: W269N-WFGWX-YVC9B-4J6C9-T83GX
Windows 11 Home: TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
...
```
O script permite escolher a versão do Windows e aplica a chave correspondente.

🔗 [Mais chaves KMS](https://gist.github.com/sevynkooper/8e60a6038b10e57c31830f279a026bef)  
🔗 [Documentação Slmgr.vbs](https://learn.microsoft.com/pt-br/windows-server/get-started/activation-slmgr-vbs-options)

</details>

---

<details>
<summary>🧩 <strong>Ativar Windows (MAS)</strong></summary>

Ative o Windows usando o método MAS (Microsoft Activation Scripts).

> ⚠️ **Atenção:** O uso é de responsabilidade do usuário.

🔗 [Microsoft Activation Scripts](https://github.com/massgravel/Microsoft-Activation-Scripts)

</details>

---

<details>
<summary>🐧 <strong>Instalar WSL Linux</strong></summary>

Instale o WSL (Windows Subsystem for Linux) facilmente pelo script!

**Comando:**
```sh
wsl --install
```
Depois, instale a distribuição desejada:
```sh
wsl --install -d Ubuntu
```
🔗 [Documentação WSL](https://learn.microsoft.com/pt-br/windows/wsl/install)

</details>

---

## 📖 Documentação dos Códigos Utilizados

| Biblioteca/Comando | Link |
|--------------------|------|
| Verificador de arquivos | [support.microsoft.com](https://support.microsoft.com/pt-br/topic/use-a-ferramenta-verificador-de-arquivos-do-sistema-para-reparar-arquivos-de-sistema-ausentes-ou-corrompidos-79aa86cb-ca52-166a-92a3-966e85d4094e) |
| chkdsk | [learn.microsoft.com](https://learn.microsoft.com/pt-br/windows-server/administration/windows-commands/chkdsk?tabs=event-viewer) |
| Repair | [learn.microsoft.com](https://learn.microsoft.com/pt-br/windows-hardware/manufacture/desktop/repair-a-windows-image?view=windows-11) |
| del /F /Q * | [answers.microsoft.com](https://answers.microsoft.com/pt-br/windows/forum/all/como-forçar-o-delete-de-uma-pasta-no-windows/86d37617-6ec9-4c0f-b219-0d299a6e3d42) |
| wmic | [learn.microsoft.com](https://learn.microsoft.com/pt-br/windows-server/administration/windows-commands/wmic) |
| reg add | [learn.microsoft.com](https://learn.microsoft.com/pt-br/windows-server/administration/windows-commands/reg-add) |
| powershell -command | [learn.microsoft.com](https://learn.microsoft.com/pt-br/powershell/scripting/overview?view=powershell-7.5) |
| WSL Linux | [learn.microsoft.com](https://learn.microsoft.com/pt-br/windows/wsl/install) |

---

## 📝 Licença

MIT License © 2025 ~#M?x

---

> Feito com 💙 por [suchsoak](https://github.com/suchsoak)  
> Contribuições e sugestões são bem-vindas! 😄

