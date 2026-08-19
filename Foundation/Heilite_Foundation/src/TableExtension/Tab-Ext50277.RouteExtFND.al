namespace HEILITE_MTC_.HEILITE_MTC_;

tableextension 50277 RouteExtFND extends Route107FDW
{
    // BC Upgrade SHUKLP03 >> Created table extension to add field "Van Sales Route FND" in Route table for RA SalesOrder interface.
    fields
    {
        field(50000; "Van Sales Route FND"; Boolean)
        {
            Caption = 'Van Sales Route';
            DataClassification = ToBeClassified;
        }
    }
}
