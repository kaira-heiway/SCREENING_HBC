table 50392 "Cadency Running Calendar FND"
{
    // Heilite Navision Old Id - 50285
    // version HEI.01

    // HEI.01 CHG2262655 SAHAL01 09.12.2024 Automatic data export for control purposes
    //   # Created New Table: 50285 - Cadency Running Calendar
    //   # Created New Functions - SetLastModifiedDateTime
    //                           - ValidateLineDelete
    //   # Added Code

    // BC Upgrade PATELP08>>
    // Moved table from Interface to Foundation Ext.
    // Changed name of table from "Cadency Running Calendar" to "Cadency Running Calendar FND"
    // BC Upgrade PATELP08<<

    Caption = 'Cadency Running Calendar';

    fields
    {
        field(1; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            Description = 'HEI.01';
            Editable = false;
            NotBlank = true;
        }
        field(2; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            Description = 'HEI.01';
            Editable = false;
        }
        field(3; "Month Name"; Text[10])
        {
            Caption = 'Month Name';
            Description = 'HEI.01';
            Editable = false;
        }
        field(4; "Cadency Base Calendar Code"; Code[10])
        {
            Caption = 'Cadency Base Calendar Code';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "Base Calendar";
        }
        field(5; "Working Day-2 (Auto Run Date)"; Date)
        {
            Caption = 'Working Day-2 (Auto Run Date)';
            Description = 'HEI.01';
            Editable = false;
        }
        field(6; "Working Day-6 (Auto Run Date)"; Date)
        {
            Caption = 'Working Day-6 (Auto Run Date)';
            Description = 'HEI.01';
            Editable = false;
        }
        field(7; "Working Day-2 (E-Mail Sent)"; Boolean)
        {
            Caption = 'Working Day 2 (E-Mail Sent)';
            Description = 'HEI.01';
            Editable = false;
        }
        field(8; "Working Day-6 (E-Mail Sent)"; Boolean)
        {
            Caption = 'Working Day 6 (E-Mail Sent)';
            Description = 'HEI.01';
            Editable = false;
        }
        field(11; "Manual Run Date"; Date)
        {
            Caption = 'Manual Run Date';
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                if ("Manual Run Date" <> 0D) and ("Manual Run Date" < TODAY) then
                    ERROR(Text000, FIELDCAPTION("Manual Run Date"), TODAY);
                if "Manual Run Date" <> xRec."Manual Run Date" then begin
                    if "Manual Run Date (E-Mail Sent)" then
                        ERROR(Text001, FIELDCAPTION("Manual Run Date"), "Manual Run Date");
                end;
                //HEI.01<<
            end;
        }
        field(12; "Additional Run Date"; Date)
        {
            Caption = 'Additional Run Date';
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                if ("Additional Run Date" <> 0D) and ("Additional Run Date" < TODAY) then
                    ERROR(Text000, FIELDCAPTION("Additional Run Date"), TODAY);
                if "Additional Run Date" <> xRec."Additional Run Date" then begin
                    if "Addnl. Run Date (E-Mail Sent)" then
                        ERROR(Text001, FIELDCAPTION("Additional Run Date"), "Additional Run Date");
                end;
                //HEI.01<<
            end;
        }
        field(13; "Manual Run Date (E-Mail Sent)"; Boolean)
        {
            Caption = 'Manual Run Date (E-Mail Sent)';
            Description = 'HEI.01';
            Editable = false;
        }
        field(14; "Addnl. Run Date (E-Mail Sent)"; Boolean)
        {
            Caption = 'Additional Run Date (E-Mail Sent)';
            Description = 'HEI.01';
            Editable = false;
        }
        field(27; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Description = 'HEI.01';
            Editable = false;
        }
        field(28; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
            Description = 'HEI.01';
            Editable = false;
        }
        field(29; "Last Modified By User"; Code[50])
        {
            Caption = 'Last Modified By User';
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
                //UserMgtL.LookupUserID("Last Modified By User");  // BC Upgrade NANDIS03 - Blocked temporarily to get compiled
                //HEI.01<<
            end;
        }
    }

    keys
    {
        key(Key1; "Starting Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Starting Date", "Ending Date", "Month Name", "Cadency Base Calendar Code")
        {
        }
    }

    trigger OnDelete();
    begin
        //HEI.01>>
        ValidateLineDelete();
        //HEI.01<<
    end;

    trigger OnInsert();
    begin
        //HEI.01>>
        SetLastModifiedDateTime();
        //HEI.01<<
    end;

    trigger OnModify();
    begin
        //HEI.01>>
        SetLastModifiedDateTime();
        //HEI.01<<
    end;

    var
        Text000: TextConst ENU = '%1 must be at least %2.', FRA = '<Month Text>';
        Text001: Label 'You cannot change %1 %2, because E-Mail already sent.';
        Text002: Label 'You cannot delete this record, because anyone or more following field/s is/are marked as true. i.e. "%1" or "%2" or "%3" or "%4".';

    local procedure SetLastModifiedDateTime();
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
        NowL: DateTime;
    begin
        //HEI.01>>
        NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        "Last Date Modified" := DT2DATE(NowL);
        "Last Time Modified" := DT2TIME(NowL);
        "Last Modified By User" := USERID;
        //HEI.01<<
    end;

    local procedure ValidateLineDelete();
    begin
        //HEI.01>>
        if "Working Day-2 (E-Mail Sent)" or "Working Day-6 (E-Mail Sent)" or
          "Manual Run Date (E-Mail Sent)" or "Addnl. Run Date (E-Mail Sent)" then
            ERROR(Text002, FIELDCAPTION("Working Day-2 (E-Mail Sent)"), FIELDCAPTION("Working Day-6 (E-Mail Sent)"),
              FIELDCAPTION("Manual Run Date (E-Mail Sent)"), FIELDCAPTION("Addnl. Run Date (E-Mail Sent)"));
        //HEI.01<<
    end;
}

