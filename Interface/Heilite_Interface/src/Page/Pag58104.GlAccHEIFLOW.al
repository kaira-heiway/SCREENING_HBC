page 58104 GlAcc_HEIFLOW
{
    // version HEI.01

    // HEI.01 CHG2132929 IBM POENAB02 18.03.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50274

    Editable = false;
    PageType = List;
    SourceTable = "G/L Account";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identification number of the general ledger account.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the general ledger account.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the search name for the general ledger account.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the general ledger account.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first global dimension code for the general ledger account.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the second global dimension code for the general ledger account.';
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the account category for the general ledger account.';
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general ledger account is an income statement account or a balance sheet account.';
                }
                field("Debit/Credit"; Rec."Debit/Credit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general ledger account is normally a debit or credit account.';
                }
                field("No. 2"; Rec."No. 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the secondary identification number of the general ledger account.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies additional information about the general ledger account.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general ledger account is blocked for posting.';
                }
                field("Direct Posting"; Rec."Direct Posting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether direct posting is allowed to the general ledger account.';
                }
                field("Reconciliation Account"; Rec."Reconciliation Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general ledger account is a reconciliation account.';
                }
                field("New Page"; Rec."New Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether a new page should be started after this general ledger account in reports.';
                }
                field("No. of Blank Lines"; Rec."No. of Blank Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of blank lines to insert after this general ledger account in reports.';
                }
                field(Indentation; Rec.Indentation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the indentation level for the general ledger account in reports.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the general ledger account was last modified.';
                }
                // BC Upgrade POENAB02 >>
                // Fields not available in web client
                /* 
                field("Date Filter"; Rec."Date Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date filter for viewing transactions related to the general ledger account.';
                }
                field("Global Dimension 1 Filter"; Rec."Global Dimension 1 Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first global dimension filter for viewing transactions related to the general
                }
                field("Global Dimension 2 Filter"; Rec."Global Dimension 2 Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the second global dimension filter for viewing transactions related to the general
                } 
                */
                // BC Upgrade POENAB02 <<
                field("Balance at Date"; Rec."Balance at Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the balance of the general ledger account at a specific date.';
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the net change in the balance of the general ledger account over a specific period.';
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budgeted amount for the general ledger account.';
                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether totaling is enabled for the general ledger account in reports.';
                }
                // BC Upgrade POENAB02 >>
                // Fields not available in web client
                /*                 
                field("Budget Filter"; Rec."Budget Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budget filter for viewing budgeted amounts related to the general ledger account.';
                }
                */
                // BC Upgrade POENAB02 <<
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current balance of the general ledger account.';
                }
                field("Budget at Date"; Rec."Budget at Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budgeted amount for the general ledger account at a specific date.';
                }
                field("Consol. Translation Method"; Rec."Consol. Translation Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the consolidation translation method for the general ledger account.';
                }
                field("Consol. Debit Acc."; Rec."Consol. Debit Acc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the consolidation debit account for the general ledger account.';
                }
                field("Consol. Credit Acc."; Rec."Consol. Credit Acc.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the consolidation credit account for the general ledger account.';
                }
                // BC Upgrade POENAB02 >>
                // Fields not available in web client
                /*                 
                field("Business Unit Filter"; Rec."Business Unit Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the business unit filter for viewing transactions related to the general ledger account.';
                }
                */
                // BC Upgrade POENAB02 <<
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general posting type for the general ledger account.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general business posting group for the general ledger account.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general product posting group for the general ledger account.';
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the picture associated with the general ledger account.';
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the debit amount for the general ledger account.';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the credit amount for the general ledger account.';
                }
                field("Automatic Ext. Texts"; Rec."Automatic Ext. Texts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether automatic external texts are enabled for the general ledger account.';
                }
                field("Budgeted Debit Amount"; Rec."Budgeted Debit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budgeted debit amount for the general ledger account.';
                }
                field("Budgeted Credit Amount"; Rec."Budgeted Credit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the budgeted credit amount for the general ledger account.';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax area code for the general ledger account.';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general ledger account is liable for tax.';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the tax group code for the general ledger account.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT business posting group for the general ledger account.';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT product posting group for the general ledger account.';
                }
                field("Additional-Currency Net Change"; Rec."Additional-Currency Net Change")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the net change in additional currency for the general ledger account over a specific period.';
                }
                field("Add.-Currency Balance at Date"; Rec."Add.-Currency Balance at Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the balance in additional currency for the general ledger account at a specific date.';
                }
                field("Additional-Currency Balance"; Rec."Additional-Currency Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current balance in additional currency for the general ledger account.';
                }
                field("Exchange Rate Adjustment"; Rec."Exchange Rate Adjustment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the exchange rate adjustment amount for the general ledger account.';
                }
                field("Add.-Currency Debit Amount"; Rec."Add.-Currency Debit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the debit amount in additional currency for the general ledger account.';
                }
                field("Add.-Currency Credit Amount"; Rec."Add.-Currency Credit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the credit amount in additional currency for the general ledger account.';
                }
                field("Default IC Partner G/L Acc. No"; Rec."Default IC Partner G/L Acc. No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default intercompany partner general ledger account number.';
                }
                field("Omit Default Descr. in Jnl."; Rec."Omit Default Descr. in Jnl.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to omit the default description in the journal.';
                }
                field("Account Subcategory Entry No."; Rec."Account Subcategory Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number of the account subcategory for the general ledger account.';
                }
                field("Account Subcategory Descript."; Rec."Account Subcategory Descript.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the account subcategory for the general ledger account.';
                }
                field("Cost Type No."; Rec."Cost Type No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost type number associated with the general ledger account.';
                }
                field("Default Deferral Template Code"; Rec."Default Deferral Template Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the default deferral template code for the general ledger account.';
                }
                // BC Upgrade POENAB02 >>
                // Fields not available in web client
                /* 
                field("G/L Entry Type Filter"; Rec."G/L Entry Type Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general ledger entry type filter for viewing transactions related to the general ledger account.';
                }
                */
                // BC Upgrade POENAB02 <<
                field("Temp Description"; Rec."Temp Description FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a temporary description for the general ledger account.';
                }
                field("Test Description"; Rec."Test Description FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a test description for the general ledger account.';
                }
                field("Std. Invoice Reference"; Rec."Std. Invoice Reference FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the standard invoice reference for the general ledger account.';
                }
                field("HeiMatch Code"; Rec."HeiMatch Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the HeiMatch code for the general ledger account.';
                }
                field("Automatic application mode"; Rec."Automatic application mode FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the automatic application mode for the general ledger account.';
                }
                field("Authorize other App. Modes"; Rec."Authorize other App. Modes FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to authorize other application modes for the general ledger account.';
                }
                field("Same Amount"; Rec."Same Amount FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the same amount is applied for the general ledger account.';
                }
                field("Same Remaining Amount"; Rec."Same Remaining Amount FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the same remaining amount is applied for the general ledger account.';
                }
                field("Same Document No."; Rec."Same Document No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the same document number is used for the general ledger account.';
                }
                field("Same External Document No."; Rec."Same External Document No. FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the same external document number is used for the general ledger account.';
                }
                field("Export HeiMatch Payments"; Rec."Export HeiMatch Payments FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to export HeiMatch payments for the general ledger account.';
                }
                field("CIL account"; Rec."CIL account FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general ledger account is a CIL account.';
                }
                field("Local Name"; Rec."Local Name FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the local name for the general ledger account.';
                }
                field("No Trading Partner"; Rec."No Trading Partner FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether there is no trading partner associated with the general ledger account.';
                }
                field("Posting Heineken"; Rec."Posting Heineken FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the posting is for Heineken.';
                }
                field("CIL3 Code"; Rec."CIL3 Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the CIL3 code for the general ledger account.';
                }
                field("MR Code"; Rec."MR Code FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the MR code for the general ledger account.';
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the WHT business posting group for the general ledger account.';
                }
                field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the WHT product posting group for the general ledger account.';
                }
                field("Cadency Transaction Export"; Rec."Cadency Transaction Export FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to export Cadency transactions for the general ledger account.';
                }
                field("Cadency Bank Export"; Rec."Cadency Bank Export FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to export Cadency bank data for the general ledger account.';
                }
                field("Financial Statement version"; Rec."Financial Stmt version FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the financial statement version for the general ledger account.';
                }
                field("Heimatch Sign"; Rec."Heimatch Sign FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Heimatch sign for the general ledger account.';
                }
                field("Acc Type"; Rec."Acc Type FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the account type for the general ledger account.';
                }
                field("VAT Account"; Rec."VAT Account FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT account for the general ledger account.';
                }
                field("WHT Account"; Rec."WHT Account FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the WHT account for the general ledger account.';
                }
                field("Non Deductible VAT %"; Rec."Non Deductible VAT % FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the percentage of non-deductible VAT for the general ledger account.';
                }
                field("Same Comment"; Rec."Same Comment FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the same comment is applied for the general ledger account.';
                }
                // BC Upgrade POENAB02 >>
                // Fields not available in web client
                /* 
                field("Maision des Vins Dim. Filter"; Rec."Maision des Vins Dim. Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Maison des Vins dimension filter for viewing transactions related to the general ledger account.';
                }
                */
                // BC Upgrade POENAB02 <<
                field("C&TP CODE"; Rec."C&TP CODE FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the C&TP code for the general ledger account.';
                }
                // BC Upgrade POENAB02 >>
                // fields are part of Aptead developments
                /*
                field("DIT Sub-Contract Posting Type"; Rec."DIT Sub-Contract Posting Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the DIT sub-contract posting type for the general ledger account.';
                }
                field(Collapse; Rec.Collapse)
                {
                    Caption = 'Collapse';
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general ledger account is collapsed in the user interface.';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Caption = 'Allow Invoice Discounts';
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether invoice discounts are allowed for the general ledger account.';
                }
                field("Auto. Acc. Group"; Rec."Auto. Acc. Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the automatic account group for the general ledger account.';
                }
                field("Shortcut Property 1 Code"; Rec."Shortcut Property 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 1 code for the general ledger account.';
                }
                field("Shortcut Property 2 Code"; Rec."Shortcut Property 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 2 code for the general ledger account.';
                }
                field("Shortcut Property 3 Code"; Rec."Shortcut Property 3 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 3 code for the general ledger account.';
                }
                field("Shortcut Property 4 Code"; Rec."Shortcut Property 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 4 code for the general ledger account.';
                }
                field("Shortcut Property 5 Code"; Rec."Shortcut Property 5 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 5 code for the general ledger account.';
                }
                field("Shortcut Property 6 Code"; Rec."Shortcut Property 6 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 6 code for the general ledger account.';
                }
                field("Shortcut Property 7 Code"; Rec."Shortcut Property 7 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 7 code for the general ledger account.';
                }
                field("Shortcut Property 8 Code"; Rec."Shortcut Property 8 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 8 code for the general ledger account.';
                }
                field("Shortcut Property 9 Code"; Rec."Shortcut Property 9 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 9 code for the general ledger account.';
                }
                field("Shortcut Property 10 Code"; Rec."Shortcut Property 10 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shortcut property 10 code for the general ledger account.';
                }
                field("DIT Sub-Contract Type Filter"; Rec."DIT Sub-Contract Type Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the DIT sub-contract type filter for viewing transactions related to the general ledger account.';
                }
                field("Service Contract No. Filter"; Rec."Service Contract No. Filter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the service contract number filter for viewing transactions related to the general ledger account.';
                }
                */
                // BC Upgrade POENAB02 <<
            }
        }
    }

    actions
    {
    }
}

