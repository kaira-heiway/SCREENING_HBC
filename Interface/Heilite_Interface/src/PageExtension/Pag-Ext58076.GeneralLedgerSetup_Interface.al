namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Finance.GeneralLedger.Setup;

pageextension 58076 GeneralLedgerSetupExt_Interfac extends "General Ledger Setup"
{
    // BC upgrade SHUKLP03 >>
    // HEI.05 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # New group: Local functionalities
    //   # New fields for MDM integration: WHT Minimum Invoice Amount, Manual Sales WHT Calc., Enable WHT, Round Amount for WHT Calc, Min. WHT Calc only on Inv. Amt
    //     added in group "Local Functionalities"
    // HEI.10 FDD-CHG2022328 IBM POENAB02 07.07.2019 # External document No. duplication in journal
    //   #New field added: "Restrt Duplicate Extrnl Doc" in "Local Functionalities" group
    // HEI.28 CHG2232991 IBM POENAB02 12.03.2024 HB3713_Limitation on the reverse action in table “create document shipping cost”
    //   # New field added - 50076 "Posted Document Shipping Limit" in "Local Functionalities" group
    // HEI.01 FDD-GAPID001 IBM LAZARE02 20.06.2017 # New action on General tab in the ribbon to open Outbound Interface Setup
    // BC upgrade SHUKLP03 <<

    // BC upgrade SHUKLP03 >> Blocked WHT fields as not in scope for BC upgrade.

    layout
    {
        addafter("Payroll Transaction Import")
        {
            group("Local Functionalities")
            {
                Caption = 'Local Functionalities';
                field("WHT Minimum Invoice Amount"; Rec."WHT Minimum Invoice Amount FND")
                {
                    ApplicationArea = All;
                }
                field("Manual Sales WHT Calc."; Rec."Manual Sales WHT Calc. FND")
                {
                    ApplicationArea = All;
                }
                field("Enable WHT"; Rec."Enable WHT FND")
                {
                    ApplicationArea = All;
                }
                field("Apply Compensation"; Rec."Apply Compensation FND")
                {
                    ApplicationArea = All;
                }
                // field("Round Amount for WHT Calc"; Rec."Round Amount for WHT Calc")
                // {
                //     ApplicationArea = All;
                // }
                // field("Min. WHT Calc only on Inv. Amt"; Rec."Min. WHT Calc only on Inv. Amt")
                // {
                //     ApplicationArea = All;
                // }
                field("Enable TIN By Location"; Rec."Enable TIN By Location FND")
                {
                    ApplicationArea = All;
                    Caption = 'Enable TIN By Location';
                    Description = 'HEI.09';
                }
                field("Restrt Duplicate Extrnl Doc"; Rec."Restrt Dupli Extrnl Doc FND")
                {
                    ApplicationArea = All;
                }
                field("WIP Accrual. Mat. Perc."; Rec."WIP Accrual. Mat. Perc. FND")
                {
                    ApplicationArea = All;
                }
                field("WIP Accrual. Cap. Perc."; Rec."WIP Accrual. Cap. Perc. FND")
                {
                    ApplicationArea = All;
                }
                field("WIP Output Zone Filtering"; Rec."WIP Output Zone Filtering FND")
                {
                    ApplicationArea = All;
                }
                field("Enable CAD"; Rec."Enable CAD FND")
                {
                    ApplicationArea = All;
                }
                field("Posted Document Shipping Limit"; Rec."Posted Doc Shipping Limit FND")
                {
                    ApplicationArea = All;

                }
            }
        }

    }

    actions
    {
        addafter("Bank Export/Import Setup")
        {
            action("Interface Setup")
            {
                ApplicationArea = ALL;
                Caption = 'Interface Setup';
                Image = ImportExport;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Interface Setup";
            }
        }
    }

}
