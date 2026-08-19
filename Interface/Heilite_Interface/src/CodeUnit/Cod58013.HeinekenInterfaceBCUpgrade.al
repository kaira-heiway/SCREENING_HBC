namespace HNK_InterfaceFramework.HNK_InterfaceFramework;
using System.IO;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Sales.Customer;
using Microsoft.Utilities;
using Microsoft.Warehouse.Setup;
using Microsoft.FixedAssets.FixedAsset;
using System.Threading;
using Microsoft.Purchases.Pricing;
using System.Security.AccessControl;
using System.Security.User;
using System.Environment;
using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Tracking;
using ALProject.ALProject;
using Microsoft.Foundation.Company;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Purchases.Vendor;
using Microsoft.Warehouse.Request;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Location;
using Microsoft.Inventory;
using Microsoft.Purchases.History;
using Microsoft.Inventory.Item;
using System.Integration;
using Microsoft.Foundation.Reporting;
using System.Automation;
using Microsoft.Warehouse.Document;
using Microsoft.Finance.Dimension;
using Microsoft.Sales.History;
using Microsoft.Finance.GeneralLedger.Posting;

codeunit 58013 "Heineken Interface BC Upgrade"
{
    Permissions = TableData Item = rm, TableData "Stockkeeping Unit" = rm; // BC Upgrade BHARAD11 
    // BC Upgrade NANDIS03 - subscriber created for code written against Table 1221 in function - InsertRecXMLFieldWithParentNodeID(Tag HEI.01)
    [EventSubscriber(ObjectType::Table, Database::"Data Exch. Field", OnInsertRecXMLFieldWithParentNodeIDOnBeforeInsert, '', false, false)]
    local procedure OnInsertRecXMLFieldWithParentNodeIDOnBeforeInsert(var DataExchField: Record "Data Exch. Field"; var NodeValue: Text)
    begin
        //HEI.01>>
        IF STRLEN(NodeValue) > MAXSTRLEN(DataExchField.Value) THEN
            DataExchField.InsertValueIntoBigValue(NodeValue);
        //HEI.01<<
    end;

    [EventSubscriber(ObjectType::Table, 5600, 'OnAfterInsertEvent', '', false, false)]
    local procedure FAOnInsertTrigger(var Rec: Record "Fixed Asset"; RunTrigger: Boolean);
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        DimensionValue: Record "Dimension Value";
        DefaultDimension: Record "Default Dimension";
        FARec: Record "Fixed Asset";
        DimCode: Code[20];
        DimDesc: Text;
        DimensionValue_1: Record "Dimension Value";
        DefaultDimension_1: Record "Default Dimension";
    begin
        //HEI.16
        GeneralInterfaceSetup.GET();
        DimensionValue.INIT();
        DimensionValue.VALIDATE("Dimension Code", GeneralInterfaceSetup."Project Dimension Code");
        DimensionValue.VALIDATE(Code, Rec."No.");
        DimensionValue.VALIDATE(Name, Rec."No.");
        DimensionValue.INSERT();//(TRUE);

        DefaultDimension.INIT();
        DefaultDimension.VALIDATE("Table ID", 5600);
        DefaultDimension.VALIDATE("No.", Rec."No.");
        DefaultDimension.VALIDATE("Dimension Code", GeneralInterfaceSetup."Project Dimension Code");
        DefaultDimension.VALIDATE("Dimension Value Code", Rec."No.");
        //HEI.19 >>
        DimCode := Rec."No.";
        //HEI.19 <<
        DefaultDimension.INSERT();//T(TRUE);
                                  //HEI.19 >>
                                  //HEI.24 >>
                                  /*
                                  //FARec.RESET;
                                  //IF FARec.GET(Rec."No.") THEN BEGIN
                                    DimensionValue.RESET;
                                    IF DimensionValue.GET(GeneralInterfaceSetup."Project Dimension Code",DimCode) THEN BEGIN
                                      //FARec.Description := DimensionValue.Name;
                                      //FARec.MODIFY;
                                     Rec.Description := DimensionValue.Name;
                                     Rec.MODIFY;
                                  //HEI.19 <<
                                 END;
                                 */
                                  //HEI.24<<
                                  //HEI.16

    end;

    [EventSubscriber(ObjectType::Table, 472, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyJobQueueEntry(var Rec: Record "Job Queue Entry"; var xRec: Record "Job Queue Entry"; RunTrigger: Boolean);
    begin
        //HEI.33>>
        GetGeneralInterfaceSetup();
        //HEI.113>>
        /*
        IF (Rec."Job Queue Category Code" = 'NOTIFYNOW') AND
           (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
        */
        if (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
        //HEI.113<<
        then
            Rec."User ID" := GeneralInterfaceSetup."Interface Job Queue User ID";
        //HEI.33<<

    end;  // BC Upgrade NANDIS03

    //BC Upgrade GUNREM01 -updated object name instead of Object ID >>
    // [EventSubscriber(ObjectType::Table, 2000000175, 'OnBeforeInsertEvent', '', false, false)]
    [EventSubscriber(ObjectType::Table, database::"Scheduled Task", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertScheduledTask(var Rec: Record "Scheduled Task"; RunTrigger: Boolean);
    var
        User: Record User;
        JobQueueEntry: Record "Job Queue Entry";
        RecRef: RecordRef;
    begin
        //HEI.33>>
        GetGeneralInterfaceSetup();
        if RecRef.GET(Rec.Record) then;//Bc Upgrade SHARMP16 GAPFitChanges
        if RecRef.NUMBER = DATABASE::"Job Queue Entry" then begin
            RecRef.SETRECFILTER();
            JobQueueEntry.SETVIEW(RecRef.GETVIEW());
            if JobQueueEntry.FINDFIRST() then
                //HEI.113>>
                /*
                IF (JobQueueEntry."Job Queue Category Code" = 'NOTIFYNOW') AND
                   (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
                */
            if (GeneralInterfaceSetup."Interface Job Queue User ID" <> '') then begin
                    //HEI.113<<
                    User.SETRANGE("User Name", GeneralInterfaceSetup."Interface Job Queue User ID");
                    if User.FINDFIRST() then begin
                        Rec."User ID" := User."User Security ID";
                        Rec."User Name" := User."User Name";
                    end;
                end;
        end;
        //HEI.33<<
    end;
    //BC Upgrade GUNREM01 -updated object name instead of Object ID <<


    local procedure GetGeneralInterfaceSetup();
    begin
        //HEI.33>>
        if not GeneralInterfaceSetupRead then
            if GeneralInterfaceSetup.GET() then; // Guarded GeneralInterfaceSetup.GET() with IF..THEN to prevent error during BC 28.1 version upgrade. OnBeforeInsertScheduledTask fires on company open; bare GET() failed in companies with no setup record (e.g. CRONUS FR) -BCU KAIRAR01
        GeneralInterfaceSetupRead := true;
        //HEI.33<<
    end;  // BC Upgrade NANDIS03 - Function moved to Interface extension

    [EventSubscriber(ObjectType::Table, 472, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyJobQueueEntry(var Rec: Record "Job Queue Entry"; var xRec: Record "Job Queue Entry"; RunTrigger: Boolean);
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        //HEI.110>>
        GetGeneralInterfaceSetup();
        if WarehouseSetup.GET() then //BC version 28.2 Upgrade: Prevent tenant upgrade failure by guarding Warehouse Setup GET() in Job Queue Entry event
            if (Rec."Job Queue Category Code" = WarehouseSetup."C2S COGS Job Que Cat Code FND") and
               (GeneralInterfaceSetup."Interface Job Queue User ID" <> '')
            then
                Rec."User ID" := GeneralInterfaceSetup."Interface Job Queue User ID";
        //HEI.110<<
    end;

    //BC Upgrade GUNREM01 -updated object name instead of Object ID >>
    // [EventSubscriber(ObjectType::Table, 2000000175, 'OnBeforeInsertEvent', '', false, false)]
    [EventSubscriber(ObjectType::Table, Database::"Scheduled Task", 'OnBeforeInsertEvent', '', false, false)]

    local procedure OnBeforeInsertScheduledTask_RTR(var Rec: Record "Scheduled Task"; RunTrigger: Boolean);
    var
        WarehouseSetup: Record "Warehouse Setup";
        RecRef: RecordRef;
        JobQueueEntry: Record "Job Queue Entry";
        User: Record User;
    begin
        //HEI.111>>
        GetGeneralInterfaceSetup();
        WarehouseSetup.GET();
        if RecRef.GET(Rec.Record) then;//Bc Upgrade SHARMP16 GAPFitChanges
        if RecRef.NUMBER = DATABASE::"Job Queue Entry" then begin
            RecRef.SETRECFILTER();
            JobQueueEntry.SETVIEW(RecRef.GETVIEW());
            if JobQueueEntry.FINDFIRST() then
                if (JobQueueEntry."Job Queue Category Code" = WarehouseSetup."C2S COGS Job Que Cat Code FND") and
                   (GeneralInterfaceSetup."Interface Job Queue Category" <> '')
                then begin
                    User.SETRANGE("User Name", GeneralInterfaceSetup."Interface Job Queue User ID");
                    if User.FINDFIRST() then begin
                        Rec."User ID" := User."User Security ID";
                        Rec."User Name" := User."User Name";
                    end;
                end;
        end;
        //HEI.111<<
    end;
    //BC Upgrade GUNREM01 -updated object name instead of Object ID <<


    [EventSubscriber(ObjectType::Table, Database::"Interface Entry Header INT", 'OnAfterModifyEvent', '', false, false)]
    local procedure T50001OnAfterModifySendEmailOnError(var Rec: Record "Interface Entry Header INT"; var xRec: Record "Interface Entry Header INT"; RunTrigger: Boolean);
    var
        TempUser: Record "User Setup" temporary;
        UserSetup: Record "User Setup";
        FromUserSetup: Record "User Setup";
        //SMTPMail: Codeunit "SMTP Mail";  // BC Upgrade NANDIS03 - BLocked as SMTP Mail is obsolete
        MailSubjectTxt: Text[100];
        Msg: Text[1000];
        FMInterfaceSetup: Record "FuturMaster Interf. Setup INT";
        FMInterfaceSetup_2: Record "FuturMaster Interf Setup_2 INT";
        FldRef: FieldRef;
        RecRef: RecordRef;
        FMInterface: Boolean;
        i: Integer;
    begin
        //>>HEI.44

        if (Rec."Your Reference" <> 'EMail_Sent') and (Rec.Status = Rec.Status::Error) and (Rec.Description = 'Scheduled') then begin
            FMInterface := false;
            RecRef.OPEN(Database::"FuturMaster Interf. Setup INT");//PATHAA02 12.04.26
            if RecRef.FINDFIRST() then begin
                for i := 1 to RecRef.FIELDCOUNT do begin
                    FldRef := RecRef.FIELDINDEX(i);
                    if FORMAT(FldRef.VALUE) = Rec."Interface Code" then
                        FMInterface := true;
                end;
            end;

            RecRef.CLOSE();
            RecRef.OPEN(Database::"FuturMaster Interf Setup_2 INT"); //PATHAA02-12.04.26

            if RecRef.FINDFIRST() then begin
                for i := 1 to RecRef.FIELDCOUNT do begin
                    FldRef := RecRef.FIELDINDEX(i);
                    if FORMAT(FldRef.VALUE) = Rec."Interface Code" then
                        FMInterface := true;
                end;
            end;
            RecRef.CLOSE();

            if FMInterface then begin
                // Create list of users to receive the notification
                //GeneralInterfaceSetup.GET;
                FMInterfaceSetup_2.GET();
                if FMInterfaceSetup_2."Notify User ID 1" <> '' then
                    if UserSetup.GET(FMInterfaceSetup_2."Notify User ID 1") then begin
                        TempUser := UserSetup;
                        if TempUser.INSERT() then;
                    end;
                if FMInterfaceSetup_2."Notify User ID 2" <> '' then
                    if UserSetup.GET(FMInterfaceSetup_2."Notify User ID 2") then begin
                        TempUser := UserSetup;
                        if TempUser.INSERT() then;
                    end;
                //FromUserSetup.GET(GeneralInterfaceSetup."Interface Job Queue User ID");

                // Send mail to users
                if TempUser.FIND('-') then begin
                    repeat
                        if TempUser."E-Mail" <> '' then begin
                            MailSubjectTxt := 'Error processing interface ' + Rec."Interface Code";
                            Msg := Rec."Error Message";
                            //SMTPMail.CreateMessage('HeiLite BASE Interfaces',FromUserSetup."E-Mail",TempUser."E-Mail",MailSubjectTxt,Msg,TRUE);
                            // SMTPMail.CreateMessage('HeiLite FM Interfaces', TempUser."E-Mail", TempUser."E-Mail", MailSubjectTxt, Msg, true);  // BC Upgrade NANDIS03 - BLocked as SMTP Mail is obsolete
                            // SMTPMail.Send;  // BC Upgrade NANDIS03 - BLocked as SMTP Mail is obsolete
                            Rec."Your Reference" := 'EMail_Sent';
                            Rec.MODIFY();
                        end;
                    until TempUser.NEXT() = 0;
                end;

            end;
        end;
        //<<HEI.44
    end;  // BC Upgrade NANDIS03 - this function moved out from CU 50015

    // BC Upgrade NANDIS03 >>
    // Documentation from CU 1214 - HEI.01 FDD-GAPID001 IBM LAZARE02 25.08.2017 # Copy Big Value from Data Exch. field to Intermediate Data Import
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Map DataExch To Intermediate", OnBeforeIntermediateDataImportInsert, '', false, false)]
    procedure OnBeforeIntermediateDataImportInsert(DataExchField: Record "Data Exch. Field"; DataExchLineDef: Record "Data Exch. Line Def"; var TempNameValueBuffer: Record "Name/Value Buffer" temporary; var IntermediateDataImport: Record "Intermediate Data Import")
    begin
        //HEI.01>>
        IF DataExchField."Big Value FND".HASVALUE THEN BEGIN
            DataExchField.CALCFIELDS("Big Value FND");
            IntermediateDataImport."Big Value FND" := DataExchField."Big Value FND";
        END;
        //HEI.01<<
    end;
    // BC Upgrade NANDIS03 <<

    // BC Upgrade NANDIS03 >> Trial Code for XML Dotnet variables
    procedure LoadXMLDocumentFromInStreamSaaS(var InStr: InStream; var XmlDoc: XmlDocument): Boolean
    var
        XmlReadOptions: XmlReadOptions;
    begin
        XmlReadOptions.PreserveWhitespace(true);
        if XmlDocument.ReadFrom(InStr, XmlReadOptions, XmlDoc) then
            exit(true);
        exit(false);
    end;
    // BC Upgrade NANDIS03 <<

    // [EventSubscriber(ObjectType::Table, 37, 'OnAfterValidateEvent', 'No.', false, false)]
    // local procedure T37OnAfterValidateNo(var Rec : Record "Sales Line";var xRec : Record "Sales Line";CurrFieldNo : Integer);
    // var
    //     MarakiSuppressValues : Record "Maraki Suppress Values";
    //     CashVanSalesInterfaceSetup : Record "Cash Van Sales Interface Setup INT";
    //     GeneralOpCoSetup : Record "General OpCo Setup";
    // begin
    //     //HEI.53>>
    //     GeneralOpCoSetup.GET;
    //     if GeneralOpCoSetup."Enable Send to Maraki" then begin
    //       MarakiSuppressValues.SETRANGE("No.",Rec."No.");
    //       if Rec.Type = Rec.Type::Item then
    //         MarakiSuppressValues.SETRANGE(Type,MarakiSuppressValues.Type::Item)
    //       else if Rec.Type = Rec.Type::"Charge (Item)" then
    //         MarakiSuppressValues.SETRANGE(Type,MarakiSuppressValues.Type::"Item Charge");
    //       if MarakiSuppressValues.FINDFIRST then
    //         Rec."Suppress POS Interface" := true;
    //     end;
    //     //HEI.53<<
    //     Rec."Freshness Date (min)" := GetFreshnessDate(Rec);//HEI.116
    // end;  // BC Upgrade NANDIS03 - moved from CU 50015 - need to compile


    // BC Upgrade NANDIS03 -  moved from CU 50015 from General extension  >>
    procedure T50012OnAfterInsert(var Rec: Record "Interface Entry Comp.DetailINT");
    var
        InterfaceEntryHeader: Record "Interface Entry Header INT";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        //HEI.41>>
        GeneralLedgerSetup.GET();
        case Rec."Table ID" of
            DATABASE::"Customer Attributes FND":
                begin
                    InterfaceEntryHeader.GET(Rec."Header Entry No.");
                    case Rec."Field ID" of
                        1:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", GeneralLedgerSetup."Customer Dimension Code FND", Rec.Value);
                        2:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", 'CUST TYPE', Rec.Value);
                        5:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", GeneralLedgerSetup."Business Type Dim Code FND", Rec.Value);
                        6:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", 'ORG_SEG', Rec.Value);
                        7:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", 'CHANNEL', Rec.Value);
                        43:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", 'KEY ACCOUNT', Rec.Value);
                        46:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", GeneralLedgerSetup."OPCO Dimension Code FND", Rec.Value);
                        53:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", 'MARKET', Rec.Value);
                    end;
                end;
            DATABASE::Customer:
                begin
                    case Rec."Field ID" of
                        35:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", 'COUNTRY_REGION CODE', Rec.Value);
                        2014067:
                            CreateCustDefaultDim(InterfaceEntryHeader."Source No.", 'DIR_INDIR', Rec.Value);
                    end;
                end;
        end;
        //HEI.41<<
    end;

    local procedure CreateCustDefaultDim(CustomerNo: Code[20]; DimCode: Code[20]; DimCodeValue: Code[20]);
    var
        DefaultDimension: Record "Default Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if not DefaultDimension.GET(DATABASE::Customer, CustomerNo, DimCode) then begin
            if DimCodeValue <> '' then begin
                DefaultDimension.INIT();
                DefaultDimension.VALIDATE("Table ID", DATABASE::Customer);
                DefaultDimension.VALIDATE("No.", CustomerNo);
                DefaultDimension.VALIDATE("Dimension Code", DimCode);
                DefaultDimension.VALIDATE("Dimension Value Code", DimCodeValue);
                DefaultDimension.INSERT(true);
            end;
        end else begin
            //HEI.61>>
            GeneralLedgerSetup.GET();
            if DimCode <> GeneralLedgerSetup."Customer Dimension Code FND" then begin
                DefaultDimension.VALIDATE("Dimension Value Code", DimCodeValue);
                DefaultDimension.MODIFY(true);
            end;
        end;
        //HEI.61<<
    end;
    // BC Upgrade NANDIS03 -  moved from CU 50015 from General extension  <<

    // [EventSubscriber(ObjectType::Table, 50013, 'OnAfterInsertEvent', '', false, false)]
    // local procedure T50006OnAfterInsert(var Rec : Record "Interface Log Comp. Detail INT";RunTrigger : Boolean);
    // var
    //     InterfaceLogHeader : Record "Interface Log Header INT";
    //     GeneralLedgerSetup : Record "General Ledger Setup";
    //     InterfaceLogCompDetail : Record "Interface Log Comp. Detail INT";
    //     Customer : Record Customer;
    // begin
    //     //HEI.61>>
    //     //HEI.41>>

    //     GeneralLedgerSetup.GET;
    //     case Rec."Table ID" of
    //        DATABASE::"Customer Attributes FND":
    //         begin
    //           InterfaceLogHeader.GET(Rec."Header Entry No.");

    //           if InterfaceLogHeader."Source No." = '' then
    //             if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,50036) then begin
    //               Customer.RESET;
    //               Customer.SETRANGE("Customer Description",InterfaceLogCompDetail.Value);
    //               if Customer.FINDFIRST then
    //                 InterfaceLogHeader."Source No." := Customer."No.";
    //             end;
    //           case Rec."Field ID" of
    //             1:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",GeneralLedgerSetup."Customer Dimension Code",Rec.Value);
    //             2:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'CUST TYPE',Rec.Value);
    //             5:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",GeneralLedgerSetup."Business Type Dimension Code",Rec.Value);
    //             6:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'ORG_SEG',Rec.Value);
    //             7:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'CHANNEL',Rec.Value);
    //             43:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'KEY ACCOUNT',Rec.Value);
    //             46:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",GeneralLedgerSetup."OPCO Dimension Code",Rec.Value);
    //             53:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'MARKET',Rec.Value);
    //           end;
    //         end;
    //        DATABASE::Customer:
    //         begin
    //           /*
    //           InterfaceLogHeader.GET(Rec."Header Entry No.");

    //           IF InterfaceLogHeader."Source No." = '' THEN
    //             IF InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,50036) THEN BEGIN
    //               Customer.RESET;
    //               Customer.SETRANGE("Customer Description",InterfaceLogCompDetail.Value);
    //               IF Customer.FINDFIRST THEN
    //                 InterfaceLogHeader."Source No." := Customer."No.";
    //             END;
    //           */
    //           case Rec."Field ID" of
    //          50036:
    //            begin
    //              InterfaceLogHeader.GET(Rec."Header Entry No.");

    //              if InterfaceLogHeader."Source No." = '' then begin
    //                 Customer.RESET;
    //                 Customer.SETRANGE("Customer Description",Rec.Value);
    //                 if Customer.FINDFIRST then
    //                   InterfaceLogHeader."Source No." := Customer."No.";
    //              end;
    //              if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,35) then
    //                CreateCustDefaultDim(InterfaceLogHeader."Source No.",'COUNTRY_REGION CODE',InterfaceLogCompDetail.Value);
    //              if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,2014067) then
    //                CreateCustDefaultDim(InterfaceLogHeader."Source No.",'DIR_INDIR',InterfaceLogCompDetail.Value);
    //              if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,5900) then
    //                CreateCustDefaultDim(InterfaceLogHeader."Source No.",'SERVICE ZONE',InterfaceLogCompDetail.Value);
    //            end;
    //            2014067:
    //             begin
    //               InterfaceLogHeader.GET(Rec."Header Entry No.");

    //                if InterfaceLogHeader."Source No." = '' then
    //                  if InterfaceLogCompDetail.GET(Rec."Header Entry No.",1,18,1,50036) then begin
    //                    Customer.RESET;
    //                    Customer.SETRANGE("Customer Description",InterfaceLogCompDetail.Value);
    //                    if Customer.FINDFIRST then
    //                      InterfaceLogHeader."Source No." := Customer."No.";
    //                  end;
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'DIR_INDIR',Rec.Value);
    //             end;
    //             /*
    //             35:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'COUNTRY_REGION CODE',Rec.Value);
    //        2014067:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'DIR_INDIR',Rec.Value);
    //           5900:
    //               CreateCustDefaultDim(InterfaceLogHeader."Source No.",'SERVICE ZONE',Rec.Value);
    //             */
    //           end;
    //         end;
    //     end;
    //     //HEI.41<<
    //     //HEI.61<<
    // end;  // BC Upgrade NANDIS03 - moved from CU 50015

    // [EventSubscriber(ObjectType::Table, 23, 'OnBeforeInsertEvent', '', false, false)]
    // local procedure T23OnBeforeInsertShared(var Rec : Record Vendor;RunTrigger : Boolean);
    // var
    //     CommonSourceSharingSetup : Record "Common Src Sharing Setup FND";
    //     GlobalNoSeries : Record "Global No. Series";
    //     GlobalNoSeriesManagement : Codeunit GlobalNoSeriesManagement;
    //     GlobalSharedSource : Record "Global Shared Source FND";
    //     SessionGlobals : Codeunit "Session Globals";
    //     ErrorTxt : Label 'Vendor with Global Id: %1, Local Id: %2 already exists in Company: %3 !';
    //     GenericWebServiceClient : Codeunit "Generic Web Service Client";
    //     GeneralInterfaceSetup : Record "General Interface Setup INT";
    //     Read : Boolean;
    //     GenericWebServiceClient2 : Codeunit "Generic Web Service Client";
    //     GenericWebServiceClient3 : Codeunit "Generic Web Service Client";
    // begin
    //     //>> HEI.65
    //     if (Rec.ISTEMPORARY) or (SessionGlobals.GetVendorGlobalNo = '') then //HEI.79
    //       exit;
    //     //>> HEI.68
    //     if CommonSourceSharingSetup.GET then begin
    //       if not CommonSourceSharingSetup."Database Level Sharing" then begin //HEI.79
    //         if CommonSourceSharingSetup."Enable Common Vendor Sharing" then begin
    //           GlobalSharedSource.RESET;
    //           GlobalSharedSource.SETRANGE("Source Type",GlobalSharedSource."Source Type"::Vendor);
    //           GlobalSharedSource.SETRANGE("Global ID",SessionGlobals.GetVendorGlobalNo);
    //           GlobalSharedSource.SETRANGE(Blocked,false);
    //           if GlobalSharedSource.FINDFIRST then begin
    //             Rec."No." := GlobalSharedSource."Local ID";
    //           end else
    //             begin
    //               CommonSourceSharingSetup.TESTFIELD("Global Vendor No. Series");
    //               if GlobalNoSeries.GET(CommonSourceSharingSetup."Global Vendor No. Series") then
    //                 GlobalNoSeriesManagement.InitGlobalSeries(GlobalNoSeries.Code,Rec."No. Series",
    //                                                           0D,Rec."No.",Rec."No. Series");
    //             end;
    //       end else
    //       exit;
    //     //<< HEI.68
    //     end else begin
    //         //>>HEI.79
    //         GeneralInterfaceSetup.GET;
    //         GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //         GenericWebServiceClient.INIT;
    //         GenericWebServiceClient.SETFILTER('Source_Type','Vendor');
    //         GenericWebServiceClient.SETFILTER('Global_ID',SessionGlobals.GetVendorGlobalNo);
    //         GenericWebServiceClient.SETFILTER('Blocked','false');
    //         if GenericWebServiceClient.READMULTIPLE then
    //           Rec."No." := GenericWebServiceClient.GETVALUE('Local_ID')
    //         else
    //           begin
    //             GenericWebServiceClient2.CONNECT(CommonSourceSharingSetup."Source Sharing Setup WS Link");
    //             GenericWebServiceClient2.SETFILTER('Database_Level_Sharing','true');
    //             if GenericWebServiceClient2.READMULTIPLE then
    //               if GenericWebServiceClient2.GETVALUE('Global_Vendor_No_Series') <> '' then begin
    //                 GenericWebServiceClient3.CONNECT(CommonSourceSharingSetup."Global No. Series WS Link");
    //                 GenericWebServiceClient3.SETFILTER('Code',GenericWebServiceClient2.GETVALUE('Global_Vendor_No_Series'));
    //                 if GenericWebServiceClient3.READMULTIPLE then begin
    //                   NoSeriesWebRequest(GenericWebServiceClient2.GETVALUE('Global_Vendor_No_Series'),Rec."No. Series",
    //                                      TODAY,Rec."No.",Rec."No.");
    //                   Rec.VALIDATE("No.",GenericWebServiceClient3.GETVALUE('LastNoUsed'));
    //                 end;
    //               end;
    //               GenericWebServiceClient.RESET;
    //               GenericWebServiceClient2.RESET;
    //               GenericWebServiceClient3.RESET;
    //             end;
    //           end;
    //       end;
    //       //<<HEI.79
    //     //<< HEI.65
    // end;  // BC Upgrade NANDIS03 - moved from CU 50015

    // [EventSubscriber(ObjectType::Table, 23, 'OnAfterValidateEvent', 'Global Vendor Number', false, false)]
    // local procedure T23OnAfterValidateVendorGlobNoShared(var Rec : Record Vendor;var xRec : Record Vendor;CurrFieldNo : Integer);
    // var
    //     GlobalSharedSource : Record "Global Shared Source FND";
    //     CommonSourceSharingSetup : Record "Common Src Sharing Setup FND";
    //     GenericWebServiceClient : Codeunit "Generic Web Service Client";
    //     Vendor : Record Vendor;
    // begin
    //     //>> HEI.65
    //     if Rec.ISTEMPORARY then
    //       exit;

    //     //>> HEI.68
    //     if CommonSourceSharingSetup.GET then
    //       if not CommonSourceSharingSetup."Database Level Sharing" then begin //HEI.79
    //         if not CommonSourceSharingSetup."Enable Common Vendor Sharing" then
    //           exit;
    //     //<< HEI.68

    //       if (Rec."Global Vendor Number" = xRec."Global Vendor Number") or (Rec."Global Vendor Number" = '') then
    //         exit;

    //       GlobalSharedSource.INIT;
    //       GlobalSharedSource."Source Type" := GlobalSharedSource."Source Type"::Vendor;
    //       GlobalSharedSource."Global ID" := Rec."Global Vendor Number";
    //       GlobalSharedSource."Local ID" := Rec."No.";
    //       GlobalSharedSource."Company ID" := COMPANYNAME;
    //       GlobalSharedSource.Blocked := false;
    //       GlobalSharedSource.INSERT;
    //     //>> HEI.79
    //       end else
    //         begin
    //           if (Rec."Global Vendor Number" = xRec."Global Vendor Number") or (Rec."Global Vendor Number" = '') then
    //             exit;

    //         Vendor.SETRANGE("Global Vendor Number",Rec."Global Vendor Number");
    //         if not Vendor.FINDFIRST then begin
    //           if CommonSourceSharingSetup."Database Level Sharing" = true then begin //HEI.82
    //             GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //             GenericWebServiceClient.SETFILTER('Global_ID',Rec."Global Vendor Number");
    //             GenericWebServiceClient.SETFILTER('Local_ID',Rec."No.");
    //             GenericWebServiceClient.SETFILTER('Company_ID',COMPANYNAME);
    //             GenericWebServiceClient.SETFILTER('Blocked','false');
    //             if GenericWebServiceClient.READMULTIPLE then
    //               GenericWebServiceClient.DELETE;
    //           end; //HEI.82
    //         end;
    //           GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //           GenericWebServiceClient.INIT;
    //           GenericWebServiceClient.SETVALUE('Source_Type','Vendor');
    //           GenericWebServiceClient.SETVALUE('Global_ID',Rec."Global Vendor Number");
    //           GenericWebServiceClient.SETVALUE('Local_ID',Rec."No.");
    //           GenericWebServiceClient.SETVALUE('Company_ID',COMPANYNAME);
    //           GenericWebServiceClient.SETVALUE('Blocked',false);
    //           GenericWebServiceClient.CREATE;
    //       end;
    //       //GenericWebServiceClient.RESET; // HEI.82
    //     //<< HEI.79
    //     //<< HEI.65
    // end;  // BC Upgrade NANDIS03 - moved from CU 50015

    // [EventSubscriber(ObjectType::Table, 23, 'OnAfterValidateEvent', 'Global Delete', false, false)]
    // local procedure T23OnAfterValidateGlobalDeleteShared(var Rec : Record Vendor;var xRec : Record Vendor;CurrFieldNo : Integer);
    // var
    //     GlobalSharedSource : Record "Global Shared Source FND";
    //     CommonSourceSharingSetup : Record "Common Src Sharing Setup FND";
    //     GenericWebServiceClient : Codeunit "Generic Web Service Client";
    // begin
    //     //>> HEI.68
    //     if Rec.ISTEMPORARY then
    //       exit;

    //     if CommonSourceSharingSetup.GET then
    //         if not CommonSourceSharingSetup."Database Level Sharing" then begin //HEI.79
    //           if not CommonSourceSharingSetup."Enable Common Vendor Sharing" then
    //             exit;

    //         if Rec."Global Delete" = true then begin
    //           GlobalSharedSource.RESET;
    //           GlobalSharedSource.SETRANGE("Source Type",GlobalSharedSource."Source Type"::Vendor);
    //           GlobalSharedSource.SETRANGE("Global ID",Rec."Global Vendor Number");
    //           GlobalSharedSource.SETRANGE("Local ID",Rec."No.");
    //           GlobalSharedSource.SETRANGE("Company ID",COMPANYNAME);
    //           GlobalSharedSource.SETRANGE(Blocked,false);
    //           if GlobalSharedSource.FINDFIRST then begin
    //             GlobalSharedSource.RENAME(GlobalSharedSource."Global ID",GlobalSharedSource."Local ID",GlobalSharedSource."Company ID",Rec."Global Delete");
    //           end;
    //         end;
    //         end else
    //         begin
    //         //>> HEI.79
    //           GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //           if Rec."Global Delete" = true then begin
    //             GenericWebServiceClient.SETFILTER('Global_ID',Rec."Global Vendor Number");
    //             GenericWebServiceClient.SETFILTER('Local_ID',Rec."No.");
    //             GenericWebServiceClient.SETFILTER('Company_ID',COMPANYNAME);
    //             GenericWebServiceClient.SETFILTER('Blocked','false');
    //             if GenericWebServiceClient.READMULTIPLE then begin
    //               GenericWebServiceClient.SETVALUE('Global_ID',GenericWebServiceClient.GETVALUE('Global_ID'));
    //               GenericWebServiceClient.SETVALUE('Local_ID',GenericWebServiceClient.GETVALUE('Local_ID'));
    //               GenericWebServiceClient.SETVALUE('Company_ID',GenericWebServiceClient.GETVALUE('Company_ID'));
    //               GenericWebServiceClient.SETVALUE('Blocked',Rec."Global Delete");
    //               GenericWebServiceClient.UPDATE;
    //             end;
    //           end;
    //           GenericWebServiceClient.RESET; //HEI.82
    //         end;
    //       //GenericWebServiceClient.RESET; //HEI.82
    //       //<< HEI.79

    //     //<< HEI.68
    // end;  // BC Upgrade NANDIS03 - moved from CU50015

    // [EventSubscriber(ObjectType::Codeunit, 414, 'OnAfterReleaseSalesDoc', '', false, false)]
    // local procedure OnAfterReleaseSalesDocument(var SalesHeader : Record "Sales Header";PreviewMode : Boolean);
    // var
    //     DDEInterfaceMgmt : Codeunit "DDE Interface Mgmt.";
    // begin
    //     //HEI.81>>
    //     if SalesHeader.ISTEMPORARY then
    //       exit;

    //     if SalesHeader."Source System Identifier" <> 'DDE' then
    //       exit;

    //     if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
    //       exit;

    //     DDEInterfaceMgmt.CreateEmailNotificationOnAfterRelease(SalesHeader);
    //     //HEI.81<<
    // end;  // BC Upgrade NANDIS03 - moved from CU 50015

    // [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    // local procedure OnAfterPostSalesDocument(var SalesHeader : Record "Sales Header";var GenJnlPostLine : Codeunit "Gen. Jnl.-Post Line";SalesShptHdrNo : Code[20];RetRcpHdrNo : Code[20];SalesInvHdrNo : Code[20];SalesCrMemoHdrNo : Code[20]);
    // var
    //     DDEInterfaceSetup : Record "DDE Interface Setup INT";
    //     SalesShipmentHeader : Record "Sales Shipment Header";
    //     ReturnReceiptHeader : Record "Return Receipt Header";
    //     DDEInterfaceMgmt : Codeunit "DDE Interface Mgmt.";
    // begin
    //     //HEI.81>>
    //     //HEI.122>>
    //     //IF SalesHeader."Source System Identifier" <> 'DDE' THEN
    //     //  EXIT;
    //     //HEI.122<<

    //     if not DDEInterfaceSetup.GET then
    //       exit;

    //     if not DDEInterfaceSetup."Enable DDE Ship Interface" then
    //       exit;

    //     if (SalesShptHdrNo = '') and (RetRcpHdrNo = '') then
    //       exit;

    //     //HEI.122>>
    //     if SalesHeader."Source System Identifier" <> 'DDE' then
    //       if not DDEInterfaceMgmt.IsManualDDEShipmentEnabled(SalesHeader."Sell-to Customer No.") then
    //         exit;
    //     //HEI.122<<

    //     //Create Outbound Interface for Shipment posted
    //     if SalesShptHdrNo <> '' then begin
    //       SalesShipmentHeader.GET(SalesShptHdrNo);
    //       DDEInterfaceMgmt.CreateDDEShipmentInterface(SalesShipmentHeader,SalesHeader."Order Id");
    //       DDEInterfaceMgmt.CreateEmailNotificationOnAfterPostShip(SalesShipmentHeader);
    //       //HEI.122>>
    //       if SalesShipmentHeader."Source System Identifier" <> 'DDE' then begin
    //         SalesShipmentHeader."Source System Identifier" := 'DDE';
    //         SalesShipmentHeader.MODIFY;
    //       end;
    //       //HEI.122<<
    //     end;

    //     //Create E-mail Notification for Receipt posted
    //     if RetRcpHdrNo <> '' then begin
    //       ReturnReceiptHeader.GET(RetRcpHdrNo);
    //       DDEInterfaceMgmt.CreateEmailNotificationOnAfterPostRcpt(ReturnReceiptHeader);
    //     end;
    //     //HEI.81<<
    // end;  // BC Upgrade NANDIS03 - moved to InterfaceFramework extension
    //BC UPGRADE KUMARR78 <<
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDocument(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]);
    var
        DDEInterfaceSetup: Record "DDE Interface Setup INT";
        SalesShipmentHeader: Record "Sales Shipment Header";
        ReturnReceiptHeader: Record "Return Receipt Header";
        DDEInterfaceMgmt: Codeunit "DDE Interface Mgmt.";
    begin
        //HEI.81>>
        //HEI.122>>
        //IF SalesHeader."Source System Identifier" <> 'DDE' THEN
        //  EXIT;
        //HEI.122<<

        if not DDEInterfaceSetup.GET then
            exit;

        if not DDEInterfaceSetup."Enable DDE Ship Interface" then
            exit;

        if (SalesShptHdrNo = '') and (RetRcpHdrNo = '') then
            exit;

        //HEI.122>>
        if SalesHeader."Source System Identifier FND" <> 'DDE' then
            if not DDEInterfaceMgmt.IsManualDDEShipmentEnabled(SalesHeader."Sell-to Customer No.") then
                exit;
        //HEI.122<<

        //Create Outbound Interface for Shipment posted
        if SalesShptHdrNo <> '' then begin
            SalesShipmentHeader.GET(SalesShptHdrNo);
            DDEInterfaceMgmt.CreateDDEShipmentInterface(SalesShipmentHeader, SalesHeader."Order Id FND");
            DDEInterfaceMgmt.CreateEmailNotificationOnAfterPostShip(SalesShipmentHeader);
            //HEI.122>>
            if SalesShipmentHeader."Source System Identifier FND" <> 'DDE' then begin
                SalesShipmentHeader."Source System Identifier FND" := 'DDE';
                SalesShipmentHeader.MODIFY;
            end;
            //HEI.122<<
        end;

        //Create E-mail Notification for Receipt posted
        if RetRcpHdrNo <> '' then begin
            ReturnReceiptHeader.GET(RetRcpHdrNo);
            DDEInterfaceMgmt.CreateEmailNotificationOnAfterPostRcpt(ReturnReceiptHeader);
        end;
        //HEI.81<<
    end;
    //BC UPGRADE KUMARR78  >>

    // [EventSubscriber(ObjectType::Codeunit, 414, 'OnBeforeReopenSalesDoc', '', false, false)]
    // local procedure CU414OnBeforeReopenSalesDoc(var SalesHeader : Record "Sales Header");
    // var
    //     B2BInterfaceSetup : Record "B2B Interface Setup INT";
    //     ReopenErr : Label 'You are not allowed to reopen a Sales Quote created from B2B interface.';
    // begin
    //     //HEI.118>>
    //     if (SalesHeader."Document Type" = SalesHeader."Document Type"::Quote) then begin
    //       if GUIALLOWED then begin //allow to reopen quote from Job "Delete B2B Sales Quote"
    //         B2BInterfaceSetup.GET;
    //         if (B2BInterfaceSetup."Default Souce System Ident." <> '')  and (B2BInterfaceSetup."Default Souce System Ident." = SalesHeader."Source System Identifier") then
    //           ERROR(ReopenErr);
    //       end;
    //     end;
    //     //HEI.118<<
    // end;  // BC Upgrade NANDIS03 - Moved from CU 50015

    // Added BHANDS01 07-11-2025>>
    //BC Upgrade SHARMP16 begin<<--- Generic Web Service Client codeunit will compile later.
    // [EventSubscriber(ObjectType::Table, 23, 'OnAfterValidateEvent', 'Global Vendor Number', false, false)]
    // local procedure T23OnAfterValidateGlobalVendorNo(var Rec: Record Vendor; var xRec: Record Vendor; CurrFieldNo: Integer);
    // var
    //     Vendor: Record Vendor;
    //     CommonSourceSharingSetup: Record "Common Src Sharing Setup FND";
    //     GlobalSharedSource: Record "Global Shared Source FND";
    //     GenericWebServiceClient: Codeunit "Generic Web Service Client";
    // begin
    //     //HEI.07>>
    //     if Rec."Global Vendor Number" = xRec."Global Vendor Number" then
    //         exit;

    //     //>> HEI.31

    //     if CommonSourceSharingSetup.GET then begin
    //         //>> HEI.48
    //         Vendor.SETRANGE("Global Vendor Number", Rec."Global Vendor Number");
    //         if not Vendor.FINDFIRST then begin
    //             if CommonSourceSharingSetup."Database Level Sharing" = true then begin // HEI.49
    //                 GenericWebServiceClient.CONNECT(CommonSourceSharingSetup."WS Link");
    //                 GenericWebServiceClient.SETFILTER('Global_ID', Rec."Global Vendor Number");
    //                 GenericWebServiceClient.SETFILTER('Local_ID', Rec."No.");
    //                 GenericWebServiceClient.SETFILTER('Company_ID', COMPANYNAME);
    //                 GenericWebServiceClient.SETFILTER('Blocked', 'false');
    //                 if GenericWebServiceClient.READMULTIPLE then
    //                     GenericWebServiceClient.DELETE;
    //             end; //HEI.49
    //         end;
    //         //<< HEI.48
    //         if CommonSourceSharingSetup."Enable Common Vendor Sharing" then begin
    //             GlobalSharedSource.RESET;
    //             GlobalSharedSource.SETRANGE("Source Type", GlobalSharedSource."Source Type"::Vendor);
    //             GlobalSharedSource.SETRANGE("Global ID", Rec."Global Vendor Number");
    //             GlobalSharedSource.SETRANGE("Local ID", Rec."No.");
    //             GlobalSharedSource.SETRANGE("Company ID", COMPANYNAME);
    //             GlobalSharedSource.SETRANGE(Blocked, false);
    //             if GlobalSharedSource.FINDFIRST then
    //                 ERROR(GlobalVendorNoExistsErr, Vendor."Global Vendor Number", Vendor."No.")
    //             else
    //                 exit;
    //         end;
    //     end; // HEI.48
    //     //<< HEI.31

    //     Vendor.SETRANGE("Global Vendor Number", Rec."Global Vendor Number");
    //     if Vendor.FINDFIRST then
    //         ERROR(GlobalVendorNoExistsErr, Vendor."Global Vendor Number", Vendor."No.");
    //     //HEI.07<<
    // end;
    //BC Upgrade SHARMP16 end>>--- Generic Web Service Client codeunit will compile later.
    // Added BHANDS01 07-11-2025<<

    //BC Upgrade GUNREM01 - 99000832 "Sales Line-Reserve" >>

    //     DITW15.00.00.38 DDR 17/11/2010 issue 1139 SSCC Functionnalities
    // DITW16.00.00.40 DDR 03/02/2012 #1331 (HIT0069.1 VVE 19/04/2011) FEFO tracking
    //                            Added/Rewrite functions FEFOTracking()
    //                            Added text constants Text2014060,Text2014061
    //                     13/02/2012 #1331 Remove test to check item lot or serial nos.
    //                     14/02/2012 #1331 Bugfix to calculate per bin for function FEFOTracking()
    //                     09/03/2012 #1331 Bugfix to calculate the previous lot/serial reservation
    //                     21/03/2012 #1331 Added field "Allow FEFO Trkg Blocked Lots" for function FEFOTracking()
    // DITW16.00.00.42 DDR 01/03/2013 DIT-715 #574 Bugfix function FEFOTracking() missing filter on Reserv. entries
    // DITW16.00.00.43 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Added call function TestExistReservSSCC()
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                             NORRIQ owm - Online Warehouse Management
    //                                             Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               DeleteLineConfirm: GUIALLOWED added.
    // DITW16.00.00.43 DDR 05/12/2013 DIT-715 #761 Bugfix to call function DeleteInvoiceSpecFromLine()

    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    // DITW17.00.02 DDR 14/01/2014 DIT-715 #761 Merge
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW18.00.07 VSC 07/04/2016 DIT-770 #1920 new function DeleteInvalidEnties and CheckMaxQuantity
    // DITW18.00.07 VSC 10/05/2016 DIT-770 #1920 CheckMaxQuantity only when entry exists
    // DITW19.00.08 DDR 12/08/2016 BL#10300 (DIT-770 #2118) Bugfix function FEFOTracking() to work with Outstanding quantity
    // DITW19.00.08 DDR 29/09/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    // DITW19.00.08 DDR 20/10/2016 BL#10443 added to transfer volume strength field values
    // DITW19.00.08 AKH 02/12/2016 BL#9821 (DIT-770 #2081) Disabled changes from DIT-770 #1920

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // HEI.01 FDDGAPLOG01 IBM HORTOC01 - 27.09.2018 #new function
    // DITW110.00.12A DDR 03/07/2018 NRQ#68930 Fix allow Fefo tracking on automatic promotion

    //BC Upgrade GUNREM01 -HEI.01
    procedure ShowConfirmationMessage(ShowMessage: Boolean)
    begin
        ShowConfirmMessage := ShowMessage;//HEI.01
    end;

    //BC Upgrade GUNREM01 - 99000832 "Sales Line-Reserve" <<


    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";  // BC Upgrade NANDIS03
        GeneralInterfaceSetupRead: Boolean;  // BC Upgrade NANDIS03
        ShowConfirmMessage: Boolean; //BC Upgrade GUNREM01 

    //Bc Upgrade YADAVM09 <<6620-Copy Document Management>>
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Copy Document Mgt.", 'OnUpdateSalesCreditMemoHeaderOnBeforeSetShipmentDate', '', true, true)]
    local procedure OnUpdateSalesCreditMemoHeaderOnBeforeSetShipmentDate(SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        SalesHeader."WMS Export FND" := FALSE;//HEI.22 single line // BC upgrade SHARMP16-- Review object
    end;
    //Bc Upgrade YADAVM09 <<6620-Copy Document Management<<

    // BC Upgrade BHARDA11 >> ----This event substitutes the base report with the customized report.This replacement applies everywhere, whether the base report is used in an action, in code, or in any process.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Copy Fixed Asset" then
            NewReportId := Report::"Copy Fixed Asset 2";
    end;
    // BC Upgrade BHARDA11 << ----This event substitutes the base report with the customized report.This replacement applies everywhere, whether the base report is used in an action, in code, or in any process.


    // BC Upgrade SHUKLP03 >> codeunit 1290 "SOAP Web Service Request Mgt."

    // BC Upgrade SHUKLP03 >> 
    // As per discussion happened with Sakshi we are adding our custom procedure SendRequestToWebService2() for future reference purpouse only and we have used base procedure SendRequestToWebService() instead of this in our custom code.
    // BC Upgrade SHUKLP03 <<

    // [TryFunction]
    // procedure SendRequestToWebService2()
    // var
    //     WebRequestHelper: Codeunit "Web Request Helper";
    //     HttpWebRequest	DotNet	System.Net.HttpWebRequest.'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
    //     HttpStatusCode	DotNet	System.Net.HttpStatusCode.'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
    //     ResponseHeaders	DotNet	System.Collections.Specialized.NameValueCollection.'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
    //     ResponseInStream: InStream;
    //     GeneralInterfaceSetup: Record "General Interface Setup INT";
    //     WebServReqMgt: Codeunit "SOAP Web Service Request Mgt.";
    //     ServicePointMgr	DotNet	System.Net.ServicePointManager.'System, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'	
    // begin
    //     //HEI.01>>
    //     WebServReqMgt.CheckGlobals;
    //     //HEI.03>>
    //     GeneralInterfaceSetup.GET;
    //     IF GeneralInterfaceSetup."Use TLS1.1 TLS1.2" THEN
    //         ServicePointMgr.SecurityProtocol := 48 + 192 + 768 + 3072 //48 - Ssl3, 192 - Tls, Tls11 - 768, Tls2 - 3072
    //     ELSE
    //         ServicePointMgr.SecurityProtocol := 48 + 192; //48 - Ssl3, 192 - Tls (DEFAULT - DotNET 4.5.2)
    //                                                       //HEI.03<<
    //     BuildWebRequest(GlobalURL, HttpWebRequest);
    //     ResponseInStreamTempBlob.INIT;
    //     ResponseInStreamTempBlob.Blob.CREATEINSTREAM(ResponseInStream);
    //     CreateSoapRequest(HttpWebRequest.GetRequestStream, GlobalRequestBodyInStream, GlobalUsername, GlobalPassword);
    //     WebRequestHelper.GetWebResponse(HttpWebRequest, HttpWebResponse, ResponseInStream,
    //       HttpStatusCode, ResponseHeaders, GlobalProgressDialogEnabled);
    //     //HEI.01<<
    // end;
    // BC Upgrade SHUKLP03 << codeunit 1290 "SOAP Web Service Request Mgt."
    // BC Upgrade BHARDA11 >>
    /* Codeunit 50023 "Inventory Hooks" */
    /* We have divided Inventory Hooks codeunit 50023 into three parts.
In the first part, the main code has been placed in the DTW extension Under this Codeunit ID 54004.
In the second part, the code related to the interface from that codeunit has been placed in the interface extension here.
In the third part, the section containing our DotNet variables has been kept separately, and that part is still pending. */
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeInsertEvent', '', false, false)]
    local procedure T27OnBeforeInsert(var Rec: Record Item; RunTrigger: Boolean);
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        SessionGlobals: Codeunit "Session Globals";
        LocalNo: Code[20];
        GlobalNo: Code[20];
        NoOfCharsToFill: Integer;
        GlobalItemNoFormatErr: Label 'Global item no. %1 is longer than %2 %3 from %4. You must adjust %5 or send a valid global number.';
    begin
        //HEI.07>>
        GeneralInterfaceSetup.GET;
        if (not GeneralInterfaceSetup."Enable IC Item Numbering") or
           (SessionGlobals.GetItemGlobalNo = '')
        then
            exit;

        GeneralInterfaceSetup.TESTFIELD("Item Numbering Format");
        NoOfCharsToFill := STRLEN(GeneralInterfaceSetup."Item Numbering Format") -
                   STRPOS(GeneralInterfaceSetup."Item Numbering Format", '#') + 1;
        if NoOfCharsToFill < STRLEN(SessionGlobals.GetItemGlobalNo) then
            ERROR(GlobalItemNoFormatErr, SessionGlobals.GetItemGlobalNo,
                                        GeneralInterfaceSetup.FIELDCAPTION("Item Numbering Format"),
                                        GeneralInterfaceSetup."Item Numbering Format",
                                        GeneralInterfaceSetup.TABLECAPTION,
                                        GeneralInterfaceSetup.FIELDCAPTION("Item Numbering Format"));
        GlobalNo := PADSTR('', NoOfCharsToFill - STRLEN(SessionGlobals.GetItemGlobalNo), '0') + SessionGlobals.GetItemGlobalNo;
        LocalNo := STRSUBSTNO(GeneralInterfaceSetup."Item Numbering Format", GlobalNo);
        Rec."No." := LocalNo;
        //HEI.07<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Attribute Value Mapping", 'OnAfterInsertEvent', '', false, false)]
    local procedure T7505OnAfterInsert(var Rec: Record "Item Attribute Value Mapping"; RunTrigger: Boolean);
    var
        Item: Record Item;
        ItemAttributeCILCode: Record "Item Attribute CIL Code RTR";
    begin
        //HEI.04>>
        if (Rec."Table ID" <> DATABASE::Item) or
   Rec.ISTEMPORARY
then
            exit;

        ItemAttributeCILCode.SETRANGE("Attribute ID", Rec."Item Attribute ID");
        if not ItemAttributeCILCode.ISEMPTY then begin
            Item.GET(Rec."No.");
            ItemAttributeCILCode.SETRANGE("Attribute Value ID", Rec."Item Attribute Value ID");
            if ItemAttributeCILCode.FINDFIRST then begin
                Item.VALIDATE("CIL ID Code RTR", ItemAttributeCILCode."CIL ID Code");
                Item.VALIDATE("CIL ID2 Code RTR", ItemAttributeCILCode."CIL ID2 Code");
            end else begin
                Item.VALIDATE("CIL ID Code RTR", '');
                Item.VALIDATE("CIL ID2 Code RTR", '');
            end;
            Item.MODIFY;
        end;
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Attribute Value Mapping", 'OnAfterModifyEvent', '', false, false)]
    local procedure T7505OnAfterModify(var Rec: Record "Item Attribute Value Mapping"; var xRec: Record "Item Attribute Value Mapping"; RunTrigger: Boolean);
    var
        Item: Record Item;
        ItemAttributeCILCode: Record "Item Attribute CIL Code RTR";
    begin
        //HEI.04>>
        if (Rec."Table ID" <> DATABASE::Item) or
   Rec.ISTEMPORARY
then
            exit;

        ItemAttributeCILCode.SETRANGE("Attribute ID", Rec."Item Attribute ID");
        if not ItemAttributeCILCode.ISEMPTY then begin
            Item.GET(Rec."No.");
            ItemAttributeCILCode.SETRANGE("Attribute Value ID", Rec."Item Attribute Value ID");
            if ItemAttributeCILCode.FINDFIRST then begin
                Item.VALIDATE("CIL ID Code RTR", ItemAttributeCILCode."CIL ID Code");
                Item.VALIDATE("CIL ID2 Code RTR", ItemAttributeCILCode."CIL ID2 Code");
            end else begin
                Item.VALIDATE("CIL ID Code RTR", '');
                Item.VALIDATE("CIL ID2 Code RTR", '');
            end;
            Item.MODIFY;
        end;
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Attribute Value Mapping", 'OnAfterDeleteEvent', '', false, false)]
    local procedure T7505OnAfterDelete(var Rec: Record "Item Attribute Value Mapping"; RunTrigger: Boolean);
    var
        Item: Record Item;
    begin
        //HEI.04>>
        if (Rec."Table ID" <> DATABASE::Item) or
   Rec.ISTEMPORARY
then
            exit;

        Item.GET(Rec."No.");
        Item.VALIDATE("CIL ID Code RTR", '');
        Item.VALIDATE("CIL ID2 Code RTR", '');
        Item.MODIFY;
        //HEI.04<<
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Item Category Code', false, false)]
    local procedure T27OnAfterValidateItemCategoryCode(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer);
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        DefaultDimension: Record "Default Dimension";
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        ItemCategory: Record "Item Category";
    begin
        //HEI.06>>
        if Rec."Item Category Code" = xRec."Item Category Code" then
            exit;

        SalesReceivablesSetup.GET;
        if STRPOS(SalesReceivablesSetup."RPMRelatedItemCategoryCode FND", Rec."Item Category Code") <> 0 then begin
            Rec.VALIDATE("Item Type FND", Rec."Item Type FND"::"RPM Related");
            GeneralInterfaceSetup.GET;
            GeneralInterfaceSetup.TESTFIELD("CMG Dimension Code");
            DefaultDimension.RESET;
            DefaultDimension.SETRANGE("Table ID", 27);
            DefaultDimension.SETRANGE("No.", Rec."No.");
            DefaultDimension.SETRANGE("Dimension Code", GeneralInterfaceSetup."CMG Dimension Code");
            if DefaultDimension.FINDFIRST then
                Rec.VALIDATE("RPM Type FND", DefaultDimension."Dimension Value Code");
            //ERROR(Rec."RPM Type");
            UpdateSKU(Rec);
            exit;
        end else
            Rec.VALIDATE("Item Type FND", Rec."Item Type FND"::" ");


        if STRPOS(SalesReceivablesSetup."Product RelatedItemCatCode FND", Rec."Item Category Code") <> 0 then
            Rec.VALIDATE("Item Type FND", Rec."Item Type FND"::"Product Related")
        else
            Rec.VALIDATE("Item Type FND", Rec."Item Type FND"::" ");
        //HEI.06<<

        UpdateSKU(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterInsertEvent', '', false, false)]
    local procedure T352OnAfterInsert(var Rec: Record "Default Dimension"; RunTrigger: Boolean);
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        Item: Record Item;
    begin
        //HEI.06>>
        if Rec.ISTEMPORARY then
            exit;

        GeneralInterfaceSetup.GET;
        GeneralInterfaceSetup.TESTFIELD("CMG Dimension Code");
        if (Rec."Table ID" = 27) and (Rec."Dimension Code" = GeneralInterfaceSetup."CMG Dimension Code") then begin

            Item.GET(Rec."No.");
            if Item."Item Type FND" = Item."Item Type FND"::"RPM Related" then begin
                Item.VALIDATE("RPM Type FND", Rec."Dimension Value Code");
                Item.MODIFY;

                UpdateSKU(Item);
            end;
        end;

        //HEI.06<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterModifyEvent', '', false, false)]
    local procedure T352OnAfterModify(var Rec: Record "Default Dimension"; var xRec: Record "Default Dimension"; RunTrigger: Boolean);
    var
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        Item: Record Item;
    begin
        //HEI.06>>
        if Rec.ISTEMPORARY then
            exit;


        GeneralInterfaceSetup.GET;
        GeneralInterfaceSetup.TESTFIELD("CMG Dimension Code");
        if (Rec."Table ID" = 27) and (Rec."Dimension Code" = GeneralInterfaceSetup."CMG Dimension Code") then begin

            Item.GET(Rec."No.");
            if Item."Item Type FND" = Item."Item Type FND"::"RPM Related" then begin
                Item.VALIDATE("RPM Type FND", Rec."Dimension Value Code");
                Item.MODIFY;
                UpdateSKU(Item)
            end;
        end;

        //HEI.06<<
    end;

    local procedure UpdateSKU(Item: Record Item);
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        StockkeepingUnit.RESET;
        StockkeepingUnit.SETRANGE("Item No.", Item."No.");
        if StockkeepingUnit.FINDSET then
            repeat
                StockkeepingUnit.VALIDATE("Item Type FND", Item."Item Type FND");
                StockkeepingUnit.VALIDATE("RPM Solution FND", Item."RPM Solution FND");
                StockkeepingUnit.VALIDATE("RPM Type FND", Item."RPM Type FND");
                StockkeepingUnit.MODIFY;
            until StockkeepingUnit.NEXT = 0;
    end;
    // BC Upgrade BHARDA11 >> ---- This event has been created so that we can use our interface code on the OnRun trigger of the Inventory Hooks codeunit.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Hooks", OnBeforeRunProcessingInvHooks, '', false, false)]
    local procedure OnBeforeRunProcessingInvHooks()
    var
        DefDim: Record "Default Dimension";
        Item: Record Item;
        TempItem: Record Item temporary;
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        LocalNo: Text;
        NoOfCharsToFill: Integer;
        GlobalNo: Text;

        GlobalItemNoFormatErr: Label 'Global item no. %1 is longer than %2 %3 from %4. You must adjust %5 or send a valid global number.';
    begin
        GeneralInterfaceSetup.GET();
        GeneralInterfaceSetup.TESTFIELD("Item Numbering Format");
        if not CONFIRM('Rename items') then
            exit;
        /*
        DefDim.SETRANGE("Table ID",27);
        IF DefDim.FINDSET THEN REPEAT
          IF NOT Item.GET(DefDim."No.") THEN
            DefDim.DELETE(TRUE);
        UNTIL DefDim.NEXT = 0;*/
        //EXIT;  ..0020000224
        Item.SETRANGE("No.", '0020000124', '0020000224');
        if Item.FINDSET() then
            repeat
                TempItem.TRANSFERFIELDS(Item);
                TempItem.INSERT();
            until Item.NEXT = 0;

        TempItem.RESET();
        if TempItem.FINDSET() then
            repeat
                Item.GET(TempItem."No.");


                LocalNo := '';
                //GeneralInterfaceSetup.TESTFIELD("Item Numbering Format");
                NoOfCharsToFill := STRLEN(GeneralInterfaceSetup."Item Numbering Format") -
                   STRPOS(GeneralInterfaceSetup."Item Numbering Format", '#') + 1;
                if NoOfCharsToFill < STRLEN(Item."No. 2") then
                    ERROR(GlobalItemNoFormatErr, Item."No. 2",
                                                GeneralInterfaceSetup.FIELDCAPTION("Item Numbering Format"),
                                                GeneralInterfaceSetup."Item Numbering Format",
                                                GeneralInterfaceSetup.TABLECAPTION,
                                                GeneralInterfaceSetup.FIELDCAPTION("Item Numbering Format"));
                GlobalNo := PADSTR('', NoOfCharsToFill - STRLEN(Item."No. 2"), '0') + Item."No. 2";
                LocalNo := STRSUBSTNO(GeneralInterfaceSetup."Item Numbering Format", GlobalNo);

                if LocalNo <> '' then begin
                    Item.RENAME(LocalNo);
                end;
            until TempItem.NEXT = 0;
    end;
    // BC Upgrade BHARDA11 << ---- This event has been created so that we can use our interface code on the OnRun trigger of the Inventory Hooks codeunit.
    /* We have divided Inventory Hooks codeunit 50023 into three parts.
In the first part, the main code has been placed in the DTW extension under this Codeunit ID 54004.
In the second part, the code related to the interface from that codeunit has been placed in the interface extension here.
In the third part, the section containing our DotNet variables has been kept separately, and that part is still pending. */
    /* Codeunit 50023 "Inventory Hooks" */
    // BC Upgrade BHARDA11 <<

    //BC Upgrade GUNREM01 - Codeunit 22 Item Jnl.-Post Line >>
    //     DITW15.00.00.01 DDR 27/12/2007 Added Drink-it Tax Item Charges functionnalities
    //                                  function CalcExpectedCost() new arguments ExpectedTaxSalesAmt,ExpectedTaxPurchAmt
    //                                  function CollectItemChargeValueEntryRel();
    // DITW15.00.00.01 DDR 03/01/2008 Added Drink-it Deposit Item Charges functionnalities
    //                                  change CalcExpectedCost() new arguments ItemChargeType
    // DITW15.00.00.01 DDR 04/01/2008 added "Item DDeposit Group Code"
    // DITW15.00.00.01 DDR 07/01/2008 added field "Item Charge Quantity per"
    //                                added field "Tax Posted To G/L"
    //                                bugfix "Valued Quantity" for new item charges
    // DITW15.00.00.01 DDR 09/01/2008 added functions
    //                                  PostTaxToGL;SetCalledFromAdjustmentTax;InsertTaxPostValueEntryToGL;IsTaxPostToGL
    //                                added field "Due Tax","Expected Tax Posted to G/L"
    //                                purchase item charge (no cost amounts)
    // DITW15.00.00.01 DDR 10/01/2007 Added fields
    // DITW15.00.00.01 DDR 10/01/2007 Added field "Due Tax"
    // DITW15.00.00.01 DDR 21/12/2007 Added Drink-it Discount & Promotion Item Charges functionnalities
    // DITW15.00.00.01 DDR 20/02/2008 Added field2013785 Periodic Disc.-Promo Entry No.
    // DITW15.00.00.01 DDR 28/01/2008 Bugfix conflict to insert G/L Entry between PostInventoryToGL() and PostTaxToGL()
    // DITW15.00.00.01 DDR 14/03/2008 Added field2013767 Unit Volume HL (into Item Ledger Entry)
    //                                Added field2013786 Quantity in HL (into Item Ledger Entry)
    //                                Transfer Initial Entry Due Date into Value Entry
    // DITW15.00.00.15 DDR 25/03/2008 Beta-RC1: Certification rules
    // DITW15.00.00.16 DDR 28/03/2008 Adapted Undo/Correction item journal functionnality
    // DITW15.00.00.19 DDR 04/04/2008 Certification rules
    // DITW15.00.00.20 DDR 06/06/2008 Certification rules
    // DITW15.00.00.22 PRODW14.00.00.08 DDR 09/07/2008 BrewIt & Quality
    // DITW15.00.00.24 DDR 23/07/2008 Added fields "Item Ledger Entry Quantity HL","Invoiced Quantity in HL" into Value Entry
    //                     22/09/2008 Added function MoveItemToLedgEntry() to copy item Specification/Tariff values into Item ledger entry.
    //                     25/09/2008 Added Duty point to post attached tax item charges and change "posting date" of entries
    //                     01/10/2008 don't fill "Unit Volume HL" into Value Entry when "item charge no." exists
    //                                update function IsTaxPostToGL();InsertTaxPostValueEntryToGL()
    //                     07/10/2008 Added field "Duty Tax Type" to transfer into Value Entry
    // DITW15.00.00.25 DDR 15/10/2008 Change flow Duty point: Remove existing c/al
    //                     21/10/2008 Removed flow "Duty Tax Type"
    //                     22/10/2008 Bugfix initialisation variable blnTaxPostToGL
    //                     24/10/2008 Added rule to skip Transfer-to Charge lines
    //                                  if new location code is not specified
    //                                  if location = new location code
    //                     27/10/2008 Added new field "Opposite Amount Sign" for the Internal Tax amounts
    //                                  (only used with Item, BOM journals)
    // DITW15.00.00.26 DDR 17/11/2008 Bugfix missing "cost per unit" & "Cost Amount"
    //                                  when Value Entry with "Item Charge Type" is ShippingCost
    // DITW15.00.00.30 DDR 19/01/2009 Added/Bugfix transfer field
    //                                  "Source DTax Group Code";"Source Deposit Group Code"
    // DITW15.00.00.31-PRODW14.00.00.08.10 DLE 13/02/2009 License problem
    // DITW15.00.00.31 DDR 19/02/2009 Added to save "Last Price Calculated Date" into Item Ledger, Value entries
    //                                Added to allow variance,rounding value entry When not standard Item charges (Shipping costs)
    // DITW15.00.00.32 DDR 12/03/2009 Bugfix missing get/set the G/L Register while post the item costs (with Output journal)
    //                                Bugfix "Unit Volume HL" with qty per unit of measure
    //                     07/04/2009 Bugfix missing Variance entry for item charges with Purchases
    // PRODW14.00.00.08.12 DDR 14/05/2009
    //   CITQLT1.00 002 Bypass Lot No./Serial no checks for Phs. Inventory types jnl. lines
    // DITW15.00.00.33 DDR 15/05/2009 Bugfix to calculate the "Valued quantity in HL" into Value entry
    // DITW15.00.00.33 DDR 08/06/2009 Bugfix to reverse expected costs with discount & promotion item charges
    // DITW15.00.00.34 DDR 03/07/2009 Added field "Tax Formunla" into Value Entry
    //                                Added field "Tariff No." into Item Ledger Entry
    // DITW15.00.00.34 PRODW14.00.00.13 DDR 10/07/2009
    //                                Added Output entry type to check Quality Tracked items
    // DITW15.00.00.35 DDR 07/08/2009 issue 757 bugfix Transaction no. in G/L entry
    //                                  Remove function call function SetglReg()
    //                                issue 756 Undo item charges with correction item journal
    //                     10/08/2009 issue 759 bugfix skip checking Lot/Serial nos requirements with item charge journal lines
    //                                issue 760 bugfix calc internal tax amount with transfer/reclassif. journals
    // DITW15.00.00.35 DDR 17/08/2009 Added transfer fields to value entry & item ledger entry
    //                                  "Free Item Posting Type","Free Item","Free Calculation Type","Include Free Qty. in Minimum"
    //                     17/09/2009 Added Purchase service documents
    //                     09/10/2009 issue 781 Due Taxes with Free items
    //                                  Added parameter '"DocumentLineNo' for function CalcExpectedCost()
    // DITW15.00.00.36 DDR 06/11/2009 issue 942 Bugfix Reverse Expected costs (see issue 781)
    // DITW15.00.00.37 DDR 19/01/2010 issue 1038 Allowed the internal item charges within 'output'/'consumption' entry types
    //                     20/01/2010 issue 1020 Added transfer fields into item ledger entry
    //                                  "Location Group Code","Company Tax Registration No.","Physical Location Group Code"
    //                     29/01/2010 issue 1054 Added call function CreateAADOnItemJnlLine(),cduAADDocMgt.UpdateAADOnItemEntry()
    //                     17/02/2010 issue 1032 Bugfix calculation of Value quantity with discount item charge per order
    //                     01/03/2010 issue 1089 Bugfix Item application entries while undo a receipt document within item charges
    //                     14/04/2010 issue 1077 Bugfix to calculate the DIT item charge expected (shpt/rcpt) amounts to reverse
    //                                           Added parameter "ItemChargeNo" for function CalcExpectedCost()
    //                     30/04/2010 issue 1128 Bugfix skip to post Whse journal & insert capacity entry & update prod.order document
    //                                             while item charge line from production journal.
    //                                issue 1038 Added to calculate the expected internal taxes
    //                                           Added to post tax output journal lines directly
    //                     20/05/2010 issue 1081 Added transfer fields "New Location Group Code","New Phys. Location Group Code"
    //                     25/05/2010 issue 1037 Added to delete AAD Tracking Entry when item journal correction document (from undo)
    //                                           Added function UndoAADTrackingEntryFrom()
    //                                           Added text constant Text2013660
    //                     28/05/2010 issue 480 Allow item charges for transfer orders
    // DITW15.00.00.37 PRODW14.00.00.16 DDR 22/06/2010 issue 1151 Added function ShowQualityTests()
    //                     24/06/2010 issue 1181 Bugfix to calculate the standard value entry fields Sales & Cost Amounts (Expected)
    // DITW15.00.00.37 DDR 18/01/2011 DIT-715 issue 48 (Merge Error) missing to reverse item charge expected costs
    // DITW15.00.00.38 DDR 05/07/2010 issue 1109 Added to split Due Taxes Item charge assignements by Lot/Serial tracking line
    //                                           Added function SetupChargeSplitJnlLine()
    //                     24/08/2010 issue 1217 EMCS (e-AAD) Functionnalities
    //                                           Added function UndoLRNTrackingEntryFrom()
    //                                           Added to transfer all EMCS fields
    //                     30/09/2010            Bugfix to post and create AAD Tracking on Purchase orders & Return Receipts
    //                     12/10/2010            Bugfix functions UndoLRNTrackingEntryFrom()
    // DITW15.00.00.38 DDR 22/10/2010 issue 1139 SSCC Functionnalities
    //                                           Added check on SSCC no. and quantities (if required)
    //                                           Added 'Permissions' codeunit property for table 2035041 "SSCC Ledger Entry"
    //                                           Added text constants Text2035040,Text2035041,Text2035042,Text2035043,Text2035044,
    //                                             Text2035045
    //                                           Added functions InitSSCCLedgEntry(),InsertSSCCLedgEntry(),GetSSCCSetup(),
    //                                             SetupSplitJnlLineSSCC(),SplitJnlLineSSCC(),InsertTempTrkgSpecSSCC(),
    //                                             CollectTrackingSpecSSCC()
    //                     29/10/2010            Added functions
    //                                             SSCCQtyPosting(),ApplySSCCLedgEntry(),InsertTransferSSCCEntry(),AutoTrackSSCC(),
    //                                             CollectSSCCEntryRelation()
    //                                           Updated functions
    //                                             InitSSCCLedgEntry(),InsertSSCCLedgEntry() to transfer "Pallet No." field
    //                                             InsertTempTrkgSpecSSCC() to transfer (applied) sscc entry no.
    //                                           Modified workflow call SplitJnlLineSSCC()
    //                                           Added text constants Text2035046,Text2035047
    //                                           Added functions
    //                                             UpdateSSCCLedgEntry(),UpdateOutboundSSCCLedgEntry(),UpdateOldSSCCLedgEntry(),
    //                                             CheckSSCCTracking(),UndoSSCCQuantityPosting(),InitCorrSSCCLedgEntry(),
    //                                             UpdateOldSSCCLedgEntry(),SetUndoOldSSCCEntry()
    //                     18/11/2010 issue 1239 Bugfix to post the Inventory Adjustment item journals (from report 795)
    //                     22/11/2010 issue 1139 (DIT711 91)
    //                                             Updated functions for Production
    //                                             Added to save SSCC "Creation Date","Creation Time"
    //                     03/12/2010 issue 1229 Added to undo the posted due taxes
    //                     03/12/2010 issue 1139 (DIT711 95) Bugfix to undo SSCC Tracking reservation entries
    //                     09/12/2010 issue 1139 (DIT711 100) Added field "SSCC Company No."
    //                     10/12/2010 issue 1139 (DIT711 101) Removed double call to function UpdateOutboundSSCCLedgEntry()
    //                     14/12/2010 issue 1096 Modified function IsPostToGL() to allow the shipping costs (using report1002)
    //                     17/12/2010 issue 703 Added fields "Tax Item No."
    //                     18/01/2011 restore Navision source code into function InsertValueEntry() old DITW15.00.00.34 DDR 08/06/2009
    //                     26/01/2011 issue 703 Temp disable to copy item tax specifications with "tax item no." (see issue 1276)
    //                                          ! bug multi formula to be fixed with issue 1276
    //                     01/02/2011 issue 1229 Bugfix to undo tax value entry when Duty suspended
    // DITW15.00.00.38 PRODW14.00.00.08.17 DDR 09/02/2011 issue 1272 Bugfix function UpdateQualityTest() skip field "quantity (base)"
    // DITW15.00.00.38 DDR 11/02/2011 issue 1276 Bugfix Tax formula when using Tax item no.
    //                     11/03/2011 issue 703 Removed calculation within "Item Charge Quantity per"
    //                                          Added 'TaxItemNo' parameter function CalcExpectedCost()
    //                     16/03/2011 issue 1096 Modified function IsPostToGL() to allow the discount costs (using report1002)
    //                     18/03/2011 issue 703 Copy the "Source no." into "Tax Item no." following setup
    // DITW15.00.00.39 DDR 12/04/2011 issue 1296 Bugfix to create AAD (ARC) tracking entries with transfer inbound (receipt)
    // DITW15.00.00.39 DDR 29/04/2011 issue 1321 Bugfix Split item charge (item journal) when multi item tracking lines
    //                                              wrong item ledger entry no. into value entry
    //                     05/08/2011 issue 1230 Added to transfer field "Ship-to/Order Address code" into item ledger entry
    //                     19/08/2011 issue 1363 Added to transfer field "Tax Date" into Value Entry
    //                     21/09/2011 issue 1363 Bugfix to fill "Tax Date" into Value Entry
    //                     23/09/2011 issue 1258 FA Back on inventory (v2) from all positive journal lines & check item is back
    //                                           Added text constant Text2034840,Text2034841
    //                                           Skip Unit Cost per Unit when "Inventory Value Zero" into Value Entry
    //                                           Added function ItemInventoryValueZero()
    //                     26/09/2011 issue 1363 Added to transfer field "Tax Date" into Value Entry
    //                     06/10/2011 issue 1441 Added check if exists SSCC tracking lines and item tracking code is not set within SSCC
    //                     19/10/2011 issue 1363 Added to fill "Tax Date" with "Posting Date" if empty
    // DITW16.00.00.40 DDR 05/12/2011 issue DIT-715 183 Bugfix to check if item and service item is already sold or returned
    //                     05/01/2012 DIT-715 #172 Added fields "Allow VAT Calculation (Free)" into Value Entry
    // DITW16.00.00.40 DDR 13/01/2012 DIT-715 #178 Bugfix to post the Quantity into SSCC ledger entry with Qty.UOM <> 1
    //                                             Added functions CodeSSCC() to initialize the split SSCC journal like as LOT journal
    //                     06/02/2012 issue 1299 Bugfix to clear temporary split item charge lines for next item journal
    //                     28/02/2012 DIT-715 #252 Copy always the item description and if emtpy get from the item card.
    //                     08/03/2012 DIT-715 #275 Added all SSCC Mixed fields into SSCC Ledger Entries
    //                     03/05/2012 DIT-715 #292 Added "Bin Code" into SSCC Ledger Entries
    //                     21/05/2012 DIT-715 #182 Review item charge workflow when Purchase order linked to Prod. order (subcontract
    //                     24/05/2012 DIT-715 #312 Bugfix (hidden) to calculate expected deposit amounts
    //                     11/06/2012 DIT-715 #292 Bugfix to apply the SSCC ledger entries about Put-away/Picking Lines
    //                     12/06/2012 DIT-715 #304 Bugfix to copy the sscc expiration/warranty dates for transfer orders
    //                     18/06/2012 DIT-715 #292 Bugfix to check the sscc and availability bin codes
    // DITW16.00.00.41 DDR 22/10/2012 DIT-715 #457 Added to fill "Work Order" field on the item ledger entry
    //                     14/11/2012 DIT-715 #507 Bugfix PostConsumption(),PostOutput() when item charge journal line (double value entrie
    // DITW16.00.00.42 DDR 12/02/2013 DIT-715 #561 Bugfix skip CalcExpectedCost() with standard Item Charges and not attached to items
    //                     01/03/2013 DIT-715 #563 Modified SSCC from Item Tracking Code Fields
    //                                             Added functions CheckSSCCTrackingInfo()
    //                     02/04/2013 DIT-715 #588 Bugfix when posting from Whse. Reclass/Phys. Journals
    // DITW16.00.00.43 DDR 03/05/2013 DIT-715 #634 Bugfix to update SSCC entry "Invoiced Quantity" field
    //                 DDR 14/06/2013 DIT-715 #676 Bugfix missing to reset filter on SCTempTrackingSpecification
    //                 DDR 18/06/2013 DIT-715 #680 Bugfix to show the right Lot No. while checking the quantities
    //                 DDR 25/09/2013 DIT-715 #519 Added Value Entry fields "Qty. per Unit of Measure","Unit of Measure Code"
    //                 DDR 30/08/2013 DIT-715 #745 Extended SSCC non-Specific
    //                                             Bugfix function UpdateSSCCLedgEntry()
    //                 DDR 24/10/2013 DIT-715 #813 Bugfix to check SSCC is required
    //                 DDR 24/10/2013 DIT-715 #818 Modified function UpdateOutboundSSCCLedgEntry()
    //                 DDR 24/10/2013 DIT-715 #822 Bugfix SSCC Transfer (infinite loop in function TransferItemJnlToSSCCLedgEntry)
    //                                             Bugfix missing [New] Expiration date for the transit sscc ledger entries
    // DITW16.00.00.43 RBE 05/11/2013 DIT-715 #806 Scanning OWM
    //                                               NORRIQ owm - Online Warehouse Management
    //                                               Copyright 2008 by NORRIQ A/S, www.norriq.dk
    //                                               - Added code to OnRun
    //                 DDR 05/11/2013 DIT-715 #813 Removed call function GetSSCCTrackingCheckBalance()
    //                 DDR 06/11/2013 DIT-715 #801 Added using field "Use SSCC Avail. Inventory"
    //                                             Bugfix non-specific (free sscc tracking) and insert sscc entry
    //                 DDR 08/11/2013 DIT-715 #835 Bugfix to post Output/Consumption Journals within SSCC tracking
    //                 DDR 08/11/2013 DIT-715 #752 Bugfix wrong check SSCC with correction journals
    //                 DDR 12/11/2013 DIT-715 #752 Bugfix wrong test to skip the SSCC checking
    //                 DDR 13/11/2013 DIT-715 #775 Skip SSCC entry with Location "Directed Put-away and Pick"
    //                 DDR 28/11/2013 DIT-715 #830 Added fields "Force Trck. Ph.Inv. Non Specif" (SSCC Setup)
    //                 DDR 20/12/2013 DIT-715 #864 Bugfix/Added "Unit Volume HL" and "Valued Quantity in HL" with "Tax item no."
    //                                             Bugfix to calculate "Valued Quantity in HL" with Transfer orders
    //                 DDR 05/12/2013 DIT-715 #761 Bugfix extended sscc non-specific
    // DITW16.00.00.44 DDR 17/02/2014 DIT-715 #906 Bugfix to split item charges (giftbox) with item tracking lines
    //                 DDR 19/03/2014 DIT-715 #911 Bugfix to check quantity of any splitted item charges with item tracking
    //                 DDR 14/05/2014 DIT-715 #925 Bugfix missing get location in function SplitJnlLineSSCC()
    //                 DDR 04/06/2014 DIT-715 #926 Bugfix NAV Standard
    //                 DDR 23/06/2014 DIT-715 #920 Added to copy Tax Specification Ledger Entries while undo item jnl
    // DITW16.00.00.45 DDR 27/10/2014 DIT-715 #941 Bugfix Giftbox calc. "Unit Volume HL" with Transfer orders

    // DITW17.00.01 DDR 13/02/2013 DIT-770 #001 Upgrade
    // DITW17.00.02 DDR 03/05/2013 DIT-715 #634 merge
    //                  04/06/2013 DIT-770 #101 Modified to update "Last EDI Modified Date"
    //                                          Added field ItemJnlLine."Ship-to Country/Region Code" into Value entries
    //             DDR 14/06/2013 DIT-715 #676 merge
    //             DDR 18/06/2013 DIT-715 #680 merge
    //             DDR 04/07/2013 DIT-770 #99 Added field ItemJnlLine."GWC Country/Region Code" into Item Ledger Entries
    //                                        Modified functions Item application to filter per GWC country code
    //             DDR 05/07/2013 DIT-700 #99 Bugfix inverse item application
    //             DDR 24/07/2013 DIT-770 #101 Added fields ItemJnlLine "Cust/Vendor DTax Group Code" into Item Ledger Entries
    //             DDR 19/08/2013 DIT-770 #101 Remove double field ItemJnlLine "Cust/Vendor DTax Group Code"
    //             DDR 28/08/2013 DIT-770 #178 Remove DIT-770 #99 #101

    // DITW17.00.02 AT  24/09/2013 DIT-770 #132
    //                             Added Code to Flow Free Reason Code to Item Ledger Entry & Value Entry
    // DITW17.00.02 DDR 01/10/2013 DIT-715 #519 Merge
    // DITW17.00.02 DDR 14/10/2013 DIT-715 #745 Merge
    // DITW17.00.02 DDR 24/10/2013 DIT-715 #813 Merge
    // DITW17.00.02 DDR 24/10/2013 DIT-715 #818 Merge
    // DITW17.00.02 DDR 25/10/2013 DIT-715 #822 Merge
    // DITW17.00.02 RPG 05/11/2013 DIT-770 #239 Added code to flow ILE Source No. to "Item Ledger Entry Source No." field in Value Entry
    // DITW17.00.02 DDR 05/11/2013 DIT-715 #813 Merge
    // DITW17.00.02 DDR 06/11/2013 DIT-715 #801 Merge
    // DITW17.00.02 DDR 08/11/2013 DIT-715 #835 Merge
    // DITW17.00.02 DDR 08/11/2013 DIT-715 #752 Merge
    // DITW17.00.02 DDR 08/11/2013 DIT-715 #752 Merge
    // DITW17.00.02 DDR 13/11/2013 DIT-715 #752 Merge
    // DITW17.00.02 DDR 13/11/2013 DIT-715 #775 Merge
    // DITW17.00.02 DDR 13/11/2013 DIT-770 #230 Added fields "DDiscount Level Position""DDiscount Include Tax","DDiscount Include Deposit"
    //                                            "DDiscount Include Discount"
    // DITW17.10.02 DDR 22/11/2013 DIT-770 #000 Upgrade R2
    //                                          ? SetupTempSplitItemJnlLine
    // DITW17.00.02 DDR 28/11/2013 DIT-715 #830 Merge
    // DITW17.00.02 DDR 20/12/2013 DIT-715 #864 merge
    // DITW17.00.02 DDR 14/01/2014 DIT-715 #761 Merge
    // DITW17.00.03 DDR 17/02/2014 DIT-715 #906 Merge
    // DITW17.00.03 DDR 17/03/2014 DIT-770 #553 OWM Scanning check Nav license
    // DITW17.00.03 DDR 17/03/2014 DIT-715 #911 Merge
    // DITW17.10.03 DDR 15/04/2014 DIT-770 #629 Bugfix function SetupSplitJnlLineSSCC()
    // DITW17.10.03 MSF 15/05/2014 DIT-770 #627 Upgrade W1 Rollup 5 ChangeLog.36281 file 473854
    // DITW17.10.03 MSF 28/05/2014 DIT-770 #715 Upgrade W1 Rollup 6 ChangeLog.W1.36366 file 474255
    // DITW17.10.03 DDR 04/06/2014 DIT-715 #926 Merge
    // DITW17.10.03 DDR 23/06/2014 DIT-715 #920 Merge
    // DITW17.10.05 DDR 05/08/2014 DIT-770 #849 Bugfix undo document (correction field) without SSCC mandatory
    // DITW17.10.05 DDR 19/08/2014 DIT-770 #776 Added Deposit point functionality
    // DITW17.10.05 DDR 25/08/2014 DIT-770 #776 Added field "Valued Quantity (Expected)"
    // DITW17.10.05 DDR 03/09/2014 DIT-770 #675 Added Tax Assembly Orders functionality
    // DITW17.10.05 DDR 29/10/2014 DIT-715 #941 merge
    // DITW17.10.05 MSF 14/11/2014 DIT-715 #812 : BugFix Transfertorder with LOT/SSCC - post shipment: warning on multiple expiration dates but same expiration dates in use
    //                                            Solution inspired by standard Tracking functionality
    // DITW17.10.05 DDR 20/01/2015 DIT-770 #581 Bugfix Calculate Expected Deposit Sales/Purch Amount with Item Charge Quantity Per
    // DITW17.10.05 DDR 29/01/2015 DIT-770 #1123 Bugfix function PostTaxToGL() while posting Prod.Order journals
    // DITW17.10.05 DDR 09/02/2015 DIT-770 #710 Bugfix split transfer internal tax ship/receipt per Item ledger entries (without LOT nos)
    //                                          Bugfix split any internal tax journal line per Lot tracking (merge error)
    // DITW18.00.06 DDR 10/04/2015 DIT-770 #1235 Bugfix (DIT-770 #675) Assembly Order & Adjust Cost Item Entries
    // DITW18.00.06 DDR 28/04/2015 DIT-770 #805 Bugfix License Quality Mgt.
    // DITW18.00.06 MSF 16/02/2015 DIT-770 #1185 Get "Indirect Cost %" From SKU card
    // DITW18.00.06 DDR 27/03/2015 DIT-770 #1317 Bugfix recalculate Internal tax amount with Transfer orders
    // DITW18.00.06 DDR 09/04/2015 DIT-770 #1317 Bugfix wrong sign tax amount (missing tax opposite sign)
    // DITW18.00.06 MSF 15/05/2015 DIT-770 #1237 Prod. order and posting consumption lines gives error when lot tracking without sscc setup
    // DITW18.00.06 MSF 27/05/2015 DIT-770 #805  Bugfix
    // DITW18.00.06 MSF 29/09/2015 DIT-770 #1237 "Lot Number is required for Item X" error message when you post a consumption journal with available stock and item tracking defined.
    //                                            Fix from Cumulative update 5
    // DITW18.00.06 MSF 20/10/2015 DIT-770 #805 Renumber CodeUnit ID  2035095 to 2035150
    // DITW18.00.06 DDR 19/10/2015 DIT-770 #1304 Bugfix Giftbox with "Quantity HL" in item ledger entries
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1667 Bugfix recalculate "Unit Volume HL" to item base unit of measure
    // DITW18.00.06 DDR 23/10/2015 DIT-770 #1395 Added Giftbox Other item posting
    // DITW18.00.06 DDR 04/11/2015 DIT-770 #1304 Added Giftbox "Unit Volume HL" in item ledger entries
    // DITW18.00.06 DDR 04/11/2015 DIT-770 #1667 Bugfix recalculate "Unit Volume HL" to item base unit of measure (output journal)
    // DITW18.00.06A DDR 15/12/2015 DIT-770 #1684 Bugfix Giftbox "Unit Volume HL" with sales/purchases
    // DITW18.00.07 DDR 04/02/2016 DIT-770 #1873 Bugfix SSCC posting with flush Production Orders
    //                                           Bugfix missing internal taxes on Flush consumption journal lines
    // DITW18.00.07 DAT 18/03/2016 DIT-770 #302 Bugfix missing filter when update Quality Test
    // DITW19.00.08 MVN 31/08/2016 BL#11248 (DIT-770 #2162) Merge SSCC changes
    // DITW19.00.08 DDR 17/08/2016 BL#10443 (DIT-770 #1470) New Alcohol Balance functionality
    //                                                      Added fields "Strength Spec. Code","Strength Spec. Value","Vol-Strength Spec. Code";"Vol-Strength Spec. Value"
    //                                                      Various bugfixes about unit volume HL, Scrap, Output & Brewing Quantities
    // DITW19.00.08 DDR 29/09/2016 BL#10443 Added fields "Scrap Code" in item ledger entry & value entry
    //                                      Redesign LossBreakdown posting
    //                                      Added functions SetSkipQualityTestCheck()
    //                                        RegisterLossBreakdownJnl(),InitLossBreakdownEntry(),InsertLossBreakdownEntry(),UpdateLossBreakdownEntry()
    // DITW19.00.08 DDR 17/10/2016 BL#10443 Bugfix RegisterLossBreakdownJnl when no scrap code and/or scrap quantity
    // DITW19.00.08 DDR 20/10/2016 BL#10443 Modified function InsertLossBreakdownEntry()
    //                                      Added transfer "Vol-Strength Spec. Code","Vol-Srength Spec. Value" from tracking specification
    // DITW19.00.08 DDR 28/10/2016 BL#10443 Removed checking Transfer type in function CheckScrapCodeItemTaxGr()
    // DITW19.00.08 DDR 14/11/2016 BL#10443 Bugfix vol-strength calculation in function SetupTempSplitItemJnlLine()
    // DITW19.00.08 DDR 22/11/2016 BL#10443 Modified function InsertConsumpEntry() to recalculate quantity HL, strength values...
    // DITW19.00.08 DDR 02/12/2016 BL#10443 Added "Item Strength Spec. Value" in Item Ledger Entry table
    // DITW19.00.08 DDR 09/12/2016 BL#10443 Bugfix transfer values from Loss breakdown journal
    // DITW19.00.08 AKH 14/12/2016 BL#9745 (DIT-770 #2000) Adjusted code to prevent value entry posting for tax lines in reclassification journal (bin to bin)
    // DITW19.00.08 AKH 15/12/2016 BL#9745 (DIT-770 #2000) Removed redundant code to assign LastItemItemJnlLine
    // DITW19.00.08A VSC 23/12/2016 BL#10443 Set Value on new field 2013724 Reverse
    // DITW19.00.08A VSC 02/01/2017 BL#10443 TEST if Item No on Losses and Item Journal are the same.
    // DITW19.00.08A VSC 03/01/2017 BL#10443 New Function to update "Strength Spec. Value" on  existing reservation entries.
    // DITW19.00.08A VSC 06/01/2017 BL#10443 Post Losses as NegAjustment
    //                                       No Losses on Transfer just the Neg. Ajustment.

    // DITW110.00.08 DDR 02/01/2017 NRQ#0 UPGRADE NAV 2017 CU1
    // DITW110.00.09 YHE 15/03/2017 NRQ#24111 merge DIT2016 W1 R8A
    // DITW110.00.09 DDR 16/03/2017 NRQ#24118 UPGRADE NAV 2017 CU4
    // QXL9.00.001 DAT 23/03/2016 : Quality Management
    // FINXL10.00 AKH 24/03/2017 Upgrade to NAV 2017 CU4
    // DITW110.00.10 AKH 26/05/2017 NRQ#17909 Added "Item Ledger Entry Source Type" in Value entries
    // DITW110.00.10 YHE 08/06/2017 NRQ#26412 UPGRADE NAV 2017 CU7
    // DITW110.00.10 AKH 29/06/2017 NRQ#17909 Adjustments
    // DITW110.00.10 MSF 07/07/2017 NRQ#16224 Added Route planning No. to Item ledger Entries Table
    // DITW110.00.11 SFI 30/08/2017 BL#14417 Added changes for deposit valuation
    // DITW110.00.11 SFI 31/08/2017 BL#30569 Added changes for SKU blocking
    // DITW110.00.11 VSC 26/09/2017 NRQ#30577 Merge - QXL10.01 VSC 26/09/2017 NRQ#38341 : Multisite – Quality tracking per Location
    // DITW110.00.11 VSC 26/09/2017 NRQ#30577 Merge XL NRQ#38341
    // DITW110.00.11 VSC 03/10/2017 NRQ#30577 Merge XL NRQ#38341
    // DITW110.00.11 VSC 30/10/2017 NRQ#42348 Merge XL NRQ#43357
    // DITW110.00.11 MSF 06/11/2017 NRQ#43572 Return registration & Control û part 5
    //                                        Added Field Driver Code
    // DITW110.00.12 AKH 24/01/2018 NRQ#56347 Bugfix "Invoiced Quantity in HL" must be 0 when "Invoiced Quantity" = 0
    // QXL11.01 MTR 13/09/2018 NRQ#24975 : Added function CheckYourReference()
    //                                     Copied "YourReference" field to Item ledger entry
    // DITW114.00.15 DDR 01/06/2023 NRQ#247628 Fix CalcExpectedCost() filters + restore standard sorting key


    // HEI.01 FDD-PRDGAP024 IBM SOICAD01 18.06.2017 #Zone code development without whs advanced mgmt

    // HEI.02 FDDHNK-HeiliteBASE-GAPLOG002 IBM ISYED01 20/06/2017
    //   # added code to update item ledger entry with vendor No. and source type as vendor.
    // HEI.03 FDD-KDD0TC001 IBM HORTOC01 26.09.2017
    // # code added
    // HEI.04 PRDGAP038 IBM HORTO01 16.10.2017 - fill in "Quality status"
    // HEI.05 PRDGAP01 IBM POSTOI01 12.07.2018 -spare part conssumption journal
    //   # new code added to InitItemLedgEntry
    // HEI.06 FDD-BA-SLSGAP01 IBM NASTAA02 19.12.2018 # Counterpoint Interface
    //   # Added code to fill-in Fields "Interface Code" and Reference in function "InitItemLedgEntry"

    // HEI.07 CHG2001666 IBM.AB 31.01.2019
    //   # Code added to fix bug while posting Output and Consumption Journal
    // HEI.09 Defect 4892 IBM BULIMC01 28/11/2019 #error message 'Text017' changed so that it will also display the Item No.
    // HEI.10 IBM MATHEJ01 08.01.2020 - #CHG2037233: Corrections for Expiry Date Generation Functionality
    //   # Modified Function: CheckExpirationDate
    // HEI.12 CHG2065153 IBM KUMARN15 23.06.2020
    //   # Code added in function InitItemLedgEntry and InitValueEntry
    // HEI.13 HT1615 BULIMC01 IBM 16.09.2020 #modify functions "InitItemLedgEntry", "InitValueEntry" and "InsertPhysInventoryEntry"
    //     #2 fields updated: "Zone COde", "Bin code"
    // CHG2104608: DITW111.00.13 ISL 18/12/2018 NRQ#96024 Updated code (Deleted field "Prod. BOM Version Code")
    // HEI.14 CHG2100218 IBM SAXENA03 25.03.2021
    //   # Code written for Sales Post optimizaiton
    //   # Replace FINDSET with FINDSET(FALSE,FALSE) Function ApplyItemLedgEntry()
    //   # Replace FIND('-') with FINDFIRST in Function EnsureValueEntryLoaded()
    // NRQ#177003 DDR 29/03/2021 Add "Tax Due Posting to G/L" to post discount item charge like tax
    // NRQ195669.1 MVN 15/09/2021: merge DITW114.00.15 DDR 08/05/2020 NRQ#145254 Fix/Review (#14417) Deposit Value Amount (missing Item journals; Transfer; Partial Posting Expected Calc.; Undo & Correction)
    // HEI.15 CHG2138230 IBM.AK 27.12.21
    //   # Skip the Expiration Date error for Transfer Shipment and Transfer Receipt
    // HEI.16 CHG2131272 IBM.LS      04.01.2022
    //   # Added Code for Reporting Type
    // HEI.17 CHG2129985 SAHAL01      14.04.2022
    //   # Added Code to skip the error from batch Job
    // HEI.18 CHG2140470 SAHAL01 08.11.2022 # Added Code to assign values in Item Ledger Entry Additional
    // HEI.19 CHG2207590 SAHAL01 06.06.2023 Calculation in the Inventory valuation report - Urgent
    //   # Merged Code with Norriq Fix - DITW114.00.15 DDR 01/06/2023 NRQ#247628
    // HEI.20 CHG2187702 SAHAL01 26.09.2023 Revaluation journal items in error
    //   # Added Code
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine"(var TempSplitItemJnlLine: Record "Item Journal Line"; TempTrackingSpecification: Record "Tracking Specification")

    vAR
        WMSInterfaceSetupL: Record "WMS Interface Setup INT";
    begin
        //HEI.17>>
        IF WMSInterfaceSetupL.GET THEN
            IF WMSInterfaceSetupL."WMS Integration" AND WMSInterfaceSetupL."Activate LogoPak Interface" THEN BEGIN
                IF (TempSplitItemJnlLine."Journal Template Name" = WMSInterfaceSetupL."Prod. Order Output Template") AND
                  (TempSplitItemJnlLine."Journal Batch Name" = WMSInterfaceSetupL."Prod. Order Output Batch") THEN BEGIN
                    IF (TempSplitItemJnlLine."Entry Type" = TempSplitItemJnlLine."Entry Type"::Output) AND (TempSplitItemJnlLine."Expiration Date" <> TempSplitItemJnlLine."Item Expiration Date") THEN
                        TempSplitItemJnlLine."Item Expiration Date" := TempSplitItemJnlLine."Expiration Date";
                END;
            END;
        //HEI.17<<
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInitItemLedgEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnAfterInitItemLedgEntry"(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin

        //HEI.06>>
        NewItemLedgEntry."Interface Code INT" := ItemJournalLine."Interface Code FND";
        NewItemLedgEntry."CP Vendor Invoice No. INT" := ItemJournalLine."CP Vendor Invoice No. FND";
        //HEI.06<<
    end;
    //BC Upgrade GUNREM01 - Codeunit 22 Item Jnl.-Post Line <<

    //-------------------------------->>BC Upgrade SHARMP16 BEGIN>>--------------------------------
    //BC UPG Moved to interface
    //--------------------------------------Bc Upgrade SHARMP16 GAPFitChanges
    // This code commented on Gen Ext with comment moved to Interface extension but not found in interface extension so added.
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Quote to Order", OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert, '', false, false)]
    local procedure OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert(BlanketOrderPurchHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header")
    var

        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        PurchaseHeaderAdditionalQuote: Record "Purchase Header Additional FND";
        UpdateLines: Boolean;
    begin
        //HEI.02>>
        IF PurchaseHeaderAdditional.GET(PurchOrderHeader."Document Type", PurchOrderHeader."No.") THEN BEGIN
            //Rec.CALCFIELDS("House Number FND");  //Commented by HEI.07
            //HEI.07<<
            BlanketOrderPurchHeader.CALCFIELDS("House Number FND", "PQ Approver FND", "LSR Order No. INT");
            PurchaseHeaderAdditional."LSR Order No INT" := BlanketOrderPurchHeader."LSR Order No. INT";
            //HEI.07>>
            PurchaseHeaderAdditional."PQ Approver" := BlanketOrderPurchHeader."PQ Approver FND";
            //HEI.06 >>
            BlanketOrderPurchHeader.CALCFIELDS("License Code FND", "House Number FND");
            PurchaseHeaderAdditional."License Code" := BlanketOrderPurchHeader."License Code FND";
            PurchaseHeaderAdditional."House Number" := BlanketOrderPurchHeader."House Number FND";
            //HEI.06 <<
            //HEI.10>>
            IF PurchaseHeaderAdditionalQuote.GET(BlanketOrderPurchHeader."Document Type", BlanketOrderPurchHeader."No.") THEN
                PurchaseHeaderAdditional."Region Code" := PurchaseHeaderAdditionalQuote."Region Code";
            //HEI.10<<
            PurchaseHeaderAdditional.MODIFY(TRUE);
        END;
        //HEI.02<<

        //HEI.11>>
        //>>HEI.09
        IF PurchaseHeaderAdditional."Import Identifier" = TRUE THEN BEGIN
            //IF GUIALLOWED THEN BEGIN  //HEI.13
            UpdateLines := TRUE
            //END;  //HEI.13
        END;
        //<<HEI.09
        //HEI.11<<
    end;

    //BC UPG Moved to interface
    //Bc Upgrade SHARMP16 GAPFitChanges
    //-------------------------------->>BC Upgrade SHARMP16 END<<--------------------------------
    // BC Upgrade BHARDA11 >> ---This event was originally present in the Navision codeunit 50007 (Purchases-Utils). Since it contains interface-related logic, I am moving it from the general codeunit to the interface extension
    [EventSubscriber(ObjectType::Table, 39, 'OnAfterValidateEvent', 'Blanket Order Line No.', false, false)]
    local procedure T39OnAfterValidateBlanketOrderLineNo(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer);
    var
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        BlanketOrderLine: Record "Purchase Line";
        SRMInterfaceManagement: Codeunit "SRM Interface Management";//BC Upgrade SHARMP16-- Interface code
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    begin
        //HEI.04>>
        if (Rec."Document Type" <> Rec."Document Type"::Quote) and
   (Rec."Document Type" <> Rec."Document Type"::Order) and
   (Rec."Document Type" <> Rec."Document Type"::"Return Order")
then
            exit;

        if (Rec."Blanket Order No." <> xRec."Blanket Order No.") or
           (Rec."Blanket Order Line No." <> xRec."Blanket Order Line No.")
        then begin
            SRMInterfaceManagement.UpdateSRMLineFromBlanketOrderLine(Rec, xRec);//BC Upgrade SHARMP16-- Interface code
            if Rec."Blanket Order Line No." = 0 then
                Rec."Blanket Order No." := ''
            else begin
                PurchLine.SETRANGE("Document Type", Rec."Document Type");
                PurchLine.SETRANGE("Document No.", Rec."Document No.");
                PurchLine.SETFILTER("Line No.", '<>%1', Rec."Line No.");
                PurchLine.SETFILTER("Blanket Order Line No.", '<>%1', 0);
                if PurchLine.findset() then
                    repeat
                        if PurchLine."Blanket Order No." = '' then begin
                            PurchLine.VALIDATE("Blanket Order No.", Rec."Blanket Order No.");
                            PurchLine.MODIFY();
                        end else
                            Rec.TESTFIELD("Blanket Order No.", PurchLine."Blanket Order No.");
                    until PurchLine.NEXT() = 0;
            end;
            PurchHeader.GET(Rec."Document Type", Rec."Document No.");
            if PurchHeader."Blanket Order No. FND" <> Rec."Blanket Order No." then begin
                PurchHeader.VALIDATE("Blanket Order No. FND", Rec."Blanket Order No.");
                PurchHeader.MODIFY();
            end;
            //if PurchHeader."Link Purch. Document No." = '' then begin//BC Upgrade SHARMp16-- Drink-IT field
            PurchPriceCalcMgt.FindPurchLinePrice(PurchHeader, Rec, CurrFieldNo);
            Rec.VALIDATE("Direct Unit Cost");
            //end;
        end;
        //HEI.04<<
    end;
    // BC Upgrade BHARDA11 << ---This event was originally present in the Navision codeunit 50007 (Purchases-Utils). Since it contains interface-related logic, I am moving it from the general codeunit to the interface extension
    // BC Upgrade BHARDA11 >> --These functions and code created in Codeunit 50007 and call in 5813 codeunit in navision
    procedure OnBeforeUndoReceipt(VAR precPurchRcptLine: Record "Purch. Rcpt. Line")
    var
        UndoPurchRecptL: Codeunit "Undo Purchase Receipt Line";
        POSMItemLine: Label 'This is a document with item lines with SRM order, so undo receipt is not be possible';
        POSMConfirmation: Label 'This is a POSM item line. Do you want to continue?';
        POSMWarningMessage: Label 'Undo operation is terminated to respect the warning';
        PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";

        PurchRcptHdr: Record "Purch. Rcpt. Header";
        // PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        SRMInterfaceManagement: Codeunit "SRM Interface Management";
    begin
        //HEI.134>>
        IF precPurchRcptLine.ISTEMPORARY THEN
            EXIT;

        IF (precPurchRcptLine.Type <> precPurchRcptLine.Type::Item) THEN
            EXIT;

        IF PurchRcptHeaderAdditional.GET(precPurchRcptLine."Document No.") THEN
            IF (PurchRcptHeaderAdditional."Shopping Card No. FND" = '') THEN
                EXIT;

        //ERROR(POSMItemLine);  //HEI.135
        IF NOT CONFIRM(POSMConfirmation, FALSE) THEN  //HEI.135
            ERROR(POSMWarningMessage);  //HEI.135
                                        //HEI.134<<
    end;

    procedure OnAfterUndoReceipt(VAR precPurchRcptLine: Record "Purch. Rcpt. Line")
    var
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchRcptHeaderAdditional: Record "Purch. Rcpt. Header Add FND";
        SRMInterfaceManagement: Codeunit "SRM Interface Management";
        ZycusInterfaceManagement: Codeunit "Zycus Interface Management";
        InterfaceEntryHeaderVIP: Record "Interface Entry Header VIP INT";
    begin
        //HEI.139>>
        IF precPurchRcptLine.ISTEMPORARY THEN
            EXIT;

        IF (precPurchRcptLine.Type <> precPurchRcptLine.Type::Item) THEN
            EXIT;

        IF PurchRcptHeaderAdditional.GET(precPurchRcptLine."Document No.") THEN
            //HEI.159>>
            //IF (PurchRcptHeaderAdditional."Shopping Card No. FND" = '') THEN
            //  EXIT;
            IF (PurchRcptHeaderAdditional."Shopping Card No. FND" = '') OR (PurchRcptHeaderAdditional."Zycus Order No. FND" <> '') THEN
                EXIT;
        //HEI.159<<

        //Original Receipt Line
        PurchRcptHdr.GET(precPurchRcptLine."Document No.");

        //HEI.159>>
        //SRMInterfaceManagement.CreateOutboundSRMItemGRCancellation(PurchRcptHdr, precPurchRcptLine."Line No.");
        IF (PurchRcptHeaderAdditional."Shopping Card No. FND" <> '') AND (PurchRcptHeaderAdditional."Zycus Order No. FND" = '') THEN
            SRMInterfaceManagement.CreateOutboundSRMItemGRCancellation(PurchRcptHdr, precPurchRcptLine."Line No.");
        //HEI.159<<

        PurchRcptHdr."POSM GR Confirmed FND" := FALSE;
        PurchRcptHdr.MODIFY;
        //HEI.139<<

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnBeforeOnRun, '', false, false)]
    local procedure OnBeforeOnRun(var PurchRcptLine: Record "Purch. Rcpt. Line"; var IsHandled: Boolean; var SkipTypeCheck: Boolean; var HideDialog: Boolean)
    begin
        OnBeforeUndoReceipt(PurchRcptLine);
        // if not HideDialog then
        //     if not Confirm(Text000) then
        //         exit;

        // PurchRcptLine.Copy(Rec);
        // Code();
        // Rec := PurchRcptLine;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", OnAfterCode, '', false, false)]

    local procedure OnAfterCode(var PurchRcptLine: Record "Purch. Rcpt. Line"; var UndoPostingManagement: Codeunit "Undo Posting Management")
    begin
        OnAfterUndoReceipt(PurchRcptLine);
    end;

    // BC Upgrade BHARDA11 << --These functions and code created in Codeunit 50007 and call in 5813 codeunit in navision
    // BC Upgrade BHARDA11 >> --
    //BC Upgrade SHARMP16 begin>>---------------- Interface code 
    [EventSubscriber(ObjectType::Table, 123, 'OnAfterInsertEvent', '', false, false)]
    local procedure T123OnAfterInsert(var Rec: Record "Purch. Inv. Line"; RunTrigger: Boolean);
    var
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.90>>
        if Rec.ISTEMPORARY then
            exit;
        if (Rec.Quantity = 0) then
            exit;
        if (Rec."No." <> '') and (Rec."Receipt No." <> '') then
            if PurchRcptHeader.GET(Rec."Receipt No.") then
                if PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, PurchRcptHeader."Order No.") then begin
                    //HEI.107>>
                    if (PurchaseHeader."Maximo Requisition No. FND" = '') then
                        exit;
                    //HEI.107<<
                    PurchaseHeader.CALCFIELDS("Maximo Status INT");
                    if (PurchaseHeader."Maximo Status INT" = PurchaseHeader."Maximo Status INT"::PendClose) then
                        exit
                    else begin
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
                        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                        PurchaseLine.SETFILTER("No.", '<>%1', '');
                        PurchaseLine.SETRANGE("Delivery Finalized FND", false);
                        if PurchaseLine.ISEMPTY then begin
                            if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type"::Order, PurchaseHeader."No.") then begin
                                PurchaseHeaderAdditional."Maximo Status INT" := PurchaseHeaderAdditional."Maximo Status INT"::PendClose;
                                PurchaseHeaderAdditional.MODIFY;
                            end;
                            //HEI.91>>
                            //Create Outbound for MAXIMO-PO
                            if (PurchaseHeaderAdditional."Maximo Status INT" = PurchaseHeaderAdditional."Maximo Status INT"::PendClose) then begin
                                CreatePORequest(PurchaseHeader, false, 0);
                            end;
                            //HEI.91<<
                        end
                    end;
                end;
        //HEI.90<<
    end;
    //BC Upgrade SHARMP16 end<<---------------- Interface code 
    //BC Upgrade SHARMP16 begin>>---------Interface code
    local procedure CreatePORequest(PurchaseHeader: Record "Purchase Header"; DeleteRecord: Boolean; LineNoToDelete: Integer);
    var
        InterfaceSetup: Record "Interface Setup INT";
        InterfaceEntryHeaderOut: Record "Interface Entry Header INT";
        InterfaceEntryLineOut: Record "Interface Entry Line INT";
        PurchaseLine: Record "Purchase Line";
        Vendor: Record Vendor;
        Item: Record Item;
        NextEntryNo: Integer;
        lGLAcc: Record "G/L Account";
        lCMGMapping: Record "CMG Mapping FND";
        lText50000: Label 'G/L Account %1 is defined more than once in CMG Mappings!';
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
        grec_GeneralInterfaceSetup: Record "General Interface Setup INT";//BC UPgrade SHARMP16-- Interface Code
        grec_InterfaceSetup: Record "Interface Setup INT";//BC UPgrade SHARMP16-- Interface Code
    begin
        //HEI.91>>
        if not grec_GeneralInterfaceSetup.GET then
            exit;
        GetGenLedgSetup;
        CompanyInformation.GET;

        if not InterfaceSetup.GET(grec_GeneralInterfaceSetup."Maximo PO Interface") then
            exit;
        if not InterfaceSetup.Enabled then
            exit;

        CLEAR(InterfaceEntryHeaderOut);
        InterfaceEntryHeaderOut."Message Creation DateTime" := CURRENTDATETIME;
        InterfaceEntryHeaderOut."Interface Code" := grec_GeneralInterfaceSetup."Maximo PO Interface";
        InterfaceEntryHeaderOut.Direction := InterfaceEntryHeaderOut.Direction::Outbound;
        InterfaceEntryHeaderOut.Status := InterfaceEntryHeaderOut.Status::Pending;
        InterfaceEntryHeaderOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
        InterfaceEntryHeaderOut."External Requisition No." := PurchaseHeader."Maximo Requisition No. FND";
        InterfaceEntryHeaderOut."Source Type" := DATABASE::"Purchase Line";
        InterfaceEntryHeaderOut."Source No." := PurchaseHeader."No.";
        InterfaceEntryHeaderOut."Document Date" := PurchaseHeader."Document Date";
        if Vendor.GET(PurchaseHeader."Buy-from Vendor No.") then;
        InterfaceEntryHeaderOut."Buy-from Vendor No." := Vendor."No." + '-' + CompanyInformation."Legal Entity Code FND";
        if PurchaseHeader."Currency Code" <> '' then
            InterfaceEntryHeaderOut."Currency Code" := PurchaseHeader."Currency Code"
        else
            InterfaceEntryHeaderOut."Currency Code" := GeneralLedgerSetup."LCY Code";
        PurchaseHeader.CALCFIELDS(Amount, "Amount Including VAT");
        InterfaceEntryHeaderOut.Amount := PurchaseHeader.Amount;
        InterfaceEntryHeaderOut."VAT Amount" := PurchaseHeader."Amount Including VAT" - PurchaseHeader.Amount;
        InterfaceEntryHeaderOut."Amount Including VAT" := PurchaseHeader."Amount Including VAT";
        InterfaceEntryHeaderOut."Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";
        InterfaceEntryHeaderOut."Expected Receipt Date" := PurchaseHeader."Expected Receipt Date";
        InterfaceEntryHeaderOut."Source Status" := PurchaseHeader.Status.AsInteger();
        InterfaceEntryHeaderOut."Your Reference" := PurchaseHeader."Your Reference";
        if PurchaseHeaderAdditional.GET(PurchaseHeader."Document Type", PurchaseHeader."No.") then begin
            InterfaceEntryHeaderOut."Simulation Done" := PurchaseHeaderAdditional."Import Identifier";
            InterfaceEntryHeaderOut."Location Code" := PurchaseHeader."Shipment Method Code";
            InterfaceEntryHeaderOut."Maximo Status" := InterfaceEntryHeaderOut."Maximo Status"::PendClose;
        end;
        InterfaceEntryHeaderOut."Global No." := PurchaseHeader."Location Code";
        if LineNoToDelete = 0 then
            InterfaceEntryHeaderOut."Delete Record" := DeleteRecord;
        InterfaceEntryHeaderOut.INSERT(true);

        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        if LineNoToDelete <> 0 then
            PurchaseLine.SETRANGE("Line No.", LineNoToDelete);
        if PurchaseLine.findset then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                NextEntryNo := NextEntryNo + 1;
                InterfaceEntryLineOut."Entry No." := NextEntryNo;
                InterfaceEntryLineOut."Buy-from Vendor No." := PurchaseLine."Buy-from Vendor No." + '-' + CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut."Source Line No." := PurchaseLine."Line No.";
                InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::Item;
                Item.GET(PurchaseLine."No.");
                InterfaceEntryLineOut."No." := Item."No." + '-' + CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut.Description := PurchaseLine.Description;
                InterfaceEntryLineOut."Description 2" := PurchaseLine."Description 2";
                InterfaceEntryLineOut."Location Code" := PurchaseLine."Location Code";
                InterfaceEntryLineOut.Quantity := PurchaseLine.Quantity;
                InterfaceEntryLineOut."Currency Code" := InterfaceEntryHeaderOut."Currency Code";
                InterfaceEntryLineOut."Unit Amount" := PurchaseLine."Direct Unit Cost";
                InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(PurchaseLine."Unit of Measure Code");
                InterfaceEntryLineOut."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
                InterfaceEntryLineOut."VAT %" := PurchaseLine."VAT %";
                InterfaceEntryLineOut."Document Date" := PurchaseHeader."Document Date";
                InterfaceEntryLineOut."Requested Receipt Date" := PurchaseLine."Requested Receipt Date";
                InterfaceEntryLineOut."Expected Receipt Date" := PurchaseLine."Expected Receipt Date";
                InterfaceEntryLineOut."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
                InterfaceEntryLineOut."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
                InterfaceEntryLineOut."External Requisition No." := PurchaseLine."Maximo Requisition No. FND";
                InterfaceEntryLineOut."External Requisition Line No." := PurchaseLine."Maximo Requis. Line No. FND";
                InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut."Delete Record" := DeleteRecord;
                InterfaceEntryLineOut."Zone Code" := PurchaseLine."Zone Code FND";
                InterfaceEntryLineOut."Over Percent" := PurchaseLine."Tolerance Received Over % FND";
                InterfaceEntryLineOut."Under Percent" := PurchaseLine."Tolerance Received Under % FND";
                InterfaceEntryLineOut."Machine Reference No." := PurchaseLine."Machine Reference Number FND";
                PurchaseLine.CALCFIELDS("Import Identifier FND");
                InterfaceEntryLineOut.Cancelled := PurchaseLine."Import Identifier FND";
                InterfaceEntryLineOut.INSERT;
            until PurchaseLine.NEXT = 0;

        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::"G/L Account");
        if LineNoToDelete <> 0 then
            PurchaseLine.SETRANGE("Line No.", LineNoToDelete);
        if PurchaseLine.findset then
            repeat
                CLEAR(InterfaceEntryLineOut);
                InterfaceEntryLineOut."Header Entry No." := InterfaceEntryHeaderOut."Entry No.";
                NextEntryNo := NextEntryNo + 1;
                InterfaceEntryLineOut."Entry No." := NextEntryNo;
                InterfaceEntryLineOut."Buy-from Vendor No." := PurchaseLine."Buy-from Vendor No." + '-' + CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut."Source Line No." := PurchaseLine."Line No.";
                InterfaceEntryLineOut.Type := InterfaceEntryLineOut.Type::"G/L Account";
                lGLAcc.GET(PurchaseLine."No.");
                lCMGMapping.RESET;
                lCMGMapping.SETRANGE("G/L Account", lGLAcc."No.");
                if lCMGMapping.FINDFIRST then begin
                    if lCMGMapping.COUNT > 1 then
                        ERROR(lText50000, lCMGMapping."G/L Account");
                    InterfaceEntryLineOut."No." := lCMGMapping."Dimension Value Code" + '-' + CompanyInformation."Legal Entity Code FND";
                end;
                InterfaceEntryLineOut.Description := PurchaseLine.Description;
                InterfaceEntryLineOut."Description 2" := PurchaseLine."Description 2";
                InterfaceEntryLineOut."Location Code" := PurchaseLine."Location Code";
                InterfaceEntryLineOut.Quantity := PurchaseLine.Quantity;
                InterfaceEntryLineOut."Currency Code" := InterfaceEntryHeaderOut."Currency Code";
                InterfaceEntryLineOut."Unit Amount" := PurchaseLine."Direct Unit Cost";
                InterfaceEntryLineOut."Unit of Measure Code" := InterfaceFrameworkMgt.GetUnitOfMeasureCommercialISOCode(PurchaseLine."Unit of Measure Code");
                InterfaceEntryLineOut."Qty. per Unit of Measure" := PurchaseLine."Qty. per Unit of Measure";
                InterfaceEntryLineOut."VAT %" := PurchaseLine."VAT %";
                InterfaceEntryLineOut."Document Date" := PurchaseHeader."Document Date";
                InterfaceEntryLineOut."Requested Receipt Date" := PurchaseLine."Requested Receipt Date";
                InterfaceEntryLineOut."Expected Receipt Date" := PurchaseLine."Expected Receipt Date";
                InterfaceEntryLineOut."Shortcut Dimension 1 Code" := PurchaseLine."Shortcut Dimension 1 Code";
                InterfaceEntryLineOut."Shortcut Dimension 2 Code" := PurchaseLine."Shortcut Dimension 2 Code";
                InterfaceEntryLineOut."External Requisition No." := PurchaseLine."Maximo Requisition No. FND";
                InterfaceEntryLineOut."External Requisition Line No." := PurchaseLine."Maximo Requis. Line No. FND";
                InterfaceEntryLineOut."Legal Entity" := CompanyInformation."Legal Entity Code FND";
                InterfaceEntryLineOut."Delete Record" := DeleteRecord;
                InterfaceEntryLineOut."Zone Code" := PurchaseLine."Zone Code FND";
                InterfaceEntryLineOut."Over Percent" := PurchaseLine."Tolerance Received Over % FND";
                InterfaceEntryLineOut."Under Percent" := PurchaseLine."Tolerance Received Under % FND";
                InterfaceEntryLineOut."Machine Reference No." := PurchaseLine."Machine Reference Number FND";
                InterfaceEntryLineOut.INSERT;
            until PurchaseLine.NEXT = 0;
        //HEI.91<<
    end;

    local procedure GetGenLedgSetup();
    begin
        //>> HEI.53
        if not GenLedgSetupGot then
            GeneralLedgerSetup.GET();
        GenLedgSetupGot := true;
        //<< HEI.53
    end;
    //BC Upgrade SHARMP16 end<<---------Interface code
    // BC Upgrade BHARDA11 << --
    var
        CompanyInformation: Record "Company Information";
        GenLedgSetupGot: Boolean;
        GeneralLedgerSetup: Record "General Ledger Setup";
        InterfaceFrameworkMgt: Codeunit "Interface Framework Mgt.";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", OnAfterInsertAllPurchOrderLines, '', false, false)]
    local procedure OnAfterInsertAllPurchOrderLines(var PurchOrderLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    var
        PurchaseHeaderAdditional: Record "Purchase Header Additional FND";
    begin
        //HEI.02

        IF PurchaseHeaderAdditional.GET(PurchQuoteHeader."Document Type", PurchQuoteHeader."No.") THEN BEGIN
            //Rec.CALCFIELDS("House Number FND");  //Commented by HEI.07
            PurchQuoteHeader.CALCFIELDS("House Number FND", "PQ Approver FND", "LSR Order No. INT");
            PurchaseHeaderAdditional."LSR Order No INT" := PurchQuoteHeader."LSR Order No. INT";
            PurchaseHeaderAdditional.MODIFY(TRUE);
        END;
        //HEI.02
    end;
    //BC Upgrade SHARMP16-- Interface Code begin>>
    [EventSubscriber(ObjectType::Table, 7316, 'OnBeforeInsertEvent', '', false, false)]
    local procedure T7316LSROnBeforeInsert(var Rec: Record "Warehouse Receipt Header"; RunTrigger: Boolean);
    var
        LSRInterfaceSetup: Record "LSR Interface Setup INT"; //BC Upgrade SHARMP16-- Interface Code
        PurchOrder: Record "Purchase Header";
        LSRText001: Label 'The warehouse receipt must be created in LS Retail.';
    begin

        //HEI.57<<
        if GUIALLOWED then
            if LSRInterfaceSetup.GET() and LSRInterfaceSetup."Enable LSR Interface" then
                if Rec."Source Document Type FND" = Rec."Source Document Type FND"::"Purchase Order" then
                    if PurchOrder.GET(PurchOrder."Document Type"::Order, Rec."Source No. FND") then begin
                        PurchOrder.CALCFIELDS("LSR Order No. INT");
                        if (PurchOrder."LSR Order No. INT" <> '') then
                            ERROR(LSRText001);
                    end;
        //HEI.57>>
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterValidateEvent', 'Blanket Order No. FND', false, false)]
    local procedure T38OnAfterValidateBlanketOrderNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer);
    var
        PurchaseLine: Record "Purchase Line";
        SRMInterfaceManagement: Codeunit "SRM Interface Management";//BC Upgrade SHARMP16-- Interface code
    begin
        //HEI.04>>
        if (Rec."Document Type" <> Rec."Document Type"::Quote) and
   (Rec."Document Type" <> Rec."Document Type"::Order) and
   (Rec."Document Type" <> Rec."Document Type"::"Return Order")
then
            exit;

        if Rec."Blanket Order No. FND" <> xRec."Blanket Order No. FND" then;
        SRMInterfaceManagement.UpdateSRMHeaderFromBlanketOrder(Rec);//BC Upgrade SHARMP16-- Interface code
        //HEI.04<<
    end;

    // BC Upgrade BHARDA11 << --These functions and code created in Codeunit 50007 and call in 5813 codeunit in navision

    // BC Upgrade SHUKLP03 >> Added code for PowerApps interface

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeCheckUserAsApprovalAdministrator, '', false, false)]
    local procedure OnBeforeCheckUserAsApprovalAdministratorLocal(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean)
    var
        PowerAppsSetup: Record "PowerApps Interface Setup INT";
    begin
        If PowerAppsSetup.get() then
            IF PowerAppsSetup."Enable PowerApps Integration" THEN
                IsHandled := TRUE;

    end;
    // BC Upgrade SHUKLP03 << Added code for PowerApps interface
    // BC Upgrade BHARDA11 >>
    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", OnBeforeWhseReceiptHeaderInsert, '', false, false)]
    local procedure OnBeforeWhseReceiptHeaderInsert(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; var WarehouseRequest: Record "Warehouse Request")
    begin
        WarehouseReceiptHeader."Source No. FND" := WarehouseRequest."Source No.";
    end;
    // BC Upgrade BHARAD11 <<

}
