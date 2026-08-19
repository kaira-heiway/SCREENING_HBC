tableextension 50024 GenProductPostingGroupExtFND extends "Gen. Product Posting Group"
{
    // version NAVW19.00,DITW110.00.09
    // DITW15.00.00.38 DDR 03/02/2011 issue 941
    //                                  Added fields
    //                                    2013824 Def. Prod. Posting Free Group

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW110.00.09 AKH 31/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9
    // HEI.01 CHG2109621 HT2170 IBM GAVANM01 10.06.2021 - Posting Setup for Sales Tax (Timbre), transport, free products
    //   # Added field: 50000 - Include Timbre
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
        modify("Def. VAT Prod. Posting Group")
        {
            CaptionML = ENU = 'Def. VAT Prod. Posting Group', FRA = 'Gpe compta. produit TVA défaut';
        }
        modify("Auto Insert Default")
        {

            //Unsupported feature: Change InitValue on ""Auto Insert Default"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Auto Insert Default', FRA = 'Insérer gpe compta produit TVA';
        }

        //Unsupported feature: CodeModification on ""Def. VAT Prod. Posting Group"(Field 3).OnValidate". Please convert manually.

        //trigger  VAT Prod();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF CurrFieldNo = 0 THEN
          EXIT;

        IF "Def. VAT Prod. Posting Group" <> xRec."Def. VAT Prod. Posting Group" THEN BEGIN
          GLAcc.SETCURRENTKEY("Gen. Prod. Posting Group");
          GLAcc.SETRANGE("Gen. Prod. Posting Group",Code);
          GLAcc.SETRANGE("VAT Prod. Posting Group",xRec."Def. VAT Prod. Posting Group");
          IF GLAcc.FIND('-') THEN
            IF CONFIRM(
                 Text000,FALSE,
                 GLAcc.FIELDCAPTION("VAT Prod. Posting Group"),GLAcc.TABLECAPTION,
                 GLAcc.FIELDCAPTION("Gen. Prod. Posting Group"),Code,
                 xRec."Def. VAT Prod. Posting Group")
            THEN
              REPEAT
                GLAcc2 := GLAcc;
                GLAcc2."VAT Prod. Posting Group" := "Def. VAT Prod. Posting Group";
                GLAcc2.MODIFY;
              UNTIL GLAcc.NEXT = 0;

          Item.SETCURRENTKEY("Gen. Prod. Posting Group");
          Item.SETRANGE("Gen. Prod. Posting Group",Code);
          Item.SETRANGE("VAT Prod. Posting Group",xRec."Def. VAT Prod. Posting Group");
          IF Item.FIND('-') THEN
            IF CONFIRM(
                 Text000,FALSE,
                 Item.FIELDCAPTION("VAT Prod. Posting Group"),Item.TABLECAPTION,
                 Item.FIELDCAPTION("Gen. Prod. Posting Group"),Code,
                 xRec."Def. VAT Prod. Posting Group")
            THEN
              REPEAT
                Item2 := Item;
                Item2."VAT Prod. Posting Group" := "Def. VAT Prod. Posting Group";
                Item2.MODIFY;
              UNTIL Item.NEXT = 0;

          Res.SETCURRENTKEY("Gen. Prod. Posting Group");
          Res.SETRANGE("Gen. Prod. Posting Group",Code);
          Res.SETRANGE("VAT Prod. Posting Group",xRec."Def. VAT Prod. Posting Group");
          IF Res.FIND('-') THEN
            IF CONFIRM(
                 Text000,FALSE,
                 Res.FIELDCAPTION("VAT Prod. Posting Group"),Res.TABLECAPTION,
                 Res.FIELDCAPTION("Gen. Prod. Posting Group"),Code,
                 xRec."Def. VAT Prod. Posting Group")
            THEN
              REPEAT
                Res2 := Res;
                Res2."VAT Prod. Posting Group" := "Def. VAT Prod. Posting Group";
                Res2.MODIFY;
              UNTIL Res.NEXT = 0;

          ItemCharge.SETCURRENTKEY("Gen. Prod. Posting Group");
          ItemCharge.SETRANGE("Gen. Prod. Posting Group",Code);
          ItemCharge.SETRANGE("VAT Prod. Posting Group",xRec."Def. VAT Prod. Posting Group");
          IF ItemCharge.FIND('-') THEN
            IF CONFIRM(
                 Text000,FALSE,
                 ItemCharge.FIELDCAPTION("VAT Prod. Posting Group"),ItemCharge.TABLECAPTION,
                 ItemCharge.FIELDCAPTION("Gen. Prod. Posting Group"),Code,
                 xRec."Def. VAT Prod. Posting Group")
            THEN
              REPEAT
                ItemCharge2 := ItemCharge;
                ItemCharge2."VAT Prod. Posting Group" := "Def. VAT Prod. Posting Group";
                ItemCharge2.MODIFY;
              UNTIL ItemCharge.NEXT = 0;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if CurrFieldNo = 0 then
          exit;

        if "Def. VAT Prod. Posting Group" <> xRec."Def. VAT Prod. Posting Group" then begin
        #5..7
          if GLAcc.FIND('-') then
            if CONFIRM(
                 Text000,false,
        #11..13
            then
              repeat
        #16..18
              until GLAcc.NEXT = 0;
        #20..23
          if Item.FIND('-') then
            if CONFIRM(
                 Text000,false,
        #27..29
            then
              repeat
        #32..34
              until Item.NEXT = 0;
        #36..39
          if Res.FIND('-') then
            if CONFIRM(
                 Text000,false,
        #43..45
            then
              repeat
        #48..50
              until Res.NEXT = 0;
        #52..55
          if ItemCharge.FIND('-') then
            if CONFIRM(
                 Text000,false,
        #59..61
            then
              repeat
        #64..66
              until ItemCharge.NEXT = 0;
        end;
        */
        //end;
        field(50000; "Include Timbre FND"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'HEI.01';
            Caption = 'Include Timbre';
        }
        // field(2013824; "Def. Prod. Posting Free Group"; Code[10])
        // {
        //     CaptionML = ENU = 'Def. Prod. Posting Group Free Item',
        //                 FRA = 'Groupe article gratuit compta. produit défaut';
        //     Description = 'DITW15.00.00.38 #941';
        //     TableRelation = "Gen. Product Posting Group";
        // }  // BC Upgrade NANDIS03
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=Change all occurrences of %1 in %2\where %3 is %4\and %1 is %5.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=Change all occurrences of %1 in %2\where %3 is %4\and %1 is %5.;FRA=Modifiez toutes les occurences de %1 dans %2\où %3 est %4\et %1 est %5.;
    //Variable type has not been exported.
}

