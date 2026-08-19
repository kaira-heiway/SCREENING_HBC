pageextension 51015 CheckLedgerEntriesExtCBN extends "Check Ledger Entries"
{
    // version NAVW110.0
    // HEI.01 CHG2052196 IBM.PANDES01 08.06.2020
    //   # Added Code for Void check ledger entry workflow.
    //   # Added Field Approval status, Requester ID, Requester Date.


    layout
    {
        modify("Check Date")
        {
            ToolTipML = ENU = 'Specifies the check date if a check is printed.', FRA = 'Spécifie la date chèque si un chèque est imprimé.';
        }
        modify("Check No.")
        {
            ToolTipML = ENU = 'Specifies the check number if a check is printed.', FRA = 'Spécifie le numéro de chèque si un chèque est imprimé.';
        }
        modify("Bank Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the bank account used for the check ledger entry.', FRA = 'Spécifie le numéro du compte bancaire utilisé pour l''écriture comptable chèque.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a printing description for the check ledger entry.', FRA = 'Spécifie une description d''impression de l''écriture comptable chèque.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the amount on the check ledger entry.', FRA = 'Indique le montant de l''écriture comptable chèque.';
        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of balancing account used in the entry.', FRA = 'Spécifie le type du compte de contrepartie utilisé pour l''écriture.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the balancing account used in the entry.', FRA = 'Spécifie le numéro du compte de contrepartie utilisé pour l''écriture.';
        }
        modify("Entry Status")
        {
            ToolTipML = ENU = 'Specifies the printing (and posting) status of the check ledger entry.', FRA = 'Spécifie l''état d''impression (et de validation) de l''écriture comptable chèque.';
        }
        modify("Original Entry Status")
        {
            ToolTipML = ENU = 'Specifies the status of the entry before you changed it.', FRA = 'Spécifie le statut de l''écriture avant que sa modification.';
        }
        modify("Bank Payment Type")
        {
            ToolTipML = ENU = 'Specifies the payment type that applies to the entry.', FRA = 'Spécifie le mode de paiement qui s''applique à l''écriture.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of the check ledger entry.', FRA = 'Spécifie la date comptabilisation de l''écriture comptable chèque.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the document type linked to the check ledger entry. For example, Payment.', FRA = 'Spécifie le type de document lié à l''écriture comptable chèque. Par exemple, Paiement.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number on the check ledger entry.', FRA = 'Spécifie le numéro de document de l''écriture comptable chèque.';
        }
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number assigned the check ledger entry.', FRA = 'Spécifie le numéro d''écriture affecté à l''écriture comptable chèque.';
        }
        addafter("Entry No.")
        {
            field("Approval Status"; Rec."Approval Status FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Status field.';
            }
            field("Requester ID"; Rec."Requester ID FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Requester ID field.';
            }
            field("Request Date"; Rec."Request Date FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Request Date field.';
            }
        }
    }
    actions
    {
        modify("Chec&k")
        {
            CaptionML = ENU = 'Chec&k', FRA = '&Chèque';
        }
        modify("Void Check")
        {
            Visible = false; // BC Upgrade BHARDA11 
            CaptionML = ENU = 'Void Check', FRA = 'Annuler chèque';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
        }

        // BC Upgrade BHARDA11 >> --
        addfirst(navigation)
        {
            action("VoidCheck")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Void Check';
                Image = VoidCheck;
                ToolTip = 'Void the check if, for example, the check is not cashed by the bank.';

                trigger OnAction()
                var
                    CheckManagement: Codeunit CheckManagement;
                    HenekenBCUPgradeCU: Codeunit "Heineken BC Upgrade";
                begin
                    //>>HEI.01
                    CheckLedgerEntRec := Rec;
                    CurrPage.SETSELECTIONFILTER(CheckLedgerEntRec);
                    //IF ApprovalsMgmt.CheckCheckLedgerApprovalsWorkflowEnabled(Rec) THEN
                    //ApprovalsMgmt.OnSendCheckLedgerInt(CheckLedgerEntRec);

                    if Rec."Approval Status FND" = Rec."Approval Status FND"::" " then
                        HenekenBCUPgradeCU.OnSendCheckLedgerInt(CheckLedgerEntRec)
                    else if Rec."Approval Status FND" = Rec."Approval Status FND"::Approved then begin
                        BankAccountLedgerEntry.RESET();
                        BankAccountLedgerEntry.SETRANGE("Document No.", Rec."Check No.");
                        if BankAccountLedgerEntry.FINDFIRST() then
                            CheckManagement.FinancialVoidCheck(Rec)
                        else
                            VendorLedgerEntry.RESET();
                        VendorLedgerEntry.SETRANGE("Document No.", Rec."Check No.");
                        if VendorLedgerEntry.FINDFIRST() then begin
                            //IF DetailedVendorLedgEntry.GET(VendorLedgerEntry."Entry No.") THEN BEGIN
                            // VendEntryApplyPostedEntries.PostUnApplyVendor(DetailedVendorLedgEntry,VendorLedgerEntry."Document No.",VendorLedgerEntry."Posting Date");
                            HenekenBCUPgradeCU.UnApplyVendLedgEntryforcheck(VendorLedgerEntry."Entry No.");
                            ReversalEntry.ReverseTransactionforchecks(VendorLedgerEntry."Transaction No.");
                            Rec."Entry Status" := Rec."Entry Status"::"Financially Voided";
                            Rec.MODIFY(true);

                        end;

                    end;
                    //<<HEI.01
                end;
            }
        }
        addbefore("&Navigate_Promoted")
        {
            actionref(Voidcheck_Promoted; VoidCheck) { }
        }
        // BC Upgrade BHARDA11 << 
        //Unsupported feature: CodeModification on ""Void Check"(Action 36).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckManagement.FinancialVoidCheck(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>>HEI.01
        CheckLedgerEntRec := Rec;
        CurrPage.SETSELECTIONFILTER(CheckLedgerEntRec);
        //IF ApprovalsMgmt.CheckCheckLedgerApprovalsWorkflowEnabled(Rec) THEN
         //ApprovalsMgmt.OnSendCheckLedgerInt(CheckLedgerEntRec);

        if "Approval Status" = "Approval Status"::" " then
          ApprovalsMgmt.OnSendCheckLedgerInt(CheckLedgerEntRec)
        else if "Approval Status" = "Approval Status"::Approved then begin
             BankAccountLedgerEntry.RESET;
             BankAccountLedgerEntry.SETRANGE("Document No.",Rec."Check No.");
             if BankAccountLedgerEntry.FINDFIRST then
               CheckManagement.FinancialVoidCheck(Rec)
             else
               VendorLedgerEntry.RESET;
               VendorLedgerEntry.SETRANGE("Document No.",Rec."Check No.");
               if VendorLedgerEntry.FINDFIRST then begin
                  //IF DetailedVendorLedgEntry.GET(VendorLedgerEntry."Entry No.") THEN BEGIN
                   // VendEntryApplyPostedEntries.PostUnApplyVendor(DetailedVendorLedgEntry,VendorLedgerEntry."Document No.",VendorLedgerEntry."Posting Date");
                  VendEntryApplyPostedEntries.UnApplyVendLedgEntryforcheck(VendorLedgerEntry."Entry No.");
                  ReversalEntry.ReverseTransactionforchecks(VendorLedgerEntry."Transaction No.");
                  Rec."Entry Status" := Rec."Entry Status"::"Financially Voided";
                  Rec.MODIFY(true);

                end;

          end;
          //<<HEI.01
        */
        //end;
    }

    var
        //CustVendorBankAccWorkflow: Codeunit "Cust/Vendor Bank Acc. Workflow";  // BC Upgrade SAHAL01
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        ReversalEntry: Record "Reversal Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        VendEntryApplyPostedEntries: Codeunit "VendEntry-Apply Posted Entries";
        VendorLedgerEntries: Page "Vendor Ledger Entries";

    var
        CheckLedgerEntRec: Record "Check Ledger Entry";


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF FINDFIRST THEN;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if FINDFIRST then;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

