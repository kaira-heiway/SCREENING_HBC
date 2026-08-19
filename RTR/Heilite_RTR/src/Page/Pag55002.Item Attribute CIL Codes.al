page 55002 "Item Attribute CIL Codes"
{
    // version HEI.01

    // HEI.01 FDD-PRDGAP043 IBM LAZARE02 03.11.2017 # New page for mapping item attributes to CIL Code

    // BC Upgrade Kamnay01 Original(Heilite) page id 50164

    Caption = 'Item Attribute CIL Codes';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Item Attribute CIL Code RTR";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Attribute ID"; Rec."Attribute ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Attribute ID field.';
                }
                field("Attribute Name"; Rec."Attribute Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Attribute Name field.';
                }
                field("Attribute Value ID"; Rec."Attribute Value ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Attribute Value ID field.';
                }
                field("Attribute Value"; Rec."Attribute Value")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Attribute Value field.';
                }
                field("CIL ID Code"; Rec."CIL ID Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the CIL ID Code field.';
                }
                field("CIL ID2 Code"; Rec."CIL ID2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the CIL ID2 Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

