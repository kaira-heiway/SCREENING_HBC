namespace BC_DTWLocal.BC_DTWLocal;

using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Setup;
using Microsoft.Inventory.Posting;

pageextension 54049 RevaluationJournalExtDTW extends "Revaluation Journal"
{//BC Upgrade Kamnay01 Created this page extension to add the code in posting action moved from general ext to dtw ext for validating the revaluation journal entries based on inventory setup. This is required for FDD-DTW 0031 
    actions
    {
        modify("P&ost")
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
            ToolTipML = ENU = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.', FRA = 'Finalisez le document ou la feuille en validant les montants et les quantités sur les comptes concernés dans la comptabilité de la société.';
            trigger OnBeforeAction()
            var
                InventorySetupL: Record "Inventory Setup";
                RevJnlErrorLogL: Record "Revaluation Jrnl Error Log FND";
                Cu23: Codeunit "Item Jnl.-Post Batch _DTW";
            Begin
                //HEI.01>>
                IF InventorySetupL.GET() THEN BEGIN
                    IF InventorySetupL."Activate Rev.Jnl.Error Log FND" THEN BEGIN
                        CLEARLASTERROR();
                        RevJnlErrorLogL.DELETEALL(FALSE);
                        Cu23.ValidateRevJnlError(Rec);// BC Upgrade Priya << Created function in 53499 codeunit.
                    end;
                end;
            end;
            //HEI.01<<
        }


    }
}
