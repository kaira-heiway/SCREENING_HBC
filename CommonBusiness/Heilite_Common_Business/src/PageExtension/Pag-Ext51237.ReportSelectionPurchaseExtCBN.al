pageextension 51237 ReportSelectionPurchaseExtCBN extends "Report Selection - Purchase"
{
    // version NAVW110.0,FINXL10.00,DITW110.00.08

    layout
    {
        modify(ReportUsage2)
        {
            CaptionML = ENU = 'Usage', FRA = 'Utilisation';
            ToolTipML = ENU = 'Specifies which type of document the report is used for.', FRA = 'Spécifie le type de document pour lequel l''état est utilisé.';
            //OptionCaptionML = ENU = 'Quote,Blanket Order,Order,Invoice,Return Order,Credit Memo,Receipt,Return Shipment,Purchase Document - Test,Prepayment Document - Test,P.Arch. Quote,P.Arch. Order,P. Arch. Return Order,,,,,,,,,,Shipping Agent Notice', FRA = 'Devis,Commande ouverte,Commande,Facture,Retour,Avoir,Réception,Expédition retour,Document achat - Test,Document acompte - Test,DemPrixArch.Achat,CdeArch.Achat,RetourArch.Achatr,,,,,,,,,,Avis d''expédition transporteur';

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
        addafter("Report Caption")
        {
            field("Document Subtype Code"; Rec."Document Subtype Code FND")
            {
                TableRelation = "Document Subtype Code FND".Code WHERE("Report Selection Type" = FILTER(Purchase));
                ApplicationArea = All;
            }
        }
    }

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
    //ReportUsage2 : Quote,"Blanket Order",Order,Invoice,"Return Order","Credit Memo",Receipt,"Return Shipment","Purchase Document - Test","Prepayment Document - Test","P.Arch. Quote","P.Arch. Order","P. Arch. Return Order";
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ReportUsage2 : Quote,"Blanket Order",Order,Invoice,"Return Order","Credit Memo",Receipt,"Return Shipment","Purchase Document - Test","Prepayment Document - Test","P.Arch. Quote","P.Arch. Order","P. Arch. Return Order",,,,,,,,,,"P.Ship.Agent Notice";
    //Variable type has not been exported.

    var
        _NAV2017_ReportUsage2: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo",Receipt,"Return Shipment","Purchase Document - Test","Prepayment Document - Test","P.Arch. Quote","P.Arch. Order","P. Arch. Return Order";

    var
        _XL_TEMPLATE_Usage2: Option nav_option,,,,,,,,,,dit_option,,,,,,,,,,,,,,,,,,,,xl_option;


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

    //BC UPGRADE VAMSIU01 - added >>
    trigger OnOpenPage()
    begin
        // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
        SetDocSubTypeFilter;
        // >>DITW110.00.08 DDR NRQ#20755
    end;
    //BC UPGRADE VAMSIU01 - added <<


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
        SETRANGE(Usage,Usage::"P.Quote");
    #7..27
        SETRANGE(Usage,Usage::"P.Arch. Order");
      ReportUsage2::"P. Arch. Return Order":
        SETRANGE(Usage,Usage::"P. Arch. Return Order");
    end;
    FILTERGROUP(0);
    CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    // <<DITW110.00.08 DDR 03/02/2017 NRQ#20678
    SETRANGE(Usage);
    SETRANGE(UsageDIT);
    // >>DITW110.00.08 DDR NRQ#20678
    //<<FINXL10.00 DDR 03/02/2017 NRQ#20678
    SETRANGE(UsageXL);
    //>>FINXL10.00 DDR 03/02/2017 NRQ#20678
    #4..30
      // <<DITW110.00.08 DDR 03/02/2017 NRQ#20678
      ReportUsage2::"P.Ship.Agent Notice":
        SETRANGE(UsageDIT,UsageDIT::"P.Ship.Agent Notice");
      // >>DITW110.00.08 DDR NRQ#20678
      //<<FINXL10.00 DDR 03/02/2017 NRQ#20678 later
      //ReportUsage2::"xl_option":
      //  Setrange(UsageXL,UsageXL::"xl_option");
      //>>FINXL10.00 DDR 03/02/2017 NRQ#20678
    #31..33
    */
    //end;

    local procedure SetDocSubTypeFilter();
    begin
        // <<DITW110.00.08 DDR 16/02/2017 NRQ#20755
        Rec.FILTERGROUP(2);
        Rec.FilterDocSubType(Rec."Doc Subtype Filter Table FND"::Purchase);
        Rec.FILTERGROUP(0);
    end;


}

