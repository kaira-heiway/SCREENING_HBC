page 50707 "Standard Text Reports FND"
{
    // version DITW17.00.01

    // DITW15.00.00.38 DDR 29/07/2010 issue 1203 Removed trigger OnFormat() field "Report Name"
    //                                           Removed function GetReportObj()
    // DITW16.00.00.38 DDR 30/07/2010 DIT-715 #1 RTC Page functionnalities & Nav SQL performances
    // HEI.01 FDD-HT637 IBM NASTAA02 13.01.2020 # Invoice Cr Memo Proforma Inv LaReunion
    //   # Added new Field "Image"
    //   # Added Option 'Header' to PositionTextFilter

    // BC Upgrade SHUKLP03 >> Created new page for standard text reports.

    AutoSplitKey = true;
    CaptionML = ENU = 'Report Selection - Standard Text';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Standard Text Report FND";
    ApplicationArea = ALL;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                CaptionML = ENU = 'Filters',
                            FRA = 'Filtres';
                field(ReportIDFilter; ReportIDFilter)
                {
                    BlankZero = true;
                    CaptionML = ENU = 'Report ID',
                                FRA = 'ID état';
                    //Numeric = true;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        if Text = '' then
                            Text := '0';

                        Object.FILTERGROUP(2);
                        Object.SETRANGE("Object Type", Object."Object Type"::Report);
                        Object.FILTERGROUP(0);

                        Object."Object Type" := Object."Object Type"::Report;
                        EVALUATE(Object."Object ID", Text);

                        if PAGE.RUNMODAL(PAGE::Objects, Object) = ACTION::LookupOK then begin
                            Text := FORMAT(Object."Object ID");
                            exit(true);
                        end;
                    end;

                    trigger OnValidate();
                    begin
                        /// DITW15.00.00.38 DDR 29/07/2010 #1203;
                        ReportIDFilterOnAfterValidate;
                    end;
                }
                field("Report Name"; Rec."Report Name")
                {
                    DrillDown = false;
                    Editable = false;
                }
                field(PositionTextFilter; PositionTextFilter)
                {
                    CaptionML = ENU = 'Position',
                                FRA = 'Position';
                    OptionCaption = 'Line,Footer,Header,None';

                    trigger OnValidate();
                    begin
                        PositionTextFilterOnAfterValid;
                    end;
                }
            }
            repeater(Control1100083002)
            {
                field("Report ID"; Rec."Report ID")
                {
                    LookupPageID = Objects;
                }
                field(ReportName2; Rec."Report Name")
                {
                    Visible = false;
                }
                field("Position Text"; Rec."Position Text")
                {
                }
                field(Sequence; Rec.Sequence)
                {
                    Visible = false;
                }
                field(Image; Rec.Image)
                {
                }
                field("Standard Text Code"; Rec."Standard Text Code")
                {
                }
                field("Standard Text Description"; Rec."Standard Text Description")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1905767507; Notes)
            {
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&xt. Reports")
            {
                CaptionML = ENU = 'E&xt. Reports',
                            FRA = 'Etats étendus';
                action("E&xtended Texts")
                {
                    CaptionML = ENU = 'E&xtended Texts',
                                FRA = '&Textes étendus';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST("Standard Text"),
                                  "No." = FIELD("Standard Text Code");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "Text No.");
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        if BelowxRec then begin
            if (Rec.Sequence - 9900 > 0) and
               (xRec."Report ID" = Rec."Report ID") and
               (xRec."Position Text" = Rec."Position Text")
            then
                Rec.Sequence := ROUND(Rec.Sequence - 9900)
            else
                Rec.Sequence := 100;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Report ID" := xRec."Report ID";
        Rec."Position Text" := xRec."Position Text";

        if ReportIDFilter <> 0 then
            Rec."Report ID" := ReportIDFilter;
        if PositionTextFilter < PositionTextFilter::None then
            Rec."Position Text" := PositionTextFilter;
    end;

    trigger OnOpenPage();
    begin
        GetRecFilters;
        SetRecFilters;
    end;

    var
        "Object": Record AllObj;
        ReportIDFilter: Integer;
        PositionTextFilter: Option Line,Footer,Header,"None";

    procedure GetRecFilters();
    begin
        if Rec.GETFILTERS <> '' then begin
            if Rec.GETFILTER("Report ID") <> '' then
                ReportIDFilter := Rec."Report ID"
            else
                ReportIDFilter := 0;

            PositionTextFilter := PositionTextFilter::None;
        end;
    end;

    procedure SetRecFilters();
    begin
        if ReportIDFilter <> 0 then
            Rec.SETRANGE("Report ID", ReportIDFilter)
        else
            Rec.SETRANGE("Report ID");

        if PositionTextFilter <> PositionTextFilter::None then
            Rec.SETRANGE("Position Text", PositionTextFilter)
        else
            Rec.SETRANGE("Position Text");

        CurrPage.UPDATE(false);
    end;

    local procedure PositionTextFilterOnAfterValid();
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;

    local procedure ReportIDFilterOnAfterValidate();
    begin
        CurrPage.SAVERECORD;
        SetRecFilters;
    end;
}

