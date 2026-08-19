codeunit 58130 "Automate CALTest Script DevOp"
{
    // version TS,HEI.09

    // HEI.01 RITM2957851 IBM SAXENA03 31/05/2022
    //   # CodeUnit is developed to RUN Test CAL functions aumatically from Powershell
    //   # Added code to RUN the reports
    //   # Code Added to RUN CreateXML() & ExportCALTestText(), when Data available in Table CAL Test Line HNK table.
    //   # Cleanup Code
    //   # Updated Result value as Failed if data not avialable in Table, in Function ExportCALTestText ()
    //   # Enable Unit Test Creation report.
    // 
    // HEI.02 RITM3073160 IBM SAXENA03 30/06/2022
    //   # TotalTime convert into Seconds from Miliseconds
    // 
    // HEI.03 RITM3121918 IBM VORGIM01 09/08/2022
    //   # Put Proper name in the JUNIT XML
    //   # Add Dynamic ACCEPTANCE Scripts in different Function
    // 
    // HEI.04 RITM3121918 IBM SAXENA03 11/08/2022
    //   # Added a new function CreateUnitTestDataACC() to skip Unit test Data preparation for DTW stream
    // HEI.05 RITM3007822 IBM GOKULS01 11/08/2022
    //   # Added a new function CreateUnitTestDataACC() to add Unit test Data preparation for DTW stream
    // HEI.06 RITM3007822 IBM GOKULS01 23/08/2022
    //   # Added a code to remove burundi
    // HEI.07 RITM3323083 IBM SAXENA03 07/03/2023
    //   # Added filter to Run Test Scripts only for FIELD Results = ""
    // HEI.08 RITM3323086  IBM SAXENA03 21-03-2023
    //   # Adding to code to remove Test Results = SKIP from DevOps Junit XML
    // HEI.09 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    // BC Upgrade PATELP08 >> 
    // # Replaced Custom Records, reports and codeunits with standard ones.
    // # removed 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
    // # Blocked The application objects or methods because it has scope 'OnPrem' and cannot be used for 'Extension' development
    // # Blocking DOTNET Values and Procedures having DOTNET paramter passing and finding Workaround need to find solution
    // # Old Object ID- 50186.
    // # Moved Test Script CU to INT Extension.
    // BC Upgrade PATELP08 <<

    trigger OnRun();
    begin
        RunRTPack();
        //MESSAGE('Test RUN');
    end;

    var
        GITSetup: Record "GIT Version Setup FND";
        FilePath: Text;
        FileMgt: Codeunit "File Management";
        DBDetails: Text;
        GenLedSetup: Record "General Ledger Setup";

    procedure GetTestCodeUnits(p_InputText: Text);
    var
        CALTestScriptConfig: Codeunit "CAL Test Script RT CBN";
    begin
        CALTestScriptConfig.SetDocRef(p_InputText);
        CALTestScriptConfig.TestScripts('Default');
    end;

    procedure RunRTPack();
    var
        // BC Upgrade PATELP08 >> Replaced Custom Records, reports and codeunits with standard ones.
        //CALTestLineHNK : Record "CAL Test Line HNK";
        CALTestLineHNK: Record "CAL Test Line";
        //CALTestMgtHNK : Codeunit "CAL Test Management HNK";
        CALTestMgtHNK: Codeunit "CAL Test Management";
    // BC Upgrade PATELP08 <<
    begin
        CALTestLineHNK.RESET;
        CALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
        CALTestLineHNK.SETRANGE("Test Suite", 'DEFAULT');
        CALTestLineHNK.SETRANGE("RT Pack FND", true);
        //>>HEI.07
        CALTestLineHNK.SETRANGE(Result, CALTestLineHNK.Result::" ");
        //<<HEI.07
        // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
        //if CALTestLineHNK.FINDSET(false,false) then
        if CALTestLineHNK.FINDSET(false) then
            // BC Upgrade PATELP08 <<
            CALTestMgtHNK.RunSelected(CALTestLineHNK);
    end;

    procedure RunRTPackACC();
    var
        // BC Upgrade PATELP08 >> Replaced Custom Records, reports and codeunits with standard ones.
        // CALTestLineHNK : Record "CAL Test Line HNK";
        // CALTestMgtHNK : Codeunit "CAL Test Management HNK";
        // CALTestSuiteHNK : Record "CAL Test Suite HNK";
        CALTestLineHNK: Record "CAL Test Line";
        CALTestMgtHNK: Codeunit "CAL Test Management";
        CALTestSuiteHNK: Record "CAL Test Suite";
    // BC Upgrade PATELP08 <<
    begin
        CALTestSuiteHNK.RESET;
        CALTestSuiteHNK.SETCURRENTKEY("RT Pack FND");
        CALTestSuiteHNK.SETRANGE("RT Pack FND", true);
        // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
        //if CALTestSuiteHNK.FINDSET(false,false) then repeat
        if CALTestSuiteHNK.FINDSET(false) then
            repeat
                // BC Upgrade PATELP08 <<
                CALTestLineHNK.RESET;
                CALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
                CALTestLineHNK.SETRANGE("Test Suite", CALTestSuiteHNK.Name);
                CALTestLineHNK.SETRANGE("RT Pack FND", true);
                CALTestLineHNK.SETRANGE(Run, true);
                // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
                //if CALTestLineHNK.FINDSET(false,false) then
                if CALTestLineHNK.FINDSET(false) then
                    // BC Upgrade PATELP08 >>
                    CALTestMgtHNK.RunSelected(CALTestLineHNK);
            until CALTestSuiteHNK.NEXT = 0;
    end;

    procedure GetRTLines(pInputText: Text[50]);
    var
        // BC Upgrade PATELP08 >> Replaced Custom Records, reports and codeunits with standard ones.
        //CALTestLine : Record "CAL Test Line HNK";
        CALTestLine: Record "CAL Test Line";
        CALTestResultSummary: Report "CAL Test Summary CBN";
        FileName: Text;
        FilePath1: Text;
    begin
        FileName := TENANTID + '_' + COMPANYNAME + '_TestResult.pdf';
        FilePath1 := FilePath + FileName;

        if FileMgt.ServerFileExists(FilePath1) then
            // BC Upgrade PATELP08 >> Blocking The application object or method 'DeleteServerFile' because it has scope 'OnPrem' and cannot be used for 'Extension' development
            //FileMgt.DeleteServerFile(FilePath1);
            // BC Upgrade PATELP08 <<
            CALTestLine.RESET;
        CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
        CALTestLine.SETRANGE("Test Suite", 'DEFAULT');
        CALTestLine.SETRANGE("Document Reference No. FND", pInputText);
        // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
        //if CALTestLine.FINDSET(false,false) then
        if CALTestLine.FINDSET(false) then; // BC Upgrade PATELP08 >> added ';' for removing syntax error remove in future if any code added in this if statement.
                                            // BC Upgrade PATELP08 >> Blocking The application object or method 'SAVEASPDF' because it has scope 'OnPrem' and cannot be used for 'Extension' development
                                            //REPORT.SAVEASPDF(50586,FilePath1,CALTestLine);
                                            // BC Upgrade PATELP08 <<
    end;

    procedure CreateXML(p_InputText: Text[50]);
    var
        FileName: Text;
        // BC Upgrade PATELP08 >> Blocking this DOTNET Values and finding Workaround need to find solution
        // xmlWriter: DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlTextWriter";
        // EncodingText: DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Text.Encoding";
        // BC Upgrade PATELP08 <<
        // BC Upgrade PATELP08 >> Replaced Custom Records, reports and codeunits with standard ones.
        //CALTestLineHNK : Record "CAL Test Line HNK";
        CALTestLineHNK: Record "CAL Test Line";
        // BC Upgrade PATELP08 <<
        FilePath1: Text;
        Objects: Record AllObj;
        TotalErrors: Integer;
        TotalSkipped: Integer;
        TotalTests: Integer;
        TotalTime: Decimal;
        TimeDiff: Decimal;
        Duration: Decimal;
        DurationinSec: Decimal;
        TestCodeUnit: Integer;
        // BC Upgrade PATELP08 >> Replaced Custom Records, reports and codeunits with standard ones.
        //ExistsCALTestLineHNK : Record "CAL Test Line HNK";
        ExistsCALTestLineHNK: Record "CAL Test Line";
        // BC Upgrade PATELP08 <<
        CALTestLineAvaliable: Boolean;
        TotalTimeSec: Decimal;
    begin
        FileName := TENANTID + '_' + COMPANYNAME + '_TestResults.xml';
        FilePath1 := FilePath + FileName;

        if FileMgt.ServerFileExists(FilePath1) then
            // BC Upgrade PATELP08 >> Blocking The application object or method 'DeleteServerFile' because it has scope 'OnPrem' and cannot be used for 'Extension' development
            //FileMgt.DeleteServerFile(FilePath1);
            // BC Upgrade PATELP08 <<

            //HEI.01>>
            CALTestLineAvaliable := false;
        ExistsCALTestLineHNK.RESET;
        ExistsCALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
        ExistsCALTestLineHNK.SETRANGE("Test Suite", 'DEFAULT');
        if not ExistsCALTestLineHNK.ISEMPTY then begin
            CALTestLineAvaliable := true;
        end;

        if CALTestLineAvaliable then begin
            //HEI.01<<
            TotalTests := 0;
            CALTestLineHNK.RESET;
            CALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            CALTestLineHNK.SETRANGE("Document Reference No. FND", p_InputText);
            TotalTests := CALTestLineHNK.COUNT;

            TotalErrors := 0;
            CALTestLineHNK.RESET;
            CALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            CALTestLineHNK.SETRANGE("Document Reference No. FND", p_InputText);
            CALTestLineHNK.SETRANGE(Result, CALTestLineHNK.Result::Failure);
            TotalErrors := CALTestLineHNK.COUNT;

            TotalSkipped := 0;
            //HEI.08>>
            //  CALTestLineHNK.RESET;
            //  CALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
            //  CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            //  CALTestLineHNK.SETRANGE("Document Reference No. FND",p_InputText);
            //  CALTestLineHNK.SETRANGE(Result,CALTestLineHNK.Result::Skipped);
            //  TotalSkipped := CALTestLineHNK.COUNT;
            //HEI.08<<

            TotalTime := 0;
            TimeDiff := 0;

            CALTestLineHNK.RESET;
            CALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            CALTestLineHNK.SETRANGE("Document Reference No. FND", p_InputText);
            // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
            //if CALTestLineHNK.FINDSET(false,false) then repeat
            if CALTestLineHNK.FINDSET(false) then
                repeat
                    // BC Upgrade PATELP08 <<
                    TimeDiff := CALTestLineHNK."Finish Time" - CALTestLineHNK."Start Time";
                    TotalTime += TimeDiff;
                until CALTestLineHNK.NEXT = 0;

            //HEI.02>>
            if TotalTime > 0 then
                TotalTimeSec := TotalTime / 1000
            else
                TotalTimeSec := 0;
            //HEI.02<<

            TestCodeUnit := 0;
            CALTestLineHNK.RESET;
            CALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            CALTestLineHNK.SETRANGE("Document Reference No. FND", p_InputText);
            // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
            //if CALTestLineHNK.FINDSET(false,false) then begin
            if CALTestLineHNK.FINDSET(false) then begin
                // BC Upgrade PATELP08 <<
                // BC Upgrade PATELP08 >> Blocking The application object or method 'ISNULL' because it has scope 'OnPrem' and cannot be used for 'Extension' development
                // if ISNULL(xmlWriter) then
                //   xmlWriter := xmlWriter.XmlTextWriter(FilePath1, EncodingText.UTF8);
                // BC Upgrade PATELP08 <<
                // BC Upgrade PATELP08 >> Blocking this because DOTNET Value 'xmlWriter' and finding Workaround need to find solution
                // xmlWriter.WriteStartDocument();
                // //Create Parent element
                // xmlWriter.WriteStartElement('testsuites');

                // xmlWriter.WriteStartElement('testsuite');
                // //HEI.03>>
                // //xmlWriter.WriteAttributeString('name','',CALTestLineHNK."Test Suite");
                // xmlWriter.WriteAttributeString('name', '', UPPERCASE(TENANTID) + ':' + COMPANYNAME + '_' + CALTestLineHNK."Test Suite");
                // //HEI.03<<
                // xmlWriter.WriteAttributeString('package', '', '');
                // xmlWriter.WriteAttributeString('id', '', '1');
                // xmlWriter.WriteAttributeString('hostname', '', FORMAT(DBDetails));//Server
                // xmlWriter.WriteAttributeString('errors', '', FORMAT(TotalErrors));
                // xmlWriter.WriteAttributeString('tests', '', FORMAT(TotalTests));
                // xmlWriter.WriteAttributeString('failures', '', FORMAT(TotalErrors));
                // xmlWriter.WriteAttributeString('skipped', '', FORMAT(TotalSkipped));
                // //HEI.02>>
                // //xmlWriter.WriteAttributeString('time','',FORMAT(TotalTime));
                // xmlWriter.WriteAttributeString('time', '', FORMAT(TotalTimeSec));
                // //HEI.02<<
                // xmlWriter.WriteAttributeString('timestamp', '', FORMAT(CALTestLineHNK."Finish Time", 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>'));
                // xmlWriter.WriteStartElement('properties');
                // BC Upgrade PATELP08 <<

                repeat
                    //Create Child elements
                    if (TestCodeUnit <> CALTestLineHNK."Test Codeunit") then begin
                        // BC Upgrade PATELP08 >> Blocking this because DOTNET Value 'xmlWriter' and finding Workaround need to find solution
                        // xmlWriter.WriteStartElement('property');
                        // xmlWriter.WriteAttributeString('name', '', FORMAT(CALTestLineHNK."Test Codeunit"));
                        // xmlWriter.WriteAttributeString('value', '', '');
                        // xmlWriter.WriteEndElement();
                        // BC Upgrade PATELP08 <<
                    end;
                    TestCodeUnit := CALTestLineHNK."Test Codeunit";
                until CALTestLineHNK.NEXT = 0;
                // BC Upgrade PATELP08 >> Blocking this because DOTNET Value 'xmlWriter' and finding Workaround need to find solution
                // xmlWriter.WriteEndElement();
                // BC Upgrade PATELP08 <<

            end;

            CALTestLineHNK.RESET;
            CALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            //HEI.08>>
            CALTestLineHNK.SETFILTER(Result, '<>%1', CALTestLineHNK.Result::Skipped);
            //HEI.08<<
            CALTestLineHNK.SETRANGE("Document Reference No. FND", p_InputText);
            // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
            //if CALTestLineHNK.FINDSET(false,false) then begin
            if CALTestLineHNK.FINDSET(false) then begin
                // BC Upgrade PATELP08 <<
                repeat
                    if Objects.GET(Objects."Object Type"::Codeunit, CALTestLineHNK."Test Codeunit") then;

                    if FORMAT(CALTestLineHNK."Finish Time" - CALTestLineHNK."Start Time") = '' then
                        Duration := 0
                    else
                        Duration := CALTestLineHNK."Finish Time" - CALTestLineHNK."Start Time";

                    //HEI.02>>
                    if Duration > 0 then
                        DurationinSec := Duration / 1000
                    else
                        DurationinSec := Duration;
                    //HEI.02<<

                    // BC Upgrade PATELP08 >> Blocking this because DOTNET Value 'xmlWriter' and finding Workaround need to find solution
                    // xmlWriter.WriteStartElement('testcase');
                    // xmlWriter.WriteAttributeString('classname', '', Objects."Object Name");
                    // xmlWriter.WriteAttributeString('name', '', CALTestLineHNK."Function");
                    // //HEI.02>>
                    // //xmlWriter.WriteAttributeString('time','',FORMAT(Duration));
                    // xmlWriter.WriteAttributeString('time', '', FORMAT(DurationinSec));
                    // //HEI.02<<
                    // BC Upgrade PATELP08 <<

                    if CALTestLineHNK.Result = CALTestLineHNK.Result::Skipped then begin
                        // BC Upgrade PATELP08 >> Blocking this because DOTNET Value 'xmlWriter' and finding Workaround need to find solution
                        // xmlWriter.WriteStartElement('skipped');
                        // xmlWriter.WriteEndElement();
                        // BC Upgrade PATELP08 <<
                    end;

                    if CALTestLineHNK.Result = CALTestLineHNK.Result::Failure then begin
                        // BC Upgrade PATELP08 >> Blocking this because DOTNET Value 'xmlWriter' and finding Workaround need to find solution
                        // xmlWriter.WriteStartElement('failure');
                        // xmlWriter.WriteAttributeString('message', '', CALTestLineHNK."First Error");
                        // xmlWriter.WriteAttributeString('type', '', '');
                        // xmlWriter.WriteEndElement();
                        // BC Upgrade PATELP08 <<
                    end;
                // BC Upgrade PATELP08 >> Blocking this because DOTNET Value 'xmlWriter' and finding Workaround need to find solution
                // xmlWriter.WriteEndElement();
                // BC Upgrade PATELP08 <<
                until CALTestLineHNK.NEXT = 0;
                // BC Upgrade PATELP08 >> Blocking this because DOTNET Value 'xmlWriter' and finding Workaround need to find solution
                // xmlWriter.WriteStartElement('system-out');
                // xmlWriter.WriteEndElement();
                // xmlWriter.WriteStartElement('system-err');
                // BC Upgrade PATELP08 <<
            end;
            // BC Upgrade PATELP08 >> Blocking this because DOTNET Value 'xmlWriter' and finding Workaround need to find solution
            // xmlWriter.WriteEndDocument();
            // xmlWriter.Close();
            // BC Upgrade PATELP08 <<
            //HEI.01>>
        end;
        //HEI.01<<
    end;

    procedure ExportCALTestText(pInputText: Text[50]);
    var
        // BC Upgrade PATELP08 >> Replaced Custom Records, reports and codeunits with standard ones.
        //CALTestLine : Record "CAL Test Line HNK";
        CALTestLine: Record "CAL Test Line";
        // BC Upgrade PATELP08 <<
        CALTestResultSummary: Report "CAL Test Summary CBN";
        FileName: Text;
        FilePath1: Text;
        File1: File;
        OutStreamObj: OutStream;
        Result: Code[10];
        // BC Upgrade PATELP08 >> Replaced Custom Records, reports and codeunits with standard ones.
        //ExistsCALTestLineHNK : Record "CAL Test Line HNK";
        ExistsCALTestLineHNK: Record "CAL Test Line";
        // BC Upgrade PATELP08 <<
        CALTestLineAvaliable: Boolean;
    begin
        FileName := TENANTID + '_' + COMPANYNAME + '_TestResult.txt';
        FilePath1 := FilePath + FileName;

        if FileMgt.ServerFileExists(FilePath1) then
            // BC Upgrade PATELP08 >> Blocking The application object or method 'DeleteServerFile' because it has scope 'OnPrem' and cannot be used for 'Extension' development
            //FileMgt.DeleteServerFile(FilePath1);
            // BC Upgrade PATELP08 <<

            //HEI.01>>
            CALTestLineAvaliable := false;
        ExistsCALTestLineHNK.RESET;
        ExistsCALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
        ExistsCALTestLineHNK.SETRANGE("Test Suite", 'DEFAULT');
        if not ExistsCALTestLineHNK.ISEMPTY then begin
            CALTestLineAvaliable := true;
        end;
        //HEI.01>>
        //Result :='';
        Result := 'Failed';
        //HEI.01<<
        if CALTestLineAvaliable then begin
            //HEI.01<<
            CALTestLine.RESET;
            CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLine.SETRANGE("Test Suite", 'DEFAULT');
            CALTestLine.SETRANGE("Line Type", CALTestLine."Line Type"::"Function");
            CALTestLine.SETRANGE(Result, CALTestLine.Result::Failure);
            CALTestLine.SETRANGE("Document Reference No. FND", pInputText);
            if CALTestLine.FINDFIRST then
                Result := 'Failed'
            else
                Result := 'Success';
            //HEI.01>>
        end;
        //HEI.01<<
        // BC Upgrade PATELP08 >> Blocking The application object or method 'CREATEOUTSTREAM', 'CREATE', 'CLOSE' because it has scope 'OnPrem' and cannot be used for 'Extension' development
        // File1.CREATE(FilePath1);
        // File1.CREATEOUTSTREAM(OutStreamObj);
        OutStreamObj.WRITETEXT(Result);
        //File1.CLOSE;
        // BC Upgrade PATELP08 <<
    end;
    // BC Upgrade PATELP08 >> Blocking this Procedure because of DOTNET Values and finding Workaround need to find solution
    // procedure ExecuteAutoCALTest(pCUArgument: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String");
    // var
    //     // BC Upgrade PATELP08 >> Replaced Custom Records and codeunits with standard ones.
    //     //CALTestSuite : Record "CAL Test Suite HNK";
    //     CALTestSuite: Record "CAL Test Suite";
    //     // BC Upgrade PATELP08 <<
    //     StringArrayValues: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //     Seperator: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    //     CRLF: Text;
    //     InputText: Text[50];
    // begin
    //     Seperator := ',';
    //     pCUArgument := pCUArgument.Normalize();
    //     StringArrayValues := pCUArgument.Split(Seperator.ToCharArray);

    //     CRLF[1] := 10;
    //     CRLF[2] := 13;

    //     InputText := DELCHR(StringArrayValues.GetValue(0), '<>', CRLF);
    //     FilePath := DELCHR(StringArrayValues.GetValue(1), '<>', CRLF);
    //     DBDetails := DELCHR(StringArrayValues.GetValue(2), '<>', CRLF); //>>HNK VORGIM01
    //     //HEI.01>>
    //     //CreateUnitTestData;
    //     //COMMIT;
    //     GetTestCodeUnits(InputText);
    //     RunRTPack();
    //     GetRTLines(InputText);
    //     CreateXML(InputText);
    //     ExportCALTestText(InputText);
    //     //HEI.01<<
    // end;
    // BC Upgrade PATELP08 <<

    procedure ExecuteAutoCALTestACC();
    var
        // BC Upgrade PATELP08 >> Replaced Custom Records and codeunits with standard ones.
        //CALTestSuite : Record "CAL Test Suite HNK";
        CALTestSuite: Record "CAL Test Suite";
        // BC Upgrade PATELP08 <<
        // BC Upgrade PATELP08 >> Blocking this DOTNET Values and finding Workaround need to find solution
        // StringArrayValues: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
        // Seperator: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
        // BC Upgrade PATELP08 <<
        CRLF: Text;
        InputText: Text[50];
    begin

        RunRTPackACC;
    end;

    local procedure CreateUnitTestData();
    var
        UnitTestValue: Record "Unit Testing Value FND";
        SetUnitValueMTC: Report "Create Unit Testing Val MtC";
        SetUnitValueRTR: Report "Create Unit Testing Val. - RTR";
        SetUnitValueSTP: Report "Create Unit Testing Val StP";
        SetUnitValueDTW: Report "Create Unit Testing Values DtW";
    begin

        GenLedSetup.GET;
        GenLedSetup."Allow Posting To" := (CALCDATE('<CY>', WORKDATE));
        GenLedSetup.MODIFY;
        COMMIT;

        UnitTestValue.RESET;
        if not UnitTestValue.ISEMPTY then
            UnitTestValue.DELETEALL(true);

        COMMIT;



        SetUnitValueMTC.SetParameters(true, true, true, true);
        SetUnitValueMTC.RUN;

        SetUnitValueDTW.SetParameters(true, true, true, true);
        SetUnitValueDTW.RUN;

        SetUnitValueRTR.SetParameters(true, true, true, true);
        SetUnitValueRTR.RUN;

        SetUnitValueSTP.SetParameters(true, true, true, true);
        SetUnitValueSTP.RUN;
    end;

    // BC Upgrade PATELP08 >> Blocking this procedure because of DOTNET Values and finding Workaround need to find solution
    // procedure ConfigureTestScripts(pCUArgument: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String");
    // var
    //     // BC Upgrade PATELP08 >> Replaced Custom Records and codeunits with standard ones.
    //     //CALTestSuite : Record "CAL Test Suite HNK";
    //     CALTestSuite: Record "CAL Test Suite";
    //     // BC Upgrade PATELP08 <<
    //     StringArrayValues: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //     Seperator: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    //     CRLF: Text;
    //     InputText: Text[50];
    // begin
    //     Seperator := ',';
    //     pCUArgument := pCUArgument.Normalize();
    //     StringArrayValues := pCUArgument.Split(Seperator.ToCharArray);

    //     CRLF[1] := 10;
    //     CRLF[2] := 13;

    //     InputText := DELCHR(StringArrayValues.GetValue(0), '<>', CRLF);
    //     FilePath := DELCHR(StringArrayValues.GetValue(1), '<>', CRLF);
    //     DBDetails := DELCHR(StringArrayValues.GetValue(2), '<>', CRLF); //>>HNK VORGIM01


    //     CreateUnitTestData;
    //     COMMIT;
    //     GetTestCodeUnits(InputText);
    // end;
    // BC Upgrade PATELP08 <<

    // BC Upgrade PATELP08 >> Blocking this procedure because of DOTNET Values and finding Workaround need to find solution
    // procedure GenerateOutputTS(pCUArgument: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String");
    // var
    //     // BC Upgrade PATELP08 >> Replaced Custom Records and codeunits with standard ones.
    //     //CALTestSuite : Record "CAL Test Suite HNK";
    //     CALTestSuite: Record "CAL Test Suite";
    //     // BC Upgrade PATELP08 <<
    //     StringArrayValues: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //     Seperator: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    //     CRLF: Text;
    //     InputText: Text[50];
    // begin
    //     Seperator := ',';
    //     pCUArgument := pCUArgument.Normalize();
    //     StringArrayValues := pCUArgument.Split(Seperator.ToCharArray);

    //     CRLF[1] := 10;
    //     CRLF[2] := 13;

    //     InputText := DELCHR(StringArrayValues.GetValue(0), '<>', CRLF);
    //     FilePath := DELCHR(StringArrayValues.GetValue(1), '<>', CRLF);
    //     DBDetails := DELCHR(StringArrayValues.GetValue(2), '<>', CRLF);

    //     GetRTLines(InputText);
    //     CreateXML(InputText);
    //     ExportCALTestText(InputText);
    // end;
    // BC Upgrade PATELP08 <<

    // BC Upgrade PATELP08 >> Blocking this Procedure 'ConfigureTestScriptsACC' because parameter is DOTNET Values and finding Workaround need to find solution
    // procedure ConfigureTestScriptsACC(pCUArgument: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String");
    // var
    //     // BC Upgrade PATELP08 >> Replaced Custom Records and codeunits with standard ones.
    //     //CALTestSuite : Record "CAL Test Suite HNK";
    //     CALTestSuite: Record "CAL Test Suite";
    //     // BC Upgrade PATELP08 <<
    //     // BC Upgrade PATELP08 >> Blocking this DOTNET Values and finding Workaround need to find solution
    //     StringArrayValues: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
    //     Seperator: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
    //     CRLF: Text;
    //     InputText: Text[50];
    // begin
    //     //HEI.03>>

    //     Seperator := ',';
    //     pCUArgument := pCUArgument.Normalize();
    //     StringArrayValues := pCUArgument.Split(Seperator.ToCharArray);

    //     CRLF[1] := 10;
    //     CRLF[2] := 13;

    //     InputText := DELCHR(StringArrayValues.GetValue(0), '<>', CRLF);
    //     FilePath := DELCHR(StringArrayValues.GetValue(1), '<>', CRLF);
    //     DBDetails := DELCHR(StringArrayValues.GetValue(2), '<>', CRLF);

    //     //HEI.04>>
    //     CreateUnitTestDataACC;
    //     //HEI.04<<
    //     COMMIT;
    //     GetTestCodeUnitsACC(InputText);

    //     //HEI.03<<
    // end;
    // BC Upgrade PATELP08 <<

    procedure GetTestCodeUnitsACC(p_InputText: Text);
    var

        CALTestScriptConfig: Codeunit "CAL Test Script RT CBN";
    begin
        //HEI.03>>
        CALTestScriptConfig.SetDocRef(p_InputText);
        CALTestScriptConfig.TestScriptsACC('Default');
        //HEI.03<<
    end;

    local procedure CreateUnitTestDataACC();
    var
        UnitTestValue: Record "Unit Testing Value FND";
        SetUnitValueMTC: Report "Create Unit Testing Val MtC";
        SetUnitValueRTR: Report "Create Unit Testing Val. - RTR";
        SetUnitValueSTP: Report "Create Unit Testing Val StP";
        SetUnitValueDTW: Report "Create Unit Testing Values DtW";
    begin
        //HEI.04>>
        GenLedSetup.GET;
        GenLedSetup."Allow Posting To" := (CALCDATE('<CY>', WORKDATE));
        GenLedSetup.MODIFY;
        COMMIT;

        UnitTestValue.RESET;
        if not UnitTestValue.ISEMPTY then
            UnitTestValue.DELETEALL(true);

        COMMIT;



        SetUnitValueMTC.SetParameters(true, true, true, true);
        SetUnitValueMTC.RUN;
        //HEI.05<<
        //IF UPPERCASE(COMPANYNAME)<>'10_BRARUDI' THEN BEGIN // HEI.06
        SetUnitValueDTW.SetParameters(true, true, true, true);
        SetUnitValueDTW.RUN;
        //END;// HEI.06
        //HEI.05>>
        SetUnitValueRTR.SetParameters(true, true, true, true);
        SetUnitValueRTR.RUN;

        SetUnitValueSTP.SetParameters(true, true, true, true);
        SetUnitValueSTP.RUN;
        //HEI.04<<
    end;
}

