tableextension 50181 "InvoicePostingBufferExtFND" extends "Invoice Posting Buffer"
{
    //!!! Logic was taken from "Invoice Post. Buffer" (HeiLite)

    // version NAVW110.0,FINXL10.00,DITW110.00.09,HEI.06
    // DITW15.00.00.01 DDR 27/12/2007 added fields
    //                                  2034677 Item Charge Line No.
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW16.00.00.37 DDR 16/06/2010 Upgrade NAV 2009 SP1
    // DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
    //                                Added fields
    //                                  2034850 DIT Sub-Contract Type
    //                                  2034872 Contract Group Code
    //                                  2034915 Service Contract No.
    //                                  2014310 Service Contract Line No.
    //                                  2014311 Service Contract Type
    //                 AHU 31/08/2012 DIT-715 #327 Renamed Captions fields2034915,2034310,2014311
    //                 AHU 05/11/2012 DIT-715 #327 Added fields to Primary key
    //                                  2034915 Service Contract No.
    //                                  2014311 Service Contract Type
    // DITW16.00.00.42 DDR 07/12/2012 DIT-715 #370 Added fields to Primary key
    //                                  2013695 Item Charge Type

    // FINXL7.00.001 RBE 20/03/2013: Created field 2029611
    //                               Created field 2029614 "G/L Account Description" + Added code for filling this field

    // DITW17.00.02 AT  06/12/2013 DIT-770 #222 Added Field
    //                                            2014430  Line Description
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 22/11/2014 DIT-770 #1005 Updated the length of the field "Description" to 80
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Rename DIT Contract by Financial Contract
    //                                           Added field "Financial Contract No."
    //                                           Rename Caption Contract No. by Service contract No.
    //                                           Change ID of field Contract Type to Foundation layer 2035393
    //                                           Added blank Option to Contract Type
    //                                           Added field 2014313 into primary key
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL10.00 AKH 25/01/2017 Adjusted code after upgrade
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 FDD-SLSGAP001 IBM POENAB01 21.08.2017 # MDM Customer Card
    //   # New fields for MDM integration
    // HEI.02 FDD-RTRGAP056 IBM HORTOC01 25.08.2017
    //   # New fields added
    // HEI.03 CHG2090912 HB1641 IBM NandIS01 01.02.2021 General Ledger Entries Description
    //   # New field added - id - 50009  - "Additional Description" - Text - 100
    //   # Code added under function - PreparePurchase
    // HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 23.08.2021 # Centime - additional tax on VAT
    //   # New Field created 50010 - CAD Amount
    //   # New Function created "UpdateCADAmount"
    // HEI.05 CHG2132418 FDD-HB2311 IBM NandIS01 10.03.2023 # Development Correct posting invoicing FA
    //   # New field added - "Purchase Receipt Unit Cost" (ID - 50011 - Decimal)
    // HEI.06 CHG2224401 HB3624 YADAVM09 04.04.2024 Health and Security Levy Tax
    //   # New Field created #H&S Levy Tax %
    //                       #H&S Levy Tax Amount
    //                       #HS Posting Group
    //-------------------------------BC UPgrade SHARMP16 CU 90----------------------------------
    //Created New fields for FA posting cases in Purchase..
    fields
    {
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
            //OptionCaptionML = ENU = 'Prepmt. Exch. Rate Difference,G/L Account,Item,Resource,Fixed Asset', FRA = 'Écart de conversion acpte,Compte général,Article,Ressource,Immobilisation';
        }
        modify("G/L Account")
        {
            CaptionML = ENU = 'G/L Account', FRA = 'Compte général';
        }
        modify("Global Dimension 1 Code")
        {
            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {
            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("Job No.")
        {
            CaptionML = ENU = 'Job No.', FRA = 'N° projet';
        }
        modify(Amount)
        {
            CaptionML = ENU = 'Amount', FRA = 'Montant';
        }
        modify("VAT Amount")
        {
            CaptionML = ENU = 'VAT Amount', FRA = 'Montant TVA';
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
        modify("VAT Base Amount")
        {
            CaptionML = ENU = 'VAT Base Amount', FRA = 'Montant base TVA';
        }
        modify("System-Created Entry")
        {
            CaptionML = ENU = 'System-Created Entry', FRA = 'Écriture système';
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
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Use Tax")
        {
            CaptionML = ENU = 'Use Tax', FRA = 'Use Tax';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'VAT Bus. Posting Group', FRA = 'Groupe compta. marché TVA';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'VAT Prod. Posting Group', FRA = 'Groupe compta. produit TVA';
        }
        modify("Amount (ACY)")
        {
            CaptionML = ENU = 'Amount (ACY)', FRA = 'Montant DR';
        }
        modify("VAT Amount (ACY)")
        {
            CaptionML = ENU = 'VAT Amount (ACY)', FRA = 'Montant TVA DR';
        }
        modify("VAT Base Amount (ACY)")
        {
            CaptionML = ENU = 'VAT Base Amount (ACY)', FRA = 'Montant base TVA DR';
        }
        modify("VAT Difference")
        {
            CaptionML = ENU = 'VAT Difference', FRA = 'Différence TVA';
        }
        modify("VAT %")
        {
            CaptionML = ENU = 'VAT %', FRA = '% TVA';
        }
        modify("Dimension Set ID")
        {
            CaptionML = ENU = 'Dimension Set ID', FRA = 'ID ensemble de dimensions';
        }
        modify("Deferral Code")
        {
            CaptionML = ENU = 'Deferral Code', FRA = 'Code échelonnement';
        }
        modify("Deferral Line No.")
        {
            CaptionML = ENU = 'Deferral Line No.', FRA = 'N° ligne échelonnement';
        }
        modify("FA Posting Date")
        {
            CaptionML = ENU = 'FA Posting Date', FRA = 'Date compta. immo.';
        }
        modify("FA Posting Type")
        {
            CaptionML = ENU = 'FA Posting Type', FRA = 'Type compta. immo.';
            //OptionCaptionML = ENU = ' ,Acquisition Cost,Maintenance', FRA = ' ,Coût acquisition,Maintenance';
        }
        modify("Depreciation Book Code")
        {
            CaptionML = ENU = 'Depreciation Book Code', FRA = 'Code loi d''amortissement';
        }
        modify("Salvage Value")
        {
            CaptionML = ENU = 'Salvage Value', FRA = 'Valeur résiduelle';
        }
        modify("Depr. until FA Posting Date")
        {
            CaptionML = ENU = 'Depr. until FA Posting Date', FRA = 'Amort. jusqu''à date compta.';
        }
        modify("Depr. Acquisition Cost")
        {
            CaptionML = ENU = 'Depr. Acquisition Cost', FRA = 'Amortir coût acquisition';
        }
        modify("Maintenance Code")
        {
            CaptionML = ENU = 'Maintenance Code', FRA = 'Code maintenance';
        }
        modify("Insurance No.")
        {
            CaptionML = ENU = 'Insurance No.', FRA = 'N° assurance';
        }
        modify("Budgeted FA No.")
        {
            CaptionML = ENU = 'Budgeted FA No.', FRA = 'N° immo. budgétée';
        }
        modify("Duplicate in Depreciation Book")
        {
            CaptionML = ENU = 'Duplicate in Depreciation Book', FRA = 'Dupliquer dans journaux amort.';
        }
        modify("Use Duplication List")
        {
            CaptionML = ENU = 'Use Duplication List', FRA = 'Utiliser liste duplication';
        }
        modify("Fixed Asset Line No.")
        {
            CaptionML = ENU = 'Fixed Asset Line No.', FRA = 'N° ligne immobilisation';
        }
        field(50000; "WHT Business Posting Group FND"; Code[10])
        {
            Caption = 'WHT Business Posting Group';
            Description = 'HEI.01';
            TableRelation = "WHT Business Posting Group FND".Code;
        }
        field(50001; "WHT Product Posting Group FND"; Code[10])
        {
            Caption = 'WHT Product Posting Group';
            Description = 'HEI.01';
            TableRelation = "WHT Product Posting Group FND".Code;
        }
        field(50002; "Purchase Receipt Line No. FND"; Integer)
        {
            Caption = 'Purchase Receipt Line No.';
            Description = 'HEI.02';
        }
        field(50003; "Purchase Receipt Amount FND"; Decimal)
        {
            Caption = 'Purchase Receipt Amount';
            Description = 'HEI.02';
        }
        field(50004; "Purchase Receipt No. FND"; Code[20])
        {
            Caption = 'Purchase Receipt No.';
            Description = 'HEI.02';
        }
        field(50008; "Real VAT Amount FND"; Decimal)
        {
            Caption = 'Real VAT Amount';
        }
        field(50009; "Additional Description FND"; Text[100])
        {
            Caption = 'Additional Description';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        // BC Upgrade POENAB02 - field 50010 "CAD Amount" is part of CAD development
        // This field should be moved to StP Extension???
        field(50010; "CAD Amount FND"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
            Editable = false;
        }
        field(50011; "Purchase Receipt Unit Cost FND"; Decimal)
        {
            Caption = 'Purchase Receipt Unit Cost';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(50062; "H&S Levy Tax % FND"; Decimal)
        {
            Caption = 'H&S Levy Tax %';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            TableRelation = "H&S Tax Posting Group FND";
        }
        field(50063; "H&S Levy Tax Amount FND"; Decimal)
        {
            Caption = 'H&S Levy Tax Amount';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(50064; "HS Posting Group FND"; Code[10])
        {
            Caption = 'HS Posting Group';
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
            TableRelation = "H&S Tax Posting Group FND";
        }
        //BC UPgrade SHARMP16 CU 90 BEGIN>>
        field(50067; "FA GRIR Account FND"; Boolean)
        {
            Caption = 'FA GRIR Account';
            DataClassification = ToBeClassified;
        }
        field(50068; "Purchase Reference FND"; Text[100])
        {
            Caption = 'Purchase Reference';
            DataClassification = ToBeClassified;
        }
        field(50069; "Purchase Source No FND"; code[50])
        {
            Caption = 'Purchase Source No';
            DataClassification = ToBeClassified;
        }
        field(50070; "Purchase Order No. FND"; code[50])
        {
            Caption = 'Purchase Order No.';
            DataClassification = ToBeClassified;
        }
        //BC UPgrade SHARMP16 CU 90 END<<
        // BC Upgrade POENAB02 >>
        //below code is commented, as the fields were migrated from HeiLite, but they
        //are in Aptean range.
        /* 
                field(2013695; "Item Charge Type"; Option)
                {
                    CaptionML = ENU = 'Item Charge Type',
                                FRA = 'Type frais annexes';
                    Description = 'DITW16.00.00.42 DIT-715 #370';
                    OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
                                      FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
                    OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
                }
                field(2013697; "Item Charge Line No."; Integer)
                {
                    CaptionML = ENU = 'Item Charge Line No.',
                                FRA = 'N° ligne frais annexes';
                    Description = 'DITW15.00.00.01';
                }
                field(2014310; "Service Contract Line No."; Integer)
                {
                    CaptionML = ENU = 'Contract Line No.',
                                FRA = 'N° ligne contrat';
                    Description = 'DIT-715 #392';
                }
                field(2014313; "Financial Contract No."; Code[20])
                {
                    CaptionML = ENU = 'Financial Contract No.',
                                FRA = 'N° Contrat Financier';
                    Description = 'DITW18.00.06 DIT-770 #1368';
                    TableRelation = "Financial Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
                                                                                      "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
                }
                field(2014430; "Line Description"; Text[50])
                {
                    CaptionML = ENU = 'Line Description',
                                FRA = 'Description ligne';
                    Description = 'DITW17.00.02 DIT-770 #222';
                }
                field(2029611; "Auto. Acc. Group"; Code[10])
                {
                    CaptionML = ENU = 'Auto. Acc. Group',
                                FRA = 'Groupe compte autom.';
                    Description = 'FINXL7.00.001';
                    TableRelation = "Automatic Acc. Header";
                }
                field(2029614; "G/L Account Description"; Text[50])
                {
                    Caption = 'Designation compte genéral';
                    Description = 'FINXL7.00.001';
                }
                field(2029615; "VAT Base Amount (LCY)"; Decimal)
                {
                    CaptionML = ENU = 'VAT Base Amount (LCY)',
                                FRA = 'Montant base TVA DS';
                    Description = 'FINXL7.00.001';
                }
                field(2034850; "DIT Sub-Contract Type"; Option)
                {
                    CaptionML = ENU = 'Sub Contract Type',
                                FRA = 'Sous type contrat';
                    Description = 'DIT-715 #392';
                    OptionCaptionML = ENU = ' ,Rent,Loan,Loan in use,Maintenance,Other,Plant Maintenance',
                                      FRA = ' ,Location,Prêt,Prêt en cours,Maintenance,Divers,Maintenance Usine';
                    OptionMembers = " ",Rent,Loan,LoanInUse,Maintenance,Other,PlantMaintenance;
                }
                field(2034872; "Contract Group Code"; Code[10])
                {
                    CaptionML = ENU = 'Contract Group Code',
                                FRA = 'Code groupe contrat';
                    Description = 'DIT-715 #392';
                    TableRelation = IF ("Contract Type" = CONST(Service)) "Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"))
                    else IF ("Contract Type" = CONST(Financial)) "Financial Contract Group".Code where("DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
                }
                field(2034915; "Service Contract No."; Code[20])
                {
                    CaptionML = ENU = 'Service Contract No.',
                                FRA = 'N° contrat de service';
                    Description = 'DIT-715 #392- DITW18.00.06 MSF 31/07/2015 DIT-770 #1368';
                    TableRelation = "Service Contract Header"."Contract No." where("Contract Type" = CONST(Contract),
                                                                                    "DIT Sub-Contract Type" = FIELD("DIT Sub-Contract Type"));
                }
                field(2035393; "Contract Type"; Option)
                {
                    CaptionML = ENU = 'Contract Type',
                                FRA = 'Type contrat';
                    Description = 'DIT-715 #392 - DITW18.00.06 DIT-770 #1368';
                    OptionCaptionML = ENU = ' ,Service,Financial',
                                      FRA = ' ,Service,Financier';
                    OptionMembers = " ",Service,Financial;
                }
                 */
        // BC Upgrade POENAB02 <<
    }
    keys
    {

        //Unsupported feature: Deletion on ""Type,""G/L Account"",""Gen. Bus. Posting Group"",""Gen. Prod. Posting Group"",""VAT Bus. Posting Group"",""VAT Prod. Posting Group"",""Tax Area Code"",""Tax Group Code"",""Tax Liable"",""Use Tax"",""Dimension Set ID"",""Job No."",""Fixed Asset Line No."",""Deferral Code"""(Key)". Please convert manually.

        // BC Upgrade POENAB02 >>
        //the below primary key was removed, as it contained Aptean fields. The key from standard        
        //table is being used, without Aptean keys
        /*
        key(Key1; Type, "G/L Account", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Tax Area Code", "Tax Group Code", "Tax Liable", "Use Tax", "Dimension Set ID", "Job No.", "Fixed Asset Line No.", "Deferral Code", "Contract Type", "Service Contract No.", "Financial Contract No.", "Item Charge Type")
        {
        }
        */
        // BC Upgrade POENAB02 <<
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    // BC Upgrade POENAB02 >>
    // recFinXLSetup variable belongs to Aptean
    /*
        var
            recFinXLSetup: Record "Finance XL Setup"; 
    */
    // BC Upgrade POENAB02 <<

    var
        DimMgt: Codeunit DimensionManagement;

    // Blocked as whole code is blocked and already present in base code
    // procedure PrepareSales(VAR SalesLine: Record "Sales Line")
    // var
    //     SalesSetup: Record "Sales & Receivables Setup";
    // begin
    //     // BC Upgrade POENAB02 >>
    //     // below function was commented, as it contains Aptean code
    //     /*        
    //         Clear(Rec);
    //         Type := SalesLine.Type;
    //         "System-Created Entry" := TRUE;
    //         "Gen. Bus. Posting Group" := SalesLine."Gen. Bus. Posting Group";
    //         "Gen. Prod. Posting Group" := SalesLine."Gen. Prod. Posting Group";
    //         "VAT Bus. Posting Group" := SalesLine."VAT Bus. Posting Group";
    //         "VAT Prod. Posting Group" := SalesLine."VAT Prod. Posting Group";
    //         "VAT Calculation Type" := SalesLine."VAT Calculation Type";
    //         "Global Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
    //         "Global Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
    //         "Dimension Set ID" := SalesLine."Dimension Set ID";
    //         "Job No." := SalesLine."Job No.";
    //         "VAT %" := SalesLine."VAT %";
    //         "VAT Difference" := SalesLine."VAT Difference";
    //         IF Type = Type::"Fixed Asset" THEN begin
    //             "FA Posting Date" := SalesLine."FA Posting Date";
    //             "Depreciation Book Code" := SalesLine."Depreciation Book Code";
    //             "Depr. until FA Posting Date" := SalesLine."Depr. until FA Posting Date";
    //             "Duplicate in Depreciation Book" := SalesLine."Duplicate in Depreciation Book";
    //             "Use Duplication List" := SalesLine."Use Duplication List";
    //         end;

    //         // <<DITW15.00.00.01 DDR 27/12/2007 - DITW16.00.00.37 DDR 16/06/2010
    //         "Item Charge Line No." := SalesLine."Line No.";
    //         // >>DITW15.00.00.37 DDR
    //         // <<DITW16.00.00.41 AHU 31/08/2012 DIT-715 #327
    //         //<<DITW18.00.06 MSF 31/07/2015 - DDR 07/08/2015 DIT-770 #1368
    //         IF (SalesLine."Service Contract No." = '') and (SalesLine."Financial Contract No." = '') and
    //            (SalesLine."Contract Group Code" = '') and
    //           //>>DITW18.00.06 MSF 31/07/2015 - DDR 07/08/2015 DIT-770 #1368
    //           (SalesLine."DIT Sub-Contract Type" = 0)
    //         THEN
    //             CLEAR(SalesLine."Contract Type");
    //         // >>DITW16.00.00.41 AHU DIT-715 #327
    //         // <<DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
    //         "Service Contract No." := SalesLine."Service Contract No.";
    //         //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
    //         "Financial Contract No." := SalesLine."Financial Contract No.";
    //         //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
    //         "Service Contract Line No." := SalesLine."Service Contract Line No.";
    //         "DIT Sub-Contract Type" := SalesLine."DIT Sub-Contract Type";
    //         "Contract Group Code" := SalesLine."Contract Group Code";
    //         "Contract Type" := SalesLine."Contract Type";
    //         // >>DITW16.00.00.41 AHU DIT-715 #392
    //         // <<DITW16.00.00.42 DDR 07/12/2012 DIT-715 #370
    //         SalesSetup.GET;
    //         IF SalesLine."Split Deposit on Invoice" and
    //           (SalesSetup."Allow Split Deposit per" = SalesSetup."Allow Split Deposit per"::Document)
    //         THEN
    //             "Item Charge Type" := SalesLine."Item Charge Type";
    //         // >>DITW16.00.00.42 DDR DIT-715 #370
    //         //<<DITW17.00.02 TEC1 06/12/2013 DIT-770 #222
    //         "Line Description" := SalesLine.Description;
    //         //>>DITW17.00.02 TEC1 DIT-770 #222
    //         // <<DITW16.00.00.40 DDR 20/01/2012 DIT-715 #172
    //         IF SalesLine."Allow VAT Calculation (Free)" and SalesLine."Free Item" THEN begin
    //             IF SalesLine."Free Item Posting Type" = SalesLine."Free Item Posting Type"::Price THEN begin
    //                 SalesLine."Line Discount %" := 100;
    //                 SalesLine."Line Discount Amount" := SalesLine."VAT Base Amount";
    //             end;
    //             SalesLine."VAT Base Amount" := 0;
    //             /// DITW110.00.08 DDR 02/01/2017 NRQ#0
    //         end;
    //         // >>DITW16.00.00.40 DDR DIT-715 #172

    //         // <<DITW16.00.00.37 DDR 16/06/2010
    //         "Item Charge Line No." := SalesLine."Line No.";
    //         // >>DITW15.00.00.01 DDR

    //         // <<DITW17.00.02 DDR 04/07/2013 DIT-770 #88
    //         //IF SalesLine."Line Discount %" = 100 THEN begin
    //         IF (SalesLine."Line Discount %" = 100) and not (SalesLine."Free Item" and SalesLine."Allow VAT Calculation (Free)") THEN begin
    //             // >>DITW17.00.02 DDR DIT-770 #88
    //             "VAT Base Amount" := 0;
    //             "VAT Base Amount (ACY)" := 0;
    //             "VAT Amount" := 0;
    //             "VAT Amount (ACY)" := 0;
    //         end;

    //         //<< FINXL10.00 AKH 25/01/2017
    //         IF recFinXLSetup.READPERMISSION THEN
    //             IF Type = Type::"G/L Account" THEN
    //                 "G/L Account Description" := SalesLine.Description;
    //         //>> FINXL10.00 AKH 25/01/2017

    //         //<<FINXL7.00.001 RBE 25/03/2013
    //         "Auto. Acc. Group" := SalesLine."Auto. Acc. Group";
    //         //>>FINXL7.00.001 RBE 25/03/2013

    //         IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN
    //             SetSalesTaxForSalesLine(SalesLine);

    //         DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
    //     */
    //     // BC Upgrade POENAB02 <<        
    // end;

    // Blocked as whole code is blocked and already present in base code
    // procedure CalcDiscount(PricesInclVAT: Boolean; DiscountAmount: Decimal; DiscountAmountACY: Decimal)
    // var
    //     CurrencyACY: Record Currency;
    //     CurrencyLCY: Record Currency;
    //     GLSetup: Record "General Ledger Setup";
    // begin
    //     CurrencyLCY.InitRoundingPrecision();
    //     GLSetup.Get();
    //     IF GLSetup."Additional Reporting Currency" <> '' THEN
    //         CurrencyACY.Get(GLSetup."Additional Reporting Currency")
    //     else
    //         CurrencyACY := CurrencyLCY;
    //     "VAT Amount" := Round(
    //         CalcVATAmount(PricesInclVAT, DiscountAmount, "VAT %"),
    //         CurrencyLCY."Amount Rounding Precision",
    //         CurrencyLCY.VATRoundingDirection());
    //     "VAT Amount (ACY)" := Round(
    //         CalcVATAmount(PricesInclVAT, DiscountAmountACY, "VAT %"),
    //         CurrencyACY."Amount Rounding Precision",
    //         CurrencyACY.VATRoundingDirection());

    //     if PricesInclVAT AND ("VAT %" <> 0) then begin
    //         "VAT Base Amount" := DiscountAmount - "VAT Amount";
    //         "VAT Base Amount (ACY)" := DiscountAmountACY - "VAT Amount (ACY)";
    //     end else begin
    //         "VAT Base Amount" := DiscountAmount;
    //         "VAT Base Amount (ACY)" := DiscountAmountACY;
    //     end;
    //     Amount := "VAT Base Amount";
    //     "Amount (ACY)" := "VAT Base Amount (ACY)";
    // end;

    local procedure CalcVATAmount(ValueInclVAT: Boolean; Value: Decimal; VATPercent: Decimal): Decimal
    begin
        if VATPercent = 0 then
            exit(0);
        if ValueInclVAT then
            exit(Value / (1 + (VATPercent / 100)) * (VATPercent / 100));

        exit(Value * (VATPercent / 100));
    end;

    // Blocked as whole code is blocked and already present in base code
    // procedure SetAccount(AccountNo: Code[20]; VAR TotalVAT: Decimal; VAR TotalVATACY: Decimal; VAR TotalAmount: Decimal; VAR TotalAmountACY: Decimal)
    // begin
    //     TotalVAT := TotalVAT - "VAT Amount";
    //     TotalVATACY := TotalVATACY - "VAT Amount (ACY)";
    //     TotalAmount := TotalAmount - Amount;
    //     TotalAmountACY := TotalAmountACY - "Amount (ACY)";
    //     "G/L Account" := AccountNo;
    // end;

    // Blocked as whole code is blocked and already present in base code
    // procedure SetAmounts(TotalVAT: Decimal; TotalVATACY: Decimal; TotalAmount: Decimal; TotalAmountACY: Decimal; VATDifference: Decimal; TotalVATBase: Decimal; TotalVATBaseACY: Decimal)
    // begin
    //     Amount := TotalAmount;
    //     "VAT Base Amount" := TotalVATBase;
    //     "VAT Amount" := TotalVAT;
    //     "Amount (ACY)" := TotalAmountACY;
    //     "VAT Base Amount (ACY)" := TotalVATBaseACY;
    //     "VAT Amount (ACY)" := TotalVATACY;
    //     "VAT Difference" := VATDifference;
    // end;

    // Changed as in base procedure is replaced with this new name
    //procedure PreparePurchase(VAR PurchLine: Record "Purchase Line")
    procedure PrepareInvoicePostingBuffer(VAR PurchLine: Record "Purchase Line")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup";
    begin
        // BC Upgrade POENAB02 >>
        // Below function was commented, as it contains Aptean code
        // Function contains also Levy Tax code - needs to be reviewed
        /* 
        Clear(Rec);
        Type := PurchLine.Type;
        "System-Created Entry" := TRUE;
        "Gen. Bus. Posting Group" := PurchLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := PurchLine."Gen. Prod. Posting Group";
        "VAT Bus. Posting Group" := PurchLine."VAT Bus. Posting Group";
        "VAT Prod. Posting Group" := PurchLine."VAT Prod. Posting Group";
        "VAT Calculation Type" := PurchLine."VAT Calculation Type";
        "Global Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
        "Global Dimension 2 Code" := PurchLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := PurchLine."Dimension Set ID";
        "Job No." := PurchLine."Job No.";
        "VAT %" := PurchLine."VAT %";
        "VAT Difference" := PurchLine."VAT Difference";
        IF Type = Type::"Fixed Asset" THEN BEGIN
            "FA Posting Date" := PurchLine."FA Posting Date";
            "Depreciation Book Code" := PurchLine."Depreciation Book Code";
            "Depr. until FA Posting Date" := PurchLine."Depr. until FA Posting Date";
            "Duplicate in Depreciation Book" := PurchLine."Duplicate in Depreciation Book";
            "Use Duplication List" := PurchLine."Use Duplication List";
            "FA Posting Type" := PurchLine."FA Posting Type";
            "Depreciation Book Code" := PurchLine."Depreciation Book Code";
            "Salvage Value" := PurchLine."Salvage Value";
            "Depr. Acquisition Cost" := PurchLine."Depr. Acquisition Cost";
            "Maintenance Code" := PurchLine."Maintenance Code";
            "Insurance No." := PurchLine."Insurance No.";
            "Budgeted FA No." := PurchLine."Budgeted FA No.";
        end;

        // <<DITW15.00.00.01 DDR 27/12/2007 - DITW16.00.00.37 DDR 16/06/2010
        "Item Charge Line No." := PurchLine."Line No.";
        // >>DITW15.00.00.37 DDR
        // <<DITW16.00.00.41 AHU 31/08/2012 DIT-715 #327
        //<<DITW18.00.06 MSF 31/07/2015 - DDR 07/08/2015 DIT-770 #1368
        IF (PurchLine."Service Contract No." = '') AND (PurchLine."Financial Contract No." = '') AND
           (PurchLine."Contract Group Code" = '') AND
          //>>DITW18.00.06 MSF 31/07/2015 - DDR 07/08/2015 DIT-770 #1368
          (PurchLine."DIT Sub-Contract Type" = 0)
        THEN
            CLEAR(PurchLine."Contract Type");
        // >>DITW16.00.00.41 AHU DIT-715 #327
        // <<DITW16.00.00.41 AHU 26/07/2012 DIT-715 #392
        "Service Contract No." := PurchLine."Service Contract No.";
        //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        "Financial Contract No." := PurchLine."Financial Contract No.";
        //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
        "Service Contract Line No." := PurchLine."Service Contract Line No.";
        "DIT Sub-Contract Type" := PurchLine."DIT Sub-Contract Type";
        "Contract Group Code" := PurchLine."Contract Group Code";
        "Contract Type" := PurchLine."Contract Type";
        // >>DITW16.00.00.41 AHU DIT-715 #392
        // <<DITW16.00.00.42 DDR 07/12/2012 DIT-715 #370
        PurchSetup.GET;
        IF PurchLine."Split Deposit on Invoice" AND
          (PurchSetup."Allow Split Deposit per" = PurchSetup."Allow Split Deposit per"::Document)
        THEN
            "Item Charge Type" := PurchLine."Item Charge Type";
        // >>DITW16.00.00.42 DDR DIT-715 #370
        //<<DITW17.00.02 TEC1 06/12/2013 DIT-770 #222
        "Line Description" := PurchLine.Description;
        //>>DITW17.00.02 TEC1 DIT-770 #222
        // <<DITW16.00.00.40 DDR 20/01/2012 DIT-715 #172
        IF PurchLine."Allow VAT Calculation (Free)" AND PurchLine."Free Item" THEN BEGIN
            IF PurchLine."Free Item Posting Type" = PurchLine."Free Item Posting Type"::Price THEN BEGIN
                PurchLine."Line Discount %" := 100;
                PurchLine."Line Discount Amount" := PurchLine."VAT Base Amount";
            end;
            PurchLine."VAT Base Amount" := 0;
            /// DITW110.00.08 DDR 02/01/2017 NRQ#0
        end;
        // >>DITW16.00.00.40 DDR DIT-715 #172

        // <<DITW16.00.00.37 DDR 16/06/2010
        "Item Charge Line No." := PurchLine."Line No.";
        // >>DITW15.00.00.01 DDR

        //<<FINXL7.00.001 RBE 20/03/2013
        IF recFinXLSetup.READPERMISSION THEN
            IF Type = Type::"G/L Account" THEN
                "G/L Account Description" := PurchLine.Description;
        //>>FINXL7.00.001 RBE 20/03/2013

        //<<FINXL7.00.001 RBE 25/03/2013
        "Auto. Acc. Group" := PurchLine."Auto. Acc. Group";
        //>>FINXL7.00.001 RBE 25/03/2013

        IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN
            SetSalesTaxForPurchLine(PurchLine);

        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");

        // <<DITW17.00.02 DDR 04/07/2013 DIT-770 #88
        //IF PurchLine."Line Discount %" = 100 THEN BEGIN
        IF (PurchLine."Line Discount %" = 100) AND NOT (PurchLine."Free Item" AND PurchLine."Allow VAT Calculation (Free)") THEN BEGIN
            // >>DITW17.00.02 DDR DIT-770 #88
            "VAT Base Amount" := 0;
            "VAT Base Amount (ACY)" := 0;
            "VAT Amount" := 0;
            "VAT Amount (ACY)" := 0;
        end;

        //HEI.03>>
        "Additional Description" := PurchLine."Additional Description";
        //HEI.03<<
        //HEI.06
        "H&S Levy Tax Amount" := PurchLine."H&S Levy Tax Amount";
        "H&S Levy Tax %" := PurchLine."H&S Levy Tax %";
        "HS Posting Group" := PurchLine."HS Posting Group";
        //HEI.06
        */
        //BC Upgrade POENAB02 <<
    end;

    // procedure CalcDiscountNoVAT(DiscountAmount: Decimal; DiscountAmountACY: Decimal)
    // begin
    //     "VAT Base Amount" := DiscountAmount;
    //     "VAT Base Amount (ACY)" := DiscountAmountACY;
    //     Amount := "VAT Base Amount";
    //     "Amount (ACY)" := "VAT Base Amount (ACY)"
    // end;

    // Changed as in base procedure is replaced with this new name
    //procedure SetSalesTaxForPurchLine(PurchaseLine: Record "Purchase Line")
    procedure SetSalesTax(PurchaseLine: Record "Purchase Line")
    begin
        "Tax Area Code" := PurchaseLine."Tax Area Code";
        "Tax Liable" := PurchaseLine."Tax Liable";
        "Tax Group Code" := PurchaseLine."Tax Group Code";
        "Use Tax" := PurchaseLine."Use Tax";
        Quantity := PurchaseLine."Qty. to Invoice (Base)";
    end;

    // procedure SetSalesTaxForSalesLine(SalesLine: Record "Sales Line")
    // begin
    //     "Tax Area Code" := SalesLine."Tax Area Code";
    //     "Tax Liable" := SalesLine."Tax Liable";
    //     "Tax Group Code" := SalesLine."Tax Group Code";
    //     "Use Tax" := FALSE;
    //     Quantity := SalesLine."Qty. to Invoice (Base)";
    // end;

    // procedure ReverseAmounts()
    // begin
    //     Amount := -Amount;
    //     "VAT Base Amount" := -"VAT Base Amount";
    //     "Amount (ACY)" := -"Amount (ACY)";
    //     "VAT Base Amount (ACY)" := -"VAT Base Amount (ACY)";
    //     "VAT Amount" := -"VAT Amount";
    //     "VAT Amount (ACY)" := -"VAT Amount (ACY)";
    // end;

    // procedure SetAmountsNoVAT(TotalAmount: Decimal; TotalAmountACY: Decimal; VATDifference: Decimal)
    // begin
    //     Amount := TotalAmount;
    //     "VAT Base Amount" := TotalAmount;
    //     "VAT Amount" := 0;
    //     "Amount (ACY)" := TotalAmountACY;
    //     "VAT Base Amount (ACY)" := TotalAmountACY;
    //     "VAT Amount (ACY)" := 0;
    //     "VAT Difference" := VATDifference;
    // end;

    // Changed as in base procedure is replaced with this new name
    //procedure PrepareService(VAR ServiceLine: Record "Service Line")
    procedure PrepareInvoicePostingBuffer(VAR ServiceLine: Record "Service Line")
    begin
        Clear(Rec);
        case ServiceLine.Type of
            ServiceLine.Type::Item:
                Type := Type::Item;
            ServiceLine.Type::Resource:
                Type := Type::Resource;
            ServiceLine.Type::"G/L Account":
                Type := Type::"G/L Account";
        end;
        "System-Created Entry" := TRUE;
        "Gen. Bus. Posting Group" := ServiceLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := ServiceLine."Gen. Prod. Posting Group";
        "VAT Bus. Posting Group" := ServiceLine."VAT Bus. Posting Group";
        "VAT Prod. Posting Group" := ServiceLine."VAT Prod. Posting Group";
        "VAT Calculation Type" := ServiceLine."VAT Calculation Type";
        "Global Dimension 1 Code" := ServiceLine."Shortcut Dimension 1 Code";
        "Global Dimension 2 Code" := ServiceLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := ServiceLine."Dimension Set ID";
        "Job No." := ServiceLine."Job No.";
        "VAT %" := ServiceLine."VAT %";
        "VAT Difference" := ServiceLine."VAT Difference";
        if "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" then begin
            "Tax Area Code" := ServiceLine."Tax Area Code";
            "Tax Group Code" := ServiceLine."Tax Group Code";
            "Tax Liable" := ServiceLine."Tax Liable";
            "Use Tax" := FALSE;
            Quantity := ServiceLine."Qty. to Invoice (Base)";
        end;
    end;

    // BC Upgrade POENAB02 >>
    // Below function was commented, as it contains Aptean code
    // Record Record "Service Purchase Line" from the parameter belongs to Aptean
    /* 
    procedure PreparePurchaseService(var ServiceLine: Record "Service Purchase Line")
    begin
        // <<DITW16.00.00.01 DDR 16/06/2010
        CLEAR(Rec);
        Type := ServiceLine.Type;
        "System-Created Entry" := TRUE;
        "Gen. Bus. Posting Group" := ServiceLine."Gen. Bus. Posting Group";
        "Gen. Prod. Posting Group" := ServiceLine."Gen. Prod. Posting Group";
        "VAT Bus. Posting Group" := ServiceLine."VAT Bus. Posting Group";
        "VAT Prod. Posting Group" := ServiceLine."VAT Prod. Posting Group";
        "VAT Calculation Type" := ServiceLine."VAT Calculation Type";
        "Global Dimension 1 Code" := ServiceLine."Shortcut Dimension 1 Code";
        "Global Dimension 2 Code" := ServiceLine."Shortcut Dimension 2 Code";
        "Job No." := ServiceLine."Job No.";
        "VAT %" := ServiceLine."VAT %";
        "VAT Difference" := ServiceLine."VAT Difference";
        IF "VAT Calculation Type" = "VAT Calculation Type"::"Sales Tax" THEN BEGIN
            "Tax Area Code" := ServiceLine."Tax Area Code";
            "Tax Group Code" := ServiceLine."Tax Group Code";
            "Tax Liable" := ServiceLine."Tax Liable";
            "Use Tax" := FALSE;
            Quantity := ServiceLine."Qty. to Invoice (Base)";
        end;
    end; 
    */
    // BC Upgrade POENAB02 <<

    procedure FillPrepmtAdjBuffer(VAR TempInvoicePostBuffer: Record "Invoice Posting Buffer" temporary; InvoicePostBuffer: Record "Invoice Posting Buffer"; GLAccountNo: Code[20]; AdjAmount: Decimal; RoundingEntry: Boolean)
    var
        PrepmtAdjInvPostBuffer: Record "Invoice Posting Buffer";
    begin
        PrepmtAdjInvPostBuffer.Init();
        PrepmtAdjInvPostBuffer.Type := Type::"Prepmt. Exch. Rate Difference";
        PrepmtAdjInvPostBuffer."G/L Account" := GLAccountNo;
        PrepmtAdjInvPostBuffer.Amount := AdjAmount;
        IF RoundingEntry THEN
            PrepmtAdjInvPostBuffer."Amount (ACY)" := AdjAmount
        else
            PrepmtAdjInvPostBuffer."Amount (ACY)" := 0;
        PrepmtAdjInvPostBuffer."Dimension Set ID" := InvoicePostBuffer."Dimension Set ID";
        PrepmtAdjInvPostBuffer."Global Dimension 1 Code" := InvoicePostBuffer."Global Dimension 1 Code";
        PrepmtAdjInvPostBuffer."Global Dimension 2 Code" := InvoicePostBuffer."Global Dimension 2 Code";
        PrepmtAdjInvPostBuffer."System-Created Entry" := TRUE;
        InvoicePostBuffer := PrepmtAdjInvPostBuffer;

        TempInvoicePostBuffer := InvoicePostBuffer;
        IF TempInvoicePostBuffer.Find() THEN BEGIN
            TempInvoicePostBuffer.Amount += InvoicePostBuffer.Amount;
            TempInvoicePostBuffer."Amount (ACY)" += InvoicePostBuffer."Amount (ACY)";
            TempInvoicePostBuffer.Modify();
        end else BEGIN
            TempInvoicePostBuffer := InvoicePostBuffer;
            TempInvoicePostBuffer.Insert();
        end;
    end;

    // procedure Update(InvoicePostBuffer: Record "Invoice Posting Buffer"; VAR InvDefLineNo: Integer; VAR DeferralLineNo: Integer)
    // begin
    //     // BC Upgrade POENAB02 >>
    //     // Below function was commented, as it contains Aptean code
    //     /*
    //     Rec := InvoicePostBuffer;
    //     IF FIND THEN BEGIN
    //         Amount += InvoicePostBuffer.Amount;
    //         "VAT Amount" += InvoicePostBuffer."VAT Amount";
    //         "VAT Base Amount" += InvoicePostBuffer."VAT Base Amount";
    //         "Amount (ACY)" += InvoicePostBuffer."Amount (ACY)";
    //         "VAT Amount (ACY)" += InvoicePostBuffer."VAT Amount (ACY)";
    //         "VAT Difference" += InvoicePostBuffer."VAT Difference";
    //         "VAT Base Amount (ACY)" += InvoicePostBuffer."VAT Base Amount (ACY)";
    //         Quantity += InvoicePostBuffer.Quantity;
    //         // BC Upgrade POENAB02 >>
    //         // part of CAD development. Needs to be reviewed.
    //         // needs to be moved to StP extension?
    //         "CAD Amount" += InvoicePostBuffer."CAD Amount"; //HEI.04 
    //         // BC Upgrade POENAB02 <<
    //         "H&S Levy Tax Amount" += InvoicePostBuffer."H&S Levy Tax Amount";//HEI.06

    //         // <<DITW16.00.00.41 AHU 26/07/2012 16/08/2012 DIT-715 #392
    //         IF (("Service Contract No." <> InvoicePostBuffer."Service Contract No.") AND
    //           (InvoicePostBuffer."Service Contract No." <> '')) OR
    //           //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
    //           (("Financial Contract No." <> InvoicePostBuffer."Financial Contract No.") AND
    //            (InvoicePostBuffer."Financial Contract No." <> ''))
    //         //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
    //         THEN BEGIN
    //             //<<DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
    //             "Financial Contract No." := '';
    //             //>>DITW18.00.06 MSF 31/07/2015 DIT-770 #1368
    //             "Service Contract No." := '';
    //             "Service Contract Line No." := 0;
    //             "DIT Sub-Contract Type" := 0;
    //             "Contract Group Code" := '';
    //             "Contract Type" := 0;
    //         end;
    //         // >>DITW16.00.00.41 AHU DIT-715 #392

    //         //<< FINXL10.00.001 AKH 25/01/2017
    //         "VAT Base Amount (LCY)" += InvoicePostBuffer."VAT Base Amount (LCY)";
    //         //>> FINXL10.00.001 AKH 25/01/2017
    //         IF NOT InvoicePostBuffer."System-Created Entry" THEN
    //             "System-Created Entry" := FALSE;
    //         MODIFY;
    //         InvDefLineNo := "Deferral Line No.";
    //     end else BEGIN
    //         IF "Deferral Code" <> '' THEN BEGIN
    //             DeferralLineNo := DeferralLineNo + 1;
    //             "Deferral Line No." := DeferralLineNo;
    //             InvDefLineNo := "Deferral Line No.";
    //         end;
    //         INSERT;
    //     end;
    //     */
    //     // BC Upgrade POENAB02 <<
    // end;

    // BC Upgrade POENAB02 >>
    // Part of CAD development. Needs to be moved to StP extension?
    procedure UpdateCADAmount(TotalCAD: Decimal)
    begin
        //HEI.04>>
        "CAD Amount FND" := TotalCAD;
        //HEI.04<<
    end;
    // BC Upgrade POENAB02 <<

    // BC Upgrade POENAB02 >>
    // Part of CAD development. Needs to be moved to StP extension?
    procedure SetCADAccount(VAR TotalCAD: Decimal)
    begin
        //HEI.04>>
        TotalCAD := TotalCAD - "CAD Amount FND";
        //HEI.04<<
    end;
    // BC Upgrade POENAB02 <<
}
