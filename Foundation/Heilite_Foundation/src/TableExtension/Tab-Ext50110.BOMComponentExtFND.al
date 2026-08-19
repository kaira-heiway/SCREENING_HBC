tableextension 50110 BOMComponenrExtFND extends "BOM Component"
{
    // version NAVW17.10,FINXL8.00.001,DITW110.00.09,HEI.01
    // DITW15.00.00.24 DDR 06/10/2008 Avoid field "No." empty when Type <> blank

    // FINXL7.00.001 RBE 20/03/2013: Item description extend from 30 -> 80 chars
    // FINXL8.00.001 BSA 02/06/2015 #178: Added field "Cross Reference No."

    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    // DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    // DITW110.00.09 AKH 30/03/2017 NRQ#24104 Merge XL 2017 W1 CU4 to DIT 2017 W1 R9

    // HEI.01 FDD-GAPID031 IBM.PATHAA02 17.08.2017
    //   # Description made non-Editable
    // BC Upgrade NANDIS03 - Ediatble of Description to be moved to Page level
    fields
    {
        modify("Parent Item No.")
        {
            CaptionML = ENU = 'Parent Item No.', FRA = 'N° nomenclature';
        }
        modify("Line No.")
        {
            CaptionML = ENU = 'Line No.', FRA = 'N° ligne';
        }
        modify(Type)
        {
            CaptionML = ENU = 'Type', FRA = 'Type';
           // OptionCaptionML = ENU = ' ,Item,Resource', FRA = ' ,Article,Ressource';
        }
        modify("No.")
        {

            //Unsupported feature: Change TableRelation on ""No."(Field 4)". Please convert manually.

            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Assembly BOM")
        {

            //Unsupported feature: Change CalcFormula on ""Assembly BOM"(Field 5)". Please convert manually.

            CaptionML = ENU = 'Assembly BOM', FRA = 'Nomenclature d''assemblage';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';

            //Unsupported feature: Change Description on "Description(Field 6)". Please convert manually.


            //Unsupported feature: Change Editable on "Description(Field 6)". Please convert manually.

        }
        modify("Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Code"(Field 7)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Quantity per")
        {
            CaptionML = ENU = 'Quantity per', FRA = 'Quantité par';
        }
        modify(Position)
        {
            CaptionML = ENU = 'Position', FRA = 'Position';
        }
        modify("Position 2")
        {
            CaptionML = ENU = 'Position 2', FRA = 'Position 2';
        }
        modify("Position 3")
        {
            CaptionML = ENU = 'Position 3', FRA = 'Position 3';
        }
        modify("Machine No.")
        {
            CaptionML = ENU = 'Machine No.', FRA = 'N° machine';
        }
        modify("Lead-Time Offset")
        {
            CaptionML = ENU = 'Lead-Time Offset', FRA = 'Décalage du délai';
        }
        modify("BOM Description")
        {

            //Unsupported feature: Change CalcFormula on ""BOM Description"(Field 14)". Please convert manually.

            CaptionML = ENU = 'BOM Description', FRA = 'Désignation nomenclature';
        }
        modify("Resource Usage Type")
        {
            CaptionML = ENU = 'Resource Usage Type', FRA = 'Type d''utilisation des ressources';
            OptionCaptionML = ENU = 'Direct,Fixed', FRA = 'Direct,Fixe';
        }
        modify("Variant Code")
        {

            //Unsupported feature: Change TableRelation on ""Variant Code"(Field 5402)". Please convert manually.

            CaptionML = ENU = 'Variant Code', FRA = 'Code variante';
        }
        modify("Installed in Line No.")
        {
            CaptionML = ENU = 'Installed in Line No.', FRA = 'Installé en ligne n°';
        }
        modify("Installed in Item No.")
        {
            CaptionML = ENU = 'Installed in Item No.', FRA = 'Installé sur article n°';
        }

        //Unsupported feature: CodeModification on ""No."(Field 4).OnValidate". Please convert manually.

        //trigger "(Field 4)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type);
        "Variant Code" := '';
        IF "No." = '' THEN
          EXIT;

        CASE Type OF
          Type::Item:
            BEGIN
              Item.GET("No.");
              ValidateAgainstRecursion("No.");
              Item.CALCFIELDS("Assembly BOM");
              "Assembly BOM" := Item."Assembly BOM";
              Description := Item.Description;
              "Unit of Measure Code" := Item."Base Unit of Measure";
              ParentItem.GET("Parent Item No.");
              CalcLowLevelCode.SetRecursiveLevelsOnItem(Item,ParentItem."Low-Level Code" + 1,TRUE);
              Item.FIND;
              ParentItem.FIND;
              IF ParentItem."Low-Level Code" >= Item."Low-Level Code" THEN
                ERROR(Text001,"No.");
            end;
          Type::Resource:
            BEGIN
              Res.GET("No.");
              "Assembly BOM" := FALSE;
              Description := Res.Name;
              "Unit of Measure Code" := Res."Base Unit of Measure";
            end;
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Type);
        "Variant Code" := '';
        // <<DITW15.00.00.24 DDR 03/10/2008
        if Type <> Type::" " then
          TESTFIELD("No.");
        // >>DITW15.00.00.24 DDR

        if "No." = '' then
          exit;

        case Type of
          Type::Item:
            begin
        #9..15
              CalcLowLevelCode.SetRecursiveLevelsOnItem(Item,ParentItem."Low-Level Code" + 1,true);
              Item.FIND;
              ParentItem.FIND;
              if ParentItem."Low-Level Code" >= Item."Low-Level Code" then
                ERROR(Text001,"No.");
              //<<FINXL8.00.001 BSA 02/06/201b5 #178
              if recFinXLSetup.READPERMISSION then
                fctGetCrossReference;
              //>>FINXL8.00.001 BSA 02/06/2015 #178
            end;
          Type::Resource:
            begin
              Res.GET("No.");
              "Assembly BOM" := false;
              Description := Res.Name;
              "Unit of Measure Code" := Res."Base Unit of Measure";
            end;
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Resource Usage Type"(Field 20).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Resource Usage Type" = xRec."Resource Usage Type" THEN
          EXIT;

        TESTFIELD(Type,Type::Resource);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Resource Usage Type" = xRec."Resource Usage Type" then
          exit;

        TESTFIELD(Type,Type::Resource);
        */
        //end;


        //Unsupported feature: CodeModification on ""Variant Code"(Field 5402).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Variant Code" = '' THEN
          EXIT;
        TESTFIELD(Type,Type::Item);
        TESTFIELD("No.");
        ItemVariant.GET("No.","Variant Code");
        Description := ItemVariant.Description;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Variant Code" = '' then
          exit;
        #3..6
        */
        //end;


        //Unsupported feature: CodeModification on ""Installed in Line No."(Field 5900).OnLookup". Please convert manually.

        //trigger "(Field 5900)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        BOMComp.RESET;
        BOMComp.SETRANGE("Parent Item No.","Parent Item No.");
        BOMComp.SETRANGE(Type,BOMComp.Type::Item);
        BOMComp.SETFILTER("Line No.",'<>%1',"Line No.");
        CLEAR(AssemblyBOM);
        AssemblyBOM.SETTABLEVIEW(BOMComp);
        AssemblyBOM.EDITABLE(FALSE);
        AssemblyBOM.LOOKUPMODE(TRUE);
        IF AssemblyBOM.RUNMODAL = ACTION::LookupOK THEN BEGIN
          AssemblyBOM.GETRECORD(BOMComp);
          VALIDATE("Installed in Line No.",BOMComp."Line No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        AssemblyBOM.EDITABLE(false);
        AssemblyBOM.LOOKUPMODE(true);
        if AssemblyBOM.RUNMODAL = ACTION::LookupOK then begin
          AssemblyBOM.GETRECORD(BOMComp);
          VALIDATE("Installed in Line No.",BOMComp."Line No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Installed in Line No."(Field 5900).OnValidate". Please convert manually.

        //trigger "(Field 5900)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Installed in Line No." <> 0 THEN BEGIN
          IF "Installed in Line No." = "Line No." THEN
            ERROR(Text000,FIELDCAPTION("Installed in Line No."));
          BOMComp.RESET;
          BOMComp.SETRANGE("Parent Item No.","Parent Item No.");
          BOMComp.SETRANGE(Type,BOMComp.Type::Item);
          BOMComp.SETRANGE("Line No.","Installed in Line No.");
          BOMComp.FINDFIRST;
          BOMComp.TESTFIELD("Quantity per",1);
          "Installed in Item No." := BOMComp."No.";
        end else
          "Installed in Item No." := '';
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Installed in Line No." <> 0 then begin
          if "Installed in Line No." = "Line No." then
        #3..10
        end else
          "Installed in Item No." := '';
        */
        //end;


        //Unsupported feature: CodeModification on ""Installed in Item No."(Field 5901).OnLookup". Please convert manually.

        //trigger "(Field 5901)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        BOMComp.RESET;
        BOMComp.SETRANGE("Parent Item No.","Parent Item No.");
        BOMComp.SETRANGE(Type,BOMComp.Type::Item);
        BOMComp."No." := "Installed in Item No.";
        BOMComp.SETFILTER("Line No.",'<>%1',"Line No.");
        CLEAR(AssemblyBOM);
        AssemblyBOM.SETTABLEVIEW(BOMComp);
        AssemblyBOM.EDITABLE(FALSE);
        AssemblyBOM.LOOKUPMODE(TRUE);
        IF AssemblyBOM.RUNMODAL = ACTION::LookupOK THEN BEGIN
          AssemblyBOM.GETRECORD(BOMComp);
          VALIDATE("Installed in Line No.",BOMComp."Line No.");
        end;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
        AssemblyBOM.EDITABLE(false);
        AssemblyBOM.LOOKUPMODE(true);
        if AssemblyBOM.RUNMODAL = ACTION::LookupOK then begin
          AssemblyBOM.GETRECORD(BOMComp);
          VALIDATE("Installed in Line No.",BOMComp."Line No.");
        end;
        */
        //end;


        //Unsupported feature: CodeModification on ""Installed in Item No."(Field 5901).OnValidate". Please convert manually.

        //trigger "(Field 5901)();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Installed in Item No." <> '' THEN BEGIN
          BOMComp.RESET;
          BOMComp.SETRANGE("Parent Item No.","Parent Item No.");
          BOMComp.SETRANGE(Type,BOMComp.Type::Item);
          BOMComp.SETRANGE("No.","Installed in Item No.");
          BOMComp.FINDFIRST;
        end;

        VALIDATE("Installed in Line No.",BOMComp."Line No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Installed in Item No." <> '' then begin
        #2..6
        end;

        VALIDATE("Installed in Line No.",BOMComp."Line No.");
        */
        //end;
        // field(2029610; "Cross-Reference No."; Code[20])
        // {
        //     CaptionML = ENU = 'Cross-Reference No.',
        //                 FRA = 'Référence externe';
        //     Description = 'FINXL8.00.001';

        //     trigger OnLookup();
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then
        //             fctLookupCrossReference();
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;

        //     trigger OnValidate();
        //     begin
        //         //<<FINXL8.00.001 BSA 02/06/2015 #178
        //         if recFinXLSetup.READPERMISSION then
        //             fctValidateCrossReference;
        //         //>>FINXL8.00.001 BSA 02/06/2015 #178
        //     end;
        // }  // BC Upgrade NANDIS03 
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Item.GET("Parent Item No.");
    IF Type = Type::Item THEN
      ValidateAgainstRecursion("No.")
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Item.GET("Parent Item No.");
    // <<DITW15.00.00.24 DDR 03/10/2008
    if Type <> Type::" " then
      TESTFIELD("No.");
    // >>DITW15.00.00.24 DDR
    if Type = Type::Item then
      ValidateAgainstRecursion("No.")
    */
    //end;


    //Unsupported feature: CodeModification on "OnModify". Please convert manually.

    //trigger OnModify();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Item.GET("Parent Item No.");
    IF Type = Type::Item THEN
      ValidateAgainstRecursion("No.")
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Item.GET("Parent Item No.");
    // <<DITW15.00.00.24 DDR 03/10/2008
    if Type <> Type::" " then
      TESTFIELD("No.");
    // >>DITW15.00.00.24 DDR
    if Type = Type::Item then
      ValidateAgainstRecursion("No.")
    */
    //end;


    //Unsupported feature: CodeModification on "OnRename". Please convert manually.

    //trigger OnRename();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    Item.GET("Parent Item No.");
    IF Type = Type::Item THEN
      ValidateAgainstRecursion("No.")
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Item.GET("Parent Item No.");
    if Type = Type::Item then
      ValidateAgainstRecursion("No.")
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.



    //Unsupported feature: PropertyModification on "Text000(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text000 : ENU=%1 cannot be component of itself.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text000 : ENU=%1 cannot be component of itself.;FRA=%1 ne peut être composant de lui-même.;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "Text001(Variable 1006)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //Text001 : ENU=You cannot insert item %1 as an assembly component of itself.;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //Text001 : ENU=You cannot insert item %1 as an assembly component of itself.;FRA=Vous ne pouvez pas insérer l'article %1 en tant que composant d'assemblage.;
    //Variable type has not been exported.

    var
        blnValidateCrossRef: Boolean;
        Text2036000: Label 'Only one main BOM item is allowed.';
    //recFinXLSetup: Record "Finance XL Setup";  // BC Upgrade NANDIS03

}

