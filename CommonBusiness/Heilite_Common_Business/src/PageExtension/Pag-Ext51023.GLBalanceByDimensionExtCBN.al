pageextension 51023 GLBalancebyDimensionExtCBN extends "G/L Balance by Dimension"
{
    // HEI.01 CHG2024918 IBM POENAB02 16.09.2019 La Réunion_France Fiscal Year Closing
    //   # Code added in trigger OnOpenPage
    //   # Code added in ShowMatrix - OnAction()
    //   # Added IncludeSimulation in Group Filters
    layout
    {

    }

    actions
    {

    }


    var
        CompanyInfo: Record "Company Information";
        IncludeSimulation: Boolean;

    trigger OnOpenPage()
    begin
        //HEI.01>>
        // CompanyInfo.GET;
        // IF CompanyInfo."Enable French Localization" THEN
        //     IncludeSimulation := FALSE;
        //HEI.01<<
    end;
}