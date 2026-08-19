table 50107 "Gate Comment Line FND"
{
    // version HEI.01

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    // 
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Table 80052 - Gate Comment Line from HEI2.0

    CaptionML = ENU = 'Gate Comment Line',
                FRA = 'Gate Comment Line';
    DrillDownPageID = "Gate Comment Sheet";
    LookupPageID = "Gate Comment Sheet";

    fields
    {
        field(1; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            OptionCaptionML = ENU = 'Inbound,Outbound,Service,Stay',
                              FRA = 'Inbound,Outbound,Service,Stay';
            OptionMembers = Inbound,Outbound,Service,Stay;
        }
        field(2; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        FRA = 'N°';
            TableRelation = "Gate Entry Header FND";
        }
        field(3; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        FRA = 'N° ligne';
        }
        field(4; Date; Date)
        {
            CaptionML = ENU = 'Date',
                        FRA = 'Date';
        }
        field(5; "Code"; Code[10])
        {
            CaptionML = ENU = 'Code',
                        FRA = 'Code';
        }
        field(6; Comment; Text[80])
        {
            CaptionML = ENU = 'Comment',
                        FRA = 'Commentaires';
        }
        field(7; "Document Line No."; Integer)
        {
            CaptionML = ENU = 'Document Line No.',
                        FRA = 'N° ligne document';
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

