<%

Dim controller

Class CController
    Private access
    Public login
    Public admin
    Public premium
    Public samsung
    Public bc
    Public level
    Public menu
    Public ajax
    Public json
        
    Private Sub Class_Initialize()
        access = False
        login = False
        admin = False
        ajax = False
        json = False
        level = USER_LEVEL.GUEST
    End Sub
    
    Public Sub auth (maximum_level)
        level = maximum_level
        If maximum_level = USER_LEVEL.GUEST Then
            access = True
        End If
        If Len(Session("usr_lev")) > 0 Then
            login = True
            If Session("usr_lev") <= maximum_level Then
                access = True
            End If
            If Session("usr_lev") <= USER_LEVEL.ADMIN Then
                admin = True
            End If
        End If

        If login = False and maximum_level < USER_LEVEL.GUEST Then
            ' login please
            Server.Execute("/framework/templates/requirelogin.asp")
            Response.End
        End If
    End Sub
End Class
    
Set controller = New CController

%>
