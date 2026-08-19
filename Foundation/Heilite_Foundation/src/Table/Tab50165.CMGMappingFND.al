table 50165 "CMG Mapping FND"
{
    // version HEI.01

    // HEI.01 CHG2021732 FDD-HB755 IBM.GUNERE01 03.12.2019 # Table created
    // HEI.02 CHG2021732 FDD-HB755 IBM.GUNERE01 16.01.2020 # "CIL3 Code" field added, added to the keys
    // HEI.03 CHG2021732 FDD-HB755 IBM.GUNERE01 11.02.2020 # "CIL3 Code" field ID changed to 10, ValidateTableRelation set to No,
    //                                                       "G/L Account" field ID changed to 40, G/L Account removed from keys,
    // HEI.04 CHG2093754 IBM PANDES01 23.02.2021
    //   # Added new field C&TP CODE.


    fields
    {
        field(10; "CIL3 Code"; Code[10])
        {
            Description = 'HEI.02';
            //TableRelation = "G/L Account"."CIL3 Code" where("CIL3 Code" = FILTER(<> ''));  // BC Upgrade NANDIS03
            //ValidateTableRelation = false;  // BC Upgrade NANDIS03
        }
        field(20; "Dimension Code"; Code[20])
        {
            TableRelation = Dimension.Code;

            trigger OnLookup();
            var
                Dimension: Record Dimension;
            begin
                // GetGeneralInterfaceSetup;  // BC Upgrade NANDIS03
                // Dimension.SETRANGE(Code, GeneralInterfaceSetup."CMG Dimension Code");  // BC Upgrade NANDIS03
                if PAGE.RUNMODAL(PAGE::Dimensions, Dimension) = ACTION::LookupOK then
                    "Dimension Code" := Dimension.Code;
            end;
        }
        field(30; "Dimension Value Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Code"));
        }
        field(40; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50; "C&TP CODE"; Code[20])
        {
            Caption = 'C&TP CODE';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
    }

    keys
    {
        key(Key1; "C&TP CODE", "Dimension Code", "Dimension Value Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        //GeneralInterfaceSetup: Record "General Interface Setup";  // BC Upgrade NANDIS03
        GeneralInterfaceSetupGot: Boolean;

    // local procedure GetGeneralInterfaceSetup();
    // begin
    //     if not GeneralInterfaceSetupGot then
    //         if GeneralInterfaceSetup.GET then;
    //     GeneralInterfaceSetupGot := true
    // end;  // BC Upgrade NANDIS03
}

