page 58099 DimValue_HEIFLOW
{
    // version HEI.01

    // HEI.01 CHG2132929 IBM POENAB02 18.03.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50276

    Editable = false;
    PageType = List;
    SourceTable = "Dimension Value";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension code to which the dimension value belongs.';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the dimension value.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the dimension value.';
                }
                field("Dimension Value Type"; Rec."Dimension Value Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the dimension value.';
                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the dimension value is used for totaling.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the dimension value is blocked.';
                }
                field("Consolidation Code"; Rec."Consolidation Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the consolidation code for the dimension value.';
                }
                field(Indentation; Rec.Indentation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the indentation level of the dimension value in hierarchies.';
                }
                field("Global Dimension No."; Rec."Global Dimension No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the global dimension number associated with the dimension value.';
                }
                field("Map-to IC Dimension Code"; Rec."Map-to IC Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the intercompany dimension code to which this dimension value is mapped.';
                }
                field("Map-to IC Dimension Value Code"; Rec."Map-to IC Dimension Value Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the intercompany dimension value code to which this dimension value is mapped.';
                }
                field("Dimension Value ID"; Rec."Dimension Value ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the dimension value.';
                }
                field("Business Type Dim Value Code"; Rec."Business TypeDimValue Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the business type dimension value code associated with this dimension value.';
                }
                field("CIL Code"; Rec."CIL Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CIL code for the dimension value.';
                }
                field("Approver ID"; Rec."Approver ID FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the identifier of the approver for the dimension value.';
                }
                field("Business Type Dimension Code"; Rec."Business Type Dime. Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the business type dimension code associated with this dimension value.';
                }
                field("Approver Name"; Rec."Approver Name FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the approver for the dimension value.';
                }
                field("Reporting Entity"; Rec."Reporting Entity FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reporting entity associated with the dimension value.';
                }
                field("Linked Dimension Code"; Rec."Linked Dimension Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the linked dimension code associated with this dimension value.';
                }
                field("Linked Dimension Value Code"; Rec."Linked Dime. Value Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the linked dimension value code associated with this dimension value.';
                }
                field("Min. Order Value Limit"; Rec."Min. Order Value Limit FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the minimum order value limit for the dimension value.';
                }
                field("Min. Order Value Limit Type"; Rec."Min. Order Value Limit FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the minimum order value limit for the dimension value.';
                }
                field("Bank who issued the License"; Rec."Bank issued the License FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bank that issued the license.';
                }
                field("License Expiration Date"; Rec."License Expiration Date FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the expiration date of the license.';
                }
            }
        }
    }

    actions
    {
    }
}

