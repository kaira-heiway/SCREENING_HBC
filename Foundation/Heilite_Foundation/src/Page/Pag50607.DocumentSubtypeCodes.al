page 50607 "Document Subtype Codes"
{

    // BC Upgrade BHANDS01 >> 2 Mar 2026 => Created Page

    CaptionML = ENU = 'Document Subtype Codes',
                FRA = 'Codes sous-type document';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Document Subtype Code FND";

    layout
    {
        area(content)
        {
            repeater(Control1100710001)
            {
                field("Report Selection Type"; Rec."Report Selection Type")
                {
                    Editable = RepSelectTypeEditable;
                    Visible = RepSelectTypeEditable;
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Posted Invoice Nos."; Rec."Posted Invoice Nos.")
                {
                }
                field("Posted CM. Nos."; Rec."Posted CM. Nos.")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        RepSelectTypeEditable := (Rec.GETFILTER(Rec."Report Selection Type") = '');
    end;

    var
        RepSelectTypeEditable: Boolean;
}

