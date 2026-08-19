codeunit 58024 "Zycus Interface Management"
{
    // Heilite Navision Old Id - 50208

    // version HEI.10,HEI.01,HEI.03

    // HEI.01 CHG2210794 SAHAL01 08.11.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Codeunit: 50208 - Zycus Interface Management
    //   # Created New Functions - GetCompanyInformation_Zycus
    //                           - GetGeneralInterfaceSetup_Zycus
    //                           - GetZycusInterfaceSetup_Zycus
    //                           - ValidateInterfaceSetup_Zycus
    //                           - GetLocalCurrentDateTime_Zycus
    //                           - OnAfterCCCDimCreateOrUpdate_Zycus
    //                           - OutboundCCCDimCreateOrUpdate_Zycus
    //                           - OnAfterWBNDimCreateOrUpdate_Zycus
    //                           - OutboundWBNDimCreateOrUpdate_Zycus
    //                           - OnAfterInterfaceErrorUpdate_Zycus
    //   # Removed Fixed Assets (CONCAT) Interface functionality due to descope
    //   # Added Code to incorporate the logic for sending Dimension Value Code with accepted Special Character in WBN Interface.
    // HEI.02 CHG2210794 MAJUMS03 22.01.2024 Zycus - BASE HL Integration Master Vendor and GL Account. (*RLPPD)
    //   # Created New Functions - OutboundVendorCreateOrUpdate_Zycus
    //                           - OutboundAccountCreateOrUpdate_Zycus
    //                           - OnAfterVendorCreateOrUpdate_Zycus
    //                           - OnAfterGLCreateOrUpdate_Zycus
    //                           - CheckForValidGLAcc
    //                           - CreationOfValidGLAcc
    //                           - CreationOfValidVendor
    //                           - InitializeZycusGLMastTimestamp
    //                           - InitializeZycusVendMastTimestamp
    // HEI.03 CHG2210794 SAHAL01 08.11.2024 Zycus - BASE HL Integration with Transaction PO
    //   # Created New Functions - InboundProcessPurchaseOrder_Zycus
    //                           - ValidatePurchaseOrderHeader_Zycus
    //                           - ValidatePurchaseOrderLine_Zycus
    //                           - GetPurchaseSetup_Zycus
    //                           - GetGLSetup_Zycus
    //                           - GetUserID_Zycus
    //                           - GetISOCodeUnitOfMeasure_Zycus
    //                           - IsPurchaseReceiptExist_Zycus
    //                           - CheckAdditionalLines_Zycus
    //                           - FindLinesUnitCost_Zycus
    //                           - UpdateLastOpenLine_Zycus
    //                           - CheckAndCreateDimensionsAndComponentDimensions_Zycus
    //                           - CheckDimValueOnPOCreation_Zycus
    //                           - CheckMandatoryFieldsOnPOCreation_Zycus
    //                           - CreatePurchaseOrderForGLorFA_Zycus
    //                           - DeletePurchaseOrderHeader_Zycus
    //                           - DeletePurchaseOrderLine_Zycus
    //                           - GetPurchaseReturnQuantity_Zycus
    //                           - ValidateReleasedPurchaseOrder_Zycus
    //                           - OutboundPurchaseOrderConfirmation_Zycus
    // HEI.04 CHG2210794 MAJUMS03 21.03.2024 Zycus - BASE HL Integration Master Vendor and GL Account.
    //   # Code added to update "Last Interface Run Time Vendor" and "Last Interface Run Time GL Acc" Zycus Interface Setup. Code  modified.
    // HEI.05 CHG2210794 SAHAL01 25.10.2024 Zycus - BASE HL Integration with Transaction GR
    //   # Created New Functions - InboundProcessGoodsReceiptOfPurchaseOrder_Zycus
    //                           - OutboundGoodsReceiptOfPurchaseOrderConfirmation_Zycus
    //                           - InboundProcessGoodsReceiptCancellationOfPurchaseOrder_Zycus
    //                           - OutboundGoodsReceiptCancellationOfPurchaseOrderConfirmation_Zycus
    //                           - InboundProcessGoodsReceiptOfLimitPurchaseOrder_Zycus
    //                           - OutboundGoodsReceiptOfLimitPurchaseOrderConfirmation_Zycus
    //                           - InboundProcessGoodsReceiptCancellationOfLimitPurchaseOrder_Zycus
    //                           - OutboundGoodsReceiptCancellationOfLimitPurchaseOrderConfirmation_Zycus
    //                           - CreateLimitPOLine_Zycus
    //                           - UpdateOriginalLineOnUndo_Zycus
    //                           - IncreaseOriginalLineRemAmt_Zycus
    //                           - UpdateLastOpenLineOnUndo_Zycus
    //                           - CreateAdditionalLine_Zycus
    //                           - DeleteEmptyPurchaseReturnOrder_Zycus
    //                           - CheckAdditionalLinesUndo_Zycus
    // HEI.06 CHG2210794 MAJUMS03 13.05.2024 Zycus - BASE HL Integration - Vendor GL Account Development Rework.
    //   # Code added.
    // HEI.07 CHG2210794 MAJUMS03 16.05.2024 Zycus - BASE HL Integration - Vendor development finetuning
    //   # Code added.
    // HEI.08 CHG2210794 VERMAA03 14.06.2024 Zycus -BASE integration with POSM GR
    //   # Created New Functions - CreateOutboundPOSMGR_Zycus
    //                           - CreateOutboundLinesPOSMGR_Zycus
    //                           - InboundPOSMGRConfirmation_Zycus
    //                           - CreateOutboundPOSMGRCancellation_Zycus
    //                           - CreateOutboundLinesPOSMGRCancellation_Zycus
    // HEI.09 CHG2210794 MAJUMS03 04.09.2024 Zycus - BASE HL Integration - CMG Rule Map.
    //   # Created New Functions - OutboundGLRuleMapCreateOrUpdate_Zycus
    //                           - OnAfterGLRuleMapCreateOrUpdate_Zycus
    //                           - CheckForValidGLRuleMap
    //                           - CreationOfValidGLRuleMap
    //                           - CreationOfGLRuleMap
    //                           - GetGLAccountRange
    //                           - CreationOfGLRuleMapCCC
    //                           - UpdateGLRuleMapPurchType
    // HEI.10 CHG2210794 MAJUMS03 04.09.2024 Zycus - BASE HL Integration - CMG Rule Map.
    //   # Code added. Only Blocaked = FALSE Filter added for Dimensions.
    //BC Upgrade GUNREM01 - Uncommented the code as blocked temporarly

    // HEI.11 CHG2278614 SAHAL01 04.12.2024 E2E test for Zycus HL integration
    // # Added Code
    // HEI.12 CHG2278614  SHARMP16 09.12.2024 E2E test for Zycus HL integration -GL Rule Map-Development finetuning
    //   #Create new Function -UpdateGLRuleMapAccountType
    //   #Code Added OutboundGLRuleMapCreateOrUpdate_Zycus
    //   #Code Added CreationOfGLRuleMap
    // HEI.13 CHG2278614 SHARMP16 15.01.2025 E2E test for Zycus HL integration - G/L Rule map- Development
    //   #Code Added CreationOfGLRuleMap -If any G./L Account filtered through CTP code, but not having any EBF Matrix exist,
    //   #those G/L accounts should come in the table with all CCC combinations and type should be Allowed.
    // HEI.15 CHG2278614 SHARMP16 28.02.2025 E2E test for Zycus HL integration - G/L Rule map- Development
    //   #Code Added CreationOfGLRuleMap -If any G./L Account filtered through CTP code, with blank dimension should not exsist.
    // HEI.16 CHG2278614 SHARMP16 06.03.2025 E2E test for Zycus HL integration - G/L Rule map- Development finetuning
    //   #Code Added CreationOfGLRuleMap - Add filters for G/L Account.
    //   #Code Commented OutboundGLRuleMapCreateOrUpdate_Zycus.-Code commented because this interface is now out of scope.
    // HEI.17 CHG2278614 SHARMP16 07.03.2025 E2E test for Zycus HL integration - G/L Rule map- Development finetuning
    //   #Code Commented OutboundGLRuleMapCreateOrUpdate_Zycus - Code commented because this interface is now out of scope.
    //   #Code Commented OnAfterGLRuleMapCreateOrUpdate_Zycus.
    // HEI.20 CHG2278614 SHARMP16 21.03.2025 E2E test for Zycus HL integration - G/L Rule map- Development finetuning
    //   # Added Progress Window
    // HEI.23 CHG2300013 SHARMP16 22.04.2025 - CC Corrective change for GL rule map - Development
    //   #Added new condition in CreationOfGLRuleMap -to exclude dimensions including *
    // HEI.25 CHG2300013 SHARMP16 02.05.2025 CC Corrective change for GL rule map - Development
    //   #Rolled back HEI.23 changes: Blank G/L Accounts are descoped from Quality.
    //   #Previous logic evaluated all Default Dimensions. Now, only CCC dimension is considered.
    //   #New logic: If G/L Account has only CCC as mandatory dimension, set PurchType to CCC; else WBS.
    // HEI.29 CHG2313281 SAHAL01 25.07.2025 Zycus - CMG Dimension Check
    //   # Added Code
    // HEI.30 CHG2324506 SAHAL01 10.10.2025 Cost center not showing on PO line in Heilite
    // # Added Code

    // BC Upgrade MISHRS14 >>
    // No change required in tag - #HEI.15, #HEI.17, #HEI.23
    // # Tag HEI.11 Added to Documentation, Changes in Procudure - ( ValidatePurchaseOrderHeader_Zycus, ValidatePurchaseOrderLine_Zycus, CheckAndCreateDimensionsAndComponentDimensions_Zycus,ValidateReleasedPurchaseOrder_Zycus, InboundProcessGoodsReceiptOfPurchaseOrder_Zycus )
    // # Tag HEI.12 Added to Documentation, Created Procudure - UpdateGLRuleMapAccountType and change in Procedure - CreationOfGLRuleMap
    // # Tag HEI.13 Added to Documentation, Changes in Procedure - CreationOfGLRuleMap
    // # Tag HEI.16 Added to Documentation, Changes in Procedure - CreationOfGLRuleMap
    // # Tag HEI.20 Added to Documentation, Changes in Procedure - CreationOfGLRuleMap
    // # Tag HEI.25 Added to Documentation, Changes in Procedure - UpdateGLRuleMapPurchType
    // # Tag HEI.29 Added to Documentation, Changes in Procedure - CheckAndCreateDimensionsAndComponentDimensions_Zycus
    // # Tag HEI.30 Added to Documentation, Changes in Procedure - CreateLimitPOLine_Zycus and ValidatePurchaseOrderLine_Zycus
    // BC Upgrade MISHRS14 <<

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Zycus GL Rule Map FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    Permissions = TableData "Purch. Rcpt. Header" = rm,
                  TableData "Purch. Rcpt. Line" = rm;

    trigger OnRun();
    begin
    end;

    var
        CompanyInformation: Record "Company Information";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        CompanyInformationRead: Boolean;
        GeneralInterfaceSetupRead: Boolean;
        ZycusInterfaceSetupRead: Boolean;
        Text000: Label 'Interface ''%1'' is not enabled.';
        Text001: Label 'Park';
        Text002: Label 'Error';
        Text003: Label 'Success';
        TempGLAccRec: Record "G/L Account" temporary;
        TempGLAccRec1: Record "G/L Account" temporary;
        TempVendRec: Record Vendor temporary;
        TempVendRec1: Record Vendor temporary;
        PurchPaySetup: Record "Purchases & Payables Setup";
        PurchSetupRead: Boolean;
        Text004: Label 'HEIWAY\%1';
        GLSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;
        Text005: Label '%1 %2 cannot be %3 for Zycus Purchase Order.';
        Text006: TextConst ENU = 'The %1 combination %2 and %3 does not exist for %4 %5.', FRA = 'La %1 combinaison %2 %3 n''existe pas pour %4 %5.';
        Text009: TextConst Comment = '%1 = Document Type, %2 = Document No, %3 = LineNo., %4 = Error text', ENU = 'The dimensions used in %1 %2, Line no.%3 are invalid (Error: %4).', FRA = 'Les axes analytiques utilisés dans %1 %2, ligne n° %3, ne sont pas valides (erreur : %4).';
        Text010: Label 'PO No. %1 has been successfully processed.';
        Text011: Label '%1 cannot be blank in the XML file.';
        Text012: Label 'Dimensions Value should be same for all the purchase lines.';
        Text013: Label '%1 of this %2 %3 %4 is missing in %5. It is having some restricted special character for Zycus.';
        Text014: Label 'PO';
        Text015: Label '%1 %2 is not in the %3.';
        Text016: Label '%1 cannot be created for Type %2.';
        Text017: Label '%1 %2 should not be lesser than the %3 %4 for PO No. %5 Line No. %6.';
        Text018: Label 'Location Code must be %1 instead of %2 for this Purchase %3, Document No. %4, Line No. %5 in Purchase Line. The same value already defined for Import PO in %6.';
        Text019: Label 'Location Code must be Physical Delivery Location instead of %1 for this Purchase %2, Document No. %3 in Purchase Header. The same value already defined for Import PO in %4.';
        Text020: Label 'POTypeCode';
        Text021: Label 'POLineTypeCode';
        FoundInConcat: Boolean;
        Text022: Label 'ZycusPOLineNo';
        Text023: Label '%1 ''%2'' cannot be duplicate. It must be unique and sequential number in the XML file.';
        Text024: Label 'PO No. %1 already exists, please send the %2 other than %3 in the XML file Header.';
        Text025: Label 'Blank';
        Text026: Label 'The Dimension Value %1 of Dimension Code %2 is not existing in %3 setup for this Line No. %4, Type %5 and No. %6.';
        Text027: Label 'The Dimension Value %1 of Dimension Code %2 is not matching with Default Dimension Value %3 in Default Dimension Table ID %4 and No. %5.';
        Text028: Label 'The Dimension Value %1 of Dimension Code %2 is not matching with Default Dimension Value %3 in Default Dimension Table ID %4 and No. %5 for this Dimension %6 and Dimension Value %7.';
        Text029: Label '%1 cannot be created with %2 in same Purchase %3 %4.';
        Text030: Label 'You cannot receive more than %1 %2.';
        Text031: Label 'GR of Direct Items is not allowed from Zycus and can be posted only this PO No. %1 from HeiLite.';
        Text032: Label 'GR is not allowed to post, because %1 as %2 for this PO No. %3 and Line No. %4 in HeiLite.';
        Text033: Label 'GR No. %1 has been successfully processed.';
        Text034: Label '%1 %2 is not matching with UoM Code %3 in respect of ISO UoM %4 from XML file.';
        Text035: Label 'There is no Return Shipment Line with having Quantity.';
        Text036: TextConst ENU = 'This Receipt %1 against Zycus Line No. %2 has already been invoiced. Undo Receipt can be applied only to posted, but not invoiced receipt.', FRA = 'Cette réception a déjà été facturée. Vous ne pouvez appliquer l''option Annuler réception qu''aux réceptions enregistrées mais non facturées.';
        Text037: Label '%1 cannot be blank while sending the %2 confirmation message for this Interface %3.';
        Text038: Label 'Header Entry No.';
        Text039: Label 'Purchase Order No.';
        Text040: Label 'Goods Receipt No.';
        Text041: Label 'Document No.';
        Text042: Label 'Goods Receipt Cancel';
        Text043: Label 'Goods Receipt of Limit PO';
        Text044: Label 'Goods Receipt of Limit PO Cancel';
        GLAccountOperator: Label '*';
        TempCMGMappingRec: Record "CMG Mapping FND" temporary;
        GLAccountRange: Code[10];
        TempZycusGLRuleMap: Record "Zycus GL Rule Map FND" temporary;
        PurchType: Option CCC,WBS;
        Text045: Label 'Zycus GR UUID';

        // BC Upgrade MISHRS14 >>
        AccountType: Option Income,Balance;
        Window: Dialog;
        Text058: Label 'Generating For GL: #1#####\CMG-CCC #2#####';
        Text046: Label 'Zycus CMG must have a value in file.';
    // BC Upgrade MISHRS14 <<

    local procedure GetCompanyInformation_Zycus();
    begin
        //HEI.01>>
        if not CompanyInformationRead then begin
            CompanyInformation.GET();
            CompanyInformationRead := true;
        end;
        //HEI.01<<
    end;

    local procedure GetGeneralInterfaceSetup_Zycus();
    begin
        //HEI.01>>
        if not GeneralInterfaceSetupRead then begin
            GeneralInterfaceSetup.GET();
            GeneralInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure GetZycusInterfaceSetup_Zycus();
    begin
        //HEI.01>>
        if not ZycusInterfaceSetupRead then begin
            if ZycusInterfaceSetup.GET() and ZycusInterfaceSetup."Enabled Zycus Integration" then
                ZycusInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;

    local procedure ValidateInterfaceSetup_Zycus(InterfaceCode: Code[20]);
    var
        InterfaceSetupL: Record "Interface Setup INT";
    begin
        //HEI.01>>
        InterfaceSetupL.GET(InterfaceCode);
        if not InterfaceSetupL.Enabled then
            ERROR(Text000, InterfaceSetupL.Code);
        //HEI.01<<
    end;

    procedure GetLocalCurrentDateTime_Zycus() Now: DateTime;
    var
        DateFilterCalcL: Codeunit "DateFilter-Calc";
    begin
        //HEI.01>>
        Now := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
        //HEI.01<<
    end;

    local procedure GetPurchaseSetup_Zycus();
    begin
        //HEI.03>>
        if not PurchSetupRead then begin
            PurchPaySetup.GET();
            PurchSetupRead := true;
        end;
        //HEI.03<<
    end;

    local procedure GetGLSetup_Zycus();
    begin
        //HEI.03>>
        if not GLSetupRead then begin
            GLSetup.GET();
            GLSetupRead := true;
        end;
        //HEI.03<<
    end;

    local procedure GetUserID_Zycus(UserCode: Code[50]) UserID: Code[50];
    var
        UserL: Record User;
        UserSetupL: Record "User Setup";
    begin
        //HEI.03>>
        UserL.SETCURRENTKEY("User Name");
        //  UserL.SETRANGE("User Name", STRSUBSTNO(Text004, UserCode));//BC Upgrade SHARMP16--Zycus
        if not UserL.FINDFIRST() then begin
            UserL.INIT();
            UserL."User Security ID" := CREATEGUID();
            // UserL."User Name" := STRSUBSTNO(Text004, UserCode);//BC Upgrade SHARMP16--Zycus
            UserL."User Name" := UserCode;//BC Upgrade SHARMP16--Zycus

            UserL.INSERT(false);

            UserSetupL.INIT();
            UserSetupL.VALIDATE("User ID", UserL."User Name");
            UserSetupL.INSERT(false);
            UserID := UserL."User Name";
        end else begin
            if UserSetupL.GET(UserL."User Name") then
                UserID := UserSetupL."User ID"
            else begin
                UserSetupL.INIT();
                UserSetupL.VALIDATE("User ID", UserL."User Name");
                UserSetupL.INSERT(false);
                UserID := UserSetupL."User ID";
            end;
        end;
        exit(UserID);
        //HEI.03>>
    end;

    procedure GetISOCodeUnitOfMeasure_Zycus(ISOCode: Code[10]): Code[10];
    var
        UnitofMeasureL: Record "Unit of Measure";
    begin
        //HEI.03>>
        UnitofMeasureL.SETCURRENTKEY("International Standard Code");
        UnitofMeasureL.SETRANGE("International Standard Code", ISOCode);
        if UnitofMeasureL.FINDFIRST() then
            exit(UnitofMeasureL.Code);
        exit(ISOCode);
        //HEI.03<<
    end;
    // BC upgrade GUNREM01 Replaced codeunit ID >>

    //  [EventSubscriber(ObjectType::Codeunit, 50212, 'OnScheduleCCCDimCreateOrUpdate_Zycus', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Zycus Interface Auto Outbound", 'OnScheduleCCCDimCreateOrUpdate_Zycus', '', false, false)]//BC Upgrade GUNREM01 Replaced codeunit ID with NAV to BC 

    local procedure OnAfterCCCDimCreateOrUpdate_Zycus(var Dimension: Record Dimension; PreviewMode: Boolean);
    begin
        //HEI.01>>
        if Dimension.ISTEMPORARY or PreviewMode then
            exit;
        CLEAR(ZycusInterfaceSetupRead);
        CLEAR(GeneralInterfaceSetupRead);
        CLEAR(CompanyInformationRead);
        GetZycusInterfaceSetup_Zycus;
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate CCC Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        GetCompanyInformation_Zycus;
        GetGeneralInterfaceSetup_Zycus;
        ZycusInterfaceSetup.TESTFIELD("Zycus CCC Object Type");
        ZycusInterfaceSetup.TESTFIELD("Zycus CCC Interface");
        Dimension.GET(ZycusInterfaceSetup."Zycus CCC Object Type");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus CCC Interface");
        OutboundCCCDimCreateOrUpdate_Zycus(Dimension.Code, ZycusInterfaceSetup."Zycus CCC Interface");
        //HEI.01<<
    end;

    // BC upgrade GUNREM01 Replaced codeunit ID <<

    local procedure OutboundCCCDimCreateOrUpdate_Zycus(var DimCode: Code[20]; InterfaceCode: Code[20]);
    var
        DimensionValueL: Record "Dimension Value";
        UserSetupL: Record "User Setup";
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL1: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL2: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        HeaderEntryNoL: Integer;
        EntryNoL: Integer;
        NowL: DateTime;
        LoopCountL: Integer;
        iL: Integer;
        jL: Integer;
        ParkedErrorL: Boolean;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        GeneralLedgerSetupL: Record "General Ledger Setup";
    begin
        //HEI.01>>
        DimensionValueL.SETCURRENTKEY("Dimension Code", Code, "Last DateTime Modif. Zycus FND");
        DimensionValueL.SETRANGE("Dimension Code", DimCode);
        if ZycusInterfaceSetup."Starting Date-Time for CCC" = 0DT then begin
            if ZycusInterfaceSetup."Last Zycus CCC Park Date-Time" = 0DT then
                DimensionValueL.SETFILTER("Last DateTime Modif. Zycus FND", '>=%1', 0DT)
            else if ZycusInterfaceSetup."Last Zycus CCC Park Date-Time" <> 0DT then
                DimensionValueL.SETFILTER("Last DateTime Modif. Zycus FND", '>=%1', ZycusInterfaceSetup."Last Zycus CCC Park Date-Time");
        end else if ZycusInterfaceSetup."Starting Date-Time for CCC" <> 0DT then
                DimensionValueL.SETFILTER("Last DateTime Modif. Zycus FND", '>=%1', ZycusInterfaceSetup."Starting Date-Time for CCC");
        if ZycusInterfaceSetup."Max No. of Records for CCC" <> 0 then
            LoopCountL := ROUND((DimensionValueL.COUNT / ZycusInterfaceSetup."Max No. of Records for CCC"), 1, '>')
        else
            LoopCountL := 1;
        if DimensionValueL.findset(false) then begin
            GeneralLedgerSetupL.GET();
            for iL := 1 to LoopCountL do begin
                InterfaceEntryHeaderVIPL.INIT();
                InterfaceEntryHeaderVIPL."Interface Code" := InterfaceCode;
                InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
                InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
                InterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
                InterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
                InterfaceEntryHeaderVIPL."Source Type" := DATABASE::Dimension;
                InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"0";
                InterfaceEntryHeaderVIPL."Source No." := DimCode;
                InterfaceEntryHeaderVIPL."Message Name" := Text001;
                InterfaceEntryHeaderVIPL."Currency Code" := GeneralLedgerSetupL."LCY Code";
                if iL > 1 then
                    InterfaceEntryHeaderVIPL."Entry No." += 1;
                InterfaceEntryHeaderVIPL.INSERT(true);
                HeaderEntryNoL := InterfaceEntryHeaderVIPL."Entry No.";
                InterfaceEntryHeaderVIPL1.GET(HeaderEntryNoL);
                InterfaceEntryHeaderVIPL1."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderVIPL1."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
                InterfaceEntryHeaderVIPL1."Version No." := FORMAT(HeaderEntryNoL);
                InterfaceEntryHeaderVIPL1.MODIFY(true);

                repeat
                    CLEAR(jL);
                    InterfaceEntryLineVIPL.INIT();
                    InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNoL;
                    EntryNoL += 1;
                    InterfaceEntryLineVIPL."Entry No." := EntryNoL;
                    InterfaceEntryLineVIPL.Flag := Text001;
                    InterfaceEntryLineVIPL.EAN := DimensionValueL."Dimension Code";
                    InterfaceEntryLineVIPL."Ccc Code" := DimensionValueL.Code;
                    InterfaceEntryLineVIPL."Name 2" := DimensionValueL.Name;
                    InterfaceEntryLineVIPL.Blocked := DimensionValueL.Blocked;
                    if DimensionValueL."Approver ID FND" <> '' then begin
                        if UserSetupL.GET(DimensionValueL."Approver ID FND") then
                            InterfaceEntryLineVIPL."E-mail" := UserSetupL."E-Mail";
                    end;
                    jL := STRPOS(DimensionValueL."Approver ID FND", '\');
                    if jL = 0 then
                        InterfaceEntryLineVIPL."Customer Code" := DimensionValueL."Approver ID FND"
                    else
                        InterfaceEntryLineVIPL."Customer Code" := DELSTR(DimensionValueL."Approver ID FND", 1, jL);
                    InterfaceEntryLineVIPL."Ending Date-Time" := DimensionValueL."Last DateTime Modif. Zycus FND";
                    InterfaceEntryLineVIPL."Prod. Order Line No." := DimensionValueL."Dimension Value ID";
                    InterfaceEntryLineVIPL.INSERT(true);
                until (DimensionValueL.NEXT() = 0) or (EntryNoL = (ZycusInterfaceSetup."Max No. of Records for CCC" * iL));

                if (HeaderEntryNoL <> 0) or not ParkedErrorL then begin
                    InterfaceEntryHeaderVIPL2.SETCURRENTKEY("Entry No.", Status, "Source No.");
                    InterfaceEntryHeaderVIPL2.SETRANGE("Entry No.", HeaderEntryNoL);
                    InterfaceEntryHeaderVIPL2.SETRANGE(Status, InterfaceEntryHeaderVIPL2.Status::Error);
                    InterfaceEntryHeaderVIPL2.SETRANGE("Source No.", DimCode);
                    if not InterfaceEntryHeaderVIPL2.ISEMPTY then
                        ParkedErrorL := true
                    else if not ParkedErrorL then begin
                        InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", Status, "Source No.");
                        InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", HeaderEntryNoL);
                        InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Error);
                        InterfaceLogHeaderVIPL.SETRANGE("Source No.", DimCode);
                        if not InterfaceLogHeaderVIPL.ISEMPTY then
                            ParkedErrorL := true;
                    end;
                end;
            end;
        end;

        if (HeaderEntryNoL <> 0) and (EntryNoL <> 0) and not ParkedErrorL then begin
            NowL := GetLocalCurrentDateTime_Zycus();
            ZycusInterfaceSetupL.GET();
            ZycusInterfaceSetupL."Last Zycus CCC Park Date-Time" := NowL;
            ZycusInterfaceSetupL."Last Zycus CCC Error Date-Time" := 0DT;
            ZycusInterfaceSetupL."Last Zycus CCC in Error" := false;
            ZycusInterfaceSetupL."Starting Date-Time for CCC" := 0DT;
            ZycusInterfaceSetupL.MODIFY(false);
        end;
        //HEI.01<<
    end;

    // BC upgrade GUNREM01 replaced codeunit ID >>

    //  [EventSubscriber(ObjectType::Codeunit, 50212, 'OnScheduleWBNDimCreateOrUpdate_Zycus', '', false, false)] 
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Zycus Interface Auto Outbound", 'OnScheduleWBNDimCreateOrUpdate_Zycus', '', false, false)] //BC Upgrade GUNREM01 Replaced codeunit ID with NAV to BC
    local procedure OnAfterWBNDimCreateOrUpdate_Zycus(var Dimension: Record Dimension; PreviewMode: Boolean);
    begin
        //HEI.01>>
        if Dimension.ISTEMPORARY or PreviewMode then
            exit;
        CLEAR(ZycusInterfaceSetupRead);
        CLEAR(GeneralInterfaceSetupRead);
        CLEAR(CompanyInformationRead);
        GetZycusInterfaceSetup_Zycus;
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate Project Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        GetCompanyInformation_Zycus;
        GetGeneralInterfaceSetup_Zycus;
        ZycusInterfaceSetup.TESTFIELD("Zycus Project Object Type");
        ZycusInterfaceSetup.TESTFIELD("Zycus WBN Interface");
        Dimension.GET(ZycusInterfaceSetup."Zycus Project Object Type");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus WBN Interface");
        OutboundWBNDimCreateOrUpdate_Zycus(Dimension.Code, ZycusInterfaceSetup."Zycus WBN Interface");
        //HEI.01<<
    end;

    // BC upgrade GUNREM01 replaced codeunit ID <<
    local procedure OutboundWBNDimCreateOrUpdate_Zycus(var DimCode: Code[20]; InterfaceCode: Code[20]);
    var
        DimensionValueL: Record "Dimension Value";
        UserSetupL: Record "User Setup";
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL1: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL2: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        HeaderEntryNoL: Integer;
        EntryNoL: Integer;
        NowL: DateTime;
        LoopCountL: Integer;
        iL: Integer;
        jL: Integer;
        ParkedErrorL: Boolean;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        ZycusDimValueMappingL: Record "Zycus Dim Value Mapping INT";
        ZycusSpecialCharacterL: Record "Zycus Special Character INT";
        kL: Integer;
        FixedAssetL: Record "Fixed Asset";
    begin
        //HEI.01>>
        DimensionValueL.SETCURRENTKEY("Dimension Code", Code, "Last DateTime Modif. Zycus FND");
        DimensionValueL.SETRANGE("Dimension Code", DimCode);
        if ZycusInterfaceSetup."Starting Date-Time for WBN" = 0DT then begin
            if ZycusInterfaceSetup."Last Zycus WBN Park Date-Time" = 0DT then
                DimensionValueL.SETFILTER("Last DateTime Modif. Zycus FND", '>=%1', 0DT)
            else if ZycusInterfaceSetup."Last Zycus WBN Park Date-Time" <> 0DT then
                DimensionValueL.SETFILTER("Last DateTime Modif. Zycus FND", '>=%1', ZycusInterfaceSetup."Last Zycus WBN Park Date-Time");
        end else if ZycusInterfaceSetup."Starting Date-Time for WBN" <> 0DT then
                DimensionValueL.SETFILTER("Last DateTime Modif. Zycus FND", '>=%1', ZycusInterfaceSetup."Starting Date-Time for WBN");
        if ZycusInterfaceSetup."Max No. of Records for WBN" <> 0 then
            LoopCountL := ROUND((DimensionValueL.COUNT / ZycusInterfaceSetup."Max No. of Records for WBN"), 1, '>')
        else
            LoopCountL := 1;
        if DimensionValueL.findset(false) then begin
            for iL := 1 to LoopCountL do begin
                InterfaceEntryHeaderVIPL.INIT();
                InterfaceEntryHeaderVIPL."Interface Code" := InterfaceCode;
                InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
                InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
                InterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
                InterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
                InterfaceEntryHeaderVIPL."Source Type" := DATABASE::Dimension;
                InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"0";
                InterfaceEntryHeaderVIPL."Source No." := DimCode;
                InterfaceEntryHeaderVIPL."Message Name" := Text001;
                if iL > 1 then
                    InterfaceEntryHeaderVIPL."Entry No." += 1;
                InterfaceEntryHeaderVIPL.INSERT(true);
                HeaderEntryNoL := InterfaceEntryHeaderVIPL."Entry No.";
                InterfaceEntryHeaderVIPL1.GET(HeaderEntryNoL);
                InterfaceEntryHeaderVIPL1."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderVIPL1."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
                InterfaceEntryHeaderVIPL1."Version No." := FORMAT(HeaderEntryNoL);
                InterfaceEntryHeaderVIPL1.MODIFY(true);

                repeat
                    CLEAR(jL);
                    CLEAR(kL);
                    CLEAR(ZycusDimValueMappingL);
                    CLEAR(FixedAssetL);
                    InterfaceEntryLineVIPL.INIT();
                    InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNoL;
                    EntryNoL += 1;
                    InterfaceEntryLineVIPL."Entry No." := EntryNoL;
                    InterfaceEntryLineVIPL.Flag := Text001;
                    InterfaceEntryLineVIPL.EAN := DimensionValueL."Dimension Code";
                    InterfaceEntryLineVIPL."Ccc Code" := DimensionValueL.Code;
                    if DimensionValueL."Updated Special Char Zycus FND" then begin
                        ZycusDimValueMappingL.GET(DimensionValueL."Dimension Code", DimensionValueL.Code);
                        InterfaceEntryLineVIPL."CMG Code" := ZycusDimValueMappingL."Dimension Value Code Zycus";
                    end else begin
                        InterfaceEntryLineVIPL."CMG Code" := DimensionValueL.Code;
                        ZycusSpecialCharacterL.RESET();
                        if ZycusSpecialCharacterL.findset(false) then begin
                            repeat
                                kL := STRPOS(InterfaceEntryLineVIPL."CMG Code", ZycusSpecialCharacterL."Zycus Restricted Special Char");
                            until (ZycusSpecialCharacterL.NEXT() = 0) or (kL <> 0);
                        end;
                        if kL <> 0 then
                            ERROR(Text013, ZycusDimValueMappingL.FIELDCAPTION("Dimension Value Code Zycus"), DimensionValueL.TABLECAPTION,
                              DimensionValueL.FIELDCAPTION(Code), InterfaceEntryLineVIPL."CMG Code", ZycusDimValueMappingL.TABLECAPTION);
                    end;
                    InterfaceEntryLineVIPL."Name 2" := DimensionValueL.Name;
                    InterfaceEntryLineVIPL.Blocked := DimensionValueL.Blocked;
                    if DimensionValueL."Approver ID FND" <> '' then begin
                        if UserSetupL.GET(DimensionValueL."Approver ID FND") then
                            InterfaceEntryLineVIPL."E-mail" := UserSetupL."E-Mail";
                    end;
                    jL := STRPOS(DimensionValueL."Approver ID FND", '\');
                    if jL = 0 then
                        InterfaceEntryLineVIPL."Customer Code" := DimensionValueL."Approver ID FND"
                    else
                        InterfaceEntryLineVIPL."Customer Code" := DELSTR(DimensionValueL."Approver ID FND", 1, jL);
                    InterfaceEntryLineVIPL."Ending Date-Time" := DimensionValueL."Last DateTime Modif. Zycus FND";
                    InterfaceEntryLineVIPL."Prod. Order Line No." := DimensionValueL."Dimension Value ID";
                    if FixedAssetL.GET(DimensionValueL.Code) then
                        InterfaceEntryLineVIPL.Closed := true;
                    InterfaceEntryLineVIPL.INSERT(true);
                until (DimensionValueL.NEXT() = 0) or (EntryNoL = (ZycusInterfaceSetup."Max No. of Records for WBN" * iL));

                if (HeaderEntryNoL <> 0) or not ParkedErrorL then begin
                    InterfaceEntryHeaderVIPL2.SETCURRENTKEY("Entry No.", Status, "Source No.");
                    InterfaceEntryHeaderVIPL2.SETRANGE("Entry No.", HeaderEntryNoL);
                    InterfaceEntryHeaderVIPL2.SETRANGE(Status, InterfaceEntryHeaderVIPL2.Status::Error);
                    InterfaceEntryHeaderVIPL2.SETRANGE("Source No.", DimCode);
                    if not InterfaceEntryHeaderVIPL2.ISEMPTY then
                        ParkedErrorL := true
                    else if not ParkedErrorL then begin
                        InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", Status, "Source No.");
                        InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", HeaderEntryNoL);
                        InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Error);
                        InterfaceLogHeaderVIPL.SETRANGE("Source No.", DimCode);
                        if not InterfaceLogHeaderVIPL.ISEMPTY then
                            ParkedErrorL := true;
                    end;
                end;
            end;
        end;

        if (HeaderEntryNoL <> 0) and (EntryNoL <> 0) and not ParkedErrorL then begin
            NowL := GetLocalCurrentDateTime_Zycus();
            ZycusInterfaceSetupL.GET();
            ZycusInterfaceSetupL."Last Zycus WBN Park Date-Time" := NowL;
            ZycusInterfaceSetupL."Last Zycus WBN Error Date-Time" := 0DT;
            ZycusInterfaceSetupL."Last Zycus WBN in Error" := false;
            ZycusInterfaceSetupL."Starting Date-Time for WBN" := 0DT;
            ZycusInterfaceSetupL.MODIFY(false);
        end;
        //HEI.01<<
    end;
    // BC upgrade GUNREM01 replaced codeunit ID >>
    //  [EventSubscriber(ObjectType::Codeunit, 50086, 'OnAfterSetInterfaceError', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Interface Framework Mgt. VIP", 'OnAfterSetInterfaceError', '', false, false)] //BC Upgrade GUNREM01 Replaced codeunit ID with NAV to BC

    local procedure OnAfterInterfaceErrorUpdate_Zycus(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        NowL: DateTime;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus;
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if ZycusInterfaceSetupRead and (InterfaceEntryHeaderVIP.Status = InterfaceEntryHeaderVIP.Status::Error) then begin
            case InterfaceEntryHeaderVIP."Interface Code" of
                ZycusInterfaceSetup."Zycus CCC Interface":
                    begin
                        if ZycusInterfaceSetup."Activate CCC Interface" then begin
                            if (InterfaceEntryHeaderVIP."Source Type" = DATABASE::Dimension) and
                              (InterfaceEntryHeaderVIP."Source Subtype" = InterfaceEntryHeaderVIP."Source Subtype"::"0") then begin
                                NowL := GetLocalCurrentDateTime_Zycus;
                                ZycusInterfaceSetupL.GET;
                                ZycusInterfaceSetupL."Last Zycus CCC Error Date-Time" := NowL;
                                ZycusInterfaceSetupL."Last Zycus CCC in Error" := true;
                                ZycusInterfaceSetupL.MODIFY(false);
                            end;
                        end;
                    end;
                ZycusInterfaceSetup."Zycus WBN Interface":
                    begin
                        if ZycusInterfaceSetup."Activate Project Interface" then begin
                            if (InterfaceEntryHeaderVIP."Source Type" = DATABASE::Dimension) and
                              (InterfaceEntryHeaderVIP."Source Subtype" = InterfaceEntryHeaderVIP."Source Subtype"::"0") then begin
                                NowL := GetLocalCurrentDateTime_Zycus;
                                ZycusInterfaceSetupL.GET;
                                ZycusInterfaceSetupL."Last Zycus WBN Error Date-Time" := NowL;
                                ZycusInterfaceSetupL."Last Zycus WBN in Error" := true;
                                ZycusInterfaceSetupL.MODIFY(false);
                            end;
                        end;
                    end;
                //HEI.03>>
                ZycusInterfaceSetup."Zycus PO Creation Interface":
                    begin
                        if ZycusInterfaceSetup."Activate PO Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                OutboundPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                        InterfaceEntryHeaderVIP."External Order No.");
                                NowL := GetLocalCurrentDateTime_Zycus;
                            end;
                        end;
                    end;
                //HEI.03<<
                //HEI.05>>
                ZycusInterfaceSetup."Zycus GR Creation Interface":
                    begin
                        if ZycusInterfaceSetup."Activate GR Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                OutboundGoodsReceiptOfPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                      InterfaceEntryHeaderVIP."External Order No.",
                                                                                      0);
                                NowL := GetLocalCurrentDateTime_Zycus;
                            end;
                        end;
                    end;
                ZycusInterfaceSetup."Zycus GR Cancel Interface":
                    begin
                        if ZycusInterfaceSetup."Activate GR Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                OutboundGoodsReceiptCancellationOfPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                                  InterfaceEntryHeaderVIP."Source No.",
                                                                                                  0);
                                NowL := GetLocalCurrentDateTime_Zycus;
                            end;
                        end;
                    end;
                ZycusInterfaceSetup."Zycus LPO GR CreationInterface":
                    begin
                        if ZycusInterfaceSetup."Activate GR Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                OutboundGoodsReceiptOfLimitPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                           InterfaceEntryHeaderVIP."External Order No.",
                                                                                           0);
                                NowL := GetLocalCurrentDateTime_Zycus;
                            end;
                        end;
                    end;
                ZycusInterfaceSetup."Zycus LPO GR Cancel Interface":
                    begin
                        if ZycusInterfaceSetup."Activate GR Interface" then begin
                            if InterfaceEntryHeaderVIP.Direction = InterfaceEntryHeaderVIP.Direction::Inbound then begin
                                OutboundGoodsReceiptCancellationOfLimitPurchaseOrderConfirmation_Zycus(InterfaceEntryHeaderVIP."Entry No.",
                                                                                                       InterfaceEntryHeaderVIP."External Order No.",
                                                                                                       0,
                                                                                                       InterfaceEntryHeaderVIP.Name4);
                                NowL := GetLocalCurrentDateTime_Zycus;
                            end;
                        end;
                    end;
            //HEI.05<<
            end;
        end;
        CLEAR(ZycusInterfaceSetupRead);
        CLEAR(GeneralInterfaceSetupRead);
        CLEAR(CompanyInformationRead);
        CLEAR(PurchSetupRead);
        CLEAR(GLSetupRead);
        //HEI.01<<
    end;
    // BC upgrade GUNREM01 replaced codeunit ID <<

    local procedure OutboundVendorCreateOrUpdate_Zycus(InterfaceCode: Code[20]);
    var
        VendRecL: Record Vendor;
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL1: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL2: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        HeaderEntryNoL: Integer;
        EntryNoL: Integer;
        NowL: DateTime;
        LoopCountL: Integer;
        iL: Integer;
        jL: Integer;
        ParkedErrorL: Boolean;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.02>>
        InterfaceSetup.GET(InterfaceCode);
        GeneralInterfaceSetup.GET(); //HEI.06
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreationOfValidVendor();
        TempVendRec.RESET();
        TempVendRec.SETFILTER(TempVendRec."Vendor Type FND", ZycusInterfaceSetup."Vendor Account Group Filter");
        if ZycusInterfaceSetup."Max. Vendor Per Interface" <> 0 then
            LoopCountL := ROUND((TempVendRec.COUNT / ZycusInterfaceSetup."Max. Vendor Per Interface"), 1, '>')
        else
            LoopCountL := 1;

        if TempVendRec.findset(false) then begin
            for iL := 1 to LoopCountL do begin
                InterfaceEntryHeaderVIPL.INIT();
                InterfaceEntryHeaderVIPL."Interface Code" := InterfaceCode;
                InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
                InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
                //InterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND"; //HEI.06
                InterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID"; //HEI.06
                InterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderVIPL."Source Type" := DATABASE::Vendor;
                InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"0";
                InterfaceEntryHeaderVIPL."Source No." := InterfaceCode;
                InterfaceEntryHeaderVIPL."Message Name" := Text001;
                if iL > 1 then
                    InterfaceEntryHeaderVIPL."Entry No." += 1;
                InterfaceEntryHeaderVIPL.INSERT(true);
                HeaderEntryNoL := InterfaceEntryHeaderVIPL."Entry No.";
                InterfaceEntryHeaderVIPL1.GET(HeaderEntryNoL);
                InterfaceEntryHeaderVIPL1."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderVIPL1."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
                InterfaceEntryHeaderVIPL1.MODIFY(true);

                repeat
                    CLEAR(jL);
                    InterfaceEntryLineVIPL.INIT();
                    InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNoL;
                    EntryNoL += 1;
                    InterfaceEntryLineVIPL."Entry No." := EntryNoL;
                    InterfaceEntryLineVIPL.Flag := Text001;
                    InterfaceEntryLineVIPL."No." := TempVendRec."No.";
                    InterfaceEntryLineVIPL."No. 2" := TempVendRec."Global Vendor Number FND";
                    InterfaceEntryLineVIPL.Description := COPYSTR(TempVendRec.Name, 1, 50);
                    InterfaceEntryLineVIPL."Description 2" := COPYSTR(TempVendRec."Name 2", 1, 50);
                    if TempVendRec.Blocked = TempVendRec.Blocked::All then
                        InterfaceEntryLineVIPL.Blocked := true; //Posting Blocked
                    if TempVendRec.Blocked = TempVendRec.Blocked::Order then
                        InterfaceEntryLineVIPL.Closed := true; //Purchasing Blocked
                    InterfaceEntryLineVIPL."Currency Code" := TempVendRec."Currency Code";
                    InterfaceEntryLineVIPL."Payment Terms Code" := TempVendRec."Payment Terms Code";
                    InterfaceEntryLineVIPL."Shipment Method Code" := TempVendRec."Shipment Method Code";
                    InterfaceEntryLineVIPL.INSERT(true);
                until (TempVendRec.NEXT() = 0) or (EntryNoL = (ZycusInterfaceSetup."Max. Vendor Per Interface" * iL));

                if (HeaderEntryNoL <> 0) or (not ParkedErrorL) then begin
                    InterfaceEntryHeaderVIPL2.RESET();
                    InterfaceEntryHeaderVIPL2.SETCURRENTKEY("Entry No.", Status, "Source No.");
                    InterfaceEntryHeaderVIPL2.SETRANGE("Entry No.", HeaderEntryNoL);
                    InterfaceEntryHeaderVIPL2.SETRANGE(Status, InterfaceEntryHeaderVIPL2.Status::Error);
                    InterfaceEntryHeaderVIPL2.SETRANGE("Source No.", InterfaceCode);
                    if not InterfaceEntryHeaderVIPL2.ISEMPTY then
                        ParkedErrorL := true
                    else if not ParkedErrorL then begin
                        InterfaceLogHeaderVIPL.RESET();
                        InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", Status, "Source No.");
                        InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", HeaderEntryNoL);
                        InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Error);
                        InterfaceLogHeaderVIPL.SETRANGE("Source No.", InterfaceCode);
                        if not InterfaceLogHeaderVIPL.ISEMPTY then
                            ParkedErrorL := true;
                    end;
                end;
            end;
        end;

        if (HeaderEntryNoL <> 0) and (EntryNoL <> 0) and (not ParkedErrorL) then begin
            NowL := GetLocalCurrentDateTime_Zycus();
            ZycusInterfaceSetupL.GET();
            ZycusInterfaceSetupL."Last Zycus Vendor Sync Time" := NowL;
            ZycusInterfaceSetupL.MODIFY(false);
        end;
        //HEI.02<<

        //HEI.04>>
        NowL := GetLocalCurrentDateTime_Zycus();
        ZycusInterfaceSetupL.GET();
        ZycusInterfaceSetupL."Last Interface Run Time Vendor" := NowL;
        ZycusInterfaceSetupL.MODIFY();
        //HEI.04<<
    end;

    local procedure OutboundAccountCreateOrUpdate_Zycus(InterfaceCode: Code[20]);
    var
        GLAccRecL: Record "G/L Account";
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL1: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL2: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        HeaderEntryNoL: Integer;
        EntryNoL: Integer;
        NowL: DateTime;
        LoopCountL: Integer;
        iL: Integer;
        jL: Integer;
        ParkedErrorL: Boolean;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.02>>
        InterfaceSetup.GET(InterfaceCode);
        GeneralInterfaceSetup.GET(); //HEI.06
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreationOfValidGLAcc();
        TempGLAccRec.RESET();
        if ZycusInterfaceSetup."Max. Account Per Interface" <> 0 then
            LoopCountL := ROUND((TempGLAccRec.COUNT / ZycusInterfaceSetup."Max. Account Per Interface"), 1, '>')
        else
            LoopCountL := 1;

        if TempGLAccRec.findset(false) then begin
            for iL := 1 to LoopCountL do begin
                InterfaceEntryHeaderVIPL.INIT();
                InterfaceEntryHeaderVIPL."Interface Code" := InterfaceCode;
                InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
                InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
                //InterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND"; //HEI.06
                InterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID"; //HEI.06
                InterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderVIPL."Source Type" := DATABASE::"G/L Account";
                InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"0";
                InterfaceEntryHeaderVIPL."Source No." := InterfaceCode;
                InterfaceEntryHeaderVIPL."Message Name" := Text001;
                if iL > 1 then
                    InterfaceEntryHeaderVIPL."Entry No." += 1;
                InterfaceEntryHeaderVIPL.INSERT(true);
                HeaderEntryNoL := InterfaceEntryHeaderVIPL."Entry No.";
                InterfaceEntryHeaderVIPL1.GET(HeaderEntryNoL);
                InterfaceEntryHeaderVIPL1."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderVIPL1."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
                InterfaceEntryHeaderVIPL1.MODIFY(true);

                repeat
                    CLEAR(jL);
                    InterfaceEntryLineVIPL.INIT();
                    InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNoL;
                    EntryNoL += 1;
                    InterfaceEntryLineVIPL."Entry No." := EntryNoL;
                    InterfaceEntryLineVIPL.Flag := Text001;
                    InterfaceEntryLineVIPL."No." := TempGLAccRec."No.";
                    InterfaceEntryLineVIPL."No. 2" := TempGLAccRec."No. 2";
                    InterfaceEntryLineVIPL.Description := COPYSTR(TempGLAccRec.Name, 1, 50);
                    if TempGLAccRec."Income/Balance" = TempGLAccRec."Income/Balance"::"Balance Sheet" then
                        InterfaceEntryLineVIPL."Business Segment Name" := 'Balance Sheet Account'
                    else
                        InterfaceEntryLineVIPL."Business Segment Name" := 'Profit & Loss Account';
                    if TempGLAccRec.Blocked then
                        InterfaceEntryLineVIPL.Blocked := true;
                    if TempGLAccRec."Direct Posting" then
                        InterfaceEntryLineVIPL.Closed := true;//Direct Posting
                    InterfaceEntryLineVIPL.INSERT(true);
                until (TempGLAccRec.NEXT() = 0) or (EntryNoL = (ZycusInterfaceSetup."Max. Account Per Interface" * iL));

                if (HeaderEntryNoL <> 0) or (not ParkedErrorL) then begin
                    InterfaceEntryHeaderVIPL2.RESET();
                    InterfaceEntryHeaderVIPL2.SETCURRENTKEY("Entry No.", Status, "Source No.");
                    InterfaceEntryHeaderVIPL2.SETRANGE("Entry No.", HeaderEntryNoL);
                    InterfaceEntryHeaderVIPL2.SETRANGE(Status, InterfaceEntryHeaderVIPL2.Status::Error);
                    InterfaceEntryHeaderVIPL2.SETRANGE("Source No.", InterfaceCode);
                    if not InterfaceEntryHeaderVIPL2.ISEMPTY then
                        ParkedErrorL := true
                    else if not ParkedErrorL then begin
                        InterfaceLogHeaderVIPL.RESET();
                        InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", Status, "Source No.");
                        InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", HeaderEntryNoL);
                        InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Error);
                        InterfaceLogHeaderVIPL.SETRANGE("Source No.", InterfaceCode);
                        if not InterfaceLogHeaderVIPL.ISEMPTY then
                            ParkedErrorL := true;
                    end;
                end;
            end;
        end;


        if (HeaderEntryNoL <> 0) and (EntryNoL <> 0) and (not ParkedErrorL) then begin
            NowL := GetLocalCurrentDateTime_Zycus();
            ZycusInterfaceSetupL.GET();
            ZycusInterfaceSetupL."Last Zycus Account Sync Time" := NowL;
            ZycusInterfaceSetupL.MODIFY(false);
        end;
        //HEI.02<<

        //HEI.04>>
        NowL := GetLocalCurrentDateTime_Zycus();
        ZycusInterfaceSetupL.GET();
        ZycusInterfaceSetupL."Last Interface Run Time GL Acc" := NowL;
        ZycusInterfaceSetupL.MODIFY();
        //HEI.04<<
    end;
    // BC upgrade GUNREM01 replaced codeunit ID >>
    // [EventSubscriber(ObjectType::Codeunit, 50212, 'OnScheduleVendorCreateOrUpdate_Zycus', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Zycus Interface Auto Outbound", 'OnScheduleVendorCreateOrUpdate_Zycus', '', false, false)] //BC Upgrade GUNREM01 Replaced codeunit ID with NAV to BC

    local procedure OnAfterVendorCreateOrUpdate_Zycus(PreviewMode: Boolean);
    begin
        //HEI.02>>
        if PreviewMode then
            exit;
        GetCompanyInformation_Zycus;
        GetGeneralInterfaceSetup_Zycus;
        GetZycusInterfaceSetup_Zycus;
        if not ZycusInterfaceSetup."Activate Vendor Interface" then
            exit;
        ZycusInterfaceSetup.TESTFIELD("Zycus Vendor Interface Code");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus Vendor Interface Code");
        OutboundVendorCreateOrUpdate_Zycus(ZycusInterfaceSetup."Zycus Vendor Interface Code");
        //HEI.02<<
    end;


    //  [EventSubscriber(ObjectType::Codeunit, 50212, 'OnScheduleGLCreateOrUpdate_Zycus', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Zycus Interface Auto Outbound", 'OnScheduleGLCreateOrUpdate_Zycus', '', false, false)] //BC Upgrade GUNREM01 Replaced codeunit ID with NAV to BC

    local procedure OnAfterGLCreateOrUpdate_Zycus(PreviewMode: Boolean);
    begin
        //HEI.02>>
        GetCompanyInformation_Zycus;
        GetGeneralInterfaceSetup_Zycus;
        GetZycusInterfaceSetup_Zycus;
        if not ZycusInterfaceSetup."Activate Account Interface" then
            exit;
        ZycusInterfaceSetup.TESTFIELD("Zycus Account Interface Code");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus Account Interface Code");
        OutboundAccountCreateOrUpdate_Zycus(ZycusInterfaceSetup."Zycus Account Interface Code");
        //HEI.02<<
    end;
    // BC upgrade GUNREM01 replaced codeunit ID <<
    local procedure CheckForValidGLAcc(GLAccRecLP: Record "G/L Account"): Boolean;
    var
        CMGMappingRecL: Record "CMG Mapping FND";
    begin
        //HEI.02>>
        ZycusInterfaceSetup.GET();
        CMGMappingRecL.RESET();
        CMGMappingRecL.SETRANGE(CMGMappingRecL."C&TP CODE", GLAccRecLP."C&TP CODE FND");
        CMGMappingRecL.SETRANGE(CMGMappingRecL."Dimension Code", 'CMG');
        CMGMappingRecL.SETFILTER(CMGMappingRecL."Dimension Value Code", '<>%1', '');
        if CMGMappingRecL.FINDFIRST() then begin
            if (ZycusInterfaceSetup."G/L Account Position" <> 0) and (ZycusInterfaceSetup."G/L Account Position Value" <> '') then begin
                if COPYSTR(GLAccRecLP."No.", ZycusInterfaceSetup."G/L Account Position", 1) <> ZycusInterfaceSetup."G/L Account Position Value" then
                    exit(true)
                else
                    exit(false);
            end else
                exit(true);
        end else
            exit(false);
        //HEI.02<<
    end;

    local procedure CreationOfValidGLAcc();
    var
        GLAccRecL: Record "G/L Account";
        ZycusMasterTimestampLV: Record "Zycus Master Timestamp FND";
        GLAccRecLV: Record "G/L Account";
    begin
        //HEI.02>>
        ZycusInterfaceSetup.GET();
        if ZycusInterfaceSetup."Last Zycus Account Sync Time" = 0DT then begin
            InitializeZycusGLMastTimestamp();
        end;

        CLEAR(TempGLAccRec);
        ZycusMasterTimestampLV.RESET();
        ZycusMasterTimestampLV.SETCURRENTKEY("Table ID", Deleted, "Last Local Change Datetime");
        ZycusMasterTimestampLV.SETRANGE(ZycusMasterTimestampLV."Table ID", DATABASE::"G/L Account");
        ZycusMasterTimestampLV.SETRANGE(ZycusMasterTimestampLV.Deleted, false);
        ZycusMasterTimestampLV.SETFILTER(ZycusMasterTimestampLV."Last Local Change Datetime", '%1|>%2', 0DT, ZycusInterfaceSetup."Last Zycus Account Sync Time");
        if ZycusMasterTimestampLV.findset(false) then begin
            repeat
                if GLAccRecLV.GET(ZycusMasterTimestampLV.Code) then begin
                    if ((GLAccRecLV."Account Type" = GLAccRecLV."Account Type"::Posting) and (GLAccRecLV."C&TP CODE FND" <> '')) then begin
                        if CheckForValidGLAcc(GLAccRecLV) then begin
                            TempGLAccRec.INIT();
                            TempGLAccRec := GLAccRecLV;
                            TempGLAccRec.INSERT()
                        end;
                    end;
                end;
            until ZycusMasterTimestampLV.NEXT() = 0;
        end;
        //HEI.02<<
    end;

    local procedure CreationOfValidVendor();
    var
        ZycusMasterTimestampLV: Record "Zycus Master Timestamp FND";
        VendRecLV: Record Vendor;
        GLAccLV: Record "G/L Account";
    begin
        //HEI.02>>
        ZycusInterfaceSetup.GET();
        if ZycusInterfaceSetup."Last Zycus Vendor Sync Time" = 0DT then begin
            InitializeZycusVendMastTimestamp();
        end;
        CLEAR(TempVendRec);
        ZycusMasterTimestampLV.RESET();
        ZycusMasterTimestampLV.SETCURRENTKEY("Table ID", Deleted, "Last Local Change Datetime");
        ZycusMasterTimestampLV.SETRANGE(ZycusMasterTimestampLV."Table ID", DATABASE::Vendor);
        ZycusMasterTimestampLV.SETRANGE(ZycusMasterTimestampLV.Deleted, false);
        ZycusMasterTimestampLV.SETFILTER(ZycusMasterTimestampLV."Last Local Change Datetime", '%1|>%2', 0DT, ZycusInterfaceSetup."Last Zycus Vendor Sync Time"); //HEI.04
        if ZycusMasterTimestampLV.findset(false) then begin
            repeat
                if VendRecLV.GET(ZycusMasterTimestampLV.Code) then begin
                    TempVendRec.INIT();
                    TempVendRec := VendRecLV;
                    TempVendRec.INSERT()
                end;
            until ZycusMasterTimestampLV.NEXT() = 0;
        end;
        //HEI.02<<
    end;

    local procedure InitializeZycusGLMastTimestamp();
    var
        GLAccRecL: Record "G/L Account";
        ZycusMasterTimestampLV: Record "Zycus Master Timestamp FND";
        GLAccRecLV: Record "G/L Account";
    begin
        //HEI.02>>
        CLEAR(TempGLAccRec1);
        ZycusInterfaceSetup.GET();
        GLAccRecL.RESET();
        GLAccRecL.SETFILTER(GLAccRecL."Account Type", '%1', GLAccRecL."Account Type"::Posting);
        GLAccRecL.SETFILTER(GLAccRecL."C&TP CODE FND", '<>%1', '');
        if GLAccRecL.findset(false) then begin
            repeat
                if CheckForValidGLAcc(GLAccRecL) then begin
                    TempGLAccRec1.INIT();
                    TempGLAccRec1 := GLAccRecL;
                    TempGLAccRec1.INSERT();
                end;
            until GLAccRecL.NEXT() = 0;
        end;

        ZycusMasterTimestampLV.RESET();
        ZycusMasterTimestampLV.SETRANGE(ZycusMasterTimestampLV."Table ID", DATABASE::"G/L Account");
        if ZycusMasterTimestampLV.FINDFIRST() then
            ZycusMasterTimestampLV.DELETEALL();

        TempGLAccRec1.RESET();
        if TempGLAccRec1.findset(false) then begin
            repeat
                ZycusMasterTimestampLV.INIT();
                ZycusMasterTimestampLV."Table ID" := DATABASE::"G/L Account";
                ZycusMasterTimestampLV.Code := TempGLAccRec1."No.";
                ZycusMasterTimestampLV."Last Local Change Datetime" := CREATEDATETIME(TempGLAccRec1."Last Date Modified", 000000T);
                ZycusMasterTimestampLV."Last Change Datetime" := CREATEDATETIME(TempGLAccRec1."Last Date Modified", 000000T); //HEI.07
                ZycusMasterTimestampLV.INSERT();
            until TempGLAccRec1.NEXT() = 0;
        end;
        //HEI.02<<
    end;

    local procedure InitializeZycusVendMastTimestamp();
    var
        GLAccRecL: Record "G/L Account";
        ZycusMasterTimestampLV: Record "Zycus Master Timestamp FND";
        GLAccRecLV: Record "G/L Account";
        VendRecLV: Record Vendor;
    begin
        //HEI.02>>
        CLEAR(TempVendRec1);
        ZycusInterfaceSetup.GET();
        VendRecLV.RESET();
        if VendRecLV.findset(false) then begin
            repeat
                TempVendRec1.INIT();
                TempVendRec1 := VendRecLV;
                TempVendRec1.INSERT();
            until VendRecLV.NEXT() = 0;
        end;
        ZycusMasterTimestampLV.RESET();
        ZycusMasterTimestampLV.SETRANGE(ZycusMasterTimestampLV."Table ID", DATABASE::Vendor);
        if ZycusMasterTimestampLV.FINDFIRST() then
            ZycusMasterTimestampLV.DELETEALL();
        TempVendRec1.RESET();
        if TempVendRec1.findset(false) then begin
            repeat
                ZycusMasterTimestampLV.INIT();
                ZycusMasterTimestampLV."Table ID" := DATABASE::Vendor;
                ZycusMasterTimestampLV.Code := TempVendRec1."No.";
                ZycusMasterTimestampLV."Last Local Change Datetime" := CREATEDATETIME(TempVendRec1."Last Date Modified", 000000T);
                ZycusMasterTimestampLV."Last Change Datetime" := CREATEDATETIME(TempVendRec1."Last Date Modified", 000000T); //HEI.07
                ZycusMasterTimestampLV.INSERT();
            until TempVendRec1.NEXT() = 0;
        end;
        //HEI.02<<
    end;

    procedure InboundProcessPurchaseOrder_Zycus(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        PurchaseLineL: Record "Purchase Line";
        PurchaseLineL2: Record "Purchase Line";
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
        InterfaceEntryLineVIPL2: Record "Interface Entry Line VIP INT";
        DeletePOL: Boolean;
        PurchaseLineL3: Record "Purchase Line";
    begin
        //HEI.03>>
        CLEAR(ZycusInterfaceSetupRead);
        CLEAR(GeneralInterfaceSetupRead);
        CLEAR(CompanyInformationRead);
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate PO Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus PO Creation Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus PO Confirmatio Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus Create Action Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus Update Action Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus Cancellation Action Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus PO CCC Dimention Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus PO CONCAT Dimention Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus Normal PO Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus Limit PO Code");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus PO Creation Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus PO Confirmatio Interface");
        InterfaceEntryHeaderVIP.TESTFIELD("Entry No.");
        InterfaceEntryHeaderVIP.TESTFIELD("Interface Code", ZycusInterfaceSetup."Zycus PO Creation Interface");
        InterfaceEntryHeaderVIP.TESTFIELD("External Order No.");
        InterfaceEntryHeaderVIP.TESTFIELD("Action Code");
        InterfaceEntryHeaderVIP.TESTFIELD("Buy-from Vendor No.");

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, Status, "External Order No.", "Action Code");
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus PO Creation Interface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Pending);
        InterfaceEntryHeaderVIPL.SETRANGE("External Order No.", InterfaceEntryHeaderVIP."External Order No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Action Code", InterfaceEntryHeaderVIP."Action Code");
        InterfaceEntryHeaderVIPL.FINDFIRST();

        InterfaceEntryLineVIPL.SETCURRENTKEY("Header Entry No.", "External Order No.");
        InterfaceEntryLineVIPL.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        InterfaceEntryLineVIPL.SETRANGE("External Order No.", InterfaceEntryHeaderVIPL."External Order No.");
        InterfaceEntryLineVIPL.findset(false);
        GetGLSetup_Zycus();
        GetPurchaseSetup_Zycus();
        PurchPaySetup.TESTFIELD("PO Subtype Code FND", Text014);
        InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"1";
        case InterfaceEntryHeaderVIPL."Action Code" of
            ZycusInterfaceSetup."Zycus Create Action Code":
                begin
                    ValidatePurchaseOrderHeader_Zycus(InterfaceEntryHeaderVIPL, true);
                    PurchaseHeaderL.GET(InterfaceEntryHeaderVIPL."Source Subtype", InterfaceEntryHeaderVIPL."External Order No.");
                    PurchaseHeaderAddL.GET(InterfaceEntryHeaderVIPL."Source Subtype", InterfaceEntryHeaderVIPL."External Order No.");
                end;
            ZycusInterfaceSetup."Zycus Update Action Code":
                begin
                    ValidatePurchaseOrderHeader_Zycus(InterfaceEntryHeaderVIPL, false);
                    PurchaseHeaderL.GET(InterfaceEntryHeaderVIPL."Source Subtype", InterfaceEntryHeaderVIPL."External Order No.");
                    PurchaseHeaderAddL.GET(InterfaceEntryHeaderVIPL."Source Subtype", InterfaceEntryHeaderVIPL."External Order No.");

                    PurchaseLineL2.SETCURRENTKEY("Document Type", "Zycus Order No. FND");
                    PurchaseLineL2.SETRANGE("Document Type", InterfaceEntryHeaderVIPL."Source Subtype");
                    PurchaseLineL2.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");
                    if not PurchaseLineL2.ISEMPTY then
                        PurchaseLineL2.MODIFYALL("Zycus PO Line Validated FND", false, false);

                    InterfaceEntryLineVIPL2.COPYFILTERS(InterfaceEntryLineVIPL);
                    InterfaceEntryLineVIPL2.findset(false);
                    repeat
                        if InterfaceEntryLineVIPL2."Action Code" = ZycusInterfaceSetup."Zycus Cancellation Action Code" then
                            DeletePOL := true
                        else
                            DeletePOL := false;
                    until (InterfaceEntryLineVIPL2.NEXT() = 0) or not DeletePOL;

                    if DeletePOL then begin
                        PurchaseLineL3.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Quantity Received");
                        PurchaseLineL3.COPYFILTERS(PurchaseLineL2);
                        PurchaseLineL3.SETFILTER("Quantity Received", '<>0');
                        if PurchaseLineL3.ISEMPTY then begin
                            DeletePurchaseOrderHeader_Zycus(InterfaceEntryHeaderVIPL);
                            exit;
                        end else begin
                            PurchaseLineL3.SETRANGE("Quantity Received");
                            if not PurchaseLineL3.ISEMPTY then begin
                                PurchaseLineL3.MODIFYALL("Delivery Finalized FND", true, true);
                                PurchaseHeaderL."Closed FND" := true;
                                PurchaseHeaderL.MODIFY(true);
                                exit;
                            end;
                        end;
                    end;
                end;
            ZycusInterfaceSetup."Zycus Cancellation Action Code":
                begin
                    PurchaseHeaderL.GET(InterfaceEntryHeaderVIPL."Source Subtype", InterfaceEntryHeaderVIPL."External Order No.");
                    PurchaseHeaderL."Closed FND" := true;
                    PurchaseHeaderL.MODIFY(true);
                end;
        end;

        repeat
            InterfaceEntryLineVIPL.TESTFIELD("Action Code");
            InterfaceEntryLineVIPL.TESTFIELD("External Order No.", InterfaceEntryHeaderVIPL."External Order No.");
            InterfaceEntryLineVIPL.TESTFIELD("External Order Line No.");
            if InterfaceEntryLineVIPL."Traceability Code" = '' then
                ERROR(Text011, Text020);
            if InterfaceEntryLineVIPL."Traceability Code" = ZycusInterfaceSetup."Zycus Limit PO Code" then begin
                if InterfaceEntryLineVIPL."Severity Code" = '' then
                    ERROR(Text011, Text021);
            end;
            case InterfaceEntryHeaderVIPL."Action Code" of
                ZycusInterfaceSetup."Zycus Create Action Code":
                    InterfaceEntryLineVIPL.TESTFIELD("Action Code", ZycusInterfaceSetup."Zycus Create Action Code");
                ZycusInterfaceSetup."Zycus Cancellation Action Code":
                    InterfaceEntryLineVIPL.TESTFIELD("Action Code", ZycusInterfaceSetup."Zycus Cancellation Action Code");
            end;
            case InterfaceEntryLineVIPL."Action Code" of
                ZycusInterfaceSetup."Zycus Create Action Code":
                    begin
                        PurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Zycus Order Line No. FND");
                        PurchaseLineL.SETRANGE("Document Type", InterfaceEntryHeaderVIPL."Source Subtype");
                        PurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");
                        PurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                        if PurchaseLineL.FINDFIRST() then
                            ValidatePurchaseOrderLine_Zycus(InterfaceEntryLineVIPL, PurchaseHeaderL, PurchaseLineL, false)
                        else
                            ValidatePurchaseOrderLine_Zycus(InterfaceEntryLineVIPL, PurchaseHeaderL, PurchaseLineL, true);
                    end;
                ZycusInterfaceSetup."Zycus Update Action Code":
                    begin
                        InterfaceEntryHeaderVIPL.TESTFIELD("Action Code", ZycusInterfaceSetup."Zycus Update Action Code");
                        PurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Zycus Order Line No. FND");
                        PurchaseLineL.SETRANGE("Document Type", InterfaceEntryHeaderVIPL."Source Subtype");
                        PurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");
                        PurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                        if PurchaseLineL.FINDFIRST() then
                            ValidatePurchaseOrderLine_Zycus(InterfaceEntryLineVIPL, PurchaseHeaderL, PurchaseLineL, false)
                        else
                            ValidatePurchaseOrderLine_Zycus(InterfaceEntryLineVIPL, PurchaseHeaderL, PurchaseLineL, true);
                    end;
                ZycusInterfaceSetup."Zycus Cancellation Action Code":
                    begin
                        InterfaceEntryHeaderVIPL.TESTFIELD("Action Code", ZycusInterfaceSetup."Zycus Update Action Code");
                        PurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Zycus Order Line No. FND");
                        PurchaseLineL.SETRANGE("Document Type", InterfaceEntryHeaderVIPL."Source Subtype");
                        PurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");
                        PurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                        if PurchaseLineL.FINDFIRST() then begin
                            PurchaseLineL.VALIDATE("Cancelled FND", true);
                            PurchaseLineL."Zycus PO Line Validated FND" := true;
                            PurchaseLineL.MODIFY(true);
                        end;
                    end;
            end;
        until InterfaceEntryLineVIPL.NEXT() = 0;
        CLEAR(PurchaseHeaderL);
        if PurchaseHeaderL.GET(InterfaceEntryHeaderVIPL."Source Subtype", InterfaceEntryHeaderVIPL."External Order No.") then begin
            case InterfaceEntryHeaderVIPL."Action Code" of
                ZycusInterfaceSetup."Zycus Update Action Code":
                    begin
                        DeletePurchaseOrderLine_Zycus(InterfaceEntryLineVIPL, PurchaseHeaderL);
                    end;
            end;
            PurchaseLineL.RESET();
            PurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", Quantity);
            PurchaseLineL.SETRANGE("Document Type", PurchaseHeaderL."Document Type");
            PurchaseLineL.SETRANGE("Document No.", PurchaseHeaderL."No.");
            PurchaseLineL.SETFILTER(Quantity, '>0');
            if not PurchaseLineL.ISEMPTY then begin
                //CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeaderL);
                ReleasePurchaseDocumentL.ReleasePurchaseHeader(PurchaseHeaderL, false);  //BC Upgrade SHARMP16--zycusbug fix03072026
                if PurchaseHeaderAddL."Import Identifier" then
                    ValidateReleasedPurchaseOrder_Zycus(PurchaseHeaderL);
            end;
        end;
        //HEI.03<<
    end;

    local procedure ValidatePurchaseOrderHeader_Zycus(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT"; IsInsert: Boolean);
    var
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
        PurchasesUtilsL: Codeunit "Purchases-Utils";
        VendorL: Record Vendor;
        UserIDL: Code[50];

        // BC Upgrade MISHRS14 >> # HEI.11
        PurchaseLineTOL: Record "Purchase Line";
    // BC Upgrade MISHRS14 <<

    begin
        //HEI.03>>
        InterfaceEntryHeaderVIP."Source Subtype" := InterfaceEntryHeaderVIP."Source Subtype"::"1";
        if PurchaseHeaderAddL.GET(InterfaceEntryHeaderVIP."Source Subtype", InterfaceEntryHeaderVIP."External Order No.") then begin
            PurchaseHeaderAddL.TESTFIELD("Zycus Order No. INT", InterfaceEntryHeaderVIP."External Order No.");
            if PurchaseHeaderL.GET(InterfaceEntryHeaderVIP."Source Subtype", InterfaceEntryHeaderVIP."External Order No.") then begin
                if IsInsert then begin
                    case InterfaceEntryHeaderVIP."Action Code" of
                        ZycusInterfaceSetup."Zycus Create Action Code":
                            begin
                                ERROR(Text024, PurchaseHeaderL."No.", InterfaceEntryHeaderVIP.FIELDCAPTION("Action Code"), ZycusInterfaceSetup."Zycus Create Action Code");
                            end;
                    end;
                end;
            end;
        end;
        if not GUIALLOWED then
            PurchaseHeaderL.SetHideValidationDialog(true);
        if IsInsert then begin
            PurchaseHeaderL.INIT();
            PurchaseHeaderL."Document Type" := InterfaceEntryHeaderVIP."Source Subtype";
            PurchaseHeaderL.VALIDATE("No.", InterfaceEntryHeaderVIP."External Order No.");
            PurchaseHeaderL.INSERT(true);

            CLEAR(PurchaseHeaderAddL);
            if not PurchaseHeaderAddL.GET(InterfaceEntryHeaderVIP."Source Subtype", InterfaceEntryHeaderVIP."External Order No.") then begin
                PurchaseHeaderAddL.INIT();
                PurchaseHeaderAddL."Document Type" := InterfaceEntryHeaderVIP."Source Subtype";
                PurchaseHeaderAddL."No." := InterfaceEntryHeaderVIP."External Order No.";
                PurchaseHeaderAddL.INSERT(false);
            end;
        end else begin
            ReleasePurchaseDocumentL.Reopen(PurchaseHeaderL);
            if PurchaseHeaderL.Status = PurchaseHeaderL.Status::Released then begin
                PurchaseHeaderL.Status := PurchaseHeaderL.Status::Open;
                PurchaseHeaderL.MODIFY(true);
            end;//BC Upgrade SHARMP16 zycusbug03072026
            if PurchaseHeaderL.Status = PurchaseHeaderL.Status::Open then begin

                // BC Upgrade MISHRS14 >>
                // HEI.11 >>
                PurchaseLineTOL.SETCURRENTKEY("Document Type", "Document No.", "TO Reference FND", "Quantity Received");
                PurchaseLineTOL.SETRANGE("Document Type", PurchaseHeaderL."Document Type");
                PurchaseLineTOL.SETRANGE("Document No.", PurchaseHeaderL."No.");
                PurchaseLineTOL.SETFILTER("TO Reference FND", '<>%1', '');
                PurchaseLineTOL.SETFILTER("Quantity Received", '<>0');
                IF PurchaseLineTOL.ISEMPTY() THEN BEGIN
                    // HEI.11 <<
                    // BC Upgrade MISHRS14 <<

                    if PurchasesUtilsL.TODeletionRestriction(PurchaseHeaderL) then
                        PurchasesUtilsL.ManageTOfromPO(PurchaseHeaderL);

                    // BC Upgrade MISHR14 >>
                    // HEI.11 >>
                end;
                // HEI.11 <<
                // BC Upgrade MISHR14 <<

            end;
        end;
        CLEAR(PurchaseHeaderL);
        CLEAR(PurchaseHeaderAddL);
        PurchaseHeaderL.GET(InterfaceEntryHeaderVIP."Source Subtype", InterfaceEntryHeaderVIP."External Order No.");
        if not GUIALLOWED then
            PurchaseHeaderL.SetHideValidationDialog(true); //BC Upgrade SHARMP16
        PurchaseHeaderAddL.GET(InterfaceEntryHeaderVIP."Source Subtype", InterfaceEntryHeaderVIP."External Order No.");
        //BC Upgrade SHARMP16 BEGIN<<
        if PurchaseHeaderL.Status = PurchaseHeaderL.Status::Released then begin
            PurchaseHeaderL.Status := PurchaseHeaderL.Status::Open;
            PurchaseHeaderL.MODIFY(true);
        end;//BC Upgrade SHARMP16 END>>
        PurchaseHeaderL.VALIDATE("Order Date", InterfaceEntryHeaderVIP."Document Date");
        if PurchaseHeaderL."Buy-from Vendor No." <> InterfaceEntryHeaderVIP."Buy-from Vendor No." then begin
            VendorL.GET(InterfaceEntryHeaderVIP."Buy-from Vendor No.");
            VendorL.TESTFIELD(Blocked, VendorL.Blocked::" ");
            PurchaseHeaderL.VALIDATE("Buy-from Vendor No.", InterfaceEntryHeaderVIP."Buy-from Vendor No.");
        end;
        PurchaseHeaderL.VALIDATE("Purchaser Code", InterfaceEntryHeaderVIP."Salesperson/Purchaser Code");
        PurchaseHeaderL.VALIDATE("Shipment Method Code", InterfaceEntryHeaderVIP."Shipment Method Code");
        if not PurchasesUtilsL.CheckShippingMethod(PurchPaySetup, PurchaseHeaderL) then
            PurchaseHeaderAddL."Import Identifier" := true
        else
            PurchaseHeaderAddL."Import Identifier" := false;
        PurchaseHeaderL."Shipment Method Location FND" := InterfaceEntryHeaderVIP."Shipment Method Location";
        PurchaseHeaderL.VALIDATE("Payment Terms Code", InterfaceEntryHeaderVIP."Payment Terms Code");
        if GLSetup."LCY Code" <> InterfaceEntryHeaderVIP."Currency Code" then
            PurchaseHeaderL.VALIDATE("Currency Code", InterfaceEntryHeaderVIP."Currency Code")
        else if PurchaseHeaderL."Currency Code" <> '' then
            PurchaseHeaderL.VALIDATE("Currency Code", '');
        if InterfaceEntryHeaderVIP.Contact <> '' then begin
            UserIDL := GetUserID_Zycus(InterfaceEntryHeaderVIP.Contact);
            // PurchaseHeaderL."Created By" := UserIDL;  // BC Upgrade NANDIS03 - field is of DIT
            // PurchaseHeaderL."Requester ID" := UserIDL;  // BC Upgrade NANDIS03 - field is of DIT
        end;
        PurchaseHeaderL.VALIDATE("Document Subtype Code FND", PurchPaySetup."PO Subtype Code FND"); // BC Upgrade SHUKLP03
        PurchaseHeaderL."SRM Contract No. FND" := InterfaceEntryHeaderVIP.Name;
        PurchaseHeaderL."SRM Order No. FND" := InterfaceEntryHeaderVIP."External Order No.";
        PurchaseHeaderL.MODIFY(true);
        //Bc Upgrade Sharmp16 BEGIN<<
        CLEAR(PurchaseHeaderAddL);
        PurchaseHeaderAddL.GET(InterfaceEntryHeaderVIP."Source Subtype", InterfaceEntryHeaderVIP."External Order No.");
        if not PurchasesUtilsL.CheckShippingMethod(PurchPaySetup, PurchaseHeaderL) then
            PurchaseHeaderAddL."Import Identifier" := true
        else
            PurchaseHeaderAddL."Import Identifier" := false;
        //Bc Upgrade Sharmp16 END>>
        PurchaseHeaderAddL."Zycus Order No. INT" := InterfaceEntryHeaderVIP."External Order No.";
        PurchaseHeaderAddL."PO Transaction Intf. Zycus INT" := InterfaceEntryHeaderVIP."Interface Code";
        PurchaseHeaderAddL."Processed PO Trans. Zycus INT" := true;
        PurchaseHeaderAddL.MODIFY(false);
        //HEI.03<<
    end;

    local procedure ValidatePurchaseOrderLine_Zycus(var InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT"; var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; IsInsert: Boolean);
    var
        PurchaseLineL: Record "Purchase Line";
        PurchaseLineNoL: Integer;
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        ZycusPOLineTypeMappingL: Record "Zycus PO Line Type Mapping INT";
        ItemL: Record Item;
        FixedAssetL: Record "Fixed Asset";
        GLAccountL: Record "G/L Account";
        DimensionValueL: Record "Dimension Value";
        FoundInItemL: Boolean;
        FoundInFAL: Boolean;
        FoundInGLL: Boolean;
        LineTypeL: Text[20];
        DimensionSetEntryL: Record "Dimension Set Entry";
        VATPostingSetupL: Record "VAT Posting Setup";
        LocationL: Record Location;
        PrevUnitCostL: Decimal;
        LimitPOUnitCostL: Decimal;
        ReturnQuantityL: Decimal;
        ZycusDimensionValueMappingL: Record "Zycus Dim Value Mapping INT";
        ConcatDimValCodeL: Code[20];
    begin
        //HEI.03>>
        CLEAR(FoundInConcat);
        //if not GUIALLOWED then//BC Upgrade SHARMP16--Zycus
        // PurchaseLineL.SetHideValidationDialog(true);  // BC Upgrade NANDIS03 - DIT dependency
        if IsInsert then begin
            PurchaseLineL.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLineL.SETRANGE("Document No.", PurchaseHeader."No.");
            if PurchaseLineL.FINDLAST() then
                PurchaseLineNoL := PurchaseLineL."Line No.";
            PurchaseLineNoL += 10000;
            if (PurchaseLineNoL <> InterfaceEntryLineVIP."External Order Line No." * 10000) and (PurchaseLineNoL <> 0) then
                PurchaseLineNoL := InterfaceEntryLineVIP."External Order Line No." * 10000;
            PurchaseLineL.INIT();
            PurchaseLineL."Document Type" := PurchaseHeader."Document Type";
            PurchaseLineL."Document No." := PurchaseHeader."No.";
            PurchaseLineL."Line No." := PurchaseLineNoL;
            PurchaseLineL."Zycus Order No. FND" := InterfaceEntryLineVIP."External Order No.";
            PurchaseLineL."Zycus Order Line No. FND" := InterfaceEntryLineVIP."External Order Line No.";
            PurchaseLineL."Zycus PO Type Code FND" := InterfaceEntryLineVIP."Traceability Code";
            PurchaseLineL."Zycus PO Line Type Code FND" := InterfaceEntryLineVIP."Severity Code";
            PurchaseLineL.INSERT(true);
        end else begin
            ReleasePurchaseDocumentL.Reopen(PurchaseHeader);
        end;
        PurchaseLineL.RESET();
        if InterfaceEntryLineVIP."Action Code" = ZycusInterfaceSetup."Zycus Create Action Code" then begin
            PurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", "Line No.", "Zycus Order No. FND", "Zycus Order Line No. FND");
            PurchaseLineL.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLineL.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIP."External Order No.");
            PurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIP."External Order Line No.");
            PurchaseLineL.FINDFIRST();
        end else begin
            PurchaseLineL.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLineL.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLineL.SETRANGE("Line No.", PurchaseLine."Line No.");
            PurchaseLineL.FINDFIRST();
        end;
        PurchaseLineL."Zycus PO Type Code FND" := InterfaceEntryLineVIP."Traceability Code";
        PurchaseLineL."Zycus PO Line Type Code FND" := InterfaceEntryLineVIP."Severity Code";
        if PurchaseLineL."Zycus PO Type Code FND" <> ZycusInterfaceSetup."Zycus Normal PO Code" then begin
            if PurchaseLineL."Zycus PO Type Code FND" <> ZycusInterfaceSetup."Zycus Limit PO Code" then
                ERROR(Text015, PurchaseLineL.FIELDCAPTION("Zycus PO Type Code FND"), PurchaseLineL."Zycus PO Type Code FND", ZycusInterfaceSetup.TABLECAPTION);
        end else if PurchaseLineL."Zycus PO Type Code FND" <> ZycusInterfaceSetup."Zycus Limit PO Code" then begin
            if PurchaseLineL."Zycus PO Type Code FND" <> ZycusInterfaceSetup."Zycus Normal PO Code" then
                ERROR(Text015, PurchaseLineL.FIELDCAPTION("Zycus PO Type Code FND"), PurchaseLineL."Zycus PO Type Code FND", ZycusInterfaceSetup.TABLECAPTION);
        end;
        PurchaseHeaderAddL.GET(PurchaseHeader."Document Type", PurchaseHeader."No.");
        if PurchaseLineL."Zycus PO Type Code FND" = ZycusInterfaceSetup."Zycus Normal PO Code" then begin
            if PurchaseHeaderAddL."Limit PO" then
                PurchaseHeaderAddL."Limit PO" := false;
        end else if PurchaseLineL."Zycus PO Type Code FND" = ZycusInterfaceSetup."Zycus Limit PO Code" then begin
            if not PurchaseHeaderAddL."Limit PO" then
                PurchaseHeaderAddL."Limit PO" := true;
        end;
        PurchaseHeaderAddL.MODIFY(false);
        if InterfaceEntryLineVIP."Global No." <> '' then begin
            if PurchaseLineL."Zycus PO Line Type Code FND" = '' then
                ItemL.GET(InterfaceEntryLineVIP."Global No.");
            if ItemL.GET(InterfaceEntryLineVIP."Global No.") then begin
                ItemL.TESTFIELD(Blocked, false);
                if PurchaseHeaderAddL."Limit PO" then
                    ERROR(Text016, PurchaseHeaderAddL.FIELDCAPTION("Limit PO"), FORMAT(PurchaseLineL.Type::Item));
                if (PurchaseLineL."Qty. Rcd. Not Invoiced" = 0) and (PurchaseLineL."Quantity Received" = 0) then begin
                    PurchaseLineL.VALIDATE(Type, PurchaseLineL.Type::Item);
                    PurchaseLineL.VALIDATE("No.", InterfaceEntryLineVIP."Global No.");
                end;
                if InterfaceEntryLineVIP."Fixed Asset No." <> '' then begin
                    CLEAR(ConcatDimValCodeL);
                    ConcatDimValCodeL := InterfaceEntryLineVIP."Fixed Asset No.";
                    ZycusDimensionValueMappingL.SETCURRENTKEY("Dimension Code HeiLite", "Dimension Value Code Zycus");
                    ZycusDimensionValueMappingL.SETRANGE("Dimension Code HeiLite", ZycusInterfaceSetup."Zycus PO CONCAT Dimention Code");
                    ZycusDimensionValueMappingL.SETRANGE("Dimension Value Code Zycus", InterfaceEntryLineVIP."Fixed Asset No.");
                    if ZycusDimensionValueMappingL.FINDFIRST() then
                        ConcatDimValCodeL := ZycusDimensionValueMappingL."Dimension Value Code HeiLite";
                    if DimensionValueL.GET(ZycusInterfaceSetup."Zycus PO CONCAT Dimention Code", ConcatDimValCodeL) then begin
                        FoundInConcat := true;
                    end;
                end;
                FoundInItemL := true;
            end;
        end;
        if not FoundInItemL and (InterfaceEntryLineVIP."Fixed Asset No." <> '') then begin
            if PurchaseLineL."Zycus PO Line Type Code FND" = '' then
                ERROR(Text011, Text021);
            ZycusPOLineTypeMappingL.SETRANGE("PO Line Type Code", PurchaseLineL."Zycus PO Line Type Code FND");
            ZycusPOLineTypeMappingL.SETRANGE("Line Type", ZycusPOLineTypeMappingL."Line Type"::"Fixed Asset");
            ZycusPOLineTypeMappingL.SETRANGE("CCC Marked", false);
            ZycusPOLineTypeMappingL.SETRANGE("CONCAT Marked", false);
            if not ZycusPOLineTypeMappingL.ISEMPTY then begin
                CLEAR(ConcatDimValCodeL);
                ConcatDimValCodeL := InterfaceEntryLineVIP."Fixed Asset No.";
                ZycusDimensionValueMappingL.RESET();
                ZycusDimensionValueMappingL.SETCURRENTKEY("Dimension Code HeiLite", "Dimension Value Code Zycus");
                ZycusDimensionValueMappingL.SETRANGE("Dimension Code HeiLite", ZycusInterfaceSetup."Zycus PO CONCAT Dimention Code");
                ZycusDimensionValueMappingL.SETRANGE("Dimension Value Code Zycus", InterfaceEntryLineVIP."Fixed Asset No.");
                if ZycusDimensionValueMappingL.FINDFIRST() then
                    ConcatDimValCodeL := ZycusDimensionValueMappingL."Dimension Value Code HeiLite";
                if DimensionValueL.GET(ZycusInterfaceSetup."Zycus PO CONCAT Dimention Code", ConcatDimValCodeL) then begin
                    FoundInConcat := true;
                end;
                if FixedAssetL.GET(ConcatDimValCodeL) then begin
                    FixedAssetL.TESTFIELD(Blocked, false);
                    if PurchaseHeaderAddL."Limit PO" then
                        ERROR(Text016, PurchaseHeaderAddL.FIELDCAPTION("Limit PO"), FORMAT(PurchaseLineL.Type::"Fixed Asset"));
                    if (PurchaseLineL."Qty. Rcd. Not Invoiced" = 0) and (PurchaseLineL."Quantity Received" = 0) then begin
                        PurchaseLineL.VALIDATE(Type, InterfaceEntryLineVIP.Type::"Fixed Asset");
                        PurchaseLineL.VALIDATE("No.", ConcatDimValCodeL);
                    end;
                    FoundInFAL := true;

                    // BC Upgrade MISHRS14 >>
                    //HEI.11>>
                    CLEAR(FoundInConcat);
                    //HEI.11<<
                    // BC Upgrade MISHRS14 <<

                end;
            end;
        end;
        if not (FoundInItemL or FoundInFAL) and (InterfaceEntryLineVIP."Part Group-2" <> '') then begin
            if PurchaseLineL."Zycus PO Line Type Code FND" = '' then
                ERROR(Text011, Text021);
            GLAccountL.GET(InterfaceEntryLineVIP."Part Group-2");
            GLAccountL.TESTFIELD(Blocked, false);
            ZycusPOLineTypeMappingL.RESET();
            ZycusPOLineTypeMappingL.SETRANGE("PO Line Type Code", PurchaseLineL."Zycus PO Line Type Code FND");
            ZycusPOLineTypeMappingL.SETRANGE("Line Type", ZycusPOLineTypeMappingL."Line Type"::"G/L Account");
            ZycusPOLineTypeMappingL.SETRANGE("CCC Marked", false);
            ZycusPOLineTypeMappingL.SETRANGE("CONCAT Marked", false);
            if not ZycusPOLineTypeMappingL.ISEMPTY then begin
                if (PurchaseLineL."Qty. Rcd. Not Invoiced" = 0) and (PurchaseLineL."Quantity Received" = 0) then begin
                    PurchaseLineL.VALIDATE(Type, PurchaseLineL.Type::"G/L Account");
                    PurchaseLineL.VALIDATE("No.", InterfaceEntryLineVIP."Part Group-2");
                end;
                FoundInGLL := true;
            end else begin
                ZycusPOLineTypeMappingL.SETRANGE("CCC Marked", true);
                ZycusPOLineTypeMappingL.SETRANGE("CONCAT Marked", false);
                if not ZycusPOLineTypeMappingL.ISEMPTY then begin
                    InterfaceEntryLineVIP.TESTFIELD("Ccc Code");
                    DimensionValueL.GET(ZycusInterfaceSetup."Zycus PO CCC Dimention Code", InterfaceEntryLineVIP."Ccc Code");
                    if (PurchaseLineL."Qty. Rcd. Not Invoiced" = 0) and (PurchaseLineL."Quantity Received" = 0) then begin
                        PurchaseLineL.VALIDATE(Type, PurchaseLineL.Type::"G/L Account");
                        PurchaseLineL.VALIDATE("No.", InterfaceEntryLineVIP."Part Group-2");
                    end;
                    FoundInGLL := true;
                end else begin
                    ZycusPOLineTypeMappingL.SETRANGE("CCC Marked", false);
                    ZycusPOLineTypeMappingL.SETRANGE("CONCAT Marked", true);
                    ZycusPOLineTypeMappingL.FINDFIRST();
                    InterfaceEntryLineVIP.TESTFIELD("Fixed Asset No.");
                    CLEAR(ConcatDimValCodeL);
                    ConcatDimValCodeL := InterfaceEntryLineVIP."Fixed Asset No.";
                    ZycusDimensionValueMappingL.SETCURRENTKEY("Dimension Code HeiLite", "Dimension Value Code Zycus");
                    ZycusDimensionValueMappingL.SETRANGE("Dimension Code HeiLite", ZycusInterfaceSetup."Zycus PO CONCAT Dimention Code");
                    ZycusDimensionValueMappingL.SETRANGE("Dimension Value Code Zycus", InterfaceEntryLineVIP."Fixed Asset No.");
                    if ZycusDimensionValueMappingL.FINDFIRST() then
                        ConcatDimValCodeL := ZycusDimensionValueMappingL."Dimension Value Code HeiLite";
                    DimensionValueL.GET(ZycusInterfaceSetup."Zycus PO CONCAT Dimention Code", ConcatDimValCodeL);
                    if (PurchaseLineL."Qty. Rcd. Not Invoiced" = 0) and (PurchaseLineL."Quantity Received" = 0) then begin
                        PurchaseLineL.VALIDATE(Type, PurchaseLineL.Type::"G/L Account");
                        PurchaseLineL.VALIDATE("No.", InterfaceEntryLineVIP."Part Group-2");
                    end;
                    FoundInConcat := true;
                    FoundInGLL := true;
                end;
            end;
        end;
        PurchaseLineL.TESTFIELD("No.");
        if PurchaseLineL.Type in [PurchaseLineL.Type::" ", PurchaseLineL.Type::"Charge (Item)"] then begin
            if PurchaseLineL.Type = PurchaseLineL.Type::" " then
                LineTypeL := Text025
            else
                LineTypeL := FORMAT(PurchaseLineL.Type::"Charge (Item)");
            ERROR(Text005, PurchaseLineL.TABLECAPTION, PurchaseLineL.FIELDCAPTION(Type), LineTypeL);
        end;
        if PurchaseLineL.Type in [PurchaseLineL.Type::"G/L Account", PurchaseLineL.Type::"Fixed Asset"] then begin
            if PurchaseHeaderAddL."Import Identifier" then begin
                CLEAR(PurchaseHeaderAddL);
                PurchaseHeaderAddL.GET(PurchaseHeader."Document Type", PurchaseHeader."No.");
                if PurchaseHeaderAddL."Import Identifier" then begin
                    PurchaseHeaderAddL."Import Identifier" := false;
                    PurchaseHeaderAddL.MODIFY(false);
                end;
            end;
        end;
        CreatePurchaseOrderForGLorFA_Zycus(PurchaseLineL);
        PurchaseLineL."Dimension Set ID" := CheckAndCreateDimensionsAndComponentDimensions_Zycus(InterfaceEntryLineVIP, PurchaseLineL);
        if PurchaseLineL."Dimension Set ID" <> 0 then begin
            if DimensionSetEntryL.GET(PurchaseLineL."Dimension Set ID", GLSetup."Global Dimension 1 Code") then
                PurchaseLineL.VALIDATE("Shortcut Dimension 1 Code", DimensionSetEntryL."Dimension Value Code");

            // BC Upgrade MISHRS14 >> #HEI.30
            //HEI.30>>
            CLEAR(DimensionSetEntryL);
            IF DimensionSetEntryL.GET(PurchaseLineL."Dimension Set ID", GLSetup."Global Dimension 2 Code") THEN
                PurchaseLineL.VALIDATE("Shortcut Dimension 2 Code", DimensionSetEntryL."Dimension Value Code");
            //HEI.30<<
            // BC Upgrade MISHRS14 <<

        end;
        if InterfaceEntryLineVIP."Ccc Code" <> '' then
            PurchaseLineL.VALIDATE("Shortcut Dimension 2 Code", InterfaceEntryLineVIP."Ccc Code");
        if InterfaceEntryLineVIP."CMG Code" <> '' then begin
            PurchaseLineL."CMG Code FND" := InterfaceEntryLineVIP."CMG Code";
            if PurchaseLineL.Type = PurchaseLineL.Type::Item then
                PurchaseLineL.ValidateShortcutDimCode(5, InterfaceEntryLineVIP."CMG Code");
        end;
        if not VATPostingSetupL.GET(PurchaseLineL."VAT Bus. Posting Group", PurchaseLineL."VAT Prod. Posting Group") then
            ERROR(Text006, VATPostingSetupL.TABLECAPTION, PurchaseLineL."VAT Bus. Posting Group", PurchaseLineL."VAT Prod. Posting Group", PurchaseLineL.Type, PurchaseLineL."No.");
        PurchaseLineL.Description := InterfaceEntryLineVIP.Description;
        if InterfaceEntryLineVIP."Location Code" <> '' then begin
            LocationL.GET(InterfaceEntryLineVIP."Location Code");
            PurchaseHeader.SetHideValidationDialog(true);
            if InterfaceEntryLineVIP."Location Code" <> PurchaseHeader."Location Code" then begin
                PurchaseHeader.VALIDATE("Location Code", InterfaceEntryLineVIP."Location Code");
                PurchaseHeader.MODIFY(false);
            end;
            if PurchaseHeaderAddL."Import Identifier" then
                PurchaseLineL.VALIDATE("Location Code", PurchPaySetup."Location Code Imp Proc. FND")
            else
                PurchaseLineL.VALIDATE("Location Code", InterfaceEntryLineVIP."Location Code");
        end;
        if InterfaceEntryLineVIP."Unit of Measure Code" <> '' then begin
            if (PurchaseLineL."Qty. Rcd. Not Invoiced" = 0) and (PurchaseLineL."Quantity Received" = 0) then
                PurchaseLineL.VALIDATE("Unit of Measure Code", GetISOCodeUnitOfMeasure_Zycus(InterfaceEntryLineVIP."Unit of Measure Code"));
        end;
        if InterfaceEntryLineVIP.Quantity <> 0 then begin
            if InterfaceEntryLineVIP."Action Code" = ZycusInterfaceSetup."Zycus Update Action Code" then begin
                if PurchaseLineL.Type in [PurchaseLineL.Type::"G/L Account", PurchaseLineL.Type::"Fixed Asset"] then begin
                    ReturnQuantityL := GetPurchaseReturnQuantity_Zycus(PurchaseLineL);
                end;
            end;
            if (not IsPurchaseReceiptExist_Zycus(PurchaseLineL)) or (PurchaseLineL.Quantity <> InterfaceEntryLineVIP.Quantity) then begin
                if PurchaseLineL."Quantity Received" > InterfaceEntryLineVIP.Quantity + ReturnQuantityL then
                    ERROR(Text017, InterfaceEntryLineVIP.FIELDCAPTION(Quantity), InterfaceEntryLineVIP.Quantity,
                      PurchaseLineL.FIELDCAPTION("Quantity Received"), PurchaseLineL."Quantity Received", PurchaseLineL."Document No.", PurchaseLineL."Line No.");
                PurchaseLineL.VALIDATE(Quantity, InterfaceEntryLineVIP.Quantity + ReturnQuantityL);
            end;
        end else begin
            if not IsPurchaseReceiptExist_Zycus(PurchaseLineL) then begin
                PurchaseLineL.VALIDATE(Quantity, 1 + ReturnQuantityL);
            end;
        end;
        PurchaseLineL.VALIDATE("Qty. to Receive", 0);
        PurchaseLineL.VALIDATE("Qty. to Invoice", 0);
        PurchaseLineL."Currency Code" := PurchaseHeader."Currency Code";
        if (PurchaseLineL."Zycus PO Type Code FND" = '') or (PurchaseLineL."Zycus PO Line Type Code FND" = '') then begin
            PurchaseLineL."Zycus PO Type Code FND" := InterfaceEntryLineVIP."Traceability Code";
            PurchaseLineL."Zycus PO Line Type Code FND" := InterfaceEntryLineVIP."Severity Code";
        end;
        if InterfaceEntryLineVIP."Line Amount" <> 0 then begin
            if PurchaseLineL."Zycus PO Type Code FND" = ZycusInterfaceSetup."Zycus Limit PO Code" then begin
                PurchaseHeaderAddL.TESTFIELD("Limit PO", true);
                if (PurchaseLineL.Type = PurchaseLineL.Type::"G/L Account") and (InterfaceEntryLineVIP."Part Group-2" <> '') and (PurchaseLineL.Quantity <> 0) then begin
                    if InterfaceEntryLineVIP."Action Code" = ZycusInterfaceSetup."Zycus Update Action Code" then begin
                        PrevUnitCostL := PurchaseLineL."Direct Unit Cost";
                        LimitPOUnitCostL := InterfaceEntryLineVIP."Line Amount";
                    end;
                    PurchaseLineL.VALIDATE("Direct Unit Cost", InterfaceEntryLineVIP."Line Amount");
                end;
            end else if PurchaseLineL."Zycus PO Type Code FND" = ZycusInterfaceSetup."Zycus Normal PO Code" then begin
                PurchaseHeaderAddL.TESTFIELD("Limit PO", false);
                // BC Upgrade NANDIS03 - Blocked as DIT dependency >>
                // if (PurchaseLineL.Type = PurchaseLineL.Type::Item) and (InterfaceEntryLineVIP."Global No." <> '') and (PurchaseLineL.Quantity <> 0) then
                //     PurchaseLineL."Item Charge Value" := InterfaceEntryLineVIP."Line Amount";
                // BC Upgrade NANDIS03 - Blocked as DIT dependency <<
                PurchaseLineL.VALIDATE("Direct Unit Cost", InterfaceEntryLineVIP."Line Amount");
            end;
        end;
        if PurchaseHeaderAddL."Limit PO" then begin
            if CheckAdditionalLines_Zycus(PurchaseHeader."No.", InterfaceEntryLineVIP."External Order Line No.") then begin
                PurchaseLineL.VALIDATE("Direct Unit Cost", PrevUnitCostL);
                PurchaseLineL."Remaining Amount FND" := LimitPOUnitCostL - FindLinesUnitCost_Zycus(PurchaseHeader."No.", InterfaceEntryLineVIP."External Order Line No.", true) - PrevUnitCostL;
                PurchaseLineL."Initial Amount FND" := LimitPOUnitCostL;
                UpdateLastOpenLine_Zycus(PurchaseHeader."No.", InterfaceEntryLineVIP, PurchaseLineL, PrevUnitCostL);
            end else begin
                PurchaseLineL."Initial Amount FND" := PurchaseLineL."Line Amount";
                PurchaseLineL."Remaining Amount FND" := PurchaseLineL."Line Amount";
            end;
        end;
        PurchaseLineL."SRM Contract No. FND" := PurchaseHeader."SRM Contract No. FND";
        PurchaseLineL."SRM Order No. FND" := InterfaceEntryLineVIP."External Order No.";
        PurchaseLineL."SRM Order Line No. FND" := FORMAT(InterfaceEntryLineVIP."External Order Line No.");
        PurchaseLineL.VALIDATE("Expected Receipt Date", InterfaceEntryLineVIP."Expected Receipt Date");
        CLEAR(PurchaseHeaderAddL);
        PurchaseHeaderAddL.GET(PurchaseHeader."Document Type", PurchaseHeader."No.");
        if PurchaseHeaderAddL."Import Identifier" then begin
            PurchaseHeader.TESTFIELD("Location Code");
            PurchaseHeaderAddL."Exp Physical Del Date(Imp)" := PurchaseLineL."Expected Receipt Date";
            PurchaseHeaderAddL.MODIFY(false);
            PurchaseLineL.VALIDATE("Exp Physical Del Date(Imp) FND", PurchaseLineL."Expected Receipt Date");
        end;
        // PurchaseLineL."Requester ID" := PurchaseHeader."Requester ID";  // BC Upgrade NANDIS03 - Blocked as DIT dependency
        PurchaseLineL."Requesters ID FND" := PurchaseHeader."Requester ID IBM FND";  //BC Upgrade SHARMP16--Zycus

        if PurchaseLineL.Type in [PurchaseLineL.Type::"G/L Account", PurchaseLineL.Type::"Fixed Asset"] then begin
            CheckDimValueOnPOCreation_Zycus(PurchaseLineL);
            CheckMandatoryFieldsOnPOCreation_Zycus(PurchaseLineL);
        end;
        if InterfaceEntryLineVIP.Blocked then
            PurchaseLineL."Block Line Ordering FND" := PurchaseLineL."Block Line Ordering FND"::B;
        if PurchaseLineL."Outstanding Quantity" = 0 then
            PurchaseLineL.VALIDATE("Delivery Finalized FND", true)
        else
            PurchaseLineL.VALIDATE("Delivery Finalized FND", InterfaceEntryLineVIP."Delivery Finalized");
        PurchaseLineL."Zycus Order No. FND" := InterfaceEntryLineVIP."External Order No.";
        PurchaseLineL."Zycus Order Line No. FND" := InterfaceEntryLineVIP."External Order Line No.";
        PurchaseLineL."Zycus PR Reference No. FND" := InterfaceEntryLineVIP."External Document No.";
        PurchaseLineL."Zycus PO Type Code FND" := InterfaceEntryLineVIP."Traceability Code";
        PurchaseLineL."Zycus PO Line Type Code FND" := InterfaceEntryLineVIP."Severity Code";
        PurchaseLineL."Zycus PO Line Validated FND" := true;
        PurchaseLineL.MODIFY(true);
        //HEI.03<<
    end;

    local procedure IsPurchaseReceiptExist_Zycus(var PurchaseLine: Record "Purchase Line"): Boolean;
    var
        PurchRcptLineL: Record "Purch. Rcpt. Line";
    begin
        //HEI.03>>
        PurchRcptLineL.SETCURRENTKEY("Order No.", "Order Line No.");
        PurchRcptLineL.SETRANGE("Order No.", PurchaseLine."Document No.");
        PurchRcptLineL.SETRANGE("Order Line No.", PurchaseLine."Line No.");
        if not PurchRcptLineL.ISEMPTY then
            exit(true)
        else
            exit(false);
        //HEI.03<<
    end;

    local procedure CheckAdditionalLines_Zycus(PONo: Code[20]; ExternalOrderLineNo: Integer): Boolean;
    var
        ClosedPurchaseLineL: Record "Purchase Line";
    begin
        //HEI.03>>
        ClosedPurchaseLineL.SETCURRENTKEY("Document No.", "Additional Description FND");
        ClosedPurchaseLineL.SETRANGE("Document No.", PONo);
        ClosedPurchaseLineL.SETRANGE("Additional Description FND", FORMAT(ExternalOrderLineNo));
        if not ClosedPurchaseLineL.ISEMPTY then
            exit(true)
        else
            exit(false);
        //HEI.03<<
    end;

    local procedure FindLinesUnitCost_Zycus(PONo: Code[20]; ExternalOrderLineNo: Integer; Received: Boolean) TotalUnitCost: Decimal;
    var
        ClosedPurchaseLineL: Record "Purchase Line";
    begin
        //HEI.03>>
        ClosedPurchaseLineL.SETCURRENTKEY("Document No.", "Additional Description FND", "Quantity Received");
        ClosedPurchaseLineL.SETRANGE("Document No.", PONo);
        ClosedPurchaseLineL.SETRANGE("Additional Description FND", FORMAT(ExternalOrderLineNo));
        if Received then
            ClosedPurchaseLineL.SETFILTER("Quantity Received", '<>0');
        if ClosedPurchaseLineL.findset(false) then
            repeat
                TotalUnitCost += ClosedPurchaseLineL."Direct Unit Cost";
            until ClosedPurchaseLineL.NEXT() = 0;
        exit(TotalUnitCost);
        //HEI.03<<
    end;

    local procedure UpdateLastOpenLine_Zycus(PONo: Code[20]; InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT"; PurchaseLine: Record "Purchase Line"; PreUnitCost: Decimal);
    var
        LastPurchaseLineL: Record "Purchase Line";
    begin
        //HEI.03>>
        LastPurchaseLineL.SETCURRENTKEY("Document No.", "Additional Description FND", "Quantity Received");
        LastPurchaseLineL.SETRANGE("Document No.", PONo);
        LastPurchaseLineL.SETRANGE("Additional Description FND", FORMAT(InterfaceEntryLineVIP."External Order Line No."));
        LastPurchaseLineL.SETRANGE("Quantity Received", 0);
        if LastPurchaseLineL.FINDLAST() then begin
            LastPurchaseLineL.VALIDATE("Direct Unit Cost", PurchaseLine."Remaining Amount FND");
            LastPurchaseLineL."Remaining Amount FND" := PurchaseLine."Remaining Amount FND";
            LastPurchaseLineL.VALIDATE("Delivery Finalized FND", InterfaceEntryLineVIP."Delivery Finalized");
            LastPurchaseLineL."Dimension Set ID" := PurchaseLine."Dimension Set ID";
            LastPurchaseLineL.VALIDATE("Shortcut Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
            LastPurchaseLineL.VALIDATE("Shortcut Dimension 2 Code", PurchaseLine."Shortcut Dimension 2 Code");
            if LastPurchaseLineL.Type = LastPurchaseLineL.Type::Item then
                LastPurchaseLineL.ValidateShortcutDimCode(5, PurchaseLine."CMG Code FND");
            LastPurchaseLineL.MODIFY(false);
        end;
        //HEI.03<<
    end;

    local procedure CheckAndCreateDimensionsAndComponentDimensions_Zycus(var InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT"; var PurchaseLine: Record "Purchase Line"): Integer;
    var
        DimensionValueL: Record "Dimension Value";
        TempDimensionSetEntryL: Record "Dimension Set Entry" temporary;
        DefaultDimensionL: Record "Default Dimension";
        DimensionValueComponentL: Record "Dimension Value Component FND";
        DimensionValueL2: Record "Dimension Value";
        DimensionManagementL: Codeunit DimensionManagement;
        TempDimensionSetEntryOldL: Record "Dimension Set Entry" temporary;
        DimensionSetEntryL: Record "Dimension Set Entry";
        ZycusDimensionValueMappingL: Record "Zycus Dim Value Mapping INT";
        ConcatDimValCodeL: Code[20];

        // BC Upgrade MISHRS14 >> #HEI.29
        CMGDimValCodeL: Code[20];
        CMGDimValIDL: Integer;
    // BC Upgrade MISHRS14 <<

    begin
        //HEI.03>>
        DefaultDimensionL.SETCURRENTKEY("Table ID", "No.", "Dimension Value Code", "Dimension Code");
        case PurchaseLine.Type of
            PurchaseLine.Type::Item:
                DefaultDimensionL.SETRANGE("Table ID", DATABASE::Item);
            PurchaseLine.Type::"Fixed Asset":
                DefaultDimensionL.SETRANGE("Table ID", DATABASE::"Fixed Asset");
            PurchaseLine.Type::"G/L Account":
                DefaultDimensionL.SETRANGE("Table ID", DATABASE::"G/L Account");
        end;
        DefaultDimensionL.SETRANGE("No.", PurchaseLine."No.");
        DefaultDimensionL.SETFILTER("Dimension Value Code", '<>%1', '');

        if InterfaceEntryLineVIP."CMG Code" <> '' then begin
            DimensionValueL.GET(ZycusInterfaceSetup."Zycus PO CMG Dimention Code", InterfaceEntryLineVIP."CMG Code");

            DefaultDimensionL.SETRANGE("Dimension Code", DimensionValueL."Dimension Code");
            if DefaultDimensionL.FINDFIRST() then begin
                if DefaultDimensionL."Dimension Value Code" <> DimensionValueL.Code then

                    // BC Upgrade MISHRS14 >> #HEI.29
                    //HEI.29>>
                    IF (ZycusInterfaceSetup."Zycus PO CMG Dimention Code" <> ZycusInterfaceSetup."Exclude Dimension Matching") OR
                    (DefaultDimensionL."Value Posting" = DefaultDimensionL."Value Posting"::"Same Code") THEN
                        //HEI.29<<
                        // BC Upgrade MISHRS14 <<

                    ERROR(Text027, DimensionValueL.Code, DimensionValueL."Dimension Code", DefaultDimensionL."Dimension Value Code", DefaultDimensionL."Table ID", PurchaseLine."No.");
            end;

            TempDimensionSetEntryL.INIT();
            TempDimensionSetEntryL."Dimension Set ID" := -1;
            TempDimensionSetEntryL."Dimension Code" := DimensionValueL."Dimension Code";
            TempDimensionSetEntryL."Dimension Value Code" := DimensionValueL.Code;
            TempDimensionSetEntryL."Dimension Value ID" := DimensionValueL."Dimension Value ID";
            TempDimensionSetEntryL.INSERT(false);

            // BC Upgrade MISHRS14>> #HEI.29
            //HEI.29>>
            // END;
        end else begin
            DefaultDimensionL.SETRANGE("Dimension Code", ZycusInterfaceSetup."Zycus PO CMG Dimention Code");
            IF DefaultDimensionL.FINDFIRST THEN begin
                IF (DefaultDimensionL."Value Posting" = DefaultDimensionL."Value Posting"::"Same Code") THEN
                    ERROR(Text046);
            end ELSE begin
                DefaultDimensionL.SETRANGE("Dimension Value Code", '');
                DefaultDimensionL.SETRANGE("Dimension Code", ZycusInterfaceSetup."Zycus PO CMG Dimention Code");
                IF DefaultDimensionL.FINDFIRST THEN
                    ERROR(Text046);
            end;
            DefaultDimensionL.SETFILTER("Dimension Value Code", '<>%1', '');
            DefaultDimensionL.SETRANGE("Dimension Code");
        end;

        //HEI.29<<
        // BC Upgrade MISHRS14 <<

        //end;
        if InterfaceEntryLineVIP."Ccc Code" <> '' then begin
            CLEAR(DimensionValueL);
            DimensionValueL.GET(ZycusInterfaceSetup."Zycus PO CCC Dimention Code", InterfaceEntryLineVIP."Ccc Code");

            DefaultDimensionL.SETRANGE("Dimension Code", DimensionValueL."Dimension Code");
            if DefaultDimensionL.FINDFIRST() then begin
                if DefaultDimensionL."Dimension Value Code" <> DimensionValueL.Code then
                    ERROR(Text027, DimensionValueL.Code, DimensionValueL."Dimension Code", DefaultDimensionL."Dimension Value Code", DefaultDimensionL."Table ID", PurchaseLine."No.");
            end;

            TempDimensionSetEntryL.INIT();
            TempDimensionSetEntryL."Dimension Set ID" := -1;
            TempDimensionSetEntryL."Dimension Code" := DimensionValueL."Dimension Code";
            TempDimensionSetEntryL."Dimension Value Code" := DimensionValueL.Code;
            TempDimensionSetEntryL."Dimension Value ID" := DimensionValueL."Dimension Value ID";
            TempDimensionSetEntryL.INSERT(false);
        end;
        if FoundInConcat and (InterfaceEntryLineVIP."Fixed Asset No." <> '') then begin
            CLEAR(DimensionValueL);
            CLEAR(ConcatDimValCodeL);
            ConcatDimValCodeL := InterfaceEntryLineVIP."Fixed Asset No.";
            ZycusDimensionValueMappingL.SETCURRENTKEY("Dimension Code HeiLite", "Dimension Value Code Zycus");
            ZycusDimensionValueMappingL.SETRANGE("Dimension Code HeiLite", ZycusInterfaceSetup."Zycus PO CONCAT Dimention Code");
            ZycusDimensionValueMappingL.SETRANGE("Dimension Value Code Zycus", InterfaceEntryLineVIP."Fixed Asset No.");
            if ZycusDimensionValueMappingL.FINDFIRST() then
                ConcatDimValCodeL := ZycusDimensionValueMappingL."Dimension Value Code HeiLite";
            DimensionValueL.GET(ZycusInterfaceSetup."Zycus PO CONCAT Dimention Code", ConcatDimValCodeL);

            TempDimensionSetEntryL.INIT();
            TempDimensionSetEntryL."Dimension Set ID" := -1;
            TempDimensionSetEntryL."Dimension Code" := DimensionValueL."Dimension Code";
            TempDimensionSetEntryL."Dimension Value Code" := DimensionValueL.Code;
            TempDimensionSetEntryL."Dimension Value ID" := DimensionValueL."Dimension Value ID";
            TempDimensionSetEntryL.INSERT(false);

            DimensionValueComponentL.SETCURRENTKEY("Dimension 1 Code", "Dimension 1 Value Code");
            DimensionValueComponentL.SETRANGE("Dimension 1 Code", DimensionValueL."Dimension Code");
            DimensionValueComponentL.SETRANGE("Dimension 1 Value Code", DimensionValueL.Code);
            if DimensionValueComponentL.ISEMPTY then
                ERROR(Text026, DimensionValueL.Code, DimensionValueL."Dimension Code", DimensionValueComponentL.TABLECAPTION, PurchaseLine."Line No.", FORMAT(PurchaseLine.Type), PurchaseLine."No.")
            else if DimensionValueComponentL.findset(false) then begin
                repeat
                    // BC Upgrade MISHRS14 >> #HEI.29
                    //HEI.29>>
                    TempDimensionSetEntryL.RESET;
                    TempDimensionSetEntryL.SETCURRENTKEY("Dimension Code");
                    TempDimensionSetEntryL.SETRANGE("Dimension Code", DimensionValueComponentL."Dimension 2 Code");
                    IF TempDimensionSetEntryL.ISEMPTY THEN BEGIN
                        //HEI.29<<
                        // BC Upgrade MISHRS14 <<

                        DefaultDimensionL.SETRANGE("Dimension Code", DimensionValueComponentL."Dimension 2 Code");
                        if DefaultDimensionL.FINDFIRST() then begin

                            // BC Upgrade MISHRS14 >>
                            //HEI.29>>
                            // IF DefaultDimensionL."Dimension Value Code" <> DimensionValueComponentL."Dimension 2 Value Code" THEN BEGIN
                            IF (DefaultDimensionL."Dimension Value Code" <> DimensionValueComponentL."Dimension 2 Value Code") AND
                            (DefaultDimensionL."Value Posting" = DefaultDimensionL."Value Posting"::"Same Code") AND (ZycusInterfaceSetup."Zycus PO CMG Dimention Code" <> ZycusInterfaceSetup."Exclude Dimension Matching") THEN BEGIN
                                //HEI.29<<
                                //if DefaultDimensionL."Dimension Value Code" <> DimensionValueComponentL."Dimension 2 Value Code" then begin
                                // BC Upgrade MISHRS14 <<

                                ERROR(Text028, DimensionValueComponentL."Dimension 2 Value Code", DimensionValueComponentL."Dimension 2 Code",
                                DefaultDimensionL."Dimension Value Code", FORMAT(PurchaseLine.Type), PurchaseLine."No.", DimensionValueL."Dimension Code", DimensionValueL.Code);
                            end else begin
                                if (DefaultDimensionL."Dimension Code" = ZycusInterfaceSetup."Zycus PO CMG Dimention Code") and (InterfaceEntryLineVIP."CMG Code" <> '') then begin
                                    if DefaultDimensionL."Dimension Value Code" <> InterfaceEntryLineVIP."CMG Code" then begin
                                        ERROR(Text028, InterfaceEntryLineVIP."CMG Code", DimensionValueComponentL."Dimension 2 Code",
                                        DefaultDimensionL."Dimension Value Code", FORMAT(PurchaseLine.Type), PurchaseLine."No.", DimensionValueL."Dimension Code", DimensionValueL.Code);
                                    end;
                                end;
                            end;
                        end else begin
                            CLEAR(DimensionValueL2);
                            DimensionValueL2.GET(DimensionValueComponentL."Dimension 2 Code", DimensionValueComponentL."Dimension 2 Value Code");
                            if TempDimensionSetEntryL.GET(TempDimensionSetEntryL."Dimension Set ID", ZycusInterfaceSetup."Zycus PO CONCAT Dimention Code") then begin

                                // BC Upgrade MISHRS14 >>
                                //HEI.11>> 
                                IF TempDimensionSetEntryL."Dimension Value Code" <> ConcatDimValCodeL THEN
                                    //HEI.11<<
                                    // BC Upgrade MISHRS14 <<

                                    if TempDimensionSetEntryL."Dimension Value Code" <> InterfaceEntryLineVIP."Fixed Asset No." then
                                        TempDimensionSetEntryL.DELETE(false);
                            end;

                            TempDimensionSetEntryL.INIT();
                            TempDimensionSetEntryL."Dimension Code" := DimensionValueL2."Dimension Code";
                            TempDimensionSetEntryL."Dimension Value Code" := DimensionValueL2.Code;
                            TempDimensionSetEntryL."Dimension Value ID" := DimensionValueL2."Dimension Value ID";
                            TempDimensionSetEntryL.INSERT(false);
                        end;

                        // BC Upgrade MISHRS14 >> #HEI.29
                        //HEI.29>>
                    END;
                //HEI.29<<
                // BC Upgrade MISHRS14 <<

                until DimensionValueComponentL.NEXT() = 0;
            end;
        end;

        // BC Upgrade MISHRS14 >>
        //HEI.29>>
        IF (InterfaceEntryLineVIP."CMG Code" <> '') THEN BEGIN
            TempDimensionSetEntryL.RESET;
            TempDimensionSetEntryL.SETCURRENTKEY("Dimension Code", "Dimension Value Code");
            TempDimensionSetEntryL.SETRANGE("Dimension Code", ZycusInterfaceSetup."Zycus PO CMG Dimention Code");
            TempDimensionSetEntryL.SETRANGE("Dimension Value Code", InterfaceEntryLineVIP."CMG Code");
            IF TempDimensionSetEntryL.FINDFIRST THEN BEGIN
                CMGDimValCodeL := TempDimensionSetEntryL."Dimension Value Code";
                CMGDimValIDL := TempDimensionSetEntryL."Dimension Value ID";
            END;
        END;
        //HEI.29<<
        // BC Upgrade MISHRS14 <<

        DimensionManagementL.GetDimensionSet(TempDimensionSetEntryOldL, PurchaseLine."Dimension Set ID");
        if TempDimensionSetEntryOldL.findset(false) then begin
            repeat
                TempDimensionSetEntryL.RESET();
                TempDimensionSetEntryL.SETCURRENTKEY("Dimension Code");
                TempDimensionSetEntryL.SETRANGE("Dimension Code", TempDimensionSetEntryOldL."Dimension Code");
                if TempDimensionSetEntryL.FINDFIRST() then begin

                    // BC Upgrade MISHRS14 >> #HEI.29
                    //HEI.29>>
                    IF (TempDimensionSetEntryL."Dimension Code" = ZycusInterfaceSetup."Zycus PO CMG Dimention Code") AND (InterfaceEntryLineVIP."CMG Code" <> '') THEN BEGIN
                        IF TempDimensionSetEntryL."Dimension Value Code" <> TempDimensionSetEntryOldL."Dimension Value Code" THEN BEGIN
                            TempDimensionSetEntryL."Dimension Value Code" := CMGDimValCodeL;
                            TempDimensionSetEntryL."Dimension Value ID" := CMGDimValIDL;
                            TempDimensionSetEntryL.MODIFY(FALSE);
                        END;
                    END ELSE BEGIN
                        //HEI.29<<
                        // BC Upgrade MISHRS14 <<

                        TempDimensionSetEntryL."Dimension Value Code" := TempDimensionSetEntryOldL."Dimension Value Code";
                        TempDimensionSetEntryL."Dimension Value ID" := TempDimensionSetEntryOldL."Dimension Value ID";
                        TempDimensionSetEntryL.MODIFY(false);

                        // BC Upgrade MISHRS14 >> #HEI.29
                        //HEI.29>>
                    END;
                    //HEI.29<<
                    // BC Upgrade MISHRS14 <<

                end else begin
                    TempDimensionSetEntryL.INIT();
                    TempDimensionSetEntryL."Dimension Set ID" := -1;
                    TempDimensionSetEntryL."Dimension Code" := TempDimensionSetEntryOldL."Dimension Code";

                    // BC Upgrade MISHRS14 >> #HEI.29
                    //HEI.29>>
                    IF (TempDimensionSetEntryL."Dimension Code" = ZycusInterfaceSetup."Zycus PO CMG Dimention Code") AND (InterfaceEntryLineVIP."CMG Code" <> '') THEN BEGIN
                        TempDimensionSetEntryL."Dimension Value Code" := CMGDimValCodeL;
                        TempDimensionSetEntryL."Dimension Value ID" := CMGDimValIDL;
                    END ELSE BEGIN
                        //HEI.29<<
                        // BC Upgrade MISHRS14 <<

                        TempDimensionSetEntryL."Dimension Value Code" := TempDimensionSetEntryOldL."Dimension Value Code";
                        TempDimensionSetEntryL."Dimension Value ID" := TempDimensionSetEntryOldL."Dimension Value ID";

                        // BC Upgrade MISHRS14 >> #HEI.29
                        //HEI.29>>
                    END;
                    //HEI.29<<
                    // BC Upgrade MISHRS14 <<

                    TempDimensionSetEntryL.INSERT(false);
                end;
            until TempDimensionSetEntryOldL.NEXT() = 0;
        end;
        if TempDimensionSetEntryL.ISTEMPORARY then
            exit(DimensionSetEntryL.GetDimensionSetID(TempDimensionSetEntryL));
        //HEI.03<<
    end;

    local procedure CheckDimValueOnPOCreation_Zycus(var PurchaseLine: Record "Purchase Line");
    var
        DimMgtL: Codeunit DimensionManagement;
        TableIDArrL: array[3] of Integer;
        NumberArrL: array[3] of Code[20];
    begin
        //HEI.03>>
        //  TableIDArrL[1] := DimMgtL.TypeToTableID3(Type);  // BC Upgrade NANDIS03 
        TableIDArrL[1] := DimMgtL.PurchLineTypeToTableID(PurchaseLine.Type);//BC upgrade GUNREM01 -Function replaced in BC 
        NumberArrL[1] := PurchaseLine."No.";
        if not DimMgtL.CheckDimValuePosting(TableIDArrL, NumberArrL, PurchaseLine."Dimension Set ID") then
            ERROR(Text009, PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."Line No.", DimMgtL.GetDimValuePostingErr());
        //HEI.03<<
    end;

    local procedure CheckMandatoryFieldsOnPOCreation_Zycus(var PurchaseLine: Record "Purchase Line");
    begin
        //HEI.03>>
        if PurchaseLine.Quantity <> 0 then begin
            PurchaseLine.TESTFIELD("Gen. Prod. Posting Group");
        end;
        //HEI.03<<
    end;

    local procedure CreatePurchaseOrderForGLorFA_Zycus(var PurchaseLine: Record "Purchase Line");
    var
        PurchaseLineL: Record "Purchase Line";
    begin
        //HEI.03>>
        if PurchPaySetup."Enable FA Vendor Req. FND" then begin
            PurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", "Line No.", Type);
            PurchaseLineL.SETRANGE("Document Type", PurchaseLine."Document Type");
            PurchaseLineL.SETRANGE("Document No.", PurchaseLine."Document No.");
            PurchaseLineL.SETFILTER("Line No.", '<>%1', PurchaseLine."Line No.");
            if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then
                PurchaseLineL.SETFILTER(Type, '%1|%2', PurchaseLineL.Type::"G/L Account", PurchaseLineL.Type::Item)
            else if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then
                PurchaseLineL.SETRANGE(Type, PurchaseLineL.Type::"Fixed Asset")
            else if PurchaseLine.Type = PurchaseLine.Type::Item then
                PurchaseLineL.SETRANGE(Type, PurchaseLineL.Type::"Fixed Asset");
            if PurchaseLineL.FINDFIRST() then begin
                case PurchaseLineL.Type of
                    PurchaseLineL.Type::"G/L Account":
                        begin
                            if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then begin
                                if PurchaseLineL."Document Type" <> PurchaseLineL."Document Type"::"Blanket Order" then begin
                                    ERROR(Text029, FORMAT(PurchaseLine.Type), FORMAT(PurchaseLineL.Type), FORMAT(PurchaseLine."Document Type"), PurchaseLine."Document No.");
                                end;
                            end;
                        end;
                    PurchaseLineL.Type::"Fixed Asset":
                        begin
                            if PurchaseLine.Type in [PurchaseLine.Type::"G/L Account", PurchaseLine.Type::Item] then begin
                                ERROR(Text029, FORMAT(PurchaseLine.Type), FORMAT(PurchaseLineL.Type), FORMAT(PurchaseLine."Document Type"), PurchaseLine."Document No.");
                            end;
                        end;
                    PurchaseLineL.Type::Item:
                        begin
                            if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then begin
                                ERROR(Text029, FORMAT(PurchaseLine.Type), FORMAT(PurchaseLineL.Type), FORMAT(PurchaseLine."Document Type"), PurchaseLine."Document No.");
                            end;
                        end;
                end;
            end;
        end;
        //HEI.03<<
    end;

    local procedure DeletePurchaseOrderHeader_Zycus(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
    begin
        //HEI.03>>
        InterfaceEntryHeaderVIP."Source Subtype" := InterfaceEntryHeaderVIP."Source Subtype"::"1";
        PurchaseHeaderL.GET(InterfaceEntryHeaderVIP."Source Subtype", InterfaceEntryHeaderVIP."External Order No.");
        if not GUIALLOWED then
            PurchaseHeaderL.SetHideValidationDialog(true);
        PurchaseHeaderL.DELETE(true);
        if PurchaseHeaderAddL.GET(InterfaceEntryHeaderVIP."Source Subtype", InterfaceEntryHeaderVIP."External Order No.") then
            PurchaseHeaderAddL.DELETE(false);
        //HEI.03<<
    end;

    local procedure DeletePurchaseOrderLine_Zycus(var InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT"; var PurchaseHeader: Record "Purchase Header");
    var
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
        PurchaseLineL: Record "Purchase Line";
    begin
        //HEI.03>>
        ReleasePurchaseDocumentL.Reopen(PurchaseHeader);
        PurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Zycus PO Line Validated FND", "Zycus PO Type Code FND", "Zycus PO Line Type Code FND", "Quantity Received");
        PurchaseLineL.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIP."External Order No.");
        PurchaseLineL.SETRANGE("Zycus PO Line Validated FND", false);
        PurchaseLineL.SETFILTER("Zycus PO Type Code FND", '<>%1', '');
        PurchaseLineL.SETFILTER("Zycus PO Line Type Code FND", '<>%1', '');
        PurchaseLineL.SETFILTER("Quantity Received", '<>0');
        if PurchaseLineL.findset(true) then begin
            repeat
                PurchaseLineL.VALIDATE("Cancelled FND", true);
                PurchaseLineL."Zycus PO Line Validated FND" := true;
                PurchaseLineL.MODIFY(true);
            until PurchaseLineL.NEXT() = 0;
        end;

        PurchaseLineL.SETRANGE("Quantity Received", 0);
        if not GUIALLOWED then
            // PurchaseLineL.SetHideValidationDialog(true);  // BC Upgrade NANDIS03 - Blocked as DIT dependency
        PurchaseLineL.DELETEALL(true);
        //HEI.03<<
    end;

    local procedure GetPurchaseReturnQuantity_Zycus(var PurchaseLine: Record "Purchase Line"): Decimal;
    var
        ReturnShipmentLineL: Record "Return Shipment Line";
        ReturnQuantityL: Decimal;
    begin
        //HEI.03>>
        ReturnShipmentLineL.SETCURRENTKEY("Return Order No.", "Return Order Line No.", "Zycus Order No. FND", "Zycus Order Line No. FND", Type, "No.");
        ReturnShipmentLineL.SETRANGE("Return Order No.", PurchaseLine."Document No.");
        ReturnShipmentLineL.SETRANGE("Return Order Line No.", PurchaseLine."Line No.");
        ReturnShipmentLineL.SETRANGE("Zycus Order No. FND", PurchaseLine."Zycus Order No. FND");
        ReturnShipmentLineL.SETRANGE("Zycus Order Line No. FND", PurchaseLine."Zycus Order Line No. FND");
        ReturnShipmentLineL.SETRANGE(Type, PurchaseLine.Type);
        ReturnShipmentLineL.SETRANGE("No.", PurchaseLine."No.");
        if ReturnShipmentLineL.findset(false) then begin
            repeat
                ReturnQuantityL += ReturnShipmentLineL.Quantity;
            until ReturnShipmentLineL.NEXT() = 0;
        end;
        exit(ReturnQuantityL);
        //HEI.03<<
    end;

    local procedure ValidateReleasedPurchaseOrder_Zycus(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        PurchaseLineL: Record "Purchase Line";
        PurchasesUtilsL: Codeunit "Purchases-Utils";

        // BC Upgrade MISHRS14 >> # HEI.11
        PurchaseLineTOL: Record "Purchase Line";
    // BC Upgrade MISHRS14 <<

    begin
        //HEI.03>>
        PurchaseHeaderAddL.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.");

        if PurchaseHeaderAddL."Import Identifier" then begin
            PurchaseHeader.TESTFIELD("Location Code");
            PurchaseHeaderAddL.TESTFIELD("Exp Physical Del Date(Imp)");

            PurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", Type);
            PurchaseLineL.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLineL.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLineL.SETRANGE(Type, PurchaseLineL.Type::Item);

            if PurchaseLineL.findset(false) then begin
                repeat
                    PurchaseLineL.TESTFIELD("Exp Physical Del Date(Imp) FND");
                    if PurchaseLineL."Location Code" <> PurchPaySetup."Location Code Imp Proc. FND" then
                        ERROR(Text018, PurchPaySetup."Location Code Imp Proc. FND", PurchaseLineL."Location Code", FORMAT(PurchaseLineL."Document Type"), PurchaseLineL."Document No.", PurchaseLineL."Line No.", PurchPaySetup.TABLECAPTION);
                    if PurchaseLineL."Location Code" = PurchaseHeader."Location Code" then
                        ERROR(Text019, PurchaseLineL."Location Code", FORMAT(PurchaseLineL."Document Type"), PurchaseLineL."Document No.", PurchPaySetup.TABLECAPTION);
                until PurchaseLineL.NEXT() = 0;
            end;

            if PurchaseHeader.Status = PurchaseHeader.Status::Released then BEGIN

                // BC Upgrade MISHRS14 >>
                // HEI.11 >>
                PurchaseLineTOL.SETCURRENTKEY("Document Type", "Document No.", "TO Reference FND", "Quantity Received");
                PurchaseLineTOL.SETRANGE("Document Type", PurchaseHeader."Document Type");
                PurchaseLineTOL.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLineTOL.SETFILTER("TO Reference FND", '<>%1', '');
                PurchaseLineTOL.SETFILTER("Quantity Received", '<>0');
                IF PurchaseLineTOL.ISEMPTY() THEN
                    //HEI.11 <<
                    //BC Upgrade MISHRS14 <<

                PurchasesUtilsL.ManageTOfromPO(PurchaseHeader);

                // BC Upgrade MISHRS14 >>
                //HEI.11>>
            END;
            //HEI.11<<
            // BC Upgrade MISHRS14 <<

        end;
        //HEI.03<<
    end;

    procedure OutboundPurchaseOrderConfirmation_Zycus(var InterfaceEntryNo: Integer; var ExternalOrderNo: Code[20]);
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        SendInterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        FoundInterfaceEntryNoL: Boolean;
        MessageNameL: Text[30];
        LocationCodeL: Code[10];
        ActionCodeL: Code[2];
        ExternalOrderNoL: Code[20];
        MessageTypeL: Text[35];
        MessageL: Text[250];
    begin
        //HEI.03>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate PO Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if InterfaceEntryNo = 0 then
            ERROR(Text037, Text038, Text039, ZycusInterfaceSetup."Zycus PO Confirmatio Interface");
        if ExternalOrderNo = '' then
            ERROR(Text037, Text039, Text039, ZycusInterfaceSetup."Zycus PO Confirmatio Interface");
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus PO Creation Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus PO Confirmatio Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus Create Action Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus Update Action Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus Cancellation Action Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus PO CCC Dimention Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus PO CONCAT Dimention Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus Normal PO Code");
        ZycusInterfaceSetup.TESTFIELD("Zycus Limit PO Code");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus PO Creation Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus PO Confirmatio Interface");

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, "External Order No.", Status);
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryNo);
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus PO Creation Interface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE("External Order No.", ExternalOrderNo);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Error);
        if InterfaceEntryHeaderVIPL.FINDLAST() then begin
            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus PO Confirmatio Interface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := InterfaceEntryHeaderVIPL."Message Name";
            SendInterfaceEntryHeaderVIPL."Location Code" := InterfaceEntryHeaderVIPL."Location Code";
            SendInterfaceEntryHeaderVIPL."Action Code" := InterfaceEntryHeaderVIPL."Action Code";
            SendInterfaceEntryHeaderVIPL."External Order No." := InterfaceEntryHeaderVIPL."External Order No.";
            SendInterfaceEntryHeaderVIPL."Phone No." := Text002;
            SendInterfaceEntryHeaderVIPL."Message Code" := '3';
            SendInterfaceEntryHeaderVIPL."Your Reference" := InterfaceEntryHeaderVIPL."Your Reference";
            SendInterfaceEntryHeaderVIPL.URL := DELSTR((Text014 + ': ' + InterfaceEntryHeaderVIPL."External Order No." + ': ' + InterfaceEntryHeaderVIPL."Error Message"), MAXSTRLEN(InterfaceEntryHeaderVIPL.URL));
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
            FoundInterfaceEntryNoL := true;
            exit;
        end;

        if not FoundInterfaceEntryNoL then begin
            InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Processed);
            if InterfaceEntryHeaderVIPL.FINDLAST() then begin
                MessageNameL := InterfaceEntryHeaderVIPL."Message Name";
                LocationCodeL := InterfaceEntryHeaderVIPL."Location Code";
                ActionCodeL := InterfaceEntryHeaderVIPL."Action Code";
                ExternalOrderNoL := InterfaceEntryHeaderVIPL."External Order No.";
                MessageTypeL := InterfaceEntryHeaderVIPL."Your Reference";
                MessageL := STRSUBSTNO(Text010, InterfaceEntryHeaderVIPL."External Order No.");
            end else begin
                InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", "Interface Code", Direction, "External Order No.", Status);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", InterfaceEntryNo);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus PO Creation Interface");
                InterfaceLogHeaderVIPL.SETRANGE(Direction, InterfaceLogHeaderVIPL.Direction::Inbound);
                InterfaceLogHeaderVIPL.SETRANGE("External Order No.", ExternalOrderNo);
                InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Processed);
                if InterfaceLogHeaderVIPL.FINDLAST() then begin
                    MessageNameL := InterfaceLogHeaderVIPL."Message Name";
                    LocationCodeL := InterfaceLogHeaderVIPL."Location Code";
                    ActionCodeL := InterfaceLogHeaderVIPL."Action Code";
                    ExternalOrderNoL := InterfaceLogHeaderVIPL."External Order No.";
                    MessageTypeL := InterfaceLogHeaderVIPL."Your Reference";
                    MessageL := STRSUBSTNO(Text010, InterfaceLogHeaderVIPL."External Order No.");
                end;
            end;

            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus PO Confirmatio Interface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := MessageNameL;
            SendInterfaceEntryHeaderVIPL."Location Code" := LocationCodeL;
            SendInterfaceEntryHeaderVIPL."Action Code" := ActionCodeL;
            SendInterfaceEntryHeaderVIPL."External Order No." := ExternalOrderNoL;
            SendInterfaceEntryHeaderVIPL."Phone No." := Text003;
            SendInterfaceEntryHeaderVIPL."Message Code" := '1';
            SendInterfaceEntryHeaderVIPL."Your Reference" := MessageTypeL;
            SendInterfaceEntryHeaderVIPL.URL := MessageL;
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
        end;
        //HEI.03<<
    end;

    procedure InboundProcessGoodsReceiptOfPurchaseOrder_Zycus(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        PurchaseLineL: Record "Purchase Line";
        GRPurchaseLineL: Record "Purchase Line";
        PostReceiptL: Boolean;
        PostReturnShipmentL: Boolean;
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
        ReturnPurchaseHeaderL: Record "Purchase Header";
        ReturnPurchaseLineL: Record "Purchase Line";
        CopyDocMgtL: Codeunit "Copy Document Mgt.";
        PurchDocTypeL: Option Quote,"Blanket Order","Order",Invoice,"Return Order","Credit Memo","Posted Receipt","Posted Invoice","Posted Return Shipment","Posted Credit Memo";
        ReturnPurchaseHeaderAddL: Record "Purchase Header Additional FND";
        UoMCodeL: Code[10];
        DummyInvNoL: Label 'CHG2210794_Inv';
        DummyCrMemoNoL: Label 'CHG2210794_CrMemo';
        PurchPostYesNoL: Codeunit "Purch.-Post (Yes/No)";
        FAFoundL: Boolean;
        //BC Upgrade GUNREM01 >>
        HeinekenBCUpgrade: Codeunit "Heineken BC Upgrade";
        InterfacePurchCode: Codeunit InterfacePurchCode;

        // BC Upgrade MISHRS14 >> # HEI.11
        PurchaseHeaderL1: Record "Purchase Header";
    // BC Upgrade MISHRS14 <<

    //BC Upgrade GUNREM01 <<
    begin
        //HEI.05>>
        CLEAR(ZycusInterfaceSetupRead);
        CLEAR(GeneralInterfaceSetupRead);
        CLEAR(CompanyInformationRead);
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Creation Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Confirmatio Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus GR CreationMovement Type");
        ZycusInterfaceSetup.TESTFIELD("Zycus RD CreationMovement Type");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Creation Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Confirmatio Interface");
        InterfaceEntryHeaderVIP.TESTFIELD("Entry No.");
        InterfaceEntryHeaderVIP.TESTFIELD("Interface Code", ZycusInterfaceSetup."Zycus GR Creation Interface");
        InterfaceEntryHeaderVIP.TESTFIELD("External Order No.");
        InterfaceEntryHeaderVIP.TESTFIELD(Name4);

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, Status, "External Order No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus GR Creation Interface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Pending);
        InterfaceEntryHeaderVIPL.SETRANGE("External Order No.", InterfaceEntryHeaderVIP."External Order No.");
        InterfaceEntryHeaderVIPL.FINDFIRST();

        InterfaceEntryLineVIPL.SETCURRENTKEY("Header Entry No.", "External Order No.");
        InterfaceEntryLineVIPL.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        InterfaceEntryLineVIPL.SETRANGE("External Order No.", InterfaceEntryHeaderVIPL."External Order No.");
        InterfaceEntryLineVIPL.findset(false);
        GetPurchaseSetup_Zycus();
        PurchaseHeaderL.GET(PurchaseHeaderL."Document Type"::Order, InterfaceEntryHeaderVIPL."External Order No.");
        PurchaseHeaderAddL.GET(PurchaseHeaderAddL."Document Type"::Order, InterfaceEntryHeaderVIPL."External Order No.");
        PurchaseHeaderAddL.TESTFIELD("Limit PO", false);
        PurchaseHeaderL."Posting Date" := TODAY;
        PurchaseHeaderL."Document Date" := InterfaceEntryHeaderVIPL."Document Date";
        PurchaseHeaderL."Vendor Shipment No." := InterfaceEntryHeaderVIPL."External Document No.";
        PurchaseHeaderL."Your Reference" := InterfaceEntryHeaderVIPL."Your Reference";
        PurchaseHeaderL.MODIFY(false);
        PurchaseHeaderAddL."Zycus GR UUID INT" := InterfaceEntryHeaderVIPL.Name4;
        PurchaseHeaderAddL."GR Transaction Intf Zycus INT" := ZycusInterfaceSetup."Zycus GR Creation Interface";
        PurchaseHeaderAddL."Processed GR Trans. Zycus INT" := true;
        PurchaseHeaderAddL.MODIFY(false);

        GRPurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND");
        GRPurchaseLineL.SETRANGE("Document Type", GRPurchaseLineL."Document Type"::Order);
        GRPurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");
        if GRPurchaseLineL.findset(false) then begin
            repeat
                GRPurchaseLineL.VALIDATE("Qty. to Receive", 0);
                GRPurchaseLineL.MODIFY(true);
            until GRPurchaseLineL.NEXT() = 0;
        end;

        PurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Zycus Order Line No. FND");
        PurchaseLineL.SETRANGE("Document Type", PurchaseLineL."Document Type"::Order);
        PurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");

        repeat
            CLEAR(ReleasePurchaseDocumentL);
            CLEAR(CopyDocMgtL);
            CLEAR(PurchDocTypeL);
            CLEAR(UoMCodeL);
            InterfaceEntryLineVIPL.TESTFIELD("External Order No.", InterfaceEntryHeaderVIPL."External Order No.");
            InterfaceEntryLineVIPL.TESTFIELD("External Order Line No.");
            InterfaceEntryLineVIPL.TESTFIELD("Item Type");
            PurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
            PurchaseLineL.FINDFIRST();
            if PurchaseLineL.Type = PurchaseLineL.Type::Item then
                ERROR(Text031, PurchaseLineL."Document No.");
            if PurchaseLineL."Block Line Ordering FND" = PurchaseLineL."Block Line Ordering FND"::B then
                ERROR(Text032, PurchaseLineL.FIELDCAPTION("Block Line Ordering FND"), FORMAT(PurchaseLineL."Block Line Ordering FND"),
                  PurchaseLineL."Document No.", PurchaseLineL."Line No.");

            case InterfaceEntryLineVIPL."Item Type" of
                ZycusInterfaceSetup."Zycus GR CreationMovement Type":
                    begin
                        PostReceiptL := true;
                        if InterfaceEntryLineVIPL.Quantity <> 0 then begin
                            PurchaseLineL.VALIDATE("Qty. to Receive", InterfaceEntryLineVIPL.Quantity);
                            PurchaseLineL."Vendor Shipment No. FND" := InterfaceEntryHeaderVIPL."External Document No.";
                        end else begin
                            ReleasePurchaseDocumentL.Reopen(PurchaseHeaderL);
                            PurchaseLineL.VALIDATE(Quantity, PurchaseLineL.Quantity + 1);
                            PurchaseLineL.VALIDATE("Qty. to Receive", 1);
                            CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeaderL);
                        end;
                        PurchaseLineL.VALIDATE("Qty. to Invoice", InterfaceEntryLineVIPL.Quantity);
                        UoMCodeL := GetISOCodeUnitOfMeasure_Zycus(InterfaceEntryLineVIPL."Unit of Measure Code");
                        if (UoMCodeL <> '') and (UoMCodeL <> PurchaseLineL."Unit of Measure Code") then
                            ERROR(Text034, PurchaseLineL.TABLECAPTION, PurchaseLineL.FIELDCAPTION("Unit of Measure Code"),
                              UoMCodeL, InterfaceEntryLineVIPL."Unit of Measure Code");
                        PurchaseLineL.MODIFY(false);
                    end;
                ZycusInterfaceSetup."Zycus RD CreationMovement Type":
                    begin
                        ReturnPurchaseLineL.RESET();
                        ReturnPurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", "Zycus Order Line No. FND");
                        ReturnPurchaseLineL.SETRANGE("Document Type", ReturnPurchaseLineL."Document Type"::"Return Order");
                        ReturnPurchaseLineL.SETRANGE("Document No.", InterfaceEntryLineVIPL."External Order No.");
                        ReturnPurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                        ReturnPurchaseHeaderL.RESET();
                        if not ReturnPurchaseHeaderL.GET(ReturnPurchaseHeaderL."Document Type"::"Return Order", InterfaceEntryLineVIPL."External Order No.") then begin
                            ReturnPurchaseHeaderL.INIT();
                            ReturnPurchaseHeaderL."Document Type" := ReturnPurchaseHeaderL."Document Type"::"Return Order";
                            ReturnPurchaseHeaderL."No." := PurchaseHeaderL."No.";
                            ReturnPurchaseHeaderL."No. Series" := '';
                            ReturnPurchaseHeaderL.INSERT(true);

                            CopyDocMgtL.SetProperties(true, false, false, false, false, PurchPaySetup."Exact Cost Reversing Mandatory", false);
                            //   CopyDocMgtL.SetInterfaceProperties(PurchaseLineL."Line No.");  // BC Upgrade NANDIS03 
                            HeinekenBCUpgrade.SetInterfaceProperties(PurchaseLineL."Line No."); //BC Upgrade GUNREM01 -SetInterfaceProperties function added in general BCUpgrade codeunit 
                            CopyDocMgtL.CopyPurchDoc(PurchDocTypeL::Order, PurchaseHeaderL."No.", ReturnPurchaseHeaderL);
                            ReturnPurchaseLineL.FINDFIRST();
                            ReturnPurchaseLineL.VALIDATE(Quantity, 0);
                            ReturnPurchaseLineL.MODIFY(false);
                        end;
                        if ReturnPurchaseHeaderL.Status = ReturnPurchaseHeaderL.Status::Released then
                            ReleasePurchaseDocumentL.Reopen(ReturnPurchaseHeaderL);
                        if not ReturnPurchaseLineL.FINDFIRST() then begin
                            CopyDocMgtL.SetProperties(false, false, false, false, false, PurchPaySetup."Exact Cost Reversing Mandatory", false);
                            // CopyDocMgtL.SetInterfaceProperties(PurchaseLineL."Line No.");  // BC Upgrade NANDIS03 
                            HeinekenBCUpgrade.SetInterfaceProperties(PurchaseLineL."Line No."); //BC Upgrade GUNREM01 -SetInterfaceProperties function added in general BCUpgrade codeunit 
                            CopyDocMgtL.CopyPurchDoc(PurchDocTypeL::Order, PurchaseHeaderL."No.", ReturnPurchaseHeaderL);
                            ReturnPurchaseLineL.FINDFIRST();
                            if ReturnPurchaseLineL.Type = ReturnPurchaseLineL.Type::Item then
                                ERROR(Text031, ReturnPurchaseLineL."Document No.");
                            if (not FAFoundL) and (ReturnPurchaseLineL.Type = ReturnPurchaseLineL.Type::"Fixed Asset") then
                                FAFoundL := true;
                            ReturnPurchaseLineL.VALIDATE(Quantity, InterfaceEntryLineVIPL.Quantity);
                            ReturnPurchaseLineL.MODIFY(false);
                        end else begin
                            if ReturnPurchaseHeaderL.Status = ReturnPurchaseHeaderL.Status::Released then
                                ReleasePurchaseDocumentL.Reopen(ReturnPurchaseHeaderL);
                            if (not FAFoundL) and (ReturnPurchaseLineL.Type = ReturnPurchaseLineL.Type::"Fixed Asset") then
                                FAFoundL := true;
                            ReturnPurchaseLineL.VALIDATE(Quantity, ReturnPurchaseLineL."Return Qty. Shipped" + InterfaceEntryLineVIPL.Quantity);
                            ReturnPurchaseLineL.MODIFY(false);
                        end;
                        PostReturnShipmentL := true;
                        ReleasePurchaseDocumentL.Reopen(PurchaseHeaderL);
                        if InterfaceEntryLineVIPL.Quantity <> 0 then begin
                            ReturnPurchaseLineL.VALIDATE("Return Qty. to Ship", InterfaceEntryLineVIPL.Quantity);
                        end else begin
                            ReturnPurchaseLineL.VALIDATE(Quantity, ReturnPurchaseLineL.Quantity + 1);
                            ReturnPurchaseLineL.VALIDATE("Return Qty. to Ship", 1);
                        end;
                        CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeaderL);
                        ReturnPurchaseLineL.VALIDATE("Qty. to Invoice", InterfaceEntryLineVIPL.Quantity)
                    end;
            end;
        until InterfaceEntryLineVIPL.NEXT() = 0;

        if PostReceiptL then begin
            PurchaseHeaderL.Receive := true;
            PurchaseHeaderL.Invoice := true;
            PurchaseHeaderL."Vendor Invoice No." := DummyInvNoL;
            COMMIT();
            // PurchPostYesNoL.PreviewSRMInterface(PurchaseHeaderL);  // BC Upgrade NANDIS03 
            //InterfacePurchCode.PreviewSRMInterface(PurchaseHeaderL); //BC Upgrade GUNREM01 -PreviewSRMInterface added in InterfacePurchCode codeunit//BC Upgrade SHARMP16--Zycus
            InterfacePurchCode.PreviewSRMInterface1(PurchaseHeaderL); //BC Upgrade SHARMP16--Zycus

            InterfaceEntryLineVIPL.findset(false);
            GRPurchaseLineL.RESET();
            GRPurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Zycus Order Line No. FND");
            GRPurchaseLineL.SETRANGE("Document Type", GRPurchaseLineL."Document Type"::Order);
            GRPurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");

            repeat
                GRPurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                if GRPurchaseLineL.FINDFIRST() then begin
                    if GRPurchaseLineL.Type = GRPurchaseLineL.Type::"Fixed Asset" then
                        GRPurchaseLineL.VALIDATE("Qty. to Invoice", InterfaceEntryLineVIPL.Quantity)
                    else
                        GRPurchaseLineL.VALIDATE("Qty. to Invoice", 0);
                    GRPurchaseLineL.MODIFY(true);
                end;
            until InterfaceEntryLineVIPL.NEXT() = 0;
            PurchaseHeaderL.Invoice := false;
            PurchaseHeaderL."Vendor Invoice No." := '';
            CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchaseHeaderL);

            InterfaceEntryLineVIPL.SETRANGE("Delivery Finalized", true);
            if InterfaceEntryLineVIPL.findset(false) then begin
                repeat
                    PurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                    PurchaseLineL.FINDFIRST();
                    PurchaseLineL.VALIDATE("Delivery Finalized FND", InterfaceEntryLineVIPL."Delivery Finalized");
                    PurchaseLineL.MODIFY(false);
                until InterfaceEntryLineVIPL.NEXT() = 0;
            end;
            InterfaceEntryHeaderVIPL.Name6 := FORMAT(ZycusInterfaceSetup."Zycus GR CreationMovement Type");
            InterfaceEntryHeaderVIPL.MODIFY(false);
        end;

        if PostReturnShipmentL then begin
            ReturnPurchaseHeaderL."Posting Date" := TODAY;
            ReturnPurchaseHeaderL."Your Reference" := InterfaceEntryHeaderVIPL."Your Reference";
            ReturnPurchaseHeaderL.Ship := true;
            if not FAFoundL then begin
                ReturnPurchaseHeaderL.Invoice := true;
                ReturnPurchaseHeaderL."Vendor Cr. Memo No." := DummyCrMemoNoL;
                COMMIT();
                //  PurchPostYesNoL.PreviewSRMInterface(ReturnPurchaseHeaderL);  // BC Upgrade NANDIS03 
                //  InterfacePurchCode.PreviewSRMInterface(ReturnPurchaseHeaderL); //BC Upgrade GUNREM01 -PreviewSRMInterface added in InterfacePurchCode codeunit//BC Upgrade SHARMP16--Zycus
                InterfacePurchCode.PreviewSRMInterface1(ReturnPurchaseHeaderL); //BC Upgrade SHARMP16--Zycus

            end;
            InterfaceEntryLineVIPL.findset(false);

            // BC Upgrade MISHRS14 >>
            //HEI.11>>
            PurchaseHeaderL1.GET(PurchaseHeaderL1."Document Type"::Order, InterfaceEntryLineVIPL."External Order No.");
            IF PurchaseHeaderL1.Status = PurchaseHeaderL1.Status::Released THEN BEGIN
                CLEAR(ReleasePurchaseDocumentL);
                ReleasePurchaseDocumentL.Reopen(PurchaseHeaderL1);
            END;
            //HEI.11<<
            // BC Upgrade MISHRS14 <<

            GRPurchaseLineL.RESET();
            GRPurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Zycus Order Line No. FND");
            GRPurchaseLineL.SETRANGE("Document Type", GRPurchaseLineL."Document Type"::"Return Order");
            GRPurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");

            PurchaseLineL.RESET();
            PurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Zycus Order Line No. FND");
            PurchaseLineL.SETRANGE("Document Type", PurchaseLineL."Document Type"::Order);
            PurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");

            repeat
                GRPurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                if GRPurchaseLineL.FINDFIRST() then begin
                    if GRPurchaseLineL.Type = GRPurchaseLineL.Type::"Fixed Asset" then
                        GRPurchaseLineL.VALIDATE("Qty. to Invoice", InterfaceEntryLineVIPL.Quantity)
                    else
                        GRPurchaseLineL.VALIDATE("Qty. to Invoice", 0);
                    GRPurchaseLineL.MODIFY(true);
                end;

                if InterfaceEntryLineVIPL.Quantity <> 0 then begin
                    PurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                    PurchaseLineL.FINDFIRST();
                    PurchaseLineL.VALIDATE(Quantity, PurchaseLineL.Quantity + InterfaceEntryLineVIPL.Quantity);
                    PurchaseLineL.MODIFY(false);
                end;
            until InterfaceEntryLineVIPL.NEXT() = 0;
            ReturnPurchaseHeaderL.Invoice := false;
            ReturnPurchaseHeaderL."Vendor Cr. Memo No." := '';
            ReturnPurchaseHeaderAddL.GET(ReturnPurchaseHeaderL."Document Type"::Order, ReturnPurchaseHeaderL."No.");
            ReturnPurchaseHeaderAddL.TESTFIELD("Limit PO", false);
            ReturnPurchaseHeaderAddL."Zycus Order No. INT" := InterfaceEntryLineVIPL."External Order No.";
            ReturnPurchaseHeaderAddL."Zycus GR UUID INT" := InterfaceEntryHeaderVIPL.Name4;
            ReturnPurchaseHeaderAddL."GR Transaction Intf Zycus INT" := ZycusInterfaceSetup."Zycus GR Creation Interface";
            ReturnPurchaseHeaderAddL."Processed GR Trans. Zycus INT" := true;
            ReturnPurchaseHeaderAddL.MODIFY(false);
            CODEUNIT.RUN(CODEUNIT::"Purch.-Post", ReturnPurchaseHeaderL);

            // BC Upgrade MISHRS14 >>
            //HEI.11>>
            IF PurchaseHeaderL1.Status = PurchaseHeaderL1.Status::Open THEN
                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeaderL1);
            //HEI.11<<
            // BC Upgrade MISHRS14 <<

            InterfaceEntryLineVIPL.SETRANGE("Delivery Finalized", true);
            if InterfaceEntryLineVIPL.findset(false) then begin
                repeat
                    ReturnPurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                    ReturnPurchaseLineL.FINDFIRST();
                    ReturnPurchaseLineL.VALIDATE("Delivery Finalized FND", InterfaceEntryLineVIPL."Delivery Finalized");
                    ReturnPurchaseLineL.MODIFY(false);
                until InterfaceEntryLineVIPL.NEXT() = 0;
            end;
            InterfaceEntryHeaderVIPL.Name7 := FORMAT(ZycusInterfaceSetup."Zycus RD CreationMovement Type");
            InterfaceEntryHeaderVIPL.MODIFY(false);
        end;
        //HEI.05<<
    end;

    procedure OutboundGoodsReceiptOfPurchaseOrderConfirmation_Zycus(var InterfaceEntryNo: Integer; var ExternalOrderNo: Code[20]; MovementType: Integer);
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        SendInterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        ReturnShipmentLineL: Record "Return Shipment Line";
        ReturnPurchaseLineL: Record "Purchase Line";
        FoundInterfaceEntryNoL: Boolean;
        MessageNameL: Text[30];
        LocationCodeL: Code[10];
        SourceNoL: Code[20];
        ExternalOrderNoL: Code[20];
        MessageTypeL: Text[35];
        MessageL: Text[250];
        ZycusReferenceL: Text[50];
    begin
        //HEI.05>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if InterfaceEntryNo = 0 then
            ERROR(Text037, Text038, Text040, ZycusInterfaceSetup."Zycus GR Confirmatio Interface");
        if ExternalOrderNo = '' then
            ERROR(Text037, Text039, Text040, ZycusInterfaceSetup."Zycus GR Confirmatio Interface");
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Creation Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Confirmatio Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus GR CreationMovement Type");
        ZycusInterfaceSetup.TESTFIELD("Zycus RD CreationMovement Type");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Creation Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Confirmatio Interface");

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, "External Order No.", Status);
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryNo);
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus GR Creation Interface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE("External Order No.", ExternalOrderNo);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Error);
        if InterfaceEntryHeaderVIPL.FINDLAST() then begin
            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus GR Confirmatio Interface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := InterfaceEntryHeaderVIPL."Message Name";
            SendInterfaceEntryHeaderVIPL."Location Code" := InterfaceEntryHeaderVIPL."Location Code";
            SendInterfaceEntryHeaderVIPL."Source No." := SourceNoL;
            SendInterfaceEntryHeaderVIPL."External Order No." := InterfaceEntryHeaderVIPL."External Order No.";
            SendInterfaceEntryHeaderVIPL."Phone No." := Text002;
            SendInterfaceEntryHeaderVIPL."Message Code" := '3';
            SendInterfaceEntryHeaderVIPL."Your Reference" := InterfaceEntryHeaderVIPL."Your Reference";
            SendInterfaceEntryHeaderVIPL.URL := DELSTR((Text014 + ': ' + InterfaceEntryHeaderVIPL."External Order No." + ': ' + InterfaceEntryHeaderVIPL."Error Message"), MAXSTRLEN(InterfaceEntryHeaderVIPL.URL));
            SendInterfaceEntryHeaderVIPL.Name4 := InterfaceEntryHeaderVIPL.Name4;
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
            FoundInterfaceEntryNoL := true;
            exit;
        end;

        if not FoundInterfaceEntryNoL then begin
            InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Processed);
            if InterfaceEntryHeaderVIPL.FINDLAST() then begin
                MessageNameL := InterfaceEntryHeaderVIPL."Message Name";
                LocationCodeL := InterfaceEntryHeaderVIPL."Location Code";
                case MovementType of
                    ZycusInterfaceSetup."Zycus GR CreationMovement Type":
                        begin
                            PurchRcptLineL.SETCURRENTKEY("Order No.", "Zycus Order No. FND");
                            PurchRcptLineL.SETRANGE("Order No.", ExternalOrderNo);
                            PurchRcptLineL.SETRANGE("Zycus Order No. FND", ExternalOrderNo);
                            if PurchRcptLineL.FINDLAST() then
                                SourceNoL := PurchRcptLineL."Document No.";
                        end;
                    ZycusInterfaceSetup."Zycus RD CreationMovement Type":
                        begin
                            ReturnShipmentLineL.SETCURRENTKEY("Zycus Order No. FND");
                            ReturnShipmentLineL.SETRANGE("Zycus Order No. FND", ExternalOrderNo);
                            if ReturnShipmentLineL.FINDLAST() then begin
                                ReturnPurchaseLineL.GET(ReturnPurchaseLineL."Document Type"::"Return Order",
                                  ReturnShipmentLineL."Return Order No.", ReturnShipmentLineL."Return Order Line No.");
                                SourceNoL := ReturnShipmentLineL."Document No.";
                            end;
                        end;
                end;
                ExternalOrderNoL := InterfaceEntryHeaderVIPL."External Order No.";
                MessageTypeL := InterfaceEntryHeaderVIPL."Your Reference";
                MessageL := STRSUBSTNO(Text033, SourceNoL);
                ZycusReferenceL := InterfaceEntryHeaderVIPL.Name4;
            end else begin
                InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", "Interface Code", Direction, "External Order No.", Status);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", InterfaceEntryNo);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus GR Creation Interface");
                InterfaceLogHeaderVIPL.SETRANGE(Direction, InterfaceLogHeaderVIPL.Direction::Inbound);
                InterfaceLogHeaderVIPL.SETRANGE("External Order No.", ExternalOrderNo);
                InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Processed);
                if InterfaceLogHeaderVIPL.FINDLAST() then begin
                    MessageNameL := InterfaceLogHeaderVIPL."Message Name";
                    LocationCodeL := InterfaceLogHeaderVIPL."Location Code";
                    case MovementType of
                        ZycusInterfaceSetup."Zycus GR CreationMovement Type":
                            begin
                                PurchRcptLineL.SETCURRENTKEY("Order No.", "Zycus Order No. FND");
                                PurchRcptLineL.SETRANGE("Order No.", ExternalOrderNo);
                                PurchRcptLineL.SETRANGE("Zycus Order No. FND", ExternalOrderNo);
                                if PurchRcptLineL.FINDLAST() then
                                    SourceNoL := PurchRcptLineL."Document No.";
                            end;
                        ZycusInterfaceSetup."Zycus RD CreationMovement Type":
                            begin
                                ReturnShipmentLineL.SETCURRENTKEY("Zycus Order No. FND");
                                ReturnShipmentLineL.SETRANGE("Zycus Order No. FND", ExternalOrderNo);
                                if ReturnShipmentLineL.FINDLAST() then begin
                                    ReturnPurchaseLineL.GET(ReturnPurchaseLineL."Document Type"::"Return Order",
                                      ReturnShipmentLineL."Return Order No.", ReturnShipmentLineL."Return Order Line No.");
                                    SourceNoL := ReturnShipmentLineL."Document No.";
                                end;
                            end;
                    end;
                    ExternalOrderNoL := InterfaceLogHeaderVIPL."External Order No.";
                    MessageTypeL := InterfaceLogHeaderVIPL."Your Reference";
                    MessageL := STRSUBSTNO(Text033, SourceNoL);
                    ZycusReferenceL := InterfaceEntryHeaderVIPL.Name4;
                end;
            end;

            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus GR Confirmatio Interface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := MessageNameL;
            SendInterfaceEntryHeaderVIPL."Location Code" := LocationCodeL;
            SendInterfaceEntryHeaderVIPL."Source No." := SourceNoL;
            SendInterfaceEntryHeaderVIPL."External Order No." := ExternalOrderNoL;
            SendInterfaceEntryHeaderVIPL."Phone No." := Text003;
            SendInterfaceEntryHeaderVIPL."Message Code" := '1';
            SendInterfaceEntryHeaderVIPL."Your Reference" := MessageTypeL;
            SendInterfaceEntryHeaderVIPL.URL := MessageL;
            SendInterfaceEntryHeaderVIPL."Prod. Order Line No." := MovementType;
            SendInterfaceEntryHeaderVIPL.Name4 := ZycusReferenceL;
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
        end;
        //HEI.05<<
    end;

    procedure InboundProcessGoodsReceiptCancellationOfPurchaseOrder_Zycus(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        PurchaseLineL: Record "Purchase Line";
        GRPurchaseLineL: Record "Purchase Line";
        ReturnPurchaseHeaderL: Record "Purchase Header";
        ReturnPurchaseLineL: Record "Purchase Line";
        PurchRcptHeaderL: Record "Purch. Rcpt. Header";
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        PurchRcptHeaderAddL: Record "Purch. Rcpt. Header Add FND";
        ReturnShipmentLineL: Record "Return Shipment Line";
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
        UndoPurchaseReceiptLineL: Codeunit "Undo Purchase Receipt Line";
        UndoReturnShipmentLineL: Codeunit "Undo Return Shipment Line";
        PurchRcptLineL2: Record "Purch. Rcpt. Line";
        UndoReceiptL: Boolean;
        UndoReturnShipmentL: Boolean;
        ReturnPurchaseHeaderAddL: Record "Purchase Header Additional FND";
        PurchRcptLineL3: Record "Purch. Rcpt. Line";
        ReturnShipmentHeaderL: Record "Return Shipment Header";
        ReturnShipmentLineL2: Record "Return Shipment Line";
        HeinekenBCUpgradeSTP: Codeunit HeinekenBCUpgrade_STP; //BC Upgrade GUNREM01
    begin
        //HEI.05>>
        CLEAR(ZycusInterfaceSetupRead);
        CLEAR(GeneralInterfaceSetupRead);
        CLEAR(CompanyInformationRead);
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Cancel Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Cancel Conf Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Cancel Movement Type");
        ZycusInterfaceSetup.TESTFIELD("Zycus RD Cancel Movement Type");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Cancel Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Cancel Conf Interface");
        InterfaceEntryHeaderVIP.TESTFIELD("Entry No.");
        InterfaceEntryHeaderVIP.TESTFIELD("Interface Code", ZycusInterfaceSetup."Zycus GR Cancel Interface");
        InterfaceEntryHeaderVIP.TESTFIELD("Source No.");
        InterfaceEntryHeaderVIP.TESTFIELD(Name4);
        InterfaceEntryHeaderVIP.TESTFIELD(Name5);

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, Status, "Source No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus GR Cancel Interface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Pending);
        InterfaceEntryHeaderVIPL.SETRANGE("Source No.", InterfaceEntryHeaderVIP."Source No.");
        InterfaceEntryHeaderVIPL.FINDFIRST();
        InterfaceEntryHeaderVIPL.TESTFIELD("Prod. Order Line No.");
        GetPurchaseSetup_Zycus();

        case InterfaceEntryHeaderVIPL."Prod. Order Line No." of
            ZycusInterfaceSetup."Zycus GR Cancel Movement Type":
                begin
                    PurchRcptLineL.SETCURRENTKEY("Document No.", Type, Quantity, Correction);
                    PurchRcptLineL.SETRANGE("Document No.", InterfaceEntryHeaderVIPL."Source No.");
                    PurchRcptLineL.SETFILTER(Type, '%1|%2', PurchRcptLineL.Type::"Fixed Asset", PurchRcptLineL.Type::"G/L Account");
                    PurchRcptLineL.SETFILTER(Quantity, '<>0');
                    PurchRcptLineL.SETRANGE(Correction, false);
                    PurchRcptLineL.findset(false);

                    PurchRcptHeaderAddL.SETCURRENTKEY("No.", "Zycus GR UUID FND");
                    PurchRcptHeaderAddL.SETRANGE("No.", InterfaceEntryHeaderVIPL."Source No.");
                    PurchRcptHeaderAddL.SETRANGE("Zycus GR UUID FND", InterfaceEntryHeaderVIPL.Name4);
                    PurchRcptHeaderAddL.FINDFIRST();
                    PurchaseHeaderL.GET(PurchaseHeaderL."Document Type"::Order, PurchRcptLineL."Order No.");
                    PurchaseHeaderAddL.GET(PurchaseHeaderAddL."Document Type"::Order, PurchRcptLineL."Order No.");
                    PurchaseHeaderAddL.TESTFIELD("Limit PO", false);

                    repeat
                        CLEAR(UndoPurchaseReceiptLineL);
                        if PurchRcptLineL."Qty. Rcd. Not Invoiced" <> PurchRcptLineL.Quantity then
                            ERROR(Text036, PurchRcptLineL."Document No.", PurchRcptLineL."Zycus Order Line No. FND");
                        if PurchRcptLineL.Type = PurchRcptLineL.Type::"Fixed Asset" then begin
                            UndoPurchaseReceiptLineL.SetHideDialog(true);
                            //  UndoPurchaseReceiptLineL.PreviewPostGLOnUndoFixedAssets(PurchRcptLineL);  // BC Upgrade NANDIS03 
                            HeinekenBCUpgradeSTP.PreviewPostGLOnUndoFixedAssets(PurchRcptLineL); //BC Upgrade GUNREM01 -PreviewPostGLOnUndoFixedAssets fucntion added in HeinekenBCUpgradeSTP codeunit
                        end;
                    until PurchRcptLineL.NEXT() = 0;
                    PurchRcptHeaderAddL."Zycus GR Cancel UUID FND" := InterfaceEntryHeaderVIPL.Name5;
                    PurchRcptHeaderAddL.MODIFY(false);

                    PurchRcptLineL2.COPYFILTERS(PurchRcptLineL);
                    PurchRcptLineL2.findset(false);
                    repeat
                        CLEAR(UndoPurchaseReceiptLineL);
                        UndoPurchaseReceiptLineL.SetHideDialog(true);
                        UndoPurchaseReceiptLineL.RUN(PurchRcptLineL2);
                        UndoReceiptL := true;
                    until PurchRcptLineL2.NEXT() = 0;
                end;
            ZycusInterfaceSetup."Zycus RD Cancel Movement Type":
                begin
                    ReturnShipmentLineL.SETCURRENTKEY("Document No.", Type, Quantity);
                    ReturnShipmentLineL.SETRANGE("Document No.", InterfaceEntryHeaderVIPL."Source No.");
                    ReturnShipmentLineL.SETRANGE(Type, ReturnShipmentLineL.Type::"G/L Account");
                    ReturnShipmentLineL.SETFILTER(Quantity, '<>0');
                    if ReturnShipmentLineL.ISEMPTY then
                        ERROR(Text035)
                    else begin
                        if ReturnShipmentLineL.findset(false) then begin
                            ReturnShipmentHeaderL.SETCURRENTKEY("No.", "Zycus GR UUID INT");
                            ReturnShipmentHeaderL.SETRANGE("No.", InterfaceEntryHeaderVIPL."Source No.");
                            ReturnShipmentHeaderL.SETRANGE("Zycus GR UUID INT", InterfaceEntryHeaderVIPL.Name4);
                            ReturnShipmentHeaderL.FINDFIRST();
                            PurchaseHeaderL.GET(PurchaseHeaderL."Document Type"::Order, PurchRcptLineL."Order No.");
                            PurchaseHeaderAddL.GET(PurchaseHeaderAddL."Document Type"::Order, PurchRcptLineL."Order No.");
                            PurchaseHeaderAddL.TESTFIELD("Limit PO", false);

                            repeat
                                CLEAR(UndoReturnShipmentLineL);
                                CLEAR(ReleasePurchaseDocumentL);
                                if ReturnShipmentLineL."Return Qty. Shipped Not Invd." <> ReturnShipmentLineL.Quantity then
                                    ERROR(Text036, ReturnShipmentLineL."Document No.", ReturnShipmentLineL."Zycus Order Line No. FND");

                                ReturnPurchaseLineL.RESET();
                                ReturnPurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                                ReturnPurchaseLineL.SETRANGE("Document Type", ReturnPurchaseLineL."Document Type"::"Return Order");
                                ReturnPurchaseLineL.SETRANGE("Document No.", ReturnShipmentLineL."Return Order No.");
                                ReturnPurchaseLineL.SETRANGE("Line No.", ReturnShipmentLineL."Return Order Line No.");
                                ReturnPurchaseLineL.FINDFIRST();
                                UndoReturnShipmentLineL.SetHideDialog(true);
                                UndoReturnShipmentLineL.RUN(ReturnShipmentLineL);
                                UndoReturnShipmentL := true;

                                ReturnPurchaseHeaderL.RESET();
                                ReturnPurchaseHeaderL.GET(ReturnPurchaseLineL."Document Type", ReturnPurchaseLineL."Document No.");
                                ReleasePurchaseDocumentL.Reopen(ReturnPurchaseHeaderL);
                                ReturnPurchaseLineL.VALIDATE(Quantity, ReturnPurchaseLineL.Quantity - ReturnShipmentLineL.Quantity);
                                ReturnPurchaseLineL.MODIFY(false);
                                CLEAR(ReleasePurchaseDocumentL);
                                ReleasePurchaseDocumentL.Reopen(PurchaseHeaderL);
                                PurchaseLineL.VALIDATE(Quantity, PurchaseLineL.Quantity - ReturnShipmentLineL.Quantity);
                                PurchaseLineL.MODIFY(false);
                                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeaderL);
                            until ReturnShipmentLineL.NEXT() = 0;
                            ReturnShipmentHeaderL."Zycus GR UUID INT" := InterfaceEntryHeaderVIPL.Name4;
                            ReturnShipmentHeaderL."Zycus GR Cancel UUID INT" := InterfaceEntryHeaderVIPL.Name5;
                            ReturnShipmentHeaderL.MODIFY(false);
                        end;
                    end;
                end;
        end;

        if UndoReceiptL then begin
            PurchRcptLineL3.COPYFILTERS(PurchRcptLineL);
            PurchRcptLineL3.SETRANGE(Correction, true);
            PurchRcptLineL3.findset(false);

            PurchaseLineL.RESET();
            PurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", "Delivery Finalized FND", "Line No.", "Zycus Order Line No. FND");
            PurchaseLineL.SETRANGE("Document Type", PurchaseHeaderL."Document Type");
            PurchaseLineL.SETRANGE("Document No.", PurchaseHeaderL."No.");
            PurchaseLineL.SETRANGE("Delivery Finalized FND", true);

            repeat
                PurchRcptLineL3."Delivery Finalized FND" := false;
                PurchRcptLineL3.MODIFY(false);

                PurchaseLineL.SETRANGE("Line No.", PurchRcptLineL3."Order Line No.");
                PurchaseLineL.SETRANGE("Zycus Order Line No. FND", PurchRcptLineL3."Zycus Order Line No. FND");
                if PurchaseLineL.FINDFIRST() then begin
                    PurchaseLineL.VALIDATE("Delivery Finalized FND", false);
                    PurchaseLineL.MODIFY(false);
                end;
            until PurchRcptLineL3.NEXT() = 0;
            InterfaceEntryHeaderVIPL.Name8 := FORMAT(ZycusInterfaceSetup."Zycus GR Cancel Movement Type");
            InterfaceEntryHeaderVIPL.MODIFY(false);
        end;

        if UndoReturnShipmentL then begin
            ReturnPurchaseHeaderL."Posting Date" := TODAY;
            ReturnPurchaseHeaderL."Your Reference" := InterfaceEntryHeaderVIPL."Your Reference";

            ReturnShipmentLineL2.COPYFILTERS(ReturnShipmentLineL);
            ReturnShipmentLineL2.findset(false);

            PurchaseLineL.RESET();
            PurchaseLineL.SETCURRENTKEY("Document Type", "Document No.", "Delivery Finalized FND", "Line No.");
            PurchaseLineL.SETRANGE("Document Type", ReturnPurchaseHeaderL."Document Type");
            PurchaseLineL.SETRANGE("Document No.", ReturnPurchaseHeaderL."No.");
            PurchaseLineL.SETRANGE("Delivery Finalized FND", true);

            repeat
                ReturnShipmentLineL2."Delivery Finalized FND" := false;
                ReturnShipmentLineL2.MODIFY(false);
                PurchaseLineL.SETRANGE("Line No.", ReturnShipmentLineL2."Return Order Line No.");
                if PurchaseLineL.FINDFIRST() then begin
                    PurchaseLineL.VALIDATE("Delivery Finalized FND", false);
                    PurchaseLineL.MODIFY(false);
                end;
            until ReturnShipmentLineL2.NEXT() = 0;
            ReturnPurchaseHeaderAddL.GET(ReturnPurchaseHeaderL."Document Type", ReturnPurchaseHeaderL."No.");
            ReturnPurchaseHeaderAddL.TESTFIELD("Limit PO", false);
            ReturnPurchaseHeaderAddL."Zycus GR UUID INT" := InterfaceEntryHeaderVIPL.Name4;
            ReturnPurchaseHeaderAddL."Zycus GR Cancel UUID INT" := InterfaceEntryHeaderVIPL.Name5;
            ReturnPurchaseHeaderAddL.MODIFY(false);
            DeleteEmptyPurchaseReturnOrder_Zycus(ReturnPurchaseHeaderL);
            InterfaceEntryHeaderVIPL.Name9 := FORMAT(ZycusInterfaceSetup."Zycus RD Cancel Movement Type");
            InterfaceEntryHeaderVIPL.MODIFY(false);
        end;
        //HEI.05<<
    end;

    procedure OutboundGoodsReceiptCancellationOfPurchaseOrderConfirmation_Zycus(var InterfaceEntryNo: Integer; var SourceNo: Code[20]; MovementType: Integer);
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        SendInterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        ReturnShipmentLineL: Record "Return Shipment Line";
        ReturnPurchaseLineL: Record "Purchase Line";
        FoundInterfaceEntryNoL: Boolean;
        MessageNameL: Text[30];
        LocationCodeL: Code[10];
        SourceNoL: Code[20];
        ExternalOrderNoL: Code[20];
        MessageTypeL: Text[35];
        MessageL: Text[250];
        ZycusReferenceL: Text[50];
        ZycusCancelReferenceL: Text[50];
    begin
        //HEI.05>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if InterfaceEntryNo = 0 then
            ERROR(Text037, Text038, Text042, ZycusInterfaceSetup."Zycus GR Cancel Conf Interface");
        if SourceNo = '' then
            ERROR(Text037, Text041, Text042, ZycusInterfaceSetup."Zycus GR Cancel Conf Interface");
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Cancel Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Cancel Conf Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus GR Cancel Movement Type");
        ZycusInterfaceSetup.TESTFIELD("Zycus RD Cancel Movement Type");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Cancel Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GR Cancel Conf Interface");

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, "Source No.", Status);
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryNo);
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus GR Cancel Interface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE("Source No.", SourceNo);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Error);
        if InterfaceEntryHeaderVIPL.FINDLAST() then begin
            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus GR Cancel Conf Interface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := InterfaceEntryHeaderVIPL."Message Name";
            SendInterfaceEntryHeaderVIPL."Location Code" := InterfaceEntryHeaderVIPL."Location Code";
            SendInterfaceEntryHeaderVIPL."Source No." := SourceNo;
            SendInterfaceEntryHeaderVIPL."External Order No." := InterfaceEntryHeaderVIPL."External Order No.";
            SendInterfaceEntryHeaderVIPL."Phone No." := Text002;
            SendInterfaceEntryHeaderVIPL."Message Code" := '3';
            SendInterfaceEntryHeaderVIPL."Your Reference" := InterfaceEntryHeaderVIPL."Your Reference";
            SendInterfaceEntryHeaderVIPL.URL := DELSTR((Text014 + ': ' + InterfaceEntryHeaderVIPL."External Order No." + ': ' + InterfaceEntryHeaderVIPL."Error Message"), MAXSTRLEN(InterfaceEntryHeaderVIPL.URL));
            SendInterfaceEntryHeaderVIPL.Name4 := InterfaceEntryHeaderVIPL.Name4;
            SendInterfaceEntryHeaderVIPL.Name5 := InterfaceEntryHeaderVIPL.Name5;
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
            FoundInterfaceEntryNoL := true;
            exit;
        end;

        if not FoundInterfaceEntryNoL then begin
            InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Processed);
            if InterfaceEntryHeaderVIPL.FINDLAST() then begin
                MessageNameL := InterfaceEntryHeaderVIPL."Message Name";
                LocationCodeL := InterfaceEntryHeaderVIPL."Location Code";
                case MovementType of
                    ZycusInterfaceSetup."Zycus GR Cancel Movement Type":
                        begin
                            PurchRcptLineL.SETCURRENTKEY("Document No.");
                            PurchRcptLineL.SETRANGE("Document No.", SourceNo);
                            if PurchRcptLineL.FINDLAST() then begin
                                SourceNoL := PurchRcptLineL."Document No.";
                                ExternalOrderNoL := PurchRcptLineL."Zycus Order No. FND";
                            end;
                        end;
                    ZycusInterfaceSetup."Zycus RD Cancel Movement Type":
                        begin
                            ReturnShipmentLineL.SETCURRENTKEY("Document No.");
                            ReturnShipmentLineL.SETRANGE("Document No.", SourceNo);
                            if ReturnShipmentLineL.FINDLAST() then begin
                                ReturnPurchaseLineL.GET(ReturnPurchaseLineL."Document Type"::"Return Order",
                                  ReturnShipmentLineL."Return Order No.", ReturnShipmentLineL."Return Order Line No.");
                                SourceNoL := ReturnShipmentLineL."Document No.";
                                ExternalOrderNoL := ReturnShipmentLineL."Zycus Order No. FND";
                            end;
                        end;
                end;
                MessageTypeL := InterfaceEntryHeaderVIPL."Your Reference";
                MessageL := STRSUBSTNO(Text033, SourceNoL);
                ZycusReferenceL := InterfaceEntryHeaderVIPL.Name4;
                ZycusCancelReferenceL := InterfaceEntryHeaderVIPL.Name5;
            end else begin
                InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", "Interface Code", Direction, "Source No.", Status);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", InterfaceEntryNo);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus GR Cancel Interface");
                InterfaceLogHeaderVIPL.SETRANGE(Direction, InterfaceLogHeaderVIPL.Direction::Inbound);
                InterfaceLogHeaderVIPL.SETRANGE("Source No.", SourceNo);
                InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Processed);
                if InterfaceLogHeaderVIPL.FINDLAST() then begin
                    MessageNameL := InterfaceLogHeaderVIPL."Message Name";
                    LocationCodeL := InterfaceLogHeaderVIPL."Location Code";
                    case MovementType of
                        ZycusInterfaceSetup."Zycus GR Cancel Movement Type":
                            begin
                                PurchRcptLineL.SETCURRENTKEY("Document No.");
                                PurchRcptLineL.SETRANGE("Document No.", SourceNo);
                                if PurchRcptLineL.FINDLAST() then begin
                                    SourceNoL := PurchRcptLineL."Document No.";
                                    ExternalOrderNoL := PurchRcptLineL."Zycus Order No. FND";
                                end;
                            end;
                        ZycusInterfaceSetup."Zycus RD Cancel Movement Type":
                            begin
                                ReturnShipmentLineL.SETCURRENTKEY("Document No.");
                                ReturnShipmentLineL.SETRANGE("Document No.", SourceNo);
                                if ReturnShipmentLineL.FINDLAST() then begin
                                    ReturnPurchaseLineL.GET(ReturnPurchaseLineL."Document Type"::"Return Order",
                                      ReturnShipmentLineL."Return Order No.", ReturnShipmentLineL."Return Order Line No.");
                                    SourceNoL := ReturnShipmentLineL."Document No.";
                                    ExternalOrderNoL := ReturnShipmentLineL."Zycus Order No. FND";
                                end;
                            end;
                    end;
                    MessageTypeL := InterfaceLogHeaderVIPL."Your Reference";
                    MessageL := STRSUBSTNO(Text033, SourceNoL);
                    ZycusReferenceL := InterfaceEntryHeaderVIPL.Name4;
                    ZycusCancelReferenceL := InterfaceEntryHeaderVIPL.Name5;
                end;
            end;

            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus GR Cancel Conf Interface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := MessageNameL;
            SendInterfaceEntryHeaderVIPL."Location Code" := LocationCodeL;
            SendInterfaceEntryHeaderVIPL."Source No." := SourceNoL;
            SendInterfaceEntryHeaderVIPL."External Order No." := ExternalOrderNoL;
            SendInterfaceEntryHeaderVIPL."Phone No." := Text003;
            SendInterfaceEntryHeaderVIPL."Message Code" := '1';
            SendInterfaceEntryHeaderVIPL."Your Reference" := MessageTypeL;
            SendInterfaceEntryHeaderVIPL.URL := MessageL;
            SendInterfaceEntryHeaderVIPL."Prod. Order Line No." := MovementType;
            SendInterfaceEntryHeaderVIPL.Name4 := ZycusReferenceL;
            SendInterfaceEntryHeaderVIPL.Name5 := ZycusCancelReferenceL;
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
        end;
        //HEI.05<<
    end;

    procedure InboundProcessGoodsReceiptOfLimitPurchaseOrder_Zycus(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        PurchaseLineL: Record "Purchase Line";
        GRPurchaseLineL: Record "Purchase Line";
        PurchPostYesNoL: Codeunit "Purch.-Post (Yes/No)";
        GRPurchaseLineL2: Record "Purchase Line";
        PostReceiptL: Boolean;
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
        PurchaseLineOriginalL: Record "Purchase Line";
        LastPurchaseLineL: Record "Purchase Line";
        DummyInvNoL: Label 'CHG2210794_Inv';
        InterfacePurchCode: Codeunit InterfacePurchCode; //BC Upgrade GUNREM01 
    begin
        //HEI.05>>
        CLEAR(ZycusInterfaceSetupRead);
        CLEAR(GeneralInterfaceSetupRead);
        CLEAR(CompanyInformationRead);
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus LPO GR CreationInterface");
        ZycusInterfaceSetup.TESTFIELD("Zycus LPO GR Conf Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR CreationInterface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR Conf Interface");
        InterfaceEntryHeaderVIP.TESTFIELD("Entry No.");
        InterfaceEntryHeaderVIP.TESTFIELD("Interface Code", ZycusInterfaceSetup."Zycus LPO GR CreationInterface");
        InterfaceEntryHeaderVIP.TESTFIELD("External Order No.");
        InterfaceEntryHeaderVIP.TESTFIELD(Name4);

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, Status, "External Order No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus LPO GR CreationInterface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Pending);
        InterfaceEntryHeaderVIPL.SETRANGE("External Order No.", InterfaceEntryHeaderVIP."External Order No.");
        InterfaceEntryHeaderVIPL.FINDFIRST();

        InterfaceEntryLineVIPL.SETCURRENTKEY("Header Entry No.", "External Order No.");
        InterfaceEntryLineVIPL.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        InterfaceEntryLineVIPL.SETRANGE("External Order No.", InterfaceEntryHeaderVIPL."External Order No.");
        InterfaceEntryLineVIPL.findset(false);
        GetPurchaseSetup_Zycus();
        PurchaseHeaderL.GET(PurchaseHeaderL."Document Type"::Order, InterfaceEntryHeaderVIPL."External Order No.");
        PurchaseHeaderAddL.GET(PurchaseHeaderAddL."Document Type"::Order, InterfaceEntryHeaderVIPL."External Order No.");
        PurchaseHeaderAddL.TESTFIELD("Limit PO", true);
        PurchaseHeaderL."Posting Date" := TODAY;
        PurchaseHeaderL."Document Date" := InterfaceEntryHeaderVIPL."Document Date";
        PurchaseHeaderL."Vendor Shipment No." := InterfaceEntryHeaderVIPL."External Document No.";
        PurchaseHeaderL."Your Reference" := InterfaceEntryHeaderVIPL."Your Reference";
        PurchaseHeaderL.MODIFY(false);
        PurchaseHeaderAddL."Zycus GR UUID INT" := InterfaceEntryHeaderVIPL.Name4;
        PurchaseHeaderAddL."GR Transaction Intf Zycus INT" := ZycusInterfaceSetup."Zycus LPO GR CreationInterface";
        PurchaseHeaderAddL."Processed GR Trans. Zycus INT" := true;
        PurchaseHeaderAddL.MODIFY(false);

        GRPurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND");
        GRPurchaseLineL.SETRANGE("Document Type", GRPurchaseLineL."Document Type"::Order);
        GRPurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");
        if GRPurchaseLineL.findset(false) then begin
            PurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Line No.", "Delivery Finalized FND", Quantity, "Outstanding Quantity");
            PurchaseLineL.COPYFILTERS(GRPurchaseLineL);
            repeat
                GRPurchaseLineL.TESTFIELD(Type, GRPurchaseLineL.Type::"G/L Account");
                PurchaseLineL.SETRANGE("Line No.", GRPurchaseLineL."Line No.");
                PurchaseLineL.SETRANGE("Delivery Finalized FND", false);
                PurchaseLineL.SETFILTER(Quantity, '<>0');
                PurchaseLineL.SETFILTER("Outstanding Quantity", '<>0');
                if PurchaseLineL.FINDFIRST() then begin
                    PurchaseLineL.VALIDATE("Qty. to Receive", 1);
                    PurchaseLineL.MODIFY(false);
                end;
            until GRPurchaseLineL.NEXT() = 0;
        end;
        PurchaseHeaderL.Receive := true;
        PurchaseHeaderL.Invoice := true;
        PurchaseHeaderL."Vendor Invoice No." := DummyInvNoL;
        COMMIT();
        //   PurchPostYesNoL.PreviewSRMInterface(PurchaseHeaderL);  // BC Upgrade NANDIS03 
        //  InterfacePurchCode.PreviewSRMInterface(PurchaseHeaderL); //BC Upgrade GUNREM01 -PreviewSRMInterface fucntion added in InterfacePurchCode codeunit//BC Upgrade SHARMP16--Zycus
        InterfacePurchCode.PreviewSRMInterface1(PurchaseHeaderL); //BC Upgrade SHARMP16--Zycus

        GRPurchaseLineL2.COPYFILTERS(GRPurchaseLineL);
        if GRPurchaseLineL2.findset(true) then begin
            repeat
                GRPurchaseLineL2.VALIDATE("Qty. to Receive", 0);
                GRPurchaseLineL2.MODIFY(true);
            until GRPurchaseLineL2.NEXT() = 0;
        end;

        PurchaseLineL.RESET();
        PurchaseLineL.SETCURRENTKEY("Document Type", "Zycus Order No. FND", "Zycus Order Line No. FND");
        PurchaseLineL.SETRANGE("Document Type", PurchaseLineL."Document Type"::Order);
        PurchaseLineL.SETRANGE("Zycus Order No. FND", InterfaceEntryLineVIPL."External Order No.");

        repeat
            CLEAR(ReleasePurchaseDocumentL);
            InterfaceEntryLineVIPL.TESTFIELD("External Order No.", InterfaceEntryHeaderVIPL."External Order No.");
            InterfaceEntryLineVIPL.TESTFIELD("External Order Line No.");
            PurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
            PurchaseLineL.FINDFIRST();
            if PurchaseLineL."Block Line Ordering FND" = PurchaseLineL."Block Line Ordering FND"::B then
                ERROR(Text032, PurchaseLineL.FIELDCAPTION("Block Line Ordering FND"), FORMAT(PurchaseLineL."Block Line Ordering FND"),
                  PurchaseLineL."Document No.", PurchaseLineL."Line No.");

            PostReceiptL := true;
            ReleasePurchaseDocumentL.Reopen(PurchaseHeaderL);
            PurchaseLineOriginalL.COPYFILTERS(PurchaseLineL);
            LastPurchaseLineL.RESET();
            LastPurchaseLineL.SETCURRENTKEY("Document Type", "Document No.");
            LastPurchaseLineL.SETRANGE("Document Type", LastPurchaseLineL."Document Type"::Order);
            LastPurchaseLineL.SETRANGE("Document No.", PurchaseLineL."Document No.");
            LastPurchaseLineL.FINDLAST();
            PurchaseLineOriginalL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
            PurchaseLineOriginalL.FINDFIRST();
            if PurchaseLineOriginalL."Quantity Received" <> 0 then begin
                PurchaseLineOriginalL.SETRANGE("Zycus Order Line No. FND");
                PurchaseLineOriginalL.SETRANGE("Additional Description FND", FORMAT(InterfaceEntryLineVIPL."External Order Line No."));
                PurchaseLineOriginalL.SETRANGE("Quantity Received", 0);
                PurchaseLineOriginalL.FINDLAST();
            end else if PurchaseLineOriginalL."Direct Unit Cost" = 0 then begin
                PurchaseLineOriginalL.SETRANGE("Zycus Order Line No. FND");
                PurchaseLineOriginalL.SETRANGE("Additional Description FND", FORMAT(InterfaceEntryLineVIPL."External Order Line No."));
                PurchaseLineOriginalL.FINDLAST();
            end;
            CreateLimitPOLine_Zycus(PurchaseLineOriginalL, PurchaseLineL, LastPurchaseLineL."Line No.", InterfaceEntryLineVIPL);
            CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchaseHeaderL);
        until InterfaceEntryLineVIPL.NEXT() = 0;

        if PostReceiptL then begin
            PurchaseHeaderL.Receive := true;
            PurchaseHeaderL.Invoice := false;
            PurchaseHeaderL."Vendor Invoice No." := '';
            CODEUNIT.RUN(CODEUNIT::"Purch.-Post", PurchaseHeaderL);

            InterfaceEntryLineVIPL.SETRANGE("Delivery Finalized", true);
            if InterfaceEntryLineVIPL.findset(false) then begin
                repeat
                    PurchaseLineL.SETRANGE("Zycus Order Line No. FND", InterfaceEntryLineVIPL."External Order Line No.");
                    PurchaseLineL.FINDFIRST();
                    PurchaseLineL.VALIDATE("Delivery Finalized FND", InterfaceEntryLineVIPL."Delivery Finalized");
                    PurchaseLineL.MODIFY(false);
                until InterfaceEntryLineVIPL.NEXT() = 0;
            end;
        end;
        //HEI.05<<
    end;

    procedure OutboundGoodsReceiptOfLimitPurchaseOrderConfirmation_Zycus(var InterfaceEntryNo: Integer; var ExternalOrderNo: Code[20]; MovementType: Integer);
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        SendInterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        ReturnShipmentLineL: Record "Return Shipment Line";
        ReturnPurchaseLineL: Record "Purchase Line";
        FoundInterfaceEntryNoL: Boolean;
        MessageNameL: Text[30];
        LocationCodeL: Code[10];
        SourceNoL: Code[20];
        ExternalOrderNoL: Code[20];
        MessageTypeL: Text[35];
        MessageL: Text[250];
        ZycusReferenceL: Text[50];
    begin
        //HEI.05>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if InterfaceEntryNo = 0 then
            ERROR(Text037, Text038, Text043, ZycusInterfaceSetup."Zycus LPO GR Conf Interface");
        if ExternalOrderNo = '' then
            ERROR(Text037, Text039, Text043, ZycusInterfaceSetup."Zycus LPO GR Conf Interface");
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus LPO GR CreationInterface");
        ZycusInterfaceSetup.TESTFIELD("Zycus LPO GR Conf Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR CreationInterface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR Conf Interface");

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, "External Order No.", Status);
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryNo);
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus LPO GR CreationInterface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE("External Order No.", ExternalOrderNo);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Error);
        if InterfaceEntryHeaderVIPL.FINDLAST() then begin
            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus LPO GR Conf Interface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := InterfaceEntryHeaderVIPL."Message Name";
            SendInterfaceEntryHeaderVIPL."Location Code" := InterfaceEntryHeaderVIPL."Location Code";
            SendInterfaceEntryHeaderVIPL."Source No." := SourceNoL;
            SendInterfaceEntryHeaderVIPL."External Order No." := InterfaceEntryHeaderVIPL."External Order No.";
            SendInterfaceEntryHeaderVIPL."Phone No." := Text002;
            SendInterfaceEntryHeaderVIPL."Message Code" := '3';
            SendInterfaceEntryHeaderVIPL."Your Reference" := InterfaceEntryHeaderVIPL."Your Reference";
            SendInterfaceEntryHeaderVIPL.URL := DELSTR((Text014 + ': ' + InterfaceEntryHeaderVIPL."External Order No." + ': ' + InterfaceEntryHeaderVIPL."Error Message"), MAXSTRLEN(InterfaceEntryHeaderVIPL.URL));
            SendInterfaceEntryHeaderVIPL.Name4 := InterfaceEntryHeaderVIPL.Name4;
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
            FoundInterfaceEntryNoL := true;
            exit;
        end;

        if not FoundInterfaceEntryNoL then begin
            InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Processed);
            if InterfaceEntryHeaderVIPL.FINDLAST() then begin
                MessageNameL := InterfaceEntryHeaderVIPL."Message Name";
                LocationCodeL := InterfaceEntryHeaderVIPL."Location Code";

                PurchRcptLineL.SETCURRENTKEY("Order No.", "Zycus Order No. FND");
                PurchRcptLineL.SETRANGE("Order No.", ExternalOrderNo);
                PurchRcptLineL.SETRANGE("Zycus Order No. FND", ExternalOrderNo);
                if PurchRcptLineL.FINDLAST() then
                    SourceNoL := PurchRcptLineL."Document No.";
                ExternalOrderNoL := InterfaceEntryHeaderVIPL."External Order No.";
                MessageTypeL := InterfaceEntryHeaderVIPL."Your Reference";
                MessageL := STRSUBSTNO(Text033, SourceNoL);
                ZycusReferenceL := InterfaceEntryHeaderVIPL.Name4;
            end else begin
                InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", "Interface Code", Direction, "External Order No.", Status);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", InterfaceEntryNo);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus LPO GR CreationInterface");
                InterfaceLogHeaderVIPL.SETRANGE(Direction, InterfaceLogHeaderVIPL.Direction::Inbound);
                InterfaceLogHeaderVIPL.SETRANGE("External Order No.", ExternalOrderNo);
                InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Processed);
                if InterfaceLogHeaderVIPL.FINDLAST() then begin
                    MessageNameL := InterfaceLogHeaderVIPL."Message Name";
                    LocationCodeL := InterfaceLogHeaderVIPL."Location Code";

                    PurchRcptLineL.SETCURRENTKEY("Order No.", "Zycus Order No. FND");
                    PurchRcptLineL.SETRANGE("Order No.", ExternalOrderNo);
                    PurchRcptLineL.SETRANGE("Zycus Order No. FND", ExternalOrderNo);
                    if PurchRcptLineL.FINDLAST() then
                        SourceNoL := PurchRcptLineL."Document No.";
                    ExternalOrderNoL := InterfaceLogHeaderVIPL."External Order No.";
                    MessageTypeL := InterfaceLogHeaderVIPL."Your Reference";
                    MessageL := STRSUBSTNO(Text033, SourceNoL);
                    ZycusReferenceL := InterfaceEntryHeaderVIPL.Name4;
                end;
            end;

            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus LPO GR Conf Interface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := MessageNameL;
            SendInterfaceEntryHeaderVIPL."Location Code" := LocationCodeL;
            SendInterfaceEntryHeaderVIPL."Source No." := SourceNoL;
            SendInterfaceEntryHeaderVIPL."External Order No." := ExternalOrderNoL;
            SendInterfaceEntryHeaderVIPL."Phone No." := Text003;
            SendInterfaceEntryHeaderVIPL."Message Code" := '1';
            SendInterfaceEntryHeaderVIPL."Your Reference" := MessageTypeL;
            SendInterfaceEntryHeaderVIPL.URL := MessageL;
            SendInterfaceEntryHeaderVIPL."Prod. Order Line No." := MovementType;
            SendInterfaceEntryHeaderVIPL.Name4 := ZycusReferenceL;
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
        end;
        //HEI.05<<
    end;

    procedure InboundProcessGoodsReceiptCancellationOfLimitPurchaseOrder_Zycus(var InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        PurchaseHeaderL: Record "Purchase Header";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
        PurchRcptLineL: Record "Purch. Rcpt. Line";
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";
        UndoPurchaseReceiptLineL: Codeunit "Undo Purchase Receipt Line";
        UndoReceiptL: Boolean;
        PurchRcptHeaderAddL: Record "Purch. Rcpt. Header Add FND";
        PurchRcptLineL2: Record "Purch. Rcpt. Line";
        PurchRcptLineL3: Record "Purch. Rcpt. Line";
    begin
        //HEI.05>>
        CLEAR(ZycusInterfaceSetupRead);
        CLEAR(GeneralInterfaceSetupRead);
        CLEAR(CompanyInformationRead);
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus LPO GR Cancel Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus LPO GR CanlConfInterface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR Cancel Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR CanlConfInterface");
        InterfaceEntryHeaderVIP.TESTFIELD("Entry No.");
        InterfaceEntryHeaderVIP.TESTFIELD("Interface Code", ZycusInterfaceSetup."Zycus LPO GR Cancel Interface");
        InterfaceEntryHeaderVIP.TESTFIELD("External Order No.");
        InterfaceEntryHeaderVIP.TESTFIELD(Name4);
        InterfaceEntryHeaderVIP.TESTFIELD(Name5);

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, Status, "External Order No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus LPO GR Cancel Interface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Pending);
        InterfaceEntryHeaderVIPL.SETRANGE("External Order No.", InterfaceEntryHeaderVIP."External Order No.");
        InterfaceEntryHeaderVIPL.FINDFIRST();
        GetPurchaseSetup_Zycus();

        PurchRcptHeaderAddL.SETCURRENTKEY("Zycus Order No. FND", "Zycus GR UUID FND", "Zycus GR Cancel UUID FND");
        PurchRcptHeaderAddL.SETRANGE("Zycus Order No. FND", InterfaceEntryHeaderVIPL."External Order No.");
        PurchRcptHeaderAddL.SETRANGE("Zycus GR UUID FND", InterfaceEntryHeaderVIPL.Name4);
        PurchRcptHeaderAddL.SETRANGE("Zycus GR Cancel UUID FND", '');
        PurchRcptHeaderAddL.FINDFIRST();

        PurchRcptLineL.SETCURRENTKEY("Document No.", Type, Quantity, Correction);
        PurchRcptLineL.SETRANGE("Document No.", PurchRcptHeaderAddL."No.");
        PurchRcptLineL.SETRANGE(Type, PurchRcptLineL.Type::"G/L Account");
        PurchRcptLineL.SETFILTER(Quantity, '>0');
        PurchRcptLineL.SETRANGE(Correction, false);
        PurchRcptLineL.findset(false);
        PurchaseHeaderL.GET(PurchaseHeaderL."Document Type"::Order, PurchRcptLineL."Order No.");
        PurchaseHeaderAddL.GET(PurchaseHeaderAddL."Document Type"::Order, PurchRcptLineL."Order No.");
        PurchaseHeaderAddL.TESTFIELD("Limit PO", true);

        repeat
            if PurchRcptLineL."Qty. Rcd. Not Invoiced" <> PurchRcptLineL.Quantity then
                ERROR(Text036, PurchRcptLineL."Document No.", PurchRcptLineL."Zycus Order Line No. FND");
        until PurchRcptLineL.NEXT() = 0;

        PurchRcptLineL2.COPYFILTERS(PurchRcptLineL);
        PurchRcptLineL2.findset(false);
        repeat
            CLEAR(UndoPurchaseReceiptLineL);
            UndoPurchaseReceiptLineL.SetHideDialog(true);
            UndoPurchaseReceiptLineL.RUN(PurchRcptLineL2);
            UndoReceiptL := true;
        until PurchRcptLineL2.NEXT() = 0;
        PurchRcptHeaderAddL."Zycus GR Cancel UUID FND" := InterfaceEntryHeaderVIPL.Name5;
        PurchRcptHeaderAddL.MODIFY(false);

        if UndoReceiptL then begin
            PurchRcptLineL3.SETCURRENTKEY("Document No.", Type, Quantity, Correction);
            PurchRcptLineL3.COPYFILTERS(PurchRcptLineL);
            PurchRcptLineL3.SETRANGE(Correction);
            PurchRcptLineL3.findset(false);
            repeat
                UpdateOriginalLineOnUndo_Zycus(PurchaseHeaderL, PurchRcptLineL3);
            until PurchRcptLineL3.NEXT() = 0;
        end;
        //HEI.05<<
    end;

    procedure OutboundGoodsReceiptCancellationOfLimitPurchaseOrderConfirmation_Zycus(var InterfaceEntryNo: Integer; var ExternalOrderNo: Code[20]; MovementType: Integer; ZycusGRUUID: Text[50]);
    var
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        SendInterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        PurchRcptHeaderAddL: Record "Purch. Rcpt. Header Add FND";
        ReturnShipmentLineL: Record "Return Shipment Line";
        ReturnPurchaseLineL: Record "Purchase Line";
        FoundInterfaceEntryNoL: Boolean;
        MessageNameL: Text[30];
        LocationCodeL: Code[10];
        SourceNoL: Code[20];
        ExternalOrderNoL: Code[20];
        MessageTypeL: Text[35];
        MessageL: Text[250];
        ZycusReferenceL: Text[50];
        ZycusCancelReferenceL: Text[50];
    begin
        //HEI.05>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if not ZycusInterfaceSetup."Activate GR Interface" then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if InterfaceEntryNo = 0 then
            ERROR(Text037, Text038, Text044, ZycusInterfaceSetup."Zycus LPO GR CanlConfInterface");
        if ExternalOrderNo = '' then
            ERROR(Text037, Text039, Text043, ZycusInterfaceSetup."Zycus LPO GR CanlConfInterface");
        if ZycusGRUUID = '' then
            ERROR(Text037, Text045, Text043, ZycusInterfaceSetup."Zycus LPO GR CanlConfInterface");
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        ZycusInterfaceSetup.TESTFIELD("Zycus LPO GR Cancel Interface");
        ZycusInterfaceSetup.TESTFIELD("Zycus LPO GR CanlConfInterface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR Cancel Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus LPO GR CanlConfInterface");

        InterfaceEntryHeaderVIPL.SETCURRENTKEY("Entry No.", "Interface Code", Direction, "External Order No.", Name4, Status);
        InterfaceEntryHeaderVIPL.SETRANGE("Entry No.", InterfaceEntryNo);
        InterfaceEntryHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus LPO GR Cancel Interface");
        InterfaceEntryHeaderVIPL.SETRANGE(Direction, InterfaceEntryHeaderVIPL.Direction::Inbound);
        InterfaceEntryHeaderVIPL.SETRANGE("External Order No.", ExternalOrderNo);
        InterfaceEntryHeaderVIPL.SETRANGE(Name4, ZycusGRUUID);
        InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Error);
        if InterfaceEntryHeaderVIPL.FINDLAST() then begin
            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus LPO GR CanlConfInterface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := InterfaceEntryHeaderVIPL."Message Name";
            SendInterfaceEntryHeaderVIPL."Location Code" := InterfaceEntryHeaderVIPL."Location Code";
            SendInterfaceEntryHeaderVIPL."Source No." := SourceNoL;
            SendInterfaceEntryHeaderVIPL."External Order No." := InterfaceEntryHeaderVIPL."External Order No.";
            SendInterfaceEntryHeaderVIPL."Phone No." := Text002;
            SendInterfaceEntryHeaderVIPL."Message Code" := '3';
            SendInterfaceEntryHeaderVIPL."Your Reference" := InterfaceEntryHeaderVIPL."Your Reference";
            SendInterfaceEntryHeaderVIPL.URL := DELSTR((Text014 + ': ' + InterfaceEntryHeaderVIPL."External Order No." + ': ' + InterfaceEntryHeaderVIPL."Error Message"), MAXSTRLEN(InterfaceEntryHeaderVIPL.URL));
            SendInterfaceEntryHeaderVIPL.Name4 := InterfaceEntryHeaderVIPL.Name4;
            SendInterfaceEntryHeaderVIPL.Name5 := InterfaceEntryHeaderVIPL.Name5;
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
            FoundInterfaceEntryNoL := true;
            exit;
        end;

        if not FoundInterfaceEntryNoL then begin
            InterfaceEntryHeaderVIPL.SETRANGE(Status, InterfaceEntryHeaderVIPL.Status::Processed);
            if InterfaceEntryHeaderVIPL.FINDLAST() then begin
                MessageNameL := InterfaceEntryHeaderVIPL."Message Name";
                LocationCodeL := InterfaceEntryHeaderVIPL."Location Code";

                PurchRcptHeaderAddL.SETCURRENTKEY("Zycus Order No. FND", "Zycus GR UUID FND");
                PurchRcptHeaderAddL.SETRANGE("Zycus Order No. FND", ExternalOrderNo);
                PurchRcptHeaderAddL.SETRANGE("Zycus GR UUID FND", ZycusGRUUID);
                if PurchRcptHeaderAddL.FINDLAST() then
                    SourceNoL := PurchRcptHeaderAddL."No.";
                ExternalOrderNoL := InterfaceEntryHeaderVIPL."External Order No.";
                MessageTypeL := InterfaceEntryHeaderVIPL."Your Reference";
                MessageL := STRSUBSTNO(Text033, SourceNoL);
                ZycusReferenceL := InterfaceEntryHeaderVIPL.Name4;
                ZycusCancelReferenceL := InterfaceEntryHeaderVIPL.Name5;
            end else begin
                InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", "Interface Code", Direction, "External Order No.", Name4, Status);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", InterfaceEntryNo);
                InterfaceLogHeaderVIPL.SETRANGE("Interface Code", ZycusInterfaceSetup."Zycus LPO GR Cancel Interface");
                InterfaceLogHeaderVIPL.SETRANGE(Direction, InterfaceLogHeaderVIPL.Direction::Inbound);
                InterfaceLogHeaderVIPL.SETRANGE("External Order No.", ExternalOrderNo);
                InterfaceLogHeaderVIPL.SETRANGE(Name4, ZycusGRUUID);
                InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Processed);
                if InterfaceLogHeaderVIPL.FINDLAST() then begin
                    MessageNameL := InterfaceLogHeaderVIPL."Message Name";
                    LocationCodeL := InterfaceLogHeaderVIPL."Location Code";

                    PurchRcptHeaderAddL.SETCURRENTKEY("Zycus Order No. FND", "Zycus GR UUID FND");
                    PurchRcptHeaderAddL.SETRANGE("Zycus Order No. FND", ExternalOrderNo);
                    PurchRcptHeaderAddL.SETRANGE("Zycus GR UUID FND", ZycusGRUUID);
                    if PurchRcptHeaderAddL.FINDLAST() then
                        SourceNoL := PurchRcptHeaderAddL."No.";
                    ExternalOrderNoL := InterfaceLogHeaderVIPL."External Order No.";
                    MessageTypeL := InterfaceLogHeaderVIPL."Your Reference";
                    MessageL := STRSUBSTNO(Text033, SourceNoL);
                    ZycusReferenceL := InterfaceEntryHeaderVIPL.Name4;
                    ZycusCancelReferenceL := InterfaceEntryHeaderVIPL.Name5;
                end;
            end;

            SendInterfaceEntryHeaderVIPL.INIT();
            SendInterfaceEntryHeaderVIPL."Interface Code" := ZycusInterfaceSetup."Zycus LPO GR CanlConfInterface";
            SendInterfaceEntryHeaderVIPL.Direction := SendInterfaceEntryHeaderVIPL.Direction::Outbound;
            SendInterfaceEntryHeaderVIPL.Status := SendInterfaceEntryHeaderVIPL.Status::Pending;
            SendInterfaceEntryHeaderVIPL."Legal Entity" := CompanyInformation."Legal Entity Code FND";
            SendInterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
            SendInterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := ZycusInterfaceSetup."HeiLite Business System ID";
            SendInterfaceEntryHeaderVIPL."Msg. Recv. Business System ID" := ZycusInterfaceSetup."Zycus Business System ID";
            SendInterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Purchase Header";
            SendInterfaceEntryHeaderVIPL."Message Name" := MessageNameL;
            SendInterfaceEntryHeaderVIPL."Location Code" := LocationCodeL;
            SendInterfaceEntryHeaderVIPL."Source No." := SourceNoL;
            SendInterfaceEntryHeaderVIPL."External Order No." := ExternalOrderNoL;
            SendInterfaceEntryHeaderVIPL."Phone No." := Text003;
            SendInterfaceEntryHeaderVIPL."Message Code" := '1';
            SendInterfaceEntryHeaderVIPL."Your Reference" := MessageTypeL;
            SendInterfaceEntryHeaderVIPL.URL := MessageL;
            SendInterfaceEntryHeaderVIPL."Prod. Order Line No." := MovementType;
            SendInterfaceEntryHeaderVIPL.Name4 := ZycusReferenceL;
            SendInterfaceEntryHeaderVIPL.Name5 := ZycusCancelReferenceL;
            SendInterfaceEntryHeaderVIPL."Message Creation DateTime" := CURRENTDATETIME;
            SendInterfaceEntryHeaderVIPL."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
            SendInterfaceEntryHeaderVIPL."Version No." := FORMAT(InterfaceEntryNo);
            SendInterfaceEntryHeaderVIPL.INSERT(true);
        end;
        //HEI.05<<
    end;

    local procedure CreateLimitPOLine_Zycus(var PurchaseLineOriginal: Record "Purchase Line"; var PurchaseLine: Record "Purchase Line"; var LastPurchaseLineNo: Integer; var InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT");
    var
        PurchaseLineLPOL: Record "Purchase Line";
        InitialRemAmtL: Decimal;
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
    begin
        //HEI.05>>
        PurchaseLineLPOL.INIT();
        PurchaseLineLPOL."Document Type" := PurchaseLine."Document Type";
        PurchaseLineLPOL."Document No." := PurchaseLine."Document No.";
        PurchaseLineLPOL."Line No." := LastPurchaseLineNo + 10000;
        PurchaseLineLPOL.VALIDATE(Type, PurchaseLine.Type);
        PurchaseLineLPOL.VALIDATE("No.", PurchaseLine."No.");
        PurchaseLineLPOL.VALIDATE(Description, PurchaseLine.Description);
        PurchaseLineLPOL.VALIDATE("Location Code", PurchaseLine."Location Code");
        PurchaseLineLPOL.VALIDATE("Unit of Measure Code", PurchaseLine."Unit of Measure Code");
        PurchaseLineLPOL.VALIDATE(Quantity, PurchaseLine.Quantity);
        PurchaseLineLPOL."Additional Description FND" := FORMAT(PurchaseLine."Zycus Order Line No. FND");
        PurchaseLineLPOL."SRM Contract No. FND" := PurchaseLine."SRM Contract No. FND";
        PurchaseLineLPOL."SRM Contract Line No. FND" := PurchaseLine."SRM Contract Line No. FND";
        PurchaseLineLPOL."Zycus Order No. FND" := PurchaseLine."Zycus Order No. FND";
        PurchaseLineLPOL."Zycus Order Line No. FND" := PurchaseLine."Zycus Order Line No. FND";
        if InterfaceEntryLineVIP."Line Amount" > PurchaseLine."Remaining Amount FND" then
            ERROR(Text030, PurchaseLine.FIELDCAPTION("Remaining Amount FND"), PurchaseLine."Remaining Amount FND");
        if PurchaseHeaderAddL.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") then begin
            if PurchaseHeaderAddL."Limit PO" then begin
                if PurchaseLineOriginal."Direct Unit Cost" = 0 then
                    InitialRemAmtL := PurchaseLineOriginal."Remaining Amount FND"
                else
                    InitialRemAmtL := PurchaseLine."Remaining Amount FND";
            end;
        end;
        PurchaseLineOriginal.VALIDATE("Direct Unit Cost", InterfaceEntryLineVIP."Line Amount");
        if (PurchaseLineOriginal."Additional Description FND" <> '') and (InitialRemAmtL = InterfaceEntryLineVIP."Line Amount") then
            if PurchaseHeaderAddL."Limit PO" then
                PurchaseLineOriginal."Remaining Amount FND" := InitialRemAmtL - InterfaceEntryLineVIP."Line Amount";
        PurchaseLineLPOL.VALIDATE("Direct Unit Cost", InitialRemAmtL - InterfaceEntryLineVIP."Line Amount");
        PurchaseLineOriginal.VALIDATE("Qty. to Receive", 1);
        if PurchaseHeaderAddL."Limit PO" then
            PurchaseLineLPOL."Initial Amount FND" := PurchaseLineLPOL."Direct Unit Cost";
        PurchaseLineLPOL.VALIDATE("Qty. to Receive", 0);
        PurchaseLineLPOL.VALIDATE("Expected Receipt Date", PurchaseLine."Expected Receipt Date");
        PurchaseLineLPOL.VALIDATE("Planned Receipt Date", PurchaseLine."Planned Receipt Date");
        PurchaseLineLPOL."Dimension Set ID" := PurchaseLine."Dimension Set ID";

        // BC Upgrade MISHRS14 >> #HEI.30
        //HEI.30>>
        IF PurchaseLine."Shortcut Dimension 1 Code" <> '' THEN
            PurchaseLineLPOL.VALIDATE("Shortcut Dimension 1 Code", PurchaseLine."Shortcut Dimension 1 Code");
        //HEI.30<<
        // BC Upgrade MISHRS14 <<

        if PurchaseLine."Shortcut Dimension 2 Code" <> '' then
            PurchaseLineLPOL.VALIDATE("Shortcut Dimension 2 Code", PurchaseLine."Shortcut Dimension 2 Code");
        if PurchaseHeaderAddL."Limit PO" then
            PurchaseLine."Remaining Amount FND" := PurchaseLineLPOL."Direct Unit Cost";
        PurchaseLine.MODIFY(false);
        PurchaseLineOriginal.MODIFY(false);
        if PurchaseLine."Remaining Amount FND" > 0 then
            PurchaseLineLPOL.INSERT(false);
        //HEI.05<<
    end;

    local procedure UpdateOriginalLineOnUndo_Zycus(var PurchaseHeader: Record "Purchase Header"; var PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        PurchLineL: Record "Purchase Line";
        PurchaseLineToUndoL: Record "Purchase Line";
        IncomingLineAmtL: Decimal;
        ReleasePurchaseDocumentL: Codeunit "Release Purchase Document";//BC Upgrade SHARMP16--Zycus

    begin
        //HEI.05>>
        ReleasePurchaseDocumentL.Reopen(PurchaseHeader);//BC Upgrade SHARMP16--Zycus

        PurchLineL.SETCURRENTKEY("Document No.", "Line No.", Amount);
        PurchLineL.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchLineL.SETRANGE("Line No.", PurchRcptLine."Order Line No.");
        PurchLineL.SETRANGE(Amount, ABS(PurchRcptLine."Amount Heilite FND"));  //BC Upgrade SHARMP16--Zycus
        // PurchLineL.SETRANGE(Amount, ABS(PurchRcptLine."Line Amount"));  // BC Upgrade NANDIS03 - Blocked as DIT field
        if PurchLineL.FINDFIRST() then begin
            if PurchLineL."SRM Order Line No. FND" <> '' then begin
                IncomingLineAmtL := PurchLineL."Remaining Amount FND";//BC Upgrade SHARMP16--Zycus

                PurchLineL.VALIDATE("Direct Unit Cost", 0);
                PurchLineL."Remaining Amount FND" := PurchLineL."Remaining Amount FND" + PurchRcptLine."Amount Heilite FND";//BC Upgrade SHARMP16--Zycus

                PurchLineL.MODIFY(false);
                PurchaseLineToUndoL.SETCURRENTKEY("Document No.", "Quantity Received", "Additional Description FND");
                PurchaseLineToUndoL.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLineToUndoL.SETRANGE("Quantity Received", 0);
                PurchaseLineToUndoL.SETRANGE("Additional Description FND", FORMAT(PurchRcptLine."Zycus Order Line No. FND"));
                if PurchaseLineToUndoL.FINDLAST() then begin
                    PurchaseLineToUndoL.VALIDATE("Direct Unit Cost", PurchLineL."Remaining Amount FND");
                    PurchaseLineToUndoL.MODIFY();//BC Upgrade SHARMP16--Zycus
                end else begin
                    CreateAdditionalLine_Zycus(PurchRcptLine, PurchLineL);
                end;
            end else begin
                IncreaseOriginalLineRemAmt_Zycus(PurchRcptLine, PurchaseHeader);
                UpdateLastOpenLineOnUndo_Zycus(PurchRcptLine, PurchaseHeader);
                PurchaseLineToUndoL.SETCURRENTKEY("Document No.", "Line No.");
                PurchaseLineToUndoL.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLineToUndoL.SETRANGE("Line No.", PurchRcptLine."Order Line No.");
                if PurchaseLineToUndoL.FINDFIRST() then begin
                    PurchaseLineToUndoL.DELETE(false);
                    if not CheckAdditionalLinesUndo_Zycus(PurchaseHeader."No.", PurchRcptLine."Zycus Order Line No. FND") then
                        CreateAdditionalLine_Zycus(PurchRcptLine, PurchLineL);
                end;
            end;
        end;
        ReleasePurchaseDocumentL.ReleasePurchaseHeader(PurchaseHeader, false);//BC Upgrade SHARMP16--Zycus

        //HEI.05<<
    end;

    local procedure IncreaseOriginalLineRemAmt_Zycus(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchaseHeader: Record "Purchase Header");
    var
        OriginalPurchLineL: Record "Purchase Line";
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
    begin
        //HEI.05>>
        OriginalPurchLineL.SETCURRENTKEY("Document No.", "Zycus Order Line No. FND");
        OriginalPurchLineL.SETRANGE("Document No.", PurchaseHeader."No.");
        OriginalPurchLineL.SETRANGE("Zycus Order Line No. FND", PurchRcptLine."Zycus Order Line No. FND");
        if OriginalPurchLineL.FINDFIRST() then begin
            if PurchaseHeaderAddL.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
                if PurchaseHeaderAddL."Limit PO" then begin
                    // OriginalPurchLineL.VALIDATE("Remaining Amount FND", OriginalPurchLineL."Remaining Amount FND" + ABS(PurchRcptLine."Line Amount"));  // BC Upgrade NANDIS03 - Blocked as DIT field
                    OriginalPurchLineL.VALIDATE("Remaining Amount FND", OriginalPurchLineL."Remaining Amount FND" + ABS(PurchRcptLine."Amount Heilite FND")); //BC Upgrade SHARMP16--Zycus

                    OriginalPurchLineL.MODIFY(false);
                end;
            end;
        end;
        //HEI.05<<
    end;

    local procedure UpdateLastOpenLineOnUndo_Zycus(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchaseHeader: Record "Purchase Header");
    var
        LastPurchaseLineL: Record "Purchase Line";
        PurchRecptLineAmountL: Decimal;
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";

    begin
        //HEI.05>>
        // PurchRecptLineAmountL := PurchRcptLine."Line Amount";  // BC Upgrade NANDIS03 - Blocked as DIT field
        PurchRecptLineAmountL := PurchRcptLine."Amount Heilite FND";  // BC Upgrade NANDIS03 - Blocked as DIT field//BC Upgrade SHARMP16--Interface-D

        LastPurchaseLineL.SETCURRENTKEY("Document No.", "Quantity Received", "Additional Description FND");
        LastPurchaseLineL.SETRANGE("Document No.", PurchaseHeader."No.");
        LastPurchaseLineL.SETRANGE("Quantity Received", 0);
        LastPurchaseLineL.SETRANGE("Additional Description FND", FORMAT(PurchRcptLine."Zycus Order Line No. FND"));
        if LastPurchaseLineL.FINDLAST() then begin
            LastPurchaseLineL.VALIDATE("Direct Unit Cost", LastPurchaseLineL."Direct Unit Cost" + ABS(PurchRecptLineAmountL));
            if PurchaseHeaderAddL.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
                if PurchaseHeaderAddL."Limit PO" then begin
                    LastPurchaseLineL.VALIDATE("Remaining Amount FND", LastPurchaseLineL."Direct Unit Cost");//BC Upgrade SHARMP16--Zycus
                    LastPurchaseLineL.MODIFY(false);
                end;
            end;
        end;
        //HEI.05<<
    end;

    local procedure CreateAdditionalLine_Zycus(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchaseLine: Record "Purchase Line");
    var
        PurchaseLineL: Record "Purchase Line";
        PurchaseLineL2: Record "Purchase Line";
        LineNoL: Integer;
        PurchaseHeaderAddL: Record "Purchase Header Additional FND";
    begin
        //HEI.05>>
        PurchaseLineL2.SETRANGE("Document Type", PurchaseLine."Document Type");
        PurchaseLineL2.SETRANGE("Document No.", PurchaseLine."Document No.");
        if PurchaseLineL2.FINDLAST() then
            LineNoL := PurchaseLineL2."Line No.";

        PurchaseLineL.INIT();
        PurchaseLineL."Document Type" := PurchaseLine."Document Type";
        PurchaseLineL."Document No." := PurchaseLine."Document No.";
        PurchaseLineL."Line No." := LineNoL + 10000;
        PurchaseLineL.VALIDATE(Type, PurchaseLine.Type);
        PurchaseLineL.VALIDATE("No.", PurchaseLine."No.");
        PurchaseLineL.VALIDATE(Description, PurchaseLine.Description);
        PurchaseLineL.VALIDATE("Location Code", PurchRcptLine."Location Code");
        PurchaseLineL.VALIDATE("Unit of Measure Code", PurchaseLine."Unit of Measure Code");
        PurchaseLineL.VALIDATE(Quantity, 1);
        PurchaseLineL."Additional Description FND" := FORMAT(PurchRcptLine."Zycus Order Line No. FND");
        PurchaseLineL."Zycus Order No. FND" := PurchaseLine."Zycus Order No. FND";
        PurchaseLineL."Zycus Order Line No. FND" := PurchaseLine."Zycus Order Line No. FND";
        PurchaseLineL.VALIDATE("Direct Unit Cost", ABS(PurchRcptLine."Amount Heilite FND")); //BC Upgrade SHARMP16--Zycus

        // PurchaseLineL.VALIDATE("Direct Unit Cost", ABS(PurchRcptLine."Line Amount"));  // BC Upgrade NANDIS03 - Blocked as DIT field
        //IF PurchaseHeaderAddL.GET(PurchaseLine."Document Type",PurchaseLine."Document No.") THEN BEGIN
        //IF PurchaseHeaderAddL."Limit PO" THEN
        //PurchaseLineL."Remaining Amount FND" := ABS(PurchRcptLine."Line Amount");
        //END;
        //BC Upgrade SHARMP16--Zycus BEGIN<<
        IF PurchaseHeaderAddL.GET(PurchaseLine."Document Type", PurchaseLine."Document No.") THEN BEGIN
            IF PurchaseHeaderAddL."Limit PO" THEN
                PurchaseLineL."Remaining Amount FND" := ABS(PurchRcptLine."Amount Heilite FND");//BC Upgrade SHARMP16--Interface-D
        END;
        //BC Upgrade SHARMP16--Zycus END>>
        PurchaseLineL."Dimension Set ID" := PurchaseLine."Dimension Set ID";
        PurchaseLineL.INSERT();
        //HEI.05<<
    end;

    local procedure DeleteEmptyPurchaseReturnOrder_Zycus(var ReturnPurchaseHeader: Record "Purchase Header");
    var
        ReturnPurchaseLineL: Record "Purchase Line";
    begin
        //HEI.05>>
        ReturnPurchaseLineL.SETCURRENTKEY("Document Type", "Document No.");
        ReturnPurchaseLineL.SETRANGE("Document Type", ReturnPurchaseHeader."Document Type");
        ReturnPurchaseLineL.SETRANGE("Document No.", ReturnPurchaseHeader."No.");
        if ReturnPurchaseLineL.ISEMPTY then
            ReturnPurchaseHeader.DELETE(true)
        else begin
            if ReturnPurchaseLineL.findset(false) then begin
                repeat
                    if ReturnPurchaseLineL."Outstanding Quantity" = 0 then
                        ReturnPurchaseLineL.DELETE(true);
                until ReturnPurchaseLineL.NEXT() = 0;
            end;
        end;
        //HEI.05<<
    end;

    local procedure CheckAdditionalLinesUndo_Zycus(PONo: Code[20]; ExternalOrderLineNo: Integer): Boolean;
    var
        ClosedPurchaseLineL: Record "Purchase Line";
    begin
        //HEI.05>>
        ClosedPurchaseLineL.SETCURRENTKEY("Document No.", "Additional Description FND", "Quantity Received");
        ClosedPurchaseLineL.SETRANGE("Document No.", PONo);
        ClosedPurchaseLineL.SETRANGE("Additional Description FND", FORMAT(ExternalOrderLineNo));
        ClosedPurchaseLineL.SETRANGE("Quantity Received", 0);
        if not ClosedPurchaseLineL.ISEMPTY then
            exit(true)
        else
            exit(false);
        //HEI.05<<
    end;

    local procedure OutboundGLRuleMapCreateOrUpdate_Zycus(InterfaceCode: Code[20]);
    var
        GLAccRecL: Record "G/L Account";
        InterfaceEntryHeaderVIPL: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL1: Record "Interface Entry Header VIP INT";
        InterfaceEntryHeaderVIPL2: Record "Interface Entry Header VIP INT";
        InterfaceEntryLineVIPL: Record "Interface Entry Line VIP INT";
        InterfaceLogHeaderVIPL: Record "Interface Log Header VIP INT";
        HeaderEntryNoL: Integer;
        EntryNoL: Integer;
        NowL: DateTime;
        LoopCountL: Integer;
        iL: Integer;
        jL: Integer;
        ParkedErrorL: Boolean;
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceSetup: Record "Interface Setup INT";
    begin
        //HEI.09>>
        InterfaceSetup.GET(InterfaceCode);
        GeneralInterfaceSetup.GET();
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CreationOfGLRuleMap();
        CreationOfGLRuleMapCCC();

        TempZycusGLRuleMap.RESET();
        if ZycusInterfaceSetup."Max. GL Rule Per Interface" <> 0 then
            LoopCountL := ROUND((TempZycusGLRuleMap.COUNT / ZycusInterfaceSetup."Max. GL Rule Per Interface"), 1, '>')
        else
            LoopCountL := 1;

        if TempZycusGLRuleMap.findset(false) then begin
            for iL := 1 to LoopCountL do begin
                InterfaceEntryHeaderVIPL.INIT();
                InterfaceEntryHeaderVIPL."Interface Code" := InterfaceCode;
                InterfaceEntryHeaderVIPL.Direction := InterfaceEntryHeaderVIPL.Direction::Outbound;
                InterfaceEntryHeaderVIPL.Status := InterfaceEntryHeaderVIPL.Status::Pending;
                InterfaceEntryHeaderVIPL."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
                InterfaceEntryHeaderVIPL."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
                InterfaceEntryHeaderVIPL."Source Type" := DATABASE::"Zycus GL Rule Map FND";
                InterfaceEntryHeaderVIPL."Source Subtype" := InterfaceEntryHeaderVIPL."Source Subtype"::"0";
                InterfaceEntryHeaderVIPL."Source No." := InterfaceCode;
                InterfaceEntryHeaderVIPL."Message Name" := Text001;
                if iL > 1 then
                    InterfaceEntryHeaderVIPL."Entry No." += 1;
                InterfaceEntryHeaderVIPL.INSERT(true);
                HeaderEntryNoL := InterfaceEntryHeaderVIPL."Entry No.";
                InterfaceEntryHeaderVIPL1.GET(HeaderEntryNoL);
                InterfaceEntryHeaderVIPL1."Message Creation DateTime" := CURRENTDATETIME;
                InterfaceEntryHeaderVIPL1."Sell-to Customer No." := FORMAT(CURRENTDATETIME, 0, '<Month,2>/<Day,2>/<Year> <Hours12,2>:<Minutes,2> <AM/PM>');
                InterfaceEntryHeaderVIPL1.MODIFY(true);

                repeat
                    CLEAR(jL);
                    InterfaceEntryLineVIPL.INIT();
                    InterfaceEntryLineVIPL."Header Entry No." := HeaderEntryNoL;
                    EntryNoL += 1;
                    InterfaceEntryLineVIPL."Entry No." := EntryNoL;
                    InterfaceEntryLineVIPL.Flag := Text001;
                    InterfaceEntryLineVIPL."CMG Code" := TempZycusGLRuleMap."CMG Code";
                    InterfaceEntryLineVIPL."No. 2" := TempZycusGLRuleMap."CTP Code";
                    InterfaceEntryLineVIPL."Ccc Code" := TempZycusGLRuleMap."CCC Code";
                    InterfaceEntryLineVIPL."No." := TempZycusGLRuleMap."GL Account";
                    if TempZycusGLRuleMap."Allowed With Warning" then
                        InterfaceEntryLineVIPL.Closed := true;
                    if TempZycusGLRuleMap."Purchase Type" = TempZycusGLRuleMap."Purchase Type"::CCC then
                        InterfaceEntryLineVIPL."Business Segment Name" := 'CCC'
                    else if TempZycusGLRuleMap."Purchase Type" = TempZycusGLRuleMap."Purchase Type"::WBS then
                        InterfaceEntryLineVIPL."Business Segment Name" := 'WBS';
                    InterfaceEntryLineVIPL.Blocked := TempZycusGLRuleMap.Blocked;
                    InterfaceEntryLineVIPL.INSERT(true);
                until (TempZycusGLRuleMap.NEXT() = 0) or (EntryNoL = (ZycusInterfaceSetup."Max. GL Rule Per Interface" * iL));

                if (HeaderEntryNoL <> 0) or (not ParkedErrorL) then begin
                    InterfaceEntryHeaderVIPL2.RESET();
                    InterfaceEntryHeaderVIPL2.SETCURRENTKEY("Entry No.", Status, "Source No.");
                    InterfaceEntryHeaderVIPL2.SETRANGE("Entry No.", HeaderEntryNoL);
                    InterfaceEntryHeaderVIPL2.SETRANGE(Status, InterfaceEntryHeaderVIPL2.Status::Error);
                    InterfaceEntryHeaderVIPL2.SETRANGE("Source No.", InterfaceCode);
                    if not InterfaceEntryHeaderVIPL2.ISEMPTY then
                        ParkedErrorL := true
                    else if not ParkedErrorL then begin
                        InterfaceLogHeaderVIPL.RESET();
                        InterfaceLogHeaderVIPL.SETCURRENTKEY("Interface Entry No.", Status, "Source No.");
                        InterfaceLogHeaderVIPL.SETRANGE("Interface Entry No.", HeaderEntryNoL);
                        InterfaceLogHeaderVIPL.SETRANGE(Status, InterfaceLogHeaderVIPL.Status::Error);
                        InterfaceLogHeaderVIPL.SETRANGE("Source No.", InterfaceCode);
                        if not InterfaceLogHeaderVIPL.ISEMPTY then
                            ParkedErrorL := true;
                    end;
                end;
            end;
        end;

        if (HeaderEntryNoL <> 0) and (EntryNoL <> 0) and (not ParkedErrorL) then begin
            NowL := GetLocalCurrentDateTime_Zycus();
            ZycusInterfaceSetupL.GET();
            ZycusInterfaceSetupL."Last Zycus GL Rule Sync Time" := NowL;
            ZycusInterfaceSetupL.MODIFY(false);
        end;

        NowL := GetLocalCurrentDateTime_Zycus();
        ZycusInterfaceSetupL.GET();
        ZycusInterfaceSetupL."Last Interface Run Time GLRule" := NowL;
        ZycusInterfaceSetupL.MODIFY();
        //HEI.09<<
    end;


    // BC Upgrade NANDIS03 - Blocked  as table id was used >>
    // [EventSubscriber(ObjectType::Codeunit, 50212, 'OnScheduleGLRuleMapCCCCreateOrUpdate_Zycus', '', false, false)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Zycus Interface Auto Outbound", 'OnScheduleGLRuleMapCCCCreateOrUpdate_Zycus', '', false, false)]
    local procedure OnAfterGLRuleMapCreateOrUpdate_Zycus(PreviewMode: Boolean);
    begin
        //HEI.09>>
        GetCompanyInformation_Zycus();
        GetGeneralInterfaceSetup_Zycus();
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetup."Activate GL Rule Map Interface" then
            exit;
        ZycusInterfaceSetup.TESTFIELD("Zycus GL Rule Map Interface");
        ValidateInterfaceSetup_Zycus(ZycusInterfaceSetup."Zycus GL Rule Map Interface");
        OutboundGLRuleMapCreateOrUpdate_Zycus(ZycusInterfaceSetup."Zycus GL Rule Map Interface");
        //HEI.09<<
    end;

    local procedure CheckForValidGLRuleMap(GLAccRecLP: Record "G/L Account"): Boolean;
    var
        CMGMappingRecL: Record "CMG Mapping FND";
    begin
        //HEI.09>>
        if GLAccRecLP.Blocked then
            exit(true);
        ZycusInterfaceSetup.GET();
        if (ZycusInterfaceSetup."G/L Account Position" <> 0) and (ZycusInterfaceSetup."G/L Account Position Value" <> '') then begin
            if COPYSTR(GLAccRecLP."No.", ZycusInterfaceSetup."G/L Account Position", 1) <> ZycusInterfaceSetup."G/L Account Position Value" then
                exit(true)
            else
                exit(false);
        end else
            exit(true);
        //HEI.09<<
    end;

    procedure CreationOfValidGLRuleMap();
    var
        GLAccRecL: Record "G/L Account";
        ZycusMasterTimestampLV: Record "Zycus Master Timestamp FND";
        GLAccRecLV: Record "G/L Account";
    begin
        //HEI.09>>
        ZycusInterfaceSetup.GET();
        if ZycusInterfaceSetup."Last Zycus Account Sync Time" = 0DT then begin
            InitializeZycusGLMastTimestamp();
        end;

        CLEAR(TempGLAccRec);
        ZycusMasterTimestampLV.RESET();
        ZycusMasterTimestampLV.SETCURRENTKEY("Table ID", Deleted, "Last Local Change Datetime");
        ZycusMasterTimestampLV.SETRANGE(ZycusMasterTimestampLV."Table ID", DATABASE::"G/L Account");
        ZycusMasterTimestampLV.SETRANGE(ZycusMasterTimestampLV.Deleted, false);
        ZycusMasterTimestampLV.SETFILTER(ZycusMasterTimestampLV."Last Local Change Datetime", '%1|>%2', 0DT, ZycusInterfaceSetup."Last Zycus Account Sync Time");
        if ZycusMasterTimestampLV.findset(false) then begin
            repeat
                if GLAccRecLV.GET(ZycusMasterTimestampLV.Code) then begin
                    if ((GLAccRecLV."Account Type" = GLAccRecLV."Account Type"::Posting) and (GLAccRecLV."C&TP CODE FND" <> '')) then begin
                        if CheckForValidGLAcc(GLAccRecLV) then begin
                            TempGLAccRec.INIT();
                            TempGLAccRec := GLAccRecLV;
                            TempGLAccRec.INSERT()
                        end;
                    end;
                end;
            until ZycusMasterTimestampLV.NEXT() = 0;
        end;
        //HEI.09<<
    end;

    local procedure CreationOfGLRuleMap();
    var
        CMGMappingsLV: Record "CMG Mapping FND";
        GLAccLV: Record "G/L Account";
        EBFMatrixLV: Record "Ebf Combination FND";
        EBFDimFilter: Code[60];
        DimValLV: Record "Dimension Value";
        ZycusGLRuleMapLV: Record "Zycus GL Rule Map FND";
        ZycusGLRuleMapLV1: Record "Zycus GL Rule Map FND";
    begin
        //HEI.09>>
        CLEAR(TempCMGMappingRec);

        // BC Upgrade MISHRS14 >> #HEI.20
        //HEI.20>>
        IF GUIALLOWED THEN
            Window.OPEN(Text058);
        //HEI.20<<
        // BC Upgrade MISHRS14 <<

        ZycusGLRuleMapLV.RESET();
        if ZycusGLRuleMapLV.FINDFIRST() then
            ZycusGLRuleMapLV.DELETEALL();
        CMGMappingsLV.RESET();
        //"C&TP CODE","Dimension Code","Dimension Value Code"
        //Dimension Code,Dimension Value Code
        CMGMappingsLV.SETCURRENTKEY("Dimension Code", "Dimension Value Code");
        CMGMappingsLV.SETRANGE(CMGMappingsLV."Dimension Code", 'CMG');
        if CMGMappingsLV.FINDFIRST() then begin
            repeat
                GLAccLV.RESET();
                GLAccLV.SETCURRENTKEY(GLAccLV."C&TP CODE FND");
                GLAccLV.SETRANGE(GLAccLV."C&TP CODE FND", CMGMappingsLV."C&TP CODE");

                // BC Upgrade MISHRS14 >> #HEI.16
                //HEI.16>>
                GLAccLV.SETRANGE(GLAccLV."Account Type", GLAccLV."Account Type"::Posting);
                GLAccLV.SETFILTER(GLAccLV."Direct Posting", '%1', TRUE);
                //HEI.16<<
                // BC Upgrade MISHRS14 <<

                if GLAccLV.FINDFIRST() then begin
                    repeat
                        if not GLAccLV.Blocked then begin
                            if CheckForValidGLRuleMap(GLAccLV) then begin
                                if EBFMatrixLV.CheckNewEBFMatrixIsActive() then begin
                                    EBFMatrixLV.RESET();
                                    //"GL Account No.","Dimension Code","Dimension Value Code"
                                    GetGLAccountRange(GLAccLV."No.");
                                    EBFMatrixLV.SETFILTER(EBFMatrixLV."GL Account No.", GLAccountRange);
                                    EBFMatrixLV.SETRANGE(EBFMatrixLV."Dimension Code", 'CCC');
                                    EBFMatrixLV.SETFILTER(EBFMatrixLV."Combination Restriction", '%1|%2', EBFMatrixLV."Combination Restriction"::" ", EBFMatrixLV."Combination Restriction"::"Allowed with Warn");
                                    if EBFMatrixLV.FINDFIRST() then begin
                                        repeat
                                            EBFDimFilter := '';
                                            EBFDimFilter := EBFMatrixLV."Dimension Value Code";
                                            DimValLV.RESET();
                                            //"Dimension Code","Code"
                                            DimValLV.SETRANGE(DimValLV."Dimension Code", 'CCC');
                                            DimValLV.SETFILTER(DimValLV.Code, EBFDimFilter);
                                            DimValLV.SETRANGE(DimValLV.Blocked, false); //HEI.10
                                            if DimValLV.findset() then begin
                                                repeat
                                                    ZycusGLRuleMapLV.RESET();
                                                    ZycusGLRuleMapLV.INIT();
                                                    ZycusGLRuleMapLV1.RESET();
                                                    if ZycusGLRuleMapLV1.FINDLAST() then
                                                        ZycusGLRuleMapLV."Entry No." := ZycusGLRuleMapLV1."Entry No." + 1
                                                    else
                                                        ZycusGLRuleMapLV."Entry No." := 1;
                                                    ZycusGLRuleMapLV."CMG Code" := CMGMappingsLV."Dimension Value Code";
                                                    ZycusGLRuleMapLV."CTP Code" := CMGMappingsLV."C&TP CODE";
                                                    ZycusGLRuleMapLV."CCC Code" := DimValLV.Code;
                                                    ZycusGLRuleMapLV."GL Account" := GLAccLV."No.";
                                                    if EBFMatrixLV."Combination Restriction" = EBFMatrixLV."Combination Restriction"::"Allowed with Warn" then
                                                        ZycusGLRuleMapLV."Allowed With Warning" := true;
                                                    UpdateGLRuleMapPurchType(GLAccLV."No.");
                                                    ZycusGLRuleMapLV."Purchase Type" := PurchType;

                                                    // BC Upgrade MISHRS14 >> #HEI.12
                                                    //HEI.12>>
                                                    UpdateGLRuleMapAccountType(GLAccLV."No.");
                                                    ZycusGLRuleMapLV."Account Type" := AccountType;
                                                    //HEI.12<<
                                                    // BC Upgrade MISHRS14 <<

                                                    ZycusGLRuleMapLV.Blocked := false;
                                                    ZycusGLRuleMapLV."DateTime Stamp" := CURRENTDATETIME;
                                                    ZycusGLRuleMapLV."CCC Dim Filter" := EBFDimFilter;
                                                    ZycusGLRuleMapLV.INSERT();

                                                    // BC Upgrade MISHRS14 >> #HEI.20
                                                    //HEI.20>>
                                                    IF GUIALLOWED THEN BEGIN
                                                        Window.UPDATE(1, ZycusGLRuleMapLV."GL Account");
                                                        Window.UPDATE(2, ZycusGLRuleMapLV."CMG Code" + '-' + ZycusGLRuleMapLV."CCC Code");
                                                    END;
                                                //HEI.20<<
                                                // BC Upgrade MISHRS14 <<

                                                until DimValLV.NEXT() = 0;
                                            end;
                                        until EBFMatrixLV.NEXT() = 0;

                                        // BC Upgrade MISHRS14 >> #HEI.13
                                        //HEI.13>>
                                    END ELSE BEGIN
                                        DimValLV.RESET;
                                        DimValLV.SETRANGE(DimValLV."Dimension Code", 'CCC');
                                        DimValLV.SETRANGE(Blocked, FALSE);
                                        IF DimValLV.FINDSET(FALSE) THEN BEGIN
                                            REPEAT
                                                ZycusGLRuleMapLV.RESET;
                                                ZycusGLRuleMapLV.INIT;
                                                ZycusGLRuleMapLV1.RESET;
                                                IF ZycusGLRuleMapLV1.FINDLAST THEN
                                                    ZycusGLRuleMapLV."Entry No." := ZycusGLRuleMapLV1."Entry No." + 1
                                                ELSE
                                                    ZycusGLRuleMapLV."Entry No." := 1;
                                                ZycusGLRuleMapLV."CMG Code" := CMGMappingsLV."Dimension Value Code";
                                                ZycusGLRuleMapLV."CTP Code" := CMGMappingsLV."C&TP CODE";
                                                ZycusGLRuleMapLV."CCC Code" := DimValLV.Code;
                                                ZycusGLRuleMapLV."GL Account" := GLAccLV."No.";
                                                ZycusGLRuleMapLV."Allowed With Warning" := FALSE;
                                                UpdateGLRuleMapPurchType(GLAccLV."No.");
                                                ZycusGLRuleMapLV."Purchase Type" := PurchType;
                                                UpdateGLRuleMapAccountType(GLAccLV."No.");
                                                ZycusGLRuleMapLV."Account Type" := AccountType;
                                                ZycusGLRuleMapLV.Blocked := FALSE;
                                                ZycusGLRuleMapLV."DateTime Stamp" := CURRENTDATETIME;
                                                ZycusGLRuleMapLV."CCC Dim Filter" := EBFDimFilter;
                                                ZycusGLRuleMapLV.INSERT;
                                            UNTIL DimValLV.NEXT = 0;
                                        END;
                                        //HEI.13<<
                                        // BC Upgrade MISHRS14 <<

                                    end;
                                end;
                            end;
                        end;
                    until GLAccLV.NEXT() = 0;
                end;
            until CMGMappingsLV.NEXT() = 0;

            // BC Upgrade MISHRS14 >>
            //HEI.20>>
            IF GUIALLOWED THEN
                Window.CLOSE;
            //HEI.20<<
            // BC Upgrade MISHRS14 <<

        end;

        //HEI.09<<
    end;

    procedure GetGLAccountRange(GLAccount: Code[10]);
    var
        EBFMatrix: Record "Ebf Combination FND";
    begin
        //HEI.09>>
        if not EBFMatrix.CheckNewEBFMatrixIsActive() then
            GLAccountRange := GLAccount
        else
            GLAccountRange := COPYSTR(GLAccount, 1, 5) + GLAccountOperator;
        //HEI.09<<
    end;

    local procedure CreationOfGLRuleMapCCC();
    var
        ZycusGLRuleMap: Record "Zycus GL Rule Map FND";
    begin
        //HEI.09>>
        CLEAR(TempZycusGLRuleMap);
        TempZycusGLRuleMap.RESET();
        if TempZycusGLRuleMap.FINDFIRST() then
            TempZycusGLRuleMap.DELETEALL();
        ZycusGLRuleMap.RESET();
        if ZycusGLRuleMap.findset(false) then begin
            repeat
                TempZycusGLRuleMap.INIT();
                TempZycusGLRuleMap := ZycusGLRuleMap;
                TempZycusGLRuleMap.INSERT();
            until ZycusGLRuleMap.NEXT() = 0;
        end;
        //HEI.09<<
    end;

    local procedure UpdateGLRuleMapPurchType(GLAccNoLP: Code[20]);
    var
        GLAccLV: Record "G/L Account";
        DefaultDimLV: Record "Default Dimension";
        GLSetupLV: Record "General Ledger Setup";

        // BC Upgrade MISHRS14 >> #HEI.25
        DimCount: Integer;
        IsOnlyCCC: Boolean;
    // BC Upgrade MISHRS14 <<

    begin

        // BC Upgrade MISHRS14 >>
        // HEI.25>>
        //HEI.09>>
        GLSetupLV.GET();
        GLSetupLV.TESTFIELD("Cost Center Dimension Code FND");
        DefaultDimLV.RESET();
        //PK::"Table ID","No.","Dimension Code"
        DefaultDimLV.SETRANGE(DefaultDimLV."Table ID", DATABASE::"G/L Account");
        DefaultDimLV.SETFILTER(DefaultDimLV."Dimension Code", '<>%1', GLSetupLV."Cost Center Dimension Code FND");
        DefaultDimLV.SETRANGE(DefaultDimLV."Value Posting", DefaultDimLV."Value Posting"::"Code Mandatory");
        if DefaultDimLV.FINDFIRST() then
            PurchType := PurchType::WBS
        else
            PurchType := PurchType::CCC;
        //HEI.09<<
        GLSetupLV.GET;
        GLSetupLV.TESTFIELD("Cost Center Dimension Code FND");

        DefaultDimLV.RESET;
        DefaultDimLV.SETRANGE("Table ID", DATABASE::"G/L Account");
        DefaultDimLV.SETRANGE("No.", GLAccNoLP);
        DefaultDimLV.SETRANGE("Value Posting", DefaultDimLV."Value Posting"::"Code Mandatory");

        DimCount := 0;
        IsOnlyCCC := TRUE;

        IF DefaultDimLV.FINDSET THEN BEGIN
            REPEAT
                DimCount += 1;
                IF DefaultDimLV."Dimension Code" <> GLSetupLV."Cost Center Dimension Code FND" THEN
                    IsOnlyCCC := FALSE;
            UNTIL DefaultDimLV.NEXT = 0;
        END;

        IF (DimCount = 0) OR ((DimCount = 1) AND IsOnlyCCC) THEN
            PurchType := PurchType::CCC
        ELSE
            PurchType := PurchType::WBS;
        //HEI.25<<
        // BC Upgrade MISHRS14 <<

    end;

    procedure CreateOutboundPOSMGR_Zycus(PurchRcptHeader: Record "Purch. Rcpt. Header");
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
        InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT";
    begin
        //HEI.08>>
        GetZycusInterfaceSetup_Zycus();
        GetGeneralInterfaceSetup_Zycus();

        if not ZycusInterfaceSetup."Activate POSM GR Interface" then
            exit;

        ZycusInterfaceSetup.TESTFIELD("POSM GR Creation Interface");

        if (PurchRcptHeader."Order No." <> '') then begin
            if PurchaseHeaderAdditional.GET(PurchaseHeaderAdditional."Document Type"::Order, PurchRcptHeader."Order No.") then begin
                if (PurchaseHeaderAdditional."Zycus Order No. INT" = '') then
                    exit;
            end;
        end;

        PurchRcptLine.RESET();
        PurchRcptLine.SETRANGE("Document No.", PurchRcptHeader."No.");
        PurchRcptLine.SETRANGE(Type, PurchRcptLine.Type::Item);
        PurchRcptLine.SETFILTER(Quantity, '<>%1', 0);
        if PurchRcptLine.ISEMPTY then
            exit;

        InterfaceSetup.GET(ZycusInterfaceSetup."POSM GR Creation Interface");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderVIPOut);
        InterfaceEntryHeaderVIPOut.INIT();
        InterfaceEntryHeaderVIPOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIPOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        if InterfaceEntryHeaderVIPOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderVIPOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderVIPOut."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut."Interface Code" := ZycusInterfaceSetup."POSM GR Creation Interface";
        InterfaceEntryHeaderVIPOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
        InterfaceEntryHeaderVIPOut."External Document No." := PurchRcptHeader."No.";
        InterfaceEntryHeaderVIPOut."External Order No." := PurchRcptHeader."Order No.";
        InterfaceEntryHeaderVIPOut."Source No." := PurchRcptHeader."No.";
        InterfaceEntryHeaderVIPOut."Posting Date" := PurchRcptHeader."Posting Date";
        InterfaceEntryHeaderVIPOut.Name8 := FORMAT(PurchRcptHeader."Posting Date", 0, '<year4>');
        ;
        InterfaceEntryHeaderVIPOut.INSERT(true);

        if PurchRcptLine.findset() then
            repeat
                CreateOutboundLinesPOSMGR_Zycus(InterfaceEntryHeaderVIPOut, PurchRcptLine);
            until PurchRcptLine.NEXT() = 0;
        //HEI.08<<
    end;

    local procedure CreateOutboundLinesPOSMGR_Zycus(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT"; PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        EntryNo: Integer;
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
    begin
        //HEI.08>>
        CLEAR(InterfaceEntryLineVIPOut);
        InterfaceEntryLineVIP.RESET();
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDLAST() then
            EntryNo := InterfaceEntryLineVIP."Entry No." + 1
        else
            EntryNo := 1;
        InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
        InterfaceEntryLineVIPOut."Entry No." := EntryNo;
        InterfaceEntryLineVIPOut."Source No." := PurchRcptLine."Document No.";
        InterfaceEntryLineVIPOut."Source Line No." := PurchRcptLine."Line No.";
        InterfaceEntryLineVIPOut."External Order No." := InterfaceEntryHeaderVIP."External Order No.";
        InterfaceEntryLineVIPOut."External Order Line No." := PurchRcptLine."Zycus Order Line No. FND";
        InterfaceEntryLineVIPOut."No." := PurchRcptLine."No.";
        InterfaceEntryLineVIPOut.Quantity := PurchRcptLine.Quantity;
        InterfaceEntryLineVIPOut."Unit of Measure Code" := PurchRcptLine."Unit of Measure Code";
        InterfaceEntryLineVIPOut."Global No." := InterfaceFrameworkMgt.GetUnitOfMeasureISOCode(PurchRcptLine."Unit of Measure Code");
        InterfaceEntryLineVIPOut."Location Code" := PurchRcptLine."Location Code";
        InterfaceEntryLineVIPOut.Description := PurchRcptLine.Description;
        // InterfaceEntryLineVIPOut."Line Amount" := PurchRcptLine.Amount;  // BC Upgrade NANDIS03 - Blocked as DIT field
        InterfaceEntryLineVIPOut."Line Amount" := PurchRcptLine."Amount Heilite FND";  //BC Upgrade SHARMP16--Zycus

        InterfaceEntryLineVIPOut."Unit Amount" := PurchRcptLine."Unit Cost";
        InterfaceEntryLineVIPOut."Currency Code" := InterfaceEntryHeaderVIP."Currency Code";
        InterfaceEntryLineVIPOut.Name := FORMAT(ZycusInterfaceSetup."POSM GR Creation Movement Type");
        InterfaceEntryLineVIPOut.INSERT();
        //HEI.08<<
    end;

    procedure InboundPOSMGRConfirmation_Zycus(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT");
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        GRConfirmValidation: Label 'This GR %1 does not belong to Heilite Order No. %2';
    begin
        //HEI.08>>
        //Update Purchase Receipt

        PurchRcptHeader.RESET();
        PurchRcptHeader.SETRANGE("No.", InterfaceEntryHeaderVIP."Source No.");
        PurchRcptHeader.FINDFIRST();

        if (InterfaceEntryHeaderVIP."Action Code" = 'SU') then begin
            PurchRcptHeader."POSM GR Confirmed FND" := true;
            PurchRcptHeader.MODIFY();
        end;

        //HEI.08<<
    end;

    procedure CreateOutboundPOSMGRCancellation_Zycus(PurchRcptHeader: Record "Purch. Rcpt. Header"; var InterfaceEntryHeaderVIPOut: Record "Interface Entry Header VIP INT"): Integer;
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        InterfaceSetup: Record "Interface Setup INT";
        OutboundInterface: Record "Outbound Interface INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
    begin
        //HEI.08>>

        GetZycusInterfaceSetup_Zycus();
        GetGeneralInterfaceSetup_Zycus();

        if not ZycusInterfaceSetup."Activate POSM GR Interface" then
            exit;

        ZycusInterfaceSetup.TESTFIELD("POSM GR Creation Interface");

        if (PurchRcptHeader."Order No." <> '') then begin
            if PurchaseHeaderAdditional.GET(PurchaseHeaderAdditional."Document Type"::Order, PurchRcptHeader."Order No.") then begin
                if (PurchaseHeaderAdditional."Zycus Order No. INT" = '') then
                    exit;
            end;
        end;

        InterfaceSetup.GET(ZycusInterfaceSetup."POSM GR Creation Interface");
        InterfaceFrameworkMgt.GetOutboundInterface(InterfaceSetup, OutboundInterface);
        CLEAR(InterfaceEntryHeaderVIPOut);
        InterfaceEntryHeaderVIPOut.INIT();
        InterfaceEntryHeaderVIPOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderVIPOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        if InterfaceEntryHeaderVIPOut."Msg. Sender Business System ID" = '' then
            InterfaceEntryHeaderVIPOut."Msg. Sender Business System ID" := OutboundInterface."HeiLite Business System ID";
        InterfaceEntryHeaderVIPOut."Msg. Recv. Business System ID" := OutboundInterface."SRM Business System ID";
        InterfaceEntryHeaderVIPOut.Direction := InterfaceEntryHeaderVIPOut.Direction::Outbound;
        InterfaceEntryHeaderVIPOut."Interface Code" := ZycusInterfaceSetup."POSM GR Creation Interface";
        InterfaceEntryHeaderVIPOut."Company Code ID" := GeneralInterfaceSetup."Company Code ID";
        InterfaceEntryHeaderVIPOut."External Document No." := PurchRcptHeader."No.";
        InterfaceEntryHeaderVIPOut."External Order No." := PurchRcptHeader."Order No.";
        InterfaceEntryHeaderVIPOut."Source No." := PurchRcptHeader."No.";
        InterfaceEntryHeaderVIPOut."Posting Date" := PurchRcptHeader."Posting Date";
        InterfaceEntryHeaderVIPOut.Name8 := FORMAT(PurchRcptHeader."Posting Date", 0, '<year4>');
        ;
        InterfaceEntryHeaderVIPOut.INSERT(true);

        //HEI.08<<
    end;

    procedure CreateOutboundLinesPOSMGRCancellation_Zycus(InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT"; PurchRcptLine: Record "Purch. Rcpt. Line");
    var
        InterfaceEntryLineVIPOut: Record "Interface Entry Line VIP INT";
        EntryNo: Integer;
        InterfaceEntryLineVIP: Record "Interface Entry Line VIP INT";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";
    begin
        //HEI.08>>
        CLEAR(InterfaceEntryLineVIPOut);
        InterfaceEntryLineVIP.RESET();
        InterfaceEntryLineVIP.SETRANGE("Header Entry No.", InterfaceEntryHeaderVIP."Entry No.");
        if InterfaceEntryLineVIP.FINDLAST() then
            EntryNo := InterfaceEntryLineVIP."Entry No." + 1
        else
            EntryNo := 1;
        InterfaceEntryLineVIPOut.INIT();
        InterfaceEntryLineVIPOut."Header Entry No." := InterfaceEntryHeaderVIP."Entry No.";
        InterfaceEntryLineVIPOut."Entry No." := EntryNo;
        InterfaceEntryLineVIPOut."Source No." := PurchRcptLine."Document No.";
        InterfaceEntryLineVIPOut."Source Line No." := PurchRcptLine."Line No.";
        InterfaceEntryLineVIPOut."External Order No." := InterfaceEntryHeaderVIP."External Order No.";
        InterfaceEntryLineVIPOut."External Order Line No." := PurchRcptLine."Zycus Order Line No. FND";
        InterfaceEntryLineVIPOut."No." := PurchRcptLine."No.";
        InterfaceEntryLineVIPOut.Quantity := ABS(PurchRcptLine.Quantity);
        InterfaceEntryLineVIPOut."Unit of Measure Code" := PurchRcptLine."Unit of Measure Code";
        InterfaceEntryLineVIPOut."Global No." := InterfaceFrameworkMgt.GetUnitOfMeasureISOCode(PurchRcptLine."Unit of Measure Code");
        InterfaceEntryLineVIPOut."Location Code" := PurchRcptLine."Location Code";
        InterfaceEntryLineVIPOut.Description := PurchRcptLine.Description;
        // InterfaceEntryLineVIPOut."Line Amount" := PurchRcptLine.Amount;  // BC Upgrade NANDIS03 - Blocked as DIT field
        InterfaceEntryLineVIPOut."Line Amount" := PurchRcptLine."Amount Heilite FND";  //BC Upgrade SHARMP16--Zycus

        InterfaceEntryLineVIPOut."Unit Amount" := PurchRcptLine."Unit Cost";
        InterfaceEntryLineVIPOut."Currency Code" := InterfaceEntryHeaderVIP."Currency Code";
        InterfaceEntryLineVIPOut.Name := FORMAT(ZycusInterfaceSetup."POSM GR Cancel Movement Type");
        InterfaceEntryLineVIPOut.INSERT();
        //HEI.08<<
    end;
    // BC Upgrade MISHRS14 >> #HEI.12
    LOCAL procedure UpdateGLRuleMapAccountType(GLAccNo: Code[10])
    var
        GLAccount: Record "G/L Account";
    begin
        //HEI.12>>
        IF GLAccount.GET(GLAccNo) THEN BEGIN
            IF GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Income Statement" THEN
                AccountType := AccountType::Income;
            IF GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Balance Sheet" THEN
                AccountType := AccountType::Balance;
        END;
        //HEI.12<<
    end;
    // BC Upgrade MISHRS14 <<
}

