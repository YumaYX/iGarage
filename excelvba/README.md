# セル

- Cells(Y,X)
- Range("cell / cell name")
- Range("Table")

## 選択

| 選択対象 | コード |
| --- | --- |
| 全てのセル | Cells.Select |
| A列 | Columns("A:A").Select |
| B2セル | Range("B2").Select |

### セルの内容削除

```vb
Selection.Delete 
```

# 変数

```vb
'WorkBook
Dim wb as WorkBook
Set wb = Workbooks("Book1.xlsx")
Dim wb As Worksheet: Set wb = Workbooks("Book1.xlsx")

'Sheet
Dim ws As Worksheet
Set ws = Sheets("Sheet1")
Dim ws As Worksheet: Set ws = Sheets("Sheet1")
Worksheets("Sheet Name")
Sheets("Sheet Name")

'String, Integer, Long
Dim str As String
Dim str As String: str = "abcd"

'Array
Dim array() As String
ReDim array(32)
array(0)= "first"

Dim array_index as Integer
For array_index = 0 To UBound(array)
    Cells(i + 1, 1).Value = array(array_index)
Next array_index

'コレクション
Dim col As VBA.Collection
Set col = New VBA.Collection
col.Add "a"

Dim iter As Variant
For Each iter In col
    Debug.Print iter
Next iter

'連想配列
Dim dic as Object
Set dic = CreateObject("Scripting.Dictionary")
dic.Item(1) = "a"

Dim k As Variant
For Each k In dic
    Debug.Print dic.Item(k)
Next k
```

# If

```vb
If 条件 Then
    '処理
ElseIf 条件 Then
    '処理
Else
    '処理
End if
```

## 演算子

| 意味 | 演算子 | 例 |
| --- | --- | --- |
| not | <> | 1 <> 0 |
| equal | = | 1 = 1 |
| and | And | True And True|
| or | Or | True Or False |
| 否定 | Not | Not False |


# 特別な変数

- ThisWorkbook
- ThisWorkbook.Path
- ActiveWorkBook
- ActiveSheet

# 繰り返し

```vb
'for
Dim i As Integer
For i = 1 To 10
    Debug.Print(i)
Next

'object
For Each item In オブジェクト
    Debug.Print(item.Name)
Next
```


# デバッグ

```vb
Debug.print("a")
MsgBox "b"
```

# 関数

```vb
'ByVal値渡し
ByVal str As String
'ByRef参照渡し
ByRef str As String

'Sub(void)
Sub f1()

'Function
Function f2() As String
  f2 = 'string'

'呼び出し
Call f
f2
```

---

# 最終行取得

```vb
sheet_name = "Sheet Name"
Worksheets(sheet_name).Cells(Rows.Count, 1).End(xlUp).Row
' 1 column
```


# 全シート名取得
```vb
Dim i As Long
For i = 1 To Worksheets.Count
    Debug.Print Worksheets(i).Name
Next
```

# ファイル場所について

```vb
'ドキュメントフォルダ下
"book.xlsx" ' ファイル名のみ記載する
' ".\book.xlsx"も同様にドキュメントフォルダ下

'実行ファイルと同じ場所
ThisWorkbook.Path & "book.xlsx"

'絶対パス
"C:\book.xlsx"

```

# ファイル存在確認

```vb
Dim str As String: str = "filename"
If Dir(str) <> "" Then
    MsgBox "有り"
Else
    MsgBox "無し"
End If
```

# ファイルを開く

```vb
' 選択式
Dim filename As String
filename = Application.GetOpenFilename(FileFilter:="Excelファイル,*.xls*,CSVファイル,*.csv")

' 選択式（続き）、プログラム内 
Dim wb As Workbook
Set wb = Workbooks.Open(filename)
' 処理
wb.Close
```

# 印刷プリント

```vb
' プリンタのチェック
MsgBox Application.ActivePrinter
' プリンタの指定
Application.ActivePrinter = ""
' sheetの印刷
ActiveSheet.PrintOut
```

# シートの指定の仕方、セルの指定

```vb
Dim wb As Workbook
Dim ws As Worksheet
Set ws = wb.Sheets("SheetName")
' wsには、Sheets("SheetName")が代入されるわけではなく、
' wsには、wb.Sheets("SheetName")が代入されている。
' wb.wsとは書けない。
Debug.Print (ws.Cells(1,1).Value)
'または
Debug.Print (wb.Worksheets(ws.Name).Cells(1,1).Value)
```

# ハッシュ

```vb
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