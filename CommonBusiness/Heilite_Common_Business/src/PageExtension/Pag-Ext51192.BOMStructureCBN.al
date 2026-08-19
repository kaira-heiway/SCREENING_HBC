pageextension 51192 BOMStructureExtCBN extends "BOM Structure"
{

    // HEI.01 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 05.09.2017 
    // # New function to calcutale BOM Structure on SKU lavel
    // version NAVW110.0

    //-----------------------------------------------------------------------------------------------------------
    //BC Upgrade KAPOOV01 05.12.2025 # Created new function -OnBeforeGenerateBOMTree in HeinekenBCUpgrade codeunit & Subscribed to it event-OnBeforeGenerateBOMTree of function-GenerateBOMTree so as to handle OnOpenpage Trigger related HEI.01 customization.
    //BC Upgrade KAPOOV01 05.12.2025 # Modified code in Function-RefreshPageSKU to call functions defined in HeinekenBCUpgrade & HeinekenBCCustomFunctions codeunits.
    //BC Upgrade KAPOOV01 05.12.2025 # Added code in function-SetParam to call custom function- SetParam_HNK,Created new function SetParam_HNK & called this function inside BOM Structure custom function-SetParam to check whether the BOM Structure page is opened from SKU Card or directly if BOM Structure page is opened from SKU Card then RunPageFromSKU_HNK boolean defined as Global variable in HeinekenBCUpgrade is set to True and based on this variable RunPageFromSKU_HNK true value RefreshPageSKU() function will be invoked in function-OnBeforeGenerateBOMTree else if value is false then standard function for RefreshPage will be called. 
    //BC Upgrade KAPOOV01 05.12.2025 # Made RefreshPageSKU function Global so that it can be used in HeinekenBCUpgrade codeunit.

    layout
    {
        modify(Option)
        {
            CaptionML = ENU = 'Option', FRA = 'Option';
        }
        modify(ItemFilter)
        {
            CaptionML = ENU = 'Item Filter', FRA = 'Filtre article';
            ToolTipML = ENU = 'Specifies the items that are shown in the BOM Structure window.', FRA = 'Affiche les articles qui sont affichés dans la fenêtre Structure nomenclature.';
        }
        modify(Group)
        {
            CaptionML = ENU = 'Lines', FRA = 'Lignes';

            //Unsupported feature: Change ShowAsTree on "Group(Control 2)". Please convert manually.

        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the item''s position in the BOM hierarchy. Lower-level items are indented under their parents.', FRA = 'Spécifie la position de l''article dans la hiérarchie de la nomenclature. Les articles de niveau inférieur sont indentés sous leurs parents.';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the number of the item.', FRA = 'Spécifie le numéro de l''article.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies the item''s description.', FRA = 'Spécifie la description de l''article.';
        }
        modify(HasWarning)
        {
            CaptionML = ENU = 'Warning', FRA = 'Alerte';
            ToolTipML = ENU = 'Specifies if the BOM line has setup or data issues.', FRA = 'Indique si la ligne nomenclature a des problèmes de paramètres ou de données.';

            //Unsupported feature: Change BlankZero on "HasWarning(Control 7)". Please convert manually.

        }
        modify("Low-Level Code")
        {
            ToolTipML = ENU = 'Specifies the item''s level in the BOM.', FRA = 'Indique le niveau de l''article dans la nomenclature.';
        }
        modify("Variant Code")
        {
            ToolTipML = ENU = 'Specifies the variant code that you entered in the Variant Filter field in the Item Availability by BOM Level window.', FRA = 'Spécifie le code variante que vous avez saisi dans le champ Filtre variante dans la fenêtre Disponibilité article par niveau de nomenclature.';
        }
        modify("Qty. per Parent")
        {
            ToolTipML = ENU = 'Specifies how many units of the component are required to assemble or produce one unit of the parent.', FRA = 'Spécifie le nombre d''unités du composant nécessaires pour assembler ou produire une unité de l''article parent.';
        }
        modify("Qty. per Top Item")
        {
            ToolTipML = ENU = 'Specifies how many units of the component are required to assemble or produce one unit of the top item.', FRA = 'Spécifie le nombre d''unités du composant nécessaires pour assembler ou produire une unité de l''article de niveau supérieur.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the item''s unit of measure.', FRA = 'Spécifie l''unité de mesure de l''article.';
        }
        modify("Replenishment System")
        {
            ToolTipML = ENU = 'Specifies the item''s replenishment system.', FRA = 'Spécifie le système de réapprovisionnement de l''article.';
        }
        modify("Lead-Time Offset")
        {
            ToolTipML = ENU = 'Specifies the total number of days that are required to assemble or produce the item.', FRA = 'Spécifie le nombre total de jours nécessaires à l''assemblage ou à la production de l''article.';
        }
        modify("Safety Lead Time")
        {
            ToolTipML = ENU = 'Specifies any safety lead time that is defined for the item.', FRA = 'Spécifie tout délai de sécurité défini pour l''article.';
        }
        modify("Lead Time Calculation")
        {
            ToolTipML = ENU = 'Specifies how long it takes to replenish the item, by purchase, assembly, or production.', FRA = 'Spécifie le temps nécessaire pour réapprovisionner l''article, par achat, assemblage ou production.';
        }

        //Unsupported feature: PropertyDeletion on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Option(Control 20)". Please convert manually.


        //Unsupported feature: CodeModification on "ItemFilter(Control 19).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemList.SETTABLEVIEW(Item);
        ItemList.LOOKUPMODE := true;
        if ItemList.RUNMODAL = ACTION::LookupOK then begin
          ItemList.GETRECORD(Item);
          Text := Item."No.";
          exit(true);
        end;
        exit(false);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ItemList.SETTABLEVIEW(Item);
        ItemList.LOOKUPMODE := TRUE;
        IF ItemList.RUNMODAL = ACTION::LookupOK THEN BEGIN
          ItemList.GETRECORD(Item);
          Text := Item."No.";
          EXIT(TRUE);
        END;
        EXIT(FALSE);
        */
        //end;

        //Unsupported feature: PropertyDeletion on "ItemFilter(Control 19)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ItemFilter(Control 19)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Type(Control 3)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""No."(Control 4)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 8)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Description(Control 8)". Please convert manually.



        //Unsupported feature: CodeModification on "HasWarning(Control 7).OnDrillDown". Please convert manually.

        //trigger OnDrillDown();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        if HasWarning then
          ShowWarnings;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF HasWarning THEN
          ShowWarnings;
        */
        //end;

        //Unsupported feature: PropertyDeletion on "HasWarning(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "HasWarning(Control 7)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Low-Level Code"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Low-Level Code"(Control 14)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Variant Code"(Control 6)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. per Parent"(Control 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. per Parent"(Control 21)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. per Top Item"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Qty. per Top Item"(Control 22)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Unit of Measure Code"(Control 23)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Replenishment System"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Replenishment System"(Control 24)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lead-Time Offset"(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lead-Time Offset"(Control 25)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Safety Lead Time"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Safety Lead Time"(Control 9)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lead Time Calculation"(Control 10)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Lead Time Calculation"(Control 10)". Please convert manually.

        addafter("Lead Time Calculation")
        {
            field(Indentation; Rec.Indentation)
            {
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Indentation field.';
            }
        }
    }
    actions
    {
        modify("&Item Availability by")
        {
            CaptionML = ENU = '&Item Availability by', FRA = '&Disponibilité article par';
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

            //Unsupported feature: Change AccessByPermission on "Location(Action 15)". Please convert manually.

            CaptionML = ENU = 'Location', FRA = 'Magasin';
        }
        modify("BOM Level")
        {
            CaptionML = ENU = 'BOM Level', FRA = 'Niveau nomenclature';
        }
        modify("Show Warnings")
        {
            CaptionML = ENU = 'Show Warnings', FRA = 'Afficher des avertissements';
            Promoted = true;//BC Upgrade KAPOOV01
            PromotedIsBig = true;//BC Upgrade KAPOOV01
        }

        //Unsupported feature: PropertyDeletion on "ActionContainer29(Action 29)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""&Item Availability by"(Action 28)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Event(Action 27)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Period(Action 26)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Variant(Action 18)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "Location(Action 15)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""BOM Level"(Action 13)". Please convert manually.


        //Unsupported feature: PropertyDeletion on "ActionContainer5(Action 5)". Please convert manually.


        //Unsupported feature: PropertyDeletion on ""Show Warnings"(Action 30)". Please convert manually.

    }


    //Unsupported feature: PropertyModification on "ItemFilter(Control 19).OnLookup.Item(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemFilter : Item;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemFilter : 27;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemFilter(Control 19).OnLookup.ItemList(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemFilter : "Item List";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemFilter : 31;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "OnAfterGetRecord.DummyBOMWarningLog(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //OnAfterGetRecord.DummyBOMWarningLog : "BOM Warning Log";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //OnAfterGetRecord.DummyBOMWarningLog : 5874;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "RefreshPage(PROCEDURE 2).CalcBOMTree(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //RefreshPage : "Calculate BOM Tree";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //RefreshPage : 5870;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowWarnings(PROCEDURE 10).TempBOMWarningLog(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowWarnings : "BOM Warning Log";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowWarnings : 5874;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ShowWarningsForAllLines(PROCEDURE 27).TempBOMWarningLog(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ShowWarningsForAllLines : "BOM Warning Log";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShowWarningsForAllLines : 5874;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemAvail(PROCEDURE 32).Item(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemAvail : Item;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemAvail : 27;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Item(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Item : Item;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Item : 27;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "AsmHeader(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //AsmHeader : "Assembly Header";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AsmHeader : 900;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ProdOrderLine(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ProdOrderLine : "Prod. Order Line";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ProdOrderLine : 5406;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ItemAvailFormsMgt(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ItemAvailFormsMgt : "Item Availability Forms Mgt";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemAvailFormsMgt : 353;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text000(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Could not find items with BOM levels.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Could not find items with BOM levels.;FRA=Impossible de trouver des articles avec des niveaux de nomenclature.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=There are no warnings.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=There are no warnings.;FRA=Il n'y a pas d'alerte.;
    //Variable type has not been exported.

    var
        RunPageFromSKU: Boolean;
        StockkeepingUnit: Record 5700;
        Item: Record Item;//BC Upgrade KAPOOV01

        Text000: TextConst ENU = 'Could not find items with BOM levels.', FRA = 'Impossible de trouver des articles avec des niveaux de nomenclature.';//BC Upgrade KAPOOV01


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsParentExpr := not "Is Leaf";

    HasWarning := not IsLineOk(false,DummyBOMWarningLog);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IsParentExpr := NOT "Is Leaf";

    HasWarning := NOT IsLineOk(FALSE,DummyBOMWarningLog);
    */
    //end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RefreshPage;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF RunPageFromSKU THEN//HEI.01
      RefreshPageSKU
    ELSE
      RefreshPage;
    */
    //end;


    //Unsupported feature: CodeModification on "RefreshPage(PROCEDURE 2)". Please convert manually.

    //procedure RefreshPage();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Item.SETFILTER("No.",ItemFilter);
    CalcBOMTree.SetItemFilter(Item);
    case ShowBy of
      ShowBy::Item:
        begin
          Item.FINDFIRST;
          if (not Item.HasBOM) and (Item."Routing No." = '') then
            ERROR(Text000);
          CalcBOMTree.GenerateTreeForItems(Item,Rec,0);
        end;
      ShowBy::Production:
        CalcBOMTree.GenerateTreeForProdLine(ProdOrderLine,Rec,0);
      ShowBy::Assembly:
        CalcBOMTree.GenerateTreeForAsm(AsmHeader,Rec,0);
    end;

    CurrPage.UPDATE(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Item.SETFILTER("No.",ItemFilter);
    CalcBOMTree.SetItemFilter(Item);
    CASE ShowBy OF
      ShowBy::Item:
        BEGIN
          Item.FINDFIRST;
          IF (NOT Item.HasBOM) AND (Item."Routing No." = '') THEN
            ERROR(Text000);
          CalcBOMTree.GenerateTreeForItems(Item,Rec,0);
        END;
    #11..14
    END;

    CurrPage.UPDATE(FALSE);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowWarnings(PROCEDURE 10)". Please convert manually.

    //procedure ShowWarnings();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if IsLineOk(true,TempBOMWarningLog) then
      MESSAGE(Text001)
    else
      PAGE.RUNMODAL(PAGE::"BOM Warning Log",TempBOMWarningLog);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF IsLineOk(TRUE,TempBOMWarningLog) THEN
      MESSAGE(Text001)
    ELSE
      PAGE.RUNMODAL(PAGE::"BOM Warning Log",TempBOMWarningLog);
    */
    //end;


    //Unsupported feature: CodeModification on "ShowWarningsForAllLines(PROCEDURE 27)". Please convert manually.

    //procedure ShowWarningsForAllLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if AreAllLinesOk(TempBOMWarningLog) then
      MESSAGE(Text001)
    else
      PAGE.RUNMODAL(PAGE::"BOM Warning Log",TempBOMWarningLog);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF AreAllLinesOk(TempBOMWarningLog) THEN
      MESSAGE(Text001)
    ELSE
      PAGE.RUNMODAL(PAGE::"BOM Warning Log",TempBOMWarningLog);
    */
    //end;


    //Unsupported feature: CodeModification on "ItemAvail(PROCEDURE 32)". Please convert manually.

    //procedure ItemAvail();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD(Type,Type::Item);

    Item.GET("No.");
    Item.SETFILTER("No.","No.");
    Item.SETRANGE("Date Filter",0D,"Needed by Date");
    Item.SETFILTER("Variant Filter","Variant Code");
    if ShowBy <> ShowBy::Item then
      Item.SETFILTER("Location Filter","Location Code");

    ItemAvailFormsMgt.ShowItemAvailFromItem(Item,AvailType);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    IF ShowBy <> ShowBy::Item THEN
    #8..10
    */
    //end;

    //local procedure RefreshPageSKU(); //BC Upgrade KAPOOV01
    procedure RefreshPageSKU();  //BC Upgrade KAPOOV01 Made RefreshPageSKU function Global so that it can be used in HeinekenBCUpgrade codeunit.
    var
        CalcBOMTree: Codeunit 5870;
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";  //BC Upgrade KAPOOV01
        HeinekenBCCustomFunctions: Codeunit "Heineken BC Custom Functions"; //BC Upgrade KAPOOV01
    begin
        //HEI.01>>
        Item.SETFILTER("No.", ItemFilter);
        //Item.SETFILTER("Location Code",StockkeepingUnit."Location Code");//hei.01
        CalcBOMTree.SetItemFilter(Item);
        CASE ShowBy OF
            ShowBy::Item:
                BEGIN
                    Item.FINDFIRST();
                    IF (NOT StockkeepingUnit.HasBOM()) AND (StockkeepingUnit."Routing No." = '') THEN
                        ERROR(Text000);
                    //BC Upgrade KAPOOV01 Below two functions defined in HeinekenBCUpgrade & HeinekenBCCustomFunctions codeunit >>
                    //CalcBOMTree.SetRunParam(TRUE);
                    //CalcBOMTree.GenerateTreeForItemsSKU(Item, Rec, 0, StockkeepingUnit."Location Code", StockkeepingUnit."Variant Code");

                    HeinekenBCUpgrade.SetRunParam(TRUE);
                    HeinekenBCCustomFunctions.GenerateTreeForItemsSKU(Item, Rec, 0, StockkeepingUnit."Location Code", StockkeepingUnit."Variant Code");
                    //BC Upgrade KAPOOV01 Below two functions defined in HeinekenBCUpgrade & HeinekenBCCustomFunctions codeunit ><<


                END;
        END;

        CurrPage.UPDATE(FALSE);
        //HEI.01<<
    end;


    procedure SetParam(RunFromSKU: Boolean);
    var
        HeinekenPageCU: Codeunit "Heineken Page Cu CBN";  //BC Upgrade KAPOOV01
    begin
        RunPageFromSKU := RunFromSKU;//HEI.01
        HeinekenPageCU.SetParam_HNK(RunFromSKU);  //BC Upgrade KAPOOV01
    end;

    procedure InitItemSKU(var NewItemSKU: Record "Stockkeeping Unit");
    var
        NewItem: Record 27;
    begin
        //HEI.01>>
        StockkeepingUnit.GET(NewItemSKU."Location Code", NewItemSKU."Item No.", NewItemSKU."Variant Code");
        NewItem.GET(NewItemSKU."Item No.");
        Item.COPY(NewItem);
        ItemFilter := Item."No.";
        ShowBy := ShowBy::Item;
        //HEI.01<<
    end;


    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

