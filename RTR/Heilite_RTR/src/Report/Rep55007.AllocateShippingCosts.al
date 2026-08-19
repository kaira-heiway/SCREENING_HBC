report 55007 "Allocate Shipping Costs"
{
    // version HEI.30

    // HEI.01 CHG2095415 IBM BULIMC01 11.04.2021# new report to allocate Warehouse Costs for Shipping costs
    // HEI.02 CHG2130188 IBM BULIMC01 13/10/2021 #new changes added
    // HEI.03 IBM BULIMC01 04/11/2021 #corrections
    // HEI.04 CHG2132177 IBM BULIMC01 06/12/2021#Own fleet Logic Cost
    // HEI.05 CHG2141694 IBM BULIMC01 13/04/2022#new code added for Job Queue
    // HEI.06 IBM CHG2132673 BULIMC01 13/04/2022 #filter the GL Accounts based on the SCOA Financial Statement from Whse. Setup
    // HEI.07 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //     #new DataItem "RPM_SKU" created in order to insert the entries in the table
    //     #new code added in order to allocate the Warehouse KPIs also for RPM transports
    //     #code commented and replaced with flowfields on the table in order to remove to optimise the ocde
    // HEI.08 CHG2132673 IBM BULIMC01 06/05/2022#field name changed for COGS Allocation via Job Queue
    //     #add GUIAllowed in case of manual run
    //     #add code to calculate totals for RPM
    // HEI.09 HB2618 - CHG2132177 IBM NASTAA02 12.05.2022 # C2S - Own Fleet Logistic Cost
    //   # Changed the Name for Field 136 from "Distance per Drop Allocation Own Fleet" to "Distance Allocation Own Fleet"
    // 
    // HEI.10 CHG2162842 IBM SAMANR01 23/06/202022 #C2S optimazation
    //   # Modify the code for optimized the execution time.
    //   # Query object used, GUIALLOWED added for disabled the window for JQ execution
    // HEI.11 CHG2162842 IBM SAMANR01 05/07/202022 #C2S optimazation
    //   # Add function PopulateTempSCATotalLines intorduce and add code for optimization
    //   # Move calcfields to pre-dataitem on report
    //   # Add correct key on report data item
    // HEI.12 CHG2162842 IBM SAMANR01 07/07/202022 #C2S optimazation
    //   # Add new function "PopulateCalCFields"
    // HEI.13 CHG2162842 IBM SAMANR01 07/21/202022 #C2S optimazation
    //   # BUG Fix
    // HEI.14 CHG2169207 IBM SISUM01 23/08/2022 #add function UpdateRPMOverallocation to calculate RPM Overallocation
    //   # add processing date
    //   # BUG Fix after optimization
    //   # new function created InsertTotalsShippAlloc
    //   # new function created InsertTempCustIT2
    // HEI.15 CHG2169207 IBM SISUM01 25/08/2022 # BUG Fix after optimization and optimization for dataitem DeliveryToCustomer
    // HEI.16 CHG2169207 IBM SISUM01 29/08/2022 # Split the RPM SKU lines by Own Fleet TRUE/FALSE and correction on formula for "Period Net weight transfer per RPM"
    // HEI.17 CHG2169207 IBM SISUM01 06/09/2022 # correction on formula for "Period RPM Unit Cost Transfer", "Period RPM Gen. Overh. IT", "Period RPM Gen. Overh. IT","Period RPM Whse. Handl. IT"
    // HEI.18 CHG2169207 IBM SISUM01 14/09/2022 # add RPM-SKU that are missing. Create new function: Insert2RPMSKUMissingRec
    // HEI.19 CHG2169207 IBM SISU01  22/09/2022 # correct the calculation for "Period Transfers per SKU/Lot" from HEI.04 version and other corrections from previous dev
    // HEI.20 CHG2169207 IBM SISU01  26/09/2022 # fill in "Period Cost G/L Own Fleet" no matter is  "Own Fleet" or not
    // HEI.21 CHG2177487 IBM SISU01  17/10/2022 # change formula for General Overheads
    // HEI.22 CHG2178734 IBM SISU01  07/11/2022 # change calculation for IT cost fields and NoofLines in RPMAllocation
    //    #create new functions UpdateRPMOverallocationNew, InsertRPM4Overallocation, UpdateRPMSKUFields,SCACalcFlowFields  - for optimization
    //    #create new function InsertNoOfLinesByDocItemCateg to calc the number of lines by document and item category code
    // HEI.23 CHG2178734 IBM SISU01  10/11/2022 # for the following fields was removed calculation by Own Fleet
    //       # "Period Net Weight SKU/Lot","Period Transfers per SKU/Lot","Period Gen. Overh. per SKU/Lot"
    //       # "Period Whs. Overh. per SKU/Lot", "Period Whse. Hand. per SKU/Lot",  "Period Picking Factor SKU/Lot"
    //       # and RPM overallocation
    // HEI.24 CHG2178734 IBM SISU01  16/11/2022 #add all missing RPM-SKU. Replace the table filter condition for DataItem SKU_RPM with Source Document <> Outbound Transfer
    // HEI.25 CHG2182707 IBM SISU01  22/11/2022 #new function InsertRPMSKU, add missing RPM-SKU records for Assembly List
    // HEI.26 CHG2167931 IBM SISUM01 22/11/2022 #calculate Handling fields
    // HEI.27 CHG2185464 IBM SISUM01 19/12/2022 #optimization for flowfields; create new functions
    //     #create new function InsertRPMCalcFlds4Overallocation - the flowfields from T50215 based on the fileds from T50208 are calculated with Queries that use only normal fields and inserted the sum in a temp T50208
    //     #create new function SCACalcFlowFieldsNew - calculate the needed values with Queries that use only normal fields
    // HEI.30 CHG2296790 IBM POENAB02 28.03.2025 Please correct C2S allocation logic for Own Fleet reversed shipments
    //   # Correction done for "Own Fleet" with Reversal situation

    // BC Upgrade POENAB02: Original (HeiLite) report id 50522
    // BC Upgrade POENAB02, 17.04.2026, correction of migration from HeiLite
    // BC POENAB02, 08.07.2026, Added UsageCategory

    Permissions = TableData "Shipping Cost Allocation FND" = rimd,
                  TableData "RPM - SKU Relationship FND" = rimd;
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Whse. Cost Alloc Setup FND"; "Whse. Cost Alloc Setup FND")
        {
            DataItemTableView = SORTING("C2S Name") ORDER(Ascending);

            trigger OnAfterGetRecord();
            var
                GLAccount: Record "G/L Account";
            begin
                if GuiAllowed then begin //HEI.10>>
                    Counter += 1;
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        ProgressWindow.Update(1, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := Time;
                    end;
                end; //HEI.10<<

                //HEI.10>>
                Clear(gQr_GLQuery);
                gQr_GLQuery.SetFilter(No, "G/L Account Range");
                gQr_GLQuery.SetFilter(FinancialStatementVersion, WarehouseSetup."SCOA Financial Statement FND");
                gQr_GLQuery.SetRange(PostingDate, StartingDate, EndingDate);
                gQr_GLQuery.SetFilter(DimensionCode, GLSetup."Shortcut Dimension 2 Code");
                gQr_GLQuery.SetFilter(DimensionValueCode, "CCC Dim. Filter");
                gQr_GLQuery.Open();
                while gQr_GLQuery.Read() do begin
                    TempWhseCostSetup.Reset();
                    TempWhseCostSetup.SetCurrentKey("C2S Name", "Distribution Type");
                    TempWhseCostSetup.SetRange("C2S Name", "C2S Name");
                    if InsertChild then
                        TempWhseCostSetup.SetRange("Distribution Type", "Distribution Type"); //HEI.02
                    if not TempWhseCostSetup.FindFirst() then begin
                        TempWhseCostSetup.Init();
                        TempWhseCostSetup.TransferFields("Whse. Cost Alloc Setup FND");
                        //HEI.15>>
                        //TempWhseCostSetup."Period Cost" += gQr_GLQuery.Amount;
                        TempWhseCostSetup."Period Cost" := gQr_GLQuery.Amount;
                        //HEI.15<<
                        TempWhseCostSetup.Insert();
                    end else begin
                        TempWhseCostSetup."Period Cost" += gQr_GLQuery.Amount;
                        TempWhseCostSetup.Modify();
                    end;

                end;
                gQr_GLQuery.Close(); //HEI.13
                /*
                //HEI.06<<
                GLAccount.RESET;
                GLAccount.SETFILTER("No.","G/L Account Range");
                GLAccount.SETFILTER("Financial Statement version",WarehouseSetup."SCOA Financial Statement");
                IF GLAccount.FINDSET(FALSE,FALSE) THEN
                  REPEAT
                //HEI.06>>
                    GLEntry.RESET;
                    GLEntry.SETCURRENTKEY("G/L Account No.","Posting Date");
                    //GLEntry.SETFILTER("G/L Account No.","G/L Account Range"); //HEI.06 commented
                    GLEntry.SETRANGE("G/L Account No.",GLAccount."No."); //HEI.06
                    GLEntry.SETRANGE("Posting Date",StartingDate,EndingDate);
                    IF GLEntry.FINDSET(FALSE,FALSE) THEN REPEAT
                      SkipGL := FALSE;
                      DimSetEntry.SETRANGE("Dimension Set ID",GLEntry."Dimension Set ID");
                      DimSetEntry.SETRANGE("Dimension Code",GLSetup."Shortcut Dimension 2 Code");
                      DimSetEntry.SETFILTER("Dimension Value Code","CCC Dim. Filter");
                      IF NOT DimSetEntry.FINDFIRST THEN
                        SkipGL := TRUE;
                
                      IF NOT SkipGL THEN BEGIN
                        TempWhseCostSetup.RESET;
                        TempWhseCostSetup.SETCURRENTKEY("C2S Name","Distribution Type");
                        TempWhseCostSetup.SETRANGE("C2S Name","C2S Name");
                        IF InsertChild THEN
                          TempWhseCostSetup.SETRANGE("Distribution Type","Distribution Type"); //HEI.02
                        IF NOT TempWhseCostSetup.FINDFIRST THEN BEGIN
                          TempWhseCostSetup.INIT;
                          TempWhseCostSetup.TRANSFERFIELDS("Whse. Cost Alloc Setup FND");
                          TempWhseCostSetup."Period Cost" += GLEntry.Amount;
                          TempWhseCostSetup.INSERT;
                        END ELSE BEGIN
                          TempWhseCostSetup."Period Cost" += GLEntry.Amount;
                          TempWhseCostSetup.MODIFY;
                        END;
                      END;
                    UNTIL GLEntry.NEXT = 0;
                  UNTIL GLAccount.NEXT = 0; //HEI.06
                */
                //HEI.10<<
                if "C2S Name" = "C2S Name"::"General Overhead Costs (Fixed)" then
                    GenOverheadsType := "Allocation Type"
                else if "C2S Name" = "C2S Name"::"Warehouse Handling Costs (Variable)" then
                    WhseHandlType := "Allocation Type"
                else if "C2S Name" = "C2S Name"::"Warehouse Overhead Costs (Fixed)" then
                    WhseOverheadType := "Allocation Type";

            end;

            trigger OnPreDataItem();
            begin
                if GuiAllowed then begin //HEI.10>>
                    NoOfRecords := COUNT;
                    NoOfRecProgress := NoOfRecords div 100;
                    Counter := 0;
                    NoOfProgresed := 0;
                    TimeProgress := Time;
                end;
            end;
        }
        dataitem(RPMAllocation; "Shipping Cost Allocation FND")
        {
            DataItemTableView = SORTING("Posting Date", "Destination Type", "Only RPM Transportation", "Source Document", "Item Category Code") ORDER(Ascending) WHERE("Only RPM Transportation" = FILTER(true), "Source Document" = CONST("Sales Return Order"));

            trigger OnAfterGetRecord();
            begin
                if GuiAllowed then begin //HEI.10>>
                    Counter += 1;
                    if Counter >= NoOfRecProgress
                    then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        ProgressWindow.Update(2, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := Time;
                    end;
                end; //HEI.10<<

                //HEI.04<<
                //InsertTotals(RPMAllocation); //HEI.11
                //NumberOfLines := GetLinesNumber("No."); //HEI.10
                //HEI.22>>
                //NumberOfLines := GetLinesNumber_New("No."); //HEI.10
                NumberOfLines := GetLinesNumberByDocItemCateg("No.", "Only RPM Transportation");
                //HEI.22<<

                //HEI.07<< allocate warehouse costs
                if InsertChild then begin
                    if "Distribution Type" = "Distribution Type"::Primary then
                        AllocatePrimaryWarehouseCosts(RPMAllocation)
                    else if "Distribution Type" = "Distribution Type"::Secondary then
                        AllocateSecondaryWarehouseCosts(RPMAllocation)
                    else if "Distribution Type" = "Distribution Type"::Total then
                        //CalculateTotalWhseCosts(RPMAllocation);  //HEI.10>>
                        //HEI.15>>
                        //CalculateTotalWhseCosts_New(RPMAllocation);//HEI.10>>
                        CalculateTotalWhseCosts(RPMAllocation);
                    //HEI.15<<
                end else
                    AllocateTotalWarehouseCosts(RPMAllocation);
                //HEI.07<<

                //insert Own fleet
                //HEI.19>> requested to have  "Period G/L Cost Own Fleet" fill in for all records
                /*
                IF "Own Fleet" THEN BEGIN
                  TempWhseCostSetup.RESET;
                  TempWhseCostSetup.SETCURRENTKEY("C2S Name");//HEI.10>>
                  TempWhseCostSetup.SETRANGE("C2S Name",TempWhseCostSetup."C2S Name"::"Own Fleet");
                  IF TempWhseCostSetup.FINDSET(FALSE,FALSE) THEN
                    REPEAT
                      "Period G/L Cost Own Fleet" := TempWhseCostSetup."Period Cost";
                      IF "Period Net Weight (Kg)" <> 0 THEN
                        "Weight Allocation Own Fleet" := ABS(("Net Weight (Kg)" / "Period Net Weight (Kg)") * (TempWhseCostSetup."Net Weight Allocation %"/100) * "Period G/L Cost Own Fleet");
                      IF "Period Drop Counts" <> 0 THEN
                        "No. of Drops All. Own Fleet" := ABS(("No. of Drops" / "Period Drop Counts" ) * (TempWhseCostSetup."No. of Drops Allocation %"/100) * "Period G/L Cost Own Fleet" / NumberOfLines);
                      IF "Period Distance" <> 0 THEN
                        "Distance Allocation Own Fleet" := ABS((Distance / "Period Distance") * (TempWhseCostSetup."Distance Allocation %"/100) * "Period G/L Cost Own Fleet" / NumberOfLines);
                      "Primary Allocated Amount" := "Weight Allocation Own Fleet" + "No. of Drops All. Own Fleet" + "Distance Allocation Own Fleet";
                    UNTIL TempWhseCostSetup.NEXT = 0;
                END;
                //HEI.04>>
                */

                TempWhseCostSetup.Reset();
                TempWhseCostSetup.SetCurrentKey("C2S Name");//HEI.10>>
                TempWhseCostSetup.SetRange("C2S Name", TempWhseCostSetup."C2S Name"::"Own Fleet");
                if TempWhseCostSetup.FindSet(false) then
                    repeat
                        "Period G/L Cost Own Fleet" := TempWhseCostSetup."Period Cost";
                        if "Own Fleet" then begin
                            if "Period Net Weight (Kg)" <> 0 then
                                //HEI.24>>
                                //"Weight Allocation Own Fleet" := ABS(("Net Weight (Kg)" / "Period Net Weight (Kg)") * (TempWhseCostSetup."Net Weight Allocation %"/100) * "Period G/L Cost Own Fleet");
                                "Weight Allocation Own Fleet" := ("Net Weight (Kg)" / "Period Net Weight (Kg)") * (TempWhseCostSetup."Net Weight Allocation %" / 100) * "Period G/L Cost Own Fleet";
                            //HEI.24<<
                            if ("Period Drop Counts" <> 0)
                              and (NumberOfLines <> 0) //HEI.22
                            then
                                //HEI.24<<
                                //"No. of Drops All. Own Fleet" := ABS(("No. of Drops" / "Period Drop Counts" ) * (TempWhseCostSetup."No. of Drops Allocation %"/100) * "Period G/L Cost Own Fleet" / NumberOfLines);
                                "No. of Drops All. Own Fleet" := ("No. of Drops" / "Period Drop Counts") * (TempWhseCostSetup."No. of Drops Allocation %" / 100) * "Period G/L Cost Own Fleet" / NumberOfLines;
                            //HEI.24<<
                            if ("Period Distance" <> 0)
                              and (NumberOfLines <> 0) //HEI.22
                            then
                                //HEI.24>>
                                //"Distance Allocation Own Fleet" := ABS((Distance / "Period Distance") * (TempWhseCostSetup."Distance Allocation %"/100) * "Period G/L Cost Own Fleet" / NumberOfLines);
                                "Distance Allocation Own Fleet" := (Distance / "Period Distance") * (TempWhseCostSetup."Distance Allocation %" / 100) * "Period G/L Cost Own Fleet" / NumberOfLines;
                            //HEI.24<<
                            if not Reversed then //HEI.30
                                "Primary Allocated Amount" := "Weight Allocation Own Fleet" + "No. of Drops All. Own Fleet" + "Distance Allocation Own Fleet";
                        end;
                    until TempWhseCostSetup.Next() = 0;
                //HEI.19<<


                Modify(); //HEI.07
                //HEI.07 commented and replaced in the new DataItem RPM_SKU because some info from the next DataItems are needed for this insertion<<
                /*BOMComponent.RESET;
                BOMComponent.SETCURRENTKEY("No.");
                BOMComponent.SETRANGE("No.","Item No.");
                IF BOMComponent.FINDSET(FALSE,FALSE) THEN
                  REPEAT
                    InsertRelationshipRPMSKU(RPMAllocation,BOMComponent."Parent Item No.")
                  UNTIL BOMComponent.NEXT = 0;
                
                InsertRelationshipRPMSKU(RPMAllocation,"Item No.");*/
                //HEI.07 commented and replaced in the new DataItem RPM_SKU because some info from the next DataItems are needed for this insertion<<

            end;

            trigger OnPreDataItem();
            begin
                SetRange("Posting Date", StartingDate, EndingDate);
                SetFilter("Item Category Code", SalesReceivablesSetup."RPMRelatedItemCategoryCode FND");

                if GuiAllowed then begin //HEI.10>>
                    NoOfRecords := Count;
                    NoOfRecProgress := NoOfRecords div 100;
                    Counter := 0;
                    NoOfProgresed := 0;
                    TimeProgress := Time;
                end;
                //HEI.10<<


                /*
                //HEI.11>>
                CLEAR(gRec_InsertTotals);
                gRec_InsertTotals.RESET;
                gRec_InsertTotals.COPYFILTERS(RPMAllocation);
                gRec_InsertTotals.SETRANGE("Own Fleet",TRUE);
                gRec_InsertTotals.MODIFYALL("Period Net Weight (Kg)",PeriodNetWeightOwnFleet,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Distance",PeriodDistance,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Drop Counts",PeriodDrops,FALSE);
                
                CLEAR(gRec_InsertTotals);
                gRec_InsertTotals.RESET;
                gRec_InsertTotals.COPYFILTERS(RPMAllocation);
                gRec_InsertTotals.SETRANGE("Own Fleet",FALSE);
                gRec_InsertTotals.MODIFYALL("Period Net Weight (Kg)",PeriodNetWeight,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Picking Factor" ,PeriodPickingFactor,FALSE);
                //HEI.11<<
                */

            end;
        }
        dataitem("Shipping Cost Allocation FND"; "Shipping Cost Allocation FND")
        {
            DataItemTableView = SORTING("Posting Date", "Destination Type", "Only RPM Transportation", "Source Document", "Item Category Code");

            trigger OnAfterGetRecord();
            begin
                if GuiAllowed then begin //HEI.10>>
                    Counter += 1;
                    if Counter >= NoOfRecProgress
                    then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        ProgressWindow.Update(3, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := Time;
                    end;
                end; //HEI.10<<

                InitValues();

                //InsertTotals("Shipping Cost Allocation FND"); //HEI.11
                //NumberOfLines := GetLinesNumber("No."); //HEI.10
                //HEI.22>>
                //NumberOfLines := GetLinesNumber_New("No."); //HEI.10
                NumberOfLines := GetLinesNumberByDocItemCateg("No.", "Only RPM Transportation");
                //HEI.22<<


                //Internal Transfers
                if "Destination Type" = "Destination Type"::Location then begin
                    if (StrPos(InventorySetup."Finished Goods ItemCatCode FND", "Item Category Code") <> 0) or (StrPos(SalesReceivablesSetup."RPMRelatedItemCategoryCode FND", "Item Category Code") <> 0) then begin
                        //HEI.02<<
                        if InsertChild then begin
                            if "Distribution Type" = "Distribution Type"::Primary then
                                AllocatePrimaryWarehouseCosts("Shipping Cost Allocation FND")
                            else if "Distribution Type" = "Distribution Type"::Secondary then
                                AllocateSecondaryWarehouseCosts("Shipping Cost Allocation FND")
                            else if "Distribution Type" = "Distribution Type"::Total then
                                //CalculateTotalWhseCosts("Shipping Cost Allocation FND"); //HEI.10
                                //HEI.15>>
                                //CalculateTotalWhseCosts_New("Shipping Cost Allocation FND");   //HEI.10
                                CalculateTotalWhseCosts("Shipping Cost Allocation FND");
                            //HEI.15
                        end else
                            AllocateTotalWarehouseCosts("Shipping Cost Allocation FND");
                        //HEI.02>>

                        //HEI.22>>
                        if "Own Fleet" then
                            if not Reversed then //HEI.30
                                "Primary Allocated Amount" := "Weight Allocation Own Fleet" + "No. of Drops All. Own Fleet" + "Distance Allocation Own Fleet";
                        //HEI.22<<

                    end;

                    //Delivery to Customers
                end else if ("Destination Type" = "Destination Type"::Customer) and (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", "Item Category Code") <> 0) then begin
                    //allocate warehouse costs
                    //HEI.02<<
                    if InsertChild then begin
                        if "Distribution Type" = "Distribution Type"::Primary then
                            AllocatePrimaryWarehouseCosts("Shipping Cost Allocation FND")
                        else if "Distribution Type" = "Distribution Type"::Secondary then
                            AllocateSecondaryWarehouseCosts("Shipping Cost Allocation FND")
                        else if "Distribution Type" = "Distribution Type"::Total then
                            //CalculateTotalWhseCosts("Shipping Cost Allocation FND"); //HEI.10
                            //HEI.15>>
                            //CalculateTotalWhseCosts_New("Shipping Cost Allocation FND"); //HEI.10
                            CalculateTotalWhseCosts("Shipping Cost Allocation FND");
                        //HEI.15<<
                    end else
                        AllocateTotalWarehouseCosts("Shipping Cost Allocation FND");
                    //HEI.02>>

                    //alocate IT costs
                    AllocateCustITCosts("Shipping Cost Allocation FND");

                    //HEI.23>>
                    if "Own Fleet" then
                        if not Reversed then //HEI.30
                            "Primary Allocated Amount" := "Weight Allocation Own Fleet" + "No. of Drops All. Own Fleet" + "Distance Allocation Own Fleet";
                    //HEI.23<<

                    /*HEI.07 commented and replaced by FlowFields on the table T50215
                    RPMSKURelation.RESET;
                    RPMSKURelation.SETRANGE("Period Start Date",StartingDate);
                    RPMSKURelation.SETRANGE("Period End Date",EndingDate);
                    RPMSKURelation.SETRANGE("Linked Item No.","Item No.");
                    RPMSKURelation.SETRANGE("Customer No.","Destination No.");
                    RPMSKURelation.SETFILTER("Period RPM Unit Cost Customer",'<>%1',0);
                    IF RPMSKURelation.FINDSET(FALSE,FALSE)THEN REPEAT
                      IF "Distribution Type" = "Distribution Type"::Total THEN //HEI.02
                        RPMUnitCostCust += RPMSKURelation."Period RPM Unit Cost Customer"
                      //HEI.02<<
                      ELSE IF "Distribution Type" = "Distribution Type"::Primary THEN
                        RPMUnitCostCust += RPMSKURelation."Primary RPM Unit Cost Customer"
                      ELSE
                        RPMUnitCostCust += RPMSKURelation."Second. RPM Unit Cost Customer";
                      //HEI.02
                      CountCust += 1;
                    UNTIL RPMSKURelation.NEXT = 0;

                    RPMSKURelation.RESET;
                    RPMSKURelation.SETRANGE("Period Start Date",StartingDate);
                    RPMSKURelation.SETRANGE("Period End Date",EndingDate);
                    RPMSKURelation.SETRANGE("Linked Item No.","Item No.");
                    RPMSKURelation.SETFILTER("Period RPM Unit Cost Transfer",'<>%1',0);
                    IF RPMSKURelation.FINDFIRST THEN REPEAT
                      IF "Distribution Type" = "Distribution Type"::Total THEN //HEI.02
                        RPMUnitCostTransfer += RPMSKURelation."Period RPM Unit Cost Transfer"
                      //HEI.02<<
                      ELSE IF "Distribution Type" = "Distribution Type"::Primary THEN
                        RPMUnitCostTransfer += RPMSKURelation."Primary RPM Unit Cost Transfer"
                      ELSE
                        RPMUnitCostTransfer += RPMSKURelation."Second. RPM Unit Cost Transfer";
                      //HEI.02
                      CountTransfer += 1;
                    UNTIL RPMSKURelation.NEXT = 0;

                    IF CountCust <> 0 THEN
                      "Period RPM Unit Cost Customer" := RPMUnitCostCust / CountCust;
                    IF CountTransfer <> 0 THEN
                      "Period RPM Unit Cost Transfer" := RPMUnitCostTransfer / CountTransfer;
                    //HEI.07 commented and replaced by FlowFields on the table T50215*/

                end;

                Modify();

            end;

            trigger OnPreDataItem();
            begin
                SetRange("Posting Date", StartingDate, EndingDate);

                if GuiAllowed then begin //HEI.10>>
                    NoOfRecords := Count;
                    NoOfRecProgress := NoOfRecords div 100;
                    Counter := 0;
                    NoOfProgresed := 0;
                    TimeProgress := Time;
                end; //HEI.10<<

                /*
                //HEI.11>>
                CLEAR(gRec_InsertTotals);
                gRec_InsertTotals.RESET;
                gRec_InsertTotals.COPYFILTERS(RPMAllocation);
                gRec_InsertTotals.SETRANGE("Own Fleet",TRUE);
                gRec_InsertTotals.MODIFYALL("Period Net Weight (Kg)",PeriodNetWeightOwnFleet,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Distance",PeriodDistance,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Drop Counts",PeriodDrops,FALSE);
                
                CLEAR(gRec_InsertTotals);
                gRec_InsertTotals.RESET;
                gRec_InsertTotals.COPYFILTERS(RPMAllocation);
                gRec_InsertTotals.SETRANGE("Own Fleet",FALSE);
                gRec_InsertTotals.MODIFYALL("Period Net Weight (Kg)",PeriodNetWeight,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Picking Factor" ,PeriodPickingFactor,FALSE);
                //HEI.11<<
                */

            end;
        }
        dataitem(InternalTransfers; "Shipping Cost Allocation FND")
        {
            DataItemTableView = SORTING("Posting Date", "Destination Type", "Only RPM Transportation", "Source Document", "Item Category Code") ORDER(Ascending) WHERE("Source Document" = FILTER("Outbound Transfer"));

            trigger OnAfterGetRecord();
            var
                WhseHandlAVG: Decimal;
                GenOverhAVG: Decimal;
                WhseOverhAVG: Decimal;
                Found: Boolean;
            begin
                if GuiAllowed then begin //HEI.10>>
                    Counter += 1;
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        ProgressWindow.Update(4, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := Time;
                    end;
                end; //HEI.10<<

                InitValues();

                //InsertTotals(InternalTransfers); //HEI.11

                //alocate IT
                AllocateITCosts(InternalTransfers);

                //hei.04
                //NumberOfLines := GetLinesNumber("No."); //HEI.10
                NumberOfLines := GetLinesNumber_New("No."); //HEI.10
                                                            //HEI.22>> moved calculation on DataItem: Shipping Cost Allocation to calculate correctly the Avg. Cost-Internal Transfer ST field
                                                            /*
                                                            IF "Own Fleet" THEN
                                                              "Primary Allocated Amount" := "Weight Allocation Own Fleet" + "No. of Drops All. Own Fleet" + "Distance Allocation Own Fleet";
                                                            */
                                                            //HEI.04>>

                // BC Upgrade POENAB02, 17.04.2026 >>                
                // Clear(ShippCostAllocSource); 
                // ShippCostAllocSource.SetRange("Posting Date", StartingDate, EndingDate);
                // ShippCostAllocSource.SetRange("Source Document", "Source Document"::"Outbound Transfer");
                // ShippCostAllocSource.SetRange("Item No.", "Item No.");
                // ShippCostAllocSource.SetRange("Lot No. & Destination No.", "Lot No. & Destination No.");
                // ShippCostAllocSource.SetRange("Location Code", "Location Code");
                // ShippCostAllocSource.SetFilter("Entry No.", '<>%1', "Entry No."); //HEI.11 //HEI.15 roll back the coment of the line done in HEI.11 because when is only 1rec in filter avg fields must be 0
                // ShippCostAllocSource.SetRange("Distribution Type", "Distribution Type"); //HEI.02
                // ShippCostAllocSource.SetRange("Item Category Code", InventorySetup."Finished Goods Item Cat Code"); //HEI.22

                // ShippCostAllocSource.Open();
                // while ShippCostAllocSource.Read() do begin
                //     if (GenOverheadsType = GenOverheadsType::"Net Weight (Kg)") and (ShippCostAllocSource.TotalNetWeight <> 0) and ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight <> 0) then
                //         "Avg. Cost-General Overheads ST" := ("General Overheads" + ShippCostAllocSource.TotalGenOverheads) / ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight)
                //     else if (GenOverheadsType = GenOverheadsType::"Picking Factor") and (ShippCostAllocSource.TotalPickingFactor <> 0) and ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor <> 0) then
                //         "Avg. Cost-General Overheads ST" := ("General Overheads" + ShippCostAllocSource.TotalGenOverheads) / ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor);

                //     if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and (ShippCostAllocSource.TotalNetWeight <> 0) and ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight <> 0) then
                //         "Avg. Cost-Whse. Handling ST" := ("Warehouse Handling" + ShippCostAllocSource.TotalWhseHandling) / ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight)
                //     else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShippCostAllocSource.TotalPickingFactor <> 0) and ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor <> 0) then
                //         "Avg. Cost-Whse. Handling ST" := ("Warehouse Handling" + ShippCostAllocSource.TotalWhseHandling) / ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor);

                //     if (WhseOverheadType = WhseOverheadType::"Net Weight (Kg)") and (ShippCostAllocSource.TotalNetWeight <> 0) and ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight <> 0) then
                //         "Avg. Cost-Whse. Overhead ST" := ("Warehouse Overheads" + ShippCostAllocSource.TotalWhseOverheads) / ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight)
                //     else if (WhseOverheadType = WhseOverheadType::"Picking Factor") and (ShippCostAllocSource.TotalPickingFactor <> 0) and ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor <> 0) then
                //         "Avg. Cost-Whse. Overhead ST" := ("Warehouse Overheads" + ShippCostAllocSource.TotalWhseOverheads) / ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor);

                //     //HEI.19>>
                //     /*
                //     IF ShippCostAllocSource.TotalNetWeight <> 0 THEN
                //       IF ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight <> 0) THEN
                //     */
                //     //HEI.19<<

                //     if (ShippCostAllocSource.TotalNetWeight <> 0) and ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight <> 0) then begin
                //         //HEI.22>>
                //         /*
                //         IF "Own Fleet" THEN
                //           "Avg. Cost-Internal Transfer ST" := ("Primary Allocated Amount" + ShippCostAllocSource.TotalWeightAllocationOwnFleet
                //                                               + ShippCostAllocSource.TotaDistanceAllocationOwnFleet + ShippCostAllocSource.TotalNoofDropsAllOwnFleet)
                //                                               / ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight)
                //         ELSE
                //         */
                //         //HEI.22<<
                //         "Avg. Cost-Internal Transfer ST" := ("Primary Allocated Amount" + ShippCostAllocSource.InternalTransfer) / ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight);
                //     end;

                //     //HEI.26>>
                //     if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and (ShippCostAllocSource.TotalNetWeight <> 0) and ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight <> 0) then
                //         "OVE Avg. Cost-Whse. Handl. ST" := ("OVE Warehouse Handling" + ShippCostAllocSource.TotalOVEWarehouseHandling) / ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight)
                //     else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShippCostAllocSource.TotalPickingFactor <> 0) and ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor <> 0) then
                //         "OVE Avg. Cost-Whse. Handl. ST" := ("OVE Warehouse Handling" + ShippCostAllocSource.TotalOVEWarehouseHandling) / ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor);

                //     if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and (ShippCostAllocSource.TotalNetWeight <> 0) and ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight <> 0) then
                //         "TRP Avg. Cost-Whse. Handl. ST" := ("TRP Warehouse Handling" + ShippCostAllocSource.TotalTRPWarehouseHandling) / ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight)
                //     else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShippCostAllocSource.TotalPickingFactor <> 0) and ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor <> 0) then
                //         "TRP Avg. Cost-Whse. Handl. ST" := ("TRP Warehouse Handling" + ShippCostAllocSource.TotalTRPWarehouseHandling) / ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor);

                //     if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and (ShippCostAllocSource.TotalNetWeight <> 0) and ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight <> 0) then
                //         "FIX Avg. Cost-Whse. Handl. ST" := ("FIX Warehouse Handling" + ShippCostAllocSource.TotalFIXWarehouseHandling) / ("Net Weight (Kg)" + ShippCostAllocSource.TotalNetWeight)
                //     else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShippCostAllocSource.TotalPickingFactor <> 0) and ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor <> 0) then
                //         "FIX Avg. Cost-Whse. Handl. ST" := ("FIX Warehouse Handling" + ShippCostAllocSource.TotalFIXWarehouseHandling) / ("Picking Factor" + ShippCostAllocSource.TotalPickingFactor);
                //     //HEI.26<<

                // end;
                // ShippCostAllocSource.CLOSE();

                // //HEI.22>>
                // //IT Costs - check if for the same SKU - Lot No - Dest No - Location No the IT is already calc
                // ShipCostAllocation.Reset();
                // ShipCostAllocation.SetRange("Posting Date", StartingDate, EndingDate);
                // ShipCostAllocation.SetRange("Source Document", ShipCostAllocation."Source Document"::"Outbound Transfer");
                // ShipCostAllocation.SetRange("Item No.", "Item No.");
                // ShipCostAllocation.SetFilter("Entry No.", '<%1', "Entry No.");
                // ShipCostAllocation.SetRange("Lot No. & Destination No.", "Lot No. & Destination No.");
                // ShipCostAllocation.SetRange("Lot No. & Location Code", "Lot No. & Location Code");
                // ShipCostAllocation.SetRange("Distribution Type", "Distribution Type");
                // ShipCostAllocation.SetRange("Item Category Code", "Item Category Code");
                // ShipCostAllocation.SetRange("IT Cost Is Calc", true);
                // if ShipCostAllocation.FINDLAST() then begin
                //     "IT Cost-Internal Transfer ST" := ShipCostAllocation."IT Cost-Internal Transfer ST";
                //     "IT Cost-Whse. Handling ST" := ShipCostAllocation."IT Cost-Whse. Handling ST";
                //     "IT Cost-General Overheads ST" := ShipCostAllocation."IT Cost-General Overheads ST";
                //     "IT Cost-Whse. Overhead ST" := ShipCostAllocation."IT Cost-Whse. Overhead ST";
                //     Found := true;
                // end;
                // //HEI.22<<

                // //IT Costs
                // if not Found then begin //HEI.21
                //     ShipCostAllocation.Reset();
                //     ShipCostAllocation.SetRange("Posting Date", StartingDate, EndingDate);
                //     ShipCostAllocation.SetRange("Source Document", ShipCostAllocation."Source Document"::"Outbound Transfer");
                //     ShipCostAllocation.SetRange("Item No.", "Item No.");
                //     //ShipCostAllocation.SetRange("Originial Lot & Location Code","Originial Lot & Location Code");
                //     ShipCostAllocation.SetFilter("Entry No.", '<%1', "Entry No.");
                //     ShipCostAllocation.SetRange("Lot No. & Destination No.", "Lot No. & Location Code");
                //     ShipCostAllocation.SetRange("Distribution Type", "Distribution Type"); //HEI.02
                //     ShipCostAllocation.SetRange("Item Category Code", InventorySetup."Finished Goods Item Cat Code"); //HEI.22
                //     if ShipCostAllocation.FindLast() then begin
                //         //add primay cost
                //         if ShipCostAllocation."Avg. Cost-Whse. Handling ST" <> 0 then
                //             "IT Cost-Whse. Handling ST" := ShipCostAllocation."Avg. Cost-Whse. Handling ST"
                //         else
                //             if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and (ShipCostAllocation."Net Weight (Kg)" <> 0) then
                //                 "IT Cost-Whse. Handling ST" := ShipCostAllocation."Warehouse Handling" / ShipCostAllocation."Net Weight (Kg)"
                //             else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShipCostAllocation."Picking Factor" <> 0) then
                //                 "IT Cost-Whse. Handling ST" := ShipCostAllocation."Warehouse Handling" / ShipCostAllocation."Picking Factor";

                //         if ShipCostAllocation."Avg. Cost-General Overheads ST" <> 0 then
                //             "IT Cost-General Overheads ST" := ShipCostAllocation."Avg. Cost-General Overheads ST"
                //         else
                //             if (GenOverheadsType = GenOverheadsType::"Net Weight (Kg)") and (ShipCostAllocation."Net Weight (Kg)" <> 0) then
                //                 "IT Cost-General Overheads ST" := ShipCostAllocation."General Overheads" / ShipCostAllocation."Net Weight (Kg)"
                //             else if (GenOverheadsType = GenOverheadsType::"Picking Factor") and (ShipCostAllocation."Picking Factor" <> 0) then
                //                 "IT Cost-General Overheads ST" := ShipCostAllocation."General Overheads" / ShipCostAllocation."Picking Factor";

                //         if ShipCostAllocation."Avg. Cost-Whse. Overhead ST" <> 0 then
                //             "IT Cost-Whse. Overhead ST" := ShipCostAllocation."Avg. Cost-Whse. Overhead ST"
                //         else
                //             if (WhseOverheadType = WhseOverheadType::"Net Weight (Kg)") and (ShipCostAllocation."Net Weight (Kg)" <> 0) then
                //                 "IT Cost-Whse. Overhead ST" := ShipCostAllocation."Warehouse Overheads" / ShipCostAllocation."Net Weight (Kg)"
                //             else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShipCostAllocation."Picking Factor" <> 0) then
                //                 "IT Cost-Whse. Overhead ST" := ShipCostAllocation."Warehouse Overheads" / ShipCostAllocation."Picking Factor";

                //         if ShipCostAllocation."Avg. Cost-Internal Transfer ST" <> 0 then
                //             "IT Cost-Internal Transfer ST" := ShipCostAllocation."Avg. Cost-Internal Transfer ST"
                //         else if ShipCostAllocation."Net Weight (Kg)" <> 0 then
                //             "IT Cost-Internal Transfer ST" := ShipCostAllocation."Primary Allocated Amount" / ShipCostAllocation."Net Weight (Kg)";

                //         //HEI.26>>
                //         if ShipCostAllocation."OVE Avg. Cost-Whse. Handl. ST" <> 0 then
                //             "OVE IT Cost-Whse. Handling ST" := ShipCostAllocation."OVE Avg. Cost-Whse. Handl. ST"
                //         else
                //             if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and (ShipCostAllocation."Net Weight (Kg)" <> 0) then
                //                 "OVE IT Cost-Whse. Handling ST" := ShipCostAllocation."OVE Warehouse Handling" / ShipCostAllocation."Net Weight (Kg)"
                //             else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShipCostAllocation."Picking Factor" <> 0) then
                //                 "OVE IT Cost-Whse. Handling ST" := ShipCostAllocation."OVE Warehouse Handling" / ShipCostAllocation."Picking Factor";

                //         if ShipCostAllocation."TRP Avg. Cost-Whse. Handl. ST" <> 0 then
                //             "TRP IT Cost-Whse. Handling ST" := ShipCostAllocation."OVE Avg. Cost-Whse. Handl. ST"
                //         else
                //             if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and (ShipCostAllocation."Net Weight (Kg)" <> 0) then
                //                 "TRP IT Cost-Whse. Handling ST" := ShipCostAllocation."OVE Warehouse Handling" / ShipCostAllocation."Net Weight (Kg)"
                //             else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShipCostAllocation."Picking Factor" <> 0) then
                //                 "TRP IT Cost-Whse. Handling ST" := ShipCostAllocation."OVE Warehouse Handling" / ShipCostAllocation."Picking Factor";

                //         if ShipCostAllocation."OVE Avg. Cost-Whse. Handl. ST" <> 0 then
                //             "TRP IT Cost-Whse. Handling ST" := ShipCostAllocation."TRP Avg. Cost-Whse. Handl. ST"
                //         else
                //             if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and (ShipCostAllocation."Net Weight (Kg)" <> 0) then
                //                 "TRP IT Cost-Whse. Handling ST" := ShipCostAllocation."TRP Warehouse Handling" / ShipCostAllocation."Net Weight (Kg)"
                //             else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShipCostAllocation."Picking Factor" <> 0) then
                //                 "TRP IT Cost-Whse. Handling ST" := ShipCostAllocation."TRP Warehouse Handling" / ShipCostAllocation."Picking Factor";
                //         //HEI.26<<

                //         //add last cost
                //         ShipCostAllocation2.Reset();
                //         ShipCostAllocation2.SetRange("Posting Date", StartingDate, EndingDate);
                //         ShipCostAllocation2.SetRange("Source Document", ShipCostAllocation."Source Document"::"Outbound Transfer");
                //         ShipCostAllocation2.SetRange("Item No.", ShipCostAllocation."Item No.");
                //         ShipCostAllocation2.SetFilter("Entry No.", '<%1', ShipCostAllocation."Entry No.");
                //         ShipCostAllocation2.SetRange("Lot No. & Destination No.", ShipCostAllocation."Lot No. & Location Code");
                //         ShipCostAllocation2.SetRange("Distribution Type", "Distribution Type"); //HEI.02
                //         ShipCostAllocation2.SetRange("Item Category Code", InventorySetup."Finished Goods Item Cat Code"); //HEI.22
                //         if ShipCostAllocation2.FindLast() then begin
                //             if ShipCostAllocation2."Avg. Cost-Whse. Handling ST" <> 0 then
                //                 "IT Cost-Whse. Handling ST" += ShipCostAllocation2."Avg. Cost-Whse. Handling ST"
                //             else
                //                 if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and (ShipCostAllocation2."Net Weight (Kg)" <> 0) then
                //                     "IT Cost-Whse. Handling ST" += ShipCostAllocation2."Warehouse Handling" / ShipCostAllocation2."Net Weight (Kg)"
                //                 else if (WhseHandlType = WhseHandlType::"Picking Factor") and (ShipCostAllocation2."Picking Factor" <> 0) then
                //                     "IT Cost-Whse. Handling ST" += ShipCostAllocation2."Warehouse Handling" / ShipCostAllocation2."Picking Factor";

                //             if ShipCostAllocation2."Avg. Cost-General Overheads ST" <> 0 then
                //                 "IT Cost-General Overheads ST" += ShipCostAllocation2."Avg. Cost-General Overheads ST"
                //             else
                //                 if (GenOverheadsType = GenOverheadsType::"Net Weight (Kg)") and (ShipCostAllocation2."Net Weight (Kg)" <> 0) then
                //                     "IT Cost-General Overheads ST" += ShipCostAllocation2."General Overheads" / ShipCostAllocation2."Net Weight (Kg)"
                //                 else if (GenOverheadsType = GenOverheadsType::"Picking Factor") and (ShipCostAllocation2."Picking Factor" <> 0) then
                //                     "IT Cost-General Overheads ST" += ShipCostAllocation2."General Overheads" / ShipCostAllocation2."Picking Factor";

                //             if ShipCostAllocation2."Avg. Cost-Whse. Overhead ST" <> 0 then
                //                 "IT Cost-Whse. Overhead ST" += ShipCostAllocation2."Avg. Cost-Whse. Overhead ST"
                //             else
                //                 if (WhseOverheadType = WhseOverheadType::"Net Weight (Kg)") and (ShipCostAllocation2."Net Weight (Kg)" <> 0) then
                //                     "IT Cost-Whse. Overhead ST" += ShipCostAllocation2."Warehouse Overheads" / ShipCostAllocation2."Net Weight (Kg)"
                //                 else if (WhseOverheadType = WhseOverheadType::"Picking Factor") and (ShipCostAllocation2."Picking Factor" <> 0) then
                //                     "IT Cost-Whse. Overhead ST" += ShipCostAllocation2."Warehouse Overheads" / ShipCostAllocation2."Picking Factor";

                //             if ShipCostAllocation2."Avg. Cost-Internal Transfer ST" <> 0 then
                //                 "IT Cost-Internal Transfer ST" += ShipCostAllocation2."Avg. Cost-Internal Transfer ST"
                //             else if ShipCostAllocation2."Net Weight (Kg)" <> 0 then
                //                 "IT Cost-Internal Transfer ST" += ShipCostAllocation2."Primary Allocated Amount" / ShipCostAllocation2."Net Weight (Kg)";

                //             //HEI.26>>
                //             if ShipCostAllocation2."OVE Avg. Cost-Whse. Handl. ST" <> 0 then
                //                 "OVE IT Cost-Whse. Handling ST" += ShipCostAllocation2."OVE Avg. Cost-Whse. Handl. ST"
                //             else if ShipCostAllocation2."Net Weight (Kg)" <> 0 then
                //                 "OVE IT Cost-Whse. Handling ST" += ShipCostAllocation2."Primary Allocated Amount" / ShipCostAllocation2."Net Weight (Kg)";

                //             if ShipCostAllocation2."OVE Avg. Cost-Whse. Handl. ST" <> 0 then
                //                 "TRP IT Cost-Whse. Handling ST" += ShipCostAllocation2."TRP Avg. Cost-Whse. Handl. ST"
                //             else if ShipCostAllocation2."Net Weight (Kg)" <> 0 then
                //                 "TRP IT Cost-Whse. Handling ST" += ShipCostAllocation2."Primary Allocated Amount" / ShipCostAllocation2."Net Weight (Kg)";

                //             if ShipCostAllocation2."OVE Avg. Cost-Whse. Handl. ST" <> 0 then
                //                 "FIX IT Cost-Whse. Handling ST" += ShipCostAllocation2."FIX Avg. Cost-Whse. Handl. ST"
                //             else if ShipCostAllocation2."Net Weight (Kg)" <> 0 then
                //                 "FIX IT Cost-Whse. Handling ST" += ShipCostAllocation2."Primary Allocated Amount" / ShipCostAllocation2."Net Weight (Kg)";
                //             //HEI.26<<

                //         end;

                //     end;
                // end; //HEI.21

                // //Cost General Overhead KPI
                // if ("Avg. Cost-General Overheads ST" <> 0) then
                //     "Unit Cost-General Overheads ST" := "Avg. Cost-General Overheads ST" + "IT Cost-General Overheads ST"
                // else begin
                //     if (GenOverheadsType = GenOverheadsType::"Net Weight (Kg)") and ("Net Weight (Kg)" <> 0) then
                //         "Unit Cost-General Overheads ST" := "General Overheads" / "Net Weight (Kg)" + "IT Cost-General Overheads ST"
                //     else if (GenOverheadsType = GenOverheadsType::"Picking Factor") and ("Picking Factor" <> 0) then
                //         "Unit Cost-General Overheads ST" := "General Overheads" / "Picking Factor" + "IT Cost-General Overheads ST";
                // end;

                // //Cost Warehouse Overhead KPI
                // if ("Avg. Cost-Whse. Overhead ST" <> 0) then
                //     "Unit Cost-Whse. Overhead ST" := "Avg. Cost-Whse. Overhead ST" + "IT Cost-Whse. Overhead ST"
                // else begin
                //     if (WhseOverheadType = WhseOverheadType::"Net Weight (Kg)") and ("Net Weight (Kg)" <> 0) then
                //         "Unit Cost-Whse. Overhead ST" := "Warehouse Overheads" / "Net Weight (Kg)" + "IT Cost-Whse. Overhead ST"
                //     else if (WhseOverheadType = WhseOverheadType::"Picking Factor") and ("Picking Factor" <> 0) then
                //         "Unit Cost-Whse. Overhead ST" := "Warehouse Overheads" / "Picking Factor" + "IT Cost-Whse. Overhead ST"
                // end;

                // //Cost Warehouse Handling KPI
                // if "Avg. Cost-Whse. Handling ST" <> 0 then
                //     "Unit Cost-Whse. Handling ST" := "Avg. Cost-Whse. Handling ST" + "IT Cost-Whse. Handling ST"
                // else begin
                //     if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and ("Net Weight (Kg)" <> 0) then
                //         "Unit Cost-Whse. Handling ST" := "Warehouse Handling" / "Net Weight (Kg)" + "IT Cost-Whse. Handling ST"
                //     else if (WhseHandlType = WhseHandlType::"Picking Factor") and ("Picking Factor" <> 0) then
                //         "Unit Cost-Whse. Handling ST" := "Warehouse Handling" / "Picking Factor" + "IT Cost-Whse. Handling ST"
                // end;

                // //HEI.26>>
                // if "OVE Avg. Cost-Whse. Handl. ST" <> 0 then
                //     "OVE Unit Cost-Whse. Handl. ST" := "OVE Avg. Cost-Whse. Handl. ST" + "OVE IT Cost-Whse. Handling ST"
                // else begin
                //     if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and ("Net Weight (Kg)" <> 0) then
                //         "OVE Unit Cost-Whse. Handl. ST" := "OVE Warehouse Handling" / "Net Weight (Kg)" + "OVE IT Cost-Whse. Handling ST"
                //     else if (WhseHandlType = WhseHandlType::"Picking Factor") and ("Picking Factor" <> 0) then
                //         "OVE Unit Cost-Whse. Handl. ST" := "OVE Warehouse Handling" / "Picking Factor" + "OVE IT Cost-Whse. Handling ST"
                // end;

                // if "TRP Avg. Cost-Whse. Handl. ST" <> 0 then
                //     "TRP Unit Cost-Whse. Handl. ST" := "TRP Avg. Cost-Whse. Handl. ST" + "TRP IT Cost-Whse. Handling ST"
                // else begin
                //     if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and ("Net Weight (Kg)" <> 0) then
                //         "TRP Unit Cost-Whse. Handl. ST" := "TRP Warehouse Handling" / "Net Weight (Kg)" + "TRP IT Cost-Whse. Handling ST"
                //     else if (WhseHandlType = WhseHandlType::"Picking Factor") and ("Picking Factor" <> 0) then
                //         "TRP Unit Cost-Whse. Handl. ST" := "TRP Warehouse Handling" / "Picking Factor" + "TRP IT Cost-Whse. Handling ST"
                // end;

                // if "FIX Avg. Cost-Whse. Handl. ST" <> 0 then
                //     "FIX Unit Cost-Whse. Handl. ST" := "FIX Avg. Cost-Whse. Handl. ST" + "FIX IT Cost-Whse. Handling ST"
                // else begin
                //     if (WhseHandlType = WhseHandlType::"Net Weight (Kg)") and ("Net Weight (Kg)" <> 0) then
                //         "FIX Unit Cost-Whse. Handl. ST" := "FIX Warehouse Handling" / "Net Weight (Kg)" + "FIX IT Cost-Whse. Handling ST"
                //     else if (WhseHandlType = WhseHandlType::"Picking Factor") and ("Picking Factor" <> 0) then
                //         "FIX Unit Cost-Whse. Handl. ST" := "FIX Warehouse Handling" / "Picking Factor" + "FIX IT Cost-Whse. Handling ST"
                // end;
                // //HEI.26<<

                // //Internal Transfers
                // if "Avg. Cost-Internal Transfer ST" <> 0 then
                //     "Unit Cost-Internal Transfer ST" := "Avg. Cost-Internal Transfer ST" + "IT Cost-Internal Transfer ST"
                // else if "Net Weight (Kg)" <> 0 then
                //     "Unit Cost-Internal Transfer ST" := "Primary Allocated Amount" / "Net Weight (Kg)" + "IT Cost-Internal Transfer ST";

                // "IT Cost Is Calc" := true; //HEI.22
                // MODIFY();
                // //HEI.28<<
                // BC Upgrade POENAB02, 17.04.2026 <<
            end;

            trigger OnPreDataItem();
            begin
                SetRange("Posting Date", StartingDate, EndingDate);

                //HEI.22>>
                //SETFILTER("Item Category Code",'%1|%2',InventorySetup."Finished Goods Item Cat Code",SalesReceivablesSetup."RPM Related Item Category Code"); //HEI.19
                SetFilter("Item Category Code", ItemCategFilter);
                //HEI.22<<

                if GuiAllowed then begin //HEI.10>>
                    NoOfRecords := COUNT;
                    NoOfRecProgress := NoOfRecords div 100;
                    Counter := 0;
                    NoOfProgresed := 0;
                    TimeProgress := Time;
                end;//HEI.10<<
                //insert the values in temp afteer the allocation has already been done(AllocateWhseCosts)
                InsertTempIT();

                /*
                //HEI.11>>
                CLEAR(gRec_InsertTotals);
                gRec_InsertTotals.RESET;
                gRec_InsertTotals.COPYFILTERS(RPMAllocation);
                gRec_InsertTotals.SETRANGE("Own Fleet",TRUE);
                gRec_InsertTotals.MODIFYALL("Period Net Weight (Kg)",PeriodNetWeightOwnFleet,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Distance",PeriodDistance,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Drop Counts",PeriodDrops,FALSE);
                
                CLEAR(gRec_InsertTotals);
                gRec_InsertTotals.RESET;
                gRec_InsertTotals.COPYFILTERS(RPMAllocation);
                gRec_InsertTotals.SETRANGE("Own Fleet",FALSE);
                gRec_InsertTotals.MODIFYALL("Period Net Weight (Kg)",PeriodNetWeight,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Picking Factor" ,PeriodPickingFactor,FALSE);
                //HEI.11<<
                */

            end;
        }
        dataitem(SKU_RPM; "Shipping Cost Allocation FND")
        {
            DataItemTableView = SORTING("Posting Date", "Destination Type", "Only RPM Transportation", "Source Document", "Item Category Code") ORDER(Ascending) WHERE("Source Document" = FILTER("Sales Order" | "Sales Return Order" | "Sales Invoice" | "Sales Credit Memo"));

            trigger OnAfterGetRecord();
            begin
                //HEI.07<< New DataItem created in order to insert the SKU RPM relationship entries
                if GuiAllowed then begin //HEI.10>>
                    Counter += 1;
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        ProgressWindow.Update(6, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := Time;
                    end;
                end; //HEI.10<<


                BOMComponent.Reset();
                BOMComponent.SetCurrentKey("No.");
                BOMComponent.SetRange("No.", "Item No.");
                if BOMComponent.FindSet(false) then
                    repeat
                        InsertRelationshipRPMSKU(SKU_RPM, BOMComponent."Parent Item No.")
                    until BOMComponent.Next() = 0;

                InsertRelationshipRPMSKU(SKU_RPM, "Item No.");
                //HEI.07<< New DataItem created in order to insert the SKU RPM relationship entries

                //HEI.25>>
                if (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", "Item Category Code") <> 0) then
                    Insert2RPMSKUMissingRecNew();
                //HEI.25<<
            end;

            trigger OnPostDataItem();
            begin
                //HEI.24>>
                /*
                //HEI.18>>
                Insert2RPMSKUMissingRec();
                //HEI.18<<
                */
                //Insert2RPMSKUMissingRecNew(); //HEI.25
                //HEI.24<<


                //HEI.22>>
                /*
                //HEI.14>>
                UpdateRPMOverallocation();
                //HEI.14<<
                */
                //UpdateRPMSKUFields(); //HEI.27 - deprecated the split in primary and secondary
                UpdateRPMOverallocationNew();
                //HEI.22<<

            end;

            trigger OnPreDataItem();
            begin
                //HEI.07<< New DataItem created in order to insert the SKU RPM relationship entries
                SetRange("Posting Date", StartingDate, EndingDate);

                //HEI.24>>
                //SETFILTER("Item Category Code",SalesReceivablesSetup."RPM Related Item Category Code");
                SetFilter("Item Category Code", ItemCategFilter);
                //HEI.24<<

                if GuiAllowed then begin //HEI.10>>
                    NoOfRecords := Count;
                    NoOfRecProgress := NoOfRecords div 100;
                    Counter := 0;
                    NoOfProgresed := 0;
                    TimeProgress := Time;
                end; //HEI.10<<
                //HEI.07<< New DataItem created in order to insert the SKU RPM relationship entries
            end;
        }
        dataitem(DeliveryToCustomers; "Shipping Cost Allocation FND")
        {
            DataItemTableView = SORTING("Posting Date", "Destination Type", "Only RPM Transportation", "Source Document", "Item Category Code") ORDER(Ascending) WHERE("Destination Type" = FILTER(Customer), "Only RPM Transportation" = CONST(false));

            trigger OnAfterGetRecord();
            var
                Qr_SCACalcFlowFields: Query "C2S SCA CalcFlowFields";
            begin
                if GuiAllowed then begin //HEI.10>>
                    Counter += 1;
                    if Counter >= NoOfRecProgress then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        ProgressWindow.Update(5, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := Time;
                    end;
                end; //HEI.10<<

                //HEI.15>> commented all the code and add the new optimization
                //HEI.11>>
                /*
                //InsertTotals(DeliveryToCustomers); //HEI.04
                
                CALCFIELDS("ST Gen. Overh. per SKU/Lot");
                CALCFIELDS("ST Period Net Weight SKU/Lot");
                CALCFIELDS("ST Period Pick. Factor SKU/Lot");
                CALCFIELDS("ST Transfers per SKU/Lot");
                CALCFIELDS("ST Whse. Hand. per SKU/Lot");
                CALCFIELDS("ST Whse. Overh. per SKU/Lot");
                CALCFIELDS("Unit Cost-General Overheads SO");
                CALCFIELDS("Unit Cost-Internal Transfer SO");
                CALCFIELDS("Unit Cost-Whse. Handling SO");
                CALCFIELDS("Unit Cost-Whse. Overhead SO");
                */
                //HEI.11<<


                //HEI.14>>
                /*
                //HEI.12
                {
                IF ("Period Net Weight SKU/Lot" <= "ST Period Net Weight SKU/Lot") AND ("ST Period Net Weight SKU/Lot" <> 0) THEN BEGIN
                  "Internal Transfer ST" := "Net Weight (Kg)" * "ST Transfers per SKU/Lot" / "ST Period Net Weight SKU/Lot";
                  "General Overheads ST" := "Net Weight (Kg)" * "ST Gen. Overh. per SKU/Lot" / "ST Period Net Weight SKU/Lot";
                  "Warehouse Overheads ST" := "Net Weight (Kg)" * "ST Whse. Overh. per SKU/Lot" / "ST Period Net Weight SKU/Lot";
                END ELSE BEGIN
                  "Internal Transfer ST" := "Net Weight (Kg)" * "Unit Cost-Internal Transfer SO";
                  "General Overheads ST" := "Net Weight (Kg)" * "Unit Cost-General Overheads SO";
                  "Warehouse Overheads ST" := "Net Weight (Kg)" * "Unit Cost-Whse. Overhead SO";
                END;
                
                IF ("Period Picking Factor SKU/Lot" <= "ST Period Pick. Factor SKU/Lot") AND ("ST Period Pick. Factor SKU/Lot" <> 0) THEN
                  "Warehouse Handling ST" := "Picking Factor" * "ST Whse. Hand. per SKU/Lot" / "ST Period Pick. Factor SKU/Lot"
                ELSE
                  "Warehouse Handling ST" := "Picking Factor" * "Unit Cost-Whse. Handling SO";
                }
                
                //HEI.14>> roll back HEI.12
                
                IF gRec_CalCFileds_Temp.GET(DeliveryToCustomers."Entry No.") THEN BEGIN
                
                  IF ("Period Net Weight SKU/Lot" <= gRec_CalCFileds_Temp."T_ST Period Net Weight SKU/Lot") AND
                     (gRec_CalCFileds_Temp."T_ST Period Net Weight SKU/Lot" <> 0) THEN BEGIN
                    "Internal Transfer ST" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_ST Transfers per SKU/Lot" / gRec_CalCFileds_Temp."T_ST Period Net Weight SKU/Lot";
                    "General Overheads ST" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_ST Gen. Overh. per SKU/Lot" / gRec_CalCFileds_Temp."T_ST Period Net Weight SKU/Lot";
                    "Warehouse Overheads ST" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_ST Whse. Overh. per SKU/Lot" / gRec_CalCFileds_Temp."T_ST Period Net Weight SKU/Lot";
                  END ELSE BEGIN
                    "Internal Transfer ST" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_Unit Cst Intl Transfer SO";
                    "General Overheads ST" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_Unit Cst Genl Overheads SO";
                    "Warehouse Overheads ST" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_Unit Cost-Whse. Overhead SO";
                  END;
                
                  IF ("Period Picking Factor SKU/Lot" <= gRec_CalCFileds_Temp."T_ST Period Pick Factr SKU/Lot") AND
                     (gRec_CalCFileds_Temp."T_ST Period Pick Factr SKU/Lot" <> 0) THEN
                    "Warehouse Handling ST" := "Picking Factor" * gRec_CalCFileds_Temp."T_ST Whse. Hand. per SKU/Lot" / gRec_CalCFileds_Temp."T_ST Period Pick Factr SKU/Lot"
                  ELSE
                    "Warehouse Handling ST" := "Picking Factor" * gRec_CalCFileds_Temp."Unit Cost-Whse. Handling SO";
                  //HEI.12
                
                  //HEI.14 not all records from this DataItem are inserted in temp table. Code was moved outside GET
                  {
                  //HEI.04>>
                  IF "Own Fleet" THEN
                    "Primary Allocated Amount" := "Weight Allocation Own Fleet" + "No. of Drops All. Own Fleet" + "Distance Allocation Own Fleet";
                  //HEI.04>>
                  }
                  //HEI.14<<
                
                  //HEI.07>>
                  //Allocate RPM costs for customers
                  //HEI.11>>
                  {
                  CALCFIELDS("Period RPM Unit Cost Customer","Period RPM Unit Cost Transfer","Period RPM Gen. Overh. Cust.","Period RPM Gen. Overh. IT",
                              "Period RPM Whse. Handl. Cust.","Period RPM Whse. Handl. IT","Period RPM Whse. Overh. Cust.","Period RPM Whse. Overh. IT");
                  }
                
                  //HEI.12>>
                  {
                  //HEI.11<<
                  "RPM SO" := "Net Weight (Kg)" * "Period RPM Unit Cost Customer";
                  "RPM ST" := "Net Weight (Kg)" * "Period RPM Unit Cost Transfer";
                  "Gen. Overheads RPM SO" := "Net Weight (Kg)" * "Period RPM Gen. Overh. Cust.";
                  "Gen. Overheads RPM ST" := "Net Weight (Kg)" * "Period RPM Gen. Overh. IT";
                  "Whse. Overheads RPM SO" := "Net Weight (Kg)" * "Period RPM Whse. Overh. Cust.";
                  "Whse. Overheads RPM ST" := "Net Weight (Kg)" * "Period RPM Whse. Overh. IT";
                  "Whse. Handling RPM SO" := "Picking Factor" * "Period RPM Whse. Handl. Cust.";
                  "Whse. Handling RPM ST" := "Picking Factor" * "Period RPM Whse. Handl. IT";
                  //HEI.07<<
                
                  //HEI.11<<
                  }
                
                  "RPM SO" := "Net Weight (Kg)" * "Period RPM Unit Cost Customer";
                  "RPM ST" := "Net Weight (Kg)" * "Period RPM Unit Cost Transfer";
                  //HEI.12>>
                  "Gen. Overheads RPM SO" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_Prd RPM Gen. Overh. Cust.";
                  "Gen. Overheads RPM ST" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_Prd RPM Gen. Overh. IT";
                  "Whse. Overheads RPM SO" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_Prd RPM Whse. Overh. Cust.";
                  "Whse. Overheads RPM ST" := "Net Weight (Kg)" * gRec_CalCFileds_Temp."T_Prd RPM Whse. Overh. IT";
                  "Whse. Handling RPM SO" := "Picking Factor" * gRec_CalCFileds_Temp."T_Prd RPM Whse. Handl. Cust.";
                  "Whse. Handling RPM ST" := "Picking Factor" * gRec_CalCFileds_Temp."T_Prd RPM Whse. Handl. IT";
                  //HEI.12<<
                
                  //HEI.14
                  //MODIFY;
                  //HEI.14
                END;
                
                {
                "RPM SO" := "Net Weight (Kg)" * "Period RPM Unit Cost Customer";
                "RPM ST" := "Net Weight (Kg)" * "Period RPM Unit Cost Transfer";
                "Gen. Overheads RPM SO" := "Net Weight (Kg)" * "Period RPM Gen. Overh. Cust.";
                "Gen. Overheads RPM ST" := "Net Weight (Kg)" * "Period RPM Gen. Overh. IT";
                "Whse. Overheads RPM SO" := "Net Weight (Kg)" * "Period RPM Whse. Overh. Cust.";
                "Whse. Overheads RPM ST" := "Net Weight (Kg)" * "Period RPM Whse. Overh. IT";
                "Whse. Handling RPM SO" := "Picking Factor" * "Period RPM Whse. Handl. Cust.";
                "Whse. Handling RPM ST" := "Picking Factor" * "Period RPM Whse. Handl. IT";
                }
                IF "Own Fleet" THEN
                  "Primary Allocated Amount" := "Weight Allocation Own Fleet" + "No. of Drops All. Own Fleet" + "Distance Allocation Own Fleet";
                
                MODIFY;
                */


                /*
                CLEAR(Qr_SCACalcFlowFields);
                Qr_SCACalcFlowFields.SETRANGE(FilterEntryNo,"Entry No.");
                Qr_SCACalcFlowFields.OPEN;
                WHILE Qr_SCACalcFlowFields.READ DO BEGIN
                  //HEI.22>>
                  //IF ("Period Net Weight SKU/Lot" <= Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot)
                  IF ("Period Net Weight SKU/Lot" < Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot)
                  //HEI.22<<
                    AND (Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot <> 0)
                  THEN BEGIN
                    "Internal Transfer ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.ST_Transfers_per_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot;
                    "General Overheads ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.ST_Gen_Overh_per_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot;
                    "Warehouse Overheads ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.ST_Whse_Overh_per_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot;
                  END ELSE BEGIN
                    //HEI.22>>
                    {
                    "Internal Transfer ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.Unit_Cost_Internal_Transfer_SO;
                    "General Overheads ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.Unit_Cost_General_Overheads_SO;
                    "Warehouse Overheads ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.Unit_Cost_Whse_Overhead_SO;
                    }
                    IF ("Period Net Weight SKU/Lot" <> 0) THEN BEGIN
                      "Internal Transfer ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.ST_Transfers_per_SKU_Lot / "Period Net Weight SKU/Lot" ;
                      "General Overheads ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.ST_Gen_Overh_per_SKU_Lot / "Period Net Weight SKU/Lot";
                      "Warehouse Overheads ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.ST_Whse_Overh_per_SKU_Lot / "Period Net Weight SKU/Lot";
                    END;
                    //HEI.22<<
                  END;
                
                  IF ("Period Picking Factor SKU/Lot" < Qr_SCACalcFlowFields.ST_Period_Pick_Factor_SKU_Lot)
                    AND (Qr_SCACalcFlowFields.ST_Period_Pick_Factor_SKU_Lot <> 0)
                  THEN
                    "Warehouse Handling ST" := "Picking Factor" * Qr_SCACalcFlowFields.ST_Whse_Hand_per_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Pick_Factor_SKU_Lot
                  ELSE BEGIN
                    IF ("Period Picking Factor SKU/Lot" <> 0) THEN
                      "Warehouse Handling ST" := "Picking Factor" * Qr_SCACalcFlowFields.ST_Whse_Hand_per_SKU_Lot / "Period Picking Factor SKU/Lot";
                  END;
                
                  "RPM SO" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.Period_RPM_Unit_Cost_Customer;
                  "RPM ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.Period_RPM_Unit_Cost_Transfer;
                  "Gen. Overheads RPM SO" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.Period_RPM_Gen_Overh_Cust;
                  "Gen. Overheads RPM ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.Period_RPM_Gen_Overh_IT;
                  "Whse. Overheads RPM SO" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.Period_RPM_Whse_Overh_Cust;
                  "Whse. Overheads RPM ST" := "Net Weight (Kg)" * Qr_SCACalcFlowFields.Period_RPM_Whse_Overh_IT;
                  "Whse. Handling RPM SO" := "Picking Factor" * Qr_SCACalcFlowFields.Period_RPM_Whse_Handl_Cust;
                  "Whse. Handling RPM ST" := "Picking Factor" * Qr_SCACalcFlowFields.Period_RPM_Whse_Handl_IT;
                
                END;
                Qr_SCACalcFlowFields.CLOSE;
                */

                if gRec_CalcDeliveryCustFieldsTmp.Get("Entry No.") then begin
                    "Internal Transfer ST" := gRec_CalcDeliveryCustFieldsTmp."Internal Transfer ST";
                    "General Overheads ST" := gRec_CalcDeliveryCustFieldsTmp."General Overheads ST";
                    "Warehouse Overheads ST" := gRec_CalcDeliveryCustFieldsTmp."Warehouse Overheads ST";
                    "Warehouse Handling ST" := gRec_CalcDeliveryCustFieldsTmp."Warehouse Handling ST";

                    "RPM SO" := gRec_CalcDeliveryCustFieldsTmp."RPM SO";
                    "RPM ST" := gRec_CalcDeliveryCustFieldsTmp."RPM ST";
                    "Gen. Overheads RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Gen. Overheads RPM SO";
                    "Gen. Overheads RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Gen. Overheads RPM ST";
                    "Whse. Overheads RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Whse. Overheads RPM SO";
                    "Whse. Overheads RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Whse. Overheads RPM ST";
                    "Whse. Handling RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Whse. Handling RPM SO";
                    "Whse. Handling RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Whse. Handling RPM ST";

                    //HEI.26>>
                    "OVE Whse. Hand. ST" := gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Hand. ST";
                    "TRP Whse. Hand. ST" := gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Hand. ST";
                    "FIX Whse. Hand. ST" := gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Hand. ST";

                    "OVE Whse. Handling RPM SO" := gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Handling RPM SO";
                    "TRP Whse. Handling RPM SO" := gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Handling RPM SO";
                    "FIX Whse. Handling RPM SO" := gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Handling RPM SO";
                    "OVE Whse. Handling RPM ST" := gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Handling RPM ST";
                    "TRP Whse. Handling RPM ST" := gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Handling RPM ST";
                    "FIX Whse. Handling RPM ST" := gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Handling RPM ST";
                    //HEI.26<<

                    //HEI.29>>
                    /*
                    //HEI.28>>
                    "ST Per. Net Wgt SKU/Lot Own Fl" := gRec_CalcDeliveryCustFieldsTmp."ST Per. Net Wgt SKU/Lot Own Fl";
                    "ST Per. Net Wgt. SKU/Lot 3rd P" := gRec_CalcDeliveryCustFieldsTmp."ST Per. Net Wgt. SKU/Lot 3rd P";
                    "Internal Transfer ST 3rd P" := gRec_CalcDeliveryCustFieldsTmp."Internal Transfer ST 3rd P";
                    "Internal Transfer ST Own Fleet" := gRec_CalcDeliveryCustFieldsTmp."Internal Transfer ST Own Fleet";
                    "RPM SO 3rd Party" := gRec_CalcDeliveryCustFieldsTmp."RPM SO 3rd Party";
                    "RPM SO Own Fleet" := gRec_CalcDeliveryCustFieldsTmp."RPM SO Own Fleet";
                    "RPM ST 3rd Party" := gRec_CalcDeliveryCustFieldsTmp."RPM ST 3rd Party";
                    "RPM ST Own Fleet" := gRec_CalcDeliveryCustFieldsTmp."RPM ST Own Fleet";
                    //HEI.28<<
                    */
                    //HEI.29<<
                end;

                //HEI.23>> moved on DataItem <Shipping Cost Allocation>
                /*
                IF "Own Fleet" THEN
                  "Primary Allocated Amount" := "Weight Allocation Own Fleet" + "No. of Drops All. Own Fleet" + "Distance Allocation Own Fleet";
                */
                //HEI.23<<

                Modify();
                //HEI.15<<

            end;

            trigger OnPostDataItem();
            begin
                //HEI.26>>
                /*
                //HEI.11>>
                DeliveryToCustomers.SETAUTOCALCFIELDS()
                //HEI.11<<
                */
                //HEI.26<<

            end;

            trigger OnPreDataItem();
            begin
                SetRange("Posting Date", StartingDate, EndingDate);
                SetFilter("Item Category Code", InventorySetup."Finished Goods ItemCatCode FND");

                if GuiAllowed then begin //HEI.10>>
                    NoOfRecords := Count;
                    NoOfRecProgress := NoOfRecords div 100;
                    Counter := 0;
                    NoOfProgresed := 0;
                    TimeProgress := Time;
                end; //HEI.10<<


                //HEI.15>>
                /*
                //HEI.12>>
                PopulateCalCFields(StartingDate,EndingDate);
                */
                //HEI.15<<

                //DeliveryToCustomers.SETAUTOCALCFIELDS
                //  ("Period RPM Unit Cost Customer","Period RPM Unit Cost Transfer");
                //HEI.12<<

                //HEI.15>> coming back to HEI.11
                //HEI.14>> roll back the comment
                //HEI.11>>
                /*
                DeliveryToCustomers.SETAUTOCALCFIELDS
                  ("ST Gen. Overh. per SKU/Lot","ST Period Net Weight SKU/Lot","ST Period Pick. Factor SKU/Lot",
                   "ST Transfers per SKU/Lot","ST Whse. Hand. per SKU/Lot","ST Whse. Overh. per SKU/Lot",
                   "Unit Cost-General Overheads SO","Unit Cost-Internal Transfer SO","Unit Cost-Whse. Handling SO",
                   "Unit Cost-Whse. Overhead SO","Period RPM Unit Cost Customer","Period RPM Unit Cost Transfer",
                   "Period RPM Gen. Overh. Cust.","Period RPM Gen. Overh. IT","Period RPM Whse. Handl. Cust.",
                   "Period RPM Whse. Handl. IT","Period RPM Whse. Overh. Cust.","Period RPM Whse. Overh. IT");
                */
                //HEI.14<<

                //HEI.14>> it's used function InsertTotalsShippAlloc
                /*
                CLEAR(gRec_InsertTotals);
                gRec_InsertTotals.RESET;
                gRec_InsertTotals.COPYFILTERS(RPMAllocation);
                gRec_InsertTotals.SETRANGE("Own Fleet",TRUE);
                gRec_InsertTotals.MODIFYALL("Period Net Weight (Kg)",PeriodNetWeightOwnFleet,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Distance",PeriodDistance,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Drop Counts",PeriodDrops,FALSE);
                
                CLEAR(gRec_InsertTotals);
                gRec_InsertTotals.RESET;
                gRec_InsertTotals.COPYFILTERS(RPMAllocation);
                gRec_InsertTotals.SETRANGE("Own Fleet",FALSE);
                gRec_InsertTotals.MODIFYALL("Period Net Weight (Kg)",PeriodNetWeight,FALSE);
                gRec_InsertTotals.MODIFYALL("Period Picking Factor" ,PeriodPickingFactor,FALSE);
                //HEI.11<<
                */
                //HEI.14<<

                //HEI.26>>
                //SCACalcFlowFields(); //HEI.27
                //HEI.26<<

                SCACalcFlowFieldsNew(); //HEI.27

            end;
        }
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
                        ToolTip = 'Specifies the starting date for allocating shipping costs.';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            if StartingDate <> 0D then
                                EndingDate := CALCDATE('<CM>', StartingDate);
                        end;
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date';
                        Editable = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the ending date for allocating shipping costs.';
                    }
                    field(InsertChild; InsertChild)
                    {
                        Caption = 'Insert Child Lines';
                        Visible = false;
                        ApplicationArea = All;
                        ToolTip = 'Specifies whether to insert child lines when inserting shipping costs.';
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
        if GuiAllowed then //HEI.10>>
            ProgressWindow.CLOSE();

        if Allocated then begin //HEI.05
            if GuiAllowed then //HEI.10>>
                Message(Text005);
            //HEI.05<<
            if RunJobQ then begin
                // RunningCalendar."Job Queue Run" := TRUE; //HEI.08
                RunningCalendar."C2S Job Queue Run" := true; //HEI.08
                RunningCalendar.Modify();
            end;
        end;
        //HEI.05>>

        //HEI.11>>
        Clear(gRec_C2SDocumentTotalLine);
        Clear(gRec_CalculateTotalWhseCosts);
        //HEI.11<<
    end;

    trigger OnPreReport();
    begin
        InventorySetup.Get();
        SalesReceivablesSetup.Get();
        GLSetup.Get();
        WarehouseSetup.Get(); //HEI.06

        CheckDates();

        //insert shipping costs
        //InsertShippingCosts.GetDates(StartingDate,EndingDate); //HEI.04 commented//
        InsertShippingCosts.GetDates(StartingDate, EndingDate, InsertChild); //HEI.04
        InsertShippingCosts.RunModal();


        if GuiAllowed then //HEI.10>>
            ProgressWindow.Open(Text004 + Text008 + Text009 + Text010 + Text012 + Text011);

        //HEI.11>>
        PopulateTempSCATotalLines(StartingDate, EndingDate);
        //HEI.11<<


        //insert temporary tables
        //InsertTempRPM; //HEI.07 commented and replaced by FlowFields on table 50215
        //InsertTempLinkedSKU; //HEI.07 commented commented and replaced by FlowFields on table 50215

        //HEI.14>>
        //InsertTempCustIT;
        InsertTempCustIT2();
        CalcTotalAmtsAndUpdCostAlloc();
        //HEI.14>>

        //HEI.22>>
        ItemCategFilter := InventorySetup."Finished Goods ItemCatCode FND" + '|' + SalesReceivablesSetup."RPMRelatedItemCategoryCode FND";
        InsertNoOfLinesByDocItemCateg();
        //HEI.22<<
    end;

    var
        GLEntry: Record "G/L Entry";
        DimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        SkipGL: Boolean;
        StartingDate: Date;
        EndingDate: Date;
        TempWhseCostSetup: Record "Whse. Cost Alloc Setup FND" temporary;
        PeriodPickingFactor: Decimal;
        PeriodNetWeight: Decimal;
        Text001: Label '%1 must not be blank.';
        Text002: Label 'Starting Date';
        Text003: Label 'Ending Date';
        ProgressWindow: Dialog;
        Text004: TextConst ENU = 'C2S Mapping SCOA & CC       @1@@@@@@@@@@@ \', FRA = 'Traitement des fournisseurs             #1##########';
        Text005: Label 'The shipping costs have been successfully allocated.';
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        Allocated: Boolean;
        BOMComponent: Record "BOM Component";
        RPMBuffer: Record "Brand Dim Hierarchy FND" temporary;
        RPMSKURelation: Record "RPM - SKU Relationship FND";
        GetLastEntry: Record "RPM - SKU Relationship FND";
        ProdBOMLine: Record "Production BOM Line";
        ProdBOMHeader: Record "Production BOM Header";
        ShipCostAllocation: Record "Shipping Cost Allocation FND";
        TempWhseShipCost: Record "Shipping Cost Allocation FND" temporary;
        ShipCostAllocation2: Record "Shipping Cost Allocation FND";
        GenOverheadsType: Option " ","Picking Factor","Net Weight (Kg)";
        WhseHandlType: Option " ","Picking Factor","Net Weight (Kg)";
        WhseOverheadType: Option " ","Picking Factor","Net Weight (Kg)";
        ShippCostAllocSource: Query "Shipping Cost Allocation";
        Text006: Label 'Shipping costs are already allocated for this period! Please select another date.';
        CountCust: Integer;
        CountTransfer: Integer;
        RPMUnitCostCust: Decimal;
        RPMUnitCostTransfer: Decimal;
        ShippCostAllocSource2: Query "Shipping Cost Allocation";
        InsertShippingCosts: Report "Insert Shipping Costs";
        Text008: Label 'Allocate RPM costs         @2@@@@@@@@@@@ \';
        Text009: Label 'Allocate Warehouse costs         @3@@@@@@@@@@@ \';
        TempIT: Record "Shipping Cost Allocation FND" temporary;
        TempCustIT: Record "Shipping Cost Allocation FND" temporary;
        InventorySetup: Record "Inventory Setup";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        PeriodPickingFactorOwnFleet: Decimal;
        PeriodNetWeightOwnFleet: Decimal;
        PeriodDistance: Decimal;
        PeriodDrops: Decimal;
        Text010: Label 'Calculate Internal Transfers       @4@@@@@@@@@@@ \';
        Text011: Label 'Calculate Delivery to Customers     @5@@@@@@@@@@@ \';
        TempShipCostAlloc: Record "Shipping Cost Allocation FND" temporary;
        InsertChild: Boolean;
        RunJobQ: Boolean;
        RunningCalendar: Record "C2S/COGS Running Calendar FND";
        NumberOfLines: Integer;
        WarehouseSetup: Record "Warehouse Setup";
        Text012: Label 'Insert RPM - SKU Relationships         @6@@@@@@@@@@@ \';
        gQr_GLQuery: Query "C2S GL Entry";
        gRec_C2SDocumentTotalLine: Record "Shipping Cost Allocation FND" temporary;
        gRec_CalculateTotalWhseCosts: Record "Shipping Cost Allocation FND" temporary;
        gRec_InsertTotals: Record "Shipping Cost Allocation FND";
        gRec_CalCFileds_Temp: Record "Shipping Cost Allocation FND" temporary;
        Text013: Label 'Insert RPM - SKU Relationships  from Internal transfer   @7@@@@@@@@@@@ \';
        gRec_C2STotalLinesByDocItemCategTmp: Record "Shipping Cost Allocation FND" temporary;
        gRec_CalcDeliveryCustFieldsTmp: Record "Shipping Cost Allocation FND" temporary;
        ItemCategFilter: Text[250];
        RPMSKURelation4OverallocationTmp: Record "RPM - SKU Relationship FND" temporary;
        gRec_C2SNoOfLine: Record "Shipping Cost Allocation FND" temporary;
        RPMSKURelationTmp: Record "RPM - SKU Relationship FND" temporary;
        SCACalcFldForSKURPMCustTmp: Record "Shipping Cost Allocation FND" temporary;
        SCACalcFldForSKURPMITTmp: Record "Shipping Cost Allocation FND" temporary;

    local procedure CheckDates();
    begin
        if StartingDate = 0D then
            Error(Text001, Text002);
        if EndingDate = 0D then
            Error(Text001, Text003);
    end;

    local procedure GetWhseAmount(TempWhseCost: Record "Whse. Cost Alloc Setup FND" temporary; var Rec: Record "Shipping Cost Allocation FND") AllocatedAmount: Decimal;
    begin
        if TempWhseCost."Allocation Type" = TempWhseCost."Allocation Type"::"Net Weight (Kg)" then begin
            //HEI.21>>
            /*
            IF Rec."Period Net Weight (Kg)" <> 0 THEN
              AllocatedAmount := Rec."Net Weight (Kg)" * TempWhseCostSetup."Period Cost" / Rec."Period Net Weight (Kg)";
            */
            if (PeriodNetWeight + PeriodNetWeightOwnFleet) <> 0 then
                AllocatedAmount := Rec."Net Weight (Kg)" * TempWhseCostSetup."Period Cost" / (PeriodNetWeight + PeriodNetWeightOwnFleet);
            //HEI.21<<
        end else if TempWhseCost."Allocation Type" = TempWhseCost."Allocation Type"::"Picking Factor" then
                //HEI.21>>
                /*
                IF Rec."Period Picking Factor" <> 0 THEN
                  AllocatedAmount := Rec."Picking Factor" * TempWhseCostSetup."Period Cost" / Rec."Period Picking Factor";
                */
          if (PeriodPickingFactor + PeriodPickingFactorOwnFleet) <> 0 then
                    AllocatedAmount := Rec."Picking Factor" * TempWhseCostSetup."Period Cost" / (PeriodPickingFactor + PeriodPickingFactorOwnFleet);
        //HEI.21<<

        Allocated := true;
        exit(AllocatedAmount);

    end;

    local procedure AllocatePrimaryWarehouseCosts(var Rec: Record "Shipping Cost Allocation FND");
    begin
        //HEI.02<<
        Clear(TempWhseCostSetup);
        //HEI.10>>
        TempWhseCostSetup.Reset();
        TempWhseCostSetup.SetCurrentKey("Distribution Type");
        //HEI.10<<
        TempWhseCostSetup.SetRange("Distribution Type", TempWhseCostSetup."Distribution Type"::Primary);
        if TempWhseCostSetup.FindSet(false) then
            repeat
                case TempWhseCostSetup."C2S Name" of
                    TempWhseCostSetup."C2S Name"::"General Overhead Costs (Fixed)":
                        begin
                            Rec."General Overheads" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."Period G/L Cost Gen. Overheads" := TempWhseCostSetup."Period Cost";
                        end;

                    TempWhseCostSetup."C2S Name"::"Warehouse Handling Costs (Variable)":
                        begin
                            Rec."Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."Period G/L Cost Whse. Handling" := TempWhseCostSetup."Period Cost";
                        end;

                    TempWhseCostSetup."C2S Name"::"Warehouse Overhead Costs (Fixed)":
                        begin
                            Rec."Warehouse Overheads" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."Period G/L Cost Whse. Overhead" := TempWhseCostSetup."Period Cost";
                        end;

                    TempWhseCostSetup."C2S Name"::"Delivery To Customers":
                        Rec."Period G/L Cost Delivery Cust." := TempWhseCostSetup."Period Cost";

                    //HEI.04<<
                    TempWhseCostSetup."C2S Name"::"Own Fleet":
                        //HEI.20>>
                        begin
                            Rec."Period G/L Cost Own Fleet" := TempWhseCostSetup."Period Cost";
                            //HEI.20<<
                            if Rec."Own Fleet" then begin
                                //Rec."Period G/L Cost Own Fleet" := TempWhseCostSetup."Period Cost"; //HEI.20
                                if PeriodNetWeightOwnFleet <> 0 then
                                    //HEI.24>>
                                    //Rec."Weight Allocation Own Fleet" := ABS((Rec."Net Weight (Kg)" / PeriodNetWeightOwnFleet) * (TempWhseCostSetup."Net Weight Allocation %"/100) * Rec."Period G/L Cost Own Fleet");
                                    Rec."Weight Allocation Own Fleet" := (Rec."Net Weight (Kg)" / PeriodNetWeightOwnFleet) * (TempWhseCostSetup."Net Weight Allocation %" / 100) * Rec."Period G/L Cost Own Fleet";
                                //HEI.24<<
                                if (PeriodDrops <> 0)
                                  and (NumberOfLines <> 0) //HEI.22
                                then
                                    //HEI.24>>
                                    //Rec."No. of Drops All. Own Fleet" := ABS((Rec."No. of Drops" / PeriodDrops) * (TempWhseCostSetup."No. of Drops Allocation %"/100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines);
                                    Rec."No. of Drops All. Own Fleet" := (Rec."No. of Drops" / PeriodDrops) * (TempWhseCostSetup."No. of Drops Allocation %" / 100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines;
                                //HEI.24<<
                                if (PeriodDistance <> 0)
                                  and (NumberOfLines <> 0) //HEI.22
                                then
                                    //HEI.24>>
                                    //Rec."Distance Allocation Own Fleet" := ABS((Rec.Distance / PeriodDistance) * (TempWhseCostSetup."Distance Allocation %"/100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines);
                                    Rec."Distance Allocation Own Fleet" := (Rec.Distance / PeriodDistance) * (TempWhseCostSetup."Distance Allocation %" / 100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines;
                                //HEI.24<<
                            end;
                        end;//HEI.20>>
                            //HEI.04>>

                    //HEI.26>>
                    TempWhseCostSetup."C2S Name"::"Whse Hand. Costs (Variable) OVE":
                        begin
                            Rec."OVE Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."OVE Prd G/L Whse Hand Cost" := TempWhseCostSetup."Period Cost";
                        end;
                    TempWhseCostSetup."C2S Name"::"Whse Hand. Costs (Variable) Transp. Exp.":
                        begin
                            Rec."TRP Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."TRP Prd G/L Whse Hand Cost" := TempWhseCostSetup."Period Cost";
                        end;
                    TempWhseCostSetup."C2S Name"::"Whse Hand. Costs (Variable) Fixed Exp.":
                        begin
                            Rec."FIX Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."FIX Prd G/L Whse Hand Cost" := TempWhseCostSetup."Period Cost";
                        end;
                //HEI.26<<

                end;
            until TempWhseCostSetup.Next() = 0;
        //HEI.02
    end;

    local procedure InsertRelationshipRPMSKU(var Rec: Record "Shipping Cost Allocation FND"; ItemNo: Code[20]);
    var
        BOMComponent: Record "BOM Component";
        ProdBOMLine: Record "Production BOM Line";
        ProdBOMHeader: Record "Production BOM Header";
        ShipCostAllocation2: Record "Shipping Cost Allocation FND";
        ReturnReceiptHeader: Record "Return Receipt Header";
    begin
        ProdBOMLine.Reset();
        ProdBOMLine.SetCurrentKey("No.", "Version Code");
        ProdBOMLine.SetRange("No.", ItemNo);
        ProdBOMLine.SetFilter("Version Code", '<>%1', '');
        if ProdBOMLine.FindSet(false) then
            repeat
                ProdBOMHeader.Reset();
                ProdBOMHeader.Get(ProdBOMLine."Production BOM No.");
                if ProdBOMHeader."Linked Item No. FND" <> '' then begin
                    RPMSKURelation.Reset();
                    //HEI.16>>
                    //IF NOT RPMSKURelation.GET(StartingDate,EndingDate,Rec."Item No.",ProdBOMHeader."Linked Item No.",Rec."Destination No.") THEN BEGIN
                    if not RPMSKURelation.Get(StartingDate, EndingDate, Rec."Item No.", ProdBOMHeader."Linked Item No. FND", Rec."Destination No.", Rec."Own Fleet") then begin
                        //HEI.16<<
                        RPMSKURelation.Init();
                        RPMSKURelation."Period Start Date" := StartingDate;
                        RPMSKURelation."Period End Date" := EndingDate;

                        RPMSKURelation."RPM Item No." := Rec."Item No.";
                        RPMSKURelation."Item Category Code" := Rec."Item Category Code";
                        RPMSKURelation."Linked Item No." := ProdBOMHeader."Linked Item No. FND";
                        RPMSKURelation."Period Date" := Rec."Period Date"; //HEI.07
                        RPMSKURelation."Own Fleet" := Rec."Own Fleet"; //HEI.07

                        ReturnReceiptHeader.Reset();
                        if ReturnReceiptHeader.Get(Rec."Posted Source Document No.") then
                            RPMSKURelation."Customer No." := ReturnReceiptHeader."Sell-to Customer No."
                        //HEI.24>>
                        else
                            RPMSKURelation."Customer No." := Rec."Destination No.";
                        //HEI.24<<

                        //HEI.07 commented and replaced with flowfields on T50215
                        /*
                        //for customers
                        CLEAR(TempCustItemRPM);
                        TempCustItemRPM.SETRANGE("Item No.",RPMSKURelation."RPM Item No.");
                        TempCustItemRPM.SETRANGE("Destination No.",RPMSKURelation."Customer No.");
                       // IF TempCustItemRPM.FINDFIRST THEN //HEI.02 commented
                        //HEI.02>>
                        IF TempCustItemRPM.FINDSET(FALSE,FALSE) THEN REPEAT
                          IF TempCustItemRPM."Distribution Type" = TempCustItemRPM."Distribution Type"::Total THEN
                            RPMSKURelation."Period Alloc. Amount Customer" := TempCustItemRPM."Primary Allocated Amount"
                          ELSE IF TempCustItemRPM."Distribution Type" = TempCustItemRPM."Distribution Type"::Primary THEN
                            RPMSKURelation."Primary Alloc. Amount Customer" := TempCustItemRPM."Primary Allocated Amount"
                              ELSE IF TempCustItemRPM."Distribution Type" = TempCustItemRPM."Distribution Type"::Secondary THEN
                                RPMSKURelation."Second. Alloc. Amount Customer" := TempCustItemRPM."Primary Allocated Amount";
                          RPMSKURelation."Own Fleet" := TempCustItemRPM."Own Fleet"; //HEI.07
                        UNTIL TempCustItemRPM.NEXT = 0;
                        //HEI.02<<

                        CLEAR(TempCustLinkedSKU);
                        TempCustLinkedSKU.SETRANGE("Item No.",RPMSKURelation."Linked Item No.");
                        TempCustLinkedSKU.SETRANGE("Destination No.",RPMSKURelation."Customer No.");
                        IF TempCustLinkedSKU.FINDFIRST THEN
                          RPMSKURelation."Period Net Weight Customer" := TempCustLinkedSKU."Net Weight (Kg)";
                         *///HEI.07 commented and replaced with flowfields on T50215

                        //HEI.22>> moved in PostDataItem to do update for all RPM records and calc only onece the flowfields
                        /*
                        RPMSKURelation.CALCFIELDS("Period Alloc. Amount Customer","Primary Alloc. Amount Customer","Second. Alloc. Amount Customer","Period Net Weight Customer",
                                       "Period Gen. Overheads Cust.","Period Whse. Handling Cust.","Period Whse. Overheads Cust.","Period Picking Factor Cust."); //HEI.07
                        IF RPMSKURelation."Period Net Weight Customer" <> 0 THEN BEGIN
                          //HEI.14>>
                          //RPMSKURelation."Period RPM Unit Cost Customer" := RPMSKURelation."Period Alloc. Amount Customer" / RPMSKURelation."Period Net Weight Customer";
                          //HEI.14<<
                          RPMSKURelation."Primary RPM Unit Cost Customer" := RPMSKURelation."Primary Alloc. Amount Customer" / RPMSKURelation."Period Net Weight Customer"; //HEI.02
                          RPMSKURelation."Second. RPM Unit Cost Customer" := RPMSKURelation."Second. Alloc. Amount Customer" / RPMSKURelation."Period Net Weight Customer"; //HEI.02
                          //HEI.07<<

                          //HEI.14>>
                          //RPMSKURelation."Period RPM Gen. Overh. Cust." := RPMSKURelation."Period Gen. Overheads Cust." / RPMSKURelation."Period Net Weight Customer";
                          //RPMSKURelation."Period RPM Whse. Overh. Cust." :=  RPMSKURelation."Period Whse. Overheads Cust." / RPMSKURelation."Period Net Weight Customer";
                          //HEI.14<<
                        END;
                        IF RPMSKURelation."Period Picking Factor Cust." <> 0 THEN
                          //HEI.14>>
                          //RPMSKURelation."Period RPM Whse. Handl. Cust." := RPMSKURelation."Period Whse. Handling Cust." / RPMSKURelation."Period Picking Factor Cust.";
                          //HEI.14<<
                          //HEI.07<<

                        {HEI.07 commented and replaced with flowfields on T50215
                        //for transfer orders
                        CLEAR(TempTransRPM);
                        TempTransRPM.SETRANGE("Item No.",RPMSKURelation."RPM Item No.");
                        //IF TempTransRPM.FINDFIRST THEN
                        IF TempTransRPM.FINDSET(FALSE,FALSE) THEN REPEAT //HEI.02
                          IF TempTransRPM."Distribution Type" = TempTransRPM."Distribution Type"::Total THEN
                            RPMSKURelation."Period Alloc. Amount Transfer" := TempTransRPM."Primary Allocated Amount"
                          ELSE IF TempTransRPM."Distribution Type" = TempTransRPM."Distribution Type"::Primary THEN
                            RPMSKURelation."Primary Alloc. Amount Transfer" := TempTransRPM."Primary Allocated Amount"
                              ELSE IF TempTransRPM."Distribution Type" = TempTransRPM."Distribution Type"::Secondary THEN
                                RPMSKURelation."Second. Alloc. Amount Transfer" := TempTransRPM."Primary Allocated Amount";
                        UNTIL TempTransRPM.NEXT = 0;
                        //HEI.02<<

                        CLEAR(TempTransferLinkedSKU);
                        TempTransferLinkedSKU.SETRANGE("Item No.",RPMSKURelation."Linked Item No.");
                        IF TempTransferLinkedSKU.FINDFIRST THEN
                          RPMSKURelation."Period Net Weight Linked Item" := TempTransferLinkedSKU."Net Weight (Kg)";
                        } //HEI.07 commented<<

                        RPMSKURelation.CALCFIELDS("Period Alloc. Amount Transfer","Primary Alloc. Amount Transfer","Second. Alloc. Amount Transfer","Period Net Weight Linked Item",
                                                  "Period Gen. Overheads IT","Period Whse. Overheads IT","Period Whse. Handling IT","Period Pick. Fact. Linked Item"); //HEI.07
                        IF RPMSKURelation."Period Net Weight Linked Item" <> 0 THEN BEGIN //HEI.02
                          //HEI.14>>
                          //RPMSKURelation."Period RPM Unit Cost Transfer" := RPMSKURelation."Period Alloc. Amount Transfer" / RPMSKURelation."Period Net Weight Linked Item";
                          //HEI.14<<
                          RPMSKURelation."Primary RPM Unit Cost Transfer" := RPMSKURelation."Primary Alloc. Amount Transfer" / RPMSKURelation."Period Net Weight Linked Item"; //HEI.02
                          RPMSKURelation."Second. RPM Unit Cost Transfer" := RPMSKURelation."Second. Alloc. Amount Transfer" / RPMSKURelation."Period Net Weight Linked Item"; //HEI.02
                          //HEI.07>>
                          //HEI.14>>
                          //RPMSKURelation."Period RPM Gen. Overh. IT" := RPMSKURelation."Period Gen. Overheads IT" / RPMSKURelation."Period Net Weight Linked Item";
                          //RPMSKURelation."Period RPM Whse. Overh. IT" := RPMSKURelation."Period Whse. Overheads IT" / RPMSKURelation."Period Net Weight Linked Item";
                          //HEI.14<<
                          //HEI.07<<
                        END; //HEI.02
                        //HEI.14>>
                        //HEI.07>>
                        {
                        IF RPMSKURelation."Period Pick. Fact. Linked Item" <> 0 THEN
                          RPMSKURelation."Period RPM Whse. Handl. IT" := RPMSKURelation."Period Whse. Handling IT" / RPMSKURelation."Period Pick. Fact. Linked Item";
                        }
                        //HEI.07<<
                        */
                        //HEI.22<<

                        RPMSKURelation."Processing Date" := WorkDate(); //HEI.14

                        //HEI.18>>
                        //RPMSKURelation.INSERT ;
                        if RPMSKURelation.Insert() then;
                        //HEI.18<<
                    end;
                end;
            until ProdBOMLine.Next() = 0;
    end;

    local procedure InitValues();
    begin
        CountCust := 0;
        CountTransfer := 0;
        RPMUnitCostCust := 0;
        RPMUnitCostTransfer := 0;
    end;

    local procedure InsertTempIT();
    var
        ShipCostAllocation: Record "Shipping Cost Allocation FND";
    begin
        //for transfer orders
        ShipCostAllocation.Reset();
        ShipCostAllocation.SetCurrentKey("Posting Date", "Destination Type");
        ShipCostAllocation.SetRange("Posting Date", StartingDate, EndingDate);
        ShipCostAllocation.SetRange("Destination Type", ShipCostAllocation."Destination Type"::Location);
        ShipCostAllocation.SetRange("Distribution Type", ShipCostAllocation."Distribution Type"::Total); //HEI.02
        if ShipCostAllocation.FindSet(false) then
            repeat

                if STRPOS(InventorySetup."Finished Goods ItemCatCode FND", ShipCostAllocation."Item Category Code") <> 0 then begin
                    TempIT.Reset();
                    TempIT.SetCurrentKey("Item No.");
                    TempIT.SetRange("Item No.", ShipCostAllocation."Item No.");
                    TempIT.SetRange("Lot No.", ShipCostAllocation."Lot No.");
                    TempIT.SetRange("Destination No.", ShipCostAllocation."Destination No.");
                    //HEI.23>>
                    //TempIT.SETRANGE("Own Fleet",ShipCostAllocation."Own Fleet"); //HEI.04
                    //HEI.23<<
                    if not TempIT.FindFirst() then begin
                        TempIT.Init();
                        TempIT."Entry No." := ShipCostAllocation."Entry No.";
                        TempIT."Item No." := ShipCostAllocation."Item No.";
                        TempIT."Lot No." := ShipCostAllocation."Lot No.";
                        TempIT."Destination No." := ShipCostAllocation."Destination No.";
                        TempIT."Own Fleet" := ShipCostAllocation."Own Fleet"; //HEI.04
                        TempIT."Period Net Weight SKU/Lot" := ShipCostAllocation."Net Weight (Kg)";
                        //HEI.19>>
                        //TempIT."Period Transfers per SKU/Lot" := ShipCostAllocation."Primary Allocated Amount";
                        if ShipCostAllocation."Own Fleet" then
                            TempIT."Period Transfers per SKU/Lot" := ShipCostAllocation."Weight Allocation Own Fleet" + ShipCostAllocation."No. of Drops All. Own Fleet" + ShipCostAllocation."Distance Allocation Own Fleet"
                        else
                            TempIT."Period Transfers per SKU/Lot" := ShipCostAllocation."Primary Allocated Amount";
                        //HEI.19<<
                        TempIT."Period Gen. Overh. per SKU/Lot" := ShipCostAllocation."General Overheads";
                        TempIT."Period Whs. Overh. per SKU/Lot" := ShipCostAllocation."Warehouse Overheads";
                        TempIT."Period Whse. Hand. per SKU/Lot" := ShipCostAllocation."Warehouse Handling";
                        TempIT."Period Picking Factor SKU/Lot" := ShipCostAllocation."Picking Factor";

                        //HEI.26>>
                        TempIT."OVE Prd. Whse. Hand. SKU/Lot" := ShipCostAllocation."OVE Warehouse Handling";
                        TempIT."TRP Prd. Whse. Hand. SKU/Lot" := ShipCostAllocation."TRP Warehouse Handling";
                        TempIT."FIX Prd. Whse. Hand. SKU/Lot" := ShipCostAllocation."FIX Warehouse Handling";
                        //HEI.26<<

                        TempIT.Insert();
                    end else begin
                        TempIT."Period Net Weight SKU/Lot" += ShipCostAllocation."Net Weight (Kg)";
                        //HEI.19>>
                        //TempIT."Period Transfers per SKU/Lot" += ShipCostAllocation."Primary Allocated Amount";
                        if ShipCostAllocation."Own Fleet" then
                            TempIT."Period Transfers per SKU/Lot" += ShipCostAllocation."Weight Allocation Own Fleet" + ShipCostAllocation."No. of Drops All. Own Fleet" + ShipCostAllocation."Distance Allocation Own Fleet"
                        else
                            TempIT."Period Transfers per SKU/Lot" += ShipCostAllocation."Primary Allocated Amount";
                        //HEI.19<<
                        TempIT."Period Gen. Overh. per SKU/Lot" += ShipCostAllocation."General Overheads";
                        TempIT."Period Whs. Overh. per SKU/Lot" += ShipCostAllocation."Warehouse Overheads";
                        TempIT."Period Whse. Hand. per SKU/Lot" += ShipCostAllocation."Warehouse Handling";
                        TempIT."Period Picking Factor SKU/Lot" += ShipCostAllocation."Picking Factor";
                        //HEI.26>>
                        TempIT."OVE Prd. Whse. Hand. SKU/Lot" += ShipCostAllocation."OVE Warehouse Handling";
                        TempIT."TRP Prd. Whse. Hand. SKU/Lot" += ShipCostAllocation."TRP Warehouse Handling";
                        TempIT."FIX Prd. Whse. Hand. SKU/Lot" += ShipCostAllocation."FIX Warehouse Handling";
                        //HEI.26<<

                        TempIT.MODIFY();
                    end;
                end;
            until ShipCostAllocation.Next() = 0;
    end;

    local procedure InsertTempCustIT();
    var
        ShipCostAllocation: Record "Shipping Cost Allocation FND";
    begin
        //deprecated - replaced by InsertTempCustIT2
        //for Delivery to customers
        ShipCostAllocation.Reset();
        ShipCostAllocation.SetRange("Posting Date", StartingDate, EndingDate);
        ShipCostAllocation.SetRange("Destination Type", ShipCostAllocation."Destination Type"::Customer);
        ShipCostAllocation.SetRange("Distribution Type", ShipCostAllocation."Distribution Type"::Total); //HEI.02
        ShipCostAllocation.SetRange("Only RPM Transportation", false);
        if ShipCostAllocation.FindSet(false) then
            repeat
                CalcTotals(ShipCostAllocation); //HEI.04
                TempCustIT.Reset();
                TempCustIT.SetCurrentKey("Item No.");
                TempCustIT.SetRange("Item No.", ShipCostAllocation."Item No.");
                TempCustIT.SetRange("Lot No.", ShipCostAllocation."Lot No.");
                TempCustIT.SetRange("Location Code", ShipCostAllocation."Location Code");
                TempCustIT.SetRange("Own Fleet", ShipCostAllocation."Own Fleet"); //HEI.04
                if not TempCustIT.FindFirst() then begin
                    TempCustIT.Init();
                    TempCustIT."Entry No." := ShipCostAllocation."Entry No.";
                    TempCustIT."Item No." := ShipCostAllocation."Item No.";
                    TempCustIT."Lot No." := ShipCostAllocation."Lot No.";
                    TempCustIT."Location Code" := ShipCostAllocation."Location Code";
                    TempCustIT."Own Fleet" := ShipCostAllocation."Own Fleet"; //HEI.04
                    TempCustIT."Period Net Weight SKU/Lot" := ShipCostAllocation."Net Weight (Kg)";
                    TempCustIT.Insert();
                end else begin
                    TempCustIT."Period Net Weight SKU/Lot" += ShipCostAllocation."Net Weight (Kg)";
                    TempCustIT.Modify();
                end;
            until ShipCostAllocation.Next() = 0;

        //for Internal Transfers
        ShipCostAllocation.Reset();
        ShipCostAllocation.SetRange("Posting Date", StartingDate, EndingDate);
        ShipCostAllocation.SetRange("Destination Type", ShipCostAllocation."Destination Type"::Location);
        ShipCostAllocation.SetRange("Distribution Type", ShipCostAllocation."Distribution Type"::Total); //HEI.02
        if ShipCostAllocation.FindSet(false) then
            repeat
                CalcTotals(ShipCostAllocation); //HEI.04
            until ShipCostAllocation.Next() = 0;

        //HEI.08<<
        //for rpm transports
        ShipCostAllocation.Reset();
        ShipCostAllocation.SetRange("Posting Date", StartingDate, EndingDate);
        ShipCostAllocation.SetRange("Destination Type", ShipCostAllocation."Destination Type"::Customer);
        ShipCostAllocation.SetRange("Source Document", ShipCostAllocation."Source Document"::"Sales Return Order");
        ShipCostAllocation.SetRange("Only RPM Transportation", true);
        if ShipCostAllocation.FindSet(false) then
            repeat
                CalcTotals(ShipCostAllocation);
            until ShipCostAllocation.Next() = 0;
        //HEI.08
    end;

    local procedure AllocateITCosts(var Rec: Record "Shipping Cost Allocation FND");
    begin
        Clear(TempIT);
        TempIT.SetRange("Item No.", Rec."Item No.");
        TempIT.SetRange("Lot No.", Rec."Lot No.");
        TempIT.SetRange("Destination No.", Rec."Destination No.");
        //HEI.23>>
        /*
        TempIT.SETRANGE("Own Fleet",Rec."Own Fleet"); //HEI.04
        */
        //HEI.23<<
        if TempIT.FindFirst() then begin
            Rec."Period Net Weight SKU/Lot" := TempIT."Period Net Weight SKU/Lot";
            Rec."Period Transfers per SKU/Lot" := TempIT."Period Transfers per SKU/Lot";
            Rec."Period Gen. Overh. per SKU/Lot" := TempIT."Period Gen. Overh. per SKU/Lot";
            Rec."Period Whs. Overh. per SKU/Lot" := TempIT."Period Whs. Overh. per SKU/Lot";
            Rec."Period Whse. Hand. per SKU/Lot" := TempIT."Period Whse. Hand. per SKU/Lot";
            Rec."Period Picking Factor SKU/Lot" := TempIT."Period Picking Factor SKU/Lot";
            //HEI.26>>
            Rec."OVE Prd. Whse. Hand. SKU/Lot" := TempIT."OVE Prd. Whse. Hand. SKU/Lot";
            Rec."TRP Prd. Whse. Hand. SKU/Lot" := TempIT."TRP Prd. Whse. Hand. SKU/Lot";
            Rec."FIX Prd. Whse. Hand. SKU/Lot" := TempIT."FIX Prd. Whse. Hand. SKU/Lot";
            //HEI.26<<

            //HEI.29<<
            /*
            //HEI.28>>
            Rec."Per. Net Weight SKU/Lot 3rd P"  := TempIT."Per. Net Weight SKU/Lot 3rd P";
            Rec."Per. Net Wgt SKU/Lot Own Fleet" := TempIT."Per. Net Wgt SKU/Lot Own Fleet";
            //HEI.28<<
            */
            //HEI.29<<

            Rec.Modify();
        end;

    end;

    local procedure AllocateCustITCosts(var Rec: Record "Shipping Cost Allocation FND");
    begin
        Clear(TempCustIT);
        TempCustIT.SetRange("Item No.", Rec."Item No.");
        TempCustIT.SetRange("Lot No.", Rec."Lot No.");
        TempCustIT.SetRange("Location Code", Rec."Location Code");
        //HEI.23>>
        /*
        TempCustIT.SETRANGE("Own Fleet",Rec."Own Fleet"); //HEI.04`
        */
        //HEI.23<<
        if TempCustIT.FindFirst() then begin
            Rec."Period Net Weight SKU/Lot" := TempCustIT."Period Net Weight SKU/Lot";
            //HEI.22>>
            Rec."Period Picking Factor SKU/Lot" := TempCustIT."Period Picking Factor SKU/Lot";
            //HEI.22<<

            //HEI.29>>
            /*
            //HEI.28>>
            Rec."Per. Net Weight SKU/Lot 3rd P"  := TempCustIT."Per. Net Weight SKU/Lot 3rd P";
            Rec."Per. Net Wgt SKU/Lot Own Fleet" := TempCustIT."Per. Net Wgt SKU/Lot Own Fleet";
            //HEI.28<<
            */
            //HEI.29<<

            Rec.Modify();
        end;

    end;

    local procedure AllocateSecondaryWarehouseCosts(var Rec: Record "Shipping Cost Allocation FND");
    begin
        //HEI.02
        Clear(TempWhseCostSetup);
        //HEI.10>>
        TempWhseCostSetup.Reset();
        TempWhseCostSetup.SetCurrentKey("Distribution Type");
        //HEI.10<<
        TempWhseCostSetup.SetRange("Distribution Type", TempWhseCostSetup."Distribution Type"::Secondary);
        if TempWhseCostSetup.FindSet(false) then
            repeat
                case TempWhseCostSetup."C2S Name" of
                    TempWhseCostSetup."C2S Name"::"General Overhead Costs (Fixed)":
                        begin
                            Rec."General Overheads" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."Period G/L Cost Gen. Overheads" := TempWhseCostSetup."Period Cost";
                        end;

                    TempWhseCostSetup."C2S Name"::"Warehouse Handling Costs (Variable)":
                        begin
                            Rec."Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."Period G/L Cost Whse. Handling" := TempWhseCostSetup."Period Cost";
                        end;

                    TempWhseCostSetup."C2S Name"::"Warehouse Overhead Costs (Fixed)":
                        begin
                            Rec."Warehouse Overheads" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."Period G/L Cost Whse. Overhead" := TempWhseCostSetup."Period Cost";
                        end;

                    TempWhseCostSetup."C2S Name"::"Delivery To Customers":
                        Rec."Period G/L Cost Delivery Cust." := TempWhseCostSetup."Period Cost";

                    //HEI.04<<
                    TempWhseCostSetup."C2S Name"::"Own Fleet":
                        //HEI.20>>
                        begin
                            Rec."Period G/L Cost Own Fleet" := TempWhseCostSetup."Period Cost";
                            //HEI.20<<
                            if Rec."Own Fleet" then begin
                                //Rec."Period G/L Cost Own Fleet" := TempWhseCostSetup."Period Cost"; //HEI.20
                                if PeriodNetWeightOwnFleet <> 0 then
                                    //HEI.24<<
                                    //Rec."Weight Allocation Own Fleet" := ABS((Rec."Net Weight (Kg)" / PeriodNetWeightOwnFleet) * (TempWhseCostSetup."Net Weight Allocation %"/100) * Rec."Period G/L Cost Own Fleet");
                                    Rec."Weight Allocation Own Fleet" := (Rec."Net Weight (Kg)" / PeriodNetWeightOwnFleet) * (TempWhseCostSetup."Net Weight Allocation %" / 100) * Rec."Period G/L Cost Own Fleet";
                                //HEI.24>>
                                if (PeriodDrops <> 0)
                                  and (NumberOfLines <> 0) //HEI.22
                                then
                                    //HEI.24>>
                                    //Rec."No. of Drops All. Own Fleet" := ABS((Rec."No. of Drops" / PeriodDrops) * (TempWhseCostSetup."No. of Drops Allocation %"/100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines);
                                    Rec."No. of Drops All. Own Fleet" := (Rec."No. of Drops" / PeriodDrops) * (TempWhseCostSetup."No. of Drops Allocation %" / 100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines;
                                //HEI.24<<
                                if (PeriodDistance <> 0)
                                  and (NumberOfLines <> 0) //HEI.22
                                then
                                    //HEI.24>>
                                    //Rec."Distance Allocation Own Fleet" := ABS((Rec.Distance / PeriodDistance) * (TempWhseCostSetup."Distance Allocation %"/100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines);
                                    Rec."Distance Allocation Own Fleet" := (Rec.Distance / PeriodDistance) * (TempWhseCostSetup."Distance Allocation %" / 100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines;
                                //HEI.24<<
                            end;
                        end;//HEI.20>>
                            //HEI.04>>

                    //HEI.26>>
                    TempWhseCostSetup."C2S Name"::"Whse Hand. Costs (Variable) OVE":
                        begin
                            Rec."OVE Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."OVE Prd G/L Whse Hand Cost" := TempWhseCostSetup."Period Cost";
                        end;
                    TempWhseCostSetup."C2S Name"::"Whse Hand. Costs (Variable) Transp. Exp.":
                        begin
                            Rec."TRP Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."TRP Prd G/L Whse Hand Cost" := TempWhseCostSetup."Period Cost";
                        end;
                    TempWhseCostSetup."C2S Name"::"Whse Hand. Costs (Variable) Fixed Exp.":
                        begin
                            Rec."FIX Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."FIX Prd G/L Whse Hand Cost" := TempWhseCostSetup."Period Cost";
                        end;
                //HEI.26<<
                end;
            until TempWhseCostSetup.Next() = 0;
        //HEI.02
    end;

    local procedure CalculateTotalWhseCosts(var Rec: Record "Shipping Cost Allocation FND");
    begin
        //HEI.02
        ShipCostAllocation.Reset();
        ShipCostAllocation.SetCurrentKey("Parent Line No.");
        ShipCostAllocation.SetRange("Parent Line No.", Rec."Entry No.");
        if ShipCostAllocation.FindSet(false) then
            repeat
                Rec."General Overheads" += ShipCostAllocation."General Overheads";
                Rec."Warehouse Handling" += ShipCostAllocation."Warehouse Handling";
                Rec."Warehouse Overheads" += ShipCostAllocation."Warehouse Overheads";
                Rec."Period G/L Cost Delivery Cust." += ShipCostAllocation."Period G/L Cost Delivery Cust.";
                Rec."Period G/L Cost Gen. Overheads" += ShipCostAllocation."Period G/L Cost Gen. Overheads";
                Rec."Period G/L Cost Whse. Handling" += ShipCostAllocation."Period G/L Cost Whse. Handling";
                Rec."Period G/L Cost Whse. Overhead" += ShipCostAllocation."Period G/L Cost Whse. Overhead";
                //HEI.04<<
                Rec."Period G/L Cost Own Fleet" += ShipCostAllocation."Period G/L Cost Own Fleet";
                Rec."Weight Allocation Own Fleet" += ShipCostAllocation."Weight Allocation Own Fleet";
                Rec."No. of Drops All. Own Fleet" += ShipCostAllocation."No. of Drops All. Own Fleet";
                Rec."Distance Allocation Own Fleet" += ShipCostAllocation."Distance Allocation Own Fleet";
            //HEI.04>>
            until ShipCostAllocation.Next() = 0;
        //HEI.02
    end;

    local procedure InsertTotals(var Rec: Record "Shipping Cost Allocation FND");
    begin
        //HEI.04>>
        if Rec."Own Fleet" then begin
            Rec."Period Net Weight (Kg)" := PeriodNetWeightOwnFleet;
            Rec."Period Picking Factor" := PeriodPickingFactorOwnFleet;
            Rec."Period Distance" := PeriodDistance;
            Rec."Period Drop Counts" := PeriodDrops;
        end else begin
            Rec."Period Net Weight (Kg)" := PeriodNetWeight;
            Rec."Period Picking Factor" := PeriodPickingFactor;
        end;
        Rec.MODIFY();
        //HEI.04<<
    end;

    local procedure CalcDistanceAndDrops(DestinationType: Option Customer,Vendor,Location): Decimal;
    var
        Qr_C2SCalcDistanceAndDrops: Query "C2S RPM Calc Distance&Drops";
    begin
        //HEI.22>>
        /*
        TempShipCostAlloc.RESET;
        TempShipCostAlloc.SETRANGE("Posting Date",ShipCostAlloc."Posting Date");
        TempShipCostAlloc.SETRANGE("Destination Type",ShipCostAlloc."Destination Type");
        TempShipCostAlloc.SETRANGE("Distribution Type",ShipCostAlloc."Distribution Type"::Total);
        TempShipCostAlloc.SETRANGE("Own Fleet",TRUE);
        TempShipCostAlloc.SETRANGE("No.",ShipCostAlloc."No.");
        IF NOT TempShipCostAlloc.FINDFIRST THEN BEGIN
          TempShipCostAlloc.TRANSFERFIELDS(ShipCostAlloc);
          TempShipCostAlloc."No." := ShipCostAlloc."No.";
          PeriodDistance += ShipCostAlloc.Distance;
          PeriodDrops += ShipCostAlloc."No. of Drops";
          TempShipCostAlloc.INSERT;
        END;
        */
        Qr_C2SCalcDistanceAndDrops.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Qr_C2SCalcDistanceAndDrops.SetRange(FilterDestinationType, DestinationType);
        Qr_C2SCalcDistanceAndDrops.SetRange(FilterOwnFleet, true);
        Qr_C2SCalcDistanceAndDrops.Open();
        while Qr_C2SCalcDistanceAndDrops.Read() do begin
            PeriodDistance += Qr_C2SCalcDistanceAndDrops.Distance;
            PeriodDrops += Qr_C2SCalcDistanceAndDrops.NoOfDrops;
        end;
        Qr_C2SCalcDistanceAndDrops.Close();
    end;

    local procedure CalcTotals(var Rec: Record "Shipping Cost Allocation FND");
    begin
        //HEI.22 - deprecated. Replaced with CalcTotalAmtsAndUpdCostAlloc
        //HEI.04<<
        if not Rec."Own Fleet" then begin
            PeriodNetWeight += Rec."Net Weight (Kg)";
            //HEI.21>>
            if (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", Rec."Item Category Code") <> 0) or (STRPOS(SalesReceivablesSetup."RPMRelatedItemCategoryCode FND", Rec."Item Category Code") <> 0) then
                //HEI.21<<
                PeriodPickingFactor += Rec."Picking Factor";
        end else begin
            PeriodNetWeightOwnFleet += Rec."Net Weight (Kg)";
            //HEI.21>>
            if (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", Rec."Item Category Code") <> 0) or (STRPOS(SalesReceivablesSetup."RPMRelatedItemCategoryCode FND", Rec."Item Category Code") <> 0) then
                //HEI.21<<
                PeriodPickingFactorOwnFleet += Rec."Picking Factor";
            //CalcDistanceAndDrops(Rec);HEI.22
        end;
        //HEI.04>>
    end;

    local procedure AllocateTotalWarehouseCosts(var Rec: Record "Shipping Cost Allocation FND");
    begin
        //HEI.02
        CLEAR(TempWhseCostSetup);
        //HEI.10>>
        TempWhseCostSetup.Reset();
        TempWhseCostSetup.SetCurrentKey("C2S Name");
        //HEI.10<<
        if TempWhseCostSetup.FindSet(false) then
            repeat
                case TempWhseCostSetup."C2S Name" of
                    TempWhseCostSetup."C2S Name"::"General Overhead Costs (Fixed)":
                        begin
                            Rec."General Overheads" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."Period G/L Cost Gen. Overheads" := TempWhseCostSetup."Period Cost";
                        end;

                    TempWhseCostSetup."C2S Name"::"Warehouse Handling Costs (Variable)":
                        begin
                            Rec."Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."Period G/L Cost Whse. Handling" := TempWhseCostSetup."Period Cost";
                        end;

                    TempWhseCostSetup."C2S Name"::"Warehouse Overhead Costs (Fixed)":
                        begin
                            Rec."Warehouse Overheads" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."Period G/L Cost Whse. Overhead" := TempWhseCostSetup."Period Cost";
                        end;

                    TempWhseCostSetup."C2S Name"::"Delivery To Customers":
                        Rec."Period G/L Cost Delivery Cust." := TempWhseCostSetup."Period Cost";

                    //HEI.04<<
                    TempWhseCostSetup."C2S Name"::"Own Fleet":
                        //HEI.20>>
                        begin
                            Rec."Period G/L Cost Own Fleet" := TempWhseCostSetup."Period Cost";
                            //HEI.20<<
                            if Rec."Own Fleet" then begin
                                //Rec."Period G/L Cost Own Fleet" := TempWhseCostSetup."Period Cost"; //HEI.20
                                if PeriodNetWeightOwnFleet <> 0 then
                                    //HEI.24>>
                                    //Rec."Weight Allocation Own Fleet" := ABS((Rec."Net Weight (Kg)" / PeriodNetWeightOwnFleet) * (TempWhseCostSetup."Net Weight Allocation %"/100) * Rec."Period G/L Cost Own Fleet");
                                    Rec."Weight Allocation Own Fleet" := (Rec."Net Weight (Kg)" / PeriodNetWeightOwnFleet) * (TempWhseCostSetup."Net Weight Allocation %" / 100) * Rec."Period G/L Cost Own Fleet";
                                //HEI.24<<
                                if (PeriodDrops <> 0)
                                  and (NumberOfLines <> 0) //HEI.22
                                then
                                    //HEI.24>>
                                    //Rec."No. of Drops All. Own Fleet" := ABS((Rec."No. of Drops" / PeriodDrops) * (TempWhseCostSetup."No. of Drops Allocation %"/100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines);
                                    Rec."No. of Drops All. Own Fleet" := (Rec."No. of Drops" / PeriodDrops) * (TempWhseCostSetup."No. of Drops Allocation %" / 100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines;
                                //HEI.24<<
                                if (PeriodDistance <> 0)
                                  and (NumberOfLines <> 0) //HEI.22
                                then
                                    //HEI.24>>
                                    //Rec."Distance Allocation Own Fleet" := ABS((Rec.Distance / PeriodDistance) * (TempWhseCostSetup."Distance Allocation %"/100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines);
                                    Rec."Distance Allocation Own Fleet" := (Rec.Distance / PeriodDistance) * (TempWhseCostSetup."Distance Allocation %" / 100) * Rec."Period G/L Cost Own Fleet" / NumberOfLines;
                                //HEI.24<<
                            end;

                        end;//HEI.20
                            //HEI.04>>

                    //HEI.26>>
                    TempWhseCostSetup."C2S Name"::"Whse Hand. Costs (Variable) OVE":
                        begin
                            Rec."OVE Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."OVE Prd G/L Whse Hand Cost" := TempWhseCostSetup."Period Cost";
                        end;
                    TempWhseCostSetup."C2S Name"::"Whse Hand. Costs (Variable) Transp. Exp.":
                        begin
                            Rec."TRP Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."TRP Prd G/L Whse Hand Cost" := TempWhseCostSetup."Period Cost";
                        end;
                    TempWhseCostSetup."C2S Name"::"Whse Hand. Costs (Variable) Fixed Exp.":
                        begin
                            Rec."FIX Warehouse Handling" := GetWhseAmount(TempWhseCostSetup, Rec);
                            Rec."FIX Prd G/L Whse Hand Cost" := TempWhseCostSetup."Period Cost";
                        end;
                //HEI.26<<
                end;
            until TempWhseCostSetup.Next() = 0;
        //HEI.02
    end;

    procedure GetDates(NewStartDate: Date; NewEndDate: Date);
    begin
        //HEI.05<<
        StartingDate := NewStartDate;
        EndingDate := NewEndDate;
        //HEI.05<<
    end;

    procedure JobQueueRun(lRunJobQ: Boolean; var Rec: Record "C2S/COGS Running Calendar FND");
    begin
        //HEI.05<<
        RunJobQ := lRunJobQ;
        RunningCalendar := Rec;
        //HEI.05<<
    end;

    local procedure GetLinesNumber_Old(DocNo: Code[20]): Integer;
    var
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        PostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
    begin
        //HEI.04
        CLEAR(NumberOfLines);

        ShipCostAllocation.SetRange("No.", DocNo);
        exit(ShipCostAllocation.Count);
        //HEI.04
    end;

    local procedure GetLinesNumber_New(DocNo: Code[20]): Integer;
    var
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        PostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
        l_ShippCostAlloc: Query "Shipping Cost Allocation";
        l_NoOfLines: Integer;
    begin
        //HEI.10
        /*
        CLEAR(NumberOfLines);
        CLEAR(l_NoOfLines);
        CLEAR(l_ShippCostAlloc);
        
        l_ShippCostAlloc.SETRANGE(No, DocNo);
        l_ShippCostAlloc.OPEN;
        WHILE l_ShippCostAlloc.READ DO BEGIN
          l_NoOfLines := l_ShippCostAlloc.NoOfLines;
        END;
        l_ShippCostAlloc.CLOSE;
        EXIT(l_NoOfLines);
        */
        //HEI.10

        //HEI.11>>
        Clear(NumberOfLines);
        gRec_C2SDocumentTotalLine.Reset();//HEI.22
        gRec_C2SDocumentTotalLine.SetRange("No.", DocNo);
        if gRec_C2SDocumentTotalLine.FindFirst() then
            exit(gRec_C2SDocumentTotalLine."Line No.");
        //HEI.11

    end;

    local procedure CalculateTotalWhseCosts_New(var Rec: Record "Shipping Cost Allocation FND");
    var
        lQr_ShippingCostAllocation: Query "Shipping Cost Allocation";
    begin
        //HEI.10>>
        /*
        CLEAR(lQr_ShippingCostAllocation);
        
        lQr_ShippingCostAllocation.SETRANGE(lQr_ShippingCostAllocation.ParentLineNo,Rec."Entry No.");
        lQr_ShippingCostAllocation.OPEN;
        WHILE lQr_ShippingCostAllocation.READ DO BEGIN
          Rec."General Overheads" := lQr_ShippingCostAllocation.TotalGenOverheads;
          Rec."Warehouse Handling" := lQr_ShippingCostAllocation.TotalWhseHandling;
          Rec."Warehouse Overheads" := lQr_ShippingCostAllocation.TotalWhseOverheads;
          Rec."Period G/L Cost Delivery Cust." := lQr_ShippingCostAllocation.TotalPeriodGLCostDeliveryCust;
          Rec."Period G/L Cost Gen. Overheads" := lQr_ShippingCostAllocation.TotalPeriodGLCostGenOverheads;
          Rec."Period G/L Cost Whse. Handling" := lQr_ShippingCostAllocation.TotalPeriodGLCostWhseHandling;
          Rec."Period G/L Cost Whse. Overhead" := lQr_ShippingCostAllocation.TotalPeriodGLCostWhseOverhead;
          Rec."Period G/L Cost Own Fleet" := lQr_ShippingCostAllocation.TotalPeriodGLCostOwnFleet;
          Rec."Weight Allocation Own Fleet" := lQr_ShippingCostAllocation.TotalWeightAllocationOwnFleet;
          Rec."No. of Drops All. Own Fleet" := lQr_ShippingCostAllocation.TotalNoofDropsAllOwnFleet;
          Rec."Distance Allocation Own Fleet" := lQr_ShippingCostAllocation.TotaDistanceAllocationOwnFleet
        END;
        //HEI.10<<
        */
        //HEI.11>>
        gRec_CalculateTotalWhseCosts.Reset();
        gRec_CalculateTotalWhseCosts.SetCurrentKey("Parent Line No.");
        gRec_CalculateTotalWhseCosts.SetRange("Parent Line No.", Rec."Entry No.");
        if gRec_CalculateTotalWhseCosts.FindSet(false) then
            repeat
                Rec."General Overheads" += gRec_CalculateTotalWhseCosts."General Overheads";
                Rec."Warehouse Handling" += gRec_CalculateTotalWhseCosts."Warehouse Handling";
                Rec."Warehouse Overheads" += gRec_CalculateTotalWhseCosts."Warehouse Overheads";
                Rec."Period G/L Cost Delivery Cust." += gRec_CalculateTotalWhseCosts."Period G/L Cost Delivery Cust.";
                Rec."Period G/L Cost Gen. Overheads" += gRec_CalculateTotalWhseCosts."Period G/L Cost Gen. Overheads";
                Rec."Period G/L Cost Whse. Handling" += gRec_CalculateTotalWhseCosts."Period G/L Cost Whse. Handling";
                Rec."Period G/L Cost Whse. Overhead" += gRec_CalculateTotalWhseCosts."Period G/L Cost Whse. Overhead";
                Rec."Period G/L Cost Own Fleet" += gRec_CalculateTotalWhseCosts."Period G/L Cost Own Fleet";
                Rec."Weight Allocation Own Fleet" += gRec_CalculateTotalWhseCosts."Weight Allocation Own Fleet";
                Rec."No. of Drops All. Own Fleet" += gRec_CalculateTotalWhseCosts."No. of Drops All. Own Fleet";
                Rec."Distance Allocation Own Fleet" += gRec_CalculateTotalWhseCosts."Distance Allocation Own Fleet";
            // BC Upgrade POENAB02 >>    
            // UNTIL ShipCostAllocation.NEXT = 0;            
            until gRec_CalculateTotalWhseCosts.Next() = 0;
        // BC Upgrade POENAB02<<
        //HEI.11<<

    end;

    procedure PopulateTempSCATotalLines(pDat_StartDate: Date; pDat_EndDate: Date);
    var
        lQr_C2SDocumentTotalLine: Query "C2S Document Total Line";
        EntryNo: Integer;
    begin
        //HEI.11>>
        Clear(gRec_C2SDocumentTotalLine);
        Clear(lQr_C2SDocumentTotalLine);
        EntryNo := 0;
        lQr_C2SDocumentTotalLine.SetRange(FilterPostingDate, pDat_StartDate, pDat_EndDate);
        lQr_C2SDocumentTotalLine.Open();
        while lQr_C2SDocumentTotalLine.Read() do begin
            EntryNo := EntryNo + 1;
            gRec_C2SDocumentTotalLine.Init();
            gRec_C2SDocumentTotalLine."Entry No." := EntryNo;
            gRec_C2SDocumentTotalLine."No." := lQr_C2SDocumentTotalLine.No;
            gRec_C2SDocumentTotalLine."Line No." := lQr_C2SDocumentTotalLine.NoOfLines;
            gRec_C2SDocumentTotalLine.Insert(false);
        end;
        lQr_C2SDocumentTotalLine.Close(); //HEI.13
        //HEI.11<<
    end;

    local procedure PopulateCalculateTotalWhseCosts(pDat_StartDate: Date; pDat_EndDate: Date);
    var
        lQr_CalculateTotalWhseCosts: Query "Shipping Cost Allocation";
        EntryNo: Integer;
    begin
        //HEI.11>>
        Clear(gRec_CalculateTotalWhseCosts);
        Clear(lQr_CalculateTotalWhseCosts);
        EntryNo := 0;
        lQr_CalculateTotalWhseCosts.SetRange(PostingDate, pDat_StartDate, pDat_EndDate);
        lQr_CalculateTotalWhseCosts.Open();
        while lQr_CalculateTotalWhseCosts.Read() do begin
            EntryNo := EntryNo + 1;
            gRec_CalculateTotalWhseCosts.Init();
            gRec_CalculateTotalWhseCosts."Entry No." := EntryNo;
            //gRec_CalculateTotalWhseCosts."Parent Line No." := lQr_CalculateTotalWhseCosts.FldParentLineNo; HEI.15 temporary commented. roll back
            gRec_CalculateTotalWhseCosts."General Overheads" := lQr_CalculateTotalWhseCosts.TotalGenOverheads;
            gRec_CalculateTotalWhseCosts."Warehouse Handling" := lQr_CalculateTotalWhseCosts.TotalWhseHandling;
            gRec_CalculateTotalWhseCosts."Warehouse Overheads" := lQr_CalculateTotalWhseCosts.TotalWhseOverheads;
            gRec_CalculateTotalWhseCosts."Period G/L Cost Delivery Cust." := lQr_CalculateTotalWhseCosts.TotalPeriodGLCostDeliveryCust;
            gRec_CalculateTotalWhseCosts."Period G/L Cost Gen. Overheads" := lQr_CalculateTotalWhseCosts.TotalPeriodGLCostGenOverheads;
            gRec_CalculateTotalWhseCosts."Period G/L Cost Whse. Handling" := lQr_CalculateTotalWhseCosts.TotalPeriodGLCostWhseHandling;
            gRec_CalculateTotalWhseCosts."Period G/L Cost Whse. Overhead" := lQr_CalculateTotalWhseCosts.TotalPeriodGLCostWhseOverhead;
            gRec_CalculateTotalWhseCosts."Period G/L Cost Own Fleet" := lQr_CalculateTotalWhseCosts.TotalPeriodGLCostOwnFleet;
            gRec_CalculateTotalWhseCosts."Weight Allocation Own Fleet" := lQr_CalculateTotalWhseCosts.TotalWeightAllocationOwnFleet;
            gRec_CalculateTotalWhseCosts."No. of Drops All. Own Fleet" := lQr_CalculateTotalWhseCosts.TotalNoofDropsAllOwnFleet;
            gRec_CalculateTotalWhseCosts."Distance Allocation Own Fleet" := lQr_CalculateTotalWhseCosts.TotaDistanceAllocationOwnFleet;
            gRec_CalculateTotalWhseCosts.Insert(false);
        end;
        lQr_CalculateTotalWhseCosts.Close(); //HEI.13
        //HEI.11<<
    end;

    procedure PopulateCalCFields(pDat_StartDate: Date; pDat_EndDate: Date);
    var
        lQr_C2SSCACalcFields: Query "C2S SCA CalcFields";
        lQr_C2SRPMSKUCalcFieldsPrdIT: Query "C2S RPM SKU CalcFields Prd IT";
        lQr_C2SRPMSKUCalcFieldsPrdCst: Query "C2S RPM SKU CalcFields Prd Cst";
    begin
        //HEI.12>>
        Clear(gRec_CalCFileds_Temp);
        Clear(lQr_C2SSCACalcFields);
        Clear(lQr_C2SRPMSKUCalcFieldsPrdCst);
        Clear(lQr_C2SRPMSKUCalcFieldsPrdIT);

        lQr_C2SSCACalcFields.SetRange(FilterPostingDate, pDat_StartDate, pDat_EndDate);
        lQr_C2SSCACalcFields.Open();
        while lQr_C2SSCACalcFields.Read() do begin
            gRec_CalCFileds_Temp.Init();
            gRec_CalCFileds_Temp."Entry No." := lQr_C2SSCACalcFields.EntryNo;
            gRec_CalCFileds_Temp."Period Date" := lQr_C2SSCACalcFields.Period_Date;
            gRec_CalCFileds_Temp."Item No." := lQr_C2SSCACalcFields.Item_No;
            gRec_CalCFileds_Temp."Own Fleet" := lQr_C2SSCACalcFields.Own_Fleet;
            gRec_CalCFileds_Temp."Destination Type" := lQr_C2SSCACalcFields.Destination_Type;
            gRec_CalCFileds_Temp."Destination No." := lQr_C2SSCACalcFields.Destination_No;
            gRec_CalCFileds_Temp."Lot No. & Destination No." := lQr_C2SSCACalcFields.Lot_No_Destination_No;
            gRec_CalCFileds_Temp."Source Document" := lQr_C2SSCACalcFields.Source_Document;
            gRec_CalCFileds_Temp."Lot No." := lQr_C2SSCACalcFields.Lot_No;
            gRec_CalCFileds_Temp."T_ST Period Net Weight SKU/Lot" := lQr_C2SSCACalcFields.STPeriodNetWeightSKU_Lot;
            gRec_CalCFileds_Temp."T_ST Period Pick Factr SKU/Lot" := lQr_C2SSCACalcFields.STPeriodPickFactorSKU_Lot;
            gRec_CalCFileds_Temp."T_ST Transfers per SKU/Lot" := lQr_C2SSCACalcFields.STTransfersperSKU_Lot;
            gRec_CalCFileds_Temp."T_Unit Cst Genl Overheads SO" := lQr_C2SSCACalcFields.UnitCost_GeneralOverheadsSO;
            gRec_CalCFileds_Temp."T_Unit Cst Intl Transfer SO" := lQr_C2SSCACalcFields.UnitCost_InternalTransferSO;
            gRec_CalCFileds_Temp."T_Unit Cost-Whse. Handling SO" := lQr_C2SSCACalcFields.UnitCost_WhseHandlingSO;
            gRec_CalCFileds_Temp."T_Unit Cost-Whse. Overhead SO" := lQr_C2SSCACalcFields.UnitCost_WhseOverheadSO;
            gRec_CalCFileds_Temp."T_ST Gen. Overh. per SKU/Lot" := lQr_C2SSCACalcFields.STGenOverhperSKU_Lot;
            gRec_CalCFileds_Temp."T_ST Whse. Hand. per SKU/Lot" := lQr_C2SSCACalcFields.STWhseHandperSKU_Lot;
            gRec_CalCFileds_Temp.Insert(false);
        end;

        lQr_C2SSCACalcFields.Close();

        lQr_C2SRPMSKUCalcFieldsPrdIT.SetRange(FilterPostingDate, pDat_StartDate, pDat_EndDate);
        lQr_C2SRPMSKUCalcFieldsPrdIT.Open();
        while lQr_C2SRPMSKUCalcFieldsPrdIT.Read() do begin
            if gRec_CalCFileds_Temp.Get(lQr_C2SRPMSKUCalcFieldsPrdIT.EntryNo) then begin
                gRec_CalCFileds_Temp."T_Prd RPM Gen. Overh. IT" := lQr_C2SRPMSKUCalcFieldsPrdIT.PeriodRPMGenOverhIT;
                gRec_CalCFileds_Temp."T_Prd RPM Whse. Handl. IT" := lQr_C2SRPMSKUCalcFieldsPrdIT.PeriodRPMWhseHandlIT;
                gRec_CalCFileds_Temp."T_Prd RPM Whse. Overh. IT" := lQr_C2SRPMSKUCalcFieldsPrdIT.PeriodRPMWhseOverhIT;
                gRec_CalCFileds_Temp.Modify(false);
            end else begin
                gRec_CalCFileds_Temp.Init();
                gRec_CalCFileds_Temp."Entry No." := lQr_C2SRPMSKUCalcFieldsPrdIT.EntryNo;
                gRec_CalCFileds_Temp."T_Prd RPM Gen. Overh. IT" := lQr_C2SRPMSKUCalcFieldsPrdIT.PeriodRPMGenOverhIT;
                gRec_CalCFileds_Temp."T_Prd RPM Whse. Handl. IT" := lQr_C2SRPMSKUCalcFieldsPrdIT.PeriodRPMWhseHandlIT;
                gRec_CalCFileds_Temp."T_Prd RPM Whse. Overh. IT" := lQr_C2SRPMSKUCalcFieldsPrdIT.PeriodRPMWhseOverhIT;
                gRec_CalCFileds_Temp.Insert(true);
            end;
        end;
        lQr_C2SRPMSKUCalcFieldsPrdIT.Close();


        lQr_C2SRPMSKUCalcFieldsPrdCst.SetRange(FilterPostingDate, pDat_StartDate, pDat_EndDate);
        lQr_C2SRPMSKUCalcFieldsPrdCst.Open();
        while lQr_C2SRPMSKUCalcFieldsPrdCst.Read() do begin
            if gRec_CalCFileds_Temp.Get(lQr_C2SRPMSKUCalcFieldsPrdCst.EntryNo) then begin
                gRec_CalCFileds_Temp."T_Prd RPM Gen. Overh. Cust." := lQr_C2SRPMSKUCalcFieldsPrdCst.PeriodRPMGenOverhCust;
                gRec_CalCFileds_Temp."T_Prd RPM Whse. Handl. Cust." := lQr_C2SRPMSKUCalcFieldsPrdCst.PeriodRPMWhseHandlCust;
                gRec_CalCFileds_Temp."T_Prd RPM Whse. Overh. Cust." := lQr_C2SRPMSKUCalcFieldsPrdCst.PeriodRPMWhseOverhCust;
                gRec_CalCFileds_Temp.Modify(false);
            end else begin
                gRec_CalCFileds_Temp.Init();
                gRec_CalCFileds_Temp."Entry No." := lQr_C2SRPMSKUCalcFieldsPrdCst.EntryNo;
                gRec_CalCFileds_Temp."T_Prd RPM Gen. Overh. Cust." := lQr_C2SRPMSKUCalcFieldsPrdCst.PeriodRPMGenOverhCust;
                gRec_CalCFileds_Temp."T_Prd RPM Whse. Handl. Cust." := lQr_C2SRPMSKUCalcFieldsPrdCst.PeriodRPMWhseHandlCust;
                gRec_CalCFileds_Temp."T_Prd RPM Whse. Overh. Cust." := lQr_C2SRPMSKUCalcFieldsPrdCst.PeriodRPMWhseOverhCust;
                gRec_CalCFileds_Temp.Insert(false);
            end;
        end;
        lQr_C2SRPMSKUCalcFieldsPrdCst.Close();

        //HEI.12<<
    end;

    local procedure UpdateRPMOverallocation();
    var
        Qr_C2SRPMSKUCust: Query "C2S RPM SKU RPM Item - Cust.";
        Qr_C2SRPMSKULinkedItem: Query "C2S RPM SKU RPM Item";
        Qr_C2SRPMSKUCustOverAlloc: Query "C2S RPM SKU Linked Item - Cust";
        Qr_C2SRPMSKULinkedItemOverAlloc: Query "C2S RPM SKU Linked Item";
        Qr_C2SRPMCalcFlowFields: Query "C2S RPM Calc Distance&Drops";
    begin
        //HEI.22 - deprecated. For optimization reason this function was replaced with UpdateRPMOverallocationNew
        //HEI.14>>

        //update for the couple (combination) RPM Item No. & Customer No. for the allocated period
        // step 1
        RPMSKURelation.Reset();
        RPMSKURelation.SetRange("Period Start Date", StartingDate);
        if RPMSKURelation.FindSet() then
            repeat
                RPMSKURelation.CalcFields("Period Alloc. Amount Customer", "Period Picking Factor Cust.",
                                          "Period Gen. Overheads Cust.", "Period Whse. Overheads Cust.",
                                          "Period Whse. Handling Cust.");
                Qr_C2SRPMSKUCust.SetRange(FilterPeriodStartDate, StartingDate);
                Qr_C2SRPMSKUCust.SetRange(FilterRPMItemNo, RPMSKURelation."RPM Item No.");
                Qr_C2SRPMSKUCust.SetRange(FilterCustomerNo, RPMSKURelation."Customer No.");
                Qr_C2SRPMSKUCust.Open();
                while Qr_C2SRPMSKUCust.Read() do begin
                    RPMSKURelation."Period Net Weight Sold Cust." := Qr_C2SRPMSKUCust.Sum_Period_Net_Weight_Customer;
                    RPMSKURelation."Period Pick. Factor Sold Cust." := Qr_C2SRPMSKUCust.Sum_Period_Picking_Factor_Cust;

                    if RPMSKURelation."Period Net Weight Sold Cust." <> 0 then begin
                        RPMSKURelation."RPM Unit Cost Sold Cust." := RPMSKURelation."Period Alloc. Amount Customer" / RPMSKURelation."Period Net Weight Sold Cust.";
                        RPMSKURelation."RPM Gen. Over. Unit Cost Cust." := RPMSKURelation."Period Gen. Overheads Cust." / RPMSKURelation."Period Net Weight Sold Cust.";
                        RPMSKURelation."RPM Whse. Over. Unit Cost Cust" := RPMSKURelation."Period Whse. Overheads Cust." / RPMSKURelation."Period Net Weight Sold Cust.";//HEI.17
                    end;

                    if RPMSKURelation."Period Pick. Factor Sold Cust." <> 0 then begin
                        RPMSKURelation."RPM Whse. Hand Unit Cost Cust." := RPMSKURelation."Period Whse. Handling Cust." / RPMSKURelation."Period Pick. Factor Sold Cust.";
                        //RPMSKURelation."RPM Whse. Over. Unit Cost Cust" := RPMSKURelation."Period Whse. Overheads Cust." / RPMSKURelation."Period Pick. Factor Sold Cust.";//HEI.17
                    end;

                    RPMSKURelation.Modify();
                end;
                Qr_C2SRPMSKUCust.Close();
            until RPMSKURelation.Next() = 0;

        //step 2
        RPMSKURelation.Reset();
        RPMSKURelation.SetRange("Period Start Date", StartingDate);
        if RPMSKURelation.FindSet() then
            repeat
                Qr_C2SRPMSKUCustOverAlloc.SetRange(FilterPeriodStartDate, StartingDate);
                Qr_C2SRPMSKUCustOverAlloc.SetRange(FilterLinkedItemNo, RPMSKURelation."Linked Item No.");
                Qr_C2SRPMSKUCustOverAlloc.SetRange(FilterCustomerNo, RPMSKURelation."Customer No.");
                Qr_C2SRPMSKUCustOverAlloc.Open();
                while Qr_C2SRPMSKUCustOverAlloc.Read() do begin
                    RPMSKURelation."Period RPM Unit Cost Customer" := Qr_C2SRPMSKUCustOverAlloc.Sum_RPM_Unit_Cost_Sold_Cust;
                    RPMSKURelation."Period RPM Gen. Overh. Cust." := Qr_C2SRPMSKUCustOverAlloc.Sum_RPM_Gen_Over_Unit_Cost_Cus;
                    RPMSKURelation."Period RPM Whse. Overh. Cust." := Qr_C2SRPMSKUCustOverAlloc.Sum_RPM_Whse_Over_Unit_Cost_Cu;
                    RPMSKURelation."Period RPM Whse. Handl. Cust." := Qr_C2SRPMSKUCustOverAlloc.Sum_RPM_Whse_Hand_Unit_Cost_Cu;
                    RPMSKURelation.Modify();
                end;
                Qr_C2SRPMSKUCustOverAlloc.Close();
            until RPMSKURelation.Next() = 0;



        //update for the field RPM Item No. for the allocated period
        //step 1
        RPMSKURelation.Reset();
        RPMSKURelation.SetRange("Period Start Date", StartingDate);
        if RPMSKURelation.FindSet() then
            repeat
                RPMSKURelation.CalcFields("Period Alloc. Amount Transfer", "Period Whse. Handling IT",
                                        "Period Whse. Overheads IT", "Period Gen. Overheads IT");
                Qr_C2SRPMSKULinkedItem.SetRange(FilterPeriodStartDate, StartingDate);
                Qr_C2SRPMSKULinkedItem.SetRange(FilterRPMItemNo, RPMSKURelation."RPM Item No.");
                Qr_C2SRPMSKULinkedItem.Open();
                while Qr_C2SRPMSKULinkedItem.Read() do begin
                    RPMSKURelation."Period Net Weight Transf." += Qr_C2SRPMSKULinkedItem.PeriodNetWeightLinkedItem;
                    RPMSKURelation."Period Pick. Factor Transf." += Qr_C2SRPMSKULinkedItem.PeriodPickFactLinkedItem;
                end;
                Qr_C2SRPMSKULinkedItem.Close();
                if RPMSKURelation."Period Net Weight Transf." <> 0 then begin
                    RPMSKURelation."RPM Unit Cost Transferred" := RPMSKURelation."Period Alloc. Amount Transfer" / RPMSKURelation."Period Net Weight Transf.";
                    RPMSKURelation."RPM Gen. Over. Unit Cost T" := RPMSKURelation."Period Gen. Overheads IT" / RPMSKURelation."Period Net Weight Transf.";
                    RPMSKURelation."RPM Whse. Over. Unit Cost T" := RPMSKURelation."Period Whse. Overheads IT" / RPMSKURelation."Period Net Weight Transf.";//HEI.17
                end;

                if RPMSKURelation."Period Pick. Factor Transf." <> 0 then begin
                    RPMSKURelation."RPM Whse. Hand Unit Cost T." := RPMSKURelation."Period Whse. Handling IT" / RPMSKURelation."Period Pick. Factor Transf.";
                    //RPMSKURelation."RPM Whse. Over. Unit Cost T" := RPMSKURelation."Period Whse. Overheads IT" / RPMSKURelation."Period Pick. Factor Transf."; //HEI.17
                end;
                RPMSKURelation.Modify();

            until RPMSKURelation.Next() = 0;


        //step 2

        RPMSKURelation.Reset();
        RPMSKURelation.SetRange("Period Start Date", StartingDate);
        if RPMSKURelation.FindSet() then
            repeat
                Qr_C2SRPMSKULinkedItemOverAlloc.SetRange(FilterPeriodStartDate, StartingDate);
                Qr_C2SRPMSKULinkedItemOverAlloc.SetRange(FilterLinkedItemNo, RPMSKURelation."Linked Item No.");
                Qr_C2SRPMSKULinkedItemOverAlloc.Open();
                while Qr_C2SRPMSKULinkedItemOverAlloc.Read() do begin
                    //HEI.17>>
                    /*
                    RPMSKURelation."Period RPM Unit Cost Transfer"  := Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Unit_Cost_Transferred;
                    RPMSKURelation."Period RPM Gen. Overh. IT"      := Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Gen_Over_Unit_Cost_T;
                    RPMSKURelation."Period RPM Whse. Overh. IT"     := Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Whse_Over_Unit_Cost_T;
                    RPMSKURelation."Period RPM Whse. Handl. IT"     := Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Whse_Hand_Unit_Cost_T;
                    RPMSKURelation.MODIFY;
                    */
                    RPMSKURelation."Period RPM Unit Cost Transfer" += Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Unit_Cost_Transferred;
                    RPMSKURelation."Period RPM Gen. Overh. IT" += Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Gen_Over_Unit_Cost_T;
                    RPMSKURelation."Period RPM Whse. Overh. IT" += Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Whse_Over_Unit_Cost_T;
                    RPMSKURelation."Period RPM Whse. Handl. IT" += Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Whse_Hand_Unit_Cost_T;
                    //HEI.17<<
                end;
                Qr_C2SRPMSKULinkedItemOverAlloc.Close();
                RPMSKURelation.Modify(); //HEI.17
            until RPMSKURelation.Next() = 0;


        //HEI.14<<

    end;

    local procedure CalcTotalAmtsAndUpdCostAlloc();
    var
        ShippingCostAllocLocal: Record "Shipping Cost Allocation FND";
    begin
        //HEi.14>>

        //Delivery to customer - set 1
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", false);
        ShippingCostAllocLocal.SetRange("Only RPM Transportation", false);
        ShippingCostAllocLocal.SetRange("Distribution Type", ShippingCostAllocLocal."Distribution Type"::Total);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Customer);
        //ShippingCostAllocLocal.CALCSUMS("Net Weight (Kg)","Picking Factor"); //HEI.22
        ShippingCostAllocLocal.CalcSums("Net Weight (Kg)"); //HEI.22
        PeriodNetWeight := ShippingCostAllocLocal."Net Weight (Kg)";
        //PeriodPickingFactor := ShippingCostAllocLocal."Picking Factor"; //HEI.22

        //HEI.22>>
        ShippingCostAllocLocal.Reset();
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", false);
        ShippingCostAllocLocal.SetRange("Only RPM Transportation", false);
        ShippingCostAllocLocal.SetRange("Distribution Type", ShippingCostAllocLocal."Distribution Type"::Total);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Customer);
        ShippingCostAllocLocal.SetFilter("Item Category Code", ItemCategFilter);
        ShippingCostAllocLocal.CalcSums("Picking Factor");
        PeriodPickingFactor := ShippingCostAllocLocal."Picking Factor";
        //HEI.22<<

        ShippingCostAllocLocal.Reset();
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", true);
        ShippingCostAllocLocal.SetRange("Only RPM Transportation", false);
        ShippingCostAllocLocal.SetRange("Distribution Type", ShippingCostAllocLocal."Distribution Type"::Total);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Customer);
        //ShippingCostAllocLocal.CalcSums("Net Weight (Kg)","Picking Factor");//HEI.22
        ShippingCostAllocLocal.CalcSums("Net Weight (Kg)");//HEI.22
        PeriodNetWeightOwnFleet := ShippingCostAllocLocal."Net Weight (Kg)";
        //PeriodPickingFactorOwnFleet := ShippingCostAllocLocal."Picking Factor";//HEI.22

        //HEI.22>>
        /*
        IF ShippingCostAllocLocal.FINDSET THEN
          REPEAT
            CalcDistanceAndDrops(ShippingCostAllocLocal);
          UNTIL ShippingCostAllocLocal.NEXT = 0;
        */
        CalcDistanceAndDrops(ShippingCostAllocLocal."Destination Type"::Customer);

        ShippingCostAllocLocal.Reset();
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", true);
        ShippingCostAllocLocal.SetRange("Only RPM Transportation", false);
        ShippingCostAllocLocal.SetRange("Distribution Type", ShippingCostAllocLocal."Distribution Type"::Total);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Customer);
        ShippingCostAllocLocal.SetFilter("Item Category Code", ItemCategFilter);
        ShippingCostAllocLocal.CalcSums("Picking Factor");
        PeriodPickingFactorOwnFleet := ShippingCostAllocLocal."Picking Factor";
        //HEI.22<<



        //Internal transfer - set 2
        ShippingCostAllocLocal.Reset();
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", false);
        ShippingCostAllocLocal.SetRange("Distribution Type", ShippingCostAllocLocal."Distribution Type"::Total);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Location);
        //ShippingCostAllocLocal.CalcSums("Net Weight (Kg)","Picking Factor"); //HEI.22
        ShippingCostAllocLocal.CalcSums("Net Weight (Kg)"); //HEI.22
        PeriodNetWeight += ShippingCostAllocLocal."Net Weight (Kg)";
        //PeriodPickingFactor += ShippingCostAllocLocal."Picking Factor"; //HEI.22

        //HEI.22>>
        ShippingCostAllocLocal.Reset();
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", false);
        ShippingCostAllocLocal.SetRange("Distribution Type", ShippingCostAllocLocal."Distribution Type"::Total);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Location);
        ShippingCostAllocLocal.SetFilter("Item Category Code", ItemCategFilter);
        ShippingCostAllocLocal.CalcSums("Picking Factor");
        PeriodPickingFactor += ShippingCostAllocLocal."Picking Factor";
        //HEI.22<<

        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", true);
        ShippingCostAllocLocal.SetRange("Distribution Type", ShippingCostAllocLocal."Distribution Type"::Total);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Location);
        //ShippingCostAllocLocal.CalcSums("Net Weight (Kg)","Picking Factor");//HEI.22
        ShippingCostAllocLocal.CalcSums("Net Weight (Kg)");//HEI.22
        PeriodNetWeightOwnFleet += ShippingCostAllocLocal."Net Weight (Kg)";
        //PeriodPickingFactorOwnFleet += ShippingCostAllocLocal."Picking Factor";//HEI.22

        //HEI.22>>
        /*
        IF ShippingCostAllocLocal.FINDSET THEN
          REPEAT
            CalcDistanceAndDrops(ShippingCostAllocLocal);
          UNTIL ShippingCostAllocLocal.NEXT = 0;
        */

        CalcDistanceAndDrops(ShippingCostAllocLocal."Destination Type"::Location);

        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", true);
        ShippingCostAllocLocal.SetRange("Distribution Type", ShippingCostAllocLocal."Distribution Type"::Total);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Location);
        ShippingCostAllocLocal.SetFilter("Item Category Code", ItemCategFilter);
        ShippingCostAllocLocal.CalcSums("Picking Factor");
        PeriodPickingFactorOwnFleet += ShippingCostAllocLocal."Picking Factor";
        //HEI.22<<


        //RPM Transport - set 3
        ShippingCostAllocLocal.Reset();
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", false);
        ShippingCostAllocLocal.SetRange("Only RPM Transportation", true);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Customer);
        ShippingCostAllocLocal.SetRange("Source Document", ShippingCostAllocLocal."Source Document"::"Sales Return Order");
        //ShippingCostAllocLocal.CalcSums("Net Weight (Kg)","Picking Factor");//HEI.22
        ShippingCostAllocLocal.CalcSums("Net Weight (Kg)");//HEI.22
        PeriodNetWeight += ShippingCostAllocLocal."Net Weight (Kg)";
        //PeriodPickingFactor += ShippingCostAllocLocal."Picking Factor";//HEI.22

        //HEI.22>>
        ShippingCostAllocLocal.Reset();
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", false);
        ShippingCostAllocLocal.SetRange("Only RPM Transportation", true);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Customer);
        ShippingCostAllocLocal.SetRange("Source Document", ShippingCostAllocLocal."Source Document"::"Sales Return Order");
        ShippingCostAllocLocal.SetFilter("Item Category Code", ItemCategFilter);
        ShippingCostAllocLocal.CalcSums("Picking Factor");
        PeriodPickingFactor += ShippingCostAllocLocal."Picking Factor";
        //HEI.22<<

        ShippingCostAllocLocal.Reset();
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", true);
        ShippingCostAllocLocal.SetRange("Only RPM Transportation", true);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Customer);
        ShippingCostAllocLocal.SetRange("Source Document", ShippingCostAllocLocal."Source Document"::"Sales Return Order");
        //ShippingCostAllocLocal.CalcSums("Net Weight (Kg)","Picking Factor");//HEI.22
        ShippingCostAllocLocal.CalcSums("Net Weight (Kg)");//HEI.22
        PeriodNetWeightOwnFleet += ShippingCostAllocLocal."Net Weight (Kg)";
        //PeriodPickingFactorOwnFleet += ShippingCostAllocLocal."Picking Factor";//HEI.22

        //HEI.22>>
        /*
        IF ShippingCostAllocLocal.FINDSET THEN
          REPEAT
            CalcDistanceAndDrops(ShippingCostAllocLocal);
          UNTIL ShippingCostAllocLocal.NEXT = 0;
        */

        ShippingCostAllocLocal.Reset();
        ShippingCostAllocLocal.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocLocal.SetRange("Own Fleet", true);
        ShippingCostAllocLocal.SetRange("Only RPM Transportation", true);
        ShippingCostAllocLocal.SetRange("Destination Type", ShippingCostAllocLocal."Destination Type"::Customer);
        ShippingCostAllocLocal.SetRange("Source Document", ShippingCostAllocLocal."Source Document"::"Sales Return Order");
        ShippingCostAllocLocal.SetFilter("Item Category Code", ItemCategFilter);
        ShippingCostAllocLocal.CalcSums("Picking Factor");
        PeriodPickingFactorOwnFleet += ShippingCostAllocLocal."Picking Factor";
        //HEI.22<<

        InsertTotalsShippAlloc();
        //HEI.14<<

    end;

    local procedure InsertTotalsShippAlloc();
    begin
        //HEI.14>>


        gRec_InsertTotals.SetRange("Period Date", FORMAT(StartingDate) + '..' + FORMAT(EndingDate));
        gRec_InsertTotals.SetRange("Own Fleet", true);
        gRec_InsertTotals.ModifyAll("Period Net Weight (Kg)", PeriodNetWeightOwnFleet, false);


        gRec_InsertTotals.SetRange("Period Date", FORMAT(StartingDate) + '..' + FORMAT(EndingDate));
        gRec_InsertTotals.SetRange("Own Fleet", true);
        gRec_InsertTotals.ModifyAll("Period Picking Factor", PeriodPickingFactorOwnFleet, false);

        gRec_InsertTotals.Reset();
        gRec_InsertTotals.SetRange("Period Date", FORMAT(StartingDate) + '..' + FORMAT(EndingDate));
        gRec_InsertTotals.SetRange("Own Fleet", true);
        gRec_InsertTotals.ModifyAll("Period Distance", PeriodDistance, false);

        gRec_InsertTotals.Reset();
        gRec_InsertTotals.SetRange("Period Date", FORMAT(StartingDate) + '..' + FORMAT(EndingDate));
        gRec_InsertTotals.SetRange("Own Fleet", true);
        gRec_InsertTotals.ModifyAll("Period Drop Counts", PeriodDrops, false);

        gRec_InsertTotals.Reset();
        gRec_InsertTotals.SetRange("Period Date", FORMAT(StartingDate) + '..' + FORMAT(EndingDate));
        gRec_InsertTotals.SetRange("Own Fleet", false);
        gRec_InsertTotals.ModifyAll("Period Net Weight (Kg)", PeriodNetWeight, false);


        gRec_InsertTotals.Reset();
        gRec_InsertTotals.SetRange("Period Date", FORMAT(StartingDate) + '..' + FORMAT(EndingDate));
        gRec_InsertTotals.SetRange("Own Fleet", false);
        gRec_InsertTotals.ModifyAll("Period Picking Factor", PeriodPickingFactor, false);
        //HEI.14<<
    end;

    local procedure InsertTempCustIT2();
    var
        ShipCostAllocation: Record "Shipping Cost Allocation FND";
    begin
        //for Delivery to customers
        ShipCostAllocation.Reset();
        ShipCostAllocation.SetRange("Posting Date", StartingDate, EndingDate);
        ShipCostAllocation.SetRange("Destination Type", ShipCostAllocation."Destination Type"::Customer);
        ShipCostAllocation.SetRange("Distribution Type", ShipCostAllocation."Distribution Type"::Total); //HEI.02
        ShipCostAllocation.SetRange("Only RPM Transportation", false);
        if ShipCostAllocation.FindSet(false) then
            repeat
                TempCustIT.Reset();
                TempCustIT.SetCurrentKey("Item No.");
                TempCustIT.SetRange("Item No.", ShipCostAllocation."Item No.");
                TempCustIT.SetRange("Lot No.", ShipCostAllocation."Lot No.");
                TempCustIT.SetRange("Location Code", ShipCostAllocation."Location Code");
                //HEI.23>>
                /*
                TempCustIT.SETRANGE("Own Fleet",ShipCostAllocation."Own Fleet"); //HEI.04
                */
                //HEI.23<<
                if not TempCustIT.FindFirst() then begin
                    TempCustIT.Init();
                    TempCustIT."Entry No." := ShipCostAllocation."Entry No.";
                    TempCustIT."Item No." := ShipCostAllocation."Item No.";
                    TempCustIT."Lot No." := ShipCostAllocation."Lot No.";
                    TempCustIT."Location Code" := ShipCostAllocation."Location Code";
                    TempCustIT."Own Fleet" := ShipCostAllocation."Own Fleet"; //HEI.04
                    TempCustIT."Period Net Weight SKU/Lot" := ShipCostAllocation."Net Weight (Kg)";
                    //HEI.22>>
                    TempCustIT."Period Picking Factor SKU/Lot" := ShipCostAllocation."Picking Factor";
                    //HEI.22<<

                    TempCustIT.INSERT();
                end else begin
                    TempCustIT."Period Net Weight SKU/Lot" += ShipCostAllocation."Net Weight (Kg)";
                    //HEI.22>>
                    TempCustIT."Period Picking Factor SKU/Lot" += ShipCostAllocation."Picking Factor";
                    //HEI.22<<
                    TempCustIT.MODIFY();
                end;
            until ShipCostAllocation.Next() = 0;

    end;

    local procedure Insert2RPMSKUMissingRec();
    var
        RPMSKU: Record "RPM - SKU Relationship FND";
        Qr_RPMSKUMissigComb: Query "C2S RPM SKU Add Missing Comb";
    begin
        //HEI.24 - deprecated. Replaced with Insert2RPMSKUMissingRecNew
        //HEI.18>>
        Qr_RPMSKUMissigComb.SetRange(FilterPeriodDate, FORMAT(StartingDate) + '..' + FORMAT(EndingDate));
        Qr_RPMSKUMissigComb.Open();
        while Qr_RPMSKUMissigComb.Read() do begin
            RPMSKU.SetRange("Period Date", FORMAT(StartingDate) + '..' + FORMAT(EndingDate));
            RPMSKU.SetRange("Linked Item No.", Qr_RPMSKUMissigComb.ItemNo);
            RPMSKU.SetRange("Customer No.", Qr_RPMSKUMissigComb.DestinationNo);
            if RPMSKU.FindSet() then
                repeat
                    RPMSKURelation.Reset();
                    if (not RPMSKURelation.Get(StartingDate, EndingDate, RPMSKU."RPM Item No.", RPMSKU."Linked Item No.", RPMSKU."Customer No.", Qr_RPMSKUMissigComb.OwnFleet))
                    //AND (Qr_RPMSKUMissigComb.SumNetWeightKg <> 0) //HEI.24
                    then begin
                        RPMSKURelation.Init();
                        RPMSKURelation."Period Start Date" := StartingDate;
                        RPMSKURelation."Period End Date" := EndingDate;

                        RPMSKURelation."RPM Item No." := RPMSKU."RPM Item No.";
                        RPMSKURelation."Item Category Code" := RPMSKU."Item Category Code";
                        RPMSKURelation."Linked Item No." := RPMSKU."Linked Item No.";
                        RPMSKURelation."Period Date" := RPMSKU."Period Date";
                        RPMSKURelation."Own Fleet" := Qr_RPMSKUMissigComb.OwnFleet;

                        RPMSKURelation."Customer No." := RPMSKU."Customer No.";

                        //HEI.22>> all the fileds that are calculate based on flowfields will updated for all records after insert. moved in SKU_RPM OnPostDataItem
                        /*
                        RPMSKURelation.CALCFIELDS("Period Alloc. Amount Customer","Primary Alloc. Amount Customer","Second. Alloc. Amount Customer","Period Net Weight Customer",
                                       "Period Gen. Overheads Cust.","Period Whse. Handling Cust.","Period Whse. Overheads Cust.","Period Picking Factor Cust.");
                        IF RPMSKURelation."Period Net Weight Customer" <> 0 THEN BEGIN
                          RPMSKURelation."Primary RPM Unit Cost Customer" := RPMSKURelation."Primary Alloc. Amount Customer" / RPMSKURelation."Period Net Weight Customer";
                          RPMSKURelation."Second. RPM Unit Cost Customer" := RPMSKURelation."Second. Alloc. Amount Customer" / RPMSKURelation."Period Net Weight Customer";
                        END;
                        IF RPMSKURelation."Period Picking Factor Cust." <> 0 THEN

                        RPMSKURelation.CALCFIELDS("Period Alloc. Amount Transfer","Primary Alloc. Amount Transfer","Second. Alloc. Amount Transfer","Period Net Weight Linked Item",
                                                  "Period Gen. Overheads IT","Period Whse. Overheads IT","Period Whse. Handling IT","Period Pick. Fact. Linked Item");
                        IF RPMSKURelation."Period Net Weight Linked Item" <> 0 THEN BEGIN
                          RPMSKURelation."Primary RPM Unit Cost Transfer" := RPMSKURelation."Primary Alloc. Amount Transfer" / RPMSKURelation."Period Net Weight Linked Item";
                          RPMSKURelation."Second. RPM Unit Cost Transfer" := RPMSKURelation."Second. Alloc. Amount Transfer" / RPMSKURelation."Period Net Weight Linked Item";
                        END;
                        */
                        //HEI.22<<
                        RPMSKURelation."Processing Date" := WorkDate();
                        if RPMSKURelation.Insert() then;
                    end;
                until RPMSKU.Next() = 0;
        end;
        Qr_RPMSKUMissigComb.Close();
        //HEI.18<<

    end;

    local procedure InsertNoOfLinesByDocItemCateg();
    var
        lQr_C2SToatlLinesByDocItemCateg: Query "C2S Total Lines By Doc&ItemCat";
        lEnrtyNo: Integer;
    begin
        //HEI.22>>
        lEnrtyNo := 1;
        Clear(NumberOfLines);
        Clear(lQr_C2SToatlLinesByDocItemCateg);
        lQr_C2SToatlLinesByDocItemCateg.SetRange(FilterPostingDate, StartingDate, EndingDate);
        lQr_C2SToatlLinesByDocItemCateg.Open();
        while lQr_C2SToatlLinesByDocItemCateg.Read() do begin
            /*
            gRec_C2STotalLinesByDocItemCategTmp.SETRANGE("No.",lQr_C2SToatlLinesByDocItemCateg.No);
            gRec_C2STotalLinesByDocItemCategTmp.SETRANGE("Item Category Code",lQr_C2SToatlLinesByDocItemCateg.Item_Category_Code);
            IF NOT gRec_C2STotalLinesByDocItemCategTmp.FINDFIRST THEN BEGIN
            */
            gRec_C2STotalLinesByDocItemCategTmp.Init();
            gRec_C2STotalLinesByDocItemCategTmp."Entry No." := lEnrtyNo;
            gRec_C2STotalLinesByDocItemCategTmp."No." := lQr_C2SToatlLinesByDocItemCateg.No;
            gRec_C2STotalLinesByDocItemCategTmp."Item Category Code" := lQr_C2SToatlLinesByDocItemCateg.Item_Category_Code;
            gRec_C2STotalLinesByDocItemCategTmp."Line No." := lQr_C2SToatlLinesByDocItemCateg.NoOfLines;
            if gRec_C2STotalLinesByDocItemCategTmp.Insert() then;
            lEnrtyNo += 1;
            //END;
        end;
        lQr_C2SToatlLinesByDocItemCateg.Close();
        //HEI.22<<

    end;

    local procedure UpdateRPMOverallocationNew();
    var
        Qr_C2SRPMSKUCust: Query "C2S RPM SKU RPM Item - Cust.";
        Qr_C2SRPMSKULinkedItem: Query "C2S RPM SKU RPM Item";
        Qr_C2SRPMSKUCustOverAlloc: Query "C2S RPM SKU Linked Item - Cust";
        Qr_C2SRPMSKULinkedItemOverAlloc: Query "C2S RPM SKU Linked Item";
        Qr_C2SRPMCalcFlowFields: Query "C2S RPM CalcFlowFields";
    begin
        //HEI.22>> optimization

        InsertRPM4Overallocation();
        InsertRPMCalcFlds4Overallocation(); //HEI.27 - this function inserts the value of the flowfields of RPM SKU

        //update for the couple (combination) RPM Item No. & Customer No. for the allocated period
        //update for the field RPM Item No. for the allocated period
        // step 1
        RPMSKURelation.Reset();
        RPMSKURelation.SetRange("Period Start Date", StartingDate);
        if RPMSKURelation.FindSet() then
            repeat
                //HEI.23>>
                //IF RPMSKURelation4OverallocationTmp.GET(0D,0D,RPMSKURelation."RPM Item No.",'',RPMSKURelation."Customer No.",RPMSKURelation."Own Fleet") THEN BEGIN
                if RPMSKURelation4OverallocationTmp.GET(0D, 0D, RPMSKURelation."RPM Item No.", '', RPMSKURelation."Customer No.", false) then begin
                    //HEI.23<<
                    RPMSKURelation."Period Net Weight Sold Cust." := RPMSKURelation4OverallocationTmp."Period Net Weight Sold Cust.";
                    RPMSKURelation."Period Pick. Factor Sold Cust." := RPMSKURelation4OverallocationTmp."Period Pick. Factor Sold Cust.";
                end;

                //HEI.23>>
                //IF RPMSKURelation4OverallocationTmp.GET(0D,0D,RPMSKURelation."RPM Item No.",'','',RPMSKURelation."Own Fleet") THEN BEGIN
                if RPMSKURelation4OverallocationTmp.GET(0D, 0D, RPMSKURelation."RPM Item No.", '', '', false) then begin
                    //HEI.23<<
                    RPMSKURelation."Period Net Weight Transf." := RPMSKURelation4OverallocationTmp."Period Net Weight Transf.";
                    RPMSKURelation."Period Pick. Factor Transf." := RPMSKURelation4OverallocationTmp."Period Pick. Factor Transf.";
                end;

                //HEI.27>>
                /*
                 Qr_C2SRPMCalcFlowFields.SETRANGE(Period_Start_Date,StartingDate);
                 Qr_C2SRPMCalcFlowFields.SETRANGE(Period_End_Date,EndingDate);
                 Qr_C2SRPMCalcFlowFields.SETRANGE(FilterRPMItemNo,RPMSKURelation."RPM Item No.");
                 Qr_C2SRPMCalcFlowFields.SETRANGE(FilterLinkedItemNo,RPMSKURelation."Linked Item No.");
                 Qr_C2SRPMCalcFlowFields.SETRANGE(FilterCustomerNo,RPMSKURelation."Customer No.");
                 Qr_C2SRPMCalcFlowFields.SETRANGE(FilterOwnFleet,RPMSKURelation."Own Fleet");
                 Qr_C2SRPMCalcFlowFields.OPEN;
                 Qr_C2SRPMCalcFlowFields.READ;

                 IF RPMSKURelation."Period Net Weight Sold Cust." <> 0 THEN BEGIN
                   RPMSKURelation."RPM Unit Cost Sold Cust."       := Qr_C2SRPMCalcFlowFields.Period_Alloc_Amount_Customer / RPMSKURelation."Period Net Weight Sold Cust.";
                   RPMSKURelation."RPM Gen. Over. Unit Cost Cust." := Qr_C2SRPMCalcFlowFields.Period_Gen_Overheads_Cust / RPMSKURelation."Period Net Weight Sold Cust.";
                   RPMSKURelation."RPM Whse. Over. Unit Cost Cust" := Qr_C2SRPMCalcFlowFields.Period_Whse_Overheads_Cust / RPMSKURelation."Period Net Weight Sold Cust.";

                 END;

                 IF RPMSKURelation."Period Pick. Factor Sold Cust." <> 0 THEN BEGIN
                   RPMSKURelation."RPM Whse. Hand Unit Cost Cust." :=  Qr_C2SRPMCalcFlowFields.Period_Whse_Handling_Cust / RPMSKURelation."Period Pick. Factor Sold Cust.";
                   //HEI.26<<
                   RPMSKURelation."OVE RPM Whs H Unit Cost Cust" :=  Qr_C2SRPMCalcFlowFields.OVE_Prd_Whse_Handling_Cust / RPMSKURelation."Period Pick. Factor Sold Cust.";
                   RPMSKURelation."TRP RPM Whs H Unit Cost Cust" :=  Qr_C2SRPMCalcFlowFields.TRP_Prd_Whse_Handling_Cust/ RPMSKURelation."Period Pick. Factor Sold Cust.";
                   RPMSKURelation."FIX RPM Whs H Unit Cost Cust" :=  Qr_C2SRPMCalcFlowFields.FIX_Prd_Whse_Handling_Cust / RPMSKURelation."Period Pick. Factor Sold Cust.";
                   //HEI.26>>

                 END;

                 IF RPMSKURelation."Period Net Weight Transf." <> 0 THEN BEGIN
                   RPMSKURelation."RPM Unit Cost Transferred"   := Qr_C2SRPMCalcFlowFields.Period_Alloc_Amount_Transfer / RPMSKURelation."Period Net Weight Transf.";
                   RPMSKURelation."RPM Gen. Over. Unit Cost T"  := Qr_C2SRPMCalcFlowFields.Period_Gen_Overheads_IT/ RPMSKURelation."Period Net Weight Transf.";
                   RPMSKURelation."RPM Whse. Over. Unit Cost T" := Qr_C2SRPMCalcFlowFields.Period_Whse_Overheads_IT / RPMSKURelation."Period Net Weight Transf.";
                 END;

                 IF RPMSKURelation."Period Pick. Factor Transf." <> 0 THEN BEGIN
                   RPMSKURelation."RPM Whse. Hand Unit Cost T." :=  Qr_C2SRPMCalcFlowFields.Period_Whse_Handling_IT / RPMSKURelation."Period Pick. Factor Transf.";
                   //HEI.26>>
                   RPMSKURelation."OVE RPM Whse. H Unit Cost T" :=  Qr_C2SRPMCalcFlowFields.OVE_Period_Whse_Handling_IT / RPMSKURelation."Period Pick. Factor Transf.";
                   RPMSKURelation."TRP RPM Whse. H Unit Cost T" :=  Qr_C2SRPMCalcFlowFields.TRP_Period_Whse_Handling_IT/ RPMSKURelation."Period Pick. Factor Transf.";
                   RPMSKURelation."FIX RPM Whse. H Unit Cost T" :=  Qr_C2SRPMCalcFlowFields.FIX_Period_Whse_Handling_IT / RPMSKURelation."Period Pick. Factor Transf.";
                   //HEI.26<<
                 END;
                 */

                SCACalcFldForSKURPMCustTmp.SetFilter("Period Date", RPMSKURelation."Period Date");
                SCACalcFldForSKURPMCustTmp.SetFilter("Destination No.", RPMSKURelation."Customer No.");
                SCACalcFldForSKURPMCustTmp.SetFilter("Item No.", RPMSKURelation."RPM Item No.");
                SCACalcFldForSKURPMCustTmp.SetFilter("Own Fleet", '%1', RPMSKURelation."Own Fleet");
                if SCACalcFldForSKURPMCustTmp.FindFirst() then begin
                    if RPMSKURelation."Period Net Weight Sold Cust." <> 0 then begin
                        RPMSKURelation."RPM Unit Cost Sold Cust." := SCACalcFldForSKURPMCustTmp."Primary Allocated Amount" / RPMSKURelation."Period Net Weight Sold Cust.";
                        RPMSKURelation."RPM Gen. Over. Unit Cost Cust." := SCACalcFldForSKURPMCustTmp."General Overheads" / RPMSKURelation."Period Net Weight Sold Cust.";
                        RPMSKURelation."RPM Whse. Over. Unit Cost Cust" := SCACalcFldForSKURPMCustTmp."Warehouse Overheads" / RPMSKURelation."Period Net Weight Sold Cust.";

                    end;

                    if RPMSKURelation."Period Pick. Factor Sold Cust." <> 0 then begin
                        RPMSKURelation."RPM Whse. Hand Unit Cost Cust." := SCACalcFldForSKURPMCustTmp."Warehouse Handling" / RPMSKURelation."Period Pick. Factor Sold Cust.";
                        //HEI.26<<
                        RPMSKURelation."OVE RPM Whs H Unit Cost Cust" := SCACalcFldForSKURPMCustTmp."OVE Warehouse Handling" / RPMSKURelation."Period Pick. Factor Sold Cust.";
                        RPMSKURelation."TRP RPM Whs H Unit Cost Cust" := SCACalcFldForSKURPMCustTmp."TRP Warehouse Handling" / RPMSKURelation."Period Pick. Factor Sold Cust.";
                        RPMSKURelation."FIX RPM Whs H Unit Cost Cust" := SCACalcFldForSKURPMCustTmp."FIX Warehouse Handling" / RPMSKURelation."Period Pick. Factor Sold Cust.";
                        //HEI.26>>
                    end;
                end;

                SCACalcFldForSKURPMITTmp.SETFILTER("Period Date", RPMSKURelation."Period Date");
                SCACalcFldForSKURPMITTmp.SETFILTER("Item No.", RPMSKURelation."RPM Item No.");
                SCACalcFldForSKURPMITTmp.SETFILTER("Own Fleet", '%1', RPMSKURelation."Own Fleet");
                if SCACalcFldForSKURPMITTmp.FINDFIRST() then begin
                    if RPMSKURelation."Period Net Weight Transf." <> 0 then begin
                        RPMSKURelation."RPM Unit Cost Transferred" := SCACalcFldForSKURPMITTmp."Primary Allocated Amount" / RPMSKURelation."Period Net Weight Transf.";
                        RPMSKURelation."RPM Gen. Over. Unit Cost T" := SCACalcFldForSKURPMITTmp."General Overheads" / RPMSKURelation."Period Net Weight Transf.";
                        RPMSKURelation."RPM Whse. Over. Unit Cost T" := SCACalcFldForSKURPMITTmp."Warehouse Overheads" / RPMSKURelation."Period Net Weight Transf.";
                    end;

                    if RPMSKURelation."Period Pick. Factor Transf." <> 0 then begin
                        RPMSKURelation."RPM Whse. Hand Unit Cost T." := SCACalcFldForSKURPMITTmp."Warehouse Handling" / RPMSKURelation."Period Pick. Factor Transf.";
                        //HEI.26>>
                        RPMSKURelation."OVE RPM Whse. H Unit Cost T" := SCACalcFldForSKURPMITTmp."OVE Warehouse Handling" / RPMSKURelation."Period Pick. Factor Transf.";
                        RPMSKURelation."TRP RPM Whse. H Unit Cost T" := SCACalcFldForSKURPMITTmp."TRP Warehouse Handling" / RPMSKURelation."Period Pick. Factor Transf.";
                        RPMSKURelation."FIX RPM Whse. H Unit Cost T" := SCACalcFldForSKURPMITTmp."FIX Warehouse Handling" / RPMSKURelation."Period Pick. Factor Transf.";
                        //HEI.26<<
                    end;
                end;
                //HEI.27<<

                RPMSKURelation.MODIFY();
            //Qr_C2SRPMCalcFlowFields.CLOSE; //HEI.27
            until RPMSKURelation.Next() = 0;


        //step 2
        RPMSKURelation.Reset();
        RPMSKURelation.SetRange("Period Start Date", StartingDate);
        if RPMSKURelation.FindSet() then
            repeat
                Qr_C2SRPMSKUCustOverAlloc.SetRange(FilterPeriodStartDate, StartingDate);
                Qr_C2SRPMSKUCustOverAlloc.SetRange(FilterLinkedItemNo, RPMSKURelation."Linked Item No.");
                Qr_C2SRPMSKUCustOverAlloc.SetRange(FilterCustomerNo, RPMSKURelation."Customer No.");
                //Qr_C2SRPMSKUCustOverAlloc.SetRange(FilterOwnFleet,RPMSKURelation."Own Fleet"); //HEI.23
                Qr_C2SRPMSKUCustOverAlloc.Open();
                while Qr_C2SRPMSKUCustOverAlloc.Read() do begin
                    RPMSKURelation."Period RPM Unit Cost Customer" := Qr_C2SRPMSKUCustOverAlloc.Sum_RPM_Unit_Cost_Sold_Cust;
                    RPMSKURelation."Period RPM Gen. Overh. Cust." := Qr_C2SRPMSKUCustOverAlloc.Sum_RPM_Gen_Over_Unit_Cost_Cus;
                    RPMSKURelation."Period RPM Whse. Overh. Cust." := Qr_C2SRPMSKUCustOverAlloc.Sum_RPM_Whse_Over_Unit_Cost_Cu;
                    RPMSKURelation."Period RPM Whse. Handl. Cust." := Qr_C2SRPMSKUCustOverAlloc.Sum_RPM_Whse_Hand_Unit_Cost_Cu;
                    //HEI.26>>
                    RPMSKURelation."OVE Prd. RPM Whse. Handl. Cust" := Qr_C2SRPMSKUCustOverAlloc.Sum_OVE_RPM_Whs_H_Unit_Cost_Cu;
                    RPMSKURelation."TRP Prd. RPM Whse. Handl. Cust" := Qr_C2SRPMSKUCustOverAlloc.Sum_TRP_RPM_Whs_H_Unit_Cost_Cu;
                    RPMSKURelation."FIX Prd. RPM Whse. Handl. Cust" := Qr_C2SRPMSKUCustOverAlloc.Sum_FIX_RPM_Whs_H_Unit_Cost_Cu;
                    //HEI.26<<
                end;
                Qr_C2SRPMSKUCustOverAlloc.Close();

                Qr_C2SRPMSKULinkedItemOverAlloc.SetRange(FilterPeriodStartDate, StartingDate);
                Qr_C2SRPMSKULinkedItemOverAlloc.SetRange(FilterLinkedItemNo, RPMSKURelation."Linked Item No."); //HEI.23
                                                                                                                //Qr_C2SRPMSKULinkedItemOverAlloc.SetRange(FilterOwnFleet,RPMSKURelation."Own Fleet");
                Qr_C2SRPMSKULinkedItemOverAlloc.Open();
                while Qr_C2SRPMSKULinkedItemOverAlloc.READ() do begin
                    RPMSKURelation."Period RPM Unit Cost Transfer" += Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Unit_Cost_Transferred;
                    RPMSKURelation."Period RPM Gen. Overh. IT" += Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Gen_Over_Unit_Cost_T;
                    RPMSKURelation."Period RPM Whse. Overh. IT" += Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Whse_Over_Unit_Cost_T;
                    RPMSKURelation."Period RPM Whse. Handl. IT" += Qr_C2SRPMSKULinkedItemOverAlloc.RPM_Whse_Hand_Unit_Cost_T;
                    //HEI.26>>
                    RPMSKURelation."OVE Prd. RPM Whse. Handl. IT" += Qr_C2SRPMSKULinkedItemOverAlloc.OVE_RPM_Whse_H_Unit_Cost_T;
                    RPMSKURelation."TRP Prd. RPM Whse. Handl. IT" += Qr_C2SRPMSKULinkedItemOverAlloc.TRP_RPM_Whse_H_Unit_Cost_T;
                    RPMSKURelation."FIX Prd. RPM Whse. Handl. IT" += Qr_C2SRPMSKULinkedItemOverAlloc.FIX_RPM_Whse_H_Unit_Cost_T;
                    //HEI.26<<
                end;
                Qr_C2SRPMSKULinkedItemOverAlloc.Close();

                RPMSKURelation.Modify();

            until RPMSKURelation.Next() = 0;
        //HEI.22<<

    end;

    local procedure InsertRPM4Overallocation();
    var
        Qr_C2SRPMSKULinkedItem: Query "C2S RPM SKU RPM Item";
        Qr_C2SRPMSKUCust: Query "C2S RPM SKU RPM Item - Cust.";
    begin
        //HEI.22>>
        Qr_C2SRPMSKULinkedItem.SetRange(FilterPeriodStartDate, StartingDate);
        Qr_C2SRPMSKULinkedItem.Open();
        while Qr_C2SRPMSKULinkedItem.Read() do begin
            //HEI.23>>
            //IF NOT RPMSKURelation4OverallocationTmp.GET(0D,0D,Qr_C2SRPMSKULinkedItem.RPM_Item_No,'','',Qr_C2SRPMSKULinkedItem.Own_Fleet) THEN BEGIN
            if not RPMSKURelation4OverallocationTmp.Get(0D, 0D, Qr_C2SRPMSKULinkedItem.RPM_Item_No, '', '', false) then begin
                //HEI.23<<
                RPMSKURelation4OverallocationTmp."Period Net Weight Transf." := Qr_C2SRPMSKULinkedItem.PeriodNetWeightLinkedItem;
                RPMSKURelation4OverallocationTmp."Period Pick. Factor Transf." := Qr_C2SRPMSKULinkedItem.PeriodPickFactLinkedItem;
                RPMSKURelation4OverallocationTmp."RPM Item No." := Qr_C2SRPMSKULinkedItem.RPM_Item_No;
                //RPMSKURelation4OverallocationTmp."Own Fleet"                    := Qr_C2SRPMSKULinkedItem.Own_Fleet; HEI.23
                RPMSKURelation4OverallocationTmp.Insert();
            end else begin
                RPMSKURelation4OverallocationTmp."Period Net Weight Transf." += Qr_C2SRPMSKULinkedItem.PeriodNetWeightLinkedItem;
                RPMSKURelation4OverallocationTmp."Period Pick. Factor Transf." += Qr_C2SRPMSKULinkedItem.PeriodPickFactLinkedItem;
                RPMSKURelation4OverallocationTmp.Modify();
            end;
        end;
        Qr_C2SRPMSKULinkedItem.Close();

        Qr_C2SRPMSKUCust.SetRange(FilterPeriodStartDate, StartingDate);
        Qr_C2SRPMSKUCust.Open();
        while Qr_C2SRPMSKUCust.Read() do begin
            //HEI.23>>
            //IF NOT RPMSKURelation4OverallocationTmp.GET(0D,0D,Qr_C2SRPMSKUCust.RPM_Item_No,'',Qr_C2SRPMSKUCust.Customer_No,Qr_C2SRPMSKUCust.Own_Fleet) THEN BEGIN
            if not RPMSKURelation4OverallocationTmp.Get(0D, 0D, Qr_C2SRPMSKUCust.RPM_Item_No, '', Qr_C2SRPMSKUCust.Customer_No, false) then begin
                //HEI.23<<
                RPMSKURelation4OverallocationTmp."Period Net Weight Sold Cust." := Qr_C2SRPMSKUCust.Sum_Period_Net_Weight_Customer;
                RPMSKURelation4OverallocationTmp."Period Pick. Factor Sold Cust." := Qr_C2SRPMSKUCust.Sum_Period_Picking_Factor_Cust;
                RPMSKURelation4OverallocationTmp."RPM Item No." := Qr_C2SRPMSKUCust.RPM_Item_No;
                RPMSKURelation4OverallocationTmp."Customer No." := Qr_C2SRPMSKUCust.Customer_No;
                //RPMSKURelation4OverallocationTmp."Own Fleet"    := Qr_C2SRPMSKUCust.Own_Fleet; HEI.23
                RPMSKURelation4OverallocationTmp.Insert();
            end else begin
                RPMSKURelation4OverallocationTmp."Period Net Weight Sold Cust." += Qr_C2SRPMSKUCust.Sum_Period_Net_Weight_Customer;
                RPMSKURelation4OverallocationTmp."Period Pick. Factor Sold Cust." += Qr_C2SRPMSKUCust.Sum_Period_Picking_Factor_Cust;
                RPMSKURelation4OverallocationTmp.Modify();
            end;
        end;
        Qr_C2SRPMSKUCust.Close();

        //HEI.22<<
    end;

    local procedure GetLinesNumberByDocItemCateg(DocNo: Code[20]; OnlyRPM: Boolean): Integer;
    var
        lNoOfLines: Integer;
    begin
        //HEI.22>>
        gRec_C2STotalLinesByDocItemCategTmp.Reset();
        gRec_C2STotalLinesByDocItemCategTmp.SetRange("No.", DocNo);
        if OnlyRPM then
            gRec_C2STotalLinesByDocItemCategTmp.SetFilter("Item Category Code", SalesReceivablesSetup."RPMRelatedItemCategoryCode FND")
        else
            gRec_C2STotalLinesByDocItemCategTmp.SetFilter("Item Category Code", InventorySetup."Finished Goods ItemCatCode FND");

        if gRec_C2STotalLinesByDocItemCategTmp.FindSet() then
            repeat
                lNoOfLines += gRec_C2STotalLinesByDocItemCategTmp."Line No.";
            until gRec_C2STotalLinesByDocItemCategTmp.Next() = 0;
        exit(lNoOfLines)
        //HEI.22<<
    end;

    local procedure UpdateRPMSKUFields();
    var
        Qr_C2SRPMCalcFlowFields: Query "C2S RPM CalcFlowFields";
    begin
        //HEI.22>>
        Qr_C2SRPMCalcFlowFields.SetRange(Period_Start_Date, StartingDate);
        Qr_C2SRPMCalcFlowFields.SetRange(Period_End_Date, EndingDate);
        Qr_C2SRPMCalcFlowFields.Open();
        while Qr_C2SRPMCalcFlowFields.Read() do begin
            if RPMSKURelation.Get(StartingDate, EndingDate, Qr_C2SRPMCalcFlowFields.RPM_Item_No, Qr_C2SRPMCalcFlowFields.Linked_Item_No, Qr_C2SRPMCalcFlowFields.Customer_No, Qr_C2SRPMCalcFlowFields.Own_Fleet)
            then begin
                if Qr_C2SRPMCalcFlowFields.Period_Net_Weight_Customer <> 0 then begin
                    RPMSKURelation."Primary RPM Unit Cost Customer" := Qr_C2SRPMCalcFlowFields.Primary_Alloc_Amount_Customer / Qr_C2SRPMCalcFlowFields.Period_Net_Weight_Customer;
                    RPMSKURelation."Second. RPM Unit Cost Customer" := Qr_C2SRPMCalcFlowFields.Second_Alloc_Amount_Customer / Qr_C2SRPMCalcFlowFields.Period_Net_Weight_Customer;
                end;

                if Qr_C2SRPMCalcFlowFields.Period_Net_Weight_Linked_Item <> 0 then begin
                    RPMSKURelation."Primary RPM Unit Cost Transfer" := Qr_C2SRPMCalcFlowFields.Primary_Alloc_Amount_Transfer / Qr_C2SRPMCalcFlowFields.Period_Net_Weight_Linked_Item;
                    RPMSKURelation."Second. RPM Unit Cost Transfer" := Qr_C2SRPMCalcFlowFields.Second_Alloc_Amount_Transfer / Qr_C2SRPMCalcFlowFields.Period_Net_Weight_Linked_Item;
                end;
                RPMSKURelation.Modify();
            end;
        end;
        Qr_C2SRPMCalcFlowFields.Close(); //HEI.24
    end;

    local procedure SCACalcFlowFields();
    var
        Qr_SCACalcFlowFields: Query "C2S SCA CalcFlowFields";
        ShippingCostLocal: Record "Shipping Cost Allocation FND";
    begin
        //HEI.28>> - deprecated
        /*
        //HEI.22>>
        Qr_SCACalcFlowFields.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Qr_SCACalcFlowFields.SetFilter(FilterItemCategoryCode, InventorySetup."Finished Goods Item Cat Code");
        Qr_SCACalcFlowFields.Open();
        while Qr_SCACalcFlowFields.Read() do begin
            //ShippingCostLocal.GET(Qr_SCACalcFlowFields.Entry_No); //HEI.26
            gRec_CalcDeliveryCustFieldsTmp.Init();
            if (Qr_SCACalcFlowFields.Period_Net_Weight_SKU_Lot < Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot)
              and (Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot <> 0)
            then begin
                gRec_CalcDeliveryCustFieldsTmp."Internal Transfer ST" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.ST_Transfers_per_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot;
                gRec_CalcDeliveryCustFieldsTmp."General Overheads ST" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.ST_Gen_Overh_per_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot;
                gRec_CalcDeliveryCustFieldsTmp."Warehouse Overheads ST" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.ST_Whse_Overh_per_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Net_Weight_SKU_Lot;
            end else begin
                if (Qr_SCACalcFlowFields.Period_Net_Weight_SKU_Lot <> 0) then begin
                    gRec_CalcDeliveryCustFieldsTmp."Internal Transfer ST" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.ST_Transfers_per_SKU_Lot / Qr_SCACalcFlowFields.Period_Net_Weight_SKU_Lot;
                    gRec_CalcDeliveryCustFieldsTmp."General Overheads ST" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.ST_Gen_Overh_per_SKU_Lot / Qr_SCACalcFlowFields.Period_Net_Weight_SKU_Lot;
                    gRec_CalcDeliveryCustFieldsTmp."Warehouse Overheads ST" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.ST_Whse_Overh_per_SKU_Lot / Qr_SCACalcFlowFields.Period_Net_Weight_SKU_Lot;
                end;
            end;

            if (Qr_SCACalcFlowFields.Period_Picking_Factor_SKU_Lot < Qr_SCACalcFlowFields.ST_Period_Pick_Factor_SKU_Lot)
              and (Qr_SCACalcFlowFields.ST_Period_Pick_Factor_SKU_Lot <> 0)
            then begin
                gRec_CalcDeliveryCustFieldsTmp."Warehouse Handling ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.ST_Whse_Hand_per_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Pick_Factor_SKU_Lot;
                //HEI.26>>
                gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Hand. ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.OVE_ST_Whse_Hand_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Pick_Factor_SKU_Lot;
                gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Hand. ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.TRP_ST_Whse_Hand_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Pick_Factor_SKU_Lot;
                gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Hand. ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.FIX_ST_Whse_Hand_SKU_Lot / Qr_SCACalcFlowFields.ST_Period_Pick_Factor_SKU_Lot;
                //HEI.26<<
            end else begin
                if (Qr_SCACalcFlowFields.Period_Picking_Factor_SKU_Lot <> 0) then begin
                    gRec_CalcDeliveryCustFieldsTmp."Warehouse Handling ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.ST_Whse_Hand_per_SKU_Lot / Qr_SCACalcFlowFields.Period_Picking_Factor_SKU_Lot;
                    //HEI.26>>
                    gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Hand. ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.OVE_ST_Whse_Hand_SKU_Lot / Qr_SCACalcFlowFields.Period_Picking_Factor_SKU_Lot;
                    gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Hand. ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.TRP_ST_Whse_Hand_SKU_Lot / Qr_SCACalcFlowFields.Period_Picking_Factor_SKU_Lot;
                    gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Hand. ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.FIX_ST_Whse_Hand_SKU_Lot / Qr_SCACalcFlowFields.Period_Picking_Factor_SKU_Lot;
                    //HEI.26<<
                end;
            end;


            gRec_CalcDeliveryCustFieldsTmp."RPM SO" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.Period_RPM_Unit_Cost_Customer;
            gRec_CalcDeliveryCustFieldsTmp."RPM ST" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.Period_RPM_Unit_Cost_Transfer;
            gRec_CalcDeliveryCustFieldsTmp."Gen. Overheads RPM SO" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.Period_RPM_Gen_Overh_Cust;
            gRec_CalcDeliveryCustFieldsTmp."Gen. Overheads RPM ST" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.Period_RPM_Gen_Overh_IT;
            gRec_CalcDeliveryCustFieldsTmp."Whse. Overheads RPM SO" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.Period_RPM_Whse_Overh_Cust;
            gRec_CalcDeliveryCustFieldsTmp."Whse. Overheads RPM ST" := Qr_SCACalcFlowFields.Net_Weight_Kg * Qr_SCACalcFlowFields.Period_RPM_Whse_Overh_IT;
            gRec_CalcDeliveryCustFieldsTmp."Whse. Handling RPM SO" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.Period_RPM_Whse_Handl_Cust;
            gRec_CalcDeliveryCustFieldsTmp."Whse. Handling RPM ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.Period_RPM_Whse_Handl_IT;
            //HEI.26>>
            gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Handling RPM SO" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.OVE_Prd_RPM_Whse_Handl_Cust;
            gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Handling RPM SO" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.TRP_Prd_RPM_Whse_Handl_Cust;
            gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Handling RPM SO" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.FIX_Prd_RPM_Whse_Handl_Cust;
            gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Handling RPM ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.OVE_Prd_RPM_Whse_Handl_IT;
            gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Handling RPM ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.TRP_Prd_RPM_Whse_Handl_IT;
            gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Handling RPM ST" := Qr_SCACalcFlowFields.Picking_Factor * Qr_SCACalcFlowFields.FIX_Prd_RPM_Whse_Handl_IT;
            //HEI.26<<
            gRec_CalcDeliveryCustFieldsTmp."Entry No." := Qr_SCACalcFlowFields.Entry_No;
            gRec_CalcDeliveryCustFieldsTmp.Insert(false);
        end;
        Qr_SCACalcFlowFields.Close();
        */
        //HEI.28<<
    end;

    local procedure Insert2RPMSKUMissingRecNew();
    var
        RPMSKU: Record "RPM - SKU Relationship FND";
        Qr_RPMSKUMissigComb: Query "C2S RPM SKU Add Missing Comb";
        ShippCostAlloc: Record "Shipping Cost Allocation FND";
        Qr_C2SBOMComponents: Query "C2S BOM Components";
    begin
        //HEI.24>>
        ProdBOMHeader.Reset();
        ProdBOMLine.Reset();
        ProdBOMLine.SetCurrentKey("No.", "Version Code");

        //HEI.25>>
        /*
        Qr_RPMSKUMissigComb.SETRANGE(FilterPeriodDate,FORMAT(StartingDate) + '..' + FORMAT(EndingDate));
        Qr_RPMSKUMissigComb.OPEN;
        WHILE Qr_RPMSKUMissigComb.READ DO BEGIN
        */
        //Qr_C2SBOMComponents.SETRANGE(FilterLinkedItemNo,Qr_RPMSKUMissigComb.ItemNo);
        //HEI.25<<
        Qr_C2SBOMComponents.SetRange(FilterLinkedItemNo, SKU_RPM."Item No.");
        Qr_C2SBOMComponents.Open();
        while Qr_C2SBOMComponents.Read() do begin
            //insert missing bom line
            ShippCostAlloc.SetRange("Item No.", Qr_C2SBOMComponents.ItemNo);
            ShippCostAlloc.SetRange("Posting Date", StartingDate, EndingDate);
            ShippCostAlloc.SetRange("Destination Type", ShippCostAlloc."Destination Type"::Customer);
            if ShippCostAlloc.FindFirst() then begin
                //HEI.25>>
                /*
                IF NOT RPMSKURelation.GET(StartingDate,EndingDate,Qr_C2SBOMComponents.ItemNo,Qr_C2SBOMComponents.Linked_Item_No,Qr_RPMSKUMissigComb.DestinationNo,Qr_RPMSKUMissigComb.OwnFleet) THEN BEGIN
                  RPMSKURelation.INIT;
                  RPMSKURelation."Period Start Date" := StartingDate;
                  RPMSKURelation."Period End Date" := EndingDate;
        
                  RPMSKURelation."RPM Item No." := Qr_C2SBOMComponents.ItemNo;
                  RPMSKURelation."Item Category Code" := Qr_RPMSKUMissigComb.ItemCategoryCode;
                  RPMSKURelation."Linked Item No." := Qr_C2SBOMComponents.Linked_Item_No;
                  RPMSKURelation."Period Date" := Qr_RPMSKUMissigComb.PeriodDate;
                  RPMSKURelation."Own Fleet" := Qr_RPMSKUMissigComb.OwnFleet;
                  RPMSKURelation."Customer No." := Qr_RPMSKUMissigComb.DestinationNo;
                  RPMSKURelation."Processing Date" := WORKDATE;
                  IF RPMSKURelation.INSERT THEN;
                  */
                if not RPMSKURelation.Get(StartingDate, EndingDate, Qr_C2SBOMComponents.ItemNo, Qr_C2SBOMComponents.Linked_Item_No, SKU_RPM."Destination No.", SKU_RPM."Own Fleet") then begin
                    InsertRPMSKU(Qr_C2SBOMComponents, false);
                    //HEI.25<<
                end;
            end;

            //insert assembly list
            if Qr_C2SBOMComponents.BOMComponentItemNo <> '' then begin
                ShippCostAlloc.SetRange("Item No.", Qr_C2SBOMComponents.BOMComponentItemNo);
                ShippCostAlloc.SetRange("Posting Date", StartingDate, EndingDate);
                ShippCostAlloc.SetRange("Destination Type", ShippCostAlloc."Destination Type"::Customer);
                if ShippCostAlloc.FindFirst() then begin
                    if not RPMSKURelation.Get(StartingDate, EndingDate, Qr_C2SBOMComponents.BOMComponentItemNo, Qr_C2SBOMComponents.Linked_Item_No, SKU_RPM."Destination No.", SKU_RPM."Own Fleet") then
                        InsertRPMSKU(Qr_C2SBOMComponents, true);
                end;
            end;
        end;
        Qr_C2SBOMComponents.Close();

        //HEI.25>>
        /*
        END;
        Qr_RPMSKUMissigComb.CLOSE;
        */
        //HEI.25<<

        //HEI.24<<

    end;

    local procedure InsertRPMSKU(Qr_C2SBOMComponents: Query "C2S BOM Components"; InsertAssemblyList: Boolean);
    begin
        //HEI.25>>
        RPMSKURelation.Init();
        RPMSKURelation."Period Start Date" := StartingDate;
        RPMSKURelation."Period End Date" := EndingDate;

        if InsertAssemblyList then
            RPMSKURelation."RPM Item No." := Qr_C2SBOMComponents.BOMComponentItemNo
        else
            RPMSKURelation."RPM Item No." := Qr_C2SBOMComponents.ItemNo;

        RPMSKURelation."Item Category Code" := SKU_RPM."Item Category Code";
        RPMSKURelation."Linked Item No." := Qr_C2SBOMComponents.Linked_Item_No;
        RPMSKURelation."Period Date" := SKU_RPM."Period Date";
        RPMSKURelation."Own Fleet" := SKU_RPM."Own Fleet";
        RPMSKURelation."Customer No." := SKU_RPM."Destination No.";
        RPMSKURelation."Processing Date" := WorkDate();
        if RPMSKURelation.Insert() then;
    end;

    local procedure SCACalcFlowFieldsNew();
    var
        Qr_C2SSCASTFields: Query "C2S SCA ST Fields";
        Qr_C2SSCASKUPrdUnitCostCust: Query "C2S SCA SKU Prd Unit Cost Cust";
        Qr_C2SSCASKUPrdUnitCostIT: Query "C2S SCA SKU Prd Unit Cost IT";
        Qr_C2SSCASKURPMFldCust: Query "C2S SCA SKU RPM Fld Cust";
        Qr_C2SSCASKURPMFldIT: Query "C2S SCA SKU RPM Fld IT";
        ShippingCostLocal: Record "Shipping Cost Allocation FND";
    begin
        //HEI.27>>
        Qr_C2SSCASTFields.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Qr_C2SSCASTFields.SetFilter(FilterItemCategoryCode, InventorySetup."Finished Goods ItemCatCode FND");
        Qr_C2SSCASTFields.Open();
        while Qr_C2SSCASTFields.Read() do begin
            ShippingCostLocal.Get(Qr_C2SSCASTFields.Entry_No);
            gRec_CalcDeliveryCustFieldsTmp.Init();
            if (ShippingCostLocal."Period Net Weight SKU/Lot" < Qr_C2SSCASTFields.ST_Period_Net_Weight_SKU_Lot)
              and (Qr_C2SSCASTFields.ST_Period_Net_Weight_SKU_Lot <> 0)
            then begin
                gRec_CalcDeliveryCustFieldsTmp."Internal Transfer ST" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASTFields.ST_Transfers_per_SKU_Lot / Qr_C2SSCASTFields.ST_Period_Net_Weight_SKU_Lot;
                gRec_CalcDeliveryCustFieldsTmp."General Overheads ST" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASTFields.ST_Gen_Overh_per_SKU_Lot / Qr_C2SSCASTFields.ST_Period_Net_Weight_SKU_Lot;
                gRec_CalcDeliveryCustFieldsTmp."Warehouse Overheads ST" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASTFields.ST_Whse_Overh_per_SKU_Lot / Qr_C2SSCASTFields.ST_Period_Net_Weight_SKU_Lot;
            end else begin
                if (ShippingCostLocal."Period Net Weight SKU/Lot" <> 0) then begin
                    gRec_CalcDeliveryCustFieldsTmp."Internal Transfer ST" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASTFields.ST_Transfers_per_SKU_Lot / ShippingCostLocal."Period Net Weight SKU/Lot";
                    gRec_CalcDeliveryCustFieldsTmp."General Overheads ST" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASTFields.ST_Gen_Overh_per_SKU_Lot / ShippingCostLocal."Period Net Weight SKU/Lot";
                    gRec_CalcDeliveryCustFieldsTmp."Warehouse Overheads ST" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASTFields.ST_Whse_Overh_per_SKU_Lot / ShippingCostLocal."Period Net Weight SKU/Lot";
                end;
            end;

            if (ShippingCostLocal."Period Picking Factor SKU/Lot" < Qr_C2SSCASTFields.ST_Period_Pick_Factor_SKU_Lot)
              and (Qr_C2SSCASTFields.ST_Period_Pick_Factor_SKU_Lot <> 0)
            then begin
                gRec_CalcDeliveryCustFieldsTmp."Warehouse Handling ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASTFields.ST_Whse_Hand_per_SKU_Lot / Qr_C2SSCASTFields.ST_Period_Pick_Factor_SKU_Lot;
                //HEI.26>>
                gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Hand. ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASTFields.OVE_ST_Whse_Hand_SKU_Lot / Qr_C2SSCASTFields.ST_Period_Pick_Factor_SKU_Lot;
                gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Hand. ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASTFields.TRP_ST_Whse_Hand_SKU_Lot / Qr_C2SSCASTFields.ST_Period_Pick_Factor_SKU_Lot;
                gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Hand. ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASTFields.FIX_ST_Whse_Hand_SKU_Lot / Qr_C2SSCASTFields.ST_Period_Pick_Factor_SKU_Lot;
                //HEI.26<<
            end else begin
                if (ShippingCostLocal."Period Picking Factor SKU/Lot" <> 0) then begin
                    gRec_CalcDeliveryCustFieldsTmp."Warehouse Handling ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASTFields.ST_Whse_Hand_per_SKU_Lot / ShippingCostLocal."Period Picking Factor SKU/Lot";
                    //HEI.26>>
                    gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Hand. ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASTFields.OVE_ST_Whse_Hand_SKU_Lot / ShippingCostLocal."Period Picking Factor SKU/Lot";
                    gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Hand. ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASTFields.TRP_ST_Whse_Hand_SKU_Lot / ShippingCostLocal."Period Picking Factor SKU/Lot";
                    gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Hand. ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASTFields.FIX_ST_Whse_Hand_SKU_Lot / ShippingCostLocal."Period Picking Factor SKU/Lot";
                    //HEI.26<<
                end;
            end;
            gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" := ShippingCostLocal."Net Weight (Kg)";
            gRec_CalcDeliveryCustFieldsTmp."Picking Factor" := ShippingCostLocal."Picking Factor";
            gRec_CalcDeliveryCustFieldsTmp."Entry No." := Qr_C2SSCASTFields.Entry_No;
            gRec_CalcDeliveryCustFieldsTmp.INSERT(false);
        end;
        Qr_C2SSCASTFields.Close();

        Qr_C2SSCASKUPrdUnitCostCust.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Qr_C2SSCASKUPrdUnitCostCust.SetFilter(FilterItemCategoryCode, InventorySetup."Finished Goods ItemCatCode FND");
        Qr_C2SSCASKUPrdUnitCostCust.Open();
        while Qr_C2SSCASKUPrdUnitCostCust.Read() do begin
            if gRec_CalcDeliveryCustFieldsTmp.Get(Qr_C2SSCASKUPrdUnitCostCust.Entry_No) then begin
                gRec_CalcDeliveryCustFieldsTmp."RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" * Qr_C2SSCASKUPrdUnitCostCust.Period_RPM_Unit_Cost_Customer;
                gRec_CalcDeliveryCustFieldsTmp.MODIFY(false);
            end else begin
                ShippingCostLocal.Get(Qr_C2SSCASKUPrdUnitCostCust.Entry_No);
                gRec_CalcDeliveryCustFieldsTmp.Init();
                gRec_CalcDeliveryCustFieldsTmp."RPM SO" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASKUPrdUnitCostCust.Period_RPM_Unit_Cost_Customer;
                gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" := ShippingCostLocal."Net Weight (Kg)";
                gRec_CalcDeliveryCustFieldsTmp."Picking Factor" := ShippingCostLocal."Picking Factor";
                gRec_CalcDeliveryCustFieldsTmp."Entry No." := Qr_C2SSCASKUPrdUnitCostCust.Entry_No;
                gRec_CalcDeliveryCustFieldsTmp.Insert(false);
            end;
        end;
        Qr_C2SSCASKUPrdUnitCostCust.Close();

        Qr_C2SSCASKUPrdUnitCostIT.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Qr_C2SSCASKUPrdUnitCostIT.SetFilter(FilterItemCategoryCode, InventorySetup."Finished Goods ItemCatCode FND");
        Qr_C2SSCASKUPrdUnitCostIT.Open();
        while Qr_C2SSCASKUPrdUnitCostIT.Read() do begin
            if gRec_CalcDeliveryCustFieldsTmp.Get(Qr_C2SSCASKUPrdUnitCostIT.Entry_No) then begin
                gRec_CalcDeliveryCustFieldsTmp."RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" * Qr_C2SSCASKUPrdUnitCostIT.Period_RPM_Unit_Cost_Trans;
                gRec_CalcDeliveryCustFieldsTmp.Modify(false);
            end else begin
                ShippingCostLocal.Get(Qr_C2SSCASKUPrdUnitCostIT.Entry_No);
                gRec_CalcDeliveryCustFieldsTmp.Init();
                gRec_CalcDeliveryCustFieldsTmp."RPM ST" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASKUPrdUnitCostIT.Period_RPM_Unit_Cost_Trans;
                gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" := ShippingCostLocal."Net Weight (Kg)";
                gRec_CalcDeliveryCustFieldsTmp."Picking Factor" := ShippingCostLocal."Picking Factor";
                gRec_CalcDeliveryCustFieldsTmp."Entry No." := Qr_C2SSCASKUPrdUnitCostCust.Entry_No;
                gRec_CalcDeliveryCustFieldsTmp.Insert(false);
            end;
        end;
        Qr_C2SSCASKUPrdUnitCostIT.Close();

        Qr_C2SSCASKURPMFldCust.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Qr_C2SSCASKURPMFldCust.SetFilter(FilterItemCategoryCode, InventorySetup."Finished Goods ItemCatCode FND");
        Qr_C2SSCASKURPMFldCust.Open();
        while Qr_C2SSCASKURPMFldCust.Read() do begin
            if gRec_CalcDeliveryCustFieldsTmp.Get(Qr_C2SSCASKURPMFldCust.Entry_No) then begin
                gRec_CalcDeliveryCustFieldsTmp."Gen. Overheads RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" * Qr_C2SSCASKURPMFldCust.Period_RPM_Gen_Overh_Cust;
                gRec_CalcDeliveryCustFieldsTmp."Whse. Overheads RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" * Qr_C2SSCASKURPMFldCust.Period_RPM_Whse_Overh_Cust;
                gRec_CalcDeliveryCustFieldsTmp."Whse. Handling RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Picking Factor" * Qr_C2SSCASKURPMFldCust.Period_RPM_Whse_Handl_Cust;
                gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Handling RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Picking Factor" * Qr_C2SSCASKURPMFldCust.OVE_Prd_RPM_Whse_Handl_Cus;
                gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Handling RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Picking Factor" * Qr_C2SSCASKURPMFldCust.TRP_Prd_RPM_Whse_Handl_Cus;
                gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Handling RPM SO" := gRec_CalcDeliveryCustFieldsTmp."Picking Factor" * Qr_C2SSCASKURPMFldCust.FIX_Prd_RPM_Whse_Handl_Cus;
                gRec_CalcDeliveryCustFieldsTmp.Modify(false);
            end else begin
                ShippingCostLocal.Get(Qr_C2SSCASKUPrdUnitCostIT.Entry_No);
                gRec_CalcDeliveryCustFieldsTmp.Init();
                gRec_CalcDeliveryCustFieldsTmp."Gen. Overheads RPM SO" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASKURPMFldCust.Period_RPM_Gen_Overh_Cust;
                gRec_CalcDeliveryCustFieldsTmp."Whse. Overheads RPM SO" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASKURPMFldCust.Period_RPM_Whse_Overh_Cust;
                gRec_CalcDeliveryCustFieldsTmp."Whse. Handling RPM SO" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASKURPMFldCust.Period_RPM_Whse_Handl_Cust;
                gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Handling RPM SO" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASKURPMFldCust.OVE_Prd_RPM_Whse_Handl_Cus;
                gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Handling RPM SO" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASKURPMFldCust.TRP_Prd_RPM_Whse_Handl_Cus;
                gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Handling RPM SO" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASKURPMFldCust.FIX_Prd_RPM_Whse_Handl_Cus;
                gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" := ShippingCostLocal."Net Weight (Kg)";
                gRec_CalcDeliveryCustFieldsTmp."Picking Factor" := ShippingCostLocal."Picking Factor";
                gRec_CalcDeliveryCustFieldsTmp."Entry No." := Qr_C2SSCASKUPrdUnitCostCust.Entry_No;
                gRec_CalcDeliveryCustFieldsTmp.Insert(false);
            end;
        end;
        Qr_C2SSCASKURPMFldCust.Close();

        Qr_C2SSCASKURPMFldIT.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Qr_C2SSCASKURPMFldIT.SetFilter(FilterItemCategoryCode, InventorySetup."Finished Goods ItemCatCode FND");
        Qr_C2SSCASKURPMFldIT.Open();
        while Qr_C2SSCASKURPMFldIT.Read() do begin
            if gRec_CalcDeliveryCustFieldsTmp.Get(Qr_C2SSCASKURPMFldIT.Entry_No) then begin
                gRec_CalcDeliveryCustFieldsTmp."Gen. Overheads RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" * Qr_C2SSCASKURPMFldIT.Period_RPM_Gen_Overh_IT;
                gRec_CalcDeliveryCustFieldsTmp."Whse. Overheads RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" * Qr_C2SSCASKURPMFldIT.Period_RPM_Whse_Overh_IT;
                gRec_CalcDeliveryCustFieldsTmp."Whse. Handling RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Picking Factor" * Qr_C2SSCASKURPMFldIT.Period_RPM_Whse_Handl_IT;
                gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Handling RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Picking Factor" * Qr_C2SSCASKURPMFldIT.OVE_Prd_RPM_Whse_Handl_IT;
                gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Handling RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Picking Factor" * Qr_C2SSCASKURPMFldIT.TRP_Prd_RPM_Whse_Handl_IT;
                gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Handling RPM ST" := gRec_CalcDeliveryCustFieldsTmp."Picking Factor" * Qr_C2SSCASKURPMFldIT.FIX_Prd_RPM_Whse_Handl_IT;
                gRec_CalcDeliveryCustFieldsTmp.Modify(false);
            end else begin
                ShippingCostLocal.Get(Qr_C2SSCASKURPMFldIT.Entry_No);
                gRec_CalcDeliveryCustFieldsTmp.Init();
                gRec_CalcDeliveryCustFieldsTmp."Gen. Overheads RPM ST" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASKURPMFldIT.Period_RPM_Gen_Overh_IT;
                gRec_CalcDeliveryCustFieldsTmp."Whse. Overheads RPM ST" := ShippingCostLocal."Net Weight (Kg)" * Qr_C2SSCASKURPMFldIT.Period_RPM_Whse_Overh_IT;
                gRec_CalcDeliveryCustFieldsTmp."Whse. Handling RPM ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASKURPMFldIT.Period_RPM_Whse_Handl_IT;
                gRec_CalcDeliveryCustFieldsTmp."OVE Whse. Handling RPM ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASKURPMFldIT.OVE_Prd_RPM_Whse_Handl_IT;
                gRec_CalcDeliveryCustFieldsTmp."TRP Whse. Handling RPM ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASKURPMFldIT.TRP_Prd_RPM_Whse_Handl_IT;
                gRec_CalcDeliveryCustFieldsTmp."FIX Whse. Handling RPM ST" := ShippingCostLocal."Picking Factor" * Qr_C2SSCASKURPMFldIT.FIX_Prd_RPM_Whse_Handl_IT;
                gRec_CalcDeliveryCustFieldsTmp."Net Weight (Kg)" := ShippingCostLocal."Net Weight (Kg)";
                gRec_CalcDeliveryCustFieldsTmp."Picking Factor" := ShippingCostLocal."Picking Factor";
                gRec_CalcDeliveryCustFieldsTmp."Entry No." := Qr_C2SSCASKURPMFldIT.Entry_No;
                gRec_CalcDeliveryCustFieldsTmp.Insert(false);
            end;
        end;
        Qr_C2SSCASKURPMFldIT.Close();
    end;

    local procedure InsertRPMCalcFlds4Overallocation();
    var
        Qr_SKURPMCust: Query "C2S SKU RPM CalcFlowFld Cust";
        Qr_SKURPMIT: Query "C2S SKU RPM CalcFlowFld IT";
        lEntryNo: Integer;
    begin
        Qr_SKURPMCust.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Qr_SKURPMCust.Open();
        while Qr_SKURPMCust.Read() do begin
            lEntryNo += 1;
            SCACalcFldForSKURPMCustTmp.Init();
            SCACalcFldForSKURPMCustTmp."Entry No." := lEntryNo;
            SCACalcFldForSKURPMCustTmp."Period Date" := Qr_SKURPMCust.Period_Date;
            SCACalcFldForSKURPMCustTmp."Destination No." := Qr_SKURPMCust.Destination_No;
            SCACalcFldForSKURPMCustTmp."Item No." := Qr_SKURPMCust.Item_No;
            SCACalcFldForSKURPMCustTmp."Own Fleet" := Qr_SKURPMCust.Own_Fleet;
            SCACalcFldForSKURPMCustTmp."Primary Allocated Amount" := Qr_SKURPMCust.Period_Alloc_Amount_Cust;
            SCACalcFldForSKURPMCustTmp."General Overheads" := Qr_SKURPMCust.Period_Gen_Overheads_Cust;
            SCACalcFldForSKURPMCustTmp."Warehouse Overheads" := Qr_SKURPMCust.Period_Whse_Overheads_Cust;
            SCACalcFldForSKURPMCustTmp."Warehouse Handling" := Qr_SKURPMCust.Period_Whse_Handling_Cust;
            SCACalcFldForSKURPMCustTmp."OVE Warehouse Handling" := Qr_SKURPMCust.OVE_Prd_Whse_Handling_Cust;
            SCACalcFldForSKURPMCustTmp."TRP Warehouse Handling" := Qr_SKURPMCust.TRP_Prd_Whse_Handling_Cust;
            SCACalcFldForSKURPMCustTmp."FIX Warehouse Handling" := Qr_SKURPMCust.FIX_Prd_Whse_Handling_Cust;
            SCACalcFldForSKURPMCustTmp.Insert(false);
        end;
        Qr_SKURPMCust.Close();

        lEntryNo := 0;
        Qr_SKURPMIT.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Qr_SKURPMIT.Open();
        while Qr_SKURPMIT.Read() do begin
            lEntryNo += 1;
            SCACalcFldForSKURPMITTmp.Init();
            SCACalcFldForSKURPMITTmp."Entry No." := lEntryNo;
            SCACalcFldForSKURPMITTmp."Period Date" := Qr_SKURPMIT.Period_Date;
            SCACalcFldForSKURPMITTmp."Item No." := Qr_SKURPMIT.Item_No;
            SCACalcFldForSKURPMITTmp."Own Fleet" := Qr_SKURPMIT.Own_Fleet;
            SCACalcFldForSKURPMITTmp."Primary Allocated Amount" := Qr_SKURPMIT.Period_Alloc_Amount_IT;
            SCACalcFldForSKURPMITTmp."General Overheads" := Qr_SKURPMIT.Period_Gen_Overheads_IT;
            SCACalcFldForSKURPMITTmp."Warehouse Overheads" := Qr_SKURPMIT.Period_Whse_Overheads_IT;
            SCACalcFldForSKURPMITTmp."Warehouse Handling" := Qr_SKURPMIT.Period_Whse_Handling_IT;
            SCACalcFldForSKURPMITTmp."OVE Warehouse Handling" := Qr_SKURPMIT.OVE_Prd_Whse_Handling_IT;
            SCACalcFldForSKURPMITTmp."TRP Warehouse Handling" := Qr_SKURPMIT.TRP_Prd_Whse_Handling_IT;
            SCACalcFldForSKURPMITTmp."FIX Warehouse Handling" := Qr_SKURPMIT.FIX_Prd_Whse_Handling_IT;
            SCACalcFldForSKURPMITTmp.Insert(false);
        end;
        Qr_SKURPMIT.Close();
    end;
}

