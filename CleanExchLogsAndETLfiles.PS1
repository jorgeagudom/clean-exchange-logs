# Este Script lo ha diseñado "Edward van Biljon", muchas grcias Edward!!!
#----------------------------------------------------------------------

Set-Executionpolicy RemoteSigned

$days=0 #poner los dias que queremos dejar de Logs (por defecto, elimna todos)
$IISLogPath="C:\inetpub\logs\LogFiles\"
$ExchangeLoggingPath="C:\Program Files\Microsoft\Exchange Server\V15\Logging\"
$ETLLoggingPath="C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\ETLTraces\"
$ETLLoggingPath2="C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\Logs"
Function CleanLogfiles($TargetFolder)
{
  write-host -debug -ForegroundColor Yellow -BackgroundColor Cyan $TargetFolder

    if (Test-Path $TargetFolder) {
        $Now = Get-Date
        $LastWrite = $Now.AddDays(-$days)
    #   $Files = Get-ChildItem $TargetFolder -Include *.log,*.blg, *.etl -Recurse | Where {$_.LastWriteTime -le "$LastWrite"}
        $Files = Get-ChildItem "C:\Program Files\Microsoft\Exchange Server\V15\Logging\"  -Recurse | Where-Object {$_.Name -like "*.log" -or $_.Name -like "*.blg" -or $_.Name -like "*.etl"}  | where {$_.lastWriteTime -le "$lastwrite"} | Select-Object FullName  
    # --> entiendo que en Get-Childitem habría que poner $TargetFolder    
        foreach ($File in $Files)
            {
               $FullFileName = $File.FullName  
               Write-Host "Deleting file $FullFileName" -ForegroundColor "yellow"; 
                Remove-Item $FullFileName -ErrorAction SilentlyContinue | out-null
            }
       }
Else {
    Write-Host "The folder $TargetFolder doesn't exist! Check the folder path!" -ForegroundColor "red"
    }
}
CleanLogfiles($IISLogPath)
CleanLogfiles($ExchangeLoggingPath)
CleanLogfiles($ETLLoggingPath)
CleanLogfiles($ETLLoggingPath2)