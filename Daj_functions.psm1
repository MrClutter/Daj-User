function Daj-User{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [string]$Sever = "$env:USERDNSDOMAIN",
        [switch]$HideGroups
        )

    #List of displayed user parameters
    $userPropertiesList = @'
Name
comment
Description
DisplayName
DistinguishedName
SID
EmailAddress
OfficePhone
MobilePhone
Enabled
PasswordExpired
LockedOut
PasswordNevrExpires
lockoutTime
LastLogonDate
LastBadPasswordAttempt
AccountLockoutTime
whenChanged
whenCreated
PasswordLastSet
badPwdCount
'@ -split "`r`n"

    #List of displayed group parameters
    $groupPropertiesList = @'
Name
Description
'@ -split "`r`n"


    $scriptUser = Get-ADUser -Server $Sever -Properties * -Identity $Name


    Select-Object -InputObject $ScriptUser -Property $userPropertiesList

    if ($HideGroups -eq $false){
        $scriptMemberOf = Select-Object -InputObject $scriptUser -ExpandProperty MemberOf 

        $scriptMemberOf | Get-ADGroup -Server $sever -Properties $groupPropertiesList | Select-Object $groupPropertiesList |Format-Table
    }
}



function Daj-Group{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name = (Read-Host "Group name: "),
        [string]$Server = "$env:USERDNSDOMAIN",
        [switch]$HideMembers
        )


    #List of displayed group parameters
    $groupPropertiesList = @'
DistinguishedName
ObjectCategory
Name
SID
Created
Description
MemberOf
Members
'@ -split "`r`n"

    #List of displayed account parameters
    $userPropertiesList = @'
Name
Description
comment
'@ -split "`r`n"


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


function Da {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name = (Read-Host "Group name: "),
        [string]$Server = "$env:USERDNSDOMAIN"
        )
    Daj-User -HideGroups -Name $Name -Sever $Server
}


Set-Alias -Name "Daj" -Value "Daj-User"
