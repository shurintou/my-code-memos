Sub openApplication()
    On Error GoTo err_handle
    Dim excelApp, workbook1, wordApp As Object
    Set excelApp = CreateObject("Excel.application")
    Set workbook1 = excelApp.Workbooks.Open("your_file_path\file_name.xlsx")
    Set SHE = workbook1.worksheets(1)
    s = ActiveDocument.Paragraphs(1).Range.Text
    SHE.Range("C" & CStr(SHE.Range("I1").Value + 1)).Value = s
    err_handle:
    workbook1.Save
    excelApp.Quit
End Sub