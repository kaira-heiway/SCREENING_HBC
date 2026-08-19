pageextension 51003 CostEntriesExtCBN extends "Cost Entries"
{
    // version NAVW17.00
    // HEI.01 CHG2068359 BULIMC01 IBM 08.10.2020 #new field displayed - "Shipping Cost"

    layout
    {
        addafter("Cost Object Code")
        {
            field(Brand; Rec."Brand FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Brand field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Brand field.';

            }
            field(Line; Rec."Line FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Line field.';

            }
            field("Dimension 1 Code"; Rec."Dimension 1 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 1 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 1 Code field.';

            }
            field("Dimension 2 Code"; Rec."Dimension 2 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 2 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 2 Code field.';

            }
            field("Dimension 3 Code"; Rec."Dimension 3 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 3 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 3 Code field.';

            }
            field("Dimension 4 Code"; Rec."Dimension 4 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 4 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 4 Code field.';

            }
            field("Dimension 5 Code"; Rec."Dimension 5 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 5 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 5 Code field.';

            }
            field("Dimension 6 Code"; Rec."Dimension 6 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 6 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 6 Code field.';

            }
            field("Dimension 7 Code"; Rec."Dimension 7 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 7 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 7 Code field.';

            }
            field("Dimension 8 Code"; Rec."Dimension 8 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 8 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 8 Code field.';

            }
            field("Dimension 9 Code"; Rec."Dimension 9 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 9 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 9 Code field.';

            }
            field("Dimension 10 Code"; Rec."Dimension 10 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 10 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 10 Code field.';

            }
            field("Dimension 11 Code"; Rec."Dimension 11 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 11 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 11 Code field.';

            }
            field("Dimension 12 Code"; Rec."Dimension 12 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 12 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 12 Code field.';

            }
            field("Dimension 13 Code"; Rec."Dimension 13 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 13 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 13 Code field.';

            }
            field("Dimension 14 Code"; Rec."Dimension 14 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 14 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 14 Code field.';

            }
            field("Dimension 15 Code"; Rec."Dimension 15 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 15 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 15 Code field.';

            }
            field("Dimension 16 Code"; Rec."Dimension 16 Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dimension 16 Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Dimension 16 Code field.';

            }
        }
        addafter(Allocated)
        {
            field("Shipping Cost FND"; Rec."Shipping Cost FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shipping Cost field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Shipping Cost field.';

            }
        }
    }
    actions
    {
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
        }
    }

    //Unsupported feature: PropertyChange on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

