pageextension 51153 WarehousePickExtCBN extends "Warehouse Pick"
{
    // version NAVW110.0,OWM4.50,DITW110.00.08,HEI.02
    //     DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               New menu "Show OWM Activitystatus" on Pick Action.
    //                                               OnDeleteRecord - code added.

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1

    // HEI.01 FDD-PA-LOGGAP09 - Picking List v1.0 26.04.2018 IBM.NAIKH01
    //   # Added the new report 50127 - Picking List by Lot No on the Menu.
    // HEI.02 FDD-BA-LOGGAP07 IBM NASTAA02 14.01.2019 # Picking List
    //   # New Page Action created "Picking List by Sales Order"

    // HEI.03 IBM HORTOC01 19.04.2019 # Setup the report Picking List By Lot in Report selection Inventory

    // BC Upgrade SHUKLP03 << Codeunit name "Warehouse Document-Print" is replaced with "Heineken BC Upgrade".

    layout
    {
    }
    actions
    {
        // BC Upgrade SHUKLP03 << DrinkIT action blocked.
        // addafter("Registered Picks")
        // {
        //     separator(Separator1161021000)
        //     {
        //     }
        //     action("Show OWM Activitystatus")
        //     {
        //         CaptionML = ENU='Show OWM Activitystatus',
        //                     FRA='Afficher statut activité OWM';

        //         trigger OnAction();
        //         var
        //             OWMUtils : Codeunit "N-owm Utils";
        //         begin
        //             // NIQ OWM >>
        //             OWMUtils.ShowActivityStatus(OWMUtils.ActPick, "No.", "Location Code");  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
        //             // NIQ OWM <<
        //         end;
        //     }
        // }
        // BC Upgrade SHUKLP03 << DrinkIT action blocked.

        addafter("&Print")
        {
            action("Picking List by Lot")
            {
                CaptionML = ENU = 'Picking List by Lot',
                            FRA = '&Imprimer';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the Picking List by Lot action.';

                trigger OnAction();
                begin
                    /*commented by HEI.03
                    //>>HEI.01
                    WarehouseActivityHeader.RESET;
                    WarehouseActivityHeader.SETRANGE("No.","No.");
                    REPORT.RUN(REPORT::"Picking List by Lot STD",TRUE,FALSE,WarehouseActivityHeader);
                    //<< HEI.01
                    */
                    //HEI.03>>
                    WhseDocPrint.PrintPickingListWhseActivity(Rec); // BC Upgrade SHUKLP03 << Codeunit name "Warehouse Document-Print" is replaced with "Heineken BC Upgrade".
                    //HEI.03<<

                end;
            }
            action(PickingListbySalesOrder)
            {
                Caption = 'Picking List by Sales Order';
                Description = 'HEI.02';
                Image = Print;
                ApplicationArea = All;
                ToolTip = 'Executes the Picking List by Sales Order action.';

                trigger OnAction();
                var
                    WarehouseActivityHeader2: Record "Warehouse Activity Header";
                begin
                    //HEI.02>>
                    WarehouseActivityHeader2.SETRANGE("No.", rec."No.");
                    REPORT.RUN(REPORT::"Pickng Lst by Sales Ord BA CBN", true, false, WarehouseActivityHeader2);
                    //HEI.02<<
                end;
            }
        }
    }

    var
    //OWMUtils: Codeunit "N-owm Utils";

    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        WhseDocPrint: Codeunit "Heineken BC Upgrade";


    //Unsupported feature: CodeInsertion on "OnDeleteRecord". Please convert manually.

    //trigger (Variable: OWMUtils)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: CodeModification on "OnDeleteRecord". Please convert manually.

    //trigger OnDeleteRecord() : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // NIQ OWM >>
    //soicad delete because is not in the license OWMUtils.DelAct_WarehouseActivityHeader(Rec);  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
    // NIQ OWM <<
    CurrPage.UPDATE;
    */
    //end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

