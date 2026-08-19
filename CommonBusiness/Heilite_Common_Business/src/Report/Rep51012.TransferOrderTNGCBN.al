report 51012 "Transfer Order TNG CBN"
{
    // version HEI.06

    // FDD HNK FDD-AL-LOGGAP03_Transfer Order , IBM.NAIKH01 28.09.2017
    //     #Created a new Report
    // FCE01: Added Company Language from the start with way to change
    // FCE02 : Changed the Transfer Order into a Text Variabel
    // 
    // HEI.02 Defect #1371 IBM NASTAA02 15.01.2018 # Transfer Order Layout
    //   # Layout improvements
    //   # Fixed missing "Lot No." field
    // 
    // HEI.03 Defect #1665 IBM NASTAA02 09.03.2018 # Transfer Order Report
    //   # Added new fields on the header and changed some labels on the body and on the footer
    // 
    // HEI.04 Bugfixing IBM NASTAA02 14.03.2018 # Bugfixing Algeria
    //   # Used "Home Page" from locations to fill in the Registre of Commerce in the Company info
    // 
    // HEI.05 Defect #1665 IBM NASTAA02 22.03.2018 # Transfer Order Report
    //   # Changed some labels in the Company Information
    //   # Removed NIF for Transfer Locations
    //   # Moved one table lower in the footer
    //   # Drawed entire table on the lines
    // 
    // HEI.06 FDD-AL-LOGGAP03_Transfer Order Bugfixing IBM POSTOI01 09.08.2018 # Bugfixing for Mozambique, labels in french
    //   # labels lblStore and lblPersonTrans has only french values. Added english values
    // 
    // HEI.07 BRD CHG2003750 Transfer Order changes
    //   #to Remove "Nom" from the caption field "Nom Chauffeur" and Display value "Whse. Shipping Driver”.Description.
    //   #Remove « Permis de Conduire» (License Number) field.
    //   #Display "Whse. Shipping Truck".Description value. and Delete field "Matricule remorque"
    //   #Display Item's Inventory unit of measure value in field value “Unité”. and Display the correct quantity in terms of item inventory unit of measure.

    // BC Upgrade SHUKLP03 >>
    //HEI.07 => Some part of code on trigger OnAfterGetRecord is blocked because DrinkIT field Item."Inventory Unit of Measure", "Driver Code" and "Truck Code" is used.
    // DrinkIT code is blocked.
    // BC Upgrade SHUKLP03 <<

    DefaultLayout = RDLC;
    RDLCLayout = '.\src\ReportsLayout\Transfer Order TNG.rdl'; // BC Upgrade SHUKLP03 <<
    ApplicationArea = All;   // BC Upgrade SHUKLP03 <<

    Caption = 'Transfer Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code";
            RequestFilterHeading = 'Tranasfer Header';
            column(No_TransHeader; "No.")
            {
            }
            column(PostDate_TransHeader; FORMAT("Transfer Header"."Posting Date", 0, 4))
            {
            }
            column(PageCaption; Text002)
            {
            }
            column(WhseShippingDriverName; WhseShippingDriverName)
            {
            }
            column(WhseShippingTruckName; WhseShippingTruckName)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = CONST(1));
                    column(PageNo; FORMAT(CurrReport.PAGENO()))
                    {
                    }
                    column(NoOfCopies; NoOfCopies)
                    {
                    }
                    column(LotInfo; ShowLotInfo)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(CopyTextCaption; CopyText)
                    {
                    }
                    column(CompName; CompanyInfo.Name)
                    {
                    }
                    column(CompAdd; CompanyInfo.Address)
                    {
                    }
                    column(CompPhone; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompFax; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo_RegistrationNo; CompanyInfo."Registration No.")
                    {
                    }

                    // BC Upgrade SHUKLP03 >> DrinkIT field CompanyInfo."Tax Registration No." is blocked
                    // column(CompanyInfo_TaxRegistrationNo;CompanyInfo."Tax Registration No.")
                    // {
                    // }
                    // BC Upgrade SHUKLP03 << DrinkIT field CompanyInfo."Tax Registration No." is blocked

                    column(TransferFAdd1; TransferFromAddr[1])
                    {
                    }
                    column(TransferFAdd2; TransferFromAddr[2])
                    {
                    }
                    column(TransferFAdd3; TransferFromAddr[3])
                    {
                    }
                    column(TransferFAdd4; TransferFromAddr[4])
                    {
                    }
                    column(TransferFAdd5; TransferFromAddr[5])
                    {
                    }
                    column(TransferFAdd6; TransferFromAddr[6])
                    {
                    }
                    column(TransferFAdd7; TransferFromAddr[7])
                    {
                    }
                    column(TransferFAdd8; TransferFromAddr[8])
                    {
                    }

                    // BC Upgrade SHUKLP03 >> DrinkIT field CompanyInfo."Tax Registration No." is blocked
                    // column(TransferFAdd_NIF; CompanyInfo."Tax Registration No.")
                    // {
                    // }
                    // BC Upgrade SHUKLP03 << DrinkIT field CompanyInfo."Tax Registration No." is blocked

                    column(TransferFAdd_NRC; TransferFromLocation."Home Page")
                    {
                    }
                    column(TransferTAdd1; TransferToAddr[1])
                    {
                    }
                    column(TransferTAdd2; TransferToAddr[2])
                    {
                    }
                    column(TransferTAdd3; TransferToAddr[3])
                    {
                    }
                    column(TransferTAdd4; TransferToAddr[4])
                    {
                    }
                    column(TransferTAdd5; TransferToAddr[5])
                    {
                    }
                    column(TransferTAdd6; TransferToAddr[6])
                    {
                    }
                    column(TransferTAdd7; TransferToAddr[7])
                    {
                    }
                    column(TransferTAdd8; TransferToAddr[8])
                    {
                    }

                    // BC Upgrade SHUKLP03 >> DrinkIT field CompanyInfo."Tax Registration No." is blocked
                    // column(TransferTAdd_NIF; CompanyInfo."Tax Registration No.")
                    // {
                    // }
                    // BC Upgrade SHUKLP03 << DrinkIT field CompanyInfo."Tax Registration No." is blocked

                    column(TransferTAdd_NRC; TransferToLocation."Home Page")
                    {
                    }
                    dataitem("Transfer Line"; "Transfer Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Transfer Header";
                        DataItemTableView = sorting("Document No.", "Line No.");
                        column(ItemNo_TransLine; "Item No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Desc_TransLine; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(Qty_TransLine; Qty_TransLine)
                        {
                            IncludeCaption = false;
                        }
                        column(qtyshipebase; "Qty. Shipped (Base)")
                        {
                            IncludeCaption = true;
                        }
                        column(UOM_TransLine; "Unit of Measure")
                        {
                            IncludeCaption = true;
                        }
                        column(OutputNo; OutputNo)
                        {
                        }
                        column(DimensionInformation; DimText)
                        {
                        }
                        column(LotInformation; TrackingText)
                        {
                        }
                        column(ItemInventUOM; ItemInventUOM)
                        {
                        }

                        trigger OnAfterGetRecord();
                        var
                            ReservationEntry: Record "Reservation Entry";
                        begin
                            CLEAR(DimText);
                            CLEAR(TrackingText);
                            DimSetEntry.RESET();
                            DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            if DimSetEntry.findset() then
                                repeat
                                    DimText += DimSetEntry."Dimension Code" + '-' + DimSetEntry."Dimension Value Code" + ';';
                                until DimSetEntry.NEXT() = 0;

                            //HEI.02>>
                            ReservationEntry.RESET();
                            ReservationEntry.SETRANGE("Source Type", DATABASE::"Transfer Line");
                            ReservationEntry.SETRANGE("Source ID", "Document No.");
                            ReservationEntry.SETRANGE("Item No.", "Item No.");
                            if ReservationEntry.FINDFIRST() then
                                repeat
                                    TrackingText := ReservationEntry."Lot No." + ';';
                                until ReservationEntry.NEXT() = 0;
                            //HEI.02<<

                            //HEI.07>>

                            // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field Item."Inventory Unit of Measure" is used.
                            // if Item.GET("Transfer Line"."Item No.") then
                            //     ItemInventUOM := Item."Inventory Unit of Measure";
                            // BC Upgrade SHUKLP03 << Blocked because DrinkIT field Item."Inventory Unit of Measure" is used.


                            ItemUnitofMeasure.RESET();
                            ItemUnitofMeasure.SETFILTER("Item No.", "Transfer Line"."Item No.");
                            //ItemUnitofMeasure.SETFILTER(Code, Item."Inventory Unit of Measure");// BC Upgrade SHUKLP03 << Blocked because DrinkIT field Item."Inventory Unit of Measure" is used.
                            if ItemUnitofMeasure.FINDFIRST() then
                                Qty_TransLine := ("Transfer Line"."Qty. Shipped (Base)" / ItemUnitofMeasure."Qty. per Unit of Measure");
                            //HEI.07<<
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText := STRSUBSTNO(Text001, Text003);
                        OutputNo += 1;
                    end
                    else
                        CurrReport.PAGENO := 1;
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    // FCE02 CopyText := 'Transfer Order';
                    CopyText := STRSUBSTNO(Text001, Text003);
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;

                    if OutputNo = 1 then
                        // FCE01 CopyText := 'Transfer Order';
                        CopyText := STRSUBSTNO(Text001, '');
                end;
            }

            trigger OnAfterGetRecord();
            begin
                FormatAddr.TransferHeaderTransferFrom(TransferFromAddr, "Transfer Header");
                FormatAddr.TransferHeaderTransferTo(TransferToAddr, "Transfer Header");
                //HEI.03>>
                TransferFromLocation.GET("Transfer-from Code");
                TransferToLocation.GET("Transfer-to Code");
                //HEI.03<<

                // BC Upgrade SHUKLP03 >> Blocked because DrinkIT field "Driver Code" and "Truck Code" is used.
                // //HEI.07>>
                // if WhseShippingDriver.GET("Transfer Header"."Driver Code") then
                //     WhseShippingDriverName := WhseShippingDriver.Description;

                // if WhseShippingTruck.GET("Transfer Header"."Truck Code") then
                //     WhseShippingTruckName := WhseShippingTruck.Description;
                // //HEI.07<<
                // BC Upgrade SHUKLP03 << Blocked because DrinkIT field "Driver Code" and "Truck Code" is used.

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the NoOfCopies field.';
                    }
                    field("Show Internal Information"; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ShowInternalInfo field.';
                    }
                    field("Show Lot/Serial Information"; ShowLotInfo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the ShowLotInfo field.';
                    }
                    field(Printlanguage; PrintLanguage)
                    {
                        TableRelation = Language;
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the PrintLanguage field.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        label(lblPostingDate; ENU = 'Date',
                             FRA = 'Fait, le')
        label(lblPersonTrans; ENU = 'Person who made the transfer',
                             FRA = 'Personne ayant effectuée le transfert')
        label(lblName; ENU = 'Name  ...............................',
                      FRA = 'Nom  ...............................')
        label(lblCompTel; ENU = 'Tel :',
                         FRA = 'Tél :')
        label(lblRespPerson; ENU = 'Responsible',
                            FRA = 'Responsable')
        label(lblCompFax; ENU = 'Fax :',
                         FRA = 'Fax :')
        label(lblStore; ENU = 'Store',
                       FRA = 'Magasin')
        label(lblDirection; ENU = 'DIRECTION ........................',
                           FRA = 'Code Utilisateur')
        label(lblTransferTo; ENU = 'Vers',
                            FRA = 'Code Dest. Transfert')
        label(lblSign; ENU = 'Signature,',
                      FRA = 'Signature,')
        label(ItemNoCaption; ENU = 'Item No.',
                            FRA = 'N° Article')
        label(ItemDescriptionCation; ENU = 'Description',
                                    FRA = 'Désignation')
        label(QuantityCaption; ENU = 'Quantity Shipped',
                              FRA = 'Quantité Expédiée')
        label(UOMCaption; ENU = 'Unit of Measure',
                         FRA = 'Unité')
        label(CRLbl; ENU = 'CR :',
                    FRA = 'CR :')
        label(IFLbl; ENU = 'RN :',
                    FRA = 'IF :')
        label(NIFLbl; ENU = 'NIF :',
                     FRA = 'NIF :')
        label(RCLbl; ENU = 'RC :',
                    FRA = 'RC :')
        label(CommentsLbl; ENU = 'Comments and Obs.',
                          FRA = 'Commentaires et Obs.')
        label(SenderLbl; ENU = 'Sender ............................',
                        FRA = 'Expéditeur ............................')
        label(ReceiverLbl; ENU = 'Receiver ............................',
                          FRA = 'Destinataire ............................')
        label(DriverNameLbl; ENU = 'Driver Name:',
                            FRA = 'Chauffeur:')
        label(DriverLicenseLbl; ENU = 'Driver License:',
                               FRA = 'Permis de conduire:')
        label(TruckNoLbl; ENU = 'Truck No:',
                         FRA = 'Matricule Camion:')
        label(TrailerNoLbl; ENU = 'Trailer No:',
                           FRA = 'Matricule Remorque:')
        label(DepartureDateTimeLbl; ENU = 'Departure Date and Time:',
                                   FRA = 'Date et Heure de départ.:')
        LineLbl = '.............................';
    }

    trigger OnPreReport();
    begin
        // FCE01-
        CompanyInfo.GET();
        PrintLanguage := CompanyInfo."Language Code FND";
        CurrReport.LANGUAGE := LanguageG.GetLanguageId(PrintLanguage); // BC Upgrade SHUKLPO3 << Replaced LanguageG record varible with codeunit because GetLanguageId() procedure is moved in codeunit.
        //Language.GetLanguageID(PrintLanguage);
        // FCE01+
    end;

    var
        CompanyInfo: Record "Company Information";
        DimSetEntry: Record "Dimension Set Entry";
        Item: Record Item;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        TransferFromLocation: Record Location;
        TransferToLocation: Record Location;
        FormatAddr: Codeunit "Format Address";
        LanguageG: Codeunit Language;
        ShowInternalInfo: Boolean;
        ShowLotInfo: Boolean;
        PrintLanguage: Code[10];
        Qty_TransLine: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        HdrDimCaptionLbl: Label 'Header Dimensions';
        LineDimCaptionLbl: Label 'Line Dimensions';
        Text002: Label 'Page';
        DimText: Text;
        ItemInventUOM: Text[20];
        CopyText: Text[30];
        TransferFromAddr: array[8] of Text[50];
        TransferToAddr: array[8] of Text[50];
        //WhseShippingDriver: Record "Whse. Shipping Driver"; // BC Upgrade SHUKLP03 <<
        WhseShippingDriverName: Text[50];
        //WhseShippingTruck: Record "Whse. Shipping Truck"; // BC Upgrade SHUKLP03 <<
        WhseShippingTruckName: Text[50];
        TrackingText: Text[80];
        Text001: TextConst ENU = 'Internal Transfer Order %1', FRA = 'Bon de Transfert Interne %1';
        Text003: TextConst ENU = 'COPY', FRA = 'COPIE';
}

