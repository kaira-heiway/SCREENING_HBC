tableextension 50144 RssJournalLineExtFND extends "Res. Journal Line"
{
    // version NAVW110.0.00.16996,DITW110.00.08

    fields
    {
        modify("Journal Template Name")
        {
            CaptionML = ENU = 'Journal Template Name', FRA = 'Nom modèle feuille';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            //  OptionCaptionML = ENU = 'Usage,Sale', FRA = 'Activité,Vente';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Resource No.")
        {
            CaptionML = ENU = 'Resource No.', FRA = 'N° ressource';
        }
        modify("Resource Group No.")
        {
            CaptionML = ENU = 'Resource Group No.', FRA = 'N° groupe ressources';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Work Type Code")
        {
            CaptionML = ENU = 'Work Type Code', FRA = 'Code type travail';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Direct Unit Cost")
        {
            CaptionML = ENU = 'Direct Unit Cost', FRA = 'Coût unitaire direct';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Total Cost")
        {
            CaptionML = ENU = 'Total Cost', FRA = 'Coût total';
        }
        modify("Unit Price")
        {
            CaptionML = ENU = 'Unit Price', FRA = 'Prix unitaire';
        }
        modify("Total Price")
        {
            CaptionML = ENU = 'Total Price', FRA = 'Prix total';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Source Code")
        {
            CaptionML = ENU = 'Source Code', FRA = 'Code journal';
        }
        modify("Journal Batch Name")
        {
            CaptionML = ENU = 'Journal Batch Name', FRA = 'Nom feuille';
        }
        modify("Reason Code")
        {
            CaptionML = ENU = 'Reason Code', FRA = 'Code motif';
        }
        modify("Recurring Method")
        {
            CaptionML = ENU = 'Recurring Method', FRA = 'Mode abonnement';
            OptionCaptionML = ENU = ',Fixed,Variable', FRA = ',Fixe,Variable';
        }
        modify("Expiration Date")
        {
            CaptionML = ENU = 'Expiration Date', FRA = 'Date d''expiration';
        }
        modify("Recurring Frequency")
        {
            CaptionML = ENU = 'Recurring Frequency', FRA = 'Périodicité abonnement';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            // OptionCaptionML = ENU = ' ,Customer', FRA = ' ,Client';
        }
        modify("Source No.")
        {
            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Order Type")
        {
            CaptionML = ENU = 'Order Type', FRA = 'Type de commande';
            //  OptionCaptionML = ENU = ' ,Production,Transfer,Service,Assembly', FRA = ' ,Production,Transfert,Service,Assemblage';
        }
        modify("Order No.")
        {
            CaptionML = ENU = 'Order No.', FRA = 'N° commande';
        }
        modify("Order Line No.")
        {
            CaptionML = ENU = 'Order Line No.', FRA = 'N° ligne commande';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Time Sheet No.")
        {
            CaptionML = ENU = 'Time Sheet No.', FRA = 'N° feuille de temps';
        }
        modify("Time Sheet Line No.")
        {
            CaptionML = ENU = 'Time Sheet Line No.', FRA = 'N° de ligne de la feuille de temps';
        }
        modify("Time Sheet Date")
        {
            CaptionML = ENU = 'Time Sheet Date', FRA = 'Date de la feuille de temps';
        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = 'Écriture système';
        }

        //Unsupported feature: CodeModification on ""Resource Group No."(Field 7).OnValidate". Please convert manually.

        //trigger "(Field 7)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::"Resource Group","Resource Group No.",
          DATABASE::Resource,"Resource No.",
          DATABASE::Job,"Job No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW16.00.00.41 DDR 18/09/2012 DIT-715 #297
        if "Resource Group No." <> '' then begin
          ResGr.GET("Resource Group No.");
          if ResGr."Default Resource No." <> '' then
            VALIDATE("Resource No.",ResGr."Default Resource No.");
        end;
        // >>DITW16.00.00.41 DDR DIT-715 #297
        #1..4
        */
        //end;
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        ResGr: Record "Resource Group";
}

