pageextension 51211 GeneralPostingSetuplistExtCBN extends "General Posting Setup"
{
    //     DITW15.00.00.01 DDR 27/12/2007 Added fields Drink-it Item Charges functionnalities
    // DITW15.00.00.01 DDR 23/01/2008 Added fields Drink-it Discount Item Charges functionnalities
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.24 DDR 25/09/2008 Drink-it Internal Taxes functionnalities
    //                                Added fields "Internal Tax Due Account","Internal Tax Recover Account"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 SFI 30/08/2017 BL#14417 New fields
    //                                 2013610 "Deposit In Goods Sold Acc."
    //                                 2013611 "Dep. In Goods Sold Acc. (Int)"
    //                                 2013612 "Direct Deposit Applied Account"
    //                                 2013613 "Deposit Accrual Acc. (Int.)"
    //                                 2013614 "Deposit Adjustment Acc."
    // HEI.01 FDD-HB446 CHG2023340 IBM SURYAS01 05.09.2019
    //   #Added New field - "Accrual Acc. (Interim)"
    // HEI.02 FDD-HT581 SURYAS01 IBM 30.09.2019
    //   #Added New field "VAT on Free Expense Account"
    // HEI.03 FDD-HB1609 CHG2074002 IBM BULIMC01 26.08.2020
    //   # new fields added: "Cost of Free Goods (HNK)", "HNK Free Goods Offset Acc."
    // HEI.04 FDD-HB899 - CHG2093015 IBM NASTAA02  19.01.2021 # LSR - Sales And Payments
    //   # New Field added: "Sales Resource Cost Acc."
    // HEI.05 CHG2119679 IBM BHATTA09  08.09.2021
    //   # New Field Added: Accrual Account Landed Cost
    // HEI.06 CHG2193490 IBM SISUM01 21/07/2023 HB3383_Devlopment PPV Allocation By Batch or Document Number
    //   # Add the field PPV Adjustment Account

    //Bc Upgrade YADAVM09 New page extension created for General Posting Setup list

    layout
    {
        addafter("Gen. Prod. Posting Group")
        {
            field("Accrual Acc. (Interim)"; rec."Accrual Acc. (Interim) FND")
            {
                ApplicationArea = All;
                ToolTip = 'used for Accural Account interim';
            }
        }

        addafter("Direct Cost Applied Account")
        {
            field("VAT on Free Expense Account"; rec."VAT on Free Expense Acc. FND")
            {
                ApplicationArea = All;
            }

            field("Cost of Free Goods (HNK)"; rec."Cost of Free Goods (HNK) FND")
            {
                ApplicationArea = All;
            }
            field("HNK Free Goods Offset Acc."; rec."HNK Free Goods Offset Acc. FND")
            {
                ApplicationArea = All;
            }
            field("Accrual Account Landed Cost"; rec."Accrual Acc. Landed Cost FND")
            {
                ApplicationArea = All;
            }
            field("PPV Adjustment Account"; rec."PPV Adjustment Account FND")
            {
                ApplicationArea = All;
            }
            field("Sales Resource Cost Acc."; rec."Sales Resource Cost Acc. FND")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}