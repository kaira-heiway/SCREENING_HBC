codeunit 58129 "Automate CAL Test Script"
{
    // version GIT,HEI.05

    // HEI.01 RITM2957851 IBM SAXENA03 09/03/2022
    //   # CodeUnit is developed to RUN Test CAL functions aumatically from Powershell
    // HEI.02 RITM2964345 IBM SAXENA03 01/04/2022
    //   # Code Commented/ Uncommented.
    //   # Calling RunRTPackACC function from OnRun( )
    //   # Added Db Details in CreateXMl Function()
    //   # fix the incorrect paramter in GetValue()
    //   # Added Code to Execute CAL Test for All test Suites where RT Pack is TRUE
    //   # Added Code to run reports.
    //   # Added Code to RUN Test Script Reports only for STREAM for which RT PACK field is TRUE in CAL Test Suite Table.
    // HEI.03 RITM2964345 IBM SAXENA03 08/04/2022
    //   # Added Code to RUN Unit Test Values Reports without any TestSuite Filter
    //   # Added Code to RUN Test Scripts only for Suite name "RT SET"
    // HEI.04 RITM2964345 IBM SAXENA03 04/05/2022
    //   # Feature added to add test scrips in test automatically while execution; Function Name GetTestCodeUnits().
    //   # Feature added to Get Unique Test Number from a Text file; Function Name GetUniqueTestNumber() .
    //   # Feature added to GET Test Script Results and export EXCEL File ,function Name GetRTLines().
    // HEI.05 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    // BC Upgrade PATELP08 >> 
    // # Replaced Custom Records, reports and codeunits with standard ones.
    // # removed 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
    // # Blocked The application objects or methods 'Open', 'CREATEINSTREAM', 'CLOSE', 'DeleteServerFile', 'SAVEASEXCEL' because it has scope 'OnPrem' and cannot be used for 'Extension' development
    // # Old Object ID- 50182.
    // # Moved Test Script CU to INT Extension.
    // BC Upgrade PATELP08 <<

    trigger OnRun();
    begin
        //>>HEI.02
        RunRTPackACC();
        //<<HEI.02
    end;

    var
        GITSetup: Record "GIT Version Setup FND";
        FilePath: Text;
        FileMgt: Codeunit "File Management";
        DBDetails: Text;
        UniqueTestNum: Text;

    procedure RunRTPackACC();
    var
        // BC Upgrade PATELP08 >>Replaced Custom Test Script Object with Standard Test Script Object.
        //CALTestLineHNK : Record "CAL Test Line HNK";
        CALTestLineHNK: Record "CAL Test Line";
        //CALTestMgtHNK : Codeunit "CAL Test Management HNK";
        CALTestMgtHNK: Codeunit "CAL Test Management";
        //CALTestSuiteHNK : Record "CAL Test Suite HNK";
        CALTestSuiteHNK: Record "CAL Test Suite";
    // BC Upgrade PATELP08 <<
    begin
        //>>HEI.02
        CreateUnitTestData();

        //HEI.04>>
        FilePath := '\\145.47.94.228\interface\TestScripts\';
        GetUniqueTestNumber();
        GetTestCodeUnits();
        //HEI.04<<

        CALTestSuiteHNK.RESET();
        //HEI.03>>
        //CALTestSuiteHNK.SETCURRENTKEY("RT Pack");
        //CALTestSuiteHNK.SETRANGE("RT Pack",TRUE);
        CALTestSuiteHNK.SETCURRENTKEY(Name);
        CALTestSuiteHNK.SETRANGE(Name, 'DEFAULT');
        //CALTestSuiteHNK.SETRANGE(Name,'RT_RTR');
        //HEI.03<<
        // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
        //if CALTestSuiteHNK.FINDSET(false,false) then repeat
        if CALTestSuiteHNK.FINDSET(false) then
            repeat
                // BC Upgrade PATELP08 <<
                //<<HEI.02
                CALTestLineHNK.RESET();
                CALTestLineHNK.SETCURRENTKEY("Test Suite", "Line No.");
                //>>HEI.02
                //CALTestLineHNK.SETFILTER("Test Suite",'<>%1','DEFAULT');
                CALTestLineHNK.SETRANGE("Test Suite", CALTestSuiteHNK.Name);
                //<<HEI.02
                //HEI.03>>
                //CALTestLineHNK.SETRANGE("RT Pack",TRUE);
                //HEI.03<<
                CALTestLineHNK.SETRANGE(Run, true);
                // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
                //if CALTestLineHNK.FINDSET(false,false) then
                if CALTestLineHNK.FINDSET(false) then
                    // BC Upgrade PATELP08 <<
                    CALTestMgtHNK.RunSelected(CALTestLineHNK);
            //>>HEI.02
            until CALTestSuiteHNK.NEXT() = 0;
        //<<HEI.02
        //HEI.04>>
        GetRTLines(UniqueTestNum);
        //HEI.04<<
    end;

    local procedure CreateUnitTestData();
    var
        // BC Upgrade PATELP08 >> Replaced Custom Test Script Object with Standard Test Script Object
        UnitTestValue: Record "Unit Testing Value FND";
        SetUnitValueMTC: Report "Create Unit Testing Val MtC";
        SetUnitValueRTR: Report "Create Unit Testing Val. - RTR";
        SetUnitValueSTP: Report "Create Unit Testing Val StP";
        SetUnitValueDTW: Report "Create Unit Testing Values DtW";
        //CALTestSuiteHNK : Record "CAL Test Suite HNK";
        CALTestSuiteHNK: Record "CAL Test Suite";
    // BC Upgrade PATELP08 <<
    begin
        UnitTestValue.RESET();
        if not UnitTestValue.ISEMPTY then
            UnitTestValue.DELETEALL(true);

        COMMIT();

        //HEI.03>>
        //HEI.02>>
        // CALTestSuiteHNK.RESET;
        // CALTestSuiteHNK.SETCURRENTKEY(Name);
        // CALTestSuiteHNK.SETRANGE(Name,'RT_MTC');
        // CALTestSuiteHNK.SETRANGE("RT Pack",TRUE);
        // IF CALTestSuiteHNK.FINDFIRST THEN BEGIN
        //HEI.02<<
        //HEI.03<<
        SetUnitValueMTC.SetParameters(true, true, true, true);
        SetUnitValueMTC.RUN;
        COMMIT();
        //HEI.03>>
        //HEI.02>>
        //END;
        //HEI.02<<
        //HEI.03<<

        //HEI.03>>
        //HEI.02>>
        // CALTestSuiteHNK.RESET;
        // CALTestSuiteHNK.SETCURRENTKEY(Name);
        // CALTestSuiteHNK.SETRANGE(Name,'RT_DTW');
        // CALTestSuiteHNK.SETRANGE("RT Pack",TRUE);
        // IF CALTestSuiteHNK.FINDFIRST THEN BEGIN
        //HEI.02<<
        //HEI.03<<
        //  SetUnitValueDTW.SetParameters(TRUE,TRUE,TRUE,TRUE);
        //  SetUnitValueDTW.RUN;
        //  COMMIT;
        //HEI.03>>
        //HEI.02>>
        //END;
        //HEI.02<<
        //HEI.03<<

        //HEI.03>>
        //HEI.02>>
        // CALTestSuiteHNK.RESET;
        // CALTestSuiteHNK.SETCURRENTKEY(Name);
        // CALTestSuiteHNK.SETRANGE(Name,'RT_RTR');
        // CALTestSuiteHNK.SETRANGE("RT Pack",TRUE);
        // IF CALTestSuiteHNK.FINDFIRST THEN BEGIN
        //HEI.02<<
        //HEI.03<<
        SetUnitValueRTR.SetParameters(true, true, true, true);
        SetUnitValueRTR.RUN;
        COMMIT();
        //HEI.03>>
        //HEI.02>>
        //END;
        //HEI.02<<
        //HEI.03<<

        //HEI.03>>
        //HEI.02>>
        // CALTestSuiteHNK.RESET;
        // CALTestSuiteHNK.SETCURRENTKEY(Name);
        // CALTestSuiteHNK.SETRANGE(Name,'RT_STP');
        // CALTestSuiteHNK.SETRANGE("RT Pack",TRUE);
        // IF CALTestSuiteHNK.FINDFIRST THEN BEGIN
        //HEI.02<<
        //HEI.03<<
        SetUnitValueSTP.SetParameters(true, true, true, true);
        SetUnitValueSTP.RUN;
        COMMIT();
        //HEI.03>>
        //HEI.02>>
        //END;
        //HEI.02<<
        //HEI.03<<
    end;

    procedure GetTestCodeUnits();
    var
        CALTestScriptConfig: Codeunit "CAL Test Script RT CBN";
    begin
        //HEI.04>>
        CALTestScriptConfig.SetDocRef(UniqueTestNum);
        CALTestScriptConfig.TestScripts('DEFAULT');
        //HEI.04<<
    end;

    local procedure GetUniqueTestNumber();
    var
        InStreamObj: InStream;
        Buffer: Text;
        TXTFile: File;
        TXTFileName: Text;
    begin
        //HEI.04>>
        TXTFileName := FilePath + 'DocRefNum.txt';
        //TXTFile.OPEN('\\145.47.94.228\interface\TestScripts\DocRefNum.txt');
        // BC Upgrade PATELP08 >> Blocking this because The application object or method 'Open' and 'CREATEINSTREAM' has scope 'OnPrem' and cannot be used for 'Extension' development
        // TXTFile.OPEN(TXTFileName);
        // TXTFile.CREATEINSTREAM(InStreamObj);
        // BC Upgrade PATELP08 <<
        while not InStreamObj.EOS do begin
            InStreamObj.READTEXT(Buffer);
            // Do some processing.
            UniqueTestNum := Buffer;
            //MESSAGE('Unique Test Number: %1', UniqueTestNum);
        end;
        // BC Upgrade PATELP08 >> Blocking this because The application object or method 'CLOSE' has scope 'OnPrem' and cannot be used for 'Extension' development
        //TXTFile.CLOSE;
        // BC Upgrade PATELP08 <<
        //HEI.04<<
    end;

    procedure GetRTLines(pInputText: Text[50]);
    var
        // BC Upgrade PATELP08 >>Replaced Custom Test Script Object with Standard Test Script Object.
        //CALTestLine : Record "CAL Test Line HNK";
        CALTestLine: Record "CAL Test Line";
        // BC Upgrade PATELP08 <<
        CALTestResultSummary: Report "CAL Test Summary CBN";
        FileName: Text;
        FilePath1: Text;
        ExportFileName: Text;
    begin
        //HEI.04>>
        ExportFileName := TENANTID() + '_' + COMPANYNAME + '_TestResult.xls';
        FilePath1 := FilePath + ExportFileName;

        if FileMgt.ServerFileExists(FilePath1) then
            // BC Upgrade PATELP08 >> Blocking this because The application object or method 'DeleteServerFile' has scope 'OnPrem' and cannot be used for 'Extension' development
            //FileMgt.DeleteServerFile(FilePath1);
            // BC Upgrade PATELP08 <<

            CALTestLine.RESET();
        CALTestLine.SETCURRENTKEY(Name, "Document Reference No. FND");
        CALTestLine.SETRANGE("Test Suite", 'DEFAULT');
        CALTestLine.SETRANGE("Document Reference No. FND", pInputText);
        // BC Upgrade PATELP08 >> removing 2nd parameter(false) because 'FindSet' has been deprecated because the parameter 'UpdateKey' is not used by the runtime, Use the overload without the 'UpdateKey' parameter instead to avoid warning and future error.
        //if CALTestLine.FINDSET(false,false) then
        // BC Upgrade PATELP08 >> Blocking this as there is no code in if statement for removing syntax
        if CALTestLine.FINDSET(false) then; // BC Upgrade PATELP08 >> added ';' for removing syntax error remove in future if any code added in this if statement.
                                            // BC Upgrade PATELP08 <<
                                            // BC Upgrade PATELP08 >> Blocking this because The application object or method 'SAVEASEXCEL' has scope 'OnPrem' and cannot be used for 'Extension' development
                                            //REPORT.SAVEASEXCEL(50587,FilePath1,CALTestLine);
                                            // BC Upgrade PATELP08 <<
                                            //HEI.04<<
    end;
}


