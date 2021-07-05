$reg_keys = "GXW2HelpFX", "SWnDN-GPPW2", "SWnDN-PMCNF"
$reg_val = (Get-Date).ToString("M-d-yyyy")

foreach ( $k in $reg_keys ) {
	reg add `
		"HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\MITSUBISHI\$k\CurrentVersion" `
		/v "InstallDate" `
		/t REG_SZ `
		/d "$reg_val" `
		/f
}

pause
