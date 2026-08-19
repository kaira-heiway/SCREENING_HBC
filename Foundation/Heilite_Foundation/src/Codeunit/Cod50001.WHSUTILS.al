codeunit 50001 "WHS-UTILS"
{
    // version HEI.18

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Functions used for Zone code development without whs advanced mgmt
    // HEI.02 FDD-PRDGAP032 IBM HORTOC01 19.07.2017 #Add new function to update routings/bom lines into prod orders
    // HEI.03 FDD-PRDGAP038 IBM COSTES02 07.08.2017 #Add new function to update quality status on Item ledger entry/Warehouse entry
    // HEI.04 defectID 607 IBM HORTOC01  17.10.2017 #Function commented
    // HEI.05 defectID 663 IBM HORTOC01  18.10.2017 #code added
    // HEI.07 Defect #3646 IBM ISYED01 01.25.2019 Unable to input new Bin code in item reclass journal (Replacing 3548)
    //   #changed code on New Bin code and Bincode to input value based on new location and  old location code's.
    //   # removed function OnNewBinChangedItemJnlLine as its not needed anymore
    // HEI.09 CC-CHG2091264 IBM.LS 25.11.2020
    //   # Code added.
    // HEI.10 CHG2119178 IBM.AS 30.06.2021
    //   # HeiLite Base Stability Changes for Posting functions at JOB NAS
    //   # Adding GUIAllowed function added in Functions OnAfterValidateProdBOMVerCodeProdOrdeLine()
    // HEI.11 CHG2120546 IBM.AK 07.07.21
    //  # Code modified (fucntion-OnAfterValidateQualityStatusLotNoInformation)
    // HEI.12 CHG2123219 IBM.BHATTA09 05.01.2022
    //   # Functions added to get SKU CCC Dimension Code in TO
    // HEI.13 CHG2145896 BHATTA09 14.03.2022
    //   # Code fine tuning for getting SKU CCC Dimension
    //   # New subscriber T83OnAfterModifyItemReclJnl added for Item Reclass Journal to pick correct New CCC Dim Code
    // HEI.14 CHG2154101 GOKULS01 12.07.2022
    //   # Norriq change - added filter in Item ledger entry based on the request
    // HEI.15 CHG2162715 HB3020 NORRIQ KOROLA04 17.11.2022
    //   # T121OnBeforeInsert() - added
    // HEI.16 CHG2162715 HB3020 NORRIQ KOROLA04 21.11.2022
    //   # T121OnBeforeInsert() - modified
    // HEI.17 CHG2162715 HB3020 IBM NANDIS01 22.12.2022 - Adding Production location in Purchase orders
    //   # Modified the filter to find the correct line
    // HEI.18 CHG2187702 SAHAL01 18.09.2023 Revaluation journal items in error
    //   # Added Code
    // BC UPGRADE SHIKHD02 >>
    // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases in all procedures wherever required
    // BC UPGRADE SHIKHD02 <<
    //BC Upgrade YADAVM09 Event Added missed dueing Migration T83OnAfterModifyItemReclJnl.

    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Warehouse Entry" = rm;

    trigger OnRun();
    begin
    end;

    var
        ItemJnlLineError: Record "Item Journal Line";
        gSKU: Record "Stockkeeping Unit";
        CreateLog: Boolean;
        CCCfromSKU: Code[20];
        DimValID: Integer;
        Text001: Label 'You must specify Zone Code on Bin %1 because Zone Code is mandatory on location %2';
        Text002: Label 'User ID %1 is not authorized for Location %2 Zone %3';
        Text003: Label 'Quantity to receive must be the same with Quantity in Transit';
        Text004: Label 'You can change the receiving Zone only with Zone %1 or Zone %2';

    procedure OnLocationChangedItemJnlLine(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer);
    begin
        if Rec."Location Code" = '' then //begin
            Rec.VALIDATE("Zone Code FND", '');
        //end;
    end;

    procedure OnBinChangedItemJnlLine(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer);
    var
        Bin: Record Bin;
        Location: Record Location;
    begin
        if Rec."Bin Code" <> '' then// begin
            if Bin.GET(Rec."Location Code", Rec."Bin Code") then begin
                Location.GET(Rec."Location Code");
                if Location."Zone Mandatory FND" then
                    if Bin."Zone Code" = '' then
                        ERROR(STRSUBSTNO(Text001, Bin.Code, Bin."Location Code"));
                Rec.VALIDATE("Zone Code FND", Bin."Zone Code");

            end;
        // end
    end;

    procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line");
    var
        Bin: Record Bin;
        Location: Record Location;
    begin
        //BC Upgrade SHARMP16 BEGIN<<-- issue in transfer order posting zone code not in item journal from  Lines 
        if ItemJournalLine."Bin Code" <> '' then begin
            if Bin.Get(ItemJournalLine."Location Code", ItemJournalLine."Bin Code") then
                if ItemJournalLine."Zone Code FND" = '' then
                    ItemJournalLine."Zone Code FND" := Bin."Zone Code";
        end;//BC Upgrade SHARMP16 END>> -- issue in transfer order posting zone code not in item journal from  Lines 
        Location.GET(ItemJournalLine."Location Code");
        if Location."Zone Mandatory FND" then begin
            ItemJournalLine.TESTFIELD("Zone Code FND");
            CheckUserAuthorizedinZone(ItemJournalLine."Location Code", ItemJournalLine."Zone Code FND");
        end;
    end;

    procedure OnAfterCheckItemJnlLine(var ItemJnlLine: Record "Item Journal Line");
    var
        Location: Record Location;
        SourceCodeSetup: Record "Source Code Setup";
    begin
        if ItemJnlLine.Adjustment then
            exit;
        SourceCodeSetup.GET();
        if ItemJnlLine."Source Code" = SourceCodeSetup."Adjust Cost" then
            exit;
        if Location.GET(ItemJnlLine."Location Code") then
            if Location."Zone Mandatory FND" then
                ItemJnlLine.TESTFIELD("Zone Code FND");
        if Location.GET(ItemJnlLine."New Location Code") then
            if Location."Zone Mandatory FND" then
                ItemJnlLine.TESTFIELD("New Zone Code FND");
    end;

    procedure OnAferCreateWhseEntry(var WhseEntry: Record "Warehouse Entry");
    var
        Bin: Record Bin;
        Location: Record Location;
        WarehouseEmpl: Record "Warehouse Employee";
    begin
        Location.GET(WhseEntry."Location Code");
        if Location."Zone Mandatory FND" then begin
            if WhseEntry."Zone Code" = '' then begin
                Bin.GET(WhseEntry."Location Code", WhseEntry."Bin Code");
                Bin.TESTFIELD("Zone Code");
                WhseEntry."Zone Code" := Bin."Zone Code";
            end;
            CheckUserAuthorizedinZone(WhseEntry."Location Code", WhseEntry."Zone Code");
        end;
    end;

    procedure OnAfterValidateZoneCodeProdOrderComp(var Rec: Record "Prod. Order Component"; var xRec: Record "Prod. Order Component"; CurrFieldNo: Integer);
    var
        Bin: Record Bin;
        Location: Record Location;
        Zone: Record Zone;
    begin
        // BC UPGRADE SHIKHD02 >> 
        // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases
        // with Rec do begin
        //     VALIDATE("Bin Code", '');
        //     //IF "Zone Code" <> '' THEN BEGIN

        //     //end;
        // end;
        Rec.VALIDATE("Bin Code", '');
        //IF "Zone Code" <> '' THEN BEGIN

        //end;
        // BC UPGRADE SHIKHD02 <<
    end;

    procedure CheckUserAuthorizedinZone(LocationCode: Code[10]; ZoneCode: Code[10]);
    var
        WarehouseEmpl: Record "Warehouse Employee_DTW FND";
        ItemJnlPostBatchL: Codeunit "Item Jnl.-Post Batch";
        ErrorTextL: Text[250];
    begin
        WarehouseEmpl.SETRANGE("User ID", UPPERCASE(USERID));
        if LocationCode = '' then
            exit;
        if ZoneCode = '' then
            exit;
        WarehouseEmpl.SETRANGE("Location Code", LocationCode);
        WarehouseEmpl.SETRANGE("Zone Code", ZoneCode);
        if WarehouseEmpl.ISEMPTY then
            //HEI.18>>
            if CreateLog then begin
                ErrorTextL := COPYSTR(STRSUBSTNO(Text002, USERID, LocationCode, ZoneCode), 1, 250);
                //ItemJnlPostBatchL.InsertRevJnlErrorLog(ItemJnlLineError, ErrorTextL);  // BC Upgrade PATHAA01 - Blocked as this function is uncompiled
                CLEAR(ErrorTextL);
            end else
                //HEI.18<<
                ERROR(STRSUBSTNO(Text002, USERID, LocationCode, ZoneCode));
    end;

    procedure UpdateRelatedActivityLine(var WarehouseActivityLine: Record "Warehouse Activity Line");
    var
        ItemL: Record Item;
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        NewWarehouseActivityLine: Record "Warehouse Activity Line";
        QtyTransit: Decimal;
        Text000L: Label '"""Line No."" should not be zero (0), please re-enter the line after refresing the page for W/h Movement No. %1."';
    begin
        if (WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::Take) then begin
            WarehouseActivityHeader.GET(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.");
            //HEI.09>>
            ItemL.GET(WarehouseActivityLine."Item No.");
            //HEI.09<<
            if not WarehouseActivityHeader."Zone transfer FND" then
                exit;

            //HEI.09>>
            if WarehouseActivityLine."Line No." = 0 then
                ERROR(Text000L, WarehouseActivityLine."No.");
            //HEI.09<<

            WarehouseActivityHeader.TESTFIELD("From Zone Code FND");
            WarehouseActivityHeader.TESTFIELD("To Zone Code FND");
            WarehouseActivityHeader.TESTFIELD("In-Transit Zone FND");
            WarehouseActivityHeader.TESTFIELD("In-Transit Bin FND");
            if (WarehouseActivityLine."Linked To Line No. FND" = 0) then begin
                NewWarehouseActivityLine.INIT();
                NewWarehouseActivityLine."No." := WarehouseActivityLine."No.";
                NewWarehouseActivityLine."Line No." := WarehouseActivityLine."Line No." + 1;
                NewWarehouseActivityLine."Activity Type" := NewWarehouseActivityLine."Activity Type"::Movement;
                NewWarehouseActivityLine."Action Type" := NewWarehouseActivityLine."Action Type"::Place;
                NewWarehouseActivityLine."Linked To Line No. FND" := WarehouseActivityLine."Line No.";
                NewWarehouseActivityLine."Zone-Transfer FND" := true;
                NewWarehouseActivityLine.VALIDATE("Location Code", WarehouseActivityHeader."Location Code");
                NewWarehouseActivityLine.VALIDATE("Zone Code", WarehouseActivityHeader."To Zone Code FND");
                NewWarehouseActivityLine.VALIDATE("In-Transit Zone Code FND", WarehouseActivityHeader."In-Transit Zone FND");
                NewWarehouseActivityLine.VALIDATE("In-Transit Bin Code FND", WarehouseActivityHeader."In-Transit Bin FND");
                //HEI.09>>
                if WarehouseActivityLine."Line No." <> 0 then begin
                    NewWarehouseActivityLine.INSERT(true);
                    //HEI.09<<
                    WarehouseActivityLine."Linked To Line No. FND" := WarehouseActivityLine."Line No." + 1;
                    WarehouseActivityLine.Modify(false);// Bc Upgrade kamnay01 Bug fix Zone warehouse movement 
                    WarehouseActivityLine.VALIDATE("Location Code", WarehouseActivityHeader."Location Code");
                    WarehouseActivityLine.VALIDATE("Zone Code", WarehouseActivityHeader."From Zone Code FND");
                    WarehouseActivityLine.VALIDATE("In-Transit Zone Code FND", WarehouseActivityHeader."In-Transit Zone FND");
                    WarehouseActivityLine.VALIDATE("In-Transit Bin Code FND", WarehouseActivityHeader."In-Transit Bin FND");
                    //HEI.09>>
                end;
                //HEI.09<<
            end;

            if NewWarehouseActivityLine.GET(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.", WarehouseActivityLine."Linked To Line No. FND") then begin
                NewWarehouseActivityLine.VALIDATE("Location Code", WarehouseActivityLine."Location Code");
                NewWarehouseActivityLine.VALIDATE("Zone Code", WarehouseActivityHeader."To Zone Code FND");
                NewWarehouseActivityLine.VALIDATE("In-Transit Zone Code FND", WarehouseActivityHeader."In-Transit Zone FND");
                NewWarehouseActivityLine.VALIDATE("In-Transit Bin Code FND", WarehouseActivityHeader."In-Transit Bin FND");
                NewWarehouseActivityLine.VALIDATE("Item No.", WarehouseActivityLine."Item No.");
                NewWarehouseActivityLine.VALIDATE("Variant Code", WarehouseActivityLine."Variant Code");
                NewWarehouseActivityLine.VALIDATE("Unit of Measure Code", WarehouseActivityLine."Unit of Measure Code");
                NewWarehouseActivityLine.VALIDATE(Quantity, WarehouseActivityLine.Quantity);
                NewWarehouseActivityLine.VALIDATE("Lot No.", WarehouseActivityLine."Lot No.");
                QtyTransit := CalcQtyTransit(NewWarehouseActivityLine);
                if QtyTransit <= NewWarehouseActivityLine."Qty. Outstanding" then
                    NewWarehouseActivityLine.VALIDATE("Qty. to Handle", QtyTransit)
                else
                    NewWarehouseActivityLine.VALIDATE("Qty. to Handle", 0);
                NewWarehouseActivityLine.MODIFY(true);
            end;
        end;
    end;

    procedure CheckEditAllowedWhseActivityLine(var WarehouseActivityLine: Record "Warehouse Activity Line");
    var
        WhseActivityHeader: Record "Warehouse Activity Header";
    begin
        if WhseActivityHeader.GET(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.") then
            WhseActivityHeader.TESTFIELD("Transfer Status FND", WhseActivityHeader."Transfer Status FND"::Pending);
    end;

    procedure OnAfterValidateLocationCodeWarehouseActivityHeader(var Rec: Record "Warehouse Activity Header"; var xRec: Record "Warehouse Activity Header");
    var
        Location: Record Location;
        WarehouseActivityLine: Record "Warehouse Activity Line";
    begin
        Rec.TESTFIELD("Transfer Status FND", Rec."Transfer Status FND"::Pending);
        if Rec."Location Code" = xRec."Location Code" then
            exit;
        Rec.VALIDATE("From Zone Code FND", '');
        Rec.VALIDATE("To Zone Code FND", '');
        Rec.VALIDATE("In-Transit Zone FND", '');
        Rec.VALIDATE("In-Transit Bin FND", '');
        if Rec."Location Code" <> '' then begin
            Location.GET(Rec."Location Code");
            Location.TESTFIELD("Transit Zone FND");
            Location.TESTFIELD("Transit Zone FND");
            // Rec.Validate("In-Transit Zone FND", Location."Transit Zone FND"); // BC Upgrade SHUKLP03 << Blocked validate because no code is available on validate trigger
            // Rec.Validate("In-Transit Bin", Location."Transit Bin"); // BC Upgrade SHUKLP03 << Blocked validate because no code is available on validate trigger
            Rec."In-Transit Zone FND" := Location."Transit Zone FND"; // BC Upgrade SHUKLP03 << 
            Rec."In-Transit Bin FND" := Location."Transit Bin FND"; // BC Upgrade SHUKLP03 << 
        end;
        WarehouseActivityLine.SETRANGE("Activity Type", Rec.Type);
        WarehouseActivityLine.SETRANGE("No.", Rec."No.");
        if WarehouseActivityLine.findset() then
            repeat
                WarehouseActivityLine."In-Transit Zone Code FND" := Rec."In-Transit Zone FND";
                WarehouseActivityLine."In-Transit Bin Code FND" := Rec."In-Transit Bin FND";
                WarehouseActivityLine."Zone-Transfer FND" := true;
                WarehouseActivityLine.MODIFY();
            until WarehouseActivityLine.NEXT() = 0;
    end;

    procedure CheckedWhseActLineAllowedChange(var WarehouseActivityLine: Record "Warehouse Activity Line"): Boolean;
    var
        ParentActivityLine: Record "Warehouse Activity Line";
    begin
        // BC UPGRADE SHIKHD02 >> 
        // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases
        // with WarehouseActivityLine do begin
        //     if not "Zone-Transfer FND" then
        //         exit(true);
        //     //IF Quantity <> "Qty. Outstanding (Base)" THEN
        //     if Quantity <> "Qty. Outstanding" then
        //         exit(false);
        //     if WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::Place then begin
        //         if ParentActivityLine.GET("Activity Type", "No.", "Linked To Line No. FND") then
        //             exit(WarehouseActivityLine.Quantity <> WarehouseActivityLine."Qty. Outstanding");

        //     end;
        // end;
        if not WarehouseActivityLine."Zone-Transfer FND" then
            exit(true);
        //IF Quantity <> "Qty. Outstanding (Base)" THEN
        if WarehouseActivityLine.Quantity <> WarehouseActivityLine."Qty. Outstanding" then
            exit(false);
        if WarehouseActivityLine."Action Type" = WarehouseActivityLine."Action Type"::Place then begin
            if ParentActivityLine.GET(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.", WarehouseActivityLine."Linked To Line No. FND") then
                exit(WarehouseActivityLine.Quantity <> WarehouseActivityLine."Qty. Outstanding");

        end;
        // BC UPGRADE SHIKHD02 <<
        exit(true);
    end;

    procedure CalcQtyTransit(var WarehouseActivityLine: Record "Warehouse Activity Line"): Decimal;
    var
        WarehouseEntry: Record "Warehouse Entry";
        QtyTransit: Decimal;
    begin
        QtyTransit := 0;
        // BC UPGRADE SHIKHD02 >> 
        // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases
        // with WarehouseActivityLine do begin
        //     WarehouseEntry.SETCURRENTKEY("Movement No. FND");
        //     WarehouseEntry.SETRANGE("Movement No. FND", "No.");
        //     WarehouseEntry.SETRANGE("Transit-Zone FND", true);
        //     WarehouseEntry.SETFILTER("Reference Line No. FND ", '%1|%2', "Line No.", "Linked To Line No. FND");
        //     if WarehouseEntry.findset() then
        //         repeat
        //             QtyTransit += WarehouseEntry.Quantity;
        //         until WarehouseEntry.NEXT() = 0;
        // end;
        WarehouseEntry.SETCURRENTKEY("Movement No. FND");
        WarehouseEntry.SETRANGE("Movement No. FND", WarehouseActivityLine."No.");
        WarehouseEntry.SETRANGE("Transit-Zone FND", true);
        WarehouseEntry.SETFILTER("Reference Line No. FND", '%1|%2', WarehouseActivityLine."Line No.", WarehouseActivityLine."Linked To Line No. FND");
        if WarehouseEntry.findset() then
            repeat
                QtyTransit += WarehouseEntry.Quantity;
            until WarehouseEntry.NEXT() = 0;
        // BC UPGRADE SHIKHD02 << 
        exit(QtyTransit);
    end;

    procedure CalcQtyTransitRef(var WhseActivityLine: Record "Warehouse Activity Line"; var QtyInTransit: Decimal; var QtyInTransitBase: Decimal);
    var
        WarehouseEntry: Record "Warehouse Entry";
    begin
        // BC UPGRADE SHIKHD02 >> 
        // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases
        // with WhseActivityLine do begin
        //     QtyInTransit := 0;
        //     QtyInTransitBase := 0;
        //     WarehouseEntry.SETCURRENTKEY("Movement No. FND");
        //     WarehouseEntry.SETRANGE("Movement No. FND", "No.");
        //     WarehouseEntry.SETRANGE("Transit-Zone FND", true);
        //     WarehouseEntry.SETFILTER("Reference Line No. FND ", '%1|%2', "Line No.", "Linked To Line No. FND");
        //     if WarehouseEntry.findset() then
        //         repeat
        //             QtyInTransit += WarehouseEntry.Quantity;
        //             QtyInTransitBase += WarehouseEntry."Qty. (Base)";
        //         until WarehouseEntry.NEXT() = 0;
        // end;
        QtyInTransit := 0;
        QtyInTransitBase := 0;
        WarehouseEntry.SETCURRENTKEY("Movement No. FND");
        WarehouseEntry.SETRANGE("Movement No. FND", WhseActivityLine."No.");
        WarehouseEntry.SETRANGE("Transit-Zone FND", true);
        WarehouseEntry.SETFILTER("Reference Line No. FND", '%1|%2', WhseActivityLine."Line No.", WhseActivityLine."Linked To Line No. FND");
        if WarehouseEntry.findset() then
            repeat
                QtyInTransit += WarehouseEntry.Quantity;
                QtyInTransitBase += WarehouseEntry."Qty. (Base)";
            until WarehouseEntry.NEXT() = 0;
        // BC UPGRADE SHIKHD02 <<
    end;

    procedure OnBeforeValidateQtytoHandleWhseActivLine(var Rec: Record "Warehouse Activity Line"; var xRec: Record "Warehouse Activity Line"; CurrFieldNo: Integer);
    begin
        if Rec."Zone-Transfer FND" then begin
            if Rec."Action Type" = Rec."Action Type"::Place then begin
                if Rec."Qty. to Handle" <> CalcQtyTransit(Rec) then
                    ERROR(Text003);
            end;
        end;
    end;

    procedure OnBeforePostItemJnlLine(var ItemJournalLine: Record "Item Journal Line");
    var
        Bin: Record Bin;
    begin
        // BC UPGRADE SHIKHD02 >> 
        // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases
        // with ItemJournalLine do begin
        //     //HEI.18>>
        //     GetItemJnlLine(ItemJournalLine);
        //     //HEI.18<<
        //     if "Bin Code" <> '' then begin
        //         Bin.GET("Location Code", "Bin Code");
        //         "Zone Code" := Bin."Zone Code";
        //         if "Zone Code" <> '' then
        //             CheckUserAuthorizedinZone("Location Code", "Zone Code");
        //     end;
        //     if "New Bin Code" <> '' then begin
        //         Bin.GET("New Location Code", "New Bin Code");
        //         "New Zone Code FND" := Bin."Zone Code";
        //         if "New Zone Code FND" <> '' then
        //             CheckUserAuthorizedinZone("New Location Code", "New Zone Code FND");
        //     end;
        // end;

        //HEI.18>>
        GetItemJnlLine(ItemJournalLine);
        //HEI.18<<
        if ItemJournalLine."Bin Code" <> '' then begin
            Bin.GET(ItemJournalLine."Location Code", ItemJournalLine."Bin Code");
            ItemJournalLine."Zone Code FND" := Bin."Zone Code";
            if ItemJournalLine."Zone Code FND" <> '' then
                CheckUserAuthorizedinZone(ItemJournalLine."Location Code", ItemJournalLine."Zone Code FND");
        end;
        if ItemJournalLine."New Bin Code" <> '' then begin
            Bin.GET(ItemJournalLine."New Location Code", ItemJournalLine."New Bin Code");
            ItemJournalLine."New Zone Code FND" := Bin."Zone Code";
            if ItemJournalLine."New Zone Code FND" <> '' then
                CheckUserAuthorizedinZone(ItemJournalLine."New Location Code", ItemJournalLine."New Zone Code FND");
        end;
        // BC UPGRADE SHIKHD02 <<
    end;

    procedure OnAfterValidateItemJournalLineBinCode(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer);
    var
        Bin: Record Bin;
        Location: Record Location;
    begin
        // BC UPGRADE SHIKHD02 >> 
        // Removed the WITH statement and replaced it with explicit record references, as WITH is deprecated and will become an error in future Business Central releases
        // with Rec do begin
        //     if ("Bin Code" <> xRec."Bin Code") and ("Bin Code" <> '') then begin
        //         TESTFIELD("Location Code");
        //         Location.GET("Location Code");
        //         if Location."Zone Mandatory" then begin
        //             Bin.GET("Location Code", "Bin Code");
        //             Bin.TESTFIELD("Zone Code");
        //             //HEI.07>>
        //             //"Zone Code" := Bin."Zone Code";
        //             //HEI.07<<
        //         end;
        //     end;
        // end;
        if (Rec."Bin Code" <> xRec."Bin Code") and (Rec."Bin Code" <> '') then begin
            Rec.TESTFIELD(Rec."Location Code");
            Location.GET(Rec."Location Code");
            if Location."Zone Mandatory FND" then begin
                Bin.GET(Rec."Location Code", Rec."Bin Code");
                Bin.TESTFIELD("Zone Code");
                //HEI.07>>
                //"Zone Code" := Bin."Zone Code";
                //HEI.07<<
            end;
        end;
        // BC UPGRADE SHIKHD02 << 
    end;

    procedure OnAfterValidateWhseActivityLineZoneCode(var Rec: Record "Warehouse Activity Line"; var xRec: Record "Warehouse Activity Line"; CurrFieldNo: Integer);
    var
        WhseActivityHdr: Record "Warehouse Activity Header";
        WarehouseActivityLine: Record "Warehouse Activity Line";
    begin
        if Rec."Zone Code" = '' then begin
            Rec.VALIDATE("Bin Code", '');
            exit
        end;
        if (Rec."Zone Code" = xRec."Zone Code") then
            exit;
        //CheckUserAuthorizedinZone(Rec."Location Code",Rec."Zone Code");
        WhseActivityHdr.GET(Rec."Activity Type", Rec."No.");
        if (Rec."Action Type" = Rec."Action Type"::Place) then begin
            if WarehouseActivityLine.GET(Rec."Activity Type", Rec."No.", Rec."Linked To Line No. FND") then begin
                if not (Rec."Zone Code" in [WarehouseActivityLine."Zone Code", WhseActivityHdr."To Zone Code FND"]) then
                    ERROR(Text001, WarehouseActivityLine."Zone Code");
            end;
        end;
        if (Rec."Action Type" = Rec."Action Type"::Take) then
            WarehouseActivityLine.TESTFIELD("Quantity Shipped FND", 0);
    end;

    procedure OnAfterValidateProdBOMVerCodeProdOrdeLine(var Rec: Record "Prod. Order Line"; var xRec: Record "Prod. Order Line"; CurrFieldNo: Integer);
    var
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProductionOrder: Record "Production Order";
        RefreshProductionOrder: Report "Refresh Production Order";
        CalculateProdOrder: Codeunit "Calculate Prod. Order";
        Message001: Label 'Production BOM has been updated';
        Message002: Label 'Production Routing has been updated';
    begin
        //HEI.02>>
        case CurrFieldNo of
            Rec.FIELDNO("Production BOM Version Code"):
                begin
                    if (xRec."Production BOM Version Code" <> Rec."Production BOM Version Code") and (Rec.Quantity <> 0) then begin
                        ProdOrderComp.SETRANGE(Status, Rec.Status);
                        ProdOrderComp.SETRANGE("Prod. Order No.", Rec."Prod. Order No.");
                        ProdOrderComp.SETRANGE("Prod. Order Line No.", Rec."Line No.");
                        ProdOrderComp.DELETEALL(true);
                        CheckProductionBOMStatus(Rec."Production BOM No.", Rec."Production BOM Version Code");
                        CalculateProdOrder.Calculate(Rec, 1, false, true, false, false);
                        //>>HEI.10
                        if GUIALLOWED then begin
                            //<<HEI.10
                            MESSAGE(Message001)
                            //>>HEI.10
                        end;
                        //<<HEI.10
                    end;
                end;
            Rec.FIELDNO("Routing Version Code"):
                begin
                    if (xRec."Routing Version Code" <> Rec."Routing Version Code") and (Rec.Quantity <> 0) then begin
                        ProdOrderRtngLine.SETRANGE(Status, Rec.Status);
                        ProdOrderRtngLine.SETRANGE("Prod. Order No.", Rec."Prod. Order No.");
                        ProdOrderRtngLine.SETRANGE("Routing Reference No.", Rec."Routing Reference No.");
                        ProdOrderRtngLine.SETRANGE("Routing No.", Rec."Routing No.");
                        if ProdOrderRtngLine.findset(true) then
                            repeat
                                ProdOrderRtngLine.SetSkipUpdateOfCompBinCodes(true);
                                ProdOrderRtngLine.DELETE(true);
                            until ProdOrderRtngLine.NEXT() = 0;
                        CheckRoutingStatus(Rec."Routing No.", Rec."Routing Version Code");
                        CalculateProdOrder.Calculate(Rec, 1, true, false, false, false);
                        //>>HEI.10
                        if GUIALLOWED then begin
                            //<<HEI.10
                            MESSAGE(Message002);
                            //>>HEI.10
                        end;
                        //<<HEI.10
                    end;
                end;
        end
        //HEI.02<<
    end;

    local procedure CheckProductionBOMStatus(ProdBOMNo: Code[20]; ProdBOMVersionNo: Code[20]);
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMVersion: Record "Production BOM Version";
    begin
        //HEI.02>>
        if ProdBOMNo = '' then
            exit;

        if ProdBOMVersionNo = '' then begin
            ProductionBOMHeader.GET(ProdBOMNo);
            ProductionBOMHeader.TESTFIELD(Status, ProductionBOMHeader.Status::Certified);
        end else begin
            ProductionBOMVersion.GET(ProdBOMNo, ProdBOMVersionNo);
            ProductionBOMVersion.TESTFIELD(Status, ProductionBOMVersion.Status::Certified);
        end;
        //HEI.02<<
    end;

    local procedure CheckRoutingStatus(RoutingNo: Code[20]; RoutingVersionNo: Code[20]);
    var
        RoutingHeader: Record "Routing Header";
        RoutingVersion: Record "Routing Version";
    begin
        //HEI.02>>
        if RoutingNo = '' then
            exit;

        if RoutingVersionNo = '' then begin
            RoutingHeader.GET(RoutingNo);
            RoutingHeader.TESTFIELD(Status, RoutingHeader.Status::Certified);
        end else begin
            RoutingVersion.GET(RoutingNo, RoutingVersionNo);
            RoutingVersion.TESTFIELD(Status, RoutingVersion.Status::Certified);
        end;
        //HEI.02<<
    end;


    //BC Upgrade PATHAA02>> //Quality Status is DIT field
    // procedure OnAfterValidateQualityStatusLotNoInformation(var Rec: Record "Lot No. Information"; var xRec: Record "Lot No. Information");
    // var
    //     ItemLedgerEntry: Record "Item Ledger Entry";
    //     WarehouseEntry: Record "Warehouse Entry";
    //     inventorysetup: Record "Inventory Setup";
    //     LotNoInformation: Record "Lot No. Information";
    // begin
    //     //HEI.11>>
    //     //HEI.05>>
    //     //HEI.03>>

    //     if Rec."Quality Status" = xRec."Quality Status" then
    //         exit;

    //     inventorysetup.GET;
    //     if inventorysetup."Lots skipped" <> '' then begin
    //         LotNoInformation.RESET();
    //         LotNoInformation.SETRANGE("Item No.", Rec."Item No.");
    //         LotNoInformation.SETRANGE("Variant Code", Rec."Variant Code");
    //         LotNoInformation.SETFILTER("Lot No.", inventorysetup."Lots skipped");
    //         if LotNoInformation.findset(false) then
    //             repeat
    //                 if Rec."Lot No." = LotNoInformation."Lot No." then
    //                     exit;
    //             until LotNoInformation.NEXT = 0;

    //     end; 



    // ItemLedgerEntry.SETCURRENTKEY("Item No.", "Lot No.");
    // ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
    // ItemLedgerEntry.SETRANGE("Lot No.", Rec."Lot No.");
    // ItemLedgerEntry.SETFILTER("Remaining Quantity", '>%1', 0);//HEI.14 - filter added
    // ItemLedgerEntry.MODIFYALL("Quality Status", Rec."Quality Status");

    // WarehouseEntry.SETCURRENTKEY("Item No.", "Lot No.");
    // WarehouseEntry.SETRANGE("Item No.", Rec."Item No.");
    // WarehouseEntry.SETRANGE("Lot No.", Rec."Lot No.");
    // WarehouseEntry.MODIFYALL("Quality Status", Rec."Quality Status");
    // //HEI.03<<
    // //HEI.05<<
    // //HEI.11<<
    // end;
    //BC Upgrade PATHAA02>> //Quality Status is DIT field

    [EventSubscriber(ObjectType::Table, 5406, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyProdOrderLine(var Rec: Record "Prod. Order Line"; var xRec: Record "Prod. Order Line"; RunTrigger: Boolean);
    var
        ProdOrd: Record "Production Order";
    begin
        //HEI.01>>
        if Rec.Status in [Rec.Status::"Firm Planned", Rec.Status::Released] then begin
            //CheckUserAuthorizedinZone(Rec."Location Code", xRec."Zone Code");  // BC Upgrade NANDIS03
            //CheckUserAuthorizedinZone(Rec."Location Code", Rec."Zone Code");  // BC Upgrade NANDIS03
            if ProdOrd.GET(Rec.Status, Rec."Prod. Order No.") then
                CheckUserAuthorizedinZone(ProdOrd."Location Code", ProdOrd."Zone Code FND");

        end;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Table, 5407, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyProdOrderComp(var Rec: Record "Prod. Order Component"; var xRec: Record "Prod. Order Component"; RunTrigger: Boolean);
    var
        ProdOrd: Record "Production Order";
    begin
        //HEI.01>>
        if Rec.Status in [Rec.Status::"Firm Planned", Rec.Status::Released] then begin
            //CheckUserAuthorizedinZone(Rec."Location Code", xRec."Zone Code");  // BC Upgrade NANDIS03
            //CheckUserAuthorizedinZone(Rec."Location Code", Rec."Zone Code");  // BC Upgrade NANDIS03
            if ProdOrd.GET(Rec.Status, Rec."Prod. Order No.") then
                CheckUserAuthorizedinZone(ProdOrd."Location Code", ProdOrd."Zone Code FND");
        end;
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Table, 5409, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyProdOrderRtg(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line"; RunTrigger: Boolean);
    var
        ProdOrd: Record "Production Order";
    begin
        //HEI.01>>
        if Rec.Status in [Rec.Status::"Firm Planned", Rec.Status::Released] then begin
            if ProdOrd.GET(Rec.Status, Rec."Prod. Order No.") then
                CheckUserAuthorizedinZone(ProdOrd."Location Code", ProdOrd."Zone Code FND");
        end;
        //HEI.01<<
    end;

    procedure InsertSkuDim(var Item: Record Item);
    var
        DefaultDimension: Record "Default Dimension";
        DimValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        if Item.ISTEMPORARY then
            exit;
        GLSetup.GET();
        if GLSetup."SKU Dimension Code FND" = '' then
            exit;

        DimValue.SETRANGE("Dimension Code", GLSetup."SKU Dimension Code FND");
        DimValue.SETRANGE(Code, Item."No.");
        if DimValue.FINDFIRST() then begin
            if DimValue.Name <> Item.Description then begin
                DimValue.VALIDATE(Name, Item.Description);
                DimValue.MODIFY(true);
            end;
        end else begin
            CLEAR(DimValue);
            DimValue.VALIDATE("Dimension Code", GLSetup."SKU Dimension Code FND");
            DimValue.VALIDATE(Code, Item."No.");
            DimValue.VALIDATE(Name, Item.Description);
            DimValue.INSERT(true);
        end;

        CLEAR(DefaultDimension);
        DefaultDimension.SETRANGE("Table ID", DATABASE::Item);
        DefaultDimension.SETRANGE("Dimension Code", GLSetup."SKU Dimension Code FND");
        DefaultDimension.SETRANGE("No.", Item."No.");
        if DefaultDimension.FINDFIRST() then begin
            if DefaultDimension."Dimension Value Code" <> Item."No." then begin
                DefaultDimension.VALIDATE("Dimension Value Code", Item."No.");
                DefaultDimension.MODIFY(true);
            end;
        end else begin
            CLEAR(DefaultDimension);
            DefaultDimension.VALIDATE("Table ID", DATABASE::Item);
            DefaultDimension.VALIDATE("Dimension Code", GLSetup."SKU Dimension Code FND");
            DefaultDimension.VALIDATE("No.", Item."No.");
            DefaultDimension.VALIDATE("Dimension Value Code", Item."No.");
            DefaultDimension.INSERT(true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventItem(var Rec: Record Item; RunTrigger: Boolean);
    begin
        InsertSkuDim(Rec);
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyEventItem(var Rec: Record Item; var xRec: Record Item; RunTrigger: Boolean);
    begin
        InsertSkuDim(Rec);
    end;

    procedure CallUpdateRelatedActivityLine(var WarehouseActivityLine: Record "Warehouse Activity Line");
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        NewWarehouseActivityLine: Record "Warehouse Activity Line";
        QtyTransit: Decimal;
    begin
        //HEI.09>>
        UpdateRelatedActivityLine(WarehouseActivityLine);
        CheckEditAllowedWhseActivityLine(WarehouseActivityLine);
        //HEI.09<<
    end;

    [EventSubscriber(ObjectType::Table, 5741, 'OnAfterInsertEvent', '', false, false)]
    local procedure CCCDimforT5741OnInsert(var Rec: Record "Transfer Line"; RunTrigger: Boolean);
    var
        lDimSetEntry: Record "Dimension Set Entry";
        lDimSetEntry2: Record "Dimension Set Entry";
        lDimVal: Record "Dimension Value";
        lGLSetUp: Record "General Ledger Setup";
        lSKU: Record "Stockkeeping Unit";
    begin
        //HEI.12>>
        if Rec.ISTEMPORARY then
            exit;
        lGLSetUp.GET();
        lSKU.RESET();
        lSKU.SETRANGE("Item No.", Rec."Item No.");
        lSKU.SETRANGE("Location Code", Rec."Transfer-from Code");
        if lSKU.FINDFIRST() then
            CCCfromSKU := lSKU."CCC Dim. Code FND";

        lDimVal.RESET();
        lDimVal.SETRANGE("Dimension Code", lGLSetUp."Shortcut Dimension 2 Code");
        lDimVal.SETRANGE(Code, CCCfromSKU);
        if lDimVal.FINDFIRST() then
            DimValID := lDimVal."Dimension Value ID";
        lDimSetEntry.RESET();
        lDimSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
        lDimSetEntry.SETRANGE("Dimension Code", lGLSetUp."Global Dimension 2 Code");
        if not lDimSetEntry.FINDFIRST() then begin
            Rec.VALIDATE("Dimension Set ID", fGetDimSetId(Rec));
            Rec.MODIFY();
        end;
        //HEI.12<<
    end;

    [EventSubscriber(ObjectType::Table, 5741, 'OnAfterModifyEvent', '', false, false)]
    local procedure CCCDimforT5741OnModify(var Rec: Record "Transfer Line"; var xRec: Record "Transfer Line"; RunTrigger: Boolean);
    var
        lDimSetEntry: Record "Dimension Set Entry";
        lDimSetEntry2: Record "Dimension Set Entry";
        lDimVal: Record "Dimension Value";
        lGLSetUp: Record "General Ledger Setup";
        lSKU: Record "Stockkeeping Unit";
    begin
        //HEI.12>>
        if Rec.ISTEMPORARY then
            exit;
        if (Rec."Transfer-from Code" <> '') and (Rec."Transfer-from Code" <> xRec."Transfer-from Code") then begin
            lGLSetUp.GET();
            lSKU.RESET();
            lSKU.SETRANGE("Item No.", Rec."Item No.");
            lSKU.SETRANGE("Location Code", Rec."Transfer-from Code");
            if lSKU.FINDFIRST() then
                CCCfromSKU := lSKU."CCC Dim. Code FND";
            if CCCfromSKU <> '' then begin
                lDimVal.RESET();
                lDimVal.SETRANGE("Dimension Code", lGLSetUp."Shortcut Dimension 2 Code");
                lDimVal.SETRANGE(Code, CCCfromSKU);
                if lDimVal.FINDFIRST() then
                    DimValID := lDimVal."Dimension Value ID";
                lDimSetEntry.RESET();
                lDimSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                lDimSetEntry.SETRANGE("Dimension Code", lGLSetUp."Global Dimension 2 Code");
                if not lDimSetEntry.FINDFIRST() then begin
                    Rec.VALIDATE("Dimension Set ID", fGetDimSetId(Rec));
                    Rec.MODIFY();
                end
                else begin
                    Rec.VALIDATE("Dimension Set ID", fGetDimSetId2(Rec));
                    Rec.MODIFY();
                end;
            end;
        end;

        if (Rec."Item No." <> '') and (Rec."Item No." <> xRec."Item No.") then begin
            lGLSetUp.GET();
            lSKU.RESET();
            lSKU.SETRANGE("Item No.", Rec."Item No.");
            lSKU.SETRANGE("Location Code", Rec."Transfer-from Code");
            if lSKU.FINDFIRST() then
                CCCfromSKU := lSKU."CCC Dim. Code FND";
            if CCCfromSKU <> '' then begin
                lDimVal.RESET();
                lDimVal.SETRANGE("Dimension Code", lGLSetUp."Shortcut Dimension 2 Code");
                lDimVal.SETRANGE(Code, CCCfromSKU);
                if lDimVal.FINDFIRST() then
                    DimValID := lDimVal."Dimension Value ID";
                lDimSetEntry.RESET();
                lDimSetEntry.SETRANGE("Dimension Set ID", Rec."Dimension Set ID");
                lDimSetEntry.SETRANGE("Dimension Code", lGLSetUp."Global Dimension 2 Code");
                if not lDimSetEntry.FINDFIRST() then begin
                    Rec.VALIDATE("Dimension Set ID", fGetDimSetId(Rec));
                    Rec.MODIFY();
                end
                else begin
                    Rec.VALIDATE("Dimension Set ID", fGetDimSetId2(Rec));
                    Rec.MODIFY();
                end;
            end;
        end;

        //HEI.12<<
    end;

    local procedure fGetDimSetId(TransferLine: Record "Transfer Line"): Integer;
    var
        DefaultDimension: Record "Default Dimension";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        TempDimensionSetEntry2: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionManagement: Codeunit DimensionManagement;
        dimsetid: Integer;
        dimsetid1: Integer;
    begin
        //HEI.12>>
        GeneralLedgerSetup.GET();
        TempDimensionSetEntry.DELETEALL();
        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, TransferLine."Dimension Set ID");
        //TempDimensionSetEntry.DELETEALL;
        //dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        //DimensionManagement.GetDimensionSet(TempDimensionSetEntry2,dimsetid);
        //TempDimensionSetEntry2.RESET;
        TempDimensionSetEntry."Dimension Code" := GeneralLedgerSetup."Shortcut Dimension 2 Code";
        TempDimensionSetEntry."Dimension Value Code" := CCCfromSKU;
        TempDimensionSetEntry."Dimension Value ID" := DimValID;
        TempDimensionSetEntry.INSERT();
        dimsetid := 0;
        dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        exit(dimsetid);
        //HEI.12<<
    end;

    local procedure fGetDimSetId2(TransferLine: Record "Transfer Line"): Integer;
    var
        DefaultDimension: Record "Default Dimension";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        TempDimensionSetEntry2: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";
        GeneralLedgerSetup: Record "General Ledger Setup";
        DimensionManagement: Codeunit DimensionManagement;
        dimsetid: Integer;
        dimsetid1: Integer;
    begin
        //HEI.12>>
        GeneralLedgerSetup.GET();
        TempDimensionSetEntry.DELETEALL();
        DimensionManagement.GetDimensionSet(TempDimensionSetEntry, TransferLine."Dimension Set ID");
        //TempDimensionSetEntry.DELETEALL;
        //dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        //DimensionManagement.GetDimensionSet(TempDimensionSetEntry2,dimsetid);
        //TempDimensionSetEntry2.RESET;
        TempDimensionSetEntry.SETRANGE("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 2 Code");
        if TempDimensionSetEntry.FINDFIRST() then begin
            TempDimensionSetEntry."Dimension Value Code" := CCCfromSKU;
            TempDimensionSetEntry."Dimension Value ID" := DimValID;
            TempDimensionSetEntry.MODIFY();
            dimsetid := 0;
            dimsetid := DimensionManagement.GetDimensionSetID(TempDimensionSetEntry);
        end;
        exit(dimsetid);
        //HEI.12<<
    end;

    [EventSubscriber(ObjectType::Table, 121, 'OnBeforeInsertEvent', '', true, true)]
    local procedure T121OnBeforeInsert(var Rec: Record "Purch. Rcpt. Line"; RunTrigger: Boolean);
    var
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        WarehouseEntry: Record "Warehouse Entry";
    begin
        //HEI.15 >>
        WarehouseEntry.SETCURRENTKEY("Reference No.", "Registering Date");
        WarehouseEntry.SETRANGE("Reference No.", Rec."Document No.");
        WarehouseEntry.SETRANGE("Reference Document", WarehouseEntry."Reference Document"::"Posted Rcpt.");
        //WarehouseEntry.SETRANGE("Reference Line No. FND ", WarehouseEntry."Whse. Document Line No.");//HEI.16  //HEI.17
        WarehouseEntry.SETRANGE("Source Line No.", Rec."Line No.");//HEI.17
        if not WarehouseEntry.FINDFIRST() then
            exit;

        if not PostedWhseRcptLine.GET(WarehouseEntry."Whse. Document No.", WarehouseEntry."Whse. Document Line No.") then
            exit;

        //Rec."SPL Code" := PostedWhseRcptLine."SPL Code";  // BC Upgrade NANDIS03
        //Rec."SPL Name" := PostedWhseRcptLine."SPL Name";  // BC Upgrade NANDIS03
        //HEI.15 <<
    end;

    procedure GetItemJnlLine(var ItemJournalLine: Record "Item Journal Line");
    var
        InventorySetupL: Record "Inventory Setup";
        ItemJnlTemplateL: Record "Item Journal Template";
    begin
        //HEI.18>>
        CLEAR(ItemJnlLineError);
        CLEAR(CreateLog);
        if InventorySetupL.GET() then begin
            if InventorySetupL."Activate Rev.Jnl.Error Log FND" then begin
                if ItemJnlTemplateL.GET(ItemJournalLine."Journal Template Name") then begin
                    if ItemJnlTemplateL.Type = ItemJnlTemplateL.Type::Revaluation then begin
                        ItemJnlLineError.SETRANGE("Journal Template Name", ItemJournalLine."Journal Template Name");
                        ItemJnlLineError.SETRANGE("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        ItemJnlLineError.SETRANGE("Line No.", ItemJournalLine."Line No.");
                        if ItemJnlLineError.FINDFIRST() then;
                        CreateLog := true;
                    end;
                end;
            end;
        end;
        //HEI.18<<
    end;
    //Bc Upgrade YADAVM09>>
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure T83OnAfterModifyItemReclJnl(
    var Rec: Record "Item Journal Line";
    var xRec: Record "Item Journal Line";
    RunTrigger: Boolean)
    var
        Bin: Record Bin;
    begin
        //HEI.13>>
        IF (Rec."New Location Code" <> '') AND (Rec."New Location Code" <> xRec."New Location Code") THEN BEGIN
            IF Rec."Entry Type" IN [Rec."Entry Type"::Consumption, Rec."Entry Type"::Output, Rec."Entry Type"::"Assembly Consumption", Rec."Entry Type"::"Assembly Output"] THEN BEGIN//HEI.33
                IF Bin.GET(Rec."New Location Code", Rec."Bin Code") AND (Bin."Ccc Code fnd" <> '') THEN
                    Rec.VALIDATE(Rec."New Shortcut Dimension 2 Code", Bin."Ccc Code fnd");
                //HEI.33>>
            END
            ELSE BEGIN
                IF Bin.GET(Rec."New Location Code", Rec."Bin Code") AND (Bin."Ccc Code fnd" <> '') THEN
                    Rec.VALIDATE(Rec."New Shortcut Dimension 2 Code", Bin."Ccc Code fnd")
                ELSE BEGIN
                    IF gSKU.GET(Rec."New Location Code", Rec."Item No.", Rec."Variant Code") THEN BEGIN//HEI.36
                        IF gSKU."CCC Dim. Code fnd" <> '' THEN BEGIN//HEI.36
                            Rec.VALIDATE("New Shortcut Dimension 2 Code", gSKU."CCC Dim. Code fnd");
                            Rec.MODIFY;
                        END ELSE BEGIN
                            Rec.VALIDATE("New Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                            Rec.MODIFY;
                        END;
                    END;//HEI.36
                END;
            END;
        END;
        IF (Rec."New Location Code" = '') AND (Rec."New Location Code" <> xRec."New Location Code") THEN BEGIN
            Rec.VALIDATE(Rec."New Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
            Rec.MODIFY;
        END;
        //HEI.13<<
    end;
    //Bc Upgrade YADAVM09<<

    //BC UPGRADE PATHAA02 GAP014_DTW, IBM GAP DTW 43>>  
    procedure OnAfterValidateInspectionStatusLotNoInformation(var Rec: Record "Lot No. Information"; var xRec: Record "Lot No. Information");
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        WarehouseEntry: Record "Warehouse Entry";
        inventorysetup: Record "Inventory Setup";
        LotNoInformation: Record "Lot No. Information";
    begin

        if Rec."Inspection Status Code 07 FDW" = xRec."Inspection Status Code 07 FDW" then
            exit;

        inventorysetup.GET;
        if inventorysetup."Lots skipped FND" <> '' then begin
            LotNoInformation.RESET();
            LotNoInformation.SETRANGE("Item No.", Rec."Item No.");
            LotNoInformation.SETRANGE("Variant Code", Rec."Variant Code");
            LotNoInformation.SETFILTER("Lot No.", inventorysetup."Lots skipped FND");
            if LotNoInformation.findset(false) then
                repeat
                    if Rec."Lot No." = LotNoInformation."Lot No." then
                        exit;
                until LotNoInformation.NEXT = 0;
        end;
        // ItemLedgerEntry.SETCURRENTKEY("Item No.", "Lot No.");
        // ItemLedgerEntry.SETRANGE("Item No.", Rec."Item No.");
        // ItemLedgerEntry.SETRANGE("Lot No.", Rec."Lot No.");
        // ItemLedgerEntry.SETFILTER("Remaining Quantity", '>%1', 0);//HEI.14 - filter added
        // ItemLedgerEntry.MODIFYALL("Inspection Status 07FDW", Rec."Inspection Status Code 07 FDW"); //Aptean provided Inspection status field on ILE, so it will be modifying it.

        WarehouseEntry.Reset();
        WarehouseEntry.SETCURRENTKEY("Item No.", "Lot No.");
        WarehouseEntry.SETRANGE("Item No.", Rec."Item No.");
        WarehouseEntry.SETRANGE("Lot No.", Rec."Lot No.");
        if not WarehouseEntry.IsEmpty() then begin
            WarehouseEntry.MODIFYALL("Inspection Status FND", Rec."Inspection Status Code 07 FDW");
            WarehouseEntry.MODIFYALL("Unavail. Stock (Quality) FND", Rec."Inspection Status Code 07 FDW" = inventorysetup."Quality Blocked FND");  //BCUP0-100 PATHAA02 08.07.26
            //Changes done to update the Unavailable stock (Quality) field on Warehouse Entry table based on the Inspection status code.     
        end;
    end;
    //BC UPGRADE PATHAA02 GAP014_DTW, IBM GAP DTW 43<<
}

