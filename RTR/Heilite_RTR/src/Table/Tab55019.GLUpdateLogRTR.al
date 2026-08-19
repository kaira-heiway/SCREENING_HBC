table 55019 "G/L Update Log RTR"
{
    // version HEI.01

    // HEI.01 CHG2277569 SAHAL01 06.02.2025 Not able to apply Entries
    //   # Created New Table: 50286 - G/L Update Log
    //   # Created New Function - SetLastModifiedDateTime
    //   # Added Code

    //Bc Upgrade YADAVM09 table migrated.
    //Bc Upgrade YADAVM09 Old Id - 50286.

    Caption = 'G/L Update Log';
    DrillDownPageID = "G/L Update Log";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            Description = 'HEI.01';
            Editable = false;
            NotBlank = true;
        }
        field(2; "Parent G/L Entry No."; Integer)
        {
            Caption = 'Parent G/L Entry No.';
            Description = 'HEI.01';
            Editable = false;
            NotBlank = true;
            TableRelation = "G/L Entry";
        }
        field(3; "Child G/L Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Child G/L Entry No.';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "G/L Entry";
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
            Description = 'HEI.01';
            Editable = false;
        }
        field(5; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Description = 'HEI.01';
            Editable = false;
        }
        field(6; Open; Boolean)
        {
            Caption = 'Open';
            Description = 'HEI.01';
            Editable = false;
        }
        field(7; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            Description = 'HEI.01';
            Editable = false;
        }
        field(8; "Closed by Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Closed by Entry No.';
            Description = 'HEI.01';
            Editable = false;
        }
        field(9; "Closed at Date"; Date)
        {
            Caption = 'Closed at Date';
            Description = 'HEI.01';
            Editable = false;
        }
        field(10; "Closed by Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Closed by Amount';
            Description = 'HEI.01';
            Editable = false;
        }
        field(11; Reversed; Boolean)
        {
            Caption = 'Reversed';
            Description = 'HEI.01';
            Editable = false;
        }
        field(12; "Reversed by Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed by Entry No.';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "G/L Entry";
        }
        field(13; "Reversed Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'Reversed Entry No.';
            Description = 'HEI.01';
            Editable = false;
            TableRelation = "G/L Entry";
        }
        field(21; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Description = 'HEI.01';
            Editable = false;
        }
        field(22; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
            Description = 'HEI.01';
            Editable = false;
        }
        field(23; "Last Modified By User"; Code[50])
        {
            Caption = 'Last Modified By User';
            Description = 'HEI.01';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserMgtL: Codeunit "User Management";
            begin
                //HEI.01>>
                //UserMgtL.LookupUserID(("Last Modified By User");// BC upgrade YADAVM09 Function change in BC
                UserMgtL.DisplayUserInformation("Last Modified By User");// BC upgrade YADAVM09 Function change in BC
                //HEI.01<<
            end;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        //HEI.01>>
        ERROR(Text000);
        //HEI.01<<
    end;

    trigger OnInsert();
    begin
        //HEI.01>>
        SetLastModifiedDateTime;
        //HEI.01<<
    end;

    trigger OnModify();
    begin
        //HEI.01>>
        SetLastModifiedDateTime;
        //HEI.01<<
    end;

    trigger OnRename();
    begin
        //HEI.01>>
        ERROR(Text001);
        //HEI.01<<
    end;

    var
        Text000: Label 'You cannot delete the record.';
        Text001: Label 'You cannot change the primary key value in the record.';

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
}

