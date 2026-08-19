tableextension 50113 BinExtFND extends Bin
{
    //     HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt

    // HEI.02 FDD-PRDGAP004 - Automatic Batch Number Generation , 10.09.2017 IBM.NAIKH01
    //   # Addde 2 new fields "Batch production resource" and "Batch sequential number"
    // HEI.03 FDD-PRDGAP057 - Field Gross capacity Bin , 24.04.2018 IBM.NAIKH01
    //   # Added new field 50002 - "Gross capacity" and modified the properties
    // HEI.04 FDD-LB IBM NASTAA02 15.10.2018 # Item Availability excluding Blocked Stock
    //   # New Field created: 50003 - Unavailable Stock
    // HEI.05 CHG2060990 IBM BULIMC01  22.06.2020#new field added: 55004 - "Ccc code"
    // HEI.06 CHG2158803/INC4109338 IBM PATHAA02 17.05.2022
    //   # Remove the Condition to allow modify data in the bin content

    fields
    {
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Code")
        {
            CaptionML = ENU = 'Code', FRA = 'Code';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }
        modify("Zone Code")
        {

            //Unsupported feature: Change TableRelation on ""Zone Code"(Field 4)". Please convert manually.

            CaptionML = ENU = 'Zone Code', FRA = 'Code zone';
        }
        modify("Adjustment Bin")
        {

            //Unsupported feature: Change CalcFormula on ""Adjustment Bin"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Adjustment Bin', FRA = 'Emplacement ajusté';
        }
        modify("Bin Type Code")
        {
            CaptionML = ENU = 'Bin Type Code', FRA = 'Code type emplacement';
        }
        modify("Warehouse Class Code")
        {
            CaptionML = ENU = 'Warehouse Class Code', FRA = 'Code classe entrepôt';
        }
        modify("Block Movement")
        {
            CaptionML = ENU = 'Block Movement', FRA = 'Bloquer mouvement';
            OptionCaptionML = ENU = ' ,Inbound,Outbound,All', FRA = ' ,Enlogement,Désenlogement,Tous';
        }
        modify("Special Equipment Code")
        {
            CaptionML = ENU = 'Special Equipment Code', FRA = 'Code équipement spécial';
        }
        modify("Bin Ranking")
        {
            CaptionML = ENU = 'Bin Ranking', FRA = 'Priorité emplacement';
        }
        modify("Maximum Cubage")
        {
            CaptionML = ENU = 'Maximum Cubage', FRA = 'Cubage maximum';
        }
        modify("Maximum Weight")
        {
            CaptionML = ENU = 'Maximum Weight', FRA = 'Poids maximum';
        }
        modify(Empty)
        {

            //Unsupported feature: Change InitValue on "Empty(Field 30)". Please convert manually.

            CaptionML = ENU = 'Empty', FRA = 'Vide';
        }
        modify("Item Filter")
        {
            CaptionML = ENU = 'Item Filter', FRA = 'Filtre article';
        }
        modify("Variant Filter")
        {

            //Unsupported feature: Change TableRelation on ""Variant Filter"(Field 33)". Please convert manually.

            CaptionML = ENU = 'Variant Filter', FRA = 'Filtre variante';
        }
        modify(Default)
        {

            //Unsupported feature: Change CalcFormula on "Default(Field 34)". Please convert manually.

            CaptionML = ENU = 'Default', FRA = 'Par défaut';
        }
        modify("Cross-Dock Bin")
        {
            CaptionML = ENU = 'Cross-Dock Bin', FRA = 'Emplacement transbordement';
        }
        modify(Dedicated)
        {
            CaptionML = ENU = 'Dedicated', FRA = 'Dédié';
        }

        //Unsupported feature: CodeModification on ""Zone Code"(Field 4).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Zone Code" <> xRec."Zone Code" THEN BEGIN
          CheckEmptyBin(Text007);
          IF Code = '' THEN
            SetUpNewLine;
          BinContent.RESET;
          BinContent.SETRANGE("Location Code","Location Code");
          BinContent.SETRANGE("Bin Code",Code);
          BinContent.MODIFYALL("Zone Code","Zone Code");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Zone Code" <> xRec."Zone Code" then begin
          CheckEmptyBin(Text007);
          if Code = '' then
        #4..8
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Type Code"(Field 10).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bin Type Code" <> xRec."Bin Type Code" THEN BEGIN
          CheckEmptyBin(Text007);
          BinContent.RESET;
          BinContent.SETRANGE("Location Code","Location Code");
          BinContent.SETRANGE("Bin Code",Code);
          BinContent.MODIFYALL("Bin Type Code","Bin Type Code");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bin Type Code" <> xRec."Bin Type Code" then begin
        #2..6
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Warehouse Class Code"(Field 11).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Warehouse Class Code" <> xRec."Warehouse Class Code" THEN BEGIN
          CheckEmptyBin(Text007);
          BinContent.RESET;
          BinContent.SETRANGE("Location Code","Location Code");
          BinContent.SETRANGE("Bin Code",Code);
          BinContent.MODIFYALL("Warehouse Class Code","Warehouse Class Code");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Warehouse Class Code" <> xRec."Warehouse Class Code" then begin
        #2..6
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Block Movement"(Field 12).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Block Movement" <> xRec."Block Movement" THEN BEGIN
          BinContent.RESET;
          BinContent.SETRANGE("Location Code","Location Code");
          BinContent.SETRANGE("Bin Code",Code);
          BinContent.MODIFYALL("Block Movement","Block Movement");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Block Movement" <> xRec."Block Movement" then begin
        #2..5
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Bin Ranking"(Field 21).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Bin Ranking" <> xRec."Bin Ranking" THEN BEGIN
          BinContent.RESET;
          BinContent.SETRANGE("Location Code","Location Code");
          BinContent.SETRANGE("Bin Code",Code);
        #5..7
          WhseActivLine.SETRANGE("Bin Code",Code);
          WhseActivLine.SETRANGE("Location Code","Location Code");
          WhseActivLine.MODIFYALL("Bin Ranking","Bin Ranking");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Bin Ranking" <> xRec."Bin Ranking" then begin
        #2..10
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Maximum Cubage"(Field 22).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckMaxQtyBinContent(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckMaxQtyBinContent(false);
        */
        //end;


        //Unsupported feature: CodeModification on ""Maximum Weight"(Field 23).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckMaxQtyBinContent(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CheckMaxQtyBinContent(true);
        */
        //end;


        //Unsupported feature: CodeModification on ""Cross-Dock Bin"(Field 40).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Cross-Dock Bin" <> xRec."Cross-Dock Bin" THEN BEGIN
          BinContent.RESET;
          BinContent.SETRANGE("Location Code","Location Code");
          BinContent.SETRANGE("Bin Code",Code);
          BinContent.MODIFYALL("Cross-Dock Bin","Cross-Dock Bin");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Cross-Dock Bin" <> xRec."Cross-Dock Bin" then begin
        #2..5
        end;
        */
        //end;


        //Unsupported feature: CodeModification on "Dedicated(Field 41).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF Dedicated <> xRec.Dedicated THEN BEGIN
          CheckEmptyBin(Text007);
          BinContent.RESET;
          BinContent.SETRANGE("Location Code","Location Code");
          BinContent.SETRANGE("Bin Code",Code);
          BinContent.MODIFYALL(Dedicated,Dedicated);
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if Dedicated <> xRec.Dedicated then begin
        #2..6
        end;
        */
        //end;
        field(50000; "Batch Production Resource FND"; Text[4])
        {
            caption ='Batch Production Resource';
            Description = 'PRDGAP004';
        }
        field(50001; "Batch Sequential Number FND"; Code[10])
        {
            caption ='Batch Sequential Number';
            Description = 'PRDGAP004';
            TableRelation = "No. Series";
        }
        field(50002; "Gross Capacity FND"; Decimal)
        {
            Caption = 'Gross Capacity';
            DecimalPlaces = 2 : 2;
            Description = 'HEI.03';
            MaxValue = "9,999,999,999,99";
            MinValue = 0;
        }
        field(50003; "Unavailable Stock FND"; Boolean)
        {
            Caption = 'Unavailable Stock';
            Description = 'HEI.04';

            trigger OnValidate();
            var
                WarehouseEntry: Record "Warehouse Entry";
            begin
                //HEI.06 >>
                /*//HEI.04>>
                WarehouseEntry.SETRANGE("Bin Code",Code);
                IF WarehouseEntry.FINDFIRST THEN
                  ERROR(WhseEntriesExistErr);
                //HEI.04<<
                */
                //HEI.06 <<

            end;
        }
        field(55004; "Ccc Code FND"; Code[20])
        {
            Caption = 'Ccc Code';
            Description = 'HEI.05';
            TableRelation = "Dimension Value".Code where("Dimension Code" = CONST('CCC'));
        }
        //---BC Upgrade KAMNAY01>>
        // field(2029613;"Customer No.";Code[20])
        // {
        //     CaptionML = ENU='Customer No.',
        //                 FRA='N° client';
        //     Description = 'FINXL8.00.001';
        //     TableRelation = Customer;
        // }
        // field(2029614;"Customer Name";Text[50])
        // {
        //     CalcFormula = Lookup(Customer.Name WHERE ("No."=FIELD("Customer No.")));
        //     CaptionML = ENU='Customer Name',
        //                 FRA='Nom client';
        //     Description = 'FINXL8.00.001';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(2029615;"Ship-to Code";Code[10])
        // {
        //     CaptionML = ENU='Ship-to Code',
        //                 FRA='Code destinataire';
        //     Description = 'FINXL8.00.001';
        //     TableRelation = "Ship-to Address".Code WHERE ("Customer No."=FIELD("Customer No."),
        //                                                   "Ship-to"=CONST(true));
        // }
        // field(2034982;"Work Order Mandatory";Boolean)
        // {
        //     CaptionML = ENU='Work Order Mandatory',
        //                 FRA='Commande d''intervention oblgatoire';
        //     Description = 'DIT-715 #457';

        //     trigger OnValidate();
        //     var
        //         lrecItemLedgerEntry : Record "Item Ledger Entry";
        //     begin
        //     end;
        // }
        // field(2035090;"Skip Auto.Create Quality Test";Boolean)
        // {
        //     CaptionML = ENU='Ignore Auto. Quality Tests Creation',
        //                 FRA='Ignorer auto. création des tests de qualité';
        //     Description = 'QXL9.00.001';
        // }
        // field(2035206;Barcode;Text[30])
        // {
        //     Caption = 'Barcode';
        //     Description = 'NRQ#27479';
        // }
        //---BC Upgrade KAMNAY01<<
    }


    //Unsupported feature: CodeModification on "OnDelete". Please convert manually.

    //trigger OnDelete();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckEmptyBin(Text008);

    Location.GET("Location Code");
    IF Location."Adjustment Bin Code" = Code THEN BEGIN
      ItemJnlLine.SETCURRENTKEY("Entry Type","Item No.","Variant Code","Location Code");
      ItemJnlLine.SETFILTER("Entry Type",'%1|%2|%3|%4',
        ItemJnlLine."Entry Type"::"Negative Adjmt.",ItemJnlLine."Entry Type"::Sale,
        ItemJnlLine."Entry Type"::"Positive Adjmt.",ItemJnlLine."Entry Type"::Purchase);
      ItemJnlLine.SETRANGE("Location Code","Location Code");
      IF ItemJnlLine.FINDFIRST THEN
        IF NOT CONFIRM(
             Text002,FALSE,STRSUBSTNO(ItemJnlLine.TABLECAPTION,TABLECAPTION))
        THEN
          ERROR(Text003);
    end;

    BinContent.RESET;
    BinContent.SETRANGE("Location Code","Location Code");
    BinContent.SETRANGE("Bin Code",Code);
    BinContent.DELETEALL;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if Location."Adjustment Bin Code" = Code then begin
    #5..9
      if ItemJnlLine.FINDFIRST then
        if not CONFIRM(
             Text002,false,STRSUBSTNO(ItemJnlLine.TABLECAPTION,TABLECAPTION))
        then
          ERROR(Text003);
    end;
    #16..20
    */
    //end;


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Location Code");
    GetLocation("Location Code");
    IF Location."Directed Put-away and Pick" THEN BEGIN
      TESTFIELD("Zone Code");
      TESTFIELD("Bin Type Code");
    end else BEGIN
      TESTFIELD("Zone Code",'');
      TESTFIELD("Bin Type Code",'');
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("Location Code");
    GetLocation("Location Code");
    if Location."Directed Put-away and Pick" then begin
      TESTFIELD("Zone Code");
      TESTFIELD("Bin Type Code");
    end else begin
      //HEI.01 PRDGAP024 begin delete
      //TESTFIELD("Zone Code",'');
      //TESTFIELD("Bin Type Code",'');
      //HEI.01 PRDGAP024 end delete
    end;
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetLocation("Location Code");
    IF Location."Directed Put-away and Pick" THEN BEGIN
      TESTFIELD("Zone Code");
      TESTFIELD("Bin Type Code");
    end else BEGIN
      TESTFIELD("Zone Code",'');
      TESTFIELD("Bin Type Code",'');
    end;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    GetLocation("Location Code");
    if Location."Directed Put-away and Pick" then begin
      TESTFIELD("Zone Code");
      TESTFIELD("Bin Type Code");
    end else begin
      //HEI.01 PRDGAP024 begin delete
      //TESTFIELD("Zone Code",'');
      //TESTFIELD("Bin Type Code",'');
      //HEI.01 PRDGAP024 end delete
    end;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1001)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU="You cannot %1 the %2 with %3 = %4, %5 = %6, because the %2 contains items.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU="You cannot %1 the %2 with %3 = %4, %5 = %6, because the %2 contains items.";FRA="Vous ne pouvez pas %1 l'enregistrement %2 de %3 = %4, %5 = %6, car %2 contient des articles.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1002)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU="You cannot %1 the %2 with %3 = %4, %5 = %6, because one or more %7 exists for this %2.";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU="You cannot %1 the %2 with %3 = %4, %5 = %6, because one or more %7 exists for this %2.";FRA="Vous ne pouvez pas %1 l'enregistrement %2 de %3 = %4, %5 = %6, car il existe un(e) ou plusieurs %7 pour ce %2.";
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text002(Variable 1003)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text002 : ENU=One or more %1 exists for this bin. Do you still want to delete this %2?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text002 : ENU=One or more %1 exists for this bin. Do you still want to delete this %2?;FRA=Il existe un ou plusieurs %1s pour cet emplacement. Souhaitez-vous quand même supprimer cet enregistrement %2 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text003(Variable 1004)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text003 : ENU=Cancelled.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text003 : ENU=Cancelled.;FRA=Annulé.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text005(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text005 : ENU=The total cubage %1 of the %2 in the bin contents exceeds the entered %3 %4.\Do you still want to enter this %3?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text005 : ENU=The total cubage %1 of the %2 in the bin contents exceeds the entered %3 %4.\Do you still want to enter this %3?;FRA=Le cubage total %1 du/de la %2 dans le contenu emplacement dépasse le/la %3 %4 entré(e).\Souhaitez-vous quand même entrer ce/cette %3 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text006(Variable 1007)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text006 : ENU=The total weight %1 of the %2 in the bin contents exceeds the entered %3 %4.\Do you still want to enter this %3?;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text006 : ENU=The total weight %1 of the %2 in the bin contents exceeds the entered %3 %4.\Do you still want to enter this %3?;FRA=Le poids total %1 du/de la %2 dans le contenu emplacement dépasse la valeur %3 %4 entrée.\Souhaitez-vous quand même entrer ce/cette %3 ?;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text007(Variable 1008)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text007 : ENU=modify;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text007 : ENU=modify;FRA=modifier;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text008(Variable 1011)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text008 : ENU=delete;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text008 : ENU=delete;FRA=supprimer;
    //Variable type has not been exported.

    var
        WhseEntriesExistErr: Label 'Warehouse Entries exist. You cannot change the Unavailable Stock Field.';
}

