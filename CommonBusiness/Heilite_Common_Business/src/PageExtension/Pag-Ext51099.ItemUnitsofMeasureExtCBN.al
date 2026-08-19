namespace BCIBM.BCIBM;

using Microsoft.Inventory.Item;
// HEI.01 FDD-HNK-HeiliteBASE-FDD-GAPID035 IBM PATHAA02 17/07/2017
//   # added field Unit of Dimension to the Page.

// HEI.02 FDD-GAPID043 IBM LAZARE02 05.07.2017
//     # New fields: Unit of Weight, Net Weight
// HEI.03 CHG2095242 IBM NANDIS01 20.04.2021 - Unit of Measure conversion Maximo-HeiLite interface
//   #Field shown - Last Update

pageextension 51099 ItemUnitsofMeasureExtCBN extends "Item Units of Measure"
{  //---BC Upgrade KAMNAY01<< New page extension to add fields in Item Units of Measure page
    layout
    {
        addafter(Cubage)
        {
            field("Unit of Weight"; Rec."Unit of Weight FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit of Weight field.';


            }
            field("Net Weight"; Rec."Net Weight FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Weight field.';

            }
            field("Unit of Dimension"; Rec."Unit of Dimension FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit of Dimension field.';

            }
            field("Last Update"; Rec."Last Update FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Last Update field.';

            }
        }
    }
    //---BC Upgrade KAMNAY01>>New page extension to add fields in Item Units of Measure page
}
