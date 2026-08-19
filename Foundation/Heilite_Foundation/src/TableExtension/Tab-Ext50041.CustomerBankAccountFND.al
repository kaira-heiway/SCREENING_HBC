tableextension 50041 CustomerBankAccountExtFND extends "Customer Bank Account"
{
    // HEI.01 BUGFIX IBM HORTOC01 12.10.2017 # Added field Blocked, flowfield from Customer table
    // HEI.02 Defect #1066 IBM NASTAA02 13.12.2017 # Bank sensitive details change
    //   # New fields added: 50001 "Old Bank Account No."
    //                       50002 "Old Bank Branch No."
    //                       50003 "Old IBAN"
    // HEI.03 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields added
    //     # 10851Agency Code
    //     # 10852RIB Key
    //     # 10853RIB Checked
    //   # Fieldgroup 2 DropDown added
    //   # Code added
    //   # New key added: Code
    // version NAVW110.0,FINXL10.00,DITW110.00.11,HEI.02

    //Bc Upgrade YADAVM09 Drink it field commented -Agency Code,RIB Key,RIB Checked.

    fields
    {
        modify("Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Name 2")
        {
            CaptionML = ENU = 'Name 2', FRA = 'Nom 2';
        }
        modify(Address)
        {
            CaptionML = ENU = 'Address', FRA = 'Adresse';
        }
        modify("Address 2")
        {
            CaptionML = ENU = 'Address 2', FRA = 'Adresse (2ème ligne)';
        }
        modify(City)
        {

            //Unsupported feature: Change TableRelation on "City(Field 8)". Please convert manually.

            CaptionML = ENU = 'City', FRA = 'Ville';
        }
        modify("Post Code")
        {

            //Unsupported feature: Change TableRelation on ""Post Code"(Field 9)". Please convert manually.

            CaptionML = ENU = 'Post Code', FRA = 'Code postal';
        }
        modify(Contact)
        {
            CaptionML = ENU = 'Contact', FRA = 'Contact';
        }
        modify("Phone No.")
        {
            CaptionML = ENU = 'Phone No.', FRA = 'N° téléphone';
        }
        modify("Telex No.")
        {
            CaptionML = ENU = 'Telex No.', FRA = 'N° télex';
        }
        modify("Bank Branch No.")
        {
            CaptionML = ENU = 'Bank Branch No.', FRA = 'Code établissement';

            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //BC Upgrade KAPOOV01>>
                //HEI.02>>
                IF xRec."Bank Branch No." <> "Bank Branch No." THEN
                    "Old Bank Branch No. FND" := xRec."Bank Branch No.";
                //HEI.02<<

                //HEI.03>>
                CompanyInfo.GET();
                IF CompanyInfo."Enable French Localization FND" THEN;
                //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key"); ////BC Upgrade KAPOOV01-Codeunit
                //HEI.03<<
                //BC Upgrade KAPOOV01<<
            end;

        }
        modify("Bank Account No.")
        {
            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';

            //Unsupported feature: Change Description on ""Bank Account No."(Field 14)". Please convert manually.
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //BC Upgrade KAPOOV01>>
                //HEI.02>>
                IF xRec."Bank Account No." <> "Bank Account No." THEN
                    "Old Bank Account No. FND" := xRec."Bank Account No.";
                //HEI.02<<

                //HEI.03>>
                CompanyInfo.GET();
                IF CompanyInfo."Enable French Localization FND" THEN;
                //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key"); //BC Upgrade KAPOOV01-Codeunit
                //HEI.03<< 
                //BC Upgrade KAPOOV01<<
            end;

        }
        modify("Transit No.")
        {
            CaptionML = ENU = 'Transit No.', FRA = 'N° interne';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Country/Region Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Code"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify(County)
        {
            CaptionML = ENU = 'County', FRA = 'Région';
        }
        modify("Fax No.")
        {
            CaptionML = ENU = 'Fax No.', FRA = 'N° télécopie';
        }
        modify("Telex Answer Back")
        {
            CaptionML = ENU = 'Telex Answer Back', FRA = 'Télex retour';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("E-Mail")
        {
            CaptionML = ENU = 'Email', FRA = 'Adresse e-mail';
        }
        modify("Home Page")
        {
            CaptionML = ENU = 'Home Page', FRA = 'Page d''accueil';
        }
        modify(IBAN)
        {
            CaptionML = ENU = 'IBAN', FRA = 'IBAN';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //BC Upgrade KAPOOV01>>
                //HEI.02>>
                IF xRec.IBAN <> IBAN THEN
                    "Old IBAN FND" := xRec.IBAN;
                //HEI.02<<
                //BC Upgrade KAPOOV01<<

            end;
        }
        modify("SWIFT Code")
        {
            CaptionML = ENU = 'SWIFT Code', FRA = 'Code SWIFT';
        }
        modify("Bank Clearing Code")
        {
            CaptionML = ENU = 'Bank Clearing Code', FRA = 'Code compensation bancaire';
        }
        modify("Bank Clearing Standard")
        {
            CaptionML = ENU = 'Bank Clearing Standard', FRA = 'Standard compensation bancaire';
        }

        //Unsupported feature: CodeModification on "City(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeModification on ""Post Code"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) and GUIALLOWED);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Bank Branch No."(Field 13)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //HEI.02>>
        if xRec."Bank Branch No." <> "Bank Branch No." then
          "Old Bank Branch No." := xRec."Bank Branch No.";
        //HEI.02<<

        //HEI.03>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          "RIB Checked" := RIBKey.Check("Bank Branch No.","Agency Code","Bank Account No.","RIB Key");
        //HEI.03<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Bank Account No."(Field 14)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var
        //     lcuIbanMgt : Codeunit IbanSwiftManagement; //BC Upgrade KAPOOV01.
        //begin
        /*
        //<<FINXL7.00.001 RBE 20/03/2013
        if (FORMAT("Bank Account No.") <> '') and   (("Country/Region Code" = 'BE') or ("Country/Region Code" = '')) then
          if (IBAN = '') and ("SWIFT Code" = '') then
              lcuIbanMgt.GenIbanSwift("Bank Account No.",IBAN,"SWIFT Code");
        //>>FINXL7.00.001 RBE 20/03/2013

        //HEI.02>>
        if xRec."Bank Account No." <> "Bank Account No." then
          "Old Bank Account No." := xRec."Bank Account No.";
        //HEI.02<<

        //HEI.03>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          "RIB Checked" := RIBKey.Check("Bank Branch No.","Agency Code","Bank Account No.","RIB Key");
        //HEI.03<<
        */
        //end;


        //Unsupported feature: CodeModification on "IBAN(Field 24).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CompanyInfo.CheckIBAN(IBAN);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CompanyInfo.CheckIBAN(IBAN);

        //HEI.02>>
        if xRec.IBAN <> IBAN then
          "Old IBAN" := xRec.IBAN;
        //HEI.02<<
        */
        //end;

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        field(10851; "Agency Code"; Text[5])
        {
            CaptionML = ENU = 'Agency Code',
                        FRA = 'Code agence';
            Description = 'HEI.03';
            InitValue = '00000';

            trigger OnValidate();
            begin
                //HEI.03>>
                CompanyInfo.GET;
                if CompanyInfo."Enable French Localization" then begin
                    if STRLEN("Agency Code") < 5 then
                        "Agency Code" := PADSTR('', 5 - STRLEN("Agency Code"), '0') + "Agency Code";
                    //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key"); //BC Upgrade KAPOOV01 need to be handled.
                end;
                //HEI.03>>
            end;
        }
        field(10852; "RIB Key"; Integer)
        {
            CaptionML = ENU = 'RIB Key',
                        FRA = 'Clé RIB';
            Description = 'HEI.03';

            trigger OnValidate();
            begin
                //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key");  //BC Upgrade KAPOOV01 CDs
            end;
        }
        field(10853; "RIB Checked"; Boolean)
        {
            CaptionML = ENU = 'RIB Checked',
                        FRA = 'Vérification RIB';
            Description = 'HEI.03';
            Editable = false;
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        field(50000; "Blocked FND"; Option)
        {
            CalcFormula = Lookup(Customer.Blocked where("No." = FIELD("Customer No.")));
            Caption = 'Blocked';
            Description = 'HEI.01';
            FieldClass = FlowField;
            OptionCaption = '" ,Ship,Invoice,All,Payment"';
            OptionMembers = " ",Ship,Invoice,All,Payment;

            trigger OnValidate();
            var
                Lbln_Allowed: Boolean;
            begin
            end;
        }
        field(50001; "Old Bank Account No. FND"; Text[30])
        {
            Caption = 'Old Bank Account No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50002; "Old Bank Branch No. FND"; Text[20])
        {
            Caption = 'Old Bank Branch No.';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50003; "Old IBAN FND"; Code[50])
        {
            Caption = 'Old IBAN';
            Description = 'HEI.02';
            Editable = false;
        }
    }
    keys
    {
        // key(Key2; "Code") // BC FR Upgrade KAIRAR01
        // {
        // }
        key(Key50000; "Code")
        {
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CustLedgerEntry.SETRANGE("Customer No.","Customer No.");
    CustLedgerEntry.SETRANGE("Recipient Bank Account",Code);
    CustLedgerEntry.SETRANGE(Open,TRUE);
    IF NOT CustLedgerEntry.ISEMPTY THEN
      ERROR(BankAccDeleteErr);
    IF Customer.GET("Customer No.") AND (Customer."Preferred Bank Account Code" = Code) THEN BEGIN
      Customer."Preferred Bank Account Code" := '';
      Customer.MODIFY;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CustLedgerEntry.SETRANGE("Customer No.","Customer No.");
    CustLedgerEntry.SETRANGE("Recipient Bank Account",Code);
    CustLedgerEntry.SETRANGE(Open,true);
    if not CustLedgerEntry.ISEMPTY then
      ERROR(BankAccDeleteErr);
    if Customer.GET("Customer No.") and (Customer."Preferred Bank Account Code" = Code) then begin
      Customer."Preferred Bank Account Code" := '';
      Customer.MODIFY;
    end;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //begin
    /*
    ///DITW110.00.11 MSF 07/11/2017 NRQ#13577
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    ///DITW110.00.11 MSF 07/11/2017 NRQ#13577
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: InsertAfter on "(FieldGroup: DropDown)". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "BankAccIdentifierIsEmptyErr(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BankAccIdentifierIsEmptyErr : ENU=You must specify either a Bank Account No. or an IBAN.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BankAccIdentifierIsEmptyErr : ENU=You must specify either a Bank Account No. or an IBAN.;FRA=Vous devez spécifier un n° compte bancaire ou un IBAN.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BankAccDeleteErr(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BankAccDeleteErr : ENU=You cannot delete this bank account because it is associated with one or more open ledger entries.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BankAccDeleteErr : ENU=You cannot delete this bank account because it is associated with one or more open ledger entries.;FRA=Vous ne pouvez pas supprimer ce compte bancaire, car il est associé à une ou plusieurs écritures comptables ouvertes.;
    //Variable type has not been exported.

    var
        //RIBKey: Codeunit "RIB Key"; //BC Upgrade KAPOOV01
        CompanyInfo: Record "Company Information";
        rec_Cust: Record Customer;
}

