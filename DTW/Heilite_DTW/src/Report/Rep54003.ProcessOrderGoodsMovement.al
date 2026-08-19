report 54003 "Process Order Goods Movement"
{
    // version HEI.02

    // HEI.01 FDD-PRDGAP039 IBM.Hortoc01 13-07-2017
    //   # Created new report - "Process Order Goods Movement"
    // HEI.02 FDD-PRDGAP039 IBM.POENAB01 03-08-2017
    //   #Modify the sign of Consumption Quantity.
    // HEI.03 FDD-PRDGAP056 IBM.NAIKH01 21.05.2018
    //   # Added code in Trigger OnAfterGetRecord to calculate Planned timme and Total Output Qty.
    //   #Added Code on Trigger OnAfterGetRecord of Output Dataitem to check the UMO.
    // HEI.04 IBM MATHEJ01 25.09.19 - #CHG2027163 Enhancement for Process Order Goods Movement.
    //   # Modified Functions: Output - OnAfterGetRecord(),Consumption - OnAfterGetRecord()
    //   # New Variables: Text018,ConsumptionUoM
    //   # New Columns: Text018,Consumption_ExtractContent,Output_ExtractContent
    //   # Modified RDLC layout.
    // HEI.05 CHG2066902 IBM TUDOSG01 28.04.2020
    //   # Defect-5246 - Commented code in Trigger OnAfterGetRecord to correctly calculate Total Posted Output Qty in Prod UoM
    // HEI.06 CHG2066902 IBM.LS 03.06.2020
    //   # Defect-5246 - Code added to correct the Output Quantity.
    // HEI.07 ## HB1395 IBM.AK 25.06.2020
    //   # Adding Company Info Logo
    //   # Adding Report Name and Com Info name to repeat on every page
    //   # grouping the consumption Quantities (Item No., Lot No)and adding the SubTotal in the Group Footer
    //Bc Upgrade YADAVM09 Drink it fields commented.

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Process Order Goods Movement.rdl';
    Caption = 'Process Order Goods Movement';
    ApplicationArea = all;
    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.") WHERE(Status = FILTER(Released | Finished));
            RequestFilterFields = Status, "No.";
            column(Text001; Text001)
            {
            }
            column(Text002; Text002)
            {
            }
            column(Text003; Text003)
            {
            }
            column(Text004; Text004)
            {
            }
            column(Text005; Text005)
            {
            }
            column(Text006; Text006)
            {
            }
            column(Text007; Text007)
            {
            }
            column(Text008; Text008)
            {
            }
            column(Text009; Text009)
            {
            }
            column(Text010; Text010)
            {
            }
            column(Text011; Text011)
            {
            }
            column(Text012; Text012)
            {
            }
            column(Text013; Text013)
            {
            }
            column(Text014; Text014)
            {
            }
            column(Text015; Text015)
            {
            }
            column(Text016; Text016)
            {
            }
            column(Text017; Text017)
            {
            }
            column(Text018; Text018)
            {
            }
            column(Name_CompanyInformation; CompanyInformation.Name)
            {
            }
            column(CompanyInfoPicture; CompanyInformation.Picture)
            {
            }
            column(Status_ProductionOrder; "Production Order".Status)
            {
            }
            column(No_ProductionOrder; "Production Order"."No.")
            {
            }
            column(LocationCode_ProductionOrder; "Production Order"."Location Code")
            {
            }
            column(ZoneCode_ProductionOrder; "Production Order"."Zone Code FND")
            {
            }
            column(SourceNo_ProductionOrder; "Production Order"."Source No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }

            //BC Upgrade Kamnay01 >>Added DITW field
            column(BaseUnitOfMeasure_Item; "Production Order"."Unit of Measure Code FND")
            {
            }
            //BC Upgrade Kamnay01 <<Added DITW field

            column(Quantity_ProductionOrder; "Production Order".Quantity)
            {
            }
            column(TotalOutputQty; TotalOutputQty)
            {
            }
            column(DueDate_ProductionOrder; "Production Order"."Due Date")
            {
            }
            column(CreationDate_ProductionOrder; "Production Order"."Creation Date")
            {
            }
            column(StartingDate_ProductionOrder; "Production Order"."Starting Date")
            {
            }
            column(EndingDate_ProductionOrder; "Production Order"."Ending Date")
            {
            }
            //Bc Upgrade YADAVM09 Drink it field commented>>
            //  column(RefNo_ProductionOrder; "Production Order"."Gyle No.")
            column(RefNo_ProductionOrder; '')

            {
            }
            //Bc Upgrade YADAVM09 Drink it field commented<<
            column(WorkCenterNo; WorkCenterNo)
            {
            }
            column(WorkCenterDesc; WorkCenterDesc)
            {
            }
            column(PlannedTime; TotalPlannedTime)
            {
            }
            column(TimeUOM; ManufacturingSetup."Show Capacity In")
            {
            }
            column(SortingOnConsumedItems; SortingOnConsumedItems)
            {
            }
            dataitem(Output; "Item Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.") WHERE("Entry Type" = FILTER(Output));
                column(Output_EntryNo; Output."Entry No.")
                {
                }
                column(Output_ItemNo; Output."Item No.")
                {
                }
                column(Output_UOyM; OutputUOM)
                {
                }
                column(Output_Quantity; Output.Quantity)
                {
                }
                column(Output_LotNo; Output."Lot No.")
                {
                }
                column(Output_BinCode; OutputBinCode)
                {
                }
                column(Output_PostingDate; Output."Posting Date")
                {
                }
                //Bc Upgrade YADAVM09 Drink it field commented>>
                // column(Output_ExtractContent; Output."Strength Spec. Value")
                column(Output_ExtractContent; '')

                {
                }
                //Bc Upgrade YADAVM09 Drink it field commented<<
                column(Output_ItemDesc; Item.Description)
                {
                }
                column(OutPutUserID; OutPutUserID)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    Item.GET(Output."Item No.");
                    ValueEntry.RESET();
                    ValueEntry.SETRANGE("Item Ledger Entry No.", Output."Entry No.");
                    if ValueEntry.FINDFIRST() then
                        OutPutUserID := ValueEntry."User ID";

                    OutputBinCode := GetBinCode(Output);

                    //>>HEI.03
                    //IF Item."Base Unit of Measure" <> Output."Unit of Measure Code" THEN //HEI.04<<
                    OutputUOM := Item."Base Unit of Measure"
                    //HEI.04>>
                    //ELSE
                    //OutputUOM := Output."Unit of Measure Code";
                    //HEI.04<<
                    //<<HEI.03
                end;
            }
            dataitem(Consumption; "Item Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.") WHERE("Entry Type" = FILTER(Consumption));
                column(Consumption_EntryNo; Consumption."Entry No.")
                {
                }
                column(Consumption_ItemNo; Consumption."Item No.")
                {
                }
                column(Consumption_UOM; ConsumptionUoM)
                {
                }
                column(Consumption_Quantity; QtyCons)
                {
                }
                column(Consumption_LotNo; Consumption."Lot No.")
                {
                }
                column(Consumption_BinCode; ConsumptionBinCode)
                {
                }
                column(Consumption_PostingDate; Consumption."Posting Date")
                {
                }
                //Bc Upgrade YADAVM09 Drink it field commented>>
                //  column(Consumption_ExtractContent; Consumption."Strength Spec. Value")
                column(Consumption_ExtractContent; '')

                {
                }
                //Bc Upgrade YADAVM09 Drink it field commented<<
                column(Consumption_itemDesc; Item.Description)
                {
                }
                column(ConsumptionUserID; ConsumptionUserID)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(ConsumptionBinCode);
                    Item.GET(Consumption."Item No.");
                    ValueEntry.RESET();
                    ValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
                    if ValueEntry.FINDFIRST() then
                        ConsumptionUserID := ValueEntry."User ID";

                    QtyCons := Consumption.Quantity;
                    //<<HEI.02 FDD-PRDGAP039
                    /*
                    IF QtyCons < 0 THEN
                      QtyCons := QtyCons * -1;
                    */
                    //>>HEI.02 FDD-PRDGAP039

                    ConsumptionBinCode := GetBinCode(Consumption);
                    ConsumptionUoM := Item."Base Unit of Measure";//HEI.04<<

                end;
            }

            trigger OnAfterGetRecord();
            var
                iL: Integer;
                ItemUOML: Code[10];
                Text001L: Label 'There is found mismatch on "Unit of Measure Code" for this "Document No." - %1 in Item Ledger Entries.';
            begin
                if "Production Order"."Source Type" = "Production Order"."Source Type"::Item then
                    Item.GET("Production Order"."Source No.");

                CLEAR(TotalOutputQty);
                ItemLedgerEntry.RESET();
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Output);
                ItemLedgerEntry.SETRANGE("Document No.", "Production Order"."No.");
                if ItemLedgerEntry.findset() then
                    repeat
                        //HEI.06>>
                        //TotalOutputQty += ItemLedgerEntry.Quantity;
                        if iL = 0 then
                            ItemUOML := ItemLedgerEntry."Unit of Measure Code";
                        if ItemUOML <> ItemLedgerEntry."Unit of Measure Code" then
                            ERROR(Text001L, ItemLedgerEntry."Document No.");
                        if ItemLedgerEntry."Qty. per Unit of Measure" > 0 then
                            TotalOutputQty += ItemLedgerEntry.Quantity / ItemLedgerEntry."Qty. per Unit of Measure";
                        iL += 1;
                    //HEI.06<<
                    until ItemLedgerEntry.NEXT() = 0;

                //<<HEI.03
                ManufacturingSetup.GET();

                CLEAR(TotalPlannedTime);
                CapacityLedgerEntry.RESET();
                CapacityLedgerEntry.SETRANGE("Document No.", "Production Order"."No.");
                if CapacityLedgerEntry.findset() then
                    repeat
                        TotalPlannedTime += CapacityLedgerEntry."Run Time" + CapacityLedgerEntry."Setup Time";
                    until CapacityLedgerEntry.NEXT() = 0;

                //>>HEI.05
                /*ProdOrderLine.RESET;
                ProdOrderLine.SETRANGE("Prod. Order No.","Production Order"."No.");
                ProdOrderLine.SETRANGE(Status,"Production Order".Status::Released);
                IF ProdOrderLine.FINDFIRST THEN BEGIN
                  Item1.GET(ProdOrderLine."Item No.");
                  IF Item1."Base Unit of Measure" <> ProdOrderLine."Unit of Measure Code" THEN BEGIN
                    ItemUnitofMeasure.GET(ProdOrderLine."Item No.",ProdOrderLine."Unit of Measure Code");
                    TotalOutputQty := TotalOutputQty/ItemUnitofMeasure."Qty. per Unit of Measure";
                    END;
                  END;*/
                //<<HEI.05

                //>>HEI.03

                ProdOrderRoutingLine.RESET();
                ProdOrderRoutingLine.SETRANGE(Status, "Production Order".Status);
                ProdOrderRoutingLine.SETRANGE("Prod. Order No.", "Production Order"."No.");
                ProdOrderRoutingLine.SETRANGE(Type, ProdOrderRoutingLine.Type::"Work Center");
                if ProdOrderRoutingLine.FINDFIRST() then begin
                    WorkCenterNo := ProdOrderRoutingLine."No.";
                    WorkCenterDesc := ProdOrderRoutingLine.Description;
                end;

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
                    field(SortingOnConsumedItems; SortingOnConsumedItems)
                    {
                        Caption = 'SortingOnConsumedItems';
                        ApplicationArea = All;
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

    trigger OnInitReport();
    begin

        //HEI.07>>
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(Picture);
        //HEI.07<<
    end;

    var
        CompanyInformation: Record "Company Information";
        Text001: Label 'Process Order Goods Movement';
        Text002: Label 'Status';
        Text003: Label 'Production Order ID';
        Text004: Label 'Location';
        Text005: Label 'Zone';
        Text006: Label 'Produced Item No.';
        Text007: Label 'Produced Item Description';
        Text008: Label 'Total Expected Output Qty.';
        Text009: Label 'Total Posted Output Qty in Prod UoM';
        Text010: Label 'Due Date';
        Text011: Label 'Creation Date';
        Text012: Label 'Starting Date';
        Text013: Label 'Ending Date';
        Text014: Label 'Production Resource';
        Text015: Label 'Produced Item Details';
        Text016: Label 'Consumed Item Details';
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalOutputQty: Decimal;
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        WorkCenterNo: Code[20];
        WorkCenterDesc: Text;
        ValueEntry: Record "Value Entry";
        OutPutUserID: Code[50];
        ConsumptionUserID: Code[50];
        QtyCons: Decimal;
        WarehouseEntry: Record "Warehouse Entry";
        OutputBinCode: Code[20];
        ConsumptionBinCode: Code[20];
        Text017: Label 'Planned Time';
        CapacityLedgerEntry: Record "Capacity Ledger Entry";
        ManufacturingSetup: Record "Manufacturing Setup";
        TotalPlannedTime: Decimal;
        SortingOnConsumedItems: Boolean;
        ProdOrderLine: Record "Prod. Order Line";
        Item1: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        OutputUOM: Code[20];
        tempWarehouseEntry: Record "Warehouse Entry" temporary;
        whseEntryNo: Integer;
        Text018: Label 'Reference No.';
        ConsumptionUoM: Code[20];

    local procedure GetBinCode(ItemLedgerEntry1: Record "Item Ledger Entry"): Code[20];
    begin
        WarehouseEntry.RESET();
        WarehouseEntry.SETRANGE("Reference No.", ItemLedgerEntry1."Document No.");
        WarehouseEntry.SETRANGE("Registering Date", ItemLedgerEntry1."Posting Date");
        WarehouseEntry.SETRANGE("Location Code", ItemLedgerEntry1."Location Code");
        WarehouseEntry.SETRANGE("Item No.", ItemLedgerEntry1."Item No.");
        WarehouseEntry.SETRANGE(Quantity, ItemLedgerEntry1.Quantity);
        WarehouseEntry.SETRANGE("Source Line No.", ItemLedgerEntry1."Order Line No.");


        if WarehouseEntry.findset() then begin
            whseEntryNo := 0;
            repeat
                if not tempWarehouseEntry.GET(WarehouseEntry."Entry No.") and (whseEntryNo = 0) then begin

                    tempInsertWhse(WarehouseEntry);
                    whseEntryNo := 1;

                    exit(WarehouseEntry."Bin Code");

                end;

            until WarehouseEntry.NEXT() = 0;
        end;
    end;

    local procedure tempInsertWhse(WarehouseEntry1: Record "Warehouse Entry");
    begin
        tempWarehouseEntry.INIT();
        //tempWarehouseEntry.COPY(WarehouseEntry1);
        tempWarehouseEntry."Entry No." := WarehouseEntry1."Entry No.";
        tempWarehouseEntry.INSERT();
    end;
}

