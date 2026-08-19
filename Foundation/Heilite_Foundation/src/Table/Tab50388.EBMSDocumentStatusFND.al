table 50388 "EBMS Document Status FND"
{
    // Heilite Navision Old Id - 50193
    // version HEI.03

    // HEI.01 CHG2151260-HB2788 SOICAD02 08.11.2022 Object created
    // HEI.02 CHG2151260 HB2788 BHANDS01 30.12.2022 # Burundi Fiscal Invoice
    //   # New fields created
    // HEI.03 CHG2151260 HB2788 COSTES02 06.01.2023 # Burundi Fiscal Invoice
    //   # Update optionstring

    // BC Upgrade MISHRS14 >>
    // Changed table name to "EBMS Document Status FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<


    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Invoice,"Credit Memo";
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Invoice Details Outbnd Status"; Option)
        {
            Caption = 'Invoice Details Outbound Status';
            DataClassification = ToBeClassified;
            OptionMembers = "Not Sent",Sent,Processed,Error;
        }
        field(4; "Invoice Details Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Invoice Details Sent to EBMS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Invoice Fields rcvd from EBMS"; Boolean)
        {
            Caption = 'Invoice Response Received from EBMS';
            DataClassification = ToBeClassified;
        }
        field(7; "Invoice Details Inbound Status"; Option)
        {
            Caption = 'Invoice Details Inbound Status';
            DataClassification = CustomerContent;
            Description = 'HEI.02';
            OptionCaption = 'Not Received,Received,Processed,Error';
            OptionMembers = "Not Received",Received,Processed,Error;
        }
        field(8; "Last Updated"; DateTime)
        {
            Caption = 'Last Updated';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

