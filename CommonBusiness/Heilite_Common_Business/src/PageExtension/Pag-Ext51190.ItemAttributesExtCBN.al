pageextension 51190 ItemAttributesExtCBN extends "Item Attributes"
{
    // version NAVW110.0
    // BC Upgrade SHUKLP03 >>
    // Added field "Value Format" after Blocked field
    // BC Upgrade SHUKLP03 <<

    layout
    {
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the item attribute.', ESP = 'Especifica el nombre del atributo de producto.', FRA = 'Spécifie le nom de l''attribut article.';
        }
        modify(Type)
        {
            ToolTipML = ENU = 'Specifies the type of the item attribute.', ESP = 'Especifica el tipo del atributo de producto.', FRA = 'Spécifie le type de l''attribut article.';
        }
        modify(Values)
        {
            CaptionML = ENU = 'Values', ESP = 'Valores', FRA = 'Valeurs';
            ToolTipML = ENU = 'Specifies the values of the item attribute.', ESP = 'Especifica los valores del atributo de producto.', FRA = 'Spécifie les valeurs de l''attribut article.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies whether it should be possible to assign this item attribute to an item.', ESP = 'Especifica si debería ser posible asignar a un producto este atributo de producto.', FRA = 'Indique s''il est possible d''allouer cet attribut article à un article.';
        }
        addafter(Blocked)
        {
            field("Value Format"; Rec."Value Format FND")
            {
                ApplicationArea = All;
                ToolTipML = ENU = 'Specifies the format for the values of the item attribute.', ESP = 'Especifica el formato de los valores del atributo de producto.', FRA = 'Spécifie le format des valeurs de l''attribut article.';
            }
        }
    }
    actions
    {
        modify("&Attribute")
        {
            CaptionML = ENU = '&Attribute', ESP = '&Atributo', FRA = '&Attribut';
        }
        modify(ItemAttributeValues)
        {
            CaptionML = ENU = 'Item Attribute &Values', ESP = '&Valores de atributo de producto', FRA = 'Valeurs d''attribut &article';
            ToolTipML = ENU = 'Opens a window in which you can define the values for the selected item attribute.', ESP = 'Abre una ventana en la que se pueden definir los valores para el atributo de producto seleccionado.', FRA = 'Ouvre une fenêtre dans laquelle vous pouvez définir les valeurs de l''attribut article sélectionné.';
        }
        modify(ItemAttributeTranslations)
        {
            CaptionML = ENU = 'Translations', ESP = 'Traducciones', FRA = 'Traductions';
            ToolTipML = ENU = 'Opens a window in which you can define the translations for the selected item attribute.', ESP = 'Abre una ventana en la que se pueden definir las traducciones para el atributo de producto seleccionado.', FRA = 'Ouvre une fenêtre dans laquelle vous pouvez définir les traductions de l''attribut article sélectionné.';
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

