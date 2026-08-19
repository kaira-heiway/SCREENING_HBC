page 51100 "DDE Customer Included List CBN"
{
    // version HEI.01

    // HEI.01 CHG2249480 IBM COSTES04 11.06.2024 Burundi-shipment to DDE – sending all distributors related shipments to DDE
    //   # new object created

    PageType = List;
    SourceTable = "DDE Customer Included FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(Included; Rec.Included)
                {
                    ToolTip = 'Specifies the value of the Included field.';
                }
            }
        }
    }

    actions
    {
    }
}

