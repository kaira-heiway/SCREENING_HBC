pageextension 51132 PurchaseOrderArchSubformExtCBN extends "Purchase Order Archive Subform"
{
    //     // version NAVW110.0,HEI.08,HEI.09
    // HEI.01 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //   # New Field added: "TIN No."
    // HEI.02 CHG2024349 IBM.GUNERE01 14.08.2020 # "Machine Reference Number" field added
    // HEI.03 CHG2098629 HB2014 IBM NANDIS01 08.04.2021 - LOG_Automatic creation of Transfer Order for Import PO
    //   # Field shown - "TO Reference"
    // HEI.04 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "CAD Amount"
    // HEI.05 CHG2121745 IBM BHATTA09 24.08.2021
    //   # New Group added and three new fields Total Including VAT, Total Excluding VAT and Total VAT added in the Group
    //   # Code Added for Total Including VAT, Total Excluding VAT and Total VAT
    // HEI.06 CHG2162715 HB3020 NORRIQ KOROLA04 07.11.2022
    //   # SPL Code, SPL Name - fields created
    // HEI.07 CHG2188365 HB3301 IBM NANDIS01 03.02.2023 # Limit PO in PO Archive
    //   # Code modified to show the records in Page correctly
    // HEI.08 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - Zycus Order Line No.
    //                      - Zycus PR Reference No.
    //                      - Zycus PO Type Code
    //                      - Zycus PO Line Type Code
    //                      - Zycus PO Line Validated
    // HEI.09 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Field - Zycus Movement Type
    //**************************************************************************************************************************************
    //BC UPGRADE PATHAA02 10.11.25 Done
    //1. Zycus Interface Fields, Need to put in STP Ext.
    //**************************************************************************************************************************************

    Editable = false;//BC UPGRADE PATHAA02
    layout
    {
        addfirst(Control1)
        {
            field("TO Reference"; Rec."TO Reference FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TO Reference field.';
            }
        }
        addafter(Quantity)
        {
            field("CAD Amount"; Rec."CAD Amount FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CAD Amount field.';
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("TIN No."; Rec."TIN No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the TIN No. field.';
            }
            field("Machine Reference Number"; Rec."Machine Reference Number FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Machine Reference Number field.';
            }
            field("SPL Code"; Rec."SPL Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Code field.';
            }
            field("SPL Name"; Rec."SPL Name FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SPL Name field.';
            }
            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus Order No. field.';
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus Order Line No. field.';
            }
            field("Zycus PR Reference No."; Rec."Zycus PR Reference No. FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus PR Reference No. field.';
            }
            field("Zycus PO Type Code"; Rec."Zycus PO Type Code FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus PO Type Code field.';
            }
            field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus PO Line Type Code field.';
            }
            field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus PO Line Validated field.';
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zycus Movement Type field.';
            }
            field("Total Excl. VAT"; TotalExcludingVAT)
            {
                AutoFormatType = 0;
                Caption = 'Total Excl. VAT';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Excl. VAT field.';
            }
            field("Total Incl. VAT"; TotalVAT)
            {
                Caption = 'Total VAT';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total VAT field.';
            }
            field("Total VAT"; TotalIncludingVAT)
            {
                AutoFormatType = 0;
                CaptionClass = PurchArchiveHeader."Currency Code";
                Caption = 'Total Incl. VAT';
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Incl. VAT field.';
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
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(DeferralSchedule)
        {
            CaptionML = ENU = 'Deferral Schedule', FRA = 'Tableau d''échelonnement';
        }
    }

    var
        Currency: Record Currency;
        PurchArchiveHeader: Record "Purchase Header Archive";
        TotalPurchaseHeader: Record "Purchase Header Archive";
        PurchLineArchive: Record "Purchase Line Archive";
        TotalPurchaseLine: Record "Purchase Line Archive";
        DocumentTotals: Codeunit "Document Totals";
        TotalExcludingVAT: Decimal;
        TotalIncludingVAT: Decimal;
        TotalVAT: Decimal;
        VATAmount: Decimal;
        test: Text[10];


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    if PurchArchiveHeader.GET("Document Type","Document No.") then;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    trigger OnAfterGetRecord();
    begin
        //HEI.05>>
        CLEAR(TotalExcludingVAT);
        CLEAR(TotalIncludingVAT);
        CLEAR(TotalVAT);
        PurchLineArchive.RESET();
        PurchLineArchive.SETRANGE("Document Type", Rec."Document Type");
        PurchLineArchive.SETRANGE("Document No.", Rec."Document No.");
        //IF FINDSET THEN  //HEI.07
        if PurchLineArchive.findset() then  //HEI.07
            repeat
                TotalExcludingVAT := TotalExcludingVAT + PurchLineArchive.Amount;
                TotalIncludingVAT := TotalIncludingVAT + PurchLineArchive."Amount Including VAT";
                TotalVAT := TotalVAT + (TotalIncludingVAT - TotalExcludingVAT);
            until PurchLineArchive.NEXT() = 0;
        //HEI.05<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

