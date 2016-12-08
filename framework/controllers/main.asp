<%

controller.auth(USER_LEVEL.GUEST)
model.openConnection()
controller.menu = "home"

' view variables..
Dim userList

Function RemoveHTMLTagsFromStr( strText )
    Dim nPos1
    Dim nPos2

    nPos1 = InStr(strText, "<")
    Do While nPos1 > 0
    nPos2 = InStr(nPos1 + 1, strText, ">")
    If nPos2 > 0 Then
    strText = Left(strText, nPos1 - 1) & Mid(strText, nPos2 + 1)
    Else
    Exit Do
    End If
    nPos1 = InStr(strText, "<")
    Loop
    strText = replace(strText, vbTab, "")
    strText = replace(strText, vbcrlf, "")
    RemoveHTMLTagsFromStr = strText
End Function


Function index()
    ' userList = getUserList()
    index = "index"
End Function

Function loadview(view)
    Select Case view
    Case "index" 
        %><!-- #include file="../views/main/index.asp" --><%
    Case Else
        %><!-- #include file="../templates/error.asp" --><% 
    End Select
End Function

%>