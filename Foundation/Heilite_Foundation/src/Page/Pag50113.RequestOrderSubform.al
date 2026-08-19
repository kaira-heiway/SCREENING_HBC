page 50113 "Request Order Subform"
{
    // version HEI.02

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Page created
    // HEI.02 FDD-BA-LOGGAP01 IBM NASTAA02 30.03.2019 # Request Order
    //   # Just Item Nos with Item Category Code = '01' need to be used
    // HEI.03 CHG2070625 IBM.AK 07.10.20
    //  # Made non Editable "From-Code", earlier condition was enableedit

    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Request Order Line FND";
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
                    Editable = EnableEdit;
                    ToolTip = 'Specifies the value of the Item No. field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    var
                        Item: Record Item;
                    begin
                        //HEI.02>>
                        Item.SETFILTER("Item Category Code", '%1|%2', '01', '15');
                        if PAGE.RUNMODAL(31, Item) = ACTION::LookupOK then
                            Rec.VALIDATE("Item No.", Item."No.");
                        //HEI.02<<
                    end;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = EnableEdit;
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.';
                }
                field("Requested Quantity"; Rec."Requested Quantity")
                {
                    Editable = EnableEdit;
                    ToolTip = 'Specifies the value of the Requested Quantity field.';

                    trigger OnValidate();
                    begin
                        Rec."Actual Qty." := Rec."Requested Quantity";
                    end;
                }
                field("Actual Qty."; Rec."Actual Qty.")
                {
                    Editable = EnableEdit;
                    ToolTip = 'Specifies the value of the Actual Qty. field.';
                }
                field("Outstanding Qty."; Rec."Outstanding Qty.")
                {
                    ToolTip = 'Specifies the value of the Outstanding Qty. field.';
                }
                field("From-Code"; Rec."From-Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the From-Code field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin
        if RequestHeader.GET(Rec."Document No.") then
            EnableEdit := RequestHeader.Status <> RequestHeader.Status::Released;
    end;

    var
        RequestHeader: Record "Request Order Header FND";
        EnableEdit: Boolean;
}

