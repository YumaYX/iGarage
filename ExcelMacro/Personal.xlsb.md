# PERSONAL.XLSB

```vb
' シート初期化(I)
Sub initial_sheet()
  Cells.Select
  Selection.ColumnWidth = 2
  With Selection.Font
      .Name = "MS ゴシック"
      .Size = 11
      .Strikethrough = False
      .Superscript = False
      .Subscript = False
      .OutlineFont = False
      .Shadow = False
      .Underline = xlUnderlineStyleNone
      .ThemeColor = xlThemeColorLight1
      .TintAndShade = 0
      .ThemeFont = xlThemeFontNone
  End With
  Range("A1").Select
End Sub

' セル装飾無し(A)
Sub noDecoration()
  Selection.Interior.Color = xlNone
  Selection.Font.ColorIndex = xlAutomatic
End Sub

' 列ファイル書き出し(W)
Sub OutputColumn()
  Dim l As Long
  l = ActiveCell.Column

  Dim max As Long
  max = Cells(Rows.Count, l).End(xlUp).Row

  Dim sheetname As String
  sheetname = ActiveSheet.Name

  Dim output_filename As String
  output_filename = sheetname + "_" + Format(Time, "hhmmss") + ".txt"
  output_filename = Replace(output_filename, " ", "")

  '''''''''''''''''''''''''''''''''''''''''''''''''
  Open output_filename For Append As #1

  Dim cell_val As String
  For i = 1 To max
    cell_val = Cells(i, l).Value

    If Len(cell_val) = 0 Then
    GoTo CONTINUE1:
    End If

    Print #1, cell_val
    CONTINUE1:
  Next

  Close #1
  '''''''''''''''''''''''''''''''''''''''''''''''''
End Sub

' テーブルのhash化
Public Function hash(ByRef table As Range, _
    ByVal key_column_name As String, _
    ByVal key_name As String, _
    ByVal column_name As String)
  Set target_table = table.ListObject
  For i = 1 To target_table.ListColumns(column_name).DataBodyRange.Count
    target_key = target_table.ListColumns(key_column_name).DataBodyRange(i)
    target_value = target_table.ListColumns(column_name).DataBodyRange(i)
    if target_key = key_name Then
      hash = target_value
      Exit Function
    End If
  Next
End Function
' hash(range_table,key_clm ,key, val_clm)

```