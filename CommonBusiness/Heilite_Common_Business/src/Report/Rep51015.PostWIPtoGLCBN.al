report 51015 "Post WIP to GL CBN"
{
    // version HEI.01

    // HEI.01 CHG2261740 IBM YADAVM09 07.08.2024 Report Performance Optimization | Report 50013 Fixed Asset - Trial Balance & OBJECT Report 50047 Post WIP to GL
    //   # optimisation of test scrip BPM013

    // BC Upgrade KUMARS145 Nav ID Report 50047 "Post WIP to GL"

    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = Tasks;
    Caption = 'Post WIP to GL';

    dataset
    {
        dataitem("Prod. Order Line"; "Prod. Order Line")
        {

            trigger OnAfterGetRecord();
            var
                ProdOrderComponent: Record "Prod. Order Component";
                ProdOrderRoutingLine: Record "Prod. Order Routing Line";
                Item: Record Item;
                QtyToCalc: Decimal;
                WipAmount: Decimal;
                WorkCenter: Record "Work Center";
            begin

                QtyToCalc := "Prod. Order Line"."Remaining Quantity";

                ProdOrderComponent.RESET();//HEI.01
                ProdOrderComponent.SETCURRENTKEY(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");//HEI.01
                ProdOrderComponent.SETRANGE(Status, Status);
                ProdOrderComponent.SETRANGE("Prod. Order No.", "Prod. Order No.");
                ProdOrderComponent.SETRANGE("Prod. Order Line No.", "Line No.");
                if ProdOrderComponent.FINDSET() then
                    repeat
                        if Item.GET(ProdOrderComponent."Item No.") then
                            WipAmount += Item."Unit Cost" * ProdOrderComponent."Quantity (Base)";
                    until ProdOrderComponent.NEXT() = 0;

                ProdOrderRoutingLine.RESET();//HEI.01
                ProdOrderRoutingLine.SETCURRENTKEY(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");//HEI.01
                ProdOrderRoutingLine.SETRANGE(Status, Status);
                ProdOrderRoutingLine.SETRANGE("Prod. Order No.", "Prod. Order No.");
                ProdOrderRoutingLine.SETRANGE("Routing Reference No.", "Line No.");
                if ProdOrderRoutingLine.FINDSET() then
                    repeat
                        if WorkCenter.GET(ProdOrderRoutingLine."Work Center No.") then
                            WipAmount += WorkCenter."Unit Cost" * ProdOrderRoutingLine."Run Time";
                    until ProdOrderRoutingLine.NEXT() = 0;
                WipAmount := QtyToCalc * WipAmount;
                if WipAmount <> 0 then begin
                    MakeGLLine(PostingDate, WipAmount);
                    MakeGLLine(ReversalPostingDate, -WipAmount);
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Posting Date';
                        ToolTip = 'Select the posting date for the WIP amount. The system will create one line with this posting date and another line with the reversal posting date entered for the WIP amount reversal.';
                        trigger OnValidate();
                        begin
                            //ValidateEndDate(TRUE);
                        end;
                    }
                    field(ReversalPostingDate; ReversalPostingDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Reversal Posting Date';
                        ToolTip = 'Select the reversal posting date for the WIP amount.';
                    }
                    field(GenJournalTemplate; GenJnlLine."Journal Template Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Gen. Journal Template';
                        ToolTip = 'Select the general journal template to which the WIP posting will be made. The system will use the accounts defined in this template for the WIP posting and reversal.';
                        TableRelation = "Gen. Journal Template";

                        trigger OnValidate();
                        begin
                            GenJnlLine."Journal Batch Name" := '';
                            DocNo := '';
                        end;
                    }
                    field(GenJournalBatch; GenJnlLine."Journal Batch Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Gen. Journal Batch';
                        ToolTip = 'Select the general journal batch to which the WIP posting will be made. The system will use the accounts defined in this batch for the WIP posting and reversal.';
                        Lookup = true;

                        trigger OnLookup(var Text: Text): Boolean;
                        begin
                            GenJnlLine.TESTFIELD("Journal Template Name");
                            GenJnlTemplate.GET(GenJnlLine."Journal Template Name");
                            GenJnlBatch.FILTERGROUP(2);
                            GenJnlBatch.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                            GenJnlBatch.FILTERGROUP(0);
                            GenJnlBatch."Journal Template Name" := GenJnlLine."Journal Template Name";
                            GenJnlBatch.Name := GenJnlLine."Journal Batch Name";
                            if PAGE.RUNMODAL(0, GenJnlBatch) = ACTION::LookupOK then begin
                                Text := GenJnlBatch.Name;
                                exit(true);
                            end;
                        end;

                        trigger OnValidate();
                        var
                            // BC Upgrade KUMARS145      to use the No. Series.....>>
                            // NoSeriesMgt: Codeunit "No. Series Management";
                            NoSeriesMgt: Codeunit "No. Series";
                        // BC Upgrade KUMARS145 updates the No. Series Management to use the No. Series.....<<
                        begin
                            if GenJnlLine."Journal Batch Name" <> '' then begin
                                GenJnlLine.TESTFIELD("Journal Template Name");
                                GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
                                //SOICAD01
                                if GenJnlBatch."No. Series" <> '' then begin
                                    CLEAR(NoSeriesMgt);
                                    // BC Upgrade KUMARS145 updates the No. Series Management to use the No. Series.....>>
                                    // DocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", TODAY);
                                    DocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", TODAY, true); // BC Upgrade KAIRAR01
                                    // DocNo := NoSeriesMgt.PeekNextNo(GenJnlBatch."No. Series", TODAY);
                                    // BC Upgrade KUMARS145 updates the No. Series Management to use the No. Series.....<<
                                end;
                            end;
                        end;
                    }
                    field("Account No."; AccNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Account No.';
                        ToolTip = 'Select the WIP account for the WIP posting. The system will create one line with this account and another line with the balance sheet account defined in the general journal template for the WIP posting reversal.';
                        Lookup = true;
                        TableRelation = "G/L Account"."No." WHERE("Account Type" = FILTER(Posting),
                                                                   "Direct Posting" = FILTER(true));
                    }
                    field(BallAccNo; BallAccNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Ball. Account No.';
                        ToolTip = 'Select the balance sheet account for the WIP posting reversal.';
                        Lookup = true;
                        TableRelation = "G/L Account"."No." WHERE("Account Type" = FILTER(Posting),
                                                                   "Direct Posting" = FILTER(true));
                    }
                    field(DocNo; DocNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No.';
                        ToolTip = 'Enter the document number for the WIP posting. The system will use this document number for both the WIP posting and reversal lines.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            GLSetup.GET();
            AccNo := GLSetup."WIP Account FND";
            BallAccNo := GLSetup."Bal. Wip Account FND";
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        if ReversalPostingDate = 0D then
            ERROR(Text002);
        if AccNo = '' then
            ERROR(Text003);
        if BallAccNo = '' then
            ERROR(Text004);
        if GenJnlLine."Journal Batch Name" = '' then
            ERROR(Text005);
        if GenJnlLine."Journal Template Name" = '' then
            ERROR(Text006);
        if PostingDate = 0D then
            ERROR(Text007);
        if DocNo = '' then
            ERROR(Text008);
    end;

    var
        PostingDate: Date;
        ReversalPostingDate: Date;
        AccNo: Code[20];
        BallAccNo: Code[20];
        GenJnlLine: Record "Gen. Journal Line";
        DocNo: Code[20];
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        Text001: Label 'Wip Prod. Order No. %1';
        Text002: Label 'Reversal Posting date must not be blank';
        Text003: Label 'Account no. must not be blank';
        Text004: Label 'Ball. account no. must not be blank';
        Text005: Label 'General Journal Batch must not be blank';
        Text006: Label 'General Template must not be blank';
        Text007: Label 'Posting date must not be blank';
        Text008: Label 'Document no. must not be blank';
        GLSetup: Record "General Ledger Setup";

    local procedure MakeGLLine(PostingDate: Date; Amount: Decimal);
    var
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
    begin
        GenJournalLine.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
        GenJournalLine.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
        if GenJournalLine.FINDLAST() then
            LineNo := GenJournalLine."Line No." + 10000
        else
            LineNo := 10000;
        CLEAR(GenJournalLine);
        GenJournalLine.INIT();
        GenJournalLine."Journal Template Name" := GenJnlLine."Journal Template Name";
        GenJournalLine."Journal Batch Name" := GenJnlLine."Journal Batch Name";
        GenJournalLine."Line No." := LineNo;
        GenJournalLine.INSERT();
        GenJournalLine.VALIDATE("Posting Date", PostingDate);
        GenJournalLine.VALIDATE("Document No.", DocNo);
        GenJournalLine.VALIDATE("External Document No.", "Prod. Order Line"."Prod. Order No.");
        GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Account No.", AccNo);
        GenJournalLine.VALIDATE(Amount, Amount);
        GenJournalLine.VALIDATE("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        GenJournalLine.VALIDATE("Bal. Account No.", BallAccNo);
        GenJournalLine.VALIDATE(Description, STRSUBSTNO(Text001, "Prod. Order Line"."Prod. Order No."));
        GenJournalLine.MODIFY(true);
    end;
}

