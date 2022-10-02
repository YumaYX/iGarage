# Cells

```vb
Cells(Y, X)
```

## Cell

```vb
' Cell's Name => cellname
Range("cellname")
```

# Variable Declaration

## Default

```vb
Dim name As type: name = init val
Dim name As type: Set name = init val
```

## WorkBook

```vb
Dim wb as WorkBook
Set wb = Workbooks("Book1.xlsx")

Dim wb As Worksheet: Set wb = Workbooks("Book1.xlsx")
```

## Sheet

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

## Array

```vb
Dim array() As String
ReDim array(32)
array(0)= "a"
```

### Control Array

```vb
Dim array_index as Integer
For array_index = 0 To UBound(array)
    Cells(i + 1, 1).Value = array(array_index)
Next array_index
```

## If

```vb
If condition Then
    ` Processing1
ElseIf condition Then
    ` Processing2
Else
    ` Processing3
End if
```

## Comparing Operator

| meaning | operator | examle |
| --- | --- | --- |
| not | <> | 1<>1 |
| equal | = | 1=1 |
| and | And | - |
| or | Or | - |

# Display/Debug

| Code | Destination |
| --- | --- |
| Debug.print("a") | immediate windows |
| MsgBox "b" | new window |

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

# Special Variable

| target | variable |
| --- | --- |
| book | ThisWorkbook |
| active book | ActiveWorkBook |
| active sheet | ActiveSheet |

# Get Maximum Number of Last Line

```vb
sheet_name = "Sheet Name"
Worksheets(sheet_name).Cells(Rows.Count, 1).End(xlUp).Row
' 1 column
```

# Get Sheet Name

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

### Target File Name
| absolute path | location |
| --- | --- |
| File Name | Documents |
| relative path | Documents |
| Current Dir | ThisWorkbook.Path & "File Name" |

# Delete Cell Values

```vb
Selection.ClearContents
```

| - | - |
| --- | --- |
| All Cells | Cells.Select |
| A Column | Columns("A:A").Select |
| B2 Cells | Range("B2").Select |

# Print

```vb
' Check Printer
MsgBox Application.ActivePrinter
' Print Out
Application.ActivePrinter = ""
' sheet.PrintOut
ActiveSheet.PrintOut
```

# get value from key

## sheet a

| A | B |
| --- | --- |
| key1 | value1 |
| key2 | value2 |

## sheet b

| A |
| --- |
| key1 |

```vb

Dim a As Worksheet: Set a = Sheets("a")
Dim b As Worksheet: Set b = Sheets("b")

For i = 1 To a.Cells(Rows.Count, 1).End(xlUp).Row
  k = a.Cells(i, 1).Value
  For j = 1 To b.Cells(Rows.Count, 1).End(xlUp).Row
    k2 =  b.Cells(j, 1).Value
    If k = k2 Then
      Debug.Print (a.Cells(i, 2).Value)
      Exit For
    End If
  Next j
Next i

```
