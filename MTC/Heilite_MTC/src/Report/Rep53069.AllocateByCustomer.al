report 53069 "Allocate by Customer"
{
    //BC Upgrade Old ID-50062
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry Type", Nonstock, "Item No.", "Posting Date") WHERE("Entry Type" = FILTER(Sale));
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord();
            var
                DimSetEntry: Record "Dimension Set Entry";
            begin
                if ("Source Type" = "Source Type"::Customer) and ("Source No." <> '') then begin
                    SalesBuffer.SETRANGE("Dimension Level 1 Code", "Source No.");
                    if not SalesBuffer.FINDFIRST then begin
                        SalesBuffer."Dimension Level 1 Code" := "Source No.";
                        //SalesBuffer."Sold Amt" := -"Item Ledger Entry"."Quantity in HL";
                        SalesBuffer."Sold Amt" := -"Item Ledger Entry".Quantity;
                        SalesBuffer.INSERT;
                    end else begin
                        //SalesBuffer."Sold Amt" += -"Item Ledger Entry"."Quantity in HL";
                        SalesBuffer."Sold Amt" += -"Item Ledger Entry".Quantity;
                        SalesBuffer.MODIFY;
                    end;
                end;
            end;

            trigger OnPostDataItem();
            var
                CostAllocationTarget: Record "Cost Allocation Target";
                LineNo: Integer;
            begin
                CostAllocationTarget.SETRANGE(ID, DocNo);
                CostAllocationTarget.DELETEALL(true);
                CLEAR(SalesBuffer);
                if SalesBuffer.FINDFIRST then
                    repeat
                        LineNo += 10000;
                        CLEAR(CostAllocationTarget);
                        CostAllocationTarget.VALIDATE(ID, DocNo);
                        CostAllocationTarget.VALIDATE("Line No.", LineNo);
                        //CostAllocationTarget.VALIDATE("Target Cost Center",SalesBuffer."Dimension Level 2 Code");
                        CostAllocationTarget.VALIDATE("Target Cost Center", SalesBuffer."Dimension Level 1 Code");
                        CostAllocationTarget.VALIDATE("Allocation Target Type", CostAllocationTarget."Allocation Target Type"::"All Costs");
                        CostAllocationTarget.VALIDATE(Base, CostAllocationTarget.Base::Static);
                        CostAllocationTarget.INSERT(true);
                        CostAllocationTarget.VALIDATE(Share, SalesBuffer."Sold Amt");
                        CostAllocationTarget.MODIFY(true);
                    until SalesBuffer.NEXT = 0;
            end;

            trigger OnPreDataItem();
            begin
                GLSetup.GET;
                GLSetup.TESTFIELD("SKU Dimension Code FND");
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

    var
        SalesBuffer: Record "Brand Dim Hierarchy FND" temporary;
        GLSetup: Record "General Ledger Setup";
        TotalHL: Decimal;
        DocNo: Code[20];

    procedure SetDocNo(FromDocNo: Code[10]);
    begin
        DocNo := FromDocNo;
    end;
}

