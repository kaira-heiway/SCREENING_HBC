tableextension 50145 JobJournalLineExtFND extends "Job Journal Line"
{
    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking

    // HEI.01 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable
    // HEI.02 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions ValidateJobPlanningLineLink()

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
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //  OptionCaptionML = ENU = 'Resource,Item,G/L Account', FRA = 'Ressource,Article,Compte général';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';

            //Unsupported feature: Change Description on "Description(Field 9)". Please convert manually.


            //Unsupported feature: Change Editable on "Description(Field 9)". Please convert manually.

        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Direct Unit Cost (LCY)")
        {
            CaptionML = ENU = 'Direct Unit Cost (LCY)', FRA = 'Coût unitaire direct DS';
        }
        modify("Unit Cost (LCY)")
        {
            CaptionML = ENU = 'Unit Cost (LCY)', FRA = 'Coût unitaire DS';
        }
        modify("Total Cost (LCY)")
        {
            CaptionML = ENU = 'Total Cost (LCY)', FRA = 'Coût total DS';
        }
        modify("Unit Price (LCY)")
        {
            CaptionML = ENU = 'Unit Price (LCY)', FRA = 'Prix unitaire DS';
        }
        modify("Total Price (LCY)")
        {
            CaptionML = ENU = 'Total Price (LCY)', FRA = 'Prix total DS';
        }
        modify("Resource Group No.")
        {
            CaptionML = ENU = 'Resource Group No.', FRA = 'N° groupe ressources';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify(Chargeable)
        {
            CaptionML = ENU = 'Chargeable', FRA = 'Facturable';
        }
        modify("Posting Group")
        {
            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';
        }
        modify("Shortcut Dimension 1 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Work Type Code")
        {
            CaptionML = ENU = 'Work Type Code', FRA = 'Code type travail';
        }
        modify("Customer Price Group")
        {
            CaptionML = ENU = 'Customer Price Group', FRA = 'Groupe prix client';
        }
        modify("Applies-to Entry")
        {
            CaptionML = ENU = 'Applies-to Entry', FRA = 'Ecriture lettrage';
        }
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            // OptionCaptionML = ENU = 'Usage,Sale', FRA = 'Activité,Vente';
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
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Nature transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("Country/Region Code")
        {
            CaptionML = ENU = 'Country/Region Code', FRA = 'Code pays/région';
        }
        modify("Entry/Exit Point")
        {
            CaptionML = ENU = 'Entry/Exit Point', FRA = 'Pays destination/provenance';
        }
        modify("Document Date")
        {
            CaptionML = ENU = 'Document Date', FRA = 'Date document';
        }
        modify("External Document No.")
        {
            CaptionML = ENU = 'External Document No.', FRA = 'N° doc. externe';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }
        modify("Serial No.")
        {
            CaptionML = ENU = 'Serial No.', FRA = 'N° de série';
        }
        modify("Posting No. Series")
        {
            CaptionML = ENU = 'Posting No. Series', FRA = 'Souches de n° validation';
        }
        modify("Source Currency Code")
        {
            CaptionML = ENU = 'Source Currency Code', FRA = 'Code devise origine';
        }
        modify("Source Currency Total Cost")
        {
            CaptionML = ENU = 'Source Currency Total Cost', FRA = 'Coût total devise origine';
        }
        modify("Source Currency Total Price")
        {
            CaptionML = ENU = 'Source Currency Total Price', FRA = 'Prix total devise origine';
        }
        modify("Source Currency Line Amount")
        {
            CaptionML = ENU = 'Source Currency Line Amount', FRA = 'Montant ligne devise origine';
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
        modify("Job Task No.")
        {
            CaptionML = ENU = 'Job Task No.', FRA = 'N° tâche projet';
        }
        modify("Total Cost")
        {
            CaptionML = ENU = 'Total Cost', FRA = 'Coût total';
        }
        modify("Unit Price")
        {
            CaptionML = ENU = 'Unit Price', FRA = 'Prix unitaire';
        }
        modify("Line Type")
        {
            CaptionML = ENU = 'Line Type', FRA = 'Type ligne';
            // OptionCaptionML = ENU = ' ,Budget,Billable,Both Budget and Billable', FRA = ' ,Budget,Facturable,Budget et Facturable';
        }
        modify("Applies-from Entry")
        {
            CaptionML = ENU = 'Applies-from Entry', FRA = 'Lettrage à partir écriture';
        }
        modify("Job Posting Only")
        {
            CaptionML = ENU = 'Job Posting Only', FRA = 'Comptabilisation projet uniquement';
        }
        modify("Line Discount %")
        {
            CaptionML = ENU = 'Line Discount %', FRA = '% remise ligne';
        }
        modify("Line Discount Amount")
        {
            CaptionML = ENU = 'Line Discount Amount', FRA = 'Montant remise ligne';
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Line Amount")
        {
            CaptionML = ENU = 'Line Amount', FRA = 'Montant ligne';
        }
        modify("Currency Factor")
        {
            CaptionML = ENU = 'Currency Factor', FRA = 'Facteur devise';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Line Amount (LCY)")
        {
            CaptionML = ENU = 'Line Amount (LCY)', FRA = 'Montant ligne DS';
        }
        modify("Line Discount Amount (LCY)")
        {
            CaptionML = ENU = 'Line Discount Amount (LCY)', FRA = 'Montant remise ligne DS';
        }
        modify("Total Price")
        {
            CaptionML = ENU = 'Total Price', FRA = 'Prix total';
        }
        modify("Cost Factor")
        {
            CaptionML = ENU = 'Cost Factor', FRA = 'Facteur coût';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Description 2';
        }
        modify("Ledger Entry Type")
        {
            CaptionML = ENU = 'Ledger Entry Type', FRA = 'Type écriture compta.';
            //  OptionCaptionML = ENU = ' ,Resource,Item,G/L Account', FRA = ' ,Ressource,Article,Compte général';
        }
        modify("Ledger Entry No.")
        {
            CaptionML = ENU = 'Ledger Entry No.', FRA = 'N° écriture comptable';
        }
        modify("Job Planning Line No.")
        {
            CaptionML = ENU = 'Job Planning Line No.', FRA = 'N° ligne planning projet';
        }
        modify("Remaining Qty.")
        {
            CaptionML = ENU = 'Remaining Qty.', FRA = 'Qté restante';
        }
        modify("Remaining Qty. (Base)")
        {
            CaptionML = ENU = 'Remaining Qty. (Base)', FRA = 'Quantité restante (base)';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Bin Code")
        {
            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Reserved Qty. (Base)")
        {
            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
        }
        modify("Service Order No.")
        {
            CaptionML = ENU = 'Service Order No.', FRA = 'N° commande service';
        }
        modify("Posted Service Shipment No.")
        {
            CaptionML = ENU = 'Posted Service Shipment No.', FRA = 'Nbre expéditions service enreg.';
        }
        modify("Lot No.")
        {
            CaptionML = ENU = 'Lot No.', FRA = 'N° lot';
        }

        //Unsupported feature: CodeModification on ""No."(Field 8).OnValidate". Please convert manually.

        //trigger "(Field 8)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if ("No." = '') or ("No." <> xRec."No.") then begin
          Description := '';
          "Unit of Measure Code" := '';
        #4..32
            begin
              GetItem;
              Item.TESTFIELD(Blocked,false);
              Description := Item.Description;
              "Description 2" := Item."Description 2";
              GetJob;
        #39..58

        VALIDATE(Quantity);
        UpdateDimensions;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..35
              // << DITW110.00.11 SFI 31/08/2017 BL#30569
              Item.BlockedSKU("Location Code","Variant Code",true);
              // >> DITW110.00.11 SFI BL#30569
        #36..61
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Unit of Measure Code"(Field 18)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
    }
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        Resource: Record Resource;
        ResourceUnitOfMeasure: Record "Resource Unit of Measure";
        UnitOfMeasure: Record "Unit of Measure";
        "Filter": Text;
    //begin
    /*
    case Type of
      Type::Item:
        begin
          ItemUnitOfMeasure.SETRANGE("Item No.","No.");
          if PAGE.RUNMODAL(0,ItemUnitOfMeasure) = ACTION::LookupOK then
            VALIDATE("Unit of Measure Code",ItemUnitOfMeasure.Code);
        end;
      Type::Resource:
        begin
          ResourceUnitOfMeasure.SETRANGE("Resource No.","No.");
          if "Job Planning Line No." <> 0 then begin
            Filter := Resource.GetUnitOfMeasureFilter("No.","Unit of Measure Code");
            ResourceUnitOfMeasure.SETFILTER(Code,Filter);
          end;
          if PAGE.RUNMODAL(0,ResourceUnitOfMeasure) = ACTION::LookupOK then
            VALIDATE("Unit of Measure Code",ResourceUnitOfMeasure.Code);
        end;
      else
        if PAGE.RUNMODAL(0,UnitOfMeasure) = ACTION::LookupOK then
          VALIDATE("Unit of Measure Code",UnitOfMeasure.Code);
    end;
    */
    //end;


    //Unsupported feature: CodeModification on ""Location Code"(Field 21).OnValidate". Please convert manually.

    //trigger OnValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Bin Code" := '';
    if "Location Code" <> '' then
      if IsServiceItem then
        Item.TESTFIELD(Type,Item.Type::Inventory);
    GetLocation("Location Code");
    Location.TESTFIELD("Directed Put-away and Pick",false);
    VALIDATE(Quantity);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    // << DITW110.00.11 SFI 31/08/2017 BL#30569
    if (Type = Type::Item) then begin
      GetItem();
      Item.BlockedSKU("Location Code","Variant Code",true);
    end;
    // >> DITW110.00.11 SFI BL#30569
    VALIDATE(Quantity);
    */
    //end;


    //Unsupported feature: CodeModification on ""Variant Code"(Field 5402).OnValidate". Please convert manually.

    //trigger OnValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Variant Code" = '' then begin
      if Type = Type::Item then begin
        Item.GET("No.");
    #4..13
    Description := ItemVariant.Description;
    "Description 2" := ItemVariant."Description 2";

    VALIDATE(Quantity);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
    // << DITW110.00.11 SFI 31/08/2017 BL#30569
    if (Type = Type::Item) then begin
      GetItem();
      Item.BlockedSKU("Location Code","Variant Code",true);
    end;
    // >> DITW110.00.11 SFI BL#30569
    VALIDATE(Quantity);
    */
    //end;
}

//Unsupported feature: InsertAfter on "Documentation". Please convert manually.


//Unsupported feature: PropertyChange. Please convert manually.


//Unsupported feature: PropertyChange. Please convert manually.



//Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

//var
//>>>> ORIGINAL VALUE:
//Text000 : ENU=You cannot change %1 when %2 is %3.;
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//Text000 : ENU=You cannot change %1 when %2 is %3.;FRA=Vous ne pouvez pas modifier %1 si %2 est %3.;
//Variable type has not been exported.


//Unsupported feature: PropertyModification on "Text001(Variable 1060)". Please convert manually.

//var
//>>>> ORIGINAL VALUE:
//Text001 : ENU=cannot be specified without %1;
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//Text001 : ENU=cannot be specified without %1;FRA=ne peut pas être spécifié(e) sans %1;
//Variable type has not been exported.


//Unsupported feature: PropertyModification on "Text002(Variable 1033)". Please convert manually.

//var
//>>>> ORIGINAL VALUE:
//Text002 : ENU=must be positive;
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//Text002 : ENU=must be positive;FRA=doit être de signe positif;
//Variable type has not been exported.


//Unsupported feature: PropertyModification on "Text003(Variable 1038)". Please convert manually.

//var
//>>>> ORIGINAL VALUE:
//Text003 : ENU=must be negative;
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//Text003 : ENU=must be negative;FRA=doit être de signe négatif;
//Variable type has not been exported.


//Unsupported feature: PropertyModification on "Text004(Variable 1019)". Please convert manually.

//var
//>>>> ORIGINAL VALUE:
//Text004 : ENU=%1 is only editable when a %2 is defined.;
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//Text004 : ENU=%1 is only editable when a %2 is defined.;FRA=%1 n'est modifiable que lorsqu'un(e) %2 est défini(e).;
//Variable type has not been exported.


//Unsupported feature: PropertyModification on "Text006(Variable 1034)". Please convert manually.

//var
//>>>> ORIGINAL VALUE:
//Text006 : ENU=%1 cannot be changed when %2 is set.;
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//Text006 : ENU=%1 cannot be changed when %2 is set.;FRA=%1 ne peut pas être modifié si %2 est défini.;
//Variable type has not been exported.


//Unsupported feature: PropertyModification on "Text007(Variable 1006)". Please convert manually.

//var
//>>>> ORIGINAL VALUE:
//Text007 : @@@=Job Journal Line job DEFAULT 30000 is already linked to Job Planning Line  DEERFIELD, 8 WP 1120 10000. Hence Remaining Qty. cannot be calculated correctly. Posting the line may update the linked %3 unexpectedly. Do you want to continue?;ENU=%1 %2 is already linked to %3 %4. Hence %5 cannot be calculated correctly. Posting the line may update the linked %3 unexpectedly. Do you want to continue?;
//Variable type has not been exported.
//>>>> MODIFIED VALUE:
//Text007 : @@@=Job Journal Line job DEFAULT 30000 is already linked to Job Planning Line  DEERFIELD, 8 WP 1120 10000. Hence Remaining Qty. cannot be calculated correctly. Posting the line may update the linked %3 unexpectedly. Do you want to continue?;ENU=%1 %2 is already linked to %3 %4. Hence %5 cannot be calculated correctly. Posting the line may update the linked %3 unexpectedly. Do you want to continue?;FRA=%1 %2 est déjà lié à %3 %4. %5 ne peut donc pas être calculé correctement. La validation de la ligne peut mettre à jour inopinément le %3 lié. Útes-vous certain de vouloir continuer ?;
//Variable type has not been exported.
