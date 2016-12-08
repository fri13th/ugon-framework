<%

Dim blacklist
blacklist =  Array("--", ";", "/*", "*/", "@@")', "@")
Dim moreblacklist
moreblacklist = Array("select", "drop", "insert", "update", "delete", "declare", "exec", "xp_")


Function URLDecode(str) 
    str = Replace(str, "+", " ") 
    For i = 1 To Len(str) 
        sT = Mid(str, i, 1) 
        If sT = "%" Then 
            If i+2 < Len(str) Then 
                sR = sR & _ 
                    Chr(CLng("&H" & Mid(str, i+1, 2))) 
                i = i+2 
            End If 
        Else 
            sR = sR & sT 
        End If 
    Next 
    URLDecode = sR 
End Function 
 
Function URLEncode(str) 
    URLEncode = Server.URLEncode(str) 
End Function 

Function sanitizePassword(param) 
    On Error Resume Next
    ' check length and sanitize default values
    If (IsEmpty(param) Or StrComp(param, "") = 0) Then
        sanitize = ""
        Exit Function
    End If
    param = URLDecode(param)
    If Len(param) > 20 Then
        param = Left(param, 20)
    End If
    param = Replace(param, "'", "''")
    sanitizePassword = param     
End Function

Function sanitizeQuery(param) 
    On Error Resume Next
    Dim unchecked
    Dim item

    If (IsEmpty(param) Or StrComp(param, "") = 0) Then
        sanitize = ""
        Exit Function
    End If
    param = URLDecode(param)
    param = Replace(param, "'", "''")    
    For Each item in blacklist
        param = Replace(param, item, "") 
    Next    
    sanitizeQuery = param  
End Function

Function sanitizeForm(param) 
    On Error Resume Next
    Dim unchecked
    Dim item

    If (IsEmpty(param) Or StrComp(param, "") = 0) Then
        sanitize = ""
        Exit Function
    End If
    param = URLDecode(param)
    param = Replace(param, "'", "''")    
    For Each item in blacklist
        param = Replace(param, item, "") 
    Next

    'For Each item in moreblacklist
    '    param = replaceIgnoreCase(param, item)
    'Next    

    sanitizeForm = param  
End Function


Function sanitize(param) 
    On Error Resume Next
    Dim unchecked
    Dim item

    If (IsEmpty(param) Or StrComp(param, "") = 0) Then
        sanitize = ""
        Exit Function
    End If
    param = URLDecode(param)
    param = Replace(param, "'", "''")    
    For Each item in blacklist
        param = Replace(param, item, "") 
    Next

    For Each item in moreblacklist
        param = replaceIgnoreCase(param, item)
    Next    
    
    sanitize = param  
End Function 

Function replaceIgnoreCase(orig, rep)
    Dim pos
    pos = InStr(LCase(orig), rep)
    If pos >= 0 Then
        replaceIgnoreCase = Replace(orig, Mid(orig, pos, Len(rep)),"")
    Else
        replaceIgnoreCase = orig
    End If
End Function


Dim ugon 
Class CUgon ' means ugonisan
    Public method
    Public view
    Public controller
    Public params

    Private Sub Class_Initialize()
        ' sanitize input, we need to sanitize server variables, we don't use cookie..
        Set params = CreateObject("Scripting.Dictionary")
        Dim item
        For Each item In Request.QueryString       
            params.Add item, sanitizeQuery(Request.QueryString(item))
        Next
        For Each item In Request.Form
            If Not params.Exists(item) Then
                If item = "password" Then 
                    params.Add item, sanitizePassword(Request.Form(item))
                Else
                    params.Add item, sanitizeForm(Request.Form(item))
                End If
            End If
        Next

        controller = params.item("c")
        method = params.item("m")
        If IsNull(controller) or controller = "" Then
            controller = "main"
        End If
        If IsNull(method) or method = ""  Then
            method = "index"
        End If
    End Sub
End Class
    
Set ugon = New CUgon    


%>