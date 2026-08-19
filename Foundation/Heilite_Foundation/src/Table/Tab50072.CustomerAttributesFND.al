table 50072 "Customer Attributes FND"
{
    // version HEI.04

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 25.08.2017 # MDM Customer Card
    //   # Deleted field 3 Account Group
    // HEI.03 FDD-SLSGAP001 IBM NASTAA02 11.09.2017 # MDM Customer Card
    //   # Increased "No. Of Delivery Service" field length from 4 to 10 characters
    //   # Added Flow-Field "Account Group" from the "Customer" table
    // HEI.04 FDD-SLSGAP001 IBM NASTAA02 21.09.2017 # MDM Customer Card
    //   # Code added to Field "Flag for Deletion" in order to block a Customer
    // HEI.05 FDD-AL-OTCGAP01a IBM HORTOC01 29.09.2017
    //   # new fields for Sales Cr. Memo report
    // HEI.06 FDD-SLSGAP001 IBM NASTAA02 06.10.2017 # MDM Customer Card
    //   # Removed some fields
    // HEI.07 Bugfixing IBM NASTAA02 17.11.2017 # Local Algeria
    //   # Deleted duplicated fields "Business Register" and "Taxable Item"
    // HEI.09 CHG2034524 FDD-HT788 IBM GAVANM01 25.02.2020
    //   # New field added: 50001 - Search
    //   # code added


    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Description = 'HEI.01';
        }
        field(2; "Customer Type"; Code[20])
        {
            Caption = 'Customer Type';
            Description = 'HEI.01';
            TableRelation = "Customer Type FND";
        }
        field(5; "Business Segment"; Code[20])
        {
            Caption = 'Business Segment';
            Description = 'HEI.01';
            TableRelation = "Business Segment FND";
        }
        field(6; "Business OrganizationalSegment"; Code[20])
        {
            Caption = 'Business Organizational Segment';
            Description = 'HEI.01';
            TableRelation = "Business Org Segment FND";
        }
        field(7; "Customer Sub-Type"; Code[20])
        {
            Caption = 'Customer Sub-Type';
            Description = 'HEI.01,HEI.03';
            TableRelation = "Customer Sub-Type FND" where("Account Group" = FIELD("Account Group"));
        }
        field(8; "Local Customer Sub-Type"; Code[20])
        {
            Caption = 'Local Customer Sub-Type';
            Description = 'HEI.01,HEI.03';
            TableRelation = "Local Customer Sub-Type FND" where("Global Cust. Sub-Type" = FIELD("Customer Sub-Type"));
        }
        field(9; "Name 3"; Text[40])
        {
            Caption = 'Name 3';
            Description = 'HEI.01';
        }
        field(10; "Name 4"; Text[40])
        {
            Caption = 'Name 4';
            Description = 'HEI.01';
        }
        field(11; "Search 2"; Text[20])
        {
            Caption = 'Search 2';
            Description = 'HEI.01';
        }
        field(12; "C/O Name"; Text[40])
        {
            Caption = 'C/O Name';
            Description = 'HEI.01';
        }
        field(13; "Street 3"; Text[60])
        {
            Caption = 'Street 3';
            Description = 'HEI.01';
        }
        field(14; "Street 4"; Text[60])
        {
            Caption = 'Street 4';
            Description = 'HEI.01';
        }
        field(15; "Street 5"; Text[60])
        {
            Caption = 'Street 5';
            Description = 'HEI.01';
        }
        field(16; "House No. 1"; Text[10])
        {
            Caption = 'House No. 1';
            Description = 'HEI.01';
        }
        field(17; "House Supplement 2"; Text[10])
        {
            Caption = 'House Supplement 2';
            Description = 'HEI.01';
        }
        field(18; District; Text[35])
        {
            Caption = 'District';
            Description = 'HEI.01';
        }
        field(19; "Different City"; Text[40])
        {
            Caption = 'Different City';
            Description = 'HEI.01';
        }
        field(20; "P.O.Box"; Text[10])
        {
            Caption = 'P.O.Box';
            Description = 'HEI.01';
        }
        field(21; "P.O.Box w/0 No."; Boolean)
        {
            Caption = 'P.O.Box w/0 No.';
            Description = 'HEI.01';
        }
        field(22; "Type of Delivery Service"; Code[20])
        {
            Caption = 'Type of Delivery Service';
            Description = 'HEI.01';
            TableRelation = "Type of Delivery Service FND";
        }
        field(23; "Other City"; Text[10])
        {
            Caption = 'Other City';
            Description = 'HEI.01';
        }
        field(24; "No. of Delivery Service"; Text[10])
        {
            Caption = 'No. of Delivery Service';
            Description = 'HEI.01,HEI.03';
        }
        field(25; "P.O.Box Postal Code"; Text[10])
        {
            Caption = 'P.O.Box Postal Code';
            Description = 'HEI.01';
        }
        field(26; "Other Country"; Code[10])
        {
            Caption = 'Other Country';
            Description = 'HEI.01';
            TableRelation = "Country/Region".Code;
        }
        field(27; "Other Region"; Text[3])
        {
            Caption = 'Other Region';
            Description = 'HEI.01';
        }
        field(28; "Company Postal Code"; Code[20])
        {
            Caption = 'Company Postal Code';
            Description = 'HEI.01';
            TableRelation = "Post Code".Code;
        }
        field(29; "Authorization Group"; Code[20])
        {
            Caption = 'Authorization Group';
            Description = 'HEI.01';
            // To remove warning
            //TableRelation = "Permission Set"."Role ID";
            TableRelation = "Aggregate Permission Set"."Role ID";
        }
        field(30; "Tax Number 2"; Text[11])
        {
            Caption = 'Tax Number 2';
            Description = 'HEI.01';
        }
        field(31; "Tax Number 3"; Text[18])
        {
            Caption = 'Tax Number 3';
            Description = 'HEI.01';
        }
        field(32; "Tax Number 4"; Text[18])
        {
            Caption = 'Tax Number 4';
            Description = 'HEI.01';
        }
        field(33; "Legal Form"; Code[20])
        {
            Caption = 'Legal Form';
            Description = 'HEI.01';
            TableRelation = "Legal Form FND".Code;
        }
        field(34; "Country License"; Code[10])
        {
            Caption = 'Country License';
            Description = 'HEI.01';
            TableRelation = "Country/Region".Code;
        }
        field(35; "License Type"; Code[20])
        {
            Caption = 'License Type';
            Description = 'HEI.01';
            TableRelation = "License Type FND".Code;
        }
        field(36; "License No."; Text[17])
        {
            Caption = 'License No.';
            Description = 'HEI.01';
        }
        field(37; "License Valid from"; Date)
        {
            Caption = 'License Valid from';
            Description = 'HEI.01';
        }
        field(38; "License Valid to"; Date)
        {
            Caption = 'License Valid to';
            Description = 'HEI.01';
        }
        field(39; "Payment valid from"; Date)
        {
            Caption = 'Payment valid from';
            Description = 'HEI.01';
        }
        field(40; "Payment valid to"; Date)
        {
            Caption = 'Payment valid to';
            Description = 'HEI.01';
        }
        field(41; "Strategic Indicator"; Boolean)
        {
            Caption = 'Strategic Indicator';
            Description = 'HEI.01';
        }
        field(43; "Local key Account"; Boolean)
        {
            Caption = 'Local key Account';
            Description = 'HEI.01';
        }
        field(44; "Flag for Deletion"; Boolean)
        {
            Caption = 'Flag for Deletion';
            Description = 'HEI.01';

            trigger OnValidate();
            var
                Customer: Record Customer;
            begin
                //>>HEI.04
                if Customer.GET("Customer No.") then
                    if "Flag for Deletion" and ("Flag for Deletion" <> xRec."Flag for Deletion") then begin
                        Customer.Blocked := Customer.Blocked::All;
                        if COPYSTR(Customer.Name, 1, 3) <> 'ZZ_' then      //HEI.09
                            Customer.Name := 'ZZ_' + PADSTR(Customer.Name, 47);
                        Customer.MODIFY(true);
                    end;
                //<<HEI.04
            end;
        }
        field(45; "Invoice Email Address"; Text[80])
        {
            Caption = 'Invoice Email Address';
            Description = 'HEI.01';
        }
        field(46; "Trading Partner"; Code[20])
        {
            Caption = 'Trading Partner';
            Description = 'HEI.01';
            TableRelation = "Trading Partner FND".Code;
        }
        field(47; "Tax Number 1"; Code[20])
        {
            Caption = 'Tax Number 1';
            Description = 'HEI.01';
        }
        field(48; "Free Goods"; Boolean)
        {
            Caption = 'Free Goods';
            Description = 'HEI.01';
        }
        field(53; "Market Type"; Code[20])
        {
            Caption = 'Market Type';
            Description = 'HEI.01';
            TableRelation = "Market Type FND".Code;
        }
        field(67; "Registre de Commerce"; Text[20])
        {
            Caption = 'Registre de Commerce';
            Description = 'HEI.01';
        }
        field(68; "Article d'imposition"; Text[20])
        {
            Caption = 'Article d''imposition';
            Description = 'HEI.01';
        }
        field(69; "N.I.S."; Text[20])
        {
            Caption = 'N.I.S.';
            Description = 'HEI.01';
        }
        field(70; NIF; Text[20])
        {
            Caption = 'NIF';
            Description = 'HEI.01';
        }
        field(71; "Check Digit -VAT"; Text[10])
        {
            Caption = 'Check Digit -VAT';
            Description = 'HEI.01';
        }
        field(72; "Visit day"; Text[30])
        {
            Caption = 'Visit day';
            Description = 'HEI.01';
        }
        field(73; "Account Group"; Code[20])
        {
            CalcFormula = Lookup(Customer."Account Group FND" where("No." = FIELD("Customer No.")));
            Caption = 'Account Group';
            Description = 'HEI.03';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; Classification; Code[10])
        {
            Caption = 'Classification';
            Description = 'HEI.08';
            TableRelation = ClassificationFND.Code;
        }
        field(50001; Search; Text[20])
        {
            Caption = 'Search';
            Description = 'HEI.09';
        }
    }

    keys
    {
        key(Key1; "Customer No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        AccountGroup: Record "Account Group FND";
        Customer: Record Customer;
        Text001: Label 'You cannot modify the field %1 because the %2 on the Account Group %3 is not enabled.';
}

