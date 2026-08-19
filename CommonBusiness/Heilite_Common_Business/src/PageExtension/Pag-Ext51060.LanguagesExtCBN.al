pageextension 51060 LanguagesExtCBN extends Languages
{
    //     // version NAVW110.0,DITW110.00.08,HEI.01
    // DITW15.00.00.38 DDR 25/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields "EU Language Code"
    // DITW15.00.00.39 DDR 09/05/2011 issue 1328 Shop (iPos) Functionnalities
    //                                  Added fields "ISO Language Text"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 FDD-PURGAPINT002 IBM LAZARE02 15.11.2017 # New field Use In Maximo
    // HEI.02 FDD-HT664 IBM SURYAS01 02-jan-2020
    //   #Added New Fields -"Notifcation Letter Subject","Notification Letter Body"
    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies the code for a language.', FRA = 'Spécifie le code pour une langue.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies the name of the language.', FRA = 'Spécifie le nom de la langue.';
        }
        modify("Windows Language ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the Windows language associated with the language code you have set up in this line.', FRA = 'Spécifie l''ID de la langue Windows associée au code langue que vous avez défini dans cette ligne.';

            //Unsupported feature: Change LookupPageID on ""Windows Language ID"(Control 9)". Please convert manually.

        }
        modify("Windows Language Name")
        {
            ToolTipML = ENU = 'Specifies if you enter an ID in the Windows Language ID field.', FRA = 'Spécifie si vous devez entrer un code dans le champ code langue Windows.';
        }
        addafter("Windows Language Name")
        {
            //BC Upgrade SHARMP16 BEGIN<< ---IBM GAP STP 48
            field("ISO Language Text"; Rec."ISO Language Text1 FND")
            {
                ApplicationArea = All;
            }
            //BC Upgrade SHARMP16 END>> ---IBM GAP STP 48
            // field("EU Language Code"; "EU Language Code")
            // {
            // }
            // field("ISO Language Text"; "ISO Language Text")
            // {
            //     ToolTipML = ENU = 'Format <aa-BB>  [aa]Language  [bb]Country  (e.g. "en-US")',
            //                 FRA = 'Format <aa-BB>  [aa]Langue  [bb]Pays  (ex. "en-US")';
            // }  // BC Upgrade NANDIS03
            field("Use In Maximo"; Rec."Use In Maximo FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Use In Maximo field.';
                // BC Upgrade NANDIS03                                                                                                                                                                                                                                                                                                                                                                                                                                              ToolTip = 'Specifies the value of the Use In Maximo field.';

            }
            field("Notifcation Letter Subject"; Rec."Notifcation Letter Subject FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Notifcation Letter Subject field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Notifcation Letter Subject field.';

            }
            field("Notification Letter Body"; Rec."Notification Letter Body FND")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Notification Letter Body field.';
                // BC Upgrade NANDIS03                ToolTip = 'Specifies the value of the Notification Letter Body field.';

            }
        }
    }

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

