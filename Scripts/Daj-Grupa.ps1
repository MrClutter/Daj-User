param(
    [string]$group = (Read-Host "Type group name"),
    [string]$sever = "localhost" #Default AD Server
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


$scriptGrupa = Get-ADgroup -Server $sever -Properties * -Identity $group




Select-Object -InputObject $scriptGrupa -Property $groupPropertiesList


if($scriptGrupa.Members.Count -le 30){
    $scriptMembers = Select-Object -InputObject $scriptGrupa -ExpandProperty Members 
    $scriptMembers | Get-ADObject -Server $sever -Properties $userPropertiesList | Select-Object $userPropertiesList |Format-Table
}elseif($scriptGrupa.Members.Count -le 150){
    $scriptGrupa.Members
}else{
    Write-Host "User count in group:" $scriptGrupa.Members.Count 
}

