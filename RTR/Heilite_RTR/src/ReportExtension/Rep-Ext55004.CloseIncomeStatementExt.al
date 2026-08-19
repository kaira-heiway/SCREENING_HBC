
reportextension 55004 CloseIncomeStatementExt extends "Close Income Statement"
{
    //BC Upgrade KAPOOV01 BCUP0-151 16.07.2026 # Added RequestFilterFields for DataItem -"G/L Account".

    dataset
    {
        modify("G/L Account")
        {
            RequestFilterFields = "No.", "Financial Stmt version FND";
        }
    }
}
