page 58002 "Interface Log Components"
{
    // Heilite Navision Old Id - 50013
    // version HEI.01

    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New page for Interface Common Framework

    Caption = 'Interface Log Components';
    Editable = false;
    PageType = List;
    SourceTable = "Interface Log Component INT";
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    Visible = UseComponentDetail;
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    Visible = UseComponentDetail;
                    ToolTip = 'Specifies the value of the Table Caption field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Value Code"; Rec."Value Code")
                {
                    ToolTip = 'Specifies the value of the Value Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Approver ID field.';
                }
                field("Approver Name"; Rec."Approver Name")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Approver Name field.';
                }
                field("Type ID"; Rec."Type ID")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Type ID field.';
                }
                field("Price Starting Date"; Rec."Price Starting Date")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Price Starting Date field.';
                }
                field("Price Ending Date"; Rec."Price Ending Date")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Price Ending Date field.';
                }
                field("Price Location Code"; Rec."Price Location Code")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Price Location Code field.';
                }
                field("Price Currency Code"; Rec."Price Currency Code")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Price Currency Code field.';
                }
                field("Price UoM Code"; Rec."Price UoM Code")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Price UoM Code field.';
                }
                field("Price Direct Unit Cost Multip."; Rec."Price Direct Unit Cost Multip.")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Price Direct Unit Cost Multip. field.';
                }
                field("Price Direct Cost Per Multip."; Rec."Price Direct Cost Per Multip.")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Price Direct Cost Per Multip. field.';
                }
                field("Scale Minimum Quantity"; Rec."Scale Minimum Quantity")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Scale Minimum Quantity field.';
                }
                field("Scale Unit of Measure Code"; Rec."Scale Unit of Measure Code")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Scale Unit of Measure Code field.';
                }
                field("Scale Currency Code"; Rec."Scale Currency Code")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Scale Currency Code field.';
                }
                field("Scale Direct Unit Cost"; Rec."Scale Direct Unit Cost")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Scale Direct Unit Cost field.';
                }
                field("Scale Direct Unit Cost Multip."; Rec."Scale Direct Unit Cost Multip.")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Scale Direct Unit Cost Multip. field.';
                }
                field("Scale Direct Cost Per Multip."; Rec."Scale Direct Cost Per Multip.")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Scale Direct Cost Per Multip. field.';
                }
                field("Scale Rate UoM Code"; Rec."Scale Rate UoM Code")
                {
                    Visible = NOT UseComponentDetail;
                    ToolTip = 'Specifies the value of the Scale Rate UoM Code field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Component)
            {
                Caption = 'Component';
                Image = "Action";
                action(Details)
                {
                    Caption = 'Details';
                    Image = AllLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Interface Log Comp. Details";
                    RunPageLink = "Header Entry No." = FIELD("Header Entry No."),
                                  "Line Entry No." = FIELD("Line Entry No."),
                                  "Table ID" = FIELD("Table ID"),
                                  Code = FIELD(Code);
                    ToolTip = 'Executes the Details action.';
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        UseComponentDetail := SetUseComponentDetail();
    end;

    var
        UseComponentDetail: Boolean;

    local procedure SetUseComponentDetail(): Boolean;
    var
        InterfaceLogHeader: Record "Interface Log Header INT";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        InterfaceLogHeader.GET(Rec."Header Entry No.");
        InterfaceSetup.GET(InterfaceLogHeader."Interface Code");
        exit(InterfaceSetup."Use Component Detail");
    end;
}

