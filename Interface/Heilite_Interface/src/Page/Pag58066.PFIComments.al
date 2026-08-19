page 58066 "PFI Comments"
{
    // Heilite Navision Old Id - 50462

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 08.07.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface


    // BC Upgrade MISHRS14 >>
    // Changed table name to "PFI Approval FND" as its moved from Interface to Foundation Layer.
    // BC Upgrade MISHRS14 <<

    // BC Upgrade PATELP08>>
    // Changed name of table from "PFI Comments" to "PFI Comments FND"
    // BC Upgrade PATELP08<<


    PageType = List;
    SourceTable = "PFI Comments FND";
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("PFI Document No"; Rec."PFI Document No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the PFI Document No field.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage();
    begin
        //HEI.01>>
        grec_PFIApproval.RESET();
        grec_PFIApproval.SETRANGE("PFI document No.", rec."PFI Document No");
        if grec_PFIApproval.FINDLAST() then begin
            grec_PFIComments.RESET();
            grec_PFIComments.SETRANGE("PFI Document No", grec_PFIApproval."PFI document No.");
            if grec_PFIComments.FINDFIRST() then begin
                grec_PFIApproval.Comments := grec_PFIComments.Comments;
                grec_PFIApproval.MODIFY();
            end;
        end;
        //HEI.01<<
    end;

    var
        // BC Upgrade MISHRS14 >>
        // Added FND and blocked same declaration
        grec_PFIApproval: Record "PFI Approval FND";
        grec_PFIComments: Record "PFI Comments FND";

        // grec_PFIApproval: Record "PFI Approval";
        // grec_PFIComments: Record "PFI Comments FND";
        // BC Upgrade MISHRS14 <<


    procedure GetParameter(PFINo: Code[10]; PFILineNo: Integer);
    begin
        //HEI.01>>
        rec."PFI Document No" := PFINo;
        rec."Line No" := PFILineNo;
        //HEI.01<<
    end;
}

