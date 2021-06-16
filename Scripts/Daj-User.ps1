param(
    [string]$accname = (Read-Host "Type user name"),
    [string]$sever = "localhost" #Default AD Server
    )
    
#List of displayed account parameters
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

#List of displayed group parameters whitch account is member of
$groupPropertiesList = @'
Name
Description
'@ -split "`r`n"


$scriptUser = Get-ADUser -Server $sever -Properties * -Identity $accname


Select-Object -InputObject $ScriptUser -Property $userPropertiesList



$scriptMemberOf = Select-Object -InputObject $scriptUser -ExpandProperty MemberOf 

$scriptMemberOf | Get-ADGroup -Server $sever -Properties $groupPropertiesList | Select-Object $groupPropertiesList |Format-Table
