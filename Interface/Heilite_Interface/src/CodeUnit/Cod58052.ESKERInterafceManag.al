codeunit 58052 "ESKER Interface Manag"
{
    //BC Upgrade GUNREM01 Old ID- 50058
    // version ESKER,HEI.27

    // HEI.01 Esker Interfaces  Solution IBM POSTOI01 - new Codeunit for Esker Interface
    // HEI.02 INC1000794 IBM POSTOI01 12.12.2018
    // HEI.04 CHG2022396 Esker Ethiopia 09.07.2019
    //   # modify CreatePurchInvoice for WHT requirement
    //   # new function ProcessWHTRequest
    //   # new function FctInsertInvLineWHTProdPostGroup
    //   # modify FctExtraireLine
    //   HEI.03 HORTOC01 08.05.2019 #change the source no for invoiceno field from Order No to Message ID - code35
    // HEI.05 CHG2022396 Esker Ethiopia 16.07.2019
    //   # modify HandleQty-adjust Qty to Hdl for Po invoices that are not in Base Unit of Measure
    //   # modify CreatePurchInvoice- allow multiple PO's on invoice, disable the variance message
    //   # modify FctExtraireLine
    //   # modify ProcessPOHeader to replaces Buyer email with Created by email
    //   # modify FctGetVATRate
    // HEI.06 CHG2022396 Esker Ethiopia 17.07.2019
    //   # modify CreatePurchInvoice for LC requirement
    //   # new function ProcessLCRequest
    // HEI.07 CHG2022396 Esker Ethiopia 17.07.2019
    //   # modify CreatePurchInvoice for new OPCo LC Code
    //   # new function for new OpCo LC code ProcessLCRequest
    // HEI.08 Bugfix Mozambique Post Invoice Error 14.08.2019
    //   # "Buy-from Vendor No." should not be validated before the insert of the Purchase Header
    // HEI.11 CHG2036385 IBM POSTOI01 23/10/2019
    //   # invoice discount amount not updated on purchase invoice header total amounts fields
    //   # move some code lines in the CreatePurchInvoice procedure
    // HEI.13 FDD HB1348 CHG2061857 IBM SHANKJ03 25.06.2020
    //   # Code added in ProcessVendorRequest
    //   # New Function Added ProcessVendorPstGrpRequest
    // HEI.14  CHG2071987  BULIMC01 IBM 22/07/2020
    //   # optimize the PoLine interface data queries
    //   #code uncommented for HEI.10 changes - VAT Bus. Posting Group has to be the one from the XML file
    //   #code added to CreatePurchInvoice function
    // HEI.15 CHG2080629 BULIMC01 IBM 24/09/2020 #new field added to Posting Interface "WHT Absorb Base"
    // HEI.16 CHG2081007 BULIMC01 IBM 28/09/2020 #new field added to ProcessPOHeaderRequest function: "Project Code"
    // HEI.17 CHG2085005 BULIMC01 IBM 28.10.2020 #new code added to "CreatePurchINvoice" function to fill in the License Code
    // HEI.18 HT1641 IBM BULIMC01 25/02/2021 #new code added to "CreatePurchINvoice" to fill in the Additional Description
    // HEI.19 CHG2140113 HB2701 IBM NANDIS01 02.02.202 Enhancement Of Bank Account _Esker
    //   # Bank Account to be used/validated from Esker - Change in function CreatePurchInvoice
    //   # Modified the data exchange - ESKER-INVPOSTING; by adding 'SelectBankKey' in Header level
    // HEI.20 CHG2206877 HB3485 IBM MAJUMS03 03.07.2023 Heilite ESKER FX Rate Interface
    //   # Validating Document Date is done to update the Currency Factor as per Document Date. Currency Update code exits in "On Validate" Trigger of "Document Date".
    // HEI.21 CHG2221624 HB3614 IBM SRIVAS07 05.04.2024 # Block Payment for Invoices with Price Difference higher than the tolerance
    //   # Code added to the CreatePurchInvoice()
    // HEI.22 CHG2251774 HB3933 IBM VERMAA03 03.07.2024 allow manual lines to be added on PO Purchase Invoices excluding POs with type Fixed Asset
    //   # Code added to CreatePurchInvoice() to allow manual line for Invoice Type PO Invoice.
    //   # Created new function IsFALineFound() and GetLastPurchLineNo();
    // HEI.23 CHG2251774 HB3933 IBM VERMAA03 06.07.2024 #new code added to clear Dimension Set Entry temperory data.
    // HEI.24 CHG2251774 HB3933 IBM SRIVAS07 26.07.2024 #new code added to clear Dimension Set Entry temperory data.
    //   # Added Code to fatch the correct VAT Posting group, so it will calculate the correct VAT%, as per interface Entry.
    // HEI.25 CHG2251774 HB3933 IBM SRIVAS07 08.08.2024 #Enhance interface between Heilite & ESKER to allow manual lines to be added on PO Purchase Invoices excluding POs with type Fixed Asset
    //   # Code added in CreatePurchInvoice()
    // HEI.26 CHG2251774 SHARMP16 04.09.2024 #Enhance interface between Heilite & ESKER to allow manual lines to be added on PO Purchase Invoices excluding POs with type Fixed Asset
    //   # Code added in CreatePurchInvoice()
    // HEI.27 CHG2291468 SAHAL01 27.03.2025 Heilite Esker Interface – payment status fix
    //   # Added Code
    //BC UPGRADE ATHUKS01 >> 
    //1.Commented Doc. Amount Incl. VAT and Doc. Amount VAT fields update in CreatePurchInvoice procedure and added new fields "Doc. Amount Incl. VAT IBM" and "Doc. Amount VAT IBM" for the same.
    //2.Tables are mapping to Aptean table in ProcessWHTRequest,FctInsertInvLineWHTProdPostGroup 
    //BC UPGRADE ATHUKS01 <<
    Permissions = TableData "Item Ledger Entry" = rimd;

    trigger OnRun();
    var
        ILE: Record "Item Ledger Entry";
        Item: Record Item;
    begin
    end;

    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        GeneralInterfaceSetupRead: Boolean;
        EskerInterfaceSetupRead: Boolean;
        OpCoSetup: Record "OPCO Setup FND";
        OpCoSetupRead: Boolean;
        VendLedgerEntry: Record "Vendor Ledger Entry";
        InvAmtRefNo: Decimal;
        AppliedVendLedgerEntry: Record "Vendor Ledger Entry";
        ImportLineYesNo: Boolean;
        IsPurchHeadInserted: Boolean;
        VATProdPostGrp: Code[10];
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        ErrorMsg: Text;
        TxtG50000: TextConst ENU = 'FORMAT FILE  ERROR: %1', FRA = 'ERREUR FORMAT FICHIER: %1';
        TxtG50001: TextConst ENU = 'IMPORT ERROR: %1', FRA = 'ERREUR IMPORT: %1';
        TxtG50002: TextConst ENU = 'POSTING ERROR: %1', FRA = 'ERREUR VALIDATION: %1';
        TxtG50003: TextConst ENU = 'FILES TRANSFER ERROR: %1', FRA = 'ERREUR TRANSFERT DE FICHIERS: %1';
        TxtG50004: TextConst ENU = 'DATA ERROR: %1', FRA = 'ERREUR DE DONNEES: %1';
        TxtLApprovalStatus: Text;
        ApprovalStatus: Option "Not requested",Pending,Approved;
        RecLPurchInvHeader: Record "Purch. Inv. Header";
        RecLPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        DocumentNo: Code[20];
        PaymentBlock: Codeunit "Payment Block CBN";
        InvoiceType: Option "Non-PO Invoice","PO Invoice";
        PurchSetup: Record "Purchases & Payables Setup";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        TxtG50005: Label '" "';
        TxtG50006: Label 'Vendor Invoice No. %1 already exist!';
        Txt50004: TextConst ENU = 'The currency code of the invoice is different from the currency code on the initial order No. "%1"', FRA = 'La devise de la facture est diffÙrente de la devise sur la commande initiale nÙ "%1"';
        Txt50003: TextConst ENU = 'This line does not exist in the original order (order number: %1, line number: %2, quantity: %3, amount: %4).', FRA = 'Cette ligne n''existe pas dans la commande initiale (numÙro de commande : %1, numÙro de ligne : %2, quantitÙ : %3, montant : %4).';
        CUPostInvoice: Codeunit "ESKER Interface Web Service";
        ReleasePurchDoc: Codeunit "Release Purchase Document";
        NewGPurchHeader: Record "Purchase Header";
        HeiCore: Codeunit "Heineken Global";
        LInvAmt: Decimal;
        TxtL50001: TextConst ENU = 'Document Picture', FRA = 'Image du document';
        TxtL50002: TextConst ENU = 'There is a variance between the calculated amount (%1) and the amount specified in the ERP (%2).', FRA = 'Il existe un Ùcart entre le montant calculÙ (%1) et le montant renseignÙ dans l''ERP (%2).';
        DocURL: Text[500];
        ImageURL: Text[500];
        TxtL50003: Label 'There is a variance between the calculated amount (%1) and the amount specified in the ERP (%2).';
        TextG50007: Label 'The WHT combination %1, %2 does not exist in the table WHT Posting Setup';
        ToleranceExceed: Boolean;
        TxtG50008: Label 'Tolerance exceeded and approval is pending in Heilite.';
        IsRNFound: Boolean;
        IsManualLine: Boolean;

    procedure ProcessCostCenterRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CostCenter: Record "Cost Center";
        CompanyInformation: Record "Company Information";
    begin
        //Cost Centers Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;
        GeneralInterfaceSetup.TESTFIELD("Cost Center Dimension Code");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker CostCenters Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker CostCenters Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Cost Center Code" <> '*' then begin
                    DimensionValue.RESET;
                    DimensionValue.SETCURRENTKEY("Dimension Code", Code);
                    DimensionValue.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                    DimensionValue.SETRANGE(Code, InterfaceEntryLine."Cost Center Code");
                    //CostCenter.RESET;
                    //CostCenter.SETRANGE(Code,InterfaceEntryLine."Cost Center Code");
                    if DimensionValue.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut."Cost Center Code" := DimensionValue.Code;
                        InterfaceEntryLineOut.Description := DimensionValue.Name;
                        InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                        InterfaceEntryLineOut.INSERT;
                    end
                end;
                if InterfaceEntryLine."Cost Center Code" = '*' then begin //new
                                                                          //CostCenter.RESET;
                    DimensionValue.RESET;
                    DimensionValue.SETCURRENTKEY("Dimension Code", Code);
                    DimensionValue.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                    if DimensionValue.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Cost Center Code" := DimensionValue.Code;
                            InterfaceEntryLineOut.Description := DimensionValue.Name;
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                            InterfaceEntryLineOut.INSERT;
                        until DimensionValue.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure LoadRequest(var InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
    begin
        //Transfer Orders Creation
        //>>HEI.02 begin comment
        /*
        TransferHeader.INIT;
        TransferHeader.VALIDATE("No.",InterfaceEntryHeader."Source No.");
        TransferHeader.VALIDATE("Transfer-from Code",InterfaceEntryHeader."Transfer-from Code");
        TransferHeader.VALIDATE("In-Transit Code",InterfaceEntryHeader."In-Tranzit Code");
        TransferHeader.VALIDATE("Transfer-to Code",InterfaceEntryHeader."Transfer-to Code");
        TransferHeader.VALIDATE("Posting Date",InterfaceEntryHeader."Posting Date");
        TransferHeader.VALIDATE(Status,InterfaceEntryHeader."Source Status");
        TransferHeader.VALIDATE("Truck Code",InterfaceEntryHeader."Truck Code");
        TransferHeader.VALIDATE("Driver Code",InterfaceEntryHeader."Driver Code");
        TransferHeader.INSERT(TRUE);
        
        InterfaceEntryLine.RESET;
        InterfaceEntryLine.SETRANGE("Header Entry No.",InterfaceEntryHeader."Entry No.");
        IF InterfaceEntryLine.FINDSET THEN
          REPEAT
            TransferLine.INIT;
            TransferLine.VALIDATE("Document No.",InterfaceEntryLine."Source No.");
            TransferLine.VALIDATE("Line No.",InterfaceEntryLine."Source Line No.");
            TransferLine.VALIDATE("Item No.",InterfaceEntryLine."Item No.");
            TransferLine.VALIDATE(Quantity,InterfaceEntryLine.Quantity);
            TransferLine.VALIDATE("Unit of Measure Code",InterfaceEntryLine."Unit of Measure Code");
            TransferLine.VALIDATE("Truck Code",InterfaceEntryLine."Truck Code");
            TransferLine.VALIDATE("Driver Code",InterfaceEntryLine."Driver Code");
          UNTIL InterfaceEntryLine.NEXT = 0;
        */
        //<<HEI.02 end comment

    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET;
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetEskerInterfaceSetup();
    begin
        if not EskerInterfaceSetupRead then
            EskerInterfaceSetup.GET;
        EskerInterfaceSetupRead := true;
    end;

    procedure ProcessCompanyRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CostCenter: Record "Cost Center";
        CompanyInformation: Record "Company Information";
        Company: Record Company;
        GenLedgerSetup: Record "General Ledger Setup";
    begin
        //Company Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;

        InterfaceSetup.GET(EskerInterfaceSetup."Esker Company Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker Company Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine.Description <> '*' then begin
                    Company.RESET;
                    Company.SETCURRENTKEY(Name);
                    Company.SETRANGE(Name, InterfaceEntryLine.Description);
                    if Company.FINDFIRST then begin
                        CompanyInformation.CHANGECOMPANY(Company.Name);
                        CompanyInformation.GET;
                        GenLedgerSetup.CHANGECOMPANY(Company.Name);
                        GenLedgerSetup.GET;
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut.Description := Company.Name;
                        InterfaceEntryLineOut."Description 2" := Company.Name;
                        InterfaceEntryLineOut."Currency Code" := GenLedgerSetup."LCY Code";
                        InterfaceEntryLineOut.INSERT;
                    end
                end;
                if InterfaceEntryLine.Description = '*' then begin //new

                    Company.RESET;
                    if Company.FINDSET then
                        repeat
                            CompanyInformation.CHANGECOMPANY(Company.Name);
                            CompanyInformation.GET;
                            GenLedgerSetup.CHANGECOMPANY(Company.Name);
                            GenLedgerSetup.GET;
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut.Description := Company.Name;
                            InterfaceEntryLineOut."Description 2" := Company.Name;
                            InterfaceEntryLineOut."Currency Code" := GenLedgerSetup."LCY Code";
                            InterfaceEntryLineOut.INSERT;
                        until Company.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessGLAccountRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        GLAccount: Record "G/L Account";
        CompanyInformation: Record "Company Information";
        DefaultDimension: Record "Default Dimension";
    begin
        //GL Accounts Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        //GetOpCoSetup;
        OpCoSetup.GET;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;
        GeneralInterfaceSetup.TESTFIELD("Cost Center Dimension Code");
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        OpCoSetup.TESTFIELD("Business Type Dimension Code");
        OpCoSetup.TESTFIELD("Movement Type Dimension Code");

        InterfaceSetup.GET(EskerInterfaceSetup."Esker GLAccount Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker GLAccount Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Account No." <> '*' then begin
                    GLAccount.RESET;
                    GLAccount.SETCURRENTKEY("Direct Posting", "Account Type", Blocked);
                    GLAccount.SETRANGE("No.", InterfaceEntryLine."Account No.");
                    GLAccount.SETRANGE("Direct Posting", true);
                    GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
                    GLAccount.SETRANGE(Blocked, false);
                    if GLAccount.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut."Account No." := GLAccount."No.";
                        InterfaceEntryLineOut.Description := GLAccount.Name;
                        InterfaceEntryLineOut."Description 2" := COMPANYNAME;

                        //BRAND dimension
                        DefaultDimension.RESET;
                        DefaultDimension.SETRANGE("No.", GLAccount."No.");
                        DefaultDimension.SETRANGE("Table ID", 15);
                        DefaultDimension.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                        if DefaultDimension.FINDFIRST then begin
                            InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DefaultDimension."Dimension Value Code";
                            InterfaceEntryLineOut."Global No." := FORMAT(DefaultDimension."Value Posting");
                        end;

                        //Cost center dimension
                        DefaultDimension.RESET;
                        DefaultDimension.SETRANGE("No.", GLAccount."No.");
                        DefaultDimension.SETRANGE("Table ID", 15);
                        DefaultDimension.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                        if DefaultDimension.FINDFIRST then begin
                            InterfaceEntryLineOut."Cost Center Code" := DefaultDimension."Dimension Value Code";
                            InterfaceEntryLineOut."CMG Code" := FORMAT(DefaultDimension."Value Posting");
                        end;

                        //Business Type dimension
                        DefaultDimension.RESET;
                        DefaultDimension.SETRANGE("No.", GLAccount."No.");
                        DefaultDimension.SETRANGE("Table ID", 15);
                        DefaultDimension.SETRANGE("Dimension Code", OpCoSetup."Business Type Dimension Code");
                        if DefaultDimension.FINDFIRST then begin
                            InterfaceEntryLineOut."Project Code" := DefaultDimension."Dimension Value Code";
                            InterfaceEntryLineOut."Order No." := FORMAT(DefaultDimension."Value Posting");
                        end;

                        //Movement Type dimension
                        DefaultDimension.RESET;
                        DefaultDimension.SETRANGE("No.", GLAccount."No.");
                        DefaultDimension.SETRANGE("Table ID", 15);
                        DefaultDimension.SETRANGE("Dimension Code", OpCoSetup."Movement Type Dimension Code");
                        if DefaultDimension.FINDFIRST then begin
                            InterfaceEntryLineOut."Shortcut Dimension 2 Code" := DefaultDimension."Dimension Value Code";
                            InterfaceEntryLineOut."Source No." := FORMAT(DefaultDimension."Value Posting");
                        end;

                        InterfaceEntryLineOut.INSERT;
                    end
                end;
                if InterfaceEntryLine."Account No." = '*' then begin //new
                    GLAccount.RESET;
                    GLAccount.SETCURRENTKEY("Direct Posting", "Account Type", Blocked);
                    GLAccount.SETRANGE("Direct Posting", true);
                    GLAccount.SETRANGE("Account Type", GLAccount."Account Type"::Posting);
                    GLAccount.SETRANGE(Blocked, false);
                    if GLAccount.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Account No." := GLAccount."No.";
                            InterfaceEntryLineOut.Description := GLAccount.Name;
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;

                            //BRAND dimension
                            DefaultDimension.RESET;
                            DefaultDimension.SETRANGE("No.", GLAccount."No.");
                            DefaultDimension.SETRANGE("Table ID", 15);
                            DefaultDimension.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                            if DefaultDimension.FINDFIRST then begin
                                InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DefaultDimension."Dimension Value Code";
                                InterfaceEntryLineOut."Global No." := FORMAT(DefaultDimension."Value Posting");
                            end;
                            //Cost center dimension
                            DefaultDimension.RESET;
                            DefaultDimension.SETRANGE("No.", GLAccount."No.");
                            DefaultDimension.SETRANGE("Table ID", 15);
                            DefaultDimension.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                            if DefaultDimension.FINDFIRST then begin
                                InterfaceEntryLineOut."Cost Center Code" := DefaultDimension."Dimension Value Code";
                                InterfaceEntryLineOut."CMG Code" := FORMAT(DefaultDimension."Value Posting");
                            end;
                            //Business Type dimension
                            DefaultDimension.RESET;
                            DefaultDimension.SETRANGE("No.", GLAccount."No.");
                            DefaultDimension.SETRANGE("Table ID", 15);
                            DefaultDimension.SETRANGE("Dimension Code", OpCoSetup."Business Type Dimension Code");
                            if DefaultDimension.FINDFIRST then begin
                                InterfaceEntryLineOut."Project Code" := DefaultDimension."Dimension Value Code";
                                InterfaceEntryLineOut."Order No." := FORMAT(DefaultDimension."Value Posting");
                            end;
                            //Movement Type dimension
                            DefaultDimension.RESET;
                            DefaultDimension.SETRANGE("No.", GLAccount."No.");
                            DefaultDimension.SETRANGE("Table ID", 15);
                            DefaultDimension.SETRANGE("Dimension Code", OpCoSetup."Movement Type Dimension Code");
                            if DefaultDimension.FINDFIRST then begin
                                InterfaceEntryLineOut."Shortcut Dimension 2 Code" := DefaultDimension."Dimension Value Code";
                                InterfaceEntryLineOut."Source No." := FORMAT(DefaultDimension."Value Posting");
                            end;

                            InterfaceEntryLineOut.INSERT;
                        until GLAccount.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    local procedure GetOpCoSetup();
    begin
        if not OpCoSetupRead then
            OpCoSetup.GET;
        OpCoSetupRead := true;
    end;

    procedure ProcessBrandRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CostCenter: Record "Cost Center";
        CompanyInformation: Record "Company Information";
    begin
        //Brand Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        InterfaceSetup.GET(EskerInterfaceSetup."Esker Brand Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker Brand Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Shortcut Dimension 1 Code" <> '*' then begin
                    DimensionValue.RESET;
                    DimensionValue.SETCURRENTKEY("Dimension Value Type", Blocked);
                    DimensionValue.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                    DimensionValue.SETRANGE(Code, InterfaceEntryLine."Shortcut Dimension 1 Code");
                    DimensionValue.SETRANGE("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
                    DimensionValue.SETRANGE(Blocked, false);
                    if DimensionValue.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionValue.Code;
                        InterfaceEntryLineOut.Description := DimensionValue.Name;
                        InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                        InterfaceEntryLineOut.INSERT;
                    end
                end;
                if InterfaceEntryLine."Shortcut Dimension 1 Code" = '*' then begin //new

                    DimensionValue.RESET;
                    DimensionValue.SETCURRENTKEY("Dimension Value Type", Blocked);
                    DimensionValue.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                    DimensionValue.SETRANGE("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
                    DimensionValue.SETRANGE(Blocked, false);
                    if DimensionValue.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionValue.Code;
                            InterfaceEntryLineOut.Description := DimensionValue.Name;
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                            InterfaceEntryLineOut.INSERT;
                        until DimensionValue.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessVendorRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        DefaultDimension: Record "Default Dimension";
        Vendor: Record Vendor;
    begin
        //Vendor Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;


        InterfaceSetup.GET(EskerInterfaceSetup."Esker Vendor Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker Vendor Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Buy-from Vendor No." <> '*' then begin
                    Vendor.RESET;
                    Vendor.SETCURRENTKEY(Blocked);
                    Vendor.SETRANGE("No.", InterfaceEntryLine."Buy-from Vendor No.");
                    Vendor.SETFILTER(Blocked, '<>%1', Vendor.Blocked::All);
                    if Vendor.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut."Buy-from Vendor No." := Vendor."No.";
                        InterfaceEntryLineOut.Description := Vendor.Name;
                        InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                        InterfaceEntryLineOut."Log Message" := Vendor.Address;
                        InterfaceEntryLineOut."Message ID" := Vendor.City;
                        InterfaceEntryLineOut."Ship-to Post Code" := Vendor."Post Code";
                        InterfaceEntryLineOut."Ship-to City" := Vendor.County;
                        InterfaceEntryLineOut."Ship-to Country/Region Code" := Vendor."Country/Region Code";
                        InterfaceEntryLineOut."Phone No." := Vendor."Phone No.";
                        InterfaceEntryLineOut.Contact := Vendor."Fax No.";
                        InterfaceEntryLineOut."CMG Code" := Vendor."VAT Registration No.";
                        InterfaceEntryLineOut."Payment Terms Code" := Vendor."Payment Terms Code";
                        InterfaceEntryLineOut."E-Mail" := Vendor."E-Mail";
                        InterfaceEntryLineOut."Currency Code" := Vendor."Currency Code";
                        //HEI.13 >>
                        InterfaceEntryLineOut."Vendor Posting Group" := Vendor."Vendor Posting Group";
                        //HEI.13 <<
                        InterfaceEntryLineOut.INSERT;
                    end
                end;
                if InterfaceEntryLine."Buy-from Vendor No." = '*' then begin //new
                    Vendor.RESET;
                    Vendor.SETCURRENTKEY(Blocked);
                    Vendor.SETFILTER(Blocked, '<>%1', Vendor.Blocked::All);
                    if Vendor.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Buy-from Vendor No." := Vendor."No.";
                            InterfaceEntryLineOut.Description := Vendor.Name;
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                            InterfaceEntryLineOut."Log Message" := Vendor.Address;
                            InterfaceEntryLineOut."Message ID" := Vendor.City;
                            InterfaceEntryLineOut."Ship-to Post Code" := Vendor."Post Code";
                            InterfaceEntryLineOut."Ship-to City" := Vendor.County;
                            InterfaceEntryLineOut."Ship-to Country/Region Code" := Vendor."Country/Region Code";
                            InterfaceEntryLineOut."Phone No." := Vendor."Phone No.";
                            InterfaceEntryLineOut.Contact := Vendor."Fax No.";
                            InterfaceEntryLineOut."CMG Code" := Vendor."VAT Registration No.";
                            InterfaceEntryLineOut."Payment Terms Code" := Vendor."Payment Terms Code";
                            InterfaceEntryLineOut."E-Mail" := Vendor."E-Mail";
                            InterfaceEntryLineOut."Currency Code" := Vendor."Currency Code";
                            //HEI.13 >>
                            InterfaceEntryLineOut."Vendor Posting Group" := Vendor."Vendor Posting Group";
                            //HEI.13 <<
                            InterfaceEntryLineOut.INSERT;
                        until Vendor.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessCurrencyRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        DefaultDimension: Record "Default Dimension";
        CurrencyExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //GL Accounts Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;

        InterfaceSetup.GET(EskerInterfaceSetup."Esker Currency Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker Currency Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Currency Code" <> '*' then begin
                    CurrencyExchRate.RESET;
                    CurrencyExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                    Currency.RESET;
                    CurrencyExchRate.SETRANGE("Currency Code", InterfaceEntryLine."Currency Code");
                    if CurrencyExchRate.FINDLAST then begin
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            if Currency.GET(CurrencyExchRate."Currency Code") then;
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Currency Code" := CurrencyExchRate."Currency Code";
                            InterfaceEntryLineOut."Cross Reference No." := FORMAT(CurrencyExchRate."Exchange Rate Amount", 0, 9);
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                            InterfaceEntryLineOut."Blanket Order No." := FORMAT(CurrencyExchRate."Adjustment Exch. Rate Amount", 0, 9);
                            InterfaceEntryLineOut."Order No." := FORMAT(CurrencyExchRate."Relational Exch. Rate Amount", 0, 9);
                            InterfaceEntryLineOut."Buy-from Vendor No." := CurrencyExchRate."Relational Currency Code";
                            InterfaceEntryLineOut."Shortcut Dimension 1 Code" := FORMAT(Currency."Invoice Rounding Type");
                            InterfaceEntryLineOut."Shortcut Dimension 2 Code" := FORMAT(Currency."Invoice Rounding Precision", 0, 9);
                            InterfaceEntryLineOut."Global No." := FORMAT(Currency."Unit-Amount Rounding Precision", 0, 9);
                            InterfaceEntryLineOut."No." := FORMAT(Currency."Amount Rounding Precision", 0, 9);
                            InterfaceEntryLineOut."CMG Code" := FORMAT(Currency."VAT Rounding Type");

                            InterfaceEntryLineOut.INSERT;
                        until CurrencyExchRate.NEXT = 0;
                    end
                end;
                if InterfaceEntryLine."Currency Code" = '*' then begin //new
                    GeneralLedgerSetup.GET;
                    //insert local currency
                    CLEAR(InterfaceEntryLineOut);
                    EntryNo += 1;
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."Currency Code" := GeneralLedgerSetup."LCY Code";
                    InterfaceEntryLineOut."Cross Reference No." := '1';
                    InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                    InterfaceEntryLineOut."Blanket Order No." := '1';
                    InterfaceEntryLineOut."Order No." := '1';
                    InterfaceEntryLineOut."No." := FORMAT(GeneralLedgerSetup."Amount Rounding Precision", 0, 9);
                    InterfaceEntryLineOut."CMG Code" := FORMAT(GeneralLedgerSetup."VAT Rounding Type");

                    InterfaceEntryLineOut.INSERT;
                    //other currencies
                    CurrencyExchRate.RESET;
                    CurrencyExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                    Currency.RESET;
                    if Currency.FINDFIRST then begin
                        repeat
                            CurrencyExchRate.RESET;
                            CurrencyExchRate.SETCURRENTKEY("Currency Code", "Starting Date");
                            CurrencyExchRate.SETRANGE("Currency Code", Currency.Code);
                            if CurrencyExchRate.FINDLAST then begin
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut."Currency Code" := CurrencyExchRate."Currency Code";
                                InterfaceEntryLineOut."Cross Reference No." := FORMAT(CurrencyExchRate."Exchange Rate Amount", 0, 9);
                                InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                                InterfaceEntryLineOut."Blanket Order No." := FORMAT(CurrencyExchRate."Adjustment Exch. Rate Amount", 0, 9);
                                InterfaceEntryLineOut."Order No." := FORMAT(CurrencyExchRate."Relational Exch. Rate Amount", 0, 9);
                                InterfaceEntryLineOut."Buy-from Vendor No." := CurrencyExchRate."Relational Currency Code";
                                InterfaceEntryLineOut."Shortcut Dimension 1 Code" := FORMAT(Currency."Invoice Rounding Type");
                                InterfaceEntryLineOut."Shortcut Dimension 2 Code" := FORMAT(Currency."Invoice Rounding Precision", 0, 9);
                                InterfaceEntryLineOut."Global No." := FORMAT(Currency."Unit-Amount Rounding Precision", 0, 9);
                                InterfaceEntryLineOut."No." := FORMAT(Currency."Amount Rounding Precision", 0, 9);
                                InterfaceEntryLineOut."CMG Code" := FORMAT(Currency."VAT Rounding Type");
                                InterfaceEntryLineOut.INSERT;
                            end;
                        until Currency.NEXT = 0;
                    end;

                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessTaxCodeRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        DefaultDimension: Record "Default Dimension";
        TaxCode: Record "VAT Posting Setup";
        TaxCodeStr: Text[30];
    begin
        //TaxCode Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;

        InterfaceSetup.GET(EskerInterfaceSetup."Esker TaxCode Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker TaxCode Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Phone No." <> '*' then begin
                    TaxCode.RESET;
                    TaxCode.SETRANGE("VAT Identifier", InterfaceEntryLine."Phone No.");
                    TaxCode.SETFILTER("VAT Bus. Posting Group", '<>%1', '');
                    if TaxCode.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";

                        TaxCodeStr := '';
                        if TaxCode."VAT Bus. Posting Group" <> '' then
                            TaxCodeStr += ' (' + TaxCode."VAT Bus. Posting Group" + ')';


                        InterfaceEntryLineOut."Phone No." := TaxCode."VAT Identifier" + TaxCodeStr;
                        InterfaceEntryLineOut.Description := TaxCode."VAT Bus. Posting Group" + ' ' + TaxCode."VAT Prod. Posting Group";
                        InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                        InterfaceEntryLineOut."Buy-from Vendor No." := FORMAT(TaxCode."VAT %", 0, 9);
                        InterfaceEntryLineOut."Account No." := TaxCode."Purchase VAT Account";
                        InterfaceEntryLineOut."Bill-to Customer No." := TaxCode."Sales VAT Account";
                        InterfaceEntryLineOut."Global No." := FORMAT(TaxCode."VAT Calculation Type");

                        InterfaceEntryLineOut.INSERT;
                    end
                end;
                if InterfaceEntryLine."Phone No." = '*' then begin //new
                    TaxCode.RESET;
                    TaxCode.SETFILTER("VAT Bus. Posting Group", '<>%1', '');
                    if TaxCode.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            TaxCodeStr := '';
                            if TaxCode."VAT Bus. Posting Group" <> '' then
                                TaxCodeStr += ' (' + TaxCode."VAT Bus. Posting Group" + ')';
                            InterfaceEntryLineOut."Phone No." := TaxCode."VAT Identifier" + TaxCodeStr;
                            InterfaceEntryLineOut.Description := TaxCode."VAT Bus. Posting Group" + ' ' + TaxCode."VAT Prod. Posting Group";
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                            InterfaceEntryLineOut."Buy-from Vendor No." := FORMAT(TaxCode."VAT %", 0, 9);
                            InterfaceEntryLineOut."Account No." := TaxCode."Purchase VAT Account";
                            InterfaceEntryLineOut."Bill-to Customer No." := TaxCode."Sales VAT Account";
                            InterfaceEntryLineOut."Global No." := FORMAT(TaxCode."VAT Calculation Type");
                            InterfaceEntryLineOut.INSERT;
                        until TaxCode.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessPaymTermRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        DefaultDimension: Record "Default Dimension";
        PaymTerm: Record "Payment Terms";
        InitialDate: Date;
        DueDate: Date;
        Day: Integer;
    begin
        //PaymTerm Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;

        InterfaceSetup.GET(EskerInterfaceSetup."Esker PaymTerm Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker PaymTerm Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");

        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Payment Terms Code" <> '*' then begin
                    PaymTerm.RESET;
                    PaymTerm.SETRANGE(Code, InterfaceEntryLine."Payment Terms Code");
                    if PaymTerm.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut."Payment Terms Code" := PaymTerm.Code;
                        InterfaceEntryLineOut.Description := PaymTerm.Description;
                        InterfaceEntryLineOut."Description 2" := COMPANYNAME;

                        //calculate the Day Limit
                        InitialDate := 20150101D;
                        DueDate := CALCDATE(PaymTerm."Due Date Calculation", InitialDate);
                        Day := DueDate - InitialDate;
                        if STRPOS(FORMAT(PaymTerm."Due Date Calculation"), 'CM') > 0 then
                            Day := Day - 30;
                        if Day < 0 then
                            Day := 0;
                        InterfaceEntryLineOut."CMG Code" := FORMAT(Day);

                        //calculate End of Month field
                        if STRPOS(FORMAT(PaymTerm."Due Date Calculation"), 'CM') > 0 then
                            InterfaceEntryLineOut."Global No." := 'TRUE'
                        else
                            InterfaceEntryLineOut."Global No." := 'FALSE';

                        InterfaceEntryLineOut.INSERT;
                    end
                end;
                if InterfaceEntryLine."Payment Terms Code" = '*' then begin //new
                    PaymTerm.RESET;
                    if PaymTerm.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Payment Terms Code" := PaymTerm.Code;
                            InterfaceEntryLineOut.Description := PaymTerm.Description;
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;

                            //calculate the Day Limit
                            InitialDate := 20150101D;
                            DueDate := CALCDATE(PaymTerm."Due Date Calculation", InitialDate);
                            Day := DueDate - InitialDate;
                            if STRPOS(FORMAT(PaymTerm."Due Date Calculation"), 'CM') > 0 then
                                Day := Day - 30;
                            if Day < 0 then
                                Day := 0;
                            InterfaceEntryLineOut."CMG Code" := FORMAT(Day);

                            //calculate End of Month field
                            if STRPOS(FORMAT(PaymTerm."Due Date Calculation"), 'CM') > 0 then
                                InterfaceEntryLineOut."Global No." := 'TRUE'
                            else
                                InterfaceEntryLineOut."Global No." := 'FALSE';
                            InterfaceEntryLineOut.INSERT;
                        until PaymTerm.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessBankDetailRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        DefaultDimension: Record "Default Dimension";
        BankDetail: Record "Vendor Bank Account";
    begin
        //Bank Detail Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;

        InterfaceSetup.GET(EskerInterfaceSetup."Esker BankDetail Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker BankDetail Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Buy-from Vendor No." <> '*' then begin
                    BankDetail.RESET;
                    BankDetail.SETCURRENTKEY("Vendor No.", Code);
                    BankDetail.SETRANGE("Vendor No.", InterfaceEntryLine."Buy-from Vendor No.");
                    if BankDetail.FINDFIRST then begin
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Buy-from Vendor No." := BankDetail."Vendor No.";
                            InterfaceEntryLineOut.Description := ReplaceString(ReplaceString(BankDetail.Name, '"', '{QUOTE}'), '{QUOTE}', '\"');
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                            InterfaceEntryLineOut."Zone Code" := BankDetail."Country/Region Code";
                            InterfaceEntryLineOut."No." := BankDetail.Code;
                            InterfaceEntryLineOut."Phone No." := BankDetail."Bank Account No.";
                            InterfaceEntryLineOut.Contact := BankDetail.Contact;
                            InterfaceEntryLineOut."Machine Reference No." := BankDetail.IBAN;
                            InterfaceEntryLineOut.INSERT;
                        until BankDetail.NEXT = 0;
                    end
                end;
                if InterfaceEntryLine."Buy-from Vendor No." = '*' then begin //new
                    BankDetail.RESET;
                    if BankDetail.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Buy-from Vendor No." := BankDetail."Vendor No.";
                            InterfaceEntryLineOut.Description := ReplaceString(ReplaceString(BankDetail.Name, '"', '{QUOTE}'), '{QUOTE}', '\"');
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                            InterfaceEntryLineOut."Zone Code" := BankDetail."Country/Region Code";
                            InterfaceEntryLineOut."No." := BankDetail.Code;
                            InterfaceEntryLineOut."Phone No." := BankDetail."Bank Account No.";
                            InterfaceEntryLineOut.Contact := BankDetail.Contact;
                            InterfaceEntryLineOut."Machine Reference No." := BankDetail.IBAN;
                            InterfaceEntryLineOut.INSERT;
                        until BankDetail.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    local procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250];
    begin
        while STRPOS(String, FindWhat) > 0 do
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure ProcessPOHeaderRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        DefaultDimension: Record "Default Dimension";
        POHeader: Record "Purchase Header";
        GLSetup: Record "General Ledger Setup";
        CompletedPOLine: Integer;
        TotalPOLine: Integer;
        CurrCode: Code[10];
        Status: Code[1];
        ExportCurrLine: Boolean;
        recUserSetup: Record "User Setup";
        recPurchasers: Record "Salesperson/Purchaser";
        PurchLine: Record "Purchase Line";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //PO Header Lists NAV -> Esker

        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;

        InterfaceSetup.GET(EskerInterfaceSetup."Esker POHeader Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker POHeader Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine.Description <> '*' then begin
                    POHeader.RESET;
                    POHeader.SETCURRENTKEY("Document Type", Status, "Pay-to Vendor No.");
                    POHeader.SETRANGE("Document Type", POHeader."Document Type"::Order);
                    POHeader.SETFILTER(Status, '<>%1', POHeader.Status::Open);
                    ConvertFilterText(InterfaceEntryLine.Description);
                    POHeader.SETFILTER("Pay-to Vendor No.", InterfaceEntryLine.Description);
                    if POHeader.FINDFIRST then begin
                        repeat
                            //>>test the current line
                            ExportCurrLine := true;
                            GLSetup.GET;
                            CLEAR(CompletedPOLine);
                            CLEAR(TotalPOLine);
                            if POHeader."Currency Code" <> '' then
                                CurrCode := POHeader."Currency Code"
                            else
                                CurrCode := GLSetup."LCY Code";
                            PurchLine.RESET;
                            PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                            PurchLine.SETRANGE("Document No.", POHeader."No.");
                            if PurchLine.ISEMPTY then
                                ExportCurrLine := false;

                            PurchLine.RESET;
                            PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                            PurchLine.SETRANGE("Document No.", POHeader."No.");
                            TotalPOLine := PurchLine.COUNT;
                            if PurchLine.FINDSET then
                                repeat
                                    if (PurchLine.Quantity = PurchLine."Quantity Received") and (PurchLine.Quantity = PurchLine."Quantity Invoiced") then
                                        CompletedPOLine += 1
      until PurchLine.NEXT = 0;
                            if TotalPOLine = CompletedPOLine then
                                ExportCurrLine := false;
                            if POHeader.Status = POHeader.Status::Released then
                                Status := '1'
                            else
                                Status := '0';
                            //<<test the current line
                            if ExportCurrLine then begin
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut."Buy-from Vendor No." := POHeader."Pay-to Vendor No.";

                                InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                                InterfaceEntryLineOut."Order No." := POHeader."No.";
                                InterfaceEntryLineOut."Cross Reference No." := FORMAT(POHeader."Order Date", 0, 9);
                                POHeader.CALCFIELDS(Amount);
                                InterfaceEntryLineOut."Blanket Order No." := FORMAT(POHeader.Amount, 0, 9);

                                InterfaceEntryLineOut."Global No." := FORMAT(FctCalcInvoicedAmount(POHeader."Document Type".AsInteger(), POHeader."No."), 0, 9);
                                InterfaceEntryLineOut."CMG Code" := FORMAT(FctCalcDeliveredAmount(POHeader."Document Type".AsInteger(), POHeader."No."), 0, 9);
                                //requester email
                                //BC Upgrade GUNREM01 -DIT Field >>
                                // if POHeader."Requester ID" <> '' then begin
                                //     if recUserSetup.GET(POHeader."Requester ID") then
                                //         InterfaceEntryLineOut."Log Message" := recUserSetup."E-Mail";
                                // end;
                                //BC Upgrade GUNREM01 -DIT Field <<
                                //buyer email

                                /*HEI.05 begin comment
                                IF POHeader."Purchaser Code" <> '' THEN BEGIN
                                  IF recPurchasers.GET(POHeader."Purchaser Code") THEN
                                    InterfaceEntryLineOut."E-Mail" := recPurchasers."E-Mail";
                                END;
                                HEI.05*/
                                //HEI.05>>
                                //BC Upgrade GUNREM01 -DIT Field >>
                                // if POHeader."Created By" <> '' then begin
                                //     if recUserSetup.GET(POHeader."Created By") then
                                //         InterfaceEntryLineOut."E-Mail" := recUserSetup."E-Mail";
                                // end;
                                //BC Upgrade GUNREM01 -DIT Field <<
                                //HEi.05<<

                                //receiver email
                                if POHeader."Assigned User ID" <> '' then begin
                                    if recUserSetup.GET(POHeader."Assigned User ID") then
                                        InterfaceEntryLineOut."E-Mail 2" := recUserSetup."E-Mail";
                                end;

                                //HEI.16<<
                                //License Code
                                if PurchaseHeaderAdditional.GET(POHeader."Document Type", POHeader."No.") then
                                    InterfaceEntryLineOut."Project Code" := PurchaseHeaderAdditional."License Code";
                                //HEI.16>>

                                InterfaceEntryLineOut."Payment Terms Code" := POHeader."Payment Terms Code";
                                InterfaceEntryLineOut."Currency Code" := CurrCode;
                                InterfaceEntryLineOut.Status := Status;
                                InterfaceEntryLineOut.INSERT;
                            end;
                        until POHeader.NEXT = 0;
                    end
                end;

                if InterfaceEntryLine.Description = '*' then begin //new
                    POHeader.RESET;
                    POHeader.SETCURRENTKEY("Document Type", Status, "Pay-to Vendor No.");
                    POHeader.SETRANGE("Document Type", POHeader."Document Type"::Order);
                    POHeader.SETFILTER(Status, '<>%1', POHeader.Status::Open);

                    if POHeader.FINDSET then
                        repeat
                            //>>test the current line
                            ExportCurrLine := true;
                            GLSetup.GET;
                            CLEAR(CompletedPOLine);
                            CLEAR(TotalPOLine);
                            if POHeader."Currency Code" <> '' then
                                CurrCode := POHeader."Currency Code"
                            else
                                CurrCode := GLSetup."LCY Code";
                            PurchLine.RESET;
                            PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                            PurchLine.SETRANGE("Document No.", POHeader."No.");
                            if PurchLine.ISEMPTY then
                                ExportCurrLine := false;

                            PurchLine.RESET;
                            PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                            PurchLine.SETRANGE("Document No.", POHeader."No.");
                            TotalPOLine := PurchLine.COUNT;
                            if PurchLine.FINDSET then
                                repeat
                                    if (PurchLine.Quantity = PurchLine."Quantity Received") and (PurchLine.Quantity = PurchLine."Quantity Invoiced") then
                                        CompletedPOLine += 1
      until PurchLine.NEXT = 0;
                            if TotalPOLine = CompletedPOLine then
                                ExportCurrLine := false;
                            if POHeader.Status = POHeader.Status::Released then
                                Status := '1'
                            else
                                Status := '0';
                            //<<test the current line
                            if ExportCurrLine then begin
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut."Buy-from Vendor No." := POHeader."Pay-to Vendor No.";

                                InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                                InterfaceEntryLineOut."Order No." := POHeader."No.";
                                InterfaceEntryLineOut."Cross Reference No." := FORMAT(POHeader."Order Date", 0, 9);
                                POHeader.CALCFIELDS(Amount);
                                InterfaceEntryLineOut."Blanket Order No." := FORMAT(POHeader.Amount, 0, 9);

                                InterfaceEntryLineOut."Global No." := FORMAT(FctCalcInvoicedAmount(POHeader."Document Type".AsInteger(), POHeader."No."), 0, 9);
                                InterfaceEntryLineOut."CMG Code" := FORMAT(FctCalcDeliveredAmount(POHeader."Document Type".AsInteger(), POHeader."No."), 0, 9);
                                //requester email
                                //BC Upgrade GUNREM01 -DIT Field >>
                                // if POHeader."Requester ID" <> '' then begin
                                //     if recUserSetup.GET(POHeader."Requester ID") then
                                //         InterfaceEntryLineOut."Log Message" := recUserSetup."E-Mail";
                                // end;
                                //BC Upgrade GUNREM01 -DIT Field <<
                                //buyer email
                                if POHeader."Purchaser Code" <> '' then begin
                                    if recPurchasers.GET(POHeader."Purchaser Code") then
                                        InterfaceEntryLineOut."E-Mail" := recPurchasers."E-Mail";
                                end;
                                //receiver email
                                if POHeader."Assigned User ID" <> '' then begin
                                    if recUserSetup.GET(POHeader."Assigned User ID") then
                                        InterfaceEntryLineOut."E-Mail 2" := recUserSetup."E-Mail";
                                end;

                                //HEI.16<<
                                //License Code
                                if PurchaseHeaderAdditional.GET(POHeader."Document Type", POHeader."No.") then
                                    InterfaceEntryLineOut."Project Code" := PurchaseHeaderAdditional."License Code";
                                //HEI.16>>

                                InterfaceEntryLineOut."Payment Terms Code" := POHeader."Payment Terms Code";
                                InterfaceEntryLineOut."Currency Code" := CurrCode;
                                InterfaceEntryLineOut.Status := Status;
                                InterfaceEntryLineOut.INSERT;
                            end;

                        until POHeader.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;

        //for empty response
        if EntryNo = 0 then begin
            CLEAR(InterfaceEntryLineOut);
            EntryNo += 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."Buy-from Vendor No." := '';

            InterfaceEntryLineOut."Description 2" := '';
            InterfaceEntryLineOut."Order No." := '';
            InterfaceEntryLineOut."Cross Reference No." := '';

            InterfaceEntryLineOut."Blanket Order No." := '';

            InterfaceEntryLineOut."Global No." := '';
            InterfaceEntryLineOut."CMG Code" := '';

            InterfaceEntryLineOut."Log Message" := '';

            InterfaceEntryLineOut."E-Mail" := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Payment Terms Code" := '';
            InterfaceEntryLineOut."Currency Code" := '';
            InterfaceEntryLineOut.Status := '';
            InterfaceEntryLineOut."Project Code" := ''; //HEI.16
            InterfaceEntryLineOut.INSERT;
        end;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);

    end;

    local procedure FctCalcInvoicedAmount(DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]) DecInvoicedAmount: Decimal;
    var
        RecLPurchLine: Record "Purchase Line";
    begin
        DecInvoicedAmount := 0;
        RecLPurchLine.RESET;
        RecLPurchLine.SETRANGE("Document Type", DocType);
        RecLPurchLine.SETRANGE("Document No.", DocNo);
        if RecLPurchLine.FINDSET then
            repeat
                if (RecLPurchLine.Quantity <> 0) then
                    DecInvoicedAmount += RecLPurchLine."Quantity Invoiced" * RecLPurchLine.Amount / RecLPurchLine.Quantity;
            until RecLPurchLine.NEXT = 0;
        exit(DecInvoicedAmount);
    end;

    local procedure FctCalcDeliveredAmount(DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]) DecDeliveredAmount: Decimal;
    var
        RecLPurchLine: Record "Purchase Line";
    begin
        DecDeliveredAmount := 0;
        RecLPurchLine.RESET;
        RecLPurchLine.SETRANGE("Document Type", DocType);
        RecLPurchLine.SETRANGE("Document No.", DocNo);
        if RecLPurchLine.FINDSET then
            repeat
                if (RecLPurchLine.Quantity <> 0) then
                    DecDeliveredAmount += RecLPurchLine."Quantity Received" * RecLPurchLine.Amount / RecLPurchLine.Quantity;
            until RecLPurchLine.NEXT = 0;
        exit(DecDeliveredAmount);
    end;

    procedure ProcessPOLineRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        DefaultDimension: Record "Default Dimension";
        POLine: Record "Purchase Line";
        GLSetup: Record "General Ledger Setup";
        CompletedPOLine: Integer;
        TotalPOLine: Integer;
        CurrCode: Code[10];
        Status: Code[1];
        ExportCurrLine: Boolean;
        recUserSetup: Record "User Setup";
        recPurchasers: Record "Salesperson/Purchaser";
        PurchLine: Record "Purchase Line";
        PurchHdr: Record "Purchase Header";
        DimensionSetEntry: Record "Dimension Set Entry";
        PORcptLine: Record "Purch. Rcpt. Line";
        recGPurchLine: Record "Purchase Line";
        RcptLineQtyAssign: Text[30];
        RcptLineQtyAssigned: Text[30];
        RcptLineType: Text[30];
        recPurchRcptHeader: Record "Purch. Rcpt. Line";
    begin
        //PO Line Lists NAV -> Esker

        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;
        OpCoSetup.GET;
        GeneralInterfaceSetup.TESTFIELD("Cost Center Dimension Code");
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        OpCoSetup.TESTFIELD("Business Type Dimension Code");
        OpCoSetup.TESTFIELD("Movement Type Dimension Code");

        InterfaceSetup.GET(EskerInterfaceSetup."Esker POLine Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker POLine Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine.Description <> '*' then begin
                    //Purchase Line
                    POLine.RESET;
                    //HEI.14 comment POLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    //HEI.14>>
                    POLine.SETCURRENTKEY("Document Type", "Document No.", "Pay-to Vendor No.");
                    //HEI.14<<
                    POLine.SETRANGE("Document Type", POLine."Document Type"::Order);
                    ConvertFilterText(InterfaceEntryLine.Description);
                    POLine.SETFILTER("Pay-to Vendor No.", InterfaceEntryLine.Description);
                    if POLine.FINDFIRST then begin
                        repeat
                            //>>test the current line
                            ExportCurrLine := true;

                            if (POLine.Quantity = POLine."Quantity Received") or (POLine.Quantity = POLine."Quantity Invoiced") then
                                ExportCurrLine := false;

                            PurchHdr.RESET;
                            //HEI.14>>
                            PurchHdr.SETCURRENTKEY("Document Type", "No.", Status);
                            //HEI.14<<
                            PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::Order);
                            PurchHdr.SETRANGE("No.", POLine."Document No.");
                            PurchHdr.SETFILTER(Status, '<>%1', PurchHdr.Status::Open);
                            if PurchHdr.ISEMPTY then
                                ExportCurrLine := false;
                            //<<test the current line


                            if ExportCurrLine then begin
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut."Buy-from Vendor No." := POLine."Pay-to Vendor No.";

                                InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                                InterfaceEntryLineOut."Order No." := POLine."Document No.";
                                InterfaceEntryLineOut."Item No." := FORMAT(POLine."Line No.");
                                InterfaceEntryLineOut."No." := POLine."No.";
                                InterfaceEntryLineOut.Description := ReplaceString(ReplaceString(POLine.Description, '"', '{QUOTE}'), '{QUOTE}', '\"');
                                InterfaceEntryLineOut."Global No." := FORMAT(POLine."Direct Unit Cost", 0, '<Precision,4:4><Standard Format,9>');
                                //order amount
                                InterfaceEntryLineOut."Cross Reference No." := FORMAT(POLine."Line Amount", 0, 9);
                                //order qty
                                InterfaceEntryLineOut."Blanket Order No." := FORMAT(POLine.Quantity, 0, 9);
                                //invoice amount
                                InterfaceEntryLineOut."CMG Code" := '0';
                                //invoiced quantity
                                InterfaceEntryLineOut."Ship-to Name" := '0';
                                //delivered amount
                                InterfaceEntryLineOut."Ship-to Address" := '0';
                                //delivered quantity
                                InterfaceEntryLineOut."Ship-to Address 2" := '0';
                                //tax code
                                InterfaceEntryLineOut.Contact := POLine."VAT Identifier";
                                if POLine."VAT Bus. Posting Group" <> '' then
                                    InterfaceEntryLineOut.Contact := InterfaceEntryLineOut.Contact + ' (' + POLine."VAT Bus. Posting Group" + ')';
                                //good receipt
                                InterfaceEntryLineOut."Phone No." := '';
                                InterfaceEntryLineOut."External Requisition No." := '';
                                //Type
                                InterfaceEntryLineOut."Ship-to City" := FORMAT(POLine.Type);
                                //quantity to assign
                                InterfaceEntryLineOut."Ship-to Post Code" := FORMAT(POLine."Qty. to Assign", 0, 9);
                                InterfaceEntryLineOut."E-Mail 2" := FORMAT(POLine."Qty. Assigned", 0, 9);
                                InterfaceEntryLineOut."Unit of Measure Code" := POLine."Unit of Measure Code";
                                //dimensions

                                //BRAND dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionSetEntry."Dimension Value Code";
                                end;

                                //Cost center dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Cost Center Code" := DimensionSetEntry."Dimension Value Code";
                                end;

                                //Business Type dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Business Type Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Shortcut Dimension 2 Code" := DimensionSetEntry."Dimension Value Code";
                                end;


                                //Movement Type dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Movement Type Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Movement Type" := DimensionSetEntry."Dimension Value Code";
                                end;

                                InterfaceEntryLineOut.INSERT;
                            end;
                        until POLine.NEXT = 0;
                    end;
                    //Purchase receipt
                    //>>purchase receipt line
                    //Purchase receipt Line
                    PORcptLine.RESET;
                    //HEI.14 comment line PORcptLine.SETCURRENTKEY("Order No.","Order Line No.");
                    //HEI.14>>
                    PORcptLine.SETCURRENTKEY("Order No.", Quantity, "Pay-to Vendor No.");
                    //HEI.14<<
                    PORcptLine.SETFILTER("Order No.", '<>%1', '');
                    PORcptLine.SETFILTER(Quantity, '<>%1', 0);
                    ConvertFilterText(InterfaceEntryLine.Description);
                    PORcptLine.SETFILTER("Pay-to Vendor No.", InterfaceEntryLine.Description);


                    if PORcptLine.FINDFIRST then begin
                        repeat
                            //>>test each line
                            ExportCurrLine := true;
                            if not recGPurchLine.GET(recGPurchLine."Document Type"::Order, PORcptLine."Order No.", PORcptLine."Order Line No.") then
                                ExportCurrLine := false
                            else begin
                                if (recGPurchLine."Quantity Received" = recGPurchLine.Quantity) and (recGPurchLine."Quantity Invoiced" = recGPurchLine.Quantity) then
                                    ExportCurrLine := false;
                                if PurchHdr.GET(recGPurchLine."Document Type", recGPurchLine."Document No.") then
                                    if PurchHdr.Status = PurchHdr.Status::Open then
                                        ExportCurrLine := false;
                                recGPurchLine.RESET;
                                recGPurchLine.SETRANGE(recGPurchLine."Document Type", recGPurchLine."Document Type"::Order);
                                recGPurchLine.SETRANGE(recGPurchLine."Document No.", PORcptLine."Order No.");
                                recGPurchLine.SETRANGE(recGPurchLine."Line No.", PORcptLine."Order Line No.");
                                if recGPurchLine.FINDFIRST then begin
                                    RcptLineType := FORMAT(recGPurchLine.Type);
                                    recGPurchLine.CALCFIELDS("Qty. to Assign", "Qty. Assigned");
                                    RcptLineQtyAssign := FORMAT(recGPurchLine."Qty. to Assign");
                                    RcptLineQtyAssigned := FORMAT(recGPurchLine."Qty. Assigned");
                                end;
                            end;
                            //<<test each line
                            if ExportCurrLine then begin
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut."Buy-from Vendor No." := PORcptLine."Pay-to Vendor No.";

                                InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                                InterfaceEntryLineOut."Order No." := PORcptLine."Order No.";
                                InterfaceEntryLineOut."Item No." := FORMAT(PORcptLine."Order Line No.");
                                InterfaceEntryLineOut."No." := PORcptLine."No.";
                                InterfaceEntryLineOut.Description := ReplaceString(ReplaceString(PORcptLine.Description, '"', '{QUOTE}'), '{QUOTE}', '\"');
                                InterfaceEntryLineOut."Global No." := FORMAT(PORcptLine."Direct Unit Cost", 0, '<Precision,4:4><Standard Format,9>');
                                //order amount
                                InterfaceEntryLineOut."Cross Reference No." := '0';
                                if recGPurchLine.Amount <> 0 then
                                    InterfaceEntryLineOut."Cross Reference No." := FORMAT(recGPurchLine.Amount, 0, 9);

                                //order qty
                                InterfaceEntryLineOut."Blanket Order No." := '0';
                                if recGPurchLine.Quantity <> 0 then
                                    InterfaceEntryLineOut."Blanket Order No." := FORMAT(recGPurchLine.Quantity, 0, 9);

                                //invoice amount
                                if recGPurchLine.Quantity <> 0 then
                                    InterfaceEntryLineOut."CMG Code" := FORMAT(PORcptLine."Quantity Invoiced" * recGPurchLine.Amount / recGPurchLine.Quantity, 0, 9);


                                //invoiced quantity
                                InterfaceEntryLineOut."Ship-to Name" := FORMAT(PORcptLine."Quantity Invoiced", 0, 9);

                                //delivered amount
                                if recGPurchLine.Quantity <> 0 then
                                    InterfaceEntryLineOut."Ship-to Address" := FORMAT(PORcptLine.Quantity * recGPurchLine.Amount / recGPurchLine.Quantity, 0, 9);

                                //delivered quantity
                                InterfaceEntryLineOut."Ship-to Address 2" := FORMAT(PORcptLine.Quantity, 0, 9);

                                //tax code
                                InterfaceEntryLineOut.Contact := recGPurchLine."VAT Identifier";
                                if recGPurchLine."VAT Bus. Posting Group" <> '' then
                                    InterfaceEntryLineOut.Contact := InterfaceEntryLineOut.Contact + ' (' + recGPurchLine."VAT Bus. Posting Group" + ')';

                                //good receipt
                                InterfaceEntryLineOut."Phone No." := PORcptLine."Document No.";

                                if recPurchRcptHeader.GET(PORcptLine."Document No.") then
                                    // InterfaceEntryLineOut."External Requisition No." := FORMAT(recPurchRcptHeader."Document Date", 0, 9); //BC Upgrade GUNREM01 -DIT Field

                                    //Type
                                    InterfaceEntryLineOut."Ship-to City" := RcptLineType;
                                //quantity to assign
                                InterfaceEntryLineOut."Ship-to Post Code" := RcptLineQtyAssign;
                                InterfaceEntryLineOut."E-Mail 2" := RcptLineQtyAssigned;
                                InterfaceEntryLineOut."Unit of Measure Code" := PORcptLine."Unit of Measure Code";
                                //dimensions

                                //BRAND dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionSetEntry."Dimension Value Code";
                                end;

                                //Cost center dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Cost Center Code" := DimensionSetEntry."Dimension Value Code";
                                end;

                                //Business Type dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Business Type Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Shortcut Dimension 2 Code" := DimensionSetEntry."Dimension Value Code";
                                end;


                                //Movement Type dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Movement Type Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Movement Type" := DimensionSetEntry."Dimension Value Code";
                                end;

                                InterfaceEntryLineOut.INSERT;
                            end;
                        until PORcptLine.NEXT = 0;
                    end

                    //<<purchase receipt line

                end;

                if InterfaceEntryLine.Description = '*' then begin //new
                    POLine.RESET;
                    POLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    POLine.SETRANGE("Document Type", POLine."Document Type"::Order);
                    if POLine.FINDSET then
                        repeat
                            //>>test the current line
                            ExportCurrLine := true;

                            if (POLine.Quantity = POLine."Quantity Received") or (POLine.Quantity = POLine."Quantity Invoiced") then
                                ExportCurrLine := false;

                            PurchHdr.RESET;
                            //HEI.14 comment PurchHdr.SETCURRENTKEY("Document Type", Status, "Pay-to Vendor No.");
                            //HEI.14>>
                            PurchHdr.SETCURRENTKEY("Document Type", "No.", Status);
                            //HEI.14<<
                            PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::Order);
                            PurchHdr.SETRANGE("No.", POLine."Document No.");
                            PurchHdr.SETFILTER(Status, '<>%1', PurchHdr.Status::Open);
                            if PurchHdr.ISEMPTY then
                                ExportCurrLine := false;
                            //<<test the current line
                            if ExportCurrLine then begin
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut."Buy-from Vendor No." := POLine."Pay-to Vendor No.";

                                InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                                InterfaceEntryLineOut."Order No." := POLine."Document No.";
                                InterfaceEntryLineOut."Item No." := FORMAT(POLine."Line No.");
                                InterfaceEntryLineOut."No." := POLine."No.";
                                InterfaceEntryLineOut.Description := ReplaceString(ReplaceString(POLine.Description, '"', '{QUOTE}'), '{QUOTE}', '\"');
                                InterfaceEntryLineOut."Global No." := FORMAT(POLine."Direct Unit Cost", 0, '<Precision,4:4><Standard Format,9>');
                                //order amount
                                InterfaceEntryLineOut."Cross Reference No." := FORMAT(POLine."Line Amount", 0, 9);
                                //order qty
                                InterfaceEntryLineOut."Blanket Order No." := FORMAT(POLine.Quantity, 0, 9);
                                //invoice amount
                                InterfaceEntryLineOut."CMG Code" := '0';
                                //invoiced quantity
                                InterfaceEntryLineOut."Ship-to Name" := '0';
                                //delivered amount
                                InterfaceEntryLineOut."Ship-to Address" := '0';
                                //delivered quantity
                                InterfaceEntryLineOut."Ship-to Address 2" := '0';
                                //tax code
                                InterfaceEntryLineOut.Contact := POLine."VAT Identifier";
                                if POLine."VAT Bus. Posting Group" <> '' then
                                    InterfaceEntryLineOut.Contact := InterfaceEntryLineOut.Contact + ' (' + POLine."VAT Bus. Posting Group" + ')';
                                //good receipt
                                InterfaceEntryLineOut."Phone No." := '';
                                InterfaceEntryLineOut."External Requisition No." := '';
                                //Type
                                InterfaceEntryLineOut."Ship-to City" := FORMAT(POLine.Type);
                                //quantity to assign
                                InterfaceEntryLineOut."Ship-to Post Code" := FORMAT(POLine."Qty. to Assign", 0, 9);
                                InterfaceEntryLineOut."E-Mail 2" := FORMAT(POLine."Qty. Assigned", 0, 9);
                                InterfaceEntryLineOut."Unit of Measure Code" := POLine."Unit of Measure Code";
                                //dimensions

                                //BRAND dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionSetEntry."Dimension Value Code";
                                end;

                                //Cost center dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Cost Center Code" := DimensionSetEntry."Dimension Value Code";
                                end;

                                //Business Type dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Business Type Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Shortcut Dimension 2 Code" := DimensionSetEntry."Dimension Value Code";
                                end;


                                //Movement Type dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Movement Type Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Movement Type" := DimensionSetEntry."Dimension Value Code";
                                end;

                                InterfaceEntryLineOut.INSERT;
                            end;
                        until POLine.NEXT = 0;

                    //>>purchase receipt line
                    //Purchase receipt Line

                    PORcptLine.RESET;
                    //HEI.14 comment PORcptLine.SETCURRENTKEY("Order No.","Order Line No.");
                    //HEI.14>>
                    PORcptLine.SETCURRENTKEY("Order No.", Quantity);
                    //HEI.14<<
                    PORcptLine.SETFILTER("Order No.", '<>%1', '');
                    PORcptLine.SETFILTER(Quantity, '<>%1', 0);
                    if PORcptLine.FINDFIRST then begin
                        repeat
                            //>>test each line
                            ExportCurrLine := true;
                            if not recGPurchLine.GET(recGPurchLine."Document Type"::Order, PORcptLine."Order No.", PORcptLine."Order Line No.") then
                                ExportCurrLine := false
                            else begin
                                if (recGPurchLine."Quantity Received" = recGPurchLine.Quantity) and (recGPurchLine."Quantity Invoiced" = recGPurchLine.Quantity) then
                                    ExportCurrLine := false;
                                if PurchHdr.GET(recGPurchLine."Document Type", recGPurchLine."Document No.") then
                                    if PurchHdr.Status = PurchHdr.Status::Open then
                                        ExportCurrLine := false;
                                recGPurchLine.RESET;
                                recGPurchLine.SETRANGE(recGPurchLine."Document Type", recGPurchLine."Document Type"::Order);
                                recGPurchLine.SETRANGE(recGPurchLine."Document No.", PORcptLine."Order No.");
                                recGPurchLine.SETRANGE(recGPurchLine."Line No.", PORcptLine."Order Line No.");
                                if recGPurchLine.FINDFIRST then begin
                                    RcptLineType := FORMAT(recGPurchLine.Type);
                                    recGPurchLine.CALCFIELDS("Qty. to Assign", "Qty. Assigned");
                                    RcptLineQtyAssign := FORMAT(recGPurchLine."Qty. to Assign");
                                    RcptLineQtyAssigned := FORMAT(recGPurchLine."Qty. Assigned");
                                end;
                            end;
                            //<<test each line
                            if ExportCurrLine then begin
                                CLEAR(InterfaceEntryLineOut);
                                EntryNo += 1;
                                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                InterfaceEntryLineOut."Entry No." := EntryNo;
                                InterfaceEntryLineOut."Buy-from Vendor No." := PORcptLine."Pay-to Vendor No.";

                                InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                                InterfaceEntryLineOut."Order No." := PORcptLine."Order No.";
                                InterfaceEntryLineOut."Item No." := FORMAT(PORcptLine."Order Line No.");
                                InterfaceEntryLineOut."No." := PORcptLine."No.";
                                InterfaceEntryLineOut.Description := ReplaceString(ReplaceString(PORcptLine.Description, '"', '{QUOTE}'), '{QUOTE}', '\"');
                                InterfaceEntryLineOut."Global No." := FORMAT(PORcptLine."Direct Unit Cost", 0, '<Precision,4:4><Standard Format,9>');
                                //order amount
                                InterfaceEntryLineOut."Cross Reference No." := '0';
                                if recGPurchLine.Amount <> 0 then
                                    InterfaceEntryLineOut."Cross Reference No." := FORMAT(recGPurchLine.Amount, 0, 9);

                                //order qty
                                InterfaceEntryLineOut."Blanket Order No." := '0';
                                if recGPurchLine.Quantity <> 0 then
                                    InterfaceEntryLineOut."Blanket Order No." := FORMAT(recGPurchLine.Quantity, 0, 9);

                                //invoice amount
                                if recGPurchLine.Quantity <> 0 then
                                    InterfaceEntryLineOut."CMG Code" := FORMAT(PORcptLine."Quantity Invoiced" * recGPurchLine.Amount / recGPurchLine.Quantity, 0, 9);


                                //invoiced quantity
                                InterfaceEntryLineOut."Ship-to Name" := FORMAT(PORcptLine."Quantity Invoiced", 0, 9);

                                //delivered amount
                                if recGPurchLine.Quantity <> 0 then
                                    InterfaceEntryLineOut."Ship-to Address" := FORMAT(PORcptLine.Quantity * recGPurchLine.Amount / recGPurchLine.Quantity, 0, 9);

                                //delivered quantity
                                InterfaceEntryLineOut."Ship-to Address 2" := FORMAT(PORcptLine.Quantity, 0, 9);

                                //tax code
                                InterfaceEntryLineOut.Contact := recGPurchLine."VAT Identifier";
                                if recGPurchLine."VAT Bus. Posting Group" <> '' then
                                    InterfaceEntryLineOut.Contact := InterfaceEntryLineOut.Contact + ' (' + recGPurchLine."VAT Bus. Posting Group" + ')';

                                //good receipt
                                InterfaceEntryLineOut."Phone No." := PORcptLine."Document No.";

                                if recPurchRcptHeader.GET(PORcptLine."Document No.") then
                                    //  InterfaceEntryLineOut."External Requisition No." := FORMAT(recPurchRcptHeader."Document Date", 0, 9); //BC Upgrade GUNREM01 -DIT Field

                                    //Type
                                    InterfaceEntryLineOut."Ship-to City" := RcptLineType;
                                //quantity to assign
                                InterfaceEntryLineOut."Ship-to Post Code" := RcptLineQtyAssign;
                                InterfaceEntryLineOut."E-Mail 2" := RcptLineQtyAssigned;
                                InterfaceEntryLineOut."Unit of Measure Code" := PORcptLine."Unit of Measure Code";
                                //dimensions

                                //BRAND dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionSetEntry."Dimension Value Code";
                                end;

                                //Cost center dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Cost Center Code" := DimensionSetEntry."Dimension Value Code";
                                end;

                                //Business Type dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Business Type Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Shortcut Dimension 2 Code" := DimensionSetEntry."Dimension Value Code";
                                end;


                                //Movement Type dimension
                                DimensionSetEntry.RESET;
                                DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                                DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Movement Type Dimension Code");
                                if DimensionSetEntry.FINDFIRST then begin
                                    InterfaceEntryLineOut."Movement Type" := DimensionSetEntry."Dimension Value Code";
                                end;

                                InterfaceEntryLineOut.INSERT;
                            end;
                        until PORcptLine.NEXT = 0;
                    end

                    //<<purchase receipt line
                end;

            until InterfaceEntryLine.NEXT = 0;

        //for empty record
        if EntryNo = 0 then begin
            CLEAR(InterfaceEntryLineOut);
            EntryNo += 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := EntryNo;
            InterfaceEntryLineOut."Buy-from Vendor No." := '';

            InterfaceEntryLineOut."Description 2" := '';
            InterfaceEntryLineOut."Order No." := '';
            InterfaceEntryLineOut."Item No." := '';
            InterfaceEntryLineOut."No." := '';
            InterfaceEntryLineOut.Description := '';
            InterfaceEntryLineOut."Global No." := '';
            InterfaceEntryLineOut."Cross Reference No." := '';
            InterfaceEntryLineOut."Blanket Order No." := '';
            InterfaceEntryLineOut."CMG Code" := '';
            InterfaceEntryLineOut."Ship-to Name" := '';
            InterfaceEntryLineOut."Ship-to Address" := '';

            InterfaceEntryLineOut."Ship-to Address 2" := '';
            InterfaceEntryLineOut.Contact := '';
            InterfaceEntryLineOut.Contact := '';
            InterfaceEntryLineOut."Phone No." := '';
            InterfaceEntryLineOut."External Requisition No." := '';
            InterfaceEntryLineOut."Ship-to City" := '';
            InterfaceEntryLineOut."Ship-to Post Code" := '';
            InterfaceEntryLineOut."E-Mail 2" := '';
            InterfaceEntryLineOut."Unit of Measure Code" := '';

            InterfaceEntryLineOut."Shortcut Dimension 1 Code" := '';
            InterfaceEntryLineOut."Cost Center Code" := '';

            InterfaceEntryLineOut."Shortcut Dimension 2 Code" := '';
            InterfaceEntryLineOut."Movement Type" := '';
            InterfaceEntryLineOut.INSERT;

        end;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessPaymStatusRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        Gasit: Boolean;
    begin
        //Paym Status NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;

        VendLedgerEntry.SETCURRENTKEY("Vendor No.", "Document No.");

        InterfaceSetup.GET(EskerInterfaceSetup."Esker PaymStatus Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        //
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker PaymStatus Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);
        //
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");


        if InterfaceEntryLine.FINDSET then begin
            repeat
                if (InterfaceEntryLine."Buy-from Vendor No." <> '') and (InterfaceEntryLine."Order No." <> '') then begin
                    if UPPERCASE(COMPANYNAME) = UPPERCASE(InterfaceEntryLine."Description 2") then begin
                        VendLedgerEntry.SETRANGE("Vendor No.", InterfaceEntryLine."Buy-from Vendor No.");
                        VendLedgerEntry.SETRANGE("Document No.", InterfaceEntryLine."Order No.");
                        if VendLedgerEntry.FINDSET(false) then begin
                            VendLedgerEntry.CALCFIELDS("Original Amount", "Remaining Amount");
                            if VendLedgerEntry."Remaining Amount" <> VendLedgerEntry."Original Amount" then begin
                                InvAmtRefNo := CalcRemAmtInvRefNo(VendLedgerEntry."External Document No.", VendLedgerEntry."Vendor No.");
                                SearchAppliedEntries(VendLedgerEntry, AppliedVendLedgerEntry);
                                if AppliedVendLedgerEntry.FINDSET(false) then
                                    repeat
                                        CLEAR(InterfaceEntryLineOut);
                                        EntryNo += 1;

                                        //>>create an interface entry header outbound only if there are records to be sent as response
                                        /*
                                         IF EntryNo = 1 THEN BEGIN
                                           CLEAR(InterfaceEntryHeaderOut);
                                           InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader,FALSE);
                                           InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
                                           InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker PaymStatus Resp Interf";
                                           InterfaceEntryHeaderOut.INSERT(TRUE);
                                         END;
                                         //<<create an interface entry header outbound only if there are records to be sent as response
                                         */
                                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                                        InterfaceEntryLineOut."Entry No." := EntryNo;
                                        //InterfaceEntryLineOut."Order No." := InterfaceEntryLine."Order No." ;
                                        //HEI.27>>
                                        //InterfaceEntryLineOut."Order No." := VendLedgerEntry."External Document No." ; //vendor invoice no instead of posted invoice ID //HEI.03
                                        InterfaceEntryLineOut."Order No." := VendLedgerEntry."Document No.";
                                        //HEI.27<<
                                        InterfaceEntryLineOut."Buy-from Vendor No." := VendLedgerEntry."Vendor No.";
                                        InterfaceEntryLineOut."Blanket Order No." := FORMAT(AppliedVendLedgerEntry."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>');
                                        InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                                        InterfaceEntryLineOut."Phone No." := AppliedVendLedgerEntry."Payment Method Code";

                                        //HEI.14 comment line InterfaceEntryLineOut.Contact := AppliedVendLedgerEntry."Message to Recipient";
                                        //HEI.14>>
                                        InterfaceEntryLineOut.Contact := COPYSTR(AppliedVendLedgerEntry."Message to Recipient", 1, 50);
                                        //HEI.14<<
                                        InterfaceEntryLineOut.Description := DELCHR(FORMAT(ABS(InvAmtRefNo)), '=', ',');
                                        ;
                                        InterfaceEntryLineOut.INSERT;
                                    until AppliedVendLedgerEntry.NEXT = 0;
                            end;
                        end;
                    end;
                end;
            until InterfaceEntryLine.NEXT = 0;
            //if no records then send an empty file

            if EntryNo = 0 then begin
                CLEAR(InterfaceEntryLineOut);
                EntryNo += 1;
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                InterfaceEntryLineOut."Entry No." := EntryNo;
                //InterfaceEntryLineOut."Order No." := '' ; //vendor invoice no instead of posted invoice ID
                InterfaceEntryLineOut."Message ID" := ''; //vendor invoice no instead of posted invoice ID //HEI.03
                InterfaceEntryLineOut."Buy-from Vendor No." := '';
                InterfaceEntryLineOut."Blanket Order No." := '';
                InterfaceEntryLineOut."Description 2" := '';
                InterfaceEntryLineOut."Phone No." := '';
                InterfaceEntryLineOut.Contact := '';
                InterfaceEntryLineOut.Description := '';
                InterfaceEntryLineOut.INSERT;
            end;
            //no records
        end;

        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);

    end;

    procedure CalcRemAmtInvRefNo(P_ExtRefNo: Code[35]; P_VendNo: Code[20]) RV_RemAmtInvRefNo: Decimal;
    var
        LREC_VLE: Record "Vendor Ledger Entry";
        L_InvRefNoAmt: Decimal;
    begin

        LREC_VLE.SETCURRENTKEY("External Document No.");
        LREC_VLE.SETRANGE("External Document No.", P_ExtRefNo);
        LREC_VLE.SETRANGE(LREC_VLE."Document Type", LREC_VLE."Document Type"::Invoice);
        LREC_VLE.SETRANGE("Vendor No.", P_VendNo);
        if LREC_VLE.FINDSET then
            repeat
                LREC_VLE.CALCFIELDS(LREC_VLE."Remaining Amount");
                L_InvRefNoAmt += LREC_VLE."Remaining Amount";
            until LREC_VLE.NEXT = 0;

        exit(L_InvRefNoAmt);
    end;

    local procedure SearchAppliedEntries(CreateVendLedgEntry: Record "Vendor Ledger Entry"; var TheVendLedgerEntry: Record "Vendor Ledger Entry");
    begin
        TheVendLedgerEntry.RESET;

        FindApplnEntriesDtldtLedgEntry(TheVendLedgerEntry, CreateVendLedgEntry);
        TheVendLedgerEntry.SETCURRENTKEY("Entry No.");
        TheVendLedgerEntry.SETRANGE("Entry No.");

        if CreateVendLedgEntry."Closed by Entry No." <> 0 then begin
            TheVendLedgerEntry."Entry No." := CreateVendLedgEntry."Closed by Entry No.";
            TheVendLedgerEntry.MARK(true);
        end;

        TheVendLedgerEntry.SETCURRENTKEY("Closed by Entry No.");
        TheVendLedgerEntry.SETRANGE("Closed by Entry No.", CreateVendLedgEntry."Entry No.");
        if TheVendLedgerEntry.FIND('-') then
            repeat
                TheVendLedgerEntry.MARK(true);
            until TheVendLedgerEntry.NEXT = 0;

        TheVendLedgerEntry.SETCURRENTKEY("Entry No.");
        TheVendLedgerEntry.SETRANGE("Closed by Entry No.");

        TheVendLedgerEntry.MARKEDONLY(true);
    end;

    local procedure FindApplnEntriesDtldtLedgEntry(var TheVendLedgerEntry: Record "Vendor Ledger Entry"; CreateVendLedgEntry: Record "Vendor Ledger Entry");
    var
        DtldVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    begin
        DtldVendLedgEntry1.SETCURRENTKEY("Vendor Ledger Entry No.");
        DtldVendLedgEntry1.SETRANGE("Vendor Ledger Entry No.", CreateVendLedgEntry."Entry No.");
        DtldVendLedgEntry1.SETRANGE(Unapplied, false);
        if DtldVendLedgEntry1.FIND('-') then begin
            repeat
                if DtldVendLedgEntry1."Vendor Ledger Entry No." =
                 DtldVendLedgEntry1."Applied Vend. Ledger Entry No."
                then begin
                    DtldVendLedgEntry2.INIT;
                    DtldVendLedgEntry2.SETCURRENTKEY("Applied Vend. Ledger Entry No.", "Entry Type");
                    DtldVendLedgEntry2.SETRANGE(
                      "Applied Vend. Ledger Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    DtldVendLedgEntry2.SETRANGE("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
                    DtldVendLedgEntry2.SETRANGE(Unapplied, false);
                    if DtldVendLedgEntry2.FIND('-') then begin
                        repeat
                            if DtldVendLedgEntry2."Vendor Ledger Entry No." <>
                              DtldVendLedgEntry2."Applied Vend. Ledger Entry No."
                             then begin
                                TheVendLedgerEntry.SETCURRENTKEY("Entry No.");
                                TheVendLedgerEntry.SETRANGE("Entry No.", DtldVendLedgEntry2."Vendor Ledger Entry No.");
                                if TheVendLedgerEntry.FIND('-') then
                                    TheVendLedgerEntry.MARK(true);
                            end;
                        until DtldVendLedgEntry2.NEXT = 0;
                    end;
                end else begin
                    TheVendLedgerEntry.SETCURRENTKEY("Entry No.");
                    TheVendLedgerEntry.SETRANGE("Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    if TheVendLedgerEntry.FIND('-') then
                        TheVendLedgerEntry.MARK(true);
                end;
            until DtldVendLedgEntry1.NEXT = 0;
        end;
    end;

    procedure CreatePurchInvoice(var InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        //  Route: Record Route; //BC Upgrade GUNREM01 -DIT table
        InvAmount: Decimal;
        LineNo: Integer;
        OptGLineType: Option PO,"Non-PO";
        Qty: Decimal;
        DirectUnitCost: Decimal;
        DecLTaxRate: Decimal;
        DimAdded: Boolean;
        ApprovStatus: Option "Not requested",Pending,Approved;
        DimSetEntryTmp: Record "Dimension Set Entry" temporary;
        DefaultDim: Record "Default Dimension";
        DimMgt: Codeunit DimensionManagement;
        TxtL50000: TextConst ENU = 'XML file format error', FRA = 'le format du fichier XML est incorrecte';
        TxtL50001: TextConst ENU = 'File has no Elements.', FRA = 'Le fichier ne contient aucun ?l?ment.';
        TxtL50002: TextConst ENU = 'The invoice number RUID must not be empty.', FRA = 'Le num?ro de facture RUID ne doit pas ?tre vide.';
        TxtL50003: TextConst ENU = 'Unknown doucment type', FRA = 'Type de document inconnu';
        TxtL50004: TextConst ENU = 'The vendor No. must not be empty.', FRA = 'Le numero de fournisseur ne doit pas ?tre vide.';
        TxtL50005: TextConst ENU = 'The document amount is incorrect', FRA = 'Le montant du document est incorrecte';
        DecLInvoiceAmount: Decimal;
        DocumentType: Option Invoice,"Credit Memo";
        TxtL50006: Label 'Wrong company';
        TotDocWithVAT: Decimal;
        TotDocWithoutVAT: Decimal;
        VendorBankAcc: Record "Vendor Bank Account";
        LPurchLine: Record "Purchase Line";
        DiscAmt: Decimal;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        DimSetEntryHeader: Record "Dimension Set Entry";
        VATIdentifier: Code[10];
        VATIdentifierSep: Decimal;
        FALine: Integer;
        Line2: Integer;
        PurchSetup: Record "Purchases & Payables Setup";
        Currency: Record Currency;
        decInvRoundAmount: Decimal;
        VATBusPostGr: Code[10];
        VATBusPostGrSepOpen: Integer;
        VATBusPostGrSepClose: Integer;
        VATBusPostGrText: Text;
        PurchaseHeader_Rec: Record "Purchase Header";
        HeaderDimAdded: Boolean;
        PurchInvHeaderAdditional: Record "Purchase Header Additional FND";
        POHeaderAdditional: Record "Purchase Header Additional FND";
        GLSetup: Record "General Ledger Setup";
        TxtL50007: Label 'Wrong Bank Account';
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PurchaseLine: Record "Purchase Line";
        PurchasesUtils: Codeunit "Purchases-Utils";
        WorkflowNotFoundError: Label 'Purchase Invoice %1 have upper tolerance restriction and "tolerance approval" is mandatory in" Purchases & Payable setup" but workflow is not enabled for the same.';
        TxtL50008: Label 'Without any Receipt Line, additional manual lines are not allowed in PO Type invoice.';
        TxtL50009: Label 'Additional line cannot be inserted with Fixed Assets items.';
    begin
        //Purchase Invoice Creation
        GetEskerInterfaceSetup;


        if InterfaceEntryHeader."Sell-to Customer No." <> '' then
            EVALUATE(InvAmount, InterfaceEntryHeader."Sell-to Customer No.", 9);

        CLEAR(PurchHeader);
        if InvAmount >= 0 then
            PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Invoice)
        else
            PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::"Credit Memo");

        PurchHeader.SETRANGE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No.");
        PurchHeader.SETRANGE("Vendor Invoice No.", COPYSTR(InterfaceEntryHeader."External Document No.", 1, 35));
        if PurchHeader.FINDFIRST then
            ERROR(TxtG50006, InterfaceEntryHeader."External Document No.");

        //>>check some mandatory fields
        //RUID
        if InterfaceEntryHeader.RUID = '' then begin
            ErrorMsg := STRSUBSTNO(TxtG50004, TxtL50002);
            ERROR('%1', ErrorMsg);

        end;

        //company name
        if UPPERCASE(InterfaceEntryHeader."E-Mail") <> UPPERCASE(COMPANYNAME) then begin
            ErrorMsg := TxtL50006;
            ERROR('%1', ErrorMsg);
        end;

        //Find Vendor No.
        if InterfaceEntryHeader."Buy-from Vendor No." = '' then begin
            ErrorMsg := STRSUBSTNO(TxtG50004, TxtL50004);
            ERROR('%1', ErrorMsg);
        end;
        //Find Document Type: Invoice/Credit Memo.

        if EVALUATE(DecLInvoiceAmount, InterfaceEntryHeader."Sell-to Customer No.", 9) then begin
            if DecLInvoiceAmount > 0 then
                DocumentType := DocumentType::Invoice
            else
                DocumentType := DocumentType::"Credit Memo";
        end else begin
            ErrorMsg := STRSUBSTNO(TxtG50004, TxtL50005);
            ERROR('%1', ErrorMsg);
        end;

        //Find Payment Approval Status
        TxtLApprovalStatus := InterfaceEntryHeader.County;
        case DocumentType of
            DocumentType::Invoice:
                begin
                    CLEAR(RecLPurchInvHeader);
                    RecLPurchInvHeader.SETRANGE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No.");
                    RecLPurchInvHeader.SETRANGE("RUID FND", InterfaceEntryHeader.RUID);
                    if RecLPurchInvHeader.FINDFIRST then begin
                        DocumentNo := RecLPurchInvHeader."No.";
                        if UPPERCASE(TxtLApprovalStatus) <> UPPERCASE(FORMAT(ApprovalStatus::Pending)) then
                            PaymentBlock.FctSetPaymentOnHold(2, RecLPurchInvHeader."No.",
                                                 RecLPurchInvHeader."Buy-from Vendor No.",
                                                 RecLPurchInvHeader."Posting Date");

                        GetEskerInterfaceSetup;
                        EskerInterfaceSetup.TESTFIELD("Esker InvConfirm Interf");
                        CreateInterfaceConfirmationError(InterfaceEntryHeader, 'Posted Document RUID no.=' + InterfaceEntryHeader.RUID + ' already exist!', EskerInterfaceSetup."Esker InvConfirm Interf");
                        exit;
                    end;
                end;

            DocumentType::"Credit Memo":
                begin
                    CLEAR(RecLPurchCrMemoHdr);
                    RecLPurchCrMemoHdr.SETRANGE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No.");
                    RecLPurchCrMemoHdr.SETRANGE("RUID FND", InterfaceEntryHeader.RUID);
                    if RecLPurchCrMemoHdr.FINDFIRST then begin
                        DocumentNo := RecLPurchCrMemoHdr."No.";
                        if UPPERCASE(TxtLApprovalStatus) <> UPPERCASE(FORMAT(ApprovalStatus::Pending)) then
                            PaymentBlock.FctSetPaymentOnHold(3, RecLPurchCrMemoHdr."No.",
                                                 RecLPurchCrMemoHdr."Buy-from Vendor No.",
                                                 RecLPurchCrMemoHdr."Posting Date");
                        GetEskerInterfaceSetup;
                        EskerInterfaceSetup.TESTFIELD("Esker InvConfirm Interf");
                        CreateInterfaceConfirmationError(InterfaceEntryHeader, 'Posted Document RUID no.=' + InterfaceEntryHeader.RUID + ' already exist!', EskerInterfaceSetup."Esker InvConfirm Interf");

                        exit;
                    end;
                end;
        end;

        //check invoice type
        if not ((UPPERCASE(InterfaceEntryHeader."Phone No.") = UPPERCASE(FORMAT(InvoiceType::"Non-PO Invoice"))) or
           (UPPERCASE(InterfaceEntryHeader."Phone No.") = UPPERCASE(FORMAT(InvoiceType::"PO Invoice")))) then begin
            ErrorMsg := STRSUBSTNO(TxtG50004, TxtL50003);
            ERROR('%1', ErrorMsg);
        end;
        //<<check some mandatory fields

        //>>CREATE PURCHASE INVOICE
        CLEAR(PurchHeader);
        PurchHeader.INIT;

        if InvAmount >= 0 then
            PurchHeader."Document Type" := PurchHeader."Document Type"::Invoice
        else
            PurchHeader."Document Type" := PurchHeader."Document Type"::"Credit Memo";

        PurchHeader."No. Printed" := 0;
        PurchHeader.Status := PurchHeader.Status::Open;
        PurchHeader."No." := '';

        if InterfaceEntryHeader."External Document No." <> '' then begin
            if InvAmount >= 0 then
                PurchHeader."Vendor Invoice No." := COPYSTR(InterfaceEntryHeader."External Document No.", 1, 35)
            else
                PurchHeader."Vendor Cr. Memo No." := COPYSTR(InterfaceEntryHeader."External Document No.", 1, 35);

            //PurchHeader.VALIDATE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No."); //HEI.08
            FctCheckExternalDocNumer(PurchHeader."Document Type".AsInteger(), COPYSTR(InterfaceEntryHeader."External Document No.", 1, 35),
                                       PurchHeader."Pay-to Vendor No."); //2: Invoice, 3: Credit Memo
        end;

        PurchHeader.LOCKTABLE;
        PurchHeader.INSERT(true);

        PurchHeader.VALIDATE("Buy-from Vendor No.", InterfaceEntryHeader."Buy-from Vendor No.");

        if InterfaceEntryHeader."Currency Code" <> PurchHeader."Currency Code" then begin
            if InterfaceEntryHeader."Currency Code" <> InterfaceEntryHeader."House Number" then
                PurchHeader."Currency Code" := InterfaceEntryHeader."Currency Code"
            else
                PurchHeader."Currency Code" := '';

            PurchHeader.VALIDATE("Currency Code");
        end;

        if InterfaceEntryHeader.Name <> '' then
            EVALUATE(PurchHeader."Posting Date", InterfaceEntryHeader.Name, 9);

        if InterfaceEntryHeader.Address <> '' then
            EVALUATE(PurchHeader."Document Date", InterfaceEntryHeader.Address, 9);

        //HEI.20>>
        if PurchHeader."Document Date" <> 0D then
            PurchHeader.VALIDATE("Document Date");
        //HEI.20<<

        if InterfaceEntryHeader."Address 2" <> '' then
            EVALUATE(PurchHeader."Due Date", InterfaceEntryHeader."Address 2", 9);

        if UPPERCASE(InterfaceEntryHeader.County) = UPPERCASE(FORMAT(ApprovStatus::Pending)) then
            PurchHeader."On Hold" := 'BLK';

        if InterfaceEntryHeader."Payment Terms Code" <> '' then
            PurchHeader."Payment Terms Code" := COPYSTR(InterfaceEntryHeader."Payment Terms Code", 1, 10);

        if PurchHeader."Posting Date" = 0D then
            PurchHeader."Posting Date" := WORKDATE;

        PurchHeader."RUID FND" := InterfaceEntryHeader.RUID;
        PurchHeader.VALIDATE("Invoice Disc. Code", '');
        //BC Upgrade GUNREM01- Tax date Is DIT field <<
        // if InterfaceEntryHeader.Contact <> '' then
        //     EVALUATE(PurchHeader."Tax Date", InterfaceEntryHeader.Contact, 9); 
        //BC Upgrade GUNREM01- Tax date Is DIT field >> 
        //vendor bank is mandatory
        //HEI.19>>
        if (InterfaceEntryHeader."Fax No." <> '') then begin
            if not VendorBankAcc.GET(InterfaceEntryHeader."Buy-from Vendor No.", InterfaceEntryHeader."Fax No.") then begin
                ErrorMsg := STRSUBSTNO(TxtG50004, TxtL50007);
                ERROR('%1', ErrorMsg);
            end else
                PurchHeader."Vendor Bank Account FND" := InterfaceEntryHeader."Fax No.";
        end else begin
            //HEI.19<<
            VendorBankAcc.RESET;
            VendorBankAcc.SETRANGE("Vendor No.", PurchHeader."Buy-from Vendor No.");
            if VendorBankAcc.FINDFIRST then
                PurchHeader."Vendor Bank Account FND" := VendorBankAcc.Code;
            //HEI.19>>
        end;
        //HEI.19<<

        //set the Payment Ststus value to Payment Approved
        PurchHeader."Payment Status FND" := PurchHeader."Payment Status FND"::"Payment Approved";

        //set Document Subtype Code
        //NPO invoice
        if UPPERCASE(InterfaceEntryHeader."Phone No.") = UPPERCASE(FORMAT(InvoiceType::"Non-PO Invoice")) then begin
            PurchasesPayablesSetup.GET;
            PurchasesPayablesSetup.TESTFIELD(PurchasesPayablesSetup."NPO Subtype Code FND");
            PurchHeader."Document Subtype Code FND" := PurchasesPayablesSetup."NPO Subtype Code FND"; //BC Upgrade SHUKLP03
        end;
        //PO invoice
        if UPPERCASE(InterfaceEntryHeader."Phone No.") = UPPERCASE(FORMAT(InvoiceType::"PO Invoice")) then begin
            PurchasesPayablesSetup.GET;
            PurchasesPayablesSetup.TESTFIELD(PurchasesPayablesSetup."PO Subtype Code FND");
            PurchHeader."Document Subtype Code FND" := PurchasesPayablesSetup."PO Subtype Code FND"; //BC Upgrade SHUKLP03
        end;

        //HEI.14<<
        if InterfaceEntryHeader."Salespers./Purch. Code" <> '' then
            PurchHeader."Vendor Posting Group" := InterfaceEntryHeader."Salespers./Purch. Code";
        //HEI.14>>

        //HEI.17>>
        HeaderDimAdded := false;
        if PurchaseHeader_Rec.GET(PurchaseHeader_Rec."Document Type"::Order, InterfaceEntryHeader."Your Reference") then
            if PurchaseHeader_Rec."Dimension Set ID" <> 0 then begin
                DimSetEntryHeader.RESET;
                DimSetEntryHeader.SETRANGE("Dimension Set ID", PurchaseHeader_Rec."Dimension Set ID");
                if DimSetEntryHeader.FINDSET then begin
                    repeat
                        DimSetEntryTmp.VALIDATE("Dimension Code", DimSetEntryHeader."Dimension Code");
                        DimSetEntryTmp.VALIDATE("Dimension Value Code", DimSetEntryHeader."Dimension Value Code");
                        DimSetEntryTmp.INSERT(true);
                    until DimSetEntryHeader.NEXT = 0;
                    HeaderDimAdded := true;
                end;
            end;

        if HeaderDimAdded then begin
            PurchHeader."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
            PurchHeader.MODIFY;
        end;

        //insert License Code
        GLSetup.GET;
        if GLSetup."License Dimension Code FND" <> '' then begin
            if POHeaderAdditional.GET(POHeaderAdditional."Document Type"::Order, InterfaceEntryHeader."Your Reference") then
                if PurchInvHeaderAdditional.GET(DocumentType, PurchHeader."No.") then begin
                    PurchInvHeaderAdditional."License Code" := POHeaderAdditional."License Code";
                    PurchInvHeaderAdditional.MODIFY;
                end else begin
                    PurchInvHeaderAdditional.INIT;
                    PurchInvHeaderAdditional."Document Type" := DocumentType;
                    PurchInvHeaderAdditional."No." := PurchHeader."No.";
                    PurchInvHeaderAdditional."License Code" := POHeaderAdditional."License Code";
                    PurchInvHeaderAdditional.INSERT;
                end;
        end;
        //<<HEI.17

        PurchHeader.MODIFY;
        ImportLineYesNo := true;

        IsPurchHeadInserted := true;
        //INSERT LINES

        LineNo := 500;
        GeneralInterfaceSetup.GET;
        OpCoSetup.GET;

        GeneralInterfaceSetup.TESTFIELD("Cost Center Dimension Code");
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        OpCoSetup.TESTFIELD("Business Type Dimension Code");
        OpCoSetup.TESTFIELD("Movement Type Dimension Code");

        //HEI.22>>
        CLEAR(IsRNFound);
        CLEAR(IsManualLine);
        //HEI.22<<

        InterfaceEntryLine.RESET;
        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                //HEI.22>>
                //IF (InterfaceEntryHeader."Phone No."='PO Invoice') AND (PurchHeader."Document Type"=PurchHeader."Document Type"::Invoice) AND (InterfaceEntryLine."Global No."='PO') THEN BEGIN
                if (InterfaceEntryHeader."Phone No." = 'PO Invoice') and (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) and (InterfaceEntryLine."Global No." = 'PO') and (InterfaceEntryLine."External Requisition No." <> '') then begin
                    //HEI.22<<
                    //HEI.05 comment line FctExtraireLine(PurchHeader, InterfaceEntryHeader."Your Reference", InterfaceEntryHeader."Currency Code",InterfaceEntryLine."No.", InterfaceEntryLine."CMG Code", InterfaceEntryLine."Blanket Order No.",
                    //HEI.05 comment line InterfaceEntryLine."External Requisition No.", InterfaceEntryHeader."Global No.");
                    //HEI.05>>
                    FctExtraireLine(PurchHeader, InterfaceEntryLine."Order No.", InterfaceEntryHeader."Currency Code", InterfaceEntryLine."No.", InterfaceEntryLine."CMG Code", InterfaceEntryLine."Blanket Order No.",
                                 InterfaceEntryLine."External Requisition No.", InterfaceEntryHeader."Global No.", InterfaceEntryLine);
                    //HEI.05<<
                    //HEI.14>> for update Fixed asset Acquisition
                    PurchHeader.GET(PurchHeader."Document Type", PurchHeader."No.");
                    //HEI.14>> for update Fixed asset Acquisition

                    //HEI.22>>
                    IsRNFound := true;
                end else if (InterfaceEntryHeader."Phone No." = 'PO Invoice') and (InterfaceEntryLine."External Requisition No." = '') and (InterfaceEntryLine."Global No." = 'GL') then begin
                    PurchLine.RESET;
                    PurchLine.INIT;
                    PurchLine."Document Type" := PurchHeader."Document Type";
                    PurchLine."Document No." := PurchHeader."No.";
                    PurchLine."Line No." := GetLastPurchLineNo(PurchHeader);
                    PurchLine.VALIDATE(Type, PurchLine.Type::"G/L Account");
                    if InterfaceEntryLine."Account No." <> '' then
                        PurchLine.VALIDATE("No.", InterfaceEntryLine."Account No.");
                    PurchLine.VALIDATE(Quantity, 1);
                    if InterfaceEntryLine."Blanket Order No." <> '' then begin
                        EVALUATE(DirectUnitCost, InterfaceEntryLine."Blanket Order No.", 9);
                        // line amount is always positive on credit memo in Nav
                        if PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo" then
                            PurchLine.VALIDATE("Direct Unit Cost", ABS(DirectUnitCost))
                        else
                            PurchLine.VALIDATE("Direct Unit Cost", DirectUnitCost);
                    end;
                    //HEI.24>>
                    if InterfaceEntryLine."Buy-from Vendor No." <> '' then begin
                        EVALUATE(DecLTaxRate, InterfaceEntryLine."Buy-from Vendor No.", 9);

                        VATIdentifierSep := STRPOS(InterfaceEntryLine."Phone No.", '(');
                        if VATIdentifierSep <> 0 then
                            VATIdentifier := COPYSTR(InterfaceEntryLine."Phone No.", 1, VATIdentifierSep - 1)
                        else
                            VATIdentifier := InterfaceEntryLine."Phone No.";

                        //extract the VAT Bus posting group from the XML file
                        VATBusPostGr := PurchLine."VAT Bus. Posting Group";
                        VATBusPostGrSepOpen := STRPOS(InterfaceEntryLine."Phone No.", '(');
                        if VATBusPostGrSepOpen > 0 then begin
                            VATBusPostGrSepClose := STRPOS(InterfaceEntryLine."Phone No.", ')');
                            if VATBusPostGrSepClose > VATBusPostGrSepOpen + 1 then
                                VATBusPostGr := COPYSTR(InterfaceEntryLine."Phone No.", VATBusPostGrSepOpen + 1, VATBusPostGrSepClose - VATBusPostGrSepOpen - 1);
                        end;

                        FctGetVATRate(VATProdPostGrp, VATBusPostGr, DecLTaxRate, VATIdentifier);

                        if VATProdPostGrp <> '' then
                            PurchLine.VALIDATE("VAT Prod. Posting Group", VATProdPostGrp);
                    end;
                    //HEI.24<<
                    PurchLine.INSERT(true);

                    DimAdded := false;
                    DimSetEntryTmp.DELETEALL; //HEI.23
                                              //If the line has already dim then keep them
                    if PurchLine."Dimension Set ID" <> 0 then begin
                        DimSetEntryHeader.SETRANGE("Dimension Set ID", PurchLine."Dimension Set ID");
                        if DimSetEntryHeader.FINDSET(false) then begin
                            repeat
                                DimSetEntryTmp.VALIDATE("Dimension Code", DimSetEntryHeader."Dimension Code");
                                DimSetEntryTmp.VALIDATE("Dimension Value Code", DimSetEntryHeader."Dimension Value Code");
                                DimSetEntryTmp.INSERT(true);
                            until DimSetEntryHeader.NEXT = 0;
                            DimAdded := true;
                        end;
                    end;

                    if DimAdded then begin
                        PurchLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                        PurchLine.MODIFY;
                    end;

                    //cost center code
                    DimAdded := false;
                    if InterfaceEntryLine."Shortcut Dimension 1 Code" <> '' then begin
                        //HEI.25>>
                        DimSetEntryTmp.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                        if DimSetEntryTmp.FINDFIRST then begin
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
                            DimSetEntryTmp.MODIFY(true);
                        end else begin
                            DimSetEntryTmp.INIT;
                            //HEI.25<<
                            DimSetEntryTmp.VALIDATE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                            DimSetEntryTmp.VALIDATE("Dimension Value Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
                            DimSetEntryTmp.INSERT(true);
                        end; //HEI.25
                        DimAdded := true;
                    end;

                    if DimAdded then begin
                        PurchLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                        PurchLine."Shortcut Dimension 2 Code" := InterfaceEntryLine."Shortcut Dimension 1 Code";
                        PurchLine.MODIFY;
                    end;

                    IsManualLine := true

                    //HEI.22<<
                end else begin
                    PurchLine.RESET;
                    PurchLine.INIT;
                    PurchLine."Document Type" := PurchHeader."Document Type";
                    PurchLine."Document No." := PurchHeader."No.";
                    PurchLine."Line No." := LineNo;
                    if UPPERCASE(InterfaceEntryLine."Global No.") = UPPERCASE(FORMAT(OptGLineType::PO)) then begin
                        PurchLine.VALIDATE(Type, PurchLine.Type::Item);
                        if InterfaceEntryLine."No." <> '' then
                            PurchLine.VALIDATE("No.", InterfaceEntryLine."No.");
                        if InterfaceEntryLine."CMG Code" <> '' then
                            if EVALUATE(Qty, InterfaceEntryLine."CMG Code", 9) then begin
                                HandleQty(PurchLine, Qty);
                            end;
                    end else begin
                        PurchLine.VALIDATE(Type, PurchLine.Type::"G/L Account");
                        if InterfaceEntryLine."Account No." <> '' then
                            PurchLine.VALIDATE("No.", InterfaceEntryLine."Account No.");
                        PurchLine.VALIDATE(Quantity, 1);
                        if InterfaceEntryLine."Blanket Order No." <> '' then begin
                            EVALUATE(DirectUnitCost, InterfaceEntryLine."Blanket Order No.", 9);
                            // line amount is always positive on credit memo in Nav
                            if PurchHeader."Document Type" = PurchHeader."Document Type"::"Credit Memo" then
                                PurchLine.VALIDATE("Direct Unit Cost", ABS(DirectUnitCost))
                            else
                                PurchLine.VALIDATE("Direct Unit Cost", DirectUnitCost);
                        end;
                        PurchLine.Description := InterfaceEntryLine.Description;
                        PurchLine."Additional Description FND" := InterfaceEntryLine."E-Mail 2"; //HEI.18
                    end;

                    if PurchLine.Type = PurchLine.Type::Item then
                        PurchLine.VALIDATE("Allow Invoice Disc.", true);

                    //HEI.05>>
                    // comment : update the VAT prod posting groups
                    //HEI.05<<
                    if InterfaceEntryLine."Buy-from Vendor No." <> '' then begin
                        EVALUATE(DecLTaxRate, InterfaceEntryLine."Buy-from Vendor No.", 9);
                        //HEI.05>>
                        VATIdentifierSep := STRPOS(InterfaceEntryLine."Phone No.", '(');
                        if VATIdentifierSep <> 0 then
                            VATIdentifier := COPYSTR(InterfaceEntryLine."Phone No.", 1, VATIdentifierSep - 1)
                        else
                            VATIdentifier := InterfaceEntryLine."Phone No.";
                        //HEI.05<<
                        //HEI.14 <<
                        //extract the VAT Bus posting group from the XML file
                        VATBusPostGr := PurchLine."VAT Bus. Posting Group";
                        VATBusPostGrSepOpen := STRPOS(InterfaceEntryLine."Phone No.", '(');
                        if VATBusPostGrSepOpen > 0 then begin
                            VATBusPostGrSepClose := STRPOS(InterfaceEntryLine."Phone No.", ')');
                            if VATBusPostGrSepClose > VATBusPostGrSepOpen + 1 then
                                VATBusPostGr := COPYSTR(InterfaceEntryLine."Phone No.", VATBusPostGrSepOpen + 1, VATBusPostGrSepClose - VATBusPostGrSepOpen - 1);
                        end;
                        //HEI.14>>

                        //HEI.14 comment line IF PurchLine."VAT %" <> DecLTaxRate THEN BEGIN
                        //HEI.05 comment line FctGetVATRate(VATProdPostGrp, PurchLine."VAT Bus. Posting Group", DecLTaxRate);
                        //HEI.05>>
                        //  FctGetVATRate(VATProdPostGrp, PurchLine."VAT Bus. Posting Group", DecLTaxRate, VATIdentifier); //HEI.14 commented
                        FctGetVATRate(VATProdPostGrp, VATBusPostGr, DecLTaxRate, VATIdentifier); //HEI.14
                                                                                                 //HEI.05<<
                        if VATProdPostGrp <> '' then
                            PurchLine.VALIDATE("VAT Prod. Posting Group", VATProdPostGrp);

                        //HEI.14 comment line END;
                    end;

                    //cost center
                    //comment HEI.02 incident IF InterfaceEntryLine."Shortcut Dimension 1 Code" <> '' THEN
                    //comment HEI.02 incident  PurchLine.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLine."Shortcut Dimension 1 Code");

                    if PurchLine.Type = PurchLine.Type::Item then
                        PurchLine.VALIDATE("Allow Invoice Disc.", true);

                    //update the WHT posting groups
                    //>>HEI.04
                    FctInsertInvLineWHTProdPostGroup(PurchLine, InterfaceEntryLine."Description 2");
                    //<<HEI.04
                    PurchLine."WHT Absorb Base FND" := InterfaceEntryLine."Loyalty Amount"; //HEI.15

                    PurchLine.INSERT;

                    //make invoice totals
                    TotDocWithVAT := TotDocWithVAT + PurchLine."Amount Including VAT";
                    TotDocWithoutVAT := TotDocWithoutVAT + PurchLine.Amount;

                    DimAdded := false;
                    //>>HEI.02 if the line has already dim then keep them
                    if PurchLine."Dimension Set ID" <> 0 then begin
                        DimSetEntryHeader.SETRANGE("Dimension Set ID", PurchLine."Dimension Set ID");
                        if DimSetEntryHeader.FINDSET then begin
                            repeat
                                DimSetEntryTmp.VALIDATE("Dimension Code", DimSetEntryHeader."Dimension Code");
                                DimSetEntryTmp.VALIDATE("Dimension Value Code", DimSetEntryHeader."Dimension Value Code");
                                DimSetEntryTmp.INSERT(true);

                            until DimSetEntryHeader.NEXT = 0;
                            DimAdded := true;
                        end;
                    end;
                    if DimAdded then begin
                        PurchLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                        PurchLine.MODIFY;
                    end;
                    //<<HEI.02
                    if InterfaceEntryLine."No." <> '' then begin
                        DefaultDim.SETRANGE("Table ID", 27);
                        DefaultDim.SETRANGE("No.", InterfaceEntryLine."No.");
                        if DefaultDim.FINDSET then
                            repeat
                                if DefaultDim."Dimension Value Code" <> '' then begin
                                    DimSetEntryTmp.VALIDATE("Dimension Code", DefaultDim."Dimension Code");
                                    DimSetEntryTmp.VALIDATE("Dimension Value Code", DefaultDim."Dimension Value Code");
                                    DimSetEntryTmp.INSERT(true);
                                end;
                            until DefaultDim.NEXT = 0;
                    end;

                    //brand code
                    if InterfaceEntryLine."Shortcut Dimension 2 Code" <> '' then begin
                        DimSetEntryTmp.VALIDATE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                        DimSetEntryTmp.VALIDATE("Dimension Value Code", InterfaceEntryLine."Shortcut Dimension 2 Code");
                        DimSetEntryTmp.INSERT(true);
                        DimAdded := true;
                    end;


                    if DimAdded then begin
                        PurchLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                        //HEI.14>>
                        //update GD on line
                        PurchLine."Shortcut Dimension 1 Code" := InterfaceEntryLine."Shortcut Dimension 2 Code";
                        //HEI.14<<
                        PurchLine.MODIFY;
                    end;

                    //business type code
                    if InterfaceEntryLine."Cost Center Code" <> '' then begin
                        DimSetEntryTmp.VALIDATE("Dimension Code", OpCoSetup."Business Type Dimension Code");
                        DimSetEntryTmp.VALIDATE("Dimension Value Code", InterfaceEntryLine."Cost Center Code");
                        DimSetEntryTmp.INSERT(true);
                        DimAdded := true;
                    end;

                    if DimAdded then begin
                        PurchLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                        PurchLine.MODIFY;
                    end;

                    //>HEI.06 Adding LC code for coding & posting of NPO invoices
                    if InterfaceEntryLine."Cross Reference No." <> '' then begin
                        //HEI.07 DimSetEntryTmp.VALIDATE("Dimension Code", 'LC');
                        //>>HEI.07
                        if OpCoSetup.GET then;
                        if OpCoSetup."LC Dimension Code" <> '' then
                            DimSetEntryTmp.VALIDATE("Dimension Code", OpCoSetup."LC Dimension Code")
                        else
                            DimSetEntryTmp.VALIDATE("Dimension Code", 'LC');
                        //<<HEI.07

                        DimSetEntryTmp.VALIDATE("Dimension Value Code", InterfaceEntryLine."Cross Reference No.");
                        DimSetEntryTmp.INSERT(true);
                        DimAdded := true;
                    end;

                    if DimAdded then begin
                        PurchLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                        PurchLine.MODIFY;
                    end;
                    //<HEI.06

                    //cost center code
                    if InterfaceEntryLine."Shortcut Dimension 1 Code" <> '' then begin
                        DimSetEntryTmp.VALIDATE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                        DimSetEntryTmp.VALIDATE("Dimension Value Code", InterfaceEntryLine."Shortcut Dimension 1 Code");
                        DimSetEntryTmp.INSERT(true);
                        DimAdded := true;
                    end;

                    if DimAdded then begin
                        PurchLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                        //HEI.14>>
                        //update GD on line
                        PurchLine."Shortcut Dimension 2 Code" := InterfaceEntryLine."Shortcut Dimension 1 Code";
                        //HEI.14<<
                        PurchLine.MODIFY;
                    end;

                    //movement type code
                    if InterfaceEntryLine."Project Code" <> '' then begin
                        DimSetEntryTmp.VALIDATE("Dimension Code", OpCoSetup."Movement Type Dimension Code");
                        DimSetEntryTmp.VALIDATE("Dimension Value Code", InterfaceEntryLine."Project Code");
                        DimSetEntryTmp.INSERT(true);
                        DimAdded := true;
                    end;

                    if DimAdded then begin
                        PurchLine."Dimension Set ID" := DimMgt.GetDimensionSetID(DimSetEntryTmp);
                        PurchLine.MODIFY;
                    end;
                    DimSetEntryTmp.DELETEALL;

                    LineNo += 10000;
                end;

            until InterfaceEntryLine.NEXT = 0;

        //HEI.22>>
        if IsManualLine and (not IsRNFound) then
            ERROR(TxtL50008);

        if IsManualLine and IsFALineFound(PurchHeader) then
            ERROR(TxtL50009);
        //HEI.22<<

        //HEI.11>>
        //apply the invoice discount
        if InterfaceEntryHeader."Source No." <> '0' then begin
            EVALUATE(DiscAmt, InterfaceEntryHeader."Source No.");
            HeiCore.ApplyDiscountOnPurchDocument(PurchHeader, DiscAmt);
        end;
        //HEI.11<<

        TotDocWithVAT := 0;
        TotDocWithoutVAT := 0;
        LPurchLine.RESET;
        LPurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        LPurchLine.SETRANGE("Document No.", PurchHeader."No.");
        if LPurchLine.FINDSET then
            repeat
                TotDocWithVAT += LPurchLine."Amount Including VAT";
                TotDocWithoutVAT += LPurchLine.Amount;
            until LPurchLine.NEXT = 0;

        //HEI.14>>
        if PurchHeader."Currency Code" = '' then
            Currency.InitRoundingPrecision
        else begin
            Currency.GET(PurchHeader."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        end;

        Currency.TESTFIELD("Invoice Rounding Precision");
        decInvRoundAmount := -ROUND(TotDocWithVAT - ROUND(TotDocWithVAT, Currency."Invoice Rounding Precision", Currency.InvoiceRoundingDirection),
                Currency."Amount Rounding Precision");
        //BC UPGRADE ATHUKS01 >> 
        //PurchHeader."Doc. Amount Incl. VAT" := TotDocWithVAT + decInvRoundAmount;
        // PurchHeader."Doc. Amount VAT " := TotDocWithVAT - TotDocWithoutVAT;
        PurchHeader."Doc. Amount Incl. VAT IBM FND" := TotDocWithVAT + decInvRoundAmount;
        PurchHeader."Doc. Amount VAT IBM FND" := TotDocWithVAT - TotDocWithoutVAT;
        //BC UPGRADE ATHUKS01 << 
        //HEI.26>>
        if IsManualLine then
            PurchHeader."Payment Status FND" := PurchHeader."Payment Status FND"::"Pending Review";
        //HEI.26<<
        //HEI.14<<
        //update header document totals
        //HEI.14 comment line PurchHeader."Doc. Amount Incl. VAT" := TotDocWithVAT;
        //HEI.14 comment line PurchHeader."Doc. Amount VAT" := TotDocWithVAT - TotDocWithoutVAT;
        PurchHeader.MODIFY;

        //<<create Purchase invoice

        //>>before posting

        CLEAR(ReleasePurchDoc);
        if NewGPurchHeader.GET(PurchHeader."Document Type", PurchHeader."No.") then begin
            DocURL := InterfaceEntryHeader.DocumentURL;
            ImageURL := InterfaceEntryHeader.ImageURL;
            // PurchHeader.ADDLINK(ReplaceString(DocURL, '%', '%25'), TxtL50000);
            // PurchHeader.ADDLINK(ReplaceString(ImageURL, '%', '%25'), TxtL50001);
            PurchHeader.ADDLINK(DocURL);
            PurchHeader.ADDLINK(ImageURL);
            //   NewGPurchHeader.VALIDATE("Tax Date"); //BC Upgrade GUNREM01 -DIT Field
            NewGPurchHeader.MODIFY;

            if InterfaceEntryHeader."Sell-to Customer No." <> '' then
                EVALUATE(InvAmount, InterfaceEntryHeader."Sell-to Customer No.", 9);
            //HEI.11>>
            /*
            IF InterfaceEntryHeader."Source No." <> '0' THEN BEGIN
              EVALUATE(DiscAmt,InterfaceEntryHeader."Source No.");
              HeiCore.ApplyDiscountOnPurchDocument(PurchHeader,DiscAmt);
            END;
            */
            //HEI.11<<
            NewGPurchHeader.CALCFIELDS("Amount Including VAT");
            NewGPurchHeader.CALCFIELDS(NewGPurchHeader.Amount);
            LInvAmt := NewGPurchHeader."Amount Including VAT" - NewGPurchHeader.Amount;
            NewGPurchHeader.MODIFY;
            //HEI.04>>
            if PurchSetup.GET then;
            //HEI.04<<

            /*HEI.05 comment begin
            IF (ABS(ABS(InvAmount) - NewGPurchHeader."Amount Including VAT") > PurchSetup."ESKER Max. Tolerance Amount") AND
               (NewGPurchHeader."Amount Including VAT" <> 0) THEN
              ERROR(STRSUBSTNO('There is a variance between the calculated amount (%1) and the amount specified in the ERP (%2)', InvAmount, NewGPurchHeader."Amount Including VAT"));
            HEI.05 comment ends*/
            //HEI.21>>
            PurchasesPayablesSetup.GET();
            ToleranceExceed := false;
            if (PurchHeader."Document Type" = PurchHeader."Document Type"::Invoice) and PurchasesPayablesSetup."Check Tolerance Approval FND" then begin
                PurchaseLine.SETRANGE("Document Type", PurchHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchHeader."No.");
                PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
                if PurchaseLine.FINDSET(true) then
                    repeat
                        PurchasesUtils.CheckToleranceForEsker(PurchaseLine);
                    until PurchaseLine.NEXT = 0;
                //----------------------------------
                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document Type", PurchHeader."Document Type");
                PurchaseLine.SETRANGE("Document No.", PurchHeader."No.");
                PurchaseLine.SETFILTER(Type, '<>%1', PurchaseLine.Type::" ");
                PurchaseLine.SETRANGE("Tolerance Exceeded FND", true);
                if PurchaseLine.FINDSET(true) then begin
                    ToleranceExceed := true;
                    if (PurchHeader.Status = PurchHeader.Status::Open) and not ApprovalsMgmt.IsPurchaseApprovalsWorkflowEnabled(PurchHeader) then
                        ERROR(WorkflowNotFoundError, PurchHeader."No.");
                end;
            end;

            if not ToleranceExceed then
                ReleasePurchDoc.PerformManualRelease(NewGPurchHeader)
            else
                if ApprovalsMgmt.CheckPurchaseApprovalPossible(NewGPurchHeader) then
                    ApprovalsMgmt.OnSendPurchaseDocForApproval(NewGPurchHeader);
            //ReleasePurchDoc.PerformManualRelease(NewGPurchHeader);
            //HEI.21<<

        end;
        //<<before posting

        //>>post the invoice
        if ErrorMsg = '' then begin
            COMMIT;
            if not ToleranceExceed then  //HEI.21
                FctPostPurchInvoice();
            GetEskerInterfaceSetup;
            EskerInterfaceSetup.TESTFIELD("Esker InvConfirm Interf");
            //HEI.21>>
            //CreateInterfaceConfirmationError(InterfaceEntryHeader, TxtG50005, EskerInterfaceSetup."Esker InvConfirm Interf");
            if not ToleranceExceed then
                CreateInterfaceConfirmationError(InterfaceEntryHeader, TxtG50005, EskerInterfaceSetup."Esker InvConfirm Interf")
            else
                CreateInterfaceConfirmationError(InterfaceEntryHeader, TxtG50008, EskerInterfaceSetup."Esker InvConfirm Interf");
            //HEI.21<<
        end;
        //HEI.21>>
        //IF ErrorMsg <> '' THEN
        if (ErrorMsg <> '') and not ToleranceExceed then //HEI.21<<
            FctDeletePurchDocs(PurchHeader);
        //<<post the invoice

    end;

    local procedure FctCheckExternalDocNumer(GenJnlLineDocType: Integer; GenJnlLineExtDocNo: Code[35]; PaytoVendorNo: Code[20]);
    var
        Text016: TextConst ENU = 'Purchase %1 %2 already exists for this vendor.', FRA = 'Le document %1 achat %2 existe dÙjÙ pour ce fournisseur.';
        VendLedgEntry: Record "Vendor Ledger Entry";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        // Check External Document number
        PurchSetup.GET;
        if PurchSetup."Ext. Doc. No. Mandatory" or
           (GenJnlLineExtDocNo <> '')
        then begin
            VendLedgEntry.RESET;
            VendLedgEntry.SETCURRENTKEY("External Document No.");
            VendLedgEntry.SETRANGE("Document Type", GenJnlLineDocType);
            VendLedgEntry.SETRANGE("External Document No.", GenJnlLineExtDocNo);
            VendLedgEntry.SETRANGE("Vendor No.", PaytoVendorNo);
            VendLedgEntry.SETRANGE(Reversed, false);
            if VendLedgEntry.FINDFIRST then
                ERROR(
                  Text016,
                  VendLedgEntry."Document Type", GenJnlLineExtDocNo);
        end;
    end;

    local procedure FctGetVATRate(var NewVATProdPostGrp: Code[10]; VATBusPostingGroup: Code[10]; VATRate: Decimal; lVATIdentifier: Code[10]);
    var
        RecLVATPostingSetup: Record "VAT Posting Setup";
        TxtL50000: TextConst ENU = '%1 (%2) do not exist in %3 table', FRA = 'Le %1 (%2) ne peut Ùtre trouvÙ dans la table (%3)';
        TxtL50001: TextConst ENU = '%1 (%2), %3 (%4), %5 (%6) do not exist in %7 table  ', FRA = '%1 (%2), %3 (%4), %5 (%6) n''existe pas dans table %7   ';
    begin
        //HEI.05 new local parameter lVATIdentifier, Code 10
        RecLVATPostingSetup.RESET;
        RecLVATPostingSetup.SETRANGE("VAT Bus. Posting Group", VATBusPostingGroup);
        RecLVATPostingSetup.SETRANGE("VAT %", VATRate);
        //HEI.05>>
        RecLVATPostingSetup.SETRANGE("VAT Identifier", lVATIdentifier);
        //HEI.05<<

        if RecLVATPostingSetup.FINDFIRST then
            NewVATProdPostGrp := RecLVATPostingSetup."VAT Prod. Posting Group"
        else
            //HEI.14>>
            ERROR(TxtL50001, RecLVATPostingSetup.FIELDCAPTION("VAT Bus. Posting Group"), VATBusPostingGroup, RecLVATPostingSetup.FIELDCAPTION("VAT %"), VATRate,
              RecLVATPostingSetup.FIELDCAPTION("VAT Identifier"), lVATIdentifier, RecLVATPostingSetup.TABLECAPTION);
        //HEI.14<<

        //HEI.14 ERROR(TxtL50000, RecLVATPostingSetup.FIELDCAPTION("VAT %"), VATRate, RecLVATPostingSetup.TABLECAPTION);
    end;

    procedure HandleQty(var PurchLine: Record "Purchase Line"; Qty: Decimal);
    var
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        UOMMgt: Codeunit "Unit of Measure Management";
        LotNo: Code[20];
        Item: Record Item;
        PurchRcptLine: Record "Purch. Rcpt. Line";
        ItemEntryRelation: Record "Item Entry Relation";
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        ReservEntry: Record "Reservation Entry";
        LAmount: Decimal;
        ReservStatusProspect: Boolean;
        enumvalue: Enum "Reservation Status";
    begin
        if Qty = PurchLine.Quantity then begin
            PurchLine.VALIDATE(Quantity, Qty);
            exit;
        end;

        Item.GET(PurchLine."No.");
        if Item."Item Tracking Code" = '' then begin
            PurchLine.VALIDATE(Quantity, Qty);
            exit;
        end;

        ItemEntryRelation.SETCURRENTKEY("Source ID", "Source Type");
        ItemEntryRelation.SETRANGE("Source Type", 121);
        ItemEntryRelation.SETRANGE("Source ID", PurchLine."Receipt No.");
        ItemEntryRelation.SETRANGE("Source Ref. No.", PurchLine."Receipt Line No.");
        if ItemEntryRelation.FINDSET then
            repeat
                ItemLedgEntry.GET(ItemEntryRelation."Item Entry No.");
                TempItemLedgEntry.TRANSFERFIELDS(ItemLedgEntry);
                if TempItemLedgEntry.INSERT then;
            until ItemEntryRelation.NEXT = 0;

        CLEAR(ReservEntry);
        ReservEntry.SETRANGE("Item No.", PurchLine."No.");
        ReservEntry.SETRANGE("Location Code", PurchLine."Location Code");
        ReservEntry.SETRANGE("Reservation Status", ReservEntry."Reservation Status"::Prospect);
        ReservEntry.SETRANGE("Source Type", 39);
        ReservEntry.SETRANGE("Source Subtype", 2);
        ReservEntry.SETRANGE("Source ID", PurchLine."Document No.");
        ReservEntry.DELETEALL;

        //>>HEI.02
        ReservStatusProspect := false;
        if (PurchLine.Quantity > Qty) and (PurchLine.Type = PurchLine.Type::Item) then
            ReservStatusProspect := true;
        //<<HEI.02
        PurchLine.VALIDATE(Quantity, Qty);
        //> DS007 29/06/17
        LAmount := PurchLine.Amount;
        PurchLine.VALIDATE(Amount, LAmount);
        //< DS007 29/06/17

        /*>>HEI.02  comment
        CreateReservEntry.SetDates(
                0D,0D);
        
        CLEAR(ItemEntryRelation);
        ItemEntryRelation.FINDFIRST;
        
        CreateReservEntry.CreateReservEntryFor(
          DATABASE::"Purchase Line",
          PurchLine."Document Type",
          PurchLine."Document No.",
          '',
          0,
          PurchLine."Line No.",
          PurchLine."Qty. per Unit of Measure",
          PurchLine.Quantity,
          PurchLine.Quantity,
          '',
          ItemEntryRelation."Lot No.");
        
        CreateReservEntry.CreateEntry(
          PurchLine."No.",
          PurchLine."Variant Code",
          PurchLine."Location Code",
          PurchLine.Description,
          PurchLine."Expected Receipt Date",
          0D,
          0,
          2);
        <<HEI.02 close comment*/
        //>>HEI.02
        if ItemEntryRelation.FINDSET then
            repeat
                CreateReservEntry.SetDates(0D, 0D);
                CreateReservEntry.SetItemLedgEntryNo(ItemEntryRelation."Item Entry No.");

                /*HEI.05 begin comment
                CreateReservEntry.CreateReservEntryFor(DATABASE::"Purchase Line",PurchLine."Document Type",PurchLine."Document No.",'',0,PurchLine."Line No.",PurchLine."Qty. per Unit of Measure",PurchLine.Quantity,
                                                       PurchLine.Quantity, '',ItemEntryRelation."Lot No.");
                HEI.05 end comment*/
                //>>HEI.05
                //BC Upgrade GUNREM01 Changed the variable in function >>
                // CreateReservEntry.CreateReservEntryFor(DATABASE::"Purchase Line", PurchLine."Document Type", PurchLine."Document No.", '', 0, PurchLine."Line No.", PurchLine."Qty. per Unit of Measure", PurchLine.Quantity,
                //                                        PurchLine."Quantity (Base)", '', ItemEntryRelation."Lot No.");

                CreateReservEntry.CreateReservEntryFor(DATABASE::"Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", '', 0, PurchLine."Line No.", PurchLine."Qty. per Unit of Measure", PurchLine.Quantity,
                                                          PurchLine."Quantity (Base)", ReservEntry);
                //BC Upgrade GUNREM01 Changed the variable in function <<
                //<<HEI.05

                if ReservStatusProspect then
                    CreateReservEntry.CreateEntry(PurchLine."No.", PurchLine."Variant Code", PurchLine."Location Code", PurchLine.Description, PurchLine."Expected Receipt Date", 0D, 0, enumvalue::Prospect)
                else
                    CreateReservEntry.CreateEntry(PurchLine."No.", PurchLine."Variant Code", PurchLine."Location Code", PurchLine.Description, PurchLine."Expected Receipt Date", 0D, 0, enumvalue::Surplus);
            until ItemEntryRelation.NEXT = 0;
        //<<HEI.02

    end;

    procedure CreateInterfaceConfirmationError(InterfaceEntryHeaderIn: Record "Interface Entry Header INT"; ErrorMessage: Text; ResponseInterfaceCode: Code[20]);
    var
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineIn: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        PurchaseHeader: Record "Purchase Header";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemHeader: Record "Purch. Cr. Memo Hdr.";
    begin
        //create confirmation for invoice posting
        GetEskerInterfaceSetup;
        EskerInterfaceSetup.TESTFIELD("Esker InvConfirm Interf");
        InterfaceSetup.GET(ResponseInterfaceCode);
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeaderIn, false);
        InterfaceEntryHeaderOut."Interface Code" := ResponseInterfaceCode;
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := InterfaceEntryHeaderIn."Msg. Recv. Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := InterfaceEntryHeaderIn."Msg. Sender Business System ID";

        case ResponseInterfaceCode of
            EskerInterfaceSetup."Esker InvConfirm Interf":
                InterfaceEntryHeaderOut."Object Type" := 'INV';
        end;

        //ERPID - invoice ID for ERP
        if ErrorMessage = TxtG50005 then begin
            ErrorMessage := '';
            //successful posting
            PurchInvHeader.RESET;
            PurchInvHeader.SETRANGE("RUID FND", InterfaceEntryHeaderIn.RUID);
            if PurchInvHeader.FINDFIRST then
                InterfaceEntryHeaderOut."External Document No." := PurchInvHeader."No."
            else begin
                PurchCrMemHeader.RESET;
                PurchCrMemHeader.SETRANGE("RUID FND", InterfaceEntryHeaderIn.RUID);
                if PurchCrMemHeader.FINDFIRST then
                    InterfaceEntryHeaderOut."External Document No." := PurchCrMemHeader."No.";
            end;
        end else begin
            //unsuccessful posting
            //InterfaceEntryHeaderOut."External Document No." := InterfaceEntryHeaderIn."External Document No.";
            InterfaceEntryHeaderOut."External Document No." := '';
        end;


        //ESKER Invoice ID - RUID
        InterfaceEntryHeaderOut.RUID := InterfaceEntryHeaderIn.RUID;

        //error message
        InterfaceEntryHeaderOut."Log Message" := COPYSTR(ErrorMessage, 1, MAXSTRLEN(InterfaceEntryHeaderOut."Log Message"));

        InterfaceEntryHeaderOut.INSERT(true);
    end;

    local procedure FctPostPurchInvoice();
    var
        PurchPost: Codeunit "Purch.-Post";
    begin
        if PurchSetup."Calc. Inv. Discount" then
            FctCalculateInvoiceDiscount;

        CLEARLASTERROR;
        CUPostInvoice.PostInvoice(PurchHeader);
    end;

    procedure FctCalculateInvoiceDiscount();
    var
        PurchLine: Record "Purchase Line";
        PurchCalcDisc: Codeunit "Purch.-Calc.Discount";
    begin
        CLEAR(PurchCalcDisc);
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        if PurchLine.FINDFIRST then
            CLEARLASTERROR;
        if PurchCalcDisc.RUN(PurchLine) then begin
            PurchHeader.GET(PurchHeader."Document Type", PurchHeader."No.");
            COMMIT;
        end else
            ErrorMsg := STRSUBSTNO(TxtG50002, GETLASTERRORTEXT);
        ;
    end;

    local procedure FctDeletePurchDocs(PurchHeader2: Record "Purchase Header");
    var
        PurchHeaderToDel: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReturnShptHeader: Record "Return Shipment Header";
        PrepmtPurchInvHeader: Record "Purch. Inv. Header";
        PrepmtPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCommentLine: Record "Purch. Comment Line";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        WhseRequest: Record "Warehouse Request";
        PurchPost: Codeunit "Purch.-Post";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        AllLinesDeleted: Boolean;
    begin
        PurchHeaderToDel.GET(PurchHeader2."Document Type", PurchHeader2."No.");
        if PurchHeaderToDel."RUID FND" <> '' then begin
            PurchHeaderToDel."RUID FND" := '';
            PurchHeaderToDel.MODIFY;
        end;

        AllLinesDeleted := true;
        ItemChargeAssgntPurch.RESET;
        ItemChargeAssgntPurch.SETRANGE("Document Type", PurchHeaderToDel."Document Type");
        ItemChargeAssgntPurch.SETRANGE("Document No.", PurchHeaderToDel."No.");
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", PurchHeaderToDel."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeaderToDel."No.");
        PurchLine.LOCKTABLE;
        if PurchLine.FIND('-') then
            repeat
                PurchLine.CALCFIELDS("Qty. Assigned");
                if ((PurchLine."Qty. Assigned" = PurchLine."Quantity Invoiced") and
                    (PurchLine."Qty. Assigned" <> 0)) or
                   (PurchLine.Type <> PurchLine.Type::"Charge (Item)")
                then begin
                    if PurchLine.Type = PurchLine.Type::"Charge (Item)" then begin
                        ItemChargeAssgntPurch.SETRANGE("Document Line No.", PurchLine."Line No.");
                        ItemChargeAssgntPurch.DELETEALL;
                    end;
                    if PurchLine.HASLINKS then
                        PurchLine.DELETELINKS;

                    PurchLine.DELETE;
                end else
                    AllLinesDeleted := false;
                UpdateAssSalesOrder(PurchLine);
            until PurchLine.NEXT = 0;

        if AllLinesDeleted then begin
            //BC Upgrade GUNREM01 -DIT Function >>
            // PurchPost.DeleteHeader(
            //   PurchHeaderToDel, PurchRcptHeader, PurchInvHeader, PurchCrMemoHeader,
            //   ReturnShptHeader, PrepmtPurchInvHeader, PrepmtPurchCrMemoHeader);
            //BC Upgrade GUNREM01 -DIT Function <<
            ReservePurchLine.DeleteInvoiceSpecFromHeader(PurchHeaderToDel);

            PurchCommentLine.SETRANGE("Document Type", PurchHeaderToDel."Document Type");
            PurchCommentLine.SETRANGE("No.", PurchHeaderToDel."No.");
            PurchCommentLine.DELETEALL;

            WhseRequest.SETRANGE("Source Type", DATABASE::"Purchase Line");
            WhseRequest.SETRANGE("Source Subtype", PurchHeaderToDel."Document Type");
            WhseRequest.SETRANGE("Source No.", PurchHeaderToDel."No.");
            WhseRequest.DELETEALL(true);

            if PurchHeaderToDel.HASLINKS then
                PurchHeaderToDel.DELETELINKS;

            PurchHeaderToDel.DELETE;
        end;
        COMMIT;
    end;

    local procedure UpdateAssSalesOrder(PurchLine: Record "Purchase Line");
    var
        SalesLine: Record "Sales Line";
    begin
        if not PurchLine."Special Order" then
            exit;
        SalesLine.RESET;
        SalesLine.SETRANGE("Special Order Purchase No.", PurchLine."Document No.");
        SalesLine.SETRANGE("Special Order Purch. Line No.", PurchLine."Line No.");
        SalesLine.SETRANGE("Purchasing Code", PurchLine."Purchasing Code");
        if SalesLine.FINDFIRST then begin
            SalesLine."Special Order Purchase No." := '';
            SalesLine."Special Order Purch. Line No." := 0;
            SalesLine.MODIFY;
        end;
    end;

    local procedure FctExtraireLine(PurchHeader2: Record "Purchase Header"; OrderNumber: Text; InvoiceCurrency: Text; ItemNumber: Text; Quantity: Text; Amount: Text; GoodsReceipt: Text; GRIV: Text; LInterfaceEntryLine: Record "Interface Entry Line INT");
    var
        RecLPurchHeader: Record "Purchase Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        RecLPurchHeaderOrder: Record "Purchase Header";
        RecLPurchLineOrder: Record "Purchase Line";
        GetReceipts: Codeunit "Purch.-Get Receipt";
        InvAmtIncTax: Decimal;
        InvAmt: Decimal;
        TaxAmt: Decimal;
        GeneralLedgerSetup: Record "General Ledger Setup";
        RecLUpdateDescripPurchLine: Record "Purchase Line";
        DecLTaxRate: Decimal;
        LAmount: Decimal;
        VATIdentifierSep: Decimal;
        VATIdentifier: Code[10];
        VATBusPostGr: Code[10];
        VATBusPostGrSepOpen: Integer;
        VATBusPostGrSepClose: Integer;
        VATBusPostGrText: Text;
    begin

        if not ImportLineYesNo then
            exit;

        GeneralLedgerSetup.GET;
        RecLPurchHeader.GET(PurchHeader2."Document Type", PurchHeader2."No.");
        RecLPurchHeader.TESTFIELD("Document Type", RecLPurchHeader."Document Type"::Invoice);
        RecLPurchHeader.TESTFIELD(Status, RecLPurchHeader.Status::Open);

        RecLPurchHeaderOrder.GET(RecLPurchHeaderOrder."Document Type"::Order, OrderNumber);
        if InvoiceCurrency <> '' then
            if RecLPurchHeaderOrder."Currency Code" = '' then begin
                if InvoiceCurrency <> GeneralLedgerSetup."LCY Code" then
                    ERROR(Txt50004, OrderNumber);
            end else
                if (InvoiceCurrency <> RecLPurchHeaderOrder."Currency Code") then
                    ERROR(Txt50004, OrderNumber);

        if not RecLPurchLineOrder.GET(RecLPurchLineOrder."Document Type"::Order, OrderNumber, ItemNumber) then
            ERROR(Txt50003, OrderNumber, ItemNumber, Quantity, Amount);

        PurchRcptLine.SETCURRENTKEY("Pay-to Vendor No.");
        PurchRcptLine.SETRANGE("Pay-to Vendor No.", RecLPurchHeader."Pay-to Vendor No.");

        PurchRcptLine.SETRANGE("Order No.", OrderNumber);
        PurchRcptLine.SETRANGE("Order Line No.", RecLPurchLineOrder."Line No.");
        PurchRcptLine.SETRANGE("No.", RecLPurchLineOrder."No.");
        if GRIV <> '0' then
            PurchRcptLine.SETRANGE(PurchRcptLine."Document No.", GoodsReceipt)
        else
            PurchRcptLine.SETFILTER("Qty. Rcd. Not Invoiced", '<>0');


        if PurchRcptLine.FINDFIRST then;

        GetReceipts.SetPurchHeader(RecLPurchHeader);

        GetReceipts.CreateInvLines(PurchRcptLine);

        //HEI.14>> for update Fixed asset Acquisition
        PurchHeader2.GET(PurchHeader2."Document Type", PurchHeader2."No.");
        //HEI.14<< for update Fixed asset Acquisition

        FctUpdateQty(PurchHeader2, RecLPurchLineOrder."No.", Quantity, GRIV, OrderNumber, GoodsReceipt, ItemNumber);

        //HEI.04>>

        RecLUpdateDescripPurchLine.RESET;
        RecLUpdateDescripPurchLine.SETRANGE("Document Type", PurchHeader2."Document Type");
        RecLUpdateDescripPurchLine.SETRANGE("Document No.", PurchHeader2."No.");


        if RecLUpdateDescripPurchLine.FINDLAST then begin
            RecLUpdateDescripPurchLine.Description := LInterfaceEntryLine.Description;
            RecLUpdateDescripPurchLine.MODIFY;
        end;

        RecLUpdateDescripPurchLine."Additional Description FND" := LInterfaceEntryLine."E-Mail 2"; //HEI.18

        //HEI.05>>
        //update the VAT Posting groups
        if LInterfaceEntryLine."Buy-from Vendor No." <> '' then begin
            EVALUATE(DecLTaxRate, LInterfaceEntryLine."Buy-from Vendor No.", 9);
            //HEI.14 uncommented begin <<
            //HEI.10>>
            //extract the VAT Bus posting group from the XML file
            VATBusPostGr := RecLUpdateDescripPurchLine."VAT Bus. Posting Group";
            VATBusPostGrSepOpen := STRPOS(LInterfaceEntryLine."Phone No.", '(');
            if VATBusPostGrSepOpen > 0 then begin
                VATBusPostGrSepClose := STRPOS(LInterfaceEntryLine."Phone No.", ')');
                if VATBusPostGrSepClose > VATBusPostGrSepOpen + 1 then begin
                    VATBusPostGr := COPYSTR(LInterfaceEntryLine."Phone No.", VATBusPostGrSepOpen + 1, VATBusPostGrSepClose - VATBusPostGrSepOpen - 1);
                    //VATBusPostGr := DELCHR(VATBusPostGrText, '<>', ')');
                end;
            end;
            //HEI.10<<
            //HEI.14 uncommented end>>

            //HEI.14>>
            /*
            IF RecLUpdateDescripPurchLine."VAT %" <> DecLTaxRate THEN BEGIN
                VATIdentifierSep := STRPOS(LInterfaceEntryLine."Phone No.", '(');
                IF VATIdentifierSep <> 0 THEN
                  VATIdentifier := COPYSTR(LInterfaceEntryLine."Phone No.", 1, VATIdentifierSep  - 1)
                ELSE
                  VATIdentifier := LInterfaceEntryLine."Phone No.";
                IF RecLUpdateDescripPurchLine."VAT %" <> DecLTaxRate THEN BEGIN
                  FctGetVATRate(VATProdPostGrp, RecLUpdateDescripPurchLine."VAT Bus. Posting Group", DecLTaxRate, VATIdentifier);
                  IF VATProdPostGrp <> '' THEN
                    RecLUpdateDescripPurchLine.VALIDATE("VAT Prod. Posting Group", VATProdPostGrp);
                END;
            END;
            */

            VATIdentifierSep := STRPOS(LInterfaceEntryLine."Phone No.", '(');
            if VATIdentifierSep <> 0 then
                VATIdentifier := COPYSTR(LInterfaceEntryLine."Phone No.", 1, VATIdentifierSep - 1)
            else
                VATIdentifier := LInterfaceEntryLine."Phone No.";

            FctGetVATRate(VATProdPostGrp, VATBusPostGr, DecLTaxRate, VATIdentifier);

            if VATProdPostGrp <> RecLUpdateDescripPurchLine."VAT Prod. Posting Group" then
                RecLUpdateDescripPurchLine.VALIDATE("VAT Prod. Posting Group", VATProdPostGrp);
            if VATBusPostGr <> RecLUpdateDescripPurchLine."VAT Bus. Posting Group" then
                RecLUpdateDescripPurchLine.VALIDATE("VAT Bus. Posting Group", VATBusPostGr);
            //HEI.14<<

        end;
        RecLUpdateDescripPurchLine.MODIFY;

        EVALUATE(LAmount, LInterfaceEntryLine."Blanket Order No.", 9);
        if (LAmount <> RecLUpdateDescripPurchLine."Line Amount") then
            RecLUpdateDescripPurchLine.VALIDATE("Line Amount", LAmount);
        RecLUpdateDescripPurchLine.MODIFY;
        //HEI.05<<

        //update the WHT posting group
        FctInsertInvLineWHTProdPostGroup(RecLUpdateDescripPurchLine, LInterfaceEntryLine."Description 2");

        RecLUpdateDescripPurchLine."WHT Absorb Base FND" := LInterfaceEntryLine."Loyalty Amount"; //HEI.15

        RecLUpdateDescripPurchLine.MODIFY;


        //HEI.04<<


        CLEAR(InvAmtIncTax);
        CLEAR(InvAmt);
        RecLPurchLineOrder.RESET;
        RecLPurchLineOrder.SETRANGE("Document Type", PurchHeader2."Document Type");
        RecLPurchLineOrder.SETRANGE("Document No.", PurchHeader2."No.");
        if RecLPurchLineOrder.FINDSET then
            repeat
                InvAmtIncTax += RecLPurchLineOrder."Amount Including VAT";
                InvAmt += RecLPurchLineOrder.Amount;

                if RecLPurchLineOrder.Type = RecLPurchLineOrder.Type::Item then
                    RecLPurchLineOrder.VALIDATE("Allow Invoice Disc.", true);
                RecLPurchLineOrder.MODIFY(true);
            until RecLPurchLineOrder.NEXT = 0;

        RecLPurchHeaderOrder.GET(PurchHeader2."Document Type", PurchHeader2."No.");

    end;

    local procedure FctUpdateQty(PurchHeader2: Record "Purchase Header"; ItemNo: Code[20]; Quantity: Text; GRIV: Text; OrderNumber: Text; GoodsReceipt: Text; ItemNumber: Text);
    var
        RecLPurchLine: Record "Purchase Line";
        RecLPurchLine2: Record "Purchase Line";
        Qty: Decimal;
        Text000: TextConst ENU = 'Receipt No. %1:', FRA = 'NÙ rÙception %1 :';
        RecLPurchRcptLine: Record "Purch. Rcpt. Line";
        iItemNumber: Integer;
        ItemChargeAssign: Record "Item Charge Assignment (Purch)";
    begin
        if Quantity <> '' then
            if EVALUATE(Qty, Quantity, 9) then
                if Qty = 0 then
                    exit;

        // Get the invoice lines matching the item number
        RecLPurchLine.RESET;
        RecLPurchLine.SETRANGE("Document Type", PurchHeader2."Document Type");
        RecLPurchLine.SETRANGE("Document No.", PurchHeader2."No.");
        RecLPurchLine.SETRANGE("No.", ItemNo);
        if GRIV <> '0' then
            RecLPurchLine.SETRANGE("Receipt No.", GoodsReceipt);

        if RecLPurchLine.FINDSET then
            repeat
                // Check the Order Line No. of the receipt match the item number in the XML
                EVALUATE(iItemNumber, ItemNumber, 9);
                RecLPurchRcptLine.SETRANGE("Document No.", RecLPurchLine."Receipt No.");
                RecLPurchRcptLine.SETRANGE("Line No.", RecLPurchLine."Receipt Line No.");
                RecLPurchRcptLine.SETRANGE("Order No.", OrderNumber);
                RecLPurchRcptLine.SETRANGE("Order Line No.", iItemNumber);
                if RecLPurchRcptLine.FINDSET then begin
                    if RecLPurchLine.Quantity > Qty then begin
                        if RecLPurchLine.Type = RecLPurchLine.Type::Item then
                            HandleQty(RecLPurchLine, Qty)//DSO
                        else
                            RecLPurchLine.VALIDATE(Quantity, Qty);
                        //HEI.14>>  Item Charge change the Item assignement
                        if RecLPurchLine.Type = RecLPurchLine.Type::"Charge (Item)" then begin
                            ItemChargeAssign.RESET;
                            ItemChargeAssign.SETRANGE(ItemChargeAssign."Document Type", RecLPurchLine."Document Type");
                            ItemChargeAssign.SETRANGE("Document No.", RecLPurchLine."Document No.");
                            ItemChargeAssign.SETRANGE("Document Line No.", RecLPurchLine."Line No.");
                            ItemChargeAssign.SETRANGE("Item Charge No.", RecLPurchLine."No.");
                            if ItemChargeAssign.FINDSET then
                                repeat
                                    ItemChargeAssign.VALIDATE("Qty. to Assign", Qty);
                                    ItemChargeAssign.MODIFY;
                                until ItemChargeAssign.NEXT = 0;
                        end;
                        //HEI.14<<
                        RecLPurchLine.MODIFY;
                        Qty := 0;
                    end else
                        Qty := Qty - RecLPurchLine.Quantity;
                end;
            until RecLPurchLine.NEXT = 0;

        // Remove all lines without quantity and receipt no. description line

        RecLPurchLine.RESET;
        RecLPurchLine.SETRANGE("Document Type", PurchHeader2."Document Type");
        RecLPurchLine.SETRANGE("Document No.", PurchHeader2."No.");
        RecLPurchLine.SETRANGE(Quantity, 0);
        RecLPurchLine.SETFILTER("No.", '<>%1', '');
        RecLPurchLine.DELETEALL;
    end;

    local procedure ConvertFilterText(var LocFilterText: Text[50]);
    var
        PointPos: Integer;
    begin
        if STRPOS(LocFilterText, ',') > 0 then begin
            LocFilterText := CONVERTSTR(LocFilterText, ',', '.');
            PointPos := STRPOS(LocFilterText, '.');
            if PointPos <> 0 then
                LocFilterText := INSSTR(LocFilterText, '.', PointPos);
        end;
    end;

    procedure ProcessWHTRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        //BC ATHUKS01
        WHTPostingSetup: Record "WHT Posting Setup FND";
        WHTProdPostingGroup: Record "WHT Product Posting Group FND";
        WHTBusPostingGroup: Record "WHT Business Posting Group FND";
    //BC ATHUKS01
    begin
        //HEI.04
        //WHT NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;

        InterfaceSetup.GET(EskerInterfaceSetup."Esker WHT  Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker WHT  Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat


                if InterfaceEntryLine."Shortcut Dimension 1 Code" = '*' then begin //new
                    WHTPostingSetup.RESET;

                    if WHTPostingSetup.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."Phone No." := WHTPostingSetup."WHT Business Posting Group" + ' ' + WHTPostingSetup."WHT Product Posting Group";
                            if WHTBusPostingGroup.GET(WHTPostingSetup."WHT Business Posting Group") then;
                            if WHTProdPostingGroup.GET(WHTPostingSetup."WHT Product Posting Group") then;
                            InterfaceEntryLineOut."E-Mail" := WHTBusPostingGroup.Description + ' ' + WHTProdPostingGroup.Description;
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                            InterfaceEntryLineOut."Zone Code" := FORMAT(WHTPostingSetup."WHT %", 0, 9);
                            InterfaceEntryLineOut."Global No." := WHTPostingSetup."Payable WHT Account Code";
                            InterfaceEntryLineOut."External Document No." := WHTPostingSetup."Prepaid WHT Account Code";
                            InterfaceEntryLineOut.Description := '';
                            InterfaceEntryLineOut."Cross Reference No." := '';
                            InterfaceEntryLineOut.INSERT;
                        until WHTPostingSetup.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure ProcessLCRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
    begin
        //HEI.06
        //LC NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;
        //>>HEI.07
        if OpCoSetup.GET then;
        //>>HEI.07

        InterfaceSetup.GET(EskerInterfaceSetup."Esker LC  Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker LC  Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat


                if InterfaceEntryLine."Shortcut Dimension 1 Code" = '*' then begin //new
                    DimensionValue.RESET;
                    //HEI.07 DimensionValue.SETRANGE("Dimension Code", 'LC');
                    //>>HEI.07
                    if OpCoSetup."LC Dimension Code" <> '' then
                        DimensionValue.SETRANGE("Dimension Code", OpCoSetup."LC Dimension Code")
                    else
                        DimensionValue.SETRANGE("Dimension Code", 'LC');
                    //<<HEI.07

                    DimensionValue.SETRANGE(Blocked, false);
                    DimensionValue.SETRANGE("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
                    if DimensionValue.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut."No." := DimensionValue.Code;
                            InterfaceEntryLineOut.Description := DELCHR(DimensionValue.Name, '=', '"');
                            InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                            InterfaceEntryLineOut.INSERT;
                        until DimensionValue.NEXT = 0;
                end;

            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    local procedure FctInsertInvLineWHTProdPostGroup(var LPurchLine: Record "Purchase Line"; WHTCode: Text[50]);
    var
        WHTPostingSetup: Record "WHT Posting Setup FND"; //BC ATHUKS01
        PosBlank: Integer;
        WHTProdPostingGroup: Code[10];
        WHTBusPostingGroup: Code[10];
    begin
        //HEI.04>>
        if WHTCode <> '' then begin
            PosBlank := STRPOS(WHTCode, ' ');

            //HEI.14 comment line WHTBusPostingGroup := COPYSTR(WHTCode, 1, PosBlank - 1);
            //HEI.14 comment line WHTProdPostingGroup := COPYSTR(WHTCode, PosBlank + 1);

            //HEI.14>>
            if PosBlank > 0 then begin
                WHTBusPostingGroup := COPYSTR(WHTCode, 1, PosBlank - 1);
                WHTProdPostingGroup := COPYSTR(WHTCode, PosBlank + 1);
            end else begin
                WHTBusPostingGroup := WHTCode;
                WHTProdPostingGroup := '';
            end;
            //HEI.14<<
            WHTPostingSetup.SETFILTER("WHT Product Posting Group", '=%1', WHTProdPostingGroup);
            WHTPostingSetup.SETFILTER("WHT Business Posting Group", '=%1', WHTBusPostingGroup);

            if WHTPostingSetup.FINDFIRST then begin
                if (WHTPostingSetup."WHT Product Posting Group" <> '') or (WHTPostingSetup."WHT Business Posting Group" <> '') then begin
                    LPurchLine.VALIDATE(LPurchLine."WHT Product Posting Group FND", WHTPostingSetup."WHT Product Posting Group");
                    LPurchLine.VALIDATE(LPurchLine."WHT Business Posting Group FND", WHTPostingSetup."WHT Business Posting Group");
                end;
            end else
                ERROR(TextG50007, WHTPostingSetup."WHT Product Posting Group", WHTPostingSetup."WHT Business Posting Group");
        end;
        //HEI.04<<
    end;

    procedure ProcessVendorPstGrpRequest(InterfaceEntryHeader: Record "Interface Entry Header INT"; var InterfaceEntryHeaderOut: Record "Interface Entry Header INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceSetup: Record "Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        EntryNo: Integer;
        CompanyInformation: Record "Company Information";
        DefaultDimension: Record "Default Dimension";
        Vendor: Record Vendor;
        VendorPstGrpRec: Record "Vendor Posting Group";
    begin
        //HEI.13 >>
        //Vendor Lists NAV -> Esker
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        CompanyInformation.GET;


        InterfaceSetup.GET(EskerInterfaceSetup."Esker VendorPostGr Resp Interf");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker VendorPostGr Resp Interf";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                if InterfaceEntryLine."Vendor Posting Group" <> '*' then begin
                    VendorPstGrpRec.RESET;
                    VendorPstGrpRec.SETRANGE(Code, InterfaceEntryLine."Vendor Posting Group");
                    if VendorPstGrpRec.FINDFIRST then begin
                        CLEAR(InterfaceEntryLineOut);
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := InterfaceEntryLine."Entry No.";
                        InterfaceEntryLineOut.Description := COMPANYNAME;
                        InterfaceEntryLineOut."Vendor Posting Group" := VendorPstGrpRec.Code;
                        InterfaceEntryLineOut."Payables Account" := VendorPstGrpRec."Payables Account";
                        InterfaceEntryLineOut."Service Charge Acc." := VendorPstGrpRec."Service Charge Acc.";
                        InterfaceEntryLineOut."Payment Disc. Debit Acc." := VendorPstGrpRec."Payment Disc. Debit Acc.";
                        InterfaceEntryLineOut."Invoice Rounding Account" := VendorPstGrpRec."Invoice Rounding Account";
                        InterfaceEntryLineOut."Debit Curr. Appln. Rndg. Acc." := VendorPstGrpRec."Debit Curr. Appln. Rndg. Acc.";
                        InterfaceEntryLineOut."Credit Curr. Appln. Rndg. Acc." := VendorPstGrpRec."Credit Curr. Appln. Rndg. Acc.";
                        InterfaceEntryLineOut."Debit Rounding Account" := VendorPstGrpRec."Debit Rounding Account";
                        InterfaceEntryLineOut."Credit Rounding Account" := VendorPstGrpRec."Credit Rounding Account";
                        InterfaceEntryLineOut."Payment Disc. Credit Acc." := VendorPstGrpRec."Payment Disc. Credit Acc.";
                        InterfaceEntryLineOut."Payment Tolerance Debit Acc." := VendorPstGrpRec."Payment Tolerance Debit Acc.";
                        InterfaceEntryLineOut."Payment Tolerance Credit Acc." := VendorPstGrpRec."Payment Tolerance Credit Acc.";
                        InterfaceEntryLineOut."Prepayment Request Account" := VendorPstGrpRec."Prepayment Request Account FND";
                        InterfaceEntryLineOut.INSERT;
                    end
                end else begin
                    CLEAR(EntryNo);

                    VendorPstGrpRec.RESET;
                    //VendorPstGrpRec.SETRANGE(Code,InterfaceEntryLine."Vendor Posting Group");
                    if VendorPstGrpRec.FINDSET then begin
                        repeat
                            CLEAR(InterfaceEntryLineOut);
                            EntryNo += 1;
                            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            InterfaceEntryLineOut."Entry No." := EntryNo;
                            InterfaceEntryLineOut.Description := COMPANYNAME;
                            InterfaceEntryLineOut."Vendor Posting Group" := VendorPstGrpRec.Code;
                            InterfaceEntryLineOut."Payables Account" := VendorPstGrpRec."Payables Account";
                            InterfaceEntryLineOut."Service Charge Acc." := VendorPstGrpRec."Service Charge Acc.";
                            InterfaceEntryLineOut."Payment Disc. Debit Acc." := VendorPstGrpRec."Payment Disc. Debit Acc.";
                            InterfaceEntryLineOut."Invoice Rounding Account" := VendorPstGrpRec."Invoice Rounding Account";
                            InterfaceEntryLineOut."Debit Curr. Appln. Rndg. Acc." := VendorPstGrpRec."Debit Curr. Appln. Rndg. Acc.";
                            InterfaceEntryLineOut."Credit Curr. Appln. Rndg. Acc." := VendorPstGrpRec."Credit Curr. Appln. Rndg. Acc.";
                            InterfaceEntryLineOut."Debit Rounding Account" := VendorPstGrpRec."Debit Rounding Account";
                            InterfaceEntryLineOut."Credit Rounding Account" := VendorPstGrpRec."Credit Rounding Account";
                            InterfaceEntryLineOut."Payment Disc. Credit Acc." := VendorPstGrpRec."Payment Disc. Credit Acc.";
                            InterfaceEntryLineOut."Payment Tolerance Debit Acc." := VendorPstGrpRec."Payment Tolerance Debit Acc.";
                            InterfaceEntryLineOut."Payment Tolerance Credit Acc." := VendorPstGrpRec."Payment Tolerance Credit Acc.";
                            InterfaceEntryLineOut."Prepayment Request Account" := VendorPstGrpRec."Prepayment Request Account FND";

                            InterfaceEntryLineOut.INSERT;
                        until VendorPstGrpRec.NEXT = 0;

                    end;
                end;
            /*
            IF InterfaceEntryLine."Buy-from Vendor No." = '*' THEN BEGIN //new
              Vendor.RESET;
              Vendor.SETCURRENTKEY(Blocked);
              Vendor.SETFILTER(Blocked, '<>%1', Vendor.Blocked::All);
              IF Vendor.FINDSET THEN
                REPEAT
                  CLEAR(InterfaceEntryLineOut);
                  EntryNo +=1;
                  InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                  InterfaceEntryLineOut."Entry No." := EntryNo;
                  InterfaceEntryLineOut."Vendor Posting Group" := VendorPstGrpRec.Code;
                  InterfaceEntryLineOut."Payables Account" := VendorPstGrpRec."Payables Account";
                  InterfaceEntryLineOut."Service Charge Acc." := VendorPstGrpRec."Service Charge Acc.";
                  InterfaceEntryLineOut."Payment Disc. Debit Acc." := VendorPstGrpRec."Payment Disc. Debit Acc.";
                  InterfaceEntryLineOut."Invoice Rounding Account" := VendorPstGrpRec."Invoice Rounding Account";
                  InterfaceEntryLineOut."Debit Curr. Appln. Rndg. Acc." := VendorPstGrpRec."Debit Curr. Appln. Rndg. Acc.";
                  InterfaceEntryLineOut."Credit Curr. Appln. Rndg. Acc." := VendorPstGrpRec."Credit Curr. Appln. Rndg. Acc.";
                  InterfaceEntryLineOut."Debit Rounding Account" := VendorPstGrpRec."Debit Rounding Account";
                  InterfaceEntryLineOut."Credit Rounding Account" := VendorPstGrpRec."Credit Rounding Account";
                  InterfaceEntryLineOut."Payment Disc. Credit Acc." := VendorPstGrpRec."Payment Disc. Credit Acc.";
                  InterfaceEntryLineOut."Payment Tolerance Debit Acc." := VendorPstGrpRec."Payment Tolerance Debit Acc.";
                  InterfaceEntryLineOut."Payment Tolerance Credit Acc." := VendorPstGrpRec."Payment Tolerance Credit Acc.";
                  InterfaceEntryLineOut."Prepayment Request Account" := VendorPstGrpRec."Prepayment Request Account";InterfaceEntryLineOut.INSERT;
                UNTIL Vendor.NEXT = 0;
            END;
            */
            until InterfaceEntryLine.NEXT = 0;
        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
        //HEI.13 <<

    end;

    local procedure IsFALineFound(pPurchaseHeader: Record "Purchase Header"): Boolean;
    var
        lPurchaseLine: Record "Purchase Line";
    begin
        //HEI.22>>
        lPurchaseLine.RESET;
        lPurchaseLine.SETRANGE("Document Type", pPurchaseHeader."Document Type");
        lPurchaseLine.SETRANGE("Document No.", pPurchaseHeader."No.");
        lPurchaseLine.SETRANGE(Type, lPurchaseLine.Type::"Fixed Asset");
        if lPurchaseLine.FINDFIRST then
            exit(true)
        else
            exit(false);
        //HEI.22<<
    end;

    local procedure GetLastPurchLineNo(pPurchaseHeader: Record "Purchase Header"): Integer;
    var
        lPurchaseLine: Record "Purchase Line";
    begin
        //HEI.22>>
        lPurchaseLine.RESET;
        lPurchaseLine.SETRANGE("Document Type", pPurchaseHeader."Document Type");
        lPurchaseLine.SETRANGE("Document No.", pPurchaseHeader."No.");
        if not lPurchaseLine.FINDLAST then
            exit(10000)
        else
            exit(lPurchaseLine."Line No." + 10000);
        //HEI.22<<
    end;
}

