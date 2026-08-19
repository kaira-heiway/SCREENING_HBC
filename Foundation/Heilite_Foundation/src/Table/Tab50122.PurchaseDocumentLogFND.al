table 50122 "Purchase Document Log FND"
{
    // version HEI.01

    // HEI.01 FDD-PURGAP030 - Send updated PO to supplier with specified  changes_V1.1, IBM.NAIKH01 , 21.01.2019
    //   # Created New table

    // BC Upgrade MISHRS14 >>
    // Changed data type from option to enum all values are matching for field-1 "Document Type".
    // BC Upgrade MISHRS14 <<


    fields
    {
        // field(1; "Document Type"; Option)
        // {
        //     OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
        //     OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        // }

        // BC Upgrade MISHRS14 >>
        // Changed data type from option to enum all values are matching.
        field(1; "Document Type"; Enum "Purchase Document Type")
        {
            // OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            // OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        // BC Upgrade MISHRS14 <<

        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Entry No."; Integer)
        {
        }
        field(5; "User ID"; Text[50])
        {
        }
        field(6; "Creation Datetime"; DateTime)
        {
        }
        field(7; "Field No."; Integer)
        {
        }
        field(8; "Old Value"; Text[50])
        {
        }
        field(9; "New Value"; Text[50])
        {
        }
        field(10; Comment; Text[250])
        {
        }
        field(11; Printed; Boolean)
        {
        }
        field(12; "No."; Code[20])
        {
        }
        field(13; Description; Text[50])
        {
        }
        field(14; Quantity; Decimal)
        {
        }
        field(15; "Unit of Measure"; Text[10])
        {
        }
        field(16; "Direct Unit Cost"; Decimal)
        {
        }
        field(17; "Line Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.", "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

