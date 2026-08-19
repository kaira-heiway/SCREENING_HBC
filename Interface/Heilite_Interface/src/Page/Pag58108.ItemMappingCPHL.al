page 58108 "Item Mapping CP - HL"
{
    //     HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 19.10.2018 # Counterpoint Interface
    //   # New Page created to map Items from CP and HL

    //BC Upgrade SHIKHD02 >> 
    // Nav old ID - 50241.
    // # SHIKHD02 New Page created for Table(50113) - "Item Mapping CP" because page is not found in Txt2AL folder.
    //BC Upgrade SHIKHD02 <<

    ApplicationArea = All;
    Caption = 'Item Mapping Counterpoint - Heilite';
    PageType = List;
    SourceTable = "Item Mapping CP FND";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("CP Item ID"; Rec."CP Item ID")
                {

                }
                field("Heilite Item ID"; Rec."Heilite Item ID")
                {

                }
                field("Heilite Item Description"; Rec."Heilite Item Description")
                {

                }
                field("Item Free Item Sales"; Rec."Item Free Item Sales")
                {

                }
                field("Item Product Posting"; Rec."Item Product Posting")
                {

                }
                field("Item Sales Account"; Rec."Item Sales Account")
                {

                }
                field("Item Sales Discount"; Rec."Item Sales Discount")
                {

                }
                field("Excise Tax Item"; Rec."Excise Tax Item")
                {

                }
                field("Top-Up Item"; Rec."Top-Up Item")
                {

                }
                field(Dimension; Rec.Dimension)
                {
                    Editable = DimensionEditable;
                    Enabled = DimensionEditable;
                }
                field("Dimension Value"; Rec."Dimension Value")
                {
                    Editable = DimensionEditable;
                    Enabled = DimensionEditable;
                }

            }
        }
    }
    trigger OnAfterGetRecord()
    var
    begin
        DimensionEditable := Rec."Top-Up Item" OR Rec."Excise Tax Item";
    end;

    var
        DimensionEditable: Boolean;

}
