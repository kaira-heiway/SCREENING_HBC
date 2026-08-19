table 50362 "COGS Alloc on STD Price FND"
{
    // version HEI.08

    // HEI.01 CHG2132673 IBM.LS      01.03.2022
    //   # Created New Table: 50238 - COGS Allocation on STD Price
    // HEI.02 CHG2132673 IBM BULIMC01 08/04/2022#COGS Allocation - new updates on the table
    // HEI.03 HB2605 - CHG2132673 IBM NASTAA02 11.03.2022 # COGS Allocation
    //   # Setup "AutoIncrement" = YES for "Entry No." field
    //   # Made Fields "Raw Materials_HL" and "Packaging Materials_HL" FlowFields
    // HEI.04 CHG2172818 PRASAA03 31.01.2023 EPM COGS Allocation: Average items enhancement
    //   # Added New fields for standard cost calculation
    //   # fields "Prod Bought_Resale Avg Cost_HL" and "Prod Bought_Resale Avg Cost" captions changed.
    // HEI.05 CHG2172818 PRASAA03 04.04.2023 EPM COGS Allocation: Average items enhancement
    //   # fields "Prod Bought_Resale Avg Cost_HL" and "Prod Bought_Resale Avg Cost" Decimal places added to 3
    // HEI.06 CHG2172818 PRASAA03 24.08.2023 EPM COGS Allocation: Average items enhancement
    //   # fields decimal value changed to 5 decimals.
    // HEI.07 CHG2172818 PRASAA03 27.10.2023 EPM COGS Allocation: Average items enhancement
    //   # "Valued Quantity HL" field decimal places value changed to 5 decimals.
    // HEI.08 CHG2172818 PRASAA03 07.12.2023 EPM COGS Allocation: Average items enhancement
    //   # fields "Prod Bought_Resale Avg Cost_HL" and "Prod Bought_Resale Avg Cost" captions changed.

    // BC Upgrade KUMARS145 Nav ID Table 50238 "COGS Alloc on STD Price FND"

    Caption = 'COGS Allocation on STD Price';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            Description = 'HEI.01,HEI.03';
        }
        field(2; "Processing Date"; Date)
        {
            Caption = 'Processing Date';
            Description = 'HEI.01';
        }
        field(4; Company; Text[30])
        {
            Caption = 'Company';
            Description = 'HEI.01';
            TableRelation = Company;
        }
        field(5; "Fiscal Year"; Integer)
        {
            Caption = 'Fiscal Year';
            Description = 'HEI.01';
        }
        field(6; "Period Number"; Integer)
        {
            Caption = 'Period Number';
            Description = 'HEI.02';
        }
        field(7; Location; Code[10])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            TableRelation = Location;
        }
        field(8; "SKU of Sold Products"; Code[20])
        {
            Caption = 'SKU of Sold Products';
            Description = 'HEI.01';
        }
        field(9; Brand; Code[20])
        {
            Caption = 'Brand';
            Description = 'HEI.01';
        }
        field(10; "Line Extension"; Code[20])
        {
            Caption = 'Line Extension';
            Description = 'HEI.01';
        }
        field(11; "Pack Type"; Code[20])
        {
            Caption = 'Pack Type';
            Description = 'HEI.01';
        }
        field(12; "Volumes Sold HL"; Decimal)
        {
            Caption = 'Volumes Sold_HL';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01,HEI.06';
        }
        field(13; "Raw Materials_HL"; Decimal)
        {
            CalcFormula = Sum("COGS Alloc STD Price Line FND"."Cost Raw or Pack Mat." WHERE(Company = FIELD(Company),
                                                                                            "Fiscal Year" = FIELD("Fiscal Year"),
                                                                                            "Period Number" = FIELD("Period Number"),
                                                                                            "Parent Item No." = FIELD("SKU of Sold Products"),
                                                                                            "COGS Allocation" = CONST("Raw Materials")));
            Caption = 'Raw Materials HL';
            Description = 'HEI.01,HEI.03,HEI.02';
            FieldClass = FlowField;
        }
        field(14; "Packaging Materials_HL"; Decimal)
        {
            CalcFormula = Sum("COGS Alloc STD Price Line FND"."Cost Raw or Pack Mat." WHERE(Company = FIELD(Company),
                                                                                            "Fiscal Year" = FIELD("Fiscal Year"),
                                                                                            "Period Number" = FIELD("Period Number"),
                                                                                            "Parent Item No." = FIELD("SKU of Sold Products"),
                                                                                            "COGS Allocation" = CONST("Packaging Materials")));
            Caption = 'Packaging Materials HL';
            Description = 'HEI.01,HEI.03,HEI.02';
            FieldClass = FlowField;
        }
        field(15; "Energy & Water_Prod_HL"; Decimal)
        {
            Caption = 'Energy & Water_Prod HL';
            Description = 'HEI.01HEI.02';
        }
        field(16; "Other Variable Expenses_HL"; Decimal)
        {
            Caption = 'Other Variable Expenses HL';
            Description = 'HEI.01HEI.02';
        }
        field(17; "Prod Fix Exp_COGS_HL"; Decimal)
        {
            CalcFormula = Sum("COGS Alloc STD Price Line FND"."Cost. Prod. Fix. per HL of FG" WHERE(Company = FIELD(Company),
                                                                                                    "Fiscal Year" = FIELD("Fiscal Year"),
                                                                                                    "Period Number" = FIELD("Period Number"),
                                                                                                    "Parent Item No." = FIELD("SKU of Sold Products")));
            Caption = 'Prod. Fix Exp. COGS HL';
            Description = 'HEI.01,HEI.02';
            FieldClass = FlowField;
        }
        field(18; "Total Standard Cost/HL"; Decimal)
        {
            Caption = 'Total Standard Cost HL';
            Description = 'HEI.01HEI.02';
        }
        field(19; "Prod Bought_Resale Avg Cost_HL"; Decimal)
        {
            Caption = 'Products Bought in for Resale Avg. Cost HL';
            DecimalPlaces = 0 : 3;
            Description = 'HEI.01HEI.02,HEI.04,HEI.05,HEI.08';
        }
        field(20; "Raw Materials"; Decimal)
        {
            Caption = 'Raw Materials';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01,HEI.06';
        }
        field(21; "Packaging Materials"; Decimal)
        {
            Caption = 'Packaging Materials';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01,HEI.06';
        }
        field(22; "Energy & Water_Prod"; Decimal)
        {
            Caption = 'Energy & Water_Prod';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01,HEI.06';
        }
        field(23; "Other Variable Expenses"; Decimal)
        {
            Caption = 'Other Variable Expenses';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01,HEI.06';
        }
        field(24; "Prod Fix Exp_COGS"; Decimal)
        {
            Caption = 'Prod. Fix Exp. COGS';
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01,HEI.02,HEI.06';
        }
        field(25; "Total Standard Cost"; Decimal)
        {
            Caption = 'Total Standard Cost';
            Description = 'HEI.01';
        }
        field(26; "Prod Bought_Resale Avg Cost"; Decimal)
        {
            Caption = 'Products Bought in for Resale Avg. Cost';
            DecimalPlaces = 0 : 3;
            Description = 'HEI.01,HEI.04,HEI.05,HEI.08';
        }
        field(27; Unallocated; Decimal)
        {
            Caption = 'Unallocated';
            Description = 'HEI.01,HEI.02';
        }
        field(28; "Period G/L Cost Raw Materials"; Decimal)
        {
            Caption = 'Period G/L Cost Raw Materials';
            Description = 'HEI.01';
        }
        field(29; "Period G/L Cost Pack Materials"; Decimal)
        {
            Caption = 'Period G/L Cost Packing Materials';
            Description = 'HEI.01';
        }
        field(30; "Period G/L Cost Energy & Water"; Decimal)
        {
            Caption = 'Period G/L Cost Energy & Water';
            Description = 'HEI.01';
        }
        field(31; "Period G/L Cost Other Var Exp"; Decimal)
        {
            Caption = 'Period G/L Cost Other Variable Expenses';
            Description = 'HEI.01';
        }
        field(32; "Period G/L Cost InvMovVarProEx"; Decimal)
        {
            Caption = 'Period G/L Cost Inv Mov Var Prod Exp';
            Description = 'HEI.01';
        }
        field(33; "Period G/L Cost Prod Fix Exp"; Decimal)
        {
            Caption = 'Period G/L Cost Prod Fix Exp';
            Description = 'HEI.01';
        }
        field(34; "Period G/L Cost ProdBghtResale"; Decimal)
        {
            Caption = 'Period G/L Cost Products Bought in for Resale';
            Description = 'HEI.01';
        }
        field(35; "Costing Method"; Option)
        {
            CaptionML = ENU = 'Costing Method',
                        FRA = 'Mode évaluation stock';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
            OptionCaptionML = ENU = 'FIFO,LIFO,Specific,Average,Standard',
                              FRA = 'FIFO,LIFO,Spécifique,Moyen,Standard';
            OptionMembers = FIFO,LIFO,Specific,"Average",Standard;
        }
        field(36; "Volumes Sold"; Decimal)
        {
            Caption = 'Volumes Sold';
            Description = 'HEI.02';
        }
        field(37; "Cost Posted to G/L"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(38; "Valued Quantity HL"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.04,HEI.07';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; Company, "Fiscal Year", "Period Number", "SKU of Sold Products")
        {
        }
    }

    fieldgroups
    {
    }
}

