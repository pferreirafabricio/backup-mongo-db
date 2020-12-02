<#===  Set the MongoDB access variables  ===#>
$databaseName = "databaseName"
# $username = ""
# $password = ""
$mongoDbHost = "localhost:27017"

<#===  Set the folder's location and name  ===#>
$backupPath = "C:\Path\To\Back\Folder"
$currentDate = get-date -format yyyyMMddHHmm
$directoryName = "$databaseName-$currentDate"
$directoryPath = Join-Path $backupPath $directoryName

<#===  Zip  ===#>
$zippedFileDestinationPath = "$backupPath\$directoryName.zip";

<#===  Backup process  ===#>
$Watch = New-Object System.Diagnostics.StopWatch
$Watch.Start()
Write-Host "Backing up the Database: '$databaseName' to local directory: $backupPath."

# Use this command when the database require authorization
# mongodump -h $mongoDbHost -d $databaseName -u $username -p $password -o "$directoryPath"

mongodump -h $mongoDbHost -d $databaseName -o "$directoryPath"

Write-Host "Creating the backup for $databaseName..."

$Watch.Stop();
Write-Host "MongoDB backup completed in "$Watch.Elapsed.ToString()

# Zip sfolder
Write-Host "Zipping the folder backup folder..."
Compress-Archive -Path "$directoryPath" -DestinationPath $zippedFileDestinationPath

# Delete the backup folter created
Write-Host "Delete backup's folder"
Remove-Item "$directoryPath" -Recurse