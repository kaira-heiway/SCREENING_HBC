namespace General.General;
using System.TestTools.TestRunner;
using System.Reflection;

codeunit 51030 TestScriptsBCUpgradeCBN
{

    //Bc Upgrade KAPOOV01 Created new CU for Test Scripts Custom functions.

    //Bc Upgrade KAPOOV01 CU-130400-"CAL Test Runner" begin >>

    //BC Upgrade KAPOOV01 CU-130400-"CAL Test Runner"-HEI.02,HEI.04 #Created new function -OnBeforeRunTests & Subscribed to event-OnBeforeRunTests of function-RunTests() >>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CAL Test Runner", 'OnBeforeRunTests', '', false, false)]
    local procedure OnBeforeRunTests(var CALTestLine: Record "CAL Test Line")
    var
        UnitTestingValue: Record "Unit Testing Value FND";
        CALTestLineFunction: Record "CAL Test Line"; //BC Upgrade KAPOOV01
        RT_Pack: Text[10]; //BC Upgrade KAPOOV01
        CALTestMgt: Codeunit "CAL Test Management"; //BC Upgrade KAPOOV01
    begin
        //HEI.04>>
        UnitTestingValue.SkipTestScriptExecutionPROD();
        //HEI.04<<

        IF CALTestMgt.ISPUBLISHMODE THEN  //BC Upgrade KAPOOV01
            //HEI.02>>
            RT_Pack := COPYSTR(CALTestLineFunction."Function", 1, 3);
        IF RT_Pack = 'RT_' THEN
            CALTestLineFunction."RT Pack FND" := TRUE;
        //HEI.02<<

    end;
    //BC Upgrade KAPOOV01 CU-130400-"CAL Test Runner"-HEI.02,HEI.04 #Created new function -OnBeforeRunTests & Subscribed to event-OnBeforeRunTests of function-RunTests() >>
    //Bc Upgrade KAPOOV01 CU-130400-"CAL Test Runner" end <<

    //Bc Upgrade KAPOOV01 CU-50192-"CAL Test Management HNK" added new function- AddTestLineHNK()  >>
    procedure AddTestLineHNK(TestSuiteName: Code[10]; TestCodeunitId: Integer; FunctionName: Text[128]; RTPack: Boolean; InputText: Text);
    var
        CALTestLine: Record "CAL Test Line";
        AllObj: Record "AllObj";
        //"Object": Record "Object";  //BC UPGRADE KAPOOV01 cannot use table- Object as scope is OmPrem
        CodeunitIsValid: Boolean;
        LineNo: Integer;
    begin
        //>>HEI.02
        CALTestLine.RESET;
        //CALTestLine.SETCURRENTKEY("Test Codeunit","Test Suite");//HEI.29
        CALTestLine.SETRANGE("Test Suite", TestSuiteName);
        IF CALTestLine.FINDLAST THEN
            LineNo := CALTestLine."Line No." + 10000
        ELSE BEGIN
            LineNo := 10000;
        END;

        CALTestLine.RESET;
        CALTestLine.SETCURRENTKEY("Test Codeunit", "Test Suite");
        CALTestLine.SETRANGE("Test Suite", TestSuiteName);
        CALTestLine.SETRANGE("Test Codeunit", TestCodeunitId);
        CALTestLine.SETRANGE("Line Type", CALTestLine."Line Type"::Codeunit);
        IF NOT CALTestLine.FINDFIRST THEN BEGIN
            CALTestLine.INIT;
            CALTestLine.VALIDATE("Test Suite", TestSuiteName);
            CALTestLine.VALIDATE("Line No.", LineNo);
            CALTestLine.VALIDATE("Line Type", CALTestLine."Line Type"::Codeunit);
            CALTestLine.VALIDATE("Test Codeunit", TestCodeunitId);
            CALTestLine.VALIDATE(Level, 1);
            CALTestLine.VALIDATE("Document Reference No. FND", InputText);
            CALTestLine.VALIDATE(Run, TRUE);
            CALTestLine.INSERT(FALSE);
            LineNo := LineNo + 10000;

            CALTestLine.INIT;
            CALTestLine.VALIDATE("Test Suite", TestSuiteName);
            CALTestLine.VALIDATE("Line No.", LineNo);
            CALTestLine.VALIDATE("Line Type", CALTestLine."Line Type"::"Function");
            CALTestLine.VALIDATE("Test Codeunit", TestCodeunitId);
            CALTestLine.VALIDATE("Document Reference No. FND", InputText);
            CALTestLine.VALIDATE(Level, 2);
            CALTestLine.VALIDATE("Function", FunctionName);
            CALTestLine.VALIDATE("RT Pack FND", RTPack);
            CALTestLine.VALIDATE(Run, TRUE);
            CALTestLine.INSERT(FALSE);
        END ELSE BEGIN
            CALTestLine.INIT;
            CALTestLine.VALIDATE("Test Suite", TestSuiteName);
            CALTestLine.VALIDATE("Line No.", LineNo);
            CALTestLine.VALIDATE("Line Type", CALTestLine."Line Type"::"Function");
            CALTestLine.VALIDATE("Test Codeunit", TestCodeunitId);
            CALTestLine.VALIDATE("Document Reference No. FND", InputText);
            CALTestLine.VALIDATE(Level, 2);
            CALTestLine.VALIDATE("Function", FunctionName);
            CALTestLine.VALIDATE("RT Pack FND", RTPack);
            CALTestLine.VALIDATE(Run, TRUE);
            CALTestLine.INSERT(FALSE);
        END;
        //<<HEI.02
    end;
    //Bc Upgrade KAPOOV01 CU-50192-"CAL Test Management HNK" added new function- AddTestLineHNK() <<

    //Bc Upgrade KAPOOV01 CU-50192-"CAL Test Management HNK" added new function- SkipTestLineHNK()  >>

    procedure SkipTestLineHNK(TestSuiteName: Code[10]; TestCodeunitId: Integer; FunctionName: Text[128]; RTPack: Boolean; InputText: Text);
    var
        CALTestLine: Record "CAL Test Line";
    begin
        //>>HEI.02
        CALTestLine.RESET;
        CALTestLine.SETCURRENTKEY("Test Codeunit", "Test Suite");
        CALTestLine.SETRANGE("Test Suite", TestSuiteName);
        CALTestLine.SETRANGE("Test Codeunit", TestCodeunitId);
        CALTestLine.SETRANGE("Function", FunctionName);
        CALTestLine.SETRANGE("Document Reference No. FND", InputText);
        IF CALTestLine.FINDFIRST THEN BEGIN
            CALTestLine.VALIDATE(Run, FALSE);
            CALTestLine.MODIFY(TRUE);
        END;
        //<<HEI.02
    end;
    //BC Upgrade KAPOOV01 CU-50192-"CAL Test Management HNK" added new function- SkipTestLineHNK()  <<


}
