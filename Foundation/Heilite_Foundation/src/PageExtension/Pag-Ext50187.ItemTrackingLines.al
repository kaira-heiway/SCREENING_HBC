pageextension 50187 ItemTrackingLinesExt extends "Item Tracking Lines"
{
    //     // version NAVW111.00.00.20348,FINXL10.00,QXL11.01,DITW111.00.13A,HEI.03
    //     In order to provide F6 invoked lookup from availability bitmap columns, a menu button has been hidden behind control 1.
    // Function buttons Line and Function both exist in two overlayed versions to make dynamic show/hide/enable of
    // individual menu items possible.
    // DITW15.00.00.23 DDR 08/08/2008 Certification rules
    //                                 Restore original height/width form
    //                                 Added colunm "Your reference": Width & HorzGlue properties
    //                                 Remove "Assign &Lot No. " button
    //                                 Replaced by Shortcuts (Functions button)
    //                                   Assign Serial No.  <CTRL+S>
    //                                   Assign Lot No.     <CTRL+L>
    //                                   Select Entries         <F9>
    //                                   Refresh Availability   <F5>
    //                                 Change MenuItem access keys conflict
    //                                   "Create Quality Test" -> "Create &Quality Test" (Function button)
    //                                 Rename local variable QualityManagement (2x menu Functions\quality Test)
    // DOC UK-PROD JAD 29/08/08 - Bug with V5 - changed to V4 version
    // DITW16.00.00.37 DDR 30/06/2010 Remove MoveBinContent global variable (std Nav W16.00.01)
    //                     08/07/2010 Remove Shortcut F5 menu control64 Refresh Availability (button43 functions)
    //                                                   menu control79 Refresh Availability (button50 functions)
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    // DITW15.00.00.38 DDR 14/10/2010 issue 1139 SSCC Functionnalities
    //                                 Added menu 'SSCC Tracking' into 'Line' button
    //                                 Added text constants Text2035040
    //                                 Added functions OpenLotSSCCTracking(),ExistSSCCTrackingLines()
    //                     29/10/2010   Added parameter FormRunModeSSCC into function OpenSSCCTrackingLines()
    //                                 Modified function RegisterItemTrackingLines(),RegisterChange()
    //                                 Added function SetFormRunModeSSCC()
    //                     25/11/2010   Synchronize SSCC reservations while saving the Lot modifications
    //                                 Move menu 'SSCC Tracking' into 'Line' button
    //                                 Modified function ExistSSCCTrackingLines(),RegisterItemTrackingLines()
    //                     02/12/2010 issue 1139 (DIT711 90)
    //                                 Bugfix to validate the quality tests (or other) after calling of SSCC tracking form
    //                     08/12/2010 issue 1139 (DIT711 91) Editable Creation Date
    //                                                       Disable synchronization when existing LOT but decrease qty only
    //                                           (DIT711 92) Added Column "SSCC Quantity (base)" to show current reserved quantity
    //                                                       Added function LotSCAvailableQty()
    // DITW16.00.00.38 DDR 22/02/2011 DIT-715 #1 RTC Upgrade
    // DITW16.00.00.38 DDR 07/03/2011 DIT-715 #67 RTC Upgrade Page functionnalities
    //                                             Moved column "Your reference" after column lot/serial
    // DITW15.00.00.39 DDR 19/10/2011 issue 1443 Bugfix function SetSource() and find real item reservation lines
    // DITW16.00.00.40 DDR 20/12/2011 issue 1309 Bugfix to keep the expiration
    //                                           before using the lookup button of field "Quantity Base (SSCC)"
    //                                           The expiration date is not saved before to open SSCC tracking form
    //                     03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                                           Added functions CreateItemTrackingLine4Sales(),CreateItemTrackingLine()
    //                                           Added SaveItemTrakingLines()
    //                                           Modified code for saving Bin Code to the reserve entry
    //                                           Resize Form/Control59
    //                                           Added 'HorzGlue' property Control82
    //                     22/05/2012 DIT-715 #292 Bugfix to open SSCC Tracking form/page missing (current) Location/Bin code
    //                     11/06/2012 DIT-715 #355 Disable information message Text2035040
    //                     12/06/2012 DIT-715 #304 Bugfix to commit data before opening SSCC tracking lines (case Transfer order)
    //                     14/06/2012 DIT-715 #361 Bugfix to open SSCCTracking form/page (RTC Bug?)
    //                     17/10/2012 DIT-715 #442 Bugfix missing filter to synchronize to SSCC tracking lines
    //                     17/10/2012 DIT-715 #462 Bugfix synchronization transfer orders
    // DITW16.00.00.42 DDR 01/03/2013 DIT-715 #563 Modified SSCC from Item Tracking Code Fields
    // DITW16.00.00.43 DDR 08/07/2013 DIT-715 #693 Bugfix standard? error Source quantity
    //                                               while partial Lot Transfer shipment & Picking (still in Transit)
    //                 DDR 10/10/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added functions SetRequired()
    //                 DDR 14/10/2013 DIT-715 #775 Bugfix to update SSCC Lines
    //                 DDR 18/10/2013 DIT-715 #775 Bugfix to update the shared fields into SSCC lines
    //                 DDR 24/10/2013 DIT-715 #818 Bugfix to skip SSCC synchronisation while FormRunModeSSCC = Reverse
    //                 DDR 05/11/2013 DIT-715 #813 Removed field "Check SSCC/Lot Qty. Balance"

    // FINXL7.00.001 RBE 16/10/2013: Additional functions to add lot and serial nos from code

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 11/07/2013 DIT-715 #693 merge
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 15/10/2013 DIT-715 #775 Merge
    // DITW17.00.02 DDR 18/10/2013 DIT-715 #775 Merge
    // DITW17.00.02 DDR 24/10/2013 DIT-715 #818 Merge
    // DITW17.00.02 DDR 05/11/2013 DIT-715 #813 Merge
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 20/10/2015 DIT-770 #805 Renumber CodeUnit ID  2035095 to 2035150
    // DITW18.00.07 VSC 13/01/2016 DIT-770 #1825 Fill the expiration date
    // DITW19.00.08 DDR 29/09/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                     Added fields "Strength Spec. Code","Strength Spec. Value","New Strength Spec. Value"
    //                                                     Bugfix minor Look&Feel ribbon button
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Added fields "Vol-Strength Spec. Code","Vol-Strength Spec. Value","New Vol-Strength Spec. Value"
    // DITW19.00.08 DDR 07/11/2016 BL#10443 Bugfix to recalculate the strength volume while changing strength value
    // DITW19.00.08 DDR 14/11/2016 BL#10443 Bugfix to recalculate the strength volume with Qty. to handle
    //                                     Bugfix wrong strengh volume sign in function ModifyFieldsWithinFilter()

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // FINXL10.00 RGO 12/04/2017 NRQ#25748 Disabled Local property fct CreateLotSNInfoCard
    // DITW110.00.11 VSC 28/09/2017 NRQ#30577 Merge - QXL10.01 VSC 27/09/2017 NRQ#38351 : XL It should not be possible to select a blocked lot no on outbound
    // QXL11.01 MTR 13/09/2018 NRQ#24975 : Deleted function SetCustomControls()
    //                                     Changed call condition for "Your Reference" field visibility
    // DITW111.00.13A MSF 30/04/2019 NRQ#106834 AUTO FEFO and Undo Tracking Lines functions for transfer orders
    //                                           Added Function CreateItemTrackingLine4Transf
    // FINXL11.01 MTR 09/11/2018 NRQ#91436 : Added function fctGetTrackingSpecification()

    // HEI.01 FDD-GAPID003 - One component split into multiple lots,  IBM.NAIKH01 21/07/2017
    //   # Added Code on trigger "OnClosePage() "
    // HEI.02 FDD-PRDGAP004 - Automatic Batch Number Generation , 10.09.2017 IBM.NAIKH01
    //   # Created a new function "AssignLotNo_Batch".
    // HEI.03 ISSUE ID-294 - IBM.NAIKH01, 28.09.2017
    //   # Skiping the Warning message in the OnQueryClosePage() Trigger of the Page.
    // HEI.04 IBM MATHEJ01 08.01.2020 - #CHG2037233: Corrections for Expiry Date Generation Functionality
    //   # Modified function: AssignLotNo_Batch,OnInsertRecord
    // HEI.05 INC3034813/CHG2077568 & INC3003481 IBM.AK 07.09.20
    //   # Added code on Func CreateItemTrackingLine4ItJnl
    // HEI.06 CHG2112777 IBM.LS      15.06.2021
    //   # Added Code
    // HEI.07 CHG2075364 IBM.LS      21.07.2021
    //   # Added Movement option on SourceEntryType
    //   # Added Fields - Zone Code
    //                 - Bin Code
    //   # Added Code
    // HEI.08 CHG2120463 IBM.LS      20.08.2021
    //   # Added Code
    // HEI.09 CHG2118467 IBM.LS      14.09.2021
    //   # Created New Button - Create Reclass Batch No.
    //   # Added Code
    // HEI.10 CHG2119481 IBM.LS      10.12.2021
    //   # Added New Fields - KG/HL
    //                     - Weight of Extract
    //   # Added Code
    // HEI.11 CHG2119481 IBM.LS      21.01.2022
    //   # Added New Field - Reference No.
    //   # Added Code for Reference No.
    // HEI.12 CHG2132707 IBM.LS      24.01.2022
    //   # Added Code to calculate New Extract Content value
    //   # Added Fields - New Location Code
    //                 - New Bin Code

    // BC Upgrade SHUKLP03 >>
    // HEI.09 => To flow AvailablityDate in PostingDate code added on event OnAfterSetSourceSpec.
    // HEI.07 => Procedure LookupAvailable() code added on fields AvailabilitySerialNo, AvailabilityLotNo "TrackingAvailable(Rec,2)" on drilldown trigger.
    // HEI.05 => Code blocked because DrinkIT field "Strength Spec. Code" code is blocked
    //HEI.09 => RegisterChange() code is not added because event is not found, as per discussion with Sakshi: To maintain in excel need to check with functional.
    // HEI.07 => For procedure RegisterChange() code is not added because code is within DrinkIT code.
    // HEI.07 => Code is not added of procedure SetSourceSpec() SetFilters(), because code is written inside DrinkIT code.
    // HEI.07 => Code is not added of DrinkIT Procedure OpenLotSSCCTrackingLines().
    // HEI.11 => Code is not added of procedure SetFilters(), because code is written inside DrinkIT code.
    // On Procedure AssignLotNo_Batch(), I have modified procedure name from UpdateLotSNDataSetWithChange to UpdateTrackingDataSetWithChange. In BC procedure name is UpdateTrackingDataSetWithChange.

    // HEI.07 => Check RegisterChange(), LOCAL LookupAvailable(), LOCAL SelectEntries() HEI code.
    // HEI.06 => On procedure CreateLotNoInfo Some part of code blocked because DrinkIT field "Expiration Date" is used.
    // HEI.07 => ON procedure OnAFMoveFields Some part of code blocked because DrinkIT field "Bin Code" is used.
    // HEI.08 => Code blocked of field "Lot No." and procedure OnBFQueryClosePage() because DrinkIT field "Strength Spec. Value" is used.
    // HEI.09 => Some part of code blocked because DrinkIT field "New Bin Code", "Strength Spec. Value" is blocked on action("Create Reclass Batch No.") and procedure CreateNewLotNo().
    // HEI.12 => Code blocked because DrinkIT field "New Strength Spec. Value" is used.
    // HEI.10 => On local procedure AssignLotNo_Batch() Code blocked because DrinkIT field "Strength Spec. Code" is used.
    // HEI.10 => Whole procedure UpdateWeightOfExtractValues() is blocked because DrinkIT field "Strength Spec. Code" is used
    // HEI.12 => On local procedure SetValues() DrinkIt field is blocked.                       

    // HEI.07=> Half part of code of field "Lot No." is added on event OnBeforeLotNoAssistEdit.

    // HEI.07 => To execute HEI.07 code present on onclosepage trigger subscribed events OnBeforeClosePage, OnBeforeSynchronizeWarehouseItemTracking,OnAFterOnClosePage

    // HEI.10, HEI.11 => Subscribe event OnAfterCreateReservEntryFor to add code of procedure RegisterChange()
    // HEI.07 => Subscribe event OnAfterGetInvoiceSource to add code of procedure GetInvoiceSource().
    // # Called below procedures from Page extension of "Item Tracking Lines" on events: 
    // Procedure ==> Event
    // OnBFClosePage() ==> OnBeforeClosePage ----- HEI.07
    // OnBFSynchronizeWarehouseItemTracking() ==> OnBeforeSynchronizeWarehouseItemTracking ----- HEI.07
    // OnAFOnClosePage() ==> OnAFterOnClosePage ------- HEI.01
    // OnBFInsertRecord() ==> OnBeforeOnInsertRecord -------- HEI.04
    // OnBFOnModifyRecord() ==> OnBeforeOnModifyRecord ----- HEI.07
    // OnBFQueryClosePage() ==> OnBeforeQueryClosePage ----------- HEI.03,HEI.08
    // OnQueryClosePageOnBFCurrPageUpdate() ==> OnQueryClosePageOnBeforeCurrPageUpdate ------- HEI.09
    // OnBFLotNoAssistEdit() ==> OnBeforeLotNoAssistEdit ----- HEI.07
    // SetSourceSpecExt() ==> OnBeforeSetSourceSpec ----- HEI.07
    // OnBFFillSourceQuantityArray() ==> OnBeforeFillSourceQuantityArray ------- HEI.09
    // OnAFSetSourceSpec() ==> OnAfterSetSourceSpec ----- HEI.07
    // OnAddReservEntriesToTempRecSetOnBeforeInsertExt() ==> OnAddReservEntriesToTempRecSetOnBeforeInsert
    // SetFiltersC() ==> OnAfterSetFilters ----- HEI.07, HEI.11
    // OnAFMoveFields() ==> OnAfterMoveFields ----- HEI.07
    // OnAFAssignNewTrackingNo() ==> OnAfterAssignNewTrackingNo ----- HEI.07
    // OnSelectEntriesOnBFSelectMultipleTrackingNo() ==> OnSelectEntriesOnBeforeSelectMultipleTrackingNo ----- HEI.12,HEI.07
    // OnSelectEntriesOnAFTransferFields() ==> OnSelectEntriesOnAfterTransferFields ----- HEI.12,HEI.07

    // BC Upgrade SHUKLP03 <<
    //Bc Upgrade sharmp16-- PageFAT issue changes


    layout
    {

        modify("Qty. to Handle (Base)")
        {
            Visible = true;
        }
        modify("Qty. to Invoice (Base)")
        {
            Visible = true;
        }//Bc Upgrade sharmp16-- PageFAT issue changes
        modify("Lot No.")//Bc Upgrade sharmp16-- PageFAT issue changes
        {
            ToolTipML = ENU = 'Specifies the lot number of the item being handled for the associated document line.', FRA = 'Spécifie le numéro de lot de l''article traité avec la ligne document associée.';
            CaptionML = ENU = '<Lot No.>', FRA = 'N° lot';
            Style = Attention;
            //StyleExpr = LotStyleExpr; // BC Upgrade SHUKLP03 << DrinkIT code blocked
            Visible = true;//Bc Upgrade sharmp16-- PageFAT issue changes
            trigger OnBeforeValidate()
            begin
                //HEI.08>>
                CLEAR(EditableStrengthSpecValue);
                IF (Rec."Lot No." <> xRec."Lot No.") THEN BEGIN
                    IF ((Rec."Source Type" = DATABASE::"Item Journal Line") AND (Rec."Source Subtype" IN [Rec."Source Subtype"::"2", Rec."Source Subtype"::"5", Rec."Source Subtype"::"6"])) OR
                     ((Rec."Source Type" = DATABASE::"Purchase Line") AND (Rec."Source Subtype" = Rec."Source Subtype"::"1")) THEN BEGIN
                        // IF ItemL.GET(Rec."Item No.") AND (ItemL."Strength Spec. Code" = 'EXT.[%W/W]') AND ("Strength Spec. Value" = 0) THEN // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Strength Spec. Value" is used.
                        EditableStrengthSpecValue := TRUE;
                    end;
                end;
                //HEI.08<<
            end;

            // PATHAA02-14.07.26>>
            // Quality Fix-Added code to create lot no information when lot no is entered manually in item journal line and Inspection status should be ON HOLD.
            trigger OnAfterValidate()
            var
                ItemJnlLine: Record "Item Journal Line";
            begin
                if Rec."Lot No." = xRec."Lot No." then
                    exit;

                if Rec."Source Type" <> Database::"Item Journal Line" then
                    exit;

                IF ItemJnlLine.Get(Rec."Source ID", Rec."Source Batch Name", Rec."Source Ref. No.") and
                   (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt.") then
                    CreateLotNoInformation(Rec."Item No.", Rec."Variant Code", Rec."Lot No.", Rec."Expiration Date");
            end;
            // PATHAA02-14.07.26<<

            trigger OnAssistEdit() //Bc Upgrade YADAVM09>> base code and custom code is added on AssitEdit trigger.
            var
                MaxQuantity: Decimal;
                ItemTrackingDataCollectionC: Codeunit "Heineken BC Upgrade";
            begin
                MaxQuantity := UndefinedQtyArray[1];

                Rec."Bin Code" := ForBinCode;
                //HEI.07>>
                IF EnabledApplyFilters THEN BEGIN
                    Rec."Zone Code FND" := ForZoneCode;
                    ItemTrackingDataCollectionC.ApplyFilters;
                END;
                //HEI.07<<
                if (Rec."Source Type" = Database::"Transfer Line") and (CurrentRunMode = CurrentRunMode::Reclass) then
                    ItemTrackingDataCollection.SetDirectTransfer(true);
                ItemTrackingDataCollection.AssistEditTrackingNo(Rec,
                    DoSearchForSupply((CurrentSignFactor * SourceQuantityArray[1] < 0) and not InsertIsBlocked),
                    CurrentSignFactor, "Item Tracking Type"::"Lot No.", MaxQuantity);

                Rec."Bin Code" := '';
                //HEI.07>>
                IF EnabledApplyFilters THEN
                    Rec."Zone Code FND" := '';

                IF (Rec."Lot No." = xRec."Lot No.") AND (Rec."Lot No." = '') THEN
                    CurrPage.UPDATE(FALSE)
                ELSE
                    //HEI.07<<
                    CurrPage.Update();

            end;//YADAVM09
        }
        modify("New Lot No.")
        {

            ToolTipML = ENU = 'Specifies a new lot number that will take the place of the lot number in the Lot No. field.', FRA = 'Spécifie un nouveau numéro de lot qui remplace le numéro de lot du champ N° de lot.';
            Style = Attention;
            //StyleExpr = NewLotStyleExpr; // BC Upgrade SHUKLP03 << DrinkIT code blocked
            trigger OnAfterValidate()
            var
            begin
                //HEI.06>>
                IF (Rec."Source Type" = DATABASE::"Item Journal Line") AND (Rec."Source Subtype" = 4) THEN
                    CreateLotNoInfo(Rec."Item No.", Rec."Variant Code", Rec."New Lot No.", Rec."New Expiration Date");
                //HEI.06<<
            end;
        }
        modify("New Expiration Date")
        {
            trigger OnAfterValidate()
            var
            begin
                //HEI.06>>
                IF (Rec."Source Type" = DATABASE::"Item Journal Line") AND (Rec."Source Subtype" = 4) THEN
                    CreateLotNoInfo(Rec."Item No.", Rec."Variant Code", Rec."New Lot No.", Rec."New Expiration Date");
                //HEI.06<<


            end;
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                ItemL: Record item;
            begin
                //HEI.09>>
                IF (Rec."Source Type" = DATABASE::"Item Journal Line") AND (Rec."Source Subtype" = 4) AND (NOT VisibleItemReclass) THEN BEGIN
                    Rec.TESTFIELD("Item No.");
                    Rec.TESTFIELD("Location Code");
                    ItemL.GET(Rec."Item No.");
                    IF ItemL."Batch Number Policy FND" IN [ItemL."Batch Number Policy FND"::"Bulk Product Related Materials", ItemL."Batch Number Policy FND"::"Discrete Product Related Materials"] THEN
                        VisibleItemReclass := TRUE
                    else
                        CLEAR(VisibleItemReclass);
                end;
                //HEI.09<<
            end;
        }
        modify(AvailabilitySerialNo)
        {
            trigger OnDrillDown()
            var
                ItemTrackingDataCollectionC: Codeunit "Heineken BC Upgrade";
                LookupMode: Enum "Item Tracking Type";
            begin
                Rec."Bin Code" := ForBinCode;
                //HEI.07>>
                IF EnabledApplyFilters THEN BEGIN
                    Rec."Zone Code FND" := ForZoneCode;
                    ItemTrackingDataCollectionC.ApplyFilters();
                end;
                //HEI.07<<
                ItemTrackingDataCollection.LookupTrackingAvailability(Rec, LookupMode);
                Rec."Bin Code" := '';
                //HEI.07>>
                IF EnabledApplyFilters THEN
                    Rec."Zone Code FND" := '';
                //HEI.07<<
                CurrPage.UPDATE();
            end;
        }
        modify(AvailabilityLotNo)
        {
            trigger OnDrillDown()
            var
                ItemTrackingDataCollectionC: Codeunit "Heineken BC Upgrade";
                LookupMode: Enum "Item Tracking Type";
            begin
                Rec."Bin Code" := ForBinCode;
                //HEI.07>>
                IF EnabledApplyFilters THEN BEGIN
                    Rec."Zone Code FND" := ForZoneCode;
                    ItemTrackingDataCollectionC.ApplyFilters();
                end;
                //HEI.07<<
                ItemTrackingDataCollection.LookupTrackingAvailability(Rec, LookupMode);
                Rec."Bin Code" := '';
                //HEI.07>>
                IF EnabledApplyFilters THEN
                    Rec."Zone Code FND" := '';
                //HEI.07<<
                CurrPage.UPDATE();
            end;
        }
        modify("TrackingAvailable(Rec,2)")
        {
            trigger OnDrillDown()
            var
                ItemTrackingDataCollectionC: Codeunit "Heineken BC Upgrade";
                LookupMode: Enum "Item Tracking Type";
            begin
                Rec."Bin Code" := ForBinCode;
                //HEI.07>>
                IF EnabledApplyFilters THEN BEGIN
                    Rec."Zone Code FND" := ForZoneCode;
                    ItemTrackingDataCollectionC.ApplyFilters();
                end;
                //HEI.07<<
                ItemTrackingDataCollection.LookupTrackingAvailability(Rec, LookupMode);
                Rec."Bin Code" := '';
                //HEI.07>>
                IF EnabledApplyFilters THEN
                    Rec."Zone Code FND" := '';
                //HEI.07<<
                CurrPage.UPDATE();
            end;
        }
        // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
        // addafter("Lot No.")
        // {
        //     field("Lot Is Blocked"; LotIsBlocked)
        //     {
        //         Caption = 'Lot Is Blocked';
        //         Description = 'QXL10.01 NRQ#38351';
        //     }
        // }
        // addafter("New Lot No.")
        // {
        //     field("New Lot Blocked"; NewLotIsBlocked)
        //     {
        //         Caption = 'New Lot Blocked';
        //         Description = 'QXL10.01 NRQ#38351';
        //         Visible = NewLotNoVisible;
        //     }
        //     field("Your Reference"; "Your Reference")
        //     {
        //         Visible = "Your ReferenceVisible";
        //     }
        //     field("Creation Date"; "Creation Date")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.
        addafter("Lot No.")//Bc Upgrade sharmp16-- PageFAT issue changes
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                Editable = false;
                Visible = EnabledApplyFilters;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
            field("Bin Code"; REC."Bin Code")
            {
                Editable = EditableBin;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bin Code field.';
            }
        }

        // BC Upgrade SHUKLP03 >> DrinkIT field is blocked
        // addafter("Quantity (Base)")
        // {
        //     field("LotSCAvailableQty(Rec,0)"; LotSCAvailableQty(Rec, 0))
        //     {
        //         CaptionML = ENU = 'Quantity (Base) SSCC',
        //                 FRA = 'Quantité (Base) SSCC';
        //         DecimalPlaces = 0 : 5;
        //         Editable = false;
        //         Visible = false;

        //         trigger OnDrillDown();
        //         begin
        //             // <<DITW15.00.00.38 DDR 08/12/2010 #1139 (DIT711 92)
        //             OpenLotSSCCTrackingLines();
        //         end;
        //     }
        // }
        // addafter("Quantity Invoiced (Base)")
        // {
        //     field("Strength Spec. Code"; "Strength Spec. Code")
        //     {
        //         Editable = false;
        //     }
        //     field("Strength Spec. Value"; "Strength Spec. Value")
        //     {
        //         Editable = "Strength Spec. ValueEditable";

        //         trigger OnValidate();
        //         var
        //             QtyToHandle: Decimal;
        //         begin
        //             // <<DITW19.00.08 DDR 20/10/2016 07/11/2016 BL#10443
        //             QtyToHandle := "Quantity (Base)";
        //             if QtyToHandleBaseVisible then
        //                 QtyToHandle := "Qty. to Handle (Base)";
        //             if "Strength Spec. Code" <> '' then
        //                 "Vol-Strength Spec. Value" := CalcVolumeStrength(QtyToHandle, "Strength Spec. Value", Item."Unit Volume HL");
        //             // >>DITW19.00.08 DDR BL#10443
        //         end;
        //     }
        //     field("New Strength Spec. Value"; "New Strength Spec. Value")
        //     {
        //         Editable = "New Strength Spec. ValueEditable";
        //         Visible = "New Strength Spec. ValueVisible";

        //         trigger OnValidate();
        //         var
        //             QtyToHandle: Decimal;
        //         begin
        //             // <<DITW19.00.08 DDR 20/10/2016 07/11/2016 BL#10443
        //             QtyToHandle := "Quantity (Base)";
        //             if QtyToHandleBaseVisible then
        //                 QtyToHandle := "Qty. to Handle (Base)";
        //             if "Strength Spec. Code" <> '' then
        //                 "New Vol-Strength Spec. Value" := CalcVolumeStrength(QtyToHandle, "New Strength Spec. Value", Item."Unit Volume HL");
        //             // >>DITW19.00.08 DDR BL#10443
        //         end;
        //     }
        //     field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
        //     {
        //         Editable = false;
        //         Visible = false;
        //     }
        //     field("Vol-Strength Spec. Value"; "Vol-Strength Spec. Value")
        //     {
        //         Editable = "VStrength Spec. ValueEditable";
        //     }
        //     field("New Vol-Strength Spec. Value"; "New Vol-Strength Spec. Value")
        //     {
        //         Editable = "New VStrength Spec. ValueEditable";
        //         Visible = "New VStrength Spec. ValueVisible";
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT field is blocked
        addafter("Bin Code")//Bc Upgrade sharmp16-- PageFAT issue changes
        {
            field("KG/HL"; Rec."KG/HL FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the KG/HL field.';
            }
            field("Weight of Extract"; Rec."Weight of Extract FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Weight of Extract field.';
            }
            field("Reference No."; Rec."Reference No. FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reference No. field.';
            }
            // BC Upgrade SHUKLP03 >> DrinkIT field is blocked
            // field("New Location Code"; Rec."New Location Code")
            // {
            //     ApplicationArea = All;
            // }
            // field("New Bin Code"; Rec."New Bin Code")
            // {
            //     ApplicationArea = All;
            // }
            // BC Upgrade SHUKLP03 << DrinkIT field is blocked
        }
        moveafter("Lot No."; "Quantity (Base)")//Bc Upgrade sharmp16-- PageFAT issue changes

    }

    actions
    {
        modify("Assign Lot No.")
        {
            CaptionML = ENU = 'Assign &Lot No.', FRA = 'Affecter n° l&ot';
            //ShortCutKey = Ctrl+Alt+L;
            Promoted = true;

            //Unsupported feature: Change Visible on ""Assign Lot No."(Action 52)". Please convert manually.

            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify("Select Entries")
        {
            CaptionML = ENU = 'Select &Entries', FRA = 'Sélectionner &écritures';
            ShortCutKey = F7;

            //Unsupported feature: Change Visible on ""Select Entries"(Action 55)". Please convert manually.

        }
        addafter("Reclass_LotNoInfoCard")
        {
            action("Create Reclass Batch No.")
            {
                Image = Lot;
                Visible = VisibleItemReclass;
                ApplicationArea = All;
                ToolTip = 'Executes the Create Reclass Batch No. action.';

                trigger OnAction();
                var
                    NewLotNoL: Code[20];
                    TotalLineExtValueL: Decimal;
                    TotalQuantityBaseL: Decimal;
                    Text000L: TextConst ENU = 'Batch No. cannot be created as excess quantity %1 has been defined in Item tracking.', FRA = 'Les corrections ne peuvent être enregistrées car vous avez indiqué une quantité excessive.\Souhaitez-vous tout de même fermer le formulaire ?';
                    Text001L: TextConst ENU = 'Batch No. cannot be created as lesser quantity %1 has been defined in Item tracking.', FRA = 'La quantité traçabilité totale %1 dépasse la quantité %2 %3.\Les modifications ne peuvent être enregistrées dans la base de données.';
                begin
                    //HEI.09>>
                    CLEAR(UpdatedNewLotNo);
                    // Rec.TESTFIELD(Rec."New Bin Code"); // BC Upgrade SHUKLP03 << DrinkIT field "New Bin Code" is blocked
                    Rec.TESTFIELD("Lot No.");
                    Rec.TESTFIELD("Quantity (Base)");
                    if not UpdateUndefinedQty() then
                        ERROR(Text000L, ABS(UndefinedQtyArray[1]))
                    else if UndefinedQtyArray[1] > 0 then
                        ERROR(Text001L, ABS(UndefinedQtyArray[1]));

                    NewLotNoL := CreateNewLotNo();
                    if NewLotNoL <> '' then begin
                        if Rec.COUNT = 1 then
                            Rec.VALIDATE("New Lot No.", NewLotNoL)
                        else begin
                            if Rec.FIND('-') then begin
                                repeat
                                    Rec.TESTFIELD("Lot No.");
                                    Rec.TESTFIELD("Quantity (Base)");
                                    Rec.VALIDATE("New Lot No.", NewLotNoL);

                                    // BC Upgrade SHUKLP03 >> Code blocked because DrinkIT field "Strength Spec. Value" is used.
                                    // //HEI.12>>
                                    // TotalLineExtValueL += Rec."Quantity (Base)" * Rec."Strength Spec. Value";
                                    // TotalQuantityBaseL += Rec."Quantity (Base)";
                                    // //HEI.12<<
                                    // BC Upgrade SHUKLP03 << Code blocked because DrinkIT field "Strength Spec. Value" is used.

                                    Rec.MODIFY(true);
                                    if not TempItemTrackLineModify.GET(Rec."Entry No.") then begin
                                        TempItemTrackLineModify.INIT();
                                        TempItemTrackLineModify.TRANSFERFIELDS(Rec);
                                        TempItemTrackLineModify.INSERT();
                                    end else begin
                                        TempItemTrackLineModify.TRANSFERFIELDS(Rec);
                                        TempItemTrackLineModify.MODIFY();
                                    end;
                                until Rec.NEXT() = 0;
                            end;
                            // BC Upgrade SHUKLP03 >> Code blocked because DrinkIT field "New Strength Spec. Value" is used.
                            // //HEI.12>>
                            // if Rec.findset then begin
                            //   repeat
                            //     "New Strength Spec. Value" := TotalLineExtValueL / TotalQuantityBaseL;
                            //     Rec.MODIFY;
                            //   until NEXT = 0;
                            // end;
                            // if TempItemTrackLineModify.findset then begin
                            //   repeat
                            //     TempItemTrackLineModify."New Strength Spec. Value" := TotalLineExtValueL / TotalQuantityBaseL;
                            //     TempItemTrackLineModify.MODIFY;
                            //   until TempItemTrackLineModify.NEXT = 0;
                            // end;
                            // //HEI.12<<
                            // BC Upgrade SHUKLP03 << Code blocked because DrinkIT field "New Strength Spec. Value" is used.
                        end;
                        UpdatedNewLotNo := true;
                    end;
                    //HEI.09<<
                end;
            }
        }
        // BC Upgrade SHUKLP03 >> DrinkIT action is blocked.
        // addafter("Line_LotNoInfoCard")
        // {
        //     separator(Separator2035090)
        //     {
        //     }
        //     action("Quality Test")
        //     {
        //         CaptionML = ENU='Quality Test',
        //                     FRA='Test qualité';
        //         Image = "Table";

        //         trigger OnAction();
        //         var
        //             lrQualityManagement : Codeunit "Quality Management";
        //         begin
        //             lrQualityManagement.LaunchTestCardFromTracking(Rec);
        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT action is blocked.
        addafter("Refresh Availability")
        {
            action("Create Batch Number")
            {
                Caption = 'Create Batch Number';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+Alt+L';
                Visible = FunctionsSupplyVisible;
                ApplicationArea = All;
                ToolTip = 'Executes the Create Batch Number action.';

                trigger OnAction();
                begin
                    if InsertIsBlocked then
                        exit;
                    AssignLotNo_Batch();  //HEI.02 NAIKH01
                    CreateLotNoInformation(Rec."Item No.", Rec."Variant Code", Rec."Lot No.", Rec."Expiration Date"); //PATHAA02 30.04.26 //PATHAA02 GAP014_DTW, IBM GAP DTW 43  
                end;
            }
            // BC Upgrade SHUKLP03 >> DrinkIT action is blocked.
            // group(SSCC)
            // {
            //     CaptionML = ENU='SSCC',
            //                 FRA='SSCC';
            //     Visible = FunctionsSupplyVisible;
            //     action("SSCC Tracking Lines")
            //     {
            //         CaptionML = ENU='SSCC Tracking Lines',
            //                     FRA='Lignes Traçabilité SSCC';
            //         Image = ItemTrackingLines;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         Visible = FunctionsSupplyVisible;

            //         trigger OnAction();
            //         begin
            //             // <<DITW15.00.00.38 DDR 14/10/2010 #1139
            //             OpenLotSSCCTrackingLines();
            //         end;
            //     }
            // }

            // group(Quality)
            // {
            //     CaptionML = ENU='Quality',
            //                 FRA='Qualité';
            //     Visible = FunctionsSupplyVisible;
            //     action("Create &Quality Test")
            //     {
            //         CaptionML = ENU='Create &Quality Test',
            //                     FRA='Créer test qualité';
            //         Image = TaskQualityMeasure;

            //         trigger OnAction();
            //         begin
            //             //<<QXL9.00.001 DAT 23/03/2016
            //             QualityCreateLotTest(false);
            //             //>>QXL9.00.001 DAT 23/03/2016
            //         end;
            //     }
            //     action("Create Ad Hoc Quality Test")
            //     {
            //         CaptionML = ENU='Create Ad Hoc Quality Test',
            //                     FRA='Créer test qualité Ad Hoc';
            //         Image = TaskQualityMeasure;

            //         trigger OnAction();
            //         begin
            //             //<<QXL9.00.001 DAT 23/03/2016
            //             QualityCreateLotTest(true);
            //             //>>QXL9.00.001 DAT 23/03/2016
            //         end;
            //     }
            // }
            // BC Upgrade SHUKLP03 << DrinkIT action is blocked.
        }
        // addafter("Assign &Lot No.")
        // {
        //     separator(Separator1100083007)
        //     {
        //     }
        // }
        // addafter(CreateCustomizedSN)
        // {
        //     separator(Separator1100083008)
        //     {
        //     }
        // }
        // BC Upgrade SHUKLP03 >> DrinkIT action is blocked.
        // addafter(FunctionsDemand)
        // {
        //     group(ActionGroup1100066000)
        //     {
        //         CaptionML = ENU='SSCC',
        //                     FRA='SSCC';
        //         Visible = FunctionsDemandVisible;
        //         action(Action1100083014)
        //         {
        //             CaptionML = ENU='SSCC Tracking Lines',
        //                         FRA='Lignes Traçabilité SSCC';
        //             Image = ItemTrackingLines;
        //             Promoted = true;
        //             PromotedCategory = Process;
        //             Visible = FunctionsDemandVisible;

        //             trigger OnAction();
        //             begin
        //                 // <<DITW15.00.00.38 DDR 14/10/2010 #1139
        //                 OpenLotSSCCTrackingLines();
        //             end;
        //         }
        //     }
        //     group(ActionGroup2035094)
        //     {
        //         CaptionML = ENU='Quality',
        //                     FRA='Qualité';
        //         Visible = FunctionsDemandVisible;
        //         action(Action2035095)
        //         {
        //             CaptionML = ENU='Create &Quality Test',
        //                         FRA='Créer test qualité';
        //             Image = TaskQualityMeasure;

        //             trigger OnAction();
        //             begin
        //                 //<<QXL9.00.001 DAT 23/03/2016
        //                 QualityCreateLotTest(false);
        //                 //>>QXL9.00.001 DAT 23/03/2016
        //             end;
        //         }
        //         action(Action2035096)
        //         {
        //             CaptionML = ENU='Create Ad Hoc Quality Test',
        //                         FRA='Créer test qualité Ad Hoc';
        //             Image = TaskQualityMeasure;

        //             trigger OnAction();
        //             begin
        //                 //<<QXL9.00.001 DAT 23/03/2016
        //                 QualityCreateLotTest(true);
        //                 //>>QXL9.00.001 DAT 23/03/2016
        //             end;
        //         }
        //         action(Action2035097)
        //         {
        //             CaptionML = ENU='Quality Test',
        //                         FRA='Test qualité';
        //             Image = TaskQualityMeasure;

        //             trigger OnAction();
        //             var
        //                 lrQualityManagement : Codeunit "Quality Management";
        //             begin
        //                 lrQualityManagement.LaunchTestCardFromTracking(Rec);
        //             end;
        //         }
        //     }
        //}
        // BC Upgrade SHUKLP03 << DrinkIT action is blocked.
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.07>>
        EnabledApplyFilters := FALSE;
        EditableBin := TRUE;
        //HEI.07<<
        //HEI.09>>
        VisibleItemReclass := FALSE;
        //HEI.09<<

        //HEI.07>>
        IF EnabledApplyFilters THEN BEGIN
            LocationCodeEditable := FALSE;
            EditableBin := FALSE;
        end;
        //HEI.07<<
    end;

    procedure OnBFInsertRecord(TrackingSpecificationR: Record "Tracking Specification")
    var
    begin
        //HEI.07>>
        IF EnabledApplyFilters THEN
            TrackingSpecificationR."Zone Code FND" := ForZoneCode;
        //HEI.07<<
        //HEI.04>>
        IF TrackingSpecificationR."Quantity (Base)" = 0 THEN BEGIN
            TrackingSpecificationR.VALIDATE("Quantity (Base)", SourceQuantityArray[1]);
            IF (TrackingSpecificationR."Qty. to Handle (Base)" <> SourceQuantityArray[2]) THEN
                TrackingSpecificationR.VALIDATE("Qty. to Handle (Base)", SourceQuantityArray[2]);
        end;
        //HEI.04<<
    end;

    procedure OnBFOnModifyRecord(var TrackingSpecificationR: Record "Tracking Specification")
    begin
        //HEI.07>>
        IF EnabledApplyFilters THEN BEGIN
            TrackingSpecificationR."Zone Code FND" := ForZoneCode;
            TrackingSpecificationR."Bin Code" := ForBinCode;
        end;
        //HEI.07<<
    end;

    procedure OnBFClosePage(SkipWriteToDatabaseC: Boolean; CurrentRunModeC: Enum "Item Tracking Run Mode"; CurrentSourceTypeC: Integer)
    begin
        //HEI.07>>
        IF EnabledApplyFilters THEN begin
            SkipWriteToDatabaseC := true;
            CurrentRunModeC := CurrentRunModeC::Reclass;
            CurrentSourceTypeC := Database::"Transfer Line";
        end;
        //HEI.07<<
    end;

    procedure OnBFSynchronizeWarehouseItemTracking(var IsHandled: Boolean)
    begin
        //HEI.07>>
        IF EnabledApplyFilters THEN
            IsHandled := true;
        //HEI.07<<
    end;

    procedure OnAFOnClosePage(CurrentRunModeOrg: Enum "Item Tracking Run Mode"; CurrentSourceTypeOrg: Integer)
    var
        ReservEntry: Record "Reservation Entry";
        TransferTracking: Record "Tracking Specification";
        HeinekenGlobal: Codeunit "Heineken Global";
    begin
        IF EnabledApplyFilters THEN begin
            CurrentSourceType := CurrentSourceTypeOrg;
            CurrentRunMode := CurrentRunModeOrg;
            Exit;
        end;


        //<< HEI.01 NAIKH01
        IF (Rec."Source Type" = 5407) AND (Rec."Source Subtype" = 3) THEN BEGIN
            ReservEntry.RESET();
            ReservEntry.SETCURRENTKEY("Source ID", "Item No.", "Source Prod. Order Line", "Source Ref. No.", "Source Type", "Source Subtype", "Lot No.");
            ReservEntry.SETRANGE("Source ID", Rec."Source ID");
            ReservEntry.SETRANGE("Item No.", Rec."Item No.");
            ReservEntry.SETRANGE("Source Prod. Order Line", Rec."Source Prod. Order Line");
            ReservEntry.SETRANGE("Source Ref. No.", Rec."Source Ref. No.");
            ReservEntry.SETRANGE("Source Type", 5407);
            ReservEntry.SETRANGE("Source Subtype", 3);
            ReservEntry.SETFILTER("Lot No.", '<>%1', '');
            IF ReservEntry.findset() THEN
                HeinekenGlobal.UpdateConsumptionEntryByLot(ReservEntry);
        end;

    end;
    //>> HEI.01 NAIKH01

    trigger OnAfterGetCurrRecord()
    begin
        //HEI.08>>
        IF EditableStrengthSpecValue AND (NOT "Strength Spec. ValueEditable") THEN
            "Strength Spec. ValueEditable" := EditableStrengthSpecValue;
        //HEI.08<<
    end;

    procedure OnBFQueryClosePage(var TrackingSpecification: Record "Tracking Specification")
    var
        CloseAction: Action;
        Text000L: TextConst ENU = 'There is still Undefined Quantity %1. Please selsect Lot and Quantity correctly.';
        Text001L: TextConst ENU = 'The Lot No. - %1 has an Extract Content [%w/w] Value = 0.00. Would you like to proceed?';
    begin
        //HEI.07>>
        IF EnabledApplyFilters AND Rec.findset() THEN BEGIN
            IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
                IF UndefinedQtyArray[1] <> 0 THEN
                    ERROR(Text000L, UndefinedQtyArray[1])
                else
                    AssignLots(Rec);
                EXIT;
            end else
                EXIT;
        end;
        //HEI.07<<

        // BC Upgrade SHUKLP03 >> Code blocked because DrinkIT field "Strength Spec. Value" is used.
        // //HEI.08>>
        // IF (CloseAction IN [ACTION::OK, ACTION::LookupOK]) THEN BEGIN
        //     IF ((Rec."Source Type" = DATABASE::"Item Journal Line") AND (Rec."Source Subtype" IN [Rec."Source Subtype"::"2", Rec."Source Subtype"::"5", Rec."Source Subtype"::"6"])) OR
        //      ((Rec."Source Type" = DATABASE::"Purchase Line") AND (Rec."Source Subtype" = Rec."Source Subtype"::"1")) THEN BEGIN
        //         IF (Rec."Lot No." <> '') AND (Rec."Strength Spec. Value" = 0) THEN BEGIN
        //             IF EditableStrengthSpecValue THEN BEGIN
        //                 IF NOT CONFIRM(Text001L, FALSE, Rec."Lot No.") THEN
        //                     ERROR('');
        //             end else BEGIN
        //                 IF ItemL.GET(Rec."Item No.") AND (ItemL."Strength Spec. Code" = 'EXT.[%W/W]') THEN BEGIN
        //                     IF NOT CONFIRM(Text001L, FALSE, Rec."Lot No.") THEN
        //                         ERROR('');
        //                 end;
        //             end;
        //         end;
        //     end;
        // end;
        // //HEI.08<<
        // BC Upgrade SHUKLP03 >> Code blocked because DrinkIT field "Strength Spec. Value" is used.


        ProdOrderLineHandling := HeinekenGlobal.CheckProdOrdBackwardFlushing(Rec);  //HEI.03
    end;

    procedure OnQueryClosePageOnBFCurrPageUpdate(): Boolean
    Begin
        //HEI.09>>
        IF NOT (VisibleItemReclass OR UpdatedNewLotNo) THEN begin
            CurrPage.UPDATE();
            exit(true);
        end;
        exit(false);
        //HEI.09<<
    End;

    procedure OnBFLotNoAssistEdit(var TrackingSpecificationR: Record "Tracking Specification")
    var
        ItemTrackingDataCollectionC: Codeunit "Heineken BC Upgrade";
    Begin
        //HEI.07>>
        IF EnabledApplyFilters THEN BEGIN
            TrackingSpecificationR."Zone Code FND" := ForZoneCode;
            ItemTrackingDataCollectionC.ApplyFilters();
        end;
        //HEI.07<<
    End;

    procedure OnAFMoveFields(var ReservEntry1: Record "Reservation Entry"; var TrackingSpecification: Record "Tracking Specification")
    Begin
        //HEI.07>>
        IF EnabledApplyFilters THEN BEGIN
            ReservEntry1."Location Code" := TrackingSpecification."Location Code";
            ReservEntry1."Zone Code FND" := TrackingSpecification."Zone Code FND";
            //ReservEntry1."Bin Code" := TrackingSpecification."Bin Code"; // BC Upgrade SHUKLP03 << DrinkIT field "Bin Code" is blocked.
        end;
        //HEI.07<<
    End;

    procedure OnAFAssignNewTrackingNo(var TrkgSpec: Record "Tracking Specification")
    begin
        //HEI.07>>
        IF EnabledApplyFilters THEN
            TrkgSpec."Zone Code FND" := ForZoneCode;
        //HEI.07<<
    end;

    procedure OnSelectEntriesOnBFSelectMultipleTrackingNo()
    var
        ItemTrackingDataCollectionC: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.07>>
        IF EnabledApplyFilters THEN BEGIN
            Rec."Zone Code FND" := ForZoneCode;
            ItemTrackingDataCollectionC.ApplyFilters();
        end;
        //HEI.07<<
        //HEI.12>>
        SetValues(ForNewLocationCode, ForNewBinCode);
        //HEI.12<<
    end;

    procedure OnSelectEntriesOnAFTransferFields()
    Begin
        //HEI.07>>
        IF EnabledApplyFilters THEN
            Rec."Zone Code FND" := '';
        //HEI.07<<
        //HEI.12>>
        SetValues('', '');
        //HEI.12<<
    End;

    var
        ItemL: Record Item;
        ReservEntry: Record "Reservation Entry";
        TransferTracking: Record "Tracking Specification";
        Text000L: Label 'There is still Undefined Quantity %1. Please selsect Lot and Quantity correctly.';
        SourceEntryType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output,,,,Warehouse,Production,Movement;
        Text001L: TextConst ENU = 'The Lot No. - %1 has an Extract Content [%w/w] Value = 0.00. Would you like to proceed?';

    // StrengthCode: Code[20];
    // StrengthValue: Decimal;
    // VStrengthCode: Code[20];
    // VStrengthValue: Decimal;
    // SSCCTrackingForm: Page "SSCC Tracking Lines";
    // TempItemTrackLineDeleteQlty: Record "Tracking Specification" temporary;

    var
        recItem: Record Item;
        ItemJrnlLine: Record "Item Journal Line";
        recItemTracking: Record "Item Tracking Code";
        LotNoInfo: Record "Lot No. Information";
        ProdComponent: Record "Prod. Order Component";
        recProdOrder: Record "Production Order";
        TempReservEntry: Record "Reservation Entry";
        SerialNoInfo: Record "Serial No. Information";
        ItemTrackingLineOpen: Record "Tracking Specification";
        //SSCCTrackingMgt: Codeunit "SSCC Tracking Management";
        //recFINXLSetup: Record "Finance XL Setup";
        recTrackingSpecification: Record "Tracking Specification";
        xTempItemTrackingLine: Record "Tracking Specification";
        HeinekenGlobal: Codeunit "Heineken Global";
        //QualityTestHeader: Record "Quality Test Header";
        //QualityManagement: Codeunit "Quality Management";
        //CreateLotTest: Codeunit "Create Lot Test";
        //BrewingManagement: Codeunit "Brewing Management";
        ApplyActuals: Boolean;
        EditableBin: Boolean;
        EditableStrengthSpecValue: Boolean;
        //HeinekenGlobal: Codeunit "Heineken Global";
        EnabledApplyFilters: Boolean;
        ForLotInfoRequired: Boolean;
        ForLotRequired: Boolean;
        ForSCRequired: Boolean;
        ForSNInfoRequired: Boolean;
        ForSNRequired: Boolean;

        LotStyleExpr: Boolean;

        NewLotStyleExpr: Boolean;

        "New Strength Spec. ValueEditable": Boolean;

        "New Strength Spec. ValueVisible": Boolean;

        "New VStrength Spec. ValueEditable": Boolean;

        "New VStrength Spec. ValueVisible": Boolean;
        ProdOrderLineHandling: Boolean;
        SkipDeleteCurrentLines: Boolean;

        "Strength Spec. ValueEditable": Boolean;
        UpdatedNewLotNo: Boolean;
        VisibleItemReclass: Boolean;

        "VStrength Spec. ValueEditable": Boolean;
        WhseManaged: Boolean;

        "Your ReferenceVisible": Boolean;
        //QualitySetup: Record "Quality Setup";
        //BeverageSetup: Record "Production Setup";
        ForNewLocationCode: Code[10];
        ForZoneCode: Code[10];
        ForNewBinCode: Code[20];
        AvailabilityDateGlobal: Date;
        datCreationDate: Date;
        PostingDate: Date;
        SecondSourceQuantityArrayOpen: array[3] of Decimal;
        CurrSessionID: Guid;
        SecondSourceTable: Integer;
        FormRunMode: Option ,Reclass,"Combined Ship/Rcpt","Drop Shipment",Transfer;
        //SCReservEngineMgt: Codeunit "SSCC Reservation Engine Mgt.";
        FormRunModeSSCC: Option Normal,Reverse;
        CallFormRunMode: Option Reclass,"Combined Ship/Rcpt","Drop Shipment",Transfer;
        Text015: TextConst ENU = 'Do you want to synchronize item tracking on the line with item tracking on the related drop shipment %1?', FRA = 'Souhaitez-vous synchroniser la traçabilité de la ligne avec la traçabilité de la livraison directe %1 associée ?';
        Text016: TextConst ENU = 'purchase order line', FRA = 'ligne commande achat';
        Text017: TextConst ENU = 'sales order line', FRA = 'ligne commande vente';
        Text2035040: TextConst ENU = 'One or more SSCC tracking are defined for the lot no. %1 and you must update the existing lines manually.', FRA = 'Une ou plusieurs ligne(s) de traçabilité SSCC existent pour le n° lot %1 et vous devez metre manuellement à jour les lignes existantes.';
        Text2035041: TextConst ENU = 'The corrections cannot be saved as excess quantity has been defined.', FRA = 'Les corrections ne peuvent être enregistrées car vous avez indiqué une quantité excessive.';
        Text2035042: TextConst ENU = '%1 of Lot No. %2 cannot be less than the total SSCC Tracking Lines.', FRA = '%1 du lot n ° %2 ne peut pas être inférieur au total des lignes traçabilité SSCC.';
        Text2035090: TextConst ENU = 'Unable to execute the function (create Quality Test) because New Location and/or New Bin are missing. ', FRA = 'Impossible d''exécuter la fonction (créer Test de Qualité) car le nouveau code magasin et/ou code emplacement sont manquant. ';
        // SSCCSetup: Record "SSCC Setup";
        // SCLineReserv: Codeunit "SSCC Line-Reserve";
        Text2035091: TextConst ENU = 'You cannot change the item tracking line %1 %2, because one or more Quality test with %3 ''%4'' exist.', FRA = 'Vous ne pouvez pas changer la ligne traçabilité %1 %2, car il existe au moins un test qualité avec %3 ''%4''.';
        Text2035092: TextConst ENU = 'This item tracking line %1 %2 is linked to one or more quality tests. Do you want to continue anyway?', FRA = 'Cette ligne traçabilité %1 %2 est lié à un ou plusieurs tests de qualité. Souhaitez-vous continuer quand même?';
        Text2035093: TextConst ENU = 'This item tracking line %1 %2 is linked to the quality test %3 in progress. Do you want to continue anyway?', FRA = 'Cette ligne traçabilité %1 %2 est lié au test de qualité %3 en cours de travail. Souhaitez-vous continuer quand même?';
        Text2035094: TextConst ENU = 'Unable to execute the function (create Quality Test) because %1 and/or %2 are missing.', FRA = 'Impossible d''exécuter la fonction (créer Test de Qualité) car le %1 et/ou %2 sont manquant.';


    // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
    // procedure SetCustomControls();
    // begin
    //     // <<DITW15.00.00.22 PRODW14.00.00.08.08 DDR 09/07/2008 -  DITW19.00.08 DDR 29/09/2016 BL#10443
    //     "Your ReferenceVisible" :=
    //       ("Source Type" = 83) and ("Source Subtype" = 0) or ("Source Subtype" = 2);
    //     // >>DITW15.00.00.22 PRODW14.00.00.08.08 DDR - DITW19.00.08 DDR BL#10443
    // end;

    // procedure PopulateTrackingFromActuals(var CompTrackingEntry: Record "Comp. Tracking Entry");
    // var
    //     TempTrackingSpec: Record "Tracking Specification" temporary;
    // begin
    //     //DOC UK-PROD JAD 29/08/08 -

    //     // <<DITW15.00.00.22 PRODW14.00.00.08.08 DDR 09/07/2008
    //     ApplyActuals := true;
    //     CurrentFormIsOpen := true;
    //     CurrPage.EDITABLE(false);

    //     with CompTrackingEntry do begin

    //         repeat
    //             TempTrackingSpec.INIT;
    //             TempTrackingSpec."Entry No." := CompTrackingEntry."Entry No.";
    //             TempTrackingSpec.VALIDATE("Item No.", CompTrackingEntry."Item No.");
    //             TempTrackingSpec."Location Code" := CompTrackingEntry."Location Code";
    //             TempTrackingSpec.VALIDATE("Quantity (Base)", ABS(CompTrackingEntry."Quantity (Base)"));
    //             TempTrackingSpec."Source Type" := CompTrackingEntry."Source Type";
    //             TempTrackingSpec."Source Subtype" := CompTrackingEntry."Source Subtype";
    //             TempTrackingSpec."Source ID" := CompTrackingEntry."Source ID";
    //             TempTrackingSpec."Source Prod. Order Line" := CompTrackingEntry."Source Prod. Order Line";
    //             TempTrackingSpec."Source Ref. No." := CompTrackingEntry."Source Ref. No.";
    //             TempTrackingSpec."Qty. per Unit of Measure" := CompTrackingEntry."Qty. per Unit of Measure";
    //             TempTrackingSpec."Lot No." := CompTrackingEntry."Lot No.";
    //             TempTrackingSpec."Variant Code" := CompTrackingEntry."Variant Code";
    //             TempTrackingSpec.Positive := CompTrackingEntry.Positive;
    //             TempItemTrackLineInsert.TRANSFERFIELDS(TempTrackingSpec);
    //             TempItemTrackLineInsert.INSERT();
    //             TempTrackingSpec.INSERT;
    //             BrewingManagement.TransferGyleNo(TempTrackingSpec);
    //         until CompTrackingEntry.NEXT = 0;

    //         TempTrackingSpec.CALCSUMS(TempTrackingSpec."Quantity (Base)",
    //           TempTrackingSpec."Qty. to Handle (Base)",
    //           TempTrackingSpec."Qty. to Invoice (Base)");
    //         TotalItemTrackingLine := TempTrackingSpec;

    //         SetSourceSpec(TempTrackingSpec, WORKDATE);
    //         CalculateSums;

    //         WriteToDatabase;
    //         COMMIT;

    //     end;

    //     //--------------------NEW CODE endS
    //     //DOC UK-PROD JAD 29/08/08 +
    // end;

    // procedure SetSessionID(NewSessionID: Guid);
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     CurrSessionID := NewSessionID;
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // procedure SetNewSource(NewLocationCode: Code[10]; NewBinCode: Code[20]);
    // begin
    //     // <<DITW15.00.00.37 PRODW14.00.00.08.16 DDR 21/06/2010
    //     ForNewLocationCode := NewLocationCode;
    //     ForNewBinCode := NewBinCode;
    // end;

    // local procedure QualityCreateLotTest(ForAdHocTest: Boolean);
    // var
    //     CreateLotTestYesNo: Codeunit "Create Lot Test (Yes/No)";
    //     CreateAdHocLotTestYesNo: Codeunit "Create AdHoc Lot Test (Yes/No)";
    //     TempNewItemTrackingLine: Record "Tracking Specification" temporary;
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     TempNewItemTrackingLine := Rec;
    //     TempNewItemTrackingLine."Session ID" := CurrSessionID;
    //     if QualitySetup.READPERMISSION and (TempNewItemTrackingLine."Quantity (Base)" <> 0) then begin
    //         if FormRunMode = FormRunMode::Reclass then begin
    //             if (ForNewLocationCode = '') and (ForNewBinCode = '') then
    //                 ERROR(Text2035090);
    //             if (TempNewItemTrackingLine."New Lot No." = '') and (TempNewItemTrackingLine."New Serial No." = '') then
    //                 ERROR(Text2035094, FIELDCAPTION("New Lot No."), FIELDCAPTION("New Serial No."));
    //             TempNewItemTrackingLine."New Location Code" := ForNewLocationCode;
    //             TempNewItemTrackingLine."New Bin Code" := ForNewBinCode;
    //         end else begin
    //             if (CurrentSignFactor < 0) then
    //                 exit;
    //             if (TempNewItemTrackingLine."Lot No." = '') and (TempNewItemTrackingLine."Serial No." = '') then
    //                 ERROR(Text2035094, FIELDCAPTION("Lot No."), FIELDCAPTION("Serial No."));
    //         end;
    //         if ForAdHocTest then
    //             CreateAdHocLotTestYesNo.RUN(TempNewItemTrackingLine)
    //         else
    //             CreateLotTestYesNo.RUN(TempNewItemTrackingLine);
    //     end;
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // procedure OpenLotSSCCTrackingLines();
    // var
    //     NewFormRunMode: Integer;
    //     NewSecondSourceRowID: Text[100];
    //     ItemTrackingLineOpen2: Record "Tracking Specification" temporary;
    //     AvailabilityDate: Date;
    //     LastTempRec: Record "Tracking Specification" temporary;
    // begin
    //     // <<DITW15.00.00.38 DDR 14/10/2010 - 16/11/2010 - 29/11/2010 - 02/12/2010 #1139
    //     TESTFIELD("Lot No.");
    //     SSCCSetup.GET;

    //     // commit before calling SSCC tracking form
    //     // <<DITW16.00.00.40 DDR 20/12/2011 #1309 - 14/06/2012 DIT-715 #361
    //     CurrPage.SAVERECORD;
    //     // >>DITW16.00.00.40 DDR #1309 - DIT-715 #361

    //     // Form - OnQueryCloseForm() : Boolean
    //     if not UpdateUndefinedQty then begin
    //         MESSAGE(Text2035041);
    //         exit;
    //     end;
    //     ItemTrackingDataCollection.RefreshLotSNAvailability(Rec, false);

    //     // Form - OnCloseForm()
    //     if UpdateUndefinedQty then
    //         WriteToDatabase;
    //     if FormRunMode = FormRunMode::"Drop Shipment" then
    //         case CurrentSourceType of
    //             DATABASE::"Sales Line":
    //                 SynchronizeLinkedSources(STRSUBSTNO(Text015, Text016));
    //             DATABASE::"Purchase Line":
    //                 SynchronizeLinkedSources(STRSUBSTNO(Text015, Text017));
    //         end;
    //     if FormRunMode = FormRunMode::Transfer then
    //         SynchronizeLinkedSources('');

    //     // <<DITW16.00.00.40 DDR 12/06/2012 DIT-715 #304
    //     COMMIT;
    //     // >>DITW16.00.00.40 DDR DIT-715 #304

    //     // calling tracking form
    //     NewFormRunMode := FormRunMode;
    //     NewSecondSourceRowID := SecondSourceRowID;
    //     ItemTrackingLineOpen2 := Rec;
    //     // <<DITW16.00.00.40 DDR 22/05/2012 DIT-715 #292
    //     ItemTrackingLineOpen2."Location Code" := ItemTrackingLineOpen."Location Code";
    //     ItemTrackingLineOpen2."Bin Code" := ItemTrackingLineOpen."Bin Code";
    //     // >>DITW16.00.00.40 DDR DIT-715 #292
    //     //HEI.07>>
    //     if EnabledApplyFilters then
    //         ItemTrackingLineOpen2."Zone Code" := ItemTrackingLineOpen."Zone Code";
    //     //HEI.07<<

    //     if CurrentSignFactor < 0 then
    //         AvailabilityDate := ShipmentDate
    //     else
    //         AvailabilityDate := ExpectedReceiptDate;

    //     // Synchronization of outbound transfer order:
    //     if ("Source Type" = DATABASE::"Transfer Line") and
    //        ("Source Subtype" = 0) and
    //        (CallFormRunMode <> FormRunMode)
    //     then begin
    //         NewFormRunMode := CallFormRunMode;
    //         NewSecondSourceRowID := '';
    //     end;

    //     if ("Source Type" = DATABASE::"Transfer Line") and
    //        ("Source Subtype" = 1)
    //     then begin
    //         ItemTrackingLineOpen2."Source Ref. No." := ItemTrackingLineOpen."Source Ref. No.";
    //         ItemTrackingLineOpen2."Source Prod. Order Line" := ItemTrackingLineOpen2."Source Prod. Order Line";
    //     end;

    //     if SecondSourceTable = 0 then begin
    //         if ABS(ItemTrackingLineOpen2."Qty. to Handle (Base)") > ABS(ItemTrackingLineOpen."Qty. to Handle (Base)") then
    //             ItemTrackingLineOpen2."Qty. to Handle (Base)" := ItemTrackingLineOpen."Qty. to Handle (Base)";
    //     end;
    //     if ABS(ItemTrackingLineOpen2."Qty. to Invoice (Base)") > ABS(ItemTrackingLineOpen."Qty. to Handle (Base)") then
    //         ItemTrackingLineOpen2."Qty. to Invoice (Base)" := ItemTrackingLineOpen."Qty. to Invoice (Base)";

    //     // <<DITW15.00.00.38 DDR 29/11/2010 #1139
    //     ItemTrackingLineOpen2."New Lot No." := "New Lot No.";
    //     ItemTrackingLineOpen2."New Location Code" := "New Location Code";
    //     ItemTrackingLineOpen2."New Bin Code" := "New Bin Code";
    //     ItemTrackingLineOpen2."New Expiration Date" := "New Expiration Date";
    //     ItemTrackingLineOpen2."Expiration Date" := "Expiration Date";
    //     ItemTrackingLineOpen2."Warranty Date" := "Warranty Date";

    //     SCLineReserv.CallSSCCTracking(ItemTrackingLineOpen2, NewFormRunMode, 0, NewSecondSourceRowID, SecondSourceTable, Inbound);

    //     // Refresh all lines (like open this item tracking form)
    //     LastTempRec := Rec;
    //     RESET;
    //     DELETEALL;
    //     TempItemTrackLineReserv.RESET;
    //     TempItemTrackLineReserv.DELETEALL;
    //     xTempItemTrackingLine.RESET;
    //     xTempItemTrackingLine.DELETEALL;
    //     TempReservEntry.RESET;
    //     TempReservEntry.DELETEALL;
    //     SetSourceSpec(ItemTrackingLineOpen, AvailabilityDate);
    //     // <<DITW16.00.00.43 DDR 10/10/2013 DIT-715 #745
    //     SetSecondSourceQuantity(SecondSourceQuantityArrayOpen);
    //     // >>DITW16.00.00.43 DDR DIT-715 #745
    //     SETRANGE("Lot No.");
    //     SETRANGE("Serial No.");
    //     Rec := LastTempRec;
    //     if not FIND('=<') then
    //         INIT;
    //     CalculateSums();
    //     UpdateUndefinedQty;
    //     CurrPage.UPDATE(false);
    // end;

    // local procedure ExistSSCCTrackingLines(var CurrTempTrackingSpecification: Record "Tracking Specification" temporary): Boolean;
    // begin
    //     // <<DITW15.00.00.38 DDR 25/10/2010 - 29/11/2010 #1139
    //     if SSCCSetup.READPERMISSION or (CurrTempTrackingSpecification."Lot No." = '') then
    //         exit(
    //           SCLineReserv.ReservEntryExistQty(CurrTempTrackingSpecification));
    // end;

    // local procedure SynchronizeLinkedSourcesSSCC(DialogText: Text[250]): Boolean;
    // var
    //     SCTrackingMgt: Codeunit "SSCC Tracking Management";
    //     TCurrentSourceRowID: Text[100];
    // begin
    //     // <<DITW15.00.00.38 DDR 25/10/2010 #1139
    //     if SSCCSetup.READPERMISSION then begin
    //         if CurrentSourceRowID <> '' then
    //             TCurrentSourceRowID := CurrentSourceRowID
    //         else
    //             TCurrentSourceRowID := ItemTrackingMgt.ComposeRowID(
    //               "Source Type", "Source Subtype", "Source ID",
    //               "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");

    //         if TCurrentSourceRowID <> '' then begin
    //             SCTrackingMgt.SynchronizeSSCCTrackingSrc(TCurrentSourceRowID, TCurrentSourceRowID, DialogText);
    //             exit(true);
    //         end;
    //     end;
    // end;

    // local procedure SynchronizeLinkedSourcesSSCC2(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification"; ChangeType: Option Insert,Modify,FullDelete,PartDelete,ModifyAll; ModifySharedFields: Boolean): Boolean;
    // var
    //     SCTempReservEntry: Record "SSCC Reservation Entry" temporary;
    //     SCNewTrackingSpecification: Record "SSCC Tracking Specification" temporary;
    //     SCOldTrackingSpecification: Record "SSCC Tracking Specification" temporary;
    //     SCReservEntry: Record "SSCC Reservation Entry";
    //     SCTrackingForm: Page "SSCC Tracking Lines";
    //     SCReservMgt: Codeunit "SSCC Reservation Management";
    // begin
    //     // <<DITW15.00.00.38 DDR 29/11/2010 - 02/12/2010 - 08/12/2010 #1139
    //     // <<DITW16.00.00.42 DDR 01/03/2013 DIT-715 #563
    //     // <<DITW16.00.00.43 DDR 10/10/2013 14/10/2013 DIT-715 #745
    //     // <<DITW16.00.00.43 DDR 24/10/2013 DIT-715 #818
    //     if not (SSCCSetup.READPERMISSION and ItemTrackingCode.HasSetupSSCC and (FormRunModeSSCC = 0)) then
    //         // >>DITW16.00.00.43 DDR DIT-715 #818
    //         // >>DITW16.00.00.43 DDR DIT-715 #745
    //         // >>DITW16.00.00.42 DDR DIT-715 #563
    //         exit;
    //     SCOldTrackingSpecification.TRANSFERFIELDS(OldTrackingSpecification);
    //     SCNewTrackingSpecification.TRANSFERFIELDS(NewTrackingSpecification);
    //     SCTempReservEntry.RESET;
    //     SCTempReservEntry.DELETEALL;
    //     SCTempReservEntry.SETCURRENTKEY(
    //       "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
    //       "Source Batch Name", "Source Prod. Order Line", "Reservation Status");
    //     SCReservEntry.RESET;
    //     SCReservMgt.SetSrcReservEntry2(TempReservEntry, SCReservEntry);
    //     // <<DITW16.00.00.41 DDR 17/10/2012 DIT-715 #442
    //     TempReservEntry.SETRANGE("Lot No.", SCOldTrackingSpecification."Lot No.");
    //     // >>DITW16.00.00.41 DDR DIT-715 #442
    //     TempReservEntry.COPYFILTER("Lot No.", SCReservEntry."Lot No.");

    //     if (ChangeType <> ChangeType::Insert) or
    //       ((ChangeType = ChangeType::Modify) and not CurrentFormIsOpen) or
    //       (NewTrackingSpecification."Quantity (Base)" = 0)
    //     then begin
    //         if SCReservEntry.findset then begin
    //             repeat
    //                 SCTempReservEntry := SCReservEntry;
    //                 SCTempReservEntry.INSERT;
    //             until SCReservEntry.NEXT = 0;

    //             // <<DITW16.00.00.41 DDR 17/10/2012 DIT-715 #442
    //             /// DITW110.00.08 DDR 02/01/2017 NRQ#0
    //             if (ChangeType = ChangeType::FullDelete) or (NewTrackingSpecification."Quantity (Base)" = 0) then begin
    //                 SCOldTrackingSpecification."SSCC No." := '';
    //                 SCOldTrackingSpecification."Lot No." := '';
    //                 SCOldTrackingSpecification."Warranty Date" := 0D;
    //                 SCOldTrackingSpecification."Expiration Date" := 0D;
    //                 SCOldTrackingSpecification."Your Reference" := '';
    //                 SCOldTrackingSpecification."Gyle No." := '';
    //                 // <<DITW15.00.00.38 DDR 08/12/2010 #1139 (DIT711 91)
    //                 SCOldTrackingSpecification."Creation Date" := 0D;
    //                 SCOldTrackingSpecification."Creation Time" := 000000T;
    //                 // >>DITW15.00.00.38 DDR #1139 (DIT711 91)

    //                 SCReservEngineMgt.AddSSCCTrackingToTempRecSet(
    //                   SCTempReservEntry, SCOldTrackingSpecification,
    //                   CurrentSignFactor * SCOldTrackingSpecification."Quantity (Base)", QtyToAddAsBlank,
    //                   ItemTrackingCode."SSCC Specific Tracking", ItemTrackingCode."Lot Specific Tracking");
    //             end else begin
    //                 // <<DITW16.00.00.41 DDR 17/10/2012 DIT-715 #442
    //                 SCTempReservEntry.CALCSUMS("Quantity (Base)");
    //                 if ABS(NewTrackingSpecification."Quantity (Base)") < ABS(SCTempReservEntry."Quantity (Base)") then
    //                     ERROR(Text2035042,
    //                       SCNewTrackingSpecification.FIELDCAPTION("Quantity (Base)"), SCNewTrackingSpecification."Lot No.");
    //             end;
    //             // >>DITW16.00.00.41 DDR DIT-715 #442
    //         end;
    //     end;

    //     if ModifySharedFields then begin
    //         SCReservEntry.SETRANGE("Reservation Status");
    //         // <<DITW16.00.00.43 DDR 18/10/2013 DIT-715 #775
    //         if (OldTrackingSpecification."Warranty Date" <> NewTrackingSpecification."Warranty Date") or
    //            (OldTrackingSpecification."Expiration Date" <> NewTrackingSpecification."Expiration Date") or
    //            (OldTrackingSpecification."Lot No." <> NewTrackingSpecification."Lot No.") or
    //            (OldTrackingSpecification."New Lot No." <> NewTrackingSpecification."New Lot No.") or
    //            (OldTrackingSpecification."New Expiration Date" <> NewTrackingSpecification."New Expiration Date") or
    //            (OldTrackingSpecification."Gyle No." <> NewTrackingSpecification."Gyle No.")
    //         then
    //             // >>DITW16.00.00.43 DDR DIT-715 #775
    //             SCTrackingForm.ModifyFieldsWithinFilterLot(SCReservEntry, SCNewTrackingSpecification,
    //           // <<DITW16.00.00.43 DDR 14/10/2013 DIT-715 #745 - 18/10/2013 DIT-715 #775
    //           true);
    //         // >>DITW16.00.00.43 DDR DIT-715 #745 #775
    //     end;
    // end;

    // procedure SetFormRunModeSSCC(Mode: Option Normal,Reverse);
    // begin
    //     // <<DITW15.00.00.38 DDR 29/10/2010 #1139
    //     FormRunModeSSCC := Mode;
    // end;

    // local procedure LotSCAvailableQty(var TrackingSpecification: Record "Tracking Specification"; FieldMode: Option Base,HandleBase,InvoiceBase): Decimal;
    // var
    //     SCTotalTrackingSpecification: Record "SSCC Tracking Specification" temporary;
    // begin
    //     // <<DITW15.00.00.38 DDR 08/12/2010 #1139 (DIT711 92)
    //     ItemTrackingDataCollection.LotSCAvailableQty(TrackingSpecification, 1, SCTotalTrackingSpecification);
    //     with SCTotalTrackingSpecification do
    //         case FieldMode of
    //             0:
    //                 exit(CurrentSignFactor * "Quantity (Base)");
    //             1:
    //                 exit(CurrentSignFactor * "Qty. to Handle (Base)");
    //             2:
    //                 exit(CurrentSignFactor * "Qty. to Invoice (Base)");
    //         end;
    // end;

    // procedure CreateLotSNInfoCard();
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     if "Quantity (Base)" <> 0 then begin
    //         if "Lot No." <> '' then
    //             CreateLotNoInformation("Lot No.");
    //         if "Serial No." <> '' then
    //             CreateSerialNoInformation("Serial No.");

    //         if (FormRunMode = FormRunMode::Reclass) and
    //           (("New Lot No." <> '') or ("New Serial No." <> ''))
    //         then begin
    //             if (ForNewLocationCode = '') and (ForNewBinCode = '') then
    //                 ERROR(Text2035090);
    //             if "New Lot No." <> '' then
    //                 CreateLotNoInformation("New Lot No.");
    //             if "New Serial No." <> '' then
    //                 CreateSerialNoInformation("New Serial No.");
    //         end;
    //     end;
    //     //>>QXL9.00.001 DAT 23/03/2016
    //     /*
    //       IF "Quantity (Base)" <> 0 THEN BEGIN
    //         CASE TRUE OF
    //           ("Lot No." <> ''):
    //             CreateLotNoInformation("Lot No.");
    //           ("Serial No." <> ''):
    //             CreateSerialNoInformation("Serial No.");
    //         end;

    //         IF ((FormRunMode = FormRunMode::Reclass) OR MoveBinContent) AND
    //           (("New Lot No." <> '') OR ("New Serial No." <> ''))
    //         THEN BEGIN
    //           IF (ForNewLocationCode = '') AND (ForNewBinCode = '') THEN
    //             ERROR(Text2035090);
    //           CASE TRUE OF
    //             ("New Lot No." <> ''):
    //               CreateLotNoInformation("New Lot No.");
    //             ("New Serial No." <> ''):
    //               CreateSerialNoInformation("New Serial No.");
    //           end;
    //         end;
    //       end;
    //     */

    // end;

    // local procedure FormatNotNos();
    // begin
    //     //<< QXL10.01 VSC 27/09/2017 NRQ#38351
    //     LotStyleExpr := LotIsBlocked;
    //     if NewLotNoVisible then
    //         NewLotStyleExpr := NewLotIsBlocked;
    // end;

    // procedure CheckExistQualityTest(DeleteTrigger: Boolean): Boolean;
    // var
    //     QualityTestHeader: Record "Quality Test Header";
    //     QualityTestLine: Record "Quality Test Line";
    // begin
    //     //<<QXL9.00.001 DAT 23/03/2016
    //     if QualitySetup.READPERMISSION and (CurrentSignFactor * SourceQuantityArray[1] >= 0) then begin
    //         // checking headers
    //         QualityTestHeader.RESET;
    //         QualityTestHeader.SETCURRENTKEY("Source ID", "Lot No.", "Serial No.", Status);
    //         QualityTestHeader.SETRANGE("Source ID", "Source ID");
    //         QualityTestHeader.SETRANGE("Lot No.", "Lot No.");
    //         QualityTestHeader.SETRANGE("Serial No.", "Serial No.");

    //         if DeleteTrigger then begin
    //             QualityTestHeader.SETFILTER(Status, '%1|%2',
    //               QualityTestHeader.Status::Pass, QualityTestHeader.Status::Concession);
    //             if QualityTestHeader.findset then
    //                 if CurrentFormIsOpen and GUIALLOWED then
    //                     ERROR(Text2035091, "Lot No.", "Serial No.", QualityTestHeader.FIELDCAPTION(Status), QualityTestHeader.Status)
    //                 else
    //                     exit(false);
    //         end;

    //         // Checking pass & concession lines
    //         if CurrentFormIsOpen and GUIALLOWED and not DeleteIsBlocked then begin
    //             QualityTestHeader.SETFILTER(Status, '<>%1&<>%2',
    //               QualityTestHeader.Status::Pass, QualityTestHeader.Status::Concession);
    //             if not QualityTestHeader.ISEMPTY then
    //                 if not CONFIRM(Text2035092, false, "Lot No.", "Serial No.") then
    //                     exit(false);
    //         end;

    //         if CurrentFormIsOpen and GUIALLOWED and not DeleteIsBlocked then begin
    //             QualityTestHeader.SETFILTER(Status, '%1|%2',
    //               QualityTestHeader.Status::Quarantine, QualityTestHeader.Status::Pending);
    //             QualityTestLine.RESET;
    //             if QualityTestHeader.findset then
    //                 repeat
    //                     QualityTestLine.SETRANGE("Document Type", QualityTestHeader."Document Type");
    //                     QualityTestLine.SETRANGE("Document No.", QualityTestHeader."No.");
    //                     QualityTestLine.SETFILTER(Result, '<>%1', QualityTestLine.Result::" ");
    //                     if not QualityTestLine.ISEMPTY then
    //                         if not CONFIRM(Text2035093, false, "Lot No.", "Serial No.", QualityTestHeader."No.") then
    //                             exit(false);
    //                 until QualityTestHeader.NEXT = 0;
    //         end;
    //     end;
    //     exit(true);
    //     //>>QXL9.00.001 DAT 23/03/2016
    // end;

    // procedure CreateItemTrackingLine4Sales(p_codLotNo: Code[20]; p_decQty: Decimal; p_recSalesLine: Record "Sales Line");
    // var
    //     lintEntryNo: Integer;
    // begin
    //     // <<DITW16.00.00.40 DDR 03/02/2012 #1331
    //     if FINDLAST() then
    //         lintEntryNo := "Entry No." + 1
    //     else
    //         lintEntryNo := 1;

    //     SETRANGE("Lot No.", p_codLotNo);

    //     if not ISEMPTY then begin
    //         FINDSET(true, false);
    //         VALIDATE("Quantity (Base)", "Quantity (Base)" + p_decQty);
    //         MODIFY(true);
    //     end else begin
    //         INIT();
    //         VALIDATE("Source Type", DATABASE::"Sales Line");
    //         VALIDATE("Source Subtype", p_recSalesLine."Document Type");
    //         VALIDATE("Source ID", p_recSalesLine."Document No.");
    //         VALIDATE("Source Ref. No.", p_recSalesLine."Line No.");
    //         VALIDATE("Entry No.", lintEntryNo);
    //         VALIDATE("Item No.", p_recSalesLine."No.");
    //         VALIDATE("Location Code", p_recSalesLine."Location Code");
    //         VALIDATE("Bin Code", p_recSalesLine."Bin Code");
    //         VALIDATE("Lot No.", p_codLotNo);
    //         VALIDATE("Quantity (Base)", p_decQty);
    //         // <<DITW19.00.08 DDR 29/09/2016 20/10/2016 BL#10443
    //         if p_recSalesLine."Strength Spec. Code" <> '' then begin
    //             VALIDATE("Strength Spec. Code", p_recSalesLine."Strength Spec. Code");
    //         end;
    //         if p_recSalesLine."Vol-Strength Spec. Code" <> '' then begin
    //             VALIDATE("Vol-Strength Spec. Code", p_recSalesLine."Vol-Strength Spec. Code");
    //         end;
    //         // >>DITW19.00.08 DDR BL#10443
    //         INSERT(true);
    //     end;
    //     SETRANGE("Lot No.");
    // end;
    // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
    procedure CreateItemTrackingLine4ItJnl(p_codLotNo: Code[20]; p_decQty: Decimal; p_recItemJnlLine: Record "Item Journal Line");
    var
        lintEntryNo: Integer;
    begin
        // <<DITW16.00.00.40 DDR 03/02/2012 #1331
        if Rec.FINDLAST() then
            lintEntryNo := Rec."Entry No." + 1
        else
            lintEntryNo := 1;

        Rec.SETRANGE("Lot No.", p_codLotNo);

        if not Rec.ISEMPTY then begin
            //  Rec.findset(true);
            Rec.findset(true);
            Rec.VALIDATE("Quantity (Base)", Rec."Quantity (Base)" + p_decQty);
            Rec.MODIFY(true);
        end else begin
            Rec.INIT();
            Rec.VALIDATE("Source Type", DATABASE::"Item Journal Line");
            Rec.VALIDATE("Source Subtype", p_recItemJnlLine."Entry Type");
            Rec.VALIDATE("Source ID", p_recItemJnlLine."Journal Template Name");
            Rec.VALIDATE("Source Batch Name", p_recItemJnlLine."Journal Batch Name");
            Rec.VALIDATE("Source Ref. No.", p_recItemJnlLine."Line No.");
            Rec.VALIDATE("Entry No.", lintEntryNo);
            Rec.VALIDATE("Item No.", p_recItemJnlLine."Item No.");
            Rec.VALIDATE("Location Code", p_recItemJnlLine."Location Code");
            Rec.VALIDATE("Bin Code", p_recItemJnlLine."Bin Code");
            Rec.VALIDATE("Lot No.", p_codLotNo);
            Rec.VALIDATE("Quantity (Base)", p_decQty);

            // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
            // // <<DITW19.00.08 DDR 29/09/2016 20/10/2016 BL#10443
            // if p_recItemJnlLine."Strength Spec. Code" <> '' then begin
            //     if p_recItemJnlLine."Strength Spec. Code" <> 'N/A' then begin //HEI.05
            //         VALIDATE("Strength Spec. Code", p_recItemJnlLine."Strength Spec. Code");
            //         VALIDATE("Strength Spec. Value", p_recItemJnlLine."Strength Spec. Value");
            //     end; //HEI.05
            // end;
            // if p_recItemJnlLine."Vol-Strength Spec. Code" <> '' then begin
            //     VALIDATE("Vol-Strength Spec. Code", p_recItemJnlLine."Vol-Strength Spec. Code");
            //     VALIDATE("Vol-Strength Spec. Value", p_recItemJnlLine."Vol-Strength Spec. Value");
            // end;
            // // >>DITW19.00.08 DDR BL#10443
            // BC Upgrade SHUKLP03 << DrinkIT code is blocked.

            Rec.INSERT(true);
        end;
        Rec.SETRANGE("Lot No.");
    end;

    procedure SaveTrackingLines();
    begin
        // <<DITW16.00.00.40 DDR 03/02/2012 #1331
        if UpdateUndefinedQty() then
            WriteToDatabase();
        if FormRunMode = FormRunMode::"Drop Shipment" then
            case CurrentSourceType of
                DATABASE::"Sales Line":
                    SynchronizeLinkedSources(STRSUBSTNO(Text015, Text016));
                DATABASE::"Purchase Line":
                    SynchronizeLinkedSources(STRSUBSTNO(Text015, Text017));
            end;
        if FormRunMode = FormRunMode::Transfer then
            SynchronizeLinkedSources('');

        CLEAR(UndefinedQtyArray);
        CLEAR(SourceQuantityArray);
        TempReservEntry.RESET();
        TempReservEntry.DELETEALL();
        TempItemTrackLineReserv.RESET();
        TempItemTrackLineReserv.DELETEALL();
        xTempItemTrackingLine.RESET();
        xTempItemTrackingLine.DELETEALL();
        Rec.RESET();
        Rec.DELETEALL();
        Rec.INIT();
        Rec."Entry No." := 0;
        COMMIT();
    end;

    // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
    // local procedure UpdateStrengthValueEditable();
    // var
    //     AllowEdit: Boolean;
    // begin
    //     // <<DITW19.00.08 DDR 29/09/2016 20/10/2016 BL#10443
    //     "Strength Spec. ValueEditable" :=
    //       HasTaxSpecEditable("Strength Spec. Code") and
    //      not (("Buffer Status Dit1" = "Buffer Status Dit1"::"Strength blocked") or (CurrentSignFactor < 0));

    //     "New Strength Spec. ValueEditable" :=
    //       "New Strength Spec. ValueVisible" and HasTaxSpecEditable("Strength Spec. Code");

    //     "VStrength Spec. ValueEditable" :=
    //       HasTaxSpecEditable("Vol-Strength Spec. Code") and
    //      not (("Buffer Status Dit1" = "Buffer Status Dit1"::"Strength blocked") or (CurrentSignFactor < 0));

    //     "New VStrength Spec. ValueEditable" :=
    //       "New VStrength Spec. ValueVisible" and HasTaxSpecEditable("Vol-Strength Spec. Code");
    //     // >>DITW19.00.08 DDR BL#10443
    // end;

    // procedure fctInitPage();
    // begin
    //     //<<FINXL7.00.001
    //     UpdateUndefinedQty;
    //     CurrentFormIsOpen := true;
    //     //>>FINXL7.00.001
    // end;

    // procedure fctFinishPage();
    // begin
    //     //<<FINXL7.00.001
    //     if UpdateUndefinedQty then
    //         WriteToDatabase;
    //     if FormRunMode = FormRunMode::"Drop Shipment" then
    //         case CurrentSourceType of
    //             DATABASE::"Sales Line":
    //                 SynchronizeLinkedSources(STRSUBSTNO(Text015, Text016));
    //             DATABASE::"Purchase Line":
    //                 SynchronizeLinkedSources(STRSUBSTNO(Text015, Text017));
    //         end;
    //     if FormRunMode = FormRunMode::Transfer then
    //         SynchronizeLinkedSources('');
    //     //>>FINXL7.00.001
    // end;

    // procedure fctInsertSerialLot(pcodSerialNo: Code[20]; pcodLotNo: Code[20]; pdecQuantity: Decimal);
    // begin
    //     //<<FINXL7.00.001
    //     Rec := recTrackingSpecification;
    //     "Entry No." := NextEntryNo;
    //     "Qty. per Unit of Measure" := QtyPerUOM;
    //     if pcodSerialNo <> '' then
    //         VALIDATE("Serial No.", pcodSerialNo);
    //     if pcodLotNo <> '' then
    //         VALIDATE("Lot No.", pcodLotNo);
    //     VALIDATE("Quantity (Base)", pdecQuantity);

    //     if (not InsertIsBlocked) and (not ZeroLineExists) then
    //         if not TestTempSpecificationExists then begin
    //             TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
    //             TempItemTrackLineInsert.INSERT;
    //             INSERT;
    //             ItemTrackingDataCollection.UpdateLotSNDataSetWithChange(
    //               TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);
    //         end;
    //     CalculateSums;
    //     //>>FINXL7.00.001
    // end;
    // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
    local procedure AssignLotNo_Batch();
    var
        ProdOrderAutoBatchNoGen_HNK: Report "Auto Batch No. Generation";
        Item1: Record Item;
        ProdOrderAutoBatchNoGen_HNK1: Report "Auto Batch No. Generation1";
        AutoBatchNoGeneration_FPOP: Report "Auto Batch No. Generation_FPOP";
        AutoBatchNoGeneration_BPRM: Report "Auto Batch No. Generation_BPRM";
        ExpiryDate: Date;
        QtyToCreate: Decimal;
    begin
        //HEI.02
        if ZeroLineExists() then
            Rec.DELETE();

        if (SourceQuantityArray[1] * UndefinedQtyArray[1] <= 0) or
           (ABS(SourceQuantityArray[1]) < ABS(UndefinedQtyArray[1]))
        then
            QtyToCreate := 0
        else
            QtyToCreate := UndefinedQtyArray[1];

        GetItem(Rec."Item No.");

        //New Code
        if Rec."Source Type" = 39 then begin
            CLEAR(AutoBatchNoGeneration_BPRM);
            AutoBatchNoGeneration_BPRM.GenBatch(Rec."Item No.", Rec."Location Code", ForBinCode);
        end;

        if Rec."Source Type" = 83 then begin
            ItemJrnlLine.RESET();
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Journal Template Name", Rec."Source ID");
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Line No.", Rec."Source Ref. No.");
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Item No.", Rec."Item No.");
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Journal Batch Name", Rec."Source Batch Name");
            ItemJrnlLine.SETRANGE(ItemJrnlLine."Location Code", Rec."Location Code");
            if ItemJrnlLine.FINDFIRST() then
                Item1.GET(Rec."Item No.");
            Item1.TESTFIELD("Batch Number Policy FND");

            if (Item1."Batch Number Policy FND" = Item1."Batch Number Policy FND"::"Propagated Yeast") or
              (Item1."Batch Number Policy FND" = Item1."Batch Number Policy FND"::"Harvested Yeast") then begin
                CLEAR(ProdOrderAutoBatchNoGen_HNK1);
                ProdOrderAutoBatchNoGen_HNK1.SETTABLEVIEW(ItemJrnlLine);
                ProdOrderAutoBatchNoGen_HNK1.RUNMODAL();  //Code commented NAIIKH01 22/9
            end else begin
                if (Item1."Batch Number Policy FND" <> Item1."Batch Number Policy FND"::"Finished Product Own Produced") then begin
                    CLEAR(ProdOrderAutoBatchNoGen_HNK);
                    ProdOrderAutoBatchNoGen_HNK.SETTABLEVIEW(ItemJrnlLine);
                    ProdOrderAutoBatchNoGen_HNK.RUNMODAL();  //Code commented NAIIKH01 22/9
                end;
            end;

            if (Item1."Batch Number Policy FND" = Item1."Batch Number Policy FND"::"Finished Product Own Produced") then begin
                CLEAR(AutoBatchNoGeneration_FPOP);
                AutoBatchNoGeneration_FPOP.SETTABLEVIEW(ItemJrnlLine);
                AutoBatchNoGeneration_FPOP.RUNMODAL();  //Code commented NAIIKH01 22/9
            end;
            //HEI.04>>
            if ItemJrnlLine."Entry Type" = ItemJrnlLine."Entry Type"::Output then
                ExpiryDate := Rec.CalcExpiryDate(ItemJrnlLine."Posting Date");
            //HEI.04<<
        end;

        //Item.TESTFIELD("Lot Nos.");  NAIKH01
        Rec.VALIDATE("Quantity Handled (Base)", 0);
        Rec.VALIDATE("Quantity Invoiced (Base)", 0);

        if Rec."Source Type" = 83 then begin
            //VALIDATE("Lot No.",NoSeriesMgt.GetNextNo(Item."Lot Nos.",WORKDATE,TRUE));  NAIKH01
            if (Item1."Batch Number Policy FND" = Item1."Batch Number Policy FND"::"Propagated Yeast") or
              (Item1."Batch Number Policy FND" = Item1."Batch Number Policy FND"::"Harvested Yeast") then
                Rec.VALIDATE("Lot No.", ProdOrderAutoBatchNoGen_HNK1.RetrieveBatchNo())   //New Code
            else begin
                if (Item1."Batch Number Policy FND" <> Item1."Batch Number Policy FND"::"Finished Product Own Produced") then
                    Rec.VALIDATE("Lot No.", ProdOrderAutoBatchNoGen_HNK.RetrieveBatchNo())   //New Code
                else
                    Rec.VALIDATE("Lot No.", AutoBatchNoGeneration_FPOP.RetrieveBatchNo())   //New Code
            end;
        end;


        if Rec."Source Type" = 39 then begin
            Rec.VALIDATE("Lot No.", AutoBatchNoGeneration_BPRM.RetrieveBatchNo())
        end;

        Rec."Qty. per Unit of Measure" := QtyPerUOM;
        Rec.VALIDATE("Quantity (Base)", QtyToCreate);
        Rec."Entry No." := NextEntryNo();
        TestTempSpecificationExists();

        //BC Upgrade Kamnay01 >> Bug Fix
        // // <<DITW15.00.00.28 PRODW14.00.00.08.06 DLE 01/12/2008: Include Bin No.
        Rec."Bin Code" := ForBinCode;
        Rec.Description := Item.Description;
        // >>DITW15.00.00.28 PRODW14.00.00.08.06 DLE 01/12/2008: Include Bin No.
        //HEI.10>>
        case Rec."Source Type" of
            DATABASE::"Item Journal Line":
                begin
                    case Rec."Source Subtype" of
                        Rec."Source Subtype"::"6":
                            begin
                                if Rec."Strength 3 Code 101FDW" = 'EXT.[%W/W]' then begin
                                    UpdateWeightOfExtractValues;
                                end;
                            end;
                    end;
                end;
        end;
        // //HEI.10<<
        //BC Upgrade Kamnay01 << Bug Fix

        //BC Upgrade SHUKLP03 << Code blocked because DrinkIT field "Strength Spec. Code" is used.

        Rec.INSERT();
        TempItemTrackLineInsert.TRANSFERFIELDS(Rec);
        TempItemTrackLineInsert.INSERT();

        ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
          TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0); // BC Upgrade SHUKLP03 << In  BC procedure name is different. UpdateTrackingDataSetWithChange => BC, UpdateLotSNDataSetWithChange => Nav

        CalculateSums();

        // <<DITW15.00.00.28 PRODW14.00.00.08.06 DLE 01/12/2008: Create Lot no. Information Card
        // <<DITW15.00.00.37 PRODW14.00.00.08.16 DDR 21/06/2010
        // <<DITW15.00.00.38 PRODW14.00.08.17 DDR 24/01/2011 #1256
        // CreateLotSNInfoCard(); // BC Upgrade SHUKLP03 << DrinkIT code blocked.
        // >>DITW15.00.00.37 PRODW14.00.00.08.17 DDR #1256

        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
        // //<< DITW18.00.07 VSC 13/01/2016 DIT-770 #1825
        // if recItem.GET(Rec."Item No.") then
        //     if recItemTracking.GET(recItem."Item Tracking Code") then
        //         if recItemTracking."Man. Expir. Date Entry Reqd." then
        //             if FORMAT(recItem."Expiration Calculation") <> '' then begin
        //                 recProdOrder.SETRANGE("No.", Rec."Source ID");
        //                 if recProdOrder.FINDFIRST() then
        //                     datCreationDate := CALCDATE(recItem."Expiration Calculation", recProdOrder."Due Date");
        //                 Rec."Expiration Date" := datCreationDate;
        //             end;//HEI.04 (added ;)
        // //>> DITW18.00.07 VSC DIT-770 #1825
        // BC Upgrade SHUKLP03 << DrinkIT code is blocked.

        //HEI.04>>
        if ExpiryDate <> 0D then
            Rec."Expiration Date" := ExpiryDate;
        //HEI.04<<
    end;

    // procedure CreateItemTrackingLine4Transf(p_codLotNo: Code[20]; p_decQty: Decimal; TransferLine: Record "Transfer Line");
    // var
    //     lintEntryNo: Integer;
    // begin
    //     if FINDLAST() then
    //         lintEntryNo := "Entry No." + 1
    //     else
    //         lintEntryNo := 1;

    //     SETRANGE("Lot No.", p_codLotNo);

    //     if not ISEMPTY then begin
    //         FINDSET(true, false);
    //         VALIDATE("Quantity (Base)", "Quantity (Base)" + p_decQty);
    //         MODIFY(true);
    //     end else begin
    //         INIT();
    //         VALIDATE("Source Type", DATABASE::"Transfer Line");
    //         VALIDATE("Source ID", TransferLine."Document No.");
    //         VALIDATE("Source Ref. No.", TransferLine."Line No.");
    //         VALIDATE("Entry No.", lintEntryNo);
    //         VALIDATE("Item No.", TransferLine."Item No.");
    //         VALIDATE("Location Code", TransferLine."Transfer-from Code");
    //         VALIDATE("Bin Code", TransferLine."Transfer-from Bin Code");
    //         VALIDATE("Lot No.", p_codLotNo);
    //         VALIDATE("Quantity (Base)", p_decQty);
    //         if TransferLine."Strength Spec. Code" <> '' then begin
    //             VALIDATE("Strength Spec. Code", TransferLine."Strength Spec. Code");
    //         end;
    //         if TransferLine."Vol-Strength Spec. Code" <> '' then begin
    //             VALIDATE("Vol-Strength Spec. Code", TransferLine."Vol-Strength Spec. Code");
    //         end;
    //         INSERT(true);
    //     end;
    //     SETRANGE("Lot No.");
    // end;

    // local procedure "_FINXL11.01.FCT"();
    // begin
    // end;

    // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.  
    // procedure fctGetTrackingSpecification(var ptmpTrackingSpecification: Record "Tracking Specification" temporary);
    // begin
    //     //<<FINXL11.01 MTR 09/11/2018 NRQ#91436
    //     ptmpTrackingSpecification.RESET;
    //     ptmpTrackingSpecification.DELETEALL;
    //     if FINDSET then
    //         repeat
    //             ptmpTrackingSpecification := Rec;
    //             ptmpTrackingSpecification.INSERT;
    //         until NEXT = 0;
    //     //>>FINXL11.01 MTR 09/11/2018 NRQ#91436
    // end;
    // BC Upgrade SHUKLP03 << DrinkIT code is blocked.  

    procedure CreateLotNoInfo(ItemNo: Code[20]; VariantCode: Code[10]; LotNo: Code[20]; ExpirationDate: Date);
    var
        LotNoInformationL: Record "Lot No. Information";
    begin
        //HEI.06>>
        if not LotNoInformationL.GET(ItemNo, VariantCode, LotNo) then begin
            LotNoInformationL.INIT();
            LotNoInformationL.VALIDATE("Item No.", ItemNo);
            LotNoInformationL.VALIDATE("Variant Code", VariantCode);
            LotNoInformationL.VALIDATE("Lot No.", LotNo);
            // LotNoInformationL."Expiration Date" := ExpirationDate; // BC Upgrade SHUKLP03 << DrinkIT field is blocked 
            LotNoInformationL.INSERT(true);
        end else begin
            // LotNoInformationL."Expiration Date" := ExpirationDate; // BC Upgrade SHUKLP03 << DrinkIT field is blocked
            LotNoInformationL.MODIFY(true);
        end;
        //HEI.06<<
    end;

    procedure OnBFFillSourceQuantityArray(TrackingSpecification: Record "Tracking Specification")
    var
        ItemL: Record Item;
    begin
        //HEI.09>>
        CLEAR(VisibleItemReclass);
        IF (FormRunMode = FormRunMode::Reclass) AND (TrackingSpecification."Source Type" = DATABASE::"Item Journal Line") AND (TrackingSpecification."Source Subtype" = 4) THEN BEGIN
            TrackingSpecification.TESTFIELD("Item No.");
            TrackingSpecification.TESTFIELD("Location Code");
            ItemL.GET(TrackingSpecification."Item No.");
            IF ItemL."Batch Number Policy FND" IN [ItemL."Batch Number Policy FND"::"Bulk Product Related Materials", ItemL."Batch Number Policy FND"::"Discrete Product Related Materials"] THEN BEGIN
                VisibleItemReclass := TRUE;
                // PostingDate := AvailabilityDateGlobal; // BC Upgrade SHUKP03 << Code added on OnAfterSetSourceSpec. 
            end;
        end;
        //HEI.09<<

    end;

    procedure ApplyFilters();
    begin
        //HEI.07>>
        EnabledApplyFilters := true;
        //HEI.07<<
    end;

    procedure AssignLots(var TrackingSpecification: Record "Tracking Specification");
    var
        WarehouseActivityLineL: Record "Warehouse Activity Line";
        Text000L: Label 'Empty Lot cannot be assigned.';
    begin
        //HEI.07>>
        case TrackingSpecification.COUNT of
            0:
                ERROR(Text000L);
            1:
                ValidateLot(TrackingSpecification);
            else
                ValidateLots(TrackingSpecification);
        end;
        //HEI.07<<
    end;

    procedure ValidateLot(var TrackingSpecification: Record "Tracking Specification");
    var
        WarehouseActivityLineL: Record "Warehouse Activity Line";
    begin
        //HEI.07>>
        if (TrackingSpecification."Source Type" = DATABASE::"Warehouse Activity Line") and (TrackingSpecification."Source Subtype" = 3) then begin
            TrackingSpecification.TESTFIELD("Lot No.");
            WarehouseActivityLineL.SETCURRENTKEY("Activity Type", "No.", "Line No.", "Item No.");
            WarehouseActivityLineL.SETRANGE("Activity Type", TrackingSpecification."Source Subtype");
            WarehouseActivityLineL.SETRANGE("No.", TrackingSpecification."Source ID");
            WarehouseActivityLineL.SETRANGE("Line No.", TrackingSpecification."Source Ref. No.");
            WarehouseActivityLineL.SETRANGE("Item No.", TrackingSpecification."Item No.");
            WarehouseActivityLineL.FINDFIRST();
            if WarehouseActivityLineL."Lot No." <> '' then
                CheckOldLot(WarehouseActivityLineL, WarehouseActivityLineL."Lot No.");
            CheckOldLot(WarehouseActivityLineL, TrackingSpecification."Lot No.");
            WarehouseActivityLineL.VALIDATE("Lot No.", TrackingSpecification."Lot No.");
            WarehouseActivityLineL.MODIFY(true);
        end;
        //HEI.07<<
    end;

    procedure ValidateLots(var TrackingSpecification: Record "Tracking Specification");
    var
        WarehouseActivityLineL: Record "Warehouse Activity Line";
        UOMCodeL: Code[10];
        BinCodeL: Code[20];
        QtyBaseL: Decimal;
        QuantityL: Decimal;
        QuantityNewL: Decimal;
        iL: Integer;
        jL: Integer;
    begin
        //HEI.07>>
        repeat
            CLEAR(jL);
            CLEAR(QuantityNewL);
            if (TrackingSpecification."Source Type" = DATABASE::"Warehouse Activity Line") and (TrackingSpecification."Source Subtype" = 3) then begin
                TrackingSpecification.TESTFIELD("Lot No.");
                WarehouseActivityLineL.RESET();
                WarehouseActivityLineL.SETCURRENTKEY("Activity Type", "No.", "Line No.", "Item No.");
                WarehouseActivityLineL.SETRANGE("Activity Type", TrackingSpecification."Source Subtype");
                WarehouseActivityLineL.SETRANGE("No.", TrackingSpecification."Source ID");
                if WarehouseActivityLineL.FINDLAST() then
                    jL := WarehouseActivityLineL."Line No.";
                WarehouseActivityLineL.SETRANGE("Line No.", TrackingSpecification."Source Ref. No.");
                WarehouseActivityLineL.SETRANGE("Item No.", TrackingSpecification."Item No.");
                if iL = 0 then begin
                    WarehouseActivityLineL.FIND('-');
                    BinCodeL := GetBinCode(WarehouseActivityLineL);
                    if WarehouseActivityLineL."Lot No." <> '' then
                        CheckOldLot(WarehouseActivityLineL, WarehouseActivityLineL."Lot No.");
                    CheckOldLot(WarehouseActivityLineL, TrackingSpecification."Lot No.");
                    UOMCodeL := WarehouseActivityLineL."Unit of Measure Code";
                    QuantityL := WarehouseActivityLineL.Quantity;
                    QtyBaseL := WarehouseActivityLineL."Qty. (Base)";
                    QuantityNewL := TrackingSpecification."Quantity (Base)" / TrackingSpecification."Qty. per Unit of Measure";
                    WarehouseActivityLineL.VALIDATE(Quantity, QuantityNewL);
                    WarehouseActivityLineL.VALIDATE("Lot No.", TrackingSpecification."Lot No.");
                    WarehouseActivityLineL.MODIFY(true);
                    iL := 1;
                end else begin
                    WarehouseActivityLineL.INIT();
                    WarehouseActivityLineL."Activity Type" := TrackingSpecification."Source Subtype";
                    WarehouseActivityLineL."No." := TrackingSpecification."Source ID";
                    WarehouseActivityLineL."Line No." := jL + 10000;
                    WarehouseActivityLineL."Action Type" := WarehouseActivityLineL."Action Type"::Take;
                    WarehouseActivityLineL."Zone-Transfer FND" := true;
                    WarehouseActivityLineL."Location Code" := TrackingSpecification."Location Code";
                    WarehouseActivityLineL."Zone Code" := TrackingSpecification."Zone Code FND";
                    WarehouseActivityLineL."Bin Code" := TrackingSpecification."Bin Code";
                    WarehouseActivityLineL.VALIDATE("Item No.", TrackingSpecification."Item No.");
                    WarehouseActivityLineL.VALIDATE("Variant Code", TrackingSpecification."Variant Code");
                    WarehouseActivityLineL.VALIDATE(WarehouseActivityLineL."Unit of Measure Code", UOMCodeL);
                    QuantityNewL := TrackingSpecification."Quantity (Base)" / TrackingSpecification."Qty. per Unit of Measure";
                    WarehouseActivityLineL.VALIDATE(Quantity, QuantityNewL);
                    WarehouseActivityLineL.VALIDATE("Lot No.", TrackingSpecification."Lot No.");
                    if WarehouseActivityLineL.INSERT(true) then
                        UpdateBinCode(WarehouseActivityLineL, BinCodeL);
                end;
            end;
        until TrackingSpecification.NEXT() = 0;
        //HEI.07<<
    end;

    procedure GetBinCode(var WhseActivityLineL: Record "Warehouse Activity Line") BinCode: Code[20];
    var
        WarehouseActivityLineL: Record "Warehouse Activity Line";
    begin
        //HEI.07>>
        WarehouseActivityLineL.SETCURRENTKEY("Activity Type", "No.", "Line No.", "Item No.");
        WarehouseActivityLineL.SETRANGE("Activity Type", WhseActivityLineL."Activity Type");
        WarehouseActivityLineL.SETRANGE("No.", WhseActivityLineL."No.");
        WarehouseActivityLineL.SETRANGE("Linked To Line No. FND", WhseActivityLineL."Line No.");
        WarehouseActivityLineL.SETRANGE("Item No.", WhseActivityLineL."Item No.");
        WarehouseActivityLineL.FINDFIRST();
        BinCode := WarehouseActivityLineL."Bin Code";
        //HEI.07<<
    end;

    procedure UpdateBinCode(var WhseActivityLineL: Record "Warehouse Activity Line"; var BinCode: Code[20]);
    var
        WarehouseActivityLineL: Record "Warehouse Activity Line";
    begin
        //HEI.07>>
        WarehouseActivityLineL.SETCURRENTKEY("Activity Type", "No.", "Line No.", "Item No.");
        WarehouseActivityLineL.SETRANGE("Activity Type", WhseActivityLineL."Activity Type");
        WarehouseActivityLineL.SETRANGE("No.", WhseActivityLineL."No.");
        WarehouseActivityLineL.SETRANGE("Linked To Line No. FND", WhseActivityLineL."Line No.");
        WarehouseActivityLineL.SETRANGE("Item No.", WhseActivityLineL."Item No.");
        WarehouseActivityLineL.FINDFIRST();
        WarehouseActivityLineL."Bin Code" := BinCode;
        WarehouseActivityLineL.MODIFY();
        //HEI.07<<
    end;

    procedure CheckOldLot(var WarehouseActivityLine: Record "Warehouse Activity Line"; var LotNo: Code[20]);
    var
        WhseActivityLineL: Record "Warehouse Activity Line";
    begin
        //HEI.07>>
        WarehouseActivityLine.TESTFIELD("Item No.");
        if WarehouseActivityLine."Lot No." <> '' then begin
            WhseActivityLineL.SETCURRENTKEY("Activity Type", "No.", "Item No.", "Action Type", "Zone-Transfer FND",
              "Location Code", "Zone Code", "Bin Code", "Lot No.", "Quantity Shipped FND", "Quantity Received FND", "Line No.");
            WhseActivityLineL.SETRANGE("Activity Type", WarehouseActivityLine."Activity Type");
            WhseActivityLineL.SETRANGE("No.", WarehouseActivityLine."No.");
            WhseActivityLineL.SETRANGE("Item No.", WarehouseActivityLine."Item No.");
            WhseActivityLineL.SETRANGE("Action Type", WarehouseActivityLine."Action Type");
            WhseActivityLineL.SETRANGE("Zone-Transfer FND", WarehouseActivityLine."Zone-Transfer FND");
            WhseActivityLineL.SETRANGE("Location Code", WarehouseActivityLine."Location Code");
            WhseActivityLineL.SETRANGE("Zone Code", WarehouseActivityLine."Zone Code");
            WhseActivityLineL.SETRANGE("Bin Code", WarehouseActivityLine."Bin Code");
            WhseActivityLineL.SETRANGE("Lot No.", LotNo);
            WhseActivityLineL.SETRANGE("Quantity Shipped FND", 0);
            WhseActivityLineL.SETRANGE("Quantity Received FND", 0);
            WhseActivityLineL.SETFILTER("Line No.", '<>%1', WarehouseActivityLine."Line No.");
            if WhseActivityLineL.FIND('-') then begin
                repeat
                    WhseActivityLineL.VALIDATE("Lot No.", '');
                    WhseActivityLineL.MODIFY(true);
                until WhseActivityLineL.NEXT() = 0;
            end;
        end;
        //HEI.07<<
    end;

    procedure CreateNewLotNo() NewLotNo: Code[20];
    var
        BinL: Record Bin;
        LocationL: Record Location;
        NoSeriesL: Record "No. Series";
        NoSeriesLineL: Record "No. Series Line";
        BatchSequentialNoL: Code[20];
        IncrementL: Integer;
        Text000L: Label 'Please enter Posting Date in Reclass Journal.';
        Text001L: Label 'The Length of the field %1 for the Bin Code %2 should be 4 Character.';
    begin
        //HEI.09>>
        if LocationL.GET(REC."Location Code") then begin
            LocationL.TESTFIELD("Plant ID FND");
            if PostingDate = 0D then
                ERROR(Text000L);

            // BC Upgrade SHUKLP03 >> Code blocked because DrinkIT field "New Bin Code" is used.

            // if BinL.GET(REC."Location Code", REC."New Bin Code") then begin
            //     BinL.TESTFIELD("Batch Production Resource");
            //     BinL.TESTFIELD("Batch Sequential Number");
            //     if STRLEN(BinL."Batch Production Resource") < 4 then
            //         ERROR(Text001L, BinL.FIELDCAPTION("Batch Production Resource"), REC."New Bin Code");
            //     NoSeriesL.GET(BinL."Batch Sequential Number");
            //     NoSeriesLineL.SETCURRENTKEY("Series Code", "Line No.", Open);
            //     NoSeriesLineL.SETRANGE("Series Code", BinL."Batch Sequential Number");
            //     NoSeriesLineL.SETRANGE("Line No.", 10000);
            //     NoSeriesLineL.SETRANGE(Open, true);
            //     if NoSeriesLineL.FINDFIRST() then begin
            //         if NoSeriesLineL."Last No. Used" = '' then
            //             BatchSequentialNoL := NoSeriesLineL."Starting No."
            //         else begin
            //             for IncrementL := 1 to NoSeriesLineL."Increment-by No." do
            //                 BatchSequentialNoL := INCSTR(NoSeriesLineL."Last No. Used");
            //         end;
            //         NoSeriesLineL."Last No. Used" := BatchSequentialNoL;
            //         NoSeriesLineL.MODIFY();
            //     end;
            // end;
            // BC Upgrade SHUKLP03 >> Code blocked because DrinkIT field "New Bin Code" is used.    

            NewLotNo := LocationL."Plant ID FND" + COPYSTR(FORMAT(PostingDate, 0, '<Day,2><Month,2><Year4>'), 8, 1) +
              BinL."Batch Production Resource FND" + BatchSequentialNoL;

            exit(NewLotNo);
        end;
        //HEI.09<<
    end;

    //BC Upgrade Kamnay01 >>07/04/2026 FDD - DTW011  HEI.10 and HEI.11 added drinkit field "Strength 3 Code 101FDW", "Strength 3 Value 101FDW"
    local procedure UpdateWeightOfExtractValues();
    var
        ItemL: Record Item;
        Text000L: Label 'EXT.[%w/w] Value %1 is outside of the target range %2 (+/- 0.25). Would you like to proceed?';
        ReservationEntryL: Record "Reservation Entry";
    begin
        //HEI.10>>
        if ItemL.GET(Rec."Item No.") and (ItemL."Strength 3 Code 101FDW" = 'EXT.[%W/W]') then begin
            if IsCMGBin then begin
                ReservationEntryL.SETCURRENTKEY("Source Type", "Source Subtype", "Source ID", "Source Batch Name",
                  "Reference No. FND", "Location Code", "Strength 3 Code 101FDW", "Strength 3 Value 101FDW", "Weight of Extract FND");
                ReservationEntryL.SETRANGE("Source Type", DATABASE::"Item Journal Line");
                ReservationEntryL.SETRANGE("Source Subtype", ReservationEntryL."Source Subtype"::"5");
                ReservationEntryL.SETRANGE("Source ID", Rec."Source ID");
                ReservationEntryL.SETRANGE("Source Batch Name", Rec."Source Batch Name");
                ReservationEntryL.SETRANGE("Reference No. FND", Rec."Reference No. FND");
                ReservationEntryL.SETRANGE("Location Code", Rec."Location Code");
                ReservationEntryL.SETRANGE("Strength 3 Code 101FDW", 'EXT.[%W/W]');
                ReservationEntryL.SETFILTER("Strength 3 Value 101FDW", '<>%1', 0);
                ReservationEntryL.SETFILTER("Weight of Extract FND", '<>%1', 0);
                if ReservationEntryL.findset then begin
                    if Rec."Quantity (Base)" <> 0 then begin
                        ReservationEntryL.CALCSUMS("Weight of Extract FND");
                        Rec."Weight of Extract FND" := ReservationEntryL."Weight of Extract FND";
                        Rec."KG/HL FND" := Rec."Weight of Extract FND" / Rec."Quantity (Base)";
                        Rec.VALIDATE("Strength 3 Value 101FDW", ROUND((-0.013328718) + (1.0045228 * Rec."KG/HL FND") - (0.0040137783 * POWER(Rec."KG/HL FND", 2)) + (0.00001684932 * POWER(Rec."KG/HL FND", 3)), 0.01, '='));
                        if (ItemL."Strength 3 Value 101FDW" - Rec."Strength 3 Value 101FDW" > 0.25) or (ItemL."Strength 3 Value 101FDW" - Rec."Strength 3 Value 101FDW" < -0.25) then begin
                            if not CONFIRM(Text000L, false, Rec."Strength 3 Value 101FDW", ItemL."Strength 3 Value 101FDW") then begin
                                if ItemL."Strength 3 Value 101FDW" <> 0 then
                                    Rec.VALIDATE("Strength 3 Value 101FDW", ItemL."Strength 3 Value 101FDW");
                            end;
                        end;
                    end;
                end;
            end;
        end;
        //HEI.10<<
    end;
    // BC Upgrade Kamnay01 <<07/04/2026 FDD - DTW011  HEI.10 and HEI.11 added drinkit field "Strength 3 Code 101FDW", "Strength 3 Value 101FDW",

    procedure IsCMGBin(): Boolean;
    var
        BinL: Record Bin;
        DefaultDimensionL: Record "Default Dimension";
        InventorySetupL: Record "Inventory Setup";
    begin
        //HEI.10>>
        InventorySetupL.GET();
        if InventorySetupL."CMG Code for Empty Bin FND" <> '' then begin
            if (REC."Bin Code" <> '') and BinL.GET(REC."Location Code", REC."Bin Code") then begin
                DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Code", "Dimension Value Code");
                DefaultDimensionL.SETRANGE("Table ID", DATABASE::Item);
                DefaultDimensionL.SETRANGE("No.", REC."Item No.");
                DefaultDimensionL.SETRANGE("Dimension Code", 'CMG');
                DefaultDimensionL.SETFILTER("Dimension Value Code", InventorySetupL."CMG Code for Empty Bin FND");
                if DefaultDimensionL.FINDFIRST() then
                    exit(true);
            end;
        end;
        exit(false);
        //HEI.10<<
    end;

    local procedure SetValues(NewLocationCode: Code[10]; NewBinCode: Code[20]);
    begin
        //HEI.12>>
        case REC."Source Type" of
            DATABASE::"Item Journal Line":
                begin
                    case REC."Source Subtype" of
                        REC."Source Subtype"::"4":
                            begin
                                if FormRunMode = FormRunMode::Reclass then begin
                                    // BC Upgrade SHUKLP03 >> DrinkIt field is blocked.
                                    // REC."New Location Code" := NewLocationCode;
                                    // REC."New Bin Code" := NewBinCode;
                                    // BC Upgrade SHUKLP03 >> DrinkIt field is blocked.

                                end;
                            end;
                    end;
                end;
        end;
        //HEI.12<<
    end;

    procedure SetSourceSpecExt(var TrackingSpecificationC: Record "Tracking Specification")
    begin
        //HEI.07>>
        IF EnabledApplyFilters THEN
            ForZoneCode := TrackingSpecificationC."Zone Code FND";
        //HEI.07<<
    end;

    procedure OnAFSetSourceSpec(var AvailabilityDate: Date; var TrackingSpecificationSS: Record "Tracking Specification")
    var
        ItemTrackingDataCollectionC: Codeunit "Heineken BC Upgrade";
    begin
        //HEI.09>>
        IF (FormRunMode = FormRunMode::Reclass) AND (TrackingSpecificationss."Source Type" = DATABASE::"Item Journal Line") AND (TrackingSpecificationss."Source Subtype" = 4) THEN BEGIN
            ItemL.GET(TrackingSpecificationss."Item No.");
            IF ItemL."Batch Number Policy FND" IN [ItemL."Batch Number Policy FND"::"Bulk Product Related Materials", ItemL."Batch Number Policy FND"::"Discrete Product Related Materials"] THEN BEGIN
                PostingDate := AvailabilityDate; // BC Upgrade SHUKP03 << Created global variable "AvailabilityDateGlobal" and flowed value from proceduer OnAFSetSourceSpec().
            end;
        end;
        //HEI.09<<

        //HEI.07>>
        IF EnabledApplyFilters THEN BEGIN
            ItemTrackingDataCollectionC.ApplyFilters();
            ItemTrackingDataCollectionC.SetCurrentZoneCode(ForZoneCode);
        end;
        //HEI.07<<
    end;

    procedure OnAddReservEntriesToTempRecSetOnBeforeInsertExt(var TempTrackingSpecificationC: Record "Tracking Specification" temporary; ReservEntryC: Record "Reservation Entry")
    begin
        //HEI.07>>
        IF EnabledApplyFilters THEN
            TempTrackingSpecificationC."Zone Code FND" := ReservEntryC."Zone Code FND";
        //HEI.07<<
    end;

    procedure SetFiltersC(TrackingSpecification: Record "Tracking Specification")
    begin
        Rec.FilterGroup := 2;
        //HEI.07>>
        IF EnabledApplyFilters THEN BEGIN
            Rec.SETRANGE("Zone Code FND", TrackingSpecification."Zone Code FND");
            Rec.SETRANGE("Bin Code", TrackingSpecification."Bin Code");
        end;
        //HEI.07<<
        //HEI.11>>
        CASE TrackingSpecification."Source Type" OF
            DATABASE::"Item Journal Line":
                BEGIN
                    CASE TrackingSpecification."Source Subtype" OF
                        TrackingSpecification."Source Subtype"::"5", TrackingSpecification."Source Subtype"::"6":
                            BEGIN
                                IF TrackingSpecification."Reference No. FND" <> '' THEN
                                    Rec.SETRANGE("Reference No. FND", TrackingSpecification."Reference No. FND");
                            end;
                    end;
                end;
        end;
        //HEI.11<<
        Rec.FilterGroup := 0;
    end;
    //Bc Upgrade YADAVM09>>
    local procedure DoSearchForSupply(SearchSupply: Boolean): Boolean
    begin
        if not IsInvtDocumentCorrection then
            exit(SearchSupply);

        if InsertIsBlocked then
            exit(false);

        if Rec."Source Type" <> DATABASE::"Invt. Document Line" then
            exit(SearchSupply);

        exit(Rec."Source Subtype" = 0);
    end;
    //Bc Upgrade YADAVM09<<
    //PATHAA02 GAP014_DTW, IBM GAP DTW 43>>
    //PATHAA02 30.04.26>>
    local procedure CreateLotNoInformation(ItemNo: Code[20]; VariantCode: Code[10]; LotNo: Code[20]; ExpirationDate: Date)
    var
        LotInfo: Record "Lot No. Information";
        Qualitycontroltriggers: Record QCTrigger92FDW;
        InspectionStatusCode: Code[10];
        InventorySetup: Record "Inventory Setup";
    begin
        InventorySetup.GET();
        if LotNo = '' then
            exit;

        Qualitycontroltriggers.RESET;
        Qualitycontroltriggers.SetRange("No.", ItemNo);
        IF Qualitycontroltriggers.FINDFIRST THEN
            InspectionStatusCode := InventorySetup."Quality On Hold FND"
        ELSE
            InspectionStatusCode := InventorySetup."Quality Unrestricted FND";

        IF NOT LotInfo.Get(ItemNo, VariantCode, LotNo) then begin
            LotInfo.Init();
            LotInfo.Validate("Item No.", ItemNo);
            LotInfo."Variant Code" := VariantCode;
            LotInfo."Lot No." := LotNo;
            LotInfo."Expiration Date 06 FDW" := ExpirationDate;
            LotInfo."Inspection Status Code 07 FDW" := InspectionStatusCode;
            LotInfo.Insert(true);
        end;

        Rec.CalcFields("Inspection Status Code 07 FDW");
        CurrPage.Update(true); //BCUP0-100 PATHAA02 08.07.26 
    end;
    //PATHAA02 30.04.26<<  
    //PATHAA02 GAP014_DTW, IBM GAP DTW 43<<
}

