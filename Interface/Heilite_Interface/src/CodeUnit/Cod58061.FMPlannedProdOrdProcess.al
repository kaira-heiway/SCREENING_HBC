codeunit 58061 "FM Planned Prod. Ord Process"
{
    // version FM,HEI.01
    //BC Upgrade GUNREM01 Old-ID 50151
    // HEI.01 CHG2207158 IBM PATHAA02 29.08.2023 # Planned Production Inbound Interface Enhancement
    // # New Object Created-Production Plan Inbound Interface Validations added in the new CU

    Permissions = TableData "Requisition Line" = rimd;
    TableNo = "Interface Entry Line INT";

    trigger OnRun();
    var
        FuturMasterInterfaceSetup2: Record "FuturMaster Interf Setup_2 INT";
        InterfaceEntryLine: Record "Interface Entry Line INT";
        DocumentNo: Code[20];
        LocationCode: Code[20];
        LineNo: Integer;
        ReqLine: Record "Requisition Line";
        ReqLine1: Record "Requisition Line";
        Item: Record Item;
        ProductionOrder: Record "Production Order";
        NewCode: Code[20];
    begin

        if FuturMasterInterfaceSetup2.GET then;
        InterfaceEntryLine.SETRANGE("Header Entry No.", Rec."Header Entry No.");
        InterfaceEntryLine.SETRANGE("Entry No.", Rec."Entry No.");
        if InterfaceEntryLine.FINDFIRST then begin
            ReqLine1.SETRANGE("Worksheet Template Name", FuturMasterInterfaceSetup2."ProdOrds WksTempName");
            ReqLine1.SETRANGE("Journal Batch Name", FuturMasterInterfaceSetup2.ProdOrdsJournBatchName);
            if ReqLine1.FINDLAST then
                LineNo := ReqLine1."Line No." + 10000
            else
                LineNo := 10000;

            ReqLine.INIT;
            ReqLine.VALIDATE("Worksheet Template Name", FuturMasterInterfaceSetup2."ProdOrds WksTempName");
            ReqLine.VALIDATE("Journal Batch Name", FuturMasterInterfaceSetup2.ProdOrdsJournBatchName);
            ReqLine.VALIDATE("Line No.", LineNo);
            ReqLine.INSERT;
            ReqLine.VALIDATE(Type, ReqLine.Type::Item);

            Item.RESET;
            if STRLEN(InterfaceEntryLine."No.") <= 19 then
                NewCode := '*' + InterfaceEntryLine."No."
            else
                NewCode := InterfaceEntryLine."No.";
            Item.SETFILTER("No.", '%1', NewCode);
            if Item.FINDFIRST then
                ReqLine.VALIDATE("No.", Item."No.");

            ReqLine.VALIDATE("Action Message", ReqLine."Action Message"::New);
            ReqLine.VALIDATE("Accept Action Message", true);
            ReqLine.VALIDATE("Replenishment System", ReqLine."Replenishment System"::"Prod. Order");
            ReqLine.VALIDATE("Location Code", Rec."Location Code");
            ReqLine.VALIDATE(Quantity, Rec.Quantity);
            ReqLine.VALIDATE("Starting Date", CALCDATE('<-CW>', Rec."Posting Date"));
            ReqLine.VALIDATE("Due Date", CALCDATE('<+4D>', ReqLine."Starting Date"));
            ReqLine.VALIDATE("Starting Date-Time", CREATEDATETIME(CALCDATE('<-CW>', TODAY), 000000T)); //monday of the current week
            ReqLine.VALIDATE("Ending Date-Time", CREATEDATETIME(CALCDATE('<+5D>', CALCDATE('<-CW>', TODAY)), 235959T)); //friday of the current week
            if InterfaceEntryLine."Cross Reference No." <> '' then
                ReqLine.VALIDATE("Production BOM No.", Rec."Cross Reference No.");
            if InterfaceEntryLine."Buy-from Vendor No." <> '' then
                ReqLine.VALIDATE("Production BOM Version Code", Rec."Buy-from Vendor No.");
            if InterfaceEntryLine."External Document No." <> '' then
                ReqLine.VALIDATE("Routing No.", Rec."External Document No.");
            if InterfaceEntryLine."Global No." <> '' then
                ReqLine.VALIDATE("Routing Version Code", Rec."Global No.");
            if InterfaceEntryLine."Unit of Measure Code" <> '' then
                ReqLine.VALIDATE("Unit of Measure Code", Rec."Unit of Measure Code");
            ReqLine.MODIFY;
        end;
    end;
}

