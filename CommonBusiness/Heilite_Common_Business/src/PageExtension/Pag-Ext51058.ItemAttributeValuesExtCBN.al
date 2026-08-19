pageextension 51058 ItemAttributeValuesExtCBN extends "Item Attribute Values"
{
    // version NAVW110.0,HEI.01
    // HEI.01 FDD–GAPID043 IBM LAZARE02 27.07.2017
    //   # New column Description

    // HEI.02 Defect # 4550 IBM.GUNERE01 10.10.2019 # new function GetSelectionFilter added

    // BC Upgrade RDO3- Duplicate Object (P_Ext51418_ItemAttributeValues) has deleted.
    layout
    {
        modify(Value)
        {
            ToolTipML = ENU = 'Specifies the value of the item attribute.', FRA = 'Spécifie la valeur attribut article.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies whether it should be possible to assign this item attribute value to an item.', FRA = 'Indique s''il est possible d''allouer cette valeur attribut article à un article.';
        }
        addafter(Value)
        {
            field(Description; Rec."Description FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Description field.';
                //BC Upgrade YADAVM09                ToolTip = 'Specifies the value of the Description field.';

            }
        }
        addafter(Blocked)
        {
            field("Numeric Value"; Rec."Numeric Value")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Numeric Value field.';
                //BC Upgrade YADAVM09                ToolTip = 'Specifies the value of the Numeric Value field.';

            }
            field("Attribute Name"; Rec."Attribute Name")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the name of the item attribute.';
                //BC Upgrade YADAVM09                ToolTip = 'Specifies the name of the item attribute.';

            }
        }
    }
    actions
    {
        modify(Process)
        {
            CaptionML = ENU = 'Process', FRA = 'Traitement';
        }
        modify(ItemAttributeValueTranslations)
        {
            CaptionML = ENU = 'Translations', FRA = 'Traductions';
            ToolTipML = ENU = 'Opens a window in which you can specify the translations of the selected item attribute value.', FRA = 'Ouvre une fenêtre dans laquelle vous pouvez spécifier les traductions des valeurs de l''attribut article sélectionné.';

            //Unsupported feature: Change RunPageLink on "ItemAttributeValueTranslations(Action 7)". Please convert manually.

        }
    }


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF GETFILTER("Attribute ID") <> '' THEN
      AttributeID := GETRANGEMIN("Attribute ID");
    IF AttributeID <> 0 THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Attribute ID",AttributeID);
      FILTERGROUP(0);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    if GETFILTER("Attribute ID") <> '' then
      AttributeID := GETRANGEMIN("Attribute ID");
    if AttributeID <> 0 then begin
    #4..6
    end;
    */
    //end;

    procedure GetSelectionFilter(): Text;
    var
        ItemAttributeValue: Record "Item Attribute Value";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        //>>HEI.02
        CurrPage.SETSELECTIONFILTER(ItemAttributeValue);
        //exit(SelectionFilterManagement.GetSelectionFilterForItemAttributeValues(ItemAttributeValue));  // BC Upgrade NANDIS03
        //SelectionFilterManagement.GetSelectionFilter();  // BC Upgrade NANDIS03
        //<<HEI.02
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

