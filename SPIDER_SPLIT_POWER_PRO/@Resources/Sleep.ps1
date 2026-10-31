# Only calls the built-in Windows power-state API. No network or downloads.
Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;
public static class SpiderSplitSleep
{
    [DllImport("powrprof.dll", SetLastError=true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool SetSuspendState([MarshalAs(UnmanagedType.Bool)] bool Hibernate, [MarshalAs(UnmanagedType.Bool)] bool ForceCritical, [MarshalAs(UnmanagedType.Bool)] bool DisableWakeEvent);
}
'@
[void][SpiderSplitSleep]::SetSuspendState($false, $false, $false)
