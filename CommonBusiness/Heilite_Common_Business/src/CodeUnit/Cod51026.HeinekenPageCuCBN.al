codeunit 51026 "Heineken Page Cu CBN"
{
    trigger OnRun()
    begin

    end;

    //BC Upgrade SHUKLP03  >> Page 6500

    // # HEI.01 Called procedure AutoSelectTrackingNoExt() from page "Item Tracking Summary".

    [EventSubscriber(ObjectType::Page, 6500, OnBeforeAutoSelectTrackingNo, '', false, false)]
    local procedure OnBeforeAutoSelectTrackingNo(var EntrySummary: Record "Entry Summary" temporary; var IsHandled: Boolean; var MaxQuantity: Decimal)
    var
        ItemTrackingSummExt: Page 6500;
    begin
        //HEI.01>>
      //  ItemTrackingSummExt.AutoSelectTrackingNoExt(MaxQuantity);
        ItemTrackingSummExt.AutoSelectTrackingNoExt(MaxQuantity, EntrySummary); //BC Upgrade Kamnay01 Bug Fix 
        //HEI.01<<
        IsHandled := true;
    end;

    //BC Upgrade SHUKLP03 << Page 6500

    //BC Upgrade Kamnay01>> code in page "Apply Vendor Entries" Hei.01
    [EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", OnSetVendApplIdOnAfterCheckAgainstApplnCurrency, '', false, false)]
    local procedure "Apply Vendor Entries_OnSetVendApplIdOnAfterCheckAgainstApplnCurrency"(var VendorLedgerEntry: Record "Vendor Ledger Entry"; CalcType: Option; GenJnlLine: Record "Gen. Journal Line"; PurchHeader: Record "Purchase Header"; ApplyingVendLedgEntry: Record "Vendor Ledger Entry")
    var
        Text020: Label 'The %1 document is already present on proposal in journal %2';
    begin
        //HEI.01>>
        IF VendorLedgerEntry."Batch payment name FND" <> '' THEN
            ERROR(Text020, VendorLedgerEntry."Document No.", VendorLedgerEntry."Batch payment name FND");
        //HEI.01<<
    end;
    //BC Upgrade Kamnay01<< code in page "Apply Vendor Entries"[EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", OnSetVendApplIdOnAfterCheckAgainstApplnCurrency, '', false, false)]


    //BC Upgrade Kamnay01 >> Page 283 Recurring General Journal - HEI.01
    //In NAV, page 283 – Recurring General Journal called SetControlAppearance twice in OnOpenPage.
    //In BC, subscribed to event OnAfterOnOpenPage of the same page in HeinekenPageCU (subscriber name: OnAfterOnOpenPage_RecurringGenJnl) to call SetControlAppearance once, covering both “opened from batch” and normal selection cases.
    [EventSubscriber(ObjectType::Page, Page::"Recurring General Journal", 'OnAfterOnOpenPage', '', false, false)]
    local procedure OnAfterOnOpenPage(CurrentJnlBatchName: Code[10])
    var
        Pag_RecurringGeneralJournal: Page "Recurring General Journal";
    begin
        // HEI.01 >>
        Pag_RecurringGeneralJournal.SetControlAppearance();
        // HEI.01 <<
    end;
    //BC Upgrade Kamnay01 << Page 283 Recurring General Journal - HEI.01



    // Page 5805 Item Charge Assigment>>
    [EventSubscriber(ObjectType::Page, page::"Item Charge Assignment (Purch)", 'OnAfterUpdateQty', '', true, true)]
    local procedure OnAfterUpdateQty(var ItemChargeAssignmentPurch: Record "Item Charge Assignment (Purch)"; var QtyToReceiveBase: Decimal; var QtyReceivedBase: Decimal; var QtyToShipBase: Decimal; var QtyShippedBase: Decimal; var GrossWeight: Decimal; var UnitVolume: Decimal)
    var
        TransferShptLine: Record "Transfer Shipment Line";
    begin
        //>> HEI.01
        case ItemChargeAssignmentPurch."Applies-to Doc. Type" of//Bc Upgrade YADAVM09 Case statement required
            ItemChargeAssignmentPurch."Applies-to Doc. Type"::"Transfer Shipment":
                BEGIN
                    TransferShptLine.GET(ItemChargeAssignmentPurch."Applies-to Doc. No.", ItemChargeAssignmentPurch."Applies-to Doc. Line No.");
                    QtyToReceiveBase := 0;
                    QtyReceivedBase := TransferShptLine.Quantity;
                    QtyToShipBase := 0;
                    QtyShippedBase := 0;
                END;
        //<< HEI.01
        end;
    end;
    // Page 5805 Item Charge Assigment<<


    // BC Upgrade BHARDA11 >> ----This event is using in Onaftergtrecord trigger in customer card page; 
    //we need to comment this function in base and use custom function so this  NewMode := false; this variable exit thi function , this is the local function use only single time .
    [EventSubscriber(ObjectType::Page, Page::"Customer Card", OnBeforeCreateCustomerFromTemplate, '', false, false)]

    local procedure OnBeforeCreateCustomerFromTemplate(var NewMode: Boolean; var Customer: Record Customer)
    begin
        NewMode := false; // BC Upgrade BHARDA11
    end;
    // BC Upgrade BHARDA11 << ----This event is using in Onaftergtrecord trigger in customer card page.



    //BC Upgrade KAPOOV01 #PAG-5870-HEI.01 >>
    //-----------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 PAG-5870-HEI.01 #Created new function -OnBeforeGenerateBOMTree & Subscribed to event-OnBeforeGenerateBOMTree of function-GenerateBOMTree so as to handle OnOpenpage Trigger related customization>>
    [EventSubscriber(ObjectType::Page, PAGE::"BOM Structure", OnBeforeGenerateBOMTree, '', false, false)]
    local procedure OnBeforeGenerateBOMTree(var BOMBuffer: Record "BOM Buffer"; var Item: Record Item; var AsmHeader: Record "Assembly Header"; var ProdOrderLine: Record "Prod. Order Line"; ShowBy: Integer; ItemFilter: Code[250]; var IsHandled: Boolean)
    var
        BOMStructure: Page "BOM Structure";
    begin
        if RunPageFromSKU_HNK = true then begin
            IsHandled := true;
            BOMStructure.RefreshPageSKU();
        end
        else
            IsHandled := false;
    end;
    //BC Upgrade KAPOOV01 PAG-5870-HEI.01 #Created new function -OnBeforeGenerateBOMTree & Subscribed to event-OnBeforeGenerateBOMTree of function-GenerateBOMTree so as to handle OnOpenpage Trigger related customization<<

    //BC Upgrade KAPOOV01 PAG-5870-HEI.01 #Created new function SetParam_HNK & called this function inside BOM Structure custom function-SetParam to check whether the BOM Structure page is opened from SKU Card or directly if BOM Structure page is opened from SKU Card then RunPageFromSKU_HNK boolean defined as Global variable in HeinekenBCUpgrade is set to True and based on this variable RunPageFromSKU_HNK true value RefreshPageSKU() function will be invoked in function-OnBeforeGenerateBOMTree else if value is false then standard function for RefreshPage will be called. >>
    procedure SetParam_HNK(RunFromSKU_Param: Boolean)
    var
    begin
        RunPageFromSKU_HNK := RunFromSKU_Param;
    end;
    //BC Upgrade KAPOOV01 PAG-5870-HEI.01 #Created new function SetParam_HNK & called this function inside BOM Structure custom function-SetParam to check whether the BOM Structure page is opened from SKU Card or directly if BOM Structure page is opened from SKU Card then RunPageFromSKU_HNK boolean defined as Global variable in HeinekenBCUpgrade is set to True and based on this variable RunPageFromSKU_HNK true value RefreshPageSKU() function will be invoked in function-OnBeforeGenerateBOMTree else if value is false then standard function for RefreshPage will be called. <<
    var
        RunPageFromSKU_HNK: Boolean;
    //BC Upgrade KAPOOV01 # created new Global Variable-PAG-5870.
    //BC Upgrade KAPOOV01 #PAG-5870-HEI.01 <<



}