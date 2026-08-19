report 54044 "Calculate Inventory Heilite"
{

    // DITW15.00.00.24 DDR 03/10/2008 Drink-It Internal Tax functionnalities
    //                -Changed function InsertItemJnlLine()
    // PRODW14.00.00.08.12 DDR 14/05/2009
    //   Added parameters functions InsertItemJnlLine(),UpdateBuffer(),RetrieveBuffer()
    //   CITQLT1.00 001 Allow inventory to be calculated by lot no./serial no.
    //   CITQLT1.00 002 Allow items with no movement to be included
    // PRODW14.00.00.08.13 DDR 10/06/2009 correct merge error design in request form
    //                                    Bugfix when the option 'by lot/serial' is not activated into function RetrieveBuffer()
    // DITW15.00.00.37 DDR 03/03/2010 issue 1038 Save main item journal line after inserted item charges
    // DITW16.00.00.37 CEL 20/08/2010 DIT-715 #1 RTC Report/Page functionnalities & Nav SQL performances
    // DITW16.00.00.39 DDR 19/07/2011 DIT-715 #92 RTC Error Request page captions (removed special characters not supported RTC)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW19.00.08A AKH 30/12/2016 BL#18748 Bugfix Phys. Inv journal calculation per lot per bin and Lot/Serial calculation
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A


    // HEI.02 CHG2026978 KUMARN15 14.10.2019
    //   # Code change in function InsertItemJnlLine

    // FCE01 07072020 INC2938943/CHG2071092 Changed the key of DataItem ItemLEdger Entries:
    //              - SORTING(Item No.,Location Code,Open,Variant Code,Unit of Measure Code,Lot No.,Serial No.)
    // FCE02 08072020 INC2938943/CHG2071092 Added possiobility to filter per zone from the Warehouse Entry Dataitem
    // HEI.05 CHG2060990 IBM BULIMC01  25.06.2020 #update CCC Code with the value from Bin
    // HEI.06 CHG2145896 IBM BHATTA09  19.07.2022 #update CCC Code with the value from SKU if CCC is missing in Bin
    // HEI.07 CHG2145896 IBM Yadavm05  12.01.2023 #Rollback CCC Code with the value from SKU if CCC is missing in Bin
    // HEI.08 CHG2222964 SAHAL01 05.10.2023 Physical inventory journal too slow
    //   # Added and Commented Code to improve performance
    //   # Changed the Change No. from CHG2210924 (SC) to CHG2222964 (CC)
    // HEI.09 CHG2222964 IBM PATHAA02/Mimikos 21.11.2023 Physical inventory journal too slow
    //   # Code Optimisation to Improve performance
    //   # Removed Item Charges Functions as they are not needed and not used in the HeiLite
    //   #Process dialog for the Buffer entries
    // HEI.10 CHG2222964 IBM PATHAA02/Mimikos 27.11.2023 Physical inventory journal too slow
    //   # Code Optimisation to Improve performance using Queries
    //   # Changes done in Functions UpdateBuffer, RetrieveBuffer, ItemBinLocationIsCalculated (On paramenters and data fetched from Query)
    //  HEI.11 CHG2222964 IBM PATHAA02/Mimikos 29.11.2023 #Physical inventory journal too slow
    //   # Use of SETFILTER instead of SETRANGE
    //  HEI.12 CHG2222964 IBM PATHAA02/Mimikos 05.12.2023 Physical inventory journal too slow
    //   # Code Optimisation to Improve performance (fixing old bug)
    //   HEI.13 CHG2234148 IBM PRASAA03/Mimikos 05.01.2024 Calucalte Inventory within Phys. Inventory Journal does not take filters into account
    //   # Code Optimisation to Improve performance (fixing old bug)
    //   HEI.14 CHG2234148 IBM PATHAA02/Mimikos 10.01.2024 Calucalte Inventory within Phys. Inventory Journal does not take filters into account
    //   # Code Optimisation to Improve performance (fixing old bug)


    // BC Upgrade MISHRS14 >>
    // Created this report - Original Report- 790 ("Calculate Inventory") by adding all HEI Tags present in NAV by converting code from CAL To AL
    // Added action button in Page-Extension DTW -54043 (Phys.InventoryJournalExt)
    // Blocked parameter - WhseEntry."Serial No.", WhseEntry."Lot No." in function - "CreateReservEntryFor" and added parameter - ForReservEntry because its record type and this is present in base report.
    // Blocked parameter - (WhseSNRequired,WhseLNRequired,FALSE) in function - "CheckWhseItemTrkgSetup" because only one parameter of datatype Code was being passed in base.
    // BC Upgrade MISHRS14 <<

    //FDD-GAP001 IBM PATHAA02-07.04.26
    //# When called from Action on page, template and batch should be passed to report to get the filters from page and process accordingly

    Caption = 'Calculate Inventory Heilite_Legacy';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") WHERE(Type = CONST(Inventory));
            RequestFilterFields = "No.", "Location Filter", "Bin Filter", "Date Filter";
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No." = FIELD("No."), "Variant Code" = FIELD("Variant Filter"), "Location Code" = FIELD("Location Filter"), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Item No.", "Location Code", Open, "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.");
                RequestFilterFields = "Item No.", "Lot No.";
                UseTemporary = true;

                trigger OnAfterGetRecord()
                var
                    ItemVariant: Record "Item Variant";
                    ByBin: Boolean;
                    ExecuteLoop: Boolean;
                    InsertTempSKU: Boolean;
                begin
                    /* //HEI.10 <<
                    IF NOT GetLocation("Location Code") THEN
                      CurrReport.SKIP;
                    IF ColumnDim <> '' THEN
                      TransferDim("Dimension Set ID");
                    IF NOT "Drop Shipment" THEN
                      ByBin := Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick";
                    IF NOT SkipCycleSKU("Location Code","Item No.","Variant Code") THEN
                      IF ByBin THEN BEGIN
                        IF NOT TempSKU.GET("Location Code","Item No.","Variant Code") THEN BEGIN
                          InsertTempSKU := FALSE;
                          IF "Variant Code" = '' THEN
                            InsertTempSKU := TRUE
                          ELSE
                            IF ItemVariant.GET("Item No.","Variant Code") THEN
                              InsertTempSKU := TRUE;
                          IF InsertTempSKU THEN BEGIN
                            TempSKU."Item No." := "Item No.";
                            TempSKU."Variant Code" := "Variant Code";
                            TempSKU."Location Code" := "Location Code";
                            //HEI.08>>
                            //TempSKU.INSERT;
                            TempSKU.INSERT(FALSE);
                            //HEI.08<<
                            ExecuteLoop := TRUE;
                          END;
                        END
                        //<< DITW19.00.08A AKH 30/12/2016 BL#18748
                        ELSE
                        IF ByLotSerial THEN
                          IF ("Location Code" = OldLocationCode) AND ("Item No." = OldItemNo) AND ("Variant Code" = OldVariantCode) THEN
                            ExecuteLoop := TRUE;
                        //>> DITW19.00.08A AKH BL#18748
                        IF ExecuteLoop THEN BEGIN
                    
                          WhseEntry.SETRANGE("Item No.","Item No.");
                          WhseEntry.SETRANGE("Location Code","Location Code");
                          WhseEntry.SETRANGE("Variant Code","Variant Code");
                          // <<PRODW14.00.00.08.12 DDR 14/05/2009
                          IF ByLotSerial THEN BEGIN                                       // CITQLT1.00 001
                            WhseEntry.SETRANGE("Lot No.","Lot No.");                      // CITQLT1.00 001
                            WhseEntry.SETRANGE("Serial No.","Serial No.");                // CITQLT1.00 001
                          END;                                                            // CITQLT1.00 001
                          // >>PRODW14.00.00.08.12
                          // Fce01-
                          WhseEntry.SETFILTER("Zone Code", "Warehouse Entry".GETFILTER("Warehouse Entry"."Zone Code"));
                          // FCE01+
                          WhseEntry.SETFILTER("Registering Date",Item.GETFILTER("Date Filter"));
                          //HEI.08>>
                          //IF WhseEntry.FIND('-') THEN
                          IF WhseEntry.FINDSET(FALSE,FALSE) THEN
                          //HEI.08<<
                            IF WhseEntry."Entry No." <> OldWhseEntry."Entry No." THEN BEGIN
                              OldWhseEntry := WhseEntry;
                              REPEAT
                                WhseEntry.SETRANGE("Bin Code",WhseEntry."Bin Code");
                                IF NOT ItemBinLocationIsCalculated(WhseEntry."Bin Code") THEN BEGIN
                                  WhseEntry.CALCSUMS("Qty. (Base)");
                                  // <<PRODW14.00.00.08.12 DDR 14/05/2009
                                  // UpdateBuffer(WhseEntry."Bin Code",WhseEntry."Qty. (Base)");
                                  UpdateBuffer(WhseEntry."Bin Code",WhseEntry."Qty. (Base)",WhseEntry."Lot No.",WhseEntry."Serial No.");
                                  // CITQLT1.00 001
                                  // >>PRODW14.00.00.08.12
                                END;
                                //HEI.08>>
                                //WhseEntry.FIND('+');
                                WhseEntry.FINDLAST;
                                //HEI.08<<
                                Item.COPYFILTER("Bin Filter",WhseEntry."Bin Code");
                              UNTIL WhseEntry.NEXT = 0;
                            END;
                        END;
                        //<< DITW19.00.08A AKH 30/12/2016 BL#18748
                        IF ByLotSerial THEN BEGIN
                          OldItemNo := "Item No.";
                          OldLocationCode := "Location Code";
                          OldVariantCode := "Variant Code";
                        END;
                        //>> DITW19.00.08A AKH BL#18748
                      END ELSE
                        // <<PRODW14.00.00.08.12 DDR 14/05/2009
                        // UpdateBuffer('',Quantity);
                        UpdateBuffer('',Quantity,"Lot No.","Serial No."); // CITQLT1.00 001
                        // >>PRODW14.00.00.08.12
                    
                    
                    
                    //HEI.09<<
                    //IF NOT "Item Ledger Entry".ISEMPTY THEN
                    //  CurrReport.SKIP;   // Skip if item has any record in Item Ledger Entry.
                    CLEAR(QuantityOnHandBuffer);
                    QuantityOnHandBuffer."Item No." := "Item No.";
                    QuantityOnHandBuffer."Location Code" := "Location Code";
                    QuantityOnHandBuffer."Variant Code" := "Variant Code";
                    
                    //GetLocation("Location Code");
                    IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                      QuantityOnHandBuffer."Bin Code" := "Bin Code";
                    IF NOT QuantityOnHandBuffer.FIND THEN
                      //HEI.08>>
                      //QuantityOnHandBuffer.INSERT;   // Insert a zero quantity line.
                      QuantityOnHandBuffer.INSERT(FALSE);   // Insert a zero quantity line.
                      //HEI.08<<
                    //HEI.09>>;
                    */ //HEI.10>>

                end;

                trigger OnPreDataItem()
                var
                    qILEInventory: Query "ILE Calculate Inventory CBN";
                    ItemVariant: Record "Item Variant";
                    ByBin: Boolean;
                    ExecuteLoop: Boolean;
                    InsertTempSKU: Boolean;
                    qWHEInventory: Query "WHE Calculate Inventory";
                    ProccessingStep: Integer;
                begin
                    //HEI.10<<
                    ProccessingStep := 0;

                    qILEInventory.SETRANGE(qILEInventory.Item_No, Item."No.");
                    qILEInventory.SETFILTER(qILEInventory.Location_Code, Item.GETFILTER("Location Filter")); //HEI.11

                    /*IF Item.GETFILTER("Bin Filter")<>'' THEN BEGIN
                    qILEInventory.SETRANGE(qILEInventory.Bin_Code,Item.GETFILTER("Bin Filter"));
                    END;*/ //HEI.12

                    IF Item.GETFILTER("Date Filter") <> '' THEN BEGIN //HEI.12
                        qILEInventory.SETFILTER(qILEInventory.Posting_Date, Item.GETFILTER("Date Filter")); //HEI.12
                    END;


                    qILEInventory.OPEN();
                    WHILE qILEInventory.READ() DO BEGIN


                        ProccessingEntry := ProccessingEntry + 1;
                        ProccessingStep := ProccessingStep + 1;
                        IF ProccessingStep > 100 THEN BEGIN
                            IF NOT HideValidationDialog THEN BEGIN
                                Window.UPDATE(2, FORMAT(ProccessingEntry));
                                ProccessingStep := 0;
                            END;
                        END;

                        IF NOT GetLocation(qILEInventory.Location_Code) THEN BEGIN //HEI.12
                            CurrReport.SKIP();

                            /*IF NOT qILEInventory.Drop_Shipment THEN
                              ByBin := Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick";
                            IF NOT SkipCycleSKU(qILEInventory.Location_Code,qILEInventory.Item_No,qILEInventory.Variant_Code) THEN
                              IF ByBin THEN BEGIN
                                IF NOT TempSKU.GET(qILEInventory.Location_Code,qILEInventory.Item_No,qILEInventory.Variant_Code) THEN BEGIN
                                  InsertTempSKU := FALSE;
                                  IF qILEInventory.Variant_Code = '' THEN
                                    InsertTempSKU := TRUE
                                  ELSE
                                    IF ItemVariant.GET(qILEInventory.Item_No,qILEInventory.Variant_Code) THEN
                                      InsertTempSKU := TRUE;
                                  IF InsertTempSKU THEN BEGIN
                                    TempSKU."Item No." := qILEInventory.Item_No;
                                    TempSKU."Variant Code" := qILEInventory.Variant_Code;
                                    TempSKU."Location Code" := qILEInventory.Location_Code;
                                    //HEI.08>>
                                    //TempSKU.INSERT;
                                    TempSKU.INSERT(FALSE);
                                    //HEI.08<<
                                    //ExecuteLoop := TRUE;*/ //HEI.12
                        END;
                        /*  END

                          ELSE
                          //IF ByLotSerial THEN
                          //  IF (qILEInventory.Location_Code = OldLocationCode) AND (qILEInventory.Item_No = OldItemNo) AND (qILEInventory.Variant_Code = OldVariantCode) THEN
                          //    ExecuteLoop := TRUE; *///HEI.12

                        // IF ByLotSerial THEN BEGIN //SerialNo  //HEI.14

                        qWHEInventory.SETRANGE(qWHEInventory.Location_Code, qILEInventory.Location_Code);
                        // qWHEInventory.SETRANGE(qWHEInventory.Bin_Code,qILEInventory.Bin_Code); //HEI.12
                        IF Item.GETFILTER("Bin Filter") <> '' THEN BEGIN //HEI.12
                            qWHEInventory.SETRANGE(qWHEInventory.Bin_Code, Item.GETFILTER("Bin Filter")); //HEI.12
                        END; //HEI.12
                        qWHEInventory.SETRANGE(qWHEInventory.Item_No, Item."No.");
                        qWHEInventory.SETRANGE(qWHEInventory.Lot_No, qILEInventory.Lot_No);

                        IF qILEInventory.Serial_No <> '' THEN BEGIN
                            qWHEInventory.SETRANGE(qWHEInventory.Serial_No, qILEInventory.Serial_No);
                        END;

                        IF qILEInventory.Variant_Code <> '' THEN BEGIN
                            qWHEInventory.SETRANGE(qWHEInventory.Variant_Code, qILEInventory.Variant_Code);
                        END;

                        IF ("Warehouse Entry".GETFILTER("Warehouse Entry"."Zone Code") <> '') THEN BEGIN
                            qWHEInventory.SETFILTER(qWHEInventory.Zone_Code, "Warehouse Entry".GETFILTER("Warehouse Entry"."Zone Code")); //HEI.12
                        END;

                        IF Item.GETFILTER("Date Filter") <> '' THEN BEGIN //HEI.12
                            qWHEInventory.SETFILTER(qWHEInventory.Registering_Date, Item.GETFILTER("Date Filter"));
                        END;

                        //HEI.13>>
                        IF NOT ZeroQty THEN BEGIN
                            qWHEInventory.SETFILTER(qWHEInventory.Sum_Qty_Base, '<>%1', 0);
                        END;
                        //HEI.13<<

                        qWHEInventory.OPEN();
                        WHILE qWHEInventory.READ() DO BEGIN
                            IF (ByLotSerial = TRUE) THEN BEGIN //HEI.14
                                QuantityOnHandBuffer.INIT();
                                QuantityOnHandBuffer."Item No." := qWHEInventory.Item_No;
                                QuantityOnHandBuffer."Variant Code" := qWHEInventory.Variant_Code;
                                QuantityOnHandBuffer."Dimension Entry No." := ProccessingEntry;
                                QuantityOnHandBuffer."Location Code" := qWHEInventory.Location_Code;
                                QuantityOnHandBuffer."Bin Code" := qWHEInventory.Bin_Code;
                                QuantityOnHandBuffer."Lot No." := qWHEInventory.Lot_No;
                                QuantityOnHandBuffer."Serial No." := qWHEInventory.Serial_No;
                                QuantityOnHandBuffer.Quantity := qWHEInventory.Sum_Qty_Base;
                                QuantityOnHandBuffer.INSERT(FALSE);
                                //HEI.14<<
                            END ELSE BEGIN
                                QuantityOnHandBuffer.RESET();
                                QuantityOnHandBuffer.SETRANGE("Item No.", qWHEInventory.Item_No);
                                QuantityOnHandBuffer.SETRANGE("Location Code", qWHEInventory.Location_Code);
                                QuantityOnHandBuffer.SETRANGE("Bin Code", qWHEInventory.Bin_Code);

                                IF QuantityOnHandBuffer.FINDFIRST() THEN BEGIN
                                    QuantityOnHandBuffer.Quantity := QuantityOnHandBuffer.Quantity + qWHEInventory.Sum_Qty_Base;
                                    QuantityOnHandBuffer.MODIFY(FALSE);
                                END ELSE BEGIN
                                    QuantityOnHandBuffer.INIT();
                                    QuantityOnHandBuffer."Item No." := qWHEInventory.Item_No;
                                    QuantityOnHandBuffer."Dimension Entry No." := ProccessingEntry;
                                    QuantityOnHandBuffer."Location Code" := qWHEInventory.Location_Code;
                                    QuantityOnHandBuffer."Bin Code" := qWHEInventory.Bin_Code;
                                    QuantityOnHandBuffer.Quantity := qWHEInventory.Sum_Qty_Base;
                                    QuantityOnHandBuffer.INSERT(FALSE);
                                END;

                            END;
                            //HEI.14>>
                        END;
                        qWHEInventory.CLOSE();

                        // END; //SerialNo   //HEI.14

                        //HEI.14<<
                        //IF NOT ByLotSerial THEN BEGIN //HEI.12
                        //  UpdateBuffer('',qILEInventory.Sum_Quantity,qILEInventory.Lot_No,qILEInventory.Serial_No,ProccessingEntry,qILEInventory.Location_Code,qILEInventory.Variant_Code,qILEInventory.Item_No);
                        //END;
                        //HEI.14>>

                    END; //HEI.12

                    /*//HEI.12
                    CLEAR(QuantityOnHandBuffer);
                    QuantityOnHandBuffer."Item No." :=qILEInventory.Item_No ;
                    QuantityOnHandBuffer."Location Code" := qILEInventory.Location_Code;
                    QuantityOnHandBuffer."Variant Code" := qILEInventory.Variant_Code;
                    
                    
                    IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                      QuantityOnHandBuffer."Bin Code" :=Location."Default Bin Code";  //FIX2
                    IF NOT QuantityOnHandBuffer.FIND THEN
                      QuantityOnHandBuffer.INSERT(FALSE);
                    END;
                    *///HEI.12

                    qILEInventory.CLOSE();
                    //HEI.10>>

                end;
            }
            dataitem("Warehouse Entry"; "Warehouse Entry")
            {
                DataItemLink = "Item No." = FIELD("No."),
                               "Variant Code" = FIELD("Variant Filter"),
                               "Location Code" = FIELD("Location Filter");
                RequestFilterFields = "Location Code", "Zone Code";
                UseTemporary = true;

                trigger OnAfterGetRecord()
                begin
                    //HEI.09<<
                    /*
                    IF NOT "Item Ledger Entry".ISEMPTY THEN
                      CurrReport.SKIP;   // Skip if item has any record in Item Ledger Entry.
                    CLEAR(QuantityOnHandBuffer);
                    QuantityOnHandBuffer."Item No." := "Item No.";
                    QuantityOnHandBuffer."Location Code" := "Location Code";
                    QuantityOnHandBuffer."Variant Code" := "Variant Code";
                    
                    GetLocation("Location Code");
                    IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN
                      QuantityOnHandBuffer."Bin Code" := "Bin Code";
                    IF NOT QuantityOnHandBuffer.FIND THEN
                      //HEI.08>>
                      //QuantityOnHandBuffer.INSERT;   // Insert a zero quantity line.
                      QuantityOnHandBuffer.INSERT(FALSE);   // Insert a zero quantity line.
                      //HEI.08<<
                    */
                    //HEI.09>>

                end;

                trigger OnPreDataItem()
                begin

                    CurrReport.SKIP(); //HEI.09
                end;
            }
            dataitem(ItemWithNoTransaction; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));

                trigger OnAfterGetRecord()
                begin
                    IF IncludeItemWithNoTransaction THEN
                        UpdateQuantityOnHandBuffer(Item."No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT HideValidationDialog THEN
                    Window.UPDATE();
                TempSKU.DELETEALL();
            end;

            trigger OnPostDataItem()
            begin
                CalcPhysInvQtyAndInsertItemJnlLine();
            end;

            trigger OnPreDataItem()
            var
                ItemJnlTemplate: Record "Item Journal Template";
                ItemJnlBatch: Record "Item Journal Batch";
            begin
                IF PostingDate = 0D THEN
                    ERROR(Text000);

                ItemJnlTemplate.GET(ItemJnlLine."Journal Template Name");
                ItemJnlBatch.GET(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
                IF NextDocNo = '' THEN BEGIN
                    IF ItemJnlBatch."No. Series" <> '' THEN BEGIN
                        ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
                        ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
                        //HEI.08>>
                        //IF NOT ItemJnlLine.FINDFIRST THEN
                        IF ItemJnlLine.ISEMPTY THEN
                            //HEI.08<<
                            NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", PostingDate, FALSE);
                        ItemJnlLine.INIT();
                    END;
                    IF NextDocNo = '' THEN
                        ERROR(Text001);
                END;

                NextLineNo := 0;

                IF NOT HideValidationDialog THEN
                    Window.OPEN(Text002, "No.");

                //IF NOT SkipDim THEN  //HEI.10
                //  SelectedDim.GetSelectedDim(USERID,3,REPORT::"Calculate Inventory",'',TempSelectedDim); //HEI.10

                QuantityOnHandBuffer.RESET();
                QuantityOnHandBuffer.DELETEALL();
                // <<PRODW14.00.00.08.12 DDR 14/05/2009
                Item2.COPYFILTERS(Item);  // CITQLT1.00 002
                // >>PRODW14.00.00.08.12
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
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posting Date';
                        ToolTip = 'Specifies the date for the posting of this batch job. By default, the working date is entered, but you can change it.';

                        trigger OnValidate()
                        begin
                            ValidatePostingDate();
                        end;
                    }
                    field(DocumentNo; NextDocNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Document No.';
                        ToolTip = 'Specifies the number of the document that is processed by the report or batch job.';
                    }
                    field(ItemsNotOnInventory; ZeroQty)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Items Not on Inventory.';
                        ToolTip = 'Specifies if journal lines should be created for items that are not on inventory, that is, items where the value in the Qty. (Calculated) field is 0.';

                        trigger OnValidate()
                        begin
                            IF NOT ZeroQty THEN
                                IncludeItemWithNoTransaction := FALSE;
                        end;
                    }
                    field(NoMovement; NoMovement)
                    {
                        Caption = 'Items with no Movement';
                        ApplicationArea = All;
                    }
                    field(ByLotSerial; ByLotSerial)
                    {
                        Caption = 'By Lot-Serial';
                        ApplicationArea = All;
                    }
                    field(IncludeItemWithNoTransaction; IncludeItemWithNoTransaction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Item without Transactions';
                        ToolTip = 'Specifies if journal lines should be created for items that are not on inventory and are not used in any transactions.';

                        trigger OnValidate()
                        begin
                            IF NOT IncludeItemWithNoTransaction THEN
                                EXIT;
                            IF NOT ZeroQty THEN
                                ERROR(ItemNotOnInventoryErr);
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PostingDate = 0D THEN
                PostingDate := WORKDATE();
            ValidatePostingDate();
            ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Calculate Inventory", '');
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        ItemJnlLine2: Record "Item Journal Line";
        ItemLedgEntry: Record "Item Ledger Entry";
        Step: Integer;
        TotalNonInvItems: Integer;
        recItemSKU: Record "Stockkeeping Unit";
    begin
        // <<PRODW14.00.00.08.12 DDR 14/05/2009
        // -- CITQLT1.00 002 -- Begin

        //HEI.10<<
        IF NOT HideValidationDialog THEN BEGIN
            Window.OPEN(Text005);
        END;
        IF NoMovement THEN BEGIN
            //HEI.10>>

            //HEI.08>>
            //IF Item2.FIND('-') THEN REPEAT
            IF Item2.FINDSET(FALSE) THEN
                REPEAT
                    //HEI.08<<
                    ItemLedgEntry.RESET();
                    //HEI.08>>
                    ItemLedgEntry.SETCURRENTKEY("Item No.");
                    //HEI.08<<
                    ItemLedgEntry.SETRANGE("Item No.", Item2."No.");
                    //HEI.08>>
                    //IF NOT ItemLedgEntry.FIND('-') THEN BEGIN
                    IF ItemLedgEntry.ISEMPTY THEN BEGIN
                        //HEI.08<<
                        TempItem.INIT();
                        TempItem."No." := Item2."No.";
                        //HEI.08>>
                        //TempItem.INSERT;
                        TempItem.INSERT(FALSE);
                        //HEI.08<<
                    END;
                UNTIL Item2.NEXT() = 0;

            //HEI.08>>
            //IF TempItem.FIND('-') THEN REPEAT

            IF TempItem.FINDSET(FALSE) THEN
                REPEAT
                    //HEI.08<<
                    //HEI.10<<
                    Step := Step + 1;
                    TotalNonInvItems := TotalNonInvItems + 1;
                    IF (Step > 50) THEN BEGIN
                        IF NOT HideValidationDialog THEN BEGIN
                            Window.UPDATE(1, TotalNonInvItems);
                            Step := 0;
                        END;
                    END;
                    //HEI.10>>

                    NextLineNo := NextLineNo + 10000;
                    //WITH ItemJnlLine2 DO BEGIN
                    ItemJnlLine2.INIT();
                    //HEI.14<<
                    recItemSKU.RESET();
                    recItemSKU.SETFILTER("Item No.", TempItem."No.");
                    recItemSKU.SETFILTER("Location Code", Item.GETFILTER("Location Filter"));
                    IF recItemSKU.FINDSET(FALSE) THEN BEGIN
                        //HEI.14>>
                        ItemJnlLine2."Line No." := NextLineNo;
                        ItemJnlLine2."Journal Template Name" := ItemJnlLine."Journal Template Name";
                        ItemJnlLine2."Journal Batch Name" := ItemJnlLine."Journal Batch Name";
                        ItemJnlLine2."Location Code" := recItemSKU."Location Code"; //HEI.14
                        ItemJnlLine2.VALIDATE("Posting Date", PostingDate);
                        ItemJnlLine2.VALIDATE("Entry Type", ItemJnlLine2."Entry Type"::"Positive Adjmt.");
                        ItemJnlLine2.VALIDATE("Document No.", NextDocNo);
                        ItemJnlLine2.VALIDATE("Item No.", TempItem."No.");
                        ItemJnlLine2."Phys. Inventory" := TRUE;
                        //HEI.08>>
                        //INSERT(TRUE);
                        ItemJnlLine2.INSERT(FALSE);
                        //HEI.14<<
                    END ELSE BEGIN

                        ItemJnlLine2."Line No." := NextLineNo;
                        ItemJnlLine2."Journal Template Name" := ItemJnlLine."Journal Template Name";
                        ItemJnlLine2."Journal Batch Name" := ItemJnlLine."Journal Batch Name";
                        //"Location Code":=recItemSKU."Location Code";
                        ItemJnlLine2.VALIDATE("Posting Date", PostingDate);
                        ItemJnlLine2.VALIDATE("Entry Type", ItemJnlLine2."Entry Type"::"Positive Adjmt.");
                        ItemJnlLine2.VALIDATE("Document No.", NextDocNo);
                        ItemJnlLine2.VALIDATE("Item No.", TempItem."No.");
                        ItemJnlLine2."Phys. Inventory" := TRUE;
                        //HEI.08>>
                        //INSERT(TRUE);
                        ItemJnlLine2.INSERT(FALSE);
                    END;
                //HEI.14>>
                //HEI.08<<
                //END;
                UNTIL TempItem.NEXT() = 0;
        END;
        // ++ CITQLT1.00 002 ++ End
        // >>PRODW14.00.00.08.12
        //HEI.10<<
        IF NOT HideValidationDialog THEN BEGIN
            Window.CLOSE()
        END;
        //HEI.10>>
    end;

    trigger OnPreReport()
    begin
        IF SkipDim THEN
            ColumnDim := ''
        ELSE
            DimSelectionBuf.CompareDimText(3, REPORT::"Calculate Inventory", '', ColumnDim, Text003);
        ZeroQtySave := ZeroQty;
    end;

    var
        WarehouseEntry: Record "Warehouse Entry"; // MISHRS14
        Text000: Label 'Enter the posting date.';
        Text001: Label 'Enter the document no.';
        Text002: Label 'Processing item    #1########## Item SUM Entries :#2#######';
        Text003: Label 'Retain Dimensions';
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        WhseEntry: Record "Warehouse Entry";
        QuantityOnHandBuffer: Record "Inventory Buffer" temporary;
        SourceCodeSetup: Record "Source Code Setup";
        DimSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        SelectedDim: Record "Selected Dimension";
        TempSelectedDim: Record "Selected Dimension" temporary;
        TempDimBufIn: Record "Dimension Buffer" temporary;
        TempDimBufOut: Record "Dimension Buffer" temporary;
        DimSelectionBuf: Record "Dimension Selection Buffer";
        Location: Record Location;
        NoSeriesMgt: Codeunit "No. Series - Batch";
        DimBufMgt: Codeunit "Dimension Buffer Management";
        Window: Dialog;
        PostingDate: Date;
        CycleSourceType: Option " ",Item,SKU;
        PhysInvtCountCode: Code[10];
        NextDocNo: Code[20];
        NextLineNo: Integer;
        ZeroQty: Boolean;
        ZeroQtySave: Boolean;
        IncludeItemWithNoTransaction: Boolean;
        HideValidationDialog: Boolean;
        AdjustPosQty: Boolean;
        ItemTrackingSplit: Boolean;
        SkipDim: Boolean;
        ColumnDim: Text[250];
        PosQty: Decimal;
        NegQty: Decimal;
        Text004: Label 'You must not filter on dimensions if you calculate locations with %1 is %2.';
        OldWhseEntry: Record "Warehouse Entry";
        TempSKU: Record "Stockkeeping Unit" temporary;
        TempItem: Record "Item" temporary;
        Item2: Record "Item";
        ByLotSerial: Boolean;
        NoMovement: Boolean;
        ItemNotOnInventoryErr: Label 'Items Not on Inventory.';
        OldLocationCode: Code[10];
        OldItemNo: Code[20];
        OldVariantCode: Code[10];
        gSKU: Record "Stockkeeping Unit";
        Text005: Label 'Insert NoMovement Items: #1#######';
        Text006: Label 'Processing Buffer Entry: #1####### Total Buffer Entries(approx.): #2#######';
        ProccessingEntry: Integer;


    //[Scope('Internal')]
    procedure SetItemJnlLine(var NewItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine := NewItemJnlLine;
    end;

    procedure GetTemplateBatch(var ItemJournalTemplate: Record "Item Journal Line")
    begin
        ItemJnlLine := ItemJournalTemplate;
    end;

    local procedure ValidatePostingDate()
    begin
        ItemJnlBatch.GET(ItemJnlLine."Journal Template Name", ItemJnlLine."Journal Batch Name");
        IF ItemJnlBatch."No. Series" = '' THEN
            NextDocNo := ''
        ELSE BEGIN
            NextDocNo := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", PostingDate, FALSE);
            CLEAR(NoSeriesMgt);
        END;
    end;

    local procedure InsertItemJnlLine(ItemNo: Code[20]; VariantCode2: Code[10]; DimEntryNo2: Integer; BinCode2: Code[20]; Quantity2: Decimal; PhysInvQuantity: Decimal; LotNo2: Code[20]; SerialNo2: Code[20])
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ReservEntry: Record "Reservation Entry";
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        Bin: Record Bin;
        DimValue: Record "Dimension Value";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        DimMgt: Codeunit DimensionManagement;
        EntryType: Option "Negative Adjmt.","Positive Adjmt.";
        NoBinExist: Boolean;
        OrderLineNo: Integer;
        Bin2: Record Bin;
        ItemUOM: Record "Item Unit Of Measure";
        Item: Record "Item";
        UOMMgt: Codeunit "Unit Of Measure Management";
        ForReservEntry: Record "Reservation Entry";

    begin
        // PRODW14.00.00.08.12 DDR 14/05/2009 new parameters (LotNo, SerialNo2)
        ItemJnlLine.SETAUTOCALCFIELDS(); //HEI.09
                                         //WITH ItemJnlLine DO BEGIN
        IF NextLineNo = 0 THEN BEGIN
            //HEI.08>>
            //LOCKTABLE;
            //HEI.08<<
            ItemJnlLine.SETRANGE("Journal Template Name", ItemJnlLine."Journal Template Name");
            ItemJnlLine.SETRANGE("Journal Batch Name", ItemJnlLine."Journal Batch Name");
            IF ItemJnlLine.FINDLAST() THEN
                NextLineNo := ItemJnlLine."Line No.";

            SourceCodeSetup.GET();
        END;
        NextLineNo := NextLineNo + 10000;

        IF (Quantity2 <> 0) OR ZeroQty THEN BEGIN
            IF (Quantity2 = 0) AND Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick"
            THEN
                IF NOT Bin.GET(Location.Code, BinCode2) THEN
                    NoBinExist := TRUE;

            ItemJnlLine.INIT();
            ItemJnlLine."Line No." := NextLineNo;
            ItemJnlLine.VALIDATE("Posting Date", PostingDate);
            IF PhysInvQuantity >= Quantity2 THEN
                ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.")
            ELSE
                ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");
            ItemJnlLine.VALIDATE("Document No.", NextDocNo);
            ItemJnlLine.VALIDATE("Item No.", ItemNo);
            ItemJnlLine.VALIDATE("Variant Code", VariantCode2);
            ItemJnlLine.VALIDATE("Location Code", Location.Code);
            IF Bin2.GET(ItemJnlLine."Location Code", BinCode2) THEN
                ItemJnlLine."Zone Code FND" := Bin2."Zone Code";//FIX error bin not found
            IF NOT NoBinExist THEN
                ItemJnlLine.VALIDATE("Bin Code", BinCode2)
            ELSE
                ItemJnlLine.VALIDATE("Bin Code", '');
            ItemJnlLine.VALIDATE("Source Code", SourceCodeSetup."Phys. Inventory Journal");

            //<<HEI.02
            Item.GET(ItemNo);
            Item.TESTFIELD("Inventory Unit of Measure FND");
            ItemJnlLine.VALIDATE("Invent. Unit of Measur Cod FND", Item."Inventory Unit of Measure FND");
            ItemJnlLine."Qty. Phys. Inv. in Inv.UoM FND" := UOMMgt.CalcQtyFromBase(PhysInvQuantity, UOMMgt.GetQtyPerUnitOfMeasure(Item, ItemJnlLine."Invent. Unit of Measur Cod FND"));
            ItemJnlLine."Qty. (Calc.) in Inv. UoM FND" := UOMMgt.CalcQtyFromBase(Quantity2, UOMMgt.GetQtyPerUnitOfMeasure(Item, ItemJnlLine."Invent. Unit of Measur Cod FND"));
            //>>HEI.02

            ItemJnlLine."Qty. (Phys. Inventory)" := PhysInvQuantity;
            ItemJnlLine."Phys. Inventory" := TRUE;
            ItemJnlLine.VALIDATE("Qty. (Calculated)", Quantity2);
            ItemJnlLine."Posting No. Series" := ItemJnlBatch."Posting No. Series";
            ItemJnlLine."Reason Code" := ItemJnlBatch."Reason Code";

            ItemJnlLine."Phys Invt Counting Period Code" := PhysInvtCountCode;
            ItemJnlLine."Phys Invt Counting Period Type" := CycleSourceType;

            IF Location."Bin Mandatory" THEN
                ItemJnlLine."Dimension Set ID" := 0;
            ItemJnlLine."Shortcut Dimension 1 Code" := '';
            ItemJnlLine."Shortcut Dimension 2 Code" := '';

            ItemLedgEntry.RESET();
            ItemLedgEntry.SETCURRENTKEY("Item No.");
            ItemLedgEntry.SETRANGE("Item No.", ItemNo);
            IF ItemLedgEntry.FINDLAST() THEN
                ItemJnlLine."Last Item Ledger Entry No." := ItemLedgEntry."Entry No."
            ELSE
                ItemJnlLine."Last Item Ledger Entry No." := 0;

            // <<PRODW14.00.00.08.12 DDR 14/05/2009
            IF (Quantity2 <> 0) AND ByLotSerial THEN BEGIN     // CITQLT1.00 001
                ItemJnlLine."Lot No." := LotNo2;                             // CITQLT1.00 001
                ItemJnlLine."Serial No." := SerialNo2;                       // CITQLT1.00 001
            END;                                               // CITQLT1.00 001
                                                               // >>PRODW14.00.00.08.12

            //HEI.08>>
            //INSERT(TRUE);
            ItemJnlLine.INSERT(FALSE);
            //HEI.08<<

            IF Location.Code <> '' THEN
                IF Location."Directed Put-away and Pick" THEN BEGIN
                    WhseEntry.SETCURRENTKEY(
                      "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
                      "Lot No.", "Serial No.", "Entry Type");
                    WhseEntry.SETRANGE("Item No.", ItemJnlLine."Item No.");
                    WhseEntry.SETRANGE("Bin Code", Location."Adjustment Bin Code");
                    WhseEntry.SETRANGE("Location Code", ItemJnlLine."Location Code");
                    WhseEntry.SETRANGE("Variant Code", ItemJnlLine."Variant Code");
                    IF WhseEntry."Entry Type" = WhseEntry."Entry Type"::"Positive Adjmt." THEN
                        EntryType := EntryType::"Negative Adjmt.";
                    IF WhseEntry."Entry Type" = WhseEntry."Entry Type"::"Negative Adjmt." THEN
                        EntryType := EntryType::"Positive Adjmt.";
                    WhseEntry.SETRANGE("Entry Type", EntryType);
                    //HEI.08>>
                    //IF WhseEntry.FIND('-') THEN
                    WhseEntry.SETAUTOCALCFIELDS(); //HEI.09

                    IF WhseEntry.FINDSET(FALSE) THEN
                        //HEI.08<<
                        REPEAT
                            WhseEntry.SETRANGE("Lot No.", WhseEntry."Lot No.");
                            WhseEntry.SETRANGE("Serial No.", WhseEntry."Serial No.");
                            WhseEntry.CALCSUMS("Qty. (Base)");

                            WhseEntry2.SETCURRENTKEY(
                              "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
                              "Lot No.", "Serial No.", "Entry Type");
                            WhseEntry2.COPYFILTERS(WhseEntry);
                            CASE EntryType OF
                                EntryType::"Positive Adjmt.":
                                    WhseEntry2.SETRANGE("Entry Type", WhseEntry2."Entry Type"::"Negative Adjmt.");
                                EntryType::"Negative Adjmt.":
                                    WhseEntry2.SETRANGE("Entry Type", WhseEntry2."Entry Type"::"Positive Adjmt.");
                            END;
                            WhseEntry2.CALCSUMS("Qty. (Base)");
                            IF ABS(WhseEntry2."Qty. (Base)") > ABS(WhseEntry."Qty. (Base)") THEN
                                WhseEntry."Qty. (Base)" := 0
                            ELSE
                                WhseEntry."Qty. (Base)" := WhseEntry."Qty. (Base)" + WhseEntry2."Qty. (Base)";

                            IF WhseEntry."Qty. (Base)" <> 0 THEN BEGIN
                                IF ItemJnlLine."Order Type" = ItemJnlLine."Order Type"::Production THEN
                                    OrderLineNo := ItemJnlLine."Order Line No.";
                                CreateReservEntry.CreateReservEntryFor(
                                  DATABASE::"Item Journal Line",
                                  ItemJnlLine."Entry Type".AsInteger(),
                                  ItemJnlLine."Journal Template Name",
                                  ItemJnlLine."Journal Batch Name",
                                  OrderLineNo,
                                  ItemJnlLine."Line No.",
                                  ItemJnlLine."Qty. per Unit of Measure",
                                  ABS(WhseEntry.Quantity),
                                  ABS(WhseEntry."Qty. (Base)"),
                                  //WhseEntry."Serial No.",
                                  //WhseEntry."Lot No."
                                  ForReservEntry);
                                IF WhseEntry."Qty. (Base)" < 0 THEN             // only Date on positive adjustments
                                    CreateReservEntry.SetDates(WhseEntry."Warranty Date", WhseEntry."Expiration Date");
                                CreateReservEntry.CreateEntry(
                                  ItemJnlLine."Item No.",
                                  ItemJnlLine."Variant Code",
                                  ItemJnlLine."Location Code",
                                  ItemJnlLine.Description,
                                  0D,
                                  0D,
                                  0,
                                  ReservEntry."Reservation Status"::Prospect);
                            END;
                            //HEI.08>>
                            //WhseEntry.FIND('+');
                            WhseEntry.FINDLAST();
                            //HEI.08<<
                            WhseEntry.SETRANGE("Lot No.");
                            WhseEntry.SETRANGE("Serial No.");
                        UNTIL WhseEntry.NEXT() = 0;
                END;

            IF ColumnDim = '' THEN
                DimEntryNo2 := CreateDimFromItemDefault();

            IF DimBufMgt.GetDimensions(DimEntryNo2, TempDimBufOut) THEN BEGIN
                TempDimSetEntry.RESET();
                TempDimSetEntry.DELETEALL();
                //HEI.08>>
                //IF TempDimBufOut.FIND('-') THEN BEGIN
                IF TempDimBufOut.FINDSET(FALSE) THEN BEGIN
                    //HEI.08<<
                    REPEAT
                        DimValue.GET(TempDimBufOut."Dimension Code", TempDimBufOut."Dimension Value Code");
                        TempDimSetEntry."Dimension Code" := TempDimBufOut."Dimension Code";
                        TempDimSetEntry."Dimension Value Code" := TempDimBufOut."Dimension Value Code";
                        TempDimSetEntry."Dimension Value ID" := DimValue."Dimension Value ID";
                        //HEI.08>>
                        //IF TempDimSetEntry.INSERT THEN;
                        IF TempDimSetEntry.INSERT(FALSE) THEN;
                        //HEI.08<<
                        ItemJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
                        DimMgt.UpdateGlobalDimFromDimSetID(ItemJnlLine."Dimension Set ID",
                          ItemJnlLine."Shortcut Dimension 1 Code", ItemJnlLine."Shortcut Dimension 2 Code");
                        //HEI.05<<
                        IF Bin.GET(ItemJnlLine."Location Code", ItemJnlLine."Bin Code") AND (Bin."Ccc Code FND" <> '') THEN
                            ItemJnlLine.VALIDATE("Shortcut Dimension 2 Code", Bin."Ccc Code FND");//HEI.07
                                                                                              //HEI.06>>
                                                                                              /*ELSE BEGIN//HEI.07
                                                                                                IF gSKU.GET("Location Code","Item No.",'') THEN BEGIN
                                                                                                  IF gSKU."CCC Dim. Code" <> '' THEN
                                                                                                    VALIDATE("Shortcut Dimension 2 Code",gSKU."CCC Dim. Code");
                                                                                                END;
                                                                                              END;*///HEI.07
                                                                                                    //HEI.06<<
                                                                                                    //HEI.05>>
                                                                                                    //HEI.08>>
                                                                                                    //MODIFY;
                        ItemJnlLine.MODIFY(FALSE);
                    //HEI.08<<
                    UNTIL TempDimBufOut.NEXT() = 0;
                    TempDimBufOut.DELETEALL();
                END;
            END;

            //HEI.09<<
            // <<DITW15.00.00.24 DDR 03/10/2008 - DITW15.00.00.37 DDR 03/03/2010
            //IF InsertCharges4(FIELDNO("Item No.")) THEN
            //  MODIFY;
            // >>DITW15.00.00.37 DDR
            //HEI.09>>
        END;
        //END;

    end;

    local procedure InsertQuantityOnHandBuffer(ItemNo: Code[20]; LocationCode: Code[10])
    begin
        //WITH QuantityOnHandBuffer DO BEGIN
        QuantityOnHandBuffer.INIT();
        QuantityOnHandBuffer."Item No." := ItemNo;
        QuantityOnHandBuffer."Location Code" := LocationCode;
        //HEI.08>>
        //INSERT(TRUE);
        QuantityOnHandBuffer.INSERT(FALSE);
        //HEI.08<<
        //END;
    end;

    //[Scope('Internal')]
    procedure InitializeRequest(NewPostingDate: Date; DocNo: Code[20]; ItemsNotOnInvt: Boolean)
    begin
        PostingDate := NewPostingDate;
        NextDocNo := DocNo;
        ZeroQty := ItemsNotOnInvt;
        IF NOT SkipDim THEN
            ColumnDim := DimSelectionBuf.GetDimSelectionText(3, REPORT::"Calculate Inventory", '');
    end;

    local procedure TransferDim(DimSetID: Integer)
    begin
        DimSetEntry.SETRANGE("Dimension Set ID", DimSetID);
        //HEI.08>>
        //IF DimSetEntry.FIND('-') THEN BEGIN
        IF DimSetEntry.FINDSET(FALSE) THEN BEGIN
            //HEI.08<<
            REPEAT
                IF TempSelectedDim.GET(
                     USERID, 3, REPORT::"Calculate Inventory", '', DimSetEntry."Dimension Code")
                THEN
                    InsertDim(DATABASE::"Item Ledger Entry", DimSetID, DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
            UNTIL DimSetEntry.NEXT() = 0;
        END;
    end;

    local procedure CalcWhseQty(AdjmtBin: Code[20]; var PosQuantity: Decimal; var NegQuantity: Decimal)
    var
        WhseEntry: Record "Warehouse Entry";
        WhseEntry2: Record "Warehouse Entry";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        WhseQuantity: Decimal;
        WhseSNRequired: Boolean;
        WhseLNRequired: Boolean;
        NoWhseEntry: Boolean;
        NoWhseEntry2: Boolean;
    begin
        AdjustPosQty := FALSE;
        //WITH QuantityOnHandBuffer DO BEGIN
        ItemTrackingMgt.CheckWhseItemTrkgSetup(QuantityOnHandBuffer."Item No.");//(WhseSNRequired,WhseLNRequired,FALSE);
        ItemTrackingSplit := WhseSNRequired OR WhseLNRequired;
        WhseEntry.SETCURRENTKEY(
          "Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code",
          "Lot No.", "Serial No.", "Entry Type");

        WhseEntry.SETRANGE("Item No.", QuantityOnHandBuffer."Item No.");
        WhseEntry.SETRANGE("Location Code", QuantityOnHandBuffer."Location Code");
        WhseEntry.SETRANGE("Variant Code", QuantityOnHandBuffer."Variant Code");
        WhseEntry.CALCSUMS("Qty. (Base)");
        WhseQuantity := WhseEntry."Qty. (Base)";
        WhseEntry.SETRANGE("Bin Code", AdjmtBin);

        IF WhseSNRequired THEN BEGIN
            WhseEntry.SETRANGE("Entry Type", WhseEntry."Entry Type"::"Positive Adjmt.");
            WhseEntry.CALCSUMS("Qty. (Base)");
            PosQuantity := WhseQuantity - WhseEntry."Qty. (Base)";
            WhseEntry.SETRANGE("Entry Type", WhseEntry."Entry Type"::"Negative Adjmt.");
            WhseEntry.CALCSUMS("Qty. (Base)");
            NegQuantity := WhseQuantity - WhseEntry."Qty. (Base)";
            WhseEntry.SETRANGE("Entry Type", WhseEntry."Entry Type"::Movement);
            WhseEntry.CALCSUMS("Qty. (Base)");
            IF WhseEntry."Qty. (Base)" <> 0 THEN BEGIN
                IF WhseEntry."Qty. (Base)" > 0 THEN
                    PosQuantity := PosQuantity + WhseQuantity - WhseEntry."Qty. (Base)"
                ELSE
                    NegQuantity := NegQuantity - WhseQuantity - WhseEntry."Qty. (Base)";
            END;

            WhseEntry.SETRANGE("Entry Type", WhseEntry."Entry Type"::"Positive Adjmt.");
            //HEI.08>>
            //IF WhseEntry.FIND('-') THEN BEGIN
            IF WhseEntry.FINDSET(FALSE) THEN BEGIN
                //HEI.08<<
                REPEAT
                    WhseEntry.SETRANGE("Serial No.", WhseEntry."Serial No.");

                    WhseEntry2.RESET();
                    WhseEntry2.SETCURRENTKEY(
                      "Item No.", "Bin Code", "Location Code", "Variant Code",
                      "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type");

                    WhseEntry2.COPYFILTERS(WhseEntry);
                    WhseEntry2.SETRANGE("Entry Type", WhseEntry2."Entry Type"::"Negative Adjmt.");
                    WhseEntry2.SETRANGE("Serial No.", WhseEntry."Serial No.");
                    //HEI.08>>
                    //IF WhseEntry2.FIND('-') THEN
                    IF WhseEntry2.FINDSET(FALSE) THEN
                        //HEI.08<<
                        REPEAT
                            PosQuantity := PosQuantity + 1;
                            NegQuantity := NegQuantity - 1;
                            NoWhseEntry := WhseEntry.NEXT() = 0;
                            NoWhseEntry2 := WhseEntry2.NEXT() = 0;
                        UNTIL NoWhseEntry2 OR NoWhseEntry
                    ELSE
                        AdjustPosQty := TRUE;

                    IF NOT NoWhseEntry AND NoWhseEntry2 THEN
                        AdjustPosQty := TRUE;

                    //HEI.08>>
                    //WhseEntry.FIND('+');
                    WhseEntry.FINDLAST();
                    //HEI.08<<
                    WhseEntry.SETRANGE("Serial No.");
                UNTIL WhseEntry.NEXT() = 0;
            END;
        END ELSE BEGIN
            //HEI.08>>
            //IF WhseEntry.FIND('-') THEN
            IF WhseEntry.FINDSET(FALSE) THEN
                //HEI.08<<
                REPEAT
                    WhseEntry.SETRANGE("Lot No.", WhseEntry."Lot No.");
                    WhseEntry.CALCSUMS("Qty. (Base)");
                    IF WhseEntry."Qty. (Base)" <> 0 THEN BEGIN
                        IF WhseEntry."Qty. (Base)" > 0 THEN
                            NegQuantity := NegQuantity - WhseEntry."Qty. (Base)"
                        ELSE
                            PosQuantity := PosQuantity + WhseEntry."Qty. (Base)";
                    END;
                    //HEI.08>>
                    //WhseEntry.FIND('+');
                    WhseEntry.FINDLAST();
                    //HEI.08<<
                    WhseEntry.SETRANGE("Lot No.");
                UNTIL WhseEntry.NEXT() = 0;
            IF PosQuantity <> WhseQuantity THEN
                PosQuantity := WhseQuantity - PosQuantity;
            IF NegQuantity <> -WhseQuantity THEN
                NegQuantity := WhseQuantity + NegQuantity;
        END;
        //END;
    end;

    //[Scope('Internal')]
    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    //[Scope('Internal')]
    procedure InitializePhysInvtCount(PhysInvtCountCode2: Code[10]; CountSourceType2: Option " ",Item,SKU)
    begin
        PhysInvtCountCode := PhysInvtCountCode2;
        CycleSourceType := CountSourceType2;
    end;

    local procedure SkipCycleSKU(LocationCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]): Boolean
    var
        SKU: Record "Stockkeeping Unit";
    begin
        IF CycleSourceType = CycleSourceType::Item THEN
            IF SKU.READPERMISSION THEN
                IF SKU.GET(LocationCode, ItemNo, VariantCode) THEN
                    EXIT(TRUE);
        EXIT(FALSE);
    end;

    local procedure GetLocation(LocationCode: Code[10]): Boolean
    begin
        IF LocationCode = '' THEN BEGIN
            CLEAR(Location);
            EXIT(TRUE);
        END;

        IF Location.Code <> LocationCode THEN
            IF NOT Location.GET(LocationCode) THEN
                EXIT(FALSE);

        IF Location."Bin Mandatory" AND NOT Location."Directed Put-away and Pick" THEN BEGIN
            IF (Item.GETFILTER("Global Dimension 1 Code") <> '') OR
               (Item.GETFILTER("Global Dimension 2 Code") <> '') OR
               TempDimBufIn.FINDFIRST()
            THEN
                ERROR(Text004, Location.FIELDCAPTION("Bin Mandatory"), Location."Bin Mandatory");
        END;

        EXIT(TRUE);
    end;

    local procedure UpdateBuffer(BinCode: Code[20]; NewQuantity: Decimal; LotNo: Code[20]; SerialNo: Code[20]; BufferEntry: Integer; LocationCode: Code[20]; VariantCode: Code[20]; ItemNo: Code[20])
    var
        DimEntryNo: Integer;
    begin
        // PRODW14.00.00.08.12 DDR 14/05/2009 new parameters (LotNo, SerialNo)
        //WITH QuantityOnHandBuffer DO BEGIN
        IF NOT HasNewQuantity(NewQuantity) THEN
            EXIT;
        IF BinCode = '' THEN BEGIN
            /*HEI.10<<
             // IF ColumnDim <> '' THEN
             //   TempDimBufIn.SETRANGE("Entry No.","Item Ledger Entry"."Dimension Set ID");
             // DimEntryNo := DimBufMgt.FindDimensions(TempDimBufIn);
             // IF DimEntryNo = 0 THEN
             //   DimEntryNo := DimBufMgt.InsertDimensions(TempDimBufIn);
             */ //HEI.10>>
        END;
        // <<PRODW14.00.00.08.12 DDR 14/05/2009
        IF ByLotSerial THEN BEGIN                                       // CITQLT1.00 001
            QuantityOnHandBuffer.SETRANGE("Lot No.", LotNo);               // CITQLT1.00 001
            QuantityOnHandBuffer.SETRANGE("Serial No.", SerialNo);         // CITQLT1.00 001
        END;                                                            // CITQLT1.00 001
                                                                        // >>PRODW14.00.00.08.12
                                                                        // <<PRODW14.00.00.08.12 DDR 14/05/2009
                                                                        //IF RetrieveBuffer(BinCode,DimEntryNo) THEN BEGIN
        IF RetrieveBuffer(BinCode, BufferEntry, LotNo, SerialNo, LocationCode, VariantCode, ItemNo) THEN BEGIN // CITQLT1.00 001 //HEI.10
                                                                                                               // >>PRODW14.00.00.08.12 DDR 14/05/2009
            QuantityOnHandBuffer.Quantity := QuantityOnHandBuffer.Quantity + NewQuantity;
            //HEI.08>>
            //MODIFY;
            QuantityOnHandBuffer.MODIFY(FALSE);
            //HEI.08<<
        END ELSE BEGIN
            QuantityOnHandBuffer.Quantity := NewQuantity;
            //HEI.08>>
            //INSERT;
            QuantityOnHandBuffer.INSERT(FALSE);
            //HEI.08<<
        END;
        //END;
    end;

    local procedure RetrieveBuffer(BinCode: Code[20]; DimEntryNo: Integer; LotNo: Code[20]; SerialNo: Code[20]; LocationCode: Code[10]; VariantCode: Code[10]; ItemNo: Code[20]): Boolean
    begin
        // PRODW14.00.00.08.12 DDR 14/05/2009 new parameters (LotNo, SerialNo)
        //WITH QuantityOnHandBuffer DO BEGIN
        QuantityOnHandBuffer.RESET();
        // <<PRODW14.00.00.08.12 DDR 14/05/2009
        IF ByLotSerial THEN BEGIN                                                           // CITQLT1.00 001
            QuantityOnHandBuffer.SETRANGE("Lot No.", LotNo);           // CITQLT1.00 001 //HEI.10
            QuantityOnHandBuffer.SETRANGE("Serial No.", SerialNo);     // CITQLT1.00 001  //HEI.10
        END;                                                                                // CITQLT1.00 001
                                                                                            // >>PRODW14.00.00.08.12
        QuantityOnHandBuffer."Item No." := ItemNo; //HEI.10
        QuantityOnHandBuffer."Variant Code" := VariantCode; //HEI.10
        QuantityOnHandBuffer."Location Code" := LocationCode; //HEI.10
        QuantityOnHandBuffer."Dimension Entry No." := DimEntryNo;
        QuantityOnHandBuffer."Bin Code" := BinCode;
        // <<PRODW14.00.00.08.12 DDR 14/05/2009 - PRODW14.00.00.08.13 DDR 11/06/2009
        IF ByLotSerial THEN BEGIN
            QuantityOnHandBuffer."Lot No." := LotNo;       // CITQLT1.00 001
            QuantityOnHandBuffer."Serial No." := SerialNo; // CITQLT1.00 001
        END;
        // >>PRODW14.00.00.08.13
        EXIT(QuantityOnHandBuffer.FIND());
        //END;
    end;

    local procedure HasNewQuantity(NewQuantity: Decimal): Boolean
    begin
        EXIT((NewQuantity <> 0) OR ZeroQty);
    end;

    local procedure ItemBinLocationIsCalculated(BinCode: Code[20]; LocationCode: Code[10]; VariantCode: Code[10]; ItemNo: Code[20]; LotNo: Code[20]; SerialNo: Code[20]): Boolean
    begin
        //WITH QuantityOnHandBuffer DO BEGIN
        QuantityOnHandBuffer.RESET();
        QuantityOnHandBuffer.SETRANGE("Item No.", ItemNo);   //HEI.10
        QuantityOnHandBuffer.SETRANGE("Variant Code", VariantCode); //HEI.10
        QuantityOnHandBuffer.SETRANGE("Location Code", LocationCode); //HEI.10
        QuantityOnHandBuffer.SETRANGE("Bin Code", BinCode);
        // <<PRODW14.00.00.08.12 DDR 14/05/2009
        IF ByLotSerial THEN BEGIN                                      // CITQLT1.00 001
            QuantityOnHandBuffer.SETRANGE("Lot No.", LotNo);           // CITQLT1.00 001 //HEI.10
            QuantityOnHandBuffer.SETRANGE("Serial No.", SerialNo);     // CITQLT1.00 001 //HEI.10
        END;                                                           // CITQLT1.00 001
                                                                       // >>PRODW14.00.00.08.12
        EXIT(QuantityOnHandBuffer.FINDFIRST()); //HEI.10
        //END;
    end;

    //[Scope('Internal')]
    procedure SetSkipDim(NewSkipDim: Boolean)
    begin
        SkipDim := NewSkipDim;
    end;

    local procedure UpdateQuantityOnHandBuffer(ItemNo: Code[20])
    var
        Location: Record Location;
    begin
        QuantityOnHandBuffer.SETRANGE("Item No.", ItemNo);
        IF QuantityOnHandBuffer.ISEMPTY THEN BEGIN
            Item.COPYFILTER("Location Filter", Location.Code);
            Location.SETRANGE("Use As In-Transit", FALSE);
            //HEI.08>>
            //IF (Item.GETFILTER("Location Filter") <> '') AND Location.FINDSET THEN
            IF (Item.GETFILTER("Location Filter") <> '') AND Location.FINDSET(FALSE) THEN
                //HEI.08<<
                REPEAT
                    InsertQuantityOnHandBuffer(ItemNo, Location.Code);
                UNTIL Location.NEXT() = 0
            ELSE
                InsertQuantityOnHandBuffer(ItemNo, '');
        END;
    end;

    local procedure CalcPhysInvQtyAndInsertItemJnlLine()
    var
        I: Integer;
        TotalEntries: Integer;
    begin
        //HEI.09<<
        IF NOT HideValidationDialog THEN BEGIN
            Window.CLOSE();
            Window.OPEN(Text006);
            I := 0;
        END;
        //HEI.09>>

        //WITH QuantityOnHandBuffer DO BEGIN
        QuantityOnHandBuffer.RESET();
        //HEI.08>>
        //IF FINDSET THEN BEGIN
        TotalEntries := QuantityOnHandBuffer.COUNT; //HEI.09
        IF QuantityOnHandBuffer.FINDSET(FALSE) THEN BEGIN
            //HEI.08<<
            REPEAT
                PosQty := 0;
                NegQty := 0;
                //HEI.09<<
                IF NOT HideValidationDialog THEN BEGIN
                    I := I + 1;
                    Window.UPDATE(1, FORMAT(I));
                    Window.UPDATE(2, FORMAT(TotalEntries));
                END;
                //HEI.09>>


                GetLocation(QuantityOnHandBuffer."Location Code");
                IF Location."Directed Put-away and Pick" THEN
                    CalcWhseQty(Location."Adjustment Bin Code", PosQty, NegQty);

                IF (NegQty - QuantityOnHandBuffer.Quantity <> QuantityOnHandBuffer.Quantity - PosQty) OR ItemTrackingSplit THEN BEGIN
                    IF PosQty = QuantityOnHandBuffer.Quantity THEN
                        PosQty := 0;
                    IF (PosQty <> 0) OR AdjustPosQty THEN
                        InsertItemJnlLine(
                          QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.",
                          QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, PosQty,
                          // <<PRODW14.00.00.08.12 DDR 14/05/2009
                          QuantityOnHandBuffer."Lot No.", QuantityOnHandBuffer."Serial No."); // CITQLT1.00 001
                                                                                              // >>PRODW14.00.00.08.12

                    IF NegQty = QuantityOnHandBuffer.Quantity THEN
                        NegQty := 0;
                    IF NegQty <> 0 THEN BEGIN
                        IF ((PosQty <> 0) OR AdjustPosQty) AND NOT ItemTrackingSplit THEN BEGIN
                            NegQty := NegQty - QuantityOnHandBuffer.Quantity;
                            QuantityOnHandBuffer.Quantity := 0;
                            ZeroQty := TRUE;
                        END;
                        IF NegQty = -QuantityOnHandBuffer.Quantity THEN BEGIN
                            NegQty := 0;
                            AdjustPosQty := TRUE;
                        END;
                        InsertItemJnlLine(
                          QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.",
                          QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, NegQty,
                          // <<PRODW14.00.00.08.12 DDR 14/05/2009
                          QuantityOnHandBuffer."Lot No.", QuantityOnHandBuffer."Serial No."); // CITQLT1.00 001
                                                                                              // >>PRODW14.00.00.08.12

                        ZeroQty := ZeroQtySave;
                    END;
                END ELSE BEGIN
                    PosQty := 0;
                    NegQty := 0;
                END;

                IF (PosQty = 0) AND (NegQty = 0) AND NOT AdjustPosQty THEN
                    InsertItemJnlLine(
                      QuantityOnHandBuffer."Item No.", QuantityOnHandBuffer."Variant Code", QuantityOnHandBuffer."Dimension Entry No.",
                      QuantityOnHandBuffer."Bin Code", QuantityOnHandBuffer.Quantity, QuantityOnHandBuffer.Quantity,
                      // <<PRODW14.00.00.08.12 DDR 14/05/2009
                      QuantityOnHandBuffer."Lot No.", QuantityOnHandBuffer."Serial No."); // CITQLT1.00 001
                                                                                          // >>PRODW14.00.00.08.12
            UNTIL QuantityOnHandBuffer.NEXT() = 0;
            QuantityOnHandBuffer.DELETEALL();
        END;
        //END;
        //HEI.09<<
        IF NOT HideValidationDialog THEN BEGIN
            Window.CLOSE();
        END;
        //HEI.09>>
    end;

    local procedure CreateDimFromItemDefault() DimEntryNo: Integer
    var
        DefaultDimension: Record "Default Dimension";
    begin
        //WITH DefaultDimension DO BEGIN
        DefaultDimension.SETRANGE(DefaultDimension."No.", QuantityOnHandBuffer."Item No.");
        DefaultDimension.SETRANGE(DefaultDimension."Table ID", DATABASE::Item);
        DefaultDimension.SETFILTER(DefaultDimension."Dimension Value Code", '<>%1', '');
        //HEI.08>>
        //IF FINDSET THEN
        IF DefaultDimension.FINDSET(FALSE) THEN
            //HEI.08<<
            REPEAT
                InsertDim(DATABASE::Item, 0, DefaultDimension."Dimension Code", DefaultDimension."Dimension Value Code");
            UNTIL DefaultDimension.NEXT() = 0;
        //END;

        DimEntryNo := DimBufMgt.InsertDimensions(TempDimBufIn);
        TempDimBufIn.SETRANGE("Table ID", DATABASE::Item);
        TempDimBufIn.DELETEALL();
    end;

    local procedure InsertDim(TableID: Integer; EntryNo: Integer; DimCode: Code[20]; DimValueCode: Code[20])
    begin
        //WITH TempDimBufIn DO BEGIN
        TempDimBufIn.INIT();
        TempDimBufIn."Table ID" := TableID;
        TempDimBufIn."Entry No." := EntryNo;
        TempDimBufIn."Dimension Code" := DimCode;
        TempDimBufIn."Dimension Value Code" := DimValueCode;
        //HEI.08>>
        //IF INSERT THEN;
        IF TempDimBufIn.INSERT(FALSE) THEN;
        //HEI.08<<
        //END;
    end;
}

