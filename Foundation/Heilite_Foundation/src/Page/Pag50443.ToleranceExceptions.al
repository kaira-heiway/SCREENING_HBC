page 50443 "Tolerance Exceptions"
{
    // version HEI.01

    // HEI.01 FDD-HB1886 IBM NASTAA02 30.03.2021 # Specific Invoice Tolerances
    //   # New Table created for Specific Invoice Tolerances

    Caption = 'Tolerance Exceptions';
    PageType = List;
    SourceTable = "Tolerance Exceptions FND";  // BC Upgrade NANDIS03
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.';
                }
                field("Upper % Tolerance"; Rec."Upper % Tolerance")
                {
                    ToolTip = 'Specifies the value of the Upper % Tolerance field.';
                }
                field("Upper Amount Tolerance"; Rec."Upper Amount Tolerance")
                {
                    ToolTip = 'Specifies the value of the Upper Amount Tolerance field.';
                }
                field("Lower % Tolerance"; Rec."Lower % Tolerance")
                {
                    ToolTip = 'Specifies the value of the Lower % Tolerance field.';
                }
                field("Lower Amount Tolerance"; Rec."Lower Amount Tolerance")
                {
                    ToolTip = 'Specifies the value of the Lower Amount Tolerance field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec.Type := Rec.Type::Item;
    end;
}

