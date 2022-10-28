# Rotation Day Directory

| Scripts | Location |
| --- | --- |
| make_todays_dir_on_desktop.bat | shell:startup |
| move_workfolder_to_pastwork.bat | shell:startup |
| move_pastworkfolder.ps1 | ~/scripts |
| - | ~/pastwork |

## make_todays_dir_on_desktop.bat

```bat
if not "%1" == "1" (
    start /min cmd /c call "%~f0" 1
    exit
)

set year=%date:~0,4%
set month=%date:~5,2%
set day=%date:~8,2%

mkdir %homepath%¥Desktop¥%year%%month%%day%_work
```

## move_workfolder_to_pastwork.bat

```bat
if not "%1" == "1" (
    start /min cmd /c call "%~f0" 1
    exit
)

powershell -ExecutionPolicy Bypass "%homepath%¥scripts¥move_pastworkfolder.ps1"
```

## move_pastworkfolder.ps1

```powershell
sleep 10

$yswork = "$HOME" + "¥Desktop¥"
$ysold = "$HOME" + "¥pastwork¥"

for ($i=0; $i -le 10; $i++){
    $yshiduke=[DateTime]::Today.AddDays(-$i).ToString('yyyyMMdd') + "_work"
    if ( Test-Path $yswork$yshiduke ) {
        mv $yswork$yshiduke $ysold$yshiduke
    }
}

##### delete pastworks
$DAYS=14
Get-ChildItem $ysold | Where-Object {$_.Mode -eq "d-----" -and ($_.LastWriteTime -lt (Get-Date).AddDays(-1 * $DAYS))} | Remove-Item -Recurse -force
```
