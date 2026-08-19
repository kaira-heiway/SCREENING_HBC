table 50402 "HeiFlow Vend Inv Status FND"
{
    // version HEI.01

    // HEI.01 CHG2144425 IBM POENAB02 26.05.2022 HeiLite Vendor Invoice Status| Automation for Caribbean OpCo’s SSC
    //   #Object created

    // BC Upgrade POENAB02: Original (HeiLite) table id 50242

    // BC UPGRADE PATELS08 >>
    // # Table moved from Interfaces to Foundation Layer.
    // # Table name changed from "HeiFlow-Vend.Inv.Status Setup" to "HeiFlow Vend Inv Status FND".
    // BC UPGRADE PATELS08 <<

    Caption = 'HeiFlow - Vend. Inv. Status Setup';

    fields
    {
        field(1; "Status ID"; Integer)
        {
            Caption = 'Status ID';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "External Doc. No."; Text[30])
        {
            Caption = 'External Doc. No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Payment Status"; Option)
        {
            Caption = 'Payment Status';
            DataClassification = ToBeClassified;
            OptionCaptionML = ENU = 'Pending Review,Payment Approved,Payment Rejected',
                              FRA = 'En attente,Paiement approuvé,Paiement rejeté';
            OptionMembers = "Pending Review","Payment Approved","Payment Rejected";
        }
        field(5; Open; Boolean)
        {
            Caption = 'Open';
            DataClassification = ToBeClassified;
        }
        field(6; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            DataClassification = ToBeClassified;
            OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss',
                              FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage or Loss';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back","Purchase Receipt","Interest Rate Credit","RPM Damage or Loss","FFE Security Payment";
        }
        field(7; "Batch Payment Name"; Text[50])
        {
            Caption = 'Batch Payment Name';
            DataClassification = ToBeClassified;
        }
        field(8; "On Hold"; Text[30])
        {
            Caption = 'On Hold';
            DataClassification = ToBeClassified;
        }
        field(9; "Closed by Entry No."; Text[30])
        {
            Caption = 'Closed by Entry No.';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Status ID", "External Doc. No.", "Payment Status", Open, "Document Type", "Batch Payment Name", "On Hold", "Closed by Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

