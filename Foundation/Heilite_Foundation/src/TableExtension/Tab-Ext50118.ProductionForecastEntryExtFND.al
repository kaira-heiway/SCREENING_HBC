tableextension 50118 ProductionForecastEntryExtFND extends "Production Forecast Entry"
{
    // HEI.01 FDD-BPMGAP001_BPMGAP002 IBM HORTOC01 06.09.2017 
    // # New field "Forecast Quantity HL"

    fields
    {
        modify("Production Forecast Name")
        {
            CaptionML = ENU = 'Production Forecast Name', FRA = 'Nom prévision production';
        }
        modify("Entry No.")
        {
            CaptionML = ENU = 'Entry No.', FRA = 'N° séquence';
        }
        modify("Item No.")
        {
            CaptionML = ENU = 'Item No.', FRA = 'N° article';
        }
        modify("Forecast Date")
        {
            CaptionML = ENU = 'Forecast Date', FRA = 'Date prévision';
        }
        modify("Forecast Quantity")
        {
            CaptionML = ENU = 'Forecast Quantity', FRA = 'Quantité prévision';
        }
        modify("Unit of Measure Code")
        {

            //Unsupported feature: Change TableRelation on ""Unit of Measure Code"(Field 6)". Please convert manually.

            CaptionML = ENU = 'Unit of Measure Code', FRA = 'Code unité';
        }
        modify("Qty. per Unit of Measure")
        {
            CaptionML = ENU = 'Qty. per Unit of Measure', FRA = 'Quantité par unité';
        }
        modify("Forecast Quantity (Base)")
        {
            CaptionML = ENU = 'Forecast Quantity (Base)', FRA = 'Quantité prévision (base)';
        }
        modify("Location Code")
        {
            CaptionML = ENU = 'Location Code', FRA = 'Code magasin';
        }
        modify("Component Forecast")
        {
            CaptionML = ENU = 'Component Forecast', FRA = 'Prévision composant';
        }
        modify(Description)
        {
            CaptionML = ENU = 'Description', FRA = 'Désignation';
        }

        //Unsupported feature: CodeModification on ""Unit of Measure Code"(Field 6).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemUnitofMeasure.GET("Item No.","Unit of Measure Code");
        "Qty. per Unit of Measure" := ItemUnitofMeasure."Qty. per Unit of Measure";
        "Forecast Quantity" := "Forecast Quantity (Base)" / "Qty. per Unit of Measure";
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        {HEI.01
        #1..3
        }
        //HEI.01>>
        ItemUnitofMeasureHL.GET("Item No.",'HL');
        "Qty. per Unit of Measure" := 1;
        "Unit of Measure Code" := 'HL';
        "Forecast Quantity (Base)" := "Forecast Quantity HL" * ItemUnitofMeasureHL."Qty. per Unit of Measure";
        "Forecast Quantity" := "Forecast Quantity (Base)";
        ////HEI.01<<
        */
        //end;


        //Unsupported feature: CodeModification on ""Forecast Quantity (Base)"(Field 8).OnValidate". Please convert manually.

        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Unit of Measure Code" = '' THEN BEGIN
          Item.GET("Item No.");
          "Unit of Measure Code" := Item."Sales Unit of Measure";
          ItemUnitofMeasure.GET("Item No.","Unit of Measure Code");
          "Qty. per Unit of Measure" := ItemUnitofMeasure."Qty. per Unit of Measure";
        end;
        VALIDATE("Unit of Measure Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        if "Unit of Measure Code" = '' then begin
        #2..5
        end;
        VALIDATE("Unit of Measure Code");
        */
        //end;
        field(50000; "Forecast Quantity HL FND"; Decimal)
        {
            Caption = 'Forecast Quantity HL';
            Description = 'HEI.01';

            trigger OnValidate();
            begin
                VALIDATE("Unit of Measure Code");
            end;
        }
    }


    //Unsupported feature: CodeModification on "OnInsert". Please convert manually.

    //trigger OnInsert();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Forecast Date");
    TESTFIELD("Production Forecast Name");
    LOCKTABLE;
    IF "Entry No." = 0 THEN
      IF ForecastEntry.FINDLAST THEN
        "Entry No." := ForecastEntry."Entry No." + 1;
    PlanningAssignment.AssignOne("Item No.",'',"Location Code","Forecast Date");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    if "Entry No." = 0 then
      if ForecastEntry.FINDLAST then
        "Entry No." := ForecastEntry."Entry No." + 1;
    PlanningAssignment.AssignOne("Item No.",'',"Location Code","Forecast Date");
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    var
        ItemUnitofMeasureHL: Record "Item Unit of Measure";
}

