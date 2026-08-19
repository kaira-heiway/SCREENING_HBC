pageextension 51108 PaymentMethodsExtCBN extends "Payment Methods"
{
    // version NAVW110.0

    //     DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added fields
    //                                    "Pos System","Pos System Timestamp"
    //                                    "Payment Details","Refunds","Payment Terminal Link Type","Cash Drawer"
    //                                    "Editable","Exclude on Total","Button Background Color","Button Position No."
    //                                  Added button "Payment"
    //                                  Added menu "SOM Synchronize"
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.03 DDR 26/03/2014 DIT-770 #563 Added fields "Cash Payment"
    // DITW17.10.05 WSA 01/09/2014 DIT-770 #626 Added Field "Full Payment"
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01, FDD_PTPGAP022 31.07.17 #Aligned new field-Cheque-----reverted/commented-----defect94
    // HEI.02, FDD-PTPGAP007 27.08.17 #Aligned new field-"Mandatory Bank Details"
    // HEI.03 FDD-PTPGAP072 IBM NASTAA02 31.01.2017 # Cashier Order Creation
    //   # New field added "Cashier Order"
    // HEI.04 CHG2181582 IBM SRIVAS07 16.03.2023 - Mozambique bank connectivity -  outgoing payments (Standard Bank - domestic)
    //   # New field added "Bank Connectivity Pmt. Method"
    //BC Upgrade PATHAA02-25Sep25-Done

    layout
    {
        //BC Upgrade PATHAA02>> 
        addafter("Pmt. Export Line Definition")
        {
            field(Cheque; Rec."Cheque FND")
            {
                ApplicationArea = All;
                Caption = 'Cheque';
                ToolTip = 'Specifies the value of the Cheque field.';
            }
            field("Mandatory Bank details"; Rec."Mandatory Bank details FND")
            {
                ApplicationArea = All;
                Caption = 'Mandatory Bank details';
                ToolTip = 'Specifies the value of the Mandatory Bank details field.';
            }
            field("Cashier Order"; Rec."Cashier Order FND")
            {
                ApplicationArea = All;
                Caption = 'Cashier Order';
                ToolTip = 'Specifies the value of the Cashier Order field.';
            }
            field("Bank Connectivity Pmt. Method"; Rec."Bank Cnctvty Pmt. Method FND")
            {
                ApplicationArea = All;
                Caption = 'Bank Connectivity Pmt. Method';
                ToolTip = 'Specifies the value of the Bank Connectivity Pmt. Method field.';
            }
            //BC Upgrade PATHAA02<<

            //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Code(Control 2)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Code(Control 2)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Description(Control 4)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Description(Control 4)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Bal. Account Type"(Control 8)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Bal. Account Type"(Control 8)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Bal. Account No."(Control 6)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Bal. Account No."(Control 6)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Direct Debit"(Control 3)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Direct Debit"(Control 3)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Direct Debit Pmt. Terms Code"(Control 5)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Direct Debit Pmt. Terms Code"(Control 5)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Pmt. Export Line Definition"(Control 7)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Pmt. Export Line Definition"(Control 7)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Bank Data Conversion Pmt. Type"(Control 9)". Please convert manually.


            //Unsupported feature: PropertyDeletion on ""Bank Data Conversion Pmt. Type"(Control 9)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Control1900000007(Control 1900000007)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Control1900383207(Control 1900383207)". Please convert manually.


            //Unsupported feature: PropertyDeletion on "Control1905767507(Control 1905767507)". Please convert manually.

        }

    }

}