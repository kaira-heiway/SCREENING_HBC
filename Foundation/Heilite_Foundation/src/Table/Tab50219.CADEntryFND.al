table 50219 "CAD Entry FND"
{
    // version HEI.01

    // HEI.01 FDD-HT2159 - CHG2105031 IBM NASTAA02 09.06.2021 # Centime - additional tax on VAT
    //   # New Table created
    //********************************************************************************************
    //BC UPGRADE 12.11.25-Done
    //01-"LookupUserID" Function of NAV was missing in BC--> CU-"User Managment", same logic added into this Object-->Functions added-->'LookupUserID' & 'LookupUser'.
    //02-->"LooupUserID" removed and replaced with function in BC-"DisplayUserInformation"
    //************************************************************************************************

    // BC Upgrade PATELS08 >>
    // # Changed datatype of field "Document Type" and "Type" from Option to Enum to avoid implicit conversion
    // BC Upgrade PATELS08 <<

    Caption = 'CAD Entry';
    DrillDownPageID = "CAD Entries";
    LookupPageID = "CAD Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.',
                        FRA = 'N° séquence';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date',
                        FRA = 'Date comptabilisation';
            ClosingDates = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        FRA = 'N° document';
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnLookup();
            var
                IncomingDocument: Record "Incoming Document";
            begin
            end;
        }

        // BC Upgrade PATELS08 >> # Changed from Option to Enum to avoid implicit conversion
        // field(4; "Document Type"; Option)
        field(4; "Document Type"; Enum "Gen. Journal Document Type")
        // BC Upgrade PATELS08 <<
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            DataClassification = ToBeClassified;
            Editable = false;
            // BC Upgrade PATELS08 >> # Blocked Option Properties
            // OptionCaptionML = ENU = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund,,,,,Bank Reverse,Bank Charge,Loan Pay Out,Loan Pay Back,Purchase Receipt,Interest Rate Credit,RPM Damage / Loss,FFE Security Payment',
            //                   FRA = ' ,Paiement,Facture,Avoir,Intérêts,Relance,Remboursement,,,,,Banque inverse,Charge bancaire,Paiment prêt,Rembousement prêt,Purchase Receipt,Interest Rate Credit,RPM Damage / Loss,FFE Security Payment';
            // OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund,,,,,"Bank Reverse","Bank Charge","Loan Pay Out","Loan Pay Back","Purchase Receipt","Interest Rate Credit","RPM Damage or Loss","FFE Security Payment";
            // BC Upgrade PATELS08 <<
        }

        // BC Upgrade PATELS08 >> # Changed from Option to Enum to avoid implicit conversion
        // field(5; Type; Option)
        field(5; Type; Enum "General Posting Type")
        // BC Upgrade PATELS08 <<
        {
            CaptionML = ENU = 'Type',
                        FRA = 'Type';
            DataClassification = ToBeClassified;
            Editable = false;
            // BC Upgrade PATELS08 >> # Blocked Option Properties
            // OptionCaptionML = ENU = ' ,Purchase,Sale,Settlement',
            //                   FRA = ' ,Achat,Vente,Règlement';
            // OptionMembers = " ",Purchase,Sale,Settlement;
            // BC Upgrade PATELS08 <<
        }
        field(6; "CAD %"; Decimal)
        {
            Caption = 'CAD %';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        FRA = 'Code magasin';
            DataClassification = ToBeClassified;
            TableRelation = Location where("Use As In-Transit" = CONST(false));
        }
        field(8; "VAT Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'VAT Bus. Posting Group',
                        FRA = 'Groupe compta. marché TVA';
            Editable = false;
            TableRelation = "VAT Business Posting Group";
        }
        field(9; "VAT Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'VAT Prod. Posting Group',
                        FRA = 'Groupe compta. produit TVA';
            Editable = false;
            TableRelation = "VAT Product Posting Group";
        }
        field(10; "CAD Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'CAD Amount',
                        FRA = 'CAD Montant';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; Base; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Base';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Amount Including CAD"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount Including CAD',
                        FRA = 'Montant incl. CAD';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Sell-to / Buy-from No."; Code[20])
        {
            Caption = 'Sell-to / Buy-from No.';
            Editable = false;
            TableRelation = IF (Type = FILTER(Purchase)) Vendor
            else IF (Type = FILTER(Sale)) Customer;
        }
        field(14; "External Document No."; Code[35])
        {
            CaptionML = ENU = 'External Document No.',
                        FRA = 'N° doc. externe';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "User ID"; Code[50])
        {
            CaptionML = ENU = 'User ID',
                        FRA = 'Code utilisateur';
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                UserMgt: Codeunit "User Management";
            begin
                //BC UPGRADE PATHAA02>>
                //UserMgt.LookupUserID("User ID"); 
                UserMgt.DisplayUserInformation("User ID");
                //BC UPGRADE PATHAA02<<
            end;
        }
        field(16; "Source Code"; Code[10])
        {
            CaptionML = ENU = 'Source Code',
                        FRA = 'Code journal';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(17; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code',
                        FRA = 'Code motif';
            Editable = false;
            TableRelation = "Return Reason";
        }
        field(20; "Amount Excl. VAT"; Decimal)
        {
            Caption = 'Amount Excl. VAT';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Account No."; Code[20])
        {
            CaptionML = ENU = 'Account No.',
                        FRA = 'N° compte général';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(69; "Transaction No."; Integer)
        {
            CaptionML = ENU = 'Transaction No.',
                        FRA = 'N° transaction';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    //BC UPGRADE PATHAA02>>
    /*
    local procedure LookupUserID(VAR UserName: Code[50])
    var
        SID: Guid;
    begin
        LookupUser(UserName, SID);
    end;

    local procedure LookupUser(VAR UserName: Code[50]; VAR SID: GUID): Boolean
    var
        user: Record User;
    begin
        User.RESET;
        User.SETCURRENTKEY("User Name");
        User."User Name" := UserName;
        IF User.FIND('=><') THEN;
        IF PAGE.RUNMODAL(PAGE::Users, User) = ACTION::LookupOK THEN BEGIN
            UserName := User."User Name";
            SID := User."User Security ID";
            EXIT(TRUE);
        end;

        EXIT(FALSE);
    end;
    */
    //BC UPGRADE PATHAA02<<
}

