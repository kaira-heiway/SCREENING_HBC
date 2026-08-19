page 58145 "Integration Framework Log"
{
    // version HEI.03

    // HEI.01 CHG2084921 IBM KUMARN15 29.10.2020
    //   # New page created
    // HEI.02 FDD-HB1281 - CHG2056937 IBM NASTAA02 12.04.2021 # B2B Pricing Interface
    //   # New Page Actions created "ShowResponse", "Resend XML"
    // HEI.03 HB2427 - CHG2121928 IBM NASTAA02 21.01.2022 # B2B Invoice API
    //   # New Field added: "Source No."
    // BC Upgrade KUMARR78 >>
    //
    // Page Name  : Integration Framework Log
    // Page ID    : 50440
    //
    // 1. Added Business Central visibility property.
    //    Old:
    //         - ApplicationArea not mandatory in NAV.
    //    New:
    //         - ApplicationArea = All added at page level.
    //         - Ensures page visibility and search compliance in BC.
    //
    // 2. Replaced legacy NAV table ID with named object reference.
    //    Old:
    //         - SourceTable = 50200;
    //    New:
    //         - SourceTable = "Integration Framework Log";
    //         - Removed dependency on numeric object ID.
    //         - SaaS safe and upgrade compliant.
    //
    // 3. Verified repeater field structure for BC compliance.
    //    Old:
    //         - Fields without explicit ApplicationArea (NAV allowed).
    //    New:
    //         - Page-level ApplicationArea = All applied.
    //         - Fields validated against BC compiler standards.
    //         - No unsupported properties used.
    //         - Structure compatible with BC AL.
    //
    // 4. Ensured proper AL method invocation syntax.
    //    Old:
    //         - Rec.ShowRequest;
    //         - Rec.ShowResponse;
    //         - Rec.ShowError;
    //         - Rec.SendMessage;
    //    New:
    //         - Rec.ShowRequest();
    //         - Rec.ShowResponse();
    //         - Rec.ShowError();
    //         - Rec.SendMessage();
    //         - Ensures correct AL execution pattern.
    //
    // 5. Validated BLOB handling using CalcFields.
    //    Old:
    //         - Implicit BLOB access (NAV behavior).
    //    New:
    //         - Rec.CalcFields("Response File");
    //         - Ensures proper BLOB loading before HasValue check.
    //         - BC SaaS compliant data access pattern.
    //
    // 6. Added conditional validation before resend logic.
    //    Old:
    //         - Direct resend logic.
    //    New:
    //         - if Rec."Response File".HasValue and
    //              (Rec.Status <> Rec.Status::Processed) then
    //                Rec.SendMessage();
    //         - Prevents resending already processed entries.
    //         - Improves functional control and stability.
    //
    // 7. Maintained pragma suppression for AA0218.
    //    Old:
    //         - Implicit behavior without suppression.
    //    New:
    //         - #pragma warning disable/restore AA0218 retained.
    //         - Prevents upgrade warnings for legacy table design.
    //
    // BC Upgrade KUMARR78 <<

    Caption = 'Integration Framework Log';
    ApplicationArea = All; //BC UPGRADE KUMARR78 Adding ApplicationArea.
    UsageCategory = Lists; // BC Upgrade SHUKLP03 <<
    Editable = false;
    PageType = List;
    // SourceTable = 50200;//BC UPGRADE KUMARR78 Blocking OLD NAV Table ID.
    SourceTable = "Integration Framework Log INT";//BC UPGRADE KUMARR78 Replacing 50200 ID with Latest Record Object.


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
#pragma warning disable AA0218
                field("Entry No"; Rec."Entry No")

                {
                }
                field("Interface Code"; Rec."Interface Code")
                {
                }
                field("Request Sync. Date/Time"; Rec."Request Sync. Date/Time")
                {
                }
                field("Response Date/Time"; Rec."Response Date/Time")
                {
                }
                field("Source No."; Rec."Source No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Display Error"; Rec."Display Error")
                {
                }
#pragma warning restore AA0218
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ShowRequest)
            {
                Caption = 'Show Request Message';
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Rec.ShowRequest();
                end;
            }
            action(ShowResponse)
            {
                Caption = 'Show Response Message';
                Description = 'HEI.02';
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    //HEI.02>>
                    Rec.ShowResponse();
                    //HEI.02<<
                end;
            }
            action(ShowError)
            {
                Caption = 'Show Technical Error Message';
                Image = Error;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Rec.ShowError();
                end;
            }
            action(ResendXML)
            {
                Caption = 'Resend XML';
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    //HEI.02>>
                    Rec.CalcFields("Response File");

                    if Rec."Response File".HasValue and (Rec.Status <> Rec.Status::Processed) then
                        Rec.SendMessage();
                    //HEI.02<<
                end;
            }
        }
    }
}

