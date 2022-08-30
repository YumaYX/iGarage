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


