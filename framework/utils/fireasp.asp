<%

	Class FireASP
		
		'Private variables 
		Private headerPrefix
		Private headerCounter
		Private protocolHeaderKeys(3)
		Private protocolHeaderVals(3)
		
		'Singleton Instance
		Private instance
		
		Private Sub Class_Initialize()
			
            Dim i
			'Set the header prefix
			headerPrefix = "X-Wf-"
			
			headerCounter = 0
			
			protocolHeaderKeys(0) = "Protocol-1"
			protocolHeaderKeys(1) = "1-Plugin-1"
			protocolHeaderKeys(2) = "1-Structure-1"
			
			protocolHeaderVals(0) = "http://meta.wildfirehq.org/Protocol/JsonStream/0.2"
			protocolHeaderVals(1) = "http://meta.firephp.org/Wildfire/Plugin/FirePHP/Library-FirePHPCore/0.3"
			protocolHeaderVals(2) = "http://meta.firephp.org/Wildfire/Structure/FirePHP/FirebugConsole/0.1"
			
			'Turn on Page buffering
			Response.Buffer = True
			
			For i = 0 to 2
				
				'Response.Write protocolHeaders(i)
				Response.addHeader headerPrefix & protocolHeaderKeys(i), protocolHeaderVals(i) 
				
			next
			
		End Sub
		
		Private Function formatResponse( ByRef str )
			dim msgLength
            Dim header
			
			if len(str) < 1 then
				str = ""
			end if
			
			header = "|[{" & chr(34) & "Type" & chr(34) & ":" & chr(34) & "LOG" & chr(34) & "}," &  str  & "]|"
			
			'Subtract two characters to compensate for the bars
			msgLength = len(header) - 2
			formatResponse = msgLength & header
			
			'Response.Write formatResponse &  "<br />"
			
		End Function
		
		'Public Methods
		Public Function log( ByRef obj )
			dim str
			
			headerCounter= headerCounter + 1
			
			if IsArray( obj ) then	'is an array
				
				str = "["
				
				For Each item In obj
					
					str = str & chr(34) & item & chr(34) & ","
					
				next
				
				'Remove the last comma
				str = Left( str, len(str) -1 )
				
				str = str & "]"
				
			elseif IsObject( obj ) then 	'is an object
				'sdsdsd
		
			else	'is a string
				str = chr(34) & "nothing" & chr(34)
				str = chr(34) & obj & chr(34)
			end if
			
			'Response.write headerCounter
			Response.addHeader headerPrefix & "1-1-1-" & headerCounter , formatResponse( str ) 
		End Function
		
		'Get singleton instance
		Public Function getInstance
			
			If IsNull( instance ) then
				set instance = new FireASP
			End if
			
			getInstance = instance
			
		End Function
		
	End Class

    Dim FIRE_ASP
	Set FIRE_ASP = new FireASP
	
	Function FALog( ByRef msg )
		
		FIRE_ASP.log( msg )
		
	End Function
%>