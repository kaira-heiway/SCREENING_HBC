
page 58109 "Location Mapping CP - HL"
{
    //     HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 19.10.2018 # Counterpoint Interface
    //   # New Page created to map Stores from CP and Locations from HL

    //BC Upgrade MISHRS14 >>
    //   #Created new Page for table(50114)- Location Mapping CP because page is not found in Txt2AL folder.
    // Nav old ID - 50242.
    //BC Upgrade MISHRS14 <<

    ApplicationArea = All;
    Caption = 'Location Mapping Counterpoint - Heilite';
    PageType = List;
    SourceTable = "Location Mapping CP FND";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("CP Store Code"; Rec."CP Store Code")
                {
                    ToolTip = 'Specifies the value of the CP Store Code field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code (Heilite) field.', Comment = '%';
                }
                field("Location Code Name"; Rec."Location Code Name")
                {
                    ToolTip = 'Specifies the value of the Location Code Name field.', Comment = '%';
                }
                field("Accounts Receivables"; Rec."Accounts Receivables")
                {
                    ToolTip = 'Specifies the value of the Accounts Receivables field.', Comment = '%';
                }
                field("Payouts Bank Account"; Rec."Payouts Bank Account")
                {
                    ToolTip = 'Specifies the value of the Payouts Bank Account field.', Comment = '%';
                }
                field("CCC Dimension"; Rec."CCC Dimension")
                {
                    ToolTip = 'Specifies the value of the CCC Dimension field.', Comment = '%';
                }
                field("CCC Dimension Value"; Rec."CCC Dimension Value")
                {
                    ToolTip = 'Specifies the value of the CCC Dimension Value field.', Comment = '%';
                    trigger OnValidate()
                    var
                    begin
                        IF Rec."CCC Dimension Value" <> '' THEN
                            CLEAR(Rec."CCC Dimension Value");
                    end;
                }
            }
        }
    }
}
