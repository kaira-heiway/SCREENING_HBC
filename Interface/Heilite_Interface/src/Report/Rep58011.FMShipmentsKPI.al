report 58011 "FM Shipments KPI"
{
    // version HEI.02
    //BC Upgrade GUNREM01 Old ID_50129
    // HEI.01 CHG2161264 DEBUSD01 10.11.2022 Shipment KPI Interface
    // HEI.02 CHG2161264 DEBUSD01 13.02.2023 Shipment KPI Interface
    //   #Fix If there is quantity unit HL 0 for any line, that line should not be exported.

    Caption = 'FuturMaster DP Shipments KPI';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;//BC UPGRADE KUMARR78 FM++


    dataset
    {
        dataitem(SalesShptLineFilters; "Sales Shipment Line")
        {
            RequestFilterFields = "Document Subtype Code FND", "Location Code", "Item Category Code";
            /// ReqFilterHeading = 'Shipment Filters';
            RequestFilterHeading = 'Shipment Filters'; //BC Upgrade GUNREM01 

            trigger OnPreDataItem();
            begin
                CurrReport.BREAK;
            end;
        }
        dataitem(TransfShptLineFilters; "Transfer Shipment Line")
        {
            RequestFilterFields = "Document Subtype Code FND", "Transfer-from Code", "Item Category Code";
            //  ReqFilterHeading = 'Transfer Shipment Filters';
            RequestFilterHeading = 'Transfer Shipment Filters'; //BC Upgrade GUNREM01 
            trigger OnPreDataItem();
            begin
                CurrReport.BREAK;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(AsPerDate; AsPerDate)
                    {
                        Caption = 'As per Date';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            FMInterfaceSetup2.GET();
            FMInterfaceSetup2.TESTFIELD("Shipment KPI Interface");
            CalledByRequest := true;
            SetDefaultSalesShptLineFilter(SalesShptLineFilters);
            SetDefaultTransferShptLineFilter(TransfShptLineFilters);
            CalledByRequest := false;
            AsPerDate := TODAY;
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        if FMInterfaceMgt.CreateShipmentsKpi(SalesShptLineFilters, TransfShptLineFilters, AsPerDate, false) then
            MESSAGE(SendedMessage);
    end;

    var
        FMInterfaceMgt: Codeunit "FM Interface Management";
        FMInterfaceSetup2: Record "FuturMaster Interf Setup_2 INT";
        SendedMessage: Label 'FuturMaster Shipments KPI are sent.';
        AsPerDate: Date;
        CalledByRequest: Boolean;

    procedure SetDefaultSalesShptLineFilter(var NewSalesShptLineFilters: Record "Sales Shipment Line");
    begin
        FMInterfaceSetup2.GET();
        NewSalesShptLineFilters.COPY(SalesShptLineFilters);
        NewSalesShptLineFilters.SETFILTER("Document Subtype Code FND", FMInterfaceSetup2."Shpt. Doc. Sub Type Filter");
        NewSalesShptLineFilters.SETFILTER("Location Code", FMInterfaceSetup2."Shpt. Location Filter");
        NewSalesShptLineFilters.SETFILTER("Item Category Code", FMInterfaceSetup2."Shpt. Item Category Filter");
        if CalledByRequest then
            NewSalesShptLineFilters.FILTERGROUP(99);
        NewSalesShptLineFilters.SETRANGE(Type, NewSalesShptLineFilters.Type::Item);
        NewSalesShptLineFilters.SETFILTER(Quantity, '<>0');
        //HEI.02>>
        //  NewSalesShptLineFilters.SETFILTER("Unit Volume HL", '<>0'); //BC Upgrade GUNREM01 -DIT Field
        //HEI.02<<
        NewSalesShptLineFilters.SETFILTER("Volume 2 101FDW", '<>0'); //BC UPGRADE KUMARR78 ++

        NewSalesShptLineFilters.SETRANGE(Correction, false);
        NewSalesShptLineFilters.FILTERGROUP(0);
    end;

    procedure SetDefaultTransferShptLineFilter(var NewTransfShptLineFilters: Record "Transfer Shipment Line");
    begin
        FMInterfaceSetup2.GET();
        NewTransfShptLineFilters.COPY(TransfShptLineFilters);
        NewTransfShptLineFilters.SETFILTER("Document Subtype Code FND", FMInterfaceSetup2."ShptTrsf. Doc. Sub Type Filter");
        NewTransfShptLineFilters.SETFILTER("Transfer-from Code", FMInterfaceSetup2."ShpTrsf. Location Filter");
        NewTransfShptLineFilters.SETFILTER("Item Category Code", FMInterfaceSetup2."ShpTrsf. Item Category Filter");
        if CalledByRequest then
            NewTransfShptLineFilters.FILTERGROUP(99);
        // NewTransfShptLineFilters.SETRANGE("Item Charge No.", '');//BC Upgrade GUNREM01 -DIT Field
        NewTransfShptLineFilters.SETFILTER(Quantity, '<>0');
        //HEI.02>>
        //  NewTransfShptLineFilters.SETFILTER("Unit Volume HL", '<>0');//BC Upgrade GUNREM01 -DIT Field
        //HEI.02<<
        NewTransfShptLineFilters.SETFILTER("Volume 2 101FDW", '<>0'); //BC UPGRADE KUMARR78 ++

        NewTransfShptLineFilters.FILTERGROUP(0);
    end;
}

