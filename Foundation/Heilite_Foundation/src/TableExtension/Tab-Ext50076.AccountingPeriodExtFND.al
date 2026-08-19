tableextension 50076 AccountingPeriodExtFND extends "Accounting Period"
{
    // HEI.01 FDD-HT667 IBM SURYAS01 12-07-2019
    //   #New Field created:50000 - "Final Reporting Extracted"
    // HEI.02 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # New functions:
    //     # CheckOpenFiscalYears
    //     # CloseFiscalPeriod
    //     # ReopenFiscalPeriod
    //     # UpdateGLSetup
    //     # UpdateUserSetup
    //     # CheckSimulationEntries
    //     # CheckPostingRangeSetup
    //   # New fields:
    //     # 10800 Fiscally Closed
    //     # 10801 Fiscal Closing Date
    //     # 10802 Period Reopened Date
    //   # Code added in
    //     # OnDelete
    //     # New Fiscal Year - OnValidate
    // version NAVW19.00

    //Bc Upgrade YADAVM09 Drink it field blocked-Fiscally Closed,Fiscal Closing Date,Period Reopened Date.

    fields
    {
        modify("Starting Date")
        {
            CaptionML = ENU = 'Starting Date', FRA = 'Date début';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("New Fiscal Year")
        {
            CaptionML = ENU = 'New Fiscal Year', FRA = 'Nouvel exercice comptable';
            //BC Upgrade KAPOOV01>>

            /* //Bc Upgrade YADAVM09 Drink it code blocked>>
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                //HEI.02>>
                CompanyInfo.GET;
                IF CompanyInfo."Enable French Localization" THEN
                    IF NOT "New Fiscal Year" THEN BEGIN
                        GLSetup.CALCFIELDS("Posting Allowed To");
                        IF GLSetup."Posting Allowed To" <> 0D THEN
                            OldPostingAllowedTo := CALCDATE('<-1D>', GLSetup."Posting Allowed To");
                        MODIFY;
                        GLSetup.CALCFIELDS("Posting Allowed To");
                        AccountingPeriod2.SETRANGE("New Fiscal Year", TRUE);
                        IF AccountingPeriod2.FIND('+') THEN BEGIN
                            IF GLSetup."Posting Allowed To" <> 0D THEN
                                IF CheckPostingRangeSetup(CALCDATE('<-1D>', GLSetup."Posting Allowed To")) THEN
                                    ERROR(
                                      Text10800,
                                      AccountingPeriod2."Starting Date", OldPostingAllowedTo,
                                      GLSetup.FIELDCAPTION("Allow Posting From"), GLSetup.FIELDCAPTION("Allow Posting To"),
                                      GLSetup.TABLECAPTION, UserSetup.TABLECAPTION);
                        end;
                    end
                    //HEI.02<<
                    else BEGIN//BC Upgrade KAPOOV01 Extra added code 
                        //HEI.02>>
                        IF CompanyInfo."Enable French Localization" THEN
                            CheckOpenFiscalYears;
                        //HEI.02<<
                    end;//BC Upgrade KAPOOV01 Extra added code 

            end;
            //BC Upgrade KAPOOV01<<
             */ //Bc Upgrade YADAVM09 Drink it code blocked<<
        }
        modify(Closed)
        {
            CaptionML = ENU = 'Closed', FRA = 'Clôturé';
        }
        modify("Date Locked")
        {
            CaptionML = ENU = 'Date Locked', FRA = 'Verrouillage date';
        }
        modify("Average Cost Calc. Type")
        {
            CaptionML = ENU = 'Average Cost Calc. Type', FRA = 'Type calcul coût moyen';
            //OptionCaptionML = ENU = ' ,Item,Item & Location & Variant', FRA = ' ,Article,Article & Magasin & Variante';
        }
        modify("Average Cost Period")
        {
            CaptionML = ENU = 'Average Cost Period', FRA = 'Période coût moyen';
            // OptionCaptionML = ENU = ' ,Day,Week,Month,Quarter,Year,Accounting Period', FRA = ' ,Jour,Semaine,Mois,Trimestre,Année,Période comptable';
        }

        //Unsupported feature: CodeModification on ""New Fiscal Year"(Field 3).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Date Locked",FALSE);
        IF "New Fiscal Year" THEN BEGIN
          IF NOT InvtSetup.GET THEN
            EXIT;
          "Average Cost Calc. Type" := InvtSetup."Average Cost Calc. Type";
          "Average Cost Period" := InvtSetup."Average Cost Period";
        end else BEGIN
          "Average Cost Calc. Type" := "Average Cost Calc. Type"::" ";
          "Average Cost Period" := "Average Cost Period"::" ";
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD("Date Locked",false);
        //HEI.02>>
        CompanyInfo.GET;
        if CompanyInfo."Enable French Localization" then
          if not "New Fiscal Year" then begin
            GLSetup.CALCFIELDS("Posting Allowed To");
            if GLSetup."Posting Allowed To" <> 0D then
              OldPostingAllowedTo := CALCDATE('<-1D>',GLSetup."Posting Allowed To");
            MODIFY;
            GLSetup.CALCFIELDS("Posting Allowed To");
            AccountingPeriod2.SETRANGE("New Fiscal Year",true);
            if AccountingPeriod2.FIND('+') then begin
              if GLSetup."Posting Allowed To" <> 0D then
                if CheckPostingRangeSetup(CALCDATE('<-1D>',GLSetup."Posting Allowed To")) then
                  ERROR(
                    Text10800,
                    AccountingPeriod2."Starting Date",OldPostingAllowedTo,
                    GLSetup.FIELDCAPTION("Allow Posting From"),GLSetup.FIELDCAPTION("Allow Posting To"),
                    GLSetup.TABLECAPTION,UserSetup.TABLECAPTION);
            end;
          end;
        //HEI.02<<
        if "New Fiscal Year" then begin
          //HEI.02>>
          if CompanyInfo."Enable French Localization" then
            CheckOpenFiscalYears;
          //HEI.02<<
          if not InvtSetup.GET then
            exit;
          "Average Cost Calc. Type" := InvtSetup."Average Cost Calc. Type";
          "Average Cost Period" := InvtSetup."Average Cost Period";
        end else begin
          "Average Cost Calc. Type" := "Average Cost Calc. Type"::" ";
          "Average Cost Period" := "Average Cost Period"::" ";
        end;
        */
        //end;

        /* //Bc Upgrade YADAVM09 Drink it field commented>>
        field(10800; "Fiscally Closed"; Boolean)
        {
            CaptionML = ENU = 'Fiscally Closed',
                        FRA = 'Clôturé fiscalement';
            Description = 'HEI.02';
            Editable = false;
        }
        field(10801; "Fiscal Closing Date"; Date)
        {
            CaptionML = ENU = 'Fiscal Closing Date',
                        FRA = 'Date de clôture fiscale';
            Description = 'HEI.02';
            Editable = false;
        }
        field(10802; "Period Reopened Date"; Date)
        {
            CaptionML = ENU = 'Period Reopened Date',
                        FRA = 'Date réouverture période';
            Description = 'HEI.02';
            Editable = false;
        }
        */ //Bc Upgrade YADAVM09 Drink it field commented<<
        field(50000; "Final Reporting Extracted FND"; Boolean)
        {
            Description = 'HEI.01';
            Caption = 'Final Reporting Extracted';
        }
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Date Locked",FALSE);
    UpdateAvgItems(3);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("Date Locked",false);
    //HEI.02>>
    CompanyInfo.GET;
    if CompanyInfo."Enable French Localization" then
      begin
        "New Fiscal Year" := false;
        VALIDATE("New Fiscal Year");
      end;
    //HEI.02<<
    UpdateAvgItems(3);
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    AccountingPeriod2 := Rec;
    IF AccountingPeriod2.FIND('>') THEN
      AccountingPeriod2.TESTFIELD("Date Locked",FALSE);
    UpdateAvgItems(1);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    AccountingPeriod2 := Rec;
    if AccountingPeriod2.FIND('>') then
      AccountingPeriod2.TESTFIELD("Date Locked",false);
    UpdateAvgItems(1);
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Date Locked",FALSE);
    AccountingPeriod2 := Rec;
    IF AccountingPeriod2.FIND('>') THEN
      AccountingPeriod2.TESTFIELD("Date Locked",FALSE);
    UpdateAvgItems(4);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("Date Locked",false);
    AccountingPeriod2 := Rec;
    if AccountingPeriod2.FIND('>') then
      AccountingPeriod2.TESTFIELD("Date Locked",false);
    UpdateAvgItems(4);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=<Month Text>;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=<Month Text>;FRA=<Month Text>;
    //Variable type has not been exported.
    //BC Upgrade Kapoov01>>
    procedure CheckOpenFiscalYears()
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;
        /* //Bc Upgrade YADAVM09 Drink it field Dependency Blocked>>
                AccountingPeriod2.RESET;
                AccountingPeriod2.SETRANGE("New Fiscal Year", TRUE);
                AccountingPeriod2.SETRANGE("Fiscally Closed", FALSE);
                NoOfOpenFiscalYears := AccountingPeriod2.COUNT;
                IF AccountingPeriod2.FINDFIRST THEN;

                // check last period of previous fiscal year
                AccountingPeriod2.SETRANGE("New Fiscal Year");
                AccountingPeriod2.SETRANGE("Fiscally Closed");
                IF AccountingPeriod2.FIND('<') THEN
                    IF NOT AccountingPeriod2."Fiscally Closed" THEN
                        NoOfOpenFiscalYears := NoOfOpenFiscalYears + 1;
                IF NoOfOpenFiscalYears > 2 THEN
                    ERROR(Text10801);
                //HEI.02<<
                */ //Bc Upgrade YADAVM09 Drink it field Dependency Blocked<<
    end;

    procedure CloseFiscalPeriod()
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;
        /* //Bc Upgrade YADAVM09 Drink it field dependency commented>>
               AccountingPeriod2.RESET;
               AccountingPeriod2.SETRANGE("Fiscally Closed", FALSE);
               IF AccountingPeriod2.FINDFIRST THEN BEGIN
                   StartingDate := AccountingPeriod2."Starting Date";
                   IF NOT AccountingPeriod2.FIND('>') THEN
                       ERROR(Text10809);
        
                          // check last period in fiscal year
        IF AccountingPeriod2."New Fiscal Year" THEN
            ERROR(Text10804);
        EndingDate := CALCDATE('<-1D>', AccountingPeriod2."Starting Date");
        AccountingPeriod2.FIND('<');
        CheckSimulationEntries(StartingDate, EndingDate);
        IF CONFIRM(Text10802, TRUE, AccountingPeriod2."Starting Date") THEN BEGIN
            AccountingPeriod2."Fiscally Closed" := TRUE;
            AccountingPeriod2."Fiscal Closing Date" := TODAY;
            AccountingPeriod2.MODIFY;
            // update allowed posting range
        
            UpdateGLSetup(EndingDate);
            UpdateUserSetup(EndingDate);
        end;
    end else
            MESSAGE(Text10803);
        //HEI.02<<
        */ //Bc Upgrade YADAVM09 Drink it field dependency commented<<
    end;

    procedure ReopenFiscalPeriod()
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;
        /* //Bc Upgrade YADAVM09 Drink it field dependency commented>>
                AccountingPeriod2.RESET;
                AccountingPeriod2.SETRANGE("Fiscally Closed", FALSE);
                IF AccountingPeriod2.FINDFIRST THEN
                    IF AccountingPeriod2."New Fiscal Year" THEN
                        ERROR(Text10805);
                AccountingPeriod2.SETRANGE("Fiscally Closed", TRUE);
                IF AccountingPeriod2.FINDLAST THEN BEGIN
                    IF NOT CONFIRM(Text10806, FALSE, AccountingPeriod2."Starting Date") THEN
                        EXIT;
                    AccountingPeriod2."Fiscally Closed" := FALSE;
                    AccountingPeriod2."Period Reopened Date" := TODAY;
                    AccountingPeriod2.MODIFY;
                end else
                    MESSAGE(Text10807);
                //HEI.02<<
                */ //Bc Upgrade YADAVM09 Drink it field dependency commented<<

    end;

    procedure UpdateGLSetup(PeriodEndDate: Date)
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;
        /* //Bc Upgrade YADAVM09 Drink it field dependency commented>>
                WITH GLSetup DO BEGIN
                    GET;
                    CALCFIELDS("Posting Allowed From");
                    IF "Allow Posting From" <= PeriodEndDate THEN BEGIN
                        "Allow Posting From" := "Posting Allowed From";
                        MODIFY;
                    end;
                    IF ("Allow Posting To" <= PeriodEndDate) AND ("Allow Posting To" <> 0D) THEN BEGIN
                        "Allow Posting To" := CALCDATE('<+1M-1D>', "Posting Allowed From");
                        MODIFY;
                    end;
                end;
                //HEI.02<<
                */ //Bc Upgrade YADAVM09 Drink it field dependency commented<<
    end;

    procedure UpdateUserSetup(PeriodEndDate: Date)
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;
        /* //Bc Upgrade YADAVM09 Drink it field dependency commented>>
                WITH UserSetup DO BEGIN
                    IF FINDFIRST THEN
                        REPEAT
                            IF "Allow Posting From" <= PeriodEndDate THEN BEGIN
                                "Allow Posting From" := GLSetup."Posting Allowed From";
                                MODIFY;
                            end;
                            IF ("Allow Posting To" <= PeriodEndDate) AND ("Allow Posting To" <> 0D) THEN BEGIN
                                "Allow Posting To" := CALCDATE('<+1M-1D>', GLSetup."Posting Allowed From");
                                MODIFY;
                            end;
                        UNTIL NEXT = 0;

                end
                //HEI.02<<
                 */ //Bc Upgrade YADAVM09 Drink it field dependency commented>>

    end;

    procedure CheckSimulationEntries(PeriodStartDate: Date; PeriodEndDate: Date)
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;

        GLEntry.SETFILTER("Posting Date", '%1..%2', PeriodStartDate, PeriodEndDate);
        GLEntry.SETFILTER("Entry No.", '<%1', 0);
        IF GLEntry.FIND('-') THEN
            ERROR(
              Text10808,
              PeriodStartDate, PeriodEndDate,
              GLEntry.TABLECAPTION, GLEntry.FIELDCAPTION("Entry No."), GLEntry."Entry No.");
        //HEI.02<<
    end;

    procedure CheckPostingRangeSetup(FYEndDate: Date): Boolean
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CompanyInfo.GET();
        IF NOT CompanyInfo."Enable French Localization FND" THEN
            EXIT;

        GLSetup.GET();
        IF (GLSetup."Allow Posting From" > FYEndDate) OR (GLSetup."Allow Posting To" > FYEndDate) THEN
            EXIT(TRUE);

        IF UserSetup.FINDFIRST() THEN
            REPEAT
                IF (UserSetup."Allow Posting From" > FYEndDate) OR (UserSetup."Allow Posting To" > FYEndDate) THEN
                    EXIT(TRUE);
            UNTIL UserSetup.NEXT() = 0;

        EXIT(FALSE);
        //HEI.02<<
    end;

    trigger OnBeforeDelete()
    var
        myInt: Integer;
    begin
        //HEI.02>>
        CompanyInfo.GET();
        IF CompanyInfo."Enable French Localization FND" THEN BEGIN
            "New Fiscal Year" := FALSE;
            VALIDATE("New Fiscal Year");
        end;
        //HEI.02<<
        //UpdateAvgItems(3);  BC Upgrade Kapoov01 NEED TO CHECK THIS FUNCTION AS IN STANDARD NO Parameter('3') IS BEING PASSED also this function is not called in standard and its Heiniken cutomized code still documentation is missing here.
    end;
    //BC Upgrade Kapoov01<<

    var
        AccountingPeriod2: Record "Accounting Period";
        CompanyInfo: Record "Company Information";
        GLEntry: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        EndingDate: Date;
        OldPostingAllowedTo: Date;
        StartingDate: Date;
        NoOfOpenFiscalYears: Integer;
        Text10800: TextConst ENU = 'To delete the fiscal year from %1 to %2, you must first modify the fields %3 and %4 in the %5 and %6 so that they are outside the fiscal year that is being deleted.', FRA = 'Pour supprimer l''exercice comptable du %1 au %2, vous devez d''abord modifier les champs %3 et %4 dans %5 et %6 de sorte à ce qu''ils se situent en dehors de l''exercice comptable en cours de suppression.';
        Text10801: TextConst ENU = 'It is not allowed to have more than two open fiscal years. Please fiscally close the oldest open fiscal year first.', FRA = 'Vous ne pouvez pas avoir plus de deux exercices comptables ouverts. Veuillez d''abord clôturer fiscalement l''exercice ouvert le plus ancien.';
        Text10802: TextConst ENU = 'You will not be able to post transactions in a closed period. Are you sure you want to close the period with starting date %1?', FRA = 'Vous ne pourrez pas valider de transactions dans une période clôturée. ­tes-vous sûr de vouloir clôturer la période ayant comme date de début %1 ?';
        Text10803: TextConst ENU = 'There are no open fiscal periods that can be closed.', FRA = 'Il n''y a pas de période fiscale ouverte à clôturer.';
        Text10804: TextConst ENU = 'You cannot close the last period of a fiscal year. In order to close the last period of a fiscal year, you must fiscally close the fiscal year.', FRA = 'Vous ne pouvez pas clôturer la dernière période d''un exercice comptable. Pour clôturer la dernière période d''un exercice comptable, vous devez clôturer fiscalement ce dernier.';
        Text10805: TextConst ENU = 'The period you are trying to reopen belongs to a fiscal year that has been fiscally closed.\Once a fiscal year is fiscally closed, you cannot reopen any of the periods in that fiscal year.', FRA = 'La période que vous tentez de rouvrir appartient à un exercice comptable qui a été clôturé fiscalement.\Lorsque vous avez clôturé fiscalement un exercice comptable, vous ne pouvez plus rouvrir ses périodes.';
        Text10806: TextConst ENU = 'A closed fiscal period should normally not be reopened. Are you sure you want to reopen the fiscal period with starting date %1?', FRA = 'Une période fiscale clôturée ne doit normalement plus être rouverte. ­tes-vous sûr de vouloir rouvrir la période fiscale ayant comme date de début %1 ?';
        Text10807: TextConst ENU = 'There are no closed fiscal periods that can be reopened.', FRA = 'Il n''y a pas de période fiscale clôturée à rouvrir.';
        Text10808: TextConst ENU = 'To fiscally close the period from %1 to %2, you must first transfer or delete all existing simulation entries in this fiscal period.', FRA = 'Pour clôturer fiscalement la période allant du %1 au %2, vous devez d''abord transférer ou supprimer toutes les écritures de simulation existant dans cette période fiscale.';
        Text10809: TextConst ENU = 'You must create a new fiscal year before you can close this fiscal period.', FRA = 'Vous devez créer un exercice comptable avant de clôturer cette période fiscale.';
}

