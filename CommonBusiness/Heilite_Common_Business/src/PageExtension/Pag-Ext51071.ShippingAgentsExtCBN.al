pageextension 51071 ShippingAgentsExtCBN extends "Shipping Agents"
{
    //     DITW15.00.00.21 DDR 18/06/2008 Added columns Vendor No.,Contact No.
    //                                Added functions GetSelectionFilter(),SetSelection()
    //                                Added button "Purchases" & menu "Prices"
    // DITW15.00.00.28 DDR 26/11/2008 Added menu "Card" into button "Line"
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields "Shipping Currency Code"
    // DITW15.00.00.38 DDR 23/12/2010 issue 1217 (DIT711 106) Added fields "Language Code"
    // DITW15.00.00.38 DDR 25/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                  Added fields into tab 'Invoicing'
    //                                    "Vendor No.","Vendor Currency Code"
    //                                  Added fields into tab Drink-It
    //                                    "Transport Arranger",
    //                                    "Consignor Guarantee","Transporter Guarantee",
    //                                    "Owner Guarantee","Consignee Guarantee"
    // DITW16.00.00.38 DDR 25/02/2011 DIT-715 #1 RTC Page functionnalities
    // DITW16.00.00.40 DDR 12/06/2012 DIT-715 #334 Added fields "First Transporter Trader" (Drink-It tab)
    // DITW16.00.00.42 AHU 11/02/2013 DIT-715 #404 Added all missing DIT fields (issue DIT-712 #1217, DIT-715 #334)
    // DITW18.00.06 MSF 13/05/2015 DIT-770 #1212 #1213 #1214 Added Fields "Responsibility Center" AND "Physical location group code"
    // DITW18.00.06 MSF 26/06/2015 DIT-770 #1212 #1213 #1214 Delete Fields "Physical location group code"

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 MSF 07/07/2017 NRQ#16224 Return Registration part 3
    //                                  Added fields : "Customer No."
    // HEI.01 CHG0255774_FDD_TC_Calculation_Enhancement IBM NANDIS01 08.07.2019
    //   New field shown in page - "Own Logistics"
    // HEI.02 FDD-HT678, HT679 IBM SURYAS01 22.08.2019
    //   #Added New Field - "Auto Mail on release Order"

    layout
    {
        modify("Code")
        {
            ToolTipML = ENU = 'Specifies a shipping agent code.', FRA = 'Spécifie un code transporteur.';
        }
        modify(Name)
        {
            ToolTipML = ENU = 'Specifies a description of the shipping agent.', FRA = 'Spécifie une description du transporteur.';
        }
        modify("Internet Address")
        {
            ToolTipML = ENU = 'Specifies an Internet address for the shipping agent.', FRA = 'Spécifie une adresse Internet du transporteur.';
        }
        modify("Account No.")
        {
            ToolTipML = ENU = 'Specifies the account number that the shipping agent has assigned to your company.', FRA = 'Spécifie le numéro du compte affecté à votre société par le transporteur.';
        }
        // addafter("Account No.")
        // {
        //     field("Language Code"; Rec."Language Code")
        //     {
        //     }
        //     field("Own Logistics"; Rec."Own Logistics")
        //     {
        //     }
        //     field("Vendor No."; Rec."Vendor No.")
        //     {
        //     }
        //     field("Vendor Currency Code"; Rec."Vendor Currency Code")
        //     {
        //         DrillDown = false;
        //     }
        //     field("Customer No."; Rec."Customer No.")
        //     {
        //     }
        //     field("Contact No."; Rec."Contact No.")
        //     {
        //     }
        //     field("Transport Arranger Type"; Rec."Transport Arranger Type")
        //     {
        //     }
        //     field("First Transporter Trader"; Rec."First Transporter Trader")
        //     {
        //     }
        //     field("Consignor Guarantee"; Rec."Consignor Guarantee")
        //     {
        //     }
        //     field("Transporter Guarantee"; Rec."Transporter Guarantee")
        //     {
        //     }
        //     field("Owner Guarantee"; Rec."Owner Guarantee")
        //     {
        //     }
        //     field("Consignee Guarantee"; Rec."Consignee Guarantee")
        //     {
        //     }
        //     field(LanguageCode; Rec."Language Code")
        //     {
        //     }
        //     field("VAT Registration No."; Rec."VAT Registration No.")
        //     {
        //     }
        //     field("Responsibility Center"; Rec."Responsibility Center")
        //     {
        //     }
        //     field("Auto Mail on release Order"; Rec."Auto Mail on release Order")
        //     {
        //     }
        // }//BC Upgrade SHARMP16 drink-it fields
        //BC UPGRADE KUMARR78 ++19-05-2026 >>
        addafter("Transport Arrangement 113FDW")
        {
            field("Vendor No. 20 FDW"; Rec."Vendor No. 20 FDW")
            {
                ApplicationArea = all;
                Caption = 'Vendor No.';
            }
            field("Consignor Guarantee 113FDW"; Rec."Consignor Guarantee 113FDW")
            {
                ApplicationArea = all;
            }
            //'Trans. Validation Type 108FDW' is already defined in PageExtension 'ShippingAgents108FDW' by the extension 'Aptean Beverage Advanced Warehouse Management for Drink-IT Edition by Aptean (2602.0.312442.0)'.
            // field("Trans. Validation Type 108FDW"; Rec."Trans. Validation Type 108FDW")
            // {
            //     ApplicationArea = all;
            // }
        }
        //BC UPGRADE KUMARR78 ++19-05-2026 <<
    }
    actions
    {
        modify("&Line")
        {
            CaptionML = ENU = '&Line', FRA = '&Ligne';
        }
        modify(ShippingAgentServices)
        {
            CaptionML = ENU = 'Shipping A&gent Services', FRA = '&Prestations transporteur';
            ToolTipML = ENU = 'View the types of services that your shipping agent can offer you and their shipping time.', FRA = 'Affichez les types de services que votre transporteur est en mesure de vous proposer et leur délai d''expédition.';
        }
        addafter("&Line")
        {
            // group("&Purchases")
            // {
            //     CaptionML = ENU = '&Purchases',
            //                 FRA = 'Ac&hats';
            //     action("&Prices")
            //     {
            //         CaptionML = ENU = '&Prices',
            //                     FRA = 'Pri&x';
            //         Image = ResourcePrice;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         RunObject = Page "Shipping Agent Purch. Prices";
            //         RunPageLink = "Shipping Agent Code" = FIELD(Code);
            //     }
            // }//BC Upgrade SHARMP16 drink-it 
        }
    }

    procedure GetSelectionFilter(): Code[80];
    var
        ShippingAgent: Record "Shipping Agent";
        More: Boolean;
        FirstAgent: Code[30];
        LastAgent: Code[30];
        SelectionFilter: Code[250];
        AgentCount: Integer;
    begin
        // <<HITW15.00.00.21 DDR 30/06/2008
        CurrPage.SETSELECTIONFILTER(ShippingAgent);
        AgentCount := ShippingAgent.COUNT;
        if AgentCount > 0 then begin
            ShippingAgent.FIND('-');
            while AgentCount > 0 do begin
                AgentCount := AgentCount - 1;
                ShippingAgent.MARKEDONLY(false);
                FirstAgent := ShippingAgent.Code;
                LastAgent := FirstAgent;
                More := (AgentCount > 0);
                while More do
                    if ShippingAgent.NEXT() = 0 then
                        More := false
                    else
                        if not ShippingAgent.MARK() then
                            More := false
                        else begin
                            LastAgent := ShippingAgent.Code;
                            AgentCount := AgentCount - 1;
                            if AgentCount = 0 then
                                More := false;
                        end;
                if SelectionFilter <> '' then
                    SelectionFilter := SelectionFilter + '|';
                if FirstAgent = LastAgent then
                    SelectionFilter := SelectionFilter + FirstAgent
                else
                    SelectionFilter := SelectionFilter + FirstAgent + '..' + LastAgent;
                if AgentCount > 0 then begin
                    ShippingAgent.MARKEDONLY(true);
                    ShippingAgent.NEXT();
                end;
            end;
        end;
        exit(SelectionFilter);
    end;

    procedure SetSelection(var NewShippingAgent: Record "Shipping Agent");
    begin
        // <<HITW15.00.00.21 DDR 30/06/2008
        CurrPage.SETSELECTIONFILTER(NewShippingAgent);
    end;

    //Unsupported feature: InsertAfter on "Documentation". Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.


    //Unsupported feature: PropertyChange. Please convert manually.

}

