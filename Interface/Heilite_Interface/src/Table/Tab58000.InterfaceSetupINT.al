table 58000 "Interface Setup INT"
{
    // Heilite Navision Old Id - 50000
    // version HEI.06,FM

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New table for Interface Common Framework
    // HEI.02 FDD-HNK LOGGAP001 03/12/2017 IBM.CHAUHB01. Following fields are added.
    //   Object Type
    //   Object ID
    //   Object Name
    //   File Name
    //   Tranasaction Type
    //   File Header
    // HEI.05 FDD-PA-SLSGAP023 IBM BULIMC01 21.02.2019 # New field Pepperi Interface added.
    // HEI.06 S&OP IBM POSTOI01 09.05.2019 # create new field 50018 50018Last Execution Date/TimeDateTime
    // HEI.07 HT1010 IBM NASTAA02 28.11.2019 # Maraki dedicated Job Queue - CHG2039961
    //   # New Field created: 30 - VIP Interface
    // HE.08 FDD-HT626 IBM SURYAS01 16-12-2019 FDD_Bank Connection Setup_La Réunion
    //  #Created New Following Fields:
    //   Interface Code
    // Interface Type
    // Last Seq. No.
    // Interface Dim 1 Filter
    //   Interface Dim 2 Filter
    //  #Created New Function "GetCaptionClass"
    // HEI.09 INC3036514 IBM NASTAA02 07/09/2020 # Heilite Interface FuturMaster Discount not being proccessed fully
    //   # New Field created 22 - Enable Processing Flag
    // HEI.11 CHG2335817 IBM SAHAL01 02.02.2026 To restrict users not to process Zycus errors in HeiLite
    //   # Created New Field: 50024 - Block to Reprocess VIP Error

    // BC UPGRAGDE PATELS08 >>
    // # Tag HEI.11 added and the related code.
    // BC UPGRAGDE PATELS08 <<

    Caption = 'Interface Setup';
    DrillDownPageID = "Interface Setup";
    LookupPageID = "Interface Setup";
    Permissions = //TableData "Service Password" = rimd,  // BC Upgrade NANDIS03 - Blocked as Service Password is obsolete
                  TableData "Interface Setup INT" = rimd;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; Endpoint; Text[250])
        {
            Caption = 'Endpoint';
        }
        field(4; Enabled; Boolean)
        {
            Caption = 'Enabled';

            trigger OnValidate();
            var
                CurrExchRateUpdateSetup: Record "Curr. Exch. Rate Update Setup";
            begin
            end;
        }
        field(5; "User ID"; Text[250])
        {
            Caption = 'User ID';
        }
        field(6; "Password Key"; Guid)
        {
            Caption = 'Password Key';
        }
        field(7; Direction; Option)
        {
            Caption = 'Direction';
            OptionCaption = 'Inbound,Outbound';
            OptionMembers = Inbound,Outbound;
            // BC UPGRAGDE PATELS08 >>
            trigger OnValidate()
            begin
                //HEI.11>>
                IF (Code <> '') AND "Block to Reprocess VIP Error" THEN BEGIN
                IF (xRec.Direction = xRec.Direction::Inbound) AND (xRec.Direction <> Direction) THEN BEGIN
                    "Block to Reprocess VIP Error" := FALSE;
                END;
                END;
                //HEI.11<<
            end;
            // BC UPGRAGDE PATELS08 <<
        }
        field(8; "Call Type"; Option)
        {
            Caption = 'Call Type';
            OptionCaption = 'Synchronous,Asynchronous';
            OptionMembers = Synchronous,Asynchronous;

            // BC UPGRAGDE PATELS08 >>
            trigger OnValidate()
            begin
                //HEI.11>>
                IF (Code <> '') AND "Block to Reprocess VIP Error" THEN BEGIN
                IF (xRec."Call Type" = xRec."Call Type"::Asynchronous) AND (xRec."Call Type" <> "Call Type") THEN BEGIN
                    "Block to Reprocess VIP Error" := FALSE;
                END;
                END;
                //HEI.11<<
            end;
            // BC UPGRAGDE PATELS08 <<
        }
        field(10; "Data Exch. Def Code"; Code[20])
        {
            Caption = 'Data Exch. Def Code';
            TableRelation = "Data Exch. Def".Code WHERE("Interfaces FND" = CONST(true));
        }
        field(11; "Data Exch. Line Def Code"; Code[20])
        {
            Caption = 'Data Exch. Line Def Code';
            NotBlank = true;
            TableRelation = "Data Exch. Line Def".Code WHERE("Data Exch. Def Code" = FIELD("Data Exch. Def Code"));
        }
        field(15; "Use Component Detail"; Boolean)
        {
            Caption = 'Use Component Detail';
        }
        field(20; "Endpoint 2"; Text[250])
        {
            Caption = 'Endpoint 2';
        }
        field(21; "SOAP Action"; Text[50])
        {
            Caption = 'SOAP Action';
        }
        field(22; "Enable Processing Flag"; Boolean)
        {
            Caption = 'Enable Processing Flag';
            Description = 'HEI.09';
        }
        field(30; "VIP Interface"; Boolean)
        {
            Description = 'HEI.07';

            // BC UPGRAGDE PATELS08 >>
            trigger OnValidate()
            begin
                //HEI.11>>
                IF (Code <> '') AND "Block to Reprocess VIP Error" THEN BEGIN
                IF xRec."VIP Interface" AND (xRec."VIP Interface" <> "VIP Interface") THEN BEGIN
                    "Block to Reprocess VIP Error" := FALSE;
                END;
                END;
                //HEI.11<<
            end;
            // BC UPGRAGDE PATELS08 <<
        }
        field(50000; "Object Type"; Option)
        {
            CaptionML = ENU = 'Object Type',
                        FRA = 'Object Type',
                        ESA = 'Object Type';
            Description = 'HEI.02';
            OptionCaptionML = ENU = ' ,,,Report,,Codeunit,XMLport',
                              FRA = ' ,,,Report,,Codeunit,XMLport';
            OptionMembers = " ",,,"Report",,"Codeunit","XMLport";
        }
        field(50001; "Object ID"; Integer)
        {
            CaptionML = ENU = 'Object ID',
                        FRA = 'Object ID',
                        ESA = 'Object ID';
            Description = 'HEI.02';
            TableRelation = AllObj."Object ID" WHERE("Object Type" = FIELD("Object Type"));

            trigger OnValidate();
            begin
                if AllObj.GET("Object Type", "Object ID") then
                    "Object Name" := AllObj."Object Name"
                else
                    "Object Name" := '';
            end;
        }
        field(50002; "Object Name"; Text[50])
        {
            CaptionML = ENU = 'Object Name',
                        FRA = 'Object Name',
                        ESA = 'Object Name';
            Description = 'HEI.02';
            Editable = false;
        }
        field(50003; "File Name"; Text[120])
        {
            CaptionML = ENU = 'File Name',
                        FRA = 'File Name',
                        ESA = 'File Name';
            Description = 'HEI.02';
        }
        field(50004; "Transaction Type"; Option)
        {
            CaptionML = ENU = 'Transaction Type',
                        FRA = 'Transaction Type',
                        ESA = 'Transaction Type';
            Description = 'HEI.02,HEI.03';
            OptionCaptionML = ENU = ' ,DynamicRoute,Sales Management,Product Exchange,AR Collection',
                              FRA = ' ,DynamicRoute,Sales Management,Product Exchange,AR Collection',
                              ESA = ' ,DynamicRoute,Sales Management,Product Exchange,AR Collection';
            OptionMembers = " ",DynamicRoute,"Sales Management","Product Exchange","AR Collection";
        }
        field(50005; "File Header"; Boolean)
        {
            CaptionML = ENU = 'File Header',
                        FRA = 'File Header',
                        ESA = 'File Header';
            Description = 'HEI.02';
        }
        field(50006; "Run Type"; Option)
        {
            Description = 'HEI.04';
            InitValue = Automatic;
            OptionCaption = 'Automatic,Manual';
            OptionMembers = Automatic,Manual;

            trigger OnValidate();
            begin
                if "Run Type" = "Run Type"::Automatic then begin
                    "Starting Time" := 000000T;
                    "Ending Time" := 000000T;
                    "No. of Minutes between Runs" := 0;
                end;
            end;
        }
        field(50007; "No. of Minutes between Runs"; Integer)
        {
            CaptionML = ENU = 'No. of Minutes between Runs',
                        FRA = 'Nbre minutes entre les exécutions';
            Description = 'HEI.04';
        }
        field(50008; "Starting Time"; Time)
        {
            CaptionML = ENU = 'Starting Time',
                        FRA = 'Heure début';
            Description = 'HEI.04';
        }
        field(50009; "Ending Time"; Time)
        {
            CaptionML = ENU = 'Ending Time',
                        FRA = 'Heure fin';
            Description = 'HEI.04';
        }
        field(50010; "Run on Mondays"; Boolean)
        {
            Description = 'HEI.04';
        }
        field(50011; "Run on Tuesdays"; Boolean)
        {
            Description = 'HEI.04';
        }
        field(50012; "Run on Wednesdays"; Boolean)
        {
            Description = 'HEI.04';
        }
        field(50013; "Run on Thursdays"; Boolean)
        {
            Description = 'HEI.04';
        }
        field(50014; "Run on Fridays"; Boolean)
        {
            Description = 'HEI.04';
        }
        field(50015; "Run on Saturdays"; Boolean)
        {
            Description = 'HEI.04';
        }
        field(50016; "Run on Sundays"; Boolean)
        {
            Description = 'HEI.04';
        }
        field(50017; "Pepperi Interface"; Boolean)
        {
            Caption = 'Pepperi Interface';
            Description = 'HEI.05';
        }
        field(50018; "Last Execution Date/Time"; DateTime)
        {
            Caption = 'Last Execution Date/Time';
            Description = 'HEI.06';
        }
        field(50019; "Interface Code"; Code[10])
        {
            Description = 'HEI.08';
            NotBlank = true;

            trigger OnValidate();
            begin
                if Interface.GET("Interface Code") then
                    "Interface Type" := Interface."Interface Type";
            end;
        }
        field(50020; "Interface Type"; Option)
        {
            Description = 'HEI.08';
            OptionCaption = 'SAGE-Treasory,TVI,VPI,SFA,SAGE-Payroll,FM,EDI-Order,EDI-Item,SEPA';
            OptionMembers = "SAGE-Treasory",TVI,VPI,SFA,"SAGE-Payroll",FM,"EDI-Order","EDI-Item",SEPA;
        }
        field(50021; "Last Seq. No."; Integer)
        {
            Description = 'HEI.08';
        }
        field(50022; "Interface Dim 1 Filter"; Text[100])
        {
            CaptionClass = GetCaptionClass(1);
            Description = 'HEI.08';
        }
        field(50023; "Interface Dim 2 Filter"; Text[100])
        {
            CaptionClass = GetCaptionClass(2);
            Description = 'HEI.08';
        }
        // BC UPGRADE PATELS08 >>
        field(50024; "Block to Reprocess VIP Error"; Boolean)
        {
            Description = 'HEI.08';

            trigger OnValidate()
            var
                Text000: Label 'Blocking option is available only for Inbound VIP Asynchronous Interfaces.';
            begin
                //HEI.11>>
                IF (Code <> '') AND "Block to Reprocess VIP Error" THEN BEGIN
                IF (Direction = Direction::Inbound) AND ("Call Type" = "Call Type"::Asynchronous) AND "VIP Interface" THEN BEGIN
                END ELSE
                    ERROR(Text000);
                END;
                //HEI.11<<
            end;
        }
        // BC UPGRADE PATELS08 <<
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

    var
        AllObj: Record AllObj;
        //"Object": Record "Object";
        Text55000: Label '1,5,,Interface Dimension 1 Filter';
        Text55001: Label '1,5,,Interface Dimension 2 Filter';
        Interface: Record "Interface table INT";
    //BCUpgrade sharmp16 begin>>
    // procedure SetPassword(NewPassword: Text[250]);
    // var
    //     ServicePassword: Record service;
    // begin
    //     if ISNULLGUID("Password Key") or not ServicePassword.GET("Password Key") then begin
    //         ServicePassword.SavePassword(NewPassword);
    //         ServicePassword.INSERT(true);
    //         "Password Key" := ServicePassword.Key;
    //     end else begin
    //         ServicePassword.SavePassword(NewPassword);
    //         ServicePassword.MODIFY;
    //     end;
    // end;

    // procedure GetPassword(): Text[250];
    // var
    //     ServicePassword: Record "Service Password";
    // begin
    //     if not ISNULLGUID("Password Key") then
    //         if ServicePassword.GET("Password Key") then
    //             exit(ServicePassword.GetPassword);
    //     exit('');
    // end;

    // procedure HasPassword(): Boolean;
    // begin
    //     exit(GetPassword <> '');
    // end;
    //BCUpgrade sharmp16 end>>
    procedure GetCaptionClass(InterfaceDimType: Integer): Text[250];
    begin
        //HEI.08>>
        if Interface.Code <> "Interface Code" then
            if not Interface.GET("Interface Code") then
                exit('');
        case InterfaceDimType of
            1:
                begin
                    if Interface."Interface Dimension 1 Code" <> '' then
                        exit('1,5,' + Interface."Interface Dimension 1 Code")
                    else
                        exit(Text55000);
                end;
            2:
                begin
                    if Interface."Interface Dimension 2 Code" <> '' then
                        exit('1,5,' + Interface."Interface Dimension 2 Code")
                    else
                        exit(Text55001);
                end;
        end;
        //HEI.08<<
    end;
}

