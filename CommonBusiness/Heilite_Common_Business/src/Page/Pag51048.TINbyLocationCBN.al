page 51048 "TIN by Location CBN"
{
    // version HEI.02

    // HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Page created
    // HEI.02 BA-RTRGAP01 IBM NASTAA02 08.10.2018 # Bahamas VAT
    //   # Page should be updated after validate "VAT Prod. Posting Group by Location"

    Caption = 'TIN by Location';
    PageType = List;
    SourceTable = "TIN by Location FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                }
                field("VAT Prod. Posting Group by Loc"; Rec."VAT Prod. Posting Group by Loc")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group by Location field.';

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE(); //HEI.02
                    end;
                }
                field("TIN No."; Rec."TIN No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the TIN No. field.';
                }
            }
        }
    }

    actions
    {
    }
}

