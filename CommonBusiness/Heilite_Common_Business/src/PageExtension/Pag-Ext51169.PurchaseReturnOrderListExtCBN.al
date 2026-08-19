pageextension 51169 PurchaseReturnOrderListExtCBN extends "Purchase Return Order List"
{
    //     DITW16.00.00.40 11/01/2012 DIT-715 issue 197 RTC Upgrade
    //                                              Convert Control55 Print -> Menu
    //                                              Added 'Test AAD Document' menu into 'Print' button
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                     17/02/2012 DIT-715 #244 Added/Moved columns

    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 DDR 02/03/2015 DIT-770 #1191 Added fields "Responsiblity Center","Physical Location Group Code"
    // DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Vendor"
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Add Action to Shipping Cost Page + Removed old Shipping Costs fields

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4

    // HEI.01 RFC-CHG0249183 IBM.LS 18.01.2019
    //   # Added fields - "BRC Purchase Order" and "SRM Order No.".
    // DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                               Added Field "Disable DIT Disc. Prom."
    // FINXL11.00 HBA 03/05/2018 NRQ#69018 : Added Action "Auto. Send IC Return Order"
    // DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018
    // HEI.02 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # New Field added: "Fixed Asset Acquisition"
    // FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    // HEI.03 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Added New Fields - Zycus Order No.
    //                      - PO Transaction Interface Zycus
    //                      - Processed PO Transaction Zycus
    // HEI.04 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Added New Fields - Zycus GR UUID
    //                      - Zycus GR Cancel UUID
    //                      - GR Transaction Interface Zycus
    //                      - Processed GR Transaction Zycus
    //-------------------------------------------------------------------------------------------------------
    //BC Upgrade SHARMP16--- Commented Drink-IT fields
    //BC Upgrade SHARMP16--- Commented Interface related fields and shifted to Interface Ext.

    layout
    {
        addafter("No.")
        {
            // field(Status; Rec.Status)
            // {
            // }//BC Upgrade SHARMP16--- DRINK_IT field
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';
            }
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16--- DRINK_IT field
        }
        addafter("Currency Code")
        {
            // field("Disc.Promo. Order Calculated"; Rec."Disc.Promo. Order Calculated")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }//BC Upgrade SHARMP16--- DRINK_IT field
        }
        addafter("Expected Receipt Date")
        {
            // field("Payment Terms Code"; Rec."Payment Terms Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Due Date"; Rec."Due Date")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Payment Discount %"; Rec."Payment Discount %")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Payment Method Code"; Rec."Payment Method Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Shipment Method Code"; Rec."Shipment Method Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }//BC Upgrade SHARMP16--- DRINK_IT field
            // field("Requested Receipt Date"; Rec."Requested Receipt Date")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }//BC Upgrade SHARMP16--- DRINK_IT field
            //BC Upgrade SHARMP16 BEGIN<<--- DRINK_IT field
            // field("Shipping Agent Code"; Rec."Shipping Agent Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field(Distance; Rec.Distance)
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Shipping Charge Per"; Rec."Shipping Charge Per")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Maximum Weight"; Rec."Maximum Weight")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Maximum Cubage"; Rec."Maximum Cubage")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Total Weight"; Rec."Total Weight")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Total Cubage"; Rec."Total Cubage")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[1]"; Rec.ShortcutQtyUomValue[1])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(1);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[2]"; Rec.ShortcutQtyUomValue[2])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(2);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomValue[3]"; Rec.ShortcutQtyUomValue[3])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassUom(3);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Link Purch. Document Type"; Rec."Link Purch. Document Type")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Link Purch. Document No."; Rec."Link Purch. Document No.")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Vendor Tax Registration No."; Rec."Vendor Tax Registration No.")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Vendor Tax Warehouse Ref."; Rec."Vendor Tax Warehouse Ref.")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            //BC Upgrade SHARMP16 end>>--- DRINK_IT field
        }
        addafter("Job Queue Status")
        {
            // field("Sundry Vendor"; Rec."Sundry Vendor")
            // {
            //     Editable = false;
            //     Visible = false;
            // }//BC Upgrade SHARMP16--- DRINK_IT field
            field("BRC Purchase Order"; Rec."BRC Purchase Order FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the BRC Purchase Order field.';
            }
            // field("SRM Order No."; Rec."SRM Order No.")
            // {
            // }//BC upgrade SHARMP16-- Interface related fields.
            // field("Disable DIT Disc. Prom."; Rec."Disable DIT Disc. Prom.")
            // {
            //     Visible = false;
            // }//BC Upgrade SHARMP16--- DRINK_IT field
            field("Fixed Asset Acquisition"; Rec."Fixed Asset Acquisition FND")
            {
                Editable = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Asset Acquisition field.';
            }
            //BC Upgrade SHARMP16 BEGIN>>----- Interface related fields
            // field("PurchaseHeaderAdditional.""Zycus Order No."""; PurchaseHeaderAdditional."Zycus Order No.")
            // {
            //     Caption = 'Zycus Order No.';
            //     Visible = false;
            // }
            // field("PurchaseHeaderAdditional.""PO Transaction Interface Zycus"""; PurchaseHeaderAdditional."PO Transaction Interface Zycus")
            // {
            //     Caption = 'PO Transaction Interface Zycus';
            //     Visible = false;
            // }
            // field("PurchaseHeaderAdditional.""Processed PO Transaction Zycus"""; PurchaseHeaderAdditional."Processed PO Transaction Zycus")
            // {
            //     Caption = 'Processed PO Transaction Zycus';
            //     Visible = false;
            // }
            // field("PurchaseHeaderAdditional.""Zycus GR UUID"""; PurchaseHeaderAdditional."Zycus GR UUID")
            // {
            //     Caption = 'Zycus GR UUID';
            //     Visible = false;
            // }
            // field("PurchaseHeaderAdditional.""Zycus GR Cancel UUID"""; PurchaseHeaderAdditional."Zycus GR Cancel UUID")
            // {
            //     Caption = 'Zycus GR Cancel UUID';
            //     Visible = false;
            // }
            // field("PurchaseHeaderAdditional.""GR Transaction Interface Zycus"""; PurchaseHeaderAdditional."GR Transaction Interface Zycus")
            // {
            //     Caption = 'GR Transaction Interface Zycus';
            //     Visible = false;
            // }
            // field("PurchaseHeaderAdditional.""Processed GR Transaction Zycus"""; PurchaseHeaderAdditional."Processed GR Transaction Zycus")
            // {
            //     Caption = 'Processed GR Transaction Zycus';
            //     Visible = false;
            // }
            //BC Upgrade SHARMP16 end<<----- Interface related fields
        }
    }
    actions
    {
        modify("&Return Order")
        {
            CaptionML = ENU = '&Return Order', FRA = '&Retour';
        }

        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Approvals)
        {
            CaptionML = ENU = 'Approvals', FRA = 'Approbations';
            ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.', FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Documents)
        {
            CaptionML = ENU = 'Documents', FRA = 'Documents';
        }
        modify("Return Shipments")
        {
            CaptionML = ENU = 'Return Shipments', FRA = 'Expéditions retour';
        }
        modify("Cred&it Memos")
        {
            CaptionML = ENU = 'Cred&it Memos', FRA = 'A&voirs';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            CaptionML = ENU = 'In&vt. Put-away/Pick Lines', FRA = 'Lignes prélè&v./rangement stock';
        }

        modify(Print)
        {

            //Unsupported feature: Change ActionType on "Print(Action 55)". Please convert manually.


            //Unsupported feature: Change Name on "Print(Action 55)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }

        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';

        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Get Posted Doc&ument Lines to Reverse")
        {
            CaptionML = ENU = 'Get Posted Doc&ument Lines to Reverse', FRA = 'Extraire lignes doc&ument enreg. à contrepasser';
        }
        modify("Send IC Return Order")
        {
            CaptionML = ENU = 'Send IC Return Order', FRA = 'Envoyer retour IC';

            //Unsupported feature: Change Description on ""Send IC Return Order"(Action 1102601024)". Please convert manually.


            //Unsupported feature: Change Visible on ""Send IC Return Order"(Action 1102601024)". Please convert manually.

        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';
        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away/Pick', FRA = 'Créer prélèv./rangement stoc&k';
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify(TestReport)
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify(Preview)
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify(PostAndPrint)
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify(PostBatch)
        {
            CaptionML = ENU = 'Post &Batch', FRA = 'Valider par l&ot';
        }
        modify(RemoveFromJobQueue)
        {
            CaptionML = ENU = 'Remove From Job Queue', FRA = 'Supprimer de la file d''attente des travaux';
        }


        //Unsupported feature: PropertyDeletion on "Print(Action 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Print(Action 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Print(Action 55)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Print(Action 55)". Please convert manually.

        addafter("Co&mments")
        {
            // action("Shipping Costs")
            // {
            //     CaptionML = ENU = 'Shipping Costs',
            //                 FRA = 'Coûts transport';
            //     Image = Costs;
            //     RunObject = Page "Document Shipping Cost";
            //     RunPageLink = "Source Type" = CONST(38),
            //                   "Source No." = FIELD("No."),
            //                   "Sub Type" = FIELD("Document Type");
            // }//BC Upgrade SHARMP16--- DRINK_IT page used.
        }
        addafter("Send IC Return Order")
        {
            action(AutoSendICReturnOrder)
            {
                Caption = 'Auto. Send IC Return Order';
                Description = 'NRQ69018-FINXL14.00.15 MSF 13/05/2020 NRQ#117628';
                Image = Intercompany;
                ApplicationArea = All;
                ToolTip = 'Executes the Auto. Send IC Return Order action.';

                trigger OnAction();
                begin
                    //<<FINXL11.00 HBA 03/05/2018 NRQ#69018
                    // cduICWebservice.fctCopyICDocument("Document Type", "No.", 'PURCHASE');//BC Upgrade SHARMP16--- DRINK_IT code.
                    //>>FINXL11.00 HBA 03/05/2018 NRQ#69018
                end;
            }
        }
        addfirst("&Return Order")
        {
            // action("Order Confirmation")
            // {
            //     CaptionML = ENU = 'Order Confirmation',
            //                 FRA = 'Confirmation de commande';
            //     Ellipsis = true;
            //     Image = Print;

            //     trigger OnAction();
            //     begin
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         DocPrint.PrintPurchHeader(Rec);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //     end;
            // }//BC Upgrade SHARMP16--- DRINK_IT action
            // action("Test AAD Document")
            // {
            //     CaptionML = ENU = 'Test AAD Document',
            //                 FRA = 'Tester document AAD';
            //     Ellipsis = true;
            //     Image = Print;

            //     trigger OnAction();
            //     begin
            //         // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
            //         DocPrint.PrintPurchHeaderAAD(Rec);
            //         // >>DITW16.00.00.40 DDR DIT-715 #197
            //     end;
            // }//BC Upgrade SHARMP16--- DRINK_IT action
        }

    }

    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        VisibleSendIC: Boolean;
        // cduICWebservice: Codeunit "IC Web Service";
        ShortcutQtyUomValue: array[3] of Decimal;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetControlAppearance;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetControlAppearance;
    //<<FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    VisibleSendIC := not IsAutoSendDocEnabled ;
    //>>FINXL14.00.15 MSF 13/05/2020 NRQ#117628
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    ShowShortcutUomValue(ShortcutQtyUomValue);
    // >>DITW16.00.00.40 DDR DIT-715 #244
    //HEI.03>>
    if PurchaseHeaderAdditional.GET("Document Type","No.") then;
    //HEI.03<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

    //BC Upgrade SHARMP16 BEGIN>>
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //HEI.03>>
        IF PurchaseHeaderAdditional.GET(rec."Document Type", rec."No.") THEN;
        //HEI.03<<

    end;
    //BC Upgrade SHARMP16 end<<
}

