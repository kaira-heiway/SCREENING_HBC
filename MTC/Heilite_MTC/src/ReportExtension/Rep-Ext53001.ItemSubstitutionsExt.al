reportextension 53001 ItemSubstitutionsExt extends "Item Substitutions"
{
    /* 
    HEI.01 IBM NASTAA02 18.10.2017 # Defect 545
        # Dataset and Layout improvements 
     */
    // BC Upgrade BHARDA11 >>
    // 1. Changes in the layout Nav column expression is different as compare to Business central , so change all the expression in the layout.
    // BC Upgrade BHARAD11 <<
    RDLCLayout = '.\src\ReportsLayout\Item Substitutions.rdl';
    dataset
    {


    }
    labels
    {
        ReportTitleLbl = 'Item Substitutions';
        PageLbl = 'Page';
        BaseUnitOfMeasureLbl = 'Base Unit of Measure';
        QuantityOnHandLbl = 'Quantity on Hand';
    }


}
