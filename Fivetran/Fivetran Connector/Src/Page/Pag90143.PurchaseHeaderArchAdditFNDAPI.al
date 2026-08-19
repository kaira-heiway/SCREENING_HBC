page 90143 "Purch. Hdr Arch Addit FND API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'customEndpoints';
    ApplicationArea = All;
    Caption = 'Purchase Header Arch Addit FND';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Purchase Header Arch Addit FND';
    EntitySetCaption = 'Purchase Header Arch Addit FND';
    EntityName = 'PurchaseHeaderArchAdditFND';
    EntitySetName = 'PurchaseHeaderArchAdditFND';
    SourceTable = "Purchase Header Arch Addit FND";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
                {
                    Caption = 'Doc. No. Occurrence';
                }
                field(versionNo; Rec."Version No.")
                {
                    Caption = 'Version No.';
                }
                field(pqApprover; Rec."PQ Approver")
                {
                    Caption = 'PQ Approver';
                }
                field(maximoStatus; Rec."Maximo Status INT")
                {
                    Caption = 'Maximo Status';
                }
                field(limitPO; Rec."Limit PO")
                {
                    Caption = 'Limit PO';
                }
                field(lsrOrderNo; Rec."LSR Order No INT")
                {
                    Caption = 'LSR Order No';
                }
                field(expectedDateDeparture; Rec."Expected Date Departure INT")
                {
                    Caption = 'Expected Date Departure';
                }
                field(departureDate; Rec."Departure Date INT")
                {
                    Caption = 'Departure Date';
                }
                field(dateOrigDocsSent; Rec."Date Orig. Docs Sent INT")
                {
                    Caption = 'Date Orig. Docs Sent';
                }
                field(dateCopyDocsSent; Rec."Date Copy Docs Sent INT")
                {
                    Caption = 'Date Copy Docs Sent';
                }
                field(orderFormToSupplierDate; Rec."Order Form To Suppl. Date INT")
                {
                    Caption = 'Order Form To Supplier Date';
                }
                field(expectedDateToExWorks; Rec."Expected Date to Ex Works INT")
                {
                    Caption = 'Expected Date to Ex Works';
                }
                field(vesselName; Rec."Vessel Name INT")
                {
                    Caption = 'Vessel Name';
                }
                field(expectedDateArrival; Rec."Expected Date Arrival INT")
                {
                    Caption = 'Expected Date Arrival';
                }
                field(bLAWB; Rec."B/L-AWB INT")
                {
                    Caption = 'B/L-AWB';
                }
                field(shipmentDescription; Rec."Shipment Description INT")
                {
                    Caption = 'Shipment Description';
                }
                field(orderNo; Rec."Order No. INT")
                {
                    Caption = 'Order No.';
                }
                field(trackingInformation; Rec."Tracking Information INT")
                {
                    Caption = 'Tracking Information';
                }
                field(referenceSdv; Rec."Reference SDV INT")
                {
                    Caption = 'Reference SDV';
                }
                field(dateReceiptDocsSupplier; Rec."Date Receipt Docs Supplier INT")
                {
                    Caption = 'Date Receipt Docs Supplier';
                }
                field(dateReceiptDocsForwarder; Rec."Date Recpt. Docs Forwarder INT")
                {
                    Caption = 'Date Receipt Docs Forwarder';
                }
                field(volumeInM3; Rec."Volume in m3 INT")
                {
                    Caption = 'Volume in m3';
                }
                field(nbrCont20Feet; Rec."Nbr cont. 20 feet INT")
                {
                    Caption = 'Nbr cont. 20 feet';
                }
                field(nbrCont40Feet; Rec."Nbr cont. 40 feet INT")
                {
                    Caption = 'Nbr cont. 40 feet';
                }
                field(pFIDocumentNo; Rec."PFI Document No. INT")
                {
                    Caption = 'PFI Document No.';
                }
                field(regionCode; Rec."Region Code")
                {
                    Caption = 'Region Code';
                }
                field(creditNumber; Rec."Credit Number INT")
                {
                    Caption = 'Credit Number';
                }
                field(creditAmountOfSupplier; Rec."Credit Amount Of supplier INT")
                {
                    Caption = 'Credit Amount Of supplier';
                }
                field(creditValidityDate; Rec."Credit Validity Date INT")
                {
                    Caption = 'Credit Validity Date';
                }
                field(lastDateOfShipment; Rec."Last Date Of Shipment INT")
                {
                    Caption = 'Last Date Of Shipment';
                }
                field(bankWhoIssuedCredit; Rec."Bank Who Issued Credit INT")
                {
                    Caption = 'Bank Who Issued Credit';
                }
                field(ibecorDossierNo; Rec."Ibecor Dossier No. INT")
                {
                    Caption = 'Ibecor Dossier No.';
                }
                field(shoppingCardCreationDate; Rec."Shopping Card Creati Date INT")
                {
                    Caption = 'Shopping Card Creation Date';
                }
                field(wmsExport; Rec."WMS Export INT")
                {
                    Caption = 'WMS Export';
                }
                field(arrivalDateDestinationPort; Rec."Arrival Date Destin. Port INT")
                {
                    Caption = 'Arrival Date Destination Port';
                }
                field(licenseRequired; Rec."License Required INT")
                {
                    Caption = 'License Required';
                }
                field(creditInfoRequired; Rec."Credit Info Required INT")
                {
                    Caption = 'Credit Info Required';
                }
                field(shoppingCardNo; Rec."Shopping Card No. INT")
                {
                    Caption = 'Shopping Card No.';
                }
                field(zycusOrderNo; Rec."Zycus Order No. INT")
                {
                    Caption = 'Zycus Order No.';
                }
                field(zycusGRUUID; Rec."Zycus GR UUID INT")
                {
                    Caption = 'Zycus GR UUID';
                }
                field(zycusGRCancelUUID; Rec."Zycus GR Cancel UUID INT")
                {
                    Caption = 'Zycus GR Cancel UUID';
                }
                field(pOTransactionInterfaceZycus; Rec."PO Trans. Interf. Zycus INT")
                {
                    Caption = 'PO Transaction Interface Zycus';
                }
                field(gRTransactionInterfaceZycus; Rec."GR Trans. Interf. Zycus INT")
                {
                    Caption = 'GR Transaction Interface Zycus';
                }
                field(processedPOTransactionZycus; Rec."Processed PO Trans. Zycus INT")
                {
                    Caption = 'Processed PO Transaction Zycus';
                }
                field(processedGRTransactionZycus; Rec."Processed GR Trans. Zycus INT")
                {
                    Caption = 'Processed GR Transaction Zycus';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
            }
        }
    }
}