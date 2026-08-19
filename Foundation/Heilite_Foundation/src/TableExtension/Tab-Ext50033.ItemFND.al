tableextension 50033 ItemExtFND extends Item
{
    // version NAVW110.0.00.18197,FINXL10.01,MANXL10.01,QXL9.00.001,DITW110.00.12A,HEI.28
    //HEI.01 FDD-GAPID043 IBM LAZARE02 05.07.2017
    //   # New fields: Batch Number Policy, Cross Plant Material Status
    //   # Set default value of field Product Group Code to INVTY
    // HEI.02 FDD-OTCGAP064 IBM.NAIKH01 10.0.2017 One unit of measure to be defined on the SKU level only
    // HEI.03 FDD PRDGAP038 IBM COSTES02 07.08.2017 Added new fields : Quantity Quality Hold,Quantity Unrestricted (Pass),Quantity Blocked (Fail)
    // HEI.05 FDD-SLSGAP001 IBM POENAB01 17.08.2017 # MDM Customer Card
    //   # New field for MDM integration: WHT Product Posting Group
    // HEI.06 FDD-PRDGAP36B IBM.ISYED01 22.08.2017 Item LifeCycle Status
    //   # New feild added to the table "Cross-Plant Material Status" and "Plant-Specific Material Status"
    //   # Added code logic to  "Cross-Plant Material Status" to block customer
    // HEI.07 FDD-BPMGAP014 IBM.ISYED01 24.08.2017 CIL
    //   # New feild added to the table "CIL ID Code","CIL ID2 Code"
    // HEI.08 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 06.09.2017
    //   New field "Production Forecast Quantity HL"
    // HEI.09 FDD-RFC141 IBM LAZARE02 20.09.2017
    //   # New fields for Maximo
    // HEI.10 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    //   # New fields
    // HEI.11 FDD-GAPID043 IBM LAZARE02 12.10.2017
    //   # Add code to Type OnValidate to skip code if the same Type is validated
    // HEI.12 Defect 663 IBM HORTOC01 19.10.2017
    //   # change flowfield formula by adding Lot No <>'' condition
    // HEI.13 Defect #1328 #1329 IBM NASTAA02 19.12.2017 # Missing fields in file creation
    //   # Added new field: 50020 - "Product Group Code R1"
    // HEI.14 INC0805375 IBM LAZARE02 06.06.2018
    //   # Check if rec <> xrec before validating Inventory Value Zero field
    // HEI.15 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field created: 50021 - Full BOM Counterpart
    // HEI.16 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Field created: 50022 - Available Inv. (Whse)
    // HEI.17 CHG2023313 IBM KUMARN15 22.08.2019
    //   # New field created - Uavailable Inv. (Whse)
    // HEI.18 CHG2013123 IBM GAVANM01 30.10.2019
    //   # Add code to skip the function TestNoOpenEntriesExist when not GUIALLOWED
    // HEI.19 CHG2079720 IBM.LS 21.09.2020
    //   # Code modified.
    // HEI.20 CHG2079720 IBM.LS 06.10.2020
    //   # Code modified.
    // HEI.21 CHG2095188 IBM SAXENA03 02.01.2021
    //   # Remove Assembly BOM field from Field Groups
    // HEI.22 CHG2098084 IBM.LS 12.03.2021
    //   # Added and Uncommented Code.
    // HEI.23 HB2279-CHG2111642 - IBM NANDIS01 - 27.05.2021 - Technical fix to enable Extract Content Reg. for Purchased Materials
    //   # Code blocked and added in function - TestNoEntriesExist, Error should not come while changing strength method of item
    //   # Code added under field validate trigger - "Strength Spec. Value" and "Strength Spec. Code"
    // HEI.24 CHG2147859 SAHAL01 22.07.2022
    //   # Created New Fields: 50030 - Item Interface Code for Astro
    //                         50031 - Item Parked for Astro
    //                         50032 - Last Parked Date for Astro
    //                         50033 - Last Parked Time for Astro
    // HEI.25 CHG2202557/INC4640449 IBM.PRASAA03 16.05.2023 Sync Issue Mendix to Heilite
    //   # Checking the Strength Specific Code Validation is causing the issue from mendix to heilite.
    // HEI.26 CHG2202557/INC4640449 IBM.PRASAA03 22.05.2023 Sync Issue Mendix to Heilite
    //   # Removed HEI.25 Version Code.
    //   # Changing validation in Strength Specific Value Onvalidate trigger.
    // HEI.27 CHG2207110 SAHAL01 28.06.2023 Update Standard Cost Aging Info table with blocked/unblocked information
    //   # Added Code
    // HEI.28 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New Field created #H&S Levy Tax Posting Group

    //------------------------------------------------------------------------
    // BC Upgrade Kamnay01 Item table also extend in Heineken_RTR extension because for adding CIL ID Code and CIL ID2 Code fields to Item table 
    //Bc Upgrade YADAVM09 New field added 50035#"Product Group Code" for item product group functionality
    //BC UPGRADE PATHAA02 23.01.26 # Commented Astro Fields as they are not required-FAT

    // BC Upgrade MISHRS14 >>
    // Changed datatype of field-50018 "Item Type" from option to enum to avoid implicit conversion and blocked option therefore for CU-54002(DTW)
    // Changed datatype of field-50016 "RPM Solution" from option to enum to avoid implicit conversion and blocked option therefore for CU-54002(DTW)
    // BC Upgrade MISHRS14 <<

    //HEI.28 PATHAA02 13.03.26 #Inventory UoM Fucntionality
    //Moved DIT field "Inventory Unit of Measure" from 2014427 to 50051 
    //added code OnValidate trigger to set Inventory Unit of Measure same as Base Unit of Measure if the field is left blank while validating the record.
    // BC Upgrade Kamnay01 >> Added new field 50052 "Production Unit of Measure" and added code in Base Unit of Measure OnValidate trigger to set Production Unit of Measure.

    fields
    {


        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("No."), Text2014310_1); //BC Upgrade PATHAA02 -Function is not found(DIT)
        }
        modify("No. 2")
        {
            CaptionML = ENU = 'No. 2', FRA = 'N° 2';
            trigger OnAfterValidate()
            var
                InventorySetup: Record "Inventory Setup";  //---BC Upgrade KAMNAY01>>
            begin
                //---BC Upgrade KAMNAY01>>
                //HEI.01>>
                InventorySetup.GET();
                IF InventorySetup."Item Global ID Cross Ref. FND" THEN;
                //HEI.01<<
                //---BC Upgrade KAMNAY01<<

            end;
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Search Description")
        {
            CaptionML = ENU = 'Search Description', FRA = 'Désignation de recherche';
        }
        modify("Description 2")
        {
            CaptionML = ENU = 'Description 2', FRA = 'Désignation 2';
        }
        modify("Assembly BOM")
        {

            //Unsupported feature: Change CalcFormula on ""Assembly BOM"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Assembly BOM', FRA = 'Nomenclature d''assemblage';
        }
        modify("Base Unit of Measure")
        {
            CaptionML = ENU = 'Base Unit of Measure', FRA = 'Unité de base';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //BC Upgrade Kamnay01 >>
                "Production Unit of Measure FND" := "Base Unit of Measure";
                //BC Upgrade Kamnay01 <<

            end;
        }
        //BC Upgrade Kamnay01 >>07/04/2026 FDD - DTW011
        modify("Strength 3 Value 101FDW")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.23>>
                IF ("Strength 3 Value 101FDW" <> xRec."Strength 3 Value 101FDW") AND GUIALLOWED THEN
                    TestNoEntriesExist(FIELDCAPTION("Strength 3 Value 101FDW"));
                //HEI.23<<
            end;
        }
        //BC Upgrade Kamnay01 <<07/04/2026 FDD - DTW011
        modify("Price Unit Conversion")
        {
            CaptionML = ENU = 'Price Unit Conversion', FRA = 'Conversion unité de prix';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = 'Inventory,Service', FRA = 'Stock,Service';
            trigger OnAfterValidate()
            var
            begin
                //---BC Upgrade KAMNAY01>>
                //HEI.11>>
                IF Type = xRec.Type THEN
                    EXIT;
                //HEI.11<<
                //---BC Upgrade KAMNAY01>>
            end;
        }
        modify("Inventory Posting Group")
        {
            CaptionML = ENU = 'Inventory Posting Group', FRA = 'Groupe compta. stock';
        }
        modify("Shelf No.")
        {
            CaptionML = ENU = 'Shelf No.', FRA = 'N° emplacement';
        }
        modify("Item Disc. Group")
        {
            CaptionML = ENU = 'Item Disc. Group', FRA = 'Groupe rem. article';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Item Disc. Group"), Text2014310_14);  //BC Upgrade PATHAA02 -Function is not found(DIT)
        }
        modify("Allow Invoice Disc.")
        {

            //Unsupported feature: Change InitValue on ""Allow Invoice Disc."(Field 15)". Please convert manually.

            CaptionML = ENU = 'Allow Invoice Disc.', FRA = 'Remise facture autorisée';
        }
        modify("Statistics Group")
        {
            CaptionML = ENU = 'Statistics Group', FRA = 'Groupe statistiques';
        }
        modify("Commission Group")
        {
            CaptionML = ENU = 'Commission Group', FRA = 'Groupe commissions';
        }
        modify("Unit Price")
        {
            CaptionML = ENU = 'Unit Price', FRA = 'Prix unitaire';
        }
        modify("Price/Profit Calculation")
        {
            CaptionML = ENU = 'Price/Profit Calculation', FRA = 'Calcul prix ou marge';
            //OptionCaptionML = ENU = 'Profit=Price-Cost,Price=Cost+Profit,No Relationship', FRA = 'Marge=Prix-Coût,Prix=Coût+Marge,Sans relation';
        }
        modify("Profit %")
        {
            CaptionML = ENU = 'Profit %', FRA = '% marge sur vente';
        }
        modify("Costing Method")
        {
            CaptionML = ENU = 'Costing Method', FRA = 'Mode évaluation stock';
            //OptionCaptionML = ENU = 'FIFO,LIFO,Specific,Average,Standard', FRA = 'FIFO,LIFO,Spécifique,Moyen,Standard';
        }
        modify("Unit Cost")
        {
            CaptionML = ENU = 'Unit Cost', FRA = 'Coût unitaire';
        }
        modify("Standard Cost")
        {
            CaptionML = ENU = 'Standard Cost', FRA = 'Coût standard';
        }
        modify("Last Direct Cost")
        {
            CaptionML = ENU = 'Last Direct Cost', FRA = 'Dernier coût direct';
        }
        modify("Indirect Cost %")
        {
            CaptionML = ENU = 'Indirect Cost %', FRA = '% coût indirect';
        }
        modify("Cost is Adjusted")
        {

            //Unsupported feature: Change InitValue on ""Cost is Adjusted"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Cost is Adjusted', FRA = 'Coût ajusté';
        }
        modify("Allow Online Adjustment")
        {

            //Unsupported feature: Change InitValue on ""Allow Online Adjustment"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Allow Online Adjustment', FRA = 'Autoriser l''ajustement en ligne';
        }
        modify("Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', FRA = 'N° fournisseur';
        }
        modify("Vendor Item No.")
        {
            CaptionML = ENU = 'Vendor Item No.', FRA = 'Référence fournisseur';
        }
        modify("Lead Time Calculation")
        {
            CaptionML = ENU = 'Lead Time Calculation', FRA = 'Délai de réappro.';
        }
        modify("Reorder Point")
        {
            CaptionML = ENU = 'Reorder Point', FRA = 'Point de commande';
        }
        modify("Maximum Inventory")
        {
            CaptionML = ENU = 'Maximum Inventory', FRA = 'Stock maximum';
        }
        modify("Reorder Quantity")
        {
            CaptionML = ENU = 'Reorder Quantity', FRA = 'Quantité de réappro.';
        }
        modify("Alternative Item No.")
        {

            //Unsupported feature: Change TableRelation on ""Alternative Item No."(Field 37)". Please convert manually.

            CaptionML = ENU = 'Alternative Item No.', FRA = 'Référence de remplacement';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Alternative Item No."), Text2014310_37);  //BC Upgrade PATHAA02 -Function is not found(DIT)
        }
        modify("Unit List Price")
        {
            CaptionML = ENU = 'Unit List Price', FRA = 'Prix unitaire catalogue';
        }
        modify("Duty Due %")
        {
            CaptionML = ENU = 'Duty Due %', FRA = 'Droits de douane (%)';
        }
        modify("Duty Code")
        {
            CaptionML = ENU = 'Duty Code', FRA = 'Code taxe';
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
        modify(Durability)
        {
            CaptionML = ENU = 'Durability', FRA = 'Durabilité';
        }
        modify("Freight Type")
        {
            CaptionML = ENU = 'Freight Type', FRA = 'Type fret';
        }
        modify("Tariff No.")
        {
            CaptionML = ENU = 'Tariff No.', FRA = 'Nomenclature produits';
        }
        modify("Duty Unit Conversion")
        {
            CaptionML = ENU = 'Duty Unit Conversion', FRA = 'Unité de conversion douanière';
        }
        modify("Country/Region Purchased Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region Purchased Code"(Field 49)". Please convert manually.

            CaptionML = ENU = 'Country/Region Purchased Code', FRA = 'Code pays/région achat';
        }
        modify("Budget Quantity")
        {
            CaptionML = ENU = 'Budget Quantity', FRA = 'Quantité budgétée';
        }
        modify("Budgeted Amount")
        {
            CaptionML = ENU = 'Budgeted Amount', FRA = 'Montant budgété';
        }
        modify("Budget Profit")
        {
            CaptionML = ENU = 'Budget Profit', FRA = 'Marge budgétée';
        }
        modify(Comment)
        {

            //Unsupported feature: Change CalcFormula on "Comment(Field 53)". Please convert manually.

            CaptionML = ENU = 'Comment', FRA = 'Commentaires';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
            //BC Upgrade Gunrem01>> Big fix of DTW 20-04-2026
            trigger OnBeforeValidate()
            var
                UserSetup: Record "User Setup";
            begin
                if Rec.Blocked = false then begin

                    if UserSetup.Get(UserId) then begin
                        if not UserSetup."Release Item FND" then
                            Error('You do not have permission to unblock items.');
                    end else
                        Error('User Setup not found.');
                end;
            end;
            //BC Upgrade Gunrem01<< Big fix of DTW 20-04-2026

            //BC Upgrade KAMNAY01 >>
            trigger OnAfterValidate()
            var
                StdCostAgingInfoL: Record "Standard Cost Aging Info FND";
            begin
                StdCostAgingInfoL.SETCURRENTKEY("Item No.");
                StdCostAgingInfoL.SETRANGE("Item No.", "No.");
                IF StdCostAgingInfoL.findset(false) THEN BEGIN
                    StdCostAgingInfoL.MODIFYALL(Blocked, Blocked, FALSE);
                    StdCostAgingInfoL.MODIFYALL("Block or Unblock Date", TODAY, FALSE);
                end;
                //HEI.27

            end;
            //BC Upgrade KAMNAY01<<
        }
        modify("Cost is Posted to G/L")
        {

            //Unsupported feature: Change CalcFormula on ""Cost is Posted to G/L"(Field 55)". Please convert manually.

            CaptionML = ENU = 'Cost is Posted to G/L', FRA = 'Le coût est validé en comptabilité';
        }
        modify("Last Date Modified")
        {
            CaptionML = ENU = 'Last Date Modified', FRA = 'Date dern. modification';
        }
        modify("Last Time Modified")
        {
            CaptionML = ENU = 'Last Time Modified', FRA = 'Heure dern. modification';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Global Dimension 1 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Filter"(Field 65)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Filter', FRA = 'Filtre axe principal 1';
        }
        modify("Global Dimension 2 Filter")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Filter"(Field 66)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Filter', FRA = 'Filtre axe principal 2';
        }
        modify("Location Filter")
        {
            CaptionML = ENU = 'Location Filter', FRA = 'Filtre magasin';
        }
        modify(Inventory)
        {

            //Unsupported feature: Change CalcFormula on "Inventory(Field 68)". Please convert manually.

            CaptionML = ENU = 'Inventory', FRA = 'Stocks';
        }
        modify("Net Invoiced Qty.")
        {

            //Unsupported feature: Change CalcFormula on ""Net Invoiced Qty."(Field 69)". Please convert manually.

            CaptionML = ENU = 'Net Invoiced Qty.', FRA = 'Solde quantités facturées';
        }
        modify("Net Change")
        {

            //Unsupported feature: Change CalcFormula on ""Net Change"(Field 70)". Please convert manually.

            CaptionML = ENU = 'Net Change', FRA = 'Solde période';
        }
        modify("Purchases (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Purchases (Qty.)"(Field 71)". Please convert manually.

            CaptionML = ENU = 'Purchases (Qty.)', FRA = 'Achats (qté)';
        }
        modify("Sales (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales (Qty.)"(Field 72)". Please convert manually.

            CaptionML = ENU = 'Sales (Qty.)', FRA = 'Ventes (qté)';
        }
        modify("Positive Adjmt. (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Positive Adjmt. (Qty.)"(Field 73)". Please convert manually.

            CaptionML = ENU = 'Positive Adjmt. (Qty.)', FRA = 'Ajust. positif (qté)';
        }
        modify("Negative Adjmt. (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Negative Adjmt. (Qty.)"(Field 74)". Please convert manually.

            CaptionML = ENU = 'Negative Adjmt. (Qty.)', FRA = 'Ajust. négatif (qté)';
        }
        modify("Purchases (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Purchases (LCY)"(Field 77)". Please convert manually.

            CaptionML = ENU = 'Purchases (LCY)', FRA = 'Achats DS';
        }
        modify("Sales (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales (LCY)"(Field 78)". Please convert manually.

            CaptionML = ENU = 'Sales (LCY)', FRA = 'Ventes DS';
        }
        modify("Positive Adjmt. (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Positive Adjmt. (LCY)"(Field 79)". Please convert manually.

            CaptionML = ENU = 'Positive Adjmt. (LCY)', FRA = 'Ajust. positif DS';
        }
        modify("Negative Adjmt. (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Negative Adjmt. (LCY)"(Field 80)". Please convert manually.

            CaptionML = ENU = 'Negative Adjmt. (LCY)', FRA = 'Ajust. négatif DS';
        }
        modify("COGS (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""COGS (LCY)"(Field 83)". Please convert manually.

            CaptionML = ENU = 'COGS (LCY)', FRA = 'Val. sortie stock DS';
        }
        modify("Qty. on Purch. Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Purch. Order"(Field 84)". Please convert manually.

            CaptionML = ENU = 'Qty. on Purch. Order', FRA = 'Qté sur commande achat';
        }
        modify("Qty. on Sales Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Sales Order"(Field 85)". Please convert manually.

            CaptionML = ENU = 'Qty. on Sales Order', FRA = 'Qté sur commande vente';

            //Unsupported feature: Change Description on ""Qty. on Sales Order"(Field 85)". Please convert manually.

        }
        modify("Price Includes VAT")
        {
            CaptionML = ENU = 'Price Includes VAT', FRA = 'Prix TTC';
        }
        modify("Drop Shipment Filter")
        {
            CaptionML = ENU = 'Drop Shipment Filter', FRA = 'Filtre livraison directe';
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            CaptionML = ENU = 'VAT Bus. Posting Gr. (Price)', FRA = 'Gpe compta. marché TVA (prix)';
        }
        modify("Gen. Prod. Posting Group")
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group', FRA = 'Groupe compta. produit';
        }
        modify(Picture)
        {
            CaptionML = ENU = 'Picture', FRA = 'Image';
        }
        modify("Transferred (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Transferred (Qty.)"(Field 93)". Please convert manually.

            CaptionML = ENU = 'Transferred (Qty.)', FRA = 'Quantité transférée';
        }
        modify("Transferred (LCY)")
        {

            //Unsupported feature: Change CalcFormula on ""Transferred (LCY)"(Field 94)". Please convert manually.

            CaptionML = ENU = 'Transferred (LCY)', FRA = 'Montant transféré DS';
        }
        modify("Country/Region of Origin Code")
        {

            //Unsupported feature: Change TableRelation on ""Country/Region of Origin Code"(Field 95)". Please convert manually.

            CaptionML = ENU = 'Country/Region of Origin Code', FRA = 'Code pays/région origine';
        }
        modify("Automatic Ext. Texts")
        {
            CaptionML = ENU = 'Automatic Ext. Texts', FRA = 'Textes étendus automatiques';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify("Tax Group Code")
        {
            CaptionML = ENU = 'Tax Group Code', FRA = 'Code groupe taxes';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify(Reserve)
        {
            CaptionML = ENU = 'Reserve', FRA = 'Réserver';
            //OptionCaptionML = ENU = 'Never,Optional,Always', FRA = 'Jamais,Manuel,Toujours';
        }
        modify("Reserved Qty. on Inventory")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. on Inventory"(Field 101)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. on Inventory', FRA = 'Quantité réservée sur stock';
        }
        modify("Reserved Qty. on Purch. Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. on Purch. Orders"(Field 102)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. on Purch. Orders', FRA = 'Quantité réservée cdes achat';
        }
        modify("Reserved Qty. on Sales Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. on Sales Orders"(Field 103)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. on Sales Orders', FRA = 'Quantité réservée cdes vente';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 105)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 106)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Res. Qty. on Outbound Transfer")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on Outbound Transfer"(Field 107)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on Outbound Transfer', FRA = 'Qté rés. désenlogt transfert';
        }
        modify("Res. Qty. on Inbound Transfer")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on Inbound Transfer"(Field 108)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on Inbound Transfer', FRA = 'Qté rés. enlogt transfert';
        }
        modify("Res. Qty. on Sales Returns")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on Sales Returns"(Field 109)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on Sales Returns', FRA = 'Qté réserv. sur retours vente';
        }
        modify("Res. Qty. on Purch. Returns")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on Purch. Returns"(Field 110)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on Purch. Returns', FRA = 'Qté réserv. sur retours achat';
        }
        modify("Stockout Warning")
        {
            CaptionML = ENU = 'Stockout Warning', FRA = 'Alerte rupture stock';
            OptionCaptionML = ENU = 'Default,No,Yes', FRA = 'Par défaut,Non,Oui';
        }
        modify("Prevent Negative Inventory")
        {
            CaptionML = ENU = 'Prevent Negative Inventory', FRA = 'Éviter stock négatif';
            OptionCaptionML = ENU = 'Default,No,Yes', FRA = 'Par défaut,Non,Oui';
        }
        modify("Cost of Open Production Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Cost of Open Production Orders"(Field 200)". Please convert manually.

            CaptionML = ENU = 'Cost of Open Production Orders', FRA = 'Coût des O.F. ouverts';
        }
        modify("Application Wksh. User ID")
        {
            CaptionML = ENU = 'Application Wksh. User ID', FRA = 'Code utilisateur de la feuille lettrage';
        }
        modify("Assembly Policy")
        {
            CaptionML = ENU = 'Assembly Policy', FRA = 'Politique d''assemblage';
            // OptionCaptionML = ENU = 'Assemble-to-Stock,Assemble-to-Order', FRA = 'Assemblage avant entreposage,Assemblage à la commande';
        }
        modify("Res. Qty. on Assembly Order")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on Assembly Order"(Field 929)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on Assembly Order', FRA = 'Qté rés. sur ordre d''assemblage';
        }
        modify("Res. Qty. on  Asm. Comp.")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on  Asm. Comp."(Field 930)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on  Asm. Comp.', FRA = 'Qté rés. sur composant d''assemblage';
        }
        modify("Qty. on Assembly Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Assembly Order"(Field 977)". Please convert manually.

            CaptionML = ENU = 'Qty. on Assembly Order', FRA = 'Qté sur ordre d''assemblage';
        }
        modify("Qty. on Asm. Component")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Asm. Component"(Field 978)". Please convert manually.

            CaptionML = ENU = 'Qty. on Asm. Component', FRA = 'Qté sur composant d''assemblage';
        }
        modify("Qty. on Job Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Job Order"(Field 1001)". Please convert manually.

            CaptionML = ENU = 'Qty. on Job Order', FRA = 'Qté sur ordre de travail';
        }
        modify("Res. Qty. on Job Order")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on Job Order"(Field 1002)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on Job Order', FRA = 'Qté rés. sur ordre de travail';
        }
        modify(GTIN)
        {
            CaptionML = ENU = 'GTIN', FRA = 'GTIN';
        }
        modify("Default Deferral Template Code")
        {
            CaptionML = ENU = 'Default Deferral Template Code', FRA = 'Code modèle échelonnement par défaut';
        }
        modify("Low-Level Code")
        {
            CaptionML = ENU = 'Low-Level Code', FRA = 'Code plus bas niveau';
        }
        modify("Lot Size")
        {
            CaptionML = ENU = 'Lot Size', FRA = 'Taille lot';
        }
        modify("Serial Nos.")
        {
            CaptionML = ENU = 'Serial Nos.', FRA = 'N° de série';
        }
        modify("Last Unit Cost Calc. Date")
        {
            CaptionML = ENU = 'Last Unit Cost Calc. Date', FRA = 'Date dern. calcul coût unitaire';
        }
        modify("Rolled-up Material Cost")
        {
            CaptionML = ENU = 'Rolled-up Material Cost', FRA = 'Coût matière multi-niveau';
        }
        modify("Rolled-up Capacity Cost")
        {
            CaptionML = ENU = 'Rolled-up Capacity Cost', FRA = 'Coût opératoire multi-niveau';
        }
        modify("Scrap %")
        {
            CaptionML = ENU = 'Scrap %', FRA = '% perte';
        }
        modify("Inventory Value Zero")
        {
            CaptionML = ENU = 'Inventory Value Zero', FRA = 'Exclure évaluation stock';
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //---BC Upgrade KAMNAY01>>
                //HEI.14>>
                IF "Inventory Value Zero" <> xRec."Inventory Value Zero" THEN
                    CheckForProductionOutput("No.");
                //HEI.14<<
                //---BC Upgrade KAMNAY01<<
            end;
        }
        modify("Discrete Order Quantity")
        {
            CaptionML = ENU = 'Discrete Order Quantity', FRA = 'Quantité commande discrète';
        }
        modify("Minimum Order Quantity")
        {
            CaptionML = ENU = 'Minimum Order Quantity', FRA = 'Qté minimum commande';
        }
        modify("Maximum Order Quantity")
        {
            CaptionML = ENU = 'Maximum Order Quantity', FRA = 'Qté maximum commande';
        }
        modify("Safety Stock Quantity")
        {
            CaptionML = ENU = 'Safety Stock Quantity', FRA = 'Stock de sécurité';
        }
        modify("Order Multiple")
        {
            CaptionML = ENU = 'Order Multiple', FRA = 'Commandé par';
        }
        modify("Safety Lead Time")
        {
            CaptionML = ENU = 'Safety Lead Time', FRA = 'Délai de sécurité';
        }
        modify("Flushing Method")
        {
            CaptionML = ENU = 'Flushing Method', FRA = 'Méthode consommation';
            //OptionCaptionML = ENU = 'Manual,Forward,Backward,Pick + Forward,Pick + Backward', FRA = 'Manuelle,Pré-déduction,Post-déduction,Prélèvement + Pré-déduction,Prélèvement + Post-déduction';
        }
        modify("Replenishment System")
        {
            CaptionML = ENU = 'Replenishment System', FRA = 'Système réappro.';
            //OptionCaptionML = ENU = 'Purchase,Prod. Order,,Assembly', FRA = 'Achat,O.F.,,Assemblage';
        }
        modify("Scheduled Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Scheduled Receipt (Qty.)"(Field 5420)". Please convert manually.

            CaptionML = ENU = 'Scheduled Receipt (Qty.)', FRA = 'Réception planifiée (qté)';
        }
        // modify("Scheduled Need (Qty.)")
        //{

        //Unsupported feature: Change CalcFormula on ""Scheduled Need (Qty.)"(Field 5421)". Please convert manually.

        //  CaptionML = ENU = 'Scheduled Need (Qty.)', FRA = 'Besoin planifié (qté)';
        // }
        modify("Rounding Precision")
        {
            CaptionML = ENU = 'Rounding Precision', FRA = 'Précision arrondi';
        }
        modify("Bin Filter")
        {

            //Unsupported feature: Change TableRelation on ""Bin Filter"(Field 5423)". Please convert manually.

            CaptionML = ENU = 'Bin Filter', FRA = 'Filtre emplacement';
        }
        modify("Variant Filter")
        {

            //Unsupported feature: Change TableRelation on ""Variant Filter"(Field 5424)". Please convert manually.

            CaptionML = ENU = 'Variant Filter', FRA = 'Filtre variante';
        }
        modify("Sales Unit of Measure")
        {

            //Unsupported feature: Change TableRelation on ""Sales Unit of Measure"(Field 5425)". Please convert manually.

            CaptionML = ENU = 'Sales Unit of Measure', FRA = 'Unité de vente';
        }
        modify("Purch. Unit of Measure")
        {

            //Unsupported feature: Change TableRelation on ""Purch. Unit of Measure"(Field 5426)". Please convert manually.

            CaptionML = ENU = 'Purch. Unit of Measure', FRA = 'Unité d''achat';
        }
        modify("Time Bucket")
        {
            CaptionML = ENU = 'Time Bucket', FRA = 'Période de vérification';
        }
        modify("Reserved Qty. on Prod. Order")
        {

            //Unsupported feature: Change CalcFormula on ""Reserved Qty. on Prod. Order"(Field 5429)". Please convert manually.

            CaptionML = ENU = 'Reserved Qty. on Prod. Order', FRA = 'Qté réservée sur O.F.';
        }
        modify("Res. Qty. on Prod. Order Comp.")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on Prod. Order Comp."(Field 5430)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on Prod. Order Comp.', FRA = 'Qté rés. sur comp. O.F.';
        }
        modify("Res. Qty. on Req. Line")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on Req. Line"(Field 5431)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on Req. Line', FRA = 'Qté rés. sur dem. achat';
        }
        modify("Reordering Policy")
        {
            CaptionML = ENU = 'Reordering Policy', FRA = 'Méthode réapprovisionnement';
            // OptionCaptionML = ENU = ' ,Fixed Reorder Qty.,Maximum Qty.,Order,Lot-for-Lot', FRA = ' ,Qté fixe de commande,Qté maximum,Commande,Lot pour lot';
        }
        modify("Include Inventory")
        {
            CaptionML = ENU = 'Include Inventory', FRA = 'Inclure stock';
        }
        modify("Manufacturing Policy")
        {
            CaptionML = ENU = 'Manufacturing Policy', FRA = 'Mode de lancement';
            // OptionCaptionML = ENU = 'Make-to-Stock,Make-to-Order', FRA = 'Fabrication sur stock,Fabrication à la commande';
        }
        modify("Rescheduling Period")
        {
            CaptionML = ENU = 'Rescheduling Period', FRA = 'Période de replanification';
        }
        modify("Lot Accumulation Period")
        {
            CaptionML = ENU = 'Lot Accumulation Period', FRA = 'Période de regroupement de lots';
        }
        modify("Dampener Period")
        {
            CaptionML = ENU = 'Dampener Period', FRA = 'Période seuil';
        }
        modify("Dampener Quantity")
        {
            CaptionML = ENU = 'Dampener Quantity', FRA = 'Quantité tampon';
        }
        modify("Overflow Level")
        {
            CaptionML = ENU = 'Overflow Level', FRA = 'Niveau de dépassement de capacité';
        }
        modify("Planning Transfer Ship. (Qty).")
        {

            //Unsupported feature: Change CalcFormula on ""Planning Transfer Ship. (Qty)."(Field 5449)". Please convert manually.

            CaptionML = ENU = 'Planning Transfer Ship. (Qty).', FRA = 'Planning expédition transfert (Qté).';
        }
        modify("Planning Worksheet (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Planning Worksheet (Qty.)"(Field 5450)". Please convert manually.

            CaptionML = ENU = 'Planning Worksheet (Qty.)', FRA = 'Feuille planning (Qté)';
        }
        modify("Stockkeeping Unit Exists")
        {

            //Unsupported feature: Change CalcFormula on ""Stockkeeping Unit Exists"(Field 5700)". Please convert manually.

            CaptionML = ENU = 'Stockkeeping Unit Exists', FRA = 'Point de stock';
        }
        modify("Manufacturer Code")
        {
            CaptionML = ENU = 'Manufacturer Code', FRA = 'Code fabricant';
        }
        modify("Item Category Code")
        {
            CaptionML = ENU = 'Item Category Code', FRA = 'Code catégorie article';
        }
        modify("Created From Nonstock Item")
        {
            CaptionML = ENU = 'Created From Nonstock Item', FRA = 'Lien article non stocké';
        }
        //BC Upgrade PATHAA02 -Field is Deprecated >>
        // modify("Product Group Code")  
        // {
        //     //Unsupported feature: Change TableRelation on ""Product Group Code"(Field 5704)". Please convert manually.
        //     CaptionML = ENU = 'Product Group Code', FRA = 'Code groupe produits';
        // }
        //BC Upgrade PATHAA02 -Field is Deprecated <<
        modify("Substitutes Exist")
        {

            //Unsupported feature: Change CalcFormula on ""Substitutes Exist"(Field 5706)". Please convert manually.

            CaptionML = ENU = 'Substitutes Exist', FRA = 'Article de substitution';
        }
        modify("Qty. in Transit")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. in Transit"(Field 5707)". Please convert manually.

            CaptionML = ENU = 'Qty. in Transit', FRA = 'Qté en transit';
        }
        modify("Trans. Ord. Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Trans. Ord. Receipt (Qty.)"(Field 5708)". Please convert manually.

            CaptionML = ENU = 'Trans. Ord. Receipt (Qty.)', FRA = 'Réception transfert (qté)';
        }
        modify("Trans. Ord. Shipment (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Trans. Ord. Shipment (Qty.)"(Field 5709)". Please convert manually.

            CaptionML = ENU = 'Trans. Ord. Shipment (Qty.)', FRA = 'Expédition transfert (qté)';
        }
        modify("Qty. Assigned to ship")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. Assigned to ship"(Field 5776)". Please convert manually.

            CaptionML = ENU = 'Qty. Assigned to ship', FRA = 'Qté affectée à expédier';
        }
        modify("Qty. Picked")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. Picked"(Field 5777)". Please convert manually.

            CaptionML = ENU = 'Qty. Picked', FRA = 'Qté prélevée';
        }
        modify("Service Item Group")
        {
            CaptionML = ENU = 'Service Item Group', FRA = 'Gpe articles de service';
        }
        modify("Qty. on Service Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Service Order"(Field 5901)". Please convert manually.

            CaptionML = ENU = 'Qty. on Service Order', FRA = 'Qté sur commande service';
        }
        modify("Res. Qty. on Service Orders")
        {

            //Unsupported feature: Change CalcFormula on ""Res. Qty. on Service Orders"(Field 5902)". Please convert manually.

            CaptionML = ENU = 'Res. Qty. on Service Orders', FRA = 'Qté rés. sur commande service';
        }
        modify("Item Tracking Code")
        {
            CaptionML = ENU = 'Item Tracking Code', FRA = 'Code traçabilité';
            // CaptionClass = GetCaptionClassPM(FIELDCAPTION("Item Tracking Code"), Text2014310_6500); //BC Upgrade PATHAA02 -Function is not found(DIT)
        }
        modify("Lot Nos.")
        {
            CaptionML = ENU = 'Lot Nos.', FRA = 'N° lot';
        }
        modify("Expiration Calculation")
        {
            CaptionML = ENU = 'Expiration Calculation', FRA = 'Calcul péremption';
        }
        modify("Lot No. Filter")
        {
            CaptionML = ENU = 'Lot No. Filter', FRA = 'Filtre n° lot';
        }
        modify("Serial No. Filter")
        {
            CaptionML = ENU = 'Serial No. Filter', FRA = 'Filtre n° de série';
        }
        modify("Qty. on Purch. Return")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Purch. Return"(Field 6650)". Please convert manually.

            CaptionML = ENU = 'Qty. on Purch. Return', FRA = 'Qté sur retour achat';
        }
        modify("Qty. on Sales Return")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Sales Return"(Field 6660)". Please convert manually.

            CaptionML = ENU = 'Qty. on Sales Return', FRA = 'Qté sur retour vente';

            //Unsupported feature: Change Description on ""Qty. on Sales Return"(Field 6660)". Please convert manually.

        }
        modify("No. of Substitutes")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Substitutes"(Field 7171)". Please convert manually.

            CaptionML = ENU = 'No. of Substitutes', FRA = 'Nbre de substituts';
        }
        modify("Warehouse Class Code")
        {
            CaptionML = ENU = 'Warehouse Class Code', FRA = 'Code classe entrepôt';
        }
        modify("Special Equipment Code")
        {
            CaptionML = ENU = 'Special Equipment Code', FRA = 'Code équipement spécial';
        }
        modify("Put-away Template Code")
        {
            CaptionML = ENU = 'Put-away Template Code', FRA = 'Code modèle rangement';
        }
        modify("Put-away Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Put-away Unit of Measure Code"(Field 7307)". Please convert manually.

            CaptionML = ENU = 'Put-away Unit of Measure Code', FRA = 'Code unité rangement';
        }
        modify("Phys Invt Counting Period Code")
        {
            CaptionML = ENU = 'Phys Invt Counting Period Code', FRA = 'Code période inventaire stock';
        }
        modify("Last Counting Period Update")
        {
            CaptionML = ENU = 'Last Counting Period Update', FRA = 'Dern. MAJ période d''inventaire';
        }
        modify("Last Phys. Invt. Date")
        {

            //Unsupported feature: Change CalcFormula on ""Last Phys. Invt. Date"(Field 7383)". Please convert manually.

            CaptionML = ENU = 'Last Phys. Invt. Date', FRA = 'Date dern. inventaire';
        }
        modify("Use Cross-Docking")
        {

            //Unsupported feature: Change InitValue on ""Use Cross-Docking"(Field 7384)". Please convert manually.

            CaptionML = ENU = 'Use Cross-Docking', FRA = 'Utiliser transbordement';
        }
        modify("Next Counting Start Date")
        {
            CaptionML = ENU = 'Next Counting Start Date', FRA = 'Proch. date début d''inventaire';
        }
        modify("Next Counting End Date")
        {
            CaptionML = ENU = 'Next Counting End Date', FRA = 'Proch. date fin d''inventaire';
        }
        modify("Identifier Code")
        {

            //Unsupported feature: Change CalcFormula on ""Identifier Code"(Field 7700)". Please convert manually.

            CaptionML = ENU = 'Identifier Code', FRA = 'Code identifiant';
        }
        modify("Routing No.")
        {
            CaptionML = ENU = 'Routing No.', FRA = 'N° gamme';
        }
        modify("Production BOM No.")
        {
            CaptionML = ENU = 'Production BOM No.', FRA = 'N° nomenclature production';
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
        modify("Overhead Rate")
        {
            CaptionML = ENU = 'Overhead Rate', FRA = 'Frais généraux';
        }
        modify("Rolled-up Subcontracted Cost")
        {
            CaptionML = ENU = 'Rolled-up Subcontracted Cost', FRA = 'Coût s/traitance multi-niv.';
        }
        modify("Rolled-up Mfg. Ovhd Cost")
        {
            CaptionML = ENU = 'Rolled-up Mfg. Ovhd Cost', FRA = 'Frais gén. matière multi-niv.';
        }
        modify("Rolled-up Cap. Overhead Cost")
        {
            CaptionML = ENU = 'Rolled-up Cap. Overhead Cost', FRA = 'Frais gén. opérat. multi-niv.';
        }
        modify("Planning Issues (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Planning Issues (Qty.)"(Field 99000761)". Please convert manually.

            CaptionML = ENU = 'Planning Issues (Qty.)', FRA = 'Sorties planning (qté)';
        }
        modify("Planning Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Planning Receipt (Qty.)"(Field 99000762)". Please convert manually.

            CaptionML = ENU = 'Planning Receipt (Qty.)', FRA = 'Réception planning (qté)';
        }
        modify("Planned Order Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Planned Order Receipt (Qty.)"(Field 99000765)". Please convert manually.

            CaptionML = ENU = 'Planned Order Receipt (Qty.)', FRA = 'Réception ordre planifiée (qté)';
        }
        modify("FP Order Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""FP Order Receipt (Qty.)"(Field 99000766)". Please convert manually.

            CaptionML = ENU = 'FP Order Receipt (Qty.)', FRA = 'Récep. ordre plan. ferme (qté)';
        }
        modify("Rel. Order Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Rel. Order Receipt (Qty.)"(Field 99000767)". Please convert manually.

            CaptionML = ENU = 'Rel. Order Receipt (Qty.)', FRA = 'Réception ordre lancé (qté)';
        }
        modify("Planning Release (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Planning Release (Qty.)"(Field 99000768)". Please convert manually.

            CaptionML = ENU = 'Planning Release (Qty.)', FRA = 'Lancement planning (qté)';
        }
        modify("Planned Order Release (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Planned Order Release (Qty.)"(Field 99000769)". Please convert manually.

            CaptionML = ENU = 'Planned Order Release (Qty.)', FRA = 'Lancement ordre planifié (qté)';
        }
        modify("Purch. Req. Receipt (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Purch. Req. Receipt (Qty.)"(Field 99000770)". Please convert manually.

            CaptionML = ENU = 'Purch. Req. Receipt (Qty.)', FRA = 'Réception dem. achat (qté)';
        }
        modify("Purch. Req. Release (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Purch. Req. Release (Qty.)"(Field 99000771)". Please convert manually.

            CaptionML = ENU = 'Purch. Req. Release (Qty.)', FRA = 'Lancement dem. achat (qté)';
        }
        modify("Order Tracking Policy")
        {
            CaptionML = ENU = 'Order Tracking Policy', FRA = 'Chaînage dynamique';
            // OptionCaptionML = ENU = 'None,Tracking Only,Tracking & Action Msg.', FRA = 'Aucun,Chaînage seul,Chaînage & message d''action';
        }
        modify("Prod. Forecast Quantity (Base)")
        {

            //Unsupported feature: Change CalcFormula on ""Prod. Forecast Quantity (Base)"(Field 99000774)". Please convert manually.

            CaptionML = ENU = 'Prod. Forecast Quantity (Base)', FRA = 'Qté prévision prod. (base)';
        }
        modify("Production Forecast Name")
        {
            CaptionML = ENU = 'Production Forecast Name', FRA = 'Nom prévision production';
        }
        modify("Component Forecast")
        {
            CaptionML = ENU = 'Component Forecast', FRA = 'Prévision composant';
        }
        modify("Qty. on Prod. Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Prod. Order"(Field 99000777)". Please convert manually.

            CaptionML = ENU = 'Qty. on Prod. Order', FRA = 'Qté sur ordre fabrication';
        }
        modify("Qty. on Component Lines")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Component Lines"(Field 99000778)". Please convert manually.

            CaptionML = ENU = 'Qty. on Component Lines', FRA = 'Qté sur lignes composant';
        }
        modify(Critical)
        {
            CaptionML = ENU = 'Critical', FRA = 'Critique';
        }
        modify("Common Item No.")
        {
            CaptionML = ENU = 'Common Item No.', FRA = 'N° article commun';
        }


        //Unsupported feature: CodeModification on ""No."(Field 1).OnValidate". Please convert manually.

        //trigger "(Field 1)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." <> xRec."No." THEN BEGIN
          GetInvtSetup;
          NoSeriesMgt.TestManual(InvtSetup."Item Nos.");
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "No." <> xRec."No." then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeInsertion on ""No. 2"(Field 2)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //var  //BC Upgrade PATHAA02
        //    InventorySetup: Record "Inventory Setup"; //BC Upgrade PATHAA02
        //begin
        /*
        //HEI.01>>
        InventorySetup.GET;
        if InventorySetup."Item Global ID As Cross Ref." then
        //HEI.01<<
        //<<FINXL8.00.001 BSA 27/05/2015 #186
        if recFinXLSetup.READPERMISSION then
          SaveAsCrossReference;
        //>>FINXL8.00.001 BSA 27/05/2015 #186
        */
        //end;


        //Unsupported feature: CodeModification on "Description(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Search Description" = UPPERCASE(xRec.Description)) OR ("Search Description" = '') THEN
          "Search Description" := Description;

        IF "Created From Nonstock Item" THEN BEGIN
          NonstockItem.SETCURRENTKEY("Item No.");
          NonstockItem.SETRANGE("Item No.","No.");
          IF NonstockItem.FINDFIRST THEN
            IF NonstockItem.Description = '' THEN BEGIN
              NonstockItem.Description := Description;
              NonstockItem.MODIFY;
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Search Description" = UPPERCASE(xRec.Description)) or ("Search Description" = '') then
          "Search Description" := Description;

        if "Created From Nonstock Item" then begin
          NonstockItem.SETCURRENTKEY("Item No.");
          NonstockItem.SETRANGE("Item No.","No.");
          if NonstockItem.FINDFIRST then
            if NonstockItem.Description = '' then begin
              NonstockItem.Description := Description;
              NonstockItem.MODIFY;
            end;
        end;

        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
        if (Description <> xRec.Description) then begin
          GetInvtSetup;
          if (InvtSetup."Item Auto Dimension Code" <> '') then begin
            txtDimName := DimMgt.fctGetDimNameFromSource(Description,"Description 2");
            if rDimValue.GET(InvtSetup."Item Auto Dimension Code","No.") and (rDimValue.Name <> txtDimName) then begin
              rDimValue.Name := txtDimName;
              rDimValue.MODIFY;
            end;
          end;
        end;
        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Description 2"(Field 5)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
        if ("Description 2" <> xRec."Description 2") then begin
          GetInvtSetup;
          if (InvtSetup."Item Auto Dimension Code" <> '') then begin
            txtDimName := DimMgt.fctGetDimNameFromSource(Description,"Description 2");
            if rDimValue.GET(InvtSetup."Item Auto Dimension Code","No.") and (rDimValue.Name <> txtDimName) then begin
              rDimValue.Name := txtDimName;
              rDimValue.MODIFY;
            end;
          end;
        end;
        //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
        */
        //end;


        //Unsupported feature: CodeModification on ""Base Unit of Measure"(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Base Unit of Measure" <> xRec."Base Unit of Measure" THEN BEGIN
          TestNoOpenEntriesExist(FIELDCAPTION("Base Unit of Measure"));

          "Sales Unit of Measure" := "Base Unit of Measure";
          "Purch. Unit of Measure" := "Base Unit of Measure";
          IF "Base Unit of Measure" <> '' THEN BEGIN
            UnitOfMeasure.GET("Base Unit of Measure");

            IF NOT ItemUnitOfMeasure.GET("No.","Base Unit of Measure") THEN BEGIN
              ItemUnitOfMeasure.INIT;
              ItemUnitOfMeasure.VALIDATE("Item No.","No.");
              ItemUnitOfMeasure.VALIDATE(Code,"Base Unit of Measure");
              ItemUnitOfMeasure."Qty. per Unit of Measure" := 1;
              ItemUnitOfMeasure.INSERT;
            end else BEGIN
              IF ItemUnitOfMeasure."Qty. per Unit of Measure" <> 1 THEN
                ERROR(STRSUBSTNO(BaseUnitOfMeasureQtyMustBeOneErr,"Base Unit of Measure",ItemUnitOfMeasure."Qty. per Unit of Measure"));
            end;
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Base Unit of Measure" <> xRec."Base Unit of Measure" then begin
        #2..5
           //<< DITW110.00.12 AKH 21/03/2018 NRQ#64704
          "Production Unit of Measure" := "Base Unit of Measure";
          "Inventory Unit of Measure" := "Base Unit of Measure";
          //>> DITW110.00.12 AKH NRQ#64704
          if "Base Unit of Measure" <> '' then begin
            UnitOfMeasure.GET("Base Unit of Measure");
            //<< HEI.02 NAIKH01  Commented the code as per the defect List ID #47 & #48
           // HeinekenGlobal.CheckUOM(Rec."No.",Rec."Base Unit of Measure",1);
            //>> HEI.02 NAIKH01

            if not ItemUnitOfMeasure.GET("No.","Base Unit of Measure") then begin
        #10..14
            end else begin
              if ItemUnitOfMeasure."Qty. per Unit of Measure" <> 1 then
                ERROR(STRSUBSTNO(BaseUnitOfMeasureQtyMustBeOneErr,"Base Unit of Measure",ItemUnitOfMeasure."Qty. per Unit of Measure"));
            end;
          end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on "Type(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemLedgEntry.RESET;
        ItemLedgEntry.SETCURRENTKEY("Item No.");
        ItemLedgEntry.SETRANGE("Item No.","No.");
        IF NOT ItemLedgEntry.ISEMPTY THEN
          ERROR(CannotChangeFieldErr,FIELDCAPTION(Type),TABLECAPTION,"No.",ItemLedgEntry.TABLECAPTION);

        CheckJournalsAndWorksheets(FIELDNO(Type));
        CheckDocuments(FIELDNO(Type));
        IF Type = Type::Service THEN BEGIN
          CALCFIELDS("Assembly BOM");
          TESTFIELD("Assembly BOM",FALSE);

          CALCFIELDS("Stockkeeping Unit Exists");
          TESTFIELD("Stockkeeping Unit Exists",FALSE);

          VALIDATE("Assembly Policy","Assembly Policy"::"Assemble-to-Stock");
          VALIDATE("Replenishment System","Replenishment System"::Purchase);
        #18..22
          VALIDATE("Routing No.",'');
          VALIDATE("Reordering Policy","Reordering Policy"::" ");
          VALIDATE("Order Tracking Policy","Order Tracking Policy"::None);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.11>>
        if Type = xRec.Type then
          exit;
        //HEI.11<<

        #1..3
        if not ItemLedgEntry.ISEMPTY then
        #5..8
        if Type = Type::Service then begin
          CALCFIELDS("Assembly BOM");
          TESTFIELD("Assembly BOM",false);

          CALCFIELDS("Stockkeeping Unit Exists");
          TESTFIELD("Stockkeeping Unit Exists",false);
        #15..25
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Inventory Posting Group"(Field 11).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Inventory Posting Group" <> '' THEN
          TESTFIELD(Type,Type::Inventory);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Inventory Posting Group" <> '' then
          TESTFIELD(Type,Type::Inventory);
        // <<DITW16.00.00.43 DDR 30/01/2014 DIT-715 #605
        ValidateAsEmptyGood;
        // >>DITW16.00.00.43 DDR DIT-715 #605
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Allow Invoice Disc."(Field 15)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 09/05/2011 #1328
        if "Allow Invoice Disc." then
          TESTFIELD("Pos System","Pos System"::" ");
        // >>DITW15.00.00.39 DDR #1328
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Price"(Field 18).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Price/Profit Calculation");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Price/Profit Calculation");
        // <<DITW16.00.00.43 DDR 14/08/2013 DIT-715 #605
        if (xRec."Unit Price" <> "Unit Price") or
          (CurrFieldNo <> 0) and ("Unit Price" = 0)
        then
          "Modified Unit Price" := true;
        // >>DITW16.00.00.43 DDR DIT-715 #605
        */
        //end;


        //Unsupported feature: CodeModification on ""Price/Profit Calculation"(Field 19).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Price/Profit Calculation" OF
          "Price/Profit Calculation"::"Profit=Price-Cost":
            IF "Unit Price" <> 0 THEN
              IF "Unit Cost" = 0 THEN
                "Profit %" := 0
              else
                "Profit %" :=
                  ROUND(
                    100 * (1 - "Unit Cost" /
                           ("Unit Price" / (1 + CalcVAT))),0.00001)
            else
              "Profit %" := 0;
          "Price/Profit Calculation"::"Price=Cost+Profit":
            IF "Profit %" < 100 THEN BEGIN
              GetGLSetup;
              "Unit Price" :=
                ROUND(
                  ("Unit Cost" / (1 - "Profit %" / 100)) *
                  (1 + CalcVAT),
                  GLSetup."Unit-Amount Rounding Precision");
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        case "Price/Profit Calculation" of
          "Price/Profit Calculation"::"Profit=Price-Cost":
            if "Unit Price" <> 0 then
              if "Unit Cost" = 0 then
                "Profit %" := 0
              else
        #7..10
            else
              "Profit %" := 0;
          "Price/Profit Calculation"::"Price=Cost+Profit":
            if "Profit %" < 100 then begin
        #15..20
            end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Costing Method"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Costing Method" = xRec."Costing Method" THEN
          EXIT;

        IF "Costing Method" <> "Costing Method"::FIFO THEN
          TESTFIELD(Type,Type::Inventory);

        IF "Costing Method" = "Costing Method"::Specific THEN BEGIN
          TESTFIELD("Item Tracking Code");

          ItemTrackingCode.GET("Item Tracking Code");
          IF NOT ItemTrackingCode."SN Specific Tracking" THEN
            ERROR(
              Text018,
              ItemTrackingCode.FIELDCAPTION("SN Specific Tracking"),
              FORMAT(TRUE),ItemTrackingCode.TABLECAPTION,ItemTrackingCode.Code,
              FIELDCAPTION("Costing Method"),"Costing Method");
        end;

        TestNoEntriesExist(FIELDCAPTION("Costing Method"));

        ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,FALSE,FALSE,TRUE,FIELDNO("Costing Method"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Costing Method" = xRec."Costing Method" then
          exit;

        if "Costing Method" <> "Costing Method"::FIFO then
          TESTFIELD(Type,Type::Inventory);

        if "Costing Method" = "Costing Method"::Specific then begin
        #8..10
          if not ItemTrackingCode."SN Specific Tracking" then
        #12..14
              FORMAT(true),ItemTrackingCode.TABLECAPTION,ItemTrackingCode.Code,
              FIELDCAPTION("Costing Method"),"Costing Method");
        end;
        #18..20
        ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,false,false,true,FIELDNO("Costing Method"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Unit Cost"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Costing Method" = "Costing Method"::Standard THEN
          VALIDATE("Standard Cost","Unit Cost")
        else
          TestNoEntriesExist(FIELDCAPTION("Unit Cost"));
        VALIDATE("Price/Profit Calculation");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Costing Method" = "Costing Method"::Standard then
          VALIDATE("Standard Cost","Unit Cost")
        else
          TestNoEntriesExist(FIELDCAPTION("Unit Cost"));
        VALIDATE("Price/Profit Calculation");
        */
        //end;


        //Unsupported feature: CodeModification on ""Standard Cost"(Field 24).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Costing Method" = "Costing Method"::Standard) AND (CurrFieldNo <> 0) THEN
          IF NOT GUIALLOWED THEN BEGIN
            "Standard Cost" := xRec."Standard Cost";
            EXIT;
          end else
            IF NOT
               CONFIRM(
                 Text020 +
                 Text021 +
                 Text022,FALSE,
                 FIELDCAPTION("Standard Cost"))
            THEN BEGIN
              "Standard Cost" := xRec."Standard Cost";
              EXIT;
            end;

        ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,FALSE,FALSE,TRUE,FIELDNO("Standard Cost"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Costing Method" = "Costing Method"::Standard) and (CurrFieldNo <> 0) then
          if not GUIALLOWED then begin
            "Standard Cost" := xRec."Standard Cost";
            exit;
          end else
            if not
        #7..9
                 Text022,false,
                 FIELDCAPTION("Standard Cost"))
            then begin
              "Standard Cost" := xRec."Standard Cost";
              exit;
            end;

        ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,false,false,true,FIELDNO("Standard Cost"));
        //<<DITW17.00.02 SR 10/09/2013 DIT-770 #143
        recUserSetup.GET(USERID);
        if not recUserSetup."Release Item" then
          if (xRec."Standard Cost" <> "Standard Cost")
            then Blocked := true;
        //>>DITW17.00.02 SR DIT-770 #143
        */
        //end;


        //Unsupported feature: CodeModification on ""Indirect Cost %"(Field 28).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,FALSE,FALSE,TRUE,FIELDNO("Indirect Cost %"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,false,false,true,FIELDNO("Indirect Cost %"));
        */
        //end;


        //Unsupported feature: CodeModification on ""Vendor No."(Field 31).OnValidate". Please convert manually.

        //trigger "(Field 31)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Vendor No." <> "Vendor No.") AND
           ("Vendor No." <> '')
        THEN
          IF Vend.GET("Vendor No.") THEN
            "Lead Time Calculation" := Vend."Lead Time Calculation";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Vendor No." <> "Vendor No.") and
           ("Vendor No." <> '')
        then
          if Vend.GET("Vendor No.") then
            "Lead Time Calculation" := Vend."Lead Time Calculation";
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Tariff No."(Field 47)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //var //BC Upgrade PATHAA02
        //   Confirmed: Boolean; //BC Upgrade PATHAA02
        //begin
        /*
        // <<DITW15.00.00.38 DDR 25/08/2010 #1217
        if "Tariff No." <> '' then begin
          TariffNumber.GET("Tariff No.");
          if TariffNumber."Product Tax Code" <> '' then begin
            if (CurrFieldNo = FIELDNO("Tariff No.")) and ("Product Tax Code" <> '') and GUIALLOWED then
              Confirmed :=
                CONFIRM(Text2013661,false,
                  FIELDCAPTION("Tariff No."),FIELDCAPTION("Product Tax Code"),
                  TariffNumber."Product Tax Code","Product Tax Code")
            else
              Confirmed := true;

            if Confirmed then
              VALIDATE("Product Tax Code",TariffNumber."Product Tax Code");
          end;
        end;
        // >>DITW15.00.00.38 DDR
        */
        //end;


        //Unsupported feature: CodeInsertion on "Blocked(Field 54)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //BC Upgrade PATHAA02>>
        //var 
        //Lbln_Allowed: Boolean;         
        //  StdCostAgingInfoL: Record "Standard Cost Aging Info FND"; 
        //BC Upgrade PATHAA02<<
        //begin
        /*
        //<<DITW17.00.02 SR 10/09/2013 DIT-770 #143 - DITW110.00.08 DDR 02/01/2017 NRQ#0
        if (Blocked <> xRec.Blocked) and (USERID <> '') then begin
          if recUserSetup.GET(USERID) then
            Lbln_Allowed := recUserSetup."Release Item";
        end;
        //<<DITW110.00.11 MSF 08/11/2017 NRQ#13577
        if (Blocked <> xRec.Blocked) and (not Blocked) and  not Lbln_Allowed then
        //>>DITW110.00.11 MSF 08/11/2017 NRQ#13577
            ERROR(Text2014412);
        //>>DITW17.00.02 SR DIT-770 #143

        /// DITW17.00.02 SR 20/09/2013 DIT-770 #187 - DITW110.00.08 DDR 09/02/2017 NRQ#20699

        //HEI.27>>
        StdCostAgingInfoL.SETCURRENTKEY("Item No.");
        StdCostAgingInfoL.SETRANGE("Item No.","No.");
        if StdCostAgingInfoL.findset(false,false) then begin
          StdCostAgingInfoL.MODIFYALL(Blocked,Blocked,false);
          StdCostAgingInfoL.MODIFYALL("Block or Unblock Date",TODAY,false);
        end;
        //HEI.27<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Price Includes VAT"(Field 87).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Price Includes VAT" THEN BEGIN
          SalesSetup.GET;
          IF SalesSetup."VAT Bus. Posting Gr. (Price)" <> '' THEN
            "VAT Bus. Posting Gr. (Price)" := SalesSetup."VAT Bus. Posting Gr. (Price)";
          VATPostingSetup.GET("VAT Bus. Posting Gr. (Price)","VAT Prod. Posting Group");
        end;
        VALIDATE("Price/Profit Calculation");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Price Includes VAT" then begin
          SalesSetup.GET;
          if SalesSetup."VAT Bus. Posting Gr. (Price)" <> '' then
            "VAT Bus. Posting Gr. (Price)" := SalesSetup."VAT Bus. Posting Gr. (Price)";
          VATPostingSetup.GET("VAT Bus. Posting Gr. (Price)","VAT Prod. Posting Group");
        end else
          // <<DITW15.00.00.39 DDR 09/05/2011 #1328
          TESTFIELD("Pos System","Pos System"::" ");
          // >>DITW15.00.00.39 DDR #1328

        VALIDATE("Price/Profit Calculation");
        */
        //end;


        //Unsupported feature: CodeModification on ""Gen. Prod. Posting Group"(Field 91).OnValidate". Please convert manually.

        //trigger  Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN BEGIN
          IF CurrFieldNo <> 0 THEN
            IF ProdOrderExist THEN
              IF NOT CONFIRM(
                   Text024 +
                   Text022,FALSE,
                   FIELDCAPTION("Gen. Prod. Posting Group"))
              THEN BEGIN
                "Gen. Prod. Posting Group" := xRec."Gen. Prod. Posting Group";
                EXIT;
              end;

          IF GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") THEN
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");
        end;

        VALIDATE("Price/Profit Calculation");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then begin
          if CurrFieldNo <> 0 then
            if ProdOrderExist then
              if not CONFIRM(
                   Text024 +
                   Text022,false,
                   FIELDCAPTION("Gen. Prod. Posting Group"))
              then begin
                "Gen. Prod. Posting Group" := xRec."Gen. Prod. Posting Group";
                exit;
              end;

          if GenProdPostingGrp.ValidateVatProdPostingGroup(GenProdPostingGrp,"Gen. Prod. Posting Group") then
            VALIDATE("VAT Prod. Posting Group",GenProdPostingGrp."Def. VAT Prod. Posting Group");

          // <<DITW15.00.00.38 DDR 02/02/2011 #941
          if GenProdPostingGrp."Def. Prod. Posting Free Group" <> '' then
            VALIDATE("Gen. Prod. Posting Free Group",GenProdPostingGrp."Def. Prod. Posting Free Group");
          // >>DITW15.00.00.38 DDR #941

          // <<DITW15.00.00.35 DDR 09/10/2009
          if ("Gen. Prod. Posting Free Group" = '') and ("Gen. Prod. Posting Group" <> '') then
            VALIDATE("Gen. Prod. Posting Free Group","Gen. Prod. Posting Group");
          // >>DITW15.00.00.35 DDR
        end;

        VALIDATE("Price/Profit Calculation");
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Country/Region of Origin Code"(Field 95)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.38 DDR 25/08/2010 #1217
        if "Country/Region of Origin Code" = '' then
          TESTFIELD("Wine Growing zone",'');
        if "Wine Growing zone" <> '' then
          WineGrowzone.GET("Country/Region of Origin Code","Wine Growing zone");
        // >>DITW15.00.00.38 DDR
        // <<DITW16.00.00.40 DDR 21/02/2012 DIT-715 #222
        if "Country/Region of Origin Code" <> '' then
          VALIDATE("Wine Product Category");
        // >>DITW16.00.00.40 DDR DIT-715 #222
        */
        //end;


        //Unsupported feature: CodeModification on "Reserve(Field 100).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Reserve <> Reserve::Never THEN
          TESTFIELD(Type,Type::Inventory);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Reserve <> Reserve::Never then
          TESTFIELD(Type,Type::Inventory);
        */
        //end;


        //Unsupported feature: CodeModification on ""Assembly Policy"(Field 910).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Assembly Policy" = "Assembly Policy"::"Assemble-to-Order" THEN
          TESTFIELD("Replenishment System","Replenishment System"::Assembly);
        IF Type = Type::Service THEN
          TESTFIELD("Assembly Policy","Assembly Policy"::"Assemble-to-Stock");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Assembly Policy" = "Assembly Policy"::"Assemble-to-Order" then
          TESTFIELD("Replenishment System","Replenishment System"::Assembly);
        if Type = Type::Service then
          TESTFIELD("Assembly Policy","Assembly Policy"::"Assemble-to-Stock");
        */
        //end;


        //Unsupported feature: CodeModification on ""Serial Nos."(Field 5402).OnValidate". Please convert manually.

        //trigger "(Field 5402)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Serial Nos." <> '' THEN
          TESTFIELD("Item Tracking Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Serial Nos." <> '' then
          TESTFIELD("Item Tracking Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Inventory Value Zero"(Field 5409).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckForProductionOutput("No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //HEI.14>>
        //old code: CheckForProductionOutput("No.");
        if "Inventory Value Zero" <> xRec."Inventory Value Zero" then
          CheckForProductionOutput("No.");
        //HEI.14<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Replenishment System"(Field 5419).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Replenishment System" <> "Replenishment System"::Assembly THEN
          TESTFIELD("Assembly Policy","Assembly Policy"::"Assemble-to-Stock");
        IF "Replenishment System" <> "Replenishment System"::Purchase THEN
          TESTFIELD(Type,Type::Inventory);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Replenishment System" <> "Replenishment System"::Assembly then
          TESTFIELD("Assembly Policy","Assembly Policy"::"Assemble-to-Stock");
        if "Replenishment System" <> "Replenishment System"::Purchase then
          TESTFIELD(Type,Type::Inventory);
        */
        //end;


        //Unsupported feature: CodeModification on ""Rounding Precision"(Field 5422).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Rounding Precision" <= 0 THEN
          FIELDERROR("Rounding Precision",Text027);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Rounding Precision" <= 0 then
          FIELDERROR("Rounding Precision",Text027);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Sales Unit of Measure"(Field 5425)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW15.00.00.39 DDR 09/05/2011 #1328
        if ("Sales Unit of Measure" <> '') and ("Pos System" <> "Pos System"::" ") then begin
          ItemUnitOfMeasure.GET("Sales Unit of Measure");
          ItemUnitOfMeasure.TESTFIELD("Pos System","Pos System");
        end;
        // >>DITW15.00.00.39 DDR #1328
        */
        //end;


        //Unsupported feature: CodeModification on ""Reordering Policy"(Field 5440).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "Include Inventory" :=
          "Reordering Policy" IN ["Reordering Policy"::"Lot-for-Lot",
                                  "Reordering Policy"::"Maximum Qty.",
                                  "Reordering Policy"::"Fixed Reorder Qty."];

        IF "Reordering Policy" <> "Reordering Policy"::" " THEN
          TESTFIELD(Type,Type::Inventory);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        "Include Inventory" :=
          "Reordering Policy" in ["Reordering Policy"::"Lot-for-Lot",
        #3..5
        if "Reordering Policy" <> "Reordering Policy"::" " then
          TESTFIELD(Type,Type::Inventory);
        */
        //end;


        //Unsupported feature: CodeModification on ""Service Item Group"(Field 5900).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."Service Item Group" <> "Service Item Group" THEN BEGIN
          IF NOT ResSkillMgt.ChangeRelationWithGroup(
               ResSkill.Type::Item,
               "No.",
               ResSkill.Type::"Service Item Group",
               "Service Item Group",
               xRec."Service Item Group")
          THEN
            "Service Item Group" := xRec."Service Item Group";
        end else
          ResSkillMgt.RevalidateRelation(
            ResSkill.Type::Item,
            "No.",
            ResSkill.Type::"Service Item Group",
            "Service Item Group")
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Service Item Group" <> "Service Item Group" then begin
          if not ResSkillMgt.ChangeRelationWithGroup(
        #3..7
          then
            "Service Item Group" := xRec."Service Item Group";
        end else
        #11..15
        */
        //end;


        //Unsupported feature: CodeModification on ""Item Tracking Code"(Field 6500).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Item Tracking Code" <> '' THEN
          TESTFIELD(Type,Type::Inventory);
        IF "Item Tracking Code" = xRec."Item Tracking Code" THEN
          EXIT;

        IF NOT ItemTrackingCode.GET("Item Tracking Code") THEN
          CLEAR(ItemTrackingCode);

        IF NOT ItemTrackingCode2.GET(xRec."Item Tracking Code") THEN
          CLEAR(ItemTrackingCode2);

        IF (ItemTrackingCode."SN Specific Tracking" <> ItemTrackingCode2."SN Specific Tracking") OR
           (ItemTrackingCode."Lot Specific Tracking" <> ItemTrackingCode2."Lot Specific Tracking")
        THEN
          TestNoEntriesExist(FIELDCAPTION("Item Tracking Code"));

        IF "Costing Method" = "Costing Method"::Specific THEN BEGIN
          TestNoEntriesExist(FIELDCAPTION("Item Tracking Code"));

          TESTFIELD("Item Tracking Code");

          ItemTrackingCode.GET("Item Tracking Code");
          IF NOT ItemTrackingCode."SN Specific Tracking" THEN
            ERROR(
              Text018,
              ItemTrackingCode.FIELDCAPTION("SN Specific Tracking"),
              FORMAT(TRUE),ItemTrackingCode.TABLECAPTION,ItemTrackingCode.Code,
              FIELDCAPTION("Costing Method"),"Costing Method");
        end;

        TestNoOpenDocumentsWithTrackingExist;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Item Tracking Code" <> '' then
          TESTFIELD(Type,Type::Inventory);
        if "Item Tracking Code" = xRec."Item Tracking Code" then
          exit;

        if not ItemTrackingCode.GET("Item Tracking Code") then
          CLEAR(ItemTrackingCode);

        if not ItemTrackingCode2.GET(xRec."Item Tracking Code") then
          CLEAR(ItemTrackingCode2);

        if (ItemTrackingCode."SN Specific Tracking" <> ItemTrackingCode2."SN Specific Tracking") or
           (ItemTrackingCode."Lot Specific Tracking" <> ItemTrackingCode2."Lot Specific Tracking")
        then
          TestNoEntriesExist(FIELDCAPTION("Item Tracking Code"));

        if "Costing Method" = "Costing Method"::Specific then begin
        #18..22
          if not ItemTrackingCode."SN Specific Tracking" then
        #24..26
              FORMAT(true),ItemTrackingCode.TABLECAPTION,ItemTrackingCode.Code,
              FIELDCAPTION("Costing Method"),"Costing Method");
        end;

        TestNoOpenDocumentsWithTrackingExist;
        */
        //end;


        //Unsupported feature: CodeModification on ""Lot Nos."(Field 6501).OnValidate". Please convert manually.

        //trigger "(Field 6501)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Lot Nos." <> '' THEN
          TESTFIELD("Item Tracking Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Lot Nos." <> '' then
          TESTFIELD("Item Tracking Code");
        */
        //end;


        //Unsupported feature: CodeModification on ""Phys Invt Counting Period Code"(Field 7380).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Phys Invt Counting Period Code" <> '' THEN BEGIN
          PhysInvtCountPeriod.GET("Phys Invt Counting Period Code");
          PhysInvtCountPeriod.TESTFIELD("Count Frequency per Year");
          IF "Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code" THEN BEGIN
            IF CurrFieldNo <> 0 THEN
              IF NOT CONFIRM(
                   Text7380,
                   FALSE,
                   FIELDCAPTION("Phys Invt Counting Period Code"),
                   FIELDCAPTION("Next Counting Start Date"),
                   FIELDCAPTION("Next Counting End Date"))
              THEN
                ERROR(Text7381);

            IF ("Last Counting Period Update" = 0D) OR
               ("Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code")
            THEN
              PhysInvtCountPeriodMgt.CalcPeriod(
                "Last Counting Period Update","Next Counting Start Date","Next Counting End Date",
                PhysInvtCountPeriod."Count Frequency per Year");
          end;
        end else BEGIN
          IF CurrFieldNo <> 0 THEN
            IF NOT CONFIRM(Text003,FALSE,FIELDCAPTION("Phys Invt Counting Period Code")) THEN
              ERROR(Text7381);
          "Next Counting Start Date" := 0D;
          "Next Counting End Date" := 0D;
          "Last Counting Period Update" := 0D;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Phys Invt Counting Period Code" <> '' then begin
          PhysInvtCountPeriod.GET("Phys Invt Counting Period Code");
          PhysInvtCountPeriod.TESTFIELD("Count Frequency per Year");
          if "Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code" then begin
            if CurrFieldNo <> 0 then
              if not CONFIRM(
                   Text7380,
                   false,
        #9..11
              then
                ERROR(Text7381);

            if ("Last Counting Period Update" = 0D) or
               ("Phys Invt Counting Period Code" <> xRec."Phys Invt Counting Period Code")
            then
        #18..20
          end;
        end else begin
          if CurrFieldNo <> 0 then
            if not CONFIRM(Text003,false,FIELDCAPTION("Phys Invt Counting Period Code")) then
        #25..28
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Routing No."(Field 99000750).OnValidate". Please convert manually.

        //trigger "(Field 99000750)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Routing No." <> '' THEN
          TESTFIELD(Type,Type::Inventory);

        PlanningAssignment.RoutingReplace(Rec,xRec."Routing No.");

        IF "Routing No." <> xRec."Routing No." THEN
          ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,FALSE,FALSE,TRUE,FIELDNO("Routing No."));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Routing No." <> '' then
        #2..4
        //<<DITW18.00.06 MSF 03/02/2015 DIT-770 #1182
        if "Routing No." <> xRec."Routing No." then  begin
        //>>DITW18.00.06 MSF 03/02/2015 DIT-770 #1182
          ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,false,false,true,FIELDNO("Routing No."));
        // <<DITW18.00.06 MSF 03/02/2015 DIT-770 #1182
          UpdateSKUs;
        end;
        // <<DITW18.00.06 MSF 03/02/2015 DIT-770 #1182
        */
        //end;


        //Unsupported feature: CodeModification on ""Production BOM No."(Field 99000751).OnValidate". Please convert manually.

        //trigger "(Field 99000751)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Production BOM No." <> '' THEN
          TESTFIELD(Type,Type::Inventory);

        PlanningAssignment.BomReplace(Rec,xRec."Production BOM No.");

        IF "Production BOM No." <> xRec."Production BOM No." THEN
          ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,FALSE,FALSE,TRUE,FIELDNO("Production BOM No."));

        IF ("Production BOM No." <> '') AND ("Production BOM No." <> xRec."Production BOM No.") THEN BEGIN
          ProdBOMHeader.GET("Production BOM No.");
          ItemUnitOfMeasure.GET("No.",ProdBOMHeader."Unit of Measure Code");
          IF ProdBOMHeader.Status = ProdBOMHeader.Status::Certified THEN BEGIN
            MfgSetup.GET;
            IF MfgSetup."Dynamic Low-Level Code" THEN
              CODEUNIT.RUN(CODEUNIT::"Calculate Low-Level Code",Rec);
          end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Production BOM No." <> '' then
        #2..5
        if "Production BOM No." <> xRec."Production BOM No." then
          ItemCostMgt.UpdateUnitCost(Rec,'','',0,0,false,false,true,FIELDNO("Production BOM No."));

        if ("Production BOM No." <> '') and ("Production BOM No." <> xRec."Production BOM No.") then begin
          ProdBOMHeader.GET("Production BOM No.");
          ItemUnitOfMeasure.GET("No.",ProdBOMHeader."Unit of Measure Code");
          if ProdBOMHeader.Status = ProdBOMHeader.Status::Certified then begin
            MfgSetup.GET;
            if MfgSetup."Dynamic Low-Level Code" then
              CODEUNIT.RUN(CODEUNIT::"Calculate Low-Level Code",Rec);
          end;
          // <<DITW18.00.06 MSF 09/02/2015 DIT-770 #1182
          UpdateSKUs;
          // <<DITW18.00.06 MSF 09/02/2015 DIT-770 #1182
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Order Tracking Policy"(Field 99000773).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Order Tracking Policy" <> "Order Tracking Policy"::None THEN
          TESTFIELD(Type,Type::Inventory);
        IF xRec."Order Tracking Policy" = "Order Tracking Policy" THEN
          EXIT;
        IF "Order Tracking Policy" > xRec."Order Tracking Policy" THEN BEGIN
          MESSAGE(Text99000000 +
            Text99000001,
            SELECTSTR("Order Tracking Policy",Text99000002));
        end else BEGIN
          ActionMessageEntry.SETCURRENTKEY("Reservation Entry");
          ReservEntry.SETCURRENTKEY("Item No.","Variant Code","Location Code","Reservation Status");
          ReservEntry.SETRANGE("Item No.","No.");
          ReservEntry.SETRANGE("Reservation Status",ReservEntry."Reservation Status"::Tracking,ReservEntry."Reservation Status"::Surplus);
          IF ReservEntry.FIND('-') THEN
            REPEAT
              ActionMessageEntry.SETRANGE("Reservation Entry",ReservEntry."Entry No.");
              ActionMessageEntry.DELETEALL;
              IF "Order Tracking Policy" = "Order Tracking Policy"::None THEN
                IF ReservEntry.TrackingExists THEN BEGIN
                  TempReservationEntry := ReservEntry;
                  TempReservationEntry."Reservation Status" := TempReservationEntry."Reservation Status"::Surplus;
                  TempReservationEntry.INSERT;
                end else
                  ReservEntry.DELETE;
            UNTIL ReservEntry.NEXT = 0;

          IF TempReservationEntry.FIND('-') THEN
            REPEAT
              ReservEntry := TempReservationEntry;
              ReservEntry.MODIFY;
            UNTIL TempReservationEntry.NEXT = 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Order Tracking Policy" <> "Order Tracking Policy"::None then
          TESTFIELD(Type,Type::Inventory);
        if xRec."Order Tracking Policy" = "Order Tracking Policy" then
          exit;
        if "Order Tracking Policy" > xRec."Order Tracking Policy" then begin
        #6..8
        end else begin
        #10..13
          if ReservEntry.FIND('-') then
            repeat
              ActionMessageEntry.SETRANGE("Reservation Entry",ReservEntry."Entry No.");
              ActionMessageEntry.DELETEALL;
              if "Order Tracking Policy" = "Order Tracking Policy"::None then
                if ReservEntry.TrackingExists then begin
        #20..22
                end else
                  ReservEntry.DELETE;
            until ReservEntry.NEXT = 0;

          if TempReservationEntry.FIND('-') then
            repeat
              ReservEntry := TempReservationEntry;
              ReservEntry.MODIFY;
              // <<DITW15.00.00.38 DDR 25/10/2010 #1139
              if SSCCSetup.READPERMISSION then begin
                TempTrackingSpecifcation.TRANSFERFIELDS(ReservEntry);
                SSCCLineReserv.FindReservEntry(TempTrackingSpecifcation,SCReservEntry);
                SCReservEntry.MODIFYALL("Reservation Status",SCReservEntry."Reservation Status"::Surplus);
              end;
              // >>DITW15.00.00.38 DDR #1139
            until TempReservationEntry.NEXT = 0;
        end;
        */
        //end;
        field(50000; "Batch Number Policy FND";
        Option)
        {
            Caption = 'Batch Number Policy';
            Description = 'HEI.01';
            OptionCaption = '" ,Bulk Product Related Materials,Discrete Product Related Materials,Wort/Must,Propagated Yeast,Semi-Finished Beverage,Harvested Yeast,Filtration Capacity,Finished Beverage,Finished Product Own Produced"';
            OptionMembers = " ","Bulk Product Related Materials","Discrete Product Related Materials","Wort/Must","Propagated Yeast","Semi-Finished Beverage","Harvested Yeast","Filtration Capacity","Finished Beverage","Finished Product Own Produced";
        }
        field(50001; "Cross-Plant Mtrl. Status FND"; Option)
        {
            Caption = 'Cross-Plant Material Status';
            Description = 'HEI.01';
            OptionCaption = 'Initial Setup,Basic Data Complete,Active,To be Archived';
            OptionMembers = "Initial Setup","Basic Data Complete",Active,"To be Archived";

            trigger OnValidate();
            begin
                //HEI.06>> As per Anca email dt. 09/21/2017, code is commented
                //IF Rec."Cross-Plant Material Status"<> xRec."Cross-Plant Material Status" THEN BEGIN
                //  IF "Cross-Plant Material Status" = "Cross-Plant Material Status"::"To be Archived" THEN
                //    Blocked := TRUE
                //  else
                //    Blocked := FALSE;
                //end;
                //HEI.06<<
            end;
        }
        field(50002; "Quantity Quality Hold FND"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity where("Item No." = FIELD("No."),
                                                                  "Inspection Status 07FDW" = CONST('ON HOLD'),
                                                                  "Lot No." = FILTER(<> ''))); //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
            Caption = 'Quantity Quality Hold (Quarantine)';
            Description = 'HEI.03|HEI.12';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Qty Unrestricted (Pass) FND"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity where("Item No." = FIELD("No."),
                                                                  "Inspection Status 07FDW" = CONST('UNBLOCKED'),
                                                                  "Lot No." = FILTER(<> ''))); //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
            Caption = 'Quantity Unrestricted (Pass)';
            Description = 'HEI.03|HEI.12';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Quantity Blocked (Fail) FND"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity where("Item No." = FIELD("No."),
                                                                  "Inspection Status 07FDW" = CONST('BLOCKED'),
                                                                  "Lot No." = FILTER(<> ''))); //Bc Upgrade PATHAA02 GAP014_DTW, IBM GAP DTW 43
            Caption = 'Quantity Blocked (Fail)';
            Description = 'HEI.03|HEI.12';
            Editable = false;
            FieldClass = FlowField;
        }
        //BC Upgrade Kamnay01>> Moved to RTR_IBM Ext
        // field(50005; "CIL ID Code"; Code[10])
        // {
        //     CaptionML = ENU = 'CIL ID Code',
        //                 FRA = 'CIL ID Code';
        //     Description = 'HEI4.0';
        //     TableRelation = "CIL Code";
        // }
        // field(50006; "CIL ID2 Code"; Code[10])
        // {
        //     Description = 'HEI4.0';
        //     TableRelation = "CIL2 Code";
        // }
        //BC Upgrade Kamnay01<< Moved to RTR_IBM Ext
        field(50007; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.05';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        field(50008; "Plant-Specif. Mtrl. Status FND"; Option)
        {
            Description = 'HEI.01';
            Caption = 'Plant-Specific Material Status';
            OptionCaption = 'Local Setup,Local active,Local Inact/ No procurement,Local Inactive,Local to be Archived';
            OptionMembers = "Local Setup","Local active","Local Inact/ No procurement","Local Inactive","Local to be Archived";
        }
        field(50009; "Batch Numbering Policy FND"; Code[10])
        {
            Description = 'PRDGAP004';
            Caption = 'Batch Numbering Policy';
            TableRelation = "Batch Numbering Policy FND";
        }
        field(50010; "Prod. Forecast Quantity HL FND"; Decimal)
        {
            CalcFormula = Sum("Production Forecast Entry"."Forecast Quantity HL FND" where("Item No." = FIELD("No."),
                                                                                        "Production Forecast Name" = FIELD("Production Forecast Name"),
                                                                                        "Forecast Date" = FIELD("Date Filter"),
                                                                                        "Location Code" = FIELD("Location Filter"),
                                                                                        "Component Forecast" = FIELD("Component Forecast")));
            Caption = 'Prod. Forecast Quantity (HL)';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.08';
            FieldClass = FlowField;
        }
        field(50011; "Item Segmentation FND"; Option)
        {
            Caption = 'Item Segmentation';
            Description = 'HEI.09';
            OptionCaption = ' ,CP,WP,PWP,RP'; //BC UPGRADE PATHAA02
            OptionMembers = " ",CP,WP,PWP,RP;
        }
        field(50012; "Certification Required FND"; Boolean)
        {
            Caption = 'Certification Required';
            Description = 'HEI.09';
        }
        field(50013; "Rotating Item FND"; Boolean)
        {
            Caption = 'Rotating Item';
            Description = 'HEI.09';
        }
        field(50014; "Machine Reference Number FND"; Text[50])
        {
            Caption = 'Machine Reference Number';
            Description = 'HEI.09';
        }

        // BC Upgrade MISHRS14 >>
        // Changed datatype of "RPM Solution" from option to enum to avoid implicit conversion and blocked option therefore for CU-54002(DTW)
        //field(50016; "RPM Solution"; Option)
        field(50016; "RPM Solution FND"; enum "RPM Solution SKU")
        {
            Caption = 'RPM Solution';
            Description = 'HEI.10';
            // OptionCaption = '" ,Deposit,Full-for-Empty with revenue impact (FFE with revenue),Full-for Empty without revenue impact (FFE w/o revenue)"';
            // OptionMembers = " ",Deposit,"Full-for-Empty with revenue impact (FFE with revenue)","Full-for Empty without revenue impact (FFE w/o revenue)";
            // BC Upgrade MISHRS14 <<
        }
        field(50017; "RPM Type FND"; Code[20])
        {
            Description = 'HEI.10';
            Caption = 'RPM Type';
        }

        // BC Upgrade MISHRS14 >>
        // Changed datatype of "Item Type" from option to enum to avoid implicit conversion and blocked option therefore for CU-54002(DTW)
        //field(50018; "Item Type"; Option)
        field(50018; "Item Type FND"; enum "Item Type SKU")
        {
            Caption = 'Item Type';
            Description = 'HEI.10';
            // OptionCaption = '" ,RPM Related,Product Related"';
            // OptionMembers = " ","RPM Related","Product Related";
            // BC Upgrade MISHRS14 <<
        }
        field(50019; "Unit Volume FPL FND"; Decimal)
        {
            Description = 'HEI.10';
            Caption = 'Unit Volume FPL';
        }
        field(50020; "Product Group Code R1 FND"; Code[10])
        {
            CaptionML = ENU = 'Product Group Code R1',
                        FRA = 'Product Group Code R1';
            Description = 'HEI.13';
            TableRelation = "Product Group R1 FND".Code;
        }
        field(50021; "Full BOM Counterpart FND"; Code[20])
        {
            CaptionML = ENU = 'Full BOM Counterpart',
                        FRA = 'Equivalent casier plein';
            Description = 'HEI.15';
            TableRelation = Item where("Assembly BOM" = FILTER(true));
        }
        field(50022; "Available Inv. (Whse) FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity where("Item No." = FIELD("No."),
                                                                "Unavailable Stock (Bin) FND" = CONST(false),
                                                                "Unavail. Stock (Quality) FND" = CONST(false)));
            DecimalPlaces = 0 : 5;
            Description = 'HEI.16';
            Caption = 'Available Inventory (Warehouse)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "Uavailable Inv. (Whse) FND"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity where("Item No." = FIELD("No."),
                                                                "Unavailable Stock FND" = CONST(true),
                                                                "Location Code" = FIELD("Location Filter")));
            Caption = 'Uavailable Inv. (Whse)';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.17';
            Editable = false;
            FieldClass = FlowField;
        }
        //BC UPGRADE PATHAA02 23.01.26>>

        //BC Upgrade GUNREM01 >>
        field(50024; "Strength Method FND"; Option)
        {
            Caption = 'Strength Method';
            OptionMembers = "Fixed","Variable";
            DataClassification = ToBeClassified;
        }

        field(50025; "New Location Code FND"; Text[30])
        {
            Caption = 'New Location Code';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //BC Upgrade GUNREM01 <<
        // field(50030; "Item Interface Code for Astro"; Code[20])
        // {
        //     Caption = 'Item Interface Code for Astro';
        //     Description = 'HEI.24';
        //     Editable = false;
        //     //TableRelation = "Interface Setup";  // BC Upgrade NANDIS03 - Blocked as "Interface Setup" table moved in Interface Extension 
        // }
        // field(50031; "Item Parked for Astro"; Boolean)
        // {
        //     Caption = 'Item Parked for Astro';
        //     Description = 'HEI.24';
        //     Editable = false;
        // }
        // field(50032; "Last Parked Date for Astro"; Date)
        // {
        //     Caption = 'Last Parked Date for Astro';
        //     Description = 'HEI.24';
        //     Editable = false;
        // }
        // field(50033; "Last Parked Time for Astro"; Time)
        // {
        //     Caption = 'Last Parked Time for Astro';
        //     Description = 'HEI.24';
        //     Editable = false;
        // }
        //BC UPGRADE PATHAA02 23.01.26<<
        field(50034; "H&S Levy Tax Posting Group FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.28';
            Caption = 'H&S Levy Tax Posting Group';
            TableRelation = "H&S Tax Posting Group FND";
        }
        //Bc Upgrade YADAVM09 Field Added for item Product group>>
        field(50050; "Product Group Code FND"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Product Group Code';
            TableRelation = "Item Product Group BC FND";
        }

        //Bc Upgrade YADAVM09 Field Added for item Product group<<
        //BC Upgrade PATHAA02>>        
        // field(2013610; "Item DDeposit Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Deposit Group Code',
        //                 FRA = 'Code groupe consigne article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Deposit Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013622; "Empty Good"; Boolean)
        // {
        //     CalcFormula = Lookup("Inventory Posting Group"."As Empty Good" where(Code = FIELD("Inventory Posting Group")));
        //     CaptionML = ENU = 'Empty Good',
        //                 FRA = 'Vidange';
        //     Description = 'DITW15.00.00.35';
        //     Editable = false;
        //     FieldClass = FlowField;

        //     trigger OnValidate();
        //     begin
        //         /// DITW16.00.00.43 DDR 30/01/2014 DIT-715 #605 - DITW110.00.09 YHE 14/04/2017 NRQ#13145
        //     end;
        // }
        // field(2013636; "Split Deposit on Invoice"; Boolean)
        // {
        //     CaptionML = ENU = 'Split Deposit on Invoice (Entries)',
        //                 FRA = 'Diviser consigne sur facture (écritures)';
        //     Description = 'DITW16.00.00.42 DIT-715 #370';
        // }
        // field(2013640; "Sales Deposit (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Value Entry"."Sales Deposit Amount (Actual)" where("Item Ledger Entry Type" = CONST(Sale),
        //                                                                            "Item No." = FIELD("No."),
        //                                                                            "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                            "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                            "Location Code" = FIELD("Location Filter"),
        //                                                                            "Posting Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'Sales Deposit (LCY)',
        //                 FRA = 'Consigne vente DS';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013642; "Sales Qty. Deposit (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Value Entry"."Valued Quantity" where("Item Ledger Entry Type" = CONST(Sale),
        //                                                              "Item No." = FIELD("No."),
        //                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                              "Location Code" = FIELD("Location Filter"),
        //                                                              "Posting Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'Sales Qty. Deposit (LCY)',
        //                 FRA = 'Quantité consigne vente DS';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013650; "Purchases Deposit (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Value Entry"."Purchase Deposit Amt. (Actual)" where("Item Ledger Entry Type" = CONST(Purchase),
        //                                                                             "Item No." = FIELD("No."),
        //                                                                             "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                             "Location Code" = FIELD("Location Filter"),
        //                                                                             "Drop Shipment" = FIELD("Drop Shipment Filter"),
        //                                                                             "Variant Code" = FIELD("Variant Filter"),
        //                                                                             "Posting Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'Purchases Deposit (LCY)',
        //                 FRA = 'Consigne achat DS';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013652; "Purchases Qty. Deposit (LCY)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CalcFormula = Sum("Value Entry"."Valued Quantity" where("Item Ledger Entry Type" = CONST(Purchase),
        //                                                              "Item No." = FIELD("No."),
        //                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                              "Location Code" = FIELD("Location Filter"),
        //                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
        //                                                              "Variant Code" = FIELD("Variant Filter"),
        //                                                              "Posting Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'Purchases Qty. Deposit (LCY)',
        //                 FRA = 'Quantité consigne achat DS';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013653; "Deposit Value Method"; Option)
        // {
        //     Caption = 'Deposit Value Method';
        //     Description = 'DITW110.00.11 BL#14417';
        //     OptionMembers = Standard;
        // }
        // field(2013654; "Deposit Value"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Deposit Value';
        //     Description = 'DITW110.00.11 BL#14417';
        // }
        // field(2013666; "Autom. Item Charge"; Option)
        // {
        //     CaptionML = ENU = 'Autom. Item Charge',
        //                 FRA = 'Frais annexes automatique';
        //     Description = 'VC008-DITW15.00.00.01-.37';
        //     InitValue = "Automatic - Before Ext. Texts";
        //     OptionCaptionML = ENU = ' ,Before Ext. Texts,After Ext. Texts,Automatic - Before Ext. Texts,Automatic - After Ext. Texts',
        //                       FRA = ' ,Avant Textes étendus,Après Textes étendus,Automatique - Avant Textes étendus,Automatique - Après Textes étendus';
        //     OptionMembers = " ","Before Ext. Texts","After Ext. Texts","Automatic - Before Ext. Texts","Automatic - After Ext. Texts";
        // }
        // field(2013667; "Item DTax Group Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Tax Group Code',
        //                 FRA = 'Code groupe taxe article';
        //     Description = 'DITW15.00.00.01';
        //     TableRelation = "Drink Tax Group".Code where("Source Type" = CONST(Item));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.38 DDR 12/08/2010 #1217
        //         if (xRec."Item DTax Group Code" <> "Item DTax Group Code") and
        //           ("Item DTax Group Code" <> '')
        //         then begin
        //             DrinkTaxGroup.GET(DrinkTaxGroup."Source Type"::Item, "Item DTax Group Code");
        //             if DrinkTaxGroup."Tax Spec. View Code" <> '' then
        //                 VALIDATE("Tax Spec. View Code", DrinkTaxGroup."Tax Spec. View Code");
        //             if DrinkTaxGroup."AAD Field (Area 23) Code" <> '' then
        //                 VALIDATE("AAD Field (Area 23) Code", DrinkTaxGroup."AAD Field (Area 23) Code");
        //             if DrinkTaxGroup."Product Tax Code" <> '' then
        //                 VALIDATE("Product Tax Code", DrinkTaxGroup."Product Tax Code");
        //             if DrinkTaxGroup."Fiscal Mark  Code" <> '' then
        //                 VALIDATE("Fiscal Mark Code", DrinkTaxGroup."Fiscal Mark  Code");
        //             // <<DITW19.00.08 DDR 17/08/2016 29/09/2016 BL#10443
        //             if DrinkTaxGroup."Strength Spec. Code" <> '' then
        //                 VALIDATE("Strength Spec. Code", DrinkTaxGroup."Strength Spec. Code");
        //             if DrinkTaxGroup."Vol-Strength Spec. Code" <> '' then
        //                 VALIDATE("Vol-Strength Spec. Code", DrinkTaxGroup."Vol-Strength Spec. Code");
        //             VALIDATE("Strength Method", DrinkTaxGroup."Strength Method");
        //             // >>DITW19.00.08 DDR BL#10443
        //         end;
        //         // >>DITW15.00.00.38 DDR
        //     end;
        // }
        // field(2013670; "Sales Tax (LCY)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CalcFormula = Sum("Value Entry"."Sales Tax Amount (Actual)" where("Item Ledger Entry Type" = CONST(Sale),
        //                                                                        "Item No." = FIELD("No."),
        //                                                                        "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                        "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                        "Location Code" = FIELD("Location Filter"),
        //                                                                        "Posting Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'Sales Tax (LCY)',
        //                 FRA = 'Taxe vente DS';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013680; "Purchases Tax (LCY)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CalcFormula = Sum("Value Entry"."Purchase Tax Amount (Actual)" where("Item Ledger Entry Type" = CONST(Purchase),
        //                                                                           "Item No." = FIELD("No."),
        //                                                                           "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                           "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                           "Location Code" = FIELD("Location Filter"),
        //                                                                           "Drop Shipment" = FIELD("Drop Shipment Filter"),
        //                                                                           "Variant Code" = FIELD("Variant Filter"),
        //                                                                           "Posting Date" = FIELD("Date Filter")));
        //     CaptionML = ENU = 'Purchases Tax (LCY)',
        //                 FRA = 'Taxe achat DS';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013714; "Tax Spec. View Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Spec. View Code',
        //                 FRA = 'Code vue spécification taxe';
        //     Description = 'DITW15.00.00.24';
        //     TableRelation = "View Specification Template";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.24 DDR 25/09/2008 - DITW15.00.00.33 DDR 14/05/2009
        //         if (xRec."Tax Spec. View Code" <> "Tax Spec. View Code") then begin
        //             if CurrFieldNo <> 0 then
        //                 if ExistDefaultSpecValue(false) then
        //                     if not
        //                       CONFIRM(
        //                         Text2013660 +
        //                         Text022, false,
        //                         FIELDCAPTION("Tax Spec. View Code"))
        //                     then begin
        //                         "Tax Spec. View Code" := xRec."Tax Spec. View Code";
        //                         exit;
        //                     end;
        //             TaxSpecMgt.DeleteDefaultTaxSpecValue("No.");
        //             TaxSpecMgt.CopyTemplateToDefaultSpec("Tax Spec. View Code", "No.");
        //         end;
        //         // >>DITW15.00.00.33 DDR
        //     end;
        // }
        // field(2013716; "Strength Spec. Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Strength Spec. Code',
        //                 FRA = 'Code contrainte spécification taxe';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 22/11/2016 BL#10443
        //         if ("Strength Method" = "Strength Method"::Fix) and ("Strength Spec. Code" <> xRec."Strength Spec. Code")
        //           and GUIALLOWED then  //HEI.18
        //             TestNoOpenEntriesExist(FIELDCAPTION("Strength Spec. Code"));
        //         // >>DITW19.00.08 DDR BL#10443// <<DITW19.00.08 DDR 19/09/2016 29/09/2016 BL#10443
        //         if "Strength Spec. Code" <> '' then
        //             VALIDATE("Strength Spec. Value", GetGlobalTaxSpecValue("Strength Spec. Code"))
        //         else begin
        //             "Strength Spec. Value" := 0;
        //             ValidateGlobalTaxSpecValue(xRec."Strength Spec. Code", "Strength Spec. Value", true);
        //         end;
        //     end;
        // }
        // field(2013717; "Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Strength Spec. Value"));
        //     CaptionML = ENU = 'Strength Spec. Value',
        //                 FRA = 'Valeur contrainte spécification';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 19/09/2016 29/09/2016 BL#10443
        //         if "Strength Spec. Value" <> 0 then //HEI.26
        //             TESTFIELD("Strength Spec. Code");
        //         // <<DITW19.00.08 DDR 22/11/2016 BL#10443
        //         if ("Strength Method" = "Strength Method"::Fix) and ("Strength Spec. Value" <> xRec."Strength Spec. Value")
        //           and GUIALLOWED then  //HEI.18
        //             TestNoOpenEntriesExist(FIELDCAPTION("Strength Spec. Code"));
        //         // >>DITW19.00.08 DDR BL#10443

        //         //HEI.23>>
        //         if ("Strength Spec. Value" <> xRec."Strength Spec. Value") and GUIALLOWED then
        //             TestNoEntriesExist(FIELDCAPTION("Strength Spec. Value"));
        //         //HEI.23<<

        //         if HasTaxSpecEditable("Strength Spec. Code") then begin
        //             ValidateGlobalTaxSpecValue("Strength Spec. Code", "Strength Spec. Value", false);
        //         end else
        //             if ("Strength Spec. Value" <> 0) and (CurrFieldNo = FIELDNO("Strength Spec. Value")) then
        //                 FIELDERROR("Strength Spec. Value");
        //         "Strength Spec. Value" := GetGlobalTaxSpecValue("Strength Spec. Code");
        //         if ("Strength Spec. Value" <> xRec."Strength Spec. Value") and ("Vol-Strength Spec. Code" <> '') then
        //             VALIDATE("Vol-Strength Spec. Code");
        //     end;
        // }
        // field(2013718; "Vol-Strength Spec. Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Vol-Strength Spec. Code',
        //                 FRA = 'Code spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     TableRelation = "Tax Specification" where(Type = CONST(Specification));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 22/11/2016 BL#10443
        //         if ("Strength Method" = "Strength Method"::Fix) and ("Vol-Strength Spec. Code" <> xRec."Vol-Strength Spec. Code") then
        //             TestNoOpenEntriesExist(FIELDCAPTION("Strength Spec. Code"));
        //         // >>DITW19.00.08 DDR BL#10443
        //         // <<DITW19.00.08 DDR 19/09/2016 29/09/2016 BL#10443
        //         if "Vol-Strength Spec. Code" <> '' then
        //             VALIDATE("Vol-Strength Spec. Value", GetGlobalTaxSpecValue("Vol-Strength Spec. Code"))
        //         else begin
        //             "Vol-Strength Spec. Value" := 0;
        //             ValidateGlobalTaxSpecValue(xRec."Vol-Strength Spec. Code", "Vol-Strength Spec. Value", true);
        //         end;
        //     end;
        // }
        // field(2013719; "Vol-Strength Spec. Value"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Spec. Value"));
        //     AutoFormatType = 2013664;
        //     CaptionClass = GetTaxSpecCaption(1, FIELDNO("Vol-Strength Spec. Value"));
        //     CaptionML = ENU = 'Vol-Strength Spec. Value',
        //                 FRA = 'Valeur spécification contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 19/09/2016 29/09/2016 BL#10443
        //         TESTFIELD("Vol-Strength Spec. Code");
        //         // <<DITW19.00.08 DDR 22/11/2016 BL#10443
        //         if ("Strength Method" = "Strength Method"::Fix) and ("Vol-Strength Spec. Value" <> xRec."Vol-Strength Spec. Value") then
        //             TestNoOpenEntriesExist(FIELDCAPTION("Strength Spec. Code"));
        //         // >>DITW19.00.08 DDR BL#10443
        //         if HasTaxSpecEditable("Vol-Strength Spec. Code") then begin
        //             ValidateGlobalTaxSpecValue("Vol-Strength Spec. Code", "Vol-Strength Spec. Value", false);
        //         end else
        //             if ("Vol-Strength Spec. Value" <> 0) and (CurrFieldNo = FIELDNO("Vol-Strength Spec. Value")) then
        //                 FIELDERROR("Vol-Strength Spec. Value");
        //         "Vol-Strength Spec. Value" := GetGlobalTaxSpecValue("Vol-Strength Spec. Code");
        //     end;
        // }
        // field(2013720; "Strength Method"; Option)
        // {
        //     CaptionML = ENU = 'Strength Method',
        //                 FRA = 'Méthode contrainte';
        //     Description = 'DITW19.00.08 BL#10443';
        //     OptionCaptionML = ENU = 'Fixed,Variable',
        //                       FRA = 'Fixe,Variable';
        //     OptionMembers = Fix,Variable;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW19.00.08 DDR 19/09/2016 29/09/2016 BL#10443
        //         if "Strength Method" = xRec."Strength Method" then
        //             exit;
        //         if GUIALLOWED then  //HEI.18
        //             TestNoEntriesExist(FIELDCAPTION("Strength Method"));
        //     end;
        // }
        // field(2013721; "Vol-Strength Net Change"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Vol-Strength Net Change"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Item Ledger Entry"."Vol-Strength Spec. Value" where("Item No." = FIELD("No."),
        //                                                                             "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                             "Location Code" = FIELD("Location Filter"),
        //                                                                             "Drop Shipment" = FIELD("Drop Shipment Filter"),
        //                                                                             "Posting Date" = FIELD("Date Filter"),
        //                                                                             "Variant Code" = FIELD("Variant Filter"),
        //                                                                             "Lot No." = FIELD("Lot No. Filter"),
        //                                                                             "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionML = ENU = 'Vol-Strength Net Change',
        //                 FRA = 'Solde contrainte volume';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013722; "Loss Vol-Strength Net Change"; Decimal)
        // {
        //     AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Loss Vol-Strength Net Change"));
        //     AutoFormatType = 2013664;
        //     CalcFormula = Sum("Loss Breakdown Entry"."Vol-Strength Spec. Value" where("Item No." = FIELD("No."),
        //                                                                                "Capacity Ledger Entry No." = CONST(0),
        //                                                                                "Location Code" = FIELD("Location Filter"),
        //                                                                                "Posting Date" = FIELD("Date Filter"),
        //                                                                                "Variant Code" = FIELD("Variant Filter"),
        //                                                                                "Lot No." = FIELD("Lot No. Filter"),
        //                                                                                "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionML = ENU = 'Loss Vol-Strength Net Change',
        //                 FRA = 'Perte Solde contrainte volume';
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013727; "AAD Nos."; Code[10])
        // {
        //     CaptionML = ENU = 'AAD Nos.',
        //                 FRA = 'N° AAD';
        //     Description = 'DITW15.00.00.28';
        //     TableRelation = "No. Series";
        // }
        // field(2013753; "AAD Field (Area 23) Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Designation of Origin Std. Text Code',
        //                 FRA = 'Code texte std. Appellation d''Origine';
        //     Description = 'DITW15.00.00.33-.37-.38';
        //     TableRelation = "Standard Text";

        //     trigger OnValidate();
        //     var
        //         StdText: Record "Standard Text";
        //         ValueBigInt: BigInteger;
        //     begin
        //         // <<DITW15.00.00.38 DDR 23/11/2010 #1217 (DIT711 56)
        //         if "AAD Field (Area 23) Code" <> '' then begin
        //             StdText.GET("AAD Field (Area 23) Code");
        //             if StdText.Description <> '' then begin
        //                 if not EVALUATE(ValueBigInt, FORMAT(StdText.Description)) then
        //                     FIELDERROR("AAD Field (Area 23) Code", Text2014260);
        //                 if STRLEN(FORMAT(ValueBigInt)) > 15 then
        //                     FIELDERROR("AAD Field (Area 23) Code", Text2014261);
        //             end;
        //         end;
        //         // >>DITW15.00.00.38 #1217
        //     end;
        // }
        // field(2013760; "Volume Unit of Measure Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Volume Unit of Measure Code',
        //                 FRA = 'Unité de volume';
        //     Description = 'DITW17.00.02 DIT-770 #147';
        //     TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("No."));

        //     trigger OnValidate();
        //     var
        //         Tgtext0001: TextConst ENU = 'The Volume Unit must be %1.', FRA = 'Le volume unitaire doit être %1';
        //         RecItemunitofMeasure: Record "Item Unit of Measure";
        //     begin
        //         //<<DITW17.00.02 SR 12/03/2013 DIT-770 #147
        //         if "Volume Unit of Measure Code" <> '' then begin
        //             InvtSetup.GET;
        //             InvtSetup.TESTFIELD(InvtSetup."Volume Unit of Measure Code");
        //             if InvtSetup."Volume Unit of Measure Code" <> "Volume Unit of Measure Code" then
        //                 ERROR(Tgtext0001, InvtSetup."Volume Unit of Measure Code");

        //             if RecItemunitofMeasure.GET("No.", "Volume Unit of Measure Code") then begin
        //                 RecItemunitofMeasure.TESTFIELD("Qty. per Unit of Measure");
        //                 // <<DITW17.00.02 DDR 10/12/2013 DIT-770 #233
        //                 "Unit Volume HL" := ROUND(1 / RecItemunitofMeasure."Qty. per Unit of Measure", 0.00001);
        //                 // >>DITW17.00.02 DDR DIT-770 #233
        //             end;
        //         end else
        //             "Unit Volume HL" := 0;
        //         //>>DITW17.00.02 SR DIT-770 #147
        //     end;
        // }
        // field(2013763; "No. of Drink Disc. Groups"; Integer)
        // {
        //     CalcFormula = Count("Drink Discount Relation" where("Source Type" = CONST(Item),
        //                                                          "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'No. of Drink-It Disc. Groups',
        //                 FRA = 'Nombre de Drink-It Groupes remises';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013766; "No. of Promotion Groups"; Integer)
        // {
        //     CalcFormula = Count("Drink Promotion Relation" where("Source Type" = CONST(Item),
        //                                                           "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'No. of Promotion Groups',
        //                 FRA = 'Nombre de Groupes promotions';
        //     Description = 'DITW15.00.00.01';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013767; "Unit Volume HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Unit Volume HL"));
        //     CaptionML = ENU = 'Unit Volume',
        //                 FRA = 'Volume unitaire';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01-.32';
        //     Editable = false;
        //     MinValue = 0;
        // }
        // field(2013768; "Inventory HL"; Decimal)
        // {
        //     CalcFormula = Sum("Item Ledger Entry"."Quantity in HL" where("Item No." = FIELD("No."),
        //                                                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                   "Location Code" = FIELD("Location Filter"),
        //                                                                   "Drop Shipment" = FIELD("Drop Shipment Filter"),
        //                                                                   "Variant Code" = FIELD("Variant Filter"),
        //                                                                   "Lot No." = FIELD("Lot No. Filter"),
        //                                                                   "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Inventory HL"));
        //     CaptionML = ENU = 'Inventory',
        //                 FRA = 'Stock';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013769; "Net Change HL"; Decimal)
        // {
        //     CalcFormula = Sum("Item Ledger Entry"."Quantity in HL" where("Item No." = FIELD("No."),
        //                                                                   "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                   "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                   "Location Code" = FIELD("Location Filter"),
        //                                                                   "Drop Shipment" = FIELD("Drop Shipment Filter"),
        //                                                                   "Posting Date" = FIELD("Date Filter"),
        //                                                                   "Variant Code" = FIELD("Variant Filter"),
        //                                                                   "Lot No." = FIELD("Lot No. Filter"),
        //                                                                   "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Net Change HL"));
        //     CaptionML = ENU = 'Net Change',
        //                 FRA = 'Solde période';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW19.00.08 BL#10443';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2013771; "Purchase Net Cost"; Decimal)
        // {
        //     CaptionML = DEU = 'EK Preis (Netto)',
        //                 ENU = 'Purchase Net Cost';
        //     Description = 'DITW110.00.11 SFI BL#10509';
        //     Editable = false;
        // }
        // field(2013803; "Allow VAT Calculation (Free)"; Boolean)
        // {
        //     CaptionML = ENU = 'Allow VAT Calculation (Free)',
        //                 FRA = 'Autoriser calcul TVA (Gratuit)';
        //     Description = 'DITW16.00.00.40 DIT-715 #172';
        // }
        // field(2013804; "Item DDisc. Group Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Discount Group Filter',
        //                 FRA = 'Filtre groupe remise article';
        //     Description = 'DITW16.00.00.41 DIT-715 #378';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Drink Discount Group".Code where("Source Type" = CONST(Item));
        // }
        // field(2013824; "Gen. Prod. Posting Free Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Gen. Prod. Posting Group Free Item',
        //                 FRA = 'Groupe article gratuit compta. produit';
        //     Description = 'DITW15.00.00.35';
        //     TableRelation = "Gen. Product Posting Group";

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         if "Gen. Prod. Posting Free Group" = '' then begin
        //             "Free Item Posting Type" := "Free Item Posting Type"::" ";
        //             "Free Item" := false;
        //             //<< DITW110.00.12A ISL 21/06/2018 NRQ#67425
        //             "Free Item (Purchase)" := false;
        //             //>> DITW110.00.12A ISL NRQ#67425
        //             // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        //             "Allow VAT Calculation (Free)" := false;
        //             // >>DITW16.00.00.40 DDR DIT-715 #172
        //         end;
        //     end;
        // }
        // field(2013825; "Free Item Posting Type"; Option)
        // {
        //     CaptionML = ENU = 'Calculate Price on Free',
        //                 FRA = 'Calculer Prix sur gratuit';
        //     Description = 'DITW15.00.00.35';
        //     OptionCaptionML = ENU = ' ,Price 0,Discount 100%',
        //                       FRA = ' ,Prix 0,Remise 100%';
        //     OptionMembers = " ",Price,Amount;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         if "Free Item Posting Type" = "Free Item Posting Type"::" " then begin
        //             "Gen. Prod. Posting Free Group" := '';
        //             "Free Item" := false;
        //             //<< DITW110.00.12A ISL 21/06/2018 NRQ#67425
        //             "Free Item (Purchase)" := false;
        //             //>> DITW110.00.12A ISL NRQ#67425
        //             // <<DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172
        //             "Allow VAT Calculation (Free)" := false;
        //             // >>DITW16.00.00.40 DDR DIT-715 #172
        //         end;
        //     end;
        // }
        // field(2013826; "Free Item"; Boolean)
        // {
        //     CaptionML = ENU = 'Free Item',
        //                 FRA = 'Article gratuit';
        //     Description = 'DITW15.00.00.35 - DITW110.00.12A  NRQ#67425';

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.35 DDR 24/06/2009
        //         if "Free Item" then begin
        //             TESTFIELD("Item Disc. Group", '');
        //             TESTFIELD("Gen. Prod. Posting Free Group");
        //             TESTFIELD("Free Item Posting Type");
        //             if "Free Item Posting Type" = "Free Item Posting Type"::Price then begin
        //                 TESTFIELD("Unit Price", 0);
        //                 TestNoSalesPriceExist(true, FIELDCAPTION("Free Item"));
        //                 /// DITW110.00.12A ISL 21/06/2018 NRQ#67425
        //             end;
        //             if "Free Item Posting Type" <> "Free Item Posting Type"::" " then begin
        //                 TestNoSalesLineDiscExist(true, FIELDCAPTION("Free Item"));
        //                 /// DITW110.00.12A ISL 21/06/2018 NRQ#67425
        //             end;
        //         end;
        //     end;
        // }
        // field(2013827; "Free Reason Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Free Reason Code (Sales)',
        //                 FRA = 'Code motif gratuit';
        //     Description = 'DITW17.00.02 DIT-770 #132 - DITW110.00.12A  NRQ#67425';
        //     TableRelation = "Free Reason Code";
        // }
        // field(2013960; "Pos System"; Option)
        // {
        //     CaptionML = ENU = 'POS System',
        //                 FRA = 'Système POS';
        //     Description = 'DITW15.00.00.39 #1328';
        //     OptionCaptionML = ENU = ' ,Yes,Blocked',
        //                       FRA = ' ,Oui,Bloqué';
        //     OptionMembers = " ",Yes,No;

        //     trigger OnValidate();
        //     var
        //         xRecRef: RecordRef;
        //         RecRef: RecordRef;
        //         ItemUOM: Record "Item Unit of Measure";
        //         ItemUOM2: Record "Item Unit of Measure";
        //         PosChangeLogMgt: Codeunit "Pos Change Log Management";
        //         Confirmed: Boolean;
        //     begin
        //         // <<DITW15.00.00.39 DDR 09/05/2011 #1328
        //         if "Pos System" <> "Pos System"::" " then begin
        //             TESTFIELD("Allow Invoice Disc.", false);
        //         end else begin
        //             CLEAR("Pos System Timestamp");
        //             ItemUOM.RESET;
        //             ItemUOM.SETRANGE("Item No.", "No.");
        //             ItemUOM.SETFILTER("Pos System", '<>%1', "Pos System"::" ");
        //             if ItemUOM.findset then
        //                 repeat
        //                     ItemUOM2 := ItemUOM;
        //                     ItemUOM2."Pos System" := ItemUOM."Pos System"::" ";
        //                     ItemUOM2."Pos System Timestamp" := 0DT;
        //                     ItemUOM2.MODIFY(true);
        //                     xRecRef.GETTABLE(ItemUOM);
        //                     RecRef.GETTABLE(ItemUOM2);
        //                     // <<DITW17.00.01 DDR 13/02/2013 DIT-770 #001
        //                     PosChangeLogMgt.LogModification(RecRef);
        //                 // >>DITW17.00.01 DDR DIT-770 #001
        //                 until ItemUOM.NEXT = 0;
        //         end;
        //     end;
        // }
        // field(2013961; "Pos System Timestamp"; DateTime)
        // {
        //     CaptionML = ENU = 'POS System Timestamp',
        //                 FRA = 'Horodateur système POS';
        //     Description = 'DITW15.00.00.39 #1328';
        // }
        // field(2014060; "Return Reason Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Return Reason Code',
        //                 FRA = 'St. Code raison retour';
        //     Description = 'DITW17.00.02 DIT-770 #145';
        //     TableRelation = "Return Reason".Code;
        // }
        // field(2014061; "Manco/Surplus Tolerance %"; Decimal)
        // {
        //     CaptionML = ENU = 'Manco/Surplus Tolerance %',
        //                 FRA = '% Manco/Surplus Tolérance';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW18.00.07 DIT-770 #1702';
        //     MaxValue = 100;
        //     MinValue = 0;
        // }
        // field(2014062; "Item Delivery Type"; Code[10])
        // {
        //     CaptionML = ENU = 'Item Delivery Type',
        //                 FRA = 'Type de Livraison Article';
        //     Description = 'DITW18.00.07 DIT-770 #1346';
        //     TableRelation = "Delivery Type".Code where(Type = CONST(Item));
        // }
        // field(2014063; "Backorder Type"; Option)
        // {
        //     Caption = 'Backorder Type';
        //     Description = 'DITW110.00.10 BL#15657';
        //     OptionCaption = '" ,Backorder,No Backorder"';
        //     OptionMembers = " ",Backorder,"No Backorder";
        // }
        // field(2014064; "Qty. on Sales Blanket Order"; Decimal)
        // {
        //     AccessByPermission = TableData "Sales Shipment Header" = R;
        //     CalcFormula = Sum("Sales Line"."Outstanding Qty. (Base)" where("Document Type" = CONST("Blanket Order"),
        //                                                                     Type = CONST(Item),
        //                                                                     "No." = FIELD("No."),
        //                                                                     "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                     "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                     "Location Code" = FIELD("Location Filter"),
        //                                                                     "Drop Shipment" = FIELD("Drop Shipment Filter"),
        //                                                                     "Variant Code" = FIELD("Variant Filter"),
        //                                                                     "Shipment Date" = FIELD("Date Filter")));
        //     Caption = 'Qty. on Sales Blanket Order';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW110.00.10 BL#15657';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014065; "Negative Qty. on Item Journal"; Decimal)
        // {
        //     CalcFormula = Sum("Item Journal Line"."Quantity (Base)" where("Item No." = FIELD("No."),
        //                                                                    "Route Planning No." = FIELD("Route Planning No. Filter"),
        //                                                                    "Entry Type" = CONST("Negative Adjmt.")));
        //     Caption = 'Negative Qty. on Item Journal';
        //     Description = 'NRQ#16224-NRQ#39012';
        //     FieldClass = FlowField;
        // }
        // field(2014066; "Qty. on Item Ledger entries"; Decimal)
        // {
        //     CalcFormula = Sum("Item Ledger Entry".Quantity where("Item No." = FIELD("No."),
        //                                                           "Route Planning No." = FIELD("Route Planning No. Filter")));
        //     Caption = 'Qty. on Item Ledger entries';
        //     Description = 'NRQ#16224';
        //     FieldClass = FlowField;
        // }
        // field(2014067; "Positive Qty. on Item Journal"; Decimal)
        // {
        //     CalcFormula = Sum("Item Journal Line"."Quantity (Base)" where("Item No." = FIELD("No."),
        //                                                                    "Route Planning No." = FIELD("Route Planning No. Filter"),
        //                                                                    "Entry Type" = CONST("Positive Adjmt.")));
        //     Caption = 'Positive Qty. on Item Journal';
        //     Description = 'NRQ#39012';
        //     FieldClass = FlowField;
        // }
        // field(2014109; "Route Planning No. Filter"; Code[20])
        // {
        //     Caption = 'Route Planning No.';
        //     Description = 'DITW18.00.07 #1488-NRQ#16224';
        //     FieldClass = FlowFilter;
        // }
        // field(2014110; "Document No. Filter"; Code[20])
        // {
        //     Caption = 'Document No. Filter';
        //     Description = 'NRQ#16224';
        //     FieldClass = FlowFilter;
        // }
        // field(2014265; "Product Tax Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Tax Product Code',
        //                 FRA = 'Code Produit taxe';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Tax Product";
        // }
        // field(2014266; "Fiscal Mark Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Fiscal Mark Std. Text Code',
        //                 FRA = 'Code texte std. Marque Fiscale';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Standard Text";
        // }
        // field(2014278; "Wine Product Category"; Option)
        // {
        //     CaptionML = ENU = 'Wine Product Category',
        //                 FRA = 'Catégorie produit vin';
        //     Description = 'DITW15-.38 #1217 - .40 DIT-715 #187 #222';
        //     OptionCaptionML = ENU = ' ,Wine without BOB/BGA,Cepage wine with BOB/BGA,Wine with BOB/BGA,Wine Imported,Other',
        //                       FRA = ' ,Vin sans BOB/BGA,Cépage de vin avec BOB/BGA,Vin avec BOB/BGA,Vin importé,Autre';
        //     OptionMembers = " ",WineNoBob,CepageWithBob,WineWithBob,Imported,Other;

        //     trigger OnValidate();
        //     begin
        //         // <<DITW16.00.00.40 DDR 21/02/2012 DIT-715 #222
        //         if ("Wine Product Category" = "Wine Product Category"::Imported) and
        //           ("Country/Region of Origin Code" <> '')
        //         then begin
        //             Country.GET("Country/Region of Origin Code");
        //             if Country."EU Country/Region Code" <> '' then
        //                 ERROR(Text2013662,
        //                   FIELDCAPTION("Country/Region of Origin Code"), "Country/Region of Origin Code",
        //                   Country.FIELDCAPTION("EU Country/Region Code"),
        //                   FIELDCAPTION("Wine Product Category"), "Wine Product Category");
        //         end;
        //         // >>DITW16.00.00.40 DDR DIT-715 #222
        //     end;
        // }
        // field(2014279; "Wine Growing zone"; Code[10])
        // {
        //     CaptionML = ENU = 'Wine Growing zone Code',
        //                 FRA = 'Code Zone viticole';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Wine Growing zone".Code where("Country/Region of Origin Code" = FIELD("Country/Region of Origin Code"));

        //     trigger OnValidate();
        //     begin
        //         TESTFIELD("Country/Region of Origin Code");
        //     end;
        // }
        // field(2014280; "Wine Operation Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Wine Operation Code',
        //                 FRA = 'Code opération vin';
        //     Description = 'DITW15.00.00.38 #1217';
        //     TableRelation = "Wine Operation Code";
        // }
        // field(2014313; "Sales (Qty.) HL"; Decimal)
        // {
        //     CalcFormula = - Sum("Value Entry"."Invoiced Quantity in HL" where("Item Ledger Entry Type" = CONST(Sale),
        //                                                                       "Item No." = FIELD("No."),
        //                                                                       "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                       "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                       "Location Code" = FIELD("Location Filter"),
        //                                                                       "Drop Shipment" = FIELD("Drop Shipment Filter"),
        //                                                                       "Variant Code" = FIELD("Variant Filter"),
        //                                                                       "Posting Date" = FIELD("Date Filter"),
        //                                                                       "Item DDisc. Group Code" = FIELD("Item DDisc. Group Filter")));
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Sales (Qty.) HL"));
        //     CaptionML = ENU = 'Sales (Qty.)',
        //                 FRA = 'Ventes (qté)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.41 DIT-715 #378';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014314; "Sales Indirect (Qty.) HL"; Decimal)
        // {
        //     CalcFormula = Sum("Indirect Cust. Ledger Entry"."Quantity HL" where("Item No." = FIELD("No."),
        //                                                                          "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                          "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                          "Posting Date" = FIELD("Date Filter"),
        //                                                                          "Item DDisc. Group Code" = FIELD("Item DDisc. Group Filter")));
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Sales Indirect (Qty.) HL"));
        //     CaptionML = ENU = 'Sales (Qty.)',
        //                 FRA = 'Ventes (qté)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW16.00.00.41 DIT-715 #378';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014362; "Reverse Location Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Return Location Code',
        //                 FRA = 'Code magasin (inverse)';
        //     Description = 'DIT-715 #247 - DITW19.00.08 BL#10756';
        //     TableRelation = Location where("Use As In-Transit" = CONST(false));
        // }
        // field(2014410; "Gift Box Item"; Boolean)
        // {
        //     CaptionML = ENU = 'Gift Box Item',
        //                 FRA = 'Coffret Article';
        //     Description = 'DIT-715 #519';
        // }
        // field(2014411; "Positive Adjmt. (Qty. Base)"; Decimal)
        // {
        //     CalcFormula = Sum("Item Ledger Entry".Quantity where("Item No." = FIELD("No."),
        //                                                           "Route Planning No." = FIELD("Route Planning No. Filter"),
        //                                                           "Entry Type" = CONST("Positive Adjmt.")));
        //     Caption = 'Positive Adjmt. (Qty. Base)';
        //     Description = 'NRQ#16224';
        //     FieldClass = FlowField;
        // }
        // field(2014412; "Negative Adjmt. (Qty. Base)"; Decimal)
        // {
        //     CalcFormula = Sum("Item Ledger Entry".Quantity where("Item No." = FIELD("No."),
        //                                                           "Route Planning No." = FIELD("Route Planning No. Filter"),
        //                                                           "Entry Type" = CONST("Negative Adjmt.")));
        //     Caption = 'Negative Adjmt. (Qty. Base)';
        //     Description = 'NRQ#16224';
        //     FieldClass = FlowField;
        // }
        // field(2014413; "Treeview Code"; Code[20])
        // {
        //     CaptionML = ENU = 'Treeview Group Code',
        //                 FRA = 'Code groupe Treeview';
        //     Description = 'DITW15.00.00.39 #1393';
        //     TableRelation = "Treeview Setup - Group";
        // }
        // field(2014414; "Treeview Code2"; Code[20])
        // {
        //     CaptionML = ENU = 'Treeview Group Code 2',
        //                 FRA = 'Code groupe Treeview 2';
        //     Description = 'DITW15.00.00.39 #1393';
        //     TableRelation = "Treeview Setup - Group";
        // }
        // field(2014415; "Treeview Level"; Integer)
        // {
        //     CaptionML = ENU = 'Treeview Level',
        //                 FRA = 'Niveau Treeview';
        //     Description = 'DITW15.00.00.39 #1393';
        // }
        // field(2014416; "Belongs Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Related to Item No.',
        //                 FRA = 'N° article lié';
        //     Description = 'DITW15.00.00.39 #1393';
        //     TableRelation = Item where("Plant Maintenance Caption" = FIELD("Plant Maintenance Caption"));

        //     trigger OnValidate();
        //     var
        //         TreeItem: Record "Treeview Setup - Item";
        //         Item: Record Item;
        //     begin
        //         // <<DITW15.00.00.39 DDR 11/08/2011 #1393
        //         if "Belongs Item No." <> xRec."Belongs Item No." then begin
        //             if "Belongs Item No." <> '' then begin
        //                 // existing highest level (orphan)
        //                 if TreeItem.GET("No.") and
        //                   (TreeItem."Belongs Item No." = xRec."Belongs Item No.") and
        //                   (xRec."Belongs Item No." <> '')
        //                 then begin
        //                     TreeItem.DELETE(true);
        //                     if TreeItem."Item No." <> "No." then begin
        //                         Item.GET(TreeItem."Item No.");
        //                         Item."Belongs Item No." := '';
        //                         Item.MODIFY;
        //                     end;
        //                 end;
        //                 TreeItem.SETCURRENTKEY("Belongs Item No.");
        //                 TreeItem.SETRANGE("Belongs Item No.", xRec."Belongs Item No.");
        //                 if TreeItem.ISEMPTY then begin
        //                     if TreeItem.GET(xRec."Belongs Item No.") then
        //                         TreeItem.DELETE(true);
        //                 end;
        //                 // existing highest level
        //                 if not TreeItem.GET("Belongs Item No.") then begin
        //                     TreeItem.INIT;
        //                     TreeItem.VALIDATE("Item No.", "Belongs Item No.");
        //                     TreeItem.INSERT;
        //                     if TreeItem."Item No." <> "No." then begin
        //                         Item.GET(TreeItem."Item No.");
        //                         Item."Belongs Item No." := "Belongs Item No.";
        //                         Item.MODIFY;
        //                     end;
        //                 end;
        //                 // insert new belongs or highest level
        //                 if TreeItem.GET("No.") then begin
        //                     if "No." <> "Belongs Item No." then
        //                         TreeItem.VALIDATE("Belongs Item No.", "Belongs Item No.");
        //                     TreeItem.MODIFY;
        //                 end else begin
        //                     TreeItem.INIT;
        //                     TreeItem.VALIDATE("Item No.", "No.");
        //                     if "No." <> "Belongs Item No." then
        //                         TreeItem.VALIDATE("Belongs Item No.", "Belongs Item No.");
        //                     TreeItem.INSERT;
        //                 end;
        //             end else begin

        //                 // remove belongs or highest level
        //                 if TreeItem.GET("No.") and
        //                   (TreeItem."Belongs Item No." = xRec."Belongs Item No.") and
        //                   (xRec."Belongs Item No." <> '')
        //                 then
        //                     TreeItem.DELETE(true);
        //                 // existing highest level (orphan)
        //                 TreeItem.SETCURRENTKEY("Belongs Item No.");
        //                 TreeItem.SETRANGE("Belongs Item No.", xRec."Belongs Item No.");
        //                 if TreeItem.ISEMPTY then begin
        //                     if TreeItem.GET(xRec."Belongs Item No.") then begin
        //                         TreeItem.DELETE(true);
        //                         if TreeItem."Item No." <> "No." then begin
        //                             Item.GET(TreeItem."Item No.");
        //                             Item."Belongs Item No." := '';
        //                             Item.MODIFY;
        //                         end;
        //                     end;
        //                 end;
        //             end;
        //         end;

        //         // >>DITW15.00.00.39 DDR #1393
        //     end;
        // }
        // field(2014418; "Treeview Line No."; Integer)
        // {
        //     CaptionML = ENU = 'Treeview Line No.',
        //                 FRA = 'N° ligne Treeview';
        //     Description = 'DITW15.00.00.39 #1393';
        // }
        // field(2014419; "Brand Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Brand code',
        //                 FRA = 'Code Marque';
        //     Description = 'DITW17.10.03 DIT-770 #393';
        //     TableRelation = Brands;
        // }
        // field(2014423; "No. of Exclusivity Groups"; Integer)
        // {
        //     CalcFormula = Count("Item Exclusivity Relation" where("Source Type" = CONST(Item),
        //                                                            "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'No. of Exclusivity Groups',
        //                 FRA = 'Nombre de Groupes exclusivité';
        //     Description = 'DITW15.00.00.39';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2014424; "No. of Quota Groups"; Integer)
        // {
        //     CalcFormula = Count("Item Quota Relation" where("Source Type" = CONST(Item),
        //                                                      "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'No. of Quota Groups',
        //                 FRA = 'Nombre de groupes de quotas';
        //     Description = 'DITW17.10.03 DDR 13/06/14 DIT-770 #392';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }

        //BC Upgrade Kamnay01 >>Added Drinkit field
        field(50052; "Production Unit of Measure FND"; Code[10])
        {
            Caption = 'Production Unit of Measure';
            Description = 'DITW110.00.12 NRQ#64704';
            TableRelation = IF ("No." = FILTER(<> '')) "Item Unit of Measure".Code where("Item No." = FIELD("No."))
            else
            "Unit of Measure";
        }
        //BC Upgrade Kamnay01 << Added Drinkit field

        // field(2014427; "Inventory Unit of Measure"; Code[10])
        // {
        //     Caption = 'Production Unit of Measure';
        //     Description = 'DITW110.00.12 NRQ#64704';
        //     TableRelation = IF ("No." = FILTER(<> '')) "Item Unit of Measure".Code where("Item No." = FIELD("No."))
        //     else
        //     "Unit of Measure";
        // }

        //HEI.28>>
        field(50051; "Inventory Unit of Measure FND"; Code[10])
        {
            Caption = 'Inventory Unit of Measure';
            Description = 'HEI.28';//DITW110.00.12 NRQ#64704
            TableRelation = IF ("No." = FILTER(<> '')) "Item Unit of Measure".Code where("Item No." = FIELD("No."))
            else
            "Unit of Measure";
        }
        //HEI.28<<

        //BC Upgrade Kamnay01 adding this Drinkit field for mendix>>

           field(50053; "Sales Price Warning FND"; Option)
        {
            Caption = 'Sales Price Warning';
            OptionMembers = Default,"No Warning",Warning,Blocked;
        }
        //BC Upgrade Kamnay01 adding this Drinkit field for mendix<<

        // field(2014440; Exclusivity; Boolean)
        // {
        //     CaptionML = ENU = 'Private Label Exclusivity',
        //                 FRA = 'Exculisivité label privé';
        //     Description = 'DITW16.00.00.43 DIT-715 #497';
        // }
        // field(2014441; "Location Code"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Code',
        //                 FRA = 'Code magasin';
        //     Description = 'DITW15.00.00.30';
        //     TableRelation = Location where("Use As In-Transit" = CONST(false));
        // }
        // field(2014442; "Modified Unit Price"; Boolean)
        // {
        //     CaptionML = ENU = 'Modified Unit Price',
        //                 FRA = 'Prix unitaire modifié';
        //     Description = 'DITW16.00.00.43 DDR 14/08/2013 DIT-715 #605';
        // }
        // field(2014454; "Value Douane"; Decimal)
        // {
        //     CaptionML = ENU = 'Customs Value',
        //                 FRA = 'Valeur Douane';
        //     Description = 'DITW15.00.00.36';
        // }
        // field(2014505; "Location Relationship Filter"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Relationship Filter',
        //                 FRA = 'Filtre relation magasin';
        //     Description = 'DITW15.00.00.39 #1365';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Location Relationship"."Location Code" where(Code = FIELD("Location Filter"));

        //     trigger OnValidate();
        //     begin
        //         // <<DITW15.00.00.39 DDR 15/09/2011 #1365 - DITW17.00.01 DDR 13/02/2013 DIT-770 #001
        //         InvtSetup.GET;
        //         if (InvtSetup."Stockout Warning (Relation)" = InvtSetup."Stockout Warning (Relation)"::" ") and
        //           (GETFILTER("Location Relationship Filter") <> '')
        //         then
        //             InvtSetup.FIELDERROR("Stockout Warning (Relation)");

        //         if GETFILTER("Location Relationship Filter") = '' then
        //             COPYFILTER("Location Filter", "Location Relationship Filter");
        //         // >>DITW15.00.00.39 DDR #1365 - DITW17.00.01 DDR 13/02/2013 DIT-770 #001
        //     end;
        // }
        // field(2014512; "No. of Loyalty Groups"; Integer)
        // {
        //     CalcFormula = Count("Loyalty Relation" where("Source Type" = CONST(Item),
        //                                                   "Source No." = FIELD("No.")));
        //     CaptionML = ENU = 'No. of Loyalty Groups',
        //                 FRA = 'Nre de Groupes Fidélité';
        //     Description = 'DITW16.00.00.40 DIT-715 #243';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2029610; "Shortcut Property 1 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,1/27';
        //     CaptionML = ENU = 'Shortcut Property 1 Code',
        //                 FRA = 'Code raccourci propriété 1';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(1));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 1 Code" := fctValidateShortcutPropertyCode(1, "Shortcut Property 1 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029611; "Shortcut Property 2 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,2/27';
        //     CaptionML = ENU = 'Shortcut Property 2 Code',
        //                 FRA = 'Code raccourci propriété 2';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(2));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 2 Code" := fctValidateShortcutPropertyCode(2, "Shortcut Property 2 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029612; "Shortcut Property 3 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,3/27';
        //     CaptionML = ENU = 'Shortcut Property 3 Code',
        //                 FRA = 'Code raccourci propriété 3';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(3));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 3 Code" := fctValidateShortcutPropertyCode(3, "Shortcut Property 3 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029613; "Shortcut Property 4 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,4/27';
        //     CaptionML = ENU = 'Shortcut Property 4 Code',
        //                 FRA = 'Code raccourci propriété 4';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(4));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 4 Code" := fctValidateShortcutPropertyCode(4, "Shortcut Property 4 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029614; "Shortcut Property 5 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,5/27';
        //     CaptionML = ENU = 'Shortcut Property 5 Code',
        //                 FRA = 'Code raccourci propriété 5';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(5));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 5 Code" := fctValidateShortcutPropertyCode(5, "Shortcut Property 5 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029615; "Shortcut Property 6 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,6/27';
        //     CaptionML = ENU = 'Shortcut Property 6 Code',
        //                 FRA = 'Code raccourci propriété 6';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(6));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 6 Code" := fctValidateShortcutPropertyCode(6, "Shortcut Property 6 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029616; "Shortcut Property 7 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,7/27';
        //     CaptionML = ENU = 'Shortcut Property 7 Code',
        //                 FRA = 'Code raccourci propriété 7';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(7));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 7 Code" := fctValidateShortcutPropertyCode(7, "Shortcut Property 7 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029617; "Shortcut Property 8 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,8/27';
        //     CaptionML = ENU = 'Shortcut Property 8 Code',
        //                 FRA = 'Code raccourci propriété 8';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(8));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 8 Code" := fctValidateShortcutPropertyCode(8, "Shortcut Property 8 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029618; "Shortcut Property 9 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,9/27';
        //     CaptionML = ENU = 'Shortcut Property 9 Code',
        //                 FRA = 'Code raccourci propriété 9';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(9));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 9 Code" := fctValidateShortcutPropertyCode(9, "Shortcut Property 9 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029619; "Shortcut Property 10 Code"; Code[20])
        // {
        //     CaptionClass = '2029610,2,10/27';
        //     CaptionML = ENU = 'Shortcut Property 10 Code',
        //                 FRA = 'Code raccourci propriété 10';
        //     Description = 'FINXL9.00';
        //     TableRelation = "Property Value".Code where("Table ID" = CONST(27),
        //                                                  "Property Code" = FILTER(<> ''),
        //                                                  "Shortcut No." = CONST(10));
        //     //This property is currently not supported
        //     //TestTableRelation = false;
        //     ValidateTableRelation = false;

        //     trigger OnValidate();
        //     begin
        //         "Shortcut Property 10 Code" := fctValidateShortcutPropertyCode(10, "Shortcut Property 10 Code");  //FINXL9.00.001 DAT 07/03/2016
        //     end;
        // }
        // field(2029620; "Location Code XL"; Code[10])
        // {
        //     CaptionML = ENU = 'Location Code XL',
        //                 FRA = 'Code magasin';
        //     Description = 'FINXL8.00.001';
        //     TableRelation = Location where("Use As In-Transit" = CONST(false));
        // }
        // field(2029621; "Purchase Price Warning"; Option)
        // {
        //     CaptionML = ENU = 'Purchase Price Warning',
        //                 FRB = 'Ignore l''obligation Prix d''achat',
        //                 NLB = 'Verplichte ink. prijs negeren';
        //     Description = 'FINXL10.01';
        //     OptionCaptionML = ENU = 'Default,No Warning,Warning,Blocked',
        //                       FRB = 'Default,Pas d''alerte,Alerte,Bloqué',
        //                       NLB = 'Default,Geen waarschuwing, Waarschuwing Blokkeren';
        //     OptionMembers = Default,"No Warning",Warning,Blocked;
        // }
        // field(2029622; "Sales Price Warning"; Option)
        // {
        //     CaptionML = ENU = 'Sales Price Warning',
        //                 FRB = 'Ignore l''obligation Prix de vente',
        //                 NLB = 'Verplichte verk. prijs negeren';
        //     Description = 'FINXL10.01';
        //     OptionCaptionML = ENU = 'Default,No Warning,Warning,Blocked',
        //                       FRB = 'Default,Pas d''alerte,Alerte,Bloqué',
        //                       NLB = 'Default,Geen waarschuwing, Waarschuwing Blokkeren';
        //     OptionMembers = Default,"No Warning",Warning,Blocked;
        // }
        // field(2034850; "DIT Sub-Contract Type Filter"; Option)
        // {
        //     CaptionML = ENU = 'Sub Contract Type Filter',
        //                 FRA = 'Filtre sous type contrat';
        //     Description = 'DITW15.00.00.37- DIT-715 #297';
        //     FieldClass = FlowFilter;
        //     OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
        //                       FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
        //     OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
        // }
        // field(2034942; "Plant Maintenance Caption"; Boolean)
        // {
        //     CaptionML = ENU = 'Plant Maintenance Caption',
        //                 FRA = 'Label Maintenance Usine';
        //     Description = 'DITW16.00.00.41 DIT-715 #297';
        //     FieldClass = FlowFilter;
        // }
        // field(2034957; "Service Order No. Filter"; Code[20])
        // {
        //     CaptionML = ENU = 'Work Order Filter',
        //                 FRA = 'Filtre ordre d''intervention';
        //     Description = 'DITW16.00.00.41 #297';
        //     FieldClass = FlowFilter;
        //     TableRelation = "Service Header"."No." where("Document Type" = CONST(Order),
        //                                                   "PM Order Status" = CONST(Released));
        // }
        // field(2034977; "Org. Manufacturer (OEM)"; Code[20])
        // {
        //     CaptionML = ENU = 'Org.Manufacturer (OEM)',
        //                 FRA = 'Fabricant initial (OEM)';
        //     Description = 'DIT-715 #454';
        //     TableRelation = Vendor;
        // }
        // field(2034978; "Suggested Vendor (OEM)"; Code[20])
        // {
        //     CaptionML = ENU = 'Suggested Vendor (OEM)',
        //                 FRA = 'Fournisseur suggéré (OEM)';
        //     Description = 'DIT-715 #454';
        //     TableRelation = Vendor;
        // }
        // field(2034979; "Default Service Item No. (OEM)"; Code[20])
        // {
        //     CaptionML = ENU = 'Default Equipment No. (OEM)',
        //                 FRA = 'N° équipement  par défaut (OEM)';
        //     Description = 'DIT-715 #454';
        //     NotBlank = true;
        //     TableRelation = "Service Item";
        // }
        // field(2035040; "Bartender Label Layout SSCC"; Text[250])
        // {
        //     CaptionML = ENU = 'Bartender Label Layout SSCC',
        //                 FRA = 'Etiquette Barman SSCC';
        //     Description = 'DIT-715 #806';
        // }
        // field(2035041; "Product Variant"; Code[10])
        // {
        //     CaptionML = ENU = 'Product Variant',
        //                 FRA = 'Variante Produit';
        //     Description = 'DIT-715 #806';
        // }
        // field(2035042; "Product Variant Description"; Text[50])
        // {
        //     CaptionML = ENU = 'Product Variant Description',
        //                 FRA = 'Déscription Variante Produit';
        //     Description = 'DIT-715 #806';
        // }
        // field(2035044; "SSCC Nos."; Code[10])
        // {
        //     CaptionML = ENU = 'SSCC Nos.',
        //                 FRA = 'N° de SSCC';
        //     Description = 'DITW15.00.00.38 #1139';
        //     TableRelation = "No. Series";
        // }
        // field(2035045; "EAN Unit of Measure Code"; Code[10])
        // {
        //     CaptionML = ENU = 'EAN Unit of Measure (Cross ref.)',
        //                 FRA = 'Unité pour EAN (Réf. externe)';
        //     Description = 'DITW15.00.00.38 #1139';
        //     TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("No."));
        // }
        // field(2035046; "GTIN Unit of Measure Code"; Code[10])
        // {
        //     CaptionML = ENU = 'GTIN Unit of Measure (Cross ref.)',
        //                 FRA = 'Unité pour GTIN (Réf. externe)';
        //     Description = 'DITW15.00.00.38 #1139';
        //     TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("No."));
        // }
        // field(2035047; Stackable; Boolean)
        // {
        //     CaptionML = ENU = 'Stackable',
        //                 FRA = 'Empilable';
        //     Description = 'DITW15.00.00.38 #1139';
        // }
        // field(2035052; "SSCC No. Filter"; Code[50])
        // {
        //     CaptionML = ENU = 'SSCC No. Filter',
        //                 FRA = 'Filtre N° SSCC';
        //     Description = 'DIT-715 #745';
        //     FieldClass = FlowFilter;
        // }
        // field(2035055; "SSCC Company No."; Code[20])
        // {
        //     CaptionML = ENU = 'SSCC Company No.',
        //                 FRA = 'N° SSCC Société';
        //     Description = 'DITW15.00.00.38 #1139';
        // }
        // field(2035091; "Quality Standard No."; Code[20])
        // {
        //     CaptionML = ENU = 'Quality Standard No.',
        //                 FRA = 'N° Standard Qualité';
        //     Description = 'QXL9.00.001';
        //     TableRelation = "Quality Standard Header";
        // }
        // field(2035092; "Quality Tracked"; Boolean)
        // {
        //     CalcFormula = Exist(Item where("No." = FIELD("No."),
        //                                     "Quality Standard No." = FILTER(<> '')));
        //     CaptionML = ENU = 'Quality Tracked',
        //                 FRA = 'Traçabilité de Qualité';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035093; "Qty. Quarantined (Base)"; Decimal)
        // {
        //     CalcFormula = Sum("Quality Test Header"."Quantity (Base)" where("Item No." = FIELD("No."),
        //                                                                      "Document Type" = CONST("Lot/SN Test"),
        //                                                                      Status = CONST(Quarantine),
        //                                                                      "Lot No." = FIELD("Lot No. Filter"),
        //                                                                      "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionML = ENU = 'Qty. Quarantined (Base)',
        //                 FRA = 'Qté. Quarantaine (Base)';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035094; "Qty. Passed (Base)"; Decimal)
        // {
        //     CalcFormula = Sum("Quality Test Header"."Quantity (Base)" where("Item No." = FIELD("No."),
        //                                                                      "Document Type" = CONST("Lot/SN Test"),
        //                                                                      Status = CONST(Pass),
        //                                                                      "Lot No." = FIELD("Lot No. Filter"),
        //                                                                      "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionML = ENU = 'Qty. Passed (Base)',
        //                 FRA = 'Qté. Approuvé (Base)';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035095; "Qty. Failed (Base)"; Decimal)
        // {
        //     CalcFormula = Sum("Quality Test Header"."Quantity (Base)" where("Item No." = FIELD("No."),
        //                                                                      "Document Type" = CONST("Lot/SN Test"),
        //                                                                      Status = CONST(Fail),
        //                                                                      "Lot No." = FIELD("Lot No. Filter"),
        //                                                                      "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionML = ENU = 'Qty. Failed (Base)',
        //                 FRA = 'Qté Mauvais (Base)';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035096; "Qty. Concessioned (Base)"; Decimal)
        // {
        //     CalcFormula = Sum("Quality Test Header"."Quantity (Base)" where("Item No." = FIELD("No."),
        //                                                                      "Document Type" = CONST("Lot/SN Test"),
        //                                                                      Status = CONST(Concession),
        //                                                                      "Lot No." = FIELD("Lot No. Filter"),
        //                                                                      "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionML = ENU = 'Qty. Concessioned (Base)',
        //                 FRA = 'Qté Concession (Base)';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035097; "Qty. Rejected (Base)"; Decimal)
        // {
        //     CalcFormula = Sum("Quality Test Header"."Quantity (Base)" where("Item No." = FIELD("No."),
        //                                                                      "Document Type" = CONST("Lot/SN Test"),
        //                                                                      Status = CONST(Rejected),
        //                                                                      "Lot No." = FIELD("Lot No. Filter"),
        //                                                                      "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionML = ENU = 'Qty. Rejected (Base)',
        //                 FRA = 'Qté Refusé (Base)';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2035106; "Auto Receive after Qlty. Test"; Option)
        // {
        //     CaptionML = ENU = 'Auto Receive after Qlty. Test',
        //                 FRA = 'Réceptionner aprés test de qualité';
        //     Description = 'QXL9.00.001';
        //     OptionCaptionML = ENU = ' ,After Positive Evaluation,Always',
        //                       FRA = ' ,Aprés test positive,Toujours';
        //     OptionMembers = " ","After Positive Evaluation",Always;
        // }
        // field(2035118; "Quarantine Posting Policy"; Option)
        // {
        //     CaptionML = ENU = 'Quarantine Posting Policy',
        //                 FRA = 'Politique validation mise en quarantaine';
        //     Description = 'QXL9.00.001';
        //     OptionCaptionML = ENU = ' ,Allow item into stock,Prevent item from entering stock',
        //                       FRA = ' ,Approuver en stock,Pas approuver en stock';
        //     OptionMembers = " ","Allow item into stock","Prevent item from entering stock";
        // }
        // field(2035171; "Rounding Method"; Option)
        // {
        //     CaptionML = ENU = 'Rounding Method',
        //                 FRA = 'Methode Arrondi';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        //     OptionCaptionML = ENU = ' ,Up,Down',
        //                       FRA = ' ,En haut,En bas';
        //     OptionMembers = " ",Up,Down;
        // }
        // field(2035240; "Planning Colour"; Code[11])
        // {
        //     CaptionML = ENU = 'Planning Colour',
        //                 FRA = 'Couleur Planning';
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        // }
        // field(2035241; "Inventory (Degrees)"; Decimal)
        // {
        //     CalcFormula = Sum("Item Ledger Entry"."Vol-Strength Spec. Value" where("Item No." = FIELD("No."),
        //                                                                             "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
        //                                                                             "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
        //                                                                             "Location Code" = FIELD("Location Filter"),
        //                                                                             "Drop Shipment" = FIELD("Drop Shipment Filter"),
        //                                                                             "Variant Code" = FIELD("Variant Filter"),
        //                                                                             "Lot No." = FIELD("Lot No. Filter"),
        //                                                                             "Serial No." = FIELD("Serial No. Filter")));
        //     CaptionClass = GetQtyCaptionClass(FIELDNO("Inventory (Degrees)"), 14);
        //     CaptionML = ENU = 'Inventory (Degrees)',
        //                 FRA = 'Stocks (Degr.)';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.22 PRODW14.00.00.08';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2036308; "Planning Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Planning Group',
        //                 FRA = 'Groupe de planification';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     TableRelation = "Planning Group";
        // }
        // field(2036309; "Production Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Production Group',
        //                 FRA = 'Groupe de production';
        //     Description = 'QXL9.00.001';
        //     Editable = false;
        //     TableRelation = "Production Group";
        // }
        // field(2036310; Template; Code[20])
        // {
        //     CaptionML = ENU = 'Copied from Item (Template)',
        //                 FRA = 'Modèle';
        //     Description = 'MANXL10.00 conflict, see documentation trigger';
        //     Editable = false;
        //     TableRelation = Item;

        //     trigger OnValidate();
        //     var
        //         lblnItemCrossReference: Boolean;
        //         lrptCopyItem: Report "Copy Item (Norriq XL)";
        //         lrecItemFrom: Record Item;
        //     begin
        //         //<<MANXL7.00.001 DAT 24/02/2014 #1
        //         if Template <> '' then
        //             if lrecItemFrom.GET(Template) then begin
        //                 lblnItemCrossReference := false;
        //                 if (STRPOS(lrecItemFrom."No.", '-') <> 0) and
        //                    (STRPOS(Template, '-') <> 0) then
        //                     lblnItemCrossReference := true;
        //                 if lblnItemCrossReference then
        //                     if COPYSTR("No.", 1, STRPOS("No.", '-')) = COPYSTR(Template, 1, STRPOS(Template, '-')) then
        //                         lblnItemCrossReference := true
        //                     else
        //                         lblnItemCrossReference := false;
        //                 CLEAR(lrptCopyItem);
        //                 if blnCopyCrossRef then
        //                     lblnItemCrossReference := blnCopyCrossRef;
        //                 lrptCopyItem.fctSetParams(blnCopySalesPrice, blnCopyPurchPrice, not lblnItemCrossReference, blnMajorRevision);
        //                 lrptCopyItem.funCopyTemplate(lrecItemFrom, Rec);
        //             end;
        //         //>>MANXL7.00.001 DAT 24/02/2014 #1
        //     end;
        // }
        // field(2036318; "Free Item (Purchase)"; Boolean)
        // {
        //     Caption = 'Free Item (Purchase)';
        //     Description = 'DITW110.00.12A  NRQ#67425';

        //     trigger OnValidate();
        //     begin
        //         //<< DITW110.00.12A ISL 21/06/2018 NRQ#67425
        //         if "Free Item" then begin
        //             TESTFIELD("Item Disc. Group", '');
        //             TESTFIELD("Gen. Prod. Posting Free Group");
        //             TESTFIELD("Free Item Posting Type");
        //             if "Free Item Posting Type" = "Free Item Posting Type"::Price then begin
        //                 TESTFIELD("Unit Price", 0);
        //                 TestNoPurchasePriceExist(true, FIELDCAPTION("Free Item"));
        //             end;
        //             if "Free Item Posting Type" <> "Free Item Posting Type"::" " then begin
        //                 TestNoPurchaseLineDiscExist(true, FIELDCAPTION("Free Item"));
        //             end;
        //         end;
        //     end;
        // }
        // field(2036319; "Free Reason Code (Purchase)"; Code[10])
        // {
        //     Caption = 'Free Reason Code (Purchase)';
        //     Description = 'DITW110.00.12A  NRQ#67425';
        //     TableRelation = "Free Reason Code";
        // }
        //BC Upgrade PATHAA02<<
    }
    keys
    {
        //BC Upgrade PATHAA02-DIT >>
        // key(Key1; "Quality Standard No.")
        // {
        // } 
        // key(Key2; "Pos System", "Pos System Timestamp")
        // {
        // } 
        // key(Key3; "Treeview Code", "Treeview Code2", "Treeview Level")
        // {
        // } 
        // key(Key4; "Treeview Line No.", "Treeview Level")
        // {
        // } 
        //BC Upgrade PATHAA02-DIT<<
        // key(Key5; "Item Category Code", "Product Group Code")
        // {
        // } //BC Upgrade PATHAA02-ProductGroupCode Deprecated
        // key(Key6; "Brand Code")
        // {
        // } //BC Upgrade PATHAA02-DIT
        key(Key20; "Costing Method")
        {
        }
        key(Key21; "No. 2")
        {
        }
    }
    //BC Upgrade GUNREM01 >> added DIT Code
    PROCEDURE BlockedSKU(LocationCode: Code[20]; VariantCode: Code[20]; ShowError: Boolean): Boolean;
    VAR
        SKU: Record "Stockkeeping Unit";
    BEGIN

        IF "No." = '' THEN
            EXIT(FALSE);

        IF (LocationCode = '') AND (VariantCode = '') THEN
            EXIT(FALSE);

        IF NOT SKU.GET(LocationCode, "No.", VariantCode) THEN
            EXIT(FALSE);

        IF ShowError THEN
            SKU.TESTFIELD("Blocked FND", FALSE);

        EXIT(SKU."Blocked FND");
    END;
    //BC Upgrade GUNREM01 << added DIT Code

    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ApprovalsMgmt.OnCancelItemApprovalRequest(Rec);

    CheckJournalsAndWorksheets(0);
    #4..6

    ServiceItem.RESET;
    ServiceItem.SETRANGE("Item No.","No.");
    IF ServiceItem.FIND('-') THEN
      REPEAT
        ServiceItem.VALIDATE("Item No.",'');
        ServiceItem.MODIFY(TRUE);
      UNTIL ServiceItem.NEXT = 0;

    DeleteRelatedData;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..9
    if ServiceItem.FIND('-') then
      repeat
        ServiceItem.VALIDATE("Item No.",'');
        ServiceItem.MODIFY(true);
      until ServiceItem.NEXT = 0;

    DeleteRelatedData;

    //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
    GetInvtSetup;
    if (InvtSetup."Item Auto Dimension Code" <> '') then begin
      if rDimValue.GET(InvtSetup."Item Auto Dimension Code","No.") then
        rDimValue.DELETE(true);
    end;
    //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "No." = '' THEN BEGIN
      GetInvtSetup;
      InvtSetup.TESTFIELD("Item Nos.");
      NoSeriesMgt.InitSeries(InvtSetup."Item Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    DimMgt.UpdateDefaultDim(
      DATABASE::Item,"No.",
      "Global Dimension 1 Code","Global Dimension 2 Code");

    SetLastDateTimeModified;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if "No." = '' then begin
    #2..4
    end;
    #6..9
    //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
    GetInvtSetup;
    if InvtSetup."Item Auto Dimension Code" <> '' then begin
      txtDimName := DimMgt.fctGetDimNameFromSource(Description,"Description 2");
      DimMgt.fctUpdateSetupAnyDimValueCode(
        InvtSetup."Item Auto Dimension Code","No.",txtDimName,false);
      DimMgt.fctSaveAnyDefaultDimOnInsert(
        DATABASE::Item,"No.",InvtSetup."Item Auto Dimension Code","No.",
        //<< FINXL10.01 AKH 28/07/2017 NRQ#33089
        rDefaultDim."Value Posting"::" ");
        //>> FINXL10.01 AKH 28/07/2017 NRQ#33089
    end;
    //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
    ///DITW110.00.11 MSF 07/11/2017 NRQ#13577

    SetLastDateTimeModified;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnRename". Please convert manually.

    //trigger (Variable: lcodNewNo)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.RenameNo(SalesLine.Type::Item,xRec."No.","No.");
    PurchLine.RenameNo(PurchLine.Type::Item,xRec."No.","No.");
    ApprovalsMgmt.RenameApprovalEntries(xRec.RECORDID,RECORDID);
    ItemAttributeValueMapping.RenameItemAttributeValueMapping(xRec."No.","No.");
    SetLastDateTimeModified;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    /// DITW17.00.02 SR 20/09/2013 DIT-770 #187 - DITW110.00.08 DDR 09/02/2017 NRQ#20699

    #1..4
    //<< FINXL10.01 AKH 19/07/2017 NRQ#33089
    GetInvtSetup;
    if (InvtSetup."Item Auto Dimension Code" <> '') then begin
      txtDimName := DimMgt.fctGetDimNameFromSource(Description,"Description 2");
      DimMgt.fctRenameSetupAnyDimValueCode(
        InvtSetup."Item Auto Dimension Code",xRec."No.","No.",txtDimName);
      //<< FINXL10.01 AKH 28/07/2017 NRQ#33089
      lcodNewNo := "No.";
      GET(xRec."No.");
      "No." := lcodNewNo;
      //>> FINXL10.01 AKH 28/07/2017 NRQ#33089
    end;
    //>> FINXL10.01 AKH 19/07/2017 NRQ#33089
    SetLastDateTimeModified;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyDeletion. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //BC Upgrade PATHAA02>>
    //var
    // SCReservEntry: Record "SSCC Reservation Entry"; 
    //TempTrackingSpecifcation: Record "Tracking Specification" temporary;
    //SSCCLineReserv: Codeunit "SSCC Line-Reserve"; 

    // var
    //     lcodNewNo: Code[20];

    // var
    //     lrecItemMinorRevision: Record "Item Minor Revision";
    //     lrecRecycleCharges: Record "Item Recycle Charge";

    // var
    //     StockkeepingUnit: Record "Stockkeeping Unit";

    //BC Upgrade PATHAA02<<
    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot delete %1 %2 because there is at least one outstanding Purchase %3 that includes this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot delete %1 %2 because there is at least one outstanding Purchase %3 that includes this item.;FRA=Vous ne pouvez pas supprimer %1 %2 car il existe encore au moins une %3 achat ouverte qui inclut cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot delete %1 %2 because there is at least one outstanding Sales %3 that includes this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot delete %1 %2 because there is at least one outstanding Sales %3 that includes this item.;FRA=Vous ne pouvez pas supprimer %1 %2 car il existe encore au moins une %3 vente ouverte qui inclut cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot delete %1 %2 because there are one or more outstanding production orders that include this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot delete %1 %2 because there are one or more outstanding production orders that include this item.;FRA=Vous ne pouvez pas supprimer %1 %2 car il existe des ordres de fabrication qui contiennent cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1057)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Do you want to change %1?;FRA=Souhaitez-vous modifier la valeur du champ %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1064)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=You cannot delete %1 %2 because there are one or more certified Production BOM that include this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=You cannot delete %1 %2 because there are one or more certified Production BOM that include this item.;FRA=Vous ne pouvez pas supprimer le %1 %2 car il existe une ou plusieurs nomenclatures validées qui contiennent cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotDeleteItemIfProdBOMVersionExistsErr(Variable 1084)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotDeleteItemIfProdBOMVersionExistsErr : @@@=%1 - Tablecaption, %2 - No.;ENU=You cannot delete %1 %2 because there are one or more certified production BOM version that include this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotDeleteItemIfProdBOMVersionExistsErr : @@@=%1 - Tablecaption, %2 - No.;ENU=You cannot delete %1 %2 because there are one or more certified production BOM version that include this item.;FRA=Vous ne pouvez pas supprimer le %1 %2 car il existe une ou plusieurs versions de nomenclatures de production validées qui contiennent cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=Prices including VAT cannot be calculated when %1 is %2.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=Prices including VAT cannot be calculated when %1 is %2.;FRA=Les prix TTC ne peuvent pas être calculés quand %1 est identique à %2.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=You cannot change %1 because there are one or more ledger entries for this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=You cannot change %1 because there are one or more ledger entries for this item.;FRA=Vous ne pouvez pas modifier %1 car il existe des écritures comptables associées à cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=You cannot change %1 because there is at least one outstanding Purchase %2 that include this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=You cannot change %1 because there is at least one outstanding Purchase %2 that include this item.;FRA=L'enregistrement %1 ne peut être modifié car il existe au moins une %2 achat ouverte comprenant cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=You cannot delete %1 %2 because there are one or more production order component lines that include this item with a remaining quantity that is not 0.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=You cannot delete %1 %2 because there are one or more production order component lines that include this item with a remaining quantity that is not 0.;FRA=L'enregistrement %1 %2 ne peut être supprimé car il existe une ou plusieurs lignes composant O.F. comprenant cet article avec une quantité restante différente de 0.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text016(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text016 : ENU=You cannot delete %1 %2 because there are one or more outstanding transfer orders that include this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text016 : ENU=You cannot delete %1 %2 because there are one or more outstanding transfer orders that include this item.;FRA=Vous ne pouvez pas supprimer %1 %2 car un ou plusieurs ordre(s) de transfert en attente contiennent cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text017(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text017 : ENU=You cannot delete %1 %2 because there is at least one outstanding Service %3 that includes this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text017 : ENU=You cannot delete %1 %2 because there is at least one outstanding Service %3 that includes this item.;FRA=Vous ne pouvez pas supprimer %1 %2 car au moins un(e) %3 service en attente contient cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text018(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text018 : ENU=%1 must be %2 in %3 %4 when %5 is %6.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text018 : ENU=%1 must be %2 in %3 %4 when %5 is %6.;FRA=Le champ %1 doit indiquer %2 pour le %3 %4 si %5 est %6.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text019(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text019 : ENU=You cannot change %1 because there are one or more open ledger entries for this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text019 : ENU=You cannot change %1 because there are one or more open ledger entries for this item.;FRA=Vous ne pouvez pas modifier %1 car il existe des écritures comptables ouvertes associées à cet élément.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text020(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text020 : ENU="There may be orders and open ledger entries for the item. ";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text020 : ENU="There may be orders and open ledger entries for the item. ";FRA="Il existe probablement des écritures comptables ouvertes et des ordres pour cet élément. ";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text021(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text021 : ENU=If you change %1 it may affect new orders and entries.\\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text021 : ENU=If you change %1 it may affect new orders and entries.\\;FRA=Si vous modifiez la valeur du champ %1, cela peut affecter les nouveaux ordres et écritures.\\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text022(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text022 : ENU=Do you want to change %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text022 : ENU=Do you want to change %1?;FRA=Souhaitez-vous modifier la valeur du champ %1?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text023(Variable 1066)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text023 : ENU=You cannot delete %1 %2 because there is at least one %3 that includes this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text023 : ENU=You cannot delete %1 %2 because there is at least one %3 that includes this item.;FRA=Vous ne pouvez pas supprimer l'%1 %2 car il existe au moins une %3 qui contient cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text024(Variable 1072)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text024 : ENU=If you change %1 it may affect existing production orders.\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text024 : ENU=If you change %1 it may affect existing production orders.\;FRA=La modification de %1 peut avoir des répercussions sur les O.F. existants.\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text025(Variable 1055)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text025 : ENU=%1 must be an integer because %2 %3 is set up to use %4.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text025 : ENU=%1 must be an integer because %2 %3 is set up to use %4.;FRA=%1 doit être un entier car %2 %3 est défini(e) pour utiliser %4.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text026(Variable 1077)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text026 : ENU=%1 cannot be changed because the %2 has work in process (WIP). Changing the value may offset the WIP account.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text026 : ENU=%1 cannot be changed because the %2 has work in process (WIP). Changing the value may offset the WIP account.;FRA=%1 ne peut pas être modifié car le %2 présente des travaux en cours (TEC). Si vous modifiez la valeur, le compte TEC risque d'être décalé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text7380(Variable 1058)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text7380 : @@@=If you change the Phys Invt Counting Period Code, the Next Counting Start Date and Next Counting End Date are calculated.\Do you still want to change the Phys Invt Counting Period Code?;ENU=If you change the %1, the %2 and %3 are calculated.\Do you still want to change the %1?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text7380 : @@@=If you change the Phys Invt Counting Period Code, the Next Counting Start Date and Next Counting End Date are calculated.\Do you still want to change the Phys Invt Counting Period Code?;ENU=If you change the %1, the %2 and %3 are calculated.\Do you still want to change the %1?;FRA=Si vous modifiez le %1, la %2 et la %3 sont calculées.\Souhaitez-vous quand même modifier le %1 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text7381(Variable 1056)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text7381 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text7381 : ENU=Cancelled.;FRA=Annulé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000000(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000000 : ENU=The change will not affect existing entries.\;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000000 : ENU=The change will not affect existing entries.\;FRA=Cette modification n'affectera pas les écritures existantes.\;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000001(Variable 1019)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000001 : ENU=If you want to generate %1 for existing entries, you must run a regenerative planning.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000001 : ENU=If you want to generate %1 for existing entries, you must run a regenerative planning.;FRA=Si vous souhaitez générer %1 pour les écritures existantes, vous devez lancer un calcul planning régénératif.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text99000002(Variable 1021)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text99000002 : ENU=tracking,tracking and action messages;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text99000002 : ENU=tracking,tracking and action messages;FRA=chaînage, chaînage et message d'action;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text027(Variable 1078)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text027 : @@@=starts with "Rounding Precision";ENU=must be greater than 0.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text027 : @@@=starts with "Rounding Precision";ENU=must be greater than 0.;FRA=doit être supérieur(e) à 0.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text028(Variable 1080)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text028 : ENU=You cannot perform this action because entries for item %1 are unapplied in %2 by user %3.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text028 : ENU=You cannot perform this action because entries for item %1 are unapplied in %2 by user %3.;FRA=Il est impossible d'effectuer cette opération car les écritures de l'article %1 ne sont pas lettrées dans%2 par l'utilisateur %3.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CannotChangeFieldErr(Variable 1079)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotChangeFieldErr : @@@="%1 = Field Caption, %2 = Item Table Name, %3 = Item No., %4 = Table Name";ENU=You cannot change the %1 field on %2 %3 because at least one %4 exists for this item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotChangeFieldErr : @@@="%1 = Field Caption, %2 = Item Table Name, %3 = Item No., %4 = Table Name";ENU=You cannot change the %1 field on %2 %3 because at least one %4 exists for this item.;FRA=Vous ne pouvez pas modifier le champ %1 de %2 %3, car il existe au moins un %4 pour cet article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "BaseUnitOfMeasureQtyMustBeOneErr(Variable 1081)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //BaseUnitOfMeasureQtyMustBeOneErr : @@@="%1 Name of Unit of measure (e.g. BOX, PCS, KG...), %2 Qty. of %1 per base unit of measure ";ENU=The quantity per base unit of measure must be 1. %1 is set up with %2 per unit of measure.\\You can change this setup in the Item Units of Measure window.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //BaseUnitOfMeasureQtyMustBeOneErr : @@@="%1 Name of Unit of measure (e.g. BOX, PCS, KG...), %2 Qty. of %1 per base unit of measure ";ENU=The quantity per base unit of measure must be 1. %1 is set up with %2 per unit of measure.\\You can change this setup in the Item Units of Measure window.;FRA=La quantité par unité de base doit correspondre à 1. %1 est configuré avec %2 par unité.\\Vous pouvez modifier ce paramètre dans la fenêtre Unités article.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OpenDocumentTrackingErr(Variable 1082)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OpenDocumentTrackingErr : ENU="You cannot change ""Item Tracking Code"" because there is at least one open document that includes this item with specified tracking: Source Type = %1, Document No. = %2.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OpenDocumentTrackingErr : ENU="You cannot change ""Item Tracking Code"" because there is at least one open document that includes this item with specified tracking: Source Type = %1, Document No. = %2.";FRA="Vous ne pouvez pas modifier le Code traçabilité car au moins un document ouvert inclut cet article avec traçabilité spécifiée : Type origine = %1, N° document = %2.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SelectItemErr(Variable 1083)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SelectItemErr : ENU=You must select an existing item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectItemErr : ENU=You must select an existing item.;FRA=Vous devez sélectionner un article existant.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "CreateNewItemTxt(Variable 1187)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CreateNewItemTxt : @@@="%1 is the name to be used to create the customer. ";ENU=Create a new item card for %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateNewItemTxt : @@@="%1 is the name to be used to create the customer. ";ENU=Create a new item card for %1.;FRA=Créez une fiche article pour %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemNotRegisteredTxt(Variable 1186)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemNotRegisteredTxt : ENU=This item is not registered. To continue, choose one of the following options:;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemNotRegisteredTxt : ENU=This item is not registered. To continue, choose one of the following options:;FRA=Cet article n'est pas enregistré. Pour continuer, sélectionnez l'une des options suivantes :;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SelectItemTxt(Variable 1185)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SelectItemTxt : ENU=Select an existing item.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SelectItemTxt : ENU=Select an existing item.;FRA=Sélectionnez un article existant.;
    //Variable type has not been exported.

    var
        Country: Record "Country/Region";
        //SalesTaxItemCharge: Record "Sales Tax Item Charge"; //BC Upgrade PATHAA02-DIT
        // SalesDepositItemCharge: Record "Sales Deposit Item Charge"; //BC Upgrade PATHAA02-DIT
        //SalesDiscountItemCharge: Record "Sales Discount Item Charge"; //BC Upgrade PATHAA02-DIT
        //SalesPromotionItemCharge: Record "Sales Promotion Item Charge";//BC Upgrade PATHAA02-DIT
        //TaxSpecMgt: Codeunit "Tax Spec. Management";//BC Upgrade PATHAA02-DIT
        DefaultDim: Record "Default Dimension";
        rDefaultDim: Record "Default Dimension";
        //HeinekenGlobal: Codeunit "Heineken Global"; //BC Upgrade PATHAA02
        rDim: Record Dimension;
        rDimValue: Record "Dimension Value";
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        // DrinkTaxGroup: Record "Drink Tax Group";//BC Upgrade PATHAA02-DIT
        TariffNumber: Record "Tariff Number";
        //WineGrowzone: Record "Wine Growing zone";//BC Upgrade PATHAA02-DIT
        // SSCCSetup: Record "SSCC Setup"; //BC Upgrade PATHAA02-DIT
        UnitOfMeasure: Record "Unit of Measure";
        recUserSetup: Record "User Setup";
        blnCopyCrossRef: Boolean;
        blnCopyPurchPrice: Boolean;
        blnCopySalesPrice: Boolean;
        blnMajorRevision: Boolean;
        RunModeCaptionPM: Boolean;
        // recFinXLSetup: Record "Finance XL Setup"; //BC Upgrade PATHAA02-DIT
        //recManufacturingXLSetup: Record "Manufacturing XL Setup"; //BC Upgrade PATHAA02-DIT
        UnitOfMeasureCode: Code[20];
        Text026: Label '%1 cannot be changed because the %2 has work in process (WIP). Changing the value may offset the WIP account.';
        TEXT031: Label 'You cannot create more than one unit of measure for item No. %1';
        Text50000: Label 'There are outstanding orders for the item. If you change Strength Method it may affect new orders. Please run the report - Update Strength Specification Code manually.';
        txtDimName: Text;
        Text2013660: TextConst ENU = 'If you change %1 it may affect ALL existing default tax Specification values.\', FRA = 'La modification de %1 peut avoir des répercussions sur toutes les valeurs des spécifications taxes.\';
        Text2013661: TextConst ENU = 'The new %1 value has the default value %3 as %2. Do you want to replace the value %2 %4 for this item?', FRA = 'la nouvelle valeur %1 a comme défaut %3 pour %2. Souhaitez-vous modifier aussi le champs %2 %4?';
        Text2013662: TextConst ENU = '%1 %2 cannot have "%3" when %4 is ''%5''.', FRA = '%1 %2 ne peut pas avoir %3 quand %4 est ''%5''.';
        Text2013760: TextConst ENU = 'You cannot change %1 because there is at least one %2 that includes this item.', FRA = 'Vous ne pouvez pas changer %1 car il existe au moins une %2 qui contient cet article.';
        Text2014260: TextConst ENU = ' does not content a numeric value', FRA = ' a une valeur qui ne correspond pas à un nombre';
        Text2014261: TextConst ENU = ' can have a numeric value with maximum 15 digits.', FRA = ' peut avoir un nombre avec un maximum de 15 chiffres.';
        Text2014310_1: TextConst ENU = 'Component No.', FRA = 'N° composant';
        Text2014310_14: TextConst ENU = 'Component Disc. Group', FRA = 'Groupe rem. composant';
        Text2014310_37: TextConst ENU = 'Alternative Component No.', FRA = 'Référence de remplacement composant';
        Text2014310_6500: TextConst ENU = 'Component Tracking Code', FRA = 'Code traçabilité composant';
        Text2014412: TextConst ENU = 'You are not allowed to release an Item (User Setup)', FRA = 'Opération non autorisée';

    //---BC Upgrade KAMNAY01>> --- THIS LOCAL PROCEDURE ALSO IN BASE TABLE(27-ITEM)
    local procedure CheckForProductionOutput(ItemNo: Code[20])
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        Clear(ItemLedgEntry);
        ItemLedgEntry.SetCurrentKey("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
        ItemLedgEntry.SetRange("Item No.", ItemNo);
        ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Output);
        if not ItemLedgEntry.IsEmpty() then
            Error(Text026, FieldCaption("Inventory Value Zero"), TableCaption);
    end;
    //---BC Upgrade KAMNAY01<<
}

