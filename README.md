# PowersShell Daj command

Include following lines in $Home\Documents\WindowsPowerShell\profile.ps

``` ps1
#Adds functions Daj-User, Daj-Group, Da and alias Daj
Import-Module $HOME\Documents\WindowsPowerShell\Daj_functions.ps1
```

Depending on environment Script might work or not, probably instead of using get-adgroup and get-aduser there should be used get-adobject in some parts whitch would make entire script more flexable.
But it works in enviroment where it was tested so yea...
