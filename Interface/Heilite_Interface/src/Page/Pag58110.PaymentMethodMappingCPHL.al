page 58110 "Payment Method Mapping CP - HL"
{
    //     HEI.01 FDD-BA-SLSGAP01 IBM NASTAA02 19.10.2018 # Counterpoint Interface
    //   # New Page created to map Payment Methods from CP and HL

    // BC Upgrade PATELP08 >>
    // #Created new Page for table(50115) - Payment Method Mapping CP because page is not found in Txt2AL folder.
    // Nav old ID - 50243.
    // BC Upgrade PATELP08 <<

    ApplicationArea = All;
    Caption = 'Payment Method Mapping Counterpoint - Heilite';
    PageType = List;
    SourceTable = "Payment Method Mapping CP FND";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("CP Payment Type"; Rec."CP Payment Type")
                {

                }
                field("Location Code Heilite"; Rec."Location Code Heilite")
                {

                }
                field("Payment GL Account"; Rec."Payment GL Account")
                {

                }
                field("CP Payment Description"; Rec."CP Payment Description")
                {

                }
                field("Excise tax Payment Type"; Rec."Excise tax Payment Type")
                {

                }
            }
        }
    }
}
