pageextension 51134 FinishedProdOrderLinesExtCBN extends "Finished Prod. Order Lines"
{
    // version NAVW110.0,FINXL8.00.001,MANXL7.00.001,QXL9.00.001,DITW110.00.08

    //     DITW14.00.00.8 PROD: BrewIt & Quality
    // DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009 License problem
    // DITW15.00.00.30-PRODW14.00.00.09 DDR 21/01/2009 merge PRODW14.00.00.08.05A
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"

    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 DAT 05/03/2014 #18: Added field "Requester ID"
    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."

    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.07 VSC 24/02/2016 DIT-770 #1811 License check.
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    //                                                      Modified ShowComponents() function
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // QXL9.00.001 DAT 23/03/2016 : Quality Management

    //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    // BC Upgrade YADAVM09 Editable=False on Description Field

    layout
    {
        modify("Item No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item that is to be produced.', FRA = 'Spécifie le numéro de l''article à produire.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies a code if you have set up variant codes in the Item Variants window.', FRA = 'Spécifie un code si vous avez défini des codes variante dans la fenêtre Variantes article.';
        }
        modify("Due Date")
        {
            ToolTipML = ENU = 'Copies the date in this field from the corresponding field on the production order header.', FRA = 'Copie la date de ce champ à partir du champ correspondant dans l''en-tête de l''ordre de fabrication.';
        }
        modify(Description)
        {
            Editable = false;//BC Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the value of the Description field on the item card. If you enter a variant code, the variant description is copied to this field instead.', FRA = 'Spécifie la valeur du champ Description de la fiche article. Si vous saisissez un code variante, la description de la variante est copiée dans ce champ à la place de la description.';
        }
        modify("Description 2")
        {
            ToolTipML = ENU = 'Specifies an additional description.', FRA = 'Spécifie une description supplémentaire.';
        }
        modify("Production BOM No.")
        {
            ToolTipML = ENU = 'Specifies the number of the production BOM that is the basis for creating the Prod. Order Component list for this line.', FRA = 'Spécifie le numéro de la nomenclature de production qui est utilisé comme base pour créer la liste Composant O.F. pour cette ligne.';
        }
        modify("Routing No.")
        {
            ToolTipML = ENU = 'Specifies the number of the routing used as the basis for creating the production order routing for this line.', FRA = 'Spécifie le numéro de la gamme utilisée comme base pour créer la gamme ordre de fabrication pour cette ligne.';
        }
        modify("Routing Version Code")
        {
            ToolTipML = ENU = 'Specifies the version number of the routing.', FRA = 'Spécifie le numéro de version de la gamme.';
        }
        modify("Production BOM Version Code")
        {
            ToolTipML = ENU = 'Specifies the version code of the production BOM.', FRA = 'Spécifie le code de version de la nomenclature de production.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'Specifies the location code, if the produced items should be stored in a specific location.', FRA = 'Spécifie le code magasin, si les articles produits doivent être stockés dans un magasin spécifique.';
        }
        modify("Bin Code")
        {
            ToolTipML = ENU = 'Specifies the bin that the produced item is posted to as output, and from where it can be taken to storage or cross-docked.', FRA = 'Spécifie l''emplacement dans lequel l''article produit est validé en tant que production et d''où il peut être prélevé ou transbordé.';
        }
        modify("Starting Date-Time")
        {
            ToolTipML = ENU = 'Specifies the starting date and the starting time, which are combined in a format called "starting date-time".', FRA = 'Spécifie la date et l''heure de début combinées au format « date/heure début ».';
        }
        modify("Starting Time")
        {
            ToolTipML = ENU = 'Specifies the entry''s starting time, which is retrieved from the production order routing.', FRA = 'Spécifie l''heure de début de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Starting Date")
        {
            ToolTipML = ENU = 'Specifies the entry''s starting date, which is retrieved from the production order routing.', FRA = 'Spécifie la date de début de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Ending Date-Time")
        {
            ToolTipML = ENU = 'Specifies the ending date and the ending time, which are combined in a format called "ending date-time".', FRA = 'Spécifie la date et l''heure de fin combinées au format « date/heure fin ».';
        }
        modify("Ending Time")
        {
            ToolTipML = ENU = 'Specifies the entry''s ending time, which is retrieved from the production order routing.', FRA = 'Spécifie l''heure de fin de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Ending Date")
        {
            ToolTipML = ENU = 'Specifies the entry''s ending date, which is retrieved from the production order routing.', FRA = 'Spécifie la date de fin de l''écriture, qui est copiée à partir de l''ordre de fabrication.';
        }
        modify("Scrap %")
        {
            ToolTipML = ENU = 'Copies the value in this field from the Scrap Percentage field on the item card when the Item No. field is filled in.', FRA = 'Copie la valeur de ce champ à partir du champ Pourcentage rebut de la fiche article lorsque le champ N° article est renseigné.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'Specifies the quantity to be produced if you manually fill in this line.', FRA = 'Indique la quantité à produire si vous renseignez manuellement cette ligne.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the base unit of measure code for the item.', FRA = 'Spécifie le code unité de l''article.';
        }
        modify("Finished Quantity")
        {
            ToolTipML = ENU = 'Specifies how much of the quantity on this line has been produced.', FRA = 'Spécifie la quantité produite de cette ligne.';
        }
        modify("Unit Cost")
        {
            ToolTipML = ENU = 'Calculates the unit cost, based on the cost of the components in the production order component list, and the routing, if the costing method is not standard.', FRA = 'Calcule le coût unitaire, sur la base de celui des composants dans la liste de composants de l''ordre de fabrication et de la gamme si la méthode évaluation stock n''est pas standard.';
        }
        modify("Cost Amount")
        {
            ToolTipML = ENU = 'Calculates the amount by multiplying the Unit Cost by the Quantity.', FRA = 'Calcule le montant en multipliant le coût unitaire par la quantité.';
        }
        modify("Shortcut Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies a dimension value code for a dimension.', FRA = 'Indique un code section pour un axe analytique.';
        }
        modify("Shortcut Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies a dimension value code for a dimension.', FRA = 'Indique un code section pour un axe analytique.';
        }
        /* //BC Upgrade YADAVM09 Drink it Field and code Commented>>
        addafter("Variant Code")
        {
            field("Cross-Reference No."; "Cross-Reference No.")
            {
            }
            field("Revision No."; "Revision No.")
            {
                Description = 'MANXL7.00.001';
            }
            
            field("Requester ID"; "Requester ID")
            {
                Description = 'MANXL7.00.001';
            }
            
            
        }

        addafter(Quantity)
        {
            field(LotNo; LotNoText)
            {
                CaptionML = ENU = 'Lot No.',
                            FRA = 'N° lot';
                Editable = false;
                Style = Attention;
                StyleExpr = LotNocolor;

                trigger OnLookup(Text: Text): Boolean;
                begin
                    //<<QXL9.00.001 DAT 23/03/2016
                    OpenItemTrackingLines;
                    LotNo :=
                      QualityManagement.GetLotNos(DATABASE::"Prod. Order Line", Status,
                                                 "Prod. Order No.", '', "Line No.", 0, "Item No.",
                                                  10, true);
                    //>>QXL9.00.001 DAT 23/03/2016
                end;
            }
            
            field(SerialNo; SerialNoText)
            {
                CaptionML = ENU = 'Serial No.',
                            FRA = 'N° de série';
                Editable = false;
                Style = Attention;
                StyleExpr = SerialNocolor;

                trigger OnLookup(Text: Text): Boolean;
                begin
                    //<<QXL9.00.001 DAT 23/03/2016
                    OpenItemTrackingLines;
                    SerialNo :=
                      QualityManagement.GetSerialNos(DATABASE::"Prod. Order Line", Status,
                                                  "Prod. Order No.", '', "Line No.", 0, "Item No.",
                                                  10, true);
                    //>>QXL9.00.001 DAT 23/03/2016
                end;
            }
            field("No. of Quality Tests"; "No. of Quality Tests")
            {
            }
        }
        
        addafter("Cost Amount")
        {
            field("Strength Spec. Code"; "Strength Spec. Code")
            {
                Visible = false;
            }
            field("Strength Spec. Value"; "Strength Spec. Value")
            {
                Visible = false;
            }
            field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
            {
                Editable = false;
                Visible = false;
            }
            field("Vol-Strength Spec. Value"; "Vol-Strength Spec. Value")
            {
                Visible = false;
            }
            field("Unit Volume HL"; "Unit Volume HL")
            {
                Visible = false;
            }
        }
        
        addafter("Shortcut Dimension 2 Code")
        {
            field("Physical Location Group Code"; "Physical Location Group Code")
            {
                Visible = false;
            }
            field("Responsibility Center"; "Responsibility Center")
            {
                Visible = false;
            }
        }
        */ //BC Upgrade YADAVM09 Drink it Field and code Commented<<
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Ro&uting")
        {
            CaptionML = ENU = 'Ro&uting', FRA = '&Gamme';
        }
        modify(Components)
        {
            CaptionML = ENU = 'Components', FRA = 'Composants';
        }
        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }
    }



    var

        LotNocolor: Boolean;

        SerialNocolor: Boolean;
        // QualitySetup: Record "Quality Setup"; BC Upgrade YADAVM09 Drink it Objects
        // QualityManagement: Codeunit "Quality Management"; BC Upgrade YADAVM09 Drink it Objects
        LotNo: Code[20];
        SerialNo: Code[20];

        LotNoText: Text[1024];

        SerialNoText: Text[1024];
    //BrewingSetup: Record "Production Setup";//BC Upgrade YADAVM09 Object not used anywhere in the code


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DescriptionIndent := 0;
    DescriptionOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    DescriptionIndent := 0;
    DescriptionOnFormat;
    //<<QXL9.00.001 DAT 23/03/2016
    //<< DITW18.00.07 VSC 24/02/2016 DIT-770 #1811
    if not QualitySetup.READPERMISSION then
      exit;

    if not QualitySetup.GET then
      exit;
    //>> DITW18.00.07 VSC  DIT-770 #1811

    LotNo :=
      QualityManagement.GetLotNos(DATABASE::"Prod. Order Line",Status,
                                 "Prod. Order No.",'',"Line No.",0,"Item No.",
                                  10,true);
    LotNoText := FORMAT(LotNo);
    LotNoTextOnFormat(LotNoText);

    SerialNo :=
      QualityManagement.GetSerialNos(DATABASE::"Prod. Order Line",Status,
                                  "Prod. Order No.",'',"Line No.",0,"Item No.",
                                  10,true);
    SerialNoText := FORMAT(SerialNo);
    SerialNoTextOnFormat(SerialNoText);
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    //<<QXL9.00.001 DAT 23/03/2016
    LotNo := '';
    SerialNo := '';
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;




    //Unsupported feature: CodeModification on "ShowComponents(PROCEDURE 1)". Please convert manually.

    //procedure ShowComponents();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ProdOrderComp.SETRANGE(Status,Status);
    ProdOrderComp.SETRANGE("Prod. Order No.","Prod. Order No.");
    ProdOrderComp.SETRANGE("Prod. Order Line No.","Line No.");

    PAGE.RUN(PAGE::"Prod. Order Components",ProdOrderComp);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    // <<DITW15.00.00.25.01-PRODW14.00.00.08.05A DLE 21/01/2009 - DITW19.00.08 DDR 17/08/2016 BL#10443
    if BrewingSetup.READPERMISSION then begin
      if not BrewingSetup.GET then
        BrewingSetup.INIT;
    end;
    if BrewingSetup."Use Enhanced Comp. Tracking" then begin
      BrewingComponents.SETTABLEVIEW(ProdOrderComp);
      BrewingComponents.SetProdOrder(Status,"Prod. Order No.","Line No.");
      BrewingComponents.RUN;
    end else
    // >>DITW15.00.00.22 PRODW14.00.00.08 DDR - DITW19.00.08 DDR BL#10443
    PAGE.RUN(PAGE::"Prod. Order Components",ProdOrderComp);
    */
    //end;
    /*BC Upgrade YADAVM09 Drink it function Commented>>
    local procedure LotNoTextOnFormat(var Text: Text[1024]);
    begin
        //<<QXL9.00.001 DAT 23/03/2016
        if QualitySetup.READPERMISSION then begin
            LotNocolor := QualityManagement.IsRequired(Text);
        end;
        //>>QXL9.00.001 DAT 23/03/2016
    end;

    local procedure SerialNoTextOnFormat(var Text: Text[1024]);
    begin
        //<<QXL9.00.001 DAT 23/03/2016
        if QualitySetup.READPERMISSION then begin
            SerialNocolor := QualityManagement.IsRequired(Text);
        end;
        //>>QXL9.00.001 DAT 23/03/2016
    end;
    *///BC Upgrade YADAVM09 Drink it function Commented<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

