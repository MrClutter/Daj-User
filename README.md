# PowersShell Daj command

Include following lines in $Home\Documents\WindowsPowerShell\profile.ps

``` ps1
set-alias -Name "Daj-User" -Value $HOME\Documents\WindowsPowerShell\Scripts\Daj-User.ps1
set-alias -Name "Da" -Value $HOME\Documents\WindowsPowerShell\Scripts\Da.ps1
set-alias -Name "Daj-Grupa" -Value $HOME\Documents\WindowsPowerShell\Scripts\Daj-Grupa.ps1
set-alias -Name "Daj" -Value "Daj-User"
```

Depending on environment Script might work or not, probably instead of using get-adgroup and get-aduser there should be used get-adobject in some parts whitch would make entire script more flexable.
But it works in enviroment where it was tested so yea...

### Todo
Merge files into one
