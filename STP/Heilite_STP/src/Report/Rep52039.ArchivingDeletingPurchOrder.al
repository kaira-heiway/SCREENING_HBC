report 52039 "Archiving Deleting Purch Order"
{
    // version NAVW110.0.00.16177,DITW110.00.09,HEI.06

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 FDD-CHG2026322 IBM PANDES01 14/01/2020
    //    # Added code Delete POs which are delivery finalized and completely recieved.
    //    # Added code for delete warehouse receipt for POs which are manually delivery finalized and completely recieved.
    // HEI.02 CHG2145242 IBM NANDIS01 04/02/2022 Archiving and deleting PO in DRC skipped a PO
    //   # Report can only be run for those who have rights to delete PO as per User Setup
    // HEI.03 CHG2188363 HB3286 IBM MAJUMS03 31.03.2023 Archiving PO delivery finalized ticked.
    //   # New Report is Developed based on existing logic of Delete Invoiced Purch. Orders (Report ID. 499) and as per CHG2188363 HB3286.
    // HEI.04 CHG2188363 HB3286 IBM MAJUMS03 26.04.2023 Archiving PO delivery finalized ticked.
    //   # Layout is modified to fit all the columns of the report in a single page, width is adjusted.Text008 is modified as per length. At  Purchase Header -
    //   OnPreDataItem() Trigger the record valiable PurchaseLineis replaced by PurchLine.
    // HEI.05 CHG2188363 HB3286 IBM MAJUMS03 11.05.2023 Archiving PO delivery finalized ticked.
    //   Name and Caption of the Report is modified as "Archiving Deleting Purch Order", Tranlation is also done and added for French Language against CaptionML Property
    //   Captin ML for French Language is also added for "Confirm Delete PO" Input Field in Report Request Page.
    // HEI.06 CHG2204759 IBM MAJUMS03 16.05.2023 Archiving PO delivery finalized ticked.
    //   Text006 is modified, previously it was Quantity Received Not Invoiced 0, right now it is corrected as Quantity Received Not Invoiced <> 0 againt this Corrective
    //   Change and Tranlation is also done and added in French Language for Text001 to Text010, but due to length issue of the text available field of Purchase Line
    //   Table (used as a Temp table in this process to store the Log), Text008 is kept same for both language.
    // HEI.07 CHG2316370 SAHAL01 04.09.2025 Fix the report for Archiving and Deletion of Purchase Orders
    //   # Added Code and Commented Code

    // BC Upgrade KUMARR78 >>
    //
    // Report Name : Archiving Deleting Purch Order
    // Old Report ID : 50582
    //
    // 1. Added ApplicationArea property at Report level.
    //    Old:
    //         - ApplicationArea property was not defined in NAV.
    //    New:
    //         - ApplicationArea = All;
    //    Reason:
    //         - Required for feature visibility compliance in Business Central.
    //
    // 2. Added UsageCategory property at Report level.
    //    Old:
    //         - UsageCategory property was not defined in NAV.
    //    New:
    //         - UsageCategory = ReportsAndAnalysis;
    //    Reason:
    //         - Enables report discoverability via Tell Me search in BC.
    //
    // 3. Blocked DIT-Specific Field Validation Logic.
    //    Location:
    //         - OnAfterGetRecord() trigger.
    //    Old:
    //         - CALCFIELDS("Whse. Receipt No. (Open)") executed.
    //         - Condition validated DIT-specific field.
    //         - TempPurchLine."Tax Liable" and "Additional Description"
    //           set based on this field.
    //    New:
    //         - Entire DIT validation block commented.
    //         - Direct assignment added:
    //               TempPurchLine."Tax Liable" := false;
    //               TempPurchLine."Additional Description" := Text005;
    //    Reason:
    //         - DIT-specific field not supported in BC.
    //
    // 4. Replaced Removed Archiving Function Call.
    //    Location:
    //         - DeletePO() procedure.
    //    Old:
    //         - ArchiveManagement.ArchivingViaDeletionPOPro(true);
    //    New:
    //         - CU_HenikenBCUpgrade.ArchivingViaDeletionPOPro(true);
    //    Reason:
    //         - Function removed from ArchiveManagement in BC.
    //         - Logic moved to custom codeunit "Heineken BC Upgrade".
    //
    // 5. Modified PostPurchDelete.DeleteHeader() Function Signature.
    //    Location:
    //         - DeletePO() procedure.
    //    Old:
    //         - Included parameters:
    //               DepositPurchInvHeader,
    //               DepositPurchCrMemoHeader.
    //    New:
    //         - Updated call aligned with BC standard signature
    //           without Deposit headers.
    //    Reason:
    //         - Deposit header parameters not supported in BC.
    //
    // 6. Added ApplicationArea property to Request Page field.
    //    Location:
    //         - ConfirmDeletePO field.
    //    Old:
    //         - ApplicationArea not defined.
    //    New:
    //         - ApplicationArea = All;
    //    Reason:
    //         - Required for BC page field visibility.
    // BC Upgrade KUMARR78 <<

    // BC Upgrade PATELS08 >>
    // # Tag HEI.07 added to the documentation.
    // # Code change in trigger OnPreDataItem() and 'OnAfterGetRecord()' for DataItem "Purchase Header". (HEI.07)
    // # Added local Varaible PurchaseHeaderAddL and  Code change in procedure 'DeletePO'. (HEI.07)
    // BC Upgrade PATELS08 <<

    // BC Upgrade MISHRS14 >>
    // Added HEI.08 Tag
    // HEI.08 CHG2353140 IBM SAHAL01 20.04.2026 Error message during archiving and deleting PO process
    // # Commented Code
    // BC Upgrade MISHRS14 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Archiving Deleting Purch Order.rdl';
    ApplicationArea = All; // BC Upgrade RAHUL Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; // BC Upgrade RAHUL Adding Usagecategory
    CaptionML = ENU = 'Archiving & Deleting Purch. Orders',
                FRA = 'Archivage et suppression d''achat. Ordres';
    Permissions = tabledata "Purchase Header" = rimd,//BC Upgrade SHARMP16--Testscriptchanges140326
                  tabledata "Purchase Line" = rimd;//BC Upgrade SHARMP16--Testscriptchanges140326
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") order(ascending) where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Pay-to Vendor No.";
            RequestFilterHeadingML = ENU = 'Purchase Order',
                                     FRA = 'Commande achat';

            trigger OnAfterGetRecord();
            var
                PurchaseLineL: Record "Purchase Line";
                ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                PostPurchDelete: Codeunit "PostPurch-Delete";
                ReservePurchLine: Codeunit "Purch. Line-Reserve";
                ProcessOQtyL: Boolean;
            begin
                Window.Update(1, "No.");


                PurchLine.Reset();
                PurchLine.SetRange("Document Type", "Purchase Header"."Document Type");
                PurchLine.SetRange("Document No.", "Purchase Header"."No.");
                // BC Upgrade PATELS08 >>
                // HEI.07 >>
                // if PurchLine.FindFirst() then begin
                if PurchLine.FindSet(false) then begin//BC Upgrade SHARMP16--Testscriptchanges140326
                    // HEI.07 <<
                    // BC Upgrade PATELS08 <<
                    repeat
                        TempPurchLine.Reset();
                        if not TempPurchLine.Get(PurchLine."Document Type", PurchLine."Document No.", PurchLine."Line No.") then begin
                            TempPurchLine.Init();
                            TempPurchLine."Document Type" := PurchLine."Document Type";
                            TempPurchLine."Document No." := PurchLine."Document No.";
                            TempPurchLine."Line No." := PurchLine."Line No.";
                            TempPurchLine.Insert();
                        end;

                        if PurchLine."Quantity Received" >= 0 then begin
                            TempPurchLine."Allow Invoice Disc." := true;
                            TempPurchLine.Description := Text001;
                        end else begin
                            TempPurchLine."Allow Invoice Disc." := false;
                            TempPurchLine.Description := Text002;
                        end;

                        if PurchLine."Quantity Invoiced" >= 0 then begin
                            TempPurchLine."Recalculate Invoice Disc." := true;
                            TempPurchLine."Description 2" := Text001;
                        end else begin
                            TempPurchLine."Recalculate Invoice Disc." := false;
                            TempPurchLine."Description 2" := Text003;
                        end;

                        if PurchLine."Delivery Finalized FND" then begin
                            TempPurchLine."Drop Shipment" := true;
                            TempPurchLine."Machine Reference Number FND" := Text001;
                        end else begin
                            TempPurchLine."Drop Shipment" := false;
                            TempPurchLine."Machine Reference Number FND" := Text004;
                        end;

                        //BC UPGRDAE KUMARR78 >> DIT Field Blocking.
                        // PurchLine.CALCFIELDS("Whse. Receipt No. (Open)");
                        // if PurchLine."Whse. Receipt No. (Open)" = '' then begin
                        //     TempPurchLine."Tax Liable" := true;
                        //     TempPurchLine."Additional Description" := Text001;
                        // end else begin
                        //     TempPurchLine."Tax Liable" := false;
                        //     TempPurchLine."Additional Description" := Text005;
                        // end;
                        //BC UPGRDAE KUMARR78 << DIT Field Blocking.

                        //BC UPGRDAE KUMARR78 >> Adding Else condition As DIT Field Were being Used before.
                        TempPurchLine."Tax Liable" := true;//BC Upgrade SHARMp16 Gap fit changes 11 march
                        TempPurchLine."Additional Description FND" := Text001;//BC Upgrade SHARMP16--Testscriptchanges140326
                        //BC UPGRDAE KUMARR78 << Adding Else condition As DIT Field Were being Used before.

                        if PurchLine."Qty. Rcd. Not Invoiced" = 0 then begin
                            TempPurchLine."Use Tax" := true;
                            TempPurchLine."SPL Name FND" := Text001;
                        end else begin
                            TempPurchLine."Use Tax" := false;
                            TempPurchLine."SPL Name FND" := Text006;
                        end;

                        PurchLine.CalcFields("Qty. Assigned");
                        if PurchLine.Type = PurchLine.Type::"Charge (Item)" then begin
                            if PurchLine."Qty. Assigned" = PurchLine."Quantity Invoiced" then begin
                                TempPurchLine."System-Created Entry" := true;
                                TempPurchLine."Vendor Item No." := Text001;
                            end else begin
                                TempPurchLine."System-Created Entry" := false;
                                TempPurchLine."Vendor Item No." := Text007;
                            end;
                        end else begin
                            TempPurchLine."System-Created Entry" := true;
                            TempPurchLine."Vendor Item No." := Text001;
                        end;

                        if PurchLine."TO Reference FND" = '' then begin
                            TempPurchLine."Prepayment Tax Liable" := true;
                            TempPurchLine."TIN No. FND" := Text001;
                        end else begin
                            if ((TOHdr.Get(PurchLine."TO Reference FND")) and (TOHdr.Status <> TOHdr.Status::Open)) then begin
                                TempPurchLine."Prepayment Tax Liable" := false;
                                TempPurchLine."TIN No. FND" := Text008;
                            end else begin
                                TempPurchLine."Prepayment Tax Liable" := true;
                                TempPurchLine."TIN No. FND" := Text001;
                            end;
                        end;

                        TempPurchLine.Modify();

                        TempPurchLine."Depr. until FA Posting Date" := false;
                        if (TempPurchLine."Allow Invoice Disc." and TempPurchLine."Recalculate Invoice Disc." and TempPurchLine."Drop Shipment" and TempPurchLine."Tax Liable"
                          and TempPurchLine."Use Tax" and TempPurchLine."System-Created Entry" and TempPurchLine."Prepayment Tax Liable") then begin
                            TempPurchLine."Depr. until FA Posting Date" := true;
                            TempPurchLine.Modify();
                        end;

                    until PurchLine.Next() = 0;
                end;

                TempPurchLine.Reset();
                TempPurchLine.SetRange(TempPurchLine."Document Type", "Purchase Header"."Document Type");
                TempPurchLine.SetRange(TempPurchLine."Document No.", "Purchase Header"."No.");
                TempPurchLine.SetRange(TempPurchLine."Depr. until FA Posting Date", false);
                if not TempPurchLine.FindFirst() then begin
                    if ConfirmDeletePO then
                        DeletePO("Purchase Header"."Document Type", "Purchase Header"."No.");
                    TempPurchLine.SetRange(TempPurchLine."Depr. until FA Posting Date");
                    TempPurchLine.DeleteAll();
                end else begin
                    TempPurchLine.SetRange(TempPurchLine."Depr. until FA Posting Date", true);
                    TempPurchLine.DeleteAll();
                end;
                /*
                AllLinesDeleted := TRUE;
                ItemChargeAssgntPurch.RESET;
                ItemChargeAssgntPurch.SETRANGE("Document Type","Document Type");
                ItemChargeAssgntPurch.SETRANGE("Document No.","No.");
                PurchLine.RESET;
                PurchLine.SETRANGE("Document Type","Document Type");
                PurchLine.SETRANGE("Document No.","No.");
                PurchLine.SETFILTER("Quantity Invoiced",'<>0');
                IF PurchLine.FIND('-') THEN BEGIN
                  PurchLine.SETRANGE("Quantity Invoiced");
                  PurchLine.SETFILTER("Outstanding Quantity",'<>0');
                  //>>HEI.01
                  IF PurchLine.FIND('-') THEN BEGIN
                    CALCFIELDS("Completely Received");
                    IF "Completely Received" THEN BEGIN
                      PurchaseLineL.SETRANGE("Document Type","Document Type");
                      PurchaseLineL.SETRANGE("Document No.","No.");
                      PurchaseLineL.SETFILTER("Quantity Invoiced",'<>0');
                      PurchaseLineL.SETFILTER("Outstanding Quantity",'<>0');
                      IF PurchaseLineL.FIND('-') THEN BEGIN
                        REPEAT
                          IF PurchaseLineL."Delivery Finalized" AND PurchaseLineL."Completely Received" THEN
                            ProcessOQtyL := TRUE;
                        UNTIL (PurchaseLineL.NEXT = 0) OR (NOT ProcessOQtyL);
                      END;
                    END;
                  END;
                //<<HEI.01
                  IF NOT PurchLine.FIND('-') OR ProcessOQtyL THEN BEGIN  //>>HEI.01 - Added "OR ProcessOQtyL" in the condition
                    PurchLine.SETRANGE("Outstanding Quantity");
                    PurchLine.SETFILTER("Qty. Rcd. Not Invoiced",'<>0');
                    IF NOT PurchLine.FIND('-') THEN BEGIN
                      PurchLine.LOCKTABLE;
                      IF NOT PurchLine.FIND('-') THEN BEGIN
                        PurchLine.SETRANGE("Qty. Rcd. Not Invoiced");
                        IF PurchLine.FIND('-') THEN
                          REPEAT
                            PurchLine.CALCFIELDS("Qty. Assigned");
                            IF (PurchLine."Qty. Assigned" = PurchLine."Quantity Invoiced") OR
                               (PurchLine.Type <> PurchLine.Type::"Charge (Item)")
                            THEN BEGIN
                              IF PurchLine.Type = PurchLine.Type::"Charge (Item)" THEN BEGIN
                                ItemChargeAssgntPurch.SETRANGE("Document Line No.",PurchLine."Line No.");
                                ItemChargeAssgntPurch.DELETEALL;
                              END;
                              IF PurchLine.HASLINKS THEN
                                PurchLine.DELETELINKS;
                
                              PurchLine.DELETE;
                            END ELSE
                              AllLinesDeleted := FALSE;
                            UpdateAssSalesOrder;
                          UNTIL PurchLine.NEXT = 0;
                
                        IF AllLinesDeleted THEN BEGIN
                          PostPurchDelete.DeleteHeader(
                            "Purchase Header",PurchRcptHeader,PurchInvHeader,PurchCrMemoHeader,
                            ReturnShptHeader,PrepmtPurchInvHeader,PrepmtPurchCrMemoHeader,
                            // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
                            DepositPurchInvHeader,DepositPurchCrMemoHeader);
                            // >>DITW110.00.08 DDR NRQ#0
                
                          ReservePurchLine.DeleteInvoiceSpecFromHeader("Purchase Header");
                
                          PurchCommentLine.SETRANGE("Document Type","Document Type");
                          PurchCommentLine.SETRANGE("No.","No.");
                          PurchCommentLine.DELETEALL;
                
                          WhseRequest.SETRANGE("Source Type",DATABASE::"Purchase Line");
                          WhseRequest.SETRANGE("Source Subtype","Document Type");
                          WhseRequest.SETRANGE("Source No.","No.");
                          IF NOT WhseRequest.ISEMPTY THEN
                            WhseRequest.DELETEALL(TRUE);
                          //>>HEI.01
                          g_WrhseRcptHdr.RESET;
                          g_WrhseRcptHdr.SETRANGE(g_WrhseRcptHdr."Source No.","Purchase Header"."No.");
                          IF g_WrhseRcptHdr.FIND('-') THEN BEGIN
                            g_WrhseRcptLine.RESET;
                            g_WrhseRcptLine.SETRANGE("No.",g_WrhseRcptHdr."No.");
                            g_WrhseRcptLine.SETRANGE("Source Document",g_WrhseRcptHdr."Source Document Type");
                            IF g_WrhseRcptLine.FINDSET THEN REPEAT
                              IF g_WrhseRcptLine."Qty. to Receive" <> 0 THEN
                                WhsRcptDel := TRUE;
                              UNTIL (g_WrhseRcptLine.NEXT = 0) OR (NOT WhsRcptDel);
                            END;
                            IF WhsRcptDel THEN BEGIN
                              g_WrhseRcptHdr.SuppressConfirmBox(TRUE);
                              g_WrhseRcptHdr.DELETE(TRUE);
                            END;
                            COMMIT;
                            //>>HEI.01
                          ApprovalsMgmt.DeleteApprovalEntries(RECORDID);
                
                          IF HASLINKS THEN
                            DELETELINKS;
                
                          DELETE;
                        END;
                        COMMIT;
                      END;
                    END;
                  END;
                END;
                */

                //<<HEI.03

            end;

            trigger OnPreDataItem();
            begin
                //>>HEI.03
                //HEI.02>>
                if UserSetup.Get(UserId) then begin
                    if not UserSetup."Allow Delete/Arc PO/Return FND" then
                        Error(Text50000);
                end else
                    Error(Text50001);
                StatusControl.SetSkipStatusCheck(true);//BC Upgrade SHARMP16--Testscriptchanges140326
                //HEI.02<<

                // BC Upgrade PATELS08 >>
                // HEI.07
                // if "Purchase Header".GetFilter("Purchase Header"."No.") = '' then begin
                //     FirstPO := '';
                //     LastPO := '';
                //     PurchHdr.Reset();
                //     PurchHdr.SetRange(PurchHdr."Document Type", PurchHdr."Document Type"::Order);
                //     if PurchHdr.FindFirst() then
                //         FirstPO := PurchHdr."No.";
                //     PurchHdr.Reset();
                //     if PurchHdr.FindLast() then
                //         LastPO := PurchHdr."No.";
                //     "Purchase Header".SetRange("Purchase Header"."No.", FirstPO, LastPO);
                // end;
                // HEI.07
                // BC Upgrade PATELS08 <<
                Window.Open(Text000);
                Clear(TempPurchLine);
                TempPurchLine.DeleteAll();
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin
                StatusControl.SetSkipStatusCheck(false);
            end;//BC Upgrade SHARMP16--Testscriptchanges140326
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number) order(ascending) where(Number = filter(1 ..));
            column(TempPLine_DocType; TempPurchLine."Document Type")
            {
            }
            column(TempPLine_DocNo; TempPurchLine."Document No.")
            {
            }
            column(TempPLine_LineNo; TempPurchLine."Line No.")
            {
            }
            column(TempPurchLine_QtyReceived; TempPurchLine.Description)
            {
            }
            column(TempPurchLine_QtyInvoiced; TempPurchLine."Description 2")
            {
            }
            column(TempPurchLine_DeliveryFinalized; TempPurchLine."Machine Reference Number FND")
            {
            }
            column(TempPurchLine_WhseRcptDoesNotExists; TempPurchLine."Additional Description FND")
            {
            }
            column(TempPurchLine_QtyReceivedNotInvoiced; TempPurchLine."SPL Name FND")
            {
            }
            column(TempPurchLine_ChargeItem; TempPurchLine."Vendor Item No.")
            {
            }
            column(TempPurchLine_TORef; TempPurchLine."TIN No. FND")
            {
            }
            column(TempPurchLine_LineCanBeDeleted; TempPurchLine."Depr. until FA Posting Date")
            {
            }
            column(PO_Deleted; POCanBeDeleted)
            {
            }
            column(Text009_Text; Text009)
            {
            }
            column(Text010_Text; Text010)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if Integer.Number = 1 then
                    TempPurchLine.FindFirst()
                else
                    TempPurchLine.Next();
            end;

            trigger OnPreDataItem();
            begin

                //>>HEI.03
                TempPurchLine.Reset();
                if TempPurchLine.FindFirst() then
                    Integer.SetRange(Integer.Number, 1, TempPurchLine.Count)
                else
                    CurrReport.Quit();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(ConfirmDeletePO; ConfirmDeletePO)
                {
                    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea
                    CaptionML = ENU = 'Confirm Delete PO',
                                FRA = 'Confirmer la suppression du bon de commande';
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

    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        PurchCommentLine: Record "Purch. Comment Line";
        DepositPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PrepmtPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        DepositPurchInvHeader: Record "Purch. Inv. Header";
        PrepmtPurchInvHeader: Record "Purch. Inv. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchaseHeader: Record "Purchase Header";
        PurchHdr: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        TempPurchLine: Record "Purchase Line" temporary;
        ReturnShptHeader: Record "Return Shipment Header";
        TOHdr: Record "Transfer Header";
        UserSetup: Record "User Setup";
        g_WrhseRcptHdr: Record "Warehouse Receipt Header";
        g_WrhseRcptLine: Record "Warehouse Receipt Line";
        WhseRequest: Record "Warehouse Request";
        AllLinesDeleted: Boolean;
        ConfirmDeletePO: Boolean;
        POCanBeDeleted: Boolean;
        WhsRcptDel: Boolean;
        FirstPO: Code[20];
        LastPO: Code[20];
        Window: Dialog;
        Text50000: Label 'You do not have permission to delete Purchase Orders';
        Text50001: Label 'User is not available in User Setup';
        LastError: Text;
        Text000: TextConst ENU = 'Processing purch. orders #1##########', FRA = 'Traitement des retours achat #1##########';
        Text001: TextConst ENU = ' ', FRA = ' ';
        Text002: TextConst ENU = '  Quantity Received <0', FRA = '  Quantité reçue <0';
        Text003: TextConst ENU = '  Quantity Invoiced <0', FRA = '  Quantité facturée <0';
        Text004: TextConst ENU = '  Delivery Finalized FALSE', FRA = '  Livraison finalisée FAUX';
        Text005: TextConst ENU = '  Warehouse Receipt exists', FRA = '  Le récépissé d''entrepôt existe';
        Text006: TextConst ENU = '  Quantity Received Not Invoiced <> 0', FRA = '  Quantité reçue non facturée <> 0';
        Text007: TextConst ENU = '  QAsgn<>QInvd-CItem', FRA = '  QAsgn<>QInvd-CItem';
        Text008: TextConst ENU = '  TO is not Open', FRA = '  TO is not Open';
        Text009: TextConst ENU = '      PO: ', FRA = '      PO: ';
        Text010: TextConst ENU = ' is not Deleted', FRA = ' n''est pas supprimé';
        StatusControl: Codeunit "HNK_ReverseEntry CBN";//BC Upgrade SHARMP16--Testscriptchanges140326

    local procedure UpdateAssSalesOrder();
    var
        SalesLine: Record "Sales Line";
    begin

        /*
        IF NOT PurchLine."Special Order" THEN
          EXIT;
        WITH SalesLine DO BEGIN
          RESET;
          SETRANGE("Special Order Purchase No.",PurchLine."Document No.");
          SETRANGE("Special Order Purch. Line No.",PurchLine."Line No.");
          SETRANGE("Purchasing Code",PurchLine."Purchasing Code");
          IF FINDFIRST THEN BEGIN
            "Special Order Purchase No." := '';
            "Special Order Purch. Line No." := 0;
            MODIFY;
          END;
        END;
        */
        //<<HEI.03

    end;

    local procedure DeletePO(DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]);
    var
        PurchaseLineL: Record "Purchase Line";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ArchiveManagement: Codeunit ArchiveManagement;
        PostPurchDelete: Codeunit "PostPurch-Delete";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        ProcessOQtyL: Boolean;
        reverseCu: Codeunit "HNK_ReverseEntry CBN";//BC Upgrade SHARMP16--Testscriptchanges140326
        CU_HenikenBCUpgrade: Codeunit "Heineken BC Upgrade"; //BC UPGRADE KUMARR78 Declared varible
        PurchaseHeaderAddL: Record "Purchase Header Additional FND"; // BC Upgrade PATELS08 - HEI.07
    begin
        //>>HEI.03
        PurchaseHeader.Reset();
        PurchaseHeader.Get(DocType, DocNo);

        // ArchiveManagement.ArchivingViaDeletionPOPro(true); //BC UPGRDAE KUMARR78 Blocking As function Was Removed  
        reverseCu.ArchivingViaDeletionPOProCustom(true);//BC Upgrade SHARMP16--Testscriptchanges140326
        // CU_HenikenBCUpgrade.ArchivingViaDeletionPOPro1(true); //BC UPGRDAE KUMARR78 Adding As function Was Removed from (ArchiveManagement) to ("Heineken BC Upgrade")
        //reverseCu.ArchivingViaDeletionPOPro(true);
        ArchiveManagement.ArchivePurchDocument("Purchase Header");

        PurchaseLine.Reset();
        PurchaseLine.SetRange(PurchaseLine."Document Type", DocType);
        PurchaseLine.SetRange(PurchaseLine."Document No.", DocNo);
        // BC Upgrade PATELS08 >>
        // HEI.07 >>
        //IF PurchaseLine.FINDFIRST THEN BEGIN
        IF PurchaseLine.FINDSET(FALSE) THEN BEGIN
            // HEI.07 <<
            // BC Upgrade PATELS08 <<
            repeat
            // BC Upgrade MISHRS14 >>
            // HEI.08
                // if PurchaseLine.Type = PurchaseLine.Type::"Charge (Item)" then begin
                //     ItemChargeAssgntPurch.Reset();
                //     ItemChargeAssgntPurch.SetRange("Document Type", DocType);
                //     ItemChargeAssgntPurch.SetRange("Document No.", DocNo);
                //     ItemChargeAssgntPurch.SetRange("Document Line No.", PurchaseLine."Line No.");
                //     ItemChargeAssgntPurch.DeleteAll();
                // end;
            // HEI.08
            // BC Upgrade MISHRS14 <<    

                if PurchaseLine.HasLinks then
                    PurchaseLine.DeleteLinks();
            until PurchaseLine.Next() = 0;
        end;

        //BC UPGRDAE KUMARR78 >> Blocking As DIT Function Used.
        // PostPurchDelete.DeleteHeader(
        // "Purchase Header", PurchRcptHeader, PurchInvHeader, PurchCrMemoHeader,
        // ReturnShptHeader, PrepmtPurchInvHeader, PrepmtPurchCrMemoHeader,
        // // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
        // DepositPurchInvHeader, DepositPurchCrMemoHeader);
        // // >>DITW110.00.08 DDR NRQ#0
        //BC UPGRDAE KUMARR78 << Blocking As DIT Function Used.

        //BC UPGRDAE KUMARR78 >> Adding As DIT Function Was Used in Above Condition.
        PostPurchDelete.DeleteHeader(
        "Purchase Header", PurchRcptHeader, PurchInvHeader, PurchCrMemoHeader,
         ReturnShptHeader, PrepmtPurchInvHeader, PrepmtPurchCrMemoHeader);
        //BC UPGRDAE KUMARR78 << Adding As DIT Function Was Used in Above Condition.

        ReservePurchLine.DeleteInvoiceSpecFromHeader("Purchase Header");

        PurchCommentLine.SetRange("Document Type", "Purchase Header"."Document Type");
        PurchCommentLine.SetRange("No.", "Purchase Header"."No.");
        PurchCommentLine.DeleteAll();

        ApprovalsMgmt.DeleteApprovalEntries("Purchase Header".RecordId);

        if "Purchase Header".HasLinks then
            "Purchase Header".DeleteLinks();
        // BC Upgrade PATELS08 >>
        // HEI.07 >>
        IF PurchaseHeaderAddL.GET("Purchase Header"."Document Type", "Purchase Header"."No.") THEN
            PurchaseHeaderAddL.DELETE(FALSE);
        //"Purchase Header".DELETE();
        "Purchase Header".DELETE(TRUE);
        // HEI.07 <<
        // BC Upgrade PATELS08 <<
        Commit();
        //<<HEI.03
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin

    end;

    var

}

