# default encoding to utf-8
[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[System.Console]::InputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# start in c:\
cd c:\

# disable the bell completely
# https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption
Set-PSReadlineOption -BellStyle None

# use vi mode
Set-PSReadlineOption -EditMode vi

# custom prompt
function prompt {
    Write-Host (" PS >") -NoNewLine
    return " "
}
