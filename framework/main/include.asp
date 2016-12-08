<%@ CODEPAGE=65001 %>
<%  Option Explicit
    Session.CodePage=65001

    Response.Buffer = True

    Dim i,j,k ' for view iterration
    Dim CONSTANT
    Class CConstant
        Public CONTROLLER 
        Public METHOD
        Public VIEW
        Private Sub Class_Initialize()
            CONTROLLER = "main" 
            METHOD = "index"
            VIEW = "index"
        End Sub
    End Class    
    Set CONSTANT = New CConstant

    Dim USER_LEVEL
    Class CUserLevel
        Public GUEST
        Public FREE
        Public PREMIUM
        Public ADMIN
        Private Sub Class_Initialize()
            GUEST = 4 ' not logged
            FREE = 3  ' only login
            PREMIUM = 2 'premium user
            ADMIN = 1  ' admin mode, restaurant manage
        End Sub
    End Class
    Set USER_LEVEL = new CUserLevel
        
    Dim DBINFO
    Class CDBInfo
        Public ID
        Public PASSWORD
        Public HOST
        Public DATABASE
        Private Sub Class_Initialize()
            ID = "dbuserid"
            PASSWORD = "dbpassword"
            HOST = "localhost"
            DATABASE = "sample"
        End Sub
    End Class
    Set DBINFO = new CDBInfo

    ' debug purpose
    If Request.ServerVariables("remote_addr") = "::1" _
        Or LEFT(Request.ServerVariables("remote_addr"), 6) = "172.16" _
        Or LEFT(Request.ServerVariables("remote_addr"), 7) = "192.168"_
        Or LEFT(Request.ServerVariables("remote_addr"), 3) = "127" Then
        DBINFO.ID = "dbuserid"
        DBINFO.PASSWORD = "dbpassword"
        DBINFO.HOST = "localhost"
    End If            

%>