Function Get-UserDa { 
    param(
        [Parameter(Mandatory=$true)]
        [string]$name,
        [strine]$server = $env:USERDNSDOMAIN
    )
    Get-UserDaj -HideGroups -name $name -server $server 
}