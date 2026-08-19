table 58038 "Legacy Futur Mster Int Stp INT"
{

    // Heilite Navision Old Id - 50167
    // version HEI.01

    // HEI.01 FDD-HT610 IBM NASTAA02 11.12.2019 # La Reunion Futur Master
    //   # New Table created to store Legacy Futur Master Interface Setup
    // HEI.02 CHG2093033 IBM.LS      20.04.2021
    //   # Created New Fields: 77 - ELP Unit of Measure
    //                         78 - ELP Primary Pack Type
    //   # Added Code
    // HEI.03 CHG2113047 HB2232 IBM GAVANM01 20.07.2021 # FM interfaces files
    //   # New field added: 79 - Cust. Subtype Tr/Kiosk

    Caption = 'Legacy Futur Master Interface Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "PUM Unit of Measure"; Code[10])
        {
            Caption = 'PUM Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(3; "HL Unit of Measure"; Code[10])
        {
            Caption = 'HL Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(4; "Pallet Unit of Measure"; Code[10])
        {
            Caption = 'Pallet Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(5; "Error E-mail Address"; Text[250])
        {
            Caption = 'Error E-mail Address';
        }
        field(6; "Content UoM"; Code[10])
        {
            Caption = 'Content Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(10; "Client Master Interface Req"; Code[20])
        {
            Caption = 'Client Master Interface Request';
            TableRelation = "Interface Setup INT";
        }
        field(11; "Actual Sales Daily Exp BB Req"; Code[20])
        {
            Caption = 'Actual Sales Daily Exp BB Request';
            TableRelation = "Interface Setup INT";
        }
        field(12; "DRP Stock Export Req"; Code[20])
        {
            Caption = 'DRP Stock Export Request';
            TableRelation = "Interface Setup INT";
        }
        field(13; "MPS Stock Export Req"; Code[20])
        {
            Caption = 'MPS Stock Export Request';
            TableRelation = "Interface Setup INT";
        }
        field(14; "Actual Sales Weekly Exp BB Req"; Code[20])
        {
            Caption = 'Actual Sales Weekly Exp BB Request';
            TableRelation = "Interface Setup INT";
        }
        field(15; "Actual Sales Monthly Exp BB R"; Code[20])
        {
            Caption = 'Actual Sales Monthly Export BB Request';
            TableRelation = "Interface Setup INT";
        }
        field(16; "MRP Stock Export BB Request"; Code[20])
        {
            Caption = 'MRP Stock Export BB Request';
            TableRelation = "Interface Setup INT";
        }
        field(17; "Purchase Order Export Req"; Code[20])
        {
            Caption = 'Purchase Order Export Request';
            TableRelation = "Interface Setup INT";
        }
        field(18; "Product FM Global Req"; Code[20])
        {
            Caption = 'Product FM Global Request';
            TableRelation = "Interface Setup INT";
        }
        field(19; "Customer Discount Req"; Code[20])
        {
            Caption = 'Customer Discount Request';
            TableRelation = "Interface Setup INT";
        }
        field(20; "Client Master Interface"; Code[20])
        {
            Caption = 'Client Master Interface Export';
            TableRelation = "Interface Setup INT";
        }
        field(21; "Actual Sales Daily Exp BB"; Code[20])
        {
            Caption = 'Actual Sales Daily Export BB';
            TableRelation = "Interface Setup INT";
        }
        field(22; "DRP Stock Export"; Code[20])
        {
            Caption = 'DRP Stock Export';
            TableRelation = "Interface Setup INT";
        }
        field(23; "MPS Stock Export"; Code[20])
        {
            Caption = 'MPS Stock Export';
            TableRelation = "Interface Setup INT";
        }
        field(24; "Actual Sales Weekly Exp BB"; Code[20])
        {
            Caption = 'Actual Sales Weekly Export BB';
            TableRelation = "Interface Setup INT";
        }
        field(25; "Actual Sales Monthly Exp BB"; Code[20])
        {
            Caption = 'Actual Sales Monthly Export BB';
            TableRelation = "Interface Setup INT";
        }
        field(26; "MRP Stock Export BB Exp"; Code[20])
        {
            Caption = 'MRP Stock Export BB';
            TableRelation = "Interface Setup INT";
        }
        field(27; "Purchase Order Export Exp"; Code[20])
        {
            Caption = 'Purchase Order Export';
            TableRelation = "Interface Setup INT";
        }
        field(28; "Product FM Global Exp"; Code[20])
        {
            Caption = 'Product FM Global Export';
            TableRelation = "Interface Setup INT";
        }
        field(30; "Filter Dimension 1 Code"; Text[100])
        {
            Caption = 'Filter Dimension 1 Code';
            TableRelation = Dimension;
            ValidateTableRelation = false;
        }
        field(31; "Filter Dimension 1 Value Code"; Text[250])
        {
            Caption = 'Filter Dimension 1 Value Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Filter Dimension 1 Code"));
            ValidateTableRelation = false;
        }
        field(32; "Filter Dimension 2 Code"; Text[100])
        {
            Caption = 'Filter Dimension 2 Code';
            TableRelation = Dimension;
            ValidateTableRelation = false;
        }
        field(33; "Filter Dimension 2 Value Code"; Text[250])
        {
            Caption = 'Filter Dimension 2 Value Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Filter Dimension 2 Value Code"));
            ValidateTableRelation = false;
        }
        field(34; "Account Group Filter"; Text[100])
        {
            TableRelation = "Account Group FND";
            ValidateTableRelation = false;
        }
        field(38; "Customer Subtype Exporter"; Code[20])
        {
            Caption = 'Customer Subtype Exporter';
            TableRelation = "Customer Sub-Type FND";
        }
        field(40; "Item Category Code Filter"; Text[100])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(41; "Location Code Filter"; Text[100])
        {
            Caption = 'Location Code Filter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(42; "Bin Filter"; Text[100])
        {
            Caption = 'Bin Filter';
            TableRelation = Bin.Code;
            ValidateTableRelation = false;
        }
        field(45; "Item Category Code Filter2"; Text[100])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(46; "Location Code Filter2"; Text[100])
        {
            Caption = 'Location Code Filter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(47; "Bin Filter2"; Text[100])
        {
            Caption = 'Bin Filter';
            TableRelation = Bin.Code;
            ValidateTableRelation = false;
        }
        field(50; "Item Category Code Filter3"; Text[100])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(51; "Location Code Filter3"; Text[100])
        {
            Caption = 'Location Code Filter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(52; "Bin Filter3"; Text[100])
        {
            Caption = 'Bin Filter';
            TableRelation = Bin.Code;
            ValidateTableRelation = false;
        }
        field(55; "Item Category Code Filter4"; Text[100])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(56; "Location Code Filter4"; Text[100])
        {
            Caption = 'Location Code Filter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(57; "Bin Filter4"; Text[100])
        {
            Caption = 'Bin Filter';
            TableRelation = Bin.Code;
            ValidateTableRelation = false;
        }
        field(60; "Item Category Code Filter5"; Text[100])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(61; "Location Code Filter5"; Text[100])
        {
            Caption = 'Location Code Filter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(62; "Bin Filter5"; Text[100])
        {
            Caption = 'Bin Filter';
            TableRelation = Bin.Code;
            ValidateTableRelation = false;
        }
        field(65; "Item Category Code Filter6"; Text[100])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(66; "Location Code Filter6"; Text[100])
        {
            Caption = 'Location Code Filter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(67; "Bin Filter6"; Text[100])
        {
            Caption = 'Bin Filter';
            TableRelation = Bin.Code;
            ValidateTableRelation = false;
        }
        field(70; "Item Category Code Filter7"; Text[100])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(71; "Location Code Filter7"; Text[100])
        {
            Caption = 'Location Code Filter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(72; "Age of Plan Rcpt Days"; Integer)
        {
            Caption = 'Age of Planned Receipt in Days';
        }
        field(75; "Item Category Code Filter8"; Text[100])
        {
            Caption = 'Item Category Code Filter';
            TableRelation = "Item Category";
            ValidateTableRelation = false;
        }
        field(76; "Location Code Filter8"; Text[100])
        {
            Caption = 'Location Code Filter';
            TableRelation = Location;
            ValidateTableRelation = false;
        }
        field(77; "ELP Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(78; "ELP Primary Pack Type"; Code[20])
        {

            trigger OnLookup();
            var
                GeneralInterfaceSetupL: Record "General Interface Setup INT";
                DimensionL: Record Dimension;
                DimensionValueL: Record "Dimension Value";
            begin
                //HEI.02>>
                GeneralInterfaceSetupL.GET();
                if GeneralInterfaceSetupL."Primary Pack Type Dim. Code" <> '' then begin
                    DimensionL.GET(GeneralInterfaceSetupL."Primary Pack Type Dim. Code");
                    DimensionValueL.SETRANGE("Dimension Code", GeneralInterfaceSetupL."Primary Pack Type Dim. Code");
                    if PAGE.RUNMODAL(0, DimensionValueL) = ACTION::LookupOK then
                        "ELP Primary Pack Type" := DimensionValueL.Code;
                end;
                //HEI.02<<
            end;
        }
        field(79; "Cust. Subtype Tr/Kiosk"; Code[20])
        {
            Caption = 'Customer Subtype Transportation/Kiosk';
            DataClassification = ToBeClassified;
            Description = 'HEI.03';
            TableRelation = "Customer Sub-Type FND";
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

