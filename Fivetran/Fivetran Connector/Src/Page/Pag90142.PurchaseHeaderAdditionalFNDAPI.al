
page 90142 "Purchase Header Add. FND API"
{
    PageType = API;
    APIVersion = 'v2.0';
    APIPublisher = 'fivetran';
    APIGroup = 'customEndpoints';
    ApplicationArea = All;
    Caption = 'Purchase Header Additional FND';
    DataAccessIntent = ReadOnly;
    Editable = false;
    DelayedInsert = true;
    EntityCaption = 'Purchase Header Additional FND';
    EntitySetCaption = 'Purchase Header Additional FND';
    EntityName = 'PurchaseHeaderAdditionalFND';
    EntitySetName = 'PurchaseHeaderAdditionalFND';
    SourceTable = "Purchase Header Additional FND";
    ODataKeyFields = SystemID;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(arrivalDateDestinationPort; Rec."Arrival Date Dest. Port INT")
                {
                    Caption = 'Arrival Date Destination Port';
                }
                field(bLAWB; Rec."B/L-AWB INT")
                {
                    Caption = 'B/L-AWB';
                }
                field(bankWhoIssuedCredit; Rec."Bank Who Issued Credit INT")
                {
                    Caption = 'Bank Who Issued Credit';
                }
                field(creditAmountOfSupplier; Rec."Credit Amount Of supplier INT")
                {
                    Caption = 'Credit Amount Of supplier';
                }
                field(creditInfoRequired; Rec."Credit Info Required INT")
                {
                    Caption = 'Credit Info Required';
                }
                field(creditNumber; Rec."Credit Number INT")
                {
                    Caption = 'Credit Number';
                }
                field(creditValidityDate; Rec."Credit Validity Date INT")
                {
                    Caption = 'Credit Validity Date';
                }
                field(dateCopyDocsSent; Rec."Date Copy Docs Sent INT")
                {
                    Caption = 'Date Copy Docs Sent';
                }
                field(dateOrigDocsSent; Rec."Date Orig. Docs Sent INT")
                {
                    Caption = 'Date Orig. Docs Sent';
                }
                field(dateReceiptDocsForwarder; Rec."Date ReceiptDocs Forwarder INT")
                {
                    Caption = 'Date Receipt Docs Forwarder';
                }
                field(dateReceiptDocsSupplier; Rec."Date Receipt Docs Supplier INT")
                {
                    Caption = 'Date Receipt Docs Supplier';
                }
                field(departureDate; Rec."Departure Date INT")
                {
                    Caption = 'Departure Date';
                }

                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(expectedDateArrival; Rec."Expected Date Arrival INT")
                {
                    Caption = 'Expected Date Arrival';
                }
                field(expectedDateDeparture; Rec."Expected Date Departure INT")
                {
                    Caption = 'Expected Date Departure';
                }
                field(expectedDateToExWorks; Rec."Expected Date to Ex Works INT")
                {
                    Caption = 'Expected Date to Ex Works';
                }
                field(grTransactionInterfaceZycus; Rec."GR Transaction Intf Zycus INT")
                {
                    Caption = 'GR Transaction Interface Zycus';
                }
                field(ibecorDossierNo; Rec."Ibecor Dossier No. INT")
                {
                    Caption = 'Ibecor Dossier No.';
                }
                field(lastDateOfShipment; Rec."Last Date Of Shipment INT")
                {
                    Caption = 'Last Date Of Shipment';
                }
                field(lsrOrderNo; Rec."LSR Order No INT")
                {
                    Caption = 'LSR Order No';
                }
                field(licenseRequired; Rec."License Required INT")
                {
                    Caption = 'License Required';
                }
                field(maximoStatus; Rec."Maximo Status INT")
                {
                    Caption = 'Maximo Status';
                }
                field(nbrCont20Feet; Rec."Nbr cont. 20 feet INT")
                {
                    Caption = 'Nbr cont. 20 feet';
                }
                field(nbrCont40Feet; Rec."Nbr cont. 40 feet INT")
                {
                    Caption = 'Nbr cont. 40 feet';
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(orderFormToSupplierDate; Rec."Order FormTo Supplier Date INT")
                {
                    Caption = 'Order Form To Supplier Date';
                }
                field(orderNo; Rec."Order No. INT")
                {
                    Caption = 'Order No.';
                }
                field(pOTransactionInterfaceZycus; Rec."PO Transaction Intf. Zycus INT")
                {
                    Caption = 'PO Transaction Interface Zycus';
                }
                field(pFIDocumentNo; Rec."PFI Document No. INT")
                {
                    Caption = 'PFI Document No.';
                }
                field(pqApprover; Rec."PQ Approver")
                {
                    Caption = 'PQ Approver';
                }
                field(processedGRTransactionZycus; Rec."Processed GR Trans. Zycus INT")
                {
                    Caption = 'Processed GR Transaction Zycus';
                }
                field(processedPOTransactionZycus; Rec."Processed PO Trans. Zycus INT")
                {
                    Caption = 'Processed PO Transaction Zycus';
                }
                field(referenceSdv; Rec."Reference SDV INT")
                {
                    Caption = 'Reference SDV';
                }
                field(regionCode; Rec."Region Code")
                {
                    Caption = 'Region Code';
                }
                field(shipmentDescription; Rec."Shipment Description INT")
                {
                    Caption = 'Shipment Description';
                }
                field(shoppingCardNo; Rec."Shopping Card No.")
                {
                    Caption = 'Shopping Card No.';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(trackingInformation; Rec."Tracking Information INT")
                {
                    Caption = 'Tracking Information';
                }
                field(vesselName; Rec."Vessel Name INT")
                {
                    Caption = 'Vessel Name';
                }
                field(volumeInM3; Rec."Volume in m3 INT")
                {
                    Caption = 'Volume in m3';
                }
                field(wmsExport; Rec."WMS Export INT")
                {
                    Caption = 'WMS Export';
                }
                field(zycusGRCancelUUID; Rec."Zycus GR Cancel UUID INT")
                {
                    Caption = 'Zycus GR Cancel UUID';
                }
                field(zycusGRUUID; Rec."Zycus GR UUID INT")
                {
                    Caption = 'Zycus GR UUID';
                }
                field(zycusOrderNo; Rec."Zycus Order No. INT")
                {
                    Caption = 'Zycus Order No.';
                }
            }
        }
    }
}
