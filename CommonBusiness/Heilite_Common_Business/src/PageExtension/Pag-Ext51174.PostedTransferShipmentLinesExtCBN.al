pageextension 51174 PostedTransferShipLinesExtCBN extends "Posted Transfer Shipment Lines"
{
    // version NAVW110.0,DITW110.00.08


    // DITW15.00.00.37 DDR 28/05/2010 issue 480 Added Expand/Collapse functions
    // DITW15.00.00.38 DDR 16/07/2010 issue 1194 Review NAV-RTC 6.0
    //                                  Added parmater et return value for function ReadExpansionStatus()
    //                                  Remove functions FormTotalingField()
    //                                  Rewrite functions UpdateFields(),FormTotalingField()
    // DITW16.00.00.37 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    //                 DDR 30/07/2010           Remove OnFormat() field "Item No."
    //                 CEL 13/08/2010           Modification RTC buttons
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    //                                             Added 'IncludeInDataset' property global variable "ActualExpansionStatusInt"
    //                                         !!  Added IndentationColumnName property value = ActualExpansionStatusInt
    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 SR 20/09/2013 DIT-770 #180 : New Field Added after "Shipment Date" field
    // DITW17.10.03 DDR 19/05/2014 DIT-770 #541 Expand-Collapse v1.2 Web client compatibility

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // HEI.01 FDD-HT1075 CHG2039144 IBM.GUNERE01 14.01.2020 # Initialize,LookupOKOnPush funcs. added
    //                                                        OnQueryClosePage func. modified
    // HEI.02 FDD-HT1304 IBM NASTAA02 01.07.2020 # IC Transfer Order Automation
    //   # New Field added: "IC Shipment Adjusted"

    // HEI.03 CHG2084411 IBM.Ak 22.10.20
    //  # Added Field-Transfer order No.

    //Bc Upgrade YADAVM09 Drink it field and code commented.
    //Bc Upgrade YADAVM09 CreateTransferShptChargeAssgnt function called from Custom codeunit.
    //Bc Upgrade YADAVM09 function added #DocumentNoOnFormat and code added on trigger OnAfterGetRecord to make editable/uneditable Document no filed

    layout
    {

        //Unsupported feature: Change IndentationColumnName on "Control1(Control 1)". Please convert manually.


        //Unsupported feature: Change IndentationControls on "Control1(Control 1)". Please convert manually.

        modify("Document No.")
        {
            Editable = false;//Bc Upgrade YADAVM09
            HideValue = DocumentNoHideValue;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the document number associated with this transfer line.', FRA = 'Spécifie le numéro du document associé à cette ligne transfert.';

            //Unsupported feature: Change Editable on ""Document No."(Control 2)". Please convert manually.

        }
        modify("Item No.")
        {
            Editable = false;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the number of the item that will be transferred.', FRA = 'Indique le numéro de l''article qui va être transféré.';

            //Unsupported feature: Change Editable on ""Item No."(Control 4)". Please convert manually.

        }
        modify(Description)
        {
            Editable = false;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies a description of the entry.', FRA = 'Spécifie une description de l''écriture.';

            //Unsupported feature: Change Editable on "Description(Control 6)". Please convert manually.

        }
        modify(Quantity)
        {
            Editable = false;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the quantity of the item specified on the line.', FRA = 'Spécifie la quantité de l''article spécifié sur la ligne.';

            //Unsupported feature: Change Editable on "Quantity(Control 8)". Please convert manually.

        }
        modify("Unit of Measure")
        {
            Editable = false;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the unit of measure code of the item.', FRA = 'Spécifie le code unité de l''article.';

            //Unsupported feature: Change Editable on ""Unit of Measure"(Control 10)". Please convert manually.

        }
        modify("Shipment Date")
        {
            Editable = false;//Bc Upgrade YADAVM09
            ToolTipML = ENU = 'Specifies the shipment date of the transfer shipment line.', FRA = 'Spécifie la date d''expédition de la ligne expédition transfert.';

            //Unsupported feature: Change Editable on ""Shipment Date"(Control 12)". Please convert manually.

        }
        addfirst(Control1)
        {
            /* //Bc Upgrade YADAVM09 Drink it field commented>>
            field("Has Item Charge"; Rec."Has Item Charge")
            {
                BlankZero = true;
            }
            field(Collapse; Rec.Collapse)
            {
                Visible = false;

                trigger OnValidate();
                begin
                    // <<DITW15.00.00.37 DDR 19/01/2010
                    CurrPage.UPDATE(true);
                    // >>DITW15.00.00.37 DDR
                end;
            }
            */ //Bc Upgrade YADAVM09 Drink it field commented<<
            field("Line No."; Rec."Line No.")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Line No. field.';
            }
        }
        /* //Bc Upgrade Drink it field Commented>>
        addafter("Item No.")
        {
            field("Item Charge No."; Rec."Item Charge No.")
            {
                Editable = false;
            }
        }
        */ //Bc Upgrade Drink it field Commented<<
        addafter("Shipment Date")
        {
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gross Weight field.';
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Weight field.';
            }
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity (Base) field.';
            }
            /* //Bc Upgrade YADAVM09 Drink it field Commented>>
            field("Line Amount"; Rec."Line Amount")
            {
            }
            field(RTCTotalLine; Rec.GetTotalingLine(1, FIELDNO(Rec."Line Amount"), true))
            {
                AutoFormatType = 1;
                BlankZero = true;
                CaptionML = ENU = 'Total Line Amount',
                            FRA = 'Montant total ligne';
                Description = 'DITW17.10.02B DIT-770 #541';
                Editable = false;
                QuickEntry = false;
            }
            field("Unit Volume HL"; Rec."Unit Volume HL")
            {
            }
            */ //Bc Upgrade YADAVM09 Drink it field Commented<<

            field("Transfer-from Code"; Rec."Transfer-from Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer-from Code field.';
            }
            field("Transfer-to Code"; Rec."Transfer-to Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer-to Code field.';
            }
            /* //Bc Upgrade YADAVM09 Drink it field commented>>
            field("Posting Date"; Rec."Posting Date")
            {
            }
            field("External Document No."; Rec."External Document No.")
            {
            }
             */ //Bc Upgrade YADAVM09 Drink it field commented<<

            field("IC Shipment Adjusted"; Rec."IC Shipment Adjusted FND")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the IC Shipment Adjusted field.';
            }
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer Order No. field.';
            }
        }
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }

        modify(Dimensions)
        {
            CaptionML = ENU = 'Dimensions', FRA = 'Axes analytiques';
            ToolTipML = ENU = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.', FRA = 'Affichez ou modifiez les axes analytiques, tels que la zone, le projet ou le département que vous pouvez affecter aux documents vente et achat afin de distribuer les coûts et analyser l''historique des transactions.';
        }

        /* //Bc Upgrade YADAVM09 Drink it action Commented>>
        addfirst("&Line")
        {
            action("+ Expand")
            {
                CaptionML = ENU = '+ Expand',
                            FRA = '+ Développer';
                Enabled = (NOT ExpandLines);
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = (NOT ExpandLines) OR ShowButtonsCE;

                trigger OnAction();
                begin
                    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                    ExpandLines := true;
                    CurrPage.UPDATE(true);
                    // >>DITW17.10.03 DDR DIT-770 #541
                end;
            }
            action("- Collapse")
            {
                CaptionML = ENU = '- Collapse',
                            FRA = '- Réduire';
                Enabled = ExpandLines;
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ExpandLines OR ShowButtonsCE;

                trigger OnAction();
                begin
                    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
                    ExpandLines := GETFILTER("Attached to Line No.") <> '';
                    CurrPage.UPDATE(true);
                    // >>DITW17.10.03 DDR DIT-770 #541
                end;
            }
        }
        */ //Bc Upgrade YADAVM09 Drink it action Commented<<
    }
    //Bc Upgrade YADAVM09>>
    trigger OnAfterGetRecord()
    begin
        DocumentNoHideValue := FALSE;
        DocumentNoOnFormat();
    end;
    //Bc Upgrade YADAVM09<<

    local procedure DocumentNoOnFormat()
    begin
        //Bc Upgrade YADAVM09>>
        if not IsFirstLine(Rec."Document No.", Rec."Line No.") then
            DocumentNoHideValue := true;
        //Bc Upgrade YADAVM09<<
    end;

    local procedure IsFirstLine(DocNo: Code[20]; LineNo: Integer): Boolean
    var
        TempTransShptLine: Record "Transfer Shipment Line" temporary;
        TransShptLine: Record "Transfer Shipment Line";
    begin
        TempTransShptLine.Reset();
        TempTransShptLine.CopyFilters(Rec);
        TempTransShptLine.SetRange("Document No.", DocNo);
        if not TempTransShptLine.FindFirst() then begin
            TransShptLine.CopyFilters(Rec);
            TransShptLine.SetRange("Document No.", DocNo);
            TransShptLine.FindFirst();
            TempTransShptLine := TransShptLine;
            TempTransShptLine.Insert();
        end;
        if TempTransShptLine."Line No." = LineNo then
            exit(true);
    end;

    var

        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        FromTransShptLine: Record "Transfer Shipment Line";
        AssignItemChargePurch: Codeunit "Item Charge Assgnt. (Purch.)";
        CreateCostDistrib: Boolean;
        DocumentNoHideValue: Boolean;
        ExpandLines: Boolean;

        ShowButtonsCE: Boolean;
        UnitCost: Decimal;
        IndentLine: Integer;


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
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
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
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    exit(NextRecordDIT(Steps,ExpandLines));
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //begin
    /*
    // <<DITW17.10.03 DDR 12/03/2014 DIT-770 #541
    ExpandLines := GETFILTER("Attached to Line No.") <> '';
    ShowButtonsCE := IsShowButtonsCEDIT();
    // >>DITW17.10.03 DDR DIT-770 #541
    */
    //end;


    //Unsupported feature: CodeInsertion on "OnQueryClosePage". Please convert manually.

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        //>> HEI.01
        if CloseAction = ACTION::LookupOK then
            LookupOKOnPush();
        //<< HEI.01  
    end;

    procedure Initialize(NewItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)"; NewUnitCost: Decimal);
    begin
        //>> HEI.01
        ItemChargeAssgntPurch := NewItemChargeAssgntPurch;
        UnitCost := NewUnitCost;
        CreateCostDistrib := true;
        //<< HEI.01
    end;

    local procedure LookupOKOnPush();
    var
        AssignItemChargePurch: Codeunit "Heineken BC Upgrade";
    begin
        //>> HEI.01
        if CreateCostDistrib then begin
            FromTransShptLine.COPY(Rec);
            CurrPage.SETSELECTIONFILTER(FromTransShptLine);
            if FromTransShptLine.FINDFIRST() then begin
                ItemChargeAssgntPurch."Unit Cost" := UnitCost;
                AssignItemChargePurch.CreateTransferShptChargeAssgnt(FromTransShptLine, ItemChargeAssgntPurch);
            end;
        end;
        //<< HEI.01
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

