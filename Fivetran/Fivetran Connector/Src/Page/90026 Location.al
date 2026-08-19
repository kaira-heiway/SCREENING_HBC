page 90026 "Location"
{
    DelayedInsert = true;
    PageType = API;
    APIVersion = 'v1.0';
    APIPublisher = 'fivetran';
    APIGroup = 'standardEndpoints';
    DataAccessIntent = ReadOnly;
    Editable = false;
    EntityCaption = 'Location';
    EntitySetCaption = 'Locations';
    ODataKeyFields = SystemId;
    EntityName = 'location';
    EntitySetName = 'locations';
    SourceTable = Location;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field(address2; Rec."Address 2")
                {
                    Caption = 'Address 2';
                }
                field(adjustmentBinCode; Rec."Adjustment Bin Code")
                {
                    Caption = 'Adjustment Bin Code';
                }
                field(allowBreakbulk; Rec."Allow Breakbulk")
                {
                    Caption = 'Allow Breakbulk';
                }
                field(alwaysCreatePickLine; Rec."Always Create Pick Line")
                {
                    Caption = 'Always Create Pick Line';
                }
                field(alwaysCreatePutAwayLine; Rec."Always Create Put-away Line")
                {
                    Caption = 'Always Create Put-away Line';
                }
                field(asmConsumpWhseHandling; Rec."Asm. Consump. Whse. Handling")
                {
                    Caption = 'Asm. Consump. Whse. Handling';
                }
                field(asmToOrderShptBinCode; Rec."Asm.-to-Order Shpt. Bin Code")
                {
                    Caption = 'Asm.-to-Order Shpt. Bin Code';
                }
                field(baseCalendarCode; Rec."Base Calendar Code")
                {
                    Caption = 'Base Calendar Code';
                }
                field(binCapacityPolicy; Rec."Bin Capacity Policy")
                {
                    Caption = 'Bin Capacity Policy';
                }
                field(binMandatory; Rec."Bin Mandatory")
                {
                    Caption = 'Bin Mandatory';
                }
                field(checkWhseClass; Rec."Check Whse. Class")
                {
                    Caption = 'Check Warehouse Class';
                }
                field(city; Rec.City)
                {
                    Caption = 'City';
                }
                field("code"; Rec."Code")
                {
                    Caption = 'Code';
                }
                field(contact; Rec.Contact)
                {
                    Caption = 'Contact';
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code';
                }
                field(county; Rec.County)
                {
                    Caption = 'County';
                }
                field(crossDockBinCode; Rec."Cross-Dock Bin Code")
                {
                    Caption = 'Cross-Dock Bin Code';
                }
                field(crossDockDueDateCalc; Rec."Cross-Dock Due Date Calc.")
                {
                    Caption = 'Cross-Dock Due Date Calc.';
                }
                field(defaultBinCode; Rec."Default Bin Code")
                {
                    Caption = 'Default Bin Code';
                }
                field(defaultBinSelection; Rec."Default Bin Selection")
                {
                    Caption = 'Default Bin Selection';
                }
                field(directedPutAwayAndPick; Rec."Directed Put-away and Pick")
                {
                    Caption = 'Directed Put-away and Pick';
                }
                // field(doNotUseForTaxCalculation; Rec."Do Not Use For Tax Calculation")
                // {
                //     Caption = 'Do Not Use For Tax Calculation';
                // }
                field(eMail; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field(faxNo; Rec."Fax No.")
                {
                    Caption = 'Fax No.';
                }
                field(fromAssemblyBinCode; Rec."From-Assembly Bin Code")
                {
                    Caption = 'From-Assembly Bin Code';
                }
                field(fromProductionBinCode; Rec."From-Production Bin Code")
                {
                    Caption = 'From-Production Bin Code';
                }

                // field(idUbicacion; Rec."ID Ubicacion")
                // {
                //     Caption = 'ID Ubicacion';
                // }
                field(inboundWhseHandlingTime; Rec."Inbound Whse. Handling Time")
                {
                    Caption = 'Inbound Whse. Handling Time';
                }
                field(jobConsumpWhseHandling; Rec."Job Consump. Whse. Handling")
                {
                    Caption = 'Job Consump. Whse. Handling';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(name2; Rec."Name 2")
                {
                    Caption = 'Name 2';
                }
                field(openShopFloorBinCode; Rec."Open Shop Floor Bin Code")
                {
                    Caption = 'Open Shop Floor Bin Code';
                }
                field(outboundWhseHandlingTime; Rec."Outbound Whse. Handling Time")
                {
                    Caption = 'Outbound Whse. Handling Time';
                }
                field(phoneNo; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
                field(phoneNo2; Rec."Phone No. 2")
                {
                    Caption = 'Phone No. 2';
                }
                field(pickAccordingToFEFO; Rec."Pick According to FEFO")
                {
                    Caption = 'Pick According to FEFO';
                }
                field(pickBinPolicy; Rec."Pick Bin Policy")
                {
                    Caption = 'Pick Bin Policy';
                }
                field(postCode; Rec."Post Code")
                {
                    Caption = 'Post Code';
                }
                field(prodConsumpWhseHandling; Rec."Prod. Consump. Whse. Handling")
                {
                    Caption = 'Prod. Consump. Whse. Handling';
                }
                field(prodOutputWhseHandling; Rec."Prod. Output Whse. Handling")
                {
                    Caption = 'Prod. Output Whse. Handling';
                }
                // field(provincialTaxAreaCode; Rec."Provincial Tax Area Code")
                // {
                //     Caption = 'Provincial Tax Area Code';
                // }
                field(putAwayBinPolicy; Rec."Put-away Bin Policy")
                {
                    Caption = 'Put-away Bin Policy';
                }
                field(putAwayTemplateCode; Rec."Put-away Template Code")
                {
                    Caption = 'Put-away Template Code';
                }
                field(receiptBinCode; Rec."Receipt Bin Code")
                {
                    Caption = 'Receipt Bin Code';
                }
                field(requirePick; Rec."Require Pick")
                {
                    Caption = 'Require Pick';
                }
                field(requirePutAway; Rec."Require Put-away")
                {
                    Caption = 'Require Put-away';
                }
                field(requireReceive; Rec."Require Receive")
                {
                    Caption = 'Require Receive';
                }
                field(requireShipment; Rec."Require Shipment")
                {
                    Caption = 'Require Shipment';
                }
                // field(satAddressID; Rec."SAT Address ID")
                // {
                //     Caption = 'SAT Address ID';
                // }

                field(shipmentBinCode; Rec."Shipment Bin Code")
                {
                    Caption = 'Shipment Bin Code';
                }
                field(specialEquipment; Rec."Special Equipment")
                {
                    Caption = 'Special Equipment';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                // field(taxAreaCode; Rec."Tax Area Code")
                // {
                //     Caption = 'Tax Area Code';
                // }
                // field(taxExemptionNo; Rec."Tax Exemption No.")
                // {
                //     Caption = 'Tax Exemption No.';
                // }
                field(telexNo; Rec."Telex No.")
                {
                    Caption = 'Telex No.';
                }
                field(toAssemblyBinCode; Rec."To-Assembly Bin Code")
                {
                    Caption = 'To-Assembly Bin Code';
                }
                field(toJobBinCode; Rec."To-Job Bin Code")
                {
                    Caption = 'To-Job Bin Code';
                }
                field(toProductionBinCode; Rec."To-Production Bin Code")
                {
                    Caption = 'To-Production Bin Code';
                }
                field(useADCS; Rec."Use ADCS")
                {
                    Caption = 'Use ADCS';
                }
                field(useAsInTransit; Rec."Use As In-Transit")
                {
                    Caption = 'Use As In-Transit';
                }
                field(useCrossDocking; Rec."Use Cross-Docking")
                {
                    Caption = 'Use Cross-Docking';
                }
                field(usePutAwayWorksheet; Rec."Use Put-away Worksheet")
                {
                    Caption = 'Use Put-away Worksheet';
                }
                //BC UPGRADE KUMARR78 >>
                field(homePage; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }

                field(transitZoneFND; Rec."Transit Zone FND")
                {
                    Caption = 'Transit Zone';
                }

                field(zoneMandatoryFND; Rec."Zone Mandatory FND")
                {
                    Caption = 'Zone Mandatory';
                }

                field(transitBinFND; Rec."Transit Bin FND")
                {
                    Caption = 'Transit Bin';
                }

                field(plantIDFND; Rec."Plant ID FND")
                {
                    Caption = 'Plant ID';
                }

                field(batchSequentialNumberFND; Rec."Batch sequential number FND")
                {
                    Caption = 'Batch sequential number';
                }

                field(defaultPhysicalLocationFND; Rec."Default Physical Location FND")
                {
                    Caption = 'Default Physical Location';
                }

                field(vanSalesRouteFND; Rec."Van Sales Route FND")
                {
                    Caption = 'Van Sales Route';
                }

                field(purchaseGateEntryMandatFND; Rec."Purchase Gate Entry Mandat FND")
                {
                    Caption = 'Purchase Gate Entry Mandat';
                }

                field(salesGateEntryMandatoryFND; Rec."Sales Gate Entry Mandatory FND")
                {
                    Caption = 'Sales Gate Entry Mandatory';
                }

                field(transferGateEntryMandatFND; Rec."Transfer Gate Entry Mandat FND")
                {
                    Caption = 'Transfer Gate Entry Mandat';
                }

                field(gateWeighingMandatoryFND; Rec."Gate Weighing Mandatory FND")
                {
                    Caption = 'Gate Weighing Mandatory';
                }

                field(warningThresholdDaysFND; Rec."Warning Threshold Days FND")
                {
                    Caption = 'Expiry Warning Threshold Days';
                }

                field(consumpToleranceLimitFND; Rec."Consump. Tolerance Limit % FND")
                {
                    Caption = 'Consump. Tolerance Limit %';
                }

                field(inBoundAutoRegistrationFND; Rec."InBound Auto Registration FND")
                {
                    Caption = 'InBound Auto Registration';
                }

                field(enableInboundValidationFND; Rec."Enable Inbound Validation FND")
                {
                    Caption = 'Enable Inbound Validation';
                }

                field(printInvoiceFND; Rec."Print Invoice FND")
                {
                    Caption = 'Print Invoice';
                }

                field(printDNWhseShipFND; Rec."Print DN (Whse Ship) FND")
                {
                    Caption = 'Print Delivery Note (Whse Shipment)';
                }

                field(printLoadingNoteFND; Rec."Print Loading Note FND")
                {
                    Caption = 'Print Loading Note';
                }

                field(createDocShipCostOnFND; Rec."Create Doc. Ship. Cost On FND")
                {
                    Caption = 'Create Doc. Ship. Cost On';
                }

                field(printerNameFND; Rec."Printer Name FND")
                {
                    Caption = 'Printer Name FND';
                }

                field(printDNSalesShipFND; Rec."Print DN (Sales Ship) FND")
                {
                    Caption = 'Print Delivery Note (Sales Shipment)';
                }

                field(logisticsEMailFND; Rec."Logistics E-Mail FND")
                {
                    Caption = 'Logistics E-Mail FND';
                }

                field(icPartnerCodeFND; Rec."IC Partner Code FND")
                {
                    Caption = 'IC Partner Code';
                }

                field(storeFND; Rec."Store FND")
                {
                    Caption = 'STORE';
                }

                field(taxRegistrationNo113FDW; Rec."Tax Registration No. 113FDW")
                {
                    Caption = 'Tax Registration No.';
                }

                field(excludeFromEMCS113FDW; Rec."Exclude from EMCS 113FDW")
                {
                    Caption = 'Exclude from EMCS';
                }

                field(typeOfOrigin113FDW; Rec."Type of Origin 113FDW")
                {
                    Caption = 'Type of Origin';
                }

                field(taxWarehouseRef113FDW; Rec."Tax Warehouse Ref. 113FDW")
                {
                    Caption = 'Tax Warehouse Reference';
                }

                field(destinationType113FDW; Rec."Destination Type 113FDW")
                {
                    Caption = 'Destination Type';
                }

                field(taxOfficeCode102FDW; Rec."Tax Office Code 102FDW")
                {
                    Caption = 'Tax Office Code';
                }

                field(costCenterPrTransOutFND; Rec."Cost Center Pr. Trans. Out FND")
                {
                    Caption = 'Cost Center for Primary Transport Outbound';
                }

                field(costCenterPrTransExpFND; Rec."Cost Center Pr. Trans. Exp FND")
                {
                    Caption = 'Cost Center for Primary Transport Export';
                }

                field(costCenterSecTransOutFND; Rec."Cost Center Sec. Trans.Out FND")
                {
                    Caption = 'Cost Center for Secondary Transport';
                }

                field(allowToAstroFND; Rec."Allow to Astro FND")
                {
                    Caption = 'Allow to Astro';
                }
                //BC UPGARDE KUMARR78<<

                field(locationGroupCode; Rec."Default Class. 102FDW")
                {
                    Caption = 'Location Group Code';
                }
            }
        }
    }
}
