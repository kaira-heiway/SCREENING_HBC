table 58078 "PFI Header INT"
{
    // Heilite Navision Old Id - 80073
    // version HEI.02

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 25.06.2021 Ibecor - PO API
    //   # New Table created for Ibecor PFI Interface
    // HEI.02 CHG2167376 HB3082 IBM NANDIS01 01.02.2023 # Ibecor-HL Integration, adding Import license and inspection codes in POs
    //   # New fields created - "License Required" (ID-32- Boolean) and "Credit Info Required" (ID-33- Boolean)


    // BC Upgrade MISHRS14 >>
    // Changed table name to "Logistics Officers FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade PATELP08>>
    // Changed name of table from "PFI Lines" to "PFI Lines FND"
    // BC Upgrade PATELP08<<


    LookupPageID = "Proforma Invoice Header";

    fields
    {
        field(1; "PFI Document No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "PFI Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Accepted,Rejected,Cancelled,Expired;
        }
        field(5; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "PQ Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "PFI Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Payment Terms Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
        field(9; "Payment Terms Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Payment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
        field(12; "Payment Method Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "IBECOR Dossier No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Logistics Officer"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Logistics Officers FND"."LO Code";
        }
        field(16; "Logistics Officer Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Total Amount(Incl. VAT)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
        field(22; Amend; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Yes,No;
        }
        field(24; "PFI Version No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "PO Created"; Boolean)
        {
            CalcFormula = Exist("PFI Lines FND" WHERE("PFI Document No." = FIELD("PFI Document No."),
                                                   "PO Number" = FILTER(<> '')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Brewery ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Shipment Method Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipment Method";
        }
        field(31; "Shipment Method Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "License Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        field(33; "Credit Info Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
    }

    keys
    {
        key(Key1; "PFI Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        grec_PFILines.RESET();
        grec_PFILines.SETRANGE("PFI Document No.", "PFI Document No.");
        if grec_PFILines.findset() then
            repeat
                grec_PFILines.DELETE();
            until grec_PFILines.NEXT() = 0;
    end;

    var
        grec_PFILines: Record "PFI Lines FND";
}

