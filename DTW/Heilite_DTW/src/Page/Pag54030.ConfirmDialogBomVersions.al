page 54030 "Confirm Dialog BomVersions"
{
    // version HEI.01

    // HEI.01 FDD_HB1029 BULIMC01 IBM 08.07.2020#new page created

    //Bc Upgrade YADAVM09 old id was 50424

    Caption = 'Choose the Status/Location Code';
    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            field(StatusOption; StatusOption)
            {
                Caption = 'Status';
                DrillDown = true;
                ToolTip = 'to check the status of the dialog';
                ApplicationArea = all;
            }
            field(LocationCode; LocationCode)
            {
                Caption = 'Location Code';
                TableRelation = Location;
                ToolTip = 'For checking the location ';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        StatusOption: Option New,"Under Development",Certified;
        LocationCode: Code[20];

    procedure ReturnLocationCode(): Code[20];
    begin
        exit(LocationCode);
    end;

    procedure ReturnStatus(): Text;
    begin
        if StatusOption = StatusOption::New then
            exit('New');
        if StatusOption = StatusOption::Certified then
            exit('Certified');
        if StatusOption = StatusOption::"Under Development" then
            exit('Under Development');
    end;
}

