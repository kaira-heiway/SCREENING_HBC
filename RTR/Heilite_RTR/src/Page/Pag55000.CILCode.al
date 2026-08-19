page 55000 "CIL Code"
{
    // version HEI.02,EDD072

    // HEI:EDD072:1:1 21/12/14 TECTURA.WSA
    //   # Created new Page for CIL ID Code
    // HEI.02 FDD-BPMGAP014 IBM ISYED01 24.08.2017
    //   #Added added new page migrated from HEI2.0 to Base

    // BC Upgrade Kamnay01 Original(Heilite) page id 50143


    Caption = 'CIL Code';
    PageType = List;
    SourceTable = "CIL Code RTR";
    ApplicationArea = All; //BC Upgrade PATHAA02
    UsageCategory = Lists; //BC Upgrade PATHAA02

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'Group';
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}

