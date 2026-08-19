table 50058 "OPCO Setup FND"
{
    // version HEI.09,ESKER

    // HEI.03 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01 21.09.2018
    //   # 2 new fields: 25 and 26 for GL Account Interface ESKER
    // HEI.04 CHG2022396 Esker Ethiopia IBM POSTOI01 17.07.2019
    //   # new field 27 LC Dimension Code
    // HEI.05 CHG2143354 IBM POENAB02 20.01.2022 Export G/L Entries - Tax audit - Extraction stuck
    //   # New field: 28 Server Name
    // HEI.06 HEI.06 CHG2127496 SHOIVAS05 IBM 08.02.2022
    //   #new field created: 29 - "Path for payment file"
    // HEI.07 CHG2157342 HB2809 IBM NANDIS01 25.07.2022 - Email notifications of Open Po's sent to Requestors
    //   # New field created - field id - 30 - "CC id for PO Send Email"
    // HEI.08 CHG2157342 HB2809 IBM NANDIS01 22.09.2022 - Email notifications of Open Po's sent to Requestors
    //   # Length of the field - "CC id for PO Send Email" increased to 150
    // HEI.09 CHG2180515 HB3249 IBM NANDIS01 12.12.2022 - Send Email Reminder to Requesters
    //   # New field "PO Doc. Subtype excluded" created

    // BC Upgrade SHUKLP03 >> Document subtype table relation added.

    Caption = 'General Interface OpCo Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Sales Date Formula"; DateFormula)
        {
        }
        field(3; "Delivery Date Formula"; DateFormula)
        {
        }
        field(25; "Business Type Dimension Code"; Code[20])
        {
            Caption = 'Business Type Dimension Code';
            Description = 'HEI.03';
            TableRelation = Dimension;
        }
        field(26; "Movement Type Dimension Code"; Code[20])
        {
            Caption = 'Movement Type Dimension Code';
            Description = 'HEI.03';
            TableRelation = Dimension;
        }
        field(27; "LC Dimension Code"; Code[20])
        {
            Caption = 'LC Dimension Code';
            Description = 'HEI.04';
            TableRelation = Dimension;
        }
        field(28; "Server Name"; Text[100])
        {
            Caption = 'Server Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.05';
        }
        field(29; "Path for payment file"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.06';
        }
        field(30; "CC id for PO Send Email"; Text[150])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.07,HEI.08';
        }
        field(31; "PO Doc. Subtype excluded"; Code[40])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.09';
            TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Purchase));  // BC Upgrade SHUKLP03
            ValidateTableRelation = false;  // BC Upgrade SHUKLP03
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

