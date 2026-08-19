report 55051 "HeiMatch Export Inv. & Balance"
{
    // version HEI.03,D4633,HEI.10

    // HNK 100020 Upgrade from Heilite 1.0 MRA-IBM 22/06/15
    // HEI.01 FDD RTRGAP062 Heilite BASE IBM ISYED01 04/08/2017 HeiMatch Flatfile
    //   #created new report for HEIMATCH flatfile creation
    // 
    // HEI.02 FDD RTRGAP062 IBM.NAIKH01 04.12.2017
    //   # Added code in function "InsertBuffer" to show Reporting Entity assigned to the OPCO dimension value
    // 
    // HEI.03 Defect #747 IBM NASTAA02 07.12.2017 # HeiMatch Export Inv. & Balance
    //   # Column "Partner Code" should be filled in with the "Reporting Entity" from Dimension Values
    //   # Changed Date Format for "Invoice Date"
    //   # "Local Amount" should be the "Amount (LCY)" not the "Remaining Amount"
    // 
    // HEI.04 FDD-RTRGAP072V2 IBM ISYED01 #Heimatch
    //   # Added code to retrive only open entries.
    //   #added code to use the heimatch sign added on GL card
    // 
    // Hei.05 FDD-RTRGAP072-HeiMatch Flat File V_Addendum_ BRD HB104_ Addendum to the first FDD_Final , NAIKH01
    //   # Changed the code in the report as per the new requirement
    // HEI.06  Defect 4633
    //  # Include information from company information tale "Legal entity code"
    //  # Add conditional to detect when currency is different to local and get amount in original currency
    // HEI.07 CHG0248106 IBM POENAB02 30.03.2020 # HeiMatch Export Inv. & Balance
    //  # Added code in "Integer - OnAfterGetRecord()", "InsertBuffer"
    //  # Added one more parameter to function InsertBuffer.
    //  # Added function ReplaceString.
    // HEI.08 CHG2255465 IBM YADAVM09 19/06/2024 #Change required in HeiMatch sign values in COA
    // #new options string for field HeiMatch sign
    // HEI.09 CHG2236640 IBM YADAVM09 28/08/2024 # Heimatch flatfile data gathering
    //   Code added to add open general ledger entries.# Add new data item for Specific
    //                                                 #Add visibilty condition for action PrevInvPeriodFormula
    // HEI.10 CHG2236640 IBM POENAB02 30.09.2024 # Heimatch flatfile data gathering
    //   #Modified code for Reversal entries


    //BC UPGRADE KUMARR78 >>
    // =================================================================================================
    // Object       : Report 50016 "HeiMatch Export Inv. & Balance"
    // Type         : ProcessingOnly Report
    // 1. Removed Automation Variable
    // -------------------------------------------------------------------------------------------------
    // OLD NAV CODE
    // Wshell : Automation "'{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B}' 1.0:'{72C24DD5-D70A-438B-8A42-98424B88AFB8}':''{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B}' 1.0'.WshShell";
    //
    // NEW BC SaaS CODE
    // Removed completely because Automation is not supported in Business Central SaaS.
    //
    // Reason:
    // BC SaaS does not allow COM Automation objects. The variable was not used in logic,
    // so it was removed safely without affecting report functionality.
    // 2. Removed File Datatype
    // -------------------------------------------------------------------------------------------------
    // OLD NAV CODE
    // FleHeiMatch : File;
    // ServerFileName : Text;
    //
    // NEW BC SaaS CODE
    // TempBlob : Codeunit "Temp Blob";
    // OutStr   : OutStream;
    // InStr    : InStream;
    //
    // Reason:
    // File datatype is not supported in BC SaaS because server file system access
    // is restricted. Temp Blob streaming is the recommended cloud-compatible approach.
    // 3. Replaced File Creation Logic
    // -------------------------------------------------------------------------------------------------
    // OLD NAV CODE
    // ServerFileName := FileManagement.ServerTempFileName('csv');
    // FleHeiMatch.CREATE(ServerFileName);
    // FleHeiMatch.TEXTMODE := TRUE;
    //
    // NEW BC SaaS CODE
    // TempBlob.CreateOutStream(OutStr);
    //
    // Reason:
    // SaaS environment does not allow server temporary file creation.
    // TempBlob provides in-memory stream handling for file generation.
    // 4. Replaced File Write Operation
    // -------------------------------------------------------------------------------------------------
    // OLD NAV CODE
    // FleHeiMatch.WRITE(FleRecord);
    //
    // NEW BC SaaS CODE
    // OutStr.WriteText(FleRecord + '\r\n');
    //
    // Reason:
    // Instead of writing to server file, the report writes directly to OutStream
    // which stores the file content in TempBlob.
    // 5. Removed File System Operations
    // -------------------------------------------------------------------------------------------------
    // OLD NAV CODE
    // IF EXISTS(Filename) THEN
    //   IF CONFIRM(Text003,FALSE) THEN ERASE(Filename);
    //
    // NEW BC SaaS CODE
    // Removed.
    //
    // Reason:
    // SaaS environment does not allow checking or deleting files on server.
    // 6. Replaced File Download Method
    // -------------------------------------------------------------------------------------------------
    // OLD NAV CODE
    // FleHeiMatch.CLOSE;
    // FileManagement.DownloadToFile(ServerFileName, Filename);
    //
    // NEW BC SaaS CODE
    // TempBlob.CreateInStream(InStr);
    // DownloadFromStream(
    //      InStr,
    //      'HeiMatch Export',
    //      '',
    //      'CSV File (*.csv)|*.csv',
    //      Filename);
    //
    // Reason:
    // DownloadFromStream is the supported SaaS method to allow users
    // to download generated files directly through the browser.
    // 7. Removed SaveFileDialog Usage
    // -------------------------------------------------------------------------------------------------
    // OLD NAV CODE
    // Filename := FileManagement.SaveFileDialog(Text002,Filename,Text600);
    //
    // NEW BC SaaS CODE
    // Filename := 'HeiMatchExport.csv';
    //
    // Reason:
    // Browser-based SaaS environment controls download location.
    // File path dialogs are not supported.
    //BC UPGRADE KUMARR78 <<

    // BC Upgrade POENAB02, 14.03.2025, gap "PID-477 RTR102-Creation of HeiMatch flat file"

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis; //BC UPGRADE KUMARR78 Adding UsageCategory

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord();
            var
                Found: Boolean;
                FoundDCLEorDVLE: Boolean;
                GLEntryShouldBeSkipped: Boolean;
                Searched: Boolean;
            begin
                //HEI.09>>
                if Calcfilter = Calcfilter::Specific then
                    CurrReport.Skip();
                //HEI.09<<
                TCounter[1] := GLAcc.Count;
                if GLAcc.FindSet() then
                    repeat
                        Counter[1] += 1;
                        //IF FORMAT(PrevInvPeriodFormula) <> '' THEN //NAIKh01 5th July
                        /*
                      WITH GLEntryBefore DO BEGIN
                          SETRANGE("G/L Account No.",GLAcc."No.");
                          SETFILTER("Bal. Account Type",'<>%1&<>%2',"Bal. Account Type"::Vendor,"Bal. Account Type"::Customer);
                          //HEI.04>>
                          GLEntryBefore.SETRANGE(Open,TRUE);
                          //HEI.04>>

                          IF FINDSET THEN BEGIN
                            TCounter[1] += COUNT;
                            REPEAT
                              Counter[1] += 1;
                              Win.UPDATE(1,ROUND((Counter[1]/TCounter[1])*10000,1));
                              Found := FALSE;
                              CASE "Source Type" OF
                                "Source Type"::Customer:
                                  BEGIN
                                    CustLedgEntryBefore.SETRANGE("Customer No.","Source No.");
                                    CustLedgEntryBefore.SETRANGE("Posting Date","Posting Date");
                                    IF IncludeOnlyOpen THEN
                                      CustLedgEntryBefore.SETRANGE(Open,TRUE);
                                    CustLedgEntryBefore.SETRANGE("Document No.","Document No.");
                                    CustLedgEntryBefore.SETRANGE("Document Type","Document Type");
                                    CustLedgEntryBefore.SETRANGE("Transaction No.","Transaction No.");
                                    Found := NOT CustLedgEntryBefore.ISEMPTY;
                                    IF Found THEN
                                      CustLedgEntryBefore.CALCFIELDS(CustLedgEntryBefore."Remaining Amt. (LCY)");
                                  END;
                                "Source Type"::Vendor:
                                  BEGIN
                                    VendLedgEntryBefore.SETRANGE("Document No.","Document No.");
                                    VendLedgEntryBefore.SETRANGE("Document Type","Document Type");
                                    VendLedgEntryBefore.SETRANGE("Vendor No.","Source No.");
                                    VendLedgEntryBefore.SETRANGE("Posting Date","Posting Date");
                                    //HEI.04>>
                                    IF IncludeOnlyOpen THEN
                                      VendLedgEntryBefore.SETRANGE(Open,TRUE);
                                    //HEI.04>>
                                    VendLedgEntryBefore.SETRANGE("Transaction No.","Transaction No.");
                                    Found := NOT VendLedgEntryBefore.ISEMPTY;
                                    IF Found THEN
                                      VendLedgEntryBefore.CALCFIELDS(VendLedgEntryBefore."Remaining Amt. (LCY)");
                                  END;
                              END;
                              IF Found THEN
                               InsertBuffer(TempBuffer,GLEntryBefore);
                            UNTIL NEXT = 0;
                          END ELSE
                            Win.UPDATE(1,ROUND((Counter[1]/TCounter[1])*10000,1));
                        END;
                        */
                        /*
                        //HEI.04>>
                        IF IncludeOnlyOpen THEN
                          GLEntry.SETRANGE(Open,TRUE);
                        //HEI.04<<
                        */
                        //NAIKH01 19 Feb
                        //HEI.04>>
                        if IncludeOnlyOpen then
                            GLEntry.SetRange("Open FND", true);
                        //HEI.04<<
                        GLEntry.SetRange("G/L Account No.", GLAcc."No.");
                        //HEI.07>>
                        /*
                        SETFILTER("Bal. Account Type",'<>%1&<>%2',"Bal. Account Type"::Vendor,"Bal. Account Type"::Customer);
                        IF NOT GLAcc."Export HeiMatch Payments" THEN
                          SETFILTER("Bal. Account Type",'<>%1&<>%2&<>%3',"Bal. Account Type"::"Bank Account","Bal. Account Type"::Vendor,
                                  "Bal. Account Type"::Customer);
                        */
                        //HEI.07<<
                        if GLEntry.FindSet() then begin

                            TCounter[1] += GLEntry.Count;
                            repeat
                                //HEI.07>>
                                DCLEorDVLEexists := false;
                                GLEntryShouldBeSkipped := false;
                                //HEI.07<<
                                Counter[1] += 1;
                                Win.Update(1, Round((Counter[1] / TCounter[1]) * 10000, 1));
                                //NAIKH01 17th June
                                LedEntryNo := 0;
                                LedgerAmt := 0.0;
                                LedgerAmtLCY := 0.0;
                                Found1 := true;
                                case GLEntry."Source Type" of
                                    GLEntry."Source Type"::Customer:
                                        begin
                                            //HEI.07>>
                                            FoundDCLEorDVLE := false;
                                            //HEI.07<<
                                            DetailedCustLedgEntry.Reset();
                                            DetailedCustLedgEntry.SetRange("Document No.", GLEntry."Document No.");
                                            DetailedCustLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
                                            //HEI.07>>
                                            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", GLEntry."Entry No.");
                                            //HEI.07<<
                                            if DetailedCustLedgEntry.FindFirst() then begin
                                                DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::"Initial Entry");
                                                if DetailedCustLedgEntry.FindFirst() then
                                                    LedEntryNo := DetailedCustLedgEntry."Cust. Ledger Entry No."
                                                else
                                                    Found1 := false;
                                            end;
                                            //HEI.07>>
                                            if DetailedCustLedgEntry.IsEmpty then
                                                FoundDCLEorDVLE := true;
                                            //HEI.07<<
                                            if not DetailedCustLedgEntry.IsEmpty then
                                                DetailedCustLedgEntry.Reset();
                                            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", LedEntryNo);
                                            //HEI.07>>
                                            DetailedCustLedgEntry.SetFilter("Posting Date", Datefilter);
                                            //HEI.07<<
                                            if DetailedCustLedgEntry.FindSet() then
                                                repeat
                                                    LedgerAmt += DetailedCustLedgEntry.Amount;
                                                    LedgerAmtLCY += DetailedCustLedgEntry."Amount (LCY)";
                                                    //HEI.07>>
                                                    DCLEorDVLEexists := true;
                                                //HEI.07<<
                                                until DetailedCustLedgEntry.Next() = 0;
                                            //HEI.07>>
                                            if DetailedCustLedgEntry.IsEmpty then begin
                                                DetailedCustLedgEntry.Reset();
                                                DetailedCustLedgEntry.SetRange("Entry No.", GLEntry."CV Detailed Entry No. FND");
                                                if DetailedCustLedgEntry.FindFirst() then
                                                    GLEntryShouldBeSkipped := true;
                                            end;
                                            //HEI.07<<
                                        end;
                                    GLEntry."Source Type"::Vendor:
                                        begin
                                            DetailedVendorLedgEntry.Reset();
                                            DetailedVendorLedgEntry.SetRange("Document No.", GLEntry."Document No.");
                                            DetailedVendorLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
                                            //HEI.07>>
                                            DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", GLEntry."Entry No.");
                                            //HEI.07<<
                                            if DetailedVendorLedgEntry.FindFirst() then begin
                                                DetailedVendorLedgEntry.SetRange("Entry Type", DetailedVendorLedgEntry."Entry Type"::"Initial Entry");
                                                if DetailedVendorLedgEntry.FindFirst() then
                                                    LedEntryNo := DetailedVendorLedgEntry."Vendor Ledger Entry No."
                                                else
                                                    Found1 := false;
                                            end;

                                            if not DetailedVendorLedgEntry.IsEmpty then
                                                DetailedVendorLedgEntry.Reset();
                                            DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", LedEntryNo);
                                            //HEI.07>>
                                            DetailedVendorLedgEntry.SetFilter("Posting Date", Datefilter);
                                            //HEI.07<<
                                            if DetailedVendorLedgEntry.FindSet() then
                                                repeat
                                                    LedgerAmt += DetailedVendorLedgEntry.Amount;
                                                    LedgerAmtLCY += DetailedVendorLedgEntry."Amount (LCY)";
                                                    //HEI.07>>
                                                    DCLEorDVLEexists := true;
                                                //HEI.07<<
                                                until DetailedVendorLedgEntry.Next() = 0;
                                            //HEI.07>>
                                            if DetailedVendorLedgEntry.IsEmpty then begin
                                                DetailedVendorLedgEntry.Reset();
                                                DetailedVendorLedgEntry.SetRange("Entry No.", GLEntry."CV Detailed Entry No. FND");
                                                if DetailedVendorLedgEntry.FindFirst() then
                                                    GLEntryShouldBeSkipped := true;
                                            end;
                                            //HEI.07<<
                                        end;

                                    GLEntry."Source Type"::" ", GLEntry."Source Type"::"Fixed Asset", GLEntry."Source Type"::"Bank Account":
                                        begin
                                            DetailedCustLedgEntry.Reset();
                                            DetailedCustLedgEntry.SetRange("Document No.", GLEntry."Document No.");
                                            DetailedCustLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
                                            //HEI.07>>
                                            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", GLEntry."Entry No.");
                                            //HEI.07<<
                                            if DetailedCustLedgEntry.FindFirst() then begin
                                                DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::"Initial Entry");
                                                if DetailedCustLedgEntry.FindFirst() then
                                                    LedEntryNo := DetailedCustLedgEntry."Cust. Ledger Entry No."
                                                else
                                                    Found1 := false;
                                            end;

                                            if not DetailedCustLedgEntry.IsEmpty then
                                                DetailedCustLedgEntry.Reset();
                                            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", LedEntryNo);
                                            //HEI.07>>
                                            DetailedCustLedgEntry.SetFilter("Posting Date", Datefilter);
                                            //HEI.07<<
                                            if DetailedCustLedgEntry.FindSet() then
                                                repeat
                                                    LedgerAmt += DetailedCustLedgEntry.Amount;
                                                    LedgerAmtLCY += DetailedCustLedgEntry."Amount (LCY)";
                                                    //HEI.07>>
                                                    DCLEorDVLEexists := true;
                                                //HEI.07<<
                                                until DetailedCustLedgEntry.Next() = 0;

                                            DetailedVendorLedgEntry.Reset();
                                            DetailedVendorLedgEntry.SetRange("Document No.", GLEntry."Document No.");
                                            DetailedVendorLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
                                            //HEI.07>>
                                            DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", GLEntry."Entry No.");
                                            //HEI.07<<
                                            if DetailedVendorLedgEntry.FindFirst() then begin
                                                DetailedVendorLedgEntry.SetRange("Entry Type", DetailedVendorLedgEntry."Entry Type"::"Initial Entry");
                                                if DetailedVendorLedgEntry.FindFirst() then
                                                    LedEntryNo := DetailedVendorLedgEntry."Vendor Ledger Entry No."
                                                else
                                                    Found1 := false;
                                            end;

                                            if not DetailedVendorLedgEntry.IsEmpty then
                                                DetailedVendorLedgEntry.Reset();
                                            DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", LedEntryNo);
                                            //HEI.07>>
                                            DetailedVendorLedgEntry.SetFilter("Posting Date", Datefilter);
                                            //HEI.07<<
                                            if DetailedVendorLedgEntry.FindSet() then
                                                repeat
                                                    LedgerAmt += DetailedVendorLedgEntry.Amount;
                                                    LedgerAmtLCY += DetailedVendorLedgEntry."Amount (LCY)";
                                                    //HEI.07>>
                                                    DCLEorDVLEexists := true;
                                                //HEI.07<<
                                                until DetailedVendorLedgEntry.Next() = 0;
                                            //HEI.07>>
                                            if DetailedCustLedgEntry.IsEmpty and DetailedVendorLedgEntry.IsEmpty then begin
                                                DetailedCustLedgEntry.Reset();
                                                DetailedCustLedgEntry.SetRange("Entry No.", GLEntry."CV Detailed Entry No. FND");
                                                if DetailedCustLedgEntry.FindFirst() then
                                                    GLEntryShouldBeSkipped := true;

                                                DetailedVendorLedgEntry.Reset();
                                                DetailedVendorLedgEntry.SetRange("Entry No.", GLEntry."CV Detailed Entry No. FND");
                                                if DetailedVendorLedgEntry.FindFirst() then
                                                    GLEntryShouldBeSkipped := true;
                                            end;
                                            //HEI.07<<
                                        end;
                                end;
                                //HEI.07>>
                                //IF Found1 THEN
                                if Found1 and (GLEntryShouldBeSkipped = false) then
                                    //HEI.07<<
                                    //>>NAIKH01 17th June
                                    //HEI.07>>
                                    //InsertBuffer(TempBuffer,GLEntry);
                                    InsertBuffer(TempBuffer, GLEntry, DCLEorDVLEexists);
                            //HEI.07<<
                            until GLEntry.Next() = 0;
                        end else
                            Win.Update(1, Round((Counter[1] / TCounter[1]) * 10000, 1));
                    until GLAcc.Next() = 0;

                TempBuffer.Reset();
                if TempBuffer.IsEmpty then
                    Error(Text010);

                if TempBuffer.FindSet() then begin
                    TCounter[2] := TempBuffer.Count;
                    //BC UPGRADE KUMARR78 >> Blocking to Replace
                    // ServerFileName := FileManagement.ServerTempFileName('csv');
                    // FleHeiMatch.CREATE(ServerFileName);
                    // FleHeiMatch.TEXTMODE := true;
                    //BC UPGRADE KUMARR78 << Blocking to Replace
                    // BC Upgrade POENAB02, 14.03.2025 >>
                    //TempBlob.CreateOutStream(OutStr); //BC UPGRADE KUMARR78 ++
                    TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
                    // BC Upgrade POENAB02, 14.03.2025 <<
                    // header
                    FleRecord := TempBuffer.FieldCaption("Reporting Entity") + Format(TabChar);
                    if ExportDataType = ExportDataType::"Invoice Reference" then
                        FleRecord += TempBuffer.FieldCaption("Invoice Reference") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Period Code") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Partner Code") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Account No.") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Currency Code") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption(Amount) + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Local Currency Code") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Amount (LCY)") + Format(TabChar);
                    if ExportDataType = ExportDataType::"Invoice Reference" then
                        FleRecord += TempBuffer.FieldCaption("Invoice Comment") + Format(TabChar)
                    else
                        FleRecord += TempBuffer.FieldCaption("Balance Comment") + Format(TabChar);

                    if ExportDataType = ExportDataType::"Invoice Reference" then begin
                        FleRecord += TempBuffer.FieldCaption("Invoice Document Date") + Format(TabChar);
                        FleRecord += TempBuffer.FieldCaption("Local Company Code");
                    end;
                    // FleHeiMatch.WRITE(FleRecord);//BC UPGRADE KUMARR78 --
                    // BC Upgrade POENAB02, 14.03.2025 >>
                    //OutStr.WriteText(FleRecord + '\r\n'); //BC UPGRADE KUMARR78 ++
                    OutStr.WriteText(FleRecord);
                    OutStr.WriteText();
                    // BC Upgrade POENAB02, 14.03.2025 <<
                    // lines
                    repeat
                        Counter[2] += 1;
                        Win.Update(2, Round((Counter[2] / TCounter[2]) * 10000, 1));
                        FleRecord := TempBuffer."Reporting Entity" + Format(TabChar);
                        if ExportDataType = ExportDataType::"Invoice Reference" then
                            FleRecord += TempBuffer."Invoice Reference" + Format(TabChar);
                        FleRecord += TempBuffer."Period Code" + Format(TabChar);
                        FleRecord += TempBuffer."Partner Code" + Format(TabChar);
                        FleRecord += TempBuffer."Account No." + Format(TabChar);
                        FleRecord += TempBuffer."Currency Code" + Format(TabChar);
                        //NAIKH01 25 Feb
                        //HEI.08 commented no longer needed since the options string for HeiMatch sign "Positive"(1) and "Negative"(2) are removed>>
                        /*IF "Remaining Amt. (LCY)" = 1 THEN
                        BEGIN
                          IF Amount < 0 THEN
                            Amount := ABS(Amount);

                          IF "Amount (LCY)" < 0 THEN
                            "Amount (LCY)" :=ABS("Amount (LCY)")
                        END;
                        IF "Remaining Amt. (LCY)" = 2 THEN BEGIN
                          IF Amount > 0 THEN
                            Amount := -Amount;
                          IF "Amount (LCY)" > 0 THEN
                          "Amount (LCY)" := -"Amount (LCY)";
                        END;*/
                        //HEI.08 commented no longer needed since the options string for HeiMatch sign "Positive"(1) and "Negative"(2) are removed>>
                        if TempBuffer."Remaining Amt. (LCY)" = 3 then begin
                            ChkAmt := false;
                            ChkAmtLCY := false;

                            if (TempBuffer.Amount < 0) and (not ChkAmt) then begin
                                TempBuffer.Amount := Abs(TempBuffer.Amount);
                                ChkAmt := true;
                            end;

                            if (TempBuffer."Amount (LCY)" < 0) and (not ChkAmtLCY) then begin
                                TempBuffer."Amount (LCY)" := Abs(TempBuffer."Amount (LCY)");
                                ChkAmtLCY := true;
                            end;

                            if (TempBuffer.Amount > 0) and (not ChkAmt) then begin
                                TempBuffer.Amount := -TempBuffer.Amount;
                                ChkAmt := true;
                            end;

                            if (TempBuffer."Amount (LCY)" > 0) and (not ChkAmtLCY) then begin
                                TempBuffer."Amount (LCY)" := -TempBuffer."Amount (LCY)";
                                ChkAmtLCY := true;
                            end;
                        end;
                        //NAIKH01 25 Feb
                        FleRecord += Format(Round(TempBuffer.Amount, 0.01), 0, '<Precision,2:2><Standard Format,1>') + Format(TabChar);
                        FleRecord += TempBuffer."Local Currency Code" + Format(TabChar);
                        FleRecord += Format(Round(TempBuffer."Amount (LCY)", 0.01), 0, '<Precision,2:2><Standard Format,1>') + Format(TabChar);
                        if ExportDataType = ExportDataType::"Invoice Reference" then
                            //HEI.07>>
                            //FleRecord += "Invoice Comment" + FORMAT(TabChar)
                            FleRecord += ReplaceString(TempBuffer."Invoice Comment", ',', '') + Format(TabChar)
                        //HEI.07<<
                        else
                            //HEI.07>>
                            //FleRecord += "Balance Comment";
                            FleRecord += ReplaceString(TempBuffer."Balance Comment", ',', '');
                        //HEI.07<<
                        if ExportDataType = ExportDataType::"Invoice Reference" then begin
                            if UseRegionalSettings then
                                FleRecord += Format(TempBuffer."Invoice Document Date", 0, 1) + Format(TabChar)
                            else
                                FleRecord += Format(TempBuffer."Invoice Document Date", 0, Text501) + Format(TabChar);
                            FleRecord += TempBuffer."Local Company Code";
                        end;
                        // FleHeiMatch.WRITE(FleRecord);//BC UPGRADE KUMARR78 --
                        // BC Upgrade POENAB02, 14.03.2025 >>
                        //OutStr.WriteText(FleRecord + '\r\n'); //BC UPGRADE KUMARR78 ++
                        OutStr.WriteText(FleRecord);
                        OutStr.WriteText();
                    // BC Upgrade POENAB02, 14.03.2025 <<
                    until TempBuffer.Next() = 0;
                    //BC UPGRADE KUMARR78 >> Blocking
                    // FleHeiMatch.CLOSE;
                    // FileManagement.DownloadToFile(ServerFileName, Filename);
                    //BC UPGRADE KUMARR78 << Blocking
                    //BC UPGRADE KUMARR78 >> Replacing Onprem Code with Saas Code
                    TempBlob.CreateInStream(InStr);

                    DownloadFromStream(
                        InStr,
                        'HeiMatch Export',
                        '',
                        'CSV File (*.csv)|*.csv',
                        Filename);
                    //BC UPGRADE KUMARR78 << Replacing Onprem Code with Saas Code
                end;

            end;

            trigger OnPostDataItem();
            begin
                //HEI.09>>
                if Calcfilter = Calcfilter::Specific then
                    CurrReport.Skip();
                //HEI.09<<
                Win.Close();
                //BC UPGRADE KUMARR78 >> Exists Not Allowed in Saas
                // if EXISTS(Filename) then
                //     Message(Text005, Filename);
                //BC UPGRADE KUMARR78 << Exists Not Allowed in Saas

            end;

            trigger OnPreDataItem();
            begin
                //HEI.09>>
                if Calcfilter = Calcfilter::Specific then
                    CurrReport.Skip();
                //HEI.09<<
                if Filename = '' then Error(Text001);

                //BC UPGRADE KUMARR78 >> Exists Not Allowed in Saas
                // if EXISTS(Filename) then
                //     if Confirm(Text003, false) then ERASE(Filename);
                //BC UPGRADE KUMARR78 << Exists Not Allowed in Saas

                TabChar := ';';
                CheckPrevInvPeriodFormula();

                GLSetup.Get();
                GLSetup.TestField("OPCO Dimension Code FND");

                Win.Open(Text300 + Text301);
                Clear(TCounter);
                Clear(Counter);

                CustLedgEntryBefore.Reset();
                CustLedgEntryBefore.SetCurrentKey("Customer No.", "Posting Date", "Document No.", Open);
                VendLedgEntryBefore.Reset();
                VendLedgEntryBefore.SetCurrentKey("Document No.", "Document Type", "Vendor No.");

                GLEntry.Reset();
                GLEntry.SetCurrentKey(
                  "Posting Date", "Document No.", "External Document No.",
                  "Global Dimension 1 Code", "Global Dimension 2 Code", "G/L Account No.", "Currency Code FND");

                GLEntryBefore.Reset();
                GLEntryBefore.Copy(GLEntry);
                GLEntry.SetFilter("Posting Date", '(' + Datefilter + ')&<=%1', NewEndingDate); //NAIKH01 New

                //IF USERID = 'HEIWAY\POENAB02' THEN
                //  MESSAGE('%1 - %2',Datefilter,NewEndingDate);

                PrevInvPeriodStartDate := CalcPrevInvPeriodDate();
                if (Format(PrevInvPeriodFormula) <> '') and (PrevInvPeriodStartDate <> 0D) then begin
                    //HEI.04>>
                    if IncludeOnlyOpen then
                        GLEntryBefore.SetRange("Open FND", true);
                    //HEI.04>>
                    GLEntryBefore.SetRange("Posting Date", PrevInvPeriodStartDate, CalcDate('<-1D>', StartingDatePeriod));
                    GLEntryBefore.SetFilter("Document Type", '%1|%2|%3', GLEntryBefore."Document Type"::" ", GLEntryBefore."Document Type"::Invoice, GLEntryBefore."Document Type"::"Credit Memo");
                    GLEntryBefore.SetFilter("Source Type", '%1|%2',
                      GLEntryBefore."Source Type"::Customer, GLEntryBefore."Source Type"::Vendor);
                end else begin
                    GLEntryBefore.Reset();
                    GLEntryBefore.SetRange("Open FND", true);
                    GLEntryBefore.SetRange("Entry No.", 0);
                end;
                UseGlobalDimAsFilter :=
                  (GLSetup."OPCO Dimension Code FND" = GLSetup."Global Dimension 1 Code") or
                  (GLSetup."Global Dimension 2 Code" = GLSetup."OPCO Dimension Code FND");
                if GLEntry.IsEmpty and GLEntryBefore.IsEmpty then
                    Error(Text010);

                GLAcc.SetFilter("HeiMatch Code FND", '<>%1', '');
                if GLAcc.IsEmpty then
                    Error(Text011, GLAcc.FieldCaption("HeiMatch Code FND"), GLAcc.TableCaption);

                CompInfo.Get();
                CompInfo.TestField("Reporting Entity FND");
                Clear(TempBuffer);
                TempBuffer.DeleteAll();
            end;
        }
        dataitem("<Integer1>"; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = const(1));

            trigger OnAfterGetRecord();
            var
                DetailedCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
                DetailedVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
                balancesheet: Boolean;
                FoundDCLEorDVLE: Boolean;
                GLEntryShouldBeSkipped: Boolean;
                DCustAmount: Decimal;
                DVendAmount: Decimal;
                CustLedgerEntryNo: Integer;
                VendLedgerEntryNo: Integer;
            begin
                //HEI.09>>
                if Calcfilter <> Calcfilter::Specific then
                    CurrReport.Skip();
                TCounter[1] := GLAcc.Count;
                if GLAcc.FindSet(false) then
                    repeat
                        Counter[1] += 1;
                        GLEntry.SetRange("G/L Account No.", GLAcc."No.");
                        //IF Calcfilter = Calcfilter::Specific THEN BEGIN //HEI.10
                        if GLAcc."Income/Balance" = GLAcc."Income/Balance"::"Balance Sheet" then begin
                            GLEntry.SetRange("Posting Date", 0D, NewEndingDate);
                            GLEntry.SetRange("Open FND", true);
                        end else
                           //HEI.10>>
                           //SETRANGE("Posting Date",NewStartingDatePeriod,NewEndingDate);
                           begin
                            GLEntry.SetRange("Posting Date", NewStartingDatePeriod, NewEndingDate);
                            GLEntry.SetFilter("Open FND", '%1|%2', true, false);
                        end;
                        //HEI.10<<
                        //END; //HEI.10
                        if GLAcc."Income/Balance" = GLAcc."Income/Balance"::"Balance Sheet" then
                            balancesheet := true
                        else
                            balancesheet := false;

                        if GLEntry.FindSet(false) then begin
                            TCounter[1] += GLEntry.Count;
                            repeat
                                DCLEorDVLEexists := false;
                                GLEntryShouldBeSkipped := false;
                                Counter[1] += 1;
                                Win.Update(1, Round((Counter[1] / TCounter[1]) * 10000, 1));
                                LedEntryNo := 0;
                                DCustAmount := 0.0;
                                DVendAmount := 0.0;
                                LedgerAmt := 0.0;
                                LedgerAmtLCY := 0.0;
                                Found1 := true;
                                case GLEntry."Source Type" of
                                    GLEntry."Source Type"::Customer:
                                        begin
                                            Clear(CustLedgerEntryNo);
                                            if balancesheet then begin
                                                DetailedCustLedgEntry1.Reset();
                                                DetailedCustLedgEntry1.SetRange("Document No.", GLEntry."Document No.");
                                                DetailedCustLedgEntry1.SetRange("Posting Date", 0D, NewEndingDate);
                                                DetailedCustLedgEntry1.SetRange("Cust. Ledger Entry No.", GLEntry."Entry No.");
                                                if DetailedCustLedgEntry1.FindSet(false) then begin
                                                    DetailedCustLedgEntry1.CalcSums(Amount);
                                                    DCustAmount := DetailedCustLedgEntry1.Amount;
                                                    if DCustAmount <> 0 then
                                                        CustLedgerEntryNo := DetailedCustLedgEntry1."Cust. Ledger Entry No."
                                                    else
                                                        Found1 := false;
                                                end;
                                            end;
                                            FoundDCLEorDVLE := false;
                                            DetailedCustLedgEntry.Reset();
                                            DetailedCustLedgEntry.SetRange("Document No.", GLEntry."Document No.");
                                            //HEI.10>>
                                            //DetailedCustLedgEntry.SETRANGE("Posting Date",GLEntry."Posting Date");
                                            if balancesheet then
                                                DetailedCustLedgEntry.SetRange("Posting Date", GLEntry."Posting Date")
                                            else begin
                                                if GLEntry."Source Code" <> SourceCodeSetup.Reversal then
                                                    DetailedCustLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
                                            end;
                                            //HEI.10<<
                                            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", GLEntry."Entry No.");
                                            if DetailedCustLedgEntry.FindFirst() then begin
                                                DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::"Initial Entry");
                                                if DetailedCustLedgEntry.FindFirst() then
                                                    LedEntryNo := DetailedCustLedgEntry."Cust. Ledger Entry No."
                                                else
                                                    Found1 := false;
                                            end;
                                            if DetailedCustLedgEntry.IsEmpty then
                                                FoundDCLEorDVLE := true;

                                            if not DetailedCustLedgEntry.IsEmpty then
                                                DetailedCustLedgEntry.Reset();
                                            if not balancesheet then
                                                DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", LedEntryNo)
                                            else
                                                DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgerEntryNo);
                                            if not balancesheet then
                                                DetailedCustLedgEntry.SetFilter("Posting Date", Datefilter)
                                            else
                                                DetailedCustLedgEntry.SetRange("Posting Date", 0D, NewEndingDate);
                                            if DetailedCustLedgEntry.FindSet(false) then
                                                repeat
                                                    LedgerAmt += DetailedCustLedgEntry.Amount;
                                                    LedgerAmtLCY += DetailedCustLedgEntry."Amount (LCY)";
                                                    DCLEorDVLEexists := true;
                                                until DetailedCustLedgEntry.Next() = 0
                                            //HEI.10>>
                                            else begin
                                                if GLEntry."Source Currency Amount" <> 0 then begin
                                                    LedgerAmt += GLEntry."Source Currency Amount";
                                                    LedgerAmtLCY += GLEntry.Amount;
                                                end;
                                                if GLEntry."Source Currency Amount" = 0 then begin
                                                    LedgerAmt += GLEntry.Amount;
                                                    LedgerAmtLCY += GLEntry.Amount;
                                                end;
                                            end;
                                            //HEI.10<<
                                            if DetailedCustLedgEntry.IsEmpty then begin
                                                DetailedCustLedgEntry.Reset();
                                                DetailedCustLedgEntry.SetRange("Entry No.", GLEntry."CV Detailed Entry No. FND");
                                                if DetailedCustLedgEntry.FindFirst() then
                                                    GLEntryShouldBeSkipped := true;
                                            end;
                                        end;
                                    GLEntry."Source Type"::Vendor:
                                        begin
                                            Clear(VendLedgerEntryNo);
                                            if balancesheet then begin
                                                DetailedVendLedgEntry1.Reset();
                                                DetailedVendLedgEntry1.SetRange("Document No.", GLEntry."Document No.");
                                                DetailedVendLedgEntry1.SetRange("Posting Date", 0D, NewEndingDate);
                                                DetailedVendLedgEntry1.SetRange("Vendor Ledger Entry No.", GLEntry."Entry No.");
                                                if DetailedVendLedgEntry1.FindSet(false) then begin
                                                    DetailedVendLedgEntry1.CalcSums(Amount);
                                                    DVendAmount := DetailedVendLedgEntry1.Amount;
                                                    if DVendAmount <> 0 then
                                                        VendLedgerEntryNo := DetailedVendLedgEntry1."Vendor Ledger Entry No."
                                                    else
                                                        Found1 := false;
                                                end;
                                            end;

                                            DetailedVendorLedgEntry.Reset();
                                            DetailedVendorLedgEntry.SetRange("Document No.", GLEntry."Document No.");
                                            //HEI.10>>
                                            //DetailedVendorLedgEntry.SETRANGE("Posting Date",GLEntry."Posting Date");
                                            if balancesheet then
                                                DetailedVendorLedgEntry.SetRange("Posting Date", GLEntry."Posting Date")
                                            else begin
                                                if GLEntry."Source Code" <> SourceCodeSetup.Reversal then
                                                    DetailedVendorLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
                                            end;
                                            //HEI.10<<
                                            DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", GLEntry."Entry No.");
                                            if DetailedVendorLedgEntry.FindFirst() then begin
                                                DetailedVendorLedgEntry.SetRange("Entry Type", DetailedVendorLedgEntry."Entry Type"::"Initial Entry");
                                                if DetailedVendorLedgEntry.FindFirst() then
                                                    LedEntryNo := DetailedVendorLedgEntry."Vendor Ledger Entry No."
                                                else
                                                    Found1 := false;
                                            end;

                                            if not DetailedVendorLedgEntry.IsEmpty then
                                                DetailedVendorLedgEntry.Reset();
                                            if not balancesheet then
                                                DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", LedEntryNo)
                                            else
                                                DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", VendLedgerEntryNo);
                                            if not balancesheet then
                                                DetailedVendorLedgEntry.SetFilter("Posting Date", Datefilter)
                                            else
                                                DetailedVendorLedgEntry.SetRange("Posting Date", 0D, NewEndingDate);
                                            if DetailedVendorLedgEntry.FindSet(false) then
                                                repeat
                                                    LedgerAmt += DetailedVendorLedgEntry.Amount;
                                                    LedgerAmtLCY += DetailedVendorLedgEntry."Amount (LCY)";
                                                    DCLEorDVLEexists := true;
                                                until DetailedVendorLedgEntry.Next() = 0
                                            //HEI.10>>
                                            else begin
                                                if GLEntry."Source Currency Amount" <> 0 then begin
                                                    LedgerAmt += GLEntry."Source Currency Amount";
                                                    LedgerAmtLCY += GLEntry.Amount;
                                                end;
                                                if GLEntry."Source Currency Amount" = 0 then begin
                                                    LedgerAmt += GLEntry.Amount;
                                                    LedgerAmtLCY += GLEntry.Amount;
                                                end;
                                            end;
                                            //HEI.10<<
                                            if DetailedVendorLedgEntry.IsEmpty then begin
                                                DetailedVendorLedgEntry.Reset();
                                                DetailedVendorLedgEntry.SetRange("Entry No.", GLEntry."CV Detailed Entry No. FND");
                                                if DetailedVendorLedgEntry.FindFirst() then
                                                    GLEntryShouldBeSkipped := true;
                                            end;
                                        end;

                                    GLEntry."Source Type"::" ", GLEntry."Source Type"::"Fixed Asset", GLEntry."Source Type"::"Bank Account":
                                        begin
                                            DetailedCustLedgEntry.Reset();
                                            DetailedCustLedgEntry.SetRange("Document No.", GLEntry."Document No.");
                                            DetailedCustLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
                                            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", GLEntry."Entry No.");
                                            if DetailedCustLedgEntry.FindFirst() then begin
                                                DetailedCustLedgEntry.SetRange("Entry Type", DetailedCustLedgEntry."Entry Type"::"Initial Entry");
                                                if DetailedCustLedgEntry.FindFirst() then
                                                    LedEntryNo := DetailedCustLedgEntry."Cust. Ledger Entry No."
                                                else
                                                    Found1 := false;
                                            end;

                                            if not DetailedCustLedgEntry.IsEmpty then
                                                DetailedCustLedgEntry.Reset();
                                            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", LedEntryNo);
                                            //HEI.10>>
                                            //DetailedCustLedgEntry.SETFILTER("Posting Date",Datefilter);
                                            if balancesheet then
                                                DetailedCustLedgEntry.SetRange("Posting Date", GLEntry."Posting Date")
                                            else begin
                                                if GLEntry."Source Code" <> SourceCodeSetup.Reversal then
                                                    DetailedCustLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
                                            end;
                                            //HEI.10<<
                                            if DetailedCustLedgEntry.FindSet(false) then
                                                repeat
                                                    LedgerAmt += DetailedCustLedgEntry.Amount;
                                                    LedgerAmtLCY += DetailedCustLedgEntry."Amount (LCY)";
                                                    DCLEorDVLEexists := true;
                                                until DetailedCustLedgEntry.Next() = 0;

                                            DetailedVendorLedgEntry.Reset();
                                            DetailedVendorLedgEntry.SetRange("Document No.", GLEntry."Document No.");
                                            //HEI.10>>
                                            //DetailedVendorLedgEntry.SETRANGE("Posting Date",GLEntry."Posting Date");
                                            if balancesheet then
                                                DetailedVendorLedgEntry.SetRange("Posting Date", GLEntry."Posting Date")
                                            else begin
                                                if GLEntry."Source Code" <> SourceCodeSetup.Reversal then
                                                    DetailedVendorLedgEntry.SetRange("Posting Date", GLEntry."Posting Date");
                                            end;
                                            //HEI.10<<
                                            DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", GLEntry."Entry No.");
                                            if DetailedVendorLedgEntry.FindFirst() then begin
                                                DetailedVendorLedgEntry.SetRange("Entry Type", DetailedVendorLedgEntry."Entry Type"::"Initial Entry");
                                                if DetailedVendorLedgEntry.FindFirst() then
                                                    LedEntryNo := DetailedVendorLedgEntry."Vendor Ledger Entry No."
                                                else
                                                    Found1 := false;
                                            end;

                                            if not DetailedVendorLedgEntry.IsEmpty then
                                                DetailedVendorLedgEntry.Reset();
                                            DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.", LedEntryNo);
                                            DetailedVendorLedgEntry.SetFilter("Posting Date", Datefilter);
                                            if DetailedVendorLedgEntry.FindSet(false) then
                                                repeat
                                                    LedgerAmt += DetailedVendorLedgEntry.Amount;
                                                    LedgerAmtLCY += DetailedVendorLedgEntry."Amount (LCY)";
                                                    DCLEorDVLEexists := true;
                                                until DetailedVendorLedgEntry.Next() = 0
                                            //HEI.10>>
                                            else begin
                                                if GLEntry."Source Currency Amount" <> 0 then begin
                                                    LedgerAmt += GLEntry."Source Currency Amount";
                                                    LedgerAmtLCY += GLEntry.Amount;
                                                end;
                                                if GLEntry."Source Currency Amount" = 0 then begin
                                                    LedgerAmt += GLEntry.Amount;
                                                    LedgerAmtLCY += GLEntry.Amount;
                                                end;
                                            end;
                                            //HEI.10<<
                                            if DetailedCustLedgEntry.IsEmpty and DetailedVendorLedgEntry.IsEmpty then begin
                                                DetailedCustLedgEntry.Reset();
                                                DetailedCustLedgEntry.SetRange("Entry No.", GLEntry."CV Detailed Entry No. FND");
                                                if DetailedCustLedgEntry.FindFirst() then
                                                    GLEntryShouldBeSkipped := true;

                                                DetailedVendorLedgEntry.Reset();
                                                DetailedVendorLedgEntry.SetRange("Entry No.", GLEntry."CV Detailed Entry No. FND");
                                                if DetailedVendorLedgEntry.FindFirst() then
                                                    GLEntryShouldBeSkipped := true;
                                            end;
                                        end;
                                end;
                                if Found1 and (GLEntryShouldBeSkipped = false) then
                                    InsertBufferForSpecific(TempBuffer, GLEntry, DCLEorDVLEexists);
                            until GLEntry.Next() = 0;
                        end else
                            Win.Update(1, Round((Counter[1] / TCounter[1]) * 10000, 1));
                    until GLAcc.Next() = 0;

                TempBuffer.Reset();
                if TempBuffer.IsEmpty then
                    Error(Text010);

                if TempBuffer.FindSet(false) then begin
                    TCounter[2] := TempBuffer.Count;
                    //BC UPGRADE KUMARR78 >> Blocking to Replace
                    // ServerFileName := FileManagement.ServerTempFileName('csv');
                    // FleHeiMatch.CREATE(ServerFileName);
                    // FleHeiMatch.TEXTMODE := true;
                    //BC UPGRADE KUMARR78 << Blocking to Replace
                    // BC Upgrade POENAB02, 14.03.2025 >>
                    //TempBlob.CreateOutStream(OutStr); //BC UPGRADE KUMARR78 ++
                    TempBlob.CreateOutStream(OutStr, TEXTENCODING::UTF8);
                    // BC Upgrade POENAB02, 14.03.2025 <<
                    FleRecord := TempBuffer.FieldCaption("Reporting Entity") + Format(TabChar);
                    if ExportDataType = ExportDataType::"Invoice Reference" then
                        FleRecord += TempBuffer.FieldCaption("Invoice Reference") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Period Code") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Partner Code") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Account No.") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Currency Code") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption(Amount) + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Local Currency Code") + Format(TabChar);
                    FleRecord += TempBuffer.FieldCaption("Amount (LCY)") + Format(TabChar);
                    if ExportDataType = ExportDataType::"Invoice Reference" then
                        FleRecord += TempBuffer.FieldCaption("Invoice Comment") + Format(TabChar)
                    else
                        FleRecord += TempBuffer.FieldCaption("Balance Comment") + Format(TabChar);

                    if ExportDataType = ExportDataType::"Invoice Reference" then begin
                        FleRecord += TempBuffer.FieldCaption("Invoice Document Date") + Format(TabChar);
                        FleRecord += TempBuffer.FieldCaption("Local Company Code");
                    end;
                    // FleHeiMatch.WRITE(FleRecord);//BC UPGRADE KUMARR78 --
                    // BC Upgrade POENAB02, 14.03.2025 >>
                    //OutStr.WriteText(FleRecord + '\r\n'); //BC UPGRADE KUMARR78 ++
                    OutStr.WriteText(FleRecord);
                    OutStr.WriteText();
                    // BC Upgrade POENAB02, 14.03.2025 <<
                    // lines
                    repeat
                        if ((TempBuffer."Amount (LCY)" > 0.1) or (TempBuffer."Amount (LCY)" < -0.1)) then begin
                            //HEI.10
                            Counter[2] += 1;
                            Win.Update(2, Round((Counter[2] / TCounter[2]) * 10000, 1));
                            if TempBuffer."Reporting Entity" <> '' then
                                FleRecord := TempBuffer."Reporting Entity" + Format(TabChar)
                            else
                                FleRecord := '' + Format(TabChar);
                            if ExportDataType = ExportDataType::"Invoice Reference" then
                                if TempBuffer."Invoice Reference" <> '' then
                                    FleRecord += TempBuffer."Invoice Reference" + Format(TabChar)
                                else
                                    FleRecord += '' + Format(TabChar);
                            if TempBuffer."Period Code" <> '' then
                                FleRecord += TempBuffer."Period Code" + Format(TabChar)
                            else
                                FleRecord += '' + Format(TabChar);
                            if TempBuffer."Partner Code" <> '' then
                                FleRecord += TempBuffer."Partner Code" + Format(TabChar)
                            else
                                FleRecord += '' + Format(TabChar);
                            if TempBuffer."Account No." <> '' then
                                FleRecord += TempBuffer."Account No." + Format(TabChar)
                            else
                                FleRecord += '' + Format(TabChar);
                            if TempBuffer."Currency Code" <> '' then
                                FleRecord += TempBuffer."Currency Code" + Format(TabChar)
                            else
                                FleRecord += '' + Format(TabChar);

                            if TempBuffer."Remaining Amt. (LCY)" = 3 then begin
                                ChkAmt := false;
                                ChkAmtLCY := false;

                                if (TempBuffer.Amount < 0) and (not ChkAmt) then begin
                                    TempBuffer.Amount := Abs(TempBuffer.Amount);
                                    ChkAmt := true;
                                end;

                                if (TempBuffer."Amount (LCY)" < 0) and (not ChkAmtLCY) then begin
                                    TempBuffer."Amount (LCY)" := Abs(TempBuffer."Amount (LCY)");
                                    ChkAmtLCY := true;
                                end;

                                if (TempBuffer.Amount > 0) and (not ChkAmt) then begin
                                    TempBuffer.Amount := -TempBuffer.Amount;
                                    ChkAmt := true;
                                end;

                                if (TempBuffer."Amount (LCY)" > 0) and (not ChkAmtLCY) then begin
                                    TempBuffer."Amount (LCY)" := -TempBuffer."Amount (LCY)";
                                    ChkAmtLCY := true;
                                end;
                            end;


                            FleRecord += Format(Round(TempBuffer.Amount, 0.01), 0, '<Precision,2:2><Standard Format,1>') + Format(TabChar);
                            FleRecord += TempBuffer."Local Currency Code" + Format(TabChar);
                            FleRecord += Format(Round(TempBuffer."Amount (LCY)", 0.01), 0, '<Precision,2:2><Standard Format,1>') + Format(TabChar);
                            if ExportDataType = ExportDataType::"Invoice Reference" then
                                FleRecord += ReplaceString(TempBuffer."Invoice Comment", ',', '') + Format(TabChar)
                            else
                                FleRecord += ReplaceString(TempBuffer."Balance Comment", ',', '');
                            if ExportDataType = ExportDataType::"Invoice Reference" then begin
                                if UseRegionalSettings then
                                    FleRecord += Format(TempBuffer."Invoice Document Date", 0, 1) + Format(TabChar)
                                else
                                    FleRecord += Format(TempBuffer."Invoice Document Date", 0, Text501) + Format(TabChar);
                                FleRecord += TempBuffer."Local Company Code";
                            end;
                            // FleHeiMatch.WRITE(FleRecord);//BC UPGRADE KUMARR78 --
                            // BC Upgrade POENAB02, 14.03.2025 >>
                            //OutStr.WriteText(FleRecord + '\r\n'); //BC UPGRADE KUMARR78 ++
                            OutStr.WriteText(FleRecord);
                            OutStr.WriteText();
                            // BC Upgrade POENAB02, 14.03.2025 <<
                        end;
                    //HEI.10
                    until TempBuffer.Next() = 0;
                    //BC UPGRADE KUMARR78 >> Blocking
                    // FleHeiMatch.CLOSE;
                    // FileManagement.DownloadToFile(ServerFileName, Filename);
                    //BC UPGRADE KUMARR78 << Blocking
                    //BC UPGRADE KUMARR78 >> Replacing Onprem Code with Saas Code
                    TempBlob.CreateInStream(InStr);

                    DownloadFromStream(
                        InStr,
                        'HeiMatch Export',
                        '',
                        'CSV File (*.csv)|*.csv',
                        Filename);
                    //BC UPGRADE KUMARR78 << Replacing Onprem Code with Saas Code
                end;
                //HEI.09<<
            end;

            trigger OnPostDataItem();
            begin
                //HEI.09>>
                if Calcfilter <> Calcfilter::Specific then
                    CurrReport.Skip();
                Win.Close();
                //BC UPGRADE KUMARR78 >> Exists Not Allowed in Saas
                // if EXISTS(Filename) then
                //     Message(Text005, Filename);
                //BC UPGRADE KUMARR78 << Exists Not Allowed in Saas
                //HEI.09<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.09>>
                if Calcfilter <> Calcfilter::Specific then
                    CurrReport.Skip();
                if Filename = '' then Error(Text001);

                //BC UPGRADE KUMARR78 >> Exists Not Allowed in Saas
                // if EXISTS(Filename) then
                //     if Confirm(Text003, false) then ERASE(Filename);
                //BC UPGRADE KUMARR78 << Exists Not Allowed in Saas

                TabChar := ';';
                CheckPrevInvPeriodFormula();

                GLSetup.Get();
                GLSetup.TestField("OPCO Dimension Code FND");

                Win.Open(Text300 + Text301);
                Clear(TCounter);
                Clear(Counter);

                GLEntry.Reset();
                GLEntry.SetCurrentKey(
                  "Posting Date", "Document No.", "External Document No.",
                  "Global Dimension 1 Code", "Global Dimension 2 Code", "G/L Account No.", "Currency Code FND");

                GLEntryBefore.Reset();
                GLEntryBefore.Copy(GLEntry);

                PrevInvPeriodStartDate := CalcPrevInvPeriodDate();

                UseGlobalDimAsFilter :=
                  (GLSetup."OPCO Dimension Code FND" = GLSetup."Global Dimension 1 Code") or
                  (GLSetup."Global Dimension 2 Code" = GLSetup."OPCO Dimension Code FND");
                if GLEntry.IsEmpty and GLEntryBefore.IsEmpty then
                    Error(Text010);

                GLAcc.SetFilter("HeiMatch Code FND", '<>%1', '');
                if GLAcc.IsEmpty then
                    Error(Text011, GLAcc.FieldCaption("HeiMatch Code FND"), GLAcc.TableCaption);

                CompInfo.Get();
                CompInfo.TestField("Reporting Entity FND");
                Clear(TempBuffer);
                TempBuffer.DeleteAll();
                //HEI.09<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(ExportDataType; ExportDataType)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'Export Per';
                }
                field(YearFilter; YearFilter)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'Year';
                    MaxValue = 2199;
                    MinValue = 1900;

                    trigger OnValidate();
                    begin
                        calcdatefilter();
                    end;
                }
                field(PeriodTypeFilter; PeriodTypeFilter)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'Period Type';

                    trigger OnValidate();
                    begin
                        calcdatefilter();
                    end;
                }
                field(PeriodFilter; PeriodFilter)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'Period';

                    trigger OnValidate();
                    begin
                        calcdatefilter();
                    end;
                }
                field(NewEndingDate; NewEndingDate)
                {
                    Caption = 'Ending Date';
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea

                    trigger OnValidate();
                    begin

                        // <<HIT0060.1 DDR 06/02/2012
                        CheckDateFields();
                        if (NewEndingDate < StartingDatePeriod) or (NewEndingDate > EndingDatePeriod) then
                            Error(Text200);
                        // >>HIT0060.1 DDR
                    end;
                }
                field(Calcfilter; Calcfilter)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'Calculate';

                    trigger OnValidate();
                    begin
                        calcdatefilter();
                        //HEI.09>>
                        if Calcfilter = Calcfilter::Specific then
                            DisableOpen := false;
                        if Calcfilter <> Calcfilter::Specific then
                            DisableOpen := true;
                        //HEI.09<<
                    end;
                }
                field(Datefilter; Datefilter)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'Date Filter';
                    Editable = false;
                    ToolTip = 'Add date filter';
                }
                field(RoundingFactor; RoundingFactor)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'Rounding Factor';
                    ToolTip = 'Select Rounding Factor';
                }
                field(Filename; Filename)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'File Name';
                    Tooltip = 'Specifies the suggested file name for the downloaded export.'; // BC Upgrade POENAB02, 14.03.2025

                    trigger OnAssistEdit();
                    begin
                        // Filename := FileManagement.SaveFileDialog(Text002, Filename, Text600); //BC UPGRADE KUMARR78 Not in BC
                        // BC Upgrade POENAB02, 14.03.2025 >>
                        if Filename = '' then
                            Filename := 'HeiMatchExport.csv';
                        NewFilename := Filename;
                        // BC Upgrade POENAB02, 14.03.2025 <<
                    end;

                    // BC Upgrade POENAB02, 14.03.2025 >>
                    trigger OnValidate();
                    begin
                        if Filename = '' then
                            Filename := 'HeiMatchExport.csv';
                        NewFilename := Filename;
                    end;
                    // BC Upgrade POENAB02, 14.03.2025 <<
                }
                field(PrevInvPeriodFormula; PrevInvPeriodFormula)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'Include Open Invoice';
                    Editable = DisableOpen;

                    trigger OnValidate();
                    begin
                        // <<HIT0060.5 DDR 29/02/2012
                        CheckPrevInvPeriodFormula();
                        // >>HIT0060.5 DDR
                    end;
                }
                field(PrevInvPeriodStartDate; PrevInvPeriodStartDate)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'PrevInvPeriodStartDate';
                    Editable = false;
                }
                field(IncludeOnlyOpen; IncludeOnlyOpen)
                {
                    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea
                    Caption = 'Only Open Entries';
                    Editable = DisableOpen;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        var
            lrecDate: Record Date;
        begin

            ClosingEntryFilter := ClosingEntryFilter::Exclude;
            InclOpening := false;

            // <<HIT0060.1 DDR 06/02/2012
            Calcfilter := Calcfilter::"Net change";
            YearFilter := Date2DMY(WorkDate(), 3);
            PeriodTypeFilter := PeriodTypeFilter::Month;
            lrecDate.SetRange("Period Type", lrecDate."Period Type"::Month);
            lrecDate.SetFilter("Period Start", '<=%1', WorkDate());
            if lrecDate.FindLast() then
                PeriodFilter := lrecDate."Period No.";
            calcdatefilter();
            // >>HIT0060.1 DDR

            // <<HIT0060.5 DDR 29/02/2012
            Evaluate(PrevInvPeriodFormula, '-3M');
            CalcPrevInvPeriodDate();
            IncludeOnlyOpen := true;
            // >>HIT0060.5 DDR

            //HEI.09>>
            if Calcfilter = Calcfilter::Specific then
                DisableOpen := false;
            if Calcfilter <> Calcfilter::Specific then
                DisableOpen := true;
            //HEI.09<<
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        Message('%1', Text503); //HEI.10
        Filename := NewFilename; // BC Upgrade POENAB02, 14.03.2025
    end;

    trigger OnPreReport();
    begin
        SourceCodeSetup.Get(); //HEI.10
        ReversalCode := SourceCodeSetup.Reversal; //HEI.10        
        Filename := NewFilename; // BC Upgrade POENAB02, 14.03.2025
    end;

    var
        CompInfo: Record "Company Information";
        CustLedgEntryBefore: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        DimensionSetEntry: Record "Dimension Set Entry";
        DimensionValue: Record "Dimension Value";
        Rec_Dimvalue: Record "Dimension Value";
        GLAcc: Record "G/L Account";
        GLAcc2: Record "G/L Account";

        GLEntry: Record "G/L Entry";
        GLEntryBefore: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
        TempBuffer: Record "HeiMatch Export Buffer FND" temporary;
        SourceCodeSetup: Record "Source Code Setup";
        VendLedgEntryBefore: Record "Vendor Ledger Entry";
        DimMgt: Codeunit DimensionManagement;
        FileManagement: Codeunit "File Management";
        //BC UPGRADE KUMARR78 >> Adding Variables
        TempBlob: Codeunit "Temp Blob";
        PrevInvPeriodFormula: DateFormula;
        ChkAmt: Boolean;
        ChkAmtLCY: Boolean;
        DCLEorDVLEexists: Boolean;
        DisableOpen: Boolean;
        Found1: Boolean;
        InclOpening: Boolean;
        IncludeOnlyOpen: Boolean;
        PerBusiType: Boolean;
        PerMovType: Boolean;
        // Wshell: Automation "'{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B}' 1.0:'{72C24DD5-D70A-438B-8A42-98424B88AFB8}':''{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B}' 1.0'.WshShell";//BC UPGRADE KUMARR78 Blocking.
        UseGlobalDimAsFilter: Boolean;
        UseRegionalSettings: Boolean;
        TabChar: Char;
        ReversalCode: Code[10];
        Dim_ReportingEntity: Code[20];
        MOV_TYPEValue: Code[20];
        Dim1Filter: Code[250];
        //BC UPGRADE KUMARR78 << Adding Variables
        GLAccFilter: Code[250];
        EndingDatePeriod: Date;
        NewEndingDate: Date;
        NewEndingDatePeriod: Date;
        NewStartingDatePeriod: Date;
        PrevInvPeriodStartDate: Date;
        StartingDatePeriod: Date;
        LedgerAmt: Decimal;
        LedgerAmtLCY: Decimal;
        Win: Dialog;
        FleHeiMatch: File;
        InStr: InStream;
        _HIT0060: Integer;
        "-HEI1.00-": Integer;
        Counter: array[2] of Integer;
        LedEntryNo: Integer;
        PeriodFilter: Integer;
        TCounter: array[2] of Integer;
        YearFilter: Integer;
        Text001: Label 'No filename specified';
        Text003: Label 'File already exisits. Overwrite file?';
        Text004: Label 'Period is not valid for this period type';
        Text005: Label 'File has been created succesfully.\"%1"';
        Text010: Label 'Nothing to export.';
        Text012: Label '"""Include Open Invoice Start Period Formula"""';
        Text013: Label '%1 must be a negative formula.';
        Text014: Label '%1 must give a date before the selected period starting date';
        Text500: Label '<Sign><INTEGER><Decimal,3>';
        Text501: Label '<Day,2><Filler Character,0>.<Month,2><Filler Character,0>.<Year4>';
        Text502: Label '<Integer,%1><Filler Character,0>';
        Text503: Label 'Report extraction complete';
        ClosingEntryFilter: Option Include,Exclude;
        ExportDataType: Option "Invoice Reference",Balance;
        Calcfilter: Option "Net change","Year to date","Balance to date","Rest of Year",Specific;
        RoundingFactor: Option None,"1","1000","1000000";
        PeriodTypeFilter: Option Week,Month,Quarter;
        OutStr: OutStream;
        ServerFileName: Text;
        ReportingPeriod: Text[2];
        Datefilter: Text[250];
        OBDatefilter: Text[250];
        Filename: Text[1024];
        NewFilename: Text[1024]; // BC Upgrade POENAB02, 14.03.2025
        FleRecord: Text[1024];
        Text002: TextConst ENU = 'Export to', FRA = ' ';
        Text011: TextConst ENU = 'No %1 has been found in %2 table.', FRA = 'Aucun %1 n''a été trouvé dans la table %2.';
        Text100: TextConst ENU = '%1 must be filled in.', FRA = '%1 doit être renseigné.';
        Text101: TextConst ENU = 'Year', FRA = 'Année';
        Text102: TextConst ENU = 'Period Type', FRA = 'Type de période';
        Text103: TextConst ENU = 'Period', FRA = 'Période';
        Text200: TextConst ENU = 'The ending date must be included in the calculated period.', FRA = 'La date de fin doit être inclue dans la période calculée.';
        Text300: TextConst ENU = 'Analyzing Data @1@@@@@@@@@@@@\', FRA = 'Analyse des données @1@@@@@@@@@@@@\';
        Text301: TextConst ENU = 'Exporting      @2@@@@@@@@@@@@\', FRA = 'Exportation         @2@@@@@@@@@@@@\';
        Text600: TextConst ENU = 'CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*', FRA = 'CSV Files (*.csv)|*.csv|Fichier Texte (*.txt)|*.txt|Tous Fichiers (*.*)|*.*';

    procedure calcdatefilter();
    var
        lrecPeriod: Record Date;
    begin
        if (YearFilter = 0) or
           (PeriodFilter = 0) then
            exit;

        if (PeriodTypeFilter = PeriodTypeFilter::Month) and
           (PeriodFilter = 12) and
           (Calcfilter = Calcfilter::"Rest of Year") then
            Error(Text004);


        if (PeriodTypeFilter = PeriodTypeFilter::Week) and
           (PeriodFilter > 53) then
            Error(Text004);

        if (PeriodTypeFilter = PeriodTypeFilter::Week) then begin
            lrecPeriod.Reset();
            lrecPeriod.SetFilter("Period End", '%1..', DMY2Date(1, 1, YearFilter));
            lrecPeriod.SetRange("Period Type", lrecPeriod."Period Type"::Week);
            lrecPeriod.SetRange("Period No.", PeriodFilter);
            if lrecPeriod.Find('-') then
                if ClosingEntryFilter = ClosingEntryFilter::Exclude then
                    lrecPeriod."Period End" := NormalDate(lrecPeriod."Period End");
            Datefilter := Format(lrecPeriod."Period Start") + '..' + Format(lrecPeriod."Period End");
            ReportingPeriod := Format(lrecPeriod."Period End", 2, '<Month,2>');
        end;

        if (PeriodTypeFilter = PeriodTypeFilter::Month) and
           (PeriodFilter > 12) then
            Error(Text004);
        if (PeriodTypeFilter = PeriodTypeFilter::Month) then begin
            lrecPeriod.Reset();
            lrecPeriod.SetFilter("Period End", '%1..', DMY2Date(1, 1, YearFilter));
            lrecPeriod.SetRange("Period Type", lrecPeriod."Period Type"::Month);
            lrecPeriod.SetRange("Period No.", PeriodFilter);
            if lrecPeriod.Find('-') then
                if ClosingEntryFilter = ClosingEntryFilter::Exclude then
                    lrecPeriod."Period End" := NormalDate(lrecPeriod."Period End");

            Datefilter := Format(lrecPeriod."Period Start") + '..' + Format(lrecPeriod."Period End");
            ReportingPeriod := Format(lrecPeriod."Period End", 2, '<Month,2>');
        end;

        if (PeriodTypeFilter = PeriodTypeFilter::Quarter) and
           (PeriodFilter > 4) then
            Error(Text004);
        if (PeriodTypeFilter = PeriodTypeFilter::Quarter) then begin
            lrecPeriod.Reset();
            lrecPeriod.SetFilter("Period End", '%1..', DMY2Date(1, 1, YearFilter));
            lrecPeriod.SetRange("Period Type", lrecPeriod."Period Type"::Quarter);
            lrecPeriod.SetRange("Period No.", PeriodFilter);
            if lrecPeriod.Find('-') then
                if ClosingEntryFilter = ClosingEntryFilter::Exclude then
                    lrecPeriod."Period End" := NormalDate(lrecPeriod."Period End");
            Datefilter := Format(lrecPeriod."Period Start") + '..' + Format(lrecPeriod."Period End");
            ReportingPeriod := Format(lrecPeriod."Period End", 2, '<Month,2>');
        end;

        StartingDatePeriod := lrecPeriod."Period Start";
        EndingDatePeriod := lrecPeriod."Period End";
        NewEndingDate := EndingDatePeriod;
        CalcPrevInvPeriodDate();

        //NAIKH01 19 Feb
        NewStartingDatePeriod := lrecPeriod."Period Start";
        NewEndingDatePeriod := lrecPeriod."Period End";
        //NAIKH01

        OBDatefilter := '..' + Format(lrecPeriod."Period Start" - 1);

        if Calcfilter = Calcfilter::"Net change" then exit;
        if Calcfilter = Calcfilter::"Year to date" then begin
            Datefilter := Format(DMY2Date(1, 1, YearFilter)) + '..' + Format(lrecPeriod."Period End");

            ReportingPeriod := Format(lrecPeriod."Period End", 2, '<Month,2>');
            StartingDatePeriod := DMY2Date(1, 1, YearFilter);
        end;
        if Calcfilter = Calcfilter::"Rest of Year" then begin
            Datefilter := Format(CalcDate('<+1D>', lrecPeriod."Period End")) + '..' + Format(DMY2Date(31, 12, YearFilter));
            ReportingPeriod := '12';
            Evaluate(StartingDatePeriod, Format(CalcDate('<+1D>', lrecPeriod."Period End")));
            Evaluate(EndingDatePeriod, Format(DMY2Date(31, 12, YearFilter)));
        end;

        if Calcfilter = Calcfilter::"Balance to date" then begin
            Datefilter := '..' + Format(lrecPeriod."Period End");
            ReportingPeriod := Format(lrecPeriod."Period End", 2, '<Month,2>');
            StartingDatePeriod := 0D;
        end;

        NewEndingDate := EndingDatePeriod;
        CalcPrevInvPeriodDate();
    end;

    local procedure FormatAmount(p_Amount: Decimal) Amount: Decimal;
    begin
        if p_Amount = 0 then
            exit;
        case RoundingFactor of
            RoundingFactor::None:
                Amount := Round(p_Amount, 0.01);
            RoundingFactor::"1":
                Amount := Round(p_Amount, 1);
            RoundingFactor::"1000":
                Amount := Round(p_Amount / 1000, 0.01);
            RoundingFactor::"1000000":
                Amount := Round(p_Amount / 1000000, 0.01);
        end;
    end;

    local procedure _fHIT0060();
    begin
    end;

    procedure CheckDateFields();
    begin
        if YearFilter = 0 then
            Error(Text100, Text101);
        if PeriodFilter = 0 then
            Error(Text100, Text103);
    end;

    procedure InsertBuffer(var TempBuffer2: Record "HeiMatch Export Buffer FND"; GLEntry: Record "G/L Entry"; pDCLEorDVLEexists: Boolean);
    var
        CompanyInformation: Record "Company Information";
        TempBuffer3: Record "HeiMatch Export Buffer FND" temporary;
        Found: Boolean;
        DimValueCode: Code[20];
        "//<<UGMA.D4633": Integer;
        "//>>UGMA.D4633": Integer;
    begin
        //>>HEI.06 UGMA.D4633
        CompanyInformation.Reset();
        CompanyInformation.Get();
        //<<HEI.06 UGMA.D4633

        //HEI.07>>
        if pDCLEorDVLEexists = true then
            if (GLEntry."Source Type" in [GLEntry."Source Type"::Customer, GLEntry."Source Type"::Vendor]) and (LedgerAmtLCY = 0) then
                exit;
        //HEI.07<<

        /*
        IF USERID = 'HEIWAY\POENAB02' THEN
          BEGIN
            IF GLEntry."Entry No." = 1234308 THEN
              MESSAGE('%1',GLEntry."Entry No.");
            IF GLEntry."Entry No." = 1234309 THEN
              MESSAGE('%1',GLEntry."Entry No.");
          END;
        */

        // initialize primary key
        if GLAcc2."No." <> GLEntry."G/L Account No." then
            GLAcc2.Get(GLEntry."G/L Account No.");

        //NAIKH01 19 Feb

        if (Calcfilter = Calcfilter::"Balance to date") and (GLAcc2."Income/Balance" = GLAcc2."Income/Balance"::"Income Statement") then begin
            if not (GLEntry."Document Date" >= NewStartingDatePeriod) and (GLEntry."Document Date" <= NewEndingDatePeriod) then
                exit;
        end;
        //NAIKH01
        TempBuffer3.Init();
        TempBuffer3."Period Code" :=
          CopyStr(
            StrSubstNo('%1.%2', CnvDateToF1(NewEndingDate, 2, 3), CnvDateToF1(NewEndingDate, 3, 4)), 1, MaxStrLen(TempBuffer3."Period Code"));

        if ExportDataType = ExportDataType::"Invoice Reference" then begin
            if (GLEntry."External Document No." <> '') then
                TempBuffer3."Invoice Reference" := CopyStr(GLEntry."External Document No.", 1, MaxStrLen(TempBuffer3."Invoice Reference"))
            else
                if GLAcc2."Std. Invoice Reference FND" <> '' then
                    TempBuffer3."Invoice Reference" := CopyStr(GLAcc2."Std. Invoice Reference FND", 1, MaxStrLen(TempBuffer3."Invoice Reference"))
                else
                    TempBuffer3."Invoice Reference" := CopyStr(GLEntry."Document No.", 1, MaxStrLen(TempBuffer3."Invoice Reference"));
        end;

        DimValueCode := '';
        if DimensionSetEntry.Get(GLEntry."Dimension Set ID", GLSetup."OPCO Dimension Code FND") then
            DimValueCode := DimensionSetEntry."Dimension Value Code";
        //<<NAIKH01 RTRGAP062
        if Rec_Dimvalue.Get(GLSetup."OPCO Dimension Code FND", DimValueCode) then
            Dim_ReportingEntity := Rec_Dimvalue."Reporting Entity FND";
        //>> NAIKH01 RTRGAP062
        //HEI.07>>
        /*
        IF DimValueCode = '' THEN
          EXIT;
        */
        //HEI.07<<
        //HEI.03>>
        //"Partner Code" := COPYSTR(DimValueCode,1,MAXSTRLEN("Partner Code"));  //NAIKH01 RTRGAP062
        //"Partner Code" := COPYSTR(Dim_ReportingEntity,1,MAXSTRLEN("Partner Code")); //NAIKH01 RTRGAP062
        if DimensionValue.Get(GLSetup."OPCO Dimension Code FND", DimValueCode) then
            TempBuffer3."Partner Code" := DimensionValue."Reporting Entity FND";
        //HEI.03<<
        TempBuffer3."Account No." := CopyStr(GLAcc2."HeiMatch Code FND", 1, MaxStrLen(TempBuffer3."Account No."));
        //TempBuffer3."Currency Code" := CopyStr(GLEntry."Currency Code FND", 1, MaxStrLen(TempBuffer3."Currency Code"));//Bc Upgrade YADAVM09<<
        TempBuffer3."Currency Code" := CopyStr(GLEntry."Source Currency Code", 1, MaxStrLen(TempBuffer3."Currency Code"));//Bc Upgrade YADAVM09<<
        // special for key
        TempBuffer3."Local Currency Code" := CopyStr(GLSetup."LCY Code", 1, MaxStrLen(TempBuffer3."Local Currency Code"));
        if TempBuffer3."Currency Code" = '' then
            TempBuffer3."Currency Code" := TempBuffer3."Local Currency Code";
        //Found := TempBuffer2.GET("Period Code","Invoice Reference","Partner Code","Account No.","Currency Code");//HEI.09
        //HEI.09>>
        TempBuffer3."Entry No." := GLEntry."Entry No.";
        if Calcfilter <> Calcfilter::Specific then begin
            TempBuffer2.SetRange("Period Code", TempBuffer3."Period Code");
            TempBuffer2.SetRange("Invoice Reference", TempBuffer3."Invoice Reference");
            TempBuffer2.SetRange("Partner Code", TempBuffer3."Partner Code");
            TempBuffer2.SetRange("Account No.", TempBuffer3."Account No.");
            TempBuffer2.SetRange("Currency Code", TempBuffer3."Currency Code");
            if TempBuffer2.FindFirst() then
                Found := true
            else
                Found := false;
        end;
        //HEI.09<<
        // new totaling record
        if not Found then begin
            TempBuffer2 := TempBuffer3;
            TempBuffer2."Reporting Entity" := CopyStr(CompInfo."Reporting Entity FND", 1, MaxStrLen(TempBuffer2."Reporting Entity"));
            TempBuffer2."Invoice Document Date" := GLEntry."Document Date";
            //>>HEI.06 UGMA.D4633
            TempBuffer2."Local Company Code" := CompanyInformation."Legal Entity Code FND";
            //<<HEI.06 UGMA.D4633
            TempBuffer2.Insert();
        end;


        if LedgerAmtLCY = 0 then
            TempBuffer2."Amount (LCY)" += GLEntry."Remaining Amount FND"
        // NAIKH01 17th June
        else
            TempBuffer2."Amount (LCY)" += LedgerAmtLCY;
        // NAIKH01 17th June
        //IF "Currency Code" <> "Local Currency Code" THEN   // NAIKH01 17th June
        //    Amount += GLEntry."Source Currency Amount" // NAIKH01 17th June
        if LedgerAmt = 0 then begin
            //>>HEI.06 UGMA.Defect.4633
            if TempBuffer2."Currency Code" <> TempBuffer2."Local Currency Code" then
                TempBuffer2.Amount += GLEntry."Source Currency Amount"
            else
                TempBuffer2.Amount += GLEntry.Amount;
            // NAIKH01 17th June
            //<<HEI.06 UGMA.Defect.4633
        end else
            TempBuffer2.Amount += LedgerAmt;
        //NAIKH01 25 Feb
        //No Change,Positive,Negative,Reverse
        //0,1,2,3
        //HEI.08 New options string: 0 - Blank; 1-No change; 2-Reverse<<
        /*IF GLAcc2."Heimatch Sign" = GLAcc2."Heimatch Sign"::Positive THEN
          "Remaining Amt. (LCY)" := 1;
        IF GLAcc2."Heimatch Sign" = GLAcc2."Heimatch Sign"::Negative THEN
          "Remaining Amt. (LCY)" := 2;
        IF GLAcc2."Heimatch Sign" = GLAcc2."Heimatch Sign"::Reverse THEN
          "Remaining Amt. (LCY)" :=3;*/
        if GLAcc2."Heimatch Sign FND" = GLAcc2."Heimatch Sign FND"::Reverse then
            TempBuffer2."Remaining Amt. (LCY)" := 3;
        //HEI.08 New options string: 0 - Blank; 1-No change; 2-Reverse<<
        if (TempBuffer2."Invoice Comment" = '') and (GLEntry.Description <> '') then
            TempBuffer2."Invoice Comment" := CopyStr(GLEntry.Description, 1, MaxStrLen(TempBuffer2."Invoice Comment"));
        TempBuffer2.Modify();

    end;

    procedure CnvDateToF1(ForDate: Date; What: Option Day,Month,Year; Length: Integer) DateCode: Code[10];
    var
        ValueDMY: Integer;
    begin
        if Length = 0 then
            exit;
        if Length > MaxStrLen(DateCode) then
            Length := MaxStrLen(DateCode);
        Evaluate(ValueDMY, Format(What, 0, 2));
        exit(Format(Date2DMY(ForDate, ValueDMY), 0, StrSubstNo(Text502, Length)));
    end;

    procedure LookupDate(var PeriodNoText: Text[1024]; var DateRecFilter: Record Date): Boolean;
    var
        lrecDate: Record Date;
    begin
        lrecDate.Copy(DateRecFilter);
        if (lrecDate.GetFilter("Period Start") = '') and
          (lrecDate.GetFilter("Period End") = '')
        then begin
            lrecDate.SetRange("Period Start", CalcDate('<-CY>', WorkDate()), CalcDate('+CY', WorkDate()));
            lrecDate.SetRange("Period End");
        end;
        lrecDate.SetFilter("Period No.", PeriodNoText);
        if lrecDate.FindSet() then;
        lrecDate.SetRange("Period No.");
        //BC UPGRADE KUMARR78 >> Page not Available
        // if Page.RUNMODAL(Page::80077, lrecDate) = Action::LookupOK then begin
        //     PeriodNoText := Format(lrecDate."Period No.");
        //     DateRecFilter := lrecDate;
        //     exit(true);
        // end;
        //BC UPGRADE KUMARR78 << Page not Available
    end;

    procedure CheckPrevInvPeriodFormula();
    begin
        if Format(PrevInvPeriodFormula) = '' then
            exit;
        if StrPos(Format(PrevInvPeriodFormula), '-') = 0 then
            Error(Text013, Text012);
        CalcPrevInvPeriodDate();
        if PrevInvPeriodStartDate >= StartingDatePeriod then
            Error(Text014, Text012);
    end;

    procedure CalcPrevInvPeriodDate(): Date;
    begin
        PrevInvPeriodStartDate := 0D;
        if Format(PrevInvPeriodFormula) = '' then
            exit;
        if StartingDatePeriod <> 0D then
            PrevInvPeriodStartDate := CalcDate(PrevInvPeriodFormula, StartingDatePeriod);
        exit(PrevInvPeriodStartDate);
    end;

    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text): Text;
    var
        NewString: Text;
    begin
        //HEI.07>>
        while StrPos(String, FindWhat) > 0 do
            String := DelStr(String, StrPos(String, FindWhat)) + ReplaceWith + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString := String;

        exit(NewString);
        //HEI.07<<
    end;

    procedure InsertBufferForSpecific(var TempBuffer2: Record "HeiMatch Export Buffer FND"; GLEntry: Record "G/L Entry"; pDCLEorDVLEexists: Boolean);
    var
        CompanyInformation: Record "Company Information";
        TempBuffer3: Record "HeiMatch Export Buffer FND" temporary;
        Found: Boolean;
        DimValueCode: Code[20];
        "//<<UGMA.D4633": Integer;
        "//>>UGMA.D4633": Integer;
    begin
        //HEI.09>>
        CompanyInformation.Reset();
        CompanyInformation.Get();

        if pDCLEorDVLEexists = true then
            if (GLEntry."Source Type" in [GLEntry."Source Type"::Customer, GLEntry."Source Type"::Vendor]) and (LedgerAmtLCY = 0) then
                exit;

        if GLAcc2."No." <> GLEntry."G/L Account No." then
            GLAcc2.Get(GLEntry."G/L Account No.");

        TempBuffer3.Init();
        TempBuffer3."Period Code" :=
          CopyStr(
            StrSubstNo('%1.%2', CnvDateToF1(NewEndingDate, 2, 3), CnvDateToF1(NewEndingDate, 3, 4)), 1, MaxStrLen(TempBuffer3."Period Code"));

        if ExportDataType = ExportDataType::"Invoice Reference" then begin
            if (GLEntry."External Document No." <> '') then
                TempBuffer3."Invoice Reference" := (DelChr(GLEntry."External Document No.", '=', ';|,-'))
            else
                if GLAcc2."Std. Invoice Reference FND" <> '' then
                    TempBuffer3."Invoice Reference" := CopyStr(GLAcc2."Std. Invoice Reference FND", 1, MaxStrLen(TempBuffer3."Invoice Reference"))
                else
                    TempBuffer3."Invoice Reference" := (DelChr(GLEntry."Document No.", '=', ',-'))
        end;

        DimValueCode := '';
        if DimensionSetEntry.Get(GLEntry."Dimension Set ID", GLSetup."OPCO Dimension Code FND") then
            DimValueCode := DimensionSetEntry."Dimension Value Code";

        if Rec_Dimvalue.Get(GLSetup."OPCO Dimension Code FND", DimValueCode) then
            Dim_ReportingEntity := Rec_Dimvalue."Reporting Entity FND";

        if DimensionValue.Get(GLSetup."OPCO Dimension Code FND", DimValueCode) then
            TempBuffer3."Partner Code" := DimensionValue."Reporting Entity FND";
        TempBuffer3."Account No." := CopyStr(GLAcc2."HeiMatch Code FND", 1, MaxStrLen(TempBuffer3."Account No."));
        //TempBuffer3."Currency Code" := CopyStr(GLEntry."Currency Code FND", 1, MaxStrLen(TempBuffer3."Currency Code"));//Bc Upgrade YADAVM09<<
        TempBuffer3."Currency Code" := CopyStr(GLEntry."Source Currency Code", 1, MaxStrLen(TempBuffer3."Currency Code"));//Bc upgrade YADAVM09<<
        // special for key
        TempBuffer3."Local Currency Code" := CopyStr(GLSetup."LCY Code", 1, MaxStrLen(TempBuffer3."Local Currency Code"));
        if TempBuffer3."Currency Code" = '' then
            TempBuffer3."Currency Code" := TempBuffer3."Local Currency Code";
        TempBuffer3."Entry No." := GLEntry."Entry No.";

        Found := TempBuffer2.Get(TempBuffer3."Period Code", TempBuffer3."Invoice Reference", TempBuffer3."Partner Code", TempBuffer3."Account No.", TempBuffer3."Currency Code", TempBuffer3."Entry No.");

        if not Found then begin
            TempBuffer2 := TempBuffer3;
            TempBuffer2."Reporting Entity" := CopyStr(CompInfo."Reporting Entity FND", 1, MaxStrLen(TempBuffer2."Reporting Entity"));
            TempBuffer2."Invoice Document Date" := GLEntry."Document Date";
            TempBuffer2."Local Company Code" := CompanyInformation."Legal Entity Code FND";
            TempBuffer2.Insert();
        end;


        if LedgerAmtLCY = 0 then
            TempBuffer2."Amount (LCY)" += GLEntry."Remaining Amount FND"
        else
            TempBuffer2."Amount (LCY)" += LedgerAmtLCY;

        if LedgerAmt = 0 then begin
            if TempBuffer2."Currency Code" <> TempBuffer2."Local Currency Code" then
                TempBuffer2.Amount += GLEntry."Source Currency Amount"
            else
                TempBuffer2.Amount += GLEntry.Amount;

        end else
            TempBuffer2.Amount += LedgerAmt;

        if GLAcc2."Heimatch Sign FND" = GLAcc2."Heimatch Sign FND"::Reverse then
            TempBuffer2."Remaining Amt. (LCY)" := 3;

        if (TempBuffer2."Invoice Comment" = '') and (GLEntry.Description <> '') then
            TempBuffer2."Invoice Comment" := CopyStr(GLEntry.Description, 1, MaxStrLen(TempBuffer2."Invoice Comment"));
        TempBuffer2.Modify();
        //HEI.09<<
    end;
}

