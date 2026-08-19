page 50116 "Request Order Archive Subform"
{
    // version HEI.01

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Page created

    Caption = 'Lines';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Request Order Line Archive FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Requested Quantity"; Rec."Requested Quantity")
                {
                    ToolTip = 'Specifies the value of the Requested Quantity field.';
                }
                field("Actual Qty."; Rec."Actual Qty.")
                {
                    ToolTip = 'Specifies the value of the Actual Qty. field.';
                }
                field("Outstanding Qty."; Rec."Outstanding Qty.")
                {
                    ToolTip = 'Specifies the value of the Outstanding Qty. field.';
                }
                field("From-Code"; Rec."From-Code")
                {
                    ToolTip = 'Specifies the value of the From-Code field.';
                }
            }
        }
    }

    actions
    {
    }
}

