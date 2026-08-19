namespace Heineken_BC_Upgrade.Heineken_BC_Upgrade;

using Microsoft.Inventory.Transfer;

pageextension 51166 TransferlinesExtCBN extends "Transfer lines"
{
    //     DITW15.00.00.37 DDR 28/05/2010 issue 480 Added Expand/Collapse functions
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "Item No."
    //                 CEL 13/08/2010           Modification RTC buttons
    //                 DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                         !!  Added IndentationColumnName property value = ActualExpansionStatusInt
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Unit of Measure" field
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // BC Upgrade SHUKLP03 >>
    // Added 1 in name because facing (Error:An application object of type 'PageExtension' with name 'TransferlinesExt' is already declared by the extension) compilation issue.
    // Table Transfer Line => Table HEI.01 code added here, description made editable false on page "Transfer Order Subform". 
    // BC Upgrade SHUKLP03 <<

    layout
    {
        modify(Description)
        {
            Editable = FALSE; // HEI.01
        }
    }

}
