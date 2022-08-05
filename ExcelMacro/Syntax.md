# Cells

```vb
Cells(Y, X)
' X, Yが逆
```

# 変数宣言

## 初期値宣言

```vb
Dim 変数名 As 型: 変数名 = 初期値
Dim 変数名 As 型: Set 変数名 = 初期値
```

## ワークブック

```vb
Dim wb as WorkBook
Set wb = Workbooks("Book1.xlsx")

Dim wb As Worksheet: Set wb = Workbooks("Book1.xlsx")
```

## シート

```vb
Dim ws As Worksheet
Set ws = Sheets("Sheet1")

Dim ws As Worksheet: Set ws = Sheets("index")
Worksheets("Sheet Name")
Sheets("Sheet Name")
```

## String

```vb
Dim str As String
Dim str As String: str = "abcd"
```

## Integer

```vb
Dim i As Long
Dim i As Integer: i = 0
```

## 配列

```vb
Dim array() As String
ReDim array(32)
array(0)= "a"
```

### 配列使い方

```vb
Dim array_index as Integer
For array_index = 0 To UBound(array)
    Cells(i + 1, 1).Value = array(array_index)
Next array_index
```

## If

```vb
If 条件 Then
    処理1
ElseIf 条件 Then
    処理2
Else
    処理3
End if
```

## 演算子

| 内容 | 記号 | 例 |
| --- | --- | --- |
| 否定 | <> | 1<>1 |
| 等価 | = | 1=1(ひとつ) |
| かつ | And | - |
| または | Or | - |

# 表示/デバッグ

| Code | Destination |
| --- | --- |
| Debug.print("a") | イミディエイトウィンドウ |
| MsgBox "b" | 新規ウィンドウ |

# Loop

for

```vb
Dim i As Integer
For i = 1 To 10
    Debug.Print(i)
Next
```

object

```vb
For Each item In Worksheets
    Debug.Print(item.Name)
Next
```

# 特殊変数

| 内容 | 変数 |
| --- | --- |
| VBAコードが記述されているブック | ThisWorkbook |
| 現在表示されているブック | ActiveWorkBook |
| 現在表示されているシート | ActiveSheet |

# 最大行最終行取得

```vb
sheet_name = "Sheet Name"
Worksheets(sheet_name).Cells(Rows.Count, 1).End(xlUp).Row
' 1列目
```

# シート名取得

```vb
Dim i As Long
For i = 1 To Worksheets.Count
    Cells(i, 1) = Worksheets(i).Name
Next
```

# File exist

```vb
Dim str As String: str = "filename"
If Dir(str) <> "" Then
    MsgBox "Exist"
Else
    MsgBox "None"
End If
```

# Open Book

## Manual

```vb
Dim strFilePath As String
strFilePath = Application.GetOpenFilename(Filefilter:="Any,*")
Workbooks.Open Filename:=strFilePath

Dim wb1
Set wb1 = ThisWorkbook ' this book
Dim FSO As Object
Set FSO = CreateObject("Scripting.FileSystemObject")
Dim wb2
Set wb2 = Workbooks(FSO.GetBaseName(strFilePath) & ".xlsx") ' another
' Processing
wb2.Close
```

## Auto(in Program)

```vb
Dim wb1
Set wb1 = ThisWorkbook
Dim wb2
Set wb2 = Workbooks.Open("Book1.xlsx")

Dim i
sheet_name = "sheet Name"
For i = 1 To wb2.Worksheets(sheet_name).Cells(Rows.Count, 1).End(xlUp).Row
    Debug.Print (wb2.Worksheets(sheet_name).Cells(i, 1).Value)
Next i
wb2.Close
```

### ファイル名指定
| 絶対パス | フルパスの場所 |
| --- | --- |
| File Name | Documents |
| 相対Path | Documentsから見て |
| Current Dir | ThisWorkbook.Path & "File Name" |

# セル内容削除

```vb
Selection.ClearContents
```

| - | - |
| --- | --- |
| All Cells | Cells.Select |
| A Column | Columns("A:A").Select |
| B2 Cells | Range("B2").Select |
