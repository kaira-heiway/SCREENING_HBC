page 51078 "KS SalesPerson Export CBN"
{

    // BC UPGRADE PATELP08 >>
    //    # Added application area and usage category
    //    # in fields added Rec. before field name as per new syntax change in BC upgrade
    // BC UPGRADE PATELP08 <<

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Salesperson/Purchaser";

    // BC UPGRADE PATELP08 >> added application area and usage category
    ApplicationArea = All;
    UsageCategory = Lists;
    // BC UPGRADE PATELP08 <<

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                // BC UPGRADE PATELP08 >> added Rec. before field name
                field("Code"; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(sysmodified; ConvertDate(TODAY))
                {
                }
                // BC UPGRADE PATELP08 <<
            }
        }
    }

    actions
    {
    }

    var
        SysModified: Date;

    local procedure ConvertDate(SysModified: Date): Text;
    var
        ReturnDate: Text;
    begin
        ReturnDate := FORMAT(SysModified, 0, '<Year4>-<Month,2>-<Day,2>') + 'T00:' + '00:00.000+00:00';
        exit(ReturnDate);
    end;
}

