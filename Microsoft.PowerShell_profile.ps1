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

Function vs22 {
    $path = $null
    Get-ChildItem -Path "$Env:ProgramFiles" -Filter 'Microsoft.VisualStudio.DevShell.dll' -Recurse -File -ErrorAction Ignore | % { $path = $_.FullName }
    if ($path -eq $null) {
        Get-ChildItem -Path "${env:ProgramFiles(x86)}" -Filter 'Microsoft.VisualStudio.DevShell.dll' -Recurse -File -ErrorAction Ignore | % { $path = $_.FullName }
    }
    Import-Module $path
    Enter-VsDevShell 0af32636 -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64"
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

Function git_add_prompt { git add -p }
Set-Alias -Name gap -Value git_add_prompt

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

oh-my-posh init pwsh --config "$env:USERPROFILE\.config\ohmyposh\own-basedon-jandedobbeleer.omp.json" | Invoke-Expression

