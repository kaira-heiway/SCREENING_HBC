page 58025 "Trintech Interface Setup"
{
    // Heilite Navision Old Id - 50314
    // version HEI.03

    // HEI.01 FDD-RTRGAP073 BRD HB142- Trintech connection , IBM.NAIKH01 , 25.02.2019
    //   # Created new Page
    // HEI.02 CHG2262655 SAHAL01 29.11.2024 Automatic data export for control purposes
    //   # Added New Fields - Cadency Base Calendar Code
    //                      - JQ Run Date for Working Day-2
    //                      - JQ Run Date for Working Day-6
    //                      - Last GLBAL Completion Date
    //                      - Last GLTRAN Completion Date
    //                      - Last SLBAL Completion Date
    //                      - Last Date Modified
    //                      - Last Time Modified
    //                      - Last Modified By User
    //                      - Enabled E-Mail Notification
    //                      - Max No. of Records for GLBAL
    //                      - Max No. of Records for GLTRAN
    //                      - Max No. of Records for SLBAL
    //                      - E-Mail List 1
    //                      - E-Mail List 2
    //                      - E-Mail List 3
    //                      - E-Mail List 4
    //   # Added New Action - Cadency Running Calendar
    // HEI.03 CHG2311415 KAPOOV01 21.07.2025 Automatic data export for control purposes schedule change
    //   # Modified Fields Name - JQ Run Date for Working Day-2  -> JQ Run Date First Run
    //                          - JQ Run Date for Working Day-6  -> JQ Run Date Second Run

    Caption = 'Trintech Interface Setup';
    PageType = Card;
    SourceTable = "Trintech Interface Setup INT";
    ApplicationArea = All; // BC Upgrade NANDIS03
    UsageCategory = Lists;  // BC Upgrade NANDIS03

    layout
    {
        area(content)
        {
            group(General)
            {
                field(GLBAL; Rec.GLBAL)
                {
                    ToolTip = 'Specifies the value of the GLBAL field.';
                }
                field(GLTRAN; Rec.GLTRAN)
                {
                    ToolTip = 'Specifies the value of the GLTRAN field.';
                }
                field(SLBAL; Rec.SLBAL)
                {
                    ToolTip = 'Specifies the value of the SLBAL field.';
                }
                field("Cadency Base Calendar Code"; Rec."Cadency Base Calendar Code")
                {
                    ToolTip = 'Specifies the value of the Cadency Base Calendar Code field.';
                }
                field("JQ Run Date for Working Day-2"; Rec."JQ Run Date for Working Day-2")
                {
                    Caption = 'JQ Run Date First Run';
                    ToolTip = 'Specifies the value of the JQ Run Date First Run field.';
                }
                field("JQ Run Date for Working Day-6"; Rec."JQ Run Date for Working Day-6")
                {
                    Caption = 'JQ Run Date Second Run';
                    ToolTip = 'Specifies the value of the JQ Run Date Second Run field.';
                }
                field("Last GLBAL Completion Date"; Rec."Last GLBAL Completion Date")
                {
                    ToolTip = 'Specifies the value of the Last GLBAL Completion Date field.';
                }
                field("Last GLTRAN Completion Date"; Rec."Last GLTRAN Completion Date")
                {
                    ToolTip = 'Specifies the value of the Last GLTRAN Completion Date field.';
                }
                field("Last SLBAL Completion Date"; Rec."Last SLBAL Completion Date")
                {
                    ToolTip = 'Specifies the value of the Last SLBAL Completion Date field.';
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
            group("E-Mail Notification")
            {
                field("Enabled E-Mail Notification"; Rec."Enabled E-Mail Notification")
                {
                    ToolTip = 'Specifies the value of the Enabled E-Mail Notification field.';
                }
                field("Max No. of Records for GLBAL"; Rec."Max No. of Records for GLBAL")
                {
                    ToolTip = 'Specifies the value of the Max No. of Records for GLBAL field.';
                }
                field("Max No. of Records for GLTRAN"; Rec."Max No. of Records for GLTRAN")
                {
                    ToolTip = 'Specifies the value of the Max No. of Records for GLTRAN field.';
                }
                field("Max No. of Records for SLBAL"; Rec."Max No. of Records for SLBAL")
                {
                    ToolTip = 'Specifies the value of the Max No. of Records for SLBAL field.';
                }
                field("E-Mail List 1"; Rec."E-Mail List 1")
                {
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the E-Mail List 1 field.';
                }
                field("E-Mail List 2"; Rec."E-Mail List 2")
                {
                    ToolTip = 'Specifies the value of the E-Mail List 2 field.';
                }
                field("E-Mail List 3"; Rec."E-Mail List 3")
                {
                    ToolTip = 'Specifies the value of the E-Mail List 3 field.';
                }
                field("E-Mail List 4"; Rec."E-Mail List 4")
                {
                    ToolTip = 'Specifies the value of the E-Mail List 4 field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cadency Running Calendar")
            {
                Caption = 'Cadency Running Calendar';
                Image = Calendar;
                Promoted = true;
                RunObject = Page "Cadency Running Calendar";
                ToolTip = 'Executes the Cadency Running Calendar action.';
            }
        }
    }
}

