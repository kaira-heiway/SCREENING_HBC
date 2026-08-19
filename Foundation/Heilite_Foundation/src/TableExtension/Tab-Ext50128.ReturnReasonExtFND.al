tableextension 50128 ReturnReason_ExtFND extends "Return Reason"
{
    // version NAVW19.00,HEI.01
    // HEI.01 CHG2200362 IBM COSTES04 30.05.2023 Updating Return reasons Code
    //   # New field Blocked
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
        modify("Default Location Code")
        {

            //Unsupported feature: Change TableRelation on ""Default Location Code"(Field 3)". Please convert manually.

            CaptionML = ENU = 'Default Location Code', FRA = 'Code magasin par défaut';
        }
        modify("Inventory Value Zero")
        {
            CaptionML = ENU = 'Inventory Value Zero', FRA = 'Exclure évaluation stock';
        }
        field(50000; "Blocked FND"; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
            Description = 'HEI.01';

            trigger OnValidate();
            var
                SalesLine: Record "Sales Line";
                SalesLineExistMsg: Label 'Return Reason %1 is currently used in open return sales orders, this may cause validation issues. Do you want to continue?';
            begin
                //HEI.01>>
                if "Blocked FND" then begin
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::"Return Order");
                    SalesLine.SETRANGE("Return Reason Code", Code);
                    if not SalesLine.ISEMPTY then
                        if not CONFIRM(STRSUBSTNO(SalesLineExistMsg, Code)) then
                            ERROR('');
                end;
                //HEI.01<<
            end;
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

