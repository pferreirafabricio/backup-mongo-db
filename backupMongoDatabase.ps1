#region Variables

<# Set the MongoDB access variables #>
$databaseName = "databaseName"
# $username = ""
# $password = ""
# $authenticationDatabase = ""
$mongoDbHost = "localhost:27017"

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

# ATTENTION ⚠: Use the absolute path if you haven't added mongo to your System Path
# Ex: C:\mongodb\bin\mongodump.exe -h $mongoDbHost -d $databaseName -o "$directoryPath"
mongodump -h "$mongoDbHost" -d "$databaseName" -o "$directoryPath"

Write-Host "Creating the backup for $databaseName..."

$watch.Stop();
Write-Host "MongoDB backup completed in "$watch.Elapsed.ToString()

# Zip sfolder
Write-Host "Zipping the folder backup folder..."
Compress-Archive -Path "$directoryPath" -DestinationPath $zippedFileDestinationPath

# Delete the backup folter created
Write-Host "Delete backup's folder"
Remove-Item "$directoryPath" -Recurse

#endregion
