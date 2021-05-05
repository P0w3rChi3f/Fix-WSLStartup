
function Set-WSLAutoStart {
    
    $WSL = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\LxssManager

    if ($WSL.Start -ne 2) {
        Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\LxssManager -Name 'Start' -Value 2
        Write-Host "Changing LxssManager to AutoStart"  
    }  
    else {
    Write-Host "LxssManager is already set to AutoStart"
    }
}

Set-WSLAutoStart

