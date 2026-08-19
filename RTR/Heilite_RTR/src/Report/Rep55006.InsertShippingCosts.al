report 55006 "Insert Shipping Costs"
{
    // version HEI.21

    // HEI.01 CHG2095415 IBM BULIMC01 11.06.2021#new report created to insert the shipping costs
    // HEI.02 CHG2130188 IBM BULIMC01 13/10/2021 #new changes added
    // HEI.03 IBM BULIM01 IBM 04/11/2021
    //     #Net Weight should be calculated based on finished goods or only RPM goods
    //     #Add the next Local Variables to functions "FindNonRPMItems" and "CalcTotalNetWeight":
    //        #DocItem,PostedWhseShipmentLine,PostedWhseReceiptLine,SalesInvoiceLine,SalesCreditMemoLine and replace them where used
    // HEI.04 CHG2132177 BULIMC01 IBM 06/05/2022 # Own Fleet Allocation
    //   #make the Net Weight and Total Net Weight positive
    //   #make the Qty. Base UoM and Qty. HL negative
    //   #DocNo. length paramter changed to 20
    // HEI.05 CHG2152809 IBM BULIMC01 28/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //   #fill in the PeriodDate to mark the month of allocation
    // HEI.06 INC4122240 - CHG2159877 IBM NASTAA02 25/05/2022 # Please stop sending C2S allocation for previous periods to archived table
    //   # Removed code that archives the Shipping Cost Allocation
    // HEI.07 CHG2162842 IBM SAMANR01 20/06/202022 #C2S optimazation & archiving
    //   # Modify the code for optimized the execution time.
    //   # Temporary table used, GUIALLOWED added for disabled the window for JQ execution
    // HEI.08 CHG2162842 IBM SAMANR01 20/06/202022 #C2S optimazation
    //   # Enhance the Archive process in new function
    // HEI.09 CHG2162842 IBM SAMANR01 04/07/202022 #C2S optimazation
    //   # ValueEntry & ItemLedgEntry table variable mark as temp
    //   # PopulateTempValueEntry & PopulateTempItemLedgerEntry function introduce and add related code
    // HEI.10 CHG2165828 IBM SAMANR01 12/07/2022 #C2S job Permission issue
    //   # Add table 50208 & 50215 "rimd" permission on report property
    // HEI.11 CHG2162842 IBM SAMANR01 21/07/202022 #C2S optimazation
    //   # PostedWhseShipLine & PostedWhseReceiptLine table variable mark as temp
    //   # PostedWhseShipLine2 & PostedWhseReceiptLine2 table variable deleted
    //   # PopulateTempPostedWhseShipLine & PopulateTempPostedWhseReceiptLine function introduce and add related code
    //   # Bugfix
    // HEI.12 CHG2169207 IBM SISUM01 17/08/2022 #Bug fix - the sales returns were not inserted anymore in Shipping Cost Allocation
    //   # convert Cost Amount from Posted Document Shipping Cost table when currency is not equal with local currency - function GetCostAmount()
    // HEI.13 CHG2169207 IBM SISUM01 24/08/2022 #Bug fix - the sales returns were not inserted anymore in Shipping Cost Allocation
    //   # add processing date
    // HEI.14 CHG2169207 IBM SISUM01 25/08/2022 #Bug fix - Lot No. and Qty. (Base) were empty
    // HEI.15 CHG2169207 IBM SISUM01 22/09/2022 #Bug fix - NoOfDrops for Delivery to Customer
    // HEI.16 CHG2169207 IBM SISUM01 26/09/2022 #Bug fix - NoOfDrops for Location
    // HEI.17 CHG2177487 IBM SISUM01 17/10/2022 #Calculate "No. of Palltes" only for finish goods and RPM
    // HEI.18 CHG2178734 IBM SISUM01 07/11/2022 #Update formula for NoOfDrops and Distance
    //   # change the calc for posted shipment document cost when the currency <> '' - for optimization
    //   # change the filters for value entries
    //   # comment the splitlines because it's not used
    //   # add new functions InsertCurrencyFactor, InsertPostedShipDocCost2LCY
    // HEI.19 CHG2178734 IBM SISUM01 14/11/2022 #NoOfDrops and Distance claculated only for specific records that are meet the condition
    // HEI.20 CHG2185464 IBM SISUM01 19/12/2022 #optimization
    //   #delete dataItem Shipments and add dataItem ShipmentsNew
    //   #delete dataItem Returns and add dataItem RetrunsNew
    //   #add new function InsertShipments, InsertReturns
    // HEI.21 CHG2277600 IBM POENAB02 31.03.2025 C2S - reversed shipment scenarios EE
    //   #Modified functions and triggers: CheckReversedLines

    // BC Upgrade POENAB02: Original (HeiLite) report id 50521

    // POENAB02, 09.06.2026
    // BC changes to calculate based on Aptean BC standard

    Permissions = TableData "Posted Whse. Receipt Line" = rimd,
                  TableData "Posted Whse. Shipment Line" = rimd,
                  TableData "Shipping Cost Allocation FND" = rimd,
                  TableData "RPM - SKU Relationship FND" = rimd;
    ProcessingOnly = true;
    UseRequestPage = false;
    Caption = 'Insert Shipping Costs';
    ApplicationArea = All;

    dataset
    {
        dataitem(ShipmentsNew; "Integer")
        {
            DataItemTableView = sorting(Number);
            UseTemporary = true;

            trigger OnAfterGetRecord();
            begin
                CurrReport.Skip();
            end;

            trigger OnPostDataItem();
            begin
                //HEI.15>>
                ShippingAllocation.Reset();
                if ShippingAllocation.FindSet(false) then
                    repeat
                        //HEI.18>>
                        if ((StrPos(InventorySetup."Finished Goods ItemCatCode FND", ShippingAllocation."Item Category Code") <> 0) and (not ShippingAllocation."Only RPM Transportation"))
                          or
                          ((StrPos(SalesReceivSetup."RPMRelatedItemCategoryCode FND", ShippingAllocation."Item Category Code") <> 0) and (ShippingAllocation."Only RPM Transportation")
                          //HEI.19>>
                          and (ShippingAllocation."Source Document" <> ShippingAllocation."Source Document"::"Sales Order")
                          //HEI.19<<
                          )
                        then begin
                            //HEI.18<<
                            TmpCountDrops.SetRange("Linked Item No.", ShippingAllocation."No.");
                            ShippingAllocation."No. of Drops" := TmpCountDrops.Count();
                            ShippingAllocation.Modify();
                        end; //HEI.18
                    until ShippingAllocation.Next() = 0;
                //HEI.15<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.11>>
                Clear(PostedWhseShipLine);
                PopulateTempPostedWhseShipLine(StartingDate, EndingDate);
                //HEI.11<<

                InsertShipments();
            end;
        }
        dataitem(ReturnsNew; "Integer")
        {
            DataItemTableView = SORTING(Number);
            UseTemporary = true;

            trigger OnAfterGetRecord();
            begin
                CurrReport.Skip();
            end;

            trigger OnPostDataItem();
            begin
                //HEI.16>>
                ShippingAllocation.Reset();
                ShippingAllocation.SetRange("Destination Type", ShippingAllocation."Destination Type"::Customer);
                ShippingAllocation.SetRange("Own Fleet", true);
                ShippingAllocation.SetRange("Source Document", ShippingAllocation."Source Document"::"Sales Return Order");
                if ShippingAllocation.FindSet(false) then
                    repeat
                        //HEI.18>>
                        if ((StrPos(InventorySetup."Finished Goods ItemCatCode FND", ShippingAllocation."Item Category Code") <> 0) and (not ShippingAllocation."Only RPM Transportation"))
                          or
                          ((StrPos(SalesReceivSetup."RPMRelatedItemCategoryCode FND", ShippingAllocation."Item Category Code") <> 0) and (ShippingAllocation."Only RPM Transportation")
                          //HEI.19>>
                          and (ShippingAllocation."Source Document" <> ShippingAllocation."Source Document"::"Sales Order")
                          //HEI.19<<
                          )
                        then begin
                            //HEI.18<<
                            TmpCountDrops.SetRange("Linked Item No.", ShippingAllocation."No.");
                            ShippingAllocation."No. of Drops" := TmpCountDrops.Count();
                            ShippingAllocation.Modify();
                        end; //HEI.18
                    until ShippingAllocation.Next() = 0;
                //HEI.16<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.11>>
                CLEAR(PostedWhseReceiptLine);
                PopulateTempPostedWhseReceiptLine(StartingDate, EndingDate);
                //HEI.11<<

                InsertReturns(); //HEI.20
            end;
        }
        dataitem(Transfers; "Posted Whse. Shipment Line")
        {
            DataItemTableView = SORTING("Source Document", "Source No.") ORDER(Ascending) WHERE("Source Document" = CONST("Outbound Transfer"));

            trigger OnAfterGetRecord();
            begin
                if GuiAllowed then begin //HEI.07<<
                    Counter3 += 1;
                    if Counter3 >= NoOfRecProgress3 then begin
                        NoOfProgresed3 := NoOfProgresed3 + Counter3;
                        Window.Update(3, ROUND(NoOfProgresed3 / NoOfRecords3 * 10000, 1));
                        Counter3 := 0;
                        TimeProgress3 := Time;
                    end;
                end;
                InsertDoc := false;

                Item.Get("Item No.");
                if (not FindNonRPMItems("No.", DocType::Shipment)) or (StrPos(InventorySetup."Finished Goods ItemCatCode FND", Item."Item Category Code") <> 0) then
                    InsertDoc := true
                else begin
                    // BC Upgrade POENAB02>>
                    // Code commented, as Posted Document Shipping Cost belongs to Aptean
                    /*
                    //if other category code, then check the Posted Doc. shipp. cost
                    PostedDocumentShippingCost.Reset();
                    PostedDocumentShippingCost.SetRange("Source No.", "No.");
                    if PostedDocumentShippingCost.FindFirst then
                        InsertDoc := true;
                    */
                    // BC Upgrade POENAB02<<
                    //POENAB02, 09.06.2026>>
                    PostedTradeCostOrderAPS.Reset();
                    PostedTradeCostOrderAPS.SetRange("Posted Whse. Shipment No.", "No.");
                    if PostedTradeCostOrderAPS.FindFirst() then
                        InsertDoc := true;
                    //POENAB02, 09.06.2026<<
                end;

                if InsertDoc then begin
                    ItemLedgEntry.SetCurrentKey("Posting Date", "Document No.", "Document Line No.", "Location Code");
                    ItemLedgEntry.SetRange("Posting Date", "Posting Date");
                    ItemLedgEntry.SetRange("Document No.", "Posted Source No.");
                    ItemLedgEntry.SetRange("Document Line No.", "Source Line No.");
                    ItemLedgEntry.SetRange("Location Code", "Location Code");
                    if ItemLedgEntry.FindSet(false) then
                        repeat //HEI.07>>
                            ShippingAllocation.INIT();
                            //HEI.07>>
                            //ShippingAllocation."Entry No." := FindLastAllocated;
                            EntryNo := EntryNo + 1;
                            ShippingAllocation."Entry No." := EntryNo;
                            //HEI.07<<
                            ShippingAllocation."Item Category Code" := ItemLedgEntry."Item Category Code";
                            ShippingAllocation."Posting Date" := "Posting Date";
                            ShippingAllocation."No." := "No.";
                            ShippingAllocation."Line No." := "Line No.";
                            ShippingAllocation."Source Document" := ShippingAllocation."Source Document"::"Outbound Transfer";
                            ShippingAllocation."Source No." := "Source No.";
                            ShippingAllocation."Source Line No." := "Source Line No.";
                            ShippingAllocation."Item No." := "Item No.";
                            ShippingAllocation."Unit of Measure Code" := "Unit of Measure Code";
                            ShippingAllocation."Posted Source Document" := ShippingAllocation."Posted Source Document"::"Posted Transfer Shipment";
                            ShippingAllocation."Posted Source Document No." := "Posted Source No.";
                            ShippingAllocation."Destination Type" := "Destination Type".AsInteger();
                            ShippingAllocation."Destination No." := "Destination No.";
                            ShippingAllocation."Location Code" := "Location Code";
                            ShippingAllocation.Description := Description;
                            ShippingAllocation."Period Date" := Format(StartingDate) + '..' + Format(EndingDate); //HEI.05

                            if FindNonRPMItems("No.", DocType::Shipment) then
                                ShippingAllocation."Only RPM Transportation" := false
                            else
                                ShippingAllocation."Only RPM Transportation" := true;

                            ShippingAllocation."Dimension Set ID" := ItemLedgEntry."Dimension Set ID";

                            ShippingAllocation."Lot No." := ItemLedgEntry."Lot No.";
                            ShippingAllocation."Lot No. & Destination No." := ShippingAllocation."Lot No." + ShippingAllocation."Destination No.";
                            ShippingAllocation."Lot No. & Location Code" := ShippingAllocation."Lot No." + ShippingAllocation."Location Code";
                            ShippingAllocation."Quantity (Base UoM)" := -ItemLedgEntry.Quantity;
                            ShippingAllocation."Quantity HL" := -CalculateQtyHL(ItemLedgEntry);

                            //Net Weight
                            if (ShippingAllocation."Only RPM Transportation") or (StrPos(InventorySetup."Finished Goods ItemCatCode FND", ItemLedgEntry."Item Category Code") <> 0) then begin //HEI.03
                                CheckNetWeight("Item No.");
                                //ShippingAllocation."Total Net Weight (Kg)" := CalcTotalNetWeight(ShippingAllocation."No.",DocType::Shipment,ShippingAllocation."Only RPM Transportation"); //HEI.04
                                //ShippingAllocation."Net Weight (Kg)" := CalcNetWeight(ShippingAllocation."Item No.",ShippingAllocation."Quantity (Base UoM)"); //HEI.04
                                //HEI.04<<
                                ShippingAllocation."Total Net Weight (Kg)" := Abs(CalcTotalNetWeight(ShippingAllocation."No.", DocType::Shipment, ShippingAllocation."Only RPM Transportation"));
                                ShippingAllocation."Net Weight (Kg)" := Abs(CalcNetWeight(ShippingAllocation."Item No.", ShippingAllocation."Quantity (Base UoM)"));
                                //HEI.04>>
                            end; //HEI.03

                            //HEI.02
                            if CheckReversedLines(ShippingAllocation."No.", DocType::Shipment, ShippingAllocation."Item No.") = 0 then begin
                                ShippingAllocation.Reversed := true;
                                ShippingAllocation."Quantity (Base UoM)" := 0;
                                ShippingAllocation."Net Weight (Kg)" := 0;
                            end;
                            //HEI.02

                            //get info from Posted Doc. shipping Cost
                            GetDocShipCostDetails(ShippingAllocation, true);

                            //HEI.04<<
                            PostedWhseShipmentHeader.Reset();
                            PostedWhseShipmentHeader.Get("No.");
                            ShippingAllocation."Shipping Agent Code" := PostedWhseShipmentHeader."Shipping Agent Code";
                            ShippingAllocation."Shipping Agent Service Code" := PostedWhseShipmentHeader."Shipping Agent Service Code";
                            //BC Upgrade POENAB02>>
                            //code commented, as Route and Route Planning No. belong to Aptean
                            /*
                            ShippingAllocation.Route := PostedWhseShipmentHeader.Route;
                            ShippingAllocation."Route Planning No." := PostedWhseShipmentHeader."Route Planning No.";
                            */
                            //BC Upgrade POENAB02<<
                            //POENAB02, 09.06.2026>>
                            ShippingAllocation.Route := PostedWhseShipmentHeader."Route 107FDW";
                            ShippingAllocation."Route Planning No." := PostedWhseShipmentHeader."Route Planning No. 107FDW";
                            //POENAB02, 09.06.2026<<

                            ShippingAgent.Reset();
                            if ShippingAgent.Get(ShippingAllocation."Shipping Agent Code") then
                                ShippingAllocation."Own Fleet" := ShippingAgent."Own Logistics FND";
                            if ShippingAllocation."Own Fleet" then begin
                                //HEI.18>>
                                if ((StrPos(InventorySetup."Finished Goods ItemCatCode FND", ShippingAllocation."Item Category Code") <> 0) and (not ShippingAllocation."Only RPM Transportation"))
                                  or
                                  ((StrPos(SalesReceivSetup."RPMRelatedItemCategoryCode FND", ShippingAllocation."Item Category Code") <> 0) and (ShippingAllocation."Only RPM Transportation")
                                  //HEI.19>>
                                  and (ShippingAllocation."Source Document" <> ShippingAllocation."Source Document"::"Sales Order")
                                  //HEI.19<<
                                  )
                                then begin
                                    // BC Upgrade POENAB02>>
                                    // code commented, as Distance belong to Aptean
                                    /* 
                                    //HEI.18<<
                                    if PostedWhseShipmentHeader.Distance <> 0 then
                                        ShippingAllocation.Distance := PostedWhseShipmentHeader.Distance
                                    else
                                        ShippingAllocation.Distance := GetReceiptDistance(ShippingAllocation."Posted Source Document No.");
                                    ShippingAllocation."No. of Drops" := CountDrops(ShippingAllocation);
                                     */
                                    //BC Upgrade POENAB02>>                                 
                                    //POENAB02, 09.06.2026>>
                                    ShippingAllocation."No. of Drops" := CountDrops(ShippingAllocation);
                                    //POENAB02, 09.06.2026<<
                                end; //HEI.18
                            end;
                            //HEI.04>>

                            //get picking factor
                            // BC upgrade POENAB02>>
                            // code commented, as InventorySetup.Pallet belongs to Aptean
                            /*
                            if ItemUnitofMeasure.Get(ShippingAllocation."Item No.", InventorySetup.Pallet) then
                                ShippingAllocation."No. of Pallets" := ShippingAllocation."Quantity (Base UoM)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                            */
                            // BC upgrade POENAB02<< 
                            //POENAB02, 09.06.2026>>
                            if ItemUnitofMeasure.Get(ShippingAllocation."Item No.", DrinkITFoundationSetup."Pallet Unit Of Measure") then
                                ShippingAllocation."No. of Pallets" := ShippingAllocation."Quantity (Base UoM)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                            //POENAB02, 09.06.2026<< 
                            if (ShippingAllocation."No. of Pallets" mod 1 = 0) then
                                ShippingAllocation."Picking Factor" := ShippingAllocation."No. of Pallets"
                            else
                                ShippingAllocation."Picking Factor" := (ShippingAllocation."No. of Pallets" div 1) + WhseSetup."Picking Coeff. Non-Pallet FND";

                            if ShippingAllocation."Total Net Weight (Kg)" <> 0 then
                                ShippingAllocation."Primary Allocated Amount" := ABS((ShippingAllocation."Net Weight (Kg)" * ShippingAllocation."Total Shipping Cost Amount") / ShippingAllocation."Total Net Weight (Kg)");

                            if (not ShippingAllocation."Only RPM Transportation") and (ShippingAllocation."Lot No." <> '') and (ShippingAllocation."Source Document" = ShippingAllocation."Source Document"::"Outbound Transfer") then
                                FindOriginalLotDestination(ShippingAllocation);

                            ShippingAllocation."Distribution Type" := ShippingAllocation."Distribution Type"::Total; //HEI.02

                            //HEI.13>>
                            ShippingAllocation."Processing Date" := WorkDate();
                            //HEI.13<<

                            //POENAB02, 06.08.2026, BCUP0-247>>
                            ShippingAllocation."Cost Center Code" := PostedTradeCostOrderAPS."Cost Center Code";
                            ShippingAllocation."Posted Whse. Shipment No." := PostedTradeCostOrderAPS."Posted Whse. Shipment No.";
                            ShippingAllocation."Posted Whse. Receipt No." := PostedTradeCostOrderAPS."Posted Whse. Receipt No.";
                            //POENAB02, 06.08.2026, BCUP0-247<<
                            ShippingAllocation.Insert();
                            //HEI.18>> for the moment always is FALSE. It doesn't make sense to do it. Save some milisec
                            /*
                            IF Split THEN
                              InsertChildLines(ShippingAllocation,TRUE); //HEI.02
                            */
                            //HEI.18<<
                            Inserted := true;
                        until ItemLedgEntry.Next() = 0;
                end;
            end;

            trigger OnPreDataItem();
            begin
                SetRange("Posting Date", StartingDate, EndingDate);
                if GuiAllowed then begin //HEI.07<<
                    NoOfRecords3 := Count();
                    NoOfRecProgress3 := NoOfRecords3 div 100;
                    Counter3 := 0;
                    NoOfProgresed3 := 0;
                    TimeProgress3 := Time();

                end;

                ItemLedgEntry.Reset(); //HEI.20
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
                        ApplicationArea = All;
                        ToolTip = 'Specifies the starting date for the period to insert shipping costs.';
                    }
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the ending date for the period to insert shipping costs.';
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
        if GuiAllowed then //HEI.07<<
            Window.Close();

        //HEI.07>>
        ShippingAllocation.Reset();
        if ShippingAllocation.FindSet(false) then
            repeat
                gRec_ShippingAllocation.Init();
                gRec_ShippingAllocation.TransferFields(ShippingAllocation);
                gRec_ShippingAllocation.Insert();
            until ShippingAllocation.Next() = 0;
        //HEI.07<<

        //HEI.09>>
        Clear(ShippingAllocation);
        Clear(ValueEntry);
        Clear(ItemLedgEntry);
        //HEI.09<<
        //HEI.11>>
        Clear(PostedWhseReceiptLine);
        Clear(PostedWhseShipLine);
        //HEI.11<<
    end;

    trigger OnPreReport();
    begin
        SalesReceivSetup.Get();
        InventorySetup.Get();
        WhseSetup.Get();
        DrinkITFoundationSetup.Get();

        //HEI.06>>
        //MoveToArchive; //HEI.02
        RemoveOldShipCostEntries();
        //HEI.06<<

        //HEI.18>> for the moment always is FALSE. It doesn't make sense to do it. Save some milisec
        /*
        GetSplitFilters; //HEI.04
        */
        //HEI.18<<

        if GuiAllowed then //HEI.07<<
            Window.Open(Text002 + Text003 + Text004);

        //HEI.07>>
        EntryNo := FindLastAllocated();
        Clear(ShippingAllocation);
        //HEI.07<<

        //HEI.09>>
        Clear(ValueEntry);
        Clear(ItemLedgEntry);
        PopulateTempValueEntry(StartingDate, EndingDate);
        PopulateTempItemLedgerEntry(StartingDate, EndingDate);
        //HEI.09<<

        //HEI.18>>
        Currency.InitRoundingPrecision();
        InsertCurrencyFactor();
        InsertPostedShipDocCost2LCY();
        //HEI.18<<

    end;

    var
        StartingDate: Date;
        EndingDate: Date;
        Inserted: Boolean;
        ShippingAllocation: Record "Shipping Cost Allocation FND" temporary;
        WhseSetup: Record "Warehouse Setup";
        SalesReceivSetup: Record "Sales & Receivables Setup";
        DrinkITFoundationSetup: Record FoundationSetup101FDW;
        Text001: Label 'Shipping costs have been successfully inserted!';
        InventorySetup: Record "Inventory Setup";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Text002: Label 'Inserting Delivery to customers       @1@@@@@@@@@@@ \';
        Window: Dialog;
        NoOfRecords: Integer;
        NoOfRecProgress: Integer;
        NoOfProgresed: Integer;
        Counter: Integer;
        TimeProgress: Time;
        Text003: Label 'Inserting RPM Transports     @2@@@@@@@@@@@ \';
        Item: Record Item;
        ValueEntry: Record "Value Entry" temporary;
        SalesInvLine: Record "Sales Invoice Line";
        Found: Boolean;
        ItemLedgEntry: Record "Item Ledger Entry" temporary;
        Text004: Label 'Inserting Internal Transfers     @3@@@@@@@@@@@ \';
        NoOfRecords2: Integer;
        NoOfRecProgress2: Integer;
        NoOfProgresed2: Integer;
        Counter2: Integer;
        TimeProgress2: Time;
        NoOfRecords3: Integer;
        NoOfRecProgress3: Integer;
        NoOfProgresed3: Integer;
        Counter3: Integer;
        TimeProgress3: Time;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        DocType: Option " ",Shipment,Return,Invoice,"Credit Memo";
        InsertDoc: Boolean;
        // BC Upgrade POENAB02>>
        // code commented, as "Posted Document Shipping Cost" belongs to Aptean
        // PostedDocumentShippingCost: Record "Posted Document Shipping Cost";
        // BC Upgrade POENAB02<<
        //POENAB02, 09.06.2026>>
        PostedTradeCostOrderAPS: Record "Posted Trade Cost Order APS";
        //POENAB02, 09.06.2026<<
        PostedWhseShipLine: Record "Posted Whse. Shipment Line" temporary;
        SalesInvLine2: Record "Sales Invoice Line";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line" temporary;
        WhseCostAllocationSetup: Record "Whse. Cost Alloc Setup FND";
        ShippingAgent: Record "Shipping Agent";
        PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";
        PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
        PrimaryChargeNoFilter: Text;
        SecondaryChargeNoFilter: Text;
        Split: Boolean;
        EntryNo: Integer;
        gRec_ShippingAllocation: Record "Shipping Cost Allocation FND";
        TmpCountDrops: Record "RPM - SKU Relationship FND" temporary;
        TmpCurrencyFactor: Record Currency temporary;
        Currency: Record Currency;
        // BC Upgrade POENAB02>>
        // Code commented, as "Posted Document Shipping Cost" belongs to Aptean
        //TmpPostedShipDocCost2LCY: Record "Posted Document Shipping Cost" temporary;
        // BC Upgrade POENAB02<<
        //POENAB02, 09.06.2026>>
        TmpPostedShipDocCost2LCY: Record "Posted Trade Cost Order APS";
        //POENAB02, 09.06.2026<<
        FilterRPMItemCategoryAnd: Text[250];
        FindNonRPMItemBool: Boolean;

    local procedure CheckNetWeight(ItemNo: Code[20]);
    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Item: Record Item;
        Text50001: Label 'Base UoM (%1) of Item No. %2 has the Unit of Weight %3. It cannot be different than %4 or %5.';
        Text50002: Label 'Net Weight must not be blank for Base UoM (%1) of Item No. %2.';
    begin
        Item.Get(ItemNo);
        ItemUnitofMeasure.Get(Item."No.", Item."Base Unit of Measure");
        if (WhseSetup."Net Weight UoM (G) FND" <> '') and (WhseSetup."Net Weight UoM (Kg) FND" <> '') then
            if (ItemUnitofMeasure."Unit of Weight FND" <> WhseSetup."Net Weight UoM (G) FND") and (ItemUnitofMeasure."Unit of Weight FND" <> WhseSetup."Net Weight UoM (Kg) FND") then
                if ItemUnitofMeasure."Unit of Weight FND" <> '' then
                    Error(Text50001, Item."Base Unit of Measure", Item."No.", ItemUnitofMeasure."Unit of Weight FND", WhseSetup."Net Weight UoM (G) FND", WhseSetup."Net Weight UoM (Kg) FND")
                else
                    Error(Text50001, Item."Base Unit of Measure", Item."No.", 'blank', WhseSetup."Net Weight UoM (G) FND", WhseSetup."Net Weight UoM (Kg) FND");
        if ItemUnitofMeasure."Net Weight FND" = 0 then
            Error(Text50002, Item."Base Unit of Measure", Item."No.");
    end;

    procedure FindNonRPMItems(DocNo: Code[20]; DocType: Option " ",Shipment,Return,Invoice,"Credit Memo"): Boolean;
    var
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        PostedWhseShipLine: Record "Posted Whse. Shipment Line";
        DocItem: Record Item;
        PostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
    begin
        case DocType of
            DocType::Shipment:
                begin
                    PostedWhseShipmentLine.Reset();
                    PostedWhseShipmentLine.SetRange("No.", DocNo);
                    if PostedWhseShipmentLine.FindSet(false) then
                        repeat //HEI.07>>
                            DocItem.Get(PostedWhseShipmentLine."Item No.");
                            if STRPOS(SalesReceivSetup."RPMRelatedItemCategoryCode FND", DocItem."Item Category Code") = 0 then
                                exit(true);
                        until PostedWhseShipmentLine.Next() = 0;
                end;

            DocType::Return:
                begin
                    PostedWhseReceiptLine.Reset();
                    PostedWhseReceiptLine.SetRange("No.", DocNo);
                    if PostedWhseReceiptLine.FindSet(false) then
                        repeat //HEI.07>>
                            DocItem.Get(PostedWhseReceiptLine."Item No.");
                            if StrPos(SalesReceivSetup."RPMRelatedItemCategoryCode FND", DocItem."Item Category Code") = 0 then
                                exit(true);
                        until PostedWhseReceiptLine.Next() = 0;
                end;

            DocType::Invoice:
                begin
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Document No.", DocNo);
                    SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                    if SalesInvoiceLine.FindSet(false) then
                        repeat //HEI.07>>
                            DocItem.Get(SalesInvoiceLine."No.");
                            if StrPos(SalesReceivSetup."RPMRelatedItemCategoryCode FND", DocItem."Item Category Code") = 0 then
                                exit(true);
                        until SalesInvoiceLine.Next() = 0;
                end;

            DocType::"Credit Memo":
                begin
                    SalesCreditMemoLine.Reset();
                    SalesCreditMemoLine.SetRange("Document No.", DocNo);
                    SalesCreditMemoLine.SetRange(Type, SalesInvLine.Type::Item);
                    if SalesCreditMemoLine.FindSet(false) then
                        repeat //HEI.07>>
                            DocItem.Get(SalesCreditMemoLine."No.");
                            if StrPos(SalesReceivSetup."RPMRelatedItemCategoryCode FND", DocItem."Item Category Code") = 0 then
                                exit(true);
                        until SalesCreditMemoLine.Next() = 0;
                end;
        end;

        exit(false);
    end;

    local procedure GetDocShipCostDetails(var Rec: Record "Shipping Cost Allocation FND"; WhseShip: Boolean);
    var
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferReceiptHeader: Record "Transfer Receipt Header";
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        PostedWhseShipLine: Record "Posted Whse. Shipment Line";
        // BC Upgrade POENAB02>>
        // Code commented, as "Posted Document Shipping Cost" belongs to Aptean
        // PostedDocumentShippingCost: Record "Posted Document Shipping Cost";
        // BC Upgrade POENAB02<<
        //POENAB02, 09.06.2026>>
        PostedDocumentShippingCost: Record "Posted Trade Cost Order APS";
        DocFound: Boolean;
    //POENAB02, 09.06.2026<<
    begin
        //HEI.18>>
        /*
        PostedDocumentShippingCost.RESET;
        PostedDocumentShippingCost.SETRANGE("Source No.",Rec."No.");
        IF PostedDocumentShippingCost.FINDFIRST THEN
          GetCostAmount(Rec,PostedDocumentShippingCost)
        */
        // BC Upgrade POENAB02>>
        // Code commented, as "Posted Document Shipping Cost" belongs to Aptean        
        //POENAB02, 10.07.2026>>
        //if TmpPostedShipDocCost2LCY.Get(0, Rec."No.", 0) then
        //GetCostAmount(Rec, TmpPostedShipDocCost2LCY)
        //if TmpPostedShipDocCost2LCY.Get(Rec."No.") then
        //POENAB02, 06.08.2026, BCUP0-247>>
        /*         
        if TmpPostedShipDocCost2LCY."Posted Whse. Shipment No." <> '' then
            if TmpPostedShipDocCost2LCY."Posted Whse. Shipment No." = Rec."No." then begin
                GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                DocFound := true;
            end;
        if TmpPostedShipDocCost2LCY."Posted Whse. Receipt No." <> '' then
            if TmpPostedShipDocCost2LCY."Posted Whse. Receipt No." = Rec."No." then begin
                GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                DocFound := true;
            end; 
        */

        if Rec."No." <> '' then begin
            TmpPostedShipDocCost2LCY.Reset();
            TmpPostedShipDocCost2LCY.SetRange("Posted Whse. Shipment No.", Rec."No.");
            if TmpPostedShipDocCost2LCY.FindFirst() then begin
                GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                DocFound := true;
            end;
        end;
        if Rec."No." <> '' then begin
            TmpPostedShipDocCost2LCY.Reset();
            TmpPostedShipDocCost2LCY.SetRange("Posted Whse. Receipt No.", Rec."No.");
            if TmpPostedShipDocCost2LCY.FindFirst() then begin
                GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                DocFound := true;
            end;
        end;
        //POENAB02, 06.08.2026, BCUP0-247<<   
        //POENAB02, 10.07.2026<<
        //HEI.18<<
        if DocFound = true then begin
        end
        else if WhseShip then begin
            //POENAB02, 06.08.2026, BCUP0-247>>
            //if TransferShipmentHeader.Get(Rec."Posted Source Document No.") then begin
            if TransferShipmentHeader.Get(Rec."No.") then begin
                //POENAB02, 06.08.2026, BCUP0-247<<
                PostedWhseReceiptLine.Reset();
                PostedWhseReceiptLine.SetRange("Source No.", TransferShipmentHeader."Transfer Order No.");
                if PostedWhseReceiptLine.FindFirst() then begin
                    //HEI.18>>
                    /*
                    PostedDocumentShippingCost.SETRANGE("Source No.",PostedWhseReceiptLine."No.");
                    IF PostedDocumentShippingCost.FINDFIRST THEN
                    */
                    //POENAB02, 10.07.2026>>
                    //if TmpPostedShipDocCost2LCY.Get(0, PostedWhseReceiptLine."No.", 0) then
                    //if TmpPostedShipDocCost2LCY.Get(PostedWhseReceiptLine."No.") then
                    //GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                    //POENAB02, 06.08.2026, BCUP0-247>>
                    /* 
                    if TmpPostedShipDocCost2LCY."Posted Whse. Shipment No." <> '' then
                        if TmpPostedShipDocCost2LCY."Posted Whse. Shipment No." = Rec."No." then
                            GetCostAmount(Rec, TmpPostedShipDocCost2LCY); 
                    */

                    if Rec."No." <> '' then begin
                        TmpPostedShipDocCost2LCY.Reset();
                        TmpPostedShipDocCost2LCY.SetRange("Posted Whse. Shipment No.", Rec."No.");
                        if TmpPostedShipDocCost2LCY.FindFirst() then begin
                            GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                            DocFound := true;
                        end;
                    end;
                    //POENAB02, 06.08.2026, BCUP0-247<<
                    //if TmpPostedShipDocCost2LCY."Posted Whse. Receipt No." <> '' then
                    //    if TmpPostedShipDocCost2LCY."Posted Whse. Receipt No." = Rec."No." then
                    //        GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                    //POENAB02, 10.07.2026<<
                    //HEI.18<<
                    //GetCostAmount(Rec, TmpPostedShipDocCost2LCY); //bogdan
                end;
            end;
        end else
            //POENAB02, 06.08.2026, BCUP0-247>>
            //if TransferReceiptHeader.Get(Rec."Posted Source Document No.") then begin
            if TransferReceiptHeader.Get(Rec."No.") then begin
                //POENAB02, 06.08.2026, BCUP0-247<<
                PostedWhseShipLine.Reset();
                PostedWhseShipLine.SetRange("Source No.", TransferReceiptHeader."Transfer Order No.");
                if PostedWhseShipLine.FindFirst then begin
                    //HEI.18>>
                    /*
                    PostedDocumentShippingCost.SETRANGE("Source No.",PostedWhseShipLine."No.");
                    IF PostedDocumentShippingCost.FINDFIRST THEN
                    */
                    //POENAB02, 10.07.2026>>
                    //if TmpPostedShipDocCost2LCY.Get(0, PostedWhseShipLine."No.", 0) then
                    //if TmpPostedShipDocCost2LCY.Get(PostedWhseShipLine."No.") then
                    //if TmpPostedShipDocCost2LCY."Posted Whse. Shipment No." <> '' then
                    //    if TmpPostedShipDocCost2LCY."Posted Whse. Shipment No." = Rec."No." then
                    //        GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                    //POENAB02, 06.08.2026, BCUP0-247>>
                    /*
                    if TmpPostedShipDocCost2LCY."Posted Whse. Receipt No." <> '' then
                        if TmpPostedShipDocCost2LCY."Posted Whse. Receipt No." = Rec."No." then
                            GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                    */
                    if Rec."No." <> '' then begin
                        TmpPostedShipDocCost2LCY.Reset();
                        TmpPostedShipDocCost2LCY.SetRange("Posted Whse. Receipt No.", Rec."No.");
                        if TmpPostedShipDocCost2LCY.FindFirst() then begin
                            GetCostAmount(Rec, TmpPostedShipDocCost2LCY);
                            DocFound := true;
                        end;
                    end;
                    //POENAB02, 06.08.2026, BCUP0-247<<
                    //POENAB02, 10.07.2026<<
                    //HEI.18<<
                    //GetCostAmount(Rec, TmpPostedShipDocCost2LCY); //bogdan
                end;
            end;
        // BC Upgrade POENAB02<<

    end;

    local procedure FindLastAllocated() EntryNo: Integer;
    var
        ShipCostAllocation: Record "Shipping Cost Allocation FND";
    begin
        ShipCostAllocation.Reset();
        if ShipCostAllocation.FindLast() then
            EntryNo := ShipCostAllocation."Entry No." + 1
        else
            EntryNo := 1;

        exit(EntryNo);
    end;

    local procedure FindOriginalLotDestination(var Rec: Record "Shipping Cost Allocation FND");
    var
        ShippingAllocation2: Record "Shipping Cost Allocation FND";
    begin
        ShippingAllocation2.Reset();
        ShippingAllocation2.SetCurrentKey("Source Document", "Item No.", "Lot No.", "Destination No.", "Originial Lot & Location Code");
        ShippingAllocation2.SetRange("Source Document", ShippingAllocation2."Source Document"::"Outbound Transfer");
        ShippingAllocation2.SetRange("Item No.", Rec."Item No.");
        ShippingAllocation2.SetRange("Lot No.", Rec."Lot No.");
        ShippingAllocation2.SetRange("Destination No.", Rec."Location Code");
        ShippingAllocation2.SetFilter("Originial Lot & Location Code", '<>%1', '');
        if not ShippingAllocation2.FindFirst() then begin
            Rec."Originial Lot & Location Code" := Rec."Lot No." + Rec."Location Code";
            Rec."Initial Origin ST" := Rec."Location Code";
        end else begin
            Rec."Originial Lot & Location Code" := ShippingAllocation2."Originial Lot & Location Code";
            Rec."Initial Origin ST" := CopyStr(ShippingAllocation2."Originial Lot & Location Code", StrLen(ShippingAllocation2."Lot No.") + 1);
        end;
    end;

    local procedure CalcNetWeight(ItemNo: Code[20]; Qty: Decimal) NetWeight: Decimal;
    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Item: Record Item;
    begin
        NetWeight := 0;

        //HEI.19>>
        if (ShippingAllocation."Only RPM Transportation")
          and (ShippingAllocation."Source Document" = ShippingAllocation."Source Document"::"Sales Order")
        then
            exit(0);
        //HEI.19<<

        Item.Get(ItemNo);
        if ItemUnitofMeasure.Get(ItemNo, Item."Base Unit of Measure") then begin
            if ItemUnitofMeasure."Unit of Weight FND" = WhseSetup."Net Weight UoM (Kg) FND" then
                NetWeight := Qty * ItemUnitofMeasure."Net Weight FND"
            else if ItemUnitofMeasure."Unit of Weight FND" = WhseSetup."Net Weight UoM (G) FND" then
                NetWeight := (Qty * ItemUnitofMeasure."Net Weight FND") / 1000;
        end;

        exit(NetWeight);
    end;

    local procedure CalcTotalNetWeight(DocNo: Code[20]; DocType: Option " ",Shipment,Return,Invoice,"Credit Memo"; OnlyRPM: Boolean) TotalNetWeight: Decimal;
    var
        ItemLedgEntry2: Record "Item Ledger Entry";
        Location: Record Location;
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        PostedWhseShipLine: Record "Posted Whse. Shipment Line";
        PostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
    begin
        TotalNetWeight := 0;

        case DocType of
            DocType::Shipment:
                begin
                    PostedWhseShipmentLine.Reset();
                    PostedWhseShipmentLine.SetRange("No.", DocNo);
                    if PostedWhseShipmentLine.FindSet(false) then
                        repeat //HEI.07>>
                            Item.Get(PostedWhseShipmentLine."Item No.");
                            if (OnlyRPM) or (StrPos(InventorySetup."Finished Goods ItemCatCode FND", Item."Item Category Code") <> 0) then
                                TotalNetWeight += CalcNetWeight(PostedWhseShipmentLine."Item No.", PostedWhseShipmentLine."Qty. (Base)");
                        until PostedWhseShipmentLine.Next() = 0;
                end;

            DocType::Return:
                begin
                    PostedWhseReceiptLine.Reset();
                    PostedWhseReceiptLine.SetRange("No.", DocNo);
                    if PostedWhseReceiptLine.FindSet(false) then
                        repeat //HEI.07>>
                            Item.Get(PostedWhseReceiptLine."Item No.");
                            if (OnlyRPM) or (StrPos(InventorySetup."Finished Goods ItemCatCode FND", Item."Item Category Code") <> 0) then
                                //TotalNetWeight += CalcNetWeight(PostedWhseReceiptLine."Item No.",-PostedWhseReceiptLine."Qty. (Base)"); //HEI.c
                                TotalNetWeight += CalcNetWeight(PostedWhseReceiptLine."Item No.", PostedWhseReceiptLine."Qty. (Base)"); //HEI.c
                        until PostedWhseReceiptLine.Next() = 0;
                end;

            DocType::Invoice:
                begin
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Document No.", DocNo);
                    SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                    if SalesInvoiceLine.FindSet(false) then
                        repeat //HEI.07>>
                            Item.Get(SalesInvoiceLine."No.");
                            if (OnlyRPM) or (StrPos(InventorySetup."Finished Goods ItemCatCode FND", Item."Item Category Code") <> 0) then
                                TotalNetWeight += CalcNetWeight(SalesInvoiceLine."No.", SalesInvoiceLine."Quantity (Base)");
                        until SalesInvoiceLine.Next() = 0;
                end;

            DocType::"Credit Memo":
                begin
                    SalesCreditMemoLine.Reset();
                    SalesCreditMemoLine.SetRange("Document No.", DocNo);
                    SalesCreditMemoLine.SetRange(Type, SalesCreditMemoLine.Type::Item);
                    if SalesCreditMemoLine.FindSet(false) then
                        repeat //HEI.07>>
                            Item.Get(SalesCreditMemoLine."No.");
                            if (OnlyRPM) or (StrPos(InventorySetup."Finished Goods ItemCatCode FND", Item."Item Category Code") <> 0) then
                                //TotalNetWeight += CalcNetWeight(SalesCreditMemoLine."No.",-SalesCreditMemoLine."Quantity (Base)");
                                TotalNetWeight += CalcNetWeight(SalesCreditMemoLine."No.", SalesCreditMemoLine."Quantity (Base)"); //HEI.c
                        until SalesCreditMemoLine.Next() = 0;
                end;
        end;

        exit(TotalNetWeight);
    end;

    procedure GetDates(NewStartDate: Date; NewEndDate: Date; InsertChild: Boolean);
    begin
        StartingDate := NewStartDate;
        EndingDate := NewEndDate;
        Split := InsertChild; //HEI.04
    end;

    local procedure CalculateQtyHL(var ItemLedgEntry: Record "Item Ledger Entry") QtyHL: Decimal;
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ValueEntry: Record "Value Entry";
    begin
        QtyHL := 0;

        ValueEntry.Reset();
        ValueEntry.SetCurrentKey("Posting Date", "Item Ledger Entry No.");
        ValueEntry.SetRange("Posting Date", StartingDate, EndingDate);
        ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
        if ValueEntry.FindSet(false) then
            repeat //HEI.07>>
                   // BC Upgrade POENAB02 >>
                   // code commented, as ValueEntry."Invoiced Quantity in HL" belongs to Aptean
                   // QtyHL += ValueEntry."Invoiced Quantity in HL";
                   // BC Upgrade POENAB02 <<
                   //POENAB02, 09.06.2026>>
                QtyHL += ValueEntry."Invoiced Quantity HL FND";
            //POENAB02, 09.06.2026<<
            until ValueEntry.Next() = 0;

        exit(QtyHL);
    end;

    local procedure InsertChildLines(var ParentLine: Record "Shipping Cost Allocation FND"; WhseShip: Boolean);
    var
        ChildLine: Record "Shipping Cost Allocation FND";
    begin
        //HEI.02<<
        //insert primary child line
        ChildLine.Reset();
        ChildLine.TransferFields(ParentLine);
        //HEI.07>>
        //ChildLine."Entry No." := FindLastAllocated;
        EntryNo := EntryNo + 1;
        ChildLine."Entry No." := EntryNo;
        //HEI.07<<
        ChildLine."Parent Line No." := ParentLine."Entry No.";
        ChildLine."Distribution Type" := ChildLine."Distribution Type"::Primary;
        GetDocShipCostDetails(ChildLine, WhseShip);
        if ChildLine."Total Net Weight (Kg)" <> 0 then
            ChildLine."Primary Allocated Amount" := ABS((ChildLine."Net Weight (Kg)" * ChildLine."Total Shipping Cost Amount") / ChildLine."Total Net Weight (Kg)");

        //HEI.13>>
        ChildLine."Processing Date" := WorkDate();
        //HEI.13<<

        ChildLine.Insert();

        //insert secondary child line
        ChildLine.Reset();
        ChildLine.TransferFields(ParentLine);
        //HEI.07>>
        //ChildLine."Entry No." := FindLastAllocated;
        EntryNo := EntryNo + 1;
        ChildLine."Entry No." := EntryNo;
        //HEI.07<<
        ChildLine."Parent Line No." := ParentLine."Entry No.";
        ChildLine."Distribution Type" := ChildLine."Distribution Type"::Secondary;
        GetDocShipCostDetails(ChildLine, WhseShip);
        if ChildLine."Total Net Weight (Kg)" <> 0 then
            ChildLine."Primary Allocated Amount" := ABS((ChildLine."Net Weight (Kg)" * ChildLine."Total Shipping Cost Amount") / ChildLine."Total Net Weight (Kg)");

        //HEI.13>>
        ChildLine."Processing Date" := WorkDate();
        //HEI.13<<

        ChildLine.Insert();

        //HEI.02>>
    end;

    local procedure MoveToArchive();
    var
        ShippingCostArchive: Record "Shipping Cost Archive FND";
        RPMSKURelationship: Record "RPM - SKU Relationship FND";
        RPMSKURelationshipArchive: Record "RPM-SKU Relationship Arch FND";
        ArchiveStartDate: Date;
        ArchiveEndDate: Date;
    begin
        //HEI.02<<
        //find the period which is already allocated
        ShippingAllocation.Reset();
        if ShippingAllocation.FindFirst() then begin
            ArchiveStartDate := CalcDate('<-CM>', ShippingAllocation."Posting Date");
            ArchiveEndDate := CalcDate('<CM>', ShippingAllocation."Posting Date");
        end;

        //delete the old entries from Shipping Cost Archive for the same period
        ShippingCostArchive.Reset();
        ShippingCostArchive.SetRange("Posting Date", ArchiveStartDate, ArchiveEndDate);
        ShippingCostArchive.DeleteAll();

        //delete the old entries from RPM-SKU relationship for the same period
        RPMSKURelationshipArchive.Reset();
        RPMSKURelationshipArchive.SetRange("Period Start Date", ArchiveStartDate);
        RPMSKURelationshipArchive.SetRange("Period End Date", ArchiveEndDate);
        RPMSKURelationshipArchive.DeleteAll();

        //insert the old Shipping Allocation entries to archive
        ShippingAllocation.Reset();
        if ShippingAllocation.FindSet(false) then
            repeat //HEI.07>>

                //insert the new entries to archive
                ShippingCostArchive.TransferFields(ShippingAllocation);
                ShippingCostArchive."Entry No." := FindLastArchived();
                ShippingCostArchive.Insert();

                //delete the old entry
                ShippingAllocation.Delete();
            until ShippingAllocation.Next() = 0;

        //insert the old RPM-SKU entires to archive
        RPMSKURelationship.Reset();
        if RPMSKURelationship.FindSet(false) then
            repeat //HEI.07>>

                //insert the new entries to archive
                RPMSKURelationshipArchive.TransferFields(RPMSKURelationship);
                RPMSKURelationshipArchive.Insert();

                //delete the old entry
                RPMSKURelationship.Delete();
            until RPMSKURelationship.Next() = 0;
        //HEI.02>>
    end;

    local procedure FindLastArchived() EntryNo: Integer;
    var
        ShippingCostArchive: Record "Shipping Cost Archive FND";
    begin
        //HEI.02<<
        ShippingCostArchive.Reset();
        if ShippingCostArchive.FindLast() then
            EntryNo := ShippingCostArchive."Entry No." + 1
        else
            EntryNo := 1;

        exit(EntryNo);
        //HEI.02>>
    end;

    local procedure UpdateChidLines(var ParentLine: Record "Shipping Cost Allocation FND");
    var
        ChildLine: Record "Shipping Cost Allocation FND";
    begin
        ChildLine.Reset();
        ChildLine.SetCurrentKey("Parent Line No.");
        ChildLine.SetRange("Parent Line No.", ParentLine."Entry No.");
        if ChildLine.FindSet(false) then
            repeat //HEI.07>>
                ChildLine."Quantity HL" += ParentLine."Quantity HL";
                ChildLine.Modify();
            until ChildLine.Next() = 0;
    end;

    local procedure CheckReversedLines(DocNo: Code[20]; DocType: Option " ",Shipment,Return,Invoice,"Credit Memo"; ItemNo: Code[20]) Qty: Decimal;
    var
        PostedWhseShipmentLine: Record "Posted Whse. Shipment Line";
        PostedWhseReceiptLine: Record "Posted Whse. Receipt Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCreditMemoLine: Record "Sales Cr.Memo Line";
        // BC Upgrade POENAB02 >>
        // code commented, as "Posted Document Shipping Cost" belongs to Aptean
        // LocalPostedDocumentShippingCost: Record "Posted Document Shipping Cost";
        // BC Upgrade POENAB02 <<
        //POENAB02, 09.06.2026>>
        LocalPostedDocumentShippingCost: Record "Posted Trade Cost Order APS";
        //POENAB02, 09.06.2026<<
        LocalReversedDocFound: Boolean;
    begin
        Qty := 0;

        case DocType of
            DocType::Shipment:
                begin
                    PostedWhseShipmentLine.Reset();
                    PostedWhseShipmentLine.SetRange("No.", DocNo);
                    PostedWhseShipmentLine.SetRange("Item No.", ItemNo);
                    if PostedWhseShipmentLine.FindSet(false) then
                        repeat //HEI.07>>
                               //HEI.21>>
                               //  Qty += PostedWhseShipmentLine."Qty. (Base)";
                            LocalReversedDocFound := false;
                            // BC Upgrade POENAB02 >>
                            // Code commented, as "Posted Document Shipping Cost" belongs to Aptean
                            /*
                            LocalPostedDocumentShippingCost.Reset();
                            LocalPostedDocumentShippingCost.SetRange("Source No.", DocNo);
                            if LocalPostedDocumentShippingCost.FindFirst then
                                if LocalPostedDocumentShippingCost.Status = LocalPostedDocumentShippingCost.Status::Reversed then begin
                                    Qty += 0;
                                    LocalReversedDocFound := true;
                                end;
                            */
                            // BC Upgrade POENAB02 <<
                            //POENAB02, 09.06.2026>>
                            LocalPostedDocumentShippingCost.Reset();
                            LocalPostedDocumentShippingCost.SetRange("Posted Whse. Shipment No.", DocNo);
                            if LocalPostedDocumentShippingCost.FindFirst then
                                if LocalPostedDocumentShippingCost.Status = LocalPostedDocumentShippingCost.Status::Reversed then begin
                                    Qty += 0;
                                    LocalReversedDocFound := true;
                                end;
                            //POENAB02, 09.06.2026<<
                            if LocalReversedDocFound = false then
                                Qty += PostedWhseShipmentLine."Qty. (Base)";
                        //HEI.21<<
                        until PostedWhseShipmentLine.Next() = 0;
                end;

            DocType::Return:
                begin
                    PostedWhseReceiptLine.Reset();
                    PostedWhseReceiptLine.SetRange("No.", DocNo);
                    PostedWhseReceiptLine.SetRange("Item No.", ItemNo);
                    if PostedWhseReceiptLine.FindSet(false) then
                        repeat //HEI.07>>
                               //HEI.21>>
                               //Qty += PostedWhseReceiptLine."Qty. (Base)";
                            LocalReversedDocFound := false;
                            // BC Upgrade POENAB02 >>
                            // Code commented, as "Posted Document Shipping Cost" belongs to Aptean
                            /*                            
                            LocalPostedDocumentShippingCost.Reset();
                            LocalPostedDocumentShippingCost.SetRange("Source No.", DocNo);
                            if LocalPostedDocumentShippingCost.FindFirst then
                                if LocalPostedDocumentShippingCost.Status = LocalPostedDocumentShippingCost.Status::Reversed then begin
                                    Qty += 0;
                                    LocalReversedDocFound := true;
                                end;
                            */
                            // BC Upgrade POENAB02 <<
                            //POENAB02, 09.06.2026>>
                            LocalPostedDocumentShippingCost.Reset();
                            LocalPostedDocumentShippingCost.SetRange("Posted Whse. Receipt No.", DocNo);
                            if LocalPostedDocumentShippingCost.FindFirst then
                                if LocalPostedDocumentShippingCost.Status = LocalPostedDocumentShippingCost.Status::Reversed then begin
                                    Qty += 0;
                                    LocalReversedDocFound := true;
                                end;
                            //POENAB02, 09.06.2026<<
                            if LocalReversedDocFound = false then
                                Qty += PostedWhseReceiptLine."Qty. (Base)";
                        //HEI.21<<
                        until PostedWhseReceiptLine.Next() = 0;
                end;

            DocType::Invoice:
                begin
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Document No.", DocNo);
                    SalesInvoiceLine.SetRange(Type, SalesInvoiceLine.Type::Item);
                    SalesInvoiceLine.SetRange("No.", ItemNo);
                    if SalesInvoiceLine.FindSet(false) then
                        repeat //HEI.07>>
                               //HEI.21>>
                               //Qty += SalesInvoiceLine."Quantity (Base)";
                            LocalReversedDocFound := false;
                            // BC Upgrade POENAB02 >>
                            // Code commented, as "Posted Document Shipping Cost" belongs to Aptean
                            /*
                            LocalPostedDocumentShippingCost.Reset();
                            LocalPostedDocumentShippingCost.SetRange("Source No.", DocNo);
                            if LocalPostedDocumentShippingCost.FindFirst then
                                if LocalPostedDocumentShippingCost.Status = LocalPostedDocumentShippingCost.Status::Reversed then begin
                                    Qty += 0;
                                    LocalReversedDocFound := true;
                                end;
                            */
                            // BC Upgrade POENAB02 <<
                            if LocalReversedDocFound = false then
                                Qty += SalesInvoiceLine."Quantity (Base)";
                        //HEI.21<<
                        until SalesInvoiceLine.Next() = 0;
                end;

            DocType::"Credit Memo":
                begin
                    SalesCreditMemoLine.Reset();
                    SalesCreditMemoLine.SetRange("Document No.", DocNo);
                    SalesCreditMemoLine.SetRange(Type, SalesCreditMemoLine.Type::Item);
                    SalesCreditMemoLine.SetRange("No.", ItemNo);
                    if SalesCreditMemoLine.FindSet(false) then
                        repeat //HEI.07>>
                               //HEI.21>>
                               //Qty += SalesCreditMemoLine."Quantity (Base)";
                            LocalReversedDocFound := false;
                            // BC Upgrade POENAB02 >>
                            // Code commented, as "Posted Document Shipping Cost" belongs to Aptean
                            /*
                            LocalPostedDocumentShippingCost.Reset();
                            LocalPostedDocumentShippingCost.SetRange("Source No.", DocNo);
                            if LocalPostedDocumentShippingCost.FindFirst then
                                if LocalPostedDocumentShippingCost.Status = LocalPostedDocumentShippingCost.Status::Reversed then begin
                                    Qty += 0;
                                    LocalReversedDocFound := true;
                                end;
                            */
                            // BC Upgrade POENAB02 <<
                            if LocalReversedDocFound = false then
                                Qty += SalesCreditMemoLine."Quantity (Base)";
                        //HEI.21<<
                        until SalesCreditMemoLine.Next() = 0;
                end;
        end;
    end;

    local procedure CountDrops(Rec: Record "Shipping Cost Allocation FND") NoDrops: Integer;
    var
        lItemLedgEntry: Record "Item Ledger Entry";
        TempCustomer: Record Customer temporary;
        lPostedWhseShipLine: Record "Posted Whse. Shipment Line";
        TempLocation: Record Location temporary;
    begin
        //HEI.04<<
        NoDrops := 0;

        if Rec."Destination Type" = Rec."Destination Type"::Customer then begin
            lItemLedgEntry.Reset();
            lItemLedgEntry.SetCurrentKey("Document No.", "Posting Date", "Source Type");
            lItemLedgEntry.SetRange("Document No.", Rec."Posted Source Document No.");
            lItemLedgEntry.SetRange("Posting Date", Rec."Posting Date");
            lItemLedgEntry.SetRange("Source Type", lItemLedgEntry."Source Type"::Customer);
            if lItemLedgEntry.FindSet(false) then
                repeat //HEI.07>>
                       //HEI.19>>
                       /*
                       TempCustomer.RESET;
                       IF NOT TempCustomer.GET(lItemLedgEntry."Source No.") THEN BEGIN
                         NoDrops += 1;
                         TempCustomer."No." := lItemLedgEntry."Source No.";
                         TempCustomer.INSERT;
                       END;
                       */
                    TmpCountDrops.Reset();
                    if not TmpCountDrops.Get(StartingDate, EndingDate, '', Rec."No.", lItemLedgEntry."Source No.", false) then begin
                        NoDrops += 1;
                        TmpCountDrops."Period Start Date" := StartingDate;
                        TmpCountDrops."Period End Date" := EndingDate;
                        TmpCountDrops."RPM Item No." := '';
                        TmpCountDrops."Linked Item No." := Rec."No."; //keep the document No. tocount no of comb (Document No, Customer No)
                        TmpCountDrops."Customer No." := lItemLedgEntry."Source No.";
                        TmpCountDrops.Insert();
                    end;
                //HEI.19<<
                until lItemLedgEntry.Next() = 0;
            //HEI.18>> roll beack - the test is done once, when is called the function
            /*
            //HEI.16>>
            //END ELSE IF Rec."Destination Type" = Rec."Destination Type"::Location THEN BEGIN
            END ELSE IF (Rec."Destination Type" = Rec."Destination Type"::Location) AND
              (
              ((STRPOS(InventorySetup."Finished Goods Item Cat Code",Rec."Item Category Code") = 0)  AND (Rec."Only RPM Transportation") AND  (Rec."Own Fleet"))
              OR
              (STRPOS(InventorySetup."Finished Goods Item Cat Code",Rec."Item Category Code") <> 0)
              )
            THEN BEGIN
            //HEI.16<<
            */
        end else if Rec."Destination Type" = Rec."Destination Type"::Location then begin
            //HEI.18>>
            lPostedWhseShipLine.Reset();
            lPostedWhseShipLine.SetRange("No.", Rec."No.");
            if lPostedWhseShipLine.FindSet(false) then
                repeat //HEI.07>>
                    TempLocation.Reset();
                    if not TempLocation.Get(lPostedWhseShipLine."Destination No.") then begin
                        NoDrops += 1;
                        TempLocation.Code := lPostedWhseShipLine."Destination No.";
                        TempLocation.Insert();
                    end;
                until lPostedWhseShipLine.Next() = 0;
        end;
        //HEI.04>>

    end;

    //BC Upgrade POENAB02 >>
    //Code commented, as "Posted Document Shipping Cost" belongs to Aptean
    //POENAB02, 09.06.2026>>
    //local procedure GetCostAmount(var Rec: Record "Shipping Cost Allocation FND"; PostedDocumentShippingCost: Record "Posted Document Shipping Cost"): Decimal;
    local procedure GetCostAmount(var Rec: Record "Shipping Cost Allocation FND"; PostedDocumentShippingCost: Record "Posted Trade Cost Order APS"): Decimal;
    //POENAB02, 09.06.2026<<
    var
        CostAmountLCY: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        //HEI.18 >> - commented all and add the new lines of codes
        //HEI.12>>
        /*
        //HEI.04<<
        IF Rec."Distribution Type" = Rec."Distribution Type"::Total THEN
          Rec."Total Shipping Cost Amount" := PostedDocumentShippingCost."Cost Amount"
        ELSE
          IF Rec."Distribution Type" = Rec."Distribution Type"::Primary THEN BEGIN
            IF STRPOS(PrimaryChargeNoFilter,PostedDocumentShippingCost."Charge No.") <> 0 THEN
              Rec."Total Shipping Cost Amount" := PostedDocumentShippingCost."Cost Amount"
            ELSE
              Rec."Total Shipping Cost Amount" := 0;
          END ELSE IF Rec."Distribution Type" = Rec."Distribution Type"::Secondary THEN BEGIN
            IF STRPOS(SecondaryChargeNoFilter,PostedDocumentShippingCost."Charge No.") <> 0 THEN
              Rec."Total Shipping Cost Amount" := PostedDocumentShippingCost."Cost Amount"
            ELSE
              Rec."Total Shipping Cost Amount" := 0;
          END;
        //HEI.04>>
        */

        /*
        IF PostedDocumentShippingCost."Currency Code" <> '' THEN BEGIN
          Currency.InitRoundingPrecision;
          CostAmountLCY :=
            ROUND(
              //HEI.17>>
              //CurrExchRate.ExchangeAmtFCYToLCY(
              CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
              //HEI.17<<
                EndingDate,PostedDocumentShippingCost."Currency Code",
                PostedDocumentShippingCost."Cost Amount",//CurrExchRate.ExchangeRate(EndingDate,PostedDocumentShippingCost."Currency Code")), //HEI.18
                CurrExchRate.ExchangeRateAdjmt(EndingDate,PostedDocumentShippingCost."Currency Code")), //HEI.18
                Currency."Amount Rounding Precision")
        END ELSE
          CostAmountLCY := PostedDocumentShippingCost."Cost Amount";

        IF Rec."Distribution Type" = Rec."Distribution Type"::Total THEN
          Rec."Total Shipping Cost Amount" := CostAmountLCY
        ELSE
          IF Rec."Distribution Type" = Rec."Distribution Type"::Primary THEN BEGIN
            IF STRPOS(PrimaryChargeNoFilter,PostedDocumentShippingCost."Charge No.") <> 0 THEN
              Rec."Total Shipping Cost Amount" := CostAmountLCY
            ELSE
              Rec."Total Shipping Cost Amount" := 0;
          END ELSE IF Rec."Distribution Type" = Rec."Distribution Type"::Secondary THEN BEGIN
            IF STRPOS(SecondaryChargeNoFilter,PostedDocumentShippingCost."Charge No.") <> 0 THEN
              Rec."Total Shipping Cost Amount" := CostAmountLCY
            ELSE
              Rec."Total Shipping Cost Amount" := 0;
          END;
        //HEI.12<<
        */

        //POENAB02, 09.06.2026>>
        //Rec."Total Shipping Cost Amount" := PostedDocumentShippingCost."Cost Amount"
        Rec."Total Shipping Cost Amount" := PostedDocumentShippingCost.Amount;
        //POENAB02, 09.06.2026<<
        //HEI.18<<

    end;
    //BC Upgrade POENAB02 <<

    local procedure GetSplitFilters();
    begin
        //HEI.04
        WhseCostAllocationSetup.Reset();
        WhseCostAllocationSetup.SetRange("C2S Name", WhseCostAllocationSetup."C2S Name"::"Delivery To Customers");
        WhseCostAllocationSetup.SetRange("Distribution Type", WhseCostAllocationSetup."Distribution Type"::Primary);
        if WhseCostAllocationSetup.FindFirst() then
            PrimaryChargeNoFilter := WhseCostAllocationSetup."Shipping Charge No. Filter";

        WhseCostAllocationSetup.Reset();
        WhseCostAllocationSetup.SetRange("C2S Name", WhseCostAllocationSetup."C2S Name"::"Delivery To Customers");
        WhseCostAllocationSetup.SetRange("Distribution Type", WhseCostAllocationSetup."Distribution Type"::Secondary);
        if WhseCostAllocationSetup.FindFirst() then
            SecondaryChargeNoFilter := WhseCostAllocationSetup."Shipping Charge No. Filter";
        //HEI.04
    end;

    local procedure GetReceiptDistance("No.": Code[20]): Decimal;
    var
        PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        TransferReceiptHeader: Record "Transfer Receipt Header";
    begin
        if TransferShipmentHeader.Get("No.") then begin
            PostedWhseReceiptLine.Reset();
            PostedWhseReceiptLine.SetRange("Source No.", TransferShipmentHeader."Transfer Order No.");
            if PostedWhseReceiptLine.FindFirst() then begin
                PostedWhseReceiptHeader.Get(PostedWhseReceiptLine."No.");
                // BC Upgrade POENAB02 >>
                // code commented, as PostedWhseReceiptHeader.Distance belongs to Aptean
                // exit(PostedWhseReceiptHeader.Distance);
                // BC Upgrade POENAB02 <<
            end;
        end;
    end;

    local procedure RemoveOldShipCostEntries();
    var
        RPMSKURelationship: Record "RPM - SKU Relationship FND";
        ShippingCostAllocation: Record "Shipping Cost Allocation FND";
    begin
        //HEI.06>>
        //Remove the old Shipping Allocation entries
        ShippingCostAllocation.Reset();
        ShippingCostAllocation.SetCurrentKey("Posting Date"); //HEI.07>>
        ShippingCostAllocation.SetRange("Posting Date", StartingDate, EndingDate);
        ShippingCostAllocation.DeleteAll(); //HEI.07>>

        //Remove the old RPM-SKU entires
        RPMSKURelationship.Reset();
        RPMSKURelationship.SetRange("Period Start Date", StartingDate);
        RPMSKURelationship.SetRange("Period End Date", EndingDate);
        RPMSKURelationship.DeleteAll(); //HEI.07>>

        //HEI.06<<
    end;

    procedure MoveToArchive_New(ArchiveStartDate: Date; ArchiveEndDate: Date);
    var
        ShippingCostArchive: Record "Shipping Cost Archive FND";
        RPMSKURelationship: Record "RPM - SKU Relationship FND";
        RPMSKURelationshipArchive: Record "RPM-SKU Relationship Arch FND";
        EntryNo: Integer;
        lRec_ShippingAllocation: Record "Shipping Cost Allocation FND";
    begin
        //HEI.08>>
        //find the period which is already allocated
        /*
        ShippingAllocation.RESET;
        IF ShippingAllocation.FINDFIRST THEN BEGIN
          ArchiveStartDate := CALCDATE('<-CM>',ShippingAllocation."Posting Date");
          ArchiveEndDate := CALCDATE('<CM>',ShippingAllocation."Posting Date");
        END;
        */


        //delete the old entries from Shipping Cost Archive for the same period
        ShippingCostArchive.Reset();
        ShippingCostArchive.SetRange("Posting Date", ArchiveStartDate, ArchiveEndDate);
        ShippingCostArchive.DeleteAll();

        //delete the old entries from RPM-SKU relationship for the same period
        RPMSKURelationshipArchive.Reset();
        RPMSKURelationshipArchive.SetRange("Period Start Date", ArchiveStartDate);
        RPMSKURelationshipArchive.SetRange("Period End Date", ArchiveEndDate);
        RPMSKURelationshipArchive.DeleteAll();

        EntryNo := FindLastArchived();
        //insert the old Shipping Allocation entries to archive
        lRec_ShippingAllocation.Reset();
        lRec_ShippingAllocation.SetCurrentKey("Posting Date");
        lRec_ShippingAllocation.SetRange("Posting Date", ArchiveStartDate, ArchiveEndDate);
        if lRec_ShippingAllocation.FindSet(false) then
            repeat

                //insert the new entries to archive
                ShippingCostArchive.Init();
                ShippingCostArchive.TransferFields(lRec_ShippingAllocation);
                ShippingCostArchive."Entry No." := EntryNo;
                EntryNo := EntryNo + 1;
                ShippingCostArchive.Insert();
                //delete the old entry
                lRec_ShippingAllocation.Delete();
            until lRec_ShippingAllocation.Next() = 0;

        //insert the old RPM-SKU entires to archive
        RPMSKURelationship.Reset();
        RPMSKURelationship.SetRange("Period Start Date", ArchiveStartDate);
        RPMSKURelationship.SetRange("Period End Date", ArchiveEndDate);
        if RPMSKURelationship.FindSet(false) then
            repeat
                //insert the new entries to archive
                RPMSKURelationshipArchive.Init();
                RPMSKURelationshipArchive.TransferFields(RPMSKURelationship);
                RPMSKURelationshipArchive.Insert();

                //delete the old entry
                RPMSKURelationship.Delete();
            until RPMSKURelationship.Next() = 0;
        //HEI.08<<

    end;

    procedure PopulateTempValueEntry(pDat_StartDate: Date; pDat_EndDate: Date);
    var
        lqr_C2SValueEntry: Query "C2S Value Entry";
    begin
        //HEI.09>>
        Clear(lqr_C2SValueEntry);
        lqr_C2SValueEntry.SetRange(FilterPostingDate, pDat_StartDate, pDat_EndDate);
        lqr_C2SValueEntry.Open(); //HEI.11
        while lqr_C2SValueEntry.Read() do begin
            ValueEntry.Init();
            ValueEntry."Entry No." := lqr_C2SValueEntry.EntryNo;
            ValueEntry."Posting Date" := lqr_C2SValueEntry.PostingDate;
            ValueEntry."Item Ledger Entry No." := lqr_C2SValueEntry.ItemLedgerEntryNo;
            // BC Upgrade POENAB02 >>
            // code commented, as ValueEntry."Invoiced Quantity in HL" belongs to Aptean
            // ValueEntry."Invoiced Quantity in HL" := lqr_C2SValueEntry.InvoicedQuantityinHL;
            // BC Upgrade POENAB02 <<
            //POENAB02, 09.06.2026>>
            ValueEntry."Invoiced Quantity HL FND" := lqr_C2SValueEntry.InvoicedQuantityinHL;
            //POENAB02, 09.06.2026<<
            ValueEntry."Document Type" := lqr_C2SValueEntry.DocumentType;
            ValueEntry."Document No." := lqr_C2SValueEntry.DocumentNo;
            ValueEntry."Document Line No." := lqr_C2SValueEntry.DocumentLineNo;
            ValueEntry."Item Ledger Entry Quantity" := lqr_C2SValueEntry.ItemLedgerEntryQuantity;

            //HEI.20>>
            ValueEntry."Order No." := lqr_C2SValueEntry.OrderNo;
            ValueEntry."Order Line No." := lqr_C2SValueEntry.OrderLineNo;
            //HEI.20<<

            ValueEntry.Insert(false);
        end;
        lqr_C2SValueEntry.Close(); //HEI.11
        //HEI.09<<
    end;

    procedure PopulateTempItemLedgerEntry(pDat_StartDate: Date; pDat_EndDate: Date);
    var
        lqr_C2SItemLedgerEntry: Query "C2S Item Ledger Entry";
    begin
        //HEI.09>>
        Clear(lqr_C2SItemLedgerEntry);
        lqr_C2SItemLedgerEntry.SetRange(FilterPostingDate, pDat_StartDate, pDat_EndDate);
        lqr_C2SItemLedgerEntry.Open();//HEI.11
        while lqr_C2SItemLedgerEntry.Read() do begin
            ItemLedgEntry.Init();
            ItemLedgEntry."Entry No." := lqr_C2SItemLedgerEntry.EntryNo;
            ItemLedgEntry."Posting Date" := lqr_C2SItemLedgerEntry.PostingDate;
            ItemLedgEntry."Document No." := lqr_C2SItemLedgerEntry.DocumentNo;
            ItemLedgEntry."Document Line No." := lqr_C2SItemLedgerEntry.DocumentLineNo;
            ItemLedgEntry."Location Code" := lqr_C2SItemLedgerEntry.LocationCode;
            ItemLedgEntry."Item Category Code" := lqr_C2SItemLedgerEntry.ItemCategoryCode;
            ItemLedgEntry."Dimension Set ID" := lqr_C2SItemLedgerEntry.DimensionSetID;
            ItemLedgEntry.Quantity := lqr_C2SItemLedgerEntry.Quantity;
            //HEI.14>>
            ItemLedgEntry."Lot No." := lqr_C2SItemLedgerEntry.LotNo;
            //HE.14<<

            //HEI.20>>
            ItemLedgEntry."Entry Type" := lqr_C2SItemLedgerEntry.Entry_Type;
            ItemLedgEntry."Document Type" := lqr_C2SItemLedgerEntry.Document_Type;
            ItemLedgEntry."Source No." := lqr_C2SItemLedgerEntry.Source_No;
            ItemLedgEntry.Description := lqr_C2SItemLedgerEntry.Description;
            ItemLedgEntry."Unit of Measure Code" := lqr_C2SItemLedgerEntry.Unit_of_Measure_Code;
            ItemLedgEntry."Item No." := lqr_C2SItemLedgerEntry.Item_No;
            //HEI.20<<

            ItemLedgEntry.Insert(false);
        end;
        lqr_C2SItemLedgerEntry.Close(); //HEI.11
        //HEI.09<<
    end;

    procedure PopulateTempPostedWhseShipLine(pDat_StartDate: Date; pDat_EndDate: Date);
    var
        lQr_C2SILEWhseShipLine: Query "C2S ILE & Whse. Ship Line";
    begin
        //HEI.11>>
        Clear(lQr_C2SILEWhseShipLine);
        lQr_C2SILEWhseShipLine.SetRange(FilterPostingDate, pDat_StartDate, pDat_EndDate);
        lQr_C2SILEWhseShipLine.Open();
        while lQr_C2SILEWhseShipLine.Read() do begin
            //HEI.13>>
            if not PostedWhseShipLine.Get(lQr_C2SILEWhseShipLine.No, lQr_C2SILEWhseShipLine.ILE_Entry_No) then begin
                //HEI.13<<
                PostedWhseShipLine.Init();
                PostedWhseShipLine."Sequence No. FND" := lQr_C2SILEWhseShipLine.ILE_Entry_No;
                PostedWhseShipLine."No." := lQr_C2SILEWhseShipLine.No;
                PostedWhseShipLine."Line No." := lQr_C2SILEWhseShipLine.ILE_Entry_No;
                PostedWhseShipLine."Load No. FND" := lQr_C2SILEWhseShipLine.Line_No;
                PostedWhseShipLine."Posting Date" := lQr_C2SILEWhseShipLine.Posting_Date;
                PostedWhseShipLine."Source No." := lQr_C2SILEWhseShipLine.Source_No;
                PostedWhseShipLine."Source Line No." := lQr_C2SILEWhseShipLine.Source_Line_No;
                PostedWhseShipLine."Item No." := lQr_C2SILEWhseShipLine.Item_No;
                PostedWhseShipLine."Unit of Measure Code" := lQr_C2SILEWhseShipLine.Unit_of_Measure_Code;
                PostedWhseShipLine."Posted Source No." := lQr_C2SILEWhseShipLine.Posted_Source_No;
                PostedWhseShipLine."Destination Type" := lQr_C2SILEWhseShipLine.Destination_Type;
                PostedWhseShipLine."Destination No." := lQr_C2SILEWhseShipLine.Destination_No;
                PostedWhseShipLine."Location Code" := lQr_C2SILEWhseShipLine.Location_Code;
                PostedWhseShipLine.Description := lQr_C2SILEWhseShipLine.Description;
                // BC Upgrade POENAB02 >>
                // Code commented, as "Posted Document Shipping Cost" belongs to Aptean
                // PostedWhseShipLine."Whse. Shipment No." := lQr_C2SILEWhseShipLine.PostedDocShipment_Source_No;
                // BC Upgrade POENAB02 <<
                //POENAB02, 09.06.2026>>
                PostedWhseShipLine."Whse. Shipment No." := lQr_C2SILEWhseShipLine.PostedDocShipment_Source_No;
                //POENAB02, 09.06.2026<<
                PostedWhseShipLine.Insert(false);
                //HEI.13>>
            end;
            //HEI.13<<
        end;
        lQr_C2SILEWhseShipLine.Close();
        //HEI.11<<
    end;

    procedure PopulateTempPostedWhseReceiptLine(pDat_StartDate: Date; pDat_EndDate: Date);
    var
        lQr_C2SILEWhseReceptLine: Query "C2S ILE & Whse. Recept Line";
    begin
        //HEI.11>>
        Clear(lQr_C2SILEWhseReceptLine);
        lQr_C2SILEWhseReceptLine.SetRange(FilterPostingDate, pDat_StartDate, pDat_EndDate);
        lQr_C2SILEWhseReceptLine.Open();
        while lQr_C2SILEWhseReceptLine.Read() do begin
            //HEI.13>>
            if not PostedWhseReceiptLine.Get(lQr_C2SILEWhseReceptLine.No, lQr_C2SILEWhseReceptLine.ILE_Entry_No) then begin
                //HEI.13<<
                PostedWhseReceiptLine.Init();
                PostedWhseReceiptLine."Sequence No. FND" := lQr_C2SILEWhseReceptLine.ILE_Entry_No;
                PostedWhseReceiptLine."No." := lQr_C2SILEWhseReceptLine.No;
                PostedWhseReceiptLine."Line No." := lQr_C2SILEWhseReceptLine.ILE_Entry_No;
                PostedWhseReceiptLine."Load No. FND" := lQr_C2SILEWhseReceptLine.Line_No;
                PostedWhseReceiptLine."Posting Date" := lQr_C2SILEWhseReceptLine.Posting_Date;
                PostedWhseReceiptLine."Source No." := lQr_C2SILEWhseReceptLine.Source_No;
                PostedWhseReceiptLine."Source Line No." := lQr_C2SILEWhseReceptLine.Source_Line_No;
                PostedWhseReceiptLine."Item No." := lQr_C2SILEWhseReceptLine.Item_No;
                PostedWhseReceiptLine."Unit of Measure Code" := lQr_C2SILEWhseReceptLine.Unit_of_Measure_Code;
                PostedWhseReceiptLine."Posted Source No." := lQr_C2SILEWhseReceptLine.Posted_Source_No;
                PostedWhseReceiptLine."Location Code" := lQr_C2SILEWhseReceptLine.Location_Code;
                PostedWhseReceiptLine.Description := lQr_C2SILEWhseReceptLine.Description;
                // BC Upgrade POENAB02 >>
                // code commented, as it related to Aptean
                // PostedWhseReceiptLine."Whse. Receipt No." := lQr_C2SILEWhseReceptLine.PostedDocReceipt_Source_No;
                // BC Upgrade POENAB02 <<
                //POENAB02, 09.06.2026>>
                PostedWhseReceiptLine."Whse. Receipt No." := lQr_C2SILEWhseReceptLine.PostedDocReceipt_Source_No;
                //POENAB02, 09.06.2026<<
                //HEI.14>>
                PostedWhseReceiptLine."Qty. (Base)" := lQr_C2SILEWhseReceptLine.Qty_Base;
                //HEI.14<<
                PostedWhseReceiptLine.Insert(false);
                //HEI.13>>
            end;
            //HEI.13<<
        end;
        lQr_C2SILEWhseReceptLine.Close();
        //HEI.11<<
    end;

    local procedure InsertCurrencyFactor();
    var
        CurrExchRate: Record "Currency Exchange Rate";
        // BC Upgrade POENAB02 >>
        // code commented, as "Posted Document Shipping Cost" is related to Aptean
        /*
        PostedDocShipCost: Record "Posted Document Shipping Cost";
        Q_C2SPostedShipDocDistinctCur: Query "C2S PostedShipDoc Distinct Cur";
        */
        // BC Upgrade POENAB02 <<
        //POENAB02, 09.06.2026>>
        PostedDocShipCost: Record "Posted Trade Cost Order APS";
        Q_C2SPostedShipDocDistinctCur: Query "C2S PostedShipDoc Distinct Cur";
    //POENAB02, 09.06.2026<<
    begin
        //HEI.18>>
        Q_C2SPostedShipDocDistinctCur.SetRange(FilterPostingDate, StartingDate, EndingDate);
        Q_C2SPostedShipDocDistinctCur.Open();
        while Q_C2SPostedShipDocDistinctCur.Read() do begin
            if Q_C2SPostedShipDocDistinctCur.Currency_Code <> '' then begin
                TmpCurrencyFactor.Init();
                TmpCurrencyFactor.Code := Q_C2SPostedShipDocDistinctCur.Currency_Code;
                TmpCurrencyFactor."Currency Factor" := CurrExchRate.ExchangeRateAdjmt(EndingDate, Q_C2SPostedShipDocDistinctCur.Currency_Code);
                TmpCurrencyFactor.Insert(false);
            end;
        end;
        Q_C2SPostedShipDocDistinctCur.Close();
    end;

    local procedure InsertPostedShipDocCost2LCY();
    var
        // BC Upgrade POENAB02 >>
        // code commented, as "Posted Document Shipping Cost" belongs to Aptean
        // PostedShipDoc: Record "Posted Document Shipping Cost";
        // BC Upgrade POENAB 02<<
        CurrExchRate: Record "Currency Exchange Rate";
        PostedShipDoc: Record "Posted Trade Cost Order APS"; //POENAB02, 09.06.2026
    begin
        //HEI.18>>
        PostedShipDoc.SetRange("Posting Date", StartingDate, EndingDate);
        if PostedShipDoc.FindSet(false) then
            repeat
                TmpPostedShipDocCost2LCY.Init();
                //POENAB02, 09.06.2026>>
                //TmpPostedShipDocCost2LCY."Source No." := PostedShipDoc."Source No.";
                TmpPostedShipDocCost2LCY."Posted Whse. Receipt No." := PostedShipDoc."Posted Whse. Receipt No.";
                TmpPostedShipDocCost2LCY."Posted Whse. Shipment No." := PostedShipDoc."Posted Whse. Shipment No.";
                //POENAB02, 09.06.2026<<
                TmpPostedShipDocCost2LCY."Currency Code" := PostedShipDoc."Currency Code";
                if PostedShipDoc."Currency Code" <> '' then begin
                    TmpCurrencyFactor.Get(PostedShipDoc."Currency Code");
                    //POENAB02, 09.06.2026>>
                    //TmpPostedShipDocCost2LCY."Cost Amount" :=
                    TmpPostedShipDocCost2LCY.Amount :=
                    //POENAB02, 09.06.2026<<
                      Round(
                        CurrExchRate.ExchangeAmtFCYToLCYAdjmt(
                          EndingDate, PostedShipDoc."Currency Code",
                          //POENAB02, 09.06.2026>>
                          //PostedShipDoc."Cost Amount",
                          PostedShipDoc.Amount,
                          //POENAB02, 09.06.2026<<
                          TmpCurrencyFactor."Currency Factor"),
                          Currency."Amount Rounding Precision");
                end else
                    //POENAB02, 09.06.2026>>
                    //TmpPostedShipDocCost2LCY."Cost Amount" := PostedShipDoc."Cost Amount";
                    TmpPostedShipDocCost2LCY.Amount := PostedShipDoc.Amount;
                //POENAB02, 09.06.2026<<
                if TmpPostedShipDocCost2LCY.Insert(false) then;
            until PostedShipDoc.Next() = 0;
    end;

    local procedure InsertShipments();
    var
        LocalPostedTradeCostOrderAPS: Record "Posted Trade Cost Order APS";
    begin
        //HEI.20>>

        ItemLedgEntry.SetCurrentKey("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date");
        ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
        ItemLedgEntry.SetFilter("Document Type", '%1|%2', ItemLedgEntry."Document Type"::"Sales Shipment", ItemLedgEntry."Document Type"::"Sales Invoice");

        if GuiAllowed then begin
            NoOfRecords := ItemLedgEntry.Count;
            NoOfRecProgress := NoOfRecords div 100;
            Counter := 0;
            NoOfProgresed := 0;
            TimeProgress := Time;
        end;

        if ItemLedgEntry.FindSet(false) then
            repeat
                if GuiAllowed then begin //HEI.07<<
                    Counter += 1;
                    if Counter >= NoOfRecProgress
                    then begin
                        NoOfProgresed := NoOfProgresed + Counter;
                        Window.Update(1, Round(NoOfProgresed / NoOfRecords * 10000, 1));
                        Counter := 0;
                        TimeProgress := Time;
                    end;
                end;
                Found := false;
                InsertDoc := false;
                //check the shipments
                //HEI.11>>
                /*
                PostedWhseShipLine.RESET;
                PostedWhseShipLine.SETCURRENTKEY("Posting Date","Posted Source No.","Source Line No.","Location Code");
                PostedWhseShipLine.SETRANGE("Posting Date","Posting Date");
                PostedWhseShipLine.SETRANGE("Posted Source No.","Document No.");
                PostedWhseShipLine.SETRANGE("Source Line No.","Document Line No.");
                PostedWhseShipLine.SETRANGE("Location Code","Location Code");
                IF PostedWhseShipLine.FINDFIRST THEN BEGIN
                  Item.GET(PostedWhseShipLine."Item No.");
                  IF (NOT FindNonRPMItems(PostedWhseShipLine."No.",DocType::Shipment)) OR (STRPOS(InventorySetup."Finished Goods Item Cat Code",Item."Item Category Code") <> 0) THEN
                    InsertDoc := TRUE
                  ELSE BEGIN
                    //if other category code, then check the Posted Doc. shipp. cost
                    PostedDocumentShippingCost.RESET;
                    PostedDocumentShippingCost.SETRANGE("Source No.",PostedWhseShipLine."No.");
                    IF PostedDocumentShippingCost.FINDFIRST THEN
                      InsertDoc := TRUE;
                  END;
                */

                PostedWhseShipLine.Reset();
                //HEI.13>>
                //PostedWhseShipLine.SETRANGE("Sequence No.",EntryNo);
                PostedWhseShipLine.SetRange("Sequence No. FND", ItemLedgEntry."Entry No.");
                //HEI.13<<
                if PostedWhseShipLine.Find('-') then begin
                    //HEI.20>>
                    /*
                    Item.GET(PostedWhseShipLine."Item No.");
                    IF (NOT FindNonRPMItems(PostedWhseShipLine."No.",DocType::Shipment)) OR (STRPOS(InventorySetup."Finished Goods Item Cat Code",Item."Item Category Code") <> 0) THEN
                    */
                    FindNonRPMItemBool := FindNonRPMItems(PostedWhseShipLine."No.", DocType::Shipment);
                    if (not FindNonRPMItems(PostedWhseShipLine."No.", DocType::Shipment)) or (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", ItemLedgEntry."Item Category Code") <> 0) then
                        //HEI.20<<
                        InsertDoc := true
                    else begin
                        if PostedWhseShipLine."Whse. Shipment No." <> '' then
                            InsertDoc := true;
                    end;
                    //HEI.11<<
                    if InsertDoc then begin
                        ShippingAllocation.Init();
                        //HEI.07>>
                        //ShippingAllocation."Entry No." := FindLastAllocated;
                        EntryNo := EntryNo + 1;
                        ShippingAllocation."Entry No." := EntryNo;
                        //HEI.07<<
                        ShippingAllocation."Item Category Code" := ItemLedgEntry."Item Category Code";
                        ShippingAllocation."Posting Date" := PostedWhseShipLine."Posting Date";
                        ShippingAllocation."No." := PostedWhseShipLine."No.";
                        //HEI.11>>
                        //ShippingAllocation."Line No." := PostedWhseShipLine."Line No.";
                        ShippingAllocation."Line No." := PostedWhseShipLine."Load No. FND";
                        //HEI.11<<
                        ShippingAllocation."Source Document" := ShippingAllocation."Source Document"::"Sales Order";
                        ShippingAllocation."Source No." := PostedWhseShipLine."Source No.";
                        ShippingAllocation."Source Line No." := PostedWhseShipLine."Source Line No.";
                        ShippingAllocation."Item No." := PostedWhseShipLine."Item No.";
                        ShippingAllocation."Unit of Measure Code" := PostedWhseShipLine."Unit of Measure Code";
                        ShippingAllocation."Posted Source Document" := ShippingAllocation."Posted Source Document"::"Posted Shipment";
                        ShippingAllocation."Posted Source Document No." := PostedWhseShipLine."Posted Source No.";
                        ShippingAllocation."Destination Type" := PostedWhseShipLine."Destination Type".AsInteger();
                        ShippingAllocation."Destination No." := PostedWhseShipLine."Destination No.";
                        ShippingAllocation."Location Code" := PostedWhseShipLine."Location Code";
                        ShippingAllocation.Description := PostedWhseShipLine.Description;
                        ShippingAllocation."Period Date" := FORMAT(StartingDate) + '..' + FORMAT(EndingDate); //HEI.05

                        //HEI.20>>
                        //IF FindNonRPMItems(PostedWhseShipLine."No.",DocType::Shipment) THEN
                        if FindNonRPMItemBool then
                            //HEI.20>>
                            ShippingAllocation."Only RPM Transportation" := false
                        else
                            ShippingAllocation."Only RPM Transportation" := true;

                        ShippingAllocation."Dimension Set ID" := ItemLedgEntry."Dimension Set ID";
                        ShippingAllocation."Lot No." := ItemLedgEntry."Lot No.";
                        ShippingAllocation."Lot No. & Destination No." := ShippingAllocation."Lot No." + ShippingAllocation."Destination No.";
                        ShippingAllocation."Lot No. & Location Code" := ShippingAllocation."Lot No." + ShippingAllocation."Location Code";
                        ShippingAllocation."Quantity (Base UoM)" := -ItemLedgEntry.Quantity;

                        //Net Weight
                        if (ShippingAllocation."Only RPM Transportation") or (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", ItemLedgEntry."Item Category Code") <> 0) then begin //HEI.03
                            CheckNetWeight(ShippingAllocation."Item No.");
                            //ShippingAllocation."Total Net Weight (Kg)" := CalcTotalNetWeight(ShippingAllocation."No.",DocType::Shipment,ShippingAllocation."Only RPM Transportation"); //HEI.04 commented
                            //ShippingAllocation."Net Weight (Kg)" := CalcNetWeight(ShippingAllocation."Item No.",ShippingAllocation."Quantity (Base UoM)");//HEI.04 commented
                            //HEI.04<<
                            ShippingAllocation."Total Net Weight (Kg)" := ABS(CalcTotalNetWeight(ShippingAllocation."No.", DocType::Shipment, ShippingAllocation."Only RPM Transportation"));
                            ShippingAllocation."Net Weight (Kg)" := ABS(CalcNetWeight(ShippingAllocation."Item No.", ShippingAllocation."Quantity (Base UoM)"));
                            //HEI.04<<
                        end; //HEI.03

                        //HEI.02
                        if CheckReversedLines(ShippingAllocation."No.", DocType::Shipment, ShippingAllocation."Item No.") = 0 then begin
                            ShippingAllocation.Reversed := true;
                            ShippingAllocation."Quantity (Base UoM)" := 0;
                            ShippingAllocation."Net Weight (Kg)" := 0;
                        end;
                        //HEI.02

                        //get info from Posted Doc. shipping Cost
                        GetDocShipCostDetails(ShippingAllocation, true);

                        //HEI.04<<
                        PostedWhseShipmentHeader.Reset();
                        PostedWhseShipmentHeader.Get(PostedWhseShipLine."No.");
                        ShippingAllocation."Shipping Agent Code" := PostedWhseShipmentHeader."Shipping Agent Code";
                        ShippingAllocation."Shipping Agent Service Code" := PostedWhseShipmentHeader."Shipping Agent Service Code";
                        // BC Upgrade POENAB02 >>
                        // code commented, as Route and "Route Planning No." belongs to Aptean
                        //ShippingAllocation.Route := PostedWhseShipmentHeader.Route;
                        //ShippingAllocation."Route Planning No." := PostedWhseShipmentHeader."Route Planning No.";
                        // BC Upgrade POENAB02<<
                        //POENAB02, 09.06.2026>>
                        ShippingAllocation.Route := PostedWhseShipmentHeader."Route 107FDW";
                        ShippingAllocation."Route Planning No." := PostedWhseShipmentHeader."Route Planning No. 107FDW";
                        //POENAB02, 09.06.2026<<

                        ShippingAgent.Reset();
                        if ShippingAgent.Get(ShippingAllocation."Shipping Agent Code") then
                            ShippingAllocation."Own Fleet" := ShippingAgent."Own Logistics FND";
                        if ShippingAllocation."Own Fleet" then begin
                            //HEI.18>>
                            if ((STRPOS(InventorySetup."Finished Goods ItemCatCode FND", ShippingAllocation."Item Category Code") <> 0) and (not ShippingAllocation."Only RPM Transportation"))
                              or
                              ((STRPOS(SalesReceivSetup."RPMRelatedItemCategoryCode FND", ShippingAllocation."Item Category Code") <> 0) and (ShippingAllocation."Only RPM Transportation")
                              //HEI.19>>
                              and (ShippingAllocation."Source Document" <> ShippingAllocation."Source Document"::"Sales Order")
                              //HEI.19<<
                              )
                            then begin
                                // BC Upgrade POENAB02 >>
                                // code commented, as PostedWhseShipmentHeader.Distance belongs to Aptean
                                /*
                                //HEI.18<<
                                if PostedWhseShipmentHeader.Distance <> 0 then
                                    ShippingAllocation.Distance := PostedWhseShipmentHeader.Distance
                                else
                                    ShippingAllocation.Distance := GetReceiptDistance(ShippingAllocation."Posted Source Document No.");
                                */
                                // BC Upgrade POENAB02 <<
                                ShippingAllocation."No. of Drops" := CountDrops(ShippingAllocation);
                            end; //HEI.18
                        end;
                        //HEI.04>>

                        //get picking factor
                        // BC Upgrade POENAB02 >>
                        // code commented, as InventorySetup.Pallet belongs to Aptean
                        /*
                        //HEI.17>>
                        //IF ItemUnitofMeasure.GET(ShippingAllocation."Item No.",InventorySetup.Pallet) THEN
                        if (ItemUnitofMeasure.Get(ShippingAllocation."Item No.", InventorySetup.Pallet)) and
                          ((StrPos(InventorySetup."Finished Goods Item Cat Code", ShippingAllocation."Item Category Code") <> 0) or
                          (StrPos(SalesReceivSetup."RPM Related Item Category Code", ShippingAllocation."Item Category Code") <> 0))
                        then
                            //HEI.17<<
                            ShippingAllocation."No. of Pallets" := ShippingAllocation."Quantity (Base UoM)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                        */
                        // BC Upgrade POENAB02 <<
                        //POENAB02, 09.06.2026>>
                        if (ItemUnitofMeasure.Get(ShippingAllocation."Item No.", DrinkITFoundationSetup."Pallet Unit Of Measure")) and
                          ((StrPos(InventorySetup."Finished Goods ItemCatCode FND", ShippingAllocation."Item Category Code") <> 0) or
                          (StrPos(SalesReceivSetup."RPMRelatedItemCategoryCode FND", ShippingAllocation."Item Category Code") <> 0))
                        then
                            ShippingAllocation."No. of Pallets" := ShippingAllocation."Quantity (Base UoM)" / ItemUnitofMeasure."Qty. per Unit of Measure";
                        //POENAB02, 09.06.2026<<

                        if (ShippingAllocation."No. of Pallets" mod 1 = 0) then
                            ShippingAllocation."Picking Factor" := ShippingAllocation."No. of Pallets"
                        else
                            ShippingAllocation."Picking Factor" := (ShippingAllocation."No. of Pallets" div 1) + WhseSetup."Picking Coeff. Non-Pallet FND";

                        if ShippingAllocation."Total Net Weight (Kg)" <> 0 then
                            ShippingAllocation."Primary Allocated Amount" := ABS((ShippingAllocation."Net Weight (Kg)" * ShippingAllocation."Total Shipping Cost Amount") / ShippingAllocation."Total Net Weight (Kg)");

                        if (not ShippingAllocation."Only RPM Transportation") and (ShippingAllocation."Lot No." <> '') and (ShippingAllocation."Source Document" = ShippingAllocation."Source Document"::"Outbound Transfer") then
                            FindOriginalLotDestination(ShippingAllocation);

                        ShippingAllocation."Distribution Type" := ShippingAllocation."Distribution Type"::Total; //HEI.02

                        //HEI.13>>
                        ShippingAllocation."Processing Date" := WorkDate();
                        //HEI.13<<

                        //POENAB02, 06.08.2026, BCUP0-247>>
                        LocalPostedTradeCostOrderAPS.Reset();
                        LocalPostedTradeCostOrderAPS.SetCurrentKey("Posted Whse. Shipment No.");
                        LocalPostedTradeCostOrderAPS.SetRange("Posted Whse. Shipment No.", PostedWhseShipmentHeader."No.");
                        if LocalPostedTradeCostOrderAPS.FindFirst() then begin
                            ShippingAllocation."Cost Center Code" := LocalPostedTradeCostOrderAPS."Cost Center Code";
                            ShippingAllocation."Posted Whse. Shipment No." := LocalPostedTradeCostOrderAPS."Posted Whse. Shipment No.";
                            ShippingAllocation."Posted Whse. Receipt No." := LocalPostedTradeCostOrderAPS."Posted Whse. Receipt No.";
                        end;
                        //POENAB02, 06.08.2026, BCUP0-247<<
                        ShippingAllocation.Insert();
                        //HEI.18>> for the moment always is FALSE. It doesn't make sense to do it. Save some milisec
                        /*
                        IF Split THEN
                          InsertChildLines(ShippingAllocation,TRUE);  //HEI.02
                        */
                        //HEI.18<<
                        Inserted := true;
                        Found := true;
                    end;
                end;

                //Step 2- find the invoices related to shipments: if found - add the invoice qty; if not found - insert a new line
                ValueEntry.Reset();
                //HEI.18>>
                /*
                ValueEntry.SETCURRENTKEY("Posting Date","Item Ledger Entry No.","Document Type","Invoiced Quantity in HL");
                ValueEntry.SETRANGE("Posting Date",StartingDate,EndingDate);
                ValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ValueEntry.SETRANGE("Document Type",ValueEntry."Document Type"::"Sales Invoice");
                ValueEntry.SETFILTER("Invoiced Quantity in HL",'<>%1',0);
                */
                ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                //HEI.18<<
                if ValueEntry.FindSet(false) then
                    repeat //HEI.07>>
                           //HEI.18>>
                        if (ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Invoice")
                        then begin
                            //HEI.18<<
                            if Found then begin
                                // BC Upgrade POENAB02 >>
                                // code commented, as ValueEntry."Invoiced Quantity in HL" belongs to Aptean
                                //ShippingAllocation."Quantity HL" += -ValueEntry."Invoiced Quantity in HL";
                                // BC Upgrade POENAB02 <<
                                //POENAB02, 09.06.2026>>
                                ShippingAllocation."Quantity HL" += -ValueEntry."Invoiced Quantity HL FND";
                                //POENAB02, 09.06.2026<<
                                ShippingAllocation.Modify();
                                //HEI.18>> for the moment always is FALSE. It doesn't make sense to do it. Save some milisec
                                /*
                                IF Split THEN
                                  UpdateChidLines(ShippingAllocation); //HEI.02
                                */
                                //HEI.18<<
                            end else begin
                                //HEI.20>>
                                /*
                                SalesInvLine.RESET;
                                SalesInvLine.SETRANGE("Document No.",ValueEntry."Document No.");
                                SalesInvLine.SETRANGE("Line No.",ValueEntry."Document Line No.");
                                SalesInvLine.SETRANGE(Type,SalesInvLine.Type::Item);
                                IF SalesInvLine.FINDFIRST THEN BEGIN
                                  Item.GET(SalesInvLine."No.");
                                  IF (NOT FindNonRPMItems(SalesInvLine."Document No.",DocType::Invoice)) OR (STRPOS(InventorySetup."Finished Goods Item Cat Code",Item."Item Category Code") <> 0) THEN BEGIN
                                */
                                FindNonRPMItemBool := FindNonRPMItems(ValueEntry."Document No.", DocType::Invoice);
                                if (not FindNonRPMItemBool) or (StrPos(InventorySetup."Finished Goods ItemCatCode FND", ItemLedgEntry."Item Category Code") <> 0) then begin
                                    //HEI.20<<
                                    ShippingAllocation.Init();
                                    //HEI.07>>
                                    //ShippingAllocation."Entry No." := FindLastAllocated;
                                    EntryNo := EntryNo + 1;
                                    ShippingAllocation."Entry No." := EntryNo;
                                    //HEI.07<<

                                    //HEI.20>>
                                    /*
                                    ShippingAllocation."Item Category Code" := Item."Item Category Code";
                                    ShippingAllocation."Posting Date" := SalesInvLine."Posting Date";
                                    ShippingAllocation."No." := SalesInvLine."Document No.";
                                    ShippingAllocation."Line No." := SalesInvLine."Line No.";
                                    */
                                    ShippingAllocation."Item Category Code" := ItemLedgEntry."Item Category Code";
                                    ShippingAllocation."Posting Date" := ValueEntry."Posting Date";
                                    ShippingAllocation."No." := ValueEntry."Document No.";
                                    ShippingAllocation."Line No." := ValueEntry."Document Line No.";
                                    //HEI.20<<

                                    ShippingAllocation."Source Document" := ShippingAllocation."Source Document"::"Sales Invoice";
                                    //HEI.20>>
                                    /*
                                    ShippingAllocation."Source No." := SalesInvLine."Order No.";
                                    ShippingAllocation."Source Line No." := SalesInvLine."Order Line No.";
                                    ShippingAllocation."Item No." := SalesInvLine."No.";
                                    ShippingAllocation."Unit of Measure Code" := SalesInvLine."Unit of Measure Code";
                                    */
                                    ShippingAllocation."Source No." := ValueEntry."Order No.";
                                    ShippingAllocation."Source Line No." := ValueEntry."Order Line No.";
                                    ShippingAllocation."Item No." := ItemLedgEntry."Item No.";
                                    ShippingAllocation."Unit of Measure Code" := ItemLedgEntry."Unit of Measure Code";
                                    //HEI.20<<

                                    ShippingAllocation."Posted Source Document" := ShippingAllocation."Posted Source Document"::"Posted Sales Invoice";
                                    ShippingAllocation."Posted Source Document No." := ValueEntry."Document No.";
                                    ShippingAllocation."Destination Type" := ShippingAllocation."Destination Type"::Customer;
                                    ShippingAllocation."Destination No." := ItemLedgEntry."Source No.";
                                    //HEI.20>>
                                    /*
                                    ShippingAllocation."Location Code" := SalesInvLine."Location Code";
                                    ShippingAllocation.Description := SalesInvLine.Description;
                                    */
                                    ShippingAllocation."Location Code" := ItemLedgEntry."Location Code";
                                    ShippingAllocation.Description := ItemLedgEntry.Description;
                                    //HEI.20<<

                                    ShippingAllocation."Dimension Set ID" := ItemLedgEntry."Dimension Set ID";
                                    ShippingAllocation."Lot No." := ItemLedgEntry."Lot No.";
                                    ShippingAllocation."Lot No. & Destination No." := ShippingAllocation."Lot No." + ShippingAllocation."Destination No.";
                                    ShippingAllocation."Lot No. & Location Code" := ShippingAllocation."Lot No." + ShippingAllocation."Location Code";
                                    ShippingAllocation."Quantity (Base UoM)" := -ValueEntry."Item Ledger Entry Quantity";
                                    // BC Upgrade POENAB02 >>
                                    // code commented, as ValueEntry."Invoiced Quantity in HL" belongs to Aptean
                                    //ShippingAllocation."Quantity HL" += -ValueEntry."Invoiced Quantity in HL";
                                    // BC Upgrade POENAB02 <<
                                    //POENAB02, 09.06.2026>>
                                    ShippingAllocation."Quantity HL" += -ValueEntry."Invoiced Quantity HL FND";
                                    //POENAB02, 09.06.2026<<
                                    ShippingAllocation."Period Date" := FORMAT(StartingDate) + '..' + FORMAT(EndingDate); //HEI.05

                                    //HEI.20>>
                                    //IF FindNonRPMItems(ValueEntry."Document No.",DocType::Invoice) THEN
                                    if FindNonRPMItemBool then
                                        //HEI.20>>
                                        ShippingAllocation."Only RPM Transportation" := false
                                    else
                                        ShippingAllocation."Only RPM Transportation" := true;

                                    //Net Weight
                                    //HEI.20>>
                                    //IF (ShippingAllocation."Only RPM Transportation") OR (STRPOS(InventorySetup."Finished Goods Item Cat Code",Item."Item Category Code") <> 0) THEN BEGIN //HEI.03
                                    if (ShippingAllocation."Only RPM Transportation") or (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", ItemLedgEntry."Item Category Code") <> 0) then begin
                                        //HEI.20<<
                                        CheckNetWeight(ShippingAllocation."Item No.");
                                        //ShippingAllocation."Total Net Weight (Kg)" := CalcTotalNetWeight(ShippingAllocation."No.",DocType::Invoice,ShippingAllocation."Only RPM Transportation"); //HEI.04 commented
                                        //ShippingAllocation."Net Weight (Kg)" := CalcNetWeight(ShippingAllocation."Item No.",ShippingAllocation."Quantity (Base UoM)"); //HEI.04 commented
                                        //HEI.04<<
                                        ShippingAllocation."Total Net Weight (Kg)" := ABS(CalcTotalNetWeight(ShippingAllocation."No.", DocType::Invoice, ShippingAllocation."Only RPM Transportation"));
                                        ShippingAllocation."Net Weight (Kg)" := ABS(CalcNetWeight(ShippingAllocation."Item No.", ShippingAllocation."Quantity (Base UoM)"));
                                        //HEI.04>>
                                    end; //HEI.03

                                    //HEI.02
                                    if CheckReversedLines(ShippingAllocation."No.", DocType::Invoice, ShippingAllocation."Item No.") = 0 then begin
                                        ShippingAllocation.Reversed := true;
                                        ShippingAllocation."Quantity (Base UoM)" := 0;
                                        ShippingAllocation."Net Weight (Kg)" := 0;
                                    end;
                                    //HEI.02

                                    //get info from Posted Doc. shipping Cost
                                    GetDocShipCostDetails(ShippingAllocation, true);

                                    if ShippingAllocation."Total Net Weight (Kg)" <> 0 then
                                        ShippingAllocation."Primary Allocated Amount" := ABS((ShippingAllocation."Net Weight (Kg)" * ShippingAllocation."Total Shipping Cost Amount") / ShippingAllocation."Total Net Weight (Kg)");

                                    ShippingAllocation."Distribution Type" := ShippingAllocation."Distribution Type"::Total; //HEI.02

                                    //HEI.13>>
                                    ShippingAllocation."Processing Date" := WorkDate();
                                    //HEI.13<<

                                    //POENAB02, 06.08.2026, BCUP0-247>>
                                    ShippingAllocation."Cost Center Code" := LocalPostedTradeCostOrderAPS."Cost Center Code";
                                    ShippingAllocation."Posted Whse. Shipment No." := PostedTradeCostOrderAPS."Posted Whse. Shipment No.";
                                    ShippingAllocation."Posted Whse. Receipt No." := PostedTradeCostOrderAPS."Posted Whse. Receipt No.";
                                    //POENAB02, 06.08.2026, BCUP0-247<<
                                    ShippingAllocation.Insert();
                                    Inserted := true;
                                end;
                            end;
                        end;
                    //END; //HEI.18
                    until ValueEntry.Next() = 0;
            until ItemLedgEntry.Next() = 0;

    end;

    local procedure InsertReturns();
    var
        LocalPostedTradeCostOrderAPS: Record "Posted Trade Cost Order APS";
    begin
        //HEI.20>>

        ItemLedgEntry.Reset();
        ItemLedgEntry.SetCurrentKey("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date");
        ItemLedgEntry.SetRange("Entry Type", ItemLedgEntry."Entry Type"::Sale);
        ItemLedgEntry.SetFilter("Document Type", '%1|%2', ItemLedgEntry."Document Type"::"Sales Return Receipt", ItemLedgEntry."Document Type"::"Sales Credit Memo");

        if GuiAllowed then begin //HEI.07<<
            NoOfRecords2 := ItemLedgEntry.Count;
            NoOfRecProgress2 := NoOfRecords2 div 100;
            Counter2 := 0;
            NoOfProgresed2 := 0;
            TimeProgress2 := Time();
        end;

        if ItemLedgEntry.FindSet(false) then
            repeat
                if GuiAllowed then begin //HEI.07<<
                    Counter2 += 1;
                    if Counter2 >= NoOfRecProgress2 then begin
                        NoOfProgresed2 := NoOfProgresed2 + Counter2;
                        Window.Update(2, Round(NoOfProgresed2 / NoOfRecords2 * 10000, 1));
                        Counter2 := 0;
                        TimeProgress2 := Time();
                    end;
                end;

                Found := false;
                InsertDoc := false;

                //HEI.11
                /*
                PostedWhseReceiptLine.RESET;
                PostedWhseReceiptLine.SETCURRENTKEY("Posting Date","Posted Source No.","Source Line No.","Location Code");
                PostedWhseReceiptLine.SETRANGE("Posting Date","Posting Date");
                PostedWhseReceiptLine.SETRANGE("Posted Source No.","Document No.");
                PostedWhseReceiptLine.SETRANGE("Source Line No.","Document Line No.");
                PostedWhseReceiptLine.SETRANGE("Location Code","Location Code");
                IF PostedWhseReceiptLine.FINDFIRST THEN BEGIN
                  Item.GET(PostedWhseReceiptLine."Item No.");
                  IF (NOT FindNonRPMItems(PostedWhseReceiptLine."No.",DocType::Return)) OR (STRPOS(InventorySetup."Finished Goods Item Cat Code",Item."Item Category Code") <> 0) THEN
                    InsertDoc := TRUE
                  ELSE BEGIN
                    //if other category code, then check the Posted Doc. shipp. cost
                    PostedDocumentShippingCost.RESET;
                    PostedDocumentShippingCost.SETRANGE("Source No.",PostedWhseReceiptLine."No.");
                    IF PostedDocumentShippingCost.FINDFIRST THEN
                      InsertDoc := TRUE;
                  END;
                */
                PostedWhseReceiptLine.Reset();
                //HEI.12>>
                //PostedWhseReceiptLine.SETRANGE("Sequence No.",EntryNo);
                PostedWhseReceiptLine.SetRange("Sequence No. FND", ItemLedgEntry."Entry No.");
                //HEI.12<<
                if PostedWhseReceiptLine.Find('-') then begin
                    //HEI.20>>
                    /*
                    Item.GET(PostedWhseReceiptLine."Item No.");
                    IF (NOT FindNonRPMItems(PostedWhseReceiptLine."No.",DocType::Return)) OR (STRPOS(InventorySetup."Finished Goods Item Cat Code",Item."Item Category Code") <> 0) THEN
                    */
                    FindNonRPMItemBool := FindNonRPMItems(PostedWhseReceiptLine."No.", DocType::Return);
                    if (not FindNonRPMItemBool) or (StrPos(InventorySetup."Finished Goods ItemCatCode FND", ItemLedgEntry."Item Category Code") <> 0) then
                        //HEI.20<<
                        InsertDoc := true
                    else begin
                        if PostedWhseReceiptLine."Whse. Receipt No." <> '' then
                            InsertDoc := true;
                    end;
                    //HEI.11<<

                    if InsertDoc then begin
                        ShippingAllocation.Init();
                        //HEI.07>>
                        //ShippingAllocation."Entry No." := FindLastAllocated;
                        EntryNo := EntryNo + 1;
                        ShippingAllocation."Entry No." := EntryNo;
                        //HEI.07<<
                        ShippingAllocation."Item Category Code" := ItemLedgEntry."Item Category Code";
                        ShippingAllocation."Posting Date" := PostedWhseReceiptLine."Posting Date";
                        ShippingAllocation."No." := PostedWhseReceiptLine."No.";
                        //HEI.11>>
                        //ShippingAllocation."Line No." := PostedWhseReceiptLine."Line No.";
                        ShippingAllocation."Line No." := PostedWhseReceiptLine."Load No. FND";
                        //HEI.11<<
                        ShippingAllocation."Source Document" := ShippingAllocation."Source Document"::"Sales Return Order";
                        ShippingAllocation."Source No." := PostedWhseReceiptLine."Source No.";
                        ShippingAllocation."Source Line No." := PostedWhseReceiptLine."Source Line No.";
                        ShippingAllocation."Item No." := PostedWhseReceiptLine."Item No.";
                        ShippingAllocation.Description := PostedWhseReceiptLine.Description;
                        ShippingAllocation."Unit of Measure Code" := PostedWhseReceiptLine."Unit of Measure Code";
                        ShippingAllocation."Posted Source Document" := ShippingAllocation."Posted Source Document"::"Posted Return Receipt";
                        ShippingAllocation."Posted Source Document No." := PostedWhseReceiptLine."Posted Source No.";
                        ShippingAllocation."Destination Type" := ShippingAllocation."Destination Type"::Customer;
                        ShippingAllocation."Destination No." := ItemLedgEntry."Source No.";
                        ShippingAllocation."Location Code" := PostedWhseReceiptLine."Location Code";
                        ShippingAllocation."Period Date" := FORMAT(StartingDate) + '..' + FORMAT(EndingDate); //HEI.05

                        ShippingAllocation."Quantity (Base UoM)" := -ItemLedgEntry.Quantity;

                        //HEI.20>>
                        //IF FindNonRPMItems(ShippingAllocation."No.",DocType::Return) THEN
                        if (FindNonRPMItemBool) then
                            //HEI.20<<
                            ShippingAllocation."Only RPM Transportation" := false
                        else
                            ShippingAllocation."Only RPM Transportation" := true;

                        ShippingAllocation."Dimension Set ID" := ItemLedgEntry."Dimension Set ID";
                        ShippingAllocation."Lot No." := ItemLedgEntry."Lot No.";
                        ShippingAllocation."Lot No. & Destination No." := ShippingAllocation."Lot No." + ShippingAllocation."Destination No.";
                        ShippingAllocation."Lot No. & Location Code" := ShippingAllocation."Lot No." + ShippingAllocation."Location Code";

                        //Net Weight
                        if (ShippingAllocation."Only RPM Transportation") or (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", ItemLedgEntry."Item Category Code") <> 0) then begin //HEI.03
                            CheckNetWeight(ItemLedgEntry."Item No.");
                            //ShippingAllocation."Total Net Weight (Kg)" := CalcTotalNetWeight(ShippingAllocation."No.",DocType::Return,ShippingAllocation."Only RPM Transportation"); HEI.04
                            //ShippingAllocation."Net Weight (Kg)" := CalcNetWeight(ShippingAllocation."Item No.",-ShippingAllocation."Quantity (Base UoM)"); HEI.04
                            //HEI.04<<<
                            ShippingAllocation."Total Net Weight (Kg)" := ABS(CalcTotalNetWeight(ShippingAllocation."No.", DocType::Return, ShippingAllocation."Only RPM Transportation"));
                            ShippingAllocation."Net Weight (Kg)" := ABS(CalcNetWeight(ShippingAllocation."Item No.", -ShippingAllocation."Quantity (Base UoM)"));
                            //HEI.04>>
                        end; //HEI.03

                        //HEI.02
                        if CheckReversedLines(ShippingAllocation."No.", DocType::Return, ShippingAllocation."Item No.") = 0 then begin
                            ShippingAllocation.Reversed := true;
                            ShippingAllocation."Quantity (Base UoM)" := 0;
                            ShippingAllocation."Net Weight (Kg)" := 0;
                        end;
                        //HEI.02

                        //get info from Posted Doc. shipping Cost
                        GetDocShipCostDetails(ShippingAllocation, false);

                        //HEI.04<<
                        PostedWhseReceiptHeader.Reset();
                        PostedWhseReceiptHeader.Get(PostedWhseReceiptLine."No.");
                        // BC Upgrade POENAB02 >>
                        // code commented, as fields below are dependent on Aptean
                        /*
                        ShippingAllocation."Shipping Agent Code" := PostedWhseReceiptHeader."Shipping Agent Code";
                        ShippingAllocation."Shipping Agent Service Code" := PostedWhseReceiptHeader."Shipping Agent Service Code";
                        ShippingAllocation.Route := PostedWhseReceiptHeader.Route;
                        ShippingAllocation."Route Planning No." := PostedWhseReceiptHeader."Route Planning No.";
                        */
                        // BC Upgrade POENAB02<<
                        //POENAB02, 09.06.2026>>
                        ShippingAllocation."Shipping Agent Code" := PostedWhseReceiptHeader."Shipping Agent Code 107FDW";
                        ShippingAllocation."Shipping Agent Service Code" := PostedWhseReceiptHeader."Shipp. Agent Serv. 107FDW";
                        ShippingAllocation.Route := PostedWhseReceiptHeader."Route 107FDW";
                        ShippingAllocation."Route Planning No." := PostedWhseReceiptHeader."Route Planning No. 107FDW";
                        //POENAB02, 09.06.2026<<

                        ShippingAgent.Reset();
                        if ShippingAgent.Get(ShippingAllocation."Shipping Agent Code") then
                            ShippingAllocation."Own Fleet" := ShippingAgent."Own Logistics FND";
                        if ShippingAllocation."Own Fleet" then begin
                            //HEI.18>>
                            if ((StrPos(InventorySetup."Finished Goods ItemCatCode FND", ShippingAllocation."Item Category Code") <> 0) and (not ShippingAllocation."Only RPM Transportation"))
                              or
                              ((StrPos(SalesReceivSetup."RPMRelatedItemCategoryCode FND", ShippingAllocation."Item Category Code") <> 0) and (ShippingAllocation."Only RPM Transportation")
                              //HEI.19>>
                              and (ShippingAllocation."Source Document" <> ShippingAllocation."Source Document"::"Sales Order")
                              //HEI.19<<
                              )
                            then begin
                                //HEI.18<<
                                // BC Upgrade POENAB02 >>
                                // code commented, as PostedWhseReceiptHeader.Distance is dependent on Aptean
                                //ShippingAllocation.Distance := PostedWhseReceiptHeader.Distance;
                                // BC Upgrade POENAB02 <<
                                ShippingAllocation."No. of Drops" := CountDrops(ShippingAllocation);
                            end; //HEI.18
                        end;
                        //HEI.04>>

                        if ShippingAllocation."Total Net Weight (Kg)" <> 0 then
                            ShippingAllocation."Primary Allocated Amount" := ABS((ShippingAllocation."Net Weight (Kg)" * ShippingAllocation."Total Shipping Cost Amount") / ShippingAllocation."Total Net Weight (Kg)");

                        ShippingAllocation."Distribution Type" := ShippingAllocation."Distribution Type"::Total; //HEI.02

                        //HEI.13>>
                        ShippingAllocation."Processing Date" := WorkDate();
                        //HEI.13<<

                        //POENAB02, 06.08.2026, BCUP0-247>>
                        LocalPostedTradeCostOrderAPS.Reset();
                        LocalPostedTradeCostOrderAPS.SetCurrentKey("Posted Whse. Receipt No.");
                        LocalPostedTradeCostOrderAPS.SetRange("Posted Whse. Receipt No.", PostedWhseReceiptHeader."No.");
                        if LocalPostedTradeCostOrderAPS.FindFirst() then begin
                            ShippingAllocation."Cost Center Code" := LocalPostedTradeCostOrderAPS."Cost Center Code";
                            ShippingAllocation."Posted Whse. Shipment No." := LocalPostedTradeCostOrderAPS."Posted Whse. Shipment No.";
                            ShippingAllocation."Posted Whse. Receipt No." := LocalPostedTradeCostOrderAPS."Posted Whse. Receipt No.";
                        end; //POENAB02, 06.08.2026, BCUP0-247<<
                        ShippingAllocation.Insert();
                        //HEI.18>> for the moment always is FALSE. It doesn't make sense to do it. Save some milisec
                        /*
                        IF Split THEN
                          InsertChildLines(ShippingAllocation,FALSE);  //HEI.02
                        */
                        //HEI.18>>
                        Inserted := true;
                        Found := true;
                    end;
                end;

                //Step 2- find the credit memos related to returns: if found - add the invoice qty; if not found - insert a new line
                ValueEntry.Reset();
                //HEI.18>>
                /*
                ValueEntry.SETCURRENTKEY("Posting Date","Item Ledger Entry No.","Document Type","Invoiced Quantity in HL");
                ValueEntry.SETRANGE("Posting Date",StartingDate,EndingDate);
                ValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                ValueEntry.SETRANGE("Document Type",ValueEntry."Document Type"::"Sales Credit Memo");
                ValueEntry.SETFILTER("Invoiced Quantity in HL",'<>%1',0);
                */
                ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                //HEI.18<<
                if ValueEntry.FindSet(false) then
                    repeat //HEI.07>>
                        if (ValueEntry."Document Type" = ValueEntry."Document Type"::"Sales Credit Memo") then begin //HEI.18
                            if Found then begin
                                // BC Upgrade POENAB02 >>
                                // code commented, as ValueEntry."Invoiced Quantity in HL" belongs to Aptean
                                //ShippingAllocation."Quantity HL" += -ValueEntry."Invoiced Quantity in HL";
                                // BC Upgrade POENAB02 <<
                                //POENAB02, 09.06.2026>>
                                ShippingAllocation."Quantity HL" += -ValueEntry."Invoiced Quantity HL FND";
                                //POENAB02, 09.06.2026<<
                                ShippingAllocation.Modify();
                                //HEI.18>> for the moment always is FALSE. It doesn't make sense to do it. Save some milisec
                                /*
                                IF Split THEN
                                  UpdateChidLines(ShippingAllocation); //HEI.02
                                */
                                //HEI.18<<
                            end else begin
                                //HEI.20>>
                                /*
                                SalesCrMemoLine.RESET;
                                SalesCrMemoLine.SETCURRENTKEY("Document No.","Line No.",Type);
                                SalesCrMemoLine.SETRANGE("Document No.",ValueEntry."Document No.");
                                SalesCrMemoLine.SETRANGE("Line No.",ValueEntry."Document Line No.");
                                SalesCrMemoLine.SETRANGE(Type,SalesCrMemoLine.Type::Item);
                                IF SalesCrMemoLine.FINDFIRST THEN BEGIN
                                  Item.GET(SalesCrMemoLine."No.");
                                  IF (NOT FindNonRPMItems(SalesCrMemoLine."Document No.",DocType::"Credit Memo")) OR (STRPOS(InventorySetup."Finished Goods Item Cat Code",Item."Item Category Code") <> 0) THEN BEGIN
                                */
                                FindNonRPMItemBool := FindNonRPMItems(ValueEntry."Document No.", DocType::"Credit Memo");
                                if (not FindNonRPMItemBool) or (StrPos(InventorySetup."Finished Goods ItemCatCode FND", ItemLedgEntry."Item Category Code") <> 0) then begin
                                    //HEI.20<<
                                    ShippingAllocation.Init();
                                    //HEI.07>>
                                    //ShippingAllocation."Entry No." := FindLastAllocated;
                                    EntryNo := EntryNo + 1;
                                    ShippingAllocation."Entry No." := EntryNo;
                                    //HEI.07<<

                                    //HEI.20>>
                                    /*
                                    ShippingAllocation."Item Category Code" := Item."Item Category Code";
                                    ShippingAllocation."Posting Date" := SalesCrMemoLine."Posting Date";
                                    ShippingAllocation."No." := SalesCrMemoLine."Document No.";
                                    ShippingAllocation."Line No." := SalesCrMemoLine."Line No.";
                                    */
                                    ShippingAllocation."Item Category Code" := ItemLedgEntry."Item Category Code";
                                    ShippingAllocation."Posting Date" := ValueEntry."Posting Date";
                                    ShippingAllocation."No." := ValueEntry."Document No.";
                                    ShippingAllocation."Line No." := ValueEntry."Document Line No.";
                                    //HEI.20<<

                                    ShippingAllocation."Source Document" := ShippingAllocation."Source Document"::"Sales Credit Memo";
                                    //HEI.20>>
                                    //SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.");
                                    SalesCrMemoHeader.Get(ValueEntry."Document No.");
                                    //HEI.20<<
                                    ShippingAllocation."Source No." := SalesCrMemoHeader."Pre-Assigned No.";
                                    //HEI.20>>
                                    /*
                                    ShippingAllocation."Source Line No." := SalesCrMemoLine."Line No.";
                                    ShippingAllocation."Item No." := SalesCrMemoLine."No.";
                                    ShippingAllocation."Unit of Measure Code" := SalesCrMemoLine."Unit of Measure Code";
                                    */
                                    ShippingAllocation."Source Line No." := ValueEntry."Document Line No.";
                                    ShippingAllocation."Item No." := ItemLedgEntry."Item No.";
                                    ShippingAllocation."Unit of Measure Code" := ItemLedgEntry."Unit of Measure Code";
                                    //HEI.20>>

                                    ShippingAllocation."Posted Source Document" := ShippingAllocation."Posted Source Document"::"Posted Sales Credit Memo";
                                    ShippingAllocation."Posted Source Document No." := ValueEntry."Document No.";
                                    ShippingAllocation."Destination Type" := ShippingAllocation."Destination Type"::Customer;
                                    ShippingAllocation."Destination No." := ItemLedgEntry."Source No.";
                                    //HEI.20>>
                                    /*
                                    ShippingAllocation."Location Code" := SalesCrMemoLine."Location Code";
                                    ShippingAllocation.Description := SalesCrMemoLine.Description;
                                    */
                                    ShippingAllocation."Location Code" := ItemLedgEntry."Location Code";
                                    ShippingAllocation.Description := ItemLedgEntry.Description;
                                    //HEI.20<<

                                    ShippingAllocation."Dimension Set ID" := ItemLedgEntry."Dimension Set ID";
                                    ShippingAllocation."Lot No." := ItemLedgEntry."Lot No.";
                                    ShippingAllocation."Lot No. & Destination No." := ShippingAllocation."Lot No." + ShippingAllocation."Destination No.";
                                    ShippingAllocation."Lot No. & Location Code" := ShippingAllocation."Lot No." + ShippingAllocation."Location Code";
                                    ShippingAllocation."Period Date" := Format(StartingDate) + '..' + Format(EndingDate); //HEI.05

                                    //ShippingAllocation."Quantity (Base UoM)" := ValueEntry."Item Ledger Entry Quantity";//HEI.04 commented
                                    //ShippingAllocation."Quantity HL" += ValueEntry."Invoiced Quantity in HL"; //HEI.04 commented
                                    //HEI.04>>
                                    // BC Upgrade POENAB02 >>
                                    // code commented, as ValueEntry."Invoiced Quantity in HL" belongs to Aptean
                                    //ShippingAllocation."Quantity HL" += -ValueEntry."Invoiced Quantity in HL";
                                    // BC Upgrade POENAB02 <<
                                    //POENAB02, 09.06.2026>>
                                    ShippingAllocation."Quantity HL" += -ValueEntry."Invoiced Quantity HL FND";
                                    //POENAB02, 09.06.2026<<
                                    ShippingAllocation."Quantity (Base UoM)" := -ValueEntry."Item Ledger Entry Quantity";
                                    //HEI.04<<

                                    //HEI.20>>
                                    //IF FindNonRPMItems(ValueEntry."Document No.",DocType::"Credit Memo") THEN
                                    //HEI.20<<
                                    if FindNonRPMItemBool then
                                        ShippingAllocation."Only RPM Transportation" := false
                                    else
                                        ShippingAllocation."Only RPM Transportation" := true;

                                    //Net Weight
                                    if (ShippingAllocation."Only RPM Transportation") or (STRPOS(InventorySetup."Finished Goods ItemCatCode FND", ItemLedgEntry."Item Category Code") <> 0) then begin //HEI.03
                                        CheckNetWeight(ShippingAllocation."Item No.");
                                        //ShippingAllocation."Total Net Weight (Kg)" := CalcTotalNetWeight(ShippingAllocation."No.",DocType::"Credit Memo",ShippingAllocation."Only RPM Transportation");
                                        //ShippingAllocation."Net Weight (Kg)" := CalcNetWeight(ShippingAllocation."Item No.",ShippingAllocation."Quantity (Base UoM)");
                                        //HEI.04<<
                                        ShippingAllocation."Total Net Weight (Kg)" := Abs(CalcTotalNetWeight(ShippingAllocation."No.", DocType::"Credit Memo", ShippingAllocation."Only RPM Transportation"));
                                        ShippingAllocation."Net Weight (Kg)" := Abs(CalcNetWeight(ShippingAllocation."Item No.", ShippingAllocation."Quantity (Base UoM)"));
                                        //HEI.04>>
                                    end; //HEI.03

                                    //HEI.02
                                    if CheckReversedLines(ShippingAllocation."No.", DocType::"Credit Memo", ShippingAllocation."Item No.") = 0 then begin
                                        ShippingAllocation.Reversed := true;
                                        ShippingAllocation."Quantity (Base UoM)" := 0;
                                        ShippingAllocation."Net Weight (Kg)" := 0;
                                    end;
                                    //HEI.02

                                    //get info from Posted Doc. shipping Cost
                                    GetDocShipCostDetails(ShippingAllocation, false);

                                    if ShippingAllocation."Total Net Weight (Kg)" <> 0 then
                                        ShippingAllocation."Primary Allocated Amount" := ABS((ShippingAllocation."Net Weight (Kg)" * ShippingAllocation."Total Shipping Cost Amount") / ShippingAllocation."Total Net Weight (Kg)");

                                    ShippingAllocation."Distribution Type" := ShippingAllocation."Distribution Type"::Total; //HEI.02

                                    //HEI.13>>
                                    ShippingAllocation."Processing Date" := WorkDate();
                                    //HEI.13<<

                                    //POENAB02, 06.08.2026, BCUP0-247>>
                                    ShippingAllocation."Cost Center Code" := LocalPostedTradeCostOrderAPS."Cost Center Code";
                                    ShippingAllocation."Posted Whse. Shipment No." := PostedTradeCostOrderAPS."Posted Whse. Shipment No.";
                                    ShippingAllocation."Posted Whse. Receipt No." := PostedTradeCostOrderAPS."Posted Whse. Receipt No.";
                                    //POENAB02, 06.08.2026, BCUP0-247<<                                   
                                    ShippingAllocation.Insert();
                                    Inserted := true;
                                end;
                            end;
                        end;
                    //END; //HEI.18
                    until ValueEntry.Next() = 0;
            until ItemLedgEntry.Next() = 0;

    end;
}

