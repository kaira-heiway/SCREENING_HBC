codeunit 51038 "GL Bulk Application Post CBN"
{
    // HEI.01 CHG2317671 IBM POENAB02 08.10.2025 HB2428 Excel Mapping Report IBM tool for closing GL entries for GL Account with big volume of data
    //   # Object created
    // HEI.02 CHG2338202 IBM POENAB02 08.01.2026 Optimization needed for GL Mass Clearing report
    //   # Optimization for Bulk Application Tool

    // BC UPGRADE PATELS08 >>
    // # Created Codeunit
    // # Nav ID : 50234
    // BC UPGRADE PATELS08 <<

    Permissions =
    TableData "G/L Entry"=rim;

    SingleInstance = false;

    var
        GLBulkApplication : Record "GL Bulk Application FND";
        GLBulkApplicationTMP : Record "GL Bulk Application FND" temporary;
        ErrorText : Text;
        NoOfPostedCombinations : Integer;
        NoOfSkippedCombinations: Integer;
        Progress: Integer;
        Window: Dialog;
        NoOfRecords: Integer;
        RecordNo: Integer;
        NewProgress: Integer;
        Text50000: Label 'Posting is finished!\\ %1 Combinations were posted!\ %2 Combinations were skipped!';
        Text50001: Label 'There is nothing to post!';
        Text50002: Label 'Applying entries  @1@@@@@@@@@@@@@';
        GLBulkApplicationPostGroup: Codeunit "GL Bulk App-Post Group CBN";


    trigger OnRun()
    begin
        NoOfPostedCombinations := 0;
        NoOfSkippedCombinations := 0;
        NoOfRecords := 0;
        RecordNo := 0;
        GLBulkApplicationTMP.DELETEALL;

        GLBulkApplication.RESET;
        IF GLBulkApplication.FINDSET(FALSE) THEN
        REPEAT
            GLBulkApplicationTMP.RESET;
            GLBulkApplicationTMP.SETCURRENTKEY("Application Combination"); //HEI.02
            GLBulkApplicationTMP.SETRANGE("Application Combination",GLBulkApplication."Application Combination");
            IF NOT GLBulkApplicationTMP.FINDFIRST THEN
            BEGIN
                GLBulkApplicationTMP.TRANSFERFIELDS(GLBulkApplication);
                IF GLBulkApplicationTMP.INSERT THEN;
                NoOfRecords += 1;
            END;
        UNTIL GLBulkApplication.NEXT = 0
        ELSE
            BEGIN
            IF GUIALLOWED THEN
                MESSAGE(Text50001);
            EXIT;
            END;

        IF NoOfRecords <> 0 THEN
        IF GUIALLOWED THEN
            Window.OPEN(Text50002);
        GLBulkApplicationTMP.RESET;
        IF GLBulkApplicationTMP.FINDSET(FALSE) THEN
        REPEAT
            RecordNo += 1;
            CLEARLASTERROR;
            GLBulkApplicationPostGroup.SetApplicationCombination(GLBulkApplicationTMP."Application Combination");
            IF GLBulkApplicationPostGroup.RUN THEN;
            NewProgress := ROUND(RecordNo / NoOfRecords * 100,1);
            IF GUIALLOWED THEN
            Window.UPDATE(1,NewProgress * 100);
            ErrorText := GETLASTERRORTEXT;
            IF ErrorText <> '' THEN
            BEGIN
                IF STRLEN(ErrorText) < 251 THEN
                GLBulkApplicationTMP."Error Message" := COPYSTR(ErrorText,1,250)
                ELSE
                BEGIN
                    GLBulkApplicationTMP."Error Message" := COPYSTR(ErrorText,1,250);
                    IF STRLEN(ErrorText) < 501 THEN
                    GLBulkApplicationTMP."Error Message 2" := COPYSTR(ErrorText,251,STRLEN(ErrorText)-250)
                    ELSE
                        GLBulkApplicationTMP."Error Message 2" := COPYSTR(ErrorText,251,250);
                END;
                GLBulkApplicationTMP.MODIFY;

                GLBulkApplication.RESET;
                GLBulkApplication.SETCURRENTKEY("Application Combination"); //HEI.02
                GLBulkApplication.SETRANGE("Application Combination",GLBulkApplicationTMP."Application Combination");
                //HEI.02>>
                // {
                // IF GLBulkApplication.FINDSET(TRUE) THEN
                // REPEAT
                //     GLBulkApplication.MODIFYALL("Error Message",GLBulkApplicationTMP."Error Message");
                //     GLBulkApplication.MODIFYALL("Error Message 2",GLBulkApplicationTMP."Error Message 2");
                // UNTIL GLBulkApplication.NEXT = 0;
                // }
                GLBulkApplication.MODIFYALL("Error Message",GLBulkApplicationTMP."Error Message");
                GLBulkApplication.MODIFYALL("Error Message 2",GLBulkApplicationTMP."Error Message 2");
                //HEI.02<<
            END;
            COMMIT();
        UNTIL GLBulkApplicationTMP.NEXT = 0;

        IF NoOfRecords <> 0 THEN
        IF GUIALLOWED THEN
            Window.CLOSE;

        GLBulkApplicationTMP.RESET;
        GLBulkApplicationTMP.SETCURRENTKEY("Error Message");
        //HEI.02>>
        //GLBulkApplicationTMP.SETFILTER("Error Message",'=%1','');
        GLBulkApplicationTMP.SETRANGE("Error Message",'');
        //HEI.02<<
        NoOfPostedCombinations := GLBulkApplicationTMP.COUNT;

        GLBulkApplicationTMP.RESET;
        GLBulkApplicationTMP.SETCURRENTKEY("Error Message");
        GLBulkApplicationTMP.SETFILTER("Error Message",'<>%1','');
        NoOfSkippedCombinations := GLBulkApplicationTMP.COUNT;

        GLBulkApplication.RESET;
        GLBulkApplication.SETCURRENTKEY("Error Message");
        //HEI.02>>
        //GLBulkApplication.SETFILTER("Error Message",'=%1','');
        GLBulkApplication.SETRANGE("Error Message",'');
        //HEI.02<<
        GLBulkApplication.DELETEALL;

        IF GUIALLOWED THEN
        MESSAGE(Text50000,NoOfPostedCombinations,NoOfSkippedCombinations);

        GLBulkApplicationTMP.DELETEALL;

    end;
}
