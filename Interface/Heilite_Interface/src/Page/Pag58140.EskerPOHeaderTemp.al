page 58140 "Esker POHeaderTemp"
{
    // BC Upgrade KUMARR78 >>
    //
    // Page Name  : Esker POHeaderTemp
    // Page ID    : 50404
    //
    // 1. Added Business Central visibility property.
    //    Old:
    //         - ApplicationArea property not defined at page level (NAV).
    //    New:
    //         - ApplicationArea = All added at page level.
    //         - Ensures visibility compliance in Business Central.
    //
    // 2. Confirmed Temporary Source Table behavior.
    //    Old:
    //         - SourceTableTemporary used in NAV without strict SaaS validation.
    //    New:
    //         - SourceTableTemporary = true retained and validated for BC.
    //         - Ensures temporary dataset behavior remains unchanged.
    //
    // 3. Updated field references to BC standard (Rec. usage).
    //    Old:
    //         - Direct field references used in some NAV patterns.
    //    New:
    //         - All fields explicitly referenced using Rec. for AL compliance.
    //         - Ensures clean AL compilation in BC.
    //
    // 4. Blocked unsupported/removed field logic.
    //    Old:
    //         - Logic dependent on field "Requester ID" in Purchase Header.
    //    New:
    //         - Entire conditional logic commented as field not available in BC.
    //         - Prevents compilation errors in BC environment.
    //
    // 5. Replaced deprecated field "Created By".
    //    Old:
    //         - POHeader."Created By"
    //    New:
    //         - Replaced with POHeader.SystemCreatedBy.
    //         - Ensures compatibility with BC system fields.
    //
    // BC Upgrade KUMARR78 <<
    //BC UPGRADE ATHUKS01 Added User category  
    //BC UPGRADE ATHUKS01 Commented code in OnInit trigger as not used in BC & due to this Page is not opening in BC.
    //BC UPGRADE ATHUKS01 Replacing Field ("Requester ID") with ("Requester ID IBM FND") & Created By with Created By IBM FND` 
    Caption = 'Esker POHeader';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
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
                field(OrderDate; Rec."External Requisition No.")
                {
                    Caption = 'OrderDate';
                    ToolTip = 'Specifies the order date.';
                }
                field(OrderAmt; Rec."Cross Reference No.")
                {
                    Caption = 'OrderAmt';
                    ToolTip = 'Specifies the order amount.';
                }
                field(InvAmt; Rec."CMG Code")
                {
                    Caption = 'InvAmt';
                    ToolTip = 'Specifies the invoice amount.';
                }
                field(DelivAmt; Rec."Ship-to Address")
                {
                    Caption = 'DelivAmt';
                    ToolTip = 'Specifies the delivery amount.';
                }
                field(Requester; Rec."E-Mail 2")
                {
                    Caption = 'Requester';
                    ToolTip = 'Specifies the requester.';
                }
                field(Buyer; Rec."E-Mail" + Rec."Global No.")
                {
                    Caption = 'Buyer';
                    ToolTip = 'Specifies the buyer.';
                }
                field(Receiver; Rec."Log Message")
                {
                    Caption = 'Receiver';
                    ToolTip = 'Specifies the receiver.';
                }
                field(PaymTerm; Rec."Payment Terms Code")
                {
                    Caption = 'PaymTerm';
                    ToolTip = 'Specifies the payment term.';
                }
                field(CurrCode; Rec."Currency Code")
                {
                    Caption = 'CurrCode';
                    ToolTip = 'Specifies the currency code.';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the status.';
                }
                field(LicenseCode; Rec."Project Code")
                {
                    Caption = 'LicenseCode';
                    ToolTip = 'Specifies the license code.';
                }
            }
        }
    }

    trigger OnInit()
    begin
        //BC UPGRADE ATHUKS01 >> Commented as not used in BC<<
        //GeneralInterfaceSetup.Get();
        //OpCoSetup.Get();
        //BC UPGRADE ATHUKS01 >> Commented as not used in BC>>
    end;

    trigger OnOpenPage()
    begin
        InitTempTable();
    end;

    var
        GeneralInterfaceSetup: Record "Interface Setup INT";
        OpCoSetup: Record "OPCO Setup FND";
        POHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        GLSetup: Record "General Ledger Setup";
        CurrCode: Code[10];
        vStatus: Code[1];
        EntryNo: Integer;
        ExportLine: Boolean;

    local procedure InitTempTable()
    begin
        Rec.Reset();
        Rec.DeleteAll();
        Rec.SetCurrentKey("Header Entry No.", "Entry No.");

        // Insert POHeader
        POHeader.Reset();
        POHeader.SetCurrentKey("Document Type", Status, "Pay-to Vendor No.");
        POHeader.SetRange("Document Type", POHeader."Document Type"::Order);
        POHeader.SetFilter(Status, '<>%1', POHeader.Status::Open);

        if POHeader.FindSet() then
            repeat
                // test the current line
                ExportLine := true;
                GLSetup.Get();
                if POHeader."Currency Code" <> '' then
                    CurrCode := POHeader."Currency Code"
                else
                    CurrCode := GLSetup."LCY Code";
                PurchLine.Reset();
                PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                PurchLine.SetRange("Document No.", POHeader."No.");
                if PurchLine.IsEmpty() then
                    ExportLine := false;

                PurchLine.Reset();
                PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                PurchLine.SetRange("Document No.", POHeader."No.");
                if PurchLine.FindSet() then
                    repeat
                        if (PurchLine.Quantity = PurchLine."Quantity Received") and (PurchLine.Quantity = PurchLine."Quantity Invoiced") then
                            ExportLine := false;
                    until PurchLine.Next() = 0;
                if POHeader.Status = POHeader.Status::Released then
                    vStatus := '1'
                else
                    vStatus := '0';
                if ExportLine then begin
                    EntryNo += 1;
                    InsertPOHeader(POHeader);
                end;
            until POHeader.Next() = 0;
    end;

    local procedure InsertPOHeader(POHeader: Record "Purchase Header")
    var
        recUserSetup: Record "User Setup";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        Rec.Init();
        Rec."Header Entry No." := 1;
        Rec."Entry No." := EntryNo;
        Rec."Buy-from Vendor No." := POHeader."Pay-to Vendor No.";
        Rec."Description 2" := CopyStr(CompanyName(), 1, MaxStrLen(Rec."Description 2"));
        Rec."Order No." := POHeader."No.";
        Rec."External Requisition No." := Format(POHeader."Order Date", 0, 9);
        POHeader.CalcFields(Amount);
        Rec."Cross Reference No." := Format(POHeader.Amount, 0, 9);
        Rec."CMG Code" := Format(FctCalcInvoicedAmount(POHeader."Document Type", POHeader."No."), 0, 9);
        Rec."Ship-to Address" := Format(FctCalcDeliveredAmount(POHeader."Document Type", POHeader."No."), 0, 9);
        //BC UPGRADE ATHUKS01 Replacing Field ("Requester ID") with ("Requester ID IBM FND")  
        //BC UPGRDAE KUMARR78 >> Blocking Whole Condtions As Field Removed("Requester ID")
        if POHeader."Requester ID IBM FND" <> 'WEBSERVICES' then begin
            if recUserSetup.Get(POHeader."Requester ID IBM FND") then
                Rec."E-Mail 2" := recUserSetup."E-Mail";
        end;
        //BC UPGRDAE KUMARR78 << Blocking Whole Condtions As Field Removed("Requester ID")
        //BC UPGRADE ATHUKS01 Replacing Field ("Requester ID") with ("Requester ID IBM FND")  


        if Rec."E-Mail 2" = '' then
            Rec."E-Mail 2" := ' ';
        //BC UPGRADE ATHUKS01 Replacing Field ("Created By") with ("Created By IBM FND")  
        if POHeader."Created By IBM FND" <> 'WEBSERVICES' then begin //BC UPGRDAE KUMARR78 Replacing Field ("Created By") with (SystemCreatedBy)

            // if POHeader.SystemCreatedBy <> 'WEBSERVICES' then begin //BC UPGRDAE KUMARR78 Replacing Field SystemCreatedBy from ("Created By")

            // if recUserSetup.Get(POHeader.SystemCreatedBy) then begin //BC UPGRDAE KUMARR78 Replacing from ("Created By") Field with (SystemCreatedBy)

            if recUserSetup.Get(POHeader."Created By IBM FND") then begin//BC UPGRDAE KUMARR78 Replacing Field to SystemCreatedBy from ("Created By")
                Rec."E-Mail" := CopyStr(recUserSetup."E-Mail", 1, 80);
                Rec."Global No." := CopyStr(recUserSetup."E-Mail", 81, 20);
            end;
        end;
        if Rec."E-Mail" = '' then
            Rec."E-Mail" := ' ';

        if POHeader."Assigned User ID" <> 'WEBSERVICES' then begin
            if recUserSetup.Get(POHeader."Assigned User ID") then
                Rec."Log Message" := recUserSetup."E-Mail";
        end;
        if Rec."Log Message" = '' then
            Rec."Log Message" := ' ';

        Rec."Payment Terms Code" := POHeader."Payment Terms Code";
        Rec."Currency Code" := CurrCode;
        Rec.Status := vStatus;

        if PurchaseHeaderAdditional.Get(POHeader."Document Type", POHeader."No.") then
            Rec."Project Code" := PurchaseHeaderAdditional."License Code";

        Rec.Insert();
    end;

    local procedure FctCalcInvoicedAmount(DocType: Enum "Purchase Document Type"; DocNo: Code[20]): Decimal
    var
        RecLPurchLine: Record "Purchase Line";
    begin
        RecLPurchLine.Reset();
        RecLPurchLine.SetRange("Document Type", DocType);
        RecLPurchLine.SetRange("Document No.", DocNo);
        if RecLPurchLine.FindSet() then
            repeat
                if (RecLPurchLine.Quantity <> 0) then
                    exit(RecLPurchLine."Quantity Invoiced" * RecLPurchLine.Amount / RecLPurchLine.Quantity);
            until RecLPurchLine.Next() = 0;
        exit(0);
    end;

    local procedure FctCalcDeliveredAmount(DocType: Enum "Purchase Document Type"; DocNo: Code[20]): Decimal
    var
        RecLPurchLine: Record "Purchase Line";
    begin
        RecLPurchLine.Reset();
        RecLPurchLine.SetRange("Document Type", DocType);
        RecLPurchLine.SetRange("Document No.", DocNo);
        if RecLPurchLine.FindSet() then
            repeat
                if (RecLPurchLine.Quantity <> 0) then
                    exit(RecLPurchLine."Quantity Received" * RecLPurchLine.Amount / RecLPurchLine.Quantity);
            until RecLPurchLine.Next() = 0;
        exit(0);
    end;
}
