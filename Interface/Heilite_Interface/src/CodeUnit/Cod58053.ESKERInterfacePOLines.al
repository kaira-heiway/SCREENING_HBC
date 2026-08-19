codeunit 58053 "ESKER Interface POLines"
{
    //BC Upgrade GUNREM01 Old ID-50059
    // version ESKER

    // HEI.01 CHG2028862 Mozambique_Esker IBM POSTOI01, 27.08.2019
    //   # new object ESKER POLines asynch
    // HEI.02 IBM POSTOI01, 27.08.2019
    //   # correct string length


    trigger OnRun();
    begin
        ExportPOLines;
    end;

    var
        GeneralInterfaceSetupRead: Boolean;
        EskerInterfaceSetupRead: Boolean;
        EskerInterfaceSetup: Record "Esker Interface Setup INT";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        InterfaceSetup: Record "Interface Setup INT";
        CompanyInformation: Record "Company Information";
        OpCoSetup: Record "OPCO Setup FND";
        POLine: Record "Purchase Line";
        LastEntryNo: Integer;
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        EntryNo: Integer;
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        ExportCurrLine: Boolean;
        PurchHdr: Record "Purchase Header";
        DimensionSetEntry: Record "Dimension Set Entry";
        PORcptLine: Record "Purch. Rcpt. Line";
        recGPurchLine: Record "Purchase Line";
        RcptLineQtyAssign: Text[30];
        RcptLineQtyAssigned: Text[30];
        RcptLineType: Text[30];
        recPurchRcptHeader: Record "Purch. Rcpt. Header";

    local procedure GetGeneralInterfaceSetup();
    begin
        //HEI.01
        if not GeneralInterfaceSetupRead then
            GeneralInterfaceSetup.GET;
        GeneralInterfaceSetupRead := true;
    end;

    local procedure GetEskerInterfaceSetup();
    begin
        //HEI.01
        if not EskerInterfaceSetupRead then
            if EskerInterfaceSetup.GET then;
        EskerInterfaceSetupRead := true;
    end;

    local procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250];
    begin
        while STRPOS(String, FindWhat) > 0 do
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    local procedure ExportPOLines();
    begin
        GetGeneralInterfaceSetup;
        GetEskerInterfaceSetup;
        InterfaceSetup.GET(EskerInterfaceSetup."Esker POLines Interf");
        if not InterfaceSetup.Enabled then
            exit;

        CompanyInformation.GET;
        OpCoSetup.GET;
        GeneralInterfaceSetup.TESTFIELD("Cost Center Dimension Code");
        GeneralInterfaceSetup.TESTFIELD("Brand Dim. Code");
        OpCoSetup.TESTFIELD("Business Type Dimension Code");
        OpCoSetup.TESTFIELD("Movement Type Dimension Code");

        //export Purchase Order lines
        POLine.RESET;
        POLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        POLine.SETRANGE("Document Type", POLine."Document Type"::Order);
        if POLine.FINDSET then begin
            InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
            CLEAR(InterfaceEntryHeaderOut);

            InterfaceEntryHeaderOut.INIT;
            InterfaceEntryHeaderOut."Interface Code" := EskerInterfaceSetup."Esker POLines Interf";
            InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
            InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;

            //InterfaceEntryHeaderOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Msg. Sender Business System ID" := COMPANYNAME;
            InterfaceEntryHeaderOut."Msg. Recv. Business System ID" := OutboundInterface."HeiLite Business System ID";
            InterfaceEntryHeaderOut."Source System ID" := OutboundInterface."Logical System ID";
            InterfaceEntryHeaderOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            InterfaceEntryHeaderOut.INSERT(true);
            repeat
                //>>test the current line
                ExportCurrLine := true;

                if (POLine.Quantity = POLine."Quantity Received") or (POLine.Quantity = POLine."Quantity Invoiced") then
                    ExportCurrLine := false;

                PurchHdr.RESET;
                PurchHdr.SETCURRENTKEY("Document Type", "No.", Status);
                PurchHdr.SETRANGE("Document Type", PurchHdr."Document Type"::Order);
                PurchHdr.SETRANGE("No.", POLine."Document No.");
                PurchHdr.SETFILTER(Status, '<>%1', PurchHdr.Status::Open);
                if PurchHdr.ISEMPTY then
                    ExportCurrLine := false;
                //<<test the current line
                if ExportCurrLine then begin
                    CLEAR(InterfaceEntryLineOut);
                    EntryNo += 1;
                    InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                    InterfaceEntryLineOut."Entry No." := EntryNo;
                    InterfaceEntryLineOut."Buy-from Vendor No." := POLine."Pay-to Vendor No.";

                    InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                    InterfaceEntryLineOut."Order No." := POLine."Document No.";
                    InterfaceEntryLineOut."Item No." := FORMAT(POLine."Line No.");
                    InterfaceEntryLineOut."No." := POLine."No.";
                    //HEI.02   InterfaceEntryLineOut.Description := ReplaceString(ReplaceString(POLine.Description, '"', '{QUOTE}'), '{QUOTE}', '\"');
                    //HEI.02>>
                    InterfaceEntryLineOut.Description := COPYSTR(ReplaceString(ReplaceString(POLine.Description, '"', '{QUOTE}'), '{QUOTE}', '\"'), 1, 50);
                    //HEI.02<<
                    InterfaceEntryLineOut."Global No." := FORMAT(POLine."Direct Unit Cost", 0, '<Precision,4:4><Standard Format,9>');
                    //order amount
                    InterfaceEntryLineOut."Cross Reference No." := FORMAT(POLine."Line Amount", 0, 9);
                    //order qty
                    InterfaceEntryLineOut."Blanket Order No." := FORMAT(POLine.Quantity, 0, 9);
                    //invoice amount
                    InterfaceEntryLineOut."CMG Code" := '0';
                    //invoiced quantity
                    InterfaceEntryLineOut."Ship-to Name" := '0';
                    //delivered amount
                    InterfaceEntryLineOut."Ship-to Address" := '0';
                    //delivered quantity
                    InterfaceEntryLineOut."Ship-to Address 2" := '0';
                    //tax code
                    InterfaceEntryLineOut.Contact := POLine."VAT Identifier";
                    if POLine."VAT Bus. Posting Group" <> '' then
                        InterfaceEntryLineOut.Contact := InterfaceEntryLineOut.Contact + ' (' + POLine."VAT Bus. Posting Group" + ')';
                    //good receipt
                    InterfaceEntryLineOut."Phone No." := '';
                    InterfaceEntryLineOut."External Requisition No." := '';
                    //Type
                    InterfaceEntryLineOut."Ship-to City" := FORMAT(POLine.Type);
                    //quantity to assign
                    InterfaceEntryLineOut."Ship-to Post Code" := FORMAT(POLine."Qty. to Assign", 0, 9);
                    InterfaceEntryLineOut."E-Mail 2" := FORMAT(POLine."Qty. Assigned", 0, 9);
                    InterfaceEntryLineOut."Unit of Measure Code" := POLine."Unit of Measure Code";
                    //dimensions
                    //BRAND dimension
                    DimensionSetEntry.RESET;
                    DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                    DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                    if DimensionSetEntry.FINDFIRST then begin
                        InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionSetEntry."Dimension Value Code";
                    end;
                    //Cost center dimension
                    DimensionSetEntry.RESET;
                    DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                    DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                    if DimensionSetEntry.FINDFIRST then begin
                        InterfaceEntryLineOut."Cost Center Code" := DimensionSetEntry."Dimension Value Code";
                    end;
                    //Business Type dimension
                    DimensionSetEntry.RESET;
                    DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                    DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Business Type Dimension Code");
                    if DimensionSetEntry.FINDFIRST then begin
                        InterfaceEntryLineOut."Shortcut Dimension 2 Code" := DimensionSetEntry."Dimension Value Code";
                    end;


                    //Movement Type dimension
                    DimensionSetEntry.RESET;
                    DimensionSetEntry.SETRANGE("Dimension Set ID", POLine."Dimension Set ID");
                    DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Movement Type Dimension Code");
                    if DimensionSetEntry.FINDFIRST then begin
                        InterfaceEntryLineOut."Movement Type" := DimensionSetEntry."Dimension Value Code";
                    end;

                    InterfaceEntryLineOut.INSERT;
                end;
            until POLine.NEXT = 0;

            //export the Purchase Receipt Lines
            PORcptLine.RESET;
            PORcptLine.SETCURRENTKEY("Order No.", Quantity);
            PORcptLine.SETFILTER("Order No.", '<>%1', '');
            PORcptLine.SETFILTER(Quantity, '<>%1', 0);
            if PORcptLine.FINDFIRST then begin
                repeat
                    //>>test each line
                    ExportCurrLine := true;
                    if not recGPurchLine.GET(recGPurchLine."Document Type"::Order, PORcptLine."Order No.", PORcptLine."Order Line No.") then
                        ExportCurrLine := false
                    else begin
                        if (recGPurchLine."Quantity Received" = recGPurchLine.Quantity) and (recGPurchLine."Quantity Invoiced" = recGPurchLine.Quantity) then
                            ExportCurrLine := false;
                        if PurchHdr.GET(recGPurchLine."Document Type", recGPurchLine."Document No.") then
                            if PurchHdr.Status = PurchHdr.Status::Open then
                                ExportCurrLine := false;
                        recGPurchLine.RESET;
                        recGPurchLine.SETRANGE(recGPurchLine."Document Type", recGPurchLine."Document Type"::Order);
                        recGPurchLine.SETRANGE(recGPurchLine."Document No.", PORcptLine."Order No.");
                        recGPurchLine.SETRANGE(recGPurchLine."Line No.", PORcptLine."Order Line No.");
                        if recGPurchLine.FINDFIRST then begin
                            RcptLineType := FORMAT(recGPurchLine.Type);
                            recGPurchLine.CALCFIELDS("Qty. to Assign", "Qty. Assigned");
                            RcptLineQtyAssign := FORMAT(recGPurchLine."Qty. to Assign");
                            RcptLineQtyAssigned := FORMAT(recGPurchLine."Qty. Assigned");
                        end;
                    end;
                    //<<test each line
                    if ExportCurrLine then begin
                        CLEAR(InterfaceEntryLineOut);
                        EntryNo += 1;
                        InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                        InterfaceEntryLineOut."Entry No." := EntryNo;
                        InterfaceEntryLineOut."Buy-from Vendor No." := PORcptLine."Pay-to Vendor No.";
                        InterfaceEntryLineOut."Description 2" := COMPANYNAME;
                        InterfaceEntryLineOut."Order No." := PORcptLine."Order No.";
                        InterfaceEntryLineOut."Item No." := FORMAT(PORcptLine."Order Line No.");
                        InterfaceEntryLineOut."No." := PORcptLine."No.";
                        //HEI.02 InterfaceEntryLineOut.Description := ReplaceString(ReplaceString(PORcptLine.Description, '"', '{QUOTE}'), '{QUOTE}', '\"');
                        //HEI.02>>
                        InterfaceEntryLineOut.Description := COPYSTR(ReplaceString(ReplaceString(PORcptLine.Description, '"', '{QUOTE}'), '{QUOTE}', '\"'), 1, 50);
                        //HEI.02<<

                        InterfaceEntryLineOut."Global No." := FORMAT(PORcptLine."Direct Unit Cost", 0, '<Precision,4:4><Standard Format,9>');
                        //order amount
                        InterfaceEntryLineOut."Cross Reference No." := '0';
                        if recGPurchLine.Amount <> 0 then
                            InterfaceEntryLineOut."Cross Reference No." := FORMAT(recGPurchLine.Amount, 0, 9);

                        //order qty
                        InterfaceEntryLineOut."Blanket Order No." := '0';
                        if recGPurchLine.Quantity <> 0 then
                            InterfaceEntryLineOut."Blanket Order No." := FORMAT(recGPurchLine.Quantity, 0, 9);

                        //invoice amount
                        if recGPurchLine.Quantity <> 0 then
                            InterfaceEntryLineOut."CMG Code" := FORMAT(PORcptLine."Quantity Invoiced" * recGPurchLine.Amount / recGPurchLine.Quantity, 0, 9);


                        //invoiced quantity
                        InterfaceEntryLineOut."Ship-to Name" := FORMAT(PORcptLine."Quantity Invoiced", 0, 9);

                        //delivered amount
                        if recGPurchLine.Quantity <> 0 then
                            InterfaceEntryLineOut."Ship-to Address" := FORMAT(PORcptLine.Quantity * recGPurchLine.Amount / recGPurchLine.Quantity, 0, 9);

                        //delivered quantity
                        InterfaceEntryLineOut."Ship-to Address 2" := FORMAT(PORcptLine.Quantity, 0, 9);

                        //tax code
                        InterfaceEntryLineOut.Contact := recGPurchLine."VAT Identifier";
                        if recGPurchLine."VAT Bus. Posting Group" <> '' then
                            InterfaceEntryLineOut.Contact := InterfaceEntryLineOut.Contact + ' (' + recGPurchLine."VAT Bus. Posting Group" + ')';

                        //good receipt
                        InterfaceEntryLineOut."Phone No." := PORcptLine."Document No.";

                        if recPurchRcptHeader.GET(PORcptLine."Document No.") then
                            InterfaceEntryLineOut."External Requisition No." := FORMAT(recPurchRcptHeader."Document Date", 0, 9);

                        //Type
                        InterfaceEntryLineOut."Ship-to City" := RcptLineType;
                        //quantity to assign
                        InterfaceEntryLineOut."Ship-to Post Code" := RcptLineQtyAssign;
                        InterfaceEntryLineOut."E-Mail 2" := RcptLineQtyAssigned;
                        InterfaceEntryLineOut."Unit of Measure Code" := PORcptLine."Unit of Measure Code";
                        //dimensions

                        //BRAND dimension
                        DimensionSetEntry.RESET;
                        DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                        DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Brand Dim. Code");
                        if DimensionSetEntry.FINDFIRST then begin
                            InterfaceEntryLineOut."Shortcut Dimension 1 Code" := DimensionSetEntry."Dimension Value Code";
                        end;

                        //Cost center dimension
                        DimensionSetEntry.RESET;
                        DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                        DimensionSetEntry.SETRANGE("Dimension Code", GeneralInterfaceSetup."Cost Center Dimension Code");
                        if DimensionSetEntry.FINDFIRST then begin
                            InterfaceEntryLineOut."Cost Center Code" := DimensionSetEntry."Dimension Value Code";
                        end;

                        //Business Type dimension
                        DimensionSetEntry.RESET;
                        DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                        DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Business Type Dimension Code");
                        if DimensionSetEntry.FINDFIRST then begin
                            InterfaceEntryLineOut."Shortcut Dimension 2 Code" := DimensionSetEntry."Dimension Value Code";
                        end;


                        //Movement Type dimension
                        DimensionSetEntry.RESET;
                        DimensionSetEntry.SETRANGE("Dimension Set ID", PORcptLine."Dimension Set ID");
                        DimensionSetEntry.SETRANGE("Dimension Code", OpCoSetup."Movement Type Dimension Code");
                        if DimensionSetEntry.FINDFIRST then begin
                            InterfaceEntryLineOut."Movement Type" := DimensionSetEntry."Dimension Value Code";
                        end;

                        InterfaceEntryLineOut.INSERT;
                    end;
                until PORcptLine.NEXT = 0;
            end
        end;
    end;
}

