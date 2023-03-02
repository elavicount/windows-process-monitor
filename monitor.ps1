#Requires -Version 5.0

<#
    .Description
    Check if the specified process is running
#>
param
(
  $ProcessName = 'Explorer',
  $Type = 'POPUP'
)

function Process-Monitor {
	param(
		[Parameter()]
		[string]$ProcessName,

		[Parameter()]
		[string]$Type
	)

	try {
		for (;;)
		{
			#Check if the process is running every 5 minutes
			$process = Get-Process $ProcessName -ErrorAction 'Stop' | select -expand ProcessName
			Write-Output "Last execution: $(Get-Date)"
			Start-Sleep -s 300
		}
	} catch {
		Show-Custom-Message 'ERROR' $ProcessName $Type
		break
	}
}

function Show-Custom-Message {
	param(
		[Parameter(Mandatory)]
		[ValidateSet('NONE','INFO','WARNING','ERROR')]
		[string]$Title,

		[Parameter(Mandatory)]
		[string]$ProcessName,

		[Parameter(Mandatory)]
		[ValidateSet('BALLON','POPUP')]
		[string]$Type
	)
	if ($Type -eq 'BALLON') {
		[reflection.assembly]::loadwithpartialname('System.Windows.Forms')
		[reflection.assembly]::loadwithpartialname('System.Drawing')
		$notify = new-object system.windows.forms.notifyicon
		$notify.icon = [System.Drawing.SystemIcons]::Information
		$notify.visible = $true
		$notify.showballoontip(30,"$Title", "$ProcessName has stopped", [system.windows.forms.tooltipicon]::None)
	} else {
		[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
		[System.Windows.Forms.MessageBox]::Show("$ProcessName has stopped", "$Title")
	}
}

Process-Monitor $ProcessName $Type