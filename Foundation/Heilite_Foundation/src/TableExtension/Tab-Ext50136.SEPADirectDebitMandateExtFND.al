tableextension 50136 SEPADirectDebitMandateExtFND extends "SEPA Direct Debit Mandate"
{
    // HEI.01 CHG2132219 HB2607 IBM GAVANM01 25.01.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # new key(3rd) added: Customer No.,Customer Bank Account Code
    // HEI.02 CHG2132219 HB2607 IBM GAVANM01 25.01.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # 2rd key modified: ID added
    //   # 3rd key deleted
    // HEI.03 CHG2132219 HB2607 IBM GAVANM01 22.03.2022 #Customer Creation Integration with Mendix (SEPA)
    //   # xRec.FIND('=') added in OnModify trigger to obtain the xRec values, if any value was changed by code assignment(not by user)

    fields
    {
        modify(ID)
        {
            CaptionML = ENU = 'ID', FRA = 'ID';
        }
        modify("Customer No.")
        {
            CaptionML = ENU = 'Customer No.', FRA = 'N° client';
        }
        modify("Customer Bank Account Code")
        {

            //Unsupported feature: Change TableRelation on ""Customer Bank Account Code"(Field 3)". Please convert manually.

            CaptionML = ENU = 'Customer Bank Account Code', FRA = 'Code compte bancaire client';
        }
        modify("Valid From")
        {
            CaptionML = ENU = 'Valid From', FRA = 'Valide à partir de';
        }
        modify("Valid To")
        {
            CaptionML = ENU = 'Valid To', FRA = 'Valide jusque';
        }
        modify("Date of Signature")
        {
            CaptionML = ENU = 'Date of Signature', FRA = 'Date de signature';
        }
        modify("Type of Payment")
        {
            CaptionML = ENU = 'Type of Payment', FRA = 'Type d''encaissement';
            OptionCaptionML = ENU = 'OneOff,Recurrent', FRA = 'Unique,Récurrent';
        }
        modify(Blocked)
        {
            CaptionML = ENU = 'Blocked', FRA = 'Bloqué';
        }
        modify("Expected Number of Debits")
        {
            CaptionML = ENU = 'Expected Number of Debits', FRA = 'Nombre attendu de prélèvements';
        }
        modify("Debit Counter")
        {
            CaptionML = ENU = 'Debit Counter', FRA = 'Compteur prélèvements';
        }
        modify("No. Series")
        {
            CaptionML = ENU = 'No. Series', FRA = 'Souches de n°';
        }
        modify(Closed)
        {
            CaptionML = ENU = 'Closed', FRA = 'Clôturé';
        }

        //Unsupported feature: CodeModification on "ID(Field 1).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ID <> xRec.ID THEN BEGIN
          SalesSetup.GET;
          NoSeriesMgt.TestManual(SalesSetup."Direct Debit Mandate Nos.");
          "No. Series" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ID <> xRec.ID then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Customer No."(Field 2).OnValidate". Please convert manually.

        //trigger "(Field 2)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF (xRec."Customer No." <> '') AND ("Customer No." <> xRec."Customer No.") THEN BEGIN
          TESTFIELD("Date of Signature",0D);
          TESTFIELD("Debit Counter",0);
          "Customer Bank Account Code" := '';
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if (xRec."Customer No." <> '') and ("Customer No." <> xRec."Customer No.") then begin
        #2..4
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Type of Payment"(Field 7).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Type of Payment" = "Type of Payment"::OneOff) AND ("Debit Counter" > 1) THEN
          ERROR(MandateChangeErr);
        "Expected Number of Debits" := 1;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if ("Type of Payment" = "Type of Payment"::OneOff) and ("Debit Counter" > 1) then
          ERROR(MandateChangeErr);
        "Expected Number of Debits" := 1;
        */
        //end;


        //Unsupported feature: CodeModification on ""Expected Number of Debits"(Field 9).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Expected Number of Debits" < "Debit Counter" THEN
          ERROR(InvalidNumberOfDebitsTxt);
        IF ("Type of Payment" = "Type of Payment"::OneOff) AND ("Expected Number of Debits" > 1) THEN
          ERROR(InvalidOneOffNumOfDebitsErr);

        Closed := "Expected Number of Debits" <= "Debit Counter";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Expected Number of Debits" < "Debit Counter" then
          ERROR(InvalidNumberOfDebitsTxt);
        if ("Type of Payment" = "Type of Payment"::OneOff) and ("Expected Number of Debits" > 1) then
        #4..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Debit Counter"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Expected Number of Debits" < "Debit Counter" THEN BEGIN
          MESSAGE(InvalidNumberOfDebitsTxt);
          FIELDERROR("Debit Counter");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Expected Number of Debits" < "Debit Counter" then begin
          MESSAGE(InvalidNumberOfDebitsTxt);
          FIELDERROR("Debit Counter");
        end;
        */
        //end;
    }
    //---BC Upgrade KAMNAY01>>
    keys
    {
        key(Key50000; "Customer No.", ID)
        {
        }
    }

    trigger OnBeforeModify()
    begin
        //HEI.03>>
        IF NOT GUIALLOWED THEN
            xRec.FIND('=');
        //HEI.03<<
    end;
    //---BC Upgrade KAMNAY01<<


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF xRec.Blocked THEN
      TESTFIELD(Blocked,FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //HEI.03>>
    if not GUIALLOWED then
      xRec.FIND('=');
    //HEI.03<<
    if xRec.Blocked then
      TESTFIELD(Blocked,false);
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "DateErr(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //DateErr : ENU=The Valid To date must be after the Valid From date.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DateErr : ENU=The Valid To date must be after the Valid From date.;FRA=La Date fin validité doit être postérieure à la Date début validité.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "InvalidNumberOfDebitsTxt(Variable 1005)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //InvalidNumberOfDebitsTxt : ENU=The Debit Counter cannot be greater than the Number of Debits.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvalidNumberOfDebitsTxt : ENU=The Debit Counter cannot be greater than the Number of Debits.;FRA=Le compteur de prélèvements ne peut pas être supérieur au nombre de prélèvements.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "InvalidOneOffNumOfDebitsErr(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //InvalidOneOffNumOfDebitsErr : ENU=The Number of Debits for OneOff Sequence Type cannot be greater than one.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvalidOneOffNumOfDebitsErr : ENU=The Number of Debits for OneOff Sequence Type cannot be greater than one.;FRA=Le nombre de domiciliations pour le type d'encaissement Unique ne peut pas être supérieur à un.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "MandateChangeErr(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //MandateChangeErr : ENU=SequenceType cannot be set to OneOff, since the Mandate has already been used.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //MandateChangeErr : ENU=SequenceType cannot be set to OneOff, since the Mandate has already been used.;FRA=Le type d'encaissement ne peut pas être défini sur Unique, puisque le mandat a déjà été utilisé.;
    //Variable type has not been exported.
}

