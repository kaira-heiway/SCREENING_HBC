report 52047 "Contract Overview PxQ"
{
    // version HEI.01

    // HEI.01 CHG2111765 IBM SHIVAS05 07/07/2021
    //   # Create New report for CHG2111765.

    // BC Upgrade KUMARS145 Nav ID Report 50525 "Contract Overview PxQ"

    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST("Blanket Order"), "Channel FND" = CONST('A'));
            RequestFilterFields = "SRM Contract No. FND", "No.", "Buy-from Vendor No.";
            dataitem("Purchase Line"; "Purchase Line")
            {
                CalcFields = "SRM Contract Type FND", "Valid From FND", "Valid To FND";
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Type = CONST(Item));

                trigger OnAfterGetRecord();
                var
                    PaymentTerms: Record "Payment Terms";
                    Item: Record Item;
                    PurchaseLinePrice: Record "Purchase Line Price FND";
                    PayTermDesc: Text;
                    ItemNo2: Text;
                begin
                    CLEAR(PayTermDesc);
                    PaymentTerms.RESET();
                    PaymentTerms.SETRANGE(Code, "Purchase Header"."Payment Terms Code");
                    if PaymentTerms.FINDFIRST() then
                        PayTermDesc := PaymentTerms.Description;
                    CLEAR(ItemNo2);
                    Item.RESET();
                    Item.SETRANGE("No.", "Purchase Line"."No.");
                    if Item.FINDFIRST() then
                        ItemNo2 := Item."No. 2";

                    PurchaseLinePrice.RESET();
                    PurchaseLinePrice.SETRANGE("Document Type", "Purchase Line"."Document Type");
                    PurchaseLinePrice.SETRANGE("Document No.", "Purchase Line"."Document No.");
                    PurchaseLinePrice.SETRANGE("Document Line No.", "Purchase Line"."Line No.");
                    if PurchaseLinePrice.FINDSET() then
                        repeat
                            TempExcelBuffer.NewRow();
                            TempExcelBuffer.AddColumn("Purchase Line"."SRM Contract No. FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line"."SRM Contract Line No. FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Header"."SRM Contract Name FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Header"."Document Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                            TempExcelBuffer.AddColumn("Purchase Header"."Channel FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line"."Valid From FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                            TempExcelBuffer.AddColumn("Purchase Line"."Valid To FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                            TempExcelBuffer.AddColumn("Purchase Line"."SRM Contract Type FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Header"."Shipment Method Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Header"."Payment Terms Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn(PayTermDesc, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Header"."Buy-from Vendor No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Header"."Buy-from Vendor Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Header"."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line"."Line No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn("Purchase Line".Type, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line"."Block Line Ordering FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line"."CMG Code FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line"."Shortcut Dimension 2 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line"."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn(ItemNo2, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line".Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line"."Location Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn("Purchase Line".Quantity, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn("Purchase Line"."Unit of Measure Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn(PurchaseLinePrice."Starting Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                            TempExcelBuffer.AddColumn(PurchaseLinePrice."Ending Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                            TempExcelBuffer.AddColumn(PurchaseLinePrice."Currency Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn(PurchaseLinePrice."Direct Cost Per Multiplier", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn(PurchaseLinePrice."Direct Unit Cost Multiplier", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn(PurchaseLinePrice."Unit of Measure Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                            TempExcelBuffer.AddColumn(PurchaseLinePrice."Minimum Quantity", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn("Purchase Line"."Quantity Received", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn("Purchase Line"."Quantity Invoiced", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn("Purchase Line"."Tolerance Received Over % FND", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                            TempExcelBuffer.AddColumn("Purchase Line"."Tolerance Received Under % FND", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                        until PurchaseLinePrice.NEXT() = 0
                    else begin
                        TempExcelBuffer.NewRow();
                        TempExcelBuffer.AddColumn("Purchase Line"."SRM Contract No. FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line"."SRM Contract Line No. FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Header"."SRM Contract Name FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Header"."Document Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn("Purchase Header"."Channel FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line"."Valid From FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn("Purchase Line"."Valid To FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn("Purchase Line"."SRM Contract Type FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Header"."Shipment Method Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Header"."Payment Terms Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(PayTermDesc, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Header"."Buy-from Vendor No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Header"."Buy-from Vendor Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Header"."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line"."Line No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn("Purchase Line".Type, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line"."Block Line Ordering FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line"."CMG Code FND", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line"."Shortcut Dimension 2 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line"."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(ItemNo2, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line".Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line"."Location Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn("Purchase Line".Quantity, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn("Purchase Line"."Unit of Measure Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(0, false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(0, false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(0, false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn("Purchase Line"."Quantity Received", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn("Purchase Line"."Quantity Invoiced", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn("Purchase Line"."Tolerance Received Over % FND", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn("Purchase Line"."Tolerance Received Under % FND", false, '', false, false, false, '0.00', TempExcelBuffer."Cell Type"::Number);
                    end;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if (("Purchase Header"."Valid From FND" < ValidFrom) and ("Purchase Header"."Valid To FND" < ValidFrom) and (ValidFrom <> 0D)) or
                   (("Purchase Header"."Valid From FND" > ValidTo) and ("Purchase Header"."Valid To FND" > ValidTo) and (ValidTo <> 0D)) then
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem();
            begin
                TempExcelBuffer.NewRow();
                TempExcelBuffer.AddColumn('SRM Contract No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('SRM Contract Line No.', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Legal contract', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Contract date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Channel', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Contract start date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Contract end date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Operating model', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Incoterm', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Payment Terms Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Payment Term Description', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Vendor Local ID', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Vendor Local Name', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Blanket PO number', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Blanket PO Line number', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Line type', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Block Line Ordering', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CMG', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Cost center', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Item Local ID', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Item Global ID', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Item Description', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Location Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Quantity', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Unit of Measure Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Price validity Starting Date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Price validity Ending Date', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Currency', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Price', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Price Per', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Unit of Measure Code', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Minimum Quantity', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Quantity Received', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Quantity Invoiced', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Tolerance Received Over %', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Tolerance Received Under %', false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ValidFrom; ValidFrom)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Valid From';
                        ToolTip = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.';
                    }
                    field(ValidTo; ValidTo)
                    {
                        ApplicationArea = all;
                        Caption = 'Valid To';
                        ToolTip = 'Valid To';
                    }
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

    trigger OnPostReport();
    begin
        // BC Upgrade KUMARS145 Replaced with New Function...>>
        // TempExcelBuffer.CreateBookAndOpenExcel('', 'Contract overview report PxQ', '', COMPANYNAME, USERID);
        TempExcelBuffer.CreateNewBook('Contract overview report PxQ');
        TempExcelBuffer.WriteSheet('Contract overview report PxQ', COMPANYNAME, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename('Contract Overview Report PxQ');
        TempExcelBuffer.OpenExcel();
        // BC Upgrade KUMARS145 Replaced with New Function...<<
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ValidFrom: Date;
        ValidTo: Date;
}

