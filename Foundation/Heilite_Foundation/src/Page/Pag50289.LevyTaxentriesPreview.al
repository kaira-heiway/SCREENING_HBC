page 50289 "Levy Tax entries Preview"
{
    // version HEI.01

    // HEI.01 CHG2224401 HB3624 YADAVM09 09.02.2024 Health and Security Levy Tax
    //   # New Object created

    PageType = List;
    SourceTable = "Levy Tax Entries FND";
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Lists;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Transaction Type"; rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Doc. No."; rec."Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Doc. No. field.';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.';
                }
                field(Type; rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Quantity; rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Direct Unit Cost Exl. VAT"; rec."Direct Unit Cost Exl. VAT")
                {
                    ToolTip = 'Specifies the value of the Direct Unit Cost Exl. VAT field.';
                }
                field("Line Amount Excl. VAT"; rec."Line Amount Excl. VAT")
                {
                    ToolTip = 'Specifies the value of the Line Amount Excl. VAT field.';
                }
                field("H&S Levy Tax %"; rec."H&S Levy Tax %")
                {
                    ToolTip = 'Specifies the value of the H&S Levy Tax % field.';
                }
                field("H&S Levy Tax Amount"; rec."H&S Levy Tax Amount")
                {
                    ToolTip = 'Specifies the value of the H&S Levy Tax Amount field.';
                }
                field("Discount %"; rec."Discount %")
                {
                    ToolTip = 'Specifies the value of the Discount % field.';
                }
                field("Discount Line Amt Excl. VAT"; rec."Discount Line Amt Excl. VAT")
                {
                    ToolTip = 'Specifies the value of the Discount Line Amt Excl. VAT field.';
                }
                field("Total Amount Excl VAT/H&S"; rec."Total Amount Excl VAT/H&S")
                {
                    ToolTip = 'Specifies the value of the Total Amount Excl VAT/H&S field.';
                }
            }
        }
    }

    actions
    {
    }
}

