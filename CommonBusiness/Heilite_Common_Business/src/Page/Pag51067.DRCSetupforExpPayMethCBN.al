page 51067 "DRC Setup Exp.Pay.Meth CBN"
{
    // version HEI.01

    // HEI.01 CHG2190168 IBM POENAB02 25.01.2023 HB1917 CITI BANK USD & EUR adjustment to Payment file
    //   # Object created
    //   # 25.01.2023 Old CHG CHG2117475 was replaced with CHG2190168. Initial change was on 21.04.2021.
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in Page and Fields. 
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Setup for exporting Payment method';
    PageType = List;
    SourceTable = "DRC-Setup for Exp Pay Meth FND";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("House Bank"; Rec."House Bank")
                {
                    ApplicationArea = All;
                }
                field("Receiving Bank"; Rec."Receiving Bank")
                {
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                }
                field("Country Receiving Bank"; Rec."Country Receiving Bank")
                {
                    ApplicationArea = All;
                }
                field("Value for Payment Method"; Rec."Value for Payment Method")
                {
                    ApplicationArea = All;
                }
                field("Swift Code"; Rec."Swift Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

