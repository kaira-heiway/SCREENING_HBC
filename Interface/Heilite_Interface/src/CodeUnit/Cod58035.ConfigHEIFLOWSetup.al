codeunit 58035 ConfigHEIFLOWSetup
{
    // version HEI.01

    // HEI.01 CHG2132748 IBM SAXENA03 09.11.2021
    //   # HeiLite Base integration with HeiFlow  Master Data
    //   # Created a new CodeUnit to configure all setups related to HEIFLOW interface

    // BC Upgrade POENAB02: Original (HeiLite) codeunit id 50203

    trigger OnRun();
    begin
        //Test
        CleanupLastModifydateMasterSetup();
        /*
        CreateInterfaceSetup('HEIFLOW-CUSTOMER');
        CreateInterfaceSetup('HEIFLOW-VENDOR');
        CreateHeiFlowSetup('HEIFLOW-CUSTOMER','HEIFLOW-VENDOR');
        CreateSourceSysIdentifier('HEIFLOW');
        //CreateWS;
        */
        Message('Setup has configured');

    end;

    var
        InterfaceSetup: Record "Interface Setup INT";
        HeiFlowSetup: Record "HeiFLOW Interface Setup INT";
        WebServices: Record "Web Service Aggregate";
        SourceSysIdentifier: Record "Source Sys Identifier API FND";

    local procedure CreateInterfaceSetup(p_InterfaceCode: Code[20]);
    begin
        if InterfaceSetup.Get(p_InterfaceCode) then
            InterfaceSetup.Delete();

        InterfaceSetup.Init();
        InterfaceSetup.Validate(Code, p_InterfaceCode);
        InterfaceSetup.Validate(Description, p_InterfaceCode);
        InterfaceSetup.Validate(Enabled, true);
        InterfaceSetup.Validate(Direction, InterfaceSetup.Direction::Inbound);
        InterfaceSetup.Validate("Call Type", InterfaceSetup."Call Type"::Synchronous);
        InterfaceSetup.Validate("Interface Type", InterfaceSetup."Interface Type"::"SAGE-Treasory");
        InterfaceSetup.Insert();
    end;

    local procedure CreateHeiFlowSetup(p_Customer: Code[20]; p_Vendor: Code[20]);
    begin
        HeiFlowSetup.DeleteAll();

        HeiFlowSetup.Init();
        HeiFlowSetup."Interface Enable/Disable" := true;
        HeiFlowSetup."HeiFLOW Customer" := p_Customer;
        HeiFlowSetup."HeiFLOW Vendor" := p_Vendor;
        HeiFlowSetup.Insert();
    end;

    local procedure CreateWS();
    begin
        WebServices.Reset();
        WebServices.SetCurrentKey("Object Type", "Service Name");
        WebServices.SetRange("Object Type", WebServices."Object Type"::Codeunit);
        WebServices.SetRange("Object ID", 50202);
        if WebServices.FindSet() then
            WebServices.Delete();

        WebServices.Init();
        WebServices.Validate("Object Type", WebServices."Object Type"::Codeunit);
        WebServices.Validate("Service Name", 'HeiFlowInterfaceWS');
        WebServices.Validate("Object ID", 50202);
        WebServices.Validate("All Tenants", true);
        WebServices.Validate(Published, true);
        WebServices.Insert();
    end;

    local procedure CreateSourceSysIdentifier(p_InterfaceCode: Code[20]);
    begin
        if SourceSysIdentifier.Get(p_InterfaceCode) then
            SourceSysIdentifier.Delete();

        SourceSysIdentifier.Init();
        SourceSysIdentifier.Validate(Code, p_InterfaceCode);
        SourceSysIdentifier.Validate(Description, p_InterfaceCode);
        SourceSysIdentifier.Insert();
    end;

    local procedure CleanupLastModifydateMasterSetup();
    var
        HeiFlowSetup: Record "HeiFLOW Interface Setup INT";
    begin
        if HeiFlowSetup.Get() then begin
            HeiFlowSetup."Last Modified Customer" := 0D;
            HeiFlowSetup."Last Modified Vendor" := 0D;
            HeiFlowSetup.Modify();
            //MESSAGE('MODIFIED');
        end;
    end;
}

