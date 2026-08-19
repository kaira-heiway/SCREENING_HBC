pageextension 51100 ReportSelectionSalesExtCBN extends "Report Selection - Sales"
{
    // version NAVW110.0,FINXL10.00,DITW110.00.08
    //DITW15.00.00.39 RBE 20/04/2011 issue 1230 Telesales functionnalities
    //                                  Added 2 new options tot the filter and new code (S.SHPT and S.PICK)
    //DITW16.00.00.40 DDR 13/02/2012 #1460 Renamed/Bugfix option value of "Usage" field (table 77 Report Selections

    //FINXL7.00.001 RBE 04/06/2013: Added pro-forma option

    //DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    //DITW17.00.02 SR 10/21/2013 DIT-770 #155 : New Code Added
    //DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //DITW17.00.02 RPG 18/12/2013 DIT-770 #235 Added Code for "Shipment Specification"
    //DITW17.10.03 MSF 09/07/2014 DIT-770 #542 :  Sales Return control document
    //                                            Added New option "Return Control" in Usage field
    //DITW17.10.05 MSF 09/07/2014 DIT-770 #925 Change Option order on Variable ReportUsage2
    //DITW17.10.05 MSF 16/09/2014 DIT-770 #925 Delete Option "Order - Picking"  From Variable ReportUsage2
    //DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5
    //DITW18.00.06 MSF 29/05/2015 DIT-770 #1269 Restore option (DIT-770 #925 (Delete option Order-picking))
    //DITW18.00.07 AKH 31/03/2016 DIT-770 #1508 Added field "Document Subtype Code"
    //DITW18.00.07 DDR 19/04/2016 DIT-770 #1488 Rename 'Combined Shipment' -> 'Load List'

    //DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //DITW110.00.08 DDR 03/02/2017 NRQ#20678 update ReportUsage2
    //                                        remove (DIT-770 #925) update page on Report ID control
    //DITW110.00.08 DDR 16/02/2017 NRQ#20755 update "Document Sub Type Filter"

    //FINXL10.00 DDR 03/02/2017 NRQ#20678 pro-forma

    //HEI.01 FDD- HB597 IBM BULIMc01 24.05.2019 #added new option "Picking list by Sales Order BA" on page
    //HEI.03 FDD- HT465 IBM SURYAS01 28.08.2019
    //  # add new option "Delivery Note(SUR)" on ReportUsage2 Field
    //  #added code on SetUsageFilter function.
    //HEI.04 Defect4464 IBM BULIMC01 26/11/2019 #"Delivery Note(SUR)" changed to "Delivery Note(Local)"
    //HEI.05 FDD-HB503 IBM NASTAA02 30.01.2019 # Post & Print
    //  # Renamed Option of "ReportUsage2" from "Delivery Note(Local)" to "Delivery Note(Sales Invoice)"
    //  # Code changed on Function "SetUsageFilter"
    //HEI.06 CHG2070787 IBM GAVANM01 03.09.2020 - Update all Billing documents in line with Global (for the BAHAMAS)
    //  # add new option "Debit Note" in ReportUsage2 variable
    //  # code added


    layout
    {
        modify(ReportUsage)
        {
            CaptionML = ENU = 'Usage', FRA = 'Utilisation';
            ToolTipML = ENU = 'Specifies which type of document the report is used for.', FRA = 'Spécifie le type de document pour lequel l''état est utilisé.';
            //OptionCaptionML = ENU = 'Quote,Blanket Order,Order,Invoice,Work Order,Return Order,Credit Memo,Shipment,Return Receipt,Sales Document - Test,Prepayment Document - Test,S.Arch. Quote,S.Arch. Order,S. Arch. Return Order,Pick Instruction,Customer Statement,Draft Invoice,,,,,,,,,,Sales Order Pick,Picking List,Shipping List,Order (Shipment),Combined Picking,Load List,Shipment Specification,Return Control,,,,,,,,,,,,,,,,,,,,Pro-forma Invoice,Cash.Collection,Delivery Note(Whse Ship),Picking List By SO,Delivery Note(Sales Invoice),Debit Note', FRA = 'Devis,Commande ouverte,Commande,Facture,Ordre fabrication,Retour,Avoir,Expédition,Réception retour,Document vente - Test,Document acompte - Test,DevisVteArch.,CdeVteArch.,RetourVteArch.,Instruction prélèvement,Relevé client,Facture provisoire,Picking List By SO';// BC Upgrade SHUKLP03 << Blocked this because this is convert in ENUM.
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
            ToolTipML = ENU = 'Specifies the name of the report.', FRA = 'Spécifie le nom du rapport.';
        }
        modify("Use for Email Body")
        {
            ToolTipML = ENU = 'Specifies that summarized information, such as invoice number, due date, and payment service link, will be inserted in the body of the email that you send.', FRA = 'Spécifie que les informations résumées, telles que le numéro de facture, la date d''échéance et le lien de service de paiement, vont être insérées dans le corps de l''e-mail que vous envoyez.';
        }
        modify("Use for Email Attachment")
        {
            ToolTipML = ENU = 'Specifies that the related document will be attached to the email.', FRA = 'Spécifie que le document associé sera joint à l''e-mail.';
        }
        modify("Email Body Layout Code")
        {
            ToolTipML = ENU = 'Specifies the ID of the email body layout that is used.', FRA = 'Spécifie l''ID présentation du corps du message e-mail qui est utilisé.';
        }
        modify("Email Body Layout Description")
        {
            ToolTipML = ENU = 'Specifies a description of the email body layout that is used.', FRA = 'Spécifie une description de la présentation du corps du message e-mail qui est utilisée.';
        }
        //BC Upgrade VAMSIU01>> - DrinkIT
        addafter("Report Caption")
        {
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                ApplicationArea = All;
            }
        } //BC Upgrade VAMSIU01<< - DrinkIT
    }

    var
    // DummyDocSubType: Record "Document Subtype Code" temporary; //BC Upgrade Priya<< - DrinkIT


    //Unsupported feature: PropertyModification on "ReportUsage2(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReportUsage2 : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReportUsage2 : 1101000000;
    //Variable type has not been exported.


    //Unsupported feature: PropertyModification on "ReportUsage2(Variable 1000)". Please convert manually.

    //var
    //>>>> ORIGINAL VALUE:
    //ReportUsage2 : Quote,"Blanket Order",Order,Invoice,"Work Order","Return Order","Credit Memo",Shipment,"Return Receipt","Sales Document - Test","Prepayment Document - Test","S.Arch. Quote","S.Arch. Order","S. Arch. Return Order","Pick Instruction","Customer Statement","Draft Invoice";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReportUsage2 : Quote,"Blanket Order",Order,Invoice,"Work Order","Return Order","Credit Memo",Shipment,"Return Receipt","Sales Document - Test","Prepayment Document - Test","S.Arch. Quote","S.Arch. Order","S. Arch. Return Order","Pick Instruction","Customer Statement","Draft Invoice",,,,,,,,,,"S.Order Pick","S.Picking List","S.Shipping List","Order Shipment","S.Combined Picking","S.Load List","Shipment Specification","Return Control",,,,,,,,,,,,,,,,,,,,"Pro-forma",,"Delivery Note(Whse Ship)","Picking List By SO","Delivery Note(Sales Invoice)","Debit Note";
    //Variable type has not been exported.

    var
        _NAV2017_ReportUsage2: Option Quote,"Blanket Order","Order",Invoice,"Work Order","Return Order","Credit Memo",Shipment,"Return Receipt","Sales Document - Test","Prepayment Document - Test","S.Arch. Quote","S.Arch. Order","S. Arch. Return Order","Pick Instruction","Customer Statement","Draft Invoice";    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.
    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger (Variable: DummyDocSubType)();
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


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
    case ReportUsage2 of
      ReportUsage2::Quote:
        SETRANGE(Usage,Usage::"S.Quote");
    #7..35
        SETRANGE(Usage,Usage::"S. Arch. Return Order");
      ReportUsage2::"Customer Statement":
        SETRANGE(Usage,Usage::"C.Statement");
    end;
    FILTERGROUP(0);
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3

    // <<DITW17.00.01 DDR 13/02/2013 DIT-770 #001
    SETRANGE(Usage);
    SETRANGE(UsageDIT);
    // >>DITW17.00.01 DDR DIT-770 #001
    //<<FINXL10.00 DDR 03/02/2017 NRQ#20678
    SETRANGE(UsageXL);
    //>>FINXL10.00 DDR 03/02/2017 NRQ#20678

    #4..38
      ReportUsage2::"Delivery Note(Whse Ship)":
        SETRANGE(Usage,Usage::"Delivery Note(Whse Ship)");
      //<<HEI.03
      //ReportUsage2::"Delivery Note(SUR)": //commented HEI.04
       // SETRANGE(Usage,Usage::"Delivery Note(Local)"); //commented HEI.04
      //<<HEI.03
      //BC Upgrade Priya>> - Code added in Cod53499
      //HEI.04<<
      ReportUsage2::"Delivery Note(Sales Invoice)": //HEI.05
        SETRANGE(Usage,Usage::"Delivery Note(Sales Invoice)");
      //HEI.04>>
      /BC Upgrade Priya<< - Code added in Cod53499
      // <<DITW110.00.08 DDR 02/01/2017 NRQ#0
      // <<DITW15.00.00.39 RBE 20/04/2011 #1230 - DITW16.00.00.40 DDR 13/02/2012 #1460 - DITW17.00.01 DDR 13/02/2013 DIT-770 #001
      ReportUsage2::"S.Order Pick":
        SETRANGE(UsageDIT,UsageDIT::"S.Order Pick");
      ReportUsage2::"S.Picking List":
        SETRANGE(UsageDIT,UsageDIT::"S.Picking List");
      ReportUsage2::"S.Shipping List":
        SETRANGE(UsageDIT,UsageDIT::"S.Shipping List");
      ReportUsage2::"Order Shipment":
        SETRANGE(UsageDIT,UsageDIT::"S.Order Shpt.");
      /// DITW17.10.05 MSF 16/09/2014 DIT-770 #925
      //<<DITW17.00.02 SR 10/21/2013 DIT-770 #155
      ReportUsage2::"S.Combined Picking":
        SETRANGE(UsageDIT,UsageDIT::"S.Comb.Pick");
      // <<DITW18.00.07 DDR 19/04/2016 DIT-770 #1488
      ReportUsage2::"S.Load List":
      // >>DITW18.00.07 DDR DIT-770 #1488
        SETRANGE(UsageDIT,UsageDIT::"S.Load List");
      //>>DITW17.00.02 SR DIT-770 #155
      // >>DITW15.00.00.39 RBE #1230 - DITW16.00.00.40 DDR #1460 - DITW17.00.01 DDR DIT-770 #001
      //>>DITW17.00.02 RPG 18/12/2013 DIT-770 #235
      ReportUsage2::"Shipment Specification":
        SETRANGE(UsageDIT,UsageDIT::"Shpt.Spec.");
      //>>DITW17.00.02 RPG DIT-770 #235
      //<<DITW17.10.03 MSF 09/07/2014 DIT-770 #542 - DITW18.00.06 MSF 29/05/2015 DIT-770 #1269
      ReportUsage2::"Return Control":
         SETRANGE(UsageDIT,UsageDIT::"Ret.Control");
      //>>DITW17.10.03 MSF 09/07/2014 DIT-770 #542 - DITW18.00.06 MSF 29/05/2015 DIT-770 #1269
      //<<FINXL7.00.001 RBE 04/06/2013 - FINXL10.00 DDR 03/02/2017 NRQ#20678
      ReportUsage2::"Pro-forma":
        SETRANGE(UsageXL,UsageXL::"Pro-Forma");
        //>>FINXL7.00.001 RBE 04/06/2013 - FINXL10.00 DDR 03/02/2017 NRQ#20678
       ReportUsage2::"Picking List By SO":
        SETRANGE(Usage,Usage::"Picking List By SO");
      /BC Upgrade Priya>> - Code added in Cod53499
      //<<HEI.06
      ReportUsage2::"Debit Note":
        SETRANGE(Usage,Usage::"Debit Note");
      //>>HEI.06
      /BC Upgrade Priya<< - Code added in Cod53499
    #39..41
    */
    //end;
    //BC Upgrade VAMSIU01 >> - DrinkIT
    local procedure SetDocSubTypeFilter();
    begin
        // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
        Rec.FILTERGROUP(2);
        Rec.FilterDocSubType(Rec."Doc Subtype Filter Table FND"::Sales);
        Rec.FILTERGROUP(0);
    end;
    //BC Upgrade VAMSIU01 << - DrinkIT

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

