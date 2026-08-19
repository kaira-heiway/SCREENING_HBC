tableextension 50001 CostTypeExtFND extends "Cost Type"
{
    // version NAVW110.0.00.16177,HEI.02
    // HEI.01 DefectID #1359 IBM HORTOC01 12.01.2018
    //   New field "Cost Allocation Key FND"
    // HEI.02 DefectID #1323 IBM POSTOI01 17.01.2018
    //   Modify Fields "Dimension Filter 1 Value Code" and "Dimension Filter 2 Value Code" (properties and OnLookup trigger)
    //   Add new function LookupDimValueFilter
    // HEI.03 DefectID IBM HORTOC01 01.02.2018
    //   #increese lenght of field 40 - "G/L Account Range" from 50 to 250 chr
    // HEI.04 FDD-BPMGAP BRD HB398 IBM NASTAA02 16.05.2019 # Actual Product Costing
    //   # New Field created: 50005 - COGS Variable Item Cat Code
    // HEI.05 CHG2068359 BULIMC01 IBM 07.10.2020 #new boolean field added: 50006- "Source Shipping Cost"

    // BC Upgrade MISHRS14 >>
    // Blocked property 'OptionCaptionML' due to warning in field - modify(type).
    // BC Upgrade MISHRS14 <<

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Search Name")
        {
            CaptionML = ENU = 'Search Name', FRA = 'Nom de recherche';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';

            // BC Upgrade MISHRS14 >>
            // Blocked below property 'OptionCaptionML' because it can only be set on elements of type Option and this will become error in future.
            //OptionCaptionML = ENU = 'Cost Type,Heading,Total,Begin-Total,End-Total', FRA = 'Type coût,En-tête,Total,Début total,Fin total';
            // BC Upgrade MISHRS14 <<

        }
        modify("Cost Center Code")
        {
            CaptionML = ENU = 'Cost Center Code', FRA = 'Code centre de coûts';
        }
        modify("Cost Object Code")
        {
            CaptionML = ENU = 'Cost Object Code', FRA = 'Code objet de coûts';
        }
        modify("Combine Entries")
        {
            CaptionML = ENU = 'Combine Entries', FRA = 'Combiner écritures';
            OptionCaptionML = ENU = 'None,Day,Month', FRA = 'Aucun,Jour,Mois';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("New Page")
        {
            CaptionML = ENU = 'New Page', FRA = 'Nouvelle page';
        }
        modify("Blank Line")
        {
            CaptionML = ENU = 'Blank Line', FRA = 'Ligne blanche';

            //Unsupported feature: Change MinValue on ""Blank Line"(Field 18)". Please convert manually.

        }
        modify(Indentation)
        {
            CaptionML = ENU = 'Indentation', FRA = 'Indentation';
        }
        modify(Comment)
        {
            CaptionML = ENU = 'Comment', FRA = 'Commentaire';
        }
        modify("Cost Classification")
        {
            CaptionML = ENU = 'Cost Classification', FRA = 'Classification des coûts';
            OptionCaptionML = ENU = ' ,Fixed,Variable,Step Variable', FRA = ' ,Fixe,Variable,Variable par paliers';
        }
        modify("Fixed Share")
        {
            CaptionML = ENU = 'Fixed Share', FRA = 'Participation fixe';
        }
        modify("Modified Date")
        {
            CaptionML = ENU = 'Modified Date', FRA = 'Date modifiée';
        }
        modify("Modified By")
        {
            CaptionML = ENU = 'Modified By', FRA = 'Modifié par';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Cost Center Filter")
        {
            CaptionML = ENU = 'Cost Center Filter', FRA = 'Filtre centre de coûts';
        }
        modify("Cost Object Filter")
        {
            CaptionML = ENU = 'Cost Object Filter', FRA = 'Filtre objet de coûts';
        }
        modify("Balance at Date")
        {

            //Unsupported feature: Change CalcFormula on ""Balance at Date"(Field 31)". Please convert manually.

            CaptionML = ENU = 'Balance at Date', FRA = 'Solde au';
        }
        modify("Net Change")
        {

            //Unsupported feature: Change CalcFormula on ""Net Change"(Field 32)". Please convert manually.

            CaptionML = ENU = 'Net Change', FRA = 'Solde période';
        }
        modify("Budget Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Budget Amount"(Field 33)". Please convert manually.

            CaptionML = ENU = 'Budget Amount', FRA = 'Montant budget';
        }
        modify(Totaling)
        {
            CaptionML = ENU = 'Totaling', FRA = 'Totalisation';
        }
        modify("Budget Filter")
        {
            CaptionML = ENU = 'Budget Filter', FRA = 'Filtre budget';
        }
        modify(Balance)
        {

            //Unsupported feature: Change CalcFormula on "Balance(Field 36)". Please convert manually.

            CaptionML = ENU = 'Balance', FRA = 'Solde';
        }
        modify("Budget at Date")
        {
            CaptionML = ENU = 'Budget at Date', FRA = 'Budget période';
        }
        modify("G/L Account Range")
        {

            //Unsupported feature: Change Data type on ""G/L Account Range"(Field 40)". Please convert manually.

            CaptionML = ENU = 'G/L Account Range', FRA = 'Plage compte général';

            //Unsupported feature: Change Description on ""G/L Account Range"(Field 40)". Please convert manually.

        }
        modify("Debit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Debit Amount"(Field 47)". Please convert manually.

            CaptionML = ENU = 'Debit Amount', FRA = 'Montant débit';
        }
        modify("Credit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Credit Amount"(Field 48)". Please convert manually.

            CaptionML = ENU = 'Credit Amount', FRA = 'Montant crédit';
        }
        modify("Balance to Allocate")
        {

            //Unsupported feature: Change CalcFormula on ""Balance to Allocate"(Field 51)". Please convert manually.

            CaptionML = ENU = 'Balance to Allocate', FRA = 'Solde à affecter';
        }
        modify("Budget Debit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Budget Debit Amount"(Field 60)". Please convert manually.

            CaptionML = ENU = 'Budget Debit Amount', FRA = 'Montant débit budget';
        }
        modify("Budget Credit Amount")
        {

            //Unsupported feature: Change CalcFormula on ""Budget Credit Amount"(Field 72)". Please convert manually.

            CaptionML = ENU = 'Budget Credit Amount', FRA = 'Montant crédit budget';
        }
        modify("Add. Currency Net Change")
        {

            //Unsupported feature: Change CalcFormula on ""Add. Currency Net Change"(Field 73)". Please convert manually.

            CaptionML = ENU = 'Add. Currency Net Change', FRA = 'Solde période DR';
        }
        modify("Add. Currency Balance at Date")
        {

            //Unsupported feature: Change CalcFormula on ""Add. Currency Balance at Date"(Field 74)". Please convert manually.

            CaptionML = ENU = 'Add. Currency Balance at Date', FRA = 'Solde au DR';
        }

        //Unsupported feature: CodeModification on "Type(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        // Blocked if <> account
        IF Type <> xRec.Type THEN
          Blocked := Type <> Type::"Cost Type";

        // CHange only if no entries or budget
        IF Blocked AND NOT xRec.Blocked THEN BEGIN
          CostEntry.SETRANGE("Cost Type No.","No.");
          IF NOT CostEntry.ISEMPTY THEN
            ERROR(Text001,"No.",CostEntry.TABLECAPTION);
          CostBudgetEntry.SETRANGE("Cost Type No.","No.");
          IF NOT CostBudgetEntry.ISEMPTY THEN
            ERROR(Text001,"No.",CostBudgetEntry.TABLECAPTION);
        end;

        Totaling := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        // Blocked if <> account
        if Type <> xRec.Type then
        #3..5
        if Blocked and not xRec.Blocked then begin
          CostEntry.SETRANGE("Cost Type No.","No.");
          if not CostEntry.ISEMPTY then
            ERROR(Text001,"No.",CostEntry.TABLECAPTION);
          CostBudgetEntry.SETRANGE("Cost Type No.","No.");
          if not CostBudgetEntry.ISEMPTY then
            ERROR(Text001,"No.",CostBudgetEntry.TABLECAPTION);
        end;

        Totaling := '';
        */
        //end;


        //Unsupported feature: CodeModification on "Totaling(Field 34).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF LookupCostTypeFilter(SelectionFilter) THEN
          VALIDATE(Totaling,COPYSTR(SelectionFilter,1,MAXSTRLEN(Totaling)));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if LookupCostTypeFilter(SelectionFilter) then
          VALIDATE(Totaling,COPYSTR(SelectionFilter,1,MAXSTRLEN(Totaling)));
        */
        //end;


        //Unsupported feature: CodeModification on "Totaling(Field 34).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT (Type IN [Type::Total,Type::"End-Total"]) THEN
          FIELDERROR(Type);

        CALCFIELDS("Net Change");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if not (Type in [Type::Total,Type::"End-Total"]) then
        #2..4
        */
        //end;


        //Unsupported feature: CodeModification on ""G/L Account Range"(Field 40).OnLookup". Please convert manually.

        //trigger OnLookup();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF LookupGLAccFilter(SelectionFilter) THEN
          VALIDATE("G/L Account Range",COPYSTR(SelectionFilter,1,MAXSTRLEN("G/L Account Range")));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if LookupGLAccFilter(SelectionFilter) then
          VALIDATE("G/L Account Range",COPYSTR(SelectionFilter,1,MAXSTRLEN("G/L Account Range")));
        */
        //end;
        field(50000; "Dimension Filter 1 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension Filter 1 Code';

            trigger OnValidate();
            begin
                "Dim Filter 1 Value Code FND" := '';
            end;
        }
        field(50001; "Dim Filter 1 Value Code FND"; Text[20])
        {
            Caption = 'Code';
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Filter 1 Code FND"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            var
                SelectionFilter: Text[1024];
            begin
                //>>HEI.02
                if LookupDimValueFilter(SelectionFilter, "Dimension Filter 1 Code FND") then
                    VALIDATE("Dim Filter 1 Value Code FND", COPYSTR(SelectionFilter, 1, MAXSTRLEN("Dim Filter 1 Value Code FND")));
                //<<HEI.02
            end;
        }
        field(50002; "Dimension Filter 2 Code FND"; Code[20])
        {
            TableRelation = Dimension;
            Caption = 'Dimension Filter 2 Code';

            trigger OnValidate();
            begin
                "Dim Filter 2 Value Code FND" := '';
            end;
        }
        field(50003; "Dim Filter 2 Value Code FND"; Text[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = FIELD("Dimension Filter 2 Code FND"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            Caption = 'Dimension Filter 2 Value Code';

            trigger OnLookup();
            var
                SelectionFilter: Text[1024];
            begin
                //>>HEI.02
                if LookupDimValueFilter(SelectionFilter, "Dimension Filter 2 Code FND") then
                    VALIDATE("Dim Filter 2 Value Code FND", COPYSTR(SelectionFilter, 1, MAXSTRLEN("Dim Filter 2 Value Code FND")));
                //<<HEI.02
            end;
        }
        field(50004; "Cost Allocation Key FND"; Option)
        {
            Caption = 'Cost Allocation Key';
            Description = 'HEI.01';
            OptionCaption = '" ,KMs,Quantity(HL)"';
            OptionMembers = " ",KMs,"Quantity(HL)";
        }
        field(50005; "COGS Var Item Cat Code FND"; Text[100])
        {
            Caption = 'COGS Variable Item Category Code';
            Description = 'HEI.03';
            TableRelation = "Item Category";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50006; "Source Shipping Cost FND"; Boolean)
        {
            Caption = 'Source Shipping Cost from Value Entries';
            Description = 'HEI.05';
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    // Message if balance  <> 0
    IF Type = Type::"Cost Type" THEN BEGIN
      CALCFIELDS(Balance);
      TESTFIELD(Balance,0);
    end;

    // Error if movement in not closed fiscal year
    CostEntry.SETRANGE("Cost Type No.","No.");
    AccPeriod.SETRANGE(Closed,FALSE);
    IF AccPeriod.FINDFIRST THEN
      CostEntry.SETFILTER("Posting Date",'>=%1',AccPeriod."Starting Date");
    IF NOT CostEntry.ISEMPTY THEN
      ERROR(Text000);

    // Renumber to entries to no. 0
    #16..23

    GLAccount.SETRANGE("Cost Type No.","No.");
    GLAccount.MODIFYALL("Cost Type No.",'');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // Message if balance  <> 0
    if Type = Type::"Cost Type" then begin
      CALCFIELDS(Balance);
      TESTFIELD(Balance,0);
    end;
    #6..8
    AccPeriod.SETRANGE(Closed,false);
    if AccPeriod.FINDFIRST then
      CostEntry.SETFILTER("Posting Date",'>=%1',AccPeriod."Starting Date");
    if not CostEntry.ISEMPTY then
    #13..26
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=You cannot delete a cost type with entries in an open fiscal year.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=You cannot delete a cost type with entries in an open fiscal year.;FRA=Vous ne pouvez pas supprimer un type de coûts disposant d'écritures dans un exercice comptable ouvert.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot change cost type %1. There are %2 associated with it.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot change cost type %1. There are %2 associated with it.;FRA=Vous ne pouvez pas modifier le type de coûts %1. Des %2 y sont associés.;
    //Variable type has not been exported.
    local procedure LookupDimValueFilter(VAR Text: Text; DimFilterCode: Code[20]): Boolean
    var
        DimValue: Record "Dimension Value";
        DimValueList: Page "Dimension Value List";
        myInt: Integer;
    begin
        //HEI.02
        DimValueList.LOOKUPMODE(TRUE);
        DimValue.SETRANGE(DimValue."Dimension Code", DimFilterCode);
        DimValueList.SETTABLEVIEW(DimValue);
        IF DimValueList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            Text := DimValueList.GetSelectionFilter();
            EXIT(TRUE);
        end;
        EXIT(FALSE)
    end;
}

