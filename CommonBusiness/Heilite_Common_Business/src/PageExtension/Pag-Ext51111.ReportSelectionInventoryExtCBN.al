pageextension 51111 ReportSelectionInventoryExtCBN extends "Report Selection - Inventory"
{
    // version NAVW110.0,DITW110.00.08,HEI.02
    // DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.08 DDR 16/02/2017 NRQ#20755 update "Document Sub Type Filter"
    // HEI.01 FDD-LB-GAPLOG03 IBM NASTAA02 17.07.2018 # Loading Note Almaza
    // # New Option added "Load List (Posted Whse. Shipment)"
    // HEI.02 FDD-LB-GAPLOG09 IBM CHAUHB01 18.07.2018 # Picking List Layout Almaza
    // # New Option added "Combined Pick (Whs Shipment)"
    // HEI.03 IBM HORTOC01 14.08.2018 # Loading Notes
    // # New Option added "Loading notes (Whs Shipment)"

    // HEI.04 IBM.NAIKH01 10.09.2018 # Zone (Whse Movement)
    // # New Option added "Zone (Whse Movement)"
    // HEI.05 IBM HORTOC01 19.04.2019 # add new options "Unloading Note(Whse. Receipt),Picking List By Lot"
    // HEI.06 CHG2011091 IBM GAVANM01 23.05.2019
    // # add new option "Gate Entry Document" on global variable "ReportUsage2"
    // # new code

    //A new enum extension has been created: 50011 - ReportSelectionUsageInventoryExt.

    layout
    {
        modify(ReportUsage2)
        {
            CaptionML = ENU = 'Usage', FRA = 'Utilisation';
            ToolTipML = ENU = 'Specifies which type of document the report is used for.', FRA = 'Spécifie le type de document pour lequel l''état est utilisé.';
            //OptionCaptionML = ENU = 'Transfer Order,Transfer Shipment,Transfer Receipt,Inventory Period Test,Assembly Order,Posted Assembly Order,Load List (Posted Whse. Shipment),Combined Pick (Whs Shipment),Loading Notes (Whse. Shipment),Zone (Whse Movement),Unloading Note(Whse. Receipt),Picking List By Lot,Gate Entry Document', FRA = 'Ordre transfert,Expédition transfert,Réception transfert,Test période inventaire,Ordre d''assemblage,Ordre d''assemblage validé,Load List (Posted Whse. Shipment),Combined Pick (Whs Shipment),Loading Notes (Whse. Shipment),Zone (Whse Movement),Unloading Note(Whse. Receipt),Picking List By Lot,Gate Entry Document'; // BC Upgrade SHUKLP03 << Blocked because now it is converted in ENUM.
        }
        modify(Sequence)
        {
            ToolTipML = ENU = 'Specifies a number that indicates where this report is in the printing order.', FRA = 'Spécifie un numéro qui indique où se trouve l''état dans l''ordre d''impression.';
        }
        modify("Report ID")
        {
            ToolTipML = ENU = 'Specifies the ID of the report that the program will print.', FRA = 'Spécifie l''ID du rapport que le programme imprime.';
        }
        modify("Report Caption")
        {
            ToolTipML = ENU = 'Specifies the name of the report.', FRA = 'Spécifie le nom de l''état.';
        }

        // BC Upgrade VAMSIU01 >> DrinkIT field is added.
        addafter("Report Caption")
        {
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Inventory));
                ApplicationArea = All;
            }
        }
        // BC Upgrade VAMSIU01 << DrinkIT field is added.
    }


    //Unsupported feature: PropertyModification on "ReportUsage2(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReportUsage2 : "Transfer Order","Transfer Shipment","Transfer Receipt","Inventory Period Test","Assembly Order","Posted Assembly Order";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReportUsage2 : "Transfer Order","Transfer Shipment","Transfer Receipt","Inventory Period Test","Assembly Order","Posted Assembly Order","Load List (Posted Whse. Shipment)","Combined Pick (Whs Shipment)","Loading Notes (Whse. Shipment)","Zone (Whse Movement)","Unloading Note(Whse. Receipt)","Picking List By Lot","Gate Entry Document";
    //Variable type has not been exported.


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetUsageFilter(false);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetUsageFilter(false);
    // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
    SetDocSubTypeFilter;
    // >>DITW110.00.08 DDR NRQ#20755
    */
    //end;

    //BC Upgrade VAMSIU01 >>
    trigger OnOpenPage()
    begin
        // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
        SetDocSubTypeFilter;
        // >>DITW110.00.08 DDR NRQ#20755
    end;
    //BC Upgrade VAMSIU01 <<


    //Unsupported feature: CodeModification on "SetUsageFilter(PROCEDURE 1)". Please convert manually.

    //procedure SetUsageFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if ModifyRec then
      if MODIFY then;
    FILTERGROUP(2);
    #4..13
        SETRANGE(Usage,Usage::"Asm. Order");
      ReportUsage2::"Posted Assembly Order":
        SETRANGE(Usage,Usage::"P.Assembly Order");
    end;
    FILTERGROUP(0);
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..16
    // BC Upgrade Priya >> Code added in HeinekeinToBCUpgrade codeunit
      //HEI.01>>
      ReportUsage2::"Load List (Posted Whse. Shipment)":
        SETRANGE(Usage,Usage::"Load List (Pst. Whse. Shipment)");
      //HEI.01<<
      //HEI.02>>
      ReportUsage2::"Combined Pick (Whs Shipment)":
        SETRANGE(Usage,Usage::"Combined Pick (Whs Shipment)");
      //HEI.02<<
      //HEI.03>>
      ReportUsage2::"Loading Notes (Whse. Shipment)":
        SETRANGE(Usage,Usage::"Loading Note(Whse Ship)");
      //HEI.03<<
      //HEI.04<<
      ReportUsage2::"Zone (Whse Movement)":
        SETRANGE(Usage,Usage::"Zone (Whse Movement)");
      //HEI.04>>
      //HEI.05>>
      ReportUsage2::"Unloading Note(Whse. Receipt)":
        SETRANGE(Usage,Usage::"Unloading Note(Whse. Receipt)");
      ReportUsage2::"Picking List By Lot":
        SETRANGE(Usage,Usage::"Picking List By Lot");
      //HEI.05<<
      //HEI.06>>
      ReportUsage2::"Gate Entry Document":
        SETRANGE(Usage,Usage::"Gate Entry Document");
      //HEI.06<<
      //HEI.04<<
    // BC Upgrade Priya << Code added in HeinekeinToBCUpgrade codeunit
    #17..19
    */
    //end;

    // BC Upgrade VAMSIU01 - Added>> 
    local procedure SetDocSubTypeFilter();
    begin
        // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
        Rec.FILTERGROUP(2);
        Rec.FilterDocSubType(Rec."Doc Subtype Filter Table FND"::Inventory);
        Rec.FILTERGROUP(0);
    end;
    // BC Upgrade VAMSIU01 0- Added <<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

