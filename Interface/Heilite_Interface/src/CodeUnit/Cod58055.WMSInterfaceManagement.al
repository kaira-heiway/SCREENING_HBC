codeunit 58055 "WMS Interface Management"
{
    //BC Upgrade GUNREM01 Old ID-50109
    // version HEI.36

    // HEI.04 CHG2043663 FDD-HT604 IBM.COSTES02 20.01.2020 # WMS integration Heilite BASE and Reflex
    //   # New functions added for stock adjustment and warehouse movement interface
    // HEI.06 CHG2043663 FDD-HT604 IBM.GAVANM01 18.01.20120 # WMS integration Heilite BASE and Reflex
    //   # New functions added for Transfer Receipt - 'ProcessTransferWhsReceipt', 'PostTOReceipt', 'CreateAndPostTransferWhsReceipt'
    // HEI.07 CHG2043663 FDD-HT604 IBM.GAVANM01 19.05.20120 # WMS integration Heilite BASE and Reflex
    //   # code changed due to change of the Data Exch Def. for shipments
    // HEI.08 CHG2071252 Defect #5607 IBM.NASTAA02 13.07.2020 # Not Possible to Correct expired inventory in WMS interface
    //   # Code changed on function "CreateReservationEntriesForItemJournal" to assign Item Tracking for Negative Adjustments when the Lot has expired invenotry
    // HEI.09 CHG2071252 IBM.GAVANM01 20.07.2020 Defect #5601
    //   # Change the code that instead of looking for one value in "Reflex 3rd OUM", in WMS setup, it would look for more values
    // HEI.10 CHG2076906 IBM.GAVANM01 26.08.2020 INC3025662 # WMS interface Grams are not converted to KG
    //   # code changes, if Unit of Weight is Grams, then we need to divide by 1000 (we should send only KG values in Reflex)
    // HEI.11 CHG2078283 - INC3044366 IBM.GAVANM01 04.09.2020 # WMS integration
    //   # truncate Ship-to Name and Ship-to Address
    // HEI.12 CHG2077574 IBM GAVANM01 04.09.2020 # WMS Integration
    //   # include/exclude items filter added for Items, SO and TO interfaces
    // HEI.13 CHG2078812 IBM GAVANM01 15.09.2020 # WMS Integration
    //   # error management
    // HEI.14 CHG2079638 IBM GAVANM01 15.09.2020 # WMS Integration - Sales Order Deletion: Return Order should not be present
    //   # code changes
    // HEI.15 CHG2079783 IBM GAVANM01 21.09.2020 # WMS Integration - SH Interfaces Issue when missing product
    //   # when SH, lines with 0 quantity will be deleted
    // HEI.16 CHG2079726 IBM GAVANM01 21.09.2020 # WMS Integration - Zone Warehouse Movement Stuck In Transit
    //   # in WM interface, for Place entries we need to filter for Linked to Line
    // HEI.17 CHG2081873 HB1731 IBM GAVANM01 29.10.2020 #WMS interface error messages improvement
    //   # code changes
    // HEI.18 CHG2112000 IBM GHOSHS05  27.05.2021  Modified code in CreateSalesOrderLineEntry() to filter Sales Line correctly
    // HEI.19 CHG2133338 IBM PATHAA02  03.11.2021 Item needs to be validated before inserting warehouse activity line(to fix WMS-WM inbound interface item not found error)
    // HEI.20 CHG2128692 HB2155 IBM GAVANM01 10.11.2021 # WMS Interface Sales Return
    //   # new functions added: CreatesSalesReturnOrderEntry(),CreateSalesReturnLineEntry()
    //   # code changes in function OnAfterReleaseSalesOrder()
    // HEI.21 FDD-HB2155 CHG2128694 IBM NANDIS01 11.11.2021 WMS PO
    //   # New functions - WMSCreatePORequest, CheckIfPurchaseLineExists, CreatePurchaseOrderLineEntry, ConvertToReflexPcsPurchase,
    //                     OnBeforeDeletePurchaseOrder, CreatePurchaseOrderDeleteEntry, WMSProcessPurchaseWhsReceipt,
    //                     CreateAndPostPurchaseWhsReceipt, PostPOReceipt, ConvertToPurchaseUOM, OnAfterSetInterfaceError
    //   # Code modified on function - CreateAndPostPurchaseWhsReceipt; In UAT warehouse receipt failed to get posted - fixed with reservation of expiration date
    //   # Qty(Base) should be considered from the one rcvd from Reflex
    // HEI.22 CHG2129985 SAHAL01      12.04.2022
    //   # Created New Functions - OnAfterReleasedProductionOrder
    //                           - ReleasedProductionOrderOutput
    //                           - OnAfterInterfaceErrorUpdate
    // HEI.23 CHG2138969 INC3842082 IBM GAVANM01 13.12.2021 # Wrong date format in WMS messages
    //   # format of all the date fields for export interfaces (WMS-PO,WMS-SO,WMS-SR,WMS-TO,WMS-TO-PO) will be hardcoded.
    // HEI.24 CHG2140527 IBM PATHAA02 24.12.21
    //   # corrective change Bug Fix
    //   # For WMS-SA Interface having multiple lines, system is trying to validate 1st line UOM with 2nd line item and throwing error
    //   # Code added on function - ProcessStockAdjustmentRequest
    // HEI.25 HB2156 CHG2107450 IBM GAVANM01 27.01.2022 # WMS Phase 2 - Transportation cost
    //   # change in Properties: 'TableNo' = Warehouse Shipment Line
    //   # new functions: ProcessWhsShpmntRequestTC, CheckLotTC, CreateReservationEntriesTC
    //   # ProcessWhsShpmntRequest function becomes obsolete
    // HEI.26 HB2155 CHG2128694 IBM GAVANM01 02.02.2022 WMS - SRO Warehouse Receipt creation
    //   # new functions: ProcessSROWhsReceipt,CreateAndPostSROWhsReceipt
    // HEI.27 FDD-HB2155 CHG2128694 IBM NANDIS01 07.02.2022 WMS PO
    //   # Code fixes for Purch Rcpt process while diff Lot come for same item, in function - CreateAndPostPurchaseWhsReceipt
    //   # If few lines in warehs rcpt are having 0 qty to rcv then those should not get posted
    // HEI.28 HB2156 CHG2107450 IBM GAVANM01 08.02.2022 # WMS Phase 2 - Transportation cost
    //   # bug fixes after FAT
    //   # new function for Transfer Shipment (includes the Transportation Cost requests)
    //   # bug fix when multiple lots for the same line
    // HEI.29 HB2156 CHG2107450 IBM GAVANM01 09.03.2022 # WMS Phase 2 - Transportation cost
    //   # bug fixes during UAT
    // HEI.30 HB2156 CHG2107450 IBM GAVANM01 14.03.2022 # WMS Phase 2 - Transportation cost
    //   # change the error message related to Lot No unavailable in NAV
    // HEI.31 HB2156 CHG2107450 IBM BHANDS01 08.04.2022 # WMS Phase 2 - Transportation cost
    //   # bug fix during UAT
    // HEI.32 HB2156 CHG2107450 IBM BHANDS01 11.04.2022 # WMS Phase 2 - Transportation cost
    //   # bug fix during FAT
    // HEI.33 INC4071333 Corrective Change CHG2155733 IBM BHANDS01 22.04.2022 # WMS Phase 2 - Transportation cost
    //   # bug fix
    // HEI.34 INC4073237 and INC4075485 Corrective Change CHG2156103 IBM BHANDS01 27.04.2022 # WMS Phase 2 - Transportation cost
    //   # logic for Posting Date changed and also removed External Doc No mapping from Load Code in the interface file.
    // HEI.35 HB3247 CHG2184595 IBM COSTES04 31.03.2023 Prioritization of digital Sales Orders
    //   # Add Reservation Flag
    // HEI.36 HB3247 CHG2184595 IBM COSTES04 03.04.2023 Prioritization of digital Sales Orders
    //   # Populate closed on the line level

    //BC Upgrade GUNREM01 >>
    //# Commented DIT fields, Functions
    //# Changed Reservation entry parameter
    //# Replaced Item Cross Reference Table and related fields
    //# Blocked SMTP Mail Functionality
    //# OnAfterReleasedProdOrder this event subcription code already coverd in codeunit 58016 InterfaceDtWCode 

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "WMS Source System Identifier" to "WMS Source Sys ID FND". 
    // BC UPGRADE PATELS08 << 

    //BC Upgrade GUNREM01 <<

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "WMS Items Included/Excluded" to "WMS Items Included/ExcludedFND"
    // BC UPGRADE PATELS08 <<

    Permissions = TableData "Sales Invoice Header" = rm,
                  TableData "Sales Cr.Memo Header" = rm;
    TableNo = "Warehouse Shipment Line";

    trigger OnRun();
    var
        WhseShipHeader: Record "Warehouse Shipment Header";
        TransferLine: Record "Transfer Line";
    begin
        /*//HEI.28<<
        //HEI.25<<
        IF WMSInterfaceSetup.GET AND WhseShipHeader.GET(Rec."No.") THEN
          CreateReservationEntriesTC(Rec."Cubage to Ship",Rec."Source No.",'',Rec."Source Line No.",37,Rec."Source Document",
            Rec."Item No.",Rec."Variant Code",WhseShipHeader."Location Code",Rec."Unit of Measure Code",
            Rec.Description,Rec."Shipment Date",Rec."External Document No.", ConvertToBaseUOM(Rec."Item No.",WMSInterfaceSetup."Reflex 1st OUM",Rec."Cubage to Ship"));
        //HEI.25>>
        *///HEI.28<<
          //HEI.28<<
          //BC Upgrade GUNREM01 -Dependency with DIT Fields >>
          // if WMSInterfaceSetup.GET and WhseShipHeader.GET(Rec."No.") then
          //     case Rec."Source Type" of
          //         37:
          //             // CreateReservationEntriesTC(Rec."Cubage to Ship", Rec."Source No.", '', Rec."Source Line No.", 37, Rec."Source Document",
          //             //   Rec."Item No.", Rec."Variant Code", WhseShipHeader."Location Code", Rec."Unit of Measure Code",
          //             //   Rec.Description, Rec."Shipment Date", Rec."External Document No.", ConvertToBaseUOM(Rec."Item No.", WMSInterfaceSetup."Reflex 1st OUM", Rec."Cubage to Ship"));
          //             CreateReservationEntriesTC(Rec."Source No.", '', Rec."Source Line No.", 37, Rec."Source Document",
          //                   Rec."Item No.", Rec."Variant Code", WhseShipHeader."Location Code", Rec."Unit of Measure Code",
          //                   Rec.Description, Rec."Shipment Date", ConvertToBaseUOM(Rec."Item No.", WMSInterfaceSetup."Reflex 1st OUM", Rec."Cubage to Ship"));
          //         5741:
          //             begin
          //                 TransferLine.GET(Rec."Source No.", Rec."Source Line No.");
          //                 CreateTOSHReservationEntriesTC(Rec."Cubage to Ship", Rec."Source No.", '', Rec."Source Line No.", 5741, 0,
          //                   Rec."Item No.", Rec."Variant Code", Rec."Location Code", Rec."Unit of Measure Code",
          //                   Rec.Description, Rec."Shipment Date", Rec."External Document No.",
          //                   ConvertToBaseUOM(Rec."Item No.", WMSInterfaceSetup."Reflex 1st OUM", Rec."Cubage to Ship"), TransferLine."Transfer-from Bin Code", true);
          //                 CreateTOSHReservationEntriesTC(Rec."Cubage to Ship", Rec."Source No.", '', Rec."Source Line No.", 5741, 1,
          //                   Rec."Item No.", Rec."Variant Code", Rec."Destination No.", Rec."Unit of Measure Code",
          //                   Rec.Description, Rec."Shipment Date", Rec."External Document No.",
          //                   ConvertToBaseUOM(Rec."Item No.", WMSInterfaceSetup."Reflex 1st OUM", Rec."Cubage to Ship"), TransferLine."Transfer-To Bin Code", false);
          //             end;
          //     end;
          //HEI.28<<
          //BC Upgrade GUNREM01 -Dependency with DIT Fields <<
          //HEI.28>>
          //BC Upgrade KUMARR78 >>
        if WMSInterfaceSetup.Get() and WhseShipHeader.Get(Rec."No.") then
            case Rec."Source Type" of
                37:
                    CreateReservationEntriesTC(Rec."Cubag To Ship FND", Rec."Source No.", '', Rec."Source Line No.", 37, Rec."Source Document".AsInteger(),
        Rec."Item No.", Rec."Variant Code", WhseShipHeader."Location Code", Rec."Unit of Measure Code",
        Rec.Description, Rec."Shipment Date", Rec."External Document No. FND", ConvertToBaseUOM(Rec."Item No.", WMSInterfaceSetup."Reflex 1st OUM", 1));

                5741:
                    begin
                        TransferLine.Get(Rec."Source No.", Rec."Source Line No.");
                        CreateTOSHReservationEntriesTC(Rec."Cubag To Ship FND", Rec."Source No.", '', Rec."Source Line No.", 5741, 0,
                          Rec."Item No.", Rec."Variant Code", Rec."Location Code", Rec."Unit of Measure Code",
                          Rec.Description, Rec."Shipment Date", Rec."External Document No. FND",
                          ConvertToBaseUOM(Rec."Item No.", WMSInterfaceSetup."Reflex 1st OUM", Rec."Cubag To Ship FND"), TransferLine."Transfer-from Bin Code", true);
                        CreateTOSHReservationEntriesTC(Rec."Cubag To Ship FND", Rec."Source No.", '', Rec."Source Line No.", 5741, 1,
                          Rec."Item No.", Rec."Variant Code", Rec."Destination No.", Rec."Unit of Measure Code",
                          Rec.Description, Rec."Shipment Date", Rec."External Document No. FND",
                          ConvertToBaseUOM(Rec."Item No.", WMSInterfaceSetup."Reflex 1st OUM", Rec."Cubag To Ship FND"), TransferLine."Transfer-To Bin Code", false);
                    end;
            end;
        //BC Upgrade KUMARR78 <<

    end;

    var
        enumvalue : Enum "Reservation Status";
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        WMSInterfaceSetup: Record "WMS Interface Setup INT";
        InterfaceFrameworkMgtVIP: Codeunit "Interface Framework Mgt. VIP";
        GLSetupRead: Boolean;
        SalesSetupRead: Boolean;
        GeneralOpCoSetupRead: Boolean;
        GeneralInterfaceSetupRead: Boolean;
        WMSInterfaceSetupRead: Boolean;
        ReceivedInHeiLiteTxt: Label 'Received in HeiLite';
        SentToMiddlewareTxt: Label 'Sent to middleware';
        NotSentToMiddlewareTxt: Label 'Not sent to middleware.\ Error message: %1.';
        IncorrectFormatErr: Label '%1 has an incorrect format. Current value is %2.';
        Customer: Record Customer;
        CompanyInformation: Record "Company Information";
        CompanyInformationRead: Boolean;
        InterfaceSetup: Record "Interface Setup INT";
        ReflexUOMErr: Label 'The item %1 does not have UOM defined as %2';
        Text50000: Label 'The Lot No %1 is not available in NAV';
        ItemUOMinReflex3rd: Code[10];
        ItemsIncludeExclude: Record "WMS Items Included/ExcludedFND";
        ErrorTemplate: TextConst ENU = ' - Item No.=%1 - Lot=%2 - Location=%3 - Zone=%4 - Bin=%5 - Qty=%6 - UoM=%7 - Line=%8';

    local procedure GetGLSetup();
    begin
        if not GLSetupRead then
            GLSetup.GET;
        GLSetupRead := true;
    end;

    local procedure GetGeneralOpCoSetup();
    begin
        if not GeneralOpCoSetupRead then
            GeneralOpCoSetup.GET;
        GeneralOpCoSetupRead := true;
    end;

    local procedure GetGeneralInterfaceSetup();
    begin
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET;
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetWMSInterfaceSetup();
    begin
        if not WMSInterfaceSetupRead then
            if WMSInterfaceSetup.GET then;
        WMSInterfaceSetupRead := true;
    end;

    local procedure GetCompanyInformation();
    begin
        if not CompanyInformationRead then
            CompanyInformation.GET;
        CompanyInformationRead := true;
    end;

    local procedure GetNoOfAttemptsPerInterfaceAndSource(InterfaceCode: Code[20]; SourceType: Integer; SourceSubtype: Integer; SourceNo: Code[20]): Integer;
    var
        InterfaceLogHeaderVIP: Record "Interface Log Header VIP INT";
    begin
        InterfaceLogHeaderVIP.SETRANGE("Interface Code", InterfaceCode);
        InterfaceLogHeaderVIP.SETRANGE("Source Type", SourceType);
        InterfaceLogHeaderVIP.SETRANGE("Source Subtype", SourceSubtype);
        InterfaceLogHeaderVIP.SETRANGE("Source No.", SourceNo);
        exit(InterfaceLogHeaderVIP.COUNT);
    end;

    local procedure GetSalesSetup();
    begin
        //HEI.35>>
        if not SalesSetupRead then
            SalesSetup.GET;
        SalesSetupRead := true;
        //HEI.35<<
    end;

    local procedure "--- ITEM Functions -----"();
    begin
    end;

    procedure ProcessItemRequest(InterfaceEntryHeader: Record "Interface Entry Header VIP INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line VIP INT";
        InterfaceEntryLine: Record "Interface Entry Line VIP INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        VATPostingSetup: Record "VAT Posting Setup";
        //ItemCrossReference: Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference"; //BC Upgrade GUNREM01 Replaced Item Cross Reference Table
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        DefaultDimension: Record "Default Dimension";
        entryNo: Integer;
        MissingSKUError: Label 'Item No. %1 has no SKU for Van Sales';
        "----": Integer;
        ItemTrackingCode: Record "Item Tracking Code";
        // ItemCrossRef: Record "Item Cross Reference";
        ItemCrossRef: Record "Item Reference"; //BC Upgrade GUNREM01 Replaced Item Cross Reference Table
        ItemUOM: Record "Item Unit of Measure";
        DefaultDimensions: Record "Default Dimension";
        InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
    begin
        //-- OBSOLETE---
        //Items NAV -> WMS
        GetGeneralInterfaceSetup;
        GetWMSInterfaceSetup;
        GetCompanyInformation;
        GetGLSetup;

        WMSInterfaceSetup.TESTFIELD("WMS Item Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."WMS Item Interface");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        //InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader,FALSE);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Msg. Sender Business System ID" := InterfaceEntryHeader."Msg. Recv. Business System ID";
        if InterfaceEntryHeaderOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := InterfaceEntryHeader."Msg. Sender Business System ID";
        InterfaceEntryHeaderOut."Source System ID" := InterfaceEntryHeader."Source System ID";
        InterfaceEntryHeaderOut."Interface Code" := WMSInterfaceSetup."WMS Item Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                Item.RESET;
                if InterfaceEntryLine."Item Code" <> '*' then
                    Item.SETRANGE("No.", InterfaceEntryLine."Item Code");
                Item.SETRANGE(Blocked, false);
                Item.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                Item.SETFILTER("Last Date Modified", '>=%1', CALCDATE(WMSInterfaceSetup."Starting Modified Date", TODAY));
                if Item.FINDSET then
                    repeat
                        Item.TESTFIELD(Description);
                        CLEAR(InterfaceEntryLineOut);
                        entryNo += 1;
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := entryNo;
                        InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
                        InterfaceEntryLineOut."Item Code" := Item."No.";
                        InterfaceEntryLineOut."Item Designation" := Item.Description;
                        InterfaceEntryLineOut."Traceability Code" := Item."Item Tracking Code";
                        InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                        InterfaceEntryLineOut."Item UOM in Reflex 1st" := WMSInterfaceSetup."Reflex 1st OUM";
                        //InterfaceEntryLineOut."Item UOM in Reflex 2rd" := WMSInterfaceSetup."Reflex 2rd OUM";
                        InterfaceEntryLineOut."Item UOM in Reflex 2rd" := Item."Sales Unit of Measure";
                        InterfaceEntryLineOut."Item UOM in Reflex 3rd" := WMSInterfaceSetup."Reflex 3rd OUM";
                        //InterfaceEntryLineOut.Flag := Flag;

                        ItemCrossRef.RESET;
                        ItemCrossRef.SETRANGE("Item No.", Item."No.");
                        //  ItemCrossRef.SETRANGE("Cross-Reference Type", ItemCrossRef."Cross-Reference Type"::"Bar Code"); 
                        ItemCrossRef.SETRANGE("Reference Type", ItemCrossRef."Reference Type"::"Bar Code"); //BC Upgrade GUNREM01 Replaced with "Cross-Reference Type"
                        ItemCrossRef.SETFILTER("Unit of Measure", '%1|%2|%3', WMSInterfaceSetup."Reflex 1st OUM", WMSInterfaceSetup."Reflex 2rd OUM", WMSInterfaceSetup."Reflex 3rd OUM");
                        if ItemCrossRef.FINDFIRST then
                            repeat
                                case ItemCrossRef."Unit of Measure" of
                                    WMSInterfaceSetup."Reflex 1st OUM":
                                        begin
                                            //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 1st" := ItemCrossRef."Cross-Reference No.";
                                            InterfaceEntryLineOut."Cross-Ref. No. Reflex 1st" := ItemCrossRef."Reference No.";//BC Upgrade GUNREM01 Replaced with "Cross-Reference No."
                                            InterfaceEntryLineOut."Cross Ref Desc. Reflex 1st" := ItemCrossRef.Description;
                                        end;
                                    WMSInterfaceSetup."Reflex 2rd OUM":
                                        begin
                                            //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 2rd" := ItemCrossRef."Cross-Reference No.";
                                            InterfaceEntryLineOut."Cross-Ref. No. Reflex 2rd" := ItemCrossRef."Reference No.";//BC Upgrade GUNREM01 Replaced with "Cross-Reference No."
                                            InterfaceEntryLineOut."Cross Ref Desc. Reflex 2rd" := ItemCrossRef.Description;
                                        end;
                                    WMSInterfaceSetup."Reflex 3rd OUM":
                                        begin
                                            //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 3rd" := ItemCrossRef."Cross-Reference No.";
                                            InterfaceEntryLineOut."Cross-Ref. No. Reflex 3rd" := ItemCrossRef."Reference No.";//BC Upgrade GUNREM01 Replaced with "Cross-Reference No."
                                            InterfaceEntryLineOut."Cross Ref Desc. Reflex 3rd" := ItemCrossRef.Description;
                                        end;
                                end;
                            until ItemCrossRef.NEXT = 0;

                        ItemUOM.RESET;
                        ItemUOM.SETRANGE("Item No.", Item."No.");
                        ItemUOM.SETFILTER(Code, '%1|%2|%3', WMSInterfaceSetup."Reflex 1st OUM", WMSInterfaceSetup."Reflex 2rd OUM", WMSInterfaceSetup."Reflex 3rd OUM");
                        if ItemUOM.FINDFIRST then
                            repeat
                                case ItemUOM.Code of
                                    WMSInterfaceSetup."Reflex 1st OUM":
                                        begin
                                            InterfaceEntryLineOut."Length Reflex 1st" := ItemUOM.Length;
                                            InterfaceEntryLineOut."Width Reflex 1st" := ItemUOM.Width;
                                            InterfaceEntryLineOut."Height Reflex 1st" := ItemUOM.Height;
                                            InterfaceEntryLineOut."Weight Reflex 1st" := ItemUOM.Weight;
                                            InterfaceEntryLineOut."Net Weight Reflex 1st" := ItemUOM."Net Weight FND";
                                        end;
                                    WMSInterfaceSetup."Reflex 2rd OUM":
                                        begin
                                            InterfaceEntryLineOut."Length Reflex 2rd" := ItemUOM.Length;
                                            InterfaceEntryLineOut."Width Reflex 2rd" := ItemUOM.Width;
                                            InterfaceEntryLineOut."Height Reflex 2rd" := ItemUOM.Height;
                                            InterfaceEntryLineOut."Weight Reflex 2rd" := ItemUOM.Weight;
                                            InterfaceEntryLineOut."Net Weight Reflex 2rd" := ItemUOM."Net Weight FND";
                                        end;
                                    WMSInterfaceSetup."Reflex 3rd OUM":
                                        begin
                                            InterfaceEntryLineOut."Length Reflex 3rd" := ItemUOM.Length;
                                            InterfaceEntryLineOut."Width Reflex 3rd" := ItemUOM.Width;
                                            InterfaceEntryLineOut."Height Reflex 3rd" := ItemUOM.Height;
                                            InterfaceEntryLineOut."Weight Reflex 3rd" := ItemUOM.Weight;
                                            InterfaceEntryLineOut."Net Weight Reflex 3rd" := ItemUOM."Net Weight FND";
                                        end;
                                end;
                            until ItemUOM.NEXT = 0;

                        DefaultDimensions.RESET;
                        DefaultDimensions.SETRANGE("Table ID", 27);
                        DefaultDimensions.SETRANGE("No.", Item."No.");
                        DefaultDimensions.SETFILTER("Dimension Code", '%1|%2|%3', GLSetup."Global Dimension 1 Code", GLSetup."Global Dimension 2 Code", GLSetup."Shortcut Dimension 6 Code");
                        if DefaultDimensions.FINDFIRST then
                            repeat
                                case DefaultDimensions."Dimension Code" of
                                    GLSetup."Global Dimension 1 Code":
                                        begin
                                            InterfaceEntryLineOut."Item Shorctcut Dim1" := DefaultDimensions."Dimension Code";
                                            InterfaceEntryLineOut."Item Dim. Value Code1" := DefaultDimensions."Dimension Value Code";
                                        end;
                                    GLSetup."Global Dimension 2 Code":
                                        begin
                                            InterfaceEntryLineOut."Item Shorctcut Dim2" := DefaultDimensions."Dimension Code";
                                            InterfaceEntryLineOut."Item Dim. Value Code2" := DefaultDimensions."Dimension Value Code";
                                        end;
                                    GLSetup."Shortcut Dimension 6 Code":
                                        begin
                                            InterfaceEntryLineOut."Item Shorctcut Dim6" := DefaultDimensions."Dimension Code";
                                            InterfaceEntryLineOut."Item Dim. Value Code6" := DefaultDimensions."Dimension Value Code";
                                        end;
                                end;
                            until DefaultDimensions.NEXT = 0;

                        InterfaceEntryLineOut.INSERT;
                    until Item.NEXT = 0;
            until InterfaceEntryLine.NEXT = 0;

        //InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        //InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        //InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure CreateItemOutbound(pItem: Record Item; pFlag: Text[6]);
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line VIP INT";
        InterfaceEntryLine: Record "Interface Entry Line VIP INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        VATPostingSetup: Record "VAT Posting Setup";
        //  ItemCrossReference: Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference"; //BC Upgrade GUNREM01 Replaced Item Cross Reference Table
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        DefaultDimension: Record "Default Dimension";
        entryNo: Integer;
        MissingSKUError: Label 'Item No. %1 has no SKU for Van Sales';
        "----": Integer;
        ItemTrackingCode: Record "Item Tracking Code";
        //  ItemCrossRef: Record "Item Cross Reference";
        ItemCrossRef: Record "Item Reference"; //BC Upgrade GUNREM01 Replaced Item Cross Reference Table
        ItemUOM: Record "Item Unit of Measure";
        DefaultDimensions: Record "Default Dimension";
        InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        ItemUOM1: Record "Item Unit of Measure";
    begin
        //Items NAV -> WMS
        GetGeneralInterfaceSetup;
        GetWMSInterfaceSetup;
        GetCompanyInformation;
        GetGLSetup;

        WMSInterfaceSetup.TESTFIELD("WMS Item Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."WMS Item Interface");
        if not InterfaceSetup.Enabled then exit;

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := WMSInterfaceSetup."WMS Item Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."Source Type" := DATABASE::Item;
        InterfaceEntryHeaderOut."Source No." := pItem."No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        Item.RESET;
        Item.SETRANGE("No.", pItem."No.");
        /*//<<commented by HEI.12
        //Item.SETRANGE(Blocked,FALSE);
        //Item.SETFILTER("Item Category Code",WMSInterfaceSetup."Item Category");
        *///>>commented by HEI.12
        if Item.FINDFIRST then begin
            Item.TESTFIELD(Description);
            CLEAR(InterfaceEntryLineOut);
            entryNo += 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := entryNo;
            InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
            InterfaceEntryLineOut."Item Code" := Item."No.";
            InterfaceEntryLineOut."Item Designation" := Item.Description;
            InterfaceEntryLineOut."Traceability Code" := Item."Item Tracking Code";
            InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            InterfaceEntryLineOut."Item UOM in Reflex 1st" := WMSInterfaceSetup."Reflex 1st OUM";
            //InterfaceEntryLineOut."Item UOM in Reflex 2rd" := WMSInterfaceSetup."Reflex 2rd OUM";
            InterfaceEntryLineOut."Item UOM in Reflex 2rd" := Item."Sales Unit of Measure";
            //HEI.09>>
            //InterfaceEntryLineOut."Item UOM in Reflex 3rd" := WMSInterfaceSetup."Reflex 3rd OUM";
            ItemUOMinReflex3rd := Item_UOMinReflex3rd(Item);
            InterfaceEntryLineOut."Item UOM in Reflex 3rd" := ItemUOMinReflex3rd;
            //HEI.09<<
            InterfaceEntryLineOut.Flag := pFlag;

            ItemCrossRef.RESET;
            ItemCrossRef.SETRANGE("Item No.", Item."No.");
            //ItemCrossRef.SETRANGE("Cross-Reference Type",ItemCrossRef."Cross-Reference Type"::"Bar Code");
            //  ItemCrossRef.SETFILTER("Cross-Reference Type", '%1|%2', ItemCrossRef."Cross-Reference Type"::"Bar Code", ItemCrossRef."Cross-Reference Type"::" ");
            ItemCrossRef.SETFILTER("Reference Type", '%1|%2', ItemCrossRef."Reference Type"::"Bar Code", ItemCrossRef."Reference Type"::" "); //BC Upgrade GUNREM01 Replaced with "Cross-Reference Type"

            //ItemCrossRef.SETFILTER("Unit of Measure",'%1|%2|%3',WMSInterfaceSetup."Reflex 1st OUM",WMSInterfaceSetup."Reflex 2rd OUM",WMSInterfaceSetup."Reflex 3rd OUM");
            //HEI.09>>
            //ItemCrossRef.SETFILTER("Unit of Measure",'%1|%2|%3',WMSInterfaceSetup."Reflex 1st OUM",Item."Sales Unit of Measure",WMSInterfaceSetup."Reflex 3rd OUM");
            ItemCrossRef.SETFILTER("Unit of Measure", '%1|%2|%3', WMSInterfaceSetup."Reflex 1st OUM", Item."Sales Unit of Measure", ItemUOMinReflex3rd);
            //HEI.09<<
            if ItemCrossRef.FINDFIRST then
                repeat
                    case ItemCrossRef."Unit of Measure" of
                        WMSInterfaceSetup."Reflex 1st OUM":
                            if InterfaceEntryLineOut."Cross-Ref. No. Reflex 1st" = '' then begin
                                //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 1st" := ItemCrossRef."Cross-Reference No.";
                                InterfaceEntryLineOut."Cross-Ref. No. Reflex 1st" := ItemCrossRef."Reference No.";//

                                InterfaceEntryLineOut."Cross Ref Desc. Reflex 1st" := ItemCrossRef.Description;

                                if WMSInterfaceSetup."Reflex 1st OUM" = Item."Sales Unit of Measure" then begin
                                    //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 2rd" := ItemCrossRef."Cross-Reference No.";
                                    InterfaceEntryLineOut."Cross-Ref. No. Reflex 2rd" := ItemCrossRef."Reference No.";//BC Upgrade GUNREM01 Replaced with "Cross-Reference No."

                                    InterfaceEntryLineOut."Cross Ref Desc. Reflex 2rd" := ItemCrossRef.Description;
                                end;
                                //HEI.09>>
                                //IF WMSInterfaceSetup."Reflex 1st OUM" = WMSInterfaceSetup."Reflex 3rd OUM" THEN BEGIN
                                if WMSInterfaceSetup."Reflex 1st OUM" = ItemUOMinReflex3rd then begin
                                    //HEI.09<<
                                    //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 3rd" := ItemCrossRef."Cross-Reference No.";
                                    InterfaceEntryLineOut."Cross-Ref. No. Reflex 3rd" := ItemCrossRef."Reference No.";  //BC Upgrade GUNREM01 Replaced with "Cross-Reference No."
                                    InterfaceEntryLineOut."Cross Ref Desc. Reflex 3rd" := ItemCrossRef.Description;
                                end;
                            end;
                        //WMSInterfaceSetup."Reflex 2rd OUM":
                        Item."Sales Unit of Measure":
                            if InterfaceEntryLineOut."Cross-Ref. No. Reflex 2rd" = '' then begin
                                //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 2rd" := ItemCrossRef."Cross-Reference No.";
                                InterfaceEntryLineOut."Cross-Ref. No. Reflex 2rd" := ItemCrossRef."Reference No.";//BC Upgrade GUNREM01 Replaced with "Cross-Reference No."

                                InterfaceEntryLineOut."Cross Ref Desc. Reflex 2rd" := ItemCrossRef.Description;
                                //HEI.09>>
                                //IF Item."Sales Unit of Measure" = WMSInterfaceSetup."Reflex 3rd OUM" THEN BEGIN
                                if Item."Sales Unit of Measure" = ItemUOMinReflex3rd then begin
                                    //HEI.09<<
                                    //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 3rd" := ItemCrossRef."Cross-Reference No.";
                                    InterfaceEntryLineOut."Cross-Ref. No. Reflex 3rd" := ItemCrossRef."Reference No."; //BC Upgrade GUNREM01 Replaced with "Cross-Reference No."

                                    InterfaceEntryLineOut."Cross Ref Desc. Reflex 3rd" := ItemCrossRef.Description;
                                end;
                            end;
                        //HEI.09>>
                        //WMSInterfaceSetup."Reflex 3rd OUM":
                        ItemUOMinReflex3rd:
                            //HEI.09<<
                            if InterfaceEntryLineOut."Cross-Ref. No. Reflex 3rd" = '' then begin
                                //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 3rd" := ItemCrossRef."Cross-Reference No.";
                                InterfaceEntryLineOut."Cross-Ref. No. Reflex 3rd" := ItemCrossRef."Reference No."; //BC Upgrade GUNREM01 Replaced with "Cross-Reference No."
                                InterfaceEntryLineOut."Cross Ref Desc. Reflex 3rd" := ItemCrossRef.Description;
                            end;
                    end;
                until ItemCrossRef.NEXT = 0;

            if (InterfaceEntryLineOut."Cross-Ref. No. Reflex 1st" = '') and ItemUOM1.GET(Item."No.", WMSInterfaceSetup."Reflex 1st OUM") then begin
                ItemCrossRef.RESET;
                ItemCrossRef.SETRANGE("Item No.", Item."No.");
                //  ItemCrossRef.SETFILTER("Cross-Reference Type", '%1|%2', ItemCrossRef."Cross-Reference Type"::"Bar Code", ItemCrossRef."Cross-Reference Type"::" ");
                ItemCrossRef.SETFILTER("Reference Type", '%1|%2', ItemCrossRef."Reference Type"::"Bar Code", ItemCrossRef."Reference Type"::" ");// //BC Upgrade GUNREM01 Replaced with "Cross-Reference No."

                if ItemCrossRef.FINDFIRST then
                    repeat
                        if ItemUOM.GET(Item."No.", ItemCrossRef."Unit of Measure") and (ItemUOM."Qty. per Unit of Measure" = ItemUOM1."Qty. per Unit of Measure") then begin
                            //  InterfaceEntryLineOut."Cross-Ref. No. Reflex 1st" := ItemCrossRef."Cross-Reference No.";
                            InterfaceEntryLineOut."Cross-Ref. No. Reflex 1st" := ItemCrossRef."Reference No."; //BC Upgrade GUNREM01 Replaced with "Cross-Reference No."
                            InterfaceEntryLineOut."Cross Ref Desc. Reflex 1st" := ItemCrossRef.Description;
                        end;
                    until (ItemCrossRef.NEXT = 0) or (InterfaceEntryLineOut."Cross-Ref. No. Reflex 1st" <> '');
            end;

            ItemUOM.RESET;
            ItemUOM.SETRANGE("Item No.", Item."No.");
            //ItemUOM.SETFILTER(Code,'%1|%2|%3',WMSInterfaceSetup."Reflex 1st OUM",WMSInterfaceSetup."Reflex 2rd OUM",WMSInterfaceSetup."Reflex 3rd OUM");
            //HEI.09>>
            //ItemUOM.SETFILTER(Code,'%1|%2|%3',WMSInterfaceSetup."Reflex 1st OUM", Item."Sales Unit of Measure", WMSInterfaceSetup."Reflex 3rd OUM");
            ItemUOM.SETFILTER(Code, '%1|%2|%3', WMSInterfaceSetup."Reflex 1st OUM", Item."Sales Unit of Measure", ItemUOMinReflex3rd);
            //HEI.09<<
            if ItemUOM.FINDFIRST then
                repeat
                    //HEI.10>>
                    if ItemUOM."Unit of Weight FND" = 'G' then begin
                        ItemUOM.Weight := ItemUOM.Weight / 1000;
                        ItemUOM."Net Weight FND" := ItemUOM."Net Weight FND" / 1000;
                    end;
                    //HEI.10<<
                    case ItemUOM.Code of
                        WMSInterfaceSetup."Reflex 1st OUM":
                            begin
                                InterfaceEntryLineOut."Length Reflex 1st" := ItemUOM.Length;
                                InterfaceEntryLineOut."Width Reflex 1st" := ItemUOM.Width;
                                InterfaceEntryLineOut."Height Reflex 1st" := ItemUOM.Height;
                                InterfaceEntryLineOut."Weight Reflex 1st" := ItemUOM.Weight;
                                InterfaceEntryLineOut."Net Weight Reflex 1st" := ItemUOM."Net Weight FND";

                                if WMSInterfaceSetup."Reflex 1st OUM" = Item."Sales Unit of Measure" then begin
                                    InterfaceEntryLineOut."Length Reflex 2rd" := ItemUOM.Length;
                                    InterfaceEntryLineOut."Width Reflex 2rd" := ItemUOM.Width;
                                    InterfaceEntryLineOut."Height Reflex 2rd" := ItemUOM.Height;
                                    InterfaceEntryLineOut."Weight Reflex 2rd" := ItemUOM.Weight;
                                    InterfaceEntryLineOut."Net Weight Reflex 2rd" := ItemUOM."Net Weight FND";
                                    InterfaceEntryLineOut."Reflex Ref. UOM Reflex 2rd" := ItemUOM."Qty. per Unit of Measure";
                                end;
                                //HEI.09>>
                                //IF WMSInterfaceSetup."Reflex 1st OUM" = WMSInterfaceSetup."Reflex 3rd OUM" THEN BEGIN
                                if WMSInterfaceSetup."Reflex 1st OUM" = ItemUOMinReflex3rd then begin
                                    //HEI.09<<
                                    InterfaceEntryLineOut."Length Reflex 3rd" := ItemUOM.Length;
                                    InterfaceEntryLineOut."Width Reflex 3rd" := ItemUOM.Width;
                                    InterfaceEntryLineOut."Height Reflex 3rd" := ItemUOM.Height;
                                    InterfaceEntryLineOut."Weight Reflex 3rd" := ItemUOM.Weight;
                                    InterfaceEntryLineOut."Net Weight Reflex 3rd" := ItemUOM."Net Weight FND";
                                    InterfaceEntryLineOut."Reflex Ref. UOM Reflex 3rd" := ItemUOM."Qty. per Unit of Measure";
                                end;
                            end;
                        //WMSInterfaceSetup."Reflex 2rd OUM":
                        Item."Sales Unit of Measure":
                            begin
                                InterfaceEntryLineOut."Length Reflex 2rd" := ItemUOM.Length;
                                InterfaceEntryLineOut."Width Reflex 2rd" := ItemUOM.Width;
                                InterfaceEntryLineOut."Height Reflex 2rd" := ItemUOM.Height;
                                InterfaceEntryLineOut."Weight Reflex 2rd" := ItemUOM.Weight;
                                InterfaceEntryLineOut."Net Weight Reflex 2rd" := ItemUOM."Net Weight FND";
                                InterfaceEntryLineOut."Reflex Ref. UOM Reflex 2rd" := ItemUOM."Qty. per Unit of Measure";
                                //HEI.09>>
                                //IF Item."Sales Unit of Measure" = WMSInterfaceSetup."Reflex 3rd OUM" THEN BEGIN
                                if Item."Sales Unit of Measure" = ItemUOMinReflex3rd then begin
                                    //HEI.09<<
                                    InterfaceEntryLineOut."Length Reflex 3rd" := ItemUOM.Length;
                                    InterfaceEntryLineOut."Width Reflex 3rd" := ItemUOM.Width;
                                    InterfaceEntryLineOut."Height Reflex 3rd" := ItemUOM.Height;
                                    InterfaceEntryLineOut."Weight Reflex 3rd" := ItemUOM.Weight;
                                    InterfaceEntryLineOut."Net Weight Reflex 3rd" := ItemUOM."Net Weight FND";
                                    InterfaceEntryLineOut."Reflex Ref. UOM Reflex 3rd" := ItemUOM."Qty. per Unit of Measure";
                                end;
                            end;
                        //HEI.09>>
                        //WMSInterfaceSetup."Reflex 3rd OUM":
                        ItemUOMinReflex3rd:
                            //HEI.09<<
                            begin
                                InterfaceEntryLineOut."Length Reflex 3rd" := ItemUOM.Length;
                                InterfaceEntryLineOut."Width Reflex 3rd" := ItemUOM.Width;
                                InterfaceEntryLineOut."Height Reflex 3rd" := ItemUOM.Height;
                                InterfaceEntryLineOut."Weight Reflex 3rd" := ItemUOM.Weight;
                                InterfaceEntryLineOut."Net Weight Reflex 3rd" := ItemUOM."Net Weight FND";
                                InterfaceEntryLineOut."Reflex Ref. UOM Reflex 3rd" := ItemUOM."Qty. per Unit of Measure";
                            end;
                    end;
                until ItemUOM.NEXT = 0;

            DefaultDimensions.RESET;
            DefaultDimensions.SETRANGE("Table ID", 27);
            DefaultDimensions.SETRANGE("No.", Item."No.");
            DefaultDimensions.SETFILTER("Dimension Code", '%1|%2|%3', GLSetup."Global Dimension 1 Code", GLSetup."Shortcut Dimension 5 Code", GLSetup."Shortcut Dimension 6 Code");
            if DefaultDimensions.FINDFIRST then
                repeat
                    case DefaultDimensions."Dimension Code" of
                        GLSetup."Global Dimension 1 Code":
                            begin
                                InterfaceEntryLineOut."Item Shorctcut Dim1" := DefaultDimensions."Dimension Code";
                                InterfaceEntryLineOut."Item Dim. Value Code1" := DefaultDimensions."Dimension Value Code";
                            end;
                        /*GLSetup."Global Dimension 2 Code":
                          BEGIN
                            InterfaceEntryLineOut."Item Shorctcut Dim2" := DefaultDimensions."Dimension Code";
                            InterfaceEntryLineOut."Item Dim. Value Code2" := DefaultDimensions."Dimension Value Code";
                          END;*/
                        GLSetup."Shortcut Dimension 5 Code":
                            begin
                                InterfaceEntryLineOut."Item Shorctcut Dim5" := DefaultDimensions."Dimension Code";
                                InterfaceEntryLineOut."Item Dim. Value Code5" := DefaultDimensions."Dimension Value Code";
                            end;
                        GLSetup."Shortcut Dimension 6 Code":
                            begin
                                InterfaceEntryLineOut."Item Shorctcut Dim6" := DefaultDimensions."Dimension Code";
                                InterfaceEntryLineOut."Item Dim. Value Code6" := DefaultDimensions."Dimension Value Code";
                            end;
                    end;
                until DefaultDimensions.NEXT = 0;

            InterfaceEntryLineOut.INSERT(true);
        end;

    end;

    procedure FindItemFilters(Item: Record Item): Boolean;
    var
        ItemSearch: Record Item;
        ItemsIncludeExclude: Record "WMS Items Included/ExcludedFND";
    begin
        ItemsIncludeExclude.RESET;  //HEI.12
        ItemSearch.RESET;
        ItemSearch.SETRANGE("No.", Item."No.");
        ItemSearch.SETRANGE(Blocked, false);
        if not ItemsIncludeExclude.GET(Item."No.") then    //HEI.12
            ItemSearch.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
        if ItemSearch.FINDFIRST then begin
            //EXIT(TRUE);  //HEI.12
            //<<HEI.12
            if ItemsIncludeExclude."Item Code" <> '' then begin
                if ItemsIncludeExclude.Excluded then exit(false);
                if ItemsIncludeExclude.Included then exit(true);
            end else
                exit(true);
            //>>HEI.12
        end else
            exit(false);
    end;

    // [EventSubscriber(ObjectType::Codeunit, 50000, 'OnAfterSetInterfaceProcessed', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Interface Framework Mgt.", 'OnAfterSetInterfaceProcessed', '', false, false)]

    local procedure Interface_OnAfterProcessed(InterfaceEntryHeader: Record "Interface Entry Header INT");
    var
        ItemVar: Record Item;
        InterLine: Record "Interface Entry Line INT";
        InterComp: Record "Interface Entry Component INT";
        InterCompDetails: Record "Interface Entry Comp.DetailINT";
    begin
        if InterfaceEntryHeader.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        GetGeneralInterfaceSetup;
        if InterfaceEntryHeader."Interface Code" = GeneralInterfaceSetup."Material Interface" then begin
            InterLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
            if InterLine.FINDFIRST then
                repeat
                    InterComp.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
                    InterComp.SETRANGE("Line Entry No.", InterLine."Entry No.");
                    InterComp.SETRANGE("Table ID", 27);
                    if InterComp.FINDFIRST and InterCompDetails.GET(InterfaceEntryHeader."Entry No.", InterLine."Entry No.", 27, InterComp.Code, 2) then begin
                        ItemVar.SETRANGE("No. 2", InterCompDetails."Incoming Value");
                        if ItemVar.FINDFIRST then
                            if FindItemFilters(ItemVar) then
                                CreateItemOutbound(ItemVar, 'Update');
                    end;
                until InterLine.NEXT = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterInsertEvent', '', false, false)]
    local procedure Item_OnAfterInsertEvent(var Rec: Record Item; RunTrigger: Boolean);
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not RunTrigger then exit;
        if not GUIALLOWED then exit;

        if (Rec.Description <> '') and FindItemFilters(Rec) then
            CreateItemOutbound(Rec, 'Create');
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure Item_OnBeforeDeleteEvent(var Rec: Record Item; RunTrigger: Boolean);
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not RunTrigger then exit;

        if FindItemFilters(Rec) then
            CreateItemOutbound(Rec, 'Delete');
    end;

    [EventSubscriber(ObjectType::Table, 27, 'OnAfterModifyEvent', '', false, false)]
    local procedure Item_OnAfterModifyEvent(var Rec: Record Item; var xRec: Record Item; RunTrigger: Boolean);
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not RunTrigger then exit;
        if not GUIALLOWED then exit;

        /*IF (Rec."No." = xRec."No.") AND
           (Rec.Description = xRec.Description) AND
           (Rec."Item Tracking Code" = xRec."Item Tracking Code") AND
           (Rec."Item Category Code" = xRec."Item Category Code") AND
           (Rec.Blocked = xRec.Blocked) THEN
          EXIT;*/


        if FindItemFilters(Rec) then
            CreateItemOutbound(Rec, 'Update');

    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Reference", 'OnAfterInsertEvent', '', false, false)]
    local procedure CrossRef_OnAfterInsertEvent(var Rec: Record "Item Reference"; RunTrigger: Boolean);
    var
        ItemRec: Record Item;
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not ItemRec.GET(Rec."Item No.") then exit;
        if not RunTrigger then exit;

        //HEI.09>>
        //IF Rec."Unit of Measure" IN [WMSInterfaceSetup."Reflex 1st OUM",WMSInterfaceSetup."Reflex 2rd OUM",WMSInterfaceSetup."Reflex 3rd OUM"] THEN
        if Rec."Unit of Measure" in [WMSInterfaceSetup."Reflex 1st OUM", WMSInterfaceSetup."Reflex 2rd OUM", Item_UOMinReflex3rd(ItemRec)] then
            //HEI.09<<
            if FindItemFilters(ItemRec) then
                CreateItemOutbound(ItemRec, 'Update');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Reference", 'OnAfterModifyEvent', '', false, false)]
    local procedure CrossRef_OnAftereModifyEvent(var Rec: Record "Item Reference"; var xRec: Record "Item Reference"; RunTrigger: Boolean);
    var
        ItemRec: Record Item;
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not ItemRec.GET(Rec."Item No.") then exit;
        if not RunTrigger then exit;
        //HEI.09>>
        //IF (Rec."Unit of Measure" IN [WMSInterfaceSetup."Reflex 1st OUM",WMSInterfaceSetup."Reflex 2rd OUM",WMSInterfaceSetup."Reflex 3rd OUM"]) AND (Rec.Description <> xRec.Description) THEN
        if (Rec."Unit of Measure" in [WMSInterfaceSetup."Reflex 1st OUM", WMSInterfaceSetup."Reflex 2rd OUM", Item_UOMinReflex3rd(ItemRec)]) and (Rec.Description <> xRec.Description) then
            //HEI.09<<
            if FindItemFilters(ItemRec) then
                CreateItemOutbound(ItemRec, 'Update');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Reference", 'OnBeforeRenameEvent', '', false, false)]
    local procedure CrossRef_OnBeforeRenameyEvent(var Rec: Record "Item Reference"; var xRec: Record "Item Reference"; RunTrigger: Boolean);
    var
        ItemRec: Record Item;
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not ItemRec.GET(Rec."Item No.") then exit;
        if not RunTrigger then exit;
        //HEI.09>>
        //IF (Rec."Unit of Measure" IN [WMSInterfaceSetup."Reflex 1st OUM",WMSInterfaceSetup."Reflex 2rd OUM",WMSInterfaceSetup."Reflex 3rd OUM"])
        if (Rec."Unit of Measure" in [WMSInterfaceSetup."Reflex 1st OUM", WMSInterfaceSetup."Reflex 2rd OUM", Item_UOMinReflex3rd(ItemRec)])
                    //HEI.09<<
                    // and (Rec."Cross-Reference No." <> xRec."Cross-Reference No.") then
                    and (Rec."Reference No." <> xRec."Reference No.") then //BC Upgrade GUNREM01 Replaced with "Cross-Reference No."

            if FindItemFilters(ItemRec) then
                CreateItemOutbound(ItemRec, 'Update');
    end;

    local procedure Item_UOMinReflex3rd(Item: Record Item): Code[10];
    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
        FirstUOMinFilter: Code[10];
    begin
        //HEI.09>>
        CLEAR(FirstUOMinFilter);
        if STRPOS(WMSInterfaceSetup."Reflex 3rd OUM", '|') > 0 then begin
            FirstUOMinFilter := COPYSTR(WMSInterfaceSetup."Reflex 3rd OUM", 1, STRPOS(WMSInterfaceSetup."Reflex 3rd OUM", '|') - 1);
            ItemUnitofMeasure.RESET;
            ItemUnitofMeasure.SETRANGE("Item No.", Item."No.");
            ItemUnitofMeasure.SETFILTER(Code, FirstUOMinFilter);
            if ItemUnitofMeasure.FIND('-') then
                exit(ItemUnitofMeasure.Code);
        end;

        ItemUnitofMeasure.RESET;
        ItemUnitofMeasure.SETRANGE("Item No.", Item."No.");
        ItemUnitofMeasure.SETFILTER(Code, WMSInterfaceSetup."Reflex 3rd OUM");
        if ItemUnitofMeasure.FIND('-') then
            exit(ItemUnitofMeasure.Code);
        //HEI.09<<
    end;

    local procedure "--- CUSTOMER Functions -----"();
    begin
    end;

    procedure FindCustomerFilters(Customer: Record Customer): Boolean;
    var
        CustomerSearch: Record Customer;
    begin
        CustomerSearch.RESET;
        CustomerSearch.SETRANGE("No.", Customer."No.");
        CustomerSearch.SETRANGE("Flag for Deletion FND", false);
        CustomerSearch.SETFILTER("Account Group FND", WMSInterfaceSetup."Customer Account Groups");
        if CustomerSearch.FINDFIRST then
            exit(true)
        else
            exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforeSendCustomerRequestT(var SalesHeader: Record "Sales Header");
    begin
        //FindCustomerFilters(Customer);
    end;

    procedure ProcessCustomerRequest(InterfaceEntryHeader: Record "Interface Entry Header VIP INT");
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line VIP INT";
        InterfaceEntryLine: Record "Interface Entry Line VIP INT";
        InterfaceSetup: Record "Interface Setup INT";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        VATPostingSetup: Record "VAT Posting Setup";
        // ItemCrossReference: Record "Item Cross Reference";
        ItemCrossReference: Record "Item Reference";

        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        DefaultDimension: Record "Default Dimension";
        entryNo: Integer;
        MissingSKUError: Label 'Item No. %1 has no SKU for Van Sales';
        "----": Integer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        CustomerLocal: Record Customer;
        CountryRegionLocal: Record "Country/Region";
        CustomerAttributesLocal: Record "Customer Attributes FND";
    begin
        //Items NAV -> WMS
        GetGeneralInterfaceSetup;
        GetWMSInterfaceSetup;
        GetCompanyInformation;
        GetGLSetup;

        WMSInterfaceSetup.TESTFIELD("WMS Customer Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."WMS Customer Interface");
        if not InterfaceSetup.Enabled then
            exit;

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut.TRANSFERFIELDS(InterfaceEntryHeader, false);
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut."Interface Code" := WMSInterfaceSetup."WMS Customer Interface";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceEntryLine.SETRANGE("Header Entry No.", InterfaceEntryHeader."Entry No.");
        if InterfaceEntryLine.FINDSET then
            repeat
                CustomerLocal.RESET;
                if InterfaceEntryLine."Customer Code" <> '*' then
                    CustomerLocal.SETRANGE("No.", InterfaceEntryLine."Customer Code");
                CustomerLocal.SETRANGE("Flag for Deletion FND", false);
                CustomerLocal.SETFILTER("Account Group FND", WMSInterfaceSetup."Customer Account Groups");
                CustomerLocal.SETFILTER("Last Date Modified", '>=%1', CALCDATE(WMSInterfaceSetup."Starting Modified Date", TODAY));
                if CustomerLocal.FINDFIRST then
                    repeat
                        CustomerLocal.TESTFIELD(Name);
                        CLEAR(InterfaceEntryLineOut);
                        entryNo += 1;
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := entryNo;
                        InterfaceEntryLineOut."Customer Code" := CustomerLocal."No.";
                        InterfaceEntryLineOut.Description := CustomerLocal.Name;
                        InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                        InterfaceEntryLineOut."Description 2" := CustomerLocal."Name 2";
                        InterfaceEntryLineOut."Post Code" := CustomerLocal."Post Code";
                        InterfaceEntryLineOut.City := CustomerLocal.City;
                        InterfaceEntryLineOut."Country Code" := CustomerLocal."Country/Region Code";
                        if CountryRegionLocal.GET(CustomerLocal."Country/Region Code") then
                            InterfaceEntryLineOut."Country Name" := CountryRegionLocal.Name;
                        InterfaceEntryLineOut."Phone No." := CustomerLocal."Phone No.";
                        InterfaceEntryLineOut."E-mail" := CustomerLocal."E-Mail";
                        //InterfaceEntryLineOut.Route := CustomerLocal.Route; //BC Upgrade GUNREM01 DIT Field
                        InterfaceEntryLineOut."Location Code" := CustomerLocal."Location Code";
                        InterfaceEntryLineOut."Payment Terms Code" := CustomerLocal."Payment Terms Code";
                        // InterfaceEntryLineOut."Require 2 Drivers" := CustomerLocal."Require 2 Drivers";  //BC Upgrade GUNREM01 DIT Field
                        // InterfaceEntryLineOut."Ship-to Address Key No." := CustomerLocal."Ship-to Address Key No."; //BC Upgrade GUNREM01 DIT Field
                        if CustomerAttributesLocal.GET(CustomerLocal."No.") then begin
                            InterfaceEntryLineOut.Classification := CustomerAttributesLocal.Classification;
                            InterfaceEntryLineOut.Address := COPYSTR(CustomerAttributesLocal."House No. 1" + ' ' + CustomerAttributesLocal."House Supplement 2" + ' ' + CustomerLocal.Address, 1, 40);
                            InterfaceEntryLineOut."Address 2" := COPYSTR(CustomerLocal."Address 2" + ' ' + CustomerAttributesLocal."Street 3" + ' ' + CustomerAttributesLocal."Street 4" + ' ' + CustomerAttributesLocal."Street 5", 1, 40);
                        end else begin
                            InterfaceEntryLineOut.Address := COPYSTR(CustomerLocal.Address, 1, 40);
                            InterfaceEntryLineOut."Address 2" := COPYSTR(CustomerLocal."Address 2", 1, 40);
                        end;
                        InterfaceEntryLineOut.INSERT;
                    until CustomerLocal.NEXT = 0;
            until InterfaceEntryLine.NEXT = 0;

        InterfaceFrameworkMgt.SetInterfaceProcessed(InterfaceEntryHeader);
        InterfaceFrameworkMgt.LogInterfaceEntries(InterfaceEntryHeader);
        InterfaceFrameworkMgt.DeleteInterfaceEntries(InterfaceEntryHeader);
    end;

    procedure CreateCustomerOutbound(pCustomer: Record Customer; pFlag: Text[6]);
    var
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt. VIP";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line VIP INT";
        InterfaceEntryLine: Record "Interface Entry Line VIP INT";
        InterfaceSetup: Record "Interface Setup INT";
        Customer: Record Customer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        VATPostingSetup: Record "VAT Posting Setup";
        //ItemCrossReference: Record "Item Cross Reference"; 
        ItemCrossReference: Record "Item Reference"; //BC Upgrade GUNREM01 replaced with "Item Cross Reference" table
        ItemCrossRefError: Label 'Item No. %1 has no item cross reference with type bar code!';
        DefaultDimension: Record "Default Dimension";
        entryNo: Integer;
        MissingSKUError: Label 'Item No. %1 has no SKU for Van Sales';
        "----": Integer;
        InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT";
        CustomerLocal: Record Customer;
        CountryRegionLocal: Record "Country/Region";
        CustomerAttributesLocal: Record "Customer Attributes FND";
    begin
        GetGeneralInterfaceSetup;
        GetWMSInterfaceSetup;
        GetCompanyInformation;
        GetGLSetup;

        WMSInterfaceSetup.TESTFIELD("WMS Customer Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."WMS Customer Interface");
        if not InterfaceSetup.Enabled then exit;

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := WMSInterfaceSetup."WMS Customer Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."Source Type" := DATABASE::Customer;
        InterfaceEntryHeaderOut."Source No." := pCustomer."No.";
        InterfaceEntryHeaderOut.INSERT(true);

        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);

        CustomerLocal.RESET;
        CustomerLocal.SETRANGE("No.", pCustomer."No.");
        CustomerLocal.SETRANGE("Flag for Deletion FND", false);
        CustomerLocal.SETFILTER("Account Group FND", WMSInterfaceSetup."Customer Account Groups");
        if CustomerLocal.FINDFIRST then begin
            CustomerLocal.TESTFIELD(Name);
            CLEAR(InterfaceEntryLineOut);
            entryNo += 1;
            InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
            InterfaceEntryLineOut."Entry No." := entryNo;
            InterfaceEntryLineOut."Customer Code" := CustomerLocal."No.";
            InterfaceEntryLineOut.Description := CustomerLocal.Name;
            InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            InterfaceEntryLineOut."Description 2" := CustomerLocal."Name 2";
            InterfaceEntryLineOut."Post Code" := CustomerLocal."Post Code";
            InterfaceEntryLineOut.City := CustomerLocal.City;
            InterfaceEntryLineOut."Country Code" := CustomerLocal."Country/Region Code";
            if CountryRegionLocal.GET(CustomerLocal."Country/Region Code") then
                InterfaceEntryLineOut."Country Name" := CountryRegionLocal.Name;
            InterfaceEntryLineOut."Phone No." := CustomerLocal."Phone No.";
            InterfaceEntryLineOut."E-mail" := CustomerLocal."E-Mail";
            // InterfaceEntryLineOut.Route := CustomerLocal.Route; //BC Upgrade GUNREM01 DIT field
            InterfaceEntryLineOut."Location Code" := CustomerLocal."Location Code";
            InterfaceEntryLineOut."Payment Terms Code" := CustomerLocal."Payment Terms Code";
            // InterfaceEntryLineOut."Require 2 Drivers" := CustomerLocal."Require 2 Drivers"; //BC Upgrade GUNREM01 DIT field
            // InterfaceEntryLineOut."Ship-to Address Key No." := CustomerLocal."Ship-to Address Key No."; //BC Upgrade GUNREM01 DIT field
            if CustomerAttributesLocal.GET(CustomerLocal."No.") then begin
                InterfaceEntryLineOut.Classification := CustomerAttributesLocal.Classification;
                InterfaceEntryLineOut.Address := COPYSTR(CustomerAttributesLocal."House No. 1" + ' ' + CustomerAttributesLocal."House Supplement 2" + ' ' + CustomerLocal.Address, 1, 40);
                InterfaceEntryLineOut."Address 2" := COPYSTR(CustomerLocal."Address 2" + ' ' + CustomerAttributesLocal."Street 3" + ' ' + CustomerAttributesLocal."Street 4" + ' ' + CustomerAttributesLocal."Street 5", 1, 40);
            end else begin
                InterfaceEntryLineOut.Address := COPYSTR(CustomerLocal.Address, 1, 40);
                InterfaceEntryLineOut."Address 2" := COPYSTR(CustomerLocal."Address 2", 1, 40);
            end;
            InterfaceEntryLineOut.INSERT(true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterInsertEvent', '', false, false)]
    local procedure Customer_OnAfterInsertEvent(var Rec: Record Customer; RunTrigger: Boolean);
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not RunTrigger then exit;

        if (Rec.Name <> '') and FindCustomerFilters(Rec) then
            CreateCustomerOutbound(Rec, 'Create');
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure Customer_OnBeforeDeleteEvent(var Rec: Record Customer; RunTrigger: Boolean);
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not RunTrigger then exit;

        if FindCustomerFilters(Rec) then
            CreateCustomerOutbound(Rec, 'Delete');
    end;

    [EventSubscriber(ObjectType::Table, 18, 'OnAfterModifyEvent', '', false, false)]
    local procedure Customer_OnAfterModifyEvent(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean);
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not RunTrigger then exit;

        if FindCustomerFilters(Rec) then
            CreateCustomerOutbound(Rec, 'Update');
    end;

    [EventSubscriber(ObjectType::Table, 50072, 'OnAfterModifyEvent', '', false, false)]
    local procedure CustomerAtt_OnAfterModifyEvent(var Rec: Record "Customer Attributes FND"; var xRec: Record "Customer Attributes FND"; RunTrigger: Boolean);
    var
        Cust: Record Customer;
    begin
        if Rec.ISTEMPORARY then exit;
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if not RunTrigger then exit;

        if Cust.GET(Rec."Customer No.") then
            if FindCustomerFilters(Cust) then
                CreateCustomerOutbound(Cust, 'Update');
    end;

    local procedure _SalesOrder_();
    begin
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteSalesOrder(var Rec: Record "Sales Header"; RunTrigger: Boolean);
    var
        SellToCustomer: Record Customer;
    begin
        //>>HEI.02
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if Rec.ISTEMPORARY then
            exit;
        if not RunTrigger then
            exit;

        /*//HEI.20<<
        IF (Rec."Document Type" <> Rec."Document Type"::Order) OR NOT Rec."WMS Export FND" THEN EXIT;     //HEI.14
        CreateSalesOrderDeleteEntry(Rec);
        *///HEI.20>>
          //HEI.20<<
        if Rec."WMS Export FND" then
            case Rec."Document Type" of
                Rec."Document Type"::Order:
                    CreateSalesOrderDeleteEntry(Rec);
                Rec."Document Type"::"Return Order":
                    begin
                        SellToCustomer.RESET;
                        SellToCustomer.SETRANGE("No.", Rec."Sell-to Customer No.");
                        SellToCustomer.SETFILTER("Account Group FND", WMSInterfaceSetup."Customer Account Groups");
                        if SellToCustomer.FINDFIRST then
                            CreateSalesReturnOrderDeleteEntry(Rec);
                    end;
            end;
        //HEI.20>>

        //<<HEI.02

    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifySalesHeader(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; RunTrigger: Boolean);
    begin
        /*//<<HEI.14
        //>>HEI.02
        GetWMSInterfaceSetup;
        IF NOT WMSInterfaceSetup."WMS Integration" THEN EXIT;
        IF Rec.ISTEMPORARY THEN
          EXIT;
        IF NOT Rec."WMS Export"  THEN
          EXIT;
        IF Rec.Status = Rec.Status::Released THEN
          EXIT;
        IF NOT RunTrigger THEN
          EXIT;
        Rec."WMS Export" := FALSE;
        //<<HEI.02
        *///>>HEI.14

    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifySalesLine(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean);
    var
        SalesHeader: Record "Sales Header";
    begin
        /*//<<HEI.14
        //>>HEI.02
        GetWMSInterfaceSetup;
        IF NOT WMSInterfaceSetup."WMS Integration" THEN EXIT;
        IF Rec.ISTEMPORARY THEN
          EXIT;
        IF NOT RunTrigger THEN
          EXIT;
        SalesHeader.GET(Rec."Document Type",Rec."Document No.");
        IF NOT SalesHeader."WMS Export" THEN
          EXIT;
        SalesHeader."WMS Export" := FALSE;
        //SalesHeader.MODIFY;
        //<<HEI.02
        *///>>HEI.14

    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteSalesLine(var Rec: Record "Sales Line"; RunTrigger: Boolean);
    var
        SalesHeader: Record "Sales Header";
    begin
        /*//<<HEI.14
        //>>HEI.02
        GetWMSInterfaceSetup;
        IF NOT WMSInterfaceSetup."WMS Integration" THEN EXIT;
        IF Rec.ISTEMPORARY THEN
          EXIT;
        IF NOT RunTrigger THEN
          EXIT;
        SalesHeader.GET(Rec."Document Type",Rec."Document No.");
        IF NOT SalesHeader."WMS Export" THEN
          EXIT;
        SalesHeader."WMS Export" := FALSE;
        //SalesHeader.MODIFY;
        //<<HEI.02
        *///>>HEI.14

    end;

    [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseSalesOrder(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
    var
        SellToCustomer: Record Customer;
    begin
        //>>HEI.02
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if SalesHeader.ISTEMPORARY then
            exit;
        if PreviewMode then
            exit;

        /*//HEI.20<<
        IF SalesHeader."Document Type" <> SalesHeader."Document Type"::Order THEN
          EXIT;
        CreatesSalesOrderEntry(SalesHeader);
        *///HEI.20>>
          //HEI.20<<
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order:
                CreatesSalesOrderEntry(SalesHeader);
            SalesHeader."Document Type"::"Return Order":
                begin
                    SellToCustomer.RESET;
                    SellToCustomer.SETRANGE("No.", SalesHeader."Sell-to Customer No.");
                    SellToCustomer.SETFILTER("Account Group FND", WMSInterfaceSetup."Customer Account Groups");
                    if SellToCustomer.FINDFIRST then
                        CreatesSalesReturnOrderEntry(SalesHeader);
                end;
        end;
        //HEI.20>>
        //<<HEI.02

    end;

    procedure ProcessSalesOrderRequest(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        SalesHeader: Record "Sales Header";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //>>HEI.02
        GetWMSInterfaceSetup;
        WMSInterfaceSetup.TESTFIELD("Sales Order Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Sales Order Interface");
        if not InterfaceSetup.Enabled then
            exit;
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE(Status, SalesHeader.Status::Released);
        SalesHeader.SETRANGE("WMS Export FND", false);
        if SalesHeader.FINDSET then
            repeat
                CreatesSalesOrderEntry(SalesHeader);
            until SalesHeader.NEXT = 0;
        SalesHeader.MODIFYALL("WMS Export FND", true);
        //<<HEI.02
    end;

    local procedure CreateSalesOrderDeleteEntry(var SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        //>>HEI.02
        GetCompanyInformation;
        GetWMSInterfaceSetup;
        WMSInterfaceSetup.TESTFIELD("Sales Order Deletion Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Sales Order Deletion Interface");
        if not InterfaceSetup.Enabled then
            exit;

        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        //InterfaceEntryHeaderVIP."Message Name" := 'SUPODPBDB';
        InterfaceEntryHeaderVIP."Interface Code" := WMSInterfaceSetup."Sales Order Deletion Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Sales Header";
        InterfaceEntryHeaderVIP."Source No." := SalesHeader."No.";
        InterfaceEntryHeaderVIP."Location Code" := SalesHeader."Location Code";
        InterfaceEntryHeaderVIP.INSERT(true);
        //<<HEI.02
    end;

    local procedure CreatesSalesOrderEntry(var SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        Language: Record Language;
        ItemTranslation: Record "Item Translation";
        DefaultLanguageCode: Code[10];
        LineEntryNo: Integer;
    begin
        //>>HEI.02
        GetGeneralInterfaceSetup;
        GetCompanyInformation;
        GetWMSInterfaceSetup;
        if not InterfaceSetup.GET(WMSInterfaceSetup."Sales Order Interface") then exit;
        if not InterfaceSetup.Enabled then
            exit;
        if not CheckIfSalesLineExists(SalesHeader) then
            exit;
        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        //InterfaceEntryHeaderVIP."Message Name" := 'PREPA_B2B';
        InterfaceEntryHeaderVIP."Interface Code" := WMSInterfaceSetup."Sales Order Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Sales Header";
        InterfaceEntryHeaderVIP."Source Subtype" := SalesHeader."Document Type".AsInteger();
        InterfaceEntryHeaderVIP."Source No." := SalesHeader."No.";
        InterfaceEntryHeaderVIP."Location Code" := SalesHeader."Location Code";
        InterfaceEntryHeaderVIP."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
        InterfaceEntryHeaderVIP."External Document No." := SalesHeader."External Document No.";
        InterfaceEntryHeaderVIP."Document Date" := SalesHeader."Requested Delivery Date";
        InterfaceEntryHeaderVIP.Closed := GetReservationFlag(SalesHeader);//HEI.35
        InterfaceEntryHeaderVIP.INSERT(true);

        CreateSalesOrderLineEntry(InterfaceEntryHeaderVIP, SalesHeader);
        SalesHeader."WMS Export FND" := true;
        SalesHeader.MODIFY;
        //<<HEI.02
    end;

    local procedure CreateSalesOrderLineEntry(InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT"; SalesHeader: Record "Sales Header");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SalesLine: Record "Sales Line";
        NextEntryNo: Integer;
        ItemLine: Record Item;
        SalesLine2: Record "Sales Line";
        IncludeSalesLine: Boolean;
        ExcludeSalesLine: Boolean;
    begin
        //<<HEI.12
        SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine2.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine2.SETRANGE(Type, SalesLine2.Type::Item);
        if SalesLine2.FINDSET then
            repeat
                IncludeSalesLine := false;
                ExcludeSalesLine := false;
                if ItemsIncludeExclude.GET(SalesLine2."No.") then begin
                    if ItemsIncludeExclude.Included then
                        IncludeSalesLine := true;
                    if ItemsIncludeExclude.Excluded then
                        ExcludeSalesLine := true;
                end;

                if not ExcludeSalesLine then begin
                    //>>HEI.12
                    //>>HEI.02
                    //>>HEI.18
                    SalesLine.RESET;
                    //<<HEI.18
                    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                    SalesLine.SETRANGE("Line No.", SalesLine2."Line No.");     //HEI.12
                    SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                    //IF WMSInterfaceSetup."Item Category" <> '' THEN     //commented by HEI.12
                    if not IncludeSalesLine and (WMSInterfaceSetup."Item Category" <> '') then    //HEI.12
                        SalesLine.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                    if SalesLine.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineVIP);
                            InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            NextEntryNo := NextEntryNo + 1;
                            InterfaceEntryLineVIP."Entry No." := NextEntryNo;
                            InterfaceEntryLineVIP."Source Line No." := SalesLine."Line No.";
                            InterfaceEntryLineVIP.Type := SalesLine.Type.AsInteger();
                            //InterfaceEntryLineVIP."No." := SalesLine."No.";
                            //InterfaceEntryLineVIP."Source Type" := SalesLine."Document Type";
                            //InterfaceEntryLineVIP."Source No." := SalesLine."Document No.";
                            InterfaceEntryLineVIP."Item Code" := SalesLine."No.";
                            InterfaceEntryLineVIP."No." := SalesLine."Document No.";
                            InterfaceEntryLineVIP."Location Code" := SalesLine."Location Code";
                            InterfaceEntryLineVIP.Quantity := ConvertToReflexPcs(SalesLine);
                            InterfaceEntryLineVIP."Currency Code" := SalesHeader."Sell-to Customer No.";
                            InterfaceEntryLineVIP.Description := SalesHeader."External Document No.";
                            //InterfaceEntryLineVIP."Expected Delivery Date" := SalesHeader."Requested Delivery Date";    //commented by HEI.23
                            InterfaceEntryLineVIP."Payment Terms Code" := FORMAT(SalesHeader."Requested Delivery Date", 0, '<Year4><Month,2><Day,2>');  //HEI.23
                            InterfaceEntryLineVIP."Traceability Code" := SalesLine."Bin Code";
                            InterfaceEntryLineVIP.Quantity := SalesLine."Quantity (Base)";
                            /*//>>HEI.11
                            InterfaceEntryLineVIP.Name := SalesHeader."Ship-to Name";
                            InterfaceEntryLineVIP.Address := SalesHeader."Ship-to Address";
                            InterfaceEntryLineVIP."Address 2" := SalesHeader."Ship-to Address 2";
                            *///<<HEI.11
                              //>>HEI.11
                            InterfaceEntryLineVIP.Name := COPYSTR(SalesHeader."Ship-to Name", 1, 30);
                            InterfaceEntryLineVIP.Address := COPYSTR(SalesHeader."Ship-to Address", 1, 40);
                            InterfaceEntryLineVIP."Address 2" := COPYSTR(SalesHeader."Ship-to Address 2", 1, 40);
                            //<<HEI.11
                            InterfaceEntryLineVIP.City := SalesHeader."Ship-to City";
                            InterfaceEntryLineVIP."Post Code" := SalesHeader."Ship-to Post Code";
                            InterfaceEntryLineVIP.Closed := InterfaceEntryHeaderOut.Closed;//HEI.36
                            InterfaceEntryLineVIP.INSERT(true);
                        until SalesLine.NEXT = 0;
                    //<<HEI.02
                    //<<HEI.12
                end;
            until SalesLine2.NEXT = 0;
        //>>HEI.12

    end;

    local procedure CheckIfSalesLineExists(SalesHeader: Record "Sales Header"): Boolean;
    var
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        IncludeSalesLine: Boolean;
        ExcludeSalesLine: Boolean;
    begin
        //>>HEI.02
        GetWMSInterfaceSetup;
        /*//<<commented by HEI.12
        SalesLine.SETRANGE("Document Type",SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.",SalesHeader."No.");
        SalesLine.SETRANGE(Type,SalesLine.Type::Item);
        IF WMSInterfaceSetup."Item Category" <> ''  THEN
          SalesLine.SETFILTER("Item Category Code",WMSInterfaceSetup."Item Category");
        EXIT(NOT SalesLine.ISEMPTY);
        *///>> commented by HEI.12
        //<<HEI.02
        //<<HEI.12
        SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine2.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine2.SETRANGE(Type, SalesLine2.Type::Item);
        if SalesLine2.FINDSET then begin
            repeat
                ItemsIncludeExclude.RESET;
                if ItemsIncludeExclude.GET(SalesLine2."No.") then begin
                    if ItemsIncludeExclude.Included then
                        exit(true);
                end else begin
                    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                    SalesLine.SETRANGE("Line No.", SalesLine2."Line No.");
                    if WMSInterfaceSetup."Item Category" <> '' then
                        SalesLine.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                    if SalesLine.FINDFIRST then
                        exit(true);
                end;
            until SalesLine2.NEXT = 0;
            exit(false);
        end else
            exit(false);
        //>>HEI.12

    end;

    local procedure ConvertToReflexPcs(SalesLine: Record "Sales Line"): Decimal;
    var
        SalesItemUnitOfMeasure: Record "Item Unit of Measure";
        ReflexItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        //>>HEI.02
        GetWMSInterfaceSetup;
        if (SalesLine."Unit of Measure Code" <> '') and (WMSInterfaceSetup."Reflex 1st OUM" <> '') then begin

            ReflexItemUnitOfMeasure.GET(SalesLine."No.", WMSInterfaceSetup."Reflex 1st OUM");

            SalesItemUnitOfMeasure.GET(SalesLine."No.", SalesLine."Unit of Measure Code");

            exit(ROUND((ROUND((SalesItemUnitOfMeasure."Qty. per Unit of Measure" /
              ReflexItemUnitOfMeasure."Qty. per Unit of Measure"), 1, '=') * SalesLine.Quantity), 1, '='));

        end;

        exit(SalesLine.Quantity);
        //<<HEI.02
    end;

    local procedure GetReservationFlag(SalesHeader: Record "Sales Header"): Boolean;
    var
        WMSSourceSystemIdentifier: Record "WMS Source Sys ID FND";
    begin
        //HEI.35>>
        GetSalesSetup;
        if SalesSetup."EDI Nos. FND" = SalesHeader."No. Series" then begin
            WMSSourceSystemIdentifier.SETRANGE("EDI System Identifier", true);
            if WMSSourceSystemIdentifier.FINDFIRST then
                exit(WMSSourceSystemIdentifier."Reservation Indicator")
            else
                exit(false);
        end;
        if not WMSSourceSystemIdentifier.GET(SalesHeader."Source System Identifier FND") then
            exit(false);

        exit(WMSSourceSystemIdentifier."Reservation Indicator");
        //HEI.35<<
    end;

    local procedure _SalesOrderShipment_();
    begin
    end;

    procedure ProcessWhsShpmntRequestTC(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        WhseShptHeader: Record "Warehouse Shipment Header";
        GetSourceDocuments: Report "Get Source Documents";
        WhseRqst: Record "Warehouse Request";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SOBuffer: Record "Aging Band Buffer" temporary;
        SalesHeader: Record "Sales Header";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        Location: Record Location;
        LocationCode: Text;
        lrWhseSourceFilterBuffer: Record "Warehouse Source Filter";
        WhseSetup: Record "Warehouse Setup";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        SalesLine: Record "Sales Line";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        WhsePostShipment: Codeunit "Whse.-Post Shipment";
        SalesPost: Codeunit "Sales-Post";
        TotalQtyfromFile: Decimal;
        StoreFirstBin: Code[20];
        QuantitySalesUOM: Decimal;
        ResEntry1: Record "Reservation Entry";
        WhseShipLineLast: Record "Warehouse Shipment Line";
        LotNo: Code[20];
        LotNoInfo: Record "Lot No. Information";
        AllowPosting: Boolean;
        Qty: Decimal;
        ExtDoc: Text[35];
        ErrorText001: Label 'Warehouse Shipment was created but could not be posted due to error on the lines.';
        ErrorText002: Label 'Warehouse Request is missing.';
        TempBool: Boolean;//BC UPGARADE KUMARR78 ++14-05-2026 

    begin
        //HEI.25<<
        GetWMSInterfaceSetup;

        WMSInterfaceSetup.TESTFIELD("Warehouse Shipment Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Warehouse Shipment Interface");
        if not InterfaceSetup.Enabled then
            exit;

        WhseShptHeader.INIT;
        WhseShptHeader.VALIDATE("No.");
        WhseShptHeader.INSERT(true);
        WhseShptHeader.VALIDATE("Location Code", InterfaceEntryHeaderVIP."Location Code");
        WhseShptHeader."WMS Import FND" := true;
        // WhseShptHeader.VALIDATE("External Document No.", InterfaceEntryHeaderVIP."Source No.");  //HEI.34 Code Commented
        /*//HEI.29<<
        WhseShptHeader.VALIDATE("Driver Code", InterfaceEntryHeaderVIP."Buy-from Vendor No.");
        WhseShptHeader.VALIDATE("Truck Code", InterfaceEntryHeaderVIP."Sell-to Customer No.");
        *///HEI.29>>
        WhseShptHeader.VALIDATE("Shipping Agent Code", InterfaceEntryHeaderVIP."Currency Code");
        WhseShptHeader.VALIDATE("Shipping Agent Service Code", InterfaceEntryHeaderVIP."Pay-to Vendor No.");
        //HEI.29<<
        //BC Upgrade GUNREM01 DIT fields >>
        // WhseShptHeader.VALIDATE("Truck Code", InterfaceEntryHeaderVIP."Sell-to Customer No.");
        // WhseShptHeader.VALIDATE("Driver Code", InterfaceEntryHeaderVIP."Buy-from Vendor No.");
        //BC Upgrade GUNREM01 DIT fields <<
        //HEI.29>>
        //HEI.34 >>
        //BC UPGRADE KUMARR78 ++11-05-2026 >>
        WhseShptHeader.Validate("Vehicle Code 101FDW", InterfaceEntryHeaderVIP."Sell-to Customer No.");
        WhseShptHeader.Validate("Log Driver 107FDW", InterfaceEntryHeaderVIP."Buy-from Vendor No.");
        //BC UPGRADE KUMARR78 ++11-05-2026 <<
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDFIRST then begin
            if SalesHeader.GET(SalesHeader."Document Type"::Order, InterfaceEntryLineVIP."Item Code") then begin
                WhseShptHeader.VALIDATE("Shipment Date", SalesHeader."Shipment Date");
                WhseShptHeader.VALIDATE("Posting Date", SalesHeader."Posting Date");
            end;
        end;
        //HEI.34 <<
        WhseShptHeader.MODIFY(true);

        SOBuffer.DELETEALL;
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDSET then
            repeat
                if not SOBuffer.GET(InterfaceEntryLineVIP."Item Code") then begin
                    //SalesHeader.GET(SalesHeader."Document Type"::Order,InterfaceEntryLineVIP."Item Code");  //commented by HEI.28
                    if SalesHeader.GET(SalesHeader."Document Type"::Order, InterfaceEntryLineVIP."Item Code") then begin     //HEI.28
                        SOBuffer."Currency Code" := InterfaceEntryLineVIP."Item Code";
                        SOBuffer.INSERT;
                        //TESTFIELD(Status,Status::Released);   //commented by HEI.28
                        GetSourceDocOutbound.CheckSalesHeader(SalesHeader, true);
                        WhseRqst.SETRANGE(Type, WhseRqst.Type::Outbound);
                        WhseRqst.SETRANGE("Source Type", DATABASE::"Sales Line");
                        WhseRqst.SETRANGE("Source Subtype", SalesHeader."Document Type");
                        WhseRqst.SETRANGE("Source No.", SalesHeader."No.");
                        WhseRqst.SETRANGE("Document Status", WhseRqst."Document Status"::Released);
                        CLEAR(LocationCode);
                        if WhseRqst.FINDSET then begin
                            repeat
                                if Location.RequireShipment(WhseRqst."Location Code") then
                                    LocationCode += WhseRqst."Location Code" + '|';
                            until WhseRqst.NEXT = 0;
                            if LocationCode <> '' then
                                LocationCode := COPYSTR(LocationCode, 1, STRLEN(LocationCode) - 1);
                            WhseRqst.SETFILTER("Location Code", LocationCode);
                        end;

                        /*//commented by HEI.28
                        IF WhseRqst.ISEMPTY THEN
                          ERROR(ErrorText002);
                        *///commented by HEI.28

                        if not WhseRqst.ISEMPTY then begin  //HEI.28
                            CLEAR(GetSourceDocuments);
                            GetSourceDocuments.SetOneCreatedShptHeader(WhseShptHeader);
                            //  lrWhseSourceFilterBuffer.SetCopyDefaultFromWhseSetup(); 
                            //   GetSourceDocuments.SetWhseSourceFilter(lrWhseSourceFilterBuffer); //BC Upgrade GUNREM01 -DIT function 
                            WhseSetup.GET();
                            // GetSourceDocuments.SetCreateMultiWhseHeader(0); //BC Upgrade GUNREM01 -DIT function
                            //   GetSourceDocuments.SetWhseHeaderPerPhysLoc(WhseSetup."Whse. Doc. per Phys. Location"); //BC Upgrade GUNREM01 -DIT function
                            GetSourceDocuments.SetSkipBlocked(true);
                            GetSourceDocuments.USEREQUESTPAGE(false);
                            GetSourceDocuments.SETTABLEVIEW(WhseRqst);
                            GetSourceDocuments.SetHideDialog(true);
                            GetSourceDocuments.RUNMODAL;

                            WhseShptHeader."Document Status" := WhseShptHeader.GetDocumentStatus(0);
                            WhseShptHeader.MODIFY;
                        end;  //HEI.28
                    end;  //HEI.28
                end;
            until InterfaceEntryLineVIP.NEXT = 0;

        WarehouseShipmentLine.RESET;
        WarehouseShipmentLine.SETRANGE("No.", WhseShptHeader."No.");
        if WarehouseShipmentLine.FINDSET then
            repeat
                WarehouseShipmentLine.VALIDATE("Qty. to Ship", 0);
                WarehouseShipmentLine.MODIFY;

                //HEI.28<<
                ResEntry1.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line");
                ResEntry1.SETRANGE("Source ID", WarehouseShipmentLine."Source No.");
                ResEntry1.SETRANGE("Source Ref. No.", WarehouseShipmentLine."Source Line No.");
                ResEntry1.SETRANGE("Source Type", 37);
                ResEntry1.SETRANGE("Source Subtype", WarehouseShipmentLine."Source Document");
                ResEntry1.SETRANGE("Source Batch Name", '');
                ResEntry1.SETRANGE("Source Prod. Order Line", 0);
                ResEntry1.DELETEALL;
            //HEI.28>>
            until WarehouseShipmentLine.NEXT = 0;

        AllowPosting := true;
        InterfaceEntryLineVIP.RESET;
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDSET then
            repeat
                WarehouseShipmentLine.RESET;
                WarehouseShipmentLine.SETRANGE("No.", WhseShptHeader."No.");
                WarehouseShipmentLine.SETRANGE("Source No.", InterfaceEntryLineVIP."Item Code");
                WarehouseShipmentLine.SETRANGE("Source Line No.", InterfaceEntryLineVIP."Source Line No.");
                WarehouseShipmentLine.SETRANGE("Item No.", InterfaceEntryLineVIP."No.");
                if WarehouseShipmentLine.FINDFIRST then begin
                    /*//HEI.28
                    ResEntry1.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line");
                    ResEntry1.SETRANGE("Source ID",WarehouseShipmentLine."Source No.");
                    ResEntry1.SETRANGE("Source Ref. No.",WarehouseShipmentLine."Source Line No.");
                    ResEntry1.SETRANGE("Source Type",37);
                    ResEntry1.SETRANGE("Source Subtype",WarehouseShipmentLine."Source Document");
                    ResEntry1.SETRANGE("Source Batch Name",'');
                    ResEntry1.SETRANGE("Source Prod. Order Line",0);
                    IF ResEntry1.FINDFIRST THEN
                      ResEntry1.DELETEALL;
                    *///HEI.28

                    TotalQtyfromFile := 0;
                    StoreFirstBin := InterfaceEntryLineVIP."Location Code";
                    QuantitySalesUOM := ConvertToSalesUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", WarehouseShipmentLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                    TotalQtyfromFile += QuantitySalesUOM;
                    //Lot check depending on setup
                    if (InterfaceEntryLineVIP.Quantity > 0) and Item.GET(WarehouseShipmentLine."Item No.") then begin
                        if (Item."Item Tracking Code" <> '') then begin
                            if ItemTrackingCode.GET(Item."Item Tracking Code") then begin
                                if (ItemTrackingCode."Lot Purchase Outbound Tracking") and (ItemTrackingCode."Lot Sales Outbound Tracking") and (ItemTrackingCode."Lot Pos. Adjmt. Outb. Tracking")
                                  and (ItemTrackingCode."Lot Neg. Adjmt. Outb. Tracking") and (ItemTrackingCode."Lot Manuf. Outbound Tracking") then
                                    LotNo := InterfaceEntryLineVIP."Post Code"
                                else
                                    LotNo := '';
                                LotNoInfo.RESET;
                                if CheckLotTC(LotNoInfo, InterfaceEntryLineVIP, WarehouseShipmentLine."Source No.", '', WarehouseShipmentLine."Source Line No.", 37, WarehouseShipmentLine."Source Document".AsInteger(),
                                  WarehouseShipmentLine."Item No.", WarehouseShipmentLine."Variant Code", WhseShptHeader."Location Code", WarehouseShipmentLine."Unit of Measure Code",
                                  WarehouseShipmentLine.Description, WarehouseShipmentLine."Shipment Date", LotNo, ConvertToBaseUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity))
                                then begin
                                    WarehouseShipmentLine.VALIDATE("Zone Code", InterfaceEntryLineVIP."External Contract No.");  //HEI.28
                                    WarehouseShipmentLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Location Code");
                                    WarehouseShipmentLine.VALIDATE("Qty. to Ship", WarehouseShipmentLine."Qty. to Ship" + QuantitySalesUOM);
                                    //BC Upgrade GUNREM01 DIT Fields used >>
                                    // ExtDoc := WarehouseShipmentLine."External Document No.";
                                    // WarehouseShipmentLine."External Document No." := LotNo;
                                    // Qty := WarehouseShipmentLine."Cubage to Ship";
                                    // WarehouseShipmentLine."Cubage to Ship" := InterfaceEntryLineVIP.Quantity;
                                    //BC Upgrade GUNREM01 DIT Fields used >>
                                    //BC UPGRADE KUMARR78 ++13-05-2026 >>
                                    Qty := WarehouseShipmentLine."Cubag To Ship FND";
                                    WarehouseShipmentLine."Cubag To Ship FND" := InterfaceEntryLineVIP.Quantity;

                                    ExtDoc := WarehouseShipmentLine."External Document No. FND";
                                    WarehouseShipmentLine."External Document No. FND" := LotNo;
                                    //BC UPGRADE KUMARR78 ++13-05-2026 <<
                                    WarehouseShipmentLine.MODIFY;

                                    COMMIT;
                                    // if CODEUNIT.RUN(50109, WarehouseShipmentLine) then begin //BC UPGRADE KUMARR78 --12-05-2026
                                    if Codeunit.Run(58055, WarehouseShipmentLine) then begin
                                        //BC UPGRADE KUMARR78 ++12-05-2026
                                        //BC Upgrade GUNREM01 DIT Fields used >>
                                        // WarehouseShipmentLine."Cubage to Ship" := Qty;
                                        // WarehouseShipmentLine."External Document No." := ExtDoc;
                                        //BC Upgrade GUNREM01 DIT Fields used <<
                                        //BC UPGRADE KUMARR78 >> 13-05-2026 >>
                                        WarehouseShipmentLine."Cubag To Ship FND" := Qty;
                                        WarehouseShipmentLine."External Document No. FND" := ExtDoc;
                                        //BC UPGRADE KUMARR78 >> 13-05-2026 <<
                                        WarehouseShipmentLine.MODIFY;
                                    end else begin
                                        WarehouseShipmentLine.DELETE;

                                        WhseShipLineLast.RESET;
                                        WhseShipLineLast."No." := WhseShptHeader."No.";
                                        WhseShipLineLast.SETRANGE("No.", WhseShipLineLast."No.");
                                        if WhseShipLineLast.FINDLAST then;

                                        WhseShipLineLast.INIT;
                                        WhseShipLineLast."Line No." := WhseShipLineLast."Line No." + 10000;
                                        WhseShipLineLast."Source Type" := DATABASE::"Sales Line";
                                        WhseShipLineLast."Source Document" := WhseShipLineLast."Source Document"::"Sales Order";
                                        WhseShipLineLast."Source Subtype" := 1;
                                        WhseShipLineLast."Source No." := InterfaceEntryLineVIP."Item Code";
                                        WhseShipLineLast.Description := COPYSTR(GETLASTERRORTEXT, 1, 50);
                                        WhseShipLineLast.INSERT;
                                        AllowPosting := false;
                                    end;
                                end
                                else begin
                                    WarehouseShipmentLine.DELETE;

                                    WhseShipLineLast.RESET;
                                    WhseShipLineLast."No." := WhseShptHeader."No.";
                                    WhseShipLineLast.SETRANGE("No.", WhseShipLineLast."No.");
                                    if WhseShipLineLast.FINDLAST then;

                                    WhseShipLineLast.INIT;
                                    WhseShipLineLast."Line No." := WhseShipLineLast."Line No." + 10000;
                                    WhseShipLineLast."Source Type" := DATABASE::"Sales Line";
                                    WhseShipLineLast."Source Document" := WhseShipLineLast."Source Document"::"Sales Order";
                                    WhseShipLineLast."Source Subtype" := 1;
                                    WhseShipLineLast."Source No." := InterfaceEntryLineVIP."Item Code";
                                    WhseShipLineLast.Description := COPYSTR(GETLASTERRORTEXT, 1, 50);
                                    WhseShipLineLast.INSERT;
                                    AllowPosting := false;
                                end;
                            end;
                        end else begin    //HEI.31 >>
                            if CheckZoneBinTC(InterfaceEntryLineVIP, WhseShptHeader."Location Code") then begin    //HEI.32 >>
                                WarehouseShipmentLine.VALIDATE("Zone Code", InterfaceEntryLineVIP."External Contract No.");
                                WarehouseShipmentLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Location Code");
                                WarehouseShipmentLine.VALIDATE("Qty. to Ship", WarehouseShipmentLine."Qty. to Ship" + QuantitySalesUOM);
                                WarehouseShipmentLine.MODIFY;
                                //HEI.32 >>
                            end else begin
                                WarehouseShipmentLine.DELETE;

                                WhseShipLineLast.RESET;
                                WhseShipLineLast."No." := WhseShptHeader."No.";
                                WhseShipLineLast.SETRANGE("No.", WhseShipLineLast."No.");
                                if WhseShipLineLast.FINDLAST then;

                                WhseShipLineLast.INIT;
                                WhseShipLineLast."Line No." := WhseShipLineLast."Line No." + 10000;
                                WhseShipLineLast."Source Type" := DATABASE::"Sales Line";
                                WhseShipLineLast."Source Document" := WhseShipLineLast."Source Document"::"Sales Order";
                                WhseShipLineLast."Source Subtype" := 1;
                                WhseShipLineLast."Source No." := InterfaceEntryLineVIP."Item Code";
                                WhseShipLineLast.Description := COPYSTR(GETLASTERRORTEXT, 1, 50);
                                WhseShipLineLast.INSERT;
                                AllowPosting := false;
                            end;
                            //HEI.32 <<
                        end;
                        //HEI.31 <<
                    end;
                end else begin
                    WhseShipLineLast.RESET;
                    WhseShipLineLast."No." := WhseShptHeader."No.";
                    WhseShipLineLast.SETRANGE("No.", WhseShipLineLast."No.");
                    if WhseShipLineLast.FINDLAST then;

                    WhseShipLineLast.INIT;
                    WhseShipLineLast."Line No." := WhseShipLineLast."Line No." + 10000;
                    WhseShipLineLast."Source Type" := DATABASE::"Sales Line";
                    WhseShipLineLast."Source Document" := WhseShipLineLast."Source Document"::"Sales Order";
                    WhseShipLineLast."Source Subtype" := 1;
                    WhseShipLineLast."Source No." := InterfaceEntryLineVIP."Item Code";
                    WhseShipLineLast.Description := COPYSTR(InterfaceEntryLineVIP."Item Code" + '/' + FORMAT(InterfaceEntryLineVIP."Source Line No.") + ' ' + InterfaceEntryLineVIP."No." + ' not found or not Released', 1, 50);
                    WhseShipLineLast.INSERT;
                    AllowPosting := false;
                end;
            until InterfaceEntryLineVIP.NEXT = 0;

        WarehouseShipmentLine.RESET;
        WarehouseShipmentLine.SETRANGE("No.", WhseShptHeader."No.");
        WarehouseShipmentLine.SETFILTER("Qty. to Ship", '%1', 0);
        WarehouseShipmentLine.SETFILTER("Item No.", '<>%1', '');
        WarehouseShipmentLine.DELETEALL;

        if AllowPosting then begin
            if WMSInterfaceSetup."Post Inb. Shipment Interface" = WMSInterfaceSetup."Post Inb. Shipment Interface"::"Ship &Invoice" then
                WhsePostShipment.SetPostingSettings(true);
            COMMIT;
            //BC UPGARADE KUMARR78 ++14-05-2026 >>
            TempBool := WhsePostShipment.Run(WarehouseShipmentLine);
            //BC UPGARADE KUMARR78 ++14-05-2026 <<
            if not TempBool then begin //BC UPGARADE KUMARR78 ++14-05-2026 >>
                // if not WhsePostShipment.Run(WarehouseShipmentLine); //BC UPGARADE KUMARR78 --14-05-2026 >>
                WhseShptHeader.GET(WarehouseShipmentLine."No.");
                WhseShptHeader.DELETE(true);
                COMMIT;
                ERROR(GETLASTERRORTEXT);
            end;
        end else begin
            InterfaceEntryHeaderVIP."Error Message" := COPYSTR(ErrorText001, 1, MAXSTRLEN(InterfaceEntryHeaderVIP."Error Message"));
            InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Error;
            InterfaceEntryHeaderVIP.MODIFY;
            InterfaceFrameworkMgtVIP.LogInterfaceEntries(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
        end;
        //HEI.25>>

    end;

    [TryFunction]
    local procedure CheckLotTC(var pLotNoRec: Record "Lot No. Information"; InterfaceEntryLine: Record "Interface Entry Line VIP INT"; pSourceNo: Code[20]; pSourceBatch: Code[10]; pSourceLineNo: Integer; pSourceType: Integer; pSourceSubtype: Integer; pItemNo: Code[20]; pVariantCode: Code[20]; pLocationCode: Code[10]; pUnitOfMeasureCode: Code[10]; pDescription: Text[50]; pShipmentDate: Date; pLotNo: Code[20]; pQuantity: Integer);
    var
        LotNoInfo: Record "Lot No. Information";
        ResEntry: Record "Reservation Entry";
        Customer: Record Customer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        QtyToShipBase: Decimal;
        RemQtyToShipBase: Decimal;
        AvailLotQty: Decimal;
        ReservedQty: Decimal;
        SerialNo: Code[20];
        QtyPerUOM: Integer;
        Err000: Label 'Lot not available in NAV.';
        Err001: Label 'Lot is blocked.';
        Bin: Record Bin;
        Zone: Record Zone;
        Err002: Label 'Lot quality issue.';
        Err003: Label 'Lot: %1 Issue-Item: %2';
    begin
        //HEI.25<<
        LotNoInfo.RESET;
        // LotNoInfo.SETCURRENTKEY("Item No.", "Variant Code", "Quality Status"); //BC Upgrade GUNREM01 -Quality Status is DIT field
        LotNoInfo.SETRANGE("Item No.", pItemNo);
        if pLotNo <> '' then
            LotNoInfo.SETRANGE(LotNoInfo."Lot No.", pLotNo);
        //IF LotNoInfo.COUNT = 0 THEN   //HEI.28
        if LotNoInfo.ISEMPTY then     //HEI.28
                                      //ERROR(Err000 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.",InterfaceEntryLine."Location Code",pQuantity,pUnitOfMeasureCode,InterfaceEntryLine."Source Line No.");  //HEI.30
            ERROR(Err003, pLotNo, pItemNo);  //HEI.30
        LotNoInfo.SETRANGE(LotNoInfo.Blocked, false);
        //IF LotNoInfo.COUNT = 0 THEN   //HEI.28
        if LotNoInfo.ISEMPTY then     //HEI.28
            ERROR(Err001 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        //HEI.28<<
        //BC Upgrade GUNREM01 -Quality Status is DIT field >>
        // LotNoInfo.SETFILTER("Quality Status", '%1|%2', LotNoInfo."Quality Status"::Pass, LotNoInfo."Quality Status"::Quarantine);
        // if LotNoInfo.ISEMPTY then
        //     ERROR(Err002 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        //BC Upgrade GUNREM01 -Quality Status is DIT field <<
        //HEI.28>>
        LotNoInfo.SETFILTER("Date Filter", '%1..%2', 00000101D, TODAY);  //HEI.33
        // LotNoInfo.SETRANGE("Date Filter",0D,TODAY);  //HEI.33 Code Commented
        if not LotNoInfo.FINDSET then
            //ERROR(Err000 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.",InterfaceEntryLine."Location Code",pQuantity,pUnitOfMeasureCode,InterfaceEntryLine."Source Line No.");  //HEI.30
            ERROR(Err003, pLotNo, pItemNo);  //HEI.30
        pLotNoRec.COPY(LotNoInfo);

        //Bin.GET(pLocationCode,InterfaceEntryLine."Location Code");  //HEI.28
        //HEI.28<<
        Zone.GET(pLocationCode, InterfaceEntryLine."External Contract No.");
        Bin.RESET;
        Bin.SETRANGE("Location Code", pLocationCode);
        Bin.SETRANGE("Zone Code", Zone.Code);
        Bin.SETRANGE(Code, InterfaceEntryLine."Location Code");
        Bin.FINDFIRST;
        //HEI.28>>
        //HEI.25>>
    end;

    procedure CreateReservationEntriesTC(InterfaceEntryLineQuantity: Decimal; pSourceNo: Code[20]; pSourceBatch: Code[10]; pSourceLineNo: Integer; pSourceType: Integer; pSourceSubtype: Integer; pItemNo: Code[20]; pVariantCode: Code[20]; pLocationCode: Code[10]; pUnitOfMeasureCode: Code[10]; pDescription: Text[50]; pShipmentDate: Date; pLotNo: Code[20]; pQuantity: Integer);
    var
        LotNoInfo: Record "Lot No. Information";
        ResEntry: Record "Reservation Entry";
        Customer: Record Customer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        QtyToShipBase: Decimal;
        RemQtyToShipBase: Decimal;
        AvailLotQty: Decimal;
        ReservedQty: Decimal;
        SerialNo: Code[20];
        QtyPerUOM: Integer;
        Err000: Label 'Lot not available in NAV.';
        Err001: Label 'Lot is blocked.';
    begin
        //HEI.25<<
        LotNoInfo.RESET;
        //  LotNoInfo.SETCURRENTKEY("Item No.", "Variant Code", "Quality Status"); //BC Upgrade GUNREM01 -Quality Status is DIT field
        LotNoInfo.SETRANGE("Item No.", pItemNo);
        if pLotNo <> '' then
            LotNoInfo.SETRANGE(LotNoInfo."Lot No.", pLotNo);
        LotNoInfo.SETRANGE(LotNoInfo.Blocked, false);
        LotNoInfo.SETFILTER("Date Filter", '%1..%2', 00000101D, TODAY); //HEI.33
        // LotNoInfo.SETRANGE("Date Filter",0D,TODAY);  //HEI.33 Code Commented
        if LotNoInfo.FINDLAST then begin
            QtyToShipBase := pQuantity;
            RemQtyToShipBase := QtyToShipBase;
            // Cycle through Available Lots
            repeat
                LotNoInfo.CALCFIELDS(Inventory, "Expired Inventory");
                if (LotNoInfo.Inventory - LotNoInfo."Expired Inventory") > 0 then begin
                    //Calculate Available Qty to Ship
                    CLEAR(ReservedQty);
                    ResEntry.RESET;
                    ResEntry.SETCURRENTKEY("Item No.", "Variant Code", "Location Code", "Item Tracking", "Reservation Status", "Lot No.", "Serial No.");
                    ResEntry.SETRANGE("Item No.", pItemNo);
                    ResEntry.SETRANGE("Variant Code", pVariantCode);
                    ResEntry.SETRANGE("Location Code", pLocationCode);
                    ResEntry.SETFILTER("Reservation Status", '%1|%2', 2, 3);    //Surplus, Prospect
                    ResEntry.SETRANGE("Lot No.", LotNoInfo."Lot No.");
                    ResEntry.SETRANGE(Positive, false);
                    if ResEntry.FINDSET then
                        repeat
                            ReservedQty += ResEntry."Quantity (Base)";
                        until ResEntry.NEXT = 0;
                    AvailLotQty := LotNoInfo.Inventory - LotNoInfo."Expired Inventory" + ReservedQty;
                    AvailLotQty := CalcRoundedQty(AvailLotQty, LotNoInfo."Item No.", pUnitOfMeasureCode);

                    //Adjust Qty to Ship
                    if AvailLotQty > RemQtyToShipBase then begin
                        QtyToShipBase := RemQtyToShipBase;
                        RemQtyToShipBase := 0;
                    end else begin
                        if AvailLotQty < 0 then
                            QtyToShipBase := 0
                        else begin
                            QtyToShipBase := AvailLotQty;
                            RemQtyToShipBase := RemQtyToShipBase - AvailLotQty;
                        end;
                    end;
                    if ItemUnitofMeasure.GET(pItemNo, pUnitOfMeasureCode) then
                        QtyPerUOM := ItemUnitofMeasure."Qty. per Unit of Measure"
                    else
                        QtyPerUOM := 1;
                    if QtyToShipBase > 0 then begin
                        //BC Upgrade GUNREM01 Changed the Reservation enrty Parameter >>
                        // CreateReservEntry.CreateReservEntryFor(pSourceType, pSourceSubtype, pSourceNo, pSourceBatch, 0, pSourceLineNo, QtyPerUOM, InterfaceEntryLineQuantity, QtyToShipBase, SerialNo,
                        //                                         LotNoInfo."Lot No.");
                        CreateReservEntry.CreateReservEntryFor(pSourceType, pSourceSubtype, pSourceNo, pSourceBatch, 0, pSourceLineNo, QtyPerUOM, InterfaceEntryLineQuantity, QtyToShipBase, ResEntry);
                        //BC Upgrade GUNREM01 Changed the Reservation enrty Parameter <<
                        CreateReservEntry.CreateEntry(pItemNo, pVariantCode, pLocationCode, pDescription, 0D, pShipmentDate, 0, enumvalue::Prospect);
                    end;
                end;
            until (LotNoInfo.NEXT(-1) = 0) or (RemQtyToShipBase = 0);
        end
        //HEI.25>>
    end;

    procedure ProcessWhsShpmntRequest(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        SalesHeader: Record "Sales Header";
        Location: Record Location;
    begin
        //OBSOLETE   //HEI.25
        //>>HEI.02
        GetWMSInterfaceSetup;

        WMSInterfaceSetup.TESTFIELD("Warehouse Shipment Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Warehouse Shipment Interface");
        if not InterfaceSetup.Enabled then
            exit;

        SalesHeader.GET(SalesHeader."Document Type"::Order, InterfaceEntryHeaderVIP."Source No.");

        // if (InterfaceEntryHeaderVIP."Buy-from Vendor No." <> '') then
        //     SalesHeader."Driver Code" := InterfaceEntryHeaderVIP."Buy-from Vendor No."; //BC Upgrade GUNREM01 -DIT Field
        if (InterfaceEntryHeaderVIP."Currency Code" <> '') then
            SalesHeader."Shipping Agent Code" := InterfaceEntryHeaderVIP."Currency Code";
        // if (InterfaceEntryHeaderVIP."Sell-to Customer No." <> '') then
        //     SalesHeader."Truck Code" := InterfaceEntryHeaderVIP."Sell-to Customer No."; //BC Upgrade GUNREM01 -DIT Field
        if InterfaceEntryHeaderVIP."Pay-to Vendor No." <> '' then
            SalesHeader."Shipping Agent Service Code" := InterfaceEntryHeaderVIP."Pay-to Vendor No.";
        SalesHeader.MODIFY;
        Location.GET(SalesHeader."Location Code");
        if Location."Require Shipment" then
            CreateAndPostWhsShpmnt(SalesHeader, InterfaceEntryHeaderVIP)
        else
            PostSOShipment(SalesHeader, InterfaceEntryHeaderVIP);
        //<<HEI.02
    end;

    local procedure CreateAndPostWhsShpmnt(var pSalesHeader: Record "Sales Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SalesLine: Record "Sales Line";
        Location: Record Location;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        WhsePostShipment: Codeunit "Whse.-Post Shipment";
        SalesPost: Codeunit "Sales-Post";
        TotalQtyfromFile: Decimal;
        GetWhseShpNo: Code[20];
        StoreFirstBin: Code[20];
        QuantitySalesUOM: Decimal;
        ResEntry1: Record "Reservation Entry";
    begin
        //>>HEI.02
        //CSO
        WarehouseShipmentHeader.SETRANGE("Source No. FND", pSalesHeader."No.");
        if WarehouseShipmentHeader.FINDSET then
            WarehouseShipmentHeader.DELETE(true);
        //cso
        // GetSourceDocOutbound.Fct_Batchprocessing(true); //BC Upgrade GUNREM01 -DIT function 
        GetSourceDocOutbound.CreateFromSalesOrder(pSalesHeader);

        WarehouseShipmentLine.RESET;
        WarehouseShipmentLine.SETRANGE("Source No.", pSalesHeader."No.");
        if WarehouseShipmentLine.FINDFIRST then
            GetWhseShpNo := WarehouseShipmentLine."No.";

        //Assign qty in Wrshe Shipment Line's "Qty to Ship" field
        if WarehouseShipmentHeader.GET(GetWhseShpNo) then begin
            WarehouseShipmentHeader.LOCKTABLE;
            // if (InterfaceEntryHeaderVIP."Buy-from Vendor No." <> '') then
            //     WarehouseShipmentHeader."Driver Code" := InterfaceEntryHeaderVIP."Buy-from Vendor No."; //BC Upgrade GUNREM01 -DIT Fields
            if (InterfaceEntryHeaderVIP."Currency Code" <> '') then
                WarehouseShipmentHeader."Shipping Agent Code" := InterfaceEntryHeaderVIP."Currency Code";
            // if (InterfaceEntryHeaderVIP."Sell-to Customer No." <> '') then
            //     WarehouseShipmentHeader."Truck Code" := InterfaceEntryHeaderVIP."Sell-to Customer No.";  //BC Upgrade GUNREM01 -DIT Fields
            if InterfaceEntryHeaderVIP."Pay-to Vendor No." <> '' then
                WarehouseShipmentHeader."Shipping Agent Service Code" := InterfaceEntryHeaderVIP."Pay-to Vendor No.";
            WarehouseShipmentHeader.MODIFY;

            WarehouseShipmentLine.RESET;
            WarehouseShipmentLine.SETRANGE("No.", WarehouseShipmentHeader."No.");
            if WarehouseShipmentLine.FINDSET then
                repeat
                    TotalQtyfromFile := 0;
                    InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                    //InterfaceEntryLineVIP.SETRANGE("Source No.",WarehouseShipmentLine."Source No.");
                    InterfaceEntryLineVIP.SETRANGE("Source Line No.", WarehouseShipmentLine."Source Line No.");
                    InterfaceEntryLineVIP.SETRANGE("No.", WarehouseShipmentLine."Item No.");
                    if InterfaceEntryLineVIP.FINDSET then begin
                        ResEntry1.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line");
                        ResEntry1.SETRANGE("Source ID", WarehouseShipmentLine."Source No.");
                        ResEntry1.SETRANGE("Source Ref. No.", WarehouseShipmentLine."Source Line No.");
                        ResEntry1.SETRANGE("Source Type", 37);
                        ResEntry1.SETRANGE("Source Subtype", WarehouseShipmentLine."Source Document");
                        ResEntry1.SETRANGE("Source Batch Name", '');
                        ResEntry1.SETRANGE("Source Prod. Order Line", 0);
                        if ResEntry1.FINDFIRST then
                            ResEntry1.DELETEALL;

                        repeat
                            StoreFirstBin := InterfaceEntryLineVIP."Location Code";
                            //CSO+
                            //QuantitySalesUOM :=ConvertToSalesUOM(WarehouseShipmentLine."No.",InterfaceEntryLineVIP."Unit of Measure Code",WarehouseShipmentLine."Unit of Measure Code",InterfaceEntryLineVIP.Quantity);
                            QuantitySalesUOM := ConvertToSalesUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", WarehouseShipmentLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                            //CSO-
                            TotalQtyfromFile += QuantitySalesUOM;
                            //Lot check depending on setup
                            //IF Item.GET(WarehouseShipmentLine."Item No.") THEN BEGIN             //commented by HEI.15
                            if (InterfaceEntryLineVIP.Quantity > 0) and Item.GET(WarehouseShipmentLine."Item No.") then begin      //HEI.15
                                if (Item."Item Tracking Code" <> '') then begin
                                    if ItemTrackingCode.GET(Item."Item Tracking Code") then begin

                                        if (ItemTrackingCode."Lot Purchase Outbound Tracking") and (ItemTrackingCode."Lot Sales Outbound Tracking") and (ItemTrackingCode."Lot Pos. Adjmt. Outb. Tracking")
                                              and (ItemTrackingCode."Lot Neg. Adjmt. Outb. Tracking") and (ItemTrackingCode."Lot Manuf. Outbound Tracking") then
                                            //>>Hei.04
                                            //CreateReservationEntries(InterfaceEntryLineVIP,WarehouseShipmentLine."Source No.",WarehouseShipmentLine."Source Line No.",WarehouseShipmentLine."Source Document",
                                            CreateReservationEntries(InterfaceEntryLineVIP, WarehouseShipmentLine."Source No.", '', WarehouseShipmentLine."Source Line No.", 37, WarehouseShipmentLine."Source Document".AsInteger(),
                          //<<Hei.04
                          WarehouseShipmentLine."Item No.", WarehouseShipmentLine."Variant Code", WarehouseShipmentHeader."Location Code", WarehouseShipmentLine."Unit of Measure Code",
                          //WarehouseShipmentLine.Description,WarehouseShipmentLine."Shipment Date",InterfaceEntryLineVIP."Currency Code",    //commented by HEI.07
                          WarehouseShipmentLine.Description, WarehouseShipmentLine."Shipment Date", InterfaceEntryLineVIP."Post Code",          //HEI.07
                          ConvertToBaseUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity))
                                        else
                                            //>>Hei.04
                                            //CreateReservationEntries(InterfaceEntryLineVIP,WarehouseShipmentLine."Source No.",WarehouseShipmentLine."Source Line No.",WarehouseShipmentLine."Source Document",
                                            CreateReservationEntries(InterfaceEntryLineVIP, WarehouseShipmentLine."Source No.", '', WarehouseShipmentLine."Source Line No.", 37, WarehouseShipmentLine."Source Document".AsInteger(),
                          //<<Hei.04
                          WarehouseShipmentLine."Item No.", WarehouseShipmentLine."Variant Code", WarehouseShipmentHeader."Location Code", WarehouseShipmentLine."Unit of Measure Code",
                          WarehouseShipmentLine.Description, WarehouseShipmentLine."Shipment Date", '', ConvertToBaseUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity));
                                    end;
                                end;
                            end;
                        until InterfaceEntryLineVIP.NEXT = 0;

                        WarehouseShipmentLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Location Code");
                        WarehouseShipmentLine.VALIDATE("Qty. to Ship", TotalQtyfromFile);
                        WarehouseShipmentLine.MODIFY;
                    end else begin
                        WarehouseShipmentLine.VALIDATE("Qty. to Ship", 0);
                        WarehouseShipmentLine.MODIFY;
                    end;
                until WarehouseShipmentLine.NEXT = 0;
            if WMSInterfaceSetup."Post Inb. Shipment Interface" = WMSInterfaceSetup."Post Inb. Shipment Interface"::"Ship &Invoice" then
                WhsePostShipment.SetPostingSettings(true);
            WhsePostShipment.RUN(WarehouseShipmentLine);
        end;
        //<<HEI.02
    end;

    local procedure PostSOShipment(var pSalesHeader: Record "Sales Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Location: Record Location;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        SalesPost: Codeunit "Sales-Post";
        TotalQtyfromFile: Decimal;
        QuantitySalesUOM: Decimal;
    begin
        //>>HEI.02
        SalesLine.SETRANGE("Document Type", pSalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", pSalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        if SalesLine.FINDSET then
            repeat
                TotalQtyfromFile := 0;
                InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                InterfaceEntryLineVIP.SETRANGE("Source No.", SalesLine."Document No.");
                InterfaceEntryLineVIP.SETRANGE("Source Line No.", SalesLine."Line No.");
                InterfaceEntryLineVIP.SETRANGE("No.", SalesLine."No.");
                if InterfaceEntryLineVIP.FINDSET then begin
                    repeat
                        QuantitySalesUOM := ConvertToSalesUOM(SalesLine."No.", InterfaceEntryLineVIP."Unit of Measure Code", SalesLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                        TotalQtyfromFile += QuantitySalesUOM;
                        SalesLine.VALIDATE("Qty. to Ship", TotalQtyfromFile);
                        SalesLine.MODIFY;
                        //Lot Check depending upon setup
                        if Item.GET(SalesLine."No.") then begin
                            if (Item."Item Tracking Code" <> '') then begin
                                if ItemTrackingCode.GET(Item."Item Tracking Code") then begin
                                    if (ItemTrackingCode."Lot Purchase Outbound Tracking") and (ItemTrackingCode."Lot Sales Outbound Tracking") and (ItemTrackingCode."Lot Pos. Adjmt. Outb. Tracking")
                                        and (ItemTrackingCode."Lot Neg. Adjmt. Outb. Tracking") and (ItemTrackingCode."Lot Manuf. Outbound Tracking") then
                                        //>>HEI.04
                                        //CreateReservationEntries(InterfaceEntryLineVIP,SalesLine."Document No.",SalesLine."Line No.",SalesLine."Document Type",SalesLine."No.",SalesLine."Variant Code",
                                        CreateReservationEntries(InterfaceEntryLineVIP, SalesLine."Document No.", '', SalesLine."Line No.", 37, SalesLine."Document Type".AsInteger(), SalesLine."No.", SalesLine."Variant Code",
                      //<<HEI.04
                      //SalesLine."Location Code",SalesLine."Unit of Measure Code",SalesLine.Description,SalesLine."Shipment Date",InterfaceEntryLineVIP."Currency Code",QuantitySalesUOM)  //commented by HEI.07
                      SalesLine."Location Code", SalesLine."Unit of Measure Code", SalesLine.Description, SalesLine."Shipment Date", InterfaceEntryLineVIP."Post Code", QuantitySalesUOM)  //HEI.07
                                    else
                                        //>>HEI.04
                                        //CreateReservationEntries(InterfaceEntryLineVIP,SalesLine."Document No.",SalesLine."Line No.",SalesLine."Document Type",SalesLine."No.",SalesLine."Variant Code",
                                        CreateReservationEntries(InterfaceEntryLineVIP, SalesLine."Document No.", '', SalesLine."Line No.", 37, SalesLine."Document Type".AsInteger(), SalesLine."No.", SalesLine."Variant Code",
                      //<<HEI.04
                      SalesLine."Location Code", SalesLine."Unit of Measure Code", SalesLine.Description, SalesLine."Shipment Date", '', QuantitySalesUOM);
                                end;
                            end;
                        end;
                    until InterfaceEntryLineVIP.NEXT = 0;
                end else begin
                    SalesLine.VALIDATE("Qty. to Ship", 0);
                    SalesLine.MODIFY;
                end;
            until SalesLine.NEXT = 0;
        SalesHeader.Ship := true;
        if WMSInterfaceSetup."Post Inb. Shipment Interface" = WMSInterfaceSetup."Post Inb. Shipment Interface"::"Ship &Invoice" then
            SalesHeader.Invoice := true;
        SalesPost.RUN(SalesHeader);
        //<<HEI.02
    end;

    procedure CreateReservationEntries(InterfaceEntryLine: Record "Interface Entry Line VIP INT"; pSourceNo: Code[20]; pSourceBatch: Code[10]; pSourceLineNo: Integer; pSourceType: Integer; pSourceSubtype: Integer; pItemNo: Code[20]; pVariantCode: Code[20]; pLocationCode: Code[10]; pUnitOfMeasureCode: Code[10]; pDescription: Text[50]; pShipmentDate: Date; pLotNo: Code[20]; pQuantity: Integer);
    var
        LotNoInfo: Record "Lot No. Information";
        ResEntry: Record "Reservation Entry";
        Customer: Record Customer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        QtyToShipBase: Decimal;
        RemQtyToShipBase: Decimal;
        AvailLotQty: Decimal;
        ReservedQty: Decimal;
        SerialNo: Code[20];
        QtyPerUOM: Integer;
        Err000: Label 'Lot not available in NAV.';
        Err001: Label 'Lot is blocked.';
    begin
        //>>HEI.02
        /*ResEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line");
        ResEntry.SETRANGE("Source ID",pSourceNo);
        ResEntry.SETRANGE("Source Ref. No.",pSourceLineNo);
        //>>HEI.04
        //ResEntry.SETRANGE("Source Type",DATABASE::"Sales Line");
        ResEntry.SETRANGE("Source Type",pSourceType);
        //<<Hei.04
        ResEntry.SETRANGE("Source Subtype",pSourceSubtype);
        //>>HEI.04
        //ResEntry.SETRANGE("Source Batch Name",pSourceBatch);
        ResEntry.SETRANGE("Source Batch Name",pSourceBatch);
        //<<HEI.04
        ResEntry.SETRANGE("Source Prod. Order Line",0);
        IF ResEntry.FINDFIRST THEN
          ResEntry.DELETEALL;*/

        LotNoInfo.RESET;
        //  LotNoInfo.SETCURRENTKEY("Item No.", "Variant Code", "Quality Status"); //BC Upgrade GUNREM01 -DIT Field
        LotNoInfo.SETRANGE("Item No.", pItemNo);
        /*LotNoInfo.SETRANGE("Variant Code",pVariantCode);
        LotNoInfo.SETFILTER("Quality Status",'%1|%2',LotNoInfo."Quality Status"::Pass,LotNoInfo."Quality Status"::Quarantine);
        LotNoInfo.SETRANGE("Location Filter",pLocationCode);
        LotNoInfo.SETFILTER(Inventory,'>0');*/
        //LotNoInfo.SETRANGE(LotNoInfo.Blocked,FALSE);  //commented by HEI.17
        if pLotNo <> '' then
            //>>HEI.04
            //LotNoInfo.SETRANGE(LotNoInfo."Lot No.",InterfaceEntryLine."Currency Code");  //Added
            LotNoInfo.SETRANGE(LotNoInfo."Lot No.", pLotNo);  //Added
                                                              //<<HEI.04
                                                              //HEI.17<<
        if LotNoInfo.COUNT = 0 then
            ERROR(Err000 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        LotNoInfo.SETRANGE(LotNoInfo.Blocked, false);
        if LotNoInfo.COUNT = 0 then
            ERROR(Err001 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        //HEI.17>>
        LotNoInfo.SETFILTER("Date Filter", '%1..%2', 00000101D, TODAY);
        if LotNoInfo.FINDLAST then begin
            QtyToShipBase := pQuantity;  //Added - HEI.01
            RemQtyToShipBase := QtyToShipBase;
            // Cycle through Available Lots
            repeat
                LotNoInfo.CALCFIELDS(Inventory, "Expired Inventory");
                if (LotNoInfo.Inventory - LotNoInfo."Expired Inventory") > 0 then begin
                    //Calculate Available Qty to Ship
                    CLEAR(ReservedQty);
                    ResEntry.RESET;
                    ResEntry.SETCURRENTKEY("Item No.", "Variant Code", "Location Code", "Item Tracking", "Reservation Status", "Lot No.", "Serial No.");
                    ResEntry.SETRANGE("Item No.", pItemNo);
                    ResEntry.SETRANGE("Variant Code", pVariantCode);
                    ResEntry.SETRANGE("Location Code", pLocationCode);
                    ResEntry.SETFILTER("Reservation Status", '%1|%2', 2, 3);    //Surplus, Prospect
                    ResEntry.SETRANGE("Lot No.", LotNoInfo."Lot No.");
                    ResEntry.SETRANGE(Positive, false);
                    if ResEntry.FINDSET then
                        repeat
                            ReservedQty += ResEntry."Quantity (Base)";
                        until ResEntry.NEXT = 0;
                    AvailLotQty := LotNoInfo.Inventory - LotNoInfo."Expired Inventory" + ReservedQty;
                    AvailLotQty := CalcRoundedQty(AvailLotQty, LotNoInfo."Item No.", pUnitOfMeasureCode);

                    //Adjust Qty to Ship
                    if AvailLotQty > RemQtyToShipBase then begin
                        QtyToShipBase := RemQtyToShipBase;
                        RemQtyToShipBase := 0;
                    end else begin
                        if AvailLotQty < 0 then
                            QtyToShipBase := 0
                        else begin
                            QtyToShipBase := AvailLotQty;
                            RemQtyToShipBase := RemQtyToShipBase - AvailLotQty;
                        end;
                    end;
                    if ItemUnitofMeasure.GET(pItemNo, pUnitOfMeasureCode) then
                        QtyPerUOM := ItemUnitofMeasure."Qty. per Unit of Measure"
                    else
                        QtyPerUOM := 1;
                    if QtyToShipBase > 0 then begin
                        //>>HEI.04
                        //CreateReservEntry.CreateReservEntryFor(DATABASE::"Sales Line",pSourceSubtype,pSourceNo,'',0,pSourceLineNo,QtyPerUOM,InterfaceEntryLine.Quantity,QtyToShipBase,SerialNo,
                        //                                        LotNoInfo."Lot No.");
                        //BC Upgrade GUNREM01 Changed the Reservation enrty Parameter >>
                        // CreateReservEntry.CreateReservEntryFor(pSourceType, pSourceSubtype, pSourceNo, pSourceBatch, 0, pSourceLineNo, QtyPerUOM, InterfaceEntryLine.Quantity, QtyToShipBase, SerialNo,
                        //                                         LotNoInfo."Lot No.");
                        CreateReservEntry.CreateReservEntryFor(pSourceType, pSourceSubtype, pSourceNo, pSourceBatch, 0, pSourceLineNo, QtyPerUOM, InterfaceEntryLine.Quantity, QtyToShipBase, ResEntry);
                        //BC Upgrade GUNREM01 Changed the Reservation enrty Parameter <<
                        //<<HEI.04
                        CreateReservEntry.CreateEntry(pItemNo, pVariantCode, pLocationCode, pDescription, 0D, pShipmentDate, 0, enumvalue::Prospect);

                    end;
                end;
            until (LotNoInfo.NEXT(-1) = 0) or (RemQtyToShipBase = 0);
        end else
            //>>HEI.04
            //ERROR(Text50000,InterfaceEntryLine."Currency Code");
            //ERROR(Text50000,pLotNo);  //commented by HEI.17
            //<<HEI.04
            //HEI.17<<
            ERROR(Err000 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        //HEI.17<<

        //<<HEI.02

    end;

    procedure CalcRoundedQty(Qty: Decimal; ItemNo: Code[20]; UOM: Code[20]): Decimal;
    var
        ItemUOM: Record "Item Unit of Measure";
    begin
        ItemUOM.GET(ItemNo, UOM);
        exit(ROUND(Qty / ItemUOM."Qty. per Unit of Measure", 1, '<') * ItemUOM."Qty. per Unit of Measure");
    end;

    local procedure ConvertToSalesUOM(ItemNo: Code[20]; ReflexUOM: Code[10]; SalesUOM: Code[10]; Quantity: Decimal): Decimal;
    var
        SalesItemUnitOfMeasure: Record "Item Unit of Measure";
        ReflexItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        //>>HEI.02
        if (SalesUOM <> '') and (ReflexUOM <> '') then begin

            ReflexItemUnitOfMeasure.GET(ItemNo, ReflexUOM);

            SalesItemUnitOfMeasure.GET(ItemNo, SalesUOM);
            //CSO

            //EXIT(ROUND((ROUND((SalesItemUnitOfMeasure."Qty. per Unit of Measure" /
            //  ReflexItemUnitOfMeasure."Qty. per Unit of Measure"),1,'=') * Quantity),1,'='));
            exit(ROUND((ReflexItemUnitOfMeasure."Qty. per Unit of Measure" /
              SalesItemUnitOfMeasure."Qty. per Unit of Measure" * Quantity), 1, '='));
            //cso
        end;

        exit(Quantity);
        //<<HEI.02
    end;

    local procedure ConvertToBaseUOM(ItemNo: Code[20]; ReflexUOM: Code[10]; Quantity: Decimal): Decimal;
    var
        ReflexItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        //>>HEI.02
        if (ReflexUOM <> '') then begin

            ReflexItemUnitOfMeasure.GET(ItemNo, ReflexUOM);
            exit(ROUND((Quantity / ReflexItemUnitOfMeasure."Qty. per Unit of Measure"), 1, '='));
        end;
        exit(Quantity);
        //<<HEI.02
    end;
    //BC Upgrade GUNREM01 -Used SMTP mail functionality, as of now its blocked >>
    // [EventSubscriber(ObjectType::Codeunit, 50086, 'OnAfterSetInterfaceError', '', false, false)] Interface Framework Mgt. VIP
    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Interface Framework Mgt. VIP", 'OnAfterSetInterfaceError', '', false, false)]

    // local procedure OnAfterSetInterfaceError(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    // var
    //     // SMTPMail: Codeunit "SMTP Mail"; //BC Upgrade GUNREM01
    //     Subject: Text;
    //     Body: Text;
    //     DataExch: Record "Data Exch.";
    //     InStr: InStream;
    // begin
    //     //>>HEI.02
    //     GetWMSInterfaceSetup;
    //     case InterfaceEntryHeaderVIP."Interface Code" of
    //         WMSInterfaceSetup."Sales Order Interface",
    //         WMSInterfaceSetup."Warehouse Shipment Interface",
    //         WMSInterfaceSetup."Sales Order Deletion Interface":
    //             begin
    //                 // if WMSInterfaceSetup."Email Errors" <> '' then begin
    //                 //     /*//<<HEI.13
    //                 //     SMTPMail.CreateMessage('NAV LOG ERROR EDI TECH','NAV_ERROR@heineken.com',WMSInterfaceSetup."Email Errors",
    //                 //                             WMSInterfaceSetup."Email Subject",InterfaceEntryHeaderVIP."Error Message",FALSE);
    //                 //     *///>>HEI.13
    //                 //       //<<HEI.13
    //                 //     Subject := WMSInterfaceSetup."Email Subject" + ' Source No.: ' + InterfaceEntryHeaderVIP."Source No.";
    //                 //     Body := 'Error happened on interface: ' + InterfaceEntryHeaderVIP."Interface Code" + '<br><br>';
    //                 //     Body += InterfaceEntryHeaderVIP."Error Message";
    //                 //     SMTPMail.CreateMessage('NAV LOG ERROR TECH', 'NAV_ERROR@heineken.com', WMSInterfaceSetup."Email Errors",
    //                 //                         //    Subject, Body, true); 
    //                 //     if DataExch.GET(InterfaceEntryHeaderVIP."Data Exch. Entry No.") then
    //                 //         if (DataExch."Parent Data Exch. No." <> 0) and (DataExch."Entry No." <> DataExch."Parent Data Exch. No.") then
    //                 //             DataExch.GET(DataExch."Parent Data Exch. No.");
    //                 //     with DataExch do
    //                 //         if "File Content".HASVALUE then begin
    //                 //             CALCFIELDS("File Content");
    //                 //             "File Content".CREATEINSTREAM(InStr);
    //                 //             SMTPMail.AddAttachmentStream(InStr, InterfaceEntryHeaderVIP."Interface Code" + '.xml');
    //                 //         end;
    //                 //     //>>HEI.13

    //                 //     SMTPMail.Send;
    //                 // end;
    //             end;
    //         WMSInterfaceSetup."TO Interface",
    //         WMSInterfaceSetup."TO Interface Purchase",
    //         WMSInterfaceSetup."TO Deletion Interface",
    //         //HEI.21>>
    //         //WMSInterfaceSetup."Warehouse TS Interface",
    //         //WMSInterfaceSetup."Warehouse RE Interface":
    //         WMSInterfaceSetup."Warehouse TS Interface":
    //             //HEI.21<<
    //             begin
    //                 if WMSInterfaceSetup."Email Errors TS" <> '' then begin
    //                     /*//<<HEI.13
    //                     SMTPMail.CreateMessage('NAV LOG ERROR EDI TECH','NAV_ERROR@heineken.com',WMSInterfaceSetup."Email Errors TS",
    //                                             WMSInterfaceSetup."Email Subject TS",InterfaceEntryHeaderVIP."Error Message",FALSE);
    //                     *///>>HEI.13
    //                       //<<HEI.13
    //                     Subject := WMSInterfaceSetup."Email Subject TS" + ' Source No.: ' + InterfaceEntryHeaderVIP."Source No.";
    //                     Body := 'Error happened on interface: ' + InterfaceEntryHeaderVIP."Interface Code" + '<br><br>';
    //                     Body += InterfaceEntryHeaderVIP."Error Message";
    //                     SMTPMail.CreateMessage('NAV LOG ERROR TECH', 'NAV_ERROR@heineken.com', WMSInterfaceSetup."Email Errors TS",
    //                                             Subject, Body, true);
    //                     if DataExch.GET(InterfaceEntryHeaderVIP."Data Exch. Entry No.") then
    //                         if (DataExch."Parent Data Exch. No." <> 0) and (DataExch."Entry No." <> DataExch."Parent Data Exch. No.") then
    //                             DataExch.GET(DataExch."Parent Data Exch. No.");
    //                     with DataExch do
    //                         if "File Content".HASVALUE then begin
    //                             CALCFIELDS("File Content");
    //                             "File Content".CREATEINSTREAM(InStr);
    //                             SMTPMail.AddAttachmentStream(InStr, InterfaceEntryHeaderVIP."Interface Code" + '.xml');
    //                         end;
    //                     //>>HEI.13

    //                     SMTPMail.Send;
    //                 end;
    //             end;
    //         //HEI.21>>
    //         WMSInterfaceSetup."Purchase Order Interface",
    //         WMSInterfaceSetup."Purchase Order Del Interface":
    //             begin
    //                 if WMSInterfaceSetup."Email Errors PO" <> '' then begin
    //                     Subject := WMSInterfaceSetup."Email Subject PO" + ' Source No.: ' + InterfaceEntryHeaderVIP."Source No.";
    //                     Body := 'Error happened on interface: ' + InterfaceEntryHeaderVIP."Interface Code" + '<br><br>';
    //                     Body += InterfaceEntryHeaderVIP."Error Message";
    //                     SMTPMail.CreateMessage('NAV LOG ERROR TECH', 'NAV_ERROR@heineken.com', WMSInterfaceSetup."Email Errors PO",
    //                                             Subject, Body, true);
    //                     if DataExch.GET(InterfaceEntryHeaderVIP."Data Exch. Entry No.") then
    //                         if (DataExch."Parent Data Exch. No." <> 0) and (DataExch."Entry No." <> DataExch."Parent Data Exch. No.") then
    //                             DataExch.GET(DataExch."Parent Data Exch. No.");
    //                     with DataExch do
    //                         if "File Content".HASVALUE then begin
    //                             CALCFIELDS("File Content");
    //                             "File Content".CREATEINSTREAM(InStr);
    //                             SMTPMail.AddAttachmentStream(InStr, InterfaceEntryHeaderVIP."Interface Code" + '.xml');
    //                         end;
    //                     SMTPMail.Send;
    //                 end;
    //             end;
    //         WMSInterfaceSetup."Warehouse RE Interface":
    //             begin
    //                 if InterfaceEntryHeaderVIP."External Document No." = '010' then begin
    //                     if WMSInterfaceSetup."Email Errors PO" <> '' then begin
    //                         Subject := WMSInterfaceSetup."Email Subject PO" + ' Source No.: ' + InterfaceEntryHeaderVIP."Source No.";
    //                         Body := 'Error happened on interface: ' + InterfaceEntryHeaderVIP."Interface Code" + '<br><br>';
    //                         Body += InterfaceEntryHeaderVIP."Error Message";
    //                         SMTPMail.CreateMessage('NAV LOG ERROR TECH', 'NAV_ERROR@heineken.com', WMSInterfaceSetup."Email Errors PO",
    //                                                 Subject, Body, true);
    //                         if DataExch.GET(InterfaceEntryHeaderVIP."Data Exch. Entry No.") then
    //                             if (DataExch."Parent Data Exch. No." <> 0) and (DataExch."Entry No." <> DataExch."Parent Data Exch. No.") then
    //                                 DataExch.GET(DataExch."Parent Data Exch. No.");
    //                         with DataExch do
    //                             if "File Content".HASVALUE then begin
    //                                 CALCFIELDS("File Content");
    //                                 "File Content".CREATEINSTREAM(InStr);
    //                                 SMTPMail.AddAttachmentStream(InStr, InterfaceEntryHeaderVIP."Interface Code" + '.xml');
    //                             end;
    //                         SMTPMail.Send;
    //                     end;
    //                 end else begin
    //                     if InterfaceEntryHeaderVIP."External Document No." = '030' then begin
    //                         if WMSInterfaceSetup."Email Errors TS" <> '' then begin
    //                             Subject := WMSInterfaceSetup."Email Subject TS" + ' Source No.: ' + InterfaceEntryHeaderVIP."Source No.";
    //                             Body := 'Error happened on interface: ' + InterfaceEntryHeaderVIP."Interface Code" + '<br><br>';
    //                             Body += InterfaceEntryHeaderVIP."Error Message";
    //                             SMTPMail.CreateMessage('NAV LOG ERROR TECH', 'NAV_ERROR@heineken.com', WMSInterfaceSetup."Email Errors TS",
    //                                                     Subject, Body, true);
    //                             if DataExch.GET(InterfaceEntryHeaderVIP."Data Exch. Entry No.") then
    //                                 if (DataExch."Parent Data Exch. No." <> 0) and (DataExch."Entry No." <> DataExch."Parent Data Exch. No.") then
    //                                     DataExch.GET(DataExch."Parent Data Exch. No.");
    //                             with DataExch do
    //                                 if "File Content".HASVALUE then begin
    //                                     CALCFIELDS("File Content");
    //                                     "File Content".CREATEINSTREAM(InStr);
    //                                     SMTPMail.AddAttachmentStream(InStr, InterfaceEntryHeaderVIP."Interface Code" + '.xml');
    //                                 end;
    //                             SMTPMail.Send;
    //                         end;
    //                     end;
    //                 end;
    //             end;
    //     //HEI.21<<
    //     end;
    //     //<<HEI.02

    // end;
    //BC Upgrade GUNREM01 -Used SMTP mail functionality, as of now its blocked <<

    [TryFunction]
    local procedure CheckZoneBinTC(InterfaceEntryLine: Record "Interface Entry Line VIP INT"; pLocationCode: Code[10]);
    var
        Zone: Record Zone;
        Bin: Record Bin;
    begin
        //HEI.32 >>
        Zone.GET(pLocationCode, InterfaceEntryLine."External Contract No.");
        Bin.RESET;
        Bin.SETRANGE("Location Code", pLocationCode);
        Bin.SETRANGE("Zone Code", Zone.Code);
        Bin.SETRANGE(Code, InterfaceEntryLine."Location Code");
        Bin.FINDFIRST;
        //HEI.32 <<
    end;

    local procedure "--- Transfer Order Functions -----"();
    begin
    end;

    [EventSubscriber(ObjectType::Table, 5740, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteTransferOrder(var Rec: Record "Transfer Header"; RunTrigger: Boolean);
    begin
        //>>HEI.03
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if Rec.ISTEMPORARY then exit;
        if not RunTrigger then exit;

        CreateTransferOrderDeleteEntry(Rec);
        //<<HEI.03
    end;

    [EventSubscriber(ObjectType::Table, 5740, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyTransferHeader(var Rec: Record "Transfer Header"; var xRec: Record "Transfer Header"; RunTrigger: Boolean);
    begin
        /*//<<HEI.14
        //>>HEI.03
        GetWMSInterfaceSetup;
        IF NOT WMSInterfaceSetup."WMS Integration" THEN EXIT;
        IF Rec.ISTEMPORARY THEN EXIT;
        IF NOT Rec."WMS Export" THEN EXIT;
        IF Rec.Status = Rec.Status::Released THEN EXIT;
        IF NOT RunTrigger THEN EXIT;
        
        Rec."WMS Export" := FALSE;
        //<<HEI.03
        *///>>HEI.14

    end;

    [EventSubscriber(ObjectType::Table, 5741, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyTransferLine(var Rec: Record "Transfer Line"; var xRec: Record "Transfer Line"; RunTrigger: Boolean);
    var
        TransferHeader: Record "Transfer Header";
    begin
        /*//<<HEI.14
        //>>HEI.03
        GetWMSInterfaceSetup;
        IF NOT WMSInterfaceSetup."WMS Integration" THEN EXIT;
        IF Rec.ISTEMPORARY THEN EXIT;
        IF NOT RunTrigger THEN EXIT;
        TransferHeader.GET(Rec."Document No.");
        IF NOT TransferHeader."WMS Export" THEN EXIT;
        TransferHeader."WMS Export" := FALSE;
        //TransferHeader.MODIFY;
        
        //<<HEI.03
        *///>>HEI.14

    end;

    [EventSubscriber(ObjectType::Table, 5741, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteTransferLine(var Rec: Record "Transfer Line"; RunTrigger: Boolean);
    var
        TransferHeader: Record "Transfer Header";
    begin
        /*//<<HEI.14
        //>>HEI.03
        GetWMSInterfaceSetup;
        IF NOT WMSInterfaceSetup."WMS Integration" THEN EXIT;
        IF Rec.ISTEMPORARY THEN EXIT;
        IF NOT RunTrigger THEN EXIT;
        TransferHeader.GET(Rec."Document No.");
        IF NOT TransferHeader."WMS Export" THEN EXIT;
        TransferHeader."WMS Export" := FALSE;
        //TransferHeader.MODIFY;
        //<<HEI.03
        *///>>HEI.14

    end;

    [EventSubscriber(ObjectType::Codeunit, 5708, 'OnAfterReleaseTransferDoc', '', false, false)]
    local procedure OnAfterReleaseTransferOrder(var TransferHeader: Record "Transfer Header");
    var
        TH: Record "Transfer Header";
    begin
        //>>HEI.03
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if TransferHeader.ISTEMPORARY then exit;

        GetWMSInterfaceSetup;

        CLEAR(TH);
        TH.SETRANGE("No.", TransferHeader."No.");
        TH.SETFILTER("Transfer-from Code", WMSInterfaceSetup."Location on REFLEX");
        if TH.FINDFIRST then
            CreatesTransferOrderEntry(TransferHeader);
        /*ELSE BEGIN
          CLEAR(TH);
          TH.SETRANGE("No.",TransferHeader."No.");
          TH.SETFILTER("Transfer-to Code", WMSInterfaceSetup."Location on REFLEX");
          IF TH.FINDFIRST THEN
            CreatesTransferOrderPurchaseEntry(TransferHeader);
        END;*/

        //<<HEI.03

    end;

    [EventSubscriber(ObjectType::Codeunit, 5704, 'OnAfterTransferOrderPostShipment', '', false, false)]
    local procedure OnAfterShipTransferOrder(var TransferHeader: Record "Transfer Header");
    var
        TH: Record "Transfer Header";
    begin
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then exit;
        if TransferHeader.ISTEMPORARY then exit;

        CLEAR(TH);
        TH.SETRANGE("No.", TransferHeader."No.");
        TH.SETFILTER("Transfer-from Code", WMSInterfaceSetup."Location on REFLEX");
        if not TH.FINDFIRST then begin
            CLEAR(TH);
            TH.SETRANGE("No.", TransferHeader."No.");
            TH.SETFILTER("Transfer-to Code", WMSInterfaceSetup."Location on REFLEX");
            if TH.FINDFIRST then
                CreatesTransferOrderPurchaseEntry(TransferHeader);
        end;
    end;

    procedure ProcessTransferOrderRequest(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        TransferHeader: Record "Transfer Header";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //>>HEI.03
        GetWMSInterfaceSetup;
        WMSInterfaceSetup.TESTFIELD("TO Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."TO Interface");
        if not InterfaceSetup.Enabled then exit;

        TransferHeader.SETRANGE(Status, TransferHeader.Status::Released);
        TransferHeader.SETRANGE("WMS Export FND", false);
        if TransferHeader.FINDSET then
            repeat
                CreatesTransferOrderEntry(TransferHeader);
            until TransferHeader.NEXT = 0;

        TransferHeader.MODIFYALL("WMS Export FND", true);
        //<<HEI.03
    end;

    local procedure CreateTransferOrderDeleteEntry(var TransferHeader: Record "Transfer Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        //>>HEI.03
        GetCompanyInformation;
        GetWMSInterfaceSetup;
        WMSInterfaceSetup.TESTFIELD("TO Deletion Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."TO Deletion Interface");
        if not InterfaceSetup.Enabled then
            exit;

        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        //InterfaceEntryHeaderVIP."Message Name" := 'SUPTRFB2B';
        InterfaceEntryHeaderVIP."Interface Code" := WMSInterfaceSetup."TO Deletion Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Transfer Header";
        InterfaceEntryHeaderVIP."Source No." := TransferHeader."No.";
        InterfaceEntryHeaderVIP."Location Code" := TransferHeader."Transfer-from Code";
        InterfaceEntryHeaderVIP.INSERT(true);
        //<<HEI.03
    end;

    local procedure CreatesTransferOrderEntry(var TransferHeader: Record "Transfer Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        Language: Record Language;
        ItemTranslation: Record "Item Translation";
        DefaultLanguageCode: Code[10];
        LineEntryNo: Integer;
    begin
        //>>HEI.03
        GetGeneralInterfaceSetup;
        GetCompanyInformation;
        GetWMSInterfaceSetup;
        InterfaceSetup.GET(WMSInterfaceSetup."TO Interface");
        if not InterfaceSetup.Enabled then exit;
        if not CheckIfTransferLineExists(TransferHeader) then exit;

        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        //InterfaceEntryHeaderVIP."Message Name" := 'TRANS_B2B';
        InterfaceEntryHeaderVIP."Interface Code" := WMSInterfaceSetup."TO Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Transfer Header";
        InterfaceEntryHeaderVIP."Source No." := TransferHeader."No.";
        InterfaceEntryHeaderVIP."Location Code" := TransferHeader."Transfer-from Code";
        InterfaceEntryHeaderVIP."Currency Code" := TransferHeader."Transfer-to Code";
        InterfaceEntryHeaderVIP."External Document No." := TransferHeader."External Document No.";
        InterfaceEntryHeaderVIP."Document Date" := TransferHeader."Posting Date";
        InterfaceEntryHeaderVIP.INSERT(true);

        CreateTransferOrderLineEntry(InterfaceEntryHeaderVIP, TransferHeader);
        TransferHeader."WMS Export FND" := true;
        TransferHeader.MODIFY;
        //<<HEI.03
    end;

    local procedure CreateTransferOrderLineEntry(InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT"; TransferHeader: Record "Transfer Header");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TransferLine: Record "Transfer Line";
        NextEntryNo: Integer;
        TransferLine2: Record "Transfer Line";
        IncludeSalesLine: Boolean;
        ExcludeSalesLine: Boolean;
    begin
        //<<HEI.12
        TransferLine2.SETRANGE("Document No.", TransferHeader."No.");
        if TransferLine2.FINDSET then
            repeat
                IncludeSalesLine := false;
                ExcludeSalesLine := false;
                if ItemsIncludeExclude.GET(TransferLine2."Item No.") then begin
                    if ItemsIncludeExclude.Included then
                        IncludeSalesLine := true;
                    if ItemsIncludeExclude.Excluded then
                        ExcludeSalesLine := true;
                end;

                if not ExcludeSalesLine then begin
                    //>>HEI.12
                    //>>HEI.03
                    TransferLine.SETRANGE("Document No.", TransferHeader."No.");
                    TransferLine.SETRANGE("Line No.", TransferLine2."Line No.");   //HEI.12
                                                                                   //IF WMSInterfaceSetup."Item Category" <> ''  THEN      //commented by HEI.12
                    if (WMSInterfaceSetup."Item Category" <> '') and not IncludeSalesLine then   //HEI.12
                        TransferLine.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                    if TransferLine.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineVIP);
                            InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            NextEntryNo := NextEntryNo + 1;
                            InterfaceEntryLineVIP."Entry No." := NextEntryNo;
                            InterfaceEntryLineVIP."Source Line No." := TransferLine."Line No.";
                            InterfaceEntryLineVIP."Item Code" := TransferLine."Item No.";
                            InterfaceEntryLineVIP."No." := TransferHeader."No.";
                            InterfaceEntryLineVIP."Location Code" := TransferHeader."Transfer-from Code";
                            InterfaceEntryLineVIP."Currency Code" := TransferHeader."Transfer-to Code";
                            InterfaceEntryLineVIP.Quantity := TOConvertToReflexPcs(TransferLine, TransferLine.Quantity);
                            InterfaceEntryLineVIP.Description := TransferHeader."External Document No.";
                            //InterfaceEntryLineVIP."Expected Delivery Date" := TransferHeader."Posting Date";   //commented by HEI.23
                            InterfaceEntryLineVIP."Payment Terms Code" := FORMAT(TransferHeader."Posting Date", 0, '<Year4><Month,2><Day,2>');  //HEI.23
                            InterfaceEntryLineVIP."Traceability Code" := TransferLine."Transfer-from Bin Code";
                            InterfaceEntryLineVIP.Name := COPYSTR(TransferHeader."Transfer-to Name", 1, 30);
                            InterfaceEntryLineVIP.Address := COPYSTR(TransferHeader."Transfer-to Address", 1, 40);
                            InterfaceEntryLineVIP."Address 2" := COPYSTR(TransferHeader."Transfer-to Address 2", 1, 40);
                            InterfaceEntryLineVIP.City := TransferHeader."Transfer-to City";
                            InterfaceEntryLineVIP."Post Code" := TransferHeader."Transfer-to Post Code";
                            InterfaceEntryLineVIP."Description 2" := TransferHeader."Transfer-to Contact";
                            InterfaceEntryLineVIP.INSERT(true);
                        until TransferLine.NEXT = 0;
                    //<<HEI.03
                end;  //HEI.12
            until TransferLine2.NEXT = 0;   //HEI.12
    end;

    local procedure CheckIfTransferLineExists(TransferHeader: Record "Transfer Header"): Boolean;
    var
        TransferLine: Record "Transfer Line";
        TransferLine2: Record "Transfer Line";
    begin
        /*//<<commented by HEI.12
        //>>HEI.03
        GetWMSInterfaceSetup;
        TransferLine.SETRANGE("Document No.",TransferHeader."No.");
        IF WMSInterfaceSetup."Item Category" <> ''  THEN
          TransferLine.SETFILTER("Item Category Code",WMSInterfaceSetup."Item Category");
        EXIT(NOT TransferLine.ISEMPTY);
        //<<HEI.03
        *///>>commented by HEI.12
        //<<HEI.12
        GetWMSInterfaceSetup;
        TransferLine2.SETRANGE("Document No.", TransferHeader."No.");
        if TransferLine2.FINDSET then begin
            repeat
                ItemsIncludeExclude.RESET;
                if ItemsIncludeExclude.GET(TransferLine2."Item No.") then begin
                    if ItemsIncludeExclude.Included then
                        exit(true);
                end else begin
                    TransferLine.SETRANGE("Document No.", TransferHeader."No.");
                    TransferLine.SETRANGE("Line No.", TransferLine2."Line No.");
                    if WMSInterfaceSetup."Item Category" <> '' then
                        TransferLine.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                    if TransferLine.FINDFIRST then
                        exit(true);
                end;
            until TransferLine2.NEXT = 0;
            exit(false);
        end else
            exit(false);
        //>>HEI.12

    end;

    local procedure TOConvertToReflexPcs(TransferLine: Record "Transfer Line"; pQuantity: Decimal): Decimal;
    var
        SalesItemUnitOfMeasure: Record "Item Unit of Measure";
        ReflexItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        //>>HEI.03
        GetWMSInterfaceSetup;
        if (TransferLine."Unit of Measure Code" <> '') and (WMSInterfaceSetup."Reflex 1st OUM" <> '') then begin
            ReflexItemUnitOfMeasure.GET(TransferLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM");
            SalesItemUnitOfMeasure.GET(TransferLine."Item No.", TransferLine."Unit of Measure Code");
            exit(ROUND((ROUND((SalesItemUnitOfMeasure."Qty. per Unit of Measure" /
              ReflexItemUnitOfMeasure."Qty. per Unit of Measure"), 1, '=') * pQuantity), 1, '='));

        end;

        exit(TransferLine.Quantity);
        //<<HEI.03
    end;

    local procedure CreatesTransferOrderPurchaseEntry(var TransferHeader: Record "Transfer Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        Language: Record Language;
        ItemTranslation: Record "Item Translation";
        DefaultLanguageCode: Code[10];
        LineEntryNo: Integer;
    begin
        //>>HEI.03
        GetGeneralInterfaceSetup;
        GetCompanyInformation;
        GetWMSInterfaceSetup;
        if not InterfaceSetup.GET(WMSInterfaceSetup."TO Interface Purchase") then exit;
        if not InterfaceSetup.Enabled then exit;
        if not CheckIfTransferLineExists(TransferHeader) then exit;

        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        //InterfaceEntryHeaderVIP."Message Name" := 'RECEPTION';
        InterfaceEntryHeaderVIP."Interface Code" := WMSInterfaceSetup."TO Interface Purchase";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Transfer Header";
        InterfaceEntryHeaderVIP."Source No." := TransferHeader."No.";
        InterfaceEntryHeaderVIP."Location Code" := TransferHeader."Transfer-from Code";
        InterfaceEntryHeaderVIP."Currency Code" := TransferHeader."Transfer-to Code";
        InterfaceEntryHeaderVIP."External Document No." := TransferHeader."External Document No.";
        InterfaceEntryHeaderVIP."Document Date" := TransferHeader."Posting Date";
        InterfaceEntryHeaderVIP.INSERT(true);

        CreateTransferOrderLinePurchaseEntry(InterfaceEntryHeaderVIP, TransferHeader);
        TransferHeader."WMS Export FND" := true;
        TransferHeader.MODIFY;
        //<<HEI.03
    end;

    local procedure CreateTransferOrderLinePurchaseEntry(InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT"; TransferHeader: Record "Transfer Header");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TransferLine: Record "Transfer Line";
        NextEntryNo: Integer;
        PTShLine: Record "Transfer Shipment Line";
        TransferLine2: Record "Transfer Line";
        IncludeSalesLine: Boolean;
        ExcludeSalesLine: Boolean;
    begin
        //<<HEI.12
        TransferLine2.SETRANGE("Document No.", TransferHeader."No.");
        TransferLine2.SETFILTER("Derived From Line No.", '=%1', 0);
        if TransferLine2.FINDSET then
            repeat
                IncludeSalesLine := false;
                ExcludeSalesLine := false;
                if ItemsIncludeExclude.GET(TransferLine2."Item No.") then begin
                    if ItemsIncludeExclude.Included then
                        IncludeSalesLine := true;
                    if ItemsIncludeExclude.Excluded then
                        ExcludeSalesLine := true;
                end;

                if not ExcludeSalesLine then begin
                    //>>HEI.12
                    //>>HEI.03
                    TransferLine.SETRANGE("Document No.", TransferHeader."No.");
                    TransferLine.SETRANGE("Line No.", TransferLine2."Line No.");  //HEI.12
                    TransferLine.SETFILTER("Derived From Line No.", '=%1', 0);
                    //IF WMSInterfaceSetup."Item Category" <> ''  THEN    //commented by HEI.12
                    if (WMSInterfaceSetup."Item Category" <> '') and not IncludeSalesLine then    //HEI.12
                        TransferLine.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                    if TransferLine.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineVIP);
                            InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            NextEntryNo := NextEntryNo + 1;
                            InterfaceEntryLineVIP."Entry No." := NextEntryNo;
                            InterfaceEntryLineVIP."Location Code" := TransferHeader."Transfer-to Code";
                            InterfaceEntryLineVIP."No." := TransferHeader."No.";
                            InterfaceEntryLineVIP."Currency Code" := TransferHeader."Transfer-from Code";
                            //InterfaceEntryLineVIP."Expected Delivery Date" := TransferHeader."Posting Date";  //commented by HEI.23
                            InterfaceEntryLineVIP."Payment Terms Code" := FORMAT(TransferHeader."Posting Date", 0, '<Year4><Month,2><Day,2>');  //HEI.23
                            InterfaceEntryLineVIP."Source Line No." := TransferLine."Line No.";
                            InterfaceEntryLineVIP."Item Code" := TransferLine."Item No.";

                            PTShLine.RESET;
                            if PTShLine.GET(TransferHeader."Last Shipment No.", TransferLine."Line No.") then
                                InterfaceEntryLineVIP.Quantity := TOConvertToReflexPcs(TransferLine, PTShLine.Quantity)
                            else
                                InterfaceEntryLineVIP.Quantity := TOConvertToReflexPcs(TransferLine, TransferLine.Quantity);

                            InterfaceEntryLineVIP."Traceability Code" := TransferLine."Transfer-To Bin Code";
                            InterfaceEntryLineVIP.INSERT(true);
                        until TransferLine.NEXT = 0;
                    //<<HEI.03
                end;  //HEI.12
            until TransferLine2.NEXT = 0;  //HEI.12
    end;

    local procedure "---StockAdjustmentFunctions---"();
    begin
    end;

    procedure ProcessStockAdjustmentRequest(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TempItemJournalTemplate: Record "Item Journal Template" temporary;
        ItemJournalLine: Record "Item Journal Line";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        LineNo: Integer;
        ItemJournalTemplateName: Code[10];
        ItemJnlPostBatch: Codeunit "Item Jnl.-Post Batch";
    begin
        //>>HEI.04

        GetWMSInterfaceSetup;

        WMSInterfaceSetup.TESTFIELD("Warehouse Shipment Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Warehouse Shipment Interface");
        if not InterfaceSetup.Enabled then
            exit;
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDSET then
            repeat
                //different journal template are used base on reason code
                ItemJournalTemplateName := GetItemJournalTemplate(InterfaceEntryLineVIP."Customer Code");
                if not TempItemJournalTemplate.GET(ItemJournalTemplateName) then begin
                    TempItemJournalTemplate.Name := ItemJournalTemplateName;
                    TempItemJournalTemplate."Page ID" := 10000;
                    ItemJournalBatch.GET(ItemJournalTemplateName, WMSInterfaceSetup."Stock Adjustment Batch");
                    ItemJournalBatch.TESTFIELD("No. Series");
                    //  TempItemJournalTemplate.Description := NoSeriesMgt.TryGetNextNo(ItemJournalBatch."No. Series", InterfaceEntryLineVIP."Posting Date");
                    TempItemJournalTemplate.Description := NoSeriesMgt.GetNextNo(ItemJournalBatch."No. Series", InterfaceEntryLineVIP."Posting Date"); //BC Upgrade GUNREM01 Replaced with TryGetNextNo

                    TempItemJournalTemplate.INSERT;
                    ItemJournalLine.SETRANGE("Journal Template Name", ItemJournalTemplateName);
                    ItemJournalLine.SETRANGE("Journal Batch Name", WMSInterfaceSetup."Stock Adjustment Batch");
                    if not ItemJournalLine.ISEMPTY then
                        ItemJournalLine.DELETEALL;
                end else begin
                    //use for increment the line no.
                    TempItemJournalTemplate."Page ID" += 10000;
                    TempItemJournalTemplate.MODIFY;
                end;

                ItemJournalLine."Journal Template Name" := ItemJournalTemplateName;
                ItemJournalLine."Journal Batch Name" := WMSInterfaceSetup."Stock Adjustment Batch";
                ItemJournalLine."Line No." := TempItemJournalTemplate."Page ID";
                ItemJournalLine.INSERT(true);
                if InterfaceEntryLineVIP."External Contract No." = '+' then
                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.")
                else
                    ItemJournalLine.VALIDATE("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");

                ItemJournalLine.VALIDATE("Posting Date", InterfaceEntryLineVIP."Posting Date");
                ItemJournalLine.VALIDATE("Document No.", TempItemJournalTemplate.Description);

                //HEI.24>>
                ItemJournalLine."Item No." := InterfaceEntryLineVIP."No.";
                ItemJournalLine."Unit of Measure Code" := InterfaceEntryLineVIP."Unit of Measure Code";
                //HEI.24<<

                ItemJournalLine.VALIDATE("Item No.", InterfaceEntryLineVIP."No.");
                ItemJournalLine.VALIDATE("Location Code", InterfaceEntryLineVIP."Location Code");
                ItemJournalLine.VALIDATE("Zone Code FND", InterfaceEntryLineVIP."Item Code");
                ItemJournalLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Currency Code");
                //CSO+
                ItemJournalLine.VALIDATE("Unit of Measure Code", InterfaceEntryLineVIP."Unit of Measure Code");
                //CSO-
                ItemJournalLine.VALIDATE(Quantity, InterfaceEntryLineVIP.Quantity);
                if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt." then
                    ItemJournalLine.VALIDATE("Expiration Date", InterfaceEntryLineVIP."Expected Delivery Date");

                if Item.GET(ItemJournalLine."Item No.") then begin
                    if (Item."Item Tracking Code" <> '') then begin
                        if ItemTrackingCode.GET(Item."Item Tracking Code") then begin
                            if (ItemTrackingCode."Lot Purchase Outbound Tracking") and (ItemTrackingCode."Lot Sales Outbound Tracking") and (ItemTrackingCode."Lot Pos. Adjmt. Outb. Tracking")
                                  and (ItemTrackingCode."Lot Neg. Adjmt. Outb. Tracking") and (ItemTrackingCode."Lot Manuf. Outbound Tracking") then
                                CreateReservationEntriesForItemJournal(InterfaceEntryLineVIP, ItemJournalLine, InterfaceEntryLineVIP."Cross-Ref. No. Reflex 1st")
                            else
                                CreateReservationEntriesForItemJournal(InterfaceEntryLineVIP, ItemJournalLine, '');
                        end;
                    end;
                end;

                ItemJournalLine.VALIDATE("Reason Code", InterfaceEntryLineVIP."Customer Code");
                ItemJournalLine.MODIFY;
            until InterfaceEntryLineVIP.NEXT = 0;

        if TempItemJournalTemplate.FINDSET then
            repeat
                ItemJournalLine.SETRANGE("Journal Template Name", TempItemJournalTemplate.Name);
                ItemJournalLine.SETRANGE("Journal Batch Name", WMSInterfaceSetup."Stock Adjustment Batch");
                if ItemJournalLine.FINDSET then
                    //CSO+
                    //ItemJnlPostLine.RUN(ItemJournalLine);
                    ItemJnlPostBatch.RUN(ItemJournalLine);
                //CSO-
                //cso+
                ItemJournalLine.SETRANGE("Journal Template Name", TempItemJournalTemplate.Name);
                ItemJournalLine.SETRANGE("Journal Batch Name", WMSInterfaceSetup."Stock Adjustment Batch");
                if ItemJournalLine.FINDSET then
                    ItemJournalLine.DELETEALL;
            //CSO-
            until TempItemJournalTemplate.NEXT = 0;
        //<<HEI.04
    end;

    procedure CreateReservationEntriesForItemJournal(InterfaceEntryLine: Record "Interface Entry Line VIP INT"; ItemJournalLine: Record "Item Journal Line"; pLotNo: Code[20]);
    var
        LotNoInfo: Record "Lot No. Information";
        ResEntry: Record "Reservation Entry";
        Customer: Record Customer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        QtyToShipBase: Decimal;
        RemQtyToShipBase: Decimal;
        AvailLotQty: Decimal;
        ReservedQty: Decimal;
        SerialNo: Code[20];
        QtyPerUOM: Integer;
        Err000: Label 'Lot not available in NAV.';
        Err001: Label 'Lot quality issue.';
        Err002: Label 'Lot in wrong location.';
        Err003: Label 'Lot inventory insufficient.';
        Err004: Label 'Lot is blocked.';
    begin
        //>>HEI.02
        ResEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line");
        ResEntry.SETRANGE("Source ID", ItemJournalLine."Journal Template Name");
        ResEntry.SETRANGE("Source Ref. No.", ItemJournalLine."Line No.");
        ResEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ResEntry.SETRANGE("Source Subtype", ItemJournalLine."Entry Type");
        ResEntry.SETRANGE("Source Batch Name", ItemJournalLine."Journal Batch Name");
        ResEntry.SETRANGE("Source Prod. Order Line", 0);
        if not ResEntry.ISEMPTY then
            ResEntry.DELETEALL;

        LotNoInfo.RESET;
        // LotNoInfo.SETCURRENTKEY("Item No.", "Variant Code", "Quality Status"); //BC Upgrade GUNREM01 -DIT field
        LotNoInfo.SETRANGE("Item No.", ItemJournalLine."Item No.");
        LotNoInfo.SETRANGE("Variant Code", ItemJournalLine."Variant Code");
        //   LotNoInfo.SETFILTER("Quality Status", '%1|%2', LotNoInfo."Quality Status"::Pass, LotNoInfo."Quality Status"::Quarantine); //BC Upgrade GUNREM01 -DIT field
        LotNoInfo.SETRANGE("Location Filter", ItemJournalLine."Location Code");
        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." then
            LotNoInfo.SETFILTER(Inventory, '>0');
        LotNoInfo.SETRANGE(LotNoInfo.Blocked, false);
        if pLotNo <> '' then
            LotNoInfo.SETRANGE(LotNoInfo."Lot No.", pLotNo);  //Added
        LotNoInfo.SETFILTER("Date Filter", '%1..%2', 00000101D, TODAY);
        if LotNoInfo.FINDLAST then begin
            QtyToShipBase := ItemJournalLine.Quantity;  //Added - HEI.01
            RemQtyToShipBase := QtyToShipBase;
            // Cycle through Available Lots
            repeat
                LotNoInfo.CALCFIELDS(Inventory, "Expired Inventory");

                //HEI.08>>
                //IF (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt.") OR ((LotNoInfo.Inventory - LotNoInfo."Expired Inventory") > 0) THEN BEGIN
                if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt.") or ((LotNoInfo.Inventory - LotNoInfo."Expired Inventory") >= 0) then begin
                    //HEI.08<<
                    //Calculate Available Qty to Ship
                    if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." then begin
                        CLEAR(ReservedQty);
                        ResEntry.RESET;
                        ResEntry.SETCURRENTKEY("Item No.", "Variant Code", "Location Code", "Item Tracking", "Reservation Status", "Lot No.", "Serial No.");
                        ResEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
                        ResEntry.SETRANGE("Variant Code", ItemJournalLine."Variant Code");
                        ResEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
                        ResEntry.SETFILTER("Reservation Status", '%1|%2', 2, 3);    //Surplus, Prospect
                        ResEntry.SETRANGE("Lot No.", LotNoInfo."Lot No.");
                        ResEntry.SETRANGE(Positive, false);
                        if ResEntry.FINDSET then
                            repeat
                                ReservedQty += ResEntry."Quantity (Base)";
                            until ResEntry.NEXT = 0;

                        //HEI.08>>
                        //AvailLotQty := LotNoInfo.Inventory  - LotNoInfo."Expired Inventory" + ReservedQty;
                        AvailLotQty := LotNoInfo.Inventory + ReservedQty;
                        //HEI.08<<

                        AvailLotQty := CalcRoundedQty(AvailLotQty, LotNoInfo."Item No.", ItemJournalLine."Unit of Measure Code");

                        //Adjust Qty to Ship
                        if AvailLotQty > RemQtyToShipBase then begin
                            QtyToShipBase := RemQtyToShipBase;
                            RemQtyToShipBase := 0;
                        end else begin
                            if AvailLotQty < 0 then
                                QtyToShipBase := 0
                            else begin
                                QtyToShipBase := AvailLotQty;
                                RemQtyToShipBase := RemQtyToShipBase - AvailLotQty;
                            end;
                        end;
                    end else
                        QtyToShipBase := ItemJournalLine.Quantity;
                    if ItemUnitofMeasure.GET(ItemJournalLine."Item No.", ItemJournalLine."Unit of Measure Code") then
                        QtyPerUOM := ItemUnitofMeasure."Qty. per Unit of Measure"
                    else
                        QtyPerUOM := 1;
                    if QtyToShipBase > 0 then begin
                        // CreateReservEntry.CreateReservEntryFor(DATABASE::"Item Journal Line", ItemJournalLine."Entry Type", ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name", 0, ItemJournalLine."Line No.", QtyPerUOM,
                        //                   ItemJournalLine.Quantity * QtyPerUOM, QtyToShipBase * QtyPerUOM, SerialNo, LotNoInfo."Lot No.");
                        //BC Upgrade GUNREM01 -Changed reservation entry parameter >>
                        CreateReservEntry.CreateReservEntryFor(DATABASE::"Item Journal Line", ItemJournalLine."Entry Type".AsInteger(), ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name", 0, ItemJournalLine."Line No.", QtyPerUOM,
                                            ItemJournalLine.Quantity * QtyPerUOM, QtyToShipBase * QtyPerUOM, ResEntry);
                        //BC Upgrade GUNREM01 -Changed reservation entry parameter <<
                        CreateReservEntry.CreateEntry(ItemJournalLine."Item No.", ItemJournalLine."Variant Code", ItemJournalLine."Location Code", ItemJournalLine.Description, 0D, ItemJournalLine."Posting Date", 0, enumvalue::Prospect);
                    end;
                end;
            until (LotNoInfo.NEXT(-1) = 0) or (RemQtyToShipBase = 0);
        end else
          //ERROR(Text50000,pLotNo);  //commented by HEI.17
          //HEI.17<<
          begin
            LotNoInfo.RESET;
            //  LotNoInfo.SETCURRENTKEY("Item No.", "Variant Code", "Quality Status"); //BC Upgrade GUNREM01 -DIT field
            LotNoInfo.SETRANGE("Item No.", ItemJournalLine."Item No.");
            LotNoInfo.SETRANGE("Variant Code", ItemJournalLine."Variant Code");
            LotNoInfo.SETFILTER("Date Filter", '%1..%2', 00000101D, TODAY);
            if pLotNo <> '' then
                LotNoInfo.SETRANGE(LotNoInfo."Lot No.", pLotNo);
            if LotNoInfo.COUNT = 0 then
                ERROR(Err000 + ErrorTemplate, ItemJournalLine."Item No.", pLotNo, ItemJournalLine."Location Code",
                  ItemJournalLine."Zone Code FND", ItemJournalLine."Bin Code", ItemJournalLine.Quantity, ItemJournalLine."Unit of Measure Code", ItemJournalLine."Line No.");

            //  LotNoInfo.SETFILTER("Quality Status", '%1|%2', LotNoInfo."Quality Status"::Pass, LotNoInfo."Quality Status"::Quarantine);//BC Upgrade GUNREM01 -DIT field
            if LotNoInfo.COUNT = 0 then
                ERROR(Err001 + ErrorTemplate, ItemJournalLine."Item No.", pLotNo, ItemJournalLine."Location Code",
                  ItemJournalLine."Zone Code FND", ItemJournalLine."Bin Code", ItemJournalLine.Quantity, ItemJournalLine."Unit of Measure Code", ItemJournalLine."Line No.");

            LotNoInfo.SETRANGE("Location Filter", ItemJournalLine."Location Code");
            if LotNoInfo.COUNT = 0 then
                ERROR(Err002 + ErrorTemplate, ItemJournalLine."Item No.", pLotNo, ItemJournalLine."Location Code",
                  ItemJournalLine."Zone Code FND", ItemJournalLine."Bin Code", ItemJournalLine.Quantity, ItemJournalLine."Unit of Measure Code", ItemJournalLine."Line No.");

            if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." then begin
                LotNoInfo.SETFILTER(Inventory, '>0');
                if LotNoInfo.COUNT = 0 then
                    ERROR(Err003 + ErrorTemplate, ItemJournalLine."Item No.", pLotNo, ItemJournalLine."Location Code",
                      ItemJournalLine."Zone Code FND", ItemJournalLine."Bin Code", ItemJournalLine.Quantity, ItemJournalLine."Unit of Measure Code", ItemJournalLine."Line No.");
            end;

            LotNoInfo.SETRANGE(LotNoInfo.Blocked, false);
            if LotNoInfo.COUNT = 0 then
                ERROR(Err004 + ErrorTemplate, ItemJournalLine."Item No.", pLotNo, ItemJournalLine."Location Code",
                  ItemJournalLine."Zone Code FND", ItemJournalLine."Bin Code", ItemJournalLine.Quantity, ItemJournalLine."Unit of Measure Code", ItemJournalLine."Line No.");

        end
        //HEI.17<<
    end;

    local procedure GetItemJournalTemplate(ReasonCode: Code[20]): Code[10];
    var
        ItemJournalTemplate: Record "Item Journal Template";
    begin
        //>>HEI.04
        ItemJournalTemplate.SETRANGE(Type, ItemJournalTemplate.Type::Item);
        ItemJournalTemplate.SETRANGE("Reason Code", ReasonCode);
        if ItemJournalTemplate.FINDFIRST then
            exit(ItemJournalTemplate.Name);

        WMSInterfaceSetup.TESTFIELD("Stock Adjustment Template");
        exit(WMSInterfaceSetup."Stock Adjustment Template");
        //<<HEI.04
    end;

    local procedure "----- TRANSFER SHIPMENTS--------------"();
    begin
    end;

    procedure ProcessTransferWhsShpmntRequestTC(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        WhseShptHeader: Record "Warehouse Shipment Header";
        GetSourceDocuments: Report "Get Source Documents";
        WhseRqst: Record "Warehouse Request";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TOBuffer: Record "Aging Band Buffer" temporary;
        TransferHeader: Record "Transfer Header";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        Location: Record Location;
        LocationCode: Text;
        lrWhseSourceFilterBuffer: Record "Warehouse Source Filter";
        WhseSetup: Record "Warehouse Setup";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        SalesLine: Record "Sales Line";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        WhsePostShipment: Codeunit "Whse.-Post Shipment";
        SalesPost: Codeunit "Sales-Post";
        TotalQtyfromFile: Decimal;
        StoreFirstBin: Code[20];
        QuantitySalesUOM: Decimal;
        ResEntry1: Record "Reservation Entry";
        WhseShipLineLast: Record "Warehouse Shipment Line";
        LotNo: Code[20];
        LotNoInfo: Record "Lot No. Information";
        AllowPosting: Boolean;
        Qty: Decimal;
        ExtDoc: Text[35];
        ErrorText001: Label 'Warehouse Shipment was created but could not be posted due to error on the lines.';
        ErrorText002: Label 'Warehouse Request is missing.';
    begin
        //HEI.28<<
        GetWMSInterfaceSetup;

        WMSInterfaceSetup.TESTFIELD("Warehouse TS Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Warehouse TS Interface");
        if not InterfaceSetup.Enabled then
            exit;

        WhseShptHeader.INIT;
        WhseShptHeader.VALIDATE("No.");
        WhseShptHeader.INSERT(true);
        WhseShptHeader.VALIDATE("Location Code", InterfaceEntryHeaderVIP."Location Code");
        WhseShptHeader."WMS Import FND" := true;
        // WhseShptHeader.VALIDATE("External Document No.", InterfaceEntryHeaderVIP."Source No.");  //HEI.34 Code Commented
        /*//HEI.29<<
        WhseShptHeader.VALIDATE("Driver Code", InterfaceEntryHeaderVIP."Buy-from Vendor No.");
        WhseShptHeader.VALIDATE("Truck Code", InterfaceEntryHeaderVIP."Sell-to Customer No.");
        *///HEI.29>>
        WhseShptHeader.VALIDATE("Shipping Agent Code", InterfaceEntryHeaderVIP."Currency Code");
        WhseShptHeader.VALIDATE("Shipping Agent Service Code", InterfaceEntryHeaderVIP."Pay-to Vendor No.");
        //HEI.29<<
        //BC Upgrade GUNREM01 -DIT fields >>
        // WhseShptHeader.VALIDATE("Truck Code", InterfaceEntryHeaderVIP."Sell-to Customer No.");
        // WhseShptHeader.VALIDATE("Driver Code", InterfaceEntryHeaderVIP."Buy-from Vendor No.");
        //BC Upgrade GUNREM01 -DIT fields <<
        //HEI.29>>
        //HEI.34 >>
        //BC UPGRADE KUMARR78 ++11-05-2026 >>
        WhseShptHeader.Validate("Vehicle Code 101FDW", InterfaceEntryHeaderVIP."Sell-to Customer No.");
        WhseShptHeader.Validate("Log Driver 107FDW", InterfaceEntryHeaderVIP."Buy-from Vendor No.");
        //BC UPGRADE KUMARR78 ++11-05-2026 <<
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDFIRST then begin
            if TransferHeader.GET(InterfaceEntryLineVIP."Item Code") then begin
                WhseShptHeader.VALIDATE("Shipment Date", TransferHeader."Shipment Date");
                WhseShptHeader.VALIDATE("Posting Date", TransferHeader."Posting Date");
            end;
        end;
        //HEI.34 <<
        WhseShptHeader.MODIFY(true);

        TOBuffer.DELETEALL;
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDSET then
            repeat
                if not TOBuffer.GET(InterfaceEntryLineVIP."Item Code") then begin
                    if TransferHeader.GET(InterfaceEntryLineVIP."Item Code") then begin
                        TOBuffer."Currency Code" := InterfaceEntryLineVIP."Item Code";
                        TOBuffer.INSERT;

                        GetSourceDocOutbound.CheckTransferHeader(TransferHeader, true);
                        WhseRqst.SETRANGE(Type, WhseRqst.Type::Outbound);
                        WhseRqst.SETRANGE("Source Type", DATABASE::"Transfer Line");
                        WhseRqst.SETRANGE("Source Subtype", 0);
                        WhseRqst.SETRANGE("Source No.", TransferHeader."No.");
                        WhseRqst.SETRANGE("Document Status", WhseRqst."Document Status"::Released);
                        CLEAR(LocationCode);

                        if WhseRqst.FINDSET then begin
                            repeat
                                if Location.RequireShipment(WhseRqst."Location Code") then
                                    LocationCode += WhseRqst."Location Code" + '|';
                            until WhseRqst.NEXT = 0;
                            if LocationCode <> '' then
                                LocationCode := COPYSTR(LocationCode, 1, STRLEN(LocationCode) - 1);
                            WhseRqst.SETFILTER("Location Code", LocationCode);
                        end;

                        if not WhseRqst.ISEMPTY then begin
                            CLEAR(GetSourceDocuments);
                            GetSourceDocuments.SetOneCreatedShptHeader(WhseShptHeader);
                            // lrWhseSourceFilterBuffer.SetCopyDefaultFromWhseSetup(); //BC Upgrade GUNREM01 -DIT Function
                            // GetSourceDocuments.SetWhseSourceFilter(lrWhseSourceFilterBuffer); //BC Upgrade GUNREM01 -DIT Function
                            WhseSetup.GET();
                            // GetSourceDocuments.SetCreateMultiWhseHeader(0); //BC Upgrade GUNREM01 -DIT Function
                            // GetSourceDocuments.SetWhseHeaderPerPhysLoc(WhseSetup."Whse. Doc. per Phys. Location"); //BC Upgrade GUNREM01 -DIT Function
                            GetSourceDocuments.SetSkipBlocked(true);
                            GetSourceDocuments.USEREQUESTPAGE(false);
                            GetSourceDocuments.SETTABLEVIEW(WhseRqst);
                            GetSourceDocuments.SetHideDialog(true);
                            GetSourceDocuments.RUNMODAL;

                            WhseShptHeader."Document Status" := WhseShptHeader.GetDocumentStatus(0);
                            WhseShptHeader.MODIFY;
                        end;
                    end;
                end;
            until InterfaceEntryLineVIP.NEXT = 0;

        WarehouseShipmentLine.RESET;
        WarehouseShipmentLine.SETRANGE("No.", WhseShptHeader."No.");
        if WarehouseShipmentLine.FINDSET then
            repeat
                WarehouseShipmentLine.VALIDATE("Qty. to Ship", 0);
                WarehouseShipmentLine.MODIFY;

                //HEI.28<<
                ResEntry1.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line");
                ResEntry1.SETRANGE("Source ID", WarehouseShipmentLine."Source No.");
                ResEntry1.SETRANGE("Source Ref. No.", WarehouseShipmentLine."Source Line No.");
                ResEntry1.SETRANGE("Source Type", 5741);
                ResEntry1.SETRANGE("Source Batch Name", '');
                ResEntry1.SETRANGE("Source Prod. Order Line", 0);
                ResEntry1.DELETEALL;
            //HEI.28>>
            until WarehouseShipmentLine.NEXT = 0;

        AllowPosting := true;
        InterfaceEntryLineVIP.RESET;
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDSET then
            repeat
                WarehouseShipmentLine.RESET;
                WarehouseShipmentLine.SETRANGE("No.", WhseShptHeader."No.");
                WarehouseShipmentLine.SETRANGE("Source No.", InterfaceEntryLineVIP."Item Code");
                WarehouseShipmentLine.SETRANGE("Source Line No.", InterfaceEntryLineVIP."Source Line No.");
                WarehouseShipmentLine.SETRANGE("Item No.", InterfaceEntryLineVIP."No.");
                if WarehouseShipmentLine.FINDFIRST then begin
                    /*//HEI.28
                    ResEntry1.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line");
                    ResEntry1.SETRANGE("Source ID",WarehouseShipmentLine."Source No.");
                    ResEntry1.SETRANGE("Source Ref. No.",WarehouseShipmentLine."Source Line No.");
                    ResEntry1.SETRANGE("Source Type",5741);
                    ResEntry1.SETRANGE("Source Batch Name",'');
                    ResEntry1.SETRANGE("Source Prod. Order Line",0);
                    IF ResEntry1.FINDFIRST THEN
                      ResEntry1.DELETEALL;
                    *///HEI.28

                    TotalQtyfromFile := 0;
                    StoreFirstBin := InterfaceEntryLineVIP."Location Code";
                    QuantitySalesUOM := ConvertToSalesUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", WarehouseShipmentLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                    TotalQtyfromFile += QuantitySalesUOM;
                    //Lot check depending on setup
                    if (InterfaceEntryLineVIP.Quantity > 0) and Item.GET(WarehouseShipmentLine."Item No.") then begin
                        if (Item."Item Tracking Code" <> '') then begin
                            if ItemTrackingCode.GET(Item."Item Tracking Code") then begin
                                if (ItemTrackingCode."Lot Purchase Outbound Tracking") and (ItemTrackingCode."Lot Sales Outbound Tracking") and (ItemTrackingCode."Lot Pos. Adjmt. Outb. Tracking")
                                  and (ItemTrackingCode."Lot Neg. Adjmt. Outb. Tracking") and (ItemTrackingCode."Lot Manuf. Outbound Tracking") then
                                    LotNo := InterfaceEntryLineVIP."Post Code"
                                else
                                    LotNo := '';
                                LotNoInfo.RESET;
                                if CheckLotTC(LotNoInfo, InterfaceEntryLineVIP, WarehouseShipmentLine."Source No.", '', WarehouseShipmentLine."Source Line No.", 5741, 0,
                                  WarehouseShipmentLine."Item No.", WarehouseShipmentLine."Variant Code", WhseShptHeader."Location Code", WarehouseShipmentLine."Unit of Measure Code",
                                  WarehouseShipmentLine.Description, WarehouseShipmentLine."Shipment Date", LotNo, ConvertToBaseUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity))
                                then begin
                                    WarehouseShipmentLine.VALIDATE("Zone Code", InterfaceEntryLineVIP."External Contract No.");  //HEI.28
                                    WarehouseShipmentLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Location Code");
                                    WarehouseShipmentLine.VALIDATE("Qty. to Ship", WarehouseShipmentLine."Qty. to Ship" + QuantitySalesUOM);
                                    //BC Upgrade GUNREM01 -DIT fields >>
                                    // ExtDoc := WarehouseShipmentLine."External Document No.";
                                    // WarehouseShipmentLine."External Document No." := LotNo;
                                    // Qty := WarehouseShipmentLine."Cubage to Ship";
                                    // WarehouseShipmentLine."Cubage to Ship" := InterfaceEntryLineVIP.Quantity;
                                    //BC Upgrade GUNREM01 -DIT fields <<
                                    //BC UPGRADE KUMARR78 ++13-05-2026 >>
                                    Qty := WarehouseShipmentLine."Cubag To Ship FND";
                                    WarehouseShipmentLine."Cubag To Ship FND" := InterfaceEntryLineVIP.Quantity;
                                    ExtDoc := WarehouseShipmentLine."External Document No. FND";
                                    WarehouseShipmentLine."External Document No. FND" := LotNo;
                                    //BC UPGRADE KUMARR78 ++13-05-2026 <<
                                    WarehouseShipmentLine.MODIFY;

                                    COMMIT;
                                    // if CODEUNIT.RUN(50109, WarehouseShipmentLine) then begin //BC UPGRADE KUMARR78 --12-05-2026
                                    if Codeunit.Run(58055, WarehouseShipmentLine) then begin
                                        //BC UPGRADE KUMARR78 ++12-05-2026
                                        //BC Upgrade GUNREM01 -DIT fields >>
                                        // WarehouseShipmentLine."Cubage to Ship" := Qty;
                                        // WarehouseShipmentLine."External Document No." := ExtDoc;
                                        //BC Upgrade GUNREM01 -DIT fields <<
                                        //BC UPGRADE KUMARR78 >> ++13-05-2026
                                        WarehouseShipmentLine."Cubag To Ship FND" := Qty;
                                        WarehouseShipmentLine."External Document No. FND" := ExtDoc;
                                        //BC UPGRADE KUMARR78 << ++13-05-2026
                                        WarehouseShipmentLine.MODIFY;
                                    end else begin
                                        WarehouseShipmentLine.DELETE;

                                        WhseShipLineLast.RESET;
                                        WhseShipLineLast."No." := WhseShptHeader."No.";
                                        WhseShipLineLast.SETRANGE("No.", WhseShipLineLast."No.");
                                        if WhseShipLineLast.FINDLAST then;

                                        WhseShipLineLast.INIT;
                                        WhseShipLineLast."Line No." := WhseShipLineLast."Line No." + 10000;
                                        WhseShipLineLast."Source Type" := DATABASE::"Transfer Line";
                                        WhseShipLineLast."Source Document" := WhseShipLineLast."Source Document"::"Outbound Transfer";
                                        WhseShipLineLast."Source Subtype" := 0;
                                        WhseShipLineLast."Source No." := InterfaceEntryLineVIP."Item Code";
                                        WhseShipLineLast.Description := COPYSTR(GETLASTERRORTEXT, 1, 50);
                                        WhseShipLineLast.INSERT;
                                        AllowPosting := false;
                                    end;
                                end
                                else begin
                                    WarehouseShipmentLine.DELETE;

                                    WhseShipLineLast.RESET;
                                    WhseShipLineLast."No." := WhseShptHeader."No.";
                                    WhseShipLineLast.SETRANGE("No.", WhseShipLineLast."No.");
                                    if WhseShipLineLast.FINDLAST then;

                                    WhseShipLineLast.INIT;
                                    WhseShipLineLast."Line No." := WhseShipLineLast."Line No." + 10000;
                                    WhseShipLineLast."Source Type" := DATABASE::"Transfer Line";
                                    WhseShipLineLast."Source Document" := WhseShipLineLast."Source Document"::"Outbound Transfer";
                                    WhseShipLineLast."Source Subtype" := 0;
                                    WhseShipLineLast."Source No." := InterfaceEntryLineVIP."Item Code";
                                    WhseShipLineLast.Description := COPYSTR(GETLASTERRORTEXT, 1, 50);
                                    WhseShipLineLast.INSERT;
                                    AllowPosting := false;
                                end;
                            end;
                        end else begin    //HEI.31 >>
                            if CheckZoneBinTC(InterfaceEntryLineVIP, WhseShptHeader."Location Code") then begin    //HEI.32 >>
                                WarehouseShipmentLine.VALIDATE("Zone Code", InterfaceEntryLineVIP."External Contract No.");
                                WarehouseShipmentLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Location Code");
                                WarehouseShipmentLine.VALIDATE("Qty. to Ship", WarehouseShipmentLine."Qty. to Ship" + QuantitySalesUOM);
                                WarehouseShipmentLine.MODIFY;
                            end else begin  //HEI.32 >>
                                WarehouseShipmentLine.DELETE;

                                WhseShipLineLast.RESET;
                                WhseShipLineLast."No." := WhseShptHeader."No.";
                                WhseShipLineLast.SETRANGE("No.", WhseShipLineLast."No.");
                                if WhseShipLineLast.FINDLAST then;

                                WhseShipLineLast.INIT;
                                WhseShipLineLast."Line No." := WhseShipLineLast."Line No." + 10000;
                                WhseShipLineLast."Source Type" := DATABASE::"Sales Line";
                                WhseShipLineLast."Source Document" := WhseShipLineLast."Source Document"::"Sales Order";
                                WhseShipLineLast."Source Subtype" := 1;
                                WhseShipLineLast."Source No." := InterfaceEntryLineVIP."Item Code";
                                WhseShipLineLast.Description := COPYSTR(GETLASTERRORTEXT, 1, 50);
                                WhseShipLineLast.INSERT;
                                AllowPosting := false;
                            end;
                            //HEI.32 <<
                        end;
                        //HEI.31 <<
                    end;
                end else begin
                    WhseShipLineLast.RESET;
                    WhseShipLineLast."No." := WhseShptHeader."No.";
                    WhseShipLineLast.SETRANGE("No.", WhseShipLineLast."No.");
                    if WhseShipLineLast.FINDLAST then;

                    WhseShipLineLast.INIT;
                    WhseShipLineLast."Line No." := WhseShipLineLast."Line No." + 10000;
                    WhseShipLineLast."Source Type" := DATABASE::"Transfer Line";
                    WhseShipLineLast."Source Document" := WhseShipLineLast."Source Document"::"Outbound Transfer";
                    WhseShipLineLast."Source Subtype" := 0;
                    WhseShipLineLast."Source No." := InterfaceEntryLineVIP."Item Code";
                    WhseShipLineLast.Description := COPYSTR(InterfaceEntryLineVIP."Item Code" + '/' + FORMAT(InterfaceEntryLineVIP."Source Line No.") + ' ' + InterfaceEntryLineVIP."No." + ' not found or not Released', 1, 50);
                    WhseShipLineLast.INSERT;
                    AllowPosting := false;
                end;
            until InterfaceEntryLineVIP.NEXT = 0;

        WarehouseShipmentLine.RESET;
        WarehouseShipmentLine.SETRANGE("No.", WhseShptHeader."No.");
        WarehouseShipmentLine.SETFILTER("Qty. to Ship", '%1', 0);
        WarehouseShipmentLine.SETFILTER("Item No.", '<>%1', '');
        WarehouseShipmentLine.DELETEALL;

        if AllowPosting then begin
            if WMSInterfaceSetup."Post Inb. TS Interface" = WMSInterfaceSetup."Post Inb. TS Interface"::"Ship &Invoice" then
                WhsePostShipment.SetPostingSettings(true);
            COMMIT;
            if not WhsePostShipment.RUN(WarehouseShipmentLine) then begin
                WhseShptHeader.GET(WarehouseShipmentLine."No.");
                WhseShptHeader.DELETE(true);
                COMMIT;
                ERROR(GETLASTERRORTEXT);
            end;
        end else begin
            InterfaceEntryHeaderVIP."Error Message" := COPYSTR(ErrorText001, 1, MAXSTRLEN(InterfaceEntryHeaderVIP."Error Message"));
            InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Error;
            InterfaceEntryHeaderVIP.MODIFY;
            InterfaceFrameworkMgtVIP.LogInterfaceEntries(InterfaceEntryHeaderVIP);
            InterfaceFrameworkMgtVIP.DeleteInterfaceEntries(InterfaceEntryHeaderVIP);
        end;
        //HEI.28>>

    end;

    procedure CreateTOSHReservationEntriesTC(InterfaceEntryLineQuantity: Decimal; pSourceNo: Code[20]; pSourceBatch: Code[10]; pSourceLineNo: Integer; pSourceType: Integer; pSourceSubtype: Integer; pItemNo: Code[20]; pVariantCode: Code[20]; pLocationCode: Code[10]; pUnitOfMeasureCode: Code[10]; pDescription: Text[50]; pShipmentDate: Date; pLotNo: Code[20]; pQuantity: Integer; pBinCode: Code[20]; pCheckInventory: Boolean);
    var
        LotNoInfo: Record "Lot No. Information";
        ResEntry: Record "Reservation Entry";
        Customer: Record Customer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        QtyToShipBase: Decimal;
        RemQtyToShipBase: Decimal;
        AvailLotQty: Decimal;
        ReservedQty: Decimal;
        SerialNo: Code[20];
        QtyPerUOM: Integer;
        Err000: Label 'Lot not available in NAV.';
        Err001: Label 'Lot quality issue.';
        Err002: Label 'Lot in wrong location.';
        Err003: Label 'Lot inventory insufficient.';
        Err004: Label 'Lot is blocked.';
    begin
        //HEI.28<<
        LotNoInfo.RESET;
        // LotNoInfo.SETCURRENTKEY("Item No.", "Variant Code", "Quality Status"); //BC Upgrade GUNREM01 -DIT field
        LotNoInfo.SETRANGE("Item No.", pItemNo);
        LotNoInfo.SETRANGE("Variant Code", pVariantCode);
        if pLotNo <> '' then
            LotNoInfo.SETRANGE(LotNoInfo."Lot No.", pLotNo);
        //LotNoInfo.SETFILTER("Quality Status", '%1|%2', LotNoInfo."Quality Status"::Pass, LotNoInfo."Quality Status"::Quarantine); //BC Upgrade GUNREM01 -DIT field
        LotNoInfo.SETRANGE("Location Filter", pLocationCode);
        if pCheckInventory then
            LotNoInfo.SETFILTER(Inventory, '>0');
        LotNoInfo.SETRANGE(LotNoInfo.Blocked, false);
        LotNoInfo.SETFILTER("Date Filter", '%1..%2', 00000101D, TODAY);  //HEI.33
        // LotNoInfo.SETRANGE("Date Filter",0D,TODAY);  //HEI.33 Code Commented
        if LotNoInfo.FINDLAST then begin
            QtyToShipBase := pQuantity;
            RemQtyToShipBase := QtyToShipBase;
            // Cycle through Available Lots
            repeat
                LotNoInfo.CALCFIELDS(Inventory, "Expired Inventory");
                if (not pCheckInventory) or ((LotNoInfo.Inventory - LotNoInfo."Expired Inventory") > 0) then begin
                    //Calculate Available Qty to Ship
                    CLEAR(ReservedQty);
                    ResEntry.RESET;
                    ResEntry.SETCURRENTKEY("Item No.", "Variant Code", "Location Code", "Item Tracking", "Reservation Status", "Lot No.", "Serial No.");
                    ResEntry.SETRANGE("Item No.", pItemNo);
                    ResEntry.SETRANGE("Variant Code", pVariantCode);
                    ResEntry.SETRANGE("Location Code", pLocationCode);
                    ResEntry.SETFILTER("Reservation Status", '%1|%2', 2, 3);    //Surplus, Prospect
                    ResEntry.SETRANGE("Lot No.", LotNoInfo."Lot No.");
                    ResEntry.SETRANGE(Positive, false);
                    if ResEntry.FINDSET then
                        repeat
                            ReservedQty += ResEntry."Quantity (Base)";
                        until ResEntry.NEXT = 0;
                    AvailLotQty := LotNoInfo.Inventory - LotNoInfo."Expired Inventory" + ReservedQty;
                    AvailLotQty := CalcRoundedQty(AvailLotQty, LotNoInfo."Item No.", pUnitOfMeasureCode);

                    if pCheckInventory then begin
                        //Adjust Qty to Ship
                        if AvailLotQty > RemQtyToShipBase then begin
                            QtyToShipBase := RemQtyToShipBase;
                            RemQtyToShipBase := 0;
                        end else begin
                            if AvailLotQty < 0 then
                                QtyToShipBase := 0
                            else begin
                                QtyToShipBase := AvailLotQty;
                                RemQtyToShipBase := RemQtyToShipBase - AvailLotQty;
                            end;
                        end;
                    end;

                    if ItemUnitofMeasure.GET(pItemNo, pUnitOfMeasureCode) then
                        QtyPerUOM := ItemUnitofMeasure."Qty. per Unit of Measure"
                    else
                        QtyPerUOM := 1;

                    if QtyToShipBase > 0 then begin
                        // CreateReservEntry.SetCustomFields('', '', pBinCode); //BC Upgrade GUNREM01 -DIT Function
                        //BC Upgrade GUNREM01 -changed the Reservation entry parameter >>
                        // CreateReservEntry.CreateReservEntryFor(pSourceType, pSourceSubtype, pSourceNo, pSourceBatch, 0, pSourceLineNo, QtyPerUOM, InterfaceEntryLineQuantity, QtyToShipBase, SerialNo,
                        //                                         LotNoInfo."Lot No.");
                        CreateReservEntry.CreateReservEntryFor(pSourceType, pSourceSubtype, pSourceNo, pSourceBatch, 0, pSourceLineNo, QtyPerUOM, InterfaceEntryLineQuantity, QtyToShipBase, ResEntry);
                        //BC Upgrade GUNREM01 -changed the Reservation entry parameter <<
                        CreateReservEntry.CreateEntry(pItemNo, pVariantCode, pLocationCode, pDescription, 0D, pShipmentDate, 0, enumvalue::Surplus);

                    end;
                end;
            until (LotNoInfo.NEXT(-1) = 0) or (RemQtyToShipBase = 0);
        end
        //HEI.28>>
    end;

    procedure ProcessTransferWhsShpmntRequest(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        TransferHeader: Record "Transfer Header";
        Location: Record Location;
    begin
        //>>HEI.05
        GetWMSInterfaceSetup;
        WMSInterfaceSetup.TESTFIELD("Warehouse TS Interface");
        if not InterfaceSetup.GET(WMSInterfaceSetup."Warehouse TS Interface") then exit;
        if not InterfaceSetup.Enabled then exit;

        TransferHeader.GET(InterfaceEntryHeaderVIP."Source No.");
        //BC Upgrade GUNREM01 -DIT fields >>
        // if (InterfaceEntryHeaderVIP."Buy-from Vendor No." <> '') then
        //     TransferHeader."Driver Code" := InterfaceEntryHeaderVIP."Buy-from Vendor No.";
        //BC Upgrade GUNREM01 -DIT fields <<
        if (InterfaceEntryHeaderVIP."Currency Code" <> '') then
            TransferHeader."Shipping Agent Code" := InterfaceEntryHeaderVIP."Currency Code";
        //BC Upgrade GUNREM01 -DIT fields >>
        // if (InterfaceEntryHeaderVIP."Sell-to Customer No." <> '') then
        //     TransferHeader."Truck Code" := InterfaceEntryHeaderVIP."Sell-to Customer No.";
        //BC Upgrade GUNREM01 -DIT fields <<
        if InterfaceEntryHeaderVIP."Pay-to Vendor No." <> '' then
            TransferHeader."Shipping Agent Service Code" := InterfaceEntryHeaderVIP."Pay-to Vendor No.";
        TransferHeader.MODIFY;
        COMMIT;

        TransferHeader.GET(InterfaceEntryHeaderVIP."Source No.");
        Location.GET(TransferHeader."Transfer-from Code");
        if Location."Require Shipment" then
            CreateAndPostTransferWhsShpmnt(TransferHeader, InterfaceEntryHeaderVIP)
        else
            PostTOShipment(TransferHeader, InterfaceEntryHeaderVIP);
        //<<HEI.05
    end;

    local procedure CreateAndPostTransferWhsShpmnt(var pTransferHeader: Record "Transfer Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TransferLine: Record "Transfer Line";
        Location: Record Location;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
        WhsePostShipment: Codeunit "Whse.-Post Shipment";
        TOPostShipment: Codeunit "TransferOrder-Post Shipment";
        TotalQtyfromFile: Decimal;
        GetWhseShpNo: Code[20];
        StoreFirstBin: Code[20];
        QuantitySalesUOM: Decimal;
        WhseSetup: Record "Warehouse Setup";
        ResEntry1: Record "Reservation Entry";
    begin
        //>>HEI.05
        //BC Upgrade GUNREM01 -"Auto.Release Transfer on Whse." DIT field >>
        // WhseSetup.GET;
        // if WhseSetup."Auto.Release Transfer on Whse." then begin
        //     CODEUNIT.RUN(CODEUNIT::"Release Transfer Document", pTransferHeader);
        // end;
        //BC Upgrade GUNREM01 -"Auto.Release Transfer on Whse." DIT field <<

        WarehouseShipmentHeader.SETRANGE("Source No. FND", pTransferHeader."No.");
        if WarehouseShipmentHeader.FINDSET then
            WarehouseShipmentHeader.DELETE(true);

        //GetSourceDocOutbound.Fct_Batchprocessing(true); //BC Upgrade GUNREM01 -DIT Function
        //GetSourceDocOutbound.CreateFromOutbndTransferOrder(pTransferHeader);
        GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(pTransferHeader);

        WarehouseShipmentLine.RESET;
        WarehouseShipmentLine.SETRANGE("Source No.", pTransferHeader."No.");
        if WarehouseShipmentLine.FINDFIRST then
            GetWhseShpNo := WarehouseShipmentLine."No.";

        //Assign qty in Wrshe Shipment Line's "Qty to Ship" field
        if WarehouseShipmentHeader.GET(GetWhseShpNo) then begin
            WarehouseShipmentHeader.LOCKTABLE;
            //BC Upgrade GUNREM01 -DIT fields >>
            // if (InterfaceEntryHeaderVIP."Buy-from Vendor No." <> '') then
            //     WarehouseShipmentHeader."Driver Code" := InterfaceEntryHeaderVIP."Buy-from Vendor No.";
            //BC Upgrade GUNREM01 -DIT fields <<
            if (InterfaceEntryHeaderVIP."Currency Code" <> '') then
                WarehouseShipmentHeader."Shipping Agent Code" := InterfaceEntryHeaderVIP."Currency Code";
            //BC Upgrade GUNREM01 -DIT fields >>
            // if (InterfaceEntryHeaderVIP."Sell-to Customer No." <> '') then
            //     WarehouseShipmentHeader."Truck Code" := InterfaceEntryHeaderVIP."Sell-to Customer No.";
            //BC Upgrade GUNREM01 -DIT fields <<
            if InterfaceEntryHeaderVIP."Pay-to Vendor No." <> '' then
                WarehouseShipmentHeader."Shipping Agent Service Code" := InterfaceEntryHeaderVIP."Pay-to Vendor No.";
            WarehouseShipmentHeader.MODIFY;

            WarehouseShipmentLine.RESET;
            WarehouseShipmentLine.SETRANGE("No.", WarehouseShipmentHeader."No.");
            if WarehouseShipmentLine.FINDSET then
                repeat
                    TotalQtyfromFile := 0;
                    InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                    //InterfaceEntryLineVIP.SETRANGE("Source No.",WarehouseShipmentLine."Source No.");
                    InterfaceEntryLineVIP.SETRANGE("Source Line No.", WarehouseShipmentLine."Source Line No.");
                    InterfaceEntryLineVIP.SETRANGE("No.", WarehouseShipmentLine."Item No.");
                    if InterfaceEntryLineVIP.FINDSET then begin
                        ResEntry1.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line");
                        ResEntry1.SETRANGE("Source ID", WarehouseShipmentLine."Source No.");
                        ResEntry1.SETRANGE("Source Ref. No.", WarehouseShipmentLine."Source Line No.");
                        ResEntry1.SETRANGE("Source Type", 5741);
                        //ResEntry1.SETRANGE("Source Subtype",0);
                        ResEntry1.SETRANGE("Source Batch Name", '');
                        ResEntry1.SETRANGE("Source Prod. Order Line", 0);
                        if ResEntry1.FINDFIRST then
                            ResEntry1.DELETEALL;

                        repeat
                            if TransferLine.GET(WarehouseShipmentLine."Source No.", WarehouseShipmentLine."Source Line No.") then;
                            StoreFirstBin := InterfaceEntryLineVIP."Location Code";
                            //QuantitySalesUOM :=ConvertToSalesUOM(TransferLine."Item No.",InterfaceEntryLineVIP."Unit of Measure Code",TransferLine."Unit of Measure Code",InterfaceEntryLineVIP.Quantity);
                            QuantitySalesUOM := ConvertToSalesUOM(TransferLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", TransferLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                            TotalQtyfromFile += QuantitySalesUOM;
                            //Lot check depending on setup
                            if Item.GET(WarehouseShipmentLine."Item No.") then begin
                                if (Item."Item Tracking Code" <> '') then begin
                                    if ItemTrackingCode.GET(Item."Item Tracking Code") then begin

                                        if (ItemTrackingCode."Lot Purchase Outbound Tracking") and (ItemTrackingCode."Lot Sales Outbound Tracking") and (ItemTrackingCode."Lot Pos. Adjmt. Outb. Tracking")
                                              and (ItemTrackingCode."Lot Neg. Adjmt. Outb. Tracking") and (ItemTrackingCode."Lot Manuf. Outbound Tracking") then begin
                                            //>>Hei.04
                                            //CreateReservationEntries(InterfaceEntryLineVIP,WarehouseShipmentLine."Source No.",WarehouseShipmentLine."Source Line No.",WarehouseShipmentLine."Source Document",
                                            CreateReservationEntriesTOSH(InterfaceEntryLineVIP, WarehouseShipmentLine."Source No.", '', WarehouseShipmentLine."Source Line No.", 5741, 0,
                                              //<<Hei.04
                                              WarehouseShipmentLine."Item No.", WarehouseShipmentLine."Variant Code", WarehouseShipmentLine."Location Code", TransferLine."Unit of Measure Code",
                                              //WarehouseShipmentLine.Description,WarehouseShipmentLine."Shipment Date",InterfaceEntryLineVIP."Currency Code", //commented by HEI.07
                                              WarehouseShipmentLine.Description, WarehouseShipmentLine."Shipment Date", InterfaceEntryLineVIP."Post Code",       //HEI.07
                                              ConvertToBaseUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity), TransferLine."Transfer-from Bin Code", true);
                                            //<<Hei.04
                                            CreateReservationEntriesTOSH(InterfaceEntryLineVIP, WarehouseShipmentLine."Source No.", '', WarehouseShipmentLine."Source Line No.", 5741, 1,
                                              WarehouseShipmentLine."Item No.", WarehouseShipmentLine."Variant Code", WarehouseShipmentLine."Destination No.", TransferLine."Unit of Measure Code",
                                              //WarehouseShipmentLine.Description,WarehouseShipmentLine."Shipment Date",InterfaceEntryLineVIP."Currency Code",  //commented by HEI.07
                                              WarehouseShipmentLine.Description, WarehouseShipmentLine."Shipment Date", InterfaceEntryLineVIP."Post Code",        //HEI.07
                                              ConvertToBaseUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity), TransferLine."Transfer-To Bin Code", false);
                                        end else begin
                                            //>>Hei.04
                                            //CreateReservationEntries(InterfaceEntryLineVIP,WarehouseShipmentLine."Source No.",WarehouseShipmentLine."Source Line No.",WarehouseShipmentLine."Source Document",
                                            CreateReservationEntriesTOSH_Filtered(InterfaceEntryLineVIP, WarehouseShipmentLine."Source No.", '', WarehouseShipmentLine."Source Line No.", 5741, 0,
                                              //<<Hei.04
                                              WarehouseShipmentLine."Item No.", WarehouseShipmentLine."Variant Code", WarehouseShipmentLine."Location Code", TransferLine."Unit of Measure Code",
                                              WarehouseShipmentLine.Description, WarehouseShipmentLine."Shipment Date", '',
                                              ConvertToBaseUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity), TransferLine."Transfer-from Bin Code");
                                            //<<Hei.04
                                            CreateReservationEntriesTOSH_Filtered(InterfaceEntryLineVIP, WarehouseShipmentLine."Source No.", '', WarehouseShipmentLine."Source Line No.", 5741, 1,
                                              WarehouseShipmentLine."Item No.", WarehouseShipmentLine."Variant Code", WarehouseShipmentLine."Destination No.", TransferLine."Unit of Measure Code",
                                              WarehouseShipmentLine.Description, WarehouseShipmentLine."Shipment Date", '',
                                              ConvertToBaseUOM(WarehouseShipmentLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity), TransferLine."Transfer-To Bin Code");
                                        end;
                                    end;
                                end;
                            end;
                        until InterfaceEntryLineVIP.NEXT = 0;

                        WarehouseShipmentLine.VALIDATE("Qty. to Ship", TotalQtyfromFile);
                        WarehouseShipmentLine.VALIDATE("Zone Code", InterfaceEntryLineVIP."External Contract No.");
                        WarehouseShipmentLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Location Code");
                        WarehouseShipmentLine.MODIFY;
                    end else begin
                        WarehouseShipmentLine.VALIDATE("Qty. to Ship", 0);
                        WarehouseShipmentLine.MODIFY;
                    end;
                until WarehouseShipmentLine.NEXT = 0;
            if WMSInterfaceSetup."Post Inb. TS Interface" = WMSInterfaceSetup."Post Inb. TS Interface"::"Ship &Invoice" then
                WhsePostShipment.SetPostingSettings(true);
            WhsePostShipment.RUN(WarehouseShipmentLine);
        end;
        //<<HEI.05
    end;

    local procedure PostTOShipment(var pTransferHeader: Record "Transfer Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        Location: Record Location;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        TOPostShipment: Codeunit "TransferOrder-Post Shipment";
        TotalQtyfromFile: Decimal;
        QuantitySalesUOM: Decimal;
    begin
        //>>HEI.05
        TransferLine.SETRANGE("Document No.", pTransferHeader."No.");
        if TransferLine.FINDSET then
            repeat
                TotalQtyfromFile := 0;
                InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                //InterfaceEntryLineVIP.SETRANGE("Source No.",TransferLine."Document No.");
                InterfaceEntryLineVIP.SETRANGE("Source Line No.", TransferLine."Line No.");
                InterfaceEntryLineVIP.SETRANGE("No.", TransferLine."Item No.");
                if InterfaceEntryLineVIP.FINDSET then begin
                    repeat
                        //QuantitySalesUOM := ConvertToSalesUOM(TransferLine."Item No.",InterfaceEntryLineVIP."Unit of Measure Code",TransferLine."Unit of Measure Code",InterfaceEntryLineVIP.Quantity);
                        QuantitySalesUOM := ConvertToSalesUOM(TransferLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", TransferLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                        TotalQtyfromFile += QuantitySalesUOM;
                        TransferLine.VALIDATE("Qty. to Ship", TotalQtyfromFile);
                        TransferLine.MODIFY;
                        //Lot Check depending upon setup
                        if Item.GET(TransferLine."Item No.") then begin
                            if (Item."Item Tracking Code" <> '') then begin
                                if ItemTrackingCode.GET(Item."Item Tracking Code") then begin
                                    if (ItemTrackingCode."Lot Purchase Outbound Tracking") and (ItemTrackingCode."Lot Sales Outbound Tracking") and (ItemTrackingCode."Lot Pos. Adjmt. Outb. Tracking")
                                        and (ItemTrackingCode."Lot Neg. Adjmt. Outb. Tracking") and (ItemTrackingCode."Lot Manuf. Outbound Tracking") then
                                        //>>HEI.04
                                        //CreateReservationEntries(InterfaceEntryLineVIP,SalesLine."Document No.",SalesLine."Line No.",SalesLine."Document Type",SalesLine."No.",SalesLine."Variant Code",
                                        CreateReservationEntries(InterfaceEntryLineVIP, TransferLine."Document No.", '', TransferLine."Line No.", 5741, 0, TransferLine."Item No.", TransferLine."Variant Code",
                      //<<HEI.04
                      TransferLine."Transfer-from Code", TransferLine."Unit of Measure Code", TransferLine.Description, TransferLine."Shipment Date", InterfaceEntryLineVIP."Currency Code",
                      ConvertToBaseUOM(TransferLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity))
                                    else
                                        //>>HEI.04
                                        //CreateReservationEntries(InterfaceEntryLineVIP,SalesLine."Document No.",SalesLine."Line No.",SalesLine."Document Type",SalesLine."No.",SalesLine."Variant Code",
                                        CreateReservationEntries(InterfaceEntryLineVIP, TransferLine."Document No.", '', TransferLine."Line No.", 5741, 0, TransferLine."Item No.", TransferLine."Variant Code",
                      //<<HEI.04
                      TransferLine."Transfer-from Code", TransferLine."Unit of Measure Code", TransferLine.Description, TransferLine."Shipment Date", '',
                      ConvertToBaseUOM(TransferLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", InterfaceEntryLineVIP.Quantity));
                                end;
                            end;
                        end;
                    until InterfaceEntryLineVIP.NEXT = 0;
                end else begin
                    TransferLine.VALIDATE("Qty. to Ship", 0);
                    TransferLine.MODIFY;
                end;
            until TransferLine.NEXT = 0;
        if WMSInterfaceSetup."Post Inb. TS Interface" = WMSInterfaceSetup."Post Inb. TS Interface"::"Ship &Invoice" then;
        TOPostShipment.RUN(TransferHeader);
        //<<HEI.05
    end;

    procedure CreateReservationEntriesTOSH(InterfaceEntryLine: Record "Interface Entry Line VIP INT"; pSourceNo: Code[20]; pSourceBatch: Code[10]; pSourceLineNo: Integer; pSourceType: Integer; pSourceSubtype: Integer; pItemNo: Code[20]; pVariantCode: Code[20]; pLocationCode: Code[10]; pUnitOfMeasureCode: Code[10]; pDescription: Text[50]; pShipmentDate: Date; pLotNo: Code[20]; pQuantity: Integer; pBinCode: Code[20]; pCheckInventory: Boolean);
    var
        LotNoInfo: Record "Lot No. Information";
        ResEntry: Record "Reservation Entry";
        Customer: Record Customer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        QtyToShipBase: Decimal;
        RemQtyToShipBase: Decimal;
        AvailLotQty: Decimal;
        ReservedQty: Decimal;
        SerialNo: Code[20];
        QtyPerUOM: Integer;
        Err000: Label 'Lot not available in NAV.';
        Err001: Label 'Lot quality issue.';
        Err002: Label 'Lot in wrong location.';
        Err003: Label 'Lot inventory insufficient.';
        Err004: Label 'Lot is blocked.';
    begin
        //>>HEI.02
        /*ResEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line");
        ResEntry.SETRANGE("Source ID",pSourceNo);
        ResEntry.SETRANGE("Source Ref. No.",pSourceLineNo);
        ResEntry.SETRANGE("Source Type",pSourceType);
        ResEntry.SETRANGE("Source Subtype",pSourceSubtype);
        ResEntry.SETRANGE("Source Batch Name",pSourceBatch);
        ResEntry.SETRANGE("Source Prod. Order Line",0);
        IF ResEntry.FINDFIRST THEN
          ResEntry.DELETEALL;*/

        LotNoInfo.RESET;
        //  LotNoInfo.SETCURRENTKEY("Item No.", "Variant Code", "Quality Status"); //BC Upgrade GUNREM01 -DIT Field
        LotNoInfo.SETRANGE("Item No.", pItemNo);
        LotNoInfo.SETRANGE("Variant Code", pVariantCode);
        /*//commented by HEI.17
        LotNoInfo.SETFILTER("Quality Status",'%1|%2',LotNoInfo."Quality Status"::Pass,LotNoInfo."Quality Status"::Quarantine);
        LotNoInfo.SETRANGE("Location Filter",pLocationCode);
        IF pCheckInventory THEN
          LotNoInfo.SETFILTER(Inventory,'>0');
        LotNoInfo.SETRANGE(LotNoInfo.Blocked,FALSE);
        */ //commented by HEI.17
        if pLotNo <> '' then
            LotNoInfo.SETRANGE(LotNoInfo."Lot No.", pLotNo);  //Added
        //HEI.17<<
        if LotNoInfo.COUNT = 0 then
            ERROR(Err000 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        // LotNoInfo.SETFILTER("Quality Status", '%1|%2', LotNoInfo."Quality Status"::Pass, LotNoInfo."Quality Status"::Quarantine); //BC Upgrade GUNREM01 -DIT Field
        if LotNoInfo.COUNT = 0 then
            ERROR(Err001 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        LotNoInfo.SETRANGE("Location Filter", pLocationCode);
        if LotNoInfo.COUNT = 0 then
            ERROR(Err002 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        if pCheckInventory then begin
            LotNoInfo.SETFILTER(Inventory, '>0');
            if LotNoInfo.COUNT = 0 then
                ERROR(Err003 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        end;
        LotNoInfo.SETRANGE(LotNoInfo.Blocked, false);
        if LotNoInfo.COUNT = 0 then
            ERROR(Err004 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        //HEI.17>>
        LotNoInfo.SETFILTER("Date Filter", '%1..%2', 00000101D, TODAY);
        if LotNoInfo.FINDLAST then begin
            QtyToShipBase := pQuantity;  //Added - HEI.01
            RemQtyToShipBase := QtyToShipBase;
            // Cycle through Available Lots
            repeat
                LotNoInfo.CALCFIELDS(Inventory, "Expired Inventory");
                if (not pCheckInventory) or ((LotNoInfo.Inventory - LotNoInfo."Expired Inventory") > 0) then begin
                    //Calculate Available Qty to Ship
                    CLEAR(ReservedQty);
                    ResEntry.RESET;
                    ResEntry.SETCURRENTKEY("Item No.", "Variant Code", "Location Code", "Item Tracking", "Reservation Status", "Lot No.", "Serial No.");
                    ResEntry.SETRANGE("Item No.", pItemNo);
                    ResEntry.SETRANGE("Variant Code", pVariantCode);
                    ResEntry.SETRANGE("Location Code", pLocationCode);
                    ResEntry.SETFILTER("Reservation Status", '%1|%2', 2, 3);    //Surplus, Prospect
                    ResEntry.SETRANGE("Lot No.", LotNoInfo."Lot No.");
                    ResEntry.SETRANGE(Positive, false);
                    if ResEntry.FINDSET then
                        repeat
                            ReservedQty += ResEntry."Quantity (Base)";
                        until ResEntry.NEXT = 0;
                    AvailLotQty := LotNoInfo.Inventory - LotNoInfo."Expired Inventory" + ReservedQty;
                    AvailLotQty := CalcRoundedQty(AvailLotQty, LotNoInfo."Item No.", pUnitOfMeasureCode);

                    if pCheckInventory then begin
                        //Adjust Qty to Ship
                        if AvailLotQty > RemQtyToShipBase then begin
                            QtyToShipBase := RemQtyToShipBase;
                            RemQtyToShipBase := 0;
                        end else begin
                            if AvailLotQty < 0 then
                                QtyToShipBase := 0
                            else begin
                                QtyToShipBase := AvailLotQty;
                                RemQtyToShipBase := RemQtyToShipBase - AvailLotQty;
                            end;
                        end;
                    end;

                    if ItemUnitofMeasure.GET(pItemNo, pUnitOfMeasureCode) then
                        QtyPerUOM := ItemUnitofMeasure."Qty. per Unit of Measure"
                    else
                        QtyPerUOM := 1;

                    if QtyToShipBase > 0 then begin
                        //>>HEI.04
                        //CreateReservEntry.CreateReservEntryFor(DATABASE::"Sales Line",pSourceSubtype,pSourceNo,'',0,pSourceLineNo,QtyPerUOM,InterfaceEntryLine.Quantity,QtyToShipBase,SerialNo,
                        //                                        LotNoInfo."Lot No.");
                        // CreateReservEntry.SetCustomFields('', '', pBinCode); //BC Upgrade GUNREM01 -DIT function 
                        //BC Upgrade GUNREM01 Changed the Reservation enrty Parameter >> 
                        // CreateReservEntry.CreateReservEntryFor(pSourceType, pSourceSubtype, pSourceNo, pSourceBatch, 0, pSourceLineNo, QtyPerUOM, InterfaceEntryLine.Quantity, QtyToShipBase, SerialNo,
                        //                                         LotNoInfo."Lot No.");
                        CreateReservEntry.CreateReservEntryFor(pSourceType, pSourceSubtype, pSourceNo, pSourceBatch, 0, pSourceLineNo, QtyPerUOM, InterfaceEntryLine.Quantity, QtyToShipBase, ResEntry);
                        //BC Upgrade GUNREM01 Changed the Reservation enrty Parameter <<
                        //<<HEI.04
                        CreateReservEntry.CreateEntry(pItemNo, pVariantCode, pLocationCode, pDescription, 0D, pShipmentDate, 0, enumvalue::Surplus);

                    end;
                end;
            until (LotNoInfo.NEXT(-1) = 0) or (RemQtyToShipBase = 0);
        end else
            //>>HEI.04
            //ERROR(Text50000,InterfaceEntryLine."Currency Code");
            //ERROR(Text50000,pLotNo);  //commented by HEI.17
            //<<HEI.04
            //HEI.17<<
            ERROR(Err000 + ErrorTemplate, pItemNo, pLotNo, pLocationCode, InterfaceEntryLine."External Contract No.", InterfaceEntryLine."Location Code", pQuantity, pUnitOfMeasureCode, InterfaceEntryLine."Source Line No.");
        //HEI.17<<
        //<<HEI.02

    end;

    procedure CreateReservationEntriesTOSH_Filtered(InterfaceEntryLine: Record "Interface Entry Line VIP INT"; pSourceNo: Code[20]; pSourceBatch: Code[10]; pSourceLineNo: Integer; pSourceType: Integer; pSourceSubtype: Integer; pItemNo: Code[20]; pVariantCode: Code[20]; pLocationCode: Code[10]; pUnitOfMeasureCode: Code[10]; pDescription: Text[50]; pShipmentDate: Date; pLotNo: Code[20]; pQuantity: Integer; pBinCode: Code[20]);
    var
        LotNoInfo: Record "Lot No. Information";
        ResEntry: Record "Reservation Entry";
        Customer: Record Customer;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        QtyToShipBase: Decimal;
        RemQtyToShipBase: Decimal;
        AvailLotQty: Decimal;
        ReservedQty: Decimal;
        SerialNo: Code[20];
        QtyPerUOM: Integer;
        ReservationEntry: Record "Reservation Entry";
        Lastentryno: Integer;
        g_recItem: Record Item;
        g_recItemUOM: Record "Item Unit of Measure";
        g_recItemUOMCompare: Record "Item Unit of Measure";
        StoreBUOM: Decimal;
    begin
        LotNoInfo.RESET;
        LotNoInfo.SETRANGE("Item No.", pItemNo);
        LotNoInfo.SETRANGE("Lot No.", pLotNo);
        if not LotNoInfo.FINDFIRST then begin
            LotNoInfo."Item No." := pItemNo;
            LotNoInfo."Variant Code" := '';
            LotNoInfo."Lot No." := pLotNo;
            LotNoInfo.INSERT(true);
        end;

        /*ResEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line");
        ResEntry.SETRANGE("Source ID",pSourceNo);
        ResEntry.SETRANGE("Source Ref. No.",pSourceLineNo);
        ResEntry.SETRANGE("Source Type",pSourceType);
        ResEntry.SETRANGE("Source Subtype",pSourceSubtype);
        //ResEntry.SETRANGE("Source Batch Name",pSourceBatch);
        ResEntry.SETRANGE("Source Prod. Order Line",0);
        ResEntry.SETRANGE("Lot No.",pLotNo);
        IF ResEntry.FINDFIRST THEN
          ResEntry.DELETEALL;*/

        if ReservationEntry.FINDLAST then
            Lastentryno := ReservationEntry."Entry No." + 1
        else
            Lastentryno := 1;

        ReservationEntry.RESET;
        ReservationEntry."Entry No." := Lastentryno;
        ReservationEntry.Positive := false;
        ReservationEntry."Item No." := pItemNo;
        ReservationEntry."Location Code" := pLocationCode;

        /*IF g_recItem.GET(interfaceentryline."No.") THEN BEGIN
          IF (g_recItem."Base Unit of Measure" <> interfaceentryline."Unit of Measure Code") THEN BEGIN
            IF g_recItemUOM.GET(interfaceentryline."No.",g_recItem."Base Unit of Measure") THEN
              StoreBUOM := g_recItemUOM."Qty. per Unit of Measure";
            IF g_recItemUOMCompare.GET(interfaceentryline."No.",interfaceentryline."Unit of Measure Code") THEN
              //StoreQtyUOM := ROUND((g_recItemUOMCompare."Qty. per Unit of Measure" * StoreBUOM),1,'='); //NEW-16-04-2019
              StoreQtyUOM := (g_recItemUOMCompare."Qty. per Unit of Measure" * StoreBUOM);
            ReservationEntry."Quantity (Base)" := StoreQtyUOM * (-interfaceentryline.Quantity);
            ReservationEntry."Qty. to Handle (Base)" := StoreQtyUOM * (-interfaceentryline.Quantity);
            ReservationEntry."Qty. to Invoice (Base)" := StoreQtyUOM * (-interfaceentryline.Quantity);
          END ELSE BEGIN
            ReservationEntry."Quantity (Base)" := (-interfaceentryline.Quantity);//p_TransLn."Qty. to Receive (Base)";//l_recIntrfcEntryLn.Quantity;//l_recIntrfcEntryLn."Qty. to Receive (Base)";
            ReservationEntry."Qty. to Handle (Base)" := (-interfaceentryline.Quantity);//p_TransLn."Qty. to Receive (Base)";
            ReservationEntry."Qty. to Invoice (Base)" := (-interfaceentryline.Quantity);//p_TransLn."Qty. to Receive (Base)";
          END;
        END;*/

        ReservationEntry."Quantity (Base)" := -pQuantity;
        ReservationEntry."Qty. to Handle (Base)" := -pQuantity;
        ReservationEntry."Qty. to Invoice (Base)" := -pQuantity;

        ReservationEntry."Reservation Status" := enumvalue::Surplus;
        ReservationEntry.Description := pDescription;
        ReservationEntry."Creation Date" := WORKDATE;
        ReservationEntry."Source Type" := pSourceType;
        ReservationEntry."Source Subtype" := pSourceSubtype;
        ReservationEntry."Source Prod. Order Line" := 0;
        ReservationEntry."Expected Receipt Date" := 0D;
        ReservationEntry."Source ID" := pSourceNo;
        ReservationEntry."Source Ref. No." := pSourceLineNo;
        ReservationEntry."Created By" := USERID;
        ReservationEntry."Source Batch Name" := '';
        ReservationEntry.Quantity := -pQuantity;
        ReservationEntry."Qty. per Unit of Measure" := pQuantity;
        ReservationEntry."Lot No." := pLotNo;
        ReservationEntry."New Lot No." := '';
        ReservationEntry."Variant Code" := '';
        ReservationEntry."Expiration Date" := pShipmentDate;
        ReservationEntry."New Expiration Date" := 0D;
        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
        // ReservationEntry."Bin Code" := pBinCode; //BC Upgrade GUNREM01 -DIT Field
        ReservationEntry.INSERT;

    end;

    local procedure "------- TRANSFER RECEIPT -------------"();
    begin
    end;

    procedure ProcessTransferWhsReceipt(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        TransferHeader: Record "Transfer Header";
        Location: Record Location;
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
    begin
        //>>HEI.06
        GetWMSInterfaceSetup;
        WMSInterfaceSetup.TESTFIELD("Warehouse RE Interface");
        if not InterfaceSetup.GET(WMSInterfaceSetup."Warehouse RE Interface") then exit;
        if not InterfaceSetup.Enabled then exit;

        if TransferHeader.GET(InterfaceEntryHeaderVIP."Source No.") then begin
            Location.GET(TransferHeader."Transfer-from Code");
            if Location."Require Receive" then
                CreateAndPostTransferWhsReceipt(TransferHeader, InterfaceEntryHeaderVIP)
            else
                PostTOReceipt(TransferHeader, InterfaceEntryHeaderVIP);
        end;
        //<<HEI.06
    end;

    local procedure CreateAndPostTransferWhsReceipt(var pTransferHeader: Record "Transfer Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TransferLine: Record "Transfer Line";
        Location: Record Location;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        WhsePostReceipt: Codeunit "Whse.-Post Receipt";
        TOPostReceipt: Codeunit "TransferOrder-Post Receipt";
        TotalQtyfromFile: Decimal;
        GetWhseRcptNo: Code[20];
        StoreFirstBin: Code[20];
        QuantitySalesUOM: Decimal;
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
        ShipNotDone: Label 'Receipt impossible because shipment not done before.';
    begin
        //>>HEI.06
        GetWMSInterfaceSetup;

        /*IF pTransferHeader.Status = pTransferHeader.Status::Released THEN
          ReleaseTransferDoc.Reopen(pTransferHeader);
        COMMIT;*/

        if not CanBeReceived(pTransferHeader) then
            ERROR(ShipNotDone);

        //Delete Warehouse Rcpt if exists
        WarehouseReceiptLine.RESET;
        WarehouseReceiptLine.SETRANGE("Source No.", pTransferHeader."No.");
        if WarehouseReceiptLine.FINDFIRST then begin
            if WarehouseReceiptHeader.GET(WarehouseReceiptLine."No.") then
                WarehouseReceiptHeader.DELETE(true);
        end;
        COMMIT;

        //CODEUNIT.RUN(CODEUNIT::"Release Transfer Document",pTransferHeader);
        //COMMIT;

        //GetSourceDocInbound.CreateFromInbndTransferOrder(pTransferHeader);
        GetSourceDocInbound.CreateFromInbndTransferOrderHideDialog(pTransferHeader);

        WarehouseReceiptLine.RESET;
        WarehouseReceiptLine.SETRANGE("Source No.", pTransferHeader."No.");
        if WarehouseReceiptLine.FINDFIRST then
            GetWhseRcptNo := WarehouseReceiptLine."No.";

        //Assign qty in Wrshe Recpt Line's "Qty to rcv" field
        WarehouseReceiptHeader.RESET;
        if WarehouseReceiptHeader.GET(GetWhseRcptNo) then begin
            WarehouseReceiptHeader."Posting Date" := InterfaceEntryHeaderVIP."Posting Date";
            WarehouseReceiptHeader.MODIFY(true);

            WarehouseReceiptLine.RESET;
            WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
            if WarehouseReceiptLine.FINDSET then
                repeat
                    TotalQtyfromFile := 0;
                    InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                    InterfaceEntryLineVIP.SETRANGE("Source Line No.", WarehouseReceiptLine."Source Line No.");
                    InterfaceEntryLineVIP.SETRANGE("No.", WarehouseReceiptLine."Item No.");
                    InterfaceEntryLineVIP.SETRANGE("External Contract Line No.", '0');
                    if InterfaceEntryLineVIP.FINDSET then begin
                        repeat
                            if InterfaceEntryLineVIP.Quantity <> 0 then
                                CheckLotQuantityBin(InterfaceEntryHeaderVIP, InterfaceEntryLineVIP);

                            if TransferLine.GET(WarehouseReceiptLine."Source No.", WarehouseReceiptLine."Source Line No.") then;
                            StoreFirstBin := InterfaceEntryLineVIP."Location Code";
                            QuantitySalesUOM := ConvertToSalesUOM(TransferLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", TransferLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                            TotalQtyfromFile += QuantitySalesUOM;
                        until InterfaceEntryLineVIP.NEXT = 0;

                        WarehouseReceiptLine.VALIDATE("Zone Code", InterfaceEntryLineVIP."External Contract No.");
                        WarehouseReceiptLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Location Code");
                        WarehouseReceiptLine.VALIDATE("Qty. to Receive", TotalQtyfromFile);
                        WarehouseReceiptLine.MODIFY;
                    end else begin
                        WarehouseReceiptLine.VALIDATE("Qty. to Receive", 0);
                        WarehouseReceiptLine.VALIDATE("Bin Code", '');
                        WarehouseReceiptLine.MODIFY;
                    end;

                    if WarehouseReceiptLine."Qty. to Receive" = 0 then
                        WarehouseReceiptLine.DELETE(true);
                until WarehouseReceiptLine.NEXT = 0;

            WhsePostReceipt.SetHideValidationDialog(true);
            WhsePostReceipt.RUN(WarehouseReceiptLine);

        end;
        //<<HEI.06

    end;

    local procedure PostTOReceipt(var pTransferHeader: Record "Transfer Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        Location: Record Location;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        TOPostReceipt: Codeunit "TransferOrder-Post Receipt";
        TotalQtyfromFile: Decimal;
        QuantitySalesUOM: Decimal;
    begin
        //>>HEI.06
        GetWMSInterfaceSetup;
        TransferLine.SETRANGE("Document No.", pTransferHeader."No.");
        if TransferLine.FINDSET then
            repeat
                TotalQtyfromFile := 0;
                InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                //InterfaceEntryLineVIP.SETRANGE("Source No.",TransferLine."Document No.");
                InterfaceEntryLineVIP.SETRANGE("Source Line No.", TransferLine."Line No.");
                InterfaceEntryLineVIP.SETRANGE("No.", TransferLine."Item No.");
                InterfaceEntryLineVIP.SETRANGE("External Contract Line No.", '0');
                if InterfaceEntryLineVIP.FINDSET then begin
                    repeat
                        QuantitySalesUOM := ConvertToSalesUOM(TransferLine."Item No.", WMSInterfaceSetup."Reflex 1st OUM", TransferLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                        TotalQtyfromFile += QuantitySalesUOM;
                        TransferLine.VALIDATE("Qty. to Receive", TotalQtyfromFile);
                        TransferLine.MODIFY;
                    until InterfaceEntryLineVIP.NEXT = 0;
                end else begin
                    TransferLine.VALIDATE("Qty. to Receive", 0);
                    TransferLine.MODIFY;
                end;
            until TransferLine.NEXT = 0;

        TOPostReceipt.RUN(TransferHeader);
        //<<HEI.06
    end;

    local procedure CheckLotQuantityBin(IEH_VIP: Record "Interface Entry Header VIP INT"; IEL_VIP: Record "Interface Entry Line VIP INT");
    var
        ResEntry: Record "Reservation Entry";
        Text001: Label 'Wrong Lot number.';
        Text002: Label 'Wrong Bin.';
        Text003: Label 'Wrong Quantity.';
    begin
        //ResEntry.SETCURRENTKEY("Source ID","Source Ref. No.","Source Type","Source Subtype","Source Batch Name","Source Prod. Order Line");
        ResEntry.RESET;
        ResEntry.SETRANGE("Source ID", IEH_VIP."Source No.");
        ResEntry.SETRANGE("Source Prod. Order Line", IEL_VIP."Source Line No.");
        ResEntry.SETRANGE("Source Type", 5741);
        ResEntry.SETRANGE("Source Subtype", 1);
        ResEntry.SETRANGE("Location Code", IEH_VIP."Location Code");
        ResEntry.SETRANGE("Item No.", IEL_VIP."No.");
        ResEntry.SETRANGE("Lot No.", IEL_VIP."Post Code");
        if ResEntry.COUNT = 0 then
            //ERROR(Text001, IEL_VIP."Post Code",IEL_VIP."Source Line No."); //commented by HEI.17
            //HEI.17<<
            ERROR(Text001 + ErrorTemplate, IEL_VIP."No.", IEL_VIP."Post Code", IEH_VIP."Location Code", IEL_VIP."External Contract No.", IEL_VIP."Location Code",
          IEL_VIP.Quantity, '', IEL_VIP."Source Line No.");
        //HEI.17>>
        //  ResEntry.SETRANGE("Bin Code", IEL_VIP."Location Code"); //BC Upgrade GUNREM01 -DIT Field
        if ResEntry.COUNT = 0 then
            //ERROR(Text002, IEL_VIP."Location Code", IEL_VIP."Source Line No.");  //commented by HEI.17
            //HEI.17<<
            ERROR(Text002 + ErrorTemplate, IEL_VIP."No.", IEL_VIP."Post Code", IEH_VIP."Location Code", IEL_VIP."External Contract No.", IEL_VIP."Location Code",
          IEL_VIP.Quantity, '', IEL_VIP."Source Line No.");
        //HEI.17>>
        ResEntry.SETFILTER("Quantity (Base)", '>=%1', IEL_VIP.Quantity);
        if ResEntry.COUNT = 0 then
            //ERROR(Text003, IEL_VIP.Quantity, IEL_VIP."Source Line No.");  //commented by HEI.17
            //HEI.17<<
            ERROR(Text003 + ErrorTemplate, IEL_VIP."No.", IEL_VIP."Post Code", IEH_VIP."Location Code", IEL_VIP."External Contract No.", IEL_VIP."Location Code",
          IEL_VIP.Quantity, '', IEL_VIP."Source Line No.");
        //HEI.17>>
        if ResEntry.FINDFIRST then begin
            ResEntry.VALIDATE("Qty. to Handle (Base)", IEL_VIP.Quantity);
            ResEntry.MODIFY(true);
        end;
    end;

    local procedure CanBeReceived(TH: Record "Transfer Header"): Boolean;
    var
        TL: Record "Transfer Line";
    begin
        TL.RESET;
        TL.SETRANGE("Document No.", TH."No.");
        if TL.FINDFIRST then
            repeat
                if TL."Quantity Shipped" > TL."Quantity Received" then
                    exit(true);
            until (TL.NEXT = 0);
        exit(false);
    end;

    local procedure "----WarehouseMovement----"();
    begin
    end;

    procedure ProcessWarehouseMovementRequest(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        TempItemJournalTemplate: Record "Item Journal Template" temporary;
        ItemJournalLine: Record "Item Journal Line";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        //  NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        LineNo: Integer;
        ItemJournalTemplateName: Code[10];
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        WarehouseActivityLine: Record "Warehouse Activity Line";
    begin
        //>>HEI.04

        GetWMSInterfaceSetup;

        WMSInterfaceSetup.TESTFIELD("Warehouse Shipment Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Warehouse Shipment Interface");
        if not InterfaceSetup.Enabled then
            exit;

        WarehouseActivityHeader.INIT;
        WarehouseActivityHeader.Type := WarehouseActivityHeader.Type::Movement;
        WarehouseActivityHeader."Zone transfer FND" := true;
        WarehouseActivityHeader.INSERT(true);
        WarehouseActivityHeader.VALIDATE("Location Code", InterfaceEntryHeaderVIP."Location Code");
        WarehouseActivityHeader.VALIDATE("From Zone Code FND", InterfaceEntryHeaderVIP."Buy-from Vendor No.");
        WarehouseActivityHeader.VALIDATE("To Zone Code FND", InterfaceEntryHeaderVIP."Sell-to Customer No.");
        WarehouseActivityHeader.VALIDATE("Posting Date", InterfaceEntryHeaderVIP."Posting Date");

        WarehouseActivityHeader.MODIFY;
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDSET then
            repeat

                LineNo += 10000;
                WarehouseActivityLine.INIT;
                WarehouseActivityLine."Action Type" := WarehouseActivityLine."Action Type"::Take;
                WarehouseActivityLine."Activity Type" := WarehouseActivityLine."Activity Type"::Movement;
                WarehouseActivityLine."No." := WarehouseActivityHeader."No.";
                WarehouseActivityLine."Line No." := LineNo;
                WarehouseActivityLine.VALIDATE("Item No.", InterfaceEntryLineVIP."No.");//HEI.19
                WarehouseActivityLine.INSERT(true);

                WarehouseActivityLine.RESET;
                WarehouseActivityLine.SETRANGE("Activity Type", WarehouseActivityLine."Activity Type"::Movement);
                WarehouseActivityLine.SETRANGE("No.", WarehouseActivityLine."No.");
                WarehouseActivityLine.SETRANGE("Line No.", LineNo);
                if WarehouseActivityLine.FINDFIRST then begin
                    /*//commented by HEI.17<<
                    WarehouseActivityLine.VALIDATE("Location Code",WarehouseActivityHeader."Location Code");
                    WarehouseActivityLine.VALIDATE("Zone Code",WarehouseActivityHeader."From Zone Code");
                    WarehouseActivityLine.VALIDATE("Item No.",InterfaceEntryLineVIP."No.");
                    WarehouseActivityLine.VALIDATE("Zone-Transfer",TRUE);

                    WarehouseActivityLine.VALIDATE("Unit of Measure Code",InterfaceEntryLineVIP."Unit of Measure Code");
                    WarehouseActivityLine.VALIDATE("Bin Code",InterfaceEntryLineVIP."Location Code");
                    //CSO+
                    WarehouseActivityLine.VALIDATE("In-Transit Zone Code",WarehouseActivityHeader."In-Transit Zone");
                    WarehouseActivityLine.VALIDATE("In-Transit Bin Code",WarehouseActivityHeader."In-Transit Bin");
                    //CSO-
                    WarehouseActivityLine.VALIDATE(Quantity,InterfaceEntryLineVIP.Quantity);
                    WarehouseActivityLine.VALIDATE("Lot No.",InterfaceEntryLineVIP."Customer Code");
                    WarehouseActivityLine.MODIFY;
                    *///commented by HEI.17>>
                      //HEI.17<<
                    if not ValidateWMfields(InterfaceEntryLineVIP, WarehouseActivityHeader, WarehouseActivityLine) then
                        ERROR(GETLASTERRORTEXT + ErrorTemplate, InterfaceEntryLineVIP."No.", InterfaceEntryLineVIP."Customer Code", WarehouseActivityHeader."Location Code",
                          WarehouseActivityHeader."From Zone Code FND", InterfaceEntryLineVIP."Location Code", InterfaceEntryLineVIP.Quantity, InterfaceEntryLineVIP."Unit of Measure Code", LineNo);
                    WarehouseActivityLine.MODIFY;
                    //HEI.17>>
                end;

                /*LineNo += 10000;
                WarehouseActivityLine.INIT;
                WarehouseActivityLine."Action Type" := WarehouseActivityLine."Action Type"::Place;
                WarehouseActivityLine."Activity Type" := WarehouseActivityLine."Activity Type"::Movement;
                WarehouseActivityLine."No." := WarehouseActivityHeader."No.";
                WarehouseActivityLine."Line No." := LineNo;
                WarehouseActivityLine.INSERT(TRUE);
                WarehouseActivityLine.VALIDATE("Location Code",WarehouseActivityHeader."Location Code");
                WarehouseActivityLine.VALIDATE("Zone Code",WarehouseActivityHeader."To Zone Code");
                WarehouseActivityLine.VALIDATE("Item No.",InterfaceEntryLineVIP."No.");
                WarehouseActivityLine.VALIDATE("Zone-Transfer",TRUE);
                WarehouseActivityLine.VALIDATE("Unit of Measure Code",InterfaceEntryLineVIP."Unit of Measure Code");
                WarehouseActivityLine.VALIDATE("Bin Code",InterfaceEntryLineVIP."Currency Code");
                //CSO+
                WarehouseActivityLine.VALIDATE("In-Transit Zone Code",WarehouseActivityHeader."In-Transit Zone");
                WarehouseActivityLine.VALIDATE("In-Transit Bin Code",WarehouseActivityHeader."In-Transit Bin");
                //CSO-
                WarehouseActivityLine.VALIDATE(Quantity,InterfaceEntryLineVIP.Quantity);
                WarehouseActivityLine.VALIDATE("Lot No.",InterfaceEntryLineVIP."Customer Code");
                WarehouseActivityLine.MODIFY;*/

                WarehouseActivityLine.RESET;
                WarehouseActivityLine.SETRANGE("Activity Type", WarehouseActivityLine."Activity Type"::Movement);
                WarehouseActivityLine.SETRANGE("No.", WarehouseActivityLine."No.");
                WarehouseActivityLine.SETRANGE("Action Type", WarehouseActivityLine."Action Type"::Place);
                WarehouseActivityLine.SETRANGE("Linked To Line No. FND", LineNo);    //HEI.16
                if WarehouseActivityLine.FINDFIRST then begin
                    /*//commented by HEI.17<<
                    WarehouseActivityLine.VALIDATE("Location Code",WarehouseActivityHeader."Location Code");
                    WarehouseActivityLine.VALIDATE("Zone Code",WarehouseActivityHeader."To Zone Code");
                    WarehouseActivityLine.VALIDATE("Item No.",InterfaceEntryLineVIP."No.");
                    WarehouseActivityLine.VALIDATE("Zone-Transfer",TRUE);
                    WarehouseActivityLine.VALIDATE("Unit of Measure Code",InterfaceEntryLineVIP."Unit of Measure Code");
                    WarehouseActivityLine.VALIDATE("Bin Code",InterfaceEntryLineVIP."Currency Code");
                    //CSO+
                    WarehouseActivityLine.VALIDATE("In-Transit Zone Code",WarehouseActivityHeader."In-Transit Zone");
                    WarehouseActivityLine.VALIDATE("In-Transit Bin Code",WarehouseActivityHeader."In-Transit Bin");
                    //CSO-
                    WarehouseActivityLine.VALIDATE(Quantity,InterfaceEntryLineVIP.Quantity);
                    WarehouseActivityLine.VALIDATE("Lot No.",InterfaceEntryLineVIP."Customer Code");
                    WarehouseActivityLine.MODIFY;
                    *///commented by HEI.17>>
                      //HEI.17<<
                    if not ValidateWMfields(InterfaceEntryLineVIP, WarehouseActivityHeader, WarehouseActivityLine) then
                        ERROR(GETLASTERRORTEXT + ErrorTemplate, InterfaceEntryLineVIP."No.", InterfaceEntryLineVIP."Customer Code", WarehouseActivityHeader."Location Code",
                          WarehouseActivityHeader."To Zone Code FND", InterfaceEntryLineVIP."Currency Code", InterfaceEntryLineVIP.Quantity, InterfaceEntryLineVIP."Unit of Measure Code", LineNo);
                    WarehouseActivityLine.MODIFY;
                    //HEI.17>>
                end;
            until InterfaceEntryLineVIP.NEXT = 0;

        WarehouseActivityLine.RESET;
        WarehouseActivityLine.SETRANGE("Activity Type", WarehouseActivityLine."Activity Type"::Movement);
        WarehouseActivityLine.SETRANGE("No.", WarehouseActivityLine."No.");
        WarehouseActivityHeader."Posting Type FND" := WarehouseActivityHeader."Posting Type FND"::Ship;
        WarehouseActivityHeader.MODIFY;
        CODEUNIT.RUN(CODEUNIT::"Whse.-Act.-Register (Yes/No)", WarehouseActivityLine);

        WarehouseActivityHeader.SETRANGE(Type, WarehouseActivityHeader.Type::Movement);
        WarehouseActivityHeader.SETRANGE("No.", WarehouseActivityLine."No.");
        if WarehouseActivityHeader.FINDFIRST then
            WarehouseActivityHeader."Posting Type FND" := WarehouseActivityHeader."Posting Type FND"::Receive;
        //CSO+
        //WarehouseActivityHeader.MODIFY;
        if WarehouseActivityHeader.MODIFY then
            //CSO-

            CODEUNIT.RUN(CODEUNIT::"Whse.-Act.-Register (Yes/No)", WarehouseActivityLine);
        //<<HEI.04

    end;

    [TryFunction]
    local procedure ValidateWMfields(var InterfaceLine: Record "Interface Entry Line VIP INT"; var WhseActHeader: Record "Warehouse Activity Header"; var WhseActLine: Record "Warehouse Activity Line");
    begin
        //HEI.17<<
        WhseActLine.VALIDATE("Location Code", WhseActHeader."Location Code");
        if WhseActLine."Action Type" = WhseActLine."Action Type"::Take then
            WhseActLine.VALIDATE("Zone Code", WhseActHeader."From Zone Code FND")
        else
            WhseActLine.VALIDATE("Zone Code", WhseActHeader."To Zone Code FND");
        WhseActLine.VALIDATE("Item No.", InterfaceLine."No.");
        WhseActLine.VALIDATE("Zone-Transfer FND", true);
        WhseActLine.VALIDATE("Unit of Measure Code", InterfaceLine."Unit of Measure Code");
        if WhseActLine."Action Type" = WhseActLine."Action Type"::Take then
            WhseActLine.VALIDATE("Bin Code", InterfaceLine."Location Code")
        else
            WhseActLine.VALIDATE("Bin Code", InterfaceLine."Currency Code");
        WhseActLine.VALIDATE("In-Transit Zone Code FND", WhseActHeader."In-Transit Zone FND");
        WhseActLine.VALIDATE("In-Transit Bin Code FND", WhseActHeader."In-Transit Bin FND");
        WhseActLine.VALIDATE(Quantity, InterfaceLine.Quantity);
        WhseActLine.VALIDATE("Lot No.", InterfaceLine."Customer Code");
        //HEI.17>>
    end;

    local procedure CreatesSalesReturnOrderEntry(var SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        Language: Record Language;
        ItemTranslation: Record "Item Translation";
        DefaultLanguageCode: Code[10];
        LineEntryNo: Integer;
    begin
        //>>HEI.20
        GetGeneralInterfaceSetup;
        GetCompanyInformation;
        GetWMSInterfaceSetup;
        if not InterfaceSetup.GET(WMSInterfaceSetup."SRO Interface") or not InterfaceSetup.Enabled then
            exit;
        if not CheckIfSalesLineExists(SalesHeader) then
            exit;

        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP."Interface Code" := WMSInterfaceSetup."SRO Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Sales Header";
        InterfaceEntryHeaderVIP."Source Subtype" := SalesHeader."Document Type".AsInteger();
        InterfaceEntryHeaderVIP."Source No." := SalesHeader."No.";
        InterfaceEntryHeaderVIP."Location Code" := SalesHeader."Location Code";
        InterfaceEntryHeaderVIP."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
        InterfaceEntryHeaderVIP."External Document No." := SalesHeader."External Document No.";
        InterfaceEntryHeaderVIP."Document Date" := SalesHeader."Requested Delivery Date";
        InterfaceEntryHeaderVIP.INSERT(true);

        CreateSalesReturnLineEntry(InterfaceEntryHeaderVIP, SalesHeader);
        SalesHeader."WMS Export FND" := true;
        SalesHeader.MODIFY;
        //<<HEI.20
    end;

    local procedure CreateSalesReturnLineEntry(InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT"; SalesHeader: Record "Sales Header");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SalesLine: Record "Sales Line";
        NextEntryNo: Integer;
        ItemLine: Record Item;
        SalesLine2: Record "Sales Line";
        IncludeSalesLine: Boolean;
        ExcludeSalesLine: Boolean;
    begin
        //<<HEI.20
        SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine2.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine2.SETRANGE(Type, SalesLine2.Type::Item);
        if SalesLine2.FINDSET then
            repeat
                IncludeSalesLine := false;
                ExcludeSalesLine := false;
                if ItemsIncludeExclude.GET(SalesLine2."No.") then begin
                    if ItemsIncludeExclude.Included then
                        IncludeSalesLine := true;
                    if ItemsIncludeExclude.Excluded then
                        ExcludeSalesLine := true;
                end;

                if not ExcludeSalesLine then begin
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                    SalesLine.SETRANGE("Line No.", SalesLine2."Line No.");
                    SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                    if (WMSInterfaceSetup."Item Category" <> '') and not IncludeSalesLine then
                        SalesLine.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                    if SalesLine.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineVIP);
                            InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            NextEntryNo := NextEntryNo + 1;
                            InterfaceEntryLineVIP."Entry No." := NextEntryNo;
                            InterfaceEntryLineVIP."Location Code" := SalesLine."Location Code";
                            InterfaceEntryLineVIP."No." := SalesLine."Document No.";
                            InterfaceEntryLineVIP."Currency Code" := SalesHeader."Sell-to Customer No.";
                            //InterfaceEntryLineVIP."Expected Delivery Date" := SalesHeader."Requested Delivery Date";  //commented by HEI.23
                            InterfaceEntryLineVIP."Payment Terms Code" := FORMAT(SalesHeader."Requested Delivery Date", 0, '<Year4><Month,2><Day,2>');  //HEI.23
                            InterfaceEntryLineVIP."Source Line No." := SalesLine."Line No.";
                            InterfaceEntryLineVIP."Item Code" := SalesLine."No.";
                            InterfaceEntryLineVIP.Quantity := ConvertToReflexPcs(SalesLine);
                            InterfaceEntryLineVIP."Traceability Code" := SalesLine."Bin Code";
                            InterfaceEntryLineVIP.INSERT(true);
                        until SalesLine.NEXT = 0;
                end;
            until SalesLine2.NEXT = 0;
        //HEI.20>>
    end;

    local procedure CreateSalesReturnOrderDeleteEntry(var SalesHeader: Record "Sales Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        //>>HEI.20
        GetCompanyInformation;
        GetWMSInterfaceSetup;
        WMSInterfaceSetup.TESTFIELD("SRO Deletion Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."SRO Deletion Interface");
        if not InterfaceSetup.Enabled then
            exit;

        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP."Interface Code" := WMSInterfaceSetup."SRO Deletion Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Sales Header";
        InterfaceEntryHeaderVIP."Currency Code" := 'DEL_RECEP';
        InterfaceEntryHeaderVIP."Source No." := SalesHeader."No.";
        InterfaceEntryHeaderVIP."Location Code" := SalesHeader."Location Code";
        InterfaceEntryHeaderVIP.INSERT(true);
        //<<HEI.20
    end;

    procedure ProcessSROWhsReceipt(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        SalesReturnHdr: Record "Sales Header";
        Location: Record Location;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        Error50000: Label 'There is no such document no - %1 found';
    begin
        //HEI.26>>
        GetWMSInterfaceSetup;
        WMSInterfaceSetup.TESTFIELD("Warehouse RE Interface");
        if not InterfaceSetup.GET(WMSInterfaceSetup."Warehouse RE Interface") then
            exit;
        if not InterfaceSetup.Enabled then
            exit;

        if SalesReturnHdr.GET(SalesReturnHdr."Document Type"::"Return Order", InterfaceEntryHeaderVIP."Source No.") then begin
            if Location.GET(SalesReturnHdr."Location Code") then
                if Location."Require Receive" then
                    CreateAndPostSROWhsReceipt(SalesReturnHdr, InterfaceEntryHeaderVIP);
        end else
            ERROR(Error50000, InterfaceEntryHeaderVIP."Source No.");
        //HEI.26<<
    end;

    local procedure CreateAndPostSROWhsReceipt(var pSalesReturnHeader: Record "Sales Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        SalesReturnLine: Record "Sales Line";
        Location: Record Location;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        WhsePostReceipt: Codeunit "Whse.-Post Receipt";
        TotalQtyfromFile: Decimal;
        GetWhseRcptNo: Code[20];
        SalesReturnFirstBin: Code[20];
        QuantitySalesReturnUOM: Decimal;
        WhseCreateSourceDocument: Codeunit "Whse.-Create Source Document";
        ResEntry: Record "Reservation Entry";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        StoreLotNo: Text;
        ReservationEntry: Record "Reservation Entry";
        Error001: Label 'Error on Warehouse Receipt creation.';
        Error002: Label 'Item %1 - line no. %2 cannot be found in the warehouse receipt.';
    begin
        //HEI.26>>
        GetWMSInterfaceSetup;

        //Delete Warehouse Rcpt if exists
        WarehouseReceiptLine.RESET;
        WarehouseReceiptLine.SETRANGE("Source No.", pSalesReturnHeader."No.");
        if WarehouseReceiptLine.FINDFIRST then begin
            if WarehouseReceiptHeader.GET(WarehouseReceiptLine."No.") then
                WarehouseReceiptHeader.DELETE(true);
        end;
        COMMIT;

        GetSourceDocInbound.CreateFromSalesReturnOrderHideDialog(pSalesReturnHeader);

        WarehouseReceiptLine.RESET;
        WarehouseReceiptLine.SETRANGE("Source No.", pSalesReturnHeader."No.");
        if WarehouseReceiptLine.FINDFIRST then
            GetWhseRcptNo := WarehouseReceiptLine."No.";

        //Assign qty in Wrshe Recpt Line's "Qty to rcv" field
        WarehouseReceiptHeader.RESET;
        if WarehouseReceiptHeader.GET(GetWhseRcptNo) then begin
            WarehouseReceiptHeader."Posting Date" := InterfaceEntryHeaderVIP."Posting Date";
            WarehouseReceiptHeader.MODIFY(true);

            InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
            InterfaceEntryLineVIP.SETRANGE("External Contract Line No.", '0');
            InterfaceEntryLineVIP.SETFILTER(Quantity, '<>%1', 0);
            if InterfaceEntryLineVIP.FINDSET then
                repeat
                    WarehouseReceiptLine.RESET;
                    WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
                    WarehouseReceiptLine.SETRANGE("Source Line No.", InterfaceEntryLineVIP."Source Line No.");
                    WarehouseReceiptLine.SETRANGE("Item No.", InterfaceEntryLineVIP."No.");
                    if WarehouseReceiptLine.COUNT = 0 then
                        ERROR(Error001 + Error002, InterfaceEntryLineVIP."No.", InterfaceEntryLineVIP."Source Line No.");
                until InterfaceEntryLineVIP.NEXT = 0;

            WarehouseReceiptLine.RESET;
            WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
            if WarehouseReceiptLine.FINDSET then
                repeat
                    TotalQtyfromFile := 0;
                    InterfaceEntryLineVIP.RESET;
                    InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                    InterfaceEntryLineVIP.SETRANGE("Source Line No.", WarehouseReceiptLine."Source Line No.");
                    InterfaceEntryLineVIP.SETRANGE("No.", WarehouseReceiptLine."Item No.");
                    InterfaceEntryLineVIP.SETRANGE("External Contract Line No.", '0');
                    if InterfaceEntryLineVIP.FINDSET then begin
                        ResEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line");
                        ResEntry.SETRANGE("Source ID", WarehouseReceiptLine."Source No.");
                        ResEntry.SETRANGE("Source Type", 37);
                        ResEntry.SETRANGE("Source Subtype", 5);
                        ResEntry.SETRANGE("Source Batch Name", '');
                        ResEntry.SETRANGE("Source Prod. Order Line", 0);
                        ResEntry.SETRANGE("Source Ref. No.", WarehouseReceiptLine."Source Line No.");
                        ResEntry.SETRANGE("Item No.", WarehouseReceiptLine."Item No.");
                        ResEntry.SETRANGE("Location Code", WarehouseReceiptLine."Location Code");
                        ResEntry.SETRANGE("Variant Code", '');
                        if ResEntry.FINDFIRST then
                            ResEntry.DELETEALL;

                        repeat
                            if SalesReturnLine.GET(SalesReturnLine."Document Type"::"Return Order", WarehouseReceiptLine."Source No.", WarehouseReceiptLine."Source Line No.") then;
                            SalesReturnFirstBin := InterfaceEntryLineVIP."Location Code";
                            QuantitySalesReturnUOM := ConvertToSalesUOM(SalesReturnLine."No.", WMSInterfaceSetup."Reflex 1st OUM", SalesReturnLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                            TotalQtyfromFile += QuantitySalesReturnUOM;

                            if (InterfaceEntryLineVIP.Quantity <> 0) and Item.GET(WarehouseReceiptLine."Item No.") then begin
                                if (Item."Item Tracking Code" <> '') then begin
                                    if ItemTrackingCode.GET(Item."Item Tracking Code") then begin
                                        if ItemTrackingCode."Lot Sales Inbound Tracking" then begin
                                            if (InterfaceEntryLineVIP."Post Code" <> '') then
                                                StoreLotNo := InterfaceEntryLineVIP."Post Code"
                                            else
                                                StoreLotNo := '';

                                            //  CreateReservEntry.SetCustomFields('', '', InterfaceEntryLineVIP."Location Code"); //BC Upgrade GUNREM01 DIT Function
                                            //BC Upgrade GUNREM01 -Changed the Parameter reservation entry >>
                                            // CreateReservEntry.CreateReservEntryFor(37, 5, WarehouseReceiptLine."Source No.", '', 0,
                                            //                   WarehouseReceiptLine."Source Line No.", WarehouseReceiptLine."Qty. per Unit of Measure",
                                            //                   QuantitySalesReturnUOM, InterfaceEntryLineVIP.Quantity, '', StoreLotNo);
                                            CreateReservEntry.CreateReservEntryFor(37, 5, WarehouseReceiptLine."Source No.", '', 0,
                                                             WarehouseReceiptLine."Source Line No.", WarehouseReceiptLine."Qty. per Unit of Measure",
                                                             QuantitySalesReturnUOM, InterfaceEntryLineVIP.Quantity, ResEntry);
                                            //BC Upgrade GUNREM01 -Changed the Parameter reservation entry <<
                                            CreateReservEntry.CreateEntry(WarehouseReceiptLine."Item No.", '', WarehouseReceiptLine."Location Code", '',
                                                              InterfaceEntryHeaderVIP."Posting Date", 0D, 0, enumvalue::Surplus);
                                        end;
                                    end;
                                end;
                            end;
                        until InterfaceEntryLineVIP.NEXT = 0;

                        WarehouseReceiptLine.VALIDATE("Qty. to Receive", TotalQtyfromFile);
                        WarehouseReceiptLine.VALIDATE("Zone Code", InterfaceEntryLineVIP."External Contract No.");
                        WarehouseReceiptLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Location Code");
                        WarehouseReceiptLine.MODIFY;
                    end else begin
                        WarehouseReceiptLine.VALIDATE("Qty. to Receive", 0);
                        WarehouseReceiptLine.VALIDATE("Bin Code", '');
                        WarehouseReceiptLine.MODIFY;
                    end;

                    if WarehouseReceiptLine."Qty. to Receive" = 0 then
                        WarehouseReceiptLine.DELETE(true);
                until WarehouseReceiptLine.NEXT = 0;

            WhsePostReceipt.SetHideValidationDialog(true);
            WhsePostReceipt.RUN(WarehouseReceiptLine);
        end else
            ERROR(Error001);
        //HEI.26<<
    end;

    local procedure "---------PURCHASE ORDER-------------------"();
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure WMSCreatePORequest(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        PurchAdditionalHdr: Record "Purchase Header Additional FND";
        CompanyInformation: Record "Company Information";
    begin
        //HEI.21>>
        GetWMSInterfaceSetup;
        GetGeneralInterfaceSetup;
        GetCompanyInformation;

        if not WMSInterfaceSetup."WMS Integration" then exit;
        if PurchaseHeader.ISTEMPORARY then
            exit;
        if PreviewMode then
            exit;
        if not InterfaceSetup.GET(WMSInterfaceSetup."Purchase Order Interface") then
            exit;
        if not InterfaceSetup.Enabled then
            exit;

        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;
        if PurchAdditionalHdr.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then
            if PurchAdditionalHdr."Import Identifier" then
                exit;

        if not CheckIfPurchaseLineExists(PurchaseHeader) then
            exit;
        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIP."Interface Code" := WMSInterfaceSetup."Purchase Order Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Purchase Header";
        InterfaceEntryHeaderVIP."Source Subtype" := PurchaseHeader."Document Type".AsInteger();
        InterfaceEntryHeaderVIP."Source No." := PurchaseHeader."No.";
        InterfaceEntryHeaderVIP."Location Code" := PurchaseHeader."Location Code";
        InterfaceEntryHeaderVIP."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
        InterfaceEntryHeaderVIP."Expected Receipt Date" := PurchaseHeader."Expected Receipt Date";
        InterfaceEntryHeaderVIP.INSERT(true);

        CreatePurchaseOrderLineEntry(InterfaceEntryHeaderVIP, PurchaseHeader);
        if PurchAdditionalHdr.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
            PurchAdditionalHdr."WMS Export INT" := true;
            PurchAdditionalHdr.MODIFY;
        end;
        //HEI.21<<
    end;

    local procedure CheckIfPurchaseLineExists(PurchHeader: Record "Purchase Header"): Boolean;
    var
        PurchLine: Record "Purchase Line";
        PurchLine2: Record "Purchase Line";
        IncludePurchLine: Boolean;
        ExcludePurchLine: Boolean;
    begin
        //HEI.21>>
        GetWMSInterfaceSetup;
        PurchLine2.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine2.SETRANGE("Document No.", PurchHeader."No.");
        PurchLine2.SETRANGE(Type, PurchLine2.Type::Item);
        if PurchLine2.FINDSET then begin
            repeat
                ItemsIncludeExclude.RESET;
                if ItemsIncludeExclude.GET(PurchLine2."No.") then begin
                    if ItemsIncludeExclude.Included then
                        exit(true);
                end else begin
                    PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
                    PurchLine.SETRANGE("Document No.", PurchHeader."No.");
                    PurchLine.SETRANGE("Line No.", PurchLine2."Line No.");
                    if WMSInterfaceSetup."Item Category" <> '' then
                        PurchLine.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                    if PurchLine.FINDFIRST then
                        exit(true);
                end;
            until PurchLine2.NEXT = 0;
            exit(false);
        end else
            exit(false);
        //HEI.21<<
    end;

    local procedure CreatePurchaseOrderLineEntry(InterfaceEntryHeaderOut: Record "Interface Entry Header VIP INT"; PurchaseHeader: Record "Purchase Header");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        PurchaseLine: Record "Purchase Line";
        NextEntryNo: Integer;
        ItemLine: Record Item;
        PurchaseLine2: Record "Purchase Line";
        IncludePurchLine: Boolean;
        ExcludePurchLine: Boolean;
    begin
        //HEI.21>>
        PurchaseLine2.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine2.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine2.SETRANGE(Type, PurchaseLine2.Type::Item);
        if PurchaseLine2.FINDSET then
            repeat
                IncludePurchLine := false;
                ExcludePurchLine := false;
                if ItemsIncludeExclude.GET(PurchaseLine2."No.") then begin
                    if ItemsIncludeExclude.Included then
                        IncludePurchLine := true;
                    if ItemsIncludeExclude.Excluded then
                        ExcludePurchLine := true;
                end;

                if not ExcludePurchLine then begin
                    PurchaseLine.RESET;
                    PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                    PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                    PurchaseLine.SETRANGE("Line No.", PurchaseLine2."Line No.");
                    PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                    if not IncludePurchLine and (WMSInterfaceSetup."Item Category" <> '') then
                        PurchaseLine.SETFILTER("Item Category Code", WMSInterfaceSetup."Item Category");
                    if PurchaseLine.FINDSET then
                        repeat
                            CLEAR(InterfaceEntryLineVIP);
                            InterfaceEntryLineVIP."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                            NextEntryNo := NextEntryNo + 1;
                            InterfaceEntryLineVIP."Entry No." := NextEntryNo;
                            InterfaceEntryLineVIP."Source Line No." := PurchaseLine."Line No.";
                            InterfaceEntryLineVIP.Type := PurchaseLine.Type.AsInteger();
                            InterfaceEntryLineVIP."Item Code" := PurchaseLine."No.";
                            InterfaceEntryLineVIP."No." := PurchaseLine."Document No.";
                            InterfaceEntryLineVIP."Currency Code" := PurchaseLine."Buy-from Vendor No.";
                            //InterfaceEntryLineVIP."Expected Delivery Date" := PurchaseLine."Expected Receipt Date";   //commented by HEI.23
                            InterfaceEntryLineVIP."Payment Terms Code" := FORMAT(PurchaseLine."Expected Receipt Date", 0, '<Year4><Month,2><Day,2>');  //HEI.23
                            InterfaceEntryLineVIP."Location Code" := PurchaseLine."Location Code";
                            InterfaceEntryLineVIP.Quantity := ConvertToReflexPcsPurchase(PurchaseLine);
                            InterfaceEntryLineVIP."Post Code" := PurchaseLine."Bin Code";
                            InterfaceEntryLineVIP.INSERT(true);
                        until PurchaseLine.NEXT = 0;
                end;
            until PurchaseLine2.NEXT = 0;
        //HEI.21<<
    end;

    local procedure ConvertToReflexPcsPurchase(PurchLine: Record "Purchase Line"): Decimal;
    var
        PurchItemUnitOfMeasure: Record "Item Unit of Measure";
        ReflexItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        //HEI.21>>
        GetWMSInterfaceSetup;
        if (PurchLine."Unit of Measure Code" <> '') and (WMSInterfaceSetup."Reflex 1st OUM" <> '') then begin
            ReflexItemUnitOfMeasure.GET(PurchLine."No.", WMSInterfaceSetup."Reflex 1st OUM");
            PurchItemUnitOfMeasure.GET(PurchLine."No.", PurchLine."Unit of Measure Code");
            exit(ROUND((ROUND((PurchItemUnitOfMeasure."Qty. per Unit of Measure" /
              ReflexItemUnitOfMeasure."Qty. per Unit of Measure"), 1, '=') * PurchLine.Quantity), 1, '='));
        end;
        exit(PurchLine.Quantity);
        //HEI.21<<
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeletePurchaseOrder(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        PurchHdrAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.21>>
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."WMS Integration" then
            exit;
        if Rec.ISTEMPORARY then
            exit;
        if not RunTrigger then
            exit;

        if not InterfaceSetup.GET(WMSInterfaceSetup."Purchase Order Del Interface") then
            exit;
        if not InterfaceSetup.Enabled then
            exit;

        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;
        if PurchHdrAdditional.GET(Rec."Document Type"::Order, Rec."No.") then
            if not PurchHdrAdditional."WMS Export INT" then
                exit;

        CreatePurchaseOrderDeleteEntry(Rec);
        //HEI.21<<
    end;

    local procedure CreatePurchaseOrderDeleteEntry(var PurchaseHdr: Record "Purchase Header");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
        CompanyInformation: Record "Company Information";
    begin
        //HEI.21>>
        GetWMSInterfaceSetup;
        CompanyInformation.GET;
        WMSInterfaceSetup.TESTFIELD("Purchase Order Del Interface");
        InterfaceSetup.GET(WMSInterfaceSetup."Purchase Order Del Interface");
        if not InterfaceSetup.Enabled then
            exit;

        CLEAR(InterfaceEntryHeaderVIP);
        InterfaceEntryHeaderVIP."Message Creation DateTime" := CURRENTDATETIME;
        //InterfaceEntryHeaderVIP."Message Name" := 'SUPODPBDB';
        InterfaceEntryHeaderVIP."Interface Code" := WMSInterfaceSetup."Purchase Order Del Interface";
        InterfaceEntryHeaderVIP.Direction := InterfaceEntryHeaderVIP.Direction::Outbound;
        InterfaceEntryHeaderVIP.Status := InterfaceEntryHeaderVIP.Status::Pending;
        InterfaceEntryHeaderVIP."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderVIP."Source Type" := DATABASE::"Purchase Header";
        InterfaceEntryHeaderVIP."Source No." := PurchaseHdr."No.";
        InterfaceEntryHeaderVIP."Location Code" := PurchaseHdr."Location Code";
        InterfaceEntryHeaderVIP.INSERT(true);
        //HEI.21<<
    end;

    local procedure "---------PURCHASE RECEIPT---------------"();
    begin
    end;

    procedure WMSProcessPurchaseWhsReceipt(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        PurchaseHdr: Record "Purchase Header";
        Location: Record Location;
        ReleasePurchaseDoc: Codeunit "Release Purchase Document";
        Error50000: Label 'There is no such document no - %1 found';
    begin
        //HEI.21>>
        GetWMSInterfaceSetup;
        WMSInterfaceSetup.TESTFIELD("Warehouse RE Interface");
        if not InterfaceSetup.GET(WMSInterfaceSetup."Warehouse RE Interface") then
            exit;
        if not InterfaceSetup.Enabled then
            exit;

        if PurchaseHdr.GET(PurchaseHdr."Document Type"::Order, InterfaceEntryHeaderVIP."Source No.") then begin
            if Location.GET(PurchaseHdr."Location Code") then
                if Location."Require Receive" then
                    CreateAndPostPurchaseWhsReceipt(PurchaseHdr, InterfaceEntryHeaderVIP)
                else
                    PostPOReceipt(PurchaseHdr, InterfaceEntryHeaderVIP);
        end else
            ERROR(Error50000, InterfaceEntryHeaderVIP."Source No.");
        //HEI.21<<
    end;

    local procedure CreateAndPostPurchaseWhsReceipt(var pPurchHeader: Record "Purchase Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        PurchaseLine: Record "Purchase Line";
        Location: Record Location;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
        WhsePostReceipt: Codeunit "Whse.-Post Receipt";
        TotalQtyfromFile: Decimal;
        GetWhseRcptNo: Code[20];
        PurchaseFirstBin: Code[20];
        QuantityPurchaseUOM: Decimal;
        ShipNotDone: Label 'Receipt impossible because shipment not done before.';
        WhseCreateSourceDocument: Codeunit "Whse.-Create Source Document";
        ResEntry: Record "Reservation Entry";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        StoreLotNo: Text;
        ReservationEntry: Record "Reservation Entry";
        InterfaceDtWCode: Codeunit "InterfaceDtWCode";
    begin
        //HEI.21>>
        GetWMSInterfaceSetup;

        //Delete Warehouse Rcpt if exists
        WarehouseReceiptLine.RESET;
        WarehouseReceiptLine.SETRANGE("Source No.", pPurchHeader."No.");
        if WarehouseReceiptLine.FINDFIRST then begin
            if WarehouseReceiptHeader.GET(WarehouseReceiptLine."No.") then begin
                WarehouseReceiptHeader.SuppressConfirmBox(true);
                WarehouseReceiptHeader.DELETE(true);
            end;
        end;
        COMMIT;

        //  GetSourceDocInbound.SkipPageOpening(true);
        InterfaceDtWCode.SkipPageOpening(true);
        GetSourceDocInbound.CreateFromPurchOrder(pPurchHeader);

        WarehouseReceiptLine.RESET;
        WarehouseReceiptLine.SETRANGE("Source No.", pPurchHeader."No.");
        if WarehouseReceiptLine.FINDFIRST then
            GetWhseRcptNo := WarehouseReceiptLine."No.";

        //Assign qty in Wrshe Recpt Line's "Qty to rcv" field
        WarehouseReceiptHeader.RESET;
        if WarehouseReceiptHeader.GET(GetWhseRcptNo) then begin
            WarehouseReceiptHeader."Posting Date" := InterfaceEntryHeaderVIP."Posting Date";
            WarehouseReceiptHeader.MODIFY(true);

            WarehouseReceiptLine.RESET;
            WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
            if WarehouseReceiptLine.FINDSET then
                repeat
                    TotalQtyfromFile := 0;
                    InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                    InterfaceEntryLineVIP.SETRANGE("Source Line No.", WarehouseReceiptLine."Source Line No.");
                    InterfaceEntryLineVIP.SETRANGE("No.", WarehouseReceiptLine."Item No.");
                    //HEI.27>>
                    InterfaceEntryLineVIP.SETRANGE("External Contract Line No.", '0');
                    //HEI.27<<
                    if InterfaceEntryLineVIP.FINDSET then begin
                        //HEI.27>>
                        ResEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line");
                        ResEntry.SETRANGE("Source ID", WarehouseReceiptLine."Source No.");
                        ResEntry.SETRANGE("Source Type", 39);
                        ResEntry.SETRANGE("Source Subtype", 1);
                        ResEntry.SETRANGE("Source Batch Name", '');
                        ResEntry.SETRANGE("Source Prod. Order Line", 0);
                        ResEntry.SETRANGE("Source Ref. No.", WarehouseReceiptLine."Source Line No.");
                        ResEntry.SETRANGE("Item No.", WarehouseReceiptLine."Item No.");
                        ResEntry.SETRANGE("Location Code", WarehouseReceiptLine."Location Code");
                        ResEntry.SETRANGE("Variant Code", '');
                        if ResEntry.FINDFIRST then
                            ResEntry.DELETEALL;
                        //HEI.27<<
                        repeat
                            if PurchaseLine.GET(PurchaseLine."Document Type"::Order, WarehouseReceiptLine."Source No.", WarehouseReceiptLine."Source Line No.") then;
                            PurchaseFirstBin := InterfaceEntryLineVIP."Location Code";
                            QuantityPurchaseUOM := ConvertToPurchaseUOM(PurchaseLine."No.", WMSInterfaceSetup."Reflex 1st OUM",
                                                    PurchaseLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                            TotalQtyfromFile += QuantityPurchaseUOM;

                            if (InterfaceEntryLineVIP.Quantity <> 0) and Item.GET(WarehouseReceiptLine."Item No.") then begin
                                if (Item."Item Tracking Code" <> '') then begin
                                    if ItemTrackingCode.GET(Item."Item Tracking Code") then begin
                                        if ItemTrackingCode."Lot Purchase Inbound Tracking" then begin
                                            if (InterfaceEntryLineVIP."Post Code" <> '') then
                                                StoreLotNo := InterfaceEntryLineVIP."Post Code"
                                            else
                                                StoreLotNo := '';
                                            //BC Upgrade GUNREM01 -Changed the Parameter reservation entry <<
                                            // CreateReservEntry.CreateReservEntryFor(39, 1, WarehouseReceiptLine."Source No.", '', 0,
                                            //                   WarehouseReceiptLine."Source Line No.", WarehouseReceiptLine."Qty. per Unit of Measure",
                                            //                   QuantityPurchaseUOM, InterfaceEntryLineVIP.Quantity, '', StoreLotNo); //HEI.21
                                            CreateReservEntry.CreateReservEntryFor(39, 1, WarehouseReceiptLine."Source No.", '', 0,
                                          WarehouseReceiptLine."Source Line No.", WarehouseReceiptLine."Qty. per Unit of Measure",
                                          QuantityPurchaseUOM, InterfaceEntryLineVIP.Quantity, ResEntry); //HEI.21
                                                                                                          //BC Upgrade GUNREM01 -Changed the Parameter reservation entry <<
                                            CreateReservEntry.CreateEntry(WarehouseReceiptLine."Item No.", '', WarehouseReceiptLine."Location Code", '',
                                                              InterfaceEntryHeaderVIP."Posting Date", 0D, 0, enumvalue::Surplus);
                                        end;
                                        if (ItemTrackingCode."Strict Expiration Posting") and (InterfaceEntryLineVIP."Best Before Date" <> 0D) then begin
                                            ReservationEntry.RESET;
                                            ReservationEntry.SETRANGE("Source ID", WarehouseReceiptLine."Source No.");
                                            ReservationEntry.SETRANGE("Source Type", 39);
                                            ReservationEntry.SETRANGE("Source Subtype", 1);
                                            ReservationEntry.SETRANGE("Source Batch Name", '');
                                            ReservationEntry.SETRANGE("Source Prod. Order Line", 0);
                                            ReservationEntry.SETRANGE("Source Ref. No.", WarehouseReceiptLine."Source Line No.");
                                            ReservationEntry.SETRANGE("Item No.", WarehouseReceiptLine."Item No.");
                                            ReservationEntry.SETRANGE("Location Code", WarehouseReceiptLine."Location Code");
                                            ReservationEntry.SETRANGE("Lot No.", StoreLotNo);
                                            if ReservationEntry.FINDFIRST then begin
                                                ReservationEntry."Expiration Date" := InterfaceEntryLineVIP."Best Before Date";
                                                ReservationEntry.MODIFY;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        until InterfaceEntryLineVIP.NEXT = 0;

                        WarehouseReceiptLine.VALIDATE("Qty. to Receive", TotalQtyfromFile);
                        WarehouseReceiptLine.VALIDATE("Zone Code", InterfaceEntryLineVIP."External Contract No.");
                        WarehouseReceiptLine.VALIDATE("Bin Code", InterfaceEntryLineVIP."Location Code");
                        WarehouseReceiptLine.MODIFY;
                    end else begin
                        WarehouseReceiptLine.VALIDATE("Qty. to Receive", 0);
                        WarehouseReceiptLine.VALIDATE("Bin Code", '');
                        WarehouseReceiptLine.MODIFY;
                    end;

                //HEI.27>>
                //IF WarehouseReceiptLine."Qty. to Receive" = 0 THEN
                //  WarehouseReceiptLine.DELETE(TRUE);
                //HEI.27<<
                until WarehouseReceiptLine.NEXT = 0;

            //HEI.27>>
            WarehouseReceiptLine.RESET;
            WarehouseReceiptLine.SETRANGE("No.", WarehouseReceiptHeader."No.");
            WarehouseReceiptLine.SETFILTER("Qty. to Receive", '<>%1', 0);
            //HEI.27<<

            WhsePostReceipt.SetHideValidationDialog(true);
            WhsePostReceipt.RUN(WarehouseReceiptLine);
            //CODEUNIT.RUN(CODEUNIT::"Whse.-Post Receipt",WarehouseReceiptLine);
        end;
        //Update Purchase Line
        if (InterfaceEntryHeaderVIP."Your Reference" = 'Yes') then begin
            PurchaseLine.RESET;
            PurchaseLine.SETRANGE("Document Type", pPurchHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", pPurchHeader."No.");
            if PurchaseLine.FINDSET then
                repeat
                    PurchaseLine."Delivery Finalized FND" := true;
                    PurchaseLine.MODIFY;
                until PurchaseLine.NEXT = 0;
        end;
        //HEI.21<<
    end;

    local procedure PostPOReceipt(var pPurchHeader: Record "Purchase Header"; InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        Location: Record Location;
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        PostReceipt: Codeunit "Purch.-Post";
        TotalQtyfromFile: Decimal;
        QuantityPurchaseUOM: Decimal;
    begin
        //HEI.21>>
        GetWMSInterfaceSetup;
        PurchLine.SETRANGE("Document No.", pPurchHeader."No.");
        if PurchLine.FINDSET then
            repeat
                TotalQtyfromFile := 0;
                InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
                InterfaceEntryLineVIP.SETRANGE("Source No.", PurchLine."Document No.");
                InterfaceEntryLineVIP.SETRANGE("Source Line No.", PurchLine."Line No.");
                InterfaceEntryLineVIP.SETRANGE("No.", PurchLine."No.");
                InterfaceEntryLineVIP.SETRANGE("External Contract Line No.", '0');
                if InterfaceEntryLineVIP.FINDSET then begin
                    repeat
                        QuantityPurchaseUOM := ConvertToPurchaseUOM(PurchLine."No.", WMSInterfaceSetup."Reflex 1st OUM", PurchLine."Unit of Measure Code", InterfaceEntryLineVIP.Quantity);
                        TotalQtyfromFile += QuantityPurchaseUOM;
                        PurchLine.VALIDATE("Qty. to Receive", TotalQtyfromFile);
                        PurchLine.MODIFY;
                    until InterfaceEntryLineVIP.NEXT = 0;
                end else begin
                    PurchLine.VALIDATE("Qty. to Receive", 0);
                    PurchLine.MODIFY;
                end;
            until PurchLine.NEXT = 0;

        PostReceipt.RUN(pPurchHeader);
        //HEI.21<<
    end;

    local procedure ConvertToPurchaseUOM(ItemNo: Code[20]; ReflexUOM: Code[10]; PurchaseUOM: Code[10]; Quantity: Decimal): Decimal;
    var
        PurchaseItemUnitOfMeasure: Record "Item Unit of Measure";
        ReflexItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        //HEI.21>>
        if (PurchaseUOM <> '') and (ReflexUOM <> '') then begin
            ReflexItemUnitOfMeasure.GET(ItemNo, ReflexUOM);
            PurchaseItemUnitOfMeasure.GET(ItemNo, PurchaseUOM);
            exit(ROUND((ReflexItemUnitOfMeasure."Qty. per Unit of Measure" / PurchaseItemUnitOfMeasure."Qty. per Unit of Measure" * Quantity), 1, '='));
        end;

        exit(Quantity);
        //HEI.21<<
    end;

    //BC Upgrade GUNREM01- Code already covered in codeunit 58016 InterfaceDtWCode >>
    // //BC UPGRADE PATHAA02-Ext for CU5407-ProdOrderStatusMgmt 13.11.25>>
    //CU5407-Publisher->OnAfterReleasedProductionOrder(HEI.02)-->EventSubscribed on CU50109-WMS Interface Mgmt(HEI.22)
    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Prod. Order Status Management", 'OnAfterReleasedProdOrder', '', false, false)]
    // local procedure OnAfterReleasedProductionOrder(var ProductionOrder: Record "Production Order"; PreviewMode: Boolean);
    // var
    //     ProcessOutboundRPOforLPL: Report "Process Outbound RPO for LP";
    // begin
    //     //HEI.22>>
    //     if ProductionOrder.ISTEMPORARY then
    //         exit;
    //     if PreviewMode then
    //         exit;
    //     if WMSInterfaceSetup.GET then begin
    //         if not WMSInterfaceSetup."WMS Integration" then
    //             exit;
    //         if not WMSInterfaceSetup."Activate LogoPak Interface" then
    //             exit;
    //         ProcessOutboundRPOforLPL.GetProdOrder(ProductionOrder."No.");
    //         ProcessOutboundRPOforLPL.RUN;
    //     end;
    //     //HEI.22<<
    // end;
    //BC Upgrade GUNREM01- Code already covered in codeunit 58016 InterfaceDtWCode <<
    procedure ReleasedProductionOrderOutput(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        ProcessInboundOPRPOforLPL: Report "Process Inbound RPO for LP";
    begin
        //HEI.22>>
        if WMSInterfaceSetup.GET then begin
            if not WMSInterfaceSetup."WMS Integration" then
                exit;
            if not WMSInterfaceSetup."Activate LogoPak Interface" then
                exit;
            ProcessInboundOPRPOforLPL.GetProdOrder(InterfaceEntryHeaderVIP."Source No.");
            ProcessInboundOPRPOforLPL.GetHeaderEntry(InterfaceEntryHeaderVIP."Entry No.");
            ProcessInboundOPRPOforLPL.RUN;
        end;
        //HEI.22<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Interface Framework Mgt. VIP", 'OnAfterSetInterfaceError', '', false, false)]
    local procedure OnAfterInterfaceErrorUpdate(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        ProductionOrderL: Record "Production Order";
    begin
        //HEI.22>>
        GetWMSInterfaceSetup;
        if not WMSInterfaceSetup."Activate LogoPak Interface" then
            exit;
        if InterfaceEntryHeaderVIP.Status = InterfaceEntryHeaderVIP.Status::Error then begin
            case InterfaceEntryHeaderVIP."Interface Code" of
                WMSInterfaceSetup."Prod. Order Interface":
                    begin
                        if (InterfaceEntryHeaderVIP."Source Type" = DATABASE::"Production Order") and
                          (InterfaceEntryHeaderVIP."Source Subtype" = InterfaceEntryHeaderVIP."Source Subtype"::"7") then begin
                            if ProductionOrderL.GET(ProductionOrderL.Status::Released, InterfaceEntryHeaderVIP."Source No.") then begin
                                ProductionOrderL."Parked for LogoPak INT" := false;
                                ProductionOrderL.MODIFY(true);
                            end;
                        end;
                    end;
            end;
        end;
        //HEI.22<<
    end;
}

