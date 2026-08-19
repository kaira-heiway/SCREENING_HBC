page 58014 "EBMS Document Types"
{
    // Heilite Navision Old Id - 50217

    // version HEI.01

    // HEI.01 CHG2151260-HB2788 COSTES04 21.12.2022 Page created
    
    // BC Upgrade PATELP08>>
    // Changed name of table from "EBMS Document Type" to "EBMS Document Type FND"
    // BC Upgrade PATELP08<<

    Caption = 'EBMS Document Types';
    PageType = List;
    SourceTable = "EBMS Document Type FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Document Subtype Code"; Rec."Document Subtype Code")
                {
                    ToolTip = 'Specifies the value of the Document Subtype Code field.';
                }
                field("Customer Tax Group Code"; Rec."Customer Tax Group Code")
                {
                    ToolTip = 'Specifies the value of the Customer Tax Group Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

