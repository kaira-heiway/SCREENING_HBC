page 51073 "CustHandlingTimeTruck CBN"
{
    // HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new page
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in page and all fields.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All; // BC Upgrade BHARDA11
    UsageCategory = Lists;  // BC Upgrade BHARDA11
    PageType = List;
    SourceTable = "Cust  Handling Time Truck FND";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Unloading Time  Fixed"; Rec."Unloading Time  Fixed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unloading Time  Fixed field.';
                }
                field("Unloading Time Variable"; Rec."Unloading Time Variable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unloading Time Variable field.';
                }
                field("Loading Time Fixed"; Rec."Loading Time Fixed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loading Time Fixed field.';
                }
                field("Loading Time Variable"; Rec."Loading Time Variable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loading Time Variable field.';
                }
                field("Truck Type Allowed 1"; Rec."Truck Type Allowed 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Nickerie field.';
                }
                field("Truck Type Allowed 2"; Rec."Truck Type Allowed 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Brokopondo field.';
                }
                field("Truck Type Allowed 3"; Rec."Truck Type Allowed 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parbo Klein field.';
                }
                field("Truck Type Allowed 4"; Rec."Truck Type Allowed 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marowijne field.';
                }
                field("Truck Type Allowed 5"; Rec."Truck Type Allowed 5")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parbo Groot field.';
                }
                field("Truck Type Allowed 6"; Rec."Truck Type Allowed 6")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Smalle Wegen field.';
                }
                field("Truck Type Allowed 7"; Rec."Truck Type Allowed 7")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Truck Type Allowed 7 field.';
                }
                field("Truck Type Allowed 8"; Rec."Truck Type Allowed 8")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Truck Type Allowed 8 field.';
                }
                field("Truck Type Allowed 9"; Rec."Truck Type Allowed 9")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Truck Type Allowed 9 field.';
                }
                field("Truck Type Allowed 10"; Rec."Truck Type Allowed 10")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Truck Type Allowed 10 field.';
                }
            }
        }
    }

    actions
    {
    }
}

