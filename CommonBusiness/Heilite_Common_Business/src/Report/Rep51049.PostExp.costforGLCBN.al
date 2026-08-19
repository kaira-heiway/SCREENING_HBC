report 51049 "Post Exp. cost for G/L CBN"
{
    // version HEI.01

    // HEI.01 FDD-HB446 IBM SURYAS01 -#Created New Report
    // HEI.02 FDD-HT1100 IBM SURYAS01 09/04/2019
    //  # Added Code in trigger -"Purch. Rcpt. Line - OnPreDataItem()'
    //  # Added Option "Include_Item_Charges","Include_G/L_Account" in Request page
    // HEI.03 CHG2119679 IBM BHATTA09 08/09/2021
    //   # Various changes done in order to make this report work only for GL Accounts
    //   # The name and caption changed, previously it was Post Exp. cost G/L/Item Charge
    //   # From Request Page, Include_Item_Charges and "Include_G/L_Account" are removed
    //   # Code is amended for taking only GL into consideration

    //----------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 01.02.2026 #Replaced variable- Editable by Editable_Var to resolve compilation errors.
    //BC Upgrade KAPOOV01 01.02.2025 #Commented DRINK-IT related code.
    //BC Upgrade KAPOOV01 01.02.2025 #Replaced Codeunit- NoSeriesManagement by "No. Series",CU-NoSeriesManagement is Obsolete in BC.
    //BC Upgrade KAPOOV01 01.02.2025 #Added Property -UsageCategory,ApplicationArea.

    // BC Upgrade POENAB02, 26.03.2026, FDD-RTR-016- Accrual posting of Item Charges and service
    // BC Upgrade POENAB02, 04.04.2026, FDD-RTR-016- Accrual posting of Item Charges and service

    CaptionML = ENU = 'Post Expected cost for G/L',
                FRA = 'Post expected coût pour G/L';
    Permissions = TableData "G/L Entry" = rm;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                // BC Upgrade POENAB02, 26.03.2026>>
                //DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER("G/L Account" | '"Charge (Item)"'));
                DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Type = FILTER("G/L Account" | "Charge (Item)"));
                // BC Upgrade POENAB02, 26.03.2026<<

                trigger OnAfterGetRecord();
                begin
                    /*
                    IF "Qty. Rcd. Not Invoiced" <> 0 THEN
                    BEGIN
                      IF NOT GenPostingSetup.GET("Gen. Bus. Posting Group","Gen. Prod. Posting Group") THEN
                        ERROR(text003,"Gen. Bus. Posting Group","Gen. Prod. Posting Group")
                      ELSE PostCost;
                    END;
                    *///commented IBM.AK 24/02/19

                    if "Qty. Rcd. Not Invoiced" <> 0 then begin
                        //MESSAGE('hi');
                        if not GenPostingSetup.GET("Gen. Bus. Posting Group", "Gen. Prod. Posting Group") then
                            ERROR(text003, "Gen. Bus. Posting Group", "Gen. Prod. Posting Group")
                        else
                            if "Create General Jnl Lines" then
                                CreateGenJnlLines()
                            else
                                PostCost();           //IBM.AK
                    end;

                end;

                trigger OnPreDataItem();
                begin
                    //>>HEI.03
                    /*
                    //HEI.02<<
                    IF "Include_G/L_Account" = TRUE THEN
                      SETRANGE(Type,Type::"G/L Account");
                    IF Include_Item_Charges = TRUE THEN
                      SETRANGE(Type,Type::"Charge (Item)");
                    IF (Include_Item_Charges = TRUE) AND ("Include_G/L_Account" = TRUE) THEN
                      SETFILTER(Type,'%1|%2',Type::"G/L Account",Type::"Charge (Item)");
                    //HEI.02>>
                    */
                    SETRANGE(Type, Type::"G/L Account");
                    //<<HEI.03

                end;
            }

            trigger OnPreDataItem();
            begin
                if EndingDate = 0D then
                    ERROR(Text001);
                if ReversalDate = 0D then
                    ERROR(Text002);
                LineNo2 := 0;



                if StartingDate <> 0D then
                    SETFILTER("Purch. Rcpt. Header"."Order Date", '%1..%2', StartingDate, EndingDate)
                else
                    SETFILTER("Purch. Rcpt. Header"."Order Date", '..%1', EndingDate);

                if not "Create General Jnl Lines" then    //IBM.AK 240219
                    Window.OPEN(text004);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartingDate; StartingDate)
                {
                    CaptionML = ENU = 'Starting Date',
                                FRA = 'Date début';
                    ApplicationArea = All;
                }
                field(EndingDate; EndingDate)
                {
                    CaptionML = ENU = 'Ending Date',
                                FRA = 'Date fin';
                    ApplicationArea = All;
                }
                field(ReversalDate; ReversalDate)
                {
                    CaptionML = ENU = 'Reversal Date',
                                FRA = 'Date de contre-passation';
                    ApplicationArea = All;
                }
                field("Create Gen Jnl Lines"; "Create General Jnl Lines")
                {
                    Caption = 'Create General Jnl. Lines';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        //POENAB02, 04.04.2026>>
                        /*
                        //HEI:CHG0256150:1:1 IBM.AK 24//02/2019>>
                        if "Create General Jnl Lines" then
                            Editable := true else
                            Editable := false;
                        //HEI:CHG0256150:1:1 IBM.AK 24//02/2019>>
                        */
                        if "Create General Jnl Lines" then
                            Editable_Var := true else
                            Editable_Var := false;
                        //POENAB02, 04.04.2026<<
                    end;
                }
                field(GenTempName; GenTempName)
                {
                    Caption = 'General Template Name';
                    //BC Upgrade KAPOOV01 replaced variable- Editable by Editable_Var to resolve compilation errors >>
                    //Editable = Editable
                    Editable = Editable_Var;
                    //BC Upgrade KAPOOV01 replaced variable- Editable by Editable_Var to resolve compilation errors <<
                    TableRelation = "Gen. Journal Template";
                    ApplicationArea = All;
                }
                field(GenBatchName; GenBatchName)
                {
                    Caption = 'General Batch Name';
                    //BC Upgrade KAPOOV01 replaced variable- Editable by Editable_Var to resolve compilation errors >>
                    //Editable = Editable
                    Editable = Editable_Var;
                    ApplicationArea = All;
                    //BC Upgrade KAPOOV01 replaced variable- Editable by Editable_Var to resolve compilation errors <<

                    //BC Upgrade KAPOOV01 To correct Syntax error >>
                    //trigger OnLookup(Text: Text): Boolean; //BC Upgrade KAPOOV01 Commented
                    trigger OnLookup(Var Text: Text): Boolean;
                    //BC Upgrade KAPOOV01 To correct Syntax error <<
                    begin
                        //   "Gen. Journal Batch".Name WHERE (Journal Template Name=FIELD(Journal Template Name))
                        //HEI:CHG0256150:1:1 IBM.AK 24//02/2019>>
                        GenJournalBatch.RESET();
                        GenJournalBatch.SETRANGE("Journal Template Name", GenTempName);
                        if PAGE.RUNMODAL(0, GenJournalBatch) = ACTION::LookupOK then
                            GenBatchName := GenJournalBatch.Name;
                        //HEI:CHG0256150:1:1 IBM.AK 24//02/2019<<
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        /* MESSAGE(text005, Counter);
          Window.CLOSE;
        *///IBM.AK commented 24/02/19


        if not "Create General Jnl Lines" then begin
            MESSAGE(text005, Counter);
            Window.CLOSE();
        end else
            MESSAGE('General Journal Lines are Created');  //IBM.AK

    end;

    trigger OnPreReport();
    begin
        PurchSetup.GET();
        PurchSetup.TESTFIELD("Posted Exp. Cost Doc. Nos. FND");
        //BC Upgrade KAPOOV01 replaced variable- Editable by Editable_Var to resolve compilation errors >>
        //Editable := false;
        Editable_Var := false;
        //BC Upgrade KAPOOV01 replaced variable- Editable by Editable_Var to resolve compilation errors <<
    end;

    var
        Counter: Integer;
        StartingDate: Date;
        EndingDate: Date;
        ReversalDate: Date;
        Text001: TextConst ENU = 'The ending date cannot be empty for this process', FRA = 'Le date final no doit pas être vide pour ce procès ';
        Text002: Label 'The reversal date cannot be empty for this process';
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        GenJnlLine4: Record "Gen. Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        GenPostingSetup: Record "General Posting Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        text003: Label '"There is no General Posting Setup to be found for ''Gen. Bus. Posting Group'' %1 and ''Gen. Prod. Posting Group'' %2 "';
        DimMgt: Codeunit DimensionManagement;
        //NoSeriesMgt: Codeunit NoSeriesManagement; //BC Upgrade KAPOOV01 Blocked
        NoSeries: Codeunit "No. Series"; //BC Upgrade KAPOOV01 Added
        Window: Dialog;
        text004: Label 'Posting expected costs';
        text005: TextConst ENU = '%1 lines have been posted', FRA = '%1 lignes sont registrées';
        text006: TextConst ENU = 'Purchase Receipt %1 - Order %2', FRA = 'Réception achat %1 - Commande %2';
        "Create General Jnl Lines": Boolean;
        GenTempName: Code[10];
        GenBatchName: Code[10];
        GenJournalBatch: Record "Gen. Journal Batch";
        text007: Label 'General Journal Template or General Journal Batch cannot be Empty';
        LineNo2: Integer;
        //[InDataSet]
        //BC Upgrade KAPOOV01 replaced variable- Editable by Editable_Var to resolve compilation errors >>
        //Editable: Boolean;
        Editable_Var: Boolean;
        //BC Upgrade KAPOOV01 replaced variable- Editable by Editable_Var to resolve compilation errors <<
        Include_Item_Charges: Boolean;
        "Include_G/L_Account": Boolean;

    procedure PostCost();
    var
        GLEntries: Record "G/L Entry";
        EntryNo1: Integer;
        EntryNo2: Integer;
        EntryNo3: Integer;
        EntryNo4: Integer;
        NoSeries: Codeunit "No. Series"; //POENAB02, 04.04.2026
    begin
        GenJnlLine.INIT();
        GenJnlLine."Posting Date" := EndingDate;
        GenJnlLine."Document Date" := "Purch. Rcpt. Header"."Document Date";
        //>>HEI.03
        /*
        IF "Purch. Rcpt. Line".Type = "Purch. Rcpt. Line".Type::"G/L Account" THEN
          GenJnlLine."Account No.":= "Purch. Rcpt. Line"."No."
        ELSE IF "Purch. Rcpt. Line".Type = "Purch. Rcpt. Line".Type::"Charge (Item)" THEN
          GenJnlLine."Account No." := GenPostingSetup."Purch. Account";
        */
        GenJnlLine."Account No." := "Purch. Rcpt. Line"."No.";
        //<<HEI.03
        GenJnlLine.Description := STRSUBSTNO(text006, "Purch. Rcpt. Header"."No.", "Purch. Rcpt. Header"."Order No.");
        // NoSeriesMgt.InitSeries(PurchSetup."Posted Exp. Cost Doc. Nos. FND", '', "Posting Date",
        //                        GenJnlLine."Document No.", PurchSetup."Posted Exp. Cost Doc. Nos. FND");  //BC Upgrade KAPOOV01 Blocked
        //POENAB02, 04.04.2026>>
        GenJnlLine."Document No." := NoSeries.GetNextNo(PurchSetup."Posted Exp. Cost Doc. Nos. FND", "Purch. Rcpt. Header"."Posting Date");
        //POENAB02, 04.04.2026<<              
        NoSeries.AreRelated(PurchSetup."Posted Exp. Cost Doc. Nos. FND", "Purch. Rcpt. Header"."No. Series");
        // BC Upgrade KAPOOV01 - Added
        GenJnlLine."Reason Code" := "Purch. Rcpt. Header"."Reason Code";
        GenJnlLine."System-Created Entry" := false;
        GenJnlLine.VALIDATE(Amount, "Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced");
        GenJnlLine."VAT Base Amount" := GenJnlLine.Amount;
        GenJnlLine."Source Currency Code" := "Purch. Rcpt. Header"."Currency Code";
        GenJnlLine."Source Currency Amount" := "Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Header"."Currency Factor" * "Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced";
        GenJnlLine.Correction := false;
        GenJnlLine.Quantity := 1;

        GenJnlLine."Shortcut Dimension 1 Code" := "Purch. Rcpt. Line"."Shortcut Dimension 1 Code";
        GenJnlLine."Shortcut Dimension 2 Code" := "Purch. Rcpt. Line"."Shortcut Dimension 2 Code";
        GenJnlLine."Dimension Set ID" := "Purch. Rcpt. Line"."Dimension Set ID";

        if SourceCodeSetup.GET() then;
        GenJnlLine."Source Code" := SourceCodeSetup.Purchases;
        GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
        GenJnlLine."Source No." := "Purch. Rcpt. Header"."Pay-to Vendor No.";
        GenJnlLine2 := GenJnlLine;
        GenJnlLine3 := GenJnlLine;
        GenJnlLine4 := GenJnlLine;
        EntryNo1 := GenJnlPostLine.RunWithCheck(GenJnlLine);

        GenJnlLine2."Account No." := GenPostingSetup."Accrual Acc. (Interim) FND";
        GenJnlLine2.VALIDATE(Amount, -GenJnlLine2.Amount);
        GenJnlLine2."Dimension Set ID" := 0;
        //BC Upgrade KAPOOV01 Drink-IT fields used inside function- CreateDim >>
        // GenJnlLine2.CreateDim(
        // DimMgt.TypeToTableID1("Account Type"), "Account No.",
        // DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
        // DATABASE::Job, "Job No.",
        // DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
        // DATABASE::Campaign, "Campaign No.",
        // DATABASE::Building, "Building No.",
        // DimMgt.TypeToTableID2034932(GetSourceType(), "Purch. Rcpt. Header"."Contract Type"), "Service Contract No.");
        //BC Upgrade KAPOOV01 Drink-IT fields used inside function- CreateDim <<
        GenJnlLine4."Dimension Set ID" := GenJnlLine2."Dimension Set ID";
        EntryNo2 := GenJnlPostLine.RunWithCheck(GenJnlLine2);

        GenJnlLine3."Posting Date" := ReversalDate;
        GenJnlLine3.VALIDATE(Amount, -GenJnlLine3.Amount);
        EntryNo3 := GenJnlPostLine.RunWithCheck(GenJnlLine3);

        GenJnlLine4."Posting Date" := ReversalDate;
        GenJnlLine4."Account No." := GenPostingSetup."Accrual Acc. (Interim) FND";
        //IBM.AK 240219>>
        //BC Upgrade KAPOOV01 Drink-IT fields used inside function- CreateDim >>
        // GenJnlLine4.CreateDim(
        // DimMgt.TypeToTableID1("Account Type"), "Account No.",
        // DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
        // DATABASE::Job, "Job No.",
        // DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
        // DATABASE::Campaign, "Campaign No.",
        // DATABASE::Building, "Building No.",
        // DimMgt.TypeToTableID2034932(GetSourceType(), "Contract Type"), "Service Contract No.");
        //BC Upgrade KAPOOV01 Drink-IT fields used inside function- CreateDim <<
        //EntryNo2 := GenJnlPostLine.RunWithCheck(GenJnlLine2);
        //IBM.AK 240219<<
        EntryNo4 := GenJnlPostLine.RunWithCheck(GenJnlLine4);

        COMMIT();
        if GLEntries.GET(EntryNo1) then begin
            GLEntries."Remaining Amount FND" := 0;
            GLEntries."Open FND" := false;
            GLEntries."Closed by Entry No. FND" := EntryNo3;
            GLEntries."Closed at Date FND" := ReversalDate;
            GLEntries."Closed by Amount FND" := GLEntries.Amount;
            GLEntries.MODIFY();
        end;
        if GLEntries.GET(EntryNo2) then begin
            GLEntries."Remaining Amount FND" := 0;
            GLEntries."Open FND" := false;
            GLEntries."Closed by Entry No. FND" := EntryNo4;
            GLEntries."Closed at Date FND" := ReversalDate;
            GLEntries."Closed by Amount FND" := GLEntries.Amount;
            GLEntries.MODIFY();
        end;
        if GLEntries.GET(EntryNo3) then begin
            GLEntries."Remaining Amount FND" := 0;
            GLEntries."Open FND" := false;
            GLEntries.MODIFY();
        end;
        if GLEntries.GET(EntryNo4) then begin
            GLEntries."Remaining Amount FND" := 0;
            GLEntries."Open FND" := false;
            GLEntries.MODIFY();
        end;
        Counter += 4;

    end;

    procedure CreateGenJnlLines();
    var
        GLEntries: Record "G/L Entry";
        EntryNo1: Integer;
        EntryNo2: Integer;
        EntryNo3: Integer;
        EntryNo4: Integer;
    begin
        //HEI:CHG0256150:1:1 IBM.AK 24/02/2019>>
        if (GenTempName = '') or (GenBatchName = '') then
            ERROR(text007);

        if GenTempName <> '' then begin
            if LineNo2 = 0 then begin
                GenJnlLine.SETRANGE("Journal Template Name", GenTempName);
                GenJnlLine.SETRANGE("Journal Batch Name", GenBatchName);
                if GenJnlLine.FINDLAST() then
                    LineNo2 := GenJnlLine."Line No."
                else
                    LineNo2 := 0;
                GenJnlLine.RESET();
            end;

            GenJnlLine.INIT();
            GenJnlLine."Journal Template Name" := GenTempName;
            GenJnlLine."Journal Batch Name" := GenBatchName;
            LineNo2 += 10000;
            GenJnlLine."Line No." := LineNo2;
            GenJnlLine."Posting Date" := EndingDate;
            GenJnlLine."Document Date" := "Purch. Rcpt. Header"."Document Date";
            //>>HEI.03
            /*
            IF "Purch. Rcpt. Line".Type = "Purch. Rcpt. Line".Type::"G/L Account" THEN
              GenJnlLine."Account No.":= "Purch. Rcpt. Line"."No."
            ELSE IF "Purch. Rcpt. Line".Type = "Purch. Rcpt. Line".Type::"Charge (Item)" THEN
              GenJnlLine."Account No." := GenPostingSetup."Purch. Account";
            */
            GenJnlLine."Account No." := "Purch. Rcpt. Line"."No.";
            //<<HEI.03
            //GenJnlLine."Account No.":= "Purch. Rcpt. Line"."No.";
            GenJnlLine.Description := STRSUBSTNO(text006, "Purch. Rcpt. Header"."No.", "Purch. Rcpt. Header"."Order No.");
            // NoSeriesMgt.InitSeries(PurchSetup."Posted Exp. Cost Doc. Nos. FND", '', "Posting Date",
            //                        GenJnlLine."Document No.", PurchSetup."Posted Exp. Cost Doc. Nos. FND"); //BC Upgrade KAPOOV01 Blocked
            //POENAB02, 04.04.2026>>
            GenJnlLine."Document No." := NoSeries.GetNextNo(PurchSetup."Posted Exp. Cost Doc. Nos. FND", "Purch. Rcpt. Header"."Posting Date");
            //POENAB02, 04.04.2026<<
            NoSeries.AreRelated(PurchSetup."Posted Exp. Cost Doc. Nos. FND", "Purch. Rcpt. Header"."No. Series");
            // BC Upgrade KAPOOV01 - Added
            GenJnlLine."Reason Code" := "Purch. Rcpt. Header"."Reason Code";
            GenJnlLine."System-Created Entry" := false;
            GenJnlLine.VALIDATE(Amount, "Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced");
            GenJnlLine."VAT Base Amount" := GenJnlLine.Amount;
            GenJnlLine."Source Currency Code" := "Purch. Rcpt. Header"."Currency Code";
            GenJnlLine."Source Currency Amount" := "Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Header"."Currency Factor" * "Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced";
            GenJnlLine.Correction := false;
            GenJnlLine.Quantity := 1;

            GenJnlLine."Shortcut Dimension 1 Code" := "Purch. Rcpt. Line"."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Purch. Rcpt. Line"."Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := "Purch. Rcpt. Line"."Dimension Set ID";

            if SourceCodeSetup.GET() then;
            GenJnlLine."Source Code" := SourceCodeSetup.Purchases;
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
            GenJnlLine."Source No." := "Purch. Rcpt. Header"."Pay-to Vendor No.";
            GenJnlLine.INSERT(true);
        end;


        GenJnlLine2 := GenJnlLine;
        GenJnlLine3 := GenJnlLine;
        GenJnlLine4 := GenJnlLine;
        //EntryNo1 := GenJnlPostLine.RunWithCheck(GenJnlLine);
        LineNo2 += 10000;
        GenJnlLine2."Line No." := LineNo2;
        GenJnlLine2."Account No." := GenPostingSetup."Accrual Acc. (Interim) FND";
        GenJnlLine2.VALIDATE(Amount, -GenJnlLine2.Amount);
        GenJnlLine2."Dimension Set ID" := 0;
        //BC Upgrade KAPOOV01 Drink-IT fields used inside function- CreateDim >>
        // GenJnlLine2.CreateDim(
        // DimMgt.TypeToTableID1("Account Type"), "Account No.",
        // DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
        // DATABASE::Job, "Job No.",
        // DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
        // DATABASE::Campaign, "Campaign No.",
        // DATABASE::Building, "Building No.",
        // DimMgt.TypeToTableID2034932(GetSourceType(), "Contract Type"), "Service Contract No.");
        //BC Upgrade KAPOOV01 Drink-IT fields used inside function- CreateDim <<
        GenJnlLine4."Dimension Set ID" := GenJnlLine2."Dimension Set ID";
        GenJnlLine2.INSERT(true);
        //EntryNo2 := GenJnlPostLine.RunWithCheck(GenJnlLine2);
        GenJnlLine3."Posting Date" := ReversalDate;
        LineNo2 += 10000;
        GenJnlLine3."Line No." := LineNo2;
        GenJnlLine3.VALIDATE(Amount, -GenJnlLine3.Amount);
        GenJnlLine3.INSERT(true);
        //EntryNo3 := GenJnlPostLine.RunWithCheck(GenJnlLine3);
        GenJnlLine4."Posting Date" := ReversalDate;
        LineNo2 += 10000;
        GenJnlLine4."Line No." := LineNo2;
        GenJnlLine4."Account No." := GenPostingSetup."Accrual Acc. (Interim) FND";
        //IBM.AK>> 240219
        GenJnlLine4."Dimension Set ID" := 0;
        //BC Upgrade KAPOOV01 Drink-IT fields used inside function- CreateDim >>
        // GenJnlLine4.CreateDim(
        // DimMgt.TypeToTableID1("Account Type"), "Account No.",
        // DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
        // DATABASE::Job, "Job No.",
        // DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
        // DATABASE::Campaign, "Campaign No.",
        // DATABASE::Building, "Building No.",
        // DimMgt.TypeToTableID2034932(GetSourceType(), "Contract Type"), "Service Contract No.");
        //BC Upgrade KAPOOV01 Drink-IT fields used inside function- CreateDim <<
        // GenJnlLine4."Dimension Set ID" := GenJnlLine2."Dimension Set ID";
        //IBM.AK<< 240219
        GenJnlLine4.INSERT(true);
        //EntryNo4 := GenJnlPostLine.RunWithCheck(GenJnlLine4);
        //HEI:CHG0256150:1:1 IBM.AK 24/02/2019
    end;
}

