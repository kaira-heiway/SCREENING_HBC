pageextension 51188 ItemReferencesExtCBN extends "Item References"
// HEI.01 FDD-GAPID043 IBM LAZARE02 06.07.2017
//     # New field: EAN Category Code

//Bc Upgrade YADAVM09 Page extension Created and Added field EAN Category Code
// Item Cross Reference Page is now Iten References
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