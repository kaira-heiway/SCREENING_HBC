page 54035 "Change Status BOM Versions"
{
    // HEI.01 FDD_HB1029 BULIMC01 IBM 08.07.2020#new page created to change the following fields: Status,Active
    //#Page ID-50423, BC UPGRADE PATHAA02 23.01.26

    Caption = 'Change Status BOM Versions';
    Editable = true;
    PageType = List;
    SourceTable = "Production BOM Version";
    ApplicationArea = ALL; //BC UPGRADE PATHAA02 23.01.26
    usagecategory = Lists; //BC UPGRADE PATHAA02 23.01.26

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    Editable = false;
                }
                field("Version Code"; Rec."Version Code")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field(Active; Rec."Active FND")
                {
                    Editable = false;
                }
                field("Certify Status"; Rec."Certify Status FND")
                {
                    CaptionML = ENU = 'To be Certified';
                    Editable = DisableCertified;
                    Enabled = DisableCertified;

                    trigger OnValidate();
                    begin
                        ValidateNewCertifiedStatus();
                    end;
                }
                field("New Active"; Rec."New Active FND")
                {
                    CaptionML = ENU = 'To be Active';
                    Editable = ActiveEditable;
                    Enabled = ActiveEditable;

                    trigger OnValidate();
                    begin
                        ValidateActiveField();
                    end;
                }
                field("Close Status"; Rec."Close Status FND")
                {
                    CaptionML = ENU = 'To be Closed';
                    Editable = CloseEditable;
                    Enabled = CloseEditable;

                    trigger OnValidate();
                    begin
                        ValidateNewClosedStatus();
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin
        ValidateNewCertifiedStatus();
        UpdateEditableVariables();
    end;

    trigger OnAfterGetRecord();
    begin
        ValidateNewCertifiedStatus();
        UpdateEditableVariables();
    end;

    trigger OnOpenPage();
    begin
        DisableCertified := true;
        ActiveEditable := true;
        CloseEditable := true;

        if StatusFilter = 'Certified' then begin
            Rec.SETRANGE(Status, Rec.Status::Certified);
            DisableCertified := false;
        end;

        if StatusFilter = 'New' then
            Rec.SETRANGE(Status, Rec.Status::New);
        if StatusFilter = 'Under Development' then
            Rec.SETRANGE(Status, Rec.Status::"Under Development");

        if Rec.FINDFIRST() then
            repeat
                if Rec.Status <> Rec.Status::Certified then
                    Rec."Certify Status FND" := true
                else
                    Rec."Certify Status FND" := false;
                Rec."New Active FND" := false;
                Rec."Close Status FND" := false;
                Rec.MODIFY();
                ProductionBOMHeader.SETRANGE("No.", Rec."Production BOM No.");
                if ProductionBOMHeader.FINDFIRST() then begin
                    if LocationCodeFilter <> '' then
                        Rec.MARK((ProductionBOMHeader.Status = ProductionBOMHeader.Status::Certified) and (LocationCodeFilter = ProductionBOMHeader."Linked SKU FND"))
                    else
                        Rec.MARK(ProductionBOMHeader.Status = ProductionBOMHeader.Status::Certified);
                end;
            until Rec.NEXT = 0;

        Rec.MARKEDONLY(true);
        if Rec.FINDFIRST() then;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if CloseAction = ACTION::LookupOK then begin
            if CONFIRM(Text001) then begin
                if Rec.FINDSET() then
                    repeat
                        if Rec."Certify Status FND" then begin
                            Rec.VALIDATE(Status, Rec.Status::Certified);
                            Rec.MODIFY();
                            StatusChanged := true;
                        end;
                        if Rec."New Active FND" then begin
                            ProductionBOMVersion.RESET();
                            ProductionBOMVersion.SETRANGE("Production BOM No.", Rec."Production BOM No.");
                            ProductionBOMVersion.SETRANGE("Active FND", true);
                            if ProductionBOMVersion.FINDFIRST() then begin
                                ProductionBOMVersion.VALIDATE("Active FND", false);
                                ProductionBOMVersion.MODIFY();
                            end;
                            Rec.VALIDATE("Active FND", true);
                            ActiveChanged := true;
                        end;
                        if Rec."Close Status FND" then begin
                            Rec.VALIDATE(Status, Rec.Status::Closed);
                            StatusChanged := true;
                            Rec.MODIFY();
                        end;
                        Rec."New Active FND" := false;
                        if Rec.Status <> Rec.Status::Certified then
                            Rec."Certify Status FND" := true;
                        Rec.MODIFY;
                    until Rec.NEXT = 0;
            end;
        end else if CONFIRM('There are unsaved changes on the page. Do you want to leave the page?') then
                exit(true)
        else
            exit(false);

        if StatusChanged or ActiveChanged then
            MESSAGE(Text002);
    end;

    var
        Window: Dialog;
        StatusFilter: Text;
        DisableCertified: Boolean;
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMVersion: Record "Production BOM Version";
        LocationCodeFilter: Code[10];
        StatusChanged: Boolean;
        ActiveChanged: Boolean;
        Text001: Label 'Do you want to update these BOM Versions?';
        Text002: Label 'Changes successfully saved.';
        Text003: Label 'Active field has been changed.';
        Text004: Label 'Production BOM No. %1 Version Code %2 is already set to be closed. The status will be changed to Certified.';
        Text005: Label 'Only Certified BOM Versions can be made Active! Please disable "To be Closed" tick for %1 %2.';
        Text006: Label 'Only Certified BOM Versions can be made Active! Please enable "To be Certified" tick for %1 %2.';
        Text007: Label 'Production BOM No. %1 Version Code %2 is already active.';
        Text008: Label 'Production BOM No. %1 Version Code %2 is already set to be certified.The status will be made Closed.';
        //Text009: Label 'You are not allowed to close Production BOM No. %1 Version Code %2 because it is an active version.Status must be equal to Certified".';
        Text010: Label 'You are not allowed to close Production BOM No. %1 Version Code %2 because this version will be made active. Status must be equal to "Certified".';
        ActiveEditable: Boolean;
        CloseEditable: Boolean;

    procedure GetFilters(NewStatus: Text; NewLocationCode: Code[10]);
    begin
        StatusFilter := NewStatus;
        LocationCodeFilter := NewLocationCode;
    end;

    local procedure ValidateNewCertifiedStatus();
    begin
        if Rec.Status <> Rec.Status::Certified then begin
            if Rec."Certify Status FND" then begin
                ActiveEditable := true;
                Rec."Close Status FND" := false;
            end else begin
                Rec."New Active FND" := false;
                ActiveEditable := false;
            end;
        end;
        Rec.MODIFY();
    end;

    local procedure ValidateActiveField();
    begin
        if Rec."New Active FND" then begin
            ModifyOtherActiveFields();
            Rec."Close Status FND" := false;
            Rec.MODIFY();
        end else
            ModifyClosedStatusForActiveVersions();
    end;

    local procedure ValidateNewClosedStatus();
    begin
        if (Rec."Close Status FND") then
            if Rec.Status <> Rec.Status::Certified then begin
                Rec."New Active FND" := false;
                ActiveEditable := false;
                Rec."Certify Status FND" := false;
            end else begin
                Rec."New Active FND" := false;
                ModifyClosedStatusForActiveVersions();
            end;
        Rec.MODIFY();
    end;

    local procedure ModifyClosedStatusForActiveVersions();
    begin
        if Rec.Status = Rec.Status::Certified then begin
            ProductionBOMVersion.RESET();
            ProductionBOMVersion.SETRANGE("Production BOM No.", Rec."Production BOM No.");
            ProductionBOMVersion.SETRANGE(Status, Rec.Status);
            ProductionBOMVersion.SETRANGE("Active FND", true);
            if ProductionBOMVersion.FINDFIRST() then begin
                ProductionBOMVersion."Close Status FND" := false;
                ProductionBOMVersion.MODIFY();
            end;
        end;
    end;

    local procedure ModifyOtherActiveFields();
    begin
        ProductionBOMVersion.RESET();
        ProductionBOMVersion.SETRANGE("Production BOM No.", Rec."Production BOM No.");
        ProductionBOMVersion.SETRANGE(Status, Rec.Status);
        if ProductionBOMVersion.FINDSET() then
            repeat
                ProductionBOMVersion."New Active FND" := false;
                ProductionBOMVersion.MODIFY();
            until ProductionBOMVersion.NEXT() = 0;
    end;

    local procedure UpdateEditableVariables();
    begin
        if Rec.Status = Rec.Status::Certified then begin
            if Rec."Active FND" then begin
                ActiveEditable := false;
                ProductionBOMVersion.RESET();
                ProductionBOMVersion.SETRANGE("Production BOM No.", Rec."Production BOM No.");
                ProductionBOMVersion.SETRANGE(Status, Rec.Status);
                ProductionBOMVersion.SETRANGE("New Active FND", true);
                if ProductionBOMVersion.FINDFIRST() then
                    CloseEditable := true
                else
                    CloseEditable := false;
            end else begin
                ActiveEditable := true;
                CloseEditable := true;
            end;
        end else if Rec.Status <> Rec.Status::Certified then begin
            if Rec."Certify Status FND" then
                ActiveEditable := true
            else
                ActiveEditable := false;
        end;
    end;
}

