report 51092 "Suggest Allocate Consump CBN"
{
    // version HEI.01

    // HEI.01 CHG2140470 SAHAL01 09.11.2022 # Created New Report: 50575 - Suggest/Allocate Consumption
    //                                      # Added Code to suggest or allocate consumption lines

    //---- Bc Upgrade YADAVM09 Drink it code commmented

    CaptionML = ENU = 'Suggest/Allocate Consumption',
                FRA = 'Calculer consommation';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Order No.", "Order Line No.", "Prod. Order Comp. Line No.", "Entry Type") where("Entry Type" = CONST(Consumption), "Order Type" = CONST(Production));
            dataitem("Production Order"; "Production Order")
            {
                DataItemLink = "No." = FIELD("Order No.");
                DataItemTableView = sorting(Status, "No.") where(Status = FILTER(<> Finished));
                dataitem("Prod. Order Component"; "Prod. Order Component")
                {
                    DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                    DataItemTableView = sorting(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");

                    trigger OnAfterGetRecord();
                    var
                        ItemL: Record Item;
                        ProdOrderLineL: Record "Prod. Order Line";
                    begin
                        //HEI.01>>
                        if GUIALLOWED then
                            Window.UPDATE(2, "Item No.");
                        TESTFIELD("Location Code");
                        ItemL.GET("Item No.");
                        ProdOrderLineL.GET(Status, "Prod. Order No.", "Prod. Order Line No.");

                        ItemJnlBuffer.RESET();
                        ItemJnlBuffer.SETCURRENTKEY("Document No.", "Item No.", "Zone Code", "Lot No.");
                        ItemJnlBuffer.SETRANGE("Document No.", "Item Ledger Entry"."Document No.");
                        ItemJnlBuffer.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                        ItemJnlBuffer.SETRANGE("Zone Code", "Item Ledger Entry"."Zone Code FND");
                        ItemJnlBuffer.SETRANGE("Lot No.", "Item Ledger Entry"."Lot No.");
                        if not ItemJnlBuffer.FINDFIRST() then begin
                            ItemJnlBuffer.INIT();
                            ItemJnlBuffer."Line No." := "Item Ledger Entry"."Entry No.";
                            ItemJnlBuffer."Journal Template Name" := ToTemplateName;
                            ItemJnlBuffer."Journal Batch Name" := ToBatchName;
                            ItemJnlBuffer."Posting Date" := PostingDate;
                            ItemJnlBuffer."Entry Type" := "Item Ledger Entry"."Entry Type".AsInteger();
                            ItemJnlBuffer."Document No." := "Item Ledger Entry"."Document No.";
                            ItemJnlBuffer."Item No." := "Item Ledger Entry"."Item No.";
                            ItemJnlBuffer.Description := "Item Ledger Entry".Description;
                            ItemJnlBuffer."Unit of Measure Code" := "Item Ledger Entry"."Unit of Measure Code";
                            ItemJnlBuffer."Qty. per Unit of Measure" := "Item Ledger Entry"."Qty. per Unit of Measure";
                            ItemJnlBuffer."Variant Code" := "Item Ledger Entry"."Variant Code";
                            ItemJnlBuffer."Location Code" := "Item Ledger Entry"."Location Code";
                            ItemJnlBuffer."Zone Code" := "Item Ledger Entry"."Zone Code FND";
                            //ItemJnlBuffer."Bin Code" := "Item Ledger Entry"."Bin Code";//Bc Upgrade YADAVM09 Drink it field commented
                            ItemJnlBuffer."Lot No." := "Item Ledger Entry"."Lot No.";
                            ItemJnlBuffer."Source Type" := "Item Ledger Entry"."Source Type".AsInteger();
                            ItemJnlBuffer."Source No." := "Item Ledger Entry"."Source No.";
                            ItemJnlBuffer."Source Code" := ItemJournalTemplate."Source Code";
                            ItemJnlBuffer.Quantity := "Item Ledger Entry".Quantity;
                            ItemJnlBuffer."Order Type" := "Item Ledger Entry"."Order Type".AsInteger();
                            ItemJnlBuffer."Order No." := "Item Ledger Entry"."Order No.";
                            ItemJnlBuffer."Order Line No." := "Item Ledger Entry"."Order Line No.";
                            ItemJnlBuffer."Prod. Order Comp. Line No." := "Item Ledger Entry"."Prod. Order Comp. Line No.";
                            ItemJnlBuffer."User ID" := USERID;
                            ItemJnlBuffer.INSERT(false);
                        end else begin
                            ItemJnlBuffer.Quantity += "Item Ledger Entry".Quantity;
                            ItemJnlBuffer.MODIFY(false);
                        end;
                        //HEI.01<<
                    end;

                    trigger OnPreDataItem();
                    begin
                        //HEI.01>>
                        SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                        //HEI.01<<
                    end;
                }

                trigger OnAfterGetRecord();
                var
                    ItemL: Record Item;
                begin
                    //HEI.01>>
                    if GUIALLOWED then
                        Window.UPDATE(1, "No.");
                    ItemL.GET("Source No.");
                    //HEI.01<<
                end;

                trigger OnPreDataItem();
                begin
                    //HEI.01>>
                    if SourceNo <> '' then
                        SETRANGE("Source No.", SourceNo);
                    if (FromDueDate <> 0D) and (ToDueDate <> 0D) then begin
                        if FromDueDate > ToDueDate then
                            ERROR(Text009)
                        else
                            if FromDueDate = ToDueDate then
                                SETRANGE("Due Date", FromDueDate)
                            else
                                SETRANGE("Due Date", FromDueDate, ToDueDate);
                    end else
                        if (FromDueDate <> 0D) and (ToDueDate = 0D) then
                            SETRANGE("Due Date", FromDueDate)
                        else
                            if (FromDueDate = 0D) and (ToDueDate <> 0D) then
                                SETRANGE("Due Date", ToDueDate);
                    //Bc Upgrade YADAVM09 Drink it field commented>>
                    if RoutingVersionCode <> '' then
                        SETRANGE("Routing Vrsn Code 112FDW", RoutingVersionCode);
                    if BOMVersionCode <> '' then
                        SETRANGE("Prod. BOM Vrsn Code 112FDW", BOMVersionCode);
                    //Bc Upgrade YADAVM09 Drink it field commented>>
                    if not ISEMPTY then begin
                        ItemJnlLine.RESET();
                        ItemJnlLine.LOCKTABLE();
                        ItemJnlLine.SETRANGE("Journal Template Name", ToTemplateName);
                        ItemJnlLine.SETRANGE("Journal Batch Name", ToBatchName);
                        if ItemJnlLine.FINDLAST() then
                            NextConsumpJnlLineNo := ItemJnlLine."Line No." + 10000
                        else
                            NextConsumpJnlLineNo := 10000;
                    end;
                    //HEI.01<<
                end;
            }

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                if RunFor <> RunFor::Suggest then
                    CurrReport.BREAK();
                SETRANGE("Posting Date", FromPostingDate, ToPostingDate);
                SETRANGE("Item No.", ItemNo);
                if LocationCode <> '' then
                    SETRANGE("Location Code", LocationCode);
                if ZoneCode <> '' then
                    SETRANGE("Zone Code FND", ZoneCode);
                /* //Bc Upgrade YADAVM09 Drink it field commented>>  
                  if BinCode <> '' then
                      SETRANGE("Bin Code", BinCode);
              */ //Bc Upgrade YADAVM09 Drink it field commented>>  
                if LotNo <> '' then
                    SETRANGE("Lot No.", LotNo);

                if GUIALLOWED then
                    Window.OPEN(
                      Text000 +
                      Text001 +
                      Text002 +
                      Text003);
                //HEI.01<<
            end;
        }
        dataitem("Item Journal Line"; "Item Journal Line")
        {
            DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.") where("Consumption Suggested FND" = CONST(true));

            trigger OnAfterGetRecord();
            var
                LotNoInfoL: Record "Lot No. Information";
            begin
                //HEI.01>>
                ValidatePostingDate("Posting Date");
                VALIDATE(Quantity, ROUND((AvgQuantityToAllocate * "Actual Posted Consumption FND"), 0.01, '>'));
                "Quantity Allocated FND" := Quantity;
                if LotNo = '' then
                    LotNo := "Actual Posted Lot No. FND";
                if LotNo <> '' then begin
                    //Bc Upgrade YADAVM09 Drink it field Commented>>
                    if LotNoInfoL.GET("Item No.", "Variant Code", LotNo) then
                        VALIDATE("Expiration Date", LotNoInfoL."Expiration Date 101FDW")
                    else begin
                        //Bc Upgrade YADAVM09 Drink it field Commented<<
                        LotNoInfoL.INIT();
                        LotNoInfoL."Item No." := "Item No.";
                        LotNoInfoL."Lot No." := LotNo;
                        LotNoInfoL.INSERT(true);
                        //end;//Bc Upgrade YADAVM09 Drink it field code Commented
                    end;
                    MODIFY(false);
                    if "Quantity Allocated FND" <> 0 then begin
                        if LotNo <> '' then
                            CreateReservationEntriesForConsJnl("Item Journal Line", LotNo);
                        "Consumption Allocated FND" := true;
                        MODIFY(true);
                        CountLine += 1;
                    end;
                    //HEI.01<<
                end;
            End;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                CLEAR(TotalActualPostedCons);
                CLEAR(AvgQuantityToAllocate);
                if RunFor <> RunFor::Allocate then
                    CurrReport.BREAK();
                SETRANGE("Journal Template Name", ToTemplateName);
                SETRANGE("Journal Batch Name", ToBatchName);
                CALCSUMS("Actual Posted Consumption FND");
                TotalActualPostedCons := "Actual Posted Consumption FND";
                AvgQuantityToAllocate := QuantityToAllocate / TotalActualPostedCons;

                if GUIALLOWED then
                    Window.OPEN(
                      Text010 +
                      Text001 +
                      Text002 +
                      Text003);
                //HEI.01<<
            end;
        }
    }

    requestpage
    {
        Caption = 'Suggest/Allocate Consumption';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("<Control1900000002>")
                {
                    CaptionML = ENU = 'Filters To Suggest',
                                FRA = 'Options';
                    Visible = SuggestVisible;
                    group("<Control1900000003>")
                    {
                        CaptionML = ENU = 'Item Ledger Entries',
                                    FRA = 'Options';
                        field("From Posting Date"; FromPostingDate)
                        {
                            CaptionML = ENU = 'From Posting Date',
                                        FRA = 'Date comptabilisation';
                            ShowMandatory = true;
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the FromPostingDate field.';

                            trigger OnValidate();
                            begin
                                //HEI.01>>
                                CLEAR(ToPostingDate);
                                CLEAR(PostingDate);
                                //HEI.01<<
                            end;
                        }
                        field("To Posting Date"; ToPostingDate)
                        {
                            CaptionML = ENU = 'To Posting Date',
                                        FRA = 'Date comptabilisation';
                            ShowMandatory = true;
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the ToPostingDate field.';

                            trigger OnValidate();
                            begin
                                //HEI.01>>
                                CLEAR(PostingDate);
                                //HEI.01<<
                            end;
                        }
                        field("Location Code"; LocationCode)
                        {
                            CaptionML = ENU = 'Location Code',
                                        FRA = 'Magasin prélèvement';
                            TableRelation = Location;
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the LocationCode field.';

                            trigger OnValidate();
                            begin
                                //HEI.01>>
                                CLEAR(ZoneCode);
                                CLEAR(BinCode);
                                //HEI.01<<
                            end;
                        }
                        field("Zone Code"; ZoneCode)
                        {
                            Caption = 'Zone Code';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Zone Code field.';

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                ZoneL: Record Zone;
                            begin
                                //HEI.01>>
                                if LocationCode <> '' then
                                    ZoneL.SETRANGE("Location Code", LocationCode);
                                if PAGE.RUNMODAL(0, ZoneL) = ACTION::LookupOK then begin
                                    Text := ZoneL.Code;
                                    exit(true);
                                end;
                                exit(false);
                                //HEI.01<<
                            end;
                        }
                        field("Bin Code"; BinCode)
                        {
                            Caption = 'Bin Code';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Bin Code field.';

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                BinContentL: Record "Bin Content";
                            begin
                                //HEI.01>>
                                if LocationCode <> '' then
                                    BinContentL.SETRANGE("Location Code", LocationCode);
                                if ZoneCode <> '' then
                                    BinContentL.SETRANGE("Zone Code", ZoneCode);
                                if ItemNo <> '' then
                                    BinContentL.SETRANGE("Item No.", ItemNo);
                                if PAGE.RUNMODAL(0, BinContentL) = ACTION::LookupOK then begin
                                    Text := BinContentL."Bin Code";
                                    exit(true);
                                end;
                                exit(false);
                                //HEI.01<<
                            end;
                        }
                        field("Item No."; ItemNo)
                        {
                            Caption = 'Item No.';
                            ShowMandatory = true;
                            TableRelation = Item;
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Item No. field.';

                            trigger OnValidate();
                            begin
                                //HEI.01>>
                                CLEAR(BinCode);
                                CLEAR(LotNo);
                                if GeneralLedgerSetup."Allow Posting To" < TODAY then
                                    PostingDate := GeneralLedgerSetup."Allow Posting To"
                                else
                                    PostingDate := TODAY;
                                //HEI.01<<
                            end;
                        }
                        field("Lot No."; LotNo)
                        {
                            Caption = 'Lot No.';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Lot No. field.';

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                LotNoInfoL: Record "Lot No. Information";
                            begin
                                //HEI.01>>
                                if ItemNo <> '' then
                                    LotNoInfoL.SETRANGE("Item No.", ItemNo);
                                if PAGE.RUNMODAL(0, LotNoInfoL) = ACTION::LookupOK then begin
                                    Text := LotNoInfoL."Lot No.";
                                    exit(true);
                                end;
                                exit(false);
                                //HEI.01<<
                            end;
                        }
                        field("Posting Date"; PostingDate)
                        {
                            Caption = 'Posting Date';
                            ShowMandatory = true;
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Posting Date field.';

                            trigger OnValidate();
                            begin
                                //HEI.01>>
                                ValidatePostingDate(PostingDate);
                                //HEI.01<<
                            end;
                        }
                    }
                    group("<Control1900000004>")
                    {
                        CaptionML = ENU = 'Production Orders',
                                    FRA = 'Options';
                        field("Source No."; SourceNo)
                        {
                            Caption = 'Source No.';
                            TableRelation = Item;
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Source No. field.';
                        }
                        field("From Due Date"; FromDueDate)
                        {
                            Caption = 'From Due Date';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the From Due Date field.';
                        }
                        field("To Due Date"; ToDueDate)
                        {
                            Caption = 'To Due Date';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the To Due Date field.';
                        }
                        field("Routing Version Code"; RoutingVersionCode)
                        {
                            Caption = 'Routing Version Code';
                            TableRelation = "Routing Version"."Version Code";
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Routing Version Code field.';
                        }
                        field("BOM Version Code"; BOMVersionCode)
                        {
                            Caption = 'BOM Version Code';
                            TableRelation = "Production BOM Version"."Version Code";
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the BOM Version Code field.';
                        }
                    }
                }
                group("<Control1900000005>")
                {
                    CaptionML = ENU = 'Filters To Allocate',
                                FRA = 'Options';
                    Visible = AllocateVisible;
                    group("<Control1900000006>")
                    {
                        CaptionML = ENU = 'Consumption Journals',
                                    FRA = 'Options';
                        field("Quantity To Allocate"; QuantityToAllocate)
                        {
                            BlankZero = true;
                            Caption = 'Quantity To Allocate';
                            ShowMandatory = true;
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Quantity To Allocate field.';
                        }
                        field("Lot No. To Allocate"; LotNo)
                        {
                            Caption = 'Lot No. To Allocate';
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Lot No. To Allocate field.';

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                LotNoInfoL: Record "Lot No. Information";
                            begin
                                //HEI.01>>
                                if ItemNo <> '' then
                                    LotNoInfoL.SETRANGE("Item No.", ItemNo);
                                if PAGE.RUNMODAL(0, LotNoInfoL) = ACTION::LookupOK then begin
                                    Text := LotNoInfoL."Lot No.";
                                    exit(true);
                                end;
                                exit(false);
                                //HEI.01<<
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            //HEI.01>>
            CLEAR(QuantityToAllocate);
            CLEAR(LotNo);
            GeneralLedgerSetup.GET();
            //HEI.01<<
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        //HEI.01>>
        ItemJnlBuffer.RESET();
        if ItemJnlBuffer.findset(false) then
            repeat
                CreateConsumpJnlLine(ItemJnlBuffer);
                CountLine += 1;
            until ItemJnlBuffer.NEXT() = 0;

        if GUIALLOWED then begin
            Window.CLOSE();
            case RunFor of
                RunFor::Suggest:
                    begin
                        if CountLine = 0 then
                            MESSAGE(Text011)
                        else
                            MESSAGE(Text012, CountLine);
                    end;
                RunFor::Allocate:
                    begin
                        MESSAGE(Text013, CountLine)
                    end;
            end;
        end;
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        CLEAR(CountLine);
        GeneralLedgerSetup.GET();
        ItemJournalTemplate.GET(ToTemplateName);
        case RunFor of
            RunFor::Suggest:
                begin
                    if FromPostingDate = 0D then
                        ERROR(Text004);
                    if ToPostingDate = 0D then
                        ERROR(Text005);
                    if FromPostingDate > ToPostingDate then
                        ERROR(Text006);
                    if ItemNo = '' then
                        ERROR(Text007);
                    ValidatePostingDate(PostingDate);
                    ItemJnlBuffer.DELETEALL(false);
                end;
            RunFor::Allocate:
                begin
                    if QuantityToAllocate = 0 then
                        ERROR(Text008);
                end;
        end;
        //HEI.01<<
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        ItemJnlBuffer: Record "Item Jnl. Buffer FND" temporary;
        ItemJnlLine: Record "Item Journal Line";
        ItemJournalTemplate: Record "Item Journal Template";

        AllocateVisible: Boolean;

        SuggestVisible: Boolean;
        LocationCode: Code[10];
        ToBatchName: Code[10];
        ToTemplateName: Code[10];
        ZoneCode: Code[10];
        BinCode: Code[20];
        BOMVersionCode: Code[20];
        ItemNo: Code[20];
        LotNo: Code[20];
        RoutingVersionCode: Code[20];
        SourceNo: Code[20];
        FromDueDate: Date;
        FromPostingDate: Date;
        PostingDate: Date;
        ToDueDate: Date;
        ToPostingDate: Date;
        AvgQuantityToAllocate: Decimal;
        QuantityToAllocate: Decimal;
        TotalActualPostedCons: Decimal;
        Window: Dialog;
        CountLine: Integer;
        NextConsumpJnlLineNo: Integer;
        Text004: Label 'Please select From Posting Date.';
        Text005: Label 'Please select To Posting Date.';
        Text006: Label 'To Posting Date must be greater than From Posting Date.';
        Text007: Label 'Please select Item No.';
        Text008: Label 'Please enter Quantity To Allocate.';
        Text009: Label 'To Due Date must be greater than From Due Date.';
        Text011: Label 'There is nothing to suggest on Consumption Line.';
        Text012: Label '%1 Consumption Line suggested successfully.';
        Text013: Label '%1 Consumption Line allocated successfully.';
        Text015: Label '"There is nothing to create for Consumption Entry in Reservation. "';
        Text016: Label 'Posting Date cannot be left blank.';
        Text017: Label 'Posting Date %1 is not within your range of allowed posting dates in %2.';
        Text018: Label 'Posting Date %1 cannot be future date.';
        RunFor: Option Suggest,Allocate;
        Text000: TextConst ENU = 'Suggesting Consumption...\\', FRA = 'Calcul de la consommation...\\';
        Text001: TextConst ENU = 'Prod. Order No.   #1##########\', FRA = 'N° O.F.           #1##########\';
        Text002: TextConst ENU = 'Item No.          #2##########\', FRA = 'N° article        #2##########\';
        Text003: TextConst ENU = 'Quantity          #3##########', FRA = 'Quantité          #3##########';
        Text010: TextConst ENU = 'Allocating Consumption...\\', FRA = 'Calcul de la consommation...\\';

    procedure InitializeRequest(TemplateName: Code[10]; BatchName: Code[10]; RunProcess: Option Suggest,Allocate);
    begin
        //HEI.01>>
        ToTemplateName := TemplateName;
        ToBatchName := BatchName;
        RunFor := RunProcess;
        case RunProcess of
            RunProcess::Suggest:
                SuggestVisible := true;
            RunProcess::Allocate:
                AllocateVisible := true;
        end;
        //HEI.01<<
    end;

    local procedure CreateConsumpJnlLine(var GetItemJnlBuffer: Record "Item Jnl. Buffer FND");
    var
        BinL: Record Bin;
        ItemL: Record Item;
        MfgSetupL: Record "Manufacturing Setup";
    begin
        //HEI.01>>
        if GUIALLOWED then
            Window.UPDATE(3, GetItemJnlBuffer.Quantity);
        ItemJnlLine.INIT();
        ItemJnlLine."Journal Template Name" := GetItemJnlBuffer."Journal Template Name";
        ItemJnlLine."Journal Batch Name" := GetItemJnlBuffer."Journal Batch Name";
        ItemJnlLine."Line No." := NextConsumpJnlLineNo;
        ItemJnlLine.VALIDATE("Posting Date", GetItemJnlBuffer."Posting Date");
        ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Consumption);
        ItemJnlLine.VALIDATE("Order Type", ItemJnlLine."Order Type"::Production);
        ItemJnlLine."Order No." := GetItemJnlBuffer."Order No.";
        ItemJnlLine.VALIDATE("Order Line No.", GetItemJnlBuffer."Order Line No.");
        ItemJnlLine.VALIDATE("Prod. Order Comp. Line No.", GetItemJnlBuffer."Prod. Order Comp. Line No.");
        MfgSetupL.GET();
        if MfgSetupL."Doc. No. Is Prod. Order No." then
            ItemJnlLine."Document No." := ItemJnlLine."Order No.";
        ItemJnlLine.VALIDATE("Source Code", GetItemJnlBuffer."Source Code");
        ItemJnlLine.VALIDATE("Source Type", ItemJnlLine."Source Type"::Item);
        ItemJnlLine.VALIDATE("Source No.", GetItemJnlBuffer."Source No.");
        ItemJnlLine.VALIDATE("Item No.", GetItemJnlBuffer."Item No.");
        ItemJnlLine."Variant Code" := GetItemJnlBuffer."Variant Code";
        ItemJnlLine.Description := GetItemJnlBuffer.Description;
        ItemJnlLine.VALIDATE("Unit of Measure Code", GetItemJnlBuffer."Unit of Measure Code");
        ItemJnlLine.VALIDATE(Quantity, 0);
        ItemJnlLine.VALIDATE("Actual Posted Consumption FND", GetItemJnlBuffer.Quantity);
        ItemJnlLine."Actual Posted Consumption FND" := (ItemJnlLine."Actual Posted Consumption FND" * -1);
        ItemJnlLine.VALIDATE("Location Code", GetItemJnlBuffer."Location Code");
        ItemJnlLine.VALIDATE("Zone Code FND", GetItemJnlBuffer."Zone Code");
        if GetItemJnlBuffer."Bin Code" <> '' then begin
            if ItemJnlLine."Zone Code FND" = '' then begin
                BinL.GET(ItemJnlLine."Location Code", GetItemJnlBuffer."Bin Code");
                ItemJnlLine.VALIDATE("Zone Code FND", BinL."Zone Code");
            end;
            ItemJnlLine.VALIDATE("Bin Code", GetItemJnlBuffer."Bin Code");
        end;
        ItemJnlLine."Actual Posted Lot No. FND" := GetItemJnlBuffer."Lot No.";
        ItemJnlLine."Consumption Suggested FND" := true;
        ItemJnlLine.INSERT(false);

        NextConsumpJnlLineNo := NextConsumpJnlLineNo + 10000;
        //HEI.01<<
    end;

    procedure CreateReservationEntriesForConsJnl(var ItemJournalLine: Record "Item Journal Line"; var LotNo: Code[20]);
    var
        ItemJournalLineL: Record "Item Journal Line";
        CreateReservationEntryL: Record "Reservation Entry";
        ReservEntryNoL: Integer;
    begin
        //HEI.01>>
        if ItemJournalLineL.GET(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name", ItemJournalLine."Line No.") then begin
            CreateReservationEntryL.LOCKTABLE();
            if CreateReservationEntryL.FINDLAST() then
                ReservEntryNoL := CreateReservationEntryL."Entry No." + 1
            else
                ReservEntryNoL := 1;
            CreateReservationEntryL.INIT();
            CreateReservationEntryL."Entry No." := ReservEntryNoL;
            CreateReservationEntryL.Positive := false;
            CreateReservationEntryL.VALIDATE("Item No.", ItemJournalLineL."Item No.");
            CreateReservationEntryL.VALIDATE("Location Code", ItemJournalLineL."Location Code");
            CreateReservationEntryL.Description := ItemJournalLineL.Description;
            CreateReservationEntryL."Zone Code FND" := ItemJournalLineL."Zone Code FND";
            // CreateReservationEntryL."Bin Code" := ItemJournalLineL."Bin Code";//Bc Upgrade YADAVM09 Drink it field commented
            CreateReservationEntryL.VALIDATE("Lot No.", LotNo);
            CreateReservationEntryL."Expiration Date" := ItemJournalLineL."Expiration Date";
            CreateReservationEntryL."Qty. per Unit of Measure" := ItemJournalLineL."Qty. per Unit of Measure";
            CreateReservationEntryL.VALIDATE("Quantity (Base)", -ItemJournalLineL."Quantity (Base)");
            CreateReservationEntryL."Reservation Status" := CreateReservationEntryL."Reservation Status"::Prospect;
            CreateReservationEntryL."Source Type" := DATABASE::"Item Journal Line";
            CreateReservationEntryL."Source Subtype" := ItemJournalLineL."Entry Type".AsInteger();
            CreateReservationEntryL."Source ID" := ItemJournalLineL."Journal Template Name";
            CreateReservationEntryL."Source Batch Name" := ItemJournalLineL."Journal Batch Name";
            CreateReservationEntryL."Source Prod. Order Line" := 0;
            CreateReservationEntryL."Source Ref. No." := ItemJournalLineL."Line No.";
            CreateReservationEntryL."Item Tracking" := CreateReservationEntryL."Item Tracking"::"Lot No.";
            CreateReservationEntryL."Shipment Date" := ItemJournalLineL."Posting Date";
            CreateReservationEntryL."Reference No. FND" := ItemJournalLineL."Order No.";
            CreateReservationEntryL."Created By" := USERID;
            CreateReservationEntryL."Creation Date" := PostingDate;
            CreateReservationEntryL.INSERT(true);
        end else
            ERROR(Text015);
        //HEI.01<<
    end;

    local procedure ValidatePostingDate(var PostingDt: Date);
    begin
        //HEI.01>>
        if PostingDt = 0D then
            ERROR(Text016);
        if (PostingDt < GeneralLedgerSetup."Allow Posting From") or
          (PostingDt > GeneralLedgerSetup."Allow Posting To") then
            ERROR(Text017, PostingDt, GeneralLedgerSetup.TABLECAPTION);
        if PostingDt > TODAY then
            ERROR(Text018, PostingDt);
        if GeneralLedgerSetup."Allow Posting To" < TODAY then
            PostingDt := GeneralLedgerSetup."Allow Posting To";
        //HEI.01<<
    end;
}

