$targets = Import-Csv ..\AllHosts.csv |
    Where-Object {$_.os -eq "Win10"} |
        Select-Object -ExpandProperty ip

$current = Invoke-Command -ComputerName $targets -Credential $creds -FilePath ..\01_Reference_Scripts\services.ps1

$current | Sort-Object -Property pscomputername, ServiceName -Unique |
    Group-Object ServiceName |
        Where-Object {$_.count -le 2} |
            Select-Object -ExpandProperty Group

# My Version
$creds = Get-Credential
$targets = Import-Csv .\AllHost.csv
$targets = Get-Content .\AllHost.txt

$current = Invoke-Command -ComputerName $targets -Credential $creds .\services.ps1

$lfaservices = $current | Sort-Object -Property pscomputername, ServiceName -Unique |
    Group-Object ServiceName | Where-Object {$_.count -le 2} | Select-Object -ExpandProperty Group