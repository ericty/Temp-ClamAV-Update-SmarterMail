Write-Host "Turn off ClamAV"
$URI = "https://server.domain.com/Services/svcVirusAdmin.asmx"
$result = (Invoke-WebRequest $URI -infile "C:\temp\TurnClamOff.xml" -ContentType "text/xml" -Method POST)
Write-Host $result.content
Write-Host "Allow FreshClam to update"
(Get-Content C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\etc\freshclam.conf) -replace 'Example', '#Example' | Set-Content C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\etc\freshclam.conf
Write-Host "Rename ClamSup Batch file"
Rename-Item C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\ClamSup\ClamSup.bat.old C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\ClamSup\ClamSup.bat
Write-Host "Execute ClamSup"
Start-Process C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\ClamSup\ClamSup.bat -NoNewWindow -Wait
Write-Host "Run FreshClam"
Start-Process C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\bin64\freshclam.exe --config-file="C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\etc\freshclam.conf" -NoNewWindow -Wait
Write-Host "Rename ClamSup Batch, so it won't execute by accident"
Rename-Item C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\ClamSup\ClamSup.bat C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\ClamSup\ClamSup.bat.old
Write-Host "Update Freshclam Config to an Example"
(Get-Content C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\etc\freshclam.conf) -replace '#Example', 'Example' | Set-Content C:\PROGRA~2\SMARTE~1\SMARTE~1\Service\Clam\etc\freshclam.conf
Write-Host "Waiting 25 seconds for ClamDB to reload"
Start-Sleep -s 25
Write-Host "Turn on ClamAV"
$result = (Invoke-WebRequest $URI -infile "C:\temp\TurnClamOn.xml" -ContentType "text/xml" -Method POST)
Write-Host $result.content