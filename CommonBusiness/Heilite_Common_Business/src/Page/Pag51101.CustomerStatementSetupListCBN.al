page 51101 "CustomerStatementSetupListCBN"
{
    // version HEI.01

    // HEI.01 CHG2228480-HB3631 COSTES04 02.08.2024 Sierra Leone Automate the separation of deposit and finish product
    //   # New object created

    PageType = ListPart;
    SourceTable = "Customer Statement Setup FND";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03
    caption = 'Customer Statement Setup List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field("Running Date"; Rec."Running Date")
                {
                    ToolTip = 'Specifies the value of the Running Date field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
        }
    }

    actions
    {
    }
}

