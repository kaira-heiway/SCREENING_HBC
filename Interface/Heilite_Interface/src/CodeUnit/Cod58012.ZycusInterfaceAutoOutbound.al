codeunit 58012 "Zycus Interface Auto Outbound"
{
    // Heilite Navision Old Id - 50212

    // version HEI.04,HEI.01

    // HEI.01 CHG2210794 SAHAL01 03.09.2024 Zycus - BASE HL Integration Master Dimension
    //   # Created New Codeunit: 50212 - Zycus Interface Auto Outbound
    //   # Created New Functions - GetZycusInterfaceSetup_Zycus
    //                           - OnScheduleCCCDimCreateOrUpdate_Zycus
    //                           - OnScheduleWBNDimCreateOrUpdate_Zycus
    //   # Removed Fixed Assets (CONCAT) Interface functionality due to descope
    //   # Added Code
    // HEI.02 CHG2210794 MAJUMS03 22.01.2024 Zycus - BASE HL Integration Master vendor and GL Account (*RLPPD)
    //   # Created New Functions - OnScheduleVendorCreateOrUpdate_Zycus
    //                           - OnScheduleGLCreateOrUpdate_Zycus
    //   # Code Added.
    // HEI.03 CHG2210794 MAJUMS03 06.06.2024 Zycus - BASE HL Integration - CMG Rule Map.
    //   # Created New Functions - OnScheduleGLRuleMapCCCCreateOrUpdate_Zycus
    //   # Code Added.
    // HEI.04 CHG2278614 SHARMP16 06.03.2025 E2E test for Zycus HL integration - G/L Rule map- Development finetuning
    //   # Comment code -OnRun Functions - Code commented because this interface is now out of scope.


    trigger OnRun();
    var
        DimensionL: Record Dimension;
    begin
        //HEI.01>>
        GetZycusInterfaceSetup_Zycus();
        if not ZycusInterfaceSetupRead then begin
            CLEAR(ZycusInterfaceSetup);
            exit;
        end;
        if ZycusInterfaceSetup."Activate CCC Interface" then begin
            ZycusInterfaceSetup.TESTFIELD("Zycus CCC Object Type");
            DimensionL.GET(ZycusInterfaceSetup."Zycus CCC Object Type");
            OnScheduleCCCDimCreateOrUpdate_Zycus(DimensionL, false);
        end;
        if ZycusInterfaceSetup."Activate Project Interface" then begin
            ZycusInterfaceSetup.TESTFIELD("Zycus Project Object Type");
            CLEAR(DimensionL);
            DimensionL.GET(ZycusInterfaceSetup."Zycus Project Object Type");
            OnScheduleWBNDimCreateOrUpdate_Zycus(DimensionL, false);
        end;
        //HEI.01<<
        //HEI.02>>
        if ZycusInterfaceSetup."Activate Vendor Interface" then begin
            ZycusInterfaceSetup.TESTFIELD("Zycus Vendor Interface Code");
            OnScheduleVendorCreateOrUpdate_Zycus(false);
        end;
        if ZycusInterfaceSetup."Activate Account Interface" then begin
            ZycusInterfaceSetup.TESTFIELD("Zycus Account Interface Code");
            OnScheduleGLCreateOrUpdate_Zycus(false);
        end;
        //HEI.02<<
        //HEI.03>>
        //HEI.04>>
        /*IF ZycusInterfaceSetup."Activate GL Rule Map Interface" THEN BEGIN
          ZycusInterfaceSetup.TESTFIELD("Zycus GL Rule Map Interface");
          OnScheduleGLRuleMapCCCCreateOrUpdate_Zycus(FALSE);
        END;*/
        //HEI.04<<
        //HEI.03<<
        //HEI.01>>
        CLEAR(ZycusInterfaceSetup);
        CLEAR(ZycusInterfaceSetupRead);
        //HEI.01<<

    end;

    var
        ZycusInterfaceSetup: Record "Zycus Interface Setup INT";
        ZycusInterfaceSetupRead: Boolean;
        Text000: Label 'Interface ''%1'' is not enabled.';

    local procedure GetZycusInterfaceSetup_Zycus();
    begin
        //HEI.01>>
        if not ZycusInterfaceSetupRead then begin
            if ZycusInterfaceSetup.GET() and ZycusInterfaceSetup."Enabled Zycus Integration" then
                ZycusInterfaceSetupRead := true;
        end;
        //HEI.01<<
    end;

    [IntegrationEvent(false, false)]
    procedure OnScheduleCCCDimCreateOrUpdate_Zycus(var Dimension: Record Dimension; PreviewMode: Boolean);
    begin
        //HEI.01
    end;

    [IntegrationEvent(false, false)]
    procedure OnScheduleWBNDimCreateOrUpdate_Zycus(var Dimension: Record Dimension; PreviewMode: Boolean);
    begin
        //HEI.01
    end;

    [IntegrationEvent(false, false)]
    procedure OnScheduleVendorCreateOrUpdate_Zycus(PreviewMode: Boolean);
    begin
        //HEI.02
    end;

    [IntegrationEvent(false, false)]
    procedure OnScheduleGLCreateOrUpdate_Zycus(PreviewMode: Boolean);
    begin
        //HEI.02
    end;

    [IntegrationEvent(false, false)]
    procedure OnScheduleGLRuleMapCCCCreateOrUpdate_Zycus(PreviewMode: Boolean);
    begin
        //HEI.03
    end;
}

