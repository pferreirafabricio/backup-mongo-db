$scriptToExecutePath = "C:\Path\To\dump-script.ps1";
$taskName = "MongoDB Backup"
$taskDescription = "Make a dump of a MongoDB database"

$action = New-ScheduledTaskAction `
  -Execute 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe' `
  -Argument "-NoProfile -NoLogo -NonInteractive -ExecutionPolicy Bypass -File $scriptToExecutePath"
  
$trigger = New-ScheduledTaskTrigger -Daily -At 1am
  
$taskSettings = New-ScheduledTaskSettingsSet -Compatibility Win8

Register-ScheduledTask `
  -TaskName $taskName `
  -Action $action `
  -Trigger $trigger `
  -Settings $taskSettings `
  -Description $taskDescription
