tableextension 50056 VATProductPostingGroupExtFND extends "VAT Product Posting Group"
{
    // version NAVW19.00
    // HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field created: 50000 - "TIN No."
    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        field(50000; "TIN No. FND"; Text[20])
        {
            Description = 'HEI.01';
            Caption = 'TIN No.';
            TableRelation = "TIN FND"."TIN No.";
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

