page 58093 "General Interface OpCo Setup"
{
    // version HEI.06,ESKER

    // HEI.01 FDD_Rwanda_Bralirwa_Esker_ Interface_V0.3_HT75 IBM POSTOI01 21.09.2018
    //   # show 2 new fields : ID 25 Business Type Dimension Code and 26 Movement Type Dimension Code
    //   # new group Dimensions
    // HEI.02 CHG2022396 Esker Ethiopia IBM POSTOI01 17.07.2019
    //   # show field 27 LC Dimension Code
    // HEI.03 CHG2143354 IBM POENAB02 20.01.2022 Export G/L Entries - Tax audit - Extraction stuck
    //   # New field: 28 Server Name
    // HEI.04 CHG2127496 SHOIVAS05 IBM 08.02.2022
    //   # show field: 29 - "Path for payment file"
    // HEI.05 CHG2157342 HB2809 IBM NANDIS01 25.07.2022 - Email notifications of Open Po's sent to Requestors
    //   # New field shown in tab "Send POS by email to Requesters" - field id - 31 - "CC id for PO Send Email"
    // HEI.06 CHG2180515 HB3249 IBM NANDIS01 12.12.2022 - Send Email Reminder to Requesters
    //   # New field "PO Doc. Subtype excluded" shown

    // BC Upgrade SHUKLP03 >> Nav Page Id - 50168

    PageType = Card;
    SourceTable = "OPCO Setup FND";
    ApplicationArea = All; // BC Upgrade SHULP03 <<
    UsageCategory = Administration; // BC Upgrade SHULP03 <<

    layout
    {
        area(content)
        {
            group("Pepperi Interface")
            {
                field("Sales Date Formula"; Rec."Sales Date Formula")
                {
                    ApplicationArea = All; // BC Upgrade SHULP03 <<                    
                    ToolTip = 'Specifies the value of the Sales Date Formula field.';

                }
                field("Delivery Date Formula"; Rec."Delivery Date Formula")
                {
                    ApplicationArea = All; // BC Upgrade SHULP03 <<                    
                    ToolTip = 'Specifies the value of the Delivery Date Formula field.';

                }
            }
            group(Dimensions)
            {
                Caption = 'Dimensions';
                field("Business Type Dimension Code"; Rec."Business Type Dimension Code")
                {
                    ApplicationArea = All; // BC Upgrade SHULP03 <<                    
                    ToolTip = 'Specifies the value of the Business Type Dimension Code field.';

                }
                field("Movement Type Dimension Code"; Rec."Movement Type Dimension Code")
                {
                    ApplicationArea = All; // BC Upgrade SHULP03 <<                    
                    ToolTip = 'Specifies the value of the Movement Type Dimension Code field.';

                }
                field("LC Dimension Code"; Rec."LC Dimension Code")
                {
                    ApplicationArea = All; // BC Upgrade SHULP03 <<                    
                    ToolTip = 'Specifies the value of the LC Dimension Code field.';

                }
            }
            group("Server Information")
            {
                Caption = 'Server Information';
                field("Server Name"; Rec."Server Name")
                {
                    ApplicationArea = All; // BC Upgrade SHULP03 <<                    
                    ToolTip = 'Specifies the value of the Server Name field.';

                }
                field("Path for payment file"; Rec."Path for payment file")
                {
                    ApplicationArea = All; // BC Upgrade SHULP03 <<                    
                    ToolTip = 'Specifies the value of the Path for payment file field.';

                }
            }
            group("Send POS by email to Requesters")
            {
                Caption = 'Send POS by email to Requesters';
                field("CC id for PO Send Email"; Rec."CC id for PO Send Email")
                {
                    ApplicationArea = All; // BC Upgrade SHULP03 <<                    
                    ToolTip = 'Specifies the value of the CC id for PO Send Email field.';

                }
                field("PO Doc. Subtype excluded"; Rec."PO Doc. Subtype excluded")
                {
                    ApplicationArea = All; // BC Upgrade SHULP03 <<                    
                    ToolTip = 'Specifies the value of the PO Doc. Subtype excluded field.';

                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.RESET();
        //if not Rec.GET then begin  // BC Upgrade SHUKLP03 << Blocked HEI code because not working properly.
        if Rec."Primary Key" <> '' then begin // BC Upgrade SHUKLP03 <<
            Rec.INIT();
            Rec.INSERT();
        end;
    end;
}

