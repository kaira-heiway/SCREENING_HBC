tableextension 50235 SalesCommentLineExtFND extends "Sales Comment Line"
{
    // version NAVW17.00,DITW18.00.07
    // DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                    Added fields
    //                                      2013910 User ID
    //                   DDR 26/04/2011 Modifield field "No." property 'Not Blank' = Yes
    //   DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //   DITW17.00.02 RPG 05/11/2013 DIT-770 #235 Added New Fields
    //                                              2014410 "Pick List"
    //                                              2014411 Shipment
    //                                              2014412 Invoice
    //   DITW18.00.07 KJB 02/02/2016 #1042   Added new field : "Sales Order"
    //   DITW18.00.07 AKH 07/04/2016 DIT-770 #1042 Changed captions for fields "Pick List", Shipment & Invoice
    //   DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU caption
    //   IBM PATHAA02 08/03/17 LOGGAP07/Defect1578
    //   # Aligned "Print on Delivery Note" field
    //BC Upgrade GUNREM01 Commented Drink-It Code


    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            // OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Shipment,Posted Invoice,Posted Credit Memo,Posted Return Receipt', FRA = 'Demande de prix,Commande,Facture,Avoir,Commande ouverte,Retour,Expédition,Facture enregistrée,Avoir enregistré,Réception retour enregistrée';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';

            //Unsupported feature: Change NotBlank on ""No."(Field 2)". Please convert manually.


            //Unsupported feature: Change Description on ""No."(Field 2)". Please convert manually.

        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Date)
        {
            CaptionML = ENU = 'Date', FRA = 'Date';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify("Document Line No.")
        {
            CaptionML = ENU = 'Document Line No.', FRA = 'N° ligne document';
        }

        //Unsupported feature: CodeInsertion on ""No."(Field 2)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 26/04/2011 #1230
        if xRec."No." <> "No." then
          TESTFIELD("No.");
        // >>DITW15.00.00.39 DDR #1230
        */
        //end;
        field(50000; "Print on Delivery Note FND"; Boolean)
        {
            Caption = 'Print on Delivery Note';
            Description = 'Defect 1578';
        }
        //BC Upgrade GUNREM01 << Commented Drink-IT fields
        /*   field(2013910;"User ID";Code[50])
           {
               CaptionML = ENU='User ID',
                           FRA='Code utilisateur';
               Description = 'DITW17.00.01 #001';
               Editable = false;
               TableRelation = User."User Name";
               //This property is currently not supported
               //TestTableRelation = false;
               ValidateTableRelation = false;

               trigger OnLookup();
               var
                   UserMgt : Codeunit "User Management";
               begin
                   UserMgt.LookupUserID("User ID");
               end;
           }
           field(2014410;"Print on Pick List";Boolean)
           {
               CaptionML = ENU='Print on Pick List',
                           FRA='Imprimé sur Liste Prélèvement';
               Description = 'DITW17.00.02 DIT-770 #235 - DITW18.00.07 DIT-770 #1042';
           }
           field(2014411;"Print on Shipment";Boolean)
           {
               CaptionML = ENU='Print on Shipment',
                           FRA='Imprimé sur Expédition';
               Description = 'DITW17.00.02 DIT-770 #235 - DITW18.00.07 DIT-770 #1042';
           }
           field(2014412;"Print on Invoice";Boolean)
           {
               CaptionML = ENU='Print on Invoice',
                           FRA='Imprimé sur Facture';
               Description = 'DITW17.00.02 DIT-770 #235 - DITW18.00.07 DIT-770 #1042';
           }
           field(2014413;"Sales Order";Boolean)
           {
               CaptionML = ENU='Sales Order',
                           FRA='Commande vente';
               Description = 'DITW18.00.07 DIT-770 #1042';
           }
           */
        //BC Upgrade GUNREM01 << Commented Drink-IT fields
    }


    //Unsupported feature: CodeInsertion on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.39 RBE 20/04/2011 #1230
    "User ID" := USERID();
    // <<DITW15.00.00.39 DDR 26/04/2011 #1230
    TESTFIELD("No.");
    // >>DITW15.00.00.39 DDR #1230
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.39 RBE 20/04/2011 #1230
    "User ID" := USERID();
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.39 RBE 20/04/2011 #1230
    "User ID" := USERID();
    // <<DITW15.00.00.39 DDR 26/04/2011 #1230
    TESTFIELD("No.");
    // >>DITW15.00.00.39 DDR #1230
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

