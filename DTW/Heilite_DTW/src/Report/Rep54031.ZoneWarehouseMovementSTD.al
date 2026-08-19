report 54031 "Zone Warehouse Movement STD"
{
    // HEI.01 Defect # 3609 IBM ISYED01 17.12.2018
    //  #Adjusted the signature boxes as requested in defect.
    //  # Added Sender name and singature and Receiver name and signature
    // BC Upgrade KUMARR78 >>
    //
    // Old Report ID- 50260
    //
    // 1. Added ApplicationArea Property at Report Level
    //    Old: ApplicationArea property was not defined.
    //    New: ApplicationArea = All;
    // 2. Added UsageCategory Property at Report Level
    //    Old: UsageCategory property was not defined.
    //    New: UsageCategory = ReportsAndAnalysis;
    // 3. Added ApplicationArea Property to Request Page Fields
    //    Old: Request page fields did not contain ApplicationArea property.
    //    New: ApplicationArea = All; added to following fields:
    //         - SetBreakbulkFilter
    //         - SumUpLines
    //         - ShowSlNoLotNo
    //         - ActionTypeFilter
    //    Reason: ApplicationArea is mandatory in Business Central
    //            to ensure request page fields are visible as per UI standards.
    // BC Upgrade KUMARR78 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Zone Warehouse Movement STD.rdl';
    ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
    UsageCategory = ReportsAndAnalysis; //BC Upgrade KUMARR78 Adding Usagecategory

    CaptionML = ENU = 'Movement List STD',
                FRA = 'Liste mouvements STD';

    dataset
    {
        dataitem("Warehouse Activity Header"; "Warehouse Activity Header")
        {
            DataItemTableView = sorting(Type, "No.") where(Type = filter(Movement | "Invt. Movement"));
            RequestFilterFields = "No.", "No. Printed";
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(CurrReportPageNo; CurrReport.PageNo())
                {
                }
                column(CompanyName; CompanyName)
                {
                }
                column(Picture_CompanyInfo; CompanyInfo.Picture)
                {
                }
                column(CompanyText; CompanyText)
                {
                }
                column(WhseActivHeaderCaption; DocumentNoLbl)
                {
                }
                column(MovementFilter; MovementFilter)
                {
                }
                column(SumUpLines; SumUpLines)
                {
                }
                column(ShowLotSN; ShowLotSN)
                {
                }
                column(InvtMovement; InvtMovement)
                {
                }
                column(SortMethod_WhseActivHeader; "Warehouse Activity Header"."Sorting Method")
                {
                    IncludeCaption = true;
                }
                column(AssignedUserID_WhseActivHeader; "Warehouse Activity Header"."Assigned User ID")
                {
                    IncludeCaption = true;
                }
                column(No1_WhseActivHeader; "Warehouse Activity Header"."No.")
                {
                    IncludeCaption = true;
                }
                column(LocCode_WhseActivHeader; "Warehouse Activity Header"."Location Code")
                {
                    IncludeCaption = true;
                }
                column(SourceDoc_WhseActivLine; "Warehouse Activity Line"."Source Document")
                {
                    IncludeCaption = true;
                }
                column(LocationBinMandatory; Location."Bin Mandatory")
                {
                }
                column(MovementListCaption; MovementListCaptionLbl)
                {
                }
                column(DueDateCaption; DueDateCaptionLbl)
                {
                }
                column(QtyHandledCaption; QtyHandledCaptionLbl)
                {
                }
                column(SourceNoCaption; SourceNoCaptionLbl)
                {
                }
                column(DestinationTypeCaption; DestinationTypeCaptionLbl)
                {
                }
                column(DestinationNoCaption; DestinationNoCaptionLbl)
                {
                }
                column(ItemNoCaption; ItemNoCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(VariantCodeCaption; VariantCodeCaptionLbl)
                {
                }
                column(ShelfNoCaption; ShelfNoCaptionLbl)
                {
                }
                column(QuantityBaseCaption; QuantityBaseCaptionLbl)
                {
                }
                column(QtytoHandleCaption; QtytoHandleCaptionLbl)
                {
                }
                column(UOMCodeCaption; UOMCodeCaptionLbl)
                {
                }
                column(ActionTypeCaption; ActionTypeCaptionLbl)
                {
                }
                column(ZoneCodeCaption; ZoneCodeCaptionLbl)
                {
                }
                column(BinCodeCaption; BinCodeCaptionLbl)
                {
                }
                column(QtyHandledCaptionLbl; QtyHandledCaptionLbl)
                {
                }
                dataitem("Warehouse Activity Line"; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = field(Type), "No." = field("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = sorting("Activity Type", "No.", "Sorting Sequence No.");

                    trigger OnAfterGetRecord();
                    begin
                        if SumUpLines then begin
                            if TempWhseActivLine."No." = '' then begin
                                TempWhseActivLine := "Warehouse Activity Line";
                                TempWhseActivLine.Insert();
                                Mark(true);
                            end else begin
                                TempWhseActivLine.SetCurrentKey("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                                TempWhseActivLine.SetRange("Activity Type", "Activity Type");
                                TempWhseActivLine.SetRange("No.", "No.");
                                TempWhseActivLine.SetRange("Bin Code", "Bin Code");
                                TempWhseActivLine.SetRange("Item No.", "Item No.");
                                TempWhseActivLine.SetRange("Action Type", "Action Type");
                                TempWhseActivLine.SetRange("Variant Code", "Variant Code");
                                TempWhseActivLine.SetRange("Unit of Measure Code", "Unit of Measure Code");
                                TempWhseActivLine.SetRange("Due Date", "Due Date");
                                if TempWhseActivLine.FindFirst() then begin
                                    TempWhseActivLine."Qty. (Base)" := TempWhseActivLine."Qty. (Base)" + "Qty. (Base)";
                                    TempWhseActivLine."Qty. to Handle" := TempWhseActivLine."Qty. to Handle" + "Qty. to Handle";
                                    TempWhseActivLine."Source No." := '';
                                    TempWhseActivLine.Modify();
                                end else begin
                                    TempWhseActivLine := "Warehouse Activity Line";
                                    TempWhseActivLine.Insert();
                                    Mark(true);
                                end;
                            end;
                        end else
                            Mark(true);
                    end;

                    trigger OnPostDataItem();
                    begin
                        MarkedOnly(true);
                    end;

                    trigger OnPreDataItem();
                    begin
                        TempWhseActivLine.SetRange("Activity Type", "Warehouse Activity Header".Type);
                        TempWhseActivLine.SetRange("No.", "Warehouse Activity Header"."No.");
                        TempWhseActivLine.DeleteAll();
                        if BreakbulkFilter then
                            TempWhseActivLine.SetRange("Original Breakbulk", false);
                        Clear(TempWhseActivLine);

                        case ActionTypeFilter of
                            ActionTypeFilter::Take:
                                SetRange("Action Type", "Action Type"::Take);
                            ActionTypeFilter::Place:
                                SetRange("Action Type", "Action Type"::Place);
                        end;
                    end;
                }
                dataitem(WhseActivLine; "Warehouse Activity Line")
                {
                    DataItemLink = "Activity Type" = field(Type), "No." = field("No.");
                    DataItemLinkReference = "Warehouse Activity Header";
                    DataItemTableView = sorting("Activity Type", "No.", "Sorting Sequence No.");
                    column(SourceNo_WhseActivLine; "Source No.")
                    {
                        IncludeCaption = false;
                    }
                    column(SourceDocumentText; SourceDocumentText)
                    {
                    }
                    column(ShelfNo_WhseActivLine; "Shelf No.")
                    {
                        IncludeCaption = false;
                    }
                    column(ItemNo_WhseActivLine; "Item No.")
                    {
                        IncludeCaption = false;
                    }
                    column(Description_WhseActivLine; Description)
                    {
                        IncludeCaption = false;
                    }
                    column(VariantCode_WhseActivLine; "Variant Code")
                    {
                        IncludeCaption = false;
                    }
                    column(UOMCode_WhseActivLine; "Unit of Measure Code")
                    {
                        IncludeCaption = false;
                    }
                    column(DueDate_WhseActivLine; Format("Due Date"))
                    {
                    }
                    column(QtytoHandle_WhseActivLine; "Qty. to Handle")
                    {
                        IncludeCaption = false;
                    }
                    column(QtyBase_WhseActivLine; Quantity)
                    {
                    }
                    column(DestType_WhseActivLine; "Destination Type")
                    {
                        IncludeCaption = false;
                    }
                    column(DestNo_WhseActivLine; "Destination No.")
                    {
                        IncludeCaption = false;
                    }
                    column(ZoneCode_WhseActivLine; "Zone Code")
                    {
                        IncludeCaption = false;
                    }
                    column(BinCode_WhseActivLine; "Bin Code")
                    {
                        IncludeCaption = false;
                    }
                    column(ActionType_WhseActivLine; "Action Type")
                    {
                        IncludeCaption = false;
                    }
                    column(LotNo_WhseActivLine; "Lot No.")
                    {
                        IncludeCaption = false;
                    }
                    column(SerialNo_WhseActivLine; "Serial No.")
                    {
                        IncludeCaption = true;
                    }
                    column(LineNo_WhseActivLine; "Line No.")
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(ExpirationDate_WhseActivLine; Format(WhseActivLine."Expiration Date"))
                    {
                    }
                    dataitem(ExtendedText; "Integer")
                    {
                        column(ExtendedTextVal; ExtendedTextVal)
                        {
                        }
                        column(ShowExtLine; ShowExtLine)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                ExtendedTextLine.FindFirst()
                            else
                                ExtendedTextLine.Next();

                            //NAIKH01 New
                            ExtendedTextHeader.Reset();
                            ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::Item);
                            ExtendedTextHeader.SetRange("No.", ExtendedTextLine."No.");
                            ExtendedTextHeader.SetRange("Language Code", ExtendedTextLine."Language Code");
                            ExtendedTextHeader.SetRange("Text No.", ExtendedTextLine."Text No.");
                            ExtendedTextHeader.SetRange("Print on Picklist FND", true);
                            if not ExtendedTextHeader.FindSet() then
                                CurrReport.Skip()
                            else
                                ExtendedTextVal := ExtendedTextLine.Text;

                            ShowExtLine := false;

                            if WhseActivLine."Action Type" = WhseActivLine."Action Type"::Take then
                                ShowExtLine := true;
                        end;

                        trigger OnPreDataItem();
                        begin
                            ExtendedTextVal := '';

                            ExtendedTextLine.Reset();
                            ExtendedTextLine.SetRange("Table Name", ExtendedTextLine."Table Name"::Item);
                            ExtendedTextLine.SetRange("No.", WhseActivLine."Item No.");


                            SetRange(Number, 1, ExtendedTextLine.Count);
                        end;
                    }
                    dataitem(WhseActivLine2; "Warehouse Activity Line")
                    {
                        DataItemLink = "Activity Type" = field("Activity Type"), "No." = field("No."), "Bin Code" = field("Bin Code"), "Item No." = field("Item No."), "Action Type" = field("Action Type"), "Variant Code" = field("Variant Code"), "Unit of Measure Code" = field("Unit of Measure Code"), "Due Date" = field("Due Date");
                        DataItemTableView = sorting("Activity Type", "No.", "Bin Code", "Breakbulk No.", "Action Type");
                        column(LotNo_WhseActivLine2; "Lot No.")
                        {
                            IncludeCaption = true;
                        }
                        column(SerialNo_WhseActivLine2; "Serial No.")
                        {
                            IncludeCaption = true;
                        }
                        column(QtyBase_WhseActivLine2; "Qty. (Base)")
                        {
                        }
                        column(QtytoHandl_WhseActivLine2; "Qty. to Handle")
                        {
                        }
                        column(LineNo_WhseActivLine2; "Line No.")
                        {
                        }
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if SumUpLines then begin
                            TempWhseActivLine.Get("Activity Type", "No.", "Line No.");
                            "Qty. (Base)" := TempWhseActivLine."Qty. (Base)";
                            "Qty. to Handle" := TempWhseActivLine."Qty. to Handle";
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        Copy("Warehouse Activity Line");
                        Counter := Count;
                        if Counter = 0 then
                            CurrReport.Break();

                        if BreakbulkFilter then
                            SetRange("Original Breakbulk", false);
                    end;
                }
            }

            trigger OnAfterGetRecord();
            begin
                //-----Company Info
                CompanyInfo.Get();
                //Picture
                CompanyInfo.CalcFields(Picture);
                //Company Text
                Clear(CompanyText);
                CompanyText := CompanyInfo.Name;

                GetLocation("Location Code");
                InvtMovement := Type = Type::"Invt. Movement";
                if not CurrReport.Preview then
                    Codeunit.Run(Codeunit::"Whse.-Printed", "Warehouse Activity Header");
            end;
        }
    }

    requestpage
    {
        CaptionML = ENU = 'Movement List',
                    FRA = 'Liste mouvements';
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field(SetBreakbulkFilter; BreakbulkFilter)
                    {
                        ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'Set Breakbulk Filter',
                                    FRA = 'Filtrer déconditionnement';
                        Editable = BreakbulkEditable;
                        Visible = false;
                    }
                    field(SumUpLines; SumUpLines)
                    {
                        ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'Sum up Lines',
                                    FRA = 'Totaliser lignes';
                        Editable = SumUpLinesEditable;
                        Visible = false;
                    }
                    field(ShowSlNoLotNo; ShowLotSN)
                    {
                        ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
                        CaptionML = ENU = 'Show Serial/Lot Number',
                                    FRA = 'Afficher numéro série/lot';
                        Visible = false;
                    }
                    field(ActionTypeFilter; ActionTypeFilter)
                    {
                        ApplicationArea = All; //BC Upgrade KUMARR78 Adding ApplicationArea
                        Caption = 'Action type';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            SumUpLinesEditable := true;
            BreakbulkEditable := true;
        end;

        trigger OnOpenPage();
        begin
            if HideOptions then begin
                BreakbulkEditable := false;
                SumUpLinesEditable := false;
            end;
        end;
    }

    labels
    {
        LblSignatureWarehouseEmployeeforLoading = 'Signature Warehouse Employee for Loading'; LblSignatureWarehouseresponsibleforLoading = 'Signature Warehouse responsible for Loading'; LblSignatureDriverforLoading = 'Signature Driver for Loading'; LblWarehouseEmployee = 'Warehouse Employee:'; LblWarehouseresp = 'Warehouse resp:'; LblDriverName = 'Driver Name'; LblSignatureWarehouseEmployeeforUnloading = 'Signature Warehouse Employee for Unloading'; LblSignatureWarehouseresponsibleforUnloading = 'Signature Warehouse responsible for Unloading'; LblSignatureDriverforUnloading = 'Signature Driver for Unloading'; LblDriver = 'Driver'; LblTruck = 'Truck'; LblTransferfromZone = 'Transfer from Zone'; LblTransfertoZone = 'Transfer to Zone'; label(lblSenderNameNsignature; ENU = 'Sender name and signature',
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        FRA = 'Nom et signature de l''expéditeur')
        label(lblreceiverNameNsignature; ENU = 'Receiver name and signature',
                                        FRA = 'Nom et signature du destinataire')
        label(lblDocumentNo; ENU = 'Document No.',
                            FRA = 'Numéro de document')
        label(lblCreatedby; ENU = 'Created by:',
                           FRA = 'Créé par:')
        label(LblExpirationDate; ENU = 'Exp. Date',
                                FRA = 'Date d''expiration')
        label(LblLotNo; ENU = 'Lot No.',
                       FRA = 'N° lot')
        label(LblSerialNo; ENU = 'Serial No.',
                          FRA = 'N° de série')
    }

    trigger OnPreReport();
    begin
        MovementFilter := "Warehouse Activity Header".GetFilters;
    end;

    var
        Location: Record Location;
        TempWhseActivLine: Record "Warehouse Activity Line" temporary;
        MovementFilter: Text;
        SourceDocumentText: Text[30];
        BreakbulkFilter: Boolean;
        SumUpLines: Boolean;
        ShowLotSN: Boolean;
        HideOptions: Boolean;
        InvtMovement: Boolean;
        Counter: Integer;
        BreakbulkEditable: Boolean;
        SumUpLinesEditable: Boolean;
        MovementListCaptionLbl: TextConst ENU = 'Zone Warehouse Movement', FRA = 'Liste mouvements';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', FRA = 'Date d''échéance';
        QtyHandledCaptionLbl: TextConst ENU = 'Qty. Handled', FRA = 'Quantité traitée';
        SourceNoCaptionLbl: TextConst ENU = 'Source No.', FRA = 'N° origine';
        DestinationTypeCaptionLbl: TextConst ENU = 'Destination Type', FRA = 'Type destination';
        DestinationNoCaptionLbl: TextConst ENU = 'Destination No.', FRA = 'N° destination';
        ItemNoCaptionLbl: TextConst ENU = 'Item No.', FRA = 'N° article';
        DescriptionCaptionLbl: TextConst ENU = 'Description', FRA = 'Désignation';
        VariantCodeCaptionLbl: TextConst ENU = 'Variant Code', FRA = 'Code variante';
        ShelfNoCaptionLbl: TextConst ENU = 'Shelf No.', FRA = 'N° emplacement';
        QuantityBaseCaptionLbl: TextConst ENU = 'Quantity', FRA = 'Quantité';
        QtytoHandleCaptionLbl: TextConst ENU = 'Qty. to Handle', FRA = 'Quantité à traiter';
        UOMCodeCaptionLbl: TextConst ENU = 'Unit Of Measure', FRA = 'Code unité';
        ActionTypeCaptionLbl: TextConst ENU = 'Action Type', FRA = 'Type d''action';
        ZoneCodeCaptionLbl: TextConst ENU = 'Zone Code', FRA = 'Code zone';
        BinCodeCaptionLbl: TextConst ENU = 'Bin Code', FRA = 'Code emplacement';
        EmptyStringCaptionLbl: TextConst ENU = '_____', FRA = '____________';
        ExtendedTextLine: Record "Extended Text Line";
        ExtendedTextVal: Text[250];
        ExtendedTextHeader: Record "Extended Text Header";
        ShowExtLine: Boolean;
        CompanyInfo: Record "Company Information";
        CompanyText: Text[50];
        DocumentNoLbl: Label 'Document no.';
        ActionTypeFilter: Option Both,Take,Place;

    local procedure GetLocation(LocationCode: Code[10]);
    begin
        if LocationCode = '' then
            Location.Init()
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

    procedure SetBreakbulkFilter(BreakbulkFilter2: Boolean);
    begin
        BreakbulkFilter := BreakbulkFilter2;
    end;

    procedure SetInventory(SetHideOptions: Boolean);
    begin
        HideOptions := SetHideOptions;
    end;
}

