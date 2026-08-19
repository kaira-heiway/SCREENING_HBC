page 58051 "Sage Interface Setup"
{
    // Heilite Navision Old Id - 50415

    // HEI.01 FDD-HT664 SURYAS01 12-02-2020
    //  # New Page Sage Interface Setup created.
    // HEI.02  FDD-HT626 SURYAS01 12-02-2020
    //  #Added New Fields  -"Vendor Non-SEPA interface","Vendor SEPA interface","Vendor Fixed Asset SEPA Interf",
    //    "Vendor SEPA BRED Interface","Vendor Fixed Asset SEPA IC","Bank Account Balances"

    PageType = Card;
    SourceTable = "SAGE Interface Setup INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Sage Interface Setup';
                field("Cust Direct Debit Interface"; Rec."Cust Direct Debit Interface")
                {
                    ToolTip = 'Specifies the value of the Cust Direct Debit Interface field.';
                }
                field("Vendor Non-SEPA interface"; Rec."Vendor Non-SEPA interface")
                {
                    ToolTip = 'Specifies the value of the Vendor Non-SEPA interface field.';
                }
                field("Vendor SEPA interface"; Rec."Vendor SEPA interface")
                {
                    ToolTip = 'Specifies the value of the Vendor SEPA interface field.';
                }
                field("Vendor Fixed Asset SEPA Interf"; Rec."Vendor Fixed Asset SEPA Interf")
                {
                    ToolTip = 'Specifies the value of the Vendor Fixed Asset SEPA Interf field.';
                }
                field("Vendor SEPA BRED Interface"; Rec."Vendor SEPA BRED Interface")
                {
                    ToolTip = 'Specifies the value of the Vendor SEPA BRED Interface field.';
                }
                field("Vendor Fixed Asset SEPA IC"; Rec."Vendor Fixed Asset SEPA IC")
                {
                    ToolTip = 'Specifies the value of the Vendor Fixed Asset SEPA IC field.';
                }
                field("Bank Account Balances"; Rec."Bank Account Balances")
                {
                    ToolTip = 'Specifies the value of the Bank Account Balances field.';
                }
            }
        }
    }

    actions
    {
    }
}

