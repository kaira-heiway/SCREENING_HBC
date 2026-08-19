pageextension 51087 ItemTemplCardExtCBN extends "Item Templ. Card"
{
    // version NAVW110.0,QXL10.00,DITW110.00.08,HEI.01
    //DITW15.00.00.28 DDR 24/11/2008 Added fields "ADD Nos.","Def. Tax Spec. HL","Def. Tax Spec. Degree Plato"
    //DITW15.00.00.37 DDR 16/02/2010 Issue 960 Added field "Inventory Value Zero"
    //DITW15.00.00.38 DDR 10/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                Added fields
    //                                    "DDeposit Group Code","DDeposit Group Mandatory"
    //                                    "DTax Group Code","DDiscount Group Mandatory","DPromotion Group Mandatory"
    //                                    "Value Douane Mandatory","Location Code","Tariff No.","Tariff Mandatory"
    //                                    "Country/Region Purchased Code","Country/R. Purchased Mandatory"
    //                                    "Country/Region of Origin Code","Country/R. of Origin Mandatory"
    //                                    "Gross Weight Mandatory","Net Weight Mandatory","Inventory Value Zero Mandatory"
    //                                    "Price Mandatory","Item Disc. Group Mandatory","Line Discount Mandatory",
    //                                    "Item Tracking Mandatory","DTax Group Mandatory","Quality Standard Mandatory"
    //                                Added button 'Category'
    //                                Removed fields "Tax Spec. HL","Tax Spec. Degrees Plato"
    //                    05/01/2011 issue 822 Added fields "Service Item Group"
    //                    01/02/2011 issue 941 Added fields "Gen. Prod. Posting Free Group","Free Item Posting Type","Free Item"
    //                    03/02/2011 issue 941 + Non-visible
    //DITW16.00.00.40 DDR 05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" into 'Drink-it' tab

    //DITW17.00.02 DDR 17/05/2013 DIT-770 #95 Added fields "C945 Category Type","C945 Category Unit of Measure"
    //                28/08/2013 DIT-770 #178 Remove DIT-770 #95
    //DITW17.00.02 AT  25/09/2013 DIT-770 #145 Added New Field St. Return Reason Code
    //DITW17.10.05 DDR 12/02/2015 DIT-770 #1118 Added field "Free Reason Code"
    //                                        Modified all custom fields visible

    //DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //DITW110.00.08 DDR 09/02/2017 NRQ#20699 Add all DIT from page2014426 Item Category Card
    //                                        Deleted field2034927 Service Item Group (= NAV field5900)
    //                                        Renamed field names 2013824,2014060

    //QXL10.00 DDR 09/02/2017 NRQ#20699 added field2035091
    //HEI.01 FDD-KDD0TC001 IBM HORTOC01 02.10.2017
    //# check fields

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        //BC Upgrade Priya - Fields not found in Business Central base table
        //modify("Template Name")
        //{
        //    ToolTipML = ENU='Specifies the name of the template.',FRA='Spécifie le nom du modèle.';
        //}
        //modify(TemplateEnabled)
        //{
        //    CaptionML = ENU='Enabled',FRA='Activé';
        //    ToolTipML = ENU='Specifies if the template is ready to be used',FRA='Spécifie si le modèle est prêt pour utilisation.';
        //}//BC Upgrade Priya<< - Fields not found in Business Central base table

        //BC Upgrade Priya<< - Item Setup group not found in Business Central base table
        //modify("Item Setup")
        //{
        //    CaptionML = ENU='Item Setup',FRA='Paramètres article';
        //} //BC Upgrade Priya<< - Item Setup group not found in Business Central base table
        modify("Base Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit in which the item is held in inventory. The base unit of measure also serves as the conversion basis for alternate units of measure.', FRA = 'Spécifie l''unité dans laquelle l''article est stocké. L''unité de base sert également de base de conversion pour d''autres unités.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies if the item card represents a physical item (Inventory) or a service (Service).', FRA = 'Spécifie si la fiche article représente un article physique (Stock) ou un service (Service).';
        }
        modify("Automatic Ext. Texts")
        {
            ToolTipML = ENU = 'Specifies that an extended text will be added on sales or purchase documents for this item.', FRA = 'Spécifie qu''un texte étendu sera ajouté aux documents vente ou achat de cet article.';
        }
        //BC Upgrade Priya>> - Group Name changed from Price to PricesAndSales in Business Central.
        // modify(Price)
        // {
        //     CaptionML = ENU = 'Price', FRA = 'Prix';
        // }//BC Upgrade Priya<< - Group Name changed from Price to PricesAndSales in Business Central.
        modify("Price Includes VAT")
        {
            ToolTipML = ENU = 'Specifies if the Unit Price and Line Amount fields on sales document lines for this item should be shown with or without VAT.', FRA = 'Spécifie si les champs Prix unitaire et Montant ligne sur les lignes document vente pour cet article doivent être affichés avec ou sans la TVA.';
        }
        modify("Price/Profit Calculation")
        {
            ToolTipML = ENU = 'Specifies if the Profit Percentage field, the Unit Price field, or neither field is calculated and filled.', FRA = 'Spécifie si le champ % marge sur vente, le champ Prix unitaire ou aucun des deux champs est calculé et renseigné.';
        }
        modify("Profit %")
        {
            ToolTipML = ENU = 'Specifies the profit you have made from the customer in the current fiscal year, as a percentage of the customer''s total sales.', FRA = 'Spécifie la marge que vous avez réalisée pour ce client au cours de l''exercice comptable en cours, en pourcentage des ventes totales du client.';
        }
        modify("Allow Invoice Disc.")
        {
            ToolTipML = ENU = 'Specifies if the item should be included in the calculation of an invoice discount on documents where the item is traded.', FRA = 'Spécifie si l''article doit être inclus dans le calcul d''une remise facture sur les documents dans lesquels l''article est négocié.';
        }
        modify("Item Disc. Group")
        {
            ToolTipML = ENU = 'Specifies an item group code that can be used as a criterion to grant a discount when the item is sold to a certain customer.', FRA = 'Indique un code groupe articles qui peut être utilisé comme critère pour octroyer une remise lorsque l''article est vendu à un client spécifique.';
        }
        //BC Upgrade Priya>> - Group Name changed from Cost to CostsAndPosting in Business Central.
        // modify(CostsAndPosting)
        // {
        //     CaptionML = ENU = 'Cost', FRA = 'Coût';
        // }//BC Upgrade Priya<< - Group Name changed from Cost to CostsAndPosting in Business Central.
        modify("Costing Method")
        {
            ToolTipML = ENU = 'Specifies links between business transactions made for this item and the general ledger, to account for VAT amounts that result from trade with the item.', FRA = 'Spécifie les liens entre les transactions commerciales effectuées pour cet article et les écritures comptables, pour représenter les montants de TVA découlant de la négociation de l''article.';
        }
        modify("Indirect Cost %")
        {
            ToolTipML = ENU = 'Specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item.', FRA = 'Spécifie le pourcentage du dernier coût d''achat de l''article qui inclut les coûts indirects, comme le fret associé à l''achat de l''article.';
        }
        //BC Upgrade Priya>> - Group Name changed from Financial Details to PostingDetails in Business Central.
        // modify("PostingDetails")
        // {
        //     CaptionML = ENU = 'Financial Details', FRA = 'Détails financiers';
        // }//BC Upgrade Priya<< - Group Name changed from Financial Details to PostingDetails in Business Central.
        modify("Gen. Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies links between business transactions made for this item and the general ledger, to account for the value of trade with the item.', FRA = 'Spécifie les liens entre les transactions commerciales effectuées pour cet article et les écritures comptables, pour représenter la valeur découlant de la négociation de l''article.';
        }
        modify("VAT Prod. Posting Group")
        {
            ToolTipML = ENU = 'Specifies links between business transactions made for this item and the general ledger, to account for VAT amounts that result from trade.', FRA = 'Spécifie les liens entre les transactions commerciales effectuées pour cet article et les écritures comptables, pour représenter les montants de TVA découlant de la négociation.';
        }
        modify("Inventory Posting Group")
        {
            ToolTipML = ENU = 'Specifies links between business transactions made for the item and an inventory account in the general ledger, to group amounts for that item type.', FRA = 'Spécifie les liens entre les transactions commerciales effectuées pour l''article et un compte stock en comptabilité, pour regrouper les montants de ce type d''article.';
        }
        modify("Tax Group Code")
        {
            ToolTipML = ENU = 'Specifies the tax group code for the tax-detail entry.', FRA = 'Spécifie le code groupe taxes de l''écriture spécification de taxe.';
        }
        //BC Upgrade Priya>> -  Not found in Business Central base page.
        //modify(Categorization)
        //{
        //    CaptionML = ENU='Categorization',FRA='Catégorisation';
        //}//BC Upgrade Priya<< -  Not found in Business Central base page.
        modify("Item Category Code")
        {
            ToolTipML = ENU = 'Specifies the category that the item belongs to.', FRA = 'Spécifie la catégorie à laquelle l''article appartient.';
        }
        addafter("Automatic Ext. Texts")
        {
            field("Item Type"; Rec."Item Type FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Item Type field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the Item Type field.';

            }
            field("RPM Solution"; Rec."RPM Solution FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the RPM Solution field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the RPM Solution field.';

            }
            field("RPM Type"; Rec."RPM Type FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the RPM Type field.';
                // BC Upgrade SHUKLP03 <<                ToolTip = 'Specifies the value of the RPM Type field.';

            }
            //BC Upgrade Priya>> - Drink IT
            //group(Promotion)
            //{
            //    CaptionML = ENU='Promotion',
            //                FRA='Promotion';
            //    field("Free Item";"Free Item")
            //    {
            //    }
            //    field("Free Reason Code";"Free Reason Code")
            //    {
            //    }
            //}
            //group(Exclusivity)
            //{
            //    CaptionML = ENU='Exclusivity',
            //                FRA='Exclusivité';
            //    field("Private Label Exclusivity";Exclusivity)
            //    {
            //    }
            //}//BC Upgrade Priya<< - Drink IT
        }
        //BC Upgrade Priya>> - Drink IT
        //addafter("Item Disc. Group")
        //{
        //    group(Control1101001003)
        //    {
        //        CaptionML = ENU='Promotion',
        //                    FRA='Promotion';
        //        field("Free Item Posting Type";"Free Item Posting Type")
        //        {
        //        }
        //        field("Allow VAT Calculation (Free)";"Allow VAT Calculation (Free)")
        //        {
        //            Description = 'DIT-715 #172 #359';
        //        }
        //    }
        //}
        //addafter("Tax Group Code")
        //{

        //    group(Tax)
        //    {
        //        CaptionML = ENU='Tax',
        //                    FRA='Taxes';
        //        field("Item DTax Group Code";"Item DTax Group Code")
        //        {
        //        }
        //        field("AAD Nos.";"AAD Nos.")
        //        {
        //        }
        //    }
        //    group(Deposit)
        //    {
        //        CaptionML = ENU='Deposit',
        //                    FRA='Consigne';
        //        field("Item DDeposit Group Code";"Item DDeposit Group Code")
        //        {
        //        }
        //    }
        //    group(Control1101001004)
        //    {
        //        CaptionML = ENU='Promotion',
        //                    FRA='Promotion';
        //        field("Prod. Posting Free Group";"Prod. Posting Free Group")
        //        {
        //        }
        //    }
        //}
        //addafter(Categorization)
        //{
        //    group("Shipping-Receiving")
        //    {
        //        CaptionML = ENU='Shipping-Receiving',
        //                    FRA='Expédier-Recevoir';
        //        field("Manco/Surplus Tolerance %";"Manco/Surplus Tolerance %")
        //        {
        //        }
        //    }
        //    group("Foreign Trade")
        //    {
        //        CaptionML = ENU='Foreign Trade',
        //                    FRA='International';
        //        field("Tariff No.";"Tariff No.")
        //        {
        //        }
        //        field("Country/Region of Origin Code";"Country/Region of Origin Code")
        //        {
        //        }
        //        field("Country/Region Purchased Code";"Country/Region Purchased Code")
        //        {
        //        }
        //    }
        //    group(Quality)
        //    {
        //        CaptionML = ENU='Quality',
        //                    FRA='Qualité';
        //        field("Quality Standard No.";"Quality Standard No.")
        //        {
        //        }
        //    }
        //}//BC Upgrade Priya<< - Drink IT
    }
    actions
    {
        //BC Upgrade Priya>> - Master Data action group is not found in Business central base page
        //modify("Master Data")
        //{
        //    CaptionML = ENU = 'Master Data', FRA = 'Données principales';
        //}//BC Upgrade Priya<< - Master Data action group is not found in Business central base page
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        myInt: Integer;
    begin
        //HEI.01>>
        if rec.Code <> '' then begin
            if Rec."Item Type FND" = Rec."Item Type FND"::"RPM Related" then begin
                Rec.TESTFIELD("RPM Solution FND");
                Rec.TESTFIELD("RPM Type FND");
            end else begin
                Rec.TESTFIELD("RPM Solution FND", 0);
                Rec.TESTFIELD("RPM Type FND", '');
            end;
        end;
        //HEI.01<<
    end;


    //Unsupported feature: PropertyModification on "ProvideTemplateNameErr(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ProvideTemplateNameErr : @@@=%1 Template Name;ENU=You must enter a %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ProvideTemplateNameErr : @@@=%1 Template Name;ENU=You must enter a %1.;FRA=Vous devez entrer un %1.;
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "OnQueryClosePage". Please convert manually.

    //trigger OnQueryClosePage(CloseAction : Action) : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    case CloseAction of
      ACTION::LookupOK:
        if Code <> '' then
          CheckTemplateNameProvided;
      ACTION::LookupCancel:
        if DELETE(true) then;
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    //HEI.01>>
    if Code <> '' then begin
      if "Item Type" = "Item Type"::"RPM Related" then begin
        TESTFIELD("RPM Solution");
        TESTFIELD("RPM Type");
      end else begin
        TESTFIELD("RPM Solution","RPM Solution"::" ");
        TESTFIELD("RPM Type",'');
      end;
    end;
    //HEI.01<<
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

