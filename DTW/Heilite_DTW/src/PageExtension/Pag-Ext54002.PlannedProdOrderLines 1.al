pageextension 54002 PlannedProdOrderLinesExt extends "Planned Prod. Order Lines"
{
    // version NAVW110.0,FINXL8.00.001,MANXL7.00.001,QXL9.00.001,DITW110.00.08

    //     DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific

    // MANXL7.00.001 DAT 03/03/2014 #12: Version Management
    // MANXL7.00.001 DAT 05/03/2014 #18: Added field "Requester ID"
    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No.", "Emergency Order"

    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW18.00.06 MSF 26/02/2015 DIT-770 #1192 Added fields 2014410 "Responsibility Center"
    //                                                        2014411 "Physical Location Group Code"
    // DITW18.00.07 VSC 11/01/2016 DIT-770 #1811 License check.
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code","Vol-Strength Spec. Value","Unit Volume HL"
    //                                                      Modified ShowComponents() function
    // QXL9.00.001 DAT 23/03/2016 : Quality Management

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
            Editable = false;//BCUPGRADE YADAVM09
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
        modify("Production BOM Version Code")
        {
            ToolTipML = ENU = 'Specifies the version code of the production BOM.', FRA = 'Spécifie le code de version de la nomenclature de production.';
        }
        modify("Routing Version Code")
        {
            ToolTipML = ENU = 'Specifies the version number of the routing.', FRA = 'Spécifie le numéro de version de la gamme.';
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
        modify("Reserved Quantity")
        {
            ToolTipML = ENU = 'Specifies how many units of this item have been reserved.', FRA = 'Spécifie le nombre d''unités de cet article qui ont été réservées.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the base unit of measure code for the item.', FRA = 'Spécifie le code unité de l''article.';
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

        //Unsupported feature: CodeInsertion on ""Location Code"(Control 24)". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //begin
        /*
        //<<DITW18.00.06 MSF 03/03/2015 DIT-770 #1192
        if "Location Code" <> xRec."Location Code" then
         CurrPage.UPDATE(true);
        */
        //end;
        /* BCUPGRADE YADAVM09 Drink it code commented>>
        addafter("Variant Code")
        {
            field("Cross-Reference No."; "Cross-Reference No.")
            {
            }
            field("Emergency Order"; "Emergency Order")
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
                Visible = false;
            }
        }
        
        addafter("Cost Amount")
        {
            field("Strength Spec. Code"; "Strength Spec. Code")
            {
                Editable = false;
                Visible = false;
            }
            field("Strength Spec. Value"; "Strength Spec. Value")
            {
                Editable = GlobalTax1ValueEditable;
                Visible = false;
            }
            field("Vol-Strength Spec. Code"; "Vol-Strength Spec. Code")
            {
                Editable = false;
                Visible = false;
            }
            field("Vol-Strength Spec. Value"; "Vol-Strength Spec. Value")
            {
                Editable = GlobalTax2ValueEditable;
                Visible = false;
            }
            field("Unit Volume HL"; "Unit Volume HL")
            {
                Editable = false;
                Visible = false;
            }
        }
        addafter("ShortcutDimCode[8]")
        {
            field("Responsibility Center"; "Responsibility Center")
            {
                QuickEntry = false;
                Visible = false;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1190
                    if "Responsibility Center" <> xRec."Responsibility Center" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 MSF DIT-770 #1190
                end;
            }
            field("Physical Location Group Code"; "Physical Location Group Code")
            {
                QuickEntry = false;
                Visible = false;

                trigger OnValidate();
                begin
                    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
                    if "Physical Location Group Code" <> xRec."Physical Location Group Code" then
                        CurrPage.UPDATE(true);
                    // >>DITW18.00.06 MSF DIT-770 #1192
                end;
            }
        }
        */  //BCUPGRADE YADAVM09 Drink it code commented>>
    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Order &Tracking")
        {
            CaptionML = ENU = 'Order &Tracking', FRA = 'C&haînage';
        }
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Item Availability by")
        {
            CaptionML = ENU = 'Item Availability by', FRA = 'Disponibilité article par';
        }
        modify("Event")
        {
            CaptionML = ENU = 'Event', FRA = 'Événement';
        }
        modify(Period)
        {
            CaptionML = ENU = 'Period', FRA = 'Période';
        }
        modify(Variant)
        {
            CaptionML = ENU = 'Variant', FRA = 'Variante';
        }
        modify(Location)
        {
            CaptionML = ENU = 'Location', FRA = 'Magasin';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
        }
        modify("Reservation Entries")
        {
            CaptionML = ENU = 'Reservation Entries', FRA = 'Écritures réservation';
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

        modify("Item &Tracking Lines")
        {
            CaptionML = ENU = 'Item &Tracking Lines', FRA = 'Lignes &traçabilité';
        }

    }


    var
        //QualitySetup: Record "Quality Setup";
        //QualityManagement: Codeunit "Quality Management";
        LotNo: Code[20];

        LotNocolor: Boolean;

        LotNoText: Text[1024];

        SerialNoText: Text[1024];
        SerialNo: Code[20];

        SerialNocolor: Boolean;
        UserMgt: Codeunit "User Setup Management";

        GlobalTax1ValueEditable: Boolean;

        GlobalTax2ValueEditable: Boolean;


    //Unsupported feature: CodeInsertion on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //begin
    /*
    // <<DITW18.00.06 MSF 26/02/2015 DIT-770 #1192
    SETFILTER("Resp. Center Table Filter",UserMgt.GetRespCenterFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Phys. Location Table Filter",UserMgt.GetRespPhysLocationFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    SETFILTER("Location Table Filter",UserMgt.GetRespLocationFilter(3,"Responsibility Center","Physical Location Group Code","Location Code"));
    // >>DITW18.00.06 MSF DIT-770 #1192
    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    GlobalTax1ValueEditable := HasTaxSpecEditable("Strength Spec. Code");
    GlobalTax2ValueEditable := HasTaxSpecEditable("Vol-Strength Spec. Code");
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DescriptionIndent := 0;
    ShowShortcutDimCode(ShortcutDimCode);
    DescriptionOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    //<<QXL9.00.001 DAT 23/03/2016
    if not QualitySetup.READPERMISSION then
      exit;

    if not QualitySetup.GET then
      exit;

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


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    COMMIT;
    if not ReserveProdOrderLine.DeleteLineConfirm(Rec) then
      exit(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    //<<QXL9.00.001 DAT 23/03/2016
    if QualitySetup.READPERMISSION then begin
      if not QualityManagement.DeleteProdOrderLineConfirm(Rec) then
        exit(false);
    end;
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    GlobalTax1ValueEditable := true;
    GlobalTax2ValueEditable := true;
    // >>DITW19.00.08 DDR BL#10443
    */
    //end;


    //Unsupported feature: CodeModification on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CLEAR(ShortcutDimCode);
    //<<QXL9.00.001 DAT 23/03/2016
    LotNo := '';
    SerialNo := '';
    //>>QXL9.00.001 DAT 23/03/2016
    */
    //end;

    procedure BrewingComponents();
    begin
    end;


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
    // <<DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008
    // <<DITW19.00.08 DDR 17/08/2016 BL#10443
    if BrewingSetup.READPERMISSION then begin
      if not BrewingSetup.GET then
        BrewingSetup.INIT;
    end;
    // >>DITW19.00.08 DDR BL#10443
    if BrewingSetup."Use Enhanced Comp. Tracking" then begin
      BrewingComponents.SETTABLEVIEW(ProdOrderComp);
      BrewingComponents.SetProdOrder(Status,"Prod. Order No.","Line No.");
      BrewingComponents.RUN;
    end else
    // >>DITW15.00.00.22 PRODW14.00.00.08 DDR
      PAGE.RUN(PAGE::"Prod. Order Components",ProdOrderComp);
    */
    //end;

    /* //BCUPGRADE YADAVM09 Drink it code commented>>
        local procedure LotNoTextOnFormat(var Text: Text[1024]);
        begin
            // <<DITW19.00.08 DDR 17/08/2016 BL#10443
            if (Quantity = 0) or ("Item No." = '') then begin
                LotNocolor := false;
                Text := '';
                exit;
            end;
            // >>DITW19.00.08 DDR BL#10443
            //<<QXL9.00.001 DAT 23/03/2016
            if QualitySetup.READPERMISSION then begin
                LotNocolor := QualityManagement.IsRequired(Text);
            end;
            //>>QXL9.00.001 DAT 23/03/2016
        end;
        */ //BCUPGRADE YADAVM09 Drink it code commented>>
           /* //BCUPGRADE YADAVM09 Drink it function Commented>>
               local procedure SerialNoTextOnFormat(var Text: Text[1024]);
               begin
                   //<<QXL9.00.001 DAT 23/03/2016
                   if QualitySetup.READPERMISSION then begin
                       SerialNocolor := QualityManagement.IsRequired(Text);
                   end;
                   //>>QXL9.00.001 DAT 23/03/2016
               end;
               */ //BCUPGRADE YADAVM09 Drink it function Commented<<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

