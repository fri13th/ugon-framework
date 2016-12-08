<%

Sub insertLoginInfo(id, userid)
    ' auto incremental is not working so we don't use this function
    model.saveUpdate("insert into t_login(usr_num,usr_id,login,session_num) values("& id & ",'" & userid & "',GETDATE(),0)")
End Sub

%>