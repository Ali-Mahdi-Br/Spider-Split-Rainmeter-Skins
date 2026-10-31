Option Explicit
Dim shell, choice, action, fso, folder, ps
Set shell = CreateObject("WScript.Shell")
If WScript.Arguments.Count < 1 Then WScript.Quit 0
action = LCase(WScript.Arguments.Item(0))
Select Case action
Case "power"
    choice = MsgBox("Shut down Windows? Save any open work first.", vbYesNo + vbQuestion + vbDefaultButton2, "Confirm shut down")
    If choice = vbYes Then shell.Run "shutdown.exe /s /t 0", 0, False
Case "restart"
    choice = MsgBox("Restart Windows? Save any open work first.", vbYesNo + vbQuestion + vbDefaultButton2, "Confirm restart")
    If choice = vbYes Then shell.Run "shutdown.exe /r /t 0", 0, False
Case "sleep"
    Set fso = CreateObject("Scripting.FileSystemObject")
    folder = fso.GetParentFolderName(WScript.ScriptFullName)
    ps = fso.BuildPath(folder, "Sleep.ps1")
    shell.Run "powershell.exe -NoProfile -NonInteractive -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & ps & """", 0, False
Case "lock"
    shell.Run "rundll32.exe user32.dll,LockWorkStation", 0, False
End Select
