pageextension 54022 RoutingVersionList extends "Routing Version List"
{
    //  HEI.01 RFC-CHG0257267 IBM.AB 15.10.2018
    //   # New field Active created
    //   # Code added to mandate Active at lease one version
    //**************************************************************************************
    //BC UPGRADE PATHAA02 23.01.26
    //# Onqueryclosepageevent added in DTW Ext-CU

    Editable = false;

    layout
    {
        addlast(Control1)
        {
            field(Active; Rec."Active FND")
            {
                ApplicationArea = Manufacturing;
                ToolTip = 'Specifies whether this routing version is Active.';
            }
        }
    }
}