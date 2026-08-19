page 50229 "Gate Entry Line Lists"
{
    // version HEI.01

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0

    CaptionML = ENU = 'Gate Entry Line Lists',
                FRA = 'Gate Entry Line Lists';
    Editable = false;
    PageType = Card;
    SourceTable = "Gate Entry Line FND";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Gate Entry Document No."; Rec."Gate Entry Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Gate Entry Document No. field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Unit Of Measure Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Quantity on Arrival"; Rec."Quantity on Arrival")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Quantity on Arrival field.';
                }
                field("Quantity on Departure"; Rec."Quantity on Departure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Quantity on Departure field.';
                }
                field("Posted Quantity Inbound"; Rec."Posted Quantity Inbound")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted Quantity Inbound field.';
                }
                field("Posted Quantity Outbound"; Rec."Posted Quantity Outbound")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Posted Quantity Outbound field.';
                }
            }
        }
    }

    actions
    {
    }
}

