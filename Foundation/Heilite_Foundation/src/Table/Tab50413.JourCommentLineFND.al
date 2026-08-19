table 50413 "Jour. Comment Line FND"
{

    // BC Upgrade MISHRS14 >>
    // HEI.01 CHG2336029 SS40 17.03.2026 # Workflow Approval Functionality for Stock Adjustments
    // # New Table created
    // NAV Table ID - 50307
    // BC Upgrade MISHRS14 <<

    Caption = 'Jour. Comment Line';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name
                WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }

        field(5; Comment; Text[80])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }
}
