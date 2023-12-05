function goToWork {set-location "~\Desktop\Work\development\"}
function goToEmp {set-location "~\Desktop\Work\development\EMP\Client"}
function goToEmp2 {set-location "~\Desktop\Work\development\EMP_Develop\Client"}
function goToVim {set-location "~\AppData\Local\nvim"}

function searchWorkDirectory {
    Get-ChildItem -Path "~\Desktop\Work\development\" | Select FullName | fzf | %{ set-location $_.Trim() }
    ls
}
Set-Alias fwd searchWorkDirectory

function searchPersonalDirectory {
    Get-ChildItem -Path "~\Desktop\Projects\" | Select FullName | fzf | %{ set-location $_.Trim() }
    ls
}
Set-Alias fpd searchPersonalDirectory

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

# Store previous command's output in $__
$PSDefaultParameterValues['Out-Default:OutVariable'] = '__'
