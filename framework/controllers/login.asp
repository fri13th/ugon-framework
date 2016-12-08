<%

controller.auth(USER_LEVEL.GUEST)
model.openConnection()


'If controller.login = True Then
'    Response.Redirect("/framework/views/login/logged.asp")
'    Response.End
'End If

' view variables..

Dim url
Dim encrypted
Dim referrer

Function index()
    Dim referrer
    referrer = Request.ServerVariables("http_referer")
    If InStr(1, referrer, "login", vbTextCompare) = 0 Then
        Session("referrer") = referrer 
    End If
    index = "index"
End Function



Function login()
    Dim userid
    Dim password
    Dim userinfo
    Dim expired
    Dim expiredAlert
    Dim referrer
    
    userid = ugon.params.Item("userid")
    password = HTMLDecode(ugon.params.Item("password"))
    userinfo = retriveUserInfo(userid, password) 'id, usr_nm, usr_lev, usr_nick, usr_mail

    If IsNull(userinfo) Then
        login = "mismatch"
    Else
        Session.Timeout = 120
        Session("usr_id") = userid
        Session("usr_num") = userinfo(0,0)
        Session("usr_nm") = userinfo(1,0)
        Session("usr_lev") = userinfo(2,0)
        Session("usr_nick") = userinfo(3,0)
        Session("usr_mail") = userinfo(4,0)

        insertLoginInfo userinfo(0,0), userid

        If referrer="" Or InStr(1, referrer, "login", vbTextCompare) > 0 Then
            'Response.Redirect "http://" & Request.ServerVariables("SERVER_NAME")
            url = "http://" & Request.ServerVariables("SERVER_NAME")
        else
            'Response.Redirect referrer
            url = referrer
        End If

        controller.ajax = true
    End If

End Function


%>
