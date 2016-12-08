<%


Function retriveUserInfo (userid, password)
    retriveUserInfo = model.retrieve("SELECT id, usr_nm, usr_lev, usr_nick, usr_mail, samsung, bc FROM t_usrinfo WHERE usr_id='" & userid & "' AND Convert(VARCHAR(60), DecryptByPassPhrase('f^Nj@{[67;94a}AW', usr_pw_enc))='" & password & "' AND usr_lev<=" & USER_LEVEL.FREE)
End Function

%>
