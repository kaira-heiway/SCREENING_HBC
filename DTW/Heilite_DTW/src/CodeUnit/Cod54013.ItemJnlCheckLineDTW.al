namespace BC_DTWLocal.BC_DTWLocal;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GeneralLedger.Preview;
using Microsoft.Finance.GeneralLedger.Posting;
using ALProject.ALProject;
using Microsoft.CRM.Team;
using Microsoft.Warehouse.Journal;
using System.Security.User;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Ledger;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Inventory.Setup;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Posting;

codeunit 54013 "Item Jnl.-Check Line _DTW"

//BC Upgrade Kamnay01 Created this new Cu for Revaluation Journal error log. FDD- FDD-DTW-031


// DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008 BrewIt & Quality

// DITW15.00.00.24 DDR 01/10/2008 Skip check Applies-to when "Item charge no." from journals

// DITW15.00.00.25 DDR 27/10/2008 Check if field "Opposite Amount Sign" is used for Tax only and journal

//                                Added TextConst Text2013660,Text2013661

// DITW15.00.00.29 DDR 12/12/2008 Bugfix to allow the internal taxes with (new) location empty when

//                                  location code is mandatory from inventory setup

// DITW15.00.00.30 DDR 09/01/2009 Added function CheckCombLocationBins()

// DITW15.00.00.33 DDR 08/05/2009 Added checking Duty Suspended and Due Tax

// DITW15.00.00.37 DDR 19/01/2010 issue 1038 Allowed the internal item charges within 'output'/'consumption' entry types

//                     19/05/2010 issue 1137 Added checking for the internal item charges

//                     28/05/2010 issue 480 Allow field "Opposite Amount Sign" for transfer orders

// DITW15.00.00.38 DDR 05/07/2010 issue 1109 Remove quantity checking when splitted by lot/serial tracking line

//                     24/08/2010 issue 1217 EMCS (e-AAD) Functionnalities

//                                           Added checking AAD/EMCS fields

//                     14/03/2011 issue 703 Skip item charge tests while posting BOM journals (temporary)

// DITW16.00.00.40 DDR 21/05/2012 DIT-715 #182 Review item charge workflow when Purchase order linked to Prod. order (subcontract

// DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added functions CheckWorkOrderOnLocation()

// DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade

// DITW17.10.02 DDR 22/11/2013 DIT-770 #000

// DITW17.00.03 DDR 06/03/2014 DIT-770 #530 Added to show mandatory dimensions when item charge instead of item

// DITW17.10.05 MSF 17/11/2014 DIT-770 #701 Added function isItemDuetaxMondatory & isLocationDuetaxMondatory & CheckTaxDueMondatory

// DITW17.10.05 MSF 20/11/2014 DIT-770 #701 Deleted function isItemDuetaxMondatory & isLocationDuetaxMondatory & CheckTaxDueMondatory

// DITW17.10.05 MSF 08/12/2014 DIT-770 #701 Check when post line

// DITW17.10.05 MSF 11/12/2014 DIT-770 #701

// DITW18.00 MSF 27/04/2015 DIT-770 #1363 Fix Upgrade Tag

// DITW18.00 MSF 18/09/2015 DIT-770 #1612 Fix Upgrade Error

// DITW18.00.07 MSF 22/01/2016 DIT-770 #1766 :Wrong check on new location code for Tax charge lines in Transfer order or rfeclass. jnl.

// DITW18.00.07 DDR 20/06/2016 DIT-770 #1770 Added new ENU captions

// DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality

//                                                      Remove field3 Prod. Unit of Measure (replaced by Inventory setup table313)

//                                                      Added checking for Work & Machine center max % scrap

// DITW19.00.08 DDR 29/09/2016 BL#10443 Added checking on "Loss Breakdown Mandatory"

//                                      Added default Scrap Code from Work Centers

// DITW19.00.08 DDR 17/10/2016 BL#10443 Added function CheckOutputStrengthVol()

//                                      Added text constants Text2013664

// DITW19.00.08 DDR 20/10/2016 BL#10443 Removed function CheckOutputStrengthVol()

// DITW19.00.08 DDR 27/10/2016 BL#10443 Modified checking scrap code mandatory for only neg. item journal

// DITW19.00.08 DDR 22/11/2016 BL#10443 Bugfix read Work center instead of Machine center

// DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

// DITW110.00.08 DDR 02/02/2017 NRQ#20692 Item Category Code length 20

// DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7

// HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Functions used for Zone code development without whs advanced mgmt

// HEI.02 CHG2026978 IBM.LS      05.12.2019

//   # Code added to execute process based on "Enable Phys. Inv. Round-off".

// HEI.03 CHG2131424 IBM SISUM01 01/05/2023 HB2520 Dimension Validation HeiLite

//   # Code change to skip Dimension COmbination if the setup is in place and if record is created from Sales documents

// HEI.04 CHG2187702 SAHAL01 18.09.2023 Revaluation journal items in error

//   # Added Code

{
    var

        Text023: Label ' %1 %2';

        Text024: Label 'You cannot post before %1 because the %2 is already closed. You must re-open the period first.';
        text021: Label '%1 cannot be left blank.';
        ItemJnlPostBatchL: Codeunit "Item Jnl.-Post Batch _DTW";
        CreateLog: Boolean;
        ItemJnlLineError: Record "Item Journal Line";
        ErrorTextL: Text[250];
        Location: Record Location;
        InvtSetup: Record "Inventory Setup";
        GLSetup: Record "General Ledger Setup";
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemJnlLine2: Record "Item Journal Line";
        ItemJnlLine3: Record "Item Journal Line";
        DimMgt: Codeunit DimensionManagement;
        CalledFromInvtPutawayPick: Boolean;
        CalledFromAdjustment: Boolean;

#pragma warning disable AA0074
#pragma warning disable AA0470
        Text000: Label 'cannot be a closing date';
        Text003: Label 'must not be negative when %1 is %2';
        Text004: Label 'must have the same value as %1';
        Text005: Label 'must be %1 or %2 when %3 is %4';
        Text006: Label 'must equal %1 - %2 when %3 is %4 and %5 is %6';
        DimCombBlockedErr: Label 'The combination of dimensions used in item journal line %1, %2, %3 is blocked. %4.', Comment = '%1 = Journal Template Name; %2 = Journal Batch Name; %3 = Line No.';
        DimCausedErr: Label 'A dimension used in item journal line %1, %2, %3 has caused an error. %4.', Comment = '%1 = Journal Template Name; %2 = Journal Batch Name; %3 = Line No.';
        Text011: Label '%1 must not be equal to %2';
        UseInTransitLocationErr: Label 'You can use In-Transit location %1 for transfer orders only.';

        Item: Record Item;
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        IsHandled: Boolean;
        ShouldCheckApplication: Boolean;
        ShouldCheckDiscountAmount: Boolean;
        ShouldCheckLocationCode: Boolean;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", OnAfterGetItem, '', false, false)]
    local procedure "Item Jnl.-Check Line_OnAfterGetItem"(Item: Record Item; var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        IsHandled := True;
        GetItemJnlLine(ItemJournalLine);
        if ItemJournalLine."Posting No. Series" = '' then begin//Begin BC Upgrade Kamnay01

            //HEI.04>> //BC Upgrade Kamnay01
            IF CreateLog AND (ItemJournalLine."Document No." = '') THEN BEGIN
                ErrorTextL := STRSUBSTNO(Text021, ItemJournalLine.FIELDCAPTION(ItemJournalLine."Document No."));
                ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                CLEAR(ErrorTextL);
            END ELSE
                //HEI.04<< BC Upgrade Kamnay01
                ItemJournalLine.TestField("Document No.", ErrorInfo.Create());
        End;
        //HEI.04>>
        IF CreateLog AND (ItemJournalLine."Gen. Prod. Posting Group" = '') THEN BEGIN
            ErrorTextL := STRSUBSTNO(Text021, ItemJournalLine.FIELDCAPTION("Gen. Prod. Posting Group"));
            ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
            CLEAR(ErrorTextL);
        END ELSE
            //HEI.04<<
            ItemJournalLine.TestField("Gen. Prod. Posting Group", ErrorInfo.Create());

        CheckDates(ItemJournalLine);

        ////IsHandled := false;
        // OnBeforeCheckLocation(ItemJournalLine, IsHandled);
        if not IsHandled then
            if InvtSetup."Location Mandatory" and
                (ItemJournalLine."Value Entry Type" = ItemJournalLine."Value Entry Type"::"Direct Cost") and
               (ItemJournalLine.Quantity <> 0) and
               not ItemJournalLine.Adjustment and
               not ItemJournalLine.Correction
            then begin
                ShouldCheckLocationCode := (ItemJournalLine.Type <> ItemJournalLine.Type::Resource) and (Item.Type = Item.Type::Inventory) and
                   (not ItemJournalLine."Direct Transfer" or (ItemJournalLine."Document Type" = ItemJournalLine."Document Type"::"Transfer Shipment"));
                //OnRunCheckOnAfterCalcShouldCheckLocationCode(ItemJournalLine, ShouldCheckLocationCode);
                if ShouldCheckLocationCode then
                    ItemJournalLine.TestField("Location Code", ErrorInfo.Create());
                if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer) and
                   (not ItemJournalLine."Direct Transfer" or (ItemJournalLine."Document Type" = ItemJournalLine."Document Type"::"Transfer Receipt"))
                then
                    ItemJournalLine.TestField("New Location Code", ErrorInfo.Create())
                else
                    ItemJournalLine.TestField("New Location Code", '', ErrorInfo.Create());
                if GLSetup."Journal Templ. Name Mandatory" and
                    (InvtSetup."Automatic Cost Posting" or InvtSetup."Expected Cost Posting to G/L")
                then begin
                    InvtSetup.TestField("Invt. Cost Jnl. Template Name", ErrorInfo.Create());
                    InvtSetup.TestField("Invt. Cost Jnl. Batch Name", ErrorInfo.Create());
                end;
            end;

        CheckVariantMandatory(ItemJournalLine, Item);

        CheckInTransitLocations(ItemJournalLine);

        if Item.IsInventoriableType() then
            CheckBins(ItemJournalLine)
        else
            ItemJournalLine.TestField("Bin Code", '', ErrorInfo.Create());

        ShouldCheckDiscountAmount := ItemJournalLine."Entry Type" in [ItemJournalLine."Entry Type"::"Positive Adjmt.", ItemJournalLine."Entry Type"::"Negative Adjmt."];
        //OnRunCheckOnAfterCalcShouldCheckDiscountAmount(ItemJournalLine, ShouldCheckDiscountAmount);
        if ShouldCheckDiscountAmount then
            ItemJournalLine.TestField("Discount Amount", 0, ErrorInfo.Create());

        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer then begin
            if (ItemJournalLine."Value Entry Type" = ItemJournalLine."Value Entry Type"::"Direct Cost") and
               (ItemJournalLine."Item Charge No." = '') and
               not ItemJournalLine.Adjustment
            then
                ItemJournalLine.TestField(Amount, 0, ErrorInfo.Create());
            ItemJournalLine.TestField("Discount Amount", 0, ErrorInfo.Create());
            if (ItemJournalLine.Quantity < 0) and not ItemJournalLine.Correction then
                ItemJournalLine.FieldError(Quantity, ErrorInfo.Create(StrSubstNo(Text003, ItemJournalLine.FieldCaption("Entry Type"), ItemJournalLine."Entry Type"), true));
            if ItemJournalLine.Quantity <> ItemJournalLine."Invoiced Quantity" then
                ItemJournalLine.FieldError("Invoiced Quantity", ErrorInfo.Create(StrSubstNo(Text004, ItemJournalLine.FieldCaption(Quantity)), true));
        end;

        if not ItemJournalLine."Phys. Inventory" then begin
            CheckEmptyQuantity(ItemJournalLine);
            ItemJournalLine.TestField("Qty. (Calculated)", 0, ErrorInfo.Create());
            ItemJournalLine.TestField("Qty. (Phys. Inventory)", 0, ErrorInfo.Create());
        end else
            CheckPhysInventory(ItemJournalLine);

        CheckOutputFields(ItemJournalLine);

        ShouldCheckApplication := ItemJournalLine."Applies-from Entry" <> 0;
        // OnRunCheckOnAfterCalcShouldCheckApplication(ItemJournalLine, ShouldCheckApplication);
        if ShouldCheckApplication then begin
            ItemLedgEntry.Get(ItemJournalLine."Applies-from Entry");
            ItemLedgEntry.TestField("Item No.", ItemJournalLine."Item No.", ErrorInfo.Create());
            ItemLedgEntry.TestField("Variant Code", ItemJournalLine."Variant Code", ErrorInfo.Create());
            ItemLedgEntry.TestField(Positive, false, ErrorInfo.Create());
            if ItemJournalLine."Applies-to Entry" = ItemJournalLine."Applies-from Entry" then
                Error(
                    ErrorInfo.Create(
                        StrSubstNo(
                            Text011,
                            ItemJournalLine.FieldCaption("Applies-to Entry"),
                            ItemJournalLine.FieldCaption("Applies-from Entry")),
                        true));
        end;

        // OnRunOnCheckWarehouse(ItemJournalLine, CalledFromAdjustment, CalledFromInvtPutawayPick);

        // //IsHandled := false;
        // OnRunCheckOnBeforeTestFieldAppliesToEntry(ItemJournalLine, IsHandled);
        if not isHandled then
            if (ItemJournalLine."Value Entry Type" <> ItemJournalLine."Value Entry Type"::"Direct Cost") or (ItemJournalLine."Item Charge No." <> '') then
                if ItemJournalLine."Inventory Value Per" = ItemJournalLine."Inventory Value Per"::" " then
                    ItemJournalLine.TestField("Applies-to Entry", ErrorInfo.Create());

        CheckDimensions(ItemJournalLine);

        if (ItemJournalLine."Entry Type" in
            [ItemJournalLine."Entry Type"::Purchase, ItemJournalLine."Entry Type"::Sale, ItemJournalLine."Entry Type"::"Positive Adjmt.", ItemJournalLine."Entry Type"::"Negative Adjmt."]) and
           (not GenJnlPostPreview.IsActive())
        then
            ItemJournalLine.CheckItemJournalLineRestriction();

        //HEI.04>>  //Check    
        IF CreateLog AND (GETLASTERRORTEXT <> '') THEN BEGIN
            ErrorTextL := COPYSTR(GETLASTERRORTEXT, 1, 250);
            ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
        END;
        CLEAR(ErrorTextL);
        //HEI.04<< 
        // OnAfterCheckItemJnlLine(ItemJournalLine, CalledFromInvtPutawayPick, CalledFromAdjustment);
    end;

    local procedure CheckDates(ItemJnlLine: Record "Item Journal Line")
    var
        InvtPeriod: Record "Inventory Period";
        UserSetupManagement: Codeunit "User Setup Management";
        DateCheckDone: Boolean;
        ShouldShowError: Boolean;
    begin
        //HEI.04>>
        IF CreateLog AND (ItemJnlLine."Posting Date" = 0D) THEN BEGIN
            ErrorTextL := STRSUBSTNO(Text021, ItemJnlLine.FIELDCAPTION(ItemJnlLine."Posting Date"));
            ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
            CLEAR(ErrorTextL);
        END ELSE
            //HEI.04<<
            ItemJnlLine.TestField("Posting Date", ErrorInfo.Create());


        if ItemJnlLine."Posting Date" <> NormalDate(ItemJnlLine."Posting Date") then
            //HEI.04>>  BC Upgrade Kamnay01 change 
            IF CreateLog THEN BEGIN
                ErrorTextL := STRSUBSTNO(Text023, ItemJnlLine."Posting Date", Text000);
                ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                CLEAR(ErrorTextL);
            END ELSE
                //HEI.04 <<  BC Upgrade Kamnay01 change 
                ItemJnlLine.FieldError("Posting Date", ErrorInfo.Create(Text000, true));

        //OnBeforeDateNotAllowed(ItemJnlLine, DateCheckDone);
        if not DateCheckDone then
            UserSetupManagement.CheckAllowedPostingDate(ItemJnlLine."Posting Date");

        ShouldShowError := not InvtPeriod.IsValidDate(ItemJnlLine."Posting Date");
        // OnCheckDatesOnAfterCalcShouldShowError(ItemJnlLine, ShouldShowError, CalledFromAdjustment);
        //HEI.04>>
        if not InvtPeriod.IsValidDate(ItemJnlLine."Posting Date") then // BC Upgrade Kamnay01 added this 
            IF CreateLog THEN BEGIN
                ErrorTextL := STRSUBSTNO(Text024, CALCDATE('<+1D>', ItemJnlLine."Posting Date"), InvtPeriod.TABLECAPTION);
                ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                CLEAR(ErrorTextL);
            END ELSE
                //HEI.04<<
                InvtPeriod.ShowError(ItemJnlLine."Posting Date");


        if ItemJnlLine."Document Date" <> 0D then begin
            if ItemJnlLine."Document Date" <> NormalDate(ItemJnlLine."Document Date") then begin
                //HEI.04>>
                IF CreateLog THEN BEGIN
                    ErrorTextL := STRSUBSTNO(Text023, ItemJnlLine."Document Date", Text000);
                    ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                    CLEAR(ErrorTextL);
                END ELSE
                    //HEI.04<<
                    ItemJnlLine.FieldError("Document Date", ErrorInfo.Create(Text000, true));
            end;
        end;
    End;

    local procedure CheckVariantMandatory(var ItemJournalLine: Record "Item Journal Line"; var Item: Record Item)
    var
        IsHandled: Boolean;
    begin
        //IsHandled := false;
        //OnBeforeCheckVariantMandatory(ItemJournalLine, IsHandled);
        if IsHandled then
            exit;

        if ItemJournalLine."Item Charge No." <> '' then
            exit;

        if ItemJournalLine."Inventory Value Per" in [ItemJournalLine."Inventory Value Per"::Item, ItemJournalLine."Inventory Value Per"::Location] then
            exit;

        if Item.IsVariantMandatory(InvtSetup."Variant Mandatory if Exists", ItemJournalLine."Item No.") then
            ItemJournalLine.TestField("Variant Code", ErrorInfo.Create());
    end;

    local procedure CheckInTransitLocations(var ItemJnlLine: Record "Item Journal Line")
    var
        IsHandled: Boolean;
    begin
        //IsHandled := false;
        //OnBeforeCheckInTransitLocations(ItemJnlLine, IsHandled);
        if IsHandled then
            exit;

        if ((ItemJnlLine."Entry Type" <> ItemJnlLine."Entry Type"::Transfer) or (ItemJnlLine."Order Type" <> ItemJnlLine."Order Type"::Transfer)) and
               not ItemJnlLine.Adjustment
        then begin
            CheckInTransitLocation(ItemJnlLine."Location Code");
            CheckInTransitLocation(ItemJnlLine."New Location Code");
        end;
    end;

    local procedure CheckBins(ItemJnlLine: Record "Item Journal Line")
    var
        WMSManagement: Codeunit "WMS Management";
        IsHandled: Boolean;
        ShouldExit: Boolean;
    begin
        //IsHandled := false;
        //OnBeforeCheckBins(ItemJnlLine, IsHandled, CalledFromAdjustment);
        if IsHandled then
            exit;

        if (ItemJnlLine."Item Charge No." <> '') or (ItemJnlLine."Value Entry Type" <> ItemJnlLine."Value Entry Type"::"Direct Cost") or (ItemJnlLine.Quantity = 0) then
            exit;

        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer then begin
            GetLocation(ItemJnlLine."New Location Code");
            CheckNewBinCode(ItemJnlLine);
        end else begin
            GetLocation(ItemJnlLine."Location Code");
            if not Location."Bin Mandatory" or Location."Directed Put-away and Pick" then
                exit;
        end;

        if ItemJnlLine."Drop Shipment" or ItemJnlLine.OnlyStopTime() or (ItemJnlLine."Quantity (Base)" = 0) or ItemJnlLine.Adjustment or CalledFromAdjustment then
            exit;

        ShouldExit := false;
        // OnCheckBinsOnCheckForEntryTypeOutput(ItemJnlLine, ShouldExit);
        if ShouldExit then
            exit;

        //IsHandled := false;
        //OnCheckBinsOnBeforeCheckNonZeroQuantity(ItemJnlLine, CalledFromAdjustment, IsHandled);
        if not IsHandled then
            if ItemJnlLine.Quantity <> 0 then
                case ItemJnlLine."Entry Type" of
                    ItemJnlLine."Entry Type"::Purchase,
                  ItemJnlLine."Entry Type"::"Positive Adjmt.",
                  ItemJnlLine."Entry Type"::Output,
                  ItemJnlLine."Entry Type"::"Assembly Output":
                        WMSManagement.CheckInbOutbBin(ItemJnlLine."Location Code", ItemJnlLine."Bin Code", ItemJnlLine.Quantity > 0);
                    ItemJnlLine."Entry Type"::Sale,
                  ItemJnlLine."Entry Type"::"Negative Adjmt.",
                  ItemJnlLine."Entry Type"::Consumption,
                  ItemJnlLine."Entry Type"::"Assembly Consumption":
                        WMSManagement.CheckInbOutbBin(ItemJnlLine."Location Code", ItemJnlLine."Bin Code", ItemJnlLine.Quantity < 0);
                    ItemJnlLine."Entry Type"::Transfer:
                        begin
                            GetLocation(ItemJnlLine."Location Code");
                            if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
                                WMSManagement.CheckInbOutbBin(ItemJnlLine."Location Code", ItemJnlLine."Bin Code", ItemJnlLine.Quantity < 0);
                            if (ItemJnlLine."New Location Code" <> '') and (ItemJnlLine."New Bin Code" <> '') then
                                WMSManagement.CheckInbOutbBin(ItemJnlLine."New Location Code", ItemJnlLine."New Bin Code", ItemJnlLine.Quantity > 0);
                        end;
                end;
    end;

    local procedure CheckEmptyQuantity(ItemJnlLine: Record "Item Journal Line")
    var
        IsHandled: Boolean;
    begin
        // //IsHandled := false;
        //OnBeforeCheckEmptyQuantity(ItemJnlLine, IsHandled);
        if IsHandled then
            exit;

        //OnCheckEmptyQuantity(ItemJnlLine);
    end;

    local procedure CheckPhysInventory(ItemJnlLine: Record "Item Journal Line")
    var
        IsHandled: Boolean;
    begin
        // //IsHandled := false;
        //OnBeforeCheckPhysInventory(ItemJnlLine, IsHandled);
        if IsHandled then
            exit;

        if not
           (ItemJnlLine."Entry Type" in
            [ItemJnlLine."Entry Type"::"Positive Adjmt.", ItemJnlLine."Entry Type"::"Negative Adjmt."])
        then begin
            ItemJnlLine2."Entry Type" := ItemJnlLine2."Entry Type"::"Positive Adjmt.";
            ItemJnlLine3."Entry Type" := ItemJnlLine3."Entry Type"::"Negative Adjmt.";
            ItemJnlLine.FieldError(
                "Entry Type",
                ErrorInfo.Create(
                    StrSubstNo(
                        Text005, ItemJnlLine2."Entry Type", ItemJnlLine3."Entry Type", ItemJnlLine.FieldCaption("Phys. Inventory"), true),
                    true));
        end;
        if (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt.") and
           (ItemJnlLine."Qty. (Phys. Inventory)" - ItemJnlLine."Qty. (Calculated)" <> ItemJnlLine.Quantity)
        then
            ItemJnlLine.FieldError(
                Quantity,
                 ErrorInfo.Create(
                    StrSubstNo(
                        Text006, ItemJnlLine.FieldCaption("Qty. (Phys. Inventory)"), ItemJnlLine.FieldCaption("Qty. (Calculated)"),
                        ItemJnlLine.FieldCaption("Entry Type"), ItemJnlLine."Entry Type", ItemJnlLine.FieldCaption("Phys. Inventory"), true),
                    true));
        if (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Negative Adjmt.") and
           (ItemJnlLine."Qty. (Calculated)" - ItemJnlLine."Qty. (Phys. Inventory)" <> ItemJnlLine.Quantity)
        then
            ItemJnlLine.FieldError(
                Quantity,
                ErrorInfo.Create(
                    StrSubstNo(
                        Text006, ItemJnlLine.FieldCaption("Qty. (Calculated)"), ItemJnlLine.FieldCaption("Qty. (Phys. Inventory)"),
                        ItemJnlLine.FieldCaption("Entry Type"), ItemJnlLine."Entry Type", ItemJnlLine.FieldCaption("Phys. Inventory"), true),
                    true));
    end;

    local procedure CheckOutputFields(var ItemJournalLine: Record "Item Journal Line")
    var
        IsHandled: Boolean;
    begin
        // //IsHandled := false;
        //OnBeforeCheckOutputFields(ItemJournalLine, IsHandled);
        if IsHandled then
            exit;

        //OnCheckOutputFields(ItemJournalLine);
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Clear(Location)
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

    local procedure CheckInTransitLocation(LocationCode: Code[10])
    begin
        if Location.IsInTransit(LocationCode) then
            //HEI.04>>
            IF CreateLog THEN BEGIN
                ErrorTextL := COPYSTR(STRSUBSTNO(UseInTransitLocationErr, LocationCode), 1, 250);
                ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                CLEAR(ErrorTextL);
            END ELSE
                //HEI.04<<
                Error(ErrorInfo.Create(StrSubstNo(UseInTransitLocationErr, LocationCode), true));
    end;

    local procedure CheckNewBinCode(ItemJnlLine: Record "Item Journal Line")
    var
        IsHandled: Boolean;
    begin
        ////IsHandled := false;
        //OnBeforeCheckNewBinCode(ItemJnlLine, Location, IsHandled);
        if IsHandled then
            exit;

        if Location."Bin Mandatory" and not Location."Directed Put-away and Pick" then
            ItemJnlLine.TestField("New Bin Code", ErrorInfo.Create());
    end;

    local procedure CheckDimensions(ItemJnlLine: Record "Item Journal Line")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        IsHandled: Boolean;
    begin
        // //IsHandled := false;
        //OnBeforeCheckDimensions(ItemJnlLine, CalledFromAdjustment, IsHandled);
        if IsHandled then
            exit;

        if not ItemJnlLine.IsValueEntryForDeletedItem() and not ItemJnlLine.Correction and not CalledFromAdjustment then begin
            if not DimMgt.CheckDimIDComb(ItemJnlLine."Dimension Set ID") then
                //HEI.04>>
                IF CreateLog THEN BEGIN
                    ErrorTextL := STRSUBSTNO(DimCombBlockedErr, ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name", ItemJnlLine."Line No.", DimMgt.GetDimCombErr);
                    ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                    CLEAR(ErrorTextL);
                END ELSE
                    //HEI.04<<
                    Error(
                    ErrorInfo.Create(
                        StrSubstNo(
                            DimCombBlockedErr, ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name", ItemJnlLine."Line No.", DimMgt.GetDimCombErr()),
                        true));
            //Hei.03
            if ItemJnlLine."Item Charge No." = '' then begin
                TableID[1] := Database::Item;
                No[1] := ItemJnlLine."Item No.";
            end else begin
                TableID[1] := Database::"Item Charge";
                No[1] := ItemJnlLine."Item Charge No.";
            end;
            TableID[2] := Database::"Salesperson/Purchaser";
            No[2] := ItemJnlLine."Salespers./Purch. Code";
            // OnCheckDimensionsOnAfterSetTableValues(ItemJnlLine, TableID, No);

            if ItemJnlLine."New Dimension Set ID" <> 0 then begin
                TableID[4] := Database::Location;
                No[4] := ItemJnlLine."Location Code";
                CheckDimensionsAfterAssignDimTableIDs(ItemJnlLine, TableID, No, ItemJnlLine."Dimension Set ID");
                TableID[4] := Database::Location;
                No[4] := ItemJnlLine."New Location Code";
                CheckDimensionsAfterAssignDimTableIDs(ItemJnlLine, TableID, No, ItemJnlLine."New Dimension Set ID");
            end else begin
                // This condition will ensure locations default dimension is not checked as for Item charge lines, location in item journal is populated from document line
                if ItemJnlLine."Item Charge No." = '' then begin
                    TableID[4] := Database::Location;
                    No[4] := ItemJnlLine."Location Code";
                    TableID[5] := Database::Location;
                    No[5] := ItemJnlLine."New Location Code";
                end;
                if (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer) then begin
                    CheckDimensionsAfterAssignDimTableIDs(ItemJnlLine, TableID, No, ItemJnlLine."Dimension Set ID");
                    if (DimMgt.CheckDefaultDimensionHasCodeMandatory(TableID, No)) and
                       (ItemJnlLine."Value Entry Type" <> ItemJnlLine."Value Entry Type"::Revaluation)
                    then
                        CheckDimensionsAfterAssignDimTableIDs(ItemJnlLine, TableID, No, ItemJnlLine."New Dimension Set ID");
                end else
                    CheckDimensionsAfterAssignDimTableIDs(ItemJnlLine, TableID, No, ItemJnlLine."Dimension Set ID");
            end;

            if (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer) and
               (ItemJnlLine."Value Entry Type" <> ItemJnlLine."Value Entry Type"::Revaluation)
            then
                if not DimMgt.CheckDimIDComb(ItemJnlLine."Dimension Set ID") then begin
                    if ItemJnlLine."Line No." <> 0 then
                        //HEI.04>>
                        IF CreateLog THEN BEGIN
                            ErrorTextL := STRSUBSTNO(DimCausedErr, ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name", ItemJnlLine."Line No.", DimMgt.GetDimValuePostingErr);
                            ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                            CLEAR(ErrorTextL);
                        END ELSE
                            Error(
                                ErrorInfo.Create(
                                    StrSubstNo(DimCausedErr, ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name", ItemJnlLine."Line No.", DimMgt.GetDimValuePostingErr()),
                                true));
                    //HEI.04>>
                    IF CreateLog THEN BEGIN
                        ErrorTextL := DimMgt.GetDimValuePostingErr;
                        ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                        CLEAR(ErrorTextL);
                    END ELSE
                        //HEI.04<<
                        Error(ErrorInfo.Create(StrSubstNo(DimMgt.GetDimValuePostingErr()), true));
                end;
        end;
    end;

    local procedure CheckDimensionsAfterAssignDimTableIDs(
        ItemJnlLine: Record "Item Journal Line";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        DimSetID: Integer)
    begin
        //OnCheckDimensionsOnAfterAssignDimTableIDs(ItemJnlLine, TableID, No);
        if not DimMgt.CheckDimValuePosting(TableID, No, DimSetID) then begin
            if ItemJnlLine."Line No." <> 0 then
                //HEI.04>>
                IF CreateLog THEN BEGIN
                    ErrorTextL := STRSUBSTNO(DimCausedErr, ItemJnlLineError."Journal Template Name", ItemJnlLineError."Journal Batch Name", ItemJnlLineError."Line No.", DimMgt.GetDimValuePostingErr);
                    ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                    CLEAR(ErrorTextL);
                END ELSE
                    //HEI.04<<
                    Error(
                    ErrorInfo.Create(
                        StrSubstNo(DimCausedErr, ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name", ItemJnlLine."Line No.", DimMgt.GetDimValuePostingErr()),
                    true));
            //HEI.04>>
            IF CreateLog THEN BEGIN
                ErrorTextL := DimMgt.GetDimValuePostingErr;
                ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);
                CLEAR(ErrorTextL);
            END ELSE
                //HEI.04<<
                Error(ErrorInfo.Create(StrSubstNo(DimMgt.GetDimValuePostingErr()), true));
        end;
    end;



    local procedure GetItemJnlLine(VAR ItemJournalLine: Record "Item Journal Line")
    var

        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
    begin
        //HEI.04>>
        CLEAR(ItemJnlLineError);
        CLEAR(CreateLog);
        IF InventorySetupL.GET THEN BEGIN
            IF InventorySetupL."Activate Rev.Jnl.Error Log FND" THEN BEGIN
                IF ItemJnlTemplateL.GET(ItemJournalLine."Journal Template Name") THEN BEGIN
                    IF ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation THEN BEGIN
                        ItemJnlLineError.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                        ItemJnlLineError.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        ItemJnlLineError.SETRANGE("Line No.", ItemJournalLine."Line No.");
                        IF ItemJnlLineError.FINDFIRST THEN;
                        CreateLog := TRUE;
                    END;
                END;
            END;
        END;
    End;







}
