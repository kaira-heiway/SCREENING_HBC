page 50231 "Gate Entry Statistics"
{
    // version HEI.01

    // HEI:EDD151:1:1 17/08/11 NJ
    //   # Added new field 80000 'Location Code' [Code 20]
    // 
    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0

    PageType = Card;
    SourceTable = "Gate Statistics Buffer FND";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Unit Of Measure Code field.';
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
                field("Net Change 1"; Rec."Net Change 1")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Net Change 1 field.';
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
                field("Net Change 2"; Rec."Net Change 2")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Net Change 2 field.';
                }
                field(Deviation; Rec.Deviation)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Deviation field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        DeviationOnFormat();
    end;

    var
        WhseSetup: Record "Warehouse Setup";

    local procedure DeviationOnFormat();
    begin
        WhseSetup.GET();
        if ABS(rec.Deviation) > WhseSetup."Gate Entry Weight Tole % FND" then;
    end;
}

