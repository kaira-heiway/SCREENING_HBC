page 58146 "Cadency Data_GLTRAN"
{
    // version HEI.01

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 21.02.2019
    //   # Created new Page

    // BC Upgrade POENAB02: Original (HeiLite) page id 50307
    
    // BC Upgrade MISHRS14 >>
    // Changed table name to "Cadency Data FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Editable = false;
    PageType = List;
    SourceTable = "Cadency Data FND";
    SourceTableView = where("File Type" = filter(GLTRAN));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    ToolTip = 'Entry No. is the unique identifier for each record and cannot be modified.';
                }
                field("File Type"; Rec."File Type")
                {
                    Editable = false;
                    ToolTip = 'File Type indicates the type of data and cannot be modified.';
                }
                field("Header Info"; Rec."Header Info")
                {
                    Editable = false;
                    ToolTip = 'Header Info provides additional context for the record and cannot be modified.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    Editable = false;
                    ToolTip = 'Company Name indicates the name of the company associated with the record and cannot be modified.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Editable = false;
                    ToolTip = 'G/L Account No. is the general ledger account number and cannot be modified.';
                }
                field(EffectiveDate; Rec.EffectiveDate)
                {
                    Editable = false;
                    ToolTip = 'Effective Date is the date when the record becomes effective and cannot be modified.';
                }
                field(Date1; Rec.Date1)
                {
                    Editable = false;
                    ToolTip = 'Date1 is an additional date field for the record and cannot be modified.';
                }
                field(CCY2Code; Rec.CCY2Code)
                {
                    Editable = false;
                    ToolTip = 'CCY2 Code is the currency code for the second currency and cannot be modified.';
                }
                field(CCY2Amount; Rec.CCY2Amount)
                {
                    Editable = false;
                    ToolTip = 'CCY2 Amount is the amount in the second currency and cannot be modified.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ToolTip = 'Document No. is the number of the document associated with the record and cannot be modified.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Description provides a brief description of the record and cannot be modified.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ToolTip = 'Document Type indicates the type of document and cannot be modified.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ToolTip = 'External Document No. is the number of the external document associated with the record and cannot be modified.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    ToolTip = 'Customer No. is the number of the customer associated with the record and cannot be modified.';
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ToolTip = 'User ID is the identifier of the user who created or modified the record and cannot be modified.';
                }
                field("Total Count"; Rec."Total Count")
                {
                    Editable = false;
                    ToolTip = 'Total Count is the total number of records and cannot be modified.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    Editable = false;
                    ToolTip = 'Total Amount is the total amount for the record and cannot be modified.';
                }
            }
        }
    }

    actions
    {
    }
}

