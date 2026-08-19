page 50363 "Global No. Series Lines"
{
    // version HEI.01

    // HEI.01 FDD-HT817 CHG2034523 IBM GUNERE01 30.10.2019 # Page created
    // HEI.02 FDD-HT923 CHG2034529 IBM GUNERE01 30.10.2019 # Page created

    AutoSplitKey = true;
    CaptionML = ENU = 'Global No. Series Lines',
                FRA = 'Lignes souche de n°';
    DataCaptionFields = "Series Code";
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Global No. Series Line FND";
    SourceTableView = sorting("Series Code", "Starting Date", "Starting No.");
    ApplicationArea = All;  // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Series Code"; Rec."Series Code")
                {
                    ToolTipML = ENU = 'Specifies the code for the number series to which this line applies.',
                                FRA = 'Spécifie le code de la souche de numéros à laquelle cette ligne s''applique.';
                    Visible = false;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date from which you would like this line to apply.',
                                FRA = 'Spécifie la date à partir de laquelle la ligne doit être prise en considération.';
                }
                field("Starting No."; Rec."Starting No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the first number in the series.',
                                FRA = 'Spécifie le premier numéro de la souche de numéros.';
                }
                field("Ending No."; Rec."Ending No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the last number in the series.',
                                FRA = 'Spécifie le dernier numéro de la souche de numéros.';
                }
                field("Last Date Used"; Rec."Last Date Used")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the date when a number was most recently assigned from the number series.',
                                FRA = 'Spécifie la dernière date à laquelle un numéro de cette souche de numéros a été affecté.';
                }
                field("Last No. Used"; Rec."Last No. Used")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the last number that was used from the number series.',
                                FRA = 'Spécifie le dernier numéro de la souche de numéros à avoir été utilisé.';
                }
                field("Warning No."; Rec."Warning No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies when you want to receive a warning that the number series is running out.',
                                FRA = 'Spécifie lorsque vous souhaitez être prévenu que la souche de numéros arrive à sa fin.';
                }
                field("Increment-by No."; Rec."Increment-by No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies the size of the interval by which you would like to space the numbers in the number series.',
                                FRA = 'Spécifie la taille de l''intervalle qui sépare deux numéros de la souche de numéros.';
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTipML = ENU = 'Specifies whether the number series line is open. It is open until the last number in the series has been used.',
                                FRA = 'Indique si la ligne souche de numéros est ouverte ou non. Elle est ouverte tant que le dernier numéro de la souche de numéros n''a pas été utilisé.';
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

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        if GlobalNoSeriesLine.GET(Rec."Series Code", Rec."Line No.") then begin
            GlobalNoSeriesLine.SETRANGE("Series Code", Rec."Series Code");
            if GlobalNoSeriesLine.FINDLAST() then;
            Rec."Line No." := GlobalNoSeriesLine."Line No." + 10000;
        end;
        exit(true);
    end;

    var
        GlobalNoSeriesLine: Record "Global No. Series Line FND";
}

