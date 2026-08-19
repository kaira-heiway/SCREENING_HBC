page 58033 "EDI Interface Setup"
{
    // Heilite Navision Old Id - 50357
    // HEI.01 CHG2026335 HT653 FDD_La Reunion_EDI_EDI Order IBM GAVANM01 04.10.2019 - #new page

    PageType = Card;
    SourceTable = "EDI Interface Setup INT";
    ApplicationArea = ALl;  // BC Upgrade NANDIS03
    UsageCategory = Administration;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group("EDI Interface")
            {
                field("SO/SRO Interface Request"; Rec."SO/SRO Interface Request")
                {
                    ToolTip = 'Specifies the value of the SO/SRO Interface Request field.';
                }
                field("Error email address"; Rec."Error email address")
                {
                    ToolTip = 'Specifies the value of the Error email address field.';
                }
                field("Error email subject"; rec."Error email subject")
                {
                    ToolTip = 'Specifies the value of the Error email subject field.';
                }
                field("Accounting group filter"; Rec."Accounting group filter")
                {
                    ToolTip = 'Specifies the value of the Accounting group filter field.';

                    //trigger OnLookup(Text : Text) : Boolean;  // BC Upgrade NANDIS03
                    trigger OnLookup(var Text: Text): Boolean;  // BC Upgrade NANDIS03
                    begin
                        CLEAR(AccountGroupList);
                        AccountGroupList.LOOKUPMODE(true);
                        if not (AccountGroupList.RUNMODAL() = ACTION::LookupOK) then
                            exit(false);

                        Text := AccountGroupList.GetSelectionFilter();
                        exit(true);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        AccountGroupList: Page "Account Group List";
}

