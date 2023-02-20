'This is a function that delete all pictures in Excel workbook.
Sub deleteAllPics()
    Dim ws As WorkSheet
    Dim pic as Object
    For Each ws In WorkSheets
        For Each pic In ws.Pictures
            pic.Delete
        Next pic
    Next ws
End Sub