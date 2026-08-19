tableextension 50132 ResourceGroupExtFND extends "Resource Group"
{
    // version NAVW19.00,DITW18.00

    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify(Name)
        {
            CaptionML = ENU = 'Name', FRA = 'Nom';
        }
        modify("Date Filter")
        {
            CaptionML = ENU = 'Date Filter', FRA = 'Filtre date';
        }
        modify(Capacity)
        {

            //Unsupported feature: Change CalcFormula on "Capacity(Field 23)". Please convert manually.

            CaptionML = ENU = 'Capacity', FRA = 'Capacité';
        }
        modify("Qty. on Order (Job)")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Order (Job)"(Field 24)". Please convert manually.

            CaptionML = ENU = 'Qty. on Order (Job)', FRA = 'Qté commandée (projet)';
        }
        modify("Qty. Quoted (Job)")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. Quoted (Job)"(Field 25)". Please convert manually.

            CaptionML = ENU = 'Qty. Quoted (Job)', FRA = 'Qté en devis (projet)';
        }
        modify("Unit of Measure Filter")
        {
            CaptionML = ENU = 'Unit of Measure Filter', FRA = 'Filtre unité';
        }
        modify("Usage (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Usage (Qty.)"(Field 27)". Please convert manually.

            CaptionML = ENU = 'Usage (Qty.)', FRA = 'Activité (qté)';
        }
        modify("Usage (Cost)")
        {

            //Unsupported feature: Change CalcFormula on ""Usage (Cost)"(Field 28)". Please convert manually.

            CaptionML = ENU = 'Usage (Cost)', FRA = 'Activité (coût)';
        }
        modify("Usage (Price)")
        {

            //Unsupported feature: Change CalcFormula on ""Usage (Price)"(Field 29)". Please convert manually.

            CaptionML = ENU = 'Usage (Price)', FRA = 'Activité (prix)';
        }
        modify("Sales (Qty.)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales (Qty.)"(Field 30)". Please convert manually.

            CaptionML = ENU = 'Sales (Qty.)', FRA = 'Ventes (qté)';
        }
        modify("Sales (Cost)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales (Cost)"(Field 31)". Please convert manually.

            CaptionML = ENU = 'Sales (Cost)', FRA = 'Ventes (coût)';
        }
        modify("Sales (Price)")
        {

            //Unsupported feature: Change CalcFormula on ""Sales (Price)"(Field 32)". Please convert manually.

            CaptionML = ENU = 'Sales (Price)', FRA = 'Ventes (prix)';
        }
        modify("Chargeable Filter")
        {
            CaptionML = ENU = 'Chargeable Filter', FRA = 'Filtre facturable';
        }
        modify("Global Dimension 1 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 1 Code"(Field 34)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 1 Code', FRA = 'Code axe principal 1';
        }
        modify("Global Dimension 2 Code")
        {

            //Unsupported feature: Change TableRelation on ""Global Dimension 2 Code"(Field 35)". Please convert manually.

            CaptionML = ENU = 'Global Dimension 2 Code', FRA = 'Code axe principal 2';
        }
        modify("No. of Resources Assigned")
        {

            //Unsupported feature: Change CalcFormula on ""No. of Resources Assigned"(Field 36)". Please convert manually.

            CaptionML = ENU = 'No. of Resources Assigned', FRA = 'Nbre de ressources attribuées';
        }
        modify("Qty. on Service Order")
        {

            //Unsupported feature: Change CalcFormula on ""Qty. on Service Order"(Field 5900)". Please convert manually.

            CaptionML = ENU = 'Qty. on Service Order', FRA = 'Qté sur commande service';
        }
        // field(2034966;"Default Resource No.";Code[20])
        // {
        //     CaptionML = ENU='Default Resource No.',
        //                 FRA='N° ressource par défaut';
        //     Description = 'DIT-715 #434';
        //     TableRelation = Resource WHERE ("Resource Group No."=FIELD("No."));
        // }  // BC Upgrade NANDIS03 - Blocked Aptean code
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

