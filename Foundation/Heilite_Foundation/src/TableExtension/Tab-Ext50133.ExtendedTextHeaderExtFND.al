tableextension 50133 ExtendedTextHeaderExtFND extends "Extended Text Header"
{
    // version NAVW110.0,FINXL7.00.001,DITW110.00.09

    // DITW15.00.00.20 DDR 04/06/2008 Drink-it Reporting functionnalities
    //                                Added fields
    //                                  2014410 Sales Shipment
    //                                  2014411 Sales Return Receipt
    //                                  2014420 Purchase Receipt
    //                                  2014421 Purchase Return Shipment
    // DITW15.00.00.23 DDR 28/07/2008 Rename fields
    //                                  2014410 -> 2014411 Sales Shipment
    //                                  2014411 -> 2014412 Sales Return Receipt
    //                                  2014420 -> 2014421 Purchase Receipt
    //                                  2014421 -> 2014422 Purchase Return Shipment
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // FINXL7.00.002 RBE 30/10/2014: Changed local variable "Descr" in function GetCaption from 50 to 80 characters
    //                               Changed ReturnValue of function GetCaption from 80 to 120 characters

    // DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9

    // HEI.02 FDD-RW-GAPLOG02 IBM NASTAA02 15.10.2018 # Delivery Note
    //   # New Field created 50001 - Print on Delivery Note
    // HEI.03 HT2111 - CHG2105023 IBM NASTAA02 08.04.2021 # Customer Statement of Account Congo
    //   # New Field created 50002 - Print on Customer Statement

    fields
    {
        modify("Table Name")
        {
            CaptionML = ENU = 'Table Name', FRA = 'Nom de la table';
            //OptionCaptionML = ENU = 'Standard Text,G/L Account,Item,Resource', FRA = 'Texte standard,Compte général,Article,Ressource';
        }
        modify("No.")
        {

            //Unsupported feature: Change TableRelation on ""No."(Field 2)". Please convert manually.

            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Language Code")
        {
            CaptionML = ENU = 'Language Code', FRA = 'Code langue';
        }
        modify("Text No.")
        {
            CaptionML = ENU = 'Text No.', FRA = 'N° texte';
        }
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify("Ending Date")
        {
            CaptionML = ENU = 'Ending Date', FRA = 'Date fin';
        }
        modify("All Language Codes")
        {

            //Unsupported feature: Change InitValue on ""All Language Codes"(Field 7)". Please convert manually.

            CaptionML = ENU = 'All Language Codes', FRA = 'Commun toutes langues';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify("Sales Quote")
        {

            //Unsupported feature: Change InitValue on ""Sales Quote"(Field 11)". Please convert manually.

            CaptionML = ENU = 'Sales Quote', FRA = 'Devis';
        }
        modify("Sales Invoice")
        {

            //Unsupported feature: Change InitValue on ""Sales Invoice"(Field 12)". Please convert manually.

            CaptionML = ENU = 'Sales Invoice', FRA = 'Facture vente';
        }
        modify("Sales Order")
        {

            //Unsupported feature: Change InitValue on ""Sales Order"(Field 13)". Please convert manually.

            CaptionML = ENU = 'Sales Order', FRA = 'Commande vente';
        }
        modify("Sales Credit Memo")
        {

            //Unsupported feature: Change InitValue on ""Sales Credit Memo"(Field 14)". Please convert manually.

            CaptionML = ENU = 'Sales Credit Memo', FRA = 'Avoir vente';
        }
        modify("Purchase Quote")
        {

            //Unsupported feature: Change InitValue on ""Purchase Quote"(Field 15)". Please convert manually.

            CaptionML = ENU = 'Purchase Quote', FRA = 'Demande de prix';
        }
        modify("Purchase Invoice")
        {

            //Unsupported feature: Change InitValue on ""Purchase Invoice"(Field 16)". Please convert manually.

            CaptionML = ENU = 'Purchase Invoice', FRA = 'Facture achat';
        }
        modify("Purchase Order")
        {

            //Unsupported feature: Change InitValue on ""Purchase Order"(Field 17)". Please convert manually.

            CaptionML = ENU = 'Purchase Order', FRA = 'Commande achat';
        }
        modify("Purchase Credit Memo")
        {

            //Unsupported feature: Change InitValue on ""Purchase Credit Memo"(Field 18)". Please convert manually.

            CaptionML = ENU = 'Purchase Credit Memo', FRA = 'Avoir achat';
        }
        modify(Reminder)
        {

            //Unsupported feature: Change InitValue on "Reminder(Field 19)". Please convert manually.

            CaptionML = ENU = 'Reminder', FRA = 'Relance';
        }
        modify("Finance Charge Memo")
        {

            //Unsupported feature: Change InitValue on ""Finance Charge Memo"(Field 20)". Please convert manually.

            CaptionML = ENU = 'Finance Charge Memo', FRA = 'Facture d''intérêts';
        }
        modify("Sales Blanket Order")
        {

            //Unsupported feature: Change InitValue on ""Sales Blanket Order"(Field 21)". Please convert manually.

            CaptionML = ENU = 'Sales Blanket Order', FRA = 'Commande ouverte vente';
        }
        modify("Purchase Blanket Order")
        {

            //Unsupported feature: Change InitValue on ""Purchase Blanket Order"(Field 22)". Please convert manually.

            CaptionML = ENU = 'Purchase Blanket Order', FRA = 'Commande ouverte achat';
        }
        modify("Prepmt. Sales Invoice")
        {

            //Unsupported feature: Change InitValue on ""Prepmt. Sales Invoice"(Field 23)". Please convert manually.

            CaptionML = ENU = 'Prepmt. Sales Invoice', FRA = 'Facture vente acompte';
        }
        modify("Prepmt. Sales Credit Memo")
        {

            //Unsupported feature: Change InitValue on ""Prepmt. Sales Credit Memo"(Field 24)". Please convert manually.

            CaptionML = ENU = 'Prepmt. Sales Credit Memo', FRA = 'Avoir vente acompte';
        }
        modify("Prepmt. Purchase Invoice")
        {

            //Unsupported feature: Change InitValue on ""Prepmt. Purchase Invoice"(Field 25)". Please convert manually.

            CaptionML = ENU = 'Prepmt. Purchase Invoice', FRA = 'Facture achat acompte';
        }
        modify("Prepmt. Purchase Credit Memo")
        {

            //Unsupported feature: Change InitValue on ""Prepmt. Purchase Credit Memo"(Field 26)". Please convert manually.

            CaptionML = ENU = 'Prepmt. Purchase Credit Memo', FRA = 'Avoirs achat acompte';
        }
        modify("Service Order")
        {

            //Unsupported feature: Change InitValue on ""Service Order"(Field 5900)". Please convert manually.

            CaptionML = ENU = 'Service Order', FRA = 'Commande service';
        }
        modify("Service Quote")
        {

            //Unsupported feature: Change InitValue on ""Service Quote"(Field 5901)". Please convert manually.

            CaptionML = ENU = 'Service Quote', FRA = 'Devis service';
        }
        modify("Service Invoice")
        {

            //Unsupported feature: Change InitValue on ""Service Invoice"(Field 5902)". Please convert manually.

            CaptionML = ENU = 'Service Invoice', FRA = 'Facture service';
        }
        modify("Service Credit Memo")
        {

            //Unsupported feature: Change InitValue on ""Service Credit Memo"(Field 5903)". Please convert manually.

            CaptionML = ENU = 'Service Credit Memo', FRA = 'Avoir service';
        }
        modify("Sales Return Order")
        {

            //Unsupported feature: Change InitValue on ""Sales Return Order"(Field 6600)". Please convert manually.

            CaptionML = ENU = 'Sales Return Order', FRA = 'Retour vente';
        }
        modify("Purchase Return Order")
        {

            //Unsupported feature: Change InitValue on ""Purchase Return Order"(Field 6605)". Please convert manually.

            CaptionML = ENU = 'Purchase Return Order', FRA = 'Retour achat';
        }

        //Unsupported feature: CodeModification on ""Language Code"(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Language Code" <> '' THEN
          "All Language Codes" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Language Code" <> '' then
          "All Language Codes" := false;
        */
        //end;


        //Unsupported feature: CodeModification on ""All Language Codes"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "All Language Codes" THEN
          "Language Code" := ''
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "All Language Codes" then
          "Language Code" := ''
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchase Quote"(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Purchase Quote" THEN
          NoResourcePurch;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Purchase Quote" then
          NoResourcePurch;
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchase Invoice"(Field 16).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Purchase Invoice" THEN
          NoResourcePurch;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Purchase Invoice" then
          NoResourcePurch;
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchase Order"(Field 17).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Purchase Order" THEN
          NoResourcePurch;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Purchase Order" then
          NoResourcePurch;
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchase Credit Memo"(Field 18).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Purchase Credit Memo" THEN
          NoResourcePurch;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Purchase Credit Memo" then
          NoResourcePurch;
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchase Blanket Order"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Purchase Blanket Order" THEN
          NoResourcePurch;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Purchase Blanket Order" then
          NoResourcePurch;
        */
        //end;
        field(50000; "Print on Picklist FND"; Boolean)
        {
            caption = 'Print on Picklist';
            Description = 'HEI.01';
        }
        field(50001; "Print on Delivery Note FND"; Boolean)
        {
            caption = 'Print on Delivery Note';
            Description = 'HEI.02';
        }
        field(50002; "Print on Cust Statement FND"; Boolean)
        {
            Caption = 'Print on Customer Statement';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        // field(2014411;"Sales Shipment";Boolean)
        // {
        //     CaptionML = ENU='Sales Shipment',
        //                 FRA='Expédition vente';
        //     Description = 'DITW15.00.00.20-.23';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.20 DDR 27/05/2008
        //         if "Sales Shipment" then
        //           TESTFIELD("Table Name","Table Name"::"Standard Text");
        //         // >>DITW15.00.00.20 DDR
        //     end;
        // }
        // field(2014412;"Sales Return Receipt";Boolean)
        // {
        //     CaptionML = ENU='Sales Return Receipt',
        //                 FRA='Réception retour vente';
        //     Description = 'DITW15.00.00.20-.23';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.20 DDR 27/05/2008
        //         if "Sales Return Receipt" then
        //           TESTFIELD("Table Name","Table Name"::"Standard Text");
        //         // >>DITW15.00.00.20 DDR
        //     end;
        // }
        // field(2014421;"Purchase Receipt";Boolean)
        // {
        //     CaptionML = ENU='Purchase Receipt',
        //                 FRA='Réception achat';
        //     Description = 'DITW15.00.00.20-.23';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.20 DDR 27/05/2008
        //         if "Purchase Receipt" then
        //           TESTFIELD("Table Name","Table Name"::"Standard Text");
        //         // >>DITW15.00.00.20 DDR
        //     end;
        // }
        // field(2014422;"Purchase Return Shipment";Boolean)
        // {
        //     CaptionML = ENU='Purchase Return Shipment',
        //                 FRA='Expédition retour achat';
        //     Description = 'DITW15.00.00.20-.23';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.20 DDR 27/05/2008
        //         if "Purchase Return Shipment" then
        //           TESTFIELD("Table Name","Table Name"::"Standard Text");
        //         // >>DITW15.00.00.20 DDR
        //     end;
        // }  // BC Upgrade NANDIS03 - Blocked Aptean code
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ExtTextLine.SETRANGE("Table Name","Table Name");
    ExtTextLine.SETRANGE("No.","No.");
    ExtTextLine.SETRANGE("Language Code","Language Code");
    ExtTextLine.SETRANGE("Text No.","Text No.");
    ExtTextLine.DELETEALL(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    ExtTextLine.DELETEALL(true);
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetUniqueTextNo;

    IF "Table Name" = "Table Name"::Resource THEN BEGIN
      "Purchase Quote" := FALSE;
      "Purchase Invoice" := FALSE;
      "Purchase Blanket Order" := FALSE;
      "Purchase Order" := FALSE;
      "Purchase Credit Memo" := FALSE;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetUniqueTextNo;

    if "Table Name" = "Table Name"::Resource then begin
      "Purchase Quote" := false;
      "Purchase Invoice" := false;
      "Purchase Blanket Order" := false;
      "Purchase Order" := false;
      "Purchase Credit Memo" := false;
      // <<DITW15.00.00.20 DDR 27/05/2008
      "Purchase Receipt" := false;
      // >>DITW15.00.00.20 DDR
    end;
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Table Name" <> xRec."Table Name") OR ("No." <> xRec."No.") THEN
      ERROR(STRSUBSTNO(RenameRecordErr,FIELDCAPTION("Table Name"),FIELDCAPTION("No.")));

    SetUniqueTextNo;

    RecreateTextLines;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ("Table Name" <> xRec."Table Name") or ("No." <> xRec."No.") then
    #2..6
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "UntitledMsg(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //UntitledMsg : ENU=untitled;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //UntitledMsg : ENU=untitled;FRA=sans titre;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot purchase resources.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot purchase resources.;FRA=Vous ne pouvez pas acheter de ressources.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RenameRecordErr(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RenameRecordErr : @@@=%1 is TableName Field %2 is No.Table Field;ENU=You cannot rename %1 or %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RenameRecordErr : @@@=%1 is TableName Field %2 is No.Table Field;ENU=You cannot rename %1 or %2.;FRA=Vous ne pouvez pas renommer %1 ou %2.;
    //Variable type has not been exported.
}

