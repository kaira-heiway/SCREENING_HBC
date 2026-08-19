page 51038 "Customer Default Dim. List CBN"
{
    // version HEI.03

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 24.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 FDD-SLSGAP001 IBM POENAB01 24.08.2017 # MDM Customer Card
    //   # Change object caption
    // HEI.03 FDD-SLSGAP001 IBM POENAB01 28.08.2017 # MDM Customer Card
    //   # Populate a list. Code added.
    //   # Code added to update a page.
    // 
    // HEI.04 FDD-SLSGAP001 IBM NASTAA02 15.09.2017 # MDM Customer Card
    //   # Added "Dimension Code" field
    //   # Deleted "Code" field

    //BC UPGRADE PATHAA02-18/09/25-Done (Dependecy T50081,T50089-Interface Ext-Saikat)

    Caption = 'Customer Default Dimension List';
    PageType = List;
    SourceTable = "Customer Default Dimension FND";
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = LISTS; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Field ID field.';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Field Name field.';
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the value of the Dimension Code field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        //<<HEI.03
        FinancialUtils.PopulateFieldList();
        //>>HEI.03
    end;

    var
        FinancialUtils: Codeunit "Financial-Utils";
}

