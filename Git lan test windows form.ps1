Add-Type -Assemblyname System.Windows.Forms
#главная форма
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(400,250)


$NetAdapterNames=Get-NetAdapter -Name *  -Physical
$localip = foreach ($NetAdapterName in $NetAdapterNames)
{
  Get-NetIPConfiguration -InterfaceAlias $NetAdapterName.name | Select-Object IPv4Address 
}
$localipSTR = $localip | Out-String



$wanip=Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content)

$wshell = New-Object -ComObject Wscript.Shell

$label = New-Object System.Windows.Forms.Label
$label.Size = New-Object System.Drawing.Size(100,40)
$label.Text = "Внешний адрес $($wanip.ip)"
$label.Location = New-Object System.Drawing.Point 20,10

$label2 = New-Object System.Windows.Forms.Label
$label2.Size = New-Object System.Drawing.Size(100,80)
$label2.Text = "локальный", $localipSTR.Trim()
$label2.Location = New-Object System.Drawing.Point 150,10

$label3 = New-Object System.Windows.Forms.Label
$label3.Size = New-Object System.Drawing.Size(280,20)
if ((Test-Connection -Count 1 -computer  <addr0> -quiet) -eq $True) 
{
		$label3.Text = "<addr0>   ДОСТУПЕН"
}
	Else 
    {
		$label3.Text = "<addr0>   НЕДОСТУПЕН!"
	}
$label3.Location = New-Object System.Drawing.Point 20,100

$label4 = New-Object System.Windows.Forms.Label
$label4.Size = New-Object System.Drawing.Size(280,20)
if ((Test-Connection -Count 1 -computer <addr1> -quiet) -eq $True) 
{
		$label4.Text = " <addr1>  ДОСТУПЕН"
}
	Else 
    {
		$label4.Text = " <addr1>  НЕДОСТУПЕН!"
	}
$label4.Location = New-Object System.Drawing.Point 20,120

$label5 = New-Object System.Windows.Forms.Label
$label5.Size = New-Object System.Drawing.Size(280,20)
if ((Test-Connection -Count 1 -computer <addr3>  -quiet) -eq $True) 
{
		$label5.Text = " <addr3> ДОСТУПЕН"
}
	Else 
    {
		$label5.Text = " <addr3> НЕДОСТУПЕН!"
	}
$label5.Location = New-Object System.Drawing.Point 20,140




$form.Controls.Add($label)
$form.Controls.Add($label2)
$form.Controls.Add($label3)
$form.Controls.Add($label4)
$form.Controls.Add($label5)
$form.ShowDialog()