page 58116 "MDM Cust. Bank Acc. Interface"
{
    // version HEI.01

    // HEI.01 CHG2132219 HB2607 IBM BHANDS01 22.06.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # New field added: TransitNo in CustomerBankAccount

    // BC UPGRADE PATELS08 >>
    //    # old object id - 50216
    //    # new object id - 58116 
    //    # in all fields added Rec. before field name as per new syntax change in BC upgrade
    //    # Changed page type to listpart, to be added as part in MDM Customer Interface page (58115)
    // BC UPGRADE PATELS08 <<

    Caption = 'Customer Bank Account';
    DeleteAllowed = false;
    Editable = false;

    // BC Upgrade PATELS08 >> Changed page type to listpart, to be added as part in MDM Customer Interface page (58115)
    // PageType = List;
    PageType = ListPart;
    // BC Upgrade PATELS08 <<

    SourceTable = "Customer Bank Account";

    // BC Upgrade PATELS08 >> added application area and usage category
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.") { }
                field("Code"; Rec.Code) { }
                field(Name; Rec.Name) { }
                field(City; Rec.City) { }
                field("Post Code"; Rec."Post Code") { }
                field("Bank Branch No."; Rec."Bank Branch No.") { }
                field("Bank Account No."; Rec."Bank Account No.") { }
                field("Currency Code"; Rec."Currency Code") { }
                field("Country/Region Code"; Rec."Country/Region Code") { }
                field(IBAN; Rec.IBAN) { }
                field("SWIFT Code"; Rec."SWIFT Code") { }
                field("Transit No."; Rec."Transit No.") { }
            }
        }
    }

    actions
    {
    }
}

