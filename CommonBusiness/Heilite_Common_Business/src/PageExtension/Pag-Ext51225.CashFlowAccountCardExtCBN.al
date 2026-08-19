namespace RtR_Sandbox.RtR_Sandbox;

using Microsoft.CashFlow.Account;

// BC Upgrade POENAB02: Original (HeiLite) page id 862

pageextension 51225 CashFlowAccountCardExtCBN extends "Cash Flow Account Card"
{
    layout
    {
        addafter("G/L Account Filter")
        {
            field("Movement Type"; Rec."Movement Type FND")
            {
                ApplicationArea = All;
                ToolTip = 'Defines the movement type for the cash flow account. This field is used to determine how the cash flow account is used in cash flow forecasting and reporting.';
            }
        }
    }
}
