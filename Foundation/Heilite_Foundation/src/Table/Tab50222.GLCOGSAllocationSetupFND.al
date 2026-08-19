table 50222 "G/L COGS Allocation Setup FND"
{
    // version HEI.02

    // HEI.01 CHG2132673 IBM.LS      01.03.2022
    //   # Created New Table: 50222 - G/L COGS Allocation Setup
    // HEI.02 CHG2132673 IBM BULIMC01 04/03/2022 #new changes on the table
    //PATHAA02 04.04.26 #FDD-COGS-[PID803,FDD-DTW-022,IBM GAP DTW54]
    //# Table Relation for field 3 is corrected.

    Caption = 'G/L COGS Allocation Setup';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(2; "G/L Account Range for SCOA L3"; Code[20])
        {
            Caption = 'G/L Account Range for SCOA L3';
            Description = 'HEI.02';
            TableRelation = "G/L Account";
            //This property is currently not supported
            TestTableRelation = false;//Bc Upgrade YADAVM09<<
            ValidateTableRelation = false;
        }
        field(3; "Ccc Code Dim. Filter"; Text[250])
        {
            Caption = 'Ccc Code Dim. Filter';
            Description = 'HEI.02';
            //TableRelation = "Dimension Value".Code where("Dimension Code" = FILTER(CCC));  // BC Upgrade NANDIS03 - blocked as hardcode
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('CCC')); //PATHAA02-04.04.26   
            //This property is currently not supported
            TestTableRelation = false;//Bc Upgrade YADAVM09<<
            ValidateTableRelation = false;  // BC Upgrade NANDIS03 - to be opened
        }
        field(4; "COGS Allocation"; Option)
        {
            Caption = 'COGS Allocation';
            Description = 'HEI.01';
            OptionCaption = '" ,Energy & Water,Inv. Mov. Var. Prod Exp.,Other Variable Expenses,Packaging Materials,Prod Bought in for Resale,Prod Fix Exp,Raw Materials"';
            OptionMembers = " ","Energy & Water","Inv. Mov. Var. Prod Exp.","Other Variable Expenses","Packaging Materials","Prod Bought in for Resale","Prod Fix Exp","Raw Materials";
        }
        field(5; "Period Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "COGS Allocation", "G/L Account Range for SCOA L3")
        {
        }
    }

    fieldgroups
    {
    }
}

