namespace Heiniken.Heiniken;

using Microsoft.Manufacturing.Reports;

reportextension 51000 ProductionOrderStatsExtCBN extends "Production Order Statistics"
{
    //  HEI.01 IBM NASTAA02 14.09.2017 # Standard Reports Navision  - minor changes
    //   # Layout improvements
    //---------------------------------------------------------------------------------------

    //BC Upgrade KAPOOV01 11.12.2025 #Created new Report extention and defined custom layout modified under HEI Tag.
    //BC Upgrade KAPOOV01 11.12.2025 #Created new column- CompanyName_Cust Inside dataitem for-"Production Order" to modify source expression of column-CompanyName as done in Heiniken Report and also replaced CompanyName column in report layout with new column created-CompanyName_Cust.

    //NAVW110.0,HEI.01

    dataset
    {
        add("Production Order")
        {
            column(CompanyName_Cust; CompanyName)
            {
            }
        }
    }
    rendering
    {

        layout(RDLC_Cust)
        {
            Type = RDLC;
            LayoutFile = '.\src\ReportsLayout\ProductionOrderStatistics.rdl';
        }

    }

}
