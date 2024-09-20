$LogFile= "$($env:USERPROFILE)\Desktop\NET_TEST.txt"
[System.Windows.Forms.MessageBox]::Show("Тестирование запущено","Запись теста в фаил")
#Локальный ip

$NetAdapterNames=Get-NetAdapter -Name *  -Physical
$localip = foreach ($NetAdapterName in $NetAdapterNames)
{
  Get-NetIPConfiguration -InterfaceAlias $NetAdapterName.name | Select-Object IPv4Address 
}

#Внешний ip

$wanip=Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content)

#Проверка 8.8.8.8, <addr1>, <addr2> 

$testconnection=Test-Connection 8.8.8.8, <addr1>, <addr2>

#Маршрут до <addr3>

$trace= Test-NetConnection -ComputerName <addr3> -TraceRoute

#Вывод в файл на рабочий стол
Remove-Item -Path $LogFile -Force
"Внешний адрес $($wanip.ip)" | Format-Table -AutoSize   | Out-File $LogFile -Append
"Локальный адрес" | Out-File $LogFile -Append
$localip | Format-Table -AutoSize   | Out-File $LogFile -Append
"Проверка адресов" | Out-File $LogFile -Append
$testconnection | Format-Table -AutoSize   | Out-File $LogFile -Append
"Проверка пути до <addr3>" | Out-File $LogFile -Append
$trace | Out-File $LogFile -Append

[System.Windows.Forms.MessageBox]::Show("Выполнено","Запись теста в фаил")