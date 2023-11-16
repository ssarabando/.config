## utils

Function freespace {
    Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object -Property DeviceID,@{'Name' = 'FreeSpace (GB)'; Expression= { [int]($_.FreeSpace / 1GB) }}
}
Set-Alias -Name df -Value freespace

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

if (Test-Path "$env:ProgramFiles/Notepad++/notepad++.exe") {
    Function notepad_plus_plus {
        & "$env:ProgramFiles/Notepad++/notepad++.exe" $args
    }
    Set-Alias -Name npp -Value notepad_plus_plus
}

if (Test-Path "$env:LocalAppData/Programs/Azure Data Studio/azuredatastudio.exe") {
    Function azure_data_studio {
        & "C:\Users\ssarabando\AppData\Local\Programs\Azure Data Studio\azuredatastudio.exe" | Out-Null
    }
    Set-Alias -Name ads -Value azure_data_studio
}

Set-Alias -Name touch -Value Out-File

# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/atomic.omp.json" | Invoke-Expression
oh-my-posh init pwsh --config "$env:USERPROFILE\.config\ohmyposh\own-basedon-jandedobbeleer.omp.json" | Invoke-Expression
