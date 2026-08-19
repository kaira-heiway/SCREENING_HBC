page 52001 "BRC Bottle recycle Center Card"
{
    // BC Upgrade Kamnay01 Original(Heilite) page id 50239

    // version HEI.01

    // 
    // HEI.01 PTPGAP066 IBM SOICAD01 29.06.2017 Purchase to Pay– Bank account for payment
    //   # New field Vendor Bank Account
    // 
    // HEI.02 HLSRM02-05 IBM LAZARE02 31.07.2017
    //   #New fields for SRM integration added to SRM tab
    // 
    // HEI.03 FDD-PTPGAP007 IBM PATHAA02 28.08.2017
    // # Made property "Show mandatory" to True for the field "Vendor Bank Account"
    // 
    // HEI.04 FDD-PURGAPINT005 IBM NASTAA02 28.09.2017 # Purchase Order Layout Template Procurement
    //   # Print button should be enabled just when "SRM Order No." is empty
    // 
    // HEI.05 FDD-PTPGAP067 IBM Isyed01
    //   # added code to update document sub type for PO if we are printing prepayment invoice and prepayment redit memo.
    // 
    // HEI.06 HLSRM03 IBM LAZARE02 11.12.2017
    //   # New action Get Blanket Order Price
    // HEI.07  FDD-AL-PTPGAP02 IBM HORTOC01 16.05.2018 - new subpage
    // HEI.08 defect #2234 IBM POSTOI01 05.06.2018
    //   #new code OnOpenPage, new variable DocSubtypeEditable, change property Editable on Document Subtype Code field
    // HEI.09 SoicaD Filtering by doc subtype
    // HEI.10 RFC-CHG0249183 IBM.LS 04.10.2018
    //   # Added code to call SendEmailPurchaseOrder function.
    // HEI.11 RFC-CHG0246348 IBM.AB 08.10.2018
    //   # Field Reason Code added
    //   # Code added to make Reason Code mandatory
    // 
    // HEI.12 FDD-BA-PURGAP03- Bottle Recycling Centre - V2.6 IBM NAIKH01 16.10.2018
    //   # Created a new Page Copy of Page 50 - Purchase Order
    //   # Added new Field "BRC Purchase Order"
    // HEI.13 FDD-HT594 IBM NASTAA02 30.09.2019 # La Reunion FA Requirements Vendor
    //   # Made Field "Vendor Posting Group" non-editable
    //*****************************************************************************************

    //BC UPGRADE PATHAA02-30.10.25
    //1. Dependency with Page 50120-Purchase Order Subform SRM(Manisha-Done)
    //2. StatusOnValidate(commented-DIT)
    //3.SRM related fields found.

    // BC Upgrade MISHRS14 >>
    // Blocked 'OpenPurchaseOrderStatistics' in 'Statistics' action as it is marked for removal.
    // In action Statistics 'Rec.OpenPurchaseOrderStatistics()' is marked for removal. Thus instead directly running page using runobject.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade SHUKLP03 >> Added document subtype code.

    CaptionML = ENU = 'BRC Bottle recycle Center Card',
                FRA = 'Commande achat';
    PageType = Document;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Approve,Release,Posting,Prepare,Invoice,Request Approval,Print',
                                 FRA = 'Nouveau,Traiter,Déclarer,Approuver,Lancer,Comptabilisation,Préparer,Facturer,Demander une approbation,Imprimer';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            FRA = 'Général';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies the number of a general ledger account, item, additional cost, or fixed asset, depending on what you selected in the Type field.',
                                FRA = 'Spécifie le numéro d''un compte général, d''un article, d''un coût supplémentaire ou d''une immobilisation, selon la sélection effectuée dans le champ Type.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit();
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    QuickEntry = true;
                    ToolTip = 'Specifies the number of the vendor you buy from.';

                    trigger OnValidate();
                    begin

                        //>>HEI.12
                        GeneralOpCoSetup.GET();
                        GeneralOpCoSetup.TESTFIELD("Local Vendor Type");

                        if Vendor.GET(Rec."Buy-from Vendor No.") then;

                        if Vendor."Local Vendor Type FND" <> GeneralOpCoSetup."Local Vendor Type" then
                            ERROR(Err001, Rec."Buy-from Vendor No.", GeneralOpCoSetup."Local Vendor Type");
                        //<<HEI.12

                        //BC UPGRADE PATHAA02>>
                        // //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                        // if "Sundry Vendor" then
                        //   ShowVendorSundryInfo();
                        // //>> DITW18.00.07 AKH DIT-770 #1804
                        //BC UPGRADE PATHAA02<<

                        if Rec.GETFILTER(Rec."Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
                            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                                Rec.SETRANGE(Rec."Buy-from Vendor No.");

                        CurrPage.UPDATE();

                        //BC UPGRADE PATHAA02>>
                        // // <<DITW15.00.00.39 DDR 27/04/2011 #1323 (BE5.00.01)
                        // COMMIT;
                        // StdVendPurchCode.AutoInsertPurchLines(Rec);
                        // // >>DITW15.00.00.39 DDR #1323 (BE5.00.01)
                        //BC UPGRADE PATHAA02<<
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Vendor',
                                FRA = 'Fournisseur';
                    Importance = Promoted;
                    QuickEntry = false;
                    ShowMandatory = true;
                    ToolTipML = ENU = 'Specifies detailed information about the vendor on the selected purchase document.',
                                FRA = 'Spécifie des informations détaillées concernant le fournisseur sur le document achat sélectionné.';

                    trigger OnValidate();
                    begin
                        if Rec.GETFILTER(Rec."Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
                            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                                Rec.SETRANGE(Rec."Buy-from Vendor No.");

                        //<<HEI.12
                        GeneralOpCoSetup.GET();
                        GeneralOpCoSetup.TESTFIELD("Local Vendor Type");

                        if Vendor.GET(Rec."Buy-from Vendor No.") then;

                        if Vendor."Local Vendor Type FND" <> GeneralOpCoSetup."Local Vendor Type" then
                            ERROR(Err001, Rec."Buy-from Vendor No.", GeneralOpCoSetup."Local Vendor Type");
                        //>>HEI.12

                        CurrPage.UPDATE();
                    end;
                }
                group("Buy-from")
                {
                    CaptionML = ENU = 'Buy-from',
                                FRA = 'Fournisseur';
                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Address',
                                    FRA = 'Adresse';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTipML = ENU = 'Specifies the vendor''s buy-from address.',
                                    FRA = 'Spécifie l''adresse fournisseur du fournisseur.';
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Address 2',
                                    FRA = 'Adresse (2ème ligne)';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTipML = ENU = 'Specifies an additional part of the vendor''s buy-from address.',
                                    FRA = 'Spécifie un complément à l''adresse fournisseur du fournisseur.';
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Post Code',
                                    FRA = 'Code postal';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the postal code of the address.';
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'City',
                                    FRA = 'Ville';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the vendor who ships the items.';
                    }
                    field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                    {
                        CaptionML = ENU = 'Country/Region',
                                    FRA = 'Pays/région';
                        Importance = Additional;
                        ToolTip = 'Specifies the country/region code of the address.';
                    }
                    field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                    {
                        CaptionML = ENU = 'Contact No.',
                                    FRA = 'N° contact';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the number of your contact at the vendor.';
                    }
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Contact',
                                FRA = 'Contact';
                    QuickEntry = false;
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Suite;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the date of the vendor''s invoice.',
                                FRA = 'Spécifie la date de la facture du fournisseur.';
                }
                // field("Tax Date"; Rec."Tax Date")
                // {
                //     Importance = Additional;
                //     QuickEntry = false;
                // } //BC UPGRADE PATHAA02-DIT F2013733

                //BC UPGRADE PATHAA02 DIT fields>>
                // group(Control1100710018)
                // {
                //     field(RouteNew; Rec.Route)
                //     {
                //         Description = '<DITW18.00.07 DIT-770 #1968 - DITW19.00.08 BL#11231>--NRQ#16082';
                //         QuickEntry = true;
                //         ShowMandatory = RouteAsMandatory;

                //         trigger OnDrillDown();
                //         begin
                //             //FIXME<<DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                //             DrillDownRouteCombinaison;
                //             // >>DITW18.00.06 MSF 17/06/2015 DIT-770 #1212 #1213 #1214
                //         end;
                //     }
                //     field(RoutePlanningNew; "Route Planning No.")
                //     {
                //         Editable = false;
                //     }
                // }

                // field("Multiple Order Route"; "Multiple Order Route")
                // {
                //     Editable = false;
                // }
                // field("Vendor Tax Registration No."; "Vendor Tax Registration No.")
                // {
                //     Description = 'DITW15.00.00.28,DITW19.00.08 BL#10387';
                //     Editable = EditableVendorTax;
                // }
                // field("Vendor Tax Warehouse Ref."; "Vendor Tax Warehouse Ref.")
                // {
                //     Description = 'DITW15.00.00.38 #1217,DITW19.00.08 BL#10387';
                //     Editable = EditableVendorTax;
                // }
                //BC UPGRADE PATHAA02 DIT fields<<

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the posting date of the record.',
                                FRA = 'Spécifie la date comptabilisation de l''enregistrement.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies when the purchase invoice is due for payment.',
                                FRA = 'Spécifie la date à laquelle la facture achat doit être payée.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ShowMandatory = VendorInvoiceNoMandatory;
                    ToolTipML = ENU = 'Specifies the vendor''s own invoice number.',
                                FRA = 'Spécifie le numéro de facture propre au fournisseur.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = true;
                    ToolTipML = ENU = 'Specifies which purchaser is associated with the order.',
                                FRA = 'Spécifie l''acheteur associé à la commande.';

                    trigger OnValidate();
                    begin
                        PurchaserCodeOnAfterValidate();
                    end;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the number of archived versions for this document.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Suite;
                    Description = 'NRQ#16082';
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.',
                                FRA = 'Spécifie la date à laquelle les articles doivent être disponibles dans l''entrepôt. Si vous laissez ce champ vide, le calcul est effectué comme suit : Date planifiée de réception + Délai de sécurité + Délai enlogement + Date réception prévue.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address. The value in the field is used to calculate the latest date you can order the items to have them delivered on the requested receipt date. If you do not need delivery on a specific date, you can leave the field blank.';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    Description = 'FINXL7.00.001';
                    ToolTip = 'Specifies the vendor''s reference.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTipML = ENU = 'Specifies the date when the item is ordered. It is calculated backwards from the Planned Receipt Date field in combination with the Lead Time Calculation field.',
                                FRA = 'Spécifie la date de commande de l''article. Elle est calculée en amont à partir du champ Date planifiée de réception et du champ Délai de réappro.';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    CaptionML = ENU = 'Purchase Quote No.',
                                FRA = 'N° devis ventes';
                    Description = 'DITW17.00.02 DIT-770 #144';
                    Importance = Additional;
                    ToolTip = 'Specifies the quote number for the purchase order.';
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    QuickEntry = true;
                    ToolTipML = ENU = 'Specifies the vendor''s order number.',
                                FRA = 'Spécifie le numéro de commande du fournisseur.';
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ShowMandatory = VendorShipmentNoMandatory;
                    ToolTip = 'Specifies the vendor''s shipment number. It is inserted in the corresponding field on the source document during posting.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the order address code linked to the relevant vendor''s order address.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the responsibility center that is associated with the user, company, or vendor.';

                    trigger OnValidate();
                    begin
                        //BC UPGRADE PATHAA02>>
                        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        // if Rec."Responsibility Center" <> xRec."Responsibility Center" then
                        //     CurrPage.UPDATE(true);
                        // // >>DITW18.00.06 DDR DIT-770 #1191
                        //BC UPGRADE PATHAA02<<
                    end;
                }
                //BC UPGRADE PATHAA02-DIT Field>>
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     Description = '<DITW18.00.06 DIT-770 #1191>-NRQ#16082';
                //     Editable = EditableMultipleRouteOrder;
                //     Importance = Additional;
                //     QuickEntry = false;

                //     trigger OnValidate();
                //     begin
                //         // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                //         if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                //             CurrPage.UPDATE(true);
                //         // >>DITW18.00.06 DDR DIT-770 #1191
                //     end;
                // } 
                //BC UPGRADE PATHAA02-DIT Field<<
                field(LocationCodeNew; Rec."Location Code")
                {
                    Description = 'NRQ#16082';
                    QuickEntry = false;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';

                    trigger OnValidate();
                    begin

                        //<<HEI.12
                        GeneralOpCoSetup.GET();
                        GeneralOpCoSetup.TESTFIELD("BRC Location Code");

                        if Rec."Location Code" <> GeneralOpCoSetup."BRC Location Code" then
                            MESSAGE(Text001, GeneralOpCoSetup."BRC Location Code");

                        Rec."Location Code" := GeneralOpCoSetup."BRC Location Code";
                        //>>HEI.12

                        //BC UPGRADE PATHAA02>>
                        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        // if Rec."Location Code" <> xRec."Location Code" then
                        //     CurrPage.UPDATE(true);
                        // // >>DITW18.00.06 DDR DIT-770 #1191
                        //BC UPGRADE PATHAA02<<
                    end;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                // field("Requester ID"; Rec."Requester ID")
                // {
                //     Description = 'DITW17.00.02 DIT-770 #144';
                // } //BC UPGRADE PATHAA02-DIT F2014430
                field(Status; Rec.Status)
                {
                    Description = 'DITW17.00.02 DIT-770 #170';
                    Importance = Promoted;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';

                    trigger OnValidate();
                    begin
                        StatusOnValidate();
                        StatusOnAfterValidate();
                    end;
                }

                //BC UPGRADE PATHAA02-DIT field>>
                // field("Creation Date/Time"; "Creation Date/Time")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // } //DIT-F2014411

                // field("Created By"; "Created By")
                // {
                //     Description = 'DITW18.00.07 DIT-770 #1282';
                //     Importance = Additional;
                // } //DIT-2014412
                //BC UPGRADE PATHAA02-DIT field<<

                //BC UPGRADE PATHAA02>>
                // field("Document Shipping Costs"; HasDocumentShippingCosts)
                // {
                //     CaptionML = ENU = 'Document Shipping Costs',
                //                 FRA = 'Document Frais livraison';

                //     trigger OnDrillDown();
                //     begin
                //         //BC UPGRADE PATHAA02>>
                //         // //<< DITW18.00.07 VSC 22/03/2016 DIT-770 #1066
                //         // OpenDocumentShippingCosts;
                //         // //>> DITW18.00.07 VSC DIT-770 #1066
                //         //BC UPGRADE PATHAA02<<
                //     end;
                // } //BC UPGRADE PATHAA02-DIT Fucntion on T38-HasDocumentShippingCosts-DIT

                //BC UPGRADE PATHAA02-DIT fields>>
                // field("Emergency Order"; Rec."Emergency Order")
                // {
                // }

                // field("Last changed User ID"; "Last changed User ID")
                // {
                //     Editable = false;
                // }

                // field("Last changed Date/time"; "Last changed Date/time")
                // {
                //     Editable = false;
                // }
                // field("Linked Customer No."; "Linked Customer No.")
                // {
                //     Importance = Additional;
                // }
                //BC UPGRADE PATHAA02<<

                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = JobQueueUsed;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                }
                //BC UPGRADE PATHAA02>>
                // field("Vendor DTax Group Code"; "Vendor DTax Group Code")
                // {
                //     Importance = Additional;
                // }
                // field("Receipt Status"; "Receipt Status")
                // {
                //     Description = 'DITW18.00.07 #1968';
                // }//BC UPGRADE PATHAA02<<

                field("Reason Code"; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the document.';
                }
                field("BRC Purchase Order"; Rec."BRC Purchase Order FND")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the BRC Purchase Order field.';
                }
            }
            part(PurchLines; "BRC Bottle Recycle Subform")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                Visible = NOT ShowSRMSubpage;
            }
            part(Control55005; "Purchase Order Subform SRM CBN")
            {
                ApplicationArea = Suite;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
                Visible = ShowSRMSubpage;
            }
            group("Invoice Details")
            {
                CaptionML = ENU = 'Invoice Details',
                            FRA = 'Détails facture';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies the currency of amounts on the purchase document.',
                                FRA = 'Spécifie la devise des montants sur le document achat.';

                    trigger OnAssistEdit();
                    begin
                        CLEAR(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WORKDATE());
                        if ChangeExchangeRate.RUNMODAL() = ACTION::OK then begin
                            Rec.VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.UPDATE();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate();
                    begin
                        CurrPage.UPDATE();
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies whether the unit price on the line should be displayed including or excluding VAT.',
                                FRA = 'Spécifie si le prix unitaire de la ligne doit être affiché TTC ou hors taxes.';

                    trigger OnValidate();
                    begin
                        PricesIncludingVATOnAfterValid();
                    end;
                }
                field("WHT Business Posting Group"; Rec."WHT Business Posting Group FND")
                {
                    ToolTip = 'Specifies the value of the WHT Business Posting Group field.';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Suite;
                    ToolTipML = ENU = 'Specifies which VAT business posting group was used when the VAT entry was posted.',
                                FRA = 'Spécifie le groupe comptabilisation marché TVA utilisé lorsque l''écriture TVA a été validée.';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    Editable = false;
                    ToolTip = 'Specifies the vendor''s market type to link business transactions to.';
                }
                // field("Sundry Vendor"; Rec."Sundry Vendor")
                // {
                // }//BC UPGRADE PATHAA02-DIT
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTipML = ENU = 'Specifies the code that represents the payment terms that apply to the purchase order.',
                                FRA = 'Spécifie le code qui représente les conditions de paiement qui s''appliquent à la commande achat.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies how payment for the purchase document must be submitted.',
                                FRA = 'Spécifie la manière dont le paiement du document achat doit être réalisé.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the number for the transaction type, for the purpose of reporting to INTRASTAT.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2.';

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies the last date on which the amount in the purchase order must be paid for the order to qualify for a payment discount.',
                                FRA = 'Spécifie la dernière date à laquelle le montant de la commande achat doit être payé pour que la commande puisse faire l''objet d''un escompte.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';

                    trigger OnValidate();
                    begin
                        // // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
                        // if Rec."Location Code" <> xRec."Location Code" then
                        //     CurrPage.UPDATE(true);
                        // // >>DITW18.00.06 DDR DIT-770 #1191 //BC UPGRADE PATHAA02-DIT
                    end;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Description = 'NRQ#16082';
                    Editable = EditableMultipleRouteOrder;
                    ToolTip = 'Specifies the code that represents the shipment method for this purchase.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ToolTip = 'Identifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ToolTip = 'Identifies the vendor who sent the purchase invoice.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Specifies if the posted invoice will be included in the payment suggestion.';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Importance = Additional;
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTipML = ENU = 'Specifies the number of the customer that the items are shipped to directly from your vendor, as a drop shipment.',
                                FRA = 'Spécifie le numéro du client à qui les articles sont livrés directement par votre fournisseur, en tant que livraison directe.';
                }
            }
            group("Shipping and Payment")
            {
                CaptionML = ENU = 'Shipping and Payment',
                            FRA = 'Expédition et paiement';
                group("Ship-to")
                {
                    CaptionML = ENU = 'Ship-to',
                                FRA = 'Destinataire';
                    field("Ship-to Code"; Rec."Ship-to Code")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Code',
                                    FRA = 'Code';
                        ToolTip = 'Specifies a ship-to code if you want a different shipment address from the one that has been automatically entered.';
                    }
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Name',
                                    FRA = 'Nom';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the company at the address to which you want the items to be shipped.';
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Address',
                                    FRA = 'Adresse';
                        Importance = Additional;
                        ToolTipML = ENU = 'Specifies the vendor''s buy-from address.',
                                    FRA = 'Spécifie l''adresse fournisseur du fournisseur.';
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Address 2',
                                    FRA = 'Adresse (2ème ligne)';
                        Importance = Additional;
                        ToolTipML = ENU = 'Specifies an additional part of the vendor''s buy-from address.',
                                    FRA = 'Spécifie un complément à l''adresse fournisseur du fournisseur.';
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Post Code',
                                    FRA = 'Code postal';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code of the address.';
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'City',
                                    FRA = 'Ville';
                        Importance = Additional;
                        ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
                    }
                    field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                    {
                        CaptionML = ENU = 'Country/Region',
                                    FRA = 'Pays/région';
                        Importance = Additional;
                        ToolTip = 'Specifies the country/region code of the address.';
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Contact',
                                    FRA = 'Contact';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of a contact person for the address where the items should be shipped.';
                    }
                }
                //BC UPGRADE PATHAA02-DIT fields>>
                // field("Fiscal Representative No."; Rec."Fiscal Representative No.")
                // {
                // }
                // field("Tax Office Code"; Rec."Tax Office Code")
                // {
                // }
                // field("Journey Time"; Rec."Journey Time")
                // {
                // }
                // field("Whse. Receipt No. (First)"; Rec."Whse. Receipt No. (First)")
                // {
                //     Lookup = false;
                // }
                // field("Whse. Receipt Status (First)"; Rec."Whse. Receipt Status (First)")
                // {
                //     DrillDown = false;
                //     Lookup = false;
                // }
                //BC UPGRADE PATHAA02-DIT fields<<
                group("Pay-to")
                {
                    CaptionML = ENU = 'Pay-to',
                                FRA = 'Paiement';
                    field("Pay-to Name"; Rec."Pay-to Name")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Name',
                                    FRA = 'Nom';
                        Importance = Promoted;
                        ToolTip = 'Specifies the name of the vendor sending the invoice.';
                    }
                    field("Pay-to Address"; Rec."Pay-to Address")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Address',
                                    FRA = 'Adresse';
                        Importance = Additional;
                        ToolTipML = ENU = 'Specifies the vendor''s buy-from address.',
                                    FRA = 'Spécifie l''adresse fournisseur du fournisseur.';
                    }
                    field("Pay-to Address 2"; Rec."Pay-to Address 2")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Address 2',
                                    FRA = 'Adresse (2ème ligne)';
                        Importance = Additional;
                        ToolTipML = ENU = 'Specifies an additional part of the vendor''s buy-from address.',
                                    FRA = 'Spécifie un complément à l''adresse fournisseur du fournisseur.';
                    }
                    field("Pay-to Post Code"; Rec."Pay-to Post Code")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Post Code',
                                    FRA = 'Code postal';
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code of the address.';
                    }
                    field("Pay-to City"; Rec."Pay-to City")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'City',
                                    FRA = 'Ville';
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the vendor sending the invoice.';
                    }
                    field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                    {
                        CaptionML = ENU = 'Country/Region',
                                    FRA = 'Pays/région';
                        Importance = Additional;
                        ToolTip = 'Specifies the country/region code of the address.';
                    }
                    field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                    {
                        CaptionML = ENU = 'Contact No.',
                                    FRA = 'N° contact';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact who sends the invoice.';
                    }
                    field("Pay-to Contact"; Rec."Pay-to Contact")
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Contact',
                                    FRA = 'Contact';
                        Importance = Additional;
                        ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    }
                    field("Vendor Bank Account"; Rec."Vendor Bank Account FND")
                    {
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Vendor Bank Account field.';
                    }
                    field(IBAN; Rec."IBAN FND")
                    {
                        ToolTip = 'Specifies the value of the IBAN field.';
                    }
                }
            }
            group("Foreign Trade")
            {
                CaptionML = ENU = 'Foreign Trade',
                            FRA = 'International';
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies a code for the purchase header''s transaction specification here.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the code for the transport method to be used with this purchase header.';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region.';
                }
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Specifies the code for the area of the vendor''s address.';
                }
            }
            group(Prepayment)
            {
                CaptionML = ENU = 'Prepayment',
                            FRA = 'Acompte';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for purchase.';

                    trigger OnValidate();
                    begin
                        Prepayment37OnAfterValidate();
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ToolTip = 'Specifies that prepayments on the purchase order are combined if they have the same general ledger account for prepayments or the same dimensions.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the purchase document.';
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies when the prepayment invoice for this purchase order is due.';
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted on the prepayment if the vendor pays on or before the date entered in the Prepmt. Pmt. Discount Date field.';
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the last date the vendor can pay the prepayment invoice and still receive a payment discount on the prepayment amount.';
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ToolTip = 'Specifies the number that the vendor uses for the credit memo you are creating in this purchase credit memo header.';
                }
                field("Document Subtype Code"; Rec."Document Subtype Code FND")
                {
                    ApplicationArea = All;
                } //BC UPGRADE SHUKLP03
            }

            //BC UPGRADE PATHAA02-DIT fields>>
            // group(Receiving)
            // {
            //     CaptionML = ENU = 'Receiving',
            //                 FRA = 'Recéption';
            //     field(Route; Rec.Route)
            //     {
            //         Description = '<DITW18.00.07 DIT-770 #1968 - DITW19.00.08 BL#11231>-NRQ#16082';

            //         trigger OnDrillDown();
            //         begin
            //             //<< DITW18.00.07 VSC 09/05/2016 DIT-770 #1968
            //             DrillDownRouteCombinaison;
            //         end;
            //     }
            //     field("Route Planning No."; Rec."Route Planning No.")
            //     {
            //         Editable = false;
            //     }
            //     field("Shipping Agent Code"; Rec."Shipping Agent Code")
            //     {
            //         Description = '<DITW15.00.00.21 - DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214>-NRQ#16082';
            //         Editable = EditableMultipleRouteOrder;

            //         trigger OnValidate();
            //         begin
            //             //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //             if xRec."Shipping Agent Code" <> Rec."Shipping Agent Code" then
            //                 CurrPage.UPDATE
            //             //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         end;
            //     }
            //     field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
            //     {
            //         Description = '<DITW15.00.00.21>-NRQ#16082';
            //         Editable = EditableMultipleRouteOrder;
            //     }
            //     field("Copy Shipment Method Code"; Rec."Shipment Method Code")
            //     {
            //         Description = '-NRQ#16082';
            //         Editable = EditableMultipleRouteOrder;
            //     }
            //     field(Distance; Rec.Distance)
            //     {
            //         Description = '<DITW15.00.00.24>--NRQ#16082';
            //     }
            //     field("Truck Code"; Rec."Truck Code")
            //     {
            //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
            //         Editable = EditableMultipleRouteOrder;

            //         trigger OnValidate();
            //         begin
            //             //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //             if xRec."Truck Code" <> Rec."Truck Code" then
            //                 CurrPage.UPDATE
            //             //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         end;
            //     }
            //     field("Trailer Code"; Rec."Trailer Code")
            //     {
            //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
            //         Editable = EditableMultipleRouteOrder;
            //     }
            //     field("Driver Code"; Rec."Driver Code")
            //     {
            //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
            //         Editable = EditableMultipleRouteOrder;

            //         trigger OnValidate();
            //         begin
            //             //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //             if xRec."Truck Code" <> Rec."Truck Code" then
            //                 CurrPage.UPDATE
            //             //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
            //         end;
            //     }
            //     field("Truck Zone"; Rec."Truck Zone")
            //     {
            //         Description = 'DITW18.00.07 #1968-NRQ#16082';
            //     }
            //     // field("Require 2 Drivers"; Rec."Require 2 Drivers")
            //     // {
            //     //     Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
            //     //     Editable = EditableMultipleRouteOrder;
            //     // }
            //     field("Driver 2 Code"; Rec."Driver 2 Code")
            //     {
            //         Description = '<DITW18.00.07 DIT-770 #1968>-NRQ#16082';
            //         Editable = EditableMultipleRouteOrder;
            //     }
            //     field("Delivery Sequence"; Rec."Delivery Sequence")
            //     {
            //         Description = 'DITW18.00.07 #1968';
            //     }
            //     field("Maximum Weight"; Rec."Maximum Weight")
            //     {
            //         Editable = false;
            //         Style = Strong;
            //         StyleExpr = "Maximum WeightEmphasize";
            //         Visible = "Maximum WeightVisible";
            //     }
            //     field("Maximum Cubage"; Rec."Maximum Cubage")
            //     {
            //         Editable = false;
            //         Style = Strong;
            //         StyleExpr = "Maximum CubageEmphasize";
            //         Visible = "Maximum CubageVisible";
            //     }
            //     field("Total Weight"; Rec."Total Weight")
            //     {
            //         Editable = false;
            //     }
            //     field("Total Cubage"; Rec."Total Cubage")
            //     {
            //         Editable = false;
            //     }
            //     field("Delivery Time 1 From"; Rec."Delivery Time 1 From")
            //     {
            //     }
            //     field("Delivery Time 1 To"; Rec."Delivery Time 1 To")
            //     {
            //     }
            //     field("Delivery Time 2 From"; Rec."Delivery Time 2 From")
            //     {
            //     }
            //     field("Delivery Time 2 To"; Rec."Delivery Time 2 To")
            //     {
            //     }
            //     field("Vendor Delivery Type"; Rec."Vendor Delivery Type")
            //     {
            //     }
            //     field("Delivery Time (sec.)"; Rec."Delivery Time (sec.)")
            //     {
            //     }
            // }

            // group("Service/Contract")
            // {
            //     CaptionML = ENU = 'Service/Contract',
            //                 FRA = 'Service/ Contrat';
            //     field("Contract Type"; Rec."Contract Type")
            //     {
            //         Editable = false;
            //     }
            //     field("DIT Sub-Contract Type"; Rec."DIT Sub-Contract Type")
            //     {
            //     }
            //     field("Service Contract No."; Rec."Service Contract No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Financial Contract No."; Rec."Financial Contract No.")
            //     {
            //         Visible = false;
            //     }
            //     field("Contract Group Code"; Rec."Contract Group Code")
            //     {
            //     }
            // } 
            //BC UPGRADE PATHAA02-DIT fields>>
            group(Maximo)
            {
                Caption = 'Maximo';
                field("Maximo Requisition No."; Rec."Maximo Requisition No. FND")
                {
                    ToolTip = 'Specifies the value of the Maximo Requisition No. field.';
                }
            }
            group(SRM)
            {
                Caption = 'SRM';
                field("SRM Contract No."; Rec."SRM Contract No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract No. field.';
                }
                field("SRM Contract Name"; Rec."SRM Contract Name FND")
                {
                    ToolTip = 'Specifies the value of the SRM Contract Name field.';
                }
                field("SRM Contract Type"; Rec."SRM Contract Type FND")
                {
                    ToolTip = 'Specifies the value of the Contract Type field.';
                }
                field("Valid From"; Rec."Valid From FND")
                {
                    ToolTip = 'Specifies the value of the Valid From field.';
                }
                field("Valid To"; Rec."Valid To FND")
                {
                    ToolTip = 'Specifies the value of the Valid To field.';
                }
                field("Shipment Method Location"; Rec."Shipment Method Location FND")
                {
                    ToolTip = 'Specifies the value of the Shipment Method Location field.';
                }
                field(Channel; Rec."Channel FND")
                {
                    ToolTip = 'Specifies the value of the Channel field.';
                }
                field(Closed; Rec."Closed FND")
                {
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("SRM Order No."; Rec."SRM Order No. FND")
                {
                    ToolTip = 'Specifies the value of the SRM Order No. field.';
                }
                field("Target Value Currency"; Rec."Target Value Currency FND")
                {
                    ToolTip = 'Specifies the value of the Target Value Currency field.';
                }
                field("Target Value Amount"; Rec."Target Value Amount FND")
                {
                    ToolTip = 'Specifies the value of the Target Value Amount field.';
                }
            }
        }
        area(factboxes)
        {
            part(Control23; "Pending Approval FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1903326807; "Item Replenishment FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            // part(Control1907232107; "Purchase Line FactBox2")
            // {
            //     Provider = PurchLines;
            //     SubPageLink = "Document Type" = FIELD("Document Type"),
            //                   "Document No." = FIELD("Document No."),
            //                   "Line No." = FIELD("Line No.");
            //     Visible = true;
            // } //BC UPGRADE PATHAA02-DIT-P2035460
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
                Visible = false;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part(Control3; "Purchase Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                CaptionML = ENU = 'O&rder',
                            FRA = '&Commande';
                Image = "Order";
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Dimensions',
                                FRA = 'Axes analytiques';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.',
                                FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SAVERECORD();
                    end;
                }
                action(Statistics)
                {
                    CaptionML = ENU = 'Statistics',
                                FRA = 'Statistiques';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    // BC Upgrade MISHRS14 >>
                    // In action Statistics 'Rec.OpenPurchaseOrderStatistics()' is marked for removal. Thus instead directly running page using runobject.
                    RunObject = Page "Purchase Order Statistics";
                    RunPageOnRec = true;
                    // BC Upgrade MISHRS14 <<

                    trigger OnAction();
                    begin

                        // BC Upgrade MISHRS14 >>
                        // Blocked 'OpenPurchaseOrderStatistics' as it is marked for removal.
                        //Rec.OpenPurchaseOrderStatistics();
                        // BC Upgrade MISHRS14 <<

                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Card',
                                FRA = 'Fiche';
                    Image = EditLines;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTipML = ENU = 'View or change detailed information about the vendor.',
                                FRA = 'Affichez ou modifiez des informations détaillées sur le fournisseur.';
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Approvals',
                                FRA = 'Approbations';
                    Image = Approvals;
                    ToolTipML = ENU = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.',
                                FRA = 'Affichez une liste des enregistrements en attente d''approbation. Par exemple, vous pouvez voir qui a demandé l''approbation de l''enregistrement, quand il a été envoyé et quand son approbation est due.';

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //BC UPGRADE PATHAA02-Changing to new Function>>
                        //ApprovalEntries.Setfilters(DATABASE::"Purchase Header", "Document Type", "No.");
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        //BC UPGRADE PATHAA02-Changing to new Function<<
                        ApprovalEntries.RUN();

                    end;
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                FRA = 'Co&mmentaires';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'Executes the Co&mments action.';
                }
                // action("Shipping Costs")
                // {
                //     CaptionML = ENU = 'Shipping Costs',
                //                 FRA = 'Coûts transport';
                //     Image = Costs;
                //     RunObject = Page "Document Shipping Cost";
                //     RunPageLink = "Source Type" = CONST(38),
                //                   "Source No." = FIELD("No."),
                //                   "Sub Type" = FIELD("Document Type");
                // } //BC UPGRADE PATHAA02-DIT Page2014096
            }
            group(Documents)
            {
                CaptionML = ENU = 'Documents',
                            FRA = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Receipts',
                                FRA = 'Bons de réception';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'Executes the Receipts action.';
                }
                action(Invoices)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Invoices',
                                FRA = 'Factures';
                    Image = Invoice;
                    Promoted = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'Executes the Invoices action.';
                }
                action(PostedPrepaymentInvoices)
                {
                    CaptionML = ENU = 'Prepa&yment Invoices',
                                FRA = 'Factures acom&pte';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'Executes the PostedPrepaymentInvoices action.';
                }
                action(PostedPrepaymentCrMemos)
                {
                    CaptionML = ENU = 'Prepayment Credi&t Memos',
                                FRA = 'A&voirs acompte';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ToolTip = 'Executes the PostedPrepaymentCrMemos action.';
                }
            }
            group(Warehouse)
            {
                CaptionML = ENU = 'Warehouse',
                            FRA = 'Entrepôt';
                Image = Warehouse;
                separator(Separator181)
                {
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    CaptionML = ENU = 'In&vt. Put-away/Pick Lines',
                                FRA = 'Lignes prélè&v./rangement stock';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Purchase Order"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ToolTip = 'Executes the In&vt. Put-away/Pick Lines action.';
                }
                // action("Quote Approvals")
                // {
                //     CaptionML = ENU = 'Quote Approvals',
                //                 FRA = 'Approbations devis';

                //     trigger OnAction();
                //     var
                //         ApprovalEntries: Page "Approval Entries";
                //     begin

                //         // //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144
                //         // ApprovalEntries.Setfilters(DATABASE::"Purchase Header", "Document Type"::Quote, "Quote No.");
                //         // ApprovalEntries.RUN;
                //         // //>>DITW17.00.02 TEC1 DIT-770 #144

                //     end;
                // }  //BC UPGRADE PATHAA02 -DIT code on Action
                action("Ret&urn Orders")
                {
                    CaptionML = ENU = 'Ret&urn Orders',
                                FRA = 'Re&tours';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Order List";
                    ToolTip = 'Executes the Ret&urn Orders action.';
                    // RunPageLink = "Link Purch. Document Type" = FIELD("Document Type"),
                    //               "Link Purch. Document No." = FIELD("No.");
                    //BC UPGRADE PATHAA02 -links are DIT Fields-F2013613,2013614
                }
                action("R&eturn Shipments")
                {
                    CaptionML = ENU = 'R&eturn Shipments',
                                FRA = 'Expédition R&etour';
                    Image = ReturnShipment;
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Executes the R&eturn Shipments action.';
                    // RunPageLink = "Link Purch. Document No." = FIELD("No.");
                    // BC UPGRADE PATHAA02 -link is DIT Field-2013614
                }
                action("Whse. Receipt Lines")
                {
                    CaptionML = ENU = 'Whse. Receipt Lines',
                                FRA = 'Lignes réception entrep.';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39),
                                  "Source Subtype" = FIELD("Document Type"),
                                  "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ToolTip = 'Executes the Whse. Receipt Lines action.';
                }
                separator(Separator182)
                {
                }
                group("Dr&op Shipment")
                {
                    CaptionML = ENU = 'Dr&op Shipment',
                                FRA = 'Livraison &directe';
                    Image = Delivery;
                    action(Warehouse_GetSalesOrder)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Get &Sales Order',
                                    FRA = 'Ex&traire commande vente';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ToolTipML = ENU = 'Select the sales order that must be linked to the purchase order, for drop shipment. ',
                                    FRA = 'Sélectionnez la commande vente à associer à la commande achat pour une livraison directe. ';
                    }
                }
                group("Speci&al Order")
                {
                    CaptionML = ENU = 'Speci&al Order',
                                FRA = 'C&ommande spéciale';
                    Image = SpecialOrder;
                    action("Get &Sales Order")
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        CaptionML = ENU = 'Get &Sales Order',
                                    FRA = 'Ex&traire commande vente';
                        Image = "Order";
                        ToolTip = 'Executes the Get &Sales Order action.';

                        trigger OnAction();
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                separator(Separator1161021000)
                {
                }

                // action("<Action1161021001>")
                // {
                //     CaptionML = ENU = 'Show N-owm activities',
                //                 FRA = 'Visualiser Activitées N-owm';
                //     Image = NewResource;

                //     trigger OnAction();
                //     var
                //         owmUtils: Codeunit "N-owm Utils";
                //     begin
                //         owmUtils.ShowActivityStatus(owmUtils.ActPutAway, Rec."No.", '');  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                //     end;
                // } //BC UPGRADE PATHAA02-CU6062406
            }
        }
        area(processing)
        {
            group(Approval)
            {
                CaptionML = ENU = 'Approval',
                            FRA = 'Approbation';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Approve',
                                FRA = 'Approuver';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTipML = ENU = 'Approve the requested changes.',
                                FRA = 'Approuvez les modifications demandées.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Reject',
                                FRA = 'Rejeter';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Reject action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Delegate',
                                FRA = 'Déléguer';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Delegate action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Comments',
                                FRA = 'Commentaires';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Comment action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(ActionGroup13)
            {
                CaptionML = ENU = 'Release',
                            FRA = 'Lancer';
                Image = ReleaseDoc;
                separator(Separator73)
                {
                }
                action(Release)
                {
                    CaptionML = ENU = 'Re&lease',
                                FRA = '&Lancer';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Release action.';

                    trigger OnAction();
                    var
                        PurchasesPayablesSetupL: Record "Purchases & Payables Setup";
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //>>HEI:CHG0246348:1:1 08/10/18 IBM.AB
                        /*PurchHdrArch.RESET;
                        PurchHdrArch.SETRANGE(PurchHdrArch."Document Type","Document Type");
                        PurchHdrArch.SETRANGE(PurchHdrArch."No.","No.");
                        IF PurchHdrArch.FINDFIRST AND ("Reason Code" = '') THEN
                        */
                        if Rec."Reason Code" = '' then
                            ERROR(ReasonCodeErr);
                        //<<HEI:CHG0246348:1:1 08/10/18 IBM.AB
                        // <<DITW15.00.00.23.04 DDR 15/09/2008 - DITW15.00.00.36 DDR 07/12/2009
                        CurrPage.UPDATE(true);
                        // >>DITW15.00.00.23.04 DDR
                        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                        //ReleasePurchDoc.PerformManualRelease(Rec);
                        //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804 
                        // BC UPGRADE PATHAA02-DIT Code>>                    
                        // if "Sundry Vendor" then
                        //     TestSundryMandatoryFields();
                        // //>> DITW18.00.07 DIT-770 #1804                        
                        // ReleasePurchDoc.DocStatusRelease(xRec, Rec); 
                        //BC UPGRADE PATHAA02-DIT Code<<
                        CurrPage.UPDATE();

                        // >>DITW15.00.00.39 DDR #1330 #1407

                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Re&open',
                                FRA = 'R&ouvrir';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ShortCutKey = 'Ctrl+F10';
                    ToolTipML = ENU = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed',
                                FRA = 'Rouvrez le document pour le modifier après son approbation. Les documents approuvés ont le statut Lancé et doivent être ouverts pour pouvoir être modifiés.';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin

                        // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
                        //ReleasePurchDoc.PerformManualReopen(Rec);
                        // ReleasePurchDoc.DocStatusOpen(xRec, Rec); //BC UPGRADE PATHAA02-DIT Code>>
                        CurrPage.UPDATE();
                        // >>DITW15.00.00.39 DDR #1330 #1407
                    end;
                }
                separator(Separator611)
                {
                }
            }
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            FRA = 'Fonction&s';
                Image = "Action";
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Calculate &Invoice Discount',
                                FRA = 'C&alculer remise facture';
                    Image = CalculateInvoiceDiscount;
                    ToolTipML = ENU = 'Calculate the discount that can be granted based on all lines in the purchase document.',
                                FRA = 'Calculez la remise qui peut être accordée en fonction de toutes les lignes du document achat.';

                    trigger OnAction();
                    begin
                        ApproveCalcInvDisc();
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                // action("Change Sundry vendor fields")
                // {
                //     CaptionML = ENU = 'Change Sundry vendor fields',
                //                 FRA = 'Modifier champs fournisseurs divers';
                //     Image = ChangeCustomer;
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     //Visible = "Sundry Vendor"; //BC UPGRADE PATHAA02-DIT

                //     trigger OnAction();
                //     begin
                //         //<< DITW18.00.07 AKH 11/02/2016 DIT-770 #1804
                //         ShowVendorSundryInfo();
                //         //>> DITW18.00.07 DIT-770 #1804
                //         //<< DITW18.00.07 AKH 19/02/2016 DIT-770 #1804
                //         CurrPage.UPDATE(true);
                //         //>> DITW18.00.07 DIT-770 #1804
                //     end;
                // } //BC UPGRADE PATHAA02-DIT(T38-FShowVendorSundryInfo)
                separator(Separator190)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Get St&d. Vend. Purchase Codes',
                                FRA = 'Extraire codes &achat fourn. std';
                    Ellipsis = true;
                    Image = VendorCode;
                    ToolTip = 'Executes the Get St&d. Vend. Purchase Codes action.';

                    trigger OnAction();
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Separator75)
                {
                }
                action(CopyDocument)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Copy Document',
                                FRA = 'Copier document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the CopyDocument action.';

                    trigger OnAction();
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL();
                        CLEAR(CopyPurchDoc);
                        if Rec.GET(Rec."Document Type", Rec."No.") then;
                    end;
                }
                action(MoveNegativeLines)
                {
                    CaptionML = ENU = 'Move Negative Lines',
                                FRA = 'Déplacer lignes négatives';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ToolTip = 'Executes the MoveNegativeLines action.';

                    trigger OnAction();
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL();
                        MoveNegPurchLines.ShowDocument();
                    end;
                }
                // action("Cre&ate Return Order")
                // {
                //     CaptionML = ENU = 'Cre&ate Return Order',
                //                 FRA = 'Créer commande retour';
                //     Image = ReturnOrder;
                //     ShortCutKey = 'Shift+F3';

                //     trigger OnAction();
                //     begin
                //         // <<DITW15.00.00.01 DDR 27/02/2008
                //         CODEUNIT.RUN(CODEUNIT::"Purch Ord. to Ret.Shpt. (Y/N)", Rec);

                //         if not FIND('=><') then
                //             INIT;
                //         // >>DITW15.00.00.01 DDR
                //     end;
                // } //BC UPGRADE PATHAA02-DIT Code(CU2013611)
                action(GetBlanketOrderPrice)
                {
                    Caption = 'Get Blanket Order Price';
                    Image = Price;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Get Blanket Order Price action.';

                    trigger OnAction();
                    begin
                        //HEI.06>>
                        if CONFIRM(GetBlanketOrderPriceQst) then
                            Rec.GetBlanketOrderPrice();
                        //HEI.06<<
                    end;
                }
                separator(Separator1100083000)
                {
                }
                group(ActionGroup225)
                {
                    CaptionML = ENU = 'Dr&op Shipment',
                                FRA = 'Livrais&on directe';
                    Image = Delivery;
                    action(Functions_GetSalesOrder)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Get &Sales Order',
                                    FRA = 'Ex&traire commande vente';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ToolTipML = ENU = 'Select the sales order that must be linked to the purchase order, for drop shipment. ',
                                    FRA = 'Sélectionnez la commande vente à associer à la commande achat pour une livraison directe. ';
                    }
                }
                group(ActionGroup186)
                {
                    CaptionML = ENU = 'Speci&al Order',
                                FRA = 'C&ommande spéciale';
                    Image = SpecialOrder;
                    action(Action187)
                    {
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        CaptionML = ENU = 'Get &Sales Order',
                                    FRA = 'Ex&traire commande vente';
                        Image = "Order";
                        ToolTip = 'Executes the Action187 action.';

                        trigger OnAction();
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                action("Archive Document")
                {
                    CaptionML = ENU = 'Archi&ve Document',
                                FRA = 'Archi&ver document';
                    Image = Archive;
                    ToolTip = 'Executes the Archive Document action.';

                    trigger OnAction();
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Send IC Purchase Order")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    CaptionML = ENU = 'Send IC Purchase Order',
                                FRA = 'Envoyer commande achat IC';
                    Image = IntercompanyOrder;
                    ToolTip = 'Executes the Send IC Purchase Order action.';

                    trigger OnAction();
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                            ICInOutboxMgt.SendPurchDoc(Rec, false);
                    end;
                }
                separator(Separator189)
                {
                }
                // action("Register Route Shipment entries")
                // {
                //     CaptionML = ENU = 'Register Route Shipment entries',
                //                 FRA = 'Registre route écritures éxpéditions';
                //     Image = Register;
                //     RunObject = Page "Route Register Entries";
                //     RunPageLink = "Route Planning No." = FIELD("Route Planning No."),
                //                   "Source Type" = CONST(36),
                //                   "Source Subtype" = FIELD("Document Type"),
                //                   "Source No." = FIELD("No.");
                // } //BC UPGRADE PATHAA02-DIT Page2014088
                group(IncomingDocument)
                {
                    CaptionML = ENU = 'Incoming Document',
                                FRA = 'Document entrant';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'View Incoming Document',
                                    FRA = 'Afficher le document entrant';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        ToolTipML = ENU = 'View any incoming document records and file attachments that exist for the entry or document, for example for auditing purposes',
                                    FRA = 'Affichez tous les fichiers joints et tous les enregistrements de document entrant qui existent pour l''écriture ou le document, par exemple à des fins d''audit.';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData "Incoming Document" = R;
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Select Incoming Document',
                                    FRA = 'Sélectionner le document entrant';
                        Image = SelectLineToApply;
                        ToolTipML =;

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            Rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RECORDID));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Create Incoming Document from File',
                                    FRA = 'Créer un document entrant à partir d''un fichier';
                        Ellipsis = true;
                        Enabled = CreateIncomingDocumentEnabled;
                        Image = Attach;
                        ToolTipML = ENU = 'Create an incoming document from a file that you select from the disk. The file will be attached to the incoming document record.',
                                    FRA = 'Créez un document entrant à partir d''un fichier que vous sélectionnez sur le disque. Le fichier sera joint à l''enregistrement de document entrant.';

                        trigger OnAction();
                        var
                            IncomingDocumentAttachment: Record "Incoming Document Attachment";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = Suite;
                        CaptionML = ENU = 'Remove Incoming Document',
                                    FRA = 'Supprimer le document entrant';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        ToolTipML =;

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            if IncomingDocument.GET(Rec."Incoming Document Entry No.") then
                                IncomingDocument.RemoveLinkToRelatedRecord();
                            Rec."Incoming Document Entry No." := 0;
                            Rec.MODIFY(true);
                        end;
                    }
                }
            }
            group("Request Approval")
            {
                CaptionML = ENU = 'Request Approval',
                            FRA = 'Approbation demande achat';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Send A&pproval Request',
                                FRA = 'Envoyer demande d''a&pprobation';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Executes the SendApprovalRequest action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //>>HEI:CHG0246348:1:1 08/10/18 IBM.AB
                        PurchHdrArch.RESET();
                        PurchHdrArch.SETRANGE(PurchHdrArch."Document Type", Rec."Document Type");
                        PurchHdrArch.SETRANGE(PurchHdrArch."No.", Rec."No.");
                        if PurchHdrArch.FINDFIRST() and (Rec."Reason Code" = '') then
                            ERROR(ReasonCodeErr);
                        //<<HEI:CHG0246348:1:1 08/10/18 IBM.AB
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Cancel Approval Re&quest',
                                FRA = 'Annuler demande d''appro&bation';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Cancel the approval request.',
                                FRA = 'Annulez la demande d''approbation.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group(ActionGroup17)
            {
                CaptionML = ENU = 'Warehouse',
                            FRA = 'Entrepôt';
                Image = Warehouse;
                action("Create &Whse. Receipt")
                {
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    CaptionML = ENU = 'Create &Whse. Receipt',
                                FRA = 'Créer &réception entrepôt';
                    Image = NewReceipt;
                    ToolTip = 'Executes the Create &Whse. Receipt action.';

                    trigger OnAction();
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        PurchSetup: Record "Purchases & Payables Setup";
                    begin
                        //BC UPGRADE PATHAA02>>
                        // <<DITW19.00.07 MVN 25/01/2016 DIT-770 #1740 Upgrade: Variables
                        // <<DITW15.00.00.34 DDR 16/06/2009
                        // PurchSetup.GET();
                        // if PurchSetup."Auto.Release Document on Whse." then begin
                        //     // <<DITW15.00.00.39 DDR 27/07/2011 #1407
                        //     ReleasePurchDoc.DocStatusRelease(xRec, Rec);
                        //     // >>DITW15.00.00.39 DDR #1407
                        //     if (xRec.Status <> Status) and (Status = Status::Released) then
                        //         MESSAGE(Text2014410, "Document Type", "No.");
                        // end;
                        // // >>DITW15.00.00.34 DDR
                        // // >>DITW19.00.07 MVN DIT-770 #1740
                        //BC UPGRADE PATHAA02-DIT<<
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    CaptionML = ENU = 'Create Inventor&y Put-away/Pick',
                                FRA = 'Créer prélèv./rangement stoc&k';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Executes the Create Inventor&y Put-away/Pick action.';

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();

                        if not Rec.FIND('=><') then
                            Rec.INIT();
                    end;
                }
                separator(Separator74)
                {
                }
            }
            group("P&osting")
            {
                CaptionML = ENU = 'P&osting',
                            FRA = '&Validation';
                Image = Post;
                action("P&ost")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'P&ost',
                                FRA = '&Valider';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Executes the P&ost action.';

                    trigger OnAction();
                    begin
                        //BC UPGRADE PATHAA02-DIT Code>>
                        // // <<DITW15.00.00.25 DDR 20/10/2008
                        // CurrPage.UPDATE;
                        // // >>DITW15.00.00.25 DDR 
                        //BC UPGRADE PATHAA02-DIT Code-if required uncomment<<
                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Preview Posting',
                                FRA = 'Aperçu compta.';
                    Image = ViewPostedOrder;
                    ToolTipML = ENU = 'Review the different types of entries that will be created when you post the document or journal.',
                                FRA = 'Examinez les différents types d''écritures qui seront créés lorsque vous validez le document ou la feuille.';

                    trigger OnAction();
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Post and &Print',
                                FRA = 'Valider et i&mprimer';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Executes the Post and &Print action.';

                    trigger OnAction();
                    begin
                        //BC UPGRADE PATHAA02-DIT Code>>
                        // <<DITW15.00.00.25 DDR 20/10/2008
                        // CurrPage.UPDATE;
                        // >>DITW15.00.00.25 DDR
                        //BC UPGRADE PATHAA02-DIT Code<<

                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Test Report")
                {
                    CaptionML = ENU = 'Test Report',
                                FRA = 'Impression test';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'Executes the Test Report action.';

                    trigger OnAction();
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    CaptionML = ENU = 'Post &Batch',
                                FRA = 'Valider par l&ot';
                    Ellipsis = true;
                    Image = PostBatch;
                    ToolTip = 'Executes the Post &Batch action.';

                    trigger OnAction();
                    begin
                        //BC UPGRADE PATHAA02-DIT Code>>
                        // // <<DITW15.00.00.25 DDR 20/10/2008
                        // CurrPage.UPDATE;
                        // // >>DITW15.00.00.25 DDR
                        //BC UPGRADE PATHAA02-DIT Code<<
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", true, true, Rec);
                        CurrPage.UPDATE(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = 'Remove From Job Queue',
                                FRA = 'Supprimer de la file d''attente des travaux';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;
                    ToolTip = 'Executes the Remove From Job Queue action.';

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                separator(Separator201)
                {
                }
                group("Prepa&yment")
                {
                    CaptionML = ENU = 'Prepa&yment',
                                FRA = 'Acom&pte';
                    Image = Prepayment;
                    action("Prepayment Test &Report")
                    {
                        CaptionML = ENU = 'Prepayment Test &Report',
                                    FRA = 'Impression &test acompte';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;
                        ToolTip = 'Executes the Prepayment Test &Report action.';

                        trigger OnAction();
                        begin
                            ReportPrint.PrintPurchHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        CaptionML = ENU = 'Post Prepayment &Invoice',
                                    FRA = 'Valider &facture acompte';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ToolTip = 'Executes the PostPrepaymentInvoice action.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //BC UPGRADE PATHAA02-DIT Code>>
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            CurrPage.UPDATE;   // BC Upgrade SHUKLP03 <<
                            // >>DITW15.00.00.25 DDR

                            //HEI.05>>
                            Rec.TESTFIELD("Document Subtype Code FND"); // BC Upgrade SHUKLP03 <<
                            //HEI.05<<
                            //BC UPGRADE PATHAA02-DIT Code<<
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        CaptionML = ENU = 'Post and Print Prepmt. Invoic&e',
                                    FRA = 'Valider et imprimer factur&e acompte';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ToolTip = 'Executes the Post and Print Prepmt. Invoic&e action.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //BC UPGRADE PATHAA02-DIT Code>>
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            // CurrPage.UPDATE;
                            // >>DITW15.00.00.25 DDR
                            //BC UPGRADE PATHAA02-DIT Code<<
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        CaptionML = ENU = 'Post Prepayment &Credit Memo',
                                    FRA = 'Valider &avoir acompte';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ToolTip = 'Executes the PostPrepaymentCreditMemo action.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //BC UPGRADE PATHAA02-DIT Code>>
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            // CurrPage.UPDATE;
                            // >>DITW15.00.00.25 DDR
                            //BC UPGRADE PATHAA02-DIT Code<<
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        CaptionML = ENU = 'Post and Print Prepmt. Cr. Mem&o',
                                    FRA = 'Valider et imprimer av&oir acompte';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ToolTip = 'Executes the Post and Print Prepmt. Cr. Mem&o action.';

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //BC UPGRADE PATHAA02-DIT Code>>
                            // <<DITW15.00.00.25 DDR 20/10/2008
                            // CurrPage.UPDATE;
                            // >>DITW15.00.00.25 DDR
                            //BC UPGRADE PATHAA02-DIT Code<<
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
                        end;
                    }
                }
            }
            group(Print)
            {
                CaptionML = ENU = 'Print',
                            FRA = 'Imprimer';
                Image = Print;
                action("&Order")
                {
                    ApplicationArea = Suite;
                    CaptionML = ENU = '&Order',
                                FRA = '&Imprimer';
                    Ellipsis = true;
                    Enabled = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category10;
                    ToolTipML = ENU = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.',
                                FRA = 'Préparez-vous à imprimer le document. La fenêtre de sélection de l''état pour le document s''ouvre et vous permet d''indiquer les éléments à imprimer.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        //<<DITW17.00.02 TEC1 10/09/2013 DIT-770 #144 - DITW110.00.08 DDR 02/01/2017 NRQ#0
                        //TESTFIELD(Status,Status::Released);
                        //>>DITW17.00.02 TEC1 10/09/2013 DIT-770 #144

                        PurchaseHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(PurchaseHeader);

                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        // CurrPage.PurchLines.PAGE.SetDisableRefreshLines(true);//BC UPGRADE PATHAA02-DIT
                        // >>DITW16.00.00.40 DDR DIT-715 #197

                        PurchaseHeader.PrintRecords(true);

                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        // CurrPage.PurchLines.PAGE.SetDisableRefreshLines(false); //BC UPGRADE PATHAA02-DIT
                        // >>DITW16.00.00.40 DDR DIT-715 #197
                    end;
                }
                action("&Shipping Agent Notice")
                {
                    CaptionML = ENU = '&Shipping Agent Notice',
                                FRA = '&Mention du transporteur';
                    Image = Print;
                    ToolTip = 'Executes the &Shipping Agent Notice action.';

                    trigger OnAction();
                    var
                        DocPrint: Codeunit "Document-Print";
                    begin
                        //? DITW110.00.08 DDR 02/01/2017 NRQ#0 TO BE REPLACED (don't use codeunit229 Document-Print)

                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        // CurrPage.PurchLines.PAGE.SetDisableRefreshLines(true);//BC UPGRADE PATHAA02-DIT
                        // >>DITW16.00.00.40 DDR DIT-715 #197

                        // <<DIT15.00.00.21 DDR 26/06/2008
                        //DocPrint.PrintPurchHeaderAgentNotice(Rec); //BC UPGRADE PATHAA02-DIT
                        // >>DIT15.00.00.21 DDR

                        // <<DITW16.00.00.40 DDR 10/01/2012 DIT-715 #197
                        // CurrPage.PurchLines.PAGE.SetDisableRefreshLines(false); //BC UPGRADE PATHAA02-DIT
                        // >>DITW16.00.00.40 DDR DIT-715 #197
                    end;
                }
                action(SendCustom)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Send',
                                FRA = 'Envoyer';
                    Ellipsis = true;
                    Image = SendToMultiple;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    ToolTipML = ENU = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.',
                                FRA = 'Préparez-vous à envoyer le document en fonction du profil d''envoi du fournisseur, par exemple en pièce jointe d''un e-mail. La fenêtre Envoyer le document à s''ouvre en premier pour que vous puissiez confirmer ou sélectionner un profil d''envoi.';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                        PurchaseHeader.SendRecords();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        //BC UPGRADE PATHAA02-DIT Code>>
        // <<DITW18.00.06 DDR 23/02/2015 DIT-770 #1191
        // Rec.SETFILTER(Rec."Resp. Center Table Filter",
        //   UserMgt.GetRespCenterFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Phys. Location Table Filter",
        //   UserMgt.GetRespPhysLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // SETFILTER("Location Table Filter",
        //   UserMgt.GetRespLocationFilter(1, "Responsibility Center", "Physical Location Group Code", "Location Code"));
        // // >>DITW18.00.06 DDR DIT-770 #1191
        // //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        // if "Responsibility Center" <> '' then
        //     SETFILTER("Resp. Center Table Filter 2", '%1|%2', '', "Responsibility Center");
        // //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        // // <<DITW15.00.00.39 DDR 27/07/2011 #1407
        // CALCFIELDS("Disc.Promo. Order Calculated");
        // // >>DITW15.00.00.34 DDR
        //BC UPGRADE PATHAA02-DIT Code<<

        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RECORDID);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RECORDID);

        //<< DITW18.00.07 VSC 04/05/2016 DIT-770 #1984 - #1981-> DIT-770 #1488
        //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
        /// DITW110.00.08 DDR 02/01/2017 NRQ#0
       // RouteAsMandatory := PurchSetup."Route Mandatory";//BC UPGRADE PATHAA02-DIT-F2014108
        //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984
        //<< DITW18.00.07 VSC DIT-770 #1984 - #1981-> DIT-770 #1488
        //<<DITW19.00.08 MSF 09/09/2016 BL#10387
        //EditableVendorTax := not ReceivedPurchLinesExist; //BC UPGRADE PATHAA02-DIT-F2014108
        //>>DITW19.00.08 MSF 09/09/2016 BL#10387

        //BC UPGRADE PATHAA02-DIT>>
        //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // if not "Multiple Order Route" then
        //     EditableMultipleRouteOrder := true
        // else
        //     EditableMultipleRouteOrder := false;
        //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //BC UPGRADE PATHAA02-DIT<<

        //>>HEI.01
        PrintEnabled := Rec."SRM Order No. FND" = '';
        //<<HEI.01
    end;

    trigger OnAfterGetRecord();
    begin
        //BC UPGRADE PATHAA02-DIT Code>>
        // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        // MaximumCubageOnFormat;
        // MaximumWeightOnFormat;
        // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        //BC UPGRADE PATHAA02-DIT Code<<

        //HEI.07>>
        PurchSetup.GET();
        ShowSRMSubpage := (Rec."SRM Contract No. FND" <> '') and PurchSetup."Allow VATChange C&TP Ord. FND";
        //HEI.07<<
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        //ERROR('hello');
        CurrPage.SAVERECORD();
        exit(Rec.ConfirmDeletion());
    end;

    trigger OnInit();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        //BC UPGRADE PATHAA02 DIT>>
        // <<DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141
        // "Maximum WeightVisible" := true;
        // "Maximum CubageVisible" := true;
        // // >>DITW16.00.00.39 DDR 04/08/2011 DIT-715 #141

        // //<<DITW19.00.08 MSF 09/09/2016 BL#10387
        // EditableVendorTax := true;
        // //>>DITW19.00.08 MSF 09/09/2016 BL#10387

        // //<<DITW110.00.11 MSF 21/09/2017 NRQ#16082
        // EditableMultipleRouteOrder := true;
        // //>>DITW110.00.11 MSF 21/09/2017 NRQ#16082
        //BC UPGRADE PATHAA02-DIT<<

        JobQueueUsed := PurchasesPayablesSetup.JobQueueActive();
        SetExtDocNoMandatoryCondition();

        // BC Upgrade SHUKLP03 >> Added code.
        //HEI.05>>
        //soicad delete
        // PurchSetup.GET();
        // IF PurchSetup."NPO Prepayment request subtype" <> '' THEN
        //     Rec."Document Subtype Code" := PurchSetup."NPO Prepayment request subtype";
        //HEI.05<<
        // BC Upgrade SHUKLP03 << Added code.

        //HEI.09>>
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    var
        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND"; //BC UPGRADE SHUKLP03 <<
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();

        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetBuyFromVendorFromFilter();

        // BC Upgrade SHUKLP03 >> Added code.
        //HEI.05>>
        // soicad delete
        // PurchSetup.GET();
        // IF PurchSetup."NPO Prepayment request subtype" <> '' THEN
        //     Rec."Document Subtype Code" := PurchSetup."NPO Prepayment request subtype";
        //HEI.05<<
        //HEI.09>>

        //BC UPGRADE PATHAA02-DIT-T2014473>>
        DocumentSubtypeCodeSetup.GET();
        DocumentSubtypeCodeSetup.TESTFIELD("Purchase - General");
        Rec."Document Subtype Code FND" := DocumentSubtypeCodeSetup."Purchase - General";
        //BC UPGRADE PATHAA02-DIT-T2014473<<

        //HEI.09<<
        // BC Upgrade SHUKLP03 << Added code.

        //>> HEI.12
        GeneralOpCoSetup.GET();
        GeneralOpCoSetup.TESTFIELD("BRC Location Code");

        Rec."Location Code" := GeneralOpCoSetup."BRC Location Code";
        Rec."BRC Purchase Order FND" := true;
        //<<HEI.12
    end;

    trigger OnOpenPage();
    var
        DocumentSubtypeCodeSetup: Record "Doc Subtype Code Setup FND";//BC UPGRADE SHUKLP03
    begin
        SetDocNoVisible();
        //BC UPGRADE PATHAA02-DIT>>
        // <<DITW18.00.06 DDR 25/02/2015 DIT-770 #1191
        //IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
        // if UserMgt.GetPurchasesTextFilter <> '' then begin
        //     FILTERGROUP(2);
        //     //SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
        //     SETFILTER("Responsibility Center", UserMgt.GetPurchasesTextFilter);
        //     FILTERGROUP(0);

        //     //<< DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR 02/01/2017 NRQ#0
        //     PurchSetup.GET;
        //     //>> DITW18.00.07 VSC 26/05/2016 DIT-770 #1984 - DITW110.00.08 DDR NRQ#0
        // end;
        // >>DITW18.00.06 DDR DIT-770 #1191

        //HEI.08>>
        if Rec."Document Subtype Code FND" <> '' then
            DocSubtypeEditable := false;
        //HEI.08<<
        //BC UPGRADE PATHAA02-DIT<<

        //HEI.07>>
        PurchSetup.GET();
        ShowSRMSubpage := (Rec."SRM Order No. FND" <> '') and PurchSetup."Allow VATChange C&TP Ord. FND";
        //HEI.07<<

        // BC Upgrade SHUKLP03 >> Added code.

        //HEI.09>>
        DocumentSubtypeCodeSetup.GET();
        DocumentSubtypeCodeSetup.TESTFIELD("Purchase - General");
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Document Subtype Code FND", '%1|%2', '', DocumentSubtypeCodeSetup."Purchase - General");
        Rec.FILTERGROUP(0);
        //HEI.09<<
        // BC Upgrade SHUKLP03 << Added code.


    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if not DocumentIsPosted then
            exit(Rec.ConfirmCloseUnposted());
    end;

    var
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ChangeExchangeRate: Page "Change Exchange Rate";




        JobQueueVisible: Boolean;

        JobQueueUsed: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedPurchaseOrderQst: TextConst ENU = 'The order has been posted and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', FRA = 'La commande a été validée et déplacée dans la fenêtre Factures achat enregistrées.\\Souhaitez-vous ouvrir la facture enregistrée ?';
        CreateIncomingDocumentEnabled: Boolean;
        Text2014410: TextConst ENU = '%1 %2 has been automatically released.', FRA = 'Le/la %1 %2 a été automatiquement lancé(e).';
        Text2014411: TextConst ENU = 'Do you want to cancel the approval request for %1 %2?', FRA = 'Souhaitez vous annuler la demande d''approbation du/de la %1 %2?';
        StdVendPurchCode: Record "Standard Vendor Purchase Code";
        Text2014412: TextConst ENU = 'Do you want to send the approval request for %1 %2?', FRA = 'Souhaitez vous envoyer la demande d''approbation du/de la %1 %2?';
        ReleasePurchDoc: Codeunit "Release Purchase Document";

        PurchHistoryBtnVisible: Boolean;

        PayToCommentPictVisible: Boolean;

        PayToCommentBtnVisible: Boolean;

        PurchHistoryBtn1Visible: Boolean;

        "Maximum CubageVisible": Boolean;

        "Maximum WeightVisible": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum CubageEmphasize": Boolean;
        VendorShipmentNoMandatory: Boolean;

        RouteAsMandatory: Boolean;
        PurchSetup: Record "Purchases & Payables Setup";
        EditableVendorTax: Boolean;
        EditableMultipleRouteOrder: Boolean;
        PrintEnabled: Boolean;
        GetBlanketOrderPriceQst: Label 'Do you want to get the blanket order price?';
        ShowSRMSubpage: Boolean;
        DocSubtypeEditable: Boolean;
        ReasonCodeErr: Label 'You must fill in the Reason Code';
        PurchHdrArch: Record "Purchase Header Archive";
        GeneralOpCoSetup: Record "General OpCo Setup FND";
        Vendor: Record Vendor;
        Err001: Label 'The Field "Local Vendor Type" in Vendor Card for the selected Vendor "%1" must be "%2"';
        Text001: Label 'The Location Code must be %1';

    local procedure Post(PostingCodeunitID: Integer);
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        Rec.SendToPosting(PostingCodeunitID);

        DocumentIsPosted := not PurchaseHeader.GET(Rec."Document Type", Rec."No.");

        if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.CLOSE();
        CurrPage.UPDATE(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
            ShowPostedConfirmationMessage();
    end;

    local procedure ApproveCalcInvDisc();
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
    end;

    local procedure PurchaserCodeOnAfterValidate();
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.UPDATE();
    end;

    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.UPDATE();
    end;

    local procedure PricesIncludingVATOnAfterValid();
    begin
        CurrPage.UPDATE();
    end;

    local procedure Prepayment37OnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    local procedure SetDocNoVisible();
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.GET();
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory";
        //BC UPGRADE PATHAA02-DIT>>
        //<< DITW18.00.07 AKH 28/03/2016 DIT-770 #1409
        // VendorShipmentNoMandatory := PurchasesPayablesSetup."Vendor Shipment No. Mandatory";
        //>> DITW18.00.07 AKH DIT-770 #1409
        //BC UPGRADE PATHAA02-DIT<<
    end;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        CreateIncomingDocumentEnabled := (not HasIncomingDocument) and (Rec."No." <> '');
        SetExtDocNoMandatoryCondition();

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RECORDID);
    end;

    local procedure ShowPostedConfirmationMessage();
    var
        OrderPurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderPurchaseHeader.GET(Rec."Document Type", Rec."No.") then begin
            PurchInvHeader.SETRANGE("No.", Rec."Last Posting No.");
            if PurchInvHeader.FINDFIRST() then
                if InstructionMgt.ShowConfirm(OpenPostedPurchaseOrderQst, InstructionMgt.ShowPostedConfirmationMessageCode()) then
                    PAGE.RUN(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end;
    end;


    //BC UPGRADE PATHAA02-DIT>>
    // local procedure FormatMaximumControls(pFieldNo: Integer; pMaxValue: Decimal; pTotalValue: Decimal);
    // var
    //     lblnBold: Boolean;
    //     lcolor: Integer;
    // begin
    //     // <<DIT15.00.00.21 DDR 19/06/2008
    //     lcolor := 0;
    //     lblnBold := false;

    //     if pMaxValue < pTotalValue then
    //         lcolor := 255;

    //     lblnBold := lcolor <> 0;

    //     // // <<DITW15.00.00.25 DDR 09/10/2008
    //     // "Maximum CubageVisible" := false;
    //     // "Maximum WeightVisible" := false;
    //     // // >>DITW15.00.00.25 DDR

    //     case pFieldNo of
    //         FIELDNO("Maximum Weight"):
    //             begin
    //                 "Maximum WeightEmphasize" := lblnBold;
    //             end;
    //         FIELDNO("Maximum Cubage"):
    //             begin
    //                 "Maximum CubageEmphasize" := lblnBold;
    //             end;
    //     end;

    //     // <<DITW15.00.00.25 DDR 09/10/2008
    //     "Maximum CubageVisible" := true;
    //     "Maximum WeightVisible" := true;
    //     // >>DITW15.00.00.25 DDR
    // end;
    //BC UPGRADE PATHAA02-DIT<<

    local procedure StatusOnAfterValidate();
    begin
        // <<DITW15.00.00.34 DDR 17/06/2009
        CurrPage.UPDATE(false);
    end;

    local procedure StatusOnValidate();
    begin
        //BC UPGRADE PATHAA02-DIT>>
        // <<DITW15.00.00.34 DDR 17/06/2009
        // if xRec.Status = Rec.Status then
        //     exit;

        // // <<DITW15.00.00.39 DDR 10/05/2011 #1330 - DITW15.00.00.39 DDR 27/07/2011 #1407
        // if (xRec.Status = Rec.Status::Open) or (Rec.Status = Rec.Status::Released) then
        //     ReleasePurchDoc.DocStatusRelease(xRec, Rec)
        // else begin
        //     if Rec.Status = Rec.Status::Open then
        //         ReleasePurchDoc.DocStatusOpen(xRec, Rec)
        //     else
        //         // >>DITW15.00.00.39 DDR #1330 #1407
        //         Rec.TESTFIELD(Rec.Status, xRec.Status);
        // end;
        //BC UPGRADE PATHAA02-DIT<<
    end;

    //BC UPGRADE PATHAA02-DIT>>
    // local procedure MaximumCubageOnFormat();
    // begin
    //     CALCFIELDS("Total Cubage");
    //     FormatMaximumControls(FIELDNO("Maximum Cubage"), "Maximum Cubage", "Total Cubage");
    // end;

    // local procedure MaximumWeightOnFormat();
    // begin
    //     CALCFIELDS("Total Weight");
    //     FormatMaximumControls(FIELDNO("Maximum Weight"), "Maximum Weight", "Total Weight");
    // end;
    //BC UPGRADE PATHAA02-DIT<<
}

