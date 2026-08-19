codeunit 58124 "Adj Cost and Post to GL"
{
    // version HEI.04

    // HEI.01 CHG2098896 IBM POENAB02 18.02.2021 Skip/step over error messages during running an batch job (adjust cost and post cost to G/L)
    //   # Object created
    // HEI.02 CHG2103832 IBM POENAB02 25.03.2021 Skip/step over error messages during running an batch job: send motification by mail
    //   # modified function OnRun
    // HEI.03 CHG2207812 IBM PRASAA03  12.06.2023 Error message Handling for more than 250 character
    //   # modified function InsertLog
    // HEI.04 CHG2197537 SAHAL01 14.06.2023 Cost ADJ Entries Corrections-Global
    //   # Added Code to skip the Items where the Inventory Value Zero as Yes

    //Bc Upgrade YADAVM09 old id is-50153.
    //Bc Upgrade YADAVM09 Email code Changes as per BC Objects.
    //Bc Upgrade YADAVM09 2c user profiles objects blocked.


    trigger OnRun();
    var
        //SMTPMailSetup: Record "SMTP Mail Setup";//Bc Upgrade YADAVM09 Blocked due to object change in Bc<<
        //SMTPMail: Codeunit "SMTP Mail";//Bc Upgrade YADAVM09 Blocked due to object change in Bc<<
        Email: Codeunit Email; // BC Upgrade YADAVM09 Added<<
        SMTPMail: Codeunit "Email Message";// BC Upgrade YADAVM09 Added<<
        SenderEmail: Text;
        CompanyInformation: Record "Company Information";
        InventorySetup: Record "Inventory Setup";
    begin
        tAdjCostandPosttoGL.RESET;
        if tAdjCostandPosttoGL.FINDLAST then
            EntryNoAdjCostandPosttoGL := tAdjCostandPosttoGL."Entry No." + 1
        else
            EntryNoAdjCostandPosttoGL := 1;

        tAdjCostandPosttoGLArch.RESET;
        if tAdjCostandPosttoGLArch.FINDLAST then
            EntryNoAdjCostandPosttoGLArch := tAdjCostandPosttoGLArch."Entry No." + 1
        else
            EntryNoAdjCostandPosttoGLArch := 1;

        tAdjCostandPosttoGL.RESET;
        //HEI.04>>
        //IF tAdjCostandPosttoGL.FINDFIRST THEN
        if tAdjCostandPosttoGL.FINDSET(false) then
            //HEI.04<<
            repeat
                //HEI.04>>
                tAdjCostandPosttoGLArch.INIT;
                //HEI.04<<
                tAdjCostandPosttoGLArch.TRANSFERFIELDS(tAdjCostandPosttoGL);
                tAdjCostandPosttoGLArch."Entry No." := EntryNoAdjCostandPosttoGLArch;
                tAdjCostandPosttoGLArch.INSERT;
                EntryNoAdjCostandPosttoGLArch += 1;
            until tAdjCostandPosttoGL.NEXT = 0;

        tAdjCostandPosttoGL.RESET;
        tAdjCostandPosttoGL.DELETEALL;

        COMMIT;
        tAdjCostandPosttoGL.RESET;
        EntryNoAdjCostandPosttoGL := 1;

        //HEI.04>>
        Item.RESET;
        Item.SETCURRENTKEY("Inventory Value Zero", "No.");
        Item.SETRANGE("Inventory Value Zero", false);
        //IF Item.FINDFIRST THEN
        if Item.FINDSET(false) then
            //HEI.04<<
            repeat
                CLEARLASTERROR;
                if AdjCostandPosttoGL.RUN(Item) then;
                if GETLASTERRORTEXT <> '' then begin
                    InsertLog(EntryNoAdjCostandPosttoGL, Item."No.", GETLASTERRORTEXT);
                    EntryNoAdjCostandPosttoGL += 1;
                end;
                COMMIT;
            until Item.NEXT = 0;


        for i := 1 to 5 do begin
            tAdjCostandPosttoGL.RESET;
            tAdjCostandPosttoGL.SETRANGE("Error Message", 'Error code: 85132273');
            //HEI.04>>
            //IF tAdjCostandPosttoGL.FINDSET THEN
            if tAdjCostandPosttoGL.FINDSET(false) then
                //HEI.04<<
                repeat
                    CLEARLASTERROR;
                    GItem.GET(tAdjCostandPosttoGL."Item No.");
                    if AdjCostandPosttoGL.RUN(GItem) then;
                    if GETLASTERRORTEXT = '' then begin
                        //HEI.04>>
                        tAdjCostandPosttoGLTMP.INIT;
                        //HEI.04<<
                        tAdjCostandPosttoGLTMP.TRANSFERFIELDS(tAdjCostandPosttoGL);
                        tAdjCostandPosttoGLTMP.INSERT;
                    end;
                until tAdjCostandPosttoGL.NEXT = 0;

            tAdjCostandPosttoGLTMP.RESET;
            tAdjCostandPosttoGL.RESET;
            //HEI.04>>
            //IF tAdjCostandPosttoGLTMP.FINDFIRST THEN
            if tAdjCostandPosttoGLTMP.FINDSET(false) then
                //HEI.04<<
                repeat
                    if tAdjCostandPosttoGL.GET(tAdjCostandPosttoGLTMP."Entry No.") then
                        tAdjCostandPosttoGL.DELETE;
                until tAdjCostandPosttoGLTMP.NEXT = 0;

            tAdjCostandPosttoGLTMP.DELETEALL;
            COMMIT;
        end;
        //HEI.02>>
        // InventorySetup.GET;
        // if (InventorySetup."Adj. Cost. Error Notif. Email" <> '') then begin
        //     CompanyInformation.GET;
        //     ListOfEmailAddresses := '';
        //     "2CUserProfile".RESET;
        //     "2CUserProfile".SETFILTER("User Profile", InventorySetup."Adj. Cost. Error Notif. Email");
        //     if "2CUserProfile".FINDFIRST then
        //         repeat
        //             "2CUserperUserProfile".RESET;
        //             "2CUserperUserProfile".SETRANGE("User Profile", "2CUserProfile"."User Profile");
        //             if "2CUserperUserProfile".FINDFIRST then
        //                 repeat
        //                     if UserSetup.GET("2CUserperUserProfile"."User Name") then
        //                         if UserSetup."E-Mail" <> '' then
        //                             ListOfEmailAddresses += UserSetup."E-Mail" + ';';
        //                 until "2CUserperUserProfile".NEXT = 0;
        //         until "2CUserProfile".NEXT = 0;

        if ListOfEmailAddresses <> '' then
            ListOfEmailAddresses2 := COPYSTR(ListOfEmailAddresses, 1, STRLEN(ListOfEmailAddresses) - 1);

        //Bc Upgrade YADAVM09>>
        // if SMTPMailSetup."User ID" <> '' then
        //     SenderEmail := SMTPMailSetup."User ID"
        // else begin
        //     CompanyInformation.GET;
        //     SenderEmail := CompanyInformation."E-Mail";
        // end;
        //Bc Upgrade YADAVM09<<

        tAdjCostandPosttoGL.RESET;
        if ListOfEmailAddresses2 <> '' then
            if tAdjCostandPosttoGL.FINDFIRST then begin
                //     SMTPMail.CreateMessage('', SenderEmail, ListOfEmailAddresses2,
                //                            Text50000, STRSUBSTNO(Text50005, CompanyInformation.Name, CompanyInformation."Legal Entity Code"), true);//Bc Upgrade YADAVM09<<

                SMTPMail.Create(ListOfEmailAddresses2,
                                           Text50000, STRSUBSTNO(Text50005, CompanyInformation.Name, CompanyInformation."Legal Entity Code FND"), true);
                //SMTPMail.AppendBody('<br><br>');//Bc Upgrade YADAVM09
                SMTPMail.AppendToBody('<br><br>');
                SMTPMail.AppendToBody(Text50001);
                repeat
                    SMTPMail.AppendToBody('<br><b> ' + Text50002 + '</b>' + tAdjCostandPosttoGL."Item No." + ' ' + '<b>' +
                      Text50003 + '</b>' + tAdjCostandPosttoGL."Error Message");
                until tAdjCostandPosttoGL.NEXT = 0;
                SMTPMail.AppendToBody('<br><br><br>');
                //SMTPMail.Send;
                Email.Send(SMTPMail, Enum::"Email Scenario"::Default);

            end
            else begin
                // SMTPMail.CreateMessage('', SenderEmail, ListOfEmailAddresses2,
                //STRSUBSTNO(Text50004, CompanyInformation.Name, CompanyInformation."Legal Entity Code"), STRSUBSTNO(Text50004, CompanyInformation.Name, CompanyInformation."Legal Entity Code"), true);//Bc Upgrade YADAVM09<<
                // SMTPMail.AppendBody('<br><br><br>');//Bc Upgrade YADAVM09<<
                // SMTPMail.Send;//Bc Upgrade YADAVM09<<
                SMTPMail.Create(ListOfEmailAddresses2,
                                        STRSUBSTNO(Text50004, CompanyInformation.Name, CompanyInformation."Legal Entity Code FND"), STRSUBSTNO(Text50004, CompanyInformation.Name, CompanyInformation."Legal Entity Code FND"), true);//Bc Upgrade YADAVM09<<
                SMTPMail.AppendToBody('<br><br><br>');//Bc Upgrade YADAVM09<<
                Email.Send(SMTPMail, Enum::"Email Scenario"::Default);//Bc Upgrade YADAVM09<<
            end;
    end;
    //HEI.02<<


    var
        AdjustCostItemEntriesHL: Report "Adjust Cost - Item Entries HL";
        Item: Record Item;
        RunOk: Boolean;
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        GenJournalLine: Record "Gen. Journal Line";
        AdjCostandPosttoGL: Codeunit "Adj Cost and Post to G/L";
        tAdjCostandPosttoGL: Record "Adj Cost and Post to G/L FND";
        tAdjCostandPosttoGLArch: Record "Adj Cost Post to G/L Arch. FND";
        EntryNoAdjCostandPosttoGL: Integer;
        EntryNoAdjCostandPosttoGLArch: Integer;
        i: Integer;
        GItem: Record Item;
        tAdjCostandPosttoGLTMP: Record "Adj Cost and Post to G/L FND" temporary;
        Text50000: Label 'Errors while running Adjust Cost!';
        Text50001: Label 'Please see details below:';
        Text50002: Label 'Item No.:';
        Text50003: Label '"Error: "';
        //"2CUserProfile": Record "2C User Profile"; //BC Upgrade YADAVM09 blocked.
        // "2CNavisionUser": Record "2C Navision User"; //BC Upgrade YADAVM09 blocked.
        //"2CUserperUserProfile": Record "2C User per User Profile"; //BC Upgrade YADAVM09 blocked.
        UserSetup: Record "User Setup";
        ListOfEmailAddresses: Text;
        CompanyInformation: Record "Company Information";
        ListOfEmailAddresses2: Text;
        Text50004: Label 'No errors found while running Adjust Cost for %1 %2!';
        Text50005: Label 'Some errors occured while running the <b>Adjust Cost</b> procedure for <b>%1 %2</b>.<br>Some items were not adjusted. Please solve the errors manually!';

    local procedure InsertLog(pEntryNo: Integer; pItemNo: Code[20]; pErrorMessage: Text);
    var
        lAdjCostandPosttoGL: Record "Adj Cost and Post to G/L FND";
    begin
        lAdjCostandPosttoGL.RESET;
        lAdjCostandPosttoGL."Entry No." := pEntryNo;
        lAdjCostandPosttoGL."Item No." := pItemNo;
        //HEI.03>>
        if STRLEN(pErrorMessage) < 251 then
            lAdjCostandPosttoGL."Error Message" := pErrorMessage
        else begin
            lAdjCostandPosttoGL."Error Message" := COPYSTR(pErrorMessage, 1, 250);
            if STRLEN(pErrorMessage) < 501 then
                lAdjCostandPosttoGL."Error Message 2" := COPYSTR(pErrorMessage, 251, STRLEN(pErrorMessage) - 250)
            else
                lAdjCostandPosttoGL."Error Message 2" := COPYSTR(pErrorMessage, 251, 250)
        end;
        //HEI.03<<
        lAdjCostandPosttoGL.Date := TODAY;
        lAdjCostandPosttoGL.Time := TIME;
        lAdjCostandPosttoGL.INSERT;
    end;
}

