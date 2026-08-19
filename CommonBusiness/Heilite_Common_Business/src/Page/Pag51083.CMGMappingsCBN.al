page 51083 "CMG Mappings CBN"
{
    // version HEI.01

    // HEI.01 CHG2021732 FDD-HB755 IBM.GUNERE01 03.12.2019 # Page created
    // HEI.02 CHG2021732 FDD-HB755 IBM.GUNERE01 16.01.2020 # "CIL3 Code" field added
    // HEI.03  CHG2093754 IBM PANDES01 23.02.2021
    //   # Added New field "C&TP CODE".

    PageType = List;
    SourceTable = "CMG Mapping FND";
    ApplicationArea = ALL;  // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists;  // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("CIL3 Code"; Rec."CIL3 Code")
                {
                    ToolTip = 'Specifies the value of the CIL3 Code field.';
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ToolTip = 'Specifies the value of the Dimension Code field.';
                }
                field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ToolTip = 'Specifies the value of the Dimension Value Code field.';
                }
                field("C&TP CODE"; Rec."C&TP CODE")
                {
                    ToolTip = 'Specifies the value of the C&TP CODE field.';
                }
            }
        }
    }

    actions
    {
    }
}

