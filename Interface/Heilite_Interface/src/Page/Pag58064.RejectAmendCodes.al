page 58064 "Reject Amend Codes"
{
    // Heilite Navision Old Id - 50460

    // version HEI.01

    // HEI.01 FDD-HB2174 CHG2104952 IBM NANDIS01 06.07.2021 Ibecor - PO API
    //   # New Page created for Ibecor PFI Interface

    // BC UPGRADE PATELS08 >>
    // # Table name changed from "Reject Amend Codes" to "Reject Amend Codes FND".
    // BC UPGRADE PATELS08 <<


    ApplicationArea = All;
    PageType = List;
    SourceTable = "Reject Amend Codes FND";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetSelected(var RejectAmendCodes: Record "Reject Amend Codes FND");
    begin
        //HEI.01>>
        CurrPage.SETSELECTIONFILTER(RejectAmendCodes);
        //HEI.01<<
    end;
}

