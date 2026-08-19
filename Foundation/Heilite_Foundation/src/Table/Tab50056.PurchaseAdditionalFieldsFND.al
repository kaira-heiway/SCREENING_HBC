table 50056 "Purchase Additional Fields FND"
{
    // version HEI.01


    fields
    {
        field(1; TableID; Integer)
        {
            Caption = 'TableID';
        }
        field(2; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Posted Receipt,Posted Invoice,Posted Cr. Memo';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Posted Receipt","Posted Invoice","Posted Cr. Memo";
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(50000; "On Hold UserID"; Code[50])
        {
            Caption = 'On Hold UserID';
        }
        field(50001; "On Hold Date"; Date)
        {
            Caption = 'On Hold Date';
        }
    }

    keys
    {
        key(Key1; TableID, "Document Type", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

