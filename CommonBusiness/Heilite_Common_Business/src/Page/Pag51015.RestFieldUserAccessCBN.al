page 51015 "Rest Field User Access CBN"
{
    // version OSFS16.1

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP015a IBM ISYED01 12/07/2017
    //   # added lookup field for the User / Group if type selected is User
    //   # added lookup field for the user / Group if type selected is User Group

    DelayedInsert = true;
    PageType = List;
    SourceTable = "Restricted Fld User Access FND";
    ApplicationArea = ALL;  //BC Upgrade Priya <<
    UsageCategory = Lists;  //BC Upgrade Priya << 

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table ID"; Rec."Table ID")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Field ID"; Rec."Field ID")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Field ID field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("User / User Group ID"; Rec."User / User Group ID")
                {
                    ToolTip = 'Specifies the value of the User / User Group ID field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        //HEI.01>>
                        if Rec.Type = Rec.Type::User then begin
                            User.RESET();
                            if PAGE.RUNMODAL(PAGE::Users, User) = ACTION::LookupOK then
                                Rec."User / User Group ID" := User."User Name";
                        end
                        else if Rec.Type = Rec.Type::"User Group" then begin
                            SecurityGroup.RESET();
                            if PAGE.RUNMODAL(PAGE::"Security Groups", SecurityGroup) = ACTION::LookupOK then //BC Upgrade Priya<< Changed page UserGroups to SecurityGroups.
                                Rec."User / User Group ID" := SecurityGroup.Code; //BC Upgrade Priya<< Changed table UserGroup to SecurityGroup.
                        end;
                        //HEI.01<<
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        //UserGroup: Record "User Group";//BC Upgrade Priya << "User Group" table and "User Groups"page have been replaced by "Security Group Buffer" and "Security Groups" page.
        SecurityGroup: Record "Security Group Buffer";//BC Upgrade Priya << "User Group" table and "User Groups"page is replaced by "Security Group Buffer" and "Security Groups" page.
        User: Record User;

    local procedure UpdateUserID();
    begin
    end;
}

