pageextension 54033 ItemReferenceentriesExt extends "Item Reference Entries"

// HEI.01 FDD-GAPID043 IBM LAZARE02 06.07.2017
//     # New field: EAN Category Code

//BC Upgrade GUNREM01 - Addding new field EAN Category Code to Item Reference Entries page
{
    layout
    {
        addafter("Reference No.")
        {
            field("EAN Category Code"; Rec."EAN Category Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the EAN Category Code field.';
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}