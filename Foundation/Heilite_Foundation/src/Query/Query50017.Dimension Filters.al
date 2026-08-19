query 50017 "Dimension Filters"
{
    // version HEI.01

    // HEI.01 CHG2143756 SAHAL01      13.04.2022
    //   # Created New Query: 50017 - Dimension Filters

    Caption = 'Dimension Filters';

    elements
    {
        dataitem(Item; Item)
        {
            DataItemTableFilter = "Inventory Value Zero" = CONST(false), "Costing Method" = FILTER(Standard | Average);
            filter(No; "No.")
            {
            }
            dataitem(Default_Dimension; "Default Dimension")
            {
                DataItemLink = "No." = Item."No.";
                DataItemTableFilter = "Table ID" = CONST(27), "Dimension Code" = CONST('CMG');
                filter(Dimension_Value_Code; "Dimension Value Code")
                {
                }
                column(Dimension_Value_Code_1; "Dimension Value Code")
                {
                    CaptionML = ENU = 'Dimension_Value_Code_1',
                                FRA = 'Code section';
                }
            }
        }
    }
}

