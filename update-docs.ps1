<#
Inital setup:

Install-Module platyps -Scope CurrentUser -Force
Import-Module .\PSUniFi\PSUniFi.psd1
New-MarkdownHelp -Module PSUniFi -OutputFolder .\docs

#>


Import-Module .\PSUniFi\PSUniFi.psd1
New-MarkdownHelp -Module PSUniFi -OutputFolder .\docs -Force
Update-MarkdownHelp .\docs
#remove it, so that this can be re-run correctly in the same PowerShell session/window
Remove-Module PSUniFi