

pageextension 52017 GetReceiptLinesExt extends "Get Receipt Lines"
{

    // version NAVW110.0,FINXL8.00.001,DITW110.00.08,HEI.02
    //BC UPGRADE SIVA Old Page ID 5709

    //  DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Item Charges functionnalities
    //                                  Remove Editable=No on Form (and All fields non-editable except Collapse button)
    //   DITW15.00.00.01 DDR 14/01/2008 Bugfix Navision REC into Button OK because using UPDATECONTROLS on AfterGetCurrRecord trigger
    //                                  Changed properties InsertAllowed,ModifyAllowed,DeleteAllowed=No (because Form Editable=No)
    //   DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    //   DITW15.00.00.19 DDR 04/04/2008 Certification rules
    //   DITW15.00.00.21 DDR 08/07/2008 Bugfix refresh & show CExpandCollapse column
    //   DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                    Added parmater et return value for function ReadExpansionStatus()
    //                                    Remove functions FormTotalingField()
    //                                    Rewrite functions UpdateFields(),FormTotalingField()
    //   DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                   DDR 30/07/2010           Remove OnFormat() field "No."
    //                   CEL 13/08/2010           Modification RTC buttons
    //                   DDR 18/08/2010 DIT717 #13 Added to keep open filters with expand-collapse (ShowAsTree in page)
    //   DITW15.00.00.38 DDR 10/12/2010 issue 1122 Modified button LookupOK -> OK + Hide if form not lookup mode
    //   DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                               Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //   DITW16.00.00.38 DDR 03/03/2011 DIT-715 #62 RTC Page functionnalities
    //                                               Modified function IsFirstDocLine() in relation to new form workflow
    //   DITW16.00.00.39 DDR 18/07/2011 DIT-715 #62 Modified Button OK
    //                                              Removed 'ModifyAllowed' form property
    //                       04/08/2011 DIT-715 #141 RTC Upgrade Added/Review Total Line Amount (Collapsed RTC)
    //                                                           Added functions UpdateFormatField()
    //                       26/09/2011 DIT-715 #141 Modified to show Total Amount column for all line types
    //   DITW16.00.00.42 DDR 14/12/2012 DIT-715 #377 Disabled creation of selected lines
    //                                               Modified property controls OK & Cancel

    //   FINXL7.00.001 RBE 20/03/2013 : Added field "Order No." on page
    //   FINXL8.00.001 BSA 11/06/2015 #115: Addded fied "Cross ref", "Vendor Item No"

    //   DITW17.00.02 DDR 12/07/2013 DIT-770 #94 Removed Expand/Collapse on List (Nav function SETSELECTIONFILTER() is not working)
    //   DITW17.00.02 AT  26/09/2013 DIT-770 #149 Merge HIT124
    //                               New flowfelds Document Date, Order No. and Vendor Shipment No.
    //   DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //   DITW17.10.03 DDR 07/03/2014 DIT-770 #532 Bugfix Lookup page and return action page
    //   DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility
    //   DITW17.10.04 DDR 07/08/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 MSF 11/11/2014 DIT-770 #654 NORRIQ XL - W1 CFMD R1
    //   DITW17.10.04 AKH 20/11/2014 DIT-770 #654 Removed empty field on page
    //                                            Moved the field "Order No." to the repeater
    //   DITW17.10.04 AKH 19/12/2014 DIT-770 #1022 Merge DIT W1 R4 in R5

    //   DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    //   HEI.01 FDD-PTPGAP063 IBM.HORTOC01 12.07.2017
    //     # Move fields "Vendor Shipment No." and "Order No." from page header to lines
    //   HEI.02 BA-RTRGAP01 IBM NASTAA02 16.08.2018 # Bahamas VAT
    //     # New Field added - "TIN No."
    //   HEI.03 FDD-HT658 IBM.GUNERE01 23.09.2019 # "Description 2" field added
    //   HEI.04 FDD-HB1034 CHG2042112 IBM SHANKJ03 02.07.2020
    //   HEI.05 FDD-HB1989 - CHG2095531 IBM NANDIS01 09.02.2021 - Due Date Update
    //     # Changed the text constant value of Text000

    //********************************//
    //BC UPGRADE SIVA 20/01/2026
    // SUMMARY OF CHANGES:
    //1.HEI.01 Vendor Shipment No. Drink it field , Order No. Added page layout.
    //2.HEI.02 Added TIN No. in page layout.
    //3.HEI.03 "Description 2 already field is exist in base app hence no need add.
    //4.HEI.04 Added Custom code in Page_OnQueryClosePage trigger 
    //5.HEI.05 No changes.
    //********************************//
    //BC UPGRADE ATHUKUS01 FDDSTP_007 <<
    //1.Code added in OnQueryClosePage trigger.
    //BC UPGRADE ATHUKUS01 FDDSTP_007 >>

    layout
    {
        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            StyleExpr = "Document No.Emphasize";
        }
        //BC UPGRADE SIVA >> Drink IT fields
        // addfirst(Control1900000001)
        // {
        //     group(Options)
        //     {
        //         CaptionML = ENU = 'Options',
        //                     FRA = 'Options';
        //         Description = 'DITW17.00.02 DDR 12/07/2013 DIT-770 #94';
        //         field("Document Date"; Rec."Document Date")
        //         {
        //             Description = 'DITW17.00.02 DIT-770 #149';
        //             Editable = false;
        //             HideValue = DocumentNoHideValue;
        //             Style = Strong;
        //             StyleExpr = "Document No.Emphasize";
        //         }
        //     }
        // }
        // addfirst(Control1)
        // {
        //     field("Has Item Charge"; rec."Has Item Charge")
        //     {
        //         BlankZero = true;
        //     }
        // }
        //BC UPGRADE SIVA << Drink IT fields

        // BC UPGRADE SIVA >> In base layout already filed is existed page layout 
        // addafter(Description)
        // {
        //     field("Description 2"; rec."Description 2")
        //     {
        //         Visible = false;
        //     }
        // }
        // BC UPGRADE SIVA << In base layout already filed is existed

        addafter("Qty. Rcd. Not Invoiced")
        {
            //BC UPGRADE SIVA >> Drink it fields 

            // field("Line Amount"; rec."Line Amount")
            // {
            //     BlankZero = true;
            //     Description = 'DITW16.00.00.37-0.39 DIT-715 #141';
            //     Visible = false;
            // }
            // field(RTCTotalLine; GetTotalingLine(1, FIELDNO("Line Amount"), true))
            // {
            //     AutoFormatExpression = GetCurrencyCodeFromHeader;
            //     AutoFormatType = 1;
            //     BlankZero = true;
            //     CaptionClass = GetCaptionClassVar(PageText2014410);
            //     CaptionML = ENU = 'Total Line Amount',
            //                 FRA = 'Montant total ligne';
            //     Description = 'DITW17.10.02B DIT-770 #541';
            //     QuickEntry = false;
            //     Visible = false;
            // }
            // field("Cross-Reference No."; rec."Cross-Reference No.")
            // {
            // }
            // field("Vendor Item No."; rec."Vendor Item No.")
            // {
            // }
            // field("Vendor Shipment No."; rec."Vendor Shipment No.")
            // {
            //     Description = 'DITW17.00.02 DIT-770 #149';
            //     Editable = false;
            //     HideValue = DocumentNoHideValue;
            //     Style = Strong;
            //     StyleExpr = "Document No.Emphasize";
            // }
            //BC UPGRADE SIVA<< Drink it fields

            field("Order No."; rec."Order No.")
            {
                ApplicationArea = all;
                ToolTip = 'Order No.';
                Description = 'FINXL7.00.001-DITW17.00.02 DIT-770 #149';
                Editable = false;
                HideValue = DocumentNoHideValue;
                Style = Strong;
                StyleExpr = "Document No.Emphasize";
            }
            field("TIN No."; rec."TIN No. FND")
            {
                ToolTip = 'TIN No.';
                ApplicationArea = all;


            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify("Show Document")
        {
            CaptionML = ENU = 'Show Document', FRA = 'Afficher document';
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }
        modify("Item &Tracking Entries")
        {
            CaptionML = ENU = 'Item &Tracking Entries', FRA = '&Ecritures traçabilité';
        }
        addfirst("&Line")
        {
            //BC UPGRADE SIVA >> Drink IT actions
            // action("+ Expand")
            // {
            //     CaptionML = ENU = '+ Expand',
            //                 FRA = '+ Développer';
            //     Enabled = (NOT ExpandLines);
            //     Image = ViewDetails;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = (NOT ExpandLines) OR ShowButtonsCE;

            //     trigger OnAction();
            //     begin
            //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
            //         ExpandLines := true;
            //         CurrPage.UPDATE(true);
            //         // >>DITW17.10.03 DDR DIT-770 #541
            //     end;
            // }
            // action("- Collapse")
            // {
            //     CaptionML = ENU = '- Collapse',
            //                 FRA = '- Réduire';
            //     Enabled = ExpandLines;
            //     Image = ViewDetails;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     Visible = ExpandLines OR ShowButtonsCE;

            //     trigger OnAction();
            //     begin
            //         // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
            //         ExpandLines := GETFILTER("Attached to Line No.") <> '';
            //         CurrPage.UPDATE(true);
            //         // >>DITW17.10.03 DDR DIT-770 #541
            //     end;
            //BC UPGRADE SIVA << Drink IT actions
        }
    }


    var
        CloseActionOk: Boolean;
        PageText2014410: TextConst ENU = 'Total Line Amount', FRA = 'Montant total ligne';

        "Document No.Emphasize": Boolean;

        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        IndentLine: Integer;
        PurchLineRec: Record "Purchase Line";
        PurchRcptLineRec: Record "Purch. Rcpt. Line";
        PurchRcptLineRec_V1: Record "Purch. Rcpt. Line";
        PurchHdrRec: Record "Purchase Header";
        PurchHdrRec_V1: Record "Purchase Header";
        Position: Integer;
        Text000: Label 'You cannot create lines from the current receipt %1, because of different payment terms';
        PaytCode: Code[30];
        Text001: Label 'Receipts cannot be combined into one invoice because the payment terms do not match.';


    //Unsupported feature: CodeModification on "OnAfterGetRecord". Please convert manually.

    //trigger OnAfterGetRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentNoHideValue := false;
    DocumentNoOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 05/05/2014 DIT-770 #541
    IndentLine := IndentRecordDIT(ExpandLines);
    // >>DITW17.10.03 DDR DIT-770 #541

    DocumentNoHideValue := false;
    DocumentNoOnFormat;
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnFindRecord". Please convert manually.

    //trigger OnFindRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW17.00.02 DDR 12/07/2013 DIT-770 #94
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    exit(FindRecordDIT(Which,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnNextRecord". Please convert manually.

    //trigger OnNextRecord();
    //Parameters and return type have not been exported.
    //begin
    /*
    // <<DITW17.00.02 DDR 12/07/2013 DIT-770 #94
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    exit(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeModification on "OnQueryClosePage". Please convert manually.

    //trigger OnQueryClosePage(CloseAction : Action) : Boolean;
    //>>>> ORIGINAL CODE:
    //begin
    /*
    if CloseAction in [ACTION::OK,ACTION::LookupOK] then
      CreateLines;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // <<DITW17.10.03 DDR 07/03/2014 DIT-770 #532
    // <<DITW16.00.00.39 DDR 18/07/2011  DIT-715 #62 - DITW16.00.00.42 DDR 14/12/2012 DIT-715 #377
    //IF CloseAction IN [ACTION::OK,ACTION::LookupOK] THEN
    //  CreateLines;

    if CloseAction in [ACTION::OK,ACTION::LookupOK] then begin
        LookupOKOnPush;
    // >>DITW17.10.03 DDR DIT-770 #532
    // HEI.04 >>
    CLEAR(PaytCode);
    PurchRcptLineRec.RESET;
    CurrPage.SETSELECTIONFILTER(Rec);
    PurchRcptLineRec.COPY(Rec);
    PurchRcptLineRec_V1.COPY(Rec);
    // Checking Payment terms code for the receipts selected
    if PurchRcptLineRec_V1.FINDSET then begin
      repeat
        PurchHdrRec_V1.RESET;
        if PurchHdrRec_V1.GET(1,PurchRcptLineRec_V1."Order No.") then begin
          if (PaytCode = '') then
            PaytCode := PurchHdrRec_V1."Payment Terms Code"
           else if (PaytCode <> PurchHdrRec_V1."Payment Terms Code") then
            ERROR(Text001);
        end;
      until PurchRcptLineRec_V1.NEXT = 0;
    end;

    //Checking payment terms code if already any receipt is used in purchase line
    if PurchRcptLineRec.FINDSET then begin
      repeat
        PurchLineRec.RESET;
        PurchLineRec.SETRANGE("Document Type",PurchHeader."Document Type");
        PurchLineRec.SETRANGE("Document No.",PurchHeader."No.");
        if PurchLineRec.FINDSET then begin
          repeat
            Position := 0;
            Position := STRPOS(PurchLineRec.Description,PurchRcptLineRec."Document No.");
            if Position = 0 then begin
              PurchHdrRec.RESET;
              if PurchHdrRec.GET(1,PurchRcptLineRec."Order No.") then begin
                if PurchHeader."Payment Terms Code" <> PurchHdrRec."Payment Terms Code" then
                  ERROR(Text000,PurchRcptLineRec."Document No.");
              end;
            end;
          until PurchLineRec.NEXT = 0;
        end;
      until PurchRcptLineRec.NEXT = 0;
    end;
    // HEI.04 <<
    end;
    */
    //end;


    //Unsupported feature: CodeModification on "CreateLines(PROCEDURE 19031339)". Please convert manually.

    //procedure CreateLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrPage.SETSELECTIONFILTER(Rec);
    GetReceipts.SetPurchHeader(PurchHeader);
    GetReceipts.CreateInvLines(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    // DITW17.10.03 DDR 07/03/2014 DIT-770 #532 remove LOCAL parameter
    #1..3
    */
    //end;

    local procedure LookupOKOnPush();
    begin
        //CloseActionOk := true; //BC UPGRADE SIVA
        // DITW15.00.00.01 DDR 14/01/2008 - DITW16.00.00.39 DDR 18/07/2011  DIT-715 #62
        // using standard Nav W1 6.0 function CreateLines()
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN BEGIN
            // LookupOKOnPush;
            // >>DITW17.10.03 DDR DIT-770 #532
            CreateLines;
            // HEI.04 >>
            CLEAR(PaytCode);
            PurchRcptLineRec.RESET();
            CurrPage.SETSELECTIONFILTER(Rec);
            PurchRcptLineRec.COPY(Rec);
            PurchRcptLineRec_V1.COPY(Rec);
            // Checking Payment terms code for the receipts selected
            IF PurchRcptLineRec_V1.FINDSET() THEN BEGIN
                REPEAT
                    PurchHdrRec_V1.RESET();
                    IF PurchHdrRec_V1.GET(1, PurchRcptLineRec_V1."Order No.") THEN BEGIN
                        IF (PaytCode = '') THEN
                            PaytCode := PurchHdrRec_V1."Payment Terms Code"
                        ELSE IF (PaytCode <> PurchHdrRec_V1."Payment Terms Code") THEN
                            ERROR(Text001);
                    END;
                UNTIL PurchRcptLineRec_V1.NEXT() = 0;
            END;

            //Checking payment terms code if already any receipt is used in purchase line
            IF PurchRcptLineRec.FINDSET() THEN BEGIN
                REPEAT
                    PurchLineRec.RESET();
                    PurchLineRec.SETRANGE("Document Type", PurchHeader."Document Type");
                    PurchLineRec.SETRANGE("Document No.", PurchHeader."No.");
                    PurchLineRec.SetFilter("Receipt No.", '<>%1', PurchRcptLineRec."Document No.");
                    PurchLineRec.SetFilter("Receipt Line No.", '<>%1', PurchRcptLineRec."Line No.");
                    IF PurchLineRec.FINDSET THEN BEGIN
                        REPEAT
                            Position := 0;
                            Position := STRPOS(PurchLineRec.Description, PurchRcptLineRec."Document No.");
                            IF Position = 0 THEN BEGIN
                                PurchHdrRec.RESET;
                                IF PurchHdrRec.GET(1, PurchRcptLineRec."Order No.") THEN BEGIN
                                    IF PurchHeader."Payment Terms Code" <> PurchHdrRec."Payment Terms Code" THEN
                                        ERROR(Text000, PurchRcptLineRec."Document No.");
                                END;
                            END;
                        UNTIL PurchLineRec.NEXT() = 0;
                    END;
                UNTIL PurchRcptLineRec.NEXT() = 0;
            END;
            // HEI.04 <<
        end;
        //BC UPGRADE ATHUKUS01 FDDSTP_007 <<
    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_007 >>
    procedure CreateLines()
    var
        GetReceipts: Codeunit "Purch.-Get Receipt";
    begin
        CurrPage.SetSelectionFilter(Rec);
        GetReceipts.SetPurchHeader(PurchHeader);
        GetReceipts.CreateInvLines(Rec);
    end;
    //BC UPGRADE ATHUKUS01 FDDSTP_007 <<

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}