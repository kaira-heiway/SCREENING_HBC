pageextension 54021 ProdBOMVersionList extends "Prod. BOM Version List"
{
    // version NAVW110.0
    //     HEI.01 RFC-CHG0257267 IBM.AB 15.10.2018
    //   # New field Active created
    //   # Code added to mandate Active at least one version
    // HEI.02 FDD_HB1029 BULIMC01 IBM 07.07.2020# new action added:"Change Status"
    //**************************************************************************************
    //BC UPGRADE PATHAA02 23.01.26
    //# Onqueryclosepageevent added in DTW Ext-CU

    Editable = false;

    layout
    {
        addlast(Control1)
        {
            field(Active; Rec."Active FND")
            {
                Caption = 'Active';
                ApplicationArea = All;
                ToolTip = 'Specifies whether this production BOM version is Active.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action("Change Status")
            {
                CaptionML = ENU = 'Change Status', FRA = 'Co&mmentaires';
                Image = Change;
                ApplicationArea = Manufacturing;

                trigger OnAction()
                var
                    ConfirmDialogBomVersions: Page "Confirm Dialog BomVersions";
                    ProdBomVersPage: Page "Change Status BOM Versions";
                    LocationCode: Code[20];
                    StatusFilter: Text;
                begin
                    ConfirmDialogBomVersions.LookupMode(true);

                    if ConfirmDialogBomVersions.RunModal() = Action::Yes then begin
                        LocationCode := ConfirmDialogBomVersions.ReturnLocationCode();
                        StatusFilter := ConfirmDialogBomVersions.ReturnStatus();

                        ProdBomVersPage.GetFilters(StatusFilter, LocationCode);
                        ProdBomVersPage.LookupMode(true);
                        ProdBomVersPage.RunModal();
                    end;
                end;
            }
        }
    }
}