table 50096 "Request Order Header FND"
{
    // version HEI.05

    // HEI.01 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Table created
    // HEI.02 FDD-BA-LOGGAP01 IBM NASTAA02 09.10.2018 # Request Order
    //   # If no "Actual Qty." > 0 exist on the lines then Error message will be shown
    // HEI.03 Defect #3388 IBM NASTAA02 30.10.2018 # Request Order - Multiple Adjustments
    //   # "Shipping Date" and "Receipt Date" in Transfer Order should flow from "Request Date" in Request Order as well as "Posting Date"
    // HEI.04 Defect #3415 IBM NASTAA02 02.11.2018 # Request Order - External Doc. Number
    //   # Field "External Document No." should flow to the Transfer Header table
    // HEI.05 Defect #3453 IBM NASTAA02 06.11.2018 # Request Order - multiple corrections
    //   # Removed check on "Release Request Order" for UserID when modying an existing record
    // HEI.06  CHG2070625 IBM.AK 08.10.20IBM.AK
    //  #Added fields 8,9 From-Code, From-Name
    //  #Code written on From-Code On validate

    Caption = 'Request Order Header';
    DrillDownPageID = "Request Order List";
    LookupPageID = "Request Order List";

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin
                    WarehouseSetup.GET();
                    NoSeriesMgt.TestManual(WarehouseSetup."Request Order Nos. FND");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Request Date"; Date)
        {
        }
        field(3; "To-Code"; Code[10])
        {
            TableRelation = Location;

            trigger OnValidate();
            begin
                RequestLine.SETRANGE("Document No.", "No.");
                RequestLine.SETRANGE("From-Code", "To-Code");
                if RequestLine.FINDFIRST() then
                    ERROR(Text002, "To-Code", RequestLine."From-Code", "No.");

                if Location.GET("To-Code") then
                    "To-Name" := Location.Name;
            end;
        }
        field(4; "To-Name"; Text[50])
        {
            Editable = false;
        }
        field(5; "In-Transit Code"; Code[10])
        {
            TableRelation = Location where("Use As In-Transit" = CONST(true));
        }
        field(6; "External Document No."; Text[35])
        {
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(8; "From-Code"; Code[10])
        {
            TableRelation = Location;

            trigger OnValidate();
            begin
                //HEI.06>>
                if Location.GET("From-Code") then
                    "From-Name" := Location.Name;

                if "From-Code" <> xRec."From-Code" then begin
                    ReqOrdLine.RESET();
                    ReqOrdLine.SETRANGE(ReqOrdLine."Document No.", "No.");
                    if ReqOrdLine.findset() then begin
                        repeat
                            ReqOrdLine."From-Code" := "From-Code";
                            ReqOrdLine.MODIFY();
                        until ReqOrdLine.NEXT() = 0;
                    end;
                end;
                //HEI.06<<
            end;
        }
        field(9; "From-Name"; Text[50])
        {
            Editable = false;
        }
        field(28; "No. Series"; Code[10])
        {
            CaptionML = ENU = 'No. Series',
                        FRA = 'Souches de n°';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(29; "Requester ID"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TESTFIELD(Status, Status::Open);
        if "Requester ID" <> USERID then
            ERROR(Text003, FIELDCAPTION("Requester ID"), "Requester ID", "No.");

        RequestLine.SETRANGE("Document No.", "No.");
        RequestLine.DELETEALL(true);
    end;

    trigger OnInsert();
    begin
        WarehouseSetup.GET();
        if "No." = '' then begin
            WarehouseSetup.TESTFIELD("Request Order Nos. FND");
            //NoSeriesMgt.InitSeries(WarehouseSetup."Request Order Nos.", xRec."No. Series", "Request Date", "No.", "No. Series");  // BC Upgrade NANDIS03 - Blocked
            if NoSeriesMgt.AreRelated(WarehouseSetup."Request Order Nos. FND", xRec."No. Series") then  // BC Upgrade NANDIS03 - Added
                "No. Series" := xRec."No. Series";    // BC Upgrade NANDIS03 - Added
        end;

        if "Request Date" = 0D then
            VALIDATE("Request Date", WORKDATE());
        VALIDATE("Requester ID", USERID);
    end;

    trigger OnRename();
    begin
        ERROR(Text000, TABLECAPTION);
    end;

    var
        Location: Record Location;
        RequestHeader: Record "Request Order Header FND";
        ReqOrdLine: Record "Request Order Line FND";
        RequestLine: Record "Request Order Line FND";
        UserSetup: Record "User Setup";
        WarehouseSetup: Record "Warehouse Setup";
        //NoSeriesMgt: Codeunit NoSeriesManagement;  // BC Upgrade NANDIS03 - Blocked
        NoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDIS03 - Added
        Text001: Label 'You are not allowed to release a Request Order (User Setup).';
        Text002: Label '%1 and %2 cannot be the same in Request Order No. %3.';
        Text003: Label 'Only %1 %2 can delete Request Order No. %3.';
        Text004: Label 'Transfer Orders %1 were created.';
        Text005: Label '"No quantities to transfer. "';
        Text006: Label 'It is not allowed to transfer more quantity %1 than the one requested %2 per Item %3.';
        TransferOrdersCreated: Text[1024];
        Text000: TextConst ENU = 'You cannot rename a %1.', FRA = 'Vous ne pouvez pas renommer l''enregistrement %1.';

    procedure AssistEdit(OldRequestHeader: Record "Request Order Header FND"): Boolean;
    begin
        //with RequestHeader do begin  //BC Upgrade KUMBHS03 27022026 commented to remove with statement error
        RequestHeader := Rec;
        WarehouseSetup.GET();
        WarehouseSetup.TESTFIELD("Request Order Nos. FND");
        // BC Upgrade NANDIS03 - modified code as per NOSeriesManagement CU obsolete >>
        // if NoSeriesMgt.SelectSeries(WarehouseSetup."Request Order Nos.", OldRequestHeader."No. Series", "No. Series") then begin
        //     NoSeriesMgt.SetSeries("No.");
        if NoSeriesMgt.LookupRelatedNoSeries(WarehouseSetup."Request Order Nos. FND", OldRequestHeader."No. Series", RequestHeader."No. Series") then begin //BC Upgrade KUMBHS03 27022026 added RequestHeader
            NoSeriesMgt.GetNextNo(RequestHeader."No.");  //BC Upgrade KUMBHS03 27022026 added RequestHeader
                                                         // BC Upgrade NANDIS03 - modified code as per NOSeriesManagement CU obsolete <<
            Rec := RequestHeader;
            exit(true);
        end;
        //end; //BC Upgrade KUMBHS03 27022026 commented to remove with statement error
    end;

    procedure ReleaseRequestOrder();
    begin
        UserSetup.GET(USERID);
        if not UserSetup."Release Request Order FND" then
            ERROR(Text001);

        TESTFIELD("To-Code");
        TESTFIELD("In-Transit Code");
        RequestLine.SETRANGE("Document No.", "No.");
        if RequestLine.findset() then
            repeat
                RequestLine.TESTFIELD("Item No.");
                RequestLine.TESTFIELD("From-Code");
                //HEI.03>>
                RequestLine.CALCFIELDS("Total Actual Quantity");
                if RequestLine."Requested Quantity" > 0 then
                    if RequestLine."Requested Quantity" < RequestLine."Total Actual Quantity" then
                        ERROR(Text006, RequestLine."Total Actual Quantity", RequestLine."Requested Quantity", RequestLine."Item No.");
            //HEI.03<<
            until RequestLine.NEXT() = 0;

        Status := Status::Released;
        MODIFY(true);
    end;

    procedure ReopenRequestOrder();
    begin
        Status := Status::Open;
    end;

    procedure CreateTransferOrders();
    var
        RequestLine2: Record "Request Order Line FND";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
    begin
        TESTFIELD(Status, Status::Released);
        RequestLine2.SETRANGE("Document No.", "No.");
        RequestLine2.SETFILTER("Actual Qty.", '>%1', 0);
        if RequestLine2.findset() then
            repeat
                if RequestLine2."From-Code" = TransferHeader."Transfer-from Code" then
                    InsertTransferLine(TransferHeader, RequestLine2)
                else begin
                    InsertTransferHeader(TransferHeader, RequestLine2);
                    InsertTransferLine(TransferHeader, RequestLine2);
                end;
            until RequestLine2.NEXT() = 0
        else
            ERROR(Text005); //HEI.02

        if TransferOrdersCreated <> '' then begin
            MESSAGE(Text004, TransferOrdersCreated);
            CreateRequestOrderArchive();
            DeleteRequestOrder();
        end;
    end;

    local procedure InsertTransferHeader(var TransferHeader: Record "Transfer Header"; RequestLine2: Record "Request Order Line FND");
    var
        InventorySetup: Record "Inventory Setup";
        NewTransferOrderNo: Code[20];
    begin
        InventorySetup.GET();
        //with TransferHeader do begin  //BC Upgrade KUMBHS03 27022026 commented to remove with statement error
        TransferHeader.INIT();
        // NoSeriesMgt.InitSeries(InventorySetup."Transfer Order Nos.", TransferHeader."No. Series", // BC Upgrade NANDIS03 - Blocked
        // "Request Date", NewTransferOrderNo, InventorySetup."Transfer Order Nos.");  // BC Upgrade NANDIS03 - Blocked
        if NoSeriesMgt.AreRelated(InventorySetup."Transfer Order Nos.", TransferHeader."No. Series") then  // BC Upgrade NANDIS03 - Added
            TransferHeader."No. Series" := xRec."No. Series"; // BC Upgrade NANDIS03 - Added
        TransferHeader."No." := NewTransferOrderNo;
        TransferHeader.INSERT(true);
        TransferHeader.VALIDATE("Transfer-to Code", "To-Code");
        TransferHeader.VALIDATE("Transfer-from Code", RequestLine2."From-Code");
        TransferHeader.VALIDATE("In-Transit Code", Rec."In-Transit Code");
        TransferHeader.VALIDATE("Posting Date", "Request Date");
        TransferHeader.VALIDATE("Shipment Date", "Request Date"); //HEI.03
        TransferHeader.VALIDATE("Receipt Date", "Request Date"); //HEI.03
        TransferHeader.VALIDATE("Request Order No. FND", Rec."No.");
        TransferHeader.VALIDATE("External Document No.", Rec."External Document No."); //HEI.04
        TransferHeader.MODIFY(true);
        //end;  //BC Upgrade KUMBHS03 27022026 commented to remove with statement error

        if TransferOrdersCreated = '' then
            TransferOrdersCreated := TransferHeader."No."
        else
            TransferOrdersCreated += ', ' + TransferHeader."No.";
    end;

    local procedure InsertTransferLine(TransferHeader: Record "Transfer Header"; RequestLine2: Record "Request Order Line FND");
    var
        TransferLine: Record "Transfer Line";
    begin
        //with TransferLine do begin   //BC Upgrade KUMBHS03 27022026 commented to remove with statement error
        TransferLine.INIT();
        TransferLine.VALIDATE("Document No.", TransferHeader."No.");
        TransferLine.SETRANGE("Document No.", TransferHeader."No.");
        if TransferLine.FINDLAST() then
            TransferLine."Line No." := TransferLine."Line No." + 10000
        else
            TransferLine."Line No." := 10000;
        TransferLine.INSERT(true);
        TransferLine.VALIDATE("Item No.", RequestLine2."Item No.");
        TransferLine.VALIDATE("Unit of Measure Code", RequestLine2."Unit of Measure Code");
        TransferLine.VALIDATE(Quantity, RequestLine2."Actual Qty.");
        TransferLine.MODIFY(true);
        //end;   //BC Upgrade KUMBHS03 27022026 commented to remove with statement error
    end;

    local procedure CreateRequestOrderArchive();
    var
        RequestHeaderArchive: Record "Request Ord Header Archive FND";
        RequestLine2: Record "Request Order Line FND";
        RequestLineArchive: Record "Request Order Line Archive FND";
    begin
        RequestHeaderArchive.LOCKTABLE();
        RequestHeaderArchive.INIT();
        RequestHeaderArchive.TRANSFERFIELDS(Rec);
        RequestHeaderArchive.INSERT();

        RequestLine2.SETRANGE("Document No.", "No.");
        if RequestLine2.findset() then
            repeat
                RequestLineArchive.LOCKTABLE();
                RequestLineArchive.INIT();
                RequestLineArchive.TRANSFERFIELDS(RequestLine2);
                RequestLineArchive.INSERT();
            until RequestLine2.NEXT() = 0;
    end;

    local procedure DeleteRequestOrder();
    var
        RequestHeader2: Record "Request Order Header FND";
        RequestLine2: Record "Request Order Line FND";
    begin
        RequestHeader2.GET("No.");
        RequestHeader2.DELETE();

        RequestLine2.SETRANGE("Document No.", "No.");
        RequestLine2.DELETEALL();
    end;
}

