page 51110 "NAV BC Field Mapping CBN"
{
    ApplicationArea = All;
    Caption = 'NAV BC Field Mapping';
    PageType = List;
    SourceTable = "NAV BC Field Mapping FND";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                Caption = 'Filter';
                ShowCaption = false;

                field(FilterTableID; FilterTableID)
                {
                    ApplicationArea = All;
                    Caption = 'Filter by NAV Table ID';
                    ToolTip = 'Enter a NAV Table ID to filter the list. Leave blank to show all records.';

                    trigger OnValidate()
                    begin
                        if FilterTableID <> 0 then
                            Rec.SetRange("NAV Table ID", FilterTableID)
                        else
                            Rec.SetRange("NAV Table ID");

                        CurrPage.Update(false);
                    end;
                }
            }

            repeater(General)
            {
                field("NAV Table ID"; Rec."NAV Table ID")
                {
                    ApplicationArea = All;
                }
                field("NAV Table Name"; Rec."NAV Table Name")
                {
                    ApplicationArea = All;
                }
                field("NAV Field ID"; Rec."NAV Field ID")
                {
                    ApplicationArea = All;
                }
                field("NAV Field Name"; Rec."NAV Field Name")
                {
                    ApplicationArea = All;
                }
                field("BC Table ID"; Rec."BC Table ID")
                {
                    ApplicationArea = All;
                }
                field("BC Table Name"; Rec."BC Table Name")
                {
                    ApplicationArea = All;
                }
                field("BC Field ID"; Rec."BC Field ID")
                {
                    ApplicationArea = All;
                }
                field("BC Field Name"; Rec."BC Field Name")
                {
                    ApplicationArea = All;
                }
                field("Previous BC Table ID"; Rec."Previous BC Table ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Previous BC Field ID"; Rec."Previous BC Field ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Modified By"; ModifiedByUser)
                {
                    ApplicationArea = All;
                    Caption = 'Modified By';
                    Editable = false;
                }
                field(SystemModifiedAtDate; DT2Date(Rec.SystemModifiedAt))
                {
                    ApplicationArea = All;
                    Caption = 'Modified At Date';
                    Editable = false;
                }
                field(SystemModifiedAtTime; DT2Time(Rec.SystemModifiedAt))
                {
                    ApplicationArea = All;
                    Caption = 'Modified At Time';
                    Editable = false;
                }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(DeleteMapping)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Delete Mapping';
    //             Image = Delete;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             ToolTip = 'Deletes the selected mapping.';

    //             trigger OnAction()
    //             begin
    //                 if not Confirm(ConfirmDeleteLbl, false) then
    //                     exit;

    //                 if not Confirm(ConfirmImpactLbl, false) then
    //                     exit;

    //                 Rec.Delete(true);

    //                 Message('The mapping has been deleted.');

    //                 CurrPage.Update(false);
    //             end;
    //         }
    //     }
    // }

    var
        ModifiedByUser: Code[50];
        FilterTableID: Integer;
        IsEditable: Boolean;
        ConfirmDeleteLbl: Label 'Do you want to delete this mapping?';
        ConfirmImpactLbl: Label 'Do you really want to delete this mapping? This can impact the mapping area.';


    trigger OnAfterGetRecord()
    var
        UserRec: Record User;
    begin
        Clear(ModifiedByUser);

        if UserRec.Get(Rec.SystemModifiedBy) then
            ModifiedByUser := UserRec."User Name";
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        // if not Confirm(ConfirmDeleteLbl, false) then
        //     exit(false);

        if not Confirm(ConfirmImpactLbl, false) then
            exit(false);

        Rec.Delete(true);

        exit(false);
    end;


    
}
