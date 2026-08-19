page 51055 "Posted Whse.Rcpt ListBRe CBN"
{
    // version Role

    // DITW15.00.00.21 DDR 19/06/2008 added columns
    //                                  "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per"
    //                                  "Shipping Agent Code","Shipping Agent Service Code","Shipment Method Code","Shipment Date"
    //                                  "Total Weight","Total Volume"
    //                                resize form + HorizGlue on control8
    //                                add form's property CalcFields
    // DITW15.00.00.25 DDR 17/10/2008 Addded columns "Truck Code","Driver Code"
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields "Shipping Currency Code"
    //                 DDR 06/10/2009 issue 516 Added field "Physical Location Group Code"
    // DITW15.00.00.37 DDR 02/06/2010 issue 1061 Added default Not visible fields "Physical Location Group Code"
    // DITW16.00.00.39 DDR 29/07/2011 DIT-715 #120 Merge error design button "Receipt"
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    // DITW18.00.07 VSC 15/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Removed old Shipping Costs fields from Shipping Tab
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                      "Require 2 Drivers"
    //                                      "Driver 2 Code"
    //                                      Route
    //                                      "Route Planning No."

    //Bc Upgrade YADAVM09 Drink it field commented.

    Caption = 'Posted Whse. Receipt List';
    CardPageID = "Posted Whse. Receipt";
    DataCaptionFields = "No.";
    ApplicationArea = All;
    Editable = false;
    PageType = List;
    SourceTable = "Posted Whse. Receipt Header";
    SourceTableView = where("Location Code" = CONST('DZ01'),
                            "Zone Code" = CONST('BREWING'));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the posted warehouse receipt.';
                }
                /* Bc Upgrade YADAVM09 Drink it field commented>>
                field("Physical Location Group Code";Rec."Physical Location Group Code")
                {
                    Visible = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the code of the location where the items were received.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the number series code to use for the record it creates when you post a receipt.';
                }
                field("Whse. Receipt No."; Rec."Whse. Receipt No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the number of the warehouse receipt that the posted warehouse receipt concerns.';
                }
                /* //Bc Upgrade YADAVM09 Drink it field commented>>
                field("Truck Code"; Rec."Truck Code")
                {
                }
                field("Driver Code"; Rec."Driver Code")
                {
                }
                field("Require 2 Drivers"; Rec."Require 2 Drivers")
                {
                    Description = 'NRQ16082';
                }
                field("Driver 2 Code"; Rec."Driver 2 Code")
                {
                    Description = 'NRQ16082';
                }
                field(Route; Rec.Route)
                {
                    Description = 'NRQ16082';
                }
                field("Route Planning No."; "Route Planning No.")
                {
                    Description = 'NRQ16082';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                }
                field("Total Weight"; Rec."Total Weight")
                {
                }
                field("Total Cubage"; Rec."Total Cubage")
                {
                }
                field("ShortcutQtyUomValue[1]"; ShortcutQtyUomValue[1])
                {
                    BlankZero = true;
                    CaptionClass = GetCaptionClassUom(1);
                    DecimalPlaces = 0 : 5;
                    Description = 'DIT-715 #244';
                    Editable = false;
                    Visible = false;
                }
                field("ShortcutQtyUomValue[2]"; ShortcutQtyUomValue[2])
                {
                    BlankZero = true;
                    CaptionClass = GetCaptionClassUom(2);
                    DecimalPlaces = 0 : 5;
                    Description = 'DIT-715 #244';
                    Editable = false;
                    Visible = false;
                }
                field("ShortcutQtyUomValue[3]"; ShortcutQtyUomValue[3])
                {
                    BlankZero = true;
                    CaptionClass = GetCaptionClassUom(3);
                    DecimalPlaces = 0 : 5;
                    Description = 'DIT-715 #244';
                    Editable = false;
                    Visible = false;
                }
                */ //Bc Upgrade YADAVM09 Drink it field commented<<
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the zone on this posted receipt header.';
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the bin on the posted receipt header.';
                    Visible = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the posted warehouse receipt.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date of the receipt.';
                    Visible = false;
                }
                field("Assignment Date"; Rec."Assignment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date on which the receipt was assigned to the user.';
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';

                    trigger OnAction();
                    begin
                        PAGE.RUN(PAGE::"Posted Whse. Receipt", Rec);
                    end;
                }
            }
            group("&Receipt")
            {
                Caption = '&Receipt';
                Image = Receipt;
                action(List)
                {
                    Caption = 'List';
                    Image = OpportunitiesList;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ToolTip = 'Executes the List action.';

                    trigger OnAction();
                    begin
                        Rec.LookupPostedWhseRcptHeader(Rec);
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Warehouse Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Posted Whse. Receipt"),
                                  Type = CONST(" "),
                                  "No." = FIELD("No.");
                    ToolTip = 'Executes the Co&mments action.';
                }
                action("Put-away Lines")
                {
                    Caption = 'Put-away Lines';
                    Image = PutawayLines;
                    RunObject = Page "Warehouse Activity Lines";
                    RunPageLink = "Whse. Document Type" = CONST(Receipt),
                                  "Whse. Document No." = FIELD("No.");
                    RunPageView = sorting("Whse. Document No.", "Whse. Document Type", "Activity Type")
                                  where("Activity Type" = CONST("Put-away"));
                    ToolTip = 'Executes the Put-away Lines action.';
                }
                action("Registered Put-away Lines")
                {
                    Caption = 'Registered Put-away Lines';
                    Image = RegisteredDocs;
                    RunObject = Page "Registered Whse. Act.-Lines";
                    RunPageLink = "Whse. Document Type" = CONST(Receipt),
                                  "Whse. Document No." = FIELD("No.");
                    RunPageView = sorting("Whse. Document Type", "Whse. Document No.", "Whse. Document Line No.")
                                  where("Activity Type" = CONST("Put-away"));
                    ToolTip = 'Executes the Registered Put-away Lines action.';
                }
                /* //Bc Upgrade YADAVM09 Drink it Page code commented>>
                action("Shipping Costs")
                {
                    Caption = 'Shipping Costs';
                    Image = Costs;
                    RunObject = Page "Posted Document Shipping Cost";
                    RunPageLink = "Source Type" = CONST(7318),
                                  "Source No." = FIELD("No.");
                }
                */ //Bc Upgrade YADAVM09 Drink it Page code commented<<
            }
        }
    }

    /* //Bc Upgrade YADAVM09 Drink it code commented>>
        trigger OnAfterGetRecord();
        begin
            // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
            Rec.ShowShortcutUomValue(ShortcutQtyUomValue);
            // >>DITW16.00.00.40 DDR DIT-715 #244
        end;
    */ //Bc Upgrade YADAVM09 Drink it code commented<<

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        exit(Rec.FindFirstAllowedRec(Which));
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        exit(Rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage();
    begin
        Rec.ErrorIfUserIsNotWhseEmployee();
    end;

    var
        ShortcutQtyUomValue: array[3] of Decimal;
}

