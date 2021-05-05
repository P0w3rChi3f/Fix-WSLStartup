
function Set-WSLStartType {

    [CmdletBinding(SupportsShouldProcess = $True)]
    param(
        # This is the value of the registry key.
        [Parameter(Mandatory = $true)]
        [ValidateRange(0,5)]
        [Int32]
        $StartType
    )
    BEGIN {}
    process{
        $WSL = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\LxssManager

        switch ($StartType) {
            0 { $message = Write-Host 'Changing LxssManager to Load At Boot' }
            1 { $message = Write-Host 'Changing LxssManager to Start at Kernel Initialization' }
            2 { $message = Write-Host 'Changing LxssManager to AutoStart' }
            3 { $message = Write-Host 'Changing LxssManager to Start On Demand' }
            4 { $message = Write-Host 'Changing LxssManager to Disable' }
            5 { $message = Write-Host 'Changing LxssManager to Delayed Start' }
        }

        if ($WSL.Start -ne $StartType) {
            Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\LxssManager -Name 'Start' -Value $StartType
            $message 
        }

        else {
            Write-Host "No Change, The registry key is already set to $StartType"
        }
    }

    END {}  
}

