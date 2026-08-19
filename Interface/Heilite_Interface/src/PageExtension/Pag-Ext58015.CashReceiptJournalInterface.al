namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Sales.Document;
using Microsoft.Sales.Receivables;

pageextension 58015 CashReceiptJournalInterface extends "Cash Receipt Journal"
{
    // HEI.07 FDD-HB899 - CHG2093015 IBM NASTAA02  22.01.2021 # LSR - Sales And Payments
    //   # Code added on Page Actions "Post" and "Post & Print"
    //   # New functions created: "UpdateAPIInterfaceLog"

    actions
    {
        modify(Post)
        {
            // BC Upgrade SHUKLP03 >> OnAfterAction triggers.
            trigger OnAfterAction()
            var
            begin
                UpdateAPIInterfaceLog(); //HEI.07
            end;
            // BC Upgrade SHUKLP03 <<
        }
        modify("Post and &Print")
        {
            // BC Upgrade SHUKLP03 >> 
            trigger OnAfterAction()
            var
            begin
                UpdateAPIInterfaceLog(); //HEI.07
            end;
            // BC Upgrade SHUKLP03 << 
        }


    }
    local procedure UpdateAPIInterfaceLog();
    var
        APIInterfaceLog: Record "API Interface Log2 INT";
    begin
        //HEI.07>>
        ExternalDocNo := Rec."External Document No.";  // BC Upgrade SHUKLP03 << Added to store External Document No.
        //HEI.07<<

        //HEI.07>>
        if ExternalDocNo <> '' then begin
            APIInterfaceLog.SETRANGE("Message ID", ExternalDocNo);
            if APIInterfaceLog.FINDFIRST() then
                if APIInterfaceLog."Posting Status" = APIInterfaceLog."Posting Status"::Error then begin
                    APIInterfaceLog."Posting Status" := APIInterfaceLog."Posting Status"::Processed;
                    APIInterfaceLog.MODIFY();
                end;
        end;
        //HEI.07<<
    end;

    var
        ExternalDocNo: Code[35];
}
