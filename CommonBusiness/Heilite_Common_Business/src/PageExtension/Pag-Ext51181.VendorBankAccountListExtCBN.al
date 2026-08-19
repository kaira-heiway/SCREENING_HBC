pageextension 51181 VendorBankAccountListExtCBN extends "Vendor Bank Account List"
{
    // version NAVW110.0
    //     # HEI.01 ibmPATHAA02
    // # Aligned Vendor No. in the page
    // # Added Code on OnClosePage-041017
    // # commented for defect 629
    // HEI.02 FDD-HT1103 IBM SURYAS01  13-04-2020
    //   #Added new Field - "Compensation Bank"
    // HEI.03 CHG2003450 IBM.GUNERE01 17.02.2021 # Approval Entries Pageaction created


    layout
    {
        addbefore(Code)
        {
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Vendor No. field.';
            }
            field("Vendor Name"; Rec."Vendor Name FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Vendor Name field.';
            }
        }
        addafter("Language Code")
        {
            field("Compensation Bank"; Rec."Compensation Bank FND")
            {
                ApplicationArea = ALL;
                ToolTip = 'Specifies the value of the Compensation Bank field.';
            }
        }


        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Code(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Code(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Name(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Name(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Post Code"(Control 87)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Post Code"(Control 87)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Country/Region Code"(Control 89)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Country/Region Code"(Control 89)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Phone No."(Control 91)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Phone No."(Control 91)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Fax No."(Control 93)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Fax No."(Control 93)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Contact(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Contact(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bank Account No."(Control 105)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Bank Account No."(Control 105)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SWIFT Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""SWIFT Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "IBAN(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "IBAN(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Currency Code"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Language Code"(Control 103)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Language Code"(Control 103)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

    }


    actions
    {
        addfirst(Navigation)
        {
            action(ApprovalEntries)
            {
                ApplicationArea = ALL;
                Caption = 'Approval Entries';
                Promoted = TRUE;
                Image = Approvals;
                PromotedCategory = Process;
                ToolTip = 'Executes the Approval Entries action.';
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //>> HEI.03
                    ApprovalsMgmt.OpenApprovalEntriesPage(REC.RECORDID);
                    //<< HEI.03

                end;
            }
        }

    }


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

