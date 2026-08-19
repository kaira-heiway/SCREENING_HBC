tableextension 50090 ItemAnalysisViewEntryExtFND extends "Item Analysis View Entry"
{
    // version NAVW18.00,DITW18.00,HEI.03
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-It Item Charges functionnalities
    //                                added fields
    //                                  2013786 Valued Quantity in HL
    //                                  2013787 Quantity in HL
    //                                  2013650 Sales Deposit Amount (Actual)
    //                                  2013651 Sales Deposit Amount (Expected)
    //                                  2013660 Purchase Deposit Amount (Actual)
    //                                  2013661 Purchase Deposit Amount (Expected)
    //                                  2013794 Discount Amount
    //                                  2034650 Sales Tax Amount (Actual)
    //                                  2034651 Sales Tax Amount (Expected)
    //                                  2034660 Purchase Tax Amount (Actual)
    //                                  2034661 Purchase Tax Amount (Expected)
    //                                  2013611 Empty Goods Item No.
    //                                  2034675 Item Charge Type

    //                                Added 3 similar keys because max. key 252 bytes with new fields
    //                                  (to have more sumindexfields)
    //                                Added fields "Item Charge Type","Empty Goods Item No." into all keys
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.20 DDR 11/06/2008 Certification rules
    // DITW15.00.00.23 DDR 23/07/2008 Replaced "Empty Goods Item No." by "Item Charge No."
    //                                Added fields
    //                                  2013798 Item Charge No.
    // DITW15.00.00.23 DDR 28/07/2008 Change Caption & CaptionClass properties
    //                                  field "Unit Volume HL","Valued Quantity in HL"
    //                                Added function GetUomCaptionClass()
    // DITW15.00.00.25 DDR 10/10/2008 Added fields
    //                                  2013692 Internal Tax Amount (Actual)
    //                                  2013693 Internal Tax Amount (Exp)
    //                                  2013796 Invoiced Quantity in HL
    //                                Removed fields
    //                                  2013786 Valued Quantity in HL
    //                                Added sumindexfields "Internal Tax Amount (Actual),Internal Tax Amount (Exp)"
    // DITW15.00.00.25 DDR 10/10/2008 Added optionstring 'ShippingCost' for field "Item Charge Type"
    //                     27/10/2008 Changed property AutoFormatType=2013661 for fields
    //                                   "Sales Tax Amount (Actual)","Sales Tax Amount (Expected)"
    //                                   "Purchase Tax Amount (Actual)","Purchase Tax Amount (Expected)"
    //                                   "Internal Tax Amount (Actual)","Internal Tax Amount (Exp)"
    // DITW15.00.00.32 DDR 07/04/2009 Added function GetAutoformatRoundingType() to use into property 'AutoformatRoundingType'
    // DITW15.00.00.35 DDR 13/10/2009 issue 722 Updated Filters - TableRelation property field "Empty Goods Item No. Filter"
    // DITW15.00.00.38 DDR 17/12/2010 issue 703 Added fields
    //                                            2014113 Tax Item No.
    //                                          Added functions GetTrackingItemNo(),LookupItemNo()
    // DITW16.00.00.40 DDR 13/01/2012 DIT-715 #175 Public function GetUomCaptionClass()
    //                                             Modified Captions fields 2013650,2013651
    // DITW17.10.03 MSF 10/04/2014 DIT-770 #240 : Use the Value Entry - Item Ledger Entrys Source No for analysis, deposits,..
    //                                            Added field 2014114 "Item Ledger Entry source No."
    // DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions
    // HEI.01 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added fileds to "Add. Market type (BPG)","Add. Product type (PPG)","Add. Cust. Dim.1","Add. Cust. Dim.2","Add. Product type R1 (PPG)","Line Extension Dim. Value Code" table

    // HEI.02 FDD-HB1425 BULIMC01 IBM 03.06.2020 #new fields created:
    //     #50011 - "Shortcut 1 Value Code"
    //     #50012 - "Shortcut 2 Value Code"
    //     #code added to GetCaptionClass function
    //     #new fields added to all the table keys: "Shortcut 1 Value Code","Shortcut 2 Value Code"
    // HEI.03 IBM YADAVM09 12/10/23 CHG2218600_HB3954 DRC Interredional transfer exclusion from WIS MSV
    // #Added new field Reporting Type
    //Bc Upgrade YADAVM09 Bug Fix BCUP0-167.
    fields
    {
        modify("Analysis Area")
        {
            CaptionML = ENU = 'Analysis Area', FRA = 'Zone d''analyse';
            // OptionCaptionML = ENU = 'Sales,Purchase,Inventory', FRA = 'Ventes,Achats,Stocks';
        }
        modify("Analysis View Code")
        {

            //Unsupported feature: Change TableRelation on ""Analysis View Code"(Field 2)". Please convert manually.

            CaptionML = ENU = 'Analysis View Code', FRA = 'Code vue analytique';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify("Source Type")
        {
            CaptionML = ENU = 'Source Type', FRA = 'Type origine';
            //OptionCaptionML = ENU = ' ,Customer,Vendor,Item', FRA = ' ,Client,Fournisseur,Article';
        }
        modify("Source No.")
        {

            //Unsupported feature: Change TableRelation on ""Source No."(Field 5)". Please convert manually.

            CaptionML = ENU = 'Source No.', FRA = 'N° origine';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Dimension 1 Value Code")
        {
            CaptionML = ENU = 'Dimension 1 Value Code', FRA = 'Code section axe 1';
        }
        modify("Dimension 2 Value Code")
        {
            CaptionML = ENU = 'Dimension 2 Value Code', FRA = 'Code section axe 2';
        }
        modify("Dimension 3 Value Code")
        {
            CaptionML = ENU = 'Dimension 3 Value Code', FRA = 'Code section axe 3';
        }
        modify("Posting Date")
        {
            CaptionML = ENU = 'Posting Date', FRA = 'Date comptabilisation';
        }
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Item Ledger Entry Type")
        {
            CaptionML = ENU = 'Item Ledger Entry Type', FRA = 'Type écriture comptable article';
            // OptionCaptionML = ENU = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output', FRA = 'Achat,Vente,Positif (ajust.),Négatif (ajust.),Transfert,Consommation,Production, ,Consommation d''assemblage,Résultat d''assemblage';
        }
        modify("Entry Type")
        {
            CaptionML = ENU = 'Entry Type', FRA = 'Type écriture';
            // OptionCaptionML = ENU = 'Direct Cost,Revaluation,Rounding,Indirect Cost,Variance', FRA = 'Coût direct,Réévaluation,Arrondi,Coût indirect,Écart';
        }
        modify("Invoiced Quantity")
        {
            CaptionML = ENU = 'Invoiced Quantity', FRA = 'Quantité facturée';
        }
        modify("Sales Amount (Actual)")
        {
            CaptionML = ENU = 'Sales Amount (Actual)', FRA = 'Montant vente (réel)';
        }
        modify("Cost Amount (Actual)")
        {
            CaptionML = ENU = 'Cost Amount (Actual)', FRA = 'Coût total (réel)';
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            CaptionML = ENU = 'Cost Amount (Non-Invtbl.)', FRA = 'Coût total (non incorp.)';
        }
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Sales Amount (Expected)")
        {
            CaptionML = ENU = 'Sales Amount (Expected)', FRA = 'Montant vente (prévu)';
        }
        modify("Cost Amount (Expected)")
        {
            CaptionML = ENU = 'Cost Amount (Expected)', FRA = 'Coût total (prévu)';
        }
        field(50000; "Add. Market type (BPG) FND"; Code[10])
        {
            Description = 'HEI.01';
            Caption = 'Additional Market Type (BPG)';
            TableRelation = "Gen. Business Posting Group"."Market Type FND";
        }
        field(50001; "Add. Product type (PPG) FND"; Code[10])
        {
            Description = 'HEI.01';
            Caption = 'Additional Product Type (PPG)';
            //TableRelation = "Product Group".Code;  // BC Upgrade NANDIS03 - Needs to redesign
        }
        field(50002; "Add. Cust. Dim.1 FND"; Code[20])
        {
            Description = 'HEI.01';
            Caption = 'Additional Customer Dimension 1';
            TableRelation = "Dimension Value".Code;
        }
        field(50003; "Add. Cust. Dim.2 FND"; Code[20])
        {
            Caption = 'Additional Customer Dimension 2';
            Description = 'HEI.01';
            TableRelation = "Dimension Value".Code;
        }
        field(50004; "Add. Product type R1 (PPG) FND"; Code[10])
        {
            Description = 'HEI.01';
            Caption = 'Additional Product Type R1 (PPG)';
            //TableRelation = "Product Group".Code;  // BC Upgrade NANDIS03 - Needs to redesign
        }
        field(50005; "Line Ext. Dim. Value Code FND"; Code[20])
        {
            CaptionML = ENU = 'Line Extension Dimension Value Code',
                        FRA = 'Line Extension Dimension Value Code';
            Description = 'HEI.01';
            TableRelation = "Dimension Value".Code;
        }
        field(50010; "Inventory Posting Group FND"; Code[20])
        {
            CalcFormula = Lookup(Item."No." where("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Inventory Posting Group';
        }
        field(50011; "Shortcut 1 Value Code FND"; Code[20])
        {
            AccessByPermission = TableData Dimension = R;
            // CaptionClass = GetCaptionClass(4);//Bc upgrade YADAVM09 BCUP0-167<<
            CaptionML = ENU = 'Shortcut 1 Value Code',
                        FRA = 'Code section axe 1';
        }
        field(50012; "Shortcut 2 Value Code FND"; Code[20])
        {
            AccessByPermission = TableData Dimension = R;
            //CaptionClass = GetCaptionClass(5);//Bc upgrade YADAVM09 BCUP0-167<<
            CaptionML = ENU = 'Shortcut 2 Value Code',
                        FRA = 'Code section axe 1';
        }
        field(50013; "Reporting Type FND"; Option)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            Caption = 'Reporting Type';
            OptionCaption = '" , Interregional Transfer Outbound , Interregional Transfer Outbound"';
            OptionMembers = " ","Interregional Transfer Inbound","Interregional Transfer Outbound";
        }
        // field(2013611; "Empty Goods Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Empty Goods Item No.',
        //                 FRA = 'N° article vidange';
        //     Description = 'DITW15.00.00.01-.35';
        //     TableRelation = Item where("Empty Good" = CONST(true));
        // }
        // field(2013640; "Sales Deposit Amount (Actual)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Sales Deposit Amount (Actual)',
        //                 FRA = 'Montant consigne vente (Actuel)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013641; "Sales Deposit Amount (Exp)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Sales Deposit Amount (Expected)',
        //                 FRA = 'Montant consigne vente (Prévu)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013650; "Purchase Deposit Amt. (Actual)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Purchase Deposit Amount (Actual)',
        //                 FRA = 'Montant consigne achat (Actuel)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013651; "Purchase Deposit Amt. (Exp)"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Purchase Deposit Amount (Expected)',
        //                 FRA = 'Montant consigne achat (Prévu)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013670; "Sales Tax Amount (Actual)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Sales Tax Amount (Actual)',
        //                 FRA = 'Montant taxe vente (Actuel)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013671; "Sales Tax Amount (Expected)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Sales Tax Amount (Expected)',
        //                 FRA = 'Montant taxe vente (Prévu)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013680; "Purchase Tax Amount (Actual)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Purchase Tax Amount (Actual)',
        //                 FRA = 'Montant taxe achat (Acutel)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013681; "Purchase Tax Amount (Expected)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Purchase Tax Amount (Expected)',
        //                 FRA = 'Montant tawe achat (Prévu)';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013692; "Internal Tax Amount (Actual)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Internal Tax Amount (Actual)',
        //                 FRA = 'Montant interne taxe (réel)';
        //     Description = 'DITW15.00.00.25';
        // }
        // field(2013693; "Internal Tax Amount (Exp)"; Decimal)
        // {
        //     AutoFormatType = 2013661;
        //     CaptionML = ENU = 'Internal Tax Amount (Expected)',
        //                 FRA = 'Montant interne taxe (prévu)';
        //     Description = 'DITW15.00.00.25';
        // }
        // field(2013695; "Item Charge Type"; Option)
        // {
        //     CaptionML = ENU = 'Item Charge Type',
        //                 FRA = 'Type frais annexes';
        //     Description = 'DITW15.00.00.01';
        //     OptionCaptionML = ENU = ' ,Tax,Deposit,Discount,Promotion,,Shipping Cost',
        //                       FRA = ' ,Taxe,Consigne,Remise,Promotion,,Coût transport';
        //     OptionMembers = " ",Tax,Deposit,Discount,Promotion,,ShippingCost;
        // }
        // field(2013787; "Quantity in HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Quantity in HL"));
        //     CaptionML = ENU = 'Quantity',
        //                 FRA = 'Quantité';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013794; "Discount Amount"; Decimal)
        // {
        //     AutoFormatType = 1;
        //     CaptionML = ENU = 'Discount Amount',
        //                 FRA = 'Montant Remise';
        //     Description = 'DITW15.00.00.01';
        // }
        // field(2013796; "Invoiced Quantity in HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Invoiced Quantity in HL"));
        //     CaptionML = ENU = 'Invoiced Quantity',
        //                 FRA = 'Quantité facturée';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.25';
        // }
        // field(2013798; "Item Charge No."; Code[20])
        // {
        //     CaptionML = ENU = 'Item Charge No.',
        //                 FRA = 'N° frais annexes';
        //     Description = 'DITW15.00.00.23';
        //     TableRelation = "Item Charge";
        // }
        // field(2014113; "Tax Item No."; Code[20])
        // {
        //     CaptionML = ENU = 'Tax Tracking Item No.',
        //                 FRA = 'N° article traçable Taxe';
        //     Description = 'DITW15.00.00.38 #703';
        //     TableRelation = Item;
        // }
        // field(2014114; "Item Ledger Entry source No."; Code[20])
        // {
        //     CaptionML = ENU = 'Item Ledger Entry source No.',
        //                 FRA = 'N° d''origine écriture article';
        //     Description = 'DIT-770 #240';
        // }  // BC Upgrade NANDIS03
    }
    keys
    {

        //Unsupported feature: Deletion on ""Analysis Area","Analysis View Code","Item No.","Item Ledger Entry Type","Entry Type","Source Type","Source No.","Dimension 1 Value Code","Dimension 2 Value Code","Dimension 3 Value Code","Location Code","Posting Date","Entry No."(Key)". Please convert manually.

        // key(Key1; "Analysis Area", "Analysis View Code", "Item No.", "Item Ledger Entry Type", "Entry Type", "Source Type", "Source No.", "Item Charge Type", "Item Charge No.", "Dimension 1 Value Code", "Dimension 2 Value Code", "Dimension 3 Value Code", "Shortcut 1 Value Code", "Shortcut 2 Value Code", "Location Code", "Posting Date", "Entry No.")
        // {
        //     SumIndexFields = "Sales Amount (Actual)", "Cost Amount (Actual)", Quantity, "Invoiced Quantity";
        // }
        // key(Key2; "Analysis Area", "Analysis View Code", "Item No.", "Item Ledger Entry Type", "Entry Type", "Source Type", "Source No.", "Item Charge Type", "Item Charge No.", "Dimension 2 Value Code", "Dimension 3 Value Code", "Dimension 1 Value Code", "Shortcut 1 Value Code", "Shortcut 2 Value Code", "Location Code", "Posting Date", "Entry No.")
        // {
        //     SumIndexFields = "Sales Amount (Expected)", "Cost Amount (Expected)", "Cost Amount (Non-Invtbl.)";
        // }
        // key(Key3; "Analysis Area", "Analysis View Code", "Item No.", "Item Ledger Entry Type", "Entry Type", "Source Type", "Source No.", "Item Charge Type", "Item Charge No.", "Dimension 2 Value Code", "Dimension 1 Value Code", "Dimension 3 Value Code", "Shortcut 1 Value Code", "Shortcut 2 Value Code", "Location Code", "Posting Date", "Entry No.")
        // {
        //     SumIndexFields = "Quantity in HL", "Invoiced Quantity in HL", "Discount Amount";
        // }
        // key(Key4; "Analysis Area", "Analysis View Code", "Item No.", "Item Ledger Entry Type", "Entry Type", "Source Type", "Source No.", "Item Charge Type", "Item Charge No.", "Dimension 3 Value Code", "Dimension 1 Value Code", "Dimension 2 Value Code", "Shortcut 1 Value Code", "Shortcut 2 Value Code", "Location Code", "Posting Date", "Entry No.")
        // {
        //     SumIndexFields = "Sales Tax Amount (Actual)", "Sales Tax Amount (Expected)", "Purchase Tax Amount (Actual)", "Purchase Tax Amount (Expected)";
        // }
        // key(Key5; "Analysis Area", "Analysis View Code", "Item No.", "Item Ledger Entry Type", "Entry Type", "Source Type", "Source No.", "Item Charge Type", "Item Charge No.", "Dimension 3 Value Code", "Dimension 2 Value Code", "Dimension 1 Value Code", "Shortcut 1 Value Code", "Shortcut 2 Value Code", "Location Code", "Posting Date", "Entry No.")
        // {
        //     SumIndexFields = "Sales Deposit Amount (Actual)", "Sales Deposit Amount (Exp)";
        // }
        // key(Key6; "Analysis Area", "Analysis View Code", "Item No.", "Item Ledger Entry Type", "Entry Type", "Source Type", "Source No.", "Item Charge Type", "Item Charge No.", "Dimension 1 Value Code", "Dimension 3 Value Code", "Dimension 2 Value Code", "Shortcut 1 Value Code", "Shortcut 2 Value Code", "Location Code", "Posting Date", "Entry No.")
        // {
        //     SumIndexFields = "Purchase Deposit Amt. (Actual)", "Purchase Deposit Amt. (Exp)", "Internal Tax Amount (Actual)", "Internal Tax Amount (Exp)";
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=1,5,,Dimension 1 Value Code;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=1,5,,Dimension 1 Value Code;FRA=1,5,,Code section axe 1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=1,5,,Dimension 2 Value Code;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=1,5,,Dimension 2 Value Code;FRA=1,5,,Code section axe 2;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=1,5,,Dimension 3 Value Code;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=1,5,,Dimension 3 Value Code;FRA=1,5,,Code section axe 3;
    //Variable type has not been exported.

    var
        Text003: TextConst ENU = '1,5,,Shortcut 1 Value Code', FRA = '1,5,,Code section axe 3';
        Text004: TextConst ENU = '1,5,,Shortcut 2 Value Code', FRA = '1,5,,Code section axe 3';
}

