tableextension 50092 ItemAnalysisViewBudgEntExtFND extends "Item Analysis View Budg. Entry"
{
    // version NAVW19.00,DITW18.00,HEI.01
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-It Item Charges functionnalities
    //                                added fields
    //                                  2013786 Valued Quantity in HL
    //                                  2013787 Quantity in HL
    //                                Added second key because max. key 252 bytes with new fields
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.23 DDR 28/07/2008 Change Caption & CaptionClass properties
    //                                  field "Unit Volume HL","Valued Quantity in HL"
    //                                Added function GetUomCaptionClass()

    // DITW15.00.00.25 DDR 10/10/2008 Remove fields
    //                                  2013786 Valued Quantity in HL
    // HEI.01 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added fileds to "Add. Market type (BPG)","Add. Product type (PPG)",
    // "Add. Cust. Dim.1","Add. Cust. Dim.2",
    // "Add. Product type R1 (PPG)","Line Extension Dim. Value Code" table 

    // POENAB02, 19.03.2026, Gap "BPM051-Create CAPEX budget"
    fields
    {
        modify("Analysis Area")
        {
            CaptionML = ENU = 'Analysis Area', FRA = 'Zone d''analyse';
            //OptionCaptionML = ENU = 'Sales,Purchase', FRA = 'Ventes,Achats';
        }
        modify("Analysis View Code")
        {

            //Unsupported feature: Change TableRelation on ""Analysis View Code"(Field 2)". Please convert manually.

            CaptionML = ENU = 'Analysis View Code', FRA = 'Code vue analytique';
        }
        modify("Budget Name")
        {

            //Unsupported feature: Change TableRelation on ""Budget Name"(Field 3)". Please convert manually.

            CaptionML = ENU = 'Budget Name', FRA = 'Nom du budget';
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

            //Unsupported feature: Change TableRelation on ""Source No."(Field 6)". Please convert manually.

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
        modify(Quantity)
        {
            CaptionML = ENU = 'Quantity', FRA = 'Quantité';
        }
        modify("Sales Amount")
        {
            CaptionML = ENU = 'Sales Amount', FRA = 'Montant vente';
        }
        modify("Cost Amount")
        {
            CaptionML = ENU = 'Cost Amount', FRA = 'Coût total';
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
            //TableRelation = "Product Group".Code;  // BC Upgrade NANDIS03 - Need to redesign as Product Group table is obsolete
        }
        field(50002; "Add. Cust. Dim.1 FND"; Code[20])
        {
            Description = 'HEI.01';
            Caption = 'Additional Customer Dimension 1';
            TableRelation = "Dimension Value".Code;
        }
        field(50003; "Add. Cust. Dim.2 FND"; Code[20])
        {
            Description = 'HEI.01';
            Caption = 'Additional Customer Dimension 2';
            TableRelation = "Dimension Value".Code;
        }
        field(50004; "Add. Product type R1 (PPG) FND"; Code[10])
        {
            Description = 'HEI.01';
            Caption = 'Additional Product Type R1 (PPG)';
            //TableRelation = "Product Group".Code;  // BC Upgrade NANDIS03 - Need to redesign as Product Group table is obsolete
        }
        field(50005; "Line Ext. Dim. Val. Code FND"; Code[20])
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
            Caption = 'Inventory Posting Group';
            FieldClass = FlowField;
        }
        // POENAB02, 19.03.2026>>
        field(50011; "Volume 1 FND"; Decimal)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Volume 1', FRA = 'Volume 1';
        }
        field(50012; "Volume 2 FND"; Decimal)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Volume 2', FRA = 'Volume 2';
        }
        // POENAB02, 19.03.2026<<         
        // field(2013787; "Quantity in HL"; Decimal)
        // {
        //     CaptionClass = GetUomCaptionClass(FIELDNO("Quantity in HL"));
        //     CaptionML = ENU = 'Quantity',
        //                 FRA = 'Quantité';
        //     DecimalPlaces = 0 : 5;
        //     Description = 'DITW15.00.00.01';
        // }  // BC Upgrade NANDIS03
    }
    keys
    {
        // key(Key1; "Analysis Area", "Analysis View Code", "Budget Name", "Item No.", "Source Type", "Source No.", "Dimension 2 Value Code", "Dimension 1 Value Code", "Dimension 3 Value Code", "Location Code", "Posting Date", "Entry No.")
        // {
        //     SumIndexFields = "Quantity in HL";
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

