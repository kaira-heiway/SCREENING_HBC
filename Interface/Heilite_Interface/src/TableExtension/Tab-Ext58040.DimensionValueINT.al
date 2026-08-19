

tableextension 58040 "DimensionValue_INT" extends "Dimension Value"
{
    //BC Upgrade SHARMP16--- Interface changes

    fields
    {
        modify(Code)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.13>>
                SetLastModifiedDateTime;
                //HEI.13<<
                //HEI.15>>
                UpdateDimValueCodeZycus(FALSE);
                //HEI.15<<
            end;
        }
        modify(Name)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.13>>
                SetLastModifiedDateTime;
                //HEI.13<<
            end;
        }
        modify(Blocked)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.13>>
                SetLastModifiedDateTime;
                //HEI.13<<
            end;
        }
        modify("Approver ID FND")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                //HEI.13>>
                SetLastModifiedDateTime;
                //HEI.13<<
            end;
        }
    }
    //BC Upgrade SHARMP16 BEGIN<< InterfaceTesting
    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        SetLastModifiedDateTime;
        //HEI.15>>
        UpdateDimValueCodeZycus(FALSE);
        //HEI.15<<

    end;

    trigger OnAfterModify()
    var
        myInt: Integer;
    begin
        //HEI.13>>
        SetLastModifiedDateTime;
        //HEI.13<<
    end;

    trigger OnAfterDelete()
    var
        myInt: Integer;
    begin
        //HEI.15>>
        UpdateDimValueCodeZycus(TRUE);
        //HEI.15<<
    end;

    trigger OnAfterRename()
    var
        myInt: Integer;
    begin
        //HEI.13>>
        SetLastModifiedDateTime;
        //HEI.13<<
        //HEI.15>>
        UpdateDimValueCodeZycus(FALSE);
        //HEI.15<<
    end;

    local procedure SetLastModifiedDateTime()
    var
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        DateFilterCalcL: Codeunit "DateFilter-Calc";
        NowL: DateTime;
        UpdatedL: Boolean;
    begin
        //HEI.14>>
        IF ZycusInterfaceSetupL.GET AND ZycusInterfaceSetupL."Enabled Zycus Integration" THEN BEGIN
            IF ZycusInterfaceSetupL."Activate CCC Interface" THEN BEGIN
                IF (ZycusInterfaceSetupL."Zycus CCC Object Type" = "Dimension Code") AND (ZycusInterfaceSetupL."Zycus CCC Object Type" <> '') THEN BEGIN
                    //HEI.13>>
                    IF (Code <> xRec.Code) OR (Name <> xRec.Name) OR (Blocked <> xRec.Blocked) OR ("Approver ID FND" <> xRec."Approver ID FND") THEN BEGIN
                        //HEI.15>>
                        TESTFIELD(Code);
                        //HEI.15<<
                        NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
                        "Last DateTime Modif. Zycus FND" := NowL;
                        UpdatedL := TRUE;
                    END;
                    //HEI.13<<
                END;
            END;
            IF ZycusInterfaceSetupL."Activate Project Interface" AND NOT UpdatedL THEN BEGIN
                IF (ZycusInterfaceSetupL."Zycus Project Object Type" = "Dimension Code") AND (ZycusInterfaceSetupL."Zycus Project Object Type" <> '') THEN BEGIN
                    IF (Code <> xRec.Code) OR (Name <> xRec.Name) OR (Blocked <> xRec.Blocked) THEN BEGIN
                        //HEI.15>>
                        TESTFIELD(Code);
                        //HEI.15<<
                        NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
                        "Last DateTime Modif. Zycus FND" := NowL;
                        UpdatedL := TRUE;
                    END;
                END;
            END;
        END;
        //HEI.14<<
    end;

    local procedure UpdateDimValueCodeZycus(IsDelete: Boolean)
    var
        ZycusInterfaceSetupL: Record "Zycus Interface Setup INT";
        ZycusSpecialCharacterL: Record "Zycus Special Character INT";
        ZycusDimValueMappingL: Record "Zycus Dim Value Mapping INT";
        ValueCodeL: Code[20];
        DateFilterCalcL: Codeunit "DateFilter-Calc";
        NowL: DateTime;
    begin
        //HEI.15>>
        IF ZycusInterfaceSetupL.GET AND ZycusInterfaceSetupL."Enabled Zycus Integration" THEN BEGIN
            IF ZycusInterfaceSetupL."Activate Project Interface" THEN BEGIN
                IF (ZycusInterfaceSetupL."Zycus Project Object Type" = "Dimension Code") AND (ZycusInterfaceSetupL."Zycus Project Object Type" <> '') THEN BEGIN
                    IF IsDelete THEN BEGIN
                        ZycusDimValueMappingL.SETRANGE("Dimension Code HeiLite", "Dimension Code");
                        ZycusDimValueMappingL.SETRANGE("Dimension Value Code HeiLite", Code);
                        IF ZycusDimValueMappingL.FINDFIRST THEN BEGIN
                            ZycusDimValueMappingL.DELETE(FALSE);
                        END;
                    END ELSE BEGIN
                        IF Code <> xRec.Code THEN BEGIN
                            TESTFIELD(Code);
                            ValueCodeL := Code;
                            //Handle SPACE separately (important for BC)
                            ValueCodeL := CONVERTSTR(ValueCodeL, ' ', '_');
                            // loop through special character mappings safely
                            IF ZycusSpecialCharacterL.FINDSET() THEN BEGIN
                                REPEAT
                                    IF (ZycusSpecialCharacterL."Zycus Restricted Special Char" <> '') AND
                                       (ZycusSpecialCharacterL."Replaced by Char" <> '') AND
                                       (STRLEN(ZycusSpecialCharacterL."Zycus Restricted Special Char") =
                                        STRLEN(ZycusSpecialCharacterL."Replaced by Char")) THEN BEGIN

                                        ValueCodeL := CONVERTSTR(
                                            ValueCodeL,
                                            ZycusSpecialCharacterL."Zycus Restricted Special Char",
                                            ZycusSpecialCharacterL."Replaced by Char");
                                    END;
                                UNTIL ZycusSpecialCharacterL.NEXT = 0;
                            END;
                            IF ValueCodeL <> Code THEN BEGIN
                                ZycusDimValueMappingL.SETRANGE("Dimension Code HeiLite", "Dimension Code");
                                ZycusDimValueMappingL.SETRANGE("Dimension Value Code HeiLite", Code);
                                IF NOT ZycusDimValueMappingL.FINDFIRST THEN BEGIN
                                    ZycusDimValueMappingL.INIT;
                                    ZycusDimValueMappingL."Dimension Code HeiLite" := "Dimension Code";
                                    ZycusDimValueMappingL."Dimension Value Code HeiLite" := Code;
                                    ZycusDimValueMappingL."Dimension Value Code Zycus" := ValueCodeL;
                                    ZycusDimValueMappingL.INSERT(TRUE);
                                END ELSE BEGIN
                                    ZycusDimValueMappingL."Dimension Value Code Zycus" := ValueCodeL;
                                    ZycusDimValueMappingL.MODIFY(TRUE);
                                END;
                                "Updated Special Char Zycus FND" := TRUE;
                            END ELSE BEGIN
                                "Updated Special Char Zycus FND" := FALSE;
                            END;
                            NowL := DateFilterCalcL.ConvertToUtcDateTime(CURRENTDATETIME);
                            "Last DateTime Modif. Zycus FND":= NowL;
                        END;
                    END;
                END;
            END;
        END;
        //HEI.15<<

    end;

    var
        ZycusMasterTimestamp: Record "Zycus Master Timestamp FND";
    //BC Upgrade SHARMP16 END>> InterfaceTesting
}
