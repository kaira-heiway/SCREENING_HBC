pageextension 52012 PostedPurchaseReceiptsExt extends "Posted Purchase Receipts"
{
    // version NAVW110.0,DITW110.00.08,HEI.10,HEI.11
    //  DITW15.00.00.38 DDR 17/09/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                    Added columns
    //                                      "Vendor Tax Registration No.","Fiscal Representative No.",
    //                                      "Vendor Tax Warehouse Ref."
    //   DITW18.00.07 VSC 15/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    //   DITW18.00.07 AKH 11/04/2016 DIT-770 #1508 Added filter on document subtype code

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-PTPGAP062 IBM.HORTOC01 11.07.2017
    //     # Display field UserID
    //   HEI.02 Defect #807 IBM NASTAA02 02.11.2017 # Confirmation field to be added in HeiLite
    //     # New field "SRM Contract No." added
    //   HEI.03 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //     # New Field added "Gate Entry No."
    //   HEI.04 FDD-HT650 BULIMC01 IBM 02.07.2019 #New field displayed "Order No." and "Posting Description"

    //   HEI.05 CHG2058828 IBM NANDIS01 20.05.2020 GR IR Writeoff
    //     # New button created "GR/IR WriteOff Invoicing" for the funtionality
    //   HEI.06 CHG2091605 IBM NANDIS01 18.12.2020 invoice reference issue
    //     # Add No Series to be populated at time of creation of PO
    //   HEI.07 CHG2093868 HB899 IBM GAVANM01  28.01.2021 # LSR - Purchase
    //     # New field added: LSR Order No
    //   HEI.08 CHG2200434 FDD-HB3431 IBM MAJUMS03 01.06.2023 # Column Data Availability of WH Shipment & WH Receipt No. stated in all Posted Documents for all Customer
    //   Distribution, Inter-Brewery Transfers & Purchased Mater
    //     # New field "Posted Warehouse Receipt No." is added.
    //   HEI.09 CHG2229933 HB3689 IBM SRIVAS07 25.04.2024 # SRM Reference Document Mapping - Development
    //     # Added field - "Vendor Shipment No."
    //   HEI.10 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction PO
    //     # Added New Fields - Zycus Order No.
    //                        - PO Transaction Interface Zycus
    //                        - Processed PO Transaction Zycus
    //   HEI.11 CHG2210794 SAHAL01 27.05.2024 Zycus - BASE HL Integration with Transaction GR
    //     # Added New Fields - Zycus GR UUID
    //                        - Zycus GR Cancel UUID
    //                        - GR Transaction Interface Zycus
    //                        - Processed GR Transaction Zycus
    //HEI.10 and HEI.11 -//BC Upgrade GUNREM01 added fields in Interface

    layout
    {
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the receipt number.', FRA = 'Spécifie le numéro de réception.';
        }
        modify("Buy-from Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor that you bought the items from.', FRA = 'Indique le numéro du fournisseur auprès duquel vous avez acheté les articles.';
        }
        modify("Order Address Code")
        {
            ToolTipML = ENU = 'Specifies the order address code used in the receipt.', FRA = 'Spécifie le code adresse commande utilisé dans le reçu.';
        }
        modify("Buy-from Vendor Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor who delivered the items.', FRA = 'Spécifie le nom du fournisseur qui a livré les articles.';
        }
        modify("Buy-from Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Buy-from Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Buy-from Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person to contact at the vendor who shipped the items.', FRA = 'Spécifie le nom de la personne à contacter chez le fournisseur.';
        }
        modify("Pay-to Vendor No.")
        {
            ToolTipML = ENU = 'Specifies the number of the vendor who invoiced the shipment.', FRA = 'Spécifie le numéro du fournisseur qui a facturé l''expédition.';
        }
        modify("Pay-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the vendor who invoiced the shipment.', FRA = 'Spécifie le nom du fournisseur qui a facturé l''expédition.';
        }
        modify("Pay-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Pay-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Pay-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of the person you should contact at the vendor who invoiced the shipment.', FRA = 'Spécifie le nom de la personne que vous devez contacter chez le fournisseur qui a facturé l''expédition.';
        }
        modify("Ship-to Code")
        {
            ToolTipML = ENU = 'Specifies the shipment of the sales order that is linked to the purchase order for drop shipment from the vendor to a customer.', FRA = 'Spécifie l''expédition de la commande vente associée à la commande achat dans le cadre d''une livraison directe du fournisseur au client.';
        }
        modify("Ship-to Name")
        {
            ToolTipML = ENU = 'Specifies the name of the company at the address to which the items were shipped.', FRA = 'Spécifie le nom de la société située à l''adresse à laquelle les articles ont été livrés.';
        }
        modify("Ship-to Post Code")
        {
            ToolTipML = ENU = 'Specifies the postal code of the address.', FRA = 'Spécifie le code postal de l''adresse.';
        }
        modify("Ship-to Country/Region Code")
        {
            ToolTipML = ENU = 'Specifies the country/region code of the address.', FRA = 'Spécifie le code pays/la région de l''adresse.';
        }
        modify("Ship-to Contact")
        {
            ToolTipML = ENU = 'Specifies the name of a contact person at the address that the items were shipped to.', FRA = 'Spécifie le nom d''un contact à l''adresse à laquelle les articles ont été expédiés.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'Specifies the date the purchase header was posted.', FRA = 'Spécifie la date de validation de l''en-tête achat.';
        }
        modify("Purchaser Code")
        {
            ToolTipML = ENU = 'Specifies which purchaser is associated with the receipt.', FRA = 'Spécifie l''acheteur associé au reçu.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 1.', FRA = 'Spécifie le code pour Raccourci axe 1.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for Shortcut Dimension 2.', FRA = 'Spécifie le code pour Raccourci axe 2.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the code for the location where the items on the receipt were registered.', FRA = 'Spécifie le code du magasin où les articles de la réception ont été enregistrés.';
        }
        modify("No. Printed")
        {
            ToolTipML = ENU = 'Specifies how many times the receipt has been printed.', FRA = 'Spécifie combien de fois le reçu a été imprimé.';
        }
        modify("Document Date")
        {
            ToolTipML = ENU = 'Specifies the date when the purchase document was created.', FRA = 'Spécifie la date à laquelle vous avez créé le document achat.';
        }
        modify("Shipment Method Code")
        {
            ToolTipML = ENU = 'Specifies the code used to find the shipment method for this receipt.', FRA = 'Spécifie le code utilisé pour trouver les conditions de livraison pour cette réception.';
        }
        addafter("Location Code")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the line number of the order that created the entry.';
            }
            field("Posting Description"; Rec."Posting Description")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Posting Description field.';
            }
        }
        addafter("Shipment Method Code")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the User ID field.';
            }
            field("Vendor Shipment No."; Rec."Vendor Shipment No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the vendor''s shipment number. It is inserted in the corresponding field on the source document during posting.';
            }
            //BC Upgrade GUNREM01 >> Added fields in Interface
            // field("SRM Contract No."; Rec."SRM Contract No.")
            // {
            //     ApplicationArea = all;
            // }
            // field("SRM Order No."; Rec."SRM Order No.")
            // {
            //     ApplicationArea = all;
            // } 
            //BC Upgrade GUNREM01 << Added fields in Interface
            field("Gate Entry No."; Rec."Gate Entry No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Gate Entry No. field.';
            }
            // field("PostedPurchReceiptAdditional.""LSR Order No"""; PostedPurchReceiptAdditional."LSR Order No")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the value of the LSR Order No field.';
            // }//mOVED To Interfaces
            field("Posted Warehouse Receipt No."; rec."Posted Whse. Receipt No. FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Posted Warehouse Receipt No. field.';
            }
            //BC Upgrade GUNREM01 >> added in Interface
            // field("PostedPurchReceiptAdditional.""Zycus Order No."""; PostedPurchReceiptAdditional."Zycus Order No.")
            //  {
            //     Caption = 'Zycus Order No.';
            //     Visible = false;
            // }
            // field("PostedPurchReceiptAdditional.""PO Transaction Interface Zycus"""; PostedPurchReceiptAdditional."PO Transaction Interface Zycus")
            // {
            //     Caption = 'PO Transaction Interface Zycus';
            //     Visible = false;
            // }
            // field("PostedPurchReceiptAdditional.""Processed PO Transaction Zycus"""; PostedPurchReceiptAdditional."Processed PO Transaction Zycus")
            // {
            //     Caption = 'Processed PO Transaction Zycus';
            //     Visible = false;
            // }
            // field("PostedPurchReceiptAdditional.""Zycus GR UUID"""; PostedPurchReceiptAdditional."Zycus GR UUID")
            // {
            //     Caption = 'Zycus GR UUID';
            //     Visible = false;
            // }
            // field("PostedPurchReceiptAdditional.""Zycus GR Cancel UUID"""; PostedPurchReceiptAdditional."Zycus GR Cancel UUID")
            // {
            //     Caption = 'Zycus GR Cancel UUID';
            //     Visible = false;
            // }
            // field("PostedPurchReceiptAdditional.""GR Transaction Interface Zycus"""; PostedPurchReceiptAdditional."GR Transaction Interface Zycus")
            // {
            //     Caption = 'GR Transaction Interface Zycus';
            //     Visible = false;
            // }
            // field("PostedPurchReceiptAdditional.""Processed GR Transaction Zycus"""; PostedPurchReceiptAdditional."Processed GR Transaction Zycus")
            // {
            //     Caption = 'Processed GR Transaction Zycus';
            //     Visible = false;
            // } //BC Upgrade GUNREm01 << Added in Interface
        }
    }
    actions
    {
        modify("&Receipt")
        {
            CaptionML = ENU = '&Receipt', FRA = '&Réception';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify("&Navigate")
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
        }


        //Unsupported feature: CodeModification on ""&Print"(Action 9).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
        PurchRcptHeader.PrintRecords(true);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //<< DITW18.00.07 AKH 11/04/2016 DIT-770 #1508
        PurchRcptHeader := Rec;
        //>> DITW18.00.07 AKH DIT-770 #1508
        CurrPage.SETSELECTIONFILTER(PurchRcptHeader);
        PurchRcptHeader.PrintRecords(true);
        */
        //end;
        //BC Upgrade GUNREM >> DIT Page
        // addafter(Dimensions)
        // {
        //     action("Shipping Costs")
        //     {
        //         CaptionML = ENU = 'Shipping Costs',
        //                     FRA = 'Coûts transport';
        //         Image = Costs;
        //         RunObject = Page "Posted Document Shipping Cost";
        //         RunPageLink = "Source Type" = CONST(120),
        //                       "Source No." = FIELD("No.");
        //     }
        // }
        //BC Upgrade GUNREM01 << DIT Page
        addafter("&Navigate")
        {
            action("GR/IR Write off Invoicing")
            {
                Caption = 'GR/IR Write off Invoicing';
                Image = Invoice;
                ApplicationArea = All;
                ToolTip = 'Executes the GR/IR Write off Invoicing action.';

                trigger OnAction();
                begin
                    //HEI.05>>
                    CurrPage.UPDATE();
                    if CONFIRM(Text50002, true) then begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        CheckVendorNotoInvoice(Rec."Buy-from Vendor No.");
                        CreateInvoiceHeader(Rec."Buy-from Vendor No.");
                    end;
                    //HEI.05<<
                end;
            }
        }
    }

    var
        //  NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";  // BC Upgrade NANDIS03 - Added

        NoSeries: Record "No. Series";
        grec_purcpayblesetup: Record "Purchases & Payables Setup";
        NewInvNo: Code[10];
        PurchaseHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        grec_PurchRcptLn: Record "Purch. Rcpt. Line";
        NextLineNo1: Integer;
        WriteoffAmount: Decimal;
        PurchLine1: Record "Purchase Line";
        grec_Item: Record Item;
        grec_InventoryPostingSetup: Record "Inventory Posting Setup";
        Text50000: Label 'Vendor Number should be identical';
        Text50001: Label 'No Lines of Type Item found to be created in invoice';
        Text50002: Label 'Do you want to create GR/IR invoice?';
        Text50003: Label 'The Item - %1, is not having Inventory Posting group';
        Text50004: Label 'The Writeoff Account is not available for posting group %1 for Item - %2, against doc no - %3';
        Text50005: Label 'Knock off';
        Text50006: Label 'The purchase invoice - %1 successfully created';
        Text50007: Label 'Either there is no Item available in Posted Receipt document %1, OR it has other type except Item OR it is fully invoiced';
        PostedPurchReceiptAdditional: Record "Purch. Rcpt. Header Add FND";


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    if PostedPurchReceiptAdditional.GET("No.") then;  //HEI.07
    */
    //end;

    //BC Uprade GUNREM01 Added >>
    trigger OnAfterGetRecord();
    begin

        if PostedPurchReceiptAdditional.GET(Rec."No.") then;  //HEI.07

    end;
    //BC Upgrade GUNREM01 added <<

    procedure CheckVendorNotoInvoice(StoreVend: Code[20]);
    begin
        //HEI.05>>
        if Rec.FINDSET() then
            repeat
                if (Rec."Buy-from Vendor No." <> StoreVend) then begin
                    CLEAR(Rec);
                    ERROR(Text50000);
                end;
            until Rec.NEXT() = 0;
        //HEI.05<<
    end;

    procedure CreateInvoiceHeader(VendNo: Code[20]);
    begin
        //HEI.05>>
        grec_purcpayblesetup.GET();
        NewInvNo := '';
        grec_purcpayblesetup.TESTFIELD("GR IR Invoice Writeoff No. FND");
        NoSeries.GET(grec_purcpayblesetup."GR IR Invoice Writeoff No. FND");
        //  NoSeriesMgt.InitSeries(NoSeries.Code, '', WORKDATE(), NewInvNo, Rec."No. Series");
        NoSeriesMgt.AreRelated(NoSeries.Code, Rec."No. Series");//UPGRADE

        if not GUIALLOWED then
            PurchaseHeader.SetHideValidationDialog(true);
        PurchaseHeader.INIT();
        PurchaseHeader.VALIDATE("Document Type", PurchaseHeader."Document Type"::Invoice);
        PurchaseHeader."No." := NewInvNo;
        PurchaseHeader.INSERT(true);
        PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.", VendNo);
        //HEI.06>>
        PurchaseHeader."No. Series" := grec_purcpayblesetup."GR IR Invoice Writeoff No. FND";
        PurchaseHeader."Posting No. Series" := grec_purcpayblesetup."Posted GRIR Inv. Wrtoff No FND";
        //HEI.06<<
        PurchaseHeader.MODIFY(true);
        CreateInvoiceLines(PurchaseHeader, Rec);
        CLEAR(Rec);
        MESSAGE(Text50006, NewInvNo);
        //HEI.05<<
    end;

    procedure CreateInvoiceLines(PurchHeader: Record "Purchase Header"; var PurchRcptHdr: Record "Purch. Rcpt. Header");
    begin
        //HEI.05>>
        if PurchRcptHdr.FINDSET() then
            repeat
                grec_PurchRcptLn.RESET();
                grec_PurchRcptLn.SETRANGE("Document No.", PurchRcptHdr."No.");
                grec_PurchRcptLn.SETRANGE(Type, grec_PurchRcptLn.Type::Item);
                grec_PurchRcptLn.SETFILTER("Qty. Rcd. Not Invoiced", '<>%1', 0);
                if grec_PurchRcptLn.FINDSET() then
                    repeat
                        PurchLine.LOCKTABLE();
                        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
                        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
                        PurchLine."Document Type" := PurchHeader."Document Type";
                        PurchLine."Document No." := PurchHeader."No.";
                        grec_PurchRcptLn.InsertInvLineFromRcptLine(PurchLine);
                        grec_PurchRcptLn.SETRANGE("Attached to Line No.");

                        //Insert one more line to knock off
                        PurchLine1.INIT();
                        PurchLine1."Document Type" := PurchHeader."Document Type";
                        PurchLine1."Document No." := PurchHeader."No.";

                        PurchLine1.SETRANGE(PurchLine1."Document No.", PurchHeader."No.");
                        if PurchLine1.FINDLAST() then
                            NextLineNo1 := PurchLine1."Line No." + 10000
                        else
                            NextLineNo1 := 10000;
                        PurchLine1."Line No." := NextLineNo1;
                        PurchLine1.INSERT(true);
                        PurchLine1.VALIDATE("Receipt No.", '');
                        PurchLine1.VALIDATE(PurchLine1.Type, PurchLine1.Type::"G/L Account");
                        if grec_Item.GET(PurchLine."No.") then begin
                            if (grec_Item."Inventory Posting Group" <> '') then begin
                                if grec_InventoryPostingSetup.GET(PurchLine."Location Code", grec_Item."Inventory Posting Group") then begin
                                    if (grec_InventoryPostingSetup."WriteOff Account FND" <> '') then
                                        PurchLine1.VALIDATE("No.", grec_InventoryPostingSetup."WriteOff Account FND")
                                    else begin
                                        CLEAR(PurchRcptHdr);
                                        ERROR(Text50004, grec_Item."Inventory Posting Group", PurchLine."No.", grec_PurchRcptLn."Document No.");
                                    end;
                                end;
                            end else
                                ERROR(Text50003, PurchLine."No.");
                        end;
                        PurchLine1."Description 2" := Text50005;
                        PurchLine1.VALIDATE(Quantity, 1);
                        PurchLine1.VALIDATE("Direct Unit Cost", -PurchLine.Amount);
                        PurchLine1.VALIDATE("VAT %", PurchLine."VAT %");
                        PurchLine1.VALIDATE("Amount Including VAT", -PurchLine."Amount Including VAT");
                        PurchLine1.MODIFY(true);
                    //Insert one more line to knock off

                    until (grec_PurchRcptLn.NEXT() = 0)
                else begin
                    CLEAR(PurchRcptHdr);
                    ERROR(Text50007, PurchRcptHdr."No.");
                end;
            until PurchRcptHdr.NEXT() = 0;
        //HEI.05<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

