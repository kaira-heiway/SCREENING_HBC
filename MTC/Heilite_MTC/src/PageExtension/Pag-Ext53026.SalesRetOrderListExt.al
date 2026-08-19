pageextension 53026 SalesRetOrderListExt extends "Sales Return Order List"
{
    // version NAVW110.0.00.15052,FINXL14.00.15,DITW110.00.09,HEI.01
    // DITW15.00.00.24 DDR 07/10/2008 Added columns
    //                                   Status,"Duty Tax Type","Disc.Promo. Order Calculated",
    //                                   "Shipping Charge Per","Total Weight","Total Cubage",Distance,
    //                                   "Link Sales Document Type","Link Sales Document No."
    //   DITW15.00.00.25 DDR 21/10/2008 Deleted field2013722 Duty Tax Type
    //   DITW15.00.00.35 DDR 13/10/2009 Added columns "Building No."
    //   DITW15.00.00.38 DDR 17/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added columns
    //                                      "Customer Tax Registration No.","Fiscal Representative No.",
    //                                      "Customer Tax Warehouse Ref."
    //   DITW16.00.00.40 DDR 20/02/2012 DIT-715 #244
    //                                  Added shortcut (warehouse) fields
    //                                    Control1100079000 Shortcut Unit of Measure1 Code
    //                                    Control1100079001 Shortcut Unit of Measure2 Code
    //                                    Control1100079002 Shortcut Unit of Measure3 Code
    //                                  Added Standard Global Dimension Lookup (see from 53 as reference)
    //                       20/02/2012 DIT-715 #244 Added/Moved columns
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW18.00.06 DDR 02/03/2015 DIT-770 #1190 Added fields "Responsiblity Center","Physical Location Group Code"
    //   DITW18.00.07 AKH 19/02/2016 DIT-770 #1804 Added field "Sundry Customer"
    //   DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Add Action to Shipping Cost Page + Removed old Shipping Costs fields
    //   DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)
    //   DITW18.00.07 DDR 11/04/2016 DIT-770 #1488 Updated ShowShortcutUomValue function

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    //   HEI.01 FDD-AL-GAPLOG05 IBM NASTAA02 29.09.2017 # Unloading Note template for Algeria
    //     # New Action Button created to print the Unloading Note
    //   DITW111.00.13A MSF 09/05/2019 NRQ#109271 Disable DIT Discounts and or Promotions for a sales documents
    //                                 Added Field "Disable DIT Disc. Prom."
    //   HEI.01 FDD-SR_HT464_Ortec Interface IBM HORTOC01 30.05.2019 - #new fields added "Load No." & "Sequence No."
    //   DITW111.00.13A DDR 01/07/2019 NRQ#103938 Added visibility for Action Send Approval
    //   FINXL11.00 HBA 03/05/2018 NRQ#69018 : Added Action "Auto. Send IC Return Order"
    //   DITW111.00.13A NLAB 25/06/2019 NRQ#113801 : Merge NRQ#69018

    //   HEI.02 CHG2046145 IBM.GAVANM01 16.03.2020 # Sales Order Status Addition
    //     # New field added : 50051 - "Approval Status"
    //   FINXL14.00.15 MSF 13/05/2020 NRQ#117628 Enable /Disable AutoSend To IC
    //   HEI.03 CHG2065153 IBM KUMARN15 23.06.2020
    //     # Added field "Source System Identifier"
    //   HEI.04 FDD-HB899 - CHG2093015 IBM NASTAA02  19.01.2021 # LSR - Sales And Payments
    //     # Code added on "Create &Whse. Receipt" Action
    //*********************************//
    //BC UPGRADE SIVA 21/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 Added action. & Moved to "Load No." & "Sequence No." Inteface app.
    //2.HEI.02 Added Approval Status.
    //3.HEI.03 Added Source System Identifier.
    //4.HEI.04 Added code on before action of "Create &Whse. Receipt".
    layout
    {

        //Unsupported feature: CodeInsertion on ""Shortcut Dimension 1 Code"(Control 121)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        DimMgt.LookupDimValueCodeNoUpdate(1);
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Shortcut Dimension 2 Code"(Control 119)". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        DimMgt.LookupDimValueCodeNoUpdate(2);
        */
        //end;
        addafter("Sell-to Customer Name")
        {
            field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Sell-to Address"; Rec."Sell-to Address")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Sell-to Address 2"; Rec."Sell-to Address 2")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Sell-to Post Code")
        {
            field("Sell-to City"; Rec."Sell-to City")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = all;
                Visible = false;
            }
            // BC UPGRADE SIVA >> Drink IT field
            // field("Physical Location Group Code"; Rec."Physical Location Group Code")
            // {
            //     Visible = false;
            // }
            // BC UPGRADE SIVA << Drink IT field
        }
        addafter("Currency Code")
        {
            // BC UPGRADE SIVA >> In base layout already filed is existed 

            // field(Status; Rec.Status)
            // {
            // }
            // BC UPGRADE SIVA << In base layout already filed is existed 


            field("Approval Status"; Rec."Approval Status FND")
            {
                ApplicationArea = all;
                ToolTip = 'Approval Status';
            }
            // BC UPGRADE SIVA >> Drink IT Fields
            // field("Shipment status"; Rec."Shipment status")
            // {
            // }
            // field("Disc.Promo. Order Calculated"; Rec."Disc.Promo. Order Calculated")
            // {
            //     Visible = false;
            // }

            // field("Shipment Method Code"; Rec."Shipment Method Code")
            // {
            //     ApplicationArea = all;
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
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
            // BC UPGRADE SIVA << Drink IT Fields
        }
        addafter("Shipment Date")
        {
            // BC UPGRADE SIVA >> Drink IT fields 
            // field("Shipping Advice"; REC."Shipping Advice")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field(Distance; Rec.Distance)
            // {
            //     Visible = false;
            // }
            // field("Delivery Order"; Rec."Delivery Order")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Invoice Method"; Rec."Invoice Method")
            // {
            //     Visible = false;
            // }
            // field("Invoice Period"; Rec."Invoice Period")
            // {
            //     Visible = false;
            // }
            // field("Truck Code"; Rec."Truck Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Trailer Code"; Rec."Trailer Code")
            // {
            //     Visible = false;
            // }
            // field("Driver Code"; Rec."Driver Code")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Driver 2 Code"; Rec."Driver 2 Code")
            // {
            //     Visible = false;
            // }
            // field(Route; Rec.Route)
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Route Planning No."; Rec."Route Planning No.")
            // {
            //     Visible = false;
            // }
            // field("Shipping Charge Per"; Rec."Shipping Charge Per")
            // {
            //     Visible = false;
            // }
            // field("Picking Type"; Rec."Picking Type")
            // {
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
            // field("Total Weight (Base)"; Rec."Total Weight (Base)")
            // {
            //     Visible = false;
            // }
            // field("Total Weight"; Rec."Total Weight")
            // {
            //     Visible = false;
            // }
            // field("Total Cubage (Base)"; Rec."Total Cubage (Base)")
            // {
            //     Visible = false;
            // }
            // field("Total Cubage"; Rec."Total Cubage")
            // {
            //     Visible = false;
            // }
            // field("Total HL Cubage"; Rec."Total HL Cubage")
            // {
            //     Visible = false;
            // }
            // field("Total Eq. UOM Quantity"; Rec."Total Eq. UOM Quantity")
            // {
            //     Visible = false;
            // }

            // field("ShortcutQtyUomBase[1]"; ShortcutQtyUomBase[1])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassShortcutUom(1, 0);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomBase[2]"; ShortcutQtyUomBase[2])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassShortcutUom(2, 0);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomBase[3]"; ShortcutQtyUomBase[3])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassShortcutUom(3, 0);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-715 #244';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomOutstd[1]"; ShortcutQtyUomOutstd[1])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassShortcutUom(1, 1);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-770 #1488';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomOutstd[2]"; ShortcutQtyUomOutstd[2])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassShortcutUom(2, 1);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-770 #1488';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("ShortcutQtyUomOutstd[3]"; ShortcutQtyUomOutstd[3])
            // {
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassShortcutUom(3, 1);
            //     DecimalPlaces = 0 : 5;
            //     Description = 'DIT-770 #1488';
            //     Editable = false;
            //     Visible = false;
            // }
            // field("Link Sales Document Type"; Rec."Link Sales Document Type")
            // {
            //     Visible = false;
            // }
            // field("Link Sales Document No."; Rec."Link Sales Document No.")
            // {
            //     Visible = false;
            // }
            // field("Building No."; Rec."Building No.")
            // {
            //     Visible = false;
            // }
            // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
            // {
            //     Visible = false;
            // }
            // field("Customer Tax Registration No."; Rec."Customer Tax Registration No.")
            // {
            //     Description = 'DIT-715 #244';
            //     Visible = false;
            // }
            // field("Customer Tax Warehouse Ref."; Rec."Customer Tax Warehouse Ref.")
            // {
            //     Visible = false;
            // }
            // BC UPGRADE SIVA << Drink IT Fields
        }
        addafter("Job Queue Status")
        {
            // BC UPGRADE SIVA >> Drink IT fields 
            // field("Sundry Customer"; Rec."Sundry Customer")
            // {
            //     Editable = false;
            //     Visible = false;
            // }
            // BC UPGRADE SIVA << Drink IT fields
            field("Shipped Not Invoiced"; Rec."Shipped Not Invoiced")
            {
                ToolTip = 'Shipped Not Invoiced';
                ApplicationArea = all;

            }
            // BC UPGRADE SIVA >>Drink IT Field 
            // field("Disable DIT Disc. Prom."; Rec."Disable DIT Disc. Prom.")
            // {
            //     Visible = false;
            // }
            // BC UPGRADE SIVA << Drink IT Field 

            //BC UPGRADE SIVA << Moved to Interface app 
            // field("Load No."; Rec."Load No.")
            // {
            //     ApplicationArea = all;
            //     Description = 'HEI.01';
            //     Visible = false;
            // }
            // field("Sequence No."; Rec."Sequence No.")
            // {
            //     ApplicationArea = all;
            //     Description = 'HEI.01';
            //     Visible = false;
            // }
            //BC UPGRADE SIVA << Moved to Interface app 
            field("Source System Identifier"; Rec."Source System Identifier FND")
            {
                ApplicationArea = all;
                ToolTip = 'Source System Identifier';
            }
        }
        moveafter("Currency Code"; "Shipment Date")
    }
    actions
    {
        modify("&Return Order")
        {
            CaptionML = ENU = '&Return Order', FRA = '&Retour';
        }
        //BC UPGRADE SIVA >> Base appThe statistics action will be replaced with the SalesOrderStatistics action newer version
        // modify(Statistics)
        // {
        //     CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        // }
        //BC UPGRADE SIVA <<Base app
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
        modify("Return Receipts")
        {
            CaptionML = ENU = 'Return Receipts', FRA = 'Réceptions retour';
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
        modify("Whse. Receipt Lines")
        {
            CaptionML = ENU = 'Whse. Receipt Lines', FRA = 'Lignes réception entrep.';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify(Action7)
        {
            CaptionML = ENU = 'Release', FRA = 'Lancer';
        }
        modify(Release)
        {
            CaptionML = ENU = 'Re&lease', FRA = '&Lancer';
        }
        modify(Reopen)
        {
            CaptionML = ENU = 'Re&open', FRA = 'R&ouvrir';
            //ShortCutKey = Ctrl+F10;
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Get Posted Doc&ument Lines to Reverse")
        {
            CaptionML = ENU = 'Get Posted Doc&ument Lines to Reverse', FRA = 'Extraire lignes doc&ument enreg. à contrepasser';
        }
        modify("Send IC Return Order Cnfmn.")
        {
            CaptionML = ENU = 'Send IC Return Order Cnfmn.', FRA = 'Confirmation envoi retour IC';

            //Unsupported feature: Change Description on ""Send IC Return Order Cnfmn."(Action 1102601025)". Please convert manually.


            //Unsupported feature: Change Visible on ""Send IC Return Order Cnfmn."(Action 1102601025)". Please convert manually.

        }
        modify("Request Approval")
        {
            CaptionML = ENU = 'Request Approval', FRA = 'Approbation demande achat';
        }
        modify(SendApprovalRequest)
        {
            CaptionML = ENU = 'Send A&pproval Request', FRA = 'Envoyer demande d''a&pprobation';
            ToolTipML = ENU = 'Send an approval request.', FRA = 'Envoyez une demande d''approbation.';

            //Unsupported feature: Change Description on "SendApprovalRequest(Action 1102601019)". Please convert manually.


            //Unsupported feature: Change Visible on "SendApprovalRequest(Action 1102601019)". Please convert manually.

        }
        modify(CancelApprovalRequest)
        {
            CaptionML = ENU = 'Cancel Approval Re&quest', FRA = 'Annuler demande d''appro&bation';
            ToolTipML = ENU = 'Cancel the approval request.', FRA = 'Annulez la demande d''approbation.';
        }
        modify(Action8)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away/Pick', FRA = 'Créer prélèv./rangement stoc&k';
        }
        modify("Create &Whse. Receipt")
        {
            CaptionML = ENU = 'Create &Whse. Receipt', FRA = 'Créer &réception entrepôt';
            trigger OnBeforeAction()
            var
            begin
                //HEI.04>>
                IF SourceSystemIdentifierAPI.GET(Rec."Source System Identifier FND") THEN
                    IF SourceSystemIdentifierAPI."Automatic SO Posting" THEN
                        ERROR(CantModifyOrderErr, Rec."Source System Identifier FND");
                //HEI.04<<

            end;
        }
        modify("P&osting")
        {
            CaptionML = ENU = 'P&osting', FRA = '&Validation';
        }
        modify("Test Report")
        {
            CaptionML = ENU = 'Test Report', FRA = 'Impression test';
            ToolTipML = ENU = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.', FRA = 'Affichez une impression test afin que vous puissiez trouver et corriger toutes les erreurs avant de procéder à la validation effective de la feuille ou du document.';
        }
        modify(Post)
        {
            CaptionML = ENU = 'P&ost', FRA = '&Valider';
        }
        modify("Preview Posting")
        {
            CaptionML = ENU = 'Preview Posting', FRA = 'Aperçu compta.';
            ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.', FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';
        }
        modify("Post and &Print")
        {
            CaptionML = ENU = 'Post and &Print', FRA = 'Valider et i&mprimer';
        }
        modify("Post and Email")
        {
            CaptionML = ENU = 'Post and Email', FRA = 'Valider et envoyer par e-mail';
        }
        modify("Post &Batch")
        {
            CaptionML = ENU = 'Post &Batch', FRA = 'Valider par l&ot';
        }
        modify("Remove From Job Queue")
        {
            CaptionML = ENU = 'Remove From Job Queue', FRA = 'Supprimer de la file d''attente des travaux';
        }


        //Unsupported feature: CodeModification on ""Create &Whse. Receipt"(Action 1102601016).OnAction". Please convert manually.

        //trigger  Receipt"(Action 1102601016)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        GetSourceDocInbound.CreateFromSalesReturnOrder(Rec);
          */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
          //HEI.04>>
          if SourceSystemIdentifierAPI.GET("Source System Identifier") then
            if SourceSystemIdentifierAPI."Automatic SO Posting" then
              ERROR(CantModifyOrderErr,"Source System Identifier");
          //HEI.04<<
          GetSourceDocInbound.CreateFromSalesReturnOrder(Rec);
   
        */
        //end;
        addafter("Co&mments")
        {
            //BC UPGRADE SIVA >>Drink IT code
            // action("Shipping Costs")
            // {
            //     ApplicationArea =all;
            //     CaptionML = ENU = 'Shipping Costs',
            //                 FRA = 'Coûts transport';
            //     Image = Costs;
            //     RunObject = Page "Document Shipping Cost";
            //     RunPageLink = "Source Type" = CONST(36),
            //                   "Source No." = FIELD("No."),
            //                   "Sub Type" = FIELD("Document Type");
            // }
            //BC UPGRADE SIVA <<Drink IT code
        }
        addafter("&Print")
        {
            action(PrintUnloadingNote)
            {
                ToolTip = 'Print Unloading Note';
                ApplicationArea = all;
                CaptionML = ENU = 'Print Unloading Note',
                            FRA = 'Imprimer Bon de Depot';
                Enabled = UnloadingNoteVisible;
                Image = PrintReport;
                Visible = UnloadingNoteVisible;

                trigger OnAction();
                begin
                    //>>HEI.01
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUNMODAL(GeneralOpCoSetup."Unloading Note Report ID", true, false, Rec);
                    //<<HEI.01
                end;
            }
        }
        addafter("Send IC Return Order Cnfmn.")
        {
            //BC UPGRADE SIVA>> Drink IT code
            // action(AutoSendICReturnOrder)
            // {
            //     ToolTip ='Auto. Send IC Return Order';
            //     ApplicationArea =all;
            //     Caption = 'Auto. Send IC Return Order';
            //     Description = 'NRQ69018-FINXL14.00.15 MSF 13/05/2020 NRQ#117628';
            //     Image = Intercompany;
            //     Visible = NOT VisibleSendIC;

            //     trigger OnAction();
            //     begin
            //         //<<FINXL11.00 HBA 03/05/2018 NRQ#69018
            //         cduICWebservice.fctCopyICDocument(REC."Document Type", REC."No.", 'SALES');
            //         //>>FINXL11.00 HBA 03/05/2018 NRQ#69018
            //     end;
            // }
            //BC UPGRADE SIVA<< Drink IT code
        }
    }

    var
        SourceSystemIdentifierAPI: Record "Source Sys Identifier API FND";

    var
        DimMgt: Codeunit DimensionManagement;
        ShortcutQtyUomBase: array[3] of Decimal;
        ShortcutQtyUomOutstd: array[3] of Decimal;
        //cduICWebservice: Codeunit "IC Web Service"; //BC UPGRDE SIVA
        ReadyToPostQst: Label '%1 out of %2 selected return orders are ready for post. \Do you want to continue and post them?', Comment = '%1 - selected count, %2 - total count';
        SalesSetup: Record "Sales & Receivables Setup";
        VisibleSendApproval: Boolean;
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        UnloadingNoteVisible: Boolean;
        VisibleSendIC: Boolean;
        CantModifyOrderErr: Label 'You can not modify an Order sent by %1.';

    trigger OnAfterGetCurrRecord()
    begin
        //>>HEI.01
        IF GeneralOpCoSetup.GET() THEN
            IF GeneralOpCoSetup."Unloading Note Report ID" <> 0 THEN
                UnloadingNoteVisible := TRUE;
        //<<HEI.01
    end;
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
    // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244 - DITW18.00.07 DDR 11/04/2016 DIT-770 #1488
    ShowShortcutUomValue(ShortcutQtyUomBase,ShortcutQtyUomOutstd,2);
    // >>DITW16.00.00.40 DDR DIT-715 #244 - DITW18.00.07 DDR DIT-770 #1488
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;

    JobQueueActive := SalesSetup.JobQueueActive;

    CopySellToCustomerFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5

    //<<DITW111.00.13A DDR 01/07/2019 NRQ#103938
    SalesSetup.GET;
    VisibleSendApproval := not SalesSetup."Automatic Document Approval";
    //>>DITW111.00.13A DDR 01/07/2019 NRQ#103938
    */
    //end;


    //Unsupported feature: CodeModification on "SetControlAppearance(PROCEDURE 5)". Please convert manually.

    //procedure SetControlAppearance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

    CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3

    //>>HEI.01
    if GeneralOpCoSetup.GET() then
      if GeneralOpCoSetup."Unloading Note Report ID" <> 0 then
        UnloadingNoteVisible := true;
    //<<HEI.01
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

