pageextension 52000 DetailedVendorLedgEntriesExt extends "Detailed Vendor Ledg. Entries"
{

    // version NAVW110.0,FINXL8.00,DITW110.00.08,HEI.01
    //     FINXL8.00.001 BSA 15/06/2015 #79 : Add calculation of the txtName

    // DITW16.00.00.41 AHU 06/08/2012 DIT-715 #327 Added fields "Service Contract Type","Service Contract No.","building no."
    // DITW16.00.00.42 DDR 30/11/2012 DIT-715 #370 Added fields "Item Charge Type"
    // DITW18.00.06 MSF 31/07/2015 DIT-770 #1368 Added Field Financial Contract No.(All table using service contract No)
    //                                           Rename Field Service contract Type => Contract Type

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 CHG2236692 IBM SISUM01 29.02.2024 HB3717_Development to perform revaluation for AR/AP
    //   #add on action page to see additional detailes page

    //*****************************************************************************
    //BC UPGRADE PATHAA02 04.11.25 -Done
    //1. DIT Fields, code, variable -commented
    //*****************************************************************************

    layout
    {
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the posting date of the detailed vendor ledger entry.', FRA = 'Spécifie la date comptabilisation de l''écriture comptable fournisseur détaillée.';
        }
        modify("Entry Type")
        {
            ToolTipML = ENU = 'Specifies the entry type of the detailed vendor ledger entry.', FRA = 'Spécifie le type de l''écriture comptable fournisseur détaillée.';
        }
        modify("Document Type")
        {
            ToolTipML = ENU = 'Specifies the document type of the detailed vendor ledger entry.', FRA = 'Spécifie le type de document de l''écriture comptable fournisseur détaillée.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'Specifies the document number of the transaction that created the entry.', FRA = 'Spécifie le numéro document de la transaction qui a créé l''écriture.';
        }
        modify("Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor account to which the entry is posted.', FRA = 'Spécifie le numéro du compte fournisseur sur lequel l''écriture est validée.';
        }
        modify("Initial Entry Global Dim. 1")
        {
            ToolTipML = ENU = 'Specifies the Global Dimension 1 code of the initial vendor ledger entry.', FRA = 'Spécifie le code Axe principal 1 de l''écriture comptable fournisseur initiale.';
        }
        modify("Initial Entry Global Dim. 2")
        {
            ToolTipML = ENU = 'Specifies the Global Dimension 2 code of the initial vendor ledger entry.', FRA = 'Spécifie le code Axe principal 2 de l''écriture comptable fournisseur initiale.';
        }
        modify("Currency Code")
        {
            ToolTipML = ENU = 'Specifies the code for the currency if the amount is in a foreign currency.', FRA = 'Spécifie le code de la devise si le montant est exprimé en devise étrangère.';
        }
        modify(Amount)
        {
            ToolTipML = ENU = 'Specifies the amount of the detailed vendor ledger entry.', FRA = 'Spécifie le montant de l''écriture comptable fournisseur détaillée.';
        }
        modify("Amount (LCY)")
        {
            ToolTipML = ENU = 'Specifies the amount of the entry in LCY.', FRA = 'Spécifie le montant de l''écriture en DS.';
        }
        modify("Initial Entry Due Date")
        {
            ToolTipML = ENU = 'Specifies the date on which the initial entry is due for payment.', FRA = 'Spécifie la date à laquelle l''écriture initiale doit être payée.';
        }
        modify("User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who created the entry.', FRA = 'Spécifie le code de l''utilisateur qui a créé l''écriture.';
        }
        modify("Source Code")
        {
            ToolTipML = ENU = 'Specifies the source code that specifies where the entry was created.', FRA = 'Spécifie le code journal qui spécifie où l''écriture a été créée.';
        }
        modify("Reason Code")
        {
            ToolTipML = ENU = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.', FRA = 'Spécifie le code motif qui est un code journal supplémentaire vous permettant de suivre l''écriture.';
        }
        modify(Unapplied)
        {
            ToolTipML = ENU = 'Specifies whether the entry has been unapplied (undone) from the Unapply Vendor Entries window by the entry no. shown in the Unapplied by Entry No. field.', FRA = 'Spécifie si l''écriture a été délettrée (annulée) dans la fenêtre Délettrer des écritures fournisseur par le numéro écriture indiqué dans le champ Non lettré par n° séquence.';
        }
        modify("Unapplied by Entry No.")
        {
            ToolTipML = ENU = 'Specifies the number of the correcting entry, if the original entry has been unapplied (undone) from the Unapply Vendor Entries window.', FRA = 'Spécifie le numéro de l''écriture de correction si l''écriture d''origine a été délettrée (annulée) à partir de la fenêtre Délettrer des écritures fournisseur.';
        }
        modify("Vendor Ledger Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number of the vendor ledger entry that the detailed vendor ledger entry line was created for.', FRA = 'Spécifie le numéro séquence de l''écriture comptable fournisseur pour laquelle la ligne écriture comptable fournisseur détaillée a été créée.';
        }
        modify("Entry No.")
        {
            ToolTipML = ENU = 'Specifies the entry number of the detailed vendor ledger entry.', FRA = 'Spécifie le numéro d''écriture comptable fournisseur détaillée.';
        }
        addafter("Vendor No.")
        {
            //BC UPGRADE PATHAA02-DIT>>
            // field(Name; TxtName)
            // {
            // }
            //<<BC UPGRADE PATHAA02-DIT<<
        }

        addafter("Unapplied by Entry No.")
        {

            //BC UPGRADE PATHAA02>>
            // field("Item Charge Type"; "Item Charge Type")
            // {
            //     Visible = false;
            // } 
            // field("Contract Type"; "Contract Type")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            // {
            //     Visible = false;
            // }
            // field("Service Contract No."; Rec."Service Contract No.")
            // {
            //     Visible = false;
            // }
            // field("Financial Contract No."; Rec."Financial Contract No.")
            // {
            //     Visible = false;
            // }
            // field("Contract Group Code"; Rec."Contract Group Code")
            // {
            //     Visible = false;
            // }
            //<<BC UPGRADE PATHAA02<<
        }

    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Unapply Entries")
        {
            CaptionML = ENU = 'Unapply Entries', FRA = 'Délettrer les écritures';
            ToolTipML = ENU = 'Unselect one or more ledger entries that you want to unapply this record.', FRA = 'Désélectionnez une ou plusieurs écritures comptables que vous ne souhaitez plus lettrer à cet enregistrement.';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.', FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';
        }
        addafter("&Navigate")
        {
            //HEI.01>>
            action("Detailed Vend. Ledg. Entry Add.")
            {
                Caption = 'Detailed Vend. Ledg. Entry Additional';
                RunObject = Page "Detail CVLedgerEntryAddit CBN";
                RunPageLink = "Detaile CV Ledger Entry No." = FIELD("Entry No."),
                              "Source Type" = CONST(Vendor);
                ApplicationArea = All;
                ToolTip = 'Executes the Detailed Vend. Ledg. Entry Additional action.';
            }
            //HEI.01<<
        }
    }

    var
    // TxtName: Text[80]; //BC UPGRADE PATHAA02-DIT - commented        


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //BC UPGRADE PATHAA02-DIT>>
    //trigger OnAfterGetRecord();
    // var
    //     lrecVendor: Record Vendor;
    //begin
    /*
    //<<FINXL8.00.001 BSA 15/06/2015 #79
    TxtName := '';
    if lrecVendor.GET("Vendor No.") then
      TxtName := lrecVendor.Name;
    //>>FINXL8.00.001 BSA 15/06/2015 #79
    */
    //end;
    //BC UPGRADE PATHAA02-DIT<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

