page 54024 "Zone Warehouse Movement"
{//BC Upgrade Kamnay01 Original(Heilite) page id 50000
    // version HEI.01

    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #zone transfers
    // HEI.02 CC-CHG2091264 IBM.LS 22.01.2021
    //   # Fields added - "Transfer From Bin", "Transfer To Bin", "Posting Type", "Posting Date",
    //   "Registering No.", "No. Printed", "No. of Lines"
    //   # Code commented.
    // HEI.03 IBM.AK CHG2096760 (HT-1296) 11.03.21
    //  # New group Shipping with new fields Shipping Agent, shipping Agent service code, Truck code, Driver Code added
    //  # Allowedit global variable added and editable property changed for above new fields
    //  # New CheckAllowEdit function added and fucn. called on Onaftergetrecord, OnNewRecord, OninsertRecord;
    //  # New Checkmandatefields fucntion called on PostShipment action

    // BC Upgrade SHUKLP03 >>

    // Field "Truck code" and "Driver Code" code is blocked because dependency on DrinkIT Record "Whse. Shipping Truck" and "Whse. Shipping Driver" is used. 

    // BC Upgrade SHUKLP03 <<

    Caption = 'Zone Warehouse Movement';
    InsertAllowed = true;
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
    SourceTable = "Warehouse Activity Header";
    SourceTableView = WHERE(Type = FILTER(Movement));
    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
    UsageCategory = Documents; // BC Upgrade SHUKLP03 <<

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'No.';
                    Editable = false;
                    ToolTip = 'Specifies the number of the warehouse header.';

                    trigger OnAssistEdit();
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.UPDATE();
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    TableRelation = Location.Code WHERE("Zone Mandatory FND" = FILTER(true));
                    ApplicationArea = ALL;
                }
                field("From Zone Code"; Rec."From Zone Code FND")
                {
                    LookupPageID = "Zone List";
                    ApplicationArea = ALL;

                }
                field("To Zone Code"; Rec."To Zone Code FND")
                {
                    LookupPageID = "Zone List";
                    ApplicationArea = ALL;
                }
                field("In-Transit Zone"; Rec."In-Transit Zone FND")
                {
                    LookupPageID = "Zone List";
                    ApplicationArea = ALL;
                }
                field("In-Transit Bin"; Rec."In-Transit Bin FND")
                {
                    ApplicationArea = ALL;
                }
                field("Transfer From Bin"; Rec."Transfer From Bin FND")
                {
                    ApplicationArea = ALL;
                }
                field("Transfer To Bin"; Rec."Transfer To Bin FND")
                {
                    ApplicationArea = ALL;
                }
                field("Transfer Status"; Rec."Transfer Status FND")
                {
                    ApplicationArea = ALL;
                }
                field("Posting Type"; Rec."Posting Type FND")
                {
                    Editable = false;
                    ApplicationArea = ALL;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = ALL;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = ALL;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Assignment Date"; Rec."Assignment Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the date when the user was assigned the activity.';
                    ApplicationArea = ALL;
                }
                field("Assignment Time"; Rec."Assignment Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the time when the user was assigned the activity.';
                    ApplicationArea = ALL;
                }
                field("Registering No."; Rec."Registering No.")
                {
                    Editable = false;
                    ApplicationArea = ALL;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                }
                field("No. of Lines"; Rec."No. of Lines")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Shipping Agent Code"; Rec."Shipping Agent Code FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Editable = AllowEdit;
                    Enabled = AllowEdit;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Cod FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Editable = AllowEdit;
                    Enabled = AllowEdit;
                }
                field("Truck Code"; Rec."Truck Code FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Editable = AllowEdit;
                    Enabled = AllowEdit;

                    // BC Upgrade SHUKLP03 >> code blocked because DrinkIT Record "Whse. Shipping Truck" is used. 

                    // trigger OnLookup(var Text: Text): Boolean;
                    // var
                    //     //WhseShippingTruck: Record "Whse. Shipping Truck";
                    // begin
                    //     //HEI.03>>
                    //     if Rec."Shipping Agent Code" <> '' then begin
                    //         WhseShippingTruck.SETFILTER(Rec."Shipping Agent Code", '%1|%2', '', Rec."Shipping Agent Code");
                    //     end;

                    //     if PAGE.RUNMODAL(0, WhseShippingTruck) = ACTION::LookupOK then
                    //         Rec."Truck Code" := WhseShippingTruck.Code;
                    //     //HEI.03<<
                    // end;
                    // BC Upgrade SHUKLP03 >> code blocked because DrinkIT Record "Whse. Shipping Truck" is used. 

                }
                field("Driver Code"; Rec."Driver Code FND")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Editable = AllowEdit;
                    Enabled = AllowEdit;

                    // BC Upgrade SHUKLP03 >> code blocked because DrinkIT Record "Whse. Shipping Driver" is used. 
                    // trigger OnLookup(var Text: Text): Boolean;
                    // var
                    //    // WhseShippingDriver: Record "Whse. Shipping Driver";
                    // begin
                    //     //HEI.03>>
                    //     if Rec."Shipping Agent Code" <> '' then begin
                    //         WhseShippingDriver.SETFILTER(Rec."Shipping Agent Code", '%1|%2', '', "Shipping Agent Code");
                    //     end;

                    //     if PAGE.RUNMODAL(0, WhseShippingDriver) = ACTION::LookupOK then
                    //         Rec."Driver Code" := WhseShippingDriver.Code;
                    //     //HEI.03<<
                    // end;
                    // BC Upgrade SHUKLP03 >> code blocked because DrinkIT Record "Whse. Shipping Driver" is used. 

                }
            }
            part(WhseMovLines; "Zone Warehouse Mov Subform")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                SubPageLink = "Activity Type" = FIELD(Type),
                              "No." = FIELD("No."),
                              "Zone-Transfer FND" = FILTER(true);
                SubPageView = SORTING("Activity Type", "No.", "Sorting Sequence No.");
            }
        }
        area(factboxes)
        {
            part("Transaction Details"; "Zone Movement Details")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Caption = 'Transaction Details';
                SubPageLink = Type = FIELD(Type),
                              "No." = FIELD("No.");
                Visible = true;
            }
            part(Control1901796907; "Item Warehouse FactBox")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Provider = WhseMovLines;
                SubPageLink = "No." = FIELD("Item No.");
                Visible = true;
            }
            part(Control5; "Lot Numbers by Bin FactBox")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Provider = WhseMovLines;
                SubPageLink = "Item No." = FIELD("Item No."),
                              "Variant Code" = FIELD("Variant Code"),
                              "Location Code" = FIELD("Location Code");
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Movement")
            {
                Caption = '&Movement';
                Image = CreateMovement;
                action(List)
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'List';
                    Image = OpportunitiesList;
                    ShortCutKey = 'Shift+Ctrl+L';

                    trigger OnAction();
                    begin
                        Rec.LookupActivityHeader(CurrentLocationCode, Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Warehouse Comment Sheet";
                    RunPageLink = "Table Name" = CONST("Whse. Activity Header"),
                                  Type = FIELD(Type),
                                  "No." = FIELD("No.");
                }
                action("Registered Movements")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Registered Movements';
                    Image = RegisteredDocs;
                    RunObject = Page "Registered Whse. Activity List";
                    RunPageLink = Type = FIELD(Type),
                                  "Whse. Activity No." = FIELD("No.");
                    RunPageView = SORTING("Whse. Activity No.");
                }
                // BC Upgrade SHUKLP03 >> As per discussion with Sakshi, no need to work on Codeunit "N-owm Utils"
                // separator(Separator1161021001)
                // {
                // }
                // action("Show N-owm activities")
                // {
                //     Caption = 'Show N-owm activities';
                //     Image = NewResource;

                //     trigger OnAction();
                //     var
                //         OWMUtils: Codeunit "N-owm Utils";
                //     begin
                //         // NIQ OWM >>
                //         OWMUtils.ShowActivityStatus(OWMUtils.ActWhseMove, Rec."No.", Rec."Location Code");  //DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806
                //         // NIQ OWM <<
                //     end;
                // }
                // BC Upgrade SHUKLP03 >> As per discussion with Sakshi, no need to work on Codeunit "N-owm Utils"

            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Autofill Qty. to Handle")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = '&Autofill Qty. to Handle';
                    Image = AutofillQtyToHandle;

                    trigger OnAction();
                    begin
                        AutofillQtyToHandle();
                    end;
                }
                action("&Delete Qty. to Handle")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = '&Delete Qty. to Handle';
                    Image = DeleteQtyToHandle;

                    trigger OnAction();
                    begin
                        DeleteQtyToHandle();
                    end;
                }
            }
            group("&Registering")
            {
                Caption = '&Registering';
                Image = PostOrder;
                action("&Register Movement")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = '&Register Movement';
                    Image = RegisterPutAway;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = false;

                    trigger OnAction();
                    begin
                        RegisterActivityYesNo();
                    end;
                }
                action("Post Shipment")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Post Shipment';
                    Image = PostedShipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        if not CONFIRM(Text001) then
                            exit;
                        Rec."Posting Type FND" := Rec."Posting Type FND"::Ship;
                        Rec.MODIFY();
                        //HEI.02>>
                        //COMMIT;
                        //HEI.02<<
                        CheckMandateFields();//HEI.03
                        RegisterActivityYesNo()
                    end;
                }
                action("Post Receipt")
                {
                    ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                    Caption = 'Post Receipt';
                    Image = PostedReceipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        if not CONFIRM(Text002) then
                            exit;
                        Rec."Posting Type FND" := Rec."Posting Type FND"::Receive;
                        Rec.MODIFY();
                        //HEI.02>>
                        //COMMIT;
                        //HEI.02<<
                        RegisterActivityYesNo()
                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = All; // BC Upgrade SHUKLP03 <<
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    WhseActPrint.PrintMovementHeader(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        CurrentLocationCode := Rec."Location Code";
        CheckAllowEdit();//HEI.03
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        Rec.TESTFIELD("Transfer Status FND", Rec."Transfer Status FND"::Pending);
        CurrPage.UPDATE();
    end;

    trigger OnFindRecord(Which: Text): Boolean;
    begin
        exit(Rec.FindFirstAllowedRec(Which));
    end;

    trigger OnInit();
    begin
        Rec."Zone transfer FND" := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec."Zone transfer FND" := true;
        CheckAllowEdit();//HEI.03
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Zone transfer FND" := true;
        CheckAllowEdit();//HEI.03
    end;

    trigger OnNextRecord(Steps: Integer): Integer;
    begin
        exit(Rec.FindNextAllowedRec(Steps));
    end;

    trigger OnOpenPage();
    var
        ZoneWM: Page "Zone Warehouse Movements";
    begin
        //Rec.ErrorIfUserIsNotWhseEmployee();
        ZoneWM.CheckUserIsWhseEmployee_DTW();
    end;

    var
        WhseActPrint: Codeunit "Warehouse Document-Print";
        CurrentLocationCode: Code[10];
        Text001: Label 'Do you want to post the shipment?';
        Text002: Label 'Do you want to post the receipt?';
        AllowEdit: Boolean;

    local procedure AutofillQtyToHandle();
    begin
        CurrPage.WhseMovLines.PAGE.AutofillQtyToHandle();
    end;

    local procedure DeleteQtyToHandle();
    begin
        CurrPage.WhseMovLines.PAGE.DeleteQtyToHandle();
    end;

    local procedure RegisterActivityYesNo();
    begin
        CurrPage.WhseMovLines.PAGE.RegisterActivityYesNo();
    end;

    local procedure SortingMethodOnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    local procedure BreakbulkFilterOnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    local procedure CheckAllowEdit();
    begin
        //HEI.03>>
        if Rec."Transfer Status FND" = Rec."Transfer Status FND"::Pending then begin
            AllowEdit := true;
        end else
            AllowEdit := false;
        //HEI.03<<
    end;

    local procedure CheckMandateFields();
    begin
        //HEI.03>>
        if Rec."Truck Movement FND" = true then begin
            Rec.TESTFIELD("Shipping Agent Code FND");
            Rec.TESTFIELD("Shipping Agent Service Cod FND");
            Rec.TESTFIELD("Truck Code FND");
            Rec.TESTFIELD("Driver Code FND");
        end;
        //HEI.03<<
    end;
}

