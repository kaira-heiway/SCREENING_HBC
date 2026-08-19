pageextension 51101 UserSetupExtCBN extends "User Setup"
//BC Upgrade KAMNAY01>> Manually created this page extension because it was not included in the migrated object file. 
{
    //    HEI.01 FDD-GAPID001 : IBM.NAIKH01
    //   #Added a new Fiels "Allow Partial Output"
    // HEI.02 RTRGAP038 IBM.CHAUHB01 05/08/17
    //  # Added Field "Allowed Change App. Mode"
    // HEI.03 FDD-BA-LOGGAP01 IBM NASTAA02 06.07.2018 # Request Order
    //   # New Field added: "Release Request Order"
    //   # Field "Release Request Order" is visible just when "Enable Request Order" is ticked on OpCo Setup
    // HEI.04 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # New Field added: "Allow Gate Entry Register"
    // HEI.05 V1.05 HT84 IBM POENAB02 07.05.2019
    //   # New field: "Allow to Reexport Payment WS"
    // HEI.06 FDD-ET-MARAKI POS Interface IBM NASTAA02 21.06.2018 # Maraki POS Interface
    //   # New Field added: "Allow Change Interface Flag"
    // HEI.07 FDD-Ethiopia_Prepayment HT628 IBM POSTOI01 01.07.2019
    //   # Show New fields 50012Modify Prepay.Condt. on BOBooleanHEI.11
    // HEI.06 FDD-IC-PRODGAP BRD HT417 IBM ISYED01 04/10/2019 # PO IC Layout
    //   # New Field created: Procurement Service Manager
    // HEI.09 FDD-HT620 IBM BULIMC01 02.08.2019 #new field displayed “Consump. Tolerance Warning”
    // HEI.11 CHG2026978 IBM.LS      15.11.2019
    //   # New Field added - Freeze/Unfreeze Phys Invt Jnl.
    // HEI.12 CHG2022325 FDD-HT630 IBM.GUNERE01 18.11.2019 # "Edit PO Tol. Received Over" field added
    // HEI.14 CHG2020184 IBM POENAB02 26.06.2019
    //   # New field for Bank Connectivity CAMT053: 50016 "Allow to Reprocess CAMT053 WS"
    // HEI.16 FDD-HT664 IBM SURYAS01 02-jan-2020
    // # Added New field-"Payment Slip-Display Path"
    // HEI.17 FDD-HB1341 CHG2065548 IBM SHANKJ03  10.08.2020
    //   # Created new field Allow Delete/Archieve PQ
    // HEI.18 CHG2069321 GAVANM01 IBM 13.10.2020 #PowerApps Integration
    //   # New field added: "Approve in PowerApps Approval App"
    // HEI.19 HT2139 CHG2105037 IBM NANDIS01 30-04-2021 - Brasco Congo: HT2139 - PO Form Layout
    //   # New Page Electronic Signature added in User Setup
    // HEI.20 CHG2115759 IBM.AB 08-Jun-2021
    //   # New field added - Allow Delete/Archive PO/Return
    // HEI.21 CHG2126534 IBM.AB 15-Sep-2021
    //   # New field added: 50022-Allow Bypass WHT Validation
    // HEI.22 CHG2155847 HB2821 IBM NANDIS01 03.08.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Field shown - "Allow deletion ASTRO Whs Rcpt"
    // HEI.23 CHG2155847 HB2821 IBM NANDIS01 12.09.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Caption changed to Allow Deletion of ASTRO POs from "Allow deletion ASTRO Whs Rcpt"
    // HEI.24 CHG2155847 HB2821 IBM NANDIS01 06.02.2022 - DispatchSync and DispatchReceiveReport_Astro WMS Integration
    //   # Caption changed to Allow Deletion of ASTRO POs/PROs from Allow Deletion of ASTRO POs
    // HEI.25 CHG2202558 IBM BHANDS01 04.05.2023 - MtC Astro changes for reopening/deletion of SO/SRO/TO
    //   # New field addedAllow deletion Astro SO/SRO/TOBoolean
    // HEI.26 IBM SAMANR01 12.05.2023 CHG2204329 Email Validation on JOB Q & Interfaces
    //   # Add code for email validation
    // HEI.27 CHG2227390 HB3558 SRIVAS07 IBM 19.12.2023 # Role-StP call off handler not to create PO from PQ.
    //   # New field added - "Make PQ to PO"
    // HEI.28 CHG2231326 HB3599 YADAVM09 IBM 07.02.2024 # Restrict users to connect or disconnect RTR journal templates from the Workflow approval on Opco level.
    //   # New field Added - 50026 - "Restrict RtR Workflow Users"
    // HEI.29 CHG2277569 SAHAL01 29.01.2025 Not able to apply Entries
    //   # Added New Field - Allow to Reopen G/L Entry

    //Bc Upgrade YADAVM09 page action Added Warehouse Employee,Approval User Setup


    layout
    {
        modify(Email)
        {
            trigger OnAfterValidate()
            var
                SendEmailConfirmation: Codeunit "Send Email Confirmation CBN";
            begin
                //HEI.26>>
                SendEmailConfirmation.ValidateEmailAddresses(Rec."E-Mail", TRUE);
                //HEI.26<<
            end;
        }
        //BC Upgrade Gunrem01>> Field added 
        addafter("User ID")
        {
            field("Release Item"; Rec."Release Item FND")
            {
                ApplicationArea = All;

            }
        }
        //BC Upgrade Gunrem01<<Field added

        addafter(LicenseType)
        {
            field("Allow Partial Output"; Rec."Allow Partial Output FND")
            {
                ApplicationArea = All;
                Caption = 'Allow Partial Output';
                ToolTip = 'Specifies the value of the Allow Partial Output field.';

            }
            field("Allowed Change App. Mode"; Rec."Allowed Change App. Mode FND")
            {
                ApplicationArea = All;
                Caption = 'Allowed Change App. Mode';
                ToolTip = 'Specifies the value of the Allowed Change App. Mode field.';

            }
            field("Release Request Order"; Rec."Release Request Order FND")
            {
                ApplicationArea = All;
                Caption = 'Release Request Order';
                Visible = RequestOrderEnabled;
                ToolTip = 'Specifies the value of the Release Request Order field.';

            }
            field("Allow Gate Entry Register"; Rec."Allow Gate Entry Register FND")
            {
                ApplicationArea = All;
                Caption = 'Allow Gate Entry Register';
                ToolTip = 'Specifies the value of the Allow Gate Entry Register field.';
            }
            field("Allow to Reexport Payment WS"; Rec."Allow to Reexport Pay WS FND")
            {
                ApplicationArea = All;
                Caption = 'Allow to Reexport Payment WS';
                ToolTip = 'Specifies the value of the Allow to Reexport Payment WS field.';
            }
            field("Allow Change Interface Flag"; Rec."Allow Change Inter Flag FND")
            {
                ApplicationArea = All;
                Caption = 'Allow Change Interface Flag';
                ToolTip = 'Specifies the value of the Allow Change Interface Flag field.';
            }
            field("Allow Mod Prepay.Condt. BO"; Rec."Allow Mod Prepay.Condt. BO FND")
            {
                ApplicationArea = All;
                Caption = 'Allow Modify Prepayment Conditions on Blanket Order';
                ToolTip = 'Specifies the value of the Allow Modify Prepayment Conditions on Blanket Order field.';
            }
            field("Procurement Service Manager"; Rec."Procurement Serv Manager FND")
            {
                ApplicationArea = All;
                Caption = 'Procurement Service Manager';
                ToolTip = 'Specifies the value of the Procurement Service Manager field.';
            }
            field("Consump. Tolerance Warning"; Rec."Consump. Tolerance Warning FND")
            {
                ApplicationArea = All;
                Caption = 'Consump. Tolerance Warning';
                ToolTip = 'Specifies the value of the Consump. Tolerance Warning field.';
            }
            field("Freeze/Unfreeze Phys Invt Jnl."; Rec."Freeze/Unfreez PhysInvtJnl.FND")
            {
                ApplicationArea = All;
                Caption = 'Freeze/Unfreeze Phys Invt Jnl.';
                ToolTip = 'Specifies the value of the Freeze/Unfreeze Phys Invt Jnl. field.';
            }
            field("Edit PO Tol. Received Over"; Rec."Edit PO Tol. Received Over FND")
            {
                ApplicationArea = All;
                Caption = 'Edit PO Tol. Received Over';
                ToolTip = 'Specifies the value of the Edit PO Tol. Received Over field.';
            }
            field("Allow to Reprocess CAMT053 WS"; Rec."Allow to Rep CAMT053 WS FND")
            {
                ApplicationArea = All;
                Caption = 'Allow to Reprocess CAMT053 WS';
                ToolTip = 'Specifies the value of the Allow to Reprocess CAMT053 WS field.';
            }
            field("Payment Slip-Display Path"; Rec."Payment Slip-Display Path FND")
            {
                ApplicationArea = All;
                Caption = 'Payment Slip-Display Path';
                ToolTip = 'Specifies the value of the Payment Slip-Display Path field.';
            }
            field("Allow Delete/Archieve PQ"; Rec."Allow Delete/Archieve PQ FND")
            {
                ApplicationArea = All;
                Caption = 'Allow Delete/Archieve PQ';
                ToolTip = 'Specifies the value of the Allow Delete/Archieve PQ field.';
            }
            field("Approve in PowerApps"; Rec."Approve in PowerApps FND")
            {
                ApplicationArea = All;
                Caption = 'Approve in PowerApps';
                ToolTip = 'Specifies the value of the Approve in PowerApps field.';
            }
            field("Allow Delete/Archive PO/Return"; Rec."Allow Delete/Arc PO/Return FND")
            {
                ApplicationArea = All;
                Caption = 'Allow Delete/Archive PO/Return';
                ToolTip = 'Specifies the value of the Allow Delete/Archive PO/Return field.';
            }
            field("Allow Bypass WHT Validation"; Rec."Allow Bypass WHT Valid FND")
            {
                ApplicationArea = All;
                Caption = 'Allow Bypass WHT Validation';
                ToolTip = 'Specifies the value of the Allow Bypass WHT Validation field.';
            }
            field("Allow deletion ASTRO Whs Rcpt"; Rec."Allow del ASTRO Whs Rcpt FND")
            {
                ApplicationArea = All;
                Caption = 'Allow Deletion of ASTRO POs/PROs';
                ToolTip = 'Specifies the value of the Allow Deletion of ASTRO POs/PROs field.';
            }
            field("Allow Deletion Astro SO/SRO/TO"; Rec."Allow Del Astro SO/SRO/TO FND")
            {
                ApplicationArea = All;
                Caption = 'Allow Deletion of Astro SO/SRO/TO';
                ToolTip = 'Specifies the value of the Allow Deletion of Astro SO/SRO/TO field.';
            }
            field("Make PQ to PO"; Rec."Make PQ to PO FND")
            {
                ApplicationArea = All;
                Caption = 'Make PQ to PO';
                ToolTip = 'Specifies the value of the Make PQ to PO field.';
            }
            field("Restrict RtR Workflow Users"; Rec."Restrict RtR Work Users FND")
            {
                ApplicationArea = All;
                Caption = 'Restrict RtR Workflow Users';
                ToolTip = 'Specifies the value of the Restrict RtR Workflow Users field.';
            }
            field("Allow to Reopen G/L Entry"; Rec."Allow to Reopen G/L Entry FND")
            {
                ApplicationArea = All;
                Caption = 'Allow to Reopen G/L Entry';
                ToolTip = 'Specifies the value of the Allow to Reopen G/L Entry field.';

            }
            field("Allow to send to EBMS"; Rec."Allow to send to EBMS FND")
            {
                ApplicationArea = All;
                Caption = 'Allow to send to EBMS';
                ToolTip = 'Specifies the value of the Allow to send to EBMS field.';
            }
        }

    }
    // BC Upgrade KAMNAY01>>
    actions
    {
        addlast(Processing)
        {
            action("Electronic Signature")
            {
                Visible = true;
                Caption = 'Electronic Signature';
                Image = Signature;
                Promoted = true;
                PromotedCategory = New;
                Scope = Page;
                RunObject = page "User Electronic Signature CBN";
                RunPageLink = "User ID" = FIELD("User ID");
                ApplicationArea = All;
                ToolTip = 'Executes the Electronic Signature action.';
            }
            action("Approval user setup")
            {
                Visible = true;
                Caption = 'Approval Uset Setup';
                Image = UserSetup;
                Promoted = true;
                PromotedCategory = New;
                Scope = Page;
                RunObject = page "Approval User Setup";
                RunPageLink = "User ID" = FIELD("User ID");
                ApplicationArea = All;
                ToolTip = 'Executes Approval user Setup page';
            }
            action("Warehouse Employees")
            {
                Visible = true;
                Caption = 'Warehouse Employee';
                Image = UserSetup;
                Promoted = true;
                PromotedCategory = New;
                Scope = Page;
                RunObject = page "Warehouse Employees";
                RunPageLink = "User ID" = FIELD("User ID");
                ApplicationArea = All;
                ToolTip = 'Executes Approval user Setup page';
            }
        }
        // BC Upgrade KAMNAY01<<




    }
    // BC Upgrade KAMNAY01>>
    trigger OnOpenPage()

    begin
        //HEI.03>>
        GeneralOpCoSetup.GET();
        RequestOrderEnabled := GeneralOpCoSetup."Enable Request Order"
        //HEI.03<<
    end;
    // BC Upgrade KAMNAY01<<

    var
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        RequestOrderEnabled: Boolean;

}
//BC Upgrade KAMNAY01<< Manually created this page extension because it was not included in the migrated object file. 

