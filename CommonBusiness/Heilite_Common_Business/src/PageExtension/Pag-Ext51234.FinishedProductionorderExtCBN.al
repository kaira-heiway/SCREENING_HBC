pageextension 51234 FinishedProductionOrderExtCBN extends "Finished Production Order"
{
    //BC Upgrade GUNREM01 >> #Add new fields in finished production order page
    //# added new DIT Fields in page level 
    //-----------------------------------------------------------------------------------------------------------
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            //BC upgrade GUNREM01 added fields >>
            field("Prod. BOM No. 112FDW"; Rec."Prod. BOM No. 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Prod. BOM No. 112FDW field.';
            }

            field("Prod. BOM Vrsn Code 112FDW"; Rec."Prod. BOM Vrsn Code 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Prod. BOM Vrsn Code 112FDW field.';
            }
            field("Routing No. 112FDW"; Rec."Routing No. 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Routing No. 112FDW field.';
            }
            field("Routing Version Code 112FDW"; Rec."Routing Vrsn Code 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Routing Version Code 112FDW field.';
            }
            //BC upgrade GUNREM01 added fields <<
        }
    }

    actions
    {
        // Add changes to page actions here

    }

    var
        myInt: Integer;
}