table 58070 "Zycus Dim Value Mapping INT"
{
    // Heilite Navision Old Id - 50273
    // version HEI.02

    // HEI.01 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Table: 50273 - Zycus Dimension Value Mapping
    //   # Added Code
    // HEI.02 CHG2307002 SAHAL01 13.06.2025 Include Additional Alphabetical Special Characters for Zycus
    //   # Created New Field: 7 - Locked

    Caption = 'Zycus Dimension Value Mapping';

    fields
    {
        field(1; "Dimension Code HeiLite"; Code[20])
        {
            Caption = 'Dimension Code HeiLite';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = Dimension;
        }
        field(2; "Dimension Value Code HeiLite"; Code[20])
        {
            Caption = 'Dimension Value Code HeiLite';
            Description = 'HEI.01';
        }
        field(6; "Dimension Value Code Zycus"; Code[20])
        {
            Caption = 'Dimension Value Code Zycus';
            Description = 'HEI.01';
        }
        field(7; Locked; Boolean)
        {
            Caption = 'Locked';
            Description = 'HEI.02';
        }
        field(10; "Last Date Modified"; Date)
        {
            CaptionML = ENU = 'Last Date Modified',
                        FRA = 'Date dern. modification';
            Description = 'HEI.01';
            Editable = false;
        }
        field(11; "Last Time Modified"; Time)
        {
            CaptionML = ENU = 'Last Time Modified',
                        FRA = 'Heure dern. modification';
            Description = 'HEI.01';
            Editable = false;
        }
        field(12; "Last Modified By User"; Code[50])
        {
            CaptionML = ENU = 'Last Modified By User',
                        FRA = 'Dernière modification par l''utilisateur';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserMgtL: Codeunit "User Management";
            begin
                //HEI.01>>
                // UserMgtL.LookupUserID("Last Modified By User");  // BC Upgrade NANDIS03 - Blocked as LookupUserID is obsolete
                UserMgtL.DisplayUserInformation("Last Modified By User");  // BC Upgrade NANDIS03 - Opened to restructure 
                //HEI.01<<
            end;
        }
    }

    keys
    {
        key(Key1; "Dimension Code HeiLite", "Dimension Value Code HeiLite")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then
            ERROR(Text000, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate Project Interface" then
            ERROR(Text000, ZycusInterfaceSetup.FIELDCAPTION("Activate Project Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    trigger OnInsert();
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then
            ERROR(Text000, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate Project Interface" then
            ERROR(Text000, ZycusInterfaceSetup.FIELDCAPTION("Activate Project Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        "Last Date Modified" := TODAY;
        "Last Time Modified" := TIME;
        "Last Modified By User" := USERID;
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    trigger OnModify();
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then
            ERROR(Text000, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate Project Interface" then
            ERROR(Text000, ZycusInterfaceSetup.FIELDCAPTION("Activate Project Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        "Last Date Modified" := TODAY;
        "Last Time Modified" := TIME;
        "Last Modified By User" := USERID;
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    trigger OnRename();
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then
            ERROR(Text000, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate Project Interface" then
            ERROR(Text000, ZycusInterfaceSetup.FIELDCAPTION("Activate Project Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    var
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        ZycusInterfaceSetupRead: Boolean;
        Text000: Label '"""%1"" field needs to be enabled in the table ""%2"" for allowing the data in this table ""%3""."';

    local procedure GetZycusInterfaceSetup_Zycus();
    begin
        //HEI.01>>
        if not ZycusInterfaceSetupRead then begin
            if ZycusInterfaceSetup.GET() and ZycusInterfaceSetup."Enabled Zycus Integration" then
                ZycusInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;
}

