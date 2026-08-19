namespace Heilite_General_MTC.Heilite_General_MTC;

pageextension 50050 RoutePlanningWorksheetFND extends RoutePlanningWorks107FDW
{
    layout
    {
        addafter("Co-driver")
        {
            field("Warehouse Employee"; Rec."Warehouse Employee FND")
            {
                ApplicationArea = All;
            }
            field("Warehouse Responsible"; Rec."Warehouse Responsible FND")
            {
                ApplicationArea = All;
            }
        }
    }
}
