report 58000 "Process Outbound RPO for LP"
{
    // Heilite Navision Old Id - 50545
    // version HEI.01

    // HEI.01 CHG2129985 SAHAL01      14.04.2022
    //   # Created New Report: 50545 - Process Outbound RPO for LP
    //   # Added Code to create outbound data
    //********************************************************************************
    //BC UPGRADE PATHAA02 17.11.25-Done
    //01-Commented Line of code- //ProdOrderOutboundtoLPL1.EAN := "Cross-Reference No."; //BC UPGRADE PATHAA02- DIT field [T5406(Prod Order Line)--->F2029610("Cross Ref No.")]
    //02- Code commented on Production Order-OnPredataitem --> Due to DIT field (F2036301-"Item Category Code")
    //    if WMSInterfaceSetup."Item Category" <> '' then SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category"); 

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "WMS Items Included/Excluded" to "WMS Items Included/ExcludedFND"
    // BC UPGRADE PATELS08 <<


    Caption = 'Process Outbound RPO for LP';
    ProcessingOnly = true;
    UseRequestPage = false;
    ApplicationArea = All;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = WHERE(Status = CONST(Released), "Source Type" = CONST(Item), "Source No." = FILTER(<> ''), "Parked for LogoPak INT" = CONST(false));
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                trigger OnAfterGetRecord();
                var
                    ProdOrderOutboundtoLPL: Record "Prod. Order Outbound to LP INT";
                    ItemL: Record Item;
                    ItemIncludeL: Boolean;
                    ItemExcludeL: Boolean;
                    ProdOrderOutboundtoLPL1: Record "Prod. Order Outbound to LP INT";
                    EntryNoL: Integer;
                    ItemUnitofMeasureL: Record "Item Unit of Measure";
                    ItemUnitofMeasureL1: Record "Item Unit of Measure";
                    //ProductionSetupL : Record "Production Setup"; //BC UPGRADE PATHAA02 DIT Table
                    ErrorTextL: Text[250];
                begin
                    //HEI.01>>
                    ItemL.GET("Item No.");
                    if ItemsIncludedExcluded.GET("Item No.") then begin
                        if ItemsIncludedExcluded.Included then
                            ItemIncludeL := true;
                        if ItemsIncludedExcluded.Excluded then
                            ItemExcludeL := true;
                    end;

                    if ItemIncludeL or (not ItemExcludeL) then begin
                        if ProdOrderOutboundtoLPL1.FINDLAST() then
                            EntryNoL := ProdOrderOutboundtoLPL1."Entry No.";

                        ProdOrderOutboundtoLPL1.INIT();
                        ProdOrderOutboundtoLPL1."Entry No." := EntryNoL + 1;
                        ProdOrderOutboundtoLPL1."Prod. Order Interface" := WMSInterfaceSetup."Prod. Order Interface";
                        ProdOrderOutboundtoLPL1."Interface Status" := ProdOrderOutboundtoLPL1."Interface Status"::Pending;
                        ProdOrderOutboundtoLPL1."Sync. Date-Time" := CURRENTDATETIME;
                        ProdOrderOutboundtoLPL1."Archive Date-Time" := CURRENTDATETIME;
                        ProdOrderOutboundtoLPL1."Prod. Order Status" := Status.AsInteger();
                        ProdOrderOutboundtoLPL1."Prod. Order No." := "Prod. Order No.";
                        ProdOrderOutboundtoLPL1."Line No." := "Line No.";
                        ProdOrderOutboundtoLPL1."Location Code" := "Location Code";
                        ProdOrderOutboundtoLPL1."Item No." := "Item No.";
                        ProdOrderOutboundtoLPL1.Description := Description;
                        ProdOrderOutboundtoLPL1."Description 2" := "Description 2";
                        ProdOrderOutboundtoLPL1."Item Category Code" := ItemL."Item Category Code";
                        ProdOrderOutboundtoLPL1."Planned Quantity" := Quantity;
                        if ItemUnitofMeasureL.GET("Item No.", "Unit of Measure Code") then begin
                            if ItemUnitofMeasureL1.GET("Item No.", 'PAL') then begin
                                ProdOrderOutboundtoLPL1."Quantity (Full Pallet)" :=
                                  ItemUnitofMeasureL1."Qty. per Unit of Measure" / ItemUnitofMeasureL."Qty. per Unit of Measure";
                                ProdOrderOutboundtoLPL1."Gross Weight of Pallet in KG" := ItemUnitofMeasureL1.Weight;
                            end;
                        end;
                        //ProdOrderOutboundtoLPL1.EAN := "Cross-Reference No."; //BC UPGRADE PATHAA02- DIT field [T5406(Prod Order Line)--->F2029610("Cross Ref No.")]
                        ProdOrderOutboundtoLPL1."Ccc Code" := "Production Order"."Shortcut Dimension 2 Code";
                        ProdOrderOutboundtoLPL1."Shelf Life" := FORMAT(CALCDATE(ItemL."Expiration Calculation", "Production Order"."Starting Date"), 0, '<Year4><Month,2><Day,2>');
                        if ("Location Code" = '') or (Description = '') or (Quantity = 0) or ("Unit of Measure Code" = '') or
                          (ProdOrderOutboundtoLPL1."Quantity (Full Pallet)" = 0) or (ProdOrderOutboundtoLPL1."Ccc Code" = '') or
                            (ProdOrderOutboundtoLPL1."Gross Weight of Pallet in KG" = 0) then
                            ErrorTextL := STRSUBSTNO(Text001, "Prod. Order No.");
                        if (GETLASTERRORTEXT <> '') and (ErrorTextL <> '') then
                            ProdOrderOutboundtoLPL1."Error Message" := DELSTR(GETLASTERRORTEXT + ' ' + ErrorTextL, 250)
                        else if (GETLASTERRORTEXT <> '') then
                            ProdOrderOutboundtoLPL1."Error Message" := DELSTR(GETLASTERRORTEXT, 250)
                        else if (ErrorTextL <> '') then
                            ProdOrderOutboundtoLPL1."Error Message" := DELSTR(ErrorTextL, 250)
                        else
                            ProdOrderOutboundtoLPL1."Ready for LogoPak" := true;
                        ProdOrderOutboundtoLPL1.INSERT();
                    end;
                    //HEI.01<<
                end;

                trigger OnPreDataItem();
                var
                    ProdOrderOutboundtoLPL: Record "Prod. Order Outbound to LP INT";
                begin
                    //HEI.01>>
                    SETRANGE("Item No.", "Production Order"."Source No.");
                    ProdOrderOutboundtoLPL.SETCURRENTKEY("Prod. Order Status", "Prod. Order No.");
                    ProdOrderOutboundtoLPL.SETRANGE("Prod. Order Status", Status::Released);
                    ProdOrderOutboundtoLPL.SETRANGE("Prod. Order No.", "Production Order"."No.");
                    if not ProdOrderOutboundtoLPL.ISEMPTY then
                        CurrReport.BREAK();
                    //HEI.01<<
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //HEI.01>>
                TESTFIELD(Status, Status::Released);
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                if ProdOrderNo <> '' then
                    SETRANGE("No.", ProdOrderNo);
                //BC UPGRADE PATHAA02 DIT Field condition>>
                // if WMSInterfaceSetup."Item Category" <> '' then
                //     SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                //BC UPGRADE PATHAA02 DIT Field condition<<
                //HEI.01<<
            end;
        }
        dataitem("Prod. Order Outbound to LP INT"; "Prod. Order Outbound to LP INT")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Prod. Order Status" = CONST(Released), "Ready for LogoPak" = CONST(true));

            trigger OnAfterGetRecord();
            var
                ProductionOrderL: Record "Production Order";
                InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
                InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
                HeaderEntryNoL: Integer;
                EntryNoL: Integer;
                ItemL: Record Item;
                InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
                ParkedErrorL: Boolean;
            begin
                //HEI.01>>
                InterfaceEntryHeaderVIPL.INIT();
                InterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderVIPL."Interface Code" := WMSInterfaceSetup."Prod. Order Interface";
                InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
                InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
                InterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Production Order";
                InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"7";
                InterfaceEntryHeaderVIPL."Source Status" := InterfaceEntryHeaderVIPL."Source Status"::Released;
                InterfaceEntryHeaderVIPL."Source No." := "Prod. Order No.";
                InterfaceEntryHeaderVIPL."Location Code" := "Location Code";
                InterfaceEntryHeaderVIPL.INSERT(true);
                HeaderEntryNoL := InterfaceEntryHeaderVIPL."Entry No.";

                InterfaceEntryLineVIPL.INIT();
                InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNoL;
                EntryNoL := "Line No." + 1;
                InterfaceEntryLineVIPL."Entry No." := EntryNoL;
                InterfaceEntryLineVIPL."Entry Type" := InterfaceEntryLineVIPL."Entry Type"::" ";
                InterfaceEntryLineVIPL."Item Code" := "Prod. Order No.";
                InterfaceEntryLineVIPL."Source Line No." := "Line No.";
                InterfaceEntryLineVIPL.Type := InterfaceEntryLineVIPL.Type::Item;
                InterfaceEntryLineVIPL."No." := "Item No.";
                InterfaceEntryLineVIPL.Description := Description;
                InterfaceEntryLineVIPL."Description 2" := "Description 2";
                InterfaceEntryLineVIPL."Location Code" := "Location Code";
                InterfaceEntryLineVIPL."Planned Quantity" := "Planned Quantity";
                InterfaceEntryLineVIPL."Quantity (Full Pallet)" := "Quantity (Full Pallet)";
                InterfaceEntryLineVIPL.EAN := EAN;
                InterfaceEntryLineVIPL."Ccc Code" := "Ccc Code";
                InterfaceEntryLineVIPL."Gross Weight of Pallet in KG" := "Gross Weight of Pallet in KG";
                InterfaceEntryLineVIPL."Shelf Life" := "Shelf Life";
                InterfaceEntryLineVIPL.INSERT(true);

                InterfaceEntryHeaderVIPL.RESET();
                if InterfaceEntryHeaderVIPL.GET(HeaderEntryNoL) then begin
                    if InterfaceEntryHeaderVIPL.Status = InterfaceEntryHeaderVIPL.Status::Error then
                        ParkedErrorL := true;
                end else
                    if InterfaceLogHeaderVIPL.GET(HeaderEntryNoL) then begin
                        if InterfaceLogHeaderVIPL.Status = InterfaceLogHeaderVIPL.Status::Error then
                            ParkedErrorL := true;
                    end;

                ProductionOrderL.GET(ProductionOrderL.Status::Released, "Prod. Order No.");
                ProductionOrderL."Prod. Order Interface INT" := WMSInterfaceSetup."Prod. Order Interface";
                if not ParkedErrorL then
                    ProductionOrderL."Parked for LogoPak INT" := true;
                ProductionOrderL.MODIFY(true);
                DELETE();
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            begin
                //HEI.01>>
                if ProdOrderNo <> '' then
                    SETRANGE("Prod. Order No.", ProdOrderNo);
                //HEI.01<<
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        //HEI.01>>
        CLEARLASTERROR();
        CLEAR(ProdOrderNo);
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        CompanyInformation.GET();
        if WMSInterfaceSetup.GET() then;
        if not WMSInterfaceSetup."WMS Integration" then
            exit;
        if not WMSInterfaceSetup."Activate LogoPak Interface" then
            exit;
        WMSInterfaceSetup.TESTFIELD("Prod. Order Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Prod. Order Interface");
        if not InterfaceSetup.Enabled then
            ERROR(Text000, InterfaceSetup.Code);
        //HEI.01<<
    end;

    var
        CompanyInformation: Record "Company Information";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        ProdOrderNo: Code[20];
        Text000: Label 'Interface %1 is not enabled.';
        Text001: Label '"Mandatory values should not be blank. Please update the correct values for this Prod. Order %1. "';
        ItemsIncludedExcluded: Record "WMS Items Included/ExcludedFND";

    procedure GetProdOrder(var ProductionOrderNo: Code[20]);
    begin
        //HEI.01>>
        ProdOrderNo := ProductionOrderNo;
        //HEI.01<<
    end;
}

