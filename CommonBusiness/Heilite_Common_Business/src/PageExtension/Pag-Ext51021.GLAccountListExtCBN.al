pageextension 51021 GLAccountListExtCBN extends "G/L Account List"
{
    // DITW15.00.00.01 DDR 22/01/2008 Added Drink-it functionnalities
    //                                Added field "Collapse"
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW16.00.00.41 AHU 31/08/2012 DIT-715 #327 Added fields "DIT Sub-Contract Posting Type"

    // FINXL7.00.001 RBE 20/03/2013 : Added field "No. 2" and "Search Name" on page

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // FINXL9.00.001 DAT 07/03/2016 : Extend Master Property functionalities
    // DITW18.00.07 AKH 22/03/2016 DIT-770 #1805 Merge FINXL extended master data properties

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // FINXL9.00.000.01 KSW 27/09/2016: release Hotfix 1
    // HEI.01 FDD-SLSGAP001 IBM POENAB01 19.08.2017 # MDM Customer Card
    //   # added "WHT Business Posting Group" and "WHT Product Posting Group"
    // HEI.02 RTRGAP070 IBM LAZARE02 14.05.2018
    //   # added field Financial Stement Version
    // HEI.03 FDD-HT670 IBM BULIMC01 30.09.2019 #new field "VAT Account" displayed
    // HEI.04 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New fields: "Debit Amount", "Credit Amount"
    //   # Code added in OnOpenPage()
    // HEI.05 FDD-HT671 IBM BULIMC01 08.10.2019 #new field "WHT Account" displayed

    layout
    {
        addafter("Reconciliation Account")
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
            {
                ApplicationArea = all;
                Caption = 'WHT Business Posting Group';
                ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
            }
            field("WHT Product Posting Group"; Rec."WHT Product Posting Group FND")
            {
                ApplicationArea = all;
                Caption = 'WHT Product Posting Group';
                ToolTip = 'Specifies the value of the WHT Product Posting Group field.';
            }
            field("Financial Statement version"; Rec."Financial Stmt version FND")
            {
                ApplicationArea = all;
                Caption = 'Financial Statement version';
                ToolTip = 'Specifies the value of the Financial Statement version field.';

            }
            field("VAT Account"; Rec."VAT Account FND")
            {
                ApplicationArea = all;
                Caption = 'VAT Account';
                ToolTip = 'Specifies the value of the VAT Account field.';
            }
            field("WHT Account"; Rec."WHT Account FND")
            {
                ApplicationArea = all;
                Caption = 'WHT Account';
                ToolTip = 'Specifies the value of the WHT Account field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
    begin
        //SHARMP16>>
        //HEI.04>>
        // CompanyInfo.GET;
        // IF CompanyInfo."Enable French Localization" THEN
        //     SETRANGE("G/L Entry Type Filter", "G/L Entry Type Filter"::Definitive);
        //HEI.04<<
        //SHARMP16<<

    end;

    var
        CompanyInfo: Record "Company Information";
}