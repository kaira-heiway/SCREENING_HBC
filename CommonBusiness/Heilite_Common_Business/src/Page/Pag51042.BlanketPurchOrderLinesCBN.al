page 51042 "Blanket Purch Order Lines CBN"
{
    // version HEI.02

    // HEI.01 PURGAP11 IBM LAZARE02 04.09.2017 # New page for SRM integration
    // HEI.02 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name - fields created

    CaptionML = ENU = 'Blanket Purchase Order Lines',
                FRA = 'Lignes commande ouverte achat';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = sorting("Document Type", "Document No.", "Line No.")
                      where("Document Type" = CONST("Blanket Order"));

    ApplicationArea = ALL; //BC Upgrade Priya <<
    UsageCategory = Lists; //BC Upgrade Priya <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the document number.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the line type.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the code for the location where the items on the line will be located.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the item or service on the line.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the name of the unit of measure for the item, such as 1 bottle or 1 piece.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the number of units of the item that will be specified on the line.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the dimension value code linked to the purchase.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the dimension value code linked to the purchase.';
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Editable = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[3] field.';
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Editable = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[4] field.';
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Editable = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = true;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[5] field.';
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Editable = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[6] field.';
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Editable = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[7] field.';
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Editable = false;
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = false;
                    ToolTip = 'Specifies the value of the ShortcutDimCode[8] field.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract Type field.';
                }
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Line No."; Rec."SRM Contract Line No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract Line No. field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field("Block Line Ordering"; Rec."Block Line Ordering FND")
                {
                    ToolTip = 'Specifies the value of the Block Line Ordering field.';
                }
                field("Delivery Finalized"; Rec."Delivery Finalized FND")
                {
                    ToolTip = 'Specifies the value of the Delivery Finalized field.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ToolTip = 'Specifies the value of the Item Category Code field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the code of the currency of the amounts on the purchase line.';
                }
                field("SPL Code"; Rec."SPL Code FND")
                {
                    ToolTip = 'Specifies the value of the SPL Code field.';
                }
                field("SPL Name"; Rec."SPL Name FND")
                {
                    ToolTip = 'Specifies the value of the SPL Name field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
}

