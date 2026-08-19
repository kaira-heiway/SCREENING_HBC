page 51070 "Levy Posting Preview CBN"
{
    // version HEI.01

    // HEI.01 CHG2224401 HB3624 YADAVM09 06.02.2024 Health and Security Levy Tax
    //   # New Object created

    CaptionML = ENU = 'Posting Preview',
                FRA = 'Aperçu compta.';
    Editable = false;
    PageType = List;
    SourceTable = "Document Entry";
    SourceTableTemporary = true;
    ApplicationArea = All;  // BC Upgrade Manisha
    UsageCategory = Lists;  // BC Upgrade Manisha

    layout
    {
        area(content)
        {
            repeater(Control16)
            {
                field("Entry No."; rec."Entry No.")
                {
                    ToolTipML = ENU = 'Specifies the entry number. This field is intended only for internal use.',
                                FRA = 'Spécifie le numéro d''écriture. Ce champ est destiné à un usage interne uniquement.';
                    Visible = false;
                }
                field("Table ID"; rec."Table ID")
                {
                    ToolTipML = ENU = 'Specifies the ID. This field is intended only for internal use.',
                                FRA = 'Spécifie l''ID. Ce champ est destiné à un usage interne uniquement.';
                    Visible = false;
                }
                field("Table Name"; rec."Table Name")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Related Entries',
                                FRA = 'Écritures associées';
                    ToolTipML = ENU = 'Specifies the name of the table where the Navigate facility has found entries with the selected document number and/or posting date.',
                                FRA = 'Spécifie le nom de la table dans laquelle la fonction Naviguer a détecté des écritures portant le numéro et/ou la date comptabilisation du document sélectionné.';
                }
                field("No. of Records"; rec."No. of Records")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'No. of Entries',
                                FRA = 'Nbre écritures';
                    DrillDown = true;
                    ToolTipML = ENU = 'Specifies the number of documents that the Navigate facility has found in the table with the selected entries.',
                                FRA = 'Spécifie le nombre de documents trouvés par la fonction Naviguer dans la table et comprenant les écritures sélectionnées.';

                    trigger OnDrillDown();
                    begin
                        PostingPreviewEventHandler.ShowEntries(rec."Table ID");
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Process)
            {
                CaptionML = ENU = 'Process',
                            FRA = 'Processus';
                action(Show)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = '&Show Related Entries',
                                FRA = '&Afficher écritures associées';
                    Image = ViewDocumentLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunPageMode = View;
                    ToolTipML = ENU = 'Show details about other entries that are related to the general ledger posting.',
                                FRA = 'Affichez les détails concernant d''autres entrées qui sont en relation avec la validation en comptabilité.';

                    trigger OnAction();
                    begin
                        PostingPreviewEventHandler.ShowEntries(rec."Table ID");
                    end;
                }
            }
        }
    }

    var
        PostingPreviewEventHandler: Codeunit "Posting Preview Event Handler";

    procedure Set(var TempDocumentEntry: Record "Document Entry" temporary; NewPostingPreviewEventHandler: Codeunit "Posting Preview Event Handler");
    begin
        PostingPreviewEventHandler := NewPostingPreviewEventHandler;
        if TempDocumentEntry.findset() then
            repeat
                Rec := TempDocumentEntry;
                rec.INSERT();
            until TempDocumentEntry.NEXT() = 0;
    end;
}

