codeunit 58057 "Ibecor Interface Management"
{
    //BC Upgrade GUNREM01 Old ID-50222

    // version HEI.01

    // HEI.01 CHG2255708 SAHAL01 15.10.2024 Ibecor PFI Acknowledgment Interface
    //   # Created New Codeunit: 50222 - Ibecor Interface Management
    //   # Created New Functions - GetCompanyInformation_Ibecor
    //                           - GetGeneralInterfaceSetup_Ibecor
    //                           - GetIbecorInterfaceSetup_Ibecor
    //                           - ValidateInterfaceSetup_Ibecor
    //                           - GetLocalCurrentDateTime_Ibecor
    //                           - GetPurchaseSetup_Ibecor
    //                           - GetGLSetup_Ibecor
    //                           - GetUserID_Ibecor
    //                           - OutboundPurchaseOrderPFIConfirmation_Ibecor
    //                           - OnAfterInterfaceErrorUpdate_Ibecor
    //   # Added Code

    //BC UPGRADE ATHUKS01>>
    //1.Moved Methods GenExt to Interface extension.
    //BC UPGRADE ATHUKS01<<


    trigger OnRun();
    begin
    end;

    var
        CompanyInformation: Record "Company Information";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";
        CompanyInformationRead: Boolean;
        GeneralInterfaceSetupRead: Boolean;
        IbecorInterfaceSetupRead: Boolean;
        Text000: Label 'Interface ''%1'' is not enabled.';
        Text001: Label 'Park';
        Text002: Label 'Error';
        Text003: Label 'Success';
        Text004: Label 'HEIWAY\%1';
        PurchPaySetup: Record "Purchases & Payables Setup";
        PurchSetupRead: Boolean;
        GLSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;
        Text005: Label '%1 No. cannot be blank while sending the %2 confirmation message for this Interface %3.';
        Text006: Label 'Header Entry';
        Text007: Label 'Purchase Order';
        Text008: Label 'PFI';
        Text010: Label 'PFI No. %1 has been successfully processed.';

    local procedure GetCompanyInformation_Ibecor();
    begin
        //HEI.01>>
        if not CompanyInformationRead then begin
            CompanyInformation.GET;
            CompanyInformationRead := true;
        end;
        //HEI.01<<
    end;

    local procedure GetGeneralInterfaceSetup_Ibecor();
    begin
        //HEI.01>>
        if not GeneralInterfaceSetupRead then begin
            GeneralInterfaceSetup.GET;
            GeneralInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure GetIbecorInterfaceSetup_Ibecor();
    begin
        //HEI.01>>
        if not IbecorInterfaceSetupRead then begin
            if IbecorInterfaceSetup.GET and IbecorInterfaceSetup."Interface Enable/Disable" then
                IbecorInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure ValidateInterfaceSetup_Ibecor(InterfaceCode: Code[20]);
    var
        InterfaceSetupL: Record "Interface Setup INT";
    begin
        //HEI.01>>
        InterfaceSetupL.GET(InterfaceCode);
        if not InterfaceSetupL.Enabled then
            ERROR(Text000, InterfaceSetupL.Code);
        //HEI.01<<
    end;

    procedure GetLocalCurrentDateTime_Ibecor() Now: DateTime;
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
    begin
        //HEI.01>>
        Now := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        //HEI.01<<
    end;

    local procedure GetPurchaseSetup_Ibecor();
    begin
        //HEI.01>>
        if not PurchSetupRead then begin
            PurchPaySetup.GET;
            PurchSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure GetGLSetup_Ibecor();
    begin
        //HEI.01>>
        if not GLSetupRead then begin
            GLSetup.GET;
            GLSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure GetUserID_Ibecor(UserCode: Code[50]) UserID: Code[50];
    var
        UserL: Record User;
        UserSetupL: Record "User Setup";
    begin
        //HEI.01>>
        UserL.SETCURRENTKEY("User Name");
        UserL.SETRANGE("User Name", STRSUBSTNO(Text004, UserCode));
        if not UserL.FINDFIRST then begin
            UserL.INIT;
            UserL."User Security ID" := CREATEGUID;
            UserL."User Name" := STRSUBSTNO(Text004, UserCode);
            UserL.INSERT(false);

            UserSetupL.INIT;
            UserSetupL.VALIDATE("User ID", UserL."User Name");
            UserSetupL.INSERT(false);
            UserID := UserL."User Name";
        end else begin
            if UserSetupL.GET(UserL."User Name") then
                UserID := UserSetupL."User ID"
            else begin
                UserSetupL.INIT;
                UserSetupL.VALIDATE("User ID", UserL."User Name");
                UserSetupL.INSERT(false);
                UserID := UserSetupL."User ID";
            end;
        end;
        exit(UserID);
        //HEI.01>>
    end;

    procedure OutboundPurchaseOrderPFIConfirmation_Ibecor(var InterfaceEntryNo: Integer; var SourceNo: Code[20]);
    var
        InterfaceEntryHeaderL: Record "Interface Entry Header INT";
        InterfaceLogHeaderL: Record "Interface Log Header INT";
        SendInterfaceEntryHeaderL: Record "Interface Entry Header INT";
        FoundInterfaceEntryNoL: Boolean;
        MessageNameL: Text[30];
        ContactL: Code[20];
        ActionCodeL: Code[2];
        SourceNoL: Code[20];
        MessageTypeL: Text[35];
        MessageL: Text[250];
    begin
        //HEI.01>>
        GetIbecorInterfaceSetup_Ibecor;
        if not IbecorInterfaceSetupRead then begin
            CLEAR(IbecorInterfaceSetup);
            exit;
        end;
        if IbecorInterfaceSetup."IBECOR PFI Confmtion Interface" = '' then
            exit;
        if InterfaceEntryNo = 0 then
            ERROR(Text005, Text006, Text007, IbecorInterfaceSetup."IBECOR PFI Confmtion Interface");
        if SourceNo = '' then
            ERROR(Text005, Text007, Text007, IbecorInterfaceSetup."IBECOR PFI Confmtion Interface");
        GetCompanyInformation_Ibecor;
        GetGeneralInterfaceSetup_Ibecor;
        IbecorInterfaceSetup.TESTFIELD("IBECOR PFI");
        ValidateInterfaceSetup_Ibecor(IbecorInterfaceSetup."IBECOR PFI");
        ValidateInterfaceSetup_Ibecor(IbecorInterfaceSetup."IBECOR PFI Confmtion Interface");

        InterfaceEntryHeaderL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, "Source No.", Status);
        InterfaceEntryHeaderL.SETRANGE("Entry No.", InterfaceEntryNo);
        InterfaceEntryHeaderL.SETRANGE("Interface Code", IbecorInterfaceSetup."IBECOR PFI");
        InterfaceEntryHeaderL.SETRANGE(Direction, InterfaceEntryHeaderL.Direction::Inbound);
        InterfaceEntryHeaderL.SETRANGE("Source No.", SourceNo);
        InterfaceEntryHeaderL.SETRANGE(Status, InterfaceEntryHeaderL.Status::Error);
        if InterfaceEntryHeaderL.FINDLAST then begin
            SendInterfaceEntryHeaderL.INIT;
            SendInterfaceEntryHeaderL."Interface Code" := IbecorInterfaceSetup."IBECOR PFI Confmtion Interface";
            SendInterfaceEntryHeaderL.Direction := SendInterfaceEntryHeaderL.Direction::Outbound;
            SendInterfaceEntryHeaderL.Status := SendInterfaceEntryHeaderL.Status::Pending;
            SendInterfaceEntryHeaderL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderL."Message Name" := InterfaceEntryHeaderL."Message Name";
            SendInterfaceEntryHeaderL.Contact := InterfaceEntryHeaderL.Contact;
            SendInterfaceEntryHeaderL."Action Code" := InterfaceEntryHeaderL."Action Code";
            SendInterfaceEntryHeaderL."Source No." := InterfaceEntryHeaderL."Source No.";
            SendInterfaceEntryHeaderL."Phone No." := Text002;
            SendInterfaceEntryHeaderL."Message Code" := '3';
            SendInterfaceEntryHeaderL."Your Reference" := InterfaceEntryHeaderL."Your Reference";
            SendInterfaceEntryHeaderL.DocumentURL := DELSTR((Text008 + ': ' + InterfaceEntryHeaderL."Source No." + ': ' + InterfaceEntryHeaderL."Error Message"), MAXSTRLEN(InterfaceEntryHeaderL.DocumentURL));
            SendInterfaceEntryHeaderL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderL.INSERT(true);
            FoundInterfaceEntryNoL := true;
            exit;
        end;

        if not FoundInterfaceEntryNoL then begin
            InterfaceEntryHeaderL.SETRANGE(Status, InterfaceEntryHeaderL.Status::Processed);
            if InterfaceEntryHeaderL.FINDLAST then begin
                MessageNameL := InterfaceEntryHeaderL."Message Name";
                ContactL := InterfaceEntryHeaderL.Contact;
                ActionCodeL := InterfaceEntryHeaderL."Action Code";
                SourceNoL := InterfaceEntryHeaderL."Source No.";
                MessageTypeL := InterfaceEntryHeaderL."Your Reference";
                MessageL := STRSUBSTNO(Text010, InterfaceEntryHeaderL."Source No.");
            end else begin
                InterfaceLogHeaderL.SETCURRENTKEY("Interface Entry No.", "Interface Code", Direction, "Source No.", Status);
                InterfaceLogHeaderL.SETRANGE("Interface Entry No.", InterfaceEntryNo);
                InterfaceLogHeaderL.SETRANGE("Interface Code", IbecorInterfaceSetup."IBECOR PFI");
                InterfaceLogHeaderL.SETRANGE(Direction, InterfaceLogHeaderL.Direction::Inbound);
                InterfaceLogHeaderL.SETRANGE("Source No.", SourceNo);
                InterfaceLogHeaderL.SETRANGE(Status, InterfaceLogHeaderL.Status::Processed);
                if InterfaceLogHeaderL.FINDLAST then begin
                    MessageNameL := InterfaceLogHeaderL."Message Name";
                    ContactL := InterfaceLogHeaderL.Contact;
                    ActionCodeL := InterfaceLogHeaderL."Action Code";
                    SourceNoL := InterfaceLogHeaderL."Source No.";
                    MessageTypeL := InterfaceLogHeaderL."Your Reference";
                    MessageL := STRSUBSTNO(Text010, InterfaceLogHeaderL."Source No.");
                end;
            end;

            SendInterfaceEntryHeaderL.INIT;
            SendInterfaceEntryHeaderL."Interface Code" := IbecorInterfaceSetup."IBECOR PFI Confmtion Interface";
            SendInterfaceEntryHeaderL.Direction := SendInterfaceEntryHeaderL.Direction::Outbound;
            SendInterfaceEntryHeaderL.Status := SendInterfaceEntryHeaderL.Status::Pending;
            SendInterfaceEntryHeaderL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderL."Message Name" := MessageNameL;
            SendInterfaceEntryHeaderL.Contact := ContactL;
            SendInterfaceEntryHeaderL."Action Code" := ActionCodeL;
            SendInterfaceEntryHeaderL."Source No." := SourceNoL;
            SendInterfaceEntryHeaderL."Phone No." := Text003;
            SendInterfaceEntryHeaderL."Message Code" := '1';
            SendInterfaceEntryHeaderL."Your Reference" := MessageTypeL;
            SendInterfaceEntryHeaderL.DocumentURL := MessageL;
            SendInterfaceEntryHeaderL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderL.INSERT(true);
        end;
        //HEI.01<<
    end;

    // [EventSubscriber(ObjectType::Codeunit, 50000, 'OnAfterSetInterfaceError', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Interface Framework Mgt.", 'OnAfterSetInterfaceError', '', false, false)]

    local procedure OnAfterInterfaceErrorUpdate_Ibecor(InterfaceEntryHeader: Record "Interface Entry Header INT");
    begin
        //HEI.01>>
        GetIbecorInterfaceSetup_Ibecor;
        if not IbecorInterfaceSetupRead then begin
            CLEAR(IbecorInterfaceSetup);
            exit;
        end;
        if IbecorInterfaceSetupRead and (InterfaceEntryHeader.Status = InterfaceEntryHeader.Status::Error) then begin
            case InterfaceEntryHeader."Interface Code" of
                IbecorInterfaceSetup."IBECOR PFI":
                    begin
                        if InterfaceEntryHeader.Direction = InterfaceEntryHeader.Direction::Inbound then begin
                            OutboundPurchaseOrderPFIConfirmation_Ibecor(InterfaceEntryHeader."Entry No.", InterfaceEntryHeader."Source No.");
                        end;
                    end;
            end;
        end;
        CLEAR(IbecorInterfaceSetup);
        CLEAR(IbecorInterfaceSetupRead);
        CLEAR(GeneralInterfaceSetup);
        CLEAR(GeneralInterfaceSetupRead);
        CLEAR(CompanyInformation);
        CLEAR(CompanyInformationRead);
        CLEAR(PurchSetupRead);
        CLEAR(GLSetupRead);
        //HEI.01<<
    end;

    //BC UPGRADE ATHUKS01>>
    [EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure CU415OnAfterReleasePurchDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    begin
        //HEI.111 >>
        IbecorCreatePORequest(PurchaseHeader, PreviewMode);
        //HEI.111 <<
    end;

    local procedure IbecorCreatePORequest(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean);
    var
        InterfaceSetup: Record "Interface Setup INT";//BC Upgrade SHARMP16 -- Interface Code
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";//BC Upgrade SHARMP16 -- Interface Code
        InterfaceEntryLineOut: Record "Interface Entry Line INT";//BC Upgrade SHARMP16 -- Interface Code
        lrec_Vend: Record Vendor;
        lrec_IbecorData: Record "Ibecor PO Staging Data INT";//BC Upgrade SHARMP16-- Interface related table
        lrec_PurchLn: Record "Purchase Line";
        LineChanged: Boolean;
        lrec_InterfaceLocationMatrix: Record "Interface Location Matrix FND";//BC Upgrade SHARMP16 -- Interface Code
        lrec_CompInfo: Record "Company Information";
        IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";//BC Upgrade SHARMP16 -- Interface Code
        GIdfromSetup: Code[20];
        PFIHeader: Record "PFI Header INT";//BC Upgrade SHARMP16 -- Interface Code
        PFILine: Record "PFI Lines FND";//BC Upgrade SHARMP16 -- Interface Code
        PurchaseHdrAdditional: Record "Purchase Header Additional FND";
        PFIApproval: Record "PFI Approval FND";//BC Upgrade SHARMP16 -- Interface Code
        lrecGeneralLedgerSetup: Record "General Ledger Setup";
        lrecDimensionValue: Record "Dimension Value";
        //DocumentShippingCost: Record "Document Shipping Cost";//BC Upgrade SHARMP16-- Drink-It table.
        DocShippingAmount: Decimal;
    begin
        //HEI.63>>
        if PurchaseHeader.ISTEMPORARY then
            exit;
        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;
        //HEI.89>>
        if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then
            if (PurchaseHdrAdditional."PFI Document No. INT" = '') then
                exit;
        //HEI.89<<
        if not IbecorInterfaceSetup.GET then
            exit;
        if not IbecorInterfaceSetup."Interface Enable/Disable" then
            exit;

        if IbecorInterfaceSetup.GET and (IbecorInterfaceSetup."IBECOR API PO Notification" = '') then
            exit;
        IbecorInterfaceSetup.TESTFIELD("IBECOR Vendor");
        IbecorInterfaceSetup.TESTFIELD("IBECOR API PO Notification");


        lrec_Vend.RESET;
        lrec_Vend.SETRANGE("Global Vendor Number FND", IbecorInterfaceSetup."IBECOR Vendor");//BC Upgrade SHARMP16--Interface Code 
        if lrec_Vend.FINDFIRST then begin
            if not (PurchaseHeader."Buy-from Vendor No." = lrec_Vend."No.") then
                exit;
        end else
            exit;

        //Header insertion/modification
        lrec_CompInfo.GET;

        lrec_IbecorData.RESET;
        lrec_IbecorData.SETRANGE("Document Type", PurchaseHeader."Document Type");
        lrec_IbecorData.SETRANGE("Document No", PurchaseHeader."No.");
        if not lrec_IbecorData.FINDFIRST then begin
            lrec_IbecorData."Document Type" := PurchaseHeader."Document Type".AsInteger();
            lrec_IbecorData."Document No" := PurchaseHeader."No.";
            lrec_IbecorData."Buy from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
            lrec_IbecorData."Document Date" := PurchaseHeader."Document Date";
            lrec_IbecorData."Record Type" := lrec_IbecorData."Record Type"::Header;
            //HEI.128>>
            if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
                if (PurchaseHdrAdditional."PFI Document No. INT" <> '') then begin
                    if PFIHeader.GET(PurchaseHdrAdditional."PFI Document No. INT") then begin
                        if lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor", PurchaseHeader."Location Code", PFIHeader."Brewery ID") then
                            lrec_IbecorData."Opco Code" := lrec_InterfaceLocationMatrix."IBC Location Code";
                    end;
                end;
            end;
            //        //BC Upgrade SHARMP16--Interface Code end>>
            //IF lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor",PurchaseHeader."Location Code") THEN
            //  lrec_IbecorData."Opco Code" := lrec_InterfaceLocationMatrix."IBC Location Code";
            //HEI.128<<
            lrec_IbecorData."Bill to Customer GID" := lrec_CompInfo."Legal Entity Code FND";        //BC Upgrade SHARMP16--Interface Code 
                                                                                                    //HEI.82>>
            DocShippingAmount := 0;
            //BC Upgrade SHARMP16--Drink-IT code begin>>
            // DocumentShippingCost.RESET;
            // DocumentShippingCost.SETRANGE("Source Type", DATABASE::"Purchase Header");
            // DocumentShippingCost.SETRANGE("Source No.", PurchaseHeader."No.");
            // DocumentShippingCost.SETRANGE("Sub Type", PurchaseHeader."Document Type");
            // if DocumentShippingCost.findset then
            //     repeat
            //         DocShippingAmount += DocumentShippingCost."Unit Cost";
            //     until DocumentShippingCost.NEXT = 0;
            //BC Upgrade SHARMP16--Drink-IT code end<<
            //HEI.82<<
            PurchaseHeader.CALCFIELDS("Amount Including VAT");
            //HEI.82>>
            //lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT";
            lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT" + DocShippingAmount;  //BC Upgrade SHARMP16--Interface Code
                                                                                                  //HEI.82<<
                                                                                                  //lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT";//HEI.92
                                                                                                  //BC Upgrade SHARMP16--Interface Code begin<<
            lrec_IbecorData."Currency Code" := PurchaseHeader."Currency Code";
            lrec_IbecorData.Approver := PurchaseHeader."Last Changed User ID IBM FND";
            lrec_IbecorData.Requestor := PurchaseHeader."Requester ID IBM FND";
            lrec_IbecorData."Posting Date" := PurchaseHeader."Posting Date";  //HEI.132
            lrec_IbecorData."Document Date" := PurchaseHeader."Document Date";  //HEI.132
            lrec_IbecorData."Delivery Date" := PurchaseHeader."Expected Receipt Date";
            PFILine.RESET;
            PFILine.SETRANGE("PO Number", PurchaseHeader."No.");
            if PFILine.FINDFIRST then begin
                if PFIHeader.GET(PFILine."PFI Document No.") then begin
                    lrec_IbecorData."Ibecor Dossier No" := PFIHeader."IBECOR Dossier No.";
                    lrec_IbecorData."Logistics Officer" := PFIHeader."Logistics Officer";

                end;
            end;
            if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then begin
                lrec_IbecorData."Ibecor Doc No." := PurchaseHdrAdditional."PFI Document No. INT";
                lrec_IbecorData."Credit Info Required" := PurchaseHdrAdditional."Credit Info Required INT";  //HEI.122
                lrec_IbecorData."Credit Number" := PurchaseHdrAdditional."Credit Number INT";
                lrec_IbecorData."Credit amount Of Supplier" := PurchaseHdrAdditional."Credit Amount Of supplier INT";
                lrec_IbecorData."Bank Of Organism Supplier" := PurchaseHdrAdditional."Bank Who Issued Credit INT";
                lrec_IbecorData."Last Date Of Shipment" := PurchaseHdrAdditional."Last Date Of Shipment INT";
                lrec_IbecorData."Credit Validity Of Supplier" := PurchaseHdrAdditional."Credit Validity Date INT";
                //HEI.111 >>
                lrec_IbecorData."License Required" := PurchaseHdrAdditional."License Required INT";  //HEI.122
                lrec_IbecorData."License Expiration Date" := PurchaseHdrAdditional."License Expiration Date";
                lrec_IbecorData."Bank Of Organism License" := PurchaseHdrAdditional."Bank who issued the License";
                lrec_IbecorData."Bank Reference Number" := PurchaseHdrAdditional."Bank Reference Number";
                lrec_IbecorData."CoD/CoC Number" := PurchaseHdrAdditional."CoD/CoC Number";
                //HEI.111 <<
            end;
            if (PurchaseHdrAdditional."PFI Document No. INT" <> '') then begin
                PFIApproval.RESET;
                PFIApproval.SETRANGE(PFIApproval."PFI document No.", PurchaseHdrAdditional."PFI Document No. INT");
                if PFIApproval.FINDLAST then begin
                    lrec_IbecorData."Comment with Date" := PFIApproval.Comments;
                end;
            end;

            PurchaseHeader.CALCFIELDS("License Code FND");
            if (PurchaseHeader."License Code FND" <> '') then begin
                //HEI.136>>
                //lrec_IbecorData."Licence Number" := PurchaseHeader."License Code";
                lrec_IbecorData."Licence Number" := PurchaseHdrAdditional."License Name"; //BC Upgrade SHARMP16--Interface Code 
                lrecGeneralLedgerSetup.GET;
                //HEI.111 >>
                //IF lrecDimensionValue.GET(lrecGeneralLedgerSetup."License Dimension Code",PurchaseHeader."License Code") THEN BEGIN
                //  lrec_IbecorData."License Expiration Date" := lrecDimensionValue."License Expiration Date";
                //  lrec_IbecorData."Bank Of Organism License" := lrecDimensionValue."Bank who issued the License";
                //end;
                //HEI.111 >>
            end;
            lrec_IbecorData."Movement Status" := lrec_IbecorData."Movement Status"::"Ready to Send";
            lrec_IbecorData.INSERT(true);
            TriggerAPINotification(lrec_IbecorData);
        end else begin
            if CompareIbecorStagedData(lrec_IbecorData, PurchaseHeader) then begin
                lrec_IbecorData."Posting Date" := PurchaseHeader."Posting Date";
                lrec_IbecorData."Document Date" := PurchaseHeader."Document Date";
                lrec_IbecorData."Delivery Date" := PurchaseHeader."Expected Receipt Date";
                lrec_IbecorData."External Doc No" := PurchaseHeader."Your Reference";
                PurchaseHeader.CALCFIELDS("License Code FND");
                //HEI.136>>
                //lrec_IbecorData."Licence Number" := PurchaseHeader."License Code";
                lrec_IbecorData."Licence Number" := PurchaseHdrAdditional."License Name";

                //HEI.136<<
                //HEI.82>>
                DocShippingAmount := 0;
                //BC Upgrade SHARMP16 -- Drink-IT 
                // DocumentShippingCost.RESET;
                // DocumentShippingCost.SETRANGE("Source Type", DATABASE::"Purchase Header");
                // DocumentShippingCost.SETRANGE("Source No.", PurchaseHeader."No.");
                // DocumentShippingCost.SETRANGE("Sub Type", PurchaseHeader."Document Type");
                // if DocumentShippingCost.findset then
                //     repeat
                //         DocShippingAmount += DocumentShippingCost."Unit Cost";
                //     until DocumentShippingCost.NEXT = 0;
                //BC Upgrade SHARMP16 -- Drink-IT 
                //HEI.82<<
                PurchaseHeader.CALCFIELDS("Amount Including VAT");
                //HEI.92>>
                //lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT";
                lrec_IbecorData.Amount := PurchaseHeader."Amount Including VAT" + DocShippingAmount;
                //HEI.92<<

                //HEI.128>>
                if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
                    if (PurchaseHdrAdditional."PFI Document No. INT" <> '') then begin
                        if PFIHeader.GET(PurchaseHdrAdditional."PFI Document No. INT") then begin
                            if lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor", PurchaseHeader."Location Code", PFIHeader."Brewery ID") then
                                lrec_IbecorData."Opco Code" := lrec_InterfaceLocationMatrix."IBC Location Code";
                        end;
                    end;
                end;
                //IF lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor",PurchaseHeader."Location Code") THEN
                //  lrec_IbecorData."Opco Code" := lrec_InterfaceLocationMatrix."IBC Location Code";
                //HEI.128<<
                lrec_IbecorData."Bill to Customer GID" := lrec_CompInfo."Legal Entity Code FND";
                //HEI.111 >>
                //IF lrecDimensionValue.GET(lrecGeneralLedgerSetup."License Dimension Code",PurchaseHeader."License Code") THEN BEGIN
                //  lrec_IbecorData."License Expiration Date" := lrecDimensionValue."License Expiration Date";
                //  lrec_IbecorData."Bank Of Organism License" := lrecDimensionValue."Bank who issued the License";
                //end;
                //HEI.111 <<
                if PurchaseHdrAdditional.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then begin
                    lrec_IbecorData."Credit Info Required" := PurchaseHdrAdditional."Credit Info Required INT";  //HEI.122
                    lrec_IbecorData."Credit Number" := PurchaseHdrAdditional."Credit Number INT";
                    lrec_IbecorData."Credit amount Of Supplier" := PurchaseHdrAdditional."Credit Amount Of supplier INT";
                    lrec_IbecorData."Bank Of Organism Supplier" := PurchaseHdrAdditional."Bank Who Issued Credit INT";
                    lrec_IbecorData."Last Date Of Shipment" := PurchaseHdrAdditional."Last Date Of Shipment INT";
                    lrec_IbecorData."Credit Validity Of Supplier" := PurchaseHdrAdditional."Credit Validity Date INT";
                    //HEI.111 >>
                    lrec_IbecorData."License Required" := PurchaseHdrAdditional."License Required INT";  //HEI.122
                    lrec_IbecorData."License Expiration Date" := PurchaseHdrAdditional."License Expiration Date";
                    lrec_IbecorData."Bank Of Organism License" := PurchaseHdrAdditional."Bank who issued the License";
                    lrec_IbecorData."Bank Reference Number" := PurchaseHdrAdditional."Bank Reference Number";
                    lrec_IbecorData."CoD/CoC Number" := PurchaseHdrAdditional."CoD/CoC Number";
                    //HEI.111 <<
                end;
                lrec_IbecorData."Movement Status" := lrec_IbecorData."Movement Status"::"Ready to Send";
                lrec_IbecorData.MODIFY;
                TriggerAPINotification(lrec_IbecorData);
            end;
        end
    end;

    local procedure CompareIbecorStagedData(prec_IbecorData: Record "Ibecor PO Staging Data INT"; prec_PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        lrecDimensionValue: Record "Dimension Value";
        StoreLicExpDate: Date;
        StoreBankIssueLic: Text[50];
        lrecGeneralLedgerSetup: Record "General Ledger Setup";
        PurchaseHdrAdditional: Record "Purchase Header Additional FND";
        StoreCreditNumber: Code[20];
        StoreCreditAmount: Decimal;
        StoreBankSupplier: Text[50];
        StoreLastDOShipment: Date;
        StoreCreditValidityDate: Date;
        StoreOpcoCode: Code[20];
        lrec_InterfaceLocationMatrix: Record "Interface Location Matrix FND";
        IbecorInterfaceSetup: Record "Ibecor Interface Setup INT";
        // DocumentShippingCost: Record "Document Shipping Cost";
        DocShippingAmount: Decimal;
        AmounttoCompare: Decimal;
        PurchHeaderRecpt: Record "Purch. Rcpt. Header";
    begin
        //     //HEI.63>>
        //     /*//HEI.150>>
        //     prec_PurchaseHeader.CALCFIELDS("License Code");
        //     prec_PurchaseHeader.CALCFIELDS("Amount Including VAT");
        //     //HEI.82>>
        //     DocShippingAmount := 0;
        //     DocumentShippingCost.RESET;
        //     DocumentShippingCost.SETRANGE("Source Type",DATABASE::"Purchase Header");
        //     DocumentShippingCost.SETRANGE("Source No.",prec_PurchaseHeader."No.");
        //     DocumentShippingCost.SETRANGE("Sub Type",prec_PurchaseHeader."Document Type");
        //     IF DocumentShippingCost.findset THEN REPEAT
        //       DocShippingAmount += DocumentShippingCost."Unit Cost";
        //     UNTIL DocumentShippingCost.NEXT = 0;
        //     AmounttoCompare := prec_PurchaseHeader."Amount Including VAT" + DocShippingAmount;
        //     //HEI.82<<
        //     lrecGeneralLedgerSetup.GET;
        //     IbecorInterfaceSetup.GET;
        //     IF lrecDimensionValue.GET(lrecGeneralLedgerSetup."License Dimension Code",prec_PurchaseHeader."License Code") THEN BEGIN
        //       StoreLicExpDate := lrecDimensionValue."License Expiration Date";
        //       StoreBankIssueLic := lrecDimensionValue."Bank who issued the License";
        //     end;
        //     IF PurchaseHdrAdditional.GET(prec_PurchaseHeader."Document Type"::Order,prec_PurchaseHeader."No.") THEN BEGIN
        //       StoreCreditNumber := PurchaseHdrAdditional."Credit Number";
        //       StoreCreditAmount := PurchaseHdrAdditional."Credit Amount Of supplier";
        //       StoreBankSupplier := PurchaseHdrAdditional."Bank Who Issued Credit";
        //       StoreLastDOShipment := PurchaseHdrAdditional."Last Date Of Shipment";
        //       StoreCreditValidityDate := PurchaseHdrAdditional."Credit Validity Date";
        //     end;
        //     //IF lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor",prec_PurchaseHeader."Location Code") THEN  //HEI.128
        //     IF lrec_InterfaceLocationMatrix.GET(IbecorInterfaceSetup."IBECOR Vendor",prec_PurchaseHeader."Location Code",prec_IbecorData."Opco Code") THEN  //HEI.128
        //       StoreOpcoCode := lrec_InterfaceLocationMatrix."IBC Location Code";

        //     //HEI.144>>
        //       PurchHeaderRecpt.RESET;
        //       PurchHeaderRecpt.SETCURRENTKEY("Order No.");
        //       PurchHeaderRecpt.SETRANGE("Order No.",PurchaseHdrAdditional."No.");
        //       IF PurchHeaderRecpt.ISEMPTY THEN
        //         IF prec_IbecorData.Amount <> AmounttoCompare THEN
        //            EXIT(TRUE);
        //     //HEI.144<<

        //     CASE TRUE OF
        //       //HEI.82>>
        //       //prec_IbecorData.Amount <> prec_PurchaseHeader."Amount Including VAT" : EXIT(TRUE);
        //       //prec_IbecorData.Amount <> AmounttoCompare : EXIT(TRUE); //HEI.144
        //       //HEI.82<<
        //       //prec_IbecorData."Posting Date" <> prec_PurchaseHeader."Posting Date" : EXIT(TRUE);  //HEI.132
        //       //prec_IbecorData."Document Date" <> prec_PurchaseHeader."Document Date" : EXIT(TRUE);  //HEI.132
        //       //prec_IbecorData."Delivery Date" <> prec_PurchaseHeader."Expected Receipt Date" : EXIT(TRUE);  //HEI.132
        //       //(prec_IbecorData."Posting Date" <> 0D) AND (prec_IbecorData."Posting Date" <> prec_PurchaseHeader."Posting Date") : EXIT(TRUE);  //HEI.132 //HEI.136
        //       (prec_IbecorData."Document Date" <> 0D) AND (prec_IbecorData."Document Date" <> prec_PurchaseHeader."Document Date") : EXIT(TRUE);  //HEI.132
        //       //(prec_IbecorData."Delivery Date" <> 0D) AND (prec_IbecorData."Delivery Date" <> prec_PurchaseHeader."Expected Receipt Date") : EXIT(TRUE);  //HEI.132 //HEI.136
        //       prec_IbecorData."External Doc No" <> prec_PurchaseHeader."Your Reference" : EXIT(TRUE);
        //       //HEI.136>>
        //       //prec_IbecorData."Licence Number" <> prec_PurchaseHeader."License Code" : EXIT(TRUE);
        //       prec_IbecorData."Licence Number" <> PurchaseHdrAdditional."License Name" : EXIT(TRUE);
        //       //HEI.136<<
        //       prec_IbecorData."License Expiration Date"<> StoreLicExpDate : EXIT(TRUE);
        //       prec_IbecorData."Bank Of Organism License" <> StoreBankIssueLic : EXIT(TRUE);
        //       //prec_IbecorData."Credit Number" <> StoreCreditNumber : EXIT(TRUE);  //HEI.131
        //       //prec_IbecorData."Credit amount Of Supplier" <> StoreCreditAmount : EXIT(TRUE);  //HEI.131
        //       //prec_IbecorData."Bank Of Organism Supplier" <> StoreBankSupplier : EXIT(TRUE);  //HEI.131
        //       //prec_IbecorData."Last Date Of Shipment" <> StoreLastDOShipment : EXIT(TRUE);  //HEI.131
        //       //prec_IbecorData."Credit Validity Of Supplier" <> StoreCreditValidityDate : EXIT(TRUE);  //HEI.131
        //       (prec_IbecorData."Credit Number" <> StoreCreditNumber) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
        //       (prec_IbecorData."Credit amount Of Supplier" <> StoreCreditAmount) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
        //       (prec_IbecorData."Bank Of Organism Supplier" <> StoreBankSupplier) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
        //       (prec_IbecorData."Last Date Of Shipment" <> StoreLastDOShipment) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
        //       (prec_IbecorData."Credit Validity Of Supplier" <> StoreCreditValidityDate) AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
        //       //prec_IbecorData."Opco Code" <> StoreOpcoCode : EXIT(TRUE);  //HEI.130
        //       //HEI.111 >>
        //       //prec_IbecorData."Bank Reference Number" <> PurchaseHdrAdditional."Bank Reference Number" : EXIT(TRUE);  //HEI.131
        //       (prec_IbecorData."Bank Reference Number" <> PurchaseHdrAdditional."Bank Reference Number") AND (PurchaseHdrAdditional."Credit Info Required") : EXIT(TRUE);  //HEI.131
        //       prec_IbecorData."CoD/CoC Number" <> PurchaseHdrAdditional."CoD/CoC Number" : EXIT(TRUE);
        //       //HEI.111 <<
        //     end;
        //     */
        if PurchaseHdrAdditional.GET(prec_PurchaseHeader."Document Type"::Order, prec_PurchaseHeader."No.") then begin
            // CASE TRUE OF //HEI.151
            //HEI.153>>
            if PurchaseHdrAdditional."Credit Info Required INT" = true then begin
                //CASE PurchaseHdrAdditional."Credit Info Required" OF //HEI.151
                case true of
                    //HEI.153<<
                    prec_IbecorData."Credit Info Required" <> PurchaseHdrAdditional."Credit Info Required INT":
                        exit(true);
                    prec_IbecorData."Credit Number" <> PurchaseHdrAdditional."Credit Number INT":
                        exit(true);
                    prec_IbecorData."Credit amount Of Supplier" <> PurchaseHdrAdditional."Credit Amount Of supplier INT":
                        exit(true);
                    prec_IbecorData."Bank Of Organism Supplier" <> PurchaseHdrAdditional."Bank Who Issued Credit INT":
                        exit(true);
                    prec_IbecorData."Last Date Of Shipment" <> PurchaseHdrAdditional."Last Date Of Shipment INT":
                        exit(true);
                    prec_IbecorData."Credit Validity Of Supplier" <> PurchaseHdrAdditional."Credit Validity Date INT":
                        exit(true);
                    prec_IbecorData."Bank Reference Number" <> PurchaseHdrAdditional."Bank Reference Number":
                        exit(true); //HEI.151
                end; //HEI.151
            end; //HEI.153
            case true of //HEI.151
                prec_IbecorData."License Required" <> PurchaseHdrAdditional."License Required INT":
                    exit(true);
                prec_IbecorData."Licence Number" <> PurchaseHdrAdditional."License Name":
                    exit(true);
                prec_IbecorData."License Expiration Date" <> PurchaseHdrAdditional."License Expiration Date":
                    exit(true);
                prec_IbecorData."Bank Of Organism License" <> PurchaseHdrAdditional."Bank who issued the License":
                    exit(true);
                //prec_IbecorData."Bank Reference Number" <> PurchaseHdrAdditional."Bank Reference Number": EXIT(TRUE);
                prec_IbecorData."CoD/CoC Number" <> PurchaseHdrAdditional."CoD/CoC Number":
                    exit(true);
            end;
        end;
        exit(false);
        //HEI.150<<
        //     //HEI.63<<

    end;

    local procedure TriggerAPINotification(prec_IbecorStagedData: Record "Ibecor PO Staging Data INT");
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        IbecorIntrfcSetup: Record "Ibecor Interface Setup INT";
        CompanyInformation: Record "Company Information";
        InterfaceLocationMatrix: Record "Interface Location Matrix FND";
        lrecPurchHdr: Record "Purchase Header";
        lrecVend: Record Vendor;
        InterLogHeader: Record "Interface Log Header INT";
    begin
        //HEI.63>>
        CompanyInformation.GET;
        if not IbecorIntrfcSetup.GET then
            exit;
        InterfaceSetup.GET(IbecorIntrfcSetup."IBECOR API PO Notification");
        if not InterfaceSetup.Enabled then
            exit;

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := IbecorIntrfcSetup."IBECOR API PO Notification";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."Source No." := prec_IbecorStagedData."Document No";
        //HEI.82>>
        if lrecPurchHdr.GET(lrecPurchHdr."Document Type"::Order, prec_IbecorStagedData."Document No") then
            if lrecVend.GET(lrecPurchHdr."Buy-from Vendor No.") then
                //IF InterfaceLocationMatrix.GET(lrecVend."Global Vendor Number",lrecPurchHdr."Location Code") THEN BEGIN  //HEI.128
                if InterfaceLocationMatrix.GET(lrecVend."Global Vendor Number FND", lrecPurchHdr."Location Code", prec_IbecorStagedData."Opco Code") then begin  //HEI.128
                    InterfaceEntryHeaderOut."Sell-to Customer No." := InterfaceLocationMatrix."Heilite Location Code";
                    InterfaceEntryHeaderOut."Pay-to Vendor No." := InterfaceLocationMatrix."IBC Location Code";
                end;
        //HEI.82<<
        InterfaceEntryHeaderOut."External Document No." := 'IBECOR';
        InterfaceEntryHeaderOut."Posting Date" := WORKDATE;
        //HEI.112 >>
        InterfaceEntryHeaderOut."Action Code" := '01';
        InterLogHeader.SETRANGE("Interface Code", IbecorIntrfcSetup."IBECOR API PO Notification");
        InterLogHeader.SETRANGE(Direction, InterfaceEntryHeaderOut.Direction::Outbound);
        InterLogHeader.SETRANGE("Legal Entity", CompanyInformation."Legal Entity Code FND");
        InterLogHeader.SETRANGE("Source No.", prec_IbecorStagedData."Document No");
        if not InterLogHeader.ISEMPTY then
            InterfaceEntryHeaderOut."Action Code" := '02';
        //HEI.112 <<
        InterfaceEntryHeaderOut.INSERT(true);
        //HEI.63<<
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterDeleteEvent', '', false, false)]
    local procedure T38OnDeletePurchHeader(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        PurchaseHeaderAddtnl: Record "Purchase Header Additional FND";
        PFILine: Record "PFI Lines FND";
    begin
        //HEI.63>>
        if Rec.ISTEMPORARY then
            exit;
        if (Rec."Document Type" <> Rec."Document Type"::Order) then
            exit;
        if PurchaseHeaderAddtnl.GET(Rec."Document Type", Rec."Document No.") then begin
            if (PurchaseHeaderAddtnl."PFI Document No. INT" <> '') then begin
                PFILine.RESET;
                PFILine.SETRANGE("PFI Document No.", PurchaseHeaderAddtnl."PFI Document No. INT");
                PFILine.SETRANGE("PO Number", Rec."Document No.");
                if PFILine.findset then
                    PFILine.MODIFYALL("PO Number", '');
                PurchaseHeaderAddtnl."PFI Document No. INT" := '';
                PurchaseHeaderAddtnl.MODIFY;
            end else
                exit;
        end;
        //HEI.63<<
    end;
    //BC UPGRADE ATHUKS01<<

}

