page 53014 "Gate Entry Inbound List"
{
    // version HEI.03
    //BC Upgrade GUNREM01 Old page ID-50233

    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0
    // HEI.02 Defect #3268 IBM NASTAA02 17.10.2018 # Missing field zone on gate entry forms
    //   # Added Field "Zone Code"
    // HEI.03 Bugfixing RW IBM NASTAA02 22.10.2018 # Bugfixing Gate Entry RW
    //   # "Weight Difference" should be compared with setup as percentage

    //BC Upgrade GUNREM01 - changed the page calling process, In nav calling with Pag IDs, but in BC if use the Page IDs, if the page isnnot there it not through any error.

    CaptionML = ENU = 'Gate Entry Inbound',
                FRA = 'Gate Entry Inbound';
    CardPageID = "Gate Entry Inbound";
    Editable = false;
    PageType = List;
    SourceTable = "Gate Entry Header FND";
    SourceTableView = SORTING("Gate Entry Document No.")
                      WHERE("Gate Entry Type" = FILTER(Inbound),
                            Registered = FILTER(false));
    ApplicationArea = all;
    UsageCategory = Lists;//BC UPGRDAE KUMARR78 FDD-MTC-007


    layout
    {
        area(content)
        {
            repeater(Control1000000000)

            {
                ShowCaption = false; //BC Upgrade GUNREN01
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = all;
                }
                field("Gate Entry Document No."; Rec."Gate Entry Document No.")
                {
                    ApplicationArea = all;
                }
                field("Gate Entry Type"; Rec."Gate Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Gate Keeper ID"; Rec."Gate Keeper ID")
                {
                    ApplicationArea = all;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Driver Code"; Rec."Driver Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date In"; Rec."Date In")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Date Out"; Rec."Date Out")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Weight Difference"; Rec."Weight Difference")
                {
                    ApplicationArea = all;
                    StyleExpr = WeightDifferenceStyle;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1100710001; Links)
            {
                Visible = false;
            }
            systempart(Control1100710000; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Gate Entry")
            {
                Caption = 'Gate Entry';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ApplicationArea = all;

                    trigger OnAction();
                    begin
                        if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Inbound) and (Rec.Registered = false) then
                            // PAGE.RUNMODAL(50224, Rec);
                            Page.RunModal(Page::"Gate Entry Inbound", Rec); //BC Upgrade GUNREM01 changed the page calling process, In nav calling with Pag IDs, but in BC if use the Page IDs, if the page isnnot there it not through any error.
                        if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Inbound) and (Rec.Registered = true) then
                            // PAGE.RUNMODAL(50222, Rec);
                            Page.RunModal(Page::"Registered Gate Entry", Rec);//BC Upgrade GUNREM01 changed the page calling process, In nav calling with Pag IDs, but in BC if use the Page IDs, if the page isnnot there it not through any error.

                        if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Outbound) and (Rec.Registered = false) then
                            // PAGE.RUNMODAL(50225, Rec);
                             PAGE.RUNMODAL(Page::"Gate Entry Outbound", Rec);//BC Upgrade GUNREM01 changed the page calling process, In nav calling with Pag IDs, but in BC if use the Page IDs, if the page isnnot there it not through any error.

                        if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Outbound) and (Rec.Registered = true) then
                            //  PAGE.RUNMODAL(50222, Rec);
                            Page.RunModal(Page::"Registered Gate Entry", Rec);//BC Upgrade GUNREM01 changed the page calling process, In nav calling with Pag IDs, but in BC if use the Page IDs, if the page isnnot there it not through any error.

                        if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Service) and (Rec.Registered = false) then
                            // PAGE.RUNMODAL(50226, Rec);
                            Page.RunModal(Page::"Gate Entry Service", Rec);//BC Upgrade GUNREM01 changed the page calling process, In nav calling with Pag IDs, but in BC if use the Page IDs, if the page isnnot there it not through any error.

                        if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Service) and (Rec.Registered = true) then
                            //  PAGE.RUNMODAL(50222, Rec);
                            Page.RunModal(Page::"Registered Gate Entry", Rec);//BC Upgrade GUNREM01 changed the page calling process, In nav calling with Pag IDs, but in BC if use the Page IDs, if the page isnnot there it not through any error.

                        if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Stay) and (Rec.Registered = false) then
                            //  PAGE.RUNMODAL(50227, Rec);
                            Page.RunModal(Page::"Gate Entry Stay", Rec);//BC Upgrade GUNREM01 changed the page calling process, In nav calling with Pag IDs, but in BC if use the Page IDs, if the page isnnot there it not through any error.

                        if (Rec."Gate Entry Type" = Rec."Gate Entry Type"::Stay) and (Rec.Registered = true) then
                            //  PAGE.RUNMODAL(50222, Rec);
                            Page.RunModal(Page::"Registered Gate Entry", Rec);//BC Upgrade GUNREM01 changed the page calling process, In nav calling with Pag IDs, but in BC if use the Page IDs, if the page isnnot there it not through any error.

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        WarehouseSetup.GET;
        //IF "Weight Difference" <= WarehouseSetup."Gate Entry Weight Tolerance %" THEN //HEI.03
        if Rec.CheckTolerance then //HEI.03
            WeightDifferenceStyle := FavorableStyle
        else
            WeightDifferenceStyle := UnFavorableStyle;
    end;

    var
        //[InDataSet]
        WeightDifferenceStyle: Text;
        FavorableStyle: Label 'Favorable';
        UnFavorableStyle: Label 'Unfavorable';
}

