page 51089 "User Electronic Signature CBN"
{

    // HEI.01 HT2139 CHG2105037 IBM NANDIS01 30-04-2021 - Brasco Congo: HT2139 - PO Form Layout
    //   # New Page Electronic Signature created

    SourceTable = "User Setup";
    PageType = Card;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Control55001)
            {
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                }
                field("Electronic Signature"; Rec."Electronic Signature FND")
                {
                    ToolTip = 'Specifies the value of the Electronic Signature field.';
                }
            }
        }
    }

    actions
    {
    }
}

