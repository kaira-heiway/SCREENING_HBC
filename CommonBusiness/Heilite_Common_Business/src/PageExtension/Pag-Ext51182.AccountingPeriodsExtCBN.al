namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Foundation.Period;

pageextension 51182 AccountingPeriodsExtCBN extends "Accounting Periods"
{
    //     HEI.01 FDD-HT667 IBM SURYAS01 12-07-2019
    //   #New Field added:"Final Reporting Extracted"
    // HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Added fields "Fiscally Closed", "Fiscal Closing Date", "Period Reopened Date"
    //   # Added action group "F&iscal Closing", with action "<Codeunit Fiscal Year-FiscalClos", "CloseFiscalPeriod", "ReopenFiscalPeriod"


    // BC Upgrade SHUKLP03 >>
    //     "Page extension is not found in the TEXT2AL folder.
    // Trigger OnOpenPage()  code is  for french localization, that is why not added.
    // action group ""F&iscal Closing"", with action ""<Codeunit Fiscal Year-FiscalClos"", ""CloseFiscalPeriod"", ""ReopenFiscalPeriod"" are not added because code is for  for french localization."
    // BC Upgrade SHUKLP03 <<

    //Bc Upgrade YADAVM09 Drink it field blocked-Fiscally Closed,Fiscal Closing Date,Period Reopened Date.

    layout
    {
        addafter("Average Cost Calc. Type")
        {
            field("Final Reporting Extracted"; Rec."Final Reporting Extracted FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Final Reporting Extracted field.';
            }
            /* //Bc Upgrade YADAVM09 Drink it field commented>>
           field("Fiscally Closed"; Rec."Fiscally Closed")
           {
               ApplicationArea = ALL;
           }
           field("Fiscal Closing Date"; Rec."Fiscal Closing Date")
           {
               ApplicationArea = ALL;
           }
           field("Period Reopened Date"; Rec."Period Reopened Date")
           {
               ApplicationArea = ALL;
           }
           */ //Bc Upgrade YADAVM09 Drink it field commented<<
        }
    }


}
