pageextension 51196 FirmPlannedProdOrderExtCBN extends "Firm Planned Prod. Order"
{
    // version NAVW110.0,FINXL8.00,MANXL7.00,DITW110.00.12A,HEI.10

    //     DITW14.00.00.8 PROD: BrewIt & Quality
    // DITW15.00.00.27 PRODW14.03.00.08.05 JFE 25/10/2008
    // DITW15.00.00.35 PRODW14.00.00.08.14 DDR 18/08/2009
    //                                issue 768 Added to set non-editable fields
    //                                  "Gen. Bus. Posting Group","Gen. Prod. Posting Group","Inventory Posting Group"

    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Emergency Order"
    // MANXL7.00.001 DAT 03/03/2014 #10: Create Head group for subcontracting
    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 WSA 11/07/2014 #87: Added code MANXL security
    // MANXL7.00.001 WSA 26/09/2014 : Ovoid Rec Inserted Twice

    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // DITW18.00.06 MSF 20/10/2015 DIT-770 #805 Renumber CodeUnit ID  2035095 to 2035150

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

    // HEI.01 RFC-CHG0257267 IBM.SS 11.01.2019
    //   # Code added On Refresh production Order action
    // HEI.02 CHG2069358 IBM.AK 25.08.20
    //  # new field added on -"Created By"
    // HEI.03 CHG2070663 IBM POENAB02 18.09.2020 Role Centre Production Bottling Role Centre
    //   # Code added in OnClosePage
    // HEI.04 CHG2101736 IBM.LS      17.03.2021
    //   # Added Code
    // HEI.05 RITM2817451 DtW Test Scripts
    //   # Added Page Action-26 Replica of Refresh Prod Order
    // HEI.06 CHG2129985 SAHAL01      14.04.2022
    //   # Added New Tab - LogoPak
    //   # Added New Fields - Prod. Order Interface
    //                      - Parked for LogoPak
    //   # Added Code to visible LogoPak Tab
    // HEI.07 CHG2149734 SAHAL01 08.09.2022
    //   # Added New Tab - Astro
    //   # Added New Group - Outbound - Prod. Order Sync Info.
    //   # Added New Fields - Prod. ORDER Interface Astro
    //                      - Parked ORDER Astro
    //                      - Last Parked Date ORDER Astro
    //                      - Last Parked Time ORDER Astro
    //   # Added Code to visible Astro Tab
    // HEI.08 CHG2154367 SAHAL01 08.09.2022
    //   # Added New Group - Inbound - Prod. Order Output Info.
    //   # Added New Fields - Prod. OUTPUT Interface Astro
    //                      - Parked OUTPUT Astro
    //                      - Last Parked Date OUTPUT Astro
    //                      - Last Parked Time OUTPUT Astro
    // HEI.09 CHG2154364 SAHAL01 20.10.2022
    //   # Added New Group - Inbound - Prod. Order Line Pick Info.
    //   # Added New Fields - Prod. LINEPICK Interface Astro
    //                      - Parked LINEPICK Astro
    //                      - Last Parked Date LINEPICKAstro
    //                      - Last Parked Time LINEPICKAstro
    // HEI.10 CHG2154372 SAHAL01 15.12.2022 Astro - I/F Inventory Management - BalanceChange
    //   # Added New Group - Inbound - Prod. Order Output Reversal Info.
    //   # Added New Fields - OUTPUT Revers Interface Astro
    //                      - Parked OUTPUT Revers Astro
    //                      - Last Parked Date OUTPUTR Astro
    //                      - Last Parked Time OUTPUTR Astro
    //   # Added Code to visible Astro Fields

    //Bc Upgrade YADAVM09 HEI.01 base action Refresh production Order is hide
    //   # Action Refresh production Order1 is added to handle code //HEI.01
    //   # Action  &Testscript_Refresh Production Order is added to handle //HEI.05
    //   #Drink it field Commented #Astro Field Commented
    //   #//HEI.06 will be handeled later related to visibilty of group and depndency on interface table

    // BC Upgrade SHUKLP03 >> Added in the interface ext.
    // HEI.06 CHG2129985 SAHAL01      14.04.2022
    //   # Added New Tab - LogoPak
    //   # Added New Fields - Prod. Order Interface
    //                      - Parked for LogoPak
    //   # Added Code to visible LogoPak Tab
    // BC Upgrade SHUKLP03 << Added in the interface ext.

    layout
    {
        //BC Upgrade Kamnay01>>Added DITW field
        addafter(Quantity)
        {
            field("Unit of Measure Code"; Rec."Unit of Measure Code FND")
            {
                ApplicationArea = All;
            }
        }
        //BC upgrade Kamnay01<<Added DITW field

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
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies when the production order card was last modified.', FRA = 'Indique la date à laquelle la fiche ordre de fabrication a été modifiée pour la dernière fois.';
        }
        modify(Schedule)
        {
            CaptionML = ENU = 'Schedule', FRA = 'Planifié';
        }


        /*  BCUPG COMMENT       modify("Starting Time")
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
                } */
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
        //BC Upgrade GUNREM01 >>
        moveafter("Search Description"; "Location Code")
        //BC Upgrade GUNREM01 >>
        addafter(Quantity)
        {
            //BC upgrade GUNREM01 added fields and code >>
            field("Prod. BOM No. 112FDW"; Rec."Prod. BOM No. 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Prod. BOM No. 112FDW field.';

            }

            field("Prod. BOM Vrsn Code 112FDW"; Rec."Prod. BOM Vrsn Code 112FDW")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Prod. BOM Vrsn Code 112FDW field.';
                //BC Upgrade GUNREM01 >> Not required

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
                //BC Upgrade GUNREM01 << Not required

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
                //BC Upgrade GUNREM01 >> Not required

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
                //BC Upgrade GUNREM01 << Not required

            }
        }
        //BC upgrade GUNREM01 added fields and code <<


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
        end
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
        /* //Bc Upgrade YADAVM09 Drink it Object commented>>
                addafter("Source No.")
                {

                    field(LocationCodeNew; Rec."Location Code")
                    {
                        Description = 'DITW110.00.12A NRQ#68221';
                        Importance = Promoted;
                        ToolTip = 'Specifies the location code to which you want to post the finished product from this production order.';

                        trigger OnValidate();
                        begin
                            //<< DITW110.00.12A HBA 18/06/2018 NRQ#68221
                            if "Location Code" <> xRec."Location Code" then
                                CurrPage.UPDATE(true);
                            //<< DITW110.00.12A HBA NRQ#68221
                        end;
                    }

                    field(BinCodeNew; "Bin Code")
                    {
                        Description = 'DITW110.00.12A NRQ#68221';
                        Importance = Promoted;
                        ToolTip = 'Specifies a bin to which you want to post the finished items.';
                    }
                    field("Revision No."; "Revision No.")
                    {
                        Description = 'MANXL7.00.001';
                        Enabled = blnRevisionNoEnabled;
                    }
                    field("Routing No."; "Routing No.")
                    {
                        Description = 'DITW110.00.12A NRQ#68221';
                        Editable = blnEnabled;
                    }

                    field("Routing Version Code"; Rec."Routing Version Code")
                    {
                        Editable = blnEnabled;
                    }
                    field("Routing Version Description"; Rec."Routing Version Description")
                    {
                        Importance = Additional;
                    }
                    field("Production BOM No."; Rec."Production BOM No.")
                    {
                        Enabled = blnEnabled;
                    }
                    field("Production BOM Version Code"; "Production BOM Version Code")
                    {
                        Editable = blnEnabled;
                    }
                    field("Production BOM Version Desc."; "Production BOM Version Desc.")
                    {
                        Importance = Additional;
                    }
                    field("Gyle No."; "Gyle No.")
                    {
                        CaptionClass = '2035140,1';
                    }
                    field("Parti-Gyle"; "Parti-Gyle")
                    {
                        Visible = false;
                    }

                } */ //Bc Upgrade YADAVM09 Drink it Object commented<<
                     /* //Bc Upgrade YADAVM09 Drink it Object commented>>
                     addafter("Search Description")
                     {
                         field("Unit of Measure Code"; "Unit of Measure Code")
                         {
                             Description = 'DITW110.00.12 NRQ#64704 - DITW110.00.12A NRQ#68221';
                             Editable = blnEnabled;
                         }
                     }
                     addafter(Quantity)
                     {
                         field("Quantity (Base)"; "Quantity (Base)")
                         {
                             Importance = Additional;
                         }
                         field("Quantity HL"; "Quantity HL")
                         {
                         }
                     }
                     */ //Bc Upgrade YADAVM09 Drink it Object commented<<
        addafter("Last Date Modified")
        {
            /* //Bc Upgrade YADAVM09 Drink it Object commented>>
            field("Emergency Order"; Rec."Emergency Order")
            {
            }
            field("Certification Status"; Rec."Certification Status")
            {
            }
            field("Certified by"; Rec."Certified by")
            {
            }
            */ //Bc Upgrade YADAVM09 Drink it Object commented<<
            field("Created By"; Rec."Created By FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Created By field.';
            }

        }


        /* //Bc Upgrade YADAVM09 Drink it Object commented>>
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
        */ //Bc Upgrade YADAVM09 Drink it Object commented<<
        addafter("Location Code")
        {
            field("Zone Code"; Rec."Zone Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Zone Code field.';
            }
        }
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


        addafter(Posting)
        {
            /* //Bc Upgrade YADAVM09 Drink it Field commented>>
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
                field("No. of Lot Tests"; Rec."No. of Lot Tests")
                {
                }
                field("No. of In Process Tests"; "No. of In Process Tests")
                {
                }
            }
            */ //Bc Upgrade YADAVM09 Drink it Field commented<<

            // BC Upgrade SHUKLP03 >> Added in the interface ext.
            // group(LogoPak)
            // {
            //     Caption = 'LogoPak';
            //     Visible = VisibleLogoPak;
            //     field("Prod. Order Interface"; Rec."Prod. Order Interface")
            //     {
            //         Editable = false;
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Prod. Order Interface field.';
            //     }
            //     field("Parked for LogoPak"; Rec."Parked for LogoPak")
            //     {
            //         Editable = false;
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the value of the Parked for LogoPak field.';
            //     }
            // }
            // BC Upgrade SHUKLP03 << Added in the interface ext.

            /* //Bc Upgrade YADAVM09 Astro Field commented<<
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
                }
                
            }*/ //Bc Upgrade YADAVM09 Astro field commented<<
        }
    }
    actions
    {
        modify("O&rder")
        {
            CaptionML = ENU = 'O&rder', FRA = '&O.F.';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
            Promoted = true;
            PromotedCategory = Process;
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify(Statistics)
        {
            CaptionML = ENU = 'Statistics', FRA = 'Statistiques';
        }
        modify("Plannin&g")
        {
            CaptionML = ENU = 'Plannin&g', FRA = 'Plannin&g';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Re&fresh Production Order")
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
            CaptionML = ENU = '&Update Unit Cost', FRA = '&Mise à jour coût unitaire';
        }
        modify("C&opy Prod. Order Document")
        {
            CaptionML = ENU = 'C&opy Prod. Order Document', FRA = 'Copier &O.F.';
        }
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


        //Unsupported feature: CodeModification on ""Re&fresh Production Order"(Action 23).OnAction". Please convert manually.

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
        //HEI.01
        if Item.GET("Source No.") then begin
          StockKeepingUnit.SETRANGE("Item No.",Item."No.");
          StockKeepingUnit.SETRANGE("Location Code","Location Code");
          if StockKeepingUnit.FINDFIRST then begin
            RoutingNo := StockKeepingUnit."Routing No.";
            BOM := StockKeepingUnit."Production BOM No.";
          end else
            ERROR('There is not any Active Routing / BOM version');
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
        //HEI.01
          REPORT.RUNMODAL(REPORT::"Refresh Production Order",true,true,ProdOrder)
        //HEI.01
        else
          ERROR('There is not any Active Routing / BOM version');
        //HEI.01
        */
        //end;
        /* //Bc Upgrade YADAVM09 Drink it Action commented>>
        addafter("Re&plan")
        {
            action(Split)
            {
                CaptionML = ENU = 'Split',
                            FRA = 'Eclater';
                Ellipsis = true;
                Image = Split;

                trigger OnAction();
                begin
                    // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
                    BrewingManagement.SplitProdOrder(Rec);
                    // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
                end;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it Action commented<<
           //Bc Upgrade YADAVM09  new action Added>>
        addafter("F&unctions")
        {
            action("Re&fresh Production Order1")
            {
                ApplicationArea = Manufacturing;
                CaptionML = ENU = 'Re&fresh Production Order', FRA = 'Ac&tualiser O.F.';
                Ellipsis = true;
                Image = Refresh;
                ToolTip = 'Calculate changes made to the production order header without involving production BOM levels. The function calculates and initiates the values of the component lines and routing lines based on the master data defined in the assigned production BOM and routing, according to the order quantity and due date on the production order''s header.';

                trigger OnAction()
                var
                    ProdOrder: Record "Production Order";
                begin

                    ProdOrder.SETRANGE(Status, Rec.Status);
                    ProdOrder.SETRANGE("No.", Rec."No.");
                    //HEI.01
                    IF Item.GET(Rec."Source No.") THEN BEGIN
                        StockKeepingUnit.SETRANGE("Item No.", Item."No.");
                        StockKeepingUnit.SETRANGE("Location Code", Rec."Location Code");
                        IF StockKeepingUnit.FINDFIRST() THEN BEGIN
                            RoutingNo := StockKeepingUnit."Routing No.";
                            BOM := StockKeepingUnit."Production BOM No.";
                        END ELSE
                            ERROR('There is not any Active Routing / BOM version');
                        RoutingVersion.SETRANGE("Routing No.", RoutingNo);
                        RoutingVersion.SETRANGE("Active FND", TRUE);
                        IF RoutingVersion.FINDFIRST() THEN
                            RoutingExist := TRUE
                        ELSE
                            RoutingExist := FALSE;
                        ProductionBOMVersion.SETRANGE("Production BOM No.", BOM);
                        ProductionBOMVersion.SETRANGE("Active FND", TRUE);
                        IF ProductionBOMVersion.FINDFIRST() THEN
                            BOMExist := TRUE
                        ELSE
                            BOMExist := FALSE;
                    END;
                    IF RoutingExist AND BOMExist THEN
                        //HEI.01
                        REPORT.RUNMODAL(REPORT::"Refresh Production Order", TRUE, TRUE, ProdOrder)
                    //HEI.01
                    ELSE
                        ERROR('There is not any Active Routing / BOM version');
                    //HEI.01

                end;
            }
        }
        addafter("Change &Status")
        {
            action("&Testscript_Refresh Production Order")
            {
                ApplicationArea = All;
                ToolTip = 'Executes the &Testscript_Refresh Production Order action.';

                trigger OnAction()
                var
                    ProdOrder: Record "Production Order";
                begin
                    //HEI.05>>
                    ProdOrder.SETRANGE(Status, Rec.Status);
                    ProdOrder.SETRANGE("No.", Rec."No.");
                    IF Item.GET(Rec."Source No.") THEN BEGIN
                        StockKeepingUnit.SETRANGE("Item No.", Item."No.");
                        StockKeepingUnit.SETRANGE("Location Code", Rec."Location Code");
                        IF StockKeepingUnit.FINDFIRST() THEN BEGIN
                            RoutingNo := StockKeepingUnit."Routing No.";
                            BOM := StockKeepingUnit."Production BOM No.";
                        END ELSE
                            ERROR('There is not any Active Routing / BOM version');
                        RoutingVersion.SETRANGE("Routing No.", RoutingNo);
                        RoutingVersion.SETRANGE("Active FND", TRUE);
                        IF RoutingVersion.FINDFIRST() THEN
                            RoutingExist := TRUE
                        ELSE
                            RoutingExist := FALSE;
                        ProductionBOMVersion.SETRANGE("Production BOM No.", BOM);
                        ProductionBOMVersion.SETRANGE("Active FND", TRUE);
                        IF ProductionBOMVersion.FINDFIRST() THEN
                            BOMExist := TRUE
                        ELSE
                            BOMExist := FALSE;
                    END;

                    IF RoutingExist AND BOMExist THEN
                        REPORT.RUNMODAL(REPORT::"Refresh Prod Order DTW CBN", FALSE, FALSE, ProdOrder)
                    ELSE
                        ERROR('There is not any Active Routing / BOM version');
                    //HEI.05<<

                end;

            }
        }
        //Bc Upgrade YADAVM09 New action Added<<
        addafter("Change &Status")
        {
            action("<Action26>")
            {
                CaptionML = ENU = '&Testscript_Refresh Production Order',
                            FRA = 'Ac&tualiser O.F.';
                Ellipsis = true;
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Executes the <Action26> action.';

                trigger OnAction();
                var
                    ProdOrder: Record "Production Order";
                begin
                    //HEI.05>>
                    ProdOrder.SETRANGE(Status, Rec.Status);
                    ProdOrder.SETRANGE("No.", Rec."No.");
                    if Item.GET(Rec."Source No.") then begin
                        StockKeepingUnit.SETRANGE("Item No.", Item."No.");
                        StockKeepingUnit.SETRANGE("Location Code", Rec."Location Code");
                        if StockKeepingUnit.FINDFIRST() then begin
                            RoutingNo := StockKeepingUnit."Routing No.";
                            BOM := StockKeepingUnit."Production BOM No.";
                        end else
                            ERROR('There is not any Active Routing / BOM version');
                        RoutingVersion.SETRANGE("Routing No.", RoutingNo);
                        RoutingVersion.SETRANGE("Active FND", true);
                        if RoutingVersion.FINDFIRST() then
                            RoutingExist := true
                        else
                            RoutingExist := false;
                        ProductionBOMVersion.SETRANGE("Production BOM No.", BOM);
                        ProductionBOMVersion.SETRANGE("Active FND", true);
                        if ProductionBOMVersion.FINDFIRST() then
                            BOMExist := true
                        else
                            BOMExist := false;
                    end;

                    if RoutingExist and BOMExist then
                        REPORT.RUNMODAL(REPORT::"Refresh Prod Order DTW CBN", false, false, ProdOrder)
                    else
                        ERROR('There is not any Active Routing / BOM version');
                    //HEI.05<<
                end;
            }
        }
    }

    var
        //BrewingManagement: Codeunit "Brewing Management";//Bc Upgrade Drink it object commented
        ManufacturingSetup: Record "Manufacturing Setup";

        GenBusPostingGroupEditable: Boolean;

        GenProdPostingGroupEditable: Boolean;

        InventoryPostingGroupEditable: Boolean;
        UserMgt: Codeunit "User Setup Management";

        blnRevisionNoEnabled: Boolean;
        //rMANXLSetup: Record "Manufacturing XL Setup";//Bc Upgrade Drink it object commented
        blnEnabled: Boolean;
        Item: Record Item;
        StockKeepingUnit: Record "Stockkeeping Unit";
        RoutingVersion: Record "Routing Version";
        ProductionBOMVersion: Record "Production BOM Version";
        RoutingNo: Code[20];
        BOM: Code[20];
        RoutingExist: Boolean;
        BOMExist: Boolean;
        RoleCenterFilter: Text;
        //VisibleLogoPak: Boolean;  // BC Upgrade SHUKLP03 << Added in the interface ext.
        VisibleAstro: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SETFILTER("Resp. Center Table Filter",UserMgt.GetRespCenterFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",UserMgt.GetRespPhysLocationFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",UserMgt.GetRespLocationFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 MSF DIT-770 #1192
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnClosePage". Please convert manually.

    //trigger OnClosePage();
    //begin
    /*
    //HEI.03>>
    //HEI.04>>
    if not ISEMPTY then begin
    //HEI.04<<
      UpdateTileCode;
      MODIFY;
    //HEI.04>>
    end;
    //HEI.04<<
    //HEI.03<<
    */
    //end;


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
    var
    //WMSInterfaceSetupL: Record "WMS Interface Setup INT";//Bc Upgrade YADAVM09 Dependy on interface extension
    //InterfaceSetupL: Record "Interface Setup";//Bc Upgrade YADAVM09 Dependy on interface extension
    // AstroInterfaceSetupL: Record "Astro Interface Setup";//Bc Upgrade YADAVM09 Astro object
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

    //HEI.06>>
    CLEAR(VisibleLogoPak);
    if WMSInterfaceSetupL.GET and WMSInterfaceSetupL."WMS Integration" then begin
      if WMSInterfaceSetupL."Activate LogoPak Interface" and (WMSInterfaceSetupL."Prod. Order Interface" <> '') then
        if InterfaceSetupL.GET(WMSInterfaceSetupL."Prod. Order Interface") then
          VisibleLogoPak := true;
    end;
    //HEI.06<<

    //HEI.07>>
    CLEAR(VisibleAstro);
    if AstroInterfaceSetupL.GET and AstroInterfaceSetupL."Enabled Astro Integration" then begin
      if AstroInterfaceSetupL."Activate Prod. Order" then begin
        if AstroInterfaceSetupL."Prod. Order Interface" <> '' then begin
          CLEAR(InterfaceSetupL);
          if InterfaceSetupL.GET(AstroInterfaceSetupL."Prod. Order Interface") then
            VisibleAstro := true;
        end;
      end;
      //HEI.10>>
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
      //HEI.10<<
    end;
    //HEI.07<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.
    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        //HEI.03>>
        //HEI.04>>
        IF NOT Rec.ISEMPTY THEN BEGIN
            //HEI.04<<
            Rec.UpdateTileCode();
            Rec.MODIFY();
            //HEI.04>>
        END;
        //HEI.04<<
        //HEI.03<<
    end;

}

