tableextension 50029 SalesLineExtFND extends "Sales Line"
{
    // version NAVW110.0.00.18976,OWM4.50,FINXL10.00,MANXL10.01,DITW110.00.12A,NRQ138802-102424,HEI.41
    /*
    HEI.01 FDD HNK GAPLOG002 30/05/2017 IBM ISYED01
      # Add deposit empty item as physical item onto order line automatically through Boolean field
    HEI.02 FDD-OTCGAP065 IBM.HORTOC01 11.07.2017
      # New Fields:SKU Location Code,Document Subtype Code
    HEI.03 FDD-GAPID031 IBM.PATHAA02 17.08.2017
      # Description made non-Editable
      # Changed back to default, needs to change at page level only for type=item
    HEI.04 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
      # New fields for MDM integration
    HEI.05 FDD-SLSGAP001 IBM NASTAA02 08.09.2017 # MDM Customer Card
      # Increased "Customer DTax Group Code" field length from 10 to 20 characters
    HEI.06 FDD-RTRGAP060 IBM HORTOC01 13.09.2017
      # New field "Forecasted Sales Shipment"
    HEI.07 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
      # New fields
    HEI.08 FDD-KDD0TC004 IBM NASTAA02 13.10.2017 # OTC - Returnable Packaging Material - RPM
      # New field "RPM Damage / Loss" created
      # New field "Transporter RPM Damage / Loss" created
    HEI.09 FDD-SLSGAP015 IBM NASTAA02 20.04.2018 # Default Dimensions in the Promotion Charges
      # New functions "CopyDefaultDimensions" and "UpdateDimSet" created to add the Free Reason Code Default Dimensions to Dimension Set Entries
    HEI.10 FDD-SLSGAP015 IBM NASTAA02 24.04.2018 # Default Dimensions in the Promotion Charges
      # New function "UpdateFreeReasonCodeDimensions" created to update the Dimension based on the Free Reason Code Default Dimensions
    HEI.11 FDD RTRGAP071 IBM POSTOI01 24.04.2018
      # Added code to update "use duplication list" field
    HEI.12 IBM HORTOC01 01.08.2018 - change function
    HEI.12 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
      # New Field created: 50016 - "TIN No."
      # New Functions created: CheckTINNoMandatory, UpdateTINBAndVATProdPostGrByLocation, CheckDifferentTINNo
    HEI.14 BA-RTRGAP01 IBM NASTAA02 16.10.2018 # Bahamas VAT
      # VAT Prod. Posting Group depending on TIN By Location should apply to every Sales Document
    HEI.15 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
      # New Field created: 50017 - UnAvailable Inv. (Whse)
    HEI.17 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2019 # Maraki POS Interface
      # New Field created: 50018 - Suppress POS Interface
    HEI.18 FDD-HT709 IBM NASTAA02 24.07.2019 # Ethiopia Fiscal No in PSIL
      # New Field created: 50019 - Maraki Fiscal No
    HEI.19 FDD-HT581 IBM SURYAS01 08.08.2019 # Added code in "Free Item - OnValidate()" and "Free reason code-Onvalidate()" trigger
    HEI.20 FDD-HB564 IBM GUNERE01 21.08.2019 # Added code in "No. - OnValidate()"
                                  01.10.2019 # Added code in "No. - OnValidate()"
                                  21.10.2019 # commented line in No. - OnValidate()
    HEI.21 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019
      #new fields created:  50020 - EDI unit of measure, 50021 - Product GTIN code
    HEI.22 Defect 4703 IBM.GUNERE01 31.10.2019 # Quantity - OnValidate() func. modified
    HEI.24 Defect #4931 IBM NASTAA02 18.03.2020 # Not possible to Post Receipt of a Promotion line
      # "Qty. to Ship" should not take the value of "Outstanding Qty." for Item Charges on Return Orders
    HEI.25 Defet #5411  IBM SURYAS01 26/03/2020
      #Modified the code in "Free Reason Code - OnValidate()" Trigger
    HEI.26 CHG2060654 IBM KUMARN15 16.04.2020
      # added new fields "Is Reduced Return" and "Reduced Return Factor"
    HEI.27 CHG2060654 IBM KUMARN15 10.09.2020
      # MaintainSIFTIndex property set to No for following Keys
      - Document Type,Document No.,Attached to Line No.,Collapse
      - Document Type,Document No.,Item Charge Type,Empty Goods Item No.,Attached to Line No.
      - Document Type,No.,Type,Delayed Sequence No.
    HEI.28 Defect # 6018 CHG2055070 IBM.GUNERE01 14.10.2020 # Unit Price - OnValidate modified.
    HEI.29 CHG2074002 IBM BULIMC01 21/12/2020 #Free Goods Accounting - Code added to "No. - OnValidate" to take the "Customer DTax Group Code" from the FreeReason table
    HEI.30 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
      # Code added on functions 'UpdateCharges' and 'InsertCharges' to skip insertion of charges for LSR Orders
      # Code added on functions 'UpdateItemChargeAssgnt' and 'SaveItemChargeAssgnt' to skip insertio of Item Charge Assignment Sales for LSR Orders
    CHG2104608 DITW111.00.13 ISL 18/12/2018 NRQ#96024 Deleted field 2014461 "Prod. BOM Version Code"
    HEI.31 CHG2100218 IBM SAXENA03 25.03.2021
      # Added SETCURRENTKEY() in function AutoSuggestItemChargeAssgnt() & UpdateItemChargeAssgnt()
      # Replaced FINDSET with FINDSET(FALSE,FALSE) in UpdateItemChargeAssgnt()
    HEI.32 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
      # New Field created 50024 - CAD Amount
      # Code added on functions "CalcVATAmountLines", "UpdateVATOnLines"
    HEI.33 CHG2109621 HT2170 IBM GAVANM01 10.06.2021 - Posting Setup for Sales Tax (Timbre), transport, free products
      # Added field: 50025 - Timbre applied
      # new global function Get_blnChangedfromHeader
    HEI.34 CHG2119178 IBM.AS 30.06.2021
      # HeiLite Base Stability Changes for Posting functions at JOB NAS
      # Adding GUIAllowed function added in Functions Appl.-to Item Entry - OnValidate(),
      CheckWarehouse() , Description - OnValidate(),
      AutoReserve(), ConfirmShippedReceivedItemDimChange(), AllItemsAvailability()
    HEI.35 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
      # Code added
    HEI.36 CHG2123219 BHATTA09 08.12.2021
      # Code added for getting SKU CCC Dimension
    HEI.37 PRB2007691 MARTIR52 13.07.2022
      # Code commented to fix Delayed Promotion orders issue on Panama (Only Panama using Delayed feature)
    HEI.38 CHG2188015 DEBUSD01 10.01.2023 Qty to Ship behavior on promotionline partialShipments
      # merge NRQ#102424
    HEI.39 CHG2178940 IBM COSTES04  16.01.2023 # Add Required Freshness field on Customer Card
      # Add new field RFreshness Date (min)
    HEI.40 CHG2190680 DEBUSD01 30.01.2023 PO creation treatment shipcost quantity error
    HEI.41 CHG2200362 IBM COSTES04 30.05.2023 Updating Return reasons Code
      # Update table relation for Return Reason Code
    HEI.42 CHG2295557 IBM ADHIKG01 18.03.2025 Quantity updation issue on Charge Item for Empty Goods case
      # Aptean Fix
      # NRQ#276136 DDR 12/03/2025 Fix to update quantity attached lines of item empty good without unit price
    */
    // BC Upgrade BHARDA11 >>
    // 1. InitQtyToShip There are some //HEI.24> Code in this function but that code uder //<< DITW18.00.07 VSC 13/01/2016 DIT-770 #1745
    // 2. Block Code  //HEI.35>> //HEI.32>> Because VAT Line Amount table habe some comment As per discussion with Saikat and Sakshi, For now putting this object on hold because CAD functionality is running only in CONGO opco.
    // 3. Remove DRINK-IT Related Code.
    // 4. For No. - OnValidate() (//WHT) , We suscribe this event OnAfterAssignGLAccountValues
    // 5. For No. - OnValidate() Type - Item Customize Code ( //HEI.07>>,//WHT) , we suscribe this event OnBeforeCopyFromItem.
    // 6. For No. - OnValidate() Type - Resource Customize Code  (//WHT) , we suscribe this event OnCopyFromResourceOnBeforeApplyResUnitCost.
    // 7. For No. - OnValidate() Type - "Charge (Item)"  Customize Code (//WHT), We suscribe this event OnAfterAssignItemChargeValues
    // 8. For No. - OnValidate() Customize Code (//WHT), We suscribe this event OnAfterAssignFieldsForNo 
    // 9. For Quantity - OnValidate() Customize Code (//HEI.14>>), We suscribe this event OnValidateQuantityOnBeforeCheckAssocPurchOrder.
    // 10. For "Appl.-to Item Entry" - OnValidate() Customize Code (//>>HEI.34), we suscribe this event OnApplToItemEntryValidateOnBeforeMessage.
    // 11. For "VAT Prod. Posting Group" - OnValidate() Customize Code (//HEI.14) , We Suscribe this event OnValidateVATProdPostingGroupOnBeforeVATPostingSetupGet
    // 12. For "Depreciation Book Code" - OnValidate() Customize Code (//HEI.11>>) , We Suscribe this event OnAfterGetFAPostingGroup
    // 13. For Function UpdateItemChargeAssgnt() Customize Code (//HEI.30>>) , We Suscribe this event OnBeforeUpdateItemChargeAssgnt
    // 14. For Function UpdateVATOnLines Customize Code (//HEI.32>>) , We Suscribe this event OnUpdateVATOnLinesOnBeforeModifySalesLine
    // 15. For Function LOCAL CheckWarehouse() Customize Code (//>>HEI.34), , We Suscribe this event OnCheckWarehouseOnBeforeShowDialog
    // BC Upgrade BHARDA11 <<

    // BC Upgrade PATELS08 >>
    //   # Added Table Relation for "Return Reason Code" as per HEI.41
    // BC Upgrade PATELS08 <<

    // BC Upgrade SHUKLP03 >> Subscribed event OnAfterCopyFromItem to add code of No. onvalidate in codeunit HeinekenTableCu. 

    fields
    {
        modify("Document Type")
        {
            CaptionML = ENU = 'Document Type', FRA = 'Type document';
            //OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', FRA = 'Devis,Commande,Facture,Avoir,Commande ouverte,Retour';
        }
        modify("Sell-to Customer No.")
        {
            CaptionML = ENU = 'Sell-to Customer No.', FRA = 'N° donneur d''ordre';
        }
        modify("Document No.")
        {

            //Unsupported feature: Change TableRelation on ""Document No."(Field 3)". Please convert manually.

            CaptionML = ENU = 'Document No.', FRA = 'N° document';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)', FRA = ' ,Compte général,Article,Ressource,Immobilisation,Frais annexes';
        }
        modify("No.")
        {
            //Unsupported feature: Change TableRelation on ""No."(Field 6)". Please convert manually.

            CaptionML = ENU = 'No.', FRA = 'N°';
            trigger OnBeforeValidate()
            var
            // FreeReasonCode: Record 2013788; // BC Upgrade BHARDA11 ----Drink-IT Table (FreeReasonCode)
            begin
                // BC Upgrade BHARDA11 >> ----Drink-IT Table (FreeReasonCode) and Field ( "Customer DTax Group Code")
                // if Rec.Type = Rec.Type::Item then begin
                //     //HEI.29>>
                //     IF (FreeReasonCode.GET("Free Reason Code")) AND (FreeReasonCode."Customer DTax Group Code" <> '') THEN
                //         "Customer DTax Group Code" := FreeReasonCode."Customer DTax Group Code"
                //     ELSE
                //         "Customer DTax Group Code" := GetCustTaxGroupCode("Customer DTax Group Code", "Item DTax Group Code");
                //     IF ("Customer DTax Group Code" <> '') AND ("Customer DTax Group Code" <> SalesHeader."Customer DTax Group Code") THEN
                //         TestCustTaxRegHeader();
                //     //HEI.29<<
                // end;
            end;
            //BC UPGRADE KUMARR78 FDD-MTC-008 >>
            trigger OnAfterValidate()
            var
                RecGLAccount: Record "G/L Account";
                RecItemCharges: Record "Item Charge";
            begin
                if "No." <> '' then begin
                    if Type = Type::"G/L Account" then begin
                        if RecGLAccount.Get("No.") then
                            "Show Item charge on Inv. FND" := RecGLAccount."Show Item charge on Inv. FND";
                    end;
                    if Type = Type::"Charge (Item)" then begin
                        if RecItemCharges.Get("No.") then
                            "Show Item charge on Inv. FND" := RecItemCharges."Show Item charge on Inv. FND";
                    end;
                end;
            end;
            //BC UPGRADE KUMARR78 FDD-MTC-008 <<

        }
        modify("Location Code")
        {
            // TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
            //                                                                      Code = FIELD("Location Table Filter")); // BC Upgrade BHARDA11 ----Drink-IT Field ("Location Table Filter")
            //Unsupported feature: Change TableRelation on ""Location Code"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
            trigger OnAfterValidate()
            var
                SKU: Record "Stockkeeping Unit";
                Item: Record Item;
            begin
                UpdateTINBAndVATProdPostGrByLocation();//HEI.14
                if Rec.Type = Rec.Type::Item then
                    if Item.Get("No.") then;
                if GetSKU(SKU) then begin
                    //HEI.07>>
                    "RPM Solution FND" := SKU."RPM Solution FND".AsInteger();
                    "RPM Type FND" := SKU."RPM Type FND";
                    "Item Type FND" := SKU."Item Type FND".AsInteger();
                    //HEI.07<<
                end else begin
                    //HEI.07>>
                    "RPM Solution FND" := Item."RPM Solution FND".AsInteger();
                    "RPM Type FND" := Item."RPM Type FND";
                    "Item Type FND" := Item."Item Type FND".AsInteger();
                    //HEI.07<<
                end;
            end;
        }
        modify("Posting Group")
        {

            //Unsupported feature: Change TableRelation on ""Posting Group"(Field 8)". Please convert manually.

            CaptionML = ENU = 'Posting Group', FRA = 'Groupe comptabilisation';
        }
        modify("Shipment Date")
        {
            CaptionML = ENU = 'Shipment Date', FRA = 'Date de préparation';
        }
        modify(Description)
        {

            //Unsupported feature: Change TableRelation on "Description(Field 11)". Please convert manually.

            CaptionML = ENU = 'Description', FRA = 'Désignation';

            //Unsupported feature: Change Description on "Description(Field 11)". Please convert manually.
            // BC Upgrade BHARDA11 >> --  There is no event for consider this code
            /*  //>>HEI.34
        IF GUIALLOWED THEN BEGIN
        //<<HEI.34
          IF CONFIRM(AnotherItemWithSameDescrQst,FALSE,Item."No.",Item.Description) THEN
            VALIDATE("No.",Item."No.");
          EXIT;
        //>>HEI.34
        END ELSE BEGIN
          VALIDATE("No.",Item."No.");
          EXIT;
        END;
        //<<HEI.34 */
            // BC Upgrade BHARDA11 << There is no event for consider this code

        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Unit of Measure")
        {
            CaptionML = ENU = 'Unit of Measure', FRA = 'Unité';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
            trigger OnBeforeValidate()
            begin
                //HEI.14>>
                IF "TIN No. FND" = '' THEN
                    UpdateTINBAndVATProdPostGrByLocation();
                //HEI.14<<
            end;
            // BC Upgrade BHARDA11 >>--- There is some //HEI.01>> coed inside DRINK-IT Code // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #691 so we can not consider that code 
            /*  //HEI.01>>
   InsertEmpts2SalesLnWithChrgItm.DeleteAllEmptesAttachedChargeSalesLines(Rec,TRUE);
   //DeleteAllEmptesAttachedChargeSalesLines(Rec,TRUE);
   //HEI.01<< */
            // BC Upgrade BHARDA11 <<--- There is some //HEI.01>> coed inside DRINK-IT Code // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #691 so we can not consider that code 

        }
        modify("Outstanding Quantity")
        {
            CaptionML = ENU = 'Outstanding Quantity', FRA = 'Quantité restante';
        }
        modify("Qty. to Invoice")
        {
            CaptionML = ENU = 'Qty. to Invoice', FRA = 'Qté à facturer';
        }
        modify("Qty. to Ship")
        {
            CaptionML = ENU = 'Qty. to Ship', FRA = 'Qté à expédier';
        }
        modify("Unit Price")
        {
            CaptionML = ENU = 'Unit Price', FRA = 'Prix unitaire';

            //Unsupported feature: Change AutoFormatExpr on ""Unit Price"(Field 22)". Please convert manually.


            //Unsupported feature: Change Description on ""Unit Price"(Field 22)". Please convert manually.

        }
        modify("Unit Cost (LCY)")
        {
            CaptionML = ENU = 'Unit Cost (LCY)', FRA = 'Coût unitaire DS';

            //Unsupported feature: Change Description on ""Unit Cost (LCY)"(Field 23)". Please convert manually.


            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost (LCY)"(Field 23)". Please convert manually.

        }
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
        }
        modify("Line Discount %")
        {
            CaptionML = ENU = 'Line Discount %', FRA = '% remise ligne';
        }
        modify("Line Discount Amount")
        {
            CaptionML = ENU = 'Line Discount Amount', FRA = 'Montant remise ligne';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("Amount Including VAT")
        {
            CaptionML = ENU = 'Amount Including VAT', FRA = 'Montant TTC';
        }
        modify("Allow Invoice Disc.")
        {

            //Unsupported feature: Change InitValue on ""Allow Invoice Disc."(Field 32)". Please convert manually.

            CaptionML = ENU = 'Allow Invoice Disc.', FRA = 'Remise facture autorisée';
        }
        modify("Gross Weight")
        {
            CaptionML = ENU = 'Gross Weight', FRA = 'Poids brut';
        }
        modify("Net Weight")
        {
            CaptionML = ENU = 'Net Weight', FRA = 'Poids net';
        }
        modify("Units per Parcel")
        {
            CaptionML = ENU = 'Units per Parcel', FRA = 'Conditionnement';
        }
        modify("Unit Volume")
        {
            CaptionML = ENU = 'Unit Volume', FRA = 'Volume unitaire';
        }
        modify("Appl.-to Item Entry")
        {
            CaptionML = ENU = 'Appl.-to Item Entry', FRA = 'Écr. article à lettrer';
            // BC Upgrade BHARDA11 --- Custom code is in Codeunit
        }
        modify("Shortcut Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 1 Code"(Field 40)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 1 Code', FRA = 'Code raccourci axe 1';
        }
        modify("Shortcut Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Shortcut Dimension 2 Code"(Field 41)". Please convert manually.

            CaptionML = ENU = 'Shortcut Dimension 2 Code', FRA = 'Code raccourci axe 2';
        }
        modify("Customer Price Group")
        {
            CaptionML = ENU = 'Customer Price Group', FRA = 'Groupe prix client';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify("Work Type Code")
        {
            CaptionML = ENU = 'Work Type Code', FRA = 'Code type travail';
        }
        modify("Recalculate Invoice Disc.")
        {
            CaptionML = ENU = 'Recalculate Invoice Disc.', FRA = 'Recalculer remise facture';
        }
        modify("Outstanding Amount")
        {
            CaptionML = ENU = 'Outstanding Amount', FRA = 'Montant en commande';
        }
        modify("Qty. Shipped Not Invoiced")
        {
            CaptionML = ENU = 'Qty. Shipped Not Invoiced', FRA = 'Qté livrée non facturée';
        }
        modify("Shipped Not Invoiced")
        {
            CaptionML = ENU = 'Shipped Not Invoiced', FRA = 'Livré non facturé';
        }
        modify("Quantity Shipped")
        {
            CaptionML = ENU = 'Quantity Shipped', FRA = 'Qté expédiée';
        }
        modify("Quantity Invoiced")
        {
            CaptionML = ENU = 'Quantity Invoiced', FRA = 'Quantité facturée';
        }
        modify("Shipment No.")
        {
            CaptionML = ENU = 'Shipment No.', FRA = 'N° livraison';
        }
        modify("Shipment Line No.")
        {
            CaptionML = ENU = 'Shipment Line No.', FRA = 'N° ligne livraison';
        }
        modify("Profit %")
        {
            CaptionML = ENU = 'Profit %', FRA = '% marge sur vente';
        }
        modify("Bill-to Customer No.")
        {
            CaptionML = ENU = 'Bill-to Customer No.', FRA = 'N° client facturé';
        }
        modify("Inv. Discount Amount")
        {
            CaptionML = ENU = 'Inv. Discount Amount', FRA = 'Montant remise facture';
        }
        modify("Purchase Order No.")
        {

            //Unsupported feature: Change TableRelation on ""Purchase Order No."(Field 71)". Please convert manually.

            CaptionML = ENU = 'Purchase Order No.', FRA = 'N° commande achat';
        }
        modify("Purch. Order Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Purch. Order Line No."(Field 72)". Please convert manually.

            CaptionML = ENU = 'Purch. Order Line No.', FRA = 'N° ligne commande achat';
        }
        modify("Drop Shipment")
        {
            CaptionML = ENU = 'Drop Shipment', FRA = 'Livraison directe';
        }
        modify("Gen. Bus. Posting Group")
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group', FRA = 'Groupe compta. marché';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify("VAT Calculation Type")
        {
            CaptionML = ENU = 'VAT Calculation Type', FRA = 'Mode calcul TVA';
            //OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("Transaction Type")
        {
            CaptionML = ENU = 'Transaction Type', FRA = 'Nature transaction';
        }
        modify("Transport Method")
        {
            CaptionML = ENU = 'Transport Method', FRA = 'Mode de transport';
        }
        modify("Attached to Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Attached to Line No."(Field 80)". Please convert manually.

            CaptionML = ENU = 'Attached to Line No.', FRA = 'Attaché à la ligne n°';
        }
        modify("Exit Point")
        {
            CaptionML = ENU = 'Exit Point', FRA = 'Pays destination';
        }
        modify("Area")
        {
            CaptionML = ENU = 'Area', FRA = 'Dépt destination/provenance';
        }
        modify("Transaction Specification")
        {
            CaptionML = ENU = 'Transaction Specification', FRA = 'Régime';
        }
        modify("Tax Category")
        {
            CaptionML = ENU = 'Tax Category', FRA = 'Catégorie de taxe';
        }
        modify("Tax Area Code")
        {
            CaptionML = ENU = 'Tax Area Code', FRA = 'Code zone recouvrement';
        }
        modify("Tax Liable")
        {
            CaptionML = ENU = 'Tax Liable', FRA = 'Soumis à recouvrement';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("VAT Clause Code")
        {
            CaptionML = ENU = 'VAT Clause Code', FRA = 'Code clause TVA';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
            trigger OnBeforeValidate()
            begin
                UpdateTINBAndVATProdPostGrByLocation(); //HEI.14
            end;
        }
        modify("Currency Code")
        {
            CaptionML = ENU = 'Currency Code', FRA = 'Code devise';
        }
        modify("Outstanding Amount (LCY)")
        {
            CaptionML = ENU = 'Outstanding Amount (LCY)', FRA = 'Montant en commande DS';
        }
        modify("Shipped Not Invoiced (LCY)")
        {
            CaptionML = ENU = 'Shipped Not Invoiced (LCY)', FRA = 'Livré non facturé DS';
        }
        modify("Reserved Quantity")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Quantity"(Field 95)". Please convert manually.

            CaptionML = ENU = 'Reserved Quantity', FRA = 'Quantité réservée';
        }
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
            //OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
        }
        modify("Blanket Order No.")
        {

            //Unsupported feature: Change TableRelation on ""Blanket Order No."(Field 97)". Please convert manually.

            CaptionML = ENU = 'Blanket Order No.', FRA = 'N° commande ouverte';
        }
        modify("Blanket Order Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Blanket Order Line No."(Field 98)". Please convert manually.

            CaptionML = ENU = 'Blanket Order Line No.', FRA = 'N° ligne cde ouverte';
        }
        modify("VAT Base Amount")
        {
            CaptionML = ENU = 'VAT Base Amount', FRA = 'Montant base TVA';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';

            //Unsupported feature: Change AutoFormatExpr on ""Unit Cost"(Field 100)". Please convert manually.


            //Unsupported feature: Change Description on ""Unit Cost"(Field 100)". Please convert manually.

        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = 'Écriture système';
        }
        modify("Line Amount")
        {
            CaptionML = ENU = 'Line Amount', FRA = 'Montant ligne';
        }
        modify("VAT Difference")
        {
            CaptionML = ENU = 'VAT Difference', FRA = 'Différence TVA';
        }
        modify("Inv. Disc. Amount to Invoice")
        {
            CaptionML = ENU = 'Inv. Disc. Amount to Invoice', FRA = 'Montant rem. fact. à facturer';
        }
        modify("VAT Identifier")
        {
            CaptionML = ENU = 'VAT Identifier', FRA = 'Identifiant TVA';
        }
        modify("IC Partner Ref. Type")
        {
            CaptionML = ENU = 'IC Partner Ref. Type', FRA = 'Type de réf. du partenaire IC';
            //OptionCaptionML = ENU = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.', FRA = ' ,Compte général,Article,,,Frais annexes,Référence externe,N° article commun';
        }
        modify("IC Partner Reference")
        {
            CaptionML = ENU = 'IC Partner Reference', FRA = 'Référence du partenaire IC';
        }
        modify("Prepayment %")
        {
            CaptionML = ENU = 'Prepayment %', FRA = '% acompte';
        }
        modify("Prepmt. Line Amount")
        {
            CaptionML = ENU = 'Prepmt. Line Amount', FRA = 'Montant ligne acompte';
        }
        modify("Prepmt. Amt. Inv.")
        {
            CaptionML = ENU = 'Prepmt. Amt. Inv.', FRA = 'Fact. montant acompte';
        }
        modify("Prepmt. Amt. Incl. VAT")
        {
            CaptionML = ENU = 'Prepmt. Amt. Incl. VAT', FRA = 'Montant acompte TTC';
        }
        modify("Prepayment Amount")
        {
            CaptionML = ENU = 'Prepayment Amount', FRA = 'Montant acompte';
        }
        modify("Prepmt. VAT Base Amt.")
        {
            CaptionML = ENU = 'Prepmt. VAT Base Amt.', FRA = 'Montant base TVA acompte';
        }
        modify("Prepayment VAT %")
        {
            CaptionML = ENU = 'Prepayment VAT %', FRA = '% TVA acompte';
        }
        modify("Prepmt. VAT Calc. Type")
        {
            CaptionML = ENU = 'Prepmt. VAT Calc. Type', FRA = 'Mode calc. TVA acompte';
            //OptionCaptionML = ENU = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', FRA = 'Normal,Intracomm.,Correctif,Sales Tax';
        }
        modify("Prepayment VAT Identifier")
        {
            CaptionML = ENU = 'Prepayment VAT Identifier', FRA = 'Identifiant TVA acompte';
        }
        modify("Prepayment Tax Area Code")
        {
            CaptionML = ENU = 'Prepayment Tax Area Code', FRA = 'Code zone recouvrement acompte';
        }
        modify("Prepayment Tax Liable")
        {
            CaptionML = ENU = 'Prepayment Tax Liable', FRA = 'Acompte soumis à recouvrement';
        }
        modify("Prepayment Tax Group Code")
        {
            CaptionML = ENU = 'Prepayment Tax Group Code', FRA = 'Code groupe taxes acompte';
        }
        modify("Prepmt Amt to Deduct")
        {
            CaptionML = ENU = 'Prepmt Amt to Deduct', FRA = 'Montant acompte à déduire';
        }
        modify("Prepmt Amt Deducted")
        {
            CaptionML = ENU = 'Prepmt Amt Deducted', FRA = 'Montant acompte déduit';
        }
        modify("Prepayment Line")
        {
            CaptionML = ENU = 'Prepayment Line', FRA = 'Ligne acompte';
        }
        modify("Prepmt. Amount Inv. Incl. VAT")
        {
            CaptionML = ENU = 'Prepmt. Amount Inv. Incl. VAT', FRA = 'Fact. montant acompte TTC';
        }
        modify("Prepmt. Amount Inv. (LCY)")
        {
            CaptionML = ENU = 'Prepmt. Amount Inv. (LCY)', FRA = 'Montant acompte facturé DS';
        }
        modify("IC Partner Code")
        {
            CaptionML = ENU = 'IC Partner Code', FRA = 'Code du partenaire IC';
        }
        modify("Prepmt. VAT Amount Inv. (LCY)")
        {
            CaptionML = ENU = 'Prepmt. VAT Amount Inv. (LCY)', FRA = 'Montant TVA acompte facturé DS';
        }
        modify("Prepayment VAT Difference")
        {
            CaptionML = ENU = 'Prepayment VAT Difference', FRA = 'Différence TVA acompte';
        }
        modify("Prepmt VAT Diff. to Deduct")
        {
            CaptionML = ENU = 'Prepmt VAT Diff. to Deduct', FRA = 'Différence TVA acompte à déduire';
        }
        modify("Prepmt VAT Diff. Deducted")
        {
            CaptionML = ENU = 'Prepmt VAT Diff. Deducted', FRA = 'Différence TVA acompte déduite';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Qty. to Assemble to Order")
        {
            CaptionML = ENU = 'Qty. to Assemble to Order', FRA = 'Qté vers Assemblage à la commande';
        }
        modify("Qty. to Asm. to Order (Base)")
        {
            CaptionML = ENU = 'Qty. to Asm. to Order (Base)', FRA = 'Qté vers Assemblage à la commande (base)';
        }
        modify("ATO Whse. Outstanding Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""ATO Whse. Outstanding Qty."(Field 902)". Please convert manually.

            CaptionML = ENU = 'ATO Whse. Outstanding Qty.', FRA = 'Qté restante entrepôt ATO';
        }
        modify("ATO Whse. Outstd. Qty. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""ATO Whse. Outstd. Qty. (Base)"(Field 903)". Please convert manually.

            CaptionML = ENU = 'ATO Whse. Outstd. Qty. (Base)', FRA = 'Qté restante entrepôt ATO (base)';
        }
        modify("Job Task No.")
        {

            //Unsupported feature: Change TableRelation on ""Job Task No."(Field 1001)". Please convert manually.

            CaptionML = ENU = 'Job Task No.', FRA = 'N° tâche projet';
        }
        modify("Job Contract Entry No.")
        {
            CaptionML = ENU = 'Job Contract Entry No.', FRA = 'N° séquence contrat projet';
        }
        modify("Posting Date")
        {

            //Unsupported feature: Change CalcFormula on ""Posting Date"(Field 1300)". Please convert manually.

            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Deferral Code")
        {
            CaptionML = ENU = 'Deferral Code', FRA = 'Code échelonnement';
        }
        modify("Returns Deferral Start Date")
        {
            CaptionML = ENU = 'Returns Deferral Start Date', FRA = 'Renvoie la date de début de l''échelonnement';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5402)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Bin Code")
        {

            //Unsupported feature: Change TableRelation on ""Bin Code"(Field 5403)". Please convert manually.

            CaptionML = ENU = 'Bin Code', FRA = 'Code emplacement';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify(Planned)
        {
            CaptionML = ENU = 'Planned', FRA = 'Planifié';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Quantity (Base)")
        {
            CaptionML = ENU = 'Quantity (Base)', FRA = 'Quantité (base)';
        }
        modify("Outstanding Qty. (Base)")
        {
            CaptionML = ENU = 'Outstanding Qty. (Base)', FRA = 'Quantité ouverte (base)';
        }
        modify("Qty. to Invoice (Base)")
        {
            CaptionML = ENU = 'Qty. to Invoice (Base)', FRA = 'Qté à facturer (base)';
        }
        modify("Qty. to Ship (Base)")
        {
            CaptionML = ENU = 'Qty. to Ship (Base)', FRA = 'Qté à expédier (base)';
        }
        modify("Qty. Shipped Not Invd. (Base)")
        {
            CaptionML = ENU = 'Qty. Shipped Not Invd. (Base)', FRA = 'Qté livrée non facturée (base)';
        }
        modify("Qty. Shipped (Base)")
        {
            CaptionML = ENU = 'Qty. Shipped (Base)', FRA = 'Qté expédiée (base)';
        }
        modify("Qty. Invoiced (Base)")
        {
            CaptionML = ENU = 'Qty. Invoiced (Base)', FRA = 'Quantité facturée (base)';
        }
        modify("Reserved Qty. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. (Base)"(Field 5495)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. (Base)', FRA = 'Quantité réservée (base)';
        }
        modify("FA Posting Date")
        {
            CaptionML = ENU = 'FA Posting Date', FRA = 'Date compta. immo.';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("Depr. until FA Posting Date")
        {
            CaptionML = ENU = 'Depr. until FA Posting Date', FRA = 'Amort. jusqu''à date compta.';
        }
        modify("Duplicate in Depreciation Book")
        {
            CaptionML = ENU = 'Duplicate in Depreciation Book', FRA = 'Dupliquer dans journaux amort.';
        }
        modify("Use Duplication List")
        {
            CaptionML = ENU = 'Use Duplication List', FRA = 'Utiliser liste duplication';
        }
        modify("Responsibility Center")
        {

            //Unsupported feature: Change TableRelation on ""Responsibility Center"(Field 5700)". Please convert manually.

            CaptionML = ENU = 'Responsibility Center', FRA = 'Centre de gestion';
        }
        modify("Out-of-Stock Substitution")
        {
            CaptionML = ENU = 'Out-of-Stock Substitution', FRA = 'Substitution sur rupture';
        }
        modify("Substitution Available")
        {

            //Unsupported feature: Change CalcFormula on ""Substitution Available"(Field 5702)". Please convert manually.

            CaptionML = ENU = 'Substitution Available', FRA = 'Substitut disponible';
        }
        modify("Originally Ordered No.")
        {
            CaptionML = ENU = 'Originally Ordered No.', FRA = 'N° article substitué';
        }
        modify("Originally Ordered Var. Code")
        {

            //Unsupported feature: Change TableRelation on ""Originally Ordered Var. Code"(Field 5704)". Please convert manually.

            CaptionML = ENU = 'Originally Ordered Var. Code', FRA = 'Code variante substitué';
        }
        //BCUPGRADE>>
        /*
        modify("Cross-Reference No.")
        {
            CaptionML = ENU='Cross-Reference No.',FRA='Référence externe';
        }
        modify("Unit of Measure (Cross Ref.)")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure (Cross Ref.)"(Field 5706)". Please convert manually.

            CaptionML = ENU='Unit of Measure (Cross Ref.)',FRA='Unité référence externe';
        }
        modify("Cross-Reference Type")
        {
            CaptionML = ENU='Cross-Reference Type',FRA='Type référence externe';
            OptionCaptionML = ENU=' ,Customer,Vendor,Bar Code',FRA=' ,Client,Fournisseur,Code barre';
        }
        modify("Cross-Reference Type No.")
        {
            CaptionML = ENU='Cross-Reference Type No.',FRA='N° type référence externe';
        }
        */
        //BCUPGRADE<<
        modify("Item Category Code")
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
        }
        modify(Nonstock)
        {
            CaptionML = ENU = 'Nonstock', FRA = 'Non stocké';
        }
        modify("Purchasing Code")
        {
            CaptionML = ENU = 'Purchasing Code', FRA = 'Procédure achat';
        }
        //BCUPGRADE>>
        /*
        modify("Product Group Code")
        {

            //Unsupported feature: Change TableRelation on ""Product Group Code"(Field 5712)". Please convert manually.

            CaptionML = ENU='Product Group Code',FRA='Code groupe produits';
        }
        */
        //BCUPGRADE<<
        modify("Special Order")
        {
            CaptionML = ENU = 'Special Order', FRA = 'Commande spéciale';
        }
        modify("Special Order Purchase No.")
        {

            //Unsupported feature: Change TableRelation on ""Special Order Purchase No."(Field 5714)". Please convert manually.

            CaptionML = ENU = 'Special Order Purchase No.', FRA = 'N° achat cde spéciale';
        }
        modify("Special Order Purch. Line No.")
        {

            //Unsupported feature: Change TableRelation on ""Special Order Purch. Line No."(Field 5715)". Please convert manually.

            CaptionML = ENU = 'Special Order Purch. Line No.', FRA = 'N° ligne achat cde spéciale';
        }
        modify("Whse. Outstanding Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""Whse. Outstanding Qty."(Field 5749)". Please convert manually.

            CaptionML = ENU = 'Whse. Outstanding Qty.', FRA = 'Qté restante entrepôt';
        }
        modify("Whse. Outstanding Qty. (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Whse. Outstanding Qty. (Base)"(Field 5750)". Please convert manually.

            CaptionML = ENU = 'Whse. Outstanding Qty. (Base)', FRA = 'Qté restante entrepôt (base)';
        }
        modify("Completely Shipped")
        {
            CaptionML = ENU = 'Completely Shipped', FRA = 'Entièrement expédiée';
        }
        modify("Requested Delivery Date")
        {
            CaptionML = ENU = 'Requested Delivery Date', FRA = 'Date livraison demandée';
        }
        modify("Promised Delivery Date")
        {
            CaptionML = ENU = 'Promised Delivery Date', FRA = 'Date livraison confirmée';
        }
        modify("Shipping Time")
        {
            CaptionML = ENU = 'Shipping Time', FRA = 'Délai d''expédition';
        }
        modify("Outbound Whse. Handling Time")
        {
            CaptionML = ENU = 'Outbound Whse. Handling Time', FRA = 'Délai désenlogement';
        }
        modify("Planned Delivery Date")
        {
            CaptionML = ENU = 'Planned Delivery Date', FRA = 'Date livraison planifiée';
        }
        modify("Planned Shipment Date")
        {
            CaptionML = ENU = 'Planned Shipment Date', FRA = 'Date d''expédition planifiée';
        }
        modify("Shipping Agent Code")
        {
            CaptionML = ENU = 'Shipping Agent Code', FRA = 'Code transporteur';
        }
        modify("Shipping Agent Service Code")
        {

            //Unsupported feature: Change TableRelation on ""Shipping Agent Service Code"(Field 5797)". Please convert manually.

            CaptionML = ENU = 'Shipping Agent Service Code', FRA = 'Code prestation transporteur';
        }
        modify("Allow Item Charge Assignment")
        {

            //Unsupported feature: Change InitValue on ""Allow Item Charge Assignment"(Field 5800)". Please convert manually.

            CaptionML = ENU = 'Allow Item Charge Assignment', FRA = 'Autoriser affectation frais annexes';
        }
        modify("Qty. to Assign")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. to Assign"(Field 5801)". Please convert manually.

            CaptionML = ENU = 'Qty. to Assign', FRA = 'Qté à affecter';
        }
        modify("Qty. Assigned")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. Assigned"(Field 5802)". Please convert manually.

            CaptionML = ENU = 'Qty. Assigned', FRA = 'Qté affectée';
        }
        modify("Return Qty. to Receive")
        {
            CaptionML = ENU = 'Return Qty. to Receive', FRA = 'Qté retour à recevoir';
        }
        modify("Return Qty. to Receive (Base)")
        {
            CaptionML = ENU = 'Return Qty. to Receive (Base)', FRA = 'Qté retour à recevoir (base)';
        }
        modify("Return Qty. Rcd. Not Invd.")
        {
            CaptionML = ENU = 'Return Qty. Rcd. Not Invd.', FRA = 'Qté retour reçue non facturée';
        }
        modify("Ret. Qty. Rcd. Not Invd.(Base)")
        {
            CaptionML = ENU = 'Ret. Qty. Rcd. Not Invd.(Base)', FRA = 'Qté ret. reçue non facturée (base)';
        }
        modify("Return Rcd. Not Invd.")
        {
            CaptionML = ENU = 'Return Rcd. Not Invd.', FRA = 'Réception retour non facturée';
        }
        modify("Return Rcd. Not Invd. (LCY)")
        {
            CaptionML = ENU = 'Return Rcd. Not Invd. (LCY)', FRA = 'Réception retour non facturée DS';
        }
        modify("Return Qty. Received")
        {
            CaptionML = ENU = 'Return Qty. Received', FRA = 'Qté retour reçue';
        }
        modify("Return Qty. Received (Base)")
        {
            CaptionML = ENU = 'Return Qty. Received (Base)', FRA = 'Qté retour reçue (base)';
        }
        modify("Appl.-from Item Entry")
        {
            CaptionML = ENU = 'Appl.-from Item Entry', FRA = 'Écriture article à lettrer';
        }
        modify("BOM Item No.")
        {
            CaptionML = ENU = 'BOM Item No.', FRA = 'N° article nomenclature';
        }
        modify("Return Receipt No.")
        {
            CaptionML = ENU = 'Return Receipt No.', FRA = 'N° réception retour';
        }
        modify("Return Receipt Line No.")
        {
            CaptionML = ENU = 'Return Receipt Line No.', FRA = 'N° ligne réception retour';
        }
        modify("Return Reason Code")
        {

            //Unsupported feature: Change TableRelation on ""Return Reason Code"(Field 6608)". Please convert manually.

            CaptionML = ENU = 'Return Reason Code', FRA = 'Code motif retour';

            //Unsupported feature: Change Description on ""Return Reason Code"(Field 6608)". Please convert manually.

            // BC Upgrade PATELS08 >> # Added Table Relation for Return Reason Code as per HEI.41
            //TableRelation = "Return Reason" where(Blocked = filter(false));
            // BC Upgrade PATELS08 <<
            // BC Upgrade SHUKLP03 >> Modified the OnLookup trigger of "Return Reason Code" field to filter out blocked return reasons in the lookup page, because we cannot modify base TableRelation.

            trigger OnBeforeValidate()
            var
                ReturnReason: Record "Return Reason";
            begin
                if "Return Reason Code" = '' then
                    exit;

                ReturnReason.Get("Return Reason Code");
                if ReturnReason."Blocked FND" then
                    Error('Return Reason %1 is blocked and cannot be used.', "Return Reason Code");
            end;
            // BC Upgrade SHUKLP03 << Modified the OnLookup trigger of "Return Reason Code" field to filter out blocked return reasons in the lookup page, because we cannot modify base TableRelation.

        }
        modify("Allow Line Disc.")
        {

            //Unsupported feature: Change InitValue on ""Allow Line Disc."(Field 7001)". Please convert manually.

            CaptionML = ENU = 'Allow Line Disc.', FRA = 'Autoriser remise ligne';
        }
        modify("Customer Disc. Group")
        {
            CaptionML = ENU = 'Customer Disc. Group', FRA = 'Groupe rem. client';
        }

        //Unsupported feature: CodeInsertion on "Type(Field 5).OnValidate". Please convert manually.

        //trigger (Variable: DitDiscountGr)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on "Type(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        GetSalesHeader;

        TESTFIELD("Qty. Shipped Not Invoiced",0);
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Shipment No.",'');

        TESTFIELD("Return Qty. Rcd. Not Invd.",0);
        TESTFIELD("Return Qty. Received",0);
        TESTFIELD("Return Receipt No.",'');

        TESTFIELD("Prepmt. Amt. Inv.",0);

        CheckAssocPurchOrder(FIELDCAPTION(Type));

        IF Type <> xRec.Type THEN BEGIN
          CASE xRec.Type OF
            Type::Item:
              BEGIN
                ATOLink.DeleteAsmFromSalesLine(Rec);
                IF Quantity <> 0 THEN BEGIN
                  SalesHeader.TESTFIELD(Status,SalesHeader.Status::Open);
                  CALCFIELDS("Reserved Qty. (Base)");
                  TESTFIELD("Reserved Qty. (Base)",0);
                  ReserveSalesLine.VerifyChange(Rec,xRec);
                  WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
                END;
              END;
            Type::"Fixed Asset":
              IF Quantity <> 0 THEN
                SalesHeader.TESTFIELD(Status,SalesHeader.Status::Open);
            Type::"Charge (Item)":
              DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
          END;
          IF xRec."Deferral Code" <> '' THEN
            DeferralUtilities.RemoveOrSetDeferralSchedule('',
              DeferralUtilities.GetSalesDeferralDocType,'','',
              xRec."Document Type",xRec."Document No.",xRec."Line No.",
              xRec.GetDeferralAmount,xRec."Posting Date",'',xRec."Currency Code",TRUE);
        END;
        AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
        TempSalesLine := Rec;
        INIT;
        IF xRec."Line Amount" <> 0 THEN
          "Recalculate Invoice Disc." := TRUE;

        Type := TempSalesLine.Type;
        "System-Created Entry" := TempSalesLine."System-Created Entry";
        "Currency Code" := SalesHeader."Currency Code";

        IF Type = Type::Item THEN
          "Allow Item Charge Assignment" := TRUE
        ELSE
          "Allow Item Charge Assignment" := FALSE;
        IF Type = Type::Item THEN BEGIN
          IF SalesHeader.InventoryPickConflict("Document Type","Document No.",SalesHeader."Shipping Advice") THEN
            ERROR(Text056,SalesHeader."Shipping Advice");
          IF SalesHeader.WhseShpmntConflict("Document Type","Document No.",SalesHeader."Shipping Advice") THEN
            ERROR(Text052,SalesHeader."Shipping Advice");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.26 DDR 31/10/2008
        TestDelayedLine();
        // >>DITW15.00.00.26 DDR
        // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        TestStatusModifyEmcs(FIELDCAPTION(Type));
        // >>DITW16.00.00.43 DDR DIT-715 #720

        #3..16
        if Type <> xRec.Type then begin
          case xRec.Type of
            Type::Item:
              begin
                ATOLink.DeleteAsmFromSalesLine(Rec);
                if Quantity <> 0 then begin
        #23..27
                end;
              end;
            Type::"Fixed Asset":
              if Quantity <> 0 then
        #32..34
          end;
          if xRec."Deferral Code" <> '' then
        #37..39
              xRec.GetDeferralAmount,xRec."Posting Date",'',xRec."Currency Code",true);
          // <<DITW15.00.00.36 DDR 18/11/2009 - DITW15.00.00.37 DDR 28/04/2010
          if (xRec.Type <> xRec.Type::"Charge (Item)") and xRec."Is Item Charge"  and
            (xRec."Item Charge Calculate per" <> xRec."Item Charge Calculate per"::Item)
          then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
          // >>DITW15.00.00.37 DDR
          // <<DITW15.00.00.01 DDR 15/01/2008 - DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.23 DDR 01/08/2008
          // <<DITW15.00.00.37 DDR 03/06/2010
          if (xRec.Type = xRec.Type::Item) and (CurrFieldNo <> 0) and
            (SalesHeader.Status <> SalesHeader.Status::Released)
          then
            DeleteAllChargeSalesLines(xRec,true);
          // >>DITW15.00.00.37 DDR
        end;
        #42..44
        if xRec."Line Amount" <> 0 then
          "Recalculate Invoice Disc." := true;
        #47..51
        if Type = Type::Item then
          "Allow Item Charge Assignment" := true
        else
          "Allow Item Charge Assignment" := false;
        if Type = Type::Item then begin
          if SalesHeader.InventoryPickConflict("Document Type","Document No.",SalesHeader."Shipping Advice") then
            ERROR(Text056,SalesHeader."Shipping Advice");
          if SalesHeader.WhseShpmntConflict("Document Type","Document No.",SalesHeader."Shipping Advice") then
            ERROR(Text052,SalesHeader."Shipping Advice");
        end;

        // <<DITW15.00.00.28 DDR 24/11/2008
        UpdateAADInfo();
        // >>DITW15.00.00.28 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""No."(Field 6).OnValidate". Please convert manually.

        //trigger "(Field 6)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "No." := FindNoFromTypedValue("No.");

        TestJobPlanningLine;
        TestStatusOpen;
        CheckItemAvailable(FIELDNO("No."));

        IF (xRec."No." <> "No.") AND (Quantity <> 0) THEN BEGIN
          TESTFIELD("Qty. to Asm. to Order (Base)",0);
          CALCFIELDS("Reserved Qty. (Base)");
          TESTFIELD("Reserved Qty. (Base)",0);
          IF Type = Type::Item THEN
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        END;

        TESTFIELD("Qty. Shipped Not Invoiced",0);
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Shipment No.",'');

        TESTFIELD("Prepmt. Amt. Inv.",0);

        TESTFIELD("Return Qty. Rcd. Not Invd.",0);
        TESTFIELD("Return Qty. Received",0);
        TESTFIELD("Return Receipt No.",'');

        IF "No." = '' THEN
          ATOLink.DeleteAsmFromSalesLine(Rec);
        CheckAssocPurchOrder(FIELDCAPTION("No."));
        AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

        TempSalesLine := Rec;
        INIT;
        IF xRec."Line Amount" <> 0 THEN
          "Recalculate Invoice Disc." := TRUE;
        Type := TempSalesLine.Type;
        "No." := TempSalesLine."No.";
        IF "No." = '' THEN
          EXIT;
        IF Type <> Type::" " THEN
          Quantity := TempSalesLine.Quantity;

        "System-Created Entry" := TempSalesLine."System-Created Entry";
        GetSalesHeader;
        InitHeaderDefaults(SalesHeader);
        CALCFIELDS("Substitution Available");

        "Promised Delivery Date" := SalesHeader."Promised Delivery Date";
        "Requested Delivery Date" := SalesHeader."Requested Delivery Date";
        "Shipment Date" :=
          CalendarMgmt.CalcDateBOC(
            '',
            SalesHeader."Shipment Date",
            CalChange."Source Type"::Location,
            "Location Code",
            '',
            CalChange."Source Type"::"Shipping Agent",
            "Shipping Agent Code",
            "Shipping Agent Service Code",
            FALSE);
        UpdateDates;

        CASE Type OF
          Type::" ":
            BEGIN
              StandardText.GET("No.");
              Description := StandardText.Description;
              "Allow Item Charge Assignment" := FALSE;
            END;
          Type::"G/L Account":
            BEGIN
              GLAcc.GET("No.");
              GLAcc.CheckGLAcc;
              IF NOT "System-Created Entry" THEN
                GLAcc.TESTFIELD("Direct Posting",TRUE);
              Description := GLAcc.Name;
              "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
              "Tax Group Code" := GLAcc."Tax Group Code";
              "Allow Invoice Disc." := FALSE;
              "Allow Item Charge Assignment" := FALSE;
              InitDeferralCode;
            END;
          Type::Item:
            BEGIN
              GetItem;
              Item.TESTFIELD(Blocked,FALSE);
              Item.TESTFIELD("Gen. Prod. Posting Group");
              IF Item.Type = Item.Type::Inventory THEN BEGIN
                Item.TESTFIELD("Inventory Posting Group");
                "Posting Group" := Item."Inventory Posting Group";
              END;
              Description := Item.Description;
              "Description 2" := Item."Description 2";
              GetUnitCost;
              "Allow Invoice Disc." := Item."Allow Invoice Disc.";
              "Units per Parcel" := Item."Units per Parcel";
              "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
              "Tax Group Code" := Item."Tax Group Code";
              "Item Category Code" := Item."Item Category Code";
              "Product Group Code" := Item."Product Group Code";
              Nonstock := Item."Created From Nonstock Item";
              "Profit %" := Item."Profit %";
              "Allow Item Charge Assignment" := TRUE;
              PrepaymentMgt.SetSalesPrepaymentPct(Rec,SalesHeader."Posting Date");

              IF SalesHeader."Language Code" <> '' THEN
                GetItemTranslation;

              IF Item.Reserve = Item.Reserve::Optional THEN
                Reserve := SalesHeader.Reserve
              ELSE
                Reserve := Item.Reserve;

              "Unit of Measure Code" := Item."Sales Unit of Measure";
              InitDeferralCode;
              SetDefaultItemQuantity;
            END;
          Type::Resource:
            BEGIN
              Res.GET("No.");
              Res.TESTFIELD(Blocked,FALSE);
              Res.TESTFIELD("Gen. Prod. Posting Group");
              Description := Res.Name;
              "Description 2" := Res."Name 2";
              "Unit of Measure Code" := Res."Base Unit of Measure";
              "Unit Cost (LCY)" := Res."Unit Cost";
              "Gen. Prod. Posting Group" := Res."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := Res."VAT Prod. Posting Group";
              "Tax Group Code" := Res."Tax Group Code";
              "Allow Item Charge Assignment" := FALSE;
              FindResUnitCost;
              InitDeferralCode;
            END;
          Type::"Fixed Asset":
            BEGIN
              FixedAsset.GET("No.");
              FixedAsset.TESTFIELD(Inactive,FALSE);
              FixedAsset.TESTFIELD(Blocked,FALSE);
              GetFAPostingGroup;
              Description := FixedAsset.Description;
              "Description 2" := FixedAsset."Description 2";
              "Allow Invoice Disc." := FALSE;
              "Allow Item Charge Assignment" := FALSE;
            END;
          Type::"Charge (Item)":
            BEGIN
              ItemCharge.GET("No.");
              Description := ItemCharge.Description;
              "Gen. Prod. Posting Group" := ItemCharge."Gen. Prod. Posting Group";
              "VAT Prod. Posting Group" := ItemCharge."VAT Prod. Posting Group";
              "Tax Group Code" := ItemCharge."Tax Group Code";
              "Allow Invoice Disc." := FALSE;
              "Allow Item Charge Assignment" := FALSE;
            END;
        END;

        IF NOT (Type IN [Type::" ",Type::"Fixed Asset"]) THEN
          VALIDATE("VAT Prod. Posting Group");

        UpdatePrepmtSetupFields;

        IF Type <> Type::" " THEN BEGIN
          VALIDATE("Unit of Measure Code");
          IF Quantity <> 0 THEN BEGIN
            InitOutstanding;
            IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
              InitQtyToReceive
            ELSE
              InitQtyToShip;
            InitQtyToAsm;
            UpdateWithWarehouseShip;
          END;
          UpdateUnitPrice(FIELDNO("No."));
        END;

        IF NOT ISTEMPORARY THEN
          CreateDim(
            DimMgt.TypeToTableID3(Type),"No.",
            DATABASE::Job,"Job No.",
            DATABASE::"Responsibility Center","Responsibility Center");

        IF "No." <> xRec."No." THEN BEGIN
          IF Type = Type::Item THEN
            IF (Quantity <> 0) AND ItemExists(xRec."No.") THEN BEGIN
              ReserveSalesLine.VerifyChange(Rec,xRec);
              WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
            END;
          GetDefaultBin;
          AutoAsmToOrder;
          DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          IF Type = Type::"Charge (Item)" THEN
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
        END;

        UpdateItemCrossRef;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.26 DDR 31/10/2008
        TestDelayedLine();
        // >>DITW15.00.00.26 DDR
        // <<DITW15.00.00.39 DDR 07/10/2011 #1396
        CheckItemExclusivityAvail(FIELDNO("No."));
        // >>DITW15.00.00.39 DDR #1396
        // <<DITW17.10.03 DDR 13/06/2014 DIT-770 #392
        CheckItemQuotaAvail(FIELDNO("No."));
        // >>DITW17.10.03 DDR DIT-770 #392

        CheckItemAvailable(FIELDNO("No."));
        //<<DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
        if (xRec."No." <> "No.") and ("Event Doc. No."<>'') then
          ERROR(Text2014360,FIELDCAPTION("No."), "Event Doc. No.", "Event Doc. Line No.");
        //>>DITW18.00.06 MSF 19/10/2015 DIT-770 #1261

        if (xRec."No." <> "No.") and (Quantity <> 0) then begin
        #8..10
          if Type = Type::Item then
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        end;
        #14..24
        if "No." = '' then
        #26..29
        // <<DITW15.00.00.35 DDR 01/07/2009
        CLEAR(SaveTempSalesChargeLine);
        SaveTempSalesChargeLine.DELETEALL;
        // >>DITW15.00.00.35 DDR

        // <<DITW19.00.08 DDR 10/11/2016 BL#11843
        if ("No." = '') or (xRec."No." <> "No.") then
          DeleteAllChargeSalesLines(Rec,true);
        // >>DITW19.00.08 DDR BL#11843

        // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        TestStatusModifyEmcs(FIELDCAPTION("No."));
        // >>DITW16.00.00.43 DDR DIT-715 #720

        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.36  DDR 23/11/2009
        TransferTaxCharges.ClearBuffer();
        TransferDepositCharges.ClearBuffer();
        TransferDiscountCharges.ClearBuffer();
        TransferPromotionCharges.ClearBuffer();
        // >>DITW15.00.00.36 DDR

        TempSalesLine := Rec;
        INIT;
        if xRec."Line Amount" <> 0 then
          "Recalculate Invoice Disc." := true;
        Type := TempSalesLine.Type;
        "No." := TempSalesLine."No.";
        // <<DITW15.00.00.35 DDR 23/07/2009
        "Is Item Charge" := TempSalesLine."Is Item Charge";
        "Item Charge Type" := TempSalesLine."Item Charge Type";
        "Free Item" := TempSalesLine."Free Item";
        //<< DITW17.00.02 TEC1 12/09/2013 DIT-770 #132
        "Free Reason Code" := TempSalesLine."Free Reason Code";
        //>> DITW17.00.02 TEC1 DIT-770 #132
        //<< DITW18.00.07 VSC 04/03/2016 DIT-770 #1702
        "Original Quantity" := TempSalesLine."Original Quantity";
        //>> DITW18.00.07 VSC DIT-770 #1702

        // >>DITW15.00.00.35 DDR
        // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        "Allow VAT Calculation (Free)" := TempSalesLine."Allow VAT Calculation (Free)";
        // >>DITW16.00.00.40 DDR DIT-715 #172
        // <<DITW15.00.00.37 DDR 04/06/2010
        Collapse := TempSalesLine.Collapse;
        // >>DITW15.00.00.37 DDR
        // <<DITW110.00.09 DDR 05/04/2017 NRQ#16737
        "Relation Location Code" := '';
        // >>DITW110.00.09 DDR NRQ#16737

        // <<DITW15.00.00.23 DDR 30/07/2008
        if (xRec."No." <> '') and ("No." = '') and
           (Type <> Type::" ") and (xRec.Type = Type) and
           (CurrFieldNo <> 0)
        then
          TESTFIELD("No.");
        // >>DITW15.00.00.23 DDR

        if "No." = '' then
          exit;
        if Type <> Type::" " then
        #39..57
            false);
        UpdateDates;

        // << DITW19.00.08 SFI 18/08/2016 BL#10868
        GLSetup.GET;
        // >> DITW19.00.08 SFI BL#10868
        case Type of
          Type::" ":
            begin
              StandardText.GET("No.");
              Description := StandardText.Description;
              "Allow Item Charge Assignment" := false;
              // << DITW19.00.08 SFI 18/08/2016 BL#10868
              "Allow Invoice Disc." := false;
              // >> DITW19.00.08 SFI BL#10868
            end;
          Type::"G/L Account":
            begin
              GLAcc.GET("No.");
              GLAcc.CheckGLAcc;
              if not "System-Created Entry" then
                GLAcc.TESTFIELD("Direct Posting",true);
        #74..76
              "WHT Product Posting Group" := GLAcc."WHT Product Posting Group";//WHT
              "Tax Group Code" := GLAcc."Tax Group Code";
              "Allow Invoice Disc." := false;
              "Allow Item Charge Assignment" := false;
              InitDeferralCode;
              //<<FINXL7.00.001 RBE 25/03/2013
              if recFinXLSetup.READPERMISSION then
                "Auto. Acc. Group" := GLAcc."Auto. Acc. Group";
              //>>FINXL7.00.001 RBE 25/03/2013
              // <<DITW15.00.00.39 DDR 09/05/2011 #1328
              if "Is Item Charge" then
                Collapse := GLAcc.Collapse;
              // >>DITW15.00.00.39 DDR #1328
              // << DITW19.00.08 SFI 18/08/2016 BL#10868
              if GLSetup."Allow Invoice Disc. G/L Acc." then
                "Allow Invoice Disc." := GLAcc."Allow Invoice Disc.";
              // >> DITW19.00.08 SFI BL#10868
              // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
              if (GLAcc."DIT Sub-Contract Posting Type" <> GLAcc."DIT Sub-Contract Posting Type"::" ") and
                (GLAcc."DIT Sub-Contract Posting Type" <> GLAcc."DIT Sub-Contract Posting Type"::All) and
                ("DIT Sub-Contract Type" <> "DIT Sub-Contract Type"::" ")
              then
                TESTFIELD("DIT Sub-Contract Type",GLAcc."DIT Sub-Contract Posting Type");

              if GLAcc."DIT Sub-Contract Posting Type" <> GLAcc."DIT Sub-Contract Posting Type"::All then
                "DIT Sub-Contract Type" := GLAcc."DIT Sub-Contract Posting Type";
              // >>DITW16.00.00.41 AHU DIT-715 #327
            end;
          Type::Item:
            begin
              GetItem;
              Item.TESTFIELD(Blocked,false);
              // << DITW110.00.11 SFI 31/08/2017 BL#30569
              Item.BlockedSKU("Location Code","Variant Code",true);
              // >> DITW110.00.11 SFI BL#30569
              Item.TESTFIELD("Gen. Prod. Posting Group");
              if Item.Type = Item.Type::Inventory then begin
                Item.TESTFIELD("Inventory Posting Group");
                //<<DITW17.00.02 AT  19/12/2013 DIT-770 #235
                "Shelf No." := Item."Shelf No.";
                //>>DITW17.00.02 AT  19/12/2013 DIT-770 #235
                "Posting Group" := Item."Inventory Posting Group";
              end;
              Description := Item.Description;
              "Description 2" := Item."Description 2";
              //<< DITW18.00.07 AKH 29/04/2016 DIT-770 #1346
              "Item Delivery Type" := Item."Item Delivery Type";
              //>> DITW18.00.07 AKH DIT-770 #1346
              GetUnitCost;
              // << DITW110.00.11 SFI 30/08/2017 BL#14417
              GetDepositValue;
              // >> DITW110.00.11 SFI BL#14417
        #94..98
              // <<DITW15.00.00.28 DDR 24/11/2008
              //"Item Category Code" := Item."Item Category Code";
              VALIDATE("Item Category Code",Item."Item Category Code");
              // >>DITW15.00.00.28 DDR
              "Product Group Code" := Item."Product Group Code";
              // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1190
              //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1534
              if Item."Location Code" <> '' then begin
              //>>DITW18.00.06 DDR 08/09/2015 DIT-770 #1534
                ItemLocationCode := UserSetupMgt.GetLocation(0,Item."Location Code","Responsibility Center");
                if ItemLocationCode <> '' then
                  "Location Code" := ItemLocationCode;
               //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1534
               end;
               //>>DITW18.00.06 MSF 08/09/2015 DIT-770 #1534
               // >>DITW18.00.06 DDR DIT-770 #1190
               // <<DITW16.00.00.40 DDR 16/04/2012 02/05/2012 DIT-715 #247 - DITW18.00.06 DDR 27/02/2015 DIT-770 #1190
               //<<DITW18.00.06 MSF 08/09/2015 DIT-770 #1534
               if Item."Reverse Location Code" <> '' then begin
               //>>DITW18.00.06 MSF 08/09/2015 DIT-770 #1534
                 ItemLocationCode := UserSetupMgt.GetLocation(0,Item."Reverse Location Code","Responsibility Center");
                 if (("Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) xor (Quantity < 0)) and
                   (ItemLocationCode <> '')
                 then
                   "Location Code" := ItemLocationCode;
              //<<DITW18.00.06 DDR 08/09/2015 DIT-770 #1534
              end;
              //>>DITW18.00.06 DDR 08/09/2015 DIT-770 #1534
              // >>DITW16.00.00.40 DDR DIT-715 #247 - DITW18.00.06 DDR DIT-770 #1190
              // <<DITW15.00.00.35 DLE 06/09/2009 - 06/10/2009
              GetLocation("Location Code");
              // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
              if not UserSetupMgt.CheckLocation(0,"Location Code","Responsibility Center") then
                //<< DITW19.00.08 AKH 27/10/2016 BL#11231
                ERROR(
                  Text2014414,
                  Location.TABLECAPTION,"Location Code");
                //>> DITW19.00.08 AKH BL#11231

              if "Location Code" <> xRec."Location Code" then
                VALIDATE("Location Code");
              // >>DITW18.00.06 DDR DIT-770 #1190

              // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
              if Location.Code <> '' then
              // >>DITW18.00.06 DDR DIT-770 #1190
                "Physical Location Group Code" := Location."Physical Location Group Code";
              // <<DITW15.00.00.37 DDR 20/01/2010
              "Location Group Code" := Location."Location Group Code";
              // >>DITW15.00.00.37 DDR
              // >>DITW15.00.00.35 DLE 06/09/2009
              Nonstock := Item."Created From Nonstock Item";
              "Profit %" := Item."Profit %";
              "Allow Item Charge Assignment" := true;
              PrepaymentMgt.SetSalesPrepaymentPct(Rec,SalesHeader."Posting Date");
              // <<DITW15.00.00.01 DDR 27/12/2007
              "Item DTax Group Code" := Item."Item DTax Group Code";
              // >>DITW15.00.00.01 DDR
              // <<DITW17.10.03 DDR 19/05/2014 DIT-770 #623
              //HEI.29 commented begin>>
            {  "Customer DTax Group Code" := GetCustTaxGroupCode("Customer DTax Group Code","Item DTax Group Code");
              IF ("Customer DTax Group Code" <> '') AND ("Customer DTax Group Code" <> SalesHeader."Customer DTax Group Code") THEN
                TestCustTaxRegHeader();}
              //HEI.29 commented end <<
              // >>DITW17.10.03 DDR DIT-770 #623
              // <<DITW15.00.00.01 DDR 04/01/2007
              "Item DDeposit Group Code" := Item."Item DDeposit Group Code";
              // >>DITW15.00.00.01 DDR
              // <<DITW15.00.00.01 DDR 24/01/2008 - DITW19.00.08 DDR 17/08/2016 BL#10443
              "Unit Volume HL" := Item."Unit Volume HL" * UOMMgt.GetQtyPerUnitOfMeasure(Item,"Unit of Measure Code");
              // >>DITW15.00.00.01 DDR - DITW19.00.08 DDR BL#10443
              // <<DITW15.00.00.28 DDR 24/11/2008
              "Tariff No." := Item."Tariff No.";
              // >>DITW15.00.00.28 DDR
              // <<DITW15.00.00.35 DDR 24/06/2009
              //<< DITW17.00.02 TEC1 12/09/2013 DIT-770 #132
              if not Item."Free Item" then begin
                Cust.GET("Sell-to Customer No.");
                // <<DITW111.00.13 ISL 04/12/2018 NRQ#93127
                if SalesHeader.IsCustCalcPrices(Cust,SalesSetup."Bill-to/Sell-to Prices Calc."::"Bill-to") then
                  Cust.GET("Bill-to Customer No.");
                // >>DITW111.00.13 ISL NRQ#93127
                if Cust."Free Item" then begin
                  // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
                  if SalesSetup."Enforce Free Reason on Free" and Cust."Free Item" and (CurrFieldNo <> 0) then
                    Cust.TESTFIELD("Free Reason Code");
                  // >>DITW17.10.05 DDR DIT-770 #1118
                  Item."Free Item" := Cust."Free Item";
                  Item."Free Reason Code" := Cust."Free Reason Code";
                end;
              end;
              //>> DITW17.00.02 TEC1 DIT-770 #132
              "Free Item" := Item."Free Item";
              // <<DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
              if "Free Item" then
              // >>DITW17.10.05 DDR DIT-770 #1118
              //<< DITW17.00.02 TEC1 12/09/2013 DIT-770 #132 - DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
                "Free Reason Code" := Item."Free Reason Code"
              else
                "Free Reason Code" := '';
              //>> DITW17.00.02 TEC1 DIT-770 #132 - DITW18.00.07A DDR DIT-770 #2074
              // <<DITW17.10.03 DDR 04/07/2014 DIT-770 #699 - DITW17.10.05 DDR 12/02/2015 DIT-770 #1118
              if SalesSetup."Enforce Free Reason on Free" and Item."Free Item" and (CurrFieldNo <> 0) then
                Item.TESTFIELD("Free Reason Code");
              // >>DITW17.10.03 DDR DIT-770 #699 - DITW17.10.05 DDR DIT-770 #1118
              // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
              "Allow VAT Calculation (Free)" := Item."Allow VAT Calculation (Free)";
              // >>DITW16.00.00.40 DDR DIT-715 #172
              "Gen. Prod. Posting Free Group" := Item."Gen. Prod. Posting Free Group";
              if Item."Free Item Posting Type" <> Item."Free Item Posting Type"::" " then
                "Free Item Posting Type" := Item."Free Item Posting Type"
              else
                "Free Item Posting Type" := SalesHeader."Free Item Posting Type";
              // >>DITW15.00.00.35 DDR
              //HEI.29>>
              if (FreeReasonCode.GET("Free Reason Code")) and (FreeReasonCode."Customer DTax Group Code" <> '') then
                "Customer DTax Group Code" := FreeReasonCode."Customer DTax Group Code"
              else
                "Customer DTax Group Code" := GetCustTaxGroupCode("Customer DTax Group Code","Item DTax Group Code");
              if ("Customer DTax Group Code" <> '') and ("Customer DTax Group Code" <> SalesHeader."Customer DTax Group Code") then
                TestCustTaxRegHeader();
              //HEI.29<<

              if SalesHeader."Language Code" <> '' then
                GetItemTranslation;

              if Item.Reserve = Item.Reserve::Optional then
                Reserve := SalesHeader.Reserve
              else
        #112..114
              //<<FINXL7.00.001 RBE 20/03/2013
              "Tariff No." := Item."Tariff No.";
              //>>FINXL7.00.001 RBE 20/03/2013
              // <<DITW15.00.00.38 DDR 02/09/2010 #1217
              ItemUnitOfMeasure.GET("No.","Unit of Measure Code");
              // <<DITW16.00.00.43 DDR 12/08/2013 DIT-715 #720
              VALIDATE("Packaging Type Code",ItemUnitOfMeasure."Packaging Type Code");
              // >>DITW16.00.00.43 DDR DIT-715#720
              // >>DITW15.00.00.38 DDR
              // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
              if ItemUnitOfMeasure."Packaging Type Code" <> '' then
                ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
              "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
              // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
              // <<DITW15.00.00.28 DDR 24/11/2008
              UpdateAADInfo();
              // >>DITW15.00.00.28 DDR
              // <<DITW15.00.00.38 DDR 01/09/2010 #1217
              "Product Tax Code" := Item."Product Tax Code";
              // >>DITW15.00.00.38 DDR
              // <<DITW15.00.00.39 DDR 09/05/2011 #1328
              if "Is Item Charge" then
                Collapse := GLAcc.Collapse;
              // >>DITW15.00.00.39 DDR #1328
              // <<DITW15.00.00.39 DDR 23/09/2011 #1258
              if ("Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) and
                (Item."Service Item Group" <> '')
              then begin
                ServItemGroup.GET(Item."Service Item Group");
                if ServItemGroup."Default Return Reason Code" <> '' then
                  VALIDATE("Return Reason Code",ServItemGroup."Default Return Reason Code");
              end;
              // >>DITW15.00.00.39 DDR  #1258

              //<<DITW17.00.02 TEC1 09/09/2013 DIT-770 #145
              //>> HEI.20 FDD-HB564 21.08.2019
              locItem.SETRANGE(locItem."No.",Item."No.");
              //locItem.SETFILTER(locItem."Item Category Code",SalesSetup."RPM Related Item Category Code"); // HEI.20 FDD-HB564 21.10.2019
              if locItem.FINDFIRST then
                "Return Reason Code" := locItem."Return Reason Code";
              //<< HEI.20 FDD-HB564 21.08.2019
              //>>DITW17.00.02 TEC1 DIT-770 #145

              // << DITW110.00.10 SFI 20/06/2017 BL#15657
              if GetSKU then begin
                if "Backorder Type" <> SKU."Backorder Type" then
                  VALIDATE("Backorder Type", SKU."Backorder Type");
                //HEI.07>>
                  "RPM Solution" := SKU."RPM Solution";
                  "RPM Type" := SKU."RPM Type";
                  "Item Type" := SKU."Item Type";
                //HEI.07<<
              end else begin
                if "Backorder Type" <> Item."Backorder Type" then
                  VALIDATE("Backorder Type", Item."Backorder Type");
                 //HEI.07>>
                  "RPM Solution" := Item."RPM Solution";
                  "RPM Type" := Item."RPM Type";
                  "Item Type" := Item."Item Type";
                //HEI.07<<
              end;
              // >> DITW110.00.10 SFI BL#15657

              // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
              VALIDATE("Free Item");
              // >>DITW17.10.05 DDR DIT-770 #868
              //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
              VALIDATE("Purchasing Code",GetPurchasingCode(SalesHeader."Sell-to Customer No.","Location Code"));
              //>> DITW18.00.07 AKH DIT-770 #1425
              // <<DITW19.00.08 DDR 17/08/2016 17/10/2016 BL#10443
              "Strength Spec. Code" := Item."Strength Spec. Code";
              "Vol-Strength Spec. Code" := Item."Vol-Strength Spec. Code";
              // >>DITW19.00.08 DDR BL#10443
              //HEI.02>>
              "Document Subtype Code" := SalesHeader."Document Subtype Code";
              //HEI.02<<
              "WHT Product Posting Group" := Item."WHT Product Posting Group";//WHT
              InitDeferralCode;
              ///DITW110.00.10 MSF 18/07/2017 NRQ#16224
              //? <<FINXL10.00 DDR 02/01/2017 NRQ#0 TO BE REVIEWED
              ////<<FINXL7.00.001 RBE 20/03/2013
              //IF recFinXLSetup.READPERMISSION THEN BEGIN
              //  "Tariff No." := Item."Tariff No.";
              //    //<<FINXL8.00.001 BSA 04/06/2015 #51
              //    IF Item."Location Code" <> '' THEN
              //      "Location Code" := Item."Location Code";
              //  //>>FINXL8.00.001 BSA 04/06/2015 #51
              //END;
              ////>>FINXL7.00.001 RBE 20/03/2013
              //? >>FINXL10.00 DDR 02/01/2017 NRQ#0
              SetDefaultItemQuantity;
            end;
          Type::Resource:
            begin
              Res.GET("No.");
              Res.TESTFIELD(Blocked,false);
        #122..129
              "Allow Item Charge Assignment" := false;
              "WHT Product Posting Group" := Res."WHT Product Posting Group";//WHT
              // << DITW19.00.08 SFI 18/08/2016 BL#10868
              if GLSetup."Allow Invoice Disc. Resource" then
                "Allow Invoice Disc." := Res."Allow Invoice Disc.";
              // >> DITW19.00.08 SFI BL#10868
              FindResUnitCost;
              InitDeferralCode;
            end;
          Type::"Fixed Asset":
            begin
              FixedAsset.GET("No.");
              FixedAsset.TESTFIELD(Inactive,false);
              FixedAsset.TESTFIELD(Blocked,false);
        #139..141
              "Allow Invoice Disc." := false;
              // << DITW19.00.08 SFI 18/08/2016 BL#10868
              if GLSetup."Allow Invoice Disc. FA" then
                "Allow Invoice Disc." := FixedAsset."Allow Invoice Disc.";
              // >> DITW19.00.08 SFI BL#10868
              "Allow Item Charge Assignment" := false;
              // <<DITW16.00.00.41 AHU 03/08/2012 DIT-715 #327
              //<< DITW18.00.07 VSC 12/01/2016 DIT-770 #1751 Error Contractmanagment On Posting invoice
              if FixedAsset."Financial Contract No." <> '' then begin
                //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                VALIDATE("Contract Type","Contract Type"::Financial);
                //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
              end else begin
                "Contract Type" := "Contract Type"::" ";
              end;
              //>> DITW18.00.07 VSC DIT-770 #1751
              FixedAsset.CALCFIELDS("DIT Sub-Contract Type");
              "DIT Sub-Contract Type" := FixedAsset."DIT Sub-Contract Type";
              //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
              if FixedAsset."Financial Contract No." <> "Financial Contract No." then
                VALIDATE("Financial Contract No.",FixedAsset."Financial Contract No.");
              //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
              // >>DITW16.00.00.41 AHU DIT-715 #327
            end;
          Type::"Charge (Item)":
            begin
              ItemCharge.GET("No.");
              // <<DITW16.00.00.43 DDR 27/08/2013 DIT-715 #742
              if (CurrFieldNo <> 0) and (ItemCharge."Item Charge Type" <> "Item Charge Type"::" ") then
                ItemCharge.FIELDERROR("Item Charge Type");
              // >>DITW16.00.00.43 DDR DIT-715 #742
        #148..151
              "Allow Invoice Disc." := false;
              // << DITW19.00.08 SFI 18/08/2016 BL#10868
              if GLSetup."Allow Invoice Disc. Item Chrg." then
                "Allow Invoice Disc." := ItemCharge."Allow Invoice Disc.";
              // >> DITW19.00.08 SFI BL#10868
              "Allow Item Charge Assignment" := false;
              // <<DITW15.00.00.01 DDR 02/01/2008
              "Item Charge Type" := ItemCharge."Item Charge Type";
              // >>DITW15.00.00.01 DDR
              // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
              "Gen. Prod. Posting Free Group" := ItemCharge."Gen. Prod. Posting Free Group";
              // >>DITW16.00.00.40 DDR DIT-715 #172
              "WHT Product Posting Group" := ItemCharge."WHT Product Posting Group";//WHT
            end;
        end;

        if not (Type in [Type::" ",Type::"Fixed Asset"]) then begin
          VALIDATE("VAT Prod. Posting Group");
          VALIDATE("WHT Product Posting Group");//WHT
        end;
        UpdatePrepmtSetupFields;

        if Type <> Type::" " then begin
          VALIDATE("Unit of Measure Code");
          if Quantity <> 0 then begin
            InitOutstanding;
            if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then
              InitQtyToReceive
            else
        #169..171
            //<< DITW18.00.07 AKH 29/04/2016 DIT-770 #1346
            if "Document Type" = "Document Type"::Order then
              CalcDeliveryTimeQtyBase();
            //>> DITW18.00.07 AKH DIT-770 #1346
          end;

        // <<DITW18.00.06 WSA 31/08/2015 DIT-770 # 1559
          TempFreeItem := "Free Item";
          "Free Item" := false;
        // >>DITW18.00.06 WSA 31/08/2015 DIT-770 # 1559
          UpdateUnitPrice(FIELDNO("No."));
        // <<DITW18.00.06 WSA 31/08/2015 DIT-770 # 1559
         "Free Item" := TempFreeItem;
        // >>DITW18.00.06 WSA 31/08/2015 DIT-770 # 1559

          // <<DITW15.00.00.39 DDR 23/09/2011 #1258
          if "Return Reason Code" <> '' then
            VALIDATE("Return Reason Code");
          // >>DITW15.00.00.39 DDR  #1258

          // <<DITW15.00.00.35 DDR 25/06/2009
          if ("Free Item") and (Type = Type::Item) then
            VALIDATE("Free Item");
          // >>DITW15.00.00.35 DDR
        end;

        // DITW15.00.00.39 DDR 29/08/2011 #1396 - 07/10/2011 #1396
        //IF NOT ISTEMPORARY THEN
        //  CreateDim(
        //    DimMgt.TypeToTableID3(Type),"No.",
        //    DATABASE::Job,"Job No.",
        //    DATABASE::"Responsibility Center","Responsibility Center");

        if "No." <> xRec."No." then begin
          if Type = Type::Item then
            if (Quantity <> 0) and ItemExists(xRec."No.") then begin
              ReserveSalesLine.VerifyChange(Rec,xRec);
              WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
            end;
          GetDefaultBin;
          AutoAsmToOrder;
          // <<DITW15.00.00.36 DDR 18/11/2009
          // DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
          if Type = Type::"Charge (Item)" then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
          // <<DITW15.00.00.36 DDR 18/11/2009 - DITW15.00.00.37 DDR 28/04/2010
          if (Type <> Type::"Charge (Item)") and "Is Item Charge"  and
            ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item)
          then
            DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
          // >>DITW15.00.00.37 DDR
        end;

        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        // <<DITW18.00.06 DDR 16/09/2015 18/09/2015 05/11/2015 DIT-770 #1592
        // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
        //IF NOT ISTEMPORARY THEN
        if not ISTEMPORARY and (CurrFieldNo = FIELDNO("No.")) or ((CurrFieldNo = 0) and ("Line No." <> 0)) then
        // >>DITW110.00.08 DDR NRQ#0
        // >>DITW18.00.06 DDR DIT-770 #1592
        #177..179
            DATABASE::"Responsibility Center","Responsibility Center",
            // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
            //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo(),
            //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            // >>DITW16.00.00.41 AHU DIT-715 #327
            // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
            DimMgt.TypeToTableID3(Type::Item),"Tax Item No.");
            // >>DITW16.00.00.43 DDR DIT-715 #768
        // >>DITW15.00.00.38 DDR #1259

        UpdateItemCrossRef;
        // <<DITW15.00.00.34 DDR 12/06/2009
        GetSalesHeader();
        // >>DITW15.00.00.34 DDR

        // <<DITW15.00.00.31 DDR 17/02/2009 - DITW15.00.00.35 DDR 29/06/2009
        if (CurrFieldNo = FIELDNO("No.")) and
           (Type = Type::Item)  and
           (not BatchInsertCheckSuspended)
        then begin
          COMMIT;
          // <<DITW15.00.00.35 DDR 29/06/2009
          if "Line No." <> 0 then begin
            if TransferExtText.SalesCheckIfAnyExtText(Rec,false) then
              TransferExtText.InsertSalesExtText(Rec);
            COMMIT;
          end;
          // >>DITW15.00.00.35 DDR

          // <<DITW15.00.00.36 DDR 17/11/2009 - DITW15.00.00.37 DDR 04/05/2010
          if (Type = Type::Item) and ("Quantity Invoiced" = 0) and
            ("Quantity Shipped" = 0) and ("Return Qty. Received" = 0) and
            ("Appl.-to Item Entry" = 0) and ("Appl.-from Item Entry" = 0) and
            ("Shipment No." = '') and ("Return Receipt No." = '')
          then begin
            if (Quantity <> 0) or (xRec.Quantity <> Quantity) then begin
              // <<DITW15.00.00.38 DDR 27/01/2011 #1259
              lTempCurrfieldno := CurrFieldNo;
              // >>DITW15.00.00.38 DDR #1259
              CurrFieldNo := FIELDNO("Location Code");
              InsertCharges3(FIELDNO("Location Code"));
              // <<DITW15.00.00.38 DDR 27/01/2011 #1259
              CurrFieldNo := lTempCurrfieldno;
              // >>DITW15.00.00.38 DDR #1259
              // <<DITW17.10.05 DDR 15/12/2014 DIT-770 #1110
              UpdateAmounts;
              // >>DITW17.10.05 DDR DIT-770 #1110
            end else
              DeleteAllChargeSalesLines(Rec,true);
          end;
          // >>DITW15.00.00.37 DDR
        end;
        // >>DITW15.00.00.35 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Location Code"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        CheckAssocPurchOrder(FIELDCAPTION("Location Code"));
        IF "Location Code" <> '' THEN
          IF IsServiceItem THEN
            Item.TESTFIELD(Type,Item.Type::Inventory);
        IF xRec."Location Code" <> "Location Code" THEN BEGIN
          IF NOT FullQtyIsForAsmToOrder THEN BEGIN
            CALCFIELDS("Reserved Qty. (Base)");
            TESTFIELD("Reserved Qty. (Base)","Qty. to Asm. to Order (Base)");
          END;
          TESTFIELD("Qty. Shipped Not Invoiced",0);
          TESTFIELD("Shipment No.",'');
          TESTFIELD("Return Qty. Rcd. Not Invd.",0);
          TESTFIELD("Return Receipt No.",'');
        END;

        GetSalesHeader;
        "Shipment Date" :=
          CalendarMgmt.CalcDateBOC(
            '',
            SalesHeader."Shipment Date",
            CalChange."Source Type"::Location,
            "Location Code",
            '',
            CalChange."Source Type"::"Shipping Agent",
            "Shipping Agent Code",
            "Shipping Agent Service Code",
            FALSE);

        CheckItemAvailable(FIELDNO("Location Code"));

        IF NOT "Drop Shipment" THEN BEGIN
          IF "Location Code" = '' THEN BEGIN
            IF InvtSetup.GET THEN
              "Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
          END ELSE
            IF Location.GET("Location Code") THEN
              "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
        END ELSE
          EVALUATE("Outbound Whse. Handling Time",'<0D>');

        IF "Location Code" <> xRec."Location Code" THEN BEGIN
          InitItemAppl(TRUE);
          GetDefaultBin;
          InitQtyToAsm;
          AutoAsmToOrder;
          IF Quantity <> 0 THEN BEGIN
            IF NOT "Drop Shipment" THEN
              UpdateWithWarehouseShip;
            IF NOT FullReservedQtyIsForAsmToOrder THEN
              ReserveSalesLine.VerifyChange(Rec,xRec);
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
          END;
        END;

        UpdateDates;

        IF (Type = Type::Item) AND ("No." <> '') THEN
          GetUnitCost;

        CheckWMS;

        IF "Document Type" = "Document Type"::"Return Order" THEN
          ValidateReturnReasonCode(FIELDNO("Location Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        UpdateTINBAndVATProdPostGrByLocation; //HEI.14
        // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
        // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
        if (("Responsibility Center" = xRec."Responsibility Center") or ("No." <> xRec."No.")) and
          ("Location Code" <> xRec."Location Code")
        then begin
        // >>DITW18.00.06 DDR DIT-770 #1592
          GetLocation("Location Code");
          // <<DITW18.00.06 DDR 16/09/2015 DIT-770 #1592
          "Responsibility Center" := UserSetupMgt.GetFirstRespCenter(0,Location."Physical Location Group Code","Location Code");
          // >>DITW18.00.06 DDR DIT-770 #1592
        end;
        // >>DITW18.00.06 DDR DIT-770 #1190

        // <<DITW18.00.06 DDR 19/02/2015 26/02/2015 DIT-770 #1190
        if (("Responsibility Center" = xRec."Responsibility Center") and ("Location Code" <> '')) or
          ("Responsibility Center" <> xRec."Responsibility Center")
        then
          if not UserSetupMgt.CheckLocation(0,"Location Code","Responsibility Center") then
            //<< DITW19.00.08 AKH 27/10/2016 BL#11231
            ERROR(
              Text2014414,
              Location.TABLECAPTION,"Location Code");
            //>> DITW19.00.08 AKH BL#11231
        // >>DITW18.00.06 DDR DIT-770 #1190

        CheckAssocPurchOrder(FIELDCAPTION("Location Code"));

        if "Location Code" <> '' then
          if IsServiceItem then
            Item.TESTFIELD(Type,Item.Type::Inventory);
        if xRec."Location Code" <> "Location Code" then begin
          if not FullQtyIsForAsmToOrder then begin
            CALCFIELDS("Reserved Qty. (Base)");
            TESTFIELD("Reserved Qty. (Base)","Qty. to Asm. to Order (Base)");
          end;
          TESTFIELD("Qty. Shipped Not Invoiced",0);
          //<<FINXL8.00.001 BSA 27/05/2015 #184 - DITW110.00.09 AKH 10/04/2017 NRQ#24104
          if recFinXLSetup.READPERMISSION then begin
            if not recUserSetup.GET(USERID) then
              recUserSetup.INIT;
            if not recUserSetup."Ship Other Bill-to Customer" then
            TESTFIELD("Shipment No.",'');
          end;
          //>>FINXL8.00.001 BSA 27/05/2015 #184
          TESTFIELD("Return Qty. Rcd. Not Invd.",0);
          TESTFIELD("Return Receipt No.",'');
          // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
          TestStatusModifyEmcs(FIELDCAPTION("Location Code"));
          // >>DITW16.00.00.43 DDR DIT-715 #720
          // <<DITW18.00.07 MVN 16/03/2016 DIT-770 #1666
          GetDefaultBin;
          // >>DITW18.00.07 MVN DIT-770 #1666
        end;

        // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1190
        if "Location Code" <> '' then begin
          Location.GET("Location Code");
          if Location."Physical Location Group Code" <> "Physical Location Group Code" then
            "Physical Location Group Code" := Location."Physical Location Group Code";
        end;
        // >>DITW18.00.06 DDR DIT-770 #1190
        if xRec."Physical Location Group Code" = "Physical Location Group Code" then
          VALIDATE("Physical Location Group Code");
        // >>DITW18.00.06 DDR DIT-770 #1190
        #17..28
            false);

        // DITW16.00.00.43 DDR 31/01/2014 DIT-715 #856
        //CheckItemAvailable(FIELDNO("Location Code"));

        if not "Drop Shipment" then begin
          if "Location Code" = '' then begin
            if InvtSetup.GET then
              "Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
          end else
            if Location.GET("Location Code") then
              "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
        end else
          EVALUATE("Outbound Whse. Handling Time",'<0D>');

        ///DITW18.00.07 AKH 29/02/2016 DIT-770 #1425 - DITW19.00.08 DDR 10/11/2016 BL#11843-NRQ#174042  MSF 25/02/2021
        if Type = Type::Item then
            VALIDATE("Purchasing Code",GetPurchasingCode(SalesHeader."Sell-to Customer No.","Location Code"));
        //>> DITW18.00.07 AKH DIT-770 #1425 - DITW19.00.08 DDR BL#11843

        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        if (Type = Type::Item) then
          GetDepositValue;
        // >> DITW110.00.11 SFI BL#14417

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if (Type = Type::Item) then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569
        // <<DITW18.00.06 DDR 16/09/2015 DIT-770 #1592
        if (Type = Type::Item) and ((Quantity <> 0) or (xRec.Quantity <> Quantity)) then
          InsertCharges3(FIELDNO("Location Code"));
        //<<NRQ#174042  MSF 25/02/2021
        if Type = Type::Item then
          VALIDATE("Purchasing Code",GetPurchasingCode(SalesHeader."Sell-to Customer No.","Location Code"));
        //>>NRQ#174042  MSF 25/02/2021

        CheckItemAvailable(FIELDNO("Location Code"));
        // >>DITW18.00.06 DDR DIT-770 #1592

        //<< DITW110.00.10 DDR 20/04/2017 NRQ#15493
        if "Location Code" <> xRec."Location Code" then begin
           //<<DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
          // <<DITW17.00.03 DDR 13/02/2014 DIT-770 #383
          if (CurrFieldNo = FIELDNO("Location Code")) or
            // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1190
            (CurrFieldNo = FIELDNO("Physical Location Group Code")) or
            (CurrFieldNo = FIELDNO("Responsibility Center"))or
            // >>DITW18.00.06 DDR DIT-770 #1190
            // <<DITW110.00.09 YHE 03/04/2017 NRQ #17616
            (CurrFieldNo = 0)
            // >>DITW110.00.09 YHE 03/04/2017 NRQ #17616
          then
            UpdateAmounts();
          // >>DITW17.00.03 DDR DIT-770 #383
          //>>DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
          // <<DITW110.00.09 DDR 05/04/2017 NRQ#16737
          if CurrFieldNo <> 0 then
            "Relation Location Code" := '';
          // >>DITW110.00.09 DDR NRQ#16737
        end;
        //>> DITW110.00.10 DDR 20/04/2017 NRQ#15493
        // << DITW110.00.10 SFI 20/06/2017 BL#15657
        if (Type = Type::Item) then begin
          if GetSKU then begin
            if "Backorder Type" <> SKU."Backorder Type" then
              VALIDATE("Backorder Type", SKU."Backorder Type");
            //HEI.07>>
            "RPM Solution" := SKU."RPM Solution";
            "RPM Type" := SKU."RPM Type";
            "Item Type" := SKU."Item Type";
            //HEI.07<<
          end else begin
            //HEI.07>>
            "RPM Solution" := Item."RPM Solution";
            "RPM Type" := Item."RPM Type";
            "Item Type" := Item."Item Type";
            //HEI.07<<
          end;
        end;
        // >> DITW110.00.10 SFI BL#15657
        if "Location Code" <> xRec."Location Code" then begin
          InitItemAppl(true);
        #45..47
          if Quantity <> 0 then begin
            if not "Drop Shipment" then
              UpdateWithWarehouseShip;
            if not FullReservedQtyIsForAsmToOrder then
              ReserveSalesLine.VerifyChange(Rec,xRec);
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
          end;
          /// DITW18.00.06 MSF 19/10/2015 DIT-770 #1261 - DITW110.00.09 DDR 20/04/2017 NRQ#26317
          /// DITW110.00.09 DDR 05/04/2017 NRQ#16737 - DITW110.00.09 DDR 20/04/2017 NRQ#26317
        end;
        #56..58
        if (Type = Type::Item) and ("No." <> '') then
        #60..63
        //<< DITW18.00.07 VSC 02/06/2016 DIT-770 #1730
        if "Document Type" = "Document Type"::"Return Order" then begin
          if CurrFieldNo <> FIELDNO("Return Reason Code") then
          ValidateReturnReasonCode(FIELDNO("Location Code"));
        end;
        //>> DITW18.00.07 VSC DIT-770 #1730
        // <<DITW15.00.00.35 DLE 06/09/2009 - 06/10/2009
        // <<DITW15.00.00.37 DDR 20/01/2010
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
          GetLocation("Location Code");
          if Location.Code <> '' then begin
            "Location Group Code" := Location."Location Group Code";
          end else begin
            "Location Group Code" := '';
          end;
        // >>DITW18.00.06 DDR DIT-770 #1190

        // <<DITW15.00.00.37 DDR 04/05/2010
        // <<DITW18.00.06 DDR 16/09/2015 05/11/2015 DIT-770 #1592
        if ("Responsibility Center" <> xRec."Responsibility Center") and
          ("Location Code" <> xRec."Location Code") and
          (CurrFieldNo = FIELDNO("Location Code"))
        then
          VALIDATE("Responsibility Center");
        // >>DITW18.00.06 DDR DIT-770 #1592

        // <<DITW15.00.00.38 DDR 30/08/2010 #1217
        UpdateAADInfo();
        // >>DITW15.00.00.38 DDR

        if "Location Code" <> xRec."Location Code" then begin
          if Quantity <> 0 then begin
            ReserveSalesLine.VerifyChange(Rec,xRec);
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
          end;
        end;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipment Date"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        IF CurrFieldNo <> 0 THEN
          AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

        IF "Shipment Date" <> 0D THEN BEGIN
          IF CurrFieldNo IN [
                             FIELDNO("Planned Shipment Date"),
                             FIELDNO("Planned Delivery Date"),
                             FIELDNO("Shipment Date"),
                             FIELDNO("Shipping Time"),
                             FIELDNO("Outbound Whse. Handling Time"),
                             FIELDNO("Requested Delivery Date")]
          THEN
            CheckItemAvailable(FIELDNO("Shipment Date"));

          IF ("Shipment Date" < WORKDATE) AND (Type <> Type::" ") THEN
            IF NOT (HideValidationDialog OR HasBeenShown) AND GUIALLOWED THEN BEGIN
              MESSAGE(
                Text014,
                FIELDCAPTION("Shipment Date"),"Shipment Date",WORKDATE);
              HasBeenShown := TRUE;
            END;
        END;

        AutoAsmToOrder;
        IF (xRec."Shipment Date" <> "Shipment Date") AND
           (Quantity <> 0) AND
           NOT StatusCheckSuspended
        THEN
          CheckDateConflict.SalesLineCheck(Rec,CurrFieldNo <> 0);

        IF NOT PlannedShipmentDateCalculated THEN
          "Planned Shipment Date" := CalcPlannedShptDate(FIELDNO("Shipment Date"));
        IF NOT PlannedDeliveryDateCalculated THEN
          "Planned Delivery Date" := CalcPlannedDeliveryDate(FIELDNO("Shipment Date"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        //<< DITW110.00.11 VSC 03/10/2017 NRQ#33755
        if not ChangedFromWarehouse then
        //>> DITW110.00.11 VSC NRQ#33755
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);

        //HEI.06>>
        "Forecasted Shipment Date" := "Shipment Date";
        //HEI.06<<
        //<<DITW18.00.06 MSF 21/09/2015 DIT-770 #1261
        // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
        GetSalesSetup;
        // >>DITW18.00.07 DDR DIT-770 #1488
        if SalesSetup."New Document Per Shipment Date" then
          //<<DITW18.00.06 MSF 06/10/2015 DIT-770 #1261
          if ("Event Doc. No." <> '') and (not NewBlnUpdateFromEvent) then
          //>>DITW18.00.06 MSF 06/10/2015 DIT-770 #1261
            ERROR(Text2014360,FIELDCAPTION("Shipment Date"), "Event Doc. No.", "Event Doc. Line No.");
        //>>DITW18.00.06 MSF 21/09/2015 DIT-770 #1261

        if CurrFieldNo <> 0 then
          AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

        if "Shipment Date" <> 0D then begin
          if CurrFieldNo in [
        #8..13
          then
            CheckItemAvailable(FIELDNO("Shipment Date"));
          //<< DITW19.00.08 AKH 05/10/2016 BL#10806
          GetSalesSetup;
          if SalesSetup."Show Warning ShptDate-Workdate" then
          //>> DITW19.00.08 AKH BL#10806
            if ("Shipment Date" < WORKDATE) and (Type <> Type::" ") then
              // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
              //IF NOT (HideValidationDialog OR HasBeenShown) AND GUIALLOWED THEN BEGIN
              if not (HideValidationDialog or HasBeenShown) and GUIALLOWED and not BatchInsertCheckSuspended then begin
              // >>DITW18.00.07 DDR DIT-770 #1488
                MESSAGE(
                  Text014,
                  FIELDCAPTION("Shipment Date"),"Shipment Date",WORKDATE);
                HasBeenShown := true;
              end;
        end;

        AutoAsmToOrder;
        if (xRec."Shipment Date" <> "Shipment Date") and
           (Quantity <> 0) and
           not StatusCheckSuspended
        then
          CheckDateConflict.SalesLineCheck(Rec,CurrFieldNo <> 0);

        if not PlannedShipmentDateCalculated then
          "Planned Shipment Date" := CalcPlannedShptDate(FIELDNO("Shipment Date"));
        if not PlannedDeliveryDateCalculated then
          "Planned Delivery Date" := CalcPlannedDeliveryDate(FIELDNO("Shipment Date"));

        // <<DITW15.00.00.01 DDR 18/12/2007 - 14/01/2008
        // <<DITW15.00.00.19 DDR 07/04/2008 - DITW15.00.00.37 DDR 09/06/2010
        if (Type = Type::Item) and (CurrFieldNo <> 0) and
          (xRec."Shipment Date" <> "Shipment Date")
        then
          UpdateCharges(FIELDNO("Shipment Date"),true);
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on "Description(Field 11).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::" " THEN
          EXIT;

        CASE Type OF
          Type::Item:
            BEGIN
              IF (STRLEN(Description) <= MAXSTRLEN(Item."No.")) AND ("No." <> '') THEN
                ItemDescriptionIsNo := Item.GET(Description)
              ELSE
                ItemDescriptionIsNo := FALSE;

              IF ("No." <> '') AND (NOT ItemDescriptionIsNo) AND (Description <> '') THEN BEGIN
                Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '*''');
                IF NOT Item.FINDFIRST THEN
                  EXIT;
                IF Item."No." = "No." THEN
                  EXIT;
                IF CONFIRM(AnotherItemWithSameDescrQst,FALSE,Item."No.",Item.Description) THEN
                  VALIDATE("No.",Item."No.");
                EXIT;
              END;

              GetSalesSetup;
              DefaultCreate := ("No." = '') AND SalesSetup."Create Item from Description";
              IF Item.TryGetItemNoOpenCard(ReturnValue,Description,DefaultCreate,NOT HideValidationDialog) THEN
                CASE ReturnValue OF
                  '':
                    BEGIN
                      LookupRequested := TRUE;
                      Description := xRec.Description;
                    END;
                  "No.":
                    Description := xRec.Description;
                  ELSE BEGIN
                    CurrFieldNo := FIELDNO("No.");
                    VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN(Item."No.")));
                  END;
                END;
            END;
          ELSE
            IF "No." = '' THEN
              IF TypeHelper.FindRecordByDescription(ReturnValue,Type,Description) = 1 THEN BEGIN
                CurrFieldNo := FIELDNO("No.");
                VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
              END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::" " then
          exit;

        case Type of
          Type::Item:
            begin
              if (STRLEN(Description) <= MAXSTRLEN(Item."No.")) and ("No." <> '') then
                ItemDescriptionIsNo := Item.GET(Description)
              else
                ItemDescriptionIsNo := false;

              if ("No." <> '') and (not ItemDescriptionIsNo) and (Description <> '') then begin
                Item.SETFILTER(Description,'''@' + CONVERTSTR(Description,'''','?') + '*''');
                if not Item.FINDFIRST then
                  exit;
                if Item."No." = "No." then
                  exit;
                //>>HEI.34
                if GUIALLOWED then begin
                //<<HEI.34
                  if CONFIRM(AnotherItemWithSameDescrQst,false,Item."No.",Item.Description) then
                    VALIDATE("No.",Item."No.");
                  exit;
                //>>HEI.34
                end else begin
                  VALIDATE("No.",Item."No.");
                  exit;
                end;
                //<<HEI.34
              end;

              GetSalesSetup;
              DefaultCreate := ("No." = '') and SalesSetup."Create Item from Description";
              if Item.TryGetItemNoOpenCard(ReturnValue,Description,DefaultCreate,not HideValidationDialog) then
                case ReturnValue of
                  '':
                    begin
                      LookupRequested := true;
                      Description := xRec.Description;
                    end;
                  "No.":
                    Description := xRec.Description;
                  else begin
                    CurrFieldNo := FIELDNO("No.");
                    VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN(Item."No.")));
                  end;
                end;
            end;
          else
            if "No." = '' then
              if TypeHelper.FindRecordByDescription(ReturnValue,Type,Description) = 1 then begin
                CurrFieldNo := FIELDNO("No.");
                VALIDATE("No.",COPYSTR(ReturnValue,1,MAXSTRLEN("No.")));
              end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on "Quantity(Field 15).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;

        CheckAssocPurchOrder(FIELDCAPTION(Quantity));

        IF "Shipment No." <> '' THEN
          CheckShipmentRelation
        ELSE
          IF "Return Receipt No." <> '' THEN
            CheckRetRcptRelation;

        "Quantity (Base)" := CalcBaseQty(Quantity);

        IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
          IF (Quantity * "Return Qty. Received" < 0) OR
             ((ABS(Quantity) < ABS("Return Qty. Received")) AND ("Return Receipt No." = ''))
          THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Return Qty. Received")));
          IF ("Quantity (Base)" * "Return Qty. Received (Base)" < 0) OR
             ((ABS("Quantity (Base)") < ABS("Return Qty. Received (Base)")) AND ("Return Receipt No." = ''))
          THEN
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text003,FIELDCAPTION("Return Qty. Received (Base)")));
        END ELSE BEGIN
          IF (Quantity * "Quantity Shipped" < 0) OR
             ((ABS(Quantity) < ABS("Quantity Shipped")) AND ("Shipment No." = ''))
          THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Quantity Shipped")));
          IF ("Quantity (Base)" * "Qty. Shipped (Base)" < 0) OR
             ((ABS("Quantity (Base)") < ABS("Qty. Shipped (Base)")) AND ("Shipment No." = ''))
          THEN
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text003,FIELDCAPTION("Qty. Shipped (Base)")));
        END;

        IF (Type = Type::"Charge (Item)") AND (CurrFieldNo <> 0) THEN BEGIN
          IF (Quantity = 0) AND ("Qty. to Assign" <> 0) THEN
            FIELDERROR("Qty. to Assign",STRSUBSTNO(Text009,FIELDCAPTION(Quantity),Quantity));
          IF (Quantity * "Qty. Assigned" < 0) OR (ABS(Quantity) < ABS("Qty. Assigned")) THEN
            FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Qty. Assigned")));
        END;

        AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
        IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
          InitOutstanding;
          IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
            InitQtyToReceive
          ELSE
            InitQtyToShip;
          InitQtyToAsm;
          SetDefaultQuantity;
        END;

        CheckItemAvailable(FIELDNO(Quantity));

        IF (Quantity * xRec.Quantity < 0) OR (Quantity = 0) THEN
          InitItemAppl(FALSE);

        IF Type = Type::Item THEN BEGIN
          UpdateUnitPrice(FIELDNO(Quantity));
          IF (xRec.Quantity <> Quantity) OR (xRec."Quantity (Base)" <> "Quantity (Base)") THEN BEGIN
            ReserveSalesLine.VerifyQuantity(Rec,xRec);
            IF NOT "Drop Shipment" THEN
              UpdateWithWarehouseShip;
            WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
            IF ("Quantity (Base)" * xRec."Quantity (Base)" <= 0) AND ("No." <> '') THEN BEGIN
              GetItem;
              IF (Item."Costing Method" = Item."Costing Method"::Standard) AND NOT IsShipment THEN
                GetUnitCost;
            END;
          END;
          VALIDATE("Qty. to Assemble to Order");
          IF (Quantity = "Quantity Invoiced") AND (CurrFieldNo <> 0) THEN
            CheckItemChargeAssgnt;
          CheckApplFromItemLedgEntry(ItemLedgEntry);
        END ELSE
          VALIDATE("Line Discount %");

        IF (xRec.Quantity <> Quantity) AND (Quantity = 0) AND
           ((Amount <> 0) OR ("Amount Including VAT" <> 0) OR ("VAT Base Amount" <> 0))
        THEN BEGIN
          Amount := 0;
          "Amount Including VAT" := 0;
          "VAT Base Amount" := 0;
        END;

        UpdatePrePaymentAmounts;

        CheckWMS;

        UpdatePlanned;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        //HEI.14>>
        if "TIN No." = '' then
          UpdateTINBAndVATProdPostGrByLocation;
        //HEI.14<<
        //<< DITW18.00.07 VSC 03/03/2016 DIT-770 #1702
        UpdateOriginalQuantity;
        //>> DITW18.00.07 VSC DIT-770 #1702

        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.26 DDR 31/10/2008
        TestDelayedLine();
        // >>DITW15.00.00.26 DDR

        //<< DITW18.00.07 AKH 29/02/2016 DIT-770 #1425
        if not UpdateAssocPurchOrder(FIELDCAPTION(Quantity)) then
        //>> DITW18.00.07 AKH DIT-770 #1425
          CheckAssocPurchOrder(FIELDCAPTION(Quantity));
        // <<DITW17.10.05 WSA 23/02/2015 DIT-770 #779
        if not BatchInsertCheckSuspended then
        // >>DITW17.10.05 WSA 23/02/2015 DIT-770 #779
          // <<DITW17.10.05 WSA 25/11/2014 DIT-770 #779
          CheckAssocEvent(FIELDCAPTION(Quantity));
          // >>DITW17.10.05 WSA 25/11/2014 DIT-770 #779

        // <<DITW17.00.02 DDR 28/11/2013 DIT-715 #273
        if not BatchInsertCheckSuspended then
        // >>DITW17.00.02 DDR DIT-715 #273
          if "Shipment No." <> '' then
            CheckShipmentRelation
          else
            if "Return Receipt No." <> '' then
              CheckRetRcptRelation;
        #11..13
        if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then begin
          if (Quantity * "Return Qty. Received" < 0) or
             ((ABS(Quantity) < ABS("Return Qty. Received")) and ("Return Receipt No." = ''))
          then
            FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Return Qty. Received")));
          if ("Quantity (Base)" * "Return Qty. Received (Base)" < 0) or
             ((ABS("Quantity (Base)") < ABS("Return Qty. Received (Base)")) and ("Return Receipt No." = ''))
          then
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text003,FIELDCAPTION("Return Qty. Received (Base)")));
        end else begin
          if (Quantity * "Quantity Shipped" < 0) or
             ((ABS(Quantity) < ABS("Quantity Shipped")) and ("Shipment No." = ''))
          then
            FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Quantity Shipped")));
          if ("Quantity (Base)" * "Qty. Shipped (Base)" < 0) or
             ((ABS("Quantity (Base)") < ABS("Qty. Shipped (Base)")) and ("Shipment No." = ''))
          then
            FIELDERROR("Quantity (Base)",STRSUBSTNO(Text003,FIELDCAPTION("Qty. Shipped (Base)")));
        end;

        // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        if "Document Type" = "Document Type"::Order then begin
          if "ARC No." <> '' then begin
            // <<DITW16.00.00.43 DDR 18/10/2013 DIT-715 #812
            if ArcSentFromThis() then
            // >>DITW16.00.00.43 DDR DIT-715 #812
            TESTFIELD(Quantity,xRec.Quantity)
          end else
            if "LRN No." <> '' then
              TestStatusModifyEmcs(FIELDCAPTION(Quantity));
        end;
        // >>DITW16.00.00.43 DDR DIT-715 #720

        // <<DITW15.00.00.01 DDR 24/01/2008 - DITW15.00.00.24 DDR 06/10/2008
        if (Quantity <> 1) and (CurrFieldNo <> 0) then
          case "Extra Charge Type" of
            "Extra Charge Type"::"Fixed Amount":
              TESTFIELD(Quantity, 1);
            "Extra Charge Type"::VolumeHL:
              begin
                // <<DITW17.10.03 DDR 13/06/2014 DIT-770 #570
                if ("Attached to Line No." <> 0) and not "Manual Item Charge" then begin
                // >>DITW17.10.03 DDR DIT-770 #570
                  SalesLine2.GET("Document Type","Document No.","Attached to Line No.");
                  SalesLine2.TESTFIELD("Unit Volume HL");
                  TESTFIELD(Quantity, SalesLine2."Unit Volume HL");
                end;
              end;
          end;
        // >>DITW15.00.00.24 DDR

        // <<DITW15.00.00.19 DDR 19/05/2008 - DITW15.00.00.26 DDR 31/10/2008 - DITW114.00.15 DDR 24/04/2020 29/04/2020 NRQ#102424
        //HEI.40>>
        // IF (CurrFieldNo = FIELDNO(Quantity)) AND
        //   (xRec.Quantity <> Quantity) AND (Quantity <> 0) AND
        //   ((Type <> Type::Item) OR ("Qty. Shipped Not Invoiced" = 0)) AND
        //   NOT ("Item Charge Type" IN ["Item Charge Type"::" ","Item Charge Type"::Promotion]) AND NOT "Free Item" AND
        //   NOT (("Item Charge Calculate per" IN ["Item Charge Calculate per"::DelayOrder,"Item Charge Calculate per"::Period]))
        // THEN
        //  TESTFIELD(Quantity, xRec.Quantity);
        //HEI.40<<
        // >>DITW15.00.00.26 DDR - DITW114.00.15 DDR NRQ#102424

        // <<DITW15.00.00.39 DDR 10/05/2011 #718
        if "Is Item Charge" and (Quantity < 0) then
          VALIDATE("Prepayment %",0);
        // >>DITW15.00.00.39 DDR #718

        // <<DITW15.00.00.39 DDR 12/04/2011 #1303
        if (Type = Type::Item) and (Quantity = 0) and (xRec.Quantity <> Quantity) and
          ("Quantity Invoiced" = 0) and ("Quantity Shipped" = 0) and ("Return Qty. Received" = 0) and
          ("Appl.-to Item Entry" = 0) and ("Appl.-from Item Entry" = 0) and
          ("Shipment No." = '') and ("Return Receipt No." = '') and
          // <<DITW17.10.03 DDR 26/06/2014 DIT-770 #570
          //>> HEI.22
          //<<DITW110.00.12A MSF 17/07/2018 NRQ#78507
          //(CurrFieldNo <> 0) AND ("Line No." <> 0)
          ("Line No." <> 0)
          //>>DITW110.00.12A MSF 17/07/2018 NRQ#78507
          //<< HEI.22
          // >>DITW17.10.03 DDR DIT-770 #570
        then begin
          CLEAR(SaveTempSalesChargeLine);
          SaveTempSalesChargeLine.DELETEALL;
          TransferTaxCharges.ClearBuffer();
          TransferDepositCharges.ClearBuffer();
          TransferDiscountCharges.ClearBuffer();
          TransferPromotionCharges.ClearBuffer();
          DeleteAllChargeSalesLines(Rec,true);
          // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #691
          //HEI.01>>
          InsertEmpts2SalesLnWithChrgItm.DeleteAllEmptesAttachedChargeSalesLines(Rec,true);
          //DeleteAllEmptesAttachedChargeSalesLines(Rec,TRUE);
          //HEI.01<<
          if "Item Charge Value" <> "Unit Price" then
            VALIDATE("Unit Price","Item Charge Value");
          // >>DITW16.00.00.43 DDR DIT-715 #691
        end;
        // >>DITW15.00.00.39 DDR #1303

        if (Type = Type::"Charge (Item)") and (CurrFieldNo <> 0) then begin
          if (Quantity = 0) and ("Qty. to Assign" <> 0) then
            FIELDERROR("Qty. to Assign",STRSUBSTNO(Text009,FIELDCAPTION(Quantity),Quantity));
          if (Quantity * "Qty. Assigned" < 0) or (ABS(Quantity) < ABS("Qty. Assigned")) then
            FIELDERROR(Quantity,STRSUBSTNO(Text003,FIELDCAPTION("Qty. Assigned")));
        end;

        AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
        if (xRec.Quantity <> Quantity) or (xRec."Quantity (Base)" <> "Quantity (Base)") then begin
          InitOutstanding;
          if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then
            InitQtyToReceive
          else
        #47..49
          //<< DITW18.00.07 AKH 29/04/2016 DIT-770 #1346
          if "Document Type" = "Document Type"::Order then
            CalcDeliveryTimeQtyBase();
          //>> DITW18.00.07 AKH DIT-770 #1346
        end;

        // <<DITW16.00.00.40 DDR 16/04/2012 02/05/2012 DIT-715 #247
        if (Type = Type::Item) and (Quantity <> 0) and (xRec.Quantity <> Quantity) and
          ((Quantity < 0)  or ((xRec.Quantity * Quantity) <= -1)) and
          ("Quantity Invoiced" = 0) and ("Quantity Shipped" = 0) and ("Return Qty. Received" = 0) and
          ("Appl.-to Item Entry" = 0) and ("Appl.-from Item Entry" = 0) and
          ("Shipment No." = '') and ("Return Receipt No." = '')
        then begin
          GetItem();
          GetSalesHeader();
          GetLocation(SalesHeader."Location Code");
          if (("Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"]) xor (Quantity < 0)) then
            //<< DITW19.00.08 AKH 21/09/2016 BL#10756
            begin
            //>> DITW19.00.08 AKH BL#10756
              GetLocation(Item."Reverse Location Code");
            //<< DITW19.00.08 AKH 21/09/2016 BL#10756
              if (Location.Code='') then
                GetLocation(SalesHeader."Return Location Code");
            end
            //>>DITW19.00.08 AKH BL#10756
          else
            GetLocation(Item."Location Code");
          if ("Location Code" <> Location.Code) and (Location.Code <> '') and
          // <<DITW17.10.03 DDR 26/06/2014 DIT-770 #570
          (CurrFieldNo <> 0) and ("Line No." <> 0)
          // >>DITW17.10.03 DDR DIT-770 #570
          //<< DITW19.00.08 AKH 23/09/2016 - 09/12/2016 BL#10763
          and not (IsRetReasonWithLocation()) and (CurrFieldNo = FIELDNO(Quantity))
          //>> DITW19.00.08 AKH BL#10763
          then begin
            CLEAR(SaveTempSalesChargeLine);
            SaveTempSalesChargeLine.DELETEALL;
            TransferTaxCharges.ClearBuffer();
            TransferDepositCharges.ClearBuffer();
            TransferDiscountCharges.ClearBuffer();
            TransferPromotionCharges.ClearBuffer();
            DeleteAllChargeSalesLines(Rec,true);
            "Physical Location Group Code" := Location."Physical Location Group Code";
            VALIDATE("Location Code",Location.Code);
          end;
        end;
        // >>DITW16.00.00.40 DDR DIT-715 #247

        // <<DITW15.00.00.24 DDR 14/08/2008 - DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247
        GetLocation("Location Code");
        if Location."Directed Put-away and Pick" then
          CheckBinCubageWeight(xRec.Cubage,xRec.Weight);
        // >>DITW15.00.00.24 DDR

        // DITW16.00.00.43 DDR 31/01/2014 DIT-715 #856 - DITW19.00.08 DDR 05/08/2016 BL#9865
        //CheckItemAvailable(FIELDNO(Quantity));

        if (Quantity * xRec.Quantity < 0) or (Quantity = 0) then
          InitItemAppl(false);

        if Type = Type::Item then begin
          // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
          if "Free Item" and
            (CurrFieldNo <> FIELDNO("Free Item")) and
            (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
            (CurrFieldNo <> FIELDNO("Free Reason Code"))
          then
            VALIDATE("Free Item Posting Type");
          // >>DITW18.00.07A DDR DIT-770 #2074
          // <<DITW18.00.07 MVN 24/03/2016 DIT-770 #1918: Moved Code here
          if "Allow Loyalty" then begin
            VALIDATE("Loyalty Unit Point");
            VALIDATE("Loyalty Unit Amount");
          end;
          // >>DITW18.00.07 MVN DIT-770 #1918

          //<< DITW18.00.07 VSC 08/04/2016 DIT-770 #1364
          CheckItemAvailable(FIELDNO(Quantity));
          //>> DITW18.00.07 VSC DIT-770 #1364

          /// DITW16.00.00.43 DDR 05/11/2013 DIT-715 #812 - DITW110.00.11 DDR 10/08/2017 NRQ#24875

          // <<DITW114.00.15 DDR 24/04/2020 NRQ#102424
          if (not "Drop Shipment") and (Type = Type::Item) and ("Item Charge Type" = "Item Charge Type"::" ") then
            UpdateWithWarehouseShip;
          // >>DITW114.00.15 DDR NRQ#102424

          UpdateUnitPrice(FIELDNO(Quantity));
          // <<DITW16.00.00.43 DDR 31/01/2014 DIT-715 #856
          {
          //<<DITW110.00.12A MSF 17/07/2018 NRQ#78507
          IF (Type = Type::Item) AND (Quantity <> 0) AND (xRec.Quantity <> Quantity) AND ("Line No." <> 0) AND
             ("Attached to Line No." = 0) AND NOT BatchInsertCheckSuspended AND (CurrFieldNo = 0) AND
             (("Quantity Invoiced" <> 0) OR ("Quantity Shipped" <> 0) OR ("Return Qty. Received" <> 0)) AND
             ("Appl.-to Item Entry" = 0) AND ("Appl.-from Item Entry" = 0)
          THEN
            UpdateCharges2(FIELDNO(Quantity),FALSE);
          //>>DITW110.00.12A MSF 17/07/2018 NRQ#78507
          }
          // <<DITW110.00.12 DDR 05/03/2018 NRQ#13043
          if (Type = Type::Item) and (Quantity <> xRec.Quantity) and (Quantity <> 0) and
            not BatchInsertCheckSuspended and "Disc.Promo. Order Calculated"
          then begin
            if xRec.Quantity = 0 then begin
              "Disc.Promo. Order Calculated" := false;
              if "Order No." = '' then
                "Order Line No." := 0;
            end;
            UpdateCharges(FIELDNO(Quantity),not (("Item Charge Type" = "Item Charge Type"::Promotion) and ("Attached to Line No." <> 0)));
          end;
          // >>DITW110.00.12 DDR NRQ#13043

          // <<DITW17.10.03 DDR 13/06/2014 DIT-770 #392
          CheckItemQuotaAvail(FIELDNO(Quantity));
          // >>DITW17.10.03 DDR DIT-770 #392
          //<< DITW18.00.07 VSC 08/04/2016 DIT-770 #1364
          //CheckItemAvailable(FIELDNO(Quantity));
          //>> DITW18.00.07 VSC DIT-770 #1364
          UpdateAmounts();

          // >>DITW16.00.00.43 DDR DIT-715 #856
          if (xRec.Quantity <> Quantity) or (xRec."Quantity (Base)" <> "Quantity (Base)") then begin
            // <<DITW15.00.00.35 DDR 17/07/2009
            if not "Is Item Charge" then
            // >>DITW15.00.00.35 DDR
              ReserveSalesLine.VerifyQuantity(Rec,xRec);
            // <<DITW15.00.00.37 DDR 30/04/2010 - DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247
            if not (BatchInsertCheckSuspended and "Is Item Charge") then
            // >>DITW15.00.00.37 DDR - DITW16.00.00.40 DDR DIT-715 #247
              if not "Drop Shipment" then
                UpdateWithWarehouseShip;
            // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
            UpdateRoutePlanRqstLines(FIELDNO(Quantity));
            // >>DITW18.00.07 DDR DIT-770 #1488
            // <<DITW15.00.00.35 DDR 17/07/2009
            if not "Is Item Charge" then
            // >>DITW15.00.00.35 DDR
              //<< DITW18.00.07 VSC 01/02/2016 DIT-770 #1702
              if not ChangedFromWarehouse then
                WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
              //>> DITW18.00.07 VSC DIT-770 #1702

            if ("Quantity (Base)" * xRec."Quantity (Base)" <= 0) and ("No." <> '') then begin
              GetItem;
              if (Item."Costing Method" = Item."Costing Method"::Standard) and not IsShipment then
                GetUnitCost;
            end;
            // <<DITW16.00.00.43 DDR 12/08/2013 DIT-715 #720
            VALIDATE("Packaging Type Code");
            // >>DITW16.00.00.43 DDR DIT-715 #720
            //<<FINXL9.00.000.01 ACH 10/01/2017
            if recFinXLSetup.READPERMISSION then
              recFinXLSetup.GET;
            if recFinXLSetup."Recycle Charges" then
              if (("Document Type" = "Document Type"::Order) and (not cduSalesHook.fctCheckChargesSalesLine(Rec))
                and ("Recycle Chrg. Attach. Line No." = 0)
                and (xRec.Quantity <> Quantity) and ("Line No." <> 0))then begin
                  cduSalesHook.fctRecycleChargeUpdateSalesLine(Rec,FIELDNAME(Quantity));
              end;
            //>>FINXL9.00.000.01 ACH 10/01/2017
          end;
          VALIDATE("Qty. to Assemble to Order");
          if (Quantity = "Quantity Invoiced") and (CurrFieldNo <> 0) then
            CheckItemChargeAssgnt;
          CheckApplFromItemLedgEntry(ItemLedgEntry);
        // <<DITW15.00.00.19 DDR 22/05/2008 - DITW15.00.00.29 DDR 12/12/2008
        //END ELSE
        //  VALIDATE("Line Discount %");
        end else begin
            if (not "Drop Shipment") and "Is Item Charge" and
               ((xRec.Quantity <> Quantity) or (xRec."Quantity (Base)" <> "Quantity (Base)"))
            then
              UpdateWithWarehouseShip;
          VALIDATE("Line Discount %");
        end;
        // >>DITW15.00.00.29 DDR

        if (xRec.Quantity <> Quantity) and (Quantity = 0) and
           ((Amount <> 0) or ("Amount Including VAT" <> 0) or ("VAT Base Amount" <> 0))
        then begin
        #80..82
        end;

        // <<DITW15.00.00.39 DDR 23/09/2011 #1258
        if "Return Reason Code" <> '' then
          VALIDATE("Return Reason Code");
        // >>DITW15.00.00.39 DDR  #1258

        // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        if (Type = Type::Item) and "Is Item Charge" then begin
          CalcCubageWeight();
          //<<DITW17.00.02 SR 08/01/2014 DIT-770 #189
          CalcHLCubage;
          CalcEqVUOMQuantity;
          //>>DITW17.00.02 SR 08/01/2014 DIT-770 #189
          // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
          UpdateRoutePlanRqstLines(FIELDNO(Quantity));
          // >>DITW18.00.07 DDR DIT-770 #1488
         end;
        // >>DITW16.00.00.40 DDR DIT-715 #172

        // <<DITW15.00.00.36 DDR 21/12/2009
        if (Type = Type::Item) and
          "Free Item" and
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925
          ("Attached to Line No." <> 0)  and
          // >>DITW110.00.11 DDR NRQ#37925
          // <<DITW114.00.15 DDR 29/04/2020 NRQ#102424
          ((CurrFieldNo = 0) or ((CurrFieldNo <> 0) and (("Quantity Shipped"+"Return Qty. Received") <> 0)))
          // >>DITW114.00.15 DDR NRQ#102424
        then
          // <<DITW114.00.15 DDR 29/04/2020 NRQ#102424
          UpdateCharges(FIELDNO(Quantity),(CurrFieldNo <> 0));
          // >>DITW114.00.15 DDR NRQ#102424
        // >>DITW15.00.00.36 DDR
        #84..89

        //<< DITW17.00.02 TEC1 10/09/2013 DIT-770 #148 - DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        ValidateShipmentDateReturn();
        //>> DITW17.00.02 TEC1 DIT-770 #148 - DITW18.00.07 DDR DIT-770 #1488

        //<<DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
        if (Quantity > 0) and  ("Document Type" <> "Document Type" ::"Return Order") and (CurrFieldNo <> 0 ) then
          UpdateEventLine(0,"Event Doc. No.","Event Doc. Line No.",CurrFieldNo,false);
        //>>DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Outstanding Quantity"(Field 16)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.24 DDR 14/08/2008
        CalcCubageWeight();
        // >>DITW15.00.00.24 DDR
        //<<DITW17.00.02 SR 08/01/2014 DIT-770 #189
        CalcHLCubage();
        CalcEqVUOMQuantity;
        //>>DITW17.00.02 SR 08/01/2014 DIT-770 #189
        // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
        if (xRec."Outstanding Quantity" <> "Outstanding Quantity") and (CurrFieldNo <> 0) then
          UpdateRoutePlanRqstLines(FIELDNO("Outstanding Quantity"));
        // >>DITW18.00.07 DDR DIT-770 #1488
        //<< DITW18.00.07 AKH 10/05/2016 DIT-770 #1346
        if "Document Type" = "Document Type"::Order then
          CalcDeliveryTimeQtyBase();
        //>> DITW18.00.07 AKH DIT-770 #1346

        /// DITW18.00.07 VSC 02/06/2016 DIT-770 #1932 - DITW110.00.09 DDR 13/04/2017 NRQ#13107
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Invoice"(Field 17).OnValidate". Please convert manually.

        //trigger  to Invoice"(Field 17)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Qty. to Invoice" = MaxQtyToInvoice THEN
          InitQtyToInvoice
        ELSE
          "Qty. to Invoice (Base)" := CalcBaseQty("Qty. to Invoice");
        IF ("Qty. to Invoice" * Quantity < 0) OR
           (ABS("Qty. to Invoice") > ABS(MaxQtyToInvoice))
        THEN
          ERROR(
            Text005,
            MaxQtyToInvoice);
        IF ("Qty. to Invoice (Base)" * "Quantity (Base)" < 0) OR
           (ABS("Qty. to Invoice (Base)") > ABS(MaxQtyToInvoiceBase))
        THEN
          ERROR(
            Text006,
            MaxQtyToInvoiceBase);
        "VAT Difference" := 0;
        CalcInvDiscToInvoice;
        CalcPrepaymentToDeduct;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Qty. to Invoice" = MaxQtyToInvoice then
          InitQtyToInvoice
        else
          "Qty. to Invoice (Base)" := CalcBaseQty("Qty. to Invoice");
        if ("Qty. to Invoice" * Quantity < 0) or
           (ABS("Qty. to Invoice") > ABS(MaxQtyToInvoice))
        then
        #8..10
        if ("Qty. to Invoice (Base)" * "Quantity (Base)" < 0) or
           (ABS("Qty. to Invoice (Base)") > ABS(MaxQtyToInvoiceBase))
        then
        #14..19

        //<<FINXL9.00.000.01 ACH 10/01/2017
        if recFinXLSetup.READPERMISSION then
          recFinXLSetup.GET;
        if recFinXLSetup."Recycle Charges" then
          if (("Document Type" = "Document Type"::Order) and (not cduSalesHook.fctCheckChargesSalesLine(Rec))
            and ("Recycle Chrg. Attach. Line No." = 0)
            and (xRec."Qty. to Invoice" <> "Qty. to Invoice") and ("Line No." <> 0))then begin
            cduSalesHook.fctRecycleChargeUpdateSalesLine(Rec,FIELDNAME("Qty. to Invoice"));
          end;
        //>>FINXL9.00.000.01 ACH 10/01/2017

        // <<DITW15.00.00.01 DDR 04/01/2008 - 15/01/2008
        // <<DITW15.00.00.19 DDR 07/04/2008 - DITW15.00.00.23 DDR 08/08/2008 - DITW15.00.00.36 DDR 22/12/2009
        // <<DITW15.00.00.37 DDR 22/01/2010
        // <<DITW15.00.00.39 DDR 29/06/2011 #1308
        // <<DITW16.00.00.40 DDR 23/05/2012 DIT-715 #345
        if (Type = Type::Item) and ("Qty. to Invoice" <> xRec."Qty. to Invoice") and
          (CurrFieldNo <> FIELDNO(Quantity)) and
          not BatchInsertCheckSuspended
        then
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925 - DITW114.00.15 DDR 29/04/2020 NRQ#102424
          UpdateCharges(FIELDNO("Qty. to Invoice"),not ISTEMPORARY);
          // >>DITW110.00.11 DDR NRQ#37925 - DITW114.00.15 DDR NRQ#102424
        // >>DITW15.00.00.37 DDR - DITW15.00.00.39 DDR #1308 - DITW16.00.00.40 DDR DIT-715 #345

        //<<DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
        UpdateEventLine(0,"Event Doc. No.","Event Doc. Line No.",CurrFieldNo,false);
        //>>DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
        // <<DITW15.00.00.01 DDR 10/01/2008 - 31/01/2008
        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.35 DDR 15/10/2009 - DITW15.00.00.36 DDR 18/11/2009 - 21/12/2009
        // <<DITW15.00.00.37 DDR 28/04/2010
        if ((Type <> Type::Item) and "Is Item Charge") or
          ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item)
        then begin
          if CurrFieldNo <> 0 then begin
            UpdateItemChargeAssgnt();
            if CurrFieldNo <> FIELDNO(Quantity) then
              SaveItemChargeAssgnt();
          end else
            if not BatchInsertCheckSuspended then
              AutoSuggestItemChargeAssgnt(GetItemChargeAssgntType());
        end;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Ship"(Field 18).OnValidate". Please convert manually.

        //trigger  to Ship"(Field 18)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetLocation("Location Code");
        IF (CurrFieldNo <> 0) AND
           (Type = Type::Item) AND
           (NOT "Drop Shipment")
        THEN BEGIN
          IF Location."Require Shipment" AND
             ("Qty. to Ship" <> 0)
          THEN
            CheckWarehouse;
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        END;

        IF "Qty. to Ship" = "Outstanding Quantity" THEN
          InitQtyToShip
        ELSE BEGIN
          "Qty. to Ship (Base)" := CalcBaseQty("Qty. to Ship");
          CheckServItemCreation;
          InitQtyToInvoice;
        END;
        IF ((("Qty. to Ship" < 0) XOR (Quantity < 0)) AND (Quantity <> 0) AND ("Qty. to Ship" <> 0)) OR
           (ABS("Qty. to Ship") > ABS("Outstanding Quantity")) OR
           (((Quantity < 0) XOR ("Outstanding Quantity" < 0)) AND (Quantity <> 0) AND ("Outstanding Quantity" <> 0))
        THEN
          ERROR(
            Text007,
            "Outstanding Quantity");
        IF ((("Qty. to Ship (Base)" < 0) XOR ("Quantity (Base)" < 0)) AND ("Qty. to Ship (Base)" <> 0) AND ("Quantity (Base)" <> 0)) OR
           (ABS("Qty. to Ship (Base)") > ABS("Outstanding Qty. (Base)")) OR
           ((("Quantity (Base)" < 0) XOR ("Outstanding Qty. (Base)" < 0)) AND ("Quantity (Base)" <> 0) AND ("Outstanding Qty. (Base)" <> 0))
        THEN
          ERROR(
            Text008,
            "Outstanding Qty. (Base)");

        IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND ("Qty. to Ship" < 0) THEN
          CheckApplFromItemLedgEntry(ItemLedgEntry);

        ATOLink.UpdateQtyToAsmFromSalesLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetLocation("Location Code");
        //<< DITW18.00.07 VSC 28/01/2016 DIT-770 #1702
        ValidateMancoSurplusTolerance;
        //>> DITW18.00.07 VSC DIT-770 #1702

        if (CurrFieldNo <> 0) and
           (Type = Type::Item) and
           (not "Drop Shipment")
        then begin
          if Location."Require Shipment" and
             ("Qty. to Ship" <> 0)
          then
            CheckWarehouse;
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        end;

        if "Qty. to Ship" = "Outstanding Quantity" then
          InitQtyToShip
        else begin
        #16..18
        end;
        if ((("Qty. to Ship" < 0) xor (Quantity < 0)) and (Quantity <> 0) and ("Qty. to Ship" <> 0)) or
           (ABS("Qty. to Ship") > ABS("Outstanding Quantity")) or
           (((Quantity < 0) xor ("Outstanding Quantity" < 0)) and (Quantity <> 0) and ("Outstanding Quantity" <> 0))
        then
        #24..26
        if ((("Qty. to Ship (Base)" < 0) xor ("Quantity (Base)" < 0)) and ("Qty. to Ship (Base)" <> 0) and ("Quantity (Base)" <> 0)) or
           (ABS("Qty. to Ship (Base)") > ABS("Outstanding Qty. (Base)")) or
           ((("Quantity (Base)" < 0) xor ("Outstanding Qty. (Base)" < 0)) and ("Quantity (Base)" <> 0) and ("Outstanding Qty. (Base)" <> 0))
        then
        #31..34
        if (CurrFieldNo <> 0) and (Type = Type::Item) and ("Qty. to Ship" < 0) then
          CheckApplFromItemLedgEntry(ItemLedgEntry);

        // <<DITW15.00.00.01 DDR 04/01/2008 - 15/01/2008
        // <<DITW15.00.00.19 DDR 07/04/2008 - DITW15.00.00.23 DDR 08/08/2008 - DITW15.00.00.36 DDR 22/12/2009
        // <<DITW15.00.00.37 DDR 22/01/2010 - 11/03/2010 - 18/06/2010
        // <<DITW15.00.00.38 DDR 13/10/2010 #1231
        // <<DITW15.00.00.39 DDR 29/06/2011 #1308
        // <<DITW16.00.00.40 DDR 23/05/2012 DIT-715 #275-DITW111.00.13A MSF 22/04/2019 NRQ#108355
        if (Type = Type::Item) and
        //>>DITW111.00.13A MSF 22/04/2019 NRQ#108355
          (CurrFieldNo <> FIELDNO(Quantity)) and
          not BatchInsertCheckSuspended
        then
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925 - DITW114.00.15 DDR 29/04/2020 NRQ#102424
          UpdateCharges(FIELDNO("Qty. to Ship"),not ISTEMPORARY);
          // >>DITW110.00.11 DDR NRQ#37925 - DITW114.00.15 DDR NRQ#102424
        // >>DITW15.00.00.38 DDR #1231 - DITW15.00.00.39 DDR #1308 - DITW16.00.00.40 DDR DIT-715 #275

        //<<DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
        UpdateEventLine(0,"Event Doc. No.","Event Doc. Line No.",CurrFieldNo,false);
        //>>DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
        ATOLink.UpdateQtyToAsmFromSalesLine(Rec);

        //<<FINXL9.00.000.01 ACH 10/01/2017
        if recFinXLSetup.READPERMISSION then
          recFinXLSetup.GET;
        if recFinXLSetup."Recycle Charges" then
          if (("Document Type" = "Document Type"::Order) and (not cduSalesHook.fctCheckChargesSalesLine(Rec))
            and ("Recycle Chrg. Attach. Line No." = 0)
            and (xRec."Qty. to Ship" <> "Qty. to Ship") and ("Line No." <> 0))then begin
            cduSalesHook.fctRecycleChargeUpdateSalesLine(Rec,FIELDNAME("Qty. to Ship"));
          end;
        //>>FINXL9.00.000.01 ACH 10/01/2017
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Price"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        VALIDATE("Line Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.26 DDR 31/10/2008
        TestDelayedLine();
        // >>DITW15.00.00.26 DDR
        // <<DITW15.00.00.01 DDR 18/12/2007 - 15/01/2008 - 25/01/2008 - DITW15.00.00.34 DDR 12/06/2009
        // 13-12-05, VS B: Alleen handmatige wijzigingen overnemen. Anders van toeslag
        if ("Extra Charge Type" <> "Extra Charge Type"::Amount) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Fixed Amount") and
           ("Extra Charge Type" <> "Extra Charge Type"::VolumeHL) and
           ("Extra Charge Type" <> "Extra Charge Type"::"Price Item") and
           (CurrFieldNo = FIELDNO("Unit Price")) and
           "Is Item Charge"
        then
          FIELDERROR("Extra Charge Type");
        // >>DITW15.00.00.34 DDR

        // <<DITW16.00.00.43 DDR 14/08/2013 DIT-715 #605
        if (xRec."Unit Price" <> "Unit Price") and (CurrFieldNo = FIELDNO("Unit Price")) then
          "Manual Unit Price" := true;
        if ("Unit Price" = 0) and (CurrFieldNo = FIELDNO("Unit Price")) then
          "Manual Unit Price" := true;
        // >>DITW16.00.00.43 DDR DIT-715 #605

        // <<DITW15.00.00.01 DDR 01/02/2008 - 21/03/2008
        // <<DITW15.00.00.01 DDR 08/02/2008
        GetSalesHeader();
        if CurrFieldNo = FIELDNO("Unit Price") then begin
          // <<DITW15.00.00.35 DDR 25/06/2009 - 09/10/2009 - DITW16.00.00.40 DDR 25/01/2012 DIT-715 #172
          if "Free Item" and ("Free Item Posting Type" = "Free Item Posting Type"::Price) then
            ERROR(Text028,FIELDCAPTION("Unit Price"),FIELDCAPTION("Free Item"));
          // >>DITW16.00.00.40 DDR DIT-715 #172

          if not "Is Item Charge" then
            "Item Charge Value" := "Unit Price"
          else
            // <<DITW15.00.00.30 DDR 16/01/2009
            UpdateItemChargeValue();
            // >>DITW15.00.00.30 DDR

          // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
          if (Type = Type::Item) and ("Unit Price" <> xRec."Unit Price") and not BatchInsertCheckSuspended then
          // >>DITW110.00.11 DDR NRQ#24875
            CheckNoItemChargeInclPrice(FIELDCAPTION("Unit Price"));
        end;
        // >>DITW15.00.00.19 DDR
        // <<DITW19.00.08 DDR 05/08/2016 BL#9865
        // <<DITW17.10.05 DDR 30/07/2014 DIT-770 #826
        if (Type = Type::Item) and ("Unit Price" <> xRec."Unit Price") then
          UpdateCharges(FIELDNO("Unit Price"),false);
        // >>DITW17.10.05 DDR DIT-770 #826

        VALIDATE("Line Discount %");
        // >>DITW19.00.08 DDR BL#9865

        // <<DITW16.00.00.43 DDR 23/08/2013 DIT-715 #691
        // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
        if (Type = Type::"Charge (Item)") and
          //>> HEI.28
          //("Item Charge Type" <> "Item Charge Type"::" ") AND
          (("Item Charge Type" = "Item Charge Type"::Deposit) or
            ("Item Charge Type" = "Item Charge Type"::Tax) or
            ("Item Charge Type" = "Item Charge Type"::Discount)) and
          //<< HEI.28
          ("Unit Price" <> xRec."Unit Price") and
          (CurrFieldNo = FIELDNO("Unit Price"))
        then
          CalcBackUnitPriceItem();
        // >>DITW110.00.11 DDR NRQ#24875
        // >>DITW16.00.00.43 DDR DIT-715 #691

        // <<DITW15.00.00.25 DDR 30/10/2008 - DITW15.00.00.36 DDR 18/11/2009 - DITW15.00.00.37 DDR 08/02/2010 - 28/04/2010
        if ("Line No." <> 0) and
          (((Type <> Type::Item) and ("Is Item Charge")) or ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item))
        then
          UpdateItemChargeAssgnt;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost (LCY)"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo = FIELDNO("Unit Cost (LCY)")) AND
           ("Unit Cost (LCY)" <> xRec."Unit Cost (LCY)")
        THEN
          CheckAssocPurchOrder(FIELDCAPTION("Unit Cost (LCY)"));

        IF (CurrFieldNo = FIELDNO("Unit Cost (LCY)")) AND
           (Type = Type::Item) AND ("No." <> '') AND ("Quantity (Base)" <> 0)
        THEN BEGIN
          TestJobPlanningLine;
          GetItem;
          IF (Item."Costing Method" = Item."Costing Method"::Standard) AND NOT IsShipment THEN BEGIN
            IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN
              ERROR(
                Text037,
                FIELDCAPTION("Unit Cost (LCY)"),Item.FIELDCAPTION("Costing Method"),
                Item."Costing Method",FIELDCAPTION(Quantity));
            ERROR(
              Text038,
              FIELDCAPTION("Unit Cost (LCY)"),Item.FIELDCAPTION("Costing Method"),
              Item."Costing Method",FIELDCAPTION(Quantity));
          END;
        END;

        GetSalesHeader;
        IF SalesHeader."Currency Code" <> '' THEN BEGIN
          Currency.TESTFIELD("Unit-Amount Rounding Precision");
          "Unit Cost" :=
            ROUND(
              CurrExchRate.ExchangeAmtLCYToFCY(
                GetDate,SalesHeader."Currency Code",
                "Unit Cost (LCY)",SalesHeader."Currency Factor"),
              Currency."Unit-Amount Rounding Precision")
        END ELSE
          "Unit Cost" := "Unit Cost (LCY)";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (CurrFieldNo = FIELDNO("Unit Cost (LCY)")) and
           ("Unit Cost (LCY)" <> xRec."Unit Cost (LCY)")
        then
          CheckAssocPurchOrder(FIELDCAPTION("Unit Cost (LCY)"));

        if (CurrFieldNo = FIELDNO("Unit Cost (LCY)")) and
           (Type = Type::Item) and ("No." <> '') and ("Quantity (Base)" <> 0)
        then begin
          TestJobPlanningLine;
          GetItem;
          if (Item."Costing Method" = Item."Costing Method"::Standard) and not IsShipment then begin
            if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then
        #13..20
          end;
        end;

        GetSalesHeader;
        if SalesHeader."Currency Code" <> '' then begin
        #26..32
        end else
          "Unit Cost" := "Unit Cost (LCY)";
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Line Discount %"(Field 27).OnValidate". Please convert manually.

        //trigger (Variable: lCurrUnitPrice)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount %"(Field 27).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        "Line Discount Amount" :=
          ROUND(
            ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") *
            "Line Discount %" / 100,Currency."Amount Rounding Precision");
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;

        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.26 DDR 31/10/2008
        TestDelayedLine();
        // >>DITW15.00.00.26 DDR

        // <<DITW15.00.00.19 DDR 07/04/2008
        GetSalesHeader;
        // <<DITW15.00.00.30 DDR 16/01/2009
        UpdateItemChargeValue();
        // >>DITW15.00.00.30 DDR

        // <<DITW17.00.02 DDR 10/07/2013 DIT-770 #114
        if (Type = Type::Item) and (not "Is Item Charge") and (not "Free Item") then
        // >>DITW17.00.02 DDR DIT-770 #114
          lCurrUnitPrice := "Item Charge Value"
        else
          lCurrUnitPrice := "Unit Price";

        if (CurrFieldNo = FIELDNO("Line Discount %")) then begin
          // <<DITW15.00.00.35 DDR 25/06/2009 - 09/10/2009
          if "Free Item"  then
            ERROR(Text028,FIELDCAPTION("Line Discount %"),FIELDCAPTION("Free Item"));
          // >>DITW15.00.00.35 DDR
          "Unit Price" := lCurrUnitPrice;
        end;

        // <<DITW15.00.00.19 DDR 07/04/2008
        //"Line Discount Amount" :=
        //  ROUND(
        //    ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") *
        //    "Line Discount %" / 100,Currency."Amount Rounding Precision");
        "Line Discount Amount" :=
          ROUND(
            ROUND(Quantity * lCurrUnitPrice,Currency."Amount Rounding Precision") *
              "Line Discount %" / 100,
              Currency."Amount Rounding Precision");
        // >>DITW15.00.00.19 DDR

        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;

        // <<DITW17.10.05 DDR 30/07/2014 DIT-770 #826
        if (Type = Type::Item) and (Quantity <> 0) and (CurrFieldNo <> 0) and
          (CurrFieldNo <> FIELDNO(Quantity)) and ("Line No." <> 0) and
          ((xRec."Line Amount" = 0) or (xRec."Line Discount %" = 100) or (xRec."Unit Price" = 0)) and
          (not BatchInsertCheckSuspended) and (not ForceDeleteItemCharges)
        then
          InsertCharges3(CurrFieldNo);
        // >>DITW17.10.05 DDR DIT-770 #826

        UpdateAmounts;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Line Discount Amount"(Field 28).OnValidate". Please convert manually.

        //trigger (Variable: lCurrUnitPrice)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Discount Amount"(Field 28).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        "Line Discount Amount" := ROUND("Line Discount Amount",Currency."Amount Rounding Precision");
        TestJobPlanningLine;
        TestStatusOpen;
        TESTFIELD(Quantity);
        IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
          IF ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") <> 0 THEN
            "Line Discount %" :=
              ROUND(
                "Line Discount Amount" / ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") * 100,
                0.00001)
          ELSE
            "Line Discount %" := 0;
        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4

        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.26 DDR 31/10/2008
        TestDelayedLine();
        // >>DITW15.00.00.26 DDR
        TESTFIELD(Quantity);

        // <<DITW15.00.00.30 DDR 16/01/2009
        UpdateItemChargeValue();
        // >>DITW15.00.00.30 DDR

        // <<DITW15.00.00.19 DDR 07/04/2008
        if (Type = Type::Item) and (not "Is Item Charge") then
          lCurrUnitPrice := "Item Charge Value"
        else
          lCurrUnitPrice := "Unit Price";

        if (CurrFieldNo = FIELDNO("Line Discount Amount")) or
           (CurrFieldNo = FIELDNO("Line Amount"))
        then begin
          // <<DITW15.00.00.35 DDR 25/06/2009 - 13/10/2009
          if "Free Item" then
            ERROR(Text028,FIELDCAPTION("Line Discount Amount"),FIELDCAPTION("Free Item"));
          // >>DITW15.00.00.35 DDR
          "Unit Price" := lCurrUnitPrice;
        end;

        // <<DITW15.00.00.19 DDR 07/04/2008
        //IF xRec."Line Discount Amount" <> "Line Discount Amount" THEN
        //  IF ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") <> 0 THEN
        //    "Line Discount %" :=
        //      ROUND(
        //        "Line Discount Amount" / ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") * 100,
        //        0.00001)
        //  ELSE
        //    "Line Discount %" := 0;
        if xRec."Line Discount Amount" <> "Line Discount Amount" then
          if ROUND(Quantity * lCurrUnitPrice,Currency."Amount Rounding Precision") <> 0 then
            "Line Discount %" :=
              ROUND(
                "Line Discount Amount" / ROUND(Quantity * lCurrUnitPrice,Currency."Amount Rounding Precision") * 100,
                0.00001)
          else
            "Line Discount %" := 0;
        // >>DITW15.00.00.19 DDR

        "Inv. Discount Amount" := 0;
        "Inv. Disc. Amount to Invoice" := 0;

        // <<DITW17.10.05 DDR 30/07/2014 DIT-770 #826
        if (Type = Type::Item) and (Quantity <> 0) and (CurrFieldNo <> 0) and
          (CurrFieldNo <> FIELDNO(Quantity)) and ("Line No." <> 0) and
          ((xRec."Line Amount" = 0) or (xRec."Line Discount %" = 100) or (xRec."Unit Price" = 0)) and
          (not BatchInsertCheckSuspended) and (not ForceDeleteItemCharges)
        then
          InsertCharges3(CurrFieldNo);
        // >>DITW17.10.05 DDR DIT-770 #826
        UpdateAmounts;
        */
        //end;


        //Unsupported feature: CodeModification on "Amount(Field 29).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Amount := ROUND(Amount,Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              "VAT Base Amount" :=
                ROUND(Amount * (1 - SalesHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                ROUND(Amount + "VAT Base Amount" * "VAT %" / 100,Currency."Amount Rounding Precision");
            END;
          "VAT Calculation Type"::"Full VAT":
            IF Amount <> 0 THEN
              FIELDERROR(Amount,
                STRSUBSTNO(
                  Text009,FIELDCAPTION("VAT Calculation Type"),
                  "VAT Calculation Type"));
          "VAT Calculation Type"::"Sales Tax":
            BEGIN
              SalesHeader.TESTFIELD("VAT Base Discount %",0);
              "VAT Base Amount" := ROUND(Amount,Currency."Amount Rounding Precision");
              "Amount Including VAT" :=
                Amount +
                SalesTaxCalculate.CalculateTax(
                  "Tax Area Code","Tax Group Code","Tax Liable",SalesHeader."Posting Date",
                  "VAT Base Amount","Quantity (Base)",SalesHeader."Currency Factor");
              IF "VAT Base Amount" <> 0 THEN
                "VAT %" :=
                  ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
              ELSE
                "VAT %" := 0;
              "Amount Including VAT" := ROUND("Amount Including VAT",Currency."Amount Rounding Precision");
            END;
        END;

        InitOutstandingAmount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.19 DDR 07/04/2008
        GetSalesHeader;
        // >>DITW15.00.00.19 DDR
        Amount := ROUND(Amount,Currency."Amount Rounding Precision");
        case "VAT Calculation Type" of
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            begin
        #6..9
            end;
          "VAT Calculation Type"::"Full VAT":
            if Amount <> 0 then
        #13..17
            begin
        #19..25
              if "VAT Base Amount" <> 0 then
                "VAT %" :=
                  ROUND(100 * ("Amount Including VAT" - "VAT Base Amount") / "VAT Base Amount",0.00001)
              else
                "VAT %" := 0;
              "Amount Including VAT" := ROUND("Amount Including VAT",Currency."Amount Rounding Precision");
            end;
        end;

        InitOutstandingAmount;
        */
        //end;


        //Unsupported feature: CodeModification on ""Amount Including VAT"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Amount Including VAT" := ROUND("Amount Including VAT",Currency."Amount Rounding Precision");
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            BEGIN
              Amount :=
                ROUND(
                  "Amount Including VAT" /
                  (1 + (1 - SalesHeader."VAT Base Discount %" / 100) * "VAT %" / 100),
                  Currency."Amount Rounding Precision");
              "VAT Base Amount" :=
                ROUND(Amount * (1 - SalesHeader."VAT Base Discount %" / 100),Currency."Amount Rounding Precision");
            END;
          "VAT Calculation Type"::"Full VAT":
            BEGIN
              Amount := 0;
              "VAT Base Amount" := 0;
            END;
          "VAT Calculation Type"::"Sales Tax":
            BEGIN
              SalesHeader.TESTFIELD("VAT Base Discount %",0);
              Amount :=
                SalesTaxCalculate.ReverseCalculateTax(
                  "Tax Area Code","Tax Group Code","Tax Liable",SalesHeader."Posting Date",
                  "Amount Including VAT","Quantity (Base)",SalesHeader."Currency Factor");
              IF Amount <> 0 THEN
                "VAT %" :=
                  ROUND(100 * ("Amount Including VAT" - Amount) / Amount,0.00001)
              ELSE
                "VAT %" := 0;
              Amount := ROUND(Amount,Currency."Amount Rounding Precision");
              "VAT Base Amount" := Amount;
            END;
        END;

        InitOutstandingAmount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW15.00.00.19 DDR 07/04/2008
        GetSalesHeader;
        // >>DITW15.00.00.19 DDR
        "Amount Including VAT" := ROUND("Amount Including VAT",Currency."Amount Rounding Precision");
        case "VAT Calculation Type" of
          "VAT Calculation Type"::"Normal VAT",
          "VAT Calculation Type"::"Reverse Charge VAT":
            begin
        #6..12
            end;
          "VAT Calculation Type"::"Full VAT":
            begin
              Amount := 0;
              "VAT Base Amount" := 0;
            end;
          "VAT Calculation Type"::"Sales Tax":
            begin
        #21..25
              if Amount <> 0 then
                "VAT %" :=
                  ROUND(100 * ("Amount Including VAT" - Amount) / Amount,0.00001)
              else
        #30..32
            end;
        end;

        InitOutstandingAmount;
        */
        //end;


        //Unsupported feature: CodeModification on ""Allow Invoice Disc."(Field 32).OnValidate". Please convert manually.

        //trigger "(Field 32)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF ("Allow Invoice Disc." <> xRec."Allow Invoice Disc.") AND
           (NOT "Allow Invoice Disc.")
        THEN BEGIN
          "Inv. Discount Amount" := 0;
          "Inv. Disc. Amount to Invoice" := 0;
          UpdateAmounts;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if ("Allow Invoice Disc." <> xRec."Allow Invoice Disc.") and
           (not "Allow Invoice Disc.")
        then begin
        #5..7
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Appl.-to Item Entry"(Field 38).OnValidate". Please convert manually.

        //trigger -to Item Entry"(Field 38)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Appl.-to Item Entry" <> 0 THEN BEGIN
          AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);

          TESTFIELD(Type,Type::Item);
          TESTFIELD(Quantity);
          IF "Document Type" IN ["Document Type"::"Return Order","Document Type"::"Credit Memo"] THEN BEGIN
            IF Quantity > 0 THEN
              FIELDERROR(Quantity,Text030);
          END ELSE BEGIN
            IF Quantity < 0 THEN
              FIELDERROR(Quantity,Text029);
          END;
          ItemLedgEntry.GET("Appl.-to Item Entry");
          ItemLedgEntry.TESTFIELD(Positive,TRUE);
          IF ItemLedgEntry.TrackingExists THEN
            ERROR(Text040,ItemTrackingLines.CAPTION,FIELDCAPTION("Appl.-to Item Entry"));
          IF ABS("Qty. to Ship (Base)") > ItemLedgEntry.Quantity THEN
            ERROR(ShippingMoreUnitsThanReceivedErr,ItemLedgEntry.Quantity,ItemLedgEntry."Document No.");

          VALIDATE("Unit Cost (LCY)",CalcUnitCost(ItemLedgEntry));

          "Location Code" := ItemLedgEntry."Location Code";
          IF NOT ItemLedgEntry.Open THEN
            MESSAGE(Text042,"Appl.-to Item Entry");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Appl.-to Item Entry" <> 0 then begin
        #2..5
          if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then begin
            if Quantity > 0 then
              FIELDERROR(Quantity,Text030);
          end else begin
            if Quantity < 0 then
              FIELDERROR(Quantity,Text029);
          end;
          ItemLedgEntry.GET("Appl.-to Item Entry");
          ItemLedgEntry.TESTFIELD(Positive,true);
          if ItemLedgEntry.TrackingExists then
            ERROR(Text040,ItemTrackingLines.CAPTION,FIELDCAPTION("Appl.-to Item Entry"));
          if ABS("Qty. to Ship (Base)") > ItemLedgEntry.Quantity then
        #18..22
          //>>HEI.34
          //IF NOT ItemLedgEntry.Open THEN
          if ((not ItemLedgEntry.Open) and (GUIALLOWED)) then
          //<<HEI.34
            MESSAGE(Text042,"Appl.-to Item Entry");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Customer Price Group"(Field 42).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Item THEN
          UpdateUnitPrice(FIELDNO("Customer Price Group"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::Item then
          UpdateUnitPrice(FIELDNO("Customer Price Group"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Work Type Code"(Field 52).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Resource THEN BEGIN
          TestStatusOpen;
          IF WorkType.GET("Work Type Code") THEN
            VALIDATE("Unit of Measure Code",WorkType."Unit of Measure Code");
          UpdateUnitPrice(FIELDNO("Work Type Code"));
          VALIDATE("Unit Price");
          FindResUnitCost;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::Resource then begin
          TestStatusOpen;
          if WorkType.GET("Work Type Code") then
        #4..7
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Outstanding Amount"(Field 57).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        Currency2.InitRoundingPrecision;
        IF SalesHeader."Currency Code" <> '' THEN
          "Outstanding Amount (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                GetDate,"Currency Code",
                "Outstanding Amount",SalesHeader."Currency Factor"),
              Currency2."Amount Rounding Precision")
        ELSE
          "Outstanding Amount (LCY)" :=
            ROUND("Outstanding Amount",Currency2."Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetSalesHeader;
        Currency2.InitRoundingPrecision;
        if SalesHeader."Currency Code" <> '' then
        #4..9
        else
          "Outstanding Amount (LCY)" :=
            ROUND("Outstanding Amount",Currency2."Amount Rounding Precision");
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipped Not Invoiced"(Field 59).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        Currency2.InitRoundingPrecision;
        IF SalesHeader."Currency Code" <> '' THEN
          "Shipped Not Invoiced (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                GetDate,"Currency Code",
                "Shipped Not Invoiced",SalesHeader."Currency Factor"),
              Currency2."Amount Rounding Precision")
        ELSE
          "Shipped Not Invoiced (LCY)" :=
            ROUND("Shipped Not Invoiced",Currency2."Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetSalesHeader;
        Currency2.InitRoundingPrecision;
        if SalesHeader."Currency Code" <> '' then
        #4..9
        else
          "Shipped Not Invoiced (LCY)" :=
            ROUND("Shipped Not Invoiced",Currency2."Amount Rounding Precision");
        */
        //end;


        //Unsupported feature: CodeModification on ""Inv. Discount Amount"(Field 69).OnValidate". Please convert manually.

        //trigger  Discount Amount"(Field 69)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CalcInvDiscToInvoice;
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CalcInvDiscToInvoice;
        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.35 DDR 29/06/2009
        if (Type = Type::Item) and
           ExistItemChargeInclPrice()
        then begin
          // <<DITW15.00.00.30 DDR 16/01/2009
          UpdateItemChargeValue();
          // >>DITW15.00.00.35 DDR
          "Unit Price" := "Item Charge Value";
        end;
        // >>DITW15.00.00.19 DDR
        UpdateAmounts;
        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW15.00.00.36 DDR 18/11/2009
        // <<DITW15.00.00.37 DDR 28/04/2010
        if ("Line No." <> 0) and
          (((Type <> Type::Item) and ("Is Item Charge")) or ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item))
        then begin
          UpdateItemChargeAssgnt;
          SaveItemChargeAssgnt;
        end;
        // >>DITW15.00.00.37 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchase Order No."(Field 71).OnValidate". Please convert manually.

        //trigger "(Field 71)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Purchase Order No." <> "Purchase Order No.") AND (Quantity <> 0) THEN BEGIN
          ReserveSalesLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Purchase Order No." <> "Purchase Order No.") and (Quantity <> 0) then begin
          ReserveSalesLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Purch. Order Line No."(Field 72).OnValidate". Please convert manually.

        //trigger  Order Line No();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Purch. Order Line No." <> "Purch. Order Line No.") AND (Quantity <> 0) THEN BEGIN
          ReserveSalesLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Purch. Order Line No." <> "Purch. Order Line No.") and (Quantity <> 0) then begin
          ReserveSalesLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Drop Shipment"(Field 73).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Document Type","Document Type"::Order);
        TESTFIELD(Type,Type::Item);
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Job No.",'');
        TESTFIELD("Qty. to Asm. to Order (Base)",0);

        IF "Drop Shipment" THEN
          TESTFIELD("Special Order",FALSE);

        CheckAssocPurchOrder(FIELDCAPTION("Drop Shipment"));

        IF "Special Order" THEN
          Reserve := Reserve::Never
        ELSE
          IF "Drop Shipment" THEN BEGIN
            Reserve := Reserve::Never;
            VALIDATE(Quantity,Quantity);
            IF "Drop Shipment" THEN BEGIN
              EVALUATE("Outbound Whse. Handling Time",'<0D>');
              EVALUATE("Shipping Time",'<0D>');
              UpdateDates;
              "Bin Code" := '';
            END;
          END ELSE
            SetReserveWithoutPurchasingCode;

        CheckItemAvailable(FIELDNO("Drop Shipment"));

        AddOnIntegrMgt.CheckReceiptOrderStatus(Rec);
        IF (xRec."Drop Shipment" <> "Drop Shipment") AND (Quantity <> 0) THEN BEGIN
          IF NOT "Drop Shipment" THEN BEGIN
            InitQtyToAsm;
            AutoAsmToOrder;
            UpdateWithWarehouseShip
          END ELSE
            InitQtyToShip;
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
          IF NOT FullReservedQtyIsForAsmToOrder THEN
            ReserveSalesLine.VerifyChange(Rec,xRec);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        if "Drop Shipment" then
          TESTFIELD("Special Order",false);

        /// DITW18.00.07 VSC 30/06/2016 DIT-770 #1228 - DITW110.00.10 DDR 02/05/2017 NRQ#10450
        CheckAssocPurchOrder(FIELDCAPTION("Drop Shipment"));

        if "Special Order" then
          Reserve := Reserve::Never
        else
          if "Drop Shipment" then begin
            Reserve := Reserve::Never;
            VALIDATE(Quantity,Quantity);
            if "Drop Shipment" then begin
        #19..22
            end;
          end else
        #25..29
        if (xRec."Drop Shipment" <> "Drop Shipment") and (Quantity <> 0) then begin
          if not "Drop Shipment" then begin
        #32..34
          end else
            InitQtyToShip;

          // <<DITW15.00.00.37 DDR 04/05/2010
          if Type = Type::Item then
            UpdateCharges(FIELDNO("Drop Shipment"),true);
          // >>DITW15.00.00.37 DDR

          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
          if not FullReservedQtyIsForAsmToOrder then
            ReserveSalesLine.VerifyChange(Rec,xRec);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Bus. Posting Group"(Field 74).OnValidate". Please convert manually.

        //trigger  Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
          IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
          if GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") then
            VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Gen. Prod. Posting Group"(Field 75).OnValidate". Please convert manually.

        //trigger (Variable: VATProdPostingGroup)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Prod. Posting Group"(Field 75).OnValidate". Please convert manually.

        //trigger  Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN
          IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
          if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") then begin
            //<<DITW110.00.12A MSF 05/07/2018 NRQ#64943
            VATProdPostingGroup := GetVatProdPostingGroup();
            if VATProdPostingGroup <> '' then
              VALIDATE("VAT Prod. Posting Group",VATProdPostingGroup)
            else
            //>>DITW110.00.12A MSF 05/07/2018 NRQ#64943
              VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
          //<<DITW110.00.12A MSF 05/07/2018 NRQ#64943
          end;
          //>>DITW110.00.12A MSF 05/07/2018 NRQ#64943
        // <<DITW18.00.07 DDR 28/02/2016 DIT-770 #1836
        UpdateCharges(FIELDNO("Gen. Prod. Posting Group"),true);
        // >>DITW18.00.07 DDR DIT-770 #1836
        */
        //end;


        //Unsupported feature: CodeModification on ""VAT Prod. Posting Group"(Field 90).OnValidate". Please convert manually.

        //trigger  Posting Group"(Field 90)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
        "VAT Difference" := 0;
        "VAT %" := VATPostingSetup."VAT %";
        "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
        "VAT Identifier" := VATPostingSetup."VAT Identifier";
        "VAT Clause Code" := VATPostingSetup."VAT Clause Code";
        CASE "VAT Calculation Type" OF
          "VAT Calculation Type"::"Reverse Charge VAT",
          "VAT Calculation Type"::"Sales Tax":
            "VAT %" := 0;
          "VAT Calculation Type"::"Full VAT":
            BEGIN
              TESTFIELD(Type,Type::"G/L Account");
              VATPostingSetup.TESTFIELD("Sales VAT Account");
              TESTFIELD("No.",VATPostingSetup."Sales VAT Account");
            END;
        END;
        IF SalesHeader."Prices Including VAT" AND (Type IN [Type::Item,Type::Resource]) THEN
          "Unit Price" :=
            ROUND(
              "Unit Price" * (100 + "VAT %") / (100 + xRec."VAT %"),
              Currency."Unit-Amount Rounding Precision");
        UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        UpdateTINBAndVATProdPostGrByLocation; //HEI.14
        // <<DITW15.00.00.01 DDR 25/01/2008
        //VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group");
        // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
        CLEAR(VATPostingSetup);
        // >>DITW18.00.07 DDR DIT-770 #1836
        if not VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group") then
          // <<DITW18.00.07 DDR 20/02/2016 DIT-770 #1836
          if not (HideValidationDialog or BatchInsertCheckSuspended) then
          // >>DITW18.00.07 DDR DIT-770 #1836
            ERROR(Text2014410,VATPostingSetup.TABLECAPTION,"VAT Bus. Posting Group","VAT Prod. Posting Group",Type,"No.");
        // >>DITW15.00.00.01 DDR

        #3..7
        case "VAT Calculation Type" of
        #9..12
            begin
        #14..16
            end;
        end;
        if SalesHeader."Prices Including VAT" and (Type in [Type::Item,Type::Resource]) then
        #20..23

        // <<DITW18.00.07 DDR 28/02/2016 DIT-770 #1836
        UpdateCharges(FIELDNO("VAT Prod. Posting Group"),true);
        // >>DITW18.00.07 DDR DIT-770 #1836
        UpdateAmounts;
        */
        //end;


        //Unsupported feature: CodeModification on "Reserve(Field 96).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Reserve <> Reserve::Never THEN BEGIN
          TESTFIELD(Type,Type::Item);
          TESTFIELD("No.");
        END;
        CALCFIELDS("Reserved Qty. (Base)");
        IF (Reserve = Reserve::Never) AND ("Reserved Qty. (Base)" > 0) THEN
          TESTFIELD("Reserved Qty. (Base)",0);

        IF "Drop Shipment" OR "Special Order" THEN
          TESTFIELD(Reserve,Reserve::Never);
        IF xRec.Reserve = Reserve::Always THEN BEGIN
          GetItem;
          IF Item.Reserve = Item.Reserve::Always THEN
            TESTFIELD(Reserve,Reserve::Always);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Reserve <> Reserve::Never then begin
          TESTFIELD(Type,Type::Item);
          TESTFIELD("No.");
        end;
        CALCFIELDS("Reserved Qty. (Base)");
        if (Reserve = Reserve::Never) and ("Reserved Qty. (Base)" > 0) then
          TESTFIELD("Reserved Qty. (Base)",0);

        if "Drop Shipment" or "Special Order" then
          TESTFIELD(Reserve,Reserve::Never);
        if xRec.Reserve = Reserve::Always then begin
          GetItem;
          if Item.Reserve = Item.Reserve::Always then
            TESTFIELD(Reserve,Reserve::Always);
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Blanket Order No."(Field 97).OnValidate". Please convert manually.

        //trigger "(Field 97)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        IF "Blanket Order No." = '' THEN
          "Blanket Order Line No." := 0
        ELSE
          VALIDATE("Blanket Order Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        if "Blanket Order No." = '' then
          "Blanket Order Line No." := 0
        else
          VALIDATE("Blanket Order Line No.");

        // << DITW110.00.10 SFI 20/06/2017 BL#15657
        if "Backorder Type" = "Backorder Type"::Backorder then
          "Backorder Type" := "Backorder Type"::" ";
        // >> DITW110.00.10 SFI BL#15657
        */
        //end;


        //Unsupported feature: CodeModification on ""Blanket Order Line No."(Field 98).OnValidate". Please convert manually.

        //trigger "(Field 98)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        IF "Blanket Order Line No." <> 0 THEN BEGIN
          SalesLine2.GET("Document Type"::"Blanket Order","Blanket Order No.","Blanket Order Line No.");
          SalesLine2.TESTFIELD(Type,Type);
          SalesLine2.TESTFIELD("No.","No.");
        #6..9
          VALIDATE("Unit of Measure Code",SalesLine2."Unit of Measure Code");
          VALIDATE("Unit Price",SalesLine2."Unit Price");
          VALIDATE("Line Discount %",SalesLine2."Line Discount %");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Quantity Shipped",0);
        if "Blanket Order Line No." <> 0 then begin
        #3..12
        end;

        // << DITW110.00.10 SFI 20/06/2017 BL#15657
        if "Backorder Type" = "Backorder Type"::Backorder then
          "Backorder Type" := "Backorder Type"::" ";
        // >> DITW110.00.10 SFI BL#15657
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Line Amount"(Field 103).OnValidate". Please convert manually.

        //trigger (Variable: lCurrUnitPrice)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Line Amount"(Field 103).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type);
        TESTFIELD(Quantity);
        TESTFIELD("Unit Price");
        GetSalesHeader;
        "Line Amount" := ROUND("Line Amount",Currency."Amount Rounding Precision");
        VALIDATE(
          "Line Discount Amount",ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") - "Line Amount");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        // <<DITW15.00.00.01 DDR 08/02/2008
        TestPeriodicWkshtLine();
        // >>DITW15.00.00.01 DDR
        // <<DITW15.00.00.26 DDR 31/10/2008
        TestDelayedLine();
        // >>DITW15.00.00.26 DDR
        GetSalesHeader;
        // <<DITW15.00.00.30 DDR 16/01/2009
        UpdateItemChargeValue();
        // >>DITW15.00.00.30 DDR

        // <<DITW15.00.00.35 DDR 25/06/2009 - 13/10/2009
        if CurrFieldNo = FIELDNO("Line Amount") then begin
          if "Free Item" then
            ERROR(Text028,FIELDCAPTION("Line Amount"),FIELDCAPTION("Free Item"));
        end;
        // >>DITW15.00.00.35 DDR

        // <<DITW15.00.00.19 DDR 07/04/2008
        if (Type = Type::Item) and (not "Is Item Charge") then
          lCurrUnitPrice := "Item Charge Value"
        else
          lCurrUnitPrice := "Unit Price";
        // >>DITW15.00.00.19

        "Line Amount" := ROUND("Line Amount",Currency."Amount Rounding Precision");
        // <<DITW15.00.00.19 DDR 07/04/2008
        //VALIDATE(
        //  "Line Discount Amount",ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") - "Line Amount");
        "Line Amount" := ROUND("Line Amount",Currency."Amount Rounding Precision");
        VALIDATE(
          "Line Discount Amount",ROUND(Quantity * lCurrUnitPrice,Currency."Amount Rounding Precision") - "Line Amount");
        // >>DITW15.00.00.19
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Partner Ref. Type"(Field 107).OnValidate". Please convert manually.

        //trigger  Type"(Field 107)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "IC Partner Code" <> '' THEN
          "IC Partner Ref. Type" := "IC Partner Ref. Type"::"G/L Account";
        IF "IC Partner Ref. Type" <> xRec."IC Partner Ref. Type" THEN
          "IC Partner Reference" := '';
        IF "IC Partner Ref. Type" = "IC Partner Ref. Type"::"Common Item No." THEN BEGIN
          IF Item."No." <> "No." THEN
            Item.GET("No.");
          Item.TESTFIELD("Common Item No.");
          "IC Partner Reference" := Item."Common Item No.";
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "IC Partner Code" <> '' then
          "IC Partner Ref. Type" := "IC Partner Ref. Type"::"G/L Account";
        if "IC Partner Ref. Type" <> xRec."IC Partner Ref. Type" then
          "IC Partner Reference" := '';
        if "IC Partner Ref. Type" = "IC Partner Ref. Type"::"Common Item No." then begin
          if Item."No." <> "No." then
        #7..9
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Partner Reference"(Field 108).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> '' THEN
          CASE "IC Partner Ref. Type" OF
            "IC Partner Ref. Type"::"G/L Account":
              BEGIN
                IF ICGLAccount.GET("IC Partner Reference") THEN;
                IF PAGE.RUNMODAL(PAGE::"IC G/L Account List",ICGLAccount) = ACTION::LookupOK THEN
                  VALIDATE("IC Partner Reference",ICGLAccount."No.");
              END;
            "IC Partner Ref. Type"::Item:
              BEGIN
                IF Item.GET("IC Partner Reference") THEN;
                IF PAGE.RUNMODAL(PAGE::"Item List",Item) = ACTION::LookupOK THEN
                  VALIDATE("IC Partner Reference",Item."No.");
              END;
            "IC Partner Ref. Type"::"Cross Reference":
              BEGIN
                ItemCrossReference.RESET;
                ItemCrossReference.SETCURRENTKEY("Cross-Reference Type","Cross-Reference Type No.");
                ItemCrossReference.SETFILTER(
                  "Cross-Reference Type",'%1|%2',
                  ItemCrossReference."Cross-Reference Type"::Customer,
                  ItemCrossReference."Cross-Reference Type"::" ");
                ItemCrossReference.SETFILTER("Cross-Reference Type No.",'%1|%2',"Sell-to Customer No.",'');
                IF PAGE.RUNMODAL(PAGE::"Cross Reference List",ItemCrossReference) = ACTION::LookupOK THEN
                  VALIDATE("IC Partner Reference",ItemCrossReference."Cross-Reference No.");
              END;
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> '' then
          case "IC Partner Ref. Type" of
            "IC Partner Ref. Type"::"G/L Account":
              begin
                if ICGLAccount.GET("IC Partner Reference") then;
                if PAGE.RUNMODAL(PAGE::"IC G/L Account List",ICGLAccount) = ACTION::LookupOK then
                  VALIDATE("IC Partner Reference",ICGLAccount."No.");
              end;
            "IC Partner Ref. Type"::Item:
              begin
                if Item.GET("IC Partner Reference") then;
                if PAGE.RUNMODAL(PAGE::"Item List",Item) = ACTION::LookupOK then
                  VALIDATE("IC Partner Reference",Item."No.");
              end;
            "IC Partner Ref. Type"::"Cross Reference":
              begin
        #17..23
                if PAGE.RUNMODAL(PAGE::"Cross Reference List",ItemCrossReference) = ACTION::LookupOK then
                  VALIDATE("IC Partner Reference",ItemCrossReference."Cross-Reference No.");
              end;
          end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepayment %"(Field 109).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        UpdatePrepmtSetupFields;

        IF Type <> Type::" " THEN
          UpdateAmounts;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        // <<DITW15.00.00.23 DDR 11/08/2008
        UpdateCharges(FIELDNO("Prepayment %"),false);
        // >>DITW15.00.00.23 DDR

        if Type <> Type::" " then
          UpdateAmounts;
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt. Line Amount"(Field 110).OnValidate". Please convert manually.

        //trigger  Line Amount"(Field 110)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        PrePaymentLineAmountEntered := TRUE;
        TESTFIELD("Line Amount");
        IF "Prepmt. Line Amount" < "Prepmt. Amt. Inv." THEN
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text044,"Prepmt. Amt. Inv."));
        IF "Prepmt. Line Amount" > "Line Amount" THEN
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,"Line Amount"));
        IF "System-Created Entry" THEN
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,0));
        VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" * 100 / "Line Amount",0.00001));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        PrePaymentLineAmountEntered := true;
        TESTFIELD("Line Amount");
        if "Prepmt. Line Amount" < "Prepmt. Amt. Inv." then
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text044,"Prepmt. Amt. Inv."));
        if "Prepmt. Line Amount" > "Line Amount" then
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,"Line Amount"));
        if "System-Created Entry" then
          FIELDERROR("Prepmt. Line Amount",STRSUBSTNO(Text045,0));
        VALIDATE("Prepayment %",ROUND("Prepmt. Line Amount" * 100 / "Line Amount",0.00001));
        */
        //end;


        //Unsupported feature: CodeModification on ""Prepmt Amt to Deduct"(Field 121).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Prepmt Amt to Deduct" > "Prepmt. Amt. Inv." - "Prepmt Amt Deducted" THEN
          FIELDERROR(
            "Prepmt Amt to Deduct",
            STRSUBSTNO(Text045,"Prepmt. Amt. Inv." - "Prepmt Amt Deducted"));

        IF "Prepmt Amt to Deduct" > "Qty. to Invoice" * "Unit Price" THEN
          FIELDERROR(
            "Prepmt Amt to Deduct",
            STRSUBSTNO(Text045,"Qty. to Invoice" * "Unit Price"));

        IF ("Prepmt. Amt. Inv." - "Prepmt Amt to Deduct" - "Prepmt Amt Deducted") >
           (Quantity - "Qty. to Invoice" - "Quantity Invoiced") * "Unit Price"
        THEN
          FIELDERROR(
            "Prepmt Amt to Deduct",
            STRSUBSTNO(Text044,
              "Prepmt. Amt. Inv." - "Prepmt Amt Deducted" - (Quantity - "Qty. to Invoice" - "Quantity Invoiced") * "Unit Price"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Prepmt Amt to Deduct" > "Prepmt. Amt. Inv." - "Prepmt Amt Deducted" then
        #2..5
        if "Prepmt Amt to Deduct" > "Qty. to Invoice" * "Unit Price" then
        #7..10
        if ("Prepmt. Amt. Inv." - "Prepmt Amt to Deduct" - "Prepmt Amt Deducted") >
           (Quantity - "Qty. to Invoice" - "Quantity Invoiced") * "Unit Price"
        then
        #14..17
        */
        //end;


        //Unsupported feature: CodeModification on ""IC Partner Code"(Field 130).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "IC Partner Code" <> '' THEN BEGIN
          TESTFIELD(Type,Type::"G/L Account");
          GetSalesHeader;
          SalesHeader.TESTFIELD("Sell-to IC Partner Code",'');
          SalesHeader.TESTFIELD("Bill-to IC Partner Code",'');
          VALIDATE("IC Partner Ref. Type","IC Partner Ref. Type"::"G/L Account");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "IC Partner Code" <> '' then begin
        #2..6
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Qty. to Assemble to Order"(Field 900).OnValidate". Please convert manually.

        //trigger  to Assemble to Order"(Field 900)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);

        "Qty. to Asm. to Order (Base)" := CalcBaseQty("Qty. to Assemble to Order");

        IF "Qty. to Asm. to Order (Base)" <> 0 THEN BEGIN
          TESTFIELD("Drop Shipment",FALSE);
          TESTFIELD("Special Order",FALSE);
          IF "Qty. to Asm. to Order (Base)" < 0 THEN
            FIELDERROR("Qty. to Assemble to Order",STRSUBSTNO(Text009,FIELDCAPTION("Quantity (Base)"),"Quantity (Base)"));
          TESTFIELD("Appl.-to Item Entry",0);

          CASE "Document Type" OF
            "Document Type"::"Blanket Order",
            "Document Type"::Quote:
              IF ("Quantity (Base)" = 0) OR ("Qty. to Asm. to Order (Base)" <= 0) OR SalesLineReserve.ReservEntryExist(Rec) THEN
                TESTFIELD("Qty. to Asm. to Order (Base)",0)
              ELSE
                IF "Quantity (Base)" <> "Qty. to Asm. to Order (Base)" THEN
                  FIELDERROR("Qty. to Assemble to Order",STRSUBSTNO(Text031,0,"Quantity (Base)"));
            "Document Type"::Order:
              ;
            ELSE
              TESTFIELD("Qty. to Asm. to Order (Base)",0);
          END;
        END;

        CheckItemAvailable(FIELDNO("Qty. to Assemble to Order"));
        IF NOT (CurrFieldNo IN [FIELDNO(Quantity),FIELDNO("Qty. to Assemble to Order")]) THEN
          GetDefaultBin;
        AutoAsmToOrder;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 01/02/2016 DIT-770 #1702
        if not ChangedFromWarehouse then
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        //>> DITW18.00.07 VSC DIT-770 #1702
        #2..4
        if "Qty. to Asm. to Order (Base)" <> 0 then begin
          TESTFIELD("Drop Shipment",false);
          TESTFIELD("Special Order",false);
          if "Qty. to Asm. to Order (Base)" < 0 then
        #9..11
          case "Document Type" of
            "Document Type"::"Blanket Order",
            "Document Type"::Quote:
              if ("Quantity (Base)" = 0) or ("Qty. to Asm. to Order (Base)" <= 0) or SalesLineReserve.ReservEntryExist(Rec) then
                TESTFIELD("Qty. to Asm. to Order (Base)",0)
              else
                if "Quantity (Base)" <> "Qty. to Asm. to Order (Base)" then
        #19..21
            else
              TESTFIELD("Qty. to Asm. to Order (Base)",0);
          end;
        end;

        CheckItemAvailable(FIELDNO("Qty. to Assemble to Order"));
        if not (CurrFieldNo in [FIELDNO(Quantity),FIELDNO("Qty. to Assemble to Order")]) then
          GetDefaultBin;
        AutoAsmToOrder;
        */
        //end;


        //Unsupported feature: CodeModification on ""Job Contract Entry No."(Field 1002).OnValidate". Please convert manually.

        //trigger "(Field 1002)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        JobPlanningLine.SETCURRENTKEY("Job Contract Entry No.");
        JobPlanningLine.SETRANGE("Job Contract Entry No.","Job Contract Entry No.");
        JobPlanningLine.FINDFIRST;
        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,JobPlanningLine."Job No.",
          DATABASE::"Responsibility Center","Responsibility Center");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
          DATABASE::"Responsibility Center","Responsibility Center",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo(),
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
          // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
          DimMgt.TypeToTableID3(Type::Item),"Tax Item No.");
          // >>DITW16.00.00.43 DDR DIT-715 #768
        */
        //end;


        //Unsupported feature: CodeModification on ""Deferral Code"(Field 1700).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        DeferralPostDate := SalesHeader."Posting Date";

        #4..6
          GetDeferralAmount,DeferralPostDate,
          Description,SalesHeader."Currency Code");

        IF "Document Type" = "Document Type"::"Return Order" THEN
          "Returns Deferral Start Date" :=
            DeferralUtilities.GetDeferralStartDate(DeferralUtilities.GetSalesDeferralDocType,
              "Document Type","Document No.","Line No.","Deferral Code",SalesHeader."Posting Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
        if "Document Type" = "Document Type"::"Return Order" then
        #11..13
        */
        //end;


        //Unsupported feature: CodeModification on ""Returns Deferral Start Date"(Field 1702).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        IF DeferralHeader.GET(DeferralUtilities.GetSalesDeferralDocType,'','',"Document Type","Document No.","Line No.") THEN
          DeferralUtilities.CreateDeferralSchedule("Deferral Code",DeferralUtilities.GetSalesDeferralDocType,'','',
            "Document Type","Document No.","Line No.",GetDeferralAmount,
            DeferralHeader."Calc. Method","Returns Deferral Start Date",
            DeferralHeader."No. of Periods",TRUE,
            DeferralHeader."Schedule Description",FALSE,
            SalesHeader."Currency Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetSalesHeader;
        if DeferralHeader.GET(DeferralUtilities.GetSalesDeferralDocType,'','',"Document Type","Document No.","Line No.") then
        #3..5
            DeferralHeader."No. of Periods",true,
            DeferralHeader."Schedule Description",false,
            SalesHeader."Currency Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 5402).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        IF "Variant Code" <> '' THEN
          TESTFIELD(Type,Type::Item);
        TestStatusOpen;
        CheckAssocPurchOrder(FIELDCAPTION("Variant Code"));

        IF xRec."Variant Code" <> "Variant Code" THEN BEGIN
          TESTFIELD("Qty. Shipped Not Invoiced",0);
          TESTFIELD("Shipment No.",'');

          TESTFIELD("Return Qty. Rcd. Not Invd.",0);
          TESTFIELD("Return Receipt No.",'');
          InitItemAppl(FALSE);
        END;

        CheckItemAvailable(FIELDNO("Variant Code"));

        IF Type = Type::Item THEN BEGIN
          GetUnitCost;
          UpdateUnitPrice(FIELDNO("Variant Code"));
        END;

        GetDefaultBin;
        InitQtyToAsm;
        AutoAsmToOrder;
        IF (xRec."Variant Code" <> "Variant Code") AND (Quantity <> 0) THEN BEGIN
          IF NOT FullReservedQtyIsForAsmToOrder THEN
            ReserveSalesLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        END;

        UpdateItemCrossRef;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestJobPlanningLine;
        if "Variant Code" <> '' then
        #3..6
        if xRec."Variant Code" <> "Variant Code" then begin
        #8..12
          InitItemAppl(false);
        end;
        #15..17
        if Type = Type::Item then begin
          GetUnitCost;
          UpdateUnitPrice(FIELDNO("Variant Code"));
        end;
        #22..25
        if (xRec."Variant Code" <> "Variant Code") and (Quantity <> 0) then begin
          if not FullReservedQtyIsForAsmToOrder then
            ReserveSalesLine.VerifyChange(Rec,xRec);
          WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
        end;

        // << DITW110.00.11 SFI 30/08/2017 BL#14417
        if (Type = Type::Item) then
          GetDepositValue;
        // >> DITW110.00.11 SFI BL#14417

        // << DITW110.00.11 SFI 31/08/2017 BL#30569
        if (Type = Type::Item) then begin
          GetItem();
          Item.BlockedSKU("Location Code","Variant Code",true);
        end;
        // >> DITW110.00.11 SFI BL#30569

        // << DITW110.00.10 SFI 20/06/2017 BL#15657
        if (Type = Type::Item) then begin
          if GetSKU then begin
            if "Backorder Type" <> SKU."Backorder Type" then
              VALIDATE("Backorder Type", SKU."Backorder Type");
          end;
        end;
        // >> DITW110.00.10 SFI BL#15657
        UpdateItemCrossRef;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 5403).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT IsInbound AND ("Quantity (Base)" <> 0) THEN
          BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        ELSE
          BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');

        IF BinCode <> '' THEN
          VALIDATE("Bin Code",BinCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not IsInbound and ("Quantity (Base)" <> 0) then
          BinCode := WMSManagement.BinContentLookUp("Location Code","No.","Variant Code",'',"Bin Code")
        else
          BinCode := WMSManagement.BinLookUp("Location Code","No.","Variant Code",'');

        if BinCode <> '' then
          VALIDATE("Bin Code",BinCode);
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Code"(Field 5403).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bin Code" <> '' THEN BEGIN
          IF NOT IsInbound AND ("Quantity (Base)" <> 0) AND ("Qty. to Asm. to Order (Base)" = 0) THEN
            WMSManagement.FindBinContent("Location Code","Bin Code","No.","Variant Code",'')
          ELSE
            WMSManagement.FindBin("Location Code","Bin Code",'');
        END;

        IF "Drop Shipment" THEN
          CheckAssocPurchOrder(FIELDCAPTION("Bin Code"));

        TESTFIELD(Type,Type::Item);
        TESTFIELD("Location Code");

        IF (Type = Type::Item) AND ("Bin Code" <> '') THEN BEGIN
          TESTFIELD("Drop Shipment",FALSE);
          GetLocation("Location Code");
          Location.TESTFIELD("Bin Mandatory");
          CheckWarehouse;
        END;
        ATOLink.UpdateAsmBinCodeFromSalesLine(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bin Code" <> '' then begin
          if not IsInbound and ("Quantity (Base)" <> 0) and ("Qty. to Asm. to Order (Base)" = 0) then
            WMSManagement.FindBinContent("Location Code","Bin Code","No.","Variant Code",'')
          else
            WMSManagement.FindBin("Location Code","Bin Code",'');
        end;

        if "Drop Shipment" then
        #9..13
        if (Type = Type::Item) and ("Bin Code" <> '') then begin
          TESTFIELD("Drop Shipment",false);
        #16..18
          // <<DITW15.00.00.24 DDR 14/08/2008
          if Location."Directed Put-away and Pick" then
            CheckBinCubageWeight(0,0);
          // >>DITW15.00.00.24 DDR
        end;
        // <<DITW15.00.00.01 DDR 18/12/2007 - 14/01/2008
        // <<DITW15.00.00.19 DDR 07/04/2008 - DITW15.00.00.35 DDR 29/06/2009 - DITW15.00.00.36 DDR 17/11/2009
        if (Type = Type::Item) and ((Quantity <> 0) or (xRec.Quantity <> Quantity)) then
          InsertCharges3(FIELDNO("Bin Code"));
        // >>DITW15.00.00.35 DDR
        ATOLink.UpdateAsmBinCodeFromSalesLine(Rec);
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 5407).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        TESTFIELD("Quantity Shipped",0);
        TESTFIELD("Qty. Shipped (Base)",0);
        TESTFIELD("Return Qty. Received",0);
        TESTFIELD("Return Qty. Received (Base)",0);
        IF "Unit of Measure Code" <> xRec."Unit of Measure Code" THEN BEGIN
          TESTFIELD("Shipment No.",'');
          TESTFIELD("Return Receipt No.",'');
        END;

        CheckAssocPurchOrder(FIELDCAPTION("Unit of Measure Code"));

        IF "Unit of Measure Code" = '' THEN
          "Unit of Measure" := ''
        ELSE BEGIN
          IF NOT UnitOfMeasure.GET("Unit of Measure Code") THEN
            UnitOfMeasure.INIT;
          "Unit of Measure" := UnitOfMeasure.Description;
          GetSalesHeader;
          IF SalesHeader."Language Code" <> '' THEN BEGIN
            UnitOfMeasureTranslation.SETRANGE(Code,"Unit of Measure Code");
            UnitOfMeasureTranslation.SETRANGE("Language Code",SalesHeader."Language Code");
            IF UnitOfMeasureTranslation.FINDFIRST THEN
              "Unit of Measure" := UnitOfMeasureTranslation.Description;
          END;
        END;
        DistIntegration.EnterSalesItemCrossRef(Rec);
        CASE Type OF
          Type::Item:
            BEGIN
              GetItem;
              GetUnitCost;
              UpdateUnitPrice(FIELDNO("Unit of Measure Code"));
              CheckItemAvailable(FIELDNO("Unit of Measure Code"));
              "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
              "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
              "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
              "Units per Parcel" := ROUND(Item."Units per Parcel" / "Qty. per Unit of Measure",0.00001);
              IF (xRec."Unit of Measure Code" <> "Unit of Measure Code") AND (Quantity <> 0) THEN
                WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
              IF "Qty. per Unit of Measure" > xRec."Qty. per Unit of Measure" THEN
                InitItemAppl(FALSE);
            END;
          Type::Resource:
            BEGIN
              IF "Unit of Measure Code" = '' THEN BEGIN
                GetResource;
                "Unit of Measure Code" := Resource."Base Unit of Measure";
              END;
              ResUnitofMeasure.GET("No.","Unit of Measure Code");
              "Qty. per Unit of Measure" := ResUnitofMeasure."Qty. per Unit of Measure";
              UpdateUnitPrice(FIELDNO("Unit of Measure Code"));
              FindResUnitCost;
            END;
          Type::"G/L Account",Type::"Fixed Asset",Type::"Charge (Item)",Type::" ":
            "Qty. per Unit of Measure" := 1;
        END;
        VALIDATE(Quantity);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        if "Unit of Measure Code" <> xRec."Unit of Measure Code" then begin
          TESTFIELD("Shipment No.",'');
          TESTFIELD("Return Receipt No.",'');
        end;
        // <<DITW16.00.00.43 DDR 22/01/2014 DIT-715 #882
        if "Is Item Charge" and not HideValidationDialog then
          ERROR(Text2013662,FIELDCAPTION("Unit of Measure Code"),FIELDCAPTION("Item Charge Type"));
        // >>DITW16.00.00.43 DDR DIT-715 #882
        #11..13
        if "Unit of Measure Code" = '' then begin
          "Unit of Measure" := '';
          // <<DITW15.00.00.38 DDR 02/09/2010 #1217
          // <<DITW16.00.00.43 DDR 12/08/2013 DIT-715 #720
          VALIDATE("Packaging Type Code",'');
          // >>DITW16.00.00.43 DDR DIT-715 #720
          // >>DITW15.00.00.38 DDR
          // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
          "Pack Qty. per Unit of Measure" := 0;
          // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
        end else begin
          if not UnitOfMeasure.GET("Unit of Measure Code") then
            UnitOfMeasure.INIT;
          "Unit of Measure" := UnitOfMeasure.Description;
          // <<DITW15.00.00.38 DDR 02/09/2010 #1217
          "Packaging Type Code" := UnitOfMeasure."Packaging Type Code";
          // >>DITW15.00.00.38 DDR
          // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
          "Pack Qty. per Unit of Measure" := 0;
          // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
          //<<DITW17.00.02 TEC1 12/09/2013 DIT-770 #154
          if UnitOfMeasure."Picking Type" <> UnitOfMeasure."Picking Type"::" " then
            "Picking Type" := UnitOfMeasure."Picking Type";
          //>>DITW17.00.02 TEC1 DIT-770 #154

          GetSalesHeader;
          if SalesHeader."Language Code" <> '' then begin
            UnitOfMeasureTranslation.SETRANGE(Code,"Unit of Measure Code");
            UnitOfMeasureTranslation.SETRANGE("Language Code",SalesHeader."Language Code");
            if UnitOfMeasureTranslation.FINDFIRST then
              "Unit of Measure" := UnitOfMeasureTranslation.Description;
          end;
        end;
        // <<DITW17.00.01 DDR 23/04/2013 DIT-770 #001
        BatchInsertCheckSuspended2 := BatchInsertCheckSuspended;
        BatchInsertCheckSuspended := true;
        // >>DITW17.00.01 DDR DIT-770 #001
        DistIntegration.EnterSalesItemCrossRef(Rec);
        case Type of
          Type::Item:
            begin
              GetItem;
              GetUnitCost;
              // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #689
              "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
              // >>DITW16.00.00.43 DDR DIT-715 #689
              // <<DITW16.00.00.43 DDR 31/01/2014 DIT-715 #856
              // <<DITW114.00.15 DDR 08/05/2020 NRQ#145254
              GetDepositValue();
              // >>DITW114.00.15 DDR NRQ#145254
              UpdateUnitPrice(FIELDNO("Unit of Measure Code"));
              //CheckItemAvailable(FIELDNO("Unit of Measure Code"));
              UpdateAmounts();
              // >>DITW16.00.00.43 DDR DIT-715 #856
        #36..39
              // <<DITW15.00.00.28 DDR 24/11/2008
              "Tariff No." := Item."Tariff No.";
              // >>DITW15.00.00.28 DDR
              // <<DITW15.00.00.38 DDR 02/09/2010 #1217
              ItemUnitOfMeasure.GET("No.","Unit of Measure Code");
              // <<DITW16.00.00.43 DDR 12/08/2013 DIT-715 #720
              VALIDATE("Packaging Type Code",ItemUnitOfMeasure."Packaging Type Code");
              // >>DITW16.00.00.43 DDR DIT-715 #720
              // >>DITW15.00.00.38 DDR
              // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
              if ItemUnitOfMeasure."Packaging Type Code" <> '' then
                ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
              "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
              // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
              if (xRec."Unit of Measure Code" <> "Unit of Measure Code") and (Quantity <> 0) then
                WhseValidateSourceLine.SalesLineVerifyChange(Rec,xRec);
              if "Qty. per Unit of Measure" > xRec."Qty. per Unit of Measure" then
                InitItemAppl(false);
              // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
              UpdateRoutePlanRqstLines(FIELDNO("Qty. per Unit of Measure"));
              // >>DITW18.00.07 DDR DIT-770 #1488
            end;
          Type::Resource:
            begin
              if "Unit of Measure Code" = '' then begin
                GetResource;
                "Unit of Measure Code" := Resource."Base Unit of Measure";
              end;
        #51..54
            end;
          // <<DITW16.00.00.43 DDR 01/10/2013 DIT-715 #519
          //Type::"G/L Account",Type::"Fixed Asset",Type::"Charge (Item)",Type::" ":
          Type::"G/L Account",Type::"Fixed Asset",Type::" ":
          // >>DITW16.00.00.43 DDR DIT-715 #519
            "Qty. per Unit of Measure" := 1;
          // <<DITW15.00.00.38 DDR 17/12/2010 #703
          Type::"Charge (Item)":
            if "Tax Item No." <> '' then begin
              Item.GET("Tax Item No.");
              // <<DITW16.00.00.43 DDR 01/10/2013 DIT-715 #519
              ItemUnitOfMeasure.GET(Item."No.","Unit of Measure Code");
              "Qty. per Unit of Measure" := 1;
              // >>DITW16.00.00.43 DDR DIT-715 #519
              "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
              "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
              "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
              "Units per Parcel" := ROUND(Item."Units per Parcel" / "Qty. per Unit of Measure",0.00001);
              "Unit Volume HL" := Item."Unit Volume HL" * "Qty. per Unit of Measure";
              "Tariff No." := Item."Tariff No.";
              // <<DITW16.00.00.43 DDR 12/08/2013 DIT-715 #720
              VALIDATE("Packaging Type Code",ItemUnitOfMeasure."Packaging Type Code");
              // >>DITW16.00.00.43 DDR DIT-715 #720
              // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
              if ItemUnitOfMeasure."Packaging Type Code" <> '' then
                ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
              "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
              // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
            end;
          // >>DITW15.00.00.38 DDR #703
        end;
        VALIDATE(Quantity);
        // <<DITW17.00.01 DDR 23/04/2013 DIT-770 #001
        BatchInsertCheckSuspended := BatchInsertCheckSuspended2;

        UpdateUnitPriceCharges(FIELDNO("Unit of Measure Code"));
        // >>DITW17.00.01 DDR DIT-770 #001
        //<<DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
        UpdateEventLine(0,"Event Doc. No.","Event Doc. Line No.",CurrFieldNo,false);
        //>>//<<DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
        // <<DITW17.10.05 DDR 30/07/2014 DIT-770 (#383) #826
        if (xRec."Unit of Measure Code" <> "Unit of Measure Code") and
          ("Unit of Measure Code" <> '') and (CurrFieldNo = FIELDNO("Unit of Measure Code"))
        then
          UpdateAmounts();
        // >>DITW17.10.05 DDR DIT-770 (#383) #826
        */
        //end;


        //Unsupported feature: CodeModification on ""Duplicate in Depreciation Book"(Field 5612).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Use Duplication List" := FALSE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Use Duplication List" := false;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Responsibility Center"(Field 5700).OnValidate". Please convert manually.

        //trigger (Variable: LocationCode)();
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: CodeModification on ""Responsibility Center"(Field 5700).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::"Responsibility Center","Responsibility Center",
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1190
        if xRec."Responsibility Center" <> "Responsibility Center" then begin
          if not UserSetupMgt.CheckRespCenter(0,"Responsibility Center") then
            ERROR(
              Text2014413,
              RespCenter.TABLECAPTION,UserSetupMgt.GetSalesFilter);
        end;

        // "Location Code" := UserSetupMgt.GetLocation(0,'',"Responsibility Center");
        if (CurrFieldNo <> FIELDNO("Location Code")) and
          (CurrFieldNo <> FIELDNO("Physical Location Group Code")) and
          (xRec."Physical Location Group Code" = "Physical Location Group Code") and
          (xRec."Location Code" = "Location Code")
        then begin
            // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
            PhysLocGrCode := UserSetupMgt.GetphysicalLocation(0,'',"Responsibility Center");
            if PhysLocGrCode <> "Physical Location Group Code" then begin
              "Location Code" := '';
              SETFILTER("Location Table Filter",
                UserSetupMgt.GetRespLocationFilter(0,"Responsibility Center",PhysLocGrCode,"Location Code"));
            end;
            VALIDATE("Physical Location Group Code",PhysLocGrCode);
            // >>DITW18.00.06 DDR DIT-770 #1592
            LocationCode := UserSetupMgt.GetLocation(0,'',"Responsibility Center");
            // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1190
            if (LocationCode <> '') or ("Physical Location Group Code" <> xRec."Physical Location Group Code") then
            // >>DITW18.00.06 DDR DIT-770 #1190
              VALIDATE("Location Code", LocationCode);
        end;
        // >>DITW18.00.06 DDR DIT-770 #1190

        // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1190 - DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
        if "Responsibility Center" <> xRec."Responsibility Center" then
          UpdateCharges2(FIELDNO("Responsibility Center"),(CurrFieldNo = FIELDNO("Responsibility Center")));
        // >>DITW18.00.06 DDR DIT-770 #1190 - DITW18.00.06 DDR DIT-770 #1592

        #1..3
          DATABASE::Job,"Job No.",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          // <<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo(),
          // >>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
          // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
          DimMgt.TypeToTableID3(Type::Item),"Tax Item No.");
          // >>DITW16.00.00.43 DDR DIT-715 #768
        */
        //end;

        //Unsupported feature: PropertyDeletion on ""Responsibility Center"(Field 5700)". Please convert manually.



        //Unsupported feature: CodeModification on ""Cross-Reference No."(Field 5705).OnValidate". Please convert manually.

        //trigger "(Field 5705)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        "Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
        ReturnedCrossRef.INIT;
        IF "Cross-Reference No." <> '' THEN BEGIN
          DistIntegration.ICRLookupSalesItem(Rec,ReturnedCrossRef);
          IF "No." <> ReturnedCrossRef."Item No." THEN
            VALIDATE("No.",ReturnedCrossRef."Item No.");
          IF ReturnedCrossRef."Variant Code" <> '' THEN
            VALIDATE("Variant Code",ReturnedCrossRef."Variant Code");

          IF ReturnedCrossRef."Unit of Measure" <> '' THEN
            VALIDATE("Unit of Measure Code",ReturnedCrossRef."Unit of Measure");
        END;

        "Unit of Measure (Cross Ref.)" := ReturnedCrossRef."Unit of Measure";
        "Cross-Reference Type" := ReturnedCrossRef."Cross-Reference Type";
        "Cross-Reference Type No." := ReturnedCrossRef."Cross-Reference Type No.";
        "Cross-Reference No." := ReturnedCrossRef."Cross-Reference No.";

        IF ReturnedCrossRef.Description <> '' THEN
          Description := ReturnedCrossRef.Description;

        UpdateUnitPrice(FIELDNO("Cross-Reference No."));
        UpdateICPartner;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        if "Cross-Reference No." <> '' then begin
          DistIntegration.ICRLookupSalesItem(Rec,ReturnedCrossRef);
          // <<DITW15.00.00.38 DDR 27/01/2011 #1259
          lItemNo := "No.";
          // >>DITW15.00.00.38 DDR #1259
          if "No." <> ReturnedCrossRef."Item No." then
            VALIDATE("No.",ReturnedCrossRef."Item No.");
          if ReturnedCrossRef."Variant Code" <> '' then
            VALIDATE("Variant Code",ReturnedCrossRef."Variant Code");

          if ReturnedCrossRef."Unit of Measure" <> '' then
            VALIDATE("Unit of Measure Code",ReturnedCrossRef."Unit of Measure");
        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        //END;
        end else
          VALIDATE("No.");
        // >>DITW15.00.00.38 DDR #1259
        #14..19
        if ReturnedCrossRef.Description <> '' then
        #21..23

        UpdateICPartner;

        // <<DITW15.00.00.38 DDR 27/01/2011 #1259
        if (CurrFieldNo = FIELDNO("Cross-Reference No.")) and
           (Type = Type::Item)  and
           (not BatchInsertCheckSuspended)
        then begin
          COMMIT;
          if "Line No." <> 0 then begin
            if TransferExtText.SalesCheckIfAnyExtText(Rec,false) then
              TransferExtText.InsertSalesExtText(Rec);
            COMMIT;
          end;

          if (Type = Type::Item) and ("Quantity Invoiced" = 0) and
            ("Quantity Shipped" = 0) and ("Return Qty. Received" = 0) and
            ("Appl.-to Item Entry" = 0) and ("Appl.-from Item Entry" = 0) and
            ("Shipment No." = '') and ("Return Receipt No." = '') and
            // <<DITW17.10.03 DDR 26/06/2014 DIT-770 #570
            (CurrFieldNo <> 0) and ("Line No." <> 0)
            // >>DITW17.10.03 DDR DIT-770 #570
          then begin
            if (Quantity <> 0) or (xRec.Quantity <> Quantity) then begin
              lTempCurrfieldNo := CurrFieldNo;
              CurrFieldNo := FIELDNO("Location Code");
              InsertCharges3(FIELDNO("Location Code"));
              CurrFieldNo := lTempCurrfieldNo;
            end else
              DeleteAllChargeSalesLines(Rec,true);
          end;
        end;

        CreateDim(
          DimMgt.TypeToTableID3(Type),"No.",
          DATABASE::Job,"Job No.",
          DATABASE::"Responsibility Center","Responsibility Center",
          // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo(),
          //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
          // >>DITW16.00.00.41 AHU DIT-715 #327
          // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
          DimMgt.TypeToTableID3(Type::Item),"Tax Item No.");
          // >>DITW16.00.00.43 DDR DIT-715 #768
        // >>DITW15.00.00.38 DDR #1259
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Item Category Code"(Field 5709)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.28 DDR 24/11/2008
        if "Item Category Code" <> '' then begin
          ItemCategory.GET("Item Category Code" );
          if "AAD No. Series" <> '' then begin
            // <<DITW15.00.00.32 DDR 09/04/2009
            if "Tariff No." = '' then begin
              GetItem();
              Item.TESTFIELD("Tariff No.");
            end;
            // >>DITW15.00.00.32 DDR
          end;
        end;
        // >>DITW15.00.00.28 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Purchasing Code"(Field 5711).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        TESTFIELD(Type,Type::Item);
        CheckAssocPurchOrder(FIELDCAPTION(Type));

        IF PurchasingCode.GET("Purchasing Code") THEN BEGIN
          "Drop Shipment" := PurchasingCode."Drop Shipment";
          "Special Order" := PurchasingCode."Special Order";
          IF "Drop Shipment" OR "Special Order" THEN BEGIN
            TESTFIELD("Qty. to Asm. to Order (Base)",0);
            CALCFIELDS("Reserved Qty. (Base)");
            TESTFIELD("Reserved Qty. (Base)",0);
            IF (Quantity <> 0) AND (Quantity = "Quantity Shipped") THEN
              ERROR(SalesLineCompletelyShippedErr);
            Reserve := Reserve::Never;
            VALIDATE(Quantity,Quantity);
            IF "Drop Shipment" THEN BEGIN
              EVALUATE("Outbound Whse. Handling Time",'<0D>');
              EVALUATE("Shipping Time",'<0D>');
              UpdateDates;
              "Bin Code" := '';
            END;
          END ELSE
            SetReserveWithoutPurchasingCode;
        END ELSE BEGIN
          "Drop Shipment" := FALSE;
          "Special Order" := FALSE;
          SetReserveWithoutPurchasingCode;
        END;

        IF ("Purchasing Code" <> xRec."Purchasing Code") AND
           (NOT "Drop Shipment") AND
           ("Drop Shipment" <> xRec."Drop Shipment")
        THEN BEGIN
          IF "Location Code" = '' THEN BEGIN
            IF InvtSetup.GET THEN
              "Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
          END ELSE
            IF Location.GET("Location Code") THEN
              "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
          IF ShippingAgentServices.GET("Shipping Agent Code","Shipping Agent Service Code") THEN
            "Shipping Time" := ShippingAgentServices."Shipping Time"
          ELSE BEGIN
            GetSalesHeader;
            "Shipping Time" := SalesHeader."Shipping Time";
          END;
          UpdateDates;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
        if PurchasingCode.GET("Purchasing Code") then begin
          "Drop Shipment" := PurchasingCode."Drop Shipment";
          "Special Order" := PurchasingCode."Special Order";
          //<< DITW18.00.07 VSC 21/06/2016 DIT-770 #1228
          CheckDropShipItemExclusivityAvail(FIELDNO("Purchasing Code"));
          //>> DITW18.00.07 VSC DIT-770 #1228

          if "Drop Shipment" or "Special Order" then begin
        #9..11
            if (Quantity <> 0) and (Quantity = "Quantity Shipped") then
        #13..15
            if "Drop Shipment" then begin
        #17..20
            end;
          end else
            SetReserveWithoutPurchasingCode;
        end else begin
          "Drop Shipment" := false;
          "Special Order" := false;
          SetReserveWithoutPurchasingCode;
        end;

        if ("Purchasing Code" <> xRec."Purchasing Code") and
           (not "Drop Shipment") and
           ("Drop Shipment" <> xRec."Drop Shipment")
        then begin
          if "Location Code" = '' then begin
            if InvtSetup.GET then
              "Outbound Whse. Handling Time" := InvtSetup."Outbound Whse. Handling Time";
          end else
            if Location.GET("Location Code") then
              "Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
          if ShippingAgentServices.GET("Shipping Agent Code","Shipping Agent Service Code") then
            "Shipping Time" := ShippingAgentServices."Shipping Time"
          else begin
            GetSalesHeader;
            "Shipping Time" := SalesHeader."Shipping Time";
          end;
          UpdateDates;
        end;

        // <<DITW15.00.00.01 15/01/2008
        // <<DITW15.00.00.19 DDR 22/04/2008 - DITW19.00.08 DDR 10/11/2016 BL#11843
        if xRec."Purchasing Code" <> "Purchasing Code" then
          UpdateCharges(FIELDNO("Purchasing Code"),(CurrFieldNo = FIELDNO("Purchasing Code")));
        // >>DITW15.00.00.01 DDR -
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Special Order"(Field 5713)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.01 15/01/2008
        // <<DITW15.00.00.19 DDR 22/04/2008
        if Type = Type::Item then
          UpdateCharges(FIELDNO("Special Order"),true);
        // >>DITW15.00.00.01 DDR
        */
        //end;


        //Unsupported feature: CodeModification on ""Requested Delivery Date"(Field 5790).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF ("Requested Delivery Date" <> xRec."Requested Delivery Date") AND
           ("Promised Delivery Date" <> 0D)
        THEN
          ERROR(
            Text028,
            FIELDCAPTION("Requested Delivery Date"),
            FIELDCAPTION("Promised Delivery Date"));

        IF "Requested Delivery Date" <> 0D THEN
          VALIDATE("Planned Delivery Date","Requested Delivery Date")
        ELSE BEGIN
          GetSalesHeader;
          VALIDATE("Shipment Date",SalesHeader."Shipment Date");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if ("Requested Delivery Date" <> xRec."Requested Delivery Date") and
           ("Promised Delivery Date" <> 0D)
        then
        #5..9
        if "Requested Delivery Date" <> 0D then
          VALIDATE("Planned Delivery Date","Requested Delivery Date")
        else begin
          GetSalesHeader;
          VALIDATE("Shipment Date",SalesHeader."Shipment Date");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Promised Delivery Date"(Field 5791).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Promised Delivery Date" <> 0D THEN
          VALIDATE("Planned Delivery Date","Promised Delivery Date")
        ELSE
          VALIDATE("Requested Delivery Date");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if "Promised Delivery Date" <> 0D then
          VALIDATE("Planned Delivery Date","Promised Delivery Date")
        else
          VALIDATE("Requested Delivery Date");
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Time"(Field 5792).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Drop Shipment" THEN
          DateFormularZero("Shipping Time",FIELDNO("Shipping Time"),FIELDCAPTION("Shipping Time"));
        UpdateDates;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        GetSalesHeader();
        if FORMAT(SalesHeader."Journey Time") = '' then
          TestStatusModifyEmcs(FIELDCAPTION("Shipping Time"));
        // >>DITW16.00.00.43 DDR DIT-715 #720
        if "Drop Shipment" then
          DateFormularZero("Shipping Time",FIELDNO("Shipping Time"),FIELDCAPTION("Shipping Time"));
        UpdateDates;
        */
        //end;


        //Unsupported feature: CodeModification on ""Outbound Whse. Handling Time"(Field 5793).OnValidate". Please convert manually.

        //trigger  Handling Time"(Field 5793)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Drop Shipment" THEN
          DateFormularZero("Outbound Whse. Handling Time",
            FIELDNO("Outbound Whse. Handling Time"),FIELDCAPTION("Outbound Whse. Handling Time"));
        UpdateDates;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if "Drop Shipment" then
        #3..5
        */
        //end;


        //Unsupported feature: CodeModification on ""Planned Delivery Date"(Field 5794).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Planned Delivery Date" <> 0D THEN BEGIN
          PlannedDeliveryDateCalculated := TRUE;

          IF FORMAT("Shipping Time") <> '' THEN
            VALIDATE("Planned Shipment Date",CalcPlannedDeliveryDate(FIELDNO("Planned Delivery Date")))
          ELSE
            VALIDATE("Planned Shipment Date",CalcPlannedShptDate(FIELDNO("Planned Delivery Date")));

          IF "Planned Shipment Date" > "Planned Delivery Date" THEN
            "Planned Delivery Date" := "Planned Shipment Date";
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if "Planned Delivery Date" <> 0D then begin
          PlannedDeliveryDateCalculated := true;

          if FORMAT("Shipping Time") <> '' then
            VALIDATE("Planned Shipment Date",CalcPlannedDeliveryDate(FIELDNO("Planned Delivery Date")))
          else
            VALIDATE("Planned Shipment Date",CalcPlannedShptDate(FIELDNO("Planned Delivery Date")));

          if "Planned Shipment Date" > "Planned Delivery Date" then
            "Planned Delivery Date" := "Planned Shipment Date";

          // <<DITW16.00.00.40 DDR 16/04/2012 DIT-715 #247
          if (CurrFieldNo <> FIELDNO("Shipment Date")) and (Quantity < 0) and
            (FORMAT("Ret. Receipt Date Calculation") <> '')
          then
            VALIDATE("Shipment Date",CALCDATE("Ret. Receipt Date Calculation","Planned Delivery Date"));
          // >>DITW16.00.00.40 DDR DIT-715 #247
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Planned Shipment Date"(Field 5795).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Planned Shipment Date" <> 0D THEN BEGIN
          PlannedShipmentDateCalculated := TRUE;

          IF FORMAT("Outbound Whse. Handling Time") <> '' THEN
            VALIDATE(
              "Shipment Date",
              CalendarMgmt.CalcDateBOC2(
        #9..13
                CalChange."Source Type"::"Shipping Agent",
                "Shipping Agent Code",
                "Shipping Agent Service Code",
                FALSE))
          ELSE
            VALIDATE(
              "Shipment Date",
              CalendarMgmt.CalcDateBOC(
        #22..26
                CalChange."Source Type"::Location,
                "Location Code",
                '',
                FALSE));
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TestStatusOpen;
        if "Planned Shipment Date" <> 0D then begin
          PlannedShipmentDateCalculated := true;

          if FORMAT("Outbound Whse. Handling Time") <> '' then
        #6..16
                false))
          else
        #19..29
                false));
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Code"(Field 5796).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Shipping Agent Code" <> xRec."Shipping Agent Code" THEN
          VALIDATE("Shipping Agent Service Code",'');
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW17.00.02 AT 20/12/2013 DIT-770 #289
        //TestStatusOpen;
        //>> DITW17.00.02 AT 20/12/2013 DIT-770 #289
        // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        TestStatusModifyEmcs(FIELDCAPTION("Shipping Agent Code"));
        // >>DITW16.00.00.43 DDR DIT-715 #720
        if "Shipping Agent Code" <> xRec."Shipping Agent Code" then
          VALIDATE("Shipping Agent Service Code",'');
        */
        //end;


        //Unsupported feature: CodeModification on ""Shipping Agent Service Code"(Field 5797).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;
        IF "Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" THEN
          EVALUATE("Shipping Time",'<>');

        IF "Drop Shipment" THEN BEGIN
          EVALUATE("Shipping Time",'<0D>');
          UpdateDates;
        END ELSE
          IF ShippingAgentServices.GET("Shipping Agent Code","Shipping Agent Service Code") THEN
            "Shipping Time" := ShippingAgentServices."Shipping Time"
          ELSE BEGIN
            GetSalesHeader;
            "Shipping Time" := SalesHeader."Shipping Time";
          END;

        IF ShippingAgentServices."Shipping Time" <> xRec."Shipping Time" THEN
          VALIDATE("Shipping Time","Shipping Time");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW17.00.02 AT 20/12/2013 DIT-770 #289
        //TestStatusOpen;
        //>> DITW17.00.02 AT 20/12/2013 DIT-770 #289
        // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
        TestStatusModifyEmcs(FIELDCAPTION("Shipping Agent Service Code"));
        // >>DITW16.00.00.43 DDR DIT-715 #720
        if "Shipping Agent Service Code" <> xRec."Shipping Agent Service Code" then
          EVALUATE("Shipping Time",'<>');

        if "Drop Shipment" then begin
          EVALUATE("Shipping Time",'<0D>');
          UpdateDates;
        end else
          if ShippingAgentServices.GET("Shipping Agent Code","Shipping Agent Service Code") then
            "Shipping Time" := ShippingAgentServices."Shipping Time"
          else begin
            GetSalesHeader;
            "Shipping Time" := SalesHeader."Shipping Time";
          end;

        if ShippingAgentServices."Shipping Time" <> xRec."Shipping Time" then
          VALIDATE("Shipping Time","Shipping Time");
        */
        //end;


        //Unsupported feature: CodeModification on ""Return Qty. to Receive"(Field 5803).OnValidate". Please convert manually.

        //trigger  to Receive"(Field 5803)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (CurrFieldNo <> 0) AND
           (Type = Type::Item) AND
           ("Return Qty. to Receive" <> 0) AND
           (NOT "Drop Shipment")
        THEN
          CheckWarehouse;

        IF "Return Qty. to Receive" = Quantity - "Return Qty. Received" THEN
          InitQtyToReceive
        ELSE BEGIN
          "Return Qty. to Receive (Base)" := CalcBaseQty("Return Qty. to Receive");
          InitQtyToInvoice;
        END;
        IF ("Return Qty. to Receive" * Quantity < 0) OR
           (ABS("Return Qty. to Receive") > ABS("Outstanding Quantity")) OR
           (Quantity * "Outstanding Quantity" < 0)
        THEN
          ERROR(
            Text020,
            "Outstanding Quantity");
        IF ("Return Qty. to Receive (Base)" * "Quantity (Base)" < 0) OR
           (ABS("Return Qty. to Receive (Base)") > ABS("Outstanding Qty. (Base)")) OR
           ("Quantity (Base)" * "Outstanding Qty. (Base)" < 0)
        THEN
          ERROR(
            Text021,
            "Outstanding Qty. (Base)");

        IF (CurrFieldNo <> 0) AND (Type = Type::Item) AND ("Return Qty. to Receive" > 0) THEN
          CheckApplFromItemLedgEntry(ItemLedgEntry);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 VSC 28/01/2016 DIT-770 #1702
        ValidateMancoSurplusTolerance;
        //>> DITW18.00.07 VSC DIT-770 #1702

        if (CurrFieldNo <> 0) and
           (Type = Type::Item) and
           ("Return Qty. to Receive" <> 0) and
           (not "Drop Shipment")
        then
          CheckWarehouse;

        if "Return Qty. to Receive" = Quantity - "Return Qty. Received" then
          InitQtyToReceive
        else begin
          "Return Qty. to Receive (Base)" := CalcBaseQty("Return Qty. to Receive");
          InitQtyToInvoice;
        end;
        if ("Return Qty. to Receive" * Quantity < 0) or
           (ABS("Return Qty. to Receive") > ABS("Outstanding Quantity")) or
           (Quantity * "Outstanding Quantity" < 0)
        then
        #18..20
        if ("Return Qty. to Receive (Base)" * "Quantity (Base)" < 0) or
           (ABS("Return Qty. to Receive (Base)") > ABS("Outstanding Qty. (Base)")) or
           ("Quantity (Base)" * "Outstanding Qty. (Base)" < 0)
        then
        #25..28
        if (CurrFieldNo <> 0) and (Type = Type::Item) and ("Return Qty. to Receive" > 0) then
          CheckApplFromItemLedgEntry(ItemLedgEntry);

        // <<DITW15.00.00.01 DDR 04/01/2008 - 15/01/2008
        // <<DITW15.00.00.19 DDR 22/04/2008  - DITW15.00.00.31 DDR 19/02/2009 - DITW15.00.00.35 DDR 29/06/2009
        // <<DITW15.00.00.36 DDR 22/12/2009 - DITW15.00.00.37 DDR 22/01/2010-DITW111.00.13A MSF 22/04/2019 NRQ#108355
        if (Type = Type::Item) and
        //>>DITW111.00.13A MSF 22/04/2019 NRQ#108355
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925 - DITW114.00.15 DDR 29/04/2020 NRQ#102424
          (CurrFieldNo <> FIELDNO(Quantity)) and
          // >>DITW110.00.11 DDR NRQ#37925 - DITW114.00.15 DDR NRQ#102424
          not BatchInsertCheckSuspended
        then
          // <<DITW110.00.11 DDR 06/10/2017 NRQ#37925 - DITW114.00.15 DDR 29/04/2020 NRQ#102424
          UpdateCharges(FIELDNO("Return Qty. to Receive"),not ISTEMPORARY);
          // >>DITW110.00.11 DDR NRQ#37925 - DITW114.00.15 DDR NRQ#102424
        // >>DITW15.00.00.37 DDR - DITW16.00.00.40 DDR DIT-715 #275
        */
        //end;


        //Unsupported feature: CodeModification on ""Return Rcd. Not Invd."(Field 5807).OnValidate". Please convert manually.

        //trigger  Not Invd();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSalesHeader;
        Currency2.InitRoundingPrecision;
        IF SalesHeader."Currency Code" <> '' THEN
          "Return Rcd. Not Invd. (LCY)" :=
            ROUND(
              CurrExchRate.ExchangeAmtFCYToLCY(
                GetDate,"Currency Code",
                "Return Rcd. Not Invd.",SalesHeader."Currency Factor"),
              Currency2."Amount Rounding Precision")
        ELSE
          "Return Rcd. Not Invd. (LCY)" :=
            ROUND("Return Rcd. Not Invd.",Currency2."Amount Rounding Precision");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        GetSalesHeader;
        Currency2.InitRoundingPrecision;
        if SalesHeader."Currency Code" <> '' then
        #4..9
        else
          "Return Rcd. Not Invd. (LCY)" :=
            ROUND("Return Rcd. Not Invd.",Currency2."Amount Rounding Precision");
        */
        //end;


        //Unsupported feature: CodeModification on ""Appl.-from Item Entry"(Field 5811).OnValidate". Please convert manually.

        //trigger -from Item Entry"(Field 5811)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Appl.-from Item Entry" <> 0 THEN BEGIN
          CheckApplFromItemLedgEntry(ItemLedgEntry);
          VALIDATE("Unit Cost (LCY)",CalcUnitCost(ItemLedgEntry));
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Appl.-from Item Entry" <> 0 then begin
          CheckApplFromItemLedgEntry(ItemLedgEntry);
          VALIDATE("Unit Cost (LCY)",CalcUnitCost(ItemLedgEntry));
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Customer Disc. Group"(Field 7002).OnValidate". Please convert manually.

        //trigger  Group"(Field 7002)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Type = Type::Item THEN
          UpdateUnitPrice(FIELDNO("Customer Disc. Group"))
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Type = Type::Item then
          UpdateUnitPrice(FIELDNO("Customer Disc. Group"))
        */
        //end;
        field(50000; "Document Subtype Code FND"; Code[10])
        {
            Caption = 'Document Subtype Code';
            Description = 'HEI.01';
        }
        field(50001; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.04';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50002; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.04';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        field(50003; "WHT Absorb Base FND"; Decimal)
        {
            Caption = 'WHT Absorb Base';
            Description = 'HEI.04';
        }
        field(50004; "Forecasted Shipment Date FND"; Date)
        {
            Caption = 'Forecasted Shipment Date';
            Description = 'HEI.06';
        }
        field(50005; "RPM Solution FND"; Option)
        {
            Caption = 'RPM Solution';
            Description = 'HEI.07';
            Editable = false;
            OptionCaption = ' ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)';
            OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
        }
        field(50006; "RPM Type FND"; Code[20])
        {
            Description = 'HEI.07';
            Caption = 'RPM Type';
            Editable = false;
            TableRelation = "Return Pack Material Type FND".Code;
        }
        field(50007; "Item Type FND"; Option)
        {
            Caption = 'Item Type';
            Description = 'HEI.07';
            Editable = false;
            OptionCaption = ' ,RPM Related,Product Related';
            OptionMembers = " ","RPM Related","Product Related";
        }
        field(50010; "RPM Damage / Loss FND"; Boolean)
        {
            Description = 'HEI.08';
            Caption = 'RPM Damage / Loss';

            trigger OnValidate();
            begin
                //>>HEI.08
                if ("RPM Damage / Loss FND" <> xRec."RPM Damage / Loss FND")
                   and "RPM Damage / Loss FND"
                   and (Type <> Type::Item)
                   or not ("RPM Solution FND" in ["RPM Solution"::"Full-for Empty without revenue impact (FFE w/o revenue)".AsInteger(),
                                           "RPM Solution"::"Full-for-Empty with revenue impact (FFE with revenue)".AsInteger()])
                then
                    ERROR(RPMDamageLossTrueErr, FIELDCAPTION("RPM Damage / Loss FND"), "RPM Damage / Loss FND", FIELDCAPTION(Type),
                          Type::Item, FIELDCAPTION("RPM Solution FND"), "RPM Solution"::"Full-for Empty without revenue impact (FFE w/o revenue)",
                          "RPM Solution"::"Full-for-Empty with revenue impact (FFE with revenue)");

                if "RPM Damage / Loss FND" and not xRec."RPM Damage / Loss FND" then
                    "TransporterRPM Damage/Loss FND" := false;
                //<<HEI.08
            end;
        }
        field(50011; "TransporterRPM Damage/Loss FND"; Boolean)
        {
            Caption = 'Transporter RPM Damage / Loss';
            Description = 'HEI.08';

            trigger OnValidate();
            begin
                //>>HEI.08
                if ("TransporterRPM Damage/Loss FND" <> xRec."TransporterRPM Damage/Loss FND")
                   and "TransporterRPM Damage/Loss FND"
                   and (Type <> Type::Item)
                   or not ("RPM Solution FND" in ["RPM Solution"::"Full-for Empty without revenue impact (FFE w/o revenue)".AsInteger(),
                                           "RPM Solution"::"Full-for-Empty with revenue impact (FFE with revenue)".AsInteger()])
                then
                    ERROR(RPMDamageLossTrueErr, FIELDCAPTION("TransporterRPM Damage/Loss FND"), "TransporterRPM Damage/Loss FND", FIELDCAPTION(Type),
                          Type::Item, FIELDCAPTION("RPM Solution FND"), "RPM Solution"::"Full-for Empty without revenue impact (FFE w/o revenue)",
                          "RPM Solution"::"Full-for-Empty with revenue impact (FFE with revenue)");

                if "TransporterRPM Damage/Loss FND" and not xRec."TransporterRPM Damage/Loss FND" then
                    "RPM Damage / Loss FND" := false;
                //<<HEI.08
            end;
        }
        field(50012; "Posted Whse. Shpmnt No. FND"; Code[20])
        {
            Description = 'LOGGAP07';
            Caption = 'Posted Wharehouse Shipment No.';
        }
        field(50013; "Whse. Shipment No. FND"; Code[20])
        {
            Description = 'LOGGAP07';
            Caption = 'Wharehouse Shipment No.';
        }
        field(50016; "TIN No. FND"; Text[20])
        {
            Caption = 'TIN No.';
            Description = 'HEI.12';
            Editable = false;
            TableRelation = "TIN by Location FND"."TIN No.";
            ValidateTableRelation = false;
        }
        field(50017; "Unavailable Inv. (Whse) FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                "Location Code" = FIELD("Location Code"),
                                                                "Unavailable Stock FND" = CONST(true)));
            DecimalPlaces = 0 : 5;
            Description = 'HEI.15';
            Caption = 'Unavailable Inventory (Warehouse)';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50019; "Maraki Fiscal No. FND"; Code[30])
        {
            CalcFormula = Lookup("Sales Header"."Free Reason Code FND" WHERE("Document Type" = FIELD("Document Type"),
                                                                          "No." = FIELD("Document No.")));
            Caption = 'Maraki Fiscal No.';
            Description = 'HEI.18';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; "EDI unit of measure FND"; Text[20])
        {
            Description = 'HEI.21';
            Caption = 'EDI unit of measure';
            Editable = false;
        }
        field(50021; "Product GTIN code FND"; Code[20])
        {
            Description = 'HEI.21';
            Caption = 'Product GTIN code';
        }
        field(50022; "Is Reduced Return FND"; Boolean)
        {
            Description = 'HEI.26';
            Editable = false;
            caption = 'Is Reduced Return';
        }
        field(50023; "Reduced Return Factor FND"; Decimal)
        {
            Description = 'HEI.26';
            Caption = 'Reduced Return Factor';
        }
        field(50024; "CAD Amount FND"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.32';
            Editable = false;
        }
        field(50025; "Timbre applied FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.33';
            Caption = 'Timbre Applied';
        }
        field(50026; "Freshness Date (min) FND"; Date)
        {
            Caption = 'Freshness Date (min)';
            DataClassification = CustomerContent;
            Description = 'HEI.39';
        }
        field(80000; "Record GUID FND"; Guid)
        {
            Description = 'NRQ6581';
            Caption = 'Record GUID';
        }
        //BCUPGRADE
        //DRINKIT Fields
        /*
        field(2013610;"Item DDeposit Group Code";Code[10])
        {
            CaptionML = ENU='Item Deposit Group Code',
                        FRA='Code groupe consigne article';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Deposit Group".Code WHERE ("Source Type"=CONST(Item));

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(2013611;"Empty Goods Item No.";Code[20])
        {
            CaptionML = ENU='Empty Goods Item No.',
                        FRA='N° article vidange';
            Description = 'DITW15.00.00.01-.35';
            TableRelation = Item WHERE ("Empty Good"=CONST(true));

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
                // >>DITW15.00.00.35 DDR
            end;
        }
        field(2013612;"Item Charge Quantity per";Decimal)
        {
            CaptionML = ENU='Item Charge Quantity per',
                        FRA='Quantité frais annexes par';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.01';
            MinValue = 0;
        }
        field(2013613;"Empty Goods Item No. Filter";Code[20])
        {
            CaptionML = ENU='Empty Goods Item No. Filter',
                        FRA='Filtre article vidange n°';
            Description = 'DITW17.00.01';
            FieldClass = FlowFilter;
            TableRelation = Item;
        }
        field(2013614;"Item Charge Type Filter";Option)
        {
            CaptionML = ENU='Item Charge Type Filter',
                        FRA='Filtre type frais article';
            Description = 'DITW17.00.01';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                              FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,"Shipping Cost";
        }
        field(2013615;"Rounding factor";Option)
        {
            CaptionML = ENU='Rounding factor',
                        FRA='Unité d''affichage';
            Description = 'DITW17.00.02 DIT-770 #142';
            Editable = false;
            OptionCaptionML = ENU='Nearest,Up,Down',
                              FRA='Au plus près,Par excès,Par défaut';
            OptionMembers = Nearest,Up,Down;
        }
        field(2013622;"Empty Good";Boolean)
        {
            CalcFormula = Lookup("Inventory Posting Group"."As Empty Good" WHERE (Code=FIELD("Posting Group")));
            Caption = 'Empty Good';
            Description = 'NRQ#16224';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013636;"Split Deposit on Invoice";Boolean)
        {
            CaptionML = ENU='Split Deposit on Invoice (Entries)',
                        FRA='Diviser consigne sur facture (écritures)';
            Description = 'DITW16.00.00.42 DIT-715 #370';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                TestStatusOpen;
                // >>DITW18.00.07 DDR DIT-770 #1488
                // <<DITW16.00.00.42 DDR 07/12/2012 DIT-715 #370
                if "Split Deposit on Invoice" then begin
                  if Type <> Type::"Charge (Item)" then
                    FIELDERROR(Type);
                  TESTFIELD("Item Charge Type","Item Charge Type"::Deposit);
                  GetSalesHeader();
                  SalesHeader.TESTFIELD("Deposit Cust. Posting Group");
                end;
                // >>DITW16.00.00.42 DDR DIT-715 #370
            end;
        }
        field(2013637;"Deposit Value";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Deposit Value';
            Description = 'DITW110.00.11 BL#14417';
        }
        field(2013660;"Extra Charge Type";Option)
        {
            CaptionML = ENU='Extra Charge Type',
                        FRA='Type frais extra';
            Description = 'VC8-DITW15.00.00.01-.34';
            OptionCaptionML = ENU=' ,Amount,Price %,Amount %,Fixed Amount,Volume /Unit,Weight,Cubage,Distance,Sales Price,Unit of measure',
                              FRA=' ,Montant,Prix %,Montant %,Montant Fixe,Volume /Unit,Poids,Cubage,Distance,Prix vente,Unit of measure';
            OptionMembers = " ",Amount,"Price %","Amount %","Fixed Amount",VolumeHL,Weight,Cubage,Distance,"Price Item","Unit of measure";
        }
        field(2013661;"Item Charge Value";Decimal)
        {
            AutoFormatExpression = GetAutoformatRoundingType("Currency Code");
            AutoFormatType = 2;
            CaptionML = ENU='Item Charge Value',
                        FRA='Valeur frais annexes';
            Description = 'DITW15.00.00.32';
        }
        field(2013662;"Is Item Charge";Boolean)
        {
            CaptionML = ENU='Is Item Charge',
                        FRA='Est frais annexes';
            Description = 'VC8-DITW15.00.00.01';
        }
        field(2013663;"ItemCharge Incl. Price";Boolean)
        {
            CaptionML = ENU='Item Charge Incl. Price',
                        FRA='Frais annexe inclus prix';
            Description = 'VC8-DITW15.00.00.01';
        }
        field(2013664;"Item Charge Discount %";Decimal)
        {
            CaptionML = ENU='Item Charge Discount %',
                        FRA='Remise frais annexes %';
            Description = 'VC8-DITW15.00.00.01';
        }
        field(2013665;"Allow Item Charge Line Disc.";Boolean)
        {
            CaptionML = ENU='Allow Item Charge Line Discount',
                        FRA='Frais annexes remise ligne autorisé';
            Description = 'VC8-DITW15.00.00.01';
            InitValue = true;
        }
        field(2013666;"Customer DTax Group Code";Code[20])
        {
            CaptionML = ENU='Customer Tax Group Code',
                        FRA='Code groupe taxe client';
            Description = 'DITW17.10.03 DIT-770 623,HEI.05';
            TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Customer));

            trigger OnValidate();
            begin
                // <<DITW17.10.03 DDR 19/05/2014 DIT-770 #623
                TestStatusOpen;
                TestCustTaxRegHeader();
                TestStatusModifyEmcs(FIELDCAPTION("Customer DTax Group Code"));
                // <<DITW17.10.05 MSF 30/07/2014 DIT-770 #692
                if (xRec."Customer DTax Group Code" <> "Customer DTax Group Code") and
                  ("Line No." <> 0) and (Quantity <> 0) and
                  (not BatchInsertCheckSuspended)
                then begin
                  TESTFIELD(Type,Type::Item);
                  CLEAR(CommonItemChrgMgt);
                  CLEAR(TransferTaxCharges);
                  GetSalesHeader();
                  ForceDeleteItemCharges := false;
                  CLEAR(SaveTempSalesChargeLine);
                  SaveTempSalesChargeLine.DELETEALL;
                  SalesLine2.COPY(Rec);
                  SaveTempSalesChargeLine.SETRANGE("Item Charge Type",SaveTempSalesChargeLine."Item Charge Type"::Tax);
                  CommonItemChrgMgt.DeleteSalesLines(SalesLine2,
                    SaveTempSalesChargeLine,true,"Item Charge Calculate per"::Item);
                  TransferTaxCharges.SuspendStatusCheck(true);
                  TransferTaxCharges.CalcUnitPriceSalesLine(SalesHeader,Rec,0,true,0);
                  if TransferTaxCharges.SalesCheckIfAny(SalesHeader,Rec,false,FIELDNO(Quantity)) then begin
                    TransferTaxCharges.TempInsertSales(Rec,SaveTempSalesChargeLine);
                    GetItem();
                    if Item."Gift Box Item" then begin
                      if BomItemCharges.SalesCheckIfAny(SalesHeader,Rec,true,FIELDNO(Quantity)) then
                        BomItemCharges.TempInsertSales(Rec,SaveTempSalesChargeLine);
                    end;
                    if TransferTaxCharges.MakeUpdate() or BomItemCharges.MakeUpdate() then begin
                      CommonItemChrgMgt.InsertChrgSalesLines(
                        SalesHeader,Rec,SaveTempSalesChargeLine,SaveTempItemChrgAssgnSales,true,true,true,true);
                      UpdateAmounts();
                    end;
                  end;
                end;
                // >>DITW17.10.05 MSF DIT-770 #692

                UpdateAADInfo();
            end;
        }
        field(2013667;"Item DTax Group Code";Code[10])
        {
            CaptionML = ENU='Item Tax Group Code',
                        FRA='Code groupe taxe article';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Tax Group".Code WHERE ("Source Type"=CONST(Item));

            trigger OnValidate();
            begin
                TestStatusOpen;
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusModifyEmcs(FIELDCAPTION("Item DTax Group Code"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW15.00.00.38 DDR 20/08/2010 #1217
                UpdateAADInfo();
                // >>DITW15.00.00.38 DDR
            end;
        }
        field(2013695;"Item Charge Type";Option)
        {
            CaptionML = ENU='Item Charge Type',
                        FRA='Type frais annexes';
            Description = 'DITW15.00.00.01-.35';
            OptionCaptionML = ENU=' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                              FRA=' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
            OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        }
        field(2013696;"Location Group Code";Code[10])
        {
            CaptionML = ENU='Location Tax Group Code',
                        FRA='Code groupe magasin taxe';
            Description = 'DITW15.00.00.35';
            TableRelation = "Location Group";

            trigger OnValidate();
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusOpen();
                TestStatusModifyEmcs(FIELDCAPTION("Location Group Code"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW15.00.00.38 DDR 20/08/2010 #1217
                UpdateAADInfo();
                // >>DITW15.00.00.38 DDR
            end;
        }
        field(2013708;"Due Tax";Boolean)
        {
            CaptionML = ENU='Due Tax',
                        FRA='Taxe due';
            Description = 'DITW15.00.00.01';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
                // >>DITW15.00.00.35 DDR
                // <<DITW15.00.00.38 DDR 20/08/2010 #1217
                TestDutySuspendMandatory();
                // >>DITW15.00.00.38 DDR

                // <<DITW17.10.05 MSF 08/12/2014 DIT-770 #701
                TestTaxDueMandatory();
                // >>DITW17.10.05 MSF 08/12/2014 DIT-770 #701

                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusModifyEmcs(FIELDCAPTION("Due Tax"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2013715;"Tax Formula";Code[80])
        {
            CaptionML = ENU='Tax Formula',
                        FRA='Formule taxe';
            Description = 'DITW15.00.00.30';
        }
        field(2013716;"Strength Spec. Code";Code[20])
        {
            CaptionClass = GetTaxSpecCaption(0,FIELDNO("Strength Spec. Code"));
            CaptionML = ENU='Strength Spec. Code',
                        FRA='Code contrainte spécification taxe';
            Description = 'DITW19.00.08 BL#10443';
            TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));

            trigger OnValidate();
            begin
                // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                TestStatusOpen;
                TESTFIELD(Type,Type::Item);
            end;
        }
        field(2013717;"Strength Spec. Value";Decimal)
        {
            AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
            AutoFormatType = 2013664;
            CalcFormula = Average("Reservation Entry"."Strength Spec. Value" WHERE ("Source Type"=CONST(37),
                                                                                    "Source Subtype"=FIELD("Document Type"),
                                                                                    "Source ID"=FIELD("Document No."),
                                                                                    "Source Batch Name"=CONST(''),
                                                                                    "Source Prod. Order Line"=CONST(0),
                                                                                    "Source Ref. No."=FIELD("Line No.")));
            CaptionClass = GetTaxSpecCaption(1,FIELDNO("Strength Spec. Value"));
            CaptionML = ENU='Strength Spec. Value',
                        FRA='Valeur contrainte spécification';
            Description = 'DITW19.00.08 BL#10443';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013718;"Vol-Strength Spec. Code";Code[20])
        {
            CaptionClass = GetTaxSpecCaption(0,FIELDNO("Vol-Strength Spec. Code"));
            CaptionML = ENU='Vol-Strength Spec. Code',
                        FRA='Code spécification contrainte volume';
            Description = 'DITW19.00.08 BL#10443';
            TableRelation = "Tax Specification" WHERE (Type=CONST(Specification));

            trigger OnValidate();
            begin
                // <<DITW19.00.08 DDR 17/08/2016 BL#10443
                TestStatusOpen;
            end;
        }
        field(2013719;"Vol-Strength Spec. Value";Decimal)
        {
            AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
            AutoFormatType = 2013664;
            CalcFormula = Sum("Reservation Entry"."Vol-Strength Spec. Value" WHERE ("Source Type"=CONST(37),
                                                                                    "Source Subtype"=FIELD("Document Type"),
                                                                                    "Source ID"=FIELD("Document No."),
                                                                                    "Source Batch Name"=CONST(''),
                                                                                    "Source Prod. Order Line"=CONST(0),
                                                                                    "Source Ref. No."=FIELD("Line No.")));
            CaptionClass = GetTaxSpecCaption(1,FIELDNO("Vol-Strength Spec. Value"));
            CaptionML = ENU='Vol-Strength Spec. Value',
                        FRA='Valeur spécification contrainte volume';
            Description = 'DITW19.00.08 BL#10443';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2013722;"Duty Suspended";Boolean)
        {
            CaptionML = ENU='Duty Suspended',
                        FRA='Taxe en suspension';
            Description = 'DITW15.00.00.33';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.38 DDR 20/08/2010 #1217
                TestDutySuspendMandatory();
                // >>DITW15.00.00.38 DDR
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusModifyEmcs(FIELDCAPTION("Duty Suspended"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2013726;"Company Tax Registration No.";Text[20])
        {
            CaptionML = ENU='Company Tax Registration No.',
                        FRA='N° identif. accise société';
            Description = 'DITW15.00.00.28';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
                // >>DITW15.00.00.35 DDR
                // <<DITW15.00.00.38 DDR 20/08/2010 #1217
                TestTaxRegMandatory();
                // >>DITW15.00.00.38 DDR
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusModifyEmcs(FIELDCAPTION("Company Tax Registration No."));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2013727;"AAD No. Series";Code[10])
        {
            CaptionML = ENU='AAD No. Series',
                        FRA='Souches de n° DAA';
            Description = 'DITW15.00.00.28';
            TableRelation = "No. Series";

            trigger OnLookup();
            var
                lrSalesLine : Record "Sales Line";
                lDefaultAADCode : Code[10];
            begin
                // <<DITW15.00.00.28 DDR 24/11/2008
                // <<DITW15.00.00.38 DDR 17/12/2010 #703
                if Type = Type::"Charge (Item)" then
                  TESTFIELD("Tax Item No.")
                else
                TESTFIELD(Type,Type::Item);
                // >>DITW15.00.00.38 DDR #703

                // <<DITW15.00.00.33 DDR 14/05/2009 - DITW15.00.00.38 DDR 20/08/2010 #1217
                TestAADNoSeriesMandatory();
                // >>DITW15.00.00.38 DDR

                with lrSalesLine do begin
                  lrSalesLine := Rec;
                  lDefaultAADCode := GetAADNoSeries();
                  if NoSeriesMgt.LookupSeries(lDefaultAADCode,"AAD No. Series") then
                    VALIDATE("AAD No. Series");
                  Rec := lrSalesLine;
                end;
            end;

            trigger OnValidate();
            var
                lDefaultAADCode : Code[10];
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
                // >>DITW15.00.00.35 DDR
                // <<DITW15.00.00.28 DDR 24/11/2008
                // <<DITW15.00.00.38 DDR 17/12/2010 #703
                if Type = Type::"Charge (Item)" then
                  TESTFIELD("Tax Item No.")
                else
                  TESTFIELD(Type,Type::Item);
                // >>DITW15.00.00.38 DDR #703

                if "AAD No. Series" <> '' then begin
                  lDefaultAADCode := GetAADNoSeries();
                  if lDefaultAADCode <> '' then
                    NoSeriesMgt.TestSeries(lDefaultAADCode,"AAD No. Series");
                  // <<DITW15.00.00.32 DDR 09/04/2009 - DITW15.00.00.38 DDR 20/08/2010 #1217
                  TestAADNoSeriesMandatory();
                  // >>DITW15.00.00.38 DDR
                end;
                TESTFIELD("AAD No.",'');
            end;
        }
        field(2013728;"AAD No.";Code[20])
        {
            CaptionML = ENU='AAD No.',
                        FRA='N° DAA';
            Description = 'DITW15.00.00.28';

            trigger OnValidate();
            begin
                // << DITW15.00.00.35 DDR 24/06/2009 - DITW15.00.00.37 DDR 07/01/2010
                if "Outstanding Quantity" = 0 then
                  FIELDERROR("Outstanding Quantity");
                // >>DITW15.00.00.37 DDR
                // <<DITW15.00.00.39 DDR 11/07/2011 #1369
                if CurrFieldNo = FIELDNO("AAD No.") then
                  TESTFIELD("Applies-to AAD Trck. Entry No.",0);
                // >>DITW15.00.00.39 DDR #1369

                // <<DITW15.00.00.28 DDR 24/11/2008
                // <<DITW15.00.00.38 DDR 17/12/2010 #703
                if Type = Type::"Charge (Item)" then
                  TESTFIELD("Tax Item No.")
                else
                TESTFIELD(Type,Type::Item);
                // >>DITW15.00.00.38 DDR #703

                if "AAD No." <> xRec."AAD No." then begin
                  NoSeriesMgt.TestManual("AAD No. Series");
                  "AAD No. Series" := '';
                end;

                if "AAD No." <> '' then begin
                  AADDocMgt.CheckAADNo("AAD No.");
                  // <<DITW15.00.00.32 DDR 09/04/2009
                  TESTFIELD("Tariff No.");
                  // >>DITW15.00.00.32 DDR
                end;
            end;
        }
        field(2013729;"Tariff No.";Code[10])
        {
            CaptionML = ENU='Tariff No.',
                        FRA='Nomenclature produits';
            Description = 'DITW15.00.00.28';
            TableRelation = "Tariff Number";

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
                // >>DITW15.00.00.35 DDR
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusModifyEmcs(FIELDCAPTION("Tariff No."));
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW15.00.00.32 DDR 09/04/2009
                if "Tariff No." = '' then begin
                  TESTFIELD("AAD No. Series",'');
                  // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                  TESTFIELD("LRN No. Series",'');
                  // >>DITW16.00.00.43 DDR DIT-715 #720
                end;
                // >>DITW15.00.00.32 DDR
            end;
        }
        field(2013731;"Applies-to AAD Trck. Entry No.";Integer)
        {
            CaptionML = ENU='Applies-to Correction AAD Trck. Entry No.',
                        FRA='N° Ecriture correction suivi DAA lettrage';
            Description = 'DITW15.00.00.39 #1369';
            TableRelation = "AAD Tracking Entry"."Entry No." WHERE ("Entry Type"=CONST(Outbound),
                                                                    "Source Type"=CONST(Customer),
                                                                    "Source No."=FIELD("Sell-to Customer No."));

            trigger OnLookup();
            var
                AADTrackingEntry : Record "AAD Tracking Entry";
            begin
                // <<DITW16.00.00.39 DDR 05/08/2011 DIT-715 #148
                AADTrackingEntry.SETRANGE("Entry Type",AADTrackingEntry."Entry Type"::Outbound);
                AADTrackingEntry.SETRANGE("Source Type",AADTrackingEntry."Source Type"::Customer);
                AADTrackingEntry.SETRANGE("Source No.","Sell-to Customer No.");
                AADTrackingEntry."Entry No." := "Applies-to AAD Trck. Entry No.";
                if PAGE.RUNMODAL(0,AADTrackingEntry) = ACTION::LookupOK then
                  VALIDATE("Applies-to AAD Trck. Entry No.",AADTrackingEntry."Entry No.");
            end;

            trigger OnValidate();
            var
                AADTrackingEntry : Record "AAD Tracking Entry";
            begin
                // <<DITW15.00.00.39 DDR 04/08/2011 #1369
                if Type = Type::" " then
                  FIELDERROR(Type);
                if "Applies-to AAD Trck. Entry No." <> 0 then begin
                  TESTFIELD("LRN No.",'');
                  AADTrackingEntry.GET("Applies-to AAD Trck. Entry No.");
                  "AAD No. Series" := '';
                  "AAD No." := AADTrackingEntry."AAD No.";
                  "LRN No. Series" := '';
                  "ARC No." := AADTrackingEntry."ARC No.";
                  "ARC No. Mandatory" := false;
                end else begin
                  "AAD No." := '';
                  "ARC No." := '';
                  if Type = Type::Item then
                    UpdateAADInfo();
                end;
            end;
        }
        field(2013760;"Unit Volume Sales Price";Option)
        {
            CaptionML = ENU='Unit Volume Sales Price',
                        FRA='Volume Unitaire Prix de Vente';
            Description = 'DITW17.00.02 DIT-770 #147';
            Editable = false;
            OptionCaptionML = ENU='No,Yes',
                              FRA='Non,Oui';
            OptionMembers = No,Yes;
        }
        field(2013761;"Disable DIT Disc. Prom.";Option)
        {
            Caption = 'Disable DIT Discount Promotion';
            Description = 'DITW111.00.13A MSF 09/05/2019 NRQ#109271';
            OptionCaption = '" ,Discount,Promotion,All"';
            OptionMembers = " ",Discount,Promotion,All;
        }
        field(2013767;"Unit Volume HL";Decimal)
        {
            CaptionClass = GetUomCaptionClassHL(FIELDNO("Unit Volume HL"));
            CaptionML = ENU='Unit Volume',
                        FRA='Volume unitaire';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.01';
            MinValue = 0;

            trigger OnValidate();
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusModifyEmcs(FIELDCAPTION("Unit Volume HL"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW15.00.00.01 DDR 24/01/2008 - DITW15.00.00.19 DDR 22/04/2008
                UpdateCharges(FIELDNO("Unit Volume HL"),true);
                // >>DITW15.00.00.19 DDR
            end;
        }
        field(2013768;"Allow Price Dit Discount";Boolean)
        {
            CaptionML = ENU='Special Price (Dit Discount)',
                        FRA='Prix special (Remise DIT)';
            Description = 'DITW17.10.05 DIT-770 #695';

            trigger OnValidate();
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                TestStatusOpen;
                // >>DITW18.00.07 DDR DIT-770 #1488
            end;
        }
        field(2013773;"Customer DDisc. Group Code";Code[10])
        {
            CaptionML = ENU='Customer Discount Group',
                        FRA='Groupe remise client';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Customer));

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
            end;
        }
        field(2013774;"Item DDisc. Group Code";Code[10])
        {
            CaptionML = ENU='Item Discount Group',
                        FRA='Groupe remise article';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Discount Group".Code WHERE ("Source Type"=CONST(Item));

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
            end;
        }
        field(2013775;"Customer DPromo. Group Code";Code[10])
        {
            CaptionML = ENU='Customer Promotion Group',
                        FRA='Groupe promotion client';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Promotion Group".Code WHERE ("Source Type"=CONST(Customer));

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
            end;
        }
        field(2013776;"Item DPromo. Group Code";Code[10])
        {
            CaptionML = ENU='Item Promotion Group',
                        FRA='Groupe promotion article';
            Description = 'DITW15.00.00.01';
            TableRelation = "Drink Promotion Group".Code WHERE ("Source Type"=CONST(Item));

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
            end;
        }
        field(2013777;"Item Charge Calculate per";Option)
        {
            CaptionML = ENU='Item Charge Calculate per',
                        FRA='Frais annexe calcul par';
            Description = 'DITW15.00.00.01 - DITW19.00.08 BL#11069';
            OptionCaptionML = ENU='Item,Order,Period,Delayed Order,List Item,List Order',
                              FRA='Article,Order,Périodique,Commande retardée,Liste article,Liste Commande';
            OptionMembers = Item,"Order",Period,DelayOrder,ListItem,ListOrder;
        }
        field(2013778;"Opposite Qty. Sign";Boolean)
        {
            CaptionML = ENU='Opposite Qty. Sign',
                        FRA='Signe quantité opposé';
            Description = 'DITW15.00.00.01';
        }
        field(2013779;"Using Qty. (Base)";Boolean)
        {
            CaptionML = ENU='Using Qty. (Base)',
                        FRA='Utilisation quantité (Base)';
            Description = 'DITW15.00.00.01';
        }
        field(2013780;"Free Quantity";Decimal)
        {
            CaptionML = ENU='Free Quantity',
                        FRA='Quantité gratuite';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.01';
            MinValue = 0;
        }
        field(2013781;"Multiple Quantity";Decimal)
        {
            CaptionML = ENU='Multiple Quantity',
                        FRA='Quantité multiple';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.01';
            MinValue = 0;
        }
        field(2013782;"Maximum Free Quantity";Decimal)
        {
            CaptionML = ENU='Maximum Free Quantity',
                        FRA='Quantité maximum gratuite';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.01';
            MinValue = 0;
        }
        field(2013783;"DDiscount Level Position";Integer)
        {
            CaptionML = ENU='Discount Level Position',
                        FRA='Position niveau de remise';
            Description = 'DITW17.00.02 DIT-770 #230';
        }
        field(2013784;"DDiscount Base Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU='DDiscount Base Amount',
                        FRA='Montant base remise';
            Description = 'DITW17.00.02 DIT-770 #274';
        }
        field(2013785;"Periodic Disc.-Promo Entry No.";Integer)
        {
            CaptionML = ENU='Periodic Disc.-Promo Entry No.',
                        FRA='N° écriture Remise-Promotion périodique';
            Description = 'DITW15.00.00.01';
            TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        }
        field(2013788;"DDiscount Include Tax";Boolean)
        {
            CaptionML = ENU='DDiscount Include Tax',
                        FRA='Remise inculent taxe';
            Description = 'DITW17.00.02 DIT-770 #230';
        }
        field(2013789;"DDiscount Include Deposit";Boolean)
        {
            CaptionML = ENU='DDiscount Include Deposit',
                        FRA='Remise incluent caution';
            Description = 'DITW17.00.02 DIT-770 #230';
        }
        field(2013790;"DDiscount Include Discount";Boolean)
        {
            CaptionML = ENU='DDiscount Include Discount',
                        FRA='Remise incluent remise';
            Description = 'DITW17.00.02 DIT-770 #230';
        }
        field(2013797;"Disc.Promo. Order Calculated";Boolean)
        {
            CaptionML = ENU='Disc.Promo. Order Calculated',
                        FRA='Remise-Promotion cmde. calculé';
            Description = 'DITW15.00.00.37';
        }
        field(2013803;"Allow VAT Calculation (Free)";Boolean)
        {
            CaptionML = ENU='Allow VAT Calculation (Free)',
                        FRA='Autoriser calcul TVA (Gratuit)';
            Description = 'DITW16.00.00.40 DIT-715 #172';

            trigger OnValidate();
            var
                FreeReasonCode : Record "Free Reason Code";
            begin
                // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 - 20/01/2012 DIT-715 #172 - 25/01/2012 DIT-715 #172
                TestStatusOpen;
                // <<DITW16.00.00.43 DDR 05/11/2013 DIT-715 #811
                if xRec."Allow VAT Calculation (Free)" <> "Allow VAT Calculation (Free)" then begin
                // >>DITW16.00.00.43 DDR DIT-715 #812
                  TESTFIELD("Quantity Shipped",0);
                  TESTFIELD("Qty. Shipped (Base)",0);
                  TESTFIELD("Return Qty. Received",0);
                  TESTFIELD("Return Qty. Received (Base)",0);
                end;
                if "Allow VAT Calculation (Free)" and "Free Item" then begin
                  //<< NRQ151359 AKH 17/07/2020
                  if Type = Type::Item then begin
                    if (FreeReasonCode.GET("Free Reason Code")) and (FreeReasonCode."Free Item Posting Type" = FreeReasonCode."Free Item Posting Type"::" ") then
                      TESTFIELD("Free Item Posting Type");
                  end else
                  //>> NRQ151359 AKH 17/07/2020
                    TESTFIELD("Free Calculation Type");
                  // <<DITW111.00.13 DDR 11/12/2018 NRQ#35372
                  GetSalesHeader;
                  "VAT Base Amount" := ROUND(Quantity * "Item Charge Value",Currency."Amount Rounding Precision");
                  // >>DITW111.00.13 DDR NRQ#35372
                end else begin
                  Amount := 0;
                  "Amount Including VAT" := 0;
                  "VAT Base Amount" := 0;
                end;
                if (Type = Type::Item) and "Is Item Charge" then
                  UpdateCharges(FIELDNO("Allow VAT Calculation (Free)"),false);
                InitOutstandingAmount;
                UpdateAmounts();
            end;
        }
        field(2013810;"Periodic Delayed Entry No.";Integer)
        {
            CaptionML = ENU='Periodic Delayed Entry No.',
                        FRA='N° écriture périod. retardée';
            Description = 'DITW15.00.00.26';
            TableRelation = "Sales Discount.-Promo. Entry"."Entry No.";
        }
        field(2013811;"Delayed Sequence No.";Integer)
        {
            CaptionML = ENU='Delayed Sequence No.',
                        FRA='N° séquence retardé';
            Description = 'DITW15.00.00.26';
        }
        field(2013812;"Delayed Sequence No. Filter";Integer)
        {
            CaptionML = ENU='Delayed Sequence No.',
                        FRA='N° séquence retardé';
            Description = 'DITW17.00.01';
            FieldClass = FlowFilter;
        }
        field(2013824;"Gen. Prod. Posting Free Group";Code[10])
        {
            CaptionML = ENU='Gen. Prod. Posting Group Free Item',
                        FRA='Groupe article gratuit compta. produit';
            Description = 'DITW15.00.00.35';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009
                TestStatusOpen;
                // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
                case Type of
                  Type::Item:
                    begin
                      TESTFIELD("Free Item Posting Type");
                      if "Free Item" then
                        VALIDATE("Free Item");
                    end;
                end;
                // >>DITW16.00.00.40 DDR DIT-715 #172
            end;
        }
        field(2013825;"Free Item Posting Type";Option)
        {
            CaptionML = ENU='Calculate Price on Free',
                        FRA='Calculer Prix sur gratuit';
            Description = 'DITW15.00.00.35';
            OptionCaptionML = ENU=' ,Price 0,Discount 100%',
                              FRA=' ,Prix 0,Remise 100%';
            OptionMembers = " ",Price,Amount;

            trigger OnValidate();
            var
                lTempBatchInsertCheckSuspended : Boolean;
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009 - 14/10/2009
                TestStatusOpen;
                // <<DITW15.00.00.37 DDR 20/01/2010
                // <<DITW16.00.00.43 DDR 18/10/2013 DIT-715 #811
                if (xRec."Free Item" <> "Free Item") or
                  (xRec."Free Item Posting Type" <> "Free Item Posting Type")
                then begin
                // >>DITW16.00.00.43 DDR DIT-715 #811
                  TESTFIELD("Quantity Shipped",0);
                  TESTFIELD("Qty. Shipped (Base)",0);
                  TESTFIELD("Return Qty. Received",0);
                  TESTFIELD("Return Qty. Received (Base)",0);
                end;
                // >>DITW15.00.00.37 DDR
                //<< NRQ152558 AKH 04/08/2020
                if CurrFieldNo <> 0 then
                //>> NRQ152558 AKH 04/08/2020
                  TESTFIELD(Type,Type::Item);

                lTempBatchInsertCheckSuspended := BatchInsertCheckSuspended;
                BatchInsertCheckSuspended := true;

                case "Free Item Posting Type" of
                  "Free Item Posting Type"::" ":
                    begin
                      // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
                      if CurrFieldNo = FIELDNO("Free Item Posting Type") then begin
                        BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
                        // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
                        if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) then
                        // >>DITW114.00.15 DDR NRQ#151016
                          VALIDATE("Free Item",false);
                        UpdateUnitPrice(FIELDNO("Free Item Posting Type"));
                      end;
                      VALIDATE("Line Discount %",0);
                    end;
                  "Free Item Posting Type"::Price:
                    begin
                      // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
                      if "Free Item" then begin
                        if CurrFieldNo = FIELDNO("Free Item Posting Type") then begin
                          VALIDATE("Free Item");
                          // <<DITW19.00.08 DDR 11/08/2016 BL#9886
                          VALIDATE("Line Discount %",0);
                          VALIDATE("Unit Price",0);
                          // >>DITW19.00.08 DDR BL#9886
                          UpdateUnitPrice(FIELDNO("Free Item Posting Type"));
                        end;
                        VALIDATE("Line Discount %",0);
                        VALIDATE("Unit Price",0);
                      // <<DITW19.00.08 DDR 11/08/2016 BL#9886
                      end else
                        UpdateUnitPrice(FIELDNO("Free Item Posting Type"));
                      // >>DITW19.00.08 DDR BL#9886
                    end;
                  "Free Item Posting Type"::Amount:
                    begin
                      // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
                      if "Free Item" then begin
                        if CurrFieldNo = FIELDNO("Free Item Posting Type") then begin
                          VALIDATE("Free Item");
                          "Line Discount %" := 0;
                          "Unit Price" := "Item Charge Value";
                          UpdateUnitPrice(FIELDNO("Free Item Posting Type"));
                        end;
                        VALIDATE("Line Discount %",100);
                      // <<DITW19.00.08 DDR 11/08/2016 BL#9886
                      end else
                        VALIDATE("Line Discount %",0);
                      // >>DITW19.00.08 DDR BL#9886
                    end;
                end;

                BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
                if  xRec."Free Item Posting Type" <> "Free Item Posting Type" then
                  UpdateAmounts();
            end;
        }
        field(2013826;"Free Item";Boolean)
        {
            CaptionML = ENU='Free Item',
                        FRA='Article gratuit';
            Description = 'DITW15.00.00.35';

            trigger OnValidate();
            var
                lTempBatchInsertCheckSuspended : Boolean;
                lTempCurrfieldno : Integer;
                "_NRQ195518.1_LOCALS" : Integer;
                lrecFreeReasonCode : Record "Free Reason Code";
                lrecItem : Record Item;
            begin
                // <<DITW15.00.00.35 DDR 24/06/2009 - 21/08/2009 - 14/10/2009
                TestStatusOpen;
                // <<DITW15.00.00.37 DDR 20/01/2010
                // <<DITW16.00.00.43 DDR 18/10/2013 DIT-715 #811
                if (xRec."Free Item" <> "Free Item") or
                  (xRec."Free Item Posting Type" <> "Free Item Posting Type")
                then begin
                // >>DITW16.00.00.43 DDR DIT-715 #811
                  TESTFIELD("Quantity Shipped",0);
                  TESTFIELD("Qty. Shipped (Base)",0);
                  TESTFIELD("Return Qty. Received",0);
                  TESTFIELD("Return Qty. Received (Base)",0);
                end;
                // >>DITW15.00.00.37 DDR

                // <<DITW17.10.03 DDR 04/07/2014 DIT-770 #699 - DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                GetSalesSetup;
                // >>DITW17.10.03 DDR DIT-770 #699 - DITW18.00.07 DDR DIT-770 #1488
                //<< NRQ152558 AKH 04/08/2020
                if CurrFieldNo <> 0 then
                //>> NRQ152558 AKH 04/08/2020
                  TESTFIELD(Type,Type::Item);
                GetSalesHeader();

                /// DITW113.00.15 DDR 16/10/2019 18/10/2019 21/10/2019 NRQ#120300

                lTempBatchInsertCheckSuspended := BatchInsertCheckSuspended;
                BatchInsertCheckSuspended := true;

                if "Free Item" then begin
                  // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                  GetItem();
                  // >>DITW17.10.05 DDR DIT-770 #868
                  if ("Free Item Posting Type" = "Free Item Posting Type"::" ") and
                  //<< NRQ151359 AKH 17/07/2020
                    (CurrFieldNo <> FIELDNO("Free Item Posting Type"))
                    //>>
                  then begin
                  //>> NRQ151359 AKH 17/07/2020
                    if Item."Free Item Posting Type" <> Item."Free Item Posting Type"::" " then
                      "Free Item Posting Type" := Item."Free Item Posting Type"
                    else
                      "Free Item Posting Type" := SalesHeader."Free Item Posting Type";
                  end;
                  // <<DITW17.00.01 DDR 08/03/2013 DIT-770 #001
                  TESTFIELD("Free Item Posting Type");
                  SalesHeader.TESTFIELD("Gen. Bus. Posting Free Group");
                  TESTFIELD("Gen. Prod. Posting Free Group");

                  // >>DITW17.00.01 DDR DIT-770 #001
                  // <<DITW17.10.03 DDR 04/07/2014 DIT-770 #699
                  if (Item."Free Reason Code" <> "Free Reason Code") and ("Free Reason Code" = '') then
                    "Free Reason Code" := Item."Free Reason Code";
                  //<< NRQ151359 AKH 17/07/2020
                  if ("Free Reason Code" <> '') and
                    (CurrFieldNo <> FIELDNO("Free Item Posting Type"))
                  then begin
                    rFreeReasonCode.GET("Free Reason Code");
                    if rFreeReasonCode."Free Item Posting Type" <> rFreeReasonCode."Free Item Posting Type"::" " then
                      "Free Item Posting Type" := rFreeReasonCode."Free Item Posting Type"-1;
                  end;
                  //>> NRQ151359 AKH 17/07/2020
                  if (CurrFieldNo = FIELDNO("Free Item")) and SalesSetup."Enforce Free Reason on Free" then
                    TESTFIELD("Free Reason Code");
                  // >>DITW17.10.03 DDR DIT-770 #699
                  "Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Free Group";
                  // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
                  VALIDATE("Gen. Prod. Posting Group","Gen. Prod. Posting Free Group");
                  // >>DITW16.00.00.40 DDR DIT-715 #172
                  VALIDATE("VAT Prod. Posting Group");
                  // <<DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR 11/10/2019 16/10/2019 18/10/2019 NRQ#120300
                  if (CurrFieldNo = FIELDNO("Free Item")) then
                    LoyaltyCalcMgt.FindSalesLineLoyalty(SalesHeader,Rec,FIELDNO("Free Item"));
                  // >>DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR NRQ#120300
                  if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
                    // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                    (CurrFieldNo <> FIELDNO("Free Reason Code")) and
                    (CurrFieldNo <> FIELDNO("No."))
                    // >>DITW17.10.05 DDR DIT-770 #868
                  then begin
                    // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                    lTempCurrfieldno := CurrFieldNo;
                    VALIDATE("Free Reason Code");
                    // >>DITW17.10.05 DDR DIT-770 #868
                   // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
                    if (CurrFieldNo = FIELDNO("Free Item")) or
                      // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                      (CurrFieldNo = FIELDNO("Allow Loyalty")) or
                      // >>DITW17.10.05 DDR DIT-770 #868
                      //<<DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
                      (CurrFieldNo = 0)
                      //>>DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
                    then
                      BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
                    // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
                    if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
                      (xRec."Free Item Posting Type" = "Free Item Posting Type")
                    then
                    // >>DITW114.00.15 DDR NRQ#151016
                      VALIDATE("Free Item Posting Type");
                    // >>DITW18.00.07A DDR DIT-770 #2074
                    UpdateUnitPrice(FIELDNO("Free Item"));
                    // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                    CurrFieldNo := lTempCurrfieldno;
                    // >>DITW17.10.05 DDR DIT-770 #868
                    UpdateAmounts();
                    // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
                    BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
                    // >>DITW16.00.00.40 DDR DIT-715 #243
                    // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
                    if "Allow VAT Calculation (Free)" and (CurrFieldNo <> 0) and
                      (CurrFieldNo <> FIELDNO("Allow VAT Calculation (Free)"))
                    then
                      VALIDATE("Allow VAT Calculation (Free)");
                    // >>DITW16.00.00.40 DDR DIT-715 #172
                  // <<DITW111.00.13A DDR 12/06/2019 NRQ#112600
                  end else
                    if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) then
                      VALIDATE("Free Item Posting Type");
                  // >>DITW111.00.13A DDR NRQ#112600
                end else begin
                  // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
                  if (CurrFieldNo <> 0) and "Is Item Charge" and xRec."Free Item" and not HideValidationDialog then
                    ERROR(
                      STRSUBSTNO(Text2013762,
                        FIELDCAPTION("Free Item"),
                        FIELDCAPTION("Item Charge Type"),"Item Charge Type"));
                  SalesHeader.TESTFIELD("Gen. Bus. Posting Group");
                  "Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
                  GetItem;
                  Item.TESTFIELD(Blocked,false);
                  // << DITW110.00.11 SFI 31/08/2017 BL#30569
                  Item.BlockedSKU("Location Code","Variant Code",true);
                  // >> DITW110.00.11 SFI BL#30569
                  Item.TESTFIELD("Inventory Posting Group");
                  Item.TESTFIELD("Gen. Prod. Posting Group");
                  "Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
                  "VAT Prod. Posting Group" := Item."VAT Prod. Posting Group";
                  // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
                  "VAT Base Amount" := 0;
                  // >>DITW16.00.00.40 DDR DIT-715 #172
                  if (CurrFieldNo <> FIELDNO("No.")) and (CurrFieldNo <> FIELDNO("Free Reason Code")) then begin
                    // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                    //<<DITW17.10.05 MSF 06/08/2014 DIT-770 #864
                    "Free Reason Code" := '';
                    // <<DITW110.00.12 DDR 08/03/2018 NRQ#63284
                    //<<DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR 16/10/2019 18/10/2019 NRQ#120300
                    if (CurrFieldNo = FIELDNO("Free Item")) then
                      LoyaltyCalcMgt.FindSalesLineLoyalty(SalesHeader,Rec,FIELDNO("Free Item"));
                    //>>DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR NRQ#120300
                    "Customer DTax Group Code" := GetCustTaxGroupCode("Customer DTax Group Code","Item DTax Group Code");
                    // >>DITW110.00.12 DDR NRQ#63284
                    //>>DITW17.10.05 MSF 06/08/2014 DIT-770 #864
                    // >>DITW17.10.05 DDR DIT-770 #868
                    VALIDATE("VAT Prod. Posting Group");
                    BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
                    if (CurrFieldNo = FIELDNO("Free Item")) or
                      (CurrFieldNo = FIELDNO("Free Item Posting Type")) or
                      // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                      (CurrFieldNo = FIELDNO("Free Reason Code")) or
                      (CurrFieldNo = FIELDNO("Allow Loyalty")) or
                      // >>DITW17.10.05 DDR DIT-770 #868
                      // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
                      (CurrFieldNo = FIELDNO("Allow VAT Calculation (Free)"))
                      // >>DITW16.00.00.40 DDR DIT-715 #172
                    then begin
                      VALIDATE("Unit of Measure Code");
                      if Quantity <> 0 then begin
                        InitOutstanding;
                        if "Document Type" in ["Document Type"::"Return Order","Document Type"::"Credit Memo"] then
                          InitQtyToReceive
                        else
                          InitQtyToShip;
                        UpdateWithWarehouseShip;
                        //<< DITW18.00.07 AKH 10/05/2016 DIT-770 #1346
                        if "Document Type" = "Document Type"::Order then
                          CalcDeliveryTimeQtyBase();
                        //>> DITW18.00.07 AKH DIT-770 #1346
                      // <<DITW19.00.08 DDR 11/08/2016 BL#9886
                      // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
                      if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
                        (xRec."Free Item Posting Type" = "Free Item Posting Type")
                      then
                      // >>DITW114.00.15 DDR NRQ#151016
                        VALIDATE("Free Item Posting Type");
                      UpdateAmounts();
                      // >>DITW19.00.08 DDR BL#9886
                      end;
                      // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
                      BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
                      // >>DITW18.00.07A DDR DIT-770 #2074
                      // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
                      if (CurrFieldNo <> FIELDNO("Free Item Posting Type")) and
                        (xRec."Free Item Posting Type" = "Free Item Posting Type")
                      then
                      // >>DITW114.00.15 DDR NRQ#151016
                        // <<DITW19.00.08 DDR 11/08/2016 BL#9886
                        VALIDATE("Free Item Posting Type");
                        // >>DITW19.00.08 DDR BL#9886
                      UpdateUnitPrice(FIELDNO("Free Item"));
                    end;
                  end;
                end;
                BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
                //HEI.19<<
                if "Free Reason Code" = '' then
                  "Allow VAT Calculation (Free)" := false;
                //HEI.19>>
            end;
        }
        field(2013827;"Free Calculation Type";Option)
        {
            CaptionML = ENU='Calculate on Free',
                        FRA='Calculer sur gratuit';
            Description = 'DITW15.00.00.35';
            OptionCaptionML = ENU='None,Discount 100%,Full Amount',
                              FRA='Aucun,Remise 100%,Montant';
            OptionMembers = "None","Discount 100%",All;

            trigger OnValidate();
            var
                lTempBatchInsertCheckSuspended : Boolean;
            begin
                //<< NRQ152558 AKH 04/08/2020
                TestStatusOpen;
                if (xRec."Free Item" <> "Free Item") or
                  (xRec."Free Calculation Type" <> "Free Calculation Type")
                then begin
                  TESTFIELD("Quantity Shipped",0);
                  TESTFIELD("Qty. Shipped (Base)",0);
                  TESTFIELD("Return Qty. Received",0);
                  TESTFIELD("Return Qty. Received (Base)",0);
                end;

                if CurrFieldNo <> 0 then
                  TESTFIELD(Type,Type::"Charge (Item)");

                lTempBatchInsertCheckSuspended := BatchInsertCheckSuspended;
                BatchInsertCheckSuspended := true;

                case "Free Calculation Type" of
                  "Free Calculation Type"::All:
                    begin
                      if CurrFieldNo = FIELDNO("Free Calculation Type") then begin
                        BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
                        if (CurrFieldNo <> FIELDNO("Free Calculation Type")) then
                          VALIDATE("Free Item",false);
                        UpdateUnitPrice(FIELDNO("Free Calculation Type"));
                      end;
                      VALIDATE("Line Discount %",0);
                    end;
                  "Free Calculation Type"::None:
                    begin
                      if "Free Item" then begin
                        if CurrFieldNo = FIELDNO("Free Calculation Type") then begin
                          VALIDATE("Free Item");
                          VALIDATE("Line Discount %",0);
                          VALIDATE("Unit Price",0);
                          UpdateUnitPrice(FIELDNO("Free Calculation Type"));
                        end;
                        VALIDATE("Line Discount %",0);
                        VALIDATE("Unit Price",0);
                      end else
                        UpdateUnitPrice(FIELDNO("Free Calculation Type"));
                    end;
                  "Free Calculation Type"::"Discount 100%":
                    begin
                      if "Free Item" then begin
                        if CurrFieldNo = FIELDNO("Free Calculation Type") then begin
                          VALIDATE("Free Item");
                          "Line Discount %" := 0;
                          "Unit Price" := "Item Charge Value";
                          UpdateUnitPrice(FIELDNO("Free Calculation Type"));
                        end;
                        VALIDATE("Line Discount %",100);
                      end else
                        VALIDATE("Line Discount %",0);
                    end;
                end;

                BatchInsertCheckSuspended := lTempBatchInsertCheckSuspended;
                if  xRec."Free Calculation Type" <> "Free Calculation Type" then
                  UpdateAmounts();
                //>> NRQ152558 AKH 04/08/2020
            end;
        }
        field(2013828;"Include Free Qty. in Minimum";Boolean)
        {
            CaptionML = ENU='Include Free Quantity in Minimum',
                        FRA='Inclure quantité gratuite avec minimum';
            Description = 'DITW15.00.00.35'; 
        }
        field(2013829;"Free Reason Code";Code[10])
        {
            CaptionML = ENU='Free Reason Code',
                        FRA='Code motif gratuit';
            Description = 'DITW17.00.02 DIT-770 #132';
            TableRelation = "Free Reason Code";

            trigger OnValidate();
            var
                lTempBatchInsertCheckSuspended : Boolean;
                TempHideValidationDialog : Boolean;
            begin
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                TestStatusOpen;
                // >>DITW18.00.07 DDR DIT-770 #1488
                //<< DITW17.00.02 TEC1 12/09/2013 DIT-770 #132
                // <<DITW17.10.03 DDR 04/07/2014 DIT-770 #699
                if xRec."Free Reason Code" <> "Free Reason Code" then begin
                  // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
                  GetSalesSetup;
                  // >>DITW18.00.07 DDR DIT-770 #1488
                  // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
                  if CurrFieldNo <> FIELDNO("Free Item") then begin
                  // >>DITW18.00.07A DDR DIT-770 #2074
                    if SalesSetup."Enforce Free Reason on Free" then begin
                      if "Free Item" <> ("Free Reason Code" <> '') then  begin
                        "Free Item" := ("Free Reason Code" <> '');
                      end;
                    end else
                      // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                      "Free Item" := ("Free Reason Code" <> '');
                      // >>DITW17.10.05 DDR DIT-770 #868
                  end;

                  // <<DITW17.10.05 DDR 08/09/2014 DIT-770 #699
                  if SalesSetup."Enforce Free Reason on Free" and "Free Item" then
                    TESTFIELD("Free Reason Code");
                  // >>DITW17.10.05 DDR DIT-770 #699

                  // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                  //<<DITW17.10.05 MSF 06/08/2014 DIT-770 #864
                  //<<DITW17.10.05 MSF 15/07/2014 DIT-770 #692
                  if "Free Reason Code" <>'' then begin
                    // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                    rFreeReasonCode.GET("Free Reason Code");
                    // >>DITW17.10.05 DDR DIT-770 #868
                    //<< NRQ151359 AKH 17/07/2020
                    if rFreeReasonCode."Customer Disc. Group" <> '' then
                      "Customer Disc. Group" := rFreeReasonCode."Customer Disc. Group";
                    if rFreeReasonCode."Customer Price Group" <> '' then
                      "Customer Price Group" := rFreeReasonCode."Customer Price Group";
                    //>> NRQ151359 AKH 17/07/2020

                    //<<DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR 18/10/2019 NRQ#120300
                    if rFreeReasonCode.Type = rFreeReasonCode.Type::Loyalty then begin
                      /// DITW113.00.15 DDR 03/10/2019 NRQ#120296 - DITW113.00.15 DDR 11/10/2019 18/10/2019 NRQ#120300
                      LoyaltyCalcMgt.FindSalesLineLoyalty(SalesHeader,Rec,FIELDNO("Free Reason Code"));
                    end;
                    //>>DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR 18/10/2019 NRQ#120300

                    //<<DITW17.10.05 MSF 31/07/2014 DIT-770 #692
                    if rFreeReasonCode."Customer DTax Group Code" <> '' then
                      "Customer DTax Group Code" := rFreeReasonCode."Customer DTax Group Code"
                    else
                      // <<DITW110.00.12 DDR 08/03/2018 NRQ#63284
                      "Customer DTax Group Code" := GetCustTaxGroupCode("Customer DTax Group Code","Item DTax Group Code");
                      // >>DITW110.00.12 DDR NRQ#63284
                  //>>DITW17.10.05 MSF 31/07/2014 DIT-770 #692
                  end else begin
                  // >>DITW17.10.05 DDR DIT-770 #868
                    //<<DITW17.10.05 MSF 01/08/2014 DIT-770 #692 - DITW110.00.12 DDR 08/03/2018 NRQ#63284
                    "Customer DTax Group Code" := GetCustTaxGroupCode("Customer DTax Group Code","Item DTax Group Code");
                    //>>DITW17.10.05 MSF 01/08/2014 DIT-770 #692 - DITW110.00.12 DDR NRQ#63284
                    //<<DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR 11/10/2019 NRQ#120300
                    //<<DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR 18/10/2019 NRQ#120300
                    LoyaltyCalcMgt.FindSalesLineLoyalty(SalesHeader,Rec,FIELDNO("Free Reason Code"));
                    //>>DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR NRQ#120300
                    //<< NRQ151359 AKH 17/07/2020
                    "Customer Disc. Group" := SalesHeader."Customer Disc. Group";
                    "Customer Price Group" := SalesHeader."Customer Price Group";
                    //>> NRQ151359 AKH 17/07/2020
                  end;

                  // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                  if (CurrFieldNo <> FIELDNO("Free Item")) and
                    (CurrFieldNo <> FIELDNO("No."))
                  then begin
                    if CurrFieldNo = FIELDNO("Free Reason Code") then begin
                      VALIDATE("Free Item");
                      // <<DITW114.00.15 DDR 08/07/2020 NRQ#151016
                      if (CurrFieldNo <> FIELDNO("Free Item Posting Type"))
                         /// NRQ151359 AKH 17/07/2020
                      then
                      // >>DITW114.00.15 DDR NRQ#151016
                        //<< NRQ151359 AKH 17/07/2020
                        if rFreeReasonCode."Free Item Posting Type" <> rFreeReasonCode."Free Item Posting Type"::" " then
                          VALIDATE("Free Item Posting Type",rFreeReasonCode."Free Item Posting Type"-1)
                        else
                          VALIDATE("Free Item Posting Type");
                        //>> NRQ151359 AKH 17/07/2020
                        // <<DITW18.00.07A DDR 12/07/2016 DIT-770 #2074
                        //VALIDATE("Free Item Posting Type");
                        // >>DITW18.00.07A DDR DIT-770 #2074
                    end;
                   ///NRQ152558 AKH 04/08/2020 - NRQ153809 DDR 11/08/2020-NRQ#157706 MSF 25/09/2020


                    UpdateUnitPrice(FIELDNO("Free Reason Code"));

                    UpdateAmounts();
                    // >>DITW17.10.05 DDR DIT-770 #868
                  end;
                  //>>DITW17.10.05 MSF 06/08/2014 DIT-770 #864
                end;
                // >>DITW17.10.03 DDR DIT-770 #699
                //>> DITW17.00.02 TEC1 DIT-770 #132



                //<<HEI.19
                Rec_FreeReasonCode.RESET;
                if Rec_FreeReasonCode.GET("Free Reason Code") then begin
                  if Rec_FreeReasonCode."Gen. Bus. Posting Group" <> '' then //HEI.25
                    "Gen. Bus. Posting Group" := Rec_FreeReasonCode."Gen. Bus. Posting Group";
                     if Rec_FreeReasonCode."Allow VAT Calculation" = true then begin
                      //<< NRQ151359 AKH 17/07/2020
                      if ("Allow VAT Calculation (Free)" <> xRec."Allow VAT Calculation (Free)") then
                      //>> NRQ151359 AKH 17/07/2020
                        VALIDATE("Allow VAT Calculation (Free)");
                      "Allow VAT Calculation (Free)" := true
                     end else if Rec_FreeReasonCode."Allow VAT Calculation" = false then
                        "Allow VAT Calculation (Free)" := false
                  //END;//HEI.25
                end;
                if "Free Reason Code" = '' then
                  "Allow VAT Calculation (Free)" := false;

                //>>HEI.19
            end;
        }
        field(2014060;Route;Code[20])
        {
            CaptionML = ENU='Route',
                        FRA='Route';
            Description = 'DITW17.00.02 DIT-770 #159';
            Editable = false;
            TableRelation = Route;
        }
        field(2014061;Status;Option)
        {
            CaptionML = ENU='Status',
                        FRA='Statut';
            Description = 'DITW17.00.02 DIT-770 #159';
            Editable = false;
            OptionCaptionML = ENU='Open,Released,Pending Approval,Pending Prepayment',
                              FRA='Ouvert,Lancé,Approbation suspendue,Acompte suspendu';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(2014062;"Shipment Status";Option)
        {
            CaptionML = ENU='Shipment Status',
                        FRA='Statut expédition';
            Description = 'DITW17.00.02 DIT-770 #159';
            Editable = false;
            OptionCaptionML = ENU='Open,Picklist Printed,Assigned,Picked,Shipped,Return completed,Invoice',
                              FRA='Ouvert,Prélèvement imprimé,Affecté,Prélevé,Expédié,Retour terminée,Facturée';
            OptionMembers = Open,"Picklist Printed",Assigned,Picked,Shipped,"Return completed",Invoice;
        }
        field(2014063;"Truck Zone";Option)
        {
            CaptionML = ENU='Truck Zone',
                        FRA='Zone de camion';
            Description = 'DITW17.00.02 DIT-770 #159';
            Editable = false;
            OptionCaptionML = ENU=' ,Right,Left',
                              FRA=' ,Droite,Gauche';
            OptionMembers = " ",Right,Left;
        }
        field(2014064;"Shipping Charge Per";Option)
        {
            CaptionML = ENU='Shipping Charge Per',
                        FRA='Frais transport par';
            Description = 'DITW15.00.00.21';
            OptionCaptionML = ENU='Shipment,Weight,Volume',
                              FRA='Expédition,Poids,Volume';
            OptionMembers = Shipment,Weight,Volume;

            trigger OnValidate();
            begin
                // <<DITW15.00.00.24 DDR 14/08/2008
                TestStatusOpen;
                // >>DITW15.00.00.24 DDR
            end;
        }
        field(2014065;"Original Quantity";Decimal)
        {
            CaptionML = ENU='Original Quantity',
                        FRA='Quantité initiale';
            DecimalPlaces = 0:5;
            Description = 'DITW18.00.07 DIT-770 #1702';
            MaxValue = 100;
            MinValue = 0;
        }
        field(2014066;"Receipt Status";Option)
        {
            CaptionML = ENU='Receipt Status',
                        FRA='Satut Recéption';
            Description = 'DITW18.00.07 DIT-770 #1968';
            OptionCaptionML = ENU='Open,Order Printed,Order Sent,Order Confirmed,To Receive,Receipt Completed,Invoice',
                              FRA='Ouvert,Commande Imprimée,Commande Envoyée,Commande Confirmée,A réceptionner,Réception Complete,Facturée';
            OptionMembers = Open,"Order Printed","Order Sent","Order Confirmed","To Receive","Receipt Completed",Invoice;
        }
        field(2014067;"Backorder Type";Option)
        {
            Caption = 'Backorder Type';
            Description = 'DITW110.00.10 BL#15657';
            OptionCaption = '" ,Backorder,No Backorder"';
            OptionMembers = " ",Backorder,"No Backorder";

            trigger OnValidate();
            var
                ItemBackOrderNotification : Notification;
            begin
                // << DITW110.00.10 SFI 20/06/2017 BL#15657
                TESTFIELD(Type, Type::Item);

                if not ("Document Type" in ["Document Type"::Order, "Document Type"::"Blanket Order"]) then
                  "Backorder Type" := "Backorder Type"::" ";

                //<< DITW110.00.11 VSC 09/10/2017 NRQ#33755
                if CurrFieldNo <> FIELDNO("Backorder Type") then begin
                  if "Backorder Type" <> xRec."Backorder Type" then
                    if ("Backorder Type" = "Backorder Type"::Backorder) then
                      if (not HideValidationDialog) and GUIALLOWED then begin
                        ItemBackOrderNotification.MESSAGE := STRSUBSTNO(Text2014063, "No.");
                        ItemBackOrderNotification.SCOPE := NOTIFICATIONSCOPE::LocalScope;
                        ItemBackOrderNotification.SEND;
                      end;
                  InitQtyToShip(); // calls also "InitQtyToInvoice"

                  // << DITW110.00.10 SFI 04/08/2017 BL#34135
                  ///<< DITW110.00.11 VSC 09/10/2017 NRQ#33755 - DITW110.00.10 SFI 04/08/2017 BL#34135 MODIFY;
                  UpdateCharges2(FIELDNO("Qty. to Ship"),true);
                  UpdateCharges2(FIELDNO("Qty. to Invoice"),true);
                  // >> DITW110.00.10 SFI BL#34135
                end;
                //>> DITW110.00.11 VSC NRQ#33755
                // <<DITW110.00.13 ISL 05/12/2018 NRQ#91882
                if  ("Document Type" = "Document Type"::Order) then
                  SyncBackorderwhseshipment()
                else if ("Document Type" = "Document Type"::"Return Order") then
                  SyncBackorderwhsereceipt();
                // >>DITW110.00.13 ISL NRQ#91882
            end;
        }
        field(2014071;"Original Sales Order No.";Code[20])
        {
            Caption = 'Original Sales Order No.';
            Description = 'DITW110.00.10 BL#15657';
        }
        field(2014072;"Original Sales Order Line No.";Integer)
        {
            Caption = 'Original Sales Order Line No.';
            Description = 'DITW110.00.10 BL#15657';
        }
        field(2014079;Cubage;Decimal)
        {
            CaptionML = ENU='Outstanding Volume (Cubage)',
                        FRA='Volume (cubage)';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.24,DIT-770 #1488';
        }
        field(2014080;Weight;Decimal)
        {
            CaptionML = ENU='Outstanding Weight',
                        FRA='Poids';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.24,DIT-770 #1488';
        }
        field(2014081;"HL Cubage";Decimal)
        {
            CaptionClass = GetUomCaptionClassHL(FIELDNO("HL Cubage"));
            CaptionML = ENU='Outstanding Volume',
                        FRA='Volume (cubage)';
            DecimalPlaces = 0:5;
            Description = 'DITW17.00.02 DIT-770 #189';
        }
        field(2014082;"Eq. UOM Quantity";Decimal)
        {
            CaptionClass = GetUomCaptionClassEqUom(FIELDNO("Eq. UOM Quantity"));
            CaptionML = ENU='Outstanding Eq. UOM Quantity',
                        FRA='Quantité Restante UOM';
            DecimalPlaces = 0:5;
            Description = 'DITW17.00.02 DIT-770 #189';
        }
        field(2014083;"Cubage (Base)";Decimal)
        {
            CaptionML = ENU='Volume (Cubage)',
                        FRA='Volume (cubage)';
            DecimalPlaces = 0:5;
            Description = 'DIT-770 #1488';
        }
        field(2014084;"Weight (Base)";Decimal)
        {
            CaptionML = ENU='Weight',
                        FRA='Poids';
            DecimalPlaces = 0:5;
            Description = 'DIT-770 #1488';
        }
        field(2014085;"Item Delivery Type";Code[10])
        {
            CaptionML = ENU='Item Delivery Type',
                        FRA='Type de Livraison Article';
            Description = 'DITW18.00.07 DIT-770 #1346';
            TableRelation = "Delivery Type".Code WHERE (Type=CONST(Item));
        }
        field(2014086;"Delivery Time (sec.)";Decimal)
        {
            CaptionML = ENU='Delivery Time (sec.)',
                        FRA='Temps de Livraison (Sec.)';
            Description = 'DITW18.00.07 DIT-770 #1346';
            MinValue = 0;
        }
        field(2014087;Distance;Decimal)
        {
            CaptionML = ENU='Distance',
                        FRA='Distance';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.24';
            MinValue = 0;
        }
        field(2014088;"Eq. UOM Quantity (Base)";Decimal)
        {
            CaptionClass = GetUomCaptionClassEqUom(FIELDNO("Eq. UOM Quantity"));
            Caption = 'Eq. UOM Quantity';
            DecimalPlaces = 0:5;
            Description = 'DITW110.00.10 NRQ#16068';
        }
        field(2014089;"HL Cubage (Base)";Decimal)
        {
            CaptionClass = GetUomCaptionClassHL(FIELDNO("HL Cubage"));
            Caption = 'Volume';
            DecimalPlaces = 0:5;
            Description = 'DITW110.00.10 NRQ#16068';
        }
        field(2014094;"Physical Location Group Code";Code[10])
        {
            CaptionML = ENU='Physical Location Group Code',
                        FRA='Code groupe magasin réel';
            Description = 'DITW15.00.00.35';
            TableRelation = "Physical Location Group" WHERE (Code=FIELD("Phys. Location Table Filter"));

            trigger OnValidate();
            begin
                // <<DITW15.00.00.35 DDR 06/10/2009
                TestStatusOpen();
                InvtSetup.GET;

                if xRec."Physical Location Group Code" <> "Physical Location Group Code" then begin
                  TESTFIELD("Reserved Quantity",0);
                  TESTFIELD("Qty. Shipped Not Invoiced",0);
                  TESTFIELD("Shipment No.",'');
                  TESTFIELD("Return Qty. Rcd. Not Invd.",0);
                  TESTFIELD("Return Receipt No.",'');
                  // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                  TestStatusModifyEmcs(FIELDCAPTION("Physical Location Group Code"));
                  // >>DITW16.00.00.43 DDR DIT-715 #720
                end;

                // <<DITW18.00.06 DDR 26/02/2015 DIT-770 #1190
                if ("Responsibility Center" = xRec."Responsibility Center") and
                  ("Physical Location Group Code" <> xRec."Physical Location Group Code") and
                  ("Physical Location Group Code" <> '')
                then
                  // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
                  "Responsibility Center" := UserSetupMgt.GetFirstRespCenter(0,"Physical Location Group Code",'');
                  // >>DITW18.00.06 DDR DIT-770 #1592
                // >>DITW18.00.06 DDR DIT-770 #1190

                // <<DITW18.00.06 DDR 19/02/2015 DIT-770 #1190
                if xRec."Physical Location Group Code" <> "Physical Location Group Code" then
                  if not UserSetupMgt.CheckPhysLocation(0,"Physical Location Group Code","Responsibility Center") then
                    //<< DITW19.00.08 AKH 27/10/2016 BL#11231
                    ERROR(
                      Text2014414,
                      PhysLocationGr.TABLECAPTION,"Physical Location Group Code");
                    //>> DITW19.00.08 AKH BL#11231
                // >>DITW18.00.06 DDR DIT-770 #1190

                // <<DITW18.00.06 DDR 23/02/2015 27/02/2015 DIT-770 #1190
                if ((xRec."Physical Location Group Code" <> "Physical Location Group Code") or (CurrFieldNo = 0)) and
                  ("Location Code" <> '')
                then begin
                  GetLocation("Location Code");
                  if (Location."Physical Location Group Code" <> "Physical Location Group Code") then begin
                    if ((CurrFieldNo <> FIELDNO("Location Code")) and (xRec."Responsibility Center" = "Responsibility Center")) or
                      (CurrFieldNo = FIELDNO("Physical Location Group Code"))
                    then
                      VALIDATE("Location Code",'')
                    else
                      "Location Code" := '';
                  end;
                end;
                // >>DITW18.00.06 DDR DIT-770 #1190

                // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
                if ("Responsibility Center" <> xRec."Responsibility Center") and (CurrFieldNo <> FIELDNO("Responsibility Center")) then
                  VALIDATE("Responsibility Center");
                // >>DITW18.00.06 DDR DIT-770 #1592

                // <<DITW18.00.06 DDR 27/02/2015 DIT-770 #1190
                // <<DITW18.00.06 DDR 05/11/2015 DIT-770 #1592
                if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                  UpdateCharges2(FIELDNO("Physical Location Group Code"),(CurrFieldNo = FIELDNO("Physical Location Group Code")));
                // >>DITW18.00.06 DDR DIT-770 #1592
                // >>DITW18.00.06 DDR DIT-770 #1190
            end;
        }
        field(2014096;"Picking Type";Option)
        {
            CaptionML = ENU='Picking Type',
                        FRA='Type de prélèvement';
            Description = 'DITW17.00.02 DIT-770 #154';
            OptionCaptionML = ENU=' ,Order,Combined',
                              FRA=' ,Commande,Combinée';
            OptionMembers = " ","Order",Combined;
        }
        field(2014097;"Picklist Printed (date/time)";DateTime)
        {
            CaptionML = ENU='Picklist Printed (date/time)',
                        FRA='prélèvements entrepôt imprimé (date/heure)';
            Description = 'DITW17.00.02 DIT-770 #154';
        }
        field(2014103;"Whse. Shipment No. (Open)";Code[20])
        {
            CalcFormula = Lookup("Warehouse Shipment Line"."No." WHERE ("Source Type"=CONST(37),
                                                                        "Source Subtype"=FIELD("Document Type"),
                                                                        "Source No."=FIELD("Document No."),
                                                                        "Source Line No."=FIELD("Line No.")));
            CaptionML = ENU='Whse. Shipment No. (Open)',
                        FRA='N° expédition magasin (Ouvert)';
            Description = 'DITW15.00.00.39 #1399';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Warehouse Shipment Header";
        }
        field(2014109;"Route Planning No.";Code[20])
        {
            CalcFormula = Lookup("Sales Header"."Route Planning No." WHERE ("Document Type"=FIELD("Document Type"),
                                                                            "No."=FIELD("Document No.")));
            Caption = 'Route Planning No.';
            Description = 'DITW18.00.07 #1488 - NRQ#16224';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Route Planning Worksheet";
        }
        field(2014113;"Tax Item No.";Code[20])
        {
            CaptionML = ENU='Tax Tracking Item No.',
                        FRA='N° article traçable Taxe';
            Description = 'DITW15.00.00.38 #703';
            TableRelation = Item;

            trigger OnValidate();
            var
                lrFromItemSalesLine : Record "Sales Line";
                TempSalesLine : Record "Sales Line" temporary;
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusOpen;
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW15.00.00.38 DDR 17/12/2010 #703
                CLEAR(Item);
                CLEAR(TempSalesLine);
                if "Tax Item No." <> '' then begin
                  Item.GET("Tax Item No.");
                  GetSalesHeader();
                  TempSalesLine.SetSalesHeader(SalesHeader);
                  TempSalesLine.SetHideValidationDialog(true);
                  TempSalesLine.SetHasBeenShown();
                  TempSalesLine.SetBatchInsertCheck(true);
                  TempSalesLine."Document Type" := "Document Type";
                  TempSalesLine."Document No." := "Document No.";
                  TempSalesLine.VALIDATE(Type,Type::Item);
                  TempSalesLine.VALIDATE("No.","Tax Item No.");
                  // <<DITW16.00.00.43 DDR 18/12/2013 DIT-715 #766
                  TempSalesLine."Physical Location Group Code" := '';
                  // >>DITW16.00.00.43 DDR DIT-715 #766
                  TempSalesLine.VALIDATE("Location Code","Location Code");
                  TempSalesLine.VALIDATE(Quantity,Quantity);
                  // <<DITW16.00.00.43 DDR 01/10/2013 DIT-715 #519
                  TempSalesLine.VALIDATE("Unit of Measure Code","Unit of Measure Code");
                  // >>DITW16.00.00.43 DDR DIT-715 #519
                  TempSalesLine.UpdateAADInfo();
                  TempSalesLine.CalcCubageWeight();
                  //<<DITW17.00.02 SR 08/01/2014 DIT-770 #189
                  TempSalesLine.CalcHLCubage;
                  TempSalesLine.CalcEqVUOMQuantity;
                  //>>DITW17.00.02 SR 08/01/2014 DIT-770 #189
                end;
                "Gross Weight" := TempSalesLine."Gross Weight";
                "Net Weight" := TempSalesLine."Net Weight";
                "Unit Volume" := TempSalesLine."Unit Volume";
                "Units per Parcel" := TempSalesLine."Units per Parcel";
                "Unit Volume HL" := TempSalesLine."Unit Volume HL";
                Cubage := TempSalesLine.Cubage;
                Weight := TempSalesLine.Weight;
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                "Cubage (Base)" := TempSalesLine."Cubage (Base)";
                "Weight (Base)" := TempSalesLine."Weight (Base)";
                // >>DITW18.00.07 DDR DIT-770 #1488
                Distance := TempSalesLine.Distance;
                // <<DITW16.00.00.43 DDR 25/09/2013 DIT-715 #519
                "Item Category Code" := TempSalesLine."Item Category Code";
                "Product Group Code" := TempSalesLine."Product Group Code";
                "Unit Volume HL" := TempSalesLine."Unit Volume HL";
                // >>DITW16.00.00.43 DDR DIT-715 #519
                // <<DITW16.00.00.43 DDR 22/01/2014 DIT-715 #882
                "Item Charge Qty. per Uom" := TempSalesLine."Item Charge Qty. per Uom";
                // >>DITW16.00.00.43 DDR DIT-715 #882
                // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
                "HL Cubage" := TempSalesLine."HL Cubage";
                // >>DITW18.00.06 DDR DIT-770 #1449
                // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                "Eq. UOM Quantity" := TempSalesLine."Eq. UOM Quantity";
                // >>DITW18.00.07 DDR DIT-770 #1488
                // <<DITW110.00.10 YHE 03/07/2017 NRQ#16068
                "Eq. UOM Quantity (Base)" := TempSalesLine."Eq. UOM Quantity (Base)";
                "HL Cubage (Base)" := TempSalesLine."HL Cubage (Base)";
                // >>DITW110.00.10 YHE 03/07/2017 NRQ#16068

                if ("Line No." <> 0) and (CurrFieldNo <> 0) and ("Attached to Line No." <> 0) then begin
                  lrFromItemSalesLine.GET("Document Type","Document No.","Attached to Line No.");
                  "Gross Weight" := "Gross Weight" * lrFromItemSalesLine."Qty. per Unit of Measure";
                  "Net Weight" := "Net Weight" * lrFromItemSalesLine."Qty. per Unit of Measure";
                  "Unit Volume" := "Unit Volume" * lrFromItemSalesLine."Qty. per Unit of Measure";
                  "Units per Parcel" := ROUND("Units per Parcel" / lrFromItemSalesLine."Qty. per Unit of Measure",0.00001);
                  "Unit Volume HL" := "Unit Volume HL" * lrFromItemSalesLine."Qty. per Unit of Measure";
                  Cubage := Cubage * lrFromItemSalesLine."Qty. per Unit of Measure";
                  Weight := Weight * lrFromItemSalesLine."Qty. per Unit of Measure";
                  // <<DITW18.00.07 DDR 29/02/2016 DIT-770 #1488
                  "Cubage (Base)" := "Cubage (Base)" * lrFromItemSalesLine."Qty. per Unit of Measure";
                  "Weight (Base)" := "Weight (Base)" * lrFromItemSalesLine."Qty. per Unit of Measure";
                  // >>DITW18.00.07 DDR DIT-770 #1488
                  // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
                  "HL Cubage" := "HL Cubage" * lrFromItemSalesLine."Qty. per Unit of Measure";
                  // >>DITW18.00.06 DDR DIT-770 #1449
                  // <<DITW110.00.10 YHE 03/07/2017 NRQ#16068
                  "HL Cubage (Base)" := "HL Cubage (Base)" * lrFromItemSalesLine."Qty. per Unit of Measure";
                  // >>DITW110.00.10 YHE 03/07/2017 NRQ#16068

                end;

                "Tariff No." := TempSalesLine."Tariff No.";
                // <<DITW16.00.00.43 DDR 23/10/2013 DIT-715 #768
                if "Item Charge Type" = "Item Charge Type"::Tax then begin
                // >>DITW16.00.00.43 DDR DIT-715 #768
                "Item DTax Group Code" := TempSalesLine."Item DTax Group Code";
                "AAD No. Series" := TempSalesLine."AAD No. Series";
                "Company Tax Registration No." := TempSalesLine."Company Tax Registration No.";
                "LRN No. Series" := TempSalesLine."LRN No. Series";
                "Product Tax Code" := TempSalesLine."Product Tax Code";
                "ARC No. Mandatory" := TempSalesLine."ARC No. Mandatory";
                "Company Tax Warehouse Ref." := TempSalesLine."Company Tax Warehouse Ref.";
                "Packaging Type Code" := TempSalesLine."Packaging Type Code";
                // >>DITW15.00.00.38 DDR #703
                // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148)
                "Pack Qty. per Unit of Measure" := TempSalesLine."Pack Qty. per Unit of Measure";
                // >>DITW15.00.00.38 DDR #1217 (DIT711 148)
                // <<DITW16.00.00.43 DDR 12/08/2013 DIT-715 #720
                "No. of Packages" := TempSalesLine."No. of Packages";
                // >>DITW16.00.00.43 DDR DIT-715 #720
                end;

                // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
                CreateDim(
                  DimMgt.TypeToTableID3(Type::Item),"Tax Item No.",
                  DimMgt.TypeToTableID3(Type),"No.",
                  DATABASE::Job,"Job No.",
                  DATABASE::"Responsibility Center","Responsibility Center",
                  //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                  DimMgt.TypeToTableID2034932(1,"Contract Type"),GetContractNo());
                  //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                // >>DITW16.00.00.43 DDR DIT-715 #768
            end;
        }
        field(2014260;"LRN No. Series";Code[10])
        {
            CaptionML = ENU='LRN No. Series',
                        FRA='Souches de n° LRN';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "No. Series";

            trigger OnLookup();
            var
                lrSalesLine : Record "Sales Line";
                lDefaultAADCode : Code[10];
            begin
                // <<DITW15.00.00.38 DDR 10/08/2010 #1217
                // <<DITW15.00.00.38 DDR 17/12/2010 #703
                if Type = Type::"Charge (Item)" then
                  TESTFIELD("Tax Item No.")
                else
                  TESTFIELD(Type,Type::Item);
                // >>DITW15.00.00.38 DDR #703
                TestLRNNoSeriesMandatory();

                with lrSalesLine do begin
                  lrSalesLine := Rec;
                  EmcsSetup.GET;
                  lDefaultAADCode := EmcsSetup."LRN Nos.";
                  if NoSeriesMgt.LookupSeries(lDefaultAADCode,"LRN No. Series") then
                    VALIDATE("LRN No. Series");
                  Rec := lrSalesLine;
                end;
            end;

            trigger OnValidate();
            var
                lDefaultAADCode : Code[10];
            begin
                // <<DITW15.00.00.38 DDR 10/08/2010 #1217
                TestStatusOpen;
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TESTFIELD("ARC No. Mandatory");
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW15.00.00.38 DDR 17/12/2010 #703
                if Type = Type::"Charge (Item)" then
                  TESTFIELD("Tax Item No.")
                else
                  TESTFIELD(Type,Type::Item);
                // >>DITW15.00.00.38 DDR #703
                if "LRN No. Series" <> '' then begin
                  EmcsSetup.GET;
                  lDefaultAADCode := EmcsSetup."LRN Nos.";
                  if lDefaultAADCode <> '' then
                    NoSeriesMgt.TestSeries(lDefaultAADCode,"LRN No. Series");
                  TestLRNNoSeriesMandatory();
                end;
                TESTFIELD("LRN No.",'');
            end;
        }
        field(2014261;"LRN No.";Code[20])
        {
            CaptionML = ENU='LRN No.',
                        FRA='N° LRN';
            Description = 'DITW15.00.00.38 #1217';

            trigger OnLookup();
            begin
                // <<DITW110.00.09 DDR 22/03/2017 NRQ#9661
                ShowSalesShptLines(FIELDNO("LRN No."));
                // >>DITW110.00.09 DDR NRQ#9661
            end;

            trigger OnValidate();
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TESTFIELD("ARC No. Mandatory",true);
                TESTFIELD("ARC No.",'');
                // >>DITW16.00.00.43 DDR DIT-715 #720

                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                if "Document Type" <> "Document Type"::Order then
                // >>DITW16.00.00.43 DDR DIT-715 #720
                  // <<DITW15.00.00.38 DDR 10/08/2010 #1217
                  if "Outstanding Quantity" = 0 then
                    FIELDERROR("Outstanding Quantity");

                // <<DITW15.00.00.38 DDR 17/12/2010 #703
                if Type = Type::"Charge (Item)" then
                  TESTFIELD("Tax Item No.")
                else
                  TESTFIELD(Type,Type::Item);
                // >>DITW15.00.00.38 DDR #703

                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720 - DITW110.00.09 DDR 22/03/2017 NRQ#9661
                if (CurrFieldNo = FIELDNO("LRN No.")) and ("LRN No." <> xRec."LRN No.") and ("LRN No." <> '') then begin
                // >>DITW16.00.00.43 DDR DIT-715 #720 - DITW110.00.09 DDR NRQ#9661
                  NoSeriesMgt.TestManual("LRN No. Series");
                  "LRN No. Series" := '';
                end;
                // <<DITW15.00.00.39 DDR 11/07/2011 #1369
                TESTFIELD("Applies-to AAD Trck. Entry No.",0);
                // >>DITW15.00.00.39 DDR #1369
            end;
        }
        field(2014262;"ARC No.";Code[30])
        {
            CaptionML = ENU='ARC No.',
                        FRA='N° ARC';
            Description = 'DITW15.00.00.38 #1217';

            trigger OnLookup();
            var
                NewText : Text[1024];
            begin
                // <<DITW15.00.00.38 DDR 30/09/2010 #1217
                NewText := "ARC No.";
                if EDILookupExtTrackingARC(NewText) then
                  VALIDATE("ARC No.",NewText);
                // >>DITW15.00.00.38 DDR
            end;

            trigger OnValidate();
            begin
                // <<DITW15.00.00.38 DDR 20/08/2010 #1217
                if "ARC No." <> '' then
                  TESTFIELD("ARC No. Mandatory")
                else
                  if "ARC No. Mandatory" then begin
                    SalesLine2.RESET;
                    SalesLine2 := Rec;
                    SalesLine2.SETRECFILTER;
                    // <<DITW15.00.00.39 DDR 15/04/2011 #1296
                    if GUIALLOWED and not HideValidationDialog and (CurrFieldNo <> 0) then
                    // >>DITW15.00.00.39 DDR #1296
                      MESSAGE(Text2014260,FIELDCAPTION("ARC No."),TABLECAPTION,SalesLine2.GETFILTERS);
                  end;
                // <<DITW15.00.00.38 DDR 30/09/2010 #1217
                if xRec."ARC No." <> "ARC No." then begin
                  EDIUpdateInboxDocNo(xRec."ARC No.","ARC No.");
                  if not TestOpenEDIInboxDocNo(xRec."ARC No.") then
                    TESTFIELD("ARC No.",xRec."ARC No.");
                end;
                // >>DITW15.00.00.38 DDR
                // <<DITW15.00.00.39 DDR 1  1/07/2011 #1369
                if CurrFieldNo = FIELDNO("ARC No.") then
                  TESTFIELD("Applies-to AAD Trck. Entry No.",0);
                // >>DITW15.00.00.39 DDR #1369
            end;
        }
        field(2014263;"SAD No.";Code[30])
        {
            CaptionML = ENU='SAD No.',
                        FRA='N° SAD';
            Description = 'DITW15.00.00.38 #1217';
        }
        field(2014265;"Product Tax Code";Code[10])
        {
            CaptionML = ENU='Tax Product Code',
                        FRA='Code Produit taxe';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Tax Product";

            trigger OnValidate();
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusOpen;
                TestStatusModifyEmcs(FIELDCAPTION("Product Tax Code"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2014267;"ARC No. Mandatory";Boolean)
        {
            CaptionML = ENU='ARC No. Mandatory (EMCS)',
                        FRA='N° ARC obligatoire (EMCS)';
            Description = 'DITW15.00.00.38 #1217';

            trigger OnValidate();
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusOpen;
                TestStatusModifyEmcs(FIELDCAPTION("ARC No. Mandatory"));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2014271;"Company Tax Warehouse Ref.";Text[20])
        {
            CaptionML = ENU='Company Tax Warehouse Reference',
                        FRA='Entrepôt fiscal de référence société';
            Description = 'DITW15.00.00.38 #1217';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.38 DDR 13/09/2010 #1217
                TestStatusOpen;
                TestTaxWhseRefMandatory();
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusModifyEmcs(FIELDCAPTION("Company Tax Warehouse Ref."));
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2014287;"Cancellation Reason Type";Option)
        {
            CaptionML = ENU='Cancellation Reason Type',
                        FRA='Type motif d''annulation';
            Description = 'DITW16.00.00.43 DIT-715 #720';
            OptionCaptionML = ENU=' ,Typing Error,Commercial Transaction Interrupt,Duplicate eAAD,State conflict',
                              FRA=' ,Erreur de frappe,Interruption transaction commerciale,Double eAAD,Conflit administration';
            OptionMembers = " ",TypingError,TransactInterrupt,DuplicAAD,StateConflict;

            trigger OnValidate();
            var
                EMCS810OutMgt : Codeunit "EMCS EDI-IE810 Outbox";
                SalesShptLineCancel : Record "Sales Shipment Line";
                SalesLineCancel : Record "Sales Line";
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TESTFIELD("Document Type","Document Type"::Order);
                // >>DITW16.00.00.43 DDR DIT-715 #720
                TESTFIELD("ARC No. Mandatory",true);
                TESTFIELD("ARC No.");

                if xRec."Cancellation Reason Type" <> "Cancellation Reason Type" then begin
                  EMCS810OutMgt.TestDocumentOutbox(
                    DATABASE::"Sales Line","Document No.","ARC No.",true);

                  // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                  SalesShptLineCancel.SETCURRENTKEY("Order No.","Order Line No.");
                  SalesLineCancel.SETRANGE("Document Type","Document Type");
                  SalesLineCancel.SETRANGE("Document No.","Document No.");
                  SalesLineCancel.SETFILTER("Line No.",'<>%1',"Line No.");
                  SalesLineCancel.SETRANGE("ARC No.","ARC No.");
                  SalesLineCancel.MODIFYALL("Cancellation Reason Type","Cancellation Reason Type");
                  SalesShptLineCancel.SETRANGE("Order No.",SalesLineCancel."Document No.");
                  //SalesShptLineCancel.SETFILTER("order Line No.",SalesLineCancel."Line No.");
                  SalesShptLineCancel.SETRANGE("ARC No.",SalesLineCancel."ARC No.");
                  // <<DITW18.00.06 DDR 15/04/2015 DIT-770 #1329
                  if not SalesShptLineCancel.ISEMPTY then
                  // >>DITW18.00.06 DDR DIT-770 #1329
                    SalesShptLineCancel.MODIFYALL("Cancellation Reason Type","Cancellation Reason Type");
                  // >>DITW16.00.00.43 DDR DIT-715 #720
                end;
            end;
        }
        field(2014292;"Cancellation Reason Comment";Boolean)
        {
            CalcFormula = Exist("EMCS Comment Line" WHERE ("Table ID"=CONST(37),
                                                           "Document Type"=CONST(1),
                                                           "Document No."=FIELD("Document No."),
                                                           "Document Line No."=FIELD("Line No."),
                                                           "Field ID"=CONST(2014287)));
            CaptionML = ENU='Cancellation Reason Comment',
                        FRA='Commentaire motif d''annulation';
            Description = 'DITW16.00.00.43 DIT-715 #720';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014310;"Service Contract Line No.";Integer)
        {
            CaptionML = ENU='Contract Line No.',
                        FRA='N° ligne contrat';
            Description = 'DITW16.00.00.41 DIT-715 #392';
        }
        field(2014312;"DIT Sub-Contr.Pst. Type Filter";Option)
        {
            CaptionML = ENU='Financial Contract Posting Type Filter',
                        FRA='Filtre Type Imputation contrat DIT';
            Description = 'DITW16.00.00.41 DIT-715 #327';
            FieldClass = FlowFilter;
            OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance,,,,,All',
                              FRA=' ,Location,Prêt,Mise à disposition,Maintenance,Divers,Maintenance Usine,,,,,Tous';
            OptionMembers = " ",Rent,Loan,"Loan in use",Maintenance,Other,PlantMaintenance,,,,,All;
        }
        field(2014313;"Financial Contract No.";Code[20])
        {
            CaptionML = ENU='Financial Contract No.',
                        FRA='N° contrat financier';
            Description = 'DITW18.00.06 DIT-770 #1368';
            TableRelation = IF ("DIT Sub-Contract Type"=CONST(" ")) "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract))
                            ELSE IF ("DIT Sub-Contract Type"=FILTER(<>" ")) "Financial Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
                                                                                                                              "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

            trigger OnValidate();
            var
                FA2 : Record "Fixed Asset";
            begin
                // <<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                TestStatusOpen;
                if "Financial Contract No." <> '' then begin
                  //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                  "Contract Type" := "Contract Type"::Financial;
                  TESTFIELD("Service Contract No.",'');
                  //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                  GetSalesHeader;
                  if (CurrFieldNo = FIELDNO("Financial Contract No.")) and
                    (xRec."Financial Contract No." <> "Financial Contract No.")
                  then begin
                    "Service Contract Line No." := 0;
                    "Contract Group Code" := '';
                  end;

                  if Type = Type::"Fixed Asset" then begin
                    TESTFIELD("No.");
                    FA2.GET("No.");
                  end;
                  if FA2."Financial Contract No." <> '' then
                    TESTFIELD("Financial Contract No.",FA2."Financial Contract No.");

                  ContractDIT.GET(ContractDIT."Contract Type"::Contract,"Financial Contract No.");
                  if SalesHeader."Building No." <> '' then
                    ContractDIT.TESTFIELD("Building No.",SalesHeader."Building No.");
                  if ("DIT Sub-Contract Type" <> 0) or
                    ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
                    (xRec."Financial Contract No." = "Financial Contract No."))
                  then
                    TESTFIELD("DIT Sub-Contract Type",ContractDIT."DIT Sub-Contract Type")
                  else
                    "DIT Sub-Contract Type" := ContractDIT."DIT Sub-Contract Type";
                  if ("Contract Group Code" <> '') or
                    ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
                    (xRec."Financial Contract No." = "Financial Contract No."))
                  then
                    TESTFIELD("Contract Group Code",ContractDIT."Contract Group Code")
                  else
                    "Contract Group Code" := ContractDIT."Contract Group Code";
                end else begin
                  //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                  CLEAR("Contract Type");
                  //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                  CLEAR("Service Contract Line No.");
                  CLEAR("Contract Group Code");
                end;

                CreateDim(
                  DimMgt.TypeToTableID2034932(1,"Contract Type"),"Financial Contract No.",
                  DimMgt.TypeToTableID3(Type),"No.",
                  DATABASE::Job,"Job No.",
                  DATABASE::"Responsibility Center","Responsibility Center",
                  // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
                  DimMgt.TypeToTableID3(Type::Item),"Tax Item No.");
                  // >>DITW16.00.00.43 DDR DIT-715 #768

                SetFilterSubContractPostType();
            end;
        }
        field(2014362;"Ret. Receipt Date Calculation";DateFormula)
        {
            CaptionML = ENU='Return Receipt Date Calculation',
                        FRA='Calcul Date de retour réception';
            Description = 'DIT-715 #247';

            trigger OnValidate();
            begin
                if FORMAT("Ret. Receipt Date Calculation") <> '' then begin
                  if CurrFieldNo = FIELDNO("Ret. Receipt Date Calculation") then begin
                    if Quantity >= 0 then
                      FIELDERROR(Quantity);
                    TESTFIELD("Planned Delivery Date");
                  end;
                  if "Planned Delivery Date" <> 0D then
                    VALIDATE("Planned Delivery Date");
                end;
            end;
        }
        field(2014367;"Event Doc. No.";Code[20])
        {
            CaptionML = ENU='Event Doc. No.',
                        FRA='N° document Evénement';
            Description = 'DITW17.10.05 DIT-770 #779';
            Editable = false;
            TableRelation = "Event Header"."No." WHERE ("Document Type"=FILTER(Event));
        }
        field(2014368;"Event Doc. Line No.";Integer)
        {
            CaptionML = ENU='Event Doc. Line No.',
                        FRA='N° Line Evénement';
            Description = 'DITW17.10.05 DIT-770 #779';
            Editable = false;
            TableRelation = "Event Line"."Line No." WHERE ("Document Type"=FILTER(Event),
                                                           "Document No."=FIELD("Event Doc. No."));
        }
        field(2014410;Collapse;Boolean)
        {
            CaptionML = ENU='Collapse',
                        FRA='Réduire';
            Description = 'DITW15.00.00.24';

            trigger OnValidate();
            begin
                // <<DITW15.00.00.01 DDR 23/01/2008
                if Collapse and
                  ("Attached to Line No." = 0)
                then
                  TESTFIELD(Collapse, false);
                // >>DITW15.00.00.01 DDR
            end;
        }
        field(2014411;"Calculated Unit Price";Boolean)
        {
            CaptionML = ENU='Calculated Unit Price',
                        FRA='Calculer prix unitaire';
            Description = 'DITW16.00.00.43';
        }
        field(2014412;"Order No.";Code[20])
        {
            CaptionML = ENU='Order No.',
                        FRA='N° commande';
            Description = 'DITW17.00.02 DIT-770 #235';
        }
        field(2014413;"Order Line No.";Integer)
        {
            CaptionML = ENU='Order Line No.',
                        FRA='N° ligne commande';
            Description = 'DITW17.00.02 DIT-770 #235';
        }
        field(2014414;"Goods Value";Boolean)
        {
            CaptionML = ENU='Goods Value',
                        FRA='Valeur des marchandises';
            Description = 'DITW17.00.02 DIT-770 #235';
        }
        field(2014415;"Item Charge Qty. per Uom";Decimal)
        {
            CaptionML = ENU='Item Charge Qty. per Unit of Measure',
                        FRA='Qté frais annexe par unité de mesure';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.43 DIT-715 #882';
            InitValue = 1;
        }
        field(2014416;"Manual Item Charge";Boolean)
        {
            CaptionML = ENU='Manual Item Charge',
                        FRA='Frais annexe manuel';
            Description = 'DITW17.10.03 DIT-770 #570';
        }
        field(2014417;"Relation Location Code";Code[10])
        {
            CaptionML = ENU='Relation Location Code',
                        FRA='Code Magasin Relation';
            Description = 'DITW110.00.09 NRQ#16737';
            TableRelation = Location WHERE ("Use As In-Transit"=CONST(false),
                                            Code=FIELD("Location Table Filter"));
        }
        field(2014418;"Lot Reserved Qty. (Base)";Decimal)
        {
            CalcFormula = -Sum("Reservation Entry"."Quantity (Base)" WHERE ("Source Type"=CONST(37),
                                                                            "Source ID"=FIELD("Document No."),
                                                                            "Source Subtype"=FIELD("Document Type"),
                                                                            "Source Ref. No."=FIELD("Line No."),
                                                                            "Lot No."=FILTER(<>''),
                                                                            "Reservation Status"=CONST(Surplus)));
            Caption = 'Lot Reserved Qty. (Base)';
            Description = 'NRQ#94671';
            FieldClass = FlowField;
        }
        field(2014442;"Manual Unit Price";Boolean)
        {
            CaptionML = ENU='Manual Unit Price',
                        FRA='Prix unitaire manuel';
            Description = 'DITW16.00.00.43 DDR DIT-715 #605';

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(2014444;"Last Price Calculated Date";Date)
        {
            CaptionML = ENU='Last Price Calculated Date',
                        FRA='Dernière date prix calculé';
            Description = 'DITW15.00.00.31';
        }
        field(2014457;"Collapse Totaling";Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE ("Document Type"=FIELD("Document Type"),
                                                                "Document No."=FIELD("Document No."),
                                                                "Attached to Line No."=FIELD("Line No.")));
            CaptionML = ENU='Collapse Totaling',
                        FRA='Totalisation';
            Description = 'DITW16.00.00.37 TEMP TEST';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014460;"Production BOM No.";Code[20])
        {
            CaptionML = ENU='Production BOM No.',
                        FRA='N° nomenclature production';
            Description = 'DITW18.00.06 DIT-770 #1449';
            TableRelation = "Production BOM Header";
        }
        field(2014462;"BOM Line No.";Integer)
        {
            CaptionML = ENU='BOM Line No.',
                        FRA='N° ligne nomenclature';
            Description = 'DITW18.00.06 DIT-770 #1449';
            NotBlank = true;
            TableRelation = IF ("Production BOM No."=FILTER(<>'')) "Production BOM Line"."Line No." WHERE ("Production BOM No."=FIELD("Production BOM No."))
                            ELSE IF ("Production BOM No."=CONST('')) "BOM Component"."Line No." WHERE ("Parent Item No."=FIELD("BOM Item No."));
        }
        field(2014464;"BOM Qty. per Unit of Measure";Decimal)
        {
            CaptionML = ENU='BOM Qty. per Unit of Measure',
                        FRA='Quantité par unité nomenclature';
            DecimalPlaces = 0:5;
            Description = 'DITW18.00.06 DIT-770 #1449';
        }
        field(2014476;"Packaging Type Code";Code[10])
        {
            CaptionML = ENU='Packaging Type Code',
                        FRA='Code Type de Conditionnement';
            Description = 'DITW15.00.00.38 #1217';
            TableRelation = "Packaging Type";

            trigger OnValidate();
            var
                PackagingType : Record "Packaging Type";
                ItemTax : Record Item;
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusOpen;
                // >>DITW16.00.00.43 DDR DIT-715 #720
                // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
                if (CurrFieldNo = FIELDNO("Packaging Type Code")) and ("Tax Item No." <> '') and
                  ("Packaging Type Code" <> '') and (xRec."Packaging Type Code" <> "Packaging Type Code")
                then
                  TESTFIELD("Packaging Type Code",xRec."Packaging Type Code");
                // >>DITW18.00.06 DDR DIT-770 #1449

                // <<DITW15.00.00.38 DDR 16/02/2011 #1217 (DIT711 148) - 16/03/2011 (DIT711 161)
                if "Packaging Type Code" <> '' then begin
                  PackagingType.GET("Packaging Type Code");
                  if "Tax Item No." <> '' then begin
                    // <<DITW110.00.09 DDR 22/03/2017 NRQ#9661
                    ItemTax.GET("Tax Item No.");
                    ItemUnitOfMeasure.GET("Tax Item No.",ItemTax."Sales Unit of Measure");
                    // >>DITW110.00.09 DDR NRQ#9661
                  end else
                    ItemUnitOfMeasure.GET("No.","Unit of Measure Code");
                  if "Packaging Type Code" = ItemUnitOfMeasure."Packaging Type Code" then begin
                    ItemUnitOfMeasure.TESTFIELD("Pack Qty. per Unit of Measure");
                    "Pack Qty. per Unit of Measure" := ItemUnitOfMeasure."Pack Qty. per Unit of Measure";
                  end else
                    "Pack Qty. per Unit of Measure" := 1;
                  TESTFIELD("Pack Qty. per Unit of Measure");
                end else
                  "Pack Qty. per Unit of Measure" := 0;
                // >>DITW15.00.00.38 DDR #1217 (DIT711 148) (DIT711 161)
                // <<DITW16.00.00.43 DDR 12/08/2013 DIT-715 #720
                // <<DITW16.00.00.44 DDR 24/03/2014 DIT-715 #912
                //<< DITW18.00.07 VSC 02/06/2016 DIT-770 #1932 - DITW110.00.09 DDR 13/04/2017 NRQ#13107
                "No. of Packages" := ROUND(Quantity * "Pack Qty. per Unit of Measure",1,'>');
                //>> DITW18.00.07 VSC DIT-770 #1932 - DITW110.00.09 DDR 13/04/2017 NRQ#13107
                // >>DITW16.00.00.44 DDR DIT-715 #912
                // >>DITW16.00.00.43 DDR DIT-715 #720
            end;
        }
        field(2014477;"No. of Packages";Decimal)
        {
            CaptionML = ENU='No. of Packages',
                        FRA='Nbre de colis';
            DecimalPlaces = 0:2;
            Description = 'DITW16.00.00.43 DIT-715 #720';

            trigger OnValidate();
            var
                PackagingType : Record "Packaging Type";
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusOpen;
                TESTFIELD("ARC No. Mandatory",true);
                TESTFIELD("ARC No.",'');
                // >>DITW16.00.00.43 DDR DIT-715 #720
                TESTFIELD(Quantity);
                // <<DITW15.00.00.38 DDR 17/12/2010 #703
                if ("Tax Item No." = '') and (Type <> Type::Item) then
                  TESTFIELD("No. of Packages",0);
                // >>DITW15.00.00.38 DDR #703
                // <<DITW18.00.06 DDR 20/10/2015 DIT-770 #1449
                if ("Tax Item No." <> '') and (xRec."No. of Packages" <> "No. of Packages") then
                  TESTFIELD("No. of Packages",xRec."No. of Packages");
                // >>DITW18.00.06 DDR DIT-770 #1449
                // <<DITW110.00.09 DDR 22/03/2017 NRQ#9661
                if ("Packaging Type Code" <> '') and ("Outstanding Quantity" <> 0) then begin
                  PackagingType.GET("Packaging Type Code");
                  if PackagingType.Countable then
                    TESTFIELD("No. of Packages");
                end;
                // >>DITW110.00.09 DDR NRQ#9661
            end;
        }
        field(2014478;"Commercial Seal ID";Text[35])
        {
            CaptionML = ENU='Commercial Seal ID',
                        FRA='ID sceau commerciale';
            Description = 'DITW16.00.00.43 DIT-715 #720';

            trigger OnValidate();
            begin
                // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
                TestStatusOpen;
                TESTFIELD("ARC No. Mandatory",true);
                TESTFIELD("ARC No.",'');
                // >>DITW16.00.00.43 DDR DIT-715 #720
                TESTFIELD(Quantity);
                // <<DITW15.00.00.38 DDR 17/12/2010 #703
                if ("Tax Item No." = '') and (Type <> Type::Item) then
                  TESTFIELD("Commercial Seal ID",'');
                // >>DITW15.00.00.38 DDR #703
            end;
        }
        field(2014482;"Pack Qty. per Unit of Measure";Decimal)
        {
            CaptionML = ENU='Packaging Qty. per Unit of Measure',
                        FRA='Quantité conditionnement par unité';
            DecimalPlaces = 0:5;
            Description = 'DITW15.00.00.38 #1217 (DIT711 148)';
        }
        field(2014497;"Resp. Center Table Filter";Code[10])
        {
            CaptionML = ENU='Resp. Center Table Filter',
                        FRA='Filtre Centre de gestion (table)';
            Description = 'DITW18.00.06 DIT-770 #1190';
            FieldClass = FlowFilter;
            TableRelation = "Responsibility Center";
        }
        field(2014498;"Phys. Location Table Filter";Code[10])
        {
            CaptionML = ENU='Phys. Location Table Filter',
                        FRA='Filtre groupe magasin réel (table)';
            Description = 'DITW18.00.06 DIT-770 #1190';
            FieldClass = FlowFilter;
            TableRelation = "Physical Location Group";
        }
        field(2014499;"Location Table Filter";Code[10])
        {
            CaptionML = ENU='Location Table Filter',
                        FRA='Filtre Magasin (table)';
            Description = 'DITW18.00.06 DIT-770 #1190';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(2014500;"Has Item Charge";Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE ("Document Type"=FIELD("Document Type"),
                                                    "Document No."=FIELD("Document No."),
                                                    "Attached to Line No."=FIELD("Line No.")));
            CaptionML = ENU='Has Item Charge',
                        FRA='A des Frais Annexes';
            Description = 'DITW17.10.03 DIT-770 #541';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2014503;"Equiv. Unit of Measure Code";Code[10])
        {
            CaptionML = ENU='Equiv. Unit of Measure Code',
                        FRA='Unitié de mesure equiv.';
            Description = 'DITW17.00.02 DIT-770 #183';
            TableRelation = "Unit of Measure".Code;
        }
        field(2014504;"Calculate Minimum";Option)
        {
            CaptionML = ENU='Calculate Minimum',
                        FRA='Calculer minimum';
            Description = 'DITW17.00.02 DIT-770 #183';
            OptionCaptionML = ENU=' ,Under,Over,Until,Until Including Min,Recurring,Recurring Over,Recurring Under,Recurring Until',
                              FRA=' ,Under,Over,Until,Until Including Min,Recurring,Recurring Over,Recurring Under,Recurring Until';
            OptionMembers = " ",Under,Over,"Until","Until Including Min",Recurring,"Recurring Over","Recurring Under","Recurring Until";
        }
        field(2014505;"Recurring Min. Quantity";Decimal)
        {
            CaptionML = ENU='Recurring Min. Quantity',
                        FRA='Quantité Min. Recurrente';
            DecimalPlaces = 0:5;
            Description = 'DITW17.10.03 DIT-770 #327';
            MinValue = 0;
        }
        field(2014506;"Splitting per";Option)
        {
            CaptionML = ENU='Calculate Source Per',
                        FRA='Calculer source par';
            Description = 'DITW17.10.03 DIT-770 #327';
            InitValue = Item;
            OptionCaptionML = ENU='Group,Item',
                              FRA='Groupe,Article';
            OptionMembers = Group,Item;
        }
        field(2014507;"Minimum Quantity";Decimal)
        {
            Caption = 'Minimum Quantity';
            DecimalPlaces = 0:5;
            Description = 'NRQ#14143';
            MinValue = 0;
        }
        field(2014508;"Minimum Quantity in HL";Decimal)
        {
            Caption = 'Minimum Quantity in HL';
            DecimalPlaces = 0:5;
            Description = 'DITW113.00.15 NRQ#122686';
            MinValue = 0;
        }
        field(2014509;"Minimum Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Minimum Amount';
            Description = 'DITW113.00.15 NRQ#122686';
            MinValue = 0;
        }
        field(2014510;"Loyalty-Created";Boolean)
        {
            Caption = 'Loyalty-Created';
            Description = 'DITW113.00.15 NRQ#120300';
        }
        field(2014511;"Allow Loyalty";Boolean)
        {
            CaptionML = ENU='Allow Loyalty',
                        FRA='Autoriser Fidélité';
            Description = 'DITW16.00.00.40 DIT715 #243';

            trigger OnValidate();
            begin
                // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
                TestStatusOpen;
                if "Allow Loyalty" then
                  TESTFIELD(Type,Type::Item);
                GetSalesHeader();
                if "Allow Loyalty" then begin
                  // <<DITW113.00.15 DDR 18/10/2019 NRQ#120300
                  if CurrFieldNo = FIELDNO("Allow Loyalty") then
                  // >>DITW113.00.15 DDR NRQ#120300
                    LoyaltyCalcMgt.FindSalesLineLoyalty(SalesHeader,Rec,FIELDNO("Allow Loyalty"));
                  // <<DITW113.00.15 DDR 04/10/2019 16/10/2019 NRQ#10495
                  if "Free Reason Code" <> '' then begin
                    rFreeReasonCode.GET("Free Reason Code");
                    rFreeReasonCode.TESTFIELD(Type,rFreeReasonCode.Type::Loyalty);
                  end;
                  VALIDATE("Loyalty Point Type");
                  VALIDATE("Loyalty Amount Type");
                  // >>DITW113.00.15 DDR NRQ#10495
                  // <<DITW113.00.15 DDR 03/10/2019 NRQ#120296
                  if ("Allow Loyalty" <> xRec."Allow Loyalty") and (CurrFieldNo <> FIELDNO("Free Item")) then begin
                  // >>DITW113.00.15 DDR NRQ#120296
                    // <<DITW17.10.05 WSA 02/02/2015 DIT-770 #185
                    UpdateUnitPrice(FIELDNO("Allow Loyalty"));
                    UpdateAmounts();
                    // >>DITW17.10.05 WSA 02/02/2015 DIT-770 #185
                  end;
                  CheckLoyaltyAvail(FIELDNO("Allow Loyalty"));
                end else begin
                  // <<DITW113.00.15 DDR 11/10/2019 16/10/2019 NRQ#120300
                  "Loyalty Convert to Free Item" := false;
                  "Loyalty-Created" := false;
                  // >>DITW113.00.15 DDR NRQ#120300
                  "Loyalty Unit Point" := 0;
                  "Loyalty Points Qty. (Base)" := 0;
                  "Loyalty Outstd. Pts Qty.(Base)" := 0;
                  "Loyalty Unit Amount" := 0;
                  "Loyalty Unit Amount (LCY)" := 0;
                  "Loyalty Outstanding Amount" := 0;
                  "Loyalty Outstd. Amount (LCY)" := 0;
                  // <<DITW113.00.15 DDR 04/10/2019 NRQ#10495
                  "Loyalty Amount" := 0;
                  "Loyalty Amount (LCY)" := 0;
                  // >>DITW113.00.15 DDR NRQ#10495
                  // <<DITW17.10.05 WSA 05/11/2014 DIT-770 #185
                  "Loyalty Point Type" := "Loyalty Point Type" ::" ";
                  "Loyalty Amount Type" := "Loyalty Amount Type" ::" ";
                  // >>DITW17.10.05 WSA 05/11/2014 DIT-770 #185
                  /// DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR 11/10/2019 NRQ#120300
                  // <<DITW17.10.05 DDR 14/08/2014 DIT-770 #868
                  // missing sales line field "Convert to Free Item" from Loyalty setup
                  //<<DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR 11/10/2019 NRQ#120300
                  if ("Allow Loyalty" <> xRec."Allow Loyalty") and (CurrFieldNo <> FIELDNO("Free Item")) then begin
                    /// DITW17.10.05 MSF 08/08/2014 DIT-770 #868 - DITW113.00.15 DDR 11/10/2019 NRQ#120300
                    UpdateUnitPrice(FIELDNO("Allow Loyalty"));
                    UpdateAmounts();
                  end;
                  // >>DITW110.00.12 MSF 27/04/2018 NRQ#10488 - DITW113.00.15 DDR 11/10/2019 NRQ#120300
                  // >>DITW17.10.05 DDR DIT-770 #868
                end;
            end;
        }
        field(2014513;"Loyalty Unit Point";Decimal)
        {
            CaptionML = ENU='Loyalty Unit Point',
                        FRA='Point unitaire';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.40 DIT715 #243';

            trigger OnValidate();
            begin
                // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
                TestStatusOpen;
                if "Loyalty Unit Point" <> 0 then
                  TESTFIELD("Allow Loyalty");
                // <<DITW17.10.05 DDR 05/11/2014 DIT-770 #185
                Sign := 1;
                if "Loyalty Point Type" <> "Loyalty Point Type"::Gain then
                  Sign := -1;
                // <<DITW18.00.07 MVN 23/03/2016 DIT-770 #1918
                "Loyalty Points Qty. (Base)" := Sign * Quantity * "Loyalty Unit Point";
                // >>DITW18.00.07 MVN DIT-770 #1918
                "Loyalty Outstd. Pts Qty.(Base)" := Sign * "Outstanding Quantity" * "Loyalty Unit Point";
                // >>DITW17.10.05 DDR 05/11/2014 DIT-770 #185
            end;
        }
        field(2014514;"Loyalty Points Qty. (Base)";Decimal)
        {
            CaptionML = ENU='Loyalty Points Qty. (Base)',
                        FRA='Points (base)';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.40 DIT715 #243';

            trigger OnValidate();
            begin
                // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
                TestStatusOpen;
                if "Loyalty Points Qty. (Base)" <> 0 then
                  TESTFIELD("Allow Loyalty");
                /// DITW113.00.15 DDR 23/10/2019 NRQ#120300

                // <<DITW113.00.15 DDR 23/10/2019 NRQ#120300
                if "Quantity (Base)" <> 0 then
                // >>DITW113.00.15 DDR NRQ#120300
                  // <<DITW17.10.05 DDR 05/11/2014 DIT-770 #185
                  VALIDATE("Loyalty Unit Point",ABS(ROUND("Loyalty Points Qty. (Base)" / "Quantity (Base)",0.00001)));
                  // >>DITW17.10.05 DDR 05/11/2014 DIT-770 #185
            end;
        }
        field(2014515;"Loyalty Outstd. Pts Qty.(Base)";Decimal)
        {
            CaptionML = ENU='Outstanding Loyalty Points (Base)',
                        FRA='Points ouvert (base)';
            DecimalPlaces = 0:5;
            Description = 'DITW16.00.00.40 DIT715 #243';
            Editable = false;

            trigger OnValidate();
            begin
                // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
                TestStatusOpen;
                if "Loyalty Points Qty. (Base)" <> 0 then
                  TESTFIELD("Allow Loyalty");
            end;
        }
        field(2014516;"Loyalty Unit Amount (LCY)";Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Loyalty Unit Amount (LCY)';
            Description = 'DITW16.00.00.40 DIT715 #243';
            Editable = false;

            trigger OnValidate();
            begin
                /// DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243 - DITW113.00.15 DDR 04/10/2019 NRQ#10495
                //<<DITW17.10.05 DDR 05/11/2014 DIT-770 #185
                Sign := 1;
                if "Loyalty Amount Type" <> "Loyalty Amount Type"::Gain then
                  Sign := -1;
                // <<DITW113.00.15 DDR 04/10/2019 NRQ#10495
                VALIDATE("Loyalty Outstd. Amount (LCY)",
                  ROUND(Sign * "Outstanding Quantity" * "Loyalty Unit Amount (LCY)",Currency."Amount Rounding Precision"));
                VALIDATE("Loyalty Amount (LCY)",
                  ROUND(Sign * Quantity * "Loyalty Unit Amount (LCY)",Currency."Amount Rounding Precision"));
                // >>DITW113.00.15 DDR NRQ#10495
                //>>DITW17.10.05 DDR 05/11/2014 DIT-770 #185
            end;
        }
        field(2014517;"Loyalty Unit Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Loyalty Unit Amount';
            Description = 'DITW16.00.00.40 DIT715 #243';

            trigger OnValidate();
            var
                Currency2 : Record Currency;
            begin
                // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
                GetSalesHeader();

                // <<DITW113.00.15 DDR 04/10/2019 NRQ#10495
                Currency2.InitRoundingPrecision;
                if SalesHeader."Currency Code" <> '' then begin
                  Currency2 := Currency;
                  Currency.TESTFIELD("Unit-Amount Rounding Precision");
                  "Loyalty Unit Amount (LCY)" := ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(GetDate,SalesHeader."Currency Code","Loyalty Unit Amount",SalesHeader."Currency Factor"));
                end else
                  "Loyalty Unit Amount (LCY)" := "Loyalty Unit Amount";
                // >>DITW113.00.15 DDR NRQ#10495

                // <<DITW113.00.15 DDR 04/10/2019 NRQ#10495
                VALIDATE("Loyalty Unit Amount (LCY)");
                // >>DITW113.00.15 DDR NRQ#10495

                // <<DITW17.10.05 DDR 05/11/2014 DIT-770 #185
                Sign := 1;
                if "Loyalty Amount Type" <> "Loyalty Amount Type"::Gain then
                  Sign := -1;
                VALIDATE("Loyalty Outstanding Amount",
                  ROUND(Sign * "Outstanding Quantity" * "Loyalty Unit Amount",Currency."Amount Rounding Precision"));
                // >>DITW17.10.05 DDR 05/11/2014 DIT-770 #185
                // <<DITW113.00.15 DDR 04/10/2019 NRQ#10495
                VALIDATE("Loyalty Amount",
                  ROUND(Sign * Quantity * "Loyalty Unit Amount",Currency."Amount Rounding Precision"));

                CheckLoyaltyAvail(FIELDNO("Loyalty Unit Amount"));
                // >>DITW113.00.15 DDR NRQ#10495
            end;
        }
        field(2014518;"Loyalty Outstanding Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionML = ENU='Outstanding  Loyalty Amount',
                        FRA='Fidélité Coût en commande';
            Description = 'DITW16.00.00.40 DIT715 #243';

            trigger OnValidate();
            var
                Currency2 : Record Currency;
            begin
                // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
                GetSalesHeader;
                Currency2.InitRoundingPrecision;
                if SalesHeader."Currency Code" <> '' then
                  "Loyalty Outstd. Amount (LCY)" :=
                    ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GetDate,"Currency Code",
                        "Loyalty Outstanding Amount",SalesHeader."Currency Factor"),
                      Currency2."Amount Rounding Precision")
                else
                  "Loyalty Outstd. Amount (LCY)" :=
                    ROUND("Loyalty Outstanding Amount",Currency2."Amount Rounding Precision");
            end;
        }
        field(2014519;"Loyalty Outstd. Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU='Outstanding  Loyalty Cost Amount (LCY)',
                        FRA='Fidélité Coût en commande DS';
            Description = 'DITW16.00.00.40 DIT715 #243';
            Editable = false;
        }
        field(2014520;"Loyalty Convert to Free Item";Boolean)
        {
            CaptionML = ENU='Automatic Set Free Item',
                        FRA='DËÇÜfinir comme Article gratuit';
            Description = 'DIT-770 #868';
        }
        field(2014521;"Loyalty Point Type";Option)
        {
            CaptionML = ENU='Loyalty Point Type',
                        FRA='Type Point de fidelisation';
            Description = 'DITW17.10.05 DIT-770 #185';
            OptionCaptionML = ENU=' ,Exchange,Gain',
                              FRA=' ,Change,Gain';
            OptionMembers = " ",Exchange,Gain;

            trigger OnValidate();
            begin
                //<<DITW17.10.05 WSA 31/10/2014 DIT-770 #185
                if "Loyalty Point Type" <> "Loyalty Point Type"::" " then begin
                  TESTFIELD("Allow Loyalty");
                  if xRec."Loyalty Point Type" <> "Loyalty Point Type" then begin
                    // <<DITW113.00.15 DDR 16/10/2019 18/10/2019 NRQ#120300
                    TESTFIELD("Free Item",("Loyalty Point Type" = "Loyalty Point Type"::Exchange));
                    // >>DITW113.00.15 DDR NRQ#120300
                    //<<DITW17.10.05 DDR 05/11/2014 DIT-770 #185 - DITW113.00.15 DDR 04/10/2019 NRQ#10495
                    VALIDATE("Loyalty Unit Point");
                    //>>DITW17.10.05 DDR 05/11/2014 DIT-770 #185 - DITW113.00.15 DDR NRQ#10495
                  end;
                end else begin
                  // <<DITW113.00.15 DDR 11/10/2019 NRQ#120300
                  "Loyalty Unit Point" := 0;
                  // >>DITW113.00.15 DDR NRQ#120300
                  "Loyalty Points Qty. (Base)" := 0;
                  "Loyalty Outstd. Pts Qty.(Base)" := 0;
                end;
                //>>DITW17.10.05 WSA 31/10/2014 DIT-770 #185
            end;
        }
        field(2014522;"Loyalty Amount Type";Option)
        {
            CaptionML = ENU='Loyalty Amount Type',
                        FRA='Type coËÇôt de FidËÇÜlisation';
            Description = 'DITW17.10.05 DIT-770 #185';
            OptionCaptionML = ENU=' ,Exchange,Gain',
                              FRA=' ,Change,Gain';
            OptionMembers = " ",Exchange,Gain;

            trigger OnValidate();
            begin
                //<<DITW17.10.05 WSA 31/10/2014 DIT-770 #185
                if "Loyalty Amount Type"<>"Loyalty Amount Type"::" " then begin
                  TESTFIELD("Allow Loyalty");
                  if xRec."Loyalty Amount Type" <> "Loyalty Amount Type" then begin
                    // <<DITW113.00.15 DDR 16/10/2019 NRQ#120300
                    TESTFIELD("Free Item",("Loyalty Amount Type" = "Loyalty Amount Type"::Exchange));
                    // >>DITW113.00.15 DDR NRQ#120300
                    //<<DITW17.10.05 DDR 05/11/2014 DIT-770 #185 - DITW113.00.15 DDR 04/10/2019 NRQ#10495
                    VALIDATE("Loyalty Unit Amount");
                    //>>DITW17.10.05 DDR 05/11/2014 DIT-770 #185 - DITW113.00.15 DDR NRQ#10495
                  end;
                end else begin
                  // <<DITW113.00.15 DDR 11/10/2019 NRQ#120300
                  VALIDATE("Loyalty Unit Amount",0);
                  // >>DITW113.00.15 DDR NRQ#120300
                  VALIDATE("Loyalty Outstanding Amount",0);
                  // <<DITW113.00.15 DDR 04/10/2019 NRQ#10495
                  VALIDATE("Loyalty Amount",0);
                  // >>DITW113.00.15 DDR NRQ#10495
                end;
                //>>DITW17.10.05 WSA 31/10/2014 DIT-770 #185
            end;
        }
        field(2014523;"Loyalty Amount (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Loyalty Amount (LCY)';
            Description = 'DITW113.00.15 #10495';
            Editable = false;
        }
        field(2014524;"Loyalty Amount";Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Loyalty Amount';
            Description = 'DITW113.00.15 #10495';

            trigger OnValidate();
            var
                Currency2 : Record Currency;
            begin
                // <<DITW113.00.15 DDR 23/10/2019 NRQ#120300
                TestStatusOpen;
                if "Loyalty Amount" <> 0 then
                  TESTFIELD("Allow Loyalty");
                // >>DITW113.00.15 DDR NRQ#120300
                // <<DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
                GetSalesHeader;
                Currency2.InitRoundingPrecision;
                if SalesHeader."Currency Code" <> '' then
                  "Loyalty Amount (LCY)" :=
                    ROUND(
                      CurrExchRate.ExchangeAmtFCYToLCY(
                        GetDate,"Currency Code",
                        "Loyalty Amount",SalesHeader."Currency Factor"),
                      Currency2."Amount Rounding Precision")
                else
                  "Loyalty Amount (LCY)" :=
                    ROUND("Loyalty Amount",Currency2."Amount Rounding Precision");
                // >>DITW16.00.00.40 DDR 27/04/2012 DIT-715 #243
                // <<DITW113.00.15 DDR 23/10/2019 NRQ#120300
                if Quantity <> 0 then
                  "Loyalty Unit Amount" := ABS(ROUND("Loyalty Amount" / Quantity,Currency."Unit-Amount Rounding Precision"));
                // >>DITW113.00.15 DDR NRQ#120300
            end;
        }
        field(2029610;"Tariff No. XL";Code[20])
        {
            CaptionML = ENU='Tariff No. XL',
                        FRA='Nomenclature produits';
            Description = 'FINXL7.00.001';
            Enabled = false;
            NotBlank = true;
            TableRelation = "Tariff Number";

            trigger OnValidate();
            begin
                //<<FINXL7.00.001 RBE 20/03/2013
                //<<DITW17.10.04 AKH 27/11/2014 DIT-770 #654
                //IF recFinXLSetup.READPERMISSION THEN
                //TESTFIELD(Type,Type::"G/L Account");
                //>>DITW17.10.04 AKH 27/11/2014 DIT-770 #654
                //>>FINXL7.00.001 RBE 20/03/2013
            end;
        }
        field(2029611;"Auto. Acc. Group";Code[10])
        {
            CaptionML = ENU='Auto. Acc. Group',
                        FRA='Groupe compte autom.';
            Description = 'FINXL7.00.001';
            TableRelation = "Automatic Acc. Header";

            trigger OnValidate();
            var
                lrecGeneralLedgerSetup : Record "General Ledger Setup";
            begin
                //<<FINXL8.00.001 BSA 25/05/2015 #174
                if recFinXLSetup.READPERMISSION then begin
                  lrecGeneralLedgerSetup.GET;
                  lrecGeneralLedgerSetup.TESTFIELD("Jnl. Template Name (Aut. Acc.)");
                  lrecGeneralLedgerSetup.TESTFIELD("Jnl. Batch Name (Aut. Acc.)");
                end;
                //>>FINXL8.00.001 BSA 25/05/2015 #174
            end;
        }
        field(2029614;"Recycle Chrg. Attach. Line No.";Integer)
        {
            CaptionML = ENU='Recycle Chrg. Attach. Line No.',
                        FRA='Recyclage annexe';
            Description = 'FINXL9.00.000.01';
            Editable = false;
            TableRelation = "Sales Line"."Line No." WHERE ("Document Type"=FIELD("Document Type"),
                                                           "Document No."=FIELD("Document No."));
        }
        field(2029615;"Bill-to Customer No. Shipment";Code[20])
        {
            CaptionML = ENU='Bill-to Customer No. Reception',
                        FRA='N° Recéption Client Facturé';
            Description = 'FINXL8.00.001';
            Editable = false;
            TableRelation = Vendor;
            ValidateTableRelation = false;
        }
        field(2029616;"Intrastat Mandatory";Boolean)
        {
            CalcFormula = Lookup("VAT Posting Setup"."Create Intrastat Ledg. Entries" WHERE ("VAT Bus. Posting Group"=FIELD("VAT Bus. Posting Group"),
                                                                                             "VAT Prod. Posting Group"=FIELD("VAT Prod. Posting Group")));
            Caption = 'Intrastat Mandatory';
            Description = 'FINXL9.00.000.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(2034850;"DIT Sub-Contract Type";Option)
        {
            CaptionML = ENU='Sub Contract Type',
                        FRA='Sous type contrat';
            Description = 'DITW16.00.00.41 DIT-715 #392';
            OptionCaptionML = ENU=' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
                              FRA=' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
            OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;

            trigger OnValidate();
            begin
                // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
                TestStatusOpen;
                if (xRec."DIT Sub-Contract Type" <> "DIT Sub-Contract Type") and
                  (CurrFieldNo = FIELDNO("DIT Sub-Contract Type"))
                then begin
                  VALIDATE("Contract Group Code",'');
                  //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                  case "Contract Type" of
                    "Contract Type"::Service :
                      VALIDATE("Service Contract No.");
                    "Contract Type"::Financial :
                      VALIDATE("Financial Contract No.");
                  end;
                  //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                end;

                SetFilterSubContractPostType();
            end;
        }
        field(2034872;"Contract Group Code";Code[10])
        {
            CaptionML = ENU='Contract Group Code',
                        FRA='Code groupe contrat';
            Description = 'DITW16.00.00.41 DIT-715 #392';
            TableRelation = IF ("Contract Type"=CONST(Service)) "Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"))
                            ELSE IF ("Contract Type"=CONST(Financial)) "Financial Contract Group".Code WHERE ("DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

            trigger OnValidate();
            begin
                // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
                TestStatusOpen;
                if "Contract Group Code" <> '' then begin
                    case "Contract Type" of
                      "Contract Type"::Service:
                        begin
                         if ContractGroup.Code <> "Contract Group Code" then
                           ContractGroup.GET("Contract Group Code");
                         "DIT Sub-Contract Type" := ContractGroup."DIT Sub-Contract Type";
                        end;
                      "Contract Type"::Financial:
                        begin
                         if ContractGroupDIT.Code <> "Contract Group Code" then
                           ContractGroupDIT.GET("Contract Group Code");
                         "DIT Sub-Contract Type" := ContractGroupDIT."DIT Sub-Contract Type";
                        end;
                    end;
                end else begin
                  CLEAR(ContractGroup);
                  CLEAR(ContractGroupDIT);
                end;
                if "Service Contract No." <> '' then
                  VALIDATE("Service Contract No.");
                  //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368                                                                IF "Financial Contract No." <> '' THEN
                  VALIDATE("Financial Contract No.");
                  //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
            end;
        }
        field(2034915;"Service Contract No.";Code[20])
        {
            CaptionML = ENU='Service Contract No.',
                        FRA='N° contrat de service';
            Description = 'DITW16.00.00.41 DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
            TableRelation = IF ("DIT Sub-Contract Type"=CONST(" ")) "Service Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract))
                            ELSE IF ("DIT Sub-Contract Type"=FILTER(<>" ")) "Service Contract Header"."Contract No." WHERE ("Contract Type"=CONST(Contract),
                                                                                                                            "DIT Sub-Contract Type"=FIELD("DIT Sub-Contract Type"));

            trigger OnValidate();
            var
                FA2 : Record "Fixed Asset";
            begin
                // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
                TestStatusOpen;
                if "Service Contract No." <> '' then begin
                  //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                  "Contract Type" := "Contract Type"::Service;
                  TESTFIELD("Financial Contract No.",'');
                  //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                  GetSalesHeader;
                  if (CurrFieldNo = FIELDNO("Service Contract No.")) and
                    (xRec."Service Contract No." <> "Service Contract No.")
                  then begin
                    "Service Contract Line No." := 0;
                    "Contract Group Code" := '';
                  end;
                  ServContract.GET(ServContract."Contract Type"::Contract,"Service Contract No.");
                  if SalesHeader."Building No." <> '' then
                   ServContract.TESTFIELD("Building No.",SalesHeader."Building No.");
                  if ("DIT Sub-Contract Type" <> 0) or
                    ((xRec."DIT Sub-Contract Type" <> 0) and ("DIT Sub-Contract Type" = 0) and
                    (xRec."Service Contract No." = "Service Contract No."))
                  then
                    TESTFIELD("DIT Sub-Contract Type",ServContract."DIT Sub-Contract Type")
                  else
                    "DIT Sub-Contract Type" := ServContract."DIT Sub-Contract Type";
                  if ("Contract Group Code" <> '') or
                    ((xRec."Contract Group Code" <> '') and ("Contract Group Code" = '') and
                    (xRec."Service Contract No." = "Service Contract No."))
                  then
                    TESTFIELD("Contract Group Code",ServContract."Contract Group Code")
                  else
                    "Contract Group Code" := ServContract."Contract Group Code";
                end else begin
                  //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                  CLEAR("Contract Type");
                  //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                  CLEAR("Service Contract Line No.");
                  CLEAR("Contract Group Code");
                end;

                CreateDim(
                  //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                  DimMgt.TypeToTableID2034932(1,"Contract Type"),"Service Contract No.",
                  //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
                  DimMgt.TypeToTableID3(Type),"No.",
                  DATABASE::Job,"Job No.",
                  DATABASE::"Responsibility Center","Responsibility Center",
                  // <<DITW16.00.00.43 DDR 21/10/2013 DIT-715 #768
                  DimMgt.TypeToTableID3(Type::Item),"Tax Item No.");
                  // >>DITW16.00.00.43 DDR DIT-715 #768

                SetFilterSubContractPostType();
            end;
        }
        field(2034920;"Created by Contract Batch Job";Boolean)
        {
            CaptionML = ENU='Created by Contract Batch Job',
                        FRA='Créé par traîtement périodique du contrat';
            Description = 'DITW16.00.00.43 DIT715 #619';
        }
        field(2035390;"Shelf No.";Code[10])
        {
            CaptionML = ENU='Shelf No.',
                        FRA='N° emplacement';
            Description = 'DITW17.00.02 DIT-770 #235';
        }
        field(2035393;"Contract Type";Option)
        {
            CaptionML = ENU='Contract Type',
                        FRA='Type contrat';
            Description = 'DITW16.00.00.41 DIT-715 #392 - DIT-770 #690 -DIT-770 #1368';
            OptionCaptionML = ENU=' ,Service,Financial',
                              FRA=' ,Service,Financier';
            OptionMembers = " ",Service,Financial;

            trigger OnValidate();
            begin
                //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
                //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                if rPropertyServiceMgtSetup.READPERMISSION  or
                   ContractDIT.READPERMISSION
                then begin
                //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                //>>DITW17.10.05 MSF 16/07/2014 DIT-770 #690
                  // <<DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327
                  TestStatusOpen;
                  if "Contract Type" <> xRec."Contract Type" then begin
                    "Contract Group Code" := '';
                     "Service Contract Line No." := 0;
                     //<<DITW18.00.06 DDR 07/08/2015 DIT-770 #1368
                     if "Service Contract No." <> '' then
                       VALIDATE("Service Contract No.",'');
                     if "Financial Contract No." <> '' then
                       VALIDATE("Financial Contract No.",'');
                     //>>DITW18.00.06 DDR 07/08/2015 DIT-770 #1368

                  end;
                  SetFilterSubContractPostType();
                end;
                //<<DITW17.10.05 MSF 16/07/2014 DIT-770 #690
            end;
        }
        field(2035394;"Show Item charge on Invoice";Option)
        {
            Caption = 'Show Item charge on Invoice';
            Description = 'DITW110.00.11 NRQ#43605';
            OptionCaption = '" ,Under item line,Include in item price,Order total"';
            OptionMembers = " ","Under item line","Include in item price","Order total";
        }
        */
        //BC UPGRADE KUMARR78 FDD-MTC-008 >> Adding Field with New ID
        field(50094; "Show Item charge on Inv. FND"; Option)
        {
            Caption = 'Show Item charge on Invoice';
            OptionCaption = ' ,Under item line,Include in item price,Order total';
            OptionMembers = " ","Under item line","Include in item price","Order total";
        }
        //BC UPGRADE KUMARR78 FDD-MTC-008 << Adding Field with New ID
    }
    keys
    {

        //Unsupported feature: PropertyChange on ""Document Type","Document No.","Line No."(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Shipment Date"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Document Type","Bill-to Customer No.","Currency Code"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Document Type",Type,"No.","Variant Code","Drop Shipment","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Location Code","Shipment Date"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Document Type","Bill-to Customer No.","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Currency Code"(Key)". Please convert manually.


        //Unsupported feature: Deletion on ""Document Type","Sell-to Customer No.","Shipment No."(Key)". Please convert manually.
        //BCUPGRADE
        //To Analyze if still required
        /*
        key(Key1;"Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Shipment Date","Delayed Sequence No.")
        {
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key2;"Document Type","Bill-to Customer No.","Currency Code","Item Charge Type",Type,"No.","Empty Goods Item No.")
        {
            SumIndexFields = "Outstanding Amount","Shipped Not Invoiced","Outstanding Amount (LCY)","Shipped Not Invoiced (LCY)","Return Rcd. Not Invd. (LCY)","Outstanding Quantity","Qty. Shipped Not Invoiced","Return Qty. Rcd. Not Invd.";
        }
        key(Key3;"Document Type",Type,"No.","Variant Code","Drop Shipment","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Location Code","Shipment Date","Free Item")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key4;"Document Type","Bill-to Customer No.","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Currency Code","Item Charge Type","Delayed Sequence No.")
        {
            SumIndexFields = "Outstanding Amount","Shipped Not Invoiced","Outstanding Amount (LCY)","Shipped Not Invoiced (LCY)","Outstanding Quantity","Qty. Shipped Not Invoiced";
        }
        key(Key5;"Document Type","Document No.","Location Code","Outstanding Quantity")
        {
            SumIndexFields = Weight,Cubage,"Weight (Base)","Cubage (Base)","HL Cubage","Eq. UOM Quantity";
        }
        key(Key6;"Document Type","Sell-to Customer No.","Shipment No.","Item Charge Type","Empty Goods Item No.","Delayed Sequence No.")
        {
            SumIndexFields = "Outstanding Amount (LCY)";
        }
        key(Key7;"Document Type","Document No.",Type,"No.","Location Code")
        {
            MaintainSIFTIndex = false;
            SQLIndex = "Document Type","Document No.",Type,"No.";
            SumIndexFields = Weight,Cubage,"Weight (Base)","Cubage (Base)","HL Cubage","Eq. UOM Quantity","Delivery Time (sec.)";
        }
        key(Key8;"Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Delayed Sequence No.","Shipment Date")
        {
        }
        key(Key9;"Document Type","Document No.","Attached to Line No.","Is Item Charge","ItemCharge Incl. Price","Extra Charge Type")
        {
            SumIndexFields = "Line Amount";
        }
        key(Key10;"Document Type","Document No.","Attached to Line No.",Collapse)
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Line Amount";
        }
        key(Key11;"Document Type","Document No.","Purch. Order Line No.")
        {
        }
        key(Key12;"Document Type","Document No.","Item Charge Type","Empty Goods Item No.","Attached to Line No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = Amount,"Amount Including VAT","Outstanding Amount","Shipped Not Invoiced","Outstanding Amount (LCY)","Shipped Not Invoiced (LCY)",Quantity,"Outstanding Quantity","Qty. Shipped Not Invoiced",Weight,Cubage;
        }
        key(Key13;"Document Type","Document No.","AAD No. Series","Company Tax Registration No.","Tariff No.",Type,"No.")
        {
        }
        key(Key14;"Document Type","No.",Type,"Delayed Sequence No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Outstanding Qty. (Base)";
        }
        key(Key15;"Document Type","Document No.",Type,"Line No.")
        {
        }
        key(Key16;"Document Type","Bill-to Customer No.",Type,"No.","Variant Code","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code","Location Code","Shipment Date","Allow Loyalty")
        {
            SumIndexFields = "Loyalty Points Qty. (Base)","Loyalty Outstd. Pts Qty.(Base)","Loyalty Outstanding Amount","Loyalty Outstd. Amount (LCY)";
        }
        key(Key17;"Document Type","Document No.","LRN No. Series","Company Tax Registration No.","Company Tax Warehouse Ref.")
        {
        }
        key(Key18;"LRN No.","Company Tax Registration No.","Company Tax Warehouse Ref.","Tariff No.",Type,"No.")
        {
        }
        key(Key19;"ARC No.","Company Tax Registration No.","Tariff No.",Type,"No.")
        {
        }
        key(Key20;"Applies-to AAD Trck. Entry No.")
        {
        }
        key(Key21;"Document Type","Document No.","Location Code",Type,"No.")
        {
            SQLIndex = "Location Code","Document No.";
        }
        key(Key22;"Shelf No.")
        {
        }
        key(Key23;Route,"Shipment Date","No.")
        {
        }
        key(Key24;Route,"Shipment Date","Variant Code","No.")
        {
            SumIndexFields = "Quantity (Base)","Line Amount";
        }
        key(Key25;"Shipment Date","Document Type",Route)
        {
            SQLIndex = "Shipment Date","Document Type",Route;
        }
        key(Key26;"Document Type","Document No.","Attached to Line No.","Item Charge Type",Type)
        {
        }
        key(Key27;Route,"Shipment Date",Type,"Document Type","No.","Shipment Status")
        {
        }
        key(Key28;"Document Type","Shipment Date")
        {
        }
        key(Key29;"Document Type","Requested Delivery Date")
        {
        }
        key(Key30;"Document Type","Promised Delivery Date")
        {
        }
        key(Key31;"Document Type","Document No.","Item DDeposit Group Code")
        {
        }
        */
        //BCUPGRADE
    }


    //Unsupported feature: CodeInsertion on "OnDelete". Please convert manually.

    //trigger (Variable: EmcsCommentLine)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    IF NOT StatusCheckSuspended AND (SalesHeader.Status = SalesHeader.Status::Released) AND
       (Type IN [Type::"G/L Account",Type::"Charge (Item)",Type::Resource])
    THEN
      VALIDATE(Quantity,0);

    IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
      ReserveSalesLine.DeleteLine(Rec);
      CALCFIELDS("Reserved Qty. (Base)");
      TESTFIELD("Reserved Qty. (Base)",0);
      IF "Shipment No." = '' THEN
        TESTFIELD("Qty. Shipped Not Invoiced",0);
      IF "Return Receipt No." = '' THEN
        TESTFIELD("Return Qty. Rcd. Not Invd.",0);
      WhseValidateSourceLine.SalesLineDelete(Rec);
    END;

    IF ("Document Type" = "Document Type"::Order) AND (Quantity <> "Quantity Invoiced") THEN
      TESTFIELD("Prepmt. Amt. Inv.","Prepmt Amt Deducted");

    CleanSpecialOrderFieldsAndCheckAssocPurchOrder;
    NonstockItemMgt.DelNonStockSales(Rec);

    IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
      SalesLine2.RESET;
      SalesLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
      SalesLine2.SETRANGE("Blanket Order No.","Document No.");
      SalesLine2.SETRANGE("Blanket Order Line No.","Line No.");
      IF SalesLine2.FINDFIRST THEN
        SalesLine2.TESTFIELD("Blanket Order Line No.",0);
    END;

    IF Type = Type::Item THEN BEGIN
      ATOLink.DeleteAsmFromSalesLine(Rec);
      DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
    END;

    IF Type = Type::"Charge (Item)" THEN
      DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");

    CapableToPromise.RemoveReqLines("Document No.","Line No.",0,FALSE);

    IF "Line No." <> 0 THEN BEGIN
      SalesLine2.RESET;
      SalesLine2.SETRANGE("Document Type","Document Type");
      SalesLine2.SETRANGE("Document No.","Document No.");
      SalesLine2.SETRANGE("Attached to Line No.","Line No.");
      SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      SalesLine2.DELETEALL(TRUE);
    END;

    IF "Job Contract Entry No." <> 0 THEN
      JobCreateInvoice.DeleteSalesLine(Rec);

    SalesCommentLine.SETRANGE("Document Type","Document Type");
    SalesCommentLine.SETRANGE("No.","Document No.");
    SalesCommentLine.SETRANGE("Document Line No.","Line No.");
    IF NOT SalesCommentLine.ISEMPTY THEN
      SalesCommentLine.DELETEALL;

    IF ("Line No." <> 0) AND ("Attached to Line No." = 0) THEN BEGIN
      SalesLine2.COPY(Rec);
      IF SalesLine2.FIND('<>') THEN BEGIN
        SalesLine2.VALIDATE("Recalculate Invoice Disc.",TRUE);
        SalesLine2.MODIFY;
      END;
    END;

    IF "Deferral Code" <> '' THEN
      DeferralUtilities.DeferralCodeOnDelete(
        DeferralUtilities.GetSalesDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestStatusOpen;
    // <<DITW16.00.00.44 DDR 17/04/2014 DIT-715 #916 - DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
    GetSalesSetup;
    // >>DITW16.00.00.44 DDR DIT-715 #916 - DITW18.00.07 DDR DIT-770 #1488

    if not StatusCheckSuspended and (SalesHeader.Status = SalesHeader.Status::Released) and
       (Type in [Type::"G/L Account",Type::"Charge (Item)",Type::Resource])
    then
      VALIDATE(Quantity,0);

    if (Quantity <> 0) and ItemExists("No.") then begin
    #8..10
      if "Shipment No." = '' then
        TESTFIELD("Qty. Shipped Not Invoiced",0);
      if "Return Receipt No." = '' then
        TESTFIELD("Return Qty. Rcd. Not Invd.",0);
      WhseValidateSourceLine.SalesLineDelete(Rec);
    end;

    //<<FINXL7.00.001 RBE 20/03/2013
    // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
    GetSalesSetup;
    if SalesSetup."Keep Orders After Posting" then
    // >>DITW18.00.07 DDR DIT-770 #1488
      if "Quantity Shipped" <> 0 then
        ERROR(Err2036301);
    //>>FINXL7.00.001 RBE 20/03/2013

    if ("Document Type" = "Document Type"::Order) and (Quantity <> "Quantity Invoiced") then
    #19..23
    if "Document Type" = "Document Type"::"Blanket Order" then begin
    #25..28
      if SalesLine2.FINDFIRST then
        SalesLine2.TESTFIELD("Blanket Order Line No.",0);
    end;

    // <<DITW18.00.06 DDR 03/11/2015 DIT-770 #1395
    if ("Line No." <> 0) and ("BOM Line No." <> 0) and
      ("Is Item Charge" or ("Item Charge Type" <> "Item Charge Type"::" ")) and
      not (BatchInsertCheckSuspended or StatusCheckSuspended)
    then
      TESTFIELD("BOM Line No.",0);
    // >>DITW18.00.06 DDR DIT-770 #1395

    // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
    if ("Line No." <> 0) and not (BatchInsertCheckSuspended or StatusCheckSuspended) then
      TESTFIELD("ItemCharge Incl. Price",false);
    // >>DITW110.00.11 DDR NRQ#24875

    // <<DITW15.00.00.38 DDR 15/10/2010 #1217
    // <<DITW16.00.00.43 DDR 15/10/2013 DIT-715 #765
    if ("Document Type" in ["Document Type"::Order,"Document Type"::"Return Order"]) and ("ARC No." <> '') then
    // >>DITW16.00.00.43 DDR DIT-715 #765
      EDIUpdateInboxDocNo(xRec."ARC No.",'');
    // >>DITW15.00.00.38 DDR

    if Type = Type::Item then begin
      ATOLink.DeleteAsmFromSalesLine(Rec);
      DeleteItemChargeAssgnt("Document Type","Document No.","Line No.");
    end;

    if Type = Type::"Charge (Item)" then
      DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");

    // <<DITW15.00.00.36 DDR 18/11/2009 - DITW15.00.00.37 DDR 28/04/2010
    if (Type <> Type::"Charge (Item)") and "Is Item Charge"  and
      ("Item Charge Calculate per" <> "Item Charge Calculate per"::Item)
    then
      DeleteChargeChargeAssgnt("Document Type","Document No.","Line No.");
    // >>DITW15.00.00.37 DDR

    //<<DITW18.00.06 MSF 05/10/2015 DIT-770 #1261 - DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
    if (SalesSetup."Block Events In Process") and ("Event Doc. No." <>'') then
    //>>DITW18.00.06 MSF 05/10/2015 DIT-770 #1261 - DITW18.00.07 DDR DIT-770 #1488
      ERROR(Text2014362,"Event Doc. No.")
    else begin
      //<<DITW18.00.06 MSF 19/10/2015 DIT-770 #1261
      // <<DITW19.00.08 DDR 05/08/2016 BL#9879
      if (Type = Type ::Item) and ("Event Doc. No." <> '') then begin
      // >>DITW19.00.08 DDR BL#9879
       EventDocNo := "Event Doc. No.";
       EventLineNo := "Event Doc. Line No.";
       "Event Doc. No." :='';
       "Event Doc. Line No." :=0;
       MODIFY;
        if (EventDocNo <> '') and (EventLineNo <> 0)  and ("Document Type" <> "Document Type" :: "Return Order") then
          DeleteReurnSalesline(EventDocNo,EventLineNo );
      //<<DITW18.00.06 MSF 29/09/2015 DIT-770 #1261
      if SalesHeader.GET("Document Type","Document No.") then
      //>>DITW18.00.06 MSF 29/09/2015 DIT-770 #1261
        //<<DITW18.00.06 MSF 09/10/2015 DIT-770 #1261
        if Quantity > 0 then begin
          UpdateEventLine(0,EventDocNo,EventLineNo,CurrFieldNo,true);
        end;
        //>>DITW18.00.06 MSF 09/10/2015 DIT-770 #1261
      end;
    end;
     //>>DITW18.00.06 MSF 19/10/2015 DIT-770 #1261

    CapableToPromise.RemoveReqLines("Document No.","Line No.",0,false);

    // <<DITW15.00.00.01 DDR 21/02/2008
    if "Quantity Shipped" = 0 then
      DiscPromoPostLine.ReopenFromSalesLine(Rec)
    else
      DiscPromoPostLine.CloseFromSalesLine(Rec);
    // >>DITW15.00.00.01 DDR

    if "Line No." <> 0 then begin
      // <<DITW15.00.00.35 DDR 05/08/2009
      PackingListLine.RESET;
      PackingListLine.SETRANGE("Table ID",DATABASE::"Sales Header");
      PackingListLine.SETRANGE("Document Type","Document Type");
      PackingListLine.SETRANGE("Document No.","Document No.");
      PackingListLine.SETRANGE("Line No.","Line No.");
      PackingListLine.DELETEALL(true);
      // >>DITW15.00.00.35 DDR

      SalesLine2.RESET;
      // <<DITW15.00.00.39 DDR 05/07/2011 #1349
      SalesLine2.SETCURRENTKEY("Document Type","Document No.","Attached to Line No.");
      // >>DITW15.00.00.39 DDR #1349
    #45..48
      // <<DITW15.00.00.01 DDR 18/12/2007
      // RWK-SY-9 (13-04-2006 ST) Start
      //SalesLine2.DELETEALL(TRUE);

      // <<DITW15.00.00.39 DDR 01/08/2011 #1415 - DITW19.00.08 DDR 22/08/2016 BL#9858
      if Type = Type::Item then begin
      // >>DITW15.00.00.39 DDR DIT-715 #1415 - DITW19.00.08 DDR BL#9858
        // <<DITW15.00.00.39 DDR 05/07/2011 #1349
        if SalesLine2.FINDSET(true,true) then begin
        // >>DITW16.00.00.37 DIT-715 #1
          repeat
            // <<DITW110.00.11 DDR 10/08/2017 NRQ#24875
            TESTFIELD("ItemCharge Incl. Price",false);
            // >>DITW110.00.11 DDR NRQ#24875
            // <<DITW15.00.00.39 DDR 01/08/2011 #1415 - DITW19.00.08 DDR 22/08/2016 BL#9858
            SalesLine2.SetBatchInsertCheck(true);
            SalesLine2.SuspendStatusCheck(StatusCheckSuspended);
            // >>DITW15.00.00.39 DDR DIT-715 #1415 - DITW19.00.08 DDR BL#9858
            SalesLine2.DELETE(true);
          until SalesLine2.NEXT = 0;
        end;
      end else
        SalesLine2.DELETEALL(true);
      // RWK-SY-9 (13-04-2006 ST) End
      // >>DITW15.00.00.01 DDR
    end;

    // <<DITW15.00.00.19 DDR 20/05/2008 - DITW15.00.00.23 DDR 01/08/2008
    if (Type = Type::Item) and
       (not "Is Item Charge")
    then
      DeleteAllChargeSalesLines(Rec,true);
    // >>DITW15.00.00.23 DDR

    // <<DITW15.00.00.26 DDR 31/10/2008
    if "Item Charge Calculate per" = "Item Charge Calculate per"::DelayOrder then
      DelayedLineMgt.DeleteAppliedDelayedLine(
        DATABASE::"Sales Header","Delayed Sequence No.",false);
    // >>DITW15.00.00.26 DDR

    // <<DITW15.00.00.37 DDR 04/02/2010 - 30/03/2010
    if ("Item Charge Calculate per" = "Item Charge Calculate per"::Order) and
      ("Attached to Line No." <> 0) and
      not (BatchInsertCheckSuspended or StatusCheckSuspended)
    then begin
      if SalesLine2.GET("Document Type","Document No.","Attached to Line No.") and
        SalesLine2."Disc.Promo. Order Calculated"
      then begin
        SalesLine2."Disc.Promo. Order Calculated" := false;
        SalesLine2.MODIFY;
      end;
    end;
    // >>DITW15.00.00.37 DDR

    // <<DITW15.00.00.39 DDR 05/07/2011 #1349
    if not (BatchInsertCheckSuspended or StatusCheckSuspended) and
      (Type <> Type::" ") and
      ("Attached to Line No." <> 0) and
      ("Item Charge Type" = "Item Charge Type"::Tax)
    then begin
      SalesLine2.RESET;
      SalesLine2.SETCURRENTKEY("Document Type","Document No.","Attached to Line No.");
      SalesLine2.SETRANGE("Document Type","Document Type");
      SalesLine2.SETRANGE("Document No.","Document No.");
      SalesLine2.SETRANGE("Attached to Line No.","Line No.");
      SalesLine2.SETRANGE("Item Charge Type","Item Charge Type"::Tax);
      SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      if SalesLine2.ISEMPTY then begin
        if SalesLine2.GET("Document Type","Document No.","Attached to Line No.") and
          // <<DITW15.00.00.39 DDR 01/08/2011 #1415
          ((SalesLine2."AAD No. Series" <> '') or
          (SalesLine2."LRN No. Series" <> '') or
          (SalesLine2."ARC No. Mandatory"))
          // >>DITW15.00.00.39 DDR DIT-715 #1415
        then begin
          SalesLine2."AAD No. Series" := '';
          SalesLine2."LRN No. Series" := '';
          SalesLine2."ARC No. Mandatory" := false;
          SalesLine2.MODIFY;
        end;
      end;
    end;

    //<<FINXL9.00.000.01 ACH 10/01/2017
    if "Line No." <> 0 then begin
    #44..46
      SalesLine2.SETRANGE("Recycle Chrg. Attach. Line No.","Line No.");
      SalesLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      SalesLine2.DELETEALL(true);
    end;
    //>>FINXL9.00.000.01 ACH 10/01/2017

    if "Job Contract Entry No." <> 0 then
    #53..57
    if not SalesCommentLine.ISEMPTY then
      SalesCommentLine.DELETEALL;

    /// DITW19.00.08 DDR 05/08/2016 BL#9879 from NAV'2016
    /// DITW110.00.08 DDR 02/01/2017 NRQ#0 from NAV'2017
    if ("Line No." <> 0) and ("Attached to Line No." = 0) then begin
      SalesLine2.COPY(Rec);
      // <<DITW19.00.08 DDR 05/08/2016 BL#9879
      SalesLine2.SETRANGE("Item Charge Type","Item Charge Type"::" ");
      // >>DITW19.00.08 DDR BL#9879
      if SalesLine2.FIND('<>') then begin
        SalesLine2.VALIDATE("Recalculate Invoice Disc.",true);
        SalesLine2.MODIFY;
      end;
    end;

    if "Deferral Code" <> '' then
    #70..72

    // <<DITW16.00.00.43 DDR 06/08/2013 DIT-715 #720
    EmcsCommentLine.SETRANGE("Table ID",DATABASE::"Sales Line");
    EmcsCommentLine.SETRANGE("Document Type","Document Type");
    EmcsCommentLine.SETRANGE("Document No.","Document No.");
    EmcsCommentLine.SETRANGE("Document Line No.","Line No.");
    EmcsCommentLine.DELETEALL;

    if ("Document Type" = "Document Type"::Order) and (Type = Type::Item) then begin
      AADTrackingEntry.SETCURRENTKEY("Document Type","Document No.");
      AADTrackingEntry.SETRANGE("Document Type",AADTrackingEntry."Document Type"::SO);
      AADTrackingEntry.SETRANGE("Document No.","Document No.");
      AADTrackingEntry.SETRANGE("Document Line No.","Line No.");
      // <<DITW16.00.00.44 DDR 17/04/2014 DIT-715 #916
      if not AADTrackingEntry.ISEMPTY then begin
        if ExistEdiOutbox() and (EDIOutbox."Line Status" <> EDIOutbox."Line Status"::Sent) then
          ERROR(Text2014262,
            EDIOutbox.TABLECAPTION,EDIOutbox.FIELDCAPTION("Transaction No."),EDIOutbox."Transaction No.");
        if ("AAD No." <> '') or ("ARC No." <> '') then begin
          if SalesSetup."Duty Point" = SalesSetup."Duty Point"::"Posted Shipment" then
            TESTFIELD("Completely Shipped",true);
          if SalesSetup."Duty Point" = SalesSetup."Duty Point"::"Posted Invoice" then
            TESTFIELD("Qty. Shipped Not Invoiced");
        end;
      end;
      // >>DITW16.00.00.44 DDR DIT-715 #916
      AADTrackingEntry.DELETEALL(true);
    end;
    // >>DITW16.00.00.43 DDR DIT-715 #720

    // <<DITW15.00.00.39 DDR 09/05/2011 #1328
    DeleteLinkPosSalesEntries();
    // >>DITW15.00.00.39 DDR #1328

    /// FINXL8.00.001 BSA 27/05/2015 #184 - DITW110.00.09 AKH 31/03/2017 NRQ#24104
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    IF Quantity <> 0 THEN
      ReserveSalesLine.VerifyQuantity(Rec,xRec);
    LOCKTABLE;
    SalesHeader."No." := '';
    IF Type = Type::Item THEN
      IF SalesHeader.InventoryPickConflict("Document Type","Document No.",SalesHeader."Shipping Advice") THEN
        ERROR(Text056,SalesHeader."Shipping Advice");
    IF ("Deferral Code" <> '') AND (GetDeferralAmount <> 0) THEN
      UpdateDeferralAmounts;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TestStatusOpen;
    if Quantity <> 0 then
    #3..5
    if Type = Type::Item then
      if SalesHeader.InventoryPickConflict("Document Type","Document No.",SalesHeader."Shipping Advice") then
        ERROR(Text056,SalesHeader."Shipping Advice");
    if ("Deferral Code" <> '') and (GetDeferralAmount <> 0) then
      UpdateDeferralAmounts;

    // << DITW15.00.00.23 DDR 30/07/2008
    if (Type = Type::Item) and
       ("No." <> '') and
       (not "Is Item Charge") and
       (not BatchInsertCheckSuspended) and
       ("Line No." <> 0)
    then begin
      // <<DITW15.00.00.35 DDR 29/06/2009
      if TransferExtText.SalesCheckIfAnyExtText(Rec,false) then
        TransferExtText.InsertSalesExtText(Rec);
      // >>DITW15.00.00.35 DDR
    end;
    // >>DITW15.00.00.23 DDR

    //<<FINXL8.00.001 BSA 10/06/2015 #85
    // <<DITW19.00.08 DDR 08/08/2016 BL#9713 - FINXL9.00.000.01 AKH 12/01/2017
    //IF recFinXLSetup.READPERMISSION THEN
    if recFinXLSetup.READPERMISSION and ("Line No." <> 0) and (CurrFieldNo <> 0) and not BatchInsertCheckSuspended then
    // >>DITW19.00.08 DDR BL#9713 - FINXL9.00.000.01 AKH 12/01/2017
      fctUpdateHeaderDocAfterModify;
    //>>FINXL8.00.001 BSA 10/06/2015 #85
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ("Document Type" = "Document Type"::"Blanket Order") AND
       ((Type <> xRec.Type) OR ("No." <> xRec."No."))
    THEN BEGIN
      SalesLine2.RESET;
      SalesLine2.SETCURRENTKEY("Document Type","Blanket Order No.","Blanket Order Line No.");
      SalesLine2.SETRANGE("Blanket Order No.","Document No.");
      SalesLine2.SETRANGE("Blanket Order Line No.","Line No.");
      IF SalesLine2.FINDSET THEN
        REPEAT
          SalesLine2.TESTFIELD(Type,Type);
          SalesLine2.TESTFIELD("No.","No.");
        UNTIL SalesLine2.NEXT = 0;
    END;

    IF ((Quantity <> 0) OR (xRec.Quantity <> 0)) AND ItemExists(xRec."No.") AND NOT FullReservedQtyIsForAsmToOrder THEN
      ReserveSalesLine.VerifyChange(Rec,xRec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if ("Document Type" = "Document Type"::"Blanket Order") and
       ((Type <> xRec.Type) or ("No." <> xRec."No."))
    then begin
    #4..7
      if SalesLine2.FINDSET then
        repeat
          SalesLine2.TESTFIELD(Type,Type);
          SalesLine2.TESTFIELD("No.","No.");
        until SalesLine2.NEXT = 0;
    end;

    if ((Quantity <> 0) or (xRec.Quantity <> 0)) and ItemExists(xRec."No.") and not FullReservedQtyIsForAsmToOrder then
      ReserveSalesLine.VerifyChange(Rec,xRec);
    //<<FINXL9.00.001 DAT 23/12/2015
    if not blnChangedfromHeader then
    //>>FINXL9.00.001 DAT 23/12/2015
    //<<FINXL9.00.001 ACH 27/07/2016
      // <<DITW19.00.08 DDR 08/08/2016 BL#9713
      //IF recFinXLSetup.READPERMISSION THEN
      if recFinXLSetup.READPERMISSION and ("Line No." <> 0) and (CurrFieldNo <> 0) and not BatchInsertCheckSuspended then
      // >>DITW19.00.08 DDR BL#9713
        fctUpdateHeaderDocAfterModify;
    //>>FINXL9.00.001 ACH 27/07/2016
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        //DitDiscountGr : Record "Drink Discount Group";
        //lTempCurrfieldno : Integer;
        ServItemGroup: Record "Service Item Group";
        Cust: Record Customer;
        ItemLocationCode: Code[10];
        TempFreeItem: Boolean;
        GLSetup: Record "General Ledger Setup";
        locItem: Record Item;
        //FreeReasonCode : Record "Free Reason Code";
        VATProdPostingGroup: Code[10];


        lCurrUnitPrice: Decimal;

        BatchInsertCheckSuspended2: Boolean;


        LocationCode: Code[20];
        PhysLocGrCode: Code[10];

        lItemNo: Code[20];
        //EmcsCommentLine : Record "EMCS Comment Line";
        //AADTrackingEntry : Record "AAD Tracking Entry";

        lTempBatchInsertCheckSuspended: Boolean;
        OldSalesHeader: Record "Sales Header";
        //FreeReasonCode : Record "Free Reason Code";

        TempSalesLineChecking: Record "Sales Line" temporary;


        DepreciationBook: Record "Depreciation Book";
        lAssignableQty: Decimal;
        SalesHeader2: Record "Sales Header";
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";
        lrTempSalesLine: Record "Sales Line" temporary;
        lrSalesLineCopy: Record "Sales Line";
        VATPostingSetup2: Record "VAT Posting Setup";
        CADAmount: Decimal;
        lOldItemNo: Code[20];
        lTempCurrfieldNo: Integer;
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
    //RetReasonLocationRelation : Record "Ret. Reason Location Relation";
    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot delete the order line because it is associated with purchase order %1 line %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot delete the order line because it is associated with purchase order %1 line %2.;FRA=Vous ne pouvez pas supprimer cette ligne commande car elle est associée à la commande %1 ligne %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot rename a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot rename a %1.;FRA=Vous ne pouvez pas renommer l'enregistrement %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot change %1 because the order line is associated with purchase order %2 line %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot change %1 because the order line is associated with purchase order %2 line %3.;FRA=Vous ne pouvez pas modifier %1 parce que la ligne commande est associée à la commande %2 ligne %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=must not be less than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=must not be less than %1;FRA=ne doit pas être inférieur(e) à %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=You cannot invoice more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=You cannot invoice more than %1 units.;FRA=Vous ne pouvez pas facturer plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=You cannot invoice more than %1 base units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=You cannot invoice more than %1 base units.;FRA=Vous ne pouvez pas facturer plus de %1 unité(s) de base.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot ship more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot ship more than %1 units.;FRA=Vous ne pouvez pas expédier plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot ship more than %1 base units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot ship more than %1 base units.;FRA=Vous ne pouvez pas expédier plus de %1 unité(s) de base.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=" must be 0 when %1 is %2";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=" must be 0 when %1 is %2";FRA=" doit être 0 quand %1 est %2";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=Automatic reservation is not possible.\Do you want to reserve items manually?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=Automatic reservation is not possible.\Do you want to reserve items manually?;FRA=La réservation automatique n'est pas possible.\Souhaitez-vous réserver les articles manuellement ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=%1 %2 is before work date %3;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=%1 %2 is before work date %3;FRA=La %1 %2 est antérieure à la date de travail %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text016(Variable 1040)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU="%1 is required for %2 = %3.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU="%1 is required for %2 = %3.";FRA="%1 est nécessaire pour %2 = %3.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text017(Variable 1044)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : ENU=\The entered information may be disregarded by warehouse operations.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : ENU=\The entered information may be disregarded by warehouse operations.;FRA=\Les informations entrées peuvent être ignorées par les opérations de distribution.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text020(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : ENU=You cannot return more than %1 units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : ENU=You cannot return more than %1 units.;FRA=Vous ne pouvez pas retourner plus de %1 unité(s).;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=You cannot return more than %1 base units.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=You cannot return more than %1 base units.;FRA=Vous ne pouvez pas retourner plus de %1 unité(s) de base.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text026(Variable 1025)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text026 : ENU=You cannot change %1 if the item charge has already been posted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text026 : ENU=You cannot change %1 if the item charge has already been posted.;FRA=Vous ne pouvez pas modifier %1 si les frais annexes ont été validés.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text028(Variable 1098)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text028 : ENU=You cannot change the %1 when the %2 has been filled in.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text028 : ENU=You cannot change the %1 when the %2 has been filled in.;FRA=Vous ne pouvez pas modifier le champ %1 lorsque le champ %2 a été renseigné.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text029(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text029 : ENU=must be positive;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text029 : ENU=must be positive;FRA=doit être de signe positif;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text030(Variable 1042)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text030 : ENU=must be negative;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text030 : ENU=must be negative;FRA=doit être de signe négatif;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text031(Variable 1093)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text031 : ENU=You must either specify %1 or %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text031 : ENU=You must either specify %1 or %2.;FRA=Vous devez spécifier %1 ou %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text034(Variable 1084)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text034 : ENU=The value of %1 field must be a whole number for the item included in the service item group if the %2 field in the Service Item Groups window contains a check mark.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text034 : ENU=The value of %1 field must be a whole number for the item included in the service item group if the %2 field in the Service Item Groups window contains a check mark.;FRA=La valeur du champ %1 de l'article inclus dans le groupe articles de service doit être un entier si le champ %2 de la fenêtre Gpe articles de service est activé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text035(Variable 1083)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text035 : ENU="Warehouse ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text035 : ENU="Warehouse ";FRA="Entrepôt ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text036(Variable 1090)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text036 : ENU="Inventory ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text036 : ENU="Inventory ";FRA="Stocks ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text037(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text037 : ENU=You cannot change %1 when %2 is %3 and %4 is positive.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text037 : ENU=You cannot change %1 when %2 is %3 and %4 is positive.;FRA=Vous ne pouvez pas modifier %1 si %2 est %3 et si %4 est de signe positif.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text038(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text038 : ENU=You cannot change %1 when %2 is %3 and %4 is negative.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text038 : ENU=You cannot change %1 when %2 is %3 and %4 is negative.;FRA=Vous ne pouvez pas modifier %1 si %2 est %3 et si %4 est de signe négatif.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text039(Variable 1034)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text039 : ENU=%1 units for %2 %3 have already been returned. Therefore, only %4 units can be returned.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text039 : ENU=%1 units for %2 %3 have already been returned. Therefore, only %4 units can be returned.;FRA=%1 unités pour le %2 %3 ont déjà été renvoyées. Seules %4 unités peuvent donc être renvoyées.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text040(Variable 1039)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text040 : ENU=You must use form %1 to enter %2, if item tracking is used.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text040 : ENU=You must use form %1 to enter %2, if item tracking is used.;FRA=Si vous utilisez la traçabilité, vous devez employer le formulaire %1 pour entrer %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text042(Variable 1055)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text042 : ENU=When posting the Applied to Ledger Entry %1 will be opened first;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text042 : ENU=When posting the Applied to Ledger Entry %1 will be opened first;FRA=Lors de la validation, l'écriture comptable lettrée %1 s'ouvre d'abord;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShippingMoreUnitsThanReceivedErr(Variable 1047)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShippingMoreUnitsThanReceivedErr : ENU=You cannot ship more than the %1 units that you have received for document no. %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShippingMoreUnitsThanReceivedErr : ENU=You cannot ship more than the %1 units that you have received for document no. %2.;FRA=Vous ne pouvez pas expédier plus que les %1 unités que vous avez reçues pour le document n° %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text044(Variable 1103)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text044 : ENU=cannot be less than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text044 : ENU=cannot be less than %1;FRA=ne peut pas être inférieur(e) à %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text045(Variable 1104)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text045 : ENU=cannot be more than %1;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text045 : ENU=cannot be more than %1;FRA=ne peut pas être supérieur(e) à %1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text046(Variable 1105)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text046 : ENU=You cannot return more than the %1 units that you have shipped for %2 %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text046 : ENU=You cannot return more than the %1 units that you have shipped for %2 %3.;FRA=Vous ne pouvez pas retourner plus que les %1 unités que vous avez expédiées pour %2 %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text047(Variable 1106)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text047 : ENU=must be positive when %1 is not 0.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text047 : ENU=must be positive when %1 is not 0.;FRA=doit être de signe positif si %1 est différent de 0.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text048(Variable 1108)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text048 : ENU=You cannot use item tracking on a %1 created from a %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text048 : ENU=You cannot use item tracking on a %1 created from a %2.;FRA=Vous ne pouvez pas utiliser la traçabilité sur un(e) %1 créé(e) à partir d'un(e) %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text049(Variable 1139)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text049 : ENU=cannot be %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text049 : ENU=cannot be %1.;FRA=ne peut pas être %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text051(Variable 1141)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text051 : ENU=You cannot use %1 in a %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text051 : ENU=You cannot use %1 in a %2.;FRA=Vous ne pouvez pas utiliser %1 dans un %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text052(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text052 : ENU=You cannot add an item line because an open warehouse shipment exists for the sales header and Shipping Advice is %1.\\You must add items as new lines to the existing warehouse shipment or change Shipping Advice to Partial.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text052 : ENU=You cannot add an item line because an open warehouse shipment exists for the sales header and Shipping Advice is %1.\\You must add items as new lines to the existing warehouse shipment or change Shipping Advice to Partial.;FRA=Vous ne pouvez pas ajouter une ligne article car il existe une expédition entrepôt ouverte pour l'en-tête vente et parce que l'option d'expédition est %1.\\Vous devez ajouter les articles comme nouvelles lignes à l'expédition entrepôt existante ou modifier l'option d'expédition en la définissant sur Partielle.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text053(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text053 : ENU=You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text053 : ENU=You have changed one or more dimensions on the %1, which is already shipped. When you post the line with the changed dimension to General Ledger, amounts on the Inventory Interim account will be out of balance when reported per dimension.\\Do you want to keep the changed dimension?;FRA=Vous avez modifié un ou plusieurs axes analytiques dans %1, qui a déjà été expédié. Lorsque vous validez la ligne avec l'axe analytique modifié dans la comptabilité, les montants de l'état intermédaire stock présentent un déséquilibre si un état est généré par axe analytique.\\Voulez-vous conserver l'axe analytique modifié ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text054(Variable 1023)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text054 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text054 : ENU=Cancelled.;FRA=Annulé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text055(Variable 1024)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text055 : @@@=Quantity Invoiced must not be greater than the sum of Qty. Assigned and Qty. to Assign.;ENU=%1 must not be greater than the sum of %2 and %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text055 : @@@=Quantity Invoiced must not be greater than the sum of Qty. Assigned and Qty. to Assign.;ENU=%1 must not be greater than the sum of %2 and %3.;FRA=%1 ne doit pas être supérieur à la somme de %2 et de %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text056(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text056 : ENU=You cannot add an item line because an open inventory pick exists for the Sales Header and because Shipping Advice is %1.\\You must first post or delete the inventory pick or change Shipping Advice to Partial.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text056 : ENU=You cannot add an item line because an open inventory pick exists for the Sales Header and because Shipping Advice is %1.\\You must first post or delete the inventory pick or change Shipping Advice to Partial.;FRA=Vous ne pouvez pas ajouter une ligne article car il existe un prélèvement stock ouvert pour l'en-tête vente et parce que l'option d'expédition est %1.\\Vous devez tout d'abord valider ou supprimer le prélèvement stock ou remplacer l'option d'expédition par Partielle.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text057(Variable 1027)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text057 : ENU=must have the same sign as the shipment;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text057 : ENU=must have the same sign as the shipment;FRA=doit avoir le même signe que la livraison;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text058(Variable 1028)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text058 : ENU=The quantity that you are trying to invoice is greater than the quantity in shipment %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text058 : ENU=The quantity that you are trying to invoice is greater than the quantity in shipment %1.;FRA=La quantité que vous tentez de facturer est supérieure à la quantité expédiée %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text059(Variable 1029)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text059 : ENU=must have the same sign as the return receipt;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text059 : ENU=must have the same sign as the return receipt;FRA=doit avoir le même signe que la réception retour;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text060(Variable 1041)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text060 : ENU=The quantity that you are trying to invoice is greater than the quantity in return receipt %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text060 : ENU=The quantity that you are trying to invoice is greater than the quantity in return receipt %1.;FRA=La quantité que vous tentez de facturer est supérieure à la quantité de la réception retour %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "AnotherItemWithSameDescrQst(Variable 1049)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AnotherItemWithSameDescrQst : @@@="%1=Item no., %2=item description";ENU=We found an item with the description "%2" (No. %1).\Did you mean to change the current item to %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AnotherItemWithSameDescrQst : @@@="%1=Item no., %2=item description";ENU=We found an item with the description "%2" (No. %1).\Did you mean to change the current item to %1?;FRA=Nous avons trouvé un article portant la description « %2 » (n° %1).\Souhaitiez-vous modifier l'article actuel en %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SalesLineCompletelyShippedErr(Variable 1053)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SalesLineCompletelyShippedErr : ENU=You cannot change the purchasing code for a sales line that has been completely shipped.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SalesLineCompletelyShippedErr : ENU=You cannot change the purchasing code for a sales line that has been completely shipped.;FRA=Vous ne pouvez pas modifier le code achat d'une ligne vente qui a été entièrement expédiée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemNoFieldCaptionTxt(Variable 1046)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemNoFieldCaptionTxt : ENU=Item;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemNoFieldCaptionTxt : ENU=Item;FRA=Article;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "FreightLineDescriptionTxt(Variable 1033)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //FreightLineDescriptionTxt : ENU=Freight Amount;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //FreightLineDescriptionTxt : ENU=Freight Amount;FRA=Montant des frais de transport;
    //Variable type has not been exported.
    procedure UpdateFreeReasonCodeDimensions()
    var
        SalesLine3: Record "Sales Line";
        SalesLine4: Record "Sales Line";
        DefaultDimension: Record "Default Dimension";
        TempDimSetEntry: Record "Dimension Set Entry";
    begin
        //HEI.10>>
        SalesLine3.SETRANGE("Document No.", "Document No.");
        SalesLine3.SETRANGE("Document Type", "Document Type");
        // SalesLine3.SETRANGE("Item Charge Type", "Item Charge Type"::Promotion); // BC Upgrade BHARDA11 ----Drink-IT Field ("Item Charge Type")
        SalesLine3.SETRANGE("Attached to Line No.", "Line No.");
        IF SalesLine3.FINDSET() THEN
            REPEAT
                // DefaultDimension.SETRANGE("Table ID", DATABASE::"Free Reason Code"); // BC Upgrade BHARDA11 ----Drink-IT Table (Free Reason Code)
                // DefaultDimension.SETRANGE("No.", SalesLine3."Free Reason Code");  // BC Upgrade BHARDA11 ----Drink-IT Field ("Free Reason Code")
                IF DefaultDimension.FINDSET() THEN BEGIN
                    SalesLine4.GET(SalesLine3."Document Type", SalesLine3."Document No.", SalesLine3."Line No.");
                    DimMgt.GetDimensionSet(TempDimSetEntry, SalesLine4."Dimension Set ID");
                    REPEAT
                        UpdateDimSet(TempDimSetEntry, DefaultDimension."Dimension Code", DefaultDimension."Dimension Value Code");
                    UNTIL DefaultDimension.NEXT() = 0;
                    SalesLine4.VALIDATE("Dimension Set ID", DimMgt.GetDimensionSetID(TempDimSetEntry));
                    SalesLine4.MODIFY(TRUE);
                END;
            UNTIL SalesLine3.NEXT() = 0;
        //HEI.10<<
    end;

    procedure UpdateDimSet(VAR TempDimSetEntry: Record "Dimension Set Entry" TEMPORARY; DimCode: Code[20]; DimValueCode: Code[20])
    var
        DimVal: Record "Dimension Value";
    begin
        //HEI.10>>
        IF DimCode = '' THEN
            EXIT;
        IF TempDimSetEntry.GET("Dimension Set ID", DimCode) THEN
            TempDimSetEntry.DELETE();
        IF DimValueCode = '' THEN
            DimVal.INIT()
        ELSE
            DimVal.GET(DimCode, DimValueCode);
        TempDimSetEntry."Dimension Code" := DimCode;
        TempDimSetEntry."Dimension Value Code" := DimValueCode;
        TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
        TempDimSetEntry.INSERT();
        //HEI.10<<
    end;

    procedure UpdateTINBAndVATProdPostGrByLocation()
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        TINbyLocation: Record "TIN by Location FND";
    begin
        //HEI.12>>
        GeneralLedgerSetup.GET();
        IF GeneralLedgerSetup."Enable TIN By Location FND" THEN BEGIN
            TINbyLocation.GET("VAT Prod. Posting Group", "Location Code");
            "VAT Prod. Posting Group" := TINbyLocation."VAT Prod. Posting Group by Loc";
            TINbyLocation.CALCFIELDS("TIN No.");
            "TIN No. FND" := TINbyLocation."TIN No.";

            TESTFIELD("TIN No. FND");
            CheckDifferentTINNo();
        END;
        //HEI.12<<
    end;

    local procedure CheckDifferentTINNo()
    var

        SalesLine: Record "Sales Line";
    begin
        //HEI.12>>
        SalesLine.SETRANGE("Document No.", "Document No.");
        SalesLine.SETRANGE("Document Type", "Document Type");
        SalesLine.SETFILTER("Line No.", '<>%1', "Line No.");
        SalesLine.SETFILTER("TIN No. FND", '<>%1', "TIN No. FND");
        IF SalesLine.FINDSET() THEN
            REPEAT
                IF SalesLine."TIN No. FND" <> '' THEN
                    ERROR(DifferentTINNoErr, FIELDCAPTION("Document No."), "Document No.");
            UNTIL SalesLine.NEXT() = 0;
        //HEI.12<<
    end;

    procedure SetCurrFieldNo(NewCurrFieldNo: Integer)
    begin
        CurrFieldNo := NewCurrFieldNo;//HEI.13
    end;

    procedure Get_blnChangedfromHeader(): Boolean
    begin
        //HEI.33
        EXIT(blnChangedfromHeader);
    end;



    var
        Text012: TextConst ENU = 'Change %1 from %2 to %3?', FRA = 'Remplacer %1 de %2 à %3 ?';

    var
        DimMgt: Codeunit DimensionManagement;
        TempItemChargeAssgntSales: Record "Item Charge Assignment (Sales)" temporary;
        CompanyInfo: Record "Company Information";
        //BCUPGRADE>>
        //DRINKIT
        /*
        CustDrinkTaxGr : Record "Drink Tax Group";
        ItemDrinkTaxGr : Record "Drink Tax Group";
        TransferTaxCharges : Codeunit "Tax Item Charges Mgt.";
        TransferDepositCharges : Codeunit "Deposit Item Charges Mgt.";
        TransferDiscountCharges : Codeunit "Discount Item Charges Mgt.";
        TransferPromotionCharges : Codeunit "Promotion Item Charges Mgt.";
        DiscPromoPostLine : Codeunit "Sales Disc. & Promo.-Post Line";
        */
        //BCUPGRADE<<
        Text2014060: TextConst ENU = 'Do you want to reduce the order quantity for this manco receipt?', FRA = 'Voulez vous diminuer la quantité pour cette manco réception ?';
        Text2014061: TextConst ENU = 'Do you want to increase the order quantity for this surplus receipt?', FRA = 'Voulez vous augmenter la quantité pour cette manco réception ?';
        Text2014062: TextConst ENU = 'You can not use tax location %1 for drop shipments! ', FRA = 'Vous ne pouvez pas utiliser la taxe magasin %1 pour la livraison directe! ';
        Text2014410: TextConst ENU = 'The %1 combination ''%2'' ''%3'' does not exist for %4 %5.', FRA = 'La %1 combinaison %2 %3 n''existe pas pour %4 %5.';
        Text2014411: TextConst ENU = 'Do you want to insert the item charges for all lines?', FRA = 'Souhaitez-vous insérer les frais annexes pour toutes les lignes?';
        Text2014412: TextConst ENU = 'Do you want to replace the existing %1 %2 using the item selection?', FRA = 'Souhaitez-vous remplacer l''actuel %1 %2 par les articles sélectionnés?';
        Text2014413: TextConst ENU = 'Your identification is set up to process from %1 %2 only.', FRA = 'Le paramétrage de votre code utilisateur ne vous permet de travailler que sur %1 %2.';
        Text2014414: TextConst ENU = 'You cannot use the %1 %2 because your identification is not set up to process from this Responsibility Center.', FRA = 'Vous ne pouvez pas utiliser le %1 %2 parce que votre identification n''est pas mise en place pour traiter depuis ce centre de gestion.';
        Text2013660: TextConst ENU = 'cannot ne greater than %1.', FRA = 'Ne peut pas être supérieure à %1';
        Text2013661: TextConst ENU = 'cannot be lower than %1.', FRA = 'Ne peut pas être inferieur à %1';
        Text2013662: TextConst ENU = 'You cannot change %1 because the value is automatically calculated with %2.', FRA = 'Vous ne pouvez pas modifier %1 car la valeur est calculé automatiquement avec %2.';
        Text2013663: TextConst ENU = 'At least one item charge tax line must exist with the %1 %2.', FRA = 'Il doit exister au moins une ligne de type taxe avec le %1 %2.';
        Text2013664: TextConst ENU = 'You must specify %1 in %2 or %3 or %4 when %5 %6.', FRA = 'Vous devez spécifier %1 dans %2 ou %3 ou %4 quand %5 %6.';
        Text2013760: TextConst ENU = 'You cannot input more than %1 units because it is attached to %2 %3 as %4.', FRA = 'Vous ne pouvez pas entrer plus de %1 unités car il est attaché à %2 %3 comme %4.';
        Text2013761: TextConst ENU = 'You cannot modify because it is attached to %1 %2 as %3.', FRA = 'Vous ne pouvez pas modifier, car il est attaché à %1 %2 comme %3.';
        Text2013762: TextConst ENU = 'You cannot change %1 when %2 is %3.', FRA = 'Vous ne pouvez pas modifier %1 si %2 est %3.';
        //CustCheckDeposittLimit : Codeunit "Check Deposit Limit Mgt.";
        //DelayedLineMgt : Codeunit "Delayed Disc. & Promo  Mgt";
        //NoSeriesMgt : Codeunit NoSeriesManagement;
        //AADDocMgt : Codeunit "AAD Document Mgt.";
        //CommonItemChrgMgt : Codeunit "Common Item Charges Mgt.";
        BatchInsertCheckSuspended: Boolean;
        ForceDeleteItemCharges: Boolean;
        CompanySetupRead: Boolean;
        SaveCurrency: Record Currency;
        //PackingListLine : Record "Packing List Line";
        SaveTempSalesChargeLine: Record "Sales Line" temporary;
        SaveTempItemChrgAssgnSales: Record "Item Charge Assignment (Sales)" temporary;
        TransferExtText: Codeunit "Transfer Extended Text";
        //EmcsSetup : Record "EMCS Setup";
        //LocationGr : Record "Location Group";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        Text2013763: TextConst ENU = 'If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.', FRA = 'Si l''article porte des numéros de série ou de lot, alors vous devez utiliser le champ %1 dans la fenêtre %2.';
        Text2014260: TextConst ENU = 'You must specify %1 in %2 %3.', FRA = 'Vous devez indiquer %1 dans %2 %3.';
        Text2014261: TextConst ENU = 'The warehouse document %1 is already assigned to %2 %3.', FRA = 'Le document entrepôt %1 possède déjà un %2 %3.';
        dtfDummy: DateFormula;
        //GenPosSetup : Record "General Pos Setup";
        SkipValidationChargesSOM: Boolean;
        //ItemExcluCheckAvail : Codeunit "Item Exclusivity-Check";
        WhseSetup: Record "Warehouse Setup";
        TempSalesLineBO: Record "Sales Line" temporary;
        //LoyaltyCalcMgt : Codeunit "Sales Loyalty Calc. Mgt.";
        //LoyaltyCheckAvail : Codeunit "Loyalty Check Avail.";
        ServContract: Record "Service Contract Header";
        //ContractDIT : Record "Financial Contract Header";
        ContractGroup: Record "Contract Group";
        //ContractGroupDIT : Record "Financial Contract Group";
        //AppMgt : Codeunit ApplicationManagement;
        ForceDeleteDiscItemCharges: Boolean;
        Text2014262: TextConst ENU = 'You cannot modify or delete the line because it is associated with %1 %2 %3.', FRA = 'Vous ne pouvez pas modifier ou supprimer cette ligne car elle est associée à %1 %2 %3.';
        //EDIOutbox : Record "EDI Outbox Transaction";
        Text2014263: TextConst ENU = 'You cannot modify %4 because it is associated with %1 %2 %3.', FRA = 'Vous ne pouvez pas modifier %4 car ce champ est associée à %1 %2 %3.';
        //BomItemCharges : Codeunit "Bom Item Charges Mgt.";
        Text2014264: TextConst ENU = 'The quantity you are attempting to use is greater than the %1 remaining quantity in Line No. %2.', FRA = 'La quantité que vous essayez d''utiliser est plus grande que le quantité restante %1 dans la ligne %2.';
        //ItemQuotaCheckAvail : Codeunit "Item-Check Quota";
        UserSetupMgt: Codeunit "User Setup Management";
        RespCenter: Record "Responsibility Center";
        //PhysLocationGr : Record "Physical Location Group";
        //rFreeReasonCode : Record "Free Reason Code";
        //rPropertyServiceMgtSetup : Record "Property Service Mgt. Setup";
        SkipValidationDimensions: Boolean;
        Sign: Integer;
        Error002: TextConst ENU = 'When %1 was checked then you can not change it anymore./Revalidate the item no. ', FRA = 'Vous ne pouvez plus modifier %1 quand il a été vérifié./Revalider le code article. ';
        Error003: TextConst ENU = 'You may not modify%1 when the sales line is partly shipped / invoiced.', FRA = 'Vous ne pouvez plus modifier %1 quand la commande est partiellement expédiée / Facturée';
        Error004: Label 'You cannot change the %1 when the value has been filled in.';
        Text2014360: TextConst ENU = 'You cannot change %1 because the order line is associated with Event %2 line %3.', FRA = 'Vous ne pouvez pas modifier %1 car la ligne commande est associée à l''événement %2 ligne %3.';
        Text2014361: TextConst ENU = 'You cannot insert new line because order is associated with Event %1.', FRA = 'Vous ne pouvez pas inserer une nouvelle ligne car la commande est associée à l''événement %1.';
        _recSalesSetup: Record "Sales & Receivables Setup";
        Text2014362: TextConst ENU = 'You are not allowed to delete line associated to Event %1.', FRA = 'Vous n''êtes pas autorisé à supprimer la ligne associée à l''événement %1.';
        Err2036301: TextConst ENU = 'You cannot delete the order line because there are existing shipments.', FRA = 'Vous ne pouvez pas supprimer la ligne commande parce qu''il existe des expéditions.';
        Text2029610: TextConst ENU = 'You are modifying a line that has linked charges. You need to recalculate these charges manually.', FRA = 'La ligne que vous modifiez a des frais annexes liés. Vous devez recalculer ces frais annexes manuellement.';
        EventDocNo: Code[20];
        EventLineNo: Integer;
        blnDeleteFromSalesHeader: Boolean;
        NewBlnUpdateFromEvent: Boolean;
        PaymentTerms: Record "Payment Terms";
        ChangedFromWarehouse: Boolean;
        recSalesShipLine: Record "Sales Shipment Line";
        recSalesShiptHeader: Record "Sales Shipment Header";
        recSalesHeader: Record "Sales Header";
        recUserSetup: Record "User Setup";
        blnChangedfromHeader: Boolean;
        //recFinXLSetup : Record "Finance XL Setup";
        CalculatePer: Option Item,"Order";
        ItemLine: Record "Sales Line";
        //cduSalesHook : Codeunit "Sales Hook";
        //BCUPGRADE>>
        //To be checked after Drinkit instalation
        //InsertEmpts2SalesLnWithChrgItm : Codeunit InsertEmpts2SalesLnWithChrgItm;
        //BCUPGRADE<<
        Text2014063: Label 'The line for item %1 is set to Backorder. The remaining quantity will be moved to a blanket sales order when you post the shipment or activate function Process Backorder.';
        RPMDamageLossTrueErr: Label '%1 can be %2 when %3 is %4 and %5 is %6 or %7.';
        DifferentTINNoErr: Label 'It is not allowed to have different TIN Nos on %1 %2.';
        WhseShptLine: Record "Warehouse Shipment Line";
        WhseReceiptLine: Record "Warehouse Receipt Line";
    //Rec_FreeReasonCode : Record "Free Reason Code";
    //TempSalesLoyalty : Record "Sales Loyalty Point & Amount";
}

