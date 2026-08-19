page 50141 "Project List"
{
    // version HEI.01

    // HEI.01 FDD-BA-PRDGAP01 IBM POSTOI01 12.07.2018
    //   # object created
    // 
    // HEI.02 FDD-BA-PRDGAP01 b IBM Isyed01 27-09-2018
    //   #Added new function getfilter

    PageType = List;
    SourceTable = "Project FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetSelectionFilter(): Text;
    var
        Bin: Record Bin;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        RecRefProject: RecordRef;  // BC Upgrade NANDIS03
    begin
        //HEI.02>>
        CurrPage.SETSELECTIONFILTER(Rec);
        //exit(SelectionFilterManagement.GetSelectionFilterForProject(Rec));  // BC Upgrade NANDIS03
        exit(SelectionFilterManagement.GetSelectionFilter(RecRefProject, 1));  // BC Upgrade NANDIS03
        //HEI.02<<
    end;
}

