page 50126 "WHT Posting Setup List"
{
    // version HEI.01

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 22.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 CHG2057437 IBM POENAB02 28.04.2020 # FDD_HT1104_DRC_WHT functionality enhancement
    //   # New field: 26 "WHT Bearer"
    // HEI.03 FDD-HT2159 - CHG2105031 IBM NASTAA02 21.07.2021 # VAT Centime - Part 2 - Purchases
    //   # New Field added: "CAD Account"

    Caption = 'WHT Posting Setups';
    PageType = List;
    SourceTable = "WHT Posting Setup FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1500000)
            {
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a WHT Business Posting group code.',
                                ENA = 'Specifies a WHT Business Posting group code.';
                }
                field("WHT Product Posting Group"; Rec."WHT Product Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a WHT Product Posting group code.',
                                ENA = 'Specifies a WHT Product Posting group code.';
                }
                field("WHT Calculation Rule"; Rec."WHT Calculation Rule")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Contains the WHT calculation rule.',
                                ENA = 'Contains the WHT calculation rule.';
                }
                field("WHT Minimum Invoice Amount"; Rec."WHT Minimum Invoice Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Contains the threshold amount for WHT, below which there will not be any WHT deduction.',
                                ENA = 'Contains the threshold amount for WHT, below which there will not be any WHT deduction.';
                }
                field("WHT %"; Rec."WHT %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the relevant WHT rate for the particular combination of WHT Business Posting group and WHT Product Posting group.',
                                ENA = 'Specifies the relevant WHT rate for the particular combination of WHT Business Posting group and WHT Product Posting group.';
                }
                field("Realized WHT Type"; Rec."Realized WHT Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies how WHT is calculated for purchases or sales of items with this particular combination of WHT business and product posting groups.',
                                ENA = 'Specifies how WHT is calculated for purchases or sales of items with this particular combination of WHT business and product posting groups.';
                }
                field("Prepaid WHT Account Code"; Rec."Prepaid WHT Account Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the G/L account number to which you want to post sales WHT for the particular combination of WHT business and product posting groups.',
                                ENA = 'Specifies the G/L account number to which you want to post sales WHT for the particular combination of WHT business and product posting groups.';
                }
                field("Payable WHT Account Code"; Rec."Payable WHT Account Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the G/L account number to which you want to post Purchase WHT for the particular combination of WHT business and product posting groups.',
                                ENA = 'Specifies the G/L account number to which you want to post Purchase WHT for the particular combination of WHT business and product posting groups.';
                }
                field("WHT Report"; Rec."WHT Report")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the WHT report type for a particular Business and Product Posting group combination.',
                                ENA = 'Specifies the WHT report type for a particular Business and Product Posting group combination.';
                }
                field("Bal. Prepaid Account Type"; Rec."Bal. Prepaid Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the type of Balancing Account type for Sales WHT transaction.',
                                ENA = 'Specifies the type of Balancing Account type for Sales WHT transaction.';
                }
                field("Bal. Prepaid Account No."; Rec."Bal. Prepaid Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the Account No. or Bank name (based on Bal. Prepaid Account Type) as a balancing account for Sales WHT transactions.',
                                ENA = 'Specifies the Account No. or Bank name (based on Bal. Prepaid Account Type) as a balancing account for Sales WHT transactions.';
                }
                field("Bal. Payable Account Type"; Rec."Bal. Payable Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the type of Balancing Account type for Purchase WHT transaction.',
                                ENA = 'Specifies the type of Balancing Account type for Purchase WHT transaction.';
                }
                field("Bal. Payable Account No."; Rec."Bal. Payable Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the Account No. or Bank name (based on Bal. Prepaid Account Type) as a balancing account for Purchase WHT transactions.',
                                ENA = 'Specifies the Account No. or Bank name (based on Bal. Prepaid Account Type) as a balancing account for Purchase WHT transactions.';
                }
                field("WHT Report Line No. Series"; Rec."WHT Report Line No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the no. series for WHT Report Line for a particular WHT Business and Product Posting group combination.',
                                ENA = 'Specifies the no. series for WHT Report Line for a particular WHT Business and Product Posting group combination.';
                }
                field("Revenue Type"; Rec."Revenue Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the Revenue Type this combination of WHT Business and Product Posting group belongs to.',
                                ENA = 'Specifies the Revenue Type this combination of WHT Business and Product Posting group belongs to.';
                }
                field("Purch. WHT Adj. Account No."; Rec."Purch. WHT Adj. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies an account number for Purchase Credit Memo adjustments.',
                                ENA = 'Specifies an account number for Purchase CR/Adj Note adjustments.';
                }
                field("Sales WHT Adj. Account No."; Rec."Sales WHT Adj. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies an account number for Sales Credit Memo adjustments.',
                                ENA = 'Specifies an account number for Sales CR/Adj Note adjustments.';
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the sequence in which the WHT Posting Setup shall be displayed in reports.',
                                ENA = 'Specifies the sequence in which the WHT Posting Setup shall be displayed in reports.';
                }
                field("WHT Bearer"; Rec."WHT Bearer")
                {
                    ToolTip = 'Specifies the value of the WHT Bearer field.';
                }
                field("CAD Account"; Rec."CAD Account")
                {
                    ToolTip = 'Specifies the value of the CAD Account field.';
                }
            }
        }
    }

    actions
    {
    }
}

