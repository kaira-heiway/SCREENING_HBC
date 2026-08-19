page 50706 "Standard Text Report List FND"
{
    // BC Upgrade SHUKLP03 >> Created new page for standard text report list.

    AutoSplitKey = true;
    CaptionML = ENU = 'Standard Text Report List',
                FRA = 'Liste textes standard Etats';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Standard Text Report FND";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1100083000)
            {
                field("Report ID"; Rec."Report ID")
                {
                    LookupPageID = Objects;
                }
                field("Report Name"; Rec."Report Name")
                {
                    Visible = false;
                }
                field("Position Text"; Rec."Position Text")
                {
                }
                field(Sequence; Rec.Sequence)
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
    end;
}

