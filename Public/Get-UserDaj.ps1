function Get-UserDaj{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [string]$Sever = $env:USERDNSDOMAIN,
        [bool]$HideGroups = $false
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

    $scriptUser = Get-ADUser -Server $Sever -Properties * -Identity $Name

    Select-Object -InputObject $ScriptUser -Property $userPropertiesList

    if ($HideGroups -eq $false){
        $scriptMemberOf = Select-Object -InputObject $scriptUser -ExpandProperty MemberOf 

        $scriptMemberOf | Get-ADGroup -Server $sever -Properties $groupPropertiesList | Select-Object $groupPropertiesList |Format-Table
    }
}

Function Get-UserDa { Get-UserDaj $args -HideGroups }
