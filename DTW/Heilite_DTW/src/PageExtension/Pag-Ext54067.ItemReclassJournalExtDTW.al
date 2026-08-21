pageextension 54067 "ItemReclassJournalExt_DTW" extends "Item Reclass. Journal"
{
    layout
    {
        //PATHAA02 18.08.26 LSIT BCUP0-303>>
        addafter("Location Code")
        {
            field("Zone Code FND"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                Caption = 'Zone Code';
                ToolTip = 'Specifies the zone code associated with the bin for this item reclassification journal line.';
            }
        }
        //PATHAA02 18.08.26 LSIT BCUP0-303<<
    }
}
