table 58069 "Zycus Special Character INT"
{
    // Heilite Navision Old Id - 50272
    // version HEI.02

    // HEI.01 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Table: 50272 - Zycus Special Character
    //   # Added Code
    // HEI.02 CHG2307002 SAHAL01 13.06.2025 Include Additional Alphabetical Special Characters for Zycus
    //   # Commented Code

    Caption = 'Zycus Special Character';

    fields
    {
        field(1; "Zycus Restricted Special Char"; Text[1])
        {
            Caption = 'Zycus Restricted Special Character';
            Description = 'HEI.01';
        }
        field(2; "Special Char Description"; Text[30])
        {
            Caption = 'Special Char Description';
            Description = 'HEI.01';
        }
        field(3; "Replaced by Char"; Text[1])
        {
            Caption = 'Replaced by Character';
            Description = 'HEI.01';
        }
        field(4; "Replaced by Char Description"; Text[30])
        {
            Caption = 'Replaced by Char Description';
            Description = 'HEI.01';
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
        key(Key1; "Zycus Restricted Special Char")
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
            ERROR(Text006, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate Project Interface" then
            ERROR(Text006, ZycusInterfaceSetup.FIELDCAPTION("Activate Project Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    trigger OnInsert();
    var
        ZycusSpecialCharacterL: Record "Zycus Special Character INT";
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then
            ERROR(Text006, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate Project Interface" then
            ERROR(Text006, ZycusInterfaceSetup.FIELDCAPTION("Activate Project Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        //HEI.02>>
        //IF "Zycus Restricted Special Char" IN [Text000,Text001,Text002,Text003] THEN
        //ERROR(Text004,FIELDCAPTION("Zycus Restricted Special Char"),"Zycus Restricted Special Char");
        //IF "Replaced by Char" IN [Text000,Text001,Text002,Text003] THEN
        //ERROR(Text004,FIELDCAPTION("Replaced by Char"),"Replaced by Char");
        //HEI.02<<
        ZycusSpecialCharacterL.SETCURRENTKEY("Replaced by Char");
        ZycusSpecialCharacterL.SETRANGE("Replaced by Char", "Zycus Restricted Special Char");
        if not ZycusSpecialCharacterL.ISEMPTY then
            ERROR(Text005, FIELDCAPTION("Zycus Restricted Special Char"), "Zycus Restricted Special Char", FIELDCAPTION("Replaced by Char"));
        ZycusSpecialCharacterL.SETCURRENTKEY("Zycus Restricted Special Char");
        ZycusSpecialCharacterL.SETRANGE("Zycus Restricted Special Char", "Replaced by Char");
        if not ZycusSpecialCharacterL.ISEMPTY then
            ERROR(Text005, FIELDCAPTION("Replaced by Char"), "Replaced by Char", FIELDCAPTION("Zycus Restricted Special Char"));
        "Last Date Modified" := TODAY;
        "Last Time Modified" := TIME;
        "Last Modified By User" := USERID;
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    trigger OnModify();
    var
        ZycusSpecialCharacterL: Record "Zycus Special Character INT";
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then
            ERROR(Text006, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate Project Interface" then
            ERROR(Text006, ZycusInterfaceSetup.FIELDCAPTION("Activate Project Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        //HEI.02>>
        //IF "Replaced by Char" IN [Text000,Text001,Text002,Text003] THEN
        //ERROR(Text004,FIELDCAPTION("Replaced by Char"),"Replaced by Char");
        //HEI.02<<
        ZycusSpecialCharacterL.SETCURRENTKEY("Zycus Restricted Special Char");
        ZycusSpecialCharacterL.SETRANGE("Zycus Restricted Special Char", "Replaced by Char");
        if not ZycusSpecialCharacterL.ISEMPTY then
            ERROR(Text005, FIELDCAPTION("Replaced by Char"), "Replaced by Char", FIELDCAPTION("Zycus Restricted Special Char"));
        "Last Date Modified" := TODAY;
        "Last Time Modified" := TIME;
        "Last Modified By User" := USERID;
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    trigger OnRename();
    var
        ZycusSpecialCharacterL: Record "Zycus Special Character INT";
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then
            ERROR(Text006, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate Project Interface" then
            ERROR(Text006, ZycusInterfaceSetup.FIELDCAPTION("Activate Project Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        //HEI.02>>
        //IF "Zycus Restricted Special Char" IN [Text000,Text001,Text002,Text003] THEN
        //ERROR(Text004,FIELDCAPTION("Zycus Restricted Special Char"),"Zycus Restricted Special Char");
        //HEI.02<<
        ZycusSpecialCharacterL.SETCURRENTKEY("Replaced by Char");
        ZycusSpecialCharacterL.SETRANGE("Replaced by Char", "Zycus Restricted Special Char");
        if not ZycusSpecialCharacterL.ISEMPTY then
            ERROR(Text005, FIELDCAPTION("Zycus Restricted Special Char"), "Zycus Restricted Special Char", FIELDCAPTION("Replaced by Char"));
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    var
        Text000: Label '*';
        Text001: Label '|';
        Text002: Label '@';
        Text003: Label '&';
        Text004: Label '"You cannot enter the %1 as %2; however it is restricted in HeiLite for filtering purpose."';
        Text005: Label '"You cannot enter the %1 as %2; somewhere it is already existing in ""%3"" field."';
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        ZycusInterfaceSetupRead: Boolean;
        Text006: Label '"""%1"" field needs to be enabled in the table ""%2"" for allowing the data in this table ""%3""."';

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

