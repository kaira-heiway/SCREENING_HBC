codeunit 58131 "Automate CALTest DynamicQ"
{
    // version TS,HEI.02

    // HEI.01 RITM2923302 IBM SAXENA03 05/04/2022
    //   # CodeUnit is developed to RUN All Test Scripts for Dynamic Q system.
    // HEI.02 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    // BC Upgrade PATELS08 >>
    // # Replaced Custom Objects "CAL Test Line HNK", "CAL Test Management HNK", "CAL Test Suite HNK" with Base objects "CAL Test Line", "CAL Test Management", "CAL Test Suite" respectively. 
    // # Blocked code which are using DotNet Variables. (a workaround needs to be found)
    // # Blocked code which is scoped only for On-Prem not supported in Extension development. (a workaround needs to be found)
    // # Old Object ID- 50187.
    // # Moved Test Script CU to INT Extension.
    // BC Upgrade PATELS08 <<


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
        CALTestScriptConfig: Codeunit "CAL Test RT DynamicQ CBN";
    begin
        CALTestScriptConfig.SetDocRef(p_InputText);
        CALTestScriptConfig.TestScripts('Default');
    end;

    procedure RunRTPack();
    var
        // BC UPGRADE PATELS08 >> # Changed the variable names and changed type from custom to inbuilt Codeunit and Record.
        // CALTestLineHNK : Record "CAL Test Line HNK";
        // CALTestMgtHNK : Codeunit "CAL Test Management HNK";
        CALTestLine: Record "CAL Test Line";
        CALTestMgt: Codeunit "CAL Test Management";
    // BC UPGRADE PATELS08 <<
    begin
        // BC UPGRADE PATELS08 >> # Cnanged variable name from CALTestLineHNK to CALTestLine and CALTestMgtHNK to CALTestMgt.
        // CALTestLineHNK.RESET;
        // CALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
        // CALTestLineHNK.SETRANGE("Test Suite",'DEFAULT');
        // CALTestLineHNK.SETRANGE("RT Pack FND",true);
        // if CALTestLineHNK.FINDSET then
        //   CALTestMgtHNK.RunSelected(CALTestLineHNK);

        CALTestLine.RESET();
        CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
        CALTestLine.SETRANGE("Test Suite", 'DEFAULT');
        CALTestLine.SETRANGE("RT Pack FND", true);
        if CALTestLine.FINDSET() then
            CALTestMgt.RunSelected(CALTestLine);
        // BC UPGRADE PATELS08 <<
    end;

    procedure RunRTPackACC();
    var
        // BC UPGRADE PATELS08 >> # Changed variable name and type from custom to inbuilt Codeunit and Record.
        // CALTestLineHNK : Record "CAL Test Line HNK";
        // CALTestMgtHNK : Codeunit "CAL Test Management HNK";
        // CALTestSuiteHNK : Record "CAL Test Suite HNK";
        CALTestLine: Record "CAL Test Line";
        CALTestMgt: Codeunit "CAL Test Management";
        CALTestSuite: Record "CAL Test Suite";
    // BC UPGRADE PATELS08 <<
    begin
        // BC UPGRADE PATELS08 >> # Changed variable name from CALTestLineHNK to CALTestLine, CALTestMgtHNK to CALTestMgt and CALTestSuiteHNK to CALTestSuite.
        // CALTestSuiteHNK.RESET;
        // CALTestSuiteHNK.SETCURRENTKEY("RT Pack FND");
        // CALTestSuiteHNK.SETRANGE("RT Pack FND",true);
        // if CALTestSuiteHNK.FINDSET(false,false) then repeat
        //   CALTestLineHNK.RESET;
        //   CALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
        //   CALTestLineHNK.SETRANGE("Test Suite",CALTestSuiteHNK.Name);
        //   CALTestLineHNK.SETRANGE("RT Pack FND",true);
        // CALTestLineHNK.SETRANGE(Run,true);
        // if CALTestLineHNK.FINDSET(false,false) then
        // CALTestMgtHNK.RunSelected(CALTestLineHNK);
        // until CALTestSuiteHNK.NEXT =0;

        CALTestSuite.RESET();
        CALTestSuite.SETCURRENTKEY("RT Pack FND");
        CALTestSuite.SETRANGE("RT Pack FND", true);
        if CALTestSuite.FINDSET(false) then
            repeat
                CALTestLine.RESET();
                CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
                CALTestLine.SETRANGE("Test Suite", CALTestSuite.Name);
                CALTestLine.SETRANGE("RT Pack FND", true);
                CALTestLine.SETRANGE(Run, true);
                if CALTestLine.FINDSET(false) then
                    CALTestMgt.RunSelected(CALTestLine);
            until CALTestSuite.NEXT() = 0;
        // BC UPGRADE PATELS08 <<
    end;

    procedure GetRTLines(pInputText: Text[50]);
    var
        // BC UPGRADE PATELS08 >> # Changed subtype from custom to inbuilt Record.
        // CALTestLine : Record "CAL Test Line HNK";
        CALTestLine: Record "CAL Test Line";
        // BC UPGRADE PATELS08 <<

        CALTestResultSummary: Report "CAL Test Summary CBN";
        FileName: Text;
        FilePath1: Text;
    begin
        FileName := TENANTID() + '_' + COMPANYNAME + '_TestResult.pdf';
        FilePath1 := FilePath + FileName;

        // BC UPGRADE PATELS08 >> # Blocked as DeleteServerFile cannot be used for Extension development and can only be used on On-Prem.
        // if FileMgt.ServerFileExists(FilePath1) then
        //     FileMgt.DeleteServerFile(FilePath1);
        // BC UPGRADE PATELS08 <<

        CALTestLine.RESET();
        CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
        CALTestLine.SETRANGE("Test Suite", 'DEFAULT');
        CALTestLine.SETRANGE("Document Reference No. FND", pInputText);

        // BC UPGRADE PATELS08 >> # Blocked code as SAVEASPDF cannot be used for Extension development and can only be used on On-Prem.
        // if CALTestLine.FINDSET(false) then
        //     REPORT.SAVEASPDF(50586, FilePath1, CALTestLine);
        // BC UPGRADE PATELS08 <<
    end;

    procedure CreateXML(p_InputText: Text[50]);
    var
        FileName: Text;
        // BC UPGRADE PATELS08 >> # Blocked because, are DOTNET variables
        // xmlWriter : DotNet "'System.Xml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Xml.XmlTextWriter";
        // EncodingText : DotNet "'mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Text.Encoding";
        // BC UPGRADE PATELS08 <<

        // BC UPGRADE PATELS08 >> # Changed variable name and type from custom to inbuilt Record.
        // CALTestLineHNK : Record "CAL Test Line HNK";
        CALTestLine: Record "CAL Test Line";
        // BC UPGRADE PATELS08 <<

        FilePath1: Text;
        Objects: Record AllObj;
        TotalErrors: Integer;
        TotalSkipped: Integer;
        TotalTests: Integer;
        TotalTime: Decimal;
        TimeDiff: Decimal;
        Duration: Decimal;
        TestCodeUnit: Integer;

        // BC UPGRADE PATELS08 >> # Changed variable name and type from custom to inbuilt Record.
        // ExistsCALTestLineHNK : Record "CAL Test Line HNK";
        ExistsCALTestLine: Record "CAL Test Line";
        // BC UPGRADE PATELS08 <<

        CALTestLineAvaliable: Boolean;
    begin
        FileName := TENANTID() + '_' + COMPANYNAME + '_TestResults.xml';
        FilePath1 := FilePath + FileName;

        // BC UPGRADE PATELS08 >> # Blocked code as DeleteServerFile cannot be used for Extension development and can only be used on On-Prem.
        // if FileMgt.ServerFileExists(FilePath1) then
        //     FileMgt.DeleteServerFile(FilePath1);
        // BC UPGRADE PATELS08 <<

        //HEI.01>>
        CALTestLineAvaliable := false;

        // BC UPGRADE PATELS08 >> # Changed variable name from ExistsCALTestLineHNK to ExistsCALTestLine.
        // ExistsCALTestLineHNK.RESET;
        // ExistsCALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
        // ExistsCALTestLineHNK.SETRANGE("Test Suite",'DEFAULT');
        // if not ExistsCALTestLineHNK.ISEMPTY then begin
        //   CALTestLineAvaliable:=true;
        // end;

        ExistsCALTestLine.RESET();
        ExistsCALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
        ExistsCALTestLine.SETRANGE("Test Suite", 'DEFAULT');
        if not ExistsCALTestLine.ISEMPTY() then begin
            CALTestLineAvaliable := true;
        end;
        // BC UPGRADE PATELS08 <<

        if CALTestLineAvaliable then begin
            //HEI.01<<
            TotalTests := 0;
            // BC UPGRADE PATELS08 >> # Changed variable name from CALTestLineHNK to CALTestLine.
            // CALTestLineHNK.RESET;
            // CALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
            // CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            // CALTestLineHNK.SETRANGE("Document Reference No. FND",p_InputText);
            // TotalTests := CALTestLineHNK.COUNT;

            // TotalErrors:=0;
            // CALTestLineHNK.RESET;
            // CALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
            // CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            // CALTestLineHNK.SETRANGE("Document Reference No. FND",p_InputText);
            // CALTestLineHNK.SETRANGE(Result,CALTestLineHNK.Result::Failure);
            // TotalErrors := CALTestLineHNK.COUNT;

            // TotalSkipped:=0;
            // CALTestLineHNK.RESET;
            // CALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
            // CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            // CALTestLineHNK.SETRANGE("Document Reference No. FND",p_InputText);
            // CALTestLineHNK.SETRANGE(Result,CALTestLineHNK.Result::Skipped);
            // TotalSkipped := CALTestLineHNK.COUNT;

            // TotalTime:=0;
            // TimeDiff:=0;

            // CALTestLineHNK.RESET;
            // CALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
            // CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            // CALTestLineHNK.SETRANGE("Document Reference No. FND",p_InputText);
            // if CALTestLineHNK.FINDSET(false,false) then repeat
            //   TimeDiff := CALTestLineHNK."Finish Time" - CALTestLineHNK."Start Time";
            //   TotalTime += TimeDiff;
            // until CALTestLineHNK.NEXT=0;

            // TestCodeUnit:=0;
            // CALTestLineHNK.RESET;
            // CALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
            // CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            // CALTestLineHNK.SETRANGE("Document Reference No. FND",p_InputText);
            // if CALTestLineHNK.FINDSET(false,false) then begin
            //   if ISNULL(xmlWriter) then
            //     xmlWriter := xmlWriter.XmlTextWriter(FilePath1, EncodingText.UTF8);
            //   xmlWriter.WriteStartDocument();
            //   //Create Parent element
            //   xmlWriter.WriteStartElement('testsuites');

            //   xmlWriter.WriteStartElement('testsuite');
            //   xmlWriter.WriteAttributeString('name','',CALTestLineHNK."Test Suite");
            //   xmlWriter.WriteAttributeString('package','','');
            //   xmlWriter.WriteAttributeString('id','','1');
            //   xmlWriter.WriteAttributeString('hostname','',FORMAT(DBDetails));//Server
            //   xmlWriter.WriteAttributeString('errors','',FORMAT(TotalErrors));
            //   xmlWriter.WriteAttributeString('tests','',FORMAT(TotalTests));
            //   xmlWriter.WriteAttributeString('failures','',FORMAT(TotalErrors));
            //   xmlWriter.WriteAttributeString('skipped','',FORMAT(TotalSkipped));
            //   xmlWriter.WriteAttributeString('time','',FORMAT(TotalTime));
            //   xmlWriter.WriteAttributeString('timestamp','',FORMAT(CALTestLineHNK."Finish Time",0,'<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>'));
            //   xmlWriter.WriteStartElement('properties');

            //   repeat
            //     //Create Child elements
            //     if (TestCodeUnit <> CALTestLineHNK."Test Codeunit") then begin
            //     xmlWriter.WriteStartElement('property');
            //     xmlWriter.WriteAttributeString('name','',FORMAT(CALTestLineHNK."Test Codeunit"));
            //     xmlWriter.WriteAttributeString('value','','');
            //     xmlWriter.WriteEndElement();
            //     end;
            //     TestCodeUnit := CALTestLineHNK."Test Codeunit";
            //   until CALTestLineHNK.NEXT = 0;
            //   xmlWriter.WriteEndElement();
            // end;

            // CALTestLineHNK.RESET;
            // CALTestLineHNK.SETCURRENTKEY("Test Suite","Line No.");
            // CALTestLineHNK.SETRANGE("Line Type", CALTestLineHNK."Line Type"::"Function");
            // CALTestLineHNK.SETRANGE("Document Reference No. FND",p_InputText);
            // if CALTestLineHNK.FINDSET(false,false) then begin
            //   repeat
            //     if Objects.GET(Objects."Object Type"::Codeunit,CALTestLineHNK."Test Codeunit") then;

            //     if FORMAT(CALTestLineHNK."Finish Time" - CALTestLineHNK."Start Time") = '' then
            //       Duration:=0
            //     else
            //       Duration :=CALTestLineHNK."Finish Time" - CALTestLineHNK."Start Time";

            //     xmlWriter.WriteStartElement('testcase');
            //     xmlWriter.WriteAttributeString('classname','',Objects."Object Name");
            //     xmlWriter.WriteAttributeString('name','',CALTestLineHNK."Function");
            //     xmlWriter.WriteAttributeString('time','',FORMAT(Duration));

            //     if CALTestLineHNK.Result = CALTestLineHNK.Result::Skipped then begin
            //       xmlWriter.WriteStartElement('skipped');
            //       xmlWriter.WriteEndElement();
            //     end;

            //     if CALTestLineHNK.Result = CALTestLineHNK.Result::Failure then begin
            //       xmlWriter.WriteStartElement('failure');
            //       xmlWriter.WriteAttributeString('message','',CALTestLineHNK."First Error");
            //       xmlWriter.WriteAttributeString('type','','');
            //       xmlWriter.WriteEndElement();
            //     end;

            //     xmlWriter.WriteEndElement();
            //   until CALTestLineHNK.NEXT = 0;

            //   xmlWriter.WriteStartElement('system-out');
            //   xmlWriter.WriteEndElement();
            //   xmlWriter.WriteStartElement('system-err');
            // end;
            // xmlWriter.WriteEndDocument();
            // xmlWriter.Close();

            CALTestLine.RESET();
            CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLine.SETRANGE("Line Type", CALTestLine."Line Type"::"Function");
            CALTestLine.SETRANGE("Document Reference No. FND", p_InputText);
            TotalTests := CALTestLine.COUNT;

            TotalErrors := 0;
            CALTestLine.RESET();
            CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLine.SETRANGE("Line Type", CALTestLine."Line Type"::"Function");
            CALTestLine.SETRANGE("Document Reference No. FND", p_InputText);
            CALTestLine.SETRANGE(Result, CALTestLine.Result::Failure);
            TotalErrors := CALTestLine.COUNT;

            TotalSkipped := 0;
            CALTestLine.RESET();
            CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLine.SETRANGE("Line Type", CALTestLine."Line Type"::"Function");
            CALTestLine.SETRANGE("Document Reference No. FND", p_InputText);
            CALTestLine.SETRANGE(Result, CALTestLine.Result::Skipped);
            TotalSkipped := CALTestLine.COUNT;

            TotalTime := 0;
            TimeDiff := 0;

            CALTestLine.RESET();
            CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLine.SETRANGE("Line Type", CALTestLine."Line Type"::"Function");
            CALTestLine.SETRANGE("Document Reference No. FND", p_InputText);
            if CALTestLine.FINDSET(false) then
                repeat
                    TimeDiff := CALTestLine."Finish Time" - CALTestLine."Start Time";
                    TotalTime += TimeDiff;
                until CALTestLine.NEXT() = 0;

            TestCodeUnit := 0;
            CALTestLine.RESET();
            CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLine.SETRANGE("Line Type", CALTestLine."Line Type"::"Function");
            CALTestLine.SETRANGE("Document Reference No. FND", p_InputText);
            if CALTestLine.FINDSET(false) then begin
                // BC UPGRADE PATELS08 >> # Blocked because xmlWriter is DOTNET variables
                // if ISNULL(xmlWriter) then
                //     xmlWriter := xmlWriter.XmlTextWriter(FilePath1, EncodingText.UTF8);
                // xmlWriter.WriteStartDocument();
                // //Create Parent element
                // xmlWriter.WriteStartElement('testsuites');

                // xmlWriter.WriteStartElement('testsuite');
                // xmlWriter.WriteAttributeString('name', '', CALTestLine."Test Suite");
                // xmlWriter.WriteAttributeString('package', '', '');
                // xmlWriter.WriteAttributeString('id', '', '1');
                // xmlWriter.WriteAttributeString('hostname', '', FORMAT(DBDetails));//Server
                // xmlWriter.WriteAttributeString('errors', '', FORMAT(TotalErrors));
                // xmlWriter.WriteAttributeString('tests', '', FORMAT(TotalTests));
                // xmlWriter.WriteAttributeString('failures', '', FORMAT(TotalErrors));
                // xmlWriter.WriteAttributeString('skipped', '', FORMAT(TotalSkipped));
                // xmlWriter.WriteAttributeString('time', '', FORMAT(TotalTime));
                // xmlWriter.WriteAttributeString('timestamp', '', FORMAT(CALTestLine."Finish Time", 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2>:<Minutes,2>:<Seconds,2>'));
                // xmlWriter.WriteStartElement('properties');
                // BC UPGRADE PATELS08 <<
                repeat
                    //Create Child elements
                    if (TestCodeUnit <> CALTestLine."Test Codeunit") then begin
                        // BC UPGRADE PATELS08 >> # Blocked because xmlWriter is DOTNET variables
                        // xmlWriter.WriteStartElement('property');
                        // xmlWriter.WriteAttributeString('name','',FORMAT(CALTestLine."Test Codeunit"));
                        // xmlWriter.WriteAttributeString('value','','');
                        // xmlWriter.WriteEndElement();
                        // BC UPGRADE PATELS08 <<
                    end;
                    TestCodeUnit := CALTestLine."Test Codeunit";
                until CALTestLine.NEXT() = 0;
                // BC UPGRADE PATELS08 >> # Blocked because xmlWriter is DOTNET variables
                // xmlWriter.WriteEndElement();
                // BC UPGRADE PATELS08 <<
            end;

            CALTestLine.RESET();
            CALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
            CALTestLine.SETRANGE("Line Type", CALTestLine."Line Type"::"Function");
            CALTestLine.SETRANGE("Document Reference No. FND", p_InputText);
            if CALTestLine.FINDSET(false) then begin
                repeat
                    if Objects.GET(Objects."Object Type"::Codeunit, CALTestLine."Test Codeunit") then;

                    if FORMAT(CALTestLine."Finish Time" - CALTestLine."Start Time") = '' then
                        Duration := 0
                    else
                        Duration := CALTestLine."Finish Time" - CALTestLine."Start Time";

                // BC UPGRADE PATELS08 >> # Blocked because xmlWriter is DOTNET variables
                // xmlWriter.WriteStartElement('testcase');
                // xmlWriter.WriteAttributeString('classname','',Objects."Object Name");
                // xmlWriter.WriteAttributeString('name','',CALTestLine."Function");
                // xmlWriter.WriteAttributeString('time','',FORMAT(Duration));

                // if CALTestLine.Result = CALTestLine.Result::Skipped then begin
                //   xmlWriter.WriteStartElement('skipped');
                //   xmlWriter.WriteEndElement();
                // end;

                // if CALTestLine.Result = CALTestLine.Result::Failure then begin
                //   xmlWriter.WriteStartElement('failure');
                //   xmlWriter.WriteAttributeString('message','',CALTestLine."First Error");
                //   xmlWriter.WriteAttributeString('type','','');
                //   xmlWriter.WriteEndElement();
                // end;

                // xmlWriter.WriteEndElement();
                // BC UPGRADE PATELS08 <<
                until CALTestLine.NEXT() = 0;

                // BC UPGRADE PATELS08 >> # Blocked because xmlWriter is DOTNET variables
                // xmlWriter.WriteStartElement('system-out');
                // xmlWriter.WriteEndElement();
                // xmlWriter.WriteStartElement('system-err');
                // BC UPGRADE PATELS08 <<
            end;

            // BC UPGRADE PATELS08 >> # Blocked because xmlWriter is DOTNET variables
            // xmlWriter.WriteEndDocument();
            // xmlWriter.Close();
            // BC UPGRADE PATELS08 <<

            // BC UPGRADE PATELS08 <<



            //HEI.01>>
        end;
        //HEI.01<<
    end;

    procedure ExportCALTestText(pInputText: Text[50]);
    var
        // BC UPGRADE PATELS08 >> # Changed subtype from custom to inbuilt Record.
        // CALTestLine: Record "CAL Test Line HNK";
        CALTestLine: Record "CAL Test Line";
        // BC UPGRADE PATELS08 <<

        CALTestResultSummary: Report "CAL Test Summary CBN";

        FileName: Text;
        FilePath1: Text;
        File1: File;
        OutStreamObj: OutStream;
        Result: Code[10];
        // BC UPGRADE PATELS08 >> # Changed variable name and type from custom to inbuilt Record.
        // ExistsCALTestLineHNK: Record "CAL Test Line HNK";
        ExistsCALTestLine: Record "CAL Test Line";
        // BC UPGRADE PATELS08 <<
        CALTestLineAvaliable: Boolean;
    begin
        FileName := TENANTID() + '_' + COMPANYNAME + '_TestResult.txt';
        FilePath1 := FilePath + FileName;

        // BC UPGRADE PATELS08 >> # Blocked as DeleteServerFile cannot be used for Extension development and can only be used on On-Prem.
        // if FileMgt.ServerFileExists(FilePath1) then
        //     FileMgt.DeleteServerFile(FilePath1);
        // BC UPGRADE PATELS08 <<

        //HEI.01>>
        CALTestLineAvaliable := false;

        // BC UPGRADE PATELS08 >> # Changed variable name from ExistsCALTestLineHNK to ExistsCALTestLine.
        // ExistsCALTestLineHNK.RESET;
        // ExistsCALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
        // ExistsCALTestLineHNK.SETRANGE("Test Suite", 'DEFAULT');
        // if not ExistsCALTestLineHNK.ISEMPTY then begin
        //     CALTestLineAvaliable := true;
        // end;

        ExistsCALTestLine.RESET;
        ExistsCALTestLine.SETCURRENTKEY("Test Suite", "Line No.");
        ExistsCALTestLine.SETRANGE("Test Suite", 'DEFAULT');
        if not ExistsCALTestLine.ISEMPTY then begin
            CALTestLineAvaliable := true;
        end;

        // BC UPGRADE PATELS08 <<

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

        // BC UPGRADE PATELS08 >> # Blocked as CREATE, CREATEOUTSTREAM, ClOSE cannot be used for Extension development and can only be used on On-Prem.
        // File1.CREATE(FilePath1);
        // File1.CREATEOUTSTREAM(OutStreamObj);
        OutStreamObj.WRITETEXT(Result);
        // File1.CLOSE;
        // BC UPGRADE PATELS08 <<
    end;

    procedure ExecuteAutoCALTest(
    // BC UPGRADE PATELS08 >> # Blocked code because uses DOTNET variables
    // pCUArgument: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String"
    // BC UPGRADE PATELS08 <<
    );
    var
        // BC UPGRADE PATELS08 >> # Changed variable subtype from custom to inbuilt Record.
        // CALTestSuite: Record "CAL Test Suite HNK";
        CALTestSuite: Record "CAL Test Suite";
        // BC UPGRADE PATELS08 <<

        // BC UPGRADE PATELS08 >> # Blocked code because uses DOTNET variables
        // StringArrayValues: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
        // Seperator: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
        // BC UPGRADE PATELS08 <<
        CRLF: Text;
        InputText: Text[50];
    begin

        // BC UPGRADE PATELS08 >> # Blocked code because uses DOTNET variables
        // Seperator := ',';
        // pCUArgument := pCUArgument.Normalize();
        // StringArrayValues := pCUArgument.Split(Seperator.ToCharArray);
        // BC UPGRADE PATELS08 <<

        CRLF[1] := 10;
        CRLF[2] := 13;

        // BC UPGRADE PATELS08 >> # Blocked code because uses DOTNET variables
        // InputText := DELCHR(StringArrayValues.GetValue(0), '<>', CRLF);
        // FilePath := DELCHR(StringArrayValues.GetValue(1), '<>', CRLF);
        // DBDetails := DELCHR(StringArrayValues.GetValue(2), '<>', CRLF); //>>HNK VORGIM01
        // BC UPGRADE PATELS08 <<

        //HEI.01>>
        //CreateUnitTestData;
        //COMMIT;
        GetTestCodeUnits(InputText);
        RunRTPack();
        GetRTLines(InputText);
        CreateXML(InputText);
        ExportCALTestText(InputText);
        //HEI.01<<
    end;

    procedure ExecuteAutoCALTestACC();
    var
        // BC UPGRADE PATELS08 >> # Changed variable subtype from custom to inbuilt Record.
        // CALTestSuite: Record "CAL Test Suite HNK";
        CALTestSuite: Record "CAL Test Suite";
        // BC UPGRADE PATELS08 <<

        // BC UPGRADE PATELS08 >> # Blocked because, are DOTNET variables
        // StringArrayValues: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
        // Seperator: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
        // BC UPGRADE PATELS08 <<

        CRLF: Text;
        InputText: Text[50];
    begin

        RunRTPackACC();
    end;

    local procedure CreateUnitTestData();
    var
        UnitTestValue: Record "Unit Testing Value FND";
        SetUnitValueMTC: Report "Create Unit Testing Val MtC";
        SetUnitValueRTR: Report "Create Unit Testing Val. - RTR";
        SetUnitValueSTP: Report "Create Unit Testing Val StP";
        SetUnitValueDTW: Report "Create Unit Testing Values DtW";
    begin

        GenLedSetup.GET();
        GenLedSetup."Allow Posting To" := (CALCDATE('<CY>', WORKDATE()));
        GenLedSetup.MODIFY();
        COMMIT();

        UnitTestValue.RESET();
        if not UnitTestValue.ISEMPTY then
            UnitTestValue.DELETEALL(true);

        COMMIT();



        SetUnitValueMTC.SetParameters(true, true, true, true);
        SetUnitValueMTC.RUN;
        /*
        SetUnitValueDTW.SetParameters(TRUE,TRUE,TRUE,TRUE);
        SetUnitValueDTW.RUN;
        
        SetUnitValueRTR.SetParameters(TRUE,TRUE,TRUE,TRUE);
        SetUnitValueRTR.RUN;
        
        SetUnitValueSTP.SetParameters(TRUE,TRUE,TRUE,TRUE);
        SetUnitValueSTP.RUN;
        */

    end;

    procedure ConfigureTestScripts(
    // BC UPGRADE PATELS08 >> # Blocked code because uses DOTNET variables
    // pCUArgument: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String"
    // BC UPGRADE PATELS08 <<
    );
    var
        // BC UPGRADE PATELS08 >> # Changed variable subtype from custom to inbuilt Record. 
        // CALTestSuite: Record "CAL Test Suite HNK";
        CALTestSuite: Record "CAL Test Suite";
        // BC UPGRADE PATELS08 <<

        // BC UPGRADE PATELS08 >> # Blocked because, are DOTNET variables
        // StringArrayValues: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
        // Seperator: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
        // BC UPGRADE PATELS08 <<
        CRLF: Text;
        InputText: Text[50];
    begin
        // BC UPGRADE PATELS08 >> # Blocked code because uses DOTNET variables
        // Seperator := ',';
        // pCUArgument := pCUArgument.Normalize();
        // StringArrayValues := pCUArgument.Split(Seperator.ToCharArray);
        // BC UPGRADE PATELS08 <<

        CRLF[1] := 10;
        CRLF[2] := 13;

        // BC UPGRADE PATELS08 >> # Blocked code because uses DOTNET variables
        // InputText := DELCHR(StringArrayValues.GetValue(0), '<>', CRLF);
        // FilePath := DELCHR(StringArrayValues.GetValue(1), '<>', CRLF);
        // DBDetails := DELCHR(StringArrayValues.GetValue(2), '<>', CRLF); //>>HNK VORGIM01
        // BC UPGRADE PATELS08 <<


        CreateUnitTestData();
        COMMIT();
        GetTestCodeUnits(InputText);
    end;

    procedure GenerateOutputTS(
    // pCUArgument: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String" // BC UPGRADE PATELS08 - Blocked code as this is DOTNET variable
    );
    var
        // BC UPGRADE PATELS08 >> # Blocked because, are DOTNET variables
        // CALTestSuite: Record "CAL Test Suite HNK";
        // StringArrayValues: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Array";
        // Seperator: DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.String";
        // BC UPGRADE PATELS08 <<

        CRLF: Text;
        InputText: Text[50];
    begin
        // BC UPGRADE PATELS08 >> Blocked code because uses DOTNET variables
        // Seperator := ',';
        // pCUArgument := pCUArgument.Normalize();
        // StringArrayValues := pCUArgument.Split(Seperator.ToCharArray);
        // BC UPGRADE PATELS08 <<

        CRLF[1] := 10;
        CRLF[2] := 13;

        // BC UPGRADE PATELS08 >> Blocked code because uses DOTNET variables
        // InputText := DELCHR(StringArrayValues.GetValue(0), '<>', CRLF);
        // FilePath := DELCHR(StringArrayValues.GetValue(1), '<>', CRLF);
        // DBDetails := DELCHR(StringArrayValues.GetValue(2), '<>', CRLF);
        // BC UPGRADE PATELS08 <<

        GetRTLines(InputText);
        CreateXML(InputText);
        ExportCALTestText(InputText);
    end;
}

