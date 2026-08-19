tableextension 50276 RoutinglinkExtFND extends "Routing Link"
{
    //BC Upgrade GUNREM01 >> created new table extension to add the property "Routing Links" in master data cue card part in role center page for FDD-DTW 029.
    DrillDownPageId = "Routing Links";
    fields
    {
        // Add changes to table fields here
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}