# windows-process-monitor
A small script to constantly check if a process is running in Windows

## How to use it

* Clone the repository


* Bypass the Windows execution policy by running the following command in PowerShell

    `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`


* Run the command (By default it will check for process Explorer)

    `.\monitor.ps1`

* The script can receive two optional parameters:
    Process Name: A string with the process name you want to check
    Alert Type: A string to identify the type of alert (BALLON or POPUP)

For example:

`.\monitor.ps1 Explorer BALLON`