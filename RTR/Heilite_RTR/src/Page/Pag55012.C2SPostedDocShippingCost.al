page 55012 "C2S Posted Doc. Shipping Cost"
{
    // version HEI.02

    // HEI.01 CHG2175297 IBM SISUM01 30/03/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #create new page
    // HEI.02 CHG2175297 IBM SISUM01 25/04/2023 HB3191 C2S Reconciliation Report Enhancement
    //   #add Show Dimension and Show Document on Action
    //   #add Source Type Description field

    // BC Upgrade POENAB02: Original (HeiLite) page id 50262
    // code is commented, as Source Table is not available in BC - it belongs to Aptean

    // POENAB02, 11.06.2026, changes according to Aptean BC standard

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    // BC Upgrade POENAB02 >>
    //SourceTable = "Posted Document Shipping Cost";
    //SourceTableTemporary = true;
    // BC Upgrade POENAB02 <<
    //POENAB02, 11.06.2026>>
    SourceTable = "Posted Trade Cost Order APS";
    SourceTableTemporary = true;
    //POENAB02, 11.06.2026<<
    ApplicationArea = All;
    UsageCategory = Lists;
    CaptionML = ENU = 'C2S Posted Doc. Shipping Cost';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                //POENAB02, 11.06.2026>>
                /*
                field("Source Type"; "Source Type")
                {
                    Visible = true;
                }

                field("Source No."; "Source No.")
                {
                    Visible = true;
                }
                field("Source Type Description"; Rec."Source Type Description")
                {
                }
                */
                field("Posted Whse. Shipment No."; Rec."Posted Whse. Shipment No.")
                {
                    Visible = true;
                }
                field("Posted Whse. Receipt No."; Rec."Posted Whse. Receipt No.")
                {
                    Visible = true;
                }
                //POENAB02, 11.06.2026<<                                
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                }

                //POENAB02, 11.06.2026>>
                /*
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Qty. Not Invoiced"; Rec."Qty. Not Invoiced")
                {
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                }
                field("Charge Type"; Rec."Charge Type")
                {
                }
                field("Charge No."; Rec."Charge No.")
                {
                }
                field("Charge Per"; Rec."Charge Per")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                }
                */
                //POENAB02, 11.06.2026<<
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                //POENAB02, 11.06.2026>>
                /*
                field("Total Weight"; Rec."Total Weight")
                {
                }
                field("Total Cubage"; Rec."Total Cubage")
                {
                }
                field(Distance; Rec.Distance)
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
                field("Cost By Distance"; Rec."Cost By Distance")
                {
                }
                field("Physical Location Group Code"; Rec."Physical Location Group Code")
                {
                }
                */
                //POENAB02, 11.06.2026<<
                field(Status; Rec.Status)
                {
                }
                //POENAB02, 11.06.2026>>
                /*
                field("Create PO Options"; Rec."Create PO Options")
                {
                }
                */
                //POENAB02, 11.06.2026<<
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                CaptionML = ENU = '&Line',
                                FRA = '&Ligne';
                Image = Line;
                action("Show Document")
                {
                    CaptionML = ENU = 'Show Document',
                                    FRA = 'Afficher Document';
                    Image = View;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F7';

                    trigger OnAction();
                    begin
                        //POENAB02, 11.06.2026>>
                        //ShowDocument;
                        case
                            true of
                            Rec."Posted Whse. Shipment No." <> '':
                                ShowDocument(Enum::"C2S Document Type RTR"::"Posted Whse. Shipment No.", Rec."Posted Whse. Shipment No.");
                            Rec."Posted Whse. Receipt No." <> '':
                                ShowDocument(Enum::"C2S Document Type RTR"::"Posted Whse. Receipt No.", Rec."Posted Whse. Receipt No.");
                        end;
                        //POENAB02, 11.06.2026<<
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    CaptionML = ENU = 'Dimensions',
                                    FRA = 'Axes analytiques';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction();
                    begin
                        //POENAB02, 11.06.2026>>
                        //dimensions are not available in BC
                        //ShowDimensions;
                        //POENAB02, 11.06.2026<<
                        CurrPage.SAVERECORD;
                    end;
                }
            }
        }
    }

    procedure SetTmpRecords(RecRef: RecordRef);
    begin
        //HEI.04>>
        if RecRef.FINDFIRST then
            repeat
                RecRef.SETTABLE(Rec);
                Rec.INSERT;
            until RecRef.NEXT = 0;
        //HEI.04<<
    end;

    //POENAB02, 11.06.2026>>
    local procedure ShowDocument(DocType: enum "C2S Document Type RTR"; docNo: Code[20])
    var
        PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header";
        PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header";
    begin
        case
            DocType of
            Enum::"C2S Document Type RTR"::"Posted Whse. Shipment No.":
                begin
                    PostedWhseShipmentHeader.Get(docNo);
                    Page.Run(PAGE::"Posted Whse. Shipment", PostedWhseShipmentHeader);
                end;
            Enum::"C2S Document Type RTR"::"Posted Whse. Receipt No.":
                begin
                    PostedWhseReceiptHeader.Get(docNo);
                    Page.Run(PAGE::"Posted Whse. Receipt", PostedWhseReceiptHeader);
                end;
        end;
    end;

    /*
    local procedure ShowDimensions()
    var
        DimensionSetID: DimensionSetId;
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ShowDimensionSet(Rec."Dimension Set ID", STRSUBSTNO('%1 %2', TABLECAPTION, "Source No."));
    end;
    */
    //POENAB02, 11.06.2026<<
}

