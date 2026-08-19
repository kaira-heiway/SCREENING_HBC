report 55008 "C2S Reconciliation"
{
    // version HEI.10

    // HEI.01 FDD-HB2761 BULIMC01 IBM 13/04/2022#new report created to show C2S reconcilation figures
    // HEI.02 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //   #new code added for 3rd Party and Own Fleet Warehouse KPIs in order to show the reconciled figures
    // HEI.03 CHG2169207 IBM SISUM01 29/08/2022#add additional filter for line "Internal Transfer"
    //   #add new line "RPM Internal Transfers"
    //   #add new formula when amounts for line "RPM Internal Transfers" are calculated
    //   #add new function to calculate "RPM Internal Transfers" - CalcAllocatedAmountsRPMIT
    // HEI.04 CHG2169207 IBM SISUM01 06/09/2022 #add extra filter when financial value Period GL Cost on Fleet is calculate
    // HEI.05 CHG2169207 IBM SISUM01 14/09/2022 #change filter for follow fields in CalcAllocatedAmountsRPMIT method:
    //   #RPMInternalTransferGenOverhOwnFleet,RPMInternalTransferWhseOverOwnFleet,RPMInternalTransferWhseHandlOwnFleet
    //   #RPMInternalTransferGenOverh,RPMInternalTransferWhseOver,RPMInternalTransferWhseHandl
    // HEI.06 CHG2178734 IBM SISUM01 15/11/2022 #convert to LCY the posted documents amount if it's the case
    // HEI.07 CHG2186610 IBM SISUM01 21/12/2022 #correct total section 2
    // HEI.08 CHG2186968 IBM SISUM01 30/12/2022 #correction for "Period G/L Own Fleet" balance is not triggered to Reconciliation Report
    //   #in Allocation Cost procedure, "Period G/L Cost Own Fleet" is calculated for all records, except some Item Catery Codes.It's needed only filter by date
    // HEI.09 CHG2175297 IBM SISUM01 30/03/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #Add to RequestPage new boolean option
    //   #changes on record creation and calculation
    // HEI.10 CHG2175297 IBM SISUM01 28/04/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #change some formulas

    // BC Upgrade POENAB02: Original (HeiLite) report id 50527

    // POENAB02, 11.06.2026, changes according to Aptean BC standard

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Tasks;
    CaptionML = ENU = 'C2S Reconciliation';

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the starting date for the reconciliation period.';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            if StartingDate <> 0D then
                                EndingDate := CalcDate('<CM>', StartingDate);
                        end;
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date';
                        Editable = false;
                        ApplicationArea = All;
                        Tooltip = 'Specifies the ending date for the reconciliation period.';
                    }
                    field(PrintWhseHandlingSplit; PrintWhseHandlingSplit)
                    {
                        Caption = 'Print Warehouse Handling splits';
                        ApplicationArea = All;
                        ToolTip = 'Specifies whether to print the warehouse handling splits in the reconciliation report.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        C2SReconciliationPage.GetDates(StartingDate, EndingDate);
        //HEI.09>>
        C2SReconciliationPage.SetOpCoAndReportName(CurrentDateTime);
        C2SReconciliationPage.SetProcessingDate(ProcessingDate);
        C2SReconcilationTmp.SetFilter("Period Date", PeriodDate);
        RecRef.GetTable(C2SReconcilationTmp);
        C2SReconciliationPage.SetTmpRecords(RecRef);
        //HEI.09<<
        C2SReconciliationPage.Run();
    end;

    trigger OnPreReport();
    var
    // i: Integer;//Unused Variable
    begin
        InventorySetup.Get();
        SalesSetup.Get();

        //HEI.09>>
        /*
        ShippingCostAllocation.RESET;
        ShippingCostAllocation.SETRANGE("Posting Date",StartingDate,EndingDate);
        IF NOT ShippingCostAllocation.ISEMPTY THEN
          Archived := FALSE
        ELSE
          Archived := TRUE;
        
        CalcAllocatedAmounts;
        //HEI.03>>
        CalcAllocatedAmountsRPMIT;
        //HEI.03<<
        InsertReconciliation;
        */

        ShippingCostAllocation.Reset();
        ShippingCostAllocation.SetRange("Posting Date", StartingDate, EndingDate);
        if not ShippingCostAllocation.IsEmpty then begin
            Archived := false;
            ShippingCostAllocation.FindFirst();
            ProcessingDate := ShippingCostAllocation."Processing Date";
        end else begin
            Archived := true;
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.FindFirst();
            ProcessingDate := ShipArchive."Processing Date";
            ShipArchive.Reset();
        end;

        CreateFilterItemCateg();
        InsertTmpReconcilation();
        //HEI.09<<

    end;

    var
        ShippingCostAllocation: Record "Shipping Cost Allocation FND";
        InventorySetup: Record "Inventory Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        ShipAllocation: Record "Shipping Cost Allocation FND";
        ShipArchive: Record "Shipping Cost Archive FND";
        StartingDate: Date;
        EndingDate: Date;
        PeriodDate: Text;

        Archived: Boolean;

        // BC Upgrade POENAB02 >>
        // code commented, as "Posted Document Shipping Cost" belongs to Aptean
        // PostedDocShippingCost: Record "Posted Document Shipping Cost";
        // BC Upgrade POENAB02 <<
        //POENAB02, 11.06.2026>>
        PostedDocShippingCost: Record "Posted Trade Cost Order APS";
        //POENAB02, 11.06.2026<<
        C2SReconciliation: Record "C2S Reconciliation FND";
        IntTransferAllocated: Decimal;
        RPMAllocated: Decimal;
        GenOvAllocated: Decimal;
        WhseOvAllocated: Decimal;
        WhseHandlAllocated: Decimal;
        IntTransferAllocatedOwnFleet: Decimal;
        RPMAllocatedOwnFleet: Decimal;
        GenOvAllocatedOwnFleet: Decimal;
        WhseOvAllocatedOwnFleet: Decimal;
        WhseHandlAllocatedOwnFleet: Decimal;
        DelivToCust: Decimal;
        DelivToCustOwnFleet: Decimal;
        C2SReconciliationPage: Page "C2S Reconciliation";
        GenOverhIT: Decimal;
        GenOverhITOwnFleet: Decimal;
        WhseOverhIT: Decimal;
        WhseOverhITOwnFleet: Decimal;
        WhseHandlIT: Decimal;
        WhseHandlITOwnFleet: Decimal;
        GenOverhRPM: Decimal;
        WhseOverhRPM: Decimal;
        WhseHandlRPM: Decimal;
        GenOverhRPMOwnFleet: Decimal;
        WhseOverhRPMOwnFleet: Decimal;
        WhseHandlRPMOwnFleet: Decimal;
        RPMInternalTransferAllocated: Decimal;
        RPMInternalTransferAllocatedOwnFleet: Decimal;
        RPMInternalTransferGenOverh: Decimal;
        RPMInternalTransferGenOverhOwnFleet: Decimal;
        RPMInternalTransferWhseOver: Decimal;
        RPMInternalTransferWhseOverOwnFleet: Decimal;
        RPMInternalTransferWhseHandl: Decimal;
        RPMInternalTransferWhseHandlOwnFleet: Decimal;
        PrintWhseHandlingSplit: Boolean;
        C2SReconcilationTmp: Record "C2S Reconciliation FND" temporary;
        RecRef: RecordRef;
        TotalParty: array[4] of Decimal;
        OwnFleet: array[3] of Decimal;
        Total: array[3] of Decimal;
        QShipCostAllocArhived: Query "Shipping Cost Archive";
        QShipCostAlloc: Query "Shipping Cost Allocation";
        Subtotal: array[9] of Decimal;
        CheckValues: array[3] of Decimal;
        "Sum": array[3] of Decimal;
        DiffGL: array[3] of Decimal;
        SumWhseHandlingSplit: array[9] of Decimal;
        DiffWhseHandlingSplit: array[9] of Decimal;
        PeriodGLAlloc3rdParty: Decimal;
        PeriodGLAllocOwnFleet: Decimal;
        PeriodGLAlloc: array[6] of Decimal;
        ProcessingDate: Date;
        TotalSection3: array[3] of Decimal;
        FilterItemCateg: Text[250];
        ShipAllocCostTmp: Record "Shipping Cost Allocation FND" temporary;
        EntryNo: Integer;

    local procedure InsertReconciliation();
    var
    // Reconcilation: Record "C2S Reconciliation FND";//Unused variable
    begin
        //HEI.09>> - deprecated
        /*
        PeriodDate := FORMAT(StartingDate) + '..' + FORMAT(EndingDate);
        
        IF NOT Reconcilation.ISEMPTY THEN
          Reconcilation.DELETEALL;
        
        // line 1
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Section 1: Operational";
        Reconcilation.INSERT;
        
        //line 2 - Delivery to customers
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Delivery to Customers";
        CalcPrimaryAllocation(Reconcilation);
        CalcTotals(Reconcilation);
        Reconcilation.INSERT;
        
        //line 3 - Internal Transfers
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Internal Transfers";
        CalcPrimaryAllocation(Reconcilation);
        Reconcilation."Allocated 3rd Party" := IntTransferAllocated;
        Reconcilation."Allocated Own Fleet" := IntTransferAllocatedOwnFleet;
        //HEI.02<<
        Reconcilation."Allocated Gen. Overh. 3rd P." := GenOverhIT;
        Reconcilation."Allocated Gen. Overh. OwnF." := GenOverhITOwnFleet;
        Reconcilation."Allocated Whse. Overh. 3rd P." := WhseOverhIT;
        Reconcilation."Allocated Whse. Overh. OwnF." := WhseOverhITOwnFleet;
        Reconcilation."Allocated Whse. Handl. 3rd P." := WhseHandlIT;
        Reconcilation."Allocated Whse. Handl. OwnF." := WhseHandlITOwnFleet;
        //HEI.02<<
        CalcTotals(Reconcilation);
        Reconcilation.INSERT;
        
        //line 4 - RPM Transports
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"RPM Transports";
        Reconcilation."Allocated 3rd Party" := RPMAllocated;
        Reconcilation."Allocated Own Fleet" := RPMAllocatedOwnFleet;
        CalcPrimaryAllocation(Reconcilation);
        //HEI.02<<
        Reconcilation."Allocated Gen. Overh. 3rd P." := GenOverhRPM;
        Reconcilation."Allocated Gen. Overh. OwnF." := GenOverhRPMOwnFleet;
        Reconcilation."Allocated Whse. Overh. 3rd P." := WhseOverhRPM;
        Reconcilation."Allocated Whse. Overh. OwnF." := WhseOverhRPMOwnFleet;
        Reconcilation."Allocated Whse. Handl. 3rd P." := WhseHandlRPM;
        Reconcilation."Allocated Whse. Handl. OwnF." :=WhseHandlRPMOwnFleet;
        //HEI.02<<
        CalcTotals(Reconcilation);
        Reconcilation.INSERT;
        
        //HEI.03>>
        //line 4' - RPM Internal Transfers
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"RPM Internal Transfers";
        CalcPrimaryAllocation(Reconcilation);
        Reconcilation."Allocated 3rd Party"           := RPMInternalTransferAllocated;
        Reconcilation."Allocated Own Fleet"           := RPMInternalTransferAllocatedOwnFleet;
        Reconcilation."Allocated Gen. Overh. 3rd P."  := RPMInternalTransferGenOverh;
        Reconcilation."Allocated Gen. Overh. OwnF."   := RPMInternalTransferGenOverhOwnFleet;
        Reconcilation."Allocated Whse. Overh. 3rd P." := RPMInternalTransferWhseOver;
        Reconcilation."Allocated Whse. Overh. OwnF."  := RPMInternalTransferWhseOverOwnFleet;
        Reconcilation."Allocated Whse. Handl. 3rd P." := RPMInternalTransferWhseHandl;
        Reconcilation."Allocated Whse. Handl. OwnF."  := RPMInternalTransferWhseHandlOwnFleet;
        CalcTotals(Reconcilation);
        Reconcilation.INSERT;
        //HEI.03<<
        
        //line 5 - Subtotal
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::Subtotal;
        CalcPrimaryAllocation(Reconcilation);
        Reconcilation.INSERT;
        
        //line 6 - Posted Doc. Shipping Cost
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Posted Doc. Shipping Cost";
        CalcPrimaryAllocation(Reconcilation);
        CalcTotals(Reconcilation);
        Reconcilation.INSERT;
        
        //line 7 - Check
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::Check;
        CalcPrimaryAllocation(Reconcilation);
        Reconcilation.INSERT;
        
        //line 8
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Section 2: Financials";
        Reconcilation.INSERT;
        
        //line 9 - Period G/L Cost Delivery to Customer
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Period G/L Cost Delivery to Customer";
        Reconcilation."Allocated 3rd Party" := DelivToCust + IntTransferAllocated + RPMAllocated;
        CalcPrimaryAllocation(Reconcilation);
        CalcTotals(Reconcilation);
        Reconcilation.INSERT;
        
        //line 10 - Period G/L Cost Own fleet
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Period  G/L  Own Fleet";
        Reconcilation."Allocated Own Fleet" := DelivToCustOwnFleet + IntTransferAllocatedOwnFleet + RPMAllocatedOwnFleet;
        CalcPrimaryAllocation(Reconcilation);
        CalcTotals(Reconcilation);
        Reconcilation.INSERT;
        
        //line 11 - Period G/L Cost Gen. Overheads
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Period G/L Cost Gen. Overheads";
        CalcPrimaryAllocation(Reconcilation);
        Reconcilation.Allocated := GenOvAllocated;
        Reconcilation.Unallocated := Reconcilation.Total - Reconcilation.Allocated;
        Reconcilation.INSERT;
        
        //line 12 - Period G/L Cost Whse. Handling
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Period G/L Cost Whse. Handling";
        CalcPrimaryAllocation(Reconcilation);
        Reconcilation.Allocated := WhseHandlAllocated;
        Reconcilation.Unallocated := Reconcilation.Total - Reconcilation.Allocated;
        Reconcilation.INSERT;
        
        //line 13 - Period G/L Cost Whse. Overhead
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::"Period G/L Cost Whse. Overhead";
        CalcPrimaryAllocation(Reconcilation);
        Reconcilation.Allocated := WhseOvAllocated;
        Reconcilation.Unallocated := Reconcilation.Total - Reconcilation.Allocated;
        Reconcilation.INSERT;
        
        //line Total
        Reconcilation.INIT;
        Reconcilation.Description := Reconcilation.Description::Total;
        CalcPrimaryAllocation(Reconcilation);
        Reconcilation.INSERT;
        
        */
        //HEI.09<<

    end;

    local procedure CalcPrimaryAllocation(var Rec: Record "C2S Reconciliation FND");
    var
        RecSubtotal: Record "C2S Reconciliation FND";
        RecPostedDoc: Record "C2S Reconciliation FND";
    begin
        //HEI.09>> - deprecated
        /*
        IF Rec.Description <> Rec.Description::Subtotal THEN
          Rec."Period Date" := PeriodDate;
        
        CASE Rec.Description OF
          Rec.Description::"Delivery to Customers":
            IF Archived THEN BEGIN
              ShipArchive.RESET;
              ShipArchive.SETCURRENTKEY("Posting Date","Destination Type","Only RPM Transportation");
              ShipArchive.SETRANGE("Posting Date",StartingDate,EndingDate);
              ShipArchive.SETRANGE("Destination Type",ShipArchive."Destination Type"::Customer);
              ShipArchive.SETRANGE("Only RPM Transportation",FALSE);
              IF ShipArchive.FINDSET THEN REPEAT
                GetArchiveValues(ShipArchive,Rec);
              UNTIL ShipArchive.NEXT = 0;
            END ELSE BEGIN
              ShipAllocation.RESET;
              ShipAllocation.SETCURRENTKEY("Posting Date","Destination Type","Only RPM Transportation");
              ShipAllocation.SETRANGE("Posting Date",StartingDate,EndingDate);
              ShipAllocation.SETRANGE("Destination Type",ShipAllocation."Destination Type"::Customer);
              ShipAllocation.SETRANGE("Only RPM Transportation",FALSE);
              IF ShipAllocation.FINDSET THEN REPEAT
                GetAllocationValues(ShipAllocation,Rec);
              UNTIL ShipAllocation.NEXT = 0;
            END;
        
            Rec.Description::"Internal Transfers":
            IF Archived THEN BEGIN
              ShipArchive.RESET;
              ShipArchive.SETCURRENTKEY("Posting Date","Destination Type");
              ShipArchive.SETRANGE("Posting Date",StartingDate,EndingDate);
              ShipArchive.SETRANGE("Destination Type",ShipArchive."Destination Type"::Location);
              //HEI.03>>
              ShipArchive.SETRANGE("Only RPM Transportation",FALSE);
              //HEI.03<<
              IF ShipArchive.FINDSET THEN REPEAT
                GetArchiveValues(ShipArchive,Rec);
              UNTIL ShipArchive.NEXT = 0;
            END ELSE BEGIN
              ShipAllocation.RESET;
              ShipAllocation.SETCURRENTKEY("Posting Date","Destination Type");
              ShipAllocation.SETRANGE("Posting Date",StartingDate,EndingDate);
              ShipAllocation.SETRANGE("Destination Type",ShipAllocation."Destination Type"::Location);
              //HEI.03>>
              ShipAllocation.SETRANGE("Only RPM Transportation",FALSE);
              //HEI.03<<
              IF ShipAllocation.FINDSET THEN REPEAT
                GetAllocationValues(ShipAllocation,Rec);
              UNTIL ShipAllocation.NEXT = 0;
            END;
        
            //HEI.03>>
            Rec.Description::"RPM Internal Transfers":
            IF Archived THEN BEGIN
              ShipArchive.RESET;
              ShipArchive.SETCURRENTKEY("Posting Date","Destination Type");
              ShipArchive.SETRANGE("Posting Date",StartingDate,EndingDate);
              ShipArchive.SETRANGE("Destination Type",ShipArchive."Destination Type"::Location);
              ShipArchive.SETRANGE("Only RPM Transportation",TRUE);
              IF ShipArchive.FINDSET THEN REPEAT
                GetArchiveValues(ShipArchive,Rec);
              UNTIL ShipArchive.NEXT = 0;
            END ELSE BEGIN
              ShipAllocation.RESET;
              ShipAllocation.SETCURRENTKEY("Posting Date","Destination Type");
              ShipAllocation.SETRANGE("Posting Date",StartingDate,EndingDate);
              ShipAllocation.SETRANGE("Destination Type",ShipAllocation."Destination Type"::Location);
              ShipAllocation.SETRANGE("Only RPM Transportation",TRUE);
              IF ShipAllocation.FINDSET THEN REPEAT
                GetAllocationValues(ShipAllocation,Rec);
              UNTIL ShipAllocation.NEXT = 0;
            END;
            //HEI.03<<
        
            Rec.Description::"RPM Transports":
            IF Archived THEN BEGIN
              ShipArchive.RESET;
              ShipArchive.SETCURRENTKEY("Posting Date","Destination Type","Only RPM Transportation");
              ShipArchive.SETRANGE("Posting Date",StartingDate,EndingDate);
              ShipArchive.SETRANGE("Destination Type",ShipArchive."Destination Type"::Customer);
              ShipArchive.SETRANGE("Source Document",ShipArchive."Source Document"::"Sales Return Order");
              ShipArchive.SETRANGE("Only RPM Transportation",TRUE);
              IF ShipArchive.FINDSET THEN REPEAT
                GetArchiveValues(ShipArchive,Rec);
              UNTIL ShipArchive.NEXT = 0;
            END ELSE BEGIN
              ShipAllocation.RESET;
              ShipAllocation.SETCURRENTKEY("Posting Date","Destination Type","Only RPM Transportation");
              ShipAllocation.SETRANGE("Posting Date",StartingDate,EndingDate);
              ShipAllocation.SETRANGE("Destination Type",ShipAllocation."Destination Type"::Customer);
              ShipAllocation.SETRANGE("Source Document",ShipAllocation."Source Document"::"Sales Return Order");
              ShipAllocation.SETRANGE("Only RPM Transportation",TRUE);
              IF ShipAllocation.FINDSET THEN REPEAT
                GetAllocationValues(ShipAllocation,Rec);
              UNTIL ShipAllocation.NEXT = 0;
            END;
        
            Rec.Description::Subtotal:
             BEGIN
              C2SReconciliation.RESET;
              //HEI.03>>
              //C2SReconciliation.SETFILTER(Description,'%1|%2|%3',C2SReconciliation.Description::"Delivery to Customers",C2SReconciliation.Description::"Internal Transfers",C2SReconciliation.Description::"RPM Transports");
              C2SReconciliation.SETFILTER(Description,'%1|%2|%3|%4',C2SReconciliation.Description::"Delivery to Customers",C2SReconciliation.Description::"Internal Transfers",C2SReconciliation.Description::"RPM Transports",
                                         C2SReconciliation.Description::"RPM Internal Transfers");
              //HEI.03<<
              IF C2SReconciliation.FINDSET THEN REPEAT
                Rec.Total += C2SReconciliation.Total;
                Rec."Total 3rd Party" += C2SReconciliation."Total 3rd Party";
                Rec."Total Own Fleet" += C2SReconciliation."Total Own Fleet";
                Rec.Allocated += C2SReconciliation.Allocated;
                Rec."Allocated 3rd Party" += C2SReconciliation."Allocated 3rd Party";
                Rec."Allocated Own Fleet" += C2SReconciliation."Allocated Own Fleet";
                Rec.Unallocated += C2SReconciliation.Unallocated;
                Rec."Unallocated 3rd Party" += C2SReconciliation."Unallocated 3rd Party";
                Rec."Unallocated Own Fleet" += C2SReconciliation."Unallocated Own Fleet";
                Rec."Reversed Entries" += C2SReconciliation."Reversed Entries";
                Rec."Shipment of non FG" += C2SReconciliation."Shipment of non FG";
                Rec."Missing Shipments" += C2SReconciliation."Missing Shipments";
                //HEI.02>>
                //General Overheads
                Rec."Total Gen. Overh." += C2SReconciliation."Total Gen. Overh.";
                Rec."Total Gen. Overh. 3rd P." += C2SReconciliation."Total Gen. Overh. 3rd P.";
                Rec."Total Gen. Overh. OwnF." += C2SReconciliation."Total Gen. Overh. OwnF.";
                Rec."Allocated Gen. Overh." += C2SReconciliation."Allocated Gen. Overh.";
                Rec."Allocated Gen. Overh. 3rd P." += C2SReconciliation."Allocated Gen. Overh. 3rd P.";
                Rec."Allocated Gen. Overh. OwnF." += C2SReconciliation."Allocated Gen. Overh. OwnF.";
                Rec."Unallocated Gen. Overh." += C2SReconciliation."Unallocated Gen. Overh.";
                Rec."Unallocated Gen. Overh. 3rd P." += C2SReconciliation."Unallocated Gen. Overh. 3rd P.";
                Rec."Unallocated Gen. Overh. OwnF." += C2SReconciliation."Unallocated Gen. Overh. OwnF.";
                //Warehouse Overheads
                Rec."Total Whse. Overh." += C2SReconciliation."Total Whse. Overh.";
                Rec."Total Whse. Overh. 3rd P." += C2SReconciliation."Total Whse. Overh. 3rd P.";
                Rec."Total Whse. Overh. OwnF." += C2SReconciliation."Total Whse. Overh. OwnF.";
                Rec."Allocated Whse. Overh." += C2SReconciliation."Allocated Whse. Overh.";
                Rec."Allocated Whse. Overh. 3rd P." += C2SReconciliation."Allocated Whse. Overh. 3rd P.";
                Rec."Allocated Whse. Overh. OwnF." += C2SReconciliation."Allocated Whse. Overh. OwnF.";
                Rec."Unallocated Whse. Overh." += C2SReconciliation."Unallocated Whse. Overh.";
                Rec."Unallocated Whs. Overh. 3rd P." += C2SReconciliation."Unallocated Whs. Overh. 3rd P.";
                Rec."Unallocated Whse. Overh. OwnF." += C2SReconciliation."Unallocated Whse. Overh. OwnF.";
                //Warehouse Handling
                Rec."Total Whse. Handl." += C2SReconciliation."Total Whse. Handl.";
                Rec."Total Whse. Handl. 3rd P." += C2SReconciliation."Total Whse. Handl. 3rd P.";
                Rec."Total Whse. Handl. OwnF." += C2SReconciliation."Total Whse. Handl. OwnF.";
                Rec."Allocated Whse. Handl." += C2SReconciliation."Allocated Whse. Handl.";
                Rec."Allocated Whse. Handl. 3rd P." += C2SReconciliation."Allocated Whse. Handl. 3rd P.";
                Rec."Allocated Whse. Handl. OwnF." += C2SReconciliation."Allocated Whse. Handl. OwnF.";
                Rec."Unallocated Whse. Handl." += C2SReconciliation."Unallocated Whse. Handl.";
                Rec."Unallocated Whs. Handl. 3rd P." += C2SReconciliation."Unallocated Whs. Handl. 3rd P.";
                Rec."Unallocated Whse. Handl. OwnF." += C2SReconciliation."Unallocated Whse. Handl. OwnF.";
                //HEI.02<<
              UNTIL C2SReconciliation.NEXT = 0;
             END;
        
            Rec.Description::"Posted Doc. Shipping Cost":
              BEGIN
                GetPostedDocShipCostValues(Rec);
                Rec."Allocated 3rd Party" := CalcFinancialValues(Rec,FALSE);
                IF Rec."Total Own Fleet" <> 0 THEN
                  Rec."Allocated Own Fleet" := CalcFinancialValues(Rec,TRUE);
              END;
        
            Rec.Description::Check:
              BEGIN
                RecSubtotal.RESET;
                IF RecSubtotal.GET(RecSubtotal.Description::Subtotal) THEN
                  IF RecPostedDoc.GET(RecPostedDoc.Description::"Posted Doc. Shipping Cost") THEN BEGIN
                    Rec.Total := RecSubtotal.Total - RecPostedDoc.Total;
                    Rec."Total 3rd Party" := RecSubtotal."Total 3rd Party" - RecPostedDoc."Total 3rd Party";
                    Rec."Total Own Fleet" := RecSubtotal."Total Own Fleet" - RecPostedDoc."Total Own Fleet";
                    Rec.Allocated := RecSubtotal.Allocated - RecPostedDoc.Allocated;
                    Rec."Allocated 3rd Party" := RecSubtotal."Allocated 3rd Party" -RecPostedDoc."Allocated 3rd Party";
                    Rec."Allocated Own Fleet" := RecSubtotal."Allocated Own Fleet" - RecPostedDoc."Allocated Own Fleet";
                    Rec.Unallocated := RecSubtotal.Unallocated - RecPostedDoc.Unallocated;
                    Rec."Unallocated 3rd Party" := RecSubtotal."Unallocated 3rd Party" - RecPostedDoc."Unallocated 3rd Party";
                    Rec."Unallocated Own Fleet" := RecSubtotal."Unallocated Own Fleet" - RecPostedDoc."Unallocated Own Fleet";
                  END;
              END;
        
            Rec.Description::"Period G/L Cost Delivery to Customer":
              Rec."Total 3rd Party" := CalcFinancialValues(Rec,FALSE);
        
            Rec.Description::"Period  G/L  Own Fleet":
              Rec."Total Own Fleet" := CalcFinancialValues(Rec,TRUE);
        
            ELSE IF Rec.Description <> Rec.Description::Total THEN
                Rec.Total := CalcFinancialValues(Rec,FALSE)
              ELSE BEGIN
                C2SReconciliation.RESET;
                //HEI.07>>
                //C2SReconciliation.SETFILTER(Description,'%1|%2|%3|%4|%5',C2SReconciliation.Description::"Period G/L Cost Delivery to Customer",C2SReconciliation.Description::"Section 2: Financials",C2SReconciliation.Description::"Period  G/L  Own Fleet",
                C2SReconciliation.SETFILTER(Description,'%1|%2|%3|%4|%5',C2SReconciliation.Description::"Period G/L Cost Delivery to Customer",C2SReconciliation.Description::"Period G/L Cost Whse. Handling",C2SReconciliation.Description::"Period  G/L  Own Fleet",
                //HEI.07<<
                                            C2SReconciliation.Description::"Period G/L Cost Whse. Overhead",C2SReconciliation.Description::"Period G/L Cost Gen. Overheads");
                IF C2SReconciliation.FINDSET THEN REPEAT
                  Rec.Total += C2SReconciliation.Total;
                  Rec.Allocated += C2SReconciliation.Allocated;
                  Rec.Unallocated += C2SReconciliation.Unallocated;
                UNTIL C2SReconciliation.NEXT = 0;
               END;
        END;
        */
        //HEI.09<<

    end;

    local procedure CalcAllocatedAmounts();
    var
        ShipCostAllocQuery: Query "Shipping Cost Allocation";
        Rec: Record "C2S Reconciliation FND";
        ShipCostArchQuery: Query "Shipping Cost Archive";
    begin
        //HEI.09>> - deprecated
        /*
        //InitValues; HEI.02 no needed since the function is run only once
        
        IF Archived THEN BEGIN
          //3rd party
          ShipCostArchQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostArchQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Customer);
          ShipCostArchQuery.SETRANGE(OnlyRPM,FALSE);
          ShipCostArchQuery.SETRANGE(OwnFleet,FALSE);
          ShipCostArchQuery.OPEN;
          WHILE ShipCostArchQuery.READ DO BEGIN
            DelivToCust := ShipCostArchQuery.InternalTransfer;
            IntTransferAllocated := ShipCostArchQuery.InternalTransferST;
            //HEI.03>>
            //RPMAllocated := ShipCostArchQuery.RPM_SO + ShipCostArchQuery.RPM_ST;
            //HEI.03<<
            GenOvAllocated := ShipCostArchQuery.TotalGenOverheads + ShipCostArchQuery.TotalGenOverheadsST;
            WhseOvAllocated := ShipCostArchQuery.TotalWhseOverheads + ShipCostArchQuery.TotalWhseOverheadsST;
            WhseHandlAllocated := ShipCostArchQuery.TotalWhseHandling + ShipCostArchQuery.TotalWhseHandlingST;
            //HEI.02<<
            GenOverhIT := ShipCostArchQuery.TotalGenOverheadsST;
            WhseOverhIT := ShipCostArchQuery.TotalWhseOverheadsST;
            WhseHandlIT := ShipCostArchQuery.TotalWhseHandlingST;
            //HEI.03>>
            //GenOverhRPM := ShipCostArchQuery.Gen_Overheads_RPM_SO + ShipCostArchQuery.Gen_Overheads_RPM_ST;
            //WhseOverhRPM := ShipCostArchQuery.Whse_Overheads_RPM_SO + ShipCostArchQuery.Whse_Overheads_RPM_ST;
            //WhseHandlRPM := ShipCostArchQuery.Whse_Handling_RPM_SO + ShipCostArchQuery.Whse_Handling_RPM_ST;
            GenOverhRPM := ShipCostArchQuery.Gen_Overheads_RPM_SO;
            WhseOverhRPM := ShipCostArchQuery.Whse_Overheads_RPM_SO;
            WhseHandlRPM := ShipCostArchQuery.Whse_Handling_RPM_SO;
            //HEI.03<<
        
            //HEI.02>>
          END;
          ShipCostArchQuery.CLOSE;
        
          //HEI.03>>
          //filter only by period and OnlyFleet = FALSE
          CLEAR(ShipCostArchQuery);
          ShipCostArchQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostArchQuery.SETRANGE(OwnFleet,FALSE);
          ShipCostArchQuery.OPEN;
          WHILE ShipCostArchQuery.READ DO BEGIN
            RPMAllocated := ShipCostArchQuery.RPM_SO;
          END;
          ShipCostArchQuery.CLOSE;
          //HEI.03<<
        
        
          //Own fleet
          CLEAR(ShipCostArchQuery);
          ShipCostArchQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostArchQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Customer);
          ShipCostArchQuery.SETRANGE(OnlyRPM,FALSE);
          ShipCostArchQuery.SETRANGE(OwnFleet,TRUE);
          ShipCostArchQuery.OPEN;
          WHILE ShipCostArchQuery.READ DO BEGIN
            DelivToCustOwnFleet := ShipCostArchQuery.InternalTransfer;
            IntTransferAllocatedOwnFleet := ShipCostArchQuery.InternalTransferST;
            //HEI.03>>
            //RPMAllocatedOwnFleet := ShipCostArchQuery.RPM_SO + ShipCostArchQuery.RPM_ST;
            //HEI.03<<
            GenOvAllocated += ShipCostArchQuery.TotalGenOverheads + ShipCostArchQuery.TotalGenOverheadsST;
            WhseOvAllocated += ShipCostArchQuery.TotalWhseOverheads + ShipCostArchQuery.TotalWhseOverheadsST;
            WhseHandlAllocated += ShipCostArchQuery.TotalWhseHandling + ShipCostArchQuery.TotalWhseHandlingST;
            //HEI.02<<
            GenOverhITOwnFleet := ShipCostArchQuery.TotalGenOverheadsST;
            WhseOverhITOwnFleet := ShipCostArchQuery.TotalWhseOverheadsST;
            WhseHandlITOwnFleet := ShipCostArchQuery.TotalWhseHandlingST;
            //HEI.03>>
            //GenOverhRPMOwnFleet := ShipCostArchQuery.Gen_Overheads_RPM_SO + ShipCostArchQuery.Gen_Overheads_RPM_ST;
            //WhseOverhRPMOwnFleet := ShipCostArchQuery.Whse_Overheads_RPM_SO + ShipCostArchQuery.Whse_Overheads_RPM_ST;
            //WhseHandlRPMOwnFleet := ShipCostArchQuery.Whse_Handling_RPM_SO + ShipCostArchQuery.Whse_Handling_RPM_ST;
            GenOverhRPMOwnFleet := ShipCostArchQuery.Gen_Overheads_RPM_SO;
            WhseOverhRPMOwnFleet := ShipCostArchQuery.Whse_Overheads_RPM_SO;
            WhseHandlRPMOwnFleet := ShipCostArchQuery.Whse_Handling_RPM_SO;
            //HEI.03<<
        
            //HEI.02>>
          END;
          ShipCostArchQuery.CLOSE;
        
          //HEI.03>>
          //filter only by period and OnlyFleet = FALSE
          CLEAR(ShipCostArchQuery);
          ShipCostArchQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostArchQuery.SETRANGE(OwnFleet,TRUE);
          ShipCostArchQuery.OPEN;
          WHILE ShipCostArchQuery.READ DO BEGIN
            RPMAllocatedOwnFleet := ShipCostArchQuery.RPM_SO;
          END;
          ShipCostArchQuery.CLOSE;
          //HEI.03<<
        
        END ELSE BEGIN
          //3rd party
          ShipCostAllocQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostAllocQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Customer);
          ShipCostAllocQuery.SETRANGE(OnlyRPM,FALSE);
          ShipCostAllocQuery.SETRANGE(OwnFleet,FALSE);
          ShipCostAllocQuery.OPEN;
          WHILE ShipCostAllocQuery.READ DO BEGIN
            DelivToCust := ShipCostAllocQuery.InternalTransfer;
            IntTransferAllocated := ShipCostAllocQuery.InternalTransferST;
            //HEI.03>>
            //RPMAllocated := ShipCostAllocQuery.RPM_SO + ShipCostAllocQuery.RPM_ST;
            //HEI.03<<
            GenOvAllocated := ShipCostAllocQuery.TotalGenOverheads + ShipCostAllocQuery.TotalGenOverheadsST;
            WhseOvAllocated := ShipCostAllocQuery.TotalWhseOverheads + ShipCostAllocQuery.TotalWhseOverheadsST;
            WhseHandlAllocated := ShipCostAllocQuery.TotalWhseHandling + ShipCostAllocQuery.TotalWhseHandlingST;
            //HEI.02<<
            GenOverhIT := ShipCostAllocQuery.TotalGenOverheadsST;
            WhseOverhIT := ShipCostAllocQuery.TotalWhseOverheadsST;
            WhseHandlIT := ShipCostAllocQuery.TotalWhseHandlingST;
            //HEI.03>>
            //GenOverhRPM := ShipCostAllocQuery.Gen_Overheads_RPM_SO + ShipCostAllocQuery.Gen_Overheads_RPM_ST;
            //WhseOverhRPM := ShipCostAllocQuery.Whse_Overheads_RPM_SO + ShipCostAllocQuery.Whse_Overheads_RPM_ST;
            //WhseHandlRPM := ShipCostAllocQuery.Whse_Handling_RPM_SO + ShipCostAllocQuery.Whse_Handling_RPM_ST;
            GenOverhRPM := ShipCostAllocQuery.Gen_Overheads_RPM_SO;
            WhseOverhRPM := ShipCostAllocQuery.Whse_Overheads_RPM_SO;
            WhseHandlRPM := ShipCostAllocQuery.Whse_Handling_RPM_SO;
            //HEI.03<<
        
            //HEI.02>>
          END;
          ShipCostAllocQuery.CLOSE;
        
          //HEI.03>>
          CLEAR(ShipCostAllocQuery);
          ShipCostAllocQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostAllocQuery.SETRANGE(OwnFleet,FALSE);
          ShipCostAllocQuery.OPEN;
          WHILE ShipCostAllocQuery.READ DO BEGIN
            RPMAllocated := ShipCostAllocQuery.RPM_SO;
          END;
          ShipCostAllocQuery.CLOSE;
          //HEI.03<<
        
          //Own fleet
          CLEAR(ShipCostAllocQuery);
          ShipCostAllocQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostAllocQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Customer);
          ShipCostAllocQuery.SETRANGE(OnlyRPM,FALSE);
          ShipCostAllocQuery.SETRANGE(OwnFleet,TRUE);
          ShipCostAllocQuery.OPEN;
          WHILE ShipCostAllocQuery.READ DO BEGIN
            DelivToCustOwnFleet := ShipCostAllocQuery.InternalTransfer;
            IntTransferAllocatedOwnFleet := ShipCostAllocQuery.InternalTransferST;
            //HEI.03>>
            //RPMAllocatedOwnFleet := ShipCostAllocQuery.RPM_SO + ShipCostAllocQuery.RPM_ST;
            //HEI.03<<
            GenOvAllocated += ShipCostAllocQuery.TotalGenOverheads + ShipCostAllocQuery.TotalGenOverheadsST;
            WhseOvAllocated += ShipCostAllocQuery.TotalWhseOverheads + ShipCostAllocQuery.TotalWhseOverheadsST;
            WhseHandlAllocated += ShipCostAllocQuery.TotalWhseHandling + ShipCostAllocQuery.TotalWhseHandlingST;
            //HEI.02<<
            GenOverhITOwnFleet := ShipCostAllocQuery.TotalGenOverheadsST;
            WhseOverhITOwnFleet := ShipCostAllocQuery.TotalWhseOverheadsST;
            WhseHandlITOwnFleet := ShipCostAllocQuery.TotalWhseHandlingST;
            //HEI.03>>
            //GenOverhRPMOwnFleet := ShipCostAllocQuery.Gen_Overheads_RPM_SO + ShipCostAllocQuery.Gen_Overheads_RPM_ST;
            //WhseOverhRPMOwnFleet := ShipCostAllocQuery.Whse_Overheads_RPM_SO + ShipCostAllocQuery.Whse_Overheads_RPM_ST;
            //WhseHandlRPMOwnFleet := ShipCostAllocQuery.Whse_Handling_RPM_SO + ShipCostAllocQuery.Whse_Handling_RPM_ST;
            GenOverhRPMOwnFleet := ShipCostAllocQuery.Gen_Overheads_RPM_SO;
            WhseOverhRPMOwnFleet := ShipCostAllocQuery.Whse_Overheads_RPM_SO;
            WhseHandlRPMOwnFleet := ShipCostAllocQuery.Whse_Handling_RPM_SO;
            //HEI.03<<
        
            //HEI.02>>
          END;
          ShipCostAllocQuery.CLOSE;
        
          //HEI.03>>
          CLEAR(ShipCostAllocQuery);
          ShipCostAllocQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostAllocQuery.SETRANGE(OwnFleet,TRUE);
          ShipCostAllocQuery.OPEN;
          WHILE ShipCostAllocQuery.READ DO BEGIN
            RPMAllocatedOwnFleet := ShipCostAllocQuery.RPM_SO;
          END;
          ShipCostAllocQuery.CLOSE;
          //HEI.03<<
        
        END;
        */
        //HEI.09<<

    end;

    local procedure GetArchiveValues(var ShipArchive: Record "Shipping Cost Archive FND"; var Rec: Record "C2S Reconciliation FND");
    // BC Upgrade POENAB02 >>
    // code commented, as "Posted Document Shipping Cost" belongs to Aptean
    //var
    //    TempPostedDoc: Record "Posted Document Shipping Cost" temporary;
    // BC Upgrade POENAB02 <<
    //POENAB02, 11.06.2026>>
    var
    // TempPostedDoc: Record "Posted Trade Cost Order APS" temporary;Unused variable
    //POENAB02, 11.06.2026<<
    begin
        //HEI.09>> - deprecated
        /*
        IF ShipArchive."Own Fleet" THEN BEGIN
          Rec."Total Own Fleet" += ShipArchive."Primary Allocated Amount";
          //HEI.02<<
          Rec."Total Gen. Overh. OwnF." += ShipArchive."General Overheads";
          Rec."Total Whse. Handl. OwnF." += ShipArchive."Warehouse Handling";
          Rec."Total Whse. Overh. OwnF." += ShipArchive."Warehouse Overheads";
          //HEI.02>>
          IF Rec.Description = Rec.Description::Line2 THEN BEGIN
            Rec."Allocated Own Fleet" += ShipArchive."Primary Allocated Amount";
            //HEI.02<<
            Rec."Allocated Gen. Overh. OwnF." += ShipArchive."General Overheads";
            Rec."Allocated Whse. Handl. OwnF." += ShipArchive."Warehouse Handling";
            Rec."Allocated Whse. Overh. OwnF." += ShipArchive."Warehouse Overheads";
          END;
            //HEI.02>>
        END ELSE BEGIN
          Rec."Total 3rd Party" += ShipArchive."Primary Allocated Amount";
          //HEI.02<<
          Rec."Total Gen. Overh. 3rd P." += ShipArchive."General Overheads";
          Rec."Total Whse. Handl. 3rd P." += ShipArchive."Warehouse Handling";
          Rec."Total Whse. Overh. 3rd P." += ShipArchive."Warehouse Overheads";
          //HEI.02>>
          IF Rec.Description = Rec.Description::Line2 THEN BEGIN
            Rec."Allocated 3rd Party" += ShipArchive."Primary Allocated Amount";
            //HEI.02<<
            Rec."Allocated Gen. Overh. 3rd P." += ShipArchive."General Overheads";
            Rec."Allocated Whse. Handl. 3rd P." += ShipArchive."Warehouse Handling";
            Rec."Allocated Whse. Overh. 3rd P." += ShipArchive."Warehouse Overheads";
          END;
            //HEI.02>>
        END;
        
        PostedDocShippingCost.RESET;
        PostedDocShippingCost.SETRANGE("Posting Date",StartingDate,EndingDate);
        PostedDocShippingCost.SETRANGE("Source No.",ShipArchive."No.");
        IF PostedDocShippingCost.FINDFIRST THEN BEGIN
          TempPostedDoc.RESET;
          TempPostedDoc.SETRANGE("Source No.",PostedDocShippingCost."Source No.");
          IF NOT TempPostedDoc.FINDFIRST THEN BEGIN
            TempPostedDoc.INIT;
            TempPostedDoc.TRANSFERFIELDS(PostedDocShippingCost);
            TempPostedDoc.INSERT;
            IF (STRPOS(InventorySetup."Finished Goods Item Cat Code",ShipArchive."Item Category Code") = 0) AND (STRPOS(SalesSetup."RPM Related Item Category Code",ShipArchive."Item Category Code") = 0) THEN
              //HEI.06>>
              //Rec."Shipment of non FG" += TempPostedDoc."Cost Amount";
              Rec."Shipment of non FG" += CalcAmtInLCY(TempPostedDoc);
              //HEI.06<<
            IF ShipAllocation.Reversed THEN
              //HEI.06>>
              //Rec."Reversed Entries" += TempPostedDoc."Cost Amount";
              Rec."Reversed Entries" += CalcAmtInLCY(TempPostedDoc);
              //HEI.06<<
          END;
        END ELSE
          IF NOT ShipArchive."Own Fleet" THEN
            Rec."Missing Shipments" += ShipArchive."Primary Allocated Amount";
        */
        //HEI.09<<

    end;

    local procedure GetAllocationValues(var ShipAllocation: Record "Shipping Cost Allocation FND"; var Rec: Record "C2S Reconciliation FND");
    // BC Upgrade POENAB02 >>
    // code commented, as "Posted Document Shipping Cost" belongs to Aptean
    //var        
    //    TempPostedDoc: Record "Posted Document Shipping Cost" temporary;
    // BC Upgrade POENAB02 <<
    //POENAB02, 11.06.2026>>
    var
        TempPostedDoc: Record "Posted Trade Cost Order APS" temporary;
    //POENAB02, 11.06.2026<<
    begin
        if ShipAllocation."Own Fleet" then begin
            Rec."Total Own Fleet" += ShipAllocation."Primary Allocated Amount";
            //HEI.02<<
            Rec."Total Gen. Overh. OwnF." += ShipAllocation."General Overheads";
            Rec."Total Whse. Handl. OwnF." += ShipAllocation."Warehouse Handling";
            Rec."Total Whse. Overh. OwnF." += ShipAllocation."Warehouse Overheads";
            //HEI.02>>
            if Rec.Description = Rec.Description::Line2 then begin
                Rec."Allocated Own Fleet" += ShipAllocation."Primary Allocated Amount";
                //HEI.02<<
                Rec."Allocated Gen. Overh. OwnF." += ShipAllocation."General Overheads";
                Rec."Allocated Whse. Handl. OwnF." += ShipAllocation."Warehouse Handling";
                Rec."Allocated Whse. Overh. OwnF." += ShipAllocation."Warehouse Overheads";
            end;
            //HEI.02>>
        end else begin
            Rec."Total 3rd Party" += ShipAllocation."Primary Allocated Amount";
            //HEI.02<<
            Rec."Total Gen. Overh. 3rd P." += ShipAllocation."General Overheads";
            Rec."Total Whse. Handl. 3rd P." += ShipAllocation."Warehouse Handling";
            Rec."Total Whse. Overh. 3rd P." += ShipAllocation."Warehouse Overheads";
            //HEI.02>>
            if Rec.Description = Rec.Description::Line2 then begin
                Rec."Allocated 3rd Party" += ShipAllocation."Primary Allocated Amount";
                //HEI.02<<
                Rec."Allocated Gen. Overh. 3rd P." += ShipAllocation."General Overheads";
                Rec."Allocated Whse. Handl. 3rd P." += ShipAllocation."Warehouse Handling";
                Rec."Allocated Whse. Overh. 3rd P." += ShipAllocation."Warehouse Overheads";
            end;
            //HEI.02>>
        end;

        //POENAB02, 11.06.2026>>
        /*
        PostedDocShippingCost.Reset();
        PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
        PostedDocShippingCost.SetRange("Source No.", ShipAllocation."No.");
        if PostedDocShippingCost.FindFirst then begin
            TempPostedDoc.Reset();
            TempPostedDoc.SetRange("Source No.", PostedDocShippingCost."Source No.");
            if not TempPostedDoc.FindFirst then begin
                TempPostedDoc.Init;
                TempPostedDoc.TransferFields(PostedDocShippingCost);
                TempPostedDoc.Insert;
                if (STRPOS(InventorySetup."Finished Goods Item Cat Code", ShipAllocation."Item Category Code") = 0) and (STRPOS(SalesSetup."RPM Related Item Category Code", ShipAllocation."Item Category Code") = 0) then
                    //HEI.06>>
                    //Rec."Shipment of non FG" += TempPostedDoc."Cost Amount";
                    Rec."Shipment of non FG" += CalcAmtInLCY(TempPostedDoc);
                //HEI.06<<
                if ShipAllocation.Reversed then
                    //HEI.06>>
                    //Rec."Reversed Entries" += TempPostedDoc."Cost Amount";
                    Rec."Reversed Entries" += CalcAmtInLCY(TempPostedDoc);
                //HEI.06<<
            end;
        end else
            if not ShipAllocation."Own Fleet" then
                Rec."Missing Shipments" += ShipAllocation."Primary Allocated Amount";
        */


        //POENAB02, 11.06.2026
        PostedDocShippingCost.Reset();
        PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
        PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
        if PostedDocShippingCost.FindFirst() then begin
            TempPostedDoc.Reset();
            TempPostedDoc.SetRange("Posted Whse. Shipment No.", PostedDocShippingCost."Posted Whse. Shipment No.");
            if not TempPostedDoc.FindFirst() then begin
                TempPostedDoc.Init();
                TempPostedDoc.TransferFields(PostedDocShippingCost);
                TempPostedDoc.Insert();
                if (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", ShipAllocation."Item Category Code") = 0) and (STRPOS(SalesSetup."RPMRelatedItemCategoryCode FND", ShipAllocation."Item Category Code") = 0) then
                    Rec."Shipment of non FG" += CalcAmtInLCY(TempPostedDoc);
                if ShipAllocation.Reversed then
                    Rec."Reversed Entries" += CalcAmtInLCY(TempPostedDoc);
            end;
        end else
            if not ShipAllocation."Own Fleet" then
                Rec."Missing Shipments" += ShipAllocation."Primary Allocated Amount";

        PostedDocShippingCost.Reset();
        PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
        PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
        if PostedDocShippingCost.FindFirst() then begin
            TempPostedDoc.Reset();
            TempPostedDoc.SetRange("Posted Whse. Receipt No.", PostedDocShippingCost."Posted Whse. Receipt No.");
            if not TempPostedDoc.FindFirst() then begin
                TempPostedDoc.Init();
                TempPostedDoc.TransferFields(PostedDocShippingCost);
                TempPostedDoc.Insert();
                if (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", ShipAllocation."Item Category Code") = 0) and (STRPOS(SalesSetup."RPMRelatedItemCategoryCode FND", ShipAllocation."Item Category Code") = 0) then
                    Rec."Shipment of non FG" += CalcAmtInLCY(TempPostedDoc);
                if ShipAllocation.Reversed then
                    Rec."Reversed Entries" += CalcAmtInLCY(TempPostedDoc);
            end;
        end else
            if not ShipAllocation."Own Fleet" then
                Rec."Missing Shipments" += ShipAllocation."Primary Allocated Amount";
        //POENAB02, 11.06.2026<<
    end;

    local procedure InitValues();
    begin
        IntTransferAllocated := 0;
        RPMAllocated := 0;
        GenOvAllocated := 0;
        WhseHandlAllocated := 0;
        WhseOvAllocated := 0;
        IntTransferAllocatedOwnFleet := 0;
        RPMAllocatedOwnFleet := 0;
        GenOvAllocatedOwnFleet := 0;
        WhseHandlAllocatedOwnFleet := 0;
        WhseOvAllocatedOwnFleet := 0;
    end;

    local procedure CalcTotals(var Reconcilation: Record "C2S Reconciliation FND");
    begin
        //HEI.09>> - deprecated
        /*
        Reconcilation.Allocated := Reconcilation."Allocated 3rd Party" + Reconcilation."Allocated Own Fleet";
        Reconcilation.Total := Reconcilation."Total 3rd Party" + Reconcilation."Total Own Fleet";
        Reconcilation."Unallocated 3rd Party" := Reconcilation."Total 3rd Party" - Reconcilation."Allocated 3rd Party";
        Reconcilation."Unallocated Own Fleet" := Reconcilation."Total Own Fleet" - Reconcilation."Allocated Own Fleet";
        Reconcilation.Unallocated := Reconcilation.Total - Reconcilation.Allocated;
        //HEI.02>>
        //General Overheads
        Reconcilation."Total Gen. Overh." := Reconcilation."Total Gen. Overh. 3rd P." + Reconcilation."Total Gen. Overh. OwnF.";
        Reconcilation."Allocated Gen. Overh." := Reconcilation."Allocated Gen. Overh. 3rd P." + Reconcilation."Allocated Gen. Overh. OwnF.";
        Reconcilation."Unallocated Gen. Overh." := Reconcilation."Total Gen. Overh." - Reconcilation."Allocated Gen. Overh.";
        Reconcilation."Unallocated Gen. Overh. 3rd P." := Reconcilation."Total Gen. Overh. 3rd P." - Reconcilation."Allocated Gen. Overh. 3rd P.";
        Reconcilation."Unallocated Gen. Overh. OwnF." := Reconcilation."Total Gen. Overh. OwnF." - Reconcilation."Allocated Gen. Overh. OwnF.";
        //Warehouse Overheads
        Reconcilation."Total Whse. Overh." := Reconcilation."Total Whse. Overh. 3rd P." + Reconcilation."Total Whse. Overh. OwnF.";
        Reconcilation."Allocated Whse. Overh." := Reconcilation."Allocated Whse. Overh. 3rd P." + Reconcilation."Allocated Whse. Overh. OwnF.";
        Reconcilation."Unallocated Whse. Overh." := Reconcilation."Total Whse. Overh." - Reconcilation."Allocated Whse. Overh.";
        Reconcilation."Unallocated Whs. Overh. 3rd P." := Reconcilation."Total Whse. Overh. 3rd P." - Reconcilation."Allocated Whse. Overh. 3rd P.";
        Reconcilation."Unallocated Whse. Overh. OwnF." := Reconcilation."Total Whse. Overh. OwnF." - Reconcilation."Allocated Whse. Overh. OwnF.";
        //warehouse Handling
        Reconcilation."Total Whse. Handl." := Reconcilation."Total Whse. Handl. 3rd P." + Reconcilation."Total Whse. Handl. OwnF.";
        Reconcilation."Allocated Whse. Handl." := Reconcilation."Allocated Whse. Handl. 3rd P." + Reconcilation."Allocated Whse. Handl. OwnF.";
        Reconcilation."Unallocated Whse. Handl." := Reconcilation."Total Whse. Handl." - Reconcilation."Allocated Whse. Handl.";
        Reconcilation."Unallocated Whs. Handl. 3rd P." := Reconcilation."Total Whse. Handl. 3rd P." - Reconcilation."Allocated Whse. Handl. 3rd P.";
        Reconcilation."Unallocated Whse. Handl. OwnF." := Reconcilation."Total Whse. Handl. OwnF." - Reconcilation."Allocated Whse. Handl. OwnF.";
        //HEI.02<<
        */
        //HEI.09<<

    end;

    local procedure GetPostedDocShipCostValues(var Rec: Record "C2S Reconciliation FND");
    var
        // BC Upgrade POENAB02 >>
        // code commented, as "Posted Document Shipping Cost" belongs to Aptean
        // PostedDocShipCost: Record "Posted Document Shipping Cost";
        // BC Upgrade POENAB02 <<
        ShippingAgent: Record "Shipping Agent";
        CostAmountLCY: Decimal;
        PostedDocShipCost: Record "Posted Trade Cost Order APS"; //POENAB02, 11.06.2026
    begin
        PostedDocShipCost.Reset();
        PostedDocShipCost.SetCurrentKey("Posting Date");
        PostedDocShipCost.SetRange("Posting Date", StartingDate, EndingDate);
        if PostedDocShipCost.FindSet() then
            repeat
                ShippingAgent.Reset();
                //HEI.06>>
                /*
                IF ShippingAgent.GET(PostedDocShipCost."Shipping Agent Code") THEN
                  IF ShippingAgent."Own Logistics" THEN
                    Rec."Total Own Fleet" += PostedDocShipCost."Cost Amount"
                  ELSE
                    Rec."Total 3rd Party" += PostedDocShipCost."Cost Amount";
                 */
                if ShippingAgent.Get(PostedDocShipCost."Shipping Agent Code") then begin
                    CostAmountLCY := CalcAmtInLCY(PostedDocShipCost);
                    //POENAB02, 11.06.2026>>
                    //if ShippingAgent."Own Logistics" then
                    if ShippingAgent."Own Logistics FND" then
                        //POENAB02, 11.06.2026<<
                        Rec."Total Own Fleet" += CostAmountLCY
                    else
                        Rec."Total 3rd Party" += CostAmountLCY;
                end;
            //HEI.06<<
            until PostedDocShipCost.Next() = 0;
    end;

    local procedure CalcFinancialValues(var Rec: Record "C2S Reconciliation FND"; OwnFleet: Boolean): Decimal;
    begin
        //HEI.09>> - deprecated
        /*
        IF Archived THEN BEGIN
          IF NOT OwnFleet THEN BEGIN
            //3rd party archive
            ShipArchive.RESET;
            ShipArchive.SETCURRENTKEY("Posting Date","Destination Type","Only RPM Transportation");
            ShipArchive.SETRANGE("Posting Date",StartingDate,EndingDate);
            ShipArchive.SETRANGE("Destination Type",ShipArchive."Destination Type"::Customer);
            ShipArchive.SETRANGE("Only RPM Transportation",FALSE);
            ShipArchive.SETFILTER("Item Category Code",InventorySetup."Finished Goods Item Cat Code");
            ShipArchive.SETRANGE("Own Fleet",FALSE);
            IF ShipArchive.FINDFIRST THEN
              CASE Rec.Description OF
                Rec.Description::"Period G/L Cost Delivery to Customer":
                  EXIT(ShipArchive."Period G/L Cost Delivery Cust.");
                Rec.Description::"Posted Doc. Shipping Cost":
                  EXIT(ShipArchive."Period G/L Cost Delivery Cust.");
                Rec.Description::"Period G/L Cost Gen. Overheads":
                  EXIT(ShipArchive."Period G/L Cost Gen. Overheads");
                Rec.Description::"Period G/L Cost Whse. Handling":
                  EXIT(ShipArchive."Period G/L Cost Whse. Handling");
                Rec.Description::"Period G/L Cost Whse. Overhead":
                  EXIT(ShipArchive."Period G/L Cost Whse. Overhead");
              END;
           END ELSE BEGIN
             //Own Fleet archive
            ShipArchive.RESET;
            ShipArchive.SETCURRENTKEY("Posting Date","Destination Type","Only RPM Transportation");
            ShipArchive.SETRANGE("Posting Date",StartingDate,EndingDate);
            //HEI.08>>
            {
            ShipArchive.SETRANGE("Destination Type",ShipArchive."Destination Type"::Customer);
            ShipArchive.SETRANGE("Only RPM Transportation",FALSE);
            ShipArchive.SETRANGE("Own Fleet",TRUE);
            }
            //HEI.08<<
            //HEI.04>>
            ShipArchive.SETFILTER("Period G/L Cost Own Fleet",'<>%1',0);
            //HEI.04<<
            IF ShipArchive.FINDFIRST THEN
              EXIT(ShipArchive."Period G/L Cost Own Fleet");
           END;
        END ELSE BEGIN
          //3rd party allocation
          IF NOT OwnFleet THEN BEGIN
            ShipAllocation.RESET;
            ShipAllocation.SETCURRENTKEY("Posting Date","Destination Type","Only RPM Transportation");
            ShipAllocation.SETRANGE("Posting Date",StartingDate,EndingDate);
            ShipAllocation.SETRANGE("Destination Type",ShipAllocation."Destination Type"::Customer);
            ShipAllocation.SETRANGE("Only RPM Transportation",FALSE);
            ShipAllocation.SETFILTER("Item Category Code",InventorySetup."Finished Goods Item Cat Code");
            ShipAllocation.SETRANGE("Own Fleet",FALSE);
            IF ShipAllocation.FINDFIRST THEN
              CASE Rec.Description OF
                Rec.Description::"Period G/L Cost Delivery to Customer":
                  EXIT(ShipAllocation."Period G/L Cost Delivery Cust.");
                Rec.Description::"Posted Doc. Shipping Cost":
                  EXIT(ShipAllocation."Period G/L Cost Delivery Cust.");
                Rec.Description::"Period G/L Cost Gen. Overheads":
                  EXIT(ShipAllocation."Period G/L Cost Gen. Overheads");
                Rec.Description::"Period G/L Cost Whse. Handling":
                  EXIT(ShipAllocation."Period G/L Cost Whse. Handling");
                Rec.Description::"Period G/L Cost Whse. Overhead":
                  EXIT(ShipAllocation."Period G/L Cost Whse. Overhead");
              END;
          END ELSE BEGIN
            //Own fleet allocation
            ShipAllocation.RESET;
            ShipAllocation.SETCURRENTKEY("Posting Date","Destination Type","Only RPM Transportation");
            ShipAllocation.SETRANGE("Posting Date",StartingDate,EndingDate);
            //HEI.08>>
            {
            ShipAllocation.SETRANGE("Destination Type",ShipAllocation."Destination Type"::Customer);
            ShipAllocation.SETRANGE("Only RPM Transportation",FALSE);
            ShipAllocation.SETRANGE("Own Fleet",TRUE);
            }
            //HEI.08<<
            //HEI.04>>
            ShipAllocation.SETFILTER("Period G/L Cost Own Fleet",'<>%1',0);
            //HEI.04<<
            IF ShipAllocation.FINDFIRST THEN
              EXIT(ShipAllocation."Period G/L Cost Own Fleet");
          END;
        END;
        */
        //HEI.09<<

    end;

    local procedure CalcAllocatedAmountsRPMIT();
    var
        ShipCostAllocQuery: Query "Shipping Cost Allocation";
        Rec: Record "C2S Reconciliation FND";
        ShipCostArchQuery: Query "Shipping Cost Archive";
    begin
        //HEI.09>> - deprecated
        /*
        //HEI.03>>
        
        IF Archived THEN BEGIN
          //3rd party
          ShipCostArchQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          //ShipCostArchQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Location);
          //ShipCostArchQuery.SETRANGE(OnlyRPM,TRUE);
          ShipCostArchQuery.SETRANGE(OwnFleet,FALSE);
          ShipCostArchQuery.OPEN;
          WHILE ShipCostArchQuery.READ DO BEGIN
            RPMInternalTransferAllocated  := ShipCostArchQuery.RPM_ST;
            //HEI.05>>
            RPMInternalTransferGenOverh   := ShipCostArchQuery.Gen_Overheads_RPM_ST;
            RPMInternalTransferWhseOver   := ShipCostArchQuery.Whse_Overheads_RPM_ST;
            RPMInternalTransferWhseHandl  := ShipCostArchQuery.Whse_Handling_RPM_ST;
            //HEI.05<<
          END;
          ShipCostArchQuery.CLOSE;
        
          //HEI.05>>
          {
          CLEAR(ShipCostArchQuery);
          ShipCostArchQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostArchQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Customer);
          ShipCostArchQuery.SETRANGE(OnlyRPM,TRUE);
          ShipCostArchQuery.SETRANGE(OwnFleet,FALSE);
          ShipCostArchQuery.OPEN;
          WHILE ShipCostArchQuery.READ DO BEGIN
            RPMInternalTransferGenOverh   := ShipCostArchQuery.Gen_Overheads_RPM_ST;
            RPMInternalTransferWhseOver   := ShipCostArchQuery.Whse_Overheads_RPM_ST;
            RPMInternalTransferWhseHandl  := ShipCostArchQuery.Whse_Handling_RPM_ST;
          END;
          ShipCostArchQuery.CLOSE;
          }
          //HEI.05<<
        
          //Own fleet
          CLEAR(ShipCostArchQuery);
          ShipCostArchQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          //ShipCostArchQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Location);
          //ShipCostArchQuery.SETRANGE(OnlyRPM,TRUE);
          ShipCostArchQuery.SETRANGE(OwnFleet,TRUE);
          ShipCostArchQuery.OPEN;
          WHILE ShipCostArchQuery.READ DO BEGIN
            RPMInternalTransferAllocatedOwnFleet  := ShipCostArchQuery.RPM_ST;
            //HEI.05>>
            RPMInternalTransferGenOverhOwnFleet   := ShipCostArchQuery.Gen_Overheads_RPM_ST;
            RPMInternalTransferWhseOverOwnFleet   := ShipCostArchQuery.Whse_Overheads_RPM_ST;
            RPMInternalTransferWhseHandlOwnFleet  := ShipCostArchQuery.Whse_Handling_RPM_ST;
            //HEI.05<<
          END;
          ShipCostArchQuery.CLOSE;
        
          //HEI.05>>
          {
          CLEAR(ShipCostArchQuery);
          ShipCostArchQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostArchQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Customer);
          ShipCostArchQuery.SETRANGE(OnlyRPM,TRUE);
          ShipCostArchQuery.SETRANGE(OwnFleet,TRUE);
          ShipCostArchQuery.OPEN;
          WHILE ShipCostArchQuery.READ DO BEGIN
            RPMInternalTransferGenOverhOwnFleet   := ShipCostArchQuery.Gen_Overheads_RPM_ST;
            RPMInternalTransferWhseOverOwnFleet   := ShipCostArchQuery.Whse_Overheads_RPM_ST;
            RPMInternalTransferWhseHandlOwnFleet  := ShipCostArchQuery.Whse_Handling_RPM_ST;
          END;
          ShipCostArchQuery.CLOSE;
          }
          //HEI.05<<
        
        END ELSE BEGIN
          //3rd party
          ShipCostAllocQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          //ShipCostAllocQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Location);
          //ShipCostAllocQuery.SETRANGE(OnlyRPM,TRUE);
          ShipCostAllocQuery.SETRANGE(OwnFleet,FALSE);
          ShipCostAllocQuery.OPEN;
          WHILE ShipCostAllocQuery.READ DO BEGIN
            RPMInternalTransferAllocated  := ShipCostAllocQuery.RPM_ST;
            //HEI.05>>
            RPMInternalTransferGenOverh   := ShipCostAllocQuery.Gen_Overheads_RPM_ST;
            RPMInternalTransferWhseOver   := ShipCostAllocQuery.Whse_Overheads_RPM_ST;
            RPMInternalTransferWhseHandl  := ShipCostAllocQuery.Whse_Handling_RPM_ST;
            //HEI.05<<
          END;
          ShipCostAllocQuery.CLOSE;
        
          //HEI.05>>
          {
          CLEAR(ShipCostAllocQuery);
          ShipCostAllocQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostAllocQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Customer);
          ShipCostAllocQuery.SETRANGE(OnlyRPM,TRUE);
          ShipCostAllocQuery.SETRANGE(OwnFleet,FALSE);
          ShipCostAllocQuery.OPEN;
          WHILE ShipCostAllocQuery.READ DO BEGIN
            RPMInternalTransferGenOverh   := ShipCostAllocQuery.Gen_Overheads_RPM_ST;
            RPMInternalTransferWhseOver   := ShipCostAllocQuery.Whse_Overheads_RPM_ST;
            RPMInternalTransferWhseHandl  := ShipCostAllocQuery.Whse_Handling_RPM_ST;
          END;
          ShipCostAllocQuery.CLOSE;
          }
          //HEI.05<<
        
          //Own fleet
          CLEAR(ShipCostAllocQuery);
          ShipCostAllocQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          //ShipCostAllocQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Location);
          //ShipCostAllocQuery.SETRANGE(OnlyRPM,TRUE);
          ShipCostAllocQuery.SETRANGE(OwnFleet,TRUE);
          ShipCostAllocQuery.OPEN;
          WHILE ShipCostAllocQuery.READ DO BEGIN
            RPMInternalTransferAllocatedOwnFleet  := ShipCostAllocQuery.RPM_ST;
            //HEI.05>>
            RPMInternalTransferGenOverhOwnFleet   := ShipCostAllocQuery.Gen_Overheads_RPM_ST;
            RPMInternalTransferWhseOverOwnFleet   := ShipCostAllocQuery.Whse_Overheads_RPM_ST;
            RPMInternalTransferWhseHandlOwnFleet  := ShipCostAllocQuery.Whse_Handling_RPM_ST;
            //HEI.05<<
          END;
          ShipCostAllocQuery.CLOSE;
        
          //HEI.05>>
          {
          CLEAR(ShipCostAllocQuery);
          ShipCostAllocQuery.SETRANGE(PostingDate,StartingDate,EndingDate);
          ShipCostAllocQuery.SETRANGE(DestinationType,ShipArchive."Destination Type"::Customer);
          ShipCostAllocQuery.SETRANGE(OnlyRPM,TRUE);
          ShipCostAllocQuery.SETRANGE(OwnFleet,TRUE);
          ShipCostAllocQuery.OPEN;
          WHILE ShipCostAllocQuery.READ DO BEGIN
            RPMInternalTransferGenOverhOwnFleet   := ShipCostAllocQuery.Gen_Overheads_RPM_ST;
            RPMInternalTransferWhseOverOwnFleet   := ShipCostAllocQuery.Whse_Overheads_RPM_ST;
            RPMInternalTransferWhseHandlOwnFleet  := ShipCostAllocQuery.Whse_Handling_RPM_ST;
          END;
          ShipCostAllocQuery.CLOSE;
          }
          //HEI.05<<
        
        END;
        //HEI.03<<
        */
        //HEI.09<<

    end;

    //POENAB02, 11.06.2026>>
    //local procedure CalcAmtInLCY(PostedDocShipCost: Record "Posted Document Shipping Cost"): Decimal;
    local procedure CalcAmtInLCY(PostedDocShipCost: Record "Posted Trade Cost Order APS"): Decimal;
    //POENAB02, 11.06.2026<<
    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        CostAmountLCY: Decimal;
    begin
        //HEI.06
        if PostedDocShipCost."Currency Code" <> '' then begin
            Currency.InitRoundingPrecision();
            CostAmountLCY :=
              Round(
                CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
                  EndingDate, PostedDocShipCost."Currency Code",
                  //POENAB02, 11.06.2026>>
                  //PostedDocShipCost."Cost Amount", CurrExchRate.ExchangeRateAdjmt(EndingDate, PostedDocShipCost."Currency Code")),
                  PostedDocShipCost.Amount, CurrExchRate.ExchangeRateAdjmt(EndingDate, PostedDocShipCost."Currency Code")),
                  //POENAB02, 11.06.2026<<
                  Currency."Amount Rounding Precision");
        end else
            //POENAB02, 11.06.2026>>
            //CostAmountLCY := PostedDocShipCost."Cost Amount";
            CostAmountLCY := PostedDocShipCost.Amount;
        //POENAB02, 11.06.2026<<
        exit(CostAmountLCY);
    end;

    local procedure InsertTmpReconcilation();
    begin
        //HEI.09>>
        InsertTmpTotal3Party();
        InsertTmpTotalOwnFleet();
        InsertTmpAllocated3rParty();
        InsertTmpAllocatedOwnFleet();

        InsertLines(1, 'Section 1a: Operational', '');

        InsertLines(2, 'Delivery to Customers - SO', 'Primary Allocation - Transportation Costs');
        InsertLines(3, 'FG Internal Transfers - Internal Transfers ST', 'Primary Allocation - Transportation Costs');
        InsertLines(4, 'RPM Transport - RPM SO', 'Primary Allocation - Transportation Costs');
        InsertLines(5, 'RPM Internal Transfers - RPM ST', 'Primary Allocation - Transportation Costs');
        InsertLines(6, 'Subtotal', 'Primary Allocation - Transportation Costs');
        InsertLines(7, 'Posted Doc. Shipping Cost', 'Primary Allocation - Transportation Costs');
        InsertLines(8, 'Check', 'Primary Allocation - Transportation Costs');

        InsertLines(9, 'General Overheads - SO', 'General Overheads');
        InsertLines(10, 'General Overheads - Internal Transfer ST', 'General Overheads');
        InsertLines(11, 'General Overheads RPM Transports SO', 'General Overheads');
        InsertLines(12, 'General Overheads RPM Internal Transfers - RPM ST', 'General Overheads');
        InsertLines(13, 'General Overheads Total', 'General Overheads');

        InsertLines(14, 'Warehouse Overheads - SO', 'Warehouse Overheads');
        InsertLines(15, 'Warehouse Overheads - Internal Transfer ST', 'Warehouse Overheads');
        InsertLines(16, 'Warehouse Overheads RPM SO', 'Warehouse Overheads');
        InsertLines(17, 'Warehouse Overheads RPM ST - RPM ST', 'Warehouse Overheads');
        InsertLines(18, 'Warehouse Overheads Total', 'Warehouse Overheads');

        InsertLines(19, 'Warehouse Handling - SO', 'Warehouse Handling');
        InsertLines(20, 'Warehouse Handling - Internal Transfer ST', 'Warehouse Handling');
        InsertLines(21, 'Warehouse Handling RPM SO', 'Warehouse Handling');
        InsertLines(22, 'Warehouse Handling RPM ST - RPM ST', 'Warehouse Handling');
        InsertLines(23, 'Warehouse Handling Total', 'Warehouse Handling');

        InsertLines(24, '', '');

        if (PrintWhseHandlingSplit) then begin
            InsertLines(25, 'Section 1b: Warehouse Handling Splits', '');

            InsertLines(26, 'Warehouse Handling FIX - SO', 'Warehouse Handling FIX');
            InsertLines(27, 'Warehouse Handling FIX - Internal Transfer ST', 'Warehouse Handling FIX');
            InsertLines(28, 'Warehouse Handling FIX - RPM SO', 'Warehouse Handling FIX');
            InsertLines(29, 'Warehouse Handling FIX - RPM ST', 'Warehouse Handling FIX');
            InsertLines(30, 'Warehouse Handling FIX Total', 'Warehouse Handling FIX');

            InsertLines(31, 'Warehouse Handling OVE - SO', 'Warehouse Handling OVE');
            InsertLines(32, 'Warehouse Handling OVE - Internal Transfer ST', 'Warehouse Handling OVE');
            InsertLines(33, 'Warehouse Handling OVE - RPM SO', 'Warehouse Handling OVE');
            InsertLines(34, 'Warehouse Handling OVE - RPM ST', 'Warehouse Handling OVE');
            InsertLines(35, 'Warehouse Handling OVE Total', 'Warehouse Handling OVE');

            InsertLines(36, 'Warehouse Handling TRP - SO', 'Warehouse Handling TRP');
            InsertLines(37, 'Warehouse Handling TRP - Internal Transfer ST', 'Warehouse Handling TRP');
            InsertLines(38, 'Warehouse Handling TRP - RPM SO', 'Warehouse Handling TRP');
            InsertLines(39, 'Warehouse Handling TRP - RPM ST', 'Warehouse Handling TRP');
            InsertLines(40, 'Warehouse Handling TRP Total', 'Warehouse Handling TRP');

            InsertLines(41, 'Warehouse Handling FIX + OVE + TRP', '');
            InsertLines(42, 'Warehouse Handling Checks', '');
            InsertLines(43, '', '');
        end;


        InsertLines(44, '', '');

        InsertLines(45, 'Section 2: Financials', '');

        InsertLines(46, 'Period G/L Cost Delivery to Customer', 'G/L Transportation Cots');
        InsertLines(47, 'Period G/L Own Fleet', 'G/L Transportation Cots');
        InsertLines(48, 'Period G/L Cost Gen. Overheads', 'G/L General Overheads Costs');
        InsertLines(49, 'Period G/L Cost Whse. Overhead', 'G/L Cost Whse. Overhead');
        InsertLines(50, 'Period G/L Cost Whse. Handling', 'G/L Cost Whse. Handling');
        InsertLines(51, 'Total FP&L Logistics', 'G/L Logistics Total');

        if (PrintWhseHandlingSplit) then begin
            InsertLines(52, 'Period G/L Cost Whse. Handling FIX', 'G/L Cost Whse. Handling Splits');
            InsertLines(53, 'Period G/L Cost Whse. Handling OVE', 'G/L Cost Whse. Handling Splits');
            InsertLines(54, 'Period G/L Cost Whse. Handling TRP', 'G/L Cost Whse. Handling Splits');
            InsertLines(55, 'Total Warehouse Handling Splits', 'G/L Cost Whse. Handling Splits Total');
            InsertLines(56, 'Warehouse Handling Checks', 'G/L Cost Whse. Handling Splits Total');
            InsertLines(57, '', '');
        end;


        InsertLines(58, '', '');

        InsertLines(59, 'Section 3: Non C2S Allocated Buckets', '');
        InsertLines(60, 'Reversed Entries', '');
        InsertLines(61, 'Delivery of solely RPM', '');
        InsertLines(62, 'Customer Shipment of non FG', '');
        InsertLines(63, 'Intrenal Transfer Shipment of non FG', '');
        InsertLines(64, 'Missing Shipments', '');
        //HEI.10>>
        //InsertLines(65,'Other Unreconciled Documents','');
        InsertLines(65, 'Other Unreconciled Documents not in scope of C2S', '');
        //HEI.10<<
        InsertLines(66, 'Total', '');
        //HEI.09<<
    end;

    local procedure InsertLines(OptionNo: Integer; LineDescr: Text[250]; BlockDescr: Text[250]);
    begin
        //HEI.09>>
        C2SReconcilationTmp.Init();
        ReturnOptionValue(OptionNo, C2SReconcilationTmp);
        C2SReconcilationTmp."Line Description" := LineDescr;
        C2SReconcilationTmp."Block Description" := BlockDescr;
        C2SReconcilationTmp."Period Date" := PeriodDate;

        if (OptionNo <> 1) and (OptionNo <> 24) and (OptionNo <> 25) and (OptionNo <> 44) and
           (OptionNo <> 24) and (OptionNo <> 43) and (OptionNo <> 44) and (OptionNo <> 57) and
           (OptionNo <> 58) and (OptionNo <> 45)
        then begin

            if (OptionNo = 2) or (OptionNo = 3) or (OptionNo = 4) or (OptionNo = 5) or
              (OptionNo = 9) or (OptionNo = 10) or (OptionNo = 11) or (OptionNo = 12) or
              (OptionNo = 14) or (OptionNo = 15) or (OptionNo = 16) or (OptionNo = 17) or
              (OptionNo = 19) or (OptionNo = 20) or (OptionNo = 21) or (OptionNo = 22) or
              (OptionNo = 26) or (OptionNo = 27) or (OptionNo = 28) or (OptionNo = 29) or
              (OptionNo = 30) or (OptionNo = 31) or (OptionNo = 32) or (OptionNo = 33) or
              (OptionNo = 34) or (OptionNo = 35) or (OptionNo = 36) or (OptionNo = 37) or
              (OptionNo = 38) or (OptionNo = 39) or (OptionNo = 40) or (OptionNo = 41) or
              (OptionNo = 6) or (OptionNo = 13) or (OptionNo = 18) or (OptionNo = 23)
            then begin
                CLEAR(TotalParty);

                CalculateTotal3rPartyAndOwnFleet(OptionNo, false);
                CalculateTotal3rPartyAndOwnFleet(OptionNo, true);

                CalculateAllocated3rPartyAndOwnFleet(OptionNo, false);
                CalculateAllocated3rPartyAndOwnFleet(OptionNo, true);

                C2SReconcilationTmp."Total 3rd Party" := TotalParty[1];
                C2SReconcilationTmp."Allocated 3rd Party" := TotalParty[2];
                C2SReconcilationTmp."Unallocated 3rd Party" := TotalParty[1] - TotalParty[2];

                C2SReconcilationTmp."Total Own Fleet" := TotalParty[3];
                C2SReconcilationTmp."Allocated Own Fleet" := TotalParty[4];
                C2SReconcilationTmp."Unallocated Own Fleet" := TotalParty[3] - TotalParty[4];

                C2SReconcilationTmp.Total := TotalParty[1] + TotalParty[3];
                C2SReconcilationTmp.Allocated := TotalParty[2] + TotalParty[4];
                C2SReconcilationTmp.Unallocated := (TotalParty[1] + TotalParty[3]) - (TotalParty[2] + TotalParty[4]);

                Subtotal[1] += C2SReconcilationTmp."Total 3rd Party";
                Subtotal[2] += C2SReconcilationTmp."Allocated 3rd Party";
                Subtotal[3] += C2SReconcilationTmp."Unallocated 3rd Party";
                Subtotal[4] += C2SReconcilationTmp."Total Own Fleet";
                Subtotal[5] += C2SReconcilationTmp."Allocated Own Fleet";
                Subtotal[6] += C2SReconcilationTmp."Unallocated Own Fleet";
                Subtotal[7] += C2SReconcilationTmp.Total;
                Subtotal[8] += C2SReconcilationTmp.Allocated;
                Subtotal[9] += C2SReconcilationTmp.Unallocated;
            end;

            if (OptionNo = 6) or (OptionNo = 13) or (OptionNo = 18) or (OptionNo = 23) or
               (OptionNo = 30) or (OptionNo = 35) or (OptionNo = 40)
            then begin
                C2SReconcilationTmp."Total 3rd Party" := Subtotal[1];
                C2SReconcilationTmp."Allocated 3rd Party" := Subtotal[2];
                C2SReconcilationTmp."Unallocated 3rd Party" := Subtotal[3];

                C2SReconcilationTmp."Total Own Fleet" := Subtotal[4];
                C2SReconcilationTmp."Allocated Own Fleet" := Subtotal[5];
                C2SReconcilationTmp."Unallocated Own Fleet" := Subtotal[6];

                C2SReconcilationTmp.Total := Subtotal[7];
                C2SReconcilationTmp.Allocated := Subtotal[8];
                C2SReconcilationTmp.Unallocated := Subtotal[9];

                if (OptionNo <> 6) then
                    Clear(Subtotal);

                CalcWhseHandSplitTotalsAndChecks(OptionNo);
                case OptionNo of
                    6:
                        begin
                            PeriodGLAlloc3rdParty := C2SReconcilationTmp."Allocated 3rd Party";
                            PeriodGLAllocOwnFleet := C2SReconcilationTmp."Allocated Own Fleet";
                        end;
                    13:
                        PeriodGLAlloc[1] := C2SReconcilationTmp.Allocated;
                    18:
                        PeriodGLAlloc[2] := C2SReconcilationTmp.Allocated;
                    23:
                        PeriodGLAlloc[3] := C2SReconcilationTmp.Allocated;
                    30:
                        PeriodGLAlloc[4] := C2SReconcilationTmp.Allocated;
                    35:
                        PeriodGLAlloc[5] := C2SReconcilationTmp.Allocated;
                    40:
                        PeriodGLAlloc[6] := C2SReconcilationTmp.Allocated;
                end;
            end;

            if (OptionNo = 7) then begin
                GetPostedDocShipCostValues(C2SReconcilationTmp);
                C2SReconcilationTmp.Total := C2SReconcilationTmp."Total 3rd Party" + C2SReconcilationTmp."Total Own Fleet";
                //HEI.10>>
                /*
                CheckValues[1] := Subtotal[1] - C2SReconcilationTmp."Total 3rd Party";
                CheckValues[2] := Subtotal[4] - C2SReconcilationTmp."Total Own Fleet";
                CheckValues[3] := Subtotal[7] - C2SReconcilationTmp.Total;
                */
                CheckValues[1] := C2SReconcilationTmp."Total 3rd Party" - Subtotal[1];
                CheckValues[2] := C2SReconcilationTmp."Total Own Fleet" - Subtotal[4];
                CheckValues[3] := C2SReconcilationTmp.Total - Subtotal[7];
                //HEI.10<<
                CLEAR(Subtotal);
            end;

            if (OptionNo = 8) then //begin //Bc Upgrade Blocked due to warning begin end can be used with multiple lines.
                C2SReconcilationTmp."Total 3rd Party" := CheckValues[1];
            //HEI.10>>
            /*
            C2SReconcilationTmp."Total Own Fleet" := CheckValues[2];
            C2SReconcilationTmp.Total             := CheckValues[3];
            */
            //HEI.10<<
            // end;

            if (OptionNo = 41) then begin
                C2SReconcilationTmp."Total 3rd Party" := SumWhseHandlingSplit[1];
                C2SReconcilationTmp."Allocated 3rd Party" := SumWhseHandlingSplit[2];
                C2SReconcilationTmp."Unallocated 3rd Party" := SumWhseHandlingSplit[3];

                C2SReconcilationTmp."Total Own Fleet" := SumWhseHandlingSplit[4];
                C2SReconcilationTmp."Allocated Own Fleet" := SumWhseHandlingSplit[5];
                C2SReconcilationTmp."Unallocated Own Fleet" := SumWhseHandlingSplit[6];

                C2SReconcilationTmp.Total := SumWhseHandlingSplit[7];
                C2SReconcilationTmp.Allocated := SumWhseHandlingSplit[8];
                C2SReconcilationTmp.Unallocated := SumWhseHandlingSplit[9];
            end;

            if (OptionNo = 42) then begin
                C2SReconcilationTmp."Total 3rd Party" := SumWhseHandlingSplit[1] - DiffWhseHandlingSplit[1];
                C2SReconcilationTmp."Allocated 3rd Party" := SumWhseHandlingSplit[2] - DiffWhseHandlingSplit[2];
                C2SReconcilationTmp."Unallocated 3rd Party" := SumWhseHandlingSplit[3] - DiffWhseHandlingSplit[3];

                C2SReconcilationTmp."Total Own Fleet" := SumWhseHandlingSplit[4] - DiffWhseHandlingSplit[4];
                C2SReconcilationTmp."Allocated Own Fleet" := SumWhseHandlingSplit[5] - DiffWhseHandlingSplit[5];
                C2SReconcilationTmp."Unallocated Own Fleet" := SumWhseHandlingSplit[6] - DiffWhseHandlingSplit[6];

                C2SReconcilationTmp.Total := SumWhseHandlingSplit[7] - DiffWhseHandlingSplit[7];
                C2SReconcilationTmp.Allocated := SumWhseHandlingSplit[8] - DiffWhseHandlingSplit[8];
                C2SReconcilationTmp.Unallocated := SumWhseHandlingSplit[9] - DiffWhseHandlingSplit[9];

                Clear(DiffWhseHandlingSplit);
                Clear(SumWhseHandlingSplit);
            end;

            if (OptionNo = 46) or (OptionNo = 47) or (OptionNo = 48) or (OptionNo = 49) or
               (OptionNo = 50) or (OptionNo = 51) or (OptionNo = 52) or (OptionNo = 53) or
               (OptionNo = 54) or (OptionNo = 55) or (OptionNo = 56)
            then
                CalcPeriodGL(OptionNo, C2SReconcilationTmp);

            if (OptionNo = 60) or (OptionNo = 61) or (OptionNo = 62) or (OptionNo = 63) or
               (OptionNo = 64) or (OptionNo = 65)
            then
                CalcSection3(OptionNo);

            if (OptionNo = 66) then begin
                C2SReconcilationTmp."Total 3rd Party" := TotalSection3[1];
                C2SReconcilationTmp."Total Own Fleet" := TotalSection3[2];
                C2SReconcilationTmp.Total := TotalSection3[3];
            end;


        end;
        C2SReconcilationTmp.Insert();
        //HEI.09<<

    end;

    local procedure CalculateTotal3rPartyAndOwnFleet(LineNo: Integer; OwnFleet: Boolean);
    var
        lEntryNo: Integer;
        i: Integer;
    begin
        //HEI.09>>
        if OwnFleet = false then begin
            case LineNo of
                2, 9, 14, 19, 26, 31, 36:
                    lEntryNo := 1;
                // BC Upgrade POENAB02 >>
                // code redesigned, as expression "33" was duplicated in two case options
                // needs to be checked with option is the correct one
                /*
                4, 11, 16, 21, 28, 33, 38:
                    lEntryNo := 2;
                3, 10, 15, 20, 27, 33, 37:
                    lEntryNo := 3;
                */
                4, 11, 16, 21, 28, 38:
                    lEntryNo := 2;
                3, 10, 15, 20, 27, 33, 37:
                    lEntryNo := 3;
                // BC Upgrade POENAB02 <<
                5, 12, 17, 22, 29, 34, 39:
                    lEntryNo := 4;
            end;
            i := 1;
        end else begin
            case LineNo of
                2, 9, 14, 19, 26, 31, 36:
                    lEntryNo := 5;
                // BC Upgrade POENAB02 >>
                // code redesigned, as expression "33" was duplicated in two case options
                // needs to be checked with option is the correct one
                /*                    
                4, 11, 16, 21, 28, 33, 38:
                    lEntryNo := 6;
                3, 10, 15, 20, 27, 33, 37:
                    lEntryNo := 7;
                */
                4, 11, 16, 21, 28, 38:
                    lEntryNo := 6;
                3, 10, 15, 20, 27, 33, 37:
                    lEntryNo := 7;
                // BC Upgrade POENAB02 <<
                5, 12, 17, 22, 29, 34, 39:
                    lEntryNo := 8;
            end;
            i := 3;
        end;
        if (lEntryNo <> 0) then begin
            ShipAllocCostTmp.Get(lEntryNo);

            case LineNo of
                2, 3, 4, 5:
                    TotalParty[i] := ShipAllocCostTmp."Primary Allocated Amount";
                9, 10, 11, 12:
                    TotalParty[i] := ShipAllocCostTmp."General Overheads";
                14, 15, 16, 17:
                    TotalParty[i] := ShipAllocCostTmp."Warehouse Overheads";
                19, 20, 21, 22:
                    TotalParty[i] := ShipAllocCostTmp."Warehouse Handling";
                26, 27, 28, 29:
                    TotalParty[i] := ShipAllocCostTmp."FIX Warehouse Handling";
                31, 32, 33, 34:
                    TotalParty[i] := ShipAllocCostTmp."OVE Warehouse Handling";
                36, 37, 38, 39:
                    TotalParty[i] := ShipAllocCostTmp."TRP Warehouse Handling";
            end;

        end;
        //HEI.09<<
    end;

    local procedure CalculateAllocated3rPartyAndOwnFleet(LineNo: Integer; OwnFleet: Boolean);
    var
        lEntryNo: Integer;
        i: Integer;
    begin
        //HEI.09>>
        if OwnFleet = false then begin
            case LineNo of
                2, 9, 14, 19, 26, 31, 36:
                    lEntryNo := 9;
                3, 4, 5, 10, 11, 12, 15, 16, 17, 20, 21, 22, 27, 28, 29, 32, 33, 34, 37, 38, 39:
                    lEntryNo := 10;
            end;
            i := 2;
        end else begin
            case LineNo of
                2, 9, 14, 19, 26, 31, 36:
                    lEntryNo := 11;
                3, 4, 5, 10, 11, 12, 15, 16, 17, 20, 21, 22, 27, 28, 29, 32, 33, 34, 37, 38, 39:
                    lEntryNo := 12;
            end;
            i := 4
        end;

        if (lEntryNo <> 0) then begin
            ShipAllocCostTmp.Get(lEntryNo);
            case LineNo of
                2:
                    TotalParty[i] := ShipAllocCostTmp."Primary Allocated Amount";
                3:
                    TotalParty[i] := ShipAllocCostTmp."Internal Transfer ST";
                4:
                    TotalParty[i] := ShipAllocCostTmp."RPM SO";
                5:
                    TotalParty[i] := ShipAllocCostTmp."RPM ST";
                9:
                    TotalParty[i] := ShipAllocCostTmp."General Overheads";
                10:
                    TotalParty[i] := ShipAllocCostTmp."General Overheads ST";
                11:
                    TotalParty[i] := ShipAllocCostTmp."Gen. Overheads RPM SO";
                12:
                    TotalParty[i] := ShipAllocCostTmp."Gen. Overheads RPM ST";
                14:
                    TotalParty[i] := ShipAllocCostTmp."Warehouse Overheads";
                15:
                    TotalParty[i] := ShipAllocCostTmp."Warehouse Overheads ST";
                16:
                    TotalParty[i] := ShipAllocCostTmp."Whse. Overheads RPM SO";
                17:
                    TotalParty[i] := ShipAllocCostTmp."Whse. Overheads RPM ST";
                19:
                    TotalParty[i] := ShipAllocCostTmp."Warehouse Handling";
                20:
                    TotalParty[i] := ShipAllocCostTmp."Warehouse Handling ST";
                21:
                    TotalParty[i] := ShipAllocCostTmp."Whse. Handling RPM SO";
                22:
                    TotalParty[i] := ShipAllocCostTmp."Whse. Handling RPM ST";
                26:
                    TotalParty[i] := ShipAllocCostTmp."FIX Warehouse Handling";
                27:
                    TotalParty[i] := ShipAllocCostTmp."FIX Whse. Hand. ST";
                28:
                    TotalParty[i] := ShipAllocCostTmp."FIX Whse. Handling RPM SO";
                29:
                    TotalParty[i] := ShipAllocCostTmp."FIX Whse. Handling RPM ST";
                31:
                    TotalParty[i] := ShipAllocCostTmp."OVE Warehouse Handling";
                32:
                    TotalParty[i] := ShipAllocCostTmp."OVE Whse. Hand. ST";
                33:
                    TotalParty[i] := ShipAllocCostTmp."OVE Whse. Handling RPM SO";
                34:
                    TotalParty[i] := ShipAllocCostTmp."OVE Whse. Handling RPM ST";
                36:
                    TotalParty[i] := ShipAllocCostTmp."TRP Warehouse Handling";
                37:
                    TotalParty[i] := ShipAllocCostTmp."TRP Whse. Hand. ST";
                38:
                    TotalParty[i] := ShipAllocCostTmp."TRP Whse. Handling RPM SO";
                39:
                    TotalParty[i] := ShipAllocCostTmp."TRP Whse. Handling RPM ST";
            end;
        end;
        //HEI.09<<
    end;

    local procedure CalcPeriodGL(LineNo: Integer; var C2SReconcilation: Record "C2S Reconciliation FND");
    begin
        //HEI.09>>
        if Archived then begin
            Clear(ShipArchive);
            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            case LineNo of
                46:
                    begin
                        ShipArchive.SetFilter("Period G/L Cost Delivery Cust.", '<>%1', 0);
                        if ShipArchive.FindFirst() then begin
                            C2SReconcilation."Total 3rd Party" := ShipArchive."Period G/L Cost Delivery Cust.";
                            C2SReconcilation."Allocated 3rd Party" := PeriodGLAlloc3rdParty;
                            C2SReconcilation.Total := ShipArchive."Period G/L Cost Delivery Cust.";
                            C2SReconcilation.Allocated := C2SReconcilation."Allocated 3rd Party";
                            C2SReconcilation."Unallocated 3rd Party" := C2SReconcilation."Total 3rd Party" - C2SReconcilation."Allocated 3rd Party";
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                47:
                    begin
                        ShipArchive.SetFilter("Period G/L Cost Own Fleet", '<>%1', 0);
                        if ShipArchive.FindFirst() then begin
                            C2SReconcilation."Total Own Fleet" := ShipArchive."Period G/L Cost Own Fleet";
                            C2SReconcilation."Allocated Own Fleet" := PeriodGLAllocOwnFleet;
                            C2SReconcilation.Total := ShipArchive."Period G/L Cost Own Fleet";
                            C2SReconcilation.Allocated := C2SReconcilation."Allocated Own Fleet";
                            C2SReconcilation."Unallocated Own Fleet" := C2SReconcilation."Total Own Fleet" - C2SReconcilation."Allocated Own Fleet";
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                48:
                    begin
                        ShipArchive.SetFilter("Period G/L Cost Gen. Overheads", '<>%1', 0);
                        if ShipArchive.FindFirst() then begin
                            C2SReconcilation.Total := ShipArchive."Period G/L Cost Gen. Overheads";
                            C2SReconcilation.Allocated := PeriodGLAlloc[1];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                49:
                    begin
                        ShipArchive.SetFilter("Period G/L Cost Whse. Overhead", '<>%1', 0);
                        if ShipArchive.FindFirst() then begin
                            C2SReconcilation.Total := ShipArchive."Period G/L Cost Whse. Overhead";
                            C2SReconcilation.Allocated := PeriodGLAlloc[2];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                50:
                    begin
                        ShipArchive.SetFilter("Period G/L Cost Whse. Handling", '<>%1', 0);
                        if ShipArchive.FindFirst() then begin
                            C2SReconcilation.Total := ShipArchive."Period G/L Cost Whse. Handling";
                            C2SReconcilation.Allocated := PeriodGLAlloc[3];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                51, 55:
                    begin
                        C2SReconcilation.Total := Sum[1];
                        C2SReconcilation.Allocated := Sum[2];
                        C2SReconcilation.Unallocated := Sum[3];
                        DiffGL[1] := Sum[1] - DiffGL[1];
                        DiffGL[2] := Sum[2] - DiffGL[2];
                        DiffGL[3] := Sum[3] - DiffGL[3];
                        CLEAR(Sum);
                    end;
                52:
                    begin
                        ShipArchive.SetFilter("FIX Prd G/L Whse Hand Cost", '<>%1', 0);
                        if ShipArchive.FindFirst() then begin
                            C2SReconcilation.Total := ShipArchive."FIX Prd G/L Whse Hand Cost";
                            C2SReconcilation.Allocated := PeriodGLAlloc[4];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                53:
                    begin
                        ShipArchive.SetFilter("OVE Prd G/L Whse Hand Cost", '<>%1', 0);
                        if ShipArchive.FindFirst() then begin
                            C2SReconcilation.Total := ShipArchive."OVE Prd G/L Whse Hand Cost";
                            C2SReconcilation.Allocated := PeriodGLAlloc[5];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                54:
                    begin
                        ShipArchive.SetFilter("TRP Prd G/L Whse Hand Cost", '<>%1', 0);
                        if ShipArchive.FindFirst() then begin
                            C2SReconcilation.Total := ShipArchive."TRP Prd G/L Whse Hand Cost";
                            C2SReconcilation.Allocated := PeriodGLAlloc[6];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                56:
                    begin
                        C2SReconcilation.Total := DiffGL[1];
                        C2SReconcilation.Allocated := DiffGL[2];
                        C2SReconcilation.Unallocated := DiffGL[3];
                    end;
            end;
        end else begin
            CLEAR(ShipAllocation);
            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            case LineNo of
                46:
                    begin
                        ShipAllocation.SetFilter("Period G/L Cost Delivery Cust.", '<>%1', 0);
                        if ShipAllocation.FindFirst() then begin
                            C2SReconcilation."Total 3rd Party" := ShipAllocation."Period G/L Cost Delivery Cust.";
                            C2SReconcilation."Allocated 3rd Party" := PeriodGLAlloc3rdParty;
                            C2SReconcilation.Total := ShipAllocation."Period G/L Cost Delivery Cust.";
                            C2SReconcilation.Allocated := C2SReconcilation."Allocated 3rd Party";
                            C2SReconcilation."Unallocated 3rd Party" := C2SReconcilation."Total 3rd Party" - C2SReconcilation."Allocated 3rd Party";
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                47:
                    begin
                        ShipAllocation.SetFilter("Period G/L Cost Own Fleet", '<>%1', 0);
                        if ShipAllocation.FindFirst() then begin
                            C2SReconcilation."Total Own Fleet" := ShipAllocation."Period G/L Cost Own Fleet";
                            C2SReconcilation."Allocated Own Fleet" := PeriodGLAllocOwnFleet;
                            C2SReconcilation.Total := ShipAllocation."Period G/L Cost Own Fleet";
                            C2SReconcilation.Allocated := C2SReconcilation."Allocated Own Fleet";
                            C2SReconcilation."Unallocated Own Fleet" := C2SReconcilation."Total Own Fleet" - C2SReconcilation."Allocated Own Fleet";
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                48:
                    begin
                        ShipAllocation.SetFilter("Period G/L Cost Gen. Overheads", '<>%1', 0);
                        if ShipAllocation.FindFirst() then begin
                            C2SReconcilation.Total := ShipAllocation."Period G/L Cost Gen. Overheads";
                            C2SReconcilation.Allocated := PeriodGLAlloc[1];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                49:
                    begin
                        ShipAllocation.SetFilter("Period G/L Cost Whse. Overhead", '<>%1', 0);
                        if ShipAllocation.FindFirst() then begin
                            C2SReconcilation.Total := ShipAllocation."Period G/L Cost Whse. Overhead";
                            C2SReconcilation.Allocated := PeriodGLAlloc[2];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                50:
                    begin
                        ShipAllocation.SetFilter("Period G/L Cost Whse. Handling", '<>%1', 0);
                        if ShipAllocation.FindFirst() then begin
                            C2SReconcilation.Total := ShipAllocation."Period G/L Cost Whse. Handling";
                            C2SReconcilation.Allocated := PeriodGLAlloc[3];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;

                            DiffGL[1] := C2SReconcilation.Total;
                            DiffGL[2] := C2SReconcilation.Allocated;
                            DiffGL[3] := C2SReconcilation.Unallocated;


                        end;
                    end;
                51, 55:
                    begin
                        C2SReconcilation.Total := Sum[1];
                        C2SReconcilation.Allocated := Sum[2];
                        C2SReconcilation.Unallocated := Sum[3];
                        if (LineNo = 55) then begin
                            DiffGL[1] -= Sum[1];
                            DiffGL[2] -= Sum[2];
                            DiffGL[3] -= Sum[3];
                        end;
                        Clear(Sum);
                    end;
                52:
                    begin
                        ShipAllocation.SetFilter("FIX Prd G/L Whse Hand Cost", '<>%1', 0);
                        if ShipAllocation.FindFirst() then begin
                            C2SReconcilation.Total := ShipAllocation."FIX Prd G/L Whse Hand Cost";
                            C2SReconcilation.Allocated := PeriodGLAlloc[4];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;

                        end;
                    end;
                53:
                    begin
                        ShipAllocation.SetFilter("OVE Prd G/L Whse Hand Cost", '<>%1', 0);
                        if ShipAllocation.FindFirst() then begin
                            C2SReconcilation.Total := ShipAllocation."OVE Prd G/L Whse Hand Cost";
                            C2SReconcilation.Allocated := PeriodGLAlloc[5];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                54:
                    begin
                        ShipAllocation.SetFilter("TRP Prd G/L Whse Hand Cost", '<>%1', 0);
                        if ShipAllocation.FindFirst() then begin
                            C2SReconcilation.Total := ShipAllocation."TRP Prd G/L Whse Hand Cost";
                            C2SReconcilation.Allocated := PeriodGLAlloc[6];
                            C2SReconcilation.Unallocated := C2SReconcilation.Total - C2SReconcilation.Allocated;
                            Sum[1] += C2SReconcilation.Total;
                            Sum[2] += C2SReconcilation.Allocated;
                            Sum[3] += C2SReconcilation.Unallocated;
                        end;
                    end;
                56:
                    begin
                        C2SReconcilation.Total := DiffGL[1];
                        C2SReconcilation.Allocated := DiffGL[2];
                        C2SReconcilation.Unallocated := DiffGL[3];
                    end;
            end;
        end;
        //HEI.09<<
    end;

    local procedure CalcWhseHandSplitTotalsAndChecks(LineNo: Integer);
    begin
        //HEI.09>>
        case LineNo of
            30, 35, 40:
                begin
                    SumWhseHandlingSplit[1] += C2SReconcilationTmp."Total 3rd Party";
                    SumWhseHandlingSplit[2] += C2SReconcilationTmp."Allocated 3rd Party";
                    SumWhseHandlingSplit[3] += C2SReconcilationTmp."Unallocated 3rd Party";
                    SumWhseHandlingSplit[4] += C2SReconcilationTmp."Total Own Fleet";
                    SumWhseHandlingSplit[5] += C2SReconcilationTmp."Allocated Own Fleet";
                    SumWhseHandlingSplit[6] += C2SReconcilationTmp."Unallocated Own Fleet";
                    SumWhseHandlingSplit[7] += C2SReconcilationTmp.Total;
                    SumWhseHandlingSplit[8] += C2SReconcilationTmp.Allocated;
                    SumWhseHandlingSplit[9] += C2SReconcilationTmp.Unallocated;
                end;
            23:
                begin
                    DiffWhseHandlingSplit[1] := C2SReconcilationTmp."Total 3rd Party";
                    DiffWhseHandlingSplit[2] := C2SReconcilationTmp."Allocated 3rd Party";
                    DiffWhseHandlingSplit[3] := C2SReconcilationTmp."Unallocated 3rd Party";
                    DiffWhseHandlingSplit[4] := C2SReconcilationTmp."Total Own Fleet";
                    DiffWhseHandlingSplit[5] := C2SReconcilationTmp."Allocated Own Fleet";
                    DiffWhseHandlingSplit[6] := C2SReconcilationTmp."Unallocated Own Fleet";
                    DiffWhseHandlingSplit[7] := C2SReconcilationTmp.Total;
                    DiffWhseHandlingSplit[8] := C2SReconcilationTmp.Allocated;
                    DiffWhseHandlingSplit[9] := C2SReconcilationTmp.Unallocated;
                end;

        end;
        //HEI.09<<
    end;

    local procedure ReturnOptionValue(LineNo: Integer; var C2SReconc: Record "C2S Reconciliation FND");
    begin
        //HEI.09>>
        case LineNo of
            1:
                C2SReconc.Description := C2SReconc.Description::Line1;
            2:
                C2SReconc.Description := C2SReconc.Description::Line2;
            3:
                C2SReconc.Description := C2SReconc.Description::Line3;
            4:
                C2SReconc.Description := C2SReconc.Description::Line4;
            5:
                C2SReconc.Description := C2SReconc.Description::Line5;
            6:
                C2SReconc.Description := C2SReconc.Description::Line6;
            7:
                C2SReconc.Description := C2SReconc.Description::Line7;
            8:
                C2SReconc.Description := C2SReconc.Description::Line8;
            9:
                C2SReconc.Description := C2SReconc.Description::Line9;
            10:
                C2SReconc.Description := C2SReconc.Description::Line10;
            11:
                C2SReconc.Description := C2SReconc.Description::Line11;
            12:
                C2SReconc.Description := C2SReconc.Description::Line12;
            13:
                C2SReconc.Description := C2SReconc.Description::Line13;
            14:
                C2SReconc.Description := C2SReconc.Description::Line14;
            15:
                C2SReconc.Description := C2SReconc.Description::Line15;
            16:
                C2SReconc.Description := C2SReconc.Description::Line16;
            17:
                C2SReconc.Description := C2SReconc.Description::Line17;
            18:
                C2SReconc.Description := C2SReconc.Description::Line18;
            19:
                C2SReconc.Description := C2SReconc.Description::Line19;
            20:
                C2SReconc.Description := C2SReconc.Description::Line20;
            21:
                C2SReconc.Description := C2SReconc.Description::Line21;
            22:
                C2SReconc.Description := C2SReconc.Description::Line22;
            23:
                C2SReconc.Description := C2SReconc.Description::Line23;
            24:
                C2SReconc.Description := C2SReconc.Description::Line24;
            25:
                C2SReconc.Description := C2SReconc.Description::Line25;
            26:
                C2SReconc.Description := C2SReconc.Description::Line26;
            27:
                C2SReconc.Description := C2SReconc.Description::Line27;
            28:
                C2SReconc.Description := C2SReconc.Description::line28;
            29:
                C2SReconc.Description := C2SReconc.Description::Line29;
            30:
                C2SReconc.Description := C2SReconc.Description::Line30;
            31:
                C2SReconc.Description := C2SReconc.Description::Line31;
            32:
                C2SReconc.Description := C2SReconc.Description::Line32;
            33:
                C2SReconc.Description := C2SReconc.Description::Line33;
            34:
                C2SReconc.Description := C2SReconc.Description::Line34;
            35:
                C2SReconc.Description := C2SReconc.Description::Line35;
            36:
                C2SReconc.Description := C2SReconc.Description::Line36;
            37:
                C2SReconc.Description := C2SReconc.Description::Line37;
            38:
                C2SReconc.Description := C2SReconc.Description::Line38;
            39:
                C2SReconc.Description := C2SReconc.Description::Line39;
            40:
                C2SReconc.Description := C2SReconc.Description::Line40;
            41:
                C2SReconc.Description := C2SReconc.Description::Line41;
            42:
                C2SReconc.Description := C2SReconc.Description::Line42;
            43:
                C2SReconc.Description := C2SReconc.Description::Line43;
            44:
                C2SReconc.Description := C2SReconc.Description::Line44;
            45:
                C2SReconc.Description := C2SReconc.Description::Line45;
            46:
                C2SReconc.Description := C2SReconc.Description::Line46;
            47:
                C2SReconc.Description := C2SReconc.Description::Line47;
            48:
                C2SReconc.Description := C2SReconc.Description::Line48;
            49:
                C2SReconc.Description := C2SReconc.Description::Line49;
            50:
                C2SReconc.Description := C2SReconc.Description::Line50;
            51:
                C2SReconc.Description := C2SReconc.Description::Line51;
            52:
                C2SReconc.Description := C2SReconc.Description::Line52;
            53:
                C2SReconc.Description := C2SReconc.Description::Line53;
            54:
                C2SReconc.Description := C2SReconc.Description::Line54;
            55:
                C2SReconc.Description := C2SReconc.Description::Line55;
            56:
                C2SReconc.Description := C2SReconc.Description::Line56;
            57:
                C2SReconc.Description := C2SReconc.Description::Line57;
            58:
                C2SReconc.Description := C2SReconc.Description::Line58;
            59:
                C2SReconc.Description := C2SReconc.Description::Line59;
            60:
                C2SReconc.Description := C2SReconc.Description::Line60;
            61:
                C2SReconc.Description := C2SReconc.Description::Line61;
            62:
                C2SReconc.Description := C2SReconc.Description::Line62;
            63:
                C2SReconc.Description := C2SReconc.Description::Line63;
            64:
                C2SReconc.Description := C2SReconc.Description::Line64;
            65:
                C2SReconc.Description := C2SReconc.Description::Line65;
            66:
                C2SReconc.Description := C2SReconc.Description::Line66; //HEI.10
        end;
        //HEI.09<<
    end;

    local procedure CalcReversedEntries(var C2SReconc: Record "C2S Reconciliation FND");
    // BC Upgrade POENAB02>>
    // code commented, as "Posted Document Shipping Cost" belongs to Aptean
    /*
    var
        TempPostedDoc: Record "Posted Document Shipping Cost" temporary;
    */
    // BC Upgrade POENAB02 <<
    //POENAB02, 11.06.2026>>
    var
        TempPostedDoc: Record "Posted Trade Cost Order APS" temporary;
    //POENAB02, 11.06.2026<<
    begin
        //HEI.09>>
        if Archived then begin
            //POENAB02, 11.06.2026>>
            /*
                ShipArchive.Reset();
                ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
                ShipArchive.SetFilter("Own Fleet", '%1', false);
                ShipArchive.SetFilter(Reversed, '%1', true);
                if ShipArchive.FindSet(false, false) then
                    repeat
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Source No.", ShipArchive."No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Source No." := ShipArchive."No.";
                            TempPostedDoc.Insert();
                            C2SReconc."Total 3rd Party" += ShipArchive."Total Shipping Cost Amount";
                        end;
                    until ShipArchive.Next() = 0;
                */

            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Own Fleet", '%1', false);
            ShipArchive.SetFilter(Reversed, '%1', true);
            if ShipArchive.FindSet(false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipArchive."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipArchive."Total Shipping Cost Amount";
                    end;
                until ShipArchive.Next() = 0;

            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Own Fleet", '%1', false);
            ShipArchive.SetFilter(Reversed, '%1', true);
            if ShipArchive.FindSet(false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipArchive."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipArchive."Total Shipping Cost Amount";
                    end;
                until ShipArchive.Next() = 0;
            //POENAB02, 11.06.2026<<

            //POENAB02, 11.06.2026>>
            /*
            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Own Fleet", '%1', true);
            ShipArchive.SetFilter(Reversed, '%1', true);
            if ShipArchive.FindSet(false, false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipArchive."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipArchive."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipArchive."Total Shipping Cost Amount";
                    end;
                until ShipArchive.Next() = 0;
            */

            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Own Fleet", '%1', true);
            ShipArchive.SetFilter(Reversed, '%1', true);
            if ShipArchive.FindSet(false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipArchive."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipArchive."Total Shipping Cost Amount";
                    end;
                until ShipArchive.Next() = 0;

            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Own Fleet", '%1', true);
            ShipArchive.SetFilter(Reversed, '%1', true);
            if ShipArchive.FindSet(false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipArchive."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipArchive."Total Shipping Cost Amount";
                    end;
                until ShipArchive.Next() = 0;
            //POENAB02, 11.06.2026<<
        end else begin
            //POENAB02, 11.06.2026>>
            /*
            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', false);
            ShipAllocation.SetFilter(Reversed, '%1', true);
            if ShipAllocation.FindSet(false, false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipAllocation."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipAllocation."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                until ShipAllocation.Next() = 0;
            */

            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', false);
            ShipAllocation.SetFilter(Reversed, '%1', true);
            if ShipAllocation.FindSet(false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipAllocation."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                until ShipAllocation.Next() = 0;

            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', false);
            ShipAllocation.SetFilter(Reversed, '%1', true);
            if ShipAllocation.FindSet(false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipAllocation."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                until ShipAllocation.Next() = 0;
            //POENAB02, 11.06.2026<<

            //POENAB02, 11.06.2026>>
            /*
            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', true);
            ShipAllocation.SetFilter(Reversed, '%1', true);
            if ShipAllocation.FindSet(false, false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipAllocation."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipAllocation."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                until ShipAllocation.Next() = 0;
            */

            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', true);
            ShipAllocation.SetFilter(Reversed, '%1', true);
            if ShipAllocation.FindSet(false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipAllocation."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                until ShipAllocation.Next() = 0;

            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', true);
            ShipAllocation.SetFilter(Reversed, '%1', true);
            if ShipAllocation.FindSet(false) then
                repeat
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipAllocation."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                until ShipAllocation.Next() = 0;
            //POENAB02, 11.06.2026<<
        end;
        C2SReconc.Total := C2SReconc."Total Own Fleet" + C2SReconc."Total 3rd Party";
        TotalSection3[1] += C2SReconc."Total 3rd Party";
        TotalSection3[2] += C2SReconc."Total Own Fleet";
        TotalSection3[3] += C2SReconc.Total;
        //HEI.09<<
    end;

    local procedure CalcDeliverySolelyRPM(var C2SReconc: Record "C2S Reconciliation FND");
    // BC Upgrade POENAB02>>
    // code commented, as "Posted Document Shipping Cost" belongs to Aptean
    /*    
    var
        TempPostedDoc: Record "Posted Document Shipping Cost" temporary;
    */
    // BCV Upgrade POENAB02 <<
    //POENAB02, 11.06.2026>>
    var
        TempPostedDoc: Record "Posted Trade Cost Order APS" temporary;
    //POENAB02, 11.06.2026<<
    begin
        //HEI.09>>
        if Archived then begin
            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Only RPM Transportation", '%1', true);
            ShipArchive.SetFilter("Own Fleet", '%1', false);
            ShipArchive.SetFilter("Source Document", '<>%1', ShipArchive."Source Document"::"Sales Return Order");
            ShipArchive.SetFilter("Destination Type", '%1', ShipArchive."Destination Type"::Customer);
            ShipArchive.SetFilter(Reversed, '%1', false); //HEI.10
            if ShipArchive.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipArchive."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipArchive."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipArchive."Total Shipping Cost Amount";
                    end;
                    */
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipArchive."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipArchive."Total Shipping Cost Amount";
                    end;
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipArchive."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipArchive."Total Shipping Cost Amount";
                    end;
                //POENAB02, 11.06.2026<<
                until ShipArchive.Next() = 0;

            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Only RPM Transportation", '%1', true);
            ShipArchive.SetFilter("Own Fleet", '%1', true);
            ShipArchive.SetFilter("Source Document", '<>%1', ShipArchive."Source Document"::"Sales Return Order");
            ShipArchive.SetFilter("Destination Type", '%1', ShipArchive."Destination Type"::Customer);
            ShipArchive.SetFilter(Reversed, '%1', false); //HEI.10
            if ShipArchive.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*                       
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipArchive."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipArchive."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipArchive."Total Shipping Cost Amount";
                    end;
                    */
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipArchive."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipArchive."Total Shipping Cost Amount";
                    end;
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipArchive."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipArchive."Total Shipping Cost Amount";
                    end;
                //POENAB02, 11.06.2026<<
                until ShipArchive.Next() = 0;
        end else begin
            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Only RPM Transportation", '%1', true);
            ShipAllocation.SetFilter("Own Fleet", '%1', true);
            ShipAllocation.SetFilter("Source Document", '<>%1', ShipAllocation."Source Document"::"Sales Return Order");
            ShipAllocation.SetFilter("Destination Type", '%1', ShipAllocation."Destination Type"::Customer);
            ShipAllocation.SetFilter(Reversed, '%1', false); //HEI.10
            if ShipAllocation.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*                       
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipAllocation."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipAllocation."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                    */
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipAllocation."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipAllocation."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                //POENAB02, 11.06.2026<<
                until ShipAllocation.Next() = 0;

            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Only RPM Transportation", '%1', true);
            ShipAllocation.SetFilter("Own Fleet", '%1', true);
            ShipAllocation.SetFilter("Source Document", '<>%1', ShipAllocation."Source Document"::"Sales Return Order");
            ShipAllocation.SetFilter("Destination Type", '%1', ShipAllocation."Destination Type"::Customer);
            ShipAllocation.SetFilter(Reversed, '%1', false); //HEI.10
            if ShipAllocation.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*   
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipAllocation."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipAllocation."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                    */
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipAllocation."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipAllocation."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                //POENAB02, 11.06.2026<<
                until ShipAllocation.Next() = 0;
        end;

        C2SReconc.Total := C2SReconc."Total Own Fleet" + C2SReconc."Total 3rd Party";
        TotalSection3[1] += C2SReconc."Total 3rd Party";
        TotalSection3[2] += C2SReconc."Total Own Fleet";
        TotalSection3[3] += C2SReconc.Total;
        //HEI.09<<
    end;

    local procedure CalcShipmNonFG(var C2SReconc: Record "C2S Reconciliation FND"; LineNo: Integer);
    // BC Upgrade POENAB02>>
    // code commented, as "Posted Document Shipping Cost" belongs to Aptean
    /*           
    var
        TempPostedDoc: Record "Posted Document Shipping Cost" temporary;
    */
    // BC Upgrade POENAB02 <<
    //POENAB02, 11.06.2026>>
    var
        TempPostedDoc: Record "Posted Trade Cost Order APS" temporary;
    //POENAB02, 11.06.2026<<
    begin
        //HEI.09>>
        if Archived then begin
            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Own Fleet", '%1', false);
            ShipArchive.SetFilter("Item Category Code", FilterItemCateg);
            //HEI.10>>
            ShipArchive.SetFilter(Reversed, '%1', false);
            case LineNo of
                62:
                    ShipArchive.SetFilter("Source Document", '%1|%2', ShipArchive."Source Document"::"Sales Order", ShipArchive."Source Document"::"Sales Return Order");
                63:
                    ShipArchive.SetFilter("Source Document", '%1', ShipArchive."Source Document"::"Outbound Transfer");
            end;
            //HEI.10<<
            if ShipArchive.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>                
                    /*                       
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipArchive."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipArchive."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipArchive."Total Shipping Cost Amount";
                    end;
                    */
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipArchive."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipArchive."Total Shipping Cost Amount";
                    end;
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst() then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipArchive."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipArchive."Total Shipping Cost Amount";
                    end;
                //POENAB02, 11.06.2026<<
                until ShipArchive.Next() = 0;

            TempPostedDoc.DeleteAll();
            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Own Fleet", '%1', true);
            ShipArchive.SetFilter("Item Category Code", FilterItemCateg);
            //HEI.10>>
            ShipArchive.SetFilter(Reversed, '%1', false);
            case LineNo of
                62:
                    ShipArchive.SetFilter("Source Document", '%1|%2', ShipArchive."Source Document"::"Sales Order", ShipArchive."Source Document"::"Sales Return Order");
                63:
                    ShipArchive.SetFilter("Source Document", '%1', ShipArchive."Source Document"::"Outbound Transfer");
            end;
            //HEI.10<<
            if ShipArchive.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*                       
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipArchive."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipArchive."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipArchive."Total Shipping Cost Amount";
                    end;
                    */
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipArchive."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipArchive."Total Shipping Cost Amount";
                    end;
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipArchive."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipArchive."Total Shipping Cost Amount";
                    end;
                //POENAB02, 11.06.2026<<
                until ShipArchive.Next() = 0;
        end else begin
            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', false);
            ShipAllocation.SetFilter("Item Category Code", FilterItemCateg);
            //HEI.10>>
            ShipAllocation.SetFilter(Reversed, '%1', false);
            case LineNo of
                62:
                    ShipAllocation.SetFilter("Source Document", '%1|%2', ShipAllocation."Source Document"::"Sales Order", ShipAllocation."Source Document"::"Sales Return Order");
                63:
                    ShipAllocation.SetFilter("Source Document", '%1', ShipAllocation."Source Document"::"Outbound Transfer");
            end;
            //HEI.10<<
            if ShipAllocation.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*                       
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipAllocation."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipAllocation."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                    */
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipAllocation."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipAllocation."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total 3rd Party" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                //POENAB02, 11.06.2026<<
                until ShipAllocation.Next() = 0;

            TempPostedDoc.DeleteAll();
            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', true);
            ShipAllocation.SetFilter("Item Category Code", FilterItemCateg);
            //HEI.10>>
            ShipAllocation.SetFilter(Reversed, '%1', false);
            case LineNo of
                62:
                    ShipAllocation.SetFilter("Source Document", '%1|%2', ShipAllocation."Source Document"::"Sales Order", ShipAllocation."Source Document"::"Sales Return Order");
                63:
                    ShipAllocation.SetFilter("Source Document", '%1', ShipAllocation."Source Document"::"Outbound Transfer");
            end;
            //HEI.10<<
            if ShipAllocation.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*                       
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Source No.", ShipAllocation."No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Source No." := ShipAllocation."No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                    */
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Shipment No." := ShipAllocation."Posted Whse. Shipment No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                    TempPostedDoc.Reset();
                    TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                    if not TempPostedDoc.FindFirst then begin
                        TempPostedDoc.Init();
                        TempPostedDoc."Posted Whse. Receipt No." := ShipAllocation."Posted Whse. Receipt No.";
                        TempPostedDoc.Insert();
                        C2SReconc."Total Own Fleet" += ShipAllocation."Total Shipping Cost Amount";
                    end;
                //POENAB02, 11.06.2026<<
                until ShipAllocation.Next() = 0;
        end;
        C2SReconc.Total := C2SReconc."Total Own Fleet" + C2SReconc."Total 3rd Party";
        TotalSection3[1] += C2SReconc."Total 3rd Party";
        TotalSection3[2] += C2SReconc."Total Own Fleet";
        TotalSection3[3] += C2SReconc.Total;
        //HEI.09<<
    end;

    local procedure CalcSection3(LineNo: Integer);
    begin
        //HEI.09>>
        case LineNo of
            60:
                CalcReversedEntries(C2SReconcilationTmp);
            61:
                CalcDeliverySolelyRPM(C2SReconcilationTmp);
            62, 63:
                CalcShipmNonFG(C2SReconcilationTmp, LineNo);
            64:
                CalcMissingShippments(C2SReconcilationTmp);
            65:
                CalcOtherUnrecDoc(C2SReconcilationTmp);
        end;
        //HEI.09<<
    end;

    local procedure CalcMissingShippments(var C2SReconc: Record "C2S Reconciliation FND");
    // BC Upgrade POENAB02>>
    // code commented, as "Posted Document Shipping Cost" belongs to Aptean
    /*           
    var    
        TempPostedDoc: Record "Posted Document Shipping Cost" temporary;
    */
    // BC Upgrade POENAB02 <<
    //POENAB02, 11.06.2026>>
    var
        TempPostedDoc: Record "Posted Trade Cost Order APS" temporary;
    //POENAB02, 11.06.2026<<
    begin
        //HEI.09>>
        if Archived then begin
            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Own Fleet", '%1', false);
            if ShipArchive.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*                       
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Source No.", ShipArchive."No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Source No.", ShipArchive."No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Source No." := ShipArchive."No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Source No.", ShipArchive."No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total 3rd Party" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                    */
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Posted Whse. Shipment No." := ShipArchive."Posted Whse. Shipment No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total 3rd Party" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Posted Whse. Receipt No." := ShipArchive."Posted Whse. Receipt No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total 3rd Party" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                //POENAB02, 11.06.2026<<
                until ShipArchive.Next() = 0;

            TempPostedDoc.DeleteAll();
            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            ShipArchive.SetFilter("Own Fleet", '%1', true);
            if ShipArchive.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*                       
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Source No.", ShipArchive."No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Source No.", ShipArchive."No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Source No." := ShipArchive."No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Source No.", ShipArchive."No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total Own Fleet" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                    */
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Posted Whse. Shipment No." := ShipArchive."Posted Whse. Shipment No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total Own Fleet" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Posted Whse. Receipt No." := ShipArchive."Posted Whse. Receipt No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total Own Fleet" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                //POENAB02, 11.06.2026<<
                until ShipAllocation.Next() = 0;
        end else begin
            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', false);
            if ShipAllocation.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*                       
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Source No.", ShipAllocation."No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Source No.", ShipAllocation."No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Source No." := ShipAllocation."No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Source No.", ShipAllocation."No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total 3rd Party" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                    */
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Posted Whse. Shipment No." := ShipAllocation."Posted Whse. Shipment No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total 3rd Party" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Posted Whse. Receipt No." := ShipAllocation."Posted Whse. Receipt No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total 3rd Party" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                //POENAB02, 11.06.2026<<
                until ShipAllocation.Next() = 0;

            TempPostedDoc.DeleteAll();
            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            ShipAllocation.SetFilter("Own Fleet", '%1', true);
            if ShipAllocation.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*                       
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Source No.", ShipAllocation."No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Source No.", ShipAllocation."No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Source No." := ShipAllocation."No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Source No.", ShipAllocation."No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total Own Fleet" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                    */
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Posted Whse. Shipment No." := ShipAllocation."Posted Whse. Shipment No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total Own Fleet" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                    PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                    if (not PostedDocShippingCost.FindFirst) then begin
                        TempPostedDoc.Reset();
                        TempPostedDoc.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                        if not TempPostedDoc.FindFirst then begin
                            TempPostedDoc.Init();
                            TempPostedDoc."Posted Whse. Receipt No." := ShipAllocation."Posted Whse. Receipt No.";
                            TempPostedDoc.Insert();
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                            if PostedDocShippingCost.FindFirst then
                                C2SReconc."Total Own Fleet" += CalcAmtInLCY(PostedDocShippingCost);
                        end;
                    end;
                //POENAB02, 11.06.2026<<
                until ShipAllocation.Next() = 0;
        end;
        C2SReconc.Total := C2SReconc."Total Own Fleet" + C2SReconc."Total 3rd Party";
        TotalSection3[1] += C2SReconc."Total 3rd Party";
        TotalSection3[2] += C2SReconc."Total Own Fleet";
        TotalSection3[3] += C2SReconc.Total;
        //HEI.09<<
    end;

    local procedure CalcOtherUnrecDoc(var C2SReconc: Record "C2S Reconciliation FND");
    var
        ShippingAgent: Record "Shipping Agent";
    begin
        //HEI.09>>
        PostedDocShippingCost.Reset();
        //HEI.10>>
        //PostedDocShippingCost.SETFILTER("Source Type",'<>%1&<>%2',7318,7322);
        PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
        //HEI.10<<
        if PostedDocShippingCost.FindSet() then
            repeat
                //HEI.10>>
                /*
                IF ShippingAgent.GET(PostedDocShippingCost."Shipping Agent Code") AND (NOT ShippingAgent."Own Logistics") THEN
                  C2SReconc."Total 3rd Party" += CalcAmtInLCY(PostedDocShippingCost);
                */
#pragma warning disable AA0005
                if ShippingAgent.Get(PostedDocShippingCost."Shipping Agent Code") and (NotFoundPostedDocShipCostInSCA(PostedDocShippingCost, Archived)) then begin
                    //POENAB02, 11.06.2026>>
                    //if (not ShippingAgent."Own Logistics") then
                    if (not ShippingAgent."Own Logistics FND") then
                        //POENAB02, 11.06.2026<<
                        C2SReconc."Total 3rd Party" += CalcAmtInLCY(PostedDocShippingCost)
                    else
                        C2SReconc."Total Own Fleet" += CalcAmtInLCY(PostedDocShippingCost);
                end;
#pragma warning restore AA0005
            //HEI.10<<
            until PostedDocShippingCost.Next() = 0;

        //HEI.10>>
        /*
        PostedDocShippingCost.RESET;
        PostedDocShippingCost.SETFILTER("Source Type",'<>%1&<>%2',7318,7322);
        IF PostedDocShippingCost.FINDFIRST THEN
          REPEAT
            IF ShippingAgent.GET(PostedDocShippingCost."Shipping Agent Code") AND (ShippingAgent."Own Logistics") THEN
              C2SReconc."Total 3rd Party" += CalcAmtInLCY(PostedDocShippingCost);
        UNTIL PostedDocShippingCost.NEXT = 0;
        */
        //HEI.10<<

        C2SReconc.Total := C2SReconc."Total Own Fleet" + C2SReconc."Total 3rd Party";
        TotalSection3[1] += C2SReconc."Total 3rd Party";
        TotalSection3[2] += C2SReconc."Total Own Fleet";
        TotalSection3[3] += C2SReconc.Total;
        //HEI.09<<

    end;

    local procedure CreateFilterItemCateg();
    var
        CountSeparator: Integer;
        Lenght: Integer;
        ItemCateg: Text[250];
        i: Integer;
    begin
        //HEI.09>>
        ItemCateg := InventorySetup."Finished Goods ItemCatCode FND" + '|' + SalesSetup."RPMRelatedItemCategoryCode FND";
        Lenght := StrLen(ItemCateg);
        CountSeparator := StrLen(ItemCateg) - StrLen(DelChr(ItemCateg, '=', '|'));

        FilterItemCateg := '<>';

        for i := 1 to CountSeparator + 1 do begin
            if (i = CountSeparator + 1) then
                FilterItemCateg += ItemCateg
            else begin
                FilterItemCateg += CopyStr(ItemCateg, 1, StrPos(ItemCateg, '|') - 1) + '&<>';
                ItemCateg := CopyStr(ItemCateg, StrPos(ItemCateg, '|') + 1);
            end;
        end;
        //HEI.09<<
    end;

    local procedure InsertTmpTotal3Party();
    begin
        //HEI.09>>
        EntryNo := 1;
        Clear(QShipCostAllocArhived);
        Clear(QShipCostAlloc);

        if Archived then begin
            //RPM = FALSE; Customer
            //2,9,14,19,26,31,36: - 1
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAllocArhived.SetRange(OnlyRPM, false);
            QShipCostAllocArhived.SetRange(OwnFleet, false);
            InsertTmpArchivedTotal3PartyAndOwn(QShipCostAllocArhived);

            //RPM = TRUE; Customer
            //4,11,16,21,28,33,38: - 2
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAllocArhived.SetRange(OnlyRPM, true);
            QShipCostAllocArhived.SetRange(OwnFleet, false);
            InsertTmpArchivedTotal3PartyAndOwn(QShipCostAllocArhived);

            //RPM = FALSE; Location
            //3,10,15,20,27,33,37: - 3
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Location);
            QShipCostAllocArhived.SetRange(OnlyRPM, false);
            QShipCostAllocArhived.SetRange(OwnFleet, false);
            InsertTmpArchivedTotal3PartyAndOwn(QShipCostAllocArhived);

            //RPM = TRUE; Location
            //5,12,17,22,29,34,39: - 4
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Location);
            QShipCostAllocArhived.SetRange(OnlyRPM, true);
            QShipCostAllocArhived.SetRange(OwnFleet, false);
            InsertTmpArchivedTotal3PartyAndOwn(QShipCostAllocArhived);

        end else begin
            //RPM = FALSE; Customer
            //2,9,14,19,26,31,36: - 1
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAlloc.SetRange(OnlyRPM, false);
            QShipCostAlloc.SetRange(OwnFleet, false);
            InsertTmpNonArchivedTotal3PartyAndOwn(QShipCostAlloc);

            //RPM = TRUE; Customer
            //4,11,16,21,28,33,38: - 2
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAlloc.SetRange(OnlyRPM, true);
            QShipCostAlloc.SetRange(OwnFleet, false);
            InsertTmpNonArchivedTotal3PartyAndOwn(QShipCostAlloc);

            //RPM = FALSE; Location
            //3,10,15,20,27,33,37: - 3
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Location);
            QShipCostAlloc.SetRange(OnlyRPM, false);
            QShipCostAlloc.SetRange(OwnFleet, false);
            InsertTmpNonArchivedTotal3PartyAndOwn(QShipCostAlloc);


            //RPM = TRUE; Location
            //5,12,17,22,29,34,39: - 4
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Location);
            QShipCostAlloc.SetRange(OnlyRPM, true);
            QShipCostAlloc.SetRange(OwnFleet, false);
            InsertTmpNonArchivedTotal3PartyAndOwn(QShipCostAlloc);

        end;
        //HEI.09<<
    end;

    local procedure InsertTmpTotalOwnFleet();
    begin
        //HEI.09>>
        Clear(QShipCostAllocArhived);
        Clear(QShipCostAlloc);


        if Archived then begin
            //2,9,14,19,26,31,36: - 5
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAllocArhived.SetRange(OnlyRPM, false);
            QShipCostAllocArhived.SetRange(OwnFleet, true);
            InsertTmpArchivedTotal3PartyAndOwn(QShipCostAllocArhived);

            //4,11,16,21,28,33,38: - 6
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAllocArhived.SetRange(OnlyRPM, true);
            QShipCostAllocArhived.SetRange(OwnFleet, true);
            InsertTmpArchivedTotal3PartyAndOwn(QShipCostAllocArhived);

            //3,10,15,20,27,32,37: - 7
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Location);
            QShipCostAllocArhived.SetRange(OnlyRPM, false);
            QShipCostAllocArhived.SetRange(OwnFleet, true);
            InsertTmpArchivedTotal3PartyAndOwn(QShipCostAllocArhived);


            //5,12,17,22,29,34,39: - 8
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Location);
            QShipCostAllocArhived.SetRange(OnlyRPM, true);
            QShipCostAllocArhived.SetRange(OwnFleet, true);
            InsertTmpArchivedTotal3PartyAndOwn(QShipCostAllocArhived);

        end else begin
            //2,9,14,19,26,31,36: - 5
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAlloc.SetRange(OnlyRPM, false);
            QShipCostAlloc.SetRange(OwnFleet, true);
            InsertTmpNonArchivedTotal3PartyAndOwn(QShipCostAlloc);

            //4,11,16,21,28,33,38: - 6
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAlloc.SetRange(OnlyRPM, true);
            QShipCostAlloc.SetRange(OwnFleet, true);
            InsertTmpNonArchivedTotal3PartyAndOwn(QShipCostAlloc);

            //3,10,15,20,27,32,37: - 7
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Location);
            QShipCostAlloc.SetRange(OnlyRPM, false);
            QShipCostAlloc.SetRange(OwnFleet, true);
            InsertTmpNonArchivedTotal3PartyAndOwn(QShipCostAlloc);


            //5,12,17,22,29,34,39: - 8
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Location);
            QShipCostAlloc.SetRange(OnlyRPM, true);
            QShipCostAlloc.SetRange(OwnFleet, true);
            InsertTmpNonArchivedTotal3PartyAndOwn(QShipCostAlloc);

        end;
        //HEI.09<<
    end;

    local procedure InsertTmpAllocated3rParty();
    begin
        //HEI.09>>
        Clear(QShipCostAllocArhived);
        Clear(QShipCostAlloc);

        //2,9,14,19,26,31,36: - 9
        if Archived then begin
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAllocArhived.SetRange(OnlyRPM, false);
            QShipCostAllocArhived.SetRange(OwnFleet, false);
            InsertTmpArchivedAllocated3rdPartyAndOwn(QShipCostAllocArhived);
        end else begin
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAlloc.SetRange(OnlyRPM, false);
            QShipCostAlloc.SetRange(OwnFleet, false);
            InsertTmpNonArchivedAllocated3rdPartytAndOwn(QShipCostAlloc);
        end;

        //3,4,5,10,11,12,15,16,17,20,21,22,27,28,29,32,33,34,37,38,39: - 10
        Clear(QShipCostAllocArhived);
        Clear(QShipCostAlloc);
        if Archived then begin
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetRange(OwnFleet, false);
            InsertTmpArchivedAllocated3rdPartyAndOwn(QShipCostAllocArhived);
        end else begin
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetRange(OwnFleet, false);
            InsertTmpNonArchivedAllocated3rdPartytAndOwn(QShipCostAlloc);
        end;
        //HEI.09<<
    end;

    local procedure InsertTmpAllocatedOwnFleet();
    begin
        //HEI.09>>

        //2,9,14,19,26,31,36: - 11
        Clear(QShipCostAllocArhived);
        Clear(QShipCostAlloc);
        if Archived then begin
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetFilter(DestinationType, '%1', ShipArchive."Destination Type"::Customer);
            QShipCostAllocArhived.SetRange(OnlyRPM, false);
            QShipCostAllocArhived.SetRange(OwnFleet, true);
            InsertTmpArchivedAllocated3rdPartyAndOwn(QShipCostAllocArhived);
        end else begin
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetFilter(DestinationType, '%1', ShipAllocation."Destination Type"::Customer);
            QShipCostAlloc.SetRange(OnlyRPM, false);
            QShipCostAlloc.SetRange(OwnFleet, true);
            InsertTmpNonArchivedAllocated3rdPartytAndOwn(QShipCostAlloc);
        end;

        //3,4,5,10,11,12,15,16,17,20,21,22,27,28,29,32,33,34,37,38,39: - 12
        Clear(QShipCostAllocArhived);
        Clear(QShipCostAlloc);
        if Archived then begin
            QShipCostAllocArhived.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAllocArhived.SetRange(OwnFleet, true);
            InsertTmpArchivedAllocated3rdPartyAndOwn(QShipCostAllocArhived);
        end else begin
            QShipCostAlloc.SetRange(PostingDate, StartingDate, EndingDate);
            QShipCostAlloc.SetRange(OwnFleet, true);
            InsertTmpNonArchivedAllocated3rdPartytAndOwn(QShipCostAlloc);
        end;
        //HEI.09<<
    end;

    local procedure InsertTmpArchivedAllocated3rdPartyAndOwn(lQShipAllocArhived: Query "Shipping Cost Archive");
    begin
        //HEI.09>>
        lQShipAllocArhived.Open();
        while lQShipAllocArhived.Read() do begin
            ShipAllocCostTmp."Entry No." := EntryNo;

            ShipAllocCostTmp."Primary Allocated Amount" := lQShipAllocArhived.InternalTransfer;
            ShipAllocCostTmp."Internal Transfer ST" := lQShipAllocArhived.InternalTransferST;
            ShipAllocCostTmp."RPM SO" := lQShipAllocArhived.RPM_SO;
            ShipAllocCostTmp."RPM ST" := lQShipAllocArhived.RPM_ST;

            ShipAllocCostTmp."General Overheads" := lQShipAllocArhived.TotalGenOverheads;
            ShipAllocCostTmp."General Overheads ST" := lQShipAllocArhived.TotalGenOverheadsST;
            ShipAllocCostTmp."Gen. Overheads RPM SO" := lQShipAllocArhived.Gen_Overheads_RPM_SO;
            ShipAllocCostTmp."Gen. Overheads RPM ST" := lQShipAllocArhived.Gen_Overheads_RPM_ST;

            ShipAllocCostTmp."Warehouse Overheads" := lQShipAllocArhived.TotalWhseOverheads;
            ShipAllocCostTmp."Warehouse Overheads ST" := lQShipAllocArhived.TotalWhseOverheadsST;
            ShipAllocCostTmp."Whse. Overheads RPM SO" := lQShipAllocArhived.Whse_Overheads_RPM_SO;
            ShipAllocCostTmp."Whse. Overheads RPM ST" := lQShipAllocArhived.Whse_Overheads_RPM_ST;

            ShipAllocCostTmp."Warehouse Handling" := lQShipAllocArhived.TotalWhseHandling;
            ShipAllocCostTmp."Warehouse Handling ST" := lQShipAllocArhived.TotalWhseHandlingST;
            ShipAllocCostTmp."Whse. Handling RPM SO" := lQShipAllocArhived.Whse_Handling_RPM_SO;
            ShipAllocCostTmp."Whse. Handling RPM ST" := lQShipAllocArhived.Whse_Handling_RPM_ST;

            ShipAllocCostTmp."FIX Warehouse Handling" := lQShipAllocArhived.FIX_Warehouse_Handling;
            ShipAllocCostTmp."FIX Whse. Hand. ST" := lQShipAllocArhived.FIX_Whse_Hand_ST;
            ShipAllocCostTmp."FIX Whse. Handling RPM SO" := lQShipAllocArhived.FIX_Whse_Handling_RPM_SO;
            ShipAllocCostTmp."FIX Whse. Handling RPM ST" := lQShipAllocArhived.FIX_Whse_Handling_RPM_ST;

            ShipAllocCostTmp."OVE Warehouse Handling" := lQShipAllocArhived.OVE_Warehouse_Handling;
            ShipAllocCostTmp."OVE Whse. Hand. ST" := lQShipAllocArhived.OVE_Whse_Hand_ST;
            ShipAllocCostTmp."OVE Whse. Handling RPM SO" := lQShipAllocArhived.OVE_Whse_Handling_RPM_SO;
            ShipAllocCostTmp."OVE Whse. Handling RPM ST" := lQShipAllocArhived.OVE_Whse_Handling_RPM_ST;

            ShipAllocCostTmp."TRP Warehouse Handling" := lQShipAllocArhived.TRP_Warehouse_Handling;
            ShipAllocCostTmp."TRP Whse. Hand. ST" := lQShipAllocArhived.TRP_Whse_Hand_ST;
            ShipAllocCostTmp."TRP Whse. Handling RPM SO" := lQShipAllocArhived.TRP_Whse_Handling_RPM_SO;
            ShipAllocCostTmp."TRP Whse. Handling RPM ST" := lQShipAllocArhived.TRP_Whse_Handling_RPM_ST;

            if ShipAllocCostTmp.Insert() then;
            EntryNo += 1;
        end;
        lQShipAllocArhived.Close();
        //HEI.09<<
    end;

    local procedure InsertTmpNonArchivedAllocated3rdPartytAndOwn(lQueryShipAllocCost: Query "Shipping Cost Allocation");
    begin
        //HEI.09>>
        lQueryShipAllocCost.Open();
        while lQueryShipAllocCost.Read() do begin
            ShipAllocCostTmp."Entry No." := EntryNo;

            ShipAllocCostTmp."Primary Allocated Amount" := lQueryShipAllocCost.InternalTransfer;
            ShipAllocCostTmp."Internal Transfer ST" := lQueryShipAllocCost.InternalTransferST;
            ShipAllocCostTmp."RPM SO" := lQueryShipAllocCost.RPM_SO;
            ShipAllocCostTmp."RPM ST" := lQueryShipAllocCost.RPM_ST;

            ShipAllocCostTmp."General Overheads" := lQueryShipAllocCost.TotalGenOverheads;
            ShipAllocCostTmp."General Overheads ST" := lQueryShipAllocCost.TotalGenOverheadsST;
            ShipAllocCostTmp."Gen. Overheads RPM SO" := lQueryShipAllocCost.Gen_Overheads_RPM_SO;
            ShipAllocCostTmp."Gen. Overheads RPM ST" := lQueryShipAllocCost.Gen_Overheads_RPM_ST;

            ShipAllocCostTmp."Warehouse Overheads" := lQueryShipAllocCost.TotalWhseOverheads;
            ShipAllocCostTmp."Warehouse Overheads ST" := lQueryShipAllocCost.TotalWhseOverheadsST;
            ShipAllocCostTmp."Whse. Overheads RPM SO" := lQueryShipAllocCost.Whse_Overheads_RPM_SO;
            ShipAllocCostTmp."Whse. Overheads RPM ST" := lQueryShipAllocCost.Whse_Overheads_RPM_ST;

            ShipAllocCostTmp."Warehouse Handling" := lQueryShipAllocCost.TotalWhseHandling;
            ShipAllocCostTmp."Warehouse Handling ST" := lQueryShipAllocCost.TotalWhseHandlingST;
            ShipAllocCostTmp."Whse. Handling RPM SO" := lQueryShipAllocCost.Whse_Handling_RPM_SO;
            ShipAllocCostTmp."Whse. Handling RPM ST" := lQueryShipAllocCost.Whse_Handling_RPM_ST;

            ShipAllocCostTmp."FIX Warehouse Handling" := lQueryShipAllocCost.FIX_Warehouse_Handling;
            ShipAllocCostTmp."FIX Whse. Hand. ST" := lQueryShipAllocCost.FIX_Whse_Hand_ST;
            ShipAllocCostTmp."FIX Whse. Handling RPM SO" := lQueryShipAllocCost.FIX_Whse_Handling_RPM_SO;
            ShipAllocCostTmp."FIX Whse. Handling RPM ST" := lQueryShipAllocCost.FIX_Whse_Handling_RPM_ST;

            ShipAllocCostTmp."OVE Warehouse Handling" := lQueryShipAllocCost.OVE_Warehouse_Handling;
            ShipAllocCostTmp."OVE Whse. Hand. ST" := lQueryShipAllocCost.OVE_Whse_Hand_ST;
            ShipAllocCostTmp."OVE Whse. Handling RPM SO" := lQueryShipAllocCost.OVE_Whse_Handling_RPM_SO;
            ShipAllocCostTmp."OVE Whse. Handling RPM ST" := lQueryShipAllocCost.OVE_Whse_Handling_RPM_ST;

            ShipAllocCostTmp."TRP Warehouse Handling" := lQueryShipAllocCost.TRP_Warehouse_Handling;
            ShipAllocCostTmp."TRP Whse. Hand. ST" := lQueryShipAllocCost.TRP_Whse_Hand_ST;
            ShipAllocCostTmp."TRP Whse. Handling RPM SO" := lQueryShipAllocCost.TRP_Whse_Handling_RPM_SO;
            ShipAllocCostTmp."TRP Whse. Handling RPM ST" := lQueryShipAllocCost.TRP_Whse_Handling_RPM_ST;

            if ShipAllocCostTmp.Insert() then;
            EntryNo += 1;
        end;
        lQueryShipAllocCost.Close();
        //HEI.09<<
    end;

    local procedure InsertTmpNonArchivedTotal3PartyAndOwn(lQueryShipAllocCost: Query "Shipping Cost Allocation");
    begin
        //HEI.09>>
        lQueryShipAllocCost.Open();
        while lQueryShipAllocCost.Read() do begin
            ShipAllocCostTmp."Entry No." := EntryNo; //1
            ShipAllocCostTmp."Primary Allocated Amount" := lQueryShipAllocCost.InternalTransfer;
            ShipAllocCostTmp."General Overheads" := lQueryShipAllocCost.TotalGenOverheads;
            ShipAllocCostTmp."Warehouse Overheads" := lQueryShipAllocCost.TotalWhseOverheads;
            ShipAllocCostTmp."Warehouse Handling" := lQueryShipAllocCost.TotalWhseHandling;
            ShipAllocCostTmp."FIX Warehouse Handling" := lQueryShipAllocCost.FIX_Warehouse_Handling;
            ShipAllocCostTmp."OVE Warehouse Handling" := lQueryShipAllocCost.OVE_Warehouse_Handling;
            ShipAllocCostTmp."TRP Warehouse Handling" := lQueryShipAllocCost.TRP_Warehouse_Handling;
            if ShipAllocCostTmp.Insert() then;
            EntryNo += 1;
        end;
        lQueryShipAllocCost.Close();
        //HEI.09<<
    end;

    local procedure InsertTmpArchivedTotal3PartyAndOwn(lQShipAllocArhived: Query "Shipping Cost Archive");
    begin
        //HEI.09>>
        lQShipAllocArhived.Open();
        while lQShipAllocArhived.Read() do begin
            ShipAllocCostTmp."Entry No." := EntryNo; //1
            ShipAllocCostTmp."Primary Allocated Amount" := lQShipAllocArhived.InternalTransfer;
            ShipAllocCostTmp."General Overheads" := lQShipAllocArhived.TotalGenOverheads;
            ShipAllocCostTmp."Warehouse Overheads" := lQShipAllocArhived.TotalWhseOverheads;
            ShipAllocCostTmp."Warehouse Handling" := lQShipAllocArhived.TotalWhseHandling;
            ShipAllocCostTmp."FIX Warehouse Handling" := lQShipAllocArhived.FIX_Warehouse_Handling;
            ShipAllocCostTmp."OVE Warehouse Handling" := lQShipAllocArhived.OVE_Warehouse_Handling;
            ShipAllocCostTmp."TRP Warehouse Handling" := lQShipAllocArhived.TRP_Warehouse_Handling;
            if ShipAllocCostTmp.Insert() then;
            EntryNo += 1;
        end;
        lQShipAllocArhived.Close();
        //HEI.09<<
    end;

    //POENAB02, 11.06.2026>>
    //procedure NotFoundPostedDocShipCostInSCA(lPostedDocShippCost: Record "Posted Document Shipping Cost"; lArhived: Boolean): Boolean;
    procedure NotFoundPostedDocShipCostInSCA(lPostedDocShippCost: Record "Posted Trade Cost Order APS"; lArhived: Boolean): Boolean;
    //POENAB02, 11.06.2026<<
    var
        SCA: Record "Shipping Cost Allocation FND";
        SCAArhived: Record "Shipping Cost Archive FND";
        PostedWhsReceiptLine: Record "Posted Whse. Receipt Line";
        PostedWhsShipLine: Record "Posted Whse. Shipment Line";
        IsFoundInC2S: Boolean;
    begin
        //HEI.10>>
        //POENAB02, 11.06.2026>>
        //if lPostedDocShippCost."Source Type" = DATABASE::"Posted Whse. Receipt Header" then begin
        if lPostedDocShippCost."Posted Whse. Receipt No." <> '' then begin
            //POENAB02, 11.06.2026<<
            if lArhived then
                //POENAB02, 11.06.2026>>
                //IsFoundInC2S := SCAArhived.FindByNo(lPostedDocShippCost."Source No.")
                IsFoundInC2S := SCAArhived.FindByNo(lPostedDocShippCost."Posted Whse. Receipt No.")
            //POENAB02, 11.06.2026<<
            else
                //POENAB02, 11.06.2026>>
                //IsFoundInC2S := SCA.FindByNo(lPostedDocShippCost."Source No.");
                IsFoundInC2S := SCA.FindByNo(lPostedDocShippCost."Posted Whse. Receipt No.");
            //POENAB02, 11.06.2026<<
            if IsFoundInC2S then
                exit(false)
            else begin
                //POENAB02, 11.06.2026>>
                //PostedWhsReceiptLine.SetRange("No.", lPostedDocShippCost."Source No.");
                PostedWhsReceiptLine.SetRange("No.", lPostedDocShippCost."Posted Whse. Receipt No.");
                //POENAB02, 11.06.2026<<
                PostedWhsReceiptLine.SetFilter("Source Document", '%1', PostedWhsReceiptLine."Source Document"::"Inbound Transfer");
                if PostedWhsReceiptLine.FindFirst() then begin
                    PostedWhsShipLine.SetFilter("Source No.", PostedWhsReceiptLine."Source No.");
                    if PostedWhsShipLine.FindFirst() then begin
                        if lArhived then
                            IsFoundInC2S := SCAArhived.FindByNo(PostedWhsShipLine."No.")
                        else
                            IsFoundInC2S := SCA.FindByNo(PostedWhsShipLine."No.");
                        exit(not IsFoundInC2S);
                    end;
                end;
            end;
        end else begin
            //POENAB02, 11.06.2026>>
            /*
            if lArhived then
                IsFoundInC2S := SCAArhived.FindByNo(lPostedDocShippCost."Source No.")
            else
                IsFoundInC2S := SCA.FindByNo(lPostedDocShippCost."Source No.");
            */
            if lArhived then
                IsFoundInC2S := SCAArhived.FindByNo(lPostedDocShippCost."Posted Whse. Receipt No.")
            else
                IsFoundInC2S := SCA.FindByNo(lPostedDocShippCost."Posted Whse. Receipt No.");
            //POENAB02, 11.06.2026<<
            exit(not IsFoundInC2S);
        end;

        exit(true);
        //HEI.10<<
    end;
}

