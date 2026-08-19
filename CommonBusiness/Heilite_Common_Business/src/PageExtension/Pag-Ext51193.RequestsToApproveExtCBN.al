pageextension 51193 RequestToApproveExtCBN extends "Requests to Approve"
{
    //  HEI.02 RFC-CHG0255777 IBM.LS 18.12.2018
    //         # Code added to call "ValidateCustomerMinValue" function.
    //       HEI.03 Bugfixing Bahamas IBM NASTAA02 04.04.2019 # Add new Fields
    //         # Added fields:"Approver Avail. Cr.Limit (LCY)", "Available Credit Limit (LCY)"
    //       DITW111.00.13A MSF 22/04/2019 NRQ#103938 Sales Approval Workflow for Credit Limit, Overdue and deposit limit
    //                                                Added field "Approved ID","Approval Type"
    //       DITW111.00.13A DDR 02/07/2019 NRQ#103938 Added field "Initiated By User ID"
    //       HEI.04 Defect#4558 IBM BULIMC01 10.10.2019 #Visibility property for "Status" field changed to "True"
    //       HEI.05 CHG2049056 IBM.LS      17.05.2021
    //         # Added Code
    //         # Added Fields - Entry No.
    //                        - Workflow Step Instance ID
    //       HEI.06 CHG2127496 IBM SHIVAS05 13/12/2021
    //         # Save excel sheet when approver approve the payment.
    //       HEI.07 CHG2127496 IBM SHIVAS05 08/02/2022
    //         # Using 'Path for payment file' from OPCO Setup table Instead of 'Save Payment Sheet' from Company Information table
    //       HEI.08 CHG2181582 IBM SRIVAS07 16.03.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //         # Added Code in Aprove Action
    //       HEI.09 CHG2181582 IBM SRIVAS07 25.05.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //         # Added Code in Approve OnAction
    //BC Upgrade GUNREM01>> 23/12/25
    //GUNREM01 added code in Approve action (onbefore action and onafteraction trigger).
    //GUNREM01 added code in Rejected action( onafteraction trigger)
    //GUNREM01 Created new procedures GetStringAfterSpecialCharacter and GetStringBeforeSpecialCharacter
    //GUNREM01 Added new fields Available Credit Limit (LCY),Entry No. and Workflow Step Instance ID
    //BC Upgrade GUNREM01<< 23/12/25
    layout
    {
        // Add changes to page layout here
        modify(Status)
        {
            Visible = true; //BC Upgrade GUNREM01
        }
        addafter(Status)
        {
            //BC Upgrade GUNREM01>>
            // field("Approver Avail. Cr.Limit (LCY)"; Rec."Approver Avail. Cr.Limit (LCY)")
            // {
            //Drink_It field
            // }
            field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
            {
                ApplicationArea = all;
                Description = 'HEI.03';
                ToolTip = 'Specifies the remaining credit (in LCY) that exists for the customer.';
            }
            field("Entry No."; Rec."Entry No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Entry No. field.';
            }
            field("Workflow Step Instance ID"; Rec."Workflow Step Instance ID")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Workflow Step Instance ID field.';
            }
            //BC Upgrade GUNREM01<<

        }
    }

    actions
    {
        //BC Upgrade GUNREM01>>
        modify(Approve)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
                ApprovalEntry: Record 454;
                ApprovalsMgmt: Codeunit 1535;
                PurchasesPayablesSetupL: Record 312;
                ApprovalEntryL: Record 454;
                PurchaseHeaderL: Record 38;
                SalesHeaderL: Record 36;
                lrec_PurchHdr: Record 38;
                TempName: Text;
                BatchName: Text;
                GenJournalLine: Record 81;
                OPCOSetup: Record 50058;
                BankExportImportSetup: Record 1200;
            begin
                //HEI.06 >>
                //CompanyInformation.GET;//HEI.07
                //IF CompanyInformation."Save Payment Sheet" THEN BEGIN  //HEI.07
                OPCOSetup.GET();//HEI.07
                                //HEI.08>>
                BankExportImportSetup.RESET();
                //HEI.09>>
                //BankExportImportSetup.SETRANGE(OPCO,BankExportImportSetup.OPCO::MZ);
                BankExportImportSetup.SETFILTER("OPCO FND", '<>%1', BankExportImportSetup."OPCO FND"::" ");
                //HEI.09<<
                BankExportImportSetup.SETRANGE("Journal Template Name FND", TempName);
                BankExportImportSetup.SETRANGE("Journal Batch Name FND", BatchName);
                IF BankExportImportSetup.ISEMPTY THEN BEGIN
                    //HEI.08<<
                    IF OPCOSetup."Path for payment file" <> '' THEN BEGIN //HEI.07
                        IF (Rec."Approver ID" = USERID) AND (Rec."Approval Code" = 'PTP PT') AND (Rec.Status = Rec.Status::Open) THEN BEGIN
                            TempName := GetStringBeforeSpecialCharacter(Rec.RecordDetails(), ',');
                            TempName := GetStringAfterSpecialCharacter(TempName, ':');
                            BatchName := GetStringAfterSpecialCharacter(Rec.RecordDetails(), ',');
                            GenJournalLine.RESET();
                            GenJournalLine.SETRANGE("Journal Template Name", TempName);
                            GenJournalLine.SETRANGE("Journal Batch Name", BatchName);
                            IF GenJournalLine.FINDFIRST() THEN
                                REPORT.RUNMODAL(50542, FALSE, FALSE, GenJournalLine);
                        END;
                    END;
                END; //HEI.08
                     //HEI.06 <<
            end;
            //BC Upgrade GUNREM01<<

            //BC Upgrade GUNREM01>>
            trigger OnAfterAction()
            var
                myInt: Integer;
                ApprovalEntry: Record 454;
                ApprovalsMgmt: Codeunit 1535;
                PurchasesPayablesSetupL: Record 312;
                ApprovalEntryL: Record 454;
                PurchaseHeaderL: Record 38;
                SalesHeaderL: Record 36;
                lrec_PurchHdr: Record 38;
                TempName: Text;
                BatchName: Text;
                GenJournalLine: Record 81;
                OPCOSetup: Record 50058;
                BankExportImportSetup: Record 1200;
            begin
                //HEI.02>>
                IF (ApprovalEntry."Table ID" = 36) AND
                  (ApprovalEntry."Document Type" IN [ApprovalEntry."Document Type"::Order]) THEN BEGIN
                    ApprovalEntryL.RESET();
                    ApprovalEntryL.SETRANGE("Table ID", 36);
                    ApprovalEntryL.SETRANGE("Document Type", ApprovalEntryL."Document Type"::Order);
                    ApprovalEntryL.SETRANGE("Document No.", ApprovalEntry."Document No.");
                    ApprovalEntryL.SETRANGE(Status, ApprovalEntryL.Status::Approved);
                    ApprovalEntryL.SETRANGE("Approver ID", USERID);
                    IF ApprovalEntryL.FINDLAST() THEN BEGIN
                        SalesHeaderL.SETRANGE("Document Type", SalesHeaderL."Document Type"::Order);
                        SalesHeaderL.SETRANGE("No.", ApprovalEntryL."Document No.");
                        IF SalesHeaderL.FINDFIRST() THEN
                            SalesHeaderL.ValidateCustomerMinValue(SalesHeaderL);
                    END;
                END;
                //HEI.02<<

            end;
            //BC Upgrade GUNREM01<<
        }
        modify(Reject)
        {
            //BC Upgrade GUNREM01>>
            trigger OnAfterAction()
            begin
                //HEI.05>>
                ApprovalRejected(Rec);
                //HEI.05<<
            END;
            //BC Upgrade GUNREM01<<
        }

    }
    //BC Upgrade GUNREM01>>
    LOCAL PROCEDURE ApprovalRejected(ApprovalEntry: Record 454);
    VAR
        ItemJournalBatchL: Record 233;
        ItemJournalBatch1L: Record 233;
        ItemJournalLineL: Record 83;
        RecRefL: RecordRef;
    BEGIN
        //HEI.05>>
        ApprovalEntry.SETCURRENTKEY("Table ID", "Approver ID", Status);
        ApprovalEntry.SETRANGE("Table ID", DATABASE::"Item Journal Batch");
        ApprovalEntry.SETRANGE("Approver ID", USERID);
        ApprovalEntry.SETRANGE(Status, ApprovalEntry.Status::Rejected);
        IF ApprovalEntry.FINDSET() THEN BEGIN
            REPEAT
                CLEAR(RecRefL);
                CLEAR(ItemJournalBatchL);
                IF RecRefL.GET(ApprovalEntry."Record ID to Approve") THEN BEGIN
                    RecRefL.SETTABLE(ItemJournalBatchL);
                    ItemJournalBatch1L.RESET();
                    ItemJournalBatch1L.SETCURRENTKEY("Journal Template Name", Name, "Use in Workflow FND");
                    ItemJournalBatch1L.SETRANGE("Journal Template Name", ItemJournalBatchL."Journal Template Name");
                    ItemJournalBatch1L.SETRANGE(Name, ItemJournalBatchL.Name);
                    ItemJournalBatch1L.SETRANGE("Use in Workflow FND", TRUE);
                    IF ItemJournalBatch1L.FINDFIRST() THEN BEGIN
                        ItemJournalLineL.RESET();
                        ItemJournalLineL.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Sent for Approval FND");
                        ItemJournalLineL.SETRANGE("Journal Template Name", ItemJournalBatch1L."Journal Template Name");
                        ItemJournalLineL.SETRANGE("Journal Batch Name", ItemJournalBatch1L.Name);
                        ItemJournalLineL.SETRANGE("Sent for Approval FND", TRUE);
                        IF ItemJournalLineL.FINDSET() THEN
                            ItemJournalLineL.MODIFYALL("Sent for Approval FND", FALSE, TRUE);
                    END;
                END;
            UNTIL ApprovalEntry.NEXT() = 0;
        END;
        //HEI.05<<
    END;
    //BC Upgrade GUNREM01<<

    //BC Upgrade GUNREM01>>
    LOCAL PROCEDURE GetStringAfterSpecialCharacter(VarString: Text; VarSpecialCharacter: Text): Text;
    BEGIN
        EXIT(DELSTR(VarString, 1, STRPOS(VarString, VarSpecialCharacter)));//HEI.06
    END;

    LOCAL PROCEDURE GetStringBeforeSpecialCharacter(VarString: Text; VarSpecialCharacter: Text): Text;
    BEGIN
        EXIT(DELSTR(VarString, STRPOS(VarString, VarSpecialCharacter)));//HEI.06
    END;
    //BC Upgrade GUNREM01>>

    var
        myInt: Integer;
}