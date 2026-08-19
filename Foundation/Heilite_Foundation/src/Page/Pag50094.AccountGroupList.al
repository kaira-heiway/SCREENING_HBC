page 50094 "Account Group List"
{
    // version HEI.02

    // HEI.01 FDD-SLSGAP001 IBM POENAB01 18.08.2017 # MDM Customer Card
    //   # Object created
    // HEI.02 RFC-CHG0264361 IBM.AB 20.12.2018
    //   # New Fields added:"Trading End Date Enable"
    // 
    // HEI.03 FDD - Indirect Customer Master IBM.NAIKH01 18.01.2019
    //   # Added New Field "Contract type Editable"
    // HEI.04 RFC-CHG2007388 IBM.KUMARN15 12.09.2019
    //   # New field added "Available for Sales Order/Return Order"
    // HEI.05 FDD-LC-HT736 IBM.GUNERE01 02.10.2019 # new function GetSelectionFilter added
    // HEI.06 FDD-HT587 IBM.BULIMC01 15/10/2019 #New boolean field added - "Customer Classification"

    Caption = 'Account Group List';
    PageType = List;
    SourceTable = "Account Group FND";
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
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Trading End Date Enable"; Rec."Trading End Date Enable")
                {
                    ToolTip = 'Specifies the value of the Trading End Date Enable field.';
                }
                field("Contract type Editable"; Rec."Contract type Editable")
                {
                    ToolTip = 'Specifies the value of the Contract type Editable field.';
                }
                field("Avail. for Sales/Return Order"; Rec."Avail. for Sales/Return Order")
                {
                    ToolTip = 'Specifies the value of the Avail. for Sales/Return Order field.';
                }
                field("Customer Classification"; Rec."Customer Classification")
                {
                    ToolTip = 'Specifies the value of the Customer Classification field.';
                }
            }
        }
    }

    actions
    {
    }

    procedure GetSelectionFilter(): Text;
    var
        AccountGroup: Record "Account Group FND";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        RecRefAccountGroup: RecordRef;  // BC Upgrade NANDIS03
    begin
        //HEI.05 >>
        CurrPage.SETSELECTIONFILTER(AccountGroup);
        //exit(SelectionFilterManagement.GetSelectionFilterForCustomerAccountGroup(AccountGroup));  // BC Upgrade NANDIS03
        exit(SelectionFilterManagement.GetSelectionFilter(RecRefAccountGroup, 1));  // BC Upgrade NANDIS03
        //HEI.05 <<
    end;
}

