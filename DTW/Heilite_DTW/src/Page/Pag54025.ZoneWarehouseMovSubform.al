page 54025 "Zone Warehouse Mov Subform"
{
    // version HEI.01
    //BC Upgrade Kamnay01 Original(Heilite) page id 50001
    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #zone transfers
    // HEI.02 CC-CHG2091264 IBM.LS 14.11.2020
    //   # Changed SourceTableView -
    //     SORTING(Activity Type,No.,Line No.) ORDER(Ascending) WHERE(Activity Type=FILTER(Movement))
    //   # Changed AutoSplitKey - No
    //   # Field added - "Linked To Line No."
    //   # Code added.
    // HEI.03 CHG2075364 IBM.LS      20.07.2021
    //   # Created New Menu - Item &Tracking Lines
    //   # Added Code
    //   # Changed Property - Lookup as No in Lot No. field.

    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    PopulateAllFields = true;
    ApplicationArea = ALL; // BC Upgrade SHUKLP03 <<
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<
    SourceTable = "Warehouse Activity Line";
    SourceTableView = SORTING("Activity Type", "No.", "Line No.")
                      ORDER(Ascending)
                      WHERE("Activity Type" = FILTER(Movement));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = ALL;
                }
                field("Action Type"; Rec."Action Type")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the action type for the warehouse activity line.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = ALL;
                    TableRelation = Location.Code WHERE("Zone Mandatory FND" = FILTER(true));
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = ALL;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the item number of the item to be handled, such as picked or put away.';

                    trigger OnValidate();
                    begin
                        CurrPage.SAVERECORD();
                        //HEI.02>>
                        //HooksFunc.UpdateRelatedActivityLine(Rec);
                        HooksFunc.CallUpdateRelatedActivityLine(Rec);
                        //HEI.02<<
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = ALL;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the variant code of the item to be handled.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Variant Code"));
                        //HEI.02<<
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies a description of the item on the line.';
                }
                field("Linked To Line No."; Rec."Linked To Line No. FND")
                {
                    ApplicationArea = ALL;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = ALL;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the serial number to handle in the document.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Serial No."));
                        //HEI.02<<

                        SerialNoOnAfterValidate();
                    end;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = ALL;
                    Enabled = AllowEdit;
                    Lookup = false;
                    ToolTip = 'Specifies the lot number to handle in the document.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Lot No."));
                        //HEI.02<<

                        LotNoOnAfterValidate();
                    end;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                    ToolTip = 'Specifies the expiration date of the serial/lot numbers if you are putting items away.';
                    Visible = false;
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = ALL;
                    Caption = 'Zone Code';
                    LookupPageID = "Zone List";
                    ToolTip = 'Specifies the zone code where the bin on this line is located.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Zone Code"));
                        //HEI.02<<
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = ALL;
                    Caption = 'Bin Code';
                    ToolTip = 'Specifies the bin where items on the line are handled.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Bin Code"));
                        //HEI.02<<

                        BinCodeOnAfterValidate();
                    end;
                }
                field("Special Equipment Code"; Rec."Special Equipment Code")
                {
                    ApplicationArea = ALL;
                    Caption = 'Special Equipment Code';
                    ToolTip = 'Specifies the code of the equipment required when you perform the action on the line.';
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = ALL;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the quantity of the item to be handled, such as received, put-away, or assigned.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION(Quantity));
                        //HEI.02<<
                    end;
                }
                field("Qty. (Base)"; Rec."Qty. (Base)")
                {
                    ApplicationArea = ALL;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the quantity of the item to be handled, in the base unit of measure.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Qty. (Base)"));
                        //HEI.02<<
                    end;
                }
                field("Qty. to Handle"; Rec."Qty. to Handle")
                {
                    ApplicationArea = ALL;
                    Editable = AllowEditQtyHandle;
                    ToolTip = 'Specifies how many units to handle in this warehouse activity.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Qty. to Handle"));
                        //HEI.02<<

                        HooksFunc.OnBeforeValidateQtytoHandleWhseActivLine(Rec, xRec, 0);//HEI.01 PRDGAP024 single
                        QtytoHandleOnAfterValidate();
                    end;
                }
                field("Qty. to Handle (Base)"; Rec."Qty. to Handle (Base)")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                    ToolTip = 'Specifies the quantity of items to be handled in this warehouse activity.';
                    Visible = false;
                }
                field("Qty. Outstanding"; Rec."Qty. Outstanding")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the number of items that have not yet been handled for this warehouse activity line.';
                }
                field("Qty. Outstanding (Base)"; Rec."Qty. Outstanding (Base)")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the number of items, expressed in the base unit of measure, that have not yet been handled for this warehouse activity line.';
                }
                field("Quantity Shipped"; Rec."Quantity Shipped FND")
                {
                    ApplicationArea = ALL;
                }
                field("Quantity Received"; Rec."Quantity Received FND")
                {
                    ApplicationArea = ALL;
                }
                field(QtyInTransit; QtyInTransit)
                {
                    ApplicationArea = ALL;
                    Caption = 'Qty. in transit';
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the date when the warehouse activity must be completed.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Due Date"));
                        //HEI.02<<
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = ALL;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the unit of measure code of the item on the line.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Unit of Measure Code"));
                        //HEI.02<<
                    end;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = ALL;
                    Editable = AllowEdit;
                    ToolTip = 'Specifies the quantity per unit of measure of the item on the line.';

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION("Qty. per Unit of Measure"));
                        //HEI.02<<
                    end;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the total weight of the items on the line, calculated based on the Quantity field.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION(Weight));
                        //HEI.02<<
                    end;
                }
                field(Cubage; Rec.Cubage)
                {
                    ApplicationArea = ALL;
                    ToolTip = 'Specifies the total cubage of items on the line, calculated based on the Quantity field.';
                    Visible = false;

                    trigger OnValidate();
                    begin
                        //HEI.02>>
                        ValidateItem(Rec."Item No.", Rec.FIELDCAPTION(Cubage));
                        //HEI.02<<
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Split Line")
                {
                    Caption = '&Split Line';
                    Image = Split;
                    ShortCutKey = 'Ctrl+F11';

                    trigger OnAction();
                    begin
                        CallSplitLine();
                    end;
                }
                action(ChangeUnitOfMeasure)
                {
                    Caption = '&Change Unit Of Measure';
                    Ellipsis = true;
                    Image = UnitConversions;

                    trigger OnAction();
                    begin
                        ChangeUOM();
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("Bin Contents List")
                {
                    Caption = 'Bin Contents List';
                    Image = BinContent;

                    trigger OnAction();
                    begin
                        ShowBinContents();
                    end;
                }
                action(ItemTrackingLines)
                {
                    CaptionML = ENU = 'Item &Tracking Lines',
                                FRA = 'Lignes &traçabilité';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction();
                    var
                        Text000L: Label 'Please select Take line (%1) instead of Place line (%2) to assign Lot/s for Item %3.';
                    begin
                        //HEI.03>>
                        if Rec."Action Type" = Rec."Action Type"::Take then
                            Rec.OpenItemTrackingLines()
                        else
                            ERROR(Text000L, Rec."Linked To Line No. FND", Rec."Line No.", Rec."Item No.");
                        //HEI.03<<
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        CheckAllowEdit();
    end;

    trigger OnAfterGetRecord();
    begin
        CalcQtyInTransit();
        CheckAllowEdit();
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        WarehouseActivityLine: Record "Warehouse Activity Line";
        WarehouseActivityHdr: Record "Warehouse Activity Header";
    begin
        if WarehouseActivityHdr.GET(Rec."Activity Type", Rec."No.") then
            WarehouseActivityHdr.TESTFIELD("Transfer Status FND", WarehouseActivityHdr."Transfer Status FND"::Pending);
        if Rec."Action Type" = Rec."Action Type"::Place then
            exit(false);
        if Rec."Action Type" = Rec."Action Type"::Take then begin
            if WarehouseActivityLine.GET(Rec."Activity Type", Rec."No.", Rec."Linked To Line No. FND") then
                WarehouseActivityLine.DELETE(true);
        end;
        CurrPage.UPDATE(false);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    var
        WarehouseActivityHdr: Record "Warehouse Activity Header";
    begin
        if WarehouseActivityHdr.GET(Rec."Activity Type", Rec."No.") then
            WarehouseActivityHdr.TESTFIELD("Transfer Status FND", WarehouseActivityHdr."Transfer Status FND"::Pending);
        CheckAllowEdit();
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    var
        WarehouseActivityHeader: Record "Warehouse Activity Header";
    begin
        if WarehouseActivityHeader.GET(Rec."Activity Type"::Movement, Rec."No.") then begin
            Rec."Location Code" := WarehouseActivityHeader."Location Code";
            Rec."Action Type" := Rec."Action Type"::Take;
            Rec.VALIDATE("Location Code", WarehouseActivityHeader."Location Code");
            Rec.VALIDATE("Zone Code", WarehouseActivityHeader."From Zone Code FND");
            Rec.VALIDATE("In-Transit Zone Code FND", WarehouseActivityHeader."In-Transit Zone FND");
            Rec.VALIDATE("In-Transit Bin Code FND", WarehouseActivityHeader."In-Transit Bin FND");
        end;
        CheckAllowEdit();
    end;

    var
        HooksFunc: Codeunit "WHS-UTILS";
        QtyInTransit: Decimal;
        AllowEdit: Boolean;
        AllowEditQtyHandle: Boolean;

    procedure AutofillQtyToHandle();
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        WhseActivLine.COPY(Rec);
        Rec.AutofillQtyToHandle(WhseActivLine);
    end;

    procedure DeleteQtyToHandle();
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        WhseActivLine.COPY(Rec);
        Rec.DeleteQtyToHandle(WhseActivLine);
    end;

    local procedure CallSplitLine();
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        WhseActivLine.COPY(Rec);
        Rec.SplitLine(WhseActivLine);
        CurrPage.UPDATE(false);
    end;

    local procedure ChangeUOM();
    var
        WhseActLine: Record "Warehouse Activity Line";
        WhseChangeOUM: Report "Whse. Change Unit of Measure";
    begin
        Rec.TESTFIELD("Action Type");
        Rec.TESTFIELD("Breakbulk No.", 0);
        Rec.TESTFIELD("Qty. to Handle");
        WhseChangeOUM.DefWhseActLine(Rec);
        WhseChangeOUM.RUNMODAL();
        if WhseChangeOUM.ChangeUOMCode(WhseActLine) = true then
            Rec.ChangeUOMCode(Rec, WhseActLine);
        CLEAR(WhseChangeOUM);
        CurrPage.UPDATE(false);
    end;

    procedure RegisterActivityYesNo();
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        WhseActivLine.COPY(Rec);
        WhseActivLine.FILTERGROUP(3);
        WhseActivLine.SETRANGE(Breakbulk);
        WhseActivLine.FILTERGROUP(0);
        CODEUNIT.RUN(CODEUNIT::"Whse.-Act.-Register (Yes/No)", WhseActivLine);
        Rec.RESET();
        Rec.SETCURRENTKEY("Activity Type", "No.", "Sorting Sequence No.");
        Rec.FILTERGROUP(4);
        Rec.SETRANGE("Activity Type", Rec."Activity Type");
        Rec.SETRANGE("No.", Rec."No.");
        Rec.FILTERGROUP(3);
        Rec.SETRANGE(Breakbulk, false);
        Rec.FILTERGROUP(0);
        CurrPage.UPDATE(false);
    end;

    local procedure ShowBinContents();
    var
        BinContent: Record "Bin Content";
    begin
        BinContent.ShowBinContents(Rec."Location Code", Rec."Item No.", Rec."Variant Code", '');
    end;

    local procedure SerialNoOnAfterValidate();
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ExpDate: Date;
        EntriesExist: Boolean;
        ItemTrackSetup: Record "Item Tracking Setup";
    begin
        if Rec."Serial No." <> '' then begin
            ItemTrackSetup."Lot No." := Rec."Lot No.";
            ItemTrackSetup."Serial No." := Rec."Serial No.";
            ExpDate := ItemTrackingMgt.ExistingExpirationDate(Rec."Item No.", Rec."Variant Code",
                ItemTrackSetup, false, EntriesExist);
        end;
        if ExpDate <> 0D then
            Rec."Expiration Date" := ExpDate;
    end;

    local procedure LotNoOnAfterValidate();
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ExpDate: Date;
        EntriesExist: Boolean;
        ItemTrackSetup: Record "Item Tracking Setup";
    begin
        if Rec."Lot No." <> '' then begin
            ItemTrackSetup."Lot No." := Rec."Lot No.";
            ItemTrackSetup."Serial No." := Rec."Serial No.";

            ExpDate := ItemTrackingMgt.ExistingExpirationDate(Rec."Item No.", Rec."Variant Code",
                ItemTrackSetup, false, EntriesExist);
        end;
        if ExpDate <> 0D then
            Rec."Expiration Date" := ExpDate;
    end;

    local procedure BinCodeOnAfterValidate();
    begin
        CurrPage.UPDATE();
    end;

    local procedure QtytoHandleOnAfterValidate();
    begin
        CurrPage.SAVERECORD();
    end;

    local procedure CalcQtyInTransit();
    var
        WarehouseEntry: Record "Warehouse Entry";
    begin
        QtyInTransit := 0;
        WarehouseEntry.SETCURRENTKEY("Movement No. FND");
        WarehouseEntry.SETRANGE("Movement No. FND", Rec."No.");
        WarehouseEntry.SETRANGE("Transit-Zone FND", true);
        WarehouseEntry.SETFILTER("Reference Line No. FND", '%1|%2', Rec."Line No.", Rec."Linked To Line No. FND");
        if WarehouseEntry.findset() then
            repeat
                QtyInTransit += WarehouseEntry.Quantity;
            until WarehouseEntry.NEXT() = 0;
    end;

    local procedure CheckAllowEdit();
    begin
        AllowEdit := Rec.IsEditable();  // BC Upgrade NANDIS03
        if Rec."Activity Type" = Rec."Action Type"::Place then begin
            AllowEdit := false;
            AllowEditQtyHandle := false;
        end else
            AllowEditQtyHandle := true;
    end;

    local procedure ValidateItem(ItemNo: Code[20]; FieldCaption: Text[30]);
    var
        Text00L: Label 'Please enter Item No. before entering %1.';
    begin
        //HEI.02>>
        if ItemNo = '' then
            ERROR(Text00L, FieldCaption);
        //HEI.02<<
    end;
}

