Sub CopyToClipboard()
   Dim objMail As Outlook.MailItem
   Dim doClipboard As New DataObject

   'One and ONLY one message muse be selected
   If Application.ActiveExplorer.Selection.Count <> 1 Then
       MsgBox ("Select one and ONLY one message.")
       Exit Sub
   End If

   Set objMail = Application.ActiveExplorer.Selection.Item(1)
   doClipboard.Clear
   doClipboard.SetText "outlook:" + objMail.EntryID
   doClipboard.PutInClipboard
End Sub
