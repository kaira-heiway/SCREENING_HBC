table 58071 "Zycus PO Line Type Mapping INT"
{
    // Heilite Navision Old Id - 50274
    // version HEI.01

    // HEI.01 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Table: 50274 - Zycus PO Line Type Mapping
    //   # Added Code

    Caption = 'Zycus PO Line Type Mapping';

    fields
    {
        field(1; "PO Line Type Code"; Code[1])
        {
            Caption = 'PO Line Type Code';
            Description = 'HEI.01';
        }
        field(2; "Line Type"; Option)
        {
            Caption = 'Line Type';
            Description = 'HEI.01';
            OptionCaption = '" ,G/L Account,Item,,Fixed Asset,Charge (Item)"';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(3; "CCC Marked"; Boolean)
        {
            Caption = 'CCC Marked';
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                if "CCC Marked" then begin
                    if "CONCAT Marked" then
                        ERROR(Text000, FIELDCAPTION("CCC Marked"), FIELDCAPTION("CONCAT Marked"), "PO Line Type Code");
                    if "Line Type" = "Line Type"::"Fixed Asset" then
                        ERROR(Text001, FIELDCAPTION("CCC Marked"), FIELDCAPTION("Line Type"), "Line Type", "PO Line Type Code");
                end;
                //HEI.01<<
            end;
        }
        field(4; "CONCAT Marked"; Boolean)
        {
            Caption = 'CONCAT Marked';
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                if "CONCAT Marked" then begin
                    if "CCC Marked" then
                        ERROR(Text000, FIELDCAPTION("CONCAT Marked"), FIELDCAPTION("CCC Marked"), "PO Line Type Code");
                    if "Line Type" = "Line Type"::"Fixed Asset" then
                        ERROR(Text001, FIELDCAPTION("CONCAT Marked"), FIELDCAPTION("Line Type"), "Line Type", "PO Line Type Code");
                end;
                //HEI.01<<
            end;
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
        key(Key1; "PO Line Type Code", "Line Type", "CCC Marked", "CONCAT Marked")
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
            ERROR(Text003, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate PO Interface" then
            ERROR(Text003, ZycusInterfaceSetup.FIELDCAPTION("Activate PO Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    trigger OnInsert();
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then
            ERROR(Text003, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate PO Interface" then
            ERROR(Text003, ZycusInterfaceSetup.FIELDCAPTION("Activate PO Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
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
            ERROR(Text003, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate PO Interface" then
            ERROR(Text003, ZycusInterfaceSetup.FIELDCAPTION("Activate PO Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
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
            ERROR(Text003, ZycusInterfaceSetup.FIELDCAPTION("Enabled Zycus Integration"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        if not ZycusInterfaceSetup."Activate PO Interface" then
            ERROR(Text003, ZycusInterfaceSetup.FIELDCAPTION("Activate PO Interface"), ZycusInterfaceSetup.TABLECAPTION, TABLECAPTION);
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<
    end;

    var
        Text000: Label 'You cannot mark this Field "%1" as True, beacuse this field "%2" already marked as True for this record ''%3''.';
        Text001: Label 'You cannot mark this Field "%1" as True, because the "%2" as selected ''%3'' in this record ''%4''.';
        Text002: Label 'You cannot mark this Field "%1" as True, because the same "%2" ''%3'' in this record ''%4'' is already marked this Field "%5" as True.';
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        ZycusInterfaceSetupRead: Boolean;
        Text003: Label '"""%1"" field needs to be enabled in the table ""%2"" for allowing the data in this table ""%3""."';

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

