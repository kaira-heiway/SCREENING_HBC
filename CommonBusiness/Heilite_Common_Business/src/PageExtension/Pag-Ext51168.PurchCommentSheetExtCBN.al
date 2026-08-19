pageextension 51168 PurchCommentSheetExtCBN extends "Purch. Comment Sheet"
{
    //     DITW17.00.02 VSC 26/05/2016 DIT-770 #1970 Add Fields "Print On Purchase Order", "Print On Delivery Note"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HT678,HT679 IBM SURYAS01 20.08.2019
    //   # Added New fields - "Country of Origin","Shipment Annotation" & "Mode Of Packing"
    //   # Added Code on the above added field's onvalidate trigger's.

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
            // field("Print On Delivery Note"; Rec."Print On Delivery Note")
            // {
            // }
            // field("Print On Purchase Order"; Rec."Print On Purchase Order")
            // {
            // }//BC Upgrade DRink-IT fields
            field("Country of Origin"; Rec."Country of Origin FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country of Origin field.';

                trigger OnValidate();
                begin
                    //HEI.01<<
                    if (rec."Shipment Annotation FND" = true) or (rec."Mode of Packing FND") = true then
                        ERROR('Country of origin cannot be combined with shipment annotation/Mode of Packing');
                    //HEI.01>>
                end;
            }
            field("Shipment Annotation"; Rec."Shipment Annotation FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipment Annotation field.';

                trigger OnValidate();
                begin
                    //HEI.01<<
                    if (rec."Mode of Packing FND" = true) or (rec."Country of Origin FND" = true) then
                        ERROR('Shipment Annotation cannot be combined with Mode of Packing/Country of origin');
                    //HEI.01>>
                end;
            }
            field("Mode of Packing"; Rec."Mode of Packing FND")
            {

                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mode of Packing field.';
                trigger OnValidate();
                begin
                    //HEI.01<<
                    if (rec."Shipment Annotation FND" = true) or (rec."Country of Origin FND" = true) then
                        ERROR('Mode of Packing cannot be combined with Country of Origin/Shipment Annotation');
                    //HEI.01>>
                end;
            }
            field("Mode of Shipment"; Rec."Mode of Shipment FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Mode of Shipment field.';

            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

