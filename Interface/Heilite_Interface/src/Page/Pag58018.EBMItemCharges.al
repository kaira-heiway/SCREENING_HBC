page 58018 "EBM Item Charges"
{
    // Heilite Navision Old Id - 50251

    // version HEI.01

    // HEI.01 RW-GAPLOG08 IBM LAZARE02 31.10.2018 # New page for EBM interface
    // BC Upgrade PATELP08>>
    // Changed name of table from "EBM Item Charge" to "EBM Item Charge FND"
    // BC Upgrade PATELP08<<

    PageType = List;
    SourceTable = "EBM Item Charge FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Usage; Rec.Usage)
                {
                    ToolTip = 'Specifies the value of the Usage field.';
                }
            }
        }
    }

    actions
    {
    }
}

