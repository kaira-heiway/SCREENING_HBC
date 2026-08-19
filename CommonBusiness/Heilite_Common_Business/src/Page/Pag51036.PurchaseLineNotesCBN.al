page 51036 "Purchase Line Notes CBN"
{
    // version HEI.01

    // HEI.01 HLSRM02 IBM LAZARE02 30.08.2017 # New page for showing notes on purchase line

    Caption = 'Purchase Line Notes';
    Editable = false;
    PageType = Card;
    SourceTable = "Purchase Line";
    ApplicationArea = ALL; //BC Upgrade Priya <<
    UsageCategory = Documents; //BC Upgrade Priya <<


    layout
    {
        area(content)
        {
            group(General)
            {
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Line No."; Rec."SRM Contract Line No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract Line No. field.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract Type field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field("CMG Code"; Rec."CMG Code FND")
                {
                    ToolTip = 'Specifies the value of the CMG Code field.';
                }
                field("Block Line Ordering"; Rec."Block Line Ordering FND")
                {
                    ToolTip = 'Specifies the value of the Block Line Ordering field.';
                }
                field("Delivery Finalized"; Rec."Delivery Finalized FND")
                {
                    ToolTip = 'Specifies the value of the Delivery Finalized field.';
                }
                field("Tolerance Received Over %"; Rec."Tolerance Received Over % FND")
                {
                    ToolTip = 'Specifies the value of the Tolerance Received Over % field.';
                }
                field("Tolerance Received Under %"; Rec."Tolerance Received Under % FND")
                {
                    ToolTip = 'Specifies the value of the Tolerance Received Under % field.';
                }
                field("Consumption Location Code"; Rec."Consumption Location Code FND")
                {
                    ToolTip = 'Specifies the value of the Consumption Location Code field.';
                }
                field("Initial Quantity"; Rec."Initial Quantity FND")
                {
                    ToolTip = 'Specifies the value of the Initial Quantity field.';
                }
                field(Cancelled; Rec."Cancelled FND")
                {
                    ToolTip = 'Specifies the value of the Cancelled field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("SRM Order Line No."; Rec."SRM Order Line No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order Line No. field.';
                }
                field("Last Changed Date/Time"; Rec."Last Changed Date/Time FND")
                {
                    ToolTip = 'Specifies the value of the Last Changed Date/Time field.';
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
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the direct cost of one item unit.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control50076; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

