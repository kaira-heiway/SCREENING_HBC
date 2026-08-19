report 53059 "Free Goods Accounting (HNK)"
{
    // HEI.01  FDD-HB1609 CHG2074002 IBM BULIMC01 26.08.2020 #new report created for Free Goods Accounting

    // BC Upgrade KUMARR78 >>
    // Report Name  : Free Goods Accounting (HNK)
    // Report ID    : 50453
    //
    // 1. Added Business Central visibility properties.
    //    Old:
    //         - ApplicationArea not mandatory in NAV.
    //         - UsageCategory not defined.
    //    New:
    //         - ApplicationArea = All
    //         - UsageCategory = ReportsAndAnalysis
    //
    // 2. Added ApplicationArea on Request Page fields.
    //    Old:
    //         - Request page fields without ApplicationArea.
    //    New:
    //         - ApplicationArea = All added to:
    //              • PostingFrom
    //              • PostingTo
    //              • ToGenJournalName
    //              • ToGenBatch
    //
    // 3. Updated OnLookup trigger signature to BC standard.
    //    Old:
    //         trigger OnLookup(Text: Text): Boolean;
    //    New:
    //         trigger OnLookup(var Text: Text): Boolean;
    //    Applied on:
    //         • ToGenBatch ("Gen. Journal Batch Name")
    //
    // 4. Removed DIT-specific filters from Sales Invoice Line (OnPreDataItem).
    //    Old:
    //         SETRANGE("Free Item", true);
    //         SETFILTER("Free Reason Code", '<>%1', '');
    //    New:
    //         - DIT fields commented as removed in BC.
    //         - Filtering retained on:
    //              • Posting Date
    //              • Type = Item
    //
    // 5. Removed DIT-specific filters from Value Entry (Cost calculation).
    //    Old:
    //         ValueEntry.SETRANGE("Item Charge Type", ...);
    //         ValueEntry.SETRANGE("Free Item", true);
    //         ValueEntry.SETFILTER("Free Reason Code", '<>%1', '');
    //    New:
    //         - All DIT field filters commented.
    //         - ValueEntry filtered by:
    //              • Document No.
    //              • Posting Date
    //              • Item No.
    //
    // 6. Updated ItemChargeSalesLine key after DIT field removal.
    //    Old:
    //         SETCURRENTKEY("Document No.", "Attached to Line No.", "Is Item Charge");
    //    New:
    //         SETCURRENTKEY("Document No.", "Attached to Line No.");
    //         - "Is Item Charge" field removed in BC.
    //         - Key adjusted to standard BC fields.
    //
    // 7. Removed DIT-specific filters from VAT calculation logic.
    //    Old:
    //         SETRANGE("Is Item Charge", true);
    //         SETRANGE("Item Charge Type", Tax);
    //         ValueEntry filters on DIT fields.
    //    New:
    //         - DIT field filters commented.
    //         - VAT calculation based on:
    //              • Document No.
    //              • Attached to Line No.
    //              • ValueEntry."Cost Amount (Actual)"
    //              • ItemChargeSalesLine."VAT %"
    //
    // BC Upgrade KUMARR78 <<

    Caption = 'Free Goods Accounting (HNK)';
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            RequestFilterFields = "Document No.", "Sell-to Customer No.";

            trigger OnAfterGetRecord();
            begin
                Customer.Reset();
                Customer.Get("Sell-to Customer No.");
                if not Customer."Free Goods Accounting HNK FND" then
                    CurrReport.Skip();

                if "Sales Invoice Line"."Free Goods Posted FND" then
                    AlreadyPosted += 1
                else begin
                    //check Free Goods Gen. Posting Gr. Accounts
                    GeneralPostingSetup.Get("Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
                    if GeneralPostingSetup."Cost of Free Goods (HNK) FND" = '' then
                        Error(Text002, GeneralPostingSetup.FieldCaption("Cost of Free Goods (HNK) FND"), GeneralPostingSetup.TableCaption, GeneralPostingSetup."Gen. Bus. Posting Group", GeneralPostingSetup."Gen. Prod. Posting Group");
                    if GeneralPostingSetup."HNK Free Goods Offset Acc. FND" = '' then
                        Error(Text002, GeneralPostingSetup.FieldCaption("HNK Free Goods Offset Acc. FND"), GeneralPostingSetup.TableCaption, GeneralPostingSetup."Gen. Bus. Posting Group", GeneralPostingSetup."Gen. Prod. Posting Group");

                    if SalesInvoiceHeader.Get("Sales Invoice Line"."Document No.") then;

                    //insert Cost of Free Goods into the temporary table
                    InsertGLCostOfFreeGoodsValue("Sales Invoice Line", GeneralPostingSetup, SalesInvoiceHeader."Dimension Set ID");

                    //insert VAT amount into the temporary table

                    //check Free Goods VAT Account
                    VATPostingSetup.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group");
                    if VATPostingSetup."Free Goods VAT (HNK) FND" = '' then
                        Error(Text002, VATPostingSetup.FieldCaption("Free Goods VAT (HNK) FND"), VATPostingSetup.TableCaption, VATPostingSetup."VAT Bus. Posting Group", VATPostingSetup."VAT Prod. Posting Group");
                    InsertFreeGoodVATValue("Sales Invoice Line", VATPostingSetup, SalesInvoiceHeader."Dimension Set ID");

                    Created += 1;
                end;
            end;

            trigger OnPostDataItem();
            begin
                //insert Gen lines from the temporary tables
                TransferFromTemp(TempGenJnlLineGLCost);
                TransferFromTemp(TempGenJnlLineVAT);
            end;

            trigger OnPreDataItem();
            begin
                SetRange("Posting Date", PostingFrom, PostingTo);
                SetRange(Type, Type::Item);
                // SETRANGE("Free Item", true); //BC Upgrade KUMARR78 DIT Field Removed
                // SETFILTER("Free Reason Code", '<>%1', '');//BC Upgrade KUMARR78 DIT Field Removed
            end;
        }
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.") order(ascending);

            trigger OnAfterGetRecord();
            begin
                //insert HNK Off. Acc
                GeneralPostingSetup.Reset();
                if GeneralPostingSetup.Get("Gen. Bus. Posting Group", "Gen. Prod. Posting Group") then;
                if GLAccount.Get(GeneralPostingSetup."HNK Free Goods Offset Acc. FND") then;

                TempTotalGnlJnllLine.Reset();
                TempTotalGnlJnllLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "VAT Bus. Posting Group", "VAT Prod. Posting Group");
                TempTotalGnlJnllLine.SetRange("Journal Template Name", "Journal Template Name");
                TempTotalGnlJnllLine.SetRange("Journal Batch Name", "Journal Batch Name");
                TempTotalGnlJnllLine.SetRange("Posting Date", "Posting Date");
                TempTotalGnlJnllLine.SetRange("Document No.", "Document No.");
                TempTotalGnlJnllLine.SetRange("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
                TempTotalGnlJnllLine.SetRange("Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                if not TempTotalGnlJnllLine.FindFirst() then begin
                    TempTotalGnlJnllLine.Init();
                    TempTotalGnlJnllLine.Validate("Journal Template Name", "Journal Template Name");
                    TempTotalGnlJnllLine.Validate("Journal Batch Name", "Journal Batch Name");
                    TempTotalGnlJnllLine.Validate("Line No.", EntryNo);
                    TempTotalGnlJnllLine.Validate("Posting Date", "Posting Date");
                    TempTotalGnlJnllLine.Validate("Document No.", "Document No.");
                    TempTotalGnlJnllLine.Validate("Source Code", GenJnlTemplate."Source Code");
                    TempTotalGnlJnllLine.Validate("Account Type", "Account Type"::"G/L Account");
                    TempTotalGnlJnllLine."Account No." := GeneralPostingSetup."HNK Free Goods Offset Acc. FND";
                    TempTotalGnlJnllLine.Description := GLAccount.Name;
                    TempTotalGnlJnllLine.Validate("Gen. Posting Type", TempTotalGnlJnllLine."Gen. Posting Type"::Sale);
                    TempTotalGnlJnllLine.Validate("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
                    TempTotalGnlJnllLine.Validate("Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                    TempTotalGnlJnllLine."VAT Bus. Posting Group" := '';
                    TempTotalGnlJnllLine."VAT Prod. Posting Group" := '';
                    TempTotalGnlJnllLine.Validate(Amount, -Amount);
                    TempTotalGnlJnllLine."Dimension Set ID" := "Dimension Set ID";
                    TempTotalGnlJnllLine."Free Goods Accounting FND" := true;
                    TempTotalGnlJnllLine.Insert();
                    EntryNo += 10000;
                end else begin
                    TempTotalGnlJnllLine.Amount += -Amount;
                    TempTotalGnlJnllLine.Validate(Amount);
                    TempTotalGnlJnllLine.Modify();
                end;
            end;

            trigger OnPostDataItem();
            begin
                TransferFromTemp(TempTotalGnlJnllLine);
            end;

            trigger OnPreDataItem();
            begin
                SetRange("Journal Template Name", ToGenJournalName);
                SetRange("Journal Batch Name", ToGenBatch);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                field(PostingFrom; PostingFrom)
                {
                    Caption = 'Posting From Date';
                    ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea 
                }
                field(PostingTo; PostingTo)
                {
                    Caption = 'Posting To Date';
                    ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                }
                field("Gen. Journal Template Name"; ToGenJournalName)
                {
                    CaptionML = ENU = 'Gen. Journal Template Name',
                                NLD = 'Fin. dagboeksjabloon naam';
                    TableRelation = "Gen. Journal Template".Name;
                    ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea
                }
                field("Gen. Journal Batch Name"; ToGenBatch)
                {
                    Caption = 'Gen. Journal Batch Name';
                    TableRelation = "Gen. Journal Batch".Name;
                    ApplicationArea = All;//BC Upgrade KUMARR78 Adding ApplicationArea

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Clear(GnlJnlBatchesPage);
                        GenJournalBatch.SetRange("Journal Template Name", ToGenJournalName);
                        GnlJnlBatchesPage.SetTableView(GenJournalBatch);
                        GnlJnlBatchesPage.LookupMode(true);
                        if GnlJnlBatchesPage.RunModal() = Action::LookupOK then
                            Text := GnlJnlBatchesPage.GetSelectionFilter()
                        else
                            exit(false);
                        exit(true);
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
        if Inserted then
            Message(Text003, Created, AlreadyPosted, GenJnlTemplate.TableCaption, ToGenJournalName, GenJnlBatch.TableCaption, ToGenBatch)
        else
            Message(Text005);
    end;

    trigger OnPreReport();
    begin
        if ToGenJournalName = '' then
            Error(Text001, 'General Journal Template');
        if ToGenBatch = '' then
            Error(Text001, 'General Journal Batch');

        GenJnlTemplate.Get(ToGenJournalName);
        GenJournalLine.SetRange("Journal Batch Name", ToGenBatch);
        GenJournalLine.SetRange("Journal Template Name", ToGenJournalName);
        if not GenJournalLine.IsEmpty then begin
            if Confirm(Text004, true, ToGenJournalName, ToGenBatch) then begin
                GenJournalLine.DeleteAll();
                EntryNo := 10000;
            end else if GenJournalLine.Find('+') then
                    EntryNo := GenJournalLine."Line No." + 10000;
        end else
            EntryNo := 10000;
    end;

    var
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GenBusPostingGroup: Record "Gen. Business Posting Group";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        TempGenJnlLineGLCost: Record "Gen. Journal Line" temporary;
        TempGenJnlLineVAT: Record "Gen. Journal Line" temporary;
        TempTotalGnlJnllLine: Record "Gen. Journal Line" temporary;
        GenJnlTemplate: Record "Gen. Journal Template";
        GeneralPostingSetup: Record "General Posting Setup";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ValueEntry: Record "Value Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        GnlJnlBatchesPage: Page "General Journal Batches";
        Inserted: Boolean;
        ToGenBatch: Code[10];
        ToGenJournalName: Code[10];
        PostingFrom: Date;
        PostingTo: Date;
        AlreadyPosted: Integer;
        Created: Integer;
        EntryNo: Integer;
        Text001: Label '%1 must not be empty!';
        Text002: Label '%1 account do not exist in %2 for %3 and %4 combination.';
        Text003: Label 'Total of %1 documents for which journal entries have been created. \\Documents for which journal entries are already posted: %2. \\The entries have been successfully created in the %3 %4, %5 %6.';
        Text004: Label 'Gen. Journal %1, Gen. Batch %2 already has entries. Do you want to delete them?';
        Text005: Label 'No lines inserted.';

    local procedure InsertGLCostOfFreeGoodsValue(SalesInvoiceLine: Record "Sales Invoice Line"; GenPostingSetup: Record "General Posting Setup"; DimSetID: Integer);
    begin
        //insert Value Entry amount
        if GLAccount.Get(GenPostingSetup."Cost of Free Goods (HNK) FND") then;

        ValueEntry.Reset();
        ValueEntry.SetCurrentKey("Document No.", "Posting Date");
        ValueEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        ValueEntry.SetRange("Posting Date", SalesInvoiceLine."Posting Date");
        ValueEntry.SetRange("Item No.", SalesInvoiceLine."No.");
        // ValueEntry.SETRANGE("Item Charge Type", ValueEntry."Item Charge Type"::" ");//BC Upgrade KUMARR78 DIT Field Removed
        // ValueEntry.SETRANGE("Free Item", true); //BC Upgrade KUMARR78 DIT Field Removed
        // ValueEntry.SETFILTER("Free Reason Code", '<>%1', ''); //BC Upgrade KUMARR78 DIT Field Removed
        if ValueEntry.FindFirst() then begin
            TempGenJnlLineGLCost.Reset();
            TempGenJnlLineGLCost.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group");
            TempGenJnlLineGLCost.SetRange("Journal Template Name", ToGenJournalName);
            TempGenJnlLineGLCost.SetRange("Journal Batch Name", ToGenBatch);
            TempGenJnlLineGLCost.SetRange("Posting Date", ValueEntry."Posting Date");
            TempGenJnlLineGLCost.SetRange("Document No.", ValueEntry."Document No.");
            TempGenJnlLineGLCost.SetRange("Gen. Bus. Posting Group", GenPostingSetup."Gen. Bus. Posting Group");
            TempGenJnlLineGLCost.SetRange("Gen. Prod. Posting Group", GenPostingSetup."Gen. Prod. Posting Group");
            if not TempGenJnlLineGLCost.FindFirst() then begin
                TempGenJnlLineGLCost.Init();
                TempGenJnlLineGLCost.Validate("Journal Template Name", ToGenJournalName);
                TempGenJnlLineGLCost.Validate("Journal Batch Name", ToGenBatch);
                TempGenJnlLineGLCost.Validate("Line No.", EntryNo);
                TempGenJnlLineGLCost.Validate("Posting Date", ValueEntry."Posting Date");
                TempGenJnlLineGLCost.Validate("Document No.", ValueEntry."Document No.");
                TempGenJnlLineGLCost.Validate("Source Code", GenJnlTemplate."Source Code");
                TempGenJnlLineGLCost.Validate("Account Type", TempGenJnlLineGLCost."Account Type"::"G/L Account");
                TempGenJnlLineGLCost."Account No." := GenPostingSetup."Cost of Free Goods (HNK) FND";
                TempGenJnlLineGLCost.Description := GLAccount.Name;
                TempGenJnlLineGLCost.Validate("Gen. Bus. Posting Group", GenPostingSetup."Gen. Bus. Posting Group");
                TempGenJnlLineGLCost.Validate("Gen. Prod. Posting Group", GenPostingSetup."Gen. Prod. Posting Group");
                TempGenJnlLineGLCost."VAT Bus. Posting Group" := '';
                TempGenJnlLineGLCost."VAT Prod. Posting Group" := '';
                TempGenJnlLineGLCost.Validate(Amount, Abs(ValueEntry."Cost Amount (Actual)"));
                TempGenJnlLineGLCost.Validate("Gen. Posting Type", TempGenJnlLineGLCost."Gen. Posting Type"::Sale);
                TempGenJnlLineGLCost.Validate("Dimension Set ID", DimSetID);
                TempGenJnlLineGLCost."Free Goods Accounting FND" := true;
                TempGenJnlLineGLCost.Insert();
                EntryNo += 10000;
            end else begin
                TempGenJnlLineGLCost.Amount += Abs(ValueEntry."Cost Amount (Actual)");
                TempGenJnlLineGLCost.Validate(Amount);
                TempGenJnlLineGLCost.Modify();
            end;
        end;
    end;

    local procedure InsertFreeGoodVATValue(SalesInvoiceLine: Record "Sales Invoice Line"; VATPstSetup: Record "VAT Posting Setup"; DimSetID: Integer);
    var
        ItemChargeSalesLine: Record "Sales Invoice Line";
        GLEntryFound: Boolean;
    begin
        if GLAccount.Get(VATPstSetup."Free Goods VAT (HNK) FND") then;

        ItemChargeSalesLine.Reset();
        // ItemChargeSalesLine.SETCURRENTKEY("Document No.", "Attached to Line No.", "Is Item Charge");//BC Upgrade KUMARR78 DIT Field Removed("Is Item Charge")
        ItemChargeSalesLine.SETCURRENTKEY("Document No.", "Attached to Line No.");//BC Upgrade KUMARR78 DIT Field Removed and Replacing the Expresion.
        ItemChargeSalesLine.SetRange("Document No.", SalesInvoiceLine."Document No.");
        ItemChargeSalesLine.SetRange("Attached to Line No.", SalesInvoiceLine."Line No.");
        // ItemChargeSalesLine.SETRANGE("Is Item Charge", true);//BC Upgrade KUMARR78 DIT Field Removed
        // ItemChargeSalesLine.SETRANGE("Item Charge Type", ItemChargeSalesLine."Item Charge Type"::Tax);//BC Upgrade KUMARR78 DIT Field Removed
        if ItemChargeSalesLine.FindFirst() then begin
            ValueEntry.Reset();
            ValueEntry.SetCurrentKey("Document No.", "Posting Date");
            ValueEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
            ValueEntry.SetRange("Posting Date", SalesInvoiceLine."Posting Date");
            ValueEntry.SetRange("Item No.", SalesInvoiceLine."No.");
            // ValueEntry.SETRANGE("Item Charge Type", ValueEntry."Item Charge Type"::" ");//BC Upgrade KUMARR78 DIT Field Removed
            // ValueEntry.SETRANGE("Free Item", true);//BC Upgrade KUMARR78 DIT Field Removed
            // ValueEntry.SETFILTER("Free Reason Code", '<>%1', '');//BC Upgrade KUMARR78 DIT Field Removed
            if ValueEntry.FindFirst() then begin
                TempGenJnlLineVAT.Reset();
                TempGenJnlLineVAT.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.", "VAT Bus. Posting Group", "VAT Prod. Posting Group");
                TempGenJnlLineVAT.SetRange("Journal Template Name", ToGenJournalName);
                TempGenJnlLineVAT.SetRange("Journal Batch Name", ToGenBatch);
                TempGenJnlLineVAT.SetRange("Posting Date", SalesInvoiceLine."Posting Date");
                TempGenJnlLineVAT.SetRange("Document No.", SalesInvoiceLine."Document No.");
                TempGenJnlLineVAT.SetRange("VAT Bus. Posting Group", VATPstSetup."VAT Bus. Posting Group");
                TempGenJnlLineVAT.SetRange("VAT Prod. Posting Group", VATPstSetup."VAT Prod. Posting Group");
                if not TempGenJnlLineVAT.FindFirst() then begin
                    TempGenJnlLineVAT.Init();
                    TempGenJnlLineVAT.Validate("Journal Template Name", ToGenJournalName);
                    TempGenJnlLineVAT.Validate("Journal Batch Name", ToGenBatch);
                    TempGenJnlLineVAT.Validate("Line No.", EntryNo);
                    TempGenJnlLineVAT.Validate("Posting Date", SalesInvoiceLine."Posting Date");
                    TempGenJnlLineVAT.Validate("Document No.", SalesInvoiceLine."Document No.");
                    TempGenJnlLineVAT.Validate("Source Code", GenJnlTemplate."Source Code");
                    TempGenJnlLineVAT."Account Type" := TempGenJnlLineVAT."Account Type"::"G/L Account";
                    TempGenJnlLineVAT."Account No." := VATPstSetup."Free Goods VAT (HNK) FND";
                    TempGenJnlLineVAT.Description := GLAccount.Name;
                    TempGenJnlLineVAT.Validate("Gen. Bus. Posting Group", SalesInvoiceLine."Gen. Bus. Posting Group");
                    TempGenJnlLineVAT.Validate("Gen. Prod. Posting Group", SalesInvoiceLine."Gen. Prod. Posting Group");
                    TempGenJnlLineVAT."VAT Bus. Posting Group" := '';
                    TempGenJnlLineVAT."VAT Prod. Posting Group" := '';
                    TempGenJnlLineVAT.Validate("Gen. Posting Type", TempGenJnlLineVAT."Gen. Posting Type"::Sale);
                    TempGenJnlLineVAT.Validate(Amount, Abs(ValueEntry."Cost Amount (Actual)" * ItemChargeSalesLine."VAT %" / 100));
                    TempGenJnlLineVAT.Validate("Dimension Set ID", DimSetID);
                    TempGenJnlLineVAT."Free Goods Accounting FND" := true;
                    TempGenJnlLineVAT.Insert();
                    EntryNo += 10000;
                end else begin
                    TempGenJnlLineVAT.Amount += Abs(ValueEntry."Cost Amount (Actual)" * ItemChargeSalesLine."VAT %" / 100);
                    TempGenJnlLineVAT.Validate(Amount);
                    TempGenJnlLineVAT.Modify();
                end;
            end;
        end;
    end;

    local procedure TransferFromTemp(var TempGenJnl: Record "Gen. Journal Line" temporary);
    begin
        Clear(TempGenJnl);
        TempGenJnl.SetFilter(Amount, '<>%1', 0);
        if TempGenJnl.FindSet() then
            repeat
                GenJournalLine.Reset();
                GenJournalLine.TransferFields(TempGenJnl);
                GenJournalLine.Insert();
                Inserted := true;
            until TempGenJnl.Next() = 0;
    end;
}

