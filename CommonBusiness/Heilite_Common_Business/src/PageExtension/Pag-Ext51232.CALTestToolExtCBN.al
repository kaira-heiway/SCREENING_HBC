pageextension 51232 CALTestToolExtCBN extends "CAL Test Tool"
{
    // version NAVW110.0
    // HEI.01 RITM2822071 IBM BULIMC01 07/10/2021 #new object created for HNK license
    // HEI.02 RITM2738652 IBM BHATTA09 21.12.2022
    //   # New fields added RT Pack
    // HEI.03 RITM2923302 IBM SAXENA03 11/02/2022
    //   # Added new field "Document Reference No." in Page.
    // HEI.04 RITM2964345 IBM SAXENA03 11/03/2022
    //   # Added new Button "Run Test For All OpCos" in Page.
    // HEI.05 RITM2964345 IBM SAXENA03 07/06/2022
    //   # Added new Button "Export Test Results" in Page.
    //   # Added new Function ExportTestResults() & OpenInputBOX in Page.
    // HEI.06 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    // BC Upgrade PATELS08 >>
    // # Added Tags HEI.01, HEI.02, HEI.03, HEI.04, HEI.05 and HEI.06 in documentation.
    // # Added new fields "RT Pack" and "Document Reference No." 
    // # Added labels Text50000, Text50001, Text50002, Text50003.
    // # Added new functions ExportTestResults() and OpenInputBOX().
    // # Blocked Report.SaveAsExcel and FileMgt.DeleteServerFile as they are not supported in Extension development, this code will only work for On-Prem.
    // BC Upgrade PATELS08 <<

    // BC Upgrade KAPOOV01 >>
    // # Commented function-VariablesOpenInputBOX due to DOTNET variables.
    // # Added code for REPORT.SAVEASEXCEL functionality replacement
    // BC Upgrade KAPOOV01 <<

    layout
    {


        modify(LineType)
        {
            CaptionML = ENU = 'Line Type', FRA = 'Type ligne';
        }
        modify(TestCodeunit)
        {
            CaptionML = ENU = 'Codeunit ID', FRA = 'ID codeunit';
        }
        modify(Duration)
        {
            CaptionML = ENU = 'Duration', FRA = 'Durée';
        }

        // BC Upgrade PATELS08 >> # Added fields "RT Pack", "Document Reference No."
        addafter(Name)
        {

            // HEI.02 >>
            field("RT Pack"; Rec."RT Pack FND")
            {
                ApplicationArea = All;
            }
            // HEI.02 <<
        }

        addbefore(LineType)
        {

            // HEI.03 >>
            field("Document Reference No."; Rec."Document Reference No. FND")
            {
                ApplicationArea = All;
            }
            // HEI.03 <<
        }

        // BC Upgrade PATELS08 <<

    }
    actions
    {
        modify("F&unctions")
        {
            CaptionML = ENU = 'F&unctions', FRA = 'Fonction&s';
        }
        modify(Run)
        {
            CaptionML = ENU = '&Run', FRA = 'E&xécuter';
        }
        modify(ExportProject)
        {
            CaptionML = ENU = 'Export', FRA = 'Exporter';
        }
        modify(ImportProject)
        {
            CaptionML = ENU = 'Import', FRA = 'Importer';
        }

        // BC UPGRADE PATELS08 >>

        addafter(ExportProject)
        {
            // HEI.04 >>
            action("Run Test For All OpCos")
            {
                Caption = 'Run Test For All OpCos';
                ApplicationArea = All;
                Image = TestFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Report.RunModal(50593, true, false); // Report 50593 is 'Test CAL Script Run'
                end;
            }
            // HEI.04 <<

            // HEI.05 >>
            action("Export Test Results")
            {
                Caption = 'Export Test Results';
                ApplicationArea = All;
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ExportTestResults();
                end;
            }

            // HEI.05 <<
        }
        // BC UPGRADE PATELS08 <<
    }

    // BC Upgrade PATELS08 >> 

    // HEI.05 >>
    var
        Text50000: label 'No Action will be taken';
        Text50001: label 'File Path is blank';
        Text50002: label 'Document Reference number field is blank';
        Text50003: label 'Completed';


    procedure ExportTestResults()
    var
        CALTestLine: Record "CAL Test Line";
        CALTestResultSummary: Report "CAL Test Summary CBN";
        FileName: Text;
        FilePath1: Text;
        ExportFileName: Text;
        FileMgt: Codeunit "File Management";
        FilePath: Text;
        DocRefNum: Text;
        SuiteName: Code[10];
        //BC UPGRADE KAPOOV01 added to replace REPORT.SAVEASEXCEL functionality >>
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
    //BC UPGRADE KAPOOV01 added to replace REPORT.SAVEASEXCEL functionality <<
    begin
        //OpenInputBOX(FilePath, DocRefNum); //BC UPGRADE KAPOOV01 need to comment this function due to DOTNET Variables 
        ExportFileName := TENANTID() + '_' + COMPANYNAME + '_TestResult.xls';
        FilePath1 := FilePath + '\' + ExportFileName;

        // BC Upgrade PATELS08 >> # Blocked DeleteServerFile Cannot be used for Extension Development, only for On-Prem.
        // IF FileMgt.ServerFileExists(FilePath1) THEN
        //     FileMgt.DeleteServerFile(FilePath1); 
        // BC Upgrade PATELS08 <<


        CALTestLine.RESET();
        CALTestLine.SETCURRENTKEY("Test Suite");
        CALTestLine.SETFILTER("Test Suite", '<>%1', '');
        IF CALTestLine.FINDFIRST() THEN
            SuiteName := CALTestLine."Test Suite";


        CALTestLine.RESET();
        CALTestLine.SETCURRENTKEY(Name, "Document Reference No. FND");
        CALTestLine.SETRANGE("Test Suite", SuiteName);
        CALTestLine.SETRANGE("Document Reference No. FND", DocRefNum);
        // BC Upgrade PATELS08 >> # Blocked Report.SaveAsExcel is not supported in Extension development, this code will only work for On-Prem.
        // IF CALTestLine.FINDSET(FALSE) THEN BEGIN
        // REPORT.SAVEASEXCEL(50587,FilePath1,CALTestLine);
        // END;
        // BC Upgrade PATELS08 <<

        //BC UPGRADE KAPOOV01 Added code for REPORT.SAVEASEXCEL functionality replacement >>
        IF CALTestLine.FINDSET(FALSE) THEN BEGIN
            // Create stream
            TempBlob.CreateOutStream(OutStr);

            // Run report and export as Excel
            Report.SaveAs(
                50587,
                '',
                ReportFormat::Excel,
                OutStr,
                CALTestLine
            );

            // Download file to user
            FileName := '_TestResult.xls';
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, '', '', '', FileName);

        END;
        //BC UPGRADE KAPOOV01 Added code for REPORT.SAVEASEXCEL functionality replacement <<

        MESSAGE(Text50003);
    end;
    // HEI.05 <<

    // HEI.05 >>

    //BC UPGRADE KAPOOV01 need to comment this function due to DOTNET Variables >>
    // procedure OpenInputBOX(var FilePath: Text; var DocRefNumber: Text)
    // var
    //     InputBoxForm: DotNet Microsoft.VisualBasic.Interaction.'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a';
    //     ImputValue: Text;
    //     Prompt: DotNet System.Windows.Forms.Form.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     FormBorderStyle: Dotnet System.Windows.Forms.FormBorderStyle.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     FormStartPosition: Dotnet System.Windows.Forms.FormStartPosition.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     LblRows: Dotnet System.Windows.Forms.Label.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     LblColumns: Dotnet System.Windows.Forms.Label.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     TxtRows: Dotnet System.Windows.Forms.TextBox.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     TxtColumns: Dotnet System.Windows.Forms.TextBox.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     ButtonOk: Dotnet System.Windows.Forms.Button.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     ButtonCancel: Dotnet System.Windows.Forms.Button.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     DialogResult: Dotnet System.Windows.Forms.DialogResult.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     TxtRows1: Dotnet System.Windows.Forms.TextBox.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     TxtColumns1: Dotnet System.Windows.Forms.TextBox.'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089';
    //     Color: Dotnet System.Drawing.Color.'System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a';
    // begin
    //     //HEI.05>>
    //     CLEAR(FilePath);
    //     CLEAR(DocRefNumber);

    //     //----Creating the form--
    //     Prompt := Prompt.Form();
    //     Prompt.ShowInTaskbar(TRUE);//As
    //     Prompt.Width := 650;
    //     Prompt.Height := 300;
    //     Prompt.FormBorderStyle := FormBorderStyle.FixedDialog;
    //     Prompt.BackColor := Color.White;
    //     Prompt.Text := 'Export Test Results';
    //     Prompt.StartPosition := FormStartPosition.CenterScreen;
    //     //----Creating the form--

    //     //----Adding Labels--
    //     LblRows := LblRows.Label;
    //     LblRows.Text('File Path..................');
    //     LblRows.Left(20);
    //     LblRows.Top(20);
    //     LblRows.Width(200);
    //     Prompt.Controls.Add(LblRows);

    //     LblColumns := LblColumns.Label;
    //     LblColumns.Text('Document Reference No. .......');
    //     LblColumns.Left(20);
    //     LblColumns.Top(60);
    //     LblColumns.Width(200);
    //     Prompt.Controls.Add(LblColumns);
    //     //----Adding Labels--

    //     //----Adding Textboxes--
    //     TxtRows := TxtRows.TextBox();
    //     //LblRows.Text('User ID');
    //     TxtRows.Left(230);
    //     TxtRows.Top(20);
    //     TxtRows.Width(300);
    //     //TxtRows.Text:=USERID;
    //     Prompt.Controls.Add(TxtRows);

    //     TxtColumns1 := TxtColumns1.TextBox();
    //     // TxtColumns1.Text := Rec."Document Reference No."; // BC Upgrade PATELS08 >> # To be unblocked when TableExtension is compiled
    //     //TxtColumns1.PasswordChar('*';
    //     TxtColumns1.Left(230);
    //     TxtColumns1.Top(60);
    //     TxtColumns1.Width(300);
    //     Prompt.Controls.Add(TxtColumns1);

    //     //----Adding Textboxes--

    //     //----Adding Button--
    //     ButtonOk := ButtonOk.Button;
    //     ButtonOk.Text('OK');
    //     ButtonOk.Left(380);
    //     ButtonOk.Top(150);
    //     ButtonOk.Width(100);
    //     ButtonOk.Height(30);
    //     ButtonOk.DialogResult := DialogResult.OK;
    //     Prompt.Controls.Add(ButtonOk);
    //     Prompt.AcceptButton := ButtonOk;

    //     ButtonCancel := ButtonCancel.Button;
    //     ButtonCancel.Text('Cancel');
    //     ButtonCancel.Left(500);
    //     ButtonCancel.Top(150);
    //     ButtonCancel.Width(100);
    //     ButtonCancel.Height(30);
    //     ButtonCancel.DialogResult := DialogResult.Cancel;
    //     Prompt.Controls.Add(ButtonCancel);
    //     Prompt.AcceptButton := ButtonCancel;
    //     //----Adding Button--

    //     //----Getting the Results--

    //     IF (Prompt.ShowDialog().ToString() = DialogResult.OK.ToString()) THEN BEGIN
    //         IF TxtRows.Text <> '' THEN
    //             FilePath := TxtRows.Text
    //         ELSE
    //             ERROR(Text50001);

    //         IF TxtColumns1.Text <> '' THEN
    //             DocRefNumber := TxtColumns1.Text
    //         ELSE
    //             ERROR(Text50002);
    //     END
    //     ELSE BEGIN
    //         ERROR(Text50000);
    //         Prompt.Close;
    //     END;

    //     Prompt.Close;
    //     Prompt.Dispose;
    //     //----Getting the Results--
    //     //HEI.05<<

    // end;
    //BC UPGRADE KAPOOV01 need to comment this function due to DOTNET Variables <<
    // HEI.05 <<

    // BC Upgrade PATELS08 <<
}

