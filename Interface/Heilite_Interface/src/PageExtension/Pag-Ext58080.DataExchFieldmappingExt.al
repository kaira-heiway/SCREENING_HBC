pageextension 58080 "DataExchFieldMappingExt" extends "Data Exch Field Mapping Part"
{
    layout
    {
        addafter("Transformation Rule")
        {
            field("Use Default Value"; Rec."Use Default Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the whether to use default values or not';
            }
            field("Default Value"; Rec."Default Value")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Default Value';
            }
        }
    }
}
