//namespace INTERFACES.INTERFACES;

pageextension 58077 PaymentJournalTreeExtINT extends "Payment Journal Tree CBN"
{
    //BC UPGRADE ATHUKS01>>
    //1.Added new method for checking the Gen. Journal Batch level restrictions before exporting the payments to file or WS.
    //2.Added new code for perfomance improvement while exporting payments to WS by using temporary record and batch insert. 
    //BC UPGRADE ATHUKS01<<

    actions
    {
        addafter(ApplyEntries)
        {
            action(ExportPaymentsToFile)
            {
                ApplicationArea = All;
                Caption = 'Export Payments to File';
                Ellipsis = true;
                Image = ExportFile;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Export a file with the payment information on the journal lines.';
                trigger OnAction();
                var
                    GenJnlLine: Record "Gen. Journal Line";
                    lBankExportImportSetup: Record "Bank Export/Import Setup";
                    BankConnInterfaceMgt: CodeUnit "Bank Conn. Interface Mgt."; // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan
                    GenJnlLineTmp: Record "Gen. Journal Line BC FND" temporary;
                    lInfoSentToWS: Boolean;
                    lText50000: Label 'Journal lines were sent to WS!';
                    GenJournalLineBC: Record "Gen. Journal Line BC FND";
                    lCurrency: Record Currency;
                    lUserSetup: Record "User Setup";
                    lText50001: Label 'You are not allowed to reexport the payment!';
                    lText50002: Label 'For Line No. %1, Document No. %2, Amount cannot have decimals!';
                    BankConnInterfaceMgt2: CodeUnit "Bank Conn. Interface Mgt. 2"; // BC Upgrade KUMARS145 Dependent on Codeunit 50204	Bank Conn. Interface Mgt. 2	Heineken_Interface			#Bogdan
                    BankConnSetupFound: Boolean;
                    lText50003: Label 'There is no Bank Export/Import Setup for Bank Connectivity!';
                    ApprovalManagement: CodeUnit "Approvals Mgmt.";
                    GenJournalBatch: Record "Gen. Journal Batch";
                    RestrictionManagement: CodeUnit "Gen. Jnl.-Post Batch";
                    CurrentJnlBatchName: Code[10];
                begin
                    //HEI.03>>
                    Rec.SetRange("Tree Level FND", 0);
                    //HEI.03<<

                    //HEI.16>>
                    /*
                    GenJnlLine.CopyFilters(Rec);
                    GenJnlLine.FindFirst();
                    GenJnlLine.ExportPaymentFile;
                    */

                    //HEI.36>>
                    BankConnSetupFound := false;
                    //HEI.36<<

                    lBankExportImportSetup.Reset();
                    lBankExportImportSetup.SetRange("Journal Template Name FND", Rec."Journal Template Name");
                    lBankExportImportSetup.SetRange("Journal Batch Name FND", Rec."Journal Batch Name");
                    lBankExportImportSetup.SetRange("Processing CodeUnit ID", CodeUnit::"Bank Conn. Interface Mgt.");// BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan
                    //HEI.36>>
                    lBankExportImportSetup.SetRange("OPCO FND", lBankExportImportSetup."OPCO FND"::"Ivory Coast");
                    //HEI.36<<
                    if lBankExportImportSetup.FindFirst() then begin
                        //HEI.44>>
                        GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                        if ApprovalManagement.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
                            // Rec.OnCheckGenJournalLinePostRestrictions();// BC Upgrade KUMARS145 Blank Procedure in Table 81 which does not exist.
                            OnCheckGenJournalBatchPostRestrictions(Rec.RecordId); //BC UPGRADE ATHUKS01>> 
                        end;
                        //HEI.44<<

                        // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan ......>>  
                        if (lBankExportImportSetup."Send to WS FND" = true) and (lBankExportImportSetup."Processing CodeUnit ID" = CodeUnit::"Bank Conn. Interface Mgt.") then begin
                            GenJnlLine.Reset();
                            GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                            GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            GenJnlLine.SetRange("WS Posting Allowed FND", true);//if payment was already exported
                            if GenJnlLine.FindFirst() then
                                if lUserSetup.Get(UserId) then
                                    if lUserSetup."Allow to Reexport Pay WS FND" = false then
                                        Error(lText50001);

                            GenJournalLineBC.Reset();
                            //BC UPGRADE ATHUKS01>>
                            GenJournalLineBC.SetCurrentKey("Journal Template Name", "Journal Batch Name");
                            GenJournalLineBC.SetBaseLoadFields();
                            //BC UPGRADE ATHUKS01<<
                            GenJournalLineBC.SetRange("Journal Template Name", Rec."Journal Template Name");
                            GenJournalLineBC.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            GenJournalLineBC.DeleteAll();

                            GenJnlLine.Reset();
                            GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                            GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            GenJnlLine.SetFilter("Parent Line No. FND", '=%1', 0);
                            if GenJnlLine.FindFirst() then
                                repeat
                                    GenJnlLine.TestField("HNK Bank Account FND");
                                    GenJnlLine.TestField("Customer/Vendor Bank FND");
                                    GenJnlLine.TestField("Posting Date");
                                    GenJnlLine.TestField("Account Type");
                                    GenJnlLine.TestField("Account No.");
                                    if GenJnlLine."Currency Code" <> '' then
                                        if lCurrency.Get(GenJnlLine."Currency Code") then begin
                                            lCurrency.TestField("ISO Currency Code FND");
                                            if lCurrency."BC - Send Without Decimals FND" = true then
                                                if (GenJnlLine.Amount mod 1) <> 0 then
                                                    Error(lText50002, GenJnlLine."Line No.", GenJnlLine."Document No.");
                                        end;
                                    if GenJnlLine."Currency Code" = '' then begin
                                        if lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = true then
                                            if (GenJnlLine.Amount mod 1) <> 0 then
                                                Error(lText50002, GenJnlLine."Line No.", GenJnlLine."Document No.");
                                    end;

                                    GenJournalLineBC.TransferFields(GenJnlLine);
                                    GenJournalLineBC.Insert();
                                until GenJnlLine.Next() = 0;

                            GenJnlLine.Reset();
                            GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                            GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            GenJnlLine.SetFilter("Parent Line No. FND", '=%1', 0);
                            if GenJnlLine.FindFirst() then begin
                                GenJnlLineTmp.TransferFields(GenJnlLine);
                                GenJnlLineTmp.Insert();
                            end;

                            if lBankExportImportSetup."Post WS Entries FND" then begin
                                CodeUnit.Run(CodeUnit::"Gen. Jnl.-Post", Rec);
                                CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                                CurrPage.Update(false);
                            end;

                            lInfoSentToWS := false;
                            if GenJnlLineTmp.FindFirst() then
                                repeat
                                    BankConnInterfaceMgt.CreateNonSepaPayment(GenJnlLineTmp);
                                    lInfoSentToWS := true;
                                until GenJnlLineTmp.Next() = 0;
                            if lInfoSentToWS = true then
                                Message(lText50000);
                        end else begin
                            GenJnlLine.CopyFilters(Rec);
                            GenJnlLine.FindFirst();
                            GenJnlLine.ExportPaymentFile();
                        end;
                        // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan......<<

                        //HEI.36>>
                        BankConnSetupFound := true;
                        //HEI.36<<
                    end;
                    //HEI.36>>
                    //ELSE Error(Text50001);
                    //HEI.36<<
                    //HEI.16<<

                    //HEI.36>>
                    lBankExportImportSetup.Reset();
                    lBankExportImportSetup.SetRange("Journal Template Name FND", Rec."Journal Template Name");
                    lBankExportImportSetup.SetRange("Journal Batch Name FND", Rec."Journal Batch Name");
                    //HEI.38>>
                    // lBankExportImportSetup.SetRange("Processing CodeUnit ID", CodeUnit::"Bank Conn. Interface Mgt. 2");//HEI.44 // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan
                    //HEI.41>>
                    //lBankExportImportSetup.SetFilter(OPCO,'%1|%2',lBankExportImportSetup.OPCO::Panama,lBankExportImportSetup.OPCO::"Ethiopia-CBE");
                    //lBankExportImportSetup.SetFilter(OPCO,'%1|%2|%3',lBankExportImportSetup.OPCO::Panama,lBankExportImportSetup.OPCO::"Ethiopia-CBE",lBankExportImportSetup.OPCO::MZ); //HEI.44
                    //HEI.41<<
                    //HEI.38<<
                    if lBankExportImportSetup.FindFirst() then begin

                        //HEI.41>>
                        //IF lBankExportImportSetup.OPCO =lBankExportImportSetup.OPCO::MZ THEN BEGIN //HEI.44
                        GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name");
                        if ApprovalManagement.IsGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
                            // Rec.OnCheckGenJournalLinePostRestrictions();// BC Upgrade KUMARS145 Blank Procedure in Table 81 which does not exist.
                            OnCheckGenJournalBatchPostRestrictions(Rec.RecordId); //BC UPGRADE ATHUKS01>>
                        end;
                        //END;//HEI.44
                        //HEI.41<<

                        // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan ......>>  
                        if (lBankExportImportSetup."Send to WS FND" = true) and (lBankExportImportSetup."Processing CodeUnit ID" = CodeUnit::"Bank Conn. Interface Mgt. 2") then begin
                            GenJnlLine.Reset();
                            GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                            GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            GenJnlLine.SetRange("WS Posting Allowed FND", true);//if payment was already exported
                            if GenJnlLine.FindFirst() then
                                if lUserSetup.Get(UserId) then
                                    if lUserSetup."Allow to Reexport Pay WS FND" = false then
                                        Error(lText50001);

                            GenJournalLineBC.Reset();
                            //BC UPGRADE ATHUKS01>>
                            GenJournalLineBC.SetCurrentKey("Journal Template Name", "Journal Batch Name");
                            GenJournalLineBC.SetBaseLoadFields();
                            //BC UPGRADE ATHUKS01<<
                            GenJournalLineBC.SetRange("Journal Template Name", Rec."Journal Template Name");
                            GenJournalLineBC.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            GenJournalLineBC.DeleteAll();

                            GenJnlLine.Reset();
                            GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                            GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            GenJnlLine.SetFilter("Parent Line No. FND", '=%1', 0);
                            if GenJnlLine.FindFirst() then
                                repeat
                                    GenJnlLine.TestField("HNK Bank Account FND");
                                    GenJnlLine.TestField("Customer/Vendor Bank FND");
                                    GenJnlLine.TestField("Posting Date");
                                    GenJnlLine.TestField("Account Type");
                                    GenJnlLine.TestField("Account No.");
                                    if GenJnlLine."Currency Code" <> '' then
                                        if lCurrency.Get(GenJnlLine."Currency Code") then begin
                                            lCurrency.TestField("ISO Currency Code FND");
                                            if lCurrency."BC - Send Without Decimals FND" = true then
                                                if (GenJnlLine.Amount mod 1) <> 0 then
                                                    Error(lText50002, GenJnlLine."Line No.", GenJnlLine."Document No.");
                                        end;
                                    if GenJnlLine."Currency Code" = '' then begin
                                        if lBankExportImportSetup."BC (LCY) - Send W/O Dec. FND" = true then
                                            if (GenJnlLine.Amount mod 1) <> 0 then
                                                Error(lText50002, GenJnlLine."Line No.", GenJnlLine."Document No.");
                                    end;

                                    GenJournalLineBC.TransferFields(GenJnlLine);
                                    GenJournalLineBC.Insert();
                                until GenJnlLine.Next() = 0;

                            GenJnlLine.Reset();
                            GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                            GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                            GenJnlLine.SetFilter("Parent Line No. FND", '=%1', 0);
                            if GenJnlLine.FindFirst() then begin
                                GenJnlLineTmp.TransferFields(GenJnlLine);
                                GenJnlLineTmp.Insert();
                            end;

                            if lBankExportImportSetup."Post WS Entries FND" then begin
                                CodeUnit.Run(CodeUnit::"Gen. Jnl.-Post", Rec);
                                CurrentJnlBatchName := Rec.GetRangeMax("Journal Batch Name");
                                CurrPage.Update(false);
                            end;

                            lInfoSentToWS := false;
                            if GenJnlLineTmp.FindFirst() then
                                repeat
                                    BankConnInterfaceMgt2.CreateNonSepaPayment(GenJnlLineTmp);
                                    lInfoSentToWS := true;
                                until GenJnlLineTmp.Next() = 0;
                            if lInfoSentToWS = true then
                                Message(lText50000);
                        end else begin
                            GenJnlLine.CopyFilters(Rec);
                            GenJnlLine.FindFirst();
                            GenJnlLine.ExportPaymentFile();
                        end;
                        // BC Upgrade KUMARS145 Dependent on Codeunit 50069	Bank Conn. Interface Mgt.	Heineken_Interface  #Bogdan......<<

                        BankConnSetupFound := true;
                    end;
                    //HEI.36<<

                    //HEI.36>>
                    if BankConnSetupFound = false then
                        Error(lText50003);
                    //HEI.36<<

                end;
            }
        }
    }
    //BC UPGRADE ATHUKS01>>
    local procedure OnCheckGenJournalBatchPostRestrictions(RecID: RecordId)
    var
        GnlBacth: Record "Gen. Journal Batch";
        RecordRestriction: Record "Restricted Record";
        RestrictLineUsageDetailsTxt: Label 'The restriction was imposed because the line requires approval.';
        RestrictBatchUsageDetailsTxt: Label 'The restriction was imposed because the journal batch requires approval.';
    begin
        RecordRestriction.SetRange("Record ID", RecID);
        if RecordRestriction.FindFirst() then
            Error(RestrictBatchUsageDetailsTxt);
    end;
    //BC UPGRADE ATHUKS01<<
}
