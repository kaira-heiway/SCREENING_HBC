table 58012 "Outbound Interface INT"
{
    // Heilite Navision Old Id - 50059
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 04.07.2018 # New table for Interface Common Framework

    Caption = 'Outbound Interface';
    //Permissions = TableData "Service Password" = rimd;  // BC Upgrade NANDIS03 - Blocked as Service Password table is obsolete

    fields
    {
        field(1; "Environment Code"; Option)
        {
            Caption = 'Environment Code';
            OptionCaption = 'D,Q,A,P';
            OptionMembers = D,Q,A,P;
        }
        field(2; "Legal Entity Code"; Code[10])
        {
            Caption = 'Legal Entity Code';
        }
        field(3; "Interface Code"; Code[20])
        {
            Caption = 'Interface Code';
            TableRelation = "Interface Setup INT" WHERE(Direction = CONST(Outbound));
        }
        field(11; "Database Name"; Text[250])
        {
            CaptionML = ENU = 'Database Name',
                        FRA = 'Nom de la base de données';
        }
        field(12; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
        }
        field(15; Endpoint; Text[250])
        {
            Caption = 'Endpoint';
        }
        field(16; "Endpoint 2"; Text[250])
        {
            Caption = 'Endpoint 2';
        }
        field(18; "SOAP Action"; Text[50])
        {
            Caption = 'SOAP Action';
        }
        field(20; "User ID"; Text[250])
        {
            Caption = 'User ID';
        }
        field(21; "Password Key"; Guid)
        {
            Caption = 'Password Key';
        }
        field(30; "HeiLite Business System ID"; Text[60])
        {
            Caption = 'HeiLite Business System ID';
        }
        field(31; "SRM Business System ID"; Text[60])
        {
            Caption = 'SRM Business System ID';
        }
        field(32; "Logical System ID"; Code[10])
        {
            Caption = 'Logical System ID';
        }
        //BC Upgrade VAMSIU01 - Added new field >>
        field(33; "New Password Text"; Text[100])
        {
            Caption = 'Password Text';
        }
        field(34; "New Environment Code"; Option)
        {
            Caption = 'New Environment Code';
            OptionCaption = 'D,Q,A,P';
            OptionMembers = D,Q,A,P;
        }
        //BC Upgrade VAMSIU01 - Added new field <<
    }

    keys
    {
        key(Key1; "Environment Code", "Legal Entity Code", "Interface Code")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetPassword(NewPassword: Text[250]);
    var
    // ServicePassword : Record "Service Password";//BCUpgrade sharmp16
    begin
        // if ISNULLGUID("Password Key") or not ServicePassword.GET("Password Key") then begin
        //   ServicePassword.SavePassword(NewPassword);
        //   ServicePassword.INSERT(true);
        //   "Password Key" := ServicePassword.Key;
        // end else begin
        //   ServicePassword.SavePassword(NewPassword);
        //   ServicePassword.MODIFY;
        // end;//BCUpgrade sharmp16
    end;

    // procedure GetPassword(): Text[250];
    // var
    //     ServicePassword: Record "Service Password";
    // begin
    //     if not ISNULLGUID("Password Key") then
    //         if ServicePassword.GET("Password Key") then
    //             exit(ServicePassword.GetPassword);
    //     exit('');
    // end;//BCUpgrade sharmp16

    // procedure HasPassword(): Boolean;
    // begin
    //     exit(GetPassword <> '');
    // end;//BCUpgrade sharmp16
    trigger OnInsert()
    var
        EnvInfo: Codeunit "Environment Information";
    begin
        if EnvInfo.IsSandbox() then
            Rec."New Environment Code" := Rec."New Environment Code"::D
        else
            Rec."New Environment Code" := Rec."New Environment Code"::P;
    end;

    trigger OnModify()
    var
        EnvInfo: Codeunit "Environment Information";
    begin
        if EnvInfo.IsSandbox() then
            Rec."New Environment Code" := Rec."New Environment Code"::D
        else
            Rec."New Environment Code" := Rec."New Environment Code"::P;
    end;
}

