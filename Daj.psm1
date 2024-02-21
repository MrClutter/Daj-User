$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )

Foreach($import in @($Public))
{
    Try
    {
        . $import.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}


Set-Alias -Name "Daj-User"      -Value "Get-UserDaj"
Set-Alias -Name "Daj"           -Value "Get-UserDaj"
Set-Alias -Name "Da"            -Value "Get-UserDa"

Set-Alias -Name "Daj-Group"     -Value "Get-GroupDaj"
Set-Alias -Name "Dag"           -Value "Get-GroupDaj"

Set-Alias -Name "Daj-Computer"  -Value "Get-ComputerDaj"
Set-Alias -Name "Dac"           -Value "Get-ComputerDaj"


Export-ModuleMember -Function $Public.Basename
Export-ModuleMember -Alias * -Function *
