table 50025 "Cash Collection Cmt Line FND"
{
    // version NAVW17.00

    // HEI.01 FDD OTCGAP022 Heilite BASE IBM ISYED01 28/06/2017
    //   # Cash Collection order

    Caption = 'Cash Collection Comment Line';
    DrillDownPageID = "Cash Collection Comment List";
    LookupPageID = "Cash Collection Comment List";

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            Description = 'HEI.01';
            OptionCaption = 'Cash Collection,Issued Cash Collection';
            OptionMembers = "Cash Collection","Issued Cash Collection";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = IF (Type = CONST("Cash Collection")) "Cash Collection Header FND"
            else IF (Type = CONST("Issued Cash Collection")) "Issue Cash Collection Head FND";
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Description = 'HEI.01';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            Description = 'HEI.01';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
            Description = 'HEI.01';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; Type, "No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetUpNewLine();
    var
        CashCollectionCommentLine: Record "Cash Collection Cmt Line FND";
    begin
        //HEI.01>>
        CashCollectionCommentLine.SETRANGE(Type, Type);
        CashCollectionCommentLine.SETRANGE("No.", "No.");
        CashCollectionCommentLine.SETRANGE(Date, WORKDATE());
        if not CashCollectionCommentLine.FINDFIRST() then
            Date := WORKDATE();
        //HEI.01<<
    end;
}

