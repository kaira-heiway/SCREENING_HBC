pageextension 53001 SalesCommentSheetExt extends "Sales Comment Sheet"
{
    // version NAVW110.0,DITW110.00.08
    // DITW17.00.02 RPG 05/11/2013 DIT-770 #235 New Fields added - "Pick List", Shipment, Invoice
    //   DITW18.00.07 KJB 18/02/2016 DIT-770 #1042 Add field "Sales Order"

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   IBM PATHAA02 08/03/17 LOGGAP07/Defect1578
    //   # Aligned "Print on Delivery Note" field
    //BC Upgrade GUNREM01 Commented Drink-IT code


    layout
    {
        modify(Date)
        {
            ToolTipML = ENU = 'Specifies the date the comment was created.', FRA = 'Spécifie la date de création du commentaire.';
        }
        modify(Comment)
        {
            ToolTipML = ENU = 'Specifies the comment itself.', FRA = 'Spécifie le commentaire.';
        }
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code for the comment.', FRA = 'Spécifie un code pour le commentaire.';
        }
        addafter("Code")
        {
            //BC Upgrade GUNREM01 >> Commented Drink-It Fields

            /*    field("Print on Pick List"; Rec."Print on Pick List")
                {
                }
                field("Print on Shipment"; "Print on Shipment")
                {
                }
                field("Print on Invoice"; "Print on Invoice")
                {
                }
                field("Sales Order"; "Sales Order")
                {
                }*/
            //BC Upgrade GUNREM01 << Commented Drink-It Fields

            field("Print on Delivery Note"; Rec."Print on Delivery Note FND")
            {
                ApplicationArea = all;
                ToolTip = 'Indicates whether this document should be printed on the delivery note.';
            }
        }


    }

    var
        NewSalesOrder: Boolean;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetUpNewLine;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetUpNewLine;
    //<<DITW18.00.07 KJB 18/02/2016 DIT-770 #1042
    "Sales Order" := NewSalesOrder;
    //>>DITW18.00.07 KJB DIT-770 #1042
    */
    //end;
    //BC Upgrade GUNREM01 >>
    // procedure SetDefaultValue(pNewSalesOrder: Boolean);
    // begin
    //     //<<DITW18.00.07 KJB 18/02/2016 DIT-770 #1042
    //   //  NewSalesOrder := pNewSalesOrder;
    //     //>>DITW18.00.07 KJB DIT-770 #1042
    // end;
    //BC Upgrade GUNREM01 <<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

