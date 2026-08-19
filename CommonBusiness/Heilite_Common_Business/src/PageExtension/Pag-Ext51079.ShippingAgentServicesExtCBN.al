pageextension 51079 ShippingAgentServicesExtCBN extends "Shipping Agent Services"
{

    // BC Upgrade MISHRS14 >>
    // Blocked OptionCaptionML line in - Field(Create PO Options"; Rec."Create PO Options) as its enum so OptionCaptionML not required.
    // BC Upgrade MISHRS14 <<

    layout
    {
        addafter("Base Calendar Code")
        {
            field("Blanket Order No."; Rec."Blanket Order No. FND")
            {
                CaptionML = ENU = 'Blanket Order No.';
                Description = 'HEI.01';
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Blanket Order No. field.';
            }
            field("Create PO Options"; Rec."Create PO Options FND")
            {

                // BC Upgrade MISHRS14 >>
                // Blocked below line in - Field(Create PO Options"; Rec."Create PO Options) as its enum so OptionCaptionML not needed.
                //OptionCaptionML = ENU = ' ,Create Open PO,Create & Release PO,Create & Release & Receive PO';
                // BC Upgrade MISHRS14 <<
                
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Create PO Options field.';
            }
            field("Unit of Measure"; Rec."Unit of Measure FND")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Unit of Measure field.';
            }


        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}