page 54036 "Warehouse Receipts - bre"
{
    // version Role

    // DITW15.00.00.21 DDR 19/06/2008 added columns
    //                                  "Shipping Charge Type","Shipping Charge No.","Shipping Charge Per"
    //                                  "Shipping Agent Code","Shipping Agent Service Code","Shipment Method Code","Shipment Date"
    //                                  "Total Weight","Total Volume"
    //                                resize form + HorizGlue on control2
    //                                form editable and only modify (all fields not editable except "Shipping charge per")
    //                                add form's property CalcFields
    //                                added function FormatMaximumControls()
    // DITW15.00.00.25 DDR 17/10/2008 Non-Editable columns "Maximum Weight","Maximum Cubage"
    //                                Added columns "Truck Code","Driver Code"
    // DITW15.00.00.35 DDR 19/08/2009 issue 773 Added fields "Shipping Currency Code"
    //                 DDR 06/10/2009 issue 516 Added field "Physical Location Group Code"
    // DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
    //                                Added shortcut (warehouse) fields
    //                                  Control1100079000 Shortcut Unit of Measure1 Code
    //                                  Control1100079001 Shortcut Unit of Measure2 Code
    //                                  Control1100079002 Shortcut Unit of Measure3 Code
    //                                Added Standard Global Dimension Lookup (see from 53 as reference)
    //                     17/02/2012 DIT-715 #246 Added menu 'Warehouse Lines' into 'Lines' button
    //                                             Added function Editablefields()
    //                                             Modified parameters for function FormatMaxControls()
    //                                             Removed 'Editable' property fields
    //                                               "Shipping Agent Code","Shipping Agent Service Code","Truck Code","Driver Code",
    //                                               "Assigned User ID"
    //                                             Non-editable fields
    // 
    // DITW17.00.02 DDR 21/11/2013 DIT-770 #87 DIT Icons ('Image' property)
    // DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214 Filter on "Resp. Center Table Filter"
    // DITW18.00.07 VSC 15/03/2016 DIT-770 #1066 Add Shipping Costs to Action Menu
    // DITW18.00.07 VSC 16/03/2016 DIT-770 #1066 Removed old Shipping Costs fields
    // 
    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.11 MSF 21/09/2017 NRQ#16082 Added Fields
    //                                "Require 2 Drivers"
    //                                "Driver 2 Code"
    //                                 Route
    //                                "Route Planning No."
    //                                 "Multiple Route Order"
    //                                 "Trailer Code"
    // BC Upgrade BHARDA11 >>
    // 1. Old Page ID- 50185.
    // 2. Removed Drink-IT Fields in Dataset Columns and Code("Physical Location Group Code","Shipping Agent Code","Shipping Agent Service Code","Truck Code","Trailer Code","Driver Code","Require 2 Drivers","Driver 2 Code","Maximum Weight","Total Weight To Receive","Maximum Cubage","Total Cubage To Receive","Route","Route Planning No.","Multiple Order Route").
    // 3. Removed Drink-IT Functions and related code(FormatMaximumControls,EditableFields,NoOnFormat,MaximumWeightOnFormat,MaximumCubageOnFormat).
    // 4. Removed Drink-IT Customization related code.
    // 5. Add ApplicationArea property in page,fields and actions.
    // BC Upgrade BHARDA11 <<
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Warehouse Receipts';
    CardPageID = "Warehouse Receipt";
    DataCaptionFields = "No.";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Warehouse Receipt Header";
    SourceTableView = WHERE("Location Code" = CONST('DZ01'),
                            "Zone Code" = CONST('BREWING'));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = "No.Emphasize";
                    ToolTip = 'Specifies the warehouse receipt header number, which is generated according to the No. Series specified in the Warehouse Mgt. Setup window.';
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Physical Location Group Code")
                // field("Physical Location Group Code"; Rec."Physical Location Group Code")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Visible = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Physical Location Group Code")

                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the code of the location in which the items are being received.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Editable = "Assigned User IDEditable";
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Sorting Method"; Rec."Sorting Method")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the method by which the receipts are sorted.';
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Field("Shipping Agent Code","Shipping Agent Service Code","Truck Code","Trailer Code","Driver Code","Require 2 Drivers","Driver 2 Code","Maximum Weight","Total Weight To Receive","Maximum Cubage","Total Cubage To Receive")
                // field("Shipping Agent Code"; Rec."Shipping Agent Code")
                // {
                //     ApplicationArea = All;
                //     Editable = "Shipping Agent CodeEditable";

                //     trigger OnValidate();
                //     begin
                //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //         IF (xRec."Shipping Agent Code" <> Rec."Shipping Agent Code") THEN
                //             CurrPage.UPDATE(TRUE)
                //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //     end;
                // }
                // field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                // {
                //     ApplicationArea = All;
                //     Editable = ShippingAgentServiceCodeEditab;
                // }
                // field("Truck Code"; Rec."Truck Code")
                // {
                //     ApplicationArea = All;
                //     Editable = "Truck CodeEditable";

                //     trigger OnValidate();
                //     begin
                //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //         IF (xRec."Truck Code" <> Rec."Truck Code") THEN
                //             CurrPage.UPDATE(TRUE)
                //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //     end;
                // }
                // field("Trailer Code"; Rec."Trailer Code") 
                // {
                // }
                // field("Driver Code"; Rec."Driver Code")
                // {
                //     ApplicationArea = All;
                //     Editable = "Driver CodeEditable";

                //     trigger OnValidate();
                //     begin
                //         //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //         IF (xRec."Driver Code" <> Rec."Driver Code") THEN
                //             CurrPage.UPDATE(TRUE)
                //         //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
                //     end;
                // }
                // field("Require 2 Drivers"; Rec."Require 2 Drivers") 
                // {
                //     ApplicationArea = All;
                // }
                // field("Driver 2 Code"; Rec."Driver 2 Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Maximum Weight"; Rec."Maximum Weight")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Style = Attention;
                //     StyleExpr = "Maximum WeightEmphasize";
                // }
                // field("Total Weight To Receive"; Rec."Total Weight To Receive")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Maximum Cubage"; Rec."Maximum Cubage") 
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                //     Style = Attention;
                //     StyleExpr = "Maximum CubageEmphasize";
                // }
                // field("Total Cubage To Receive"; Rec."Total Cubage To Receive")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field("Shipping Agent Code","Shipping Agent Service Code","Truck Code","Trailer Code","Driver Code","Require 2 Drivers","Driver 2 Code","Maximum Weight","Total Weight To Receive","Maximum Cubage","Total Cubage To Receive")

                // BC Upgrade BHARDA11 >> ----Drink-IT Customization
                // field(ShortcutQtyUomValue[1];ShortcutQtyUomValue[1])
                // {
                //      ApplicationArea = All;
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassUom(1);
                //     DecimalPlaces = 0:5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field(ShortcutQtyUomValue[2];ShortcutQtyUomValue[2])
                // {
                //      ApplicationArea = All;
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassUom(2);
                //     DecimalPlaces = 0:5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // field(ShortcutQtyUomValue[3];ShortcutQtyUomValue[3])
                // {
                //      ApplicationArea = All;
                //     BlankZero = true;
                //     CaptionClass = GetCaptionClassUom(3);
                //     DecimalPlaces = 0:5;
                //     Description = 'DIT-715 #244';
                //     Editable = false;
                //     Visible = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Customization
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the zone in which the items are being received if you are using directed put-away and pick.';
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Indicates the code of the bin in which you will place the items being received.';
                    Visible = false;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the status of the warehouse receipt.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the posting date of the warehouse receipt.';
                    Visible = false;
                }
                field("Assignment Date"; Rec."Assignment Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the date on which the document was assigned to the user.';
                    Visible = false;
                }
                // BC Upgrade BHARDA11 >> ----Drink-IT Field(Route,"Route Planning No.","Multiple Order Route")
                // field(Route; Rec.Route)
                // {
                //     ApplicationArea = All;
                //     trigger OnValidate();
                //     begin
                //         CurrPage.UPDATE(TRUE);
                //     end;
                // }
                // field("Route Planning No."; Rec."Route Planning No.")
                // {
                //     ApplicationArea = All;
                //     trigger OnValidate();
                //     begin
                //         CurrPage.UPDATE(TRUE);
                //     end;
                // }
                // field("Multiple Order Route"; Rec."Multiple Order Route")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // BC Upgrade BHARDA11 << ----Drink-IT Field(Route,"Route Planning No.","Multiple Order Route")
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Receipt")
            {
                Caption = '&Receipt';
                Image = Receipt;
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5776;
                    RunPageLink = "Table Name" = CONST("Whse. Receipt"),
                                  Type = CONST(" "),
                                  "No." = FIELD("No.");
                }
                action("Posted &Whse. Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted &Whse. Receipts';
                    Image = PostedReceipts;
                    RunObject = Page 7333;
                    RunPageLink = "Whse. Receipt No." = FIELD("No.");
                    RunPageView = SORTING("Whse. Receipt No.");
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction();
                    begin
                        PAGE.RUN(PAGE::"Warehouse Receipt", Rec);
                    end;
                }
                action("Whse. Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Whse. Lines';
                    Image = ReceiptLines;
                    RunObject = Page 7342;
                    RunPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // // <<DITW16.00.00.40 DDR 17/02/2012 DIT-715 #246
        // EditableFields();
        // // >>DITW16.00.00.40 DDR DIT-715 #246
        // //<<DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        // IF Rec."Physical Location Group Code" <> '' THEN BEGIN
        //     ResponsibilityCenter.RESET;
        //     ResponsibilityCenter.SETRANGE("Physical Location Group Code", "Physical Location Group Code");
        //     IF NOT ResponsibilityCenter.ISEMPTY THEN BEGIN
        //         ResponsibilityCenter.FINDFIRST;
        //         Rec.SETFILTER("Resp. Center Table Filter", '%1|%2', '', ResponsibilityCenter.Code);
        //     END;
        // END;
        // //>>DITW18.00.06 MSF 25/06/2015 DIT-770 #1212 #1213 #1214
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
    end;

    trigger OnAfterGetRecord();
    begin
        // BC Upgrade BHARDA11 >> ----Drink-IT Customization
        // // <<DITW16.00.00.40 DDR 13/02/2012 DIT-715 #244
        // ShowShortcutUomValue(ShortcutQtyUomValue);
        // // >>DITW16.00.00.40 DDR DIT-715 #244
        // NoOnFormat;
        // MaximumWeightOnFormat;
        // MaximumCubageOnFormat;
        // BC Upgrade BHARDA11 << ----Drink-IT Customization
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        EXIT(Rec.FindFirstAllowedRec(Which));
    end;

    trigger OnInit();
    begin
        "Assigned User IDEditable" := TRUE;
        "Driver CodeEditable" := TRUE;
        "Truck CodeEditable" := TRUE;
        ShippingAgentServiceCodeEditab := TRUE;
        "Shipping Agent CodeEditable" := TRUE;
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        EXIT(Rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage();
    begin
        Rec.ErrorIfUserIsNotWhseEmployee();
    end;

    var
        ShortcutQtyUomValue: array[3] of Decimal;

        "Shipping Agent CodeEditable": Boolean;

        ShippingAgentServiceCodeEditab: Boolean;

        "Truck CodeEditable": Boolean;

        "Driver CodeEditable": Boolean;

        "Assigned User IDEditable": Boolean;

        "No.Emphasize": Boolean;

        "Maximum WeightEmphasize": Boolean;

        "Maximum CubageEmphasize": Boolean;
        ResponsibilityCenter: Record 5714;
    // BC Upgrade BHARDA11 >> -----Drink-IT Functions(MaximumCubageOnFormat,MaximumWeightOnFormat,NoOnFormat,EditableFields,FormatMaximumControls)
    // procedure FormatMaximumControls(pFieldNo: Integer);
    // var
    //     lblnBold: Boolean;
    //     lcolor: Integer;
    // begin
    //     // <<DIT15.00.00.21 DDR 19/06/2008 - DITW16.00.00.40 DDR 22/02/2012 DIT-715 #246
    //     lcolor := 0;
    //     CALCFIELDS("Total Weight To Receive", "Total Cubage To Receive");

    //     IF ("Maximum Weight" < "Total Weight To Receive") OR
    //       ("Maximum Cubage" < "Total Cubage To Receive")
    //     THEN
    //         lcolor := 255;
    //     lblnBold := lcolor <> 0;

    //     CASE pFieldNo OF
    //         Rec.FIELDNO("No."):
    //             BEGIN
    //                 "No.Emphasize" := lblnBold;
    //             END;
    //         Rec.FIELDNO("Maximum Weight"):
    //             BEGIN
    //                 "Maximum WeightEmphasize" := lblnBold;
    //             END;
    //         Rec.FIELDNO("Maximum Cubage"):
    //             BEGIN
    //                 "Maximum CubageEmphasize" := lblnBold;
    //             END;
    //     END;
    // end;

    // procedure EditableFields();
    // var
    //     Editable: Boolean;
    // begin
    //     // <<DITW16.00.00.40 DDR 17/02/2012 DIT-715 #246
    //     //Editable := Status = Status::Open;
    //     Editable := TRUE;
    //     "Shipping Agent CodeEditable" := Editable;
    //     ShippingAgentServiceCodeEditab := Editable;
    //     "Truck CodeEditable" := Editable;
    //     "Driver CodeEditable" := Editable;
    //     "Assigned User IDEditable" := Editable;
    // end;

    // local procedure NoOnFormat();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/02/2012 DIT-715 #246
    //     FormatMaximumControls(FIELDNO("No."));
    // end;

    // local procedure MaximumWeightOnFormat();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/02/2012 DIT-715 #246
    //     FormatMaximumControls(FIELDNO("Maximum Weight"));
    // end;

    // local procedure MaximumCubageOnFormat();
    // begin
    //     // <<DITW16.00.00.40 DDR 22/02/2012 DIT-715 #246
    //     FormatMaximumControls(FIELDNO("Maximum Cubage"));
    // end;
    // BC Upgrade BHARDA11 << ----Drink-IT Functions(MaximumCubageOnFormat,MaximumWeightOnFormat,NoOnFormat,EditableFields,FormatMaximumControls)
}

