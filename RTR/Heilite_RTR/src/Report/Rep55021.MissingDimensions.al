report 55021 "Missing Dimensions"
{
    // version HEI.01

    // HEI.01 CHG2266140 IBM POENAB02 27.08.2024 Update missing CC dimension which are missing in posted documents
    //   # Object created

    //Bc Upgrade YADAVM09 Report property Changes.
    RDLCLayout = '.\src\Reportslayout\Missing Dimensions.rdl';
    ApplicationArea = All;//Bc Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//Bc Upgrade YADAVM09<<

    DefaultLayout = RDLC;
    Permissions = TableData "G/L Account" = r,
                  TableData "G/L Entry" = r,
                  TableData Item = r,
                  TableData "Item Ledger Entry" = r,
                  TableData "Default Dimension" = r,
                  TableData "Dimension Set Entry" = r,
                  TableData "Stockkeeping Unit" = r,
                  TableData "Transfer Shipment Header" = r,
                  TableData "Transfer Receipt Header" = r,
                  TableData "Value Entry" = r,
                  TableData "G/L - Item Ledger Relation" = r;
    PreviewMode = Normal;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
            RequestFilterFields = "Entry No.", "G/L Account No.", "Posting Date", "Document Type", "Document No.";
            column(GLEntry_PostingDate; "G/L Entry"."Posting Date")
            {
            }
            column(GLEntry_DocNo; "G/L Entry"."Document No.")
            {
            }
            column(GLEntry_GLAccount; "G/L Entry"."G/L Account No.")
            {
            }
            column(GLEntry_Amount; "G/L Entry".Amount)
            {
            }
            column(CCC; CCC)
            {
            }
            column(BRAND; BRAND)
            {
            }
            column(SKU; SKU)
            {
            }
            column(AUTO_CUST; AUTO_CUST)
            {
            }
            column(LINE_EXT; LINE_EXT)
            {
            }
            column(Service_ZONE; Service_ZONE)
            {
            }
            column(INV_LEV; INV_LEV)
            {
            }
            column(L_WRITE_OFF; L_WRITE_OFF)
            {
            }
            column(BUSS_SEG; BUSS_SEG)
            {
            }
            column(GLEntry_DocType; "G/L Entry"."Document Type")
            {
            }
            column(GLEntry_SourceCode; "G/L Entry"."Source Code")
            {
            }
            column(GLEntry_EntryNo; "G/L Entry"."Entry No.")
            {
            }
            column(ItemNo; ItemNo)
            {
            }

            trigger OnAfterGetRecord();
            begin

                GLAccount.RESET;
                if GLAccount.GET("G/L Entry"."G/L Account No.") then begin
                    DefaultDimension.SETRANGE("Table ID", 15);
                    DefaultDimension.SETRANGE("No.", GLAccount."No.");
                    DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
                    if not DefaultDimension.FINDFIRST then
                        CurrReport.SKIP;
                end;

                CCC := '';

                GLAccount.RESET;
                if GLAccount.GET("G/L Entry"."G/L Account No.") then begin
                    CCC := '';
                    ItemNo := '';
                    DefaultDimension.RESET;
                    DefaultDimension.SETRANGE("Table ID", 15);
                    DefaultDimension.SETRANGE("No.", GLAccount."No.");
                    DefaultDimension.SETRANGE("Value Posting", DefaultDimension."Value Posting"::"Code Mandatory");
                    if DefaultDimension.FINDSET() then
                        repeat
                            CCC := '';
                            case DefaultDimension."Dimension Code" of
                                'CCC':
                                    begin
                                        if TransferReceiptHeader.GET("Document No.") then begin
                                            CCC := '';
                                            CCCValueFound := false;
                                            VELocationCode := '';
                                            VEItemNo := '';
                                            CLEAR(VE_ItemLedgerEntryNo);
                                            ILE_ZoneCode := '';
                                            ILE_BinCode := '';
                                            ItemNo := '';
                                            GLItemLedgerRelation.RESET;
                                            GLItemLedgerRelation.SETRANGE("G/L Entry No.", "G/L Entry"."Entry No.");
                                            if GLItemLedgerRelation.FINDFIRST then begin
                                                ValueEntry.RESET;
                                                if ValueEntry.GET(GLItemLedgerRelation."Value Entry No.") then begin
                                                    VELocationCode := ValueEntry."Location Code";
                                                    VEItemNo := ValueEntry."Item No.";
                                                    VE_ItemLedgerEntryNo := ValueEntry."Item Ledger Entry No.";
                                                    ItemNo := ValueEntry."Item No.";
                                                    DimensionSetEntry.RESET;
                                                    DimensionSetEntry.SETRANGE("Dimension Set ID", ValueEntry."Dimension Set ID");
                                                    DimensionSetEntry.SETRANGE("Dimension Code", 'CCC');
                                                    if DimensionSetEntry.FINDFIRST then
                                                        CCCValueFound := true
                                                    else begin
                                                        ItemLedgerEntry.RESET;
                                                        if ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") then begin
                                                            if ItemLedgerEntry."Zone Code FND" <> '' then
                                                                ILE_ZoneCode := ItemLedgerEntry."Zone Code FND"
                                                            else
                                                                if ValueEntry."Zone Code FND" <> '' then
                                                                    ILE_ZoneCode := ValueEntry."Zone Code FND";
                                                            //if ItemLedgerEntry."Bin Code" <> '' then//Bc Upgrade YADAVM09 Drink it field<<
                                                            // ILE_BinCode := ItemLedgerEntry."Bin Code"//Bc Upgrade YADAVM09 Drink it field<<
                                                            // else //Bc Upgrade YADAVM09 Drink it field<<
                                                            if ValueEntry."Bin Code FND" <> '' then
                                                                ILE_BinCode := ValueEntry."Bin Code FND";
                                                        end;
                                                    end;
                                                end;
                                            end;
                                            if CCCValueFound = false then begin
                                                StockkeepingUnit.RESET;
                                                StockkeepingUnit.SETRANGE("Location Code", VELocationCode);
                                                StockkeepingUnit.SETRANGE("Item No.", VEItemNo);
                                                if StockkeepingUnit.FINDFIRST then
                                                    if StockkeepingUnit."CCC Dim. Code FND" <> '' then begin
                                                        CCC := StockkeepingUnit."CCC Dim. Code FND";
                                                        CCCValueFound := true;
                                                    end;
                                            end;
                                            Item.RESET;
                                            if CCCValueFound = false then
                                                if Item.GET(VEItemNo) then begin
                                                    DefaultDimension.RESET;
                                                    DefaultDimension.SETRANGE("Table ID", 27);
                                                    DefaultDimension.SETRANGE("No.", VEItemNo);
                                                    DefaultDimension.SETRANGE("Dimension Code", 'CCC');
                                                    if DefaultDimension.FINDFIRST then begin
                                                        CCC := DefaultDimension."Dimension Value Code";
                                                        CCCValueFound := true;
                                                    end;
                                                end;
                                            if CCCValueFound = false then //get based on historical data
                                              begin
                                                ItemLedgerEntry.RESET;
                                                ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date");
                                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                                                ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Transfer Receipt"); //!!!!!!!
                                                ItemLedgerEntry.SETRANGE("Item No.", VEItemNo);
                                                ItemLedgerEntry.SETRANGE("Location Code", VELocationCode);
                                                //ItemLedgerEntry.SETFILTER("Posting Date",'..%1',280724D);
                                                ItemLedgerEntry.SETFILTER("Posting Date", '..%1', LastValidDate);
                                                ItemLedgerEntry.SETRANGE("Zone Code FND", ILE_ZoneCode);
                                                // ItemLedgerEntry.SETRANGE("Bin Code", ILE_BinCode);//Bc Upgrade YADAVM09 Drink it field<<
                                                ItemLedgerEntry.SETFILTER("Global Dimension 2 Code", '<>%1', '');
                                                if ItemLedgerEntry.FINDLAST then begin
                                                    CCC := ItemLedgerEntry."Global Dimension 2 Code";
                                                    CCCValueFound := true;
                                                end;

                                            end;
                                            if CCCValueFound = false then
                                                CCC := 'Proposal not found!';
                                        end;

                                        if TransferShipmentHeader.GET("Document No.") then begin
                                            CCC := '';
                                            CCCValueFound := false;
                                            VELocationCode := '';
                                            VEItemNo := '';
                                            CLEAR(VE_ItemLedgerEntryNo);
                                            ILE_ZoneCode := '';
                                            ILE_BinCode := '';
                                            ItemNo := '';
                                            GLItemLedgerRelation.RESET;
                                            GLItemLedgerRelation.SETRANGE("G/L Entry No.", "G/L Entry"."Entry No.");
                                            if GLItemLedgerRelation.FINDFIRST then begin
                                                ValueEntry.RESET;
                                                if ValueEntry.GET(GLItemLedgerRelation."Value Entry No.") then begin
                                                    VELocationCode := ValueEntry."Location Code";
                                                    VEItemNo := ValueEntry."Item No.";
                                                    VE_ItemLedgerEntryNo := ValueEntry."Item Ledger Entry No.";
                                                    ItemNo := ValueEntry."Item No.";
                                                    DimensionSetEntry.RESET;
                                                    DimensionSetEntry.SETRANGE("Dimension Set ID", ValueEntry."Dimension Set ID");
                                                    DimensionSetEntry.SETRANGE("Dimension Code", 'CCC');
                                                    if DimensionSetEntry.FINDFIRST then
                                                        CCCValueFound := true
                                                    else begin
                                                        ItemLedgerEntry.RESET;
                                                        if ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") then begin
                                                            if ItemLedgerEntry."Zone Code FND" <> '' then
                                                                ILE_ZoneCode := ItemLedgerEntry."Zone Code FND"
                                                            else
                                                                if ValueEntry."Zone Code FND" <> '' then
                                                                    ILE_ZoneCode := ValueEntry."Zone Code FND";
                                                            // if ItemLedgerEntry."Bin Code" <> '' then//Bc Upgrade YADAVM09 Drink it field<<
                                                            //     ILE_BinCode := ItemLedgerEntry."Bin Code"//Bc Upgrade YADAVM09 Drink it field<<
                                                            // else//Bc Upgrade YADAVM09 Drink it field<<
                                                            if ValueEntry."Bin Code FND" <> '' then
                                                                ILE_BinCode := ValueEntry."Bin Code FND";
                                                        end;
                                                    end;
                                                end;
                                            end;
                                            if CCCValueFound = false then begin
                                                StockkeepingUnit.RESET;
                                                StockkeepingUnit.SETRANGE("Location Code", VELocationCode);
                                                StockkeepingUnit.SETRANGE("Item No.", VEItemNo);
                                                if StockkeepingUnit.FINDFIRST then
                                                    if StockkeepingUnit."CCC Dim. Code FND" <> '' then begin
                                                        CCC := StockkeepingUnit."CCC Dim. Code FND";
                                                        CCCValueFound := true;
                                                    end;
                                            end;
                                            Item.RESET;
                                            if CCCValueFound = false then
                                                if Item.GET(VEItemNo) then begin
                                                    DefaultDimension.RESET;
                                                    DefaultDimension.SETRANGE("Table ID", 27);
                                                    DefaultDimension.SETRANGE("No.", VEItemNo);
                                                    DefaultDimension.SETRANGE("Dimension Code", 'CCC');
                                                    if DefaultDimension.FINDFIRST then begin
                                                        CCC := DefaultDimension."Dimension Value Code";
                                                        CCCValueFound := true;
                                                    end;
                                                end;
                                            if CCCValueFound = false then //get based on historical data
                                              begin
                                                ItemLedgerEntry.RESET;
                                                ItemLedgerEntry.SETCURRENTKEY("Entry Type", "Document Type", "Item No.", "Source No.", "Location Code", "Variant Code", "Posting Date");
                                                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Transfer);
                                                ItemLedgerEntry.SETRANGE("Document Type", ItemLedgerEntry."Document Type"::"Transfer Shipment"); //!!!!!!!
                                                ItemLedgerEntry.SETRANGE("Item No.", VEItemNo);
                                                ItemLedgerEntry.SETRANGE("Location Code", VELocationCode);
                                                //ItemLedgerEntry.SETFILTER("Posting Date",'..%1',280724D);
                                                ItemLedgerEntry.SETFILTER("Posting Date", '..%1', LastValidDate);
                                                ItemLedgerEntry.SETRANGE("Zone Code FND", ILE_ZoneCode);
                                                // ItemLedgerEntry.SETRANGE("Bin Code", ILE_BinCode);//Bc Upgrade YADAVM09 Drink it field<<
                                                ItemLedgerEntry.SETFILTER("Global Dimension 2 Code", '<>%1', '');
                                                if ItemLedgerEntry.FINDLAST then begin
                                                    CCC := ItemLedgerEntry."Global Dimension 2 Code";
                                                    CCCValueFound := true;
                                                end;

                                            end;
                                            if CCCValueFound = false then
                                                CCC := 'Proposal not found!';
                                        end;
                                    end;
                                'INV_LEV': // MtC -> discount to customers; reason for providing discounts;
                                    begin
                                    end;
                            end;
                        until DefaultDimension.NEXT = 0;
                end;
            end;

            trigger OnPreDataItem();
            begin
                //SETFILTER("Posting Date",'%1..%2',290724D,110824D);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        LastValidDateTime := CREATEDATETIME(20240728D, 000000T);
        LastValidDate := DT2DATE(LastValidDateTime);
    end;

    var
        CCC: Text;
        BRAND: Text;
        SKU: Text;
        AUTO_CUST: Text;
        LINE_EXT: Text;
        Service_ZONE: Text;
        INV_LEV: Text;
        L_WRITE_OFF: Text;
        BUSS_SEG: Text;
        GLAccount: Record "G/L Account";
        DefaultDimension: Record "Default Dimension";
        TransferReceiptHeader: Record "Transfer Receipt Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        GLItemLedgerRelation: Record "G/L - Item Ledger Relation";
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        DimensionSetEntry: Record "Dimension Set Entry";
        StockkeepingUnit: Record "Stockkeeping Unit";
        Item: Record Item;
        VELocationCode: Code[20];
        VEItemNo: Code[20];
        CCCValueFound: Boolean;
        VE_ItemLedgerEntryNo: Integer;
        ILE_ZoneCode: Code[10];
        ILE_BinCode: Code[20];
        LastValidDate: Date;
        LastValidDateTime: DateTime;
        ItemNo: Code[20];
}

