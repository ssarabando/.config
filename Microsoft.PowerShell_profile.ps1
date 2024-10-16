## utils

function ffp {
  param (
    [string]$filename
  )
  $fn=$filename.Substring(2).Replace("``", "") # removes leading '.\' and '`'
  ffplay -vf "subtitles=`'$fn`'" $fn
}

Function freespace {
    Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object -Property DeviceID,@{'Name' = 'FreeSpace (GB)'; Expression= { [int]($_.FreeSpace / 1GB) }}
}
Set-Alias -Name df -Value freespace

Function komorebi_start {
    komorebic start --whkd
}
Function komorebi_stop {
    komorebic stop --whkd
}
Function komorebi_reload {
    komorebic fetch-asc
    komorebic reload-configuration
}
Set-Alias -Name kstart -Value komorebi_start
Set-Alias -Name kstop -Value komorebi_stop
Set-Alias -Name kreload -Value komorebi_reload

Function vs22 {
    Import-Module 'C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\Tools\Microsoft.VisualStudio.DevShell.dll'
    Enter-VsDevShell -VsInstallPath "C:\Program Files\Microsoft Visual Studio\2022\Professional\"
}

Set-Alias -Name touch -Value Out-File

# git

Function git_checkout { git checkout $args }
Set-Alias -Name gco -Value git_checkout

Function git_clear_and_status { clear; git status }
Set-Alias -Name gst -Value git_clear_and_status

Function git_cleanup { git gc }
Set-Alias -Name ggc -Value git_cleanup

Function git_log { git log --name-only }
Set-Alias -Name gln -Value git_log

Function git_status { git status }
Set-Alias -Name gs -Value git_status

# Notepad++

if (Test-Path "$env:ProgramFiles/Notepad++/notepad++.exe") {
    Function notepad_plus_plus {
        & "$env:ProgramFiles/Notepad++/notepad++.exe" $args
    }
    Set-Alias -Name npp -Value notepad_plus_plus
}

# Azure Data Studio

if (Test-Path "$env:LocalAppData/Programs/Azure Data Studio/azuredatastudio.exe") {
    Function azure_data_studio {
        & "C:\Users\ssarabando\AppData\Local\Programs\Azure Data Studio\azuredatastudio.exe" | Out-Null
    }
    Set-Alias -Name ads -Value azure_data_studio
}

# Komorebi

$Env:KOMOREBI_CONFIG_HOME = "$Env:USERPROFILE\.config\komorebi"

Function komorebi_start { komorebic start --whkd } 
Set-Alias -Name kstart -Value komorebi_start

Function komorebi_stop { komorebic stop --whkd }
Set-Alias -Name kstop -Value komorebi_stop

oh-my-posh init pwsh --config "$env:USERPROFILE\.config\ohmyposh\own-basedon-jandedobbeleer.omp.json" | Invoke-Expression

