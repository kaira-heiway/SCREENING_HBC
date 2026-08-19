namespace Heilite_General_MTC.Heilite_General_MTC;
using System.Security.AccessControl;

tableextension 50233 RoutePlanningWorksheetExtFND extends RoutePlanningWork107FDW
{
    // BC Upgrade SHUKLP03 >> LOG019 - Route Planning Worksheet - Add fields for Warehouse Employee and Warehouse Responsible
    fields
    {
        field(50000; "Warehouse Employee FND"; Code[50])
        {
            Caption = 'Warehouse Employee';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(50001; "Warehouse Responsible FND"; Code[50])
        {
            Caption = 'Warehouse Responsible';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
    }
}
