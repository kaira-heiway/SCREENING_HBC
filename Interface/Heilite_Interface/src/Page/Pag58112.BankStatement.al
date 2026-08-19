page 58112 "Bank Statement"
{
    // version BC

    // HEI.01 CHG2020184 IBM POENAB02 26.06.2019
    //   # New page for Bank Connectivity interface

    //Bc Upgrade YADAVM09 Old Id-50350.

    // BC UPGRADE PATELS08 >>
    // # Table name changed from Imported Bank Statements to Imported Bank Statements FND.
    // BC UPGRADE PATELS08 <<
    Caption = 'Imported Bank Statemtent';
    Editable = false;
    PageType = Document;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approve,Posting,Prepare,Invoice,Release,Request Approval,View',
                                 FRA = 'Nouveau,Traiter,Déclarer,Approuver,Valider,Préparer,Facturer,Lancer,Demander une approbation,Afficher';
    RefreshOnActivate = true;
    SourceTable = "Imported Bank Statements FND";
    ApplicationArea = All;//Bc Upgrade YADAVM09<<

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            FRA = 'Général';
                field("Bank Statement No."; Rec."Bank Statement No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies the number of the sales document. The field can be filled automatically or manually and can be set up to be invisible.',
                                FRA = 'Spécifie le numéro du document vente. Le champ peut être rempli automatiquement ou manuellement et être configuré pour être invisible.';
                    Visible = DocNoVisible;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Promoted;
                    NotBlank = true;
                    ShowMandatory = true;
                    ToolTipML = ENU = 'Specifies the name of the customer who will receive the products and be billed by default.',
                                FRA = 'Spécifie le nom du client qui recevra les produits et sera facturé par défaut.';

                    trigger OnValidate();
                    var
                        ApplicationAreaSetup: Record "Application Area Setup";
                    begin
                    end;
                }
                field(Processed; Rec.Processed)
                {
                    ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                }
                field("Processing Time"; Rec."Processing Time")
                {
                    ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                }
                field("Processed by User"; Rec."Processed by User")
                {
                    ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                }
                field("Reprocessed by User"; Rec."Reprocessed by User")
                {
                    ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                }
                field("File Imported"; Rec."File Imported")
                {
                    ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                    Caption = 'Statement No. Imported';
                }
                field("Bank Acc. Rec. Statement No."; Rec."Bank Acc. Rec. Statement No.")
                {
                    ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                }
                group(Statement)
                {

                    Caption = 'Statement';
                    field("Statement No."; Rec."Statement No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Serial No.';
                        Importance = Additional;
                        ToolTipML = ENU = 'Specifies the address where the customer is located.',
                                    FRA = 'Spécifie l''adresse où se trouve le client.';
                    }
                    field("Statement Date"; Rec."Statement Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        ToolTipML = ENU = 'Specifies additional address information.',
                                    FRA = 'Spécifie des informations d''adresse supplémentaires.';
                    }
                }
                field("Balance Last Statement"; Rec."Balance Last Statement")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the name of the person to contact at the customer.',
                                FRA = 'Spécifie le nom de la personne à contacter chez le client.';
                }
                field("Statement Ending Balance"; Rec."Statement Ending Balance")
                {
                    ApplicationArea = ALl;//Bc Upgrade YADAVM09<<
                }
            }
            part(BankStatementLines; "Bank Statement Subform")
            {
                ApplicationArea = Basic, Suite;
                Editable = Rec."Bank Statement No." <> '';
                Enabled = Rec."Bank Statement No." <> '';
                SubPageLink = "Statement No." = FIELD("Statement No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Process")
            {
                Caption = '&Process';
                Image = Transactions;
                action(Process)
                {
                    Caption = 'Process';
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ShortCutKey = 'F9';

                    trigger OnAction();
                    var
                        Handled: Boolean;
                    begin
                        Rec.Process;
                    end;
                }
                action(Reprocess)
                {
                    Caption = 'Reprocess';
                    Image = ExportToBank;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ShortCutKey = 'F9';

                    trigger OnAction();
                    var
                        Handled: Boolean;
                    begin
                        Rec.Reprocess;
                    end;
                }
            }
        }
    }


    var
        ApplicationAreaSetup: Record "Application Area Setup";
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        SalesCalcDiscountByType: Codeunit "Sales - Calc Discount By Type";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        ChangeExchangeRate: Page "Change Exchange Rate";
        NavigateAfterPost: Option "Posted Document","New Document",Nowhere;
        WorkDescription: Text;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        ExternalDocNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        PaymentServiceVisible: Boolean;
        PaymentServiceEnabled: Boolean;
        OpenPostedSalesInvQst: TextConst ENU = 'The invoice has been posted and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', FRA = 'La facture a été validée et déplacée dans la fenêtre Factures vente enregistrées.\\Souhaitez-vous ouvrir la facture enregistrée ?';
        CustomerSelected: Boolean;
        ShowQuoteNo: Boolean;
        JobQueuesUsed: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
        BillToOptions: Option "Default (Customer)","Another Customer";
        EmptyShipToCodeErr: TextConst ENU = 'The Code field can only be empty if you select Custom Address in the Ship-to field.', FRA = 'Le champ Code ne peut être vide que si vous sélectionnez Adresse personnalisée dans le champ Destinataire.';
        Text2014411: TextConst ENU = 'Do you want to cancel the approval request for %1 %2?', FRA = 'Souhaitez vous annuler la demande d''approbation du/de la %1 %2?';
        StdCustSalesCode: Record "Standard Customer Sales Code";
        Text2014412: TextConst ENU = 'Do you want to send the approval request for %1 %2?', FRA = 'Souhaitez vous envoyer la demande d''approbation du/de la %1 %2?';
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        SalesHistoryBtnVisible: Boolean;
        BillToCommentPictVisible: Boolean;
        BillToCommentBtnVisible: Boolean;
        SalesHistoryStnVisible: Boolean;
        recSalesSetup: Record "Sales & Receivables Setup";
        recGenJournalTemplate: Record "Gen. Journal Template";
        txtTemplateName: Text;
        blnJnlSelected: Boolean;
        //cduSingleInstaceFunctions: Codeunit "Single Instance Functions";//Bc Upgrade YADAVM09 Drink it objects<<
        //recFinXLSetup: Record "Finance XL Setup";
        DocSubtypeCode: Code[10];
        //docsubtypecodesetup: Record "Document Subtype Code Setup FND";//Bc Upgrade YADAVM09 Drink it objects<<
        CustTradingEndDate: Label 'The Posting Date exceeds the Trading End Date defined in Customer %1';
        CustForAccGr: Record Customer;
        SuppressPOSInterfaceEditable: Boolean;
}

