table 50158 "Global No. Series FND"
{
    // version HEI.01

    // HEI.01 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # Table created
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # Table created

    DataPerCompany = false;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Default Nos."; Boolean)
        {

            trigger OnValidate();
            begin
                if ("Default Nos." = false) and (xRec."Default Nos." <> "Default Nos.") and ("Manual Nos." = false) then
                    VALIDATE("Manual Nos.", true);
            end;
        }
        field(4; "Manual Nos."; Boolean)
        {

            trigger OnValidate();
            begin
                if ("Manual Nos." = false) and (xRec."Manual Nos." <> "Manual Nos.") and ("Default Nos." = false) then
                    VALIDATE("Default Nos.", true);
            end;
        }
        field(5; "Date Order"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        GlobalNoSeriesLine.SETRANGE("Series Code", Code);
        GlobalNoSeriesLine.DELETEALL();
    end;

    var
        GlobalNoSeriesLine: Record "Global No. Series Line FND";

    procedure DrillDown();
    var
        GlobalNoSeriesLine: Record "Global No. Series Line FND";
    begin
        FindNoSeriesLineToShow(GlobalNoSeriesLine);
        if GlobalNoSeriesLine.FIND('-') then;
        GlobalNoSeriesLine.SETRANGE("Starting Date");
        GlobalNoSeriesLine.SETRANGE(Open);
        PAGE.RUNMODAL(0, GlobalNoSeriesLine);
    end;

    procedure UpdateLine(var StartDate: Date; var StartNo: Code[20]; var EndNo: Code[20]; var LastNoUsed: Code[20]; var WarningNo: Code[20]; var IncrementByNo: Integer; var LastDateUsed: Date);
    var
        GlobalNoSeriesLine: Record "Global No. Series Line FND";
    begin
        FindNoSeriesLineToShow(GlobalNoSeriesLine);
        if not GlobalNoSeriesLine.FIND('-') then
            GlobalNoSeriesLine.INIT();
        StartDate := GlobalNoSeriesLine."Starting Date";
        StartNo := GlobalNoSeriesLine."Starting No.";
        EndNo := GlobalNoSeriesLine."Ending No.";
        LastNoUsed := GlobalNoSeriesLine."Last No. Used";
        WarningNo := GlobalNoSeriesLine."Warning No.";
        IncrementByNo := GlobalNoSeriesLine."Increment-by No.";
        LastDateUsed := GlobalNoSeriesLine."Last Date Used"
    end;

    local procedure FindNoSeriesLineToShow(var GlobalNoSeriesLine: Record "Global No. Series Line FND");
    var
        GlobalNoSeriesManagement: Codeunit GlobalNoSeriesManagement;
    begin
        GlobalNoSeriesManagement.SetGlobalNoSeriesLineFilter(GlobalNoSeriesLine, Code, 0D);

        if GlobalNoSeriesLine.FINDLAST() then
            exit;

        GlobalNoSeriesLine.RESET();
        GlobalNoSeriesLine.SETRANGE("Series Code", Code);
    end;
}

