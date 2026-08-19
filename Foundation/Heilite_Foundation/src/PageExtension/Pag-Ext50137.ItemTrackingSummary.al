pageextension 50137 ItemTrackingSummaryExt extends "Item Tracking Summary"

{

    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    // DITW15.00.00.38 DDR 25/10/2010 issue 1139 SSCC Functionnalities
    //                                         Added "SSCC TRacking Exist" field
    //                                         Added menu 'SSCC List' in 'Line' button
    //                                         Added function SetSourcesSSCC(),ShowSSCCSummary()
    // DITW15.00.00.38 DDR 08/12/2010 #1139 (DIT711 91) Added Creation Date
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities (Temp test with TIF coderules.txt)
    //                                           Modified C/AL "CurrForm."Sales Quality Status".VISIBLE"
    //                                           Modified C/AL "CurrForm."SSCC Tracking Exist".VISIBLE"
    // DITW16.00.00.40 DDR 03/02/2012 #1331 Modified 'HorizGlue','VertGlue' properties Controls 4,5,6,7,26,27 (footer)
    // DITW16.00.00.41 DDR 17/10/2012 DIT-715 #462 Modified function ShowSSCCSummary() to show all sscc lines

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW18.00.08 VSC 06/09/2016 BL#10578 (DIT-770 #2020) Execute per Total Qty. Not per Total Available
    // DITW19.00.08 VSC 09/12/2016 BL#10578 (DIT-770 #2020) Undo prev. change

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // DITW113.00.15 EZOG 27/09/2019 NRQ#121868  Repeating Select entries function should not increase Lot quantity
    //                                         Fix sent from Microsoft

    // HEI.01 CAS-44296 IBM NASTAA02 22.10.2019 # DITW113.00.15 EZOG 27/09/2019 NRQ#121868
    // # New functions created: "AutoSelectTrackingNoEXT", "MinValueAbsEXT"
    // # On procedure AutoSelectTrackingNoExt() Some part of HEI.01 code commented because event "OnBeforeAutoSelectTrackingNo" is 
    // already created in base page and we cannot create it here again.
    // # Called procedure AutoSelectTrackingNoExt() in codeunit HeinekenBCUpgrade

    // HEI.02 CHG2106683 IBM.LS      15.04.2021
    // # Code added on trigger OnAfterGetRecord()
    // # Added Field - Blocked

    // HEI.03 CHG2075364 IBM.LS      22.07.2021
    // # Created procedure SetCurrentZoneCode() for codeunit "Item Tracking Data Collection" in HeinekenBCUpgrade codeunit.
    // # Added field "Empty Expiration Date", "Zone Code"
    // # trigger OnOpenPage() Code of HEI.03 blocked because DrinkIT field "Creation Date" is used.
    // # created procedures ApplyFilters(), SetCurrentZoneCode() and added code.
    // # Code added on procedure AutoSelectTrackingNoExt() 
    // # Added code on trigger OnAfterValidate() of field "Selected Quantity".

    layout
    {
        addafter("Bin Content")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                Visible = ZoneCodeVisible;
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
            field("Empty Expiration Date"; Rec."Empty Expiration Date FND")
            {
                Visible = EnabledApplyFilters;
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Empty Expiration Date field.';
            }
            field(Blocked; LotBlocked)
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LotBlocked field.';
            }
        }
        //BC Upgrade Kamnay01 >> Bug Fix
        // modify("Selected Quantity")
        // {
        //     trigger OnAfterValidate()
        //     begin
        //         //HEI.03>>
        //         IF NOT EnabledApplyFilters THEN
        //             //HEI.03<<
        //             CurrPage.UPDATE();
        //     end;
        // }
        //BC Upgrade Kamnay01 << Bug Fix
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //HEI.03>>
        IF EnabledApplyFilters THEN BEGIN
            //Rec.SETCURRENTKEY("Empty Expiration Date", "Expiration Date", "Creation Date"); // BC Upgrade SHUKLP03 << Code blocked because DrinkIT field "Creation Date" is used. 
            Rec.SETCURRENTKEY("Empty Expiration Date FND", "Expiration Date"); // BC Upgrade SHUKLP03 << removed DrinkIT field "Creation Date". 
            Rec.ASCendING(TRUE);
            ZoneCodeVisible := TRUE;
        end;
        //HEI.03<<
    end;

    trigger OnAfterGetRecord()
    var
        LotNoInformationL: Record "Lot No. Information";
    begin
        //HEI.02>>
        IF (Rec."Lot No." <> '') AND (LotNoInformationL.GET(TrackingSpecification."Item No.", TrackingSpecification."Variant Code", Rec."Lot No.")) THEN
            LotBlocked := LotNoInformationL.Blocked;
        //HEI.02<<
    end;

    procedure ApplyFilters()
    begin
        //HEI.03>>
        EnabledApplyFilters := TRUE;
        //HEI.03<<
    end;

    // BC Upgrade SHUKLP03 >> Created new Procedure 

    procedure SetCurrentZoneCode(ZoneCode: Code[10])
    var
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";// HEI.03 
    begin
        //HEI.03>>
        HeinekenBCUpgrade.SetCurrentZoneCode(ZoneCode);// BC Upgrade SHUKLP03 << Created procedure SetCurrentZoneCode() in HeinekenBCUpgrade codeunit.
        CurrZoneCode := ZoneCode;
        //HEI.03<<
    end;

    procedure AutoSelectTrackingNoExt(var MaxQuantity: Decimal; var Rec: Record "Entry Summary" temporary) // BC Upgrade SHUKLP03 << Called this procedure in codeunit HeinekenBCUpgrade //BC Upgrdae Kamnay01 >> Added parameter Rec
    var
        LotNoInformationL: Record "Lot No. Information";
        LotBlockedL: Boolean;
        AvailableQty: Decimal;
        SelectedQty: Decimal;
    begin
        //HEI.01>>
        // BC Upgrade SHUKLP03 >> Code commented because event "OnBeforeAutoSelectTrackingNo" is already created in base page and we cannot create it here again.
        //IsHandled := FALSE;
        //OnBeforeAutoSelectTrackingNo(Rec, MaxQuantity, IsHandled);
        // IF IsHandled THEN
        //     EXIT;
        // BC Upgrade SHUKLP03 << Code commented because event "OnBeforeAutoSelectTrackingNo" is already created in base page and we cannot create it here again.

        IF MaxQuantity = 0 THEN
            EXIT;

        SelectedQty := MaxQuantity;
        //HEI.03>>
        IF EnabledApplyFilters THEN BEGIN
            //Rec.SETCURRENTKEY("Empty Expiration Date", "Expiration Date", "Creation Date"); // BC Upgrade SHUKLP03 << Code blocked because DrinkIT field "Creation Date" is used. 
            Rec.SETCURRENTKEY("Empty Expiration Date FND", "Expiration Date"); // BC Upgrade SHUKLP03 << removed DrinkIT field "Creation Date". 
            Rec.ASCendING(TRUE);
        end;
        //HEI.03<<
        IF Rec.findset() THEN
            REPEAT
                //HEI.03>>
                CLEAR(LotBlockedL);
                IF (Rec."Lot No." <> '') AND (LotNoInformationL.GET(TrackingSpecification."Item No.", TrackingSpecification."Variant Code", REC."Lot No.")) THEN
                    LotBlockedL := LotNoInformationL.Blocked;
                IF NOT LotBlockedL THEN BEGIN
                    //HEI.03<<
                    AvailableQty := Rec."Total Available Quantity";
                    IF Rec."Bin Active" THEN
                        AvailableQty := MinValueAbsExt(Rec.QtyAvailableToSelectFromBin(), Rec."Total Available Quantity");

                    IF AvailableQty > 0 THEN BEGIN
                        Rec."Selected Quantity" := MinValueAbsExt(AvailableQty, SelectedQty);
                        SelectedQty -= Rec."Selected Quantity";
                        Rec.MODIFY();
                    end;
                    //HEI.03>>
                end;
            //HEI.03<<
            UNTIL (Rec.NEXT() = 0) OR (SelectedQty <= 0);
        //HEI.01<<
    end;

    procedure MinValueAbsExt(Value1: Decimal; Value2: Decimal): Decimal
    begin
        //HEI.01>>
        IF ABS(Value1) < ABS(Value2) THEN
            EXIT(Value1);

        EXIT(Value2);
        //HEI.01<<
    end;
    // BC Upgrade SHUKLP03 << Created new Procedures

    var
        TrackingSpecification: Record "Tracking Specification";
        ItemTrackingSummary: Page 6500;
        EnabledApplyFilters: Boolean;
        LotBlocked: Boolean;
        ZoneCodeVisible: Boolean;
        CurrZoneCode: Code[10];
}