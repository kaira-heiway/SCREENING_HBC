page 58009 "Outbound Interfaces"
{
    // Heilite Navision Old Id - 50165
    // version HEI.02,FM

    // HEI.01 FDD-GAPID001 IBM LAZARE02 04.07.2018 # New page for Interface Common Framework
    // HEI.02 S&OP Core interfaces IBM POSTOI01 10.04.2019
    //   # change the InsertAllowed permission on the page propertie from No->Yes

    Caption = 'Outbound Interfaces';
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "Outbound Interface INT";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Environment Code"; Rec."Environment Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Environment Code field.';
                }
                field("Legal Entity Code"; Rec."Legal Entity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Legal Entity Code field.';
                }
                field("Interface Code"; Rec."Interface Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interface Code field.';
                }
                field("Database Name"; Rec."Database Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Database Name field.';
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Name field.';
                }
                field(Endpoint; Rec.Endpoint)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Endpoint field.';
                }
                field("Endpoint 2"; Rec."Endpoint 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Endpoint 2 field.';
                }
                field("SOAP Action"; Rec."SOAP Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SOAP Action field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(Password; Rec."Password Key")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Password';
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the Password field.';

                    trigger OnValidate();
                    begin
                        Rec.SetPassword(Password);
                        COMMIT();
                    end;
                }
                //BC Upgrade VAMSIU01 - Added new field >>
                field("Password Text"; Rec."New Password Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Password field.';
                }
                //BC Upgrade VAMSIU01 - Added new field <<
                field("HeiLite Business System ID"; Rec."HeiLite Business System ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HeiLite Business System ID field.';
                }
                field("SRM Business System ID"; Rec."SRM Business System ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SRM Business System ID field.';
                }
                field("Logical System ID"; Rec."Logical System ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Logical System ID field.';
                }
            }
        }
    }

    actions
    {
    }

    var
        Password: Text;
}

