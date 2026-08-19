table 50212 "Base Price STD Cost Calc. FND"
{
    // version HEI.03

    // HEI.01 CHG2090557 IBM.LS      02.08.2021
    //   # Created New Table: 50212 - Base Price STD Cost Calc.
    //   # Created New Fields: 1 - Item No.
    //                         2 - Variant Code
    //                         3 - Direct Unit Cost
    //                         4 - Currency Code
    //                         5 - Starting Date
    //                         6 - Ending Date
    //                         7 - Unit of Measure Code
    //  # Added Code
    // HEI.02 CHG2176288 IBM.PRASAA03 24.02.2023 "Split in Base price std cost calc for landed costs"
    //   # Added 2 new fields "Raw Mat & Pack" and "landed Costs"
    //   # Added code in Onvalidate for both above Points.
    //   # Madee Direct Unit Cost Field Non Editable.
    // 
    // HEI.03 CHG2257089 IBM.KAMNAY01 10.10.2024 " Configuration change for purchased items where price contains more than 2 decimals"
    //     # Change the Decimalplace property of two fields to 0:5 : 8. Raw Mat & Pack
    //                                                               9. Landed Cost

    Caption = 'Base Price STD Cost Calc.';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Description = 'HEI.01';
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate();
            begin

                //HEI.01>>
                if "Item No." <> xRec."Item No." then begin
                    "Unit of Measure Code" := '';
                    "Variant Code" := '';
                end;
                //HEI.01<<
            end;
        }
        field(2; "Variant Code"; Code[10])
        {
            Description = 'HEI.01';
            TableRelation = "Item Variant".Code where("Item No." = FIELD("Item No."));
        }
        field(3; "Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.01';
            Editable = false;
            NotBlank = true;
        }
        field(4; "Currency Code"; Code[10])
        {
            Description = 'HEI.01';
            TableRelation = Currency;
        }
        field(5; "Starting Date"; Date)
        {
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                if ("Starting Date" > "Ending Date") and ("Ending Date" <> 0D) then
                    ERROR(Text000, FIELDCAPTION("Starting Date"), FIELDCAPTION("Ending Date"));
                //HEI.01<<
            end;
        }
        field(6; "Ending Date"; Date)
        {
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                //HEI.01>>
                VALIDATE("Starting Date");
                //HEI.01<<
            end;
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Description = 'HEI.01';
            TableRelation = "Item Unit of Measure".Code where("Item No." = FIELD("Item No."));
        }
        field(8; "Raw Mat & Pack"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.03';

            trigger OnValidate();
            begin
                "Direct Unit Cost" := "Raw Mat & Pack" + "Landed Costs";
            end;
        }
        field(9; "Landed Costs"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            Description = 'HEI.03';

            trigger OnValidate();
            begin
                "Direct Unit Cost" := "Raw Mat & Pack" + "Landed Costs";
            end;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Variant Code", "Direct Unit Cost", "Currency Code", "Starting Date", "Unit of Measure Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //HEI.01>>
        TESTFIELD("Item No.");
        //HEI.01<<
    end;

    trigger OnRename();
    begin
        //HEI.01>>
        TESTFIELD("Item No.");
        //HEI.01<<
    end;

    var
        Text000: TextConst ENU = '%1 cannot be after %2', FRA = '%1 ne peut pas être postérieur(e) à %2';
}

