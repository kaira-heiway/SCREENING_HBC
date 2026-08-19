pageextension 51104 ItemTracingExtCBN extends "Item Tracing"
{
    // DITW16.00.00.39 DDR 29/07/2011 DIT-715 #134 Bugfix RTC logic standard button "Functions" & "Functions2"
    //                                                                                             Modified Visible property Action Page (ActionGroup30,ActionGroup36)
    //                                                                                             Added Visible,Enabled property Action Page (Action59,Action26)
    //                                                                                             Button Function2 is hidden behind tablebox - ensure that shortkeys for next and previous are active even though the
    //                                                                                             real Function button is disabled.

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 CHG2012342 IBM GAVANM01 19/11/2019 # Your Reference field added

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify(SerialNoFilter)
        {
            CaptionML = ENU = 'Serial No. Filter', FRA = 'Filtre n° de série';
            ToolTipML = ENU = 'Specifies the serial number or a filter on the serial numbers that you would like to trace.', FRA = 'Spécifie le numéro de série ou un filtre sur les numéros de série à suivre.';
        }
        modify(LotNoFilter)
        {
            CaptionML = ENU = 'Lot No. Filter', FRA = 'Filtre n° lot';
            ToolTipML = ENU = 'Specifies the lot number or a filter on the lot numbers that you would like to trace.', FRA = 'Spécifie le numéro de lot ou un filtre sur les numéros de lot à suivre.';
        }
        modify(ItemNoFilter)
        {
            CaptionML = ENU = 'Item Filter', FRA = 'Filtre article';
            ToolTipML = ENU = 'Specifies the item number or a filter on the item numbers that you would like to trace.', FRA = 'Spécifie le numéro d''article ou un filtre pour les numéros d''article que vous voulez suivre.';
        }
        modify(VariantFilter)
        {
            CaptionML = ENU = 'Variant Filter', FRA = 'Filtre variante';
            ToolTipML = ENU = 'Specifies the variant code or a filter on the variant codes that you would like to trace.', FRA = 'Spécifie le code de variante ou un filtre sur les codes de variante que vous souhaitez suivre.';
        }
        modify(ShowComponents)
        {
            CaptionML = ENU = 'Show Components', FRA = 'Afficher composants';
            ToolTipML = ENU = 'Specifies if you would like to see the components of the item that you are tracing.', FRA = 'Indique si vous souhaitez afficher les composants de l''article que vous suivez.';
            OptionCaptionML = ENU = 'No,Item-tracked Only,All', FRA = 'Non,Article suivi uniquement,Tous';
        }
        modify(TraceMethod)
        {
            CaptionML = ENU = 'Trace Method', FRA = 'Méthode de suivi';
            ToolTipML = ENU = 'Specifies posted serial/lot numbers that can be traced either forward or backward in a supply chain.', FRA = 'Spécifie les numéros de série/lot validés dont le suivi peut être effectué en aval ou en amont de la chaîne d''approvisionnement.';
            OptionCaptionML = ENU = 'Origin -> Usage,Usage -> Origin', FRA = 'Origine -> Activité,Activité -> Origine';
        }
        modify(Control35)
        {
            ToolTipML = ENU = 'These are the settings that were used to generate the trace result.', FRA = 'Ces paramètres ont permis de générer le résultat de suivi ci-dessous.';
        }

        //Unsupported feature: Change ShowAsTree on "Control1(Control 1)". Please convert manually.

        modify(Description)
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Entry Type")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Serial No.")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Lot No.")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Item No.")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Item Description")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Document No.")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Posting Date")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Source Type")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Source No.")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Source Name")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Location Code")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify(Quantity)
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Remaining Quantity")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Created by")
        {

            //Unsupported feature: Change Lookup on ""Created by"(Control 1000000023)". Please convert manually.

            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Created on")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Already Traced")
        {
            ToolTipML = ENU = 'Specifies if additional transaction history under this line has already been traced by other lines above it.', FRA = 'Indique si l''historique des transactions supplémentaires sous cette ligne a déjà été suivi par d''autres lignes au-dessus.';
        }
        modify("Item Ledger Entry No.")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }
        modify("Parent Item Ledger Entry No.")
        {
            ToolTipML = ENU = 'This field is used internally.', FRA = 'Ce champ est utilisé en interne.';
        }

        //Unsupported feature: PropertyDeletion on "Control1900000001(Control 1900000001)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "General(Control 1000000001)". Please convert manually.


        //Unsupported feature: CodeModification on "SerialNoFilter(Control 18).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SerialNoInfo.RESET;

           CLEAR(SerialNoList);
           SerialNoList.SETTABLEVIEW(SerialNoInfo);
           if SerialNoList.RUNMODAL = ACTION::LookupOK then
             SerialNoFilter := SerialNoList.GetSelectionFilter;
           */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
           #1..4
           IF SerialNoList.RUNMODAL = ACTION::LookupOK THEN
             SerialNoFilter := SerialNoList.GetSelectionFilter;
           */
        //end;

        //Unsupported feature: PropertyDeletion on "SerialNoFilter(Control 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "SerialNoFilter(Control 18)". Please convert manually.



        //Unsupported feature: CodeModification on "LotNoFilter(Control 13).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
           LotNoInfo.RESET;

           CLEAR(LotNoList);
           LotNoList.SETTABLEVIEW(LotNoInfo);
           if LotNoList.RUNMODAL = ACTION::LookupOK then
             LotNoFilter := LotNoList.GetSelectionFilter;
           */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
           #1..4
           IF LotNoList.RUNMODAL = ACTION::LookupOK THEN
             LotNoFilter := LotNoList.GetSelectionFilter;
           */
        //end;

        //Unsupported feature: PropertyDeletion on "LotNoFilter(Control 13)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "LotNoFilter(Control 13)". Please convert manually.



        //Unsupported feature: CodeModification on "ItemNoFilter(Control 1000000013).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
           Item.RESET;

           CLEAR(ItemList);
           ItemList.SETTABLEVIEW(Item);
           ItemList.LOOKUPMODE(true);
           if ItemList.RUNMODAL = ACTION::LookupOK then
             ItemNoFilter := ItemList.GetSelectionFilter;
           */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
           #1..4
           ItemList.LOOKUPMODE(TRUE);
           IF ItemList.RUNMODAL = ACTION::LookupOK THEN
             ItemNoFilter := ItemList.GetSelectionFilter;
           */
        //end;


        //Unsupported feature: CodeModification on "ItemNoFilter(Control 1000000013).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
           if ItemNoFilter = '' then
             VariantFilter := '';
           */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
           IF ItemNoFilter = '' THEN
             VariantFilter := '';
           */
        //end;

        //Unsupported feature: PropertyDeletion on "ItemNoFilter(Control 1000000013)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ItemNoFilter(Control 1000000013)". Please convert manually.



        //Unsupported feature: CodeModification on "VariantFilter(Control 4).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
           if ItemNoFilter = '' then
             ERROR(Text001);

           ItemVariant.RESET;

           CLEAR(ItemVariants);
           ItemVariant.SETFILTER("Item No.",ItemNoFilter);
           ItemVariants.SETTABLEVIEW(ItemVariant);
           ItemVariants.LOOKUPMODE(true);
           if ItemVariants.RUNMODAL = ACTION::LookupOK then begin
             ItemVariants.GETRECORD(ItemVariant);
             VariantFilter := ItemVariant.Code;
           end;
           */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
           IF ItemNoFilter = '' THEN
           #2..8
           ItemVariants.LOOKUPMODE(TRUE);
           IF ItemVariants.RUNMODAL = ACTION::LookupOK THEN BEGIN
             ItemVariants.GETRECORD(ItemVariant);
             VariantFilter := ItemVariant.Code;
           end;
           */
        //end;


        //Unsupported feature: CodeModification on "VariantFilter(Control 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
           if ItemNoFilter = '' then
             ERROR(Text001);
           */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
           IF ItemNoFilter = '' THEN
             ERROR(Text001);
    
        */
        //end;

        //Unsupported feature: PropertyDeletion on "VariantFilter(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "VariantFilter(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ShowComponents(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ShowComponents(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "TraceMethod(Control 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "TraceMethod(Control 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control35(Control 35)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 1000000015)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 1000000015)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Entry Type"(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Serial No."(Control 1000000034)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Serial No."(Control 1000000034)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot No."(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lot No."(Control 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 1000000030)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item No."(Control 1000000030)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item Description"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item Description"(Control 32)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 2)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document No."(Control 1000000032)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Document No."(Control 1000000032)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 1000000043)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Posting Date"(Control 1000000043)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Source Type"(Control 1000000017)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Source Type"(Control 1000000017)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Source No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Source No."(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Source Name"(Control 1000000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Source Name"(Control 1000000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Location Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 1000000021)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Quantity(Control 1000000021)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Remaining Quantity"(Control 1000000019)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Remaining Quantity"(Control 1000000019)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Created by"(Control 1000000023)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Created by"(Control 1000000023)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Created on"(Control 1000000025)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Created on"(Control 1000000025)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Already Traced"(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Already Traced"(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item Ledger Entry No."(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Item Ledger Entry No."(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Parent Item Ledger Entry No."(Control 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Parent Item Ledger Entry No."(Control 5)". Please convert manually.

        addafter("Parent Item Ledger Entry No.")
        {
            field("Your Reference"; Rec."Your Reference FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Your Reference field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Your Reference field.';

            }
        }
    }
    actions
    {
        modify(Line)
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(ShowDocument)
        {
            CaptionML = ENU = 'Show Document', FRA = 'Afficher document';
            Promoted = True;//BC Upgrade KAPOOV01 changed value from yes to True.
            PromotedCategory = Process;
        }
        modify(Item)
        {
            CaptionML = ENU = '&Item', FRA = 'Arti&cle';
        }
        modify(Card)
        {
            CaptionML = ENU = 'Card', FRA = 'Fiche';

            //Unsupported feature: Change RunObject on "Card(Action 17)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "Card(Action 17)". Please convert manually.

        }
        modify(LedgerEntries)
        {
            CaptionML = ENU = 'Ledger E&ntries', FRA = 'É&critures comptables';

            //Unsupported feature: Change RunObject on "LedgerEntries(Action 19)". Please convert manually.


            //Unsupported feature: Change RunPageView on "LedgerEntries(Action 19)". Please convert manually.


            //Unsupported feature: Change RunPageLink on "LedgerEntries(Action 19)". Please convert manually.

            Promoted = False;////BC Upgrade KAPOOV01 changed value from No to False.
        }
        modify(Functions)
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(TraceOppositeFromLine)
        {
            CaptionML = ENU = '&Trace Opposite - from Line', FRA = 'O&pposé suivi - Ligne d''origine';
            Promoted = True;//BC Upgrade KAPOOV01 changed value from yes to True.

            //Unsupported feature: Change Visible on "TraceOppositeFromLine(Action 59)". Please convert manually.

        }
        modify(SetFiltersWithLineValues)
        {
            CaptionML = ENU = 'Set &Filters with Line Values', FRA = 'Définir des &filtres avec des valeurs de ligne';

            //Unsupported feature: Change Visible on "SetFiltersWithLineValues(Action 26)". Please convert manually.

        }
        modify("Go to Already-Traced History")
        {
            CaptionML = ENU = 'Go to Already-Traced History', FRA = 'Accéder à l''historique Déjà tracé';
        }
        modify(NextTraceResult)
        {
            CaptionML = ENU = 'Next Trace Result', FRA = 'Résultat suivant du suivi';
        }
        modify(PreviousTraceResult)
        {
            CaptionML = ENU = 'Previous Trace Result', FRA = 'Résultat précédent du suivi';
        }
        modify(Print)
        {

            //Unsupported feature: Change Ellipsis on "Print(Action 16)". Please convert manually.

            CaptionML = ENU = '&Print', FRA = '&Imprimer';
            Promoted = True;//BC Upgrade KAPOOV01 changed value from yes to True.
        }
        modify(Navigate)
        {
            CaptionML = ENU = '&Navigate', FRA = 'Na&viguer';
            Promoted = True;//BC Upgrade KAPOOV01 changed value from yes to True.
        }
        modify(Trace)
        {
            CaptionML = ENU = '&Trace', FRA = '&Suivi';
            Promoted = True;//BC Upgrade KAPOOV01 changed value from yes to True.
            PromotedIsBig = True;//BC Upgrade KAPOOV01 changed value from yes to True.
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer1900000003(Action 1900000003)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer1900000004(Action 1900000004)". Please convert manually.



        //Unsupported feature: CodeModification on "TraceOppositeFromLine(Action 59).OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if TraceMethod = TraceMethod::"Origin->Usage" then
             TraceMethod := TraceMethod::"Usage->Origin"
           else
             TraceMethod := TraceMethod::"Origin->Usage";
           OppositeTraceFromLine;
           */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
           IF TraceMethod = TraceMethod::"Origin->Usage" THEN
             TraceMethod := TraceMethod::"Usage->Origin"
           else
             TraceMethod := TraceMethod::"Origin->Usage";
           OppositeTraceFromLine;
    
        */
        //end;
    }


    //Unsupported feature: PropertyModification on "Print(Action 16).OnAction.xItemTracingBuffer(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Print : "Item Tracing Buffer";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Print : 6520;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Print(Action 16).OnAction.PrintTracking(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Print : "Item Tracing Specification";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Print : 6520;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Navigate(Action 11).OnAction.Navigate(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Navigate : Navigate;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Navigate : 344;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SerialNoFilter(Control 18).OnLookup.SerialNoInfo(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SerialNoFilter : "Serial No. Information";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SerialNoFilter : 6504;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "SerialNoFilter(Control 18).OnLookup.SerialNoList(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //SerialNoFilter : "Serial No. Information List";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //SerialNoFilter : 6509;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "LotNoFilter(Control 13).OnLookup.LotNoInfo(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //LotNoFilter : "Lot No. Information";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LotNoFilter : 6505;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "LotNoFilter(Control 13).OnLookup.LotNoList(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //LotNoFilter : "Lot No. Information List";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //LotNoFilter : 6508;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemNoFilter(Control 1000000013).OnLookup.Item(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemNoFilter : Item;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemNoFilter : 27;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemNoFilter(Control 1000000013).OnLookup.ItemList(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemNoFilter : "Item List";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemNoFilter : 31;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "VariantFilter(Control 4).OnLookup.ItemVariant(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //VariantFilter : "Item Variant";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VariantFilter : 5401;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "VariantFilter(Control 4).OnLookup.ItemVariants(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //VariantFilter : "Item Variants";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VariantFilter : 5401;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Quantity(Control 1000000021).OnDrillDown.ItemLedgerEntry(Variable 1000000000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Quantity : "Item Ledger Entry";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Quantity : 32;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TempTrackEntry(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TempTrackEntry : "Item Tracing Buffer";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TempTrackEntry : 6520;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemTracingMgt(Variable 1017)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemTracingMgt : "Item Tracing Mgt.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemTracingMgt : 6520;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "TraceMethod(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //TraceMethod : "Origin->Usage","Usage->Origin";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TraceMethod : Origin->Usage,Usage->Origin;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowComponents(Variable 1000000002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowComponents : No,"Item-tracked Only",All;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowComponents : No,Item-tracked Only,All;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ActualExpansionStatus(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ActualExpansionStatus : "Has Children",Expanded,"No Children";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ActualExpansionStatus : Has Children,Expanded,No Children;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=Item No. Filter is required.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=Item No. Filter is required.;FRA=Filtre n° article requis.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=Serial No.: %1, Lot No.: %2, Item: %3, Variant: %4, Trace Method: %5, Show Components: %6;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=Serial No.: %1, Lot No.: %2, Item: %3, Variant: %4, Trace Method: %5, Show Components: %6;FRA=N° de série : %1, N° lot : %2 Article : %3, Variante : %4, Méthode de suivi : %5, Afficher composants : %6;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Filters are too large to show.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Filters are too large to show.;FRA=Filtres trop grands pour être affichés.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=Origin->Usage,Usage->Origin;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=Origin->Usage,Usage->Origin;FRA=Origine->Activité,Activité->Origine;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=No,Item-tracked Only,All;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=No,Item-tracked Only,All;FRA=Non,Article suivi uniquement,Tous;
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    NavigateEnable := true;
    PrintEnable := true;
    FunctionsEnable := true;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    NavigateEnable := TRUE;
    PrintEnable := TRUE;
    FunctionsEnable := TRUE;
    */
    //end;


    //Unsupported feature: CodeModification on "FindRecords(PROCEDURE 1000000001)". Please convert manually.

    //procedure FindRecords();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemTracingMgt.FindRecords(TempTrackEntry,Rec,
      SerialNoFilter,LotNoFilter,ItemNoFilter,VariantFilter,
      TraceMethod,ShowComponents);
    #4..7
    UpdateTraceText;

    ItemTracingMgt.ExpandAll(TempTrackEntry,Rec);
    CurrPage.UPDATE(false)
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..10
    CurrPage.UPDATE(FALSE)
    */
    //end;


    //Unsupported feature: CodeModification on "InitButtons(PROCEDURE 7)". Please convert manually.

    //procedure InitButtons();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if not TempTrackEntry.FINDFIRST then begin
      FunctionsEnable := false;
      PrintEnable := false;
      NavigateEnable := false;
    end else begin
      FunctionsEnable := true;
      PrintEnable := true;
      NavigateEnable := true;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT TempTrackEntry.FINDFIRST THEN BEGIN
      FunctionsEnable := FALSE;
      PrintEnable := FALSE;
      NavigateEnable := FALSE;
    end else BEGIN
      FunctionsEnable := TRUE;
      PrintEnable := TRUE;
      NavigateEnable := TRUE;
    end;
    */
    //end;


    //Unsupported feature: CodeModification on "RecallHistory(PROCEDURE 2)". Please convert manually.

    //procedure RecallHistory();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemTracingMgt.RecallHistory(Steps,TempTrackEntry,Rec,SerialNoFilter,
      LotNoFilter,ItemNoFilter,VariantFilter,TraceMethod,ShowComponents);
    UpdateTraceText;
    InitButtons;
    ItemTracingMgt.GetHistoryStatus(PreviousExists,NextExists);

    ItemTracingMgt.ExpandAll(TempTrackEntry,Rec);
    CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    CurrPage.UPDATE(FALSE);
    */
    //end;


    //Unsupported feature: CodeModification on "UpdateTraceText(PROCEDURE 3)". Please convert manually.

    //procedure UpdateTraceText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LengthOfText := (STRLEN(Text002 + SerialNoFilter + LotNoFilter + ItemNoFilter + VariantFilter) +
                     STRLEN(FORMAT(TraceMethod)) + STRLEN(FORMAT(ShowComponents)) - 6); // 6 = number of positions in Text002

    Overflow := LengthOfText > 512;

    if Overflow then
      TraceText := Text003
    else
      TraceText := STRSUBSTNO(Text002,SerialNoFilter,LotNoFilter,ItemNoFilter,VariantFilter,
          SELECTSTR(TraceMethod + 1,Text004) ,SELECTSTR(ShowComponents + 1,Text005));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    IF Overflow THEN
      TraceText := Text003
    else
      TraceText := STRSUBSTNO(Text002,SerialNoFilter,LotNoFilter,ItemNoFilter,VariantFilter,
          SELECTSTR(TraceMethod + 1,Text004) ,SELECTSTR(ShowComponents + 1,Text005));
    */
    //end;


    //Unsupported feature: CodeModification on "SetFocus(PROCEDURE 5)". Please convert manually.

    //procedure SetFocus();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if "Already Traced" then begin
      TempTrackEntry.SETCURRENTKEY("Item Ledger Entry No.");
      TempTrackEntry.SETRANGE("Item Ledger Entry No.",ItemLedgerEntryNo);
      TempTrackEntry.FINDFIRST;
      CurrPage.SETRECORD(TempTrackEntry);
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF "Already Traced" THEN BEGIN
    #2..5
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

