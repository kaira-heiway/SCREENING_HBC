report 51013 "Unloading Note - TNG CBN"
{
    // version HEI.01

    // HEI.01 FDD-AL-GAPLOG05 IBM NASTAA02 29.09.2017 # Unloading Note template for Algeria
    //   # New Report created

    // BC Upgrade KUMARS145 NAV ID Report 50044 "Unloading Note - TNG"

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reportslayout\Unloading Note - TNG.rdl';

    CaptionML = ENU = 'Unloading Note TNG',
                ESP = 'Bon de Depot';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = FILTER("Return Order"));
            RequestFilterFields = "No.";
            column(ReturnOrderNo; "No.") { }
            column(CompanyName; COMPANYNAME) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(Customer_Name; Customer.Name) { }
            column(ServiceZone_Description; ServiceZone.Description) { }
            dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
            {
                DataItemLink = "Source No." = FIELD("No.");
                DataItemTableView = SORTING("No.", "Line No.") ORDER(Ascending) WHERE("Source Type" = FILTER(37), "Source Subtype" = FILTER(5));
                column(WarehouseReceiptLine_No; "No.") { }
                // BC Upgrade KUMARS145 dependent on Drinkit field commented....>>
                // column(WarehouseReceiptHeader_Driver; WhseShippingDriver.Description) { }
                // column(WarehouseReceiptHeader_Truck; WhseShippingTruck.Description) { }
                column(WarehouseReceiptHeader_Driver; '') { }
                column(WarehouseReceiptHeader_Truck; '') { }
                // BC Upgrade KUMARS145 dependent on Drinkit field commented....<<

                trigger OnAfterGetRecord();
                begin
                    WarehousReceiptHeader.GET("No.");
                    // BC Upgrade KUMARS145 dependent on Drinkit field commented....>>
                    // if WhseShippingDriver.GET(WarehousReceiptHeader."Driver Code") then;
                    // if WhseShippingTruck.GET(WarehousReceiptHeader."Truck Code") then;
                    // BC Upgrade KUMARS145 dependent on Drinkit field commented....<<
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if Customer.GET("Sell-to Customer No.") then
                    if ServiceZone.GET(Customer."Service Zone Code") then;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Printlanguage; PrintLanguage)
                {
                    ApplicationArea = all;
                    CaptionML = ENU = 'Print Language',
                                ESP = 'Idioma de impresión';
                    ToolTipML = ENU = 'Select the language in which you want to print the report.',
                                ESP = 'Seleccione el idioma en el que desea imprimir el informe.';
                    TableRelation = Language;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        label(LogisticsDepartmentLbl; ENU = 'Logistics Department',
                                     FRA = 'Département Logistique')
        label(ReportTitleLbl; ENU = 'BON DE DEPOT EMBALLAGE',
                             FRA = 'BON DE DEPOT EMBALLAGE')
        label(SRNoLbl; ENU = 'SR No.',
                      FRA = 'SR N°')
        label(ReceptionNoLbl; ENU = 'Reception No.',
                             FRA = 'Reception N°')
        label(CustomerNameLbl; ENU = 'Customer Name',
                              FRA = 'Nom Client')
        label(DateLbl; ENU = 'Date:',
                      FRA = 'Date:')
        label(DriverLbl; ENU = 'Driver',
                        FRA = 'Chauffeur')
        label(TimeLbl; ENU = 'Time:',
                      FRA = 'Heure:')
        label(TruckNoLbl; ENU = 'Truck Number',
                         FRA = 'Immatriculation')
        label(WillayaLbl; ENU = 'Willaya:',
                         FRA = 'Willaya:')
        label(ItemBrandLbl; ENU = 'Item Brand',
                           FRA = 'Nom Produit')
        label(HEINEKENLbl; ENU = 'HEINEKEN',
                          FRA = 'HEINEKEN')
        label(SambaTangoLbl; ENU = 'SAMBA/TANGO',
                            FRA = 'SAMBA/TANGO')
        label(OthersLbl; ENU = 'Others',
                        FRA = 'Autre')
        label(PalettsLbl; ENU = 'PALETTES',
                         FRA = 'PALETTES')
        label(ItemCodeLbl; ENU = 'Item Code',
                          FRA = 'Code')
        label(ItemDesctriptionLbl; ENU = 'Item Description',
                                  FRA = 'Désignation')
        label(UnloadedAndReceivedQualityConfirmedLbl; ENU = 'Unloaded Quantity and Conform Received',
                                                     FRA = 'Quantité Déchargée & reçue conforme')
        label(UnloadedAndReceivedQualityNotConfirmedLbl; ENU = 'Unloaded Quantity and not Conform Received',
                                                        FRA = 'Quantité Déchargée & reçue non conforme')
        label(ControlleNnameSignatureLbl; ENU = 'Controller Name & Signature',
                                         FRA = 'Nom et Visa du Contrôleur')
        label(WarehouseSupervisorRPMLbl; ENU = 'Warehouse Supervisor RPM',
                                        FRA = 'Nom et Visa du chargé du Mag Emb')
        label(DriverRepresentative; ENU = 'Driver / Representative',
                                   FRA = 'Chauffeur / Représentant')
        ItemCode1Lbl = '701-003'; ItemCode2Lbl = '702-004'; ItemCode3Lbl = '701-001'; ItemCode4Lbl = '702-001'; ItemCode5Lbl = '703-001'; ItemCode6Lbl = '704-001'; ItemCode7Lbl = '704-002'; ItemCode8Lbl = '704-003'; ItemDescription1Lbl = 'Blle HK 30cl Vide'; ItemDescription2Lbl = 'Bac HK Vide'; ItemDescription3Lbl = 'Emb Blle 24 cl'; ItemDescription4Lbl = 'Bac Vide'; ItemDescription5Lbl = 'Emb Fût 30 l'; ItemDescription6Lbl = 'Casier'; ItemDescription7Lbl = 'Blle'; ItemDescription8Lbl = 'Emb PB'; ItemDescription9Lbl = 'Emb PP'; ItemDescription10Lbl = 'Emb PF';
    }

    trigger OnInitReport();
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);

        // FCE01-
        PrintLanguage := CompanyInfo."Language Code FND";
        // FCE01+
    end;

    trigger OnPreReport();
    begin
        // FCE01-
        CurrReport.LANGUAGE := GetLanguageID(PrintLanguage);
        // FCE01+
    end;

    local procedure GetLanguageID(PrintLanguage: Code[10]): Integer
    var
        LanguageRecLocal: Record Language;
    begin
        IF LanguageRecLocal.GET(PrintLanguage) then
            exit(LanguageRecLocal."Windows Language ID")
        else
            exit(0);
    end;

    var
        Customer: Record Customer;
        CompanyInfo: Record "Company Information";
        WarehousReceiptHeader: Record "Warehouse Receipt Header";
        // BC Upgrade KUMARS145 dependent on Drinkit table commented....>>
        // WhseShippingDriver: Record "Whse. Shipping Driver";
        // WhseShippingTruck: Record "Whse. Shipping Truck";
        // BC Upgrade KUMARS145 dependent on Drinkit table commented....<<
        ServiceZone: Record "Service Zone";
        PrintLanguage: Code[10];
        LanguageRec: Record Language;
}

