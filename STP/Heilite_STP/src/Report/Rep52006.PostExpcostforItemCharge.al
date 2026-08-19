report 52006 "Post Exp. cost for Item Charge"
{
    // version HEI.01

    // HEI.01 CHG2119679 IBM BHATTA09
    //  #Created New Report from Report 50322 to only consider Item Charges
    // HEI.02 CHG2119679 IBM BHATTA09
    //   # Code changed to take Accrual Account instead of Purch Account
    //   # Code changed to pick correct Gen Prod Posting Group
    // BC Upgrade BHARDA11 >>
    // 1. Change variable Name Editable to Editable1 because it is used in the property and the code and it showing error for peremeters because Editable is the base function
    // 2. Change Noseriesmanagement to "No. Series" and replace InitSeries to Arerelated function.
    // 3. Add ApplicationArea property in Report and requestpage fields.
    // 4. Remove Drink-IT Record Variable  and Related code(2034841)
    // 5. OLD Report ID -50561

    // BC Upgrade POENAB02, 04.04.2026, FDD-RTR-016- Accrual posting of Item Charges and service

    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Post Expected cost for Item Charge';
    Permissions = TableData "G/L Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE(Type = FILTER("G/L Account" | "Charge (Item)"));

                trigger OnAfterGetRecord()
                begin
                    PurchLine.RESET;
                    PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SETRANGE("Document No.", "Order No.");
                    PurchLine.SETRANGE("Line No.", "Order Line No.");
                    IF PurchLine.FINDFIRST THEN BEGIN
                        ItemChargeAssignmentPurch.RESET;
                        ItemChargeAssignmentPurch.SETRANGE("Document Type", ItemChargeAssignmentPurch."Document Type"::Order);
                        ItemChargeAssignmentPurch.SETRANGE("Document No.", PurchLine."Document No.");
                        IF ItemChargeAssignmentPurch.FINDFIRST THEN BEGIN
                            IF gItem.GET(ItemChargeAssignmentPurch."Item No.") THEN
                                GenProdPostingGroup := gItem."Gen. Prod. Posting Group";
                            //CCCCode :=
                        END;
                        //ShortDim1Code := PurchLine."Shortcut Dimension 1 Code";
                        //ShortDim2Code := PurchLine."Shortcut Dimension 2 Code";
                        DimSetID := PurchLine."Dimension Set ID";
                    END;

                    PurchLine.RESET;
                    PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Order);
                    PurchLine.SETRANGE("Document No.", "Order No.");
                    PurchLine.SETRANGE("Line No.", "Order Line No.");
                    IF PurchLine.FINDFIRST THEN BEGIN
                        ItemChargeAssignmentPurch.RESET;
                        ItemChargeAssignmentPurch.SETRANGE("Document Type", ItemChargeAssignmentPurch."Document Type"::Order);
                        ItemChargeAssignmentPurch.SETRANGE("Document No.", PurchLine."Document No.");
                        IF ItemChargeAssignmentPurch.FINDFIRST THEN BEGIN
                            PostedPurchRcptLine.RESET;
                            PostedPurchRcptLine.SETRANGE("Document No.", ItemChargeAssignmentPurch."Applies-to Doc. No.");
                            PostedPurchRcptLine.SETRANGE("Line No.", ItemChargeAssignmentPurch."Applies-to Doc. Line No.");
                            IF PostedPurchRcptLine.FINDFIRST THEN BEGIN
                                PurchLine2.RESET;
                                PurchLine2.SETRANGE("Document Type", PurchLine2."Document Type"::Order);
                                PurchLine2.SETRANGE("Document No.", PostedPurchRcptLine."Order No.");
                                PurchLine.SETRANGE("Line No.", PostedPurchRcptLine."Order Line No.");
                                IF PurchLine2.FINDFIRST THEN BEGIN
                                    ShortDim1Code := PurchLine2."Shortcut Dimension 1 Code";
                                    ShortDim2Code := PurchLine2."Shortcut Dimension 2 Code";
                                    //DimSetID := PurchLine2."Dimension Set ID";
                                END;
                            END;
                        END;
                    END;

                    IF "Qty. Rcd. Not Invoiced" <> 0 THEN BEGIN
                        //>>HEI.02
                        /*
                        IF NOT GenPostingSetup.GET("Gen. Bus. Posting Group","Gen. Prod. Posting Group") THEN
                          ERROR(text003,"Gen. Bus. Posting Group","Gen. Prod. Posting Group")
                        */
                        IF NOT GenPostingSetup.GET("Gen. Bus. Posting Group", GenProdPostingGroup) THEN
                            ERROR(text003, "Gen. Bus. Posting Group", GenProdPostingGroup)
                        //<<HEI.02
                        ELSE
                            IF "Create General Jnl Lines" THEN
                                CreateGenJnlLines
                            ELSE
                                PostCost;           //IBM.AK
                    END;

                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE(Type, Type::"Charge (Item)");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //>>HEI.02
                /*
                PurchLine.RESET;
                PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Order);
                PurchLine.SETRANGE("Document No.", "Order No.");
                PurchLine.SETRANGE("Line No.","Purch. Rcpt. Line"."Line No.");
                IF PurchLine.FINDFIRST THEN BEGIN
                  ItemChargeAssignmentPurch.RESET;
                  ItemChargeAssignmentPurch.SETRANGE("Document Type", ItemChargeAssignmentPurch."Document Type"::Order);
                  ItemChargeAssignmentPurch.SETRANGE("Document No.",PurchLine."Document No.");
                  IF ItemChargeAssignmentPurch.FINDFIRST THEN BEGIN
                    IF gItem.GET(ItemChargeAssignmentPurch."Item No.") THEN
                      GenProdPostingGroup := gItem."Gen. Prod. Posting Group";
                      //CCCCode :=
                  END;
                  ShortDim1Code := PurchLine."Shortcut Dimension 1 Code";
                  ShortDim2Code := PurchLine."Shortcut Dimension 2 Code";
                  DimSetID := PurchLine."Dimension Set ID";
                END;
                *///<<HEI.02

            end;

            trigger OnPreDataItem()
            begin
                IF EndingDate = 0D THEN
                    ERROR(Text001);
                IF ReversalDate = 0D THEN
                    ERROR(Text002);
                LineNo2 := 0;



                IF StartingDate <> 0D THEN
                    SETFILTER("Purch. Rcpt. Header"."Order Date", '%1..%2', StartingDate, EndingDate)
                ELSE
                    SETFILTER("Purch. Rcpt. Header"."Order Date", '..%1', EndingDate);

                IF NOT "Create General Jnl Lines" THEN    //IBM.AK 240219
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
                    ApplicationArea = All;
                    Caption = 'Starting Date';
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = All;
                    Caption = 'Ending Date';
                }
                field(ReversalDate; ReversalDate)
                {
                    ApplicationArea = All;
                    Caption = 'Reversal Date';
                }
                field("Create Gen Jnl Lines"; "Create General Jnl Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Create General Jnl. Lines';

                    trigger OnValidate()
                    begin
                        //HEI:CHG0256150:1:1 IBM.AK 24//02/2019>>
                        IF "Create General Jnl Lines" THEN
                            Editable1 := TRUE ELSE
                            Editable1 := FALSE;
                        //HEI:CHG0256150:1:1 IBM.AK 24//02/2019>>
                    end;
                }
                field(GenTempName; GenTempName)
                {
                    ApplicationArea = All;
                    Caption = 'General Template Name';
                    Editable = Editable1;
                    TableRelation = "Gen. Journal Template";
                }
                field(GenBatchName; GenBatchName)
                {
                    ApplicationArea = All;
                    Caption = 'General Batch Name';
                    Editable = Editable1;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //   "Gen. Journal Batch".Name WHERE (Journal Template Name=FIELD(Journal Template Name))
                        //HEI:CHG0256150:1:1 IBM.AK 24//02/2019>>
                        GenJournalBatch.RESET;
                        GenJournalBatch.SETRANGE("Journal Template Name", GenTempName);
                        IF PAGE.RUNMODAL(0, GenJournalBatch) = ACTION::LookupOK THEN
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

    trigger OnPostReport()
    begin
        /* MESSAGE(text005, Counter);
          Window.CLOSE;
        *///IBM.AK commented 24/02/19


        IF NOT "Create General Jnl Lines" THEN BEGIN
            MESSAGE(text005, Counter);
            Window.CLOSE;
        END ELSE
            MESSAGE('General Journal Lines are Created');  //IBM.AK

    end;

    trigger OnPreReport()
    begin
        PurchSetup.GET;
        PurchSetup.TESTFIELD("Posted Exp. Cost Doc. Nos. FND");
        Editable1 := FALSE;
    end;

    var
        Counter: Integer;
        StartingDate: Date;
        EndingDate: Date;
        ReversalDate: Date;
        Text001: Label 'The ending date cannot be empty for this process';
        Text002: Label 'The reversal date cannot be empty for this process';
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        GenJnlLine4: Record "Gen. Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        GenPostingSetup: Record "General Posting Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        text003: Label 'There is no General Posting Setup to be found for ''Gen. Bus. Posting Group'' %1 and ''Gen. Prod. Posting Group'' %2 ';
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Window: Dialog;
        text004: Label 'Posting expected costs';
        text005: Label '%1 lines have been posted';
        text006: Label 'Purchase Receipt %1 - Order %2';
        "Create General Jnl Lines": Boolean;
        GenTempName: Code[10];
        GenBatchName: Code[10];
        GenJournalBatch: Record "Gen. Journal Batch";
        text007: Label 'General Journal Template or General Journal Batch cannot be Empty';
        LineNo2: Integer;
        Editable1: Boolean;
        Include_Item_Charges: Boolean;
        "Include_G/L_Account": Boolean;
        PurchLine: Record "Purchase Line";
        ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)";
        gItem: Record Item;
        GenProdPostingGroup: Code[10];
        ShortDim1Code: Code[20];
        ShortDim2Code: Code[20];
        DimSetID: Integer;
        PurchLine2: Record "Purchase Line";
        PostedPurchRcptLine: Record "Purch. Rcpt. Line";

    procedure PostCost()
    var
        GLEntries: Record "G/L Entry";
        EntryNo1: Integer;
        EntryNo2: Integer;
        EntryNo3: Integer;
        EntryNo4: Integer;
        NoSeries: Codeunit "No. Series"; //POENAB02, 04.04.2026
    begin
        GenJnlLine.INIT;
        GenJnlLine."Posting Date" := EndingDate;
        GenJnlLine."Document Date" := "Purch. Rcpt. Header"."Document Date";
        //GenJnlLine."Account No." := GenPostingSetup."Purch. Account";//HEI.02
        GenJnlLine."Account No." := GenPostingSetup."Accrual Acc. Landed Cost FND";//HEI.02
        GenJnlLine.Description := STRSUBSTNO(text006, "Purch. Rcpt. Header"."No.", "Purch. Rcpt. Header"."Order No.");
        // NoSeriesMgt.InitSeries(PurchSetup."Posted Exp. Cost Doc. Nos. FND", '', "Posting Date", GenJnlLine."Document No.", PurchSetup."Posted Exp. Cost Doc. Nos. FND");
        GenJnlLine."Document No." := NoSeries.GetNextNo(PurchSetup."Posted Exp. Cost Doc. Nos. FND", "Purch. Rcpt. Header"."Posting Date");
        //POENAB02, 04.04.2026
        NoSeriesMgt.AreRelated(PurchSetup."Posted Exp. Cost Doc. Nos. FND", PurchSetup."Posted Exp. Cost Doc. Nos. FND");
        // BC Upgrade BHARDA11 ----Change Noseriesmanagement to No. series codeunit and InitSeries to AreRelated and change the peremeters
        GenJnlLine."Reason Code" := "Purch. Rcpt. Header"."Reason Code";
        GenJnlLine."System-Created Entry" := FALSE;
        GenJnlLine.VALIDATE(Amount, "Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced");
        GenJnlLine."VAT Base Amount" := GenJnlLine.Amount;
        GenJnlLine."Source Currency Code" := "Purch. Rcpt. Header"."Currency Code";
        GenJnlLine."Source Currency Amount" := "Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Header"."Currency Factor" * "Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced";
        GenJnlLine.Correction := FALSE;
        GenJnlLine.Quantity := 1;
        /*
         GenJnlLine."Shortcut Dimension 1 Code" := "Purch. Rcpt. Line"."Shortcut Dimension 1 Code";
         GenJnlLine."Shortcut Dimension 2 Code" := "Purch. Rcpt. Line"."Shortcut Dimension 2 Code";
         GenJnlLine."Dimension Set ID" := "Purch. Rcpt. Line"."Dimension Set ID";
         */
        GenJnlLine."Shortcut Dimension 1 Code" := ShortDim1Code;
        GenJnlLine."Shortcut Dimension 2 Code" := ShortDim2Code;
        GenJnlLine."Dimension Set ID" := DimSetID;

        IF SourceCodeSetup.GET THEN;
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
        // BC Upgrade BHARDA11 >> ----Drink-IT Table(2034841)
        // WITH GenJnlLine2 DO
        //     GenJnlLine2.CreateDim(
        //     DimMgt.TypeToTableID1("Account Type"), "Account No.",
        //     DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
        //     DATABASE::Job, "Job No.",
        //     DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
        //     DATABASE::Campaign, "Campaign No.",
        //     DATABASE::Table2034841, "Building No.",
        //     DimMgt.TypeToTableID2034932(GetSourceType(), "Purch. Rcpt. Header"."Contract Type"), "Service Contract No.");
        // BC Upgrade BHARDA11 << ----Drink-IT Table(2034841)
        GenJnlLine4."Dimension Set ID" := GenJnlLine2."Dimension Set ID";
        EntryNo2 := GenJnlPostLine.RunWithCheck(GenJnlLine2);

        GenJnlLine3."Posting Date" := ReversalDate;
        GenJnlLine3.VALIDATE(Amount, -GenJnlLine3.Amount);
        EntryNo3 := GenJnlPostLine.RunWithCheck(GenJnlLine3);

        GenJnlLine4."Posting Date" := ReversalDate;
        GenJnlLine4."Account No." := GenPostingSetup."Accrual Acc. (Interim) FND";
        //IBM.AK 240219>>
        // BC Upgrade BHARDA11 >> ----Drink-IT Table(2034841)
        // WITH GenJnlLine4 DO
        //     GenJnlLine4.CreateDim(
        //     DimMgt.TypeToTableID1("Account Type"), "Account No.",
        //     DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
        //     DATABASE::Job, "Job No.",
        //     DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
        //     DATABASE::Campaign, "Campaign No.",
        //     DATABASE::Table2034841, "Building No.",
        //     DimMgt.TypeToTableID2034932(GetSourceType(), "Contract Type"), "Service Contract No.");
        // BC Upgrade BHARDA11 << ----Drink-IT Table(2034841)
        //IBM.AK 240219<<
        EntryNo4 := GenJnlPostLine.RunWithCheck(GenJnlLine4);

        COMMIT;
        IF GLEntries.GET(EntryNo1) THEN BEGIN
            GLEntries."Remaining Amount FND" := 0;
            GLEntries."Open FND" := FALSE;
            GLEntries."Closed by Entry No. FND" := EntryNo3;
            GLEntries."Closed at Date FND" := ReversalDate;
            GLEntries."Closed by Amount FND" := GLEntries.Amount;
            GLEntries.MODIFY;
        END;
        IF GLEntries.GET(EntryNo2) THEN BEGIN
            GLEntries."Remaining Amount FND" := 0;
            GLEntries."Open FND" := FALSE;
            GLEntries."Closed by Entry No. FND" := EntryNo4;
            GLEntries."Closed at Date FND" := ReversalDate;
            GLEntries."Closed by Amount FND" := GLEntries.Amount;
            GLEntries.MODIFY;
        END;
        IF GLEntries.GET(EntryNo3) THEN BEGIN
            GLEntries."Remaining Amount FND" := 0;
            GLEntries."Open FND" := FALSE;
            GLEntries.MODIFY;
        END;
        IF GLEntries.GET(EntryNo4) THEN BEGIN
            GLEntries."Remaining Amount FND" := 0;
            GLEntries."Open FND" := FALSE;
            GLEntries.MODIFY;
        END;
        Counter += 4;

    end;

    procedure CreateGenJnlLines()
    var
        GLEntries: Record 17;
        EntryNo1: Integer;
        EntryNo2: Integer;
        EntryNo3: Integer;
        EntryNo4: Integer;
        NoSeries: Codeunit "No. Series"; //POENAB02, 04.04.2026
    begin
        //HEI:CHG0256150:1:1 IBM.AK 24/02/2019>>
        IF (GenTempName = '') OR (GenBatchName = '') THEN
            ERROR(text007);

        IF GenTempName <> '' THEN BEGIN
            IF LineNo2 = 0 THEN BEGIN
                GenJnlLine.SETRANGE("Journal Template Name", GenTempName);
                GenJnlLine.SETRANGE("Journal Batch Name", GenBatchName);
                IF GenJnlLine.FINDLAST THEN
                    LineNo2 := GenJnlLine."Line No."
                ELSE
                    LineNo2 := 0;
                GenJnlLine.RESET;
            END;

            GenJnlLine.INIT;
            GenJnlLine."Journal Template Name" := GenTempName;
            GenJnlLine."Journal Batch Name" := GenBatchName;
            LineNo2 += 10000;
            GenJnlLine."Line No." := LineNo2;
            GenJnlLine."Posting Date" := EndingDate;
            GenJnlLine."Document Date" := "Purch. Rcpt. Header"."Document Date";
            //GenJnlLine."Account No." := GenPostingSetup."Purch. Account";//HEI.02
            GenJnlLine."Account No." := GenPostingSetup."Accrual Acc. Landed Cost FND";//HEI.02
            GenJnlLine.Description := STRSUBSTNO(text006, "Purch. Rcpt. Header"."No.", "Purch. Rcpt. Header"."Order No.");
            // NoSeriesMgt.InitSeries(PurchSetup."Posted Exp. Cost Doc. Nos. FND", '', "Posting Date", GenJnlLine."Document No.", PurchSetup."Posted Exp. Cost Doc. Nos. FND"); // BC Upgrade BHARDA11 ::Blocked
            GenJnlLine."Document No." := NoSeries.GetNextNo(PurchSetup."Posted Exp. Cost Doc. Nos. FND", "Purch. Rcpt. Header"."Posting Date");//POENAB02, 04.04.2026
            NoSeriesMgt.AreRelated(PurchSetup."Posted Exp. Cost Doc. Nos. FND", PurchSetup."Posted Exp. Cost Doc. Nos. FND");
            // BC Upgrade BHARDA11 ----Change Noseriesmanagement to No. series codeunit and InitSeries to AreRelated and change the peremeters
            GenJnlLine."Reason Code" := "Purch. Rcpt. Header"."Reason Code";
            GenJnlLine."System-Created Entry" := FALSE;
            GenJnlLine.VALIDATE(Amount, "Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced");
            GenJnlLine."VAT Base Amount" := GenJnlLine.Amount;
            GenJnlLine."Source Currency Code" := "Purch. Rcpt. Header"."Currency Code";
            GenJnlLine."Source Currency Amount" := "Purch. Rcpt. Line"."Direct Unit Cost" * "Purch. Rcpt. Header"."Currency Factor" * "Purch. Rcpt. Line"."Qty. Rcd. Not Invoiced";
            GenJnlLine.Correction := FALSE;
            GenJnlLine.Quantity := 1;
            /*
            GenJnlLine."Shortcut Dimension 1 Code" := "Purch. Rcpt. Line"."Shortcut Dimension 1 Code";
            GenJnlLine."Shortcut Dimension 2 Code" := "Purch. Rcpt. Line"."Shortcut Dimension 2 Code";
            GenJnlLine."Dimension Set ID" := "Purch. Rcpt. Line"."Dimension Set ID";
            */
            GenJnlLine."Shortcut Dimension 1 Code" := ShortDim1Code;
            GenJnlLine."Shortcut Dimension 2 Code" := ShortDim2Code;
            GenJnlLine."Dimension Set ID" := DimSetID;
            IF SourceCodeSetup.GET THEN;
            GenJnlLine."Source Code" := SourceCodeSetup.Purchases;
            GenJnlLine."Source Type" := GenJnlLine."Source Type"::Vendor;
            GenJnlLine."Source No." := "Purch. Rcpt. Header"."Pay-to Vendor No.";
            GenJnlLine.INSERT(TRUE);
        END;


        GenJnlLine2 := GenJnlLine;
        GenJnlLine3 := GenJnlLine;
        GenJnlLine4 := GenJnlLine;
        //EntryNo1 := GenJnlPostLine.RunWithCheck(GenJnlLine);
        LineNo2 += 10000;
        GenJnlLine2."Line No." := LineNo2;
        GenJnlLine2."Account No." := GenPostingSetup."Accrual Acc. (Interim) FND";
        GenJnlLine2.VALIDATE(Amount, -GenJnlLine2.Amount);
        GenJnlLine2."Dimension Set ID" := 0;
        // BC Upgrade BHARDA11 >> ----Drink-IT Table(2034841)
        // WITH GenJnlLine2 DO
        //     GenJnlLine2.CreateDim(
        //     DimMgt.TypeToTableID1("Account Type"), "Account No.",
        //     DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
        //     DATABASE::Job, "Job No.",
        //     DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
        //     DATABASE::Campaign, "Campaign No.",
        //     DATABASE::Table2034841, "Building No.",
        //     DimMgt.TypeToTableID2034932(GetSourceType(), "Contract Type"), "Service Contract No.");
        // BC Upgrade BHARDA11 << ----Drink-IT Table(2034841)
        GenJnlLine4."Dimension Set ID" := GenJnlLine2."Dimension Set ID";
        GenJnlLine2.INSERT(TRUE);
        //EntryNo2 := GenJnlPostLine.RunWithCheck(GenJnlLine2);
        GenJnlLine3."Posting Date" := ReversalDate;
        LineNo2 += 10000;
        GenJnlLine3."Line No." := LineNo2;
        GenJnlLine3.VALIDATE(Amount, -GenJnlLine3.Amount);
        GenJnlLine3.INSERT(TRUE);
        //EntryNo3 := GenJnlPostLine.RunWithCheck(GenJnlLine3);
        GenJnlLine4."Posting Date" := ReversalDate;
        LineNo2 += 10000;
        GenJnlLine4."Line No." := LineNo2;
        GenJnlLine4."Account No." := GenPostingSetup."Accrual Acc. (Interim) FND";
        //IBM.AK>> 240219
        GenJnlLine4."Dimension Set ID" := 0;
        // BC Upgrade BHARDA11 >> ----Drink-IT Table(2034841)
        // WITH GenJnlLine4 DO
        //     GenJnlLine4.CreateDim(
        //     DimMgt.TypeToTableID1("Account Type"), "Account No.",
        //     DimMgt.TypeToTableID1("Bal. Account Type"), "Bal. Account No.",
        //     DATABASE::Job, "Job No.",
        //     DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
        //     DATABASE::Campaign, "Campaign No.",
        //     DATABASE::Table2034841, "Building No.",
        //     DimMgt.TypeToTableID2034932(GetSourceType(), "Contract Type"), "Service Contract No.");
        // BC Upgrade BHARDA11 << ----Drink-IT Table(2034841)
        // GenJnlLine4."Dimension Set ID" := GenJnlLine2."Dimension Set ID";
        //IBM.AK<< 240219
        GenJnlLine4.INSERT(TRUE);
        //EntryNo4 := GenJnlPostLine.RunWithCheck(GenJnlLine4);
        //HEI:CHG0256150:1:1 IBM.AK 24/02/2019
    end;
}

