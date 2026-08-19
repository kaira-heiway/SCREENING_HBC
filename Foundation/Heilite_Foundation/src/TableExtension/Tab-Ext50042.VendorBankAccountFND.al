tableextension 50042 VendorBankAccountExtFND extends "Vendor Bank Account"
{
    //     FINXL7.00.001 RBE 20/03/2013 : Check BE Bank Account at time of entry
    //                                Generate IBAN and Swift

    // DITW17.00.02 SR 10/09/2013 DIT-770 #143 : block vendor on change or insert
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL10.00 AKH 03/02/2017 Removed check on Bank Account
    // DITW110.00.11 MSF 07/11/2017 NRQ#13577 Move Code To Event Subscriber Codeunit
    // HEI.01 IBM PATHAA02 261017
    // # "Preferred Bank Account" field on the Vendor needs to update
    // # If Bank account is one, the bank account code shoould flow to vendor if not it should be blank.
    // HEI.02 FDD PTPGAP084 IBM POSTOI01 19.04.2018
    //   # add new fields 50001->50003
    //   # add new code onvalidate for the following fields : Bank Account No., Banl Branch No., IBAN
    // HEI.03 Bugfixing Panama IBM NASTAA02 22.06.2018 # Vendor Bank Payment and 'fields' needed in Mendix for Panama
    //   # Changed Option String 1 from Current to Checking on Field 50004 - Option String
    // HEI.05 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields added
    //     # 10851Agency Code
    //     # 10852RIB Key
    //     # 10853RIB Checked
    //   # Fieldgroup 2 DropDown added
    //   # New key added: Code
    //   # Code added
    // HEI.07 FDD-HT1103 IBM SURYAS01  13-04-2020
    //   #Created new Field - "Compensation Bank"
    // HEI.08 CHG2107657 IBM.GUNERE01 22.04.2021 # Marked for Deletion field added
    // HEI.09 CHG2119688 IBM POENAB02 08.11.2022 HB2428 Panama CITI - bank connectivity payment file
    //   # New field added: 50012 Domestic - Bank Branch No.
    // HEI.10 CHG2119688 IBM POENAB02 21.12.2022 HB2428 Panama CITI - bank connectivity payment file
    //   # New field added: 50013 Interm. Bank BIC/SWIFT Code
    // version NAVW110.0,FINXL10.00,DITW110.00.11,HEI.10
    //-------------------------------------------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 13.11.2025 #Commented code related to RIB.Check codeunit
    //BC Upgrade KAPOOV01 13.11.2025 # for HEI.01 Added code on OnAfterInsert trigger and created new event subcriber function-OnDeleteOnAfterSetFilters in  Cod50280 HeinekenBCUpgrade to modify standard ondelete trigger code.
    //BC Upgrade KAPOOV01 13.11.2025 #Renamed key from Key1 to Key50000 as Key1 already defined in standard base table.

    //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
    //1.Change code in OnInsert trigger to OnBeforeInsert trigger to avoid issue of record already inserted when we do validation in codeunit for same.
    //BC UPGRADE ATHUKUS01 FDDSTP_007<<
    fields
    {
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
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
            //BC Upgrade KAPOOV01>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.02>>
                IF xRec."Bank Branch No." <> "Bank Branch No." THEN
                    "Old Bank Branch No. FND" := xRec."Bank Branch No.";
                //HEI.02<<

                //HEI.05>>
                CompanyInfo.GET();
                IF CompanyInfo."Enable French Localization FND" THEN;
                //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key"); //BC Upgrade KAPOOV01-Codeunit
                //HEI.05<<
            end;
            //BC Upgrade KAPOOV01<<
        }
        modify("Bank Account No.")
        {
            CaptionML = ENU = 'Bank Account No.', FRA = 'N° compte bancaire';
            //BC Upgrade KAPOOV01>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.02>>
                IF xRec."Bank Account No." <> "Bank Account No." THEN
                    "Old Bank Account No. FND" := xRec."Bank Account No.";
                //HEI.02<<

                //HEI.05>>
                CompanyInfo.GET();
                IF CompanyInfo."Enable French Localization FND" THEN;
                //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key"); //BC Upgrade KAPOOV01-Codeunit
                //HEI.05<<
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
            //BC Upgrade KAPOOV01>>
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.02>>
                IF xRec.IBAN <> IBAN THEN
                    "Old IBAN FND" := xRec.IBAN;
                //HEI.02<<
            end;
            //BC Upgrade KAPOOV01<<
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

        //HEI.05>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          "RIB Checked" := RIBKey.Check("Bank Branch No.","Agency Code","Bank Account No.","RIB Key");
        //HEI.05<<
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Bank Account No."(Field 14)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        // var//BC Upgrade KAPOOV01-Codeunit
        //     lcuIbanMgt : Codeunit IbanSwiftManagement;//BC Upgrade KAPOOV01-Codeunit
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

        //HEI.05>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          "RIB Checked" := RIBKey.Check("Bank Branch No.","Agency Code","Bank Account No.","RIB Key");
        //HEI.05<<
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

        // BC Upgrade NANDIS03 - Blocked FR localization >>
        // field(10851; "Agency Code"; Text[5])
        // {
        //     CaptionML = ENU = 'Agency Code',
        //                 FRA = 'Code agence';
        //     Description = 'HEI.05';
        //     InitValue = '00000';

        //     trigger OnValidate();
        //     begin
        //         //HEI.05>>
        //         CompanyInfo.GET;
        //         if CompanyInfo."Enable French Localization" then begin
        //             if STRLEN("Agency Code") < 5 then
        //                 "Agency Code" := PADSTR('', 5 - STRLEN("Agency Code"), '0') + "Agency Code";
        //             //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key");//BC Upgrade KAPOOV01-Codeunit
        //         end;
        //         //HEI.05<<
        //     end;
        // }
        // field(10852; "RIB Key"; Integer)
        // {
        //     CaptionML = ENU = 'RIB Key',
        //                 FRA = 'Clé RIB';
        //     Description = 'HEI.05';

        //     trigger OnValidate();
        //     begin
        //         //HEI.05>>
        //         CompanyInfo.GET;
        //         if CompanyInfo."Enable French Localization" then;
        //         //"RIB Checked" := RIBKey.Check("Bank Branch No.", "Agency Code", "Bank Account No.", "RIB Key");//BC Upgrade KAPOOV01-Codeunit
        //         //HEI.05<<
        //     end;
        // }
        // field(10853; "RIB Checked"; Boolean)
        // {
        //     CaptionML = ENU = 'RIB Checked',
        //                 FRA = 'Vérification RIB';
        //     Description = 'HEI.05';
        //     Editable = false;
        // }
        // BC Upgrade NANDIS03 - Blocked FR localization <<
        field(50000; "Vendor Name FND"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name where("No." = FIELD("Vendor No.")));
            FieldClass = FlowField;
            Caption = 'Vendor Name';
        }
        field(50001; "Old Bank Account No. FND"; Text[30])
        {
            Caption = 'Old Bank Account No.';
            Description = 'HEi.02';
            Editable = false;
        }
        field(50002; "Old Bank Branch No. FND"; Text[20])
        {
            Caption = 'Old Bank Branch No.';
            Description = 'HEi.02';
            Editable = false;
        }
        field(50003; "Old IBAN FND"; Code[50])
        {
            Caption = 'Old IBAN';
            Description = 'HEi.02';
            Editable = false;
        }
        field(50004; "Account Type FND"; Option)
        {
            Description = 'HEI.03';
            Caption = 'Account Type';
            OptionCaption = '" ,Checking,Savings"';
            OptionMembers = " ",Checking,Savings;
        }
        field(50005; "Bank Method FND"; Code[10])
        {
            Caption = 'Bank Method';
        }
        field(50006; "Intermediary Bank Method FND"; Code[10])
        {
            Caption = 'Intermediary Bank Method';
        }
        field(50007; "Intermediary Route FND"; Code[10])
        {
            Caption = 'Intermediary Route';
        }
        field(50010; "Compensation Bank FND"; Code[20])
        {
            Description = 'HEI.07';
            Caption = 'Compensation Bank';
            TableRelation = "Bank Account";
        }
        field(50011; "Marked for Deletion FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.08';
            Caption = 'Marked for Deletion';
        }
        field(50012; "Domestic - Bank Branch No. FND"; Text[3])
        {
            Caption = 'Panama Bank Routing Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
        }
        field(50013; "Interm. Bank BIC/SWIFT Cod FND"; Code[20])
        {
            Caption = 'Intermediary Bank BIC/SWIFT Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.10';
        }
    }
    keys
    {
        key(Key50000; "Code")//BC Upgrade KAPOOV01 renamed key from Key1 to Key50000 as Key1 already defined in standard base table.
        {
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    VendorLedgerEntry.SETRANGE("Vendor No.","Vendor No.");
    VendorLedgerEntry.SETRANGE("Recipient Bank Account",Code);
    VendorLedgerEntry.SETRANGE(Open,TRUE);
    IF NOT VendorLedgerEntry.ISEMPTY THEN
      ERROR(BankAccDeleteErr);
    IF Vendor.GET("Vendor No.") AND (Vendor."Preferred Bank Account Code" = Code) THEN BEGIN
      Vendor."Preferred Bank Account Code" := '';
      Vendor.MODIFY;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    VendorLedgerEntry.SETRANGE("Vendor No.","Vendor No.");
    VendorLedgerEntry.SETRANGE("Recipient Bank Account",Code);
    VendorLedgerEntry.SETRANGE(Open,true);
    if not VendorLedgerEntry.ISEMPTY then
      ERROR(BankAccDeleteErr);

    {//HEI.01 Commented standard code PATHAA02>>
    #6..9
    }
    //HEI.01 PATHAA02>> 261017
    Heinekenglobal.updatVendebankfordel(Rec);
    //PATHAA02<< 261017
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //begin
    /*
    ///DITW110.00.11 MSF 07/11/2017 NRQ#13577

    //HEI.01 PATHAA02>> 261017
     Heinekenglobal.updatevendBank(Rec);
    //PATHAA02<< 2610117
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
    //BC UPGRADE ATHUKUS01 FDDSTP_007 >> 
    trigger OnBeforeInsert()
    begin
        Heinekenglobal.updatevendBank(Rec);
    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_007 <<
    //BC Upgrade KAPOOV01>> 
    // trigger OnAfterInsert()
    // var
    //     myInt: Integer;
    // begin
    //     //HEI.01 PATHAA02>> 261017
    //     Heinekenglobal.updatevendBank(Rec);
    //     //PATHAA02<< 2610117
    // end;
    //BC Upgrade KAPOOV01<<
    //BC UPGRADE ATHUKUS01 FDDSTP_007 >>

    //BC Upgrade SHARMP16 BEGIN<<--Open Points
    // trigger OnBeforeDelete()
    // var
    //     ApprovalEntry: Record "Approval Entry";
    //     ApprovalEntryTest: Record "Approval Entry";
    //     VendorBankAcc: Record "Vendor Bank Account";
    //     Vendor: Record Vendor;
    //     ApprovalFound: Boolean;
    //     ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    // begin
    //     ApprovalFound := false;

    //     // Delete approval entries for current record
    //     ApprovalEntry.Reset();
    //     ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
    //     ApprovalEntry.SetFilter(Status, '%1|%2',
    //         ApprovalEntry.Status::Created,
    //         ApprovalEntry.Status::Open);

    //     if not ApprovalEntry.IsEmpty() then begin
    //         ApprovalEntry.DeleteAll(true);
    //         ApprovalsMgmt.DeleteApprovalCommentLines(Rec.RecordId);
    //     end;

    //     // Check other vendor bank accounts (excluding current)
    //     VendorBankAcc.Reset();
    //     VendorBankAcc.SetRange("Vendor No.", Rec."Vendor No.");
    //     //  VendorBankAcc.SetRange(Code,Rec.Code);

    //     if VendorBankAcc.FindFirst() then begin
    //         repeat
    //             ApprovalEntryTest.Reset();
    //             ApprovalEntryTest.SetRange("Record ID to Approve", VendorBankAcc.RecordId);
    //             ApprovalEntryTest.SetFilter(Status, '%1|%2',
    //                 ApprovalEntryTest.Status::Created,
    //                 ApprovalEntryTest.Status::Open);

    //             if ApprovalEntryTest.FindFirst() then begin
    //                 ApprovalFound := true;
    //                 exit; // stop early
    //             end;
    //         until VendorBankAcc.Next() = 0;
    //     end;

    //     // If no approvals found, update vendor
    //     if not ApprovalFound then begin
    //         if Vendor.Get(Rec."Vendor No.") then begin
    //             Vendor.Validate("Sensitive Payment Block FND", false);
    //             Vendor.Validate("Sensitive Workflow Block FND", false);
    //             Vendor.Modify();
    //         end;
    //     end;
    // end;

    //BC Upgrade SHARMP16 END>>--Open Points
    var
        //RIBKey: Codeunit "RIB Key";//BC Upgrade KAPOOV01-Codeunit
        CompanyInfo: Record "Company Information";
        Rec_Vend: Record Vendor;
        Heinekenglobal: Codeunit "Heineken Global";
        RecRef: RecordRef;
        XRecRef: RecordRef;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}

