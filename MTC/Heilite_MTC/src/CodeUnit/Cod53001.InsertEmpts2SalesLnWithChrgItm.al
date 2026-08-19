namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Tracking;
using Microsoft.Warehouse.Request;
using Microsoft.Finance.Currency;
using Microsoft.Warehouse.Structure;
using Microsoft.Sales.Document;

codeunit 53001 InsertEmpts2SalesLnWithChrgItm
{

    // HEI.01 FDD HNK GAPLOG002 IBM ISYED01 20/06/2012
    //   # Added new field Include Empty Good Item No. to the table.

    // BC Upgrade SHUKLP03 >>
    // Nav old id - 50011
    // Procedure IsTrackingApppliedSales() is not added because dependency on DIT record "SSCC Reservation Entry".
    // Procedure InsertEmptPalletstoSalesLine() is not added because dependency on DIT record Sales Deposit Item Charge.
    // procedure DeleteEmptySalesLinesAttchedToChrgItms() some part of code is blocked because dependency on DIT field "Item Charge Calculate per", "Is Item Charge", "Manual Item Charge".
    // procedure DeleteAllEmptesAttachedChargeSalesLines() some part of code is blocked because dependency on DIT codeunit "Common Item Charges Mgt."
    // procedure GetSalesHeader() some part of code is blocked because dependency on DIT's procedure SetRoundingPrecisionDrink() of table Currency.
    // procedure CalcSalesLine() is not added because dependency on DIT fields "Is Item Charge","Free Item","Free Calculation Type","Free Item Posting Type" etc.
    // BC Upgrade SHUKLP03 <<

    var
        NextLineNo: Integer;
        Location: Record Location;
        BinContent: Record "Bin Content";
        Bin: Record Bin;
        Currency: Record Currency;
        ItemChrg: Record "Item Charge";
        //CommonItemchrgMgt: Codeunit "Common Item Charges Mgt.";	// BC Upgrade SHUKLP03 << Blocked DIT object.
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SaveTempSalesChargeLine: Record "Sales Line";
        SaveCurrency: Record Currency;

    LOCAL procedure GetLocation(LocationCode: Code[10])
    begin
        //HEI.01>>
        IF LocationCode = '' THEN
            CLEAR(Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
        //HEI.01<<
    end;

    procedure QuantityRounding(RoundFactor: Option Nearest,Up,Down) RoundingSignText: Text[1]
    begin
        //HEI.01>>
        CASE RoundFactor OF
            RoundFactor::Nearest:
                RoundingSignText := '=';
            RoundFactor::Up:
                RoundingSignText := '>';
            RoundFactor::Down:
                RoundingSignText := '<';
        END;
        EXIT(RoundingSignText);
        //HEI.01<<
    end;

    procedure CopyTempEmpSalesToSalesLine(VAR FromSalesLine: Record "Sales Line"; VAR ToSalesLine: Record "Sales Line")
    begin
        //HEI.01>>
        IF FromSalesLine.ISEMPTY THEN
            EXIT;

        IF FromSalesLine.FINDSET THEN
            REPEAT
                IF (FromSalesLine."No." <> '') OR
                    (FromSalesLine.Type = ToSalesLine.Type::" ")
                THEN BEGIN
                    ToSalesLine.COPY(FromSalesLine);
                    IF ToSalesLine.INSERT THEN;
                END;
            UNTIL FromSalesLine.NEXT = 0;
        //HEI.01<<
    end;

    LOCAL procedure CheckSalesLineExist(SalesLine: Record "Sales Line") SalesLineExists: Boolean
    var
        SalesLineLocal: Record "Sales Line";
    begin
        //HEI.01>>
        SalesLineExists := FALSE;
        SalesLineLocal.RESET;
        SalesLineLocal.SETRANGE("Document No.", SalesLine."Document No.");
        SalesLineLocal.SETRANGE("Document Type", SalesLine."Document Type");
        SalesLineLocal.SETRANGE("Line No.", SalesLine."Line No.");
        IF SalesLineLocal.FINDSET THEN BEGIN
            REPEAT
                SalesLineExists := TRUE;
            UNTIL SalesLineLocal.NEXT = 0;
        END;
        //HEI.01<<
    end;

    procedure DeleteEmptySalesLinesAttchedToChrgItms(VAR FromSalesLine: Record "Sales Line"; VAR TempSalesLine: Record "Sales Line"; TriggerDelete: Boolean; CalledByObject: Option Item,Order,Period,DelayOrder,ListItem,ListOrder): Boolean
    var
        SourceSalesLine: Record "Sales Line";
        FromSalesLine2: Record "Sales Line";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        ExistWhseDocLine: Boolean;
        ExistApplLotSerialSSCC: Boolean;
    begin
        //HEI.01>>
        SourceSalesLine := FromSalesLine;
        FromSalesLine2 := FromSalesLine;

        //WITH FromSalesLine2 DO BEGIN
        FromSalesLine2.COPYFILTERS(TempSalesLine);
        FromSalesLine2.SETRANGE("Document Type", FromSalesLine2."Document Type");
        FromSalesLine2.SETRANGE("Document No.", FromSalesLine2."Document No.");
        //FromSalesLine2.SETRANGE("Is Item Charge", FALSE);       // BC Upgrade SHUKLP03 << Blocked DIT field "Is Item Charge".
        // Discount Promotion only
        //FromSalesLine2.SETRANGE("Item Charge Calculate per", CalledByObject);  // BC Upgrade SHUKLP03 << Blocked DIT field "Item Charge Calculate per"
        IF (CalledByObject IN [CalledByObject::Item, CalledByObject::ListItem]) THEN
            FromSalesLine2.SETRANGE("Attached to Line No.", FromSalesLine2."Line No.");
        FromSalesLine2.SETRANGE("Quantity Shipped", 0);
        FromSalesLine2.SETRANGE("Return Qty. Received", 0);
        FromSalesLine2.SETRANGE("Prepmt. Amt. Inv.", 0);

        IF FromSalesLine2.ISEMPTY THEN
            EXIT(FALSE);

        IF FromSalesLine2.FINDSET(TRUE) THEN BEGIN
            REPEAT
                ExistWhseDocLine :=
                  WhseValidateSourceLine.WhseLinesExist(
                    DATABASE::"Sales Line", FromSalesLine2."Document Type".AsInteger(), FromSalesLine2."Document No.", FromSalesLine2."Line No.", 0, FromSalesLine2.Quantity);
                IF (SourceSalesLine."Document Type" <> FromSalesLine2."Document Type") OR
                  (SourceSalesLine."Document No." <> FromSalesLine2."Document No.") OR
                  (SourceSalesLine."Line No." <> FromSalesLine2."Attached to Line No.")
                THEN BEGIN
                    IF FromSalesLine2."Attached to Line No." <> 0 THEN BEGIN
                        IF NOT SourceSalesLine.GET(FromSalesLine2."Document Type", FromSalesLine2."Document No.", FromSalesLine2."Attached to Line No.") THEN
                            CLEAR(SourceSalesLine);
                    END ELSE
                        SourceSalesLine := FromSalesLine2;
                END;

            //ExistApplLotSerialSSCC := IsTrackingApppliedSales(SourceSalesLine); // BC Upgrade SHUKLP03 << Blocked because dependency on DIT record "SSCC Reservation Entry" in procedure IsTrackingApppliedSales().


            // BC Upgrade SHUKLP03 >> Blocked because dependency on DIT field "Manual Item Charge" and "Item Charge Type".
            // IF (SourceSalesLine."Quantity Shipped" = 0) AND
            //   (SourceSalesLine."Quantity Invoiced" = 0) AND
            //   (SourceSalesLine."Return Qty. Received" = 0) AND
            //   (SourceSalesLine."Appl.-to Item Entry" = 0) AND
            //   (SourceSalesLine."Appl.-from Item Entry" = 0) AND
            //   (SourceSalesLine."Shipment No." = '') AND
            //   (SourceSalesLine."Return Receipt No." = '') AND
            //   (SourceSalesLine."Prepmt. Amt. Inv." = 0) AND
            //   NOT ExistWhseDocLine AND
            //   NOT ExistApplLotSerialSSCC AND
            //   NOT (("Manual Item Charge") AND (SourceSalesLine."Item Charge Type" <> "Item Charge Type"::Promotion))
            // THEN BEGIN
            //     SuspendStatusCheck(TRUE);
            //     DELETE(TriggerDelete);
            //     IF "Item Charge Type" = "Item Charge Type"::Promotion THEN BEGIN
            //         TempSalesLine.SETRANGE("Attached to Line No.", "Line No.");
            //         TempSalesLine.SETRANGE("Manual Item Charge", TRUE);
            //         TempSalesLine.DELETEALL;
            //     END;
            //     IF TempSalesLine.GET("Document Type", "Document No.", "Line No.") THEN
            //         TempSalesLine.DELETE;

            //     IF (SourceSalesLine."Line No." <> "Line No.") AND
            //       ("Attached to Line No." <> 0) AND

            //       (NOT (CalledByObject IN [CalledByObject::Item, CalledByObject::ListItem]))

            //     THEN BEGIN
            //         SourceSalesLine."Disc.Promo. Order Calculated" := FALSE;
            //         SourceSalesLine.MODIFY;

            //         IF FromSalesLine."Line No." = SourceSalesLine."Line No." THEN
            //             FromSalesLine := SourceSalesLine;
            //     END;
            // END;
            // BC Upgrade SHUKLP03 << Blocked because dependency on DIT field "Manual Item Charge" and "Item Charge Type".

            UNTIL FromSalesLine2.NEXT = 0;

            EXIT(TRUE);
        END;
        //END;
        //HEI.01<<
    end;

    procedure DeleteAllEmptesAttachedChargeSalesLines(VAR pRec: Record "Sales Line"; pblnTriggerDelete: Boolean)
    begin
        //HEI.01>>xxx
        GetSalesHeader(pRec);
        IF SalesHeader.Status = SalesHeader.Status::Released THEN
            EXIT;
        // CLEAR(CommonItemchrgMgt);
        // CommonItemchrgMgt.DeleteEmptySalesLinesAttchedToChrgItms(pRec, SaveTempSalesChargeLine, pblnTriggerDelete, pRec."Item Charge Calculate per"::Item); // BC Upgrade SHUKLP03 << Blocked because DIT object CommonItemchrgMgt.
        //HEI.01<<
    end;

    LOCAL procedure GetSalesHeader(pRec: Record "Sales Line")
    begin
        //HEI.01>>
        pRec.TESTFIELD(pRec."Document No.");
        IF (pRec."Document Type" <> SalesHeader."Document Type") OR (pRec."Document No." <> SalesHeader."No.") THEN BEGIN
            SalesHeader.GET(pRec."Document Type", pRec."Document No.");
            IF SalesHeader."Currency Code" = '' THEN
                Currency.InitRoundingPrecision
            ELSE BEGIN
                SalesHeader.TESTFIELD("Currency Factor");
                Currency.GET(SalesHeader."Currency Code");
                Currency.TESTFIELD("Amount Rounding Precision");
            END;
            // <<DITW15.00.00.32 DDR 08/04/2009
            SaveCurrency := Currency;
            // >>DITW15.00.00.32 DDR
        END ELSE BEGIN
            // <<DITW15.00.00.32 DDR 08/04/2009
            Currency := SaveCurrency;
            // >>DITW15.00.00.32 DDR
        END;
        // <<DITW15.00.00.32 DDR 08/04/2009
        // Currency.SetRoundingPrecisionDrink(pRec."Item Charge Type" = pRec."Item Charge Type"::Tax, 0); // BC Upgrade SHUKLP03 << Blocked because DIT Procedure.
        // >>DITW15.00.00.32 DDR
        //HEI.01<<
    end;
}
