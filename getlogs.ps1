$logs = Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4625} | Select-Object -Property *

$iptable = @()

foreach($log in $logs){

#$log.TimeCreated
#$log.Properties[5]   # Username
#$log.Properties[13] # Source Workstation Name (this can be spoofed)
#$log.Message.split(':') -split("`t") | ? { $_ -match '\d+\.\d+\.\d+.\d+'} | % {$_ -replace ("`n","")} #IP Address
$ip = $log.Message.split(':') -split("`t") | ? { $_ -match '\d+\.\d+\.\d+.\d+'} | % {$_ -replace ("`n","")} #IP Address
$iptable += $ip

}
$iptable | gm
$iptable | Group-Object | Sort-Object -Descending -Property Count | Format-Table -Wrap

$array = $iptable | Group-Object | Sort-Object -Descending -Property Count

$array | Select-Object -ExpandProperty Name
