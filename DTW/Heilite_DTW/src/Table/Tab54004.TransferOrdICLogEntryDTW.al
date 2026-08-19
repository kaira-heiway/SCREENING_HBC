table 54004 "Transfer Ord. IC Log Entry DTW"
{
    // version HEI.01

    // HEI.01 FDD-HT1304 IBM NASTAA02 06.07.2020 # IC Transfer Order Automation
    //   # New Table created for IC Transfer Order Log
    // HEI.02 CHG2090349IBM NASTAA02 09.12.2020 #Bralima opco, difference between the time and date of inter-company transfer
    //   # Added French Translations

    // BC Upgrade KUMARS145 Nav ID Table 50182 "Transfer Order IC Log Entry"

    CaptionML = ENU = 'Transfer Order IC Log Entry',
                FRA = 'Ecritures Ordre de transfert IC Log';

    fields
    {
        field(1; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        FRA = 'Type document';
            Editable = false;
            OptionCaption = 'Transfer Order';
            OptionMembers = "Transfer Order";
        }
        field(2; "Source Type"; Option)
        {
            CaptionML = ENU = 'Source Type',
                        FRA = 'Type origine';
            Editable = false;
            OptionCaption = 'Transfer';
            OptionMembers = Transfer;
        }
        field(3; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        FRA = 'N° document';
            Editable = false;
        }
        field(4; "From Company"; Text[50])
        {
            CaptionML = ENU = 'From Company (DB)',
                        FRA = 'De la société (DB)';
            Editable = false;
        }
        field(5; "Created Document Type"; Option)
        {
            CaptionML = ENU = 'Created Document Type',
                        FRA = 'Type document créé';
            OptionCaption = 'Transfer Order';
            OptionMembers = "Transfer Order";
        }
        field(6; "Created Document No."; Code[20])
        {
            CaptionML = ENU = 'Created Document No.',
                        FRA = 'N° document créé';
            Editable = true;
        }
        field(7; "Creation Date"; Date)
        {
            CaptionML = ENU = 'Creation Date',
                        FRA = 'Date création';
            Editable = false;
        }
        field(8; "Creation Time"; Time)
        {
            CaptionML = ENU = 'Creation Time',
                        FRA = 'Heure création';
            Editable = false;
        }
        field(9; "User ID"; Code[50])
        {
            CaptionML = ENU = 'User ID',
                        FRA = 'Code utilisateur';
            Editable = false;
        }
        field(10; Status; Option)
        {
            CaptionML = ENU = 'Status',
                        FRA = 'Statut';
            OptionCaptionML = ENU = ' ,Transfer Exported,Transfer Imported,Transfer Posted,Posting info. Exported,Posting info. Imported,Done',
                              FIN = ' ,Transfert Exporté,Transfert Importé,Transfert Validé,Validation info. Exporté,Validation info. Importé,Fait';
            OptionMembers = " ","Transfer Exported","Transfer Imported","Transfer Posted","Posting info. Exported","Posting info. Imported",Done;
        }
        field(11; "Last Error"; Text[250])
        {
            CaptionML = ENU = 'Last Error',
                        FRA = 'Dernière erreur';
        }
        field(14; "To Company"; Text[30])
        {
            CaptionML = ENU = 'To Company (DB)',
                        FRA = 'à la société (DB)';
            Editable = false;
        }
        field(20; "Request File"; BLOB)
        {
            CaptionML = ENU = 'Request File',
                        FRA = 'Requête Fichier';
        }
        field(21; "Request Message"; BLOB)
        {
            CaptionML = ENU = 'Request Message',
                        FRA = 'Requête Message';
        }
    }

    keys
    {
        key(Key1; "Source Type", "Document Type", "Document No.", "From Company")
        {
        }
    }

    fieldgroups
    {
    }

    var
        RequestSentErr: Label 'Request XML was already sent.';
        ICTransferOrderWS: Codeunit "IC Transfer Order WS";
        TransferOrderICLogEntry: Record "Transfer Ord. IC Log Entry DTW";

    procedure ShowXML();
    var
        Instr: InStream;
        Outstr: OutStream;
        // BC Upgrade KUMARS145 replaced deprecated record ......>>
        // TempBlob: Record TempBlob temporary;
        TempBlob: Codeunit "Temp Blob";
        // BC Upgrade KUMARS145 replaced deprecated record ......<<
        FileManagement: Codeunit "File Management";
        FileName: Text;
    begin
        if "Request File".HASVALUE() then begin
            FileName := 'Request_' + "Document No.";
            CALCFIELDS("Request File");
            "Request File".CREATEINSTREAM(Instr);
        end;

        TempBlob.CreateOutStream(Outstr);
        COPYSTREAM(Outstr, Instr);
        FileManagement.BLOBExport(TempBlob, FileName + '.xml', true);
    end;

    // BC Upgrade KUMARS145 ......>>
    // dependent on table "IC Web Service Setup" Drinkit
    procedure ResendXML();
    var
    //     ICWebServiceSetup: Record "IC Web Service Setup"; //BC Upgrade KUMARS145 "IC Web Service Setup" Drinkit table.
    //     XMLDoc: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
    //     XMLResponse: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlDocument";
    //     OutputStream: OutStream;
    //     TempBlob: Codeunit "Temp Blob";// Record TempBlob temporary;
    //     InputStream: InStream;
    //     Request: BigText;
    begin
        // ICWebServiceSetup.RESET;
        // ICWebServiceSetup.SETRANGE("Sending Type", ICWebServiceSetup."Sending Type"::Transfer);
        // ICWebServiceSetup.SETRANGE("To Database", "To Company");
        // if ICWebServiceSetup.FINDFIRST then begin
        //     if ((Status = Status::Done) and ("Created Document No." <> '')) or
        //        ((Status = Status::"Transfer Posted") and ("Last Error" <> ''))
        //     then
        //         ERROR(RequestSentErr);

        //     if "From Company" = COMPANYNAME then
        //         if "Request Message".HASVALUE then begin
        //             CALCFIELDS("Request Message");
        //             "Request Message".CREATEINSTREAM(InputStream);

        //             XMLDoc := XMLDoc.XmlDocument;
        //             XMLDoc.Load(InputStream);
        //             XMLResponse := XMLResponse.XmlDocument;

        //             ICTransferOrderWS.ProcessRequestAPI(XMLDoc, XMLResponse, Rec, ICWebServiceSetup);
        //         end;
        // end;
    end;
    //BC Upgrade KUMARS145 ......<<
    // dependent on table "IC Web Service Setup" Drinkit
    procedure OpenCreatedTO();
    var
        TransferHeader: Record "Transfer Header";
    begin
        if "To Company" = COMPANYNAME then
            TransferHeader.SETRANGE("No.", "Created Document No.");
        if TransferHeader.FINDFIRST() then
            PAGE.RUN(5740, TransferHeader);
    end;

    procedure Reprocess();
    begin
        this.TransferOrderICLogEntry.RESET();
        this.TransferOrderICLogEntry.GET("Source Type", "Document Type", "Document No.", "From Company");
        if not CODEUNIT.RUN(50132, this.TransferOrderICLogEntry) then begin
            this.TransferOrderICLogEntry."Last Error" := GetLastErrorText;
            this.TransferOrderICLogEntry.MODIFY(true);
        end;
        ICTransferOrderWS.SendAPIResponse(this.TransferOrderICLogEntry);
    end;

    procedure ReprocessShipment();
    var
        TransferHeader: Record "Transfer Header";
        TransferOrderICLogEntryLocal: Record "Transfer Ord. IC Log Entry DTW";
        ICTransferOrderWSLocal: Codeunit "IC Transfer Order WS";
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
    begin
        if ("Created Document No." <> '') and (Status <> Status::"Posting info. Exported") then begin
            //Post Transfer Order - Shipment
            TransferHeader.GET("Created Document No.");
            if not TransferPostShipment.RUN(TransferHeader) then begin
                "Last Error" := GetLastErrorText();
                Rec.Modify(true);
            end;
            ICTransferOrderWSLocal.SendAPIResponse(Rec);
        end;
    end;


}

