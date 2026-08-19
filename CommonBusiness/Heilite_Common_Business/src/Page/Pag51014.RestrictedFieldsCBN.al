page 51014 "Restricted Fields CBN"
{
    // version OSFS16.1

    // HEI.01 FDD-HNK-HeiliteBASE-OTCGAP015a IBM ISYED01 11/07/2017
    //   #Added new feild to page Restricted fileds

    DelayedInsert = true;
    PageType = List;
    SourceTable = "Restricted Field FND";
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
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.';
                }
                field("Field ID"; Rec."Field ID")
                {
                    ToolTip = 'Specifies the value of the Field ID field.';

                    trigger OnLookup(var Text: Text): Boolean;
                    var
                        "Field": Record "Field";
                        FieldsLookup: Page "Fields Lookup";
                    begin
                        Field.SETRANGE(TableNo, Rec."Table ID");
                        FieldsLookup.SETTABLEVIEW(Field);
                        FieldsLookup.LOOKUPMODE(true);
                        if FieldsLookup.RUNMODAL() = ACTION::LookupOK then begin
                            FieldsLookup.GETRECORD(Field);
                            Rec."Field ID" := Field."No.";
                        end;
                    end;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ActionGroup1000000006)
            {
                CaptionML = ESM = '&C. trabajo',
                            FRC = 'Ate&lier',
                            ENC = 'Wor&k Ctr.';
                Image = WorkCenter;
                action("User Access")
                {
                    Caption = 'User Access';
                    Image = UserSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Rest Field User Access CBN";
                    RunPageLink = "Table ID" = FIELD("Table ID"),
                                  "Field ID" = FIELD("Field ID");
                    PromotedOnly = true;
                    RunPageView = sorting("Table ID", "Field ID", Type)
                                  order(ascending);
                    ToolTip = 'Executes the User Access action.';
                }
            }
        }
    }
}

