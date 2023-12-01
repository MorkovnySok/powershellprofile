# powershellprofile
## Clone repo
git clone https://github.com/MorkovnySok/powershellprofile.git $home/Documents/WindowsPowerShell

## Add Env Variable
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\bin", "User")
