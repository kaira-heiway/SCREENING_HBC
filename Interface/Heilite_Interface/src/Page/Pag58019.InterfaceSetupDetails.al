page 58019 "Interface Setup Details"
{
    // Heilite Navision Old Id - 50254

    // version FM

    // HEI.01 S&OP FuturMaster Interfaces IBM POSTOI01
    //   # created object
    // HEI.02 S&OP FuturMaster Interfaces IBM POSTOI01
    //   # modify page property RefreshOnActivate = Yes

    Caption = 'Interface Setup Details';
    PageType = Card;
    RefreshOnActivate = true;
    SaveValues = false;
    SourceTable = "Interface Setup INT";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Enabled field.';
                }
                field(Direction; Rec.Direction)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Direction field.';
                }
                field("Call Type"; Rec."Call Type")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Call Type field.';
                }
            }
            group(Recurrence)
            {
                Caption = 'Recurrence';
                field("Run Type"; Rec."Run Type")
                {
                    ApplicationArea = All;
                    OptionCaption = 'Automatic,Customized';
                    ToolTip = 'Specifies the value of the Run Type field.';

                    trigger OnValidate();
                    begin
                        ShowRunTypeFields(Rec."Run Type");
                    end;
                }
                field("Run on Mondays"; Rec."Run on Mondays")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the Run on Mondays field.';
                }
                field("Run on Tuesdays"; Rec."Run on Tuesdays")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the Run on Tuesdays field.';
                }
                field("Run on Wednesdays"; Rec."Run on Wednesdays")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the Run on Wednesdays field.';
                }
                field("Run on Thursdays"; Rec."Run on Thursdays")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the Run on Thursdays field.';
                }
                field("Run on Fridays"; Rec."Run on Fridays")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the Run on Fridays field.';
                }
                field("Run on Saturdays"; Rec."Run on Saturdays")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the Run on Saturdays field.';
                }
                field("Run on Sundays"; Rec."Run on Sundays")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the Run on Sundays field.';
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the Starting Time field.';
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the Ending Time field.';
                }
                field("No. of Minutes between Runs"; Rec."No. of Minutes between Runs")
                {
                    ApplicationArea = All;
                    Editable = EditRunTypeFields;
                    ToolTip = 'Specifies the value of the No. of Minutes between Runs field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin
        ShowRunTypeFields(Rec."Run Type");
    end;

    trigger OnModifyRecord(): Boolean;
    var
        FMInterface: Boolean;
        RecRef: RecordRef;
        FldRef: FieldRef;
        i: Integer;
    begin
    end;

    var
        EditRunTypeFields: Boolean;
        InterfaceSetup: Record "Interface Setup INT";
        Error011: Label 'Interface %1, %2 is Enabled and cannot be modified';

    local procedure ShowRunTypeFields(RunType: Option Automatic,Manual);
    begin
        if RunType = RunType::Automatic then
            EditRunTypeFields := false
        else
            EditRunTypeFields := true;
    end;
}

