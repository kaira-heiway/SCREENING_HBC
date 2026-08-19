codeunit 58086 "Sage Interface Mgmt."
{
    //BC Upgrade GUNREM01 Old ID-50116
    // version HEI.01

    // HEI.01 FDD-HT664 IBM SURYAS01 18-02-2020
    //   #Created New Codeunit -"50116-Sage Interface Mgmt."
    // 
    // HEI.02 FDD-HT626 IBM SURYAS01 22-02-2020
    //   #Created New Function - "CreateVendSepapayment"
    //   #Created New Function - "CreateBankAccountDetails"

    //BC Upgrade GUNREM01
    //# Commented FR locatization code 
    //# replaced tempblob record to code unit and adde code using Instream and outstream functions. 

    trigger OnRun();

    begin
    end;

    var
        InterfaceSetup: Record "Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        SageInterfaceSetup: Record "SAGE Interface Setup INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        GeneralInterfaceSetupRead: Boolean;
        LegacyFMInterfaceSetupRead: Boolean;
        Text009: Label 'Invalid Product Code. Length should be less than 15 characters.';
        EndDateError: Label 'End Date must be after %1.';
        EndDateError2: Label 'End Date %1 must be after Start Date %2.';
        LineDiscountErr: Label 'Line Discount should have a value on Interface Entry Line No. %1 if Min Qty is %2.';
        FMDiscountError: Label 'FM Discount Charge already exist for Item No. %1.';
    // PaymentClass: Record "Payment Class"; //BC Upgrade GUNREM01 -FR Localization // BC FR Upgrade KAIRAR01

    procedure CreateCustomerMasterResponse(PaymentExportData: Record "Payment Export Data"; var TempBlob: Codeunit "Temp Blob");
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        CustomerAttributes: Record "Customer Attributes FND";
        DefaultDimension_Channel: Record "Default Dimension";
        CustomerSubType: Record "Customer Sub-Type FND";
        BusinessSegment: Record "Business Segment FND";
        EntryNo: Integer;
        TerritoryCode: Code[30];
        Marche: Code[20];
        BankAccount: Record "Bank Account";
        BankExportImportSetup: Record "Bank Export/Import Setup";
        Customer: Record Customer;
        CustomerBankAccount: Record "Customer Bank Account";
        DirectDebitCollection: Record "Direct Debit Collection";
        GLSetup: Record "General Ledger Setup";
        SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
        TempDirectDebitCollectionEntry: Record "Direct Debit Collection Entry" temporary;
        SEPADDFillExportBuffer: Codeunit "SEPA DD-Fill Export Buffer";
        PaymentGroupNo: Integer;
        OutboundInterface: Record "Outbound Interface INT";
        CompanyInformation: Record "Company Information";
        DirectDebitCollectionEntry: Record "Direct Debit Collection Entry";
        //BC Upgrade Upgrade GUNREM01 added var >>
        Instr: InStream;
        Outstr: OutStream;
    //BC Upgrade Upgrade GUNREM01 added var <<
    begin
        //HEI.01
        GetGeneralInterfaceSetup;
        if SageInterfaceSetup.GET then;
        SageInterfaceSetup.TESTFIELD("Cust Direct Debit Interface");
        GLSetup.GET;
        CompanyInformation.GET;
        InterfaceSetup.GET(SageInterfaceSetup."Cust Direct Debit Interface");
        if not InterfaceSetup.Enabled then
            exit;

        DirectDebitCollection.RESET;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);

        InterfaceEntryHeader2.FINDLAST;
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := SageInterfaceSetup."Cust Direct Debit Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";


        InterfaceEntryHeaderOut."Message ID" := PaymentExportData."Message ID";
        InterfaceEntryHeaderOut.Description := FORMAT(CURRENTDATETIME, 19, 9);
        InterfaceEntryHeaderOut."Shipment Method Location" := FORMAT(PaymentExportData.COUNT);
        InterfaceEntryHeaderOut."Message Name" := FORMAT(PaymentExportData.Amount, 0, '<Precision,2:2><Standard Format,9>');
        InterfaceEntryHeaderOut.Name := CompanyInformation.Name;
        InterfaceEntryHeaderOut.Address := CompanyInformation.Address;
        InterfaceEntryHeaderOut."Post Code" := CompanyInformation."Post Code";
        InterfaceEntryHeaderOut.City := CompanyInformation.City;
        InterfaceEntryHeaderOut."Country/Region Code" := CompanyInformation."Country/Region Code";
        InterfaceEntryHeaderOut.County := CompanyInformation."VAT Registration No.";

        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := PaymentExportData."Payment Information ID";
        InterfaceEntryHeaderOut."Fax No." := 'DD';
        InterfaceEntryHeaderOut.Blocked := false;
        InterfaceEntryHeaderOut."Source Type" := PaymentExportData."Line No.";
        InterfaceEntryHeaderOut.Amount += PaymentExportData.Amount;

        InterfaceEntryHeaderOut."House Number" := 'NORM';
        InterfaceEntryHeaderOut."Phone No." := 'SEPA';

        InterfaceEntryHeaderOut."Message Code" := PaymentExportData."SEPA Partner Type Text";

        InterfaceEntryHeaderOut."Message Type" := PaymentExportData."SEPA Direct Debit Seq. Text";
        InterfaceEntryHeaderOut."Posting Date" := PaymentExportData."Transfer Date";

        InterfaceEntryHeaderOut."Source No." := PaymentExportData."Sender Bank BIC";
        InterfaceEntryHeaderOut."External Contract Name" := PaymentExportData."Sender Bank Account No.";
        InterfaceEntryHeaderOut."Action Code" := 'SLEV';
        InterfaceEntryHeaderOut."Your Reference" := PaymentExportData."Creditor No.";
        InterfaceEntryHeaderOut."Object Type" := 'SEPA';
        //BC Upgrade GUNREM01 code added using instream and outstream >>
        // InterfaceEntryHeaderOut."XML File to Send" := TempBlob.Blob;
        TempBlob.CreateInStream(Instr);
        InterfaceEntryHeaderOut."XML File to Send".CreateOutStream(Outstr);
        CopyStream(Outstr, Instr);
        //BC Upgrade GUNREM01 code added using instream and outstream <<
        InterfaceEntryHeaderOut.INSERT(true);
        //HEI.01
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        //HEI.01
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET;
        GeneralInterfaceSetupRead := true;
        //HEI.01
    end;

    procedure CreateBankAccountDetails(BankAccledEntry: Record "Bank Account Ledger Entry"; var TempBlob: Codeunit "Temp Blob");
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryHeader2: Record "Interface Entry Header INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        CustomerAttributes: Record "Customer Attributes FND";
        DefaultDimension_Channel: Record "Default Dimension";
        CustomerSubType: Record "Customer Sub-Type FND";
        BusinessSegment: Record "Business Segment FND";
        EntryNo: Integer;
        TerritoryCode: Code[30];
        Marche: Code[20];
        BankAccount: Record "Bank Account";
        BankExportImportSetup: Record "Bank Export/Import Setup";
        Customer: Record Customer;
        CustomerBankAccount: Record "Customer Bank Account";
        DirectDebitCollection: Record "Direct Debit Collection";
        GLSetup: Record "General Ledger Setup";
        SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
        TempDirectDebitCollectionEntry: Record "Direct Debit Collection Entry" temporary;
        SEPADDFillExportBuffer: Codeunit "SEPA DD-Fill Export Buffer";
        PaymentGroupNo: Integer;
        OutboundInterface: Record "Outbound Interface INT";
        CompanyInformation: Record "Company Information";
        DirectDebitCollectionEntry: Record "Direct Debit Collection Entry";
        //  PaymentLine: Record "Payment Line";  //BC Upgrade GUNREM01 -FR Localization
        //BC Upgrade Upgrade GUNREM01 added var >>
        Instr: InStream;
        Outstr: OutStream;
    //BC Upgrade Upgrade GUNREM01 added var <<
    begin
        //<<HEI.02
        GetGeneralInterfaceSetup;
        SageInterfaceSetup.RESET;
        if SageInterfaceSetup.GET then;
        SageInterfaceSetup.TESTFIELD("Bank Account Balances");
        GLSetup.GET;
        CompanyInformation.GET;
        InterfaceSetup.GET(SageInterfaceSetup."Bank Account Balances");
        if not InterfaceSetup.Enabled then
            exit;


        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderOut);

        InterfaceEntryHeader2.FINDLAST;
        InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
        InterfaceEntryHeaderOut."Interface Code" := SageInterfaceSetup."Bank Account Balances";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";

        InterfaceEntryHeaderOut."Message ID" := BankAccledEntry."External Document No.";
        InterfaceEntryHeaderOut.Description := FORMAT(CURRENTDATETIME, 19, 9);
        //  PaymentLine.RESET;  //BC Upgrade GUNREM01 -FR Localization
        InterfaceEntryHeaderOut.Name := CompanyInformation.Name;
        InterfaceEntryHeaderOut.Address := CompanyInformation.Address;
        InterfaceEntryHeaderOut."Post Code" := CompanyInformation."Post Code";
        InterfaceEntryHeaderOut.City := CompanyInformation.City;
        InterfaceEntryHeaderOut."Country/Region Code" := CompanyInformation."Country/Region Code";
        InterfaceEntryHeaderOut.County := CompanyInformation."VAT Registration No.";
        //BC Upgrade GUNREM01 code added using instream and outstream >>
        // InterfaceEntryHeaderOut."XML File to Send" := TempBlob.Blob;
        TempBlob.CreateInStream(Instr);
        InterfaceEntryHeaderOut."XML File to Send".CreateOutStream(Outstr);
        CopyStream(Outstr, Instr);
        //BC Upgrade GUNREM01 code added using instream and outstream <<
        InterfaceEntryHeaderOut.INSERT(true);
        //>>HEI.02
    end;
    // // BC FR Upgrade KAIRAR01 -Moved Function CreateVendSepapayment to codeunit 57000 "Sage Interface Mgmt. FR" in FR Extension >>
    // //BC Upgrade GUNREM01 -Dependency on FR Localization >>
    // procedure CreateVendSepapayment("Payment Header": Record "Payment Header"; var TempBlob: Codeunit "Temp Blob");

    // var
    //     InterfaceEntryHeader: Record "Interface Entry Header INT";
    //     InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
    //     InterfaceEntryHeader2: Record "Interface Entry Header INT";
    //     InterfaceEntryLine: Record "Interface Entry Line INT";
    //     InterfaceEntryLineOut: Record "Interface Entry Line INT";
    //     CustomerAttributes: Record "Customer Attributes FND";
    //     DefaultDimension_Channel: Record "Default Dimension";
    //     CustomerSubType: Record "Customer Sub-Type FND";
    //     BusinessSegment: Record "Business Segment FND";
    //     EntryNo: Integer;
    //     TerritoryCode: Code[30];
    //     Marche: Code[20];
    //     BankAccount: Record "Bank Account";
    //     BankExportImportSetup: Record "Bank Export/Import Setup";
    //     Customer: Record Customer;
    //     CustomerBankAccount: Record "Customer Bank Account";
    //     DirectDebitCollection: Record "Direct Debit Collection";
    //     GLSetup: Record "General Ledger Setup";
    //     SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
    //     TempDirectDebitCollectionEntry: Record "Direct Debit Collection Entry" temporary;
    //     SEPADDFillExportBuffer: Codeunit "SEPA DD-Fill Export Buffer";
    //     PaymentGroupNo: Integer;
    //     OutboundInterface: Record "Outbound Interface INT";
    //     CompanyInformation: Record "Company Information";
    //     DirectDebitCollectionEntry: Record "Direct Debit Collection Entry";
    //     PaymentLine: Record "Payment Line";
    //     Var_Interfacecode: Code[20];
    //     Instr: InStream;
    //     Outstr: OutStream;
    // begin
    //     //<<HEI.02
    //     GetGeneralInterfaceSetup;
    //     GLSetup.GET();
    //     CompanyInformation.GET();
    //     SageInterfaceSetup.RESET();
    //     if SageInterfaceSetup.GET then;
    //     Var_Interfacecode := '';
    //     Paymentclass.RESET();
    //     Paymentclass.SETRANGE(Code, "Payment Header"."Payment Class");
    //     if Paymentclass.FINDSET() then begin
    //         if Paymentclass."Interface Setup" = Paymentclass."Interface Setup"::"Vendor SEPA" then begin
    //             SageInterfaceSetup.TESTFIELD("Vendor SEPA interface");
    //             InterfaceSetup.GET(SageInterfaceSetup."Vendor SEPA interface");
    //             Var_Interfacecode := SageInterfaceSetup."Vendor SEPA interface";
    //             if not InterfaceSetup.Enabled then
    //                 exit;
    //         end else
    //             if Paymentclass."Interface Setup" = Paymentclass."Interface Setup"::"Vendor Fixed-Asset" then begin
    //                 SageInterfaceSetup.TESTFIELD("Vendor Fixed Asset SEPA Interf");
    //                 InterfaceSetup.GET(SageInterfaceSetup."Vendor Fixed Asset SEPA Interf");
    //                 Var_Interfacecode := SageInterfaceSetup."Vendor Fixed Asset SEPA Interf";
    //                 if not InterfaceSetup.Enabled then
    //                     exit;
    //             end else
    //                 if Paymentclass."Interface Setup" = Paymentclass."Interface Setup"::"Vendor Fixed-Asset IC" then begin
    //                     SageInterfaceSetup.TESTFIELD("Vendor Fixed Asset SEPA IC");
    //                     InterfaceSetup.GET(SageInterfaceSetup."Vendor Fixed Asset SEPA IC");
    //                     Var_Interfacecode := SageInterfaceSetup."Vendor Fixed Asset SEPA IC";
    //                     if not InterfaceSetup.Enabled then
    //                         exit;
    //                 end else
    //                     if Paymentclass."Interface Setup" = Paymentclass."Interface Setup"::"Vendor Non-SEPA" then begin
    //                         SageInterfaceSetup.TESTFIELD("Vendor Non-SEPA interface");
    //                         InterfaceSetup.GET(SageInterfaceSetup."Vendor Non-SEPA interface");
    //                         Var_Interfacecode := SageInterfaceSetup."Vendor Non-SEPA interface";
    //                         if not InterfaceSetup.Enabled then
    //                             exit;
    //                     end else
    //                         if Paymentclass."Interface Setup" = Paymentclass."Interface Setup"::"Vendor SEPA Brid" then begin
    //                             SageInterfaceSetup.TESTFIELD("Vendor SEPA BRED Interface");
    //                             InterfaceSetup.GET(SageInterfaceSetup."Vendor SEPA BRED Interface");
    //                             Var_Interfacecode := SageInterfaceSetup."Vendor SEPA BRED Interface";
    //                             if not InterfaceSetup.Enabled then
    //                                 exit;
    //                         end
    //     end;

    //     InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
    //     CLEAR(InterfaceEntryHeaderOut);

    //     InterfaceEntryHeader2.FINDLAST();
    //     InterfaceEntryHeaderOut."Entry No." := InterfaceEntryHeader2."Entry No." + 1;
    //     InterfaceEntryHeaderOut."Interface Code" := Var_Interfacecode;
    //     InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
    //     InterfaceEntryHeaderOut."Inbound Interface Entry No." := InterfaceEntryHeader."Entry No.";


    //     InterfaceEntryHeaderOut."Message ID" := "Payment Header"."No.";
    //     InterfaceEntryHeaderOut.Description := FORMAT(CURRENTDATETIME, 19, 9);
    //     InterfaceEntryHeaderOut.Name := CompanyInformation.Name;
    //     InterfaceEntryHeaderOut.Address := CompanyInformation.Address;
    //     InterfaceEntryHeaderOut."Post Code" := CompanyInformation."Post Code";
    //     InterfaceEntryHeaderOut.City := CompanyInformation.City;
    //     InterfaceEntryHeaderOut."Country/Region Code" := CompanyInformation."Country/Region Code";
    //     InterfaceEntryHeaderOut.County := CompanyInformation."VAT Registration No.";
    //     // BC FR Upgrade KAIRAR01 >>
    //     // InterfaceEntryHeaderOut."XML File to Send" := TempBlob.Blob;
    //     TempBlob.CreateInStream(Instr);
    //     InterfaceEntryHeaderOut."XML File to Send".CreateOutStream(Outstr);
    //     CopyStream(Outstr, Instr);
    //     InterfaceEntryHeaderOut.INSERT(true);
    //     // BC FR Upgrade KAIRAR01 <<
    //     //>>HEI.02
    // end;

    // //BC Upgrade GUNREM01 -Dependency on FR Localization <<
    // // BC FR Upgrade KAIRAR01 -Moved Function CreateVendSepapayment to codeunit 57000 "Sage Interface Mgmt. FR" in FR Extension <<
}

