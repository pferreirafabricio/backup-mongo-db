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

<# ZIP #>
# zip backup method for mongodbtools version 3.1 or lower

# $zippedFileDestinationPath = "$backupPath\$directoryName.zip";
# mongodump -h "$mongoDbHost" -d "$databaseName" -o "$directoryPath"

<# gzip #>
# gzip & archive for mongodbtools version 3.2 or above

$archiveFileDestinationPath = "$backupPath\$directoryName.gz";
mongodump --gzip -h "$mongoDbHost" -d "$databaseName" --archive="$archiveFileDestinationPath"


Write-Host "Creating the backup for $databaseName..."

$watch.Stop();
Write-Host "MongoDB backup completed in "$watch.Elapsed.ToString()

# ATTENTION ⚠: UnComment Lines Below If You Wish To Use ZIP Method
# Zip BackUp Folder (Powershell Built-in Command | Alternate Way)

# Write-Host "Zipping the folder backup folder..."
# Compress-Archive -Path "$directoryPath" -DestinationPath $zippedFileDestinationPath

# Delete the uncompressed backup folter created 

# Write-Host "Delete backup's folder"
# Remove-Item "$directoryPath" -Recurse


#endregion
