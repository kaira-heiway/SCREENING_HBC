pageextension 55000 ItemCardExt_RtR extends "Item Card"

// BC Upgrade Kamnay01 in Heineken_RTR extension is created for adding CIL ID Code and CIL ID2 Code fields to Item card page 

{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("CIL ID Code"; Rec."CIL ID Code RTR")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the CIL ID Code field.';
            }
            field("CIL ID2 Code"; Rec."CIL ID2 Code RTR")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the CIL ID2 Code field.';
            }
        }
    }
}
