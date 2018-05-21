Set-StrictMode -Version Latest          # enable latest version of strict mode
$script:ErrorActionPreference = "Stop"  # stop script execution if an error occurs

$reg_key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
$reg_val = "DisableLockWorkstation"

$val = (Get-ItemProperty -Path $reg_key -Name $reg_val).$reg_val

if ($val -eq 0) {
    echo "Disabling Win-L key combination; registry set to 1."
    Set-ItemProperty -Path $reg_key -Name $reg_val -Value 1
} else {
    echo "Enabling Win-L key combination; registry set to 0."
    Set-ItemProperty -Path $reg_key -Name $reg_val -Value 0
}
