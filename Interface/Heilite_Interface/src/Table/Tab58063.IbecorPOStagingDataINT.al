table 58063 "Ibecor PO Staging Data INT"
{
    // Heilite Navision Old Id - 50218
    // version HEI.04

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 31.05.2021 Ibecor - PO API
    //   # New Table created for Ibecor Interface
    // HEI.02 CHG2167376 HB3082 NORRIQ KOROLA04 11.11.2022
    //   # Bank Reference Number,Bank who issued the License - fields created
    //   # License Expiration Date,CoD/CoC Number - fields created
    // HEI.03 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields created - "License Required" (ID-65 - Boolean) and "Credit Info Required" (ID-66 - Boolean)
    // HEI.04 CHG2214459 IBM SRIVAS07 01.08.2023 - to amend the logic to get the license Number from the dimension license code
    //   # Change the Data type of "License Number" to Text[50] from Code[20]- need to store the Dimension name of the License Code.

    LookupPageID = "Ibecor Staged Data";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "Document No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Record Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Header,Line;
        }
        field(5; "Movement Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Ready to Send","Sent to Ibecor";
        }
        field(6; "Sending Version"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Last Send Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Buy from Vendor No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "External Doc No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Bill to Customer ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Approver; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Sign; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Opco Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Bill to Customer GID"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Ibecor Dossier No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Logistics Officer"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(43; Requestor; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Your Reference"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Ibecor Doc No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Comment with Date"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Licence Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.04';
        }
        field(53; "Bank Of Organism License"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54; "License Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Credit Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Credit amount Of Supplier"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Credit Validity Of Supplier"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Last Date Of Shipment"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Bank Of Organism Supplier"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Bank Reference Number"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(64; "CoD/CoC Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(65; "License Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
        field(66; "Credit Info Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

