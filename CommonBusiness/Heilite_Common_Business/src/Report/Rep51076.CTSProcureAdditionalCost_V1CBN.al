report 51076 "CTS Procure Add Cost V1 CBN"
{
    // HEI.01 FDD- HB1421 CHG2065545 IBM SHANKJ03 10.09.2020
    //   # New action button added Additional costs for FA

    ProcessingOnly = true;
    ApplicationArea = all;
    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                //HEI.01 >>
                LineNo := 0;
                RecCount := 0;
                SplitAmt := 0;
                RecCount := "Fixed Asset".COUNT;
                SplitAmt := TotalAmount / RecCount;
                FixedAssetRec.RESET();
                FixedAssetRec.COPY("Fixed Asset");

                PurchLineRec.RESET();
                PurchLineRec.SETRANGE("Document No.", PurchOrdGlb);
                if PurchLineRec.FINDLAST() then
                    LineNo := PurchLineRec."Line No." + 10000
                else
                    LineNo := 10000;

                PurchLineInsRec.INIT();
                PurchLineInsRec."Document Type" := PurchLineInsRec."Document Type"::Order;
                PurchLineInsRec."Document No." := PurchOrdGlb;
                PurchLineInsRec."Line No." := LineNo;
                //      PurchLineInsRec."Has Item Charge" := false;//BC Upgrade SHARMP16-- Drink-It field
                PurchLineInsRec.Type := PurchLineInsRec.Type::"Fixed Asset";
                PurchLineInsRec.VALIDATE("No.", "Fixed Asset"."No.");
                PurchLineInsRec.VALIDATE(Quantity, 1);
                PurchLineInsRec.VALIDATE("Direct Unit Cost", SplitAmt);
                PurchLineInsRec.INSERT(true);
                //HEI.01 <<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control55001)
                {
                    ShowCaption = false;
                    field("Total Amount"; TotalAmount)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the TotalAmount field.';
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

    trigger OnPreReport();
    begin
        Selection := STRMENU(Text000, 2)//HEI.01
    end;

    var
        FixedAssetRec: Record "Fixed Asset";
        PurchLineInsRec: Record "Purchase Line";
        PurchLineRec: Record "Purchase Line";
        PurchOrdGlb: Code[20];
        SplitAmt: Decimal;
        TotalAmount: Decimal;
        LineNo: Integer;
        RecCount: Integer;
        Selection: Integer;
        Text000: Label 'Equally';

    procedure SavePurchOrder(PurchOrdNo: Code[20]);
    begin
        PurchOrdGlb := PurchOrdNo//HEI.01
    end;
}

