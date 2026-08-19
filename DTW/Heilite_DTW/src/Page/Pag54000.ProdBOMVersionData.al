page 54000 "Prod BOM Version Data"
{
    // version HEI.03

    // HEI.01 HB2817 - CHG2150741 IBM GOKULS01 15.06.2022 # Production Version page
    // # Added new page for showing the data for Production version data
    // HEI.02 HB2817 - CHG2150741 NORRIQ KOROLA04 04.10.2022
    //   #rename page and some fields
    // HEI.03 HB2817 - CHG2150741 NORRIQ KOROLA04 18.10.2022
    //   #Location Code - field added
    //BC Upgrade Kamnay01 Original(Heilite) page id 50511

    Caption = 'Production Version Data';
    PageType = List;
    SourceTable = "Production Version Data FND";
    ApplicationArea = ALL;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Material Code"; Rec."Material Code")
                {
                }
                field("Location Code"; Rec."Location Code") // << HEI.03
                {
                }
                field("Production Version"; Rec."Production Version")
                {
                }
                field("Routing Header Code"; Rec."Routing Header Code")
                {
                }
                field("Routing Ver. hdr. Code"; Rec."Routing Ver. hdr. Code")
                {
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                }
                field("BOM Header Code"; Rec."BOM Header Code")
                {
                }
                field("BOM Ver. Hdr. Code"; Rec."BOM Ver. Hdr. Code")
                {
                }
                field("Start Validity Date"; Rec."Start Validity Date")
                {
                    Caption = 'Start Week No.'; // << HEI.02
                }
                field("End Validity Date"; Rec."End Validity Date")
                {
                    Caption = 'End Week No.'; // << HEI.02
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(RunDataCreate)
            {
                Caption = 'Create Production Version Data';
                Image = CreateSKU;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Prod. BOM Version Update";
            }
        }
    }
}

