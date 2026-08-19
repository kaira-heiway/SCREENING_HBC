page 50252 "Reason Codes_Purchase"
{
    // version NAVW110.0,DITW110.00.08

    // HEI.01 RFC-CHG0246348 IBM.AB 08.10.2018
    //   # List Page created for Reason Code_Purchase table and added it in Menusuite in Purchase--> Administration

    CaptionML = ENU = 'Reason Codes',
                FRA = 'Codes motif';
    PageType = List;
    SourceTable = "Reason Code_Purchase FND";
    ApplicationArea = ALl;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Control55005)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a reason code to attach to the entry.',
                                FRA = 'Indique un code motif à associer à l''écriture.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies a description of what the code stands for.',
                                FRA = 'Indique une description de ce que le code représente.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control55001; Links)
            {
                Visible = false;
            }
            systempart(Control55000; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

