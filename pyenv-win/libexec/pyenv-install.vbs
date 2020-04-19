Option Explicit

Sub Import(importFile)
    Dim fso, libFile
    On Error Resume Next
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set libFile = fso.OpenTextFile(fso.getParentFolderName(WScript.ScriptFullName) &"\"& importFile, 1)
    ExecuteGlobal libFile.ReadAll
    If Err.number <> 0 Then
        WScript.Echo "Error importing library """& importFile &"""("& Err.Number &"): "& Err.Description
        WScript.Quit 1
    End If
    libFile.Close
End Sub

Dim mirrorEnvPath
mirrorEnvPath = "%PYTHON_BUILD_MIRROR_URL%"
Dim mirror
mirror = objws.ExpandEnvironmentStrings(mirrorEnvPath)
If mirror = mirrorEnvPath then
    mirror = "https://www.python.org/ftp/python"
End If
WScript.echo ":: [Info] ::  Mirror: " & mirror

Dim listEnv
listEnv = Array(_
    Array("3.8.2-32bit", mirror&"/3.8.2/", "python-3.8.2.exe", "i386"),_
    Array("3.8.2", mirror&"/3.8.2/", "python-3.8.2-amd64.exe", "x64"),_
    Array("3.8.1-32bit", mirror&"/3.8.1/", "python-3.8.1.exe", "i386"),_
    Array("3.8.1", mirror&"/3.8.1/", "python-3.8.1-amd64.exe", "x64"),_
    Array("3.8.0-32bit", mirror&"/3.8.0/", "python-3.8.0.exe", "i386"),_
    Array("3.8.0", mirror&"/3.8.0/", "python-3.8.0-amd64.exe", "x64"),_
    Array("3.8.0rc1-32bit", mirror&"/3.8.0/", "python-3.8.0rc1.exe", "i386"),_
    Array("3.8.0rc1", mirror&"/3.8.0/", "python-3.8.0rc1-amd64.exe", "x64"),_
    Array("3.8.0b4-32bit", mirror&"/3.8.0/", "python-3.8.0b4.exe", "i386"),_
    Array("3.8.0b4", mirror&"/3.8.0/", "python-3.8.0b4-amd64.exe", "x64"),_
    Array("3.8.0b3-32bit", mirror&"/3.8.0/", "python-3.8.0b3.exe", "i386"),_
    Array("3.8.0b3", mirror&"/3.8.0/", "python-3.8.0b3-amd64.exe", "x64"),_
    Array("3.8.0b2-32bit", mirror&"/3.8.0/", "python-3.8.0b2.exe", "i386"),_
    Array("3.8.0b2", mirror&"/3.8.0/", "python-3.8.0b2-amd64.exe", "x64"),_
    Array("3.8.0b1-32bit", mirror&"/3.8.0/", "python-3.8.0b1.exe", "i386"),_
    Array("3.8.0b1", mirror&"/3.8.0/", "python-3.8.0b1-amd64.exe", "x64"),_
    Array("3.8.0a4-32bit", mirror&"/3.8.0/", "python-3.8.0a4.exe", "i386"),_
    Array("3.8.0a4", mirror&"/3.8.0/", "python-3.8.0a4-amd64.exe", "x64"),_
    Array("3.8.0a3-32bit", mirror&"/3.8.0/", "python-3.8.0a3.exe", "i386"),_
    Array("3.8.0a3", mirror&"/3.8.0/", "python-3.8.0a3-amd64.exe", "x64"),_
    Array("3.8.0a2-32bit", mirror&"/3.8.0/", "python-3.8.0a2.exe", "i386"),_
    Array("3.8.0a2", mirror&"/3.8.0/", "python-3.8.0a2-amd64.exe", "x64"),_
    Array("3.8.0a1-32bit", mirror&"/3.8.0/", "python-3.8.0a1.exe", "i386"),_
    Array("3.8.0a1", mirror&"/3.8.0/", "python-3.8.0a1-amd64.exe", "x64"),_
    Array("3.7.6-32bit", mirror&"/3.7.6/", "python-3.7.6.exe", "i386"),_
    Array("3.7.6", mirror&"/3.7.6/", "python-3.7.6-amd64.exe", "x64"),_
    Array("3.7.5-32bit", mirror&"/3.7.5/", "python-3.7.5.exe", "i386"),_
    Array("3.7.5", mirror&"/3.7.5/", "python-3.7.5-amd64.exe", "x64"),_
    Array("3.7.4-32bit", mirror&"/3.7.4/", "python-3.7.4.exe", "i386"),_
    Array("3.7.4", mirror&"/3.7.4/", "python-3.7.4-amd64.exe", "x64"),_
    Array("3.7.3-32bit", mirror&"/3.7.3/", "python-3.7.3.exe", "i386"),_
    Array("3.7.3", mirror&"/3.7.3/", "python-3.7.3-amd64.exe", "x64"),_
    Array("2.7.17-32bit", mirror&"/2.7.17/", "python-2.7.17.msi", "i386"),_
    Array("2.7.17", mirror&"/2.7.17/", "python-2.7.17.amd64.msi", "x64"),_
    Array("2.7.16-32bit", mirror&"/2.7.16/", "python-2.7.16.msi", "i386"),_
    Array("2.7.16", mirror&"/2.7.16/", "python-2.7.16.amd64.msi", "x64"),_
    Array("3.7.2-32bit", mirror&"/3.7.2/", "python-3.7.2.exe", "i386"),_
    Array("3.7.2", mirror&"/3.7.2/", "python-3.7.2-amd64.exe", "x64"),_
    Array("3.6.10-32bit", mirror&"/3.6.10/", "python-3.6.10.exe", "i386"),_
    Array("3.6.10", mirror&"/3.6.10/", "python-3.6.10-amd64.exe", "x64"),_
    Array("3.6.9-32bit", mirror&"/3.6.9/", "python-3.6.9.exe", "i386"),_
    Array("3.6.9", mirror&"/3.6.9/", "python-3.6.9-amd64.exe", "x64"),_
    Array("3.6.8-32bit", mirror&"/3.6.8/", "python-3.6.8.exe", "i386"),_
    Array("3.6.8", mirror&"/3.6.8/", "python-3.6.8-amd64.exe", "x64"),_
    Array("3.7.2rc1-32bit", mirror&"/3.7.2/", "python-3.7.2rc1.exe", "i386"),_
    Array("3.7.2rc1", mirror&"/3.7.2/", "python-3.7.2rc1-amd64.exe", "x64"),_
    Array("3.6.8rc1-32bit", mirror&"/3.6.8/", "python-3.6.8rc1.exe", "i386"),_
    Array("3.6.8rc1", mirror&"/3.6.8/", "python-3.6.8rc1-amd64.exe", "x64"),_
    Array("3.7.1-32bit", mirror&"/3.7.1/", "python-3.7.1.exe", "i386"),_
    Array("3.7.1", mirror&"/3.7.1/", "python-3.7.1-amd64.exe", "x64"),_
    Array("3.6.7-32bit", mirror&"/3.6.7/", "python-3.6.7.exe", "i386"),_
    Array("3.6.7", mirror&"/3.6.7/", "python-3.6.7-amd64.exe", "x64"),_
    Array("3.7.1rc2-32bit", mirror&"/3.7.1/", "python-3.7.1rc2.exe", "i386"),_
    Array("3.7.1rc2", mirror&"/3.7.1/", "python-3.7.1rc2-amd64.exe", "x64"),_
    Array("3.6.7rc2-32bit", mirror&"/3.6.7/", "python-3.6.7rc2.exe", "i386"),_
    Array("3.6.7rc2", mirror&"/3.6.7/", "python-3.6.7rc2-amd64.exe", "x64"),_
    Array("3.7.1rc1-32bit", mirror&"/3.7.1/", "python-3.7.1rc1.exe", "i386"),_
    Array("3.7.1rc1", mirror&"/3.7.1/", "python-3.7.1rc1-amd64.exe", "x64"),_
    Array("3.6.7rc1-32bit", mirror&"/3.6.7/", "python-3.6.7rc1.exe", "i386"),_
    Array("3.6.7rc1", mirror&"/3.6.7/", "python-3.6.7rc1-amd64.exe", "x64"),_
    Array("3.7.0-32bit", mirror&"/3.7.0/", "python-3.7.0.exe", "i386"),_
    Array("3.7.0", mirror&"/3.7.0/", "python-3.7.0-amd64.exe", "x64"),_
    Array("3.6.6-32bit", mirror&"/3.6.6/", "python-3.6.6.exe", "i386"),_
    Array("3.6.6", mirror&"/3.6.6/", "python-3.6.6-amd64.exe", "x64"),_
    Array("3.6.6rc1-32bit", mirror&"/3.6.6/", "python-3.6.6rc1.exe", "i386"),_
    Array("3.6.6rc1", mirror&"/3.6.6/", "python-3.6.6rc1-amd64.exe", "x64"),_
    Array("3.7.0rc1-32bit", mirror&"/3.7.0/", "python-3.7.0rc1.exe", "i386"),_
    Array("3.7.0rc1", mirror&"/3.7.0/", "python-3.7.0rc1-amd64.exe", "x64"),_
    Array("3.7.0b5-32bit", mirror&"/3.7.0/", "python-3.7.0b5.exe", "i386"),_
    Array("3.7.0b5", mirror&"/3.7.0/", "python-3.7.0b5-amd64.exe", "x64"),_
    Array("3.7.0b4-32bit", mirror&"/3.7.0/", "python-3.7.0b4.exe", "i386"),_
    Array("3.7.0b4", mirror&"/3.7.0/", "python-3.7.0b4-amd64.exe", "x64"),_
    Array("2.7.15-32bit", mirror&"/2.7.15/", "python-2.7.15.msi", "i386"),_
    Array("2.7.15", mirror&"/2.7.15/", "python-2.7.15.amd64.msi", "x64"),_
    Array("2.7.15rc1-32bit", mirror&"/2.7.15/", "python-2.7.15rc1.msi", "i386"),_
    Array("2.7.15rc1", mirror&"/2.7.15/", "python-2.7.15rc1.amd64.msi", "x64"),_
    Array("3.7.0b3-32bit", mirror&"/3.7.0/", "python-3.7.0b3.exe", "i386"),_
    Array("3.7.0b3", mirror&"/3.7.0/", "python-3.7.0b3-amd64.exe", "x64"),_
    Array("3.6.5-32bit", mirror&"/3.6.5/", "python-3.6.5.exe", "i386"),_
    Array("3.6.5", mirror&"/3.6.5/", "python-3.6.5-amd64.exe", "x64"),_
    Array("3.6.5rc1-32bit", mirror&"/3.6.5/", "python-3.6.5rc1.exe", "i386"),_
    Array("3.6.5rc1", mirror&"/3.6.5/", "python-3.6.5rc1-amd64.exe", "x64"),_
    Array("3.7.0b2-32bit", mirror&"/3.7.0/", "python-3.7.0b2.exe", "i386"),_
    Array("3.7.0b2", mirror&"/3.7.0/", "python-3.7.0b2-amd64.exe", "x64"),_
    Array("3.7.0b1-32bit", mirror&"/3.7.0/", "python-3.7.0b1.exe", "i386"),_
    Array("3.7.0b1", mirror&"/3.7.0/", "python-3.7.0b1-amd64.exe", "x64"),_
    Array("3.7.0a4-32bit", mirror&"/3.7.0/", "python-3.7.0a4.exe", "i386"),_
    Array("3.7.0a4", mirror&"/3.7.0/", "python-3.7.0a4-amd64.exe", "x64"),_
    Array("3.6.4-32bit", mirror&"/3.6.4/", "python-3.6.4.exe", "i386"),_
    Array("3.6.4", mirror&"/3.6.4/", "python-3.6.4-amd64.exe", "x64"),_
    Array("3.6.4rc1-32bit", mirror&"/3.6.4/", "python-3.6.4rc1.exe", "i386"),_
    Array("3.6.4rc1", mirror&"/3.6.4/", "python-3.6.4rc1-amd64.exe", "x64"),_
    Array("3.7.0a3-32bit", mirror&"/3.7.0/", "python-3.7.0a3.exe", "i386"),_
    Array("3.7.0a3", mirror&"/3.7.0/", "python-3.7.0a3-amd64.exe", "x64"),_
    Array("3.7.0a2-32bit", mirror&"/3.7.0/", "python-3.7.0a2.exe", "i386"),_
    Array("3.7.0a2", mirror&"/3.7.0/", "python-3.7.0a2-amd64.exe", "x64"),_
    Array("3.6.3-32bit", mirror&"/3.6.3/", "python-3.6.3.exe", "i386"),_
    Array("3.6.3", mirror&"/3.6.3/", "python-3.6.3-amd64.exe", "x64"),_
    Array("3.7.0a1-32bit", mirror&"/3.7.0/", "python-3.7.0a1.exe", "i386"),_
    Array("3.7.0a1", mirror&"/3.7.0/", "python-3.7.0a1-amd64.exe", "x64"),_
    Array("3.6.3rc1-32bit", mirror&"/3.6.3/", "python-3.6.3rc1.exe", "i386"),_
    Array("3.6.3rc1", mirror&"/3.6.3/", "python-3.6.3rc1-amd64.exe", "x64"),_
    Array("2.7.14-32bit", mirror&"/2.7.14/", "python-2.7.14.msi", "i386"),_
    Array("2.7.14", mirror&"/2.7.14/", "python-2.7.14.amd64.msi", "x64"),_
    Array("2.7.14rc1-32bit", mirror&"/2.7.14/", "python-2.7.14rc1.msi", "i386"),_
    Array("2.7.14rc1", mirror&"/2.7.14/", "python-2.7.14rc1.amd64.msi", "x64"),_
    Array("3.5.4-32bit", mirror&"/3.5.4/", "python-3.5.4.exe", "i386"),_
    Array("3.5.4", mirror&"/3.5.4/", "python-3.5.4-amd64.exe", "x64"),_
    Array("3.5.4rc1-32bit", mirror&"/3.5.4/", "python-3.5.4rc1.exe", "i386"),_
    Array("3.5.4rc1", mirror&"/3.5.4/", "python-3.5.4rc1-amd64.exe", "x64"),_
    Array("3.6.2-32bit", mirror&"/3.6.2/", "python-3.6.2.exe", "i386"),_
    Array("3.6.2", mirror&"/3.6.2/", "python-3.6.2-amd64.exe", "x64"),_
    Array("3.6.2rc2-32bit", mirror&"/3.6.2/", "python-3.6.2rc2.exe", "i386"),_
    Array("3.6.2rc2", mirror&"/3.6.2/", "python-3.6.2rc2-amd64.exe", "x64"),_
    Array("3.6.2rc1-32bit", mirror&"/3.6.2/", "python-3.6.2rc1.exe", "i386"),_
    Array("3.6.2rc1", mirror&"/3.6.2/", "python-3.6.2rc1-amd64.exe", "x64"),_
    Array("3.6.1-32bit", mirror&"/3.6.1/", "python-3.6.1.exe", "i386"),_
    Array("3.6.1", mirror&"/3.6.1/", "python-3.6.1-amd64.exe", "x64"),_
    Array("3.6.1rc1-32bit", mirror&"/3.6.1/", "python-3.6.1rc1.exe", "i386"),_
    Array("3.6.1rc1", mirror&"/3.6.1/", "python-3.6.1rc1-amd64.exe", "x64"),_
    Array("3.5.3-32bit", mirror&"/3.5.3/", "python-3.5.3.exe", "i386"),_
    Array("3.5.3", mirror&"/3.5.3/", "python-3.5.3-amd64.exe", "x64"),_
    Array("3.5.3rc1-32bit", mirror&"/3.5.3/", "python-3.5.3rc1.exe", "i386"),_
    Array("3.5.3rc1", mirror&"/3.5.3/", "python-3.5.3rc1-amd64.exe", "x64"),_
    Array("3.6.0-32bit", mirror&"/3.6.0/", "python-3.6.0.exe", "i386"),_
    Array("3.6.0", mirror&"/3.6.0/", "python-3.6.0-amd64.exe", "x64"),_
    Array("2.7.13-32bit", mirror&"/2.7.13/", "python-2.7.13.msi", "i386"),_
    Array("2.7.13", mirror&"/2.7.13/", "python-2.7.13.amd64.msi", "x64"),_
    Array("3.6.0rc2-32bit", mirror&"/3.6.0/", "python-3.6.0rc2.exe", "i386"),_
    Array("3.6.0rc2", mirror&"/3.6.0/", "python-3.6.0rc2-amd64.exe", "x64"),_
    Array("3.6.0rc1-32bit", mirror&"/3.6.0/", "python-3.6.0rc1.exe", "i386"),_
    Array("3.6.0rc1", mirror&"/3.6.0/", "python-3.6.0rc1-amd64.exe", "x64"),_
    Array("2.7.13rc1-32bit", mirror&"/2.7.13/", "python-2.7.13rc1.msi", "i386"),_
    Array("2.7.13rc1", mirror&"/2.7.13/", "python-2.7.13rc1.amd64.msi", "x64"),_
    Array("3.6.0b4-32bit", mirror&"/3.6.0/", "python-3.6.0b4.exe", "i386"),_
    Array("3.6.0b4", mirror&"/3.6.0/", "python-3.6.0b4-amd64.exe", "x64"),_
    Array("3.6.0b3-32bit", mirror&"/3.6.0/", "python-3.6.0b3.exe", "i386"),_
    Array("3.6.0b3", mirror&"/3.6.0/", "python-3.6.0b3-amd64.exe", "x64"),_
    Array("3.6.0b2-32bit", mirror&"/3.6.0/", "python-3.6.0b2.exe", "i386"),_
    Array("3.6.0b2", mirror&"/3.6.0/", "python-3.6.0b2-amd64.exe", "x64"),_
    Array("3.6.0b1-32bit", mirror&"/3.6.0/", "python-3.6.0b1.exe", "i386"),_
    Array("3.6.0b1", mirror&"/3.6.0/", "python-3.6.0b1-amd64.exe", "x64"),_
    Array("3.6.0a4-32bit", mirror&"/3.6.0/", "python-3.6.0a4.exe", "i386"),_
    Array("3.6.0a4", mirror&"/3.6.0/", "python-3.6.0a4-amd64.exe", "x64"),_
    Array("3.6.0a3-32bit", mirror&"/3.6.0/", "python-3.6.0a3.exe", "i386"),_
    Array("3.6.0a3", mirror&"/3.6.0/", "python-3.6.0a3-amd64.exe", "x64"),_
    Array("3.5.2-32bit", mirror&"/3.5.2/", "python-3.5.2.exe", "i386"),_
    Array("3.5.2", mirror&"/3.5.2/", "python-3.5.2-amd64.exe", "x64"),_
    Array("2.7.12-32bit", mirror&"/2.7.12/", "python-2.7.12.msi", "i386"),_
    Array("2.7.12", mirror&"/2.7.12/", "python-2.7.12.amd64.msi", "x64"),_
    Array("3.6.0a2-32bit", mirror&"/3.6.0/", "python-3.6.0a2.exe", "i386"),_
    Array("3.6.0a2", mirror&"/3.6.0/", "python-3.6.0a2-amd64.exe", "x64"),_
    Array("2.7.12rc1-32bit", mirror&"/2.7.12/", "python-2.7.12rc1.msi", "i386"),_
    Array("2.7.12rc1", mirror&"/2.7.12/", "python-2.7.12rc1.amd64.msi", "x64"),_
    Array("3.5.2rc1-32bit", mirror&"/3.5.2/", "python-3.5.2rc1.exe", "i386"),_
    Array("3.5.2rc1", mirror&"/3.5.2/", "python-3.5.2rc1-amd64.exe", "x64"),_
    Array("3.6.0a1-32bit", mirror&"/3.6.0/", "python-3.6.0a1.exe", "i386"),_
    Array("3.6.0a1", mirror&"/3.6.0/", "python-3.6.0a1-amd64.exe", "x64"),_
    Array("3.4.4-32bit", mirror&"/3.4.4/", "python-3.4.4.msi", "i386"),_
    Array("3.4.4", mirror&"/3.4.4/", "python-3.4.4.amd64.msi", "x64"),_
    Array("3.5.1-32bit", mirror&"/3.5.1/", "python-3.5.1.exe", "i386"),_
    Array("3.5.1", mirror&"/3.5.1/", "python-3.5.1-amd64.exe", "x64"),_
    Array("3.4.4rc1-32bit", mirror&"/3.4.4/", "python-3.4.4rc1.msi", "i386"),_
    Array("3.4.4rc1", mirror&"/3.4.4/", "python-3.4.4rc1.amd64.msi", "x64"),_
    Array("2.7.11-32bit", mirror&"/2.7.11/", "python-2.7.11.msi", "i386"),_
    Array("2.7.11", mirror&"/2.7.11/", "python-2.7.11.amd64.msi", "x64"),_
    Array("3.5.1rc1-32bit", mirror&"/3.5.1/", "python-3.5.1rc1.exe", "i386"),_
    Array("3.5.1rc1", mirror&"/3.5.1/", "python-3.5.1rc1-amd64.exe", "x64"),_
    Array("2.7.11rc1-32bit", mirror&"/2.7.11/", "python-2.7.11rc1.msi", "i386"),_
    Array("2.7.11rc1", mirror&"/2.7.11/", "python-2.7.11rc1.amd64.msi", "x64"),_
    Array("3.5.0-32bit", mirror&"/3.5.0/", "python-3.5.0.exe", "i386"),_
    Array("3.5.0", mirror&"/3.5.0/", "python-3.5.0-amd64.exe", "x64"),_
    Array("3.5.0rc4-32bit", mirror&"/3.5.0/", "python-3.5.0rc4.exe", "i386"),_
    Array("3.5.0rc4", mirror&"/3.5.0/", "python-3.5.0rc4-amd64.exe", "x64"),_
    Array("3.5.0rc3-32bit", mirror&"/3.5.0/", "python-3.5.0rc3.exe", "i386"),_
    Array("3.5.0rc3", mirror&"/3.5.0/", "python-3.5.0rc3-amd64.exe", "x64"),_
    Array("3.5.0rc2-32bit", mirror&"/3.5.0/", "python-3.5.0rc2.exe", "i386"),_
    Array("3.5.0rc2", mirror&"/3.5.0/", "python-3.5.0rc2-amd64.exe", "x64"),_
    Array("3.5.0rc1-32bit", mirror&"/3.5.0/", "python-3.5.0rc1.exe", "i386"),_
    Array("3.5.0rc1", mirror&"/3.5.0/", "python-3.5.0rc1-amd64.exe", "x64"),_
    Array("3.5.0b4-32bit", mirror&"/3.5.0/", "python-3.5.0b4.exe", "i386"),_
    Array("3.5.0b4", mirror&"/3.5.0/", "python-3.5.0b4-amd64.exe", "x64"),_
    Array("3.5.0b3-32bit", mirror&"/3.5.0/", "python-3.5.0b3.exe", "i386"),_
    Array("3.5.0b3", mirror&"/3.5.0/", "python-3.5.0b3-amd64.exe", "x64"),_
    Array("3.5.0b2-32bit", mirror&"/3.5.0/", "python-3.5.0b2.exe", "i386"),_
    Array("3.5.0b2", mirror&"/3.5.0/", "python-3.5.0b2-amd64.exe", "x64"),_
    Array("3.5.0b1-32bit", mirror&"/3.5.0/", "python-3.5.0b1.exe", "i386"),_
    Array("3.5.0b1", mirror&"/3.5.0/", "python-3.5.0b1-amd64.exe", "x64"),_
    Array("2.7.10-32bit", mirror&"/2.7.10/", "python-2.7.10.msi", "i386"),_
    Array("2.7.10", mirror&"/2.7.10/", "python-2.7.10.amd64.msi", "x64"),_
    Array("2.7.10rc1-32bit", mirror&"/2.7.10/", "python-2.7.10rc1.msi", "i386"),_
    Array("2.7.10rc1", mirror&"/2.7.10/", "python-2.7.10rc1.amd64.msi", "x64"),_
    Array("3.5.0a4-32bit", mirror&"/3.5.0/", "python-3.5.0a4.exe", "i386"),_
    Array("3.5.0a4", mirror&"/3.5.0/", "python-3.5.0a4-amd64.exe", "x64"),_
    Array("3.5.0a3-32bit", mirror&"/3.5.0/", "python-3.5.0a3.exe", "i386"),_
    Array("3.5.0a3", mirror&"/3.5.0/", "python-3.5.0a3-amd64.exe", "x64"),_
    Array("3.5.0a2-32bit", mirror&"/3.5.0/", "python-3.5.0a2.exe", "i386"),_
    Array("3.5.0a2", mirror&"/3.5.0/", "python-3.5.0a2-amd64.exe", "x64"),_
    Array("3.4.3-32bit", mirror&"/3.4.3/", "python-3.4.3.msi", "i386"),_
    Array("3.4.3", mirror&"/3.4.3/", "python-3.4.3.amd64.msi", "x64"),_
    Array("3.5.0a1-32bit", mirror&"/3.5.0/", "python-3.5.0a1.exe", "i386"),_
    Array("3.5.0a1", mirror&"/3.5.0/", "python-3.5.0a1-amd64.exe", "x64"),_
    Array("3.4.3rc1-32bit", mirror&"/3.4.3/", "python-3.4.3rc1.msi", "i386"),_
    Array("3.4.3rc1", mirror&"/3.4.3/", "python-3.4.3rc1.amd64.msi", "x64"),_
    Array("2.7.9-32bit", mirror&"/2.7.9/", "python-2.7.9.msi", "i386"),_
    Array("2.7.9", mirror&"/2.7.9/", "python-2.7.9.amd64.msi", "x64"),_
    Array("2.7.9rc1-32bit", mirror&"/2.7.9/", "python-2.7.9rc1.msi", "i386"),_
    Array("2.7.9rc1", mirror&"/2.7.9/", "python-2.7.9rc1.amd64.msi", "x64"),_
    Array("3.4.2-32bit", mirror&"/3.4.2/", "python-3.4.2.msi", "i386"),_
    Array("3.4.2", mirror&"/3.4.2/", "python-3.4.2.amd64.msi", "x64"),_
    Array("3.4.2rc1-32bit", mirror&"/3.4.2/", "python-3.4.2rc1.msi", "i386"),_
    Array("3.4.2rc1", mirror&"/3.4.2/", "python-3.4.2rc1.amd64.msi", "x64"),_
    Array("2.7.8-32bit", mirror&"/2.7.8/", "python-2.7.8.msi", "i386"),_
    Array("2.7.8", mirror&"/2.7.8/", "python-2.7.8.amd64.msi", "x64"),_
    Array("2.7.7-32bit", mirror&"/2.7.7/", "python-2.7.7.msi", "i386"),_
    Array("2.7.7", mirror&"/2.7.7/", "python-2.7.7.amd64.msi", "x64"),_
    Array("3.4.1-32bit", mirror&"/3.4.1/", "python-3.4.1.msi", "i386"),_
    Array("3.4.1", mirror&"/3.4.1/", "python-3.4.1.amd64.msi", "x64"),_
    Array("2.7.7rc1-32bit", mirror&"/2.7.7/", "python-2.7.7rc1.msi", "i386"),_
    Array("2.7.7rc1", mirror&"/2.7.7/", "python-2.7.7rc1.amd64.msi", "x64"),_
    Array("3.4.1rc1-32bit", mirror&"/3.4.1/", "python-3.4.1rc1.msi", "i386"),_
    Array("3.4.1rc1", mirror&"/3.4.1/", "python-3.4.1rc1.amd64.msi", "x64"),_
    Array("3.4.0-32bit", mirror&"/3.4.0/", "python-3.4.0.msi", "i386"),_
    Array("3.4.0", mirror&"/3.4.0/", "python-3.4.0.amd64.msi", "x64"),_
    Array("3.4.0rc3-32bit", mirror&"/3.4.0/", "python-3.4.0rc3.msi", "i386"),_
    Array("3.4.0rc3", mirror&"/3.4.0/", "python-3.4.0rc3.amd64.msi", "x64"),_
    Array("3.3.5-32bit", mirror&"/3.3.5/", "python-3.3.5.msi", "i386"),_
    Array("3.3.5", mirror&"/3.3.5/", "python-3.3.5.amd64.msi", "x64"),_
    Array("3.3.5rc2-32bit", mirror&"/3.3.5/", "python-3.3.5rc2.msi", "i386"),_
    Array("3.3.5rc2", mirror&"/3.3.5/", "python-3.3.5rc2.amd64.msi", "x64"),_
    Array("3.3.5rc1-32bit", mirror&"/3.3.5/", "python-3.3.5rc1.msi", "i386"),_
    Array("3.3.5rc1", mirror&"/3.3.5/", "python-3.3.5rc1.amd64.msi", "x64"),_
    Array("3.3.5rc1-32bit", mirror&"/3.3.5/", "python-3.3.5rc1.msi", "i386"),_
    Array("3.3.5rc1", mirror&"/3.3.5/", "python-3.3.5rc1.amd64.msi", "x64"),_
    Array("3.3.4-32bit", mirror&"/3.3.4/", "python-3.3.4.msi", "i386"),_
    Array("3.3.4", mirror&"/3.3.4/", "python-3.3.4.amd64.msi", "x64"),_
    Array("3.3.3-32bit", mirror&"/3.3.3/", "python-3.3.3.msi", "i386"),_
    Array("3.3.3", mirror&"/3.3.3/", "python-3.3.3.amd64.msi", "x64"),_
    Array("2.7.6-32bit", mirror&"/2.7.6/", "python-2.7.6.msi", "i386"),_
    Array("2.7.6", mirror&"/2.7.6/", "python-2.7.6.amd64.msi", "x64"),_
    Array("3.2.5-32bit", mirror&"/3.2.5/", "python-3.2.5.msi", "i386"),_
    Array("3.2.5", mirror&"/3.2.5/", "python-3.2.5.amd64.msi", "x64"),_
    Array("3.3.2-32bit", mirror&"/3.3.2/", "python-3.3.2.msi", "i386"),_
    Array("3.3.2", mirror&"/3.3.2/", "python-3.3.2.amd64.msi", "x64"),_
    Array("2.7.5-32bit", mirror&"/2.7.5/", "python-2.7.5.msi", "i386"),_
    Array("2.7.5", mirror&"/2.7.5/", "python-2.7.5.amd64.msi", "x64"),_
    Array("3.3.1-32bit", mirror&"/3.3.1/", "python-3.3.1.msi", "i386"),_
    Array("3.3.1", mirror&"/3.3.1/", "python-3.3.1.amd64.msi", "x64"),_
    Array("3.2.4-32bit", mirror&"/3.2.4/", "python-3.2.4.msi", "i386"),_
    Array("3.2.4", mirror&"/3.2.4/", "python-3.2.4.amd64.msi", "x64"),_
    Array("2.7.4-32bit", mirror&"/2.7.4/", "python-2.7.4.msi", "i386"),_
    Array("2.7.4", mirror&"/2.7.4/", "python-2.7.4.amd64.msi", "x64"),_
    Array("3.3.0-32bit", mirror&"/3.3.0/", "python-3.3.0.msi", "i386"),_
    Array("3.3.0", mirror&"/3.3.0/", "python-3.3.0.amd64.msi", "x64"),_
    Array("3.2.3-32bit", mirror&"/3.2.3/", "python-3.2.3.msi", "i386"),_
    Array("3.2.3", mirror&"/3.2.3/", "python-3.2.3.amd64.msi", "x64"),_
    Array("2.7.3-32bit", mirror&"/2.7.3/", "python-2.7.3.msi", "i386"),_
    Array("2.7.3", mirror&"/2.7.3/", "python-2.7.3.amd64.msi", "x64"),_
    Array("3.2.2-32bit", mirror&"/3.2.2/", "python-3.2.2.msi", "i386"),_
    Array("3.2.2", mirror&"/3.2.2/", "python-3.2.2.amd64.msi", "x64"),_
    Array("3.2.1-32bit", mirror&"/3.2.1/", "python-3.2.1.msi", "i386"),_
    Array("3.2.1", mirror&"/3.2.1/", "python-3.2.1.amd64.msi", "x64"),_
    Array("2.7.2-32bit", mirror&"/2.7.2/", "python-2.7.2.msi", "i386"),_
    Array("2.7.2", mirror&"/2.7.2/", "python-2.7.2.amd64.msi", "x64"),_
    Array("3.1.4-32bit", mirror&"/3.1.4/", "python-3.1.4.msi", "i386"),_
    Array("3.1.4", mirror&"/3.1.4/", "python-3.1.4.amd64.msi", "x64"),_
    Array("3.2-32bit", mirror&"/3.2/", "python-3.2.msi", "i386"),_
    Array("3.2", mirror&"/3.2/", "python-3.2.amd64.msi", "x64"),_
    Array("2.7.1-32bit", mirror&"/2.7.1/", "python-2.7.1.msi", "i386"),_
    Array("2.7.1", mirror&"/2.7.1/", "python-2.7.1.amd64.msi", "x64"),_
    Array("3.1.3-32bit", mirror&"/3.1.3/", "python-3.1.3.msi", "i386"),_
    Array("3.1.3", mirror&"/3.1.3/", "python-3.1.3.amd64.msi", "x64"),_
    Array("2.6.6-32bit", mirror&"/2.6.6/", "python-2.6.6.msi", "i386"),_
    Array("2.6.6", mirror&"/2.6.6/", "python-2.6.6.amd64.msi", "x64"),_
    Array("2.7-32bit", mirror&"/2.7/", "python-2.7.msi", "i386"),_
    Array("2.7", mirror&"/2.7/", "python-2.7.amd64.msi", "x64"),_
    Array("3.1.2-32bit", mirror&"/3.1.2/", "python-3.1.2.msi", "i386"),_
    Array("3.1.2", mirror&"/3.1.2/", "python-3.1.2.amd64.msi", "x64"),_
    Array("2.6.5-32bit", mirror&"/2.6.5/", "python-2.6.5.msi", "i386"),_
    Array("2.6.5", mirror&"/2.6.5/", "python-2.6.5.amd64.msi", "x64"),_
    Array("2.6.4-32bit", mirror&"/2.6.4/", "python-2.6.4.msi", "i386"),_
    Array("2.6.4", mirror&"/2.6.4/", "python-2.6.4.amd64.msi", "x64"),_
    Array("2.6.3-32bit", mirror&"/2.6.3/", "python-2.6.3.msi", "i386"),_
    Array("2.6.3", mirror&"/2.6.3/", "python-2.6.3.amd64.msi", "x64"),_
    Array("3.1.1-32bit", mirror&"/3.1.1/", "python-3.1.1.msi", "i386"),_
    Array("3.1.1", mirror&"/3.1.1/", "python-3.1.1.amd64.msi", "x64"),_
    Array("3.1-32bit", mirror&"/3.1/", "python-3.1.msi", "i386"),_
    Array("3.1", mirror&"/3.1/", "python-3.1.amd64.msi", "x64"),_
    Array("2.6.2-32bit", mirror&"/2.6.2/", "python-2.6.2.msi", "i386"),_
    Array("2.6.2", mirror&"/2.6.2/", "python-2.6.2.amd64.msi", "x64"),_
    Array("3.0.1-32bit", mirror&"/3.0.1/", "python-3.0.1.msi", "i386"),_
    Array("3.0.1", mirror&"/3.0.1/", "python-3.0.1.amd64.msi", "x64"),_
    Array("2.5.4-32bit", mirror&"/2.5.4/", "python-2.5.4.msi", "i386"),_
    Array("2.5.4", mirror&"/2.5.4/", "python-2.5.4.amd64.msi", "x64"),_
    Array("2.5.3-32bit", mirror&"/2.5.3/", "python-2.5.3.msi", "i386"),_
    Array("2.5.3", mirror&"/2.5.3/", "python-2.5.3.amd64.msi", "x64"),_
    Array("2.6.1-32bit", mirror&"/2.6.1/", "python-2.6.1.msi", "i386"),_
    Array("2.6.1", mirror&"/2.6.1/", "python-2.6.1.amd64.msi", "x64"),_
    Array("3.0-32bit", mirror&"/3.0/", "python-3.0.msi", "i386"),_
    Array("3.0", mirror&"/3.0/", "python-3.0.amd64.msi", "x64"),_
    Array("2.6-32bit", mirror&"/2.6/", "python-2.6.msi", "i386"),_
    Array("2.6", mirror&"/2.6/", "python-2.6.amd64.msi", "x64"),_
    Array("2.5.2-32bit", mirror&"/2.5.2/", "python-2.5.2.msi", "i386"),_
    Array("2.5.2", mirror&"/2.5.2/", "python-2.5.2.amd64.msi", "x64"),_
    Array("2.5.1-32bit", mirror&"/2.5.1/", "python-2.5.1.msi", "i386"),_
    Array("2.5.1", mirror&"/2.5.1/", "python-2.5.1.amd64.msi", "x64"),_
    Array("2.4.4-32bit", mirror&"/2.4.4/", "python-2.4.4.msi", "i386"),_
    Array("2.5-32bit", mirror&"/2.5/", "python-2.5.msi", "i386"),_
    Array("2.5-32bit", mirror&"/2.5/", "python-2.5.amd64.msi", "x64"),_
    Array("2.4.3-32bit", mirror&"/2.4.3/", "python-2.4.3.msi", "i386"),_
    Array("2.4.2-32bit", mirror&"/2.4.2/", "python-2.4.2.msi", "i386"),_
    Array("2.4.1-32bit", mirror&"/2.4.1/", "python-2.4.1.msi", "i386"),_
    Array("2.3.5-32bit", mirror&"/2.3.5/", "Python-2.3.5.exe", "i386"),_
    Array("2.4-32bit", mirror&"/2.4/", "python-2.4.msi", "i386"),_
    Array("2.3.4-32bit", mirror&"/2.3.4/", "Python-2.3.4.exe", "i386"),_
    Array("2.3.3-32bit", mirror&"/2.3.3/", "Python-2.3.3.exe", "i386"),_
    Array("2.3.2-1-32bit", mirror&"/2.3.2/", "Python-2.3.2-1.exe", "i386"),_
    Array("2.3.1-32bit", mirror&"/2.3.1/", "Python-2.3.1.exe", "i386"),_
    Array("2.3-32bit", mirror&"/2.3/", "Python-2.3.exe", "i386"),_
    Array("2.2.3-32bit", mirror&"/2.2.3/", "Python-2.2.3.exe", "i386"),_
    Array("2.2.2-32bit", mirror&"/2.2.2/", "Python-2.2.2.exe", "i386"),_
    Array("2.2.1-32bit", mirror&"/2.2.1/", "Python-2.2.1.exe", "i386"),_
    Array("2.1.3-32bit", mirror&"/2.1.3/", "Python-2.1.3.exe", "i386"),_
    Array("2.2-32bit", mirror&"/2.2/", "Python-2.2.exe", "i386"),_
    Array("2.0.1-32bit", mirror&"/2.0.1/", "Python-2.0.1.exe", "i386")_
)

Function DownloadFile(strUrl,strFile)
    Dim objHttp
    Dim httpProxy
    Dim proxyArr
    Set objHttp = WScript.CreateObject("WinHttp.WinHttpRequest.5.1")
    on error resume next
    httpProxy = objws.ExpandEnvironmentStrings("%http_proxy%")
    if httpProxy <> "" AND httpProxy <> "%http_proxy%" Then
        if InStr(1, httpProxy, "@") > 0 then
            ' The http_proxy environment variable is set with basic authentication
            ' WinHttp seems to work fine without the credentials, so we should be
            ' okay with just the hostname/port part
            proxyArr = Split(httpProxy, "@")
            objHttp.setProxy 2, proxyArr(1)
        else
            objHttp.setProxy 2, httpProxy
        end if
    end if
    Call objHttp.Open("GET", strUrl, False )
    if Err.Number <> 0 then
        WScript.Echo Err.Description
        WScript.Quit
    end if
    objHttp.Send

    if Err.Number <> 0 then
        WScript.Echo Err.Description
        WScript.Quit
    end if
    on error goto 0
    if objHttp.status = 404 then
        WScript.Echo ":: [ERROR] :: 404 :: file not found"
        WScript.Quit
    end if

    Dim Stream
    Set Stream = WScript.CreateObject("ADODB.Stream")
    Stream.Open
    Stream.Type = 1
    Stream.Write objHttp.responseBody
    Stream.SaveToFile strFile, 2
    Stream.Close
End Function

WScript.Echo ":: [Info] ::  Mirror: " & mirror

Sub ShowHelp()
    WScript.Echo "Usage: pyenv install [-f] <version> [<version> ...]"
    WScript.Echo "       pyenv install [-f] -a|--all"
    WScript.Echo "       pyenv install [-f] -c|--clear"
    WScript.Echo "       pyenv install -l|--list"
    WScript.Echo ""
    WScript.Echo "  -l/--list   List all available versions"
    WScript.Echo "  -a/--all    Installs all known version from the local version DB cache"
    WScript.Echo "  -c/--clear  Removes downloaded installers from the cache to free space"
    WScript.Echo "  -f/--force  Install even if the version appears to be installed already"
    WScript.Echo "  -q/--quiet  Install using /quiet. This does not show the UI nor does it prompt for inputs"
    WScript.Echo ""
    WScript.Quit
End Sub

Sub EnsureFolder(path)
    Dim stack
    Dim folder
    Set stack = CreateObject("System.Collections.ArrayList")
    stack.Add path
    On Error Resume Next
    Do While stack.Count
        folder = stack(stack.Count-1)
        If objfs.FolderExists(folder) Then
            stack.RemoveAt stack.Count-1
        ElseIf Not objfs.FolderExists(objfs.GetParentFolderName(folder)) Then
            stack.Add objfs.GetParentFolderName(folder)
        Else
            objfs.CreateFolder folder
            If Err.number <> 0 Then Exit Sub
            stack.RemoveAt stack.Count-1
        End If
    Loop
End Sub

Sub download(params)
    WScript.Echo ":: [Downloading] ::  " & params(LV_Code) & " ..."
    WScript.Echo ":: [Downloading] ::  From " & params(LV_URL)
    WScript.Echo ":: [Downloading] ::  To   " & params(IP_InstallFile)
    DownloadFile params(LV_URL), params(IP_InstallFile)
End Sub

Function deepExtract(params)
    Dim webCachePath
    Dim installPath
    webCachePath = strDirCache &"\"& params(LV_Code) &"-webinstall"
    installPath = params(IP_InstallPath)
    deepExtract = -1

    If Not objfs.FolderExists(webCachePath) Then
        deepExtract = objws.Run(""""& params(IP_InstallFile) &""" /quiet /layout """& webCachePath &"""", 0, True)
        If deepExtract Then
            WScript.Echo ":: [Error] :: error using web installer."
            Exit Function
        End If
    End If

    ' Clean unused install files.
    Dim file
    Dim baseName
    For Each file In objfs.GetFolder(webCachePath).Files
        baseName = LCase(objfs.GetBaseName(file))
        If LCase(objfs.GetExtensionName(file)) <> "msi" Or _
           Right(baseName, 2) = "_d" Or _
           Right(baseName, 4) = "_pdb" Or _
           baseName = "launcher" Or _
           baseName = "path" Or _
           baseName = "pip" _
        Then
            objfs.DeleteFile file
        End If
    Next

    ' Install the remaining MSI files into our install folder.
    Dim msi
    For Each file In objfs.GetFolder(webCachePath).Files
        baseName = LCase(objfs.GetBaseName(file))
        deepExtract = objws.Run("msiexec /quiet /a """& file &""" TargetDir="""& installPath & """", 0, True)
        If deepExtract Then
            WScript.Echo ":: [Error] :: error installing """& baseName &""" component MSI."
            Exit Function
        End If

        ' Delete the duplicate MSI files post-install.
        msi = installPath &"\"& objfs.GetFileName(file)
        If objfs.FileExists(msi) Then objfs.DeleteFile msi
    Next

    ' If the ensurepip Lib exists, call it manually since "msiexec /a" installs don't do this.
    If objfs.FolderExists(installPath &"\Lib\ensurepip") Then
        deepExtract = objws.Run(""""& installPath &"\python"" -E -s -m ensurepip -U --default-pip", 0, True)
        If deepExtract Then
            WScript.Echo ":: [Error] :: error installing pip."
            Exit Function
        End If
    End If
End Function

Sub extract(params)
    Dim installFile
    Dim installFileFolder
    Dim installPath
    Dim quiet

    installFile = params(IP_InstallFile)
    installFileFolder = objfs.GetParentFolderName(installFile)
    installPath = params(IP_InstallPath)
    If params(IP_Quiet) Then quiet = " /quiet"

    If Not objfs.FolderExists(installFileFolder) Then _
        EnsureFolder(installFileFolder)

    If Not objfs.FolderExists(objfs.GetParentFolderName(installPath)) Then _
        EnsureFolder(objfs.GetParentFolderName(installPath))

    If objfs.FolderExists(installPath) Then Exit Sub

    If Not objfs.FileExists(installFile) Then download(params)

    WScript.Echo ":: [Installing] ::  "& params(LV_Code) &" ..."
    objws.CurrentDirectory = installFileFolder

    ' Wrap the paths in quotes in case of spaces in the path.
    Dim qInstallFile
    Dim qInstallPath
    qInstallFile = """"& installFile &""""
    qInstallPath = """"& installPath &""""

    Dim exitCode
    Dim file
    If params(LV_MSI) Then
        exitCode = objws.Run("msiexec /quiet /a "& qInstallFile &" TargetDir="& qInstallPath, 9, True)
        If exitCode = 0 Then
            ' Remove duplicate .msi files from install path.
            For Each file In objfs.GetFolder(installPath).Files
                If LCase(objfs.GetExtensionName(file)) = "msi" Then objfs.DeleteFile file
            Next

            ' If the ensurepip Lib exists, call it manually since "msiexec /a" installs don't do this.
            If objfs.FolderExists(installPath &"\Lib\ensurepip") Then
                exitCode = objws.Run(""""& installPath &"\python"" -E -s -m ensurepip -U --default-pip", 0, True)
                If exitCode Then WScript.Echo ":: [Error] :: error installing pip."
            End If
        End If
    ElseIf params(LV_Web) Then
        exitCode = deepExtract(params)
    Else
        exitCode = objws.Run(qInstallFile & quiet &" InstallAllUsers=0 Include_launcher=0 Include_test=0 SimpleInstall=1 TargetDir="& qInstallPath, 9, True)
    End If

    If exitCode = 0 Then
        WScript.Echo ":: [Info] :: completed! "& params(LV_Code)
        SetGlobalVersion params(LV_Code)
    Else
        WScript.Echo ":: [Error] :: couldn't install .. "& params(LV_Code)
    End If
End Sub

Sub main(arg)
    If arg.Count = 0 Then ShowHelp

    Dim idx
    Dim optForce
    Dim optList
    Dim optQuiet
    Dim optAll
    Dim optClear
    Dim installVersions

    optForce = False
    optList = False
    optQuiet = False
    optAll = False
    Set installVersions = CreateObject("Scripting.Dictionary")

    For idx = 0 To arg.Count - 1
        Select Case arg(idx)
            Case "--help"  ShowHelp
            Case "-l"      optList = True
            Case "--list"  optList = True
            Case "-f"      optForce = True
            Case "--force" optForce = True
            Case "-q"      optQuiet = True
            Case "--quiet" optQuiet = True
            Case "-a"      optAll = True
            Case "--all"   optAll = True
            Case "-c"      optClear = True
            Case "--clear" optClear = True
            Case Else
                installVersions.Item(arg(idx)) = Empty
        End Select
    Next

    Dim versions
    Dim version
    Set versions = LoadVersionsXML(strDBFile)
    If versions.Count = 0 Then
        WScript.Echo "pyenv-install: no definitions in local database"
        WScript.Echo
        WScript.Echo "Please update the local database cache with `pyenv update'."
        WScript.Quit 1
    End If

    If Not optAll Then
        If installVersions.Count = 0 Then
            Dim ary
            ary = GetCurrentVersionNoError()
            If Not IsNull(ary) Then installVersions.Item(ary(0)) = Empty
        End If

        ' Pre-check if all versions to install exist.
        For Each version In installVersions.Keys
            If Not versions.Exists(version) Then
                WScript.Echo "pyenv-install: definition not found: "& version
                WScript.Echo
                WScript.Echo "See all available versions with `pyenv install --list'."
                WScript.Quit 1
            End If
        Next
    End If

    If optList Then
        For Each version In versions.Keys
            WScript.Echo version
        Next
    ElseIf optClear Then
        Dim objCache
        Dim delError
        delError = 0

        On Error Resume Next
        For Each objCache In objfs.GetFolder(strDirCache).Files
            objCache.Delete optForce
            If Err.Number <> 0 Then
                WScript.Echo "pyenv: Error ("& Err.Number &") deleting file "& objCache.Name &": "& Err.Description
                Err.Clear
                delError = 1
            End If
        Next
        For Each objCache In objfs.GetFolder(strDirCache).SubFolders
            objCache.Delete optForce
            If Err.Number <> 0 Then
                WScript.Echo "pyenv: Error ("& Err.Number &") deleting folder "& objCache.Name &": "& Err.Description
                Err.Clear
                delError = 1
            End If
        Next
        WScript.Quit delError
    Else
        Dim versDict
        Dim verDef
        Dim installParams

        If optAll Then
            Set versDict = versions
        Else
            Set versDict = installVersions
        End If

        If versDict.Count = 0 Then ShowHelp

        For Each version In versDict.Keys
            verDef = versions(version)
            installParams = Array( _
                verDef(LV_Code), _
                verDef(LV_FileName), _
                verDef(LV_URL), _
                verDef(LV_x64), _
                verDef(LV_Web), _
                verDef(LV_MSI), _
                strDirVers &"\"& verDef(LV_Code), _
                strDirCache &"\"& verDef(LV_FileName), _
                optQuiet _
            )
            If optForce Then clear(installParams)
            extract(installParams)
        Next
        Rehash
    End If
End Sub

main(WScript.Arguments)
