tableextension 50226 CALTestResultExtFND extends "CAL Test Result"
{
    // version NAVW19.00

    // HEI.01 RITM2822071 IBM BULIMC01 07/10/2021 #new object created for HNK license
    // HEI.02 RITM2923302 IBM SAXENA03 11/02/2022
    //   # Added new field "Suite Name" in Table.
    //   # Added new field "Document Reference No." in Table.
    //   # Created a new Function named as Initilized2 to init  new fields "Suite Name" & "Document Reference No.".
    //   # Remove SuiteName parameter from Function Initialize().
    // HEI.03 CHG2185291 IBM SAXENA03 15.05.2023
    //   # Added code for Consolidation of Test Script objects

    //BC UPGRADE KAPOOV01 >>
    // 1. Added two new fields - "Suite Name" , "Document Reference No." created under HEI.02 
    // 2. Created new procedure Initialize2 defined under HEI.02
    // 3. Created function- GetNextNo-this is a local standard function defined in standard table & is used in function- Initialize2 so need to define here
    // 4. Changed field ID of field- "Suite Name" from 18 to 50001
    // 5. Changed field ID of field- "Document Reference No." from 19 to 50002  
    //BC UPGRADE KAPOOV01 <<

    fields
    {
        //BC UPGRADE KAPOOV01 Added two new fields created under HEI.02 >>

        // BC Upgrade KAPOOV01 Changed field ID of field- "Suite Name" from 18 to 50001  >>
        //field(18; "Suite Name"; Code[10])
        field(50001; "Suite Name FND"; Code[10])
        // BC Upgrade KAPOOV01 Changed field ID of field- "Suite Name" from 18 to 50001  <<
        {
            Caption = 'Suite Name';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }

        // BC Upgrade KAPOOV01 Changed field ID of field- "Document Reference No." from 19 to 50002  >>
        //field(19; "Document Reference No."; Text[50])
        field(50002; "Document Reference No. FND"; Text[50])
        // BC Upgrade KAPOOV01 Changed field ID of field- "Document Reference No." from 19 to 50002  <<
        {
            Caption = 'Document Reference No.';
            DataClassification = ToBeClassified;
            Description = 'HEI.02';
        }
        //BC UPGRADE KAPOOV01 Added two new fields created under HEI.02 <<
        modify("No.")
        {
            CaptionML = ENU = 'No.', FRA = 'N°';
        }
        modify("Codeunit ID")
        {
            CaptionML = ENU = 'Codeunit ID', FRA = 'ID codeunit';
        }
        modify("Function Name")
        {
            CaptionML = ENU = 'Function Name', FRA = 'Nom de fonction';
        }
        modify(Result)
        {
            CaptionML = ENU = 'Result', FRA = 'Résultat';
        }
        modify(Restore)
        {
            CaptionML = ENU = 'Restore', FRA = '&Restaurer';
        }
        modify("Error Message")
        {
            CaptionML = ENU = 'Error Message', FRA = 'Message d''erreur';
        }
        modify(File)
        {
            CaptionML = ENU = 'File', FRA = 'Fichier';
        }
        modify("Call Stack")
        {
            CaptionML = ENU = 'Call Stack', FRA = 'Pile d''appels';
        }
        modify("User ID")
        {
            CaptionML = ENU = 'User ID', FRA = 'Code utilisateur';
        }
        modify("Start Time")
        {
            CaptionML = ENU = 'Start Time', FRA = 'Heure début';
        }
    }
    //BC UPGRADE KAPOOV01 Created new procedure Initialize2 defined under HEI.02 >>
    procedure Initialize2(TestRunNo: Integer; CodeunitId: Integer; FunctionName: Text[128]; StartTime: DateTime; SuiteName: Code[10]; DocRefNo: Text[50]): Boolean;
    begin
        //>>HEI.02
        INIT;
        "No." := GetNextNo;
        "Test Run No." := TestRunNo;
        VALIDATE("Codeunit ID", CodeunitId);
        "Function Name" := FunctionName;
        "Start Time" := StartTime;
        "User ID" := USERID;
        Result := Result::Incomplete;
        Platform := Platform::ServiceTier;
        "Suite Name FND" := SuiteName;
        "Document Reference No. FND" := DocRefNo;
        INSERT;
        //<<HEI.02
    end;
    //BC UPGRADE KAPOOV01 Created new procedure Initialize2 defined under HEI.02 <<


    //BC UPGRADE KAPOOV01 Added function- GetNextNo-this is a local standard function defined in standard table & is used in function- Initialize2 so need to define here >>
    local procedure GetNextNo(): Integer;
    var
        //BC UPGRADE KAPOOV01 replaced Custom Object with ID- 50230 with Standard Object -130405 ("CAL Test Result") >>
        //CALTestResult: Record "50230";
        CALTestResult: Record "CAL Test Result";
    //BC UPGRADE KAPOOV01 replaced Custom Object with ID- 50230 with Standard Object -130405 ("CAL Test Result") <<
    begin
        IF CALTestResult.FINDLAST THEN
            EXIT(CALTestResult."No." + 1);
        EXIT(1);
    end;
    //BC UPGRADE KAPOOV01 Added function- GetNextNo-this is a local standard function defined in standard table & is used in function- Initialize2 so need to define here <<

}

