page 51021 "Vendor Bank CBN"
{
    // version HEI.02

    // HEI.01 IBM HORTOC01 08.06.2018 - add new field "Account Type"
    // HEI.02 CHG2189862 HB3326 IBM SRIVAS07 04.04.2023 - BC Panama - Mendix - Vendor bank account
    //   # Added new field "Interm. Bank BIC/SWIFT Code"

    Caption = 'Vendor Bank';
    Editable = false;
    PageType = Card;
    SourceTable = "Vendor Bank Account";
    ApplicationArea = All;  // BC Upgrade Priya
    UsageCategory = Documents;  // BC Upgrade Priya

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies a code to identify this vendor bank account.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ToolTip = 'Specifies the number of the bank branch.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the relevant currency code for the bank account.';
                }
                field(IBAN; Rec.IBAN)
                {
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the bank where the vendor has this bank account.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the address of the bank where the vendor has the bank account.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city of the bank where the vendor has the bank account.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the vendor has the account.';
                }
                field(Account_Type; AccountType)
                {
                    Description = 'HEI.01';
                    ToolTip = 'Specifies the value of the AccountType field.';
                }
                field("Interm. Bank BIC/SWIFT Code"; Rec."Interm. Bank BIC/SWIFT Cod FND")
                {
                    Caption = 'Intermediary Bank BIC SWIFT Code';
                    ToolTip = 'Specifies the value of the Intermediary Bank BIC SWIFT Code field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        if (Rec."Currency Code" = '') and (Rec.Name <> '') then begin
            GLSetup.GET();
            Rec."Currency Code" := GLSetup."LCY Code";
        end;

        AccountType := Rec."Account Type FND";//HEI.01
    end;

    var
        GLSetup: Record "General Ledger Setup";
        AccountType: Integer;
}

