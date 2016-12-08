<% 

Dim controller
Dim fso

controller = Request.QueryString("c") 
If IsNull(controller) or controller = "" Then
    controller = "main"
End If

Set fso = Server.CreateObject("Scripting.FileSystemObject")
If (fso.FileExists(Server.MapPath("/backup/framework/inits/" & controller & ".asp")))=true Then
    Server.Execute("/backup/framework/inits/" & controller & ".asp")
Else
    Server.Execute("/backup/framework/templates/404.asp")
End If

%>
