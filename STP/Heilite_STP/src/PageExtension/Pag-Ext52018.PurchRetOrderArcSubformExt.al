pageextension 52018 PurchRetOrderArcSubformExt extends "Purch Return Order Arc Subform"
{
    // version NAVW110.0,HEI.03,HEI.04
    //BC UPGRADE SIVA Old Page ID 6645
    // HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //     # New Field added - "TIN No."
    //   HEI.02 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //     # New Field added: "CAD Amount"
    //   HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - Zycus Order Line No.
    //                        - Zycus PR Reference No.
    //                        - Zycus PO Type Code
    //                        - Zycus PO Line Type Code
    //                        - Zycus PO Line Validated
    //   HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Field - Zycus Movement Type
    //*******************************************//
    //BC UPGRADE SIVA 20/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01  No changes.
    //3.HEI.03 No Changes.
    //4.HEI.04 No changes
    layout
    {
        addafter(Quantity)
        {
            //BC UPGRADE SIVA>> CAD
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ToolTip = 'CAD Amount';
                ApplicationArea = all;
            }
            //BC UPGRADE SIVA<<


        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("TIN No."; Rec."TIN No. FND")
            {
                ToolTip = 'TIN No.';
                ApplicationArea = all;
            }
            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                ToolTip = 'Zycus Order No.';
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                ToolTip = 'Zycus Order Line No.';
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus PR Reference No."; Rec."Zycus PR Reference No. FND")
            {
                ToolTip = 'Zycus PR Reference No.';
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus PO Type Code"; Rec."Zycus PO Type Code FND")
            {
                ToolTip = 'Zycus PO Type Code';
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code FND")
            {
                ToolTip = 'Zycus PO Line Type Code';
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated FND")
            {
                ToolTip = 'Zycus PO Line Validated';
                Visible = false;
                ApplicationArea = all;
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                ToolTip = 'Zycus Movement Type';
                Visible = false;
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Comments)
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

