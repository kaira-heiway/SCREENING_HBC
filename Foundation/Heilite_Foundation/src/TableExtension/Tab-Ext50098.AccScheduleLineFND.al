tableextension 50098 AccScheduleLineExtFND extends "Acc. Schedule Line"
{
    // HEI.01 CHG2200302 IBM POENAB02 31.05.2023 P&L by Nature in Heilite Base
    //   # New field added - 50000 Financial St. Ver. to Exclude
    //   # New field added - 50001 CIL account
    // HEI.02 CHG2215009 IBM POENAB02 05.10.2023 HB3349 Enhancement of HB3349 To add column for L3 in main view
    //   # New field added - 50002 L3 Account
    //   # New function ReplaceString
    // version NAVW110.0,HEI.02

    fields
    {
        modify("Schedule Name")
        {
            CaptionML = ENU = 'Schedule Name', FRA = 'Nom du tableau';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify("Row No.")
        {
            CaptionML = ENU = 'Row No.', FRA = 'N° ligne totalisation';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify(Totaling)
        {

            //Unsupported feature: Change TableRelation on "Totaling(Field 5)". Please convert manually.

            CaptionML = ENU = 'Totaling', FRA = 'Totalisation';
        }
        modify("Totaling Type")
        {
            CaptionML = ENU = 'Totaling Type', FRA = 'Type totalisation';
           // OptionCaptionML = ENU = 'Posting Accounts,Total Accounts,Formula,,,Set Base For Percent,Cost Type,Cost Type Total,Cash Flow Entry Accounts,Cash Flow Total Accounts', FRA = 'Comptes imputables,Comptes de totalisation,Formule,,,Base de pourcentage,Type de coût,Total type de coût,Comptes d''écritures de trésorerie,Comptes de totalisation de trésorerie';
        }
        modify("New Page")
        {
            CaptionML = ENU = 'New Page', FRA = 'Nouvelle page';
        }
        modify(Indentation)
        {
            CaptionML = ENU = 'Indentation', FRA = 'Indentation';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify("Dimension 1 Filter")
        {
            CaptionML = ENU = 'Dimension 1 Filter', FRA = 'Filtre axe 1';
        }
        modify("Dimension 2 Filter")
        {
            CaptionML = ENU = 'Dimension 2 Filter', FRA = 'Filtre axe 2';
        }
        modify("G/L Budget Filter")
        {
            CaptionML = ENU = 'G/L Budget Filter', FRA = 'Filtre budget comptable';
        }
        modify("Business Unit Filter")
        {
            CaptionML = ENU = 'Business Unit Filter', FRA = 'Filtre centre de profit';
        }
        modify(Show)
        {
            CaptionML = ENU = 'Show', FRA = 'Afficher';
           // OptionCaptionML = ENU = 'Yes,No,If Any Column Not Zero,When Positive Balance,When Negative Balance', FRA = 'Oui,Non,Si différent de 0,Si solde positif,Si solde négatif';
        }
        modify("Dimension 3 Filter")
        {
            CaptionML = ENU = 'Dimension 3 Filter', FRA = 'Filtre axe 3';
        }
        modify("Dimension 4 Filter")
        {
            CaptionML = ENU = 'Dimension 4 Filter', FRA = 'Filtre axe 4';
        }
        modify("Dimension 1 Totaling")
        {
            CaptionML = ENU = 'Dimension 1 Totaling', FRA = 'Totalisation axe 1';
        }
        modify("Dimension 2 Totaling")
        {
            CaptionML = ENU = 'Dimension 2 Totaling', FRA = 'Totalisation axe 2';
        }
        modify("Dimension 3 Totaling")
        {
            CaptionML = ENU = 'Dimension 3 Totaling', FRA = 'Totalisation axe 3';
        }
        modify("Dimension 4 Totaling")
        {
            CaptionML = ENU = 'Dimension 4 Totaling', FRA = 'Totalisation axe 4';
        }
        modify(Bold)
        {
            CaptionML = ENU = 'Bold', FRA = 'Gras';
        }
        modify(Italic)
        {
            CaptionML = ENU = 'Italic', FRA = 'Italique';
        }
        modify(Underline)
        {
            CaptionML = ENU = 'Underline', FRA = 'Souligné';
        }
        modify("Show Opposite Sign")
        {
            CaptionML = ENU = 'Show Opposite Sign', FRA = 'Afficher signe opposé';
        }
        modify("Row Type")
        {
            CaptionML = ENU = 'Row Type', FRA = 'Type ligne';
            OptionCaptionML = ENU = 'Net Change,Balance at Date,Beginning Balance', FRA = 'Solde période,Solde au,Solde d''ouverture';
        }
        modify("Amount Type")
        {
            CaptionML = ENU = 'Amount Type', FRA = 'Type montant';
           // OptionCaptionML = ENU = 'Net Amount,Debit Amount,Credit Amount', FRA = 'Net (montant),Débit (montant),Crédit (montant)';
        }
        modify("Double Underline")
        {
            CaptionML = ENU = 'Double Underline', FRA = 'Souligné double';
        }
        modify("Cash Flow Forecast Filter")
        {
            CaptionML = ENU = 'Cash Flow Forecast Filter', FRA = 'Filtre prévision de trésorerie';
        }
        modify("Cost Center Filter")
        {
            CaptionML = ENU = 'Cost Center Filter', FRA = 'Filtre centre de coûts';
        }
        modify("Cost Object Filter")
        {
            CaptionML = ENU = 'Cost Object Filter', FRA = 'Filtre objet de coûts';
        }
        modify("Cost Center Totaling")
        {
            CaptionML = ENU = 'Cost Center Totaling', FRA = 'Totalisation centre de coûts';
        }
        modify("Cost Object Totaling")
        {
            CaptionML = ENU = 'Cost Object Totaling', FRA = 'Totalisation objet de coûts';
        }
        modify("Cost Budget Filter")
        {
            CaptionML = ENU = 'Cost Budget Filter', FRA = 'Filtre de budget des coûts';
        }

        //Unsupported feature: CodeModification on "Totaling(Field 5).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CASE "Totaling Type" OF
          "Totaling Type"::"Posting Accounts","Totaling Type"::"Total Accounts":
            BEGIN
              GLAcc.SETFILTER("No.",Totaling);
              GLAcc.CALCFIELDS(Balance);
            end;
          "Totaling Type"::Formula,"Totaling Type"::"Set Base For Percent":
            BEGIN
              Totaling := UPPERCASE(Totaling);
              CheckFormula(Totaling);
            end;
          "Totaling Type"::"Cost Type","Totaling Type"::"Cost Type Total":
            BEGIN
              CostType.SETFILTER("No.",Totaling);
              CostType.CALCFIELDS(Balance);
            end;
          "Totaling Type"::"Cash Flow Entry Accounts","Totaling Type"::"Cash Flow Total Accounts":
            BEGIN
              CFAccount.SETFILTER("No.",Totaling);
              CFAccount.CALCFIELDS(Amount);
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        case "Totaling Type" of
          "Totaling Type"::"Posting Accounts","Totaling Type"::"Total Accounts":
            begin
              GLAcc.SETFILTER("No.",Totaling);
              GLAcc.CALCFIELDS(Balance);
            end;
          "Totaling Type"::Formula,"Totaling Type"::"Set Base For Percent":
            begin
              Totaling := UPPERCASE(Totaling);
              CheckFormula(Totaling);
            end;
          "Totaling Type"::"Cost Type","Totaling Type"::"Cost Type Total":
            begin
              CostType.SETFILTER("No.",Totaling);
              CostType.CALCFIELDS(Balance);
            end;
          "Totaling Type"::"Cash Flow Entry Accounts","Totaling Type"::"Cash Flow Total Accounts":
            begin
              CFAccount.SETFILTER("No.",Totaling);
              CFAccount.CALCFIELDS(Amount);
            end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on "Underline(Field 25).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Double Underline" AND Underline THEN BEGIN
          "Double Underline" := FALSE;
          MESSAGE(ForceUnderLineMsg,FIELDCAPTION("Double Underline"));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Double Underline" and Underline then begin
          "Double Underline" := false;
          MESSAGE(ForceUnderLineMsg,FIELDCAPTION("Double Underline"));
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Double Underline"(Field 30).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Double Underline" AND Underline THEN BEGIN
          Underline := FALSE;
          MESSAGE(ForceUnderLineMsg,FIELDCAPTION(Underline));
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Double Underline" and Underline then begin
          Underline := false;
          MESSAGE(ForceUnderLineMsg,FIELDCAPTION(Underline));
        end;
        */
        //end;
        field(50000; "Finan. St. Ver. to Exclude FND"; Text[30])
        {
            Caption = 'Financial St. Ver. to Exclude';
            Description = 'HEI.01';
            FieldClass = FlowFilter;
        }
        field(50001; "CIL account FND"; Code[10])
        {
            Caption = 'CIL account';
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
        }
        field(50002; "L3 Account FND"; Text[5])
        {
            Caption = 'L3 Account';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';

            trigger OnValidate();
            var
                L3AccountNo: Integer;
                L3AccountText: Text;
            begin
                //HEI.02>>
                if "L3 Account FND" <> '' then begin
                    L3AccountText := "L3 Account FND";
                    if STRPOS(L3AccountText, '.') <> 0 then
                        if not EVALUATE(L3AccountNo, ConvertStr(L3AccountText, '.', '')) then
                            ERROR(Text50000);
                    if STRPOS(L3AccountText, '.') = 0 then
                        if not EVALUATE(L3AccountNo, "L3 Account FND") then
                            ERROR(Text50000);
                    if STRPOS(L3AccountText, ',') <> 0 then
                        ERROR(Text50000);
                end;
                //HEI.02<<
            end;
        }
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF xRec."Line No." = 0 THEN
      IF NOT AccSchedName.GET("Schedule Name") THEN BEGIN
        AccSchedName.INIT;
        AccSchedName.Name := "Schedule Name";
        IF AccSchedName.Name = '' THEN
          AccSchedName.Description := Text000;
        AccSchedName.INSERT;
      end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if xRec."Line No." = 0 then
      if not AccSchedName.GET("Schedule Name") then begin
        AccSchedName.INIT;
        AccSchedName.Name := "Schedule Name";
        if AccSchedName.Name = '' then
          AccSchedName.Description := Text000;
        AccSchedName.INSERT;
      end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "ForceUnderLineMsg(Variable 1022)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ForceUnderLineMsg : @@@="%1= Field underline ";ENU=%1 will be set to false.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ForceUnderLineMsg : @@@="%1= Field underline ";ENU=%1 will be set to false.;FRA=%1 sera paramétré sur False.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Default Schedule;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Default Schedule;FRA=Tableau d'analyse par défaut;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=The parenthesis at position %1 is misplaced.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=The parenthesis at position %1 is misplaced.;FRA=Position %1. La parenthèse est mal placée.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=You cannot have two consecutive operators. The error occurred at position %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=You cannot have two consecutive operators. The error occurred at position %1.;FRA=Position %1. Vous ne pouvez pas avoir deux opérateurs consécutifs.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=There is an operand missing after position %1.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=There is an operand missing after position %1.;FRA=Il manque un opérateur après la position %1.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text004(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text004 : ENU=There are more left parentheses than right parentheses.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text004 : ENU=There are more left parentheses than right parentheses.;FRA=Il y a plus de parenthèses ouvrantes que de parenthèses fermantes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=There are more right parentheses than left parentheses.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=There are more right parentheses than left parentheses.;FRA=Il y a plus de parenthèses fermantes que de parenthèses ouvrantes.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=1,6,,Dimension 1 Filter;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=1,6,,Dimension 1 Filter;FRA=1,6,,Filtre axe 1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=1,6,,Dimension 2 Filter;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=1,6,,Dimension 2 Filter;FRA=1,6,,Filtre axe 2;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=1,6,,Dimension 3 Filter;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=1,6,,Dimension 3 Filter;FRA=1,6,,Filtre axe 3;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text009(Variable 1009)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text009 : ENU=1,6,,Dimension 4 Filter;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text009 : ENU=1,6,,Dimension 4 Filter;FRA=1,6,,Filtre axe 4;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text010(Variable 1010)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text010 : ENU=,, Totaling;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text010 : ENU=,, Totaling;FRA=,, Totalisation;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text011(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text011 : ENU=1,5,,Dimension 1 Totaling;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text011 : ENU=1,5,,Dimension 1 Totaling;FRA=1,5,,Totalisation axe 1;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text012(Variable 1012)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text012 : ENU=1,5,,Dimension 2 Totaling;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text012 : ENU=1,5,,Dimension 2 Totaling;FRA=1,5,,Totalisation axe 2;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text013(Variable 1013)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text013 : ENU=1,5,,Dimension 3 Totaling;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text013 : ENU=1,5,,Dimension 3 Totaling;FRA=1,5,,Totalisation axe 3;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text014(Variable 1014)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text014 : ENU=1,5,,Dimension 4 Totaling;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text014 : ENU=1,5,,Dimension 4 Totaling;FRA=1,5,,Totalisation axe 4;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text015(Variable 1020)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text015 : ENU=The %1 refers to %2 %3, which does not exist. The field %4 on table %5 has now been deleted.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text015 : ENU=The %1 refers to %2 %3, which does not exist. The field %4 on table %5 has now been deleted.;FRA=Le %1 se réfère à la %2 %3, qui n'existe pas. Le champ %4 de la table %5 a maintenant été supprimé.;
    //Variable type has not been exported.

    procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text): Text
    var
        NewString: Text;
    begin
        //BC Upgrade KAPVOO01>>
        //HEI.02>>
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;

        EXIT(NewString);
        //HEI.02<<
        //BC Upgrade KAPVOO01<<
    end;

    var
        GLSetupRead: Boolean;
        Text50000: Label 'Only digits and dot character can be added in this field!';
}

