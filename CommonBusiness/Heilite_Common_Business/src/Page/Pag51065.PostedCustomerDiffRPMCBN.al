page 51065 "Posted Customer Diff (RPM) CBN"
{
    // HEI.01 FDD-RW-GAPLOG10 IBM ISYED01 30-10-2018 RPM Breakages
    //   #Created new Page created for RPM Breakages
    // HEI.02 FDD-HT88 BULIMC01 IBM 31/10/2019 # new report added for "Create Cr. Memo" action
    // BC Upgrade BHARDA11 >>
    // 1. Add ApplicationArea property in page and Actions.
    // 2. Create New Functions GetSelectionFilterForPCRPM_SROrderNo, GetSelectionFilterForPCRPM_Item and replace with selectionfilltermanagement function
    // BC Upgrade BHARDA11 <<

    //BC UPGRADE SHIKHD02>>
    //1. Added missing Caption to Page
    //2. Blocked code "Image = close" and added a valid action icon "Image = Close" in action("Close Lines") to remove warning
    //BC UPGRADE SHIKHD02<<
    Caption = 'Posted Customer Diff (RPM)'; //BC UPGRADE SHIKHD02<<
    PageType = List;
    SourceTable = "Posted Customer Diff RPM FND";
    ApplicationArea = All; // BC Upgrade BHARDA11
    UsageCategory = Lists; // BC Upgrade BHARDA11

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Enabled = false;
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("UOM Code"; Rec."UOM Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the UOM Code field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field("Deposit Price"; Rec."Deposit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Price field.';
                }
                field("RPM Missing Bottle"; Rec."RPM Missing Bottle")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Missing Bottle field.';
                }
                field("RPM Broken"; Rec."RPM Broken")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Broken field.';
                }
                field("RPM Chipped"; Rec."RPM Chipped")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Chipped field.';
                }
                field("RPM Missing crate"; Rec."RPM Missing crate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM Missing crate field.';
                }
                field("Sell-to customer no."; Rec."Sell-to customer no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to customer no. field.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sell-to Customer Name field.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer No. field.';
                }
                field("Bill-to Customer name"; Rec."Bill-to Customer name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill-to Customer name field.';
                }
                field("Compensation RPM Diff."; Rec."Compensation RPM Diff.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Compensation RPM Diff. field.';
                }
                field("Sales return order no."; Rec."Sales return order no.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales return order no. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Posted Sales Return receipt No"; Rec."Posted Sales Return receipt No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Sales Return receipt No field.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed field.';
                }
                field("Closed By Document No."; Rec."Closed By Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed By Document No. field.';
                }
                field("Closed By Posting Date"; Rec."Closed By Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed By Posting Date field.';
                }
                field("Closed By User Id"; Rec."Closed By User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed By User Id field.';
                }
                field("Closed on Date"; Rec."Closed on Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Closed on Date field.';
                }
                field("RPM comp.Sales Credit memo No."; Rec."RPM comp.Sales Credit memo No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RPM comp.Sales Credit memo No. field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Customer Difference")
            {
                CaptionML = ENU = 'Customer Difference',
                            FRA = '&Commande';
                Image = "Order";
                action("Close Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Close Lines';
                    //BC UPGRADE SHIKHD02>>
                    //Blocked code "Image = close" and added a valid action icon "Image = Close"
                    //Image = close;
                    Image = Close;
                    //BC UPGRADE SHIKHD02<<
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ShortCutKey = 'F6';
                    ToolTipML = ENU = 'Cloes lines will navigate to posted sales credit memo to close the lines with customer differences',
                                FRA = 'Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement.';

                    trigger OnAction();
                    var
                        PostedCustomerDiffRPM: Record "Posted Customer Diff RPM FND";
                        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                        Handled: Boolean;
                    begin
                        CurrPage.SETSELECTIONFILTER(Rec);
                        if not CONFIRM(Text001, false, '') then begin
                            Rec.RESET();
                            if Called4mparrentPage = '21' then begin
                                Rec.SETCURRENTKEY("Sell-to customer no.");
                                Rec.SETFILTER("Sell-to customer no.", Rec."Sell-to customer no.");
                            end
                            else begin
                                Rec.SETCURRENTKEY("Sales return order no.");
                                Rec.SETFILTER("Sales return order no.", PostedCustomerDiffRPM."Sales return order no.");
                            end;
                        end
                        else begin
                            CLEAR(noFilter);
                            CLEAR(SalesRetOrderNoFilter);
                            CurrPage.SETSELECTIONFILTER(Rec);
                            if Rec.findset() then begin
                                repeat
                                    if noFilter = '' then begin
                                        noFilter := GetItemSelectionFilter();
                                        ;
                                    end;
                                    if SalesRetOrderNoFilter = '' then begin
                                        SalesRetOrderNoFilter := GetSROSelectionFilter();
                                    end
                                until Rec.NEXT() = 0;
                            end;

                            PostedCustomerDiffRPM.RESET();
                            if Called4mparrentPage <> '21' then
                                PostedCustomerDiffRPM.SETFILTER("Sales return order no.", SalesRetOrderNoFilter)
                            else begin
                                PostedCustomerDiffRPM.SETRANGE("Sell-to customer no.", Rec."Sell-to customer no.");
                                PostedCustomerDiffRPM.SETFILTER("Sales return order no.", SalesRetOrderNoFilter);
                            end;

                            PostedCustomerDiffRPM.SETFILTER("Item No.", noFilter);
                            if PostedCustomerDiffRPM.findset() then begin
                                repeat
                                    PostedCustomerDiffRPM.Closed := true;
                                    PostedCustomerDiffRPM."Closed By User Id" := USERID;
                                    PostedCustomerDiffRPM."Closed on Date" := TODAY;
                                    PostedCustomerDiffRPM.MODIFY();
                                until PostedCustomerDiffRPM.NEXT() = 0;
                            end;
                        end;
                        COMMIT();
                        Rec.RESET();
                        if Called4mparrentPage = '21' then begin
                            Rec.SETCURRENTKEY("Sell-to customer no.");
                            Rec.SETFILTER("Sell-to customer no.", Rec."Sell-to customer no.");
                        end
                        else begin
                            Rec.SETCURRENTKEY("Sales return order no.");
                            Rec.SETFILTER("Sales return order no.", PostedCustomerDiffRPM."Sales return order no.");
                        end;
                    end;
                }
                action("Reverse Closed Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reverse Closed Lines';
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ShortCutKey = 'F7';
                    ToolTipML = ENU = 'Cloesed lines can be reversed with this action button',
                                FRA = 'Affichez les informations statistiques telles que la valeur des écritures validées pour l''enregistrement.';

                    trigger OnAction();
                    var
                        PostedCustomerDiffRPM: Record "Posted Customer Diff RPM FND";
                        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                        Handled: Boolean;
                    begin

                        if (Rec."RPM comp.Sales Credit memo No." <> '') and (Rec."RPM comp.Sales Credit memo No." <> '') and (Rec.Closed = true) then begin
                            MESSAGE(Text005, Rec."Closed By Document No.");
                            exit;
                        end
                        else if (Rec.Closed = false) and (Rec."Closed By Document No." = '') and (Rec."RPM comp.Sales Credit memo No." <> '') then begin
                            MESSAGE(Text005, Rec."Closed By Document No.");
                            exit;
                        end;

                        CurrPage.SETSELECTIONFILTER(Rec);
                        if not CONFIRM(Text002, false, '') then begin
                            Rec.RESET();
                            if Called4mparrentPage = '21' then begin
                                Rec.SETCURRENTKEY("Sell-to customer no.");
                                Rec.SETFILTER("Sell-to customer no.", Rec."Sell-to customer no.");
                            end
                            else begin
                                Rec.SETCURRENTKEY("Sales return order no.");
                                Rec.SETFILTER("Sales return order no.", PostedCustomerDiffRPM."Sales return order no.");
                            end;
                        end
                        else begin
                            CLEAR(noFilter);
                            CLEAR(SalesRetOrderNoFilter);
                            CurrPage.SETSELECTIONFILTER(Rec);
                            if Rec.findset() then begin
                                repeat
                                    if noFilter = '' then begin
                                        noFilter := GetItemSelectionFilter();
                                        ;
                                    end;
                                    if SalesRetOrderNoFilter = '' then begin
                                        SalesRetOrderNoFilter := GetSROSelectionFilter();
                                    end
                                until Rec.NEXT() = 0;
                            end;

                            PostedCustomerDiffRPM.RESET();
                            if Called4mparrentPage <> '21' then
                                PostedCustomerDiffRPM.SETFILTER("Sales return order no.", SalesRetOrderNoFilter)
                            else begin
                                PostedCustomerDiffRPM.SETRANGE("Sell-to customer no.", Rec."Sell-to customer no.");
                                PostedCustomerDiffRPM.SETFILTER("Sales return order no.", SalesRetOrderNoFilter);
                            end;

                            PostedCustomerDiffRPM.SETFILTER("Item No.", noFilter);
                            if PostedCustomerDiffRPM.findset() then begin
                                repeat
                                    PostedCustomerDiffRPM.Closed := false;
                                    PostedCustomerDiffRPM."Closed By Document No." := '';
                                    PostedCustomerDiffRPM."Closed By Posting Date" := 0D;
                                    PostedCustomerDiffRPM."Closed By User Id" := '';
                                    PostedCustomerDiffRPM."Closed on Date" := 0D;
                                    PostedCustomerDiffRPM.MODIFY();
                                until PostedCustomerDiffRPM.NEXT() = 0;
                            end
                            else
                                MESSAGE(Text004);
                        end;
                        COMMIT();
                        Rec.RESET();
                        if Called4mparrentPage = '21' then begin
                            Rec.SETCURRENTKEY("Sell-to customer no.");
                            Rec.SETFILTER("Sell-to customer no.", Rec."Sell-to customer no.");
                        end
                        else begin
                            Rec.SETCURRENTKEY("Sales return order no.");
                            Rec.SETFILTER("Sales return order no.", PostedCustomerDiffRPM."Sales return order no.");
                        end;
                    end;
                }
                action("&Navigate")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = '&Navigate',
                                FRA = 'Na&viguer';
                    Image = Navigate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTipML = ENU = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.',
                                FRA = 'Recherchez toutes les écritures et tous les documents qui existent pour le numéro de document et la date comptabilisation sur l''écriture ou le document.';

                    trigger OnAction();
                    begin
                        Rec.Navigate();
                    end;
                }
                action("Create RPM Compensate Cr. Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Create RPM Compensate Cr. Memos';
                    ToolTip = 'Executes the Create RPM Compensate Cr. Memos action.';

                    trigger OnAction();
                    begin
                        if (Rec."Closed By Document No." = '') and (Rec."RPM comp.Sales Credit memo No." = '') and (Rec.Closed = false) then begin
                            // ReturnReceiptHeader.RESET;
                            //ReturnReceiptHeader.SETFILTER("No.",Rec."Posted Sales Return receipt No"); //commented HEI.02
                            //REPORT.RUN(50254,TRUE,FALSE,ReturnReceiptHeader); //commented HEI.02
                            REPORT.RUN(50377, true, false, Rec)  //HEI.02
                        end else
                            MESSAGE(Text003, Rec."RPM comp.Sales Credit memo No.");
                    end;
                }
            }
        }
    }

    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        HeinekenGlobal: Codeunit "Heineken Global";
        PostedSalesCreditMemoPage: Page "Posted Sales Credit Memos";
        Called4mparrentPage: Code[20];
        Text001: Label 'Are you sure to check the lines as closed?';
        Text002: Label 'Are you sure to uncheck the lines as closed?';
        Text003: Label 'CR. Memo %1 is already Created / Posted for this document.';
        Text004: Label 'Manually closed document can only be Reversed.';
        Text005: Label 'This document cannot be reversed since, CR. Memo %1 is already Created / Posted for this document.';
        noFilter: Text[500];
        SalesRetOrderNoFilter: Text[500];

    procedure SetPageNamecalledfrom(CallerPageCode: Code[20]);
    begin
        Called4mparrentPage := DELSTR(CallerPageCode, 1, 5);
    end;

    procedure GetItemSelectionFilter(): Text;
    var
        Loc: Record Location;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        // exit(SelectionFilterManagement.GetSelectionFilterForPCRPM_Item(Rec)); // BC Upgrade BHARDA11 >> --- Use custom function
        exit(GetSelectionFilterForPCRPM_Item(Rec)); // BC Upgrade BHARDA11 >> --- Use custom function
    end;

    procedure GetSROSelectionFilter(): Text;
    var
        Loc: Record Location;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        // exit(SelectionFilterManagement.GetSelectionFilterForPCRPM_SROrderNo(Rec)); // BC Upgrade BHARDA11 >> --- Use custom function
        exit(GetSelectionFilterForPCRPM_SROrderNo(Rec)); // BC Upgrade BHARDA11 >> --- Use custom function
    end;
    // BC Upgrade BHARDA11 >> --- We need to create custom function in the place of SelectionFilterManagement
    procedure GetSelectionFilterForPCRPM_Item(var PosCustDiffRPM: Record "Posted Customer Diff RPM FND"): Text
    var
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    begin
        RecRef.GetTable(PosCustDiffRPM);
        exit(SelectionFilterManagement.GetSelectionFilter(RecRef, PosCustDiffRPM.FieldNo("Item No.")));
    end;

    procedure GetSelectionFilterForPCRPM_SROrderNo(VAR CustomerDifferencesRPM: Record "Posted Customer Diff RPM FND"): Text
    Var
        SelectionFilter: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    Begin

        RecRef.GETTABLE(CustomerDifferencesRPM);
        EXIT(SelectionFilter.GetSelectionFilter(RecRef, CustomerDifferencesRPM.FIELDNO("Sales return order no.")));

    End;
    // BC Upgrade BHARDA11 << --- We need to create custom function in the place of SelectionFilterManagement

}

