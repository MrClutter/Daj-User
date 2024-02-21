function Get-GroupDaj{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [string]$Server = $env:USERDNSDOMAIN,
        [bool]$HideMembers = $false
        )


    #List of displayed group parameters
    $groupPropertiesList = @(
        'DistinguishedName'
        'ObjectCategory'
        'Name'
        'SID'
        'Created'
        'Description'
        'MemberOf'
        'Members'
    )

    #List of displayed account parameters
    $userPropertiesList = @(
        'Name'
        'Description'
        'comment'
    )

    $scriptGrupa = Get-ADgroup -Server $Server -Properties * -Identity $Name

    Select-Object -InputObject $scriptGrupa -Property $groupPropertiesList

    if($HideMembers -eq $false){
        if($scriptGrupa.Members.Count -le 30){
            $scriptMembers = Select-Object -InputObject $scriptGrupa -ExpandProperty Members 
            $scriptMembers | Get-ADObject -Server $Server -Properties $userPropertiesList | Select-Object $userPropertiesList |Format-Table
        }elseif($scriptGrupa.Members.Count -le 150){
            $scriptGrupa.Members
        }else{
            Write-Host "Liczba uzytkownikow w grupie to:" $scriptGrupa.Members.Count 
        }
    }
}