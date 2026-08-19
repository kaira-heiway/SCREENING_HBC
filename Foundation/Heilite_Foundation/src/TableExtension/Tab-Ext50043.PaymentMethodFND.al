tableextension 50043 PaymentMethodExtFND extends "Payment Method"
{
    // version NAVW110.0,DITW110.00.08,HEI.04
    // DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added fields
    //                                    2013960 Pos System
    //                                    2013961 Pos System Timestamp
    //                                    2013962 Refunds
    //                                    2013963 Payment Terminal Link Type
    //                                    2013964 Cash Drawer
    //                                    2013965 Editable
    //                                    2013966 Exclude on Total
    //                                    2013967 Button Background Color
    //                                    2013968 Button Position No.
    //                                    2013971 Payment Details
    //                                  Added keys
    //                                    "Pos System,Pos System Timestamp"
    //                                    "Pos System,Button Position No."
    //                                  Added functions SomSynchronize(),AssistEditColorHex()
    // DITW15.00.00.39 DDR 30/05/2011 issue 1328 Upgrade RTC function AssistEditColorHex()
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.03 DDR 26/03/2014 DIT-770 #563 Added fields 2014410 Cash Payment
    // DITW17.10.05 WSA 01/09/2014 DIT-770 #626 Added Field 2014411 Full Payment
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // #HEI.01 FDD-PTPGAP022 IBM PATHAA02 31.07.2017
    // #New field-'Cheque' added
    // HEI.02 FDD-PTPGAP007 IBM PATHAA02 25.08.2017
    // # new field-'Mandatory Bank details' added
    // HEI.03 FDD-PTPGAP072 IBM NASTAA02 31.01.2017 # Cashier Order Creation
    //   # New field created: 50002 - Cashier Order
    // HEI.04 CHG2181582 IBM SRIVAS07 16.03.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # New field created: 50003 - "Bank Connectivity Pmt. Method"
    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Bal. Account Type")
        {
            CaptionML = ENU = 'Bal. Account Type', FRA = 'Type compte contrepartie';
            //OptionCaptionML = ENU = 'G/L Account,Bank Account', FRA = 'Général,Banque';
        }
        modify("Bal. Account No.")
        {

            //Unsupported feature: Change TableRelation on ""Bal. Account No."(Field 4)". Please convert manually.

            CaptionML = ENU = 'Bal. Account No.', FRA = 'N° compte contrepartie';
        }
        modify("Direct Debit")
        {
            CaptionML = ENU = 'Direct Debit', FRA = 'Domiciliation européenne';
        }
        modify("Direct Debit Pmt. Terms Code")
        {
            CaptionML = ENU = 'Direct Debit Pmt. Terms Code', FRA = 'Code conditions paiem. domiciliation européenne';
        }
        modify("Pmt. Export Line Definition")
        {
            CaptionML = ENU = 'Pmt. Export Line Definition', FRA = 'Définition ligne exportation paiem.';
        }
        // modify("Bank Data Conversion Pmt. Type")
        // {
        //     CaptionML = ENU = 'Bank Data Conversion Pmt. Type', FRA = 'Type paiem. conversion données bancaires';
        // }  // BC Upgrade NANDIS03

        //Unsupported feature: CodeModification on ""Bal. Account No."(Field 4).OnValidate". Please convert manually.

        //trigger  Account No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bal. Account No." <> '' THEN
          TESTFIELD("Direct Debit",FALSE);
        IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
          CheckGLAcc("Bal. Account No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.39 DDR 09/05/2011 #1328
        if "Bal. Account No." = '' then
          TESTFIELD("Pos System","Pos System"::" ");
        // >>DITW15.00.00.39 DDR #1328
        if "Bal. Account No." <> '' then
          TESTFIELD("Direct Debit",false);
        if "Bal. Account Type" = "Bal. Account Type"::"G/L Account" then
          CheckGLAcc("Bal. Account No.");
        */
        //end;


        //Unsupported feature: CodeModification on ""Direct Debit"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT "Direct Debit" THEN
          "Direct Debit Pmt. Terms Code" := '';
        IF "Direct Debit" THEN
          TESTFIELD("Bal. Account No.",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not "Direct Debit" then
          "Direct Debit Pmt. Terms Code" := '';
        if "Direct Debit" then
          TESTFIELD("Bal. Account No.",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Direct Debit Pmt. Terms Code"(Field 7).OnValidate". Please convert manually.

        //trigger  Terms Code"(Field 7)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Direct Debit Pmt. Terms Code" <> '' THEN
          TESTFIELD("Direct Debit",TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Direct Debit Pmt. Terms Code" <> '' then
          TESTFIELD("Direct Debit",true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Pmt. Export Line Definition"(Field 8).OnLookup". Please convert manually.

        //trigger  Export Line Definition"(Field 8)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DataExchLineDef.SETFILTER(Code,'<>%1','');
        IF DataExchLineDef.findset THEN BEGIN
          REPEAT
            DataExchDef.GET(DataExchLineDef."Data Exch. Def Code");
            IF DataExchDef.Type = DataExchDef.Type::"Payment Export" THEN BEGIN
              TempDataExchLineDef.INIT;
              TempDataExchLineDef.Code := DataExchLineDef.Code;
              TempDataExchLineDef.Name := DataExchLineDef.Name;
              IF TempDataExchLineDef.INSERT THEN;
            end;
          UNTIL DataExchLineDef.NEXT = 0;
          IF PAGE.RUNMODAL(PAGE::"Pmt. Export Line Definitions",TempDataExchLineDef) = ACTION::LookupOK THEN
            "Pmt. Export Line Definition" := TempDataExchLineDef.Code;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DataExchLineDef.SETFILTER(Code,'<>%1','');
        if DataExchLineDef.findset then begin
          repeat
            DataExchDef.GET(DataExchLineDef."Data Exch. Def Code");
            if DataExchDef.Type = DataExchDef.Type::"Payment Export" then begin
        #6..8
              if TempDataExchLineDef.INSERT then;
            end;
          until DataExchLineDef.NEXT = 0;
          if PAGE.RUNMODAL(PAGE::"Pmt. Export Line Definitions",TempDataExchLineDef) = ACTION::LookupOK then
            "Pmt. Export Line Definition" := TempDataExchLineDef.Code;
        end;
        */
        //end;
        field(50000; "Cheque FND"; Boolean)
        {
            Description = 'HEI.01';
            Caption = 'Cheque';
        }
        field(50001; "Mandatory Bank details FND"; Boolean)
        {
            Description = 'HEI.02';
            Caption = 'Mandatory Bank details';
        }
        field(50002; "Cashier Order FND"; Boolean)
        {
            Caption = 'Cashier Order';
            Description = 'HEI.03';
        }
        field(50003; "Bank Cnctvty Pmt. Method FND"; Code[4])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Caption = 'Bank Connectivity Payment Method';
        }
        // field(2013960;"Pos System";Option)
        // {
        //     CaptionML = ENU='POS System',
        //                 FRA='Système POS';
        //     Description = 'DITW15.00.00.39 #1328';
        //     OptionCaptionML = ENU=' ,Yes,Blocked',
        //                       FRA=' ,Oui,Bloqué';
        //     OptionMembers = " ",Yes,No;

        //     trigger OnValidate();
        //     begin
        //         if "Pos System" = "Pos System"::" " then begin
        //           CLEAR("Pos System Timestamp");
        //           CLEAR(Refunds);
        //           CLEAR("Payment Terminal Link Type");
        //           CLEAR("Cash Drawer");
        //           CLEAR("Editable on Total");
        //           CLEAR("Exclude on Total");
        //           CLEAR("Button Background RGB (Hexa)");
        //           CLEAR("Button Position No.");
        //           CLEAR("Payment Details");
        //         end else
        //           TESTFIELD("Bal. Account No.");
        //     end;
        // }
        // field(2013961;"Pos System Timestamp";DateTime)
        // {
        //     CaptionML = ENU='POS System Timestamp',
        //                 FRA='Horodateur système POS';
        //     Description = 'DITW15.00.00.39 #1328';
        // }
        // field(2013962;Refunds;Boolean)
        // {
        //     CaptionML = ENU='Refunds',
        //                 FRA='Remboursements';
        //     Description = 'DITW15.00.00.39 #1328';

        //     trigger OnValidate();
        //     begin
        //         if Refunds then
        //           TESTFIELD("Pos System");
        //     end;
        // }
        // field(2013963;"Payment Terminal Link Type";Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Payment Terminal Link Type',
        //                 FRA='Type de lien au Terminal de paiement';
        //     Description = 'DITW15.00.00.39 #1328';

        //     trigger OnValidate();
        //     begin
        //         if "Payment Terminal Link Type" <> 0 then
        //           TESTFIELD("Pos System");
        //     end;
        // }
        // field(2013964;"Cash Drawer";Boolean)
        // {
        //     CaptionML = ENU='Cash Drawer',
        //                 FRA='Tiroir caisse';
        //     Description = 'DITW15.00.00.39 #1328';

        //     trigger OnValidate();
        //     begin
        //         if "Cash Drawer" then
        //           TESTFIELD("Pos System");
        //     end;
        // }
        // field(2013965;"Editable on Total";Boolean)
        // {
        //     CaptionML = ENU='Editable on Total',
        //                 FRA='Modifiable sur total';
        //     Description = 'DITW15.00.00.39 #1328';

        //     trigger OnValidate();
        //     begin
        //         if "Editable on Total" then
        //           TESTFIELD("Pos System");
        //         "Exclude on Total" := false;
        //     end;
        // }
        // field(2013966;"Exclude on Total";Boolean)
        // {
        //     CaptionML = ENU='Exclude on Total',
        //                 FRA='Exclure du total';
        //     Description = 'DITW15.00.00.39 #1328';

        //     trigger OnValidate();
        //     begin
        //         if "Exclude on Total" then
        //           TESTFIELD("Pos System");
        //         "Editable on Total" := false;
        //     end;
        // }
        // field(2013967;"Button Background RGB (Hexa)";Code[6])
        // {
        //     CaptionML = ENU='Button Background Color (RGB Hexa)',
        //                 FRA='Couleur de fond du bouton (RGB Hexa)';
        //     Description = 'DITW15.00.00.39 #1328';

        //     trigger OnValidate();
        //     begin
        //         if "Button Background RGB (Hexa)" <> '' then
        //           TESTFIELD("Pos System");
        //     end;
        // }
        // field(2013968;"Button Position No.";Integer)
        // {
        //     BlankZero = true;
        //     CaptionML = ENU='Button Position No.',
        //                 FRA='N° position du bouton';
        //     Description = 'DITW15.00.00.39 #1328';
        //     MinValue = 0;

        //     trigger OnValidate();
        //     var
        //         PayMethodTest : Record "Payment Method";
        //     begin
        //         if "Button Position No." <> 0 then
        //           TESTFIELD("Pos System");
        //         PayMethodTest.SETCURRENTKEY("Pos System","Button Position No.");
        //         PayMethodTest.SETFILTER("Pos System",'>%1',PayMethodTest."Pos System"::" ");
        //         PayMethodTest.SETRANGE("Button Position No.","Button Position No.");
        //         if PayMethodTest.FINDFIRST then
        //           PayMethodTest.FIELDERROR("Button Position No.");
        //     end;
        // }
        // field(2013971;"Payment Details";Boolean)
        // {
        //     CaptionML = ENU='Payment Details',
        //                 FRA='Détails paiement';
        //     Description = 'DITW15.00.00.39 #1328';
        //     InitValue = true;

        //     trigger OnValidate();
        //     begin
        //         if "Payment Details" then
        //           TESTFIELD("Pos System");
        //     end;
        // }
        // field(2014410;"Cash Payment";Boolean)
        // {
        //     CaptionML = ENU='Cash Payment',
        //                 FRA='Paiement au comptant';
        //     Description = 'DITW17.00.03 DIT-770 #563';
        // }
        // field(2014411;"Full Payment";Boolean)
        // {
        //     CaptionML = ENU='Full Payment',
        //                 FRA='Paiement complet';
        //     Description = 'DITW17.10.05 DIT-770 #626';
        // }  // BC Upgrade NANDIS03
    }
    // keys
    // {
    //     key(Key; "Pos System", "Pos System Timestamp")
    //     {
    //     }
    //     key(Key2; "Pos System", "Button Position No.")
    //     {
    //     }
    // }  // BC Upgrade NANDIS03

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

