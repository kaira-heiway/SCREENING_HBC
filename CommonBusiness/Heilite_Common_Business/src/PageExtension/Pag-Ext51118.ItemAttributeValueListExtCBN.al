pageextension 51118 ItemAttributeValueListExtCBN extends "Item Attribute Value List"
{
    // version NAVW110.0,HEI.01
    // HEI.01 FDD–GAPID043 IBM LAZARE02 06.09.2017 # Apply format for decimal values
    // # Created procedure CheckInsertItemAttributeValue() because this is not found in base page to add HEI.01 code

    layout
    {
        modify("Attribute Name")
        {
            CaptionML = ENU = 'Attribute', FRA = 'Attribut';
            ToolTipML = ENU = 'Specifies the item attribute.', FRA = 'Spécifie l''attribut article.';

            trigger OnBeforeValidate()
            var
                ItemAttributeValue: Record "Item Attribute Value";
            begin
                CheckInsertItemAttributeValue(ItemAttributeValue); // BC Upgrade SHUKLP03 <<
            end;

        }
        modify(Value)
        {
            CaptionML = ENU = 'Value', FRA = 'Valeur';
            ToolTipML = ENU = 'Specifies the value of the item attribute.', FRA = 'Spécifie la valeur attribut article.';

            trigger OnBeforeValidate()
            var
                ItemAttributeValue: Record "Item Attribute Value";
            begin
                CheckInsertItemAttributeValue(ItemAttributeValue); // BC Upgrade SHUKLP03 <<
            end;
        }
        modify("Unit of Measure")
        {
            ToolTipML = ENU = 'Specifies the unit of measure for the item attribute.', FRA = 'Spécifie l''unité de mesure pour l''attribut article.';
        }
    }

    var
        ItemAttribute: Record "Item Attribute";

    LOCAL procedure CheckInsertItemAttributeValue(VAR ItemAttributeValue: Record "Item Attribute Value")
    var
        ItemAttribute: Record "Item Attribute";
        ValDecimal: Decimal;
    Begin
        ItemAttributeValue.RESET();
        ItemAttributeValue.SETRANGE("Attribute ID", Rec."Attribute ID");
        CASE Rec."Attribute Type" OF
            Rec."Attribute Type"::Option,
        Rec."Attribute Type"::Text,
        Rec."Attribute Type"::Integer:
                ItemAttributeValue.SETRANGE(Value, Rec.Value);
            Rec."Attribute Type"::Decimal:
                BEGIN
                    IF Rec.Value <> '' THEN
                        EVALUATE(ValDecimal, Rec.Value);
                    //HEI.01>>
                    //ItemAttributeValue.SETRANGE(Value,FORMAT(ValDecimal,0,9));
                    ItemAttribute.GET(Rec."Attribute ID");
                    IF ItemAttribute."Value Format FND" = '' THEN
                        ItemAttributeValue.SETRANGE(Value, FORMAT(ValDecimal, 0, 9))
                    else
                        ItemAttributeValue.SETRANGE(Value, FORMAT(ValDecimal, 0, ItemAttribute."Value Format FND"));
                    //HEI.01<<
                end;
        end;
        IF NOT ItemAttributeValue.FINDFIRST() THEN
            Rec.InsertItemAttributeValue(ItemAttributeValue, Rec);
    End;

    //Unsupported feature: CodeModification on "CheckInsertItemAttributeValue(PROCEDURE 5)". Please convert manually.

    //procedure CheckInsertItemAttributeValue();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemAttributeValue.RESET;
    ItemAttributeValue.SETRANGE("Attribute ID","Attribute ID");
    case "Attribute Type" of
    #4..8
        begin
          if Value <> '' then
            EVALUATE(ValDecimal,Value);
          ItemAttributeValue.SETRANGE(Value,FORMAT(ValDecimal,0,9));
        end;
    end;
    if not ItemAttributeValue.FINDFIRST then
      InsertItemAttributeValue(ItemAttributeValue,Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..11
          //HEI.01>>
          //ItemAttributeValue.SETRANGE(Value,FORMAT(ValDecimal,0,9));
          ItemAttribute.GET("Attribute ID");
          if ItemAttribute."Value Format" = '' then
            ItemAttributeValue.SETRANGE(Value,FORMAT(ValDecimal,0,9))
          else
            ItemAttributeValue.SETRANGE(Value,FORMAT(ValDecimal,0,ItemAttribute."Value Format"));
          //HEI.01<<
    #13..16
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

