tableextension 50158 BomBufferExtFND extends "BOM Buffer"
{
    // FINXL7.00.001 RBE 04/06/2013: Description from 50 to 80

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // DITW110.00.12 ALE 01/02/2018 NRQ#40156 Item availability by BOM for SKU BOM
    // HEI.01 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 05.09.2017
    //   # New function to calcutale BOM Structure on SKU lavel
    // HEI.02 DefectID #1394 IBM HORTOC01 19.01.2018
    //   #new field added "Parent Entry No."
    // HEI.03 RFC-CHG0257267 IBM.AB 15.10.2018
    //   # Code added to validate Active BOM Version
    // HEI.04 CHG2135085 SAHAL01      22.03.2022
    //   # Added Code to calculate cost on blank Version Code


    fields
    {
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            // OptionCaptionML = ENU = ',Item,Machine Center,Work Center,Resource', FRA = ',Article,Poste de charge,Centre de charge,Ressource';
        }
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Description';
        }
        modify("Unit of Measure Code")
        {
            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Variant Code")
        {
            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Replenishment System")
        {
            CaptionML = ENU = 'Replenishment System', FRA = 'Système réappro.';
            // OptionCaptionML = ENU = 'Purchase,Prod. Order,Transfer,Assembly', FRA = 'Achat,O.F.,Transfert,Assemblage';
        }
        modify(Indentation)
        {
            CaptionML = ENU = 'Indentation', FRA = 'Indentation';
        }
        modify("Is Leaf")
        {
            CaptionML = ENU = 'Is Leaf', FRA = 'Est un noeud terminal';
        }
        modify(Bottleneck)
        {
            CaptionML = ENU = 'Bottleneck', FRA = 'Goulot d''étranglement';
        }
        modify("Routing No.")
        {
            CaptionML = ENU = 'Routing No.', FRA = 'N° gamme';
        }
        modify("Production BOM No.")
        {
            CaptionML = ENU = 'Production BOM No.', FRA = 'N° nomenclature production';
        }
        modify("Lot Size")
        {
            CaptionML = ENU = 'Lot Size', FRA = 'Taille lot';
        }
        modify("Low-Level Code")
        {
            CaptionML = ENU = 'Low-Level Code', FRA = 'Code plus bas niveau';
        }
        modify("Rounding Precision")
        {
            CaptionML = ENU = 'Rounding Precision', FRA = 'Précision arrondi';
        }
        modify("Qty. per Parent")
        {
            CaptionML = ENU = 'Qty. per Parent', FRA = 'Qté par parent';
        }
        modify("Qty. per Top Item")
        {
            CaptionML = ENU = 'Qty. per Top Item', FRA = 'Qté par meilleur article';
        }
        modify("Able to Make Top Item")
        {
            CaptionML = ENU = 'Able to Make Top Item', FRA = 'Capable de fabriquer le meilleur article';
        }
        modify("Able to Make Parent")
        {
            CaptionML = ENU = 'Able to Make Parent', FRA = 'Capable de fabriquer le parent';
        }
        modify("Available Quantity")
        {
            CaptionML = ENU = 'Available Quantity', FRA = 'Quantité disponible';
        }
        modify("Gross Requirement")
        {
            CaptionML = ENU = 'Gross Requirement', FRA = 'Besoin brut';
        }
        modify("Scheduled Receipts")
        {
            CaptionML = ENU = 'Scheduled Receipts', FRA = 'Réceptions planifiées';
        }
        modify("Unused Quantity")
        {
            CaptionML = ENU = 'Unused Quantity', FRA = 'Quantité inutilisée';
        }
        modify("Lead Time Calculation")
        {
            CaptionML = ENU = 'Lead Time Calculation', FRA = 'Délai de réappro.';
        }
        modify("Lead-Time Offset")
        {
            CaptionML = ENU = 'Lead-Time Offset', FRA = 'Décalage du délai';
        }
        modify("Rolled-up Lead-Time Offset")
        {
            CaptionML = ENU = 'Rolled-up Lead-Time Offset', FRA = 'Décalage du délai multi-niveau';
        }
        modify("Needed by Date")
        {
            CaptionML = ENU = 'Needed by Date', FRA = 'Requis par date';
        }
        modify("Safety Lead Time")
        {
            CaptionML = ENU = 'Safety Lead Time', FRA = 'Délai de sécurité';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("Scrap %")
        {
            CaptionML = ENU = 'Scrap %', FRA = '% perte';
        }
        modify("Scrap Qty. per Parent")
        {
            CaptionML = ENU = 'Scrap Qty. per Parent', FRA = 'Qté perte par parent';
        }
        modify("Scrap Qty. per Top Item")
        {
            CaptionML = ENU = 'Scrap Qty. per Top Item', FRA = 'Qté perte par meilleur article';
        }
        modify("Resource Usage Type")
        {
            CaptionML = ENU = 'Resource Usage Type', FRA = 'Type d''utilisation des ressources';
            OptionCaptionML = ENU = 'Direct,Fixed', FRA = 'Direct,Fixe';
        }
        modify("Single-Level Material Cost")
        {
            CaptionML = ENU = 'Single-Level Material Cost', FRA = 'Coût matière mono-niveau';
        }
        modify("Single-Level Capacity Cost")
        {
            CaptionML = ENU = 'Single-Level Capacity Cost', FRA = 'Coût opératoire mono-niveau';
        }
        modify("Single-Level Subcontrd. Cost")
        {
            CaptionML = ENU = 'Single-Level Subcontrd. Cost', FRA = 'Coût s/traitance mono-niveau';
        }
        modify("Single-Level Cap. Ovhd Cost")
        {
            CaptionML = ENU = 'Single-Level Cap. Ovhd Cost', FRA = 'Frais gén. opérat. mono-niv.';
        }
        modify("Single-Level Mfg. Ovhd Cost")
        {
            CaptionML = ENU = 'Single-Level Mfg. Ovhd Cost', FRA = 'Frais gén. matière mono-niv.';
        }
        modify("Single-Level Scrap Cost")
        {
            CaptionML = ENU = 'Single-Level Scrap Cost', FRA = 'Coût perte mono-niveau';
        }
        modify("Rolled-up Material Cost")
        {
            CaptionML = ENU = 'Rolled-up Material Cost', FRA = 'Coût matière multi-niveau';
        }
        modify("Rolled-up Capacity Cost")
        {
            CaptionML = ENU = 'Rolled-up Capacity Cost', FRA = 'Coût opératoire multi-niveau';
        }
        modify("Rolled-up Subcontracted Cost")
        {
            CaptionML = ENU = 'Rolled-up Subcontracted Cost', FRA = 'Coût s/traitance multi-niv.';
        }
        modify("Rolled-up Capacity Ovhd. Cost")
        {
            CaptionML = ENU = 'Rolled-up Capacity Ovhd. Cost', FRA = 'Frais généraux opératoires multi-niveaux';
        }
        modify("Rolled-up Mfg. Ovhd Cost")
        {
            CaptionML = ENU = 'Rolled-up Mfg. Ovhd Cost', FRA = 'Frais gén. matière multi-niv.';
        }
        modify("Rolled-up Scrap Cost")
        {
            CaptionML = ENU = 'Rolled-up Scrap Cost', FRA = 'Coût perte multi-niveau';
        }
        modify("Total Cost")
        {
            CaptionML = ENU = 'Total Cost', FRA = 'Coût total';
        }
        modify("BOM Unit of Measure Code")
        {
            CaptionML = ENU = 'BOM Unit of Measure Code', FRA = 'Code unité nomenclature';
        }
        modify("Qty. per BOM Line")
        {
            CaptionML = ENU = 'Qty. per BOM Line', FRA = 'Ligne Qté par nomenclature';
        }
        field(50000; "Parent Entry No. FND"; Integer)
        {
            Caption = 'Parent Entry No.';
            Description = 'HEI.02';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        BOMVersion: Record "Production BOM Version";


    //Unsupported feature: PropertyModification on "Text001(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=The Low-level Code for Item %1 has not been calculated.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=The Low-level Code for Item %1 has not been calculated.;FRA=Le code faible niveau pour l'article %1 n'a pas été calculé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=The Quantity per. field in the BOM for Item %1 has not been set.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=The Quantity per. field in the BOM for Item %1 has not been set.;FRA=La Quantité par champ dans la nomenclature pour l'article %1 n'a pas été définie.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Routing %1 has not been certified.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Routing %1 has not been certified.;FRA=La gamme %1 n'a pas été certifiée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Production BOM %1 has not been certified.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Production BOM %1 has not been certified.;FRA=La nomenclature de production %1 n'a pas été certifiée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=Item %1 is not a BOM. Therefore, the Replenishment System field must be set to Purchase.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=Item %1 is not a BOM. Therefore, the Replenishment System field must be set to Purchase.;FRA=L'article %1 n'est pas une nomenclature. Par conséquent, le champ Système réappro. doit être défini sur Achat.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=Replenishment System for Item %1 is Assembly, but the item is not an assembly BOM. Verify that this is correct.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=Replenishment System for Item %1 is Assembly, but the item is not an assembly BOM. Verify that this is correct.;FRA=La valeur de Système réappro. pour l'article %1 est Assemblage, mais l'article n'est pas une nomenclature d'assemblage. Vérifiez que cela est correct.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=Replenishment System for Item %1 is Prod. Order, but the item does not have a production BOM. Verify that this is correct.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=Replenishment System for Item %1 is Prod. Order, but the item does not have a production BOM. Verify that this is correct.;FRA=La valeur de Système réappro. pour l'article %1 est O.F., mais l'article n'a pas de nomenclature de production. Vérifiez que cela est correct.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=Item %1 is a BOM, but the Replenishment System field is not set to Assembly or Prod. Order. Verify that the value is correct.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=Item %1 is a BOM, but the Replenishment System field is not set to Assembly or Prod. Order. Verify that the value is correct.;FRA=L'article %1 est une nomenclature, mais la valeur de Système réappro. n'est pas définie sur Assemblage ni O.F. Vérifiez que la valeur est correcte.;
    //Variable type has not been exported.

    var
        StockkeepingUnit2: Record "Stockkeeping Unit";
        StockkeepingUnit3: Record "Stockkeeping Unit";
        ForBlankVersionCode: Boolean;
        RunFromStockKeepingUnit: Boolean;

    procedure SetRunParam(StockkeepingUnit: Record "Stockkeeping Unit"; RumFromStockKeeping: Boolean)
    begin
        //HEI.01
        RunFromStockKeepingUnit := RumFromStockKeeping;
        StockkeepingUnit2 := StockkeepingUnit;
    end;

    procedure ActivateBlankVersionCode(IsBlankVersionCode: Boolean): Boolean
    begin
        //HEI.04>>
        ForBlankVersionCode := IsBlankVersionCode;
        //HEI.04<<
    end;
}

