function goToWork {set-location "~\Desktop\Work\development\"}
function goToEmp {set-location "~\Desktop\Work\development\EMP\"}
function goToEmp2 {set-location "~\Desktop\Work\development\EMP2\"}
function goToVim {set-location "~\AppData\Local\nvim"}

function searchWorkDirectory {
    Get-ChildItem -Path "~\Desktop\Work\development\" | Select FullName | fzf | %{ set-location $_.Trim() }
    ls
}
Set-Alias w searchWorkDirectory

function searchPersonalDirectory {
    Get-ChildItem -Path "~\Desktop\Projects\" | Select FullName | fzf | %{ set-location $_.Trim() }
    ls
}
Set-Alias p searchPersonalDirectory

function hist { 
    (Get-Content (Get-PSReadlineOption).HistorySavePath) | Sort-Object -Unique | fzf | clip
}

# change into fzf file directory
function czf {
    $file = & fzf
    if ($file) { 
      $path = Split-Path $file -Parent
      & cd "$path"
    }
}

function OpenInVim {
    $file = & fzf
    if ($file) { & nvim $file }
}
New-Alias -Name vzf -Value OpenInVim 

function mklink { cmd /c mklink $args }

function rgf($pattern) { rg --files | rg "$pattern" }

Set-Alias pws powershell.exe
Set-Alias work goToWork
Set-Alias emp goToEmp
Set-Alias emp2 goToEmp2
Set-Alias cfg goToVim
Set-Alias lz lazygit
Remove-Item Alias:curl
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PsFzfOption -EnableAliasFuzzyEdit
Set-PsFzfOption -EnableAliasFuzzyFasd
Set-PsFzfOption -EnableAliasFuzzyHistory
Set-PsFzfOption -EnableAliasFuzzyKillProcess
Set-PsFzfOption -EnableAliasFuzzySetLocation
Set-PsFzfOption -EnableAliasFuzzySetEverything
Set-PsFzfOption -EnableAliasFuzzyScoop
Set-PsFzfOption -EnableAliasFuzzyZLocation
Set-PsFzfOption -EnableAliasFuzzyGitStatus
Set-PsFzfOption -EnableFd

Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -EditMode Windows

# Store previous command's output in $__
$PSDefaultParameterValues['Out-Default:OutVariable'] = '__'
