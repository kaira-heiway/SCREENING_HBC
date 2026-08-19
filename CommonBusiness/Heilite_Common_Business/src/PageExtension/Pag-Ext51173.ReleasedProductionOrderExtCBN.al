pageextension 51173 ReleasedProductionOrderExtCBN extends "Released Production Order"
{

    // version NAVW110.0,FINXL8.00.001,MANXL10.01,DITW110.00.12A,HEI.16


    // DITW14.00.00.8 PROD: BrewIt & Quality
    // DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //                                issue 768 Added to set non-editable fields
    //                                  "Gen. Bus. Posting Group","Gen. Prod. Posting Group","Inventory Posting Group"
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM

    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Emergency Order"
    // MANXL7.00.001 DAT 03/03/2014 #10: Create Head group for subcontracting
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 DAT 03/03/2014 #13: KPI factbox
    // MANXL7.00.001 WSA 26/09/2014 : Ovoid Rec Inserted Twice
    // MANXL8.00.001 BSA 28/04/2015 #19: Print Prod. Order - Job Card

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.12 AKH 21/03/2018 NRQ#64704 Added fields "Unit of Measure Code"
    //                                                     "Quantity (Base)"
    //                                                     "Quantity HL"
    // DITW110.00.12A HBA 18/06/2018 NRQ#68221 Copied fields "Location Code", "Bin Code" to the General Fastab renamed to LocationCodeNew, BinCodeNew
    //                                         Added fields "Routing Version Code"
    //                                                      "Routing Version Description"
    //                                                      "Production BOM No."
    //                                                      "Production BOM Version Code"
    //                                                      "Production BOM Version Desc."
    //                                         Added Code for fields Visibility "Routing Version Code","Routing Version Description", "Production BOM No.", "Production BOM Version Code"
    //                                           "Production BOM Version Desc." and "Unit of Measure Code"
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt
    //   #Add field "Zone Code"
    // HEI.02 FDD-PRDGAP039 IBM.HORTOC01 13/07/2017
    //   # Page action ProcessOrderGoodsMovement
    // HEI.03 RFC-CHG0257267 IBM.SS 11.01.2019
    //   # Code added On Refresh production Order action
    // HEI.04 CHG0270593 - IBM ISYED01 2.15.2019
    //   # Removed Caption Class to "Gyle no" to display on the page.
    // HEI.05 FDD – HT938 IBM TUDOSG01
    //   #error message modified
    // HEI.06 CHG2069358 IBM.AK 25.08.20
    //  # new field added on -"Created By"
    // HEI.07 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //   # Code added in OnClosePage
    // HEI.08 CHG2101736 IBM.LS      17.03.2021
    //   # Added Code
    // HEI.10 IBM.LS RITM2817451 29-09-21
    // # Autotestscript-Copied page action  RefreshProductionOrder to Action 26
    // HEI.11 CHG2129985 SAHAL01      14.04.2022
    //   # Added New Tab - LogoPak
    //   # Added New Fields - Prod. Order Interface
    //                      - Prod. Order Output Interface
    //                      - Parked for LogoPak
    //                      - Parked from LogoPak
    //                      - Posted from LogoPak
    //   # Added New Action - Send For LogoPak
    //   # Added Code
    //   # Added Code to visible LogoPak Tab
    // HEI.12 RITM3007822 IBM GOKULS01
    // #Commented code for Modify in close page due to testscript failure
    // HEI.13 CHG2149734 SAHAL01 08.09.2022
    //   # Added New Tab - Astro
    //   # Added New Group - Outbound - Prod. Order Sync Info.
    //   # Added New Fields - Prod. ORDER Interface Astro
    //                      - Parked ORDER Astro
    //                      - Last Parked Date ORDER Astro
    //                      - Last Parked Time ORDER Astro
    //   # Added Code to visible Astro Tab
    //   # Added New Action - Send For Astro
    //   # Added Code
    // HEI.14 CHG2154367 SAHAL01 12.09.2022
    //   # Added New Group - Inbound - Prod. Order Output Info.
    //   # Added New Fields - Prod. OUTPUT Interface Astro
    //                      - Parked OUTPUT Astro
    //                      - Last Parked Date OUTPUT Astro
    //                      - Last Parked Time OUTPUT Astro
    //                      - Posted OUTPUT Astro
    // HEI.15 CHG2154364 SAHAL01 20.10.2022
    //   # Added New Group - Inbound - Prod. Order Line Pick Info.
    //   # Added New Fields - Prod. LINEPICK Interface Astro
    //                      - Parked LINEPICK Astro
    //                      - Last Parked Date LINEPICKAstro
    //                      - Last Parked Time LINEPICKAstro
    //                      - Posted LINEPICK Astro
    // HEI.16 CHG2154372 SAHAL01 15.12.2022 Astro - I/F Inventory Management - BalanceChange
    //   # Added New Group - Inbound - Prod. Order Output Reversal Info.
    //   # Added New Fields - OUTPUT Revers Interface Astro
    //                      - Parked OUTPUT Revers Astro
    //                      - Last Parked Date OUTPUTR Astro
    //                      - Last Parked Time OUTPUTR Astro
    //                      - Posted OUTPUT Revers Astro
    //   # Added Code to visible Astro Fields

    //Bc Upgrade YADAVM09 starting date,starting time,Ending date,Ending time field obselete in base and created new field ""Starting Date-Time","Ending Date-Time" which is already there in base base
    // Bc Upgrade YADAVM09 RefreshProductionOrder is hide and created RefreshProductionOrder2.
    //Bc Upgrade YADAVM09 Action Create Whse. Pick is obselete from base.

    layout
    {
        //BC upgrade Kamnay01>>Added DITW field 
        addafter(Quantity)
        {
            field("Unit of Measure Code"; Rec."Unit of Measure Code FND")
            {
                ApplicationArea = All;
            }
        }
        //BC upgrade Kamnay01<<Added DITW field
        //BC upgrade Kamnay01 >>visible false for both fields as these fields 
        modify("Starting Date-Time")
        {
            Visible = false;
        }
        modify("Ending Date-Time")
        {
            Visible = false;
        }
        //BC upgrade Kamnay01 <<visible false for both fields as these fields

        modify(General)
        {

            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production order.', FRA = 'Spécifie le numéro de l''ordre de fabrication.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the description of the production order.', FRA = 'Spécifie la description de l''ordre de fabrication.';
        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies an additional part of the production order description.', FRA = 'Spécifie un complément à la description de l''ordre de fabrication.';
        }
        modify("Source Type")
        {
            ToolTipML = ENU = 'Specifies the source type of the production order.', FRA = 'Spécifie le type origine de l''ordre de fabrication.';
        }
        modify("Source No.")
        {
            ToolTipML = ENU = 'Specifies the source number of the production order.', FRA = 'Spécifie le numéro origine de l''ordre de fabrication.';
        }
        modify("Search Description")
        {
            ToolTipML = ENU = 'Specifies the search description.', FRA = 'Spécifie la description de recherche.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies how many units of the item or the family to produce (production quantity).', FRA = 'Spécifie le nombre d''unités de l''article ou de la famille produits à produire (quantité de production).';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Specifies the due date of the production order.', FRA = 'Spécifie la date d''échéance de l''ordre de fabrication.';
        }
        modify("Assigned User ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the user who is responsible for the document.', FRA = 'Spécifie le code de l''utilisateur qui est responsable du document.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies whether the posting of consumption and output for the released production order is blocked.', FRA = 'Indique si la validation de la consommation et de la production de l''ordre de fabrication lancé est bloquée.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the production order card was last modified.', FRA = 'Indique la date à laquelle la fiche ordre de fabrication a été modifiée pour la dernière fois.';
        }
        modify(Schedule)
        {
            CaptionML = ENU = 'Schedule', FRA = 'Planifié';
        }
        /* Bc Upgrade YADAVM09 field obselete in base and created new field ""Starting Date-Time","Ending Date-Time">>
        modify("Starting Time")
        {
            ToolTipML = ENU = 'Specifies the starting time of the production order.', FRA = 'Spécifie l''heure de début de l''ordre de fabrication.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the starting date of the production order.', FRA = 'Spécifie la date de début de l''ordre de fabrication.';
        }
        modify("Ending Time")
        {
            ToolTipML = ENU = 'Specifies the ending time of the production order.', FRA = 'Spécifie l''heure de fin de l''ordre de fabrication.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies the ending date of the production order.', FRA = 'Spécifie la date de fin de l''ordre de fabrication.';
        }
    */ //Bc Upgrade YADAVM09 field obselete in base and created new field ""Starting Date-Time","Ending Date-Time"<<
        modify(Posting)
        {
            CaptionML = ENU = 'Posting', FRA = 'Validation';
        }
        modify("Inventory Posting Group")
        {
            ToolTipML = ENU = 'Specifies the inventory posting group in order to assign the WIP to the correct general ledger account.', FRA = 'Spécifie le groupe comptabilisation stock pour affecter les TEC au compte général qui convient.';

            //Unsupported feature: Change Editable on ""Inventory Posting Group"(Control 81)". Please convert manually.

        }
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a product posting group associated with manufactured items in this production order.', FRA = 'Indique un groupe comptabilisation produit auquel appartiennent des articles fabriqués dans cet ordre de fabrication.';

            //Unsupported feature: Change Editable on ""Gen. Prod. Posting Group"(Control 83)". Please convert manually.

        }
        modify("Gen. Bus. Posting Group")
        {
            ToolTipML = ENU = 'Specifies a business posting group.', FRA = 'Spécifie un groupe comptabilisation marché.';

            //Unsupported feature: Change Editable on ""Gen. Bus. Posting Group"(Control 85)". Please convert manually.

        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension associated with the production order.', FRA = 'Spécifie le code de la section analytique associée à l''ordre de fabrication.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies the code for the dimension associated with the production order.', FRA = 'Spécifie le code de la section analytique associée à l''ordre de fabrication.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code to which you want to post the finished product from this production order.', FRA = 'Spécifie le code magasin sur lequel le produit fini doit être validé à partir de cet ordre de fabrication.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies a bin to which you want to post the finished items.', FRA = 'Spécifie un emplacement sur lequel vous souhaitez valider les articles terminés.';
        }
          //BC Upgrade GUNREM01 >>
        moveafter("Search Description"; "Location Code")
        //BC Upgrade GUNREM01 >>
        // BC Upgrade Kamnay01>>Added fields 
        addafter(Schedule)
        {
            field("Starting Date"; Rec."Starting Date")
            {
                ApplicationArea = All;
            }
            field("Starting Time"; Rec."Starting Time")
            {
                ApplicationArea = All;
            }
            field("Ending Date"; Rec."Ending Date")
            {
                ApplicationArea = All;
            }
            field("Ending Time"; Rec."Ending Time")
            {
                ApplicationArea = All;
            }
        }
        //BC upgrade Kamnay01<<Added fields

        //Unsupported feature: CodeModification on ""Source Type"(Control 11).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if xRec."Source Type" <> "Source Type" then
          "Source No." := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if xRec."Source Type" <> "Source Type" then
          "Source No." := '';
        //<<MANXL7.00.001 WSA 11/07/2014 #87
        if rMANXLSetup.READPERMISSION then begin
        //>>MANXL7.00.001 WSA 11/07/2014 #87
          //<<MANXL7.00.001 DAT 03/03/2014 #12
          blnRevisionNoEnabled:= ("Source Type" = "Source Type"::Item);
          //<< DITW110.00.12A HBA 18/06/2018 NRQ#68221
          blnEnabled := ("Source Type" = "Source Type"::Item);
          //>> DITW110.00.12A HBA NRQ#68221
          CurrPage.UPDATE;
          //>>MANXL7.00.001 DAT 03/03/2014 #12
        //<<MANXL7.00.001 WSA 11/07/2014 #87
        end;
        //>>MANXL7.00.001 WSA 11/07/2014 #87
        */
        //end;


        //Unsupported feature: CodeInsertion on ""Location Code"(Control 42)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
        if "Location Code" <> xRec."Location Code" then
          CurrPage.UPDATE(true);
        // >>DITW18.00.06 MSF DIT-770 #1192
        */
        //end;

        //Bc Upgrade YADAVM09 Drink it field commented>>
        // modify(Control1900383207)
        // {
        //     Visible = false;
        // }
        // addafter("Source No.")
        // {
        //     field(LocationCodeNew; "Location Code")
        //     {
        //         Description = 'DITW110.00.12A NRQ#68221';
        //         Importance = Promoted;
        //         ToolTip = 'Specifies the location code to which you want to post the finished product from this production order.';

        //         trigger OnValidate();
        //         begin
        //             //<< DITW110.00.12A HBA 18/06/2018 NRQ#68221
        //             if "Location Code" <> xRec."Location Code" then
        //                 CurrPage.UPDATE(true);
        //             //>> DITW110.00.12A HBA NRQ#68221
        //         end;
        //     }
        //     field(BinCodeNew; "Bin Code")
        //     {
        //         Description = 'DITW110.00.12A NRQ#68221';
        //         Importance = Promoted;
        //         ToolTip = 'Specifies a bin to which you want to post the finished items.';
        //     }
        //     field("Revision No."; "Revision No.")
        //     {
        //         Description = 'MANXL7.00.001';
        //         Enabled = blnRevisionNoEnabled;
        //     }
        //     field("Routing No."; "Routing No.")
        //     {
        //         Description = 'DITW110.00.12A NRQ#68221';
        //         Editable = blnEnabled;
        //     }
        //     field("Routing Version Code"; "Routing Version Code")
        //     {
        //         Editable = blnEnabled;
        //     }
        //     field("Routing Version Description"; "Routing Version Description")
        //     {
        //         Importance = Additional;
        //     }
        //     field("Production BOM No."; "Production BOM No.")
        //     {
        //         Enabled = blnEnabled;
        //     }
        //     field("Production BOM Version Code"; "Production BOM Version Code")
        //     {
        //         Editable = blnEnabled;
        //     }
        //     field("Production BOM Version Desc."; "Production BOM Version Desc.")
        //     {
        //         Importance = Additional;
        //     }

        //    //BC Upgrade GUNREM01 >> Added DIT Field
        addafter(Quantity)
        {
            field("Gyle No."; Rec."Gyle No. FND")
            {
                applicationArea = all;
                CaptionML = ENU = 'Ref No.',
                            FRA = 'Gyle N°';
            }
        }
        //BC Upgrade GUNREM01 << Added DIT Field

        // addafter("Search Description")
        // {
        //     field("Unit of Measure Code"; "Unit of Measure Code")
        //     {
        //         Description = 'DITW110.00.12 NRQ#64704 - DITW110.00.12A NRQ#68221';
        //         Editable = blnEnabled;
        //     }
        // }
        // addafter(Quantity)
        // {
        //     field("Quantity (Base)"; "Quantity (Base)")
        //     {
        //         Importance = Additional;
        //     }
        //     field("Quantity HL"; "Quantity HL")
        //     {
        //     }
        // }
        //   //Bc Upgrade YADAVM09 Drink it field commented<<
        addafter("Last Date Modified")
        {
            /* //Bc Upgrade YADAVM09 Drink it field commented>>
            field("Emergency Order"; Rec."Emergency Order")
            {
            }
            */ //Bc Upgrade YADAVM09 Drink it field commented<<
            field("Created By"; Rec."Created By FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Created By field.';
            }
        }
        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        addafter("Shortcut Dimension 2 Code")
        {
            field("Responsibility Center"; "Responsibility Center")
            {
                Importance = Promoted;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                    if "Responsibility Center" <> xRec."Responsibility Center" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 MSF DIT-770 #1192
                end;
            }
            field("Physical Location Group Code"; "Physical Location Group Code")
            {
                Importance = Promoted;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                    if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 MSF DIT-770 #1192
                end;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        addafter("Location Code")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }

        }
        addafter(Quantity)
        {
            //BC upgrade GUNREM01 added DITW fields and code >>
            field("Prod. BOM No. 112FDW"; Rec."Prod. BOM No. 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Prod. BOM No. 112FDW field.';

            }

            field("Prod. BOM Vrsn Code 112FDW"; Rec."Prod. BOM Vrsn Code 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Prod. BOM Vrsn Code 112FDW field.';

                // trigger onlookup(var Text: Text): Boolean
                // var

                //     Productionbomversion: Record "Production BOM Version";
                // begin
                //     Productionbomversion.Reset();
                //     Productionbomversion.SetRange("Production BOM No.", rec."Prod. BOM No. 112FDW");
                //     Productionbomversion.SetFilter(Status, '%1', Productionbomversion.Status::Certified);

                //     if Page.RunModal(Page::"Prod. BOM Version List", Productionbomversion) = Action::LookupOK then begin
                //         Rec."Prod. BOM No. 112FDW" := Productionbomversion."Production BOM No.";
                //         exit(true);
                //     end;
                // end;
            }
            field("Routing No. 112FDW"; Rec."Routing No. 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Routing No. 112FDW field.';
            }
            field("Routing Version Code 112FDW"; Rec."Routing Vrsn Code 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Routing Version Code 112FDW field.';
                // trigger onlookup(var Text: Text): Boolean
                // var

                //     RoutingVersion: Record "Routing Version";
                // begin
                //     RoutingVersion.Reset();
                //     RoutingVersion.SetRange("Routing No.", rec."Routing No. 112FDW");
                //     RoutingVersion.SetFilter(Status, '%1', RoutingVersion.Status::Certified);

                //     if Page.RunModal(Page::"Routing Version List", RoutingVersion) = Action::LookupOK then begin
                //         Rec."Routing No. 112FDW" := RoutingVersion."Routing No.";
                //         exit(true);
                //     end;
                // end;
            }
        }
        //BC upgrade GUNREM01 added DITW fields and code <<

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
                addafter(Posting)
                {

                    group(Head)
                    {
                        CaptionML = ENU = 'Head',
                                           FRA = 'Tête';
                        Description = 'MANXL7.00.001';
                        field("Item Category Code"; "Item Category Code")
                        {
                            Description = 'MANXL7.00.001';
                        }
                        field("Item Product Group Code"; "Item Product Group Code")
                        {
                            Description = 'MANXL7.00.001';
                        }
                        field("Planning Group"; "Planning Group")
                        {
                            Description = 'MANXL7.00.001';
                        }
                        field("Production Group"; "Production Group")
                        {
                            Description = 'MANXL7.00.001';
                        }
                    }

                    group(Quality)
                    {
                        CaptionML = ENU = 'Quality',
                                           FRA = 'Qualité';
                        field("No. of Lot Tests"; "No. of Lot Tests")
                        {
                        }
                        field("No. of In Process Tests"; "No. of In Process Tests")
                        {
                        }
                    }

                    group("Tax - Strength")
                    {
                        CaptionML = ENU = 'Tax - Strength',
                                           FRA = 'Contrainte -Taxe';
                        field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
                        {
                            Importance = Promoted;
                        }
                        field("Exist Loss Strength Journal"; "Exist Loss Strength Journal")
                        {

                            trigger OnDrillDown();
                            begin
                                OpenLossOutputJournal;
                            end;
                        }

                       group(Volumes)
                       {
                           CaptionML = ENU = 'Volumes',
                                                   FRA = 'Volumes';
                           grid(Control1100910007)
                           {
                               GridLayout = Rows;
                               group(Control1100910008)
                               {
                                   field("Consumption Vol-Strength Value"; "Consumption Vol-Strength Value")
                                   {
                                       CaptionClass = PageCaptionClassText(Text2013661);
                                       CaptionML = ENU = 'Consumption',
                                                               FRA = 'Consommation';
                                   }
                                   field("Output Vol-Strength Value"; "Output Vol-Strength Value")
                                   {
                                       CaptionClass = PageCaptionClassText(Text2013662);
                                       CaptionML = ENU = 'Output',
                                                               FRA = 'Production';
                                   }
                                   field("Loss Vol-Strength Value"; "Loss Vol-Strength Value")
                                   {
                                       CaptionClass = PageCaptionClassText(Text2013663);
                                       CaptionML = ENU = 'Loss',
                                                               FRA = 'Perte';
                                   }
                                   field("""Balance Vol-Strength Value""-""Loss Vol-Strength Value"""; "Balance Vol-Strength Value" - "Loss Vol-Strength Value")
                                   {
                                       AutoFormatExpression = GetGlobalTaxSpecFormatType(FIELDNO("Balance Vol-Strength Value"));
                                       AutoFormatType = 2013664;
                                       CaptionClass = PageCaptionClassText(Text2013660);
                                       CaptionML = ENU = 'Balance',
                                                               FRA = 'Solde';
                                       DrillDown = true;

                                       trigger OnDrillDown();
                                       begin
                                           //workaround
                                       end;
                                   }
                               }
                           }
                       }
                   }*/ //Bc Upgrade YADAVM09 Drink it field commented<<
                       /* //Bc Upgrade YADAVM09 Interface Extension page is created>>
                        group(LogoPak)
                        {
                            Caption = 'LogoPak';
                            Visible = VisibleLogoPak;
                            group(Outbound)
                            {
                                Caption = 'Outbound';
                                field("Prod. Order Interface"; Rec."Prod. Order Interface")
                                {
                                    Editable = false;
                                }
                                field("Parked for LogoPak"; Rec."Parked for LogoPak")
                                {
                                    Editable = false;
                                }
                            }
                            group(Inbound)
                            {
                                Caption = 'Inbound';
                                field("Prod. Order Output Interface"; Rec."Prod. Order Output Interface")
                                {
                                    Editable = false;
                                }
                                field("Parked from LogoPak"; Rec."Parked from LogoPak")
                                {
                                    Editable = false;
                                }
                                field("Posted from LogoPak"; Rec."Posted from LogoPak")
                                {
                                    Editable = false;
                                }
                            }
                           
    }
     */ //Bc Upgrade YADAVM09 Interface Extension page is created<<
        /* Bc Upgrade YADAVM09 Astro Field blocked>>
        group(Astro)
        {
            Caption = 'Astro';
            Visible = VisibleAstro;
            group("Outbound - Prod. Order Sync Info.")
            {
                Caption = 'Outbound - Prod. Order Sync Info.';
                field("Prod. ORDER Interface Astro"; "Prod. ORDER Interface Astro")
                {
                    Editable = false;
                }
                field("Parked ORDER Astro"; "Parked ORDER Astro")
                {
                    Editable = false;
                }
                field("Last Parked Date ORDER Astro"; "Last Parked Date ORDER Astro")
                {
                    Editable = false;
                }
                field("Last Parked Time ORDER Astro"; "Last Parked Time ORDER Astro")
                {
                    Editable = false;
                }
            }
            group("Inbound - Prod. Order Line Pick Info.")
            {
                Caption = 'Inbound - Prod. Order Line Pick Info.';
                field("Prod. LINEPICK Interface Astro"; "Prod. LINEPICK Interface Astro")
                {
                    Editable = false;
                }
                field("Parked LINEPICK Astro"; "Parked LINEPICK Astro")
                {
                    Editable = false;
                }
                field("Last Parked Date LINEPICKAstro"; "Last Parked Date LINEPICKAstro")
                {
                    Editable = false;
                }
                field("Last Parked Time LINEPICKAstro"; "Last Parked Time LINEPICKAstro")
                {
                    Editable = false;
                }
                field("Posted LINEPICK Astro"; "Posted LINEPICK Astro")
                {
                    Editable = false;
                }
            }
            group("Inbound - Prod. Order Output Info.")
            {
                Caption = 'Inbound - Prod. Order Output Info.';
                field("Prod. OUTPUT Interface Astro"; "Prod. OUTPUT Interface Astro")
                {
                    Editable = false;
                }
                field("Parked OUTPUT Astro"; "Parked OUTPUT Astro")
                {
                    Editable = false;
                }
                field("Last Parked Date OUTPUT Astro"; "Last Parked Date OUTPUT Astro")
                {
                    Editable = false;
                }
                field("Last Parked Time OUTPUT Astro"; "Last Parked Time OUTPUT Astro")
                {
                    Editable = false;
                }
                field("Posted OUTPUT Astro"; "Posted OUTPUT Astro")
                {
                    Editable = false;
                }
            }
            group("Inbound - Prod. Order Output Reversal Info.")
            {
                Caption = 'Inbound - Prod. Order Output Reversal Info.';
                field("OUTPUT Revers Interface Astro"; "OUTPUT Revers Interface Astro")
                {
                    Editable = false;
                }
                field("Parked OUTPUT Revers Astro"; "Parked OUTPUT Revers Astro")
                {
                    Editable = false;
                }
                field("Last Parked Date OUTPUTR Astro"; "Last Parked Date OUTPUTR Astro")
                {
                    Editable = false;
                }
                field("Last Parked Time OUTPUTR Astro"; "Last Parked Time OUTPUTR Astro")
                {
                    Editable = false;
                }
                field("Posted OUTPUT Revers Astro"; "Posted OUTPUT Revers Astro")
                {
                    Editable = false;
                }
            }
        }
          }
        */ //Bc Upgrade YADAVM09 Astro Field blocked<<


        // addfirst(Control1900000007)
        // { /* //Bc Upgrade YADAVM09 Already avaliable in base
        /* //Bc UPgrade YADAVM09 Drink code commented>>
        part(KPI; "Production KPI FactBox")
        {
            CaptionML = ENU = 'KPI',
                        FRA = 'KPI';
            Description = 'MANXL7.00.001';
            SubPageLink = Status = FIELD(Status),
                          "No." = FIELD("No.");
            SubPageView = sorting(Status, "No.");
            Visible = false;
        }
        */ //Bc UPgrade YADAVM09 Drink it field commented<<

        //     systempart(Control9; Links)
        //     {
        //         Visible = false;
        //     }
        // } //Bc Upgrade YADAVM09 Already avaliable in base

    }

    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = '&O.F.';
        }
        modify("E&ntries")
        {
            CaptionML = ENU = 'E&ntries', FRA = 'É&critures';
        }
        modify("Item Ledger E&ntries")
        {
            CaptionML = ENU = 'Item Ledger E&ntries', FRA = 'É&critures comptables article';
        }
        modify("Capacity Ledger Entries")
        {
            CaptionML = ENU = 'Capacity Ledger Entries', FRA = 'Écritures comptables capacité';
        }
        modify("Value Entries")
        {
            CaptionML = ENU = 'Value Entries', FRA = 'Écritures valeur';
        }
        modify("&Warehouse Entries")
        {
            CaptionML = ENU = '&Warehouse Entries', FRA = 'Écritures &entrepôt';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Planning)
        {
            CaptionML = ENU = 'Plannin&g', FRA = 'Plannin&g';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
            Promoted = true;
            PromotedCategory = Process;
        }
        modify("Put-away/Pick Lines/Movement Lines")
        {
            CaptionML = ENU = 'Put-away/Pick Lines/Movement Lines', FRA = 'Lignes rangement/prélèvement/mouvement';
        }
        modify("Registered P&ick Lines")
        {
            CaptionML = ENU = 'Registered P&ick Lines', FRA = '&Lignes prélèvement enreg.';
        }
        modify("Registered Invt. Movement Lines")
        {
            CaptionML = ENU = 'Registered Invt. Movement Lines', FRA = 'Lignes mouvement stock enreg.';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(RefreshProductionOrder)
        {
            Visible = false;//Bc Upgrade YADAVM09 
            CaptionML = ENU = 'Re&fresh Production Order', FRA = 'Ac&tualiser O.F.';
        }
        modify("Re&plan")
        {
            CaptionML = ENU = 'Re&plan', FRA = 'Re&planifier';
        }
        modify("Change &Status")
        {
            CaptionML = ENU = 'Change &Status', FRA = 'Changer &statut';
        }
        modify("&Update Unit Cost")
        {
            CaptionML = ENU = '&Update Unit Cost', FRA = 'Mise à jour coût &unitaire';
        }
        modify("&Reserve")
        {
            CaptionML = ENU = '&Reserve', FRA = '&Réserver';
        }
        modify(OrderTracking)
        {
            CaptionML = ENU = 'Order &Tracking', FRA = '&Chaînage';
        }
        modify("C&opy Prod. Order Document")
        {
            CaptionML = ENU = 'C&opy Prod. Order Document', FRA = 'Copier &O.F.';
        }
        modify(Warehouse)
        {
            CaptionML = ENU = 'Warehouse', FRA = 'Entrepôt';
        }
        modify("Create Inventor&y Put-away/Pick/Movement")
        {
            CaptionML = ENU = 'Create Inventor&y Put-away/Pick/Movement', FRA = 'Créer rangement/prélèvement/mouvement stoc&k';
        }
        modify("Create I&nbound Whse. Request")
        {
            CaptionML = ENU = 'Create I&nbound Whse. Request', FRA = 'Créer &demande d''enlogement';
        }
        /* Bc Upgrade YADAVM09 Action removed from Bc>>
        modify("Create Whse. Pick")
        {
            CaptionML = ENU = 'Create Whse. Pick', FRA = 'Créer prélèvement entrep.';
        }
        */ //Bc Upgrade YADAVM09 Action removed from Bc<<
        modify("&Print")
        {
            CaptionML = ENU = '&Print', FRA = '&Imprimer';
        }
        modify("Job Card")
        {
            CaptionML = ENU = 'Job Card', FRA = 'Fiche suiveuse';
        }
        modify("Mat. &Requisition")
        {
            CaptionML = ENU = 'Mat. &Requisition', FRA = '&Besoin matière';
        }
        modify("Shortage List")
        {
            CaptionML = ENU = 'Shortage List', FRA = 'Liste des ruptures';
        }
        modify("Subcontractor - Dispatch List")
        {
            CaptionML = ENU = 'Subcontractor - Dispatch List', FRA = 'S/traitant - Liste expédition';
        }


        //Unsupported feature: CodeModification on "RefreshProductionOrder(Action 24).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ProdOrder.SETRANGE(Status,Status);
        ProdOrder.SETRANGE("No.","No.");
        REPORT.RUNMODAL(REPORT::"Refresh Production Order",true,true,ProdOrder);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ProdOrder.SETRANGE(Status,Status);
        ProdOrder.SETRANGE("No.","No.");
        //HEI.03
        if Item.GET("Source No.") then begin
          StockKeepingUnit.SETRANGE("Item No.",Item."No.");
          StockKeepingUnit.SETRANGE("Location Code","Location Code");
          if StockKeepingUnit.FINDFIRST then begin
            RoutingNo := StockKeepingUnit."Routing No.";
            BOM := StockKeepingUnit."Production BOM No.";
          end else
           //ERROR('There is no Active Routing / BOM version'); //HEI.05
            ERROR(Text003); //HEI.05
          RoutingVersion.SETRANGE("Routing No.",RoutingNo);
          RoutingVersion.SETRANGE(Active,true);
          if RoutingVersion.FINDFIRST then
            RoutingExist := true
          else
            RoutingExist := false;
          ProductionBOMVersion.SETRANGE("Production BOM No.",BOM);
          ProductionBOMVersion.SETRANGE(Active,true);
          if ProductionBOMVersion.FINDFIRST then
            BOMExist := true
          else
            BOMExist := false;
        end;
        if RoutingExist and BOMExist then
        //HEI.03
        REPORT.RUNMODAL(REPORT::"Refresh Production Order",true,true,ProdOrder)
        //HEI.03
        else
          ERROR('There is not any Active Routing / BOM version');
        //HEI.03
        //HEI.13>>
        CurrPage.UPDATE;
        ProdOrderStatusMgmtL.OnAfterReleasedProdOrderforAstro(Rec,false);
        //HEI.13<<
        */
        //end;
        /* Bc Upgrade YADAVM09 Astro is out of scope>>
        addafter("O&rder")
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                            FRA = '&Ligne';
                Image = Line;
                action(Losses)
                {
                    CaptionML = ENU = 'Losses',
                                FRA = 'Pertes';
                    Image = GainLossEntries;

                    trigger OnAction();
                    var
                        CapacityLedgerEntry: Record "Capacity Ledger Entry";
                        BrewingLosses: Page "Brewing Losses";
                    begin
                        // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                        // <<DITW17.00.01 KCO 18/03/2013 DIT-770 #001
                        CapacityLedgerEntry.SETRANGE("Order Type", CapacityLedgerEntry."Order Type"::Production);
                        CapacityLedgerEntry.SETRANGE("Order No.", "No.");
                        // >>DITW17.00.01 KCO DIT-770 #001
                        BrewingLosses.SETTABLEVIEW(CapacityLedgerEntry);
                        BrewingLosses.RUNMODAL;
                        // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
                    end;
                }
            }
        }
        
        addafter(RefreshProductionOrder)
        {
            action(SendForLogoPak)
            {
                Caption = 'Send For LogoPak';
                Ellipsis = true;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                Visible = Visiblelogopak;

                trigger OnAction();
                var
                    ProdOrderStatusMgmtL: Codeunit "Prod. Order Status Management";
                begin
                    //HEI.11>>
                    CurrPage.UPDATE;
                    ProdOrderStatusMgmtL.OnAfterReleasedProdOrder(Rec, false);
                    //HEI.11<<
                end;
            }
            action(SendForAstro)
            {
                Caption = 'Send For Astro';
                Ellipsis = true;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                Visible = VisibleAstro;

                trigger OnAction();
                var
                    ProdOrderStatusMgmtL: Codeunit "Prod. Order Status Management";
                begin
                    //HEI.13>>
                    CurrPage.UPDATE;
                    ProdOrderStatusMgmtL.OnAfterReleasedProdOrderforAstro(Rec, false);
                    //HEI.13<<
                end;
            }
        }
        /* //Bc Upgrade YADAVM09 Astro is out of scope<<
        /* //Bc Upgrade YADAVM09 Drink it action commented>>
        addafter("C&opy Prod. Order Document")
        {
            separator(Separator1100910010)
            {
            }
            action("Register Loss Strength Journal")
            {
                CaptionML = ENU = 'Register Loss Strength Journal',
                            FRA = 'Valider journal perte contrainte';
                Ellipsis = true;
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    // <<DITW19.00.08 DDR 20/10/2016 BL#10443
                    OpenLossOutputJournal;
                end;
            }
        }
        
        addafter("Create Whse. Pick")
        {
            separator(Separator1000000000)
            {
            }
            action("Print SSCC")
            {
                CaptionML = ENU = 'Print SSCC',
                            FRA = 'Imprimer SSCC';

                trigger OnAction();
                var
                    lfrmPrintLabels: Page "Print Labels";
                begin
                    // <<DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                    lfrmPrintLabels.SetProdOrder(Rec);
                    lfrmPrintLabels.RUNMODAL();
                    // >>DITW16.00.00.43 RBE DIT-715 #806
                end;
            }
        }
        addafter("Shortage List")
        {
            action("Prod. Order - Job Card")
            {
                CaptionML = ENU = 'Prod. Order - Job Card',
                            FRA = 'O.F. - Fiche suiveuse';
                Ellipsis = true;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    lrecProdOrder: Record "Production Order";
                begin
                    //<<MANXL8.00.001 BSA 28/04/2015 #19
                    lrecProdOrder.SETRANGE(Status, Status);
                    lrecProdOrder.SETRANGE("No.", "No.");
                    REPORT.RUNMODAL(REPORT::"Work Order NAVXL", true, true, lrecProdOrder);
                    //>>MANXL8.00.001 BSA 28/04/2015 #19
                end;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it action commented<<

        //Bc Upgrade YADAVM09 Action Added>>
        addafter("F&unctions")
        {
            action(RefreshProductionOrder2)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Re&fresh Production Order';
                Ellipsis = true;
                Image = Refresh;
                ToolTip = 'Calculate changes made to the production order header without involving production BOM levels. The function calculates and initiates the values of the component lines and routing lines based on the master data defined in the assigned production BOM and routing, according to the order quantity and due date on the production order''s header.';

                trigger OnAction()
                var
                    ProdOrder: Record "Production Order";
                begin
                    ProdOrder.SetRange(Status, Rec.Status);
                    ProdOrder.SetRange("No.", Rec."No.");
                    //HEI.03
                    IF Item.GET(Rec."Source No.") THEN BEGIN
                        StockKeepingUnit.SETRANGE("Item No.", Item."No.");
                        StockKeepingUnit.SETRANGE("Location Code", Rec."Location Code");
                        IF StockKeepingUnit.FINDFIRST() THEN BEGIN
                            RoutingNo := StockKeepingUnit."Routing No.";
                            BOM := StockKeepingUnit."Production BOM No.";
                        end else
                            //ERROR('There is no Active Routing / BOM version'); //HEI.05
                             ERROR(Text003); //HEI.05
                        RoutingVersion.SETRANGE("Routing No.", RoutingNo);
                        RoutingVersion.SETRANGE("Active FND", TRUE);
                        IF RoutingVersion.FINDFIRST() THEN
                            RoutingExist := TRUE
                        else
                            RoutingExist := FALSE;
                        ProductionBOMVersion.SETRANGE("Production BOM No.", BOM);
                        ProductionBOMVersion.SETRANGE("Active FND", TRUE);
                        IF ProductionBOMVersion.FINDFIRST() THEN
                            BOMExist := TRUE
                        else
                            BOMExist := FALSE;
                    end;
                    IF RoutingExist AND BOMExist THEN
                        //HEI.03
                        REPORT.RUNMODAL(REPORT::"Refresh Production Order", TRUE, TRUE, ProdOrder)
                    //HEI.03
                    else
                        ERROR('There is not any Active Routing / BOM version');
                    //HEI.03
                    /*
                    //HEI.13>> //Bc Upgrade YADAVM09 Astro code commented>>
                    CurrPage.UPDATE;
                    ProdOrderStatusMgmtL.OnAfterReleasedProdOrderforAstro(Rec, FALSE);
                    //HEI.13<<
                    */ //Bc Upgrade YADAVM09 Astro code commented<<

                end;
            }
            /*//Bc Upgrade YADAVM09 Interface Extension page is created>>
            action(SendForLogoPak)
            {
                Caption = 'Send For LogoPak';
                Ellipsis = true;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                Visible = Visiblelogopak;

                trigger OnAction();
                var
                    ProdOrderStatusMgmtL: Codeunit "Prod. Order Status Management";
                begin
                    //HEI.11>>
                    CurrPage.UPDATE;
                    ProdOrderStatusMgmtL.OnAfterReleasedProdOrder(Rec, false);
                    //HEI.11<<
                end;
            }
            */ //Bc Upgrade YADAVM09 Interface Extension page is created<<
        }
        /* //Bc Upgrade YADAVM09 Interface Extension page is created>>
                addafter("Re&plan")
                {
                    action("&Testscript_Refresh Production Order")
                    {
                        Caption = '&Testscript_Refresh Production Order';
                        Ellipsis = true;
                        Image = Refresh;
                        Promoted = true;
                        PromotedCategory = Process;
                        Visible = Visiblelogopak;
                        trigger OnAction()
                        var
                            ProdOrder: Record "Production Order";
                        begin
                            //HEI.10>>
                            ProdOrder.SETRANGE(Status, Rec.Status);
                            ProdOrder.SETRANGE("No.", Rec."No.");
                            IF Item.GET(Rec."Source No.") THEN BEGIN
                                StockKeepingUnit.SETRANGE("Item No.", Item."No.");
                                StockKeepingUnit.SETRANGE("Location Code", Rec."Location Code");
                                IF StockKeepingUnit.FINDFIRST THEN BEGIN
                                    RoutingNo := StockKeepingUnit."Routing No.";
                                    BOM := StockKeepingUnit."Production BOM No.";
                                end else
                                    ERROR('There is not any Active Routing / BOM version');
                                RoutingVersion.SETRANGE("Routing No.", RoutingNo);
                                RoutingVersion.SETRANGE(Active, TRUE);
                                IF RoutingVersion.FINDFIRST THEN
                                    RoutingExist := TRUE
                                else
                                    RoutingExist := FALSE;
                                ProductionBOMVersion.SETRANGE("Production BOM No.", BOM);
                                ProductionBOMVersion.SETRANGE(Active, TRUE);
                                IF ProductionBOMVersion.FINDFIRST THEN
                                    BOMExist := TRUE
                                else
                                    BOMExist := FALSE;
                            end;

                            IF RoutingExist AND BOMExist THEN
                                REPORT.RUNMODAL(REPORT::"Refresh Production Order DTW", FALSE, FALSE, ProdOrder)
                            else
                                ERROR('There is not any Active Routing / BOM version');
                            //HEI.10<<

                        end;
                    }
                }
        */ //Bc Upgrade YADAVM09 Interface Extension page is created<<
        //BC Upgrade GUNREM01 moved this action to DTW ext >>
        // addafter("Subcontractor - Dispatch List")
        // {
        //     action(ProcessOrderGoodsMovement)
        //     {
        //         Caption = 'Process Order Goods Movement';
        //         Image = "Report";
        //         //Promoted = false;//Bc Upgrade YADAVM09 
        //         Promoted = true;//Bc Upgrade YADAVM09 
        //                         //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
        //         PromotedCategory = "Report";
        //         ApplicationArea = All;
        //         ToolTip = 'Executes the Process Order Goods Movement action.';

        //         trigger OnAction();
        //         var
        //             ProductionOrder: Record "Production Order";
        //         begin
        //             //HEI.02>>
        //             ProductionOrder.RESET();
        //             ProductionOrder.SETRANGE(ProductionOrder.Status, Rec.Status);
        //             ProductionOrder.SETRANGE(ProductionOrder."No.", Rec."No.");
        //             REPORT.RUN(50003, true, true, ProductionOrder);
        //             //HEI.02<<
        //         end;
        //     }
        // }
        //BC Upgrade GUNREM01 moved this action to DTW ext >>
        //Bc Upgrade YADAVM09 Action Added<<
    }




    //Unsupported feature: PropertyModification on "Text000(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Inbound Whse. Requests are created.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Inbound Whse. Requests are created.;FRA=Les demandes d'enlogement ont “t“ cr““es.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=No Inbound Whse. Request is created.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=No Inbound Whse. Request is created.;FRA=Aucune demande d'enlogement n'a “t“ cr““e.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Inbound Whse. Requests have already been created.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Inbound Whse. Requests have already been created.;FRA=Les demandes enlogement ont d“j“á “t“ cr““es.;
    //Variable type has not been exported.
    trigger OnClosePage();
    begin
        //HEI.07>>
        //HEI.08>>
        if not Rec.ISEMPTY then begin
            //HEI.08<<
            Rec.UpdateTileCode();
            Rec.MODIFY();
            //HEI.08>>
        end;
        //HEI.08<<
        //HEI.07<<
    end;



    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SETFILTER("Resp. Center Table Filter",UserMgt.GetRespCenterFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",UserMgt.GetRespPhysLocationFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",UserMgt.GetRespLocationFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 MSF DIT-770 #1192
    // <<DITW19.00.08 DDR 20/10/2016 BL#10443
    CALCFIELDS("Balance Vol-Strength Value");
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnClosePage". Please convert manually.



    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    InventoryPostingGroupEditable := true;
    GenProdPostingGroupEditable := true;
    GenBusPostingGroupEditable := true;
    // >>DITW15.00.00.35 PRODW14.00.00.08.14
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    //<<DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
    "Responsibility Center" := UserMgt.GetProductionFilter;
    //>>DITW18.00.06 MSF 04/03/2015 DIT-770 #1192
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //var
    // WMSInterfaceSetupL: Record "WMS Interface Setup INT";//Bc Upgrade YADAVM09 temporary blocked due to dependency on intrface object
    //InterfaceSetupL: Record "Interface Setup";//Bc Upgrade YADAVM09 temporary blocked due to dependency on intrface object
    //AstroInterfaceSetupL: Record "Astro Interface Setup";//Bc Upgrade Astro is out of scope
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SetSecurityFilterOnRespCenter();
    // >>DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    if rMANXLSetup.READPERMISSION then begin
    //>>MANXL7.00.001 WSA 11/07/2014 #87
      //<<MANXL7.00.001 DAT 03/03/2014 #12
      blnRevisionNoEnabled:= ("Source Type" = "Source Type"::Item);
      //<< DITW110.00.12A HBA 18/06/2018 NRQ#68221
      blnEnabled := ("Source Type" = "Source Type"::Item);
      //>> DITW110.00.12A HBA NRQ#68221
      //<<MANXL7.00.001 WSA 26/09/2014
      //Currpage.update;
      CurrPage.UPDATE(false);
      //>>MANXL7.00.001 WSA 26/09/2014
      //>>MANXL7.00.001 DAT 03/03/2014 #12
    //<<MANXL7.00.001 WSA 11/07/2014 #87
    end;
    //>>MANXL7.00.001 WSA 11/07/2014 #87

    // <<DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    if ManufacturingSetup.GET() then begin
      GenBusPostingGroupEditable := ManufacturingSetup."Editable Item Posting Groups";
      GenProdPostingGroupEditable := GenBusPostingGroupEditable;
      InventoryPostingGroupEditable := GenBusPostingGroupEditable;
    end;
    // >>DITW15.00.00.35 PRODW14.00.00.08.14

    //HEI.11>>
    CLEAR(VisibleLogoPak);
    if WMSInterfaceSetupL.GET and WMSInterfaceSetupL."WMS Integration" then begin
      if WMSInterfaceSetupL."Activate LogoPak Interface" and (WMSInterfaceSetupL."Prod. Order Interface" <> '') then
        if InterfaceSetupL.GET(WMSInterfaceSetupL."Prod. Order Interface") then
          VisibleLogoPak := true;
    end;
    //HEI.11<<

    //HEI.13>>
    CLEAR(VisibleAstro);
    if AstroInterfaceSetupL.GET and AstroInterfaceSetupL."Enabled Astro Integration" then begin
      if AstroInterfaceSetupL."Activate Prod. Order" then begin
        if AstroInterfaceSetupL."Prod. Order Interface" <> '' then begin
          CLEAR(InterfaceSetupL);
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Interface") then
            VisibleAstro := true;
        end;
      end;
      //HEI.16>>
      if not VisibleAstro then begin
        CLEAR(InterfaceSetupL);
        if AstroInterfaceSetupL."Activate Inventory Balance" then begin
          if AstroInterfaceSetupL."Balance Change Interface" <> '' then begin
            if InterfaceSetupL.GET(AstroInterfaceSetupL."Balance Change Interface") then begin
              if (AstroInterfaceSetupL."Output Revers Journal Template" <> '') and
                (AstroInterfaceSetupL."Output Revers Journal Batch" <> '') then
                  VisibleAstro := true;
            end;
          end;
        end;
      end;
      //HEI.16<<
    end;
    //HEI.13<<
    */
    //end;
    /*//Bc Upgrade YADAVM09 Drink it function commented>>
        local procedure PageCaptionClassText(CaptionText: Text[255]): Text[80];
        begin
            // <<DITW19.00.08 DDR 20/10/2016 BL#10443
            // page workaround build NAV9.0.43897 NAV2016 CU2
            exit(CaptionText);
        end;
        */ //Bc Upgrade YADAVM09 Drink it function commented<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    var
        Item: Record Item;
        ManufacturingSetup: Record "Manufacturing Setup";
        ProductionBOMVersion: Record "Production BOM Version";
        RoutingVersion: Record "Routing Version";
        StockKeepingUnit: Record "Stockkeeping Unit";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ProdOrderStatusMgmtL: Codeunit "Prod. Order Status Management";
        UserMgt: Codeunit "User Setup Management";
        blnEnabled: Boolean;

        blnRevisionNoEnabled: Boolean;
        BOMExist: Boolean;

        GenBusPostingGroupEditable: Boolean;

        GenProdPostingGroupEditable: Boolean;

        InventoryPostingGroupEditable: Boolean;
        RoutingExist: Boolean;
        VisibleAstro: Boolean;
        VisibleLogoPak: Boolean;
        BOM: Code[20];
        RoutingNo: Code[20];
        Text003: Label 'There is no StockKeeping Unit for this Item!';
        // rMANXLSetup: Record "Manufacturing XL Setup";//Bc Upgrade YADAVM09 Drink it Object
        Text2013660: TextConst ENU = 'Balance', FRA = 'Solde';
        Text2013661: TextConst ENU = 'Consumption', FRA = 'Consommation';
        Text2013662: TextConst ENU = 'Output', FRA = 'Production';
        Text2013663: TextConst ENU = 'Loss', FRA = 'Perte';


}





