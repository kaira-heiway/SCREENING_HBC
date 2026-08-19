report 53002 "Create RPM Comp.Credit Updated"
{
    // HEI.01 PRM breakages IBM ISYED01 13.03.2019
    //   # created new report to create a credit memo from the posted return receipt
    // HEI.02 FDD-HT88 IBM BULIMC01 #new report for creating credit memo for RPM Breakages
    // BC Upgrade BHARDA11 >>
    // 1. Remove Drink-IT Fields and related code("Invoice Method","Truck Code","Driver Code","Goods Value","Order No.")
    // 2. Add ApplicationArea Property in Report and Requestpage Fields.
    // 3. Old Report ID is 50377.
    // BC Upgrade BHARAD11 <<
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = '"Create RPM Comp.Credit "';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Posted Customer Diff RPM FND"; "Posted Customer Diff RPM FND")
        {
            DataItemTableView = WHERE(Closed = FILTER(false), "RPM comp.Sales Credit memo No." = FILTER(= ''), "RPM Chipped" = FILTER(<> 0));
            RequestFilterFields = "Bill-to Customer No.";

            trigger OnAfterGetRecord();
            begin
                //create header
                SalesHeaderCMTemp.RESET();
                //IF NOT SalesHeaderCMTemp.GET(SalesHeaderCMTemp."Document Type"::"Credit Memo", "Sales return order no.") THEN
                if not SalesHeaderCMTemp.GET(SalesHeaderCMTemp."Document Type"::"Credit Memo", "Bill-to Customer No.") then begin
                    SalesHeaderCMTemp."Document Type" := SalesHeaderCMTemp."Document Type"::"Credit Memo";
                    // SalesHeaderCMTemp."No." := "Sales return order no.";
                    SalesHeaderCMTemp."No." := "Bill-to Customer No."; //changed
                    SalesHeaderCMTemp."Sell-to Customer No." := "Sell-to customer no.";
                    SalesHeaderCMTemp."Bill-to Customer No." := "Bill-to Customer No.";
                    // SalesHeaderCMTemp."Return Receipt No." := "Posted Sales Return receipt No";
                    // SalesHeaderCMTemp."Order No." := "Sales return order no.";
                    SalesHeaderCMTemp."Posting Date" := PostingDatefilter;
                    SalesHeaderCMTemp."Document Date" := DocumentDateFilter;
                    // BC Upgrade BHARDA11 >> ----Drink-IT Fields("Invoice Method","Truck Code","Driver Code")
                    // if not ((Cust."Invoice Method" = Cust."Invoice Method"::"Combine Shipments") and
                    //    (Cust."Invoice Method" = Cust."Invoice Method"::"Combine Shipments Per Sell-to"))
                    // then begin
                    //     ReturnReceiptHeader.SETRANGE("No.", "Posted Sales Return receipt No");
                    //     if ReturnReceiptHeader.FINDFIRST() then begin
                    //         SalesHeaderCMTemp."Shortcut Dimension 1 Code" := ReturnReceiptHeader."Shortcut Dimension 1 Code";
                    //         SalesHeaderCMTemp."Shortcut Dimension 2 Code" := ReturnReceiptHeader."Shortcut Dimension 2 Code";
                    //         SalesHeaderCMTemp."Dimension Set ID" := ReturnReceiptHeader."Dimension Set ID";
                    //         SalesHeaderCMTemp."Truck Code" := ReturnReceiptHeader."Truck Code";
                    //         SalesHeaderCMTemp."Driver Code" := ReturnReceiptHeader."Driver Code";
                    //     end;
                    // end;
                    // BC Upgrade BHARDA11 << ----Drink-IT Fields("Invoice Method","Truck Code","Driver Code")
                    SalesHeaderCMTemp."External Document No." := ExtDocNoFilter;
                    SalesHeaderCMTemp."RPM comp.SalesCrd. memoNo. FND" := true;
                    SalesHeaderCMTemp.VALIDATE(Receive, true);
                    SalesHeaderCMTemp.INSERT(); //changed

                    SalesLineCMTemp.INIT();
                    SalesLineCMTemp."Document No." := SalesHeaderCMTemp."No.";
                    SalesLineCMTemp."Document Type" := SalesHeaderCMTemp."Document Type"::"Credit Memo";
                    NextLineNo := 10000;
                    SalesLineCMTemp."Line No." := NextLineNo;
                    SalesLineCMTemp.Type := SalesLineCMTemp.Type::" ";
                    SalesLineCMTemp.Description := STRSUBSTNO(Text009, FORMAT(EndDateFilter));
                    // SalesLineCMTemp."Goods Value" := true; // BC Upgrade BHARDA11 ----Drink-IT Field("Goods Value")
                    SalesLineCMTemp.INSERT();
                end;
                //create line
                SalesHeaderCMTemp.RESET();
                // IF SalesHeaderCMTemp.GET(SalesHeaderCMTemp."Document Type"::"Credit Memo", "Bill-to Customer No.") THEN
                if SalesHeaderCMTemp.GET(SalesHeaderCMTemp."Document Type"::"Credit Memo", "Bill-to Customer No.") then begin
                    NextLineNo := 10000;
                    SalesLineCMTemp.RESET();
                    SalesLineCMTemp.SETRANGE("Document Type", SalesHeaderCMTemp."Document Type"::"Credit Memo");
                    // SalesLineCMTemp.SETRANGE("Document No.","Sales return order no.");
                    SalesLineCMTemp.SETRANGE("Document No.", "Bill-to Customer No."); //changed
                    if SalesLineCMTemp.FINDLAST() then
                        NextLineNo := SalesLineCMTemp."Line No." + 10000;

                    SalesLineCMTemp.INIT();
                    SalesLineCMTemp."Line No." := NextLineNo;
                    SalesLineCMTemp."Document Type" := SalesLineCMTemp."Document Type"::"Credit Memo";
                    SalesLineCMTemp."Document No." := SalesHeaderCMTemp."No.";
                    SalesLineCMTemp.INSERT();

                    SalesReceivablesSetup.GET();

                    SalesLineCMTemp.Type := SalesLineCMTemp.Type::Resource;
                    //SalesReceivablesSetup.TESTFIELD(SalesReceivablesSetup."RPM Chipped comp. Res.no.");
                    SalesLineCMTemp."No." := SalesReceivablesSetup."RPM Chipped comp. Res.no. FND";

                    if Cust.GET("Sell-to customer no.") then
                        SalesLineCMTemp."Location Code" := Cust."Location Code";
                    SalesLineCMTemp."Bill-to Customer No." := "Bill-to Customer No.";
                    SalesLineCMTemp."Sell-to Customer No." := "Sell-to customer no.";

                    if Cust.GET("Bill-to Customer No.") then
                        SalesLineCMTemp."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";

                    ResourceUnitofMeasure.SETRANGE("Resource No.", SalesReceivablesSetup."RPM Chipped comp. Res.no. FND");
                    if ResourceUnitofMeasure.FINDFIRST then
                        SalesLineCMTemp."Unit of Measure Code" := ResourceUnitofMeasure.Code;

                    if Resource.GET(SalesReceivablesSetup."RPM Chipped comp. Res.no. FND") then begin
                        SalesLineCMTemp."Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                        SalesLineCMTemp."VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                    end;
                    SalesLineCMTemp."Unit Price" := "Deposit Price" * (SalesReceivablesSetup."RPM Chipped comp.% FND" / 100);
                    SalesLineCMTemp.Description := "Item Description";
                    SalesLineCMTemp."Description 2" := "Sales return order no." + '-' + FORMAT(PostingDatefilter);
                    SalesLineCMTemp.Quantity := "RPM Chipped";
                    SalesLineCMTemp."Qty. to Invoice" := "RPM Chipped";
                    SalesLineCMTemp."Return Qty. to Receive" := "RPM Chipped";
                    // SalesLineCMTemp."Order No." := SalesHeaderCMTemp."Order No."; // BC Upgrade BHARDA11 ----Drink-IT Field("Order No.")
                    SalesLineCMTemp.IsCreditDocType;
                    SalesLineCMTemp.MODIFY;
                end;
            end;

            trigger OnPostDataItem();
            begin


                SalesHeaderCMTemp.RESET();
                if SalesHeaderCMTemp.FINDFIRST then
                    repeat
                        //create header
                        SalesHeader.INIT();
                        SalesHeader."Document Type" := SalesHeaderCMTemp."Document Type"::"Credit Memo";
                        SalesHeader."No." := '';
                        SalesHeader.INSERT(true);
                        SalesHeader.VALIDATE("Sell-to Customer No.", SalesHeaderCMTemp."Sell-to Customer No.");
                        SalesHeader.VALIDATE("Bill-to Customer No.", SalesHeaderCMTemp."Bill-to Customer No.");
                        SalesHeader.VALIDATE("Posting Date", PostingDatefilter);
                        SalesHeader.VALIDATE("Document Date", DocumentDateFilter);
                        SalesHeader.VALIDATE("External Document No.", ExtDocNoFilter);
                        // BC Upgrade BHARDA11 >> ----Drink-IT Field("Invoice Method","Truck Code","Driver Code")
                        // if not ((Cust."Invoice Method" = Cust."Invoice Method"::"Combine Shipments") and
                        //    (Cust."Invoice Method" = Cust."Invoice Method"::"Combine Shipments Per Sell-to"))
                        // then begin
                        //     ReturnReceiptHeader.SETRANGE("No.", "Posted Sales Return receipt No");
                        //     if ReturnReceiptHeader.FINDFIRST then begin
                        //         SalesHeader."Shortcut Dimension 1 Code" := SalesHeaderCMTemp."Shortcut Dimension 1 Code";
                        //         SalesHeader."Shortcut Dimension 2 Code" := SalesHeaderCMTemp."Shortcut Dimension 2 Code";
                        //         SalesHeader."Dimension Set ID" := SalesHeaderCMTemp."Dimension Set ID";
                        //         SalesHeader."Truck Code" := SalesHeaderCMTemp."Truck Code";
                        //         SalesHeader."Driver Code" := SalesHeaderCMTemp."Driver Code";
                        //     end;
                        // end;
                        // BC Upgrade BHARDA11 << ----Drink-IT Field("Invoice Method","Truck Code","Driver Code")
                        SalesHeader."RPM comp.SalesCrd. memoNo. FND" := true;
                        SalesHeader.VALIDATE(Receive, true);
                        SalesHeader.MODIFY;

                        //create first line

                        SalesLineCMTemp.RESET();
                        SalesLineCMTemp.SETRANGE("Document Type", SalesHeaderCMTemp."Document Type"::"Credit Memo");
                        SalesLineCMTemp.SETRANGE("Document No.", SalesHeaderCMTemp."No.");
                        SalesLineCMTemp.SETFILTER(SalesLineCMTemp."No.", '=%1', '');
                        if SalesLineCMTemp.FINDFIRST then
                            repeat
                                SalesLine.INIT();
                                SalesLine."Document No." := SalesHeader."No.";
                                SalesLine."Document Type" := SalesHeader."Document Type";
                                SalesLine."Line No." := SalesLineCMTemp."Line No.";
                                SalesLine.Description := SalesLineCMTemp.Description;
                                SalesLine.INSERT();
                            until SalesLineCMTemp.NEXT = 0;


                        //create sales credit memo lines
                        SalesLineCMTemp.RESET();
                        SalesLineCMTemp.INIT();
                        SalesLineCMTemp.SETRANGE("Document Type", SalesHeaderCMTemp."Document Type"::"Credit Memo");
                        SalesLineCMTemp.SETRANGE("Document No.", SalesHeaderCMTemp."No.");
                        SalesLineCMTemp.SETFILTER(SalesLineCMTemp."No.", '<>%1', '');
                        if SalesLineCMTemp.FINDFIRST then
                            repeat
                                SalesLine.INIT();
                                SalesLine."Document Type" := SalesHeader."Document Type"::"Credit Memo";
                                SalesLine."Document No." := SalesHeader."No.";
                                SalesLine."Line No." := SalesLineCMTemp."Line No.";
                                SalesLine.INSERT();

                                SalesReceivablesSetup.GET();
                                SalesReceivablesSetup.TESTFIELD(SalesReceivablesSetup."RPM Chipped comp. Res.no. FND");
                                SalesLine.Type := SalesLineCMTemp.Type;
                                SalesLine."No." := SalesReceivablesSetup."RPM Chipped comp. Res.no. FND";


                                if Cust.GET(SalesLine."Sell-to Customer No.") then
                                    SalesLine."Location Code" := Cust."Location Code";
                                SalesLine."Bill-to Customer No." := SalesLineCMTemp."Bill-to Customer No.";
                                SalesLine."Sell-to Customer No." := SalesLineCMTemp."Sell-to Customer No.";

                                if Cust.GET(SalesLineCMTemp."Bill-to Customer No.") then
                                    SalesLine."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";

                                ResourceUnitofMeasure.SETRANGE("Resource No.", SalesReceivablesSetup."RPM Chipped comp. Res.no. FND");
                                if ResourceUnitofMeasure.FINDFIRST then
                                    SalesLine.VALIDATE("Unit of Measure Code", ResourceUnitofMeasure.Code);

                                if Resource.GET(SalesReceivablesSetup."RPM Chipped comp. Res.no. FND") then begin
                                    SalesLine.VALIDATE("Gen. Prod. Posting Group", Resource."Gen. Prod. Posting Group");
                                    SalesLine.VALIDATE("VAT Prod. Posting Group", Resource."VAT Prod. Posting Group");
                                end;
                                SalesLine."Unit Price" := SalesLineCMTemp."Unit Price";
                                SalesLine.Description := SalesLineCMTemp.Description;
                                SalesLine."Description 2" := SalesLineCMTemp."Description 2";
                                SalesLine.Quantity := SalesLineCMTemp.Quantity;
                                SalesLine."Qty. to Invoice" := SalesLineCMTemp."Qty. to Invoice";
                                SalesLine."Return Qty. to Receive" := SalesLineCMTemp."Return Qty. to Receive";
                                // SalesLine."Order No." := SalesHeaderCMTemp."Order No."; // BC Upgrade BHARAD11 ----Drink-IT Field("Order No.")
                                SalesLine.IsCreditDocType;
                                SalesLine.MODIFY;
                            until SalesLineCMTemp.NEXT = 0;


                        //update Posted Customer Differences values
                        CLEAR(SalesPost);
                        COMMIT();
                        NoOfSalesInv := NoOfSalesInv + 1;
                        if PostCrMemo then begin
                            if not SalesPost.RUN(SalesHeader) then begin
                                NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
                                DeleteUnpostedCrMdoc(SalesHeader);
                            end
                            else begin
                                //PostedCustomerDiffRPM.SETRANGE("Sales return order no.", SalesHeader."Order No.");
                                PostedCustomerDiffRPM.SETRANGE("Bill-to Customer No.", SalesHeader."Bill-to Customer No.");
                                PostedCustomerDiffRPM.SETRANGE("RPM comp.Sales Credit memo No.", '');
                                if PostedCustomerDiffRPM.FINDFIRST then
                                    repeat
                                        SalesCrMemoHeader.RESET();
                                        SalesCrMemoHeader.SETFILTER("Pre-Assigned No.", SalesHeader."No.");
                                        if SalesCrMemoHeader.FINDSET then
                                            repeat
                                                PostedCustomerDiffRPM.Closed := true;
                                                PostedCustomerDiffRPM."Closed By Document No." := SalesHeader."No.";
                                                PostedCustomerDiffRPM."Closed By Posting Date" := PostingDatefilter;
                                                PostedCustomerDiffRPM."Closed on Date" := TODAY;
                                                PostedCustomerDiffRPM."Closed By User Id" := USERID;
                                                PostedCustomerDiffRPM."RPM comp.Sales Credit memo No." := SalesCrMemoHeader."No.";
                                                PostedCustomerDiffRPM.MODIFY(true);
                                            until SalesCrMemoHeader.NEXT = 0;
                                    until PostedCustomerDiffRPM.NEXT = 0;
                            end;

                        end else begin
                            // PostedCustomerDiffRPM.SETRANGE("Sales return order no.", SalesHeader."Order No.");
                            PostedCustomerDiffRPM.SETRANGE("Bill-to Customer No.", SalesHeader."Bill-to Customer No.");
                            PostedCustomerDiffRPM.SETRANGE("RPM comp.Sales Credit memo No.", '');
                            if PostedCustomerDiffRPM.FINDSET then
                                repeat
                                    PostedCustomerDiffRPM."RPM comp.Sales Credit memo No." := SalesHeader."No.";
                                    PostedCustomerDiffRPM.MODIFY(true);
                                until PostedCustomerDiffRPM.NEXT = 0;
                        end;

                    until SalesHeaderCMTemp.NEXT = 0;


                CurrReport.LANGUAGE := GLOBALLANGUAGE;


                if SalesHeader."No." <> '' then begin
                    if PostCrMemo then
                        MESSAGE(Text011, SalesHeader."No.")
                    else
                        MESSAGE(Text007, SalesHeader."No.");
                end else
                    MESSAGE(Text008);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Posting Date"; PostingDatefilter)
                {
                    ApplicationArea = All;
                }
                field("Document Date"; DocumentDateFilter)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDateFilter)
                {
                    ApplicationArea = All;
                }
                field("Ex. Doc No"; ExtDocNoFilter)
                {
                    ApplicationArea = All;
                }
                field("Post Cr. Memo"; PostCrMemo)
                {
                    ApplicationArea = All;
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
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        PostingDatefilter: Date;
        DocumentDateFilter: Date;
        ExtDocNoFilter: Code[30];
        EndDateFilter: Date;
        PostCrMemo: Boolean;
        SalesHeader: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";
        NoOfSalesInv: Integer;
        NoOfSalesInvErrors: Integer;
        Text007: TextConst ENU = 'A Credit memo %1 is Created.', FRA = 'Tous les avoirs n''ont pas été validés. %1 avoirs n''ont pas été validés.';
        Cust: Record Customer;
        SalesLine: Record "Sales Line";
        Text009: Label 'RPM Breakage compensation %1';
        Text008: TextConst ENU = 'There is nothing to Post/Create.', FRA = 'Il n''y a rien à regrouper.';
        Text011: TextConst ENU = 'A Credit memo %1 is Posted.', FRA = 'Tous les avoirs n''ont pas été validés. %1 avoirs n''ont pas été validés.';
        PostedCustomerDiffRPM: Record "Posted Customer Diff RPM FND";
        Resource: Record Resource;
        ResourceUnitofMeasure: Record "Resource Unit of Measure";
        NextLineNo: Integer;
        SalesHeaderCMTemp: Record "Sales Header" temporary;
        SalesLineCMTemp: Record "Sales Line" temporary;

    local procedure DeleteUnpostedCrMdoc(ParSalesHeader: Record "Sales Header");
    var
        localSalesHeader: Record "Sales Header";
        localSalesLine: Record "Sales Line";
    begin

        localSalesHeader.RESET();
        localSalesHeader.SETFILTER("No.", ParSalesHeader."No.");
        if localSalesHeader.FINDSET() then
            localSalesHeader.DELETE();

        localSalesLine.RESET();
        localSalesLine.SETFILTER("Document No.", ParSalesHeader."No.");
        if localSalesLine.FINDSET() then
            localSalesLine.DELETE();
    end;
}

