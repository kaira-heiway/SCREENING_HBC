namespace MTC.MTC;
using Microsoft.Sales.History;
using System.Threading;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;

codeunit 53002 "Auto Sales Invoice & CM Post"
{
    // HEI.01 CHG2010375 IBM.LS 22.01.2020
    //   # New Codeunit created and code added to automate Sales Invoice and Credit Memo process by Job Queue.

    // BC Upgrade SHUKLP03 >> Nav old id - 50110
    // BC Upgrade SHUKLP03 >> OTC008 Testscript changes.

    trigger OnRun()
    var
        SalesReceivablesSetupL: Record "Sales & Receivables Setup";
        JobQueueEntryL: Record "Job Queue Entry";
        SalesInvoiceHeaderL: Record "Sales Invoice Header";
        SalesCrMemoHeaderL: Record "Sales Cr.Memo Header";
        SalesHeaderL: Record "Sales Header";
        SalesPostviaJobQueueL: Codeunit "Sales Post via Job Queue";
    begin
        //HEI.01>>
        SalesReceivablesSetupL.GET();
        SalesReceivablesSetupL.TESTFIELD("Enable OTC Billing Auto. FND", TRUE);
        IF SalesReceivablesSetupL."Enable OTC Billing Auto. FND" THEN BEGIN
            SalesReceivablesSetupL.TESTFIELD("Post with Job Queue", FALSE);
            SalesHeaderL.SETFILTER("Document Type", '%1|%2', SalesHeaderL."Document Type"::Order,
                                    SalesHeaderL."Document Type"::"Return Order");
            SalesHeaderL.SETRANGE(Status, SalesHeaderL.Status::Released);
            //SalesHeaderL.SETRANGE("Shipment status", SalesHeaderL."Shipment status"::Invoice);  // BC Upgrade SHUKLP03 << Blocked because DIT field "Shipment status".
            SalesHeaderL.SetFilter(SalesHeaderL."Logistic Status 107FDW", '%1|%2', 'TO INVOICE', 'INVOICE');  // BC Upgrade SHUKLP03 << OTC008 Testscript changes.
            SalesHeaderL.SETRANGE("Job Queue Status", SalesHeaderL."Job Queue Status"::" ");
            IF SalesHeaderL.FIND('-') THEN begin
                REPEAT
                    CLEAR(SalesPostviaJobQueueL);
                    SalesHeaderL.Invoice := TRUE;
                    CASE SalesHeaderL."Send Document FND" OF
                        SalesHeaderL."Send Document FND"::" ":
                            SalesHeaderL."Print Posted Documents" := FALSE;

                        SalesHeaderL."Send Document FND"::Mail:
                            SalesHeaderL."Print Posted Documents" := FALSE;

                        SalesHeaderL."Send Document FND"::Print:
                            SalesHeaderL."Print Posted Documents" := TRUE;

                        SalesHeaderL."Send Document FND"::"Mail & Print":
                            SalesHeaderL."Print Posted Documents" := TRUE;
                    end;
                    SalesPostviaJobQueueL.EnqueueSalesDoc(SalesHeaderL);
                UNTIL SalesHeaderL.NEXT() = 0;
            END;
        END;
        //HEI.01<<
    end;

}
