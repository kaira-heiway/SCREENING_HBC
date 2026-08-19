page 53000 "Item Availability Check - SO"
{
    // version NAVW110.0

    // HEI.01 CHG2023313 IBM KUMARN15 22.08.2019
    //   # New page created
    // BC Upgrade Kamnay01 Original(Heilite) page id 50355

    AutoSplitKey = false;
    CaptionML = ENU = 'Availability check',
                FRA = 'Contrôle de disponibilité';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = false;
    PopulateAllFields = false;
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Manage',
                                 FRA = 'Nouveau,Traitement,État,Gérer';
    SaveValues = false;
    ShowFilter = true;
    SourceTable = Item;
    SourceTableTemporary = false;
    ApplicationArea = All;  // BC Upgrade SHUKLP03

    layout
    {
        area(content)
        {
            field(Control2; '')
            {
                ApplicationArea = Basic, Suite;
                CaptionClass = Heading;
                ToolTip = 'Specifies the value of the '''' field.';

            }
            field(InventoryQty; InventoryQty)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Unrestr. Available Inventory',
                            FRA = 'Stock disponible';
                DecimalPlaces = 0 : 5;
                Editable = false;
                ToolTipML = ENU = 'Specifies the quantity of the item that is currently in inventory and not reserved for other demand.',
                            FRA = 'Spécifie la quantité de l''article actuellement en stock et non réservée pour une autre demande.';
            }
            field(TotalQuantity; TotalQuantity)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Inventory Shortage',
                            FRA = 'Rupture de stock';
                DecimalPlaces = 0 : 5;
                Editable = false;
                ToolTipML = ENU = 'Specifies the total quantity of the item that is currently in inventory. The Total Quantity field is used to calculate the Available Inventory field as follows: Available Inventory = Total Quantity - Reserved Quantity.',
                            FRA = 'Spécifie la quantité totale de l''article qui est actuellement en stock. Le champ Quantité totale est utilisé pour calculer le champ Stock disponible comme suit : Stock disponible = Quantité totale - Quantité réservée.';
            }
            part(AvailabilityCheckDetails; "Item Availability Check Det.")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Manage")
            {
                CaptionML = ENU = '&Manage',
                            FRA = '&Gérer';
                action("Page Item Card")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Item',
                                FRA = 'Article';
                    Image = Item;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;
                    PromotedOnly = true;
                    RunObject = Page "Item Card";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    RunPageMode = View;
                    ToolTipML = ENU = 'View details of the Item',
                                FRA = 'Afficher les détails de l''article';
                }
            }
            group(Create)
            {
                CaptionML = ENU = 'Create',
                            FRA = 'Créer';
                action("Purchase Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Create Purchase Invoice',
                                FRA = 'Créer une facture achat';
                    Image = NewPurchaseInvoice;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = false;
                    PromotedOnly = true;
                    ToolTipML = ENU = 'Create Purchase Invoice',
                                FRA = 'Créer une facture achat';

                    trigger OnAction();
                    var
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseLine: Record "Purchase Line";
                        Vendor: Record Vendor;
                    begin
                        if Rec."Vendor No." = '' then begin
                            if not SelectVendor(Vendor) then
                                exit;

                            Rec."Vendor No." := Vendor."No."
                        end;
                        PurchaseHeader.INIT();
                        PurchaseHeader.VALIDATE("Document Type", PurchaseHeader."Document Type"::Invoice);
                        PurchaseHeader.INSERT(true);
                        PurchaseHeader.VALIDATE("Buy-from Vendor No.", Rec."Vendor No.");
                        PurchaseHeader.MODIFY(true);

                        PurchaseLine.INIT();
                        PurchaseLine.VALIDATE("Document Type", PurchaseHeader."Document Type");
                        PurchaseLine.VALIDATE("Document No.", PurchaseHeader."No.");
                        PurchaseLine.VALIDATE("Line No.", 10000);
                        PurchaseLine.INSERT(true);

                        PurchaseLine.VALIDATE(Type, PurchaseLine.Type::Item);
                        PurchaseLine.VALIDATE("No.", Rec."No.");

                        PurchaseLine.MODIFY(true);
                        PAGE.RUN(PAGE::"Purchase Invoice", PurchaseHeader);
                    end;
                }
            }
        }
    }

    var
        TotalQuantity: Decimal;
        InventoryQty: Decimal;
        Heading: Text;
        SelectVentorTxt: TextConst ENU = 'Select a vendor to buy from.', FRA = 'Sélectionnez un fournisseur chez qui effectuer vos achats.';

    procedure PopulateDataOnNotification(var AvailabilityCheckNotification: Notification; ItemNo: Code[20]; UnitOfMeasureCode: Code[20]; InventoryQty: Decimal; GrossReq: Decimal; ReservedReq: Decimal; SchedRcpt: Decimal; ReservedRcpt: Decimal; CurrentQuantity: Decimal; CurrentReservedQty: Decimal; TotalQuantity: Decimal; EarliestAvailDate: Date);
    begin
        AvailabilityCheckNotification.SETDATA('ItemNo', ItemNo);
        AvailabilityCheckNotification.SETDATA('UnitOfMeasureCode', UnitOfMeasureCode);
        AvailabilityCheckNotification.SETDATA('GrossReq', FORMAT(GrossReq));
        AvailabilityCheckNotification.SETDATA('ReservedReq', FORMAT(ReservedReq));
        AvailabilityCheckNotification.SETDATA('SchedRcpt', FORMAT(SchedRcpt));
        AvailabilityCheckNotification.SETDATA('ReservedRcpt', FORMAT(ReservedRcpt));
        AvailabilityCheckNotification.SETDATA('CurrentQuantity', FORMAT(CurrentQuantity));
        AvailabilityCheckNotification.SETDATA('CurrentReservedQty', FORMAT(CurrentReservedQty));
        AvailabilityCheckNotification.SETDATA('TotalQuantity', FORMAT(TotalQuantity));
        AvailabilityCheckNotification.SETDATA('InventoryQty', FORMAT(InventoryQty));
        AvailabilityCheckNotification.SETDATA('EarliestAvailDate', FORMAT(EarliestAvailDate));
    end;

    procedure InitializeFromNotification(AvailabilityCheckNotification: Notification);
    var
        GrossReq: Decimal;
        SchedRcpt: Decimal;
        ReservedReq: Decimal;
        ReservedRcpt: Decimal;
        CurrentQuantity: Decimal;
        CurrentReservedQty: Decimal;
        EarliestAvailDate: Date;
    begin
        Rec.GET(AvailabilityCheckNotification.GETDATA('ItemNo'));
        Rec.SETRANGE("No.", AvailabilityCheckNotification.GETDATA('ItemNo'));
        EVALUATE(TotalQuantity, AvailabilityCheckNotification.GETDATA('TotalQuantity'));
        EVALUATE(InventoryQty, AvailabilityCheckNotification.GETDATA('InventoryQty'));
        CurrPage.AvailabilityCheckDetails.PAGE.SetUnitOfMeasureCode(
          AvailabilityCheckNotification.GETDATA('UnitOfMeasureCode'));

        if AvailabilityCheckNotification.GETDATA('GrossReq') <> '' then begin
            EVALUATE(GrossReq, AvailabilityCheckNotification.GETDATA('GrossReq'));
            CurrPage.AvailabilityCheckDetails.PAGE.SetGrossReq(GrossReq);
        end;
        if AvailabilityCheckNotification.GETDATA('ReservedReq') <> '' then begin
            EVALUATE(ReservedReq, AvailabilityCheckNotification.GETDATA('ReservedReq'));
            CurrPage.AvailabilityCheckDetails.PAGE.SetReservedReq(ReservedReq);
        end;
        if AvailabilityCheckNotification.GETDATA('SchedRcpt') <> '' then begin
            EVALUATE(SchedRcpt, AvailabilityCheckNotification.GETDATA('SchedRcpt'));
            CurrPage.AvailabilityCheckDetails.PAGE.SetSchedRcpt(SchedRcpt);
        end;
        if AvailabilityCheckNotification.GETDATA('ReservedRcpt') <> '' then begin
            EVALUATE(ReservedRcpt, AvailabilityCheckNotification.GETDATA('ReservedRcpt'));
            CurrPage.AvailabilityCheckDetails.PAGE.SetReservedRcpt(ReservedRcpt);
        end;
        if AvailabilityCheckNotification.GETDATA('CurrentQuantity') <> '' then begin
            EVALUATE(CurrentQuantity, AvailabilityCheckNotification.GETDATA('CurrentQuantity'));
            CurrPage.AvailabilityCheckDetails.PAGE.SetCurrentQuantity(CurrentQuantity);
        end;
        if AvailabilityCheckNotification.GETDATA('CurrentReservedQty') <> '' then begin
            EVALUATE(CurrentReservedQty, AvailabilityCheckNotification.GETDATA('CurrentReservedQty'));
            CurrPage.AvailabilityCheckDetails.PAGE.SetCurrentReservedQty(CurrentReservedQty);
        end;
        if AvailabilityCheckNotification.GETDATA('EarliestAvailDate') <> '' then begin
            EVALUATE(EarliestAvailDate, AvailabilityCheckNotification.GETDATA('EarliestAvailDate'));
            CurrPage.AvailabilityCheckDetails.PAGE.SetEarliestAvailDate(EarliestAvailDate);
        end;
    end;

    procedure SetHeading(Value: Text);
    begin
        Heading := Value;
    end;

    local procedure SelectVendor(var Vendor: Record Vendor): Boolean;
    var
        VendorList: Page "Vendor List";
    begin
        VendorList.LOOKUPMODE(true);
        VendorList.CAPTION(SelectVentorTxt);
        if VendorList.RUNMODAL() = ACTION::LookupOK then begin
            VendorList.GETRECORD(Vendor);
            exit(true);
        end;

        exit(false);
    end;
}

