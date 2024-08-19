# Functions
# =========

function Convert-Paths {
    <#
    .SYNOPSIS
    Converts paths to be compatible with WSL.
    .PARAMETER paths
    Paths to convert.
    .EXAMPLE
    Convert-Paths "C:\example.txt" "C:\example2.txt"
    #>
    param (
        [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)][string[]]$paths
    )
    $convertedPaths = @()
    foreach ($path in $paths) {
        $convertedPath = $path -replace '\\', '/'
        if ($convertedPath -match '^([A-Za-z]):[\\/].*$') {
            $convertedPath = $convertedPath -replace '^([A-Za-z]):[\\/]', { "/mnt/$($matches[1].ToLower())/" }
        }
        $convertedPaths += $convertedPath
    }
    $convertedPaths
}

function Invoke-LS {
    <#
    .SYNOPSIS
    Invokes the 'ls' command in WSL with patched arguments.
    .PARAMETER args
    Arguments to pass to the 'ls' command.
    .EXAMPLE
    Invoke-LS -args "-l"
    #>
    # $patchedArgs = @()
    # foreach ($arg in $args) {
    #     $patchedArg = $arg -replace '\\', '/'
    #     if ($patchedArg -match '^([A-Za-z]):[\\/].*$') {
    #         $patchedArg = $patchedArg -replace '^([A-Za-z]):[\\/]', { "/mnt/$($matches[1].ToLower())/" }
    #     }
    #     $patchedArgs += $patchedArg
    # }
    $patchedArgs = Convert-Paths $args
    wsl.exe ls $patchedArgs
}

function Set-CreationDate {
    <#
    .SYNOPSIS
    Sets the creation date of a specified file.
    .PARAMETER FilePath
    The path to the file.
    .PARAMETER CreationDate
    The new creation date in the format "yyyy-mm-dd".
    .EXAMPLE
    Set-CreationDate -FilePath "C:\example.txt" -CreationDate "2023-01-01"
    #>
    param (
        [Parameter(Mandatory = $true)][string]$FilePath,
        [Parameter(Mandatory = $true)][datetime]$CreationDate
    )
    (Get-Item -Path $FilePath).CreationTime = $(Get-Date "$CreationDate")
}

# Aliases
# =======

if (Get-Alias -Name ls -ErrorAction SilentlyContinue) { Remove-Item Alias:ls }
function ls { Invoke-LS --color=yes  @args }
function la { Invoke-LS --color=yes -hal  @args }

# Set Prompt

$colorPrompt = $False
function prompt {
    $currentDir = (Get-Location).Path
    $homeDir = [System.Environment]::GetFolderPath('UserProfile')
    $currentDir = $currentDir -replace [regex]::Escape($homeDir), '~'
    if ($colorPrompt) {
        $blue = "`e[34m"
        $reset = "`e[0m"
        "$blue$currentDir$reset> "
    } else {
        "$currentDir> "
    }
}

# Completion Settings
Set-PSReadLineOption -PredictionViewStyle ListView
