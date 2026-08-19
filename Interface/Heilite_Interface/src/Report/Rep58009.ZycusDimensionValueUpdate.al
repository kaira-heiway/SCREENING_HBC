report 58009 "Zycus Dimension Value Update"
{
    // version HEI.02

    // HEI.01 CHG2210794 SAHAL01 04.04.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Report: 50610 - Zycus Dimension Value Update
    //   # Added Code
    // HEI.02 CHG2307002 SAHAL01 13.06.2025 Include Additional Alphabetical Special Characters for Zycus
    //   # Commented and Added Code

    //Bc Upgrade YADAVM09 Report property changes.

    Caption = 'Zycus Dimension Value Update';
    ProcessingOnly = true;
    ApplicationArea = All;//BC Upgrade YADAVM09<<
    UsageCategory = ReportsAndAnalysis;//BC Upgrade YADAVM09<<

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = SORTING("Dimension Code", Code) ORDER(Ascending) WHERE("Dimension Code" = CONST('CONCAT'), Code = FILTER(<> ''));

            trigger OnAfterGetRecord();
            var
                ValueCodeL: Code[20];
                ZycusSpecialCharacterL: Record "Zycus Special Character INT";
                ZycusDimValueMappingL: Record "Zycus Dim Value Mapping INT";
            begin
                //HEI.01>>
                TESTFIELD("Dimension Code", ZycusInterfaceSetup."Zycus Project Object Type");
                TESTFIELD(Code);
                ValueCodeL := Code;
                if ZycusSpecialCharacterL.FINDSET(false) then begin
                    repeat
                        ValueCodeL := CONVERTSTR(ValueCodeL, ZycusSpecialCharacterL."Zycus Restricted Special Char", ZycusSpecialCharacterL."Replaced by Char");
                    until ZycusSpecialCharacterL.NEXT = 0;
                end;
                if ValueCodeL <> Code then begin
                    ZycusDimValueMappingL.SETRANGE("Dimension Code HeiLite", "Dimension Code");
                    ZycusDimValueMappingL.SETRANGE("Dimension Value Code HeiLite", Code);
                    if not ZycusDimValueMappingL.FINDFIRST then begin
                        ZycusDimValueMappingL.INIT;
                        ZycusDimValueMappingL."Dimension Code HeiLite" := "Dimension Code";
                        ZycusDimValueMappingL."Dimension Value Code HeiLite" := Code;
                        ZycusDimValueMappingL."Dimension Value Code Zycus" := ValueCodeL;
                        ZycusDimValueMappingL.INSERT(true);
                        ValueUpdate += 1;
                    end else begin
                        //HEI.02>>
                        if not ZycusDimValueMappingL.Locked then begin
                            //HEI.02<<
                            if ZycusDimValueMappingL."Dimension Value Code Zycus" <> ValueCodeL then begin
                                ZycusDimValueMappingL."Dimension Value Code Zycus" := ValueCodeL;
                                ZycusDimValueMappingL.MODIFY(true);
                                ValueUpdate += 1;
                            end;
                            //HEI.02>>
                        end;
                        //HEI.02<<
                    end;
                    "Updated Special Char Zycus FND" := true;
                    MODIFY(false);
                end else begin
                    if "Updated Special Char Zycus FND" then begin
                        "Updated Special Char Zycus FND" := false;
                        MODIFY(false);
                    end;
                end;
                //HEI.02>>
                if GUIALLOWED then begin
                    RecNo += 1;
                    Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                end;
                //HEI.02<<
                //HEI.01<<
            end;

            trigger OnPreDataItem();
            var
                ZycusSpecialCharacterL: Record "Zycus Special Character INT";
            begin
                //HEI.01>>
                //HEI.02>>
                //IF DimValueCode <> '' THEN
                //  SETFILTER(Code,DimValueCode)
                //ELSE BEGIN
                //  IF ZycusSpecialCharacterL.FINDSET(FALSE,FALSE) THEN BEGIN
                //    REPEAT
                //      SpecialCharFilter += Text000 + ZycusSpecialCharacterL."Zycus Restricted Special Char" + Text000 + Text001;
                //    UNTIL ZycusSpecialCharacterL.NEXT = 0;
                //    SpecialCharFilter := DELCHR(SpecialCharFilter,'>',Text001);
                //    SETFILTER(Code,SpecialCharFilter);
                //  END;
                //END;
                if GUIALLOWED then begin
                    TotalRecNo := COUNT;
                end;
                //HEI.02<<
                //HEI.01<<
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                //Caption = 'Options'; //Bc Upgrade YADAVM09<<
                group(Options)
                {
                    field("Dim. Value Code"; DimValueCode)
                    {
                        TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CONCAT'));
                        ApplicationArea = All;//Bc Upgrade YADAVM09<<
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            //HEI.01>>
            CLEAR(ZycusInterfaceSetup);
            CLEAR(DimValueCode);
            CLEAR(Allowed);
            CLEAR(ValueUpdate);
            CLEAR(SpecialCharFilter);
            //HEI.01<<
        end;
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        //HEI.01>>
        if GUIALLOWED then begin
            //HEI.02>>
            Window.CLOSE;
            //HEI.02<<
            if ValueUpdate <> 0 then
                MESSAGE(Text003, ValueUpdate)
            else
                MESSAGE(Text004);
        end;
        //HEI.01<<
    end;

    trigger OnPreReport();
    begin
        //HEI.01>>
        CLEAR(Allowed);
        CLEAR(ValueUpdate);
        CLEAR(SpecialCharFilter);
        //HEI.02>>
        CLEAR(TotalRecNo);
        CLEAR(RecNo);
        //HEI.02<<
        if ZycusInterfaceSetup.GET and ZycusInterfaceSetup."Enabled Zycus Integration" then
            if ZycusInterfaceSetup."Activate Project Interface" and (ZycusInterfaceSetup."Zycus Project Object Type" <> '') then
                Allowed := true;
        if not Allowed then
            ERROR(Text005, ZycusInterfaceSetup.TABLECAPTION);
        //HEI.02>>
        if GUIALLOWED then begin
            Window.OPEN(Text008 + '@1@@@@@@@@@@@@@@@@@@@@@\');
        end;
        //HEI.02<<
        //HEI.01<<
    end;

    var
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        Allowed: Boolean;
        DimValueCode: Code[250];
        Text000: Label '*';
        Text001: Label '|';
        Text003: Label 'Total %1 Dim. Value Code updated on Zycus Special Character.';
        Text004: Label 'No Dim. Value Code found to update on Zycus Special Character.';
        ValueUpdate: Integer;
        SpecialCharFilter: Text[1024];
        Text005: Label 'You cannot execute this report as it is not activated the Project Interface in %1.';
        Window: Dialog;
        Text008: Label 'Inprogress...\';
        TotalRecNo: Integer;
        RecNo: Integer;
}

