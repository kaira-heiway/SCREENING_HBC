pageextension 51082 ItemTrackingCodesExtCBN extends "Item Tracking Codes"
{
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added fields "SSCC Specific Tracking"

    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 CHG2119725 FDD-HB2359 IBM.GUNERE01 09.08.2021 # FA related field added

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code of the record.', FRA = 'Spécifie le code de l''enregistrement.';
        }
        modify(Description)
        {
            ToolTipML = ENU = 'Specifies a description of the item tracking code.', FRA = 'Indique une description du code traçabilité.';
        }
        modify("SN Specific Tracking")
        {
            ToolTipML = ENU = 'Specifies that when handling an outbound unit of the item in question, you must always specify which existing serial number to handle.', FRA = 'Spécifie que vous devez toujours préciser le numéro de série à gérer lorsque vous traitez une unité sortante de l''article concerné.';
        }
        modify("Lot Specific Tracking")
        {
            ToolTipML = ENU = 'Specifies that when handling an outbound unit, always specify which existing lot number to handle.', FRA = 'Spécifie que vous devez toujours préciser le numéro de lot à gérer lorsque vous traitez une unité sortante.';
        }
        addafter("Lot Specific Tracking")
        {
            //BC Upgrade KAPOOV01 Drink-it>>
            // field("SSCC Specific Tracking"; "SSCC Specific Tracking")
            // {
            //     Visible = false;
            // }
            //BC Upgrade KAPOOV01 Drink-it<<
            field("FA Related"; Rec."FA Related FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the FA Related field.';
                // BC Upgrade SHUKLP03 <<                                                                                                                                                                                                                                                               ToolTip = 'Specifies the value of the FA Related field.';

            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

