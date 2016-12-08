<%

ugon.view = Eval(ugon.method & "()")

If controller.ajax Then
    If controller.json Then
        Response.ContentType = "application/json"
    End If
    loadview(ugon.view)
ElseIf ugon.view <> "" Then
%><!-- #include file="../templates/header.asp" --><%
loadview(ugon.view)
%><!-- #include file="../templates/footer.asp" --><%
End If

' finalize
model.finalize()
%>