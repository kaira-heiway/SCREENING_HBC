report 53022 "Unoading Note"
{
    // version HEI.02

    // HEI.01, FDD LOGGAP08 IBM POSTOI01 Unloading Note
    //    # Created a new Report
    // 
    // HEI.02 IBM POSTOI01 24.07.2018
    //  # modify the default value for UM from CRT to CRT|TRY|CS value in the Request Page-OnOpenPage
    //  # new function CheckBoxesUm
    //  # new global variable BoxesFilter
    //  # on Request Page new OnLookUp code for BoxesFilter
    // 
    // HEI.03 INC2123471 IBM GAVANM01 25.04.2019
    //  # new global variable UnitsFilter
    //  # replace the field UnitsUM with UnitsFilter in the Request Page
    //  # set the default value for UnitsFilter to PC|BRL value in the Request Page-OnOpenPage
    //  # on Request Page new OnLookUp code for UnitsFilter
    //  # new function CheckUnitsUm
    //  # new condition in Warehouse Receipt Line - OnAfterGetRecord()
    // BC Upgrade BHARDA11 >>
    // 1. Old Report ID is - 50121.
    // 2. Add layout path and Change extension RDLC to RDL.
    // 3. Add ApplicationArea property in Report.
    // 4. Remove Drink-IT Fields and related code in Dataset and layout.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Unoading Note.rdl'; // BC Upgrade BHARDA11 ---Add layout path and Change extension RDLC to RDL.

    Caption = 'Unloading Note';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Warehouse Receipt Header"; "Warehouse Receipt Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            // RequestFilterFields = "No.", "Location Code", "Truck Code", "Posting Date"; // BC Upgrade BHARDA11 ----Drink-IT Field("Truck Code")
            RequestFilterFields = "No.", "Location Code", "Posting Date";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(DateTime_Header; FORMAT(TODAY) + '  ' + FORMAT(TIME))
            {
            }
            column(Report_Header; STRSUBSTNO(Text000, "Warehouse Receipt Header"."Posting Date"))
            {
            }
            column(No_Whse_Shipment_Header; "Warehouse Receipt Header"."No.")
            {
            }
            column(Location_Code_Whse_Shipment_Header; "Warehouse Receipt Header"."Location Code")
            {
            }
            // BC Upgrade BHARDA11 >> ----Drink-IT Field("Driver Code","Truck Code")
            // column(Driver_Code_Whse_Shipment_Header; "Warehouse Receipt Header"."Driver Code" + '   ' + DriverName)
            // {
            // }
            // column(Truck_Code_Whse_Shipment_Header; "Warehouse Receipt Header"."Truck Code")
            // {
            // }
            // BC Upgrade BHARDA11 << ----Drink-IT Field("Driver Code","Truck Code")

            dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Item No.")
                                    ORDER(Ascending);
                column(No_WarehouseShipmentLine; "Warehouse Receipt Line"."No.")
                {
                }
                column(ItemNo_WarehouseShipmentLine; WhseRcptLines."Item No.")
                {
                }
                column(Description_WarehouseShipmentLine; WhseRcptLines.Description)
                {
                }
                column(Header1; Text004)
                {
                }
                column(Header2; Text005)
                {
                }
                column(Header3; Text006)
                {
                }
                column(Header4; Text007)
                {
                }
                column(Footer3; Text003)
                {
                }
                column(Footer4; Text008)
                {
                }
                column(Footer1; Text009)
                {
                }
                column(Footer2; Text010)
                {
                }
                column(BoxQty; BoxQty)
                {
                }
                column(UnQty; UnQty)
                {
                }
                column(TotBoxQty; TotBoxQty)
                {
                }
                column(TotUnQty; TotUnQty)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    BoxQty := 0;
                    UnQty := 0;
                    IF CurrKey <> "Warehouse Receipt Line"."No." + "Warehouse Receipt Line"."Item No." THEN BEGIN
                        WhseRcptLines.RESET;
                        WhseRcptLines.SETCURRENTKEY("No.", "Item No.");
                        WhseRcptLines.SETRANGE("No.", "Warehouse Receipt Line"."No.");
                        WhseRcptLines.SETRANGE("Item No.", "Warehouse Receipt Line"."Item No.");
                        IF WhseRcptLines.FINDSET THEN BEGIN
                            REPEAT
                                //HEI.02 IF WhseRcptLines."Unit of Measure Code" = BoxesUM THEN BEGIN
                                IF CheckBoxesUM(WhseRcptLines."Unit of Measure Code") THEN BEGIN //HEI.02
                                    BoxQty += WhseRcptLines.Quantity;
                                    TotBoxQty += WhseRcptLines.Quantity;
                                END;

                                //IF WhseRcptLines."Unit of Measure Code" = UnitsUM THEN BEGIN
                                IF CheckUnitsUM(WhseRcptLines."Unit of Measure Code") THEN BEGIN //HEI.03
                                    UnQty += WhseRcptLines.Quantity;
                                    TotUnQty += WhseRcptLines.Quantity;
                                END;
                            UNTIL WhseRcptLines.NEXT = 0;
                        END;
                        CurrKey := "Warehouse Receipt Line"."No." + "Warehouse Receipt Line"."Item No.";
                    END;

                    IF (BoxQty = 0) AND (UnQty = 0) THEN
                        CurrReport.SKIP;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrKey := '';
                BoxQty := 0;
                UnQty := 0;
                TotBoxQty := 0;
                TotUnQty := 0;
                // BC Upgrade BHARDA11 >> ----Drink-IT Table(WhseShippingDriver)
                // IF WhseShippingDriver.GET("Warehouse Receipt Header"."Driver Code") THEN
                //     DriverName := WhseShippingDriver.Description
                // ELSE
                //     DriverName := '';
                // BC Upgrade BHARDA11 << ----Drink-IT Table(WhseShippingDriver)


                TotBoxQty := 0;
                TotUnQty := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BoxesFilter; BoxesFilter)
                {
                    ApplicationArea = All;
                    Caption = 'BOXES Unit of Measure';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        UMList: Page "Units of Measure";
                        UM: Record "Unit of Measure";
                        SelectFilterManag: Codeunit SelectionFilterManagement;
                        RecRef: RecordRef;
                    begin

                        CLEAR(UMList);
                        UM.RESET;

                        UMList.SETTABLEVIEW(UM);
                        UMList.LOOKUPMODE := TRUE;
                        IF UMList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Text := UMList.GetSelectionFilter;
                            BoxesFilter := Text;
                        END;
                    end;
                }
                field(UnitsFilter; UnitsFilter)
                {
                    ApplicationArea = All;
                    Caption = 'UNITS Unit of Measure';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        UMList: Page "Units of Measure";
                        UM: Record "Unit of Measure";
                    begin
                        //>>HEI.03
                        CLEAR(UMList);
                        UM.RESET;

                        UMList.SETTABLEVIEW(UM);
                        UMList.LOOKUPMODE := TRUE;
                        IF UMList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Text := UMList.GetSelectionFilter;
                            UnitsFilter := Text;
                        END;
                        //<<HEI.03
                    end;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            //HEI.02 BoxesUM := 'CR';
            //>>HEI.02
            BoxesFilter := 'CRT|TRY|CS';
            //<<HEI.02

            //UnitsUM := 'PC';
            //>>HEI.03
            UnitsFilter := 'PC|BRL';
            //<<HEI.03
        end;
    }

    labels
    {
        LblItemDesc = 'Item Description';
        LblBOXES = 'BOXES';
        LblPALLET = 'PALLET';
        LblFULLPALLET = 'FULL PALLET';
        LblBULKPALLET = 'BULK PALLET';
        LblWEIGHTOFBOXES = 'WEIGHT OF BOXES (KG)';
        LblRETURN = 'RETURN';
        LblNo = 'No.';
        LblLocCode = 'Location Code:';
        LblDriverCode = 'Driver Code:';
        LblAssistantCode = 'Assistant Code:';
        LblTruckCode = 'Truck Code:';
        LblUnits = 'UNITS';
        LblQty = 'QUANTITY';
        CalculatedQtyLbl = 'Calculated Qty';
        PhysicalQtyLbl = 'Physical Qty';
        DiiferenceLbl = 'Difference Qty';
        AllocatedQtyLbl = 'Allocated Qty. Difference';
        LblComments = 'Comments';
    }

    trigger OnInitReport()
    begin

        CompanyInfo.GET;
    end;

    var
        CompanyInfo: Record "Company Information";
        // WhseShippingDriver: Record 2014063; // BC Upgrade BHARDA11 ----Drink-IT Table(2014063)
        // WhseShippingDriver2: Record 2014063; // BC Upgrade BHARDA11 ----Drink-IT Table(2014063)
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemUnitOfMeasure1: Record "Item Unit of Measure";
        ItemUnitOfMeasure2: Record "Item Unit of Measure";
        DriverName: Text[250];
        TotalFullPallet: Decimal;
        TotalBulkPallet: Decimal;
        NBBulkPallet: Decimal;
        NbFullPallet: Decimal;
        TotalQty: Decimal;
        Qty: Decimal;
        NbCol: Integer;
        Text000: Label 'Unloading Note OF %1';
        Text003: Label 'Signature Controller';
        Text004: Label 'Time';
        Text005: Label 'Km';
        Text006: Label 'Start';
        Text007: Label 'End';
        Text008: Label 'Signature DelieveryMan';
        Text009: Label 'Outputs Paletts';
        Text010: Label 'Pallets Entries';
        Text011: Label 'Page %1';
        PrintedLine: Integer;
        ShowLine: Integer;
        BoxQty: Decimal;
        UnQty: Decimal;
        TotPhyUnQty: Decimal;
        TotPhyBoxQty: Decimal;
        TotDiffQty: Decimal;
        TotDiffUnQty: Decimal;
        TotBoxQty: Decimal;
        TotUnQty: Decimal;
        PhyBoxQty: Decimal;
        DiffQty: Decimal;
        PhyUnQty: Decimal;
        DiffUnQty: Decimal;
        AlloQty: Decimal;
        AlloUnQty: Decimal;
        ItemNoNew1: Code[30];
        ItemNoNew2: Code[30];
        WhseRcptLines: Record "Warehouse Receipt Line";
        WhseRcptLinesTemp: Record "Warehouse Receipt Line" temporary;
        LineNo: Integer;
        CurrKey: Code[40];
        BoxesUM: Code[10];
        UnitsUM: Code[10];
        BoxesFilter: Text[500];
        UnitsFilter: Text[500];

    local procedure CheckBoxesUM(UoM: Code[10]): Boolean
    var
        UM: Record "Unit of Measure";
    begin
        //HEI.02
        UM.RESET;
        UM.SETFILTER(Code, BoxesFilter);
        IF UM.FINDSET THEN
            REPEAT
                IF UM.Code = UoM THEN
                    EXIT(TRUE);
            UNTIL UM.NEXT = 0;

        EXIT(FALSE);
    end;

    local procedure CheckUnitsUM(UoM: Code[10]): Boolean
    var
        UM: Record "Unit of Measure";
    begin
        //HEI.03
        UM.RESET;
        UM.SETFILTER(Code, UnitsFilter);
        IF UM.FINDSET THEN
            REPEAT
                IF UM.Code = UoM THEN
                    EXIT(TRUE);
            UNTIL UM.NEXT = 0;

        EXIT(FALSE);
    end;
}

