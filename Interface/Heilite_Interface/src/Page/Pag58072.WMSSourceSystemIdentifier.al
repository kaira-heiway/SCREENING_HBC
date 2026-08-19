page 58072 "WMS Source System Identifier"
{
    // Heilite Navision Old Id - 50513

    // version HEI.01

    // HEI.01 CHG2184595 IBM COSTES04 31.03.2023 Prioritization Sales Orders
    //   # new object

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "WMS Source System Identifier" to "WMS Source Sys ID FND". 
    // BC UPGRADE PATELS08 << 

    PageType = List;
    SourceTable = "WMS Source Sys ID FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source System Identifier"; Rec."Source System Identifier")
                {
                    ToolTip = 'Specifies the value of the Source System Identifier field.';
                }
                field("Reservation Indicator"; Rec."Reservation Indicator")
                {
                    ToolTip = 'Specifies the value of the Reservation Indicator field.';
                }
                field("EDI System Identifier"; Rec."EDI System Identifier")
                {
                    ToolTip = 'Specifies the value of the EDI System Identifier field.';
                }
            }
        }
    }

    actions
    {
    }
}

