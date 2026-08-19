tableextension 50068 FASetupExtFND extends "FA Setup"
{
    // HEI.01 FDD-RTRGAP056 IBM HORTOC01 25.08.2017
    //   # New fields added
    // HEI.02 FDD-HB2373 CHG2187935 IBM SRIVAS07 09-02-2023 - Development - CMG mandatory on FA
    //   # Added a new field - Excluded CMG Dim. Values
    // HEI.03 FDD-HB2311 CHG2200648 IBM NANDIS01 12-06-2023 #Correct posting flow FA invoicing (credit notes)
    //   # New field "Post GL on Purchase Return" (Boolean, field id - 50003) and "Payable Acc. Purchase Return" (Code, field id - 50004) added

    // version NAVW110.0,HEI.03

    fields
    {
        modify("Primary Key")
        {
            CaptionML = ENU = 'Primary Key', FRA = 'Clé primaire';
        }
        modify("Allow Posting to Main Assets")
        {
            CaptionML = ENU = 'Allow Posting to Main Assets', FRA = 'Compta. immo. princip.';
        }
        modify("Default Depr. Book")
        {
            CaptionML = ENU = 'Default Depr. Book', FRA = 'Loi amort. par défaut';
        }
        modify("Allow FA Posting From")
        {
            CaptionML = ENU = 'Allow FA Posting From', FRA = 'Date début validation immo.';
        }
        modify("Allow FA Posting To")
        {
            CaptionML = ENU = 'Allow FA Posting To', FRA = 'Date fin validation immo.';
        }
        modify("Insurance Depr. Book")
        {
            CaptionML = ENU = 'Insurance Depr. Book', FRA = 'Loi amort. assurance';
        }
        modify("Automatic Insurance Posting")
        {

            //Unsupported feature: Change InitValue on ""Automatic Insurance Posting"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Automatic Insurance Posting', FRA = 'Compta. assurance auto.';
        }
        modify("Fixed Asset Nos.")
        {
            CaptionML = ENU = 'Fixed Asset Nos.', FRA = 'N° immo.';
        }
        modify("Insurance Nos.")
        {
            CaptionML = ENU = 'Insurance Nos.', FRA = 'N° assurance';
        }

        //Unsupported feature: CodeModification on ""Default Depr. Book"(Field 4).OnValidate". Please convert manually.

        //trigger  Book"(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Insurance Depr. Book" = '' THEN
          VALIDATE("Insurance Depr. Book","Default Depr. Book");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Insurance Depr. Book" = '' then
          VALIDATE("Insurance Depr. Book","Default Depr. Book");
        */
        //end;


        //Unsupported feature: CodeModification on ""Insurance Depr. Book"(Field 7).OnValidate". Please convert manually.

        //trigger  Book"(Field 7)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF InsCoverageLedgEntry.ISEMPTY THEN
          EXIT;

        IF "Insurance Depr. Book" <> xRec."Insurance Depr. Book" THEN
          MakeInsCoverageLedgEntry.UpdateInsCoverageLedgerEntryFromFASetup("Insurance Depr. Book");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if InsCoverageLedgEntry.ISEMPTY then
          exit;

        if "Insurance Depr. Book" <> xRec."Insurance Depr. Book" then
          MakeInsCoverageLedgEntry.UpdateInsCoverageLedgerEntryFromFASetup("Insurance Depr. Book");
        */
        //end;
        field(50000; "Payable Acc.Purch. Receipt FND"; Code[20])
        {
            Caption = 'Payable Acc. Purchase Receipt';
            Description = 'HEI.01';
            TableRelation = "G/L Account"."No.";
        }
        field(50001; "Post GL on Purch. Receive FND"; Boolean)
        {
            Caption = 'Post GL on Purchase Receive';
            Description = 'HEI.01';
        }
        field(50002; "Excluded CMG Dim. Values FND"; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            Caption = 'Excluded CMG Dimension Values';
            //ValidateTableRelation = false; //BC Upgrade Kapoov01 ValidateTableRelation not required as TableRelation property not set.

            trigger OnLookup();
            var
                DimValue: Record "Dimension Value";
                FASetup: Record "FA Setup";
                GLSetup: Record "General Ledger Setup";
                DimValueList: Page "Dimension Values";
            begin
                //HEI.02>>
                GLSetup.GET();
                FASetup.GET();
                if (GLSetup."CMG Dimension Code FND" <> '') then begin
                    DimValue.RESET();
                    DimValue.SETRANGE(DimValue."Dimension Code", GLSetup."CMG Dimension Code FND");
                    DimValueList.SETTABLEVIEW(DimValue);
                    DimValueList.LOOKUPMODE(true);

                    if DimValueList.RUNMODAL() = ACTION::LookupOK then begin
                        DimValueList.GETRECORD(DimValue);
                        "Excluded CMG Dim. Values FND" := DimValue.Code;
                        VALIDATE("Excluded CMG Dim. Values FND", DimValue.Code);
                    end;
                end;
                //HEI.02<<
            end;
        }
        field(50003; "Post GL on Purchase Return FND"; Boolean)
        {
            Caption = 'Post GL on Purchase Return';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(50004; "Payable Acc. Purch. Return FND"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Caption = 'Payable Account Purchase Return';
            TableRelation = "G/L Account"."No.";
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

