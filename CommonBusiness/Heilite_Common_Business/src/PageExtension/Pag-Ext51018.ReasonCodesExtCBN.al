pageextension 51018 ReasonCodesExtCBN extends "Reason Codes"
{
    // version NAVW110.0,DITW110.00.08

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a reason code to attach to the entry.', FRA = 'Indique un code motif à associer à l''écriture.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of what the code stands for.', FRA = 'Indique une description de ce que le code représente.';
        }
        // BC Upgrade SHUKLP03 >> OTC221: Add 50000 to 50007 fields.

        addafter(description)
        {
            field("Allow VAT Calculation"; Rec."Allow VAT Calculation FND")
            {
                ApplicationArea = All;
            }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group FND")
            {
                ApplicationArea = All;
            }
            field("Free Item Posting Type"; Rec."Free Item Posting Type FND")
            {
                ApplicationArea = All;
            }
            field("Customer Price Group"; Rec."Customer Price Group FND")
            {
                ApplicationArea = All;
            }
            field("Customer Disc. Group"; Rec."Customer Disc. Group FND")
            {
                ApplicationArea = All;
            }
            field("Calculate on Free (Tax)"; Rec."Calculate on Free (Tax) FND")
            {
                ApplicationArea = All;
            }
            field("Calculate on Free (Deposit)"; Rec."Calculate on Free (Depo) FND")
            {
                ApplicationArea = All;
            }
            field("Calculate on Free (Discount)"; Rec."Calculate on Free (Disc) FND")
            {
                ApplicationArea = All;
            }
        }
        // BC Upgrade SHUKLP03 << OTC221

        //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


        //Unsupported feature: PropertyChange. Please convert manually.


        //Unsupported feature: PropertyChange. Please convert manually.

    }
}

