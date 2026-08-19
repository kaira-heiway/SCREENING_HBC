pageextension 51042 FALedgerEntriesExtCBN extends "FA Ledger Entries"
{
    // HEI.01 FDD-HT665 - Ethiopia Customize FA Ledger Entries IBM NASTAA02 09.07.2019 # Ethiopia Customize FA Ledger Entries
    //   # New Field added: "Vendor ID", "PO Number", "Reference Number", "CAPEX Code"
    // HEI.02 FDD-HT584 IBM NASTAA02 02.09.2019 # La Reunion FA Derogatory Depreciation
    //   # New Field added: "Exclude Derogatory"
    // version NAVW110.0,DITW110.00.08

    //Bc Upgrade YADAVM09 Drink it field blocked-Exclude Derogatory.

    layout
    {
        modify("FA Posting Date")
        {
            ToolTipML = ENU = 'Specifies the entry''s FA posting date.', FRA = 'Spécifie la date comptabilisation immobilisation de l''écriture.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the entry document type.', FRA = 'Spécifie le type de document de l''écriture.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number on the entry.', FRA = 'Spécifie le numéro du document de l''écriture.';
        }
        modify("FA No.")
        {
            ToolTipML = ENU = 'Specifies the number of the fixed asset the entry is linked to.', FRA = 'Spécifie le numéro de l''immobilisation auquel l''écriture est liée.';
        }
        modify("Depreciation Book Code")
        {
            ToolTipML = ENU = 'Specifies the code for the depreciation book used when the entry was posted.', FRA = 'Spécifie le code de la loi d''amortissement utilisé lors de la validation de l''écriture.';
        }
        modify("FA Posting Category")
        {
            ToolTipML = ENU = 'Specifies the posting category assigned to the entry when it was posted.', FRA = 'Spécifie la catégorie de validation affectée à l''écriture lorsqu''elle a été validée.';
        }
        modify("FA Posting Type")
        {
            ToolTipML = ENU = 'Specifies the fixed asset posting type used when the entry was posted.', FRA = 'Spécifie le type de validation des immobilisations utilisé lorsque l''écriture a été validée.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the entry.', FRA = 'Spécifie une description de l''écriture.';
        }
        modify("Global Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code the entry is linked to.', FRA = 'Spécifie le code section analytique lié à l''écriture.';
        }
        modify("Global Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the dimension value code the entry is linked to.', FRA = 'Spécifie le code section analytique lié à l''écriture.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the entry amount in currency.', FRA = 'Spécifie le montant de l''écriture en devise.';
        }
        modify("Reclassification Entry")
        {
            ToolTipML = ENU = 'Specifies whether the entry was made to reclassify a fixed asset, for example, to change the dimension the fixed asset is linked to.', FRA = 'Indique si l''écriture a été passée pour reclasser une immobilisation, par exemple, pour modifier l''axe auquel l''immobilisation est liée.';
        }
        modify("Index Entry")
        {
            ToolTipML = ENU = 'Specifies this entry is an index entry.', FRA = 'Spécifie que cette écriture est une écriture réévaluation.';
        }
        modify("No. of Depreciation Days")
        {
            ToolTipML = ENU = 'Specifies the number of depreciation days that were used for calculating depreciation for the fixed asset entry.', FRA = 'Spécifie le nombre de jours d''amortissement utilisés pour le calcul de l''amortissement de l''écriture comptable immobilisation.';
        }
        modify("Bal. Account Type")
        {
            ToolTipML = ENU = 'Specifies the type of balancing account used in the entry: G/L Account, Bank Account, or Fixed Asset.', FRA = 'Spécifie le type du compte de contrepartie utilisé pour l''écriture : compte général, compte bancaire ou immobilisation.';
        }
        modify("Bal. Account No.")
        {
            ToolTipML = ENU = 'Specifies the number of the balancing account used on the entry.', FRA = 'Spécifie le numéro du compte de contrepartie utilisé pour l''écriture.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user associated with the entry.', FRA = 'Spécifie le code de l''utilisateur associé à l''écriture.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the source code linked to the entry.', FRA = 'Spécifie le code source lié à l''écriture.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code on the entry.', FRA = 'Spécifie le code motif de l''écriture.';
        }
        modify(Reversed)
        {
            ToolTipML = ENU = 'Specifies whether the entry has been part of a reverse transaction (correction) made by the Reverse function.', FRA = 'Indique si l''écriture a fait partie d''une transaction contrepassée (correction) effectuée par la fonction Contrepasser.';
        }
        modify("Reversed by Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the correcting entry.', FRA = 'Spécifie le numéro de l''écriture de correction.';
        }
        modify("Reversed Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the original entry that was undone by the reverse transaction.', FRA = 'Spécifie le numéro de l''écriture initiale annulée par la transaction contre-passée.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the entry''s posting date.', FRA = 'Spécifie la date comptabilisation de l''écriture.';
        }
        modify("G/L Entry No.")
        {
            ToolTipML = ENU = 'Specifies the G/L number for the entry that was created in the general ledger for this fixed asset transaction.', FRA = 'Spécifie le numéro écriture comptable de l''écriture créée en comptabilité pour cette transaction immobilisation.';
        }
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number that is assigned to the entry.', FRA = 'Spécifie le numéro qui est affecté à l''écriture.';
        }
        addafter("Entry No.")
        {
            //BC Upgrade KAPOOV01-drink-it>>
            // field("Contract Type";Rec."Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("DIT Sub-Contract Type"; "DIT Sub-Contract Type")
            // {
            //     Visible = false;
            // }
            // field("Service Contract No."; "Service Contract No.")
            // {
            //     Visible = false;
            // }
            // field("Financial Contract No."; "Financial Contract No.")
            // {
            //     Visible = false;
            // }
            // field("Contract Group Code"; "Contract Group Code")
            // {
            //     Visible = false;
            // }
            //BC Upgrade KAPOOV01-drink-it<<
            field(CCC; CCC)
            {
                Caption = 'CCC';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CCC field.';
            }
            field(Capex; Capex)
            {
                Caption = 'Capex';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Capex field.';
            }
            field(SerialNo; SerialNo)
            {
                Caption = 'Serial No';
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Serial No field.';
            }
            field("Vendor ID"; Rec."Vendor ID FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor ID field.';
            }
            field("PO Number"; Rec."PO Number FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Number field.';
            }
            field("Reference Number"; Rec."Reference Number FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reference Number field.';
            }
            field("CAPEX Code"; Rec."CAPEX Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CAPEX Code field.';
            }
            field("FALedgEntry.""Transaction No."""; FALedgEntry."Transaction No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transaction No. field.';
            }
            /* //Bc Upgrade YADAVM09 Drink it field commented>>
           field("Exclude Derogatory"; Rec."Exclude Derogatory")
           {
           }
            */ //Bc Upgrade YADAVM09 Drink it field commented<<
        }
    }
    actions
    {
        modify("Ent&ry")
        {
            CaptionML = ENU = 'Ent&ry', FRA = 'É&criture';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(CancelEntries)
        {
            CaptionML = ENU = 'Cancel Entries', FRA = 'Annuler écritures';
            ToolTipML = ENU = 'Remove one or more fixed asset ledger entries from the FA Ledger Entries window. If you posted erroneous transactions to one or more fixed assets, you can use this function to cancel the fixed asset ledger entries. In the FA Ledger Entries window, select the entry or entries that you want to cancel.', FRA = 'Supprimez une ou plusieurs écritures comptables immobilisation de la fenêtre Écritures comptables immobilisation. Si vous avez validé des transactions erronées sur une ou plusieurs immobilisations, vous pouvez utiliser cette fonction pour annuler les écritures comptables immobilisation. Dans la fenêtre Écritures comptables immobilisation, sélectionnez la ou les écritures à annuler.';
        }
        modify(ReverseTransaction)
        {
            CaptionML = ENU = 'Reverse Transaction', FRA = 'Transaction contre-passée';
            ToolTipML = ENU = 'Undo an erroneous journal posting.', FRA = 'Annulez une validation feuille erronée.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document sélectionné(e).';
        }


        //Unsupported feature: CodeModification on "ReverseTransaction(Action 38).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CLEAR(ReversalEntry);
        IF Reversed THEN
          ReversalEntry.AlreadyReversedEntry(TABLECAPTION,"Entry No.");
        IF "Journal Batch Name" = '' THEN
          ReversalEntry.TestFieldError;
        FADeprBook.GET("FA No.","Depreciation Book Code");
        IF FADeprBook."Disposal Date" > 0D THEN
          ERROR(Text001);
        IF "Transaction No." = 0 THEN
          ERROR(CannotUndoErr,"Entry No.","Depreciation Book Code");
        TESTFIELD("G/L Entry No.");
        ReversalEntry.ReverseTransaction("Transaction No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CLEAR(ReversalEntry);
        if Reversed then
          ReversalEntry.AlreadyReversedEntry(TABLECAPTION,"Entry No.");
        if "Journal Batch Name" = '' then
          ReversalEntry.TestFieldError;
        FADeprBook.GET("FA No.","Depreciation Book Code");
        if FADeprBook."Disposal Date" > 0D then
          ERROR(Text001);
        if "Transaction No." = 0 then
        #10..12
        */
        //end;
    }


    //Unsupported feature: PropertyModification on "CannotUndoErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //CannotUndoErr : ENU=You cannot undo the FA Ledger Entry No. %1 by using the Reverse Transaction function because Depreciation Book %2 does not have the appropriate G/L integration setup.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CannotUndoErr : ENU=You cannot undo the FA Ledger Entry No. %1 by using the Reverse Transaction function because Depreciation Book %2 does not have the appropriate G/L integration setup.;FRA=Vous ne pouvez pas annuler le n° écriture comptable immobilisation %1 à l'aide de la fonction de contrepassation de transaction car la configuration de l'intégration compta. des lois d'amortissement %2 n'est pas appropriée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot reverse the transaction because the fixed asset has been sold.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot reverse the transaction because the fixed asset has been sold.;FRA=Vous ne pouvez pas contrepasser la transaction car l'immobilisation a été vendue.;
    //Variable type has not been exported.

    var
        Capex: Code[20];
        CCC: Code[20];
        SerialNo: Text[30];


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    var
        DefDim: Record "Default Dimension";
        DimSetEntry: Record "Dimension Set Entry";
        FA: Record "Fixed Asset";
    //begin
    /*
    SerialNo := '';
    Capex := '';
    CCC := '';
    if FA.GET("FA No.") then begin
      SerialNo := FA."Serial No.";
      CCC := FA."Global Dimension 2 Code";
      DefDim.SETRANGE("Table ID",DATABASE::"Fixed Asset");
      DefDim.SETRANGE("No.","FA No.");
      DefDim.SETRANGE("Dimension Code",'CAPEX');
      if DefDim.FINDFIRST then
        Capex := DefDim."Dimension Value Code";
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    var
        FALedgEntry: Record "FA Ledger Entry";

}

