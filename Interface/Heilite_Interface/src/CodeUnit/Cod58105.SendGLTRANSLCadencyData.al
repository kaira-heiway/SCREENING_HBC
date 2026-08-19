codeunit 58105 "Send GL/TRAN/SL Cadency Data"
{
    // version HEI.01

    // HEI.01 CHG2262655 SAHAL01 09.12.2024 Automatic data export for control purposes
    //   # Created New Codeunit: 50230 - Send GL/TRAN/SL Cadency Data
    //   # Created New Functions - ValidateInterfaceSetup_Trintech
    //                           - MakeExcelDataHeaderForGLBAL_Trintech
    //                           - MakeExcelDataBodyForGLBAL_Trintech
    //                           - MakeExcelDataHeaderForGLTRAN_Trintech
    //                           - MakeExcelDataBodyForGLTRAN_Trintech
    //                           - MakeExcelDataHeaderForSLBAL_Trintech
    //                           - MakeExcelDataBodyForSLBAL_Trintech
    //   # Added Code

    // BC Upgrade POENAB02: Original (HeiLite) codeunit id 50230

    // BC Upgrade PATELP08>>
    // Changed name of table from "Cadency Running Calendar" to "Cadency Running Calendar FND"
    // BC Upgrade PATELP08<<

    // BC Upgrade MISHRS14 >>
    // Changed table name to "Cadency Data FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    trigger OnRun();
    var

        // CadencyRunningCalendarL: Record "Cadency Running Calendar";
        CadencyDataL: Record "Cadency Data FND";
        CadencyDataForGLBALL: Record "Cadency Data FND";
        CadencyDataForGLTRANL: Record "Cadency Data FND";
        CadencyDataForSLBALL: Record "Cadency Data FND";
        // CadencyRunningCalendarL1: Record "Cadency Running Calendar";

        CadencyRunningCalendarL: Record "Cadency Running Calendar FND";
        // CadencyDataL: Record "Cadency Data";
        // CadencyDataForGLBALL: Record "Cadency Data";
        // CadencyDataForGLTRANL: Record "Cadency Data";
        // CadencyDataForSLBALL: Record "Cadency Data";
        CadencyRunningCalendarL1: Record "Cadency Running Calendar FND";

        EmailMessageL: Codeunit "Email Message";
        EmailIDL: Text[1024];
        IsTodayL: Boolean;
        SendEmailForMDL: Boolean;
        SendEmailForADL: Boolean;
        SendEmailForWD2L: Boolean;
        SendEmailForWD6L: Boolean;
        //SMTPMailSetupL: Record "SMTP Mail Setup"; // BC Upgrade POENAB02
        LoopCountForGLBALL: Integer;
        LoopCountForGLTRANL: Integer;
        LoopCountForSLBALL: Integer;
        LoopCountL: Integer;
        EmailInitiatedL: Boolean;
        iL: Integer;
        jL: Integer;
        //SMTPL: Codeunit "SMTP Mail"; // BC Upgrade POENAB02
        EmailSentL: Boolean;
        EmailSubjectL: Text;
    begin
        //HEI.01>>
        Clear(EmailSendDate);
        Clear(SenderEmail);
        TrintechInterfaceSetup.Get();
        if not TrintechInterfaceSetup."Enabled E-Mail Notification" then
            exit;
        GeneralInterfaceSetup.Get();
        TrintechInterfaceSetup.TestField(GLBAL);
        ValidateInterfaceSetup_Trintech(TrintechInterfaceSetup.GLBAL);
        TrintechInterfaceSetup.TestField(GLTRAN);
        ValidateInterfaceSetup_Trintech(TrintechInterfaceSetup.GLTRAN);
        TrintechInterfaceSetup.TestField(SLBAL);
        ValidateInterfaceSetup_Trintech(TrintechInterfaceSetup.SLBAL);
        TrintechInterfaceSetup.TestField("Cadency Base Calendar Code");
        TrintechInterfaceSetup.TestField("E-Mail List 1");
        EmailIDL := TrintechInterfaceSetup."E-Mail List 1";
        if TrintechInterfaceSetup."E-Mail List 2" <> '' then
            EmailIDL := EmailIDL + ';' + TrintechInterfaceSetup."E-Mail List 2";
        if TrintechInterfaceSetup."E-Mail List 3" <> '' then
            EmailIDL := EmailIDL + ';' + TrintechInterfaceSetup."E-Mail List 3";
        if TrintechInterfaceSetup."E-Mail List 4" <> '' then
            EmailIDL := EmailIDL + ';' + TrintechInterfaceSetup."E-Mail List 4";

        CadencyRunningCalendarL.SetCurrentKey("Cadency Base Calendar Code", "Manual Run Date", "Manual Run Date (E-Mail Sent)");
        CadencyRunningCalendarL.SetRange("Cadency Base Calendar Code", TrintechInterfaceSetup."Cadency Base Calendar Code");
        CadencyRunningCalendarL.FindFirst();
        CadencyRunningCalendarL.SetFilter("Manual Run Date", '<>%1', 0D);
        CadencyRunningCalendarL.SetRange("Manual Run Date (E-Mail Sent)", false);
        if CadencyRunningCalendarL.FindFirst() then begin
            EmailSendDate := CadencyRunningCalendarL."Manual Run Date";
            SendEmailForMDL := true;
        end;

        if not SendEmailForMDL then begin
            CadencyRunningCalendarL.Reset();
            CadencyRunningCalendarL.SetCurrentKey("Cadency Base Calendar Code", "Additional Run Date", "Addnl. Run Date (E-Mail Sent)");
            CadencyRunningCalendarL.SetRange("Cadency Base Calendar Code", TrintechInterfaceSetup."Cadency Base Calendar Code");
            CadencyRunningCalendarL.SetFilter("Additional Run Date", '<>%1', 0D);
            CadencyRunningCalendarL.SetRange("Addnl. Run Date (E-Mail Sent)", false);
            if CadencyRunningCalendarL.FindFirst() then begin
                EmailSendDate := CadencyRunningCalendarL."Additional Run Date";
                SendEmailForADL := true;
            end;
        end;

        if EmailSendDate = 0D then begin
            EmailSendDate := Today();
            if TrintechInterfaceSetup."Last GLBAL Completion Date" <> 0D then begin
                if TrintechInterfaceSetup."Last GLBAL Completion Date" = EmailSendDate then
                    IsTodayL := true;
                //ELSE
                //IsTodayL := FALSE;
            end;
            if TrintechInterfaceSetup."Last GLTRAN Completion Date" <> 0D then begin
                if TrintechInterfaceSetup."Last GLTRAN Completion Date" = EmailSendDate then
                    IsTodayL := true;
                //ELSE
                //IsTodayL := FALSE;
            end;
            if TrintechInterfaceSetup."Last SLBAL Completion Date" <> 0D then begin
                if TrintechInterfaceSetup."Last SLBAL Completion Date" = EmailSendDate then
                    IsTodayL := true;
                //ELSE
                //IsTodayL := FALSE;
            end;
        end;

        if not (SendEmailForMDL or SendEmailForADL or IsTodayL) then
            exit;

        if not (SendEmailForMDL or SendEmailForADL) and IsTodayL then begin
            CadencyRunningCalendarL.Reset();
            CadencyRunningCalendarL.SetCurrentKey("Cadency Base Calendar Code", "Working Day-2 (Auto Run Date)", "Working Day-2 (E-Mail Sent)");
            CadencyRunningCalendarL.SetRange("Cadency Base Calendar Code", TrintechInterfaceSetup."Cadency Base Calendar Code");
            CadencyRunningCalendarL.SetRange("Working Day-2 (Auto Run Date)", EmailSendDate);
            CadencyRunningCalendarL.SetRange("Working Day-2 (E-Mail Sent)", false);
            if CadencyRunningCalendarL.FindFirst() then begin
                SendEmailForWD2L := true;
            end;
        end;

        if not (SendEmailForMDL or SendEmailForADL or SendEmailForWD2L) and IsTodayL then begin
            CadencyRunningCalendarL.Reset();
            CadencyRunningCalendarL.SetCurrentKey("Cadency Base Calendar Code", "Working Day-6 (Auto Run Date)", "Working Day-6 (E-Mail Sent)");
            CadencyRunningCalendarL.SetRange("Cadency Base Calendar Code", TrintechInterfaceSetup."Cadency Base Calendar Code");
            CadencyRunningCalendarL.SetRange("Working Day-6 (Auto Run Date)", EmailSendDate);
            CadencyRunningCalendarL.SetRange("Working Day-6 (E-Mail Sent)", false);
            if CadencyRunningCalendarL.FindFirst() then begin
                SendEmailForWD6L := true;
            end;
        end;

        if not (SendEmailForMDL or SendEmailForADL or SendEmailForWD2L or SendEmailForWD6L) then
            exit;

        CompInfo.Get();
        // BC Upgrade POENAB02 >>
        // SMTPMailSetupL.GET;
        // if SMTPMailSetupL."User ID" <> '' then
        //     SenderEmail := SMTPMailSetupL."User ID"
        // else
        //     SenderEmail := CompInfo."E-Mail";
        if EmailScenario.GetEmailAccount(Enum::"Email Scenario"::Default, EmailAccount) then
            SenderEmail := EmailAccount."Email Address"
        else
            SenderEmail := CompInfo."E-Mail";
        // BC Upgrade POENAB02 << 
        if SenderEmail = '' then
            Error(Text001);

        if CadencyDataL.FindSet(true) then begin
            CadencyDataL.ModifyAll("E-Mail For GLBAL", false, false);
            CadencyDataL.ModifyAll("E-Mail For GLTRAN", false, false);
            CadencyDataL.ModifyAll("E-Mail For SLBAL", false, false);
        end;

        CadencyDataForGLBALL.SetCurrentKey("File Type");
        CadencyDataForGLBALL.SetRange("File Type", CadencyDataForGLBALL."File Type"::GLBAL);
        if TrintechInterfaceSetup."Max No. of Records for GLBAL" <> 0 then
            LoopCountForGLBALL := Round((CadencyDataForGLBALL.Count / TrintechInterfaceSetup."Max No. of Records for GLBAL"), 1, '>')
        else
            LoopCountForGLBALL := 1;

        CadencyDataForGLTRANL.SetCurrentKey("File Type");
        CadencyDataForGLTRANL.SetRange("File Type", CadencyDataForGLTRANL."File Type"::GLTRAN);
        if TrintechInterfaceSetup."Max No. of Records for GLTRAN" <> 0 then
            LoopCountForGLTRANL := Round((CadencyDataForGLTRANL.Count / TrintechInterfaceSetup."Max No. of Records for GLTRAN"), 1, '>')
        else
            LoopCountForGLTRANL := 1;

        CadencyDataForSLBALL.SetCurrentKey("File Type");
        CadencyDataForSLBALL.SetRange("File Type", CadencyDataForSLBALL."File Type"::SLBAL);
        if TrintechInterfaceSetup."Max No. of Records for SLBAL" <> 0 then
            LoopCountForSLBALL := Round((CadencyDataForSLBALL.Count / TrintechInterfaceSetup."Max No. of Records for SLBAL"), 1, '>')
        else
            LoopCountForSLBALL := 1;

        LoopCountL := LoopCountForGLBALL;
        if LoopCountL < LoopCountForGLTRANL then
            LoopCountL := LoopCountForGLTRANL;
        if LoopCountL < LoopCountForSLBALL then
            LoopCountL := LoopCountForSLBALL;

        EmailSubjectL := Text002 + '_' + CompInfo."Custom System Indicator Text" + '_' + GeneralInterfaceSetup."Company Code ID";

        for iL := 1 to LoopCountL do begin
            Clear(EmailInitiatedL);
            Clear(EmailMessageL);
            if LoopCountForGLBALL >= iL then begin
                CadencyDataForGLBALL.SetRange("E-Mail For GLBAL", false);
                if CadencyDataForGLBALL.FindSet(true) then begin
                    Clear(jL);
                    MakeExcelDataHeaderForGLBAL_Trintech(CadencyDataForGLBALL);
                    repeat
                        jL += 1;
                        MakeExcelDataBodyForGLBAL_Trintech(CadencyDataForGLBALL);
                        CadencyDataForGLBALL."E-Mail For GLBAL" := true;
                        CadencyDataForGLBALL.Modify(false);
                    until (CadencyDataForGLBALL.Next() = 0) or (jL = TrintechInterfaceSetup."Max No. of Records for GLBAL");
                    TempExcelBuffer.CloseBook();
                    // BC Upgrade POENAB02 >>
                    // SMTPL.CreateMessage(EmailSubjectL, SenderEmail, EmailIDL, EmailSubjectL, EmailSubjectL, true);
                    // EmailMessageL.Create(SenderEmail, EmailIDL, EmailSubjectL, true);   // BC UPGRADE KAIRAR01 PID-563
                    EmailMessageL.Create(EmailIDL, EmailSubjectL, EmailSubjectL, true); // BC UPGRADE KAIRAR01 PID-563 NAV to BC email fix: corrected recipient and subject mapping
                    // BC Upgrade POENAB02 <<                    
                    EmailInitiatedL := true;
                    // BC Upgrade POENAB02 >>
                    // SMTPL.AddAttachment(ServerFileName,
                    //                     EmailSubjectL + '_' + FORMAT(CadencyDataForGLTRANL."File Type") + '_' +
                    //                     FORMAT(EmailSendDate, 0, '<Day,2>-<Month,2>-<Year,2>') + ' ' +
                    //                     FORMAT(TIME, 0, '<Hours24,2>-<Minutes,2>-<Seconds,2>') +
                    //                     '.xlsx');
                    AddExcelAttachment(EmailMessageL,
                                       EmailSubjectL + '_' + Format(CadencyDataForGLBALL."File Type") + '_' +
                                       Format(EmailSendDate, 0, '<Day,2>-<Month,2>-<Year,2>') + ' ' +
                                       Format(Time, 0, '<Hours24,2>-<Minutes,2>-<Seconds,2>') +
                                       '.xlsx');
                    // BC Upgrade POENAB02 <<
                end;
            end;

            if LoopCountForGLTRANL >= iL then begin
                CadencyDataForGLTRANL.SetRange("E-Mail For GLTRAN", false);
                if CadencyDataForGLTRANL.FindSet(true) then begin
                    Clear(jL);
                    MakeExcelDataHeaderForGLTRAN_Trintech(CadencyDataForGLTRANL);
                    repeat
                        jL += 1;
                        MakeExcelDataBodyForGLTRAN_Trintech(CadencyDataForGLTRANL);
                        CadencyDataForGLTRANL."E-Mail For GLTRAN" := true;
                        CadencyDataForGLTRANL.Modify(false);
                    until (CadencyDataForGLTRANL.Next() = 0) or (jL = TrintechInterfaceSetup."Max No. of Records for GLTRAN");
                    TempExcelBuffer.CloseBook();
                    if not EmailInitiatedL then begin
                        // BC Upgrade POENAB02 >>
                        // SMTPL.CreateMessage(EmailSubjectL, SenderEmail, EmailIDL, EmailSubjectL, EmailSubjectL, true);
                        // EmailMessageL.Create(SenderEmail, EmailIDL, EmailSubjectL, true); // BC UPGRADE KAIRAR01 PID-563
                        EmailMessageL.Create(EmailIDL, EmailSubjectL, EmailSubjectL, true); // BC UPGRADE KAIRAR01 PID-563 NAV to BC email fix: corrected recipient and subject mapping
                        // BC Upgrade POENAB02 <<
                        EmailInitiatedL := true;
                    end;
                    // BC Upgrade POENAB02 >>
                    // SMTPL.AddAttachment(ServerFileName,
                    //                     EmailSubjectL + '_' + FORMAT(CadencyDataForSLBALL."File Type") + '_' +
                    //                     FORMAT(EmailSendDate, 0, '<Day,2>-<Month,2>-<Year,2>') + ' ' +
                    //                     FORMAT(TIME, 0, '<Hours24,2>-<Minutes,2>-<Seconds,2>') +
                    //                     '.xlsx');
                    AddExcelAttachment(EmailMessageL,
                                       EmailSubjectL + '_' + Format(CadencyDataForGLTRANL."File Type") + '_' +
                                       Format(EmailSendDate, 0, '<Day,2>-<Month,2>-<Year,2>') + ' ' +
                                       Format(Time, 0, '<Hours24,2>-<Minutes,2>-<Seconds,2>') +
                                       '.xlsx');
                    // BCUpgrade POENAB02 <<
                end;
            end;

            if LoopCountForSLBALL >= iL then begin
                CadencyDataForSLBALL.SetRange("E-Mail For SLBAL", false);
                if CadencyDataForSLBALL.FindSet(true) then begin
                    Clear(jL);
                    MakeExcelDataHeaderForSLBAL_Trintech(CadencyDataForSLBALL);
                    repeat
                        jL += 1;
                        MakeExcelDataBodyForSLBAL_Trintech(CadencyDataForSLBALL);
                        CadencyDataForSLBALL."E-Mail For SLBAL" := true;
                        CadencyDataForSLBALL.Modify(false);
                    until (CadencyDataForSLBALL.Next() = 0) or (jL = TrintechInterfaceSetup."Max No. of Records for SLBAL");
                    TempExcelBuffer.CloseBook();
                    if not EmailInitiatedL then begin
                        // EmailMessageL.Create(SenderEmail, EmailIDL, EmailSubjectL, true); // BC UPGRADE KAIRAR01 PID-563
                        EmailMessageL.Create(EmailIDL, EmailSubjectL, EmailSubjectL, true); // BC UPGRADE KAIRAR01 PID-563 NAV to BC email fix: corrected recipient and subject mapping
                        EmailInitiatedL := true;
                    end;
                    AddExcelAttachment(EmailMessageL,
                                       EmailSubjectL + '_' + Format(CadencyDataForSLBALL."File Type") + '_' +
                                       Format(EmailSendDate, 0, '<Day,2>-<Month,2>-<Year,2>') + ' ' +
                                       Format(Time, 0, '<Hours24,2>-<Minutes,2>-<Seconds,2>') +
                                       '.xlsx');
                end;
            end;

            if EmailInitiatedL then begin
                // BC Upgrade POENAB02 >>
                // SMTPL.Send;
                Email.Send(EmailMessageL, Enum::"Email Scenario"::Default);
                // BC Upgrade POENAB02 <<
                EmailSentL := true;
            end;

            if EmailSentL and (iL = LoopCountL) then begin
                CadencyRunningCalendarL1.Get(CadencyRunningCalendarL."Starting Date");
                if SendEmailForMDL then
                    CadencyRunningCalendarL1."Manual Run Date (E-Mail Sent)" := true
                else if SendEmailForADL then
                    CadencyRunningCalendarL1."Addnl. Run Date (E-Mail Sent)" := true
                else if SendEmailForWD2L then
                    CadencyRunningCalendarL1."Working Day-2 (E-Mail Sent)" := true
                else if SendEmailForWD6L then
                    CadencyRunningCalendarL1."Working Day-6 (E-Mail Sent)" := true;
                CadencyRunningCalendarL1.Modify(true);
            end;
        end;
        //HEI.01<<
    end;

    var
        TrintechInterfaceSetup: Record "Trintech Interface Setup INT";
        CompInfo: Record "Company Information";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        GeneralInterfaceSetup: Record "General Interface Setup INT";
        EmailAccount: Record "Email Account";
        Email: Codeunit Email;
        EmailScenario: Codeunit "Email Scenario";
        EmailSendDate: Date;
        Text000: Label 'Interface ''%1'' is not enabled.';
        Text001: Label 'There is no Email Setup to send Email from Sender ID.';
        Text002: Label 'Cadency Data';
        SenderEmail: Text[100];

    local procedure ValidateInterfaceSetup_Trintech(InterfaceCode: Code[20]);
    var
        InterfaceSetupL: Record "Interface Setup INT";
    begin
        //HEI.01>>
        InterfaceSetupL.Get(InterfaceCode);
        if not InterfaceSetupL.Enabled then
            Error(Text000, InterfaceSetupL.Code);
        //HEI.01<<
    end;

    local procedure MakeExcelDataHeaderForGLBAL_Trintech(var CadencyData: Record "Cadency Data FND");
    // BC Upgrade POENAB02 >>
    //var
    //    FileMgtL: Codeunit "File Management";
    // BC Upgrade POENAB02 <<
    begin
        //HEI.01>>
        TempExcelBuffer.DeleteAll(false);
        TempExcelBuffer.ClearNewRow();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Entry No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("File Type"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Company Name"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("G/L Account No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("G/L Account Name"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY1Code), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY1GLEndBalance), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY2Code), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY2GLEndBalance), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY3Code), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY3GLEndBalance), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(Period), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(Year), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY1NetDebits), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY2NetDebits), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY3NetDebits), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY1NetCredits), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY2NetCredits), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY3NetCredits), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY1TransCount), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY2TransCount), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY3TransCount), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        // BC Upgrade POENAB02 >>
        // ServerFileName := FileMgtL.ServerTempFileName('xlsx');
        // TempExcelBuffer.CreateBook(ServerFileName, Text002);        
        TempExcelBuffer.CreateNewBook(Text002);
        // BC Upgrade POENAB02 <<        
        TempExcelBuffer.WriteSheet(Text002 + '_' + Format(CadencyData."File Type"), '', '');
        //HEI.01<<
    end;

    local procedure MakeExcelDataBodyForGLBAL_Trintech(var CadencyData: Record "Cadency Data FND");
    begin
        //HEI.01>>
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(CadencyData."Entry No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData."File Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."Company Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."G/L Account No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData."G/L Account Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.CCY1Code, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.CCY1GLEndBalance, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY2Code, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.CCY2GLEndBalance, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY3Code, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.CCY3GLEndBalance, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.Period, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.Year, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY1NetDebits, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY2NetDebits, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY3NetDebits, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY1NetCredits, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY2NetCredits, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY3NetCredits, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY1TransCount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY2TransCount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY3TransCount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.WriteSheet(Text002 + '_' + Format(CadencyData."File Type"), '', '');
        //HEI.01<<
    end;

    local procedure MakeExcelDataHeaderForGLTRAN_Trintech(var CadencyData: Record "Cadency Data FND");
    // BC Upgrade POENAB02 >>
    // var
    //     FileMgtL: Codeunit "File Management";    
    // BC Upgrade POENAB02 <<
    begin
        //HEI.01>>
        TempExcelBuffer.DeleteAll(false);
        TempExcelBuffer.ClearNewRow();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Entry No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("File Type"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Header Info"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Company Name"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("G/L Account No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(EffectiveDate), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(Date1), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY2Code), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY2Amount), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Document No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(Description), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Document Type"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("External Document No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Customer No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("User ID"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Total Count"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Total Amount"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        // BC Upgrade POENAB02 >>
        // ServerFileName := FileMgtL.ServerTempFileName('xlsx');
        // TempExcelBuffer.CreateBook(ServerFileName, Text002);        
        TempExcelBuffer.CreateNewBook(Text002);
        // BCUpgrade POENAB02 <<        
        TempExcelBuffer.WriteSheet(Text002 + '_' + Format(CadencyData."File Type"), '', '');
        //HEI.01<<
    end;

    local procedure MakeExcelDataBodyForGLTRAN_Trintech(var CadencyData: Record "Cadency Data FND");
    begin
        //HEI.01>>
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(CadencyData."Entry No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData."File Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."Header Info", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."Company Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."G/L Account No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.EffectiveDate, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(CadencyData.Date1, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
        TempExcelBuffer.AddColumn(CadencyData.CCY2Code, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.CCY2Amount, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData."Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."Document Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."External Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."Customer No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."User ID", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."Total Count", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData."Total Amount", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.WriteSheet(Text002 + '_' + Format(CadencyData."File Type"), '', '');
        //HEI.01<<
    end;

    local procedure MakeExcelDataHeaderForSLBAL_Trintech(var CadencyData: Record "Cadency Data FND");
    // BC Upgrade POENAB02 >>
    // var
    //     FileMgtL: Codeunit "File Management";    
    // BCUpgrade POENAB02 <<
    begin
        //HEI.01>>
        TempExcelBuffer.DeleteAll(false);
        TempExcelBuffer.ClearNewRow();
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Entry No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("File Type"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Company Name"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("G/L Account No."), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("G/L Account Name"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY1Code), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY1SubLedger), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY2Code), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(CCY2SubLedger), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(Period), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption(Year), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Total Count"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.FieldCaption("Total Amount"), false, '', true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        // BC Upgrade POENAB02 >>
        // ServerFileName := FileMgtL.ServerTempFileName('xlsx');
        // TempExcelBuffer.CreateBook(ServerFileName, Text002);        
        TempExcelBuffer.CreateNewBook(Text002);
        // BC Upgrade POENAB02 <<
        TempExcelBuffer.WriteSheet(Text002 + '_' + Format(CadencyData."File Type"), '', '');
        //HEI.01<<
    end;

    local procedure MakeExcelDataBodyForSLBAL_Trintech(var CadencyData: Record "Cadency Data FND");
    begin
        //HEI.01>>
        TempExcelBuffer.NewRow();
        TempExcelBuffer.AddColumn(CadencyData."Entry No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData."File Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."Company Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData."G/L Account No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData."G/L Account Name", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.CCY1Code, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.CCY1SubLedger, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.CCY2Code, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn(CadencyData.CCY2SubLedger, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.Period, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData.Year, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData."Total Count", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.AddColumn(CadencyData."Total Amount", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
        TempExcelBuffer.WriteSheet(Text002 + '_' + Format(CadencyData."File Type"), '', '');
        //HEI.01<<
    end;

    // BC Upgrade POENAB02 >>
    local procedure AddExcelAttachment(var EmailMessage: Codeunit "Email Message"; AttachmentName: Text);
    var
        TempBlob: Codeunit "Temp Blob";
        AttachmentInStream: InStream;
        AttachmentOutStream: OutStream;
    begin
        TempBlob.CreateOutStream(AttachmentOutStream);
        TempExcelBuffer.SaveToStream(AttachmentOutStream, true);
        TempBlob.CreateInStream(AttachmentInStream);
        EmailMessage.AddAttachment(
            AttachmentName,
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            AttachmentInStream);
    end;
    // BC Upgrade POENAB02 <<
}

