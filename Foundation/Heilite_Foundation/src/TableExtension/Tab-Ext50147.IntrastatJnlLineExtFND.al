tableextension 50147 IntrastatJnlLineExtFND extends "Intrastat Jnl. Line"
{
    //     HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields added
    //     # 10800Shipment Method Code
    //     # 10801Cust. VAT Registration No.
    // version NAVW19.00,FINXL8.00.001,DITW110.00.09

    fields
    {
        modify("Journal Template Name")
        {
            CaptionML = ENU = 'Journal Template Name', FRA = 'Nom modèle feuille';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            OptionCaptionML = ENU = 'Receipt,Shipment', FRA = 'Introduction,Expédition';
        }
        modify(Date)
        {
            CaptionML = ENU = 'Date', FRA = 'Date';
        }
        modify("Tariff No.")
        {
            CaptionML = ENU = 'Tariff No.', FRA = 'Nomenclature produits';

            //Unsupported feature: Change NotBlank on ""Tariff No."(Field 6)". Please convert manually.


            //Unsupported feature: Change Description on ""Tariff No."(Field 6)". Please convert manually.

        }
        modify("Item Description")
        {
            CaptionML = ENU = 'Item Description', FRA = 'Désignation article';
        }
        modify("Country/Region Code")
        {
            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Nature transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            OptionCaptionML = ENU = ',Item Entry,Job Entry,,,,G/L Account', FRA = ',Article,Projet,,,,Compte Général';

            //Unsupported feature: Change OptionString on ""Source Type"(Field 11)". Please convert manually.


            //Unsupported feature: Change Description on ""Source Type"(Field 11)". Please convert manually.

        }
        modify("Source Entry No.")
        {

            //Unsupported feature: Change TableRelation on ""Source Entry No."(Field 12)". Please convert manually.

            CaptionML = ENU = 'Source Entry No.', FRA = 'N° séquence origine';

            //Unsupported feature: Change Description on ""Source Entry No."(Field 12)". Please convert manually.

        }
        modify("Net Weight")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Cost Regulation %")
        {
            CaptionML = ENU = 'Cost Regulation %', FRA = '% régulation coût';
        }
        modify("Indirect Cost")
        {
            CaptionML = ENU = 'Indirect Cost', FRA = 'Coût indirect';
        }
        modify("Statistical Value")
        {
            CaptionML = ENU = 'Statistical Value', FRA = 'Valeur statistique';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Total Weight")
        {
            CaptionML = ENU = 'Total Weight', FRA = 'Poids total';
        }
        modify("Supplementary Units")
        {
            CaptionML = ENU = 'Supplementary Units', FRA = 'Unités supplémentaires';
        }
        modify("Internal Ref. No.")
        {
            CaptionML = ENU = 'Internal Ref. No.', FRA = 'N° référence interne';
        }
        modify("Country/Region of Origin Code")
        {
            CaptionML = ENU = 'Country/Region of Origin Code', FRA = 'Code pays/région origine';
        }
        modify("Entry/Exit Point")
        {
            CaptionML = ENU = 'Entry/Exit Point', FRA = 'Pays destination/provenance';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }

        //Unsupported feature: CodeModification on ""Tariff No."(Field 6).OnValidate". Please convert manually.

        //trigger "(Field 6)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Item No.",'');
        GetItemDescription;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<<FINXL7.00 RBE 20/03/2013
        //TESTFIELD("Item No.",'');
        //>>FINXL7.00 RBE 20/03/2013
        GetItemDescription;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Item No."(Field 20).OnValidate". Please convert manually.

        //trigger (Variable: Text2029610)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Item No."(Field 20).OnValidate". Please convert manually.

        //trigger "(Field 20)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Source Type",0);

        if "Item No." = '' then
          CLEAR(Item)
        else begin
          Item.GET("Item No.");
          Item.TESTFIELD("Tariff No.");
        end;

        Name := Item.Description;
        "Tariff No." := Item."Tariff No.";
        "Country/Region of Origin Code" := Item."Country/Region of Origin Code";
        GetItemDescription;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
          //<<FINXL8.00.001 BSA 09/06/2015 #121
          //Item.TESTFIELD("Tariff No.");
          //>>FINXL8.00.001 BSA 09/06/2015 #121
        #8..10
        //<<FINXL8.00.001 BSA 09/06/2015 #121
        if recFinXLSetup.READPERMISSION then
          if Item."Tariff No." <> '' then
            "Tariff No." := Item."Tariff No."
          else
            MESSAGE(Text2029610,"Item No.");
        //>>FINXL8.00.001 BSA 09/06/2015 #121
        "Country/Region of Origin Code" := Item."Country/Region of Origin Code";
        GetItemDescription;
        */
        //end;
        //BC Upgrade KAPOOV01 French Localization>>
        // field(10800; "Shipment Method Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Shipment Method Code',
        //                 FRA = 'Code condition livraison';
        //     Description = 'HEI.01';
        //     TableRelation = "Shipment Method";
        // }
        // field(10801; "Cust. VAT Registration No."; Text[20])
        // {
        //     CaptionML = ENU = 'Cust. VAT Registration No.',
        //                 FRA = 'N° identif intracom. client';
        //     Description = 'HEI.01';
        // }
        //BC Upgrade KAPOOV01 French Localization<<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        Text2029610: Label 'The Tariff number is not filled in the item %1';

    var
    //recFinXLSetup: Record "Finance XL Setup";//BC Upgrade KAPOOV01 Drink-it
}

