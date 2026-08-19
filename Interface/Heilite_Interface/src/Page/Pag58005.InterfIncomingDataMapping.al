page 58005 "Interf. Incoming Data Mapping"
{
    // Heilite Navision Old Id - 50089
    // version HEI.01

    // HEI.01 GAPID043 IBM LAZARE02 13.08.2017 # New page for mapping incoming data

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Interf. Incoming Data Mapping" to "Interf. IncomingDataMappingFND"
    // BC UPGRADE PATELS08 <<

    Caption = 'Interface Incoming Data Mapping';
    PageType = List;
    SourceTable = "Interf. IncomingDataMappingFND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ToolTip = 'Specifies the value of the Table Caption field.';
                }
                field("Field ID"; Rec."Field ID")
                {
                    ToolTip = 'Specifies the value of the Field ID field.';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the value of the Field Caption field.';
                }
                field("Incoming Table ID"; Rec."Incoming Table ID")
                {
                    ToolTip = 'Specifies the value of the Incoming Table ID field.';
                }
                field("Incoming Table Caption"; Rec."Incoming Table Caption")
                {
                    ToolTip = 'Specifies the value of the Incoming Table Caption field.';
                }
                field("Incoming Field ID"; Rec."Incoming Field ID")
                {
                    ToolTip = 'Specifies the value of the Incoming Field ID field.';
                }
                field("Incoming Field Caption"; Rec."Incoming Field Caption")
                {
                    ToolTip = 'Specifies the value of the Incoming Field Caption field.';
                }
                field("Mapping Field ID"; Rec."Mapping Field ID")
                {
                    ToolTip = 'Specifies the value of the Mapping Field ID field.';
                }
                field("Mapping Field Caption"; Rec."Mapping Field Caption")
                {
                    ToolTip = 'Specifies the value of the Mapping Field Caption field.';
                }
                field("Use Mapping Constant"; Rec."Use Mapping Constant")
                {
                    ToolTip = 'Specifies the value of the Use Mapping Constant field.';
                }
                field("Mapping Constant"; Rec."Mapping Constant")
                {
                    ToolTip = 'Specifies the value of the Mapping Constant field.';
                }
            }
        }
    }

    actions
    {
    }
}

