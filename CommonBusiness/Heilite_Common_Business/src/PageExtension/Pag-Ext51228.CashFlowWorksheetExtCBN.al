// BC upgrade MISHRS14 >>
// Added namespace to rmeove warning in using line
namespace Heineken;
using Microsoft.CashFlow.Worksheet;
// BC upgrade MISHRS14 <<

// BC Upgrade POENAB02, 26.02.2026, gap/fit "RTR104-Creation of Cash Flow per LE" and "RTR140-Cash forecast preparation"

pageextension 51228 CashFlowWorksheetExtCBN extends "Cash Flow Worksheet"
{
    actions
    {
        modify(SuggestWorksheetLines)
        {
            Visible = false;
            Enabled = false;
        }
        addafter(SuggestWorksheetLines)
        {
            action(SuggestWorksheetLinesExt)
            {
                ApplicationArea = All;
                Caption = '&Suggest Worksheet Lines (Extended)';
                Ellipsis = true;
                Image = Import;
                ShortCutKey = 'Shift+Ctrl+F';
                ToolTip = 'Transfer information from the areas of general ledger, purchasing, sales, service, fixed assets, manual revenues, and manual expenses to the cash flow worksheet. You use the batch job to make a cash flow forecast.';
                trigger OnAction()
                var
                    SuggestWkshLines2: Report SuggestWorksheetLinesHeiLite;
                begin
                    DeleteErrors();
                    SuggestWkshLines2.RunModal();
                    Clear(SuggestWkshLines2);
                end;
            }
        }
    }
}