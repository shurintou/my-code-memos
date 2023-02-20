'This is a function that show all hidden names in Excel workbook.
Sub showNames()
    Dim name As Object
    For Each name In Names
        If name.Visible = False Then
            name.Visible = True
        End If
    Next
End Sub

'After the func done, try open the `formula - Name manager` to see the result.