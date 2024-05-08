function goToWork {set-location "~\Work"}
function goToEmp {set-location "~\Work\emp\"}
function goToEmp2 {set-location "~\Desktop\Work\development\EMP2\"}
function goToVim {set-location "~\AppData\Local\nvim"}

function gs {
	param (
		[Parameter(ValueFromPipeline)] $branch
	)

	Write-Host "switching to $branch" -ForegroundColor Green
	git fetch; git stash; git switch $branch; git pull; git stash apply
}

function gf {
	param (
		[string] $branch
	)
	$branches = git branch -r | sls $branch | %{$_ -replace '\s+', ''} | Where-Object {$_ -ne ''} | % {$_ -replace 'origin/', ''}
	if($branches.Count -gt 1) {
		Write-Host "There are more than one branch found by this pattern. Be more specific" -ForegroundColor Red
		$branches | % {Write-Host $_}
		Throw
	}
	Write-Output $branches
}

function searchWorkDirectory {
    Get-ChildItem -Path "~\Work" | Select FullName | fzf | %{ set-location $_.Trim() }
    ls
}
Set-Alias w searchWorkDirectory

function searchPersonalDirectory {
    Get-ChildItem -Path "~\Projects\" | Select FullName | fzf | %{ set-location $_.Trim() }
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
#Remove-Item Alias:curl

Import-Module PSFzf
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
Set-PsFzfOption -TabExpansion


# PSReadLine stuff
# https://raw.githubusercontent.com/PowerShell/PSReadLine/master/PSReadLine/SamplePSReadLineProfile.ps1
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PSReadLineOption -PredictionViewStyle ListView
#Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
#Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -EditMode Windows

# This example will replace any aliases on the command line with the resolved commands.
Set-PSReadLineKeyHandler -Key "Alt+%" `
                         -BriefDescription ExpandAliases `
                         -LongDescription "Replace all aliases with the full command" `
                         -ScriptBlock {
    param($key, $arg)

    $ast = $null
    $tokens = $null
    $errors = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$ast, [ref]$tokens, [ref]$errors, [ref]$cursor)

    $startAdjustment = 0
    foreach ($token in $tokens)
    {
        if ($token.TokenFlags -band [TokenFlags]::CommandName)
        {
            $alias = $ExecutionContext.InvokeCommand.GetCommand($token.Extent.Text, 'Alias')
            if ($alias -ne $null)
            {
                $resolvedCommand = $alias.ResolvedCommandName
                if ($resolvedCommand -ne $null)
                {
                    $extent = $token.Extent
                    $length = $extent.EndOffset - $extent.StartOffset
                    [Microsoft.PowerShell.PSConsoleReadLine]::Replace(
                        $extent.StartOffset + $startAdjustment,
                        $length,
                        $resolvedCommand)

                    # Our copy of the tokens won't have been updated, so we need to
                    # adjust by the difference in length
                    $startAdjustment += ($resolvedCommand.Length - $length)
                }
            }
        }
    }
}



# Store previous command's output in $__
$PSDefaultParameterValues['Out-Default:OutVariable'] = '__'



# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
