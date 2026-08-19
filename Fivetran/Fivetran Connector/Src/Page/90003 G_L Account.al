page 90003 "G/L Account"
{
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    EntityCaption = 'G/L Account';
    EntitySetCaption = 'G/L Accounts';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    EntityName = 'generalLedgerAccount';
    EntitySetName = 'generalLedgerAccounts';
    InsertAllowed = false;
    ModifyAllowed = false;
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = "G/L Account";
    DataAccessIntent = ReadOnly;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(apiAccountType; Rec."API Account Type")
                {
                    Caption = 'API Account Type';
                }
                //Bc Upgrade SAIA01 >>
                field(acc_type; Rec."Acc Type FND")
                {
                    Caption = 'Acc Type';
                }
                //Bc Upgrade SAIA01 <<
                field(accountCategory; Rec."Account Category")
                {
                    Caption = 'Account Category';
                }
                field(accountSubcategoryDescript; Rec."Account Subcategory Descript.")
                {
                    Caption = 'Account Subcategory Descript.';
                }
                field(accountSubcategoryEntryNo; Rec."Account Subcategory Entry No.")
                {
                    Caption = 'Account Subcategory Entry No.';
                }
                field(accountType; Rec."Account Type")
                {
                    Caption = 'Account Type';
                }
                field(addCurrencyBalanceAtDate; Rec."Add.-Currency Balance at Date")
                {
                    Caption = 'Add.-Currency Balance at Date';
                }
                field(addCurrencyCreditAmount; Rec."Add.-Currency Credit Amount")
                {
                    Caption = 'Add.-Currency Credit Amount';
                }
                field(addCurrencyDebitAmount; Rec."Add.-Currency Debit Amount")
                {
                    Caption = 'Add.-Currency Debit Amount';
                }
                field(additionalCurrencyBalance; Rec."Additional-Currency Balance")
                {
                    Caption = 'Additional-Currency Balance';
                }
                field(additionalCurrencyNetChange; Rec."Additional-Currency Net Change")
                {
                    Caption = 'Additional-Currency Net Change';
                }
                field(automaticExtTexts; Rec."Automatic Ext. Texts")
                {
                    Caption = 'Automatic Ext. Texts';
                }
                field(balance; Rec.Balance)
                {
                    Caption = 'Balance';
                }
                field(balanceAtDate; Rec."Balance at Date")
                {
                    Caption = 'Balance at Date';
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';
                }
                field(budgetAtDate; Rec."Budget at Date")
                {
                    Caption = 'Budget at Date';
                }
                field(budgetedAmount; Rec."Budgeted Amount")
                {
                    Caption = 'Budgeted Amount';
                }
                field(budgetedCreditAmount; Rec."Budgeted Credit Amount")
                {
                    Caption = 'Budgeted Credit Amount';
                }
                field(budgetedDebitAmount; Rec."Budgeted Debit Amount")
                {
                    Caption = 'Budgeted Debit Amount';
                }
                //Bc Upgrade SAIA01 >>
                field(cil3_code; Rec."CIL3 Code FND")
                {
                    Caption = 'CIL3 Code';
                }
                //Bc Upgrade SAIA01 <<
                field(comment; Rec.Comment)
                {
                    Caption = 'Comment';
                }
                field(consolCreditAcc; Rec."Consol. Credit Acc.")
                {
                    Caption = 'Consol. Credit Acc.';
                }
                field(consolDebitAcc; Rec."Consol. Debit Acc.")
                {
                    Caption = 'Consol. Debit Acc.';
                }
                field(consolTranslationMethod; Rec."Consol. Translation Method")
                {
                    Caption = 'Consol. Translation Method';
                }
                field(costTypeNo; Rec."Cost Type No.")
                {
                    Caption = 'Cost Type No.';
                }
                field(creditAmount; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                }
                field(debitAmount; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                }
                field(debitCredit; Rec."Debit/Credit")
                {
                    Caption = 'Debit/Credit';
                }
                field(defaultDeferralTemplateCode; Rec."Default Deferral Template Code")
                {
                    Caption = 'Default Deferral Template Code';
                }
                field(defaultICPartnerGLAccNo; Rec."Default IC Partner G/L Acc. No")
                {
                    Caption = 'Default IC Partner G/L Acc. No';
                }
                field(directPosting; Rec."Direct Posting")
                {
                    Caption = 'Direct Posting';
                }
                field(exchangeRateAdjustment; Rec."Exchange Rate Adjustment")
                {
                    Caption = 'Exchange Rate Adjustment';
                }
                //Bc Upgrade SAIA01 >>
                field(financial_statement_version; Rec."Financial Stmt version FND")
                {
                    Caption = 'Financial Stmt version';
                }
                //Bc Upgrade SAIA01 <<

                // field(gifiCode; Rec."GIFI Code")
                // {
                //     Caption = 'GIFI Code';
                // }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field(genPostingType; Rec."Gen. Posting Type")
                {
                    Caption = 'Gen. Posting Type';
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code';
                }
                //Bc Upgrade SAIA01 >>
                field(heimatch_code; Rec."HeiMatch Code FND")
                {
                    Caption = 'HeiMatch Code';
                }
                //Bc Upgrade SAIA01 <<
                field(incomeBalance; Rec."Income/Balance")
                {
                    Caption = 'Income/Balance';
                }
                field(indentation; Rec.Indentation)
                {
                    Caption = 'Indentation';
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                    Caption = 'Last Date Modified';
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                    Caption = 'Last Modified Date Time';
                }
                //Bc Upgrade SAIA01 >>
                field(local_name; Rec."Local Name FND")
                {
                    Caption = 'Local Name';
                }
                //Bc Upgrade SAIA01 <<
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(netChange; Rec."Net Change")
                {
                    Caption = 'Net Change';
                }
                field(newPage; Rec."New Page")
                {
                    Caption = 'New Page';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(no2; Rec."No. 2")
                {
                    Caption = 'No. 2';
                }
                field(noOfBlankLines; Rec."No. of Blank Lines")
                {
                    Caption = 'No. of Blank Lines';
                }
                //Bc Upgrade SAIA01 >>
                field(no_trading_partner; Rec."No Trading Partner FND")
                {
                    Caption = 'No Trading Partner';
                }
                //Bc Upgrade SAIA01 <<
                field(omitDefaultDescrInJnl; Rec."Omit Default Descr. in Jnl.")
                {
                    Caption = 'Omit Default Descr. in Jnl.';
                }
                field(picture; Rec.Picture)
                {
                    Caption = 'Picture';
                }
                //Bc Upgrade SAIA01 >>
                field(posting_heineken; Rec."Posting Heineken FND")
                {
                    Caption = 'Posting Heineken';
                }
                //Bc Upgrade SAIA01 <<
                field(reconciliationAccount; Rec."Reconciliation Account")
                {
                    Caption = 'Reconciliation Account';
                }
                // field(satAccountCode; Rec."SAT Account Code")
                // {
                //     Caption = 'SAT Account Code';
                // }
                field(searchName; Rec."Search Name")
                {
                    Caption = 'Search Name';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field(totaling; Rec.Totaling)
                {
                    Caption = 'Totaling';
                }
                field(vatAmt; Rec."VAT Amt.")
                {
                    Caption = 'VAT Amt.';
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field(budgetFilter; Rec."Budget Filter")
                {
                    Caption = 'Budget Filter';
                }
                field(businessUnitFilter; Rec."Business Unit Filter")
                {
                    Caption = 'Business Unit Filter';
                }
                field(dateFilter; Rec."Date Filter")
                {
                    Caption = 'Date Filter';
                }
                field(dimensionSetIDFilter; Rec."Dimension Set ID Filter")
                {
                    Caption = 'Dimension Set ID Filter';
                }
                field(globalDimension1Filter; Rec."Global Dimension 1 Filter")
                {
                    Caption = 'Global Dimension 1 Filter';
                }
                field(globalDimension2Filter; Rec."Global Dimension 2 Filter")
                {
                    Caption = 'Global Dimension 2 Filter';
                }
                field(vatReportingDateFilter; Rec."VAT Reporting Date Filter")
                {
                    Caption = 'VAT Reporting Date Filter';
                }
            }
        }
    }
}
