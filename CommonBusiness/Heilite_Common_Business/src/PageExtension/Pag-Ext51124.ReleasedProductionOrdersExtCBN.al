pageextension 51124 ReleasedProductionOrdersExtCBN extends "Released Production Orders"
{
    // version NAVW110.0,MANXL10.01,DITW110.00.12A,HEI.15
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                     2014411 "Physical Location Group Code"

    // MANXL7.00.001 DAT 04/03/2014 #13: Prod. Order KPI's in overview screen
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Added "Losses" & "Register Loss Strength Journal" ribbon button

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.12 AKH 21/03/2018 NRQ#64704 Added fields "Unit of Measure Code"
    //                                                 "Quantity (Base)"
    //                                                 "Quantity HL"
    // DITW110.00.12A HBA 18/06/2018 NRQ#68221 Added fields "Routing Version Code"
    //                                                     "Routing Version Description"
    //                                                     "Production BOM No."
    //                                                     "Production BOM Version Code"
    //                                                     "Production BOM Version Desc."
    // DITW110.00.12A HBA 05/06/2018 NRQ#72678 Added column decFinishedQty, adjusted fctCalcQuantityPlannedVsAct()

    // HEI.01 FDD-PRDGAP039 IBM.HORTOC01 13/07/2017
    // # Page action ProcessOrderGoodsMovement
    // HEI.02 FDD-PRDGAP024 IBM SOICAD01 25.07.2017 #Zone code development without whs advanced mgmt
    // #new fields Zone Code
    // #set table relation from Bin Code field:  Bin.Code WHERE (Location Code=FIELD(Location Code),Zone Code=FIELD(Zone Code))
    // HEI.04 CHG0270593 - IBM ISYED01 2.15.2019
    // # When more than one Lot No is found for the same one line/ 1 Prod. Order description “Multiple” should be displayed
    // # added Gyle no to the page
    // HEI.05 CHG2069358 IBM.AK 25.08.20
    // # new field added on -"Created By"
    // HEI.06 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    // # Code added in OnOpenPage
    // HEI.07 CHG2098891 IBM.LS      19.07.2021
    // # Added Field - Blocked (Caption: Admin. Completed)
    // # Moved Field - Blocked after No.
    // HEI.08 CHG2129985 IBM.LS      21.02.2022
    // # Added New Field - Item Category Code
    // HEI.09 CHG2149734 SAHAL01 07.09.2022
    // # Added New Fields - Prod. ORDER Interface Astro
    //                     - Parked ORDER Astro
    //                     - Last Parked Date ORDER Astro
    //                     - Last Parked Time ORDER Astro
    // # Added Code to visible Astro Fields
    // HEI.10 CHG2154370 SAHAL01 05.09.2022
    // # Added New Fields - Prod. CLOSE Interface Astro
    //                     - Last Parked Date CLOSE Astro
    //                     - Last Parked Time CLOSE Astro
    // # Added Code to visible Astro Fields
    // HEI.11 CHG2154367 SAHAL01 12.09.2022
    // # Added New Fields - Prod. OUTPUT Interface Astro
    //                     - Parked OUTPUT Astro
    //                     - Last Parked Date OUTPUT Astro
    //                     - Last Parked Time OUTPUT Astro
    //                     - Posted OUTPUT Astro
    // # Added Code to visible Astro Fields
    // HEI.12 CHG2154364 SAHAL01 20.10.2022
    // # Added New Fields - Prod. LINEPICK Interface Astro
    //                     - Parked LINEPICK Astro
    //                     - Last Parked Date LINEPICKAstro
    //                     - Last Parked Time LINEPICKAstro
    //                     - Posted LINEPICK Astro
    // # Added Code to visible Astro Fields
    // HEI.13 CHG2154372 SAHAL01 15.12.2022 Astro - I/F Inventory Management - BalanceChange
    // # Added New Fields - OUTPUT Revers Interface Astro
    //                     - Parked OUTPUT Revers Astro
    //                     - Last Parked Date OUTPUTR Astro
    //                     - Last Parked Time OUTPUTR Astro
    //                     - Posted OUTPUT Revers Astro
    // # Added Code to visible Astro Fields
    // HEI.14 CHG2218951 PRASAA03 02.11.2023 Change Request in the Released Production Order
    // # Commented the code and hide the below fields which is causing the performance issue.
    //     - decStandardVsActualCost
    //     - decStandardVsExpectedCost
    //     - decExpectedVsActualCost
    // HEI.15 CHG2218951 PRASAA03 08.11.2023 Change Request in the Released Production Order
    // # Commented the code and hide the below fields which is causing the performance issue.
    //     - decPlannedQty,decFinishedQty,LotNo,
    //     - decPlannedOperations,decActualVsPlannedOperations,decPlannedHours,
    //     - decActualVsPlannedHours,decPlannedSubcontract
    //     - decActualVsPlannedSubcontract,decPlannedCritical,decActualVsPlannedCritical
    // HEI.16 CHG2211537 IBM PRASAA03 18.04.2024 # Mass Upload of Production Orders
    // # 50043 Loading date and time field is added

    // BC Upgrade SHUKLP03 >> 
    // HEI.02 => TableRelation property is not available on PageExtension so code added to filter out data On ONLookUp trigger.
    // HEI.04 => Blocked DrinkIT "Gyle no", "Item Category Code" field.
    // HEI.04 => When more than one Lot No is found for the same one line/ 1 Prod. Order description “Multiple” should be displayed => This code is Blocked in Navision
    // HEI.16 => 50043 Loading date and time => This field is not added in Acceptance but present in Devops.
    // HEI.09 to HEI.13 => Astro code blocked.
    // HEI.02 => Bin Code field is visible false in Navision and in Business central. But it has TableRelation property set on Navision so code is added to filter out data On ONLookUp trigger, because TableRelation property is not available in business central.
    // BC Upgrade SHUKLP03 <<

    layout
    {
        modify("Bin Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                Bin: Record Bin;
            begin
                // HEI.02 >> HEI.02 => Bin Code field is visible false in Navision and in Business central. But it has TableRelation property set on Navision so code is added to filter out data On ONLookUp trigger, because TableRelation property is not available in business central.
                Bin.SetRange("Location Code", Rec."Location Code");
                Bin.SetRange("Zone Code", Rec."Zone Code FND");

                if Page.RunModal(Page::"Bin List", Bin) = Action::LookupOK then begin
                    Rec."Bin Code" := Bin.Code;
                end;

                exit(true);
                //HEI.02 => Bin Code field is visible false in Navision and in Business central. But it has TableRelation property set on Navision so code is added to filter out data On ONLookUp trigger, because TableRelation property is not available in business central.
            end;
        }
        addafter("No.")
        {
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies that the posting of consumption and output transactions for the released production order is blocked.';
            }
            //BC Upgrade GUNREM01 >> added DIT field
            field("Gyle No."; Rec."Gyle No. FND")
            {
                applicationArea = All;
                CaptionML = ENU = 'Ref No.',
                            FRA = 'Gyle N°';
            }
            //BC Upgrade GUNREM01 << added DIT field
        }
        // BC Upgrade SHUKLP03 >> DrinkIT fields are blocked.
        // addafter("Source No.")
        // {
        //     field("Item Category Code";"Item Category Code")
        //     {
        //     }
        // }
        // addafter("Routing No.")
        // {
        //     field("Routing Version Code";"Routing Version Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Routing Version Description";"Routing Version Description")
        //     {
        //         Visible = false;
        //     }
        //     field("Production BOM No.";"Production BOM No.")
        //     {
        //         Visible = false;
        //     }
        //     field("Production BOM Version Code";"Production BOM Version Code")
        //     {
        //         Visible = false;
        //     }
        //     field("Production BOM Version Desc.";"Production BOM Version Desc.")
        //     {
        //         Visible = false;
        //     }
        // }
        // addafter(Quantity)
        // {
        //     field("Unit of Measure Code";"Unit of Measure Code")
        //     {
        //     }
        //     field("Quantity (Base)";Rec."Quantity (Base)")
        //     {
        //     }
        //     field("Quantity HL";"Quantity HL")
        //     {
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT fields are blocked.

        addafter("Last Date Modified")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
        }
        addafter("Bin Code")
        {
            field(decPlannedQty; decPlannedQty)
            {
                CaptionML = ENU = 'Planned Quantity',
                            FRA = 'Quantité planifiée';
                DecimalPlaces = 0 : 5;
                Description = 'MANXL7.00.001';
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the decPlannedQty field.';
            }
            field("<decFinishedQty>"; decFinishedQty)
            {
                Caption = 'Finished Quantity';
                DecimalPlaces = 0 : 5;
                Description = 'NRQ#72678';
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Finished Quantity field.';
            }
            field("Lot Not"; LotNo)
            {
                //AutoFormatExpression = 1;
                AutoFormatType = 1;
                Visible = false;
                Width = 15;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LotNo field.';
            }
            field(decActualVsPlannedQty; decActualVsPlannedQty)
            {
                CaptionML = ENU = 'Actual Produced Quantity',
                            FRA = 'Quantité actuelle';
                Description = 'MANXL7.00.001';
                ExtendedDatatype = Ratio;
                MaxValue = 100;
                MinValue = 0;
                ToolTipML = ENU = 'Actual Produced Quantity',
                            FRA = 'Quantité actuelle';
                ApplicationArea = All;
            }
            field(decPlannedOperations; decPlannedOperations)
            {
                CaptionML = ENU = 'Planned Operations',
                            FRA = 'Opérations plannifiés';
                DecimalPlaces = 0 : 5;
                Description = 'MANXL7.00.001';
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the decPlannedOperations field.';
            }
            field(decActualVsPlannedOperations; decActualVsPlannedOperations)
            {
                CaptionML = ENU = 'Actual Executed Operations',
                            FRA = 'Opérations actuelles';
                Description = 'MANXL7.00.001';
                ExtendedDatatype = Ratio;
                MaxValue = 100;
                MinValue = 0;
                ToolTipML = ENU = 'Actual Executed Operations',
                            FRA = 'Opérations actuelles';
                Visible = false;
                ApplicationArea = All;
            }
            field(decPlannedHours; decPlannedHours)
            {
                CaptionML = ENU = 'Planned Operation Hours',
                            FRA = 'Heures d''opérations plannifiées';
                DecimalPlaces = 0 : 5;
                Description = 'MANXL7.00.001';
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the decPlannedHours field.';
            }
            field(decActualVsPlannedHours; decActualVsPlannedHours)
            {
                CaptionML = ENU = 'Actual Consumed Hours',
                            FRA = 'Heures d''opérations actuelles';
                Description = 'MANXL7.00.001';
                ExtendedDatatype = Ratio;
                MaxValue = 100;
                MinValue = 0;
                ToolTipML = ENU = 'Actual Consumed Hours',
                            FRA = 'Heures d''opérations actuelles';
                Visible = false;
                ApplicationArea = All;
            }
            field(decPlannedSubcontract; decPlannedSubcontract)
            {
                CaptionML = ENU = 'Planned Subcontractor Tasks',
                            FRA = 'Tâches du sous-traitant plannifiées';
                DecimalPlaces = 0 : 5;
                Description = 'MANXL7.00.001';
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the decPlannedSubcontract field.';
            }
            field(decActualVsPlannedSubcontract; decActualVsPlannedSubcontract)
            {
                CaptionML = ENU = 'Ordered Subcontractor Tasks',
                            FRA = 'Tâches du sous-traitant ordonnées';
                Description = 'MANXL7.00.001';
                ExtendedDatatype = Ratio;
                MaxValue = 100;
                MinValue = 0;
                ToolTipML = ENU = 'Ordered Subcontractor Tasks',
                            FRA = 'Tâches du sous-traitant ordonnées';
                Visible = false;
                ApplicationArea = All;
            }
            field(decPlannedCritical; decPlannedCritical)
            {
                CaptionML = ENU = 'Planned Critical Components',
                            FRA = 'Composants critique plannifiés';
                DecimalPlaces = 0 : 5;
                Description = 'MANXL7.00.001';
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the decPlannedCritical field.';
            }
            field(decActualVsPlannedCritical; decActualVsPlannedCritical)
            {
                CaptionML = ENU = 'Critical Components Available',
                            FRA = 'Composants critique disponibles';
                Description = 'MANXL7.00.001';
                ExtendedDatatype = Ratio;
                MaxValue = 100;
                MinValue = 0;
                ToolTipML = ENU = 'Critical Components Available',
                            FRA = 'Composants critique disponibles';
                Visible = false;
                ApplicationArea = All;
            }
            field(decExpectedVsActualCost; decExpectedVsActualCost)
            {
                CaptionML = ENU = 'Expected Cost vs Actual Cost',
                            FRA = 'Coût prévu vs coût réel';
                Description = 'MANXL7.00.001';
                ExtendedDatatype = Ratio;
                MaxValue = 100;
                MinValue = 0;
                ToolTipML = ENU = 'Expected Cost vs Actual Cost',
                            FRA = 'Coût prévu vs coût réel';
                Visible = false;
                ApplicationArea = All;
            }
            field(decStandardVsExpectedCost; decStandardVsExpectedCost)
            {
                CaptionML = ENU = 'Standard Cost vs Expected Cost',
                            FRA = 'Coût standard vs coût prévu';
                Description = 'MANXL7.00.001';
                ExtendedDatatype = Ratio;
                MaxValue = 100;
                MinValue = 0;
                ToolTipML = ENU = 'Standard Cost vs Expected Cost',
                            FRA = 'Coût standard vs coût prévu';
                Visible = false;
                ApplicationArea = All;
            }
            field(decStandardVsActualCost; decStandardVsActualCost)
            {
                CaptionML = ENU = 'Standard Cost vs Actual Cost',
                            FRA = 'Coût standard vs coût réel';
                Description = 'MANXL7.00.001';
                ExtendedDatatype = Ratio;
                MaxValue = 100;
                MinValue = 0;
                ToolTipML = ENU = 'Standard Cost vs Actual Cost',
                            FRA = 'Coût standard vs coût réel';
                Visible = false;
                ApplicationArea = All;
            }
            // BC Upgrade SHUKLP03 >> Astro fields are blocked.
            // field("Responsibility Center";Rec."Responsibility Center")
            // {
            //     Importance = Additional;
            //     QuickEntry = false;
            // }
            // field("Physical Location Group Code";"Physical Location Group Code")
            // {
            //     Importance = Additional;
            //     QuickEntry = false;
            // }
            field("Created By"; Rec."Created By FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Created By field.';
            }
            // field("Prod. ORDER Interface Astro";"Prod. ORDER Interface Astro")
            // {
            //     Visible = VisibleAstro;
            // }
            // field("Parked ORDER Astro";"Parked ORDER Astro")
            // {
            //     Visible = VisibleAstro;
            // }
            // field("Last Parked Date ORDER Astro";"Last Parked Date ORDER Astro")
            // {
            //     Visible = VisibleAstro;
            // }
            // field("Last Parked Time ORDER Astro";"Last Parked Time ORDER Astro")
            // {
            //     Visible = VisibleAstro;
            // }
            // field("Prod. LINEPICK Interface Astro";"Prod. LINEPICK Interface Astro")
            // {
            //     Visible = VisibleAstroLinePick;
            // }
            // field("Parked LINEPICK Astro";"Parked LINEPICK Astro")
            // {
            //     Visible = VisibleAstroLinePick;
            // }
            // field("Last Parked Date LINEPICKAstro";"Last Parked Date LINEPICKAstro")
            // {
            //     Visible = VisibleAstroLinePick;
            // }
            // field("Last Parked Time LINEPICKAstro";"Last Parked Time LINEPICKAstro")
            // {
            //     Visible = VisibleAstroLinePick;
            // }
            // field("Posted LINEPICK Astro";"Posted LINEPICK Astro")
            // {
            //     Visible = VisibleAstroLinePick;
            // }
            // field("Prod. OUTPUT Interface Astro";"Prod. OUTPUT Interface Astro")
            // {
            //     Visible = VisibleAstroOutput;
            // }
            // field("Parked OUTPUT Astro";"Parked OUTPUT Astro")
            // {
            //     Visible = VisibleAstroOutput;
            // }
            // field("Last Parked Date OUTPUT Astro";"Last Parked Date OUTPUT Astro")
            // {
            //     Visible = VisibleAstroOutput;
            // }
            // field("Last Parked Time OUTPUT Astro";"Last Parked Time OUTPUT Astro")
            // {
            //     Visible = VisibleAstroOutput;
            // }
            // field("Posted OUTPUT Astro";"Posted OUTPUT Astro")
            // {
            //     Visible = VisibleAstroOutput;
            // }
            // field("OUTPUT Revers Interface Astro";"OUTPUT Revers Interface Astro")
            // {
            //     Visible = VisibleAstroOutputReversal;
            // }
            // field("Parked OUTPUT Revers Astro";"Parked OUTPUT Revers Astro")
            // {
            //     Visible = VisibleAstroOutputReversal;
            // }
            // field("Last Parked Date OUTPUTR Astro";"Last Parked Date OUTPUTR Astro")
            // {
            //     Visible = VisibleAstroOutputReversal;
            // }
            // field("Last Parked Time OUTPUTR Astro";"Last Parked Time OUTPUTR Astro")
            // {
            //     Visible = VisibleAstroOutputReversal;
            // }
            // field("Posted OUTPUT Revers Astro";"Posted OUTPUT Revers Astro")
            // {
            //     Visible = VisibleAstroOutputReversal;
            // }
            // field("Prod. CLOSE Interface Astro";"Prod. CLOSE Interface Astro")
            // {
            //     Visible = VisibleAstroClose;
            // }
            // field("Last Parked Date CLOSE Astro";"Last Parked Date CLOSE Astro")
            // {
            //     Visible = VisibleAstroClose;
            // }
            // field("Last Parked Time CLOSE Astro";"Last Parked Time CLOSE Astro")
            // {
            //     Visible = VisibleAstroClose;
            // }
            // BC Upgrade SHUKLP03 << Astro fields are blocked.
        }
    }
    actions
    {
        addafter(Statistics)
        {
            separator(Separator1100910002)
            {
            }
            action(Losses)
            {
                CaptionML = ENU = 'Losses',
                            FRA = 'Pertes';
                Image = GainLossEntries;
                ApplicationArea = All;
                ToolTip = 'Executes the Losses action.';

                trigger OnAction();
                var
                    CapacityLedgerEntry: Record "Capacity Ledger Entry";
                //BrewingLosses : Page "Brewing Losses";  // BC Upgrade SHUKLP03 << DrinkIT page is blocked.
                begin
                    // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                    // <<DITW17.00.01 KCO 18/03/2013 DIT-770 #001
                    CapacityLedgerEntry.SETRANGE("Order Type", CapacityLedgerEntry."Order Type"::Production);
                    CapacityLedgerEntry.SETRANGE("Order No.", Rec."No.");

                    // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
                    // // >>DITW17.00.01 KCO DIT-770 #001
                    // BrewingLosses.SETTABLEVIEW(CapacityLedgerEntry);
                    // BrewingLosses.RUNMODAL;
                    // // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
                    // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
                end;
            }
        }
        addafter("Create Inventor&y Put-away/Pick/Movement")
        {
            // BC Upgrade SHUKLP03 >> DrinkIT code is blocked.
            // action("Print SSCC")
            // {
            //     CaptionML = ENU = 'Print SSCC',
            //                 FRA = 'Imprimer SSCC';

            //     trigger OnAction();
            //     var
            //     // lfrmPrintLabels: Page "Print Labels"; // BC Upgrade SHUKLP03 << DrinkIT field is blocked.
            //     begin
            //         // <<DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
            //         lfrmPrintLabels.SetProdOrder(Rec);
            //         lfrmPrintLabels.RUNMODAL();
            //         // >>DITW16.00.00.43 RBE DIT-715 #806

            //     end;
            // }
            // separator(Separator1100910001)
            // {
            // }
            // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
            action("Register Loss Strength Journal")
            {
                CaptionML = ENU = 'Register Loss Strength Journal',
                            FRA = 'Valider journal perte contrainte';
                Ellipsis = true;
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Register Loss Strength Journal action.';

                trigger OnAction();
                begin
                    // <<DITW19.00.08 DDR 20/10/2016 BL#10443
                    // OpenLossOutputJournal; // BC Upgrade SHUKLP03 << DrinkIT code is blocked.
                end;
            }
        }
        //BC Upgrade GUNREM01 moved this action to DTW ext >>

        // addafter("Production Order Statistics")
        // {
        //     action(ProcessOrderGoodsMovement)
        //     {
        //         Caption = 'Process Order Goods Movement';
        //         Image = "Report";
        //         Promoted = true;
        //         PromotedCategory = "Report";
        //         ApplicationArea = All;
        //         ToolTip = 'Executes the Process Order Goods Movement action.';

        //         trigger OnAction();
        //         var
        //             ProductionOrder: Record "Production Order";
        //         begin
        //             //HEI.01>>
        //             ProductionOrder.RESET();
        //             ProductionOrder.SETRANGE(ProductionOrder.Status, Rec.Status);
        //             ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
        //             REPORT.RUN(50003, true, true, ProductionOrder);
        //             //HEI.01<<
        //         end;
        //     }
        // }

        //BC Upgrade GUNREM01 moved this action to DTW ext <<
    }


    //Unsupported feature: PropertyModification on "ManuPrintReport(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ManuPrintReport : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ManuPrintReport : 2036301;
    //Variable type has not been exported.

    var
        UserMgt: Codeunit "User Setup Management";
        decActualCost: Decimal;
        decActualVsPlannedCritical: Decimal;
        decActualVsPlannedHours: Decimal;
        decActualVsPlannedOperations: Decimal;
        decActualVsPlannedQty: Decimal;
        decActualVsPlannedSubcontract: Decimal;
        decExpectedCost: Decimal;
        decExpectedVsActualCost: Decimal;
        decFinishedQty: Decimal;
        decPlannedCritical: Decimal;
        decPlannedHours: Decimal;
        decPlannedOperations: Decimal;
        decPlannedQty: Decimal;
        decPlannedSubcontract: Decimal;
        decStandardCost: Decimal;
        decStandardVsActualCost: Decimal;
        decStandardVsExpectedCost: Decimal;
    //rMANXLSetup: Record "Manufacturing XL Setup";

    var
        HeinekenGlobal: Codeunit "Heineken Global";
        VisibleAstro: Boolean;
        VisibleAstroClose: Boolean;
        VisibleAstroLinePick: Boolean;
        VisibleAstroOutput: Boolean;
        VisibleAstroOutputReversal: Boolean;
        TileRespCenterFilter: Text;
        LotNo: Text[50];


    //Unsupported feature: CodeInsertion on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //begin
    /*
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then begin
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 04/03/2014 #13
      //<<DITW110.00.12A HBA 05/06/2018 NRQ#72678
      decActualVsPlannedQty:= fctCalcQuantityPlannedVsAct(decPlannedQty,decFinishedQty);
      //>>DITW110.00.12A HBA 05/06/2018 NRQ#72678
      //HEI.15>>
      {
      decActualVsPlannedOperations:= fctCalcOperationsPlannedVsAct(decPlannedOperations);
      decActualVsPlannedHours:= fctCalcHoursPlannedVsAct(decPlannedHours);
      decActualVsPlannedSubcontract:= fctCalcSubcontrPlannedVsAct(decPlannedSubcontract);
      decActualVsPlannedCritical:= fctCalcCriticalPlannedVsAct(decPlannedCritical);
      }
      //HEI.15<<
      //HEI.14>>
      {
      fctCalcStatisticalInfo(decActualCost,decStandardCost,decExpectedCost,decStandardVsActualCost,decStandardVsExpectedCost,
                             decExpectedVsActualCost);
      }
      //HEI.14<<
      //>>MANXL7.00.001 DAT 04/03/2014 #13
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    end;
    //>>MANXL7.00.001 WSA 11/07/2014 #87
    //HEI.04>>
     //LotNo := HeinekenGlobal.GetLotItemTracking(Rec."No.");//HEI.15
    //HEI.04<<
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then begin
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 04/03/2014 #13
      decActualVsPlannedQty:= 0;
      decPlannedQty:= 0;
      //<<DITW110.00.12A HBA 05/06/2018 NRQ#72678
      decFinishedQty := 0;
      //>>DITW110.00.12A HBA 05/06/2018 NRQ#72678
      decActualVsPlannedOperations:= 0;
      decPlannedOperations:= 0;
      decActualVsPlannedHours:= 0;
      decPlannedHours:= 0;
      decActualVsPlannedSubcontract:= 0;
      decPlannedSubcontract:= 0;
      decActualVsPlannedCritical:= 0;
      decPlannedCritical:= 0;
      decActualCost:= 0;
      decStandardCost:= 0;
      decExpectedCost:= 0;
      decStandardVsActualCost:= 0;
      decStandardVsExpectedCost:= 0;
      decExpectedVsActualCost:= 0;
      //>>MANXL7.00.001 DAT 04/03/2014 #13
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    end;
    //>>MANXL7.00.001 WSA 11/07/2014 #87
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    trigger OnOpenPage();
    var
    // AstroInterfaceSetupL: Record "Astro Interface Setup";
    // InterfaceSetupL: Record "Interface Setup"; // BC Upgrade SHUKLP03 << Interface Setup is blocked.
    begin

        // // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        // SetSecurityFilterOnRespCenter();
        // // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192

        //HEI.06>>
        TileRespCenterFilter := REC.GETFILTER("Role Centre Tile Code FND");
        if TileRespCenterFilter <> '' then begin
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Role Centre Tile Code FND", TileRespCenterFilter);
            Rec.FILTERGROUP(0);
        end;
        //HEI.06<<

        // BC Upgrade SHUKLP03 >> Astro code is blocked.
        // //HEI.09>>
        // CLEAR(VisibleAstro);
        // //HEI.10>>
        // CLEAR(VisibleAstroClose);
        // //HEI.10<<
        // //HEI.11>>
        // CLEAR(VisibleAstroOutput);
        // //HEI.11<<
        // //HEI.12>>
        // CLEAR(VisibleAstroLinePick);
        // //HEI.12<<
        // //HEI.13>>
        // CLEAR(VisibleAstroOutputReversal);
        // //HEI.13<<
        // if AstroInterfaceSetupL.GET and AstroInterfaceSetupL."Enabled Astro Integration" then begin
        //     if AstroInterfaceSetupL."Activate Prod. Order" then begin
        //         if AstroInterfaceSetupL."Prod. Order Interface" <> '' then begin
        //             if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Interface") then
        //                 VisibleAstro := true;
        //         end;
        //         //HEI.10>>
        //         CLEAR(InterfaceSetupL);
        //         if AstroInterfaceSetupL."Prod. Order Close Interface" <> '' then begin
        //             if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Close Interface") then
        //                 VisibleAstroClose := true;
        //         end;
        //         //HEI.10<<
        //         //HEI.11>>
        //         CLEAR(InterfaceSetupL);
        //         if AstroInterfaceSetupL."Prod. Order Output Interface" <> '' then begin
        //             if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Output Interface") then
        //                 VisibleAstroOutput := true;
        //         end;
        //         //HEI.11<<
        //         //HEI.12>>
        //         CLEAR(InterfaceSetupL);
        //         if AstroInterfaceSetupL."Prod. Order LinePick Interface" <> '' then begin
        //             if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order LinePick Interface") then
        //                 VisibleAstroLinePick := true;
        //         end;
        //         //HEI.12<<
        //     end;
        //     //HEI.13>>
        //     CLEAR(InterfaceSetupL);
        //     if AstroInterfaceSetupL."Activate Inventory Balance" then begin
        //         if AstroInterfaceSetupL."Balance Change Interface" <> '' then begin
        //             if InterfaceSetupL.GET(AstroInterfaceSetupL."Balance Change Interface") then begin
        //                 if (AstroInterfaceSetupL."Output Revers Journal Template" <> '') and
        //                   (AstroInterfaceSetupL."Output Revers Journal Batch" <> '') then
        //                     VisibleAstroOutputReversal := true;
        //             end;
        //         end;
        //     end;
        //     //HEI.13<<
        // end;
        // //HEI.09<<
        // BC Upgrade SHUKLP03 << Astro code is blocked.
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

