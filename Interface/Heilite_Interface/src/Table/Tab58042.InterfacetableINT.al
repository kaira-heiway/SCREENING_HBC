table 58042 "Interface table INT"
{
    // Heilite Navision Old Id - 50172
    // version HEI.01

    // HEI.01 IBM SURYAS01 FDD-HT626 10-jan-2010
    //    # New Table


    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Interface Dimension 1 Code"; Code[20])
        {
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                if "Interface Dimension 1 Code" <> '' then
                    if "Interface Dimension 1 Code" = "Interface Dimension 2 Code" then
                        ERROR(Text55001, "Interface Dimension 1 Code");

                if "Interface Dimension 1 Code" <> xRec."Interface Dimension 1 Code" then begin
                    InterfaceSetup.RESET();
                    InterfaceSetup.SETRANGE("Interface Code", Code);
                    InterfaceSetup.SETFILTER("Interface Dim 1 Filter", '<>%1', '');
                    if InterfaceSetup.FINDFIRST() then
                        ERROR(Text55000, Code);
                end;
            end;
        }
        field(4; "Interface Dimension 2 Code"; Code[20])
        {
            TableRelation = Dimension;

            trigger OnValidate();
            begin
                if "Interface Dimension 2 Code" <> '' then
                    if "Interface Dimension 1 Code" = "Interface Dimension 2 Code" then
                        ERROR(Text55001, "Interface Dimension 2 Code");

                if "Interface Dimension 2 Code" <> xRec."Interface Dimension 2 Code" then begin
                    InterfaceSetup.RESET();
                    InterfaceSetup.SETRANGE("Interface Code", Code);
                    InterfaceSetup.SETFILTER("Interface Dim 2 Filter", '<>%1', '');
                    if InterfaceSetup.FINDFIRST() then
                        ERROR(Text55000, Code);
                end;
            end;
        }
        field(5; "Interface Type"; Option)
        {
            OptionCaption = 'SAGE-Treasory,TVI,VPI,SFA,SAGE-Payroll,FM,EDI-Order,EDI-Item,SEPA';
            OptionMembers = "SAGE-Treasory",TVI,VPI,SFA,"SAGE-Payroll",FM,"EDI-Order","EDI-Item",SEPA;

            trigger OnValidate();
            begin
                Interface.RESET();
                Interface.SETRANGE("Interface Type", "Interface Type");
                if Interface.FINDFIRST() then
                    ERROR(Text55000, "Interface Type");

                if "Interface Type" <> xRec."Interface Type" then begin
                    InterfaceSetup.RESET();
                    InterfaceSetup.SETRANGE("Interface Code", Code);
                    if InterfaceSetup.FINDFIRST() then
                        ERROR(Text55001, Code);
                end;
            end;
        }
        field(6; "Export Path"; Text[100])
        {
        }
        field(7; "Import Path"; Text[100])
        {
        }
        field(8; "Response Path"; Text[100])
        {
        }
        field(9; "Error Path"; Text[100])
        {
        }
        field(10; "Email Error Address"; Text[50])
        {
        }
        field(11; "Email Error Address 2"; Text[50])
        {
        }
        field(12; "Email Error Subject"; Text[50])
        {
        }
        field(13; "Email Availability Address"; Text[50])
        {
        }
        field(14; "Email Availability Address 2"; Text[50])
        {
        }
        field(15; "Email Availability Subject"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        InterfaceSetup.RESET();
        InterfaceSetup.SETRANGE("Interface Code", Code);
        if InterfaceSetup.findset() then
            InterfaceSetup.DELETEALL();
    end;

    trigger OnInsert();
    begin
        Interface.RESET();
        Interface.SETRANGE("Interface Type", "Interface Type");
        if Interface.FINDFIRST() then
            ERROR(Text55000, "Interface Type");
    end;

    var
        Text55000: Label 'Interface Setup exists for interface %1. Delete Setup before changing interface type.';
        Text55001: Label 'Interface Dimension Code ''%1'' already exists.';
        Interface: Record "Interface table INT";
        InterfaceSetup: Record "Interface Setup INT";
        Text55002: Label 'Interface Setup not defined for %1.';

    procedure GetInterfaceSetup(var InterfaceSetUpPM: Record "Interface Setup INT"; ObjectID: Integer) ClientFileName: Text[250];
    var
        Interface: Record "Interface table INT";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        TESTFIELD("Export Path");
        InterfaceSetUpPM.RESET();
        InterfaceSetUpPM.SETRANGE("Interface Type", "Interface Type");
        InterfaceSetUpPM.SETRANGE("Interface Code", Code);
        InterfaceSetUpPM.SETRANGE("Object Type", InterfaceSetup."Object Type"::Report);
        InterfaceSetUpPM.SETRANGE("Object ID", ObjectID);
        if InterfaceSetUpPM.FINDFIRST() then begin
            InterfaceSetUpPM.TESTFIELD("File Name");
            ClientFileName := "Export Path" + '\' + InterfaceSetUpPM."File Name";
            // if EXISTS(ClientFileName) then  // BC Upgrade NANDIS03 - Blocked to compile for time being
            //     ERASE(ClientFileName);  // BC Upgrade NANDIS03 - Blocked to compile for time being
        end else
            ERROR(Text55002, Code);
        exit(ClientFileName);
    end;
}

