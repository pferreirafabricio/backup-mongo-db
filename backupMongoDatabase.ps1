#region Variables

<# Set the MongoDB access variables #>
$databaseName = "databaseName"
# $username = ""
# $password = ""
# $authenticationDatabase = ""
$mongoDbHost = "localhost:27017"
# $uri = ""

<# Set the folder's location and name #>
$backupPath = "C:\Path\To\Back\Folder"
$currentDate = get-date -format yyyyMMddHHmm
$directoryName = "$databaseName-$currentDate"
$directoryPath = Join-Path $backupPath $directoryName

<# Zip #>
$zippedFileDestinationPath = "$backupPath\$directoryName.zip";

#endregion

#region Backup Process
$watch = New-Object System.Diagnostics.StopWatch
$watch.Start()
Write-Host "Backing up the Database: '$databaseName' to local directory: $backupPath."

# Use this command when the database require authorization
<# mongodump -h "$mongoDbHost" `
   -d "$databaseName" `
   -u "$username" `
   -p "$password" `
   --authenticationDatabase "$authenticationDatabase" `
   -o "$directoryPath"
#>

# Or use this command (Without specifying the -d flag the command will backup all databases in the host)
# mongodump --uri "$uri" -o "$directoryPath"

# ATTENTION ⚠: Use the absolute path if you haven't added mongo to your System Path
# Ex: C:\mongodb\bin\mongodump.exe -h $mongoDbHost -d $databaseName -o "$directoryPath"
# Version 3.2 introduced gzip & archive
mongodump --gzip -h "$mongoDbHost" -d "$databaseName" -o "$directoryPath"

Write-Host "Creating the backup for $databaseName..."

$watch.Stop();
Write-Host "MongoDB backup completed in "$watch.Elapsed.ToString()

#endregion
