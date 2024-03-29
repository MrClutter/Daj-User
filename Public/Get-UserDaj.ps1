function Get-UserDaj{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [string]$Server = $env:USERDNSDOMAIN,
        [switch]$HideGroups
        )


    $userPropertiesList = @(
        'Name'
        'comment'
        'Description'
        'DisplayName'
        'DistinguishedName'
        'SID'
        'EmailAddress'
        'OfficePhone'
        'MobilePhone'
        'Enabled'
        'PasswordExpired'
        'LockedOut'
        'PasswordNevrExpires'
        'lockoutTime'
        'LastLogonDate'
        'LastBadPasswordAttempt'
        'AccountLockoutTime'
        'whenChanged'
        'whenCreated'
        'PasswordLastSet'
        'badPwdCount')

    #List of displayed group parameters
    $groupPropertiesList = @(
        'Name'
        'Description'
    )

    $scriptUser = Get-ADUser -Server $Server -Properties * -Identity $Name

    Select-Object -InputObject $ScriptUser -Property $userPropertiesList

    if ($HideGroups -eq $false){
        $scriptMemberOf = Select-Object -InputObject $scriptUser -ExpandProperty MemberOf 

        $scriptMemberOf | Get-ADGroup -Server $Server -Properties $groupPropertiesList | Select-Object $groupPropertiesList |Format-Table
    }
}

