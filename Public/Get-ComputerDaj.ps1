function Get-ComputerDaj{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [string]$Server = $env:USERDNSDOMAIN,
        [switch]$HideMembers
        )

    $userPropertiesList = @(
        'CN'
        'Description'
        'DisplayName'
        'DistinguishedName'
        'SID'
        'DNSHostName'
        'Enabled'
        'IPv4Address'
        'ManagedBy'
        'WhenChanged'
        'WhenCreated')

    #List of displayed group parameters
    $groupPropertiesList = @(
        'Name'
        'Description'
    )

    $scriptUser = Get-ADComputer -Server $Server -Properties * -Identity $Name

    Select-Object -InputObject $ScriptUser -Property $userPropertiesList

    if ($HideGroups -eq $false){
        $scriptMemberOf = Select-Object -InputObject $scriptUser -ExpandProperty MemberOf 
        $scriptMemberOf | Get-ADGroup -Server $Server -Properties $groupPropertiesList | Select-Object $groupPropertiesList |Format-Table
    }
}

