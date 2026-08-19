page 50228 "Navigate Gate Entry"
{
    // version HEI.01

    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008: BrewIt & Quality
    // DITW15.00.00.26 DDR 31/10/2008 Delayed discount & Promotion Entry
    // DITW15.00.00.28 DDR 27/11/2008 AAD Document Tracking Entry
    //                                Added functions
    //                                 FindAADTrackingRecords(),ClearAADTrackingInfo(),SetAADTracking(),ItemAADTrackingSearch()
    // HIT0040.1 BGI 19/01/2009 : 2 records possible for customer ledger entries with deposit...
    // HEI:EDD002:1:1 28/07/09 TECTURA.SKS
    //   # Added code to show WHT Entry
    // DITW15.00.00.35 DDR 11/09/2009 Added Purchase Service tables
    //                                Added functions
    //                                  FindUnpostedServPurchDocs()
    // 
    // HEI:EDD001:1:1 12/11/14 TECTURA-HKH
    //   # New Form Created for Gate Entry
    // HEI.01 FDD-RW-LOGGAP09 IBM NASTAA02 28.09.2018 # Gate Control
    //   # Copied Page from HEI2.0

    // BC Upgrade PATELS08 >>
    // # In procedure 'InsertIntoDocEntry' Changed the data type of DocType parameter to Enum "Document Entry Document Type" as Implicit conversion from Integer to Enum can cause runtime error
    // # Crated varaible 'DocType' in FindRecords procedure
    // # Passing Enum DocType instead of Option to prevent runtime error in 'InsertIntoDocEntry' (called in FindRecords pocedure) 
    // BC Upgrade PATELS08 <<

    CaptionML = ENU = 'Navigate',
                FRA = 'Naviguer';
    PageType = Card;
    SaveValues = true;
    SourceTable = "Document Entry";
    SourceTableTemporary = true;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            FRA = 'General';
                field(DocNoFilter; DocNoFilter)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Document No.',
                                FRA = 'N° document';
                    ToolTip = 'Specifies the value of the DocNoFilter field.';

                    trigger OnValidate();
                    begin
                        SetDocNo(DocNoFilter);
                        DocNoFilterOnAfterValidate();
                    end;
                }
            }
            group(Control7)
            {
                field(DocType; DocType)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Document Type',
                                FRA = 'Type document';
                    Editable = false;
                    Enabled = DocTypeEnable;
                    ToolTip = 'Specifies the value of the DocType field.';
                }
                field(SourceType; SourceType)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Source Type',
                                FRA = 'Type origine';
                    Editable = false;
                    Enabled = SourceTypeEnable;
                    ToolTip = 'Specifies the value of the SourceType field.';
                }
                field(SourceNo; SourceNo)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Source No.',
                                FRA = 'N° origine';
                    Editable = false;
                    Enabled = SourceNoEnable;
                    ToolTip = 'Specifies the value of the SourceNo field.';
                }
                field(SourceName; SourceName)
                {
                    ApplicationArea = Basic, Suite;
                    CaptionML = ENU = 'Source Name',
                                FRA = 'Nom origine';
                    Editable = false;
                    Enabled = SourceNameEnable;
                    ToolTip = 'Specifies the value of the SourceName field.';
                }
            }
            repeater(Control16)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ToolTip = 'Specifies the table ID.';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the table.';
                }
                field("No. of Records"; Rec."No. of Records")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = true;
                    ToolTip = 'Specifies the number of records in the table for upgrade.';

                    trigger OnDrillDown();
                    begin
                        ShowRecords();
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Show)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = '&Show',
                            FRA = 'Affic&her';
                Enabled = ShowEnable;
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Show action.';

                trigger OnAction();
                begin
                    ShowRecords();
                end;
            }
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = '&Print',
                            FRA = '&Imprimer';
                Ellipsis = true;
                Enabled = PrintEnable;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Print action.';

                trigger OnAction();
                var
                    DocumentEntries: Report "Document Entries";
                    ItemTrackingNavigate: Report "Item Tracking Navigate";
                begin
                    DocumentEntries.TransferDocEntries(Rec);
                    DocumentEntries.TransferFilters(DocNoFilter, PostingDateFilter);
                    DocumentEntries.RUN();
                end;
            }
            action("Fi&nd")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Fi&nd',
                            FRA = '&Rechercher';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Fi&nd action.';

                trigger OnAction();
                begin
                    FindPush();
                end;
            }
        }
    }

    trigger OnInit();
    begin
        SourceNameEnable := true;
        SourceNoEnable := true;
        SourceTypeEnable := true;
        DocTypeEnable := true;
        PrintEnable := true;
        ShowEnable := true;
    end;

    trigger OnOpenPage();
    begin
        if (NewDocNo = '') then begin
            rec.DELETEALL();
            ShowEnable := false;
            PrintEnable := false;
            SetSource(0D, '', '', 0, '');
        end else begin
            rec.SETRANGE("Document No.", NewDocNo);
            DocNoFilter := rec.GETFILTER("Document No.");
            FindRecords();
        end;
    end;

    var
        Cust: Record Customer;
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        ReturnRcptHeader: Record "Return Receipt Header";
        ReturnShptHeader: Record "Return Shipment Header";
        SCMSalesHeader: Record "Sales Header";
        SISalesHeader: Record "Sales Header";
        SOSalesHeader: Record "Sales Header";
        SROSalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesShptHeader: Record "Sales Shipment Header";
        TransRcptHeader: Record "Transfer Receipt Header";
        TransShptHeader: Record "Transfer Shipment Header";
        Vend: Record Vendor;
        ApplicationManagement: Codeunit "Application Area Mgmt.";
        DocExists: Boolean;

        DocTypeEnable: Boolean;

        PrintEnable: Boolean;

        ShowEnable: Boolean;

        SourceNameEnable: Boolean;

        SourceNoEnable: Boolean;

        SourceTypeEnable: Boolean;
        NewDocNo: Code[20];
        SourceNo: Code[20];
        DocNoFilter: Code[250];
        Window: Dialog;
        SourceType: Text[30];
        DocType: Text[50];
        SourceName: Text[50];
        PostingDateFilter: Text[250];
        sText003: TextConst ENU = 'Posted Service Invoice', FRA = 'Facture service enreg.';
        sText004: TextConst ENU = 'Posted Service Credit Memo', FRA = 'Avoir service enreg.';
        sText005: TextConst ENU = 'Posted Service Shipment', FRA = 'Expédition service enreg.';
        sText021: TextConst ENU = 'Service Order', FRA = 'Commande service';
        sText022: TextConst ENU = 'Service Invoice', FRA = 'Facture service';
        sText024: TextConst ENU = 'Service Credit Memo', FRA = 'Avoir service';
        Text000: TextConst ENU = 'The business contact type was not specified.', FRA = 'Le type d''identifiant tiers n''a pas été spécifié.';
        Text001: TextConst ENU = 'There are no posted records with this external document number.', FRA = 'Il n''existe pas d''enregistrement comptabilisé avec ce numéro de document externe.';
        Text002: TextConst ENU = 'Counting records...', FRA = 'Comptage des enregistrements...';
        Text003: TextConst ENU = 'Posted Sales Invoice', FRA = 'Facture vente enregistrée';
        Text004: TextConst ENU = 'Posted Sales Credit Memo', FRA = 'Avoir vente enregistré';
        Text005: TextConst ENU = 'Posted Sales Shipment', FRA = 'Expédition vente enregistrée';
        Text006: TextConst ENU = 'Issued Reminder', FRA = 'Relances émises';
        Text007: TextConst ENU = 'Issued Finance Charge Memo', FRA = 'Factures d''intérêts émises';
        Text008: TextConst ENU = 'Posted Purchase Invoice', FRA = 'Facture achat enregistrée';
        Text009: TextConst ENU = 'Posted Purchase Credit Memo', FRA = 'Avoir achat enregistré';
        Text010: TextConst ENU = 'Posted Purchase Receipt', FRA = 'Réception achat enregistrée';
        Text011: TextConst ENU = 'The document number has been used more than once.', FRA = 'Le numéro de document a été utilisé plusieurs fois.';
        Text012: TextConst ENU = 'This combination of document number and posting date has been used more than once.', FRA = 'Cette combinaison de numéro de document et de date de comptabilisation a été utilisée plusieurs fois.';
        Text013: TextConst ENU = 'There are no posted records with this document number.', FRA = 'Il n''existe pas d''enregistrement comptabilisé avec ce numéro de document.';
        Text014: TextConst ENU = 'There are no posted records with this combination of document number and posting date.', FRA = 'Il n''existe pas d''enregistrement pour cette combinaison de numéro de document et de date de comptabilisation.';
        Text015: TextConst ENU = 'The search results in too many external documents. Please specify a business contact no.', FRA = 'Trop de documents externes ont été trouvés. Veuillez spécifier un identifiant tiers.';
        Text016: TextConst ENU = 'The search results in too many external documents. Please use Navigate from the relevant ledger entries.', FRA = 'Trop de documents externes ont été trouvés. Utilisez la fonction Naviguer à partir des écritures correspondantes.';
        Text017: TextConst ENU = 'Posted Return Receipt', FRA = 'Réception retour enreg.';
        Text018: TextConst ENU = 'Posted Return Shipment', FRA = 'Expédition retour enreg.';
        Text019: TextConst ENU = 'Posted Transfer Shipment', FRA = 'Expédition transfert enreg.';
        Text020: TextConst ENU = 'Posted Transfer Receipt', FRA = 'Réception transfert enreg.';
        Text021: TextConst ENU = 'Sales Order', FRA = 'Commande vente';
        Text022: TextConst ENU = 'Sales Invoice', FRA = 'Facture vente';
        Text023: TextConst ENU = 'Sales Return Order', FRA = 'Retour vente';
        Text024: TextConst ENU = 'Sales Credit Memo', FRA = 'Avoir vente';
        Text2034889: TextConst ENU = 'Posted Service Invoice', FRA = 'Facture service enreg.';
        Text2034890: TextConst ENU = 'Posted Service Credit Memo', FRA = 'Avoir service enreg.';
        Text2034891: TextConst ENU = 'Posted Service Shipment', FRA = 'Expédition service enreg.';
        Text2034892: TextConst ENU = 'Service Order', FRA = 'Commande service';
        Text2034893: TextConst ENU = 'Service Invoice', FRA = 'Facture service';
        Text2034894: TextConst ENU = 'Service Credit Memo', FRA = 'Avoir service';
        Text99000000: TextConst ENU = 'Production Order', FRA = 'Ordre de fabrication';

    procedure SetDoc(PostingDate: Date; DocNo: Code[20]);
    begin
        NewDocNo := DocNo;
    end;

    local procedure FindRecords();
    // BC Upgrade PATELS08 >> # 'DocType' Variable created to pass enum values as parameter to procedure 'InsertIntoDocEntry'
    var
        DocType: Enum "Document Entry Document Type";
    // BC Upgrade PATELS08 <<
    begin
        Window.OPEN(Text002);
        rec.RESET();
        rec.DELETEALL();
        rec."Entry No." := 0;
        if SalesShptHeader.READPERMISSION then begin
            SalesShptHeader.RESET();
            SalesShptHeader.SETFILTER("Gate Entry No. FND", DocNoFilter);
            // BC Upgrade PATELS08 >> # Passing DocType as Enum instead of Option to avoid runtime error due to implicit conversion from Integer to Enum.
            // InsertIntoDocEntry( 
            //   DATABASE::"Sales Shipment Header", 0, Text005, SalesShptHeader.COUNT);
            InsertIntoDocEntry(
              DATABASE::"Sales Shipment Header", DocType::Quote, Text005, SalesShptHeader.COUNT);
            // BC Upgrade PATELS08 <<
        end;
        if ReturnRcptHeader.READPERMISSION then begin
            ReturnRcptHeader.RESET();
            ReturnRcptHeader.SETFILTER("Gate Entry No. FND", DocNoFilter);
            // BC Upgrade PATELS08 >> # Passing DocType as Enum instead of Option to avoid runtime error due to implicit conversion from Integer to Enum.
            // InsertIntoDocEntry(
            //   DATABASE::"Return Receipt Header", 0, Text017, ReturnRcptHeader.COUNT);
            InsertIntoDocEntry(
              DATABASE::"Return Receipt Header", DocType::Quote, Text017, ReturnRcptHeader.COUNT);
            // BC Upgrade PATELS08 <<
        end;
        if PurchRcptHeader.READPERMISSION then begin
            PurchRcptHeader.RESET();
            PurchRcptHeader.SETFILTER("Gate Entry No. FND", DocNoFilter);
            // BC Upgrade PATELS08 >> # Passing DocType as Enum instead of Option to avoid runtime error due to implicit conversion from Integer to Enum.
            // InsertIntoDocEntry(
            //   DATABASE::"Purch. Rcpt. Header", 0, Text010, PurchRcptHeader.COUNT);
            InsertIntoDocEntry(
              DATABASE::"Purch. Rcpt. Header", DocType::Quote, Text010, PurchRcptHeader.COUNT);
            // BC Upgrade PATELS08 <<
        end;
        if ReturnShptHeader.READPERMISSION then begin
            ReturnShptHeader.RESET();
            ReturnShptHeader.SETFILTER("Gate Entry No. FND", DocNoFilter);
            // BC Upgrade PATELS08 >> # Passing DocType as Enum instead of Option to avoid runtime error due to implicit conversion from Integer to Enum.
            // InsertIntoDocEntry(
            //   DATABASE::"Return Shipment Header", 0, Text018, ReturnShptHeader.COUNT);
            InsertIntoDocEntry(
              DATABASE::"Return Shipment Header", DocType::Quote, Text018, ReturnShptHeader.COUNT);
            // BC Upgrade PATELS08 <<
        end;
        if TransShptHeader.READPERMISSION then begin
            TransShptHeader.RESET();
            TransShptHeader.SETFILTER("From Gate Entry No. FND", DocNoFilter);
            // BC Upgrade PATELS08 >> # Passing DocType as Enum instead of Option to avoid runtime error due to implicit conversion from Integer to Enum.
            // InsertIntoDocEntry(
            //   DATABASE::"Transfer Shipment Header", 0, Text019, TransShptHeader.COUNT);
            InsertIntoDocEntry(
              DATABASE::"Transfer Shipment Header", DocType::Quote, Text019, TransShptHeader.COUNT);
            // BC Upgrade PATELS08 <<
        end;
        if TransRcptHeader.READPERMISSION then begin
            TransRcptHeader.RESET();
            TransRcptHeader.SETFILTER("To Gate Entry No. FND", DocNoFilter);
            // BC Upgrade PATELS08 >> # Passing DocType as Enum instead of Option to avoid runtime error due to implicit conversion from Integer to Enum.
            // InsertIntoDocEntry(
            //   DATABASE::"Transfer Receipt Header", 0, Text020, TransRcptHeader.COUNT);
            InsertIntoDocEntry(
              DATABASE::"Transfer Receipt Header", DocType::Quote, Text020, TransRcptHeader.COUNT);
            // BC Upgrade PATELS08 <<
        end;
        if PostedWhseShptLine.READPERMISSION then begin
            PostedWhseShptLine.RESET();
            PostedWhseShptLine.SETCURRENTKEY("Gate Entry No. FND", "Posting Date");
            PostedWhseShptLine.SETFILTER("Gate Entry No. FND", DocNoFilter);
            // BC Upgrade PATELS08 >> # Passing DocType as Enum instead of Option to avoid runtime error due to implicit conversion from Integer to Enum.
            // InsertIntoDocEntry(
            //   DATABASE::"Posted Whse. Shipment Line", 0,
            //   PostedWhseShptLine.TABLECAPTION, PostedWhseShptLine.COUNT);
            InsertIntoDocEntry(
              DATABASE::"Posted Whse. Shipment Line", DocType::Quote,
              PostedWhseShptLine.TABLECAPTION, PostedWhseShptLine.COUNT);
            // BC Upgrade PATELS08 <<
        end;
        if PostedWhseRcptLine.READPERMISSION then begin
            PostedWhseRcptLine.RESET();
            PostedWhseRcptLine.SETCURRENTKEY("Gate Entry No. FND", "Posting Date");
            PostedWhseRcptLine.SETFILTER("Gate Entry No. FND", DocNoFilter);
            // BC Upgrade PATELS08 >> # Passing DocType as Enum instead of Option to avoid runtime error due to implicit conversion from Integer to Enum.
            // InsertIntoDocEntry(
            //   DATABASE::"Posted Whse. Receipt Line", 0,
            //   PostedWhseRcptLine.TABLECAPTION, PostedWhseRcptLine.COUNT);
            InsertIntoDocEntry(
              DATABASE::"Posted Whse. Receipt Line", DocType::Quote,
              PostedWhseRcptLine.TABLECAPTION, PostedWhseRcptLine.COUNT);
            // BC Upgrade PATELS08 <<
        end;

        DocExists := rec.FINDFIRST();

        SetSource(0D, '', '', 0, '');
        if DocExists then begin
            if (NoOfRecords(DATABASE::"Cust. Ledger Entry") + NoOfRecords(DATABASE::"Vendor Ledger Entry") <= 2) and
                (NoOfRecords(DATABASE::"Sales Shipment Header") +
                NoOfRecords(DATABASE::"Return Shipment Header") + NoOfRecords(DATABASE::"Return Receipt Header") +
                NoOfRecords(DATABASE::"Purch. Rcpt. Header") +
                NoOfRecords(DATABASE::"Transfer Shipment Header") + NoOfRecords(DATABASE::"Transfer Receipt Header") <= 1)
            then begin
                if NoOfRecords(DATABASE::"Return Receipt Header") = 1 then begin
                    ReturnRcptHeader.FINDFIRST();
                    SetSource(
                      ReturnRcptHeader."Posting Date", FORMAT(rec."Table Name"), ReturnRcptHeader."Gate Entry No. FND",
                      1, ReturnRcptHeader."Sell-to Customer No.");
                end;
                if NoOfRecords(DATABASE::"Sales Shipment Header") = 1 then begin
                    SalesShptHeader.FINDFIRST();
                    SetSource(
                      SalesShptHeader."Posting Date", FORMAT(rec."Table Name"), SalesShptHeader."Gate Entry No. FND",
                      1, SalesShptHeader."Sell-to Customer No.");
                end;
                if NoOfRecords(DATABASE::"Posted Whse. Shipment Line") = 1 then begin
                    PostedWhseShptLine.FINDFIRST();
                    SetSource(
                      PostedWhseShptLine."Posting Date", FORMAT(rec."Table Name"), PostedWhseShptLine."Gate Entry No. FND",
                      1, PostedWhseShptLine."Destination No.");
                end;
                if NoOfRecords(DATABASE::"Return Shipment Header") = 1 then begin
                    ReturnShptHeader.FINDFIRST();
                    SetSource(
                      ReturnShptHeader."Posting Date", FORMAT(rec."Table Name"), ReturnShptHeader."Gate Entry No. FND",
                      2, ReturnShptHeader."Buy-from Vendor No.");
                end;
                if NoOfRecords(DATABASE::"Purch. Rcpt. Header") = 1 then begin
                    PurchRcptHeader.FINDFIRST();
                    SetSource(
                      PurchRcptHeader."Posting Date", FORMAT(rec."Table Name"), PurchRcptHeader."Gate Entry No. FND",
                      2, PurchRcptHeader."Buy-from Vendor No.");
                end;
                if NoOfRecords(DATABASE::"Posted Whse. Receipt Line") = 1 then begin
                    PostedWhseRcptLine.FINDFIRST();
                    SetSource(
                      PostedWhseRcptLine."Posting Date", FORMAT(rec."Table Name"), PostedWhseRcptLine."Gate Entry No. FND",
                      2, '');
                end;
            end else begin
                if DocNoFilter <> '' then
                    if PostingDateFilter = '' then
                        MESSAGE(Text011)
                    else
                        MESSAGE(Text012);
            end;
        end else
            if PostingDateFilter = '' then
                MESSAGE(Text013)
            else
                MESSAGE(Text014);

        UpdateFormAfterFindRecords();
        Window.CLOSE();
    end;

    local procedure UpdateFormAfterFindRecords();
    begin
        ShowEnable := DocExists;
        PrintEnable := DocExists;
        CurrPage.UPDATE(false);
        DocExists := rec.FINDFIRST();
        if DocExists then;
    end;

    // BC Upgrade PATELS08 >> # Changed the data type of DocType parameter to Enum "Document Entry Document Type" as Implicit conversion from Integer to Enum can cause runtime error. (rec."Document Type" := DocType;)
    // local procedure InsertIntoDocEntry(DocTableID: Integer; DocType: Option; DocTableName: Text[1024]; DocNoOfRecords: Integer);
    local procedure InsertIntoDocEntry(DocTableID: Integer; DocType: Enum "Document Entry Document Type"; DocTableName: Text[1024]; DocNoOfRecords: Integer);
    // BC Upgrade PATELS08 <<
    begin
        if DocNoOfRecords = 0 then
            exit;
        rec.INIT();
        rec."Entry No." := rec."Entry No." + 1;
        rec."Table ID" := DocTableID;
        rec."Document Type" := DocType;
        rec."Table Name" := COPYSTR(DocTableName, 1, MAXSTRLEN(rec."Table Name"));
        rec."No. of Records" := DocNoOfRecords;
        rec.INSERT();
    end;

    local procedure NoOfRecords(TableID: Integer): Integer;
    begin
        rec.SETRANGE("Table ID", TableID);
        if not rec.FINDFIRST() then
            rec.INIT();
        rec.SETRANGE("Table ID");
        exit(rec."No. of Records");
    end;

    local procedure SetSource(PostingDate: Date; DocType2: Text[50]; DocNo: Text[50]; SourceType2: Integer; SourceNo2: Code[20]);
    begin
        if SourceType2 = 0 then begin
            DocType := '';
            SourceType := '';
            SourceNo := '';
            SourceName := '';
        end else begin
            DocType := DocType2;
            SourceNo := SourceNo2;
            rec.SETRANGE("Document No.", DocNo);
            DocNoFilter := rec.GETFILTER("Document No.");
            case SourceType2 of
                1:
                    begin
                        SourceType := Cust.TABLECAPTION;
                        if not Cust.GET(SourceNo) then
                            Cust.INIT();
                        SourceName := Cust.Name;
                    end;
                2:
                    begin
                        SourceType := Vend.TABLECAPTION;
                        if not Vend.GET(SourceNo) then
                            Vend.INIT();
                        SourceName := Vend.Name;
                    end;
            end;
        end;
        DocTypeEnable := SourceType2 <> 0;
        SourceTypeEnable := SourceType2 <> 0;
        SourceNoEnable := SourceType2 <> 0;
        SourceNameEnable := SourceType2 <> 0;
    end;

    local procedure ShowRecords();
    begin
        case rec."Table ID" of
            DATABASE::"Sales Header":
                case rec."Document Type" of
                    rec."Document Type"::Order:
                        if rec."No. of Records" = 1 then
                            PAGE.RUN(PAGE::"Sales Order", SOSalesHeader)
                        else
                            PAGE.RUN(0, SOSalesHeader);
                    rec."Document Type"::"Return Order":
                        if rec."No. of Records" = 1 then
                            PAGE.RUN(PAGE::"Sales Return Order", SROSalesHeader)
                        else
                            PAGE.RUN(0, SROSalesHeader);
                    rec."Document Type"::"Credit Memo":
                        if rec."No. of Records" = 1 then
                            PAGE.RUN(PAGE::"Sales Credit Memo", SCMSalesHeader)
                        else
                            PAGE.RUN(0, SCMSalesHeader);
                end;
            DATABASE::"Return Receipt Header":
                if rec."No. of Records" = 1 then
                    PAGE.RUN(PAGE::"Posted Return Receipt", ReturnRcptHeader)
                else
                    PAGE.RUN(0, ReturnRcptHeader);
            DATABASE::"Sales Shipment Header":
                if rec."No. of Records" = 1 then
                    PAGE.RUN(PAGE::"Posted Sales Shipment", SalesShptHeader)
                else
                    PAGE.RUN(0, SalesShptHeader);
            DATABASE::"Return Shipment Header":
                if rec."No. of Records" = 1 then
                    PAGE.RUN(PAGE::"Posted Return Shipment", ReturnShptHeader)
                else
                    PAGE.RUN(0, ReturnShptHeader);
            DATABASE::"Purch. Rcpt. Header":
                if rec."No. of Records" = 1 then
                    PAGE.RUN(PAGE::"Posted Purchase Receipt", PurchRcptHeader)
                else
                    PAGE.RUN(0, PurchRcptHeader);
            DATABASE::"Transfer Shipment Header":
                if rec."No. of Records" = 1 then
                    PAGE.RUN(PAGE::"Posted Transfer Shipment", TransShptHeader)
                else
                    PAGE.RUN(0, TransShptHeader);
            DATABASE::"Transfer Receipt Header":
                if rec."No. of Records" = 1 then
                    PAGE.RUN(PAGE::"Posted Transfer Receipt", TransRcptHeader)
                else
                    PAGE.RUN(0, TransRcptHeader);
            DATABASE::"Posted Whse. Shipment Line":
                PAGE.RUN(0, PostedWhseShptLine);
            DATABASE::"Posted Whse. Receipt Line":
                PAGE.RUN(0, PostedWhseRcptLine);
        end;
    end;

    local procedure SetPostingDate(PostingDate: Text[250]);
    var
        FilterToken: Codeunit "Filter Tokens";
        PostingDateFilter: Text;
    begin
        // if ApplicationManagement.MakeDateFilter(PostingDate) = 0 then;//Bc Upgrade SHARMP16 -- need to check workaroun
        //rec.SETFILTER("Posting Date", PostingDate);
        //PostingDateFilter := rec.GETFILTER("Posting Date");
        //BC Upgrade SHARMP16 Begin<<------------------rewrite the code as per BC standards
        PostingDateFilter := PostingDate;
        FilterToken.MakeDateFilter(PostingDateFilter);
        Rec.SetFilter("Posting Date", PostingDateFilter);
        PostingDateFilter := Rec.GetFilter("Posting Date");
    end;

    //BC Upgrade SHARMP16 end>>------------------rewrite the code as per BC standards
    local procedure SetDocNo(DocNo: Text[250]);
    begin
        rec.SETFILTER("Document No.", DocNo);
        DocNoFilter := rec.GETFILTER("Document No.");
        PostingDateFilter := rec.GETFILTER("Posting Date");
    end;

    local procedure ClearSourceInfo();
    begin
        if DocExists then begin
            DocExists := false;
            rec.DELETEALL();
            ShowEnable := false;
            SetSource(0D, '', '', 0, '');
            CurrPage.UPDATE(false);
        end;
    end;

    procedure ClearInfo();
    begin
        SetDocNo('');
    end;

    local procedure FindPush();
    begin
        FindRecords();
    end;

    local procedure DocNoFilterOnAfterValidate();
    begin
        ClearSourceInfo();
    end;
}

