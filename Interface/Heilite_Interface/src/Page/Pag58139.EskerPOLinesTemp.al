page 58139 "Esker POLinesTemp"
{
    // version ESKER,HEI.03

    // HEI.01 - CHG2030074 HEi.01, new page for performance issue fix IBM POSTOI01 12/09/2019
    //   # new created object
    // HEI.02 CHG2255443 HB3979 IBM SRIVAS07 09-08-2024 #Heilite - Esker_ Interface_delivery number-TDD/Development
    //   # Mapped one field with Message Id to Vendor Shipment no from GRN
    // HEI.03 CHG2255443 HB3979 IBM MAJUMS03 23-08-2024 Heilite - Esker_ Interface_Delivery Number
    //   # Modified Name and Caption of "Message ID" Field as "DeliveryNoteNumber__" to "DeliveryNoteNumber".

    // BC Upgrade KUMARR78 >>
    // Page Name  : Esker POLinesTemp
    // Page ID    : 50403
    //
    // 1. Added ApplicationArea property at Page level (BC mandatory visibility).
    //    Old:
    //         - ApplicationArea not defined at page level.
    //    New:
    //         - ApplicationArea = All added.
    //         - Ensures page visibility in Business Central.
    //
    // 2. Confirmed Rec usage as per BC standard.
    //    Old:
    //         - Implicit record reference (older NAV pattern).
    //    New:
    //         - Explicit Rec reference used in all fields.
    //         - Aligns with BC AL development standards.
    //
    // 3. Replaced hardcoded custom table ID with standard table reference.
    //    Old:
    //         GeneralInterfaceSetup: Record 50034;
    //    New:
    //         GeneralInterfaceSetup: Record "General Interface Setup INT";
    //         - Avoids dependency on hardcoded table ID.
    //         - Ensures object reference safety in BC.
    // BC Upgrade KUMARR78 <<
    //BC UPGRADE ATHUKS01 Added User category  


    Caption = 'Esker POLines';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ApplicationArea = All;//BC UPGRADE KUMARR78 Adding ApplicationArea.
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Interface Log Line INT";
    SourceTableTemporary = true;
    UsageCategory = Lists; //BC UPGRADE ATHUKS01

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field(CompanyCode; Rec."Description 2")
                {
                    Caption = 'CompanyCode';
                    ToolTip = 'Specifies the company code.';
                }
                field(VendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'VendorNo';
                    ToolTip = 'Specifies the vendor number.';
                }
                field(OrderNo; Rec."Order No.")
                {
                    Caption = 'OrderNo';
                    ToolTip = 'Specifies the order number.';
                }
                field(ItemNo; Rec."Item No.")
                {
                    Caption = 'ItemNo';
                    ToolTip = 'Specifies the item number.';
                }
                field(PlantNo; Rec."No.")
                {
                    Caption = 'PlantNo';
                    ToolTip = 'Specifies the plant number.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Specifies the description.';
                }
                field(UnitPrice; Rec."Global No.")
                {
                    Caption = 'UnitPrice';
                    ToolTip = 'Specifies the unit price.';
                }
                field(OrderAmt; Rec."Cross Reference No.")
                {
                    Caption = 'OrderAmt';
                    ToolTip = 'Specifies the order amount.';
                }
                field(OrderQty; Rec."Blanket Order No.")
                {
                    Caption = 'OrderQty';
                    ToolTip = 'Specifies the order quantity.';
                }
                field(InvAmt; Rec."CMG Code")
                {
                    Caption = 'InvAmt';
                    ToolTip = 'Specifies the invoice amount.';
                }
                field(InvQty; Rec."Ship-to Name")
                {
                    Caption = 'InvQty';
                    ToolTip = 'Specifies the invoice quantity.';
                }
                field(DelivAmt; Rec."Ship-to Address")
                {
                    Caption = 'DelivAmt';
                    ToolTip = 'Specifies the delivery amount.';
                }
                field(DelivQty; Rec."Ship-to Address 2")
                {
                    Caption = 'DelivQty';
                    ToolTip = 'Specifies the delivery quantity.';
                }
                field(TaxCode; Rec.Contact)
                {
                    Caption = 'TaxCode';
                    ToolTip = 'Specifies the tax code.';
                }
                field(GoodRecNo; Rec."Phone No.")
                {
                    Caption = 'GoodRecNo';
                    ToolTip = 'Specifies the goods receipt number.';
                }
                field(GoodRecDate; Rec."External Requisition No.")
                {
                    Caption = 'GoodRecDate';
                    ToolTip = 'Specifies the goods receipt date.';
                }
                field(DeliveryNoteNumber; Rec."Message ID")
                {
                    Caption = 'DeliveryNoteNumber';
                    ToolTip = 'Specifies the delivery note number.';
                }
                field(Type; Rec."Ship-to City")
                {
                    Caption = 'Type';
                    ToolTip = 'Specifies the type.';
                }
                field(QtyToAssign; Rec."Ship-to Post Code")
                {
                    Caption = 'QtyToAssign';
                    ToolTip = 'Specifies the quantity to assign.';
                }
                field(QtyToAssigned; Rec."E-Mail 2")
                {
                    Caption = 'QtyToAssigned';
                    ToolTip = 'Specifies the quantity assigned.';
                }
                field(UOMCode; Rec."Unit of Measure Code")
                {
                    Caption = 'UOMCode';
                    ToolTip = 'Specifies the unit of measure code.';
                }
                field(GLAccount; Rec."Account No.")
                {
                    Caption = 'GLAccount';
                    ToolTip = 'Specifies the G/L account.';
                }
                field(CostCenter; Rec."Cost Center Code")
                {
                    Caption = 'CostCenter';
                    ToolTip = 'Specifies the cost center.';
                }
                field(BusinessType; Rec."Project Code")
                {
                    Caption = 'BusinessType';
                    ToolTip = 'Specifies the business type.';
                }
                field(MovemType; Rec."Movement Type")
                {
                    Caption = 'MovemType';
                    ToolTip = 'Specifies the movement type.';
                }
                field(BrandType; Rec."External Document No.")
                {
                    Caption = 'BrandType';
                    ToolTip = 'Specifies the brand type.';
                }

            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        GeneralInterfaceSetup.Get();
        OpCoSetup.Get();
    end;

    trigger OnOpenPage();
    begin
        InitTempTable();
    end;

    var
        SysModified: Date;
        PurchHdr: Record "Purchase Header";
        ExportLine: Boolean;
        NewDescription: Text[50];
        UnitPrice: Text[50];
        OrderAmt: Code[20];
        OrderQty: Code[20];
        TaxCode: Text[50];
        QtyToAssign: Text[20];
        QtyToAssigned: Text[20];
        UOMCode: Code[10];
        DimensionSetEntry: Record "Dimension Set Entry";
        // GeneralInterfaceSetup: Record 50034;//BC UPGRDAE KUMARR78 Replacing Old Table ID.
        GeneralInterfaceSetup: Record "General Interface Setup INT";//BC UPGRDAE KUMARR78 Replacing Old Table ID

        OpCoSetup: Record "OPCO Setup FND";
        vBrandType: Code[20];
        CostCenter: Code[20];
        vBusinessType: Code[20];
        MovemType: Code[20];
        PurchaseLine: Record "Purchase Line";
        NoOfPoLines: Integer;
        NoOfPoReceipts: Integer;
        VendorNo: Code[20];
        OrderNo: Code[20];
        ItemNo: Code[20];
        PartNo: Code[20];
        InvAmt: Code[20];
        InvQty: Code[20];
        DelivAmt: Code[20];
        DelivQty: Code[20];
        GoodRecNo: Code[20];
        GoodRecDate: Code[20];
        recType: Text[20];
        NewType: Text[20];
        EntryNo: Integer;
        PurchReceiptLines: Record "Purch. Rcpt. Line";
        recGPurchLine: Record "Purchase Line";
        RcptLineQtyAssign: Text[30];
        RcptLineQtyAssigned: Text[30];
        RcptLineType: Text[30];
        recPurchRcptHeader: Record "Purch. Rcpt. Header";

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        ReturnDate := Format(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;

    local procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250];
    begin
        while StrPos(String, FindWhat) > 0 do
            String := DelStr(String, StrPos(String, FindWhat)) + ReplaceWith + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString := String;
    end;

    local procedure InitTempTable();
    begin
        Rec.Reset();
        Rec.DeleteAll();
        Rec.SetCurrentKey("Header Entry No.", "Entry No.");

        //>>insert the PO Lines
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
        if PurchaseLine.FindSet() then
            repeat
                ExportLine := true;
                if (PurchaseLine.Quantity = PurchaseLine."Quantity Received") or (PurchaseLine.Quantity = PurchaseLine."Quantity Invoiced") then
                    ExportLine := false;

                PurchHdr.Reset();

                PurchHdr.SetCurrentKey("Document Type", "No.", Status);

                PurchHdr.SetRange("Document Type", PurchHdr."Document Type"::Order);
                PurchHdr.SetRange("No.", PurchaseLine."Document No.");
                PurchHdr.SetFilter(Status, '<>%1', PurchHdr.Status::Open);
                if PurchHdr.IsEmpty then
                    ExportLine := false;

                if ExportLine then begin
                    EntryNo += 1;
                    InsertPoLines();
                end;
            until PurchaseLine.Next() = 0;
        //<<insert PO lines

        //>>insert the Purchase Receipt lines
        PurchReceiptLines.Reset();
        PurchReceiptLines.SetCurrentKey("Order No.", Quantity, "Pay-to Vendor No.");
        PurchReceiptLines.SetFilter("Order No.", '<>%1', '');
        PurchReceiptLines.SetFilter(Quantity, '<>%1', 0);
        if PurchReceiptLines.FindSet() then
            repeat
                ExportLine := true;
                if not recGPurchLine.Get(recGPurchLine."Document Type"::Order, PurchReceiptLines."Order No.", PurchReceiptLines."Order Line No.") then
                    ExportLine := false
                else begin
                    if (recGPurchLine."Quantity Received" = recGPurchLine.Quantity) and (recGPurchLine."Quantity Invoiced" = recGPurchLine.Quantity) then
                        ExportLine := false;
                    if PurchHdr.Get(recGPurchLine."Document Type", recGPurchLine."Document No.") then
                        if PurchHdr.Status = PurchHdr.Status::Open then
                            ExportLine := false;
                end;
                if ExportLine then begin
                    EntryNo += 1;
                    InsertPoReceipts();
                end;
            until PurchReceiptLines.Next() = 0;
        //<<insert the Purchase Receipt lines

        if Rec.FindFirst() then;
    end;

    local procedure InsertPoLines();
    begin

        Rec.Init();
        Clear(vBrandType);
        Clear(vBusinessType);

        Rec."Header Entry No." := 1;
        Rec."Entry No." := EntryNo;
        Rec."Buy-from Vendor No." := PurchaseLine."Pay-to Vendor No.";

        Rec."Description 2" := CompanyName;
        Rec."Order No." := PurchaseLine."Document No.";
        Rec."Item No." := Format(PurchaseLine."Line No.");
        Rec."No." := PurchaseLine."No.";
        Rec.Description := CopyStr(ReplaceString(ReplaceString(PurchaseLine.Description, '"', '{QUOTE}'), '{QUOTE}', '\"'), 1, 50);
        Rec."Global No." := Format(PurchaseLine."Direct Unit Cost", 0, '<Precision,4:4><Standard Format,9>');
        //order amount
        Rec."Cross Reference No." := Format(PurchaseLine."Line Amount", 0, 9);
        //order qty
        Rec."Blanket Order No." := Format(PurchaseLine.Quantity, 0, 9);
        //invoice amount
        Rec."CMG Code" := '0';
        //invoiced quantity
        Rec."Ship-to Name" := '0';
        //delivered amount
        Rec."Ship-to Address" := '0';
        //delivered quantity
        Rec."Ship-to Address 2" := '0';
        //tax code
        Rec.Contact := PurchaseLine."VAT Identifier";
        if PurchaseLine."VAT Bus. Posting Group" <> '' then
            Rec.Contact := Rec.Contact + ' (' + PurchaseLine."VAT Bus. Posting Group" + ')';
        //good receipt
        Rec."Phone No." := '';
        Rec."External Requisition No." := '';
        //Type
        Rec."Ship-to City" := Format(PurchaseLine.Type);
        //quantity to assign
        Rec."Ship-to Post Code" := Format(PurchaseLine."Qty. to Assign", 0, 9);
        Rec."E-Mail 2" := Format(PurchaseLine."Qty. Assigned", 0, 9);
        Rec."Unit of Measure Code" := PurchaseLine."Unit of Measure Code";
        //dimensions

        //BRAND dimension
        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", PurchaseLine."Dimension Set ID");
        DimensionSetEntry.SetRange("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
        if DimensionSetEntry.FindFirst() then begin
            Rec."External Document No." := DimensionSetEntry."Dimension Value Code";
        end;

        //Cost center dimension
        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", PurchaseLine."Dimension Set ID");
        DimensionSetEntry.SetRange("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
        if DimensionSetEntry.FindFirst() then begin
            Rec."Cost Center Code" := DimensionSetEntry."Dimension Value Code";
        end;

        //Business Type dimension
        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", PurchaseLine."Dimension Set ID");
        DimensionSetEntry.SetRange("Dimension Code", OpCoSetup."Business Type Dimension Code");
        if DimensionSetEntry.FindFirst() then begin
            Rec."Project Code" := DimensionSetEntry."Dimension Value Code";
        end;

        //Movement Type dimension
        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", PurchaseLine."Dimension Set ID");
        DimensionSetEntry.SetRange("Dimension Code", OpCoSetup."Movement Type Dimension Code");
        if DimensionSetEntry.FindFirst() then begin
            Rec."Movement Type" := DimensionSetEntry."Dimension Value Code";
        end;

        Rec.Insert();
    end;

    local procedure InsertPoReceipts();
    begin
        Rec.Init();
        Clear(RcptLineType);
        Clear(RcptLineQtyAssign);
        Clear(RcptLineQtyAssigned);
        Clear(vBrandType);
        Clear(vBusinessType);

        Rec."Header Entry No." := 1;
        Rec."Entry No." := EntryNo;
        recGPurchLine.Reset();
        recGPurchLine.SetRange(recGPurchLine."Document Type", recGPurchLine."Document Type"::Order);
        recGPurchLine.SetRange(recGPurchLine."Document No.", PurchReceiptLines."Order No.");
        recGPurchLine.SetRange(recGPurchLine."Line No.", PurchReceiptLines."Order Line No.");
        if recGPurchLine.FindFirst() then begin
            RcptLineType := Format(recGPurchLine.Type);
            recGPurchLine.CalcFields("Qty. to Assign", "Qty. Assigned");
            RcptLineQtyAssign := Format(recGPurchLine."Qty. to Assign");
            RcptLineQtyAssigned := Format(recGPurchLine."Qty. Assigned");
        end;
        Rec."Buy-from Vendor No." := PurchReceiptLines."Pay-to Vendor No.";

        Rec."Description 2" := CompanyName;
        Rec."Order No." := PurchReceiptLines."Order No.";
        Rec."Item No." := Format(PurchReceiptLines."Order Line No.");
        Rec."No." := PurchReceiptLines."No.";
        Rec.Description := CopyStr(ReplaceString(ReplaceString(PurchReceiptLines.Description, '"', '{QUOTE}'), '{QUOTE}', '\"'), 1, 50);
        Rec."Global No." := Format(PurchReceiptLines."Direct Unit Cost", 0, '<Precision,4:4><Standard Format,9>');
        //order amount
        Rec."Cross Reference No." := '0';
        if recGPurchLine.Amount <> 0 then
            Rec."Cross Reference No." := Format(recGPurchLine.Amount, 0, 9);

        //order qty
        Rec."Blanket Order No." := '0';
        if recGPurchLine.Quantity <> 0 then
            Rec."Blanket Order No." := Format(recGPurchLine.Quantity, 0, 9);

        //invoice amount
        if recGPurchLine.Quantity <> 0 then
            Rec."CMG Code" := Format(PurchReceiptLines."Quantity Invoiced" * recGPurchLine.Amount / recGPurchLine.Quantity, 0, 9);
        //invoiced quantity
        Rec."Ship-to Name" := Format(PurchReceiptLines."Quantity Invoiced", 0, 9);

        //delivered amount
        if recGPurchLine.Quantity <> 0 then
            Rec."Ship-to Address" := Format(PurchReceiptLines.Quantity * recGPurchLine.Amount / recGPurchLine.Quantity, 0, 9);

        //delivered quantity
        Rec."Ship-to Address 2" := Format(PurchReceiptLines.Quantity, 0, 9);

        //tax code
        Rec.Contact := recGPurchLine."VAT Identifier";
        if recGPurchLine."VAT Bus. Posting Group" <> '' then
            Rec.Contact := Rec.Contact + ' (' + recGPurchLine."VAT Bus. Posting Group" + ')';

        //good receipt
        Rec."Phone No." := PurchReceiptLines."Document No.";

        if recPurchRcptHeader.Get(PurchReceiptLines."Document No.") then
            Rec."External Requisition No." := Format(recPurchRcptHeader."Document Date", 0, 9);

        Rec."Message ID" := recPurchRcptHeader."Vendor Shipment No."; //HEI.02
        //Type
        Rec."Ship-to City" := RcptLineType;
        //quantity to assign
        Rec."Ship-to Post Code" := RcptLineQtyAssign;
        Rec."E-Mail 2" := RcptLineQtyAssigned;
        Rec."Unit of Measure Code" := PurchReceiptLines."Unit of Measure Code";
        //dimensions

        //BRAND dimension
        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", PurchReceiptLines."Dimension Set ID");
        DimensionSetEntry.SetRange("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
        if DimensionSetEntry.FindFirst() then begin
            Rec."External Document No." := DimensionSetEntry."Dimension Value Code";
        end;

        //Cost center dimension
        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", PurchReceiptLines."Dimension Set ID");
        DimensionSetEntry.SetRange("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
        if DimensionSetEntry.FindFirst() then begin
            Rec."Cost Center Code" := DimensionSetEntry."Dimension Value Code";
        end;

        //Business Type dimension
        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", PurchReceiptLines."Dimension Set ID");
        DimensionSetEntry.SetRange("Dimension Code", OpCoSetup."Business Type Dimension Code");
        if DimensionSetEntry.FindFirst() then begin
            Rec."Project Code" := DimensionSetEntry."Dimension Value Code";
        end;

        //Movement Type dimension
        DimensionSetEntry.Reset();
        DimensionSetEntry.SetRange("Dimension Set ID", PurchReceiptLines."Dimension Set ID");
        DimensionSetEntry.SetRange("Dimension Code", OpCoSetup."Movement Type Dimension Code");
        if DimensionSetEntry.FindFirst() then begin
            Rec."Movement Type" := DimensionSetEntry."Dimension Value Code";
        end;

        Rec.Insert();
    end;
}

