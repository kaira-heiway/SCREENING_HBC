tableextension 50022 GenBusinessPostingGroupExtFND extends "Gen. Business Posting Group"
{
    // version NAVW19.00
    // HEI.01 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added fileds to "Market Type" table
    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Def. VAT Bus. Posting Group")
        {
            CaptionML = ENU = 'Def. VAT Bus. Posting Group', FRA = 'Gpe compta. marché TVA défaut';
        }
        modify("Auto Insert Default")
        {

            //Unsupported feature: Change InitValue on ""Auto Insert Default"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Auto Insert Default', FRA = 'Insérer gpe compta marché TVA';
        }

        //Unsupported feature: CodeModification on ""Def. VAT Bus. Posting Group"(Field 3).OnValidate". Please convert manually.

        //trigger  VAT Bus();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Def. VAT Bus. Posting Group" <> xRec."Def. VAT Bus. Posting Group" THEN BEGIN
          GLAcc.SETCURRENTKEY("Gen. Bus. Posting Group");
          GLAcc.SETRANGE("Gen. Bus. Posting Group",Code);
          GLAcc.SETRANGE("VAT Bus. Posting Group",xRec."Def. VAT Bus. Posting Group");
          IF GLAcc.FIND('-') THEN
            REPEAT
              GLAcc2 := GLAcc;
              GLAcc2."VAT Bus. Posting Group" := "Def. VAT Bus. Posting Group";
              GLAcc2.MODIFY;
            UNTIL GLAcc.NEXT = 0;

          Cust.SETCURRENTKEY("Gen. Bus. Posting Group");
          Cust.SETRANGE("Gen. Bus. Posting Group",Code);
          Cust.SETRANGE("VAT Bus. Posting Group",xRec."Def. VAT Bus. Posting Group");
          IF Cust.FIND('-') THEN
            REPEAT
              Cust2 := Cust;
              Cust2."VAT Bus. Posting Group" := "Def. VAT Bus. Posting Group";
              Cust2.MODIFY;
            UNTIL Cust.NEXT = 0;

          Vend.SETCURRENTKEY("Gen. Bus. Posting Group");
          Vend.SETRANGE("Gen. Bus. Posting Group",Code);
          Vend.SETRANGE("VAT Bus. Posting Group",xRec."Def. VAT Bus. Posting Group");
          IF Vend.FIND('-') THEN
            REPEAT
              Vend2 := Vend;
              Vend2."VAT Bus. Posting Group" := "Def. VAT Bus. Posting Group";
              Vend2.MODIFY;
            UNTIL Vend.NEXT = 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Def. VAT Bus. Posting Group" <> xRec."Def. VAT Bus. Posting Group" then begin
        #2..4
          if GLAcc.FIND('-') then
            repeat
        #7..9
            until GLAcc.NEXT = 0;
        #11..14
          if Cust.FIND('-') then
            repeat
        #17..19
            until Cust.NEXT = 0;
        #21..24
          if Vend.FIND('-') then
            repeat
        #27..29
            until Vend.NEXT = 0;
        end;
        */
        //end;
        field(50000; "Market Type FND"; Code[10])
        {
            Caption = 'Market Type';
            Description = 'HEI.01';

        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

