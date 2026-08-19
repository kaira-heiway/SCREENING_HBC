table 50205 "DRC-Setup for Exp Pay Meth FND"
{
    // version HEI.01

    // HEI.01 CHG2190168 IBM POENAB02 20.08.2021 HB2330 BKT-EFT Citi bank payment file update
    //   # Object created
    //   # 25.01.2023 Old CHG CHG2117475 was replaced with CHG2190168. Initial change was on 20.08.2021.

    // BC Upgrade KUMARS145 Nav ID Table 50205 "DRC-Setup for Exp Pay Meth FND"

    Caption = 'Setup for exporting Payment method';

    fields
    {
        field(1; "House Bank"; Code[20])
        {
            Caption = 'House Bank';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            TableRelation = "Bank Account"."No.";
        }
        field(2; "Receiving Bank"; Code[10])
        {
            Caption = 'Receiving Bank';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            TableRelation = "Vendor Bank Account".Code;
        }
        field(3; Currency; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            TableRelation = Currency.Code;
        }
        field(4; "Country Receiving Bank"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            TableRelation = "Vendor Bank Account"."Country/Region Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(5; "Value for Payment Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(6; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            TableRelation = "Bank Account"."Country/Region Code";
        }
        field(7; "Swift Code"; Boolean)
        {
            Caption = 'Swift Code';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
    }

    keys
    {
        key(Key1; "House Bank", "Receiving Bank", Currency, "Country Receiving Bank")
        {
        }
    }

    fieldgroups
    {
    }
}

