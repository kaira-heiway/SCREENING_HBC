pageextension 51189 ItemBudgetNamesExtCBN extends "Item Budget Names"
{
    // version NAVW110.0

    layout
    {
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the item budget.', FRA = 'Spécifie le nom du budget article.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item budget.', FRA = 'Spécifie une description du budget article.';
        }
        modify(Blocked)
        {
            ToolTipML = ENU = 'Specifies whether the item budget is blocked.', FRA = 'Indique si le budget article est bloqué.';
        }
        modify("Budget Dimension 1 Code")
        {
            ToolTipML = ENU = 'Specifies a dimension code for Item Budget Dimension 1.', FRA = 'Spécifie un code axe analytique pour l''axe budget article 1.';
        }
        modify("Budget Dimension 2 Code")
        {
            ToolTipML = ENU = 'Specifies a dimension code for Item Budget Dimension 2.', FRA = 'Spécifie un code axe analytique pour l''axe budget article 2.';
        }
        modify("Budget Dimension 3 Code")
        {
            ToolTipML = ENU = 'Specifies a dimension code for Item Budget Dimension 3.', FRA = 'Spécifie un code axe analytique pour l''axe budget article 3.';
        }
        addafter("Budget Dimension 3 Code")
        {
            field("Data Version Reference"; Rec."Data Version Reference FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Data Version Reference field.';
            }
            field("Autom. copy Budget Dim.1 from"; Rec."Autom. cpy Bdgt. Dim.1 frm FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Autom. copy Budget Dim.1 from field.';
            }
            field("Autom. copy Budget Dim.2 from"; Rec."Autom. cpy Bdgt. Dim.2 frm FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Autom. copy Budget Dim.2 from field.';
            }
            field("Autom. copy Budget Dim.3 from"; Rec."Autom. cpy Bdgt. Dim.3 frm FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Autom. copy Budget Dim.3 from field.';
            }
        }
    }

    //Unsupported feature: PropertyChange. Please convert manually.

}

