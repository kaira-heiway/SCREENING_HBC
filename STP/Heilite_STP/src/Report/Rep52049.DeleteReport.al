namespace STPLocal.STPLocal;
using System.Utilities;
using Microsoft.Purchases.Document;

report 52049 DeleteReport
{
    // HEI.01 CHG2326201 IBM SHARMP16 02.01.2026 Delete the POs that are available in Purchase lines but not in the PO header
    //   # New report created report: 50653

    // BC Upgrade PATELS08 >>
    // Nav Object ID : 50653
    // BC Upgrade PATELS08 <<

    ApplicationArea = All;
    Caption = 'DeleteReport';
    UsageCategory = Tasks;

    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = const(1));

            trigger OnPostDataItem()
            begin
                DeleteOrphanPurchLines();
            end;
        }
    }

    var
        DeleteQuery: Query DeletePurchLine;
        DeletedCount: Integer;
        PurchLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        DocNoFilter: Text;
        DocNo: Text;
        DeleteLines: Boolean;
        Txt001 : Label 'Total Lines Deleted %1';


    procedure DeleteOrphanPurchLines()
    begin
        DeletedCount := 0;

        IF DocNoFilter <> '' THEN
            DeleteQuery.SETFILTER(DeleteQuery.Doc_No_Filter, DocNoFilter);

        DeleteQuery.OPEN;
        WHILE DeleteQuery.READ DO BEGIN
            DocNo := DeleteQuery.Document_No;

            IF NOT PurchHeader.GET(PurchHeader."Document Type"::Order, DocNo) THEN BEGIN
                PurchLine.RESET;
                PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
                PurchLine.SETRANGE("Document No.", DocNo);

                IF PurchLine.FINDSET THEN BEGIN
                    DeletedCount += PurchLine.COUNT;

                    IF DeleteLines = TRUE THEN BEGIN
                        PurchLine.MODIFYALL("Maximo Requisition No. FND", '');
                        PurchLine.MODIFYALL("Maximo Requis. Line No. FND", 0);
                        PurchLine.MODIFYALL("SRM Contract No. FND", '');
                        PurchLine.MODIFYALL("SRM Contract Line No. FND", '');
                        PurchLine.DELETEALL(FALSE);
                    END;
                END;
            END;
        END;

        DeleteQuery.CLOSE;

        IF DeleteLines = FALSE THEN
            MESSAGE('%1', DeletedCount)
        ELSE
            MESSAGE(Txt001, DeletedCount);

    end;

}
