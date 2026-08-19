pageextension 51113 PurchaseAgentActivitiesExtCBN extends "Purchase Agent Activities"
{
    // version NAVW110.0,DITW110.00.08
    // DITW16.00.00.39 DDR 01/09/2011 DIT-715 #139 Added Stack "Document Approvals" Activities
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 RFC-CHG0249183 IBM.LS 22.04.2019
    // # Added new field - "To Send".
    // HEI.02 CHG2087586 IBM SHANKJ03 16.12.2020
    // # created new field Request to Approve


    layout
    {
        modify("Pre-arrival Follow-up on Purchase Orders")
        {
            CaptionML = ENU = 'Pre-arrival Follow-up on Purchase Orders', FRA = 'Suivi avant arrivée des commandes achat';
        }
        modify("To Send or Confirm")
        {
            ToolTipML = ENU = 'Specifies the number of documents to send or confirm that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.', FRA = 'Spécifie le nombre de documents d''expédition ou de confirmation qui sont affichés dans la pile Achat du tableau de bord. Les documents sont filtrés à la date du jour.';
        }
        modify("Upcoming Orders")
        {
            ToolTipML = ENU = 'Specifies the number of upcoming orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.', FRA = 'Spécifie le nombre de commandes à venir qui sont affichées dans la pile Achat du tableau de bord. Les documents sont filtrés à la date du jour.';
        }
        modify("Post Arrival Follow-up")
        {
            CaptionML = ENU = 'Post Arrival Follow-up', FRA = 'Suivi après arrivée';
        }
        modify(OutstandingOrders)
        {
            CaptionML = ENU = 'Outstanding Purchase Orders', FRA = 'Commandes achat ouvertes';
            ToolTipML = ENU = 'Specifies the number of outstanding purchase orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.', FRA = 'Spécifie le nombre de commandes achat ouvertes qui sont affichées dans la pile Achat du tableau de bord. Les documents sont filtrés à la date du jour.';
        }
        modify("Purchase Return Orders - All")
        {
            ToolTipML = ENU = 'Specifies the number of purchase return orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.', FRA = 'Spécifie le nombre de retours achat qui sont affichés dans la pile Achat du tableau de bord. Les documents sont filtrés à la date du jour.';
        }
        modify("Purchase Orders - Authorize for Payment")
        {
            CaptionML = ENU = 'Purchase Orders - Authorize for Payment', FRA = 'Commandes achat - Autorisation de paiement';
        }
        modify(NotInvoiced)
        {
            CaptionML = ENU = 'Not Invoiced', FRA = 'Non facturé';
            ToolTipML = ENU = 'Specifies the orders that are not invoiced that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.', FRA = 'Spécifie les commandes non facturées qui sont affichées dans la pile Achat du tableau de bord. Les documents sont filtrés à la date du jour.';
        }
        modify(PartiallyInvoiced)
        {
            CaptionML = ENU = 'Partially Invoiced', FRA = 'Partiellement facturé';
            ToolTipML = ENU = 'Specifies the number of partially invoiced orders that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.', FRA = 'Spécifie le nombre de commandes partiellement facturées qui sont affichées dans la pile Achat du tableau de bord. Les documents sont filtrés à la date du jour.';
        }
        addafter("To Send or Confirm")
        {
            //HEI.01 >>
            field("To Send"; Rec."To Send FND")
            {
                DrillDownPageID = "Purchase Order List";
                ToolTip = 'Specifies the number of documents to send that are displayed in the Purchase Cue on the Role Center. The documents are filtered by today''s date.';
                ApplicationArea = All;
            }
            //HEI.01 <<
            //HEI.02 >>
            field("Request to Approve"; Rec."Request to Approve FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Request to Approve field.';
                trigger OnDrillDown();
                begin
                    //HEI.02 >>
                    ApprovalEntryRec.RESET();
                    ApprovalEntryRec.SETFILTER("Approver ID", USERID);
                    ApprovalEntryRec.SETFILTER("Table ID", '38');
                    CLEAR(ApprovalEntryList);
                    ApprovalEntryList.SETRECORD(ApprovalEntryRec);
                    ApprovalEntryList.SETTABLEVIEW(ApprovalEntryRec);
                    ApprovalEntryList.LOOKUPMODE(true);
                    if ApprovalEntryList.RUNMODAL() = ACTION::LookupOK then;
                    //HEI.02 <<
                end;
            }
            //HEI.02 <<
        }
        addafter("Purchase Orders - Authorize for Payment")
        {
            //BC Upgrade Priya >> DrinkIT added Stack "Document Approvals".
            // cuegroup("Document Approvals")
            // {
            //     CaptionML = ENU='Document Approvals',
            //                 FRA='Approbations document';
            //     Description = 'DIT-715 #139';
            //     field("Purch. Approval Entries - Open";"Purch. Approval Entries - Open")
            //     {
            //         Description = 'DIT-715 #139';
            //         DrillDownPageID = "Approval Request Entries";
            //     }
            //     field("My Purch. Approval Entries";"My Purch. Approval Entries")
            //     {
            //         Description = 'DIT-715 #139';
            //         DrillDownPageID = "Approval Entries";
            //     }
            //     field("Delayed Approval Entries - All";"Delayed Approval Entries - All")
            //     {
            //         Description = 'DIT-715 #139';
            //         DrillDownPageID = "Approval Request Entries";
            //         Visible = false;
            //     }
            //     field("My Delayed Approval Entries";"My Delayed Approval Entries")
            //     {
            //         Description = 'DIT-715 #139';
            //         DrillDownPageID = "Approval Entries";
            //         Visible = false;
            //     }
            //     field("Period. Approval Entries - All";"Period. Approval Entries - All")
            //     {
            //         Description = 'DIT-715 #139';
            //         DrillDownPageID = "Approval Request Entries";
            //     }
            //     field("My Period. Approval Entries";"My Period. Approval Entries")
            //     {
            //         Description = 'DIT-715 #139';
            //         DrillDownPageID = "Approval Entries";
            //     } 

            // }  //BC Upgrade Priya << DrinkIT added Stack "Document Approvals".
        }
    }
    actions
    {
        //BC Upgrade Priya >> Name of Base field groups is modified. 
        /*       modify("New Purchase Quote")
              {
                  CaptionML = ENU = 'New Purchase Quote', FRA = 'Nouvelle demande de prix';
                  // ToolTipML = ENU='Create a new purchase quote.',FRA='Créez une demande de prix.';//BC Upgrade Priya << ToolTip is blocked because ToolTip is not same as base. 
              }
              modify("New Purchase Order")
              {
                  CaptionML = ENU = 'New Purchase Order', FRA = 'Nouvelle commande achat';
                  //  ToolTipML = ENU='Create a new purchase order.',FRA='Créez une commande achat.'; //BC Upgrade Priya << ToolTip is blocked because ToolTip is not same as base. 
              }
              modify("Edit Purchase Journal")
              {
                  CaptionML = ENU = 'Edit Purchase Journal', FRA = 'Modifier feuille achat';
              }
              // modify("""Post Arrival Follow-up""(Control 10).Navigate") 
              // {
              //     CaptionML = ENU='Navigate',FRA='Naviguer'; //BC Upgrade Priya << Caption and ToolTip is blocked because Caption and ToolTip is not same as base. 
              //     ToolTipML = ENU='View and link to all entries that exist for the document number on the selected line.',FRA='Affichez et créez un lien vers toutes les écritures qui existent pour le numéro de document sur la ligne sélectionnée.';
              // }
              modify("New Purchase Return Order")
              {
                  CaptionML = ENU = 'New Purchase Return Order', FRA = 'Nouveau retour achat';
                  // ToolTipML = ENU='Create a new purchase return order.',FRA='Créez un retour commande achat.';  //BC Upgrade Priya << ToolTip is blocked because ToolTip is not same as base. 
              } */
    }

    var
        ApprovalEntryRec: Record "Approval Entry";
        ApprovalEntryList: Page "Requests to Approve";


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    if not GET then begin
      INIT;
      INSERT;
    end;

    SetRespCenterFilter;
    SETFILTER("Date Filter",'>=%1',WORKDATE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    // <<DITW16.00.00.39 DDR 01/09/2011 DIT-715 #139
    SETRANGE("User ID Filter",USERID);
    // >>DITW16.00.00.39 DDR DIT-715 #139
    SETFILTER("Date Filter",'>=%1',WORKDATE);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

