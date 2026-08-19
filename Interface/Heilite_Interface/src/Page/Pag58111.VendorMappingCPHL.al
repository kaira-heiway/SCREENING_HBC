page 58111 "Vendor Mapping CP - HL"
{
    //     HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 19.10.2018 # Counterpoint Interface
    //   # New Page created to map Vendors from CP and HL

    // BC Upgrade PATELS08 >>
    // Nav old ID - 50244.
    // #Created new Page for table(50116) - Vendor Mapping CP because page is not found in Txt2AL folder.
    // BC Upgrade PATELS08 <<

    ApplicationArea = All;
    Caption = 'Vendor Mapping Counterpoint - Heilite';
    PageType = List;
    SourceTable = "Vendor Mapping CP FND";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("CP Vendor No."; Rec."CP Vendor No.") { }
                field("Heilite Vendor No."; Rec."Heilite Vendor No.") { }
                field("Heilite Vendor Description"; Rec."Heilite Vendor Description") { }
            }
        }
    }
}
