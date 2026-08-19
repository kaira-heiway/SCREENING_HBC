page 58102 GenJnlTemplate_HEIFLOW
{
    // version HEI.01

    // HEI.01 CHG2132929 IBM POENAB02 18.03.2022 HeiLite GL Postings| Automation for Caribbean OpCo’s SSC
    //   #Object created

    // BC Upgrade POENAB02: Original (HeiLite) page id 50279

    Editable = false;
    PageType = List;
    SourceTable = "Gen. Journal Template";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the general journal template.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the general journal template.';
                }
                field("Test Report ID"; Rec."Test Report ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the test report.';
                }
                field("Page ID"; Rec."Page ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the page.';
                }
                field("Posting Report ID"; Rec."Posting Report ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the posting report.';
                }
                field("Force Posting Report"; Rec."Force Posting Report")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to force the posting report to run.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the general journal template.';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source code for the general journal template.';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason code for the general journal template.';
                }
                field(Recurring; Rec.Recurring)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general journal template is recurring.';
                }
                field("Test Report Caption"; Rec."Test Report Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the caption of the test report.';
                }
                field("Page Caption"; Rec."Page Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the caption of the page.';
                }
                field("Posting Report Caption"; Rec."Posting Report Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the caption of the posting report.';
                }
                field("Force Doc. Balance"; Rec."Force Doc. Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to force document balancing.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the balancing account.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the balancing account.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series for the general journal template.';
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting number series for the general journal template.';
                }
                field("Copy VAT Setup to Jnl. Lines"; Rec."Copy VAT Setup to Jnl. Lines")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to copy the VAT setup to journal lines.';
                }
                field("Allow VAT Difference"; Rec."Allow VAT Difference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to allow VAT differences.';
                }
                field("Cust. Receipt Report ID"; Rec."Cust. Receipt Report ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the customer receipt report.';
                }
                field("Cust. Receipt Report Caption"; Rec."Cust. Receipt Report Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the caption of the customer receipt report.';
                }
                field("Vendor Receipt Report ID"; Rec."Vendor Receipt Report ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the vendor receipt report.';
                }
                field("Vendor Receipt Report Caption"; Rec."Vendor Receipt Report Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the caption of the vendor receipt report.';
                }
                field("Ext. Doc. No. Mandatory"; Rec."Ext. Doc. No. Mandatory FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether an external document number is mandatory.';
                }
                field("Save Batch"; Rec."Save Batch FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to save the batch after posting.';
                }
                field("Customer Mandate"; Rec."Customer Mandate FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer mandate for the general journal template.';
                }
                field("RPM Payment"; Rec."RPM Payment FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general journal template is for RPM payments.';
                }
                field("Restrct Duplicate Extrn Doc"; Rec."Restrct Dplct. Extrn Doc FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether to restrict duplicate external document numbers.';
                }
                field("SO Cash Application"; Rec."SO Cash Application FND")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general journal template is for sales order cash application.';
                }
                // BC Upgrade POENAB02 >>
                // commented, as it is part of Aptead developments
                /* 
                field("Credit Memo"; Rec."Credit Memo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the general journal template is for credit memos.';
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

