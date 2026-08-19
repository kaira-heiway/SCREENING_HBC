namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Sales.Document;
using Microsoft.Warehouse.Document;
using Microsoft.Sales.History;
using Microsoft.Sales.Posting;
using Microsoft.Warehouse.Request;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Inventory.Tracking;
using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Inventory.Ledger;

codeunit 58020 "Auto Posting API Interfaces"
{
    //     HEI.01 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # New Codeunit created for Post the Sales Orders and Payments
    // HEI.02 INC3768532 - CHG2130534 IBM NASTAA02  13.10.2021 # Payments unable to be reversed
    //   # Code added on 'PostResourceCostValues' function to update all needed Fields in G/L Entry Table
    // HEI.03 INC3795821 - CHG2132451 IBM NASTAA02 28.10.2021 # Entries in API are unable to be reprocessed with Status=Error and Pending
    //   # Code added to function 'CreateAndPostWhseReceipt'
    // HEI.04 CHG2325324 HB4346 IBM COSTES04 16.10.2025 Missing Source Code
    //   # Add source code in VAlue Entry & General journale line

    // BC Upgrade SHUKLP03 >>
    // Blocked because of DrinkIT procedure Fct_Batchprocessing()
    // Procedure CreateAndPostWhseShipment() some part of code blocked because of DrinkIT field SalesHeader."Shipment status".
    // Procedure CreateAndPostWhseShipment() some part of code blocked because of DrinkIT procedure FEFOTrackingShipment()
    // procedure CreateReservEntryForDummyLotAssign() some part of code Blocked because of DrinkIT field ReservationEntry."Bin Code"
    // BC Upgrade SHUKLP03 <<

    TableNo = "API Interface Log2 INT";
    Permissions = TableData "G/L Entry" = rim, TableData "Value Entry" = rim;

    var
        APIInterfaceLog: Record "API Interface Log2 INT";
        FEFOTrac: Codeunit GenFunctions108FDW;  // BC Upgrade SHUKLP03 <<
        LastPostingErrorMsg: Text;
        LastErrorOutStream: OutStream;
        ErrorMsg: TextConst ENU = 'Error Code: %1, Error Text: %2, Call Stack Trace: %3';

    trigger OnRun()
    begin
        APIInterfaceLog := Rec;

        CASE APIInterfaceLog.Entity OF
            'SALES':
                CASE APIInterfaceLog."Source Type" OF
                    36:
                        CASE APIInterfaceLog."Source Subtype" OF
                            1:
                                CreateAndPostWhseShipment();
                            5:
                                CreateAndPostWhseReceipt();
                        END;
                END;
            'PAYMENT':
                PostCashRcptJournal();
        END;

        Rec := APIInterfaceLog;
    end;

    LOCAL procedure CreateAndPostWhseShipment()
    var
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        SalesHeader: Record "Sales Header";
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        WhsePostShipment: Codeunit "Whse.-Post Shipment";
        TempSalesLine: Record "Sales Line" temporary;
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        HasResourceLine: Boolean;
        WarehouseShipmentLineRec: Record "Warehouse Shipment Line"; // BC Upgrade SHUKLP03 << 
    begin
        SalesHeader.GET(SalesHeader."Document Type"::Order, APIInterfaceLog."Source No.");

        // BC Upgrade SHUKLP03 >> DrinkIT field SalesHeader."Shipment status".
        IF SalesHeader."Logistic Status 107FDW" = 'Open' THEN BEGIN
            SalesHeader."Logistic Status 107FDW" := 'Invoice';
            SalesHeader.MODIFY;
        END;
        // BC Upgrade SHUKLP03 << DrinkIT field SalesHeader."Shipment status".


        //Check if Resource exist on the lines
        SalesLine2.RESET();
        SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine2.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine2.SETFILTER(Type, '%1|%2', SalesLine2.Type::Resource, SalesLine2.Type::"G/L Account");
        HasResourceLine := SalesLine2.FINDFIRST();

        //Create Whse Shipment
        // GetSourceDocOutbound.Fct_Batchprocessing(TRUE);  // BC Upgrade SHUKLP03 << Blocked because of DrinkIT procedure Fct_Batchprocessing()
        GetSourceDocOutbound.CreateFromSalesOrder(SalesHeader);

        //AutoFEFO
        WarehouseShipmentLine.RESET();
        WarehouseShipmentLine.SETRANGE("Source Type", 37);
        WarehouseShipmentLine.SETRANGE("Source Subtype", WarehouseShipmentLine."Source Subtype"::"1");
        WarehouseShipmentLine.SETRANGE("Source No.", SalesHeader."No.");
        IF WarehouseShipmentLine.FINDFIRST() THEN BEGIN
            WarehouseShipmentHeader.GET(WarehouseShipmentLine."No.");
            // BC Upgrade SHUKLP03 >> Added code for FEFO. DrinkIT procedure FEFOTrackingShipment()
            FEFOTrac.AssignFEFOTracking(WarehouseShipmentLine);
            WarehouseShipmentLineRec.SETRANGE("Source Type", 37);
            WarehouseShipmentLineRec.SETRANGE("Source Subtype", WarehouseShipmentLine."Source Subtype"::"1");
            WarehouseShipmentLineRec.SETRANGE("No.", WarehouseShipmentHeader."No.");
            WarehouseShipmentLineRec.SETRANGE("Source No.", SalesHeader."No.");
            IF WarehouseShipmentLineRec.FINDSET() THEN
                REPEAT
                    // WarehouseShipmentHeader.FEFOTrackingShipment;  // BC Upgrade SHUKLP03 >> Blocked because of DrinkIT procedure FEFOTrackingShipment()
                    FEFOTrac.AssignFEFOTracking(WarehouseShipmentLineRec);

                UNTIL WarehouseShipmentLineRec.NEXT() = 0;
            // BC Upgrade SHUKLP03 << Added code for FEFO. DrinkIT procedure FEFOTrackingShipment()

            //Post Shipment
            SalesHeader.CALCFIELDS("Amount Including VAT");
            IF (SalesHeader."Doc. Amount Incl. VAT FND" = SalesHeader."Amount Including VAT") AND NOT HasResourceLine THEN
                WhsePostShipment.SetPostingSettings(TRUE)
            ELSE BEGIN
                WhsePostShipment.SetPostingSettings(FALSE);

                //Save Sales Lines before posting the Shipment
                TempSalesLine.RESET();
                SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                IF SalesLine.findset() THEN
                    REPEAT
                        TempSalesLine.INIT();
                        TempSalesLine.TRANSFERFIELDS(SalesLine);
                        TempSalesLine.INSERT();
                    UNTIL SalesLine.NEXT() = 0;
            END;

            WhsePostShipment.SetPrint(FALSE);
            WhsePostShipment.RUN(WarehouseShipmentLineRec);  // SHUKLP03 << Changed from WarehouseShipmentLine to WarehouseShipmentLineRec because of DrinkIT procedure FEFOTrackingShipment()
            CLEAR(WhsePostShipment);
        END;

        //Post Invoice
        IF SalesHeader.FIND() THEN BEGIN
            SalesHeader.Invoice := TRUE;
            IF NOT SalesHeader.Ship THEN
                SalesHeader.Ship := TRUE;
            SalesHeader.MODIFY();

            SalesLine.RESET();
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            IF SalesLine.findset() THEN
                REPEAT
                    TempSalesLine.SETRANGE("Line No.", SalesLine."Line No.");
                    IF TempSalesLine.FINDFIRST() THEN BEGIN
                        SalesLine.Quantity := TempSalesLine.Quantity;
                        SalesLine."Unit Price" := TempSalesLine."Unit Price";
                        SalesLine.Amount := TempSalesLine.Amount;
                        SalesLine."Amount Including VAT" := TempSalesLine."Amount Including VAT";
                        SalesLine."VAT Base Amount" := TempSalesLine."VAT Base Amount";
                        SalesLine."Line Amount" := TempSalesLine."Line Amount";
                        SalesLine."Outstanding Amount" := TempSalesLine."Outstanding Amount";
                        SalesLine."Outstanding Amount (LCY)" := TempSalesLine."Outstanding Amount (LCY)";
                        SalesLine.MODIFY();
                    END;
                UNTIL SalesLine.NEXT() = 0;

            CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
        END;

        //Error Log
        SalesInvoiceHeader.SETRANGE("Order No.", APIInterfaceLog."Source No.");
        IF SalesInvoiceHeader.FINDFIRST() AND NOT WarehouseShipmentHeader.FIND() THEN
            EXIT
        ELSE BEGIN
            APIInterfaceLog.FIND();
            LastPostingErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
            IF LastPostingErrorMsg <> '' THEN BEGIN
                APIInterfaceLog."Posting Status" := APIInterfaceLog."Posting Status"::Error;
                APIInterfaceLog."Posting Error Message".CREATEOUTSTREAM(LastErrorOutStream);
                LastErrorOutStream.WRITETEXT(LastPostingErrorMsg);
                APIInterfaceLog.MODIFY();

                //Delete Whse Shipment in case of posting error
                IF WarehouseShipmentHeader.FIND() THEN
                    WarehouseShipmentHeader.DELETE(TRUE);
            END;
        END;
    end;

    LOCAL procedure CreateAndPostWhseReceipt()
    var
        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        GetSourceDocInbound2: Codeunit InterfaceDtWCode; // BC Upgrade SHUKLP03 << As code added in Codeunit 51004 of Interface ext, so Changed from Codeunit "Get Source Doc. Inbound" to Codeunit 51004
        SalesHeader: Record "Sales Header";
        WhsePostReceipt: Codeunit "Whse.-Post Receipt";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        SalesHeader.GET(SalesHeader."Document Type"::"Return Order", APIInterfaceLog."Source No.");

        //Create Whse Receipt
        GetSourceDocInbound2.SkipPageOpening(TRUE);
        GetSourceDocInbound.CreateFromSalesReturnOrder(SalesHeader);

        //Assign Dummy Lot No's
        CreateReservEntryForDummyLotAssign(APIInterfaceLog."Source No.");

        //Post Receipt
        WarehouseReceiptLine.RESET();
        WarehouseReceiptLine.SETRANGE("Source Type", 37);
        WarehouseReceiptLine.SETRANGE("Source Subtype", WarehouseReceiptLine."Source Subtype"::"5");
        WarehouseReceiptLine.SETRANGE("Source No.", APIInterfaceLog."Source No.");
        IF WarehouseReceiptLine.FINDFIRST() THEN BEGIN
            WarehouseReceiptHeader.GET(WarehouseReceiptLine."No.");
            //HEI.03>>
            WarehouseReceiptHeader.VALIDATE("Posting Date", SalesHeader."Posting Date");
            WarehouseReceiptHeader.MODIFY();
            //HEI.03<<
            WhsePostReceipt.RUN(WarehouseReceiptLine);

            //Post Invoice
            SalesHeader.FIND();
            SalesHeader.Invoice := TRUE;
            SalesHeader.MODIFY();
            CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);

            //Log Error
            SalesCrMemoHeader.SETRANGE("Return Order No.", APIInterfaceLog."Source No.");
            IF SalesCrMemoHeader.FINDFIRST() AND NOT WarehouseReceiptLine.FIND() THEN
                EXIT
            ELSE BEGIN
                APIInterfaceLog.FIND();
                LastPostingErrorMsg := STRSUBSTNO(ErrorMsg, GETLASTERRORCODE, GETLASTERRORTEXT, GETLASTERRORCALLSTACK);
                IF LastPostingErrorMsg <> '' THEN BEGIN
                    APIInterfaceLog."Posting Status" := APIInterfaceLog."Posting Status"::Error;
                    APIInterfaceLog."Posting Error Message".CREATEOUTSTREAM(LastErrorOutStream);
                    LastErrorOutStream.WRITETEXT(LastPostingErrorMsg);
                    APIInterfaceLog.MODIFY();

                    //Delete Whse Receipt in case of posting error
                    IF WarehouseReceiptHeader.FIND() THEN
                        WarehouseReceiptHeader.DELETE(TRUE);
                END;
            END;
        END;
    end;

    procedure CreateReservEntryForDummyLotAssign(DocumentNo: Code[20])
    var
        ReservationEntry: Record "Reservation Entry";
        LastEntryNo: Integer;
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        LSRInterfaceSetup: Record "LSR Interface Setup INT";
    begin
        IF ReservationEntry.FINDLAST() THEN
            LastEntryNo := ReservationEntry."Entry No.";
        IF LSRInterfaceSetup.GET() THEN;

        WarehouseReceiptLine.SETRANGE("Source No.", DocumentNo);
        IF WarehouseReceiptLine.findset() THEN
            REPEAT
                ReservationEntry.INIT();
                ReservationEntry."Entry No." := LastEntryNo + 1;
                ReservationEntry.Positive := WarehouseReceiptLine.Quantity > 0;
                ReservationEntry."Source Type" := DATABASE::"Sales Line";
                ReservationEntry."Source Subtype" := ReservationEntry."Source Subtype"::"5";
                ReservationEntry."Source ID" := DocumentNo;
                ReservationEntry."Source Ref. No." := WarehouseReceiptLine."Source Line No.";
                ReservationEntry."Created By" := USERID;
                ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
                ReservationEntry.VALIDATE("Item No.", WarehouseReceiptLine."Item No.");
                ReservationEntry.VALIDATE("Location Code", WarehouseReceiptLine."Location Code");
                //ReservationEntry.VALIDATE("Bin Code", WarehouseReceiptLine."Bin Code");    // BC Upgrade SHUKLP03 << Blocked because of DrinkIT field ReservationEntry."Bin Code"
                ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                ReservationEntry.VALIDATE("Lot No.", LSRInterfaceSetup."Fixed Lot No.");
                ReservationEntry.VALIDATE(Quantity, WarehouseReceiptLine.Quantity);
                ReservationEntry.VALIDATE("Quantity (Base)", WarehouseReceiptLine."Qty. (Base)");
                ReservationEntry.VALIDATE("Qty. to Handle (Base)", ReservationEntry."Quantity (Base)");
                ReservationEntry.INSERT();
                LastEntryNo += 1;
            UNTIL WarehouseReceiptLine.NEXT() = 0;
    end;

    procedure PostResourceCostValues(SalesHeader: Record "Sales Header"; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        ValueEntry: Record "Value Entry";
        ValueEntry2: Record "Value Entry";
        Resource: Record Resource;
        GLEntry: Record "G/L Entry";
        GLEntry2: Record "G/L Entry";
        GeneralPostingSetup: Record "General Posting Setup";
        GLAccount: Record "G/L Account";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        //Create Value Entry
        IF SalesInvHdrNo <> '' THEN BEGIN
            SalesInvoiceHeader.GET(SalesInvHdrNo);
            SalesInvoiceLine.SETRANGE("Document No.", SalesInvHdrNo);
            SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Resource);
            IF SalesInvoiceLine.findset() THEN
                REPEAT
                    SourceCodeSetup.GET();//HEI.04
                    Resource.GET(SalesInvoiceLine."No.");
                    ValueEntry.INIT();
                    IF ValueEntry2.FINDLAST() THEN
                        ValueEntry."Entry No." := ValueEntry2."Entry No." + 1
                    ELSE
                        ValueEntry."Entry No." := 1;
                    ValueEntry.VALIDATE("Posting Date", SalesInvoiceHeader."Posting Date");
                    ValueEntry.VALIDATE("Item Ledger Entry Type", ValueEntry."Item Ledger Entry Type"::Sale);
                    ValueEntry.VALIDATE("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
                    ValueEntry.VALIDATE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
                    ValueEntry.VALIDATE("Document No.", SalesInvoiceHeader."No.");
                    ValueEntry.VALIDATE("Source Type", ValueEntry."Source Type"::Customer);
                    ValueEntry.VALIDATE("Source No.", SalesInvoiceHeader."Sell-to Customer No.");
                    ValueEntry.VALIDATE("Location Code", SalesInvoiceHeader."Location Code");
                    ValueEntry."External Document No." := SalesInvoiceHeader."External Document No.";
                    ValueEntry.Description := SalesInvoiceLine.Description;
                    ValueEntry."Gen. Bus. Posting Group" := SalesInvoiceHeader."Gen. Bus. Posting Group";
                    ValueEntry."Gen. Prod. Posting Group" := SalesInvoiceLine."Gen. Prod. Posting Group";
                    ValueEntry.VALIDATE("Valued Quantity", -SalesInvoiceLine.Quantity);
                    ValueEntry.VALIDATE("Invoiced Quantity", -SalesInvoiceLine.Quantity);
                    ValueEntry.VALIDATE("Cost Amount (Actual)", -(Resource."Unit Cost" * SalesInvoiceLine.Quantity));
                    ValueEntry.VALIDATE("Sales Amount (Actual)", -SalesInvoiceLine.Amount);
                    ValueEntry."Source Code" := SourceCodeSetup.Sales;//HEI.04
                    ValueEntry.INSERT();
                UNTIL SalesInvoiceLine.NEXT() = 0;
        END;
    end;

    // BC Upgrade SHUKLP03 >> Already blocked in NAV.
    //HEI.02>>
    //Create G/L Entries
    //GeneralPostingSetup.GET(SalesHeader."Gen. Bus. Posting Group",SalesLine."Gen. Prod. Posting Group");

    //Credit
    // GLAccount.GET(GeneralPostingSetup."Inventory Adjmt. Account");
    // GLEntry.INIT;
    // IF GLEntry2.FINDLAST THEN
    //  GLEntry."Entry No." := GLEntry2."Entry No." + 1
    // ELSE
    //  GLEntry."Entry No." := 1;

    // GLEntry.VALIDATE("Posting Date",SalesHeader."Posting Date");
    // GLEntry.VALIDATE("Document Type",GLEntry."Document Type"::Invoice);
    // GLEntry.VALIDATE("Document No.",SalesHeader."Posting No.");
    // GLEntry.VALIDATE("G/L Account No.",GeneralPostingSetup."Inventory Adjmt. Account");
    // GLEntry.Description := GLAccount.Name;
    // GLEntry.VALIDATE("Source Type",GLEntry."Source Type"::Customer);
    // GLEntry.VALIDATE("Source No.",SalesHeader."Sell-to Customer No.");
    // GLEntry.VALIDATE(Amount,-Resource."Unit Cost" * SalesLine.Quantity);
    // GLEntry."External Document No." := SalesHeader."External Document No.";
    // GLEntry.INSERT;
    //
    // //Debit
    // GLAccount.GET(GeneralPostingSetup."Sales Resource Cost Acc.");
    // GLEntry.RESET;
    // GLEntry.INIT;
    // IF GLEntry2.FINDLAST THEN
    //  GLEntry."Entry No." := GLEntry2."Entry No." + 1
    // ELSE
    //  GLEntry."Entry No." := 1;
    //
    // GLEntry.VALIDATE("Posting Date",SalesHeader."Posting Date");
    // GLEntry.VALIDATE("Document Type",GLEntry."Document Type"::Invoice);
    // GLEntry.VALIDATE("Document No.",SalesHeader."Posting No.");
    // GLEntry.VALIDATE("G/L Account No.",GeneralPostingSetup."Sales Resource Cost Acc.");
    // GLEntry.Description := GLAccount.Name;
    // GLEntry.VALIDATE("Source Type",GLEntry."Source Type"::Customer);
    // GLEntry.VALIDATE("Source No.",SalesHeader."Sell-to Customer No.");
    // GLEntry.VALIDATE(Amount,Resource."Unit Cost" * SalesLine.Quantity);
    // GLEntry."External Document No." := SalesHeader."External Document No.";
    // GLEntry.INSERT;
    //HEI.02<<
    // BC Upgrade SHUKLP03 << Already blocked in NAV.


    procedure PostResourceCostGLEntries(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line")
    var
        Resource: Record Resource;
        GeneralPostingSetup: Record "General Posting Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        //HEI.02>>
        //Create G/L Entries
        SourceCodeSetup.GET();//HEI.04
        Resource.GET(SalesLine."No.");
        GeneralPostingSetup.GET(SalesHeader."Gen. Bus. Posting Group", SalesLine."Gen. Prod. Posting Group");

        //Credit
        GenJnlLine.InitNewLine(
            SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", SalesHeader."Posting Description",     // BC Upgrade SHUKLP03 >> Added missing parameter SalesHeader."VAT Reporting Date".
            SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code",
            SalesLine."Dimension Set ID", SalesHeader."Reason Code");

        GenJnlLine.CopyFromSalesHeader(SalesHeader);
        GenJnlLine.CopyFromSalesHeaderPayment(SalesHeader);

        GenJnlLine."System-Created Entry" := TRUE;
        GenJnlLine."Pmt. Discount Date" := 0D;
        GenJnlLine.VALIDATE("Source Type", GenJnlLine."Source Type"::Customer);
        GenJnlLine.VALIDATE("Source No.", SalesHeader."Sell-to Customer No.");
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Invoice)
        ELSE IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" THEN
            GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::"Credit Memo");
        GenJnlLine.VALIDATE("Document No.", SalesHeader."Posting No.");
        GenJnlLine.VALIDATE("External Document No.", SalesHeader."External Document No.");
        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
        GenJnlLine.VALIDATE("Account No.", GeneralPostingSetup."Inventory Adjmt. Account");
        GenJnlLine.VALIDATE(Amount, -Resource."Unit Cost" * SalesLine.Quantity);
        GenJnlLine.VALIDATE("Gen. Posting Type", GenJnlLine."Gen. Posting Type"::Sale);
        GenJnlLine.VALIDATE("Dimension Set ID", SalesLine."Dimension Set ID");
        GenJnlLine.VALIDATE("VAT Bus. Posting Group", SalesLine."VAT Bus. Posting Group");
        GenJnlLine.VALIDATE("VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group");
        GenJnlLine."Source Code" := SourceCodeSetup.Sales;//HEI.04
        GenJnlPostLine.RunWithCheck(GenJnlLine);

        //Debit
        GenJnlLine.InitNewLine(
            SalesHeader."Posting Date", SalesHeader."Document Date", SalesHeader."VAT Reporting Date", SalesHeader."Posting Description",  // BC Upgrade SHUKLP03 >> Added missing parameter SalesHeader."VAT Reporting Date".
            SalesHeader."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 2 Code",
            SalesLine."Dimension Set ID", SalesHeader."Reason Code");

        GenJnlLine.CopyFromSalesHeader(SalesHeader);
        GenJnlLine.CopyFromSalesHeaderPayment(SalesHeader);

        GenJnlLine."System-Created Entry" := TRUE;
        GenJnlLine."Pmt. Discount Date" := 0D;
        GenJnlLine.VALIDATE("Source Type", GenJnlLine."Source Type"::Customer);
        GenJnlLine.VALIDATE("Source No.", SalesHeader."Sell-to Customer No.");
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
            GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::Invoice)
        ELSE IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" THEN
            GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::"Credit Memo");
        GenJnlLine.VALIDATE("Document No.", SalesHeader."Posting No.");
        GenJnlLine.VALIDATE("External Document No.", SalesHeader."External Document No.");
        GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
        GenJnlLine.VALIDATE("Account No.", GeneralPostingSetup."Sales Resource Cost Acc. FND");
        GenJnlLine.VALIDATE(Amount, Resource."Unit Cost" * SalesLine.Quantity);
        GenJnlLine.VALIDATE("Gen. Posting Type", GenJnlLine."Gen. Posting Type"::Sale);
        GenJnlLine.VALIDATE("Dimension Set ID", SalesLine."Dimension Set ID");
        GenJnlLine.VALIDATE("VAT Bus. Posting Group", SalesLine."VAT Bus. Posting Group");
        GenJnlLine.VALIDATE("VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group");
        GenJnlLine."Source Code" := SourceCodeSetup.Sales;//HEI.04
        GenJnlPostLine.RunWithCheck(GenJnlLine);
        //HEI.02<<
    end;

    LOCAL procedure PostCashRcptJournal()
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.SETRANGE("Journal Template Name", APIInterfaceLog."Payment Jnl Template");
        GenJournalLine.SETRANGE("Journal Batch Name", APIInterfaceLog."Payment Jnl Batch");
        GenJournalLine.SETRANGE("Document No.", APIInterfaceLog."Source No.");
        IF GenJournalLine.FINDFIRST() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);

    end;


}