page 58079 "Cadency Running Calendar"
{
    // Heilite Navision Old Id - 50655

    // version HEI.02

    // HEI.01 CHG2262655 SAHAL01 05.12.2024 Automatic data export for control purposes
    //   # Created New Page: 50655 - Cadency Running Calendar
    //   # Created New Function - CalculateAccountingPeriods
    //   # Added New Action - Calculate Cadency Accounting Periods
    // HEI.02 CHG2311415 KAPOOV01 21.07.2025 Automatic data export for control purposes schedule change
    //   # Modified Fields Name - Working Day-2 (Auto run date) ->JQ first run (Auto run date)
    //                          - Working Day-6 (Auto run date) -> JQ second run (Auto run date)
    //                          - Working Day-2 (E-Mail Sent)-> First Auto run (E-Mail Sent)
    //                          - Working Day-6 (E-Mail Sent)-> Second Auto run (E-Mail Sent)

    // BC Upgrade PATELP08>>
    // Changed name of table from "Cadency Running Calendar" to "Cadency Running Calendar FND"
    // BC Upgrade PATELP08<<

    Caption = 'Cadency Running Calendar';
    PageType = List;
    SourceTable = "Cadency Running Calendar FND";
    ApplicationArea = All; // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ToolTip = 'Specifies the value of the Ending Date field.';
                }
                field("Month Name"; Rec."Month Name")
                {
                    ToolTip = 'Specifies the value of the Month Name field.';
                }
                field("Cadency Base Calendar Code"; Rec."Cadency Base Calendar Code")
                {
                    ToolTip = 'Specifies the value of the Cadency Base Calendar Code field.';
                }
                field("Working Day-2 (Auto Run Date)"; Rec."Working Day-2 (Auto Run Date)")
                {
                    Caption = 'JQ first run (Auto run date)';
                    ToolTip = 'Specifies the value of the JQ first run (Auto run date) field.';
                }
                field("Working Day-6 (Auto Run Date)"; Rec."Working Day-6 (Auto Run Date)")
                {
                    Caption = 'JQ second run (Auto run date)';
                    ToolTip = 'Specifies the value of the JQ second run (Auto run date) field.';
                }
                field("Working Day-2 (E-Mail Sent)"; Rec."Working Day-2 (E-Mail Sent)")
                {
                    Caption = 'First Auto run (E-Mail Sent)';
                    ToolTip = 'Specifies the value of the First Auto run (E-Mail Sent) field.';
                }
                field("Working Day-6 (E-Mail Sent)"; Rec."Working Day-6 (E-Mail Sent)")
                {
                    Caption = 'Second Auto run (E-Mail Sent)';
                    ToolTip = 'Specifies the value of the Second Auto run (E-Mail Sent) field.';
                }
                field("Manual Run Date"; Rec."Manual Run Date")
                {
                    ToolTip = 'Specifies the value of the Manual Run Date field.';
                }
                field("Additional Run Date"; Rec."Additional Run Date")
                {
                    ToolTip = 'Specifies the value of the Additional Run Date field.';
                }
                field("Manual Run Date (E-Mail Sent)"; Rec."Manual Run Date (E-Mail Sent)")
                {
                    ToolTip = 'Specifies the value of the Manual Run Date (E-Mail Sent) field.';
                }
                field("Addnl. Run Date (E-Mail Sent)"; Rec."Addnl. Run Date (E-Mail Sent)")
                {
                    ToolTip = 'Specifies the value of the Additional Run Date (E-Mail Sent) field.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field("Last Time Modified"; Rec."Last Time Modified")
                {
                    ToolTip = 'Specifies the value of the Last Time Modified field.';
                }
                field("Last Modified By User"; Rec."Last Modified By User")
                {
                    ToolTip = 'Specifies the value of the Last Modified By User field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CalculateCadencyAccPeriods)
            {
                Caption = 'Calculate Cadency Accounting Periods';
                Image = CalculateCalendar;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the Calculate Cadency Accounting Periods action.';

                trigger OnAction();
                begin
                    //HEI.01>>
                    CalculateAccountingPeriods();
                    //HEI.01<<
                end;
            }
        }
    }

    local procedure CalculateAccountingPeriods();
    var
        TrintechInterfaceSetupL: Record "Trintech Interface Setup INT";
        AccountingPeriodL: Record "Accounting Period";
        CadencyRunningCalendarL: Record "Cadency Running Calendar FND";
        CalendarMgtL: Codeunit "Calendar Management";
    begin
        //HEI.01>>
        TrintechInterfaceSetupL.GET();
        TrintechInterfaceSetupL.TESTFIELD("Cadency Base Calendar Code");
        TrintechInterfaceSetupL.TESTFIELD("JQ Run Date for Working Day-2");
        TrintechInterfaceSetupL.TESTFIELD("JQ Run Date for Working Day-6");
        if AccountingPeriodL.findset(false) then begin
            repeat
                CadencyRunningCalendarL.RESET();
                if not CadencyRunningCalendarL.GET(AccountingPeriodL."Starting Date") then begin
                    CadencyRunningCalendarL.INIT();
                    CadencyRunningCalendarL."Starting Date" := AccountingPeriodL."Starting Date";
                    CadencyRunningCalendarL."Ending Date" := CALCDATE('<CM>', AccountingPeriodL."Starting Date");
                    CadencyRunningCalendarL."Month Name" := AccountingPeriodL.Name;
                    CadencyRunningCalendarL."Cadency Base Calendar Code" := TrintechInterfaceSetupL."Cadency Base Calendar Code";
                    // CadencyRunningCalendarL."Working Day-2 (Auto Run Date)" := CalendarMgtL.CalcNextWorkingDate(TrintechInterfaceSetupL."JQ Run Date for Working Day-2", (CadencyRunningCalendarL."Starting Date" - 1), TrintechInterfaceSetupL."Cadency Base Calendar Code");  // BC Upgrade NANDIS03 - Blocked for time being
                    // CadencyRunningCalendarL."Working Day-6 (Auto Run Date)" := CalendarMgtL.CalcNextWorkingDate(TrintechInterfaceSetupL."JQ Run Date for Working Day-6", (CadencyRunningCalendarL."Starting Date" - 1), TrintechInterfaceSetupL."Cadency Base Calendar Code");  // BC Upgrade NANDIS03 - Blocked for time being
                    CadencyRunningCalendarL.INSERT(true);
                end;
            until AccountingPeriodL.NEXT() = 0;
        end;
        //HEI.01<<
    end;
}

