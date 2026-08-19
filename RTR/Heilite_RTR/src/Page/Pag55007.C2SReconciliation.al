page 55007 "C2S Reconciliation"
{
    // version HEI.05

    // HEI.01 HB2761 IBM BULIMC01 13/04/2022#new page created in order to show the figures for C2s Reconcilation
    // HEI.02 CHG2152809 IBM BULIMC01 21/04/2022#Allocation of Warehouse KPIs to RPM Transport
    //   #new fields added
    // HEI.03 CHG2169207 IBM SISUM01 17/08/2022 #correct colors after a the new description option, RPM Internal Transfers, was added
    // HEI.04 CHG2175297 IBM SISUM01 30/03/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #changes for new enhancement; delete unused fields from display
    // HEI.05 CHG2175297 IBM SISUM01 26/04/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #changes for new enhancemt - split the line for Shippment non FG and formula change for Other Unrec. Documents

    // BC Upgrade POENAB02: Original (HeiLite) page id 50470
    // code is commented, as "Posted Document Shipping Cost" Table is not available in BC - it belongs to Aptean

    // POENAB02, 11.06.2026, changes according to Aptean BC standard

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "C2S Reconciliation FND";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Lists;
    CaptionML = ENU = 'C2S Reconciliation';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Columns;
                field(StrCompanyName; StrCompanyName)
                {
                    Caption = 'OpCo:';
                    Editable = false;
                    ToolTip = 'Enter the full legal name of the company or organization.';
                }
                field(ReportNameAndRunningDate; ReportNameAndRunningDate)
                {
                    Caption = 'Name:';
                    Editable = false;
                    ToolTip = 'Specify the report name and the date on which the report should be generated.';
                }
                field(ProcessingDateOfAlloc; ProcessingDateOfAlloc)
                {
                    Caption = 'Processing Date of Allocation:';
                    Editable = false;
                    ToolTip = 'Displays the date on which the allocation was processed';

                }
                field(StartingDate; StartingDate)
                {
                    Caption = 'Posting Date:';
                    Editable = false;
                    ToolTip = 'Enter the posting date';
                }
                field(EndingDate; EndingDate)
                {
                    Caption = 'Ending Date:';
                    Editable = false;
                    ToolTip = 'Enter the ending Date';
                }
            }
            repeater(Group)
            {
                field("Block Description"; Rec."Block Description")
                {
                    ToolTip = 'Enter the block Description';
                }
                field("Line Description"; Rec."Line Description")
                {
                    StyleExpr = DescStyle;
                    ToolTip = 'Enter the line Description';
                }
                field("Total 3rd Party"; Rec."Total 3rd Party")
                {
                    DecimalPlaces = 2 : 2;
                    StyleExpr = DescStyle;
                    ToolTip = 'Total value for third-party records.';

                    trigger OnDrillDown();
                    begin
                        ClearPages();
                        //HEI.04>>
                        /* 
                        IF Rec.Description = Rec.Description::"Posted Doc. Shipping Cost" THEN BEGIN
                            PostedDocShippingCost.RESET;
                            PostedDocShippingCost.SETRANGE("Posting Date", StartingDate, EndingDate);
                            IF NonOwnFleetAgents <> '' THEN
                                PostedDocShippingCost.SETFILTER("Shipping Agent Code", DELSTR(NonOwnFleetAgents, STRLEN(NonOwnFleetAgents)));
                            PostedDocShippingCostPage.SETTABLEVIEW(PostedDocShippingCost);
                            PostedDocShippingCostPage.RUNMODAL;
                        END ELSE
                            IF Archived THEN BEGIN
                                ShipArchive.RESET;
                                ShipArchive.SETCURRENTKEY("Posting Date");
                                ShipArchive.SETRANGE("Posting Date", StartingDate, EndingDate);
                                ShipArchive.SETRANGE("Own Fleet", FALSE);
                                //HEI.03>>
                                CASE Rec.Description OF
                                    Rec.Description::"RPM Internal Transfers":
                                        ShipArchive.SETRANGE("Only RPM Transportation", TRUE);
                                    Rec.Description::"Internal Transfers":
                                        ShipArchive.SETRANGE("Only RPM Transportation", FALSE);
                                END;
                                //HEI.03<<
                                LaunchArchivedPage(ShipArchive);
                            END ELSE BEGIN
                                ShipAllocation.RESET;
                                ShipAllocation.SETCURRENTKEY("Posting Date");
                                ShipAllocation.SETRANGE("Posting Date", StartingDate, EndingDate);
                                ShipAllocation.SETRANGE("Own Fleet", FALSE);
                                //HEI.03>>
                                CASE Rec.Description OF
                                    Rec.Description::"RPM Internal Transfers":
                                        ShipAllocation.SETRANGE("Only RPM Transportation", TRUE);
                                    Rec.Description::"Internal Transfers":
                                        ShipAllocation.SETRANGE("Only RPM Transportation", FALSE);
                                END;
                                //HEI.03<<
                                LaunchAllocationPage(ShipAllocation);
                            END;
                            */

                        if Rec.Description = Rec.Description::Line7 then begin
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                            if NonOwnFleetAgents <> '' then
                                PostedDocShippingCost.SetFilter("Shipping Agent Code", DelStr(NonOwnFleetAgents, StrLen(NonOwnFleetAgents)));
                            PostedDocShippingCostPage.SetTableView(PostedDocShippingCost);
                            PostedDocShippingCostPage.RunModal();
                        end else
                            if Archived then begin
                                ShipArchive.Reset();
                                ShipArchive.SetCurrentKey("Posting Date");
                                ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
                                ShipArchive.SetRange("Own Fleet", false);
                                case Rec.Description of
                                    Rec.Description::Line4, Rec.Description::Line5,
                                  Rec.Description::Line11, Rec.Description::Line12,
                                  Rec.Description::Line16, Rec.Description::Line17,
                                  Rec.Description::Line21, Rec.Description::Line22,
                                  Rec.Description::line28, Rec.Description::Line29,
                                  Rec.Description::Line33, Rec.Description::Line34,
                                  Rec.Description::Line38, Rec.Description::Line39:
                                        ShipArchive.SetRange("Only RPM Transportation", true);
                                    Rec.Description::Line2, Rec.Description::Line3,
                                  Rec.Description::Line9, Rec.Description::Line10,
                                  Rec.Description::Line14, Rec.Description::Line15,
                                  Rec.Description::Line19, Rec.Description::Line20,
                                  Rec.Description::Line26, Rec.Description::Line27,
                                  Rec.Description::Line31, Rec.Description::Line32,
                                  Rec.Description::Line36, Rec.Description::Line37:
                                        ShipArchive.SetRange("Only RPM Transportation", false);
                                    Rec.Description::Line60:
                                        ShipArchive.SetRange(Reversed, true);
                                    Rec.Description::Line61:
                                        begin
                                            ShipArchive.SetRange("Only RPM Transportation", true);
                                            ShipArchive.SetFilter("Source Document", '<>%1', ShipArchive."Source Document"::"Sales Return Order");
                                            //HEI.05>>
                                            ShipArchive.SetRange(Reversed, false);
                                            //HEI.05<<
                                        end;
                                    Rec.Description::Line62:
                                        begin
                                            if FilterCategory <> '' then
                                                ShipArchive.SetFilter("Item Category Code", DELSTR(FilterCategory, STRLEN(FilterCategory)));
                                            //HEI.05>>
                                            ShipArchive.SetFilter("Source Document", '%1|%2', ShipArchive."Source Document"::"Sales Order", ShipArchive."Source Document"::"Sales Return Order");
                                            ShipArchive.SetRange(Reversed, false);
                                            //HEI.05<<
                                        end;
                                    //HEI.05>>
                                    Rec.Description::Line63:
                                        begin
                                            if FilterCategory <> '' then
                                                ShipArchive.SetFilter("Item Category Code", DELSTR(FilterCategory, STRLEN(FilterCategory)));

                                            ShipArchive.SetFilter("Source Document", '%1', ShipArchive."Source Document"::"Outbound Transfer");
                                            ShipArchive.SetRange(Reversed, false);
                                        end;
                                //HEI.05<<
                                end;
                                LaunchArchivedPage(ShipArchive);
                            end else begin
                                ShipAllocation.Reset();
                                ShipAllocation.SetCurrentKey("Posting Date");
                                ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
                                ShipAllocation.SetRange("Own Fleet", false);
                                case Rec.Description of
                                    Rec.Description::Line4, Rec.Description::Line5,
                                  Rec.Description::Line11, Rec.Description::Line12,
                                  Rec.Description::Line16, Rec.Description::Line17,
                                  Rec.Description::Line21, Rec.Description::Line22,
                                  Rec.Description::line28, Rec.Description::Line29,
                                  Rec.Description::Line33, Rec.Description::Line34,
                                  Rec.Description::Line38, Rec.Description::Line39:
                                        ShipAllocation.SetRange("Only RPM Transportation", true);
                                    Rec.Description::Line2, Rec.Description::Line3,
                                  Rec.Description::Line9, Rec.Description::Line10,
                                  Rec.Description::Line14, Rec.Description::Line15,
                                  Rec.Description::Line19, Rec.Description::Line20,
                                  Rec.Description::Line26, Rec.Description::Line27,
                                  Rec.Description::Line31, Rec.Description::Line32,
                                  Rec.Description::Line36, Rec.Description::Line37:
                                        ShipAllocation.SetRange("Only RPM Transportation", false);
                                    Rec.Description::Line60:
                                        ShipAllocation.SetRange(Reversed, true);
                                    Rec.Description::Line61:
                                        begin
                                            ShipAllocation.SetRange("Only RPM Transportation", true);
                                            ShipAllocation.SetFilter("Source Document", '<>%1', ShipAllocation."Source Document"::"Sales Return Order");
                                            //HEI.05>>
                                            ShipAllocation.SetRange(Reversed, false);
                                            //HEI.05<<
                                        end;
                                    Rec.Description::Line62:
                                        begin
                                            if FilterCategory <> '' then
                                                ShipAllocation.SetFilter("Item Category Code", DELSTR(FilterCategory, STRLEN(FilterCategory)));
                                            //HEI.05<<
                                            ShipAllocation.SetFilter("Source Document", '%1|%2', ShipAllocation."Source Document"::"Sales Order", ShipAllocation."Source Document"::"Sales Return Order");
                                            ShipAllocation.SetRange(Reversed, false);
                                            //HEI.05<<
                                        end;
                                    //HEI.05>>
                                    Rec.Description::Line63:
                                        begin
                                            if FilterCategory <> '' then
                                                ShipAllocation.SetFilter("Item Category Code", DELSTR(FilterCategory, STRLEN(FilterCategory)));
                                            ShipAllocation.SetFilter("Source Document", '%1', ShipAllocation."Source Document"::"Outbound Transfer");
                                            ShipAllocation.SetRange(Reversed, false);
                                        end;
                                //HEI.05<<

                                end;
                                LaunchAllocationPage(ShipAllocation);
                            end;


                        if Rec.Description = Rec.Description::Line64 then begin
                            ViewMissingPostedDocShipCosts(false, false);
                            //HEI.05>>
                            /*
                            PostedDocShipCostTmp.RESET;
                            RecRef.GETTABLE(PostedDocShipCostTmp);
                            C2SPostedDocShipCostPage.SetTmpRecords(RecRef);
                            C2SPostedDocShipCostPage.RUN;
                            */
                            LaunchPostedDocShippmentPage();
                            //HEI.05<<
                        end;

                        if Rec.Description = Rec.Description::Line65 then begin
                            ViewOtherUnreconPostedDocShipCosts(false, false);
                            //HEI.05>>
                            /*
                            PostedDocShipCostTmp.RESET;
                            RecRef.GETTABLE(PostedDocShipCostTmp);
                            C2SPostedDocShipCostPage.SetTmpRecords(RecRef);
                            C2SPostedDocShipCostPage.RUN;
                            */
                            LaunchPostedDocShippmentPage();
                            //HEI.05<<
                        end;
                        //HEI.04<<

                    end;
                }
                field("Allocated 3rd Party"; Rec."Allocated 3rd Party")
                {
                    DecimalPlaces = 2 : 2;
                    StyleExpr = DescStyle;
                    ToolTip = 'Update Allocated 3rd Party';
                }
                field("Unallocated 3rd Party"; Rec."Unallocated 3rd Party")
                {
                    DecimalPlaces = 2 : 2;
                    StyleExpr = DescStyle;
                    ToolTip = 'Update Unallocated 3rd Party';
                }
                field("Total Own Fleet"; Rec."Total Own Fleet")
                {
                    DecimalPlaces = 2 : 2;
                    StyleExpr = DescStyle;
                    ToolTip = 'Total Own Fleet';

                    trigger OnDrillDown();
                    begin
                        ClearPages();
                        //HEI.04>>
                        /*
                        IF Rec.Description = Rec.Description::"Posted Doc. Shipping Cost" THEN BEGIN
                          PostedDocShippingCost.RESET;
                          PostedDocShippingCost.SETRANGE("Posting Date",StartingDate,EndingDate);
                          IF OwnFleetAgents <> '' THEN
                            PostedDocShippingCost.SETFILTER("Shipping Agent Code",DELSTR(OwnFleetAgents,STRLEN(OwnFleetAgents)));
                          PostedDocShippingCostPage.SETTABLEVIEW(PostedDocShippingCost);
                          PostedDocShippingCostPage.RUNMODAL;
                        END ELSE
                          IF Archived THEN BEGIN
                            ShipArchive.RESET;
                            ShipArchive.SETCURRENTKEY("Posting Date");
                            ShipArchive.SETRANGE("Posting Date",StartingDate,EndingDate);
                            ShipArchive.SETRANGE("Own Fleet",TRUE);
                            //HEI.03>>
                            CASE Rec.Description OF
                              Rec.Description::"RPM Internal Transfers":
                                ShipArchive.SETRANGE("Only RPM Transportation",TRUE);
                              Rec.Description::"Internal Transfers":
                                ShipArchive.SETRANGE("Only RPM Transportation",FALSE);
                            END;
                            //HEI.03<<
                            LaunchArchivedPage(ShipArchive);
                          END ELSE BEGIN
                            ShipAllocation.RESET;
                            ShipAllocation.SETCURRENTKEY("Posting Date");
                            ShipAllocation.SETRANGE("Posting Date",StartingDate,EndingDate);
                            ShipAllocation.SETRANGE("Own Fleet",TRUE);
                            //HEI.03>>
                            CASE Rec.Description OF
                              Rec.Description::"RPM Internal Transfers":
                                ShipAllocation.SETRANGE("Only RPM Transportation",TRUE);
                              Rec.Description::"Internal Transfers":
                                ShipAllocation.SETRANGE("Only RPM Transportation",FALSE);
                            END;
                            //HEI.03<<
                            LaunchAllocationPage(ShipAllocation);
                          END;
                        */

                        if Rec.Description = Rec.Description::Line7 then begin
                            PostedDocShippingCost.Reset();
                            PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                            if OwnFleetAgents <> '' then
                                PostedDocShippingCost.SetFilter("Shipping Agent Code", DELSTR(OwnFleetAgents, STRLEN(OwnFleetAgents)));
                            PostedDocShippingCostPage.SetTableView(PostedDocShippingCost);
                            PostedDocShippingCostPage.RunModal();
                        end else
                            if Archived then begin
                                ShipArchive.Reset();
                                ShipArchive.SetCurrentKey("Posting Date");
                                ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
                                ShipArchive.SetRange("Own Fleet", true);
                                case Rec.Description of
                                    Rec.Description::Line4, Rec.Description::Line5,
                                  Rec.Description::Line11, Rec.Description::Line12,
                                  Rec.Description::Line16, Rec.Description::Line17,
                                  Rec.Description::Line21, Rec.Description::Line22,
                                  Rec.Description::line28, Rec.Description::Line29,
                                  Rec.Description::Line33, Rec.Description::Line34,
                                  Rec.Description::Line38, Rec.Description::Line39:
                                        ShipArchive.SetRange("Only RPM Transportation", true);
                                    Rec.Description::Line2, Rec.Description::Line3,
                                  Rec.Description::Line9, Rec.Description::Line10,
                                  Rec.Description::Line14, Rec.Description::Line15,
                                  Rec.Description::Line19, Rec.Description::Line20,
                                  Rec.Description::Line26, Rec.Description::Line27,
                                  Rec.Description::Line31, Rec.Description::Line32,
                                  Rec.Description::Line36, Rec.Description::Line37:
                                        ShipArchive.SetRange("Only RPM Transportation", false);
                                    Rec.Description::Line60:
                                        ShipArchive.SetRange(Reversed, true);
                                    Rec.Description::Line61:
                                        begin
                                            ShipArchive.SetRange("Only RPM Transportation", true);
                                            ShipArchive.SetFilter("Source Document", '<>%1', ShipArchive."Source Document"::"Sales Return Order");
                                            //HEI.05<<
                                            ShipArchive.SetRange(Reversed, false);
                                            //HEI.05<<
                                        end;
                                    Rec.Description::Line62:
                                        begin
                                            if FilterCategory <> '' then
                                                ShipArchive.SetFilter("Item Category Code", DELSTR(FilterCategory, STRLEN(FilterCategory)));
                                            //HEI.05>>
                                            ShipArchive.SetFilter("Source Document", '%1|%2', ShipArchive."Source Document"::"Sales Order", ShipArchive."Source Document"::"Sales Return Order");
                                            ShipArchive.SetRange(Reversed, false);
                                            //HEI.05<<

                                        end;
                                    //HEI.05>>
                                    Rec.Description::Line63:
                                        begin
                                            if FilterCategory <> '' then
                                                ShipArchive.SetFilter("Item Category Code", DELSTR(FilterCategory, STRLEN(FilterCategory)));
                                            ShipArchive.SetFilter("Source Document", '%1', ShipArchive."Source Document"::"Outbound Transfer");
                                            ShipArchive.SetRange(Reversed, false);
                                        end;
                                //HEI.05<<
                                end;
                                LaunchArchivedPage(ShipArchive);
                            end else begin
                                ShipAllocation.Reset();
                                ShipAllocation.SetCurrentKey("Posting Date");
                                ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
                                ShipAllocation.SetRange("Own Fleet", true);
                                case Rec.Description of
                                    Rec.Description::Line4, Rec.Description::Line5,
                                  Rec.Description::Line11, Rec.Description::Line12,
                                  Rec.Description::Line16, Rec.Description::Line17,
                                  Rec.Description::Line21, Rec.Description::Line22,
                                  Rec.Description::line28, Rec.Description::Line29,
                                  Rec.Description::Line33, Rec.Description::Line34,
                                  Rec.Description::Line38, Rec.Description::Line39:
                                        ShipAllocation.SETRANGE("Only RPM Transportation", true);
                                    Rec.Description::Line2, Rec.Description::Line3,
                                  Rec.Description::Line9, Rec.Description::Line10,
                                  Rec.Description::Line14, Rec.Description::Line15,
                                  Rec.Description::Line19, Rec.Description::Line20,
                                  Rec.Description::Line26, Rec.Description::Line27,
                                  Rec.Description::Line31, Rec.Description::Line32,
                                  Rec.Description::Line36, Rec.Description::Line37:
                                        ShipAllocation.SetRange("Only RPM Transportation", false);
                                    Rec.Description::Line60:
                                        ShipAllocation.SetRange(Reversed, true);
                                    Rec.Description::Line61:
                                        begin
                                            ShipAllocation.SetRange("Only RPM Transportation", true);
                                            //HEI.05>>
                                            ShipAllocation.SetRange(Reversed, false);
                                            //HEI.05<<
                                            ShipAllocation.SetFilter("Source Document", '<>%1', ShipAllocation."Source Document"::"Sales Return Order");
                                        end;
                                    Rec.Description::Line62:
                                        begin
                                            if FilterCategory <> '' then
                                                ShipAllocation.SetFilter("Item Category Code", DELSTR(FilterCategory, STRLEN(FilterCategory)));
                                            //HEI.05>>
                                            ShipAllocation.SetRange(Reversed, false);
                                            ShipAllocation.SetFilter("Source Document", '%1|%2', ShipAllocation."Source Document"::"Sales Order", ShipAllocation."Source Document"::"Sales Return Order");
                                            //HEI.05<<
                                        end;
                                    //HEI.05>>
                                    Rec.Description::Line63:
                                        begin
                                            if FilterCategory <> '' then
                                                ShipAllocation.SetFilter("Item Category Code", DELSTR(FilterCategory, STRLEN(FilterCategory)));
                                            ShipAllocation.SetRange(Reversed, false);
                                            ShipAllocation.SetFilter("Source Document", '%1', ShipAllocation."Source Document"::"Outbound Transfer");
                                        end;
                                //HEI.05<<
                                end;
                                LaunchAllocationPage(ShipAllocation);
                            end;


                        if Rec.Description = Rec.Description::Line64 then begin
                            ViewMissingPostedDocShipCosts(true, false);
                            //HEI.05>>
                            /*
                            PostedDocShipCostTmp.RESET;
                            RecRef.GETTABLE(PostedDocShipCostTmp);
                            C2SPostedDocShipCostPage.SetTmpRecords(RecRef);
                            C2SPostedDocShipCostPage.RUN;
                            */
                            LaunchPostedDocShippmentPage();
                            //HEI.05<<
                        end;

                        if Rec.Description = Rec.Description::Line65 then begin
                            ViewOtherUnreconPostedDocShipCosts(true, false);
                            //HEI.05>>
                            /*
                            PostedDocShipCostTmp.RESET;
                            RecRef.GETTABLE(PostedDocShipCostTmp);
                            C2SPostedDocShipCostPage.SetTmpRecords(RecRef);
                            C2SPostedDocShipCostPage.RUN;
                            */
                            LaunchPostedDocShippmentPage();
                            //HEI.05<<
                        end;
                        //HEI.04<<
                    end;
                }
                field("Allocated Own Fleet"; Rec."Allocated Own Fleet")
                {
                    DecimalPlaces = 2 : 2;
                    StyleExpr = DescStyle;
                    ToolTip = 'Update Allocated Own Fleet';
                }
                field("Unallocated Own Fleet"; Rec."Unallocated Own Fleet")
                {
                    DecimalPlaces = 2 : 2;
                    StyleExpr = DescStyle;
                    ToolTip = 'Update Unallocated Own Fleet';

                }
                field(Total; Rec.Total)
                {
                    DecimalPlaces = 2 : 2;
                    StyleExpr = DescStyle;
                    ToolTip = 'Update Total';

                    trigger OnDrillDown();
                    begin
                        ClearPages();
                        if Rec.Total <> 0 then
                            if Rec.Description = Rec.Description::Line7 then begin
                                PostedDocShippingCost.Reset();
                                PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
                                PostedDocShippingCostPage.SetTableView(PostedDocShippingCost);
                                PostedDocShippingCostPage.RunModal();
                            end else
                                if Archived then begin
                                    ShipArchive.Reset();
                                    ShipArchive.SetCurrentKey("Posting Date");
                                    ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
                                    LaunchArchivedPage(ShipArchive);
                                end else begin
                                    ShipAllocation.Reset();
                                    ShipAllocation.SetCurrentKey("Posting Date");
                                    ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
                                    LaunchAllocationPage(ShipAllocation);
                                end;

                        //HEI.04>>
                        if Rec.Description = Rec.Description::Line64 then begin
                            ViewMissingPostedDocShipCosts(true, true);
                            //HEI.05>>
                            /*
                            RecRef.GETTABLE(PostedDocShipCostTmp);
                            C2SPostedDocShipCostPage.SetTmpRecords(RecRef);
                            C2SPostedDocShipCostPage.RUN;
                            */
                            LaunchPostedDocShippmentPage();
                            //HEI.05<<
                        end;
                        //HEI.04<<

                        //HEI.05>>
                        if Rec.Description = Rec.Description::Line65 then begin
                            ViewOtherUnreconPostedDocShipCosts(true, true);
                            LaunchPostedDocShippmentPage();
                        end;
                        //HEI.05<<                        
                    end;
                }
                field(Allocated; Rec.Allocated)
                {
                    DecimalPlaces = 2 : 2;
                    StyleExpr = DescStyle;
                    ToolTip = 'Add Allocated';
                }
                field(Unallocated; Rec.Unallocated)
                {
                    DecimalPlaces = 2 : 2;
                    StyleExpr = DescStyle;
                    ToolTip = 'Add UnAllocated';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        //HEI.04>>
        /*
        DescStyle := 'Strong';
        
        IF (Description = Description::Line6) OR (Description = Description::Line1) OR (Description = Description::Line9) OR
           (Description=Description::Line10) OR (Description=Description::Line15) THEN BEGIN
              DescStyle := 'StrongAccent';
        END ELSE IF Description = Description::Line8 THEN BEGIN
          DescStyle  := 'Favorable';
        END;
        */
        DescStyle := 'Standard';
        if (Rec.Description = Rec.Description::Line6) or (Rec.Description = Rec.Description::Line1) or (Rec.Description = Rec.Description::Line18) or
           (Rec.Description = Rec.Description::Line13) or (Rec.Description = Rec.Description::Line23) or (Rec.Description = Rec.Description::Line25) or
           (Rec.Description = Rec.Description::Line30) or (Rec.Description = Rec.Description::Line35) or (Rec.Description = Rec.Description::Line40) or
           (Rec.Description = Rec.Description::Line41) or (Rec.Description = Rec.Description::Line42) or (Rec.Description = Rec.Description::Line45) or
           (Rec.Description = Rec.Description::Line51) or (Rec.Description = Rec.Description::Line55) or (Rec.Description = Rec.Description::Line56) or
           (Rec.Description = Rec.Description::Line58) or (Rec.Description = Rec.Description::Line59)
        then //begin //Blocked to resolve error as begin can be used with compound statement
            DescStyle := 'StrongAccent'
        else
            //end else begin//Blocked to resolve error as begin can be used with compound statement
            if (Rec.Description = Rec.Description::Line8) or (Rec.Description = Rec.Description::Line66) then
                DescStyle := 'Attention';
        //end;//Blocked to resolve error as begin can be used with compound statement
        //HEI.04<<

    end;

    trigger OnOpenPage();
    begin
        ShipAllocation.Reset();
        ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
        if not ShipAllocation.IsEmpty then
            Archived := false
        else
            Archived := true;

        FindMissingItemCategCode();
        FindAgentFilter();

        SetOpCoAndReportName(CURRENTDATETIME); //HEI.04
    end;

    var
        ShipArchive: Record "Shipping Cost Archive FND";
        ShipAllocation: Record "Shipping Cost Allocation FND";
        TempItemCategory: Record "Item Category" temporary;
        InventorySetup: Record "Inventory Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        ItemCategory: Record "Item Category";
        ShippingAgent: Record "Shipping Agent";
        //POENAB02, 11.06.2026>>
        PostedDocShippingCost: Record "Posted Trade Cost Order APS";
        //POENAB02, 11.06.2026<<
        //POENAB02, 11.06.2026>>
        PostedDocShipCostTmp: Record "Posted Trade Cost Order APS" temporary;
        //POENAB02, 11.06.2026<<
        C2SPostedDocShipCostPage: Page "C2S Posted Doc. Shipping Cost";
        DeliverytoCustAllocPage: Page "Delivery to Customers";
        InternalTransfersAllocPage: Page "Internal Transfer Allocation";
        RPMTransportsAllocPage: Page "RPM Transports";
        DeliverytoCustArchivePage: Page "Delivery to Customers Archive";
        InternalTransfersArchivePage: Page "Internal Transfers Archive";
        RPMTransportsArchivePage: Page "RPM Transports Archive";
        ShippingAllocationPage: Page "Shipping Cost Allocation List";
        ShippingAllocationArchivePage: Page "Shipping Cost Alloc. Archive";

        PostedDocShippingCostPage: Page "Posted Trade Cost Orders APS";
        RecRef: RecordRef;

        StartingDate: Date;
        EndingDate: Date;
        //TotalStyle: Text;//Unused variable
        // AllocatedStyle: Text;//Unused Variable

        Archived: Boolean;
        FilterCategory: Text;

        DescStyle: Text;
        // BC Upgrade POENAB02 >>
        // Posted Document Shipping Cost is an Aptean development - code commented
        /* 
        PostedDocShippingCost: Record "Posted Document Shipping Cost";
        PostedDocShippingCostPage: Page "Posted Document Shipping Cost";
         */
        // BC Upgrade POENAB02 <<


        OwnFleetAgents: Text;
        NonOwnFleetAgents: Text;
        //PostingDate: Text;Unused variable
        ProcessingDateOfAlloc: Date;
        ReportNameAndRunningDate: Text[250];
        StrCompanyName: Text[250];
        Text001: Label 'C2S Reconcilation';
    // BC Upgrade POENAB02 >>
    // code commented, as "Posted Document Shipping Cost" Table is not available in BC - it belongs to Aptean        
    // PostedDocShipCostTmp: Record "Posted Document Shipping Cost" temporary;
    // BC Upgrade POENAB02 <<



    local procedure LaunchArchivedPage(var ShipArchive: Record "Shipping Cost Archive FND");
    begin
        //HEI.04>>
        /*
        CASE Rec.Description OF
          Rec.Description::"Delivery to Customers":
            BEGIN
              DeliverytoCustArchivePage.SETTABLEVIEW(ShipArchive);
              DeliverytoCustArchivePage.RUN;
            END;
          //HEI.03>>
          //Rec.Description::"Internal Transfers":
          Rec.Description::"Internal Transfers",Rec.Description::"RPM Internal Transfers":
          //HEI.03<<
            BEGIN
              InternalTransfersArchivePage.SETTABLEVIEW(ShipArchive);
              InternalTransfersArchivePage.RUN;
            END;
          Rec.Description::"RPM Transports":
            BEGIN
              RPMTransportsArchivePage.SETTABLEVIEW(ShipArchive);
              RPMTransportsArchivePage.RUN;
            END;
          Rec.Description::"Period  G/L  Own Fleet":
            BEGIN
              DeliverytoCustArchivePage.SETTABLEVIEW(ShipArchive);
              DeliverytoCustArchivePage.RUN;
            END;
          Rec.Description::"Period G/L Cost Delivery to Customer":
            BEGIN
              DeliverytoCustArchivePage.SETTABLEVIEW(ShipArchive);
              DeliverytoCustArchivePage.RUN;
            END;
          Rec.Description::"Period G/L Cost Gen. Overheads":
            BEGIN
              DeliverytoCustArchivePage.SETTABLEVIEW(ShipArchive);
              DeliverytoCustArchivePage.RUN;
            END;
          Rec.Description::"Period G/L Cost Gen. Overheads":
            BEGIN
              DeliverytoCustArchivePage.SETTABLEVIEW(ShipArchive);
              DeliverytoCustArchivePage.RUN;
            END;
          Rec.Description::"Period G/L Cost Whse. Handling":
            BEGIN
              DeliverytoCustArchivePage.SETTABLEVIEW(ShipArchive);
              DeliverytoCustArchivePage.RUN;
            END;
          Rec.Description::"Period G/L Cost Whse. Overhead":
            BEGIN
              DeliverytoCustArchivePage.SETTABLEVIEW(ShipArchive);
              DeliverytoCustArchivePage.RUN;
            END;
        END;
        */
        case Rec.Description of
            Rec.Description::Line2, Rec.Description::Line4,
            Rec.Description::Line9, Rec.Description::Line11,
            Rec.Description::Line14, Rec.Description::Line16,
            Rec.Description::Line19, Rec.Description::Line21,
            Rec.Description::Line26, Rec.Description::line28,
            Rec.Description::Line31, Rec.Description::Line33,
            Rec.Description::Line36, Rec.Description::Line38,
            Rec.Description::Line46, Rec.Description::Line47,
            Rec.Description::Line48, Rec.Description::Line49,
            Rec.Description::Line50, Rec.Description::Line52,
            Rec.Description::Line53, Rec.Description::Line54,
            Rec.Description::Line61, Rec.Description::Line62:
                begin
                    DeliverytoCustArchivePage.SETTABLEVIEW(ShipArchive);
                    DeliverytoCustArchivePage.RUN();
                end;
            Rec.Description::Line3, Rec.Description::Line5,
            Rec.Description::Line10, Rec.Description::Line12,
            Rec.Description::Line15, Rec.Description::Line17,
            Rec.Description::Line20, Rec.Description::Line22,
            Rec.Description::Line27, Rec.Description::Line29,
            Rec.Description::Line32, Rec.Description::Line34,
            Rec.Description::Line37, Rec.Description::Line39,
            Rec.Description::Line63:
                begin
                    InternalTransfersArchivePage.SetTableView(ShipArchive);
                    InternalTransfersArchivePage.Run();
                end;
            //HEI.05>>
            Rec.Description::Line60:
                begin
                    ShippingAllocationArchivePage.SetTableView(ShipAllocation);
                    ShippingAllocationArchivePage.Run();
                end;
        //HEI.05<<
        end;
        //HEI.04<<

    end;

    local procedure LaunchAllocationPage(var ShipAllocation: Record "Shipping Cost Allocation FND");
    begin
        //HEI.04>>
        /*
        CASE Rec.Description OF
            Rec.Description::"Delivery to Customers":
            BEGIN
              DeliverytoCustAllocPage.SETTABLEVIEW(ShipAllocation);
              DeliverytoCustAllocPage.RUN;
            END;
          //HEI.03>>
          //Rec.Description::"Internal Transfers"
          Rec.Description::"Internal Transfers",Rec.Description::"RPM Internal Transfers":
          //HEI.03<<
            BEGIN
              InternalTransfersAllocPage.SETTABLEVIEW(ShipAllocation);
              InternalTransfersAllocPage.RUN;
            END;
          Rec.Description::"RPM Transports":
            BEGIN
              RPMTransportsAllocPage.SETTABLEVIEW(ShipAllocation);
              RPMTransportsAllocPage.RUN;
            END;
          Rec.Description::"Period  G/L  Own Fleet":
            BEGIN
              DeliverytoCustAllocPage.SETTABLEVIEW(ShipAllocation);
              DeliverytoCustAllocPage.RUN;
            END;
          Rec.Description::"Period G/L Cost Delivery to Customer":
            BEGIN
              DeliverytoCustAllocPage.SETTABLEVIEW(ShipAllocation);
              DeliverytoCustAllocPage.RUN;
            END;
          Rec.Description::"Period G/L Cost Gen. Overheads":
            BEGIN
              DeliverytoCustAllocPage.SETTABLEVIEW(ShipAllocation);
              DeliverytoCustAllocPage.RUN;
            END;
          Rec.Description::"Period G/L Cost Gen. Overheads":
            BEGIN
              DeliverytoCustAllocPage.SETTABLEVIEW(ShipAllocation);
              DeliverytoCustAllocPage.RUN;
            END;
          Rec.Description::"Period G/L Cost Whse. Handling":
            BEGIN
              DeliverytoCustAllocPage.SETTABLEVIEW(ShipAllocation);
              DeliverytoCustAllocPage.RUN;
            END;
          Rec.Description::"Period G/L Cost Whse. Overhead":
            BEGIN
              DeliverytoCustAllocPage.SETTABLEVIEW(ShipAllocation);
              DeliverytoCustAllocPage.RUN;
            END;
        END;
        */

        case Rec.Description of
            Rec.Description::Line2, Rec.Description::Line4,
            Rec.Description::Line9, Rec.Description::Line11,
            Rec.Description::Line14, Rec.Description::Line16,
            Rec.Description::Line19, Rec.Description::Line21,
            Rec.Description::Line26, Rec.Description::line28,
            Rec.Description::Line31, Rec.Description::Line33,
            Rec.Description::Line36, Rec.Description::Line38,
            Rec.Description::Line46, Rec.Description::Line47,
            Rec.Description::Line48, Rec.Description::Line49,
            Rec.Description::Line50, Rec.Description::Line52,
            Rec.Description::Line53, Rec.Description::Line54,
            Rec.Description::Line61, Rec.Description::Line62:
                begin
                    DeliverytoCustAllocPage.SETTABLEVIEW(ShipAllocation);
                    DeliverytoCustAllocPage.RUN();
                end;
            Rec.Description::Line3, Rec.Description::Line5,
            Rec.Description::Line10, Rec.Description::Line12,
            Rec.Description::Line15, Rec.Description::Line17,
            Rec.Description::Line20, Rec.Description::Line22,
            Rec.Description::Line27, Rec.Description::Line29,
            Rec.Description::Line32, Rec.Description::Line34,
            Rec.Description::Line37, Rec.Description::Line39,
            Rec.Description::Line63:
                begin
                    InternalTransfersAllocPage.SetTableView(ShipAllocation);
                    InternalTransfersAllocPage.Run();
                end;
            //HEI.05>>
            Rec.Description::Line60:
                begin
                    ShippingAllocationPage.SetTableView(ShipAllocation);
                    ShippingAllocationPage.Run();
                end;
        //HEI.05<<
        end;
        //HEI.04<<

    end;

    procedure GetDates(lStartdate: Date; lEndDate: Date);
    begin
        StartingDate := lStartdate;
        EndingDate := lEndDate;
    end;

    local procedure FindMissingItemCategCode();
    begin
        InventorySetup.Get();
        SalesSetup.Get();

        if InventorySetup."Finished Goods ItemCatCode FND" <> '' then begin
            ItemCategory.Reset();
            ItemCategory.SetFilter(Code, InventorySetup."Finished Goods ItemCatCode FND");
            if ItemCategory.FindSet() then
                repeat
                    TempItemCategory.Reset();
                    if not TempItemCategory.Get(ItemCategory.Code) then begin
                        TempItemCategory.Code := ItemCategory.Code;
                        TempItemCategory.Insert();
                        FilterCategory += '<>' + TempItemCategory.Code + '&';
                    end;
                until ItemCategory.Next() = 0;
        end;

        if SalesSetup."RPMRelatedItemCategoryCode FND" <> '' then begin
            ItemCategory.Reset();
            ItemCategory.SetFilter(Code, SalesSetup."RPMRelatedItemCategoryCode FND");
            if ItemCategory.FindSet() then
                repeat
                    TempItemCategory.Reset();
                    if not TempItemCategory.Get(ItemCategory.Code) then begin
                        TempItemCategory.Code := ItemCategory.Code;
                        TempItemCategory.Insert();
                        FilterCategory += '<>' + TempItemCategory.Code + '&';
                    end;
                until ItemCategory.Next() = 0;
        end;
    end;

    local procedure FindAgentFilter();
    begin
        ShippingAgent.Reset();
        ShippingAgent.SetRange("Own Logistics FND", true);
        if ShippingAgent.FindSet() then
            repeat
                OwnFleetAgents += ShippingAgent.Code + '|';
                NonOwnFleetAgents += '<>' + ShippingAgent.Code + '&';
            until ShippingAgent.Next() = 0;
    end;

    local procedure ClearPages();
    begin
        CLEAR(DeliverytoCustAllocPage);
        CLEAR(DeliverytoCustArchivePage);
        CLEAR(InternalTransfersAllocPage);
        CLEAR(InternalTransfersArchivePage);
        CLEAR(RPMTransportsAllocPage);
        CLEAR(RPMTransportsArchivePage);
        CLEAR(PostedDocShippingCostPage);
        //HEI.05>>
        CLEAR(C2SPostedDocShipCostPage);
        CLEAR(ShippingAllocationArchivePage);
        CLEAR(ShippingAllocationPage);
        //HEI.05<<
    end;

    procedure SetOpCoAndReportName(ProcessindDateTime: DateTime);
    var
        ActiveSession: Record "Active Session";
    begin
        //HEI.04>>
        ActiveSession.SETRANGE("Server Instance ID", SERVICEINSTANCEID());
        ActiveSession.SETRANGE("Session ID", SESSIONID());
        if ActiveSession.FINDFIRST() then
#pragma warning disable AA0139
            StrCompanyName := ActiveSession."Server Computer Name" + '/' + ActiveSession."Server Instance Name" + ':';
#pragma warning restore AA0139
        StrCompanyName += COMPANYNAME;
        ReportNameAndRunningDate := Text001 + ': ' + FORMAT(ProcessindDateTime);
        //HEI.04<<
    end;

    procedure SetProcessingDate(lProcessingDate: Date);
    begin
        //HEI.04>>
        ProcessingDateOfAlloc := lProcessingDate;
        //HEI.04<<
    end;

    procedure SetTmpRecords(RecRef: RecordRef);
    begin
        //HEI.04>>
        if RecRef.FindFirst() then
            repeat
                RecRef.SetTable(Rec);
                Rec.Insert();
            until RecRef.Next() = 0;
        //HEI.04<<
    end;

    local procedure ViewMissingPostedDocShipCosts(OwnFleet: Boolean; IsTotal: Boolean);
    begin
        //HEI.04>>        
        PostedDocShipCostTmp.DeleteAll();
        if Archived then begin
            ShipArchive.Reset();
            ShipArchive.SetRange("Posting Date", StartingDate, EndingDate);
            if (not IsTotal) then
                ShipArchive.SetRange("Own Fleet", OwnFleet);
            if ShipArchive.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*
                    PostedDocShippingCost.Reset;
                    PostedDocShippingCost.SetRange("Source No.", ShipArchive."No.");
                    PostedDocShippingCost.SetFilter("Posting Date", '<%1|>%2', StartingDate, EndingDate);
                    if PostedDocShippingCost.FindFirst then begin
                        PostedDocShipCostTmp.SetRange("Source No.", PostedDocShippingCost."Source No.");
                        if PostedDocShipCostTmp.IsEmpty then begin
                            PostedDocShipCostTmp.Init;
                            PostedDocShipCostTmp.TransferFields(PostedDocShippingCost);
                            PostedDocShipCostTmp.Insert;
                        end;
                    end;
                    */

                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipArchive."Posted Whse. Shipment No.");
                    PostedDocShippingCost.SetFilter("Posting Date", '<%1|>%2', StartingDate, EndingDate);
                    if PostedDocShippingCost.FindFirst() then begin
                        PostedDocShipCostTmp.SetRange("Posted Whse. Shipment No.", PostedDocShippingCost."Posted Whse. Shipment No.");
                        if PostedDocShipCostTmp.IsEmpty then begin
                            PostedDocShipCostTmp.Init();
                            PostedDocShipCostTmp.TransferFields(PostedDocShippingCost);
                            PostedDocShipCostTmp.Insert();
                        end;
                    end;

                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipArchive."Posted Whse. Receipt No.");
                    PostedDocShippingCost.SetFilter("Posting Date", '<%1|>%2', StartingDate, EndingDate);
                    if PostedDocShippingCost.FindFirst() then begin
                        PostedDocShipCostTmp.SetRange("Posted Whse. Receipt No.", PostedDocShippingCost."Posted Whse. Receipt No.");
                        if PostedDocShipCostTmp.IsEmpty then begin
                            PostedDocShipCostTmp.Init();
                            PostedDocShipCostTmp.TransferFields(PostedDocShippingCost);
                            PostedDocShipCostTmp.Insert();
                        end;
                    end;
                //POENAB02, 11.06.2026<<
                until ShipArchive.Next() = 0;
        end else begin
            ShipAllocation.Reset();
            ShipAllocation.SetRange("Posting Date", StartingDate, EndingDate);
            if (not IsTotal) then
                ShipAllocation.SetRange("Own Fleet", OwnFleet);
            if ShipAllocation.FindSet(false) then
                repeat
                    //POENAB02, 11.06.2026>>
                    /*
                    PostedDocShippingCost.Reset;
                    PostedDocShippingCost.SetRange("Source No.", ShipAllocation."No.");
                    PostedDocShippingCost.SetFilter("Posting Date", '<%1|>%2', StartingDate, EndingDate);
                    if PostedDocShippingCost.FindFirst then begin
                        PostedDocShipCostTmp.SetRange("Source No.", PostedDocShippingCost."Source No.");
                        if PostedDocShipCostTmp.IsEmpty then begin
                            PostedDocShipCostTmp.Init;
                            PostedDocShipCostTmp.TransferFields(PostedDocShippingCost);
                            PostedDocShipCostTmp.Insert;
                        end;
                    end;
                    */

                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Shipment No.", ShipAllocation."Posted Whse. Shipment No.");
                    PostedDocShippingCost.SetFilter("Posting Date", '<%1|>%2', StartingDate, EndingDate);
                    if PostedDocShippingCost.FindFirst() then begin
                        PostedDocShipCostTmp.SetRange("Posted Whse. Shipment No.", PostedDocShippingCost."Posted Whse. Shipment No.");
                        if PostedDocShipCostTmp.IsEmpty then begin
                            PostedDocShipCostTmp.Init();
                            PostedDocShipCostTmp.TransferFields(PostedDocShippingCost);
                            PostedDocShipCostTmp.Insert();
                        end;
                    end;

                    PostedDocShippingCost.Reset();
                    PostedDocShippingCost.SetRange("Posted Whse. Receipt No.", ShipAllocation."Posted Whse. Receipt No.");
                    PostedDocShippingCost.SetFilter("Posting Date", '<%1|>%2', StartingDate, EndingDate);
                    if PostedDocShippingCost.FindFirst() then begin
                        PostedDocShipCostTmp.SetRange("Posted Whse. Receipt No.", PostedDocShippingCost."Posted Whse. Receipt No.");
                        if PostedDocShipCostTmp.IsEmpty then begin
                            PostedDocShipCostTmp.Init();
                            PostedDocShipCostTmp.TransferFields(PostedDocShippingCost);
                            PostedDocShipCostTmp.Insert();
                        end;
                    end;
                //POENAB02, 11.06.2026<<
                until ShipAllocation.Next() = 0;
        end;
        //HEI.04<< 
    end;

    local procedure ViewOtherUnreconPostedDocShipCosts(OwnFleet: Boolean; IsTotal: Boolean);
    var
        //ShippingAgent: Record "Shipping Agent";// Already having global variable<<
        // SCA: Record "Shipping Cost Allocation FND";//Unused<<
        C2SReconc: Report "C2S Reconciliation";
    begin
        //HEI.04>>        
        PostedDocShipCostTmp.DeleteAll();
        PostedDocShippingCost.Reset();
        //HEI.05>>
        //PostedDocShippingCost.SETFILTER("Source Type",'<>%1&<>%2',7318,7322);
        PostedDocShippingCost.SetRange("Posting Date", StartingDate, EndingDate);
        //HEI.05<<
        if PostedDocShippingCost.FindSet(false) then
            repeat
#pragma warning disable AA0005
                if (C2SReconc.NotFoundPostedDocShipCostInSCA(PostedDocShippingCost, Archived)) then begin
                    if (IsTotal) then
                        InsertPostedDocShippCostTmp()
                    else begin
                        //POENAB02, 11.06.2026>>
                        //if ShippingAgent.GET(PostedDocShippingCost."Shipping Agent Code") and (ShippingAgent."Own Logistics" = OwnFleet) then
                        if ShippingAgent.GET(PostedDocShippingCost."Shipping Agent Code") and (ShippingAgent."Own Logistics FND" = OwnFleet) then
                            //POENAB02, 11.06.2026<<
                            InsertPostedDocShippCostTmp();
                    end;
                end;
#pragma warning restore AA0005
            until PostedDocShippingCost.Next() = 0;
        //HEI.04<< 
    end;

    local procedure LaunchPostedDocShippmentPage();
    begin
        //HEI.05>>
        PostedDocShipCostTmp.Reset();
        RecRef.GetTable(PostedDocShipCostTmp);
        C2SPostedDocShipCostPage.SetTmpRecords(RecRef);
        C2SPostedDocShipCostPage.Run();
        //HEI.05<<
    end;

    local procedure InsertPostedDocShippCostTmp();
    begin
        //POENAB02, 11.06.2026>>
        /*
        //HEI.05>>        
        PostedDocShipCostTmp.SetRange("Source No.", PostedDocShippingCost."Source No.");        
        if PostedDocShipCostTmp.IsEmpty then begin
            PostedDocShipCostTmp.Init;
            PostedDocShipCostTmp.TransferFields(PostedDocShippingCost);
            PostedDocShipCostTmp.Insert;
        end;
        //HEI.05<<
        */
        PostedDocShipCostTmp.SetRange("Posted Whse. Shipment No.", PostedDocShippingCost."Posted Whse. Shipment No.");
        if PostedDocShipCostTmp.IsEmpty then begin
            PostedDocShipCostTmp.Init();
            PostedDocShipCostTmp.TransferFields(PostedDocShippingCost);
            PostedDocShipCostTmp.Insert();
        end;
        PostedDocShipCostTmp.SetRange("Posted Whse. Receipt No.", PostedDocShippingCost."Posted Whse. Receipt No.");
        if PostedDocShipCostTmp.IsEmpty then begin
            PostedDocShipCostTmp.Init();
            PostedDocShipCostTmp.TransferFields(PostedDocShippingCost);
            PostedDocShipCostTmp.Insert();
        end;
        //POENAB02, 11.06.2026<<
    end;
}


