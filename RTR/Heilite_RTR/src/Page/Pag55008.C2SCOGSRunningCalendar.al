page 55008 "C2S/COGS Running Calendar"
{
    // version HEI.03

    // HEI.01 CHG2141694 BULIMC01 IBM 13/04/2022#new page created to setup the automatic running f C2S
    // HEI.02 CHG2132673 BULIMC01 IBM 26/04/2022#COGS Allocation
    //     #page name changed to "C2S/COGS Running Calendar"
    //     #new field added - "COGS Job Queue Run"
    // HEI.03 CHG2162842 IBM SAMANR01 20/06/202022 #C2S optimazation & archiving
    //   # New field added: "Automatic Run Archive Date"

    // BC Upgrade POENAB02: Original (HeiLite) page id 50509

    Caption = 'Running Calendar';
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "C2S/COGS Running Calendar FND";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date that the accounting period will begin.',
                                FRA = 'Indique la date début de la période comptable.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the name of the accounting period.',
                                FRA = 'Spécifie le nom de la période comptable.';
                }
                field("Ending Date"; Rec."Ending Date")
                {
                }
                field("Automatic Run Pre-Close Date"; Rec."Automatic Run Pre-Close Date")
                {
                }
                field("Automatic Run Close Date"; Rec."Automatic Run Close Date")
                {
                }
                field("Manual Run Date"; Rec."Manual Run Date")
                {
                }
                field("C2S Job Queue Run"; Rec."C2S Job Queue Run")
                {
                }
                field("COGS Job Queue Run"; Rec."COGS Job Queue Run")
                {
                }
                field("Automatic Run Archive Date"; Rec."Automatic Run Archive Date")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        InsertAccPeriods;
    end;

    local procedure InsertAccPeriods();
    var
        AccountingPeriod: Record "Accounting Period";
        WhseSetup: Record "Warehouse Setup";
        C2SRunningCalendar: Record "C2S/COGS Running Calendar FND";
        CalendarMgt: Codeunit "Calendar Management";
        PreClosedWorkingDay: Date;
        ClosedWorkingDay: Date;
        DecPeriodTxt: Label 'December';
        DecemberDateTxt: Text;
        AdditionalDaysDec: Date;
        DecDays: Integer;
    begin
        WhseSetup.Get();

        // BC Upgrade POENAB02 >>
        // Code commented as part of BC Upgrade changes
        // CalendarMgt.CalcNextWorkingDate is dependent on Aptean Calendar functionality
        /* 
        AccountingPeriod.Reset();
        if AccountingPeriod.FindSet() then
            repeat
                C2SRunningCalendar.Reset();
                if not C2SRunningCalendar.Get(AccountingPeriod."Starting Date") then begin
                    C2SRunningCalendar.Init();
                    C2SRunningCalendar."Starting Date" := AccountingPeriod."Starting Date";
                    C2SRunningCalendar.Name := AccountingPeriod.Name;
                    C2SRunningCalendar."Ending Date" := CalcDate('<CM>', AccountingPeriod."Starting Date");
                    if C2SRunningCalendar.Name = DecPeriodTxt then begin
                        C2SRunningCalendar."Automatic Run Pre-Close Date" := CalendarMgt.CalcNextWorkingDate(WhseSetup."Job Q. Run Pre-Close Date Dec.", C2SRunningCalendar."Ending Date", WhseSetup."C2S Base Calendar Code");
                        C2SRunningCalendar."Automatic Run Close Date" := CalendarMgt.CalcNextWorkingDate(WhseSetup."Job Queue Run Close Date Dec.", C2SRunningCalendar."Ending Date", WhseSetup."C2S Base Calendar Code");
                    end else begin
                        C2SRunningCalendar."Automatic Run Pre-Close Date" := CalendarMgt.CalcNextWorkingDate(WhseSetup."Job Queue Run Pre-Close Date", C2SRunningCalendar."Ending Date", WhseSetup."C2S Base Calendar Code");
                        C2SRunningCalendar."Automatic Run Close Date" := CalendarMgt.CalcNextWorkingDate(WhseSetup."Job Queue Run Close Date", C2SRunningCalendar."Ending Date", WhseSetup."C2S Base Calendar Code");
                    end;
                    C2SRunningCalendar.Insert();
                end;
            until AccountingPeriod.Next() = 0; 
        */
        // BC Upgrade POENAB02 <<
    end;
}

