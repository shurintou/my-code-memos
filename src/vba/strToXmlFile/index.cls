'This is a function that create XML file with string value in Excel.
Sub strToXmlFile()
    Dim wb As Workbook 
    Set wb = Excel.ThisWorkbook
    
    Dim sXml As String
    sXml = wb.Sheets("Sheet1").Range("A1").Value ' the str that you want to transfer to Xml

    'define a XML file object
    Dim oXml As Object
    Set oXml = VBA.CreateObject("Msxml2.DOMDocument.6.0")
    'or Set oXml = VBA.CreateObject("Microsoft.XMLDOM")

    With oXml
        'import the string 
        .LoadXML (sXml)
        ' handle the error
        With .parseError
            If .ErrorCode <> 0 Then
                MsgBox(.reason)
            End If
        End With 
        'define the path to save the XML file
        Dim sResultXml As String
        sResultXml = wb.Path & "\result.xml"

        .Save sResultXml
    End With

End Sub