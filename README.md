# Fix-WSLStartup

## Values for the Start Registry Entry

Value | Start Type | Value Descriptions for Start Entries
--- | --- | ---
0 | Boot | Specifies a driver that is loaded (but not started) by the boot loader. If no errors occur, the driver is started during kernel initialization prior to any non-boot drivers being loaded.
1 | System | Specifies a driver that loads and starts during kernel initialization after drivers with a Start value of 0 have been started.
2 | Auto Load | Specifies a driver or service that is initialized at system startup by Session Manager (Smss.exe) or the Services Controller (Services.exe).
3 | Load on Demand | Specifies a driver or service that the Service Control Manager (SCM) will start only on demand. These drivers have to be started manually by calling a Win32 SCM application programming interface (API), such as the Services snap-in.
4 | Disable | Specifies a disabled (not started) driver or service.
5 | Delayed Start | Specifies that less-critical services will start shortly after startup to allow the operating system to be responsive to the user sooner. This start type was first introduced in Windows Vista.

## Notes to fix WSL

In my case I had to change the following registry key from 3 to 2: `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LxssManager Start 2`

Some of the symtoms I was seeing was `wslregisterdistribution failed with error: 0x80004005` When Kali tried to load

I tried to `get-service LxssManager`, I received an error.

I tried `sc query LxssManager` and received a message saying it wasn't installed

I looked at the GUI LxssManager and everything was greyed out.

Rebooted, and ended up with the same results.

Then I found this [answers.microsoft.com](https://answers.microsoft.com/en-us/windows/forum/windows_10-windows_store/wslregisterdistribution-failed-with-error/dd28f58e-869a-4a33-8b7f-95695371cb0d) site that had the resolution.

Based on that write-up, I created a [PowerShell Function](./Set-WSLStart) to change the start type of the LxssManager via a registry key change.
