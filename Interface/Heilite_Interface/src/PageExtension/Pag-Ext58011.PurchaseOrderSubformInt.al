pageextension 58011 PurchaseOrderSubformInt extends "Purchase Order Subform"
{
    // HEI.01 HLSRM02 IBM LAZARE02 07.08.2017
    //   #New fields for SRM integration: Cancelled, SRM Order No., SRM Order Line No.
    //     HEI.20 CHG2210794 SAHAL01 19.03.2024 Zycus - BASE HL Integration Master Dimension
    //   # Added New Fields - Zycus Order No.
    //                      - Zycus Order Line No.
    // HEI.22 CHG2210794 SAHAL01 19.04.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus PR Reference No.
    //                      - Zycus PO Type Code
    //                      - Zycus PO Line Type Code
    //                      - Zycus PO Line Validated
    //     HEI.26 CHG2210794 SAHAL01 10.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Field - Zycus Movement Type
    //BC Upgrade SHARMP16 -- Interface related fields and code shifted from main Ext
    // HEI.24 CHG2240166 HB3563 IBM SRIVAS07 23.04.2024 # Development CD_StP_Concat Code Missing in Purchase Lines
    //   # New variable - ConcatCode - Text[20]
    //   # New Function - SetConcatCode()
    //   # Added code in OnAfterGetRecord trigger()
    //     HEI.16 FDD-HB2060 CHG2103752 IBM NANDIS01 02-03-2022 - Final delivery and PO closure HL  Global Maximo
    //   # Field "Delivery finalized" is uneditable if PO is having Maximo Requisition No.
    //HEI.09 FDD_Ethiopia_Tolerance field for SPOT PO  Overdelivery_V0.1_HT630 IBM HORTOC01 28.06.2019 # new field added "Tolerance Received Over %"
    //     HEI.15 CHG2132608 IBM BHATTA09 06.01.2022
    //   # Code added for Tolerance Received Over % field editability

    layout
    {
        modify("Delivery Finalized")
        {
            Editable = DeliveryFinalizedEditable;
        }//BC Upgrade Sharmp16 Purchprocesschanges
        addafter("TO Reference")
        {
            field(Cancelled; Rec."Cancelled FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Cancelled field.';
            }
        }
        addafter("Tolerance Received Over %")
        {
            field("SRM Contract No."; Rec."SRM Contract No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Contract No. field.';
            }
            field("SRM Contract Line No."; Rec."SRM Contract Line No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Contract Line No. field.';
            }
            field("SRM Order No."; Rec."SRM Order No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SRM Order No. field.';
            }
            field("SRM Order Line No."; Rec."SRM Order Line No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the SRM Order Line No. field.';
            }
        }
        addafter("WHT Product Posting Group")
        {
            field("Maximo Requisition No."; Rec."Maximo Requisition No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maximo Requisition No. field.';
            }
            field("Maximo Requisition Line No."; Rec."Maximo Requis. Line No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maximo Requisition Line No. field.';
            }


            field("Zycus Order No."; Rec."Zycus Order No. FND")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Zycus Order No. field.';
            }
            field("Zycus Order Line No."; Rec."Zycus Order Line No. FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus Order Line No. field.';
            }
            field("Zycus PR Reference No."; Rec."Zycus PR Reference No. FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus PR Reference No. field.';
            }
            field("Zycus PO Type Code"; Rec."Zycus PO Type Code FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus PO Type Code field.';
            }
            field("Zycus PO Line Type Code"; Rec."Zycus PO Line Type Code FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus PO Line Type Code field.';
            }
            field("Zycus PO Line Validated"; Rec."Zycus PO Line Validated FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus PO Line Validated field.';
            }
            field("Zycus Movement Type"; Rec."Zycus Movement Type FND")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the Zycus Movement Type field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    local procedure SetConcatCode();
    var
        DimensionSetEntry: Record "Dimension Set Entry";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
    begin
        //HEI.24>>
        if rec."Dimension Set ID" <> 0 then begin
            GeneralInterfaceSetup.GET();

            DimensionSetEntry.RESET();
            DimensionSetEntry.SETRANGE("Dimension Set ID", rec."Dimension Set ID");
            DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Project Dimension Code");
            if DimensionSetEntry.FINDFIRST() then
                ConcatCode := DimensionSetEntry."Dimension Value Code"
            else
                ConcatCode := '';
        end else
            ConcatCode := '';
        //HEI.24<<
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        // //HEI.16>>
        lPurchHeader.RESET();
        IF lPurchHeader.GET(rec."Document Type", rec."Document No.") THEN BEGIN
            IF lPurchHeader."Maximo Requisition No. FND" <> '' THEN
                DeliveryFinalizedEditable := FALSE;
        END;
        // //HEI.16<<
    end;
    //BC Upgrade SHARMP16 --PurchProcesschanges BEGIN>> 
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        DeliveryFinalizedEditable := true;
    end;
    //BC Upgrade SHARMP16 --PurchProcesschanges END<<
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //HEI.09>>
        IF (rec.Type = rec.Type::Item) AND (rec."Blanket Order No." = '') THEN
            ToleranceReceivedOverEditable := TRUE
        //HEI.15>>
        ELSE
            ToleranceReceivedOverEditable := FALSE;
        //HEI.15<<
        //HEI.09<<
        SetConcatCode(); //HEI.24

    end;

    var
        lPurchHeader: Record "Purchase Header";
        DeliveryFinalizedEditable: Boolean;
        ConcatCode: Text[20];
        ToleranceReceivedOverEditable: Boolean;
}