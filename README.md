# WinInitSetBase

*This script is intended to be run on every new Windows installation by me and anyone else who wishes to use it.*

## What it does

- **Disables unnecessary processes** that are only needed for Windows Server integration.  
- **Turns off Windows Logon** (when appropriate for the target device).  
- **Removes features** that are better suited for point‑of‑sale (POS) devices.  
- **Uninstalls pre‑installed components** that, in my opinion, should not be present by default, such as:  
  - Legacy Windows Media Player  
  - Copilot  
  - Bing search integration on the taskbar  

These changes streamline the OS, reduce background activity, and give a cleaner base for customized deployments.

## Installation
1. Clone the repository (or download the script).
    git clone https://github.com/](https://github.com/Jake-makes/WinInitSetBase.git
   
3. Open PowerShell as Administrator and run the script.
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    .\WinInitSetBase.ps1

<img width="1136" height="204" alt="image" src="https://github.com/user-attachments/assets/302677c9-645a-45e3-9017-47174fca0122" />
