

tableextension 58039 "GLAccount_INT" extends "G/L Account"
{
    //BC Upgrade SHARMP16--- Interface changes

    fields
    {

    }
    //BC Upgrade SHARMP16 BEGIN<< InterfaceTesting
    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        IF CheckZycusEnable THEN //HEI.20
            ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account", "No.", FALSE, FALSE); //HEI.19
    end;

    trigger OnAfterModify()
    var
        myInt: Integer;
    begin
        IF CheckZycusEnable THEN //HEI.20
            UpdateLocaltimestamp; //HEI.17
    end;

    trigger OnAfterDelete()
    var
        myInt: Integer;
    begin
        IF CheckZycusEnable THEN //HEI.20
            ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account", "No.", TRUE, FALSE) //HEI.19
    end;

    trigger OnAfterRename()
    var
        myInt: Integer;
    begin
        IF CheckZycusEnable THEN //HEI.20
            ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account", "No.", FALSE, FALSE); //HEI.19
    end;

    local procedure CheckZycusEnable(): Boolean
    var
        ZycusInterfaceSetupLV: Record "Zycus Interface Setup INT";
    begin
        //HEI.20>>
        IF ZycusInterfaceSetupLV.READPERMISSION THEN BEGIN
            IF ZycusInterfaceSetupLV.GET THEN
                IF ((ZycusInterfaceSetupLV."Enabled Zycus Integration") AND (ZycusInterfaceSetupLV."Activate Account Interface")) THEN
                    EXIT(TRUE)
        END;
        EXIT(FALSE)
        //HEI.20<<
    end;

    local procedure UpdateLocaltimestamp()
    var
        myInt: Integer;
    begin
        //HEI.17>>
        IF (xRec.Name <> Rec.Name) OR (xRec.Blocked <> Rec.Blocked) OR (xRec."Direct Posting" <> Rec."Direct Posting")
          OR (xRec."C&TP CODE FND" <> Rec."C&TP CODE FND") OR (xRec."Account Type" <> Rec."Account Type") OR (xRec."Income/Balance" <> Rec."Income/Balance") THEN
            //ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account","No.",FALSE); //HEI.19
            ZycusMasterTimestamp.UpdateZycusMaterTimestamp(DATABASE::"G/L Account", "No.", FALSE, FALSE); //HEI.19
                                                                                                          //HEI.17<<

    end;

    var
        ZycusMasterTimestamp: Record "Zycus Master Timestamp FND";
    //BC Upgrade SHARMP16 END>> InterfaceTesting
}
