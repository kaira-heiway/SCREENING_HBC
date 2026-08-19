report 54011 "Posted Unoading Note"
{
    // version HEI.03

    // HEI.01, FDD LOGGAP08 IBM POSTOI01 Posted Unloading Note
    //    # Created a new Report
    // 
    // HEI.02 IBM POSTOI01 24.07.2018
    //   # modify the default value for UM from CR to CRT value in the Request Page-OnOpenPage
    // 
    // HEI.03 IBM POSTOI01 24.07.2018
    //  # modify the default value for UM from CRT to CRT|TRY|CS value in the Request Page-OnOpenPage
    //  # new function CheckBoxesUm
    //  # new global variable BoxesFilter
    //  # on Request Page new OnLookUp code for BoxesFilter

    // BC Upgrade SHUKLP03 >> Nav object ID 50122.
    // Blocked some part of code because dependency on DIT field "Driver Code","Truck Code" and record "Posted Return Register Control"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Posted Unoading Note.rdl';

    CaptionML = ENU = 'Posted Unloading Note',
                ESP = 'Doc. Cargue de Camion';
    PreviewMode = PrintLayout;
    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
    UsageCategory = ReportsAndAnalysis; // BC Upgrade SHUKLP03 <<

    dataset
    {
        dataitem("Posted Whse. Receipt Header"; "Posted Whse. Receipt Header")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", "Location Code";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(DateTime_Header; FORMAT(TODAY) + '  ' + FORMAT(TIME))
            {
            }
            column(Report_Header; STRSUBSTNO(Text000, "Posting Date"))
            {
            }
            column(No_Whse_Shipment_Header; "No.")
            {
            }
            column(Location_Code_Whse_Shipment_Header; "Location Code")
            {
            }
            // BC Upgrade SHUKLP03 >> DIT field "Driver Code","Truck Code"
            column(Driver_Code_Whse_Shipment_Header; "Log Driver 107FDW" + '   ' + DriverName)
            {
            }
            column(Truck_Code_Whse_Shipment_Header; "Vehicle Code 101FDW")
            {
            }
            // BC Upgrade SHUKLP03 << DIT field "Driver Code","Truck Code"

            // BC Upgrade SHUKLP03 >> Blocked because DIT record "Posted Return Register Control" is used as dataitem.

            dataitem(ReturnControl107FDW; ReturnControl107FDW)
            {
                DataItemLink = "Route Planning No." = FIELD("Route Planning No. 107FDW"); //"Source No." = FIELD("Whse. Receipt No."); // SHUKLP03 << OBSOLETE AS PER APTEAN
                // DataItemTableView = SORTING("Route Planning No.", "Source Type", "Source Subtype", "Source No.", "Item No.");  // SHUKLP03 << "Source Type","Source Subtype","Source No." OBSOLETE AS PER APTEAN
                DataItemTableView = SORTING("Route Planning No.", "Item No.");

                column(No_WarehouseShipmentLine; PostWhseRcptLines."No.")
                {
                }
                column(ItemNo_WarehouseShipmentLine; PostWhseRcptLines."Item No.")
                {
                }
                column(Description_WarehouseShipmentLine; PostWhseRcptLines.Description)
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
                column(PhyBoxQty; PhyBoxQty)
                {
                }
                column(PhyUnQty; PhyUnQty)
                {
                }
                column(DiffUnQty; DiffUnQty)
                {
                }
                column(DiffQty; DiffQty)
                {
                }
                column(AllCustBoxQty; AllCustBoxQty)
                {
                }
                column(AllCustUnQty; AllCustUnQty)
                {
                }
                column(AllDrivBoxQty; AllDrivBoxQty)
                {
                }
                column(AllDrivUnQty; AllDrivUnQty)
                {
                }
                column(AllCompBoxQty; AllCompBoxQty)
                {
                }
                column(AllCompUnQty; AllCompUnQty)
                {
                }
                column(TotPhyBoxQty; TotPhyBoxQty)
                {
                }
                column(TotPhyUnQty; TotPhyUnQty)
                {
                }
                column(TotDiffUnQty; TotDiffUnQty)
                {
                }
                column(TotDiffQty; TotDiffQty)
                {
                }
                column(TotAllCustBoxQty; TotAllCustBoxQty)
                {
                }
                column(TotAllCustUnQty; TotAllCustUnQty)
                {
                }
                column(TotAllDrivBoxQty; TotAllDrivBoxQty)
                {
                }
                column(TotAllDrivUnQty; TotAllDrivUnQty)
                {
                }
                column(TotAllCompBoxQty; TotAllCompBoxQty)
                {
                }
                column(TotAllCompUnQty; TotAllCompUnQty)
                {
                }
                column(SetSpecialRow; SetSpecialRow)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    BoxQty := 0;
                    UnQty := 0;
                    PhyUnQty := 0;
                    PhyBoxQty := 0;
                    DiffUnQty := 0;
                    DiffQty := 0;
                    AllCustBoxQty := 0;
                    AllCustUnQty := 0;
                    AllDrivBoxQty := 0;
                    AllDrivUnQty := 0;
                    AllCompBoxQty := 0;
                    AllCompUnQty := 0;
                    // CALCFIELDS(ReturnControl107FDW."Difference For Driver", ReturnControl107FDW."Difference For Company");
                    PostWhseRcptLines.RESET;
                    PostWhseRcptLines.SETCURRENTKEY("No.", "Item No.");
                    // PostWhseRcptLines.SETRANGE("Whse. Receipt No.", "Source No."); // SHUKLP03 << Obsolete
                    PostWhseRcptLines.SETRANGE("Item No.", "Item No.");
                    if PostWhseRcptLines.FINDFIRST then begin
                        if ItemUnitofMeasure4.GET(PostWhseRcptLines."Item No.", PostWhseRcptLines."Unit of Measure Code") then
                            MultipleUM := ItemUnitofMeasure4."Qty. per Unit of Measure"
                        else
                            MultipleUM := 1;


                        //for returns of full
                        if (PostWhseRcptLines.Quantity = 0) then begin
                            //HEI.03 IF PostWhseRcptLines."Unit of Measure Code" = BoxesUM THEN BEGIN
                            if CheckBoxesUM(PostWhseRcptLines."Unit of Measure Code") then begin   //HEI.03

                                PhyBoxQty := PostWhseRcptLines."Source Original Quantity FND";
                                DiffQty := -PostWhseRcptLines."Source Original Quantity FND";
                                TotPhyBoxQty += PostWhseRcptLines."Source Original Quantity FND";
                                TotDiffQty += -PostWhseRcptLines."Source Original Quantity FND";
                            end;
                            if PostWhseRcptLines."Unit of Measure Code" = UnitsUM then begin
                                PhyUnQty := PostWhseRcptLines."Source Original Quantity FND";
                                DiffUnQty := -PostWhseRcptLines."Source Original Quantity FND";
                                TotPhyUnQty += PostWhseRcptLines."Source Original Quantity FND";
                                TotDiffUnQty += -PostWhseRcptLines."Source Original Quantity FND";
                            end;
                        end else begin
                            //for other than returns of full
                            repeat
                                //HEI.03 IF PostWhseRcptLines."Unit of Measure Code" = BoxesUM THEN
                                if CheckBoxesUM(PostWhseRcptLines."Unit of Measure Code") then //HEI.03
                                    BoxQty += PostWhseRcptLines."Source Original Quantity FND";
                                if PostWhseRcptLines."Unit of Measure Code" = UnitsUM then
                                    UnQty += PostWhseRcptLines."Source Original Quantity FND";
                            until PostWhseRcptLines.NEXT = 0;

                            //HEI.03 IF PostWhseRcptLines."Unit of Measure Code" = BoxesUM THEN BEGIN
                            if CheckBoxesUM(PostWhseRcptLines."Unit of Measure Code") then begin   //HEI.03
                                PhyBoxQty := "Counted Quantity" / MultipleUM;  // SHUKLP03 <<
                                DiffQty := BoxQty - "Counted Quantity" / MultipleUM;   // SHUKLP03 <<
                                AllCustBoxQty := DiffQty - "Difference For Driver" / MultipleUM - "Difference For Company" / MultipleUM;
                                AllDrivBoxQty := "Difference For Driver" / MultipleUM;
                                AllCompBoxQty := "Difference For Company" / MultipleUM;
                                TotPhyBoxQty += PhyBoxQty;
                                TotDiffQty += DiffQty;
                                TotAllCustBoxQty += AllCustBoxQty;
                                TotAllDrivBoxQty += AllDrivBoxQty;
                                TotAllCompBoxQty += AllCompBoxQty;
                                TotBoxQty += BoxQty;
                            end;
                            if PostWhseRcptLines."Unit of Measure Code" = UnitsUM then begin
                                PhyUnQty := "Counted Quantity";     // SHUKLP03 <<
                                DiffUnQty := UnQty - "Counted Quantity";    // SHUKLP03 <<
                                AllCustUnQty := DiffUnQty - "Difference For Driver" - "Difference For Company";
                                AllDrivUnQty := "Difference For Driver";
                                AllCompUnQty := "Difference For Company";
                                TotPhyUnQty += PhyUnQty;
                                TotDiffUnQty += DiffUnQty;
                                TotAllCustUnQty += AllCustUnQty;
                                TotAllDrivUnQty += AllDrivUnQty;
                                TotAllCompUnQty += AllCompUnQty;
                                TotUnQty += UnQty;
                            end;
                        end;
                    end;


                    if (BoxQty = 0) and (UnQty = 0) and (PhyBoxQty = 0) and (PhyUnQty = 0) then
                        CurrReport.SKIP;
                end;
            }
            // BC Upgrade SHUKLP03 << Blocked because DIT record "Posted Return Register Control" is used as dataitem.
            trigger OnAfterGetRecord();
            begin
                CurrKey := '';
                BoxQty := 0;
                UnQty := 0;
                TotBoxQty := 0;
                TotUnQty := 0;

                // BC Upgrade SHUKLP03 >> Blocked because DIT field "Driver Code" .
                if WhseShippingDriver.GET("Log Driver 107FDW") then
                    DriverName := WhseShippingDriver.Description
                else
                    DriverName := '';
                // BC Upgrade SHUKLP03 << Blocked because DIT field "Driver Code" .


                TotBoxQty := 0;
                TotUnQty := 0;
                TotPhyUnQty := 0;
                TotPhyBoxQty := 0;
                TotDiffUnQty := 0;
                TotDiffQty := 0;
                TotAllCustBoxQty := 0;
                TotAllCustUnQty := 0;
                TotAllDrivBoxQty := 0;
                TotAllDrivUnQty := 0;
                TotAllCompBoxQty := 0;
                TotAllCompUnQty := 0;
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
                    Caption = 'BOXES Unit of Measure';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean;
                    var
                        UMList: Page "Units of Measure";
                        UM: Record "Unit of Measure";
                        SelectFilterManag: Codeunit SelectionFilterManagement;
                        RecRef: RecordRef;
                    begin

                        CLEAR(UMList);
                        UM.RESET();

                        UMList.SETTABLEVIEW(UM);
                        UMList.LOOKUPMODE := true;
                        if UMList.RUNMODAL() = ACTION::LookupOK then begin
                            Text := UMList.GetSelectionFilter();
                            BoxesFilter := Text;
                        end;
                    end;
                }
                field(UnitsUM; UnitsUM)
                {
                    Caption = 'UNITS Unit of Measure';
                    TableRelation = "Unit of Measure".Code;
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            //>>HEI.02
            //BoxesUM := 'CR';
            //HEI.03 BoxesUM := 'CRT';
            //<<HEI.02

            //>>HEI.03
            BoxesFilter := 'CRT|TRY|CS';
            //<<HEI.03


            UnitsUM := 'PC';
        end;
    }

    labels
    {
        label(LblItemDesc; ENU = 'Item Description',
                          FRA = 'DESCRIPTION ARTICLE')
        label(LblBOXES; ENU = 'BOXES',
                       FRA = 'COLIS')
        label(LblPALLET; ENU = 'PALLET',
                        FRA = 'PALETTE')
        label(LblFULLPALLET; ENU = 'FULL PALLET',
                            FRA = 'COMPLETE')
        label(LblBULKPALLET; ENU = 'BULK PALLET',
                            FRA = 'A REPARTIR')
        label(LblWEIGHTOFBOXES; ENU = 'WEIGHT OF BOXES (KG)',
                               FRA = 'POIDS DES COLIS (KG)')
        label(LblRETURN; ENU = 'RETURN',
                        FRA = 'RETOUR')
        label(LblNo; ENU = 'No.',
                    FRA = 'N° expédition')
        LblLocCode = 'Location Code:'; LblDriverCode = 'Driver Code:'; LblAssistantCode = 'Assistant Code:'; LblTruckCode = 'Truck Code:'; LblUnits = 'UNITS'; LblQty = 'QUANTITY'; CalculatedQtyLbl = 'Calculated Qty'; PhysicalQtyLbl = 'Physical Qty'; DiiferenceLbl = 'Difference Qty'; AllocatedQtyLbl = 'Allocated Qty. Difference'; LblComments = 'Comments'; AllocatedCustLbl = 'Allocated Customer'; AllocatedDriverLbl = 'Allocated Driver'; AllocatedCompanyLbl = 'Allocated Company';
    }

    trigger OnInitReport();
    begin

        CompanyInfo.GET();
    end;

    var
        CompanyInfo: Record "Company Information";
        WhseShippingDriver: Record Driver107FDW;  // BC Upgrade SHUKLP03 << Blocked because DIT record.
        WhseShippingDriver2: Record Driver107FDW; // BC Upgrade SHUKLP03 << Blocked because DIT record.
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
        Text000: TextConst ENU = 'Posted Unloading Note OF %1', FRA = 'BORDEREAU DE CHARGEMENT DU %1';
        Text003: TextConst ENU = 'Signature Controller', FRA = 'Signature du contrôleur';
        Text004: TextConst ENU = 'Time', FRA = 'Heure';
        Text005: TextConst ENU = 'Km', FRA = 'Km';
        Text006: TextConst ENU = 'Start', FRA = 'Départ';
        Text007: TextConst ENU = 'End', FRA = 'Arrivée';
        Text008: TextConst ENU = 'Signature DelieveryMan', FRA = 'Signature livreur';
        Text009: TextConst ENU = 'Outputs Paletts', FRA = 'Palettes sorties';
        Text010: TextConst ENU = 'Pallets Entries', FRA = 'Palettes entrées';
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
        PostWhseRcptLines: Record "Posted Whse. Receipt Line";
        WhseRcptLinesTemp: Record "Posted Whse. Receipt Line" temporary;
        LineNo: Integer;
        CurrKey: Code[40];
        BoxesUM: Code[10];
        UnitsUM: Code[10];
        TotAllCustBoxQty: Decimal;
        TotAllCustUnQty: Decimal;
        TotAllDrivBoxQty: Decimal;
        TotAllDrivUnQty: Decimal;
        TotAllCompBoxQty: Decimal;
        TotAllCompUnQty: Decimal;
        AllCustBoxQty: Decimal;
        AllCustUnQty: Decimal;
        AllDrivBoxQty: Decimal;
        AllDrivUnQty: Decimal;
        AllCompBoxQty: Decimal;
        AllCompUnQty: Decimal;
        //RetRegControl: Record "Returns Register Control"; // BC Upgrade SHUKLP03 << Blocked because DIT record.
        SetSpecialRow: Boolean;
        ItemUnitofMeasure4: Record "Item Unit of Measure";
        MultipleUM: Integer;
        BoxesFilter: Text[500];

    local procedure CheckBoxesUM(UoM: Code[10]): Boolean;
    var
        UM: Record "Unit of Measure";
    begin
        //HEI.03
        UM.RESET();
        UM.SETFILTER(Code, BoxesFilter);
        if UM.FINDSET() then
            repeat
                if UM.Code = UoM then
                    exit(true);
            until UM.NEXT() = 0;

        exit(false);
    end;
}

