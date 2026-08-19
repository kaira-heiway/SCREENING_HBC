page 51037 "Vendor Local Order Address CBN"
{
    // version HEI.01
    //BC UPGRADE PATHAA02-18/09/25-Done

    Editable = false;
    PageType = ListPart;
    SourceTable = "Order Address";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Supplying Plant Vendor Number"; Rec."Supplying Plant Vndor Num. FND")
                {
                    ToolTip = 'Specifies the value of the Supplying Plant Vendor Number field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the company located at the address.';
                }
            }
        }
    }

    actions
    {
    }
}

