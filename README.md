﻿# powershellprofile

## Add Env Variable
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\bin", "User")
