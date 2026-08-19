pageextension 51086 UnitsofMeasureExtCBN extends "Units of Measure"
{
    // version NAVW110.0,IPLXL9.00.001,DITW110.00.08,HEI.02,HEI.01
    //DITW15.00.00.23 DDR 28/07/2008 Added column "Code Caption"
    //                                Resize Width Form
    //DITW15.00.00.38 DDR 12/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                Added fields "Packaging Type Code"
    //                                Added "Packaging Type Code" filter value for new records
    //                                Added form property 'DataCaptionFields'
    //                                Added menu item Unit of measure
    //DITW17.00.02 AT  12/09/2013 DIT-770 #154
    //                            Added field 2014060 Picking Type
    //DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    //DITW18.00.07 VSC 18/05/2016 DIT-770 #1972 Merge FINXL EDI Interface
    //DITW18.00.07 DDR 05/04/2016 DIT-770 #1488 Route Planning functionality (OSP version2)

    //DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //IPLXL9.00.001 IMI 15/06/2015: Added field "EDI Unit of Measure"
    //DITW111.00.13A MSF 07/05/2019 NRQ#109275 Route Planning Worksheet- extensions on shortcut UOMs
    //                                Added Action ExistShortUOMInWarehouseSetup
    //DITW111.00.13A MSF 07/05/2019 NRQ#109275 Renumber page 2035640--->2035431

    //HEI.01 FDD-PURGAPINT002 IBM LAZARE02 18.10.2017 # New field for Maximo: "Commercial ISO Code"
    //HEI.02 FDD-PA-LOGGAP08 IBM POSTOI01 25.07.2018
    //    # add new function GetSelectionFilter


    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a code for the unit of measure, which you can select on item and resource cards from where it is copied to.', FRA = 'Spécifie un code de l''unité de mesure, que vous pouvez sélectionner dans des fiches article et ressource à partir desquelles il est copié.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the unit of measure.', FRA = 'Indique une description de l''unité.';
        }
        modify("International Standard Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code expressed according to the UNECERec20 standard in connection with electronic sending of sales documents. For example, when sending sales documents through the PEPPOL service, the value in this field is used to populate the UnitCode element in the Product group.', FRA = 'Spécifie le code unité de mesure exprimé en fonction de la norme UNECERec20 en relation avec l''envoi électronique de documents de vente. Par exemple, lors de l''envoi de documents de vente via le service PEPPOL, la valeur présente dans ce champ sert à renseigner l''élément UnitCode dans le groupe Produit.';
        }
        addafter("International Standard Code")
        {
            field("Commercial ISO Code"; Rec."Commercial ISO Code FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Commercial ISO Code field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Commercial ISO Code field.';

            }
            //BC Upgrade Priya>>  Drink IT fields
            //field("Code Caption";"Code Caption")
            //{
            //}
            //field("Packaging Type Code";"Packaging Type Code")
            //{
            //    LookupPageID = "Packaging Types";
            //}
            //field("Picking Type";"Picking Type")
            //{
            //}
            //field("EDI Unit of Measure";"EDI Unit of Measure")
            //{
            //    Description = 'IPLXL9.00.001';
            //} //BC Upgrade Priya<<
        }
    }
    actions
    {
        modify("&Unit")
        {
            CaptionML = ENU = '&Unit', FRA = '&Unité';
        }
        modify(Translations)
        {
            CaptionML = ENU = 'Translations', FRA = 'Traductions';
            ToolTipML = ENU = 'View or edit descriptions for each unit of measure in different languages.', FRA = 'Affichez ou modifiez des descriptions de chaque unité de mesure dans différentes langues.';
        }
        modify(ActionGroupCRM)
        {
            CaptionML = ENU = 'Dynamics CRM', FRA = 'Dynamics CRM';
        }
        modify(CRMGotoUnitsOfMeasure)
        {
            CaptionML = ENU = 'Unit of Measure', FRA = 'Unité';
            ToolTipML = ENU = 'Open the coupled Microsoft Dynamics CRM unit of measure.', FRA = 'Ouvrez l''unité Microsoft Dynamics CRM couplée.';
        }
        modify(CRMSynchronizeNow)
        {
            CaptionML = ENU = 'Synchronize Now', FRA = 'Synchroniser maintenant';
            ToolTipML = ENU = 'Send updated data to Microsoft Dynamics CRM.', FRA = 'Envoyez des données mises à jour à Microsoft Dynamics CRM.';
        }
        modify(Coupling)
        {
            CaptionML = ENU = 'Coupling', FRA = 'Couplage';
            ToolTipML = ENU = 'Create, change, or delete a coupling between the Microsoft Dynamics NAV record and a Microsoft Dynamics CRM record.', FRA = 'Créez, modifiez ou supprimez un couplage entre l''enregistrement Microsoft Dynamics NAV et un enregistrement Microsoft Dynamics CRM.';
        }
        modify(ManageCRMCoupling)
        {
            CaptionML = ENU = 'Set Up Coupling', FRA = 'Configurer le couplage';
            ToolTipML = ENU = 'Create or modify the coupling to a Microsoft Dynamics CRM Unit of Measure.', FRA = 'Créez ou modifiez le couplage avec une unité Microsoft Dynamics CRM.';
        }
        modify(DeleteCRMCoupling)
        {
            CaptionML = ENU = 'Delete Coupling', FRA = 'Supprimer le couplage';
            ToolTipML = ENU = 'Delete the coupling to a Microsoft Dynamics CRM Unit of Measure.', FRA = 'Supprimez le couplage avec une unité Microsoft Dynamics CRM.';
        }
        addafter(Translations)
        {
            action("Item Units of Measure")
            {
                CaptionML = ENU = 'Item Units of Measure',
                            FRA = 'Unités article';
                Image = UnitOfMeasure;
                RunObject = Page "Item Units of Measure";
                RunPageLink = Code = FIELD(Code);
                ApplicationArea = All;
                ToolTip = 'Executes the Item Units of Measure action.';
            }
            //BC Upgrade Priya>> Drink IT
            //action("Unit Of measure Relations")
            //{
            //    Caption = 'Unit Of measure Relations';
            //    Description = 'DITW111.00.13A MSF 07/05/2019 NRQ#109275';
            //    Enabled = EnableUnitOfMeasureRelation;
            //   Image = Relationship;
            //    Promoted = true;
            //    RunObject = Page "Unit Of Measure Code Relation";
            //    RunPageLink = "Related Unit Of Measure Code"=FIELD(Code);
            //} //BC Upgrade Priya<<
        }
    }

    var
        EnableUnitOfMeasureRelation: Boolean;


    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CRMIsCoupledToRecord := CRMIntegrationEnabled and CRMCouplingManagement.IsRecordCoupledToCRM(RECORDID);
    //<<DITW111.00.13A MSF 07/05/2019 NRQ#109275
    EnableUnitOfMeasureRelation := ExistShortUOMInWarehouseSetup(Code);
    //>>DITW111.00.13A MSF 07/05/2019 NRQ#109275
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnInit". Please convert manually.

    //trigger OnInit();
    //Parameters and return type have not been exported.
    //begin
    /*
    //<<DITW111.00.13A MSF 07/05/2019 NRQ#109275
    EnableUnitOfMeasureRelation := true;
    //>>DITW111.00.13A MSF 07/05/2019 NRQ#109275
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNewRecord". Please convert manually.

    //trigger OnNewRecord(BelowxRec : Boolean);
    //begin
    /*
    // <<DITW15.00.00.38 DDR 25/08/2010 #1217
    "Packaging Type Code" := GETFILTER("Packaging Type Code");
    // >>DITW15.00.00.38 DDR
    */
    //end;

    procedure GetSelectionFilter(): Text;
    var
        UM: Record "Unit of Measure";
        HeinekenBCUpgd: Codeunit "Heineken BC Upgrade"; //BC Upgrade Priya<< Function added
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    begin
        //>>HEI.02
        CurrPage.SETSELECTIONFILTER(UM);
        exit(HeinekenBCUpgd.GetSelectionFilterForUM(UM));//BC Upgrade Priya<< 
        //<<HEI.02
    end;

    //BC Upgrade Priya>>  Drink IT
    //local procedure ExistShortUOMInWarehouseSetup(UnitOfMeasureCode : Code[10]) : Boolean;
    //var
    //    WarehouseSetup : Record "Warehouse Setup";
    //begin
    //<<DITW111.00.13A MSF 07/05/2019 NRQ#109275
    //    WarehouseSetup.GET;
    //    case true of
    //      (UnitOfMeasureCode= WarehouseSetup."Shortcut Unit of Measure1 Code") and (WarehouseSetup."Calc. Short. Qty per UOM1 Code" = WarehouseSetup."Calc. Short. Qty per UOM1 Code"::"Source Line UOM Code"),
    //      (UnitOfMeasureCode= WarehouseSetup."Shortcut Unit of Measure2 Code") and (WarehouseSetup."Calc. Short. Qty per UOM2 Code" = WarehouseSetup."Calc. Short. Qty per UOM2 Code"::"Source Line UOM Code"),
    //      (UnitOfMeasureCode= WarehouseSetup."Shortcut Unit of Measure3 Code") and (WarehouseSetup."Calc. Short. Qty per UOM3 Code" = WarehouseSetup."Calc. Short. Qty per UOM3 Code"::"Source Line UOM Code"):
    //        exit(true);
    //    end;
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

