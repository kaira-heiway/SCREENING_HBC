table 50281 "User ID Entry Buffer FND"
{
    // version HEI.03

    // HEI.01 CHG2241988 SAHAL01 13.05.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Created New Table: 50281 - User ID Entry Buffer
    // HEI.02 CHG2241988 SAHAL01 05.07.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Created New Fields: 8 - Last Execution Date-Time
    //                         9 - Last Executed By
    //   # Added Code
    // HEI.03 CHG2241988 SAHAL01 26.07.2024 Email Notification of Open POs Sent To Requestors Managers
    //   # Created New Fields: 10 - Email Sent
    //                         11 - Last Email Sent Date
    //                         12 - Last Email Sent Time
    //                         13 - Last Email Sent By
    //   # Added Code

    // BC Upgrade PATELP08 >>
    // # Blocked deprecated TestTableRelation property in field(9) as it is marked for removal and will become an error in future BC Versions and has no functional impact, even if set to true.
    // BC Upgrade PATELP08 <<

    Caption = 'User ID Entry Buffer';

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'HEI.01';
            TableRelation = "User Setup";
        }
        field(2; "Full Name"; Text[80])
        {
            Caption = 'Full Name';
            Description = 'HEI.01';
        }
        field(3; "E-Mail ID"; Text[100])
        {
            Caption = 'E-Mail ID';
            Description = 'HEI.01';
            ExtendedDatatype = EMail;
        }
        field(8; "Last Execution Date-Time"; DateTime)
        {
            Caption = 'Last Execution Date-Time';
            Description = 'HEI.02';
            Editable = false;
        }
        // BC Upgrade PATELP08 >>
        field(9; "Last Executed By"; Code[50])
        {
            Caption = 'Last Executed By';
            Description = 'HEI.02';
            Editable = false;
            TableRelation = User."User Name";
            // BC Upgrade PATELP08 >> Blocked deprecated TestTableRelation property as it is marked for removal and will become an error in future BC versions and has no functional impact, even if set to true.
            //TestTableRelation = false;
            // BC Upgrade PATELP08 <<
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserMgtL: Codeunit "User Management";
            begin
                //HEI.02>>
                //UserMgtL.LookupUserID("Last Executed By");//BC Upgrade SHARMP16-- function not in BC 
                UserMgtL.DisplayUserInformation("Last Executed By");//BC Upgrade SHARMP16
                                                                    //HEI.02<<
            end;
        }
        // BC Upgrade PATELP08 <<
        field(10; "Email Sent"; Boolean)
        {
            Caption = 'Email Sent';
            Description = 'HEI.03';
            Editable = false;
        }
        field(11; "Last Email Sent Date"; Date)
        {
            Caption = 'Last Email Sent Date';
            Description = 'HEI.03';
            Editable = false;
        }
        field(12; "Last Email Sent Time"; Time)
        {
            Caption = 'Last Email Sent Time';
            Description = 'HEI.03';
            Editable = false;
        }
        field(13; "Last Email Sent By"; Code[50])
        {
            Caption = 'Last Email Sent By';
            Description = 'HEI.03';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserMgtL: Codeunit "User Management";
            begin
                //HEI.03>>
                // UserMgtL.LookupUserID("Last Email Sent By");//BC Upgrade SHARMP16-- fn not in Bc 
                UserMgtL.DisplayUserInformation("Last Email Sent By");//BC Upgrade SHARMP16
                //HEI.03<<
            end;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }
}

