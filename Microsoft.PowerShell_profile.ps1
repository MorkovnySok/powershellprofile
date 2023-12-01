function goToWork {set-location"~\Desktop\Work\development\"}
function goToEmp {set-location"~\Desktop\Work\development\EMP\Client"}
function goToEmp2 {set-location"~\Desktop\Work\development\EMP_Develop\Client"}
function goToVim {set-location"~\AppData\Local\nvim"}

Set-Alias work goToWork
Set-Alias emp goToEmp
Set-Alias emp2 goToEmp2
Set-Alias cfg goToVim
Set-Alias lz lazygit
Remove-Item Alias:curl
