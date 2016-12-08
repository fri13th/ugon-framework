<%
Dim model
    
Class CModel
    Private dbo
    Private rs
    Private id
    Private password
    Private host
    Private database
    Private connectionString
        
    Public Sub openConnection() ' may we save the db connection object to session??
        id = DBINFO.ID
        password = DBINFO.PASSWORD
        host = DBINFO.HOST
        database = DBINFO.DATABASE
            
        Set dbo = Server.CreateObject("ADODB.Connection")
        Set rs = Server.CreateObject("ADODB.RecordSet")

        connectionString = "Data Source=" & host & ";User ID=" & id & ";Password=" & password &_ 
            ";Initial Catalog=" & database & ";Provider=SQLOLEDB.1;Persist Security Info=True;"
        dbo.open(connectionString)
    End Sub
    
    Public Sub finalize()
        closeResultSet()
        closeConnection()
    End Sub
            
    Public Sub closeConnection()
    On Error Resume Next
      If IsObject(dbo) Then
        If dbo.State = 1 Then: dbo.Close
      If Err.Number <> 0 Then strErr = strErr & Err.Number & " / " & Err.Description & "<br>"
        Set dbo = Nothing
      End If
    End Sub
         
    Public Sub closeResultSet()
    On Error Resume Next
      If IsObject(rs) Then
        If rs.State = 1 Then: rs.Close
      If Err.Number <> 0 Then strErr = strErr & Err.Number & " / " & Err.Description & "<br>"
        Set rs = Nothing
      End If
    End Sub
        
    Public Sub saveUpdate(sql)
    On Error Resume Next
        rs.Open sql, dbo
        rs.Close
    End Sub
        
    Public Function retrieve(sql)
    On Error Resume Next
        rs.Open sql, dbo
        If Not rs.EOF Then
            retrieve = rs.getRows()
        Else
            retrieve = Null
        End If
        rs.Close
    End Function

    Public Function paginatedRetrieve(cols, from, where, order, start, pageSize)
        Dim sql
        sql = "SELECT TOP " & pageSize & " * FROM (" &_
	        " SELECT ROW_NUMBER() OVER (ORDER BY " & order & ") AS RowNumber, " & cols &_
            ", TotalRows=Count(*) OVER() " & " FROM " & from & " WHERE 1=1 " & where & ") _tmpInlineView " &_
            " WHERE RowNumber >= " & start & " ORDER BY " + order
        'FALog(sql)
        'Response.Write sql
        paginatedRetrieve = retrieve(sql)
    End Function
        
End Class
    
Set model = New CModel
%>
