page 58021 "DDE Interface Setup"
{
    // Heilite Navision Old Id - 50261

    // version HEI.02

    // HEI.01 FDD-HT678 IBM NASTAA02 25.08.2020 # DMS / DDE Integration
    //   # New Page created for DMS / DDE Interfaces
    // HEI.02 CHG2249480 IBM COSTES04 11.06.2024 Burundi-shipment to DDE – sending all distributors related shipments to DDE
    //   # new field added "DDE Ship Interface Code"

    Caption = 'DDE Interface Setup';
    PageType = Card;
    SourceTable = "DDE Interface Setup INT";
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Enable DDE Ship Interface"; Rec."Enable DDE Ship Interface")
                {
                    ToolTip = 'Specifies the value of the Enable DDE Shipment Interface field.';
                }
                field("Enable Manual DDE Shipment"; Rec."Enable Manual DDE Shipment")
                {
                    ToolTip = 'Specifies the value of the Enable Manual DDE Shipment field.';
                }
                field("DDE Ship Interface Code"; Rec."DDE Ship Interface Code")
                {
                    ToolTip = 'Specifies the value of the DDE Shipment Interface Code field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            //Caption = 'Options';  //BC Upgrade KAPVOO01
            action("Customers Included/Excluded")
            {
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DDE Customer Included List CBN";
                ToolTip = 'Executes the Customers Included/Excluded action.';
            }
        }
    }
}

