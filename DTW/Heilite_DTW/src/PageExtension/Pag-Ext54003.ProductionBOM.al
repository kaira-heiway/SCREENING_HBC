pageextension 54003 ProductionBOMExt extends "Production BOM"
{
    // version NAVW110.0,HEI.04

    //     HEI.01 FDD-GAPID043 IBM LAZARE02 01.09.2017 # New fields: Linked SKU

    // HEI.02 FDD-CHG2136735 IBM.PATHAA02 07.02.2022
    // # Code on Linked SKU-Onlookup
    // # Prefiltered list of Locations based on Users linked to Responsibility Center Employees (Type:Production) else show the locations linked to SKU

    // HEI.03 CHG2236885 IBM PRASAA03 10.04.2024 Add error message to production BOM to avoid redundance
    //   # New validation added to field: Linked SKU

    // HEI.04 CHG2236885 IBM PRASAA03 22.04.2024 Add error message to production BOM to avoid redundance
    //   # error message TextL001 is replaced with TextL002

    layout
    {
        modify(General)
        {
            CaptionML = ENU = 'General', FRA = 'Général';
        }
        modify("No.")
        {
            ToolTipML = ENU = 'Specifies the BOM number.', FRA = 'Spécifie le numéro de nomenclature.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description for the production BOM.', FRA = 'Indique une description de la nomenclature de production.';
        }
        modify("Unit of Measure Code")
        {
            ToolTipML = ENU = 'Specifies the unit of measure code to which the BOM refers.', FRA = 'Indique le code unité auquel la nomenclature fait référence.';
        }
        modify(Status)
        {
            ToolTipML = ENU = 'Specifies the status of the production BOM.', FRA = 'Spécifie le statut de la nomenclature de production.';
        }
        modify("Search Name")
        {
            ToolTipML = ENU = 'Specifies a search name.', FRA = 'Spécifie un nom de recherche.';
        }
        modify("Version Nos.")
        {
            ToolTipML = ENU = 'Specifies the version number series that the production BOM versions refer to.', FRA = 'Indique les souches de numéros de version auxquelles les versions de nomenclature font référence.';
        }
        modify(ActiveVersionCode)
        {
            CaptionML = ENU = 'Active Version', FRA = 'Version courante';
            ToolTipML = ENU = 'Specifies which version of the production BOM is valid.', FRA = 'Indique la version nomenclature valide.';
        }
        modify("Last Date Modified")
        {
            ToolTipML = ENU = 'Specifies the last date that was modified.', FRA = 'Indique la dernière date modifiée.';
        }
        addafter("Last Date Modified")
        {
            field("Linked SKU"; Rec."Linked SKU FND")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    /*//Bc Upgrade YADAVM09 Drink it table>>
                    //HEI.02>>
                    CLEAR(LocationFilter);
                    CLEAR(NewString);
                    RespCenterEmplLocationsRec.RESET;
                    RespCenterEmplLocationsRec.SETRANGE("User ID",USERID);
                    RespCenterEmplLocationsRec.SETFILTER(Type,'%1',RespCenterEmplLocationsRec.Type::Production);
                    if RespCenterEmplLocationsRec.FINDSET then begin
                      repeat
                      LocationFilter := LocationFilter+'|'+RespCenterEmplLocationsRec."Location Code";
                      until RespCenterEmplLocationsRec.NEXT =0;
                    end;
                    *///Bc Upgrade YADAVM09 Drink it table<<

                    if LocationFilter <> '' then begin
                        NewString := DELCHR(LocationFilter, '<', '|');
                        StockkeepingUnitRec.RESET();
                        StockkeepingUnitRec.FILTERGROUP(50);
                        StockkeepingUnitRec.SETRANGE("Item No.", Rec."Linked Item No. FND");
                        StockkeepingUnitRec.SETFILTER("Location Code", NewString);
                        if PAGE.RUNMODAL(0, StockkeepingUnitRec) = ACTION::LookupOK then
                            Text := StockkeepingUnitRec."Location Code";
                        StockkeepingUnitRec.FILTERGROUP(0);
                        exit(true);
                    end else begin
                        StockkeepingUnitRec.RESET();
                        StockkeepingUnitRec.FILTERGROUP(51);
                        StockkeepingUnitRec.SETRANGE("Item No.", Rec."Linked Item No. FND");
                        if PAGE.RUNMODAL(0, StockkeepingUnitRec) = ACTION::LookupOK then
                            Text := StockkeepingUnitRec."Location Code";
                        StockkeepingUnitRec.FILTERGROUP(0);
                        exit(true);
                    end;
                    //HEI.02<<
                end;

                trigger OnValidate();
                begin
                    CheckBOMLines();//HEI.03
                end;
            }
        }
    }
    actions
    {
        modify("&Prod. BOM")
        {
            CaptionML = ENU = '&Prod. BOM', FRA = '&Nomenclature';
        }
        modify("Co&mments")
        {
            CaptionML = ENU = 'Co&mments', FRA = 'Co&mmentaires';
        }
        modify(Versions)
        {
            CaptionML = ENU = 'Versions', FRA = 'Versions';
        }
        // modify("Ma&trix per Version")
        // {
        //     CaptionML = ENU = 'Ma&trix per Version', FRA = 'Ma&trice de versions';
        // }
        modify("Where-used")
        {
            CaptionML = ENU = 'Where-used', FRA = 'Cas d''emploi';
        }
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify("Copy &BOM")
        {
            CaptionML = ENU = 'Copy &BOM', FRA = '&Copier nomenclature';
        }
    }

    var
        StockkeepingUnitRec: Record "Stockkeeping Unit";
        //RespCenterEmplLocationsRec : Record "Resp. Center Empl. Locations";//Bc Upgrade YADAVM09 Drink it table
        LocationFilter: Text;
        NewString: Text;

    local procedure CheckBOMLines();
    var
        ProductionBOMLine: Record "Production BOM Line";
        TextL001: Label 'Same item is selected in Prod BOM for which Prod BOM is created';
        TextL002: Label 'Warning !!!!! Same item %1 is selected in line no  %2 for which Prod BOM is created';
    begin
        //HEI.03>>
        if Rec."Linked SKU FND" <> '' then begin
            ProductionBOMLine.RESET();
            ProductionBOMLine.SETCURRENTKEY("Production BOM No.", "Version Code", Type, "No.");
            ProductionBOMLine.SETRANGE("Production BOM No.", Rec."No.");
            ProductionBOMLine.SETRANGE("Version Code", '');
            ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
            ProductionBOMLine.SETRANGE("No.", Rec."Linked Item No. FND");
            if ProductionBOMLine.FINDFIRST() then
                MESSAGE(TextL002, ProductionBOMLine."No.", ProductionBOMLine."Line No.");//HEI.04
            //MESSAGE(TextL001);//HEI.04
        end;
        //HEI.03<<
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

